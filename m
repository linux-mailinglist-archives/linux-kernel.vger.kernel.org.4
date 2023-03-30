Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13BC36CFBC1
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 08:43:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229864AbjC3Gnq convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 30 Mar 2023 02:43:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229652AbjC3Gnk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 02:43:40 -0400
Received: from fd01.gateway.ufhost.com (fd01.gateway.ufhost.com [61.152.239.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A07B40D9
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 23:43:39 -0700 (PDT)
Received: from EXMBX165.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX165", Issuer "EXMBX165" (not verified))
        by fd01.gateway.ufhost.com (Postfix) with ESMTP id A06F424E0F4;
        Thu, 30 Mar 2023 14:43:37 +0800 (CST)
Received: from EXMBX066.cuchost.com (172.16.7.66) by EXMBX165.cuchost.com
 (172.16.6.75) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Thu, 30 Mar
 2023 14:43:37 +0800
Received: from jsia-virtual-machine.localdomain (202.188.176.82) by
 EXMBX066.cuchost.com (172.16.6.66) with Microsoft SMTP Server (TLS) id
 15.0.1497.42; Thu, 30 Mar 2023 14:43:34 +0800
From:   Sia Jee Heng <jeeheng.sia@starfivetech.com>
To:     <paul.walmsley@sifive.com>, <palmer@dabbelt.com>,
        <aou@eecs.berkeley.edu>
CC:     <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <jeeheng.sia@starfivetech.com>, <leyfoon.tan@starfivetech.com>,
        <mason.huo@starfivetech.com>,
        Andrew Jones <ajones@ventanamicro.com>,
        "Conor Dooley" <conor.dooley@microchip.com>
Subject: [PATCH v8 2/4] RISC-V: Factor out common code of __cpu_resume_enter()
Date:   Thu, 30 Mar 2023 14:43:19 +0800
Message-ID: <20230330064321.1008373-3-jeeheng.sia@starfivetech.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230330064321.1008373-1-jeeheng.sia@starfivetech.com>
References: <20230330064321.1008373-1-jeeheng.sia@starfivetech.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [202.188.176.82]
X-ClientProxiedBy: EXCAS066.cuchost.com (172.16.6.26) To EXMBX066.cuchost.com
 (172.16.6.66)
X-YovoleRuleAgent: yovoleflag
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-0.0 required=5.0 tests=RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The cpu_resume() function is very similar for the suspend to disk and
suspend to ram cases. Factor out the common code into suspend_restore_csrs
macro and suspend_restore_regs macro.

Signed-off-by: Sia Jee Heng <jeeheng.sia@starfivetech.com>
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
---
 arch/riscv/include/asm/assembler.h | 62 ++++++++++++++++++++++++++++++
 arch/riscv/kernel/suspend_entry.S  | 34 ++--------------
 2 files changed, 65 insertions(+), 31 deletions(-)
 create mode 100644 arch/riscv/include/asm/assembler.h

diff --git a/arch/riscv/include/asm/assembler.h b/arch/riscv/include/asm/assembler.h
new file mode 100644
index 000000000000..ba59d38f8937
--- /dev/null
+++ b/arch/riscv/include/asm/assembler.h
@@ -0,0 +1,62 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (C) 2023 StarFive Technology Co., Ltd.
+ *
+ * Author: Jee Heng Sia <jeeheng.sia@starfivetech.com>
+ */
+
+#ifndef __ASSEMBLY__
+#error "Only include this from assembly code"
+#endif
+
+#ifndef __ASM_ASSEMBLER_H
+#define __ASM_ASSEMBLER_H
+
+#include <asm/asm.h>
+#include <asm/asm-offsets.h>
+#include <asm/csr.h>
+
+/*
+ * suspend_restore_csrs - restore CSRs
+ */
+	.macro suspend_restore_csrs
+		REG_L	t0, (SUSPEND_CONTEXT_REGS + PT_EPC)(a0)
+		csrw	CSR_EPC, t0
+		REG_L	t0, (SUSPEND_CONTEXT_REGS + PT_STATUS)(a0)
+		csrw	CSR_STATUS, t0
+		REG_L	t0, (SUSPEND_CONTEXT_REGS + PT_BADADDR)(a0)
+		csrw	CSR_TVAL, t0
+		REG_L	t0, (SUSPEND_CONTEXT_REGS + PT_CAUSE)(a0)
+		csrw	CSR_CAUSE, t0
+	.endm
+
+/*
+ * suspend_restore_regs - Restore registers (except A0 and T0-T6)
+ */
+	.macro suspend_restore_regs
+		REG_L	ra, (SUSPEND_CONTEXT_REGS + PT_RA)(a0)
+		REG_L	sp, (SUSPEND_CONTEXT_REGS + PT_SP)(a0)
+		REG_L	gp, (SUSPEND_CONTEXT_REGS + PT_GP)(a0)
+		REG_L	tp, (SUSPEND_CONTEXT_REGS + PT_TP)(a0)
+		REG_L	s0, (SUSPEND_CONTEXT_REGS + PT_S0)(a0)
+		REG_L	s1, (SUSPEND_CONTEXT_REGS + PT_S1)(a0)
+		REG_L	a1, (SUSPEND_CONTEXT_REGS + PT_A1)(a0)
+		REG_L	a2, (SUSPEND_CONTEXT_REGS + PT_A2)(a0)
+		REG_L	a3, (SUSPEND_CONTEXT_REGS + PT_A3)(a0)
+		REG_L	a4, (SUSPEND_CONTEXT_REGS + PT_A4)(a0)
+		REG_L	a5, (SUSPEND_CONTEXT_REGS + PT_A5)(a0)
+		REG_L	a6, (SUSPEND_CONTEXT_REGS + PT_A6)(a0)
+		REG_L	a7, (SUSPEND_CONTEXT_REGS + PT_A7)(a0)
+		REG_L	s2, (SUSPEND_CONTEXT_REGS + PT_S2)(a0)
+		REG_L	s3, (SUSPEND_CONTEXT_REGS + PT_S3)(a0)
+		REG_L	s4, (SUSPEND_CONTEXT_REGS + PT_S4)(a0)
+		REG_L	s5, (SUSPEND_CONTEXT_REGS + PT_S5)(a0)
+		REG_L	s6, (SUSPEND_CONTEXT_REGS + PT_S6)(a0)
+		REG_L	s7, (SUSPEND_CONTEXT_REGS + PT_S7)(a0)
+		REG_L	s8, (SUSPEND_CONTEXT_REGS + PT_S8)(a0)
+		REG_L	s9, (SUSPEND_CONTEXT_REGS + PT_S9)(a0)
+		REG_L	s10, (SUSPEND_CONTEXT_REGS + PT_S10)(a0)
+		REG_L	s11, (SUSPEND_CONTEXT_REGS + PT_S11)(a0)
+	.endm
+
+#endif	/* __ASM_ASSEMBLER_H */
diff --git a/arch/riscv/kernel/suspend_entry.S b/arch/riscv/kernel/suspend_entry.S
index aafcca58c19d..12b52afe09a4 100644
--- a/arch/riscv/kernel/suspend_entry.S
+++ b/arch/riscv/kernel/suspend_entry.S
@@ -7,6 +7,7 @@
 #include <linux/linkage.h>
 #include <asm/asm.h>
 #include <asm/asm-offsets.h>
+#include <asm/assembler.h>
 #include <asm/csr.h>
 #include <asm/xip_fixup.h>
 
@@ -83,39 +84,10 @@ ENTRY(__cpu_resume_enter)
 	add	a0, a1, zero
 
 	/* Restore CSRs */
-	REG_L	t0, (SUSPEND_CONTEXT_REGS + PT_EPC)(a0)
-	csrw	CSR_EPC, t0
-	REG_L	t0, (SUSPEND_CONTEXT_REGS + PT_STATUS)(a0)
-	csrw	CSR_STATUS, t0
-	REG_L	t0, (SUSPEND_CONTEXT_REGS + PT_BADADDR)(a0)
-	csrw	CSR_TVAL, t0
-	REG_L	t0, (SUSPEND_CONTEXT_REGS + PT_CAUSE)(a0)
-	csrw	CSR_CAUSE, t0
+	suspend_restore_csrs
 
 	/* Restore registers (except A0 and T0-T6) */
-	REG_L	ra, (SUSPEND_CONTEXT_REGS + PT_RA)(a0)
-	REG_L	sp, (SUSPEND_CONTEXT_REGS + PT_SP)(a0)
-	REG_L	gp, (SUSPEND_CONTEXT_REGS + PT_GP)(a0)
-	REG_L	tp, (SUSPEND_CONTEXT_REGS + PT_TP)(a0)
-	REG_L	s0, (SUSPEND_CONTEXT_REGS + PT_S0)(a0)
-	REG_L	s1, (SUSPEND_CONTEXT_REGS + PT_S1)(a0)
-	REG_L	a1, (SUSPEND_CONTEXT_REGS + PT_A1)(a0)
-	REG_L	a2, (SUSPEND_CONTEXT_REGS + PT_A2)(a0)
-	REG_L	a3, (SUSPEND_CONTEXT_REGS + PT_A3)(a0)
-	REG_L	a4, (SUSPEND_CONTEXT_REGS + PT_A4)(a0)
-	REG_L	a5, (SUSPEND_CONTEXT_REGS + PT_A5)(a0)
-	REG_L	a6, (SUSPEND_CONTEXT_REGS + PT_A6)(a0)
-	REG_L	a7, (SUSPEND_CONTEXT_REGS + PT_A7)(a0)
-	REG_L	s2, (SUSPEND_CONTEXT_REGS + PT_S2)(a0)
-	REG_L	s3, (SUSPEND_CONTEXT_REGS + PT_S3)(a0)
-	REG_L	s4, (SUSPEND_CONTEXT_REGS + PT_S4)(a0)
-	REG_L	s5, (SUSPEND_CONTEXT_REGS + PT_S5)(a0)
-	REG_L	s6, (SUSPEND_CONTEXT_REGS + PT_S6)(a0)
-	REG_L	s7, (SUSPEND_CONTEXT_REGS + PT_S7)(a0)
-	REG_L	s8, (SUSPEND_CONTEXT_REGS + PT_S8)(a0)
-	REG_L	s9, (SUSPEND_CONTEXT_REGS + PT_S9)(a0)
-	REG_L	s10, (SUSPEND_CONTEXT_REGS + PT_S10)(a0)
-	REG_L	s11, (SUSPEND_CONTEXT_REGS + PT_S11)(a0)
+	suspend_restore_regs
 
 	/* Return zero value */
 	add	a0, zero, zero
-- 
2.34.1

