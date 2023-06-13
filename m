Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D920C72F03D
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 01:40:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241468AbjFMXkW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 19:40:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241031AbjFMXjt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 19:39:49 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 827171BEF;
        Tue, 13 Jun 2023 16:39:35 -0700 (PDT)
Message-ID: <20230613224545.371697797@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1686699574;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=BCwXFjxceFBs/QyeCz7aN0wJQMhwFQHZqSOS2loa870=;
        b=AXY7t4EYgBM4Xb0l/y7P3PBFNc+/LyMNHKcm1pULHzOGat/G5wImOgIeciGj7YGsROopRh
        GbTfZ4xfFnNGzrH8ZxUh0Tx6Wi69mAVvhoEaqBc8qK2Z4E+tkkyECYrMvKdYkE0wvTvQ9r
        JGMa1vFyW0JPoxHbKW+MbhunDvDJA1eZyEIvwCwHUWylH45amaC+7kvHqrUA0JqinwXEKs
        zsvHKGZFvdcQBlplyALBR99K4Vw+ViJOMAr6BZwaD5C21IRc1xdNrAYiVbStAceiV7LsVF
        FCO6JJqLbwZVkG6W0QJK9J1LTlKTW71s/B1WnZMvc7A/4SwttpgoN0WAPxPXhw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1686699574;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=BCwXFjxceFBs/QyeCz7aN0wJQMhwFQHZqSOS2loa870=;
        b=odIhUHA4JA31nw6HfTPicKtgbAQs4bnx/FYFS//ZVY0k7HjsO0f2PkmK+O6bzmEbCgim23
        StapgH4fi3OUISAQ==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Linus Torvalds <torvalds@linux-foundation.org>,
        Nikolay Borisov <nik.borisov@suse.com>,
        "Ahmed S. Darwish" <darwi@linutronix.de>,
        Arnd Bergmann <arnd@arndb.de>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        linux-sh@vger.kernel.org, Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org, linux-ia64@vger.kernel.org,
        Huacai Chen <chenhuacai@kernel.org>,
        WANG Xuerui <kernel@xen0n.name>, loongarch@lists.linux.dev,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-m68k@lists.linux-m68k.org,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-mips@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        sparclinux@vger.kernel.org, Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        linux-um@lists.infradead.org,
        Richard Henderson <richard.henderson@linaro.org>,
        "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Chris Zankel <chris@zankel.net>,
        Tom Lendacky <thomas.lendacky@amd.com>
Subject: [patch 08/17] sh/cpu: Switch to arch_cpu_finalize_init()
References: <20230613223827.532680283@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Wed, 14 Jun 2023 01:39:33 +0200 (CEST)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

check_bugs() is about to be phased out. Switch over to the new
arch_cpu_finalize_init() implementation.

No functional change.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: Rich Felker <dalias@libc.org>
Cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: linux-sh@vger.kernel.org
---
 arch/sh/Kconfig                 |    1 
 arch/sh/include/asm/bugs.h      |   74 ----------------------------------------
 arch/sh/include/asm/processor.h |    2 +
 arch/sh/kernel/idle.c           |    1 
 arch/sh/kernel/setup.c          |   55 +++++++++++++++++++++++++++++
 5 files changed, 59 insertions(+), 74 deletions(-)

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
--- a/arch/sh/include/asm/processor.h
+++ b/arch/sh/include/asm/processor.h
@@ -166,6 +166,8 @@ extern unsigned int instruction_size(uns
 #define instruction_size(insn)	(2)
 #endif
 
+void select_idle_routine(void);
+
 #endif /* __ASSEMBLY__ */
 
 #include <asm/processor_32.h>
--- a/arch/sh/kernel/idle.c
+++ b/arch/sh/kernel/idle.c
@@ -15,6 +15,7 @@
 #include <linux/irqflags.h>
 #include <linux/smp.h>
 #include <linux/atomic.h>
+#include <asm/processor.h>
 #include <asm/smp.h>
 #include <asm/bl_bit.h>
 
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

