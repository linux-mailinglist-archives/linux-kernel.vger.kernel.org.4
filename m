Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 928A8648A69
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 22:54:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229677AbiLIVyN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Dec 2022 16:54:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230035AbiLIVyJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Dec 2022 16:54:09 -0500
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0920E28E2A
        for <linux-kernel@vger.kernel.org>; Fri,  9 Dec 2022 13:54:08 -0800 (PST)
Received: by mail-qt1-x831.google.com with SMTP id ay32so4693962qtb.11
        for <linux-kernel@vger.kernel.org>; Fri, 09 Dec 2022 13:54:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xVKESmS2CkC8zgUGeRNy/pN8kkWa/bbTaKLrsj1OMQA=;
        b=ettPF9bh5uc1AfcY0td8C8mMF68mgK7c8miQei9n6QD/BJvzx56Dkqbz7OAZH+aUJ1
         UsIRAkVhGOGuDX1xTVxdTNCdVaq5IFhvE0Favi1ThEbpQoc2b0XwCxGup+bYTwUpaRY7
         mO2vfnKZmK7Y9GZGoCh302UYGF82dGBvlVrixpRQQQNrp4cAHawVvAshdS5XbpUHUNCm
         LczeVykHaB69farBcZdeElcSHMG48G31EOsbDdIl/FbL9KboPMD99jEKTDsJslRAgKKf
         PJFtw4A18rJkNXWRh+bwjJ614bViMWRHrATOQWH5F/LBi8N6E+Z9FTQtyrvMyAtdnm0X
         II8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xVKESmS2CkC8zgUGeRNy/pN8kkWa/bbTaKLrsj1OMQA=;
        b=Xwj25nMA/pdAAmSId8lipaQWvt+rC+yXdnjYTFesWZvePtgQ3sIgQa1JMX6NF7oEOm
         6aCqGkyMV6l3AKxwdJoW6ZF3B2TOCB3PcGf9vCnUTYMAUZFzecqcnlD7zw8xjex/d3PN
         yO4xViAR1EtnMVipTQcfmAnzs5UOn5Mjkp/KizFSY9JnWEgHtt9/4NN+/kMFV3ziCdgt
         6qnHX9rZpb1moqfsFmhXQEmwV/EiTvsqzXso9Eeq6vbiT8SOQB+fRd24dJrM4nPy0kxD
         N09/DXs5h0sqEGt5bN/j/StUHI5a+Adxi7ZN4UcCf72Bk1imIp4DNqIof2nB6aCFVuKi
         iW8Q==
X-Gm-Message-State: ANoB5pnbHKO2tO1D2NYlsRyaE/yv5OvA817p/l4d7b193K7LsYLfsTSD
        mvOn4+RHZi32e7alJbnW+0k=
X-Google-Smtp-Source: AA0mqf5pInjIQub4Aj69C3kW0wk2DgaYWxapm8VYtYnBBg+hW0faeILmls8hYnHyczQzgjUzhh9jag==
X-Received: by 2002:a05:622a:5c8b:b0:3a5:f994:78cf with SMTP id ge11-20020a05622a5c8b00b003a5f99478cfmr10024230qtb.31.1670622846982;
        Fri, 09 Dec 2022 13:54:06 -0800 (PST)
Received: from Dell-Inspiron-15.. ([2601:18c:8380:74b0:e8e5:f40c:d741:8f07])
        by smtp.gmail.com with ESMTPSA id p16-20020a05620a057000b006fee9a70343sm712718qkp.14.2022.12.09.13.54.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Dec 2022 13:54:06 -0800 (PST)
From:   Ben Wolsieffer <benwolsieffer@gmail.com>
To:     linux-stm32@st-md-mailman.stormreply.com
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Ben Wolsieffer <benwolsieffer@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Ard Biesheuvel <ardb@kernel.org>,
        "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        "Steven Rostedt (Google)" <rostedt@goodmis.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Masahiro Yamada <masahiroy@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH RESEND 1/2] ARM: v7m: handle faults
Date:   Fri,  9 Dec 2022 16:48:12 -0500
Message-Id: <20221209214824.3444954-2-benwolsieffer@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221209214824.3444954-1-benwolsieffer@gmail.com>
References: <20221209214824.3444954-1-benwolsieffer@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, any fault on an ARMv7M system will trigger the invalid entry
exception handler, bringing down the entire system.

This patch installs real handlers for the hard fault, memmanage, bus
fault and usage fault exceptions. For kernel space faults, an oops is
triggered, while user space faults kill the offending process with an
appropriate signal. The fault status registers are parsed to construct
an appropriate message and signal.

This is based on a patch from Emcraft Systems' kernel tree [1], but I
have significantly reworked it.

[1] https://github.com/EmcraftSystems/linux-upstream/commit/2882de1d86bd536c855feee582d44722434c2ac9

Signed-off-by: Ben Wolsieffer <benwolsieffer@gmail.com>
---
 arch/arm/include/asm/v7m.h  |  29 +++++++
 arch/arm/kernel/Makefile    |   2 +-
 arch/arm/kernel/entry-v7m.S |  68 +++++++++++++++-
 arch/arm/kernel/traps-v7m.c | 156 ++++++++++++++++++++++++++++++++++++
 4 files changed, 250 insertions(+), 5 deletions(-)
 create mode 100644 arch/arm/kernel/traps-v7m.c

diff --git a/arch/arm/include/asm/v7m.h b/arch/arm/include/asm/v7m.h
index 4512f7e1918f..b8c636a0578d 100644
--- a/arch/arm/include/asm/v7m.h
+++ b/arch/arm/include/asm/v7m.h
@@ -38,6 +38,35 @@
 #define V7M_SCB_SHCSR_BUSFAULTENA		(1 << 17)
 #define V7M_SCB_SHCSR_MEMFAULTENA		(1 << 16)
 
+#define V7M_SCB_CFSR			0x28
+
+#define V7M_SCB_CFSR_DIVBYZERO			(1 << 25)
+#define V7M_SCB_CFSR_UNALIGNED			(1 << 24)
+#define V7M_SCB_CFSR_NOCP			(1 << 19)
+#define V7M_SCB_CFSR_INVPC			(1 << 18)
+#define V7M_SCB_CFSR_INVSTATE			(1 << 17)
+#define V7M_SCB_CFSR_UNDEFINSTR			(1 << 16)
+#define V7M_SCB_CFSR_BFARVALID			(1 << 15)
+#define V7M_SCB_CFSR_LSPERR			(1 << 13)
+#define V7M_SCB_CFSR_STKERR			(1 << 12)
+#define V7M_SCB_CFSR_UNSTKERR			(1 << 11)
+#define V7M_SCB_CFSR_IMPRECISERR		(1 << 10)
+#define V7M_SCB_CFSR_PRECISERR			(1 << 9)
+#define V7M_SCB_CFSR_IBUSERR			(1 << 8)
+#define V7M_SCB_CFSR_MMARVALID			(1 << 7)
+#define V7M_SCB_CFSR_MLSPERR			(1 << 5)
+#define V7M_SCB_CFSR_MSTKERR			(1 << 4)
+#define V7M_SCB_CFSR_MUNSTKERR			(1 << 3)
+#define V7M_SCB_CFSR_DACCVIOL			(1 << 1)
+#define V7M_SCB_CFSR_IACCVIOL			(1 << 0)
+
+#define V7M_SCB_HFSR			0x2c
+#define V7M_SCB_HFSR_FORCED			(1 << 30)
+#define V7M_SCB_HFSR_VECTTBL			(1 << 1)
+
+#define V7M_SCB_MMAR			0x34
+#define V7M_SCB_BFAR			0x38
+
 #define V7M_xPSR_FRAMEPTRALIGN			0x00000200
 #define V7M_xPSR_EXCEPTIONNO			V7M_SCB_ICSR_VECTACTIVE
 
diff --git a/arch/arm/kernel/Makefile b/arch/arm/kernel/Makefile
index 48737ec800eb..6d7b06b28113 100644
--- a/arch/arm/kernel/Makefile
+++ b/arch/arm/kernel/Makefile
@@ -34,7 +34,7 @@ obj-$(CONFIG_ATAGS_PROC)	+= atags_proc.o
 obj-$(CONFIG_DEPRECATED_PARAM_STRUCT) += atags_compat.o
 
 ifeq ($(CONFIG_CPU_V7M),y)
-obj-y		+= entry-v7m.o v7m.o
+obj-y		+= entry-v7m.o v7m.o traps-v7m.o
 else
 obj-y		+= entry-armv.o
 endif
diff --git a/arch/arm/kernel/entry-v7m.S b/arch/arm/kernel/entry-v7m.S
index de8a60363c85..62909731cd1f 100644
--- a/arch/arm/kernel/entry-v7m.S
+++ b/arch/arm/kernel/entry-v7m.S
@@ -84,6 +84,66 @@ __irq_entry:
 	bx	lr
 ENDPROC(__irq_entry)
 
+__hardfault_entry:
+	v7m_exception_entry
+
+	@
+	@ Invoke the Hard Fault handler
+	@ routine called with r0 = struct pt_regs *
+	mov	r0, sp
+	bl	do_hardfault
+
+	@ execute the pending work, including reschedule
+	get_thread_info tsk
+	mov	why, #0
+	b	ret_to_user_from_irq
+ENDPROC(__hardfault_entry)
+
+__memmanage_entry:
+	v7m_exception_entry
+
+	@
+	@ Invoke the Mem Manage handler
+	@ routine called with r0 = struct pt_regs *
+	mov	r0, sp
+	bl	do_memmanage
+
+	@ execute the pending work, including reschedule
+	get_thread_info tsk
+	mov	why, #0
+	b	ret_to_user_from_irq
+ENDPROC(__memmanage_entry)
+
+__busfault_entry:
+	v7m_exception_entry
+
+	@
+	@ Invoke the Bus Fault handler
+	@ routine called with r0 = struct pt_regs *
+	mov	r0, sp
+	bl	do_busfault
+
+	@ execute the pending work, including reschedule
+	get_thread_info tsk
+	mov	why, #0
+	b	ret_to_user_from_irq
+ENDPROC(__busfault_entry)
+
+__usagefault_entry:
+	v7m_exception_entry
+
+	@
+	@ Invoke the Bus Fault handler
+	@ routine called with r0 = struct pt_regs *
+	mov	r0, sp
+	bl	do_usagefault
+
+	@ execute the pending work, including reschedule
+	get_thread_info tsk
+	mov	why, #0
+	b	ret_to_user_from_irq
+ENDPROC(__usagefault_entry)
+
 __pendsv_entry:
 	v7m_exception_entry
 
@@ -138,10 +198,10 @@ ENTRY(vector_table)
 	.long	0			@ 0 - Reset stack pointer
 	.long	__invalid_entry		@ 1 - Reset
 	.long	__invalid_entry		@ 2 - NMI
-	.long	__invalid_entry		@ 3 - HardFault
-	.long	__invalid_entry		@ 4 - MemManage
-	.long	__invalid_entry		@ 5 - BusFault
-	.long	__invalid_entry		@ 6 - UsageFault
+	.long	__hardfault_entry	@ 3 - HardFault
+	.long	__memmanage_entry	@ 4 - MemManage
+	.long	__busfault_entry	@ 5 - BusFault
+	.long	__usagefault_entry	@ 6 - UsageFault
 	.long	__invalid_entry		@ 7 - Reserved
 	.long	__invalid_entry		@ 8 - Reserved
 	.long	__invalid_entry		@ 9 - Reserved
diff --git a/arch/arm/kernel/traps-v7m.c b/arch/arm/kernel/traps-v7m.c
new file mode 100644
index 000000000000..5fd9943448e9
--- /dev/null
+++ b/arch/arm/kernel/traps-v7m.c
@@ -0,0 +1,156 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2011 Dmitry Cherukhin, Emcraft Systems
+ * Copyright (C) 2022 Ben Wolsieffer, Hefring Engineering
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#include <linux/io.h>
+#include <linux/sched.h>
+
+#include <asm/linkage.h>
+#include <asm/ptrace.h>
+#include <asm/system_misc.h>
+#include <asm/v7m.h>
+
+enum fault {
+	FAULT_HARDFALT = 3,
+	FAULT_MEMMANAGE = 4,
+	FAULT_BUSFAULT = 5,
+	FAULT_USAGEFAULT = 6
+};
+
+struct exception {
+	const char	*name;
+	int		fault;
+	int		test_bit;
+	int		signo;
+	int		si_code;
+	unsigned int	user_debug;
+};
+
+static const struct exception unknown_exception =
+	{"unknown exception",			0,			0,				SIGSEGV,	SEGV_MAPERR,	UDBG_SEGV};
+
+static const struct exception exceptions[] = {
+	{"escalated to hard fault",		FAULT_HARDFALT,		V7M_SCB_HFSR_FORCED,		SIGSEGV,	SEGV_MAPERR,	UDBG_SEGV},
+	{"vector read error",			FAULT_HARDFALT,		V7M_SCB_HFSR_VECTTBL,		SIGSEGV,	SEGV_MAPERR,	UDBG_SEGV},
+	{"divide by 0",				FAULT_USAGEFAULT,	V7M_SCB_CFSR_DIVBYZERO,		SIGSEGV,	SEGV_MAPERR,	UDBG_SEGV},
+	{"illegal unaligned access",		FAULT_USAGEFAULT,	V7M_SCB_CFSR_UNALIGNED,		SIGBUS,		BUS_ADRALN,	UDBG_BUS},
+	{"no coprocessor",			FAULT_USAGEFAULT,	V7M_SCB_CFSR_NOCP,		SIGILL,		ILL_COPROC,	UDBG_UNDEFINED},
+	{"return to invalid PC",		FAULT_USAGEFAULT,	V7M_SCB_CFSR_INVPC,		SIGSEGV,	SEGV_MAPERR,	UDBG_SEGV},
+	{"invalid ISA state",			FAULT_USAGEFAULT,	V7M_SCB_CFSR_INVSTATE,		SIGSEGV,	SEGV_MAPERR,	UDBG_SEGV},
+	{"undefined instruction",		FAULT_USAGEFAULT,	V7M_SCB_CFSR_UNDEFINSTR,	SIGILL,		ILL_ILLOPC,	UDBG_UNDEFINED},
+	{"floating point state error",		FAULT_BUSFAULT,		V7M_SCB_CFSR_LSPERR,		SIGBUS,		BUS_ADRERR,	UDBG_BUS},
+	{"exception stack push error",		FAULT_BUSFAULT,		V7M_SCB_CFSR_STKERR,		SIGBUS,		BUS_ADRERR,	UDBG_BUS},
+	{"exception stack pop error",		FAULT_BUSFAULT,		V7M_SCB_CFSR_UNSTKERR,		SIGBUS,		BUS_ADRERR,	UDBG_BUS},
+	{"imprecise data bus error",		FAULT_BUSFAULT,		V7M_SCB_CFSR_IMPRECISERR,	SIGBUS,		BUS_ADRERR,	UDBG_BUS},
+	{"precise data bus error",		FAULT_BUSFAULT,		V7M_SCB_CFSR_PRECISERR,		SIGBUS,		BUS_ADRERR,	UDBG_BUS},
+	{"pre-fetch error",			FAULT_BUSFAULT,		V7M_SCB_CFSR_IBUSERR,		SIGBUS,		BUS_ADRERR,	UDBG_BUS},
+	{"floating point state error",		FAULT_MEMMANAGE,	V7M_SCB_CFSR_MLSPERR,		SIGSEGV,	SEGV_MAPERR,	UDBG_SEGV},
+	{"exception stack push error",		FAULT_MEMMANAGE,	V7M_SCB_CFSR_MSTKERR,		SIGSEGV,	SEGV_MAPERR,	UDBG_SEGV},
+	{"exception stack pop error",		FAULT_MEMMANAGE,	V7M_SCB_CFSR_MUNSTKERR,		SIGSEGV,	SEGV_MAPERR,	UDBG_SEGV},
+	{"data access violation",		FAULT_MEMMANAGE,	V7M_SCB_CFSR_DACCVIOL,		SIGSEGV,	SEGV_ACCERR,	UDBG_SEGV},
+	{"instruction access violation",	FAULT_MEMMANAGE,	V7M_SCB_CFSR_IACCVIOL,		SIGSEGV,	SEGV_ACCERR,	UDBG_SEGV},
+	{NULL}
+};
+
+/*
+ * Common routine for high-level exception handlers.
+ * @param regs		state of registers when the exception occurs
+ * @param fault		IPSR, the fault number
+ */
+static void traps_v7m_common(struct pt_regs *regs, int fault)
+{
+	unsigned long status;
+	unsigned long hstatus;
+	unsigned long cstatus;
+	unsigned long addr;
+	size_t i;
+	const struct exception *exc = &unknown_exception;
+
+
+	hstatus = readl(BASEADDR_V7M_SCB + V7M_SCB_HFSR);
+	cstatus = readl(BASEADDR_V7M_SCB + V7M_SCB_CFSR);
+
+	if (cstatus & V7M_SCB_CFSR_MMARVALID && (fault == FAULT_MEMMANAGE ||
+			(fault == FAULT_HARDFALT && hstatus & V7M_SCB_HFSR_FORCED))) {
+		addr = readl(BASEADDR_V7M_SCB + V7M_SCB_MMAR);
+	} else if (cstatus & V7M_SCB_CFSR_BFARVALID && (fault == FAULT_BUSFAULT ||
+			(fault == FAULT_HARDFALT && hstatus & V7M_SCB_HFSR_FORCED))) {
+		addr = readl(BASEADDR_V7M_SCB + V7M_SCB_BFAR);
+	} else {
+		addr = instruction_pointer(regs);
+	}
+
+	writel(hstatus, BASEADDR_V7M_SCB + V7M_SCB_HFSR);
+	writel(cstatus, BASEADDR_V7M_SCB + V7M_SCB_CFSR);
+
+	for (i = 0; exceptions[i].name != NULL; ++i) {
+		if (fault != exceptions[i].fault)
+			continue;
+
+		status = fault == FAULT_HARDFALT ? hstatus : cstatus;
+		if (!(status & exceptions[i].test_bit))
+			continue;
+
+		exc = &exceptions[i];
+		break;
+	}
+
+#ifdef CONFIG_DEBUG_USER
+	if (user_mode(regs) && (user_debug & exc->user_debug)) {
+		pr_info("%s (%d): %s: addr=0x%px\n",
+			current->comm, task_pid_nr(current), exc->name, (void *)addr);
+		__show_regs(regs);
+	}
+#endif
+
+	arm_notify_die(exc->name, regs, exc->signo, exc->si_code,
+		       (void __user *)addr, 0, fault);
+}
+
+/*
+ * High-level exception handler for exception 3 (Hard Fault).
+ * @param regs		state of registers when the exception occurred
+ */
+asmlinkage void do_hardfault(struct pt_regs *regs)
+{
+	traps_v7m_common(regs, FAULT_HARDFALT);
+}
+
+/*
+ * High-level exception handler for exception 4 (Mem Manage).
+ * @param regs		state of registers when the exception occurred
+ */
+asmlinkage void do_memmanage(struct pt_regs *regs)
+{
+	traps_v7m_common(regs, FAULT_MEMMANAGE);
+}
+
+/*
+ * High-level exception handler for exception 5 (Bus Fault).
+ * @param regs		state of registers when the exception occurred
+ */
+asmlinkage void do_busfault(struct pt_regs *regs)
+{
+	traps_v7m_common(regs, FAULT_BUSFAULT);
+}
+
+/*
+ * High-level exception handler for exception 6 (Usage Fault).
+ * @param regs		state of registers when the exception occurred
+ */
+asmlinkage void do_usagefault(struct pt_regs *regs)
+{
+	traps_v7m_common(regs, FAULT_USAGEFAULT);
+}
-- 
2.38.1

