Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67A8E5FC48F
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 13:55:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229653AbiJLLyo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 07:54:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229587AbiJLLyl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 07:54:41 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C126C7C
        for <linux-kernel@vger.kernel.org>; Wed, 12 Oct 2022 04:54:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 98D0BB81A7D
        for <linux-kernel@vger.kernel.org>; Wed, 12 Oct 2022 11:54:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 371A4C433D6;
        Wed, 12 Oct 2022 11:54:31 +0000 (UTC)
Date:   Wed, 12 Oct 2022 12:54:27 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Amit Pundir <amit.pundir@linaro.org>
Cc:     Will Deacon <will@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Bjorn Andersson <andersson@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Robin Murphy <robin.murphy@arm.com>
Subject: Re: [GIT PULL] arm64 updates for 6.1-rc1
Message-ID: <Y0aq8y5mEZi14lJ/@arm.com>
References: <20221005144116.2256580-1-catalin.marinas@arm.com>
 <CAMi1Hd38YB2m_r=m0wuDz+wErii37fUq1BJnvN9=y6opDzo_Fw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMi1Hd38YB2m_r=m0wuDz+wErii37fUq1BJnvN9=y6opDzo_Fw@mail.gmail.com>
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Amit,

On Sat, Oct 08, 2022 at 08:28:26PM +0530, Amit Pundir wrote:
> On Wed, 5 Oct 2022 at 20:11, Catalin Marinas <catalin.marinas@arm.com> wrote:
> > Will Deacon (2):
> >       arm64: dma: Drop cache invalidation from arch_dma_prep_coherent()
> 
> Hi Will,
> 
> This patch broke AOSP on Dragonboard 845c (SDM845). I don't see any
> relevant crash in the attached log and device silently reboots into
> USB crash dump mode. The crash is fairly reproducible on db845c. I
> could trigger it twice in 5 reboots and it always crash at the same
> point during the boot process. Reverting this patch fixes the crash.
> 
> I'm happy to test run any debug patche(s), that would help narrow
> down this breakage.

Cc'ing Robin, maybe he has a better idea (that's commit c44094eee32f).
Architecturally the change shouldn't make any difference since the cache
lines can be brought in via the linear mapping at any point. It's just
less likely to hit a real bug (software or hardware). It's also possible
that arch_dma_prep_coherent() is used outside the DMA API (if you have
out of tree drivers).

Leaving the original log in place for Robin. A question I have, with a
successful boot, what's normally after the bpfloader lines are printed?
We should try to pinpoint which device/driver causes this. It looks like
it's well into user-space at that point (graphics about to start?)

> [    0.000000][    T0] Booting Linux on physical CPU 0x0000000000 [0x517f803c]
> [    0.000000][    T0] Linux version 6.0.0-mainline-06186-ga0de42dfac25 (pundiramit@x-wing) (aarch64-linux-gnu-gcc (Ubuntu 9.4.0-1ubuntu1~20.04.1) 9.4.0, GNU ld (GNU Binutils for Ubuntu) 2.34) #1 SMP PREEMPT Sat Oct 8 16:56:02 IST 2022
> [    0.000000][    T0] Machine model: Thundercomm Dragonboard 845c
> [    0.000000][    T0] earlycon: qcom_geni0 at MMIO 0x0000000000a84000 (options '115200n8')
> [    0.000000][    T0] printk: bootconsole [qcom_geni0] enabled
> [    0.000000][    T0] efi: UEFI not found.
> [    0.000000][    T0] Zone ranges:
> [    0.000000][    T0]   DMA32    [mem 0x0000000080000000-0x00000000ffffffff]
> [    0.000000][    T0]   Normal   [mem 0x0000000100000000-0x000000017df9ffff]
> [    0.000000][    T0] Movable zone start for each node
> [    0.000000][    T0] Early memory node ranges
> [    0.000000][    T0]   node   0: [mem 0x0000000080000000-0x00000000856fffff]
> [    0.000000][    T0]   node   0: [mem 0x0000000085700000-0x0000000085cfffff]
> [    0.000000][    T0]   node   0: [mem 0x0000000085d00000-0x0000000085dfffff]
> [    0.000000][    T0]   node   0: [mem 0x0000000085e00000-0x0000000085efffff]
> [    0.000000][    T0]   node   0: [mem 0x0000000085f00000-0x0000000085fbffff]
> [    0.000000][    T0]   node   0: [mem 0x0000000085fc0000-0x00000000890fffff]
> [    0.000000][    T0]   node   0: [mem 0x0000000089100000-0x000000008aafffff]
> [    0.000000][    T0]   node   0: [mem 0x000000008ab00000-0x000000008c416fff]
> [    0.000000][    T0]   node   0: [mem 0x000000008c417000-0x000000008c4fffff]
> [    0.000000][    T0]   node   0: [mem 0x000000008c500000-0x0000000097bfffff]
> [    0.000000][    T0]   node   0: [mem 0x0000000097c00000-0x000000017df9ffff]
> [    0.000000][    T0] Initmem setup node 0 [mem 0x0000000080000000-0x000000017df9ffff]
> [    0.000000][    T0] On node 0, zone Normal: 8288 pages in unavailable ranges
> [    0.000000][    T0] cma: Reserved 16 MiB at 0x00000000ff000000
> [    0.000000][    T0] psci: probing for conduit method from DT.
> [    0.000000][    T0] psci: PSCIv1.1 detected in firmware.
> [    0.000000][    T0] psci: Using standard PSCI v0.2 function IDs
> [    0.000000][    T0] psci: MIGRATE_INFO_TYPE not supported.
> [    0.000000][    T0] psci: SMC Calling Convention v1.2
> [    0.000000][    T0] psci: OSI mode supported.
> [    0.000000][    T0] psci: failed to set PC mode: -3
> [    0.000000][    T0] percpu: Embedded 29 pages/cpu s80296 r8192 d30296 u118784
> [    0.000000][    T0] Detected VIPT I-cache on CPU0
> [    0.000000][    T0] CPU features: detected: GIC system register CPU interface
> [    0.000000][    T0] CPU features: detected: Hardware dirty bit management
> [    0.000000][    T0] CPU features: kernel page table isolation forced ON by KASLR
> [    0.000000][    T0] CPU features: detected: Kernel page table isolation (KPTI)
> [    0.000000][    T0] alternatives: applying boot alternatives
> [    0.000000][    T0] Built 1 zonelists, mobility grouping on.  Total pages: 1024033
> [    0.000000][    T0] Kernel command line: androidboot.hardware=db845c androidboot.boot_devices=soc@0/1d84000.ufshc earlycon firmware_class.path=/vendor/firmware/ init=/init printk.devkmsg=on deferred_probe_timeout=30 pcie_pme=nomsi qcom_geni_serial.con_enabled=1 console=ttyMSM0 buildvariant=userdebug  root=/dev/sda2 androidboot.bootdevice=1d84000.ufshc androidboot.serialno=c2d1480f androidboot.baseband=msm msm_drm.dsi_display0=dsi_lt9611_1080_video_display: androidboot.slot_suffix=_a rootwait ro init=/init androidboot.dtb_idx=-1347440721
> [    0.000000][    T0] Unknown kernel command line parameters "buildvariant=userdebug", will be passed to user space.
> [    0.000000][    T0] Dentry cache hash table entries: 524288 (order: 10, 4194304 bytes, linear)
> [    0.000000][    T0] Inode-cache hash table entries: 262144 (order: 9, 2097152 bytes, linear)
> [    0.000000][    T0] mem auto-init: stack:off, heap alloc:on, heap free:off
> [    0.000000][    T0] stackdepot hash table entries: 262144 (order: 9, 2097152 bytes, linear)
> [    0.000000][    T0] software IO TLB: area num 8.
> [    0.000000][    T0] software IO TLB: mapped [mem 0x00000000fb000000-0x00000000ff000000] (64MB)
> [    0.000000][    T0] Memory: 3663888K/4161152K available (16448K kernel code, 2000K rwdata, 9864K rodata, 3520K init, 571K bss, 480880K reserved, 16384K cma-reserved)
> [    0.000000][    T0] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=8, Nodes=1
> [    0.000000][    T0] trace event string verifier disabled
> [    0.000000][    T0] rcu: Preemptible hierarchical RCU implementation.
> [    0.000000][    T0] rcu:     RCU event tracing is enabled.
> [    0.000000][    T0] rcu:     RCU restricting CPUs from NR_CPUS=32 to nr_cpu_ids=8.
> [    0.000000][    T0]  Trampoline variant of Tasks RCU enabled.
> [    0.000000][    T0]  Tracing variant of Tasks RCU enabled.
> [    0.000000][    T0] rcu: RCU calculated value of scheduler-enlistment delay is 25 jiffies.
> [    0.000000][    T0] rcu: Adjusting geometry for rcu_fanout_leaf=16, nr_cpu_ids=8
> [    0.000000][    T0] NR_IRQS: 64, nr_irqs: 64, preallocated irqs: 0
> [    0.000000][    T0] GICv3: 768 SPIs implemented
> [    0.000000][    T0] GICv3: 0 Extended SPIs implemented
> [    0.000000][    T0] Root IRQ handler: gic_handle_irq
> [    0.000000][    T0] GICv3: GICv3 features: 16 PPIs
> [    0.000000][    T0] GICv3: CPU0: found redistributor 0 region 0:0x0000000017a60000
> [    0.000000][    T0] ITS: No ITS available, not enabling LPIs
> [    0.000000][    T0] rcu: srcu_init: Setting srcu_struct sizes based on contention.
> [    0.000000][    T0] kfence: initialized - using 524288 bytes for 63 objects at 0x(____ptrval____)-0x(____ptrval____)
> [    0.000000][    T0] arch_timer: cp15 and mmio timer(s) running at 19.20MHz (virt/virt).
> [    0.000000][    T0] clocksource: arch_sys_counter: mask: 0xffffffffffffff max_cycles: 0x46d987e47, max_idle_ns: 440795202767 ns
> [    0.000001][    T0] sched_clock: 56 bits at 19MHz, resolution 52ns, wraps every 4398046511078ns
> [    0.109112][    T0] Calibrating delay loop (skipped), value calculated using timer frequency.. 38.40 BogoMIPS (lpj=76800)
> [    0.120172][    T0] pid_max: default: 32768 minimum: 301
> [    0.125783][    T0] LSM: Security Framework initializing
> [    0.131227][    T0] SELinux:  Initializing.
> [    0.135758][    T0] Mount-cache hash table entries: 8192 (order: 4, 65536 bytes, linear)
> [    0.143939][    T0] Mountpoint-cache hash table entries: 8192 (order: 4, 65536 bytes, linear)
> [    0.154533][    T1] cblist_init_generic: Setting adjustable number of callback queues.
> [    0.162587][    T1] cblist_init_generic: Setting shift to 3 and lim to 1.
> [    0.169513][    T1] cblist_init_generic: Setting shift to 3 and lim to 1.
> [    0.176547][    T1] rcu: Hierarchical SRCU implementation.
> [    0.182108][    T1] rcu:     Max phase no-delay instances is 1000.
> [    0.188656][    T1] dyndbg: Ignore empty _ddebug table in a CONFIG_DYNAMIC_DEBUG_CORE build
> [    0.197435][    T1] EFI services will not be available.
> [    0.203178][    T1] smp: Bringing up secondary CPUs ...
> [    0.210125][    T0] Detected VIPT I-cache on CPU1
> [    0.210228][    T0] GICv3: CPU1: found redistributor 100 region 0:0x0000000017a80000
> [    0.210297][    T0] CPU1: Booted secondary processor 0x0000000100 [0x517f803c]
> [    0.211981][    T0] Detected VIPT I-cache on CPU2
> [    0.212065][    T0] GICv3: CPU2: found redistributor 200 region 0:0x0000000017aa0000
> [    0.212122][    T0] CPU2: Booted secondary processor 0x0000000200 [0x517f803c]
> [    0.213916][    T0] Detected VIPT I-cache on CPU3
> [    0.213996][    T0] GICv3: CPU3: found redistributor 300 region 0:0x0000000017ac0000
> [    0.214047][    T0] CPU3: Booted secondary processor 0x0000000300 [0x517f803c]
> [    0.216401][    T0] CPU features: detected: Spectre-v2
> [    0.216418][    T0] Detected VIPT I-cache on CPU4
> [    0.216508][    T0] GICv3: CPU4: found redistributor 400 region 0:0x0000000017ae0000
> [    0.216557][    T0] CPU4: Booted secondary processor 0x0000000400 [0x516f802d]
> [    0.218702][    T0] Detected VIPT I-cache on CPU5
> [    0.218791][    T0] GICv3: CPU5: found redistributor 500 region 0:0x0000000017b00000
> [    0.218839][    T0] CPU5: Booted secondary processor 0x0000000500 [0x516f802d]
> [    0.221069][    T0] Detected VIPT I-cache on CPU6
> [    0.221157][    T0] GICv3: CPU6: found redistributor 600 region 0:0x0000000017b20000
> [    0.221206][    T0] CPU6: Booted secondary processor 0x0000000600 [0x516f802d]
> [    0.223644][    T0] Detected VIPT I-cache on CPU7
> [    0.223738][    T0] GICv3: CPU7: found redistributor 700 region 0:0x0000000017b40000
> [    0.223786][    T0] CPU7: Booted secondary processor 0x0000000700 [0x516f802d]
> [    0.223874][    T1] smp: Brought up 1 node, 8 CPUs
> [    0.373017][    T1] SMP: Total of 8 processors activated.
> [    0.378480][    T1] CPU features: detected: 32-bit EL0 Support
> [    0.384386][    T1] CPU features: detected: 32-bit EL1 Support
> [    0.390280][    T1] CPU features: detected: Data cache clean to the PoU not required for I/D coherence
> [    0.399677][    T1] CPU features: detected: Common not Private translations
> [    0.406711][    T1] CPU features: detected: CRC32 instructions
> [    0.412603][    T1] CPU features: detected: RCpc load-acquire (LDAPR)
> [    0.419104][    T1] CPU features: detected: LSE atomic instructions
> [    0.425439][    T1] CPU features: detected: Privileged Access Never
> [    0.431774][    T1] CPU features: detected: RAS Extension Support
> [    0.438021][    T1] CPU: All CPU(s) started at EL1
> [    0.442891][    T1] alternatives: applying system-wide alternatives
> [    0.476634][    T1] Registered cp15_barrier emulation handler
> [    0.482478][    T1] Registered setend emulation handler
> [    0.487974][    T1] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 7645041785100000 ns
> [    0.498523][    T1] futex hash table entries: 2048 (order: 5, 131072 bytes, linear)
> [    0.506769][    T1] pinctrl core: initialized pinctrl subsystem
> [    0.513779][    T1] NET: Registered PF_NETLINK/PF_ROUTE protocol family
> [    0.522217][    T1] DMA: preallocated 512 KiB GFP_KERNEL pool for atomic allocations
> [    0.530388][    T1] DMA: preallocated 512 KiB GFP_KERNEL|GFP_DMA32 pool for atomic allocations
> [    0.539222][    T1] audit: initializing netlink subsys (disabled)
> [    0.545576][   T57] audit: type=2000 audit(0.404:1): state=initialized audit_enabled=0 res=1
> [    0.545913][    T1] thermal_sys: Registered thermal governor 'step_wise'
> [    0.554104][    T1] thermal_sys: Registered thermal governor 'user_space'
> [    0.560873][    T1] thermal_sys: Registered thermal governor 'power_allocator'
> [    0.567876][    T1] cpuidle: using governor menu
> [    0.580191][    T1] hw-breakpoint: found 6 breakpoint and 4 watchpoint registers.
> [    0.587978][    T1] ASID allocator initialised with 32768 entries
> [    0.594290][    T1] Serial: AMBA PL011 UART driver
> [    0.613278][    T1] platform 1c06000.phy: Fixing up cyclic dependency with 100000.clock-controller
> [    0.622642][    T1] platform 1c0a000.phy: Fixing up cyclic dependency with 100000.clock-controller
> [    0.632634][    T1] platform 1d87000.phy: Fixing up cyclic dependency with 1d84000.ufshc
> [    0.642030][    T1] amba 6041000.funnel: Fixing up cyclic dependency with 6002000.stm
> [    0.650179][    T1] amba 6045000.funnel: Fixing up cyclic dependency with 6043000.funnel
> [    0.658382][    T1] amba 6045000.funnel: Fixing up cyclic dependency with 6041000.funnel
> [    0.666768][    T1] amba 6047000.etf: Fixing up cyclic dependency with 6045000.funnel
> [    0.674735][    T1] amba 6047000.etf: Fixing up cyclic dependency with 6046000.replicator
> [    0.683112][    T1] amba 6048000.etr: Fixing up cyclic dependency with 6046000.replicator
> [    0.692103][    T1] amba 7800000.funnel: Fixing up cyclic dependency with 7740000.etm
> [    0.700049][    T1] amba 7800000.funnel: Fixing up cyclic dependency with 7640000.etm
> [    0.707991][    T1] amba 7800000.funnel: Fixing up cyclic dependency with 7540000.etm
> [    0.715953][    T1] amba 7800000.funnel: Fixing up cyclic dependency with 7440000.etm
> [    0.723894][    T1] amba 7800000.funnel: Fixing up cyclic dependency with 7340000.etm
> [    0.731843][    T1] amba 7800000.funnel: Fixing up cyclic dependency with 7240000.etm
> [    0.739793][    T1] amba 7800000.funnel: Fixing up cyclic dependency with 7140000.etm
> [    0.747733][    T1] amba 7800000.funnel: Fixing up cyclic dependency with 7040000.etm
> [    0.755819][    T1] amba 7810000.funnel: Fixing up cyclic dependency with 7800000.funnel
> [    0.764019][    T1] amba 7810000.funnel: Fixing up cyclic dependency with 6043000.funnel
> [    0.775488][    T1] platform af00000.clock-controller: Fixing up cyclic dependency with dsi-phy@ae94400 (ae00000.mdss)
> [    0.792531][    T1] KASLR enabled
> [    0.804784][    T1] iommu: Default domain type: Translated 
> [    0.810423][    T1] iommu: DMA domain TLB invalidation policy: strict mode 
> [    0.817886][    T1] SCSI subsystem initialized
> [    0.822512][    T1] usbcore: registered new interface driver usbfs
> [    0.828781][    T1] usbcore: registered new interface driver hub
> [    0.834880][    T1] usbcore: registered new device driver usb
> [    0.840806][    T1] mc: Linux media interface: v0.10
> [    0.845860][    T1] videodev: Linux video capture interface: v2.00
> [    0.852149][    T1] pps_core: LinuxPPS API ver. 1 registered
> [    0.857869][    T1] pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolfo Giometti <giometti@linux.it>
> [    0.867791][    T1] PTP clock support registered
> [    0.872479][    T1] EDAC MC: Ver: 3.0.0
> [    0.876845][    T1] CPUidle PSCI: Initialized CPU PM domain topology
> [    0.883809][    T1] Advanced Linux Sound Architecture Driver Initialized.
> [    0.891059][    T1] Bluetooth: Core ver 2.22
> [    0.895411][    T1] NET: Registered PF_BLUETOOTH protocol family
> [    0.901484][    T1] Bluetooth: HCI device and connection manager initialized
> [    0.908612][    T1] Bluetooth: HCI socket layer initialized
> [    0.914250][    T1] Bluetooth: L2CAP socket layer initialized
> [    0.920062][    T1] Bluetooth: SCO socket layer initialized
> [    0.925887][    T1] nfc: nfc_init: NFC Core ver 0.1
> [    0.930858][    T1] NET: Registered PF_NFC protocol family
> [    0.937058][    T1] clocksource: Switched to clocksource arch_sys_counter
> [    0.944302][    T1] VFS: Disk quotas dquot_6.6.0
> [    0.949042][    T1] VFS: Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
> [    0.957338][    T1] NET: Registered PF_INET protocol family
> [    0.963156][    T1] IP idents hash table entries: 65536 (order: 7, 524288 bytes, linear)
> [    0.974711][    T1] tcp_listen_portaddr_hash hash table entries: 2048 (order: 3, 32768 bytes, linear)
> [    0.984104][    T1] Table-perturb hash table entries: 65536 (order: 6, 262144 bytes, linear)
> [    0.992698][    T1] TCP established hash table entries: 32768 (order: 6, 262144 bytes, linear)
> [    1.001652][    T1] TCP bind hash table entries: 32768 (order: 8, 1048576 bytes, linear)
> [    1.010545][    T1] TCP: Hash tables configured (established 32768 bind 32768)
> [    1.017958][    T1] UDP hash table entries: 2048 (order: 4, 65536 bytes, linear)
> [    1.025512][    T1] UDP-Lite hash table entries: 2048 (order: 4, 65536 bytes, linear)
> [    1.033652][    T1] NET: Registered PF_UNIX/PF_LOCAL protocol family
> [    1.040618][    T1] NET: Registered PF_XDP protocol family
> [    1.046185][    T1] PCI: CLS 0 bytes, default 64
> [    1.051101][    T9] Trying to unpack rootfs image as initramfs...
> [    1.058233][    T1] hw perfevents: enabled with armv8_pmuv3 PMU driver, 7 counters available
> [    1.067409][    T1] kvm [1]: HYP mode not available
> [    1.073450][    T1] Initialise system trusted keyrings
> [    1.078843][    T1] workingset: timestamp_bits=46 max_order=20 bucket_order=0
> [    1.092657][    T1] fuse: init (API version 7.36)
> [    1.133380][    T1] Key type asymmetric registered
> [    1.138246][    T1] Asymmetric key parser 'x509' registered
> [    1.143942][    T1] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 241)
> [    1.152119][    T1] io scheduler mq-deadline registered
> [    1.157400][    T1] io scheduler kyber registered
> [    1.162325][    T1] io scheduler bfq registered
> [    1.167241][   T74] cryptomgr_test (74) used greatest stack depth: 14800 bytes left
> [    1.283491][    T1] brd: module loaded
> [    1.295870][    T1] loop: module loaded
> [    1.300822][    T1] wireguard: WireGuard 1.0.0 loaded. See www.wireguard.com for information.
> [    1.309433][    T1] wireguard: Copyright (C) 2015-2019 Jason A. Donenfeld <Jason@zx2c4.com>. All Rights Reserved.
> [    1.320281][    T1] MACsec IEEE 802.1AE
> [    1.324561][    T1] tun: Universal TUN/TAP device driver, 1.6
> [    1.330419][    T1] CAN device driver interface
> [    1.335011][    T1] PPP generic driver version 2.4.2
> [    1.340092][    T1] PPP BSD Compression module registered
> [    1.345551][    T1] PPP Deflate Compression module registered
> [    1.351578][    T1] PPP MPPE Compression module registered
> [    1.357143][    T1] NET: Registered PF_PPPOX protocol family
> [    1.362862][    T1] PPTP driver version 0.8.5
> [    1.367423][    T1] usbcore: registered new interface driver rtl8150
> [    1.373878][    T1] usbcore: registered new interface driver r8152
> [    1.380142][    T1] usbcore: registered new interface driver asix
> [    1.386332][    T1] usbcore: registered new interface driver cdc_ether
> [    1.392947][    T1] usbcore: registered new interface driver cdc_eem
> [    1.399403][    T1] usbcore: registered new interface driver cdc_ncm
> [    1.405842][    T1] usbcore: registered new interface driver aqc111
> [    1.412193][    T1] usbcore: registered new interface driver r8153_ecm
> [    1.419263][    T1] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
> [    1.426562][    T1] ehci-pci: EHCI PCI platform driver
> [    1.431783][    T1] ehci-platform: EHCI generic platform driver
> [    1.438238][    T1] usbcore: registered new interface driver cdc_acm
> [    1.444666][    T1] cdc_acm: USB Abstract Control Model driver for USB modems and ISDN adapters
> [    1.453650][    T1] usbcore: registered new interface driver uas
> [    1.459760][    T1] usbcore: registered new interface driver usb-storage
> [    1.466744][    T1] usbcore: registered new interface driver xpad
> [    1.473096][    T1] gspca_main: v2.14.0 registered
> [    1.477998][    T1] usbcore: registered new interface driver uvcvideo
> [    1.484763][    T1] device-mapper: uevent: version 1.0.3
> [    1.490313][    T1] device-mapper: ioctl: 4.47.0-ioctl (2022-07-28) initialised: dm-devel@redhat.com
> [    1.499818][    T1] Bluetooth: HCI UART driver ver 2.3
> [    1.505019][    T1] Bluetooth: HCI UART protocol H4 registered
> [    1.510934][    T1] Bluetooth: HCI UART protocol LL registered
> [    1.516933][    T1] Bluetooth: HCI UART protocol Broadcom registered
> [    1.523361][    T1] Bluetooth: HCI UART protocol QCA registered
> [    1.530879][    T1] sdhci: Secure Digital Host Controller Interface driver
> [    1.537831][    T1] sdhci: Copyright(c) Pierre Ossman
> [    1.542938][    T1] sdhci-pltfm: SDHCI platform and OF driver helper
> [    1.549812][    T1] SMCCC: SOC_ID: ARCH_FEATURES(ARCH_SOC_ID) returned error: fffffffffffffffe
> [    1.558571][    T1] hid: raw HID events driver (C) Jiri Kosina
> [    1.565332][    T1] usbcore: registered new interface driver usbhid
> [    1.571681][    T1] usbhid: USB HID core driver
> [    1.576537][    T1] ashmem: initialized
> [    1.580523][    T1] gnss: GNSS driver registered with major 509
> [    1.587415][    T1] usbcore: registered new interface driver snd-usb-audio
> [    1.594786][    T1] GACT probability NOT on
> [    1.599046][    T1] Mirror/redirect action on
> [    1.603469][    T1] netem: version 1.3
> [    1.607358][    T1] u32 classifier
> [    1.610807][    T1]     input device check on
> [    1.615210][    T1]     Actions configured
> [    1.620277][    T1] xt_time: kernel timezone is -0000
> [    1.625491][    T1] ipip: IPv4 and MPLS over IPv4 tunneling driver
> [    1.632100][    T1] gre: GRE over IPv4 demultiplexor driver
> [    1.637739][    T1] ip_gre: GRE over IPv4 tunneling driver
> [    1.644070][    T1] IPv4 over IPsec tunneling driver
> [    1.649505][    T1] Initializing XFRM netlink socket
> [    1.654561][    T1] IPsec XFRM device driver
> [    1.659375][    T1] NET: Registered PF_INET6 protocol family
> [    1.667842][    T1] Segment Routing with IPv6
> [    1.672292][    T1] In-situ OAM (IOAM) with IPv6
> [    1.677108][    T1] mip6: Mobile IPv6
> [    1.681380][    T1] sit: IPv6, IPv4 and MPLS over IPv4 tunneling driver
> [    1.688774][    T1] ip6_gre: GRE over IPv6 tunneling driver
> [    1.694783][    T1] NET: Registered PF_PACKET protocol family
> [    1.700609][    T1] NET: Registered PF_KEY protocol family
> [    1.706270][    T1] can: controller area network core
> [    1.711461][    T1] NET: Registered PF_CAN protocol family
> [    1.717008][    T1] can: raw protocol
> [    1.720722][    T1] can: broadcast manager protocol
> [    1.725663][    T1] can: netlink gateway - max_hops=1
> [    1.731861][    T1] Bluetooth: RFCOMM TTY layer initialized
> [    1.737522][    T1] Bluetooth: RFCOMM socket layer initialized
> [    1.743445][    T1] Bluetooth: RFCOMM ver 1.11
> [    1.747952][    T1] Bluetooth: HIDP (Human Interface Emulation) ver 1.2
> [    1.754641][    T1] Bluetooth: HIDP socket layer initialized
> [    1.760416][    T1] l2tp_core: L2TP core driver, V2.0
> [    1.765530][    T1] l2tp_ppp: PPPoL2TP kernel driver, V2.0
> [    1.771076][    T1] 8021q: 802.1Q VLAN Support v1.8
> [    1.776050][    T1] tipc: Activated (version 2.0.0)
> [    1.781201][    T1] NET: Registered PF_TIPC protocol family
> [    1.786949][    T1] tipc: Started in single node mode
> [    1.792257][    T1] NET: Registered PF_IEEE802154 protocol family
> [    1.798659][    T1] NET: Registered PF_VSOCK protocol family
> [    1.805401][    T1] registered taskstats version 1
> [    1.810280][    T1] Loading compiled-in X.509 certificates
> [    1.819303][   T86] cryptomgr_probe (86) used greatest stack depth: 13632 bytes left
> [    1.822305][    T1] Loaded X.509 cert 'Build time autogenerated kernel key: bf6fe752053bb8649b9d6b2f9b351d066a611a70'
> [    1.837902][    T1] page_owner is disabled
> [    1.842228][    T1] Key type .fscrypt registered
> [    1.846905][    T1] Key type fscrypt-provisioning registered
> [    1.875590][    T1] cfg80211: Loading compiled-in X.509 certificates for regulatory database
> [    1.887485][    T1] cfg80211: Loaded X.509 cert 'sforshee: 00b28ddf47aef9cea7'
> [    1.895015][    T1] ALSA device list:
> [    1.898740][    T1]   No soundcards found.
> [    1.902894][    T1] TAP version 14
> [    1.906348][    T1] 1..0
> [    2.069535][    T9] Freeing initrd memory: 27720K
> [    2.074787][   T55] platform regulatory.0: Direct firmware load for regulatory.db failed with error -2
> [    2.084227][   T55] cfg80211: failed to load regulatory.db
> [    2.089784][    T1] Warning: unable to open an initial console.
> [    2.096925][    T1] Freeing unused kernel memory: 3520K
> [    2.110595][    T1] Run /init as init process
> [    2.117461][    T1] init: init first stage started!
> [    2.129452][    T1] init: Loading module /lib/modules/rpmsg_core.ko with args ''
> [    2.137140][    T1] rpmsg_core: module verification failed: signature and/or required key missing - tainting kernel
> [    2.149533][    T1] init: Loaded kernel module /lib/modules/rpmsg_core.ko
> [    2.156620][    T1] init: Loading module /lib/modules/qmi_helpers.ko with args ''
> [    2.165880][    T1] init: Loaded kernel module /lib/modules/qmi_helpers.ko
> [    2.173088][    T1] init: Loading module /lib/modules/pdr_interface.ko with args ''
> [    2.182366][    T1] init: Loaded kernel module /lib/modules/pdr_interface.ko
> [    2.189536][    T1] init: Loading module /lib/modules/apr.ko with args ''
> [    2.198114][    T1] init: Loaded kernel module /lib/modules/apr.ko
> [    2.204749][    T1] init: Loading module /lib/modules/qcom-scm.ko with args ''
> [    2.213957][    T1] qcom_scm: convention: smc arm 64
> [    2.219634][    T1] init: Loaded kernel module /lib/modules/qcom-scm.ko
> [    2.226364][    T1] init: Loading module /lib/modules/arm_smmu.ko with args ''
> [    2.237655][    T1] arm-smmu 15000000.iommu: probing hardware configuration...
> [    2.244964][    T1] arm-smmu 15000000.iommu: SMMUv2 with:
> [    2.250450][    T1] arm-smmu 15000000.iommu:         stage 1 translation
> [    2.256612][    T1] arm-smmu 15000000.iommu:         non-coherent table walk
> [    2.263127][    T1] arm-smmu 15000000.iommu:         (IDR0.CTTW overridden by FW configuration)
> [    2.271295][    T1] arm-smmu 15000000.iommu:         stream matching with 76 register groups
> [    2.279224][    T1] arm-smmu 15000000.iommu:         45 context banks (0 stage-2 only)
> [    2.287503][    T1] arm-smmu 15000000.iommu:         Supported page sizes: 0x61311000
> [    2.294820][    T1] arm-smmu 15000000.iommu:         Stage-1: 48-bit VA -> 48-bit IPA
> [    2.302328][    T1] arm-smmu 15000000.iommu:         preserved 0 boot mappings
> [    2.311798][    T1] init: Loaded kernel module /lib/modules/arm_smmu.ko
> [    2.318746][    T1] init: Loading module /lib/modules/ath.ko with args ''
> [    2.327161][    T1] init: Loaded kernel module /lib/modules/ath.ko
> [    2.333623][    T1] init: Loading module /lib/modules/ath10k_core.ko with args ''
> [    2.347129][    T1] init: Loaded kernel module /lib/modules/ath10k_core.ko
> [    2.354360][    T1] init: Loading module /lib/modules/ath10k_pci.ko with args ''
> [    2.364507][    T1] init: Loaded kernel module /lib/modules/ath10k_pci.ko
> [    2.371778][    T1] init: Loading module /lib/modules/smem.ko with args ''
> [    2.380330][    T1] init: Loaded kernel module /lib/modules/smem.ko
> [    2.386887][    T1] init: Loading module /lib/modules/qcom_smd.ko with args ''
> [    2.395980][    T1] init: Loaded kernel module /lib/modules/qcom_smd.ko
> [    2.402873][    T1] init: Loading module /lib/modules/qcom_glink.ko with args ''
> [    2.412135][    T1] init: Loaded kernel module /lib/modules/qcom_glink.ko
> [    2.419217][    T1] init: Loading module /lib/modules/qcom_glink_smem.ko with args ''
> [    2.428479][    T1] init: Loaded kernel module /lib/modules/qcom_glink_smem.ko
> [    2.436076][    T1] init: Loading module /lib/modules/qcom_common.ko with args ''
> [    2.445096][    T1] init: Loaded kernel module /lib/modules/qcom_common.ko
> [    2.452085][    T1] init: Loading module /lib/modules/ath10k_snoc.ko with args ''
> [    2.462274][    T1] init: Loaded kernel module /lib/modules/ath10k_snoc.ko
> [    2.469440][    T1] init: Loading module /lib/modules/ath11k.ko with args ''
> [    2.483106][    T1] init: Loaded kernel module /lib/modules/ath11k.ko
> [    2.489916][    T1] init: Loading module /lib/modules/ath11k_ahb.ko with args ''
> [    2.499546][    T1] init: Loaded kernel module /lib/modules/ath11k_ahb.ko
> [    2.506790][    T1] init: Loading module /lib/modules/mhi.ko with args ''
> [    2.516078][    T1] init: Loaded kernel module /lib/modules/mhi.ko
> [    2.522368][    T1] init: Loading module /lib/modules/ath11k_pci.ko with args ''
> [    2.531665][    T1] init: Loaded kernel module /lib/modules/ath11k_pci.ko
> [    2.538732][    T1] init: Loading module /lib/modules/ax88179_178a.ko with args ''
> [    2.547916][    T1] usbcore: registered new interface driver ax88179_178a
> [    2.554816][    T1] init: Loaded kernel module /lib/modules/ax88179_178a.ko
> [    2.562214][    T1] init: Loading module /lib/modules/virt-dma.ko with args ''
> [    2.570885][    T1] init: Loaded kernel module /lib/modules/virt-dma.ko
> [    2.577596][    T1] init: Loading module /lib/modules/bam_dma.ko with args ''
> [    2.586941][    T1] bam-dma-engine 17184000.dma-controller: Adding to iommu group 0
> [    2.596381][    T1] init: Loaded kernel module /lib/modules/bam_dma.ko
> [    2.603222][    T1] init: Loading module /lib/modules/clk-qcom.ko with args ''
> [    2.613479][    T1] init: Loaded kernel module /lib/modules/clk-qcom.ko
> [    2.620667][    T1] init: Loading module /lib/modules/cmd-db.ko with args ''
> [    2.629522][    T1] init: Loaded kernel module /lib/modules/cmd-db.ko
> [    2.636276][    T1] init: Loading module /lib/modules/qcom_rpmh.ko with args ''
> [    2.648690][    T1] init: Loaded kernel module /lib/modules/qcom_rpmh.ko
> [    2.655590][    T1] init: Loading module /lib/modules/clk-rpmh.ko with args ''
> [    2.665982][    T1] init: Loaded kernel module /lib/modules/clk-rpmh.ko
> [    2.666934][    T9] bam-dma-engine 1dc4000.dma-controller: Adding to iommu group 1
> [    2.672997][    T1] init: Loading module /lib/modules/clk-spmi-pmic-div.ko with args ''
> [    2.680715][    T9] bam-dma-engine 1dc4000.dma-controller: num-channels unspecified in dt
> [    2.696665][    T9] bam-dma-engine 1dc4000.dma-controller: num-ees unspecified in dt
> [    2.704798][    T1] init: Loaded kernel module /lib/modules/clk-spmi-pmic-div.ko
> [    2.712556][    T1] init: Loading module /lib/modules/cpr.ko with args ''
> [    2.721153][    T1] init: Loaded kernel module /lib/modules/cpr.ko
> [    2.727603][    T1] init: Loading module /lib/modules/cqhci.ko with args ''
> [    2.736217][    T1] init: Loaded kernel module /lib/modules/cqhci.ko
> [    2.742861][    T1] init: Loading module /lib/modules/dispcc-sdm845.ko with args ''
> [    2.752272][    T1] init: Loaded kernel module /lib/modules/dispcc-sdm845.ko
> [    2.759604][    T1] init: Loading module /lib/modules/dispcc-sm8250.ko with args ''
> [    2.769023][    T1] init: Loaded kernel module /lib/modules/dispcc-sm8250.ko
> [    2.776531][    T1] init: Loading module /lib/modules/drm_kms_helper.ko with args ''
> [    2.789295][    T1] init: Loaded kernel module /lib/modules/drm_kms_helper.ko
> [    2.796558][    T1] init: Loading module /lib/modules/display-connector.ko with args ''
> [    2.806372][    T1] init: Loaded kernel module /lib/modules/display-connector.ko
> [    2.814083][    T1] init: Loading module /lib/modules/drm_display_helper.ko with args ''
> [    2.825933][    T1] init: Loaded kernel module /lib/modules/drm_display_helper.ko
> [    2.833814][    T1] init: Loading module /lib/modules/drm_dp_aux_bus.ko with args ''
> [    2.843191][    T1] init: Loaded kernel module /lib/modules/drm_dp_aux_bus.ko
> [    2.850625][    T1] init: Loading module /lib/modules/extcon-usb-gpio.ko with args ''
> [    2.860140][    T1] init: Loaded kernel module /lib/modules/extcon-usb-gpio.ko
> [    2.867643][    T1] init: Loading module /lib/modules/fastrpc.ko with args ''
> [    2.876961][    T1] init: Loaded kernel module /lib/modules/fastrpc.ko
> [    2.883775][    T1] init: Loading module /lib/modules/gcc-sdm845.ko with args ''
> [    2.908379][    T1] init: Loaded kernel module /lib/modules/gcc-sdm845.ko
> [    2.915635][    T1] init: Loading module /lib/modules/gcc-sm8250.ko with args ''
> [    2.925162][    T1] init: Loaded kernel module /lib/modules/gcc-sm8250.ko
> [    2.932317][    T1] init: Loading module /lib/modules/gcc-sm8450.ko with args ''
> [    2.941493][    T1] init: Loaded kernel module /lib/modules/gcc-sm8450.ko
> [    2.948566][    T1] init: Loading module /lib/modules/gpi.ko with args ''
> [    2.957183][    T1] gpi 800000.dma-controller: Adding to iommu group 2
> [    2.965177][    T1] gpi a00000.dma-controller: Adding to iommu group 3
> [    2.972921][    T1] init: Loaded kernel module /lib/modules/gpi.ko
> [    2.979425][    T1] init: Loading module /lib/modules/gpio-regulator.ko with args ''
> [    2.988751][    T1] init: Loaded kernel module /lib/modules/gpio-regulator.ko
> [    2.996170][    T1] init: Loading module /lib/modules/gpio-wcd934x.ko with args ''
> [    3.005150][    T1] init: Loaded kernel module /lib/modules/gpio-wcd934x.ko
> [    3.012388][    T1] init: Loading module /lib/modules/gpu-sched.ko with args ''
> [    3.022386][    T1] init: Loaded kernel module /lib/modules/gpu-sched.ko
> [    3.029357][    T1] init: Loading module /lib/modules/gpucc-sdm845.ko with args ''
> [    3.039503][    T1] init: Loaded kernel module /lib/modules/gpucc-sdm845.ko
> [    3.040663][    T9] arm-smmu 5040000.iommu: probing hardware configuration...
> [    3.046775][    T1] init: Loading module /lib/modules/gpucc-sm8250.ko with args ''
> [    3.053765][    T9] arm-smmu 5040000.iommu: SMMUv2 with:
> [    3.053803][    T9] arm-smmu 5040000.iommu:  stage 1 translation
> [    3.072866][    T9] arm-smmu 5040000.iommu:  address translation ops
> [    3.073188][    T1] init: Loaded kernel module /lib/modules/gpucc-sm8250.ko
> [    3.079289][    T9] arm-smmu 5040000.iommu:  non-coherent table walk
> [    3.079295][    T9] arm-smmu 5040000.iommu:  (IDR0.CTTW overridden by FW configuration)
> [    3.086526][    T1] init: Loading module /lib/modules/i2c-designware-core.ko with args ''
> [    3.092740][    T9] arm-smmu 5040000.iommu:  stream matching with 5 register groups
> [    3.116844][    T9] arm-smmu 5040000.iommu:  5 context banks (0 stage-2 only)
> [    3.117058][    T1] init: Loaded kernel module /lib/modules/i2c-designware-core.ko
> [    3.124085][    T9] arm-smmu 5040000.iommu:  Supported page sizes: 0x63315000
> [    3.131902][    T1] init: Loading module /lib/modules/i2c-designware-platform.ko with args ''
> [    3.138901][    T9] arm-smmu 5040000.iommu:  Stage-1: 48-bit VA -> 36-bit IPA
> [    3.154924][    T9] arm-smmu 5040000.iommu:  preserved 0 boot mappings
> [    3.155407][    T1] init: Loaded kernel module /lib/modules/i2c-designware-platform.ko
> [    3.169795][    T1] init: Loading module /lib/modules/i2c-dev.ko with args ''
> [    3.178782][    T1] i2c_dev: i2c /dev entries driver
> [    3.183882][    T1] init: Loaded kernel module /lib/modules/i2c-dev.ko
> [    3.190857][    T1] init: Loading module /lib/modules/i2c-mux.ko with args ''
> [    3.199623][    T1] init: Loaded kernel module /lib/modules/i2c-mux.ko
> [    3.206256][    T1] init: Loading module /lib/modules/i2c-mux-pca954x.ko with args ''
> [    3.215650][    T1] init: Loaded kernel module /lib/modules/i2c-mux-pca954x.ko
> [    3.223156][    T1] init: Loading module /lib/modules/i2c-qcom-geni.ko with args ''
> [    3.232581][    T1] init: Loaded kernel module /lib/modules/i2c-qcom-geni.ko
> [    3.239902][    T1] init: Loading module /lib/modules/i2c-qup.ko with args ''
> [    3.248691][    T1] init: Loaded kernel module /lib/modules/i2c-qup.ko
> [    3.255499][    T1] init: Loading module /lib/modules/i2c-rk3x.ko with args ''
> [    3.264489][    T1] init: Loaded kernel module /lib/modules/i2c-rk3x.ko
> [    3.271378][    T1] init: Loading module /lib/modules/icc-bcm-voter.ko with args ''
> [    3.280566][    T1] init: Loaded kernel module /lib/modules/icc-bcm-voter.ko
> [    3.287911][    T1] init: Loading module /lib/modules/icc-osm-l3.ko with args ''
> [    3.297109][    T1] init: Loaded kernel module /lib/modules/icc-osm-l3.ko
> [    3.304177][    T1] init: Loading module /lib/modules/icc-rpmh.ko with args ''
> [    3.312738][    T1] init: Loaded kernel module /lib/modules/icc-rpmh.ko
> [    3.319630][    T1] init: Loading module /lib/modules/leds-qcom-lpg.ko with args ''
> [    3.329005][    T1] init: Loaded kernel module /lib/modules/leds-qcom-lpg.ko
> [    3.336322][    T1] init: Loading module /lib/modules/llcc-qcom.ko with args ''
> [    3.345963][    T1] init: Loaded kernel module /lib/modules/llcc-qcom.ko
> [    3.352940][    T1] init: Loading module /lib/modules/lmh.ko with args ''
> [    3.362931][    T1] init: Loaded kernel module /lib/modules/lmh.ko
> [    3.369379][    T1] init: Loading module /lib/modules/lontium-lt9611.ko with args ''
> [    3.378911][    T1] init: Loaded kernel module /lib/modules/lontium-lt9611.ko
> [    3.386328][    T1] init: Loading module /lib/modules/lontium-lt9611uxc.ko with args ''
> [    3.396125][    T1] init: Loaded kernel module /lib/modules/lontium-lt9611uxc.ko
> [    3.403800][    T1] init: Loading module /lib/modules/lpass-gfm-sm8250.ko with args ''
> [    3.413179][    T1] init: Loaded kernel module /lib/modules/lpass-gfm-sm8250.ko
> [    3.420767][    T1] init: Loading module /lib/modules/mcp251xfd.ko with args ''
> [    3.430371][    T1] init: Loaded kernel module /lib/modules/mcp251xfd.ko
> [    3.437332][    T1] init: Loading module /lib/modules/mdt_loader.ko with args ''
> [    3.446277][    T1] init: Loaded kernel module /lib/modules/mdt_loader.ko
> [    3.453335][    T1] init: Loading module /lib/modules/michael_mic.ko with args ''
> [    3.464249][    T1] init: Loaded kernel module /lib/modules/michael_mic.ko
> [    3.471471][    T1] init: Loading module /lib/modules/msm.ko with args ''
> [    3.502292][    T1] init: Loaded kernel module /lib/modules/msm.ko
> [    3.508828][    T1] init: Loading module /lib/modules/msm_serial.ko with args ''
> [    3.518289][    T1] msm_serial: driver initialized
> [    3.523223][    T1] init: Loaded kernel module /lib/modules/msm_serial.ko
> [    3.530331][    T1] init: Loading module /lib/modules/mxl692.ko with args ''
> [    3.539121][    T1] init: Loaded kernel module /lib/modules/mxl692.ko
> [    3.545851][    T1] init: Loading module /lib/modules/nvmem_qfprom.ko with args ''
> [    3.555677][    T1] init: Loaded kernel module /lib/modules/nvmem_qfprom.ko
> [    3.562969][    T1] init: Loading module /lib/modules/ohci-hcd.ko with args ''
> [    3.572242][    T1] ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
> [    3.579279][    T1] init: Loaded kernel module /lib/modules/ohci-hcd.ko
> [    3.586374][    T1] init: Loading module /lib/modules/ohci-pci.ko with args ''
> [    3.595099][    T1] ohci-pci: OHCI PCI platform driver
> [    3.600378][    T1] init: Loaded kernel module /lib/modules/ohci-pci.ko
> [    3.607318][    T1] init: Loading module /lib/modules/ohci-platform.ko with args ''
> [    3.616410][    T1] ohci-platform: OHCI generic platform driver
> [    3.622611][    T1] init: Loaded kernel module /lib/modules/ohci-platform.ko
> [    3.629947][    T1] init: Loading module /lib/modules/phy-qcom-qmp-combo.ko with args ''
> [    3.639939][    T1] init: Loaded kernel module /lib/modules/phy-qcom-qmp-combo.ko
> [    3.647710][    T1] init: Loading module /lib/modules/phy-qcom-qmp-pcie-msm8996.ko with args ''
> [    3.658157][    T1] init: Loaded kernel module /lib/modules/phy-qcom-qmp-pcie-msm8996.ko
> [    3.666535][    T1] init: Loading module /lib/modules/phy-qcom-qmp-pcie.ko with args ''
> [    3.676641][    T1] init: Loaded kernel module /lib/modules/phy-qcom-qmp-pcie.ko
> [    3.684314][    T1] init: Loading module /lib/modules/phy-qcom-qmp-ufs.ko with args ''
> [    3.694192][    T1] init: Loaded kernel module /lib/modules/phy-qcom-qmp-ufs.ko
> [    3.701793][    T1] init: Loading module /lib/modules/phy-qcom-qmp-usb.ko with args ''
> [    3.711879][    T1] init: Loaded kernel module /lib/modules/phy-qcom-qmp-usb.ko
> [    3.719467][    T1] init: Loading module /lib/modules/phy-qcom-qusb2.ko with args ''
> [    3.729170][    T1] init: Loaded kernel module /lib/modules/phy-qcom-qusb2.ko
> [    3.736588][    T1] init: Loading module /lib/modules/phy-qcom-snps-femto-v2.ko with args ''
> [    3.746698][    T1] init: Loaded kernel module /lib/modules/phy-qcom-snps-femto-v2.ko
> [    3.754985][    T1] init: Loading module /lib/modules/ulpi.ko with args ''
> [    3.763553][    T1] init: Loaded kernel module /lib/modules/ulpi.ko
> [    3.769925][    T1] init: Loading module /lib/modules/phy-qcom-usb-hs.ko with args ''
> [    3.779292][    T1] init: Loaded kernel module /lib/modules/phy-qcom-usb-hs.ko
> [    3.786798][    T1] init: Loading module /lib/modules/pinctrl-lpass-lpi.ko with args ''
> [    3.796286][    T1] init: Loaded kernel module /lib/modules/pinctrl-lpass-lpi.ko
> [    3.803950][    T1] init: Loading module /lib/modules/pinctrl-msm.ko with args ''
> [    3.813209][    T1] init: Loaded kernel module /lib/modules/pinctrl-msm.ko
> [    3.820453][    T1] init: Loading module /lib/modules/pinctrl-sdm845.ko with args ''
> [    3.829899][    T1] init: Loaded kernel module /lib/modules/pinctrl-sdm845.ko
> [    3.837326][    T1] init: Loading module /lib/modules/pinctrl-sm8250-lpass-lpi.ko with args ''
> [    3.847570][    T1] init: Loaded kernel module /lib/modules/pinctrl-sm8250-lpass-lpi.ko
> [    3.855903][    T1] init: Loading module /lib/modules/pinctrl-sm8250.ko with args ''
> [    3.865426][    T1] init: Loaded kernel module /lib/modules/pinctrl-sm8250.ko
> [    3.872845][    T1] init: Loading module /lib/modules/pinctrl-sm8450.ko with args ''
> [    3.882369][    T1] init: Loaded kernel module /lib/modules/pinctrl-sm8450.ko
> [    3.889832][    T1] init: Loading module /lib/modules/pinctrl-spmi-gpio.ko with args ''
> [    3.900488][    T1] init: Loaded kernel module /lib/modules/pinctrl-spmi-gpio.ko
> [    3.908175][    T1] init: Loading module /lib/modules/pinctrl-spmi-mpp.ko with args ''
> [    3.917975][    T1] init: Loaded kernel module /lib/modules/pinctrl-spmi-mpp.ko
> [    3.925569][    T1] init: Loading module /lib/modules/pm8916_wdt.ko with args ''
> [    3.934487][    T1] init: Loaded kernel module /lib/modules/pm8916_wdt.ko
> [    3.941539][    T1] init: Loading module /lib/modules/pm8941-pwrkey.ko with args ''
> [    3.950879][    T1] init: Loaded kernel module /lib/modules/pm8941-pwrkey.ko
> [    3.958385][    T1] init: Loading module /lib/modules/q6core.ko with args ''
> [    3.966981][    T1] init: Loaded kernel module /lib/modules/q6core.ko
> [    3.973712][    T1] init: Loading module /lib/modules/q6afe.ko with args ''
> [    3.982665][    T1] init: Loaded kernel module /lib/modules/q6afe.ko
> [    3.989301][    T1] init: Loading module /lib/modules/snd-q6dsp-common.ko with args ''
> [    3.998795][    T1] init: Loaded kernel module /lib/modules/snd-q6dsp-common.ko
> [    4.006219][    T1] init: Loading module /lib/modules/q6adm.ko with args ''
> [    4.014887][    T1] init: Loaded kernel module /lib/modules/q6adm.ko
> [    4.021567][    T1] init: Loading module /lib/modules/q6afe-clocks.ko with args ''
> [    4.030736][    T1] init: Loaded kernel module /lib/modules/q6afe-clocks.ko
> [    4.037992][    T1] init: Loading module /lib/modules/q6afe-dai.ko with args ''
> [    4.047029][    T1] init: Loaded kernel module /lib/modules/q6afe-dai.ko
> [    4.054259][    T1] init: Loading module /lib/modules/snd-q6apm.ko with args ''
> [    4.064046][    T1] init: Loaded kernel module /lib/modules/snd-q6apm.ko
> [    4.070850][    T1] init: Loading module /lib/modules/q6apm-dai.ko with args ''
> [    4.079681][    T1] init: Loaded kernel module /lib/modules/q6apm-dai.ko
> [    4.086667][    T1] init: Loading module /lib/modules/q6apm-lpass-dais.ko with args ''
> [    4.096175][    T1] init: Loaded kernel module /lib/modules/q6apm-lpass-dais.ko
> [    4.103968][    T1] init: Loading module /lib/modules/q6asm.ko with args ''
> [    4.112996][    T1] init: Loaded kernel module /lib/modules/q6asm.ko
> [    4.119639][    T1] init: Loading module /lib/modules/q6routing.ko with args ''
> [    4.130143][    T1] init: Loaded kernel module /lib/modules/q6routing.ko
> [    4.136964][    T1] init: Loading module /lib/modules/q6asm-dai.ko with args ''
> [    4.146129][    T1] init: Loaded kernel module /lib/modules/q6asm-dai.ko
> [    4.153327][    T1] init: Loading module /lib/modules/q6prm.ko with args ''
> [    4.161841][    T1] init: Loaded kernel module /lib/modules/q6prm.ko
> [    4.168296][    T1] init: Loading module /lib/modules/q6prm-clocks.ko with args ''
> [    4.177325][    T1] init: Loaded kernel module /lib/modules/q6prm-clocks.ko
> [    4.184580][    T1] init: Loading module /lib/modules/qcom-apcs-ipc-mailbox.ko with args ''
> [    4.195079][    T1] init: Loaded kernel module /lib/modules/qcom-apcs-ipc-mailbox.ko
> [    4.203111][    T1] init: Loading module /lib/modules/qcom-cpufreq-hw.ko with args ''
> [    4.213166][    T1] init: Loaded kernel module /lib/modules/qcom-cpufreq-hw.ko
> [    4.220790][    T1] init: Loading module /lib/modules/qcom-ipcc.ko with args ''
> [    4.229686][    T1] init: Loaded kernel module /lib/modules/qcom-ipcc.ko
> [    4.236653][    T1] init: Loading module /lib/modules/qcom-pdc.ko with args ''
> [    4.246036][    T1] init: Loaded kernel module /lib/modules/qcom-pdc.ko
> [    4.252940][    T1] init: Loading module /lib/modules/qcom-pmic-typec.ko with args ''
> [    4.262376][    T1] init: Loaded kernel module /lib/modules/qcom-pmic-typec.ko
> [    4.270082][    T1] init: Loading module /lib/modules/reboot-mode.ko with args ''
> [    4.279098][    T1] init: Loaded kernel module /lib/modules/reboot-mode.ko
> [    4.286080][    T1] init: Loading module /lib/modules/qcom-pon.ko with args ''
> [    4.294909][    T1] init: Loaded kernel module /lib/modules/qcom-pon.ko
> [    4.301802][    T1] init: Loading module /lib/modules/qcom-qca639x.ko with args ''
> [    4.310897][    T1] init: Loaded kernel module /lib/modules/qcom-qca639x.ko
> [    4.318160][    T1] init: Loading module /lib/modules/qcom-rpmh-regulator.ko with args ''
> [    4.328592][    T1] bob: Setting 3312000-3600000uV
> [    4.334898][    T1] init: Loaded kernel module /lib/modules/qcom-rpmh-regulator.ko
> [    4.336801][    T9] smps3: Setting 1352000-1352000uV
> [    4.342970][    T1] init: Loading module /lib/modules/qcom-vadc-common.ko with args ''
> [    4.347748][    T9] smps5: Setting 1904000-2040000uV
> [    4.360765][    T9] smps7: Setting 900000-1028000uV
> [    4.361260][    T1] init: Loaded kernel module /lib/modules/qcom-vadc-common.ko
> [    4.365889][    T9] ldo1: Setting 880000-880000uV
> [    4.373114][    T1] init: Loading module /lib/modules/qcom-spmi-adc-tm5.ko with args ''
> [    4.378043][    T9] ldo5: Setting 800000-800000uV
> [    4.390908][    T9] ldo12: Setting 1800000-1800000uV
> [    4.391373][    T1] init: Loaded kernel module /lib/modules/qcom-spmi-adc-tm5.ko
> [    4.396146][    T9] ldo7: Setting 1800000-1800000uV
> [    4.403611][    T1] init: Loading module /lib/modules/qcom-spmi-adc5.ko with args ''
> [    4.408534][    T9] ldo13: Setting 1800000-2960000uV
> [    4.421763][    T9] ldo17: Setting 1304000-1304000uV
> [    4.421860][    T1] init: Loaded kernel module /lib/modules/qcom-spmi-adc5.ko
> [    4.427496][    T9] ldo20: Setting 2960000-2968000uV
> [    4.434361][    T1] init: Loading module /lib/modules/regmap-spmi.ko with args ''
> [    4.439757][    T9] ldo21: Setting 2960000-2968000uV
> [    4.452275][    T1] init: Loaded kernel module /lib/modules/regmap-spmi.ko
> [    4.452369][    T9] ldo24: Setting 3088000-3088000uV
> [    4.459256][    T1] init: Loading module /lib/modules/qcom-spmi-pmic.ko with args ''
> [    4.465014][    T9] ldo25: Setting 3300000-3312000uV
> [    4.477842][    T1] init: Loaded kernel module /lib/modules/qcom-spmi-pmic.ko
> [    4.478141][    T9] ldo26: Setting 1200000-1200000uV
> [    4.485252][    T1] init: Loading module /lib/modules/qcom-spmi-temp-alarm.ko with args ''
> [    4.494238][    T9] qcom-qmp-pcie-phy 1c06000.phy: Registered Qcom-QMP phy
> [    4.506036][    T1] init: Loaded kernel module /lib/modules/qcom-spmi-temp-alarm.ko
> [    4.506128][    T9] qcom-qmp-pcie-phy 1c0a000.phy: Registered Qcom-QMP phy
> [    4.513971][    T1] init: Loading module /lib/modules/qcom-wdt.ko with args ''
> [    4.521260][    T9] qcom-qmp-ufs-phy 1d87000.phy: Registered Qcom-QMP phy
> [    4.535673][    T9] qcom-qmp-usb-phy 88e9000.phy: Registered Qcom-QMP phy
> [    4.535974][    T1] init: Loaded kernel module /lib/modules/qcom-wdt.ko
> [    4.543130][    T9] qcom-qmp-usb-phy 88eb000.phy: Registered Qcom-QMP phy
> [    4.549426][    T1] init: Loading module /lib/modules/qcom_aoss.ko with args ''
> [    4.556610][    T9] qcom-qusb2-phy 88e2000.phy: Registered Qcom-QUSB2 phy
> [    4.570815][    T9] qcom-qusb2-phy 88e3000.phy: Registered Qcom-QUSB2 phy
> [    4.572284][    T1] init: Loaded kernel module /lib/modules/qcom_aoss.ko
> [    4.578216][    T9] ath10k_snoc 18800000.wifi: Adding to iommu group 4
> [    4.584690][    T1] init: Loading module /lib/modules/qcom_glink_rpm.ko with args ''
> [    4.595169][    T9] ath10k_snoc 18800000.wifi: supply vdd-3.3-ch1 not found, using dummy regulator
> [    4.608132][    T9] ath10k_snoc 18800000.wifi: failed to register wlfw qmi client: -517
> [    4.608613][    T1] init: Loaded kernel module /lib/modules/qcom_glink_rpm.ko
> [    4.623638][    T1] init: Loading module /lib/modules/qcom_hwspinlock.ko with args ''
> [    4.633115][    T1] init: Loaded kernel module /lib/modules/qcom_hwspinlock.ko
> [    4.640612][    T1] init: Loading module /lib/modules/qcom_pil_info.ko with args ''
> [    4.649430][    T1] init: Loaded kernel module /lib/modules/qcom_pil_info.ko
> [    4.656939][    T1] init: Loading module /lib/modules/qcom_sysmon.ko with args ''
> [    4.666331][    T1] init: Loaded kernel module /lib/modules/qcom_sysmon.ko
> [    4.673309][    T1] init: Loading module /lib/modules/qcom_q6v5.ko with args ''
> [    4.682308][    T1] init: Loaded kernel module /lib/modules/qcom_q6v5.ko
> [    4.689300][    T1] init: Loading module /lib/modules/qcom_q6v5_adsp.ko with args ''
> [    4.699073][    T1] init: Loaded kernel module /lib/modules/qcom_q6v5_adsp.ko
> [    4.706511][    T1] init: Loading module /lib/modules/qcom_q6v5_mss.ko with args ''
> [    4.716783][    T1] init: Loaded kernel module /lib/modules/qcom_q6v5_mss.ko
> [    4.724127][    T1] init: Loading module /lib/modules/qcom_q6v5_pas.ko with args ''
> [    4.734606][    T1] init: Loaded kernel module /lib/modules/qcom_q6v5_pas.ko
> [    4.741955][    T1] init: Loading module /lib/modules/qcom_q6v5_wcss.ko with args ''
> [    4.751678][    T1] init: Loaded kernel module /lib/modules/qcom_q6v5_wcss.ko
> [    4.759095][    T1] init: Loading module /lib/modules/qcom_rpm.ko with args ''
> [    4.768083][    T1] init: Loaded kernel module /lib/modules/qcom_rpm.ko
> [    4.774978][    T1] init: Loading module /lib/modules/qcom_spmi-regulator.ko with args ''
> [    4.784967][    T1] init: Loaded kernel module /lib/modules/qcom_spmi-regulator.ko
> [    4.792813][    T1] init: Loading module /lib/modules/qcom_tsens.ko with args ''
> [    4.819826][    T1] init: Loaded kernel module /lib/modules/qcom_tsens.ko
> [    4.821131][    T9] qcom-pcie 1c00000.pci: Adding to iommu group 5
> [    4.826930][    T1] init: Loading module /lib/modules/qcom_usb_vbus-regulator.ko with args ''
> [    4.833392][    T9] qcom-pcie 1c00000.pci: supply vdda not found, using dummy regulator
> [    4.849962][    T9] qcom-pcie 1c00000.pci: host bridge /soc@0/pci@1c00000 ranges:
> [    4.850434][    T1] init: Loaded kernel module /lib/modules/qcom_usb_vbus-regulator.ko
> [    4.857556][    T9] qcom-pcie 1c00000.pci:       IO 0x0060200000..0x00602fffff -> 0x0060200000
> [    4.865748][    T1] init: Loading module /lib/modules/qnoc-sdm845.ko with args ''
> [    4.874221][    T9] qcom-pcie 1c00000.pci:      MEM 0x0060300000..0x0060ffffff -> 0x0060300000
> [    4.897902][    T1] init: Loaded kernel module /lib/modules/qnoc-sdm845.ko
> [    4.905085][    T1] init: Loading module /lib/modules/qnoc-sm8250.ko with args ''
> [    4.914553][    T1] init: Loaded kernel module /lib/modules/qnoc-sm8250.ko
> [    4.921706][    T1] init: Loading module /lib/modules/qnoc-sm8450.ko with args ''
> [    4.931089][    T1] init: Loaded kernel module /lib/modules/qnoc-sm8450.ko
> [    4.938410][    T1] init: Loading module /lib/modules/qrtr.ko with args ''
> [    4.947672][    T1] NET: Registered PF_QIPCRTR protocol family
> [    4.953701][    T1] init: Loaded kernel module /lib/modules/qrtr.ko
> [    4.960058][    T1] init: Loading module /lib/modules/qrtr-mhi.ko with args ''
> [    4.968423][    T1] init: Loaded kernel module /lib/modules/qrtr-mhi.ko
> [    4.975297][    T1] init: Loading module /lib/modules/qrtr-smd.ko with args ''
> [    4.984016][    T1] init: Loaded kernel module /lib/modules/qrtr-smd.ko
> [    4.990893][    T1] init: Loading module /lib/modules/qrtr-tun.ko with args ''
> [    4.999422][    T1] init: Loaded kernel module /lib/modules/qrtr-tun.ko
> [    5.006458][    T1] init: Loading module /lib/modules/soundwire-bus.ko with args ''
> [    5.007147][    T9] qcom-pcie 1c00000.pci: iATU unroll: disabled
> [    5.020249][    T9] qcom-pcie 1c00000.pci: iATU regions: 32 ob, 8 ib, align 4K, limit 4G
> [    5.029516][    T1] init: Loaded kernel module /lib/modules/soundwire-bus.ko
> [    5.036666][    T1] init: Loading module /lib/modules/regmap-sdw.ko with args ''
> [    5.045240][    T1] init: Loaded kernel module /lib/modules/regmap-sdw.ko
> [    5.052481][    T1] init: Loading module /lib/modules/slimbus.ko with args ''
> [    5.061588][    T1] init: Loaded kernel module /lib/modules/slimbus.ko
> [    5.068213][    T1] init: Loading module /lib/modules/regmap-slimbus.ko with args ''
> [    5.077134][    T1] init: Loaded kernel module /lib/modules/regmap-slimbus.ko
> [    5.084534][    T1] init: Loading module /lib/modules/reset-qcom-aoss.ko with args ''
> [    5.093891][    T1] init: Loaded kernel module /lib/modules/reset-qcom-aoss.ko
> [    5.101368][    T1] init: Loading module /lib/modules/reset-qcom-pdc.ko with args ''
> [    5.110739][    T1] init: Loaded kernel module /lib/modules/reset-qcom-pdc.ko
> [    5.118145][    T1] init: Loading module /lib/modules/rmtfs_mem.ko with args ''
> [    5.128708][    T9] qcom-pcie 1c00000.pci: PCIe Gen.2 x1 link up
> [    5.129325][    T1] init: Loaded kernel module /lib/modules/rmtfs_mem.ko
> [    5.134871][    T9] qcom-pcie 1c00000.pci: PCI host bridge to bus 0000:00
> [    5.141735][    T1] init: Loading module /lib/modules/rpmhpd.ko with args ''
> [    5.148379][    T9] pci_bus 0000:00: root bus resource [bus 00-ff]
> [    5.161720][    T9] pci_bus 0000:00: root bus resource [io  0x0000-0xfffff] (bus address [0x60200000-0x602fffff])
> [    5.166777][    T1] init: Loaded kernel module /lib/modules/rpmhpd.ko
> [    5.172068][    T9] pci_bus 0000:00: root bus resource [mem 0x60300000-0x60ffffff]
> [    5.172095][    T9] pci 0000:00:00.0: [17cb:0106] type 01 class 0x060400
> [    5.178791][    T1] init: Loading module /lib/modules/rpmsg_char.ko with args ''
> [    5.186206][    T9] pci 0000:00:00.0: reg 0x10: [mem 0x00000000-0x00000fff]
> [    5.207475][    T9] pci 0000:00:00.0: PME# supported from D0 D3hot D3cold
> [    5.207688][    T1] init: Loaded kernel module /lib/modules/rpmsg_char.ko
> [    5.219294][    T9] pci 0000:01:00.0: [1912:0014] type 00 class 0x0c0330
> [    5.221377][    T1] init: Loading module /lib/modules/rpmsg_ns.ko with args ''
> [    5.228062][    T9] pci 0000:01:00.0: reg 0x10: [mem 0x00000000-0x00001fff 64bit]
> [    5.243286][    T1] init: Loaded kernel module /lib/modules/rpmsg_ns.ko
> [    5.243436][    T9] pci 0000:01:00.0: PME# supported from D0 D3hot D3cold
> [    5.250155][    T1] init: Loading module /lib/modules/rtc-pm8xxx.ko with args ''
> [    5.265883][    T1] init: Loaded kernel module /lib/modules/rtc-pm8xxx.ko
> [    5.269358][    T9] pci 0000:00:00.0: BAR 14: assigned [mem 0x60300000-0x603fffff]
> [    5.272942][    T1] init: Loading module /lib/modules/sdhci-msm.ko with args ''
> [    5.280364][    T9] pci 0000:00:00.0: BAR 0: assigned [mem 0x60400000-0x60400fff]
> [    5.295272][    T9] pci 0000:01:00.0: BAR 0: assigned [mem 0x60300000-0x60301fff 64bit]
> [    5.296224][   T11] sdhci_msm 8804000.mmc: Adding to iommu group 6
> [    5.303412][    T9] pci 0000:00:00.0: PCI bridge to [bus 01-ff]
> [    5.310515][   T11] sdhci_msm 8804000.mmc: Got CD GPIO
> [    5.315568][    T9] pci 0000:00:00.0:   bridge window [mem 0x60300000-0x603fffff]
> [    5.328441][    T9] pcieport 0000:00:00.0: Adding to iommu group 5
> [    5.334835][    T9] pcieport 0000:00:00.0: PME: Signaling with IRQ 131
> [    5.343575][    T9] pcieport 0000:00:00.0: AER: enabled with IRQ 131
> [    5.350124][    T9] pci 0000:01:00.0: enabling device (0000 -> 0002)
> [    5.356732][    T9] xhci_hcd 0000:01:00.0: Adding to iommu group 5
> [    5.356752][   T11] irq: IRQ132: trimming hierarchy from :soc@0:interrupt-controller@b220000-9
> [    5.371756][    T9] xhci_hcd 0000:01:00.0: xHCI Host Controller
> [    5.372801][   T11] mmc0: SDHCI controller on 8804000.mmc [8804000.mmc] using ADMA 64-bit
> [    5.377757][    T9] xhci_hcd 0000:01:00.0: new USB bus registered, assigned bus number 1
> [    5.386330][    T1] init: Loaded kernel module /lib/modules/sdhci-msm.ko
> [    5.394200][    T9] xhci_hcd 0000:01:00.0: Zeroing 64bit base registers, expecting fault
> [    5.401172][    T1] init: Loading module /lib/modules/slim-qcom-ngd-ctrl.ko with args ''
> [    5.419240][    T1] qcom,slim-ngd-ctrl 171c0000.slim: Adding to iommu group 0
> [    5.428487][    T1] init: Loaded kernel module /lib/modules/slim-qcom-ngd-ctrl.ko
> [    5.436259][    T1] init: Loading module /lib/modules/smp2p.ko with args ''
> [    5.444755][    T1] init: Loaded kernel module /lib/modules/smp2p.ko
> [    5.446563][    T9] xhci_hcd 0000:01:00.0: hcc params 0x014051cf hci version 0x100 quirks 0x0000001100000410
> [    5.451367][    T1] init: Loading module /lib/modules/smsm.ko with args ''
> [    5.461912][    T9] xhci_hcd 0000:01:00.0: xHCI Host Controller
> [    5.473985][    T9] xhci_hcd 0000:01:00.0: new USB bus registered, assigned bus number 2
> [    5.474555][    T1] init: Loaded kernel module /lib/modules/smsm.ko
> [    5.482154][    T9] xhci_hcd 0000:01:00.0: Host supports USB 3.0 SuperSpeed
> [    5.488671][    T1] init: Loading module /lib/modules/snd-soc-dmic.ko with args ''
> [    5.495616][    T9] usb usb1: New USB device found, idVendor=1d6b, idProduct=0002, bcdDevice= 6.00
> [    5.512139][    T9] usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
> [    5.520122][    T9] usb usb1: Product: xHCI Host Controller
> [    5.520397][    T1] init: Loaded kernel module /lib/modules/snd-soc-dmic.ko
> [    5.525743][    T9] usb usb1: Manufacturer: Linux 6.0.0-mainline-06186-ga0de42dfac25 xhci-hcd
> [    5.525749][    T9] usb usb1: SerialNumber: 0000:01:00.0
> [    5.532966][    T1] init: Loading module /lib/modules/snd-soc-hdmi-codec.ko with args ''
> [    5.541587][    T9] hub 1-0:1.0: USB hub found
> [    5.559383][    T9] hub 1-0:1.0: 4 ports detected
> [    5.559587][    T1] init: Loaded kernel module /lib/modules/snd-soc-hdmi-codec.ko
> [    5.564551][    T9] usb usb2: We don't know the algorithms for LPM for this host, disabling LPM.
> [    5.571883][    T1] init: Loading module /lib/modules/snd-soc-lpass-macro-common.ko with args ''
> [    5.580602][    T9] usb usb2: New USB device found, idVendor=1d6b, idProduct=0003, bcdDevice= 6.00
> [    5.598508][    T9] usb usb2: New USB device strings: Mfr=3, Product=2, SerialNumber=1
> [    5.598973][    T1] init: Loaded kernel module /lib/modules/snd-soc-lpass-macro-common.ko
> [    5.606492][    T9] usb usb2: Product: xHCI Host Controller
> [    5.614925][    T1] init: Loading module /lib/modules/snd-soc-lpass-va-macro.ko with args ''
> [    5.620348][    T9] usb usb2: Manufacturer: Linux 6.0.0-mainline-06186-ga0de42dfac25 xhci-hcd
> [    5.620353][    T9] usb usb2: SerialNumber: 0000:01:00.0
> [    5.643039][    T9] hub 2-0:1.0: USB hub found
> [    5.643182][    T1] init: Loaded kernel module /lib/modules/snd-soc-lpass-va-macro.ko
> [    5.647564][    T9] hub 2-0:1.0: 4 ports detected
> [    5.655628][    T1] init: Loading module /lib/modules/snd-soc-lpass-wsa-macro.ko with args ''
> [    5.660933][    T9] qcom-pcie 1c08000.pci: Adding to iommu group 7
> [    5.675421][    T9] qcom-pcie 1c08000.pci: supply vdda not found, using dummy regulator
> [    5.675815][    T1] init: Loaded kernel module /lib/modules/snd-soc-lpass-wsa-macro.ko
> [    5.683576][    T9] qcom-pcie 1c08000.pci: supply vddpe-3v3 not found, using dummy regulator
> [    5.691680][    T1] init: Loading module /lib/modules/snd-soc-max98927.ko with args ''
> [    5.700101][    T9] qcom-pcie 1c08000.pci: host bridge /soc@0/pci@1c08000 ranges:
> [    5.715584][    T9] qcom-pcie 1c08000.pci:       IO 0x0040200000..0x00402fffff -> 0x0040200000
> [    5.716002][    T1] init: Loaded kernel module /lib/modules/snd-soc-max98927.ko
> [    5.724455][    T9] qcom-pcie 1c08000.pci:      MEM 0x0040300000..0x005fffffff -> 0x0040300000
> [    5.731841][    T1] init: Loading module /lib/modules/snd-soc-qcom-common.ko with args ''
> [    5.749785][    T1] init: Loaded kernel module /lib/modules/snd-soc-qcom-common.ko
> [    5.757629][    T1] init: Loading module /lib/modules/snd-soc-rl6231.ko with args ''
> [    5.766837][    T1] init: Loaded kernel module /lib/modules/snd-soc-rl6231.ko
> [    5.774236][    T1] init: Loading module /lib/modules/snd-soc-rt5663.ko with args ''
> [    5.783896][    T1] init: Loaded kernel module /lib/modules/snd-soc-rt5663.ko
> [    5.791297][    T1] init: Loading module /lib/modules/snd-soc-sdm845.ko with args ''
> [    5.800910][    T1] init: Loaded kernel module /lib/modules/snd-soc-sdm845.ko
> [    5.808315][    T1] init: Loading module /lib/modules/snd-soc-sm8250.ko with args ''
> [    5.817396][    T1] init: Loaded kernel module /lib/modules/snd-soc-sm8250.ko
> [    5.824793][    T1] init: Loading module /lib/modules/snd-soc-wcd-mbhc.ko with args ''
> [    5.834569][    T1] init: Loaded kernel module /lib/modules/snd-soc-wcd-mbhc.ko
> [    5.842155][    T1] init: Loading module /lib/modules/snd-soc-wcd9335.ko with args ''
> [    5.849436][   T56] usb 1-1: new low-speed USB device number 2 using xhci_hcd
> [    5.858356][    T1] init: Loaded kernel module /lib/modules/snd-soc-wcd9335.ko
> [    5.859705][    T9] qcom-pcie 1c08000.pci: iATU unroll: disabled
> [    5.865870][    T1] init: Loading module /lib/modules/snd-soc-wcd934x.ko with args ''
> [    5.871779][    T9] qcom-pcie 1c08000.pci: iATU regions: 8 ob, 8 ib, align 4K, limit 1024G
> [    5.888874][    T1] init: Loaded kernel module /lib/modules/snd-soc-wcd934x.ko
> [    5.896387][    T1] init: Loading module /lib/modules/snd-soc-wsa881x.ko with args ''
> [    5.905790][    T1] init: Loaded kernel module /lib/modules/snd-soc-wsa881x.ko
> [    5.913277][    T1] init: Loading module /lib/modules/socinfo.ko with args ''
> [    5.921945][    T1] init: Loaded kernel module /lib/modules/socinfo.ko
> [    5.928730][    T1] init: Loading module /lib/modules/soundwire-qcom.ko with args ''
> [    5.938482][    T1] init: Loaded kernel module /lib/modules/soundwire-qcom.ko
> [    5.945883][    T1] init: Loading module /lib/modules/spi-geni-qcom.ko with args ''
> [    5.955278][    T1] init: Loaded kernel module /lib/modules/spi-geni-qcom.ko
> [    5.962579][    T1] init: Loading module /lib/modules/spi-pl022.ko with args ''
> [    5.983599][    T1] init: Loaded kernel module /lib/modules/spi-pl022.ko
> [    5.990676][    T1] init: Loading module /lib/modules/spi-qcom-qspi.ko with args ''
> [    5.999875][    T1] init: Loaded kernel module /lib/modules/spi-qcom-qspi.ko
> [    6.007220][    T1] init: Loading module /lib/modules/spi-qup.ko with args ''
> [    6.016027][    T1] init: Loaded kernel module /lib/modules/spi-qup.ko
> [    6.022812][    T1] init: Loading module /lib/modules/spm.ko with args ''
> [    6.031221][    T1] init: Loaded kernel module /lib/modules/spm.ko
> [    6.037710][    T1] init: Loading module /lib/modules/spmi-pmic-arb.ko with args ''
> [    6.047100][    T1] spmi spmi-0: PMIC arbiter version v5 (0x50000000)
> [    6.059463][    T1] gpio gpiochip1: (c440000.spmi:pmic@0:gpios@c000): not an immutable chip, please consider fixing it!
> [    6.072225][    T1] gpio gpiochip2: (c440000.spmi:pmic@2:gpios@c000): not an immutable chip, please consider fixing it!
> [    6.083116][   T56] usb 1-1: New USB device found, idVendor=17ef, idProduct=602e, bcdDevice= 1.00
> [    6.086869][    T1] init: Loaded kernel module /lib/modules/spmi-pmic-arb.ko
> [    6.092071][   T56] usb 1-1: New USB device strings: Mfr=1, Product=2, SerialNumber=0
> [    6.092078][   T56] usb 1-1: Product: USB Optical Mouse
> [    6.092083][   T56] usb 1-1: Manufacturer: PixArt
> [    6.111271][   T56] input: PixArt USB Optical Mouse as /devices/platform/soc@0/1c00000.pci/pci0000:00/0000:00:00.0/0000:01:00.0/usb1/1-1/1-1:1.0/0003:17EF:602E.0001/input/input0
> [    6.112638][    T1] init: Loading module /lib/modules/syscon-reboot-mode.ko with args ''
> [    6.117331][   T56] hid-generic 0003:17EF:602E.0001: input,hidraw0: USB HID v1.11 Mouse [PixArt USB Optical Mouse] on usb-0000:01:00.0-1/input0
> [    6.154513][    T1] init: Loaded kernel module /lib/modules/syscon-reboot-mode.ko
> [    6.162274][    T1] init: Loading module /lib/modules/ufs_qcom.ko with args ''
> [    6.171687][    T1] ufshcd-qcom 1d84000.ufshc: Adding to iommu group 8
> [    6.178519][  T188] usb 2-3: new SuperSpeed USB device number 2 using xhci_hcd
> [    6.180315][    T1] ufshcd-qcom 1d84000.ufshc: ufshcd_populate_vreg: Unable to find vdd-hba-supply regulator, assuming enabled
> [    6.197328][    T1] ufshcd-qcom 1d84000.ufshc: ufshcd_populate_vreg: Unable to find vccq-supply regulator, assuming enabled
> [    6.208548][    T1] ufshcd-qcom 1d84000.ufshc: ufshcd_populate_vreg: Unable to find vccq2-supply regulator, assuming enabled
> [    6.217709][  T188] usb 2-3: New USB device found, idVendor=0b95, idProduct=1790, bcdDevice= 1.00
> [    6.221874][    T1] ufshcd-qcom 1d84000.ufshc: Found QC Inline Crypto Engine (ICE) v3.1.75
> [    6.228790][  T188] usb 2-3: New USB device strings: Mfr=1, Product=2, SerialNumber=3
> [    6.228798][  T188] usb 2-3: Product: AX88179
> [    6.239021][    T1] scsi host0: ufshcd
> [    6.245020][  T188] usb 2-3: Manufacturer: ASIX Elec. Corp.
> [    6.245025][  T188] usb 2-3: SerialNumber: 00000000000001
> [    6.388970][   T11] scsi 0:0:0:49488: Well-known LUN    SAMSUNG  KLUCG4J1ED-B0C1  0200 PQ: 0 ANSI: 6
> [    6.402987][   T11] scsi 0:0:0:49476: Well-known LUN    SAMSUNG  KLUCG4J1ED-B0C1  0200 PQ: 0 ANSI: 6
> [    6.415101][   T11] scsi 0:0:0:49456: Well-known LUN    SAMSUNG  KLUCG4J1ED-B0C1  0200 PQ: 0 ANSI: 6
> [    6.427993][   T11] scsi 0:0:0:0: Direct-Access     SAMSUNG  KLUCG4J1ED-B0C1  0200 PQ: 0 ANSI: 6
> [    6.439903][   T11] scsi 0:0:0:1: Direct-Access     SAMSUNG  KLUCG4J1ED-B0C1  0200 PQ: 0 ANSI: 6
> [    6.440360][  T162] sd 0:0:0:0: [sda] 14145536 4096-byte logical blocks: (57.9 GB/54.0 GiB)
> [    6.452493][   T11] scsi 0:0:0:2: Direct-Access     SAMSUNG  KLUCG4J1ED-B0C1  0200 PQ: 0 ANSI: 6
> [    6.454481][  T196] sd 0:0:0:1: [sdb] 1024 4096-byte logical blocks: (4.19 MB/4.00 MiB)
> [    6.455526][  T196] sd 0:0:0:1: [sdb] Write Protect is off
> [    6.457336][  T162] sd 0:0:0:0: [sda] Write Protect is off
> [    6.457532][  T196] sd 0:0:0:1: [sdb] Write cache: enabled, read cache: enabled, supports DPO and FUA
> [    6.457543][  T196] sd 0:0:0:1: [sdb] Preferred minimum I/O size 8192 bytes
> [    6.457550][  T196] sd 0:0:0:1: [sdb] Optimal transfer size 8192 bytes
> [    6.467380][   T11] scsi 0:0:0:3: Direct-Access     SAMSUNG  KLUCG4J1ED-B0C1  0200 PQ: 0 ANSI: 6
> [    6.469386][  T197] sd 0:0:0:2: [sdc] 1024 4096-byte logical blocks: (4.19 MB/4.00 MiB)
> [    6.470434][  T197] sd 0:0:0:2: [sdc] Write Protect is off
> [    6.472339][  T197] sd 0:0:0:2: [sdc] Write cache: enabled, read cache: enabled, supports DPO and FUA
> [    6.472349][  T197] sd 0:0:0:2: [sdc] Preferred minimum I/O size 8192 bytes
> [    6.472355][  T197] sd 0:0:0:2: [sdc] Optimal transfer size 8192 bytes
> [    6.474428][  T162] sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, supports DPO and FUA
> [    6.484278][   T11] scsi 0:0:0:4: Direct-Access     SAMSUNG  KLUCG4J1ED-B0C1  0200 PQ: 0 ANSI: 6
> [    6.484553][   T76] sd 0:0:0:3: [sdd] 32768 4096-byte logical blocks: (134 MB/128 MiB)
> [    6.484751][   T76] sd 0:0:0:3: [sdd] Write Protect is off
> [    6.485195][  T162] sd 0:0:0:0: [sda] Preferred minimum I/O size 8192 bytes
> [    6.485201][  T162] sd 0:0:0:0: [sda] Optimal transfer size 8192 bytes
> [    6.485490][   T76] sd 0:0:0:3: [sdd] Write cache: enabled, read cache: enabled, supports DPO and FUA
> [    6.485498][   T76] sd 0:0:0:3: [sdd] Preferred minimum I/O size 8192 bytes
> [    6.485504][   T76] sd 0:0:0:3: [sdd] Optimal transfer size 8192 bytes
> [    6.486665][  T196]  sdb: sdb1 sdb2
> [    6.486894][  T196] sd 0:0:0:1: [sdb] Attached SCSI disk
> [    6.504654][   T11] scsi 0:0:0:5: Direct-Access     SAMSUNG  KLUCG4J1ED-B0C1  0200 PQ: 0 ANSI: 6
> [    6.505476][  T199] sd 0:0:0:4: [sde] 1048576 4096-byte logical blocks: (4.29 GB/4.00 GiB)
> [    6.506044][  T199] sd 0:0:0:4: [sde] Write Protect is off
> [    6.506893][  T199] sd 0:0:0:4: [sde] Write cache: enabled, read cache: enabled, supports DPO and FUA
> [    6.506903][  T199] sd 0:0:0:4: [sde] Preferred minimum I/O size 8192 bytes
> [    6.506909][  T199] sd 0:0:0:4: [sde] Optimal transfer size 8192 bytes
> [    6.514662][  T197]  sdc: sdc1 sdc2
> [    6.518298][  T198] sd 0:0:0:5: [sdf] 393216 4096-byte logical blocks: (1.61 GB/1.50 GiB)
> [    6.525214][  T197] sd 0:0:0:2: [sdc] Attached SCSI disk
> [    6.530603][  T198] sd 0:0:0:5: [sdf] Write Protect is off
> [    6.544041][   T76]  sdd: sdd1 sdd2 sdd3
> [    6.546985][  T198] sd 0:0:0:5: [sdf] Write cache: enabled, read cache: enabled, supports DPO and FUA
> [    6.553715][   T76] sd 0:0:0:3: [sdd] Attached SCSI disk
> [    6.557693][  T162]  sda: sda1 sda2 sda3 sda4 sda5 sda6 sda7 sda8 sda9 sda10
> [    6.558285][  T162] sd 0:0:0:0: [sda] Attached SCSI disk
> [    6.559837][  T199]  sde: sde1 sde2 sde3 sde4 sde5 sde6 sde7 sde8 sde9 sde10 sde11 sde12 sde13 sde14 sde15 sde16 sde17 sde18 sde19 sde20 sde21 sde22 sde23 sde24 sde25 sde26 sde27 sde28 sde29 sde30 sde31 sde32 sde33 sde34 sde35 sde36 sde37 sde38 sde39 sde40 sde41 sde42 sde43 sde44 sde45 sde46 sde47 sde48
> [    6.562340][  T199] sd 0:0:0:4: [sde] Attached SCSI disk
> [    6.562731][  T198] sd 0:0:0:5: [sdf] Preferred minimum I/O size 8192 bytes
> [    6.562736][  T198] sd 0:0:0:5: [sdf] Optimal transfer size 8192 bytes
> [    6.637144][  T188] ax88179_178a 2-3:1.0 eth0: register 'ax88179_178a' at usb-0000:01:00.0-3, ASIX AX88179 USB 3.0 Gigabit Ethernet, 00:0e:c6:81:79:01
> [    6.797029][  T198]  sdf: sdf1 sdf2 sdf3 sdf4 sdf5 sdf6 sdf7 sdf8 sdf9
> [    6.804156][  T198] sd 0:0:0:5: [sdf] Attached SCSI disk
> [    6.810044][    T1] init: Loaded kernel module /lib/modules/ufs_qcom.ko
> [    6.817029][    T1] init: Loading module /lib/modules/v4l2-mem2mem.ko with args ''
> [    6.828196][    T1] init: Loaded kernel module /lib/modules/v4l2-mem2mem.ko
> [    6.835445][    T1] init: Loading module /lib/modules/venus-core.ko with args ''
> [    6.847843][    T1] init: Loaded kernel module /lib/modules/venus-core.ko
> [    6.855116][    T1] init: Loading module /lib/modules/videobuf2-dma-contig.ko with args ''
> [    6.864839][    T1] init: Loaded kernel module /lib/modules/videobuf2-dma-contig.ko
> [    6.872593][    T1] init: Loading module /lib/modules/venus-dec.ko with args ''
> [    6.882058][    T1] init: Loaded kernel module /lib/modules/venus-dec.ko
> [    6.889013][    T9] qcom-pcie 1c08000.pci: Phy link never came up
> [    6.889038][    T1] init: Loading module /lib/modules/venus-enc.ko with args ''
> [    6.895283][    T9] qcom-pcie 1c08000.pci: PCI host bridge to bus 0001:00
> [    6.909379][    T9] pci_bus 0001:00: root bus resource [bus 00-ff]
> [    6.910021][    T1] init: Loaded kernel module /lib/modules/venus-enc.ko
> [    6.915625][    T9] pci_bus 0001:00: root bus resource [io  0x100000-0x1fffff] (bus address [0x40200000-0x402fffff])
> [    6.922588][    T1] init: Loading module /lib/modules/videocc-sdm845.ko with args ''
> [    6.933011][    T9] pci_bus 0001:00: root bus resource [mem 0x40300000-0x5fffffff]
> [    6.948450][    T9] pci 0001:00:00.0: [17cb:0107] type 01 class 0x060400
> [    6.955224][    T9] pci 0001:00:00.0: reg 0x10: [mem 0x00000000-0x00000fff]
> [    6.956966][    T1] init: Loaded kernel module /lib/modules/videocc-sdm845.ko
> [    6.962300][    T9] pci 0001:00:00.0: PME# supported from D0 D3hot D3cold
> [    6.969652][    T1] init: Loading module /lib/modules/videocc-sm8250.ko with args ''
> [    6.981318][    T9] pci 0001:00:00.0: BAR 14: assigned [mem 0x40300000-0x404fffff]
> [    6.991728][    T9] pci 0001:00:00.0: BAR 15: assigned [mem 0x40500000-0x406fffff 64bit pref]
> [    6.992358][    T1] init: Loaded kernel module /lib/modules/videocc-sm8250.ko
> [    7.000327][    T9] pci 0001:00:00.0: BAR 0: assigned [mem 0x40700000-0x40700fff]
> [    7.007723][    T1] init: Loading module /lib/modules/wcd934x.ko with args ''
> [    7.015060][    T9] pci 0001:00:00.0: BAR 13: assigned [io  0x100000-0x100fff]
> [    7.029541][    T9] pci 0001:00:00.0: PCI bridge to [bus 01-ff]
> [    7.030064][    T1] init: Loaded kernel module /lib/modules/wcd934x.ko
> [    7.035518][    T9] pci 0001:00:00.0:   bridge window [io  0x100000-0x100fff]
> [    7.035526][    T9] pci 0001:00:00.0:   bridge window [mem 0x40300000-0x404fffff]
> [    7.042456][    T1] init: Loading module /lib/modules/zsmalloc.ko with args ''
> [    7.049288][    T9] pci 0001:00:00.0:   bridge window [mem 0x40500000-0x406fffff 64bit pref]
> [    7.072775][    T9] pcieport 0001:00:00.0: Adding to iommu group 7
> [    7.073121][    T1] init: Loaded kernel module /lib/modules/zsmalloc.ko
> [    7.079245][    T9] pcieport 0001:00:00.0: PME: Signaling with IRQ 149
> [    7.085785][    T1] init: Loading module /lib/modules/zram.ko with args ''
> [    7.093738][    T9] pcieport 0001:00:00.0: AER: enabled with IRQ 149
> [    7.105985][    T9] geni_se_qup 8c0000.geniqup: Adding to iommu group 9
> [    7.106457][    T1] zram: Added device: zram0
> [    7.117142][    T1] init: Loaded kernel module /lib/modules/zram.ko
> [    7.118885][    T9] spi_master spi0: will run message pump with realtime priority
> [    7.124245][    T1] init: Loaded 193 kernel modules took 5001 ms
> [    7.137400][    T1] init: Copied ramdisk prop to /second_stage_resources/system/etc/ramdisk/build.prop
> [    7.145703][    T9] mcp251xfd spi0.0 can0: MCP2517FD rev0.0 (-RX_INT -PLL +MAB_NO_WARN +CRC_REG +CRC_RX +CRC_TX +ECC -HD o:40.00MHz c:40.00MHz m:10.00MHz rs:10.00MHz es:0.00MHz rf:10.00MHz ef:0.00MHz) successfully initialized.
> [    7.147059][    T1] init: [libfs_mgr]ReadFstabFromDt(): failed to read fstab from dt
> [    7.174455][    T9] 898000.serial: ttyHS0 at MMIO 0x898000 (irq = 153, base_baud = 0) is a MSM
> [    7.175840][    T1] init: Using Android DT directory /proc/device-tree/firmware/android/
> [    7.184564][    T9] serial serial0: tty port ttyHS0 registered
> [    7.191665][    T1] init: Failed to read vbmeta partitions.
> [    7.198349][    T9] geni_se_qup ac0000.geniqup: Adding to iommu group 10
> [    7.200450][  T200] Bluetooth: hci0: setting up wcn399x
> [    7.218712][    T9] a84000.serial: ttyMSM0 at MMIO 0xa84000 (irq = 154, base_baud = 0) is a MSM
> b??????[    7.276674][    T1] EXT4-fs: Ignoring removed nomblk_io_submit option
> [    7.280446][    T1] EXT4-fs (sda9): mounted filesystem with ordered data mode. Quota mode: none.
> [    7.283288][    T9] printk: console [ttyMSM0] enabled
> [    7.292184][    T1] init: [libfs_mgr]check_fs(): mount(/dev/block/platform/soc@0/1d84000.ufshc/by-name/metadata,/metadata,ext4)=0: Success
> [    7.280446][    T1] EXT4-fs (sda9): mounted filesystem with ordered data mode. Quota mode: none.
> [    7.297214][    T9] printk: bootconsole [qcom_geni0] disabled
> [    7.283288][    T9] printk: console [ttyMSM0] enabled
> [    7.292184][    T1] init: [libfs_mgr]check_fs(): mount(/dev/block/platform/soc@0/1d84000.ufshc/by-name/metadata,/metadata,ext4)=0: Success
> [    7.334056][  T200] Bluetooth: hci0: QCA Product ID   :0x0000000a
> [    7.297214][    T9] printk: bootconsole [qcom_geni0] disabled
> [    7.334056][  T200] Bluetooth: hci0: QCA Product ID   :0x0000000a
> [    7.360083][  T200] Bluetooth: hci0: QCA SOC Version  :0x40010214
> [    7.360087][  T200] Bluetooth: hci0: QCA ROM Version  :0x00000201
> [    7.360090][  T200] Bluetooth: hci0: QCA Patch Version:0x00000001
> [    7.361446][    T1] EXT4-fs (sda9): unmounting filesystem.
> [    7.371572][    T9] i2c 10-003b: Fixing up cyclic dependency with hdmi-out
> [    7.376017][    T1] init: [libfs_mgr]umount_retry(): unmount(/metadata) succeeded
> [    7.380725][  T200] Bluetooth: hci0: QCA controller version 0x02140201
> [    7.384916][    T1] init: [libfs_mgr]Not running /system/bin/e2fsck on /dev/block/sda9 (executable not in system image)
> [    7.387668][    T9] dwc3 a600000.usb: Adding to iommu group 11
> [    7.391768][  T200] Bluetooth: hci0: QCA Downloading qca/crbtfw21.tlv
> [    7.395745][    T9] dwc3 a800000.usb: Adding to iommu group 12
> [    7.398183][    T9] xhci-hcd xhci-hcd.0.auto: xHCI Host Controller
> [    7.398199][    T9] xhci-hcd xhci-hcd.0.auto: new USB bus registered, assigned bus number 3
> [    7.398357][    T9] xhci-hcd xhci-hcd.0.auto: hcc params 0x0230fe65 hci version 0x110 quirks 0x0000002002010010
> [    7.398400][    T9] xhci-hcd xhci-hcd.0.auto: irq 167, io mem 0x0a800000
> [    7.398533][    T9] xhci-hcd xhci-hcd.0.auto: xHCI Host Controller
> [    7.398550][    T9] xhci-hcd xhci-hcd.0.auto: new USB bus registered, assigned bus number 4
> [    7.398559][    T9] xhci-hcd xhci-hcd.0.auto: Host supports USB 3.0 SuperSpeed
> [    7.398682][    T9] usb usb3: New USB device found, idVendor=1d6b, idProduct=0002, bcdDevice= 6.00
> [    7.398691][    T9] usb usb3: New USB device strings: Mfr=3, Product=2, SerialNumber=1
> [    7.398697][    T9] usb usb3: Product: xHCI Host Controller
> [    7.398702][    T9] usb usb3: Manufacturer: Linux 6.0.0-mainline-06186-ga0de42dfac25 xhci-hcd
> [    7.398707][    T9] usb usb3: SerialNumber: xhci-hcd.0.auto
> [    7.398988][    T9] hub 3-0:1.0: USB hub found
> [    7.399010][    T9] hub 3-0:1.0: 1 port detected
> [    7.399254][    T9] usb usb4: We don't know the algorithms for LPM for this host, disabling LPM.
> [    7.399320][    T9] usb usb4: New USB device found, idVendor=1d6b, idProduct=0003, bcdDevice= 6.00
> [    7.401560][    T1] EXT4-fs (sda9): mounted filesystem with ordered data mode. Quota mode: none.
> [    7.401620][    T1] init: [libfs_mgr]__mount(source=/dev/block/platform/soc@0/1d84000.ufshc/by-name/metadata,target=/metadata,type=ext4)=0: Success
> [    7.402273][    T1] init: Failed to copy /avb into /metadata/gsi/dsu/avb/: No such file or directory
> [    7.405995][  T200] bluetooth hci0: Direct firmware load for qca/crbtfw21.tlv failed with error -2
> [    7.416771][    T9] usb usb4: New USB device strings: Mfr=3, Product=2, SerialNumber=1
> [    7.416778][    T9] usb usb4: Product: xHCI Host Controller
> [    7.422676][  T200] Bluetooth: hci0: QCA Failed to request file: qca/crbtfw21.tlv (-2)
> [    7.429279][    T9] usb usb4: Manufacturer: Linux 6.0.0-mainline-06186-ga0de42dfac25 xhci-hcd
> [    7.435243][  T200] Bluetooth: hci0: QCA Failed to download patch (-2)
> [    7.441319][    T9] usb usb4: SerialNumber: xhci-hcd.0.auto
> [    7.635604][    T9] hub 4-0:1.0: USB hub found
> [    7.640116][    T9] hub 4-0:1.0: 1 port detected
> [    7.650939][    T9] input: gpio-keys as /devices/platform/gpio-keys/input/input1
> [    7.660928][    T9] adreno 5000000.gpu: Adding to iommu group 13
> [    7.667802][    T9] msm-mdss ae00000.mdss: Adding to iommu group 14
> [    7.676088][    T9] platform ae94000.dsi: Fixing up cyclic dependency with 10-003b
> [    7.683908][    T9] platform ae94000.dsi: Fixing up cyclic dependency with ae01000.display-controller
> [    7.703785][    T9] cpu cpu0: EM: created perf domain
> [    7.717554][    T9] cpu cpu4: EM: created perf domain
> [    7.727770][    T9] ath10k_snoc 18800000.wifi: supply vdd-3.3-ch1 not found, using dummy regulator
> [    7.742932][    T9] input: pm8941_pwrkey as /devices/platform/soc@0/c440000.spmi/spmi-0/0-00/c440000.spmi:pmic@0:pon@800/c440000.spmi:pmic@0:pon@800:pwrkey/input/input2
> [    7.759055][    T9] input: pm8941_resin as /devices/platform/soc@0/c440000.spmi/spmi-0/0-00/c440000.spmi:pmic@0:pon@800/c440000.spmi:pmic@0:pon@800:resin/input/input3
> [    7.774760][    T9] rtc-pm8xxx c440000.spmi:pmic@0:rtc@6000: registered as rtc0
> [    7.782256][    T9] rtc-pm8xxx c440000.spmi:pmic@0:rtc@6000: setting system clock to 1970-01-01T00:13:05 UTC (785)
> [    7.792890][    T9] qcom-venus aa00000.video-codec: Adding to iommu group 15
> [    7.800189][    T9] qcom-venus aa00000.video-codec: non legacy binding
> [    8.050276][    T9] lt9611 10-003b: LT9611 revision: 0xe1
> [    8.056742][    T9] lt9611 10-003b: failed to find dsi host
> [    8.065427][    T9] remoteproc remoteproc0: 4080000.remoteproc is available
> [    8.073335][    T9] remoteproc remoteproc1: remoteproc-adsp is available
> [    8.082720][    T9] remoteproc remoteproc2: remoteproc-cdsp is available
> [    8.082806][   T59] remoteproc remoteproc1: powering up remoteproc-adsp
> [    8.090184][  T221] remoteproc remoteproc2: powering up remoteproc-cdsp
> [    8.096163][   T59] remoteproc remoteproc1: Booting fw image qcom/sdm845/adsp.mbn, size 10420560
> [    8.111702][  T221] remoteproc remoteproc2: Booting fw image qcom/sdm845/cdsp.mbn, size 2704916
> [    8.209388][   T59] remoteproc remoteproc1: remote processor remoteproc-adsp is now up
> [    8.211239][  T231] qcom,fastrpc-cb remoteproc-adsp:glink-edge:fastrpc:compute-cb@3: Adding to iommu group 16
> [    8.228646][  T231] qcom,fastrpc-cb remoteproc-adsp:glink-edge:fastrpc:compute-cb@4: Adding to iommu group 17
> [    8.239065][  T221] remoteproc remoteproc2: remote processor remoteproc-cdsp is now up
> [    8.241409][   T17] qcom,fastrpc-cb remoteproc-cdsp:glink-edge:fastrpc:compute-cb@1: Adding to iommu group 18
> [    8.260131][   T17] qcom,fastrpc-cb remoteproc-cdsp:glink-edge:fastrpc:compute-cb@2: Adding to iommu group 19
> [    8.270990][   T17] qcom,fastrpc-cb remoteproc-cdsp:glink-edge:fastrpc:compute-cb@3: Adding to iommu group 20
> [    8.281862][   T17] qcom,fastrpc-cb remoteproc-cdsp:glink-edge:fastrpc:compute-cb@4: Adding to iommu group 21
> [    8.292693][   T17] qcom,fastrpc-cb remoteproc-cdsp:glink-edge:fastrpc:compute-cb@5: Adding to iommu group 22
> [    8.303188][    T9] lt9611 10-003b: LT9611 revision: 0xe1
> [    8.303517][   T17] qcom,fastrpc-cb remoteproc-cdsp:glink-edge:fastrpc:compute-cb@6: Adding to iommu group 23
> [    8.319516][    T9] msm_dpu ae01000.display-controller: bound ae94000.dsi (ops dsi_ops [msm])
> [    8.319732][   T17] qcom,fastrpc-cb remoteproc-cdsp:glink-edge:fastrpc:compute-cb@7: Adding to iommu group 24
> [    8.329070][    T9] adreno 5000000.gpu: supply vdd not found, using dummy regulator
> [    8.338743][   T17] qcom,fastrpc-cb remoteproc-cdsp:glink-edge:fastrpc:compute-cb@8: Adding to iommu group 25
> [    8.345945][    T9] adreno 5000000.gpu: supply vddcx not found, using dummy regulator
> [    8.365548][   T76] qcom,slim-ngd-ctrl 171c0000.slim: SLIM SAT: Rcvd master capability
> [    8.366247][    T9] platform 506a000.gmu: Adding to iommu group 26
> [    8.374241][   T59] wcd934x-slim 217:250:1:0: there is not valid maps for state default
> [    8.380184][    T9] msm_dpu ae01000.display-controller: bound 5000000.gpu (ops a3xx_ops [msm])
> [    8.402701][    T9] [drm:dpu_kms_hw_init:1067] dpu hardware revision:0x40000000
> [    8.424639][    T9] [drm] Initialized msm 1.9.0 20130625 for ae01000.display-controller on minor 0
> [    8.443396][   T59] wcd934x-slim 217:250:1:0: WCD934x chip id major 0x108, minor 0x1
> [    8.454388][   T59] wcd934x-slim 217:250:1:0: type registers are deprecated; use config registers instead
> [    8.466032][   T59] wcd934x-slim 217:250:1:0: missing qcom,mbhc-buttons-vthreshold-microvolt entry
> [    8.476280][   T59] wcd934x-gpio wcd934x-gpio.4.auto: DMA mask not set
> [    8.483149][   T59] qcom-soundwire wcd934x-soundwire.5.auto: DMA mask not set
> [    8.493981][   T59] wsa881x-codec sdw:0:0217:2010:00:2: nonexclusive access to GPIO for powerdown
> [    8.504905][  T260] qcom-soundwire wcd934x-soundwire.5.auto: qcom_swrm_irq_handler: SWR new slave attached
> [    8.516149][   T59] qcom-soundwire wcd934x-soundwire.5.auto: Qualcomm Soundwire controller v1.3.0 Registered
> [    8.526102][   T59] qcom,slim-ngd-ctrl 171c0000.slim: SLIM controller Registered
> [    8.571176][  T260] qcom-soundwire wcd934x-soundwire.5.auto: qcom_swrm_irq_handler: SWR new slave attached
> [    8.581188][  T260] qcom-soundwire wcd934x-soundwire.5.auto: Slave status not changed 14
> [    8.833057][    C6] random: crng init done
> [    8.839805][    T1] init: [libfs_mgr]Created logical partition system_a on device /dev/block/dm-0
> [    8.848758][    T1] init: [libfs_mgr]Skipping zero-length logical partition: system_b
> [    8.857744][    T1] init: [libfs_mgr]Created logical partition vendor_a on device /dev/block/dm-1
> [    8.866711][    T1] init: [libfs_mgr]Skipping zero-length logical partition: vendor_b
> [    8.876140][    T1] init: [libfs_mgr]Created logical partition system_ext_a on device /dev/block/dm-2
> [    8.885440][    T1] init: [libfs_mgr]Skipping zero-length logical partition: system_ext_b
> [    8.895108][    T1] init: [libfs_mgr]Created logical partition product_a on device /dev/block/dm-3
> [    8.904162][    T1] init: [libfs_mgr]Skipping zero-length logical partition: product_b
> [    8.912277][    T1] init: DSU not detected, proceeding with normal boot
> [    8.920528][    T1] init: [libfs_mgr]superblock s_max_mnt_count:65535,/dev/block/dm-0
> [    8.930340][    T1] EXT4-fs (dm-0): mounted filesystem without journal. Quota mode: none.
> [    8.938628][    T1] init: [libfs_mgr]__mount(source=/dev/block/dm-0,target=/system,type=ext4)=0: Success
> [    8.948346][    T1] init: Switching root to '/system'
> [    8.956208][    T1] init: [libfs_mgr]superblock s_max_mnt_count:65535,/dev/block/dm-1
> [    8.965586][    T1] EXT4-fs (dm-1): mounted filesystem without journal. Quota mode: none.
> [    8.973843][    T1] init: [libfs_mgr]__mount(source=/dev/block/dm-1,target=/vendor,type=ext4)=0: Success
> [    8.984022][    T1] init: [libfs_mgr]superblock s_max_mnt_count:65535,/dev/block/dm-2
> [    8.995583][    T1] EXT4-fs (dm-2): mounted filesystem without journal. Quota mode: none.
> [    9.003843][    T1] init: [libfs_mgr]__mount(source=/dev/block/dm-2,target=/system_ext,type=ext4)=0: Success
> [    9.014303][    T1] init: [libfs_mgr]superblock s_max_mnt_count:65535,/dev/block/dm-3
> [    9.024813][    T1] EXT4-fs (dm-3): mounted filesystem without journal. Quota mode: none.
> [    9.033071][    T1] init: [libfs_mgr]__mount(source=/dev/block/dm-3,target=/product,type=ext4)=0: Success
> [    9.052352][    T1] init: Skipped setting INIT_AVB_VERSION (not in recovery mode)
> [    9.174007][    T1] init: Opening SELinux policy
> [    9.182588][    T1] init: Falling back to standard signature check. TODO implementent support for fsverity SEPolicy.
> [    9.193247][    T1] init: Error: Apex SEPolicy failed signature check
> [    9.199758][    T1] init: Loading APEX Sepolicy from /system/etc/selinux/apex/SEPolicy.zip
> [    9.208107][    T1] init: Failed to open package /system/etc/selinux/apex/SEPolicy.zip: No such file or directory
> [    9.228863][    T1] init: Loading SELinux policy
> [    9.246708][    T1] SELinux:  Permission bpf in class capability2 not defined in policy.
> [    9.254894][    T1] SELinux:  Permission checkpoint_restore in class capability2 not defined in policy.
> [    9.264374][    T1] SELinux:  Permission bpf in class cap2_userns not defined in policy.
> [    9.272530][    T1] SELinux:  Permission checkpoint_restore in class cap2_userns not defined in policy.
> [    9.282041][    T1] SELinux:  Class mctp_socket not defined in policy.
> [    9.288626][    T1] SELinux:  Class io_uring not defined in policy.
> [    9.294951][    T1] SELinux:  Class user_namespace not defined in policy.
> [    9.301793][    T1] SELinux: the above unknown classes and permissions will be denied
> [    9.311861][    T1] SELinux:  policy capability network_peer_controls=1
> [    9.318550][    T1] SELinux:  policy capability open_perms=1
> [    9.324252][    T1] SELinux:  policy capability extended_socket_class=1
> [    9.330915][    T1] SELinux:  policy capability always_check_network=0
> [    9.337494][    T1] SELinux:  policy capability cgroup_seclabel=0
> [    9.343632][    T1] SELinux:  policy capability nnp_nosuid_transition=1
> [    9.350295][    T1] SELinux:  policy capability genfs_seclabel_symlinks=0
> [    9.357132][    T1] SELinux:  policy capability ioctl_skip_cloexec=0
> [    9.474002][   T57] audit: type=1403 audit(787.187:2): auid=4294967295 ses=4294967295 lsm=selinux res=1
> [    9.476348][    T1] selinux: SELinux: Loaded file context from:
> [    9.489479][    T1] selinux: 
> [    9.491118][  T200] Bluetooth: hci0: QCA preshutdown_cmd failed (-56)
> [    9.492469][    T1] selinux:                 /system/etc/selinux/plat_file_contexts
> [    9.492472][    T1] selinux: 
> [    9.492475][    T1] selinux:                 /vendor/etc/selinux/vendor_file_contexts
> [    9.515122][    T1] selinux: 
> [    9.518240][    T1] selinux: SELinux:  Could not stat /dev/selinux: No such file or directory.
> [    9.526922][    T1] selinux: 
> [    9.530343][   T57] audit: type=1404 audit(787.243:3): enforcing=1 old_enforcing=0 auid=4294967295 ses=4294967295 enabled=1 old-enabled=1 lsm=selinux res=1
> [    9.557338][    T1] init: init second stage started!
> [    9.581275][    T1] init: Using Android DT directory /proc/device-tree/firmware/android/
> [    9.592737][    T1] init: Do not have permissions to set 'ro.recovery.usb.vid' to '18D1' in property file '/vendor/build.prop': SELinux permission check failed
> [    9.607119][    T1] init: Do not have permissions to set 'ro.recovery.usb.adb.pid' to 'D001' in property file '/vendor/build.prop': SELinux permission check failed
> [    9.621877][    T1] init: Do not have permissions to set 'ro.recovery.usb.fastboot.pid' to '4EE0' in property file '/vendor/build.prop': SELinux permission check failed
> [    9.637133][    T1] init: Do not have permissions to set 'persist.demo.rotationlock' to '1' in property file '/vendor/build.prop': SELinux permission check failed
> [    9.651800][    T1] init: Do not have permissions to set 'wifi.supplicant_scan_interval' to '15' in property file '/vendor/build.prop': SELinux permission check failed
> [    9.671253][    T1] init: Setting product property ro.product.brand to 'Android' (from ro.product.product.brand)
> [    9.681517][    T1] init: Setting product property ro.product.device to 'db845c' (from ro.product.product.device)
> [    9.691865][    T1] init: Setting product property ro.product.manufacturer to 'unknown' (from ro.product.product.manufacturer)
> [    9.703352][    T1] init: Setting product property ro.product.model to 'db845c' (from ro.product.product.model)
> [    9.713525][    T1] init: Setting product property ro.product.name to 'db845c' (from ro.product.product.name)
> [    9.723529][    T1] init: Setting property 'ro.build.fingerprint' to 'Android/db845c/db845c:UpsideDownCake/AOSP.MASTER/eng.pundir.20221008.160459:userdebug/test-keys'
> [    9.738510][    T1] init: Setting property 'ro.product.cpu.abilist' to 'arm64-v8a,armeabi-v7a,armeabi'
> [    9.747890][    T1] init: Setting property 'ro.product.cpu.abilist32' to 'armeabi-v7a,armeabi'
> [    9.756573][    T1] init: Setting property 'ro.product.cpu.abilist64' to 'arm64-v8a'
> [    9.765468][    T1] selinux: SELinux: Loaded file context from:
> [    9.771442][    T1] selinux: 
> [    9.774443][    T1] selinux:                 /system/etc/selinux/plat_file_contexts
> [    9.780928][    T1] selinux: 
> [    9.783922][    T1] selinux:                 /vendor/etc/selinux/vendor_file_contexts
> [    9.790582][    T1] selinux: 
> [    9.793587][    T1] init: Running restorecon...
> [    9.803781][    T1] init: Created socket '/dev/socket/property_service', mode 666, user 0, group 0
> [    9.816478][    T1] init: SetupMountNamespaces done
> [    9.822220][    T1] init: Forked subcontext for 'u:r:vendor_init:s0' with pid 271
> [    9.830463][    T1] init: Parsing file /system/etc/init/hw/init.rc...
> [    9.837671][    T1] init: Added '/init.environ.rc' to import list
> [    9.843832][    T1] init: Added '/system/etc/init/hw/init.usb.rc' to import list
> [    9.851293][    T1] init: Added '/init.db845c.rc' to import list
> [    9.857351][    T1] init: Added '/vendor/etc/init/hw/init.db845c.rc' to import list
> [    9.865073][    T1] init: Added '/system/etc/init/hw/init.usb.configfs.rc' to import list
> [    9.873315][    T1] init: Added '/system/etc/init/hw/init.zygote64_32.rc' to import list
> [    9.882526][    T1] init: Parsing file /init.environ.rc...
> [    9.888657][    T1] init: Parsing file /system/etc/init/hw/init.usb.rc...
> [    9.896049][    T1] init: Parsing file /init.db845c.rc...
> [    9.901555][    T1] init: Unable to read config file '/init.db845c.rc': open() failed: No such file or directory
> [    9.912171][    T1] init: Parsing file /vendor/etc/init/hw/init.db845c.rc...
> [    9.919286][    T1] init: Unable to read config file '/vendor/etc/init/hw/init.db845c.rc': open() failed: No such file or directory
> [    9.931215][    T1] init: Parsing file /system/etc/init/hw/init.usb.configfs.rc...
> [    9.939534][    T1] init: Parsing file /system/etc/init/hw/init.zygote64_32.rc...
> [    9.947409][    T1] init: Added '/system/etc/init/hw/init.zygote64.rc' to import list
> [    9.955345][    T1] init: Parsing file /system/etc/init/hw/init.zygote64.rc...
> [    9.963014][    T1] init: Parsing directory /system/etc/init...
> [    9.969113][    T1] init: Parsing file /system/etc/init/android.hidl.allocator@1.0-service.rc...
> [    9.978264][    T1] init: Parsing file /system/etc/init/android.system.suspend@1.0-service.rc...
> [    9.987489][    T1] init: Parsing file /system/etc/init/apexd.rc...
> [    9.994177][    T1] init: Parsing file /system/etc/init/atrace.rc...
> [   10.001675][    T1] init: Parsing file /system/etc/init/atrace_userdebug.rc...
> [   10.009321][    T1] init: Parsing file /system/etc/init/audioserver.rc...
> [   10.016571][    T1] init: Parsing file /system/etc/init/blank_screen.rc...
> [   10.023853][    T1] init: Parsing file /system/etc/init/bootanim.rc...
> [   10.030981][    T1] init: Parsing file /system/etc/init/bootstat-debug.rc...
> [   10.038465][    T1] init: Parsing file /system/etc/init/bootstat.rc...
> [   10.045465][    T1] init: Parsing file /system/etc/init/bpfloader.rc...
> [   10.052472][    T1] init: Parsing file /system/etc/init/cameraserver.rc...
> [   10.059766][    T1] init: Parsing file /system/etc/init/clean_scratch_files.rc...
> [   10.067668][    T1] init: Parsing file /system/etc/init/credstore.rc...
> [   10.074701][    T1] init: Parsing file /system/etc/init/dmesgd.rc...
> [   10.081582][    T1] init: Parsing file /system/etc/init/drmserver.rc...
> [   10.088683][    T1] init: Parsing file /system/etc/init/dumpstate.rc...
> [   10.095703][    T1] init: Parsing file /system/etc/init/eth_mac_addr.rc...
> [   10.102978][    T1] init: Parsing file /system/etc/init/flags_health_check.rc...
> [   10.110765][    T1] init: Parsing file /system/etc/init/gatekeeperd.rc...
> [   10.117936][    T1] init: Parsing file /system/etc/init/gpuservice.rc...
> [   10.125027][    T1] init: Parsing file /system/etc/init/gsid.rc...
> [   10.131807][    T1] init: Parsing file /system/etc/init/heapprofd.rc...
> [   10.138866][    T1] init: Parsing file /system/etc/init/hwservicemanager.rc...
> [   10.146462][    T1] init: Parsing file /system/etc/init/idmap2d.rc...
> [   10.153256][    T1] init: Parsing file /system/etc/init/incidentd.rc...
> [   10.160290][    T1] init: Parsing file /system/etc/init/init-debug.rc...
> [   10.167421][    T1] init: Parsing file /system/etc/init/installd.rc...
> [   10.174437][    T1] init: Parsing file /system/etc/init/keystore2.rc...
> [   10.181426][    T1] init: Parsing file /system/etc/init/llkd-debuggable.rc...
> [   10.188999][    T1] init: Parsing file /system/etc/init/llkd.rc...
> [   10.195611][    T1] init: Parsing file /system/etc/init/lmkd.rc...
> [   10.202245][    T1] init: Parsing file /system/etc/init/logcatd.rc...
> [   10.209127][    T1] init: Parsing file /system/etc/init/logd.rc...
> [   10.215750][    T1] init: Parsing file /system/etc/init/logtagd.rc...
> [   10.222601][    T1] init: Parsing file /system/etc/init/lpdumpd.rc...
> [   10.229463][    T1] init: Parsing file /system/etc/init/mdnsd.rc...
> [   10.236118][    T1] init: Parsing file /system/etc/init/mediaextractor.rc...
> [   10.243582][    T1] init: Parsing file /system/etc/init/mediametrics.rc...
> [   10.250892][    T1] init: Parsing file /system/etc/init/mediaserver.rc...
> [   10.258104][    T1] init: Parsing file /system/etc/init/mtectrl.rc...
> [   10.264957][    T1] init: Parsing file /system/etc/init/mtpd.rc...
> [   10.271546][    T1] init: Parsing file /system/etc/init/netd.rc...
> [   10.278154][    T1] init: Parsing file /system/etc/init/odsign.rc...
> [   10.284922][    T1] init: Parsing file /system/etc/init/perfetto.rc...
> [   10.291944][    T1] init: Parsing file /system/etc/init/prng_seeder.rc...
> [   10.299117][    T1] init: Parsing file /system/etc/init/profcollectd.rc...
> [   10.306404][    T1] init: Parsing file /system/etc/init/racoon.rc...
> [   10.313144][    T1] init: Parsing file /system/etc/init/recovery-persist.rc...
> [   10.320762][    T1] init: Parsing file /system/etc/init/recovery-refresh.rc...
> [   10.328371][    T1] init: Parsing file /system/etc/init/rss_hwm_reset.rc...
> [   10.335732][    T1] init: Parsing file /system/etc/init/servicemanager.rc...
> [   10.343188][    T1] init: Parsing file /system/etc/init/simpleperf.rc...
> [   10.350276][    T1] init: Parsing file /system/etc/init/snapuserd.rc...
> [   10.357294][    T1] init: Parsing file /system/etc/init/storaged.rc...
> [   10.364212][    T1] init: Parsing file /system/etc/init/surfaceflinger.rc...
> [   10.371672][    T1] init: Parsing file /system/etc/init/tombstoned.rc...
> [   10.378771][    T1] init: Parsing file /system/etc/init/traced_perf.rc...
> [   10.385981][    T1] init: Parsing file /system/etc/init/uncrypt.rc...
> [   10.392826][    T1] init: Parsing file /system/etc/init/usbd.rc...
> [   10.399385][    T1] init: Parsing file /system/etc/init/vold.rc...
> [   10.405954][    T1] init: Parsing file /system/etc/init/wifi.rc...
> [   10.412588][    T1] init: Parsing file /system/etc/init/wificond.rc...
> [   10.419528][    T1] init: Parsing file /system_ext/etc/init...
> [   10.425428][    T1] init: Unable to read config file '/system_ext/etc/init': open() failed: No such file or directory
> [   10.436118][    T1] init: Parsing directory /vendor/etc/init...
> [   10.442123][    T1] init: Parsing file /vendor/etc/init/android.hardware.audio.service.rc...
> [   10.450970][    T1] init: Parsing file /vendor/etc/init/android.hardware.bluetooth@1.1-service.btlinux.rc...
> [   10.461207][    T1] init: Parsing file /vendor/etc/init/android.hardware.boot@1.2-service.rc...
> [   10.470340][    T1] init: Parsing file /vendor/etc/init/android.hardware.camera.provider@2.4-external-service.rc...
> [   10.481201][    T1] init: Parsing file /vendor/etc/init/android.hardware.cas@1.2-service.rc...
> [   10.490215][    T1] init: Parsing file /vendor/etc/init/android.hardware.gatekeeper@1.0-service.software.rc...
> [   10.500621][    T1] init: Parsing file /vendor/etc/init/android.hardware.graphics.allocator@4.0-service.minigbm_msm.rc...
> [   10.512004][    T1] init: Parsing file /vendor/etc/init/android.hardware.graphics.composer@2.3-service.rc...
> [   10.522240][    T1] init: Parsing file /vendor/etc/init/android.hardware.health@2.1-service.rc...
> [   10.531518][    T1] init: Parsing file /vendor/etc/init/android.hardware.keymaster@3.0-service.rc...
> [   10.541060][    T1] init: Parsing file /vendor/etc/init/android.hardware.media.omx@1.0-service.rc...
> [   10.550624][    T1] init: Parsing file /vendor/etc/init/boringssl_self_test.rc...
> [   10.558841][    T1] init: Parsing file /vendor/etc/init/hostapd.android.rc...
> [   10.566412][    T1] init: Parsing file /vendor/etc/init/init.db845c.rc...
> [   10.573608][    T1] init: Added 'init.db845c.usb.rc' to import list
> [   10.579931][    T1] init: Added 'init.db845c.power.rc' to import list
> [   10.586541][    T1] init: Parsing file init.db845c.usb.rc...
> [   10.592254][    T1] init: Unable to read config file 'init.db845c.usb.rc': open() failed: No such file or directory
> [   10.602773][    T1] init: Parsing file init.db845c.power.rc...
> [   10.608666][    T1] init: Unable to read config file 'init.db845c.power.rc': open() failed: No such file or directory
> [   10.619364][    T1] init: Parsing file /vendor/etc/init/init.db845c.usb.rc...
> [   10.627136][    T1] init: Parsing file /vendor/etc/init/init.qcom.rc...
> [   10.634204][    T1] init: Parsing file /vendor/etc/init/power-default.rc...
> [   10.641576][    T1] init: Parsing file /vendor/etc/init/power.stats-default.rc...
> [   10.649478][    T1] init: Parsing file /odm/etc/init...
> [   10.654755][    T1] init: Unable to read config file '/odm/etc/init': open() failed: No such file or directory
> [   10.664848][    T1] init: Parsing file /product/etc/init...
> [   10.670470][    T1] init: Unable to read config file '/product/etc/init': open() failed: No such file or directory
> [   10.681912][    T1] init: processing action (SetupCgroups) from (<Builtin Action>:0)
> [   10.742038][    T1] init: Command 'SetupCgroups' action=SetupCgroups (<Builtin Action>:0) took 52ms and succeeded
> [   10.758737][    T1] init: processing action (SetKptrRestrict) from (<Builtin Action>:0)
> [   10.766994][    T1] init: processing action (TestPerfEventSelinux) from (<Builtin Action>:0)
> [   10.776567][    T1] init: processing action (ConnectEarlyStageSnapuserd) from (<Builtin Action>:0)
> [   10.785665][    T1] init: processing action (early-init) from (/system/etc/init/hw/init.rc:15)
> [   10.795182][    T1] init: Command 'mkdir /acct/uid' action=early-init (/system/etc/init/hw/init.rc:30) took 0ms and failed: mkdir() failed on /acct/uid: Read-only file system
> [   10.812586][    T1] init: starting service 'exec 1 (/system/bin/bootstrap/linkerconfig --target /linkerconfig/bootstrap)'...
> [   10.839029][    T1] libprocessgroup: Controller io is not found
> [   10.845025][    T1] libprocessgroup: Controller io is not found
> [   10.851002][    T1] libprocessgroup: Controller io is not found
> [   10.857386][    T1] libprocessgroup: SetAttribute: unknown attribute: BfqWeight
> [   10.864772][    T1] libprocessgroup: SetAttribute: unknown attribute: CfqGroupIdle
> [   10.872411][    T1] libprocessgroup: SetAttribute: unknown attribute: CfqWeight
> [   10.879800][    T1] libprocessgroup: SetAttribute: unknown attribute: BfqWeight
> [   10.887178][    T1] libprocessgroup: SetAttribute: unknown attribute: CfqGroupIdle
> [   10.894821][    T1] libprocessgroup: SetAttribute: unknown attribute: CfqWeight
> [   10.902209][    T1] libprocessgroup: SetAttribute: unknown attribute: BfqWeight
> [   10.909575][    T1] libprocessgroup: SetAttribute: unknown attribute: CfqGroupIdle
> [   10.917201][    T1] libprocessgroup: SetAttribute: unknown attribute: CfqWeight
> [   10.924583][    T1] libprocessgroup: SetAttribute: unknown attribute: BfqWeight
> [   10.931948][    T1] libprocessgroup: SetAttribute: unknown attribute: CfqGroupIdle
> [   10.939574][    T1] libprocessgroup: SetAttribute: unknown attribute: CfqWeight
> [   10.966047][    T1] init: SVC_EXEC service 'exec 1 (/system/bin/bootstrap/linkerconfig --target /linkerconfig/bootstrap)' pid 272 (uid 0 gid 0+0 context default) started; waiting...
> [   10.982350][    T1] init: Command 'exec -- /system/bin/bootstrap/linkerconfig --target /linkerconfig/bootstrap' action=early-init (/system/etc/init/hw/init.rc:59) took 170ms and succeeded
> [   10.983775][  T272] linkerconfig: Unable to access VNDK APEX at path: /apex/com.android.vndk.vUpsideDownCake: No such file or directory
> [   11.011681][  T272] linkerconfig: Unable to access VNDK APEX at path: /apex/com.android.vndk.vUpsideDownCake: No such file or directory
> [   11.030195][  T272] linkerconfig (272) used greatest stack depth: 11552 bytes left
> [   11.030940][    T1] init: Service 'exec 1 (/system/bin/bootstrap/linkerconfig --target /linkerconfig/bootstrap)' (pid 272) exited with status 0 waiting took 0.206000 seconds
> [   11.053426][    T1] init: Sending signal 9 to service 'exec 1 (/system/bin/bootstrap/linkerconfig --target /linkerconfig/bootstrap)' (pid 272) process group...
> [   11.067838][    T1] libprocessgroup: Successfully killed process cgroup uid 0 pid 272 in 0ms
> [   11.077079][    T1] init: starting service 'ueventd'...
> [   11.104108][    T1] init: starting service 'apexd-bootstrap'...
> [   11.112478][    T1] init: SVC_EXEC service 'apexd-bootstrap' pid 274 (uid 0 gid 1000+0 context default) started; waiting...
> [   11.138682][  T273] ueventd: ueventd started!
> [   11.147504][  T273] selinux: SELinux: Loaded file context from:
> [   11.153558][  T273] selinux: 
> [   11.156570][  T273] selinux:                 /system/etc/selinux/plat_file_contexts
> [   11.163092][  T273] selinux: 
> [   11.166171][  T273] selinux:                 /vendor/etc/selinux/vendor_file_contexts
> [   11.172878][  T273] selinux: 
> [   11.176121][  T273] ueventd: Parsing file /system/etc/ueventd.rc...
> [   11.182859][  T273] ueventd: Added '/vendor/etc/ueventd.rc' to import list
> [   11.187866][  T274] apexd: Bootstrap subcommand detected
> [   11.189813][  T273] ueventd: Added '/odm/etc/ueventd.rc' to import list
> [   11.190086][  T273] ueventd: Parsing file /vendor/etc/ueventd.rc...
> [   11.195510][  T274] cutils-trace: Error opening trace file: No such file or directory (2)
> [   11.201888][  T273] ueventd: Unable to read config file '/vendor/etc/ueventd.rc': open() failed: No such file or directory
> [   11.208525][  T274] apexd-bootstrap: Scanning /system/apex for pre-installed ApexFiles
> [   11.216462][  T273] ueventd: Parsing file /odm/etc/ueventd.rc...
> [   11.216475][  T273] ueventd: Unable to read config file '/odm/etc/ueventd.rc': open() failed: No such file or directory
> [   11.228544][  T274] apexd-bootstrap: Found pre-installed APEX /system/apex/com.android.cronet.apex
> [   11.235629][  T273] ueventd: Parsing file /vendor/ueventd.rc...
> [   11.244660][  T274] apexd-bootstrap: Found pre-installed APEX /system/apex/com.android.sdkext.apex
> [   11.252758][  T273] ueventd: Parsing file /odm/ueventd.rc...
> [   11.264145][  T274] apexd-bootstrap: Found pre-installed APEX /system/apex/com.android.art.capex
> [   11.267579][  T273] ueventd: Unable to read config file '/odm/ueventd.rc': open() failed: No such file or directory
> [   11.267590][  T273] ueventd: Parsing file /ueventd.db845c.rc...
> [   11.267597][  T273] ueventd: Unable to read config file '/ueventd.db845c.rc': open() failed: No such file or directory
> [   11.321790][  T274] apexd-bootstrap: Found pre-installed APEX /system/apex/com.android.btservices.apex
> [   11.338600][  T274] apexd-bootstrap: Found pre-installed APEX /system/apex/com.android.ipsec.capex
> [   11.349188][  T274] apexd-bootstrap: Found pre-installed APEX /system/apex/com.android.tethering.capex
> [   11.360670][  T274] apexd-bootstrap: Found pre-installed APEX /system/apex/com.android.adbd.capex
> [   11.371284][  T274] apexd-bootstrap: Found pre-installed APEX /system/apex/com.android.tzdata.apex
> [   11.381312][  T274] apexd-bootstrap: Found pre-installed APEX /system/apex/com.android.scheduling.capex
> [   11.392126][  T274] apexd-bootstrap: Found pre-installed APEX /system/apex/com.android.wifi.capex
> [   11.402493][  T274] apexd-bootstrap: Found pre-installed APEX /system/apex/com.android.uwb.capex
> [   11.412757][  T274] apexd-bootstrap: Found pre-installed APEX /system/apex/com.android.ondevicepersonalization.capex
> [   11.424703][  T274] apexd-bootstrap: Found pre-installed APEX /system/apex/com.android.media.swcodec.capex
> [   11.435983][  T274] apexd-bootstrap: Found pre-installed APEX /system/apex/com.android.vndk.current.apex
> [   11.446538][  T274] apexd-bootstrap: Found pre-installed APEX /system/apex/com.android.conscrypt.capex
> [   11.457320][  T274] apexd-bootstrap: Found pre-installed APEX /system/apex/com.android.extservices.capex
> [   11.468312][  T274] apexd-bootstrap: Found pre-installed APEX /system/apex/com.android.media.capex
> [   11.478701][  T274] apexd-bootstrap: Found pre-installed APEX /system/apex/com.android.permission.capex
> [   11.489606][  T274] apexd-bootstrap: Found pre-installed APEX /system/apex/com.android.os.statsd.apex
> [   11.500038][  T274] apexd-bootstrap: Found pre-installed APEX /system/apex/com.android.neuralnetworks.capex
> [   11.511195][  T274] apexd-bootstrap: Found pre-installed APEX /system/apex/com.android.mediaprovider.capex
> [   11.522870][  T274] apexd-bootstrap: Found pre-installed APEX /system/apex/com.android.appsearch.capex
> [   11.531705][  T273] ueventd: Coldboot took 0.263 seconds
> [   11.533835][  T274] apexd-bootstrap: Found pre-installed APEX /system/apex/com.android.runtime.apex
> [   11.547851][  T274] apexd-bootstrap: Found pre-installed APEX /system/apex/com.android.resolv.capex
> [   11.559476][  T274] apexd-bootstrap: Found pre-installed APEX /system/apex/com.android.i18n.apex
> [   11.569493][  T274] apexd-bootstrap: Found pre-installed APEX /system/apex/com.android.adservices.capex
> [   11.580248][  T274] apexd-bootstrap: Scanning /system_ext/apex for pre-installed ApexFiles
> [   11.588605][  T274] apexd-bootstrap: /system_ext/apex does not exist. Skipping
> [   11.595883][  T274] apexd-bootstrap: Scanning /product/apex for pre-installed ApexFiles
> [   11.603963][  T274] apexd-bootstrap: /product/apex does not exist. Skipping
> [   11.610981][  T274] apexd-bootstrap: Scanning /vendor/apex for pre-installed ApexFiles
> [   11.618990][  T274] apexd-bootstrap: /vendor/apex does not exist. Skipping
> [   11.625930][  T274] apexd-bootstrap: Found bootstrap APEX /system/apex/com.android.i18n.apex
> [   11.634435][  T274] apexd-bootstrap: Found bootstrap APEX /system/apex/com.android.runtime.apex
> [   11.643200][  T274] apexd-bootstrap: Found bootstrap APEX /system/apex/com.android.tzdata.apex
> [   11.651880][  T274] apexd-bootstrap: Found bootstrap APEX /system/apex/com.android.vndk.current.apex
> [   11.661100][  T274] apexd-bootstrap: Need to pre-allocate 30 loop devices for 26 APEX packages
> [   11.669824][  T274] apexd-bootstrap: No block apex metadata partition found, not adding block apexes
> [   11.679625][  T274] apexd-bootstrap: Pre-allocated loop device 16
> [   11.686134][  T274] apexd-bootstrap: Pre-allocated loop device 17
> [   11.692619][  T274] apexd-bootstrap: Pre-allocated loop device 18
> [   11.699091][  T274] apexd-bootstrap: Pre-allocated loop device 19
> [   11.705565][  T274] apexd-bootstrap: Pre-allocated loop device 20
> [   11.712074][  T274] apexd-bootstrap: Pre-allocated loop device 21
> [   11.718541][  T274] apexd-bootstrap: Pre-allocated loop device 22
> [   11.725005][  T274] apexd-bootstrap: Pre-allocated loop device 23
> [   11.731488][  T274] apexd-bootstrap: Pre-allocated loop device 24
> [   11.737954][  T274] apexd-bootstrap: Pre-allocated loop device 25
> [   11.744428][  T274] apexd-bootstrap: Pre-allocated loop device 26
> [   11.750894][  T274] apexd-bootstrap: Pre-allocated loop device 27
> [   11.757361][  T274] apexd-bootstrap: Pre-allocated loop device 28
> [   11.763822][  T274] apexd-bootstrap: Pre-allocated loop device 29
> [   11.770294][  T274] apexd-bootstrap: Pre-allocated loop device 30
> [   11.776760][  T274] apexd-bootstrap: Pre-allocated loop device 31
> [   11.783224][  T274] apexd-bootstrap: Pre-allocated loop device 32
> [   11.789714][  T274] apexd-bootstrap: Pre-allocated loop device 33
> [   11.796185][  T274] apexd-bootstrap: Pre-allocated loop device 34
> [   11.802643][  T274] apexd-bootstrap: Pre-allocated loop device 35
> [   11.809123][  T274] apexd-bootstrap: Pre-allocated loop device 36
> [   11.815581][  T274] apexd-bootstrap: Pre-allocated loop device 37
> [   11.822048][  T274] apexd-bootstrap: Pre-allocated loop device 38
> [   11.828515][  T274] apexd-bootstrap: Pre-allocated loop device 39
> [   11.834974][  T274] apexd-bootstrap: Pre-allocated loop device 40
> [   11.841425][  T274] apexd-bootstrap: Pre-allocated loop device 41
> [   11.847893][  T274] apexd-bootstrap: Pre-allocated loop device 42
> [   11.854358][  T274] apexd-bootstrap: Pre-allocated loop device 43
> [   11.860888][  T274] apexd-bootstrap: Pre-allocated loop device 44
> [   11.867353][  T274] apexd-bootstrap: Pre-allocated loop device 45
> [   11.873502][  T274] apexd-bootstrap: Pre-allocated 30 loopback devices
> [   11.891518][  T310] loop0: detected capacity change from 0 to 76584
> [   11.898205][  T311] loop1: detected capacity change from 0 to 16816
> [   11.904795][  T312] loop2: detected capacity change from 0 to 1656
> [   11.907727][  T310] EXT4-fs (loop0): mounted filesystem without journal. Quota mode: none.
> [   11.911176][  T313] loop3: detected capacity change from 0 to 83144
> [   11.911374][  T311] EXT4-fs (loop1): mounted filesystem without journal. Quota mode: none.
> [   11.911487][  T311] apexd-bootstrap: Successfully mounted package /system/apex/com.android.runtime.apex on /apex/com.android.runtime@1 duration=20
> [   11.917399][  T312] EXT4-fs (loop2): mounted filesystem without journal. Quota mode: none.
> [   11.917478][  T312] apexd-bootstrap: Successfully mounted package /system/apex/com.android.tzdata.apex on /apex/com.android.tzdata@339990000 duration=26
> [   11.919416][  T310] apexd-bootstrap: Successfully mounted package /system/apex/com.android.i18n.apex on /apex/com.android.i18n@1 duration=28
> [   11.932309][  T313] EXT4-fs (loop3): mounted filesystem without journal. Quota mode: none.
> [   11.990680][  T313] apexd-bootstrap: Successfully mounted package /system/apex/com.android.vndk.current.apex on /apex/com.android.vndk.vUpsideDownCake@1 duration=99
> [   12.006852][  T274] apexd-bootstrap: Activated 4 packages.
> [   12.015179][  T274] apexd-bootstrap: OnBootstrap done, duration=806
> [   12.023099][    T1] init: Service 'apexd-bootstrap' (pid 274) exited with status 0 waiting took 0.912000 seconds
> [   12.033470][    T1] init: Sending signal 9 to service 'apexd-bootstrap' (pid 274) process group...
> [   12.042807][    T1] libprocessgroup: Successfully killed process cgroup uid 0 pid 274 in 0ms
> [   12.076417][    T1] init: linkerconfig generated /linkerconfig with mounted APEX modules info
> [   12.102493][    T1] init: processing action (early-init) from (/init.environ.rc:2)
> [   12.110585][    T1] init: processing action (ro.product.debugfs_restrictions.enabled=true && early-init) from (/system/etc/init/init-debug.rc:10)
> [   12.125456][    T1] init: processing action (early-init) from (/system/etc/init/prng_seeder.rc:5)
> [   12.135027][    T1] init: starting service 'prng_seeder'...
> [   12.141293][    T1] init: Created socket '/dev/socket/prng_seeder', mode 666, user 1092, group 1092
> [   12.175449][    T1] init: processing action (ro.product.cpu.abilist32=* && early-init) from (/vendor/etc/init/boringssl_self_test.rc:2)
> [   12.176660][    T9] qcom,slim-ngd-ctrl 171c0000.slim: SLIM SAT: Rcvd master capability
> [   12.190849][    T1] init: starting service 'boringssl_self_test32_vendor'...
> [   12.199672][  T260] qcom-soundwire wcd934x-soundwire.5.auto: qcom_swrm_irq_handler: SWR new slave attached
> [   12.204946][    T1] init: SVC_EXEC service 'boringssl_self_test32_vendor' pid 320 (uid 0 gid 0+0 context default) started; waiting...
> [   12.213471][  T260] wsa881x-codec sdw:0:0217:2010:00:2: Slave 1 state check1: UNATTACHED, status was 1
> [   12.234280][  T260] wsa881x-codec sdw:0:0217:2010:00:1: Slave 2 state check1: UNATTACHED, status was 1
> [   12.313863][  T319] prng_seeder: Hanging forever because setup failed: hwrng.read_exact in new
> [   12.313863][  T319] 
> [   12.324818][  T319] Caused by:
> [   12.327958][  T319]     No such device (os error 19)
> [   12.430415][    T1] init: Service 'boringssl_self_test32_vendor' (pid 320) exited with status 0 waiting took 0.226000 seconds
> [   12.441827][    T1] init: Sending signal 9 to service 'boringssl_self_test32_vendor' (pid 320) process group...
> [   12.452100][    T1] libprocessgroup: Successfully killed process cgroup uid 0 pid 320 in 0ms
> [   12.462164][    T1] init: processing action (ro.product.cpu.abilist64=* && early-init) from (/vendor/etc/init/boringssl_self_test.rc:4)
> [   12.475381][    T1] init: starting service 'boringssl_self_test64_vendor'...
> [   12.503749][    T1] init: SVC_EXEC service 'boringssl_self_test64_vendor' pid 321 (uid 0 gid 0+0 context default) started; waiting...
> [   12.568982][    T1] init: Service 'boringssl_self_test64_vendor' (pid 321) exited with status 0 waiting took 0.085000 seconds
> [   12.580427][    T1] init: Sending signal 9 to service 'boringssl_self_test64_vendor' (pid 321) process group...
> [   12.590714][    T1] libprocessgroup: Successfully killed process cgroup uid 0 pid 321 in 0ms
> [   12.600945][    T1] init: processing action (early-init) from (/vendor/etc/init/init.qcom.rc:36)
> [   12.610842][    T1] init: starting service 'set_hw'...
> [   12.636096][    T1] init: starting service 'exec 2 (/vendor/bin/qrtr-cfg 1)'...
> [   12.645287][    T1] init: SVC_EXEC service 'exec 2 (/vendor/bin/qrtr-cfg 1)' pid 323 (uid 0 gid 0+0 context default) started; waiting...
> [   12.666589][    T1] init: Service 'exec 2 (/vendor/bin/qrtr-cfg 1)' (pid 323) exited with status 0 waiting took 0.022000 seconds
> [   12.678285][    T1] init: Sending signal 9 to service 'exec 2 (/vendor/bin/qrtr-cfg 1)' (pid 323) process group...
> [   12.688906][    T1] libprocessgroup: Successfully killed process cgroup uid 0 pid 323 in 0ms
> [   12.698332][    T1] init: starting service 'qrtr-ns'...
> [   12.723792][    T1] init: Service 'set_hw' (pid 322) exited with status 0 oneshot service took 0.106000 seconds in background
> [   12.735208][    T1] init: Sending signal 9 to service 'set_hw' (pid 322) process group...
> [   12.743545][    T1] libprocessgroup: Successfully killed process cgroup uid 0 pid 322 in 0ms
> [   12.752957][    T1] init: processing action (wait_for_coldboot_done) from (<Builtin Action>:0)
> [   12.761705][    T1] init: start_waiting_for_property("ro.cold_boot_done", "true"): already set
> [   12.770421][    T1] init: processing action (SetMmapRndBits) from (<Builtin Action>:0)
> [   12.778741][    T1] init: processing action (KeychordInit) from (<Builtin Action>:0)
> [   12.786626][    T1] init: processing action (init) from (/system/etc/init/hw/init.rc:93)
> [   12.795094][    T1] init: Command 'copy /system/etc/prop.default /dev/urandom' action=init (/system/etc/init/hw/init.rc:98) took 0ms and failed: Could not read input file '/system/etc/prop.default': open() failed: No such file or directory
> [   12.819320][    T1] init: Command 'write /dev/cpuctl/nnapi-hal/cpu.uclamp.latency_sensitive 1' action=init (/system/etc/init/hw/init.rc:192) took 0ms and failed: Unable to write to file '/dev/cpuctl/nnapi-hal/cpu.uclamp.latency_sensitive': open() failed: Permission denied
> [   12.844611][    T1] init: Command 'write /dev/blkio/blkio.weight 1000' action=init (/system/etc/init/hw/init.rc:234) took 0ms and failed: Unable to write to file '/dev/blkio/blkio.weight': open() failed: Permission denied
> [   12.864518][    T1] init: Command 'write /dev/blkio/background/blkio.weight 200' action=init (/system/etc/init/hw/init.rc:235) took 0ms and failed: Unable to write to file '/dev/blkio/background/blkio.weight': open() failed: Permission denied
> [   12.886345][    T1] init: Command 'write /dev/blkio/blkio.group_idle 0' action=init (/system/etc/init/hw/init.rc:237) took 0ms and failed: Unable to write to file '/dev/blkio/blkio.group_idle': open() failed: Permission denied
> [   12.906671][    T1] init: Command 'write /dev/blkio/background/blkio.group_idle 0' action=init (/system/etc/init/hw/init.rc:238) took 0ms and failed: Unable to write to file '/dev/blkio/background/blkio.group_idle': open() failed: Permission denied
> [   12.959211][    T1] Registered swp emulation handler
> [   12.964903][    T1] init: starting service 'logd'...
> [   12.970062][    T1] init: Created socket '/dev/socket/logd', mode 666, user 1036, group 1036
> [   12.978664][    T1] init: Created socket '/dev/socket/logdr', mode 666, user 1036, group 1036
> [   12.987365][    T1] init: Created socket '/dev/socket/logdw', mode 222, user 1036, group 1036
> [   13.016133][    T1] init: Command 'start logd' action=init (/system/etc/init/hw/init.rc:465) took 51ms and succeeded
> [   13.027226][    T1] init: starting service 'lmkd'...
> [   13.027921][  T328] logd: libprocessgroup: Controller io is not found
> [   13.032451][    T1] init: Created socket '/dev/socket/lmkd', mode 660, user 1000, group 1000
> [   13.038738][  T328] logd: libprocessgroup: Controller io is not found
> [   13.050455][    T1] init: starting service 'servicemanager'...
> [   13.053727][  T328] logd: libprocessgroup: Controller io is not found
> [   13.054113][  T328] logd: libprocessgroup: SetAttribute: unknown attribute: BfqWeight
> [   13.062425][    T1] init: starting service 'hwservicemanager'...
> [   13.066129][  T328] logd: libprocessgroup: SetAttribute: unknown attribute: CfqGroupIdle
> [   13.076028][    T1] init: Command 'start vndservicemanager' action=init (/system/etc/init/hw/init.rc:477) took 0ms and failed: service vndservicemanager not found
> [   13.080064][  T328] logd: libprocessgroup: SetAttribute: unknown attribute: CfqWeight
> [   13.080088][  T328] logd: libprocessgroup: SetAttribute: unknown attribute: BfqWeight
> [   13.088246][    T1] init: processing action (ro.product.cpu.abilist32=* && init) from (/system/etc/init/hw/init.rc:480)
> [   13.103058][  T328] logd: libprocessgroup: SetAttribute: unknown attribute: CfqGroupIdle
> [   13.110865][    T1] init: starting service 'boringssl_self_test32'...
> [   13.118694][  T328] logd: libprocessgroup: SetAttribute: unknown attribute: CfqWeight
> [   13.131687][    T1] init: SVC_EXEC service 'boringssl_self_test32' pid 336 (uid 0 gid 0+0 context default) started; waiting...
> [   13.137691][  T328] logd: libprocessgroup: SetAttribute: unknown attribute: BfqWeight
> [   13.171392][  T328] logd: libprocessgroup: SetAttribute: unknown attribute: CfqGroupIdle
> [   13.179548][  T328] logd: libprocessgroup: SetAttribute: unknown attribute: CfqWeight
> [   13.179659][    T1] init: Service 'boringssl_self_test32' (pid 336) exited with status 0 waiting took 0.049000 seconds
> [   13.187467][  T328] logd: libprocessgroup: SetAttribute: unknown attribute: BfqWeight
> [   13.198292][    T1] init: Sending signal 9 to service 'boringssl_self_test32' (pid 336) process group...
> [   13.206103][  T328] logd: libprocessgroup: SetAttribute: unknown attribute: CfqGroupIdle
> [   13.215754][    T1] libprocessgroup: Successfully killed process cgroup uid 0 pid 336 in 0ms
> [   13.223800][  T328] logd: libprocessgroup: SetAttribute: unknown attribute: CfqWeight
> [   13.233415][    T1] init: processing action (ro.product.cpu.abilist64=* && init) from (/system/etc/init/hw/init.rc:482)
> [   13.243428][  T328] logd.auditd: start
> [   13.251189][    T1] init: starting service 'boringssl_self_test64'...
> [   13.254824][  T328] logd.klogd: 13109774578
> [   13.263772][    T1] init: SVC_EXEC service 'boringssl_self_test64' pid 340 (uid 0 gid 0+0 context default) started; waiting...
> [   13.271262][  T328] logd: Loaded bug_map file: /vendor/etc/selinux/selinux_denial_metadata
> [   13.285768][  T328] logd: Loaded bug_map file: /system/etc/selinux/bug_map
> [   13.329179][    T1] init: Service 'boringssl_self_test64' (pid 340) exited with status 0 waiting took 0.067000 seconds
> [   13.339967][    T1] init: Sending signal 9 to service 'boringssl_self_test64' (pid 340) process group...
> [   13.349608][    T1] libprocessgroup: Successfully killed process cgroup uid 0 pid 340 in 0ms
> [   13.359572][    T1] init: processing action (ro.debuggable=1 && init) from (/system/etc/init/hw/init.rc:1283)
> [   13.372581][    T1] init: starting service 'console'...
> [   13.399458][    T1] init: processing action (init) from (/system/etc/init/hw/init.usb.rc:27)
> [   13.408476][    T1] init: processing action (init) from (/system/etc/init/audioserver.rc:58)
> [   13.417497][    T1] init: processing action (init) from (/vendor/etc/init/init.db845c.rc:18)
> console:/ $ [   13.433211][    T1] init: Command 'symlink /sdcard /storage/sdcard0' action=init (/vendor/etc/init/init.db845c.rc:22) took 7ms and failed: symlink() failed: Read-only file system
> [   13.475511][    T1] init: processing action (late-init) from (/system/etc/init/hw/init.rc:517)
> [   13.484266][    T1] init: processing action (late-init) from (/system/etc/init/atrace.rc:3)
> [   13.499168][    T1] init: processing action (queue_property_triggers) from (<Builtin Action>:0)
> [   13.508027][    T1] init: processing action (early-fs) from (/system/etc/init/hw/init.rc:554)
> [   13.516841][    T1] init: starting service 'vold'...
> [   13.540373][    T1] init: processing action (early-fs) from (/vendor/etc/init/init.db845c.rc:4)
> [   13.549794][    T1] init: service 'vold' requested start, but it is already running (flags: 2052)
> [   13.558862][    T1] init: processing action (fs) from (/system/etc/init/logd.rc:29)
> [   13.566911][    T1] init: processing action (fs) from (/system/etc/init/wifi.rc:25)
> [   13.575175][    T1] init: processing action (fs) from (/vendor/etc/init/init.db845c.rc:7)
> [   13.588775][    T1] init: processing action (post-fs) from (/system/etc/init/hw/init.rc:558)
> [   13.597533][    T1] init: starting service 'exec 3 (/system/bin/vdc checkpoint markBootAttempt)'...
> [   13.634325][    T1] init: SVC_EXEC service 'exec 3 (/system/bin/vdc checkpoint markBootAttempt)' pid 345 (uid 1000 gid 1000+0 context default) started; waiting...
> [   13.648999][    T1] init: Command 'exec - system system -- /system/bin/vdc checkpoint markBootAttempt' action=post-fs (/system/etc/init/hw/init.rc:559) took 51ms and succeeded
> [   13.664822][    T1] init: Service 'exec 3 (/system/bin/vdc checkpoint markBootAttempt)' (pid 345) exited with status 0 waiting took 0.057000 seconds
> [   13.678276][    T1] init: Sending signal 9 to service 'exec 3 (/system/bin/vdc checkpoint markBootAttempt)' (pid 345) process group...
> [   13.690624][    T1] libprocessgroup: Successfully killed process cgroup uid 1000 pid 345 in 0ms
> [   13.702574][    T1] init: Command 'chown system cache /cache' action=post-fs (/system/etc/init/hw/init.rc:574) took 0ms and failed: lchown() failed: Read-only file system
> [   13.717980][    T1] init: Command 'chmod 0770 /cache' action=post-fs (/system/etc/init/hw/init.rc:575) took 0ms and failed: fchmodat() failed: Read-only file system
> [   13.733872][    T1] selinux: SELinux: Skipping restorecon on directory(/metadata)
> [   13.741416][    T1] selinux: 
> [   13.747557][    T1] selinux: SELinux: Skipping restorecon on directory(/metadata/apex)
> [   13.755545][    T1] selinux: 
> [   13.758983][    T1] init: processing action (post-fs) from (/system/etc/init/atrace_userdebug.rc:7)
> [   13.768302][    T1] init: processing action (post-fs) from (/system/etc/init/gsid.rc:8)
> [   13.776453][    T1] init: processing action (post-fs) from (/system/etc/init/recovery-refresh.rc:1)
> [   13.785710][    T1] init: starting service 'exec 4 (/system/bin/recovery-refresh)'...
> [   13.805594][    T1] init: processing action (post-fs) from (/vendor/etc/init/init.db845c.rc:11)
> [   13.814898][    T1] init: processing action (post-fs) from (/vendor/etc/init/init.db845c.usb.rc:94)
> [   13.824457][    T1] init: starting service 'set_udc'...
> [   13.832357][    T1] init: Service 'exec 4 (/system/bin/recovery-refresh)' (pid 350) exited with status 254 oneshot service took 0.037000 seconds in background
> [   13.846667][    T1] init: Sending signal 9 to service 'exec 4 (/system/bin/recovery-refresh)' (pid 350) process group...
> [   13.857705][    T1] libprocessgroup: Successfully killed process cgroup uid 1000 pid 350 in 0ms
> [   13.866651][    T1] init: processing action (post-fs) from (/vendor/etc/init/init.qcom.rc:41)
> [   13.875860][    T1] init: starting service 'pd_mapper'...
> [   13.883723][    T1] init: Service 'set_udc' (pid 351) exited with status 0 oneshot service took 0.053000 seconds in background
> [   13.895215][    T1] init: Sending signal 9 to service 'set_udc' (pid 351) process group...
> [   13.903629][    T1] libprocessgroup: Successfully killed process cgroup uid 0 pid 351 in 0ms
> [   13.911956][  T199] qcom,apr remoteproc-adsp:glink-edge.apr_audio_svc.-1.-1: Adding APR/GPR dev: aprsvc:apr-service:4:3
> [   13.912796][    T1] init: processing action (late-fs) from (/system/etc/init/hw/init.rc:632)
> [   13.923368][  T199] qcom,apr remoteproc-adsp:glink-edge.apr_audio_svc.-1.-1: Adding APR/GPR dev: aprsvc:apr-service:4:4
> [   13.932175][    T1] init: starting service 'system_suspend'...
> [   13.944543][  T199] qcom,apr remoteproc-adsp:glink-edge.apr_audio_svc.-1.-1: Adding APR/GPR dev: aprsvc:apr-service:4:7
> [   13.951281][    T1] init: starting service 'keystore2'...
> [   13.960161][  T199] q6asm-dai remoteproc-adsp:glink-edge:apr:apr-service@7:dais: Adding to iommu group 27
> [   13.967983][    T1] init: starting service 'vendor.boot-hal-1-2'...
> [   13.974845][  T199] qcom,apr remoteproc-adsp:glink-edge.apr_audio_svc.-1.-1: Adding APR/GPR dev: aprsvc:apr-service:4:8
> [   14.007685][    T1] init: starting service 'vendor.keymaster-3-0'...
> [   14.014767][   T76] qcom,slim-ngd-ctrl 171c0000.slim: SLIM SAT: Rcvd master capability
> [   14.016621][    T1] init: starting service 'suspend_blocker'...
> [   14.030945][    T1] init: Command 'class_start early_hal' action=late-fs (/system/etc/init/hw/init.rc:639) took 99ms and succeeded
> [   14.034496][  T199] wcd934x-codec wcd934x-codec.3.auto: WCD934X Minor:0x1 Version:0x401
> [   14.043051][    T1] init: starting service 'exec 5 (/system/bin/fsverity_init --load-verified-keys)'...
> [   14.061929][    T1] init: SVC_EXEC service 'exec 5 (/system/bin/fsverity_init --load-verified-keys)' pid 364 (uid 0 gid 0+0 context default) started; waiting...
> [   14.093069][    T1] init: Service 'exec 5 (/system/bin/fsverity_init --load-verified-keys)' (pid 364) exited with status 0 waiting took 0.031000 seconds
> [   14.106831][    T1] init: Sending signal 9 to service 'exec 5 (/system/bin/fsverity_init --load-verified-keys)' (pid 364) process group...
> [   14.119467][    T1] libprocessgroup: Successfully killed process cgroup uid 0 pid 364 in 0ms
> [   14.128157][    T1] init: processing action (late-fs) from (/system/etc/init/hw/init.rc:653)
> [   14.134492][  T199] wsa881x-codec sdw:0:0217:2010:00:1: ASoC: error at soc_component_read_no_lock on sdw:0:0217:2010:00:1 for register: [0x0000311c] -16
> [   14.137380][    T1] init: processing action (late-fs) from (/vendor/etc/init/init.db845c.rc:15)
> [   14.150425][  T199] wsa881x-codec sdw:0:0217:2010:00:1: ASoC: error at soc_component_read_no_lock on sdw:0:0217:2010:00:1 for register: [0x00003103] -16
> [   14.150448][  T199] wsa881x-codec sdw:0:0217:2010:00:2: ASoC: error at soc_component_read_no_lock on sdw:0:0217:2010:00:2 for register: [0x0000311c] -16
> [   14.160224][    T1] init: [libfs_mgr]Invalid ext4 superblock on '/dev/block/platform/soc@0/1d84000.ufshc/by-name/userdata'
> [   14.172952][  T199] wsa881x-codec sdw:0:0217:2010:00:2: ASoC: error at soc_component_read_no_lock on sdw:0:0217:2010:00:2 for register: [0x00003103] -16
> [   14.197844][    T1] init: [libfs_mgr]mount_with_alternatives(): skipping mount due to invalid magic, mountpoint=/data blk_dev=/dev/block/sda10 rec[1].fs_type=ext4
> [   14.212992][  T199] wcd934x-codec wcd934x-codec.3.auto: ASoC: mux RX INT0 MIX2 INP has no paths
> [   14.226830][    T1] init: Calling: /system/bin/vdc cryptfs mountFstab /dev/block/platform/soc@0/1d84000.ufshc/by-name/userdata /data 
> [   14.235482][  T199] wcd934x-codec wcd934x-codec.3.auto: ASoC: mux RX INT1 MIX2 INP has no paths
> [   14.255988][  T199] wcd934x-codec wcd934x-codec.3.auto: ASoC: mux RX INT2 MIX2 INP has no paths
> [   14.265093][  T199] wcd934x-codec wcd934x-codec.3.auto: ASoC: mux RX INT3 MIX2 INP has no paths
> [   14.274750][  T199] wcd934x-codec wcd934x-codec.3.auto: ASoC: mux RX INT4 MIX2 INP has no paths
> [   14.283857][  T199] wcd934x-codec wcd934x-codec.3.auto: ASoC: mux RX INT7 MIX2 INP has no paths
> [   14.305028][  T199] wcd934x-codec wcd934x-codec.3.auto: ASoC: mux CDC_IF TX9 MUX has no paths
> [   14.313656][  T199] wcd934x-codec wcd934x-codec.3.auto: ASoC: mux CDC_IF TX10 MUX has no paths
> [   14.319512][  T344] EXT4-fs (dm-30): Using encoding defined by superblock: utf8-12.1.0 with flags 0x0
> [   14.322345][  T199] wcd934x-codec wcd934x-codec.3.auto: ASoC: mux CDC_IF TX11 MUX has no paths
> [   14.334795][  T344] EXT4-fs (dm-30): mounted filesystem with ordered data mode. Quota mode: journalled.
> [   14.340284][  T199] wcd934x-codec wcd934x-codec.3.auto: ASoC: mux CDC_IF TX11 INP1 MUX has no paths
> [   14.358735][    T1] init: Userdata mounted using /vendor/etc/fstab.db845c result : 7
> [   14.358854][  T199] wcd934x-codec wcd934x-codec.3.auto: ASoC: mux CDC_IF TX13 MUX has no paths
> [   14.366687][    T1] init: Keyring created with id 85166943 in process 1
> [   14.375315][  T199] wcd934x-codec wcd934x-codec.3.auto: ASoC: mux CDC_IF TX13 INP1 MUX has no paths
> [   14.382604][    T1] init: Command 'mount_all /vendor/etc/fstab.${ro.hardware} --late' action=late-fs (/vendor/etc/init/init.db845c.rc:16) took 223ms and succeeded
> [   14.392610][  T199] wsa881x-codec sdw:0:0217:2010:00:1: ASoC: error at snd_soc_component_update_bits on sdw:0:0217:2010:00:1 for register: [0x0000311c] -16
> [   14.407726][    T1] init: processing action (post-fs-data) from (/system/etc/init/hw/init.rc:667)
> [   14.419705][  T199] wsa881x-codec sdw:0:0217:2010:00:2: ASoC: error at snd_soc_component_update_bits on sdw:0:0217:2010:00:2 for register: [0x0000311c] -16
> [   14.428749][    T1] init: starting service 'exec 6 (/system/bin/vdc checkpoint prepareCheckpoint)'...
> [   14.442842][  T199] input: DB845c Headset Jack as /devices/platform/soc@0/soc@0:sound/sound/card0/input4
> [   14.482235][    T1] init: SVC_EXEC service 'exec 6 (/system/bin/vdc checkpoint prepareCheckpoint)' pid 373 (uid 1000 gid 1000+0 context default) started; waiting...
> [   14.497083][    T1] init: Command 'exec - system system -- /system/bin/vdc checkpoint prepareCheckpoint' action=post-fs-data (/system/etc/init/hw/init.rc:672) took 68ms and succeeded
> [   14.516034][    T1] init: Service 'exec 6 (/system/bin/vdc checkpoint prepareCheckpoint)' (pid 373) exited with status 0 waiting took 0.063000 seconds
> [   14.529630][    T1] init: Sending signal 9 to service 'exec 6 (/system/bin/vdc checkpoint prepareCheckpoint)' (pid 373) process group...
> [   14.542066][    T1] libprocessgroup: Successfully killed process cgroup uid 1000 pid 373 in 0ms
> [   14.553471][    T1] init: starting service 'exec 7 (/system/bin/vdc --wait cryptfs enablefilecrypto)'...
> [   14.564403][    T1] init: SVC_EXEC service 'exec 7 (/system/bin/vdc --wait cryptfs enablefilecrypto)' pid 374 (uid 0 gid 0+0 context default) started; waiting...
> [   14.618208][    T1] init: Service 'exec 7 (/system/bin/vdc --wait cryptfs enablefilecrypto)' (pid 374) exited with status 0 waiting took 0.054000 seconds
> [   14.632062][    T1] init: Sending signal 9 to service 'exec 7 (/system/bin/vdc --wait cryptfs enablefilecrypto)' (pid 374) process group...
> [   14.644760][    T1] libprocessgroup: Successfully killed process cgroup uid 0 pid 374 in 0ms
> [   14.653865][    T1] init: Verified that /data/bootchart has the encryption policy 3b9eba6cac88d3cedeaf38c4f5af933f v2 modes 1/4 flags 0xa
> [   14.666335][    T1] fscrypt: AES-256-CTS-CBC using implementation "cts-cbc-aes-ce"
> [   14.676154][    T1] fscrypt: AES-256-XTS using blk-crypto (native)
> [   14.684275][    T1] init: Verified that /data/vendor has the encryption policy 3b9eba6cac88d3cedeaf38c4f5af933f v2 modes 1/4 flags 0xa
> [   14.697148][    T1] init: Verified that /data/anr has the encryption policy 3b9eba6cac88d3cedeaf38c4f5af933f v2 modes 1/4 flags 0xa
> [   14.709488][    T1] init: Verified that /data/tombstones has the encryption policy 3b9eba6cac88d3cedeaf38c4f5af933f v2 modes 1/4 flags 0xa
> [   14.722455][    T1] init: starting service 'tombstoned'...
> [   14.728155][    T1] init: Created socket '/dev/socket/tombstoned_crash', mode 666, user 1000, group 1000
> [   14.737844][    T1] init: Created socket '/dev/socket/tombstoned_intercept', mode 666, user 1000, group 1000
> [   14.747839][    T1] init: Created socket '/dev/socket/tombstoned_java_trace', mode 666, user 1000, group 1000
> [   14.772389][    T1] init: Switched to default mount namespace
> [   14.778841][    T1] init: Verified that /data/misc has the encryption policy 3b9eba6cac88d3cedeaf38c4f5af933f v2 modes 1/4 flags 0xa
> [   14.792552][    T1] init: starting service 'exec 8 (/system/bin/vdc keymaster earlyBootEnded)'...
> [   14.806516][    T1] init: SVC_EXEC service 'exec 8 (/system/bin/vdc keymaster earlyBootEnded)' pid 378 (uid 1000 gid 1000+0 context default) started; waiting...
> [   14.833383][  T344] incfs: IncFs_Features: failed to open features dir, assuming v1/none.: No such file or directory
> [   14.866847][  T344] vold: keystore2 Keystore earlyBootEnded returned service specific error: -68
> [   14.877961][    T1] init: Service 'exec 8 (/system/bin/vdc keymaster earlyBootEnded)' (pid 378) exited with status 0 waiting took 0.071000 seconds
> [   14.891196][    T1] init: Sending signal 9 to service 'exec 8 (/system/bin/vdc keymaster earlyBootEnded)' (pid 378) process group...
> [   14.903302][    T1] libprocessgroup: Successfully killed process cgroup uid 1000 pid 378 in 0ms
> [   14.912756][    T1] init: Verified that /data/property has the encryption policy 3b9eba6cac88d3cedeaf38c4f5af933f v2 modes 1/4 flags 0xa
> [   14.928807][  T270] init: Wait for property 'ro.persistent_properties.ready=true' took 3ms
> [   14.937970][    T1] init: service 'logd' requested start, but it is already running (flags: 4)
> [   14.946776][    T1] init: starting service 'logd-reinit'...
> [   14.972090][    T1] init: Not setting encryption policy on: /data/apex
> [   14.979410][    T1] init: Verified that /data/apex/decompressed has the encryption policy 3b9eba6cac88d3cedeaf38c4f5af933f v2 modes 1/4 flags 0xa
> [   14.993031][    T1] init: Verified that /data/app-staging has the encryption policy 3b9eba6cac88d3cedeaf38c4f5af933f v2 modes 1/4 flags 0xa
> [   15.005762][    T1] init: Verified that /data/apex/ota_reserved has the encryption policy 3b9eba6cac88d3cedeaf38c4f5af933f v2 modes 1/4 flags 0xa
> [   15.020089][    T1] init: starting service 'apexd'...
> [   15.024772][  T339] logd: logd reinit
> [   15.032482][  T339] logd: FrameworkListener: read() failed (Connection reset by peer)
> [   15.032918][    T1] init: Service 'logd-reinit' (pid 381) exited with status 0 oneshot service took 0.079000 seconds in background
> [   15.038725][  T382] apexd: Scanning /system/apex for pre-installed ApexFiles
> [   15.038874][  T382] apexd: Found pre-installed APEX /system/apex/com.android.cronet.apex
> [   15.039173][  T382] apexd: Found pre-installed APEX /system/apex/com.android.sdkext.apex
> [   15.039334][  T382] apexd: Found pre-installed APEX /system/apex/com.android.art.capex
> [   15.039468][  T382] apexd: Found pre-installed APEX /system/apex/com.android.btservices.apex
> [   15.039619][  T382] apexd: Found pre-installed APEX /system/apex/com.android.ipsec.capex
> [   15.039754][  T382] apexd: Found pre-installed APEX /system/apex/com.android.tethering.capex
> [   15.039886][  T382] apexd: Found pre-installed APEX /system/apex/com.android.adbd.capex
> [   15.040018][  T382] apexd: Found pre-installed APEX /system/apex/com.android.tzdata.apex
> [   15.040153][  T382] apexd: Found pre-installed APEX /system/apex/com.android.scheduling.capex
> [   15.040279][  T382] apexd: Found pre-installed APEX /system/apex/com.android.wifi.capex
> [   15.040467][  T382] apexd: Found pre-installed APEX /system/apex/com.android.uwb.capex
> [   15.052234][    T1] init: Sending signal 9 to service 'logd-reinit' (pid 381) process group...
> [   15.059625][  T382] apexd: Found pre-installed APEX /system/apex/com.android.ondevicepersonalization.capex
> [   15.067599][    T1] libprocessgroup: Successfully killed process cgroup uid 1036 pid 381 in 0ms
> [   15.075789][  T382] apexd: Found pre-installed APEX /system/apex/com.android.media.swcodec.capex
> [   15.086451][    T1] init: Verified that /data/local has the encryption policy 3b9eba6cac88d3cedeaf38c4f5af933f v2 modes 1/4 flags 0xa
> [   15.092302][  T382] apexd: Found pre-installed APEX /system/apex/com.android.vndk.current.apex
> [   15.101690][    T1] init: starting service 'exec 9 (/bin/rm -rf /data/misc/virtualizationservice)'...
> [   15.108932][  T382] apexd: Found pre-installed APEX /system/apex/com.android.conscrypt.capex
> [   15.118588][    T1] init: SVC_EXEC service 'exec 9 (/bin/rm -rf /data/misc/virtualizationservice)' pid 383 (uid 1081 gid 1000+0 context default) started; waiting...
> [   15.125182][  T382] apexd: Found pre-installed APEX /system/apex/com.android.extservices.capex
> [   15.133756][    T1] init: Service 'exec 9 (/bin/rm -rf /data/misc/virtualizationservice)' (pid 383) exited with status 1 waiting took 0.015000 seconds
> [   15.141822][  T382] apexd: Found pre-installed APEX /system/apex/com.android.media.capex
> [   15.149682][    T1] init: Sending signal 9 to service 'exec 9 (/bin/rm -rf /data/misc/virtualizationservice)' (pid 383) process group...
> [   15.158460][  T382] apexd: Found pre-installed APEX /system/apex/com.android.permission.capex
> [   15.168139][    T1] libprocessgroup: Successfully killed process cgroup uid 1081 pid 383 in 0ms
> [   15.176941][  T382] apexd: Found pre-installed APEX /system/apex/com.android.os.statsd.apex
> [   15.185881][    T1] init: Not setting encryption policy on: /data/preloads
> [   15.197894][  T382] apexd: Found pre-installed APEX /system/apex/com.android.neuralnetworks.capex
> [   15.207651][    T1] init: Verified that /data/app-private has the encryption policy 3b9eba6cac88d3cedeaf38c4f5af933f v2 modes 1/4 flags 0xa
> [   15.215839][  T382] apexd: Found pre-installed APEX /system/apex/com.android.mediaprovider.capex
> [   15.224562][    T1] init: Verified that /data/app-ephemeral has the encryption policy 3b9eba6cac88d3cedeaf38c4f5af933f v2 modes 1/4 flags 0xa
> [   15.239125][  T382] apexd: Found pre-installed APEX /system/apex/com.android.appsearch.capex
> [   15.248125][    T1] init: Verified that /data/app-asec has the encryption policy 3b9eba6cac88d3cedeaf38c4f5af933f v2 modes 1/4 flags 0xa
> [   15.261379][  T382] apexd: Found pre-installed APEX /system/apex/com.android.runtime.apex
> [   15.269733][    T1] init: Verified that /data/app-lib has the encryption policy 3b9eba6cac88d3cedeaf38c4f5af933f v2 modes 1/4 flags 0xa
> [   15.281980][  T382] apexd: Found pre-installed APEX /system/apex/com.android.resolv.capex
> [   15.290997][    T1] init: Verified that /data/app has the encryption policy 3b9eba6cac88d3cedeaf38c4f5af933f v2 modes 1/4 flags 0xa
> [   15.299317][  T382] apexd: Found pre-installed APEX /system/apex/com.android.i18n.apex
> [   15.307933][    T1] init: Verified that /data/fonts has the encryption policy 3b9eba6cac88d3cedeaf38c4f5af933f v2 modes 1/4 flags 0xa
> [   15.314672][  T382] apexd: Found pre-installed APEX /system/apex/com.android.adservices.capex
> [   15.324781][    T1] init: Verified that /data/dalvik-cache has the encryption policy 3b9eba6cac88d3cedeaf38c4f5af933f v2 modes 1/4 flags 0xa
> [   15.336193][  T382] apexd: Scanning /system_ext/apex for pre-installed ApexFiles
> [   15.345258][    T1] init: Verified that /data/ota has the encryption policy 3b9eba6cac88d3cedeaf38c4f5af933f v2 modes 1/4 flags 0xa
> [   15.357711][  T382] apexd: /system_ext/apex does not exist. Skipping
> [   15.366585][    T1] init: Verified that /data/ota_package has the encryption policy 3b9eba6cac88d3cedeaf38c4f5af933f v2 modes 1/4 flags 0xa
> [   15.378550][  T382] apexd: Scanning /product/apex for pre-installed ApexFiles
> [   15.387140][    T1] init: Verified that /data/resource-cache has the encryption policy 3b9eba6cac88d3cedeaf38c4f5af933f v2 modes 1/4 flags 0xa
> [   15.399047][  T382] apexd: /product/apex does not exist. Skipping
> [   15.407363][    T1] init: Not setting encryption policy on: /data/lost+found
> [   15.419185][  T382] apexd: Scanning /vendor/apex for pre-installed ApexFiles
> [   15.427499][    T1] init: Verified that /data/drm has the encryption policy 3b9eba6cac88d3cedeaf38c4f5af933f v2 modes 1/4 flags 0xa
> [   15.439252][  T382] apexd: /vendor/apex does not exist. Skipping
> [   15.448160][    T1] init: Verified that /data/mediadrm has the encryption policy 3b9eba6cac88d3cedeaf38c4f5af933f v2 modes 1/4 flags 0xa
> [   15.460568][  T382] apexd: No block apex metadata partition found, not adding block apexes
> [   15.468373][    T1] init: Verified that /data/nfc has the encryption policy 3b9eba6cac88d3cedeaf38c4f5af933f v2 modes 1/4 flags 0xa
> [   15.479895][  T382] apexd: Populating APEX database from mounts...
> [   15.487118][    T1] init: Verified that /data/backup has the encryption policy 3b9eba6cac88d3cedeaf38c4f5af933f v2 modes 1/4 flags 0xa
> [   15.499143][  T382] apexd: 0 packages restored.
> [   15.506417][    T1] init: Verified that /data/ss has the encryption policy 3b9eba6cac88d3cedeaf38c4f5af933f v2 modes 1/4 flags 0xa
> [   15.519378][  T382] apexd: Marking APEXd as starting
> [   15.525147][    T1] init: Verified that /data/system has the encryption policy 3b9eba6cac88d3cedeaf38c4f5af933f v2 modes 1/4 flags 0xa
> [   15.533243][  T382] apexd: Scanning /metadata/apex/sessions looking for sessions to be activated.
> [   15.539675][    T1] init: Not setting encryption policy on: /data/media
> [   15.551510][  T382] apexd: Scanning /data/apex/active for data ApexFiles
> [   15.557796][    T1] init: Not setting encryption policy on: /data/misc_ce
> [   15.569948][  T382] apexd: Selecting APEX for activation
> [   15.578399][    T1] init: Not setting encryption policy on: /data/misc_de
> [   15.589865][  T382] apexd: Processing compressed APEX
> [   15.596540][    T1] init: Not setting encryption policy on: /data/system_ce
> [   15.608251][  T382] apexd: Processing compressed APEX /system/apex/com.android.art.capex
> [   15.613334][    T1] init: Not setting encryption policy on: /data/system_de
> [   15.628216][  T382] apexd: Skipping decompression for /system/apex/com.android.art.capex
> [   15.629974][    T1] init: Not setting encryption policy on: /data/user
> [   15.641832][  T382] apexd: Processing compressed APEX /system/apex/com.android.permission.capex
> [   15.651153][    T1] init: Not setting encryption policy on: /data/user_de
> [   15.660261][  T382] apexd: Skipping decompression for /system/apex/com.android.permission.capex
> [   15.664674][    T1] init: Not setting encryption policy on: /data/vendor_ce
> [   15.671020][  T382] apexd: Processing compressed APEX /system/apex/com.android.ipsec.capex
> [   15.676764][    T1] init: Not setting encryption policy on: /data/vendor_de
> [   15.685847][  T382] apexd: Skipping decompression for /system/apex/com.android.ipsec.capex
> [   15.688783][    T1] init: starting service 'exec 10 (/system/bin/chattr +F /data/media)'...
> [   15.695337][  T382] apexd: Processing compressed APEX /system/apex/com.android.wifi.capex
> [   15.799676][  T382] apexd: Skipping decompression for /system/apex/com.android.wifi.capex
> [   15.807931][  T382] apexd: Processing compressed APEX /system/apex/com.android.resolv.capex
> [   15.818851][  T382] apexd: Skipping decompression for /system/apex/com.android.resolv.capex
> [   15.827271][  T382] apexd: Processing compressed APEX /system/apex/com.android.tethering.capex
> [   15.839093][  T382] apexd: Skipping decompression for /system/apex/com.android.tethering.capex
> [   15.841597][    T1] init: SVC_EXEC service 'exec 10 (/system/bin/chattr +F /data/media)' pid 384 (uid 1023 gid 1023+0 context default) started; waiting...
> [   15.847789][  T382] apexd: Processing compressed APEX /system/apex/com.android.media.swcodec.capex
> [   15.861724][    T1] init: Command 'exec - media_rw media_rw -- /system/bin/chattr +F /data/media' action=post-fs-data (/system/etc/init/hw/init.rc:941) took 173ms and succeeded
> [   15.873549][  T382] apexd: Skipping decompression for /system/apex/com.android.media.swcodec.capex
> [   15.886603][    T1] init: Service 'exec 10 (/system/bin/chattr +F /data/media)' (pid 384) exited with status 0 waiting took 0.182000 seconds
> [   15.895580][  T382] apexd: Processing compressed APEX /system/apex/com.android.adbd.capex
> [   15.908272][    T1] init: Sending signal 9 to service 'exec 10 (/system/bin/chattr +F /data/media)' (pid 384) process group...
> [   15.919241][  T382] apexd: Skipping decompression for /system/apex/com.android.adbd.capex
> [   15.928067][    T1] libprocessgroup: Successfully killed process cgroup uid 1023 pid 384 in 0ms
> [   15.936216][  T382] apexd: Processing compressed APEX /system/apex/com.android.scheduling.capex
> [   15.953765][    T1] init: Verified that /data/cache has the encryption policy 3b9eba6cac88d3cedeaf38c4f5af933f v2 modes 1/4 flags 0xa
> [   15.956876][  T382] apexd: Skipping decompression for /system/apex/com.android.scheduling.capex
> [   15.966566][    T1] init: Verified that /data/rollback has the encryption policy 3b9eba6cac88d3cedeaf38c4f5af933f v2 modes 1/4 flags 0xa
> [   15.974637][  T382] apexd: Processing compressed APEX /system/apex/com.android.conscrypt.capex
> [   15.987302][    T1] init: Verified that /data/rollback-observer has the encryption policy 3b9eba6cac88d3cedeaf38c4f5af933f v2 modes 1/4 flags 0xa
> [   15.998764][  T382] apexd: Skipping decompression for /system/apex/com.android.conscrypt.capex
> [   16.009186][    T1] init: Verified that /data/rollback-history has the encryption policy 3b9eba6cac88d3cedeaf38c4f5af933f v2 modes 1/4 flags 0xa
> [   16.017451][  T382] apexd: Processing compressed APEX /system/apex/com.android.media.capex
> [   16.030815][    T1] init: Verified that /data/incremental has the encryption policy 3b9eba6cac88d3cedeaf38c4f5af933f v2 modes 1/4 flags 0xa
> [   16.041115][  T382] apexd: Skipping decompression for /system/apex/com.android.media.capex
> [   16.059793][  T382] apexd: Processing compressed APEX /system/apex/com.android.extservices.capex
> [   16.071260][  T382] apexd: Skipping decompression for /system/apex/com.android.extservices.capex
> [   16.080209][  T382] apexd: Processing compressed APEX /system/apex/com.android.uwb.capex
> [   16.091116][  T382] apexd: Skipping decompression for /system/apex/com.android.uwb.capex
> [   16.099281][  T382] apexd: Processing compressed APEX /system/apex/com.android.mediaprovider.capex
> [   16.110996][  T382] apexd: Skipping decompression for /system/apex/com.android.mediaprovider.capex
> [   16.120031][  T382] apexd: Processing compressed APEX /system/apex/com.android.ondevicepersonalization.capex
> [   16.132939][  T382] apexd: Skipping decompression for /system/apex/com.android.ondevicepersonalization.capex
> [   16.142845][  T382] apexd: Processing compressed APEX /system/apex/com.android.adservices.capex
> [   16.154001][  T382] apexd: Skipping decompression for /system/apex/com.android.adservices.capex
> [   16.162773][  T382] apexd: Processing compressed APEX /system/apex/com.android.neuralnetworks.capex
> [   16.174681][  T382] apexd: Skipping decompression for /system/apex/com.android.neuralnetworks.capex
> [   16.183831][  T382] apexd: Processing compressed APEX /system/apex/com.android.appsearch.capex
> [   16.195598][  T382] apexd: Skipping decompression for /system/apex/com.android.appsearch.capex
> [   16.204897][  T385] loop4: detected capacity change from 0 to 1640
> [   16.211535][  T387] loop5: detected capacity change from 0 to 39072
> [   16.215721][  T385] EXT4-fs (loop4): mounted filesystem without journal. Quota mode: none.
> [   16.218168][  T388] loop6: detected capacity change from 0 to 14656
> [   16.226241][  T385] apexd: Successfully mounted package /system/apex/com.android.sdkext.apex on /apex/com.android.sdkext@339990000 duration=21
> [   16.229305][  T387] EXT4-fs (loop5): mounted filesystem without journal. Quota mode: none.
> [   16.229414][  T387] apexd: Successfully mounted package /system/apex/com.android.btservices.apex on /apex/com.android.btservices@339990000 duration=24
> [   16.232923][  T386] loop7: detected capacity change from 0 to 83144
> [   16.236018][  T388] EXT4-fs (loop6): mounted filesystem without journal. Quota mode: none.
> [   16.236047][  T388] apexd: Successfully mounted package /system/apex/com.android.cronet.apex on /apex/com.android.cronet@1 duration=31
> [   16.294494][  T387] loop8: detected capacity change from 0 to 1656
> [   16.300737][  T386] EXT4-fs (loop7): mounted filesystem without journal. Quota mode: none.
> [   16.300780][  T386] apexd: Successfully mounted package /system/apex/com.android.vndk.current.apex on /apex/com.android.vndk.vUpsideDownCake@1 duration=95
> [   16.309361][  T388] loop9: detected capacity change from 0 to 4048
> [   16.319734][  T387] EXT4-fs (loop8): mounted filesystem without journal. Quota mode: none.
> [   16.319845][  T387] apexd: Successfully mounted package /system/apex/com.android.tzdata.apex on /apex/com.android.tzdata@339990000 duration=87
> [   16.350747][  T385] loop10: detected capacity change from 0 to 76584
> [   16.355506][  T388] EXT4-fs (loop9): mounted filesystem without journal. Quota mode: none.
> [   16.357612][  T387] loop11: detected capacity change from 0 to 16816
> [   16.365599][  T388] apexd: Successfully mounted package /system/apex/com.android.os.statsd.apex on /apex/com.android.os.statsd@339990000 duration=128
> [   16.373475][  T385] EXT4-fs (loop10): mounted filesystem without journal. Quota mode: none.
> [   16.375107][  T386] loop12: detected capacity change from 0 to 97576
> [   16.377164][  T386] device-mapper: verity: sha256 using implementation "sha256-ce"
> [   16.386598][  T388] loop13: detected capacity change from 0 to 29160
> [   16.387030][  T387] EXT4-fs (loop11): mounted filesystem without journal. Quota mode: none.
> [   16.387118][  T387] apexd: Successfully mounted package /system/apex/com.android.runtime.apex on /apex/com.android.runtime@1 duration=65
> [   16.393865][  T385] apexd: Successfully mounted package /system/apex/com.android.i18n.apex on /apex/com.android.i18n@1 duration=147
> [   16.400895][  T387] loop14: detected capacity change from 0 to 1600
> [   16.401187][  T386] EXT4-fs (dm-28): mounted filesystem without journal. Quota mode: none.
> [   16.401283][  T386] apexd: Successfully mounted package /data/apex/decompressed/com.android.art@339990000.decompressed.apex on /apex/com.android.art@339990000 duration=77
> [   16.401750][  T388] device-mapper: verity: sha256 using implementation "sha256-ce"
> [   16.484727][  T388] EXT4-fs (dm-27): mounted filesystem without journal. Quota mode: none.
> [   16.485060][  T386] loop15: detected capacity change from 0 to 16432
> [   16.486505][  T387] device-mapper: verity: sha256 using implementation "sha256-ce"
> [   16.493098][  T388] apexd: Successfully mounted package /data/apex/decompressed/com.android.permission@339990000.decompressed.apex on /apex/com.android.permission@339990000 duration=106
> [   16.500011][  T385] loop16: detected capacity change from 0 to 8448
> [   16.500753][  T386] device-mapper: verity: sha256 using implementation "sha256-ce"
> [   16.508892][  T387] EXT4-fs (dm-26): mounted filesystem without journal. Quota mode: none.
> [   16.523724][  T386] EXT4-fs (dm-23): mounted filesystem without journal. Quota mode: none.
> [   16.523819][  T386] apexd: Successfully mounted package /data/apex/decompressed/com.android.wifi@339990000.decompressed.apex on /apex/com.android.wifi@339990000 duration=60
> [   16.528923][  T385] device-mapper: verity: sha256 using implementation "sha256-ce"
> [   16.530147][  T387] apexd: Successfully mounted package /data/apex/decompressed/com.android.ipsec@339990000.decompressed.apex on /apex/com.android.ipsec@339990000 duration=141
> [   16.530196][  T388] loop17: detected capacity change from 0 to 17944
> [   16.561847][  T385] EXT4-fs (dm-21): mounted filesystem without journal. Quota mode: none.
> [   16.570336][  T387] loop18: detected capacity change from 0 to 43144
> [   16.571618][  T388] device-mapper: verity: sha256 using implementation "sha256-ce"
> [   16.577729][  T385] apexd: Successfully mounted package /data/apex/decompressed/com.android.resolv@339990000.decompressed.apex on /apex/com.android.resolv@339990000 duration=114
> [   16.593982][  T386] loop19: detected capacity change from 0 to 17568
> [   16.595298][  T387] device-mapper: verity: sha256 using implementation "sha256-ce"
> [   16.595335][  T388] EXT4-fs (dm-20): mounted filesystem without journal. Quota mode: none.
> [   16.595381][  T388] apexd: Successfully mounted package /data/apex/decompressed/com.android.tethering@339990000.decompressed.apex on /apex/com.android.tethering@339990000 duration=87
> [   16.678412][  T386] device-mapper: verity: sha256 using implementation "sha256-ce"
> [   16.678415][  T388] loop20: detected capacity change from 0 to 536
> [   16.679357][  T387] EXT4-fs (dm-18): mounted filesystem without journal. Quota mode: none.
> [   16.679532][  T387] apexd: Successfully mounted package /data/apex/decompressed/com.android.media.swcodec@339990000.decompressed.apex on /apex/com.android.media.swcodec@339990000 duration=140
> [   16.709684][  T386] EXT4-fs (dm-19): mounted filesystem without journal. Quota mode: none.
> [   16.718470][  T385] loop21: detected capacity change from 0 to 10304
> [   16.723778][  T388] device-mapper: verity: sha256 using implementation "sha256-ce"
> [   16.726245][  T386] apexd: Successfully mounted package /data/apex/decompressed/com.android.adbd@339990000.decompressed.apex on /apex/com.android.adbd@339990000 duration=186
> [   16.733364][  T387] loop22: detected capacity change from 0 to 12952
> [   16.734644][  T385] device-mapper: verity: sha256 using implementation "sha256-ce"
> [   16.759760][  T388] EXT4-fs (dm-17): mounted filesystem without journal. Quota mode: none.
> [   16.760055][  T385] EXT4-fs (dm-16): mounted filesystem without journal. Quota mode: none.
> [   16.760168][  T385] apexd: Successfully mounted package /data/apex/decompressed/com.android.conscrypt@339990000.decompressed.apex on /apex/com.android.conscrypt@339990000 duration=81
> [   16.762720][  T386] loop23: detected capacity change from 0 to 13904
> [   16.764345][  T387] device-mapper: verity: sha256 using implementation "sha256-ce"
> [   16.769877][  T388] apexd: Successfully mounted package /data/apex/decompressed/com.android.scheduling@339990000.decompressed.apex on /apex/com.android.scheduling@339990000 duration=91
> [   16.779114][  T385] loop24: detected capacity change from 0 to 6000
> [   16.780518][  T386] device-mapper: verity: sha256 using implementation "sha256-ce"
> [   16.849483][  T388] loop25: detected capacity change from 0 to 17600
> [   16.849580][  T387] EXT4-fs (dm-9): mounted filesystem without journal. Quota mode: none.
> [   16.853643][  T385] device-mapper: verity: sha256 using implementation "sha256-ce"
> [   16.858772][  T388] device-mapper: verity: sha256 using implementation "sha256-ce"
> [   16.868633][  T387] apexd: Successfully mounted package /data/apex/decompressed/com.android.media@339990000.decompressed.apex on /apex/com.android.media@339990000 duration=188
> [   16.872391][  T386] EXT4-fs (dm-13): mounted filesystem without journal. Quota mode: none.
> [   16.878464][  T385] EXT4-fs (dm-14): mounted filesystem without journal. Quota mode: none.
> [   16.878572][  T385] apexd: Successfully mounted package /data/apex/decompressed/com.android.uwb@339990000.decompressed.apex on /apex/com.android.uwb@339990000 duration=117
> [   16.880671][  T385] loop26: detected capacity change from 0 to 536
> [   16.895409][  T386] apexd: Successfully mounted package /data/apex/decompressed/com.android.extservices@339990000.decompressed.apex on /apex/com.android.extservices@339990000 duration=153
> [   16.904661][  T387] loop27: detected capacity change from 0 to 552
> [   16.904953][  T388] EXT4-fs (dm-12): mounted filesystem without journal. Quota mode: none.
> [   16.905009][  T388] apexd: Successfully mounted package /data/apex/decompressed/com.android.mediaprovider@339990000.decompressed.apex on /apex/com.android.mediaprovider@339990000 duration=56
> [   16.908940][  T385] device-mapper: verity: sha256 using implementation "sha256-ce"
> [   16.933123][  T385] EXT4-fs (dm-11): mounted filesystem without journal. Quota mode: none.
> [   16.934138][  T388] loop28: detected capacity change from 0 to 16424
> [   16.936732][  T387] device-mapper: verity: sha256 using implementation "sha256-ce"
> [   16.950519][  T385] apexd: Successfully mounted package /data/apex/decompressed/com.android.ondevicepersonalization@339990000.decompressed.apex on /apex/com.android.ondevicepersonalization@339990000 duration=70
> [   16.957045][  T386] loop29: detected capacity change from 0 to 7136
> [   16.980535][  T387] EXT4-fs (dm-4): mounted filesystem without journal. Quota mode: none.
> [   16.983608][  T388] device-mapper: verity: sha256 using implementation "sha256-ce"
> [   16.989853][  T387] apexd: Successfully mounted package /data/apex/decompressed/com.android.adservices@339990000.decompressed.apex on /apex/com.android.adservices@339990000 duration=85
> [   16.999674][  T386] device-mapper: verity: sha256 using implementation "sha256-ce"
> [   17.071317][  T388] EXT4-fs (dm-8): mounted filesystem without journal. Quota mode: none.
> [   17.085724][  T388] apexd: Successfully mounted package /data/apex/decompressed/com.android.neuralnetworks@339990000.decompressed.apex on /apex/com.android.neuralnetworks@339990000 duration=179
> [   17.106603][  T386] EXT4-fs (dm-7): mounted filesystem without journal. Quota mode: none.
> [   17.114901][  T386] apexd: Successfully mounted package /data/apex/decompressed/com.android.appsearch@339990000.decompressed.apex on /apex/com.android.appsearch@339990000 duration=201
> [   17.132925][  T382] apexd: Activated 26 packages.
> [   17.137729][  T382] apexd: OnStart done, duration=1605
> [   17.143010][  T382] AidlLazyServiceRegistrar: Registering service apexservice
> [   17.167376][  T382] apexd: Marking APEXd as activated
> [   17.173329][  T270] init: Wait for property 'apexd.status=activated' took 1121ms
> [   17.181736][  T382] apexd: Finalizing configuration of 26 loop devices
> [   17.213730][    T1] init: Parsing file /apex/com.android.adbd/etc/init.rc...
> [   17.251289][    T1] init: Parsing file /apex/com.android.art/etc/init.rc...
> [   17.259458][    T1] init: Parsing file /apex/com.android.media.swcodec/etc/mediaswcodec.32rc...
> [   17.269380][    T1] init: Parsing file /apex/com.android.media/etc/mediatranscoding.32rc...
> [   17.279089][    T1] init: Parsing file /apex/com.android.os.statsd/etc/init.rc...
> [   17.287563][    T1] init: Parsing file /apex/com.android.sdkext/etc/derive_classpath.rc...
> [   17.296764][    T1] init: Parsing file /apex/com.android.sdkext/etc/derive_sdk.rc...
> [   17.346355][    T1] init: linkerconfig generated /linkerconfig with mounted APEX modules info
> [   17.355108][    T1] init: Command 'perform_apex_config' action=post-fs-data (/system/etc/init/hw/init.rc:988) took 173ms and succeeded
> [   17.368552][    T1] init: Verified that /data/bootanim has the encryption policy 3b9eba6cac88d3cedeaf38c4f5af933f v2 modes 1/4 flags 0xa
> [   17.382109][    T1] init: starting service 'derive_sdk'...
> [   17.408389][    T1] init: SVC_EXEC service 'derive_sdk' pid 437 (uid 9999 gid 9999+0 context default) started; waiting...
> [   17.444934][    T1] init: Service 'derive_sdk' (pid 437) exited with status 0 waiting took 0.053000 seconds
> [   17.454810][    T1] init: Sending signal 9 to service 'derive_sdk' (pid 437) process group...
> [   17.463561][    T1] libprocessgroup: Successfully killed process cgroup uid 9999 pid 437 in 0ms
> [   17.474671][    T1] init: starting service 'exec 11 (/system/bin/vdc --wait cryptfs init_user0)'...
> [   17.502812][    T1] init: SVC_EXEC service 'exec 11 (/system/bin/vdc --wait cryptfs init_user0)' pid 438 (uid 0 gid 0+0 context default) started; waiting...
> [   17.581304][    T1] init: Service 'exec 11 (/system/bin/vdc --wait cryptfs init_user0)' (pid 438) exited with status 0 waiting took 0.095000 seconds
> [   17.594865][    T1] init: Sending signal 9 to service 'exec 11 (/system/bin/vdc --wait cryptfs init_user0)' (pid 438) process group...
> [   17.607382][    T1] libprocessgroup: Successfully killed process cgroup uid 0 pid 438 in 0ms
> [   17.620517][    T1] selinux: SELinux: Skipping restorecon on directory(/data)
> [   17.627895][    T1] selinux: 
> [   17.631491][    T1] init: starting service 'derive_classpath'...
> [   17.659885][    T1] init: SVC_EXEC service 'derive_classpath' pid 440 (uid 1000 gid 1000+1 context default) started; waiting...
> [   17.690255][    T1] init: Service 'derive_classpath' (pid 440) exited with status 0 waiting took 0.049000 seconds
> [   17.700776][    T1] init: Sending signal 9 to service 'derive_classpath' (pid 440) process group...
> [   17.710296][    T1] libprocessgroup: Successfully killed process cgroup uid 1000 pid 440 in 0ms
> [   17.722271][    T1] init: starting service 'odsign'...
> [   18.018765][  T270] init: Wait for property 'odsign.key.done=1' took 262ms
> [   18.026616][    T1] init: starting service 'exec 12 (/system/bin/fsverity_init --lock)'...
> [   18.069948][    T1] init: SVC_EXEC service 'exec 12 (/system/bin/fsverity_init --lock)' pid 444 (uid 0 gid 0+0 context default) started; waiting...
> [   18.083436][    T1] init: Command 'exec -- /system/bin/fsverity_init --lock' action=post-fs-data (/system/etc/init/hw/init.rc:1015) took 57ms and succeeded
> [   18.097684][    T1] init: Service 'exec 12 (/system/bin/fsverity_init --lock)' (pid 444) exited with status 0 waiting took 0.059000 seconds
> [   18.110371][    T1] init: Sending signal 9 to service 'exec 12 (/system/bin/fsverity_init --lock)' (pid 444) process group...
> [   18.122031][    T1] libprocessgroup: Successfully killed process cgroup uid 0 pid 444 in 0ms
> [   18.131315][    T1] init: Sending signal 9 to service 'odsign' (pid 441) process group...
> [   18.145970][    T1] libprocessgroup: Successfully killed process cgroup uid 0 pid 441 in 6ms
> [   18.155893][    T1] init: Control message: Processed ctl.stop for 'odsign' from pid: 441 (/system/bin/odsign)
> [   18.167387][    T1] init: Service 'odsign' (pid 441) received signal 9
> [   18.176769][    T1] init: starting service 'apexd-snapshotde'...
> [   18.186890][    T1] init: SVC_EXEC service 'apexd-snapshotde' pid 445 (uid 0 gid 1000+0 context default) started; waiting...
> [   18.198394][  T445] apexd: Snapshot DE subcommand detected
> [   18.205619][  T445] apexd-snapshotde: Marking APEXd as ready
> [   18.214561][    T1] init: Service 'apexd-snapshotde' (pid 445) exited with status 0 waiting took 0.029000 seconds
> [   18.224995][    T1] init: Sending signal 9 to service 'apexd-snapshotde' (pid 445) process group...
> [   18.234351][    T1] libprocessgroup: Successfully killed process cgroup uid 0 pid 445 in 0ms
> [   18.252841][    T1] init: processing action (post-fs-data) from (/system/etc/init/hw/init.usb.rc:6)
> [   18.262681][    T1] init: Verified that /data/adb has the encryption policy 3b9eba6cac88d3cedeaf38c4f5af933f v2 modes 1/4 flags 0xa
> [   18.274731][    T1] init: processing action (post-fs-data) from (/system/etc/init/bootstat.rc:9)
> [   18.285084][    T1] init: processing action (ro.debuggable=1 && post-fs-data) from (/system/etc/init/clean_scratch_files.rc:1)
> [   18.296892][    T1] init: starting service 'exec 13 (/system/bin/clean_scratch_files)'...
> [   18.326144][    T1] init: processing action (post-fs-data) from (/system/etc/init/gsid.rc:17)
> [   18.335128][    T1] init: Not setting encryption policy on: /data/gsi
> [   18.342366][    T1] init: processing action (post-fs-data) from (/system/etc/init/incidentd.rc:21)
> [   18.351713][    T1] init: Service 'exec 13 (/system/bin/clean_scratch_files)' (pid 446) exited with status 0 oneshot service took 0.045000 seconds in background
> [   18.366303][    T1] init: Sending signal 9 to service 'exec 13 (/system/bin/clean_scratch_files)' (pid 446) process group...
> [   18.377762][    T1] libprocessgroup: Successfully killed process cgroup uid 0 pid 446 in 0ms
> [   18.386631][    T1] init: processing action (post-fs-data) from (/system/etc/init/logtagd.rc:4)
> [   18.396415][    T1] init: processing action (post-fs-data) from (/system/etc/init/perfetto.rc:73)
> [   18.405829][    T1] init: Command 'rm /data/misc/perfetto-traces/.guardraildata' action=post-fs-data (/system/etc/init/perfetto.rc:74) took 0ms and failed: unlink() failed: No such file or directory
> [   18.423612][    T1] init: processing action (post-fs-data) from (/system/etc/init/profcollectd.rc:9)
> [   18.433457][    T1] init: processing action (post-fs-data) from (/system/etc/init/recovery-persist.rc:1)
> [   18.443202][    T1] init: starting service 'exec 14 (/system/bin/recovery-persist)'...
> [   18.462189][    T1] init: processing action (post-fs-data) from (/system/etc/init/wifi.rc:18)
> [   18.471779][    T1] selinux: SELinux: Skipping restorecon on directory(/data/misc/apexdata/com.android.wifi)
> [   18.481690][    T1] selinux: 
> [   18.484741][    T1] init: Service 'exec 14 (/system/bin/recovery-persist)' (pid 447) exited with status 0 oneshot service took 0.032000 seconds in background
> [   18.498976][    T1] init: Sending signal 9 to service 'exec 14 (/system/bin/recovery-persist)' (pid 447) process group...
> [   18.510138][    T1] libprocessgroup: Successfully killed process cgroup uid 1000 pid 447 in 0ms
> [   18.519098][    T1] init: processing action (post-fs-data) from (/vendor/etc/init/hostapd.android.rc:9)
> [   18.531706][    T1] init: processing action (post-fs-data) from (/vendor/etc/init/init.qcom.rc:44)
> [   18.541440][  T271] init: Top-level directory needs encryption action, eg mkdir /data/vendor <mode> <uid> <gid> encryption=Require
> [   18.553967][  T271] init: Verified that /data/vendor has the encryption policy 3b9eba6cac88d3cedeaf38c4f5af933f v2 modes 1/4 flags 0xa
> [   18.576639][    T1] init: starting service 'tqftpserv'...
> [   18.608111][    T1] init: starting service 'rmtfs'...
> [   18.616836][    T1] init: processing action (load_bpf_programs) from (/system/etc/init/bpfloader.rc:17)
> [   18.621899][  T450] remoteproc remoteproc0: powering up 4080000.remoteproc
> [   18.627120][    T1] init: starting service 'bpfloader'...
> [   18.635046][  T450] remoteproc remoteproc0: Booting fw image qcom/sdm845/mba.mbn, size 242400
> [   18.641974][    T1] init: SVC_EXEC service 'bpfloader' pid 451 (uid 0 gid 0+7 context default) started; waiting...
> [   18.690444][  T451] bpfloader: /apex/com.android.tethering/etc/flag/out-of-process exists.
> [   18.702369][  T451] LibBpfLoader: Section bpfloader_min_ver value is 2 [0x2]
> [   18.709536][  T451] LibBpfLoader: Section bpfloader_max_ver value is 25 [0x19]
> [   18.716922][  T451] LibBpfLoader: Section size_of_bpf_map_def value is 120 [0x78]
> [   18.721549][  T450] qcom-q6v5-mss 4080000.remoteproc: MBA booted without debug policy, loading mpss
> [   18.724509][  T451] LibBpfLoader: Section size_of_bpf_prog_def value is 92 [0x5c]
> [   18.741144][  T451] LibBpfLoader: BpfLoader version 0x0001c ignoring ELF object /apex/com.android.tethering/etc/bpf/test.o with max ver 0x00019
> [   18.754150][  T451] bpfloader: Loaded object: /apex/com.android.tethering/etc/bpf/test.o
> 
> Format: Log Type - Time(microsec) - Message - Optional Info
> Log Type: B - Since Boot(Power On Reset),  D - Delta,  S - Statistic
> S - QC_IMAGE_VERSION_STRING=BOOT.XF.2.0-00371-SDM845LZB-1
> S - IMAGE_VARIANT_STRING=SDM845LA
> S - OEM_IMAGE_VERSION_STRING=TSBJ-FA-PC-02170
> S - Boot Interface: UFS
> S - Secure Boot: Off
> S - Boot Config @ 0x00786070 = 0x000000c1
> S - JTAG ID @ 0x00786130 = 0x2008e0e1
> S - OEM ID @ 0x00786138 = 0x00000000
> S - Serial Number @ 0x00784138 = 0x710cee0b
> S - OEM Config Row 0 @ 0x00784188 = 0x0000000400000000
> S - OEM Config Row 1 @ 0x00784190 = 0x0000000000000000
> S - Feature Config Row 0 @ 0x007841a0 = 0x0050200080000400
> S - Feature Config Row 1 @ 0x007841a8 = 0xe000ffff00007fff
> S - Core 0 Frequency, 1516 MHz
> S - PBL Patch Ver: 1
> S - PBL freq: 600 MHZ
> B -        94 - PBL, Start
> B -      5279 - bootable_media_detect_entry
> B -     44107 - bootable_media_detect_success
> B -     44484 - elf_loader_entry
> B -     45046 - auth_hash_seg_entry
> B -     45243 - auth_hash_seg_exit
> B -     51101 - elf_segs_hash_verify_entry
> B -     57837 - elf_segs_hash_verify_exit
> B -     58466 - auth_xbl_sec_hash_seg_entry
> B -     65841 - auth_xbl_sec_hash_seg_exit
> B -     65843 - xbl_sec_segs_hash_verify_entry
> B -     66601 - xbl_sec_segs_hash_verify_exit
> B -     66626 - PBL, End
> B -     81099 - SBL1, Start
> B -    204960 - boot_flash_init, Start
> D -         0 - boot_flash_init, Delta
> B -    208498 - xblconfig_init, Start
> D -       488 - Auth Metadata
> D -    157776 - xblconfig_init, Delta
> B -    371246 - sbl1_ddr_set_default_params, Start
> D -        30 - sbl1_ddr_set_default_params, Delta
> B -    379237 - boot_config_data_table_init, Start
> B -    383873 - CDT not programmed, using default
> D -      4544 - boot_config_data_table_init, Delta - (54 Bytes)
> B -    398391 - CDT Version:3,Platform ID:8,Major ID:1,Minor ID:0,Subtype:0
> B -    404094 - pm_device_init, Start
> B -   1483733 - PM: PON REASON: PM0=0x8000024000020021:0x0 PM1=0x8000084000080020:0x0 PM2=0x8000084000080020:0x0 
> B -   1543910 - PM: SET_VAL:Skip
> D -   1140364 - pm_device_init, Delta
> B -   1546899 - pm_driver_init, Start
> D -      5337 - pm_driver_init, Delta
> B -   1555713 - PM: Trigger FG IMA Reset
> B -   1559312 - PM: Trigger FG IMA Reset.Completed
> B -   1568523 - PM: EntryVbat: 4218; EntrySOC: -1
> B -   1568554 - PM: ADSP result: 0
> B -   1573098 - PM: Manually set ICL 500mA
> B -   1576209 - PM: BATT TEMP: 29 DegC
> B -   1580205 - vsense_init, Start
> D -         0 - vsense_init, Delta
> B -   1616866 - Pre_DDR_clock_init, Start
> D -        61 - Pre_DDR_clock_init, Delta
> D -   1620678 - sbl1_ddr_set_params, Delta
> B -   1624399 - sbl1_ddr_init, Start
> B -   1628334 - Freeze IOs = 0x1, 0x1, 0x1, 0x1, DBG PDC Tr = 0x0, First Pass expire = 0x0, First Pass complete = 0x1
> D -      9058 - sbl1_ddr_init, Delta
> B -   1642242 - do_ddr_training, Start
> D -         0 - do_ddr_training, Delta
> B -   1648860 - pImem Init Start
> D -      4422 - pImem Init End, Delta
> B -   1660816 - clock_init, Start
> D -       244 - clock_init, Delta
> B -   1664141 - Image Load, Start
> D -      2836 - APDP Image Loaded, Delta - (0 Bytes)
> B -   1676127 - usb: chgr -  SDP_CHARGER
> B -   1676463 - usb: qusb2_1: hstx , 0x5
> B -   1679940 - usb: PLL1 locked , 0x5
> B -   1683508 - TCSR reg value 0x10 
> B -   1687138 - Image Load, Start
> D -       488 - Auth Metadata
> D -      2806 - Segments hash check
> D -     13633 - XBLRamDump Image Loaded, Delta - (582427 Bytes)
> B -   1780407 - DisplayLib: LAB/IBB GetStatus(LabVregOk) failed after 25ms
> 
> B -   1787483 - DisplayDxe: Resolution 1440x2560 (2 intf)
> 
> B -   2098979 - usb: init start
> B -   2100077 - usb: ss_lane_1st
> B -   2102151 - usb: usb_lane
> B -   2106025 - usb: qusb2_1: hstx , 0x5
> B -   2107702 - usb: PLL1 locked , 0x5
> B -   2111454 - usb: id_p , 0x1009b
> B -   2114778 - usb: VBUS High!
> B -   2215245 - usb: suspended
> B -   2403430 - usb: HIGH , 0x900e
> B -   2531957 - usb: HIGH , 0x900e
> B -   2634437 - usb: ENUM success

-- 
Catalin
