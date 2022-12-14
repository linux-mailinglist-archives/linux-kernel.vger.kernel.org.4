Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB9AD64CC5A
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 15:33:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238601AbiLNOd2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Dec 2022 09:33:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238517AbiLNOdZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Dec 2022 09:33:25 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CAA423176
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 06:33:24 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id w15so19484400wrl.9
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 06:33:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OuqN6i3xDgWDQgdyvZ62ncqNwC02Nmosxvyp2oT1Vek=;
        b=kA8djj3SxcJzPd/tkyA19nr3VqDPI2W2mU4PabaNpfy0KhdGPok5EOhpPqRRkgHEp7
         UsKlkYzkhjJsubXy7jcirzMdIKXYiXOt1FzNgYnyMhZf2WV901v4IKLYc71zKUWapzXU
         BoJpjUXMGDRMpk2qasc76sLgOIB1gJdRcXp9M+rr+1R43dtYejor15lFhGeG+yivQk1/
         GWsl63/+gB8hodUg9lU56b1NKlQlXMe4xosZ2yPrQCM3Gk4nq2BXfWVb92TW2T0UR1Yy
         CQQRcoIm4tebkW+I57ebyGM7YG72xZ9njf/560IBLB3nCsNqh9b1JfwCSPBLyo5OU0Df
         5y5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OuqN6i3xDgWDQgdyvZ62ncqNwC02Nmosxvyp2oT1Vek=;
        b=qiznIrgLLalVgamIlIXiF8WyW7CqPX3ZgHA0/W89DHWqeADEUnsY1HOmILxPbvfKLp
         65QnNPzZqCXB3B4VUDligrW4k4RHpG3W7JV7smUgnE1uRVnSQ6fEmBMfE6q4mdx82GqR
         RHpVNYuvD+Gdz83efDbUxIEg1XDMrz7I1Aee8hu/gA0XJ/sEuq5Nc4t/Tzc/RGDVN3kj
         IeX9ygrzmafBkrEsrpysAjDLKJ3mL0rc2UrdT2XtjkmsEeQlKjudrbGd1blV5wVEOfSN
         yuUGWIx/MhIRUKog3Yw1iFtuCFiVgnq+o8xWR7WaG8nhC6o8cvDZSu1KFk7m3orAv+MU
         MeHg==
X-Gm-Message-State: ANoB5pnGhBS+OsV6yjCCc/xd/Zxi8JWSsg8L2DJ5Sg6bLdC9BRn0G0bV
        vAIuYlh3TGCIScToJGDWvOKw2w==
X-Google-Smtp-Source: AA0mqf7xIJIgXYZsxK2tSCzIVle8ET5dDH8ooORx5cJ2R6fVlqM69PBiGsZ4kH0G3Q+gQWAxnTgswA==
X-Received: by 2002:adf:f206:0:b0:242:4b69:883 with SMTP id p6-20020adff206000000b002424b690883mr16140492wro.10.1671028403021;
        Wed, 14 Dec 2022 06:33:23 -0800 (PST)
Received: from alex-rivos.ba.rivosinc.com (lfbn-lyo-1-450-160.w2-7.abo.wanadoo.fr. [2.7.42.160])
        by smtp.gmail.com with ESMTPSA id d22-20020a05600c34d600b003cfa80443a0sm2741896wmq.35.2022.12.14.06.33.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Dec 2022 06:33:22 -0800 (PST)
From:   Alexandre Ghiti <alexghiti@rivosinc.com>
To:     Jonathan Corbet <corbet@lwn.net>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Cc:     Alexandre Ghiti <alexghiti@rivosinc.com>
Subject: [PATCH] riscv: Allow to downgrade paging mode from the command line
Date:   Wed, 14 Dec 2022 15:33:11 +0100
Message-Id: <20221214143311.960266-1-alexghiti@rivosinc.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
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

Tested on both DT/ACPI kernel successfully

 .../admin-guide/kernel-parameters.txt         |  5 ++-
 arch/riscv/mm/init.c                          | 43 ++++++++++++++++++-
 2 files changed, 45 insertions(+), 3 deletions(-)

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
index b56a0a75533f..8140fefe0e57 100644
--- a/arch/riscv/mm/init.c
+++ b/arch/riscv/mm/init.c
@@ -752,12 +752,35 @@ static void __init disable_pgtable_l4(void)
  * then read SATP to see if the configuration was taken into account
  * meaning sv48 is supported.
  */
-static __init void set_satp_mode(void)
+static __init void set_satp_mode(uintptr_t dtb_pa)
 {
 	u64 identity_satp, hw_satp;
 	uintptr_t set_satp_mode_pmd = ((unsigned long)set_satp_mode) & PMD_MASK;
 	bool check_l4 = false;
 
+#ifndef CONFIG_KASAN
+	/*
+	 * The below fdt functions are kasan instrumented, since at this point
+	 * there is no mapping for the kasan shadow memory, this can't be used
+	 * when kasan is enabled.
+	 */
+	int chosen_node;
+
+	chosen_node = fdt_path_offset((void *)dtb_pa, "/chosen");
+	if (chosen_node >= 0) {
+		const char *cmdline = fdt_getprop((void *)dtb_pa, chosen_node,
+						  "bootargs", NULL);
+		if (strstr(cmdline, "no5lvl")) {
+			disable_pgtable_l5();
+			check_l4 = true;
+		} else if (strstr(cmdline, "no4lvl")) {
+			disable_pgtable_l5();
+			disable_pgtable_l4();
+			return;
+		}
+	}
+#endif
+
 	create_p4d_mapping(early_p4d,
 			set_satp_mode_pmd, (uintptr_t)early_pud,
 			P4D_SIZE, PAGE_TABLE);
@@ -800,6 +823,22 @@ static __init void set_satp_mode(void)
 	memset(early_pud, 0, PAGE_SIZE);
 	memset(early_pmd, 0, PAGE_SIZE);
 }
+
+#ifndef CONFIG_KASAN
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
 #endif
 
 /*
@@ -979,7 +1018,7 @@ asmlinkage void __init setup_vm(uintptr_t dtb_pa)
 #endif
 
 #if defined(CONFIG_64BIT) && !defined(CONFIG_XIP_KERNEL)
-	set_satp_mode();
+	set_satp_mode(dtb_pa);
 #endif
 
 	kernel_map.va_pa_offset = PAGE_OFFSET - kernel_map.phys_addr;
-- 
2.37.2

