Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D3686643B8
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 15:54:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238779AbjAJOxq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 09:53:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238740AbjAJOxl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 09:53:41 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7D60E7A
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 06:53:38 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B429FB816C6
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 14:53:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 110BBC433EF;
        Tue, 10 Jan 2023 14:53:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673362415;
        bh=N6WKvJtfTxH74PHScrpVK+1a/MBYWtrLawkyqHLIKOY=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=fFLXI3ohZfNHMRs5tthSO13w9Q4C9GMb7BYgFmpGwBx+dHp4OT+PQRGke3ydszJT5
         78aDYrGuiAL6L4rF04Ag9kewV8IFNF4wcExIET6KcmlID4R7equIywjejjqkoOoztd
         Yit8pKp3pjWURKdm4fqXyZEyN8Cf+OMa5uMWRC5fMAavkrkmkSRDKudlKQVFeeC7fr
         NgsZqiR1bpUbISSIO5Tu2tc/rrJOycjavF87iK9L5piq9d9yKxDJo9G03YKKmaDylK
         d+QkeUnlf9aH9a7NnNUqfYdAGmN9EQ5iKQHm2svxP5Dc+xevn3rboGHRHcEAT8A+qd
         FuUdiGcJlQtRw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id B2DB65C0687; Tue, 10 Jan 2023 06:53:34 -0800 (PST)
Date:   Tue, 10 Jan 2023 06:53:34 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Willy Tarreau <w@1wt.eu>
Cc:     linux-kernel@vger.kernel.org, Sven Schnelle <svens@linux.ibm.com>
Subject: Re: [PATCH 0/4] nolibc: add support for the s390 platform
Message-ID: <20230110145334.GL4028633@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20230109080910.26594-1-w@1wt.eu>
 <20230109191534.GU4028633@paulmck-ThinkPad-P17-Gen-1>
 <20230110073242.GB3229@1wt.eu>
 <20230110092517.GA4626@1wt.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230110092517.GA4626@1wt.eu>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 10, 2023 at 10:25:17AM +0100, Willy Tarreau wrote:
> On Tue, Jan 10, 2023 at 08:32:42AM +0100, Willy Tarreau wrote:
> > On Mon, Jan 09, 2023 at 11:15:34AM -0800, Paul E. McKenney wrote:
> > > On Mon, Jan 09, 2023 at 09:09:06AM +0100, Willy Tarreau wrote:
> > > > Hello Paul,
> > > > 
> > > > this series adds support for the s390x platform to nolibc and rcutorture,
> > > > reducing the init size from ~600kB to ~1kB. The work was contributed by
> > > > Sven Schnelle. It depends on the fixes series I sent previously:
> > > > 
> > > >   https://lore.kernel.org/lkml/20230109075442.25963-1-w@1wt.eu/
> > > > 
> > > > It passes the self-tests correctly and the patches are clean, please
> > > > consider queuing it.
> > > 
> > > "80 test(s) passed" and successful exit code.  I will assume that the
> > > decrease in tests from 81 to 80 is intended.  I have these queued,
> > > but it may be some hours before they are externally visible.
> > 
> > Interesting, I didn't notice and I'm not observing this when running
> > qemu-s390x (the userland version), I'm currently rebuilding the kernel
> > to compare and will let you know. Thanks for checking!
> 
> So after a re-check, I'm constantly seeing 82 tests passed and a success
> here. I don't understand what's differing, and would be interested in a
> copy of your "run.out" in the "tools/testing/selftests/nolibc" subdir to
> compare with mine, as it's possible we have a bug somewhere in the way
> tests are run (or maybe we're still facing a mangled qemu output).
> 
> You can just send this to me privately, no need to spam the list, the
> file is moderately large and uninteresting.

Here is one of them, based on both the fixes and Sven's s390 support.
Please let me know if you need any other combination.

							Thanx, Paul

------------------------------------------------------------------------

[    0.000000] Linux version 6.2.0-rc1-00004-g28ef4c3753a4 (paulmck@paulmck-ThinkPad-P17-Gen-1) (gcc (Ubuntu 9.4.0-1ubuntu1~20.04.1) 9.4.0, GNU ld (GNU Binutils for Ubuntu) 2.34) #507 SMP PREEMPT_DYNAMIC Mon Jan  9 11:13:50 PST 2023
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
[    0.000000] DMI: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.13.0-1ubuntu1.1 04/01/2014
[    0.000000] tsc: Fast TSC calibration using PIT
[    0.000000] tsc: Detected 2399.974 MHz processor
[    0.005545] last_pfn = 0x7fe0 max_arch_pfn = 0x400000000
[    0.005918] x86/PAT: Configuration [0-7]: WB  WC  UC- UC  WB  WP  UC- WT  
[    0.013636] found SMP MP-table at [mem 0x000f5ca0-0x000f5caf]
[    0.017222] ACPI: Early table checksum verification disabled
[    0.017481] ACPI: RSDP 0x00000000000F5AE0 000014 (v00 BOCHS )
[    0.017672] ACPI: RSDT 0x0000000007FE156F 000030 (v01 BOCHS  BXPCRSDT 00000001 BXPC 00000001)
[    0.018126] ACPI: FACP 0x0000000007FE144B 000074 (v01 BOCHS  BXPCFACP 00000001 BXPC 00000001)
[    0.018486] ACPI: DSDT 0x0000000007FE0040 00140B (v01 BOCHS  BXPCDSDT 00000001 BXPC 00000001)
[    0.018542] ACPI: FACS 0x0000000007FE0000 000040
[    0.018586] ACPI: APIC 0x0000000007FE14BF 000078 (v01 BOCHS  BXPCAPIC 00000001 BXPC 00000001)
[    0.018607] ACPI: HPET 0x0000000007FE1537 000038 (v01 BOCHS  BXPCHPET 00000001 BXPC 00000001)
[    0.018663] ACPI: Reserving FACP table memory at [mem 0x7fe144b-0x7fe14be]
[    0.018689] ACPI: Reserving DSDT table memory at [mem 0x7fe0040-0x7fe144a]
[    0.018696] ACPI: Reserving FACS table memory at [mem 0x7fe0000-0x7fe003f]
[    0.018702] ACPI: Reserving APIC table memory at [mem 0x7fe14bf-0x7fe1536]
[    0.018706] ACPI: Reserving HPET table memory at [mem 0x7fe1537-0x7fe156e]
[    0.020152] No NUMA configuration found
[    0.020170] Faking a node at [mem 0x0000000000000000-0x0000000007fdffff]
[    0.020654] NODE_DATA(0) allocated [mem 0x07fbe000-0x07fdffff]
[    0.031075] Zone ranges:
[    0.031099]   DMA      [mem 0x0000000000001000-0x0000000000ffffff]
[    0.031156]   DMA32    [mem 0x0000000001000000-0x0000000007fdffff]
[    0.031167]   Normal   empty
[    0.031181] Movable zone start for each node
[    0.031214] Early memory node ranges
[    0.031233]   node   0: [mem 0x0000000000001000-0x000000000009efff]
[    0.031333]   node   0: [mem 0x0000000000100000-0x0000000007fdffff]
[    0.031514] Initmem setup node 0 [mem 0x0000000000001000-0x0000000007fdffff]
[    0.032202] On node 0, zone DMA: 1 pages in unavailable ranges
[    0.032397] On node 0, zone DMA: 97 pages in unavailable ranges
[    0.033035] On node 0, zone DMA32: 32 pages in unavailable ranges
[    0.033261] ACPI: PM-Timer IO Port: 0x608
[    0.033558] ACPI: LAPIC_NMI (acpi_id[0xff] dfl dfl lint[0x1])
[    0.033835] IOAPIC[0]: apic_id 0, version 32, address 0xfec00000, GSI 0-23
[    0.033931] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
[    0.034102] ACPI: INT_SRC_OVR (bus 0 bus_irq 5 global_irq 5 high level)
[    0.034127] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
[    0.034192] ACPI: INT_SRC_OVR (bus 0 bus_irq 10 global_irq 10 high level)
[    0.034200] ACPI: INT_SRC_OVR (bus 0 bus_irq 11 global_irq 11 high level)
[    0.034328] ACPI: Using ACPI (MADT) for SMP configuration information
[    0.034361] ACPI: HPET id: 0x8086a201 base: 0xfed00000
[    0.034672] smpboot: Allowing 1 CPUs, 0 hotplug CPUs
[    0.036556] PM: hibernation: Registered nosave memory: [mem 0x00000000-0x00000fff]
[    0.036638] PM: hibernation: Registered nosave memory: [mem 0x0009f000-0x0009ffff]
[    0.036658] PM: hibernation: Registered nosave memory: [mem 0x000a0000-0x000effff]
[    0.036666] PM: hibernation: Registered nosave memory: [mem 0x000f0000-0x000fffff]
[    0.036744] [mem 0x08000000-0xfffbffff] available for PCI devices
[    0.036766] Booting paravirtualized kernel on bare hardware
[    0.036979] clocksource: refined-jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 1910969940391419 ns
[    0.046793] setup_percpu: NR_CPUS:8192 nr_cpumask_bits:1 nr_cpu_ids:1 nr_node_ids:1
[    0.051984] percpu: Embedded 54 pages/cpu s182184 r8192 d30808 u2097152
[    0.055414] Fallback order for Node 0: 0 
[    0.055609] Built 1 zonelists, mobility grouping on.  Total pages: 31968
[    0.055623] Policy zone: DMA32
[    0.055757] Kernel command line: console=ttyS0,9600 i8042.noaux panic=-1 
[    0.069401] Dentry cache hash table entries: 16384 (order: 5, 131072 bytes, linear)
[    0.069589] Inode-cache hash table entries: 8192 (order: 4, 65536 bytes, linear)
[    0.071194] mem auto-init: stack:off, heap alloc:off, heap free:off
[    0.074249] Memory: 85988K/130552K available (18432K kernel code, 3058K rwdata, 6544K rodata, 3184K init, 2808K bss, 44304K reserved, 0K cma-reserved)
[    0.076748] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=1, Nodes=1
[    0.080961] Dynamic Preempt: full
[    0.083062] rcu: Preemptible hierarchical RCU implementation.
[    0.083073] rcu: 	RCU event tracing is enabled.
[    0.083090] rcu: 	RCU restricting CPUs from NR_CPUS=8192 to nr_cpu_ids=1.
[    0.083169] 	Trampoline variant of Tasks RCU enabled.
[    0.083248] rcu: RCU calculated value of scheduler-enlistment delay is 100 jiffies.
[    0.083275] rcu: Adjusting geometry for rcu_fanout_leaf=16, nr_cpu_ids=1
[    0.091846] NR_IRQS: 524544, nr_irqs: 256, preallocated irqs: 16
[    0.095422] rcu: srcu_init: Setting srcu_struct sizes based on contention.
[    0.099083] Console: colour VGA+ 80x25
[    0.100187] printk: console [ttyS0] enabled
[    0.110092] ACPI: Core revision 20221020
[    0.113425] clocksource: hpet: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 19112604467 ns
[    0.114744] APIC: Switch to symmetric I/O mode setup
[    0.119949] ..TIMER: vector=0x30 apic1=0 pin1=2 apic2=-1 pin2=-1
[    0.125417] clocksource: tsc-early: mask: 0xffffffffffffffff max_cycles: 0x22981eecce7, max_idle_ns: 440795204679 ns
[    0.125854] Calibrating delay loop (skipped), value calculated using timer frequency.. 4799.94 BogoMIPS (lpj=2399974)
[    0.126159] pid_max: default: 32768 minimum: 301
[    0.127410] LSM: initializing lsm=capability,integrity,selinux
[    0.127846] SELinux:  Initializing.
[    0.128962] Mount-cache hash table entries: 512 (order: 0, 4096 bytes, linear)
[    0.129106] Mountpoint-cache hash table entries: 512 (order: 0, 4096 bytes, linear)
[    0.141186] Last level iTLB entries: 4KB 0, 2MB 0, 4MB 0
[    0.141296] Last level dTLB entries: 4KB 0, 2MB 0, 4MB 0, 1GB 0
[    0.141547] Spectre V1 : Mitigation: usercopy/swapgs barriers and __user pointer sanitization
[    0.141788] Spectre V2 : Mitigation: Retpolines
[    0.141878] Spectre V2 : Spectre v2 / SpectreRSB mitigation: Filling RSB on context switch
[    0.142018] Spectre V2 : Spectre v2 / SpectreRSB : Filling RSB on VMEXIT
[    0.142163] Speculative Store Bypass: Vulnerable
[    0.462697] Freeing SMP alternatives memory: 44K
[    0.574573] smpboot: CPU0: AMD QEMU Virtual CPU version 2.5+ (family: 0x6, model: 0x6, stepping: 0x3)
[    0.580221] cblist_init_generic: Setting adjustable number of callback queues.
[    0.580527] cblist_init_generic: Setting shift to 0 and lim to 1.
[    0.581061] Performance Events: PMU not available due to virtualization, using software events only.
[    0.583037] rcu: Hierarchical SRCU implementation.
[    0.583182] rcu: 	Max phase no-delay instances is 400.
[    0.587826] smp: Bringing up secondary CPUs ...
[    0.588020] smp: Brought up 1 node, 1 CPU
[    0.588140] smpboot: Max logical packages: 1
[    0.588285] smpboot: Total of 1 processors activated (4799.94 BogoMIPS)
[    0.599828] devtmpfs: initialized
[    0.607143] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 1911260446275000 ns
[    0.607536] futex hash table entries: 256 (order: 2, 16384 bytes, linear)
[    0.610089] PM: RTC time: 19:14:04, date: 2023-01-09
[    0.613930] NET: Registered PF_NETLINK/PF_ROUTE protocol family
[    0.616773] audit: initializing netlink subsys (disabled)
[    0.621064] audit: type=2000 audit(1673291643.501:1): state=initialized audit_enabled=0 res=1
[    0.621884] thermal_sys: Registered thermal governor 'step_wise'
[    0.621926] thermal_sys: Registered thermal governor 'user_space'
[    0.624026] cpuidle: using governor menu
[    0.626960] PCI: Using configuration type 1 for base access
[    0.630079] kprobes: kprobe jump-optimization is enabled. All kprobes are optimized if possible.
[    0.639754] HugeTLB: registered 2.00 MiB page size, pre-allocated 0 pages
[    0.639906] HugeTLB: 28 KiB vmemmap can be freed for a 2.00 MiB page
[    0.645130] ACPI: Added _OSI(Module Device)
[    0.645244] ACPI: Added _OSI(Processor Device)
[    0.645334] ACPI: Added _OSI(3.0 _SCP Extensions)
[    0.645423] ACPI: Added _OSI(Processor Aggregator Device)
[    0.668195] ACPI: 1 ACPI AML tables successfully acquired and loaded
[    0.686965] ACPI: Interpreter enabled
[    0.691762] ACPI: PM: (supports S0 S3 S4 S5)
[    0.691870] ACPI: Using IOAPIC for interrupt routing
[    0.692219] PCI: Using host bridge windows from ACPI; if necessary, use "pci=nocrs" and report a bug
[    0.692379] PCI: Using E820 reservations for host bridge windows
[    0.693445] ACPI: Enabled 2 GPEs in block 00 to 0F
[    0.741103] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-ff])
[    0.741601] acpi PNP0A03:00: _OSC: OS supports [ASPM ClockPM Segments MSI HPX-Type3]
[    0.741865] acpi PNP0A03:00: _OSC: not requesting OS control; OS requires [ExtendedConfig ASPM ClockPM MSI]
[    0.742471] acpi PNP0A03:00: fail to add MMCONFIG information, can't access extended configuration space under this bridge
[    0.748895] PCI host bridge to bus 0000:00
[    0.749076] pci_bus 0000:00: root bus resource [io  0x0000-0x0cf7 window]
[    0.749220] pci_bus 0000:00: root bus resource [io  0x0d00-0xffff window]
[    0.749332] pci_bus 0000:00: root bus resource [mem 0x000a0000-0x000bffff window]
[    0.749461] pci_bus 0000:00: root bus resource [mem 0x08000000-0xfebfffff window]
[    0.749578] pci_bus 0000:00: root bus resource [mem 0x100000000-0x17fffffff window]
[    0.749775] pci_bus 0000:00: root bus resource [bus 00-ff]
[    0.750870] pci 0000:00:00.0: [8086:1237] type 00 class 0x060000
[    0.757546] pci 0000:00:01.0: [8086:7000] type 00 class 0x060100
[    0.758180] pci 0000:00:01.1: [8086:7010] type 00 class 0x010180
[    0.758824] pci 0000:00:01.1: reg 0x20: [io  0xc040-0xc04f]
[    0.764159] pci 0000:00:01.1: legacy IDE quirk: reg 0x10: [io  0x01f0-0x01f7]
[    0.764306] pci 0000:00:01.1: legacy IDE quirk: reg 0x14: [io  0x03f6]
[    0.764450] pci 0000:00:01.1: legacy IDE quirk: reg 0x18: [io  0x0170-0x0177]
[    0.764577] pci 0000:00:01.1: legacy IDE quirk: reg 0x1c: [io  0x0376]
[    0.765040] pci 0000:00:01.3: [8086:7113] type 00 class 0x068000
[    0.765379] pci 0000:00:01.3: quirk: [io  0x0600-0x063f] claimed by PIIX4 ACPI
[    0.765528] pci 0000:00:01.3: quirk: [io  0x0700-0x070f] claimed by PIIX4 SMB
[    0.766119] pci 0000:00:02.0: [1234:1111] type 00 class 0x030000
[    0.766631] pci 0000:00:02.0: reg 0x10: [mem 0xfd000000-0xfdffffff pref]
[    0.767547] pci 0000:00:02.0: reg 0x18: [mem 0xfebb0000-0xfebb0fff]
[    0.772678] pci 0000:00:02.0: reg 0x30: [mem 0xfeba0000-0xfebaffff pref]
[    0.772949] pci 0000:00:02.0: Video device with shadowed ROM at [mem 0x000c0000-0x000dffff]
[    0.773730] pci 0000:00:03.0: [8086:100e] type 00 class 0x020000
[    0.774170] pci 0000:00:03.0: reg 0x10: [mem 0xfeb80000-0xfeb9ffff]
[    0.774570] pci 0000:00:03.0: reg 0x14: [io  0xc000-0xc03f]
[    0.775678] pci 0000:00:03.0: reg 0x30: [mem 0xfeb00000-0xfeb7ffff pref]
[    0.783587] ACPI: PCI: Interrupt link LNKA configured for IRQ 10
[    0.788141] ACPI: PCI: Interrupt link LNKB configured for IRQ 10
[    0.788596] ACPI: PCI: Interrupt link LNKC configured for IRQ 11
[    0.789033] ACPI: PCI: Interrupt link LNKD configured for IRQ 11
[    0.789332] ACPI: PCI: Interrupt link LNKS configured for IRQ 9
[    0.791007] iommu: Default domain type: Translated 
[    0.791118] iommu: DMA domain TLB invalidation policy: lazy mode 
[    0.796107] SCSI subsystem initialized
[    0.800559] ACPI: bus type USB registered
[    0.800870] usbcore: registered new interface driver usbfs
[    0.801142] usbcore: registered new interface driver hub
[    0.801349] usbcore: registered new device driver usb
[    0.801728] pps_core: LinuxPPS API ver. 1 registered
[    0.801821] pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolfo Giometti <giometti@linux.it>
[    0.802011] PTP clock support registered
[    0.803344] Advanced Linux Sound Architecture Driver Initialized.
[    0.817233] NetLabel: Initializing
[    0.817311] NetLabel:  domain hash size = 128
[    0.817393] NetLabel:  protocols = UNLABELED CIPSOv4 CALIPSO
[    0.818113] NetLabel:  unlabeled traffic allowed by default
[    0.820562] PCI: Using ACPI for IRQ routing
[    0.821678] pci 0000:00:02.0: vgaarb: setting as boot VGA device
[    0.821678] pci 0000:00:02.0: vgaarb: bridge control possible
[    0.821678] pci 0000:00:02.0: vgaarb: VGA device added: decodes=io+mem,owns=io+mem,locks=none
[    0.821712] vgaarb: loaded
[    0.822907] hpet: 3 channels of 0 reserved for per-cpu timers
[    0.823177] hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0
[    0.823325] hpet0: 3 comparators, 64-bit 100.000000 MHz counter
[    0.836180] clocksource: Switched to clocksource tsc-early
[    0.837721] VFS: Disk quotas dquot_6.6.0
[    0.837910] VFS: Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
[    0.842260] pnp: PnP ACPI init
[    0.845685] pnp: PnP ACPI: found 6 devices
[    0.876172] clocksource: acpi_pm: mask: 0xffffff max_cycles: 0xffffff, max_idle_ns: 2085701024 ns
[    0.876641] NET: Registered PF_INET protocol family
[    0.881341] IP idents hash table entries: 2048 (order: 2, 16384 bytes, linear)
[    0.888402] tcp_listen_portaddr_hash hash table entries: 256 (order: 0, 4096 bytes, linear)
[    0.888588] Table-perturb hash table entries: 65536 (order: 6, 262144 bytes, linear)
[    0.888745] TCP established hash table entries: 1024 (order: 1, 8192 bytes, linear)
[    0.888975] TCP bind hash table entries: 1024 (order: 3, 32768 bytes, linear)
[    0.889201] TCP: Hash tables configured (established 1024 bind 1024)
[    0.889869] UDP hash table entries: 256 (order: 1, 8192 bytes, linear)
[    0.890121] UDP-Lite hash table entries: 256 (order: 1, 8192 bytes, linear)
[    0.891073] NET: Registered PF_UNIX/PF_LOCAL protocol family
[    0.899947] RPC: Registered named UNIX socket transport module.
[    0.900077] RPC: Registered udp transport module.
[    0.900199] RPC: Registered tcp transport module.
[    0.900281] RPC: Registered tcp NFSv4.1 backchannel transport module.
[    0.902394] pci_bus 0000:00: resource 4 [io  0x0000-0x0cf7 window]
[    0.902523] pci_bus 0000:00: resource 5 [io  0x0d00-0xffff window]
[    0.902627] pci_bus 0000:00: resource 6 [mem 0x000a0000-0x000bffff window]
[    0.902736] pci_bus 0000:00: resource 7 [mem 0x08000000-0xfebfffff window]
[    0.902843] pci_bus 0000:00: resource 8 [mem 0x100000000-0x17fffffff window]
[    0.903337] pci 0000:00:01.0: PIIX3: Enabling Passive Release
[    0.903500] pci 0000:00:00.0: Limiting direct PCI/PCI transfers
[    0.903693] PCI: CLS 0 bytes, default 64
[    0.916325] rcu-torture:--- Start of test: nreaders=1 nfakewriters=4 stat_interval=60 verbose=1 test_no_idle_hz=1 shuffle_interval=3 stutter=5 irqreader=1 fqs_duration=0 fqs_holdoff=0 fqs_stutter=3 test_boost=1/0 test_boost_interval=7 test_boost_duration=4 shutdown_secs=0 stall_cpu=0 stall_cpu_holdoff=10 stall_cpu_irqsoff=0 stall_cpu_block=0 n_barrier_cbs=0 onoff_interval=0 onoff_holdoff=0 read_exit_delay=13 read_exit_burst=16 nocbs_nthreads=0 nocbs_toggle=1000
[    0.916985] rcu:  Start-test grace-period state: g-1180 f0x0
[    0.917233] rcu_torture_write_types: Testing conditional GPs.
[    0.917354] rcu_torture_write_types: Testing conditional expedited GPs.
[    0.917476] rcu_torture_write_types: Testing conditional full-state GPs.
[    0.917608] rcu_torture_write_types: Testing expedited GPs.
[    0.917711] rcu_torture_write_types: Testing asynchronous GPs.
[    0.917827] rcu_torture_write_types: Testing polling GPs.
[    0.917935] rcu_torture_write_types: Testing polling full-state GPs.
[    0.918051] rcu_torture_write_types: Testing polling expedited GPs.
[    0.920063] rcu_torture_write_types: Testing polling full-state expedited GPs.
[    0.920267] rcu_torture_write_types: Testing normal GPs.
[    0.920398] rcu-torture: Creating rcu_torture_writer task
[    0.925279] rcu-torture: Creating rcu_torture_fakewriter task
[    0.925517] rcu-torture: rcu_torture_writer task started
[    0.925622] rcu-torture: GP expediting controlled from boot/sysfs for rcu.
[    0.925911] rcu-torture: Creating rcu_torture_fakewriter task
[    0.926177] rcu-torture: rcu_torture_fakewriter task started
[    0.926441] rcu-torture: Creating rcu_torture_fakewriter task
[    0.926633] rcu-torture: rcu_torture_fakewriter task started
[    0.929534] rcu-torture: Creating rcu_torture_fakewriter task
[    0.929728] rcu-torture: rcu_torture_fakewriter task started
[    0.933191] rcu-torture: Creating rcu_torture_reader task
[    0.933385] rcu-torture: rcu_torture_fakewriter task started
[    0.933568] rcu-torture: Creating rcu_torture_stats task
[    0.933771] rcu-torture: rcu_torture_reader task started
[    0.936668] rcu-torture: Creating torture_shuffle task
[    0.936869] rcu-torture: rcu_torture_stats task started
[    0.940253] rcu-torture: Creating torture_stutter task
[    0.940451] rcu-torture: torture_shuffle task started
[    0.940942] rcu-torture: rcu_torture_fwd_prog_init: Limiting fwd_progress to # CPUs.
[    0.940942] 
[    0.941243] rcu-torture: Creating rcu_torture_fwd_prog task
[    0.941456] rcu-torture: torture_stutter task started
[    0.941639] rcu-torture: Creating rcu_torture_read_exit task
[    0.941856] rcu-torture: rcu_torture_fwd_progress task started
[    0.947514] rcu-torture: rcu_torture_read_exit: Start of test
[    0.947639] rcu-torture: rcu_torture_read_exit: Start of episode
[    1.127805] Initialise system trusted keyrings
[    1.130310] workingset: timestamp_bits=52 max_order=15 bucket_order=0
[    1.135019] NFS: Registering the id_resolver key type
[    1.135355] Key type id_resolver registered
[    1.135454] Key type id_legacy registered
[    1.136103] 9p: Installing v9fs 9p2000 file system support
[    1.158863] Key type asymmetric registered
[    1.158984] Asymmetric key parser 'x509' registered
[    1.159238] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 251)
[    1.159619] io scheduler mq-deadline registered
[    1.159776] io scheduler kyber registered
[    1.161865] input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/input/input0
[    1.169798] ACPI: button: Power Button [PWRF]
[    1.171709] Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
[    1.173221] 00:05: ttyS0 at I/O 0x3f8 (irq = 4, base_baud = 115200) is a 16550A
[    1.176810] Non-volatile memory driver v1.3
[    1.176925] Linux agpgart interface v0.103
[    1.178200] ACPI: bus type drm_connector registered
[    1.192490] loop: module loaded
[    1.198992] scsi host0: ata_piix
[    1.200548] scsi host1: ata_piix
[    1.200975] ata1: PATA max MWDMA2 cmd 0x1f0 ctl 0x3f6 bmdma 0xc040 irq 14
[    1.201125] ata2: PATA max MWDMA2 cmd 0x170 ctl 0x376 bmdma 0xc048 irq 15
[    1.203131] e100: Intel(R) PRO/100 Network Driver
[    1.203231] e100: Copyright(c) 1999-2006 Intel Corporation
[    1.203372] e1000: Intel(R) PRO/1000 Network Driver
[    1.203461] e1000: Copyright (c) 1999-2006 Intel Corporation.
[    1.328433] ACPI: \_SB_.LNKC: Enabled at IRQ 11
[    1.364073] ata2: found unknown device (class 0)
[    1.367049] ata2.00: ATAPI: QEMU DVD-ROM, 2.5+, max UDMA/100
[    1.387571] scsi 1:0:0:0: CD-ROM            QEMU     QEMU DVD-ROM     2.5+ PQ: 0 ANSI: 5
[    1.421814] sr 1:0:0:0: [sr0] scsi3-mmc drive: 4x/4x cd/rw xa/form2 tray
[    1.422091] cdrom: Uniform CD-ROM driver Revision: 3.20
[    1.438991] sr 1:0:0:0: Attached scsi generic sg0 type 5
[    1.629533] e1000 0000:00:03.0 eth0: (PCI:33MHz:32-bit) 52:54:00:12:34:56
[    1.630076] e1000 0000:00:03.0 eth0: Intel(R) PRO/1000 Network Connection
[    1.630671] e1000e: Intel(R) PRO/1000 Network Driver
[    1.630893] e1000e: Copyright(c) 1999 - 2015 Intel Corporation.
[    1.631119] sky2: driver version 1.30
[    1.633061] usbcore: registered new interface driver usblp
[    1.633310] usbcore: registered new interface driver usb-storage
[    1.634251] i8042: PNP: PS/2 Controller [PNP0303:KBD,PNP0f13:MOU] at 0x60,0x64 irq 1,12
[    1.635356] serio: i8042 KBD port at 0x60,0x64 irq 1
[    1.639118] input: AT Translated Set 2 keyboard as /devices/platform/i8042/serio0/input/input1
[    1.641604] rtc_cmos 00:00: RTC can wake from S4
[    1.645061] rtc_cmos 00:00: registered as rtc0
[    1.645930] rtc_cmos 00:00: alarms up to one day, y3k, 114 bytes nvram, hpet irqs
[    1.646459] fail to initialize ptp_kvm
[    1.647167] device-mapper: ioctl: 4.47.0-ioctl (2022-07-28) initialised: dm-devel@redhat.com
[    1.648026] hid: raw HID events driver (C) Jiri Kosina
[    1.649668] usbcore: registered new interface driver usbhid
[    1.649892] usbhid: USB HID core driver
[    1.656872] Initializing XFRM netlink socket
[    1.657363] NET: Registered PF_INET6 protocol family
[    1.664012] Segment Routing with IPv6
[    1.664279] In-situ OAM (IOAM) with IPv6
[    1.665379] sit: IPv6, IPv4 and MPLS over IPv4 tunneling driver
[    1.667797] NET: Registered PF_PACKET protocol family
[    1.668554] 9pnet: Installing 9P2000 support
[    1.668907] Key type dns_resolver registered
[    1.670464] IPI shorthand broadcast: enabled
[    1.697862] sched_clock: Marking stable (1677801841, 19906552)->(1699548182, -1839789)
[    1.699598] registered taskstats version 1
[    1.699789] Loading compiled-in X.509 certificates
[    1.711887] PM:   Magic number: 7:827:242
[    1.712556] printk: console [netcon0] enabled
[    1.712707] netconsole: network logging started
[    1.715107] cfg80211: Loading compiled-in X.509 certificates for regulatory database
[    1.730934] kworker/u2:0 (56) used greatest stack depth: 14808 bytes left
[    1.731266] kworker/u2:0 (55) used greatest stack depth: 14440 bytes left
[    1.737240] cfg80211: Loaded X.509 cert 'sforshee: 00b28ddf47aef9cea7'
[    1.739025] platform regulatory.0: Direct firmware load for regulatory.db failed with error -2
[    1.739382] cfg80211: failed to load regulatory.db
[    1.740325] ALSA device list:
[    1.740458]   No soundcards found.
[    1.740603] Warning: unable to open an initial console.
[    1.775571] Freeing unused kernel image (initmem) memory: 3184K
[    1.775919] Write protecting the kernel read-only data: 26624k
[    1.777811] Freeing unused kernel image (rodata/data gap) memory: 1648K
[    1.883191] x86/mm: Checked W+X mappings: passed, no W+X pages found.
[    1.883467] Run /init as init process

Successfully reopened /dev/console.
Running test 'syscall'
0 getpid = 1                             [OK]
1 getppid = 0                            [OK]
3 gettid = 1                             [OK]
5 getpgid_self = 0                       [OK]
6 getpgid_bad = -1 ESRCH                 [OK]
7 kill_0[    1.940442] tsc: Refined TSC clocksource calibration: 2399.981 MHz
[    1.942334] clocksource: tsc: mask: 0xffffffffffffffff max_cycles: 0x229825a5278, max_idle_ns: 440795306804 ns
 = 0                             [OK]
8 kill_CONT = 0           [    1.944987] clocksource: Switched to clocksource tsc
               [OK]
9 kill_BADPID = -1 ESRCH                 [OK]
10 sbrk = 0                              [OK]
11 brk = 0                               [OK]
12 chdir_root = 0                        [OK]
13 chdir_dot = 0                         [OK]
14 chdir_blah = -1 ENOENT                [OK]
15 chmod_net = 0                         [OK]
16 chmod_self = -1 EPERM                 [OK]
17 chown_self = -1 EPERM                 [OK]
18 chroot_root = 0                       [OK]
19 chroot_blah = -1 ENOENT               [OK]
20 chroot_exe = -1 ENOTDIR               [OK]
21 close_m1 = -1 EBADF                   [OK]
22 close_dup = 0                         [OK]
23 dup_0 = 3                             [OK]
24 dup_m1 = -1 EBADF                     [OK]
25 dup2_0 = 100                          [OK]
26 dup2_m1 = -1 EBADF                    [OK]
27 dup3_0 = 100                          [OK]
28 dup3_m1 = -1 EBADF                    [OK]
29 execve_root = -1 EACCES               [OK]
30 getdents64_root = 120                 [OK]
31 getdents64_null = -1 ENOTDIR          [OK]
32 gettimeofday_null = 0                 [OK]
34 gettimeofday_bad1 = -1 EFAULT         [OK]
35 gettimeofday_bad2 = -1 EFAULT         [OK]
36 gettimeofday_bad2 = -1 EFAULT         [OK]
38 ioctl_tiocinq = 0                     [OK]
39 ioctl_tiocinq = 0                     [OK]
40 link_root1 = -1 EEXIST                [OK]
41 link_blah = -1 ENOENT                 [OK]
42 link_dir = -1 EPERM                   [OK]
43 link_cross = -1 EXDEV                 [OK]
44 lseek_m1 = -1 EBADF                   [OK]
45 lseek_0 = -1 ESPIPE                   [OK]
46 mkdir_root = -1 EEXIST                [OK]
47 open_tty = 3                          [OK]
48 open_blah = -1 ENOENT                 [OK]
49 poll_null = 0                         [OK]
50 poll_stdout = 1                       [OK]
51 poll_fault = -1 EFAULT                [OK]
52 read_badf = -1 EBADF                  [OK]
53 sched_yield = 0                       [OK]
54 select_null = 0                       [OK]
55 select_stdout = 1                     [OK]
56 select_fault = -1 EFAULT              [OK]
57 stat_blah = -1 ENOENT                 [OK]
58 stat_fault = -1 EFAULT                [OK]
59 symlink_root = -1 EEXIST              [OK]
60 unlink_root = -1 EISDIR               [OK]
61 unlink_blah = -1 ENOENT               [OK]
62 wait_child = -1 ECHILD                [OK]
63 waitpid_min = -1 ESRCH                [OK]
64 waitpid_child = -1 ECHILD             [OK]
65 write_badf = -1 EBADF                 [OK]
66 write_zero = 0                        [OK]
Errors during this test: 0

Running test 'stdlib'
0 getenv_TERM = <linux>                  [OK]
1 getenv_blah = <(null)>                 [OK]
2 setcmp_blah_blah = 0                   [OK]
3 setcmp_blah_blah2 = -50                [OK]
4 setncmp_blah_blah = 0                  [OK]
5 setncmp_blah_blah4 = 0                 [OK]
6 setncmp_blah_blah5 = -53               [OK]
7 setncmp_blah_blah6 = -54               [OK]
8 strchr_foobar_o = <oobar>              [OK]
9 strchr_foobar_z = <(null)>             [OK]
10 strrchr_foobar_o = <obar>             [OK]
11 strrchr_foobar_z = <(null)>           [OK]
12 memcmp_20_20 = 0                      [OK]
13 memcmp_20_60 = -64                    [OK]
14 memcmp_60_20 = 64                     [OK]
15 memcmp_20_e0 = -192                   [OK]
16 memcmp_e0_20 = 192                    [OK]
17 memcmp_80_e0 = -96                    [OK]
18 memcmp_e0_80 = 96                     [OK]
Errors during this test: 0

Total number of errors: 0
Leaving init with final status: 0
[    1.997522] rcu-torture: Unscheduled system shutdown detected
[    1.998802] torture thread rcu_torture_writer parking due to system shutdown
[    1.998960] torture thread rcu_torture_reader parking due to system shutdown
[    1.999074] torture thread rcu_torture_fakewriter parking due to system shutdown
[    1.999203] torture thread rcu_torture_fakewriter parking due to system shutdown
[    1.999313] torture thread rcu_torture_read_exit parking due to system shutdown
[    1.999423] torture thread rcu_torture_fakewriter parking due to system shutdown
[    1.999531] torture thread rcu_torture_fakewriter parking due to system shutdown
[    2.120164] ACPI: PM: Preparing to enter system sleep state S5
[    2.121173] reboot: Power down
