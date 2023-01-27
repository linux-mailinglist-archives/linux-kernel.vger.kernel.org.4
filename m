Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C75F67E349
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 12:30:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233428AbjA0L3u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 06:29:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230060AbjA0L3Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 06:29:25 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 929727AE6A
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 03:28:34 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8617B1596;
        Fri, 27 Jan 2023 03:29:01 -0800 (PST)
Received: from e122027.cambridge.arm.com (e122027.cambridge.arm.com [10.1.35.16])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 418763F64C;
        Fri, 27 Jan 2023 03:28:17 -0800 (PST)
From:   Steven Price <steven.price@arm.com>
To:     kvmarm@lists.linux.dev, linux-arm-kernel@lists.infradead.org
Cc:     Steven Price <steven.price@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Marc Zyngier <maz@kernel.org>, Will Deacon <will@kernel.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        James Morse <james.morse@arm.com>,
        Oliver Upton <oliver.upton@linux.dev>,
        Zenghui Yu <yuzenghui@huawei.com>,
        linux-kernel@vger.kernel.org, Joey Gouly <joey.gouly@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Christoffer Dall <christoffer.dall@arm.com>,
        Fuad Tabba <tabba@google.com>, linux-coco@lists.linux.dev
Subject: [RFC PATCH 03/14] arm64: Detect if in a realm and set RIPAS RAM
Date:   Fri, 27 Jan 2023 11:27:47 +0000
Message-Id: <20230127112758.37891-4-steven.price@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230127112758.37891-1-steven.price@arm.com>
References: <20230127112248.136810-1-suzuki.poulose@arm.com>
 <20230127112758.37891-1-steven.price@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Detect that the VM is a realm guest by the presence of the RSI
interface.

If in a realm then all memory needs to be marked as RIPAS RAM initially,
the loader may or may not have done this for us. To be sure iterate over
all RAM and mark it as such. Any failure is fatal as that implies the
RAM regions passed to Linux are incorrect - which would mean failing
later when attempting to access non-existent RAM.

Co-developed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
Signed-off-by: Steven Price <steven.price@arm.com>
---
 arch/arm64/include/asm/rsi.h      | 46 ++++++++++++++++++++++++++++
 arch/arm64/include/asm/rsi_cmds.h | 12 ++++++--
 arch/arm64/kernel/Makefile        |  2 +-
 arch/arm64/kernel/rsi.c           | 50 +++++++++++++++++++++++++++++++
 arch/arm64/kernel/setup.c         |  3 ++
 arch/arm64/mm/init.c              |  2 ++
 6 files changed, 111 insertions(+), 4 deletions(-)
 create mode 100644 arch/arm64/include/asm/rsi.h
 create mode 100644 arch/arm64/kernel/rsi.c

diff --git a/arch/arm64/include/asm/rsi.h b/arch/arm64/include/asm/rsi.h
new file mode 100644
index 000000000000..3b56aac5dc43
--- /dev/null
+++ b/arch/arm64/include/asm/rsi.h
@@ -0,0 +1,46 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (C) 2023 ARM Ltd.
+ */
+
+#ifndef __ASM_RSI_H_
+#define __ASM_RSI_H_
+
+#include <linux/jump_label.h>
+#include <asm/rsi_cmds.h>
+
+extern struct static_key_false rsi_present;
+
+void arm64_setup_memory(void);
+
+void __init arm64_rsi_init(void);
+static inline bool is_realm_world(void)
+{
+	return static_branch_unlikely(&rsi_present);
+}
+
+static inline void set_memory_range(phys_addr_t start, phys_addr_t end,
+				    enum ripas state)
+{
+	unsigned long ret;
+	phys_addr_t top;
+
+	while (start != end) {
+		ret = rsi_set_addr_range_state(start, end, state, &top);
+		BUG_ON(ret);
+		BUG_ON(top < start);
+		BUG_ON(top > end);
+		start = top;
+	}
+}
+
+static inline void set_memory_range_protected(phys_addr_t start, phys_addr_t end)
+{
+	set_memory_range(start, end, RSI_RIPAS_RAM);
+}
+
+static inline void set_memory_range_shared(phys_addr_t start, phys_addr_t end)
+{
+	set_memory_range(start, end, RSI_RIPAS_EMPTY);
+}
+#endif
diff --git a/arch/arm64/include/asm/rsi_cmds.h b/arch/arm64/include/asm/rsi_cmds.h
index a0b3c1bd786a..ee0df00efd87 100644
--- a/arch/arm64/include/asm/rsi_cmds.h
+++ b/arch/arm64/include/asm/rsi_cmds.h
@@ -48,10 +48,16 @@ static inline void invoke_rsi_fn_smc_with_res(unsigned long function_id,
 
 static inline unsigned long rsi_set_addr_range_state(phys_addr_t start,
 						     phys_addr_t end,
-						     enum ripas state)
+						     enum ripas state,
+						     phys_addr_t *top)
 {
-	return invoke_rsi_fn_smc(SMC_RSI_IPA_STATE_SET,
-				 start, (end - start), state, 0);
+	struct arm_smccc_res res;
+
+	invoke_rsi_fn_smc_with_res(SMC_RSI_IPA_STATE_SET,
+				   start, (end - start), state, 0, &res);
+
+	*top = res.a1;
+	return res.a0;
 }
 
 #endif
diff --git a/arch/arm64/kernel/Makefile b/arch/arm64/kernel/Makefile
index ceba6792f5b3..f301c2ad2fa7 100644
--- a/arch/arm64/kernel/Makefile
+++ b/arch/arm64/kernel/Makefile
@@ -34,7 +34,7 @@ obj-y			:= debug-monitors.o entry.o irq.o fpsimd.o		\
 			   cpufeature.o alternative.o cacheinfo.o		\
 			   smp.o smp_spin_table.o topology.o smccc-call.o	\
 			   syscall.o proton-pack.o idreg-override.o idle.o	\
-			   patching.o
+			   patching.o rsi.o
 
 obj-$(CONFIG_COMPAT)			+= sys32.o signal32.o			\
 					   sys_compat.o
diff --git a/arch/arm64/kernel/rsi.c b/arch/arm64/kernel/rsi.c
new file mode 100644
index 000000000000..b354ac661c9d
--- /dev/null
+++ b/arch/arm64/kernel/rsi.c
@@ -0,0 +1,50 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2023 ARM Ltd.
+ */
+
+#include <linux/jump_label.h>
+#include <linux/memblock.h>
+#include <asm/rsi.h>
+
+DEFINE_STATIC_KEY_FALSE_RO(rsi_present);
+
+static bool rsi_version_matches(void)
+{
+	unsigned long ver = rsi_get_version();
+
+	if (ver == SMCCC_RET_NOT_SUPPORTED)
+		return false;
+
+	pr_info("RME: RSI version %lu.%lu advertised\n",
+		RSI_ABI_VERSION_GET_MAJOR(ver),
+		RSI_ABI_VERSION_GET_MINOR(ver));
+
+	return (ver >= RSI_ABI_VERSION &&
+		RSI_ABI_VERSION_GET_MAJOR(ver) == RSI_ABI_VERSION_MAJOR);
+}
+
+void arm64_setup_memory(void)
+{
+	u64 i;
+	phys_addr_t start, end;
+
+	if (!static_branch_unlikely(&rsi_present))
+		return;
+
+	/*
+	 * Iterate over the available memory ranges
+	 * and convert the state to protected memory.
+	 */
+	for_each_mem_range(i, &start, &end) {
+		set_memory_range_protected(start, end);
+	}
+}
+
+void __init arm64_rsi_init(void)
+{
+	if (!rsi_version_matches())
+		return;
+
+	static_branch_enable(&rsi_present);
+}
diff --git a/arch/arm64/kernel/setup.c b/arch/arm64/kernel/setup.c
index 12cfe9d0d3fa..ea89ee563135 100644
--- a/arch/arm64/kernel/setup.c
+++ b/arch/arm64/kernel/setup.c
@@ -43,6 +43,7 @@
 #include <asm/cpu_ops.h>
 #include <asm/kasan.h>
 #include <asm/numa.h>
+#include <asm/rsi.h>
 #include <asm/scs.h>
 #include <asm/sections.h>
 #include <asm/setup.h>
@@ -312,6 +313,8 @@ void __init __no_sanitize_address setup_arch(char **cmdline_p)
 	 * cpufeature code and early parameters.
 	 */
 	jump_label_init();
+	/* Init RSI after jump_labels are active */
+	arm64_rsi_init();
 	parse_early_param();
 
 	dynamic_scs_init();
diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
index 58a0bb2c17f1..fa9088add624 100644
--- a/arch/arm64/mm/init.c
+++ b/arch/arm64/mm/init.c
@@ -39,6 +39,7 @@
 #include <asm/kvm_host.h>
 #include <asm/memory.h>
 #include <asm/numa.h>
+#include <asm/rsi.h>
 #include <asm/sections.h>
 #include <asm/setup.h>
 #include <linux/sizes.h>
@@ -412,6 +413,7 @@ void __init arm64_memblock_init(void)
 		reserve_crashkernel();
 
 	high_memory = __va(memblock_end_of_DRAM() - 1) + 1;
+	arm64_setup_memory();
 }
 
 void __init bootmem_init(void)
-- 
2.34.1

