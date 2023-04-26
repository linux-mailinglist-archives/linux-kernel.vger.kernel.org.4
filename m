Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 437B26EECC9
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 05:41:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239309AbjDZDlF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 23:41:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239221AbjDZDlD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 23:41:03 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE8A01B0
        for <linux-kernel@vger.kernel.org>; Tue, 25 Apr 2023 20:40:35 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id 41be03b00d2f7-517bdc9e81dso3903052a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Apr 2023 20:40:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1682480435; x=1685072435;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=MB0F5jxYkAhcPVkn3n03bs7ZNVNCxQMTXaIwIWVwASw=;
        b=jHSfh0N8LMx5Z+NmczrE6U1m9vgkshHmeZHwOkIC4kRQOKex9Zm6pbgesdU2k0KzqI
         tbJ07MaNQ5xkNEsJsofw4ptBZVguCR8egH87ZWppynn8oqhRNy8mKmYe1K2yr4KsArPm
         tpOCpb+3dGWFo3I90Frd194pSDOdYAtXWHHszlct3kXLMkvI/ChZwM7Kp8JGihmPBv5l
         jq0yT1tBdTQI4rgepBim/6QSkCAbmFbC2N4gXrXPfXjZ6GuIg3bynWNy0pmyYYJYBa3o
         vLFeTflDm8xeFUDPl2CmfPKjxmpkj2pkKf12pIrHXHIOXyo3iZBNw3G2uWCD4Lx6obee
         nrPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682480435; x=1685072435;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MB0F5jxYkAhcPVkn3n03bs7ZNVNCxQMTXaIwIWVwASw=;
        b=ZE5MxuOaxMpmfEIv72yn+DfJY2sa36KVPdK0CB4rIQuIGRO9vcNukp43mPF6sPaMCK
         qqKUqB7V4UmMdUHztg96mEM95h+P98ukpd9BsNFko477pHxRJRoaOk/JQrmbOPjKHkyz
         uBjJI12R5ATMWmbhSC2RNVWR5n6MV6Q4fUPNJXkBpH0VmcuD06JjJFqxH1E6tDAbm/fz
         F+tNFJBSY8gzrSHEM68zIb7rfyLE0H8W+wdSGy/VJ8KNuoz2RSkME7/ve8KDzMJVGFrF
         DiGYrvngzO9vB31UFw3WZFlgyzfBRI5w6dCQlRAh9HlHPJCq1EPWrAnLWkR4nN3lXrLK
         WtgQ==
X-Gm-Message-State: AAQBX9cUb2LH8JmAocbMwu0O/FYBzXsmIZZ6JGDGsttI0p6cQ0J3sqUo
        zzggYZkBT2h3FX5xwW1kEmNTcw==
X-Google-Smtp-Source: AKy350YFZYyCSVSlWpDdzZ1ZL92PCSV0WLlHWN+PkWcxgLoWOkXVFF807f29qH9W/TBVEjRQDW4/Wg==
X-Received: by 2002:a05:6a20:7da9:b0:f2:bb3f:3b3e with SMTP id v41-20020a056a207da900b000f2bb3f3b3emr18378680pzj.38.1682480434984;
        Tue, 25 Apr 2023 20:40:34 -0700 (PDT)
Received: from PF2E59YH-BKX.inc.bytedance.com ([2408:8606:1800:501::a])
        by smtp.gmail.com with ESMTPSA id x4-20020aa784c4000000b0063d238b1e4bsm9987671pfn.160.2023.04.25.20.40.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Apr 2023 20:40:34 -0700 (PDT)
From:   Yunhui Cui <cuiyunhui@bytedance.com>
To:     rafael@kernel.org, lenb@kernel.org, jdelvare@suse.com,
        cuiyunhui@bytedance.com, cujomalainey@chromium.org,
        yc.hung@mediatek.com, angelogioacchino.delregno@collabora.com,
        allen-kh.cheng@mediatek.com, pierre-louis.bossart@linux.intel.com,
        tinghan.shen@mediatek.com, ardb@kernel.org,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
Subject: [PATCH] firmware: added a firmware information passing method FFI
Date:   Wed, 26 Apr 2023 11:40:01 +0800
Message-Id: <20230426034001.16-1-cuiyunhui@bytedance.com>
X-Mailer: git-send-email 2.37.3.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some BootLoaders do not support UEFI and cannot pass ACPI/SBMIOS table
addresses through UEFI, such as coreboot.

On the x86 platform, we pass the ACPI/SMBIOS table through the reserved
address segment 0xF0000, but other arches usually do not reserve this
address segment.

We have added a new firmware information transmission method named FFI
(FDT FIRMWARE INTERFACE), through FDT to obtain firmware information,
such as the base address of the ACPI and SMBIOS table.

Signed-off-by: Yunhui Cui <cuiyunhui@bytedance.com>
---
 MAINTAINERS                 |  6 +++
 drivers/acpi/osl.c          |  8 ++++
 drivers/firmware/Kconfig    | 12 +++++
 drivers/firmware/Makefile   |  1 +
 drivers/firmware/dmi_scan.c | 96 ++++++++++++++++++++++---------------
 drivers/firmware/ffi.c      | 56 ++++++++++++++++++++++
 include/linux/ffi.h         | 15 ++++++
 7 files changed, 155 insertions(+), 39 deletions(-)
 create mode 100644 drivers/firmware/ffi.c
 create mode 100644 include/linux/ffi.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 8d5bc223f305..94664f3b4c96 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7750,6 +7750,12 @@ F:	arch/x86/platform/efi/
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
diff --git a/drivers/acpi/osl.c b/drivers/acpi/osl.c
index 3269a888fb7a..d45000041d2b 100644
--- a/drivers/acpi/osl.c
+++ b/drivers/acpi/osl.c
@@ -25,6 +25,7 @@
 #include <linux/nmi.h>
 #include <linux/acpi.h>
 #include <linux/efi.h>
+#include <linux/ffi.h>
 #include <linux/ioport.h>
 #include <linux/list.h>
 #include <linux/jiffies.h>
@@ -206,6 +207,13 @@ acpi_physical_address __init acpi_os_get_root_pointer(void)
 	if (pa)
 		return pa;
 
+#ifdef CONFIG_FDT_FW_INTERFACE
+	if (fdt_fwtbl.acpi20 != FDT_INVALID_FWTBL_ADDR)
+		return fdt_fwtbl.acpi20;
+	if (fdt_fwtbl.acpi != FDT_INVALID_FWTBL_ADDR)
+		return fdt_fwtbl.acpi;
+	pr_err("Fdt system description tables not found\n");
+#endif
 	if (efi_enabled(EFI_CONFIG_TABLES)) {
 		if (efi.acpi20 != EFI_INVALID_TABLE_ADDR)
 			return efi.acpi20;
diff --git a/drivers/firmware/Kconfig b/drivers/firmware/Kconfig
index b59e3041fd62..13c67b50c17a 100644
--- a/drivers/firmware/Kconfig
+++ b/drivers/firmware/Kconfig
@@ -303,6 +303,18 @@ config TURRIS_MOX_RWTM
 	  other manufacturing data and also utilize the Entropy Bit Generator
 	  for hardware random number generation.
 
+config FDT_FW_INTERFACE
+	bool "An interface for passing firmware info through FDT"
+	depends on OF && OF_FLATTREE
+	default n
+	help
+	  When some bootloaders do not support UEFI, and the arch does not
+	  support SMBIOS_ENTRY_POINT_SCAN_START, then you can enable this option
+	  to support the transfer of firmware information, such as acpi, smbios
+	  tables.
+
+	  Say Y here if you want to pass firmware information by FDT.
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
index 015c95a825d3..1e1a74ed7d3b 100644
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
@@ -655,54 +656,71 @@ static int __init dmi_smbios3_present(const u8 *buf)
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
+	#define INVALID_TABLE_ADDR (~0UL)
 
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
+}
+
+static void __init dmi_scan_machine(void)
+{
+	char __iomem *p, *q;
+	char buf[32];
+
+#ifdef CONFIG_FDT_FW_INTERFACE
+	if (dmi_sacn_smbios(fdt_fwtbl.smbios3, fdt_fwtbl.smbios))
+		goto error;
+#endif
+	if (efi_enabled(EFI_CONFIG_TABLES)) {
+		if (dmi_sacn_smbios(efi.smbios3, efi.smbios))
+			goto error;
 	} else if (IS_ENABLED(CONFIG_DMI_SCAN_MACHINE_NON_EFI_FALLBACK)) {
 		p = dmi_early_remap(SMBIOS_ENTRY_POINT_SCAN_START, 0x10000);
 		if (p == NULL)
diff --git a/drivers/firmware/ffi.c b/drivers/firmware/ffi.c
new file mode 100644
index 000000000000..83c7abf22220
--- /dev/null
+++ b/drivers/firmware/ffi.c
@@ -0,0 +1,56 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
+#include <linux/kobject.h>
+#include <linux/ffi.h>
+#include <linux/of_fdt.h>
+#include <linux/libfdt.h>
+
+struct fdt_fwtable __read_mostly fdt_fwtbl = {
+	.acpi			= FDT_INVALID_FWTBL_ADDR,
+	.acpi20			= FDT_INVALID_FWTBL_ADDR,
+	.smbios			= FDT_INVALID_FWTBL_ADDR,
+	.smbios3		= FDT_INVALID_FWTBL_ADDR,
+};
+EXPORT_SYMBOL(fdt_fwtbl);
+
+void __init of_fdt_fwtbl(void)
+{
+	int cfgtbl, len;
+	fdt64_t *prop;
+
+	cfgtbl = fdt_path_offset(initial_boot_params, "/cfgtables");
+	if (cfgtbl < 0) {
+		pr_info("cfgtables not found.\n");
+		return;
+	}
+	prop = fdt_getprop_w(initial_boot_params, cfgtbl, "smbios_phy_ptr", &len);
+	if (!prop || len != sizeof(u64))
+		pr_info("smbios_phy_ptr not found.\n");
+	else
+		fdt_fwtbl.smbios = fdt64_to_cpu(*prop);
+
+	prop = fdt_getprop_w(initial_boot_params, cfgtbl, "smbios3_phy_ptr", &len);
+	if (!prop || len != sizeof(u64))
+		pr_info("smbios3_phy_ptr not found.\n");
+	else
+		fdt_fwtbl.smbios3 = fdt64_to_cpu(*prop);
+
+	prop = fdt_getprop_w(initial_boot_params, cfgtbl, "acpi_phy_ptr", &len);
+	if (!prop || len != sizeof(u64))
+		pr_info("acpi_phy_ptr not found.\n");
+	else
+		fdt_fwtbl.acpi = fdt64_to_cpu(*prop);
+
+	prop = fdt_getprop_w(initial_boot_params, cfgtbl, "acpi20_phy_ptr", &len);
+	if (!prop || len != sizeof(u64))
+		pr_info("acpi20_phy_ptr not found.\n");
+	else
+		fdt_fwtbl.acpi20 = fdt64_to_cpu(*prop);
+}
+
+void __init fdt_fwtbl_init(void)
+{
+	of_fdt_fwtbl();
+}
diff --git a/include/linux/ffi.h b/include/linux/ffi.h
new file mode 100644
index 000000000000..ffb50810a01e
--- /dev/null
+++ b/include/linux/ffi.h
@@ -0,0 +1,15 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifndef _LINUX_FDT_FW_H
+#define _LINUX_FDT_FW_H
+
+#define FDT_INVALID_FWTBL_ADDR		(~0UL)
+extern struct fdt_fwtable {
+	unsigned long			acpi;
+	unsigned long			acpi20;
+	unsigned long			smbios;
+	unsigned long			smbios3;
+	unsigned long			flags;
+} fdt_fwtbl;
+
+#endif
-- 
2.20.1

