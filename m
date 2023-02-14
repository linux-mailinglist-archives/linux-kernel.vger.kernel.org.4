Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0513D6959C5
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 08:07:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231898AbjBNHHg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 02:07:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231414AbjBNHHZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 02:07:25 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C11C1F5DD;
        Mon, 13 Feb 2023 23:06:59 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0511061451;
        Tue, 14 Feb 2023 07:06:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD53CC433EF;
        Tue, 14 Feb 2023 07:06:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676358408;
        bh=RKzZmEQ0aGTy+gbzBwQMcZ+ax04gqBZYglhP2Mxomuo=;
        h=From:To:Cc:Subject:Date:From;
        b=FeDhahtj5zTcKfS87v8/QfdL3FiuaRKBYgvZJuSr3uTqDOUDpR9xAIwfSUUl+xCQ4
         r7S+eXVH1xqLNIUZnh/cHtuO1wDJDQW64m8IJbGmNTGNy+/CBDE3sNH46BYhM8ZJzq
         hySTqkxhjf0gavLtGi4niNQiqmOkWmn2no49fQG3W+sIsnBFMBNtI28+cWarf+lgjw
         EkIBlAg10MBeQ6FOIITajEZQjSMDxh0fHI3x8obz1DyGtW5I15c9zlJwXVZxpo4sQS
         v0B/B1Cs/GdU7oUHS5iP/TM7GdZXf5Rr8enZUnuUAzcybm31QTM4L2TA1DoDr3aD30
         9f3vJpb0gcS8w==
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
Subject: [PATCH v2 00/24] cpu,sched: Mark arch_cpu_idle_dead() __noreturn
Date:   Mon, 13 Feb 2023 23:05:34 -0800
Message-Id: <cover.1676358308.git.jpoimboe@kernel.org>
X-Mailer: git-send-email 2.39.1
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

v2:
- make arch_call_rest_init() and rest_init() __noreturn
- make objtool 'global_returns' work for weak functions
- rebase on tip/objtool/core with dependencies merged in (mingo)
- add acks

v1.1:
- add __noreturn to all arch_cpu_idle_dead() implementations (mpe)

Josh Poimboeuf (24):
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
  objtool: Include weak functions in 'global_noreturns' check
  init: Make arch_call_rest_init() and rest_init() __noreturn
  sched/idle: Mark arch_cpu_idle_dead() __noreturn

 arch/alpha/kernel/process.c      |  4 +++-
 arch/arm/kernel/smp.c            |  4 +++-
 arch/arm64/include/asm/smp.h     |  2 +-
 arch/arm64/kernel/process.c      |  2 +-
 arch/csky/kernel/smp.c           |  4 +++-
 arch/ia64/kernel/process.c       |  6 +++---
 arch/loongarch/include/asm/smp.h |  2 +-
 arch/loongarch/kernel/process.c  |  2 +-
 arch/loongarch/kernel/smp.c      |  2 +-
 arch/mips/include/asm/smp.h      |  2 +-
 arch/mips/kernel/process.c       |  2 +-
 arch/mips/kernel/smp-bmips.c     |  3 +++
 arch/mips/loongson64/smp.c       |  1 +
 arch/parisc/kernel/process.c     |  2 +-
 arch/powerpc/include/asm/smp.h   |  2 +-
 arch/powerpc/kernel/smp.c        |  2 +-
 arch/riscv/kernel/cpu-hotplug.c  |  2 +-
 arch/s390/kernel/idle.c          |  2 +-
 arch/s390/kernel/setup.c         |  2 +-
 arch/sh/include/asm/smp-ops.h    |  5 +++--
 arch/sh/kernel/idle.c            |  3 ++-
 arch/sparc/include/asm/smp_64.h  |  2 +-
 arch/sparc/kernel/process_64.c   |  2 +-
 arch/x86/include/asm/smp.h       |  3 ++-
 arch/x86/kernel/process.c        |  4 ++--
 arch/xtensa/include/asm/smp.h    |  2 +-
 arch/xtensa/kernel/smp.c         |  4 +++-
 include/linux/cpu.h              |  2 +-
 include/linux/start_kernel.h     |  4 ++--
 init/main.c                      |  4 ++--
 kernel/sched/idle.c              |  2 +-
 tools/objtool/check.c            | 11 +++++++----
 32 files changed, 57 insertions(+), 39 deletions(-)

-- 
2.39.1

