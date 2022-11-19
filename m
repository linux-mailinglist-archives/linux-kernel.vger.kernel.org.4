Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC224630916
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Nov 2022 03:06:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232320AbiKSCGQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 21:06:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232536AbiKSCF4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 21:05:56 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 183B225F5
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 18:05:20 -0800 (PST)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4NDcRG5DyfzHvx0;
        Sat, 19 Nov 2022 10:04:42 +0800 (CST)
Received: from [10.174.151.185] (10.174.151.185) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Sat, 19 Nov 2022 10:05:15 +0800
Subject: Re: [PATCH] hugetlb: Fix __prep_compound_gigantic_page page flag
 setting
To:     Mike Kravetz <mike.kravetz@oracle.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>
CC:     Muchun Song <songmuchun@bytedance.com>,
        Joao Martins <joao.m.martins@oracle.com>,
        Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@suse.com>, Peter Xu <peterx@redhat.com>,
        Oscar Salvador <osalvador@suse.de>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        Vlastimil Babka <vbabka@kernel.org>,
        Sidhartha Kumar <sidhartha.kumar@oracle.com>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20221118195249.178319-1-mike.kravetz@oracle.com>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <5877406c-62bb-8330-e8dc-a5d78c6ab15a@huawei.com>
Date:   Sat, 19 Nov 2022 10:05:14 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20221118195249.178319-1-mike.kravetz@oracle.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.151.185]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/11/19 3:52, Mike Kravetz wrote:
> Commit 2b21624fc232 ("hugetlb: freeze allocated pages before creating
> hugetlb pages") changed the order page flags were cleared and set in the
> head page.  It moved the __ClearPageReserved after __SetPageHead.
> However, there is a check to make sure __ClearPageReserved is never
> done on a head page.  If CONFIG_DEBUG_VM_PGFLAGS is enabled, the
> following BUG will be hit when creating a hugetlb gigantic page:
> 
>     page dumped because: VM_BUG_ON_PAGE(1 && PageCompound(page))
>     ------------[ cut here ]------------
>     kernel BUG at include/linux/page-flags.h:500!
>     Call Trace will differ depending on whether hugetlb page is created
>     at boot time or run time.
> 
> Make sure to __ClearPageReserved BEFORE __SetPageHead.
> 
> Reported-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
> Fixes: 2b21624fc232 ("hugetlb: freeze allocated pages before creating hugetlb pages")
> Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>

Yes, PG_reserved is PF_NO_COMPOUND policy. Thanks for fixing this.

Reviewed-by: Miaohe Lin <linmiaohe@huawei.com>

Thanks,
Miaohe Lin

