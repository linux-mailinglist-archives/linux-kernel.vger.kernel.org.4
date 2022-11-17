Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C54662D479
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 08:56:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239300AbiKQH4r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 02:56:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231871AbiKQH4p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 02:56:45 -0500
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3740259871
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 23:56:44 -0800 (PST)
Received: from dggpemm500021.china.huawei.com (unknown [172.30.72.53])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4NCXKv5GxJz15Mkr;
        Thu, 17 Nov 2022 15:56:19 +0800 (CST)
Received: from dggpemm500001.china.huawei.com (7.185.36.107) by
 dggpemm500021.china.huawei.com (7.185.36.109) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 17 Nov 2022 15:56:42 +0800
Received: from [10.174.177.243] (10.174.177.243) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 17 Nov 2022 15:56:41 +0800
Message-ID: <3ab1b3ee-4710-b598-c634-81c096ef0100@huawei.com>
Date:   Thu, 17 Nov 2022 15:56:41 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v2 2/2] arm64/mm: fix incorrect file_map_count for invalid
 pmd/pud
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
 <20221117075602.2904324-3-liushixin2@huawei.com>
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
In-Reply-To: <20221117075602.2904324-3-liushixin2@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.243]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
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
> The page table check trigger BUG_ON() unexpectedly when split hugepage:
>
>   ------------[ cut here ]------------
>   kernel BUG at mm/page_table_check.c:119!
>   Internal error: Oops - BUG: 00000000f2000800 [#1] SMP
>   Dumping ftrace buffer:
>      (ftrace buffer empty)
>   Modules linked in:
>   CPU: 7 PID: 210 Comm: transhuge-stres Not tainted 6.1.0-rc3+ #748
>   Hardware name: linux,dummy-virt (DT)
>   pstate: 20000005 (nzCv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
>   pc : page_table_check_set.isra.0+0x398/0x468
>   lr : page_table_check_set.isra.0+0x1c0/0x468
> [...]
>   Call trace:
>    page_table_check_set.isra.0+0x398/0x468
>    __page_table_check_pte_set+0x160/0x1c0
>    __split_huge_pmd_locked+0x900/0x1648
>    __split_huge_pmd+0x28c/0x3b8
>    unmap_page_range+0x428/0x858
>    unmap_single_vma+0xf4/0x1c8
>    zap_page_range+0x2b0/0x410
>    madvise_vma_behavior+0xc44/0xe78
>    do_madvise+0x280/0x698
>    __arm64_sys_madvise+0x90/0xe8
>    invoke_syscall.constprop.0+0xdc/0x1d8
>    do_el0_svc+0xf4/0x3f8
>    el0_svc+0x58/0x120
>    el0t_64_sync_handler+0xb8/0xc0
>    el0t_64_sync+0x19c/0x1a0
> [...]
>
> On arm64, pmd_leaf() will return true even if the pmd is invalid due to
> pmd_present_invalid() check. So in pmdp_invalidate() the file_map_count
> will not only decrease once but also increase once. Then in set_pte_at(),
> the file_map_count increase again, and so trigger BUG_ON() unexpectedly.
>
> Fix this problem by adding pmd_valid() in pmd_user_accessible_page().
> Moreover, add pud_valid() for pud_user_accessible_page() too.
>
> Fixes: 42b2547137f5 ("arm64/mm: enable ARCH_SUPPORTS_PAGE_TABLE_CHECK")
> Reported-by: Denys Vlasenko <dvlasenk@redhat.com>
> Signed-off-by: Liu Shixin <liushixin2@huawei.com>
> Acked-by: Pasha Tatashin <pasha.tatashin@soleen.com>
Reviewed-by: Kefeng Wang <wangkefeng.wang@huawei.com>

