Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6789724236
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 14:33:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237299AbjFFMdw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 08:33:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235379AbjFFMdu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 08:33:50 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDC52E62
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 05:33:48 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id ffacd0b85a97d-30ae5f2ac94so6046313f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 06 Jun 2023 05:33:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1686054827; x=1688646827;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BnN91fXmDihZm2BLm/f/mP83zFIlNhb/Ca5+/aWWSSg=;
        b=DjHNMYfnVKmIDhpjBDaOJLP5gcz6KrVkSS0at3qPu2HyrKf0xKyPT0aC2vW9EtAcEp
         B6ETpOAZdLtayPMOkfWOclcleWVFPVG2mla0roVmgdcq/WNwEc65awRGdQSZabnZjsgI
         MXsOHK09i3wUuVjgDkkzc2TuQzMBsa6YCzT2r8+4CjM0CxFj2+rofNtDGvWxA8GsUr+T
         VXNpoTEhH5lWIyWqzG5RPOHM/qguYywPrj/KhqGb5M8639RJciywAKFM1JZQiOJ1jB3q
         ai92KTWiHbWcq+lSpcSVM5daewIWjJoGC5ZAYHJtZyLIOpxTSGjrO/sTsuoEdb8w8MF4
         akMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686054827; x=1688646827;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BnN91fXmDihZm2BLm/f/mP83zFIlNhb/Ca5+/aWWSSg=;
        b=kXK24GLPJBqcGHbYkvOuDuVsfATcwjsGMvUs3pkK7c/CKl+/nwHHhsnGmDhYEqPpHY
         S+ePZRVuN+P7UEkAQ8npNFbWoQEBMBe8oQM8cd0aPI46pohyKbD+xHK7smIl9ev6iJXP
         KoBQi0rpaPVEpGvUIvSniCtcgzyez7qaRXmCUag+w+TQVBzucz4t4W0O0E+5NO5O8sHm
         WttfQapXEzzsRoaXmNjmy4SgqZ+S1+nog5G30Wng+HwjENBhpx3JYa3USsIeTJhUFJSw
         PMk6jao/cdXa+OM5RGrAHR+dxptdjhIq57VoEm1aqTJA0PEfakcUpOMDIc8FvISeSB2P
         Ra6A==
X-Gm-Message-State: AC+VfDwwWUNJsWThVSQRxZxUybOdJ1oGQevczYpyHkWhR5EauHGrmIzN
        P0bA/IwfoV/usyiDQV3+Ls4+UqGhmzB5kxRpzCk=
X-Google-Smtp-Source: ACHHUZ79MImhHGy1KY/uJ6QMdnCkB9QrcE7Xte6vTeeY8KELgZa+ENLFSFotiByE9PBXVQtEEeYh5A==
X-Received: by 2002:a05:6000:1972:b0:301:8551:446a with SMTP id da18-20020a056000197200b003018551446amr2020742wrb.2.1686054827418;
        Tue, 06 Jun 2023 05:33:47 -0700 (PDT)
Received: from localhost.localdomain (amontpellier-656-1-456-62.w92-145.abo.wanadoo.fr. [92.145.124.62])
        by smtp.gmail.com with ESMTPSA id k2-20020a5d4282000000b003047ea78b42sm12435513wrq.43.2023.06.06.05.33.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jun 2023 05:33:47 -0700 (PDT)
From:   Alexandre Ghiti <alexghiti@rivosinc.com>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Ard Biesheuvel <ardb@kernel.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-efi@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     Alexandre Ghiti <alexghiti@rivosinc.com>
Subject: [PATCH v3 1/5] riscv: Introduce virtual kernel mapping KASLR
Date:   Tue,  6 Jun 2023 14:32:38 +0200
Message-Id: <20230606123242.20804-2-alexghiti@rivosinc.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230606123242.20804-1-alexghiti@rivosinc.com>
References: <20230606123242.20804-1-alexghiti@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

KASLR implementation relies on a relocatable kernel so that we can move
the kernel mapping.

The seed needed to virtually move the kernel is taken from the device tree,
so we rely on the bootloader to provide a correct seed. Zkr could be used
unconditionnally instead if implemented, but that's for another patch.

Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
---
 arch/riscv/Kconfig                   | 19 +++++++++++++++
 arch/riscv/include/asm/page.h        |  3 +++
 arch/riscv/kernel/pi/Makefile        |  2 +-
 arch/riscv/kernel/pi/cmdline_early.c | 13 ++++++++++
 arch/riscv/kernel/pi/fdt_early.c     | 30 +++++++++++++++++++++++
 arch/riscv/mm/init.c                 | 36 +++++++++++++++++++++++++++-
 6 files changed, 101 insertions(+), 2 deletions(-)
 create mode 100644 arch/riscv/kernel/pi/fdt_early.c

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 348c0fa1fc8c..c5d54f86fe5e 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -653,6 +653,25 @@ config RELOCATABLE
 
           If unsure, say N.
 
+config RANDOMIZE_BASE
+        bool "Randomize the address of the kernel image"
+        select RELOCATABLE
+        depends on MMU && 64BIT && !XIP_KERNEL
+        help
+          Randomizes the virtual address at which the kernel image is
+          loaded, as a security feature that deters exploit attempts
+          relying on knowledge of the location of kernel internals.
+
+          It is the bootloader's job to provide entropy, by passing a
+          random u64 value in /chosen/kaslr-seed at kernel entry.
+
+          When booting via the UEFI stub, it will invoke the firmware's
+          EFI_RNG_PROTOCOL implementation (if available) to supply entropy
+          to the kernel proper. In addition, it will randomise the physical
+          location of the kernel Image as well.
+
+          If unsure, say N.
+
 endmenu # "Kernel features"
 
 menu "Boot options"
diff --git a/arch/riscv/include/asm/page.h b/arch/riscv/include/asm/page.h
index b55ba20903ec..5488ecc337b6 100644
--- a/arch/riscv/include/asm/page.h
+++ b/arch/riscv/include/asm/page.h
@@ -106,6 +106,7 @@ typedef struct page *pgtable_t;
 struct kernel_mapping {
 	unsigned long page_offset;
 	unsigned long virt_addr;
+	unsigned long virt_offset;
 	uintptr_t phys_addr;
 	uintptr_t size;
 	/* Offset between linear mapping virtual address and kernel load address */
@@ -185,6 +186,8 @@ extern phys_addr_t __phys_addr_symbol(unsigned long x);
 
 #define sym_to_pfn(x)           __phys_to_pfn(__pa_symbol(x))
 
+unsigned long kaslr_offset(void);
+
 #endif /* __ASSEMBLY__ */
 
 #define virt_addr_valid(vaddr)	({						\
diff --git a/arch/riscv/kernel/pi/Makefile b/arch/riscv/kernel/pi/Makefile
index 7b593d44c712..07915dc9279e 100644
--- a/arch/riscv/kernel/pi/Makefile
+++ b/arch/riscv/kernel/pi/Makefile
@@ -35,5 +35,5 @@ $(obj)/string.o: $(srctree)/lib/string.c FORCE
 $(obj)/ctype.o: $(srctree)/lib/ctype.c FORCE
 	$(call if_changed_rule,cc_o_c)
 
-obj-y		:= cmdline_early.pi.o string.pi.o ctype.pi.o lib-fdt.pi.o lib-fdt_ro.pi.o
+obj-y		:= cmdline_early.pi.o fdt_early.pi.o string.pi.o ctype.pi.o lib-fdt.pi.o lib-fdt_ro.pi.o
 extra-y		:= $(patsubst %.pi.o,%.o,$(obj-y))
diff --git a/arch/riscv/kernel/pi/cmdline_early.c b/arch/riscv/kernel/pi/cmdline_early.c
index 05652d13c746..68e786c84c94 100644
--- a/arch/riscv/kernel/pi/cmdline_early.c
+++ b/arch/riscv/kernel/pi/cmdline_early.c
@@ -14,6 +14,7 @@ static char early_cmdline[COMMAND_LINE_SIZE];
  * LLVM complain because the function is actually unused in this file).
  */
 u64 set_satp_mode_from_cmdline(uintptr_t dtb_pa);
+bool set_nokaslr_from_cmdline(uintptr_t dtb_pa);
 
 static char *get_early_cmdline(uintptr_t dtb_pa)
 {
@@ -60,3 +61,15 @@ u64 set_satp_mode_from_cmdline(uintptr_t dtb_pa)
 
 	return match_noXlvl(cmdline);
 }
+
+static bool match_nokaslr(char *cmdline)
+{
+	return strstr(cmdline, "nokaslr");
+}
+
+bool set_nokaslr_from_cmdline(uintptr_t dtb_pa)
+{
+	char *cmdline = get_early_cmdline(dtb_pa);
+
+	return match_nokaslr(cmdline);
+}
diff --git a/arch/riscv/kernel/pi/fdt_early.c b/arch/riscv/kernel/pi/fdt_early.c
new file mode 100644
index 000000000000..899610e042ab
--- /dev/null
+++ b/arch/riscv/kernel/pi/fdt_early.c
@@ -0,0 +1,30 @@
+// SPDX-License-Identifier: GPL-2.0-only
+#include <linux/types.h>
+#include <linux/init.h>
+#include <linux/libfdt.h>
+
+/*
+ * Declare the functions that are exported (but prefixed) here so that LLVM
+ * does not complain it lacks the 'static' keyword (which, if added, makes
+ * LLVM complain because the function is actually unused in this file).
+ */
+u64 get_kaslr_seed(uintptr_t dtb_pa);
+
+u64 get_kaslr_seed(uintptr_t dtb_pa)
+{
+	int node, len;
+	fdt64_t *prop;
+	u64 ret;
+
+	node = fdt_path_offset((void *)dtb_pa, "/chosen");
+	if (node < 0)
+		return 0;
+
+	prop = fdt_getprop_w((void *)dtb_pa, node, "kaslr-seed", &len);
+	if (!prop || len != sizeof(u64))
+		return 0;
+
+	ret = fdt64_to_cpu(*prop);
+	*prop = 0;
+	return ret;
+}
diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
index 747e5b1ef02d..c61269853726 100644
--- a/arch/riscv/mm/init.c
+++ b/arch/riscv/mm/init.c
@@ -1011,11 +1011,45 @@ static void __init pt_ops_set_late(void)
 #endif
 }
 
+#ifdef CONFIG_RANDOMIZE_BASE
+extern bool __init __pi_set_nokaslr_from_cmdline(uintptr_t dtb_pa);
+extern u64 __init __pi_get_kaslr_seed(uintptr_t dtb_pa);
+
+static int __init print_nokaslr(char *p)
+{
+	pr_info("Disabled KASLR");
+	return 0;
+}
+early_param("nokaslr", print_nokaslr);
+
+unsigned long kaslr_offset(void)
+{
+	return kernel_map.virt_offset;
+}
+#endif
+
 asmlinkage void __init setup_vm(uintptr_t dtb_pa)
 {
 	pmd_t __maybe_unused fix_bmap_spmd, fix_bmap_epmd;
 
-	kernel_map.virt_addr = KERNEL_LINK_ADDR;
+#ifdef CONFIG_RANDOMIZE_BASE
+	if (!__pi_set_nokaslr_from_cmdline(dtb_pa)) {
+		u64 kaslr_seed = __pi_get_kaslr_seed(dtb_pa);
+		u32 kernel_size = (uintptr_t)(&_end) - (uintptr_t)(&_start);
+		u32 nr_pos;
+
+		/*
+		 * Compute the number of positions available: we are limited
+		 * by the early page table that only has one PUD and we must
+		 * be aligned on PMD_SIZE.
+		 */
+		nr_pos = (PUD_SIZE - kernel_size) / PMD_SIZE;
+
+		kernel_map.virt_offset = (kaslr_seed % nr_pos) * PMD_SIZE;
+	}
+#endif
+
+	kernel_map.virt_addr = KERNEL_LINK_ADDR + kernel_map.virt_offset;
 	kernel_map.page_offset = _AC(CONFIG_PAGE_OFFSET, UL);
 
 #ifdef CONFIG_XIP_KERNEL
-- 
2.39.2

