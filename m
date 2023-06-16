Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA25A732B72
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 11:26:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344286AbjFPJ0K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 05:26:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344133AbjFPJYz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 05:24:55 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B4CA270E;
        Fri, 16 Jun 2023 02:24:51 -0700 (PDT)
Date:   Fri, 16 Jun 2023 09:24:47 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1686907487;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AV6KkFtgrM2z233LjJh0pvjZzz7p2tEBabShKhguHIU=;
        b=GltytqPbDYjI3ykBmgF4MUl+rFPEKlZlZqaSB5tIh+sHOCmrTjatQKzQBL7DKxoVf/wfcd
        G/psAhq5DCW7UfgOYdtmq2FH4uuqmCqFSAmreIDY1k+fTo5YyhGjA6ACsrq3igm13sE4/L
        dNJ1PNIsJRkaCo5I+KKDxXoYfTvPVnNElsnDMo0sCZfAXXgVTYfVkS+Gl4L5BT6hpVcV4a
        ciTeDjJox7pQ9hNJesEle/olNE79RvOmg0ldtkAHchdknPlhVLdlDllo4yVP4hwYc8w4bY
        rtMJzVlWFWEiAfpk4z/CDkBeT/aWlOXBUa2GRcQ3bU/XcfdwfOK38mDnHtDlwQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1686907487;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AV6KkFtgrM2z233LjJh0pvjZzz7p2tEBabShKhguHIU=;
        b=PLCqIyRcb6jQuPir0pVr8YZ6N1hZbBXIaFWZmMTFZs7bD13LA56mQINzr99JJ4KFDv0dL1
        85Rpoj4WFYjowICw==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/boot] sh/cpu: Switch to arch_cpu_finalize_init()
Cc:     Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230613224545.371697797@linutronix.de>
References: <20230613224545.371697797@linutronix.de>
MIME-Version: 1.0
Message-ID: <168690748709.404.14314407199380002907.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/boot branch of tip:

Commit-ID:     01eb454e9bfe593f320ecbc9aaec60bf87cd453d
Gitweb:        https://git.kernel.org/tip/01eb454e9bfe593f320ecbc9aaec60bf87cd453d
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Wed, 14 Jun 2023 01:39:33 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 16 Jun 2023 10:16:00 +02:00

sh/cpu: Switch to arch_cpu_finalize_init()

check_bugs() is about to be phased out. Switch over to the new
arch_cpu_finalize_init() implementation.

No functional change.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20230613224545.371697797@linutronix.de

---
 arch/sh/Kconfig                 |  1 +-
 arch/sh/include/asm/bugs.h      | 74 +--------------------------------
 arch/sh/include/asm/processor.h |  2 +-
 arch/sh/kernel/idle.c           |  1 +-
 arch/sh/kernel/setup.c          | 55 ++++++++++++++++++++++++-
 5 files changed, 59 insertions(+), 74 deletions(-)
 delete mode 100644 arch/sh/include/asm/bugs.h

diff --git a/arch/sh/Kconfig b/arch/sh/Kconfig
index 9652d36..e339745 100644
--- a/arch/sh/Kconfig
+++ b/arch/sh/Kconfig
@@ -6,6 +6,7 @@ config SUPERH
 	select ARCH_ENABLE_MEMORY_HOTREMOVE if SPARSEMEM && MMU
 	select ARCH_HAVE_NMI_SAFE_CMPXCHG if (GUSA_RB || CPU_SH4A)
 	select ARCH_HAS_BINFMT_FLAT if !MMU
+	select ARCH_HAS_CPU_FINALIZE_INIT
 	select ARCH_HAS_CURRENT_STACK_POINTER
 	select ARCH_HAS_GIGANTIC_PAGE
 	select ARCH_HAS_GCOV_PROFILE_ALL
diff --git a/arch/sh/include/asm/bugs.h b/arch/sh/include/asm/bugs.h
deleted file mode 100644
index fe52abb..0000000
--- a/arch/sh/include/asm/bugs.h
+++ /dev/null
@@ -1,74 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef __ASM_SH_BUGS_H
-#define __ASM_SH_BUGS_H
-
-/*
- * This is included by init/main.c to check for architecture-dependent bugs.
- *
- * Needs:
- *	void check_bugs(void);
- */
-
-/*
- * I don't know of any Super-H bugs yet.
- */
-
-#include <asm/processor.h>
-
-extern void select_idle_routine(void);
-
-static void __init check_bugs(void)
-{
-	extern unsigned long loops_per_jiffy;
-	char *p = &init_utsname()->machine[2]; /* "sh" */
-
-	select_idle_routine();
-
-	current_cpu_data.loops_per_jiffy = loops_per_jiffy;
-
-	switch (current_cpu_data.family) {
-	case CPU_FAMILY_SH2:
-		*p++ = '2';
-		break;
-	case CPU_FAMILY_SH2A:
-		*p++ = '2';
-		*p++ = 'a';
-		break;
-	case CPU_FAMILY_SH3:
-		*p++ = '3';
-		break;
-	case CPU_FAMILY_SH4:
-		*p++ = '4';
-		break;
-	case CPU_FAMILY_SH4A:
-		*p++ = '4';
-		*p++ = 'a';
-		break;
-	case CPU_FAMILY_SH4AL_DSP:
-		*p++ = '4';
-		*p++ = 'a';
-		*p++ = 'l';
-		*p++ = '-';
-		*p++ = 'd';
-		*p++ = 's';
-		*p++ = 'p';
-		break;
-	case CPU_FAMILY_UNKNOWN:
-		/*
-		 * Specifically use CPU_FAMILY_UNKNOWN rather than
-		 * default:, so we're able to have the compiler whine
-		 * about unhandled enumerations.
-		 */
-		break;
-	}
-
-	printk("CPU: %s\n", get_cpu_subtype(&current_cpu_data));
-
-#ifndef __LITTLE_ENDIAN__
-	/* 'eb' means 'Endian Big' */
-	*p++ = 'e';
-	*p++ = 'b';
-#endif
-	*p = '\0';
-}
-#endif /* __ASM_SH_BUGS_H */
diff --git a/arch/sh/include/asm/processor.h b/arch/sh/include/asm/processor.h
index 85a6c1c..73fba7c 100644
--- a/arch/sh/include/asm/processor.h
+++ b/arch/sh/include/asm/processor.h
@@ -166,6 +166,8 @@ extern unsigned int instruction_size(unsigned int insn);
 #define instruction_size(insn)	(2)
 #endif
 
+void select_idle_routine(void);
+
 #endif /* __ASSEMBLY__ */
 
 #include <asm/processor_32.h>
diff --git a/arch/sh/kernel/idle.c b/arch/sh/kernel/idle.c
index d662503..045d93f 100644
--- a/arch/sh/kernel/idle.c
+++ b/arch/sh/kernel/idle.c
@@ -15,6 +15,7 @@
 #include <linux/irqflags.h>
 #include <linux/smp.h>
 #include <linux/atomic.h>
+#include <asm/processor.h>
 #include <asm/smp.h>
 #include <asm/bl_bit.h>
 
diff --git a/arch/sh/kernel/setup.c b/arch/sh/kernel/setup.c
index af977ec..cf7c0f7 100644
--- a/arch/sh/kernel/setup.c
+++ b/arch/sh/kernel/setup.c
@@ -43,6 +43,7 @@
 #include <asm/smp.h>
 #include <asm/mmu_context.h>
 #include <asm/mmzone.h>
+#include <asm/processor.h>
 #include <asm/sparsemem.h>
 #include <asm/platform_early.h>
 
@@ -354,3 +355,57 @@ int test_mode_pin(int pin)
 {
 	return sh_mv.mv_mode_pins() & pin;
 }
+
+void __init arch_cpu_finalize_init(void)
+{
+	char *p = &init_utsname()->machine[2]; /* "sh" */
+
+	select_idle_routine();
+
+	current_cpu_data.loops_per_jiffy = loops_per_jiffy;
+
+	switch (current_cpu_data.family) {
+	case CPU_FAMILY_SH2:
+		*p++ = '2';
+		break;
+	case CPU_FAMILY_SH2A:
+		*p++ = '2';
+		*p++ = 'a';
+		break;
+	case CPU_FAMILY_SH3:
+		*p++ = '3';
+		break;
+	case CPU_FAMILY_SH4:
+		*p++ = '4';
+		break;
+	case CPU_FAMILY_SH4A:
+		*p++ = '4';
+		*p++ = 'a';
+		break;
+	case CPU_FAMILY_SH4AL_DSP:
+		*p++ = '4';
+		*p++ = 'a';
+		*p++ = 'l';
+		*p++ = '-';
+		*p++ = 'd';
+		*p++ = 's';
+		*p++ = 'p';
+		break;
+	case CPU_FAMILY_UNKNOWN:
+		/*
+		 * Specifically use CPU_FAMILY_UNKNOWN rather than
+		 * default:, so we're able to have the compiler whine
+		 * about unhandled enumerations.
+		 */
+		break;
+	}
+
+	pr_info("CPU: %s\n", get_cpu_subtype(&current_cpu_data));
+
+#ifndef __LITTLE_ENDIAN__
+	/* 'eb' means 'Endian Big' */
+	*p++ = 'e';
+	*p++ = 'b';
+#endif
+	*p = '\0';
+}
