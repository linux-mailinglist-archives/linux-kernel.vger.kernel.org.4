Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A385D68A52E
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 23:05:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233356AbjBCWFo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Feb 2023 17:05:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230114AbjBCWFn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Feb 2023 17:05:43 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39599945ED;
        Fri,  3 Feb 2023 14:05:42 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C73686200C;
        Fri,  3 Feb 2023 22:05:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C488C433EF;
        Fri,  3 Feb 2023 22:05:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675461941;
        bh=Yfz7LDRr9C5stKW6l039uMgeR9w4g6B/htPQVWCmvo0=;
        h=From:To:Cc:Subject:Date:From;
        b=hT/RSWKOfEB8jVVNR5UZ+ZbSj3FXLQ0xxyrY0heskGWE6khYrrAFQ76LYykM4i9o8
         irBoG35w/xMGiAEWy8hEkn9Q1tIzJzxmXAljxc/iWYKnUXFrHhRYGep0nxJSoT9spP
         4dB2u1vvWVrwhpcumbKdCJR0B2wTRgDCB5121JafDUwhKmELKjCdPeOrwXK5eLJDjK
         tyz30wSd9T+Wd8Rt8ftd27zDruJpmQXIwZCt+CSiXATiejyCyi516LIlzhPyorZH8T
         WTNmRq1LmErrBsj/ynnHP8Qccsk6gRrw9tAaXNUSu/osCJkwqecmj01XHOVKQ9ef7f
         Ezggi0dcZPCBQ==
From:   Josh Poimboeuf <jpoimboe@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     jgross@suse.com, richard.henderson@linaro.org,
        ink@jurassic.park.msu.ru, mattst88@gmail.com,
        linux-alpha@vger.kernel.org, linux@armlinux.org.uk,
        linux-arm-kernel@lists.infradead.org, catalin.marinas@arm.com,
        will@kernel.org, guoren@kernel.org, linux-csky@vger.kernel.org,
        linux-ia64@vger.kernel.org, chenhuacai@kernel.org,
        kernel@xen0n.name, loongarch@lists.linux.dev, f.fainelli@gmail.com,
        bcm-kernel-feedback-list@broadcom.com, tsbogend@alpha.franken.de,
        linux-mips@vger.kernel.org, jiaxun.yang@flygoat.com,
        mpe@ellerman.id.au, npiggin@gmail.com, christophe.leroy@csgroup.eu,
        linuxppc-dev@lists.ozlabs.org, ysato@users.sourceforge.jp,
        dalias@libc.org, linux-sh@vger.kernel.org, davem@davemloft.net,
        sparclinux@vger.kernel.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
        hpa@zytor.com, chris@zankel.net, jcmvbkbc@gmail.com,
        linux-xtensa@linux-xtensa.org, peterz@infradead.org,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        paulmck@kernel.org
Subject: [PATCH 00/22] cpu,sched: Mark arch_cpu_idle_dead() __noreturn
Date:   Fri,  3 Feb 2023 14:05:09 -0800
Message-Id: <cover.1675461757.git.jpoimboe@kernel.org>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These are some minor changes to enable the __noreturn attribute for
arch_cpu_idle_dead().  (If there are no objections, I can merge the
entire set through the tip tree.)

Until recently [1], in Xen, when a previously offlined CPU was brought
back online, it unexpectedly resumed execution where it left off in the
middle of the idle loop by returning from play_dead() and its caller
arch_cpu_idle_dead().

There were some clever hacks to make that work, but the behavior was
surprising as do_idle() doesn't expect an offlined CPU to return from
the dead in the middle of the function.

Now that Xen has been fixed, make sure arch_cpu_idle_dead() never
returns by marking it __noreturn.  This causes the compiler to complain
if an arch-specific implementation might return.  It also improves code
generation for both caller and callee.

Patches 1-20 update the arch-specific implementations of the function so
they don't actually return (even in error cases), and make that visible
to the compiler.  That's typically done by ending the function with a
call to another noreturn function, or with a BUG().

Patch 21 fixes the weak implementation.

Patch 22 actually adds the __noreturn attribute.

[1] 076cbf5d2163 ("x86/xen: don't let xen_pv_play_dead() return")

Josh Poimboeuf (22):
  alpha/cpu: Expose arch_cpu_idle_dead()'s prototype declaration
  alpha/cpu: Make sure arch_cpu_idle_dead() doesn't return
  arm/cpu: Make sure arch_cpu_idle_dead() doesn't return
  arm64/cpu: Mark cpu_die() __noreturn
  csky/cpu: Make sure arch_cpu_idle_dead() doesn't return
  ia64/cpu: Mark play_dead() __noreturn
  loongarch/cpu: Make sure play_dead() doesn't return
  loongarch/cpu: Mark play_dead() __noreturn
  mips/cpu: Expose play_dead()'s prototype definition
  mips/cpu: Make sure play_dead() doesn't return
  mips/cpu: Mark play_dead() __noreturn
  powerpc/cpu: Mark start_secondary_resume() __noreturn
  sh/cpu: Make sure play_dead() doesn't return
  sh/cpu: Mark play_dead() __noreturn
  sh/cpu: Expose arch_cpu_idle_dead()'s prototype definition
  sparc/cpu: Mark cpu_play_dead() __noreturn
  x86/cpu: Make sure play_dead() doesn't return
  x86/cpu: Mark play_dead() __noreturn
  xtensa/cpu: Make sure cpu_die() doesn't return
  xtensa/cpu: Mark cpu_die() __noreturn
  sched/idle: Make sure weak version of arch_cpu_idle_dead() doesn't
    return
  sched/idle: Mark arch_cpu_idle_dead() __noreturn

 arch/alpha/kernel/process.c      | 2 ++
 arch/arm/kernel/smp.c            | 2 ++
 arch/arm64/include/asm/smp.h     | 2 +-
 arch/csky/kernel/smp.c           | 2 ++
 arch/ia64/kernel/process.c       | 4 ++--
 arch/loongarch/include/asm/smp.h | 2 +-
 arch/loongarch/kernel/smp.c      | 2 +-
 arch/mips/include/asm/smp.h      | 2 +-
 arch/mips/kernel/smp-bmips.c     | 3 +++
 arch/mips/loongson64/smp.c       | 1 +
 arch/powerpc/include/asm/smp.h   | 2 +-
 arch/sh/include/asm/smp-ops.h    | 5 +++--
 arch/sh/kernel/idle.c            | 1 +
 arch/sparc/include/asm/smp_64.h  | 2 +-
 arch/x86/include/asm/smp.h       | 3 ++-
 arch/x86/kernel/process.c        | 2 +-
 arch/xtensa/include/asm/smp.h    | 2 +-
 arch/xtensa/kernel/smp.c         | 2 ++
 include/linux/cpu.h              | 2 +-
 kernel/sched/idle.c              | 2 +-
 tools/objtool/check.c            | 1 +
 21 files changed, 31 insertions(+), 15 deletions(-)

-- 
2.39.0

