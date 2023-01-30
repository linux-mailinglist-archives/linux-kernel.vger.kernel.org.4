Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF9066818CA
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 19:24:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238073AbjA3SX6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 13:23:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237981AbjA3SXi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 13:23:38 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10E751555A
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 10:23:03 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id b10so11890389pjo.1
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 10:23:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pahRB1MQHdCryYbha4Boa/nOVNVdk2R7FujvNvjh3AA=;
        b=MhntFhnnMEzAvogxVHxPm1ax6jj4kTjw7Mv8WB8wpdq0EadJKSqRi+JWbLAiaBWgHE
         nmaNa5u6uSit/eEY4w0SO2GUfD++fOi8VH0Oc2EDk7WJc6Nv3YvcqtRgWVKM9VLpB9Nj
         mSus2Rkr0kylLFTxhIksaWe7VgnvSSJv88L1F4hGUKgoXdWYzedJcox0eXrjSFQuC578
         q+NqUdyarrhti8297ImRLl8MTLG2XUgqGw1CZzRhwV+/TYsemNH1KO6mXMqSDmcPQLhS
         imY6dqAFs3Qwc6osGZ3o9vmVG6PFdVLuow4jDWQBu9Ww6spn8DK4hw+KoSK6FAVU944N
         dSVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pahRB1MQHdCryYbha4Boa/nOVNVdk2R7FujvNvjh3AA=;
        b=1VQ+7o2DJlqL3Fwd9+YA8+0GvRlvUcSco4pa9n80p14QOlcQx1K6YSBV0oKbHIXOWD
         EzGmlAUUWSnpmp9UVpMvSRtnNStCs67UBFLhdxoH6ya/vReUwK0pTVe9nfCBaeVqlD/q
         gDjAbxRPOuIVHFhopygYrdKyOaXqvE+5ay6LXi+Mbsd8H19QQjv5IQ6db71c6mGHVyDZ
         /S5BrQq4texouLssM66IkKZMHA0NPRwTxnIrblMQa8FeNzc1X7WS9ickF6UeS9K7ZS6v
         jVla5cFdDE502Y33fe+qcQC/Z1EMgUuIGkgoatjlvRgxa/z2hVmKJRkLzMBTSpl3liE4
         GsKg==
X-Gm-Message-State: AFqh2kroNHJrudkzj522IAzNFz2BD5xP0vU/847xZZp9x4oCSHaeSyRG
        LZ7sGkMoaU8m5y35RBDKcD3Npg==
X-Google-Smtp-Source: AMrXdXtWe6SJ3kB3Dyaj6wRK9SbGThF/dnr0Ny0A90SETwEQypf8SaWiy1gHIn9GRTTcFlgmkbamBA==
X-Received: by 2002:a05:6a21:3987:b0:af:be2a:208f with SMTP id ad7-20020a056a21398700b000afbe2a208fmr53223873pzc.33.1675102977093;
        Mon, 30 Jan 2023 10:22:57 -0800 (PST)
Received: from kerodipc.Dlink ([49.206.9.96])
        by smtp.gmail.com with ESMTPSA id j193-20020a638bca000000b00478162d9923sm7000291pge.13.2023.01.30.10.22.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jan 2023 10:22:56 -0800 (PST)
From:   Sunil V L <sunilvl@ventanamicro.com>
To:     Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     linux-riscv@lists.infradead.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        Anup Patel <apatel@ventanamicro.com>,
        Andrew Jones <ajones@ventanamicro.com>,
        Atish Patra <atishp@rivosinc.com>,
        Sunil V L <sunilvl@ventanamicro.com>
Subject: [PATCH 05/24] RISC-V: ACPI: Add basic functions to build ACPI core
Date:   Mon, 30 Jan 2023 23:52:06 +0530
Message-Id: <20230130182225.2471414-6-sunilvl@ventanamicro.com>
X-Mailer: git-send-email 2.38.0
In-Reply-To: <20230130182225.2471414-1-sunilvl@ventanamicro.com>
References: <20230130182225.2471414-1-sunilvl@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce acpi.c and its related header files to provide
fundamental needs of extern variables and functions for ACPI core.
	- asm/acpi.h for arch specific variables and functions needed by
	  ACPI driver core;
	- acpi.c - Add function to initialize ACPI tables.
	- acpi.c for RISC-V related ACPI implementation for ACPI driver
	  core;

Code is mostly leveraged from ARM64.

Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
---
 arch/riscv/include/asm/acpi.h |  60 ++++++++++++
 arch/riscv/kernel/Makefile    |   2 +
 arch/riscv/kernel/acpi.c      | 178 ++++++++++++++++++++++++++++++++++
 3 files changed, 240 insertions(+)
 create mode 100644 arch/riscv/include/asm/acpi.h
 create mode 100644 arch/riscv/kernel/acpi.c

diff --git a/arch/riscv/include/asm/acpi.h b/arch/riscv/include/asm/acpi.h
new file mode 100644
index 000000000000..8b9babaf3f25
--- /dev/null
+++ b/arch/riscv/include/asm/acpi.h
@@ -0,0 +1,60 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ *  Copyright (C) 2013-2014, Linaro Ltd.
+ *	Author: Al Stone <al.stone@linaro.org>
+ *	Author: Graeme Gregory <graeme.gregory@linaro.org>
+ *	Author: Hanjun Guo <hanjun.guo@linaro.org>
+ *
+ *  Copyright (C) 2021-2023, Ventana Micro Systems Inc.
+ *	Author: Sunil V L <sunilvl@ventanamicro.com>
+ */
+
+#ifndef _ASM_ACPI_H
+#define _ASM_ACPI_H
+
+/* Basic configuration for ACPI */
+#ifdef CONFIG_ACPI
+
+/* ACPI table mapping after acpi_permanent_mmap is set */
+void *acpi_os_ioremap(acpi_physical_address phys, acpi_size size);
+#define acpi_os_ioremap acpi_os_ioremap
+
+#define acpi_strict 1   /* No out-of-spec workarounds on RISC-V */
+extern int acpi_disabled;
+extern int acpi_noirq;
+extern int acpi_pci_disabled;
+static inline void disable_acpi(void)
+{
+	acpi_disabled = 1;
+	acpi_pci_disabled = 1;
+	acpi_noirq = 1;
+}
+
+static inline void enable_acpi(void)
+{
+	acpi_disabled = 0;
+	acpi_pci_disabled = 0;
+	acpi_noirq = 0;
+}
+
+/*
+ * The ACPI processor driver for ACPI core code needs this macro
+ * to find out this cpu was already mapped (mapping from CPU hardware
+ * ID to CPU logical ID) or not.
+ */
+#define cpu_physical_id(cpu) cpuid_to_hartid_map(cpu)
+
+/*
+ * It's used from ACPI core in kdump to boot UP system with SMP kernel.
+ * Since MADT must provide at least one IMSIC structure for AIA
+ * initialization, CPU will be always available in MADT on RISC-V.
+ */
+static inline bool acpi_has_cpu_in_madt(void)
+{
+	return true;
+}
+
+static inline void arch_fix_phys_package_id(int num, u32 slot) { }
+#endif
+
+#endif /*_ASM_ACPI_H*/
diff --git a/arch/riscv/kernel/Makefile b/arch/riscv/kernel/Makefile
index 67f542be1bea..f979dc8cf47d 100644
--- a/arch/riscv/kernel/Makefile
+++ b/arch/riscv/kernel/Makefile
@@ -90,3 +90,5 @@ obj-$(CONFIG_EFI)		+= efi.o
 obj-$(CONFIG_COMPAT)		+= compat_syscall_table.o
 obj-$(CONFIG_COMPAT)		+= compat_signal.o
 obj-$(CONFIG_COMPAT)		+= compat_vdso/
+
+obj-$(CONFIG_ACPI)              += acpi.o
diff --git a/arch/riscv/kernel/acpi.c b/arch/riscv/kernel/acpi.c
new file mode 100644
index 000000000000..9c1aa57bf4f7
--- /dev/null
+++ b/arch/riscv/kernel/acpi.c
@@ -0,0 +1,178 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ *  RISC-V Specific Low-Level ACPI Boot Support
+ *
+ *  Copyright (C) 2013-2014, Linaro Ltd.
+ *	Author: Al Stone <al.stone@linaro.org>
+ *	Author: Graeme Gregory <graeme.gregory@linaro.org>
+ *	Author: Hanjun Guo <hanjun.guo@linaro.org>
+ *	Author: Tomasz Nowicki <tomasz.nowicki@linaro.org>
+ *	Author: Naresh Bhat <naresh.bhat@linaro.org>
+ *
+ *  Copyright (C) 2021-2023, Ventana Micro Systems Inc.
+ *	Author: Sunil V L <sunilvl@ventanamicro.com>
+ */
+
+#include <linux/acpi.h>
+#include <linux/efi.h>
+#include <linux/efi-bgrt.h>
+#include <linux/io.h>
+#include <linux/of_fdt.h>
+#include <linux/serial_core.h>
+
+int acpi_noirq = 1;		/* skip ACPI IRQ initialization */
+int acpi_disabled = 1;
+EXPORT_SYMBOL(acpi_disabled);
+
+int acpi_pci_disabled = 1;	/* skip ACPI PCI scan and IRQ initialization */
+EXPORT_SYMBOL(acpi_pci_disabled);
+
+static bool param_acpi_off __initdata;
+static bool param_acpi_on __initdata;
+static bool param_acpi_force __initdata;
+
+static int __init parse_acpi(char *arg)
+{
+	if (!arg)
+		return -EINVAL;
+
+	/* "acpi=off" disables both ACPI table parsing and interpreter */
+	if (strcmp(arg, "off") == 0)
+		param_acpi_off = true;
+	else if (strcmp(arg, "on") == 0) /* prefer ACPI over DT */
+		param_acpi_on = true;
+	else if (strcmp(arg, "force") == 0) /* force ACPI to be enabled */
+		param_acpi_force = true;
+	else
+		return -EINVAL;	/* Core will print when we return error */
+
+	return 0;
+}
+early_param("acpi", parse_acpi);
+
+/*
+ * __acpi_map_table() will be called before page_init(), so early_ioremap()
+ * or early_memremap() should be called here to for ACPI table mapping.
+ */
+void __init __iomem *__acpi_map_table(unsigned long phys, unsigned long size)
+{
+	if (!size)
+		return NULL;
+
+	return early_memremap(phys, size);
+}
+
+void __init __acpi_unmap_table(void __iomem *map, unsigned long size)
+{
+	if (!map || !size)
+		return;
+
+	early_memunmap(map, size);
+}
+
+void *acpi_os_ioremap(acpi_physical_address phys, acpi_size size)
+{
+	return memremap(phys, size, MEMREMAP_WB);
+}
+
+/*
+ * acpi_fadt_sanity_check() - Check FADT presence and carry out sanity
+ *			      checks on it
+ *
+ * Return 0 on success,  <0 on failure
+ */
+static int __init acpi_fadt_sanity_check(void)
+{
+	struct acpi_table_header *table;
+	struct acpi_table_fadt *fadt;
+	acpi_status status;
+	int ret = 0;
+
+	/*
+	 * FADT is required on riscv; retrieve it to check its presence
+	 * and carry out revision and ACPI HW reduced compliancy tests
+	 */
+	status = acpi_get_table(ACPI_SIG_FADT, 0, &table);
+	if (ACPI_FAILURE(status)) {
+		const char *msg = acpi_format_exception(status);
+
+		pr_err("Failed to get FADT table, %s\n", msg);
+		return -ENODEV;
+	}
+
+	fadt = (struct acpi_table_fadt *)table;
+
+	/*
+	 * TODO: Should we add FADT version checks?
+	 */
+
+	if (!(fadt->flags & ACPI_FADT_HW_REDUCED)) {
+		pr_err("FADT not ACPI hardware reduced compliant\n");
+		ret = -EINVAL;
+	}
+
+	/*
+	 * acpi_get_table() creates FADT table mapping that
+	 * should be released after parsing and before resuming boot
+	 */
+	acpi_put_table(table);
+	return ret;
+}
+
+/*
+ * acpi_boot_table_init() called from setup_arch(), always.
+ *	1. find RSDP and get its address, and then find XSDT
+ *	2. extract all tables and checksums them all
+ *	3. check ACPI FADT revision
+ *	4. check ACPI FADT HW reduced flag
+ *
+ * We can parse ACPI boot-time tables such as MADT after
+ * this function is called.
+ *
+ * On return ACPI is enabled if either:
+ *
+ * - ACPI tables are initialized and sanity checks passed
+ * - acpi=force was passed in the command line and ACPI was not disabled
+ *   explicitly through acpi=off command line parameter
+ *
+ * ACPI is disabled on function return otherwise
+ */
+void __init acpi_boot_table_init(void)
+{
+	/*
+	 * Enable ACPI instead of device tree unless
+	 * - ACPI has been disabled explicitly (acpi=off), or
+	 * - firmware has not populated ACPI ptr in EFI system table
+	 */
+
+	if (param_acpi_off || (efi.acpi20 == EFI_INVALID_TABLE_ADDR))
+		goto done;
+	/*
+	 * ACPI is disabled at this point. Enable it in order to parse
+	 * the ACPI tables and carry out sanity checks
+	 */
+	enable_acpi();
+
+	/*
+	 * If ACPI tables are initialized and FADT sanity checks passed,
+	 * leave ACPI enabled and carry on booting; otherwise disable ACPI
+	 * on initialization error.
+	 * If acpi=force was passed on the command line it forces ACPI
+	 * to be enabled even if its initialization failed.
+	 */
+	if (acpi_table_init() || acpi_fadt_sanity_check()) {
+		pr_err("Failed to init ACPI tables\n");
+		if (!param_acpi_force)
+			disable_acpi();
+	}
+
+done:
+	if (acpi_disabled) {
+		if (earlycon_acpi_spcr_enable)
+			early_init_dt_scan_chosen_stdout();
+	} else {
+		acpi_parse_spcr(earlycon_acpi_spcr_enable, true);
+		if (IS_ENABLED(CONFIG_ACPI_BGRT))
+			acpi_table_parse(ACPI_SIG_BGRT, acpi_parse_bgrt);
+	}
+}
-- 
2.38.0

