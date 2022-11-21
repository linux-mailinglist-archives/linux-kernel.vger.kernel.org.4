Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9ED46319DB
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 07:48:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229476AbiKUGsy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 01:48:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229817AbiKUGsq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 01:48:46 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E45D21B1D7
        for <linux-kernel@vger.kernel.org>; Sun, 20 Nov 2022 22:48:41 -0800 (PST)
Received: from dggpemm500022.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4NFydK44NnzHw20;
        Mon, 21 Nov 2022 14:48:05 +0800 (CST)
Received: from dggpemm100009.china.huawei.com (7.185.36.113) by
 dggpemm500022.china.huawei.com (7.185.36.162) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 21 Nov 2022 14:48:40 +0800
Received: from huawei.com (10.175.113.32) by dggpemm100009.china.huawei.com
 (7.185.36.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Mon, 21 Nov
 2022 14:48:39 +0800
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
Subject: [PATCH v3] arm64/mm: fix incorrect file_map_count for invalid pmd
Date:   Mon, 21 Nov 2022 15:36:08 +0800
Message-ID: <20221121073608.4183459-1-liushixin2@huawei.com>
X-Mailer: git-send-email 2.25.1
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

Add !pmd_present_invalid() check in pmd_user_accessible_page() to fix the
problem.

Fixes: 42b2547137f5 ("arm64/mm: enable ARCH_SUPPORTS_PAGE_TABLE_CHECK")
Reported-by: Denys Vlasenko <dvlasenk@redhat.com>
Signed-off-by: Liu Shixin <liushixin2@huawei.com>
Acked-by: Pasha Tatashin <pasha.tatashin@soleen.com>
Acked-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
v1->v2: Update comment and optimize the code by moving p?d_valid() at
	first place suggested by Mark.
v2->v3: Replace pmd_valid() with pmd_present_invalid() suggested by Will.

 arch/arm64/include/asm/pgtable.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
index edf6625ce965..17afb09f386f 100644
--- a/arch/arm64/include/asm/pgtable.h
+++ b/arch/arm64/include/asm/pgtable.h
@@ -863,7 +863,7 @@ static inline bool pte_user_accessible_page(pte_t pte)
 
 static inline bool pmd_user_accessible_page(pmd_t pmd)
 {
-	return pmd_leaf(pmd) && (pmd_user(pmd) || pmd_user_exec(pmd));
+	return pmd_leaf(pmd) && !pmd_present_invalid(pmd) && (pmd_user(pmd) || pmd_user_exec(pmd));
 }
 
 static inline bool pud_user_accessible_page(pud_t pud)
-- 
2.25.1

