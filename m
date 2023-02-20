Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A714D69CB73
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Feb 2023 13:55:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231655AbjBTMz0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 07:55:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231714AbjBTMzY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 07:55:24 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 941C814E9A
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 04:55:21 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id eg37so496417edb.12
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 04:55:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=DgZrbWeFA9j+he9UtLgDgb6cFaZYirSMMhpT8R84Vzw=;
        b=VRgsMgY7mK5uxk3CzVKiP1yyLJlo/CpK4wEr8aatK1dTEeHkwN+/jgk4okRgrP4v+F
         wjc+rCVVENz22PBq3Aj3zdg9XMVhU2H0A2q2xvIsvFp44UIvTmwcCB1oFleUjx3ZhB2h
         6F5o2enEE5BTYu8C4InJL2sTabHUvc795scVxjd7TsqzQCGMsn+gUgLLZeo892k6LVl2
         xtEfvdePiHubBA2UJxJTpDDXwyHU1g/NmxxJ4/K/0OVe6z7A1QhnFuQCGKdWhjdHxRp2
         mioMBC8idgWFtS4c/L3LTJr+m1VcnMlKtX9MjlrcB9dk9Hf3PPP4pPAeS35lfc7PLhME
         1o1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DgZrbWeFA9j+he9UtLgDgb6cFaZYirSMMhpT8R84Vzw=;
        b=CglJLWvNgWPyjvFDcYTNTQ0Hx+BuQIcSIwvZPwOxHc/4VtcGUNbxwLEv5365WBuWFe
         OwQTE4jmskNoXMIPKNaa66XodXCyP1z8MUzyGX6ah9ybA92l4ujw896325nYL8fUkQvf
         zcoERTl9VhtbOa+cVn6m73okD5z4iNeHTe5XHz0/lL/pPQ+/CUST9LPelf29rSsuaRoT
         004meVawWke+YCyozksRA3KZLCQC2FRkQPcwWPMfuU32f3/GMYZppK6UAmv6BZfW9kNF
         r/YMNZvBzu86sN+0AVcML8B1+dKcBrazgoZj+z4KroeiIxEFaIMnUgwsJohO5NuMFWpl
         hthQ==
X-Gm-Message-State: AO0yUKWxTqMHsoFKQ6pQn7aZiEqedSzuHfbcN5NNjh3khRK3zT6jb6Gu
        nioVzP57g0D0671Kbrl6vOY=
X-Google-Smtp-Source: AK7set8gY3KJLEKElEBp66mQnLHwnVWIYIdSDMMxAK7ANw5JtJzGseXwaL6r8gYvEPpcuURyqThB+g==
X-Received: by 2002:a17:907:888b:b0:878:6519:c740 with SMTP id rp11-20020a170907888b00b008786519c740mr11598740ejc.44.1676897719974;
        Mon, 20 Feb 2023 04:55:19 -0800 (PST)
Received: from gmail.com (1F2EF163.nat.pool.telekom.hu. [31.46.241.99])
        by smtp.gmail.com with ESMTPSA id kg19-20020a17090776f300b008be0b7242d5sm3208352ejc.90.2023.02.20.04.55.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Feb 2023 04:55:19 -0800 (PST)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Mon, 20 Feb 2023 13:55:17 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>
Subject: [GIT PULL] scheduler changes for v6.3
Message-ID: <Y/NttaqRZ+zaHIjo@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Linus,

Please pull the latest sched/core git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched-core-2023-02-20

   # HEAD: 7c4a5b89a0b5a57a64b601775b296abf77a9fe97 sched/rt: pick_next_rt_entity(): check list_entry

Scheduler updates in this cycle are:

 - Improve the scalability of the CFS bandwidth unthrottling logic
   with large number of CPUs.

 - Fix & rework various cpuidle routines, simplify interaction with
   the generic scheduler code. Add __cpuidle methods as noinstr to
   objtool's noinstr detection and fix boatloads of cpuidle bugs & quirks.

 - Add new ABI: introduce MEMBARRIER_CMD_GET_REGISTRATIONS,
   to query previously issued registrations.

 - Limit scheduler slice duration to the sysctl_sched_latency period,
   to improve scheduling granularity with a large number of SCHED_IDLE
   tasks.

 - Debuggability enhancement on sys_exit(): warn about disabled IRQs,
   but also enable them to prevent a cascade of followup problems and
   repeat warnings.

 - Fix the rescheduling logic in prio_changed_dl().

 - Micro-optimize cpufreq and sched-util methods.

 - Micro-optimize ttwu_runnable()

 - Micro-optimize the idle-scanning in update_numa_stats(),
   select_idle_capacity() and steal_cookie_task().

 - Update the RSEQ code & self-tests

 - Constify various scheduler methods

 - Remove unused methods

 - Refine __init tags

 - Documentation updates

 - ... Misc other cleanups, fixes

 Thanks,

	Ingo

------------------>
Arnd Bergmann (1):
      cpuidle: mvebu: Fix duplicate flags assignment

Bing Huang (2):
      sched/topology: Add __init for init_defrootdomain
      sched/topology: Add __init for sched_init_domains()

Chengming Zhou (2):
      sched/core: Micro-optimize ttwu_runnable()
      sched/core: Reorganize ttwu_do_wakeup() and ttwu_do_activate()

Hao Jia (2):
      sched/numa: Stop an exhastive search if an idle core is found
      sched/core: Adjusting the order of scanning CPU

Ingo Molnar (1):
      sched/cputime: Fix IA64 build error of missing arch_vtime_task_switch() prototype

Josh Don (1):
      sched: Async unthrottling for cfs bandwidth

Lukasz Luba (1):
      cpufreq, sched/util: Optimize operations with single CPU capacity lookup

Mark Brown (1):
      KVM: selftests: Fix build of rseq test

Mark Rutland (1):
      cpuidle: drivers: firmware: psci: Dont instrument suspend code

Mathieu Desnoyers (25):
      selftests/rseq: Fix: Fail thread registration when CONFIG_RSEQ=n
      rseq: Introduce feature size and alignment ELF auxiliary vector entries
      rseq: Introduce extensible rseq ABI
      rseq: Extend struct rseq with numa node id
      selftests/rseq: Use ELF auxiliary vector for extensible rseq
      selftests/rseq: Implement rseq numa node id field selftest
      sched: Introduce per-memory-map concurrency ID
      rseq: Extend struct rseq with per-memory-map concurrency ID
      selftests/rseq: Remove RSEQ_SKIP_FASTPATH code
      selftests/rseq: Implement rseq mm_cid field support
      selftests/rseq: x86: Template memory ordering and percpu access mode
      selftests/rseq: arm: Template memory ordering and percpu access mode
      selftests/rseq: arm64: Template memory ordering and percpu access mode
      selftests/rseq: mips: Template memory ordering and percpu access mode
      selftests/rseq: ppc: Template memory ordering and percpu access mode
      selftests/rseq: s390: Template memory ordering and percpu access mode
      selftests/rseq: riscv: Template memory ordering and percpu access mode
      selftests/rseq: Implement basic percpu ops mm_cid test
      selftests/rseq: Implement parametrized mm_cid test
      selftests/rseq: parametrized test: Report/abort on negative concurrency ID
      tracing/rseq: Add mm_cid field to rseq_update
      selftests/rseq: Add mm_numa_cid to test script
      sched/rseq: Fix concurrency ID handling of usermodehelper kthreads
      selftests/rseq: Revert "selftests/rseq: Add mm_numa_cid to test script"
      rseq: Increase AT_VECTOR_SIZE_BASE to match rseq auxvec entries

Matthew Wilcox (Oracle) (1):
      sched: Make const-safe

Michal Clapinski (2):
      sched/membarrier: Introduce MEMBARRIER_CMD_GET_REGISTRATIONS
      selftests/membarrier: Test MEMBARRIER_CMD_GET_REGISTRATIONS

Nicholas Piggin (2):
      cputime: remove cputime_to_nsecs fallback
      exit: Detect and fix irq disabled state in oops

Peter Zijlstra (59):
      x86/perf/amd: Remove tracing from perf_lopwr_cb()
      x86/idle: Replace 'x86_idle' function pointer with a static_call
      cpuidle/poll: Ensure IRQs stay disabled after cpuidle_state::enter() calls
      cpuidle: Move IRQ state validation
      cpuidle, riscv: Push RCU-idle into driver
      cpuidle, tegra: Push RCU-idle into driver
      cpuidle, psci: Push RCU-idle into driver
      cpuidle, ARM/imx6: Push RCU-idle into driver
      cpuidle, OMAP3: Push RCU-idle into driver
      cpuidle, armada: Push RCU-idle into driver
      cpuidle, OMAP4: Push RCU-idle into driver
      cpuidle, dt: Push RCU-idle into driver
      cpuidle: Fix ct_idle_*() usage
      cpuidle, cpu_pm: Remove RCU fiddling from cpu_pm_{enter,exit}()
      acpi_idle: Remove tracing
      cpuidle: Annotate poll_idle()
      objtool/idle: Validate __cpuidle code as noinstr
      cpuidle, intel_idle: Fix CPUIDLE_FLAG_IRQ_ENABLE *again*
      cpuidle, intel_idle: Fix CPUIDLE_FLAG_INIT_XSTATE
      cpuidle, intel_idle: Fix CPUIDLE_FLAG_IBRS
      arch/idle: Change arch_cpu_idle() behavior: always exit with IRQs disabled
      x86/tdx: Remove TDX_HCALL_ISSUE_STI
      arm, smp: Remove trace_.*_rcuidle() usage
      arm64, smp: Remove trace_.*_rcuidle() usage
      printk: Remove trace_.*_rcuidle() usage
      time/tick-broadcast: Remove RCU_NONIDLE() usage
      cpuidle, sched: Remove instrumentation from TIF_{POLLING_NRFLAG,NEED_RESCHED}
      cpuidle, mwait: Make the mwait code noinstr clean
      cpuidle, tdx: Make TDX code noinstr clean
      cpuidle, xenpv: Make more PARAVIRT_XXL noinstr clean
      cpuidle, nospec: Make mds_idle_clear_cpu_buffers() noinstr clean
      cpuidle, ACPI: Make noinstr clean
      tracing: Remove trace_hardirqs_{on,off}_caller()
      tracing: WARN on rcuidle
      tracing, hardirq: No moar _rcuidle() tracing
      cpuidle, OMAP3: Use WFI for omap3_pm_idle()
      cpuidle, OMAP3: Push RCU-idle into omap_sram_idle()
      arm, OMAP2: Use WFI for omap2_pm_idle()
      cpuidle, ARM: OMAP2+: powerdomain: Remove trace_.*_rcuidle()
      cpuidle, clk: Remove trace_.*_rcuidle()
      ubsan: Fix objtool UACCESS warns
      intel_idle: Add force_irq_on module param
      entry, kasan, x86: Disallow overriding mem*() functions
      sched/core: Always inline __this_cpu_preempt_check()
      arm64, riscv, perf: Remove RCU_NONIDLE() usage
      cpuidle: Ensure ct_cpuidle_enter() is always called from noinstr/__cpuidle
      cpuidle, arch: Mark all ct_cpuidle_enter() callers __cpuidle
      cpuidle,arch: Mark all regular cpuidle_state:: Enter methods __cpuidle
      cpuidle: Add comments about noinstr/__cpuidle usage
      context_tracking: Fix noinstr vs KASAN
      cpuidle, arm64: Fix the ARM64 cpuidle logic
      cpuidle: lib/bug: Disable rcu_is_watching() during WARN/BUG
      cpuidle: tracing: Warn about !rcu_is_watching()
      cpuidle: tracing, preempt: Squash _rcuidle tracing
      x86/atomics: Always inline arch_atomic64*()
      sched/clock/x86: Mark sched_clock() noinstr
      sched/clock: Make local_clock() noinstr
      cpuidle: Fix poll_idle() noinstr annotation
      objtool: mem*() are not uaccess safe

Pietro Borrello (1):
      sched/rt: pick_next_rt_entity(): check list_entry

Qais Yousef (1):
      sched/documentation: Document the util clamp feature

Tony Lindgren (1):
      cpuidle, OMAP4: Push RCU-idle into omap4_enter_lowpower()

Uros Bizjak (1):
      x86/pvclock: Improve atomic update of last_value in pvclock_clocksource_read()

Valentin Schneider (1):
      sched/deadline: Add more reschedule cases to prio_changed_dl()

Vincent Guittot (3):
      sched/fair: Limit sched slice duration
      sched/fair: unlink misfit task from cpu overutilized
      sched/fair: Remove capacity inversion detection

Zhang Qiao (1):
      sched/fair: sanitize vruntime of entity being placed


 Documentation/admin-guide/cgroup-v2.rst            |    3 +
 Documentation/scheduler/index.rst                  |    1 +
 Documentation/scheduler/sched-util-clamp.rst       |  741 ++++++++++++
 arch/alpha/kernel/process.c                        |    1 -
 arch/alpha/kernel/vmlinux.lds.S                    |    1 -
 arch/arc/kernel/process.c                          |    3 +
 arch/arc/kernel/vmlinux.lds.S                      |    1 -
 arch/arm/include/asm/vmlinux.lds.h                 |    1 -
 arch/arm/kernel/cpuidle.c                          |    4 +-
 arch/arm/kernel/process.c                          |    1 -
 arch/arm/kernel/smp.c                              |    6 +-
 arch/arm/mach-davinci/cpuidle.c                    |    4 +-
 arch/arm/mach-gemini/board-dt.c                    |    3 +-
 arch/arm/mach-imx/cpuidle-imx5.c                   |    4 +-
 arch/arm/mach-imx/cpuidle-imx6q.c                  |    8 +-
 arch/arm/mach-imx/cpuidle-imx6sl.c                 |    4 +-
 arch/arm/mach-imx/cpuidle-imx6sx.c                 |    9 +-
 arch/arm/mach-imx/cpuidle-imx7ulp.c                |    4 +-
 arch/arm/mach-omap2/common.h                       |    6 +-
 arch/arm/mach-omap2/cpuidle34xx.c                  |   16 +-
 arch/arm/mach-omap2/cpuidle44xx.c                  |   29 +-
 arch/arm/mach-omap2/omap-mpuss-lowpower.c          |   12 +-
 arch/arm/mach-omap2/pm.h                           |    2 +-
 arch/arm/mach-omap2/pm24xx.c                       |   51 +-
 arch/arm/mach-omap2/pm34xx.c                       |   14 +-
 arch/arm/mach-omap2/pm44xx.c                       |    2 +-
 arch/arm/mach-omap2/powerdomain.c                  |   10 +-
 arch/arm/mach-s3c/cpuidle-s3c64xx.c                |    5 +-
 arch/arm64/kernel/cpuidle.c                        |    6 +-
 arch/arm64/kernel/idle.c                           |    1 -
 arch/arm64/kernel/smp.c                            |    4 +-
 arch/arm64/kernel/suspend.c                        |   12 +-
 arch/arm64/kernel/vmlinux.lds.S                    |    1 -
 arch/csky/kernel/process.c                         |    1 -
 arch/csky/kernel/smp.c                             |    2 +-
 arch/csky/kernel/vmlinux.lds.S                     |    1 -
 arch/hexagon/kernel/process.c                      |    1 -
 arch/hexagon/kernel/vmlinux.lds.S                  |    1 -
 arch/ia64/kernel/process.c                         |    1 +
 arch/ia64/kernel/time.c                            |    1 +
 arch/ia64/kernel/vmlinux.lds.S                     |    1 -
 arch/loongarch/kernel/idle.c                       |    1 +
 arch/loongarch/kernel/vmlinux.lds.S                |    1 -
 arch/m68k/kernel/vmlinux-nommu.lds                 |    1 -
 arch/m68k/kernel/vmlinux-std.lds                   |    1 -
 arch/m68k/kernel/vmlinux-sun3.lds                  |    1 -
 arch/microblaze/kernel/process.c                   |    1 -
 arch/microblaze/kernel/vmlinux.lds.S               |    1 -
 arch/mips/kernel/idle.c                            |   14 +-
 arch/mips/kernel/vmlinux.lds.S                     |    1 -
 arch/nios2/kernel/process.c                        |    1 -
 arch/nios2/kernel/vmlinux.lds.S                    |    1 -
 arch/openrisc/kernel/process.c                     |    1 +
 arch/openrisc/kernel/vmlinux.lds.S                 |    1 -
 arch/parisc/kernel/process.c                       |    2 -
 arch/parisc/kernel/vmlinux.lds.S                   |    1 -
 arch/powerpc/kernel/idle.c                         |    5 +-
 arch/powerpc/kernel/vmlinux.lds.S                  |    1 -
 arch/riscv/kernel/process.c                        |    1 -
 arch/riscv/kernel/vmlinux-xip.lds.S                |    1 -
 arch/riscv/kernel/vmlinux.lds.S                    |    1 -
 arch/s390/kernel/idle.c                            |    3 +-
 arch/s390/kernel/vmlinux.lds.S                     |    1 -
 arch/s390/kernel/vtime.c                           |    2 +-
 arch/sh/kernel/idle.c                              |    1 +
 arch/sh/kernel/vmlinux.lds.S                       |    1 -
 arch/sparc/kernel/leon_pmc.c                       |    4 +
 arch/sparc/kernel/process_32.c                     |    1 -
 arch/sparc/kernel/process_64.c                     |    3 +-
 arch/sparc/kernel/vmlinux.lds.S                    |    1 -
 arch/um/kernel/dyn.lds.S                           |    1 -
 arch/um/kernel/process.c                           |    1 -
 arch/um/kernel/uml.lds.S                           |    1 -
 arch/x86/boot/compressed/vmlinux.lds.S             |    1 +
 arch/x86/coco/tdx/tdcall.S                         |   15 +-
 arch/x86/coco/tdx/tdx.c                            |   25 +-
 arch/x86/events/amd/brs.c                          |   13 +-
 arch/x86/include/asm/atomic64_32.h                 |   44 +-
 arch/x86/include/asm/atomic64_64.h                 |   36 +-
 arch/x86/include/asm/fpu/xcr.h                     |    4 +-
 arch/x86/include/asm/irqflags.h                    |   11 +-
 arch/x86/include/asm/kvmclock.h                    |    2 +-
 arch/x86/include/asm/mwait.h                       |   14 +-
 arch/x86/include/asm/nospec-branch.h               |    2 +-
 arch/x86/include/asm/paravirt.h                    |    8 +-
 arch/x86/include/asm/perf_event.h                  |    2 +-
 arch/x86/include/asm/pvclock.h                     |    3 +-
 arch/x86/include/asm/shared/io.h                   |    4 +-
 arch/x86/include/asm/shared/tdx.h                  |    1 -
 arch/x86/include/asm/special_insns.h               |    8 +-
 arch/x86/include/asm/xen/hypercall.h               |    2 +-
 arch/x86/kernel/cpu/bugs.c                         |    2 +-
 arch/x86/kernel/cpu/vmware.c                       |    2 +-
 arch/x86/kernel/fpu/core.c                         |    4 +-
 arch/x86/kernel/kvmclock.c                         |    6 +-
 arch/x86/kernel/paravirt.c                         |   14 +-
 arch/x86/kernel/process.c                          |   65 +-
 arch/x86/kernel/pvclock.c                          |   22 +-
 arch/x86/kernel/tsc.c                              |    7 +-
 arch/x86/kernel/vmlinux.lds.S                      |    1 -
 arch/x86/lib/memcpy_64.S                           |    5 +-
 arch/x86/lib/memmove_64.S                          |    4 +-
 arch/x86/lib/memset_64.S                           |    4 +-
 arch/x86/xen/enlighten_pv.c                        |    2 +-
 arch/x86/xen/irq.c                                 |    2 +-
 arch/x86/xen/time.c                                |   12 +-
 arch/xtensa/kernel/process.c                       |    1 +
 arch/xtensa/kernel/vmlinux.lds.S                   |    1 -
 drivers/acpi/processor_idle.c                      |   28 +-
 drivers/base/power/runtime.c                       |   24 +-
 drivers/clk/clk.c                                  |    8 +-
 drivers/cpuidle/cpuidle-arm.c                      |    4 +-
 drivers/cpuidle/cpuidle-big_little.c               |   12 +-
 drivers/cpuidle/cpuidle-mvebu-v7.c                 |   15 +-
 drivers/cpuidle/cpuidle-psci.c                     |   22 +-
 drivers/cpuidle/cpuidle-qcom-spm.c                 |    4 +-
 drivers/cpuidle/cpuidle-riscv-sbi.c                |   19 +-
 drivers/cpuidle/cpuidle-tegra.c                    |   31 +-
 drivers/cpuidle/cpuidle.c                          |   72 +-
 drivers/cpuidle/dt_idle_states.c                   |    2 +-
 drivers/cpuidle/poll_state.c                       |    8 +-
 drivers/firmware/psci/psci.c                       |   42 +-
 drivers/idle/intel_idle.c                          |   19 +-
 drivers/perf/arm_pmu.c                             |   11 +-
 drivers/perf/riscv_pmu_sbi.c                       |    8 +-
 fs/binfmt_elf.c                                    |    5 +
 fs/exec.c                                          |    4 +
 include/asm-generic/vmlinux.lds.h                  |    9 +-
 include/linux/auxvec.h                             |    2 +-
 include/linux/clockchips.h                         |    4 +-
 include/linux/compiler_types.h                     |   18 +-
 include/linux/context_tracking.h                   |   27 +
 include/linux/cpu.h                                |    3 -
 include/linux/cpuidle.h                            |   50 +-
 include/linux/cpumask.h                            |    4 +-
 include/linux/math64.h                             |    4 +-
 include/linux/mm.h                                 |   25 +
 include/linux/mm_types.h                           |   43 +-
 include/linux/percpu-defs.h                        |    2 +-
 include/linux/sched.h                              |    9 +
 include/linux/sched/clock.h                        |    8 +-
 include/linux/sched/cputime.h                      |    9 -
 include/linux/sched/idle.h                         |   40 +-
 include/linux/thread_info.h                        |   18 +-
 include/linux/trace_recursion.h                    |   18 +
 include/linux/tracepoint.h                         |   15 +-
 include/trace/events/rseq.h                        |    7 +-
 include/uapi/linux/auxvec.h                        |    2 +
 include/uapi/linux/membarrier.h                    |    4 +
 include/uapi/linux/rseq.h                          |   22 +
 init/Kconfig                                       |    4 +
 kernel/context_tracking.c                          |   12 +-
 kernel/cpu_pm.c                                    |    9 -
 kernel/exit.c                                      |    7 +
 kernel/fork.c                                      |    8 +-
 kernel/locking/lockdep.c                           |    3 +
 kernel/panic.c                                     |    5 +
 kernel/printk/printk.c                             |    2 +-
 kernel/ptrace.c                                    |    2 +-
 kernel/rseq.c                                      |   65 +-
 kernel/sched/clock.c                               |   27 +-
 kernel/sched/core.c                                |  134 ++-
 kernel/sched/cpufreq_schedutil.c                   |   43 +-
 kernel/sched/cputime.c                             |    4 +
 kernel/sched/deadline.c                            |   42 +-
 kernel/sched/fair.c                                |  389 ++++---
 kernel/sched/idle.c                                |   47 +-
 kernel/sched/membarrier.c                          |   39 +-
 kernel/sched/rt.c                                  |    5 +-
 kernel/sched/sched.h                               |  107 +-
 kernel/sched/topology.c                            |    4 +-
 kernel/signal.c                                    |    2 +
 kernel/time/tick-broadcast-hrtimer.c               |   29 +-
 kernel/time/tick-broadcast.c                       |    6 +-
 kernel/trace/trace.c                               |    3 +
 kernel/trace/trace_preemptirq.c                    |   61 +-
 lib/bug.c                                          |   15 +-
 lib/ubsan.c                                        |    5 +-
 mm/kasan/kasan.h                                   |    4 +
 mm/kasan/shadow.c                                  |   38 +
 tools/objtool/check.c                              |   14 +
 tools/testing/selftests/kvm/rseq_test.c            |   16 +-
 .../selftests/membarrier/membarrier_test_impl.h    |   33 +
 .../membarrier/membarrier_test_multi_thread.c      |    2 +-
 .../membarrier/membarrier_test_single_thread.c     |    6 +-
 tools/testing/selftests/rseq/.gitignore            |    4 +
 tools/testing/selftests/rseq/Makefile              |   20 +-
 .../testing/selftests/rseq/basic_percpu_ops_test.c |   46 +-
 tools/testing/selftests/rseq/basic_test.c          |    4 +
 tools/testing/selftests/rseq/compiler.h            |    6 +
 tools/testing/selftests/rseq/param_test.c          |  157 ++-
 tools/testing/selftests/rseq/rseq-abi.h            |   22 +
 tools/testing/selftests/rseq/rseq-arm-bits.h       |  505 +++++++++
 tools/testing/selftests/rseq/rseq-arm.h            |  701 +-----------
 tools/testing/selftests/rseq/rseq-arm64-bits.h     |  392 +++++++
 tools/testing/selftests/rseq/rseq-arm64.h          |  520 +--------
 tools/testing/selftests/rseq/rseq-bits-reset.h     |   11 +
 tools/testing/selftests/rseq/rseq-bits-template.h  |   41 +
 tools/testing/selftests/rseq/rseq-mips-bits.h      |  462 ++++++++
 tools/testing/selftests/rseq/rseq-mips.h           |  646 +----------
 tools/testing/selftests/rseq/rseq-ppc-bits.h       |  454 ++++++++
 tools/testing/selftests/rseq/rseq-ppc.h            |  617 +---------
 tools/testing/selftests/rseq/rseq-riscv-bits.h     |  410 +++++++
 tools/testing/selftests/rseq/rseq-riscv.h          |  529 +--------
 tools/testing/selftests/rseq/rseq-s390-bits.h      |  474 ++++++++
 tools/testing/selftests/rseq/rseq-s390.h           |  495 +-------
 tools/testing/selftests/rseq/rseq-skip.h           |   65 --
 tools/testing/selftests/rseq/rseq-x86-bits.h       |  993 ++++++++++++++++
 tools/testing/selftests/rseq/rseq-x86.h            | 1193 +-------------------
 tools/testing/selftests/rseq/rseq.c                |   91 +-
 tools/testing/selftests/rseq/rseq.h                |  215 +++-
 tools/testing/selftests/rseq/run_param_test.sh     |    5 +
 212 files changed, 6784 insertions(+), 5553 deletions(-)
 create mode 100644 Documentation/scheduler/sched-util-clamp.rst
 create mode 100644 tools/testing/selftests/rseq/rseq-arm-bits.h
 create mode 100644 tools/testing/selftests/rseq/rseq-arm64-bits.h
 create mode 100644 tools/testing/selftests/rseq/rseq-bits-reset.h
 create mode 100644 tools/testing/selftests/rseq/rseq-bits-template.h
 create mode 100644 tools/testing/selftests/rseq/rseq-mips-bits.h
 create mode 100644 tools/testing/selftests/rseq/rseq-ppc-bits.h
 create mode 100644 tools/testing/selftests/rseq/rseq-riscv-bits.h
 create mode 100644 tools/testing/selftests/rseq/rseq-s390-bits.h
 delete mode 100644 tools/testing/selftests/rseq/rseq-skip.h
 create mode 100644 tools/testing/selftests/rseq/rseq-x86-bits.h
