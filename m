Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75AAA5E99D7
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 08:48:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233699AbiIZGsr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 02:48:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230060AbiIZGsd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 02:48:33 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 901D2252AE
        for <linux-kernel@vger.kernel.org>; Sun, 25 Sep 2022 23:48:30 -0700 (PDT)
Received: from dggpemm500021.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4MbYB66thtzHtmL;
        Mon, 26 Sep 2022 14:43:42 +0800 (CST)
Received: from dggpemm100009.china.huawei.com (7.185.36.113) by
 dggpemm500021.china.huawei.com (7.185.36.109) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 26 Sep 2022 14:48:28 +0800
Received: from [10.174.179.24] (10.174.179.24) by
 dggpemm100009.china.huawei.com (7.185.36.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 26 Sep 2022 14:48:28 +0800
Subject: Re: [PATCH v4] mm: hugetlb: fix UAF in hugetlb_handle_userfault
To:     Andrew Morton <akpm@linux-foundation.org>
References: <20220924034905.2694686-1-liushixin2@huawei.com>
 <20220925112826.c3efd2cf438d1bb6329f78ed@linux-foundation.org>
CC:     Liu Zixian <liuzixian4@huawei.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <songmuchun@bytedance.com>,
        "Sidhartha Kumar" <sidhartha.kumar@oracle.com>,
        John Hubbard <jhubbard@nvidia.com>,
        "David Hildenbrand" <david@redhat.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>
From:   Liu Shixin <liushixin2@huawei.com>
Message-ID: <174f5998-1f1d-c283-26bb-82c5a68150ab@huawei.com>
Date:   Mon, 26 Sep 2022 14:48:27 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <20220925112826.c3efd2cf438d1bb6329f78ed@linux-foundation.org>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.179.24]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemm100009.china.huawei.com (7.185.36.113)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-8.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2022/9/26 2:28, Andrew Morton wrote:
> On Sat, 24 Sep 2022 11:49:05 +0800 Liu Shixin <liushixin2@huawei.com> wrote:
>
>> The vma_lock and hugetlb_fault_mutex are dropped before handling
>> userfault and reacquire them again after handle_userfault(), but
>> reacquire the vma_lock could lead to UAF[1,2] due to the following
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
> Thanks.  Turns out that porting all the pending material on top of this
> change was not a confidence-inspiring activity.  So I ended up merging
> your v3.  Please work with Greg on the backporting when he gets on to
> it?  Hopefully that will merely involve sending him this v4.
OK, I'll do it.
> .
>

