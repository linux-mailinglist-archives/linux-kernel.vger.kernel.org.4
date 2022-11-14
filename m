Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03AA9627CC1
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 12:46:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236672AbiKNLqm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 06:46:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236765AbiKNLqF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 06:46:05 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2AFC2315D
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 03:45:03 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 505DA6106E
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 11:45:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5C99C4314E;
        Mon, 14 Nov 2022 11:45:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668426302;
        bh=6jLF3Au9Jv2wIjIVvswUXpj2PpU4T7lNtaA1NXDNBOM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=c4YB722iE9i9n7o4La+2/68ElAJk/ENrJDWwub5IjMQwrsNvbdovTdtnYYiVqNIbA
         rM+HNFsjMR4hlolITBP7Fwsv26I6qgBXdIwFGAOXLPNvO3aQf4YtHj5/YYsn6POrCN
         rn71tz+N7Q0f1dJaJs9jasaElQqXaluaD2iz2cXu4RFJEn52RW5m2aQX7Wn3mdsIR4
         MycUe+s1pbpKSIXUshnIkYm+mT03ixbt19GFzEEfNqmZy0TXWmhKHW6+mm2NfqEXVP
         8sSocr5JcNs4IdtcfS/kvM65FvB6LyYaaA532o+ljK7NFI6mrDHnEnI9LgBLZgMNRa
         lbqTThPypuD7w==
From:   "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Andi Kleen <ak@linux.intel.com>, Martin Liska <mliska@suse.cz>,
        Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 27/46] linkage, lto: use C version for SYSCALL_ALIAS() / cond_syscall()
Date:   Mon, 14 Nov 2022 12:43:25 +0100
Message-Id: <20221114114344.18650-28-jirislaby@kernel.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221114114344.18650-1-jirislaby@kernel.org>
References: <20221114114344.18650-1-jirislaby@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andi Kleen <ak@linux.intel.com>

With LTO, aliases get largely resolved in the compiler, not in the
linker.

Implement cond_syscall() and SYSCALL_ALIAS() in C to let the compiler
understand the aliases so that it can resolve them properly.

Likely, the architecture specific versions are now not needed anymore,
but they are kept for now.

There is one subtlety here:
The assembler version didn't care whether there was a prototype or not.
This variant assumes there is no prototype because it uses a dummy
(void) signature. This works for sys_ni.c, but breaks for
kernel/time/posix-stubs.c. To avoid problems there, a second variant of
the macro (_PROTO) is added. That uses the previously declared type
(by typeof()).

I actually tried to avoid this by adding prototypes for SYS_NI() and use
only the _PROTO variant, but it resulted in very large patches and lots
of problems with all the different cases. Eventually, I gave up and just
use the prototype case in posix-stubs.c

[js] gcc >= 8 emits Wattribute-alias warning. Work around that by
     __diag_*(). This is ugly, but due to gcc bug, I see no better
     option. Suggestions welcome.

Signed-off-by: Andi Kleen <ak@linux.intel.com>
Signed-off-by: Martin Liska <mliska@suse.cz>
Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 include/linux/linkage.h   | 16 ++++++++--------
 kernel/time/posix-stubs.c | 19 +++++++++++++++++--
 2 files changed, 25 insertions(+), 10 deletions(-)

diff --git a/include/linux/linkage.h b/include/linux/linkage.h
index 1feab6136b5b..688b9bb80e96 100644
--- a/include/linux/linkage.h
+++ b/include/linux/linkage.h
@@ -23,17 +23,17 @@
 #endif
 
 #ifndef cond_syscall
-#define cond_syscall(x)	asm(				\
-	".weak " __stringify(x) "\n\t"			\
-	".set  " __stringify(x) ","			\
-		 __stringify(sys_ni_syscall))
+#define cond_syscall(x)	\
+	extern long x(void) __attribute__((alias("sys_ni_syscall"), weak));
 #endif
 
 #ifndef SYSCALL_ALIAS
-#define SYSCALL_ALIAS(alias, name) asm(			\
-	".globl " __stringify(alias) "\n\t"		\
-	".set   " __stringify(alias) ","		\
-		  __stringify(name))
+#define SYSCALL_ALIAS(a, name) \
+	long a(void) __attribute__((alias(__stringify(name))))
+#define SYSCALL_ALIAS_PROTO(a, name) \
+	typeof(a) a __attribute__((alias(__stringify(name))))
+#else
+#define SYSCALL_ALIAS_PROTO(a, name) SYSCALL_ALIAS(a, name)
 #endif
 
 #define __page_aligned_data	__section(".data..page_aligned") __aligned(PAGE_SIZE)
diff --git a/kernel/time/posix-stubs.c b/kernel/time/posix-stubs.c
index 90ea5f373e50..23e1a63adc2b 100644
--- a/kernel/time/posix-stubs.c
+++ b/kernel/time/posix-stubs.c
@@ -31,13 +31,21 @@ asmlinkage long sys_ni_posix_timers(void)
 }
 
 #ifndef SYS_NI
-#define SYS_NI(name)  SYSCALL_ALIAS(sys_##name, sys_ni_posix_timers)
+#define SYS_NI(name)  SYSCALL_ALIAS_PROTO(sys_##name, sys_ni_posix_timers)
 #endif
 
 #ifndef COMPAT_SYS_NI
-#define COMPAT_SYS_NI(name)  SYSCALL_ALIAS(compat_sys_##name, sys_ni_posix_timers)
+#define COMPAT_SYS_NI(name) \
+	SYSCALL_ALIAS_PROTO(compat_sys_##name, sys_ni_posix_timers)
 #endif
 
+/*
+ * This cannot go to SYS_NI() or SYSCALL_ALIAS_PROTO() due to gcc bug fixed in
+ * gcc >= 13 (cf. PR 97498). I wonder how is __SYSCALL_DEFINEx() able to work?
+ */
+__diag_push();
+__diag_ignore(GCC, 8, "-Wattribute-alias", "Alias to nonimplemented syscall");
+
 SYS_NI(timer_create);
 SYS_NI(timer_gettime);
 SYS_NI(timer_getoverrun);
@@ -51,6 +59,8 @@ SYS_NI(clock_adjtime32);
 SYS_NI(alarm);
 #endif
 
+__diag_pop();
+
 /*
  * We preserve minimal support for CLOCK_REALTIME and CLOCK_MONOTONIC
  * as it is easy to remain compatible with little code. CLOCK_BOOTTIME
@@ -157,6 +167,9 @@ SYSCALL_DEFINE4(clock_nanosleep, const clockid_t, which_clock, int, flags,
 				 which_clock);
 }
 
+__diag_push();
+__diag_ignore(GCC, 8, "-Wattribute-alias", "Alias to nonimplemented syscall");
+
 #ifdef CONFIG_COMPAT
 COMPAT_SYS_NI(timer_create);
 #endif
@@ -170,6 +183,8 @@ COMPAT_SYS_NI(setitimer);
 SYS_NI(timer_settime32);
 SYS_NI(timer_gettime32);
 
+__diag_pop();
+
 SYSCALL_DEFINE2(clock_settime32, const clockid_t, which_clock,
 		struct old_timespec32 __user *, tp)
 {
-- 
2.38.1

