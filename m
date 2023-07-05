Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3ED10747AE3
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 03:17:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230446AbjGEBRu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 21:17:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229753AbjGEBRr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 21:17:47 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59FBF10CF
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jul 2023 18:17:45 -0700 (PDT)
Received: from dggpemm500009.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4QwhZd1cZZzTm3l;
        Wed,  5 Jul 2023 09:16:41 +0800 (CST)
Received: from [10.174.179.24] (10.174.179.24) by
 dggpemm500009.china.huawei.com (7.185.36.225) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 5 Jul 2023 09:17:42 +0800
Subject: Re: [PATCH] bootmem: remove the vmemmap pages from kmemleak in
 free_bootmem_page
To:     Andrew Morton <akpm@linux-foundation.org>
References: <20230704101942.2819426-1-liushixin2@huawei.com>
 <20230704092841.2e71a21ee1149ec662c73744@linux-foundation.org>
CC:     Muchun Song <songmuchun@bytedance.com>,
        Matthew Wilcox <willy@infradead.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Oscar Salvador <osalvador@suse.de>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>
From:   Liu Shixin <liushixin2@huawei.com>
Message-ID: <b629bb16-ffcc-7e30-1f81-0677810a3369@huawei.com>
Date:   Wed, 5 Jul 2023 09:17:42 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <20230704092841.2e71a21ee1149ec662c73744@linux-foundation.org>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.179.24]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemm500009.china.huawei.com (7.185.36.225)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/7/5 0:28, Andrew Morton wrote:
> On Tue, 4 Jul 2023 18:19:42 +0800 Liu Shixin <liushixin2@huawei.com> wrote:
>
>> commit dd0ff4d12dd2 ("bootmem: remove the vmemmap pages from kmemleak in
>> put_page_bootmem") fix an overlaps existing problem of kmemleak. But the
>> problem still existed when HAVE_BOOTMEM_INFO_NODE is disabled, because in
>> this case, free_bootmem_page() will call free_reserved_page() directly.
> So I take it that with CONFIG_HAVE_BOOTMEM_INFO_NODE=n, the issue
> described in dd0ff4d12dd2 still occurs?  That kmemleak reports an error
> and stops working?
Yes, you're right.
>
> So we want a cc:stable on this fix, yes?
Yes.
>
>> Fix the problem by adding kmemleak_free_part() in free_bootmem_page()
>> when HAVE_BOOTMEM_INFO_NODE is disabled.
>>
>> Fixes: f41f2ed43ca5 ("mm: hugetlb: free the vmemmap pages associated with each HugeTLB page")
>> ...
> .
>

