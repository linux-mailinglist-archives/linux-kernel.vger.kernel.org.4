Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB5EE64D7A6
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 09:20:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229635AbiLOIT7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 03:19:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229676AbiLOITz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 03:19:55 -0500
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F0BB1E73B
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 00:19:54 -0800 (PST)
Received: by mail-wm1-x342.google.com with SMTP id h8-20020a1c2108000000b003d1efd60b65so1169298wmh.0
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 00:19:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=P5JatZUrB4wn6RHIEmLRs1De+PDGwMqcpJtj1hMpn28=;
        b=JLzjunRNOInwlypF9TQNBJoNGaay7JWcNf7YoQGqGXE60pbfIWK4g6E87kqaTlNEjX
         QYWw/I0p6xgHoTGol6FiQPq9nTnuTvFo2YLnBTUg5Ueb5OYw4a8ptZQQTNH7k2Fp3YhD
         npDLW5SBQ5HkMKkUA8u2VTSA1gi+lAkedt2CugVww2Eze30/Pmfi+1tCa5dpR610Yter
         uauMBuCIAdvh+JMFerv+vRM5FDaeSnHgU/XEyIR0kuVkuCIsqJi+Smi0sL2Wb8m6GZ/b
         Uq44xe1xMFDjbmCpGCYxjhjsgdPl3K5A7Kfkec34CCBAFu4a0SBQKbD4NBulirE5Hduj
         A9TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=P5JatZUrB4wn6RHIEmLRs1De+PDGwMqcpJtj1hMpn28=;
        b=OqQkTW8Rhot8KGgsjR0LikMnMw6H+ASSwHlacATothLjks4SNkwK17yCbf23TgizMQ
         XH7f6ceEJ4+LxL8YZjctF7Giyzlb0booSFDuEybJPnjrKcFeE5Jtjn4UQ9SXjDOFil6s
         1domIC9yJnSQjiQ1r/ao0R3strwXQyFoi18Vv2UcolDHd+qvxhhkxI4uS3uQJlHxekXg
         OEANSsF0Mp0oq2ciuABn341qywOx/T4/KfYQC7tGQ1RKGTde91nx3vypJ2TjrvR4Le0w
         X9mDSxI18ODNCknxqSXaMJlh+2puDytscCgWtU2ALT98G1AtQnNPZuM3RmCpNgEh6Scy
         /5QQ==
X-Gm-Message-State: ANoB5pkpyk4Bc3TuZYCsvCkhU1nUAkfB37KmNP+T07/0qgI/kzUxR64C
        7sZk+DXTHVxYvbhS3WyVCz2zRQ==
X-Google-Smtp-Source: AA0mqf5WjGshX/H4Sy5tMFHvg73SLxcJk240JuKos8U0A2iaj5qoJywpDAzH4oFnYFIYMozh6bDxPQ==
X-Received: by 2002:a7b:ce89:0:b0:3d2:3be4:2d9a with SMTP id q9-20020a7bce89000000b003d23be42d9amr3967121wmj.20.1671092392702;
        Thu, 15 Dec 2022 00:19:52 -0800 (PST)
Received: from alex-rivos.ba.rivosinc.com (lfbn-lyo-1-450-160.w2-7.abo.wanadoo.fr. [2.7.42.160])
        by smtp.gmail.com with ESMTPSA id f9-20020a05600c154900b003b49bd61b19sm1615436wmg.15.2022.12.15.00.19.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Dec 2022 00:19:52 -0800 (PST)
From:   Alexandre Ghiti <alexghiti@rivosinc.com>
To:     Jonathan Corbet <corbet@lwn.net>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org
Cc:     Alexandre Ghiti <alexghiti@rivosinc.com>
Subject: [PATCH v2] riscv: Allow to downgrade paging mode from the command line
Date:   Thu, 15 Dec 2022 09:19:48 +0100
Message-Id: <20221215081948.1256610-1-alexghiti@rivosinc.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add 2 early command line parameters called "no5lvl" and "no4lvl" (using
the same naming as x86) to allow a user to downgrade from sv57 (the
default mode if the hardware supports it) to sv48 or sv39.

Note that going through the device tree to get the kernel command line
works with ACPI too since the efi stub creates a device tree anyway with
the command line.

Also, as those params are treated very early in the boot process and we
use standard device tree functions that may be kasan instrumented, we
only enable them for !KASAN configurations.

Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
---

v2:
- Honor CMDLINE_EXTEND and CMDLINE_FORCE as noticed by Björn

 .../admin-guide/kernel-parameters.txt         |  5 +-
 arch/riscv/mm/init.c                          | 72 +++++++++++++++++--
 2 files changed, 70 insertions(+), 7 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index a465d5242774..6741524aa980 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -3548,7 +3548,10 @@
 			emulation library even if a 387 maths coprocessor
 			is present.
 
-	no5lvl		[X86-64] Disable 5-level paging mode. Forces
+	no4lvl		[RISCV] Disable 4-level paging mode. Forces
+			kernel to use 3-level paging instead.
+
+	no5lvl		[X86-64,RISCV] Disable 5-level paging mode. Forces
 			kernel to use 4-level paging instead.
 
 	nofsgsbase	[X86] Disables FSGSBASE instructions.
diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
index b56a0a75533f..d90fbe9ad494 100644
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

