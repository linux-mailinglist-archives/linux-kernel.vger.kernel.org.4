Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 997C85FC42C
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 13:12:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229546AbiJLLLy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 07:11:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229651AbiJLLLn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 07:11:43 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10FEBC1DA5;
        Wed, 12 Oct 2022 04:11:38 -0700 (PDT)
Received: from dggpemm500021.china.huawei.com (unknown [172.30.72.56])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4MnVJw08x0z1CF0G;
        Wed, 12 Oct 2022 19:09:04 +0800 (CST)
Received: from dggpemm100009.china.huawei.com (7.185.36.113) by
 dggpemm500021.china.huawei.com (7.185.36.109) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 12 Oct 2022 19:11:35 +0800
Received: from huawei.com (10.175.113.32) by dggpemm100009.china.huawei.com
 (7.185.36.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Wed, 12 Oct
 2022 19:11:35 +0800
From:   Liu Shixin <liushixin2@huawei.com>
To:     Conor Dooley <conor@kernel.org>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>
CC:     <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-riscv@lists.infradead.org>,
        Liu Shixin <liushixin2@huawei.com>
Subject: [PATCH v3 1/2] riscv: Enable HAVE_ARCH_HUGE_VMAP for 64BIT
Date:   Wed, 12 Oct 2022 20:00:37 +0800
Message-ID: <20221012120038.1034354-2-liushixin2@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221012120038.1034354-1-liushixin2@huawei.com>
References: <20221012120038.1034354-1-liushixin2@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.175.113.32]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemm100009.china.huawei.com (7.185.36.113)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This sets the HAVE_ARCH_HUGE_VMAP option, and defines the required
page table functions. With this feature, ioremap area will be mapped with
huge page granularity according to its actual size. This feature can be
disabled by kernel parameter "nohugeiomap".

Signed-off-by: Liu Shixin <liushixin2@huawei.com>
Reviewed-by: Björn Töpel <bjorn@kernel.org>
Tested-by: Björn Töpel <bjorn@kernel.org>
---
 .../features/vm/huge-vmap/arch-support.txt    |  2 +-
 arch/riscv/Kconfig                            |  1 +
 arch/riscv/include/asm/vmalloc.h              | 18 ++++
 arch/riscv/mm/Makefile                        |  1 +
 arch/riscv/mm/pgtable.c                       | 83 +++++++++++++++++++
 5 files changed, 104 insertions(+), 1 deletion(-)
 create mode 100644 arch/riscv/mm/pgtable.c

diff --git a/Documentation/features/vm/huge-vmap/arch-support.txt b/Documentation/features/vm/huge-vmap/arch-support.txt
index 13b4940e0c3a..7274a4b15bcc 100644
--- a/Documentation/features/vm/huge-vmap/arch-support.txt
+++ b/Documentation/features/vm/huge-vmap/arch-support.txt
@@ -21,7 +21,7 @@
     |    openrisc: | TODO |
     |      parisc: | TODO |
     |     powerpc: |  ok  |
-    |       riscv: | TODO |
+    |       riscv: |  ok  |
     |        s390: | TODO |
     |          sh: | TODO |
     |       sparc: | TODO |
diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 70c1c5010378..a4d597203bd9 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -70,6 +70,7 @@ config RISCV
 	select GENERIC_TIME_VSYSCALL if MMU && 64BIT
 	select GENERIC_VDSO_TIME_NS if HAVE_GENERIC_VDSO
 	select HAVE_ARCH_AUDITSYSCALL
+	select HAVE_ARCH_HUGE_VMAP if MMU && 64BIT && !XIP_KERNEL
 	select HAVE_ARCH_JUMP_LABEL if !XIP_KERNEL
 	select HAVE_ARCH_JUMP_LABEL_RELATIVE if !XIP_KERNEL
 	select HAVE_ARCH_KASAN if MMU && 64BIT
diff --git a/arch/riscv/include/asm/vmalloc.h b/arch/riscv/include/asm/vmalloc.h
index ff9abc00d139..48da5371f1e9 100644
--- a/arch/riscv/include/asm/vmalloc.h
+++ b/arch/riscv/include/asm/vmalloc.h
@@ -1,4 +1,22 @@
 #ifndef _ASM_RISCV_VMALLOC_H
 #define _ASM_RISCV_VMALLOC_H
 
+#ifdef CONFIG_HAVE_ARCH_HUGE_VMAP
+
+#define IOREMAP_MAX_ORDER (PUD_SHIFT)
+
+#define arch_vmap_pud_supported arch_vmap_pud_supported
+static inline bool arch_vmap_pud_supported(pgprot_t prot)
+{
+	return true;
+}
+
+#define arch_vmap_pmd_supported arch_vmap_pmd_supported
+static inline bool arch_vmap_pmd_supported(pgprot_t prot)
+{
+	return true;
+}
+
+#endif
+
 #endif /* _ASM_RISCV_VMALLOC_H */
diff --git a/arch/riscv/mm/Makefile b/arch/riscv/mm/Makefile
index d76aabf4b94d..ce7f121ad2dc 100644
--- a/arch/riscv/mm/Makefile
+++ b/arch/riscv/mm/Makefile
@@ -13,6 +13,7 @@ obj-y += extable.o
 obj-$(CONFIG_MMU) += fault.o pageattr.o
 obj-y += cacheflush.o
 obj-y += context.o
+obj-y += pgtable.o
 
 ifeq ($(CONFIG_MMU),y)
 obj-$(CONFIG_SMP) += tlbflush.o
diff --git a/arch/riscv/mm/pgtable.c b/arch/riscv/mm/pgtable.c
new file mode 100644
index 000000000000..6645ead1a7c1
--- /dev/null
+++ b/arch/riscv/mm/pgtable.c
@@ -0,0 +1,83 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <asm/pgalloc.h>
+#include <linux/gfp.h>
+#include <linux/kernel.h>
+#include <linux/pgtable.h>
+
+#ifdef CONFIG_HAVE_ARCH_HUGE_VMAP
+int p4d_set_huge(p4d_t *p4d, phys_addr_t addr, pgprot_t prot)
+{
+	return 0;
+}
+
+void p4d_clear_huge(p4d_t *p4d)
+{
+}
+
+int pud_set_huge(pud_t *pud, phys_addr_t phys, pgprot_t prot)
+{
+	pud_t new_pud = pfn_pud(__phys_to_pfn(phys), prot);
+
+	set_pud(pud, new_pud);
+	return 1;
+}
+
+int pud_clear_huge(pud_t *pud)
+{
+	if (!pud_leaf(READ_ONCE(*pud)))
+		return 0;
+	pud_clear(pud);
+	return 1;
+}
+
+int pud_free_pmd_page(pud_t *pud, unsigned long addr)
+{
+	pmd_t *pmd = pud_pgtable(*pud);
+	int i;
+
+	pud_clear(pud);
+
+	flush_tlb_kernel_range(addr, addr + PUD_SIZE);
+
+	for (i = 0; i < PTRS_PER_PMD; i++) {
+		if (!pmd_none(pmd[i])) {
+			pte_t *pte = (pte_t *)pmd_page_vaddr(pmd[i]);
+
+			pte_free_kernel(NULL, pte);
+		}
+	}
+
+	pmd_free(NULL, pmd);
+
+	return 1;
+}
+
+int pmd_set_huge(pmd_t *pmd, phys_addr_t phys, pgprot_t prot)
+{
+	pmd_t new_pmd = pfn_pmd(__phys_to_pfn(phys), prot);
+
+	set_pmd(pmd, new_pmd);
+	return 1;
+}
+
+int pmd_clear_huge(pmd_t *pmd)
+{
+	if (!pmd_leaf(READ_ONCE(*pmd)))
+		return 0;
+	pmd_clear(pmd);
+	return 1;
+}
+
+int pmd_free_pte_page(pmd_t *pmd, unsigned long addr)
+{
+	pte_t *pte = (pte_t *)pmd_page_vaddr(*pmd);
+
+	pmd_clear(pmd);
+
+	flush_tlb_kernel_range(addr, addr + PMD_SIZE);
+	pte_free_kernel(NULL, pte);
+	return 1;
+}
+
+#endif /* CONFIG_HAVE_ARCH_HUGE_VMAP */
-- 
2.25.1

