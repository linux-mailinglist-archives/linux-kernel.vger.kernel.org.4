Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F28E6CCA05
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 20:30:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229697AbjC1SaH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 14:30:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbjC1SaF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 14:30:05 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA51419A4
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 11:29:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E5706B81E3A
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 18:29:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A73EDC433EF;
        Tue, 28 Mar 2023 18:29:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680028193;
        bh=ywuTKoY2lUeHWxMxX33qLbgzBbGAuf3UJbeHYH8U7bc=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=U9t01VdrYjXugb1zGP7E2OC0HFtnc4yNDcaipQsPG+jk4RGX2ozrTlTK3P4vEdwKY
         PEoWxI7efyTX84U1k24xOJef4ByFsV1lVaYktCF1D6RcNUqje42AWtzg5iK45zEvQi
         6XT/p5C/26l8S3UGqYELUfxxy96A1rFVLGVQhZcZN1US4h3Azpw3gHjpGCRh5C8aWi
         2sjmobfofV9xiB284IpeOBXvpP2t/dv7SuafsGsOUhXzTWdZkQcBRTVN+pzHFPL+kg
         zNN0zWvCpopQ3ewOeoFkAuUtOb7x4UbclzTc4qQzPTZPCoxW56Wx6QaQ3yjnfJFjbj
         DEPx+TCLs1M2A==
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 44C0E1540479; Tue, 28 Mar 2023 11:29:53 -0700 (PDT)
Date:   Tue, 28 Mar 2023 11:29:53 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Willy Tarreau <w@1wt.eu>
Cc:     linux@weissschuh.net, linux-kernel@vger.kernel.org,
        Alexey Dobriyan <adobriyan@gmail.com>
Subject: Re: [PATCH 0/1] tools/nolibc: tests: use volatile to force stack
 smashing
Message-ID: <d718db04-77b5-4358-9727-8196d4486f32@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20230328161845.9584-1-w@1wt.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230328161845.9584-1-w@1wt.eu>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 28, 2023 at 06:18:44PM +0200, Willy Tarreau wrote:
> Hello Paul,
> 
> as previously discussed after Alexey's report, Thomas updated his stack
> smashing code to use a volatile pointer instead of dropping compiler
> optimizations. It's both cleaner and safer this way.
> 
> I verified on all supported archs that it doesn't change the behavior
> and passes the test without issues, so I'm fine with it:
> 
>   125 test(s) passed.
> 
> It can be queued on top of the existing series either for the next merge
> or the one after at your convenience, as I know that you're running long
> and complete tests with your series, and I don't want to make you change
> your tests at the last minute. This one is not urgent at all, it's more
> of a maintenance improvement anyway.

I have queued this for the v6.5 merge window, thank you!  If urgency
does develop in the next couple of days, please let me know, and I will
see what I can do about moving it to the v6.4 pile.

I got this from "make run" (after merging with v6.3-rc3 as discussed
earlier):

	make[1]: Leaving directory '/home/git/linux-build'
	126 test(s) passed.

This differs from your results, so please see below for the run.out file.
(I see 126 instances of "[OK]".)

But this from "make run-user":

	  CC      nolibc-test
	124 test(s) passed

The output of "grep -v "\[OK]" run.out" is as follows:

	Running test 'syscall'
	18 chroot_root                                                  [SKIPPED]
	43 link_dir                                                     [SKIPPED]
	Errors during this test: 0

	Running test 'stdlib'
	Errors during this test: 0

	Running test 'protection'
	Errors during this test: 0

	Total number of errors: 0
	Exiting with status 0

I am guessing is that this is because I am too cowardly to run this
test with root privileges, but thought I should run it by you.

						Thanx, Paul

------------------------------------------------------------------------

[    0.000000] Linux version 6.3.0-rc3-00173-g9c9d64a040a4 (paulmck@paulmck-ThinkPad-P72) (gcc (Ubuntu 11.3.0-1ubuntu1~22.04) 11.3.0, GNU ld (GNU Binutils for Ubuntu) 2.38) #6 SMP Tue Mar 28 11:00:31 PDT 2023
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
[    0.000000] last_pfn = 0x7fe0 max_arch_pfn = 0x400000000
[    0.000000] x86/PAT: Configuration [0-7]: WB  WC  UC- UC  WB  WP  UC- WT  
[    0.000000] found SMP MP-table at [mem 0x000f5ba0-0x000f5baf]
[    0.000000] ACPI: Early table checksum verification disabled
[    0.000000] ACPI: RSDP 0x00000000000F59E0 000014 (v00 BOCHS )
[    0.000000] ACPI: RSDT 0x0000000007FE1905 000034 (v01 BOCHS  BXPC     00000001 BXPC 00000001)
[    0.000000] ACPI: FACP 0x0000000007FE17B9 000074 (v01 BOCHS  BXPC     00000001 BXPC 00000001)
[    0.000000] ACPI: DSDT 0x0000000007FE0040 001779 (v01 BOCHS  BXPC     00000001 BXPC 00000001)
[    0.000000] ACPI: FACS 0x0000000007FE0000 000040
[    0.000000] ACPI: APIC 0x0000000007FE182D 000078 (v01 BOCHS  BXPC     00000001 BXPC 00000001)
[    0.000000] ACPI: HPET 0x0000000007FE18A5 000038 (v01 BOCHS  BXPC     00000001 BXPC 00000001)
[    0.000000] ACPI: WAET 0x0000000007FE18DD 000028 (v01 BOCHS  BXPC     00000001 BXPC 00000001)
[    0.000000] ACPI: Reserving FACP table memory at [mem 0x7fe17b9-0x7fe182c]
[    0.000000] ACPI: Reserving DSDT table memory at [mem 0x7fe0040-0x7fe17b8]
[    0.000000] ACPI: Reserving FACS table memory at [mem 0x7fe0000-0x7fe003f]
[    0.000000] ACPI: Reserving APIC table memory at [mem 0x7fe182d-0x7fe18a4]
[    0.000000] ACPI: Reserving HPET table memory at [mem 0x7fe18a5-0x7fe18dc]
[    0.000000] ACPI: Reserving WAET table memory at [mem 0x7fe18dd-0x7fe1904]
[    0.000000] No NUMA configuration found
[    0.000000] Faking a node at [mem 0x0000000000000000-0x0000000007fdffff]
[    0.000000] NODE_DATA(0) allocated [mem 0x07fdc000-0x07fdffff]
[    0.000000] Zone ranges:
[    0.000000]   DMA      [mem 0x0000000000001000-0x0000000000ffffff]
[    0.000000]   DMA32    [mem 0x0000000001000000-0x0000000007fdffff]
[    0.000000]   Normal   empty
[    0.000000] Movable zone start for each node
[    0.000000] Early memory node ranges
[    0.000000]   node   0: [mem 0x0000000000001000-0x000000000009efff]
[    0.000000]   node   0: [mem 0x0000000000100000-0x0000000007fdffff]
[    0.000000] Initmem setup node 0 [mem 0x0000000000001000-0x0000000007fdffff]
[    0.000000] On node 0, zone DMA: 1 pages in unavailable ranges
[    0.000000] On node 0, zone DMA: 97 pages in unavailable ranges
[    0.000000] On node 0, zone DMA32: 32 pages in unavailable ranges
[    0.000000] ACPI: PM-Timer IO Port: 0x608
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0xff] dfl dfl lint[0x1])
[    0.000000] IOAPIC[0]: apic_id 0, version 32, address 0xfec00000, GSI 0-23
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 5 global_irq 5 high level)
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 10 global_irq 10 high level)
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 11 global_irq 11 high level)
[    0.000000] ACPI: Using ACPI (MADT) for SMP configuration information
[    0.000000] ACPI: HPET id: 0x8086a201 base: 0xfed00000
[    0.000000] smpboot: Allowing 1 CPUs, 0 hotplug CPUs
[    0.000000] PM: hibernation: Registered nosave memory: [mem 0x00000000-0x00000fff]
[    0.000000] PM: hibernation: Registered nosave memory: [mem 0x0009f000-0x0009ffff]
[    0.000000] PM: hibernation: Registered nosave memory: [mem 0x000a0000-0x000effff]
[    0.000000] PM: hibernation: Registered nosave memory: [mem 0x000f0000-0x000fffff]
[    0.000000] [mem 0x08000000-0xfffbffff] available for PCI devices
[    0.000000] Booting paravirtualized kernel on bare hardware
[    0.000000] clocksource: refined-jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 1910969940391419 ns
[    0.000000] setup_percpu: NR_CPUS:8 nr_cpumask_bits:1 nr_cpu_ids:1 nr_node_ids:1
[    0.000000] percpu: Embedded 57 pages/cpu s195936 r8192 d29344 u2097152
[    0.000000] Fallback order for Node 0: 0 
[    0.000000] Built 1 zonelists, mobility grouping on.  Total pages: 31968
[    0.000000] Policy zone: DMA32
[    0.000000] Kernel command line: console=ttyS0,9600 i8042.noaux panic=-1 
[    0.000000] Dentry cache hash table entries: 16384 (order: 5, 131072 bytes, linear)
[    0.000000] Inode-cache hash table entries: 8192 (order: 4, 65536 bytes, linear)
[    0.000000] mem auto-init: stack:off, heap alloc:off, heap free:off
[    0.000000] Memory: 75860K/130552K available (18432K kernel code, 2989K rwdata, 6428K rodata, 2776K init, 13252K bss, 54432K reserved, 0K cma-reserved)
[    0.000000] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=1, Nodes=1
[    0.000000] Running RCU self tests
[    0.000000] Running RCU synchronous self tests
[    0.000000] rcu: Hierarchical RCU implementation.
[    0.000000] rcu: 	CONFIG_RCU_FANOUT set to non-default value of 2.
[    0.000000] rcu: 	RCU lockdep checking is enabled.
[    0.000000] rcu: 	Build-time adjustment of leaf fanout to 2.
[    0.000000] rcu: 	RCU restricting CPUs from NR_CPUS=8 to nr_cpu_ids=1.
[    0.000000] 	Rude variant of Tasks RCU enabled.
[    0.000000] 	Tracing variant of Tasks RCU enabled.
[    0.000000] rcu: RCU calculated value of scheduler-enlistment delay is 100 jiffies.
[    0.000000] rcu: Adjusting geometry for rcu_fanout_leaf=2, nr_cpu_ids=1
[    0.000000] Running RCU synchronous self tests
[    0.000000] NR_IRQS: 4352, nr_irqs: 256, preallocated irqs: 16
[    0.000000] rcu: srcu_init: Setting srcu_struct sizes based on contention.
[    0.000000] Console: colour VGA+ 80x25
[    0.000000] printk: console [ttyS0] enabled
[    0.000000] Lock dependency validator: Copyright (c) 2006 Red Hat, Inc., Ingo Molnar
[    0.000000] ... MAX_LOCKDEP_SUBCLASSES:  8
[    0.000000] ... MAX_LOCK_DEPTH:          48
[    0.000000] ... MAX_LOCKDEP_KEYS:        8192
[    0.000000] ... CLASSHASH_SIZE:          4096
[    0.000000] ... MAX_LOCKDEP_ENTRIES:     32768
[    0.000000] ... MAX_LOCKDEP_CHAINS:      65536
[    0.000000] ... CHAINHASH_SIZE:          32768
[    0.000000]  memory used by lock dependency info: 6365 kB
[    0.000000]  memory used for stack traces: 4224 kB
[    0.000000]  per task-struct memory footprint: 1920 bytes
[    0.000000] ACPI: Core revision 20221020
[    0.000000] clocksource: hpet: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 19112604467 ns
[    0.001000] APIC: Switch to symmetric I/O mode setup
[    0.001000] ..TIMER: vector=0x30 apic1=0 pin1=2 apic2=-1 pin2=-1
[    0.001000] tsc: Unable to calibrate against PIT
[    0.001000] tsc: using HPET reference calibration
[    0.001000] tsc: Detected 2205.917 MHz processor
[    0.001000] clocksource: tsc-early: mask: 0xffffffffffffffff max_cycles: 0x1fcc086e883, max_idle_ns: 440795286606 ns
[    0.001924] Calibrating delay loop (skipped), value calculated using timer frequency.. 4411.83 BogoMIPS (lpj=2205917)
[    0.002340] pid_max: default: 32768 minimum: 301
[    0.004553] LSM: initializing lsm=capability,integrity,selinux
[    0.005132] SELinux:  Initializing.
[    0.007208] Mount-cache hash table entries: 512 (order: 0, 4096 bytes, linear)
[    0.007443] Mountpoint-cache hash table entries: 512 (order: 0, 4096 bytes, linear)
[    0.028805] process: using AMD E400 aware idle routine
[    0.029317] Last level iTLB entries: 4KB 512, 2MB 255, 4MB 127
[    0.029506] Last level dTLB entries: 4KB 512, 2MB 255, 4MB 127, 1GB 0
[    0.029928] Spectre V1 : Mitigation: usercopy/swapgs barriers and __user pointer sanitization
[    0.030246] Spectre V2 : Mitigation: Retpolines
[    0.030397] Spectre V2 : Spectre v2 / SpectreRSB mitigation: Filling RSB on context switch
[    0.030698] Spectre V2 : Spectre v2 / SpectreRSB : Filling RSB on VMEXIT
[    0.541734] Freeing SMP alternatives memory: 44K
[    0.543259] Running RCU synchronous self tests
[    0.543538] Running RCU synchronous self tests
[    0.660657] smpboot: CPU0: AMD QEMU Virtual CPU version 2.5+ (family: 0xf, model: 0x6b, stepping: 0x1)
[    0.672171] RCU Tasks Rude: Setting shift to 0 and lim to 1 rcu_task_cb_adjust=1.
[    0.673162] RCU Tasks Trace: Setting shift to 0 and lim to 1 rcu_task_cb_adjust=1.
[    0.674124] Running RCU-tasks wait API self tests
[    0.678113] Performance Events: PMU not available due to virtualization, using software events only.
[    0.680370] Callback from call_rcu_tasks_trace() invoked.
[    0.681343] rcu: Hierarchical SRCU implementation.
[    0.681521] rcu: 	Max phase no-delay instances is 400.
[    0.689257] smp: Bringing up secondary CPUs ...
[    0.689490] smp: Brought up 1 node, 1 CPU
[    0.689647] smpboot: Max logical packages: 1
[    0.689884] smpboot: Total of 1 processors activated (4411.83 BogoMIPS)
[    0.704978] devtmpfs: initialized
[    0.715884] Running RCU synchronous self tests
[    0.716176] Running RCU synchronous self tests
[    0.717110] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 1911260446275000 ns
[    0.717602] futex hash table entries: 256 (order: 3, 32768 bytes, linear)
[    0.721872] PM: RTC time: 18:00:43, date: 2023-03-28
[    0.727880] NET: Registered PF_NETLINK/PF_ROUTE protocol family
[    0.733759] audit: initializing netlink subsys (disabled)
[    0.740683] thermal_sys: Registered thermal governor 'step_wise'
[    0.740740] thermal_sys: Registered thermal governor 'user_space'
[    0.741966] audit: type=2000 audit(1680026442.751:1): state=initialized audit_enabled=0 res=1
[    0.742742] cpuidle: using governor menu
[    0.746952] PCI: Using configuration type 1 for base access
[    0.750967] kprobes: kprobe jump-optimization is enabled. All kprobes are optimized if possible.
[    1.080964] Callback from call_rcu_tasks_rude() invoked.
[    1.083789] HugeTLB: registered 2.00 MiB page size, pre-allocated 0 pages
[    1.084018] HugeTLB: 28 KiB vmemmap can be freed for a 2.00 MiB page
[    1.092840] ACPI: Added _OSI(Module Device)
[    1.093017] ACPI: Added _OSI(Processor Device)
[    1.093156] ACPI: Added _OSI(3.0 _SCP Extensions)
[    1.093294] ACPI: Added _OSI(Processor Aggregator Device)
[    1.113347] ACPI: 1 ACPI AML tables successfully acquired and loaded
[    1.131883] ACPI: Interpreter enabled
[    1.133317] ACPI: PM: (supports S0 S3 S4 S5)
[    1.133536] ACPI: Using IOAPIC for interrupt routing
[    1.134131] PCI: Using host bridge windows from ACPI; if necessary, use "pci=nocrs" and report a bug
[    1.134406] PCI: Using E820 reservations for host bridge windows
[    1.136657] ACPI: Enabled 2 GPEs in block 00 to 0F
[    1.198054] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-ff])
[    1.199016] acpi PNP0A03:00: _OSC: OS supports [ASPM ClockPM Segments MSI HPX-Type3]
[    1.199429] acpi PNP0A03:00: _OSC: not requesting OS control; OS requires [ExtendedConfig ASPM ClockPM MSI]
[    1.200736] acpi PNP0A03:00: fail to add MMCONFIG information, can't access extended configuration space under this bridge
[    1.206413] PCI host bridge to bus 0000:00
[    1.206772] pci_bus 0000:00: root bus resource [io  0x0000-0x0cf7 window]
[    1.207071] pci_bus 0000:00: root bus resource [io  0x0d00-0xffff window]
[    1.207265] pci_bus 0000:00: root bus resource [mem 0x000a0000-0x000bffff window]
[    1.207529] pci_bus 0000:00: root bus resource [mem 0x08000000-0xfebfffff window]
[    1.207687] pci_bus 0000:00: root bus resource [mem 0x100000000-0x17fffffff window]
[    1.208081] pci_bus 0000:00: root bus resource [bus 00-ff]
[    1.210024] pci 0000:00:00.0: [8086:1237] type 00 class 0x060000
[    1.221367] pci 0000:00:01.0: [8086:7000] type 00 class 0x060100
[    1.223148] pci 0000:00:01.1: [8086:7010] type 00 class 0x010180
[    1.224196] pci 0000:00:01.1: reg 0x20: [io  0xc040-0xc04f]
[    1.225424] pci 0000:00:01.1: legacy IDE quirk: reg 0x10: [io  0x01f0-0x01f7]
[    1.225716] pci 0000:00:01.1: legacy IDE quirk: reg 0x14: [io  0x03f6]
[    1.225931] pci 0000:00:01.1: legacy IDE quirk: reg 0x18: [io  0x0170-0x0177]
[    1.226143] pci 0000:00:01.1: legacy IDE quirk: reg 0x1c: [io  0x0376]
[    1.227277] pci 0000:00:01.3: [8086:7113] type 00 class 0x068000
[    1.227888] pci 0000:00:01.3: quirk: [io  0x0600-0x063f] claimed by PIIX4 ACPI
[    1.228127] pci 0000:00:01.3: quirk: [io  0x0700-0x070f] claimed by PIIX4 SMB
[    1.229102] pci 0000:00:02.0: [1234:1111] type 00 class 0x030000
[    1.229657] pci 0000:00:02.0: reg 0x10: [mem 0xfd000000-0xfdffffff pref]
[    1.230657] pci 0000:00:02.0: reg 0x18: [mem 0xfebb0000-0xfebb0fff]
[    1.232657] pci 0000:00:02.0: reg 0x30: [mem 0xfeba0000-0xfebaffff pref]
[    1.233942] pci 0000:00:02.0: Video device with shadowed ROM at [mem 0x000c0000-0x000dffff]
[    1.241409] pci 0000:00:03.0: [8086:100e] type 00 class 0x020000
[    1.241697] pci 0000:00:03.0: reg 0x10: [mem 0xfeb80000-0xfeb9ffff]
[    1.242326] pci 0000:00:03.0: reg 0x14: [io  0xc000-0xc03f]
[    1.244521] pci 0000:00:03.0: reg 0x30: [mem 0xfeb00000-0xfeb7ffff pref]
[    1.258825] ACPI: PCI: Interrupt link LNKA configured for IRQ 10
[    1.260129] ACPI: PCI: Interrupt link LNKB configured for IRQ 10
[    1.261237] ACPI: PCI: Interrupt link LNKC configured for IRQ 11
[    1.262296] ACPI: PCI: Interrupt link LNKD configured for IRQ 11
[    1.262867] ACPI: PCI: Interrupt link LNKS configured for IRQ 9
[    1.267113] iommu: Default domain type: Translated 
[    1.267299] iommu: DMA domain TLB invalidation policy: lazy mode 
[    1.271767] SCSI subsystem initialized
[    1.274262] ACPI: bus type USB registered
[    1.274862] usbcore: registered new interface driver usbfs
[    1.275366] usbcore: registered new interface driver hub
[    1.275904] usbcore: registered new device driver usb
[    1.276567] pps_core: LinuxPPS API ver. 1 registered
[    1.276692] pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolfo Giometti <giometti@linux.it>
[    1.277090] PTP clock support registered
[    1.279819] Advanced Linux Sound Architecture Driver Initialized.
[    1.291065] NetLabel: Initializing
[    1.291198] NetLabel:  domain hash size = 128
[    1.291335] NetLabel:  protocols = UNLABELED CIPSOv4 CALIPSO
[    1.292791] NetLabel:  unlabeled traffic allowed by default
[    1.297847] PCI: Using ACPI for IRQ routing
[    1.300176] pci 0000:00:02.0: vgaarb: setting as boot VGA device
[    1.300437] pci 0000:00:02.0: vgaarb: bridge control possible
[    1.300652] pci 0000:00:02.0: vgaarb: VGA device added: decodes=io+mem,owns=io+mem,locks=none
[    1.300711] vgaarb: loaded
[    1.302173] hpet: 3 channels of 0 reserved for per-cpu timers
[    1.302564] hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0
[    1.302899] hpet0: 3 comparators, 64-bit 100.000000 MHz counter
[    1.308410] clocksource: Switched to clocksource tsc-early
[    1.313612] VFS: Disk quotas dquot_6.6.0
[    1.314010] VFS: Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
[    1.316702] pnp: PnP ACPI init
[    1.324096] pnp: PnP ACPI: found 6 devices
[    1.773718] clocksource: acpi_pm: mask: 0xffffff max_cycles: 0xffffff, max_idle_ns: 2085701024 ns
[    1.774775] NET: Registered PF_INET protocol family
[    1.776117] IP idents hash table entries: 2048 (order: 2, 16384 bytes, linear)
[    1.783192] tcp_listen_portaddr_hash hash table entries: 64 (order: 0, 4608 bytes, linear)
[    1.783539] Table-perturb hash table entries: 65536 (order: 6, 262144 bytes, linear)
[    1.783890] TCP established hash table entries: 1024 (order: 1, 8192 bytes, linear)
[    1.784319] TCP bind hash table entries: 1024 (order: 5, 147456 bytes, linear)
[    1.785095] TCP: Hash tables configured (established 1024 bind 1024)
[    1.786344] UDP hash table entries: 256 (order: 3, 40960 bytes, linear)
[    1.786926] UDP-Lite hash table entries: 256 (order: 3, 40960 bytes, linear)
[    1.788877] NET: Registered PF_UNIX/PF_LOCAL protocol family
[    1.795860] RPC: Registered named UNIX socket transport module.
[    1.796142] RPC: Registered udp transport module.
[    1.796295] RPC: Registered tcp transport module.
[    1.796438] RPC: Registered tcp NFSv4.1 backchannel transport module.
[    1.800283] pci_bus 0000:00: resource 4 [io  0x0000-0x0cf7 window]
[    1.800493] pci_bus 0000:00: resource 5 [io  0x0d00-0xffff window]
[    1.800776] pci_bus 0000:00: resource 6 [mem 0x000a0000-0x000bffff window]
[    1.800976] pci_bus 0000:00: resource 7 [mem 0x08000000-0xfebfffff window]
[    1.801167] pci_bus 0000:00: resource 8 [mem 0x100000000-0x17fffffff window]
[    1.802253] pci 0000:00:01.0: PIIX3: Enabling Passive Release
[    1.802514] pci 0000:00:00.0: Limiting direct PCI/PCI transfers
[    1.802908] PCI: CLS 0 bytes, default 64
[    1.824333] rcu-torture:--- Start of test: nreaders=1 nfakewriters=4 stat_interval=60 verbose=1 test_no_idle_hz=1 shuffle_interval=3 stutter=5 irqreader=1 fqs_duration=0 fqs_holdoff=0 fqs_stutter=3 test_boost=1/0 test_boost_interval=7 test_boost_duration=4 shutdown_secs=0 stall_cpu=0 stall_cpu_holdoff=10 stall_cpu_irqsoff=0 stall_cpu_block=0 n_barrier_cbs=0 onoff_interval=0 onoff_holdoff=0 read_exit_delay=13 read_exit_burst=16 nocbs_nthreads=0 nocbs_toggle=1000 test_nmis=0
[    1.825759] rcu:  Start-test grace-period state: g-1168 f0x0
[    1.826260] rcu_torture_write_types: Testing conditional GPs.
[    1.826467] rcu_torture_write_types: Testing conditional expedited GPs.
[    1.826685] rcu_torture_write_types: Testing conditional full-state GPs.
[    1.826982] rcu_torture_write_types: Testing expedited GPs.
[    1.827173] rcu_torture_write_types: Testing asynchronous GPs.
[    1.827373] rcu_torture_write_types: Testing polling GPs.
[    1.827563] rcu_torture_write_types: Testing polling full-state GPs.
[    1.827837] rcu_torture_write_types: Testing polling expedited GPs.
[    1.828042] rcu_torture_write_types: Testing polling full-state expedited GPs.
[    1.828260] rcu_torture_write_types: Testing normal GPs.
[    1.828455] rcu-torture: Creating rcu_torture_writer task
[    1.831338] rcu-torture: Creating rcu_torture_fakewriter task
[    1.832205] rcu-torture: rcu_torture_writer task started
[    1.832388] rcu-torture: GP expediting controlled from boot/sysfs for rcu.
[    1.833024] rcu-torture: Creating rcu_torture_fakewriter task
[    1.834786] rcu-torture: rcu_torture_fakewriter task started
[    1.835247] rcu-torture: Creating rcu_torture_fakewriter task
[    1.836522] rcu-torture: rcu_torture_fakewriter task started
[    1.836943] rcu-torture: Creating rcu_torture_fakewriter task
[    1.837353] rcu-torture: rcu_torture_fakewriter task started
[    1.837694] rcu-torture: Creating rcu_torture_reader task
[    1.838175] rcu-torture: rcu_torture_fakewriter task started
[    1.838501] rcu-torture: Creating rcu_torture_stats task
[    1.838982] rcu-torture: rcu_torture_reader task started
[    1.840195] rcu-torture: Creating torture_shuffle task
[    1.840692] rcu-torture: rcu_torture_stats task started
[    1.841399] rcu-torture: Creating torture_stutter task
[    1.841939] rcu-torture: torture_shuffle task started
[    1.842391] rcu-torture: rcu_torture_fwd_prog_init: Limiting fwd_progress to # CPUs.
[    1.842391] 
[    1.843025] rcu-torture: Creating rcu_torture_fwd_prog task
[    1.843891] rcu-torture: torture_stutter task started
[    1.844491] rcu-torture: Creating rcu_torture_read_exit task
[    1.845064] rcu-torture: rcu_torture_fwd_progress task started
[    1.850937] Initialise system trusted keyrings
[    1.853002] rcu-torture: rcu_torture_read_exit: Start of test
[    1.853206] rcu-torture: rcu_torture_read_exit: Start of episode
[    1.854047] workingset: timestamp_bits=56 max_order=15 bucket_order=0
[    1.859636] NFS: Registering the id_resolver key type
[    1.860312] Key type id_resolver registered
[    1.860530] Key type id_legacy registered
[    1.862220] 9p: Installing v9fs 9p2000 file system support
[    1.893469] Key type asymmetric registered
[    1.893787] Asymmetric key parser 'x509' registered
[    1.894328] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 251)
[    1.895289] io scheduler mq-deadline registered
[    1.895480] io scheduler kyber registered
[    1.900111] input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/input/input0
[    1.905797] ACPI: button: Power Button [PWRF]
[    1.910686] Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
[    1.913443] 00:04: ttyS0 at I/O 0x3f8 (irq = 4, base_baud = 115200) is a 16550A
[    1.924247] Non-volatile memory driver v1.3
[    1.924462] Linux agpgart interface v0.103
[    1.927111] ACPI: bus type drm_connector registered
[    1.969221] loop: module loaded
[    1.983412] scsi host0: ata_piix
[    1.987231] scsi host1: ata_piix
[    1.988341] ata1: PATA max MWDMA2 cmd 0x1f0 ctl 0x3f6 bmdma 0xc040 irq 14
[    1.988589] ata2: PATA max MWDMA2 cmd 0x170 ctl 0x376 bmdma 0xc048 irq 15
[    1.994574] e100: Intel(R) PRO/100 Network Driver
[    1.994797] e100: Copyright(c) 1999-2006 Intel Corporation
[    1.995119] e1000: Intel(R) PRO/1000 Network Driver
[    1.995272] e1000: Copyright (c) 1999-2006 Intel Corporation.
[    2.673908] ACPI: \_SB_.LNKC: Enabled at IRQ 11
[    2.835373] tsc: Refined TSC clocksource calibration: 2207.998 MHz
[    2.835907] clocksource: tsc: mask: 0xffffffffffffffff max_cycles: 0x1fd3b6211b4, max_idle_ns: 440795230313 ns
[    2.836967] ata2: found unknown device (class 0)
[    2.841216] clocksource: Switched to clocksource tsc
[    2.844170] ata2.00: ATAPI: QEMU DVD-ROM, 2.5+, max UDMA/100
[    2.859902] scsi 1:0:0:0: CD-ROM            QEMU     QEMU DVD-ROM     2.5+ PQ: 0 ANSI: 5
[    2.886037] sr 1:0:0:0: [sr0] scsi3-mmc drive: 4x/4x cd/rw xa/form2 tray
[    2.886533] cdrom: Uniform CD-ROM driver Revision: 3.20
[    2.917488] sr 1:0:0:0: Attached scsi generic sg0 type 5
[    3.017386] e1000 0000:00:03.0 eth0: (PCI:33MHz:32-bit) 52:54:00:12:34:56
[    3.018119] e1000 0000:00:03.0 eth0: Intel(R) PRO/1000 Network Connection
[    3.018585] e1000e: Intel(R) PRO/1000 Network Driver
[    3.018811] e1000e: Copyright(c) 1999 - 2015 Intel Corporation.
[    3.019145] sky2: driver version 1.30
[    3.023173] usbcore: registered new interface driver usblp
[    3.023539] usbcore: registered new interface driver usb-storage
[    3.024665] i8042: PNP: PS/2 Controller [PNP0303:KBD,PNP0f13:MOU] at 0x60,0x64 irq 1,12
[    3.026298] serio: i8042 KBD port at 0x60,0x64 irq 1
[    3.031255] rtc_cmos 00:05: RTC can wake from S4
[    3.037646] input: AT Translated Set 2 keyboard as /devices/platform/i8042/serio0/input/input1
[    3.044401] rtc_cmos 00:05: registered as rtc0
[    3.045623] rtc_cmos 00:05: alarms up to one day, y3k, 242 bytes nvram, hpet irqs
[    3.046429] fail to initialize ptp_kvm
[    3.048469] device-mapper: ioctl: 4.47.0-ioctl (2022-07-28) initialised: dm-devel@redhat.com
[    3.049738] hid: raw HID events driver (C) Jiri Kosina
[    3.053277] usbcore: registered new interface driver usbhid
[    3.053460] usbhid: USB HID core driver
[    3.065334] Initializing XFRM netlink socket
[    3.066154] NET: Registered PF_INET6 protocol family
[    3.075382] Segment Routing with IPv6
[    3.075709] In-situ OAM (IOAM) with IPv6
[    3.077214] sit: IPv6, IPv4 and MPLS over IPv4 tunneling driver
[    3.081086] NET: Registered PF_PACKET protocol family
[    3.082504] 9pnet: Installing 9P2000 support
[    3.083063] Key type dns_resolver registered
[    3.086230] IPI shorthand broadcast: enabled
[    3.173584] sched_clock: Marking stable (3189076316, -16342672)->(3178740114, -6006470)
[    3.177276] registered taskstats version 1
[    3.177452] Loading compiled-in X.509 certificates
[    3.222971] PM:   Magic number: 15:955:39
[    3.223253] bdi 7:4: hash matches
[    3.224418] printk: console [netcon0] enabled
[    3.224609] netconsole: network logging started
[    3.228639] cfg80211: Loading compiled-in X.509 certificates for regulatory database
[    3.248888] kworker/u2:1 (56) used greatest stack depth: 14256 bytes left
[    3.260968] Loaded X.509 cert 'sforshee: 00b28ddf47aef9cea7'
[    3.262207] ALSA device list:
[    3.262428]   No soundcards found.
[    3.266545] platform regulatory.0: Direct firmware load for regulatory.db failed with error -2
[    3.267268] cfg80211: failed to load regulatory.db
[    3.268490] Warning: unable to open an initial console.
[    3.310541] Freeing unused kernel image (initmem) memory: 2776K
[    3.312221] Write protecting the kernel read-only data: 26624k
[    3.317155] Freeing unused kernel image (rodata/data gap) memory: 1764K
[    3.523525] x86/mm: Checked W+X mappings: passed, no W+X pages found.
[    3.524000] Run /init as init process
[    3.793502] random: crng init done

Successfully reopened /dev/console.
Running test 'syscall'
0 getpid = 1                                                     [OK]
1 getppid = 0                                                    [OK]
3 gettid = 1                                                     [OK]
5 getpgid_self = 0                                               [OK]
6 getpgid_bad = -1 ESRCH                                         [OK]
7 kill_0 = 0                                                     [OK]
8 kill_CONT = 0                                                  [OK]
9 kill_BADPID = -1 ESRCH                                         [OK]
10 sbrk = 0                                                      [OK]
11 brk = 0                                                       [OK]
12 chdir_root = 0                                                [OK]
13 chdir_dot = 0                                                 [OK]
14 chdir_blah = -1 ENOENT                                        [OK]
15 chmod_net = 0                                                 [OK]
16 chmod_self = -1 EPERM                                         [OK]
17 chown_self = -1 EPERM                                         [OK]
18 chroot_root = 0                                               [OK]
19 chroot_blah = -1 ENOENT                                       [OK]
20 chroot_exe = -1 ENOTDIR                                       [OK]
21 close_m1 = -1 EBADF                                           [OK]
22 close_dup = 0                                                 [OK]
23 dup_0 = 3                                                     [OK]
24 dup_m1 = -1 EBADF                                             [OK]
25 dup2_0 = 100                                                  [OK]
26 dup2_m1 = -1 EBADF                                            [OK]
27 dup3_0 = 100                                                  [OK]
28 dup3_m1 = -1 EBADF                                            [OK]
29 execve_root = -1 EACCES                                       [OK]
30 getdents64_root = 120                                         [OK]
31 getdents64_null = -1 ENOTDIR                                  [OK]
32 gettimeofday_null = 0                                         [OK]
34 gettimeofday_bad1 = -1 EFAULT                                 [OK]
35 gettimeofday_bad2 = -1 EFAULT                                 [OK]
36 gettimeofday_bad2 = -1 EFAULT                                 [OK]
38 getpagesize = 0                                               [OK]
39 ioctl_tiocinq = 0                                             [OK]
40 ioctl_tiocinq = 0                                             [OK]
41 link_root1 = -1 EEXIST                                        [OK]
42 link_blah = -1 ENOENT                                         [OK]
43 link_dir = -1 EPERM                                           [OK]
44 link_cross = -1 EXDEV                                         [OK]
45 lseek_m1 = -1 EBADF                                           [OK]
46 lseek_0 = -1 ESPIPE                                           [OK]
47 mkdir_root = -1 EEXIST                                        [OK]
48 open_tty = 3                                                  [OK]
49 open_blah = -1 ENOENT                                         [OK]
50 poll_null = 0                                                 [OK]
51 poll_stdout = 1                                               [OK]
52 poll_fault = -1 EFAULT                                        [OK]
53 read_badf = -1 EBADF                                          [OK]
54 sched_yield = 0                                               [OK]
55 select_null = 0                                               [OK]
56 select_stdout = 1                                             [OK]
57 select_fault = -1 EFAULT                                      [OK]
58 stat_blah = -1 ENOENT                                         [OK]
59 stat_fault = -1 EFAULT                                        [OK]
60 symlink_root = -1 EEXIST                                      [OK]
61 unlink_root = -1 EISDIR                                       [OK]
62 unlink_blah = -1 ENOENT                                       [OK]
63 wait_child = -1 ECHILD                                        [OK]
64 waitpid_min = -1 ESRCH                                        [OK]
65 waitpid_child = -1 ECHILD                                     [OK]
66 write_badf = -1 EBADF                                         [OK]
67 write_zero = 0                                                [OK]
Errors during this test: 0

Running test 'stdlib'
0 getenv_TERM = <linux>                                          [OK]
1 getenv_blah = <(null)>                                         [OK]
2 setcmp_blah_blah = 0                                           [OK]
3 setcmp_blah_blah2 = -50                                        [OK]
4 setncmp_blah_blah = 0                                          [OK]
5 setncmp_blah_blah4 = 0                                         [OK]
6 setncmp_blah_blah5 = -53                                       [OK]
7 setncmp_blah_blah6 = -54                                       [OK]
8 strchr_foobar_o = <oobar>                                      [OK]
9 strchr_foobar_z = <(null)>                                     [OK]
10 strrchr_foobar_o = <obar>                                     [OK]
11 strrchr_foobar_z = <(null)>                                   [OK]
12 memcmp_20_20 = 0                                              [OK]
13 memcmp_20_60 = -64                                            [OK]
14 memcmp_60_20 = 64                                             [OK]
15 memcmp_20_e0 = -192                                           [OK]
16 memcmp_e0_20 = 192                                            [OK]
17 memcmp_80_e0 = -96                                            [OK]
18 memcmp_e0_80 = 96                                             [OK]
19 limit_int8_max = 127                                          [OK]
20 limit_int8_min = -128                                         [OK]
21 limit_uint8_max = 255                                         [OK]
22 limit_int16_max = 32767                                       [OK]
23 limit_int16_min = -32768                                      [OK]
24 limit_uint16_max = 65535                                      [OK]
25 limit_int32_max = 2147483647                                  [OK]
26 limit_int32_min = -2147483648                                 [OK]
27 limit_uint32_max = 4294967295                                 [OK]
28 limit_int64_max = 9223372036854775807                         [OK]
29 limit_int64_min = -9223372036854775808                        [OK]
30 limit_uint64_max = -1                                         [OK]
31 limit_int_least8_max = 127                                    [OK]
32 limit_int_least8_min = -128                                   [OK]
33 limit_uint_least8_max = 255                                   [OK]
34 limit_int_least16_max = 32767                                 [OK]
35 limit_int_least16_min = -32768                                [OK]
36 limit_uint_least16_max = 65535                                [OK]
37 limit_int_least32_max = 2147483647                            [OK]
38 limit_int_least32_min = -2147483648                           [OK]
39 limit_uint_least32_max = 4294967295                           [OK]
40 limit_int_least64_min = -9223372036854775808                  [OK]
41 limit_int_least64_max = 9223372036854775807                   [OK]
42 limit_uint_least64_max = -1                                   [OK]
43 limit_int_fast8_max = 127                                     [OK]
44 limit_int_fast8_min = -128                                    [OK]
45 limit_uint_fast8_max = 255                                    [OK]
46 limit_int_fast16_min = -9223372036854775808                   [OK]
47 limit_int_fast16_max = 9223372036854775807                    [OK]
48 limit_uint_fast16_max = -1                                    [OK]
49 limit_int_fast32_min = -9223372036854775808                   [OK]
50 limit_int_fast32_max = 9223372036854775807                    [OK]
51 limit_uint_fast32_max = -1                                    [OK]
52 limit_int_fast64_min = -9223372036854775808                   [OK]
53 limit_int_fast64_max = 9223372036854775807                    [OK]
54 limit_uint_fast64_max = -1                                    [OK]
56 limit_intptr_min = -9223372036854775808                       [OK]
57 limit_intptr_max = 9223372036854775807                        [OK]
58 limit_uintptr_max = -1                                        [OK]
59 limit_ptrdiff_min = -9223372036854775808                      [OK]
60 limit_ptrdiff_max = 9223372036854775807                       [OK]
61 limit_size_max = -1                                           [OK]
Errors during this test: 0

Running test 'protection'
0 -fstackprotector                                               [OK]
Errors during this test: 0

Total number of errors: 0
Leaving init with final status: 0
[    4.159544] rcu-torture: Unscheduled system shutdown detected
[    4.889246] ACPI: PM: Preparing to enter system sleep state S5
[    4.890593] reboot: Power down
