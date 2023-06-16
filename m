Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 176B1732B6C
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 11:25:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344297AbjFPJZn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 05:25:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344095AbjFPJYx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 05:24:53 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BD2626AF;
        Fri, 16 Jun 2023 02:24:50 -0700 (PDT)
Date:   Fri, 16 Jun 2023 09:24:45 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1686907485;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YZTWS/SmuIy5BfPauwJpZ7bZrTkvmO1D/YACfu7OakQ=;
        b=SxulI0rgwigPjRLa7nAPVIh1QuFoK0TvA7ycEVUcVRypRFJ40Gg88QhLVOGoifJjP/RoNG
        LW/EHwjnBN1L0nzGM3gJMQ00cWxpt8NZ038k7jGqh6mUUflGDIaN5oXd/d4OqSg29tgBtx
        Y7epxMmaWHJS25/jwLr4iCPBJgFYEBvTX64oSGi8SZs5SH4eLwlh5/blECAPkx71ORnvO4
        apc6Ch1PxenELWvBqGOJAPTVGMmqH4KOzyL6o7BG3KVTkzge2buClMEA9wTKQE6r5EYQIB
        OKgBuxCWcAJItbKqFjh2vFBIFL5h0lJ0T2WdOBqbmZXSp40DRhc3z9MyhiycmA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1686907485;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YZTWS/SmuIy5BfPauwJpZ7bZrTkvmO1D/YACfu7OakQ=;
        b=ng9chCFjclTqUn0+iuDeLO4cP/nycSjn8GZHXEgy0cHIDXGsE2YBfU8EmlEi4uo7IpHBB3
        nq+6iBJUMsUHeBCw==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/boot] init: Remove check_bugs() leftovers
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Richard Henderson <richard.henderson@linaro.org>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20230613224545.553215951@linutronix.de>
References: <20230613224545.553215951@linutronix.de>
MIME-Version: 1.0
Message-ID: <168690748517.404.6670831625304458737.tip-bot2@tip-bot2>
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

Commit-ID:     61235b24b9cb37c13fcad5b9596d59a1afdcec30
Gitweb:        https://git.kernel.org/tip/61235b24b9cb37c13fcad5b9596d59a1afdcec30
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Wed, 14 Jun 2023 01:39:38 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 16 Jun 2023 10:16:00 +02:00

init: Remove check_bugs() leftovers

Everything is converted over to arch_cpu_finalize_init(). Remove the
check_bugs() leftovers including the empty stubs in asm-generic, alpha,
parisc, powerpc and xtensa.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Link: https://lore.kernel.org/r/20230613224545.553215951@linutronix.de

---
 arch/alpha/include/asm/bugs.h   | 20 --------------------
 arch/parisc/include/asm/bugs.h  | 20 --------------------
 arch/powerpc/include/asm/bugs.h | 15 ---------------
 arch/xtensa/include/asm/bugs.h  | 18 ------------------
 include/asm-generic/bugs.h      | 11 -----------
 init/main.c                     |  5 -----
 6 files changed, 89 deletions(-)
 delete mode 100644 arch/alpha/include/asm/bugs.h
 delete mode 100644 arch/parisc/include/asm/bugs.h
 delete mode 100644 arch/powerpc/include/asm/bugs.h
 delete mode 100644 arch/xtensa/include/asm/bugs.h
 delete mode 100644 include/asm-generic/bugs.h

diff --git a/arch/alpha/include/asm/bugs.h b/arch/alpha/include/asm/bugs.h
deleted file mode 100644
index 78030d1..0000000
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
diff --git a/arch/parisc/include/asm/bugs.h b/arch/parisc/include/asm/bugs.h
deleted file mode 100644
index 0a7f9db..0000000
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
diff --git a/arch/powerpc/include/asm/bugs.h b/arch/powerpc/include/asm/bugs.h
deleted file mode 100644
index 01b8f6c..0000000
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
diff --git a/arch/xtensa/include/asm/bugs.h b/arch/xtensa/include/asm/bugs.h
deleted file mode 100644
index 69b29d1..0000000
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
diff --git a/include/asm-generic/bugs.h b/include/asm-generic/bugs.h
deleted file mode 100644
index 6902183..0000000
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
diff --git a/init/main.c b/init/main.c
index 77d5316..389ac62 100644
--- a/init/main.c
+++ b/init/main.c
@@ -103,7 +103,6 @@
 #include <net/net_namespace.h>
 
 #include <asm/io.h>
-#include <asm/bugs.h>
 #include <asm/setup.h>
 #include <asm/sections.h>
 #include <asm/cacheflush.h>
@@ -1079,10 +1078,6 @@ asmlinkage __visible void __init __no_sanitize_address __noreturn start_kernel(v
 	delayacct_init();
 
 	arch_cpu_finalize_init();
-	/* Temporary conditional until everything has been converted */
-#ifndef CONFIG_ARCH_HAS_CPU_FINALIZE_INIT
-	check_bugs();
-#endif
 
 	acpi_subsystem_init();
 	arch_post_acpi_subsys_init();
