Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B656748323
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 13:45:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231466AbjGELpB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 07:45:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231561AbjGELo5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 07:44:57 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD4A01981
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jul 2023 04:44:53 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id 98e67ed59e1d1-262dc1ced40so4739072a91.3
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jul 2023 04:44:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1688557493; x=1691149493;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vxuPbxVgF3zfcM/BRF/LLNBZgbT5czHHRuVcSzACvZ4=;
        b=USieFHEI7eCXkkZlxw91812OEPriTznOhYAAyi2cXQlf49JdMjM71QTNZhPXsv+nhz
         qj4BRAuXZjJzjZvy0kzeIKh5Hlmy5UmwfmwNgsyAbOWDZkARdCb/7bjGCHW+BaBbgZGt
         vr9aZZfYLHoDEDPC4mmRW8/GdKX7beelO5Vz4Ex2zA1yD90Qmut/5ZtmWcOo8PTfUPV/
         9wMTOaufrebObZG2kdeeHjoZ4dVZGvqSHK/p3ChlcMXQNJEjW3SUkAXyGAlYSNlUTWhd
         c9vbIApSePRVpayGJIb4QKHu377JeUxTSSiobs63TsC7Vbfo079dl4/ZzfesOMe4QhJe
         4o6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688557493; x=1691149493;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vxuPbxVgF3zfcM/BRF/LLNBZgbT5czHHRuVcSzACvZ4=;
        b=NQcrTWdLK/K5yZkbjSok1twjHMqnXbAsOxG2lN36mTBZz4azDb2jTJLdqMHQ6M1w0/
         4moWH+9aaHMrMQpml+8k5s7eh/RMkifdpW4EE3x7lKavnL+stbHXUaeuKmVPngUr/aC9
         b4ZXuOl09uuIUTf4pb0FG+1/cGIY6MDoVHgVvdMERb723lM8T0PThFNIe4jD1n2wgFcG
         NmXrmuvzC4MfbIVyfTs8p9fLXnHnDDqGiZNAfo0eTqaN3zMnzbfsn4n/Td/44/HFIBEd
         TX8QXRDE8XfhrMnh8n+KkmooUYPJysORfz2Yj4oNzUQkcr81YRNeKt4EPbQtRXWoFJq2
         7/FA==
X-Gm-Message-State: ABy/qLYIF3AQ4XzS+GJqAsbQmzev27ssanmQYP8eq2pYMCpzzhuBZk4F
        lAvYVM1oAMYNXa7QV1wGO3Q/sg==
X-Google-Smtp-Source: APBJJlGR3P54rhDcdlAlLclU9MYRdR5Ld0I3S9zquD63eupWzYEBKVWsWxUQA1BhQ1YV526dFMH7KQ==
X-Received: by 2002:a17:90a:54:b0:261:113e:50d2 with SMTP id 20-20020a17090a005400b00261113e50d2mr16503592pjb.31.1688557493100;
        Wed, 05 Jul 2023 04:44:53 -0700 (PDT)
Received: from PF2E59YH-BKX.inc.bytedance.com ([61.213.176.5])
        by smtp.gmail.com with ESMTPSA id 3-20020a17090a194300b00263f6687690sm1177900pjh.18.2023.07.05.04.44.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jul 2023 04:44:52 -0700 (PDT)
From:   Yunhui Cui <cuiyunhui@bytedance.com>
To:     conor@kernel.org, sunilvl@ventanamicro.com, ardb@kernel.org,
        palmer@dabbelt.com, paul.walmsley@sifive.com,
        aou@eecs.berkeley.edu, linux-riscv@lists.infradead.org,
        rminnich@gmail.com, mark.rutland@arm.com, lpieralisi@kernel.org,
        rafael@kernel.org, lenb@kernel.org, jdelvare@suse.com,
        yc.hung@mediatek.com, angelogioacchino.delregno@collabora.com,
        allen-kh.cheng@mediatek.com, pierre-louis.bossart@linux.intel.com,
        tinghan.shen@mediatek.com, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org, geshijian@bytedance.com,
        weidong.wd@bytedance.com, cuiyunhui@bytedance.com
Subject: [PATCH v3 2/4] firmware: introduce FFI for SMBIOS entry
Date:   Wed,  5 Jul 2023 19:42:49 +0800
Message-Id: <20230705114251.661-3-cuiyunhui@bytedance.com>
X-Mailer: git-send-email 2.37.3.windows.1
In-Reply-To: <20230705114251.661-1-cuiyunhui@bytedance.com>
References: <20230705114251.661-1-cuiyunhui@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To enable DMI functionality on platforms where the bootloader
does not support EFI and the architecture does not support
reserved addresses.

Add a "ffitbl" device tree node to find the SMBIOS entry
point and use wire up dmi_scan_machine().This feature is
known as the FDT Firmware Interface (FFI).

Signed-off-by: Yunhui Cui <cuiyunhui@bytedance.com>
---
 MAINTAINERS                 |  6 +++
 drivers/firmware/Kconfig    | 11 +++++
 drivers/firmware/Makefile   |  1 +
 drivers/firmware/dmi_scan.c | 97 ++++++++++++++++++++++---------------
 drivers/firmware/ffi.c      | 42 ++++++++++++++++
 include/linux/ffi.h         | 29 +++++++++++
 6 files changed, 146 insertions(+), 40 deletions(-)
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
index b59e3041fd62..3579d9bc22ff 100644
--- a/drivers/firmware/Kconfig
+++ b/drivers/firmware/Kconfig
@@ -303,6 +303,17 @@ config TURRIS_MOX_RWTM
 	  other manufacturing data and also utilize the Entropy Bit Generator
 	  for hardware random number generation.
 
+config FDT_FW_INTERFACE
+	bool "An interface for passing firmware info through FDT"
+	depends on OF && OF_FLATTREE
+	default n
+	help
+	 Enable this option to support the transfer of firmware information,
+	 such as smbios tables, for bootloaders that do not support EFI, such
+	 as coreboot.
+
+	 Say Y here if you want to transfer firmware information by FDT.
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
index 015c95a825d3..c29ea050b5b9 100644
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
@@ -655,54 +656,70 @@ static int __init dmi_smbios3_present(const u8 *buf)
 	return 1;
 }
 
-static void __init dmi_scan_machine(void)
+/*
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
+ */
+static int __init dmi_sacn_smbios(unsigned long smbios3, unsigned long smbios)
 {
-	char __iomem *p, *q;
+	char __iomem *p;
 	char buf[32];
-
-	if (efi_enabled(EFI_CONFIG_TABLES)) {
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
-			goto error;
-
-		/* This is called as a core_initcall() because it isn't
-		 * needed during early boot.  This also means we can
-		 * iounmap the space when we're done with it.
-		 */
-		p = dmi_early_remap(efi.smbios, 32);
+	#define INVALID_TABLE_ADDR (~0UL)
+	if (smbios3 != INVALID_TABLE_ADDR) {
+		p = dmi_early_remap(smbios3, 32);
 		if (p == NULL)
-			goto error;
+			return -1;
 		memcpy_fromio(buf, p, 32);
 		dmi_early_unmap(p, 32);
 
-		if (!dmi_present(buf)) {
+		if (!dmi_smbios3_present(buf)) {
 			dmi_available = 1;
-			return;
+			return 0;
 		}
+	}
+	if (smbios == INVALID_TABLE_ADDR)
+		return -1;
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
+
+	return -1;
+}
+
+static void __init dmi_scan_machine(void)
+{
+	char __iomem *p, *q;
+	char buf[32];
+
+	if (ffi_enabled(FFI_CONFIG_TABLES)) {
+		if (!dmi_sacn_smbios(ffi.smbios3, ffi.smbios))
+			return;
+	}
+
+	if (efi_enabled(EFI_CONFIG_TABLES)) {
+		if (dmi_sacn_smbios(efi.smbios3, efi.smbios))
+			goto error;
 	} else if (IS_ENABLED(CONFIG_DMI_SCAN_MACHINE_NON_EFI_FALLBACK)) {
 		p = dmi_early_remap(SMBIOS_ENTRY_POINT_SCAN_START, 0x10000);
 		if (p == NULL)
diff --git a/drivers/firmware/ffi.c b/drivers/firmware/ffi.c
new file mode 100644
index 000000000000..d4994a22438b
--- /dev/null
+++ b/drivers/firmware/ffi.c
@@ -0,0 +1,42 @@
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
+
+void __init ffi_smbios_root_pointer(void)
+{
+	u32 ffitbl, smbios, len, ver;
+	u64 entry;
+	fdt64_t *prop;
+
+	ffitbl = fdt_subnode_offset(initial_boot_params, 0, "ffitbl");
+	smbios = fdt_subnode_offset(initial_boot_params, ffitbl, "smbios");
+	prop = fdt_getprop_w(initial_boot_params, smbios, "entry", &len);
+	if (!prop || len != sizeof(u64)) {
+		pr_debug("smbios entry not found.\n");
+		return;
+	}
+	entry = fdt64_to_cpu(*prop);
+
+	prop = fdt_getprop_w(initial_boot_params, smbios, "reg", &len);
+	if (!prop || len != sizeof(u32)) {
+		pr_debug("smbios reg not found.\n");
+		return;
+	}
+	ver = fdt32_to_cpu(*prop);
+	(ver == 3) ? (ffi.smbios3 = entry) : (ffi.smbios = entry);
+	set_bit(FFI_CONFIG_TABLES, &ffi.flags);
+	pr_debug("smbios%d entry: %llx\n", ver, entry);
+}
+
diff --git a/include/linux/ffi.h b/include/linux/ffi.h
new file mode 100644
index 000000000000..a99c2a290556
--- /dev/null
+++ b/include/linux/ffi.h
@@ -0,0 +1,29 @@
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
+#define FFI_CONFIG_TABLES	2	/* Can we use FFI config tables? */
+
+#ifdef CONFIG_FDT_FW_INTERFACE
+extern void ffi_smbios_root_pointer(void);
+static inline bool ffi_enabled(int feature)
+{
+	return test_bit(feature, &ffi.flags) != 0;
+}
+#else
+static inline bool ffi_enabled(int feature)
+{
+	return false;
+}
+void ffi_smbios_root_pointer(void) { return; };
+#endif
+
+#endif /* _LINUX_FFI_H */
-- 
2.20.1

