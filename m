Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EB62677991
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 11:49:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231918AbjAWKtD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 05:49:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231773AbjAWKsu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 05:48:50 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4897446B1
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 02:48:49 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id d14so6679096wrr.9
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 02:48:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=B8g2lbRRVQxElqC+vhwxvlAd9Yl9IHH5TPADK+PZ98Q=;
        b=2UwllXEV1F4+37rtQa+xgzMqL7ieZGIS5R90acCmnh/NFf54gvz12Z2D7DZRryf2Kw
         5JKxKy+0HL4QeXeBhvERCl4u7ebN29K1u0svY3d4dZO4jmXjDp1HqI9CnJ2qhDE5yCHY
         tL9uxcgeN6euhtF5uxKAzYylIY++cbUzwdhkjLjxQatr+RISnAsFA0CC4HRpJ1ZjoiZE
         R/CK5wbz/6o0W9L3dj7e90x7LSqWtsTh6qDw1Pdut+yByYKO6T4z94ls5LZoCYBr+AFX
         S1ZkPwWZeMLv+dJ4WfkbYXKdbvOsZpYYOa2ioaiChOOymuKDMNc4azdVyMiqDG/GWwxg
         FmiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=B8g2lbRRVQxElqC+vhwxvlAd9Yl9IHH5TPADK+PZ98Q=;
        b=vf04jXSU7rqKt0l+dZYCDdSaaIIZBXqJiJhM6FO+GGYhWIJYa1mduKcTGWyVM1Mjm1
         6BVyWYMf8pzUaJtkVlsh3WAU1vQQoYTsx3YhSXcDq3vf8NPu3et/CL5u/9vYYJ4yM0DG
         57GhBqN4mxc4puC4NAZ+f4+anuyrRBziFdmiA3ta8MoktWAcnSFj2LnyzEOlSzvr99Vy
         QGdnr14Q8/H+9p+2zZeAjaP8LJyrbU0K8wMABH6mSZk4J+B/dZz5xlyCWW8hhBWz5wLT
         D77sakiy50EMIoH/sW+5WtZgySN7jcFMeGAbUGkU8jrWW9TR7IiPVyOOsZGbiZGMdP6F
         xNVg==
X-Gm-Message-State: AFqh2kq8IPqQ0SGDDsWcgXw1eApXI25d3tCckzDVVtROXMYHyqgfBTBG
        ARHxh3TNAbWiWDLStvze5uwjog==
X-Google-Smtp-Source: AMrXdXtsA5psCjwW6D5BLbiw+fn+Rog8dlvoO4malOUPAWvs7qusWFUIgGi3ZiO22gkyt4LV76DJrg==
X-Received: by 2002:adf:ec8d:0:b0:2bd:d7fd:6c93 with SMTP id z13-20020adfec8d000000b002bdd7fd6c93mr20023096wrn.48.1674470927875;
        Mon, 23 Jan 2023 02:48:47 -0800 (PST)
Received: from alex-rivos.ba.rivosinc.com (lfbn-lyo-1-450-160.w2-7.abo.wanadoo.fr. [2.7.42.160])
        by smtp.gmail.com with ESMTPSA id c8-20020a5d4148000000b002bdd21f25ebsm27562327wrq.71.2023.01.23.02.48.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jan 2023 02:48:47 -0800 (PST)
From:   Alexandre Ghiti <alexghiti@rivosinc.com>
To:     Jonathan Corbet <corbet@lwn.net>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Conor Dooley <conor@kernel.org>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Cc:     Alexandre Ghiti <alexghiti@rivosinc.com>,
        =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>
Subject: [PATCH v3] riscv: Allow to downgrade paging mode from the command
Date:   Mon, 23 Jan 2023 11:48:41 +0100
Message-Id: <20230123104841.813999-1-alexghiti@rivosinc.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add 2 early command line parameters that allow to downgrade satp mode
(using the same naming as x86):
- "no5lvl": use a 4-level page table (down from sv57 to sv48)
- "no4lvl": use a 3-level page table (down from sv57/sv48 to sv39)

Note that going through the device tree to get the kernel command line
works with ACPI too since the efi stub creates a device tree anyway with
the command line.

Also, as those params are treated very early in the boot process and we
use standard device tree functions that may be kasan instrumented, we
only enable them for !KASAN configurations.

Reviewed-by: Björn Töpel <bjorn@kernel.org>
Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
---
 .../admin-guide/kernel-parameters.txt         |  9 ++-
 arch/riscv/mm/init.c                          | 72 +++++++++++++++++--
 2 files changed, 74 insertions(+), 7 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 6cfa6e3996cf..fd647412ec91 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -3578,8 +3578,15 @@
 			emulation library even if a 387 maths coprocessor
 			is present.
 
-	no5lvl		[X86-64] Disable 5-level paging mode. Forces
+	no4lvl		[RISCV] Disable 4-level and 5-level paging modes. Forces
+			kernel to use 3-level paging instead.
+			Note: On RISC-V, this can't be used when KASAN is
+			enabled.
+
+	no5lvl		[X86-64,RISCV] Disable 5-level paging mode. Forces
 			kernel to use 4-level paging instead.
+			Note: On RISC-V, this can't be used when KASAN is
+			enabled.
 
 	nofsgsbase	[X86] Disables FSGSBASE instructions.
 
diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
index 478d6763a01a..10f99fa74368 100644
--- a/arch/riscv/mm/init.c
+++ b/arch/riscv/mm/init.c
@@ -746,17 +746,77 @@ static void __init disable_pgtable_l4(void)
 	satp_mode = SATP_MODE_39;
 }
 
+#ifndef CONFIG_KASAN
+static __init bool match_noXlvl(const char *cmdline)
+{
+	if (strstr(cmdline, "no5lvl")) {
+		disable_pgtable_l5();
+	} else if (strstr(cmdline, "no4lvl")) {
+		disable_pgtable_l5();
+		disable_pgtable_l4();
+		return true;
+	}
+
+	return false;
+}
+
+static int __init print_no4lvl(char *p)
+{
+	pr_info("Disabled 4-level and 5-level paging");
+	return 0;
+}
+early_param("no4lvl", print_no4lvl);
+
+static int __init print_no5lvl(char *p)
+{
+	pr_info("Disabled 5-level paging");
+	return 0;
+}
+early_param("no5lvl", print_no5lvl);
+#endif
+
 /*
  * There is a simple way to determine if 4-level is supported by the
  * underlying hardware: establish 1:1 mapping in 4-level page table mode
  * then read SATP to see if the configuration was taken into account
  * meaning sv48 is supported.
  */
-static __init void set_satp_mode(void)
+static __init void set_satp_mode(uintptr_t dtb_pa)
 {
 	u64 identity_satp, hw_satp;
 	uintptr_t set_satp_mode_pmd = ((unsigned long)set_satp_mode) & PMD_MASK;
-	bool check_l4 = false;
+
+#ifndef CONFIG_KASAN
+	/*
+	 * The below fdt functions are kasan instrumented, since at this point
+	 * there is no mapping for the kasan shadow memory, this can't be used
+	 * when kasan is enabled.
+	 */
+	int chosen_node;
+	unsigned int fdt_cmdline_size = 0;
+
+	if (!IS_ENABLED(CONFIG_CMDLINE_FORCE)) {
+		chosen_node = fdt_path_offset((void *)dtb_pa, "/chosen");
+		if (chosen_node >= 0) {
+			const char *fdt_cmdline;
+
+			fdt_cmdline = fdt_getprop((void *)dtb_pa, chosen_node,
+						  "bootargs", NULL);
+			if (fdt_cmdline) {
+				if (match_noXlvl(fdt_cmdline))
+					return;
+				fdt_cmdline_size = strlen(fdt_cmdline);
+			}
+		}
+	}
+
+	if (IS_ENABLED(CONFIG_CMDLINE_EXTEND) ||
+	    IS_ENABLED(CONFIG_CMDLINE_FORCE) ||
+	    fdt_cmdline_size == 0 /* CONFIG_CMDLINE_FALLBACK */) {
+		if (match_noXlvl(CONFIG_CMDLINE))
+			return;
+	}
+#endif
 
 	create_p4d_mapping(early_p4d,
 			set_satp_mode_pmd, (uintptr_t)early_pud,
@@ -775,7 +835,8 @@ static __init void set_satp_mode(void)
 retry:
 	create_pgd_mapping(early_pg_dir,
 			   set_satp_mode_pmd,
-			   check_l4 ? (uintptr_t)early_pud : (uintptr_t)early_p4d,
+			   pgtable_l5_enabled ?
+				(uintptr_t)early_p4d : (uintptr_t)early_pud,
 			   PGDIR_SIZE, PAGE_TABLE);
 
 	identity_satp = PFN_DOWN((uintptr_t)&early_pg_dir) | satp_mode;
@@ -786,9 +847,8 @@ static __init void set_satp_mode(void)
 	local_flush_tlb_all();
 
 	if (hw_satp != identity_satp) {
-		if (!check_l4) {
+		if (pgtable_l5_enabled) {
 			disable_pgtable_l5();
-			check_l4 = true;
 			memset(early_pg_dir, 0, PAGE_SIZE);
 			goto retry;
 		}
@@ -979,7 +1039,7 @@ asmlinkage void __init setup_vm(uintptr_t dtb_pa)
 #endif
 
 #if defined(CONFIG_64BIT) && !defined(CONFIG_XIP_KERNEL)
-	set_satp_mode();
+	set_satp_mode(dtb_pa);
 #endif
 
 	kernel_map.va_pa_offset = PAGE_OFFSET - kernel_map.phys_addr;
-- 
2.37.2

