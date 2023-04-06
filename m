Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B0396D936C
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 11:58:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235622AbjDFJ6u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 05:58:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236777AbjDFJ6b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 05:58:31 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 399D18689
        for <linux-kernel@vger.kernel.org>; Thu,  6 Apr 2023 02:57:39 -0700 (PDT)
Date:   Thu, 6 Apr 2023 11:57:35 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1680775056;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=5sQCwT1mq1QRO85FjPfVbYWFXzUgv8PGHqw/MqwDsYo=;
        b=IXwplGbrqeBQRCXHGHtbF/cuq9tUigyNFgohQLMDgHo2gYIvOAjcAC2s9W50Ps0qWAqsOY
        mLL1+fMwZmPfag4LloQKdBg4I97I1wEFazECkDyeO+emz8VBeVlHPZhEgRPHdGb9UM395c
        mD93dB3AFcWh4OfP3K176FULWhEP2HAtfQ0dSIiFhCvggPjgsqEE/k+OksVpm2PxAXa5X6
        wlu9dyCH+VN6tY4++vjYArDrWF4UNpkC9X4Yfm/g1/4Xfl7z0ewCjKlGURfGcP798wdKeR
        DYAboZ6RP1uI8942LZSckucLmC+kqpzLzPsi/UGf16csA2LHAXa/QpWpQY35Mg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1680775056;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=5sQCwT1mq1QRO85FjPfVbYWFXzUgv8PGHqw/MqwDsYo=;
        b=mUoABadoSCcWJ0ufaNuqlABINm5JtK14pOpVQ/iBlDae4aghn/EPq4vbgAzKYODSY6lDpz
        ESuT7gMmxUA08GDA==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@redhat.com>,
        Pavel Tatashin <pasha.tatashin@oracle.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [RFC] tick_sched_timer() is not properly aligned, fixed by chance
Message-ID: <20230406095735.0_14edn3@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With HIGHRES enabled tick_sched_timer() is programmed every jiffy to
expire the timer_list timers. This timer is programmed accurate in
respect to CLOCK_MONOTONIC so that 0 is the first tick and the next one
is 1000/CONFIG_HZ ms later. For HZ=3D250 every 4 ms and so the us/ns part
of the timer is always 0. This can be observed by enabling hrtimer_start
events and looking for the tick_sched_timer timer:

| <idle>-0 [009] 137.085041: hrtimer_start: hrtimer=3D000000002df4f2bc func=
tion=3Dtick_sched_timer expires=3D162784000000 softexpires=3D162784000000 m=
ode=3D0xa
| <idle>-0 [026] 137.085300: hrtimer_start: hrtimer=3D00000000b0911b5d func=
tion=3Dtick_sched_timer expires=3D316384000000 softexpires=3D316384000000 m=
ode=3D0xa

The lower part (us, ns) is zero. This is important for certain work
loads where it is needed to either align with the timer or hide after
it.

With commit
	857baa87b6422 ("sched/clock: Enable sched clock early")

merged into v4.19-rc1 this 0 offset is gone. The problematic part is the
last hunk of the patch:

|@@ -356,7 +374,7 @@ u64 sched_clock_cpu(int cpu)
|                return sched_clock() + __sched_clock_offset;
|
|        if (unlikely(!sched_clock_running))
|-               return 0ull;
|+               return sched_clock();
|
|        preempt_disable_notrace();
|        scd =3D cpu_sdc(cpu);

which returns the sched_clock() without any offset. The gain of this is
the high resolution output of the bootlog very early, so we see something
like this:
|[    0.000000] tsc: Detected 1995.083 MHz processor
|[    0.000893] e820: update [mem 0x00000000-0x00000fff] usable =3D=3D> res=
erved
|[    0.008179] e820: remove [mem 0x000a0000-0x000fffff] usable
|[    0.014395] last_pfn =3D 0xa40000 max_arch_pfn =3D 0x400000000
|[    0.020667] x86/PAT: Configuration [0-7]: WB  WC  UC- UC  WB  WP  UC- WT
|[    0.029822] last_pfn =3D 0xbe000 max_arch_pfn =3D 0x400000000
|[    0.050770] found SMP MP-table at [mem 0x000fd2a0-0x000fd2af]
|[    0.057015] Kernel/User page tables isolation: disabled on command line.
|[    0.064452] Using GB pages for direct mapping
|[    0.070337] RAMDISK: [mem 0x32d23000-0x35688fff]
|[    0.075298] ACPI: Early table checksum verification disabled
=E2=80=A6
|[    1.662577] ..TIMER: vector=3D0x30 apic1=3D0 pin1=3D2 apic2=3D-1 pin2=
=3D-1
|[    1.687317] clocksource: tsc-early: mask: 0xffffffffffffffff max_cycles=
: 0x398412f243e, max_idle_ns: 881590620736 ns
|[    1.699071] Calibrating delay loop (skipped), value calculated using ti=
mer frequency.. 3990.16 BogoMIPS (lpj=3D7980332)
|[    1.703070] pid_max: default: 32768 minimum: 301
|[    1.707238] LSM: Security Framework initializing

but the tick_sched_timer() is no longer properly aligned:
| <idle>-0 [002] 131.286274: hrtimer_start: hrtimer=3D000000000b8c5637 func=
tion=3Dtick_sched_timer expires=3D130680348871 softexpires=3D130680348871 m=
ode=3D0xa
| <idle>-0 [006] 131.286275: hrtimer_start: hrtimer=3D00000000e08369e4 func=
tion=3Dtick_sched_timer expires=3D317880348871 softexpires=3D317880348871 m=
ode=3D0xa

instead of 0 we have "348871" here. I consider this as a bug given that
this important.

Then PeterZ had other problems and committed
	776f22913b8e5 ("sched/clock: Make local_clock() noinstr")

which is part of v6.3-rc1. The important part here is (again) the last
hunk, the local_clock() implementation:

|noinstr u64 local_clock(void)
|{
|       u64 clock;
|
|       if (static_branch_likely(&__sched_clock_stable))
|               return sched_clock() + __sched_clock_offset;
|
|       preempt_disable_notrace();
|       clock =3D sched_clock_local(this_scd());
|       preempt_enable_notrace();
|
|       return clock;
|}

With the static branch disabled that early in the boot we fallback to
the sched_clock_local() which has the tick-based resolution. That means
the output is back Tick based resolution for most part of the boot
process:

|[    0.000000] tsc: Detected 1995.095 MHz processor
|[    0.000661] e820: update [mem 0x00000000-0x00000fff] usable =3D=3D> res=
erved
|[    0.000665] e820: remove [mem 0x000a0000-0x000fffff] usable
|[    0.000677] last_pfn =3D 0xa40000 max_arch_pfn =3D 0x400000000
|[    0.000684] x86/PAT: Configuration [0-7]: WB  WC  UC- UC  WB  WP  UC- WT
|[    0.001043] last_pfn =3D 0xbe000 max_arch_pfn =3D 0x400000000
|[    0.004000] found SMP MP-table at [mem 0x000fd2a0-0x000fd2af]
|[    0.004000] Using GB pages for direct mapping
=E2=80=A6
|[    0.004000] Switched APIC routing to cluster x2apic.
|[    0.004000] ..TIMER: vector=3D0x30 apic1=3D0 pin1=3D2 apic2=3D-1 pin2=
=3D-1
|[    0.004000] clocksource: tsc-early: mask: 0xffffffffffffffff max_cycles=
: 0x3984298f70d, max_idle_ns: 881590726857 ns
|[    2.083356] Calibrating delay loop (skipped), value calculated using ti=
mer frequency.. 3990.19 BogoMIPS (lpj=3D7980380)
|[    2.096542] pid_max: default: 32768 minimum: 301
|[    2.113889] Dentry cache hash table entries: 8388608 (order: 14, 671088=
64 bytes, vmalloc hugepage)

and the tick_sched_timer timer is programmed as expected.

The tick_sched_timer story is that it uses ktime_get() to set the
initial expire time and then always incremented. If the returned value
is jiffy-based then it will work as expected. If it has higher precision
then the time has to be adjusted since it is not expected.

So, what do we do?
- We would need to provide stable patches for v4.19=E2=80=A6v6.1 to address=
 the
  timer issue.

- The high precision timestamps during boot are gone. Is it important to
  bring that back? Or could that new local_clock() implementation be
  backported?

- An alternative is to ensure that the time returned by ktime_get() in
  tick_setup_device() is aligned with zeros.

Sebastian
