Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFAB872F06B
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 01:42:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241936AbjFMXl0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 19:41:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241616AbjFMXkI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 19:40:08 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 051311985;
        Tue, 13 Jun 2023 16:39:46 -0700 (PDT)
Message-ID: <20230613224545.783704297@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1686699584;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=Gb5sLOwcDGGXCtx9H68t6SKa9rJuuFgNMIgGpRA1Cww=;
        b=OnpchWKJJhpq6ONVVpZ9c6pjV8+YWD6D9ACsa/8z515oMg42/3uYESxEQtaaT0ZhA+Bg4D
        buKV/TS+gn3oROep32cD9pSlOuxkNN9gN1FI793/jM6gaP61aGgNBMspBhF24cVrqNkwmP
        6ZpLhrFqrdHTnl2F9db2HisP72PB5PFG31yDOZj7xCPFtzA0i/wVmqWvn4/B7KPU4C+g+A
        Hb0tBXmvL2dCVGkZKLYp8zxv+/uly8bkLAHYCsjdnPbgTYze9gOUtyNazJsma861n1vfxT
        FzX8CKJnzmPKSylUT3jSpbeQwCYY0b1DBlyPWRtKlKctXCqDI1gfU4iKjo3u0Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1686699584;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=Gb5sLOwcDGGXCtx9H68t6SKa9rJuuFgNMIgGpRA1Cww=;
        b=KeoNcLCZt1pscWtsZI+qPvC+QWWzBTddeaCrGnRrGuOteDQ3sqa2Z5VDUdEJeOoM1IwMZE
        +u5kYsrLmjkwanCA==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Linus Torvalds <torvalds@linux-foundation.org>,
        Nikolay Borisov <nik.borisov@suse.com>,
        "Ahmed S. Darwish" <darwi@linutronix.de>,
        Arnd Bergmann <arnd@arndb.de>,
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
        Richard Henderson <richard.henderson@linaro.org>,
        "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Chris Zankel <chris@zankel.net>,
        Tom Lendacky <thomas.lendacky@amd.com>
Subject: [patch 15/17] x86/fpu: Remove cpuinfo argument from init functions
References: <20230613223827.532680283@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Wed, 14 Jun 2023 01:39:43 +0200 (CEST)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Nothing in the call chain requires it

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/include/asm/fpu/api.h |    2 +-
 arch/x86/kernel/cpu/common.c   |    2 +-
 arch/x86/kernel/fpu/init.c     |    6 +++---
 3 files changed, 5 insertions(+), 5 deletions(-)

--- a/arch/x86/include/asm/fpu/api.h
+++ b/arch/x86/include/asm/fpu/api.h
@@ -109,7 +109,7 @@ extern void fpu_reset_from_exception_fix
 
 /* Boot, hotplug and resume */
 extern void fpu__init_cpu(void);
-extern void fpu__init_system(struct cpuinfo_x86 *c);
+extern void fpu__init_system(void);
 extern void fpu__init_check_bugs(void);
 extern void fpu__resume_cpu(void);
 
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -1604,7 +1604,7 @@ static void __init early_identify_cpu(st
 
 	sld_setup(c);
 
-	fpu__init_system(c);
+	fpu__init_system();
 
 #ifdef CONFIG_X86_32
 	/*
--- a/arch/x86/kernel/fpu/init.c
+++ b/arch/x86/kernel/fpu/init.c
@@ -71,7 +71,7 @@ static bool fpu__probe_without_cpuid(voi
 	return fsw == 0 && (fcw & 0x103f) == 0x003f;
 }
 
-static void fpu__init_system_early_generic(struct cpuinfo_x86 *c)
+static void fpu__init_system_early_generic(void)
 {
 	if (!boot_cpu_has(X86_FEATURE_CPUID) &&
 	    !test_bit(X86_FEATURE_FPU, (unsigned long *)cpu_caps_cleared)) {
@@ -211,10 +211,10 @@ static void __init fpu__init_system_xsta
  * Called on the boot CPU once per system bootup, to set up the initial
  * FPU state that is later cloned into all processes:
  */
-void __init fpu__init_system(struct cpuinfo_x86 *c)
+void __init fpu__init_system(void)
 {
 	fpstate_reset(&current->thread.fpu);
-	fpu__init_system_early_generic(c);
+	fpu__init_system_early_generic();
 
 	/*
 	 * The FPU has to be operational for some of the

