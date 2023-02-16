Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 698F5699C13
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 19:21:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230180AbjBPSVf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 13:21:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbjBPSVd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 13:21:33 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D88EC2A15A
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 10:21:12 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id ja21so2896933plb.13
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 10:21:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yWquo8X215yUxlcuMVI51NmUYIJJYyh2AH39DTzBzA0=;
        b=Y/uNQfauyNwP1IebYIQnlrUvDZZmMoA/yun6sqqObhrrmiVowECJlHh8IDwLwV6Mrs
         MjS//bPzSDjS9aQqAvZYuPwYcBFXD/WKKP12nV6ruoSWOybXib04rUTACCOh8K+yF7w3
         z8b4XUnhO+8LxWp/iyPecQcHqNkdQYH8UNVz7ndvMGv62gbahohUlDOgfsoGAxMCRC5H
         aDVpYVp+KXwC27ZIHotI/AbjsnKL9OYUF78nrwsdf32A0KZk1BpkDo0RODVnzm4q6gEd
         5OyE7L6NhGwfXlNfVZZL7vCzosH0KzahtK60qK5vQeHopoWXAvKpE+jw48MKjYmEyq54
         nLXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yWquo8X215yUxlcuMVI51NmUYIJJYyh2AH39DTzBzA0=;
        b=bUusBPOCQ+Brc/Yjm0qlFr115wEVqvmZFgz40VZYqAYDDVcyUrwIw1QEhV+QrYsUP0
         Txm4Kn1TA9fxAwGfO7PdlQy3nzLMg145FvxuekniVKenP6dHTIJBBUzItn0qTofF+RVU
         q3FY2RLRET8WeVUx1DdlMe8VoRmNgVAw0eT/uXxPYX5kSFHarGcOOn8PRQhaV+ofJWbg
         rGCLmlq0kC2zf7qpAWkLgdw1lagsko4l2RM5bXmKrjU/+D//kK/N7uTaXsbavCE/mD9G
         X1Y6CmoiGzXbrv6fGmVrqchWZVtSEnSrVJgzh5OsDvo7uLwun/lQ2BBvQlW2vXgCJkiH
         0HJA==
X-Gm-Message-State: AO0yUKVwCIO9wzpfeiEkzxGd7phaDk8xLgQ3buOFWB3tBGHzevf1RneV
        w4b0Hdds36obe2xgTZNHKq4K/g==
X-Google-Smtp-Source: AK7set91n5anNcToKIHo1nCNsdSUc/vn6DLL7/0cepiYJORH2Nk7E/8pcd4AT/BFiFSlkmtsonqO4w==
X-Received: by 2002:a05:6a20:a10c:b0:b6:40ae:823e with SMTP id q12-20020a056a20a10c00b000b640ae823emr7326203pzk.5.1676571672339;
        Thu, 16 Feb 2023 10:21:12 -0800 (PST)
Received: from kerodi.Dlink ([49.206.14.226])
        by smtp.gmail.com with ESMTPSA id n21-20020a637215000000b004dff15fc121sm1517574pgc.36.2023.02.16.10.21.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Feb 2023 10:21:11 -0800 (PST)
From:   Sunil V L <sunilvl@ventanamicro.com>
To:     Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>, Jonathan Corbet <corbet@lwn.net>
Cc:     linux-riscv@lists.infradead.org, linux-acpi@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Conor Dooley <conor.dooley@microchip.com>,
        Andrew Jones <ajones@ventanamicro.com>,
        Anup Patel <apatel@ventanamicro.com>,
        Atish Patra <atishp@rivosinc.com>,
        Sunil V L <sunilvl@ventanamicro.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Subject: [PATCH V2 04/21] RISC-V: Add support to build the ACPI core
Date:   Thu, 16 Feb 2023 23:50:26 +0530
Message-Id: <20230216182043.1946553-5-sunilvl@ventanamicro.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230216182043.1946553-1-sunilvl@ventanamicro.com>
References: <20230216182043.1946553-1-sunilvl@ventanamicro.com>
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

Enable ACPI core for RISC-V after adding architecture-specific
interfaces and header files required to build the ACPI core.

1) Couple of header files are required unconditionally by the ACPI
core. Add empty acenv.h and cpu.h header files.

2) If CONFIG_PCI is enabled, a few PCI related interfaces need to
be provided by the architecture. Define dummy interfaces for now
so that build succeeds. Actual implementation will be added when
PCI support is added for ACPI along with external interrupt
controller support.

3) A few globals and memory mapping related functions specific
to the architecture need to be provided.

Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 arch/riscv/Kconfig             |  5 +++
 arch/riscv/include/asm/acenv.h | 11 +++++
 arch/riscv/include/asm/acpi.h  | 60 +++++++++++++++++++++++++
 arch/riscv/include/asm/cpu.h   |  8 ++++
 arch/riscv/kernel/Makefile     |  2 +
 arch/riscv/kernel/acpi.c       | 80 ++++++++++++++++++++++++++++++++++
 6 files changed, 166 insertions(+)
 create mode 100644 arch/riscv/include/asm/acenv.h
 create mode 100644 arch/riscv/include/asm/acpi.h
 create mode 100644 arch/riscv/include/asm/cpu.h
 create mode 100644 arch/riscv/kernel/acpi.c

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index d153e1cd890b..3ba701b26389 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -12,6 +12,8 @@ config 32BIT
 
 config RISCV
 	def_bool y
+	select ACPI_GENERIC_GSI if ACPI
+	select ACPI_REDUCED_HARDWARE_ONLY if ACPI
 	select ARCH_CLOCKSOURCE_INIT
 	select ARCH_ENABLE_HUGEPAGE_MIGRATION if HUGETLB_PAGE && MIGRATION
 	select ARCH_ENABLE_SPLIT_PMD_PTLOCK if PGTABLE_LEVELS > 2
@@ -598,6 +600,7 @@ config EFI_STUB
 config EFI
 	bool "UEFI runtime support"
 	depends on OF && !XIP_KERNEL
+	select ARCH_SUPPORTS_ACPI if 64BIT
 	select LIBFDT
 	select UCS2_STRING
 	select EFI_PARAMS_FROM_FDT
@@ -703,3 +706,5 @@ source "drivers/cpufreq/Kconfig"
 endmenu # "CPU Power Management"
 
 source "arch/riscv/kvm/Kconfig"
+
+source "drivers/acpi/Kconfig"
diff --git a/arch/riscv/include/asm/acenv.h b/arch/riscv/include/asm/acenv.h
new file mode 100644
index 000000000000..22123c5a4883
--- /dev/null
+++ b/arch/riscv/include/asm/acenv.h
@@ -0,0 +1,11 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * RISC-V specific ACPICA environments and implementation
+ */
+
+#ifndef _ASM_ACENV_H
+#define _ASM_ACENV_H
+
+/* It is required unconditionally by ACPI core */
+
+#endif /* _ASM_ACENV_H */
diff --git a/arch/riscv/include/asm/acpi.h b/arch/riscv/include/asm/acpi.h
new file mode 100644
index 000000000000..7f9dce3c39d0
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
+ * Since MADT must provide at least one RINTC structure, the
+ * CPU will be always available in MADT on RISC-V.
+ */
+static inline bool acpi_has_cpu_in_madt(void)
+{
+	return true;
+}
+
+static inline void arch_fix_phys_package_id(int num, u32 slot) { }
+
+#endif /* CONFIG_ACPI */
+
+#endif /*_ASM_ACPI_H*/
diff --git a/arch/riscv/include/asm/cpu.h b/arch/riscv/include/asm/cpu.h
new file mode 100644
index 000000000000..ea1a88b3d5f2
--- /dev/null
+++ b/arch/riscv/include/asm/cpu.h
@@ -0,0 +1,8 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+
+#ifndef _ASM_CPU_H
+#define _ASM_CPU_H
+
+/* It is required unconditionally by ACPI core */
+
+#endif /* _ASM_CPU_H */
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
index 000000000000..81d448c41714
--- /dev/null
+++ b/arch/riscv/kernel/acpi.c
@@ -0,0 +1,80 @@
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
+#include <linux/io.h>
+#include <linux/pci.h>
+
+int acpi_noirq = 1;		/* skip ACPI IRQ initialization */
+int acpi_disabled = 1;
+EXPORT_SYMBOL(acpi_disabled);
+
+int acpi_pci_disabled = 1;	/* skip ACPI PCI scan and IRQ initialization */
+EXPORT_SYMBOL(acpi_pci_disabled);
+
+/*
+ * __acpi_map_table() will be called before paging_init(), so early_ioremap()
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
+#ifdef CONFIG_PCI
+
+/*
+ * These interfaces are defined just to enable building ACPI core.
+ * TODO: Update it with actual implementation when external interrupt
+ * controller support is added in RISC-V ACPI.
+ */
+int raw_pci_read(unsigned int domain, unsigned int bus, unsigned int devfn,
+		 int reg, int len, u32 *val)
+{
+	return PCIBIOS_DEVICE_NOT_FOUND;
+}
+
+int raw_pci_write(unsigned int domain, unsigned int bus, unsigned int devfn,
+		  int reg, int len, u32 val)
+{
+	return PCIBIOS_DEVICE_NOT_FOUND;
+}
+
+int acpi_pci_bus_find_domain_nr(struct pci_bus *bus)
+{
+	return -1;
+}
+
+struct pci_bus *pci_acpi_scan_root(struct acpi_pci_root *root)
+{
+	return NULL;
+}
+#endif	/* CONFIG_PCI */
-- 
2.34.1

