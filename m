Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAC0E68C0CA
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 15:57:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230478AbjBFO5y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 09:57:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229781AbjBFO5t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 09:57:49 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F3B1173F;
        Mon,  6 Feb 2023 06:57:47 -0800 (PST)
Date:   Mon, 06 Feb 2023 14:57:45 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1675695466;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=u0cRwDFFeyyBCcpfxEvnKuN5Z21qRvhqvSRSuq4tsBg=;
        b=EjJFnkjqsCCxCZnM626quE/i0qaaMnz7pMAiEI9x/ImElucEJoxTGRD0cllVJxcQzluESU
        /byi0Dvzi3b3e004/RZX31J6yCNRvmrrWAY2/99C8JVM2/+OkqHdRbl1bO0HTDt0hyWgUd
        veSSMzJfQ3ExHG7rlQksGldxmDBHFOpEN6Z3ewCGp0CzCPYl1M2F6GWA2J3ROAMTY1tWwj
        btsU21FaRfn+2w8U9HMdmwA850GfCxHICOsrDUc0A1nWueGKIZEJ2C9s6OP6NaICBS/GdG
        qMTGrdnxbMgEH+y78kYN17z6GHXdcmaBDtqfyJc5U/kg20wsTcldLA5NdH4Fbg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1675695466;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=u0cRwDFFeyyBCcpfxEvnKuN5Z21qRvhqvSRSuq4tsBg=;
        b=A1NIFZCbz+D6Y6JJWfVzZHH967C50Ic2BcjMb2N96WWxdGkHjyAmdzXp1snVNgHkFEytwd
        B6g+FiwjT7jwd4CA==
From:   "tip-bot2 for Sebastian Andrzej Siewior" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/vdso] x86/vdso: Provide getcpu for x86-32.
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20221125094216.3663444-3-bigeasy@linutronix.de>
References: <20221125094216.3663444-3-bigeasy@linutronix.de>
MIME-Version: 1.0
Message-ID: <167569546559.4906.16477266241418977603.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/vdso branch of tip:

Commit-ID:     92d33063c081a82d25dd08a9cce03947c8ed9164
Gitweb:        https://git.kernel.org/tip/92d33063c081a82d25dd08a9cce03947c8ed9164
Author:        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
AuthorDate:    Fri, 25 Nov 2022 10:42:15 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 06 Feb 2023 15:48:54 +01:00

x86/vdso: Provide getcpu for x86-32.

Wire up __vdso_getcpu() for x86-32.

The 64bit version is reused with trivial modifications. Contrary to
vclock_gettime.c there is no requirement to fake any defines in the case of
32bit VDSO on a 64bit kernel because the GDT entry from which the CPU and
node information is read is always the native one.

Adopt vdso_getcpu.c by:

 - removing the unneeded time* header files which lead to compile errors
   for 32bit.
 - adding segment.h which provides vdso_read_cpunode() and the defines
   required by it.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20221125094216.3663444-3-bigeasy@linutronix.de
---
 arch/x86/entry/vdso/Makefile            | 3 ++-
 arch/x86/entry/vdso/vdso32/vdso32.lds.S | 1 +
 arch/x86/entry/vdso/vdso32/vgetcpu.c    | 2 ++
 arch/x86/entry/vdso/vgetcpu.c           | 3 +--
 4 files changed, 6 insertions(+), 3 deletions(-)
 create mode 100644 arch/x86/entry/vdso/vdso32/vgetcpu.c

diff --git a/arch/x86/entry/vdso/Makefile b/arch/x86/entry/vdso/Makefile
index 838613a..1506a22 100644
--- a/arch/x86/entry/vdso/Makefile
+++ b/arch/x86/entry/vdso/Makefile
@@ -29,7 +29,7 @@ VDSO32-$(CONFIG_IA32_EMULATION)	:= y
 # files to link into the vdso
 vobjs-y := vdso-note.o vclock_gettime.o vgetcpu.o
 vobjs32-y := vdso32/note.o vdso32/system_call.o vdso32/sigreturn.o
-vobjs32-y += vdso32/vclock_gettime.o
+vobjs32-y += vdso32/vclock_gettime.o vdso32/vgetcpu.o
 vobjs-$(CONFIG_X86_SGX)	+= vsgx.o
 
 # files to link into kernel
@@ -104,6 +104,7 @@ $(vobjs): KBUILD_AFLAGS += -DBUILD_VDSO
 CFLAGS_REMOVE_vclock_gettime.o = -pg
 CFLAGS_REMOVE_vdso32/vclock_gettime.o = -pg
 CFLAGS_REMOVE_vgetcpu.o = -pg
+CFLAGS_REMOVE_vdso32/vgetcpu.o = -pg
 CFLAGS_REMOVE_vsgx.o = -pg
 
 #
diff --git a/arch/x86/entry/vdso/vdso32/vdso32.lds.S b/arch/x86/entry/vdso/vdso32/vdso32.lds.S
index c772099..8a3be07 100644
--- a/arch/x86/entry/vdso/vdso32/vdso32.lds.S
+++ b/arch/x86/entry/vdso/vdso32/vdso32.lds.S
@@ -28,6 +28,7 @@ VERSION
 		__vdso_time;
 		__vdso_clock_getres;
 		__vdso_clock_gettime64;
+		__vdso_getcpu;
 	};
 
 	LINUX_2.5 {
diff --git a/arch/x86/entry/vdso/vdso32/vgetcpu.c b/arch/x86/entry/vdso/vdso32/vgetcpu.c
new file mode 100644
index 0000000..b777f84
--- /dev/null
+++ b/arch/x86/entry/vdso/vdso32/vgetcpu.c
@@ -0,0 +1,2 @@
+// SPDX-License-Identifier: GPL-2.0
+#include "../vgetcpu.c"
diff --git a/arch/x86/entry/vdso/vgetcpu.c b/arch/x86/entry/vdso/vgetcpu.c
index b88a82b..0a9007c 100644
--- a/arch/x86/entry/vdso/vgetcpu.c
+++ b/arch/x86/entry/vdso/vgetcpu.c
@@ -7,8 +7,7 @@
 
 #include <linux/kernel.h>
 #include <linux/getcpu.h>
-#include <linux/time.h>
-#include <asm/vgtod.h>
+#include <asm/segment.h>
 
 notrace long
 __vdso_getcpu(unsigned *cpu, unsigned *node, struct getcpu_cache *unused)
