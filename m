Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A04265E87FA
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Sep 2022 05:34:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233009AbiIXDex (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 23:34:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232658AbiIXDep (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 23:34:45 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AB991A39F
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 20:34:43 -0700 (PDT)
Received: from dggpemm500020.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4MZDzS3NmFzHtd7;
        Sat, 24 Sep 2022 11:29:56 +0800 (CST)
Received: from dggpemm100009.china.huawei.com (7.185.36.113) by
 dggpemm500020.china.huawei.com (7.185.36.49) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Sat, 24 Sep 2022 11:34:40 +0800
Received: from [10.174.179.24] (10.174.179.24) by
 dggpemm100009.china.huawei.com (7.185.36.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Sat, 24 Sep 2022 11:34:39 +0800
Subject: Re: [PATCH v3] mm: hugetlb: fix UAF in hugetlb_handle_userfault
To:     Andrew Morton <akpm@linux-foundation.org>
References: <20220923042113.137273-1-liushixin2@huawei.com>
 <20220923170554.7046bb023f8cf582b5909b77@linux-foundation.org>
CC:     Liu Zixian <liuzixian4@huawei.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <songmuchun@bytedance.com>,
        "Sidhartha Kumar" <sidhartha.kumar@oracle.com>,
        John Hubbard <jhubbard@nvidia.com>,
        "David Hildenbrand" <david@redhat.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>
From:   Liu Shixin <liushixin2@huawei.com>
Message-ID: <11391501-c901-fd4d-5a05-50952aec011c@huawei.com>
Date:   Sat, 24 Sep 2022 11:34:39 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <20220923170554.7046bb023f8cf582b5909b77@linux-foundation.org>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.179.24]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemm100009.china.huawei.com (7.185.36.113)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2022/9/24 8:05, Andrew Morton wrote:
> On Fri, 23 Sep 2022 12:21:13 +0800 Liu Shixin <liushixin2@huawei.com> wrote:
>
>> The vma_lock and hugetlb_fault_mutex are dropped before handling
>> userfault and reacquire them again after handle_userfault(), but
>> reacquire the vma_lock could lead to UAF[1,2] due to the following
>> race,
...
> Patch is against mm-unstable, which isn't appropriate for a backport. 
> Could you please something against current -linus (which will be more
> backportable), then I'll figure out the fallout on mm-unstable.
>
> Thanks.
> .
I resend v4 rebased on current -linus.
Link: https://lore.kernel.org/all/20220924034905.2694686-1-liushixin2@huawei.com/

Thanks,

