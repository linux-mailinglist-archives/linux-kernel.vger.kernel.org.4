Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9631A6FAF81
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 13:58:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234512AbjEHL6X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 07:58:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234888AbjEHL5i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 07:57:38 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 872954643B
        for <linux-kernel@vger.kernel.org>; Mon,  8 May 2023 04:55:33 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-1aaebed5bd6so30383875ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 08 May 2023 04:55:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1683546933; x=1686138933;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AKIAPMXrXfzkk8IX1ewOX27TBpicUwrq64VdyI20DAw=;
        b=KpgNJW0kX+Z9Wh6YbIvm+WvnaRcQpsLdZVg6avNrhWbmHJqQq3JK8lHR9rYyL6R4yt
         WkgJRqi3N8sMKuoXuEZOJTn6/ObWFDVNXf4lzDXX3HFu1cbJiR8NsI64zyjkCquA5WQj
         b1r0AqTwhdfn8wWoWDeIz4mUtDbnkowHWK1+RBRutlIT2OEpP4MSi57BYhtfhLCNooqJ
         VYhJOr8PYqpluzQAk1jrzZHteLtOzdpR2+Dt9qbePCgNDMSgUQcNgs3KqytEoo8U6Pe9
         XN2/dekVn2I3WMG2LAzZblSzmku6j6LY6D+8zPaWghquK9oXxgo63cTgY9rDGF/GDEWL
         jcFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683546933; x=1686138933;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AKIAPMXrXfzkk8IX1ewOX27TBpicUwrq64VdyI20DAw=;
        b=Fak6Pf5yrngHsQZkPN+c6B20GawEez2yVHbMEX1j5b0spLsFCpf+egy6O6p5DnLKJG
         2N5/p3/V9WjDjeTMz1BitIbEuP0Ws5evUMebM6W6mWMPnss6gTWGfd5KjGPUtZkARTHG
         pU8839tQJfQrHPz9Ir8KvaSNjWlxhfa122m41Spt8cUc2M9DmaAC9xbJgLcwyhwNqoZk
         7Higl7W0toDHGT37VxsaINKkwzZiz4/VnU8t08unf4NAdpTQBcIAsJ5avZvRY7N6TXFJ
         NnPlXsMdOOA+fhOY1W4ofMiB6LA2z/kV9lcn9AMEmDhtzABm161Shg6OhFVtZGF0RGPB
         gvkA==
X-Gm-Message-State: AC+VfDzm3lHLs78ySX88aLi7wUoBCZb2KUp+J5ONW1pceNqKB7Yyjtx8
        PbZ4IHmcUpytxJjx9798Z20sgqQjlvkP6mRBlqc=
X-Google-Smtp-Source: ACHHUZ7NAIOrHplYZkCxTdW1wLJXPNPUzm6zz0o6Ibgq4lD55UWL7tyxIaH+bDt+zorb8yD6L84S/g==
X-Received: by 2002:a17:903:1110:b0:1aa:ff41:31a7 with SMTP id n16-20020a170903111000b001aaff4131a7mr13029996plh.13.1683546932740;
        Mon, 08 May 2023 04:55:32 -0700 (PDT)
Received: from sunil-laptop.. ([106.51.189.144])
        by smtp.gmail.com with ESMTPSA id w9-20020a170902904900b001aaed524541sm7015149plz.227.2023.05.08.04.55.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 May 2023 04:55:32 -0700 (PDT)
From:   Sunil V L <sunilvl@ventanamicro.com>
To:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-acpi@vger.kernel.org,
        linux-crypto@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        llvm@lists.linux.dev
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Weili Qian <qianweili@huawei.com>,
        Zhou Wang <wangzhou1@hisilicon.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>,
        Marc Zyngier <maz@kernel.org>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>,
        Sunil V L <sunilvl@ventanamicro.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Andrew Jones <ajones@ventanamicro.com>,
        Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH V5 19/21] RISC-V: Add ACPI initialization in setup_arch()
Date:   Mon,  8 May 2023 17:22:35 +0530
Message-Id: <20230508115237.216337-20-sunilvl@ventanamicro.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230508115237.216337-1-sunilvl@ventanamicro.com>
References: <20230508115237.216337-1-sunilvl@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Initialize the ACPI core for RISC-V during boot.

ACPI tables and interpreter are initialized based on
the information passed from the firmware and the value of
the kernel parameter 'acpi'.

With ACPI support added for RISC-V, the kernel parameter 'acpi'
is also supported on RISC-V. Hence, update the documentation.

Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
---
 .../admin-guide/kernel-parameters.txt         |   8 +-
 arch/riscv/kernel/acpi.c                      | 125 ++++++++++++++++++
 arch/riscv/kernel/setup.c                     |   5 +
 3 files changed, 134 insertions(+), 4 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 9e5bab29685f..d910fba25f2c 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -1,17 +1,17 @@
-	acpi=		[HW,ACPI,X86,ARM64]
+	acpi=		[HW,ACPI,X86,ARM64,RISCV64]
 			Advanced Configuration and Power Interface
 			Format: { force | on | off | strict | noirq | rsdt |
 				  copy_dsdt }
 			force -- enable ACPI if default was off
-			on -- enable ACPI but allow fallback to DT [arm64]
+			on -- enable ACPI but allow fallback to DT [arm64,riscv64]
 			off -- disable ACPI if default was on
 			noirq -- do not use ACPI for IRQ routing
 			strict -- Be less tolerant of platforms that are not
 				strictly ACPI specification compliant.
 			rsdt -- prefer RSDT over (default) XSDT
 			copy_dsdt -- copy DSDT to memory
-			For ARM64, ONLY "acpi=off", "acpi=on" or "acpi=force"
-			are available
+			For ARM64 and RISCV64, ONLY "acpi=off", "acpi=on" or
+			"acpi=force" are available
 
 			See also Documentation/power/runtime_pm.rst, pci=noacpi
 
diff --git a/arch/riscv/kernel/acpi.c b/arch/riscv/kernel/acpi.c
index 89e142611c84..93f643f8d763 100644
--- a/arch/riscv/kernel/acpi.c
+++ b/arch/riscv/kernel/acpi.c
@@ -16,6 +16,7 @@
 #include <linux/acpi.h>
 #include <linux/io.h>
 #include <linux/pci.h>
+#include <linux/efi.h>
 
 int acpi_noirq = 1;		/* skip ACPI IRQ initialization */
 int acpi_disabled = 1;
@@ -25,6 +26,130 @@ int acpi_pci_disabled = 1;	/* skip ACPI PCI scan and IRQ initialization */
 EXPORT_SYMBOL(acpi_pci_disabled);
 
 static struct acpi_madt_rintc cpu_madt_rintc[NR_CPUS];
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
+	 * The revision in the table header is the FADT's Major revision. The
+	 * FADT also has a minor revision, which is stored in the FADT itself.
+	 *
+	 * TODO: Currently, we check for 6.5 as the minimum version to check
+	 * for HW_REDUCED flag. However, once RISC-V updates are released in
+	 * the ACPI spec, we need to update this check for exact minor revision
+	 */
+	if (table->revision < 6 || (table->revision == 6 && fadt->minor_revision < 5))
+		pr_err(FW_BUG "Unsupported FADT revision %d.%d, should be 6.5+\n",
+		       table->revision, fadt->minor_revision);
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
+ *	3. check ACPI FADT HW reduced flag
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
+	 *   and ACPI has not been [force] enabled (acpi=on|force)
+	 */
+	if (param_acpi_off ||
+	    (!param_acpi_on && !param_acpi_force &&
+	     efi.acpi20 == EFI_INVALID_TABLE_ADDR))
+		return;
+
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
+}
 
 static int acpi_parse_madt_rintc(union acpi_subtable_headers *header, const unsigned long end)
 {
diff --git a/arch/riscv/kernel/setup.c b/arch/riscv/kernel/setup.c
index a44c7fcde12f..2ab4cdaa2e68 100644
--- a/arch/riscv/kernel/setup.c
+++ b/arch/riscv/kernel/setup.c
@@ -8,6 +8,7 @@
  *  Nick Kossifidis <mick@ics.forth.gr>
  */
 
+#include <linux/acpi.h>
 #include <linux/cpu.h>
 #include <linux/init.h>
 #include <linux/mm.h>
@@ -277,6 +278,10 @@ void __init setup_arch(char **cmdline_p)
 
 	efi_init();
 	paging_init();
+
+	/* Parse the ACPI tables for possible boot-time configuration */
+	acpi_boot_table_init();
+
 #if IS_ENABLED(CONFIG_BUILTIN_DTB)
 	unflatten_and_copy_device_tree();
 #else
-- 
2.34.1

