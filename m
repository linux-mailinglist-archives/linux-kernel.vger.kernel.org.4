Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4F2B714F22
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 20:00:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229526AbjE2SAd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 14:00:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjE2SAb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 14:00:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 344CED2
        for <linux-kernel@vger.kernel.org>; Mon, 29 May 2023 11:00:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B2ED3616FE
        for <linux-kernel@vger.kernel.org>; Mon, 29 May 2023 18:00:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27062C433D2;
        Mon, 29 May 2023 18:00:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685383229;
        bh=gJZ6i/YEnspBK6Kp4eZbVclre0eMmwrGGq06qCquzoU=;
        h=From:To:Cc:Subject:Date:From;
        b=dBaihDRVF/Dkad7v2ZgMsCQOwVB60RQvPXfXbZJE+4jLWCmYwYMZcv+IeFgKN4nlI
         qjlIdU/+f49JykEQI5cJEXzvPatnSWW+R4SeQ0sj3iS02QPXHC7w1g07/6d2HtOkJl
         zDvtwWdeh/gtkzTkkTk9xJSMWQZ9r0miuCMfr4a9dC7X+MNlaluy1HwR7tQGzKvNe7
         JkhhyprDfm8iN+Y8eZHAO0juHbS6AjSMc5hoCMLRZkMQcY25TBKLZo5QnedSvLwZYg
         +ub+9Oiy+pr3PncbWYVPCPZ6TgInAbwXUjWscrTK7vHFPs3mRzFZX1zOskVu91TwLg
         dKSKOonkpEp/w==
From:   =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org
Cc:     =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@rivosinc.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux@rivosinc.com, Alexandre Ghiti <alexghiti@rivosinc.com>,
        Joerg Roedel <joro@8bytes.org>
Subject: [PATCH] riscv: mm: Pre-allocate PGD entries vmalloc/modules area
Date:   Mon, 29 May 2023 20:00:23 +0200
Message-Id: <20230529180023.289904-1-bjorn@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Björn Töpel <bjorn@rivosinc.com>

The RISC-V port requires that kernel PGD entries are to be
synchronized between MMs. This is done via the vmalloc_fault()
function, that simply copies the PGD entries from init_mm to the
faulting one.

Historically, faulting in PGD entries have been a source for both bugs
[1], and poor performance.

One way to get rid of vmalloc faults is by pre-allocating the PGD
entries. Pre-allocating the entries potientially wastes 64 * 4K (65 on
SV39). The pre-allocation function is pulled from Jörg Rödel's x86
work, with the addition of 3-level page tables (PMD allocations).

The pmd_alloc() function needs the ptlock cache to be initialized
(when split page locks is enabled), so the pre-allocation is done in a
RISC-V specific pgtable_cache_init() implementation.

Pre-allocate the kernel PGD entries for the vmalloc/modules area, but
only for 64b platforms.

Link: https://lore.kernel.org/lkml/20200508144043.13893-1-joro@8bytes.org/ # [1]
Signed-off-by: Björn Töpel <bjorn@rivosinc.com>
---
 arch/riscv/mm/fault.c | 20 +++------------
 arch/riscv/mm/init.c  | 58 +++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 62 insertions(+), 16 deletions(-)

diff --git a/arch/riscv/mm/fault.c b/arch/riscv/mm/fault.c
index 8685f85a7474..6b0b5e517e12 100644
--- a/arch/riscv/mm/fault.c
+++ b/arch/riscv/mm/fault.c
@@ -230,32 +230,20 @@ void handle_page_fault(struct pt_regs *regs)
 		return;
 
 	/*
-	 * Fault-in kernel-space virtual memory on-demand.
-	 * The 'reference' page table is init_mm.pgd.
+	 * Fault-in kernel-space virtual memory on-demand, for 32-bit
+	 * architectures.  The 'reference' page table is init_mm.pgd.
 	 *
 	 * NOTE! We MUST NOT take any locks for this case. We may
 	 * be in an interrupt or a critical region, and should
 	 * only copy the information from the master page table,
 	 * nothing more.
 	 */
-	if (unlikely((addr >= VMALLOC_START) && (addr < VMALLOC_END))) {
+	if (!IS_ENABLED(CONFIG_64BIT) &&
+	    unlikely(addr >= VMALLOC_START && addr < VMALLOC_END)) {
 		vmalloc_fault(regs, code, addr);
 		return;
 	}
 
-#ifdef CONFIG_64BIT
-	/*
-	 * Modules in 64bit kernels lie in their own virtual region which is not
-	 * in the vmalloc region, but dealing with page faults in this region
-	 * or the vmalloc region amounts to doing the same thing: checking that
-	 * the mapping exists in init_mm.pgd and updating user page table, so
-	 * just use vmalloc_fault.
-	 */
-	if (unlikely(addr >= MODULES_VADDR && addr < MODULES_END)) {
-		vmalloc_fault(regs, code, addr);
-		return;
-	}
-#endif
 	/* Enable interrupts if they were enabled in the parent context. */
 	if (!regs_irqs_disabled(regs))
 		local_irq_enable();
diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
index 747e5b1ef02d..38bd4dd95276 100644
--- a/arch/riscv/mm/init.c
+++ b/arch/riscv/mm/init.c
@@ -1363,3 +1363,61 @@ int __meminit vmemmap_populate(unsigned long start, unsigned long end, int node,
 	return vmemmap_populate_basepages(start, end, node, NULL);
 }
 #endif
+
+#ifdef CONFIG_64BIT
+/*
+ * Pre-allocates page-table pages for a specific area in the kernel
+ * page-table. Only the level which needs to be synchronized between
+ * all page-tables is allocated because the synchronization can be
+ * expensive.
+ */
+static void __init preallocate_pgd_pages_range(unsigned long start, unsigned long end,
+					       const char *area)
+{
+	unsigned long addr;
+	const char *lvl;
+
+	for (addr = start; addr < end && addr >= start; addr = ALIGN(addr + 1, PGDIR_SIZE)) {
+		pgd_t *pgd = pgd_offset_k(addr);
+		p4d_t *p4d;
+		pud_t *pud;
+		pmd_t *pmd;
+
+		lvl = "p4d";
+		p4d = p4d_alloc(&init_mm, pgd, addr);
+		if (!p4d)
+			goto failed;
+
+		if (pgtable_l5_enabled)
+			continue;
+
+		lvl = "pud";
+		pud = pud_alloc(&init_mm, p4d, addr);
+		if (!pud)
+			goto failed;
+
+		if (pgtable_l4_enabled)
+			continue;
+
+		lvl = "pmd";
+		pmd = pmd_alloc(&init_mm, pud, addr);
+		if (!pmd)
+			goto failed;
+	}
+	return;
+
+failed:
+	/*
+	 * The pages have to be there now or they will be missing in
+	 * process page-tables later.
+	 */
+	panic("Failed to pre-allocate %s pages for %s area\n", lvl, area);
+}
+
+void __init pgtable_cache_init(void)
+{
+	preallocate_pgd_pages_range(VMALLOC_START, VMALLOC_END, "vmalloc");
+	if (IS_ENABLED(CONFIG_MODULES))
+		preallocate_pgd_pages_range(MODULES_VADDR, MODULES_END, "bpf/modules");
+}
+#endif

base-commit: ac9a78681b921877518763ba0e89202254349d1b
-- 
2.39.2

