Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CF8272F04E
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 01:42:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241751AbjFMXks (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 19:40:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241484AbjFMXkD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 19:40:03 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D56C1FE8;
        Tue, 13 Jun 2023 16:39:40 -0700 (PDT)
Message-ID: <20230613224545.553215951@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1686699578;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=k8gjwvZjutOT4dHhfWGxf+PGA1gm8Km0IyXoTok3KA4=;
        b=v8W2XlvrpPYRmnFVsA9HCf8AAEeUri3PKcSbwDBhRbwhqwQtRa3HmK1Q+2f3969zDWfvCU
        f+45JzSz4x2sdDMrg3PbRK6O6edSMK7X4fWklqVXtDdM8riwj3C1GuSs1kx0LdAlT//Eor
        bWuSkiP+eaVkqgryQSWe6lTFzhiT6zcxiSb48g5a2o3AOWjohXwIvwDSxjCOLeBhgj0rYc
        n9XKsHvBvxp6nhVkTdEQcV0esMuw3gJKVWlJUzMzD7i2EQ1VKtn2Y5gr3xWEUZBjeBe10Z
        BKcwkG0HAbUoDhfKVkxh2Ta5dC63PTBYjC0UsQ8d0hP2nAr1e5mgtdUqvnRrfg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1686699578;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=k8gjwvZjutOT4dHhfWGxf+PGA1gm8Km0IyXoTok3KA4=;
        b=9oeXgEFxRyb4tlolxuBtEo2cOgt2q8mFUTkLY9QzVOjoN+gPO7c+6pTf6+CANvmFHTzX+s
        vdUXlgL1JBLstfAQ==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Linus Torvalds <torvalds@linux-foundation.org>,
        Nikolay Borisov <nik.borisov@suse.com>,
        "Ahmed S. Darwish" <darwi@linutronix.de>,
        Arnd Bergmann <arnd@arndb.de>,
        Richard Henderson <richard.henderson@linaro.org>,
        "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Chris Zankel <chris@zankel.net>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org, linux-ia64@vger.kernel.org,
        Huacai Chen <chenhuacai@kernel.org>,
        WANG Xuerui <kernel@xen0n.name>, loongarch@lists.linux.dev,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-m68k@lists.linux-m68k.org,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-mips@vger.kernel.org,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        linux-sh@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
        sparclinux@vger.kernel.org, Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        linux-um@lists.infradead.org,
        Tom Lendacky <thomas.lendacky@amd.com>
Subject: [patch 11/17] init: Remove check_bugs() leftovers
References: <20230613223827.532680283@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Wed, 14 Jun 2023 01:39:38 +0200 (CEST)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Everything is converted over to arch_cpu_finalize_init(). Remove the
check_bugs() leftovers including the empty stubs in asm-generic, alpha,
parisc, powerpc and xtensa.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Richard Henderson <richard.henderson@linaro.org>
Cc: "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Chris Zankel <chris@zankel.net>
---
 arch/alpha/include/asm/bugs.h   |   20 --------------------
 arch/parisc/include/asm/bugs.h  |   20 --------------------
 arch/powerpc/include/asm/bugs.h |   15 ---------------
 arch/xtensa/include/asm/bugs.h  |   18 ------------------
 include/asm-generic/bugs.h      |   11 -----------
 init/main.c                     |    5 -----
 6 files changed, 89 deletions(-)

--- a/arch/alpha/include/asm/bugs.h
+++ /dev/null
@@ -1,20 +0,0 @@
-/*
- *  include/asm-alpha/bugs.h
- *
- *  Copyright (C) 1994  Linus Torvalds
- */
-
-/*
- * This is included by init/main.c to check for architecture-dependent bugs.
- *
- * Needs:
- *	void check_bugs(void);
- */
-
-/*
- * I don't know of any alpha bugs yet.. Nice chip
- */
-
-static void check_bugs(void)
-{
-}
--- a/arch/parisc/include/asm/bugs.h
+++ /dev/null
@@ -1,20 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-/*
- *  include/asm-parisc/bugs.h
- *
- *  Copyright (C) 1999	Mike Shaver
- */
-
-/*
- * This is included by init/main.c to check for architecture-dependent bugs.
- *
- * Needs:
- *	void check_bugs(void);
- */
-
-#include <asm/processor.h>
-
-static inline void check_bugs(void)
-{
-//	identify_cpu(&boot_cpu_data);
-}
--- a/arch/powerpc/include/asm/bugs.h
+++ /dev/null
@@ -1,15 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-or-later */
-#ifndef _ASM_POWERPC_BUGS_H
-#define _ASM_POWERPC_BUGS_H
-
-/*
- */
-
-/*
- * This file is included by 'init/main.c' to check for
- * architecture-dependent bugs.
- */
-
-static inline void check_bugs(void) { }
-
-#endif	/* _ASM_POWERPC_BUGS_H */
--- a/arch/xtensa/include/asm/bugs.h
+++ /dev/null
@@ -1,18 +0,0 @@
-/*
- * include/asm-xtensa/bugs.h
- *
- * This is included by init/main.c to check for architecture-dependent bugs.
- *
- * Xtensa processors don't have any bugs.  :)
- *
- * This file is subject to the terms and conditions of the GNU General
- * Public License.  See the file "COPYING" in the main directory of
- * this archive for more details.
- */
-
-#ifndef _XTENSA_BUGS_H
-#define _XTENSA_BUGS_H
-
-static void check_bugs(void) { }
-
-#endif /* _XTENSA_BUGS_H */
--- a/include/asm-generic/bugs.h
+++ /dev/null
@@ -1,11 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef __ASM_GENERIC_BUGS_H
-#define __ASM_GENERIC_BUGS_H
-/*
- * This file is included by 'init/main.c' to check for
- * architecture-dependent bugs.
- */
-
-static inline void check_bugs(void) { }
-
-#endif	/* __ASM_GENERIC_BUGS_H */
--- a/init/main.c
+++ b/init/main.c
@@ -103,7 +103,6 @@
 #include <net/net_namespace.h>
 
 #include <asm/io.h>
-#include <asm/bugs.h>
 #include <asm/setup.h>
 #include <asm/sections.h>
 #include <asm/cacheflush.h>
@@ -1079,10 +1078,6 @@ asmlinkage __visible void __init __no_sa
 	delayacct_init();
 
 	arch_cpu_finalize_init();
-	/* Temporary conditional until everything has been converted */
-#ifndef CONFIG_ARCH_HAS_CPU_FINALIZE_INIT
-	check_bugs();
-#endif
 
 	acpi_subsystem_init();
 	arch_post_acpi_subsys_init();

