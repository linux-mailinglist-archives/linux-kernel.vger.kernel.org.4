Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E735762D477
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 08:56:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234782AbiKQH43 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 02:56:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239408AbiKQH4Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 02:56:25 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 800B259871
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 23:56:24 -0800 (PST)
Received: from dggpemm500024.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4NCXKM1wtzzHvvp;
        Thu, 17 Nov 2022 15:55:51 +0800 (CST)
Received: from dggpemm500001.china.huawei.com (7.185.36.107) by
 dggpemm500024.china.huawei.com (7.185.36.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 17 Nov 2022 15:56:16 +0800
Received: from [10.174.177.243] (10.174.177.243) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 17 Nov 2022 15:56:15 +0800
Message-ID: <65ca8d04-d7cc-cdb3-1dab-034b9e37a12c@huawei.com>
Date:   Thu, 17 Nov 2022 15:56:15 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v2 1/2] arm64/mm: fix incorrect file_map_count for
 non-leaf pmd/pud
Content-Language: en-US
To:     Liu Shixin <liushixin2@huawei.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Denys Vlasenko <dvlasenk@redhat.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        "David Hildenbrand" <dhildenb@redhat.com>,
        Rafael Aquini <raquini@redhat.com>,
        "Pasha Tatashin" <pasha.tatashin@soleen.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <20221117075602.2904324-1-liushixin2@huawei.com>
 <20221117075602.2904324-2-liushixin2@huawei.com>
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
In-Reply-To: <20221117075602.2904324-2-liushixin2@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.243]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemm500001.china.huawei.com (7.185.36.107)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2022/11/17 15:56, Liu Shixin wrote:
> The page table check trigger BUG_ON() unexpectedly when collapse hugepage:
>
>   ------------[ cut here ]------------
>   kernel BUG at mm/page_table_check.c:82!
>   Internal error: Oops - BUG: 00000000f2000800 [#1] SMP
>   Dumping ftrace buffer:
>      (ftrace buffer empty)
>   Modules linked in:
>   CPU: 6 PID: 68 Comm: khugepaged Not tainted 6.1.0-rc3+ #750
>   Hardware name: linux,dummy-virt (DT)
>   pstate: 60000005 (nZCv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
>   pc : page_table_check_clear.isra.0+0x258/0x3f0
>   lr : page_table_check_clear.isra.0+0x240/0x3f0
> [...]
>   Call trace:
>    page_table_check_clear.isra.0+0x258/0x3f0
>    __page_table_check_pmd_clear+0xbc/0x108
>    pmdp_collapse_flush+0xb0/0x160
>    collapse_huge_page+0xa08/0x1080
>    hpage_collapse_scan_pmd+0xf30/0x1590
>    khugepaged_scan_mm_slot.constprop.0+0x52c/0xac8
>    khugepaged+0x338/0x518
>    kthread+0x278/0x2f8
>    ret_from_fork+0x10/0x20
> [...]
>
> Since pmd_user_accessible_page() doesn't check if a pmd is leaf, it
> decrease file_map_count for a non-leaf pmd comes from collapse_huge_page().
> and so trigger BUG_ON() unexpectedly.
>
> Fix this problem by using pmd_leaf() insteal of pmd_present() in
> pmd_user_accessible_page(). Moreover, use pud_leaf() for
> pud_user_accessible_page() too.
>
> Fixes: 42b2547137f5 ("arm64/mm: enable ARCH_SUPPORTS_PAGE_TABLE_CHECK")
> Reported-by: Denys Vlasenko <dvlasenk@redhat.com>
> Signed-off-by: Liu Shixin <liushixin2@huawei.com>
> Reviewed-by: David Hildenbrand <david@redhat.com>
> Acked-by: Pasha Tatashin <pasha.tatashin@soleen.com>
Reviewed-by: Kefeng Wang <wangkefeng.wang@huawei.com>

