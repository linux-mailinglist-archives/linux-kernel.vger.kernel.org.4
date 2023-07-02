Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6B1D744D21
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jul 2023 11:58:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229959AbjGBJ6d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Jul 2023 05:58:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229914AbjGBJ62 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jul 2023 05:58:28 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D145E6F
        for <linux-kernel@vger.kernel.org>; Sun,  2 Jul 2023 02:58:03 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-666fb8b1bc8so2898573b3a.1
        for <linux-kernel@vger.kernel.org>; Sun, 02 Jul 2023 02:58:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1688291883; x=1690883883;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HYya50tJlu2Jrm7C5TXSsOJP4LQItfiIbIJ4JgEwpvU=;
        b=dzNuDndr8OWQUYpcU4HBzRoL+dFRpF38ULyIKffCwwmFwEkqZUg68qO63QTl2NQyjm
         l2xUZLlLcqNHMuPSoLs1p4guToErWKm36lUkbve/lgDYYHao3X9Dtr3t+FJS7J3UAf0A
         zOfPjY2zeKIkh5UNg9OhPcRuECi0coMOY4qxPoOtIywALalB/NB/IOm8Lnv2hF/GRXN/
         Gywkv9Pe7pmsqYQYqbbGPfgz2HidIpRStPKtO1uoYCvht0hi0HbBi3EZz192GmZ5vnCC
         Q9aBUBY8238CSLdJntuG4ABygKt3itorUNa5c6juQBqnAQ5NMA9GApqvXEYJlSclb5yI
         ePvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688291883; x=1690883883;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HYya50tJlu2Jrm7C5TXSsOJP4LQItfiIbIJ4JgEwpvU=;
        b=bIAOEDeY+T95ghZjj7SuTsfcgOoRDdgGEb/F7UdVW8PoKNA+Yj9yA2vRoZw2CxBzl0
         ugLFfPAk0XzhM4INkOdL8GgTn5FJBpEXbHrrQZW4yz0RoArKHhYJia1qpmFaUEW30u18
         enMn2e6LnF7ihFiS8ia1nN/33wkYWGzvFMOcS+3UJgFk2rhu5j7zwTG+ZCx5ygp7ucLO
         DXsLhRc194Av8uuslr5VHiWXMPzHnn740JOJXXwT84nYcj8ivU3E94WzfizuzVy5uCLa
         oly6gUEPV/Ul6hVdc7DajobC/Mw5P4P0L/q+lMcA2nXLvnrMThgOh1kS80p5h1n8YMiM
         Tk4Q==
X-Gm-Message-State: ABy/qLa9KxsXbXm/Na7GWxPMuq/zIuFLo7tKe33+duoo9vuFj5h+5Io0
        y0t0wy++LBl2pA8kBKOIRoxJLw==
X-Google-Smtp-Source: APBJJlFlQxumS1ONslw4qPitjTJdc8b7vX961ozrSCLVfevwcHg41jW+SnpRdwMB5I70RzXkqLlreA==
X-Received: by 2002:a05:6a20:6a22:b0:12e:6ba3:1f6f with SMTP id p34-20020a056a206a2200b0012e6ba31f6fmr963985pzk.23.1688291882787;
        Sun, 02 Jul 2023 02:58:02 -0700 (PDT)
Received: from PF2E59YH-BKX.inc.bytedance.com ([139.177.225.251])
        by smtp.gmail.com with ESMTPSA id u26-20020a62ed1a000000b006827d86ca0csm1605095pfh.55.2023.07.02.02.57.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Jul 2023 02:58:02 -0700 (PDT)
From:   Yunhui Cui <cuiyunhui@bytedance.com>
To:     ardb@kernel.org, palmer@dabbelt.com, paul.walmsley@sifive.com,
        aou@eecs.berkeley.edu, linux-riscv@lists.infradead.org,
        rminnich@gmail.com, mark.rutland@arm.com, lpieralisi@kernel.org,
        rafael@kernel.org, lenb@kernel.org, jdelvare@suse.com,
        yc.hung@mediatek.com, angelogioacchino.delregno@collabora.com,
        allen-kh.cheng@mediatek.com, pierre-louis.bossart@linux.intel.com,
        tinghan.shen@mediatek.com, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org, geshijian@bytedance.com,
        weidong.wd@bytedance.com, cuiyunhui@bytedance.com
Subject: [PATCH v2 2/3] firmware: introduce FFI for SMBIOS entry.
Date:   Sun,  2 Jul 2023 17:57:33 +0800
Message-Id: <20230702095735.860-2-cuiyunhui@bytedance.com>
X-Mailer: git-send-email 2.37.3.windows.1
In-Reply-To: <20230702095735.860-1-cuiyunhui@bytedance.com>
References: <20230702095735.860-1-cuiyunhui@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

1. Some bootloaders do not support EFI, and the transfer of
firmware information can only be done through DTS,
such as Coreboot.

2. Some arches do not have a reserved address segment that
can be used to pass firmware parameters like x86.

3. Based on this, we have added an interface to obtain firmware
information through FDT, named FFI.

4. We not only use FFI to pass SMBIOS entry,
but also pass other firmware information as an extension.

Signed-off-by: Yunhui Cui <cuiyunhui@bytedance.com>
---
 MAINTAINERS                 |   6 ++
 drivers/firmware/Kconfig    |  11 ++++
 drivers/firmware/Makefile   |   1 +
 drivers/firmware/dmi_scan.c | 128 +++++++++++++++++-------------------
 drivers/firmware/ffi.c      |  36 ++++++++++
 include/linux/ffi.h         |  15 +++++
 6 files changed, 128 insertions(+), 69 deletions(-)
 create mode 100644 drivers/firmware/ffi.c
 create mode 100644 include/linux/ffi.h

diff --git a/MAINTAINERS b/MAINTAINERS
index e592f489e757..9b886ef36587 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7871,6 +7871,12 @@ F:	arch/x86/platform/efi/
 F:	drivers/firmware/efi/
 F:	include/linux/efi*.h
 
+FDT FIRMWARE INTERFACE (FFI)
+M:	Yunhui Cui cuiyunhui@bytedance.com
+S:	Maintained
+F:	drivers/firmware/ffi.c
+F:	include/linux/ffi.h
+
 EXTERNAL CONNECTOR SUBSYSTEM (EXTCON)
 M:	MyungJoo Ham <myungjoo.ham@samsung.com>
 M:	Chanwoo Choi <cw00.choi@samsung.com>
diff --git a/drivers/firmware/Kconfig b/drivers/firmware/Kconfig
index b59e3041fd62..ea0149fb4683 100644
--- a/drivers/firmware/Kconfig
+++ b/drivers/firmware/Kconfig
@@ -303,6 +303,17 @@ config TURRIS_MOX_RWTM
 	  other manufacturing data and also utilize the Entropy Bit Generator
 	  for hardware random number generation.
 
+config FDT_FW_INTERFACE
+       bool "An interface for passing firmware info through FDT"
+       depends on OF && OF_FLATTREE
+       default n
+       help
+         When some bootloaders do not support EFI, and the arch does not
+         support SMBIOS_ENTRY_POINT_SCAN_START, then you can enable this option
+         to support the transfer of firmware information, such as smbios tables.
+
+         Say Y here if you want to pass firmware information by FDT.
+
 source "drivers/firmware/arm_ffa/Kconfig"
 source "drivers/firmware/broadcom/Kconfig"
 source "drivers/firmware/cirrus/Kconfig"
diff --git a/drivers/firmware/Makefile b/drivers/firmware/Makefile
index 28fcddcd688f..3b8b5d0868a6 100644
--- a/drivers/firmware/Makefile
+++ b/drivers/firmware/Makefile
@@ -33,6 +33,7 @@ obj-y				+= cirrus/
 obj-y				+= meson/
 obj-$(CONFIG_GOOGLE_FIRMWARE)	+= google/
 obj-y				+= efi/
+obj-$(CONFIG_FDT_FW_INTERFACE)	+= ffi.o
 obj-y				+= imx/
 obj-y				+= psci/
 obj-y				+= smccc/
diff --git a/drivers/firmware/dmi_scan.c b/drivers/firmware/dmi_scan.c
index 015c95a825d3..64c1ceffe373 100644
--- a/drivers/firmware/dmi_scan.c
+++ b/drivers/firmware/dmi_scan.c
@@ -6,6 +6,7 @@
 #include <linux/ctype.h>
 #include <linux/dmi.h>
 #include <linux/efi.h>
+#include <linux/ffi.h>
 #include <linux/memblock.h>
 #include <linux/random.h>
 #include <asm/dmi.h>
@@ -628,31 +629,56 @@ static int __init dmi_present(const u8 *buf)
 }
 
 /*
- * Check for the SMBIOS 3.0 64-bit entry point signature. Unlike the legacy
- * 32-bit entry point, there is no embedded DMI header (_DMI_) in here.
+ * According to the DMTF SMBIOS reference spec v3.0.0, it is
+ * allowed to define both the 64-bit entry point (smbios3) and
+ * the 32-bit entry point (smbios), in which case they should
+ * either both point to the same SMBIOS structure table, or the
+ * table pointed to by the 64-bit entry point should contain a
+ * superset of the table contents pointed to by the 32-bit entry
+ * point (section 5.2)
+ * This implies that the 64-bit entry point should have
+ * precedence if it is defined and supported by the OS. If we
+ * have the 64-bit entry point, but fail to decode it, fall
+ * back to the legacy one (if available)
  */
-static int __init dmi_smbios3_present(const u8 *buf)
+static int __init dmi_sacn_smbios(unsigned long smbios3, unsigned long smbios)
 {
-	if (memcmp(buf, "_SM3_", 5) == 0 &&
-	    buf[6] >= 24 && buf[6] <= 32 &&
-	    dmi_checksum(buf, buf[6])) {
-		dmi_ver = get_unaligned_be24(buf + 7);
-		dmi_num = 0;			/* No longer specified */
-		dmi_len = get_unaligned_le32(buf + 12);
-		dmi_base = get_unaligned_le64(buf + 16);
-		smbios_entry_point_size = buf[6];
-		memcpy(smbios_entry_point, buf, smbios_entry_point_size);
+	char __iomem *p;
+	char buf[32];
+	#define INVALID_TABLE_ADDR (~0UL)
 
-		if (dmi_walk_early(dmi_decode) == 0) {
-			pr_info("SMBIOS %d.%d.%d present.\n",
-				dmi_ver >> 16, (dmi_ver >> 8) & 0xFF,
-				dmi_ver & 0xFF);
-			dmi_format_ids(dmi_ids_string, sizeof(dmi_ids_string));
-			pr_info("DMI: %s\n", dmi_ids_string);
+	if (smbios3 != INVALID_TABLE_ADDR) {
+		p = dmi_early_remap(smbios3, 32);
+		if (p == NULL)
+			return -1;
+		memcpy_fromio(buf, p, 32);
+		dmi_early_unmap(p, 32);
+
+		if (!dmi_smbios3_present(buf)) {
+			dmi_available = 1;
 			return 0;
 		}
 	}
-	return 1;
+
+	if (smbios == INVALID_TABLE_ADDR)
+		return -1;
+
+	/*
+	 * This is called as a core_initcall() because it isn't
+	 * needed during early boot.  This also means we can
+	 * iounmap the space when we're done with it.
+	 */
+	p = dmi_early_remap(smbios, 32);
+	if (p == NULL)
+		return -1;
+	memcpy_fromio(buf, p, 32);
+	dmi_early_unmap(p, 32);
+
+	if (!dmi_present(buf)) {
+		dmi_available = 1;
+		return 0;
+	}
+	return -1;
 }
 
 static void __init dmi_scan_machine(void)
@@ -660,58 +686,22 @@ static void __init dmi_scan_machine(void)
 	char __iomem *p, *q;
 	char buf[32];
 
+#ifdef CONFIG_FDT_FW_INTERFACE
+	if (dmi_sacn_smbios(ffi.smbios3, ffi.smbios))
+		goto error;
+#endif
 	if (efi_enabled(EFI_CONFIG_TABLES)) {
-		/*
-		 * According to the DMTF SMBIOS reference spec v3.0.0, it is
-		 * allowed to define both the 64-bit entry point (smbios3) and
-		 * the 32-bit entry point (smbios), in which case they should
-		 * either both point to the same SMBIOS structure table, or the
-		 * table pointed to by the 64-bit entry point should contain a
-		 * superset of the table contents pointed to by the 32-bit entry
-		 * point (section 5.2)
-		 * This implies that the 64-bit entry point should have
-		 * precedence if it is defined and supported by the OS. If we
-		 * have the 64-bit entry point, but fail to decode it, fall
-		 * back to the legacy one (if available)
-		 */
-		if (efi.smbios3 != EFI_INVALID_TABLE_ADDR) {
-			p = dmi_early_remap(efi.smbios3, 32);
-			if (p == NULL)
-				goto error;
-			memcpy_fromio(buf, p, 32);
-			dmi_early_unmap(p, 32);
-
-			if (!dmi_smbios3_present(buf)) {
-				dmi_available = 1;
-				return;
-			}
-		}
-		if (efi.smbios == EFI_INVALID_TABLE_ADDR)
+		if (dmi_sacn_smbios(efi.smbios3, efi.smbios))
 			goto error;
-
-		/* This is called as a core_initcall() because it isn't
-		 * needed during early boot.  This also means we can
-		 * iounmap the space when we're done with it.
-		 */
-		p = dmi_early_remap(efi.smbios, 32);
-		if (p == NULL)
-			goto error;
-		memcpy_fromio(buf, p, 32);
-		dmi_early_unmap(p, 32);
-
-		if (!dmi_present(buf)) {
-			dmi_available = 1;
-			return;
-		}
 	} else if (IS_ENABLED(CONFIG_DMI_SCAN_MACHINE_NON_EFI_FALLBACK)) {
 		p = dmi_early_remap(SMBIOS_ENTRY_POINT_SCAN_START, 0x10000);
 		if (p == NULL)
 			goto error;
 
 		/*
-		 * Same logic as above, look for a 64-bit entry point
-		 * first, and if not found, fall back to 32-bit entry point.
-		 */
+		* Same logic as above, look for a 64-bit entry point
+		* first, and if not found, fall back to 32-bit entry point.
+		*/
 		memcpy_fromio(buf, p, 16);
 		for (q = p + 16; q < p + 0x10000; q += 16) {
 			memcpy_fromio(buf + 16, q, 16);
@@ -724,12 +714,12 @@ static void __init dmi_scan_machine(void)
 		}
 
 		/*
-		 * Iterate over all possible DMI header addresses q.
-		 * Maintain the 32 bytes around q in buf.  On the
-		 * first iteration, substitute zero for the
-		 * out-of-range bytes so there is no chance of falsely
-		 * detecting an SMBIOS header.
-		 */
+		* Iterate over all possible DMI header addresses q.
+		* Maintain the 32 bytes around q in buf.  On the
+		* first iteration, substitute zero for the
+		* out-of-range bytes so there is no chance of falsely
+		* detecting an SMBIOS header.
+		*/
 		memset(buf, 0, 16);
 		for (q = p; q < p + 0x10000; q += 16) {
 			memcpy_fromio(buf + 16, q, 16);
diff --git a/drivers/firmware/ffi.c b/drivers/firmware/ffi.c
new file mode 100644
index 000000000000..169802b4a7a8
--- /dev/null
+++ b/drivers/firmware/ffi.c
@@ -0,0 +1,36 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
+#include <linux/of.h>
+#include <linux/of_fdt.h>
+#include <linux/libfdt.h>
+#include <linux/ffi.h>
+
+#define FFI_INVALID_TABLE_ADDR	(~0UL)
+
+struct ffi __read_mostly ffi = {
+	.smbios	= FFI_INVALID_TABLE_ADDR,
+	.smbios3 = FFI_INVALID_TABLE_ADDR,
+};
+EXPORT_SYMBOL(ffi);
+
+void __init ffi_smbios_root_pointer(void)
+{
+	int cfgtbl, len;
+	fdt64_t *prop;
+
+	cfgtbl = fdt_path_offset(initial_boot_params, "/cfgtables");
+	if (cfgtbl < 0) {
+		pr_info("firmware table not found.\n");
+		return;
+	}
+	prop = fdt_getprop_w(initial_boot_params, cfgtbl, "smbios_phy_ptr", &len);
+	if (!prop || len != sizeof(u64))
+		pr_info("smbios entry point not found.\n");
+	else
+		ffi.smbios = fdt64_to_cpu(*prop);
+
+	pr_info("smbios root pointer: %lx\n", ffi.smbios);
+}
+
diff --git a/include/linux/ffi.h b/include/linux/ffi.h
new file mode 100644
index 000000000000..95298a805222
--- /dev/null
+++ b/include/linux/ffi.h
@@ -0,0 +1,15 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifndef _LINUX_FFI_H
+#define _LINUX_FFI_H
+
+extern struct ffi {
+	unsigned long smbios;  /* SMBIOS table (32 bit entry point) */
+	unsigned long smbios3;  /* SMBIOS table (64 bit entry point) */
+	unsigned long flags;
+
+} ffi;
+
+void ffi_smbios_root_pointer(void);
+
+#endif /* _LINUX_FFI_H */
-- 
2.20.1

