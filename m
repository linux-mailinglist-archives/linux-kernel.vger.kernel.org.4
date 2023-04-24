Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E9C16ED42A
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 20:14:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231499AbjDXSNs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 14:13:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232313AbjDXSNf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 14:13:35 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2927459E7
        for <linux-kernel@vger.kernel.org>; Mon, 24 Apr 2023 11:13:30 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1682360008;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=0ooCSzoFBdO2JRjHsdDpenYgzuyvCYluYx0ojm1MFM8=;
        b=2pjpldFpJXFMrO2r4VWkl6rV0rficHF6bcwY5io8i+h6BxoNcBZjFa5geFflRhvHWzBiXX
        9BSFYVNeDhgKyFk/1iWkCws2yVxbB7pLB1u9wwnqkPCkmXWn1ymtMzb37oAoblCrh3plDA
        Ao5cNI/p5LlRL1jo/VAQRT+S10jMb0hYdjE1E8SKGPGBaApukbzksAr0XL407udf84120b
        NaoJJlwS9+7JwOYjHmW3FUTenl+/ARR7bIqBL0SiS3FDOih8gyEo98c4js/L/NaBHfS3qx
        Zptq9+aaOKQf0DgagbsH1NcxPk6OD1WNPrCRgAaiOZrba5RcAK2eocf7mMDFhg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1682360008;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=0ooCSzoFBdO2JRjHsdDpenYgzuyvCYluYx0ojm1MFM8=;
        b=gmEFNWDP7CD1Wj715ssjDqDTx2yb1scgtOM83+SsUaaIRBzXJCxVAifNaav1GxJtoWlJXm
        8ijC1G/Y0m1Ag+Dg==
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [GIT pull] timers/core for 6.4-rc1
References: <168235968801.840202.17752066425816055574.tglx@xen13>
Message-ID: <168235969244.840202.3708265453324842162.tglx@xen13>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Date:   Mon, 24 Apr 2023 20:13:28 +0200 (CEST)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull the latest timers/core branch from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers-core-2023=
-04-24

up to:  f7abf14f0001: posix-cpu-timers: Implement the missing timer_wait_runn=
ing callback


Timers and timekeeping updates:

  - Improve the VDSO build time checks to cover all dynamic relocations

    VDSO does not allow dynamic relcations, but the build time check is
    incomplete and fragile.

    It's based on architectures specifying the relocation types to search
    for and does not handle R_*_NONE relocation entries correctly.
    R_*_NONE relocations are injected by some GNU ld variants if they fail
    to determine the exact .rel[a]/dyn_size to cover trailing zeros.
    R_*_NONE relocations must be ignored by dynamic loaders, so they
    should be ignored in the build time check too.

    Remove the architecture specific relocation types to check for and
    validate strictly that no other relocations than R_*_NONE end up
    in the VSDO .so file.

  - Prefer signal delivery to the current thread for
    CLOCK_PROCESS_CPUTIME_ID based posix-timers

    Such timers prefer to deliver the signal to the main thread of a
    process even if the context in which the timer expires is the current
    task. This has the downside that it might wake up an idle thread.

    As there is no requirement or guarantee that the signal has to be
    delivered to the main thread, avoid this by preferring the current
    task if it is part of the thread group which shares sighand.

    This not only avoids waking idle threads, it also distributes the
    signal delivery in case of multiple timers firing in the context
    of different threads close to each other better.

  - Align the tick period properly (again)

    For a long time the tick was starting at CLOCK_MONOTONIC zero, which
    allowed users space applications to either align with the tick or to
    place a periodic computation so that it does not interfere with the
    tick. The alignement of the tick period was more by chance than by
    intention as the tick is set up before a high resolution clocksource is
    installed, i.e. timekeeping is still tick based and the tick period
    advances from there.

    The early enablement of sched_clock() broke this alignement as the time
    accumulated by sched_clock() is taken into account when timekeeping is
    initialized. So the base value now(CLOCK_MONOTONIC) is not longer a
    multiple of tick periods, which breaks applications which relied on
    that behaviour.

    Cure this by aligning the tick starting point to the next multiple of
    tick periods, i.e 1000ms/CONFIG_HZ.

 - A set of NOHZ fixes and enhancements

   - Cure the concurrent writer race for idle and IO sleeptime statistics

     The statitic values which are exposed via /proc/stat are updated from
     the CPU local idle exit and remotely by cpufreq, but that happens
     without any form of serialization. As a consequence sleeptimes can be
     accounted twice or worse.

     Prevent this by restricting the accumulation writeback to the CPU
     local idle exit and let the remote access compute the accumulated
     value.

   - Protect idle/iowait sleep time with a sequence count

     Reading idle/iowait sleep time, e.g. from /proc/stat, can race with
     idle exit updates. As a consequence the readout may result in random
     and potentially going backwards values.

     Protect this by a sequence count, which fixes the idle time
     statistics issue, but cannot fix the iowait time problem because
     iowait time accounting races with remote wake ups decrementing the
     remote runqueues nr_iowait counter. The latter is impossible to fix,
     so the only way to deal with that is to document it properly and to
     remove the assertion in the selftest which triggers occasionally due
     to that.

   - Restructure struct tick_sched for better cache layout

   - Some small cleanups and a better cache layout for struct tick_sched


 - Implement the missing timer_wait_running() callback for POSIX CPU timers

   For unknown reason the introduction of the timer_wait_running() callback
   missed to fixup posix CPU timers, which went unnoticed for almost four
   years.

   While initially only targeted to prevent livelocks between a timer
   deletion and the timer expiry function on PREEMPT_RT enabled kernels, it
   turned out that fixing this for mainline is not as trivial as just
   implementing a stub similar to the hrtimer/timer callbacks.

   The reason is that for CONFIG_POSIX_CPU_TIMERS_TASK_WORK enabled systems
   there is a livelock issue independent of RT.

   CONFIG_POSIX_CPU_TIMERS_TASK_WORK=3Dy moves the expiry of POSIX CPU timers
   out from hard interrupt context to task work, which is handled before
   returning to user space or to a VM. The expiry mechanism moves the
   expired timers to a stack local list head with sighand lock held. Once
   sighand is dropped the task can be preempted and a task which wants to
   delete a timer will spin-wait until the expiry task is scheduled back
   in. In the worst case this will end up in a livelock when the preempting
   task and the expiry task are pinned on the same CPU.

   The timer wheel has a timer_wait_running() mechanism for RT, which uses
   a per CPU timer-base expiry lock which is held by the expiry code and the
   task waiting for the timer function to complete blocks on that lock.

   This does not work in the same way for posix CPU timers as there is no
   timer base and expiry for process wide timers can run on any task
   belonging to that process, but the concept of waiting on an expiry lock
   can be used too in a slightly different way.

   Add a per task mutex to struct posix_cputimers_work, let the expiry task
   hold it accross the expiry function and let the deleting task which
   waits for the expiry to complete block on the mutex.

   In the non-contended case this results in an extra mutex_lock()/unlock()
   pair on both sides.

   This avoids spin-waiting on a task which is scheduled out, prevents the
   livelock and cures the problem for RT and !RT systems.

Thanks,

	tglx

------------------>
Dmitry Vyukov (2):
      posix-timers: Prefer delivery of signals to the current thread
      selftests/timers/posix_timers: Test delivery of signals across threads

Fangrui Song (1):
      vdso: Improve cmd_vdso_check to check all dynamic relocations

Frederic Weisbecker (8):
      timers/nohz: Restructure and reshuffle struct tick_sched
      timers/nohz: Only ever update sleeptime from idle exit
      timers/nohz: Protect idle/iowait sleep time under seqcount
      timers/nohz: Add a comment about broken iowait counter update race
      timers/nohz: Remove middle-function __tick_nohz_idle_stop_tick()
      MAINTAINERS: Remove stale email address
      selftests/proc: Remove idle time monotonicity assertions
      selftests/proc: Assert clock_gettime(CLOCK_BOOTTIME) VS /proc/uptime mo=
notonicity

Sebastian Andrzej Siewior (1):
      tick/common: Align tick period with the HZ tick.

Thomas Gleixner (1):
      posix-cpu-timers: Implement the missing timer_wait_running callback


 MAINTAINERS                                    |   2 +-
 arch/arm/vdso/Makefile                         |   4 +-
 arch/arm64/kernel/vdso/Makefile                |   4 +-
 arch/arm64/kernel/vdso32/Makefile              |   3 -
 arch/csky/kernel/vdso/Makefile                 |   4 +-
 arch/loongarch/vdso/Makefile                   |   4 +-
 arch/mips/vdso/Makefile                        |   4 +-
 arch/powerpc/kernel/vdso/Makefile              |   2 +-
 arch/riscv/kernel/vdso/Makefile                |   4 +-
 arch/s390/kernel/vdso32/Makefile               |   3 +-
 arch/s390/kernel/vdso64/Makefile               |   3 +-
 arch/x86/entry/vdso/Makefile                   |   5 +-
 include/linux/posix-timers.h                   |  17 ++--
 kernel/signal.c                                |  21 +++-
 kernel/time/posix-cpu-timers.c                 |  81 ++++++++++++---
 kernel/time/posix-timers.c                     |   4 +
 kernel/time/tick-common.c                      |  12 ++-
 kernel/time/tick-sched.c                       | 135 ++++++++++++-----------=
--
 kernel/time/tick-sched.h                       |  67 +++++++-----
 lib/vdso/Makefile                              |  13 +--
 tools/testing/selftests/proc/proc-uptime-001.c |  25 +++--
 tools/testing/selftests/proc/proc-uptime-002.c |  27 +++--
 tools/testing/selftests/proc/proc-uptime.h     |  28 ++---
 tools/testing/selftests/timers/posix_timers.c  |  77 ++++++++++++++
 24 files changed, 361 insertions(+), 188 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index d8ebab595b2a..ee7e011f0b5e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14746,7 +14746,7 @@ F:	include/uapi/linux/nitro_enclaves.h
 F:	samples/nitro_enclaves/
=20
 NOHZ, DYNTICKS SUPPORT
-M:	Frederic Weisbecker <fweisbec@gmail.com>
+M:	Frederic Weisbecker <frederic@kernel.org>
 M:	Thomas Gleixner <tglx@linutronix.de>
 M:	Ingo Molnar <mingo@kernel.org>
 L:	linux-kernel@vger.kernel.org
diff --git a/arch/arm/vdso/Makefile b/arch/arm/vdso/Makefile
index a7ec06ce3785..515ca33b854c 100644
--- a/arch/arm/vdso/Makefile
+++ b/arch/arm/vdso/Makefile
@@ -1,8 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
=20
-# Absolute relocation type $(ARCH_REL_TYPE_ABS) needs to be defined before
-# the inclusion of generic Makefile.
-ARCH_REL_TYPE_ABS :=3D R_ARM_JUMP_SLOT|R_ARM_GLOB_DAT|R_ARM_ABS32
+# Include the generic Makefile to check the built vdso.
 include $(srctree)/lib/vdso/Makefile
=20
 hostprogs :=3D vdsomunge
diff --git a/arch/arm64/kernel/vdso/Makefile b/arch/arm64/kernel/vdso/Makefile
index beaf9586338f..fe7a53c6781f 100644
--- a/arch/arm64/kernel/vdso/Makefile
+++ b/arch/arm64/kernel/vdso/Makefile
@@ -6,9 +6,7 @@
 # Heavily based on the vDSO Makefiles for other archs.
 #
=20
-# Absolute relocation type $(ARCH_REL_TYPE_ABS) needs to be defined before
-# the inclusion of generic Makefile.
-ARCH_REL_TYPE_ABS :=3D R_AARCH64_JUMP_SLOT|R_AARCH64_GLOB_DAT|R_AARCH64_ABS64
+# Include the generic Makefile to check the built vdso.
 include $(srctree)/lib/vdso/Makefile
=20
 obj-vdso :=3D vgettimeofday.o note.o sigreturn.o
diff --git a/arch/arm64/kernel/vdso32/Makefile b/arch/arm64/kernel/vdso32/Mak=
efile
index f59bd1a4ead6..d014162c5c71 100644
--- a/arch/arm64/kernel/vdso32/Makefile
+++ b/arch/arm64/kernel/vdso32/Makefile
@@ -3,9 +3,6 @@
 # Makefile for vdso32
 #
=20
-# Absolute relocation type $(ARCH_REL_TYPE_ABS) needs to be defined before
-# the inclusion of generic Makefile.
-ARCH_REL_TYPE_ABS :=3D R_ARM_JUMP_SLOT|R_ARM_GLOB_DAT|R_ARM_ABS32
 include $(srctree)/lib/vdso/Makefile
=20
 # Same as cc-*option, but using CC_COMPAT instead of CC
diff --git a/arch/csky/kernel/vdso/Makefile b/arch/csky/kernel/vdso/Makefile
index 0b6909f10667..299e4e41ebc5 100644
--- a/arch/csky/kernel/vdso/Makefile
+++ b/arch/csky/kernel/vdso/Makefile
@@ -1,8 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0-only
=20
-# Absolute relocation type $(ARCH_REL_TYPE_ABS) needs to be defined before
-# the inclusion of generic Makefile.
-ARCH_REL_TYPE_ABS :=3D R_CKCORE_ADDR32|R_CKCORE_JUMP_SLOT
+# Include the generic Makefile to check the built vdso.
 include $(srctree)/lib/vdso/Makefile
=20
 # Symbols present in the vdso
diff --git a/arch/loongarch/vdso/Makefile b/arch/loongarch/vdso/Makefile
index d89e2ac75f7b..461240ab4436 100644
--- a/arch/loongarch/vdso/Makefile
+++ b/arch/loongarch/vdso/Makefile
@@ -1,9 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 # Objects to go into the VDSO.
=20
-# Absolute relocation type $(ARCH_REL_TYPE_ABS) needs to be defined before
-# the inclusion of generic Makefile.
-ARCH_REL_TYPE_ABS :=3D R_LARCH_32|R_LARCH_64|R_LARCH_MARK_LA|R_LARCH_JUMP_SL=
OT
+# Include the generic Makefile to check the built vdso.
 include $(srctree)/lib/vdso/Makefile
=20
 obj-vdso-y :=3D elf.o vgetcpu.o vgettimeofday.o sigreturn.o
diff --git a/arch/mips/vdso/Makefile b/arch/mips/vdso/Makefile
index 18af9474ed0e..eb56581f6d73 100644
--- a/arch/mips/vdso/Makefile
+++ b/arch/mips/vdso/Makefile
@@ -4,9 +4,7 @@
 # Sanitizer runtimes are unavailable and cannot be linked here.
  KCSAN_SANITIZE			:=3D n
=20
-# Absolute relocation type $(ARCH_REL_TYPE_ABS) needs to be defined before
-# the inclusion of generic Makefile.
-ARCH_REL_TYPE_ABS :=3D R_MIPS_JUMP_SLOT|R_MIPS_GLOB_DAT
+# Include the generic Makefile to check the built vdso.
 include $(srctree)/lib/vdso/Makefile
=20
 obj-vdso-y :=3D elf.o vgettimeofday.o sigreturn.o
diff --git a/arch/powerpc/kernel/vdso/Makefile b/arch/powerpc/kernel/vdso/Mak=
efile
index 66f723f53be2..4c3f34485f08 100644
--- a/arch/powerpc/kernel/vdso/Makefile
+++ b/arch/powerpc/kernel/vdso/Makefile
@@ -2,7 +2,7 @@
=20
 # List of files in the vdso, has to be asm only for now
=20
-ARCH_REL_TYPE_ABS :=3D R_PPC_JUMP_SLOT|R_PPC_GLOB_DAT|R_PPC_ADDR32|R_PPC_ADD=
R24|R_PPC_ADDR16|R_PPC_ADDR16_LO|R_PPC_ADDR16_HI|R_PPC_ADDR16_HA|R_PPC_ADDR14=
|R_PPC_ADDR14_BRTAKEN|R_PPC_ADDR14_BRNTAKEN|R_PPC_REL24
+# Include the generic Makefile to check the built vdso.
 include $(srctree)/lib/vdso/Makefile
=20
 obj-vdso32 =3D sigtramp32-32.o gettimeofday-32.o datapage-32.o cacheflush-32=
.o note-32.o getcpu-32.o
diff --git a/arch/riscv/kernel/vdso/Makefile b/arch/riscv/kernel/vdso/Makefile
index 06e6b27f3bcc..a04b3bc35ca2 100644
--- a/arch/riscv/kernel/vdso/Makefile
+++ b/arch/riscv/kernel/vdso/Makefile
@@ -1,9 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0-only
 # Copied from arch/tile/kernel/vdso/Makefile
=20
-# Absolute relocation type $(ARCH_REL_TYPE_ABS) needs to be defined before
-# the inclusion of generic Makefile.
-ARCH_REL_TYPE_ABS :=3D R_RISCV_32|R_RISCV_64|R_RISCV_JUMP_SLOT
+# Include the generic Makefile to check the built vdso.
 include $(srctree)/lib/vdso/Makefile
 # Symbols present in the vdso
 vdso-syms  =3D rt_sigreturn
diff --git a/arch/s390/kernel/vdso32/Makefile b/arch/s390/kernel/vdso32/Makef=
ile
index 245bddfe9bc0..bafd3147eb4e 100644
--- a/arch/s390/kernel/vdso32/Makefile
+++ b/arch/s390/kernel/vdso32/Makefile
@@ -2,9 +2,8 @@
 # List of files in the vdso
=20
 KCOV_INSTRUMENT :=3D n
-ARCH_REL_TYPE_ABS :=3D R_390_COPY|R_390_GLOB_DAT|R_390_JMP_SLOT|R_390_RELATI=
VE
-ARCH_REL_TYPE_ABS +=3D R_390_GOT|R_390_PLT
=20
+# Include the generic Makefile to check the built vdso.
 include $(srctree)/lib/vdso/Makefile
 obj-vdso32 =3D vdso_user_wrapper-32.o note-32.o
=20
diff --git a/arch/s390/kernel/vdso64/Makefile b/arch/s390/kernel/vdso64/Makef=
ile
index 34f9542636e9..a766d286e15f 100644
--- a/arch/s390/kernel/vdso64/Makefile
+++ b/arch/s390/kernel/vdso64/Makefile
@@ -2,9 +2,8 @@
 # List of files in the vdso
=20
 KCOV_INSTRUMENT :=3D n
-ARCH_REL_TYPE_ABS :=3D R_390_COPY|R_390_GLOB_DAT|R_390_JMP_SLOT|R_390_RELATI=
VE
-ARCH_REL_TYPE_ABS +=3D R_390_GOT|R_390_PLT
=20
+# Include the generic Makefile to check the built vdso.
 include $(srctree)/lib/vdso/Makefile
 obj-vdso64 =3D vdso_user_wrapper.o note.o
 obj-cvdso64 =3D vdso64_generic.o getcpu.o
diff --git a/arch/x86/entry/vdso/Makefile b/arch/x86/entry/vdso/Makefile
index 1506a22a4fb6..6a1821bd7d5e 100644
--- a/arch/x86/entry/vdso/Makefile
+++ b/arch/x86/entry/vdso/Makefile
@@ -3,10 +3,7 @@
 # Building vDSO images for x86.
 #
=20
-# Absolute relocation type $(ARCH_REL_TYPE_ABS) needs to be defined before
-# the inclusion of generic Makefile.
-ARCH_REL_TYPE_ABS :=3D R_X86_64_JUMP_SLOT|R_X86_64_GLOB_DAT|R_X86_64_RELATIV=
E|
-ARCH_REL_TYPE_ABS +=3D R_386_GLOB_DAT|R_386_JMP_SLOT|R_386_RELATIVE
+# Include the generic Makefile to check the built vdso.
 include $(srctree)/lib/vdso/Makefile
=20
 # Sanitizer runtimes are unavailable and cannot be linked here.
diff --git a/include/linux/posix-timers.h b/include/linux/posix-timers.h
index 2c6e99ca48af..d607f51404fc 100644
--- a/include/linux/posix-timers.h
+++ b/include/linux/posix-timers.h
@@ -4,6 +4,7 @@
=20
 #include <linux/spinlock.h>
 #include <linux/list.h>
+#include <linux/mutex.h>
 #include <linux/alarmtimer.h>
 #include <linux/timerqueue.h>
=20
@@ -62,16 +63,18 @@ static inline int clockid_to_fd(const clockid_t clk)
  * cpu_timer - Posix CPU timer representation for k_itimer
  * @node:	timerqueue node to queue in the task/sig
  * @head:	timerqueue head on which this timer is queued
- * @task:	Pointer to target task
+ * @pid:	Pointer to target task PID
  * @elist:	List head for the expiry list
  * @firing:	Timer is currently firing
+ * @handling:	Pointer to the task which handles expiry
  */
 struct cpu_timer {
-	struct timerqueue_node	node;
-	struct timerqueue_head	*head;
-	struct pid		*pid;
-	struct list_head	elist;
-	int			firing;
+	struct timerqueue_node		node;
+	struct timerqueue_head		*head;
+	struct pid			*pid;
+	struct list_head		elist;
+	int				firing;
+	struct task_struct __rcu	*handling;
 };
=20
 static inline bool cpu_timer_enqueue(struct timerqueue_head *head,
@@ -135,10 +138,12 @@ struct posix_cputimers {
 /**
  * posix_cputimers_work - Container for task work based posix CPU timer expi=
ry
  * @work:	The task work to be scheduled
+ * @mutex:	Mutex held around expiry in context of this task work
  * @scheduled:  @work has been scheduled already, no further processing
  */
 struct posix_cputimers_work {
 	struct callback_head	work;
+	struct mutex		mutex;
 	unsigned int		scheduled;
 };
=20
diff --git a/kernel/signal.c b/kernel/signal.c
index 8cb28f1df294..8f6330f0e9ca 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -1003,8 +1003,7 @@ static void complete_signal(int sig, struct task_struct=
 *p, enum pid_type type)
 	/*
 	 * Now find a thread we can wake up to take the signal off the queue.
 	 *
-	 * If the main thread wants the signal, it gets first crack.
-	 * Probably the least surprising to the average bear.
+	 * Try the suggested task first (may or may not be the main thread).
 	 */
 	if (wants_signal(sig, p))
 		t =3D p;
@@ -1970,8 +1969,24 @@ int send_sigqueue(struct sigqueue *q, struct pid *pid,=
 enum pid_type type)
=20
 	ret =3D -1;
 	rcu_read_lock();
+
+	/*
+	 * This function is used by POSIX timers to deliver a timer signal.
+	 * Where type is PIDTYPE_PID (such as for timers with SIGEV_THREAD_ID
+	 * set), the signal must be delivered to the specific thread (queues
+	 * into t->pending).
+	 *
+	 * Where type is not PIDTYPE_PID, signals must be delivered to the
+	 * process. In this case, prefer to deliver to current if it is in
+	 * the same thread group as the target process, which avoids
+	 * unnecessarily waking up a potentially idle task.
+	 */
 	t =3D pid_task(pid, type);
-	if (!t || !likely(lock_task_sighand(t, &flags)))
+	if (!t)
+		goto ret;
+	if (type !=3D PIDTYPE_PID && same_thread_group(t, current))
+		t =3D current;
+	if (!likely(lock_task_sighand(t, &flags)))
 		goto ret;
=20
 	ret =3D 1; /* the signal is ignored */
diff --git a/kernel/time/posix-cpu-timers.c b/kernel/time/posix-cpu-timers.c
index 2f5e9b34022c..e9c6f9d0e42c 100644
--- a/kernel/time/posix-cpu-timers.c
+++ b/kernel/time/posix-cpu-timers.c
@@ -846,6 +846,8 @@ static u64 collect_timerqueue(struct timerqueue_head *hea=
d,
 			return expires;
=20
 		ctmr->firing =3D 1;
+		/* See posix_cpu_timer_wait_running() */
+		rcu_assign_pointer(ctmr->handling, current);
 		cpu_timer_dequeue(ctmr);
 		list_add_tail(&ctmr->elist, firing);
 	}
@@ -1161,7 +1163,49 @@ static void handle_posix_cpu_timers(struct task_struct=
 *tsk);
 #ifdef CONFIG_POSIX_CPU_TIMERS_TASK_WORK
 static void posix_cpu_timers_work(struct callback_head *work)
 {
+	struct posix_cputimers_work *cw =3D container_of(work, typeof(*cw), work);
+
+	mutex_lock(&cw->mutex);
 	handle_posix_cpu_timers(current);
+	mutex_unlock(&cw->mutex);
+}
+
+/*
+ * Invoked from the posix-timer core when a cancel operation failed because
+ * the timer is marked firing. The caller holds rcu_read_lock(), which
+ * protects the timer and the task which is expiring it from being freed.
+ */
+static void posix_cpu_timer_wait_running(struct k_itimer *timr)
+{
+	struct task_struct *tsk =3D rcu_dereference(timr->it.cpu.handling);
+
+	/* Has the handling task completed expiry already? */
+	if (!tsk)
+		return;
+
+	/* Ensure that the task cannot go away */
+	get_task_struct(tsk);
+	/* Now drop the RCU protection so the mutex can be locked */
+	rcu_read_unlock();
+	/* Wait on the expiry mutex */
+	mutex_lock(&tsk->posix_cputimers_work.mutex);
+	/* Release it immediately again. */
+	mutex_unlock(&tsk->posix_cputimers_work.mutex);
+	/* Drop the task reference. */
+	put_task_struct(tsk);
+	/* Relock RCU so the callsite is balanced */
+	rcu_read_lock();
+}
+
+static void posix_cpu_timer_wait_running_nsleep(struct k_itimer *timr)
+{
+	/* Ensure that timr->it.cpu.handling task cannot go away */
+	rcu_read_lock();
+	spin_unlock_irq(&timr->it_lock);
+	posix_cpu_timer_wait_running(timr);
+	rcu_read_unlock();
+	/* @timr is on stack and is valid */
+	spin_lock_irq(&timr->it_lock);
 }
=20
 /*
@@ -1177,6 +1221,7 @@ void clear_posix_cputimers_work(struct task_struct *p)
 	       sizeof(p->posix_cputimers_work.work));
 	init_task_work(&p->posix_cputimers_work.work,
 		       posix_cpu_timers_work);
+	mutex_init(&p->posix_cputimers_work.mutex);
 	p->posix_cputimers_work.scheduled =3D false;
 }
=20
@@ -1255,6 +1300,18 @@ static inline void __run_posix_cpu_timers(struct task_=
struct *tsk)
 	lockdep_posixtimer_exit();
 }
=20
+static void posix_cpu_timer_wait_running(struct k_itimer *timr)
+{
+	cpu_relax();
+}
+
+static void posix_cpu_timer_wait_running_nsleep(struct k_itimer *timr)
+{
+	spin_unlock_irq(&timr->it_lock);
+	cpu_relax();
+	spin_lock_irq(&timr->it_lock);
+}
+
 static inline bool posix_cpu_timers_work_scheduled(struct task_struct *tsk)
 {
 	return false;
@@ -1363,6 +1420,8 @@ static void handle_posix_cpu_timers(struct task_struct =
*tsk)
 		 */
 		if (likely(cpu_firing >=3D 0))
 			cpu_timer_fire(timer);
+		/* See posix_cpu_timer_wait_running() */
+		rcu_assign_pointer(timer->it.cpu.handling, NULL);
 		spin_unlock(&timer->it_lock);
 	}
 }
@@ -1497,23 +1556,16 @@ static int do_cpu_nanosleep(const clockid_t which_clo=
ck, int flags,
 		expires =3D cpu_timer_getexpires(&timer.it.cpu);
 		error =3D posix_cpu_timer_set(&timer, 0, &zero_it, &it);
 		if (!error) {
-			/*
-			 * Timer is now unarmed, deletion can not fail.
-			 */
+			/* Timer is now unarmed, deletion can not fail. */
 			posix_cpu_timer_del(&timer);
+		} else {
+			while (error =3D=3D TIMER_RETRY) {
+				posix_cpu_timer_wait_running_nsleep(&timer);
+				error =3D posix_cpu_timer_del(&timer);
+			}
 		}
-		spin_unlock_irq(&timer.it_lock);
=20
-		while (error =3D=3D TIMER_RETRY) {
-			/*
-			 * We need to handle case when timer was or is in the
-			 * middle of firing. In other cases we already freed
-			 * resources.
-			 */
-			spin_lock_irq(&timer.it_lock);
-			error =3D posix_cpu_timer_del(&timer);
-			spin_unlock_irq(&timer.it_lock);
-		}
+		spin_unlock_irq(&timer.it_lock);
=20
 		if ((it.it_value.tv_sec | it.it_value.tv_nsec) =3D=3D 0) {
 			/*
@@ -1623,6 +1675,7 @@ const struct k_clock clock_posix_cpu =3D {
 	.timer_del		=3D posix_cpu_timer_del,
 	.timer_get		=3D posix_cpu_timer_get,
 	.timer_rearm		=3D posix_cpu_timer_rearm,
+	.timer_wait_running	=3D posix_cpu_timer_wait_running,
 };
=20
 const struct k_clock clock_process =3D {
diff --git a/kernel/time/posix-timers.c b/kernel/time/posix-timers.c
index 0c8a87a11b39..808a247205a9 100644
--- a/kernel/time/posix-timers.c
+++ b/kernel/time/posix-timers.c
@@ -846,6 +846,10 @@ static struct k_itimer *timer_wait_running(struct k_itim=
er *timer,
 	rcu_read_lock();
 	unlock_timer(timer, *flags);
=20
+	/*
+	 * kc->timer_wait_running() might drop RCU lock. So @timer
+	 * cannot be touched anymore after the function returns!
+	 */
 	if (!WARN_ON_ONCE(!kc->timer_wait_running))
 		kc->timer_wait_running(timer);
=20
diff --git a/kernel/time/tick-common.c b/kernel/time/tick-common.c
index 46789356f856..65b8658da829 100644
--- a/kernel/time/tick-common.c
+++ b/kernel/time/tick-common.c
@@ -218,9 +218,19 @@ static void tick_setup_device(struct tick_device *td,
 		 * this cpu:
 		 */
 		if (tick_do_timer_cpu =3D=3D TICK_DO_TIMER_BOOT) {
+			ktime_t next_p;
+			u32 rem;
+
 			tick_do_timer_cpu =3D cpu;
=20
-			tick_next_period =3D ktime_get();
+			next_p =3D ktime_get();
+			div_u64_rem(next_p, TICK_NSEC, &rem);
+			if (rem) {
+				next_p -=3D rem;
+				next_p +=3D TICK_NSEC;
+			}
+
+			tick_next_period =3D next_p;
 #ifdef CONFIG_NO_HZ_FULL
 			/*
 			 * The boot CPU may be nohz_full, in which case set
diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
index b0e3c9205946..3b53b894ca98 100644
--- a/kernel/time/tick-sched.c
+++ b/kernel/time/tick-sched.c
@@ -637,43 +637,67 @@ static void tick_nohz_update_jiffies(ktime_t now)
 	touch_softlockup_watchdog_sched();
 }
=20
-/*
- * Updates the per-CPU time idle statistics counters
- */
-static void
-update_ts_time_stats(int cpu, struct tick_sched *ts, ktime_t now, u64 *last_=
update_time)
+static void tick_nohz_stop_idle(struct tick_sched *ts, ktime_t now)
 {
 	ktime_t delta;
=20
-	if (ts->idle_active) {
-		delta =3D ktime_sub(now, ts->idle_entrytime);
-		if (nr_iowait_cpu(cpu) > 0)
-			ts->iowait_sleeptime =3D ktime_add(ts->iowait_sleeptime, delta);
-		else
-			ts->idle_sleeptime =3D ktime_add(ts->idle_sleeptime, delta);
-		ts->idle_entrytime =3D now;
-	}
+	if (WARN_ON_ONCE(!ts->idle_active))
+		return;
=20
-	if (last_update_time)
-		*last_update_time =3D ktime_to_us(now);
+	delta =3D ktime_sub(now, ts->idle_entrytime);
=20
-}
+	write_seqcount_begin(&ts->idle_sleeptime_seq);
+	if (nr_iowait_cpu(smp_processor_id()) > 0)
+		ts->iowait_sleeptime =3D ktime_add(ts->iowait_sleeptime, delta);
+	else
+		ts->idle_sleeptime =3D ktime_add(ts->idle_sleeptime, delta);
=20
-static void tick_nohz_stop_idle(struct tick_sched *ts, ktime_t now)
-{
-	update_ts_time_stats(smp_processor_id(), ts, now, NULL);
+	ts->idle_entrytime =3D now;
 	ts->idle_active =3D 0;
+	write_seqcount_end(&ts->idle_sleeptime_seq);
=20
 	sched_clock_idle_wakeup_event();
 }
=20
 static void tick_nohz_start_idle(struct tick_sched *ts)
 {
+	write_seqcount_begin(&ts->idle_sleeptime_seq);
 	ts->idle_entrytime =3D ktime_get();
 	ts->idle_active =3D 1;
+	write_seqcount_end(&ts->idle_sleeptime_seq);
+
 	sched_clock_idle_sleep_event();
 }
=20
+static u64 get_cpu_sleep_time_us(struct tick_sched *ts, ktime_t *sleeptime,
+				 bool compute_delta, u64 *last_update_time)
+{
+	ktime_t now, idle;
+	unsigned int seq;
+
+	if (!tick_nohz_active)
+		return -1;
+
+	now =3D ktime_get();
+	if (last_update_time)
+		*last_update_time =3D ktime_to_us(now);
+
+	do {
+		seq =3D read_seqcount_begin(&ts->idle_sleeptime_seq);
+
+		if (ts->idle_active && compute_delta) {
+			ktime_t delta =3D ktime_sub(now, ts->idle_entrytime);
+
+			idle =3D ktime_add(*sleeptime, delta);
+		} else {
+			idle =3D *sleeptime;
+		}
+	} while (read_seqcount_retry(&ts->idle_sleeptime_seq, seq));
+
+	return ktime_to_us(idle);
+
+}
+
 /**
  * get_cpu_idle_time_us - get the total idle time of a CPU
  * @cpu: CPU number to query
@@ -681,7 +705,10 @@ static void tick_nohz_start_idle(struct tick_sched *ts)
  * counters if NULL.
  *
  * Return the cumulative idle time (since boot) for a given
- * CPU, in microseconds.
+ * CPU, in microseconds. Note this is partially broken due to
+ * the counter of iowait tasks that can be remotely updated without
+ * any synchronization. Therefore it is possible to observe backward
+ * values within two consecutive reads.
  *
  * This time is measured via accounting rather than sampling,
  * and is as accurate as ktime_get() is.
@@ -691,27 +718,9 @@ static void tick_nohz_start_idle(struct tick_sched *ts)
 u64 get_cpu_idle_time_us(int cpu, u64 *last_update_time)
 {
 	struct tick_sched *ts =3D &per_cpu(tick_cpu_sched, cpu);
-	ktime_t now, idle;
-
-	if (!tick_nohz_active)
-		return -1;
-
-	now =3D ktime_get();
-	if (last_update_time) {
-		update_ts_time_stats(cpu, ts, now, last_update_time);
-		idle =3D ts->idle_sleeptime;
-	} else {
-		if (ts->idle_active && !nr_iowait_cpu(cpu)) {
-			ktime_t delta =3D ktime_sub(now, ts->idle_entrytime);
-
-			idle =3D ktime_add(ts->idle_sleeptime, delta);
-		} else {
-			idle =3D ts->idle_sleeptime;
-		}
-	}
-
-	return ktime_to_us(idle);
=20
+	return get_cpu_sleep_time_us(ts, &ts->idle_sleeptime,
+				     !nr_iowait_cpu(cpu), last_update_time);
 }
 EXPORT_SYMBOL_GPL(get_cpu_idle_time_us);
=20
@@ -722,7 +731,10 @@ EXPORT_SYMBOL_GPL(get_cpu_idle_time_us);
  * counters if NULL.
  *
  * Return the cumulative iowait time (since boot) for a given
- * CPU, in microseconds.
+ * CPU, in microseconds. Note this is partially broken due to
+ * the counter of iowait tasks that can be remotely updated without
+ * any synchronization. Therefore it is possible to observe backward
+ * values within two consecutive reads.
  *
  * This time is measured via accounting rather than sampling,
  * and is as accurate as ktime_get() is.
@@ -732,26 +744,9 @@ EXPORT_SYMBOL_GPL(get_cpu_idle_time_us);
 u64 get_cpu_iowait_time_us(int cpu, u64 *last_update_time)
 {
 	struct tick_sched *ts =3D &per_cpu(tick_cpu_sched, cpu);
-	ktime_t now, iowait;
=20
-	if (!tick_nohz_active)
-		return -1;
-
-	now =3D ktime_get();
-	if (last_update_time) {
-		update_ts_time_stats(cpu, ts, now, last_update_time);
-		iowait =3D ts->iowait_sleeptime;
-	} else {
-		if (ts->idle_active && nr_iowait_cpu(cpu) > 0) {
-			ktime_t delta =3D ktime_sub(now, ts->idle_entrytime);
-
-			iowait =3D ktime_add(ts->iowait_sleeptime, delta);
-		} else {
-			iowait =3D ts->iowait_sleeptime;
-		}
-	}
-
-	return ktime_to_us(iowait);
+	return get_cpu_sleep_time_us(ts, &ts->iowait_sleeptime,
+				     nr_iowait_cpu(cpu), last_update_time);
 }
 EXPORT_SYMBOL_GPL(get_cpu_iowait_time_us);
=20
@@ -1084,10 +1079,16 @@ static bool can_stop_idle_tick(int cpu, struct tick_s=
ched *ts)
 	return true;
 }
=20
-static void __tick_nohz_idle_stop_tick(struct tick_sched *ts)
+/**
+ * tick_nohz_idle_stop_tick - stop the idle tick from the idle task
+ *
+ * When the next event is more than a tick into the future, stop the idle ti=
ck
+ */
+void tick_nohz_idle_stop_tick(void)
 {
-	ktime_t expires;
+	struct tick_sched *ts =3D this_cpu_ptr(&tick_cpu_sched);
 	int cpu =3D smp_processor_id();
+	ktime_t expires;
=20
 	/*
 	 * If tick_nohz_get_sleep_length() ran tick_nohz_next_event(), the
@@ -1119,16 +1120,6 @@ static void __tick_nohz_idle_stop_tick(struct tick_sch=
ed *ts)
 	}
 }
=20
-/**
- * tick_nohz_idle_stop_tick - stop the idle tick from the idle task
- *
- * When the next event is more than a tick into the future, stop the idle ti=
ck
- */
-void tick_nohz_idle_stop_tick(void)
-{
-	__tick_nohz_idle_stop_tick(this_cpu_ptr(&tick_cpu_sched));
-}
-
 void tick_nohz_idle_retain_tick(void)
 {
 	tick_nohz_retain_tick(this_cpu_ptr(&tick_cpu_sched));
diff --git a/kernel/time/tick-sched.h b/kernel/time/tick-sched.h
index 504649513399..5ed5a9d41d5a 100644
--- a/kernel/time/tick-sched.h
+++ b/kernel/time/tick-sched.h
@@ -22,65 +22,82 @@ enum tick_nohz_mode {
=20
 /**
  * struct tick_sched - sched tick emulation and no idle tick control/stats
- * @sched_timer:	hrtimer to schedule the periodic tick in high
- *			resolution mode
- * @check_clocks:	Notification mechanism about clocksource changes
- * @nohz_mode:		Mode - one state of tick_nohz_mode
+ *
  * @inidle:		Indicator that the CPU is in the tick idle mode
  * @tick_stopped:	Indicator that the idle tick has been stopped
  * @idle_active:	Indicator that the CPU is actively in the tick idle mode;
  *			it is reset during irq handling phases.
- * @do_timer_lst:	CPU was the last one doing do_timer before going idle
+ * @do_timer_last:	CPU was the last one doing do_timer before going idle
  * @got_idle_tick:	Tick timer function has run with @inidle set
+ * @stalled_jiffies:	Number of stalled jiffies detected across ticks
+ * @last_tick_jiffies:	Value of jiffies seen on last tick
+ * @sched_timer:	hrtimer to schedule the periodic tick in high
+ *			resolution mode
  * @last_tick:		Store the last tick expiry time when the tick
  *			timer is modified for nohz sleeps. This is necessary
  *			to resume the tick timer operation in the timeline
  *			when the CPU returns from nohz sleep.
  * @next_tick:		Next tick to be fired when in dynticks mode.
  * @idle_jiffies:	jiffies at the entry to idle for idle time accounting
+ * @idle_waketime:	Time when the idle was interrupted
+ * @idle_entrytime:	Time when the idle call was entered
+ * @nohz_mode:		Mode - one state of tick_nohz_mode
+ * @last_jiffies:	Base jiffies snapshot when next event was last computed
+ * @timer_expires_base:	Base time clock monotonic for @timer_expires
+ * @timer_expires:	Anticipated timer expiration time (in case sched tick is =
stopped)
+ * @next_timer:		Expiry time of next expiring timer for debugging purpose on=
ly
+ * @idle_expires:	Next tick in idle, for debugging purpose only
  * @idle_calls:		Total number of idle calls
  * @idle_sleeps:	Number of idle calls, where the sched tick was stopped
- * @idle_entrytime:	Time when the idle call was entered
- * @idle_waketime:	Time when the idle was interrupted
  * @idle_exittime:	Time when the idle state was left
  * @idle_sleeptime:	Sum of the time slept in idle with sched tick stopped
  * @iowait_sleeptime:	Sum of the time slept in idle with sched tick stopped,=
 with IO outstanding
- * @timer_expires:	Anticipated timer expiration time (in case sched tick is =
stopped)
- * @timer_expires_base:	Base time clock monotonic for @timer_expires
- * @next_timer:		Expiry time of next expiring timer for debugging purpose on=
ly
  * @tick_dep_mask:	Tick dependency mask - is set, if someone needs the tick
- * @last_tick_jiffies:	Value of jiffies seen on last tick
- * @stalled_jiffies:	Number of stalled jiffies detected across ticks
+ * @check_clocks:	Notification mechanism about clocksource changes
  */
 struct tick_sched {
-	struct hrtimer			sched_timer;
-	unsigned long			check_clocks;
-	enum tick_nohz_mode		nohz_mode;
-
+	/* Common flags */
 	unsigned int			inidle		: 1;
 	unsigned int			tick_stopped	: 1;
 	unsigned int			idle_active	: 1;
 	unsigned int			do_timer_last	: 1;
 	unsigned int			got_idle_tick	: 1;
=20
+	/* Tick handling: jiffies stall check */
+	unsigned int			stalled_jiffies;
+	unsigned long			last_tick_jiffies;
+
+	/* Tick handling */
+	struct hrtimer			sched_timer;
 	ktime_t				last_tick;
 	ktime_t				next_tick;
 	unsigned long			idle_jiffies;
-	unsigned long			idle_calls;
-	unsigned long			idle_sleeps;
-	ktime_t				idle_entrytime;
 	ktime_t				idle_waketime;
-	ktime_t				idle_exittime;
-	ktime_t				idle_sleeptime;
-	ktime_t				iowait_sleeptime;
+
+	/* Idle entry */
+	seqcount_t			idle_sleeptime_seq;
+	ktime_t				idle_entrytime;
+
+	/* Tick stop */
+	enum tick_nohz_mode		nohz_mode;
 	unsigned long			last_jiffies;
-	u64				timer_expires;
 	u64				timer_expires_base;
+	u64				timer_expires;
 	u64				next_timer;
 	ktime_t				idle_expires;
+	unsigned long			idle_calls;
+	unsigned long			idle_sleeps;
+
+	/* Idle exit */
+	ktime_t				idle_exittime;
+	ktime_t				idle_sleeptime;
+	ktime_t				iowait_sleeptime;
+
+	/* Full dynticks handling */
 	atomic_t			tick_dep_mask;
-	unsigned long			last_tick_jiffies;
-	unsigned int			stalled_jiffies;
+
+	/* Clocksource changes */
+	unsigned long			check_clocks;
 };
=20
 extern struct tick_sched *tick_get_tick_sched(int cpu);
diff --git a/lib/vdso/Makefile b/lib/vdso/Makefile
index e814061d6aa0..9f031eafc465 100644
--- a/lib/vdso/Makefile
+++ b/lib/vdso/Makefile
@@ -5,18 +5,13 @@ GENERIC_VDSO_DIR :=3D $(dir $(GENERIC_VDSO_MK_PATH))
=20
 c-gettimeofday-$(CONFIG_GENERIC_GETTIMEOFDAY) :=3D $(addprefix $(GENERIC_VDS=
O_DIR), gettimeofday.c)
=20
-# This cmd checks that the vdso library does not contain absolute relocation
+# This cmd checks that the vdso library does not contain dynamic relocations.
 # It has to be called after the linking of the vdso library and requires it
 # as a parameter.
 #
-# $(ARCH_REL_TYPE_ABS) is defined in the arch specific makefile and correspo=
nds
-# to the absolute relocation types printed by "objdump -R" and accepted by t=
he
-# dynamic linker.
-ifndef ARCH_REL_TYPE_ABS
-$(error ARCH_REL_TYPE_ABS is not set)
-endif
-
+# As a workaround for some GNU ld ports which produce unneeded R_*_NONE
+# dynamic relocations, ignore R_*_NONE.
 quiet_cmd_vdso_check =3D VDSOCHK $@
-      cmd_vdso_check =3D if $(OBJDUMP) -R $@ | grep -E -h "$(ARCH_REL_TYPE_A=
BS)"; \
+      cmd_vdso_check =3D if $(READELF) -rW $@ | grep -v _NONE | grep -q " R_=
\w*_"; \
 		       then (echo >&2 "$@: dynamic relocations are not supported"; \
 			     rm -f $@; /bin/false); fi
diff --git a/tools/testing/selftests/proc/proc-uptime-001.c b/tools/testing/s=
elftests/proc/proc-uptime-001.c
index 781f7a50fc3f..f335eec5067e 100644
--- a/tools/testing/selftests/proc/proc-uptime-001.c
+++ b/tools/testing/selftests/proc/proc-uptime-001.c
@@ -13,7 +13,9 @@
  * ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
  * OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
  */
-// Test that values in /proc/uptime increment monotonically.
+// Test that boottime value in /proc/uptime and CLOCK_BOOTTIME increment
+// monotonically. We don't test idle time monotonicity due to broken iowait
+// task counting, cf: comment above get_cpu_idle_time_us()
 #undef NDEBUG
 #include <assert.h>
 #include <stdint.h>
@@ -25,20 +27,31 @@
=20
 int main(void)
 {
-	uint64_t start, u0, u1, i0, i1;
+	uint64_t start, u0, u1, c0, c1;
 	int fd;
=20
 	fd =3D open("/proc/uptime", O_RDONLY);
 	assert(fd >=3D 0);
=20
-	proc_uptime(fd, &u0, &i0);
+	u0 =3D proc_uptime(fd);
 	start =3D u0;
+	c0 =3D clock_boottime();
+
 	do {
-		proc_uptime(fd, &u1, &i1);
+		u1 =3D proc_uptime(fd);
+		c1 =3D clock_boottime();
+
+		/* Is /proc/uptime monotonic ? */
 		assert(u1 >=3D u0);
-		assert(i1 >=3D i0);
+
+		/* Is CLOCK_BOOTTIME monotonic ? */
+		assert(c1 >=3D c0);
+
+		/* Is CLOCK_BOOTTIME VS /proc/uptime monotonic ? */
+		assert(c0 >=3D u0);
+
 		u0 =3D u1;
-		i0 =3D i1;
+		c0 =3D c1;
 	} while (u1 - start < 100);
=20
 	return 0;
diff --git a/tools/testing/selftests/proc/proc-uptime-002.c b/tools/testing/s=
elftests/proc/proc-uptime-002.c
index 7d0aa22bdc12..ae453daa96c1 100644
--- a/tools/testing/selftests/proc/proc-uptime-002.c
+++ b/tools/testing/selftests/proc/proc-uptime-002.c
@@ -13,8 +13,10 @@
  * ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
  * OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
  */
-// Test that values in /proc/uptime increment monotonically
-// while shifting across CPUs.
+// Test that boottime value in /proc/uptime and CLOCK_BOOTTIME increment
+// monotonically while shifting across CPUs. We don't test idle time
+// monotonicity due to broken iowait task counting, cf: comment above
+// get_cpu_idle_time_us()
 #undef NDEBUG
 #include <assert.h>
 #include <errno.h>
@@ -42,10 +44,10 @@ static inline int sys_sched_setaffinity(pid_t pid, unsign=
ed int len, unsigned lo
=20
 int main(void)
 {
+	uint64_t u0, u1, c0, c1;
 	unsigned int len;
 	unsigned long *m;
 	unsigned int cpu;
-	uint64_t u0, u1, i0, i1;
 	int fd;
=20
 	/* find out "nr_cpu_ids" */
@@ -60,7 +62,9 @@ int main(void)
 	fd =3D open("/proc/uptime", O_RDONLY);
 	assert(fd >=3D 0);
=20
-	proc_uptime(fd, &u0, &i0);
+	u0 =3D proc_uptime(fd);
+	c0 =3D clock_boottime();
+
 	for (cpu =3D 0; cpu < len * 8; cpu++) {
 		memset(m, 0, len);
 		m[cpu / (8 * sizeof(unsigned long))] |=3D 1UL << (cpu % (8 * sizeof(unsign=
ed long)));
@@ -68,11 +72,20 @@ int main(void)
 		/* CPU might not exist, ignore error */
 		sys_sched_setaffinity(0, len, m);
=20
-		proc_uptime(fd, &u1, &i1);
+		u1 =3D proc_uptime(fd);
+		c1 =3D clock_boottime();
+
+		/* Is /proc/uptime monotonic ? */
 		assert(u1 >=3D u0);
-		assert(i1 >=3D i0);
+
+		/* Is CLOCK_BOOTTIME monotonic ? */
+		assert(c1 >=3D c0);
+
+		/* Is CLOCK_BOOTTIME VS /proc/uptime monotonic ? */
+		assert(c0 >=3D u0);
+
 		u0 =3D u1;
-		i0 =3D i1;
+		c0 =3D c1;
 	}
=20
 	return 0;
diff --git a/tools/testing/selftests/proc/proc-uptime.h b/tools/testing/selft=
ests/proc/proc-uptime.h
index dc6a42b1d6b0..730cce4a3d73 100644
--- a/tools/testing/selftests/proc/proc-uptime.h
+++ b/tools/testing/selftests/proc/proc-uptime.h
@@ -19,10 +19,22 @@
 #include <string.h>
 #include <stdlib.h>
 #include <unistd.h>
+#include <time.h>
=20
 #include "proc.h"
=20
-static void proc_uptime(int fd, uint64_t *uptime, uint64_t *idle)
+static uint64_t clock_boottime(void)
+{
+	struct timespec ts;
+	int err;
+
+	err =3D clock_gettime(CLOCK_BOOTTIME, &ts);
+	assert(err >=3D 0);
+
+	return (ts.tv_sec * 100) + (ts.tv_nsec / 10000000);
+}
+
+static uint64_t proc_uptime(int fd)
 {
 	uint64_t val1, val2;
 	char buf[64], *p;
@@ -43,18 +55,6 @@ static void proc_uptime(int fd, uint64_t *uptime, uint64_t=
 *idle)
 	assert(p[3] =3D=3D ' ');
=20
 	val2 =3D (p[1] - '0') * 10 + p[2] - '0';
-	*uptime =3D val1 * 100 + val2;
-
-	p +=3D 4;
-
-	val1 =3D xstrtoull(p, &p);
-	assert(p[0] =3D=3D '.');
-	assert('0' <=3D p[1] && p[1] <=3D '9');
-	assert('0' <=3D p[2] && p[2] <=3D '9');
-	assert(p[3] =3D=3D '\n');
-
-	val2 =3D (p[1] - '0') * 10 + p[2] - '0';
-	*idle =3D val1 * 100 + val2;
=20
-	assert(p + 4 =3D=3D buf + rv);
+	return val1 * 100 + val2;
 }
diff --git a/tools/testing/selftests/timers/posix_timers.c b/tools/testing/se=
lftests/timers/posix_timers.c
index 0ba500056e63..8a17c0e8d82b 100644
--- a/tools/testing/selftests/timers/posix_timers.c
+++ b/tools/testing/selftests/timers/posix_timers.c
@@ -188,6 +188,80 @@ static int check_timer_create(int which)
 	return 0;
 }
=20
+int remain;
+__thread int got_signal;
+
+static void *distribution_thread(void *arg)
+{
+	while (__atomic_load_n(&remain, __ATOMIC_RELAXED));
+	return NULL;
+}
+
+static void distribution_handler(int nr)
+{
+	if (!__atomic_exchange_n(&got_signal, 1, __ATOMIC_RELAXED))
+		__atomic_fetch_sub(&remain, 1, __ATOMIC_RELAXED);
+}
+
+/*
+ * Test that all running threads _eventually_ receive CLOCK_PROCESS_CPUTIME_=
ID
+ * timer signals. This primarily tests that the kernel does not favour any o=
ne.
+ */
+static int check_timer_distribution(void)
+{
+	int err, i;
+	timer_t id;
+	const int nthreads =3D 10;
+	pthread_t threads[nthreads];
+	struct itimerspec val =3D {
+		.it_value.tv_sec =3D 0,
+		.it_value.tv_nsec =3D 1000 * 1000,
+		.it_interval.tv_sec =3D 0,
+		.it_interval.tv_nsec =3D 1000 * 1000,
+	};
+
+	printf("Check timer_create() per process signal distribution... ");
+	fflush(stdout);
+
+	remain =3D nthreads + 1;  /* worker threads + this thread */
+	signal(SIGALRM, distribution_handler);
+	err =3D timer_create(CLOCK_PROCESS_CPUTIME_ID, NULL, &id);
+	if (err < 0) {
+		perror("Can't create timer\n");
+		return -1;
+	}
+	err =3D timer_settime(id, 0, &val, NULL);
+	if (err < 0) {
+		perror("Can't set timer\n");
+		return -1;
+	}
+
+	for (i =3D 0; i < nthreads; i++) {
+		if (pthread_create(&threads[i], NULL, distribution_thread, NULL)) {
+			perror("Can't create thread\n");
+			return -1;
+		}
+	}
+
+	/* Wait for all threads to receive the signal. */
+	while (__atomic_load_n(&remain, __ATOMIC_RELAXED));
+
+	for (i =3D 0; i < nthreads; i++) {
+		if (pthread_join(threads[i], NULL)) {
+			perror("Can't join thread\n");
+			return -1;
+		}
+	}
+
+	if (timer_delete(id)) {
+		perror("Can't delete timer\n");
+		return -1;
+	}
+
+	printf("[OK]\n");
+	return 0;
+}
+
 int main(int argc, char **argv)
 {
 	printf("Testing posix timers. False negative may happen on CPU execution \n=
");
@@ -217,5 +291,8 @@ int main(int argc, char **argv)
 	if (check_timer_create(CLOCK_PROCESS_CPUTIME_ID) < 0)
 		return ksft_exit_fail();
=20
+	if (check_timer_distribution() < 0)
+		return ksft_exit_fail();
+
 	return ksft_exit_pass();
 }

