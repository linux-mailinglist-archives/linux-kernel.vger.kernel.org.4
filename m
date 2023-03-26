Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB95D6C9627
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Mar 2023 17:31:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232528AbjCZPbA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Mar 2023 11:31:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229621AbjCZPa6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Mar 2023 11:30:58 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDC574216
        for <linux-kernel@vger.kernel.org>; Sun, 26 Mar 2023 08:30:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 473F9B80C73
        for <linux-kernel@vger.kernel.org>; Sun, 26 Mar 2023 15:30:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD973C433D2;
        Sun, 26 Mar 2023 15:30:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679844652;
        bh=iVZ2Uqpx6N7+/RkTBcZRhKAjqP/zKHxxhqIMcG464j4=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=fZUd3/mopqvApFnUdBMYX7KmgwJXeKphGQXRi542iZ2XCviI+x+Tm0lEoyydZQCtP
         ZhdndanDpPi8zvs8ujOED6quQ4hDqS4vQz5yTgvDN3z3+dKcodBLs+wjnohU1pjvRt
         pp0qFF9dYM5gira/DRYIVSN1EWx5Y4Rzu12BLE+C1DDJQ397eDS8u/O1aAEZugVgg0
         qrGa6MeRXQfQuDitkh8d/YVFDVbb2t1azVpkFyB3ZeXD7LLgDMfqXsnI3wQjcBAzst
         BAokj5VOZ0fN6uj5FllHGjErROilMlLCzDAArb1j8VdEm440PIO82aTEiX4iQJTW7E
         3HlUGYX8oxCSg==
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 746881540431; Sun, 26 Mar 2023 08:30:52 -0700 (PDT)
Date:   Sun, 26 Mar 2023 08:30:52 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Willy Tarreau <w@1wt.eu>
Cc:     linux@weissschuh.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/8] tools/nolibc: add support for stack protector
Message-ID: <46896df9-4bbc-4c24-906f-b4f0941a4cbf@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20230325154516.7995-1-w@1wt.eu>
 <0d9bbc94-7ea2-4bc5-8523-29b100c0f1a1@paulmck-laptop>
 <a65340bb-2d11-445b-8595-9bf25a9f7a47@paulmck-laptop>
 <ZCBiDZfQW+YuiVNs@1wt.eu>
 <35a26245-0171-44b0-8072-325576768f91@paulmck-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <35a26245-0171-44b0-8072-325576768f91@paulmck-laptop>
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 26, 2023 at 08:26:32AM -0700, Paul E. McKenney wrote:
> On Sun, Mar 26, 2023 at 05:17:33PM +0200, Willy Tarreau wrote:
> > On Sun, Mar 26, 2023 at 08:13:48AM -0700, Paul E. McKenney wrote:
> > > On Sat, Mar 25, 2023 at 09:36:28PM -0700, Paul E. McKenney wrote:
> > > > On Sat, Mar 25, 2023 at 04:45:08PM +0100, Willy Tarreau wrote:
> > > > > Hello Paul,
> > > > > 
> > > > > This is essentially Thomas' work so instead of paraphrasing his work,
> > > > > I'm pasting his description below. I've tested his changes on all
> > > > > supported archs, applied a tiny modification with his permission
> > > > > to continue to support passing CFLAGS, and for me this is all fine.
> > > > > In a short summary this adds support for stack protector to i386 and
> > > > > x86_64 in nolibc, and the accompanying test to the selftest program.
> > > > > 
> > > > > A new test category was added, "protection", which currently has a
> > > > > single test. Archs that support it will report "OK" there and those
> > > > > that do not will report "SKIPPED", as is already the case for tests
> > > > > that cannot be run.
> > > > > 
> > > > > This was applied on top of your dev.2023.03.20a branch. I'm reasonably
> > > > > confident with the nature of the changes, so if your queue for 6.4 is
> > > > > not closed yet, it can be a good target, otherwise 6.5 will be fine as
> > > > > well.
> > > > 
> > > > I have applied and pushed it out, thank you both!
> > > > 
> > > > We are a little late in the process, but if testing goes well, I can't
> > > > see why this cannot make the v6.4 merge window.
> > > 
> > > And "make run-user" says "124 test(s) passed", which looks promising.
> > 
> > Indeed!
> > 
> > > But "make run" says "0 test(s) passed".
> > > 
> > > (They initially both said "0 test(s) passed", but that was because I
> > > forgot to build qemu-x86_64 after an upgrade.)
> > > 
> > > Please see below for the full output of "make run".  Am I missing
> > > some other package?
> > 
> > Hmmm I think that the output of run.out will be needed here. We'll
> > need to understand whether it fails to boot the kernel or to start
> > the executable.
> 
> Ah, I knew I was forgetting something!
> 
> I am retrying the test after rebasing Thomas's latest series directly
> on top of the rest of the nolibc patches.
> 
> In the meantime, the kernel died as shown below.

But that got the same result, 0 tests passed and the splat below.

My next step would be to rebase the stack back to v6.2, but in
the meantime, thoughts?

							Thanx, Paul

------------------------------------------------------------------------

[    0.000000] Linux version 6.3.0-rc1-00022-gd6bb807e5889 (paulmck@paulmck-ThinkPad-P72) (gcc (Ubuntu 11.3.0-1ubuntu1~22.04) 11.3.0, GNU ld (GNU Binutils for Ubuntu) 2.38) #3 SMP Sun Mar 26 08:28:21 PDT 2023
[    0.000000] Command line: console=ttyS0,9600 i8042.noaux panic=-1 
[    0.000000] x86/fpu: x87 FPU will use FXSAVE
[    0.000000] signal: max sigframe size: 1440
[    0.000000] BIOS-provided physical RAM map:
[    0.000000] BIOS-e820: [mem 0x0000000000000000-0x000000000009fbff] usable
[    0.000000] BIOS-e820: [mem 0x000000000009fc00-0x000000000009ffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000000f0000-0x00000000000fffff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000000100000-0x0000000007fdffff] usable
[    0.000000] BIOS-e820: [mem 0x0000000007fe0000-0x0000000007ffffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fffc0000-0x00000000ffffffff] reserved
[    0.000000] NX (Execute Disable) protection: active
[    0.000000] SMBIOS 2.8 present.
[    0.000000] DMI: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
[    0.000000] tsc: Fast TSC calibration using PIT
[    0.000000] tsc: Detected 2207.981 MHz processor
[    0.001000] last_pfn = 0x7fe0 max_arch_pfn = 0x400000000
[    0.001000] x86/PAT: Configuration [0-7]: WB  WC  UC- UC  WB  WP  UC- WT  
[    0.001000] found SMP MP-table at [mem 0x000f5ba0-0x000f5baf]
[    0.001000] ACPI: Early table checksum verification disabled
[    0.001000] ACPI: RSDP 0x00000000000F59E0 000014 (v00 BOCHS )
[    0.001000] ACPI: RSDT 0x0000000007FE1905 000034 (v01 BOCHS  BXPC     00000001 BXPC 00000001)
[    0.001000] ACPI: FACP 0x0000000007FE17B9 000074 (v01 BOCHS  BXPC     00000001 BXPC 00000001)
[    0.001000] ACPI: DSDT 0x0000000007FE0040 001779 (v01 BOCHS  BXPC     00000001 BXPC 00000001)
[    0.001000] ACPI: FACS 0x0000000007FE0000 000040
[    0.001000] ACPI: APIC 0x0000000007FE182D 000078 (v01 BOCHS  BXPC     00000001 BXPC 00000001)
[    0.001000] ACPI: HPET 0x0000000007FE18A5 000038 (v01 BOCHS  BXPC     00000001 BXPC 00000001)
[    0.001000] ACPI: WAET 0x0000000007FE18DD 000028 (v01 BOCHS  BXPC     00000001 BXPC 00000001)
[    0.001000] ACPI: Reserving FACP table memory at [mem 0x7fe17b9-0x7fe182c]
[    0.001000] ACPI: Reserving DSDT table memory at [mem 0x7fe0040-0x7fe17b8]
[    0.001000] ACPI: Reserving FACS table memory at [mem 0x7fe0000-0x7fe003f]
[    0.001000] ACPI: Reserving APIC table memory at [mem 0x7fe182d-0x7fe18a4]
[    0.001000] ACPI: Reserving HPET table memory at [mem 0x7fe18a5-0x7fe18dc]
[    0.001000] ACPI: Reserving WAET table memory at [mem 0x7fe18dd-0x7fe1904]
[    0.001000] No NUMA configuration found
[    0.001000] Faking a node at [mem 0x0000000000000000-0x0000000007fdffff]
[    0.001000] NODE_DATA(0) allocated [mem 0x07fdc000-0x07fdffff]
[    0.001000] Zone ranges:
[    0.001000]   DMA      [mem 0x0000000000001000-0x0000000000ffffff]
[    0.001000]   DMA32    [mem 0x0000000001000000-0x0000000007fdffff]
[    0.001000]   Normal   empty
[    0.001000] Movable zone start for each node
[    0.001000] Early memory node ranges
[    0.001000]   node   0: [mem 0x0000000000001000-0x000000000009efff]
[    0.001000]   node   0: [mem 0x0000000000100000-0x0000000007fdffff]
[    0.001000] Initmem setup node 0 [mem 0x0000000000001000-0x0000000007fdffff]
[    0.001000] On node 0, zone DMA: 1 pages in unavailable ranges
[    0.001000] On node 0, zone DMA: 97 pages in unavailable ranges
[    0.001000] On node 0, zone DMA32: 32 pages in unavailable ranges
[    0.001000] ACPI: PM-Timer IO Port: 0x608
[    0.001000] ACPI: LAPIC_NMI (acpi_id[0xff] dfl dfl lint[0x1])
[    0.001000] IOAPIC[0]: apic_id 0, version 32, address 0xfec00000, GSI 0-23
[    0.001000] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
[    0.001000] ACPI: INT_SRC_OVR (bus 0 bus_irq 5 global_irq 5 high level)
[    0.001000] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
[    0.001000] ACPI: INT_SRC_OVR (bus 0 bus_irq 10 global_irq 10 high level)
[    0.001000] ACPI: INT_SRC_OVR (bus 0 bus_irq 11 global_irq 11 high level)
[    0.001000] ACPI: Using ACPI (MADT) for SMP configuration information
[    0.001000] ACPI: HPET id: 0x8086a201 base: 0xfed00000
[    0.001000] smpboot: Allowing 1 CPUs, 0 hotplug CPUs
[    0.001000] PM: hibernation: Registered nosave memory: [mem 0x00000000-0x00000fff]
[    0.001000] PM: hibernation: Registered nosave memory: [mem 0x0009f000-0x0009ffff]
[    0.001000] PM: hibernation: Registered nosave memory: [mem 0x000a0000-0x000effff]
[    0.001000] PM: hibernation: Registered nosave memory: [mem 0x000f0000-0x000fffff]
[    0.001000] [mem 0x08000000-0xfffbffff] available for PCI devices
[    0.001000] Booting paravirtualized kernel on bare hardware
[    0.001000] clocksource: refined-jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 1910969940391419 ns
[    0.001000] setup_percpu: NR_CPUS:8 nr_cpumask_bits:1 nr_cpu_ids:1 nr_node_ids:1
[    0.001000] percpu: Embedded 56 pages/cpu s190816 r8192 d30368 u2097152
[    0.001000] Fallback order for Node 0: 0 
[    0.001000] Built 1 zonelists, mobility grouping on.  Total pages: 31968
[    0.001000] Policy zone: DMA32
[    0.001000] Kernel command line: console=ttyS0,9600 i8042.noaux panic=-1 
[    0.001000] Dentry cache hash table entries: 16384 (order: 5, 131072 bytes, linear)
[    0.001000] Inode-cache hash table entries: 8192 (order: 4, 65536 bytes, linear)
[    0.001000] mem auto-init: stack:off, heap alloc:off, heap free:off
[    0.001000] Memory: 75864K/130552K available (18432K kernel code, 2977K rwdata, 6428K rodata, 2792K init, 13268K bss, 54428K reserved, 0K cma-reserved)
[    0.001000] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=1, Nodes=1
[    0.001000] Running RCU self tests
[    0.001000] Running RCU synchronous self tests
[    0.001000] rcu: Hierarchical RCU implementation.
[    0.001000] rcu: 	CONFIG_RCU_FANOUT set to non-default value of 2.
[    0.001000] rcu: 	RCU lockdep checking is enabled.
[    0.001000] rcu: 	Build-time adjustment of leaf fanout to 2.
[    0.001000] rcu: 	RCU restricting CPUs from NR_CPUS=8 to nr_cpu_ids=1.
[    0.001000] 	Rude variant of Tasks RCU enabled.
[    0.001000] 	Tracing variant of Tasks RCU enabled.
[    0.001000] rcu: RCU calculated value of scheduler-enlistment delay is 100 jiffies.
[    0.001000] rcu: Adjusting geometry for rcu_fanout_leaf=2, nr_cpu_ids=1
[    0.001000] Running RCU synchronous self tests
[    0.001000] NR_IRQS: 4352, nr_irqs: 256, preallocated irqs: 16
[    0.001000] rcu: srcu_init: Setting srcu_struct sizes based on contention.
[    0.001000] Console: colour VGA+ 80x25
[    0.001000] printk: console [ttyS0] enabled
[    0.001000] Lock dependency validator: Copyright (c) 2006 Red Hat, Inc., Ingo Molnar
[    0.001000] ... MAX_LOCKDEP_SUBCLASSES:  8
[    0.001000] ... MAX_LOCK_DEPTH:          48
[    0.001000] ... MAX_LOCKDEP_KEYS:        8192
[    0.001000] ... CLASSHASH_SIZE:          4096
[    0.001000] ... MAX_LOCKDEP_ENTRIES:     32768
[    0.001000] ... MAX_LOCKDEP_CHAINS:      65536
[    0.001000] ... CHAINHASH_SIZE:          32768
[    0.001000]  memory used by lock dependency info: 6365 kB
[    0.001000]  memory used for stack traces: 4224 kB
[    0.001000]  per task-struct memory footprint: 1920 bytes
[    0.001000] ACPI: Core revision 20221020
[    0.001000] clocksource: hpet: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 19112604467 ns
[    0.001000] APIC: Switch to symmetric I/O mode setup
[    0.001000] ..TIMER: vector=0x30 apic1=0 pin1=2 apic2=-1 pin2=-1
[    0.001000] clocksource: tsc-early: mask: 0xffffffffffffffff max_cycles: 0x1fd3a64d4e5, max_idle_ns: 440795274941 ns
[    0.146738] Calibrating delay loop (skipped), value calculated using timer frequency.. 4415.96 BogoMIPS (lpj=2207981)
[    0.147134] pid_max: default: 32768 minimum: 301
[    0.148394] LSM: initializing lsm=capability,integrity,selinux
[    0.148821] SELinux:  Initializing.
[    0.150918] Mount-cache hash table entries: 512 (order: 0, 4096 bytes, linear)
[    0.151153] Mountpoint-cache hash table entries: 512 (order: 0, 4096 bytes, linear)
[    0.172265] process: using AMD E400 aware idle routine
[    0.172843] Last level iTLB entries: 4KB 512, 2MB 255, 4MB 127
[    0.173031] Last level dTLB entries: 4KB 512, 2MB 255, 4MB 127, 1GB 0
[    0.173426] Spectre V1 : Mitigation: usercopy/swapgs barriers and __user pointer sanitization
[    0.173668] Spectre V2 : Mitigation: Retpolines
[    0.173820] Spectre V2 : Spectre v2 / SpectreRSB mitigation: Filling RSB on context switch
[    0.174059] Spectre V2 : Spectre v2 / SpectreRSB : Filling RSB on VMEXIT
[    0.686790] Freeing SMP alternatives memory: 44K
[    0.688464] Running RCU synchronous self tests
[    0.688928] Running RCU synchronous self tests
[    0.806562] smpboot: CPU0: AMD QEMU Virtual CPU version 2.5+ (family: 0xf, model: 0x6b, stepping: 0x1)
[    0.817187] cblist_init_generic: Setting adjustable number of callback queues.
[    0.817606] cblist_init_generic: Setting shift to 0 and lim to 1.
[    0.818767] cblist_init_generic: Setting shift to 0 and lim to 1.
[    0.819777] Running RCU-tasks wait API self tests
[    0.825743] Performance Events: PMU not available due to virtualization, using software events only.
[    0.828637] rcu: Hierarchical SRCU implementation.
[    0.828822] rcu: 	Max phase no-delay instances is 400.
[    0.837766] smp: Bringing up secondary CPUs ...
[    0.838008] smp: Brought up 1 node, 1 CPU
[    0.838170] smpboot: Max logical packages: 1
[    0.838378] smpboot: Total of 1 processors activated (4415.96 BogoMIPS)
[    0.854003] devtmpfs: initialized
[    0.866946] Running RCU synchronous self tests
[    0.867309] Running RCU synchronous self tests
[    0.868274] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 1911260446275000 ns
[    0.868769] futex hash table entries: 256 (order: 3, 32768 bytes, linear)
[    0.873260] PM: RTC time: 15:28:38, date: 2023-03-26
[    0.879389] NET: Registered PF_NETLINK/PF_ROUTE protocol family
[    0.886633] audit: initializing netlink subsys (disabled)
[    0.894116] thermal_sys: Registered thermal governor 'step_wise'
[    0.894176] thermal_sys: Registered thermal governor 'user_space'
[    0.895481] audit: type=2000 audit(1679844517.755:1): state=initialized audit_enabled=0 res=1
[    0.896156] cpuidle: using governor menu
[    0.901063] PCI: Using configuration type 1 for base access
[    0.905238] kprobes: kprobe jump-optimization is enabled. All kprobes are optimized if possible.
[    1.241018] Callback from call_rcu_tasks_rude() invoked.
[    1.241380] Callback from call_rcu_tasks_trace() invoked.
[    1.244668] HugeTLB: registered 2.00 MiB page size, pre-allocated 0 pages
[    1.244901] HugeTLB: 28 KiB vmemmap can be freed for a 2.00 MiB page
[    1.254887] ACPI: Added _OSI(Module Device)
[    1.255063] ACPI: Added _OSI(Processor Device)
[    1.255210] ACPI: Added _OSI(3.0 _SCP Extensions)
[    1.255358] ACPI: Added _OSI(Processor Aggregator Device)
[    1.283222] ACPI: 1 ACPI AML tables successfully acquired and loaded
[    1.308267] ACPI: Interpreter enabled
[    1.309858] ACPI: PM: (supports S0 S3 S4 S5)
[    1.310078] ACPI: Using IOAPIC for interrupt routing
[    1.310813] PCI: Using host bridge windows from ACPI; if necessary, use "pci=nocrs" and report a bug
[    1.311093] PCI: Using E820 reservations for host bridge windows
[    1.314212] ACPI: Enabled 2 GPEs in block 00 to 0F
[    1.407939] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-ff])
[    1.408854] acpi PNP0A03:00: _OSC: OS supports [ASPM ClockPM Segments MSI HPX-Type3]
[    1.409251] acpi PNP0A03:00: _OSC: not requesting OS control; OS requires [ExtendedConfig ASPM ClockPM MSI]
[    1.410482] acpi PNP0A03:00: fail to add MMCONFIG information, can't access extended configuration space under this bridge
[    1.418607] PCI host bridge to bus 0000:00
[    1.418883] pci_bus 0000:00: root bus resource [io  0x0000-0x0cf7 window]
[    1.419183] pci_bus 0000:00: root bus resource [io  0x0d00-0xffff window]
[    1.419385] pci_bus 0000:00: root bus resource [mem 0x000a0000-0x000bffff window]
[    1.419602] pci_bus 0000:00: root bus resource [mem 0x08000000-0xfebfffff window]
[    1.419867] pci_bus 0000:00: root bus resource [mem 0x100000000-0x17fffffff window]
[    1.420222] pci_bus 0000:00: root bus resource [bus 00-ff]
[    1.422369] pci 0000:00:00.0: [8086:1237] type 00 class 0x060000
[    1.437601] pci 0000:00:01.0: [8086:7000] type 00 class 0x060100
[    1.440154] pci 0000:00:01.1: [8086:7010] type 00 class 0x010180
[    1.442740] pci 0000:00:01.1: reg 0x20: [io  0xc040-0xc04f]
[    1.443611] pci 0000:00:01.1: legacy IDE quirk: reg 0x10: [io  0x01f0-0x01f7]
[    1.443859] pci 0000:00:01.1: legacy IDE quirk: reg 0x14: [io  0x03f6]
[    1.444079] pci 0000:00:01.1: legacy IDE quirk: reg 0x18: [io  0x0170-0x0177]
[    1.444302] pci 0000:00:01.1: legacy IDE quirk: reg 0x1c: [io  0x0376]
[    1.445955] pci 0000:00:01.3: [8086:7113] type 00 class 0x068000
[    1.446731] pci 0000:00:01.3: quirk: [io  0x0600-0x063f] claimed by PIIX4 ACPI
[    1.446982] pci 0000:00:01.3: quirk: [io  0x0700-0x070f] claimed by PIIX4 SMB
[    1.448309] pci 0000:00:02.0: [1234:1111] type 00 class 0x030000
[    1.448562] pci 0000:00:02.0: reg 0x10: [mem 0xfd000000-0xfdffffff pref]
[    1.450562] pci 0000:00:02.0: reg 0x18: [mem 0xfebb0000-0xfebb0fff]
[    1.451562] pci 0000:00:02.0: reg 0x30: [mem 0xfeba0000-0xfebaffff pref]
[    1.452839] pci 0000:00:02.0: Video device with shadowed ROM at [mem 0x000c0000-0x000dffff]
[    1.463489] pci 0000:00:03.0: [8086:100e] type 00 class 0x020000
[    1.464023] pci 0000:00:03.0: reg 0x10: [mem 0xfeb80000-0xfeb9ffff]
[    1.464562] pci 0000:00:03.0: reg 0x14: [io  0xc000-0xc03f]
[    1.465562] pci 0000:00:03.0: reg 0x30: [mem 0xfeb00000-0xfeb7ffff pref]
[    1.487696] ACPI: PCI: Interrupt link LNKA configured for IRQ 10
[    1.489532] ACPI: PCI: Interrupt link LNKB configured for IRQ 10
[    1.491150] ACPI: PCI: Interrupt link LNKC configured for IRQ 11
[    1.492819] ACPI: PCI: Interrupt link LNKD configured for IRQ 11
[    1.493667] ACPI: PCI: Interrupt link LNKS configured for IRQ 9
[    1.498203] iommu: Default domain type: Translated 
[    1.498395] iommu: DMA domain TLB invalidation policy: lazy mode 
[    1.503059] SCSI subsystem initialized
[    1.505875] ACPI: bus type USB registered
[    1.506611] usbcore: registered new interface driver usbfs
[    1.507184] usbcore: registered new interface driver hub
[    1.507646] usbcore: registered new device driver usb
[    1.508416] pps_core: LinuxPPS API ver. 1 registered
[    1.508601] pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolfo Giometti <giometti@linux.it>
[    1.508960] PTP clock support registered
[    1.512078] Advanced Linux Sound Architecture Driver Initialized.
[    1.524434] NetLabel: Initializing
[    1.524603] NetLabel:  domain hash size = 128
[    1.524749] NetLabel:  protocols = UNLABELED CIPSOv4 CALIPSO
[    1.526109] NetLabel:  unlabeled traffic allowed by default
[    1.531329] PCI: Using ACPI for IRQ routing
[    1.533946] pci 0000:00:02.0: vgaarb: setting as boot VGA device
[    1.534212] pci 0000:00:02.0: vgaarb: bridge control possible
[    1.534423] pci 0000:00:02.0: vgaarb: VGA device added: decodes=io+mem,owns=io+mem,locks=none
[    1.534624] vgaarb: loaded
[    1.536034] hpet: 3 channels of 0 reserved for per-cpu timers
[    1.536420] hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0
[    1.536788] hpet0: 3 comparators, 64-bit 100.000000 MHz counter
[    1.542407] clocksource: Switched to clocksource tsc-early
[    1.548256] VFS: Disk quotas dquot_6.6.0
[    1.548698] VFS: Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
[    1.551760] pnp: PnP ACPI init
[    1.561989] pnp: PnP ACPI: found 6 devices
[    2.269748] clocksource: acpi_pm: mask: 0xffffff max_cycles: 0xffffff, max_idle_ns: 2085701024 ns
[    2.270816] NET: Registered PF_INET protocol family
[    2.272242] IP idents hash table entries: 2048 (order: 2, 16384 bytes, linear)
[    2.279401] tcp_listen_portaddr_hash hash table entries: 64 (order: 0, 4608 bytes, linear)
[    2.279901] Table-perturb hash table entries: 65536 (order: 6, 262144 bytes, linear)
[    2.280187] TCP established hash table entries: 1024 (order: 1, 8192 bytes, linear)
[    2.280701] TCP bind hash table entries: 1024 (order: 5, 147456 bytes, linear)
[    2.281383] TCP: Hash tables configured (established 1024 bind 1024)
[    2.282700] UDP hash table entries: 256 (order: 3, 40960 bytes, linear)
[    2.283232] UDP-Lite hash table entries: 256 (order: 3, 40960 bytes, linear)
[    2.285213] NET: Registered PF_UNIX/PF_LOCAL protocol family
[    2.291052] RPC: Registered named UNIX socket transport module.
[    2.291333] RPC: Registered udp transport module.
[    2.291533] RPC: Registered tcp transport module.
[    2.291761] RPC: Registered tcp NFSv4.1 backchannel transport module.
[    2.296031] pci_bus 0000:00: resource 4 [io  0x0000-0x0cf7 window]
[    2.296242] pci_bus 0000:00: resource 5 [io  0x0d00-0xffff window]
[    2.296424] pci_bus 0000:00: resource 6 [mem 0x000a0000-0x000bffff window]
[    2.296682] pci_bus 0000:00: resource 7 [mem 0x08000000-0xfebfffff window]
[    2.296930] pci_bus 0000:00: resource 8 [mem 0x100000000-0x17fffffff window]
[    2.298338] pci 0000:00:01.0: PIIX3: Enabling Passive Release
[    2.298610] pci 0000:00:00.0: Limiting direct PCI/PCI transfers
[    2.299024] PCI: CLS 0 bytes, default 64
[    2.321183] rcu-torture:--- Start of test: nreaders=1 nfakewriters=4 stat_interval=60 verbose=1 test_no_idle_hz=1 shuffle_interval=3 stutter=5 irqreader=1 fqs_duration=0 fqs_holdoff=0 fqs_stutter=3 test_boost=1/0 test_boost_interval=7 test_boost_duration=4 shutdown_secs=0 stall_cpu=0 stall_cpu_holdoff=10 stall_cpu_irqsoff=0 stall_cpu_block=0 n_barrier_cbs=0 onoff_interval=0 onoff_holdoff=0 read_exit_delay=13 read_exit_burst=16 nocbs_nthreads=0 nocbs_toggle=1000
[    2.322398] rcu:  Start-test grace-period state: g-1172 f0x0
[    2.322945] rcu_torture_write_types: Testing conditional GPs.
[    2.323157] rcu_torture_write_types: Testing conditional expedited GPs.
[    2.323377] rcu_torture_write_types: Testing conditional full-state GPs.
[    2.323741] rcu_torture_write_types: Testing expedited GPs.
[    2.323939] rcu_torture_write_types: Testing asynchronous GPs.
[    2.324145] rcu_torture_write_types: Testing polling GPs.
[    2.324341] rcu_torture_write_types: Testing polling full-state GPs.
[    2.324550] rcu_torture_write_types: Testing polling expedited GPs.
[    2.324827] rcu_torture_write_types: Testing polling full-state expedited GPs.
[    2.325053] rcu_torture_write_types: Testing normal GPs.
[    2.325253] rcu-torture: Creating rcu_torture_writer task
[    2.328212] rcu-torture: Creating rcu_torture_fakewriter task
[    2.328502] rcu-torture: rcu_torture_writer task started
[    2.328926] rcu-torture: GP expediting controlled from boot/sysfs for rcu.
[    2.331096] rcu-torture: Creating rcu_torture_fakewriter task
[    2.332919] rcu-torture: rcu_torture_fakewriter task started
[    2.333386] rcu-torture: Creating rcu_torture_fakewriter task
[    2.334991] rcu-torture: rcu_torture_fakewriter task started
[    2.335311] rcu-torture: Creating rcu_torture_fakewriter task
[    2.337010] rcu-torture: rcu_torture_fakewriter task started
[    2.337385] rcu-torture: Creating rcu_torture_reader task
[    2.337934] rcu-torture: rcu_torture_fakewriter task started
[    2.338320] rcu-torture: Creating rcu_torture_stats task
[    2.338891] rcu-torture: rcu_torture_reader task started
[    2.340337] rcu-torture: Creating torture_shuffle task
[    2.341425] rcu-torture: rcu_torture_stats task started
[    2.341937] rcu-torture: Creating torture_stutter task
[    2.342506] rcu-torture: torture_shuffle task started
[    2.343185] rcu-torture: rcu_torture_fwd_prog_init: Limiting fwd_progress to # CPUs.
[    2.343185] 
[    2.343917] rcu-torture: Creating rcu_torture_fwd_prog task
[    2.345475] rcu-torture: torture_stutter task started
[    2.346718] rcu-torture: Creating rcu_torture_read_exit task
[    2.347724] rcu-torture: rcu_torture_fwd_progress task started
[    2.355171] Initialise system trusted keyrings
[    2.359078] rcu-torture: rcu_torture_read_exit: Start of test
[    2.359282] rcu-torture: rcu_torture_read_exit: Start of episode
[    2.360726] workingset: timestamp_bits=56 max_order=15 bucket_order=0
[    2.367569] NFS: Registering the id_resolver key type
[    2.368212] Key type id_resolver registered
[    2.368429] Key type id_legacy registered
[    2.370090] 9p: Installing v9fs 9p2000 file system support
[    2.404110] Key type asymmetric registered
[    2.404377] Asymmetric key parser 'x509' registered
[    2.405019] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 251)
[    2.406008] io scheduler mq-deadline registered
[    2.406210] io scheduler kyber registered
[    2.411662] input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/input/input0
[    2.417449] ACPI: button: Power Button [PWRF]
[    2.423635] Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
[    2.426279] 00:04: ttyS0 at I/O 0x3f8 (irq = 4, base_baud = 115200) is a 16550A
[    2.440278] Non-volatile memory driver v1.3
[    2.440493] Linux agpgart interface v0.103
[    2.443718] ACPI: bus type drm_connector registered
[    2.499946] loop: module loaded
[    2.516864] scsi host0: ata_piix
[    2.521596] scsi host1: ata_piix
[    2.523095] ata1: PATA max MWDMA2 cmd 0x1f0 ctl 0x3f6 bmdma 0xc040 irq 14
[    2.523342] ata2: PATA max MWDMA2 cmd 0x170 ctl 0x376 bmdma 0xc048 irq 15
[    2.531385] e100: Intel(R) PRO/100 Network Driver
[    2.531678] e100: Copyright(c) 1999-2006 Intel Corporation
[    2.532062] e1000: Intel(R) PRO/1000 Network Driver
[    2.532223] e1000: Copyright (c) 1999-2006 Intel Corporation.
[    3.830465] ACPI: \_SB_.LNKC: Enabled at IRQ 11
[    3.833960] tsc: Refined TSC clocksource calibration: 2207.984 MHz
[    3.834410] clocksource: tsc: mask: 0xffffffffffffffff max_cycles: 0x1fd3a905b47, max_idle_ns: 440795263197 ns
[    3.838429] clocksource: Switched to clocksource tsc
[    3.997209] ata2: found unknown device (class 0)
[    4.003528] ata2.00: ATAPI: QEMU DVD-ROM, 2.5+, max UDMA/100
[    4.019569] scsi 1:0:0:0: CD-ROM            QEMU     QEMU DVD-ROM     2.5+ PQ: 0 ANSI: 5
[    4.064123] sr 1:0:0:0: [sr0] scsi3-mmc drive: 4x/4x cd/rw xa/form2 tray
[    4.064752] cdrom: Uniform CD-ROM driver Revision: 3.20
[    4.095925] sr 1:0:0:0: Attached scsi generic sg0 type 5
[    4.187417] e1000 0000:00:03.0 eth0: (PCI:33MHz:32-bit) 52:54:00:12:34:56
[    4.188196] e1000 0000:00:03.0 eth0: Intel(R) PRO/1000 Network Connection
[    4.188831] e1000e: Intel(R) PRO/1000 Network Driver
[    4.189000] e1000e: Copyright(c) 1999 - 2015 Intel Corporation.
[    4.189394] sky2: driver version 1.30
[    4.194506] usbcore: registered new interface driver usblp
[    4.195016] usbcore: registered new interface driver usb-storage
[    4.196296] i8042: PNP: PS/2 Controller [PNP0303:KBD,PNP0f13:MOU] at 0x60,0x64 irq 1,12
[    4.198020] serio: i8042 KBD port at 0x60,0x64 irq 1
[    4.203974] rtc_cmos 00:05: RTC can wake from S4
[    4.211119] input: AT Translated Set 2 keyboard as /devices/platform/i8042/serio0/input/input1
[    4.218523] rtc_cmos 00:05: registered as rtc0
[    4.219963] rtc_cmos 00:05: alarms up to one day, y3k, 242 bytes nvram, hpet irqs
[    4.220886] fail to initialize ptp_kvm
[    4.223274] device-mapper: ioctl: 4.47.0-ioctl (2022-07-28) initialised: dm-devel@redhat.com
[    4.224732] hid: raw HID events driver (C) Jiri Kosina
[    4.229681] usbcore: registered new interface driver usbhid
[    4.229880] usbhid: USB HID core driver
[    4.243286] Initializing XFRM netlink socket
[    4.244190] NET: Registered PF_INET6 protocol family
[    4.254249] Segment Routing with IPv6
[    4.254598] In-situ OAM (IOAM) with IPv6
[    4.256312] sit: IPv6, IPv4 and MPLS over IPv4 tunneling driver
[    4.260984] NET: Registered PF_PACKET protocol family
[    4.262487] 9pnet: Installing 9P2000 support
[    4.263135] Key type dns_resolver registered
[    4.267002] IPI shorthand broadcast: enabled
[    4.388177] sched_clock: Marking stable (4256047247, 131562798)->(4391189803, -3579758)
[    4.392927] registered taskstats version 1
[    4.393112] Loading compiled-in X.509 certificates
[    4.463908] PM:   Magic number: 15:452:488
[    4.465083] printk: console [netcon0] enabled
[    4.465284] netconsole: network logging started
[    4.469776] cfg80211: Loading compiled-in X.509 certificates for regulatory database
[    4.490696] kworker/u2:1 (56) used greatest stack depth: 14232 bytes left
[    4.504141] Loaded X.509 cert 'sforshee: 00b28ddf47aef9cea7'
[    4.505452] ALSA device list:
[    4.505765]   No soundcards found.
[    4.510134] platform regulatory.0: Direct firmware load for regulatory.db failed with error -2
[    4.510892] cfg80211: failed to load regulatory.db
[    4.512219] Warning: unable to open an initial console.
[    4.557267] Freeing unused kernel image (initmem) memory: 2792K
[    4.559195] Write protecting the kernel read-only data: 26624k
[    4.565475] Freeing unused kernel image (rodata/data gap) memory: 1764K
[    4.732757] x86/mm: Checked W+X mappings: passed, no W+X pages found.
[    4.733345] Run /init as init process
[    4.759675] BUG: unable to handle page fault for address: 000000000001d5db
[    4.760006] #PF: supervisor read access in kernel mode
[    4.760164] #PF: error_code(0x0000) - not-present page
[    4.760361] PGD 2998067 P4D 2998067 PUD 29a5067 PMD 0 
[    4.760694] Oops: 0000 [#1] SMP NOPTI
[    4.760917] CPU: 0 PID: 1 Comm: init Not tainted 6.3.0-rc1-00022-gd6bb807e5889 #3
[    4.761194] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
[    4.761499] RIP: 0010:__lock_acquire+0x5b5/0x2700
[    4.761869] Code: 00 83 f8 2f 0f 87 40 07 00 00 3b 05 e9 d8 6e 02 41 bf 01 00 00 00 0f 86 f5 00 00 00 89 05 d7 d8 6e 02 e9 ea 00 00 00 45 31 f6 <48> 81 3f a0 c8 5e 85 45 0f 45 f0 83 fe 01 0f 87 96 fa ff ff 89 f0
[    4.762391] RSP: 0018:ffffa0f4c0013c50 EFLAGS: 00000046
[    4.762567] RAX: 0000000000000000 RBX: 0000000000000001 RCX: 0000000000000000
[    4.762765] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 000000000001d5db
[    4.762959] RBP: ffff9d9341140000 R08: 0000000000000001 R09: 0000000000000001
[    4.763153] R10: 0000000000000001 R11: 0000000000000001 R12: 0000000000000000
[    4.763346] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
[    4.763578] FS:  0000000000000000(0000) GS:ffff9d9347a00000(0000) knlGS:0000000000000000
[    4.763804] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    4.763970] CR2: 000000000001d5db CR3: 00000000028da000 CR4: 00000000000006f0
[    4.764223] Call Trace:
[    4.764389]  <TASK>
[    4.764529]  ? lock_acquire+0xbf/0x310
[    4.764689]  lock_acquire+0xbf/0x310
[    4.764819]  ? add_timer_on+0x80/0x130
[    4.764939]  ? add_timer_on+0x78/0x130
[    4.765048]  ? lock_release+0xbe/0x2a0
[    4.765162]  _raw_spin_lock+0x2b/0x40
[    4.765275]  ? add_timer_on+0x80/0x130
[    4.765384]  add_timer_on+0x80/0x130
[    4.765495]  try_to_generate_entropy+0x250/0x270
[    4.765630]  ? find_held_lock+0x2b/0x80
[    4.765749]  ? __pfx_entropy_timer+0x10/0x10
[    4.765874]  ? 0xffffffff83000000
[    4.766068]  wait_for_random_bytes+0x49/0xe0
[    4.766198]  __x64_sys_getrandom+0x8e/0xc0
[    4.766320]  ? rcu_read_lock_sched_held+0x42/0x80
[    4.766459]  ? syscall_enter_from_user_mode+0x21/0x50
[    4.766600]  do_syscall_64+0x3f/0x90
[    4.766709]  entry_SYSCALL_64_after_hwframe+0x72/0xdc
[    4.766900] RIP: 0033:0x404531
[    4.767061] Code: 05 f4 2a 00 00 48 89 44 24 08 31 c0 e8 a0 ff ff ff f3 0f 1e fa b8 3e 01 00 00 48 8d 3d d8 2a 00 00 be 08 00 00 00 31 d2 0f 05 <48> 31 3d c8 2a 00 00 c3 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[    4.767531] RSP: 002b:00007ffd2466c488 EFLAGS: 00000246 ORIG_RAX: 000000000000013e
[    4.767746] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 0000000000404531
[    4.767932] RDX: 0000000000000000 RSI: 0000000000000008 RDI: 0000000000407000
[    4.768117] RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
[    4.768309] R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
[    4.768493] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
[    4.768716]  </TASK>
[    4.768824] Modules linked in:
[    4.769033] CR2: 000000000001d5db
[    4.769414] ---[ end trace 0000000000000000 ]---
[    4.769601] RIP: 0010:__lock_acquire+0x5b5/0x2700
[    4.769743] Code: 00 83 f8 2f 0f 87 40 07 00 00 3b 05 e9 d8 6e 02 41 bf 01 00 00 00 0f 86 f5 00 00 00 89 05 d7 d8 6e 02 e9 ea 00 00 00 45 31 f6 <48> 81 3f a0 c8 5e 85 45 0f 45 f0 83 fe 01 0f 87 96 fa ff ff 89 f0
[    4.770203] RSP: 0018:ffffa0f4c0013c50 EFLAGS: 00000046
[    4.770351] RAX: 0000000000000000 RBX: 0000000000000001 RCX: 0000000000000000
[    4.770536] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 000000000001d5db
[    4.770720] RBP: ffff9d9341140000 R08: 0000000000000001 R09: 0000000000000001
[    4.770904] R10: 0000000000000001 R11: 0000000000000001 R12: 0000000000000000
[    4.771086] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
[    4.771270] FS:  0000000000000000(0000) GS:ffff9d9347a00000(0000) knlGS:0000000000000000
[    4.771484] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    4.771636] CR2: 000000000001d5db CR3: 00000000028da000 CR4: 00000000000006f0
[    4.771880] note: init[1] exited with irqs disabled
[    4.772161] note: init[1] exited with preempt_count 2
[    4.772515] Kernel panic - not syncing: Attempted to kill init! exitcode=0x00000009
[    4.773007] Kernel Offset: 0x2000000 from 0xffffffff81000000 (relocation range: 0xffffffff80000000-0xffffffffbfffffff)
