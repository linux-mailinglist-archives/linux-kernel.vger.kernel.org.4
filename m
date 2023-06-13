Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A43EE72F01A
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 01:39:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240675AbjFMXjd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 19:39:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238613AbjFMXj0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 19:39:26 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B9D21989;
        Tue, 13 Jun 2023 16:39:24 -0700 (PDT)
Message-ID: <20230613223827.532680283@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1686699562;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=zGcwSkjRu8UFPTZ5Hk2Js/azQZ9pUpsGsLPKi5+wHk4=;
        b=1vl6UXgCAJSEGSzD8t6gUcoJc5169AwVrpA21nUOBZK5joseTFTf4tOCJuSxYeH8jjiG5a
        jEyyQE8u/hzl94Ysm1rJG2YnzoQg/tcACXTl7p0VwWp1Hg5BBJMua3yUhYob6t9+1w2mee
        490vMvkq9U3+kLEoOiWcYf6hGufEEl+RY32dXE3KaUMRZAu87C+A2xK5wy++4GlmwK3EZB
        Z5VXWqjjyIYWILTQXObbl4QE63VzmXuPdS4shWyoeGuVxCCmwUXoumayy+XcSsFxFG+bU7
        NlI/LWfvrG5jqcCo56KbCsG3Df/lECSRqYeR0pyPUxwGWLhUnEuZlGh+hhMUzg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1686699562;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=zGcwSkjRu8UFPTZ5Hk2Js/azQZ9pUpsGsLPKi5+wHk4=;
        b=c2klUM1ewA5e7Mdg+k2IbCC4Vl2VvLKpWjP1RVCx9kwxZJ2Q99tmqHfyKPV09o7em5evQ2
        Pbn7SMSiRq5L4VBA==
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
Subject: [patch 00/17] init, treewide, x86: Cleanup check_bugs() and start
 sanitizing the x86 boot process
Date:   Wed, 14 Jun 2023 01:39:21 +0200 (CEST)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

My team and myself are working on sanitizing the x86 boot process,
especially the complete horror show of CPUID evaluation, which is
constructed with hay-wire circuits, duct tape and superglue.

A related goal is to move the initialization of infrastructure which is not
required during early boot out into a later phase of the boot process.
Early boot is fragile and convoluted enough already, so anything which can
move into a later phase is a win.

X86 FPU initialization is one of the obvious parts which has zero
justification to be done early. The only requirement is that it happens
before alternative patching. Doing it early also requires custom command
line parsing which can be obviously avoided when the initialization happens
later.

Alternative patching happens from check_bugs() which is invoked late in
start_kernel(). Moving FPU initialization into that is too late because
check_bugs() is invoked after fork_init(), but fork_init() requires that
the FPU is initialized on X86 as on X86 the size of task_struct depends on
the FPU register buffer size.

In order to avoid another magic function we set out to move check_bugs()
earlier and inspected all incarnations whether there is any reason to do
that so late. It turned out there is none (famous last words), but it also
revealed that check_bugs() is a gross misnomer.

check_bugs() has become a dump ground for finalizing the CPU initialization
before running the rest of the init code.

Most implementations are empty, a few do actual bug checks, some do
alternative patching and one cobbles a CPU advertisment string together...

As a consequence we decided to rename it to arch_cpu_finalize_init(). The
purely mechanical 's/check_bugs/arch_cpu_finalize_init/' would have been
trivial, but having stared at the actual implementations of check_bugs()
had triggered the scavenger reflex already. So I got the mop out and
cleaned it up completely.

The resulting series consists therefore of three parts:

 1) Patches 1-11

    Rename and mop up check_bugs() which removes a solid amount of
    redundant historical copy & pasta crud:

    39 files changed, 161 insertions(+), 321 deletions(-)

    11 out of the 39 changed files are removed completely.

 2) Patches 12-13

    Move the invocation of arch_cpu_finalize_init() earlier in
    start_kernel() and move the x86'ism mem_encrypt_init() into the x86
    space.

 3) Patches 14-17

    Implement the late FPU initialization for X86 on top. Removal of the
    custom early command line parsing is subject to separate x86 specific
    changes. This part #3 is to illustrate the use case for #2.

The series applies on Linus tree and is also available from git:

    git://git.kernel.org/pub/scm/linux/kernel/git/tglx/devel.git init

Thanks,

	tglx
---
 a/arch/alpha/include/asm/bugs.h     |   20 ---------
 a/arch/ia64/include/asm/bugs.h      |   20 ---------
 a/arch/loongarch/include/asm/bugs.h |   15 ------
 a/arch/m68k/include/asm/bugs.h      |   21 ---------
 a/arch/parisc/include/asm/bugs.h    |   20 ---------
 a/arch/powerpc/include/asm/bugs.h   |   15 ------
 a/arch/sh/include/asm/bugs.h        |   74 ---------------------------------
 a/arch/sparc/include/asm/bugs.h     |   18 --------
 a/arch/um/include/asm/bugs.h        |    7 ---
 a/arch/xtensa/include/asm/bugs.h    |   18 --------
 a/include/asm-generic/bugs.h        |   11 -----
 arch/Kconfig                        |    3 +
 arch/arm/Kconfig                    |    1 
 arch/arm/include/asm/bugs.h         |    4 -
 arch/arm/kernel/bugs.c              |    3 -
 arch/ia64/Kconfig                   |    1 
 arch/ia64/kernel/setup.c            |    3 -
 arch/loongarch/Kconfig              |    1 
 arch/loongarch/kernel/setup.c       |    4 -
 arch/m68k/Kconfig                   |    1 
 arch/m68k/kernel/setup_mm.c         |    3 -
 arch/mips/Kconfig                   |    1 
 arch/mips/include/asm/bugs.h        |   17 -------
 arch/mips/kernel/setup.c            |   13 +++++
 arch/sh/Kconfig                     |    1 
 arch/sh/include/asm/processor.h     |    2 
 arch/sh/kernel/idle.c               |    1 
 arch/sh/kernel/setup.c              |   55 +++++++++++++++++++++++++
 arch/sparc/Kconfig                  |    1 
 arch/sparc/kernel/setup_32.c        |    7 +++
 arch/um/Kconfig                     |    1 
 arch/um/kernel/um_arch.c            |    3 -
 arch/x86/Kconfig                    |    1 
 arch/x86/include/asm/bugs.h         |    2 
 arch/x86/include/asm/fpu/api.h      |    2 
 arch/x86/include/asm/mem_encrypt.h  |    7 +--
 arch/x86/include/asm/sigframe.h     |    2 
 arch/x86/kernel/cpu/bugs.c          |   51 -----------------------
 arch/x86/kernel/cpu/common.c        |   79 ++++++++++++++++++++++++++++++++----
 arch/x86/kernel/cpu/cpu.h           |    1 
 arch/x86/kernel/fpu/init.c          |    8 +--
 arch/x86/kernel/signal.c            |    4 +
 include/linux/cpu.h                 |    6 ++
 init/main.c                         |   16 -------
 44 files changed, 192 insertions(+), 352 deletions(-)

