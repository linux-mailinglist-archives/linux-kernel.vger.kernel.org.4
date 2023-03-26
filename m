Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F6586C9621
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Mar 2023 17:26:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232491AbjCZP0m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Mar 2023 11:26:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229621AbjCZP0k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Mar 2023 11:26:40 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2AC01992
        for <linux-kernel@vger.kernel.org>; Sun, 26 Mar 2023 08:26:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 6D906CE0EA6
        for <linux-kernel@vger.kernel.org>; Sun, 26 Mar 2023 15:26:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C768C433EF;
        Sun, 26 Mar 2023 15:26:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679844392;
        bh=ZIqDT7G9Nj0rmKhGarFdVv2D2ibI8Fq7x5pSlr/qo+w=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=jHo4WJmMppz/xHGSwd6onRiQ7W4WcJS2gUijDQVe/WRjy3YwTo6yjw3m6BFrurHs4
         cJf/17v7k+6t5PlwbTBd19c+2/gM7hp+88ELgxVPQxqHQbKUp/6YZ2QB5KzcNlE8mc
         W6L6608MDQ+ngg3JFwURo6cYgk7isPBqT0RFsllk/yzaRU/IjnALSnLHj6l2eg3q+k
         PEjiF5dhPxeVg6eBRLyRtRW5dxbXMo4tVmnWHnCZRzPvDePkgquUcbTLpxKwk/WSFO
         aa0NiWojDDBG14CSy4gQOgtBSNpoGkeB0qmwbLkFM1BqPsSBIUcbsV95uT8HA5L/e1
         yk6iOSxcX7Fiw==
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 2E4D71540431; Sun, 26 Mar 2023 08:26:32 -0700 (PDT)
Date:   Sun, 26 Mar 2023 08:26:32 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Willy Tarreau <w@1wt.eu>
Cc:     linux@weissschuh.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/8] tools/nolibc: add support for stack protector
Message-ID: <35a26245-0171-44b0-8072-325576768f91@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20230325154516.7995-1-w@1wt.eu>
 <0d9bbc94-7ea2-4bc5-8523-29b100c0f1a1@paulmck-laptop>
 <a65340bb-2d11-445b-8595-9bf25a9f7a47@paulmck-laptop>
 <ZCBiDZfQW+YuiVNs@1wt.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZCBiDZfQW+YuiVNs@1wt.eu>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 26, 2023 at 05:17:33PM +0200, Willy Tarreau wrote:
> On Sun, Mar 26, 2023 at 08:13:48AM -0700, Paul E. McKenney wrote:
> > On Sat, Mar 25, 2023 at 09:36:28PM -0700, Paul E. McKenney wrote:
> > > On Sat, Mar 25, 2023 at 04:45:08PM +0100, Willy Tarreau wrote:
> > > > Hello Paul,
> > > > 
> > > > This is essentially Thomas' work so instead of paraphrasing his work,
> > > > I'm pasting his description below. I've tested his changes on all
> > > > supported archs, applied a tiny modification with his permission
> > > > to continue to support passing CFLAGS, and for me this is all fine.
> > > > In a short summary this adds support for stack protector to i386 and
> > > > x86_64 in nolibc, and the accompanying test to the selftest program.
> > > > 
> > > > A new test category was added, "protection", which currently has a
> > > > single test. Archs that support it will report "OK" there and those
> > > > that do not will report "SKIPPED", as is already the case for tests
> > > > that cannot be run.
> > > > 
> > > > This was applied on top of your dev.2023.03.20a branch. I'm reasonably
> > > > confident with the nature of the changes, so if your queue for 6.4 is
> > > > not closed yet, it can be a good target, otherwise 6.5 will be fine as
> > > > well.
> > > 
> > > I have applied and pushed it out, thank you both!
> > > 
> > > We are a little late in the process, but if testing goes well, I can't
> > > see why this cannot make the v6.4 merge window.
> > 
> > And "make run-user" says "124 test(s) passed", which looks promising.
> 
> Indeed!
> 
> > But "make run" says "0 test(s) passed".
> > 
> > (They initially both said "0 test(s) passed", but that was because I
> > forgot to build qemu-x86_64 after an upgrade.)
> > 
> > Please see below for the full output of "make run".  Am I missing
> > some other package?
> 
> Hmmm I think that the output of run.out will be needed here. We'll
> need to understand whether it fails to boot the kernel or to start
> the executable.

Ah, I knew I was forgetting something!

I am retrying the test after rebasing Thomas's latest series directly
on top of the rest of the nolibc patches.

In the meantime, the kernel died as shown below.

							Thanx, Paul

------------------------------------------------------------------------

[    0.000000] Linux version 6.3.0-rc1-00170-g70b5c4573f3c (paulmck@paulmck-ThinkPad-P72) (gcc (Ubuntu 11.3.0-1ubuntu1~22.04) 11.3.0, GNU ld (GNU Binutils for Ubuntu) 2.38) #103 SMP PREEMPT_DYNAMIC Sun Mar 26 07:22:25 PDT 2023
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
[    0.000000] tsc: Detected 2207.972 MHz processor
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
[    0.001000] percpu: Embedded 54 pages/cpu s182248 r8192 d30744 u2097152
[    0.001000] Fallback order for Node 0: 0 
[    0.001000] Built 1 zonelists, mobility grouping on.  Total pages: 31968
[    0.001000] Policy zone: DMA32
[    0.001000] Kernel command line: console=ttyS0,9600 i8042.noaux panic=-1 
[    0.001000] Dentry cache hash table entries: 16384 (order: 5, 131072 bytes, linear)
[    0.001000] Inode-cache hash table entries: 8192 (order: 4, 65536 bytes, linear)
[    0.001000] mem auto-init: stack:off, heap alloc:off, heap free:off
[    0.001000] Memory: 88160K/130552K available (18432K kernel code, 2716K rwdata, 6280K rodata, 2592K init, 1624K bss, 42132K reserved, 0K cma-reserved)
[    0.001000] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=1, Nodes=1
[    0.001000] Dynamic Preempt: full
[    0.001000] rcu: Preemptible hierarchical RCU implementation.
[    0.001000] rcu: 	RCU event tracing is enabled.
[    0.001000] rcu: 	RCU restricting CPUs from NR_CPUS=8 to nr_cpu_ids=1.
[    0.001000] 	Trampoline variant of Tasks RCU enabled.
[    0.001000] rcu: RCU calculated value of scheduler-enlistment delay is 100 jiffies.
[    0.001000] rcu: Adjusting geometry for rcu_fanout_leaf=16, nr_cpu_ids=1
[    0.001000] NR_IRQS: 4352, nr_irqs: 256, preallocated irqs: 16
[    0.001000] rcu: srcu_init: Setting srcu_struct sizes based on contention.
[    0.001000] Console: colour VGA+ 80x25
[    0.001000] printk: console [ttyS0] enabled
[    0.001000] ACPI: Core revision 20221020
[    0.001000] clocksource: hpet: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 19112604467 ns
[    0.001000] APIC: Switch to symmetric I/O mode setup
[    0.001000] ..TIMER: vector=0x30 apic1=0 pin1=2 apic2=-1 pin2=-1
[    0.001000] clocksource: tsc-early: mask: 0xffffffffffffffff max_cycles: 0x1fd39da580f, max_idle_ns: 440795205649 ns
[    0.124860] Calibrating delay loop (skipped), value calculated using timer frequency.. 4415.94 BogoMIPS (lpj=2207972)
[    0.125242] pid_max: default: 32768 minimum: 301
[    0.127214] LSM: initializing lsm=capability,integrity,selinux
[    0.127668] SELinux:  Initializing.
[    0.128980] Mount-cache hash table entries: 512 (order: 0, 4096 bytes, linear)
[    0.129192] Mountpoint-cache hash table entries: 512 (order: 0, 4096 bytes, linear)
[    0.143563] process: using AMD E400 aware idle routine
[    0.143915] Last level iTLB entries: 4KB 512, 2MB 255, 4MB 127
[    0.144082] Last level dTLB entries: 4KB 512, 2MB 255, 4MB 127, 1GB 0
[    0.144435] Spectre V1 : Mitigation: usercopy/swapgs barriers and __user pointer sanitization
[    0.144704] Spectre V2 : Mitigation: Retpolines
[    0.144838] Spectre V2 : Spectre v2 / SpectreRSB mitigation: Filling RSB on context switch
[    0.145061] Spectre V2 : Spectre v2 / SpectreRSB : Filling RSB on VMEXIT
[    0.490371] Freeing SMP alternatives memory: 44K
[    0.603618] smpboot: CPU0: AMD QEMU Virtual CPU version 2.5+ (family: 0xf, model: 0x6b, stepping: 0x1)
[    0.609414] RCU Tasks: Setting shift to 0 and lim to 1 rcu_task_cb_adjust=1.
[    0.609912] Performance Events: PMU not available due to virtualization, using software events only.
[    0.611760] rcu: Hierarchical SRCU implementation.
[    0.611917] rcu: 	Max phase no-delay instances is 400.
[    0.616398] smp: Bringing up secondary CPUs ...
[    0.616692] smp: Brought up 1 node, 1 CPU
[    0.616831] smpboot: Max logical packages: 1
[    0.617013] smpboot: Total of 1 processors activated (4415.94 BogoMIPS)
[    0.628258] devtmpfs: initialized
[    0.635370] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 1911260446275000 ns
[    0.635777] futex hash table entries: 256 (order: 2, 16384 bytes, linear)
[    0.638301] PM: RTC time: 14:22:40, date: 2023-03-26
[    0.642136] NET: Registered PF_NETLINK/PF_ROUTE protocol family
[    0.645048] audit: initializing netlink subsys (disabled)
[    0.648924] audit: type=2000 audit(1679840559.531:1): state=initialized audit_enabled=0 res=1
[    0.649934] thermal_sys: Registered thermal governor 'step_wise'
[    0.649965] thermal_sys: Registered thermal governor 'user_space'
[    0.651248] cpuidle: using governor menu
[    0.653900] PCI: Using configuration type 1 for base access
[    0.656831] kprobes: kprobe jump-optimization is enabled. All kprobes are optimized if possible.
[    0.666281] HugeTLB: registered 2.00 MiB page size, pre-allocated 0 pages
[    0.666494] HugeTLB: 28 KiB vmemmap can be freed for a 2.00 MiB page
[    0.674812] ACPI: Added _OSI(Module Device)
[    0.674955] ACPI: Added _OSI(Processor Device)
[    0.675073] ACPI: Added _OSI(3.0 _SCP Extensions)
[    0.675192] ACPI: Added _OSI(Processor Aggregator Device)
[    0.694265] ACPI: 1 ACPI AML tables successfully acquired and loaded
[    0.721668] ACPI: Interpreter enabled
[    0.722677] ACPI: PM: (supports S0 S3 S4 S5)
[    0.722827] ACPI: Using IOAPIC for interrupt routing
[    0.723251] PCI: Using host bridge windows from ACPI; if necessary, use "pci=nocrs" and report a bug
[    0.723501] PCI: Using E820 reservations for host bridge windows
[    0.724532] ACPI: Enabled 2 GPEs in block 00 to 0F
[    0.772673] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-ff])
[    0.773388] acpi PNP0A03:00: _OSC: OS supports [ASPM ClockPM Segments MSI HPX-Type3]
[    0.777724] acpi PNP0A03:00: _OSC: not requesting OS control; OS requires [ExtendedConfig ASPM ClockPM MSI]
[    0.778515] acpi PNP0A03:00: fail to add MMCONFIG information, can't access extended configuration space under this bridge
[    0.781385] PCI host bridge to bus 0000:00
[    0.785653] pci_bus 0000:00: root bus resource [io  0x0000-0x0cf7 window]
[    0.785930] pci_bus 0000:00: root bus resource [io  0x0d00-0xffff window]
[    0.786105] pci_bus 0000:00: root bus resource [mem 0x000a0000-0x000bffff window]
[    0.786348] pci_bus 0000:00: root bus resource [mem 0x08000000-0xfebfffff window]
[    0.786534] pci_bus 0000:00: root bus resource [mem 0x100000000-0x17fffffff window]
[    0.786746] pci_bus 0000:00: root bus resource [bus 00-ff]
[    0.788203] pci 0000:00:00.0: [8086:1237] type 00 class 0x060000
[    0.801795] pci 0000:00:01.0: [8086:7000] type 00 class 0x060100
[    0.802448] pci 0000:00:01.1: [8086:7010] type 00 class 0x010180
[    0.804169] pci 0000:00:01.1: reg 0x20: [io  0xc040-0xc04f]
[    0.805484] pci 0000:00:01.1: legacy IDE quirk: reg 0x10: [io  0x01f0-0x01f7]
[    0.809652] pci 0000:00:01.1: legacy IDE quirk: reg 0x14: [io  0x03f6]
[    0.809858] pci 0000:00:01.1: legacy IDE quirk: reg 0x18: [io  0x0170-0x0177]
[    0.810056] pci 0000:00:01.1: legacy IDE quirk: reg 0x1c: [io  0x0376]
[    0.810650] pci 0000:00:01.3: [8086:7113] type 00 class 0x068000
[    0.811105] pci 0000:00:01.3: quirk: [io  0x0600-0x063f] claimed by PIIX4 ACPI
[    0.811323] pci 0000:00:01.3: quirk: [io  0x0700-0x070f] claimed by PIIX4 SMB
[    0.811792] pci 0000:00:02.0: [1234:1111] type 00 class 0x030000
[    0.812552] pci 0000:00:02.0: reg 0x10: [mem 0xfd000000-0xfdffffff pref]
[    0.813618] pci 0000:00:02.0: reg 0x18: [mem 0xfebb0000-0xfebb0fff]
[    0.818836] pci 0000:00:02.0: reg 0x30: [mem 0xfeba0000-0xfebaffff pref]
[    0.819690] pci 0000:00:02.0: Video device with shadowed ROM at [mem 0x000c0000-0x000dffff]
[    0.826304] pci 0000:00:03.0: [8086:100e] type 00 class 0x020000
[    0.826618] pci 0000:00:03.0: reg 0x10: [mem 0xfeb80000-0xfeb9ffff]
[    0.827021] pci 0000:00:03.0: reg 0x14: [io  0xc000-0xc03f]
[    0.828618] pci 0000:00:03.0: reg 0x30: [mem 0xfeb00000-0xfeb7ffff pref]
[    0.842509] ACPI: PCI: Interrupt link LNKA configured for IRQ 10
[    0.843245] ACPI: PCI: Interrupt link LNKB configured for IRQ 10
[    0.843761] ACPI: PCI: Interrupt link LNKC configured for IRQ 11
[    0.844250] ACPI: PCI: Interrupt link LNKD configured for IRQ 11
[    0.844652] ACPI: PCI: Interrupt link LNKS configured for IRQ 9
[    0.850464] iommu: Default domain type: Translated 
[    0.850649] iommu: DMA domain TLB invalidation policy: lazy mode 
[    0.851983] SCSI subsystem initialized
[    0.855679] ACPI: bus type USB registered
[    0.856026] usbcore: registered new interface driver usbfs
[    0.856353] usbcore: registered new interface driver hub
[    0.856624] usbcore: registered new device driver usb
[    0.857057] pps_core: LinuxPPS API ver. 1 registered
[    0.857196] pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolfo Giometti <giometti@linux.it>
[    0.857480] PTP clock support registered
[    0.863031] Advanced Linux Sound Architecture Driver Initialized.
[    0.874491] NetLabel: Initializing
[    0.874624] NetLabel:  domain hash size = 128
[    0.874748] NetLabel:  protocols = UNLABELED CIPSOv4 CALIPSO
[    0.875644] NetLabel:  unlabeled traffic allowed by default
[    0.883018] PCI: Using ACPI for IRQ routing
[    0.887961] pci 0000:00:02.0: vgaarb: setting as boot VGA device
[    0.888158] pci 0000:00:02.0: vgaarb: bridge control possible
[    0.888346] pci 0000:00:02.0: vgaarb: VGA device added: decodes=io+mem,owns=io+mem,locks=none
[    0.888646] vgaarb: loaded
[    0.889460] hpet: 3 channels of 0 reserved for per-cpu timers
[    0.889823] hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0
[    0.890046] hpet0: 3 comparators, 64-bit 100.000000 MHz counter
[    0.897430] clocksource: Switched to clocksource tsc-early
[    0.898682] VFS: Disk quotas dquot_6.6.0
[    0.898913] VFS: Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
[    0.904530] pnp: PnP ACPI init
[    0.911905] pnp: PnP ACPI: found 6 devices
[    0.939044] clocksource: acpi_pm: mask: 0xffffff max_cycles: 0xffffff, max_idle_ns: 2085701024 ns
[    0.939656] NET: Registered PF_INET protocol family
[    0.940639] IP idents hash table entries: 2048 (order: 2, 16384 bytes, linear)
[    0.948782] tcp_listen_portaddr_hash hash table entries: 256 (order: 0, 4096 bytes, linear)
[    0.949097] Table-perturb hash table entries: 65536 (order: 6, 262144 bytes, linear)
[    0.949338] TCP established hash table entries: 1024 (order: 1, 8192 bytes, linear)
[    0.949659] TCP bind hash table entries: 1024 (order: 3, 32768 bytes, linear)
[    0.949943] TCP: Hash tables configured (established 1024 bind 1024)
[    0.950834] UDP hash table entries: 256 (order: 1, 8192 bytes, linear)
[    0.951198] UDP-Lite hash table entries: 256 (order: 1, 8192 bytes, linear)
[    0.956452] NET: Registered PF_UNIX/PF_LOCAL protocol family
[    0.964219] RPC: Registered named UNIX socket transport module.
[    0.964406] RPC: Registered udp transport module.
[    0.964534] RPC: Registered tcp transport module.
[    0.964657] RPC: Registered tcp NFSv4.1 backchannel transport module.
[    0.967086] pci_bus 0000:00: resource 4 [io  0x0000-0x0cf7 window]
[    0.967268] pci_bus 0000:00: resource 5 [io  0x0d00-0xffff window]
[    0.967428] pci_bus 0000:00: resource 6 [mem 0x000a0000-0x000bffff window]
[    0.967600] pci_bus 0000:00: resource 7 [mem 0x08000000-0xfebfffff window]
[    0.967771] pci_bus 0000:00: resource 8 [mem 0x100000000-0x17fffffff window]
[    0.968359] pci 0000:00:01.0: PIIX3: Enabling Passive Release
[    0.968590] pci 0000:00:00.0: Limiting direct PCI/PCI transfers
[    0.968853] PCI: CLS 0 bytes, default 64
[    0.976816] spin_lock-torture:--- Start of test: nwriters_stress=2 nreaders_stress=0 nested_locks=0 stat_interval=60 verbose=1 shuffle_interval=3 stutter=5 shutdown_secs=0 onoff_interval=0 onoff_holdoff=0
[    0.977380] spin_lock-torture: Creating torture_shuffle task
[    0.982150] spin_lock-torture: Creating torture_stutter task
[    0.982434] spin_lock-torture: torture_shuffle task started
[    0.986166] spin_lock-torture: Creating lock_torture_writer task
[    0.986457] spin_lock-torture: torture_stutter task started
[    0.989102] spin_lock-torture: Creating lock_torture_writer task
[    0.989393] spin_lock-torture: lock_torture_writer task started
[    0.992249] spin_lock-torture: Creating lock_torture_stats task
[    0.992502] spin_lock-torture: lock_torture_writer task started
[    0.995336] spin_lock-torture: lock_torture_stats task started
[    1.239439] Initialise system trusted keyrings
[    1.242459] workingset: timestamp_bits=56 max_order=15 bucket_order=0
[    1.245406] NFS: Registering the id_resolver key type
[    1.245853] Key type id_resolver registered
[    1.245995] Key type id_legacy registered
[    1.246633] 9p: Installing v9fs 9p2000 file system support
[    1.279622] Key type asymmetric registered
[    1.279837] Asymmetric key parser 'x509' registered
[    1.280164] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 251)
[    1.280712] io scheduler mq-deadline registered
[    1.280873] io scheduler kyber registered
[    1.284160] input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/input/input0
[    1.290699] ACPI: button: Power Button [PWRF]
[    1.293300] Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
[    1.295166] 00:04: ttyS0 at I/O 0x3f8 (irq = 4, base_baud = 115200) is a 16550A
[    1.300214] Non-volatile memory driver v1.3
[    1.300408] Linux agpgart interface v0.103
[    1.302107] ACPI: bus type drm_connector registered
[    1.320006] loop: module loaded
[    1.327876] scsi host0: ata_piix
[    1.330133] scsi host1: ata_piix
[    1.330559] ata1: PATA max MWDMA2 cmd 0x1f0 ctl 0x3f6 bmdma 0xc040 irq 14
[    1.330810] ata2: PATA max MWDMA2 cmd 0x170 ctl 0x376 bmdma 0xc048 irq 15
[    1.335535] e100: Intel(R) PRO/100 Network Driver
[    1.335764] e100: Copyright(c) 1999-2006 Intel Corporation
[    1.335983] e1000: Intel(R) PRO/1000 Network Driver
[    1.336117] e1000: Copyright (c) 1999-2006 Intel Corporation.
[    1.492281] ata2: found unknown device (class 0)
[    1.495093] ata2.00: ATAPI: QEMU DVD-ROM, 2.5+, max UDMA/100
[    1.503097] ACPI: \_SB_.LNKC: Enabled at IRQ 11
[    1.514708] scsi 1:0:0:0: CD-ROM            QEMU     QEMU DVD-ROM     2.5+ PQ: 0 ANSI: 5
[    1.530037] sr 1:0:0:0: [sr0] scsi3-mmc drive: 4x/4x cd/rw xa/form2 tray
[    1.530391] cdrom: Uniform CD-ROM driver Revision: 3.20
[    1.536947] sr 1:0:0:0: Attached scsi generic sg0 type 5
[    1.854410] e1000 0000:00:03.0 eth0: (PCI:33MHz:32-bit) 52:54:00:12:34:56
[    1.854970] e1000 0000:00:03.0 eth0: Intel(R) PRO/1000 Network Connection
[    1.855587] e1000e: Intel(R) PRO/1000 Network Driver
[    1.855782] e1000e: Copyright(c) 1999 - 2015 Intel Corporation.
[    1.856024] sky2: driver version 1.30
[    1.858316] usbcore: registered new interface driver usblp
[    1.858565] usbcore: registered new interface driver usb-storage
[    1.859390] i8042: PNP: PS/2 Controller [PNP0303:KBD,PNP0f13:MOU] at 0x60,0x64 irq 1,12
[    1.863361] serio: i8042 KBD port at 0x60,0x64 irq 1
[    1.866603] input: AT Translated Set 2 keyboard as /devices/platform/i8042/serio0/input/input1
[    1.869204] rtc_cmos 00:05: RTC can wake from S4
[    1.871805] rtc_cmos 00:05: registered as rtc0
[    1.872488] rtc_cmos 00:05: alarms up to one day, y3k, 242 bytes nvram, hpet irqs
[    1.872974] fail to initialize ptp_kvm
[    1.873472] device-mapper: ioctl: 4.47.0-ioctl (2022-07-28) initialised: dm-devel@redhat.com
[    1.874318] hid: raw HID events driver (C) Jiri Kosina
[    1.876110] usbcore: registered new interface driver usbhid
[    1.876272] usbhid: USB HID core driver
[    1.882759] Initializing XFRM netlink socket
[    1.883196] NET: Registered PF_INET6 protocol family
[    1.889769] Segment Routing with IPv6
[    1.890027] In-situ OAM (IOAM) with IPv6
[    1.890933] sit: IPv6, IPv4 and MPLS over IPv4 tunneling driver
[    1.893242] NET: Registered PF_PACKET protocol family
[    1.894386] 9pnet: Installing 9P2000 support
[    1.894728] Key type dns_resolver registered
[    1.896072] IPI shorthand broadcast: enabled
[    1.917836] sched_clock: Marking stable (1804029949, 113618045)->(1920714520, -3066526)
[    1.920605] registered taskstats version 1
[    1.920804] Loading compiled-in X.509 certificates
[    1.930423] PM:   Magic number: 15:243:385
[    1.931179] printk: console [netcon0] enabled
[    1.931355] netconsole: network logging started
[    1.933456] cfg80211: Loading compiled-in X.509 certificates for regulatory database
[    1.949516] kworker/u2:0 (49) used greatest stack depth: 14664 bytes left
[    1.956539] Loaded X.509 cert 'sforshee: 00b28ddf47aef9cea7'
[    1.957972] platform regulatory.0: Direct firmware load for regulatory.db failed with error -2
[    1.958404] cfg80211: failed to load regulatory.db
[    1.959782] ALSA device list:
[    1.959918]   No soundcards found.
[    1.960098] Warning: unable to open an initial console.
[    2.002800] tsc: Refined TSC clocksource calibration: 2207.977 MHz
[    2.003135] clocksource: tsc: mask: 0xffffffffffffffff max_cycles: 0x1fd3a2585d9, max_idle_ns: 440795220917 ns
[    2.003450] clocksource: Switched to clocksource tsc
[    2.011913] Freeing unused kernel image (initmem) memory: 2592K
[    2.012306] Write protecting the kernel read-only data: 26624k
[    2.015606] Freeing unused kernel image (rodata/data gap) memory: 1912K
[    2.194808] x86/mm: Checked W+X mappings: passed, no W+X pages found.
[    2.195182] Run /init as init process
[    2.214173] BUG: unable to handle page fault for address: 000000000001cc43
[    2.214479] #PF: supervisor read access in kernel mode
[    2.214627] #PF: error_code(0x0000) - not-present page
[    2.214814] PGD 1b36067 P4D 1b36067 PUD 1b31067 PMD 0 
[    2.215123] Oops: 0000 [#1] PREEMPT SMP NOPTI
[    2.215348] CPU: 0 PID: 1 Comm: init Not tainted 6.3.0-rc1-00170-g70b5c4573f3c #103
[    2.215618] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
[    2.215910] RIP: 0010:_raw_spin_lock+0x12/0x30
[    2.216253] Code: 84 00 00 00 00 00 66 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 f3 0f 1e fa 65 ff 05 dd 9e 3e 77 31 c0 ba 01 00 00 00 <3e> 0f b1 17 75 05 c3 cc cc cc cc 89 c6 e9 9c 00 00 00 66 66 2e 0f
[    2.216756] RSP: 0018:ffffa55cc0013da8 EFLAGS: 00000046
[    2.216925] RAX: 0000000000000000 RBX: 0000000000000008 RCX: 0000000000000001
[    2.217113] RDX: 0000000000000001 RSI: 0000000000000246 RDI: 000000000001cc43
[    2.217299] RBP: ffffa55cc0013e08 R08: 0000000083f15400 R09: 0000000000000001
[    2.217534] R10: 00000000bfbab7ff R11: 00000000d9a3ff84 R12: 000000000001cc43
[    2.217719] R13: 000000000001cc43 R14: 0000000000000001 R15: 0000000000000286
[    2.217934] FS:  0000000000000000(0000) GS:ffff9e3f87a00000(0000) knlGS:0000000000000000
[    2.218148] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    2.218304] CR2: 000000000001cc43 CR3: 0000000001b32000 CR4: 00000000000006f0
[    2.218544] Call Trace:
[    2.219033]  <TASK>
[    2.219166]  add_timer_on+0x80/0x130
[    2.219465]  try_to_generate_entropy+0x23b/0x270
[    2.219609]  ? __handle_mm_fault+0xa41/0xc70
[    2.219734]  ? __pfx_entropy_timer+0x10/0x10
[    2.219855]  wait_for_random_bytes+0x49/0xe0
[    2.219971]  ? handle_mm_fault+0x97/0x1f0
[    2.220084]  __x64_sys_getrandom+0x8e/0xc0
[    2.220200]  ? exit_to_user_mode_prepare+0xfe/0x110
[    2.220331]  do_syscall_64+0x3f/0x90
[    2.220447]  entry_SYSCALL_64_after_hwframe+0x72/0xdc
[    2.220681] RIP: 0033:0x404531
[    2.220901] Code: 05 f4 2a 00 00 48 89 44 24 08 31 c0 e8 a0 ff ff ff f3 0f 1e fa b8 3e 01 00 00 48 8d 3d d8 2a 00 00 be 08 00 00 00 31 d2 0f 05 <48> 31 3d c8 2a 00 00 c3 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[    2.221365] RSP: 002b:00007ffc541e0848 EFLAGS: 00000246 ORIG_RAX: 000000000000013e
[    2.221572] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 0000000000404531
[    2.221749] RDX: 0000000000000000 RSI: 0000000000000008 RDI: 0000000000407000
[    2.221924] RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
[    2.222098] R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
[    2.222272] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
[    2.222484]  </TASK>
[    2.222582] Modules linked in:
[    2.222770] CR2: 000000000001cc43
[    2.223139] ---[ end trace 0000000000000000 ]---
[    2.223290] RIP: 0010:_raw_spin_lock+0x12/0x30
[    2.223416] Code: 84 00 00 00 00 00 66 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 f3 0f 1e fa 65 ff 05 dd 9e 3e 77 31 c0 ba 01 00 00 00 <3e> 0f b1 17 75 05 c3 cc cc cc cc 89 c6 e9 9c 00 00 00 66 66 2e 0f
[    2.223861] RSP: 0018:ffffa55cc0013da8 EFLAGS: 00000046
[    2.223998] RAX: 0000000000000000 RBX: 0000000000000008 RCX: 0000000000000001
[    2.224173] RDX: 0000000000000001 RSI: 0000000000000246 RDI: 000000000001cc43
[    2.224348] RBP: ffffa55cc0013e08 R08: 0000000083f15400 R09: 0000000000000001
[    2.224523] R10: 00000000bfbab7ff R11: 00000000d9a3ff84 R12: 000000000001cc43
[    2.224697] R13: 000000000001cc43 R14: 0000000000000001 R15: 0000000000000286
[    2.224872] FS:  0000000000000000(0000) GS:ffff9e3f87a00000(0000) knlGS:0000000000000000
[    2.225070] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    2.225214] CR2: 000000000001cc43 CR3: 0000000001b32000 CR4: 00000000000006f0
[    2.225441] note: init[1] exited with irqs disabled
[    2.225633] note: init[1] exited with preempt_count 2
[    2.226208] Kernel panic - not syncing: Attempted to kill init! exitcode=0x00000009
[    2.226697] Kernel Offset: 0x6e00000 from 0xffffffff81000000 (relocation range: 0xffffffff80000000-0xffffffffbfffffff)
