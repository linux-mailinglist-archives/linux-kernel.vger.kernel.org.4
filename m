Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88E7B748324
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 13:45:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231555AbjGELpO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 07:45:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231177AbjGELpL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 07:45:11 -0400
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39A39172D
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jul 2023 04:44:46 -0700 (PDT)
Received: by mail-oi1-x233.google.com with SMTP id 5614622812f47-3942c6584f0so4537431b6e.3
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jul 2023 04:44:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1688557485; x=1691149485;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=t2wHvvnZ9EXs4kZ7PH7ZQmrp8wDzjYqwhR8Lb7Z2dm0=;
        b=jVG4zai1xG7MtgnncuyhuPAqUUpjFnE9G3irewRE18y6iFyE/sSIGF23/BN9GqjedI
         zyE5d5WvPIsC2FoCMXz6YBxr+JP9d4N15NZq5ymkBEZQ9f5R/eqSfpU/6bJ9wyhWX0GY
         CZn7coRHhPZm1IRexWWv9LxGNpN/kk927lkfVslnarGWO0nM7CTFWJ6ITIo3KHTUnDnf
         FykR8jIUlH6tBDEJwoMXPppRQhPKve5atGYBKA4SFBp23WeY7rXeoIGbL2Lfb9ToKbu8
         gEhKKIYhaaWc9JldVwFllp+Ar8BmfPkSiuuXdmcH5Dd5lugkgvKVkJ8u7MiK/YyWjCVd
         zxew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688557485; x=1691149485;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t2wHvvnZ9EXs4kZ7PH7ZQmrp8wDzjYqwhR8Lb7Z2dm0=;
        b=lOxLoijUhIDQzwxq3gx+E1QQnxy5IAkFP4WjIhakDIRsaQ6vNNOQfJTMFjHmOFNBDq
         eNM2wqsLQ6r2ULpWX4Iw8apuus613y82w/xSYyIO9xHVlLB/35cueAFfodryCbCfk57K
         HfkeomG7Lwz4YBgjhyO0/+Kkli+KkHO+VVPSyKwwkNbmdZTn4FUSX7Cc0NqofAAXSYBE
         vB1D7XWkSHymWkFcSc5v1o6MAMh/ltZRwo42PGMEah90sDuGaJo1fGvqTzQ0aSETywkx
         EEYEulJQ+2F6AK2smUpHO0Cm1xVrNTceN+KSEF3XvOtjNwZuI+nVBfNU+jgw8b037M/V
         ORHA==
X-Gm-Message-State: AC+VfDy4N0v0x1WseaoLnpLRjwMmvd+1xjG+nh5z/7Njox4VXr0k9Hk4
        I66n4lEhBWukWep4skqUwe8TSA==
X-Google-Smtp-Source: ACHHUZ4ap87VDxLx6PJqpSNbm9olTnoBIzaTi9rOfKW8IJ4lqYlS+3MO2AfgOPiU74NZ5qWJSAcOSw==
X-Received: by 2002:a05:6808:197:b0:39e:ffc5:c450 with SMTP id w23-20020a056808019700b0039effc5c450mr15121527oic.47.1688557485518;
        Wed, 05 Jul 2023 04:44:45 -0700 (PDT)
Received: from PF2E59YH-BKX.inc.bytedance.com ([61.213.176.5])
        by smtp.gmail.com with ESMTPSA id 3-20020a17090a194300b00263f6687690sm1177900pjh.18.2023.07.05.04.44.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jul 2023 04:44:45 -0700 (PDT)
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
Subject: [PATCH v3 1/4] riscv: obtain ACPI RSDP from devicetree
Date:   Wed,  5 Jul 2023 19:42:48 +0800
Message-Id: <20230705114251.661-2-cuiyunhui@bytedance.com>
X-Mailer: git-send-email 2.37.3.windows.1
In-Reply-To: <20230705114251.661-1-cuiyunhui@bytedance.com>
References: <20230705114251.661-1-cuiyunhui@bytedance.com>
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

On RISC-V, Coreboot does not support booting using EFI, only devicetree
nor does RISC-V have a reserved address segment.
To allow using Coreboot on platforms that require ACPI, the ACPI RSDP
needs to be passed to supervisor mode software using devicetree.

Add support for parsing the "ffitbl" devicetree node to find the
ACPI entry point and use wire up acpi_arch_get_root_pointer().
This feature is known as FDT Firmware Interface (FFI).

Signed-off-by: Yunhui Cui <cuiyunhui@bytedance.com>
---
 MAINTAINERS                   |  6 ++++++
 arch/riscv/include/asm/acpi.h |  9 +++++++++
 arch/riscv/include/asm/ffi.h  | 14 +++++++++++++
 arch/riscv/kernel/Makefile    |  1 +
 arch/riscv/kernel/ffi.c       | 38 +++++++++++++++++++++++++++++++++++
 arch/riscv/kernel/setup.c     |  2 ++
 6 files changed, 70 insertions(+)
 create mode 100644 arch/riscv/include/asm/ffi.h
 create mode 100644 arch/riscv/kernel/ffi.c

diff --git a/MAINTAINERS b/MAINTAINERS
index cd5388a33410..e592f489e757 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -18363,6 +18363,12 @@ F:	arch/riscv/boot/dts/
 X:	arch/riscv/boot/dts/allwinner/
 X:	arch/riscv/boot/dts/renesas/
 
+RISC-V FDT FIRMWARE INTERFACE (FFI) SUPPORT
+M:	Yunhui Cui cuiyunhui@bytedance.com
+S:	Maintained
+F:	arch/riscv/include/asm/ffi.h
+F:	arch/riscv/kernel/ffi.c
+
 RISC-V PMU DRIVERS
 M:	Atish Patra <atishp@atishpatra.org>
 R:	Anup Patel <anup@brainfault.org>
diff --git a/arch/riscv/include/asm/acpi.h b/arch/riscv/include/asm/acpi.h
index f71ce21ff684..5574f9a152f5 100644
--- a/arch/riscv/include/asm/acpi.h
+++ b/arch/riscv/include/asm/acpi.h
@@ -15,6 +15,8 @@
 /* Basic configuration for ACPI */
 #ifdef CONFIG_ACPI
 
+#include <asm/ffi.h>
+
 typedef u64 phys_cpuid_t;
 #define PHYS_CPUID_INVALID INVALID_HARTID
 
@@ -66,6 +68,13 @@ int acpi_get_riscv_isa(struct acpi_table_header *table,
 		       unsigned int cpu, const char **isa);
 
 static inline int acpi_numa_get_nid(unsigned int cpu) { return NUMA_NO_NODE; }
+
+#define ACPI_HAVE_ARCH_GET_ROOT_POINTER
+static inline u64 acpi_arch_get_root_pointer(void)
+{
+	return riscv_acpi_rsdp();
+}
+
 #else
 static inline void acpi_init_rintc_map(void) { }
 static inline struct acpi_madt_rintc *acpi_cpu_get_madt_rintc(int cpu)
diff --git a/arch/riscv/include/asm/ffi.h b/arch/riscv/include/asm/ffi.h
new file mode 100644
index 000000000000..d5e8309cc06f
--- /dev/null
+++ b/arch/riscv/include/asm/ffi.h
@@ -0,0 +1,14 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifndef _ASM_FFI_H
+#define _ASM_FFI_H
+
+#ifdef CONFIG_FDT_FW_INTERFACE
+extern void ffi_init(void);
+extern u64 riscv_acpi_rsdp(void);
+#else
+#define ffi_init()
+static inline u64 riscv_acpi_rsdp(void) { return 0; }
+#endif
+
+#endif /* _ASM_FFI_H */
diff --git a/arch/riscv/kernel/Makefile b/arch/riscv/kernel/Makefile
index 506cc4a9a45a..71831cf7f934 100644
--- a/arch/riscv/kernel/Makefile
+++ b/arch/riscv/kernel/Makefile
@@ -92,6 +92,7 @@ obj-$(CONFIG_CRASH_CORE)	+= crash_core.o
 obj-$(CONFIG_JUMP_LABEL)	+= jump_label.o
 
 obj-$(CONFIG_EFI)		+= efi.o
+obj-$(CONFIG_FDT_FW_INTERFACE)	+= ffi.o
 obj-$(CONFIG_COMPAT)		+= compat_syscall_table.o
 obj-$(CONFIG_COMPAT)		+= compat_signal.o
 obj-$(CONFIG_COMPAT)		+= compat_vdso/
diff --git a/arch/riscv/kernel/ffi.c b/arch/riscv/kernel/ffi.c
new file mode 100644
index 000000000000..147d06a5acff
--- /dev/null
+++ b/arch/riscv/kernel/ffi.c
@@ -0,0 +1,38 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * ffi.c - FDT FIRMWARE INTERFACE
+ */
+
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
+#include <linux/of.h>
+#include <linux/of_fdt.h>
+#include <linux/libfdt.h>
+
+static u64 acpi_rsdp;
+
+void __init ffi_acpi_root_pointer(void)
+{
+	u32 ffitbl, acpi, len;
+	fdt64_t *prop;
+
+	ffitbl = fdt_subnode_offset(initial_boot_params, 0, "ffitbl");
+	acpi = fdt_subnode_offset(initial_boot_params, ffitbl, "acpi");
+	prop = fdt_getprop_w(initial_boot_params, acpi, "entry", &len);
+	if (!prop || len != sizeof(u64)) {
+		pr_debug("acpi rsdp not found.\n");
+		return;
+	}
+	acpi_rsdp = fdt64_to_cpu(*prop);
+	pr_debug("acpi rsdp: %llx\n", acpi_rsdp);
+}
+
+u64 __init riscv_acpi_rsdp(void)
+{
+	return acpi_rsdp;
+}
+
+void __init ffi_init(void)
+{
+	ffi_acpi_root_pointer();
+}
diff --git a/arch/riscv/kernel/setup.c b/arch/riscv/kernel/setup.c
index 971fe776e2f8..5a933d6b6acb 100644
--- a/arch/riscv/kernel/setup.c
+++ b/arch/riscv/kernel/setup.c
@@ -36,6 +36,7 @@
 #include <asm/thread_info.h>
 #include <asm/kasan.h>
 #include <asm/efi.h>
+#include <asm/ffi.h>
 
 #include "head.h"
 
@@ -279,6 +280,7 @@ void __init setup_arch(char **cmdline_p)
 	parse_early_param();
 
 	efi_init();
+	ffi_init();
 	paging_init();
 
 	/* Parse the ACPI tables for possible boot-time configuration */
-- 
2.20.1

