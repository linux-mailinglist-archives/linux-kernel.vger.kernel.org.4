Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F67A62D3CF
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 08:08:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239029AbiKQHIk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 02:08:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238783AbiKQHIf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 02:08:35 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B3371B1F8
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 23:08:29 -0800 (PST)
Received: from dggpemm500020.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4NCWGG4cggzRpGD;
        Thu, 17 Nov 2022 15:08:06 +0800 (CST)
Received: from dggpemm100009.china.huawei.com (7.185.36.113) by
 dggpemm500020.china.huawei.com (7.185.36.49) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 17 Nov 2022 15:08:27 +0800
Received: from huawei.com (10.175.113.32) by dggpemm100009.china.huawei.com
 (7.185.36.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Thu, 17 Nov
 2022 15:08:26 +0800
From:   Liu Shixin <liushixin2@huawei.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Denys Vlasenko <dvlasenk@redhat.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        David Hildenbrand <dhildenb@redhat.com>,
        Rafael Aquini <raquini@redhat.com>,
        Pasha Tatashin <pasha.tatashin@soleen.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Liu Shixin <liushixin2@huawei.com>
Subject: [PATCH v2 2/2] arm64/mm: fix incorrect file_map_count for invalid pmd/pud
Date:   Thu, 17 Nov 2022 15:56:02 +0800
Message-ID: <20221117075602.2904324-3-liushixin2@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221117075602.2904324-1-liushixin2@huawei.com>
References: <20221117075602.2904324-1-liushixin2@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.32]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemm100009.china.huawei.com (7.185.36.113)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The page table check trigger BUG_ON() unexpectedly when split hugepage:

 ------------[ cut here ]------------
 kernel BUG at mm/page_table_check.c:119!
 Internal error: Oops - BUG: 00000000f2000800 [#1] SMP
 Dumping ftrace buffer:
    (ftrace buffer empty)
 Modules linked in:
 CPU: 7 PID: 210 Comm: transhuge-stres Not tainted 6.1.0-rc3+ #748
 Hardware name: linux,dummy-virt (DT)
 pstate: 20000005 (nzCv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
 pc : page_table_check_set.isra.0+0x398/0x468
 lr : page_table_check_set.isra.0+0x1c0/0x468
[...]
 Call trace:
  page_table_check_set.isra.0+0x398/0x468
  __page_table_check_pte_set+0x160/0x1c0
  __split_huge_pmd_locked+0x900/0x1648
  __split_huge_pmd+0x28c/0x3b8
  unmap_page_range+0x428/0x858
  unmap_single_vma+0xf4/0x1c8
  zap_page_range+0x2b0/0x410
  madvise_vma_behavior+0xc44/0xe78
  do_madvise+0x280/0x698
  __arm64_sys_madvise+0x90/0xe8
  invoke_syscall.constprop.0+0xdc/0x1d8
  do_el0_svc+0xf4/0x3f8
  el0_svc+0x58/0x120
  el0t_64_sync_handler+0xb8/0xc0
  el0t_64_sync+0x19c/0x1a0
[...]

On arm64, pmd_leaf() will return true even if the pmd is invalid due to
pmd_present_invalid() check. So in pmdp_invalidate() the file_map_count
will not only decrease once but also increase once. Then in set_pte_at(),
the file_map_count increase again, and so trigger BUG_ON() unexpectedly.

Fix this problem by adding pmd_valid() in pmd_user_accessible_page().
Moreover, add pud_valid() for pud_user_accessible_page() too.

Fixes: 42b2547137f5 ("arm64/mm: enable ARCH_SUPPORTS_PAGE_TABLE_CHECK")
Reported-by: Denys Vlasenko <dvlasenk@redhat.com>
Signed-off-by: Liu Shixin <liushixin2@huawei.com>
Acked-by: Pasha Tatashin <pasha.tatashin@soleen.com>
---
 arch/arm64/include/asm/pgtable.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
index edf6625ce965..3bc64199aa2e 100644
--- a/arch/arm64/include/asm/pgtable.h
+++ b/arch/arm64/include/asm/pgtable.h
@@ -863,12 +863,12 @@ static inline bool pte_user_accessible_page(pte_t pte)
 
 static inline bool pmd_user_accessible_page(pmd_t pmd)
 {
-	return pmd_leaf(pmd) && (pmd_user(pmd) || pmd_user_exec(pmd));
+	return pmd_valid(pmd) && pmd_leaf(pmd) && (pmd_user(pmd) || pmd_user_exec(pmd));
 }
 
 static inline bool pud_user_accessible_page(pud_t pud)
 {
-	return pud_leaf(pud) && pud_user(pud);
+	return pud_valid(pud) && pud_leaf(pud) && pud_user(pud);
 }
 #endif
 
-- 
2.25.1

