Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D84D601DAE
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 01:38:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230185AbiJQXiM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 19:38:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229904AbiJQXiK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 19:38:10 -0400
X-Greylist: delayed 60 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 17 Oct 2022 16:38:07 PDT
Received: from smtpcmd0641.aruba.it (smtpcmd0641.aruba.it [62.149.156.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2A5558050F
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 16:38:06 -0700 (PDT)
Received: from localhost.localdomain ([146.241.87.206])
        by Aruba Outgoing Smtp  with ESMTPSA
        id kZfJoHtVXJpY4kZfJoMX3o; Tue, 18 Oct 2022 01:37:03 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aruba.it; s=a1;
        t=1666049823; bh=+OQAKoYv7OiuITTsmVZiFS/2M0iuzzB5uuDxcJkXXgI=;
        h=From:To:Subject:Date:MIME-Version;
        b=bUwxpBrurlQyUR5ls45YsLQoMzDT8C9/GiWvONMGEjAi19/DBuVq243MR53ypulYl
         IH/b3lGfM5D5z1UJ3Ek2gcgoO/bSYzEuyd5mtcmEQiegZMNusd9L+NNnsmJNX22L3q
         FkkYh4BS/ihkYsyDLkadWF/3aq7dfurgJp4yOyXlDhi1jYK2EklFsgG8M68xtq6P3/
         5B8Iq4v/0v4fol+5j9xbhoWicSGwhc/R7Ck+6Pj8nUG0lOS6q+NMQPxXn7A9Ad8p50
         mq2EvrKVhi1+oB5wzsArJslj27JtC1sdV/zJ23hdsUU0Sjdifip1Mwo3n1zBVTl/nM
         xe0RNKxSZZmLw==
From:   Giulio Benetti <giulio.benetti@benettiengineering.com>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Russell King <linux@armlinux.org.uk>,
        Giulio Benetti <giulio.benetti@benettiengineering.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>, Will Deacon <will@kernel.org>
Subject: [PATCH] ARM: mm: fix no-MMU ZERO_PAGE() implementation
Date:   Tue, 18 Oct 2022 01:37:00 +0200
Message-Id: <20221017233700.84918-1-giulio.benetti@benettiengineering.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfEesJnfYhGVfzJwrpi2WrccOoQLk7qp7dxIosvDTgNTHuD+L/Kgzbkpqd5IzkRrqzYNkCaCxHsGSoGNJBk/6hCXucsuTWi1skZxo2vJ2oPXyWgrir0Dc
 WSG2BDgQRCTBN3fISBsiKdgBXLrKGfZL8BvLcoY1DCli3bD3X4YOgh0xNnuWOlxBZZ+UI5vYWrk/vQkIy1MjU4r9NL2P3zARME3m7jk1ZKUijybkhhAVOU6r
 IKu98Y6Ui8ByU+5a3DA22aTL9J5YfLdorcXL/Ef0irNtMNXrGVKwYfuLS1MZPQLyYe4CtnfkWBFPtq5GyNyOaNpd+wF1ILw98TgmEAJhgyebqBH2KL1Ad6Mv
 JDM3AuMzmChqAj4em51r15cfjGCGXrEAnbyRTENfxX0XFkAwr3xMouc4rbRgHya9z+H17oqI2G2nta7f3ybPP+WLN/TGioTA1lxsgKHpoxWHfl4ai+UALEIx
 h+iN2PkHoXKPdCD6yAlWNL/JF0cfG1eFndeljNJyUL4NgDbanjiBNn6C3Tia8AilFEDttK2spTNGMRf96iMSgmpPI8PBwZF1DRMPZjjHksQjG3nFprJyg3ge
 r1Q=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Actually in no-MMU SoCs(i.e. i.MXRT) ZERO_PAGE(vaddr) expands to
```
virt_to_page(0)
```
that in order expands to:
```
pfn_to_page(virt_to_pfn(0))
```
and then virt_to_pfn(0) to:
```
#define virt_to_pfn(0) \
	((((unsigned long)(0) - PAGE_OFFSET) >> PAGE_SHIFT) + \
	 PHYS_PFN_OFFSET)
```
where PAGE_OFFSET and PHYS_PFN_OFFSET are the DRAM offset(0x80000000) and
PAGE_SHIFT is 12. This way we obtain 16MB(0x01000000) summed to the base of
DRAM(0x80000000).
When ZERO_PAGE(0) is then used, for example in bio_add_page(), the page
gets an address that is out of DRAM bounds.
So instead of using fake virtual page 0 let's allocate a dedicated
zero_page during paging_init() and assign it to a global 'struct page *
empty_zero_page' the same way mmu.c does. Then let's move ZERO_PAGE()
definition to the top of pgtable.h to be in common between mmu.c and
nommu.c.

Signed-off-by: Giulio Benetti <giulio.benetti@benettiengineering.com>
---
 arch/arm/include/asm/pgtable-nommu.h |  6 ------
 arch/arm/include/asm/pgtable.h       | 16 +++++++++-------
 arch/arm/mm/nommu.c                  | 19 +++++++++++++++++++
 3 files changed, 28 insertions(+), 13 deletions(-)

diff --git a/arch/arm/include/asm/pgtable-nommu.h b/arch/arm/include/asm/pgtable-nommu.h
index d16aba48fa0a..090011394477 100644
--- a/arch/arm/include/asm/pgtable-nommu.h
+++ b/arch/arm/include/asm/pgtable-nommu.h
@@ -44,12 +44,6 @@
 
 typedef pte_t *pte_addr_t;
 
-/*
- * ZERO_PAGE is a global shared page that is always zero: used
- * for zero-mapped memory areas etc..
- */
-#define ZERO_PAGE(vaddr)	(virt_to_page(0))
-
 /*
  * Mark the prot value as uncacheable and unbufferable.
  */
diff --git a/arch/arm/include/asm/pgtable.h b/arch/arm/include/asm/pgtable.h
index 78a532068fec..ef48a55e9af8 100644
--- a/arch/arm/include/asm/pgtable.h
+++ b/arch/arm/include/asm/pgtable.h
@@ -10,6 +10,15 @@
 #include <linux/const.h>
 #include <asm/proc-fns.h>
 
+#ifndef __ASSEMBLY__
+/*
+ * ZERO_PAGE is a global shared page that is always zero: used
+ * for zero-mapped memory areas etc..
+ */
+extern struct page *empty_zero_page;
+#define ZERO_PAGE(vaddr)	(empty_zero_page)
+#endif
+
 #ifndef CONFIG_MMU
 
 #include <asm-generic/pgtable-nopud.h>
@@ -139,13 +148,6 @@ extern pgprot_t phys_mem_access_prot(struct file *file, unsigned long pfn,
  */
 
 #ifndef __ASSEMBLY__
-/*
- * ZERO_PAGE is a global shared page that is always zero: used
- * for zero-mapped memory areas etc..
- */
-extern struct page *empty_zero_page;
-#define ZERO_PAGE(vaddr)	(empty_zero_page)
-
 
 extern pgd_t swapper_pg_dir[PTRS_PER_PGD];
 
diff --git a/arch/arm/mm/nommu.c b/arch/arm/mm/nommu.c
index c42debaded95..c1494a4dee25 100644
--- a/arch/arm/mm/nommu.c
+++ b/arch/arm/mm/nommu.c
@@ -26,6 +26,13 @@
 
 unsigned long vectors_base;
 
+/*
+ * empty_zero_page is a special page that is used for
+ * zero-initialized data and COW.
+ */
+struct page *empty_zero_page;
+EXPORT_SYMBOL(empty_zero_page);
+
 #ifdef CONFIG_ARM_MPU
 struct mpu_rgn_info mpu_rgn_info;
 #endif
@@ -148,9 +155,21 @@ void __init adjust_lowmem_bounds(void)
  */
 void __init paging_init(const struct machine_desc *mdesc)
 {
+	void *zero_page;
+
 	early_trap_init((void *)vectors_base);
 	mpu_setup();
+
+	/* allocate the zero page. */
+	zero_page = memblock_alloc(PAGE_SIZE, PAGE_SIZE);
+	if (!zero_page)
+		panic("%s: Failed to allocate %lu bytes align=0x%lx\n",
+		      __func__, PAGE_SIZE, PAGE_SIZE);
+
 	bootmem_init();
+
+	empty_zero_page = virt_to_page(zero_page);
+	flush_dcache_page(empty_zero_page);
 }
 
 /*
-- 
2.34.1

