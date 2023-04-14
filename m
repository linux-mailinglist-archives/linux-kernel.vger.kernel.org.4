Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 244DC6E2CFD
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Apr 2023 01:44:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229802AbjDNXoV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 19:44:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229596AbjDNXoT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 19:44:19 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4121C5243;
        Fri, 14 Apr 2023 16:44:16 -0700 (PDT)
Message-ID: <20230414225551.858160935@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1681515853;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=2FBNXDCOjdNXMioUNtpnUEdjyh1DRJi8Y1Kqgx20DOM=;
        b=i+svBH7O/oaj7aunuMsHcDS2onKFuoOeQ13uBn0i2EZBlR0v4LMikX50FeDA9uuKtpCCb4
        z/ZWJt0/vTUZz6mY9zE5iv3BQkst/GrxSi6Ihj+kSlASau5HRJFfQmM6o+Ezs2LFefuihB
        OfOybKBgg03vWHVVy+lwwdcxJzNP2Mj4ptIvtRem3TShasnYo0WGCg3BGy7G1RTXjq6H0Q
        McFUN7aC8YHh6CBsi49Ue6HNDjvXBu1uwc2ekdjKi/zkZtzpv+eFnW/uvjlxZJOJf9q5K0
        HXiWxG4BHUsSjcGVIe0d8f1X+Bi3gXR6qL+GYAhvxOO7XxPoj1jAoHFb0nd3bw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1681515853;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=2FBNXDCOjdNXMioUNtpnUEdjyh1DRJi8Y1Kqgx20DOM=;
        b=CjkzjdOXpz0mr1oMcda6Lg3ZiGC4HBFA8/eiJ3o7o6axQMA6SR74jLA8yo7Mg0AL4WrPGY
        YXxTfH/3ZF/ENPBg==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, David Woodhouse <dwmw@infradead.org>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Brian Gerst <brgerst@gmail.com>,
        "Arjan van de Veen" <arjan@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Paul McKenney <paulmck@kernel.org>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Sean Christopherson <seanjc@google.com>,
        Oleksandr Natalenko <oleksandr@natalenko.name>,
        Paul Menzel <pmenzel@molgen.mpg.de>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        Piotr Gorski <lucjan.lucjanov@gmail.com>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Usama Arif <usama.arif@bytedance.com>,
        Juergen Gross <jgross@suse.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        xen-devel@lists.xenproject.org,
        Russell King <linux@armlinux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        linux-arm-kernel@lists.infradead.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Guo Ren <guoren@kernel.org>,
        linux-csky@vger.kernel.org,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-mips@vger.kernel.org,
        "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
        Helge Deller <deller@gmx.de>, linux-parisc@vger.kernel.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        linux-riscv@lists.infradead.org,
        Mark Rutland <mark.rutland@arm.com>,
        Sabin Rapan <sabrapan@amazon.com>
Subject: [patch 00/37] cpu/hotplug, x86: Reworked parallel CPU bringup
Date:   Sat, 15 Apr 2023 01:44:13 +0200 (CEST)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

This is a complete rework of the parallel bringup patch series (V17)

    https://lore.kernel.org/lkml/20230328195758.1049469-1-usama.arif@bytedance.com

to address the issues which were discovered in review:

 1) The X86 microcode loader serialization requirement

    https://lore.kernel.org/lkml/87v8iirxun.ffs@tglx

    Microcode loading on HT enabled X86 CPUs requires that the microcode is
    loaded on the primary thread. The sibling thread(s) must be in
    quiescent state; either looping in a place which is aware of potential
    changes by the microcode update (see late loading) or in fully quiescent
    state, i.e. waiting for INIT/SIPI.

    This is required by hardware/firmware on Intel. Aside of that it's a
    vendor independent software correctness issue. Assume the following
    sequence:

    CPU1.0	  	      CPU1.1
    			      CPUID($A)
    Load microcode.
    Changes CPUID($A, $B)
    			      CPUID($B)

    CPU1.1 makes a decision on $A and $B which might be inconsistent due
    to the microcode update.

    The solution for this is to bringup the primary threads first and after
    that the siblings. Loading microcode on the siblings is a NOOP on Intel
    and on AMD it is guaranteed to only modify thread local state.

    This ensures that the APs can load microcode before reaching the alive
    synchronization point w/o doing any further x86 specific
    synchronization between the core siblings.

 2) The general design issues discussed in V16

    https://lore.kernel.org/lkml/87pm8y6yme.ffs@tglx

    The previous parallel bringup patches just glued this mechanism into
    the existing code without a deeper analysis of the synchronization
    mechanisms and without generalizing it so that the control logic is
    mostly in the core code and not made an architecture specific tinker
    space.

    Much of that had been pointed out 2 years ago in the discussions about
    the early versions of parallel bringup already.


The series is based on:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip x86/apic

and also available from git:

  git://git.kernel.org/pub/scm/linux/kernel/git/tglx/devel.git hotplug


Background
----------

The reason why people are interested in parallel bringup is to shorten
the (kexec) reboot time of cloud servers to reduce the downtime of the
VM tenants. There are obviously other interesting use cases for this
like VM startup time, embedded devices...

The current fully serialized bringup does the following per AP:

    1) Prepare callbacks (allocate, intialize, create threads)
    2) Kick the AP alive (e.g. INIT/SIPI on x86)
    3) Wait for the AP to report alive state
    4) Let the AP continue through the atomic bringup
    5) Let the AP run the threaded bringup to full online state

There are two significant delays:

    #3 The time for an AP to report alive state in start_secondary() on x86
       has been measured in the range between 350us and 3.5ms depending on
       vendor and CPU type, BIOS microcode size etc.

    #4 The atomic bringup does the microcode update. This has been measured
       to take up to ~8ms on the primary threads depending on the microcode
       patch size to apply.

On a two socket SKL server with 56 cores (112 threads) the boot CPU spends
on current mainline about 800ms busy waiting for the APs to come up and
apply microcode. That's more than 80% of the actual onlining procedure.

By splitting the actual bringup mechanism into two parts this can be
reduced to waiting for the first AP to report alive or if the system is
large enough the first AP is already waiting when the boot CPU finished the
wake-up of the last AP.


The actual solution comes in several parts
------------------------------------------

 1) [P 1-2] General cleanups (init annotations, kernel doc...)

 2) [P 3] The obvious

    Avoid pointless delay calibration when TSC is synchronized across
    sockets. That removes a whopping 100ms delay for the first CPU of a
    socket. This is an improvement independent of parallel bringup and had
    been discussed two years ago already.

 2) [P 3-6] Removal of the CPU0 hotplug hack.

    This was added 11 years ago with the promise to make this a real
    hardware mechanism, but that never materialized. As physical CPU
    hotplug is not really supported and the physical unplugging of CPU0
    never materialized there is no reason to keep this cruft around. It's
    just maintenance ballast for no value and the removal makes
    implementing the parallel bringup feature way simpler.

 3) [P 7-16] Cleanup of the existing bringup mechanism:

     a) Code reorganisation so that the general hotplug specific code is
        in smpboot.c and not sprinkled all over the place

     b) Decouple MTRR/PAT initialization from smp_callout_mask to prepare
        for replacing that mask with a hotplug core code synchronization
        mechanism.

     c) Make TSC synchronization function call based so that the control CPU
        does not have to busy wait for nothing if synchronization is not
        required.

     d) Remove the smp_callin_mask synchronization point as its not longer
        required due to #3c.

     e) Rework the sparse_irq_lock held region in the core code so that the
        next polling synchronization point in the x86 code can be removed to.

     f) Due to #3e it's not longer required to spin wait for the AP to set
        it's online bit.  Remove wait_cpu_online() and the XENPV
        counterpart. So the control CPU can directly wait for the online
        idle completion by the AP and free the control CPU up for other
        work.

     This reduces the synchronization points in the x86 code to one, which
     is the AP alive one. This synchronization will be moved to core
     infrastructure in the next section.

 4) [P 17-27] Replace the disconnected CPU state tracking

    The extra CPU state tracking which is used by a few architectures is
    completely separate from the CPU hotplug core code.

    Replacing it by a variant integrated in the core hotplug machinery
    allows to reduce architecture specific code and provides a generic
    synchronization mechanism for (parallel) CPU bringup/teardown.

    - Convert x86 over and replace the AP alive synchronization on x86 with
      the core variant which removes the remaining x86 hotplug
      synchronization masks.

    - Convert the other architectures usage and remove the old interface
      and code.

 5) [P 28-30] Split the bringup into two steps

    First step invokes the wakeup function on the BP, e.g. SIPI/STARTUP on
    x86. The second one waits on the BP for the AP to report alive and
    releases it for the complete onlining.

    As the hotplug state machine allows partial bringup this allows later
    to kick all APs alive in a first iteration and then bring them up
    completely one by one afterwards.

 6) [P 31] Switch the primary thread detection to a cpumask

    This makes the parallel bringup a simple cpumask based mechanism
    without tons of conditionals and checks for primary threads.

 7) [P 32] Implement the parallel bringup core code

    The parallel bringup looks like this:
    
      1) Bring up the primary SMT threads to the CPUHP_KICK_AP_ALIVE step
      	 one by one

      2) Bring up the primary SMT threads to the CPUHP_ONLINE step one by
      	 one

      3) Bring up the secondary SMT threads to the CPUHP_KICK_AP_ALIVE
      	 step one by one

      4) Bring up the secondary SMT threads to the CPUHP_ONLINE
      	 step one by one

    In case that SMT is not supported this is obviously reduced to step #1
    and #2.

 8) [P 33-37] Prepare X86 for parallel bringup and enable it


Caveats
-------

The non X86 changes have been all compile tested. Boot and runtime
testing has only be done on a few real hardware platforms and qemu as
available. That definitely needs some help from the people who have
these systems at their fingertips.


Results and analysis
--------------------

Here are numbers for a dual socket SKL 56 cores/ 112 threads machine.  All
numbers in milliseconds. The time measured is the time which the cpu_up()
call takes for each CPU and phase. It's not exact as the system is already
scheduling, handling interrupts and soft interrupts, which is obviously
skewing the picture slightly.

Baseline tip tree x86/apic branch.

		total      avg/CPU          min          max
total  :      912.081        8.217        3.720      113.271

The max of 100ms is due to the silly delay calibration for the second
socket which takes 100ms and was eliminated first. Also the other initial
cleanups and improvements take some time away.

So the real baseline becomes:

		total      avg/CPU          min          max
total  :      785.960        7.081        3.752       36.098

The max here is on the first CPU of the second socket. 20ms of that is due
to TSC synchronization and an extra 2ms to react on the SIPI.

With parallel bootup enabled this becomes:

		total      avg/CPU          min          max
prepare:       39.108        0.352        0.238        0.883
online :       45.166        0.407        0.170       20.357
total  :       84.274        0.759        0.408       21.240

That's a factor ~9.3 reduction on average.

Looking at the 27 primary threads of socket 0 then this becomes even more
interesting:

		total      avg/CPU          min          max
total  :      325.764       12.065       11.981       14.125

versus:
		total      avg/CPU          min          max
prepare:        8.945        0.331        0.238        0.834
online :        4.830        0.179        0.170        0.212
total  :       13.775        0.510        0.408        1.046

So the reduction factor is ~23.5 here. That's mostly because the 20ms TSC
sync is not skewing the picture.

For all 55 primaries, i.e with the 20ms TSC sync extra for socket 1 this
becomes:

                total      avg/CPU          min          max
total  :      685.489       12.463       11.975       36.098

versus:

                total      avg/CPU          min          max
prepare:       19.080        0.353        0.238        0.883
online :       30.283        0.561        0.170       20.357
total  :       49.363        0.914        0.408       21.240

The TSC sync reduces the win to a factor of ~13.8

With 'tsc=reliable' on the command line the socket sync is disabled which
brings it back to the socket 0 numbers:

                total      avg/CPU          min          max
prepare:       18.970        0.351        0.231        0.874
online :       10.328        0.191        0.169        0.358
total  :       29.298        0.543        0.400        1.232

Now looking at the secondary threads only:

                total      avg/CPU          min          max
total  :      100.471        1.794        0.375        4.745

versus:
                total      avg/CPU          min          max
prepare:       19.753        0.353        0.257        0.512
online :       14.671        0.262        0.179        3.461
total  :       34.424        0.615        0.436        3.973

Still a factor of ~3.

The average on the secondaries for the serialized bringup is significantly
lower than for the primaries because the SIPI response time is shorter and
the microcode update takes no time.

This varies wildly with the system, whether microcode in BIOS is already up
to date, how big the microcode patch is and how long the INIT/SIPI response
time is. On an AMD Zen3 machine INIT/SIPI response time is amazingly fast
(350us), but then it lacks TSC_ADJUST and does a two millisecond TSC sync
test for _every_ AP. All of this sucks...


Possible further enhancements
-----------------------------

It's definitely worthwhile to look into reducing the cross socket TSC sync
test time. It's probably safe enough to use 5ms or even 2ms instead of 20ms
on systems with TSC_ADJUST and a few other 'TSC is sane' indicators. Moving
it out of the hotplug path is eventually possible, but that needs some deep
thoughts.

Let's take the TSC sync out of the picture by adding 'tsc=reliable" to the
kernel command line. So the bringup of 111 APs takes:

                total      avg/CPU          min          max
prepare:       38.936        0.351        0.231        0.874
online :       25.231        0.227        0.169        3.465
total  :       64.167        0.578        0.400        4.339

Some of the outliers are not necessarily in the state callbacks as the
system is already scheduling and handles interrupts and soft
interrupts. Haven't analyzed that yet in detail.

In the prepare stage which runs on the control CPU the larger steps are:

  smpcfd:prepare           16us  avg/CPU
  threads:prepare          98us  avg/CPU
  workqueue:prepare        43us  avg/CPU
  trace/RB:prepare	  135us	 avg/CPU

The trace ringbuffer initialization allocates 354 pages and 354 control
structures one by one. That probably should allocate a large page and an
array of control structures and work from there. I'm sure that would reduce
this significantly. Steven?

smpcfd does just a percpu allocation. No idea why that takes that long.

Vs. threads and workqueues. David thought about spreading out the
preparation work and do it really in parallel. That's a nice idea, but the
threads and workqueue prepare steps are self serializing. The workqueue one
has a global mutex and aside of that both steps create kernel threads which
implicitely serialize on kthreadd. alloc_percpu(), which is used by
smpcfd:prepare is also globally serialized.

The rest of the prepare steps is pretty much in the single digit
microseconds range.

On the AP side it should be possible to move some of the initialization
steps before the alive synchronization point, but that really needs a lot
of analysis whether the functions are safe to invoke that early and outside
of the cpu_hotplug_lock held region for the case of two stage parallel
bringup; see below.

The largest part is:

    identify_secondary_cpu()	99us avg/CPU
   
    Inside of identify_secondary_cpu() the largest offender:

      mcheck_init()		73us avg/CPU

    This part is definitly worth to be looked at whether it can be at least
    partially moved to the early startup code before the alive
    synchronization point. There's a lot of deep analysis required and
    ideally we just rewrite the whole CPUID evaluation trainwreck
    completely.

The rest of the AP side is low single digit microseconds except of:

    perf/x86:starting		14us avg/CPU

    smpboot/threads:online	13us avg/CPU
    workqueue:online		17us avg/CPU
    mm/vmstat:online		17us avg/CPU
    sched:active		30us avg/CPU

sched:active is special. Onlining the first secondary HT thread on the
second socket creates a 3.2ms outlier which skews the whole picture. That's
caused by enabling the static key sched_smt_present which patches the world
and some more. For all other APs this is really in the 1us range. This
definitely could be postponed during bootup like the scheduler domain
rebuild is done after the bringup. But that's still fully serialized and
single threaded and obviously could be done later in the context of async
parallel init. It's unclear why this is different with the fully serialized
bringup where it takes significantly less time, but that's something which
needs to be investigated.


Is truly parallel bringup feasible?
-----------------------------------

In theory yes, realistically no. Why?

   1) The preparation phase

      Allocating memory, creating threads for the to be brought up CPU must
      obviously happen on an already online CPU.

      While it would be possible to bring up a subset of CPUs first and let
      them do the preparation steps for groups of still offline CPUs
      concurrently, the actual benefit of doing so is dubious.

      The prime example is kernel thread creation, which is implicitely
      serialized on kthreadd.

      A simple experiment shows that 4 concurrent workers on 4 different
      CPUs where each is creating 14 * 5 = 70 kernel threads are 5% slower
      than a single worker creating 4 * 14 * 5 = 280 threads.

      So we'd need to have multiple kthreadd instances to handle that,
      which would then serialize on tasklist lock and other things.

      That aside the preparation phase is also affected by the problem
      below.

   2) Assumptions about hotplug serialization

      a) There are quite some assumptions about CPU bringup being fully
         serialized across state transitions.  A lot of state callbacks rely
         on that and would require local locking.

	 Adding that local locking is surely possible, but that has several
	 downsides:

          - It adds complexity and makes it harder for developers to get
	    this correct. The subtle bugs resulting out of that are going
	    to be interesting

          - Fine grained locking has a charm, but only if the time spent
	    for the actual work is larger than the time required for
	    serialization and synchronization.

	    Serializing a callback which takes less than a microsecond and
	    then having a large number of CPUs contending on the lock will
	    not make it any faster at all. That's a well known issue of
	    parallelizing and neither made up nor kernel specific.

      b) Some operations definitely require to be protected by the
         cpu_hotplug_lock, especially those which affect cpumasks as the
         masks are guaranteed to be stable in a cpus_read_lock()'ed region.

       	 As this lock cannot be taken in atomic contexts, it's required
       	 that the control CPU holds the lock write locked across these
       	 state transitions. And no, we are not making this a spinlock just
       	 for that and we even can't.

       	 Just slapping a lock into the x86 specific part of the cpumask
       	 update function does not solve anything. The relevant patch in V17
       	 is completely useless as it only serializes the actual cpumask/map
       	 modifications, but all read side users are hosed if the update
       	 would be moved before the alive synchronization point, i.e. into a
       	 non hotplug lock protected region.

       	 Even if the hotplug lock would be held accross the whole parallel
       	 bringup operation then this would still expose all usage of these
       	 masks and maps in the actual hotplug state callbacks to concurrent
       	 modifications.

       	 And no, we are not going to expose an architecture specific raw
       	 spinlock to the hotplug state callbacks, especially not to those
       	 in generic code.

      c) Some cpu_read_lock()'ed regions also expect that there is no CPU
      	 state transition happening which would modify their local
      	 state. This would again require local serialization.

    3) The amount of work and churn:

       - Analyze the per architecture low level startup functions plus their
         descendant functions and make them ready for concurrency if
       	 necessary.

       - Analyze ~300 hotplug state callbacks and their descendant functions
         and make them ready for concurrency if necessary.

       - Analyze all cpus_read_lock()'ed regions and address their
         requirements.
      
       - Rewrite the core code to handle the cpu_hotplug_lock requirements
         only in distinct phases of the state machine.

       - Rewrite the core code to handle state callback failure and the
         related rollback in the context of the new rules.

      - ...

   Even if some people are dedicated enough to do that, it's very
   questionable whether the resulting complexity is justified.

   We've spent a serious amount of time to sanitize hotplug and bring it
   into a state where it is correct. This also made it reasonably simple
   for developers to implement hotplug state callbacks without having to
   become hotplug experts.

   Breaking this completely up will result in a flood of hard to diagnose
   subtle issues for sure. Who is going to deal with them?

   The experience with this series so far does not make me comfortable
   about that thought in any way.


Summary
-------

The obvious and low hanging fruits have to be solved first:

  - The CPUID evaluation and related setup mechanisms

  - The trace/ringbuffer oddity

  - The sched:active oddity for the first sibling on the second socket
  
  - Some other expensive things which I'm not seeing in my test setup due
    to lack of hardware or configuration.

Anything else is pretty much wishful thinking in my opinion.

  To be clear. I'm not standing in the way if there is a proper solution,
  but that requires to respect the basic engineering rules:

    1) Correctness first
    2) Keep it maintainable
    3) Keep it simple

  So far this stuff failed already at #1.

I completely understand why this is important for cloud people, but
the real question to ask here is what are the actual requirements.

  As far as I understand the main goal is to make a (kexec) reboot
  almost invisible to VM tenants.

  Now lets look at how this works:

     A) Freeze VMs and persist state
     B) kexec into the new kernel
     C) Restore VMs from persistant memory
     D) Thaw VMs

  So the key problem is how long it takes to get from #B to #C and finally
  to #D.

  As far as I understand #C takes a serious amount of time and cannot be
  parallelized for whatever reasons.

  At the same time the number of online CPUs required to restore the VMs
  state is less than the number of online CPUs required to actually
  operate them in #D.

  That means it would be good enough to return to userspace with a
  limited number of online CPUs as fast as possible. A certain amount of
  CPUs are going to be busy with restoring the VMs state, i.e. one CPU
  per VM. Some remaining non-busy CPU can bringup the rest of the system
  and the APs in order to be functional for #D, i.e the restore of VM
  operation.

  Trying to optimize this purely in kernel space by adding complexity of
  dubious value is simply bogus in my opinion.

  It's already possible today to limit the number of CPUs which are
  initially onlined and online the rest later from user space.

  There are two issue there:

    a) The death by MCE broadcast problem

       Quite some (contemporary) x86 CPU generations are affected by
       this:

         - MCE can be broadcasted to all CPUs and not only issued locally
           to the CPU which triggered it.

         - Any CPU which has CR4.MCE == 0, even if it sits in a wait
           for INIT/SIPI state, will cause an immediate shutdown of the
           machine if a broadcasted MCE is delivered.

    b) Do the parallel bringup via sysfs control knob

       The per CPU target state interface allows to do that today one
       by one, but it's akward and has quite some overhead.

       A knob to online the rest of the not yet onlined present CPUs
       with the benefit of the parallel bringup mechanism is
       missing.

    #a) That's a risk to take by the operator.

        Even the regular serialized bringup does not protect against this
     	issue up to the point where all present CPUs have at least
     	initialized CR4.

	Limiting the number of APs to online early via the kernel command
	line widens that window and increases the risk further by
	executing user space before all APs have CR4 initialized.

	But the same applies to a deferred online mechanism implemented in
	the kernel where some worker brings up the not yet online APs while
	the early online CPUs are already executing user space code.

    #b) Is a no brainer to implement on top of this.


Conclusion
----------

Adding the basic parallel bringup mechanism as provided by this series
makes a lot of sense. Improving particular issues as pointed out in the
analysis makes sense too.

But trying to solve an application specific problem fully in the kernel
with tons of complexity, without exploring straight forward and simple
approaches first, does not make any sense at all.

Thanks,

	tglx

---
 Documentation/admin-guide/kernel-parameters.txt |   20 
 Documentation/core-api/cpu_hotplug.rst          |   13 
 arch/Kconfig                                    |   23 +
 arch/arm/Kconfig                                |    1 
 arch/arm/include/asm/smp.h                      |    2 
 arch/arm/kernel/smp.c                           |   18 
 arch/arm64/Kconfig                              |    1 
 arch/arm64/include/asm/smp.h                    |    2 
 arch/arm64/kernel/smp.c                         |   14 
 arch/csky/Kconfig                               |    1 
 arch/csky/include/asm/smp.h                     |    2 
 arch/csky/kernel/smp.c                          |    8 
 arch/mips/Kconfig                               |    1 
 arch/mips/cavium-octeon/smp.c                   |    1 
 arch/mips/include/asm/smp-ops.h                 |    1 
 arch/mips/kernel/smp-bmips.c                    |    1 
 arch/mips/kernel/smp-cps.c                      |   14 
 arch/mips/kernel/smp.c                          |    8 
 arch/mips/loongson64/smp.c                      |    1 
 arch/parisc/Kconfig                             |    1 
 arch/parisc/kernel/process.c                    |    4 
 arch/parisc/kernel/smp.c                        |    7 
 arch/riscv/Kconfig                              |    1 
 arch/riscv/include/asm/smp.h                    |    2 
 arch/riscv/kernel/cpu-hotplug.c                 |   14 
 arch/x86/Kconfig                                |   45 --
 arch/x86/include/asm/apic.h                     |    5 
 arch/x86/include/asm/cpu.h                      |    5 
 arch/x86/include/asm/cpumask.h                  |    5 
 arch/x86/include/asm/processor.h                |    1 
 arch/x86/include/asm/realmode.h                 |    3 
 arch/x86/include/asm/sev-common.h               |    3 
 arch/x86/include/asm/smp.h                      |   26 -
 arch/x86/include/asm/topology.h                 |   23 -
 arch/x86/include/asm/tsc.h                      |    2 
 arch/x86/kernel/acpi/sleep.c                    |    9 
 arch/x86/kernel/apic/apic.c                     |   22 -
 arch/x86/kernel/callthunks.c                    |    4 
 arch/x86/kernel/cpu/amd.c                       |    2 
 arch/x86/kernel/cpu/cacheinfo.c                 |   21 
 arch/x86/kernel/cpu/common.c                    |   50 --
 arch/x86/kernel/cpu/topology.c                  |    3 
 arch/x86/kernel/head_32.S                       |   14 
 arch/x86/kernel/head_64.S                       |  121 +++++
 arch/x86/kernel/sev.c                           |    2 
 arch/x86/kernel/smp.c                           |    3 
 arch/x86/kernel/smpboot.c                       |  508 ++++++++----------------
 arch/x86/kernel/topology.c                      |   98 ----
 arch/x86/kernel/tsc.c                           |   20 
 arch/x86/kernel/tsc_sync.c                      |   36 -
 arch/x86/power/cpu.c                            |   37 -
 arch/x86/realmode/init.c                        |    3 
 arch/x86/realmode/rm/trampoline_64.S            |   27 +
 arch/x86/xen/enlighten_hvm.c                    |   11 
 arch/x86/xen/smp_hvm.c                          |   16 
 arch/x86/xen/smp_pv.c                           |   56 +-
 drivers/acpi/processor_idle.c                   |    4 
 include/linux/cpu.h                             |    4 
 include/linux/cpuhotplug.h                      |   17 
 kernel/cpu.c                                    |  397 +++++++++++++++++-
 kernel/smp.c                                    |    2 
 kernel/smpboot.c                                |  163 -------
 62 files changed, 953 insertions(+), 976 deletions(-)


