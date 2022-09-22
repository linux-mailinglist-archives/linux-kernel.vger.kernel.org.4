Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B3C35E5850
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 03:58:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230190AbiIVB6o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 21:58:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229566AbiIVB6m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 21:58:42 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12C88A3D06
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 18:58:41 -0700 (PDT)
Received: from dggpemm500023.china.huawei.com (unknown [172.30.72.53])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4MXz0X74vszHqH1;
        Thu, 22 Sep 2022 09:56:28 +0800 (CST)
Received: from dggpemm100009.china.huawei.com (7.185.36.113) by
 dggpemm500023.china.huawei.com (7.185.36.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 22 Sep 2022 09:58:39 +0800
Received: from [10.174.179.24] (10.174.179.24) by
 dggpemm100009.china.huawei.com (7.185.36.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 22 Sep 2022 09:58:38 +0800
Subject: Re: [PATCH] mm: hugetlb: fix UAF in hugetlb_handle_userfault
To:     Andrew Morton <akpm@linux-foundation.org>
References: <20220921083440.1267903-1-liushixin2@huawei.com>
 <20220921120748.79f3255fa0a06b182576f497@linux-foundation.org>
CC:     Liu Zixian <liuzixian4@huawei.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <songmuchun@bytedance.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
From:   Liu Shixin <liushixin2@huawei.com>
Message-ID: <ced8f78a-1f86-ee63-cc48-caed243ce197@huawei.com>
Date:   Thu, 22 Sep 2022 09:58:38 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <20220921120748.79f3255fa0a06b182576f497@linux-foundation.org>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.179.24]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemm100009.china.huawei.com (7.185.36.113)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-7.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2022/9/22 3:07, Andrew Morton wrote:
> On Wed, 21 Sep 2022 16:34:40 +0800 Liu Shixin <liushixin2@huawei.com> wrote:
>
>> The vma_lock and hugetlb_fault_mutex are dropped before handling
>> userfault and reacquire them again after handle_userfault(), but
>> reacquire the vma_lock could lead to UAF[1] due to the following
>> race,
>>
>> hugetlb_fault
>>   hugetlb_no_page
>>     /*unlock vma_lock */
>>     hugetlb_handle_userfault
>>       handle_userfault
>>         /* unlock mm->mmap_lock*/
>>                                            vm_mmap_pgoff
>>                                              do_mmap
>>                                                mmap_region
>>                                                  munmap_vma_range
>>                                                    /* clean old vma */
>>         /* lock vma_lock again  <--- UAF */
>>     /* unlock vma_lock */
>>
>> Since the vma_lock will unlock immediately after hugetlb_handle_userfault(),
>> let's drop the unneeded lock and unlock in hugetlb_handle_userfault() to fix
>> the issue.
>>
>> @@ -5508,17 +5507,12 @@ static inline vm_fault_t hugetlb_handle_userfault(struct vm_area_struct *vma,
>>  
>>  	/*
>>  	 * vma_lock and hugetlb_fault_mutex must be
>> -	 * dropped before handling userfault.  Reacquire
>> -	 * after handling fault to make calling code simpler.
>> +	 * dropped before handling userfault.
>>  	 */
>>  	hugetlb_vma_unlock_read(vma);
>>  	hash = hugetlb_fault_mutex_hash(mapping, idx);
>>  	mutex_unlock(&hugetlb_fault_mutex_table[hash]);
>> -	ret = handle_userfault(&vmf, reason);
>> -	mutex_lock(&hugetlb_fault_mutex_table[hash]);
>> -	hugetlb_vma_lock_read(vma);
>> -
>> -	return ret;
>> +	return handle_userfault(&vmf, reason);
>>  }
> Current code is rather different from this.  So if the bug still exists
> in current code, please verify this and redo the patch appropriately?
>
> And hang on to this version to help with the -stable backporting.
>
> Thanks.
> .
This patch conflicts with patch series "hugetlb: Use new vma lock for huge pmd sharing synchronization".
So I reproduce the problem on next-20220920 and this patch is based on next-20220920 instead of mainline.
This problem is existed since v4.11. I will send the stable version later.

