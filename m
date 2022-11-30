Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A10963E626
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 01:07:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230425AbiLAAHj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 19:07:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230345AbiLAAFe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 19:05:34 -0500
X-Greylist: delayed 610 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 30 Nov 2022 16:02:15 PST
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [IPv6:2001:67c:2050:0:465::202])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59219934EB
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 16:02:14 -0800 (PST)
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:b231:465::2])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4NMwwd1g7Pz9sTB;
        Thu,  1 Dec 2022 00:52:01 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
        t=1669852321;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=uNNxiVGGqpWV80Slt5P8A8GScfDCK4gk6xOaxWZuTa8=;
        b=tunh8+6VyUZP2iCAjzibr1P4HSM/vTcFrWPFXvm3NFQ1qYFyF5VtSreuqmLPYiiFpJI59j
        73aSH2D0qZdjeZlWdBd5cxKEBNYzBgrLjCc4xTfjJyVv+NBDwpJ4FWEvnDFzeKYnRTg4AO
        4N6BFnvNP3TKiXvjlq/OD8vSA3wG+emgeTiVnqSPw2588fak9Zs36RPIzrR+02KNj0UZr2
        i4rNNnbVroSKFybZ4GowadmOlzH+lLiva8hcnN4P4hsiwf12AViZBCqbbe4PWvDE16RtRP
        usOUDJtyZLPrJ3/S/imDhFzT4o3n9D0T6G7mURWreoxNOJF5iI95/kcCj9azoQ==
Date:   Thu, 1 Dec 2022 00:51:55 +0100
From:   "Erhard F." <erhard_f@mailbox.org>
To:     linux-kernel@vger.kernel.org
Cc:     peterz@infradead.org
Subject: BUG: spinlock trylock failure on UP on CPU#0, Xvnc/256
Message-ID: <20221201005155.09c54325@yea>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="MP_/xQFfg_Dl4TlDy/Gy8DdNHbA"
X-MBO-RS-ID: 5f4850156f3a8a4f7ea
X-MBO-RS-META: krte4sorwjyrz6u4rjfw3o54963a54dr
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--MP_/xQFfg_Dl4TlDy/Gy8DdNHbA
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Encountered this on my PowerMac G4 DP while building glibc in a session via TigerVNC.

[...]
BUG: spinlock trylock failure on UP on CPU#0, Xvnc/256
 lock: 0xd9651008, .magic: dead4ead, .owner: Xvnc/256, .owner_cpu: 0
CPU: 0 PID: 256 Comm: Xvnc Tainted: G                T  6.0.9-gentoo-PMacG4 #1
Call Trace:
[f2b91c80] [c05d2d0c] dump_stack_lvl+0x34/0x74 (unreliable)
[f2b91ca0] [c008f95c] do_raw_spin_trylock+0xac/0xb8
[f2b91cc0] [c0937a3c] _raw_spin_trylock+0x10/0x44
[f2b91cd0] [c02204e4] z3fold_zpool_free+0x410/0x594
[f2b91d10] [c01f5810] zswap_free_entry+0xd8/0x198
[f2b91d30] [c01f5a28] zswap_frontswap_invalidate_page+0xec/0xf0
[f2b91d50] [c01f4be4] __frontswap_invalidate_page+0x5c/0xd4
[f2b91d70] [c01effd4] swapcache_free_entries+0x310/0x478
[f2b91dc0] [c01f45a0] free_swap_slot+0x138/0x158
[f2b91de0] [c01efc68] put_swap_page+0xb8/0x114
[f2b91e00] [c01ec758] delete_from_swap_cache+0x78/0xe8
[f2b91e20] [c01f0694] try_to_free_swap+0xf0/0x13c
[f2b91e40] [c01c4c1c] do_swap_page+0x594/0x9d8
[f2b91e80] [c01c5b44] handle_mm_fault+0x760/0xe34
[f2b91f00] [c001eaa0] do_page_fault+0x1c0/0x814
[f2b91f30] [c000433c] DataAccess_virt+0x124/0x17c
--- interrupt: 300 at 0xa7183884
NIP:  a7183884 LR: a71837e4 CTR: a71838f4
REGS: f2b91f40 TRAP: 0300   Tainted: G                T   (6.0.9-gentoo-PMacG4)
MSR:  0000f932 <EE,PR,FP,ME,IR,DR,RI>  CR: 24002428  XER: 20000000
DAR: 017d2750 DSISR: 42000000 
GPR00: 00651904 afccb070 a7e5d5a0 017d2750 00000006 00000070 a72733e0 ff000000 
GPR08: 017d273c 017d2750 a6494c10 a7183698 a71837e4 0072fff4 afccc6a4 afccc6a8 
GPR16: 00734474 0073424c 00734470 00734248 0073446c 00000000 a7e56764 00000000 
GPR24: 00000001 00000006 016f9d50 017d2750 000001b0 017d2750 a72dfff4 a6494c20 
NIP [a7183884] 0xa7183884
LR [a71837e4] 0xa71837e4
--- interrupt: 300[...]
[...]

Some data about the machine:
 # inxi -bZ
System:
  Host: T600 Kernel: 6.0.9-gentoo-PMacG4 arch: ppc bits: 32
    Console: pty pts/0 Distro: Gentoo Base System release 2.9
Machine:
  Type: PPC System: PowerMac3 6 details: N/A
    mobo: PowerMac3,6 MacRISC3 Power Macintosh serial: P6N
CPU:
  Info: single core 7455 altivec supported [UP] speed (MHz): 1417
Graphics:
  Device-1: AMD RV350 [Radeon 9550/9600/X1050 Series] driver: radeon
    v: kernel
  Display: x11 server: X.org v: 1.21.1.4 driver: X: loaded: radeon
    unloaded: fbdev,modesetting gpu: radeon
    resolution: <missing: xdpyinfo/xrandr>
  OpenGL: renderer: softpipe v: 3.3 Mesa 22.2.3
Network:
  Device-1: Broadcom BCM4306 802.11b/g Wireless LAN driver: b43-pci-bridge
  Device-2: Apple UniNorth 2 GMAC driver: gem
  Device-3: gmac driver: gem


The G4 DP got 2 CPUs but I am running it with a single core only due to https://bugzilla.kernel.org/show_bug.cgi?id=215389. Another locking bug I got on this machine is https://bugzilla.kernel.org/show_bug.cgi?id=216723 (here with a .config utilizing both CPUs). Don't know whether this might be related.

This has been https://bugzilla.kernel.org/show_bug.cgi?id=216734 but I was suggested to better post issues like this here on the mailing list.

Kernel dmesg and .config attached.

Cheers,
Erhard F.

--MP_/xQFfg_Dl4TlDy/Gy8DdNHbA
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename=dmesg_609_g4s.txt

Total memory = 2048MB; using 4096kB for hash table
Activating Kernel Userspace Access Protection
Activating Kernel Userspace Execution Prevention
Linux version 6.0.9-gentoo-PMacG4 (root@T800) (gcc (Gentoo 12.2.1_p20221008 p1) 12.2.1 20221008, GNU ld (Gentoo 2.39 p5) 2.39.0) #1 Wed Nov 23 00:45:48 CET 2022
ioremap() called early from pmac_feature_init+0x144/0x1090. Use early_ioremap() instead
Found UniNorth memory controller & host bridge @ 0xf8000000 revision: 0x24
Mapped at 0xff3bf000
ioremap() called early from probe_one_macio+0x1d4/0x3c8. Use early_ioremap() instead
Found a Keylargo mac-io controller, rev: 3, mapped at 0x(ptrval)
PowerMac motherboard: PowerMac G4 Windtunnel
ioremap() called early from btext_map+0x64/0xdc. Use early_ioremap() instead
Using PowerMac machine description
printk: bootconsole [udbg0] enabled
-----------------------------------------------------
phys_mem_size     = 0x80000000
dcache_bsize      = 0x20
icache_bsize      = 0x20
cpu_features      = 0x000000002514600a
  possible        = 0x00000000277de00a
  always          = 0x0000000000000000
cpu_user_features = 0x9c000001 0x00000000
mmu_features      = 0x00010001
Hash_size         = 0x400000
Hash_mask         = 0xffff
-----------------------------------------------------
ioremap() called early from pmac_setup_arch+0x1ac/0x448. Use early_ioremap() instead
ioremap() called early from find_via_pmu+0x2e8/0x7f8. Use early_ioremap() instead
ioremap() called early from find_via_pmu+0x33c/0x7f8. Use early_ioremap() instead
via-pmu: Server Mode is disabled
PMU driver v2 initialized for Core99, firmware: 0c
ioremap() called early from pmac_nvram_init+0x1cc/0x734. Use early_ioremap() instead
nvram: Checking bank 0...
nvram: gen0=3116, gen1=3115
nvram: Active bank is: 0
nvram: OF partition at 0x410
nvram: XP partition at 0x1020
nvram: NR partition at 0x1120
Zone ranges:
  DMA      [mem 0x0000000000000000-0x000000002fffffff]
  Normal   empty
  HighMem  [mem 0x0000000030000000-0x000000007fffffff]
Movable zone start for each node
Early memory node ranges
  node   0: [mem 0x0000000000000000-0x000000007fffffff]
Initmem setup node 0 [mem 0x0000000000000000-0x000000007fffffff]
Built 1 zonelists, mobility grouping on.  Total pages: 522560
Kernel command line: ro root=/dev/sda5 zswap.max_pool_percent=16 zswap.zpool=z3fold slub_debug=FZP page_poison=1 netconsole=6666@192.168.178.8/eth0,6666@192.168.178.3/70:85:C2:30:EC:01 
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes, linear)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes, linear)
mem auto-init: stack:all(pattern), heap alloc:off, heap free:off
Kernel virtual memory layout:
  * 0xffbcf000..0xfffff000  : fixmap
  * 0xff400000..0xff800000  : highmem PTEs
  * 0xff115000..0xff400000  : early ioremap
  * 0xf1000000..0xff115000  : vmalloc & ioremap
  * 0xb0000000..0xc0000000  : modules
Memory: 2056332K/2097152K available (9444K kernel code, 520K rwdata, 1756K rodata, 1308K init, 422K bss, 40820K reserved, 0K cma-reserved, 1310720K highmem)
SLUB: HWalign=32, Order=0-3, MinObjects=0, CPUs=1, Nodes=1
NR_IRQS: 512, nr_irqs: 512, preallocated irqs: 16
mpic: Setting up MPIC " MPIC 1   " version 1.2 at 80040000, max 1 CPUs
mpic: ISU size: 64, shift: 6, mask: 3f
mpic: Initializing for 64 sources
kfence: initialized - using 2097152 bytes for 255 objects at 0x(ptrval)-0x(ptrval)
clocksource: timebase: mask: 0xffffffffffffffff max_cycles: 0x99b9699db, max_idle_ns: 440795204297 ns
clocksource: timebase mult[18012db2] shift[24] registered
Console: colour dummy device 80x25
printk: console [tty0] enabled
printk: bootconsole [udbg0] disabled
pid_max: default: 32768 minimum: 301
LSM: Security Framework initializing
Yama: becoming mindful.
Stack Depot allocating hash table of 65536 entries with kvcalloc
Mount-cache hash table entries: 2048 (order: 1, 8192 bytes, linear)
Mountpoint-cache hash table entries: 2048 (order: 1, 8192 bytes, linear)
cblist_init_generic: Setting adjustable number of callback queues.
cblist_init_generic: Setting shift to 0 and lim to 1.
devtmpfs: initialized
Duplicate name in PowerPC,G4@0, renamed to "l2-cache#1"
Duplicate name in l2-cache#1, renamed to "l2-cache#1"
Duplicate name in PowerPC,G4@1, renamed to "l2-cache#1"
Duplicate name in l2-cache#1, renamed to "l2-cache#1"
Duplicate name in gpio@50, renamed to "gpio5@6f#1"
Duplicate name in gpio@50, renamed to "gpio6@70#1"
Duplicate name in gpio@50, renamed to "gpio11@75#1"
Duplicate name in gpio@50, renamed to "extint-gpio15@67#1"
Found UniNorth PCI host bridge at 0x00000000f0000000. Firmware bus number: 0->0
PCI host bridge /pci@f0000000  ranges:
 MEM 0x00000000f1000000..0x00000000f1ffffff -> 0x00000000f1000000 
  IO 0x00000000f0000000..0x00000000f07fffff -> 0x0000000000000000
 MEM 0x0000000090000000..0x00000000afffffff -> 0x0000000090000000 
Found UniNorth PCI host bridge at 0x00000000f2000000. Firmware bus number: 0->0
PCI host bridge /pci@f2000000 (primary) ranges:
 MEM 0x00000000f3000000..0x00000000f3ffffff -> 0x00000000f3000000 
  IO 0x00000000f2000000..0x00000000f27fffff -> 0x0000000000000000
 MEM 0x0000000080000000..0x000000008fffffff -> 0x0000000080000000 
Found UniNorth PCI host bridge at 0x00000000f4000000. Firmware bus number: 0->0
PCI host bridge /pci@f4000000  ranges:
 MEM 0x00000000f5000000..0x00000000f5ffffff -> 0x00000000f5000000 
  IO 0x00000000f4000000..0x00000000f47fffff -> 0x0000000000000000
Found NEC PD720100A USB2 chip with disabled EHCI, fixing up...
clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 6370867519511994 ns
futex hash table entries: 256 (order: 0, 7168 bytes, linear)
NET: Registered PF_NETLINK/PF_ROUTE protocol family
thermal_sys: Registered thermal governor 'fair_share'
thermal_sys: Registered thermal governor 'step_wise'
KeyWest i2c @0xf8001003 irq 42 /uni-n@f8000000/i2c@f8001000
 channel 0 bus <multibus>
 channel 1 bus <multibus>
KeyWest i2c @0x80018000 irq 26 /pci@f2000000/mac-io@17/i2c@18000
 channel 0 bus <multibus>
PMU i2c /pci@f2000000/mac-io@17/via-pmu@16000/pmu-i2c
 channel 1 bus <multibus>
 channel 2 bus <multibus>
pmf: no parser for command 17 !
sysfs: cannot create duplicate filename '/devices/platform/of-display'
CPU: 0 PID: 1 Comm: swapper Tainted: G                T  6.0.9-gentoo-PMacG4 #1
Call Trace:
[f101dcb0] [c05d2d0c] dump_stack_lvl+0x34/0x74 (unreliable)
[f101dcd0] [c02dbd64] sysfs_warn_dup+0x64/0x84
[f101dcf0] [c02dbf34] sysfs_create_dir_ns+0x130/0x14c
[f101dd20] [c05dbacc] kobject_add_internal+0x144/0x350
[f101dd50] [c05dc420] kobject_add+0x9c/0x110
[f101dd90] [c069b8a4] device_add+0xd4/0x9a4
[f101de00] [c07506c4] of_platform_device_create_pdata+0xb0/0x138
[f101de30] [c0c41d80] of_platform_default_populate_init+0x284/0x30c
[f101de60] [c0007ac8] do_one_initcall+0x64/0x2cc
[f101ded0] [c0c044cc] kernel_init_freeable+0x20c/0x340
[f101df10] [c0007f24] kernel_init+0x28/0x150
[f101df30] [c001a334] ret_from_kernel_thread+0x5c/0x64
kobject_add_internal failed for of-display with -EEXIST, don't try to register things with the same name in the same directory.
PCI: Probing PCI hardware
PCI host bridge to bus 0000:00
pci_bus 0000:00: root bus resource [io  0xff780000-0xfff7ffff] (bus address [0x0000-0x7fffff])
pci_bus 0000:00: root bus resource [mem 0xf1000000-0xf1ffffff]
pci_bus 0000:00: root bus resource [mem 0x90000000-0xafffffff]
pci_bus 0000:00: root bus resource [bus 00-ff]
pci_bus 0000:00: busn_res: [bus 00-ff] end is updated to ff
pci 0000:00:0b.0: [106b:0034] type 00 class 0x060000
pci 0000:00:10.0: [1002:4150] type 00 class 0x030000
pci 0000:00:10.0: reg 0x10: [mem 0xa0000000-0xafffffff pref]
pci 0000:00:10.0: reg 0x14: [io  0xff780400-0xff7804ff]
pci 0000:00:10.0: reg 0x18: [mem 0x90000000-0x9000ffff]
pci 0000:00:10.0: reg 0x30: [mem 0x90020000-0x9003ffff pref]
pci 0000:00:10.0: supports D1 D2
pci_bus 0000:00: busn_res: [bus 00-ff] end is updated to 00
OF: /pci@f2000000/mac-io@17/gpio@50/gpio5@6f: could not find phandle 1751474532
OF: /pci@f2000000/mac-io@17/gpio@50/extint-gpio15@67: could not find phandle 1751474532
OF: /pci@f2000000/mac-io@17/gpio@50/gpio6@70: could not find phandle 1634562093
OF: /pci@f2000000/mac-io@17/gpio@50/extint-gpio16@68: could not find phandle 1936745825
OF: /pci@f2000000/mac-io@17/gpio@50/extint-gpio14@66: could not find phandle 1818848869
OF: /pci@f2000000/mac-io@17/gpio@50/gpio12@76: could not find phandle 1835103092
OF: /pci@f2000000/mac-io@17/gpio@50/gpio11@75: could not find phandle 1635083369
OF: /pci@f2000000/mac-io@17/gpio@50/gpio5@6f: could not find phandle 1751474532
OF: /pci@f2000000/mac-io@17/gpio@50/gpio6@70: could not find phandle 1634562093
OF: /pci@f2000000/mac-io@17/gpio@50/extint-gpio4@5c: could not find phandle 1818848869
OF: /pci@f2000000/mac-io@17/gpio@50/gpio11@75: could not find phandle 1635083369
OF: /pci@f2000000/mac-io@17/gpio@50/extint-gpio15@67: could not find phandle 1751474532
PCI host bridge to bus 0001:10
pci_bus 0001:10: root bus resource [io  0x0000-0x7fffff]
pci_bus 0001:10: root bus resource [mem 0xf3000000-0xf3ffffff]
pci_bus 0001:10: root bus resource [mem 0x80000000-0x8fffffff]
pci_bus 0001:10: root bus resource [bus 10-ff]
pci_bus 0001:10: busn_res: [bus 10-ff] end is updated to ff
pci 0001:10:0b.0: [106b:0035] type 00 class 0x060000
pci 0001:10:12.0: [1033:0035] type 00 class 0x0c0310
pci 0001:10:12.0: reg 0x10: [mem 0x8008c000-0x8008cfff]
pci 0001:10:12.0: supports D1 D2
pci 0001:10:12.0: PME# supported from D0 D1 D2 D3hot
pci 0001:10:12.1: [1033:0035] type 00 class 0x0c0310
pci 0001:10:12.1: reg 0x10: [mem 0x8008b000-0x8008bfff]
pci 0001:10:12.1: supports D1 D2
pci 0001:10:12.1: PME# supported from D0 D1 D2 D3hot
pci 0001:10:12.2: [1033:00e0] type 00 class 0x0c0320
pci 0001:10:12.2: reg 0x10: [mem 0x80081000-0x800810ff]
pci 0001:10:12.2: supports D1 D2
pci 0001:10:12.2: PME# supported from D0 D1 D2 D3hot
pci 0001:10:13.0: [1095:3112] type 00 class 0x018000
pci 0001:10:13.0: reg 0x10: [io  0x0460-0x0467]
pci 0001:10:13.0: reg 0x14: [io  0x0450-0x0453]
pci 0001:10:13.0: reg 0x18: [io  0x0440-0x0447]
pci 0001:10:13.0: reg 0x1c: [io  0x0430-0x0433]
pci 0001:10:13.0: reg 0x20: [io  0x0420-0x042f]
pci 0001:10:13.0: reg 0x24: [mem 0x80082000-0x800821ff]
pci 0001:10:13.0: reg 0x30: [mem 0x80100000-0x8017ffff pref]
pci 0001:10:13.0: supports D1 D2
pci 0001:10:15.0: [9710:9865] type 00 class 0x070002
pci 0001:10:15.0: reg 0x10: [io  0x0410-0x0417]
pci 0001:10:15.0: reg 0x14: [mem 0x8008a000-0x8008afff]
pci 0001:10:15.0: reg 0x20: [mem 0x80089000-0x80089fff]
pci 0001:10:15.0: supports D1 D2
pci 0001:10:15.0: PME# supported from D0 D1 D2 D3hot D3cold
pci 0001:10:15.1: [9710:9865] type 00 class 0x070002
pci 0001:10:15.1: reg 0x10: [io  0x0400-0x0407]
pci 0001:10:15.1: reg 0x14: [mem 0x80088000-0x80088fff]
pci 0001:10:15.1: reg 0x20: [mem 0x80087000-0x80087fff]
pci 0001:10:15.1: supports D1 D2
pci 0001:10:15.1: PME# supported from D0 D1 D2 D3hot D3cold
pci 0001:10:15.2: [ffff:9865] type 00 class 0x070103
pci 0001:10:15.2: reg 0x10: [io  0x0000-0x0007]
pci 0001:10:15.2: reg 0x14: [io  0x0000-0x0007]
pci 0001:10:15.2: reg 0x18: [mem 0x00000000-0x00000fff]
pci 0001:10:15.2: reg 0x20: [mem 0x00000000-0x00000fff]
pci 0001:10:15.2: supports D1 D2
pci 0001:10:15.2: PME# supported from D0 D1 D2 D3hot D3cold
pci 0001:10:16.0: [14e4:4320] type 00 class 0x028000
pci 0001:10:16.0: reg 0x10: [mem 0x8008e000-0x8008ffff]
pci 0001:10:16.0: supports D1 D2
pci 0001:10:16.0: PME# supported from D0 D1 D2 D3hot D3cold
pci 0001:10:17.0: [106b:0022] type 00 class 0xff0000
pci 0001:10:17.0: reg 0x10: [mem 0x80000000-0x8007ffff]
pci 0001:10:18.0: [106b:0019] type 00 class 0x0c0310
pci 0001:10:18.0: reg 0x10: [mem 0x80086000-0x80086fff]
pci 0001:10:19.0: [106b:0019] type 00 class 0x0c0310
pci 0001:10:19.0: reg 0x10: [mem 0x80085000-0x80085fff]
pci 0001:10:1b.0: [1033:0035] type 00 class 0x0c0310
pci 0001:10:1b.0: reg 0x10: [mem 0x80084000-0x80084fff]
pci 0001:10:1b.0: supports D1 D2
pci 0001:10:1b.0: PME# supported from D0 D1 D2 D3hot D3cold
pci 0001:10:1b.1: [1033:0035] type 00 class 0x0c0310
pci 0001:10:1b.1: reg 0x10: [mem 0x80083000-0x80083fff]
pci 0001:10:1b.1: supports D1 D2
pci 0001:10:1b.1: PME# supported from D0 D1 D2 D3hot D3cold
pci 0001:10:1b.2: [1033:00e0] type 00 class 0x0c0320
pci 0001:10:1b.2: reg 0x10: [mem 0x80080000-0x800800ff]
pci 0001:10:1b.2: supports D1 D2
pci 0001:10:1b.2: PME# supported from D0 D1 D2 D3hot D3cold
pci_bus 0001:10: busn_res: [bus 10-ff] end is updated to 10
PCI host bridge to bus 0002:20
pci_bus 0002:20: root bus resource [io  0x880000-0x107ffff] (bus address [0x0000-0x7fffff])
pci_bus 0002:20: root bus resource [mem 0xf5000000-0xf5ffffff]
pci_bus 0002:20: root bus resource [bus 20-ff]
pci_bus 0002:20: busn_res: [bus 20-ff] end is updated to ff
pci 0002:20:0b.0: [106b:0036] type 00 class 0x060000
pci 0002:20:0d.0: [106b:0033] type 00 class 0xff0000
pci 0002:20:0d.0: reg 0x10: [mem 0xf5004000-0xf5007fff]
pci 0002:20:0e.0: [106b:0031] type 00 class 0x0c0010
pci 0002:20:0e.0: reg 0x10: [mem 0xf5000000-0xf5000fff]
pci 0002:20:0e.0: supports D1 D2
pci 0002:20:0e.0: PME# supported from D0 D1 D2 D3hot
pci 0002:20:0f.0: [106b:0032] type 00 class 0x020000
pci 0002:20:0f.0: reg 0x10: [mem 0xf5200000-0xf53fffff]
pci 0002:20:0f.0: reg 0x30: [mem 0xf5100000-0xf51fffff pref]
pci_bus 0002:20: busn_res: [bus 20-ff] end is updated to 20
pci_bus 0000:00: resource 4 [io  0xff780000-0xfff7ffff]
pci_bus 0000:00: resource 5 [mem 0xf1000000-0xf1ffffff]
pci_bus 0000:00: resource 6 [mem 0x90000000-0xafffffff]
pci 0001:10:15.2: BAR 2: assigned [mem 0xf3000000-0xf3000fff]
pci 0001:10:15.2: BAR 4: assigned [mem 0xf3001000-0xf3001fff]
pci 0001:10:15.2: BAR 0: assigned [io  0x1000-0x1007]
pci 0001:10:15.2: BAR 1: assigned [io  0x1008-0x100f]
pci_bus 0001:10: resource 4 [io  0x0000-0x7fffff]
pci_bus 0001:10: resource 5 [mem 0xf3000000-0xf3ffffff]
pci_bus 0001:10: resource 6 [mem 0x80000000-0x8fffffff]
pci_bus 0002:20: resource 4 [io  0x880000-0x107ffff]
pci_bus 0002:20: resource 5 [mem 0xf5000000-0xf5ffffff]
raid6: altivecx8 gen()  3380 MB/s
raid6: altivecx4 gen()  3473 MB/s
raid6: altivecx2 gen()  3461 MB/s
raid6: altivecx1 gen()  3351 MB/s
raid6: int32x8  gen()   736 MB/s
raid6: int32x4  gen()  1026 MB/s
raid6: int32x2  gen()   961 MB/s
raid6: int32x1  gen()   764 MB/s
raid6: using algorithm altivecx4 gen() 3473 MB/s
raid6: using intx1 recovery algorithm
SCSI subsystem initialized
pci 0000:00:10.0: vgaarb: setting as boot VGA device
pci 0000:00:10.0: vgaarb: bridge control possible
pci 0000:00:10.0: vgaarb: VGA device added: decodes=io+mem,owns=mem,locks=none
vgaarb: loaded
clocksource: Switched to clocksource timebase
NET: Registered PF_INET protocol family
IP idents hash table entries: 16384 (order: 5, 131072 bytes, linear)
tcp_listen_portaddr_hash hash table entries: 512 (order: 1, 10240 bytes, linear)
Table-perturb hash table entries: 65536 (order: 6, 262144 bytes, linear)
TCP established hash table entries: 8192 (order: 3, 32768 bytes, linear)
TCP bind hash table entries: 8192 (order: 5, 163840 bytes, linear)
TCP: Hash tables configured (established 8192 bind 8192)
UDP hash table entries: 512 (order: 2, 24576 bytes, linear)
UDP-Lite hash table entries: 512 (order: 2, 24576 bytes, linear)
NET: Registered PF_UNIX/PF_LOCAL protocol family
pci 0001:10:12.0: enabling device (0000 -> 0002)
pci 0001:10:12.1: enabling device (0000 -> 0002)
pci 0001:10:12.2: enabling device (0004 -> 0006)
Apple USB OHCI 0001:10:18.0 disabled by firmware
pci 0001:10:18.0: Can't enable PCI device, BIOS handoff failed.
Apple USB OHCI 0001:10:19.0 disabled by firmware
pci 0001:10:19.0: Can't enable PCI device, BIOS handoff failed.
pci 0001:10:1b.0: enabling device (0000 -> 0002)
pci 0001:10:1b.1: enabling device (0000 -> 0002)
pci 0001:10:1b.2: enabling device (0004 -> 0006)
pci 0002:20:0f.0: CLS mismatch (32 != 1020), using 32 bytes
Thermal assist unit not available
Initialise system trusted keyrings
workingset: timestamp_bits=14 max_order=19 bucket_order=5
NET: Registered PF_ALG protocol family
xor: measuring software checksum speed
   8regs           :  1329 MB/sec
   8regs_prefetch  :  1220 MB/sec
   32regs          :  1329 MB/sec
   32regs_prefetch :  1220 MB/sec
   altivec         :  4874 MB/sec
xor: using function: altivec (4874 MB/sec)
Key type asymmetric registered
Asymmetric key parser 'x509' registered
alg: self-tests for CTR-KDF (hmac(sha256)) passed
bounce: pool size: 64 pages
Block layer SCSI generic (bsg) driver version 0.4 loaded (major 251)
io scheduler kyber registered
io scheduler bfq registered
Using unsupported 1920x1080 (null) at a0008000, depth=8, pitch=2048
Console: switching to colour frame buffer device 240x67
fb0: Open Firmware frame buffer device on /pci@f0000000/ATY,AlteracParent@10/ATY,Alterac_A@0
MacIO PCI driver attached to Keylargo chipset
0.00013020:ch-a: ttyPZ0 at MMIO 0x80013020 (irq = 22, base_baud = 230400) is a Z85c30 ESCC - Serial port
0.00013000:ch-b: ttyPZ1 at MMIO 0x80013000 (irq = 23, base_baud = 230400) is a Z85c30 ESCC - Serial port
sata_sil 0001:10:13.0: enabling device (0004 -> 0007)
scsi host0: sata_sil
scsi host1: sata_sil
ata1: SATA max UDMA/100 mmio m512@0x80082000 tf 0x80082080 irq 53
ata2: SATA max UDMA/100 mmio m512@0x80082000 tf 0x800820c0 irq 53
pata-pci-macio 0002:20:0d.0: enabling device (0004 -> 0006)
pata-pci-macio 0002:20:0d.0: Activating pata-macio chipset UniNorth ATA-6, Apple bus ID 3
scsi host2: pata_macio
ata3: PATA max UDMA/100 irq 39
ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
ata1.00: ATA-9: SanDisk SSD PLUS 240GB, UF4500RL, max UDMA/133
ata1.00: 468877312 sectors, multi 1: LBA48 NCQ (depth 0/32)
ata1.00: Features: Dev-Sleep
ata1.00: configured for UDMA/100
scsi 0:0:0:0: Direct-Access     ATA      SanDisk SSD PLUS 00RL PQ: 0 ANSI: 5
sd 0:0:0:0: [sda] 468877312 512-byte logical blocks: (240 GB/224 GiB)
sd 0:0:0:0: [sda] Write Protect is off
sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
sd 0:0:0:0: [sda] Preferred minimum I/O size 512 bytes
 sda: [mac] sda1 sda2 sda3 sda4 sda5 sda6 sda7 sda8
sd 0:0:0:0: [sda] Attached SCSI disk
ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
ata2.00: ATA-9: WDC WD5000LPLX-60ZNTT1, 02.01A02, max UDMA/133
ata2.00: 976773168 sectors, multi 0: LBA48 NCQ (depth 0/32)
ata2.00: configured for UDMA/100
scsi 1:0:0:0: Direct-Access     ATA      WDC WD5000LPLX-6 1A02 PQ: 0 ANSI: 5
sd 1:0:0:0: [sdb] 976773168 512-byte logical blocks: (500 GB/466 GiB)
sd 1:0:0:0: [sdb] 4096-byte physical blocks
sd 1:0:0:0: [sdb] Write Protect is off
sd 1:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
sd 1:0:0:0: [sdb] Preferred minimum I/O size 4096 bytes
pata-macio 0.0001f000:ata-4: Activating pata-macio chipset KeyLargo ATA-4, Apple bus ID 2
scsi host3: pata_macio
ata4: PATA max UDMA/66 irq 19
ata4.00: CFA: DeLOCK 54143 512MB, 100511E, max UDMA/66
ata4.00: 1009008 sectors, multi 1: LBA 
 sdb: [mac] sdb1 sdb2 sdb3 sdb4 sdb5 sdb6 sdb7 sdb8
sd 1:0:0:0: [sdb] Attached SCSI disk
scsi 3:0:0:0: Direct-Access     ATA      DeLOCK 54143 512 11E  PQ: 0 ANSI: 5
sd 3:0:0:0: [sdc] 1009008 512-byte logical blocks: (517 MB/493 MiB)
sd 3:0:0:0: [sdc] Write Protect is off
sd 3:0:0:0: [sdc] Write cache: disabled, read cache: enabled, doesn't support DPO or FUA
sd 3:0:0:0: [sdc] Preferred minimum I/O size 512 bytes
 sdc: [mac] sdc1 sdc2 sdc3 sdc4 sdc5 sdc6
sd 3:0:0:0: [sdc] Attached SCSI disk
pata-macio 0.00020000:ata-3: Activating pata-macio chipset KeyLargo ATA-3, Apple bus ID 0
scsi host4: pata_macio
ata5: PATA max MWDMA2 irq 20
sungem.c:v1.0 David S. Miller <davem@redhat.com>
gem 0002:20:0f.0 eth0: Sun GEM (PCI) 10/100/1000BaseT Ethernet 00:0a:95:9c:76:3a
rtc-generic rtc-generic: registered as rtc0
i2c_dev: i2c /dev entries driver
PowerMac i2c bus pmu 2 registered
PowerMac i2c bus pmu 1 registered
PowerMac i2c bus mac-io 0 registered
i2c i2c-2: No i2c address for /pci@f2000000/mac-io@17/i2c@18000/i2c-modem
PowerMac i2c bus uni-n 1 registered
i2c i2c-3: i2c-powermac: modalias failure on /uni-n@f8000000/i2c@f8001000/cereal@1c0
PowerMac i2c bus uni-n 0 registered
ledtrig-cpu: registered to indicate activity on CPUs
NET: Registered PF_INET6 protocol family
Segment Routing with IPv6
In-situ OAM (IOAM) with IPv6
NET: Registered PF_PACKET protocol family
drmem: No dynamic reconfiguration memory found
ata5.00: ATAPI: _NEC DVD_RW ND-3520A, 1.04, max UDMA/33
registered taskstats version 1
Loading compiled-in X.509 certificates
scsi 4:0:0:0: CD-ROM            _NEC     DVD_RW ND-3520A  1.04 PQ: 0 ANSI: 5
zswap: loaded using pool lzo/z3fold
debug_vm_pgtable: [debug_vm_pgtable         ]: Validating architecture page table helpers
Btrfs loaded, crc32c=crc32c-generic, zoned=no, fsverity=no
input: PMU as /devices/virtual/input/input0
netpoll: netconsole: local port 6666
netpoll: netconsole: local IPv4 address 192.168.178.8
netpoll: netconsole: interface 'eth0'
netpoll: netconsole: remote port 6666
netpoll: netconsole: remote IPv4 address 192.168.178.3
netpoll: netconsole: remote ethernet address 70:85:c2:30:ec:01
netpoll: netconsole: device eth0 not up yet, forcing it
gem 0002:20:0f.0 eth0: Found BCM5421 PHY
gem 0002:20:0f.0 eth0: Link is up at 1000 Mbps, full-duplex
gem 0002:20:0f.0 eth0: Pause is enabled (rxfifo: 10240 off: 7168 on: 5632)
IPv6: ADDRCONF(NETDEV_CHANGE): eth0: link becomes ready
printk: console [netcon0] enabled
netconsole: network logging started
EXT4-fs (sda5): mounted filesystem with ordered data mode. Quota mode: disabled.
VFS: Mounted root (ext4 filesystem) readonly on device 8:5.
devtmpfs: mounted
Freeing unused kernel image (initmem) memory: 1308K
Checked W+X mappings: passed, no W+X pages found
rodata_test: all tests were successful
Run /sbin/init as init process
systemd[1]: systemd 251 running in system mode (+PAM -AUDIT -SELINUX -APPARMOR +IMA +SMACK +SECCOMP +GCRYPT -GNUTLS +OPENSSL +ACL +BLKID -CURL +ELFUTILS -FIDO2 +IDN2 -IDN -IPTC +KMOD -LIBCRYPTSETUP +LIBFDISK +PCRE2 -PWQUALITY -P11KIT -QRENCODE -TPM2 -BZIP2 +LZ4 -XZ -ZLIB +ZSTD -BPF_FRAMEWORK -XKBCOMMON +UTMP +SYSVINIT default-hierarchy=unified)
systemd[1]: Detected architecture ppc.
systemd[1]: Hostname set to <T600>.
systemd[1]: Queued start job for default target Graphical Interface.
systemd[1]: Created slice Slice /system/getty.
systemd[1]: Created slice Slice /system/modprobe.
systemd[1]: Created slice Slice /system/systemd-fsck.
systemd[1]: Created slice Slice /system/vncserver.
systemd[1]: Created slice User and Session Slice.
systemd[1]: Started Dispatch Password Requests to Console Directory Watch.
systemd[1]: Started Forward Password Requests to Wall Directory Watch.
systemd[1]: Arbitrary Executable File Formats File System Automount Point was skipped because of a failed condition check (ConditionPathExists=/proc/sys/fs/binfmt_misc).
systemd[1]: Reached target Path Units.
systemd[1]: Reached target Remote File Systems.
systemd[1]: Reached target Slice Units.
systemd[1]: Listening on Process Core Dump Socket.
systemd[1]: Listening on initctl Compatibility Named Pipe.
systemd[1]: Journal Audit Socket was skipped because of a failed condition check (ConditionSecurity=audit).
systemd[1]: Listening on Journal Socket (/dev/log).
systemd[1]: Listening on Journal Socket.
systemd[1]: Listening on udev Control Socket.
systemd[1]: Listening on udev Kernel Socket.
systemd[1]: Huge Pages File System was skipped because of a failed condition check (ConditionPathExists=/sys/kernel/mm/hugepages).
systemd[1]: Mounting POSIX Message Queue File System...
systemd[1]: Kernel Debug File System was skipped because of a failed condition check (ConditionPathExists=/sys/kernel/debug).
systemd[1]: Kernel Trace File System was skipped because of a failed condition check (ConditionPathExists=/sys/kernel/tracing).
systemd[1]: Starting Create List of Static Device Nodes...
systemd[1]: Starting Load Kernel Module configfs...
systemd[1]: Starting Load Kernel Module drm...
systemd[1]: Starting Load Kernel Module fuse...
fuse: init (API version 7.36)
systemd[1]: Starting File System Check on Root Device...
systemd[1]: Starting Journal Service...
systemd[1]: Starting Load Kernel Modules...
systemd[1]: Repartition Root Disk was skipped because all trigger condition checks failed.
systemd[1]: Starting Coldplug All udev Devices...
systemd[1]: Mounted POSIX Message Queue File System.
systemd[1]: Finished Create List of Static Device Nodes.
systemd[1]: modprobe@configfs.service: Deactivated successfully.
systemd[1]: Finished Load Kernel Module configfs.
systemd[1]: modprobe@drm.service: Deactivated successfully.
systemd[1]: Finished Load Kernel Module drm.
systemd[1]: modprobe@fuse.service: Deactivated successfully.
systemd[1]: Finished Load Kernel Module fuse.
systemd[1]: Finished File System Check on Root Device.
systemd[1]: Finished Load Kernel Modules.
systemd[1]: Mounting FUSE Control File System...
systemd[1]: Mounting Kernel Configuration File System...
systemd[1]: Starting Remount Root and Kernel File Systems...
systemd[1]: Starting Apply Kernel Variables...
systemd[1]: Started Journal Service.
EXT4-fs (sda5): re-mounted. Quota mode: disabled.
systemd-journald[94]: Received client request to flush runtime journal.
random: crng init done
BTRFS: device label tmp devid 1 transid 9757 /dev/sda6 scanned by systemd-udevd (118)
BTRFS: device label g4_musl devid 1 transid 52512 /dev/sda4 scanned by systemd-udevd (122)
Adding 8388604k swap on /dev/sdb6.  Priority:-2 extents:1 across:8388604k FS
Serial: 8250/16550 driver, 2 ports, IRQ sharing disabled
usbcore: registered new interface driver usbfs
EXT4-fs (sdc5): mounting ext2 file system using the ext4 subsystem
b43-pci-bridge 0001:10:16.0: enabling device (0004 -> 0006)
EXT4-fs (sdc5): mounted filesystem without journal. Quota mode: disabled.
ext2 filesystem being mounted at /boot supports timestamps until 2038 (0x7fffffff)
serial 0001:10:15.0: enabling device (0004 -> 0007)
usbcore: registered new interface driver hub
ssb: Found chip with id 0x4306, rev 0x02 and package 0x00
sr 4:0:0:0: [sr0] scsi3-mmc drive: 48x/48x writer cd/rw xa/form2 cdda tray
cdrom: Uniform CD-ROM driver Revision: 3.20
0001:10:15.0: ttyS0 at I/O 0x410 (irq = 58, base_baud = 115200) is a 16550A
usbcore: registered new device driver usb
ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
b43-pci-bridge 0001:10:16.0: Sonics Silicon Backplane found on PCI device 0001:10:16.0
serial 0001:10:15.1: enabling device (0004 -> 0007)
ehci-pci: EHCI PCI platform driver
ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
0001:10:15.1: ttyS1 at I/O 0x400 (irq = 58, base_baud = 115200) is a 16550A
ehci-pci 0001:10:12.2: EHCI Host Controller
ehci-pci 0001:10:12.2: new USB bus registered, assigned bus number 1
BTRFS info (device sda6): using xxhash64 (xxhash64-generic) checksum algorithm
BTRFS info (device sda6): use lzo compression, level 0
BTRFS info (device sda6): setting nodatasum
BTRFS info (device sda6): using free space tree
firewire_ohci 0002:20:0e.0: enabling device (0000 -> 0002)
ehci-pci 0001:10:12.2: irq 52, io mem 0x80081000
BTRFS info (device sda6): enabling ssd optimizations
ADM1030 fan controller [@2c]
firewire_ohci 0002:20:0e.0: added OHCI v1.10 device as card 0, 8 IR + 8 IT contexts, quirks 0x0
ehci-pci 0001:10:12.2: USB 2.0 started, EHCI 1.00
DS1775 digital thermometer [@49]
Temp: 43.8 C
  Hyst: 70.0 C
  OS: 75.0 C

usb usb1: New USB device found, idVendor=1d6b, idProduct=0002, bcdDevice= 6.00
usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
usb usb1: Product: EHCI Host Controller
usb usb1: Manufacturer: Linux 6.0.9-gentoo-PMacG4 ehci_hcd
usb usb1: SerialNumber: 0001:10:12.2
firewire_core 0002:20:0e.0: created device fw0: GUID 000a95fffe9c763a, S800
[drm] radeon kernel modesetting enabled.
snd-aoa-fabric-layout: can use this codec
fb0: switching to radeon from OFfb ATY,Altera
Console: switching to colour dummy device 80x25
radeon 0000:00:10.0: vgaarb: deactivate vga console
radeon 0000:00:10.0: enabling device (0006 -> 0007)
[drm] initializing kernel modesetting (RV350 0x1002:0x4150 0x1002:0x0002 0x00).
[drm] Forcing AGP to PCI mode
radeon 0000:00:10.0: Invalid PCI ROM header signature: expecting 0xaa55, got 0x0000
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 5 ports detected
ehci-pci 0001:10:1b.2: EHCI Host Controller
ehci-pci 0001:10:1b.2: new USB bus registered, assigned bus number 2
ehci-pci 0001:10:1b.2: irq 63, io mem 0x80080000
ehci-pci 0001:10:1b.2: USB 2.0 started, EHCI 1.00
usb usb2: New USB device found, idVendor=1d6b, idProduct=0002, bcdDevice= 6.00
usb usb2: New USB device strings: Mfr=3, Product=2, SerialNumber=1
usb usb2: Product: EHCI Host Controller
usb usb2: Manufacturer: Linux 6.0.9-gentoo-PMacG4 ehci_hcd
usb usb2: SerialNumber: 0001:10:1b.2
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 5 ports detected
usb 1-5: new high-speed USB device number 2 using ehci-pci
ohci-pci: OHCI PCI platform driver
ohci-pci 0001:10:12.0: OHCI PCI host controller
ohci-pci 0001:10:12.0: new USB bus registered, assigned bus number 3
ohci-pci 0001:10:12.0: irq 52, io mem 0x8008c000
usb 1-5: New USB device found, idVendor=05e3, idProduct=0610, bcdDevice=32.98
usb 1-5: New USB device strings: Mfr=0, Product=1, SerialNumber=0
usb 1-5: Product: USB2.0 Hub
hub 1-5:1.0: USB hub found
hub 1-5:1.0: 4 ports detected
cfg80211: Loading compiled-in X.509 certificates for regulatory database
usb 1-5.1: new low-speed USB device number 3 using ehci-pci
usb 1-5.1: New USB device found, idVendor=04d9, idProduct=0006, bcdDevice= 1.40
usb 1-5.1: New USB device strings: Mfr=1, Product=2, SerialNumber=0
usb 1-5.1: Product: RPI Wired Keyboard 5
usb 1-5.1: Manufacturer:  
usb 1-5.4: new low-speed USB device number 4 using ehci-pci
usb 1-5.4: New USB device found, idVendor=275d, idProduct=0ba6, bcdDevice= 1.00
usb 1-5.4: New USB device strings: Mfr=0, Product=1, SerialNumber=0
usb 1-5.4: Product: USB OPTICAL MOUSE 
usb usb3: New USB device found, idVendor=1d6b, idProduct=0001, bcdDevice= 6.00
usb usb3: New USB device strings: Mfr=3, Product=2, SerialNumber=1
usb usb3: Product: OHCI PCI host controller
usb usb3: Manufacturer: Linux 6.0.9-gentoo-PMacG4 ohci_hcd
usb usb3: SerialNumber: 0001:10:12.0
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 3 ports detected
cfg80211: Loaded X.509 cert 'sforshee: 00b28ddf47aef9cea7'
Loading firmware: regulatory.db
platform regulatory.0: Direct firmware load for regulatory.db failed with error -2
cfg80211: failed to load regulatory.db
ohci-pci 0001:10:12.1: OHCI PCI host controller
ohci-pci 0001:10:12.1: new USB bus registered, assigned bus number 4
ohci-pci 0001:10:12.1: irq 52, io mem 0x8008b000
[drm] Generation 2 PCI interface, using max accessible memory
radeon 0000:00:10.0: VRAM: 256M 0x00000000A0000000 - 0x00000000AFFFFFFF (256M used)
radeon 0000:00:10.0: GTT: 512M 0x0000000080000000 - 0x000000009FFFFFFF
[drm] Detected VRAM RAM=256M, BAR=256M
[drm] RAM width 128bits DDR
[drm] radeon: 256M of VRAM memory ready
[drm] radeon: 512M of GTT memory ready.
[drm] GART: num cpu pages 131072, num gpu pages 131072
usb usb4: New USB device found, idVendor=1d6b, idProduct=0001, bcdDevice= 6.00
usb usb4: New USB device strings: Mfr=3, Product=2, SerialNumber=1
usb usb4: Product: OHCI PCI host controller
usb usb4: Manufacturer: Linux 6.0.9-gentoo-PMacG4 ohci_hcd
usb usb4: SerialNumber: 0001:10:12.1
hub 4-0:1.0: USB hub found
hub 4-0:1.0: 2 ports detected
Apple USB OHCI 0001:10:18.0 disabled by firmware
Apple USB OHCI 0001:10:19.0 disabled by firmware
ohci-pci 0001:10:1b.0: OHCI PCI host controller
ohci-pci 0001:10:1b.0: new USB bus registered, assigned bus number 5
ohci-pci 0001:10:1b.0: irq 63, io mem 0x80084000
[drm] radeon: 1 quad pipes, 1 Z pipes initialized
[drm] PCI GART of 512M enabled (table at 0x0000000004A80000).
radeon 0000:00:10.0: WB enabled
radeon 0000:00:10.0: fence driver on ring 0 use gpu addr 0x0000000080000000
[drm] radeon: irq initialized.
[drm] Loading R300 Microcode
Loading firmware: radeon/R300_cp.bin
[drm] radeon: ring at 0x0000000080001000
[drm] ring test succeeded in 1 usecs
[drm] ib test succeeded in 0 usecs
[drm] Radeon Display Connectors
[drm] Connector 0:
[drm]   DVI-I-1
[drm]   HPD2
[drm]   DDC: 0x64 0x64 0x64 0x64 0x64 0x64 0x64 0x64
[drm]   Encoders:
[drm]     CRT1: INTERNAL_DAC1
[drm]     DFP2: INTERNAL_DVO1
[drm] Connector 1:
[drm]   DVI-I-2
[drm]   HPD1
[drm]   DDC: 0x60 0x60 0x60 0x60 0x60 0x60 0x60 0x60
[drm]   Encoders:
[drm]     CRT2: INTERNAL_DAC2
[drm]     DFP1: INTERNAL_TMDS1
b43legacy-phy0: Broadcom 4306 WLAN found (core revision 4)
usb usb5: New USB device found, idVendor=1d6b, idProduct=0001, bcdDevice= 6.00
usb usb5: New USB device strings: Mfr=3, Product=2, SerialNumber=1
usb usb5: Product: OHCI PCI host controller
usb usb5: Manufacturer: Linux 6.0.9-gentoo-PMacG4 ohci_hcd
usb usb5: SerialNumber: 0001:10:1b.0
hub 5-0:1.0: USB hub found
hub 5-0:1.0: 3 ports detected
b43legacy-phy0: Loading firmware b43legacy/ucode4.fw
Loading firmware: b43legacy/ucode4.fw
Broadcom 43xx-legacy driver loaded [ Features: PLID ]
b43legacy-phy0: Loading firmware b43legacy/pcm4.fw
Loading firmware: b43legacy/pcm4.fw
b43legacy-phy0: Loading firmware b43legacy/b0g0initvals2.fw
Loading firmware: b43legacy/b0g0initvals2.fw
ohci-pci 0001:10:1b.1: OHCI PCI host controller
ohci-pci 0001:10:1b.1: new USB bus registered, assigned bus number 6
ohci-pci 0001:10:1b.1: irq 63, io mem 0x80083000
usb usb6: New USB device found, idVendor=1d6b, idProduct=0001, bcdDevice= 6.00
usb usb6: New USB device strings: Mfr=3, Product=2, SerialNumber=1
usb usb6: Product: OHCI PCI host controller
usb usb6: Manufacturer: Linux 6.0.9-gentoo-PMacG4 ohci_hcd
usb usb6: SerialNumber: 0001:10:1b.1
hub 6-0:1.0: USB hub found
hub 6-0:1.0: 2 ports detected
hid: raw HID events driver (C) Jiri Kosina
usbcore: registered new interface driver usbhid
usbhid: USB HID core driver
input:   RPI Wired Keyboard 5 as /devices/pci0001:10/0001:10:12.2/usb1/1-5/1-5.1/1-5.1:1.0/0003:04D9:0006.0001/input/input1
[drm] fb mappable at 0xA0040000
[drm] vram apper at 0xA0000000
[drm] size 8294400
[drm] fb depth is 24
[drm]    pitch is 7680
hid-generic 0003:04D9:0006.0001: input,hidraw0: USB HID v1.11 Keyboard [  RPI Wired Keyboard 5] on usb-0001:10:12.2-5.1/input0
input:   RPI Wired Keyboard 5 as /devices/pci0001:10/0001:10:12.2/usb1/1-5/1-5.1/1-5.1:1.1/0003:04D9:0006.0002/input/input2
hid-generic 0003:04D9:0006.0002: input,hidraw1: USB HID v1.11 Device [  RPI Wired Keyboard 5] on usb-0001:10:12.2-5.1/input1
input: USB OPTICAL MOUSE  as /devices/pci0001:10/0001:10:12.2/usb1/1-5/1-5.4/1-5.4:1.0/0003:275D:0BA6.0003/input/input3
hid-generic 0003:275D:0BA6.0003: input,hidraw2: USB HID v1.11 Mouse [USB OPTICAL MOUSE ] on usb-0001:10:12.2-5.4/input0
Console: switching to colour frame buffer device 240x67
radeon 0000:00:10.0: [drm] fb0: radeondrmfb frame buffer device
[drm] Initialized radeon 2.50.0 20080528 for 0000:00:10.0 on minor 0
CPU-temp: 43.6 C
, Case: 26.6 C
,  Fan: 0 (tuned -11)
BTRFS info (device sda4): using xxhash64 (xxhash64-generic) checksum algorithm
BTRFS error (device sda4): unrecognized mount option 'compres=lzo'
BTRFS error (device sda4): open_ctree failed
BTRFS info (device sda4): using xxhash64 (xxhash64-generic) checksum algorithm
BTRFS info (device sda4): use lzo compression, level 0
BTRFS info (device sda4): using free space tree
BTRFS info (device sda4): enabling ssd optimizations
RPC: Registered named UNIX socket transport module.
RPC: Registered udp transport module.
RPC: Registered tcp transport module.
RPC: Registered tcp NFSv4.1 backchannel transport module.
Key type dns_resolver registered
NFS: Registering the id_resolver key type
Key type id_resolver registered
Key type id_legacy registered
usb 1-5: USB disconnect, device number 2
usb 1-5.1: USB disconnect, device number 3
usb 1-5.4: USB disconnect, device number 4
ld.so.1[17287]: floating point exception (8) at 6ff143dc nip 6ff143dc lr 6ffd1930 code 3 in libm.so[6ff00000+ab000]
ld.so.1[17287]: code: 74632000 4182001c fc00048e d8010008 8121000c 75292000 40820008 fce0004c 
ld.so.1[17287]: code: 83c10018 38600000 38210020 4e800020 <fdfe058e> 4bffffcc 9421ffe0 7c0802a6 
ld.so.1[17296]: floating point exception (8) at 6ff143dc nip 6ff143dc lr 6ffd1984 code 3 in libm.so[6ff00000+ab000]
ld.so.1[17296]: code: 74632000 4182001c fc00048e d8010008 8121000c 75292000 40820008 fce0004c 
ld.so.1[17296]: code: 83c10018 38600000 38210020 4e800020 <fdfe058e> 4bffffcc 9421ffe0 7c0802a6 
ld.so.1[17304]: floating point exception (8) at 6ff143dc nip 6ff143dc lr 6ffd1930 code 7 in libm.so[6ff00000+ab000]
ld.so.1[17304]: code: 74632000 4182001c fc00048e d8010008 8121000c 75292000 40820008 fce0004c 
ld.so.1[17304]: code: 83c10018 38600000 38210020 4e800020 <fdfe058e> 4bffffcc 9421ffe0 7c0802a6 
ld.so.1[17312]: floating point exception (8) at 6ff143dc nip 6ff143dc lr 6ffd1984 code 7 in libm.so[6ff00000+ab000]
ld.so.1[17312]: code: 74632000 4182001c fc00048e d8010008 8121000c 75292000 40820008 fce0004c 
ld.so.1[17312]: code: 83c10018 38600000 38210020 4e800020 <fdfe058e> 4bffffcc 9421ffe0 7c0802a6 
ld.so.1[17320]: floating point exception (8) at 6ff143dc nip 6ff143dc lr 6ffd1930 code 6 in libm.so[6ff00000+ab000]
ld.so.1[17320]: code: 74632000 4182001c fc00048e d8010008 8121000c 75292000 40820008 fce0004c 
ld.so.1[17320]: code: 83c10018 38600000 38210020 4e800020 <fdfe058e> 4bffffcc 9421ffe0 7c0802a6 
ld.so.1[17328]: floating point exception (8) at 6ff143dc nip 6ff143dc lr 6ffd1984 code 6 in libm.so[6ff00000+ab000]
ld.so.1[17328]: code: 74632000 4182001c fc00048e d8010008 8121000c 75292000 40820008 fce0004c 
ld.so.1[17328]: code: 83c10018 38600000 38210020 4e800020 <fdfe058e> 4bffffcc 9421ffe0 7c0802a6 
ld.so.1[17334]: floating point exception (8) at 6ff143dc nip 6ff143dc lr 6ffd1930 code 5 in libm.so[6ff00000+ab000]
ld.so.1[17334]: code: 74632000 4182001c fc00048e d8010008 8121000c 75292000 40820008 fce0004c 
ld.so.1[17334]: code: 83c10018 38600000 38210020 4e800020 <fdfe058e> 4bffffcc 9421ffe0 7c0802a6 
ld.so.1[17346]: floating point exception (8) at 6ff143dc nip 6ff143dc lr 6ffd1984 code 5 in libm.so[6ff00000+ab000]
ld.so.1[17346]: code: 74632000 4182001c fc00048e d8010008 8121000c 75292000 40820008 fce0004c 
ld.so.1[17346]: code: 83c10018 38600000 38210020 4e800020 <fdfe058e> 4bffffcc 9421ffe0 7c0802a6 
ld.so.1[17354]: floating point exception (8) at 6ff143dc nip 6ff143dc lr 6ffd1930 code 4 in libm.so[6ff00000+ab000]
ld.so.1[17354]: code: 74632000 4182001c fc00048e d8010008 8121000c 75292000 40820008 fce0004c 
ld.so.1[17354]: code: 83c10018 38600000 38210020 4e800020 <fdfe058e> 4bffffcc 9421ffe0 7c0802a6 
ld.so.1[17362]: floating point exception (8) at 6ff143dc nip 6ff143dc lr 6ffd1984 code 4 in libm.so[6ff00000+ab000]
ld.so.1[17362]: code: 74632000 4182001c fc00048e d8010008 8121000c 75292000 40820008 fce0004c 
ld.so.1[17362]: code: 83c10018 38600000 38210020 4e800020 <fdfe058e> 4bffffcc 9421ffe0 7c0802a6 
BUG: spinlock trylock failure on UP on CPU#0, Xvnc/256
 lock: 0xd9651008, .magic: dead4ead, .owner: Xvnc/256, .owner_cpu: 0
CPU: 0 PID: 256 Comm: Xvnc Tainted: G                T  6.0.9-gentoo-PMacG4 #1
Call Trace:
[f2b91c80] [c05d2d0c] dump_stack_lvl+0x34/0x74 (unreliable)
[f2b91ca0] [c008f95c] do_raw_spin_trylock+0xac/0xb8
[f2b91cc0] [c0937a3c] _raw_spin_trylock+0x10/0x44
[f2b91cd0] [c02204e4] z3fold_zpool_free+0x410/0x594
[f2b91d10] [c01f5810] zswap_free_entry+0xd8/0x198
[f2b91d30] [c01f5a28] zswap_frontswap_invalidate_page+0xec/0xf0
[f2b91d50] [c01f4be4] __frontswap_invalidate_page+0x5c/0xd4
[f2b91d70] [c01effd4] swapcache_free_entries+0x310/0x478
[f2b91dc0] [c01f45a0] free_swap_slot+0x138/0x158
[f2b91de0] [c01efc68] put_swap_page+0xb8/0x114
[f2b91e00] [c01ec758] delete_from_swap_cache+0x78/0xe8
[f2b91e20] [c01f0694] try_to_free_swap+0xf0/0x13c
[f2b91e40] [c01c4c1c] do_swap_page+0x594/0x9d8
[f2b91e80] [c01c5b44] handle_mm_fault+0x760/0xe34
[f2b91f00] [c001eaa0] do_page_fault+0x1c0/0x814
[f2b91f30] [c000433c] DataAccess_virt+0x124/0x17c
--- interrupt: 300 at 0xa7183884
NIP:  a7183884 LR: a71837e4 CTR: a71838f4
REGS: f2b91f40 TRAP: 0300   Tainted: G                T   (6.0.9-gentoo-PMacG4)
MSR:  0000f932 <EE,PR,FP,ME,IR,DR,RI>  CR: 24002428  XER: 20000000
DAR: 017d2750 DSISR: 42000000 
GPR00: 00651904 afccb070 a7e5d5a0 017d2750 00000006 00000070 a72733e0 ff000000 
GPR08: 017d273c 017d2750 a6494c10 a7183698 a71837e4 0072fff4 afccc6a4 afccc6a8 
GPR16: 00734474 0073424c 00734470 00734248 0073446c 00000000 a7e56764 00000000 
GPR24: 00000001 00000006 016f9d50 017d2750 000001b0 017d2750 a72dfff4 a6494c20 
NIP [a7183884] 0xa7183884
LR [a71837e4] 0xa71837e4
--- interrupt: 300
process 'ld.so.1' launched '/var/tmp/portage/sys-libs/glibc-2.35-r11/temp/testscriptLOhdZe' with NULL argv: empty string added
EXT4-fs (sdc5): unmounting filesystem.
systemd-shutdown[1]: Syncing filesystems and block devices.
systemd-shutdown[1]: Sending SIGTERM to remaining processes...
systemd-journald[94]: Received SIGTERM from PID 1 (systemd-shutdow).
systemd-shutdown[1]: Sending SIGKILL to remaining processes...
systemd-shutdown[1]: Unmounting file systems.
[25775]: Remounting '/' read-only with options ''.
EXT4-fs (sda5): re-mounted. Quota mode: disabled.
systemd-shutdown[1]: All filesystems unmounted.
systemd-shutdown[1]: Deactivating swaps.
systemd-shutdown[1]: All swaps deactivated.
systemd-shutdown[1]: Detaching loop devices.
systemd-shutdown[1]: All loop devices detached.
systemd-shutdown[1]: Stopping MD devices.
systemd-shutdown[1]: All MD devices stopped.
systemd-shutdown[1]: Detaching DM devices.
systemd-shutdown[1]: All DM devices detached.
systemd-shutdown[1]: All filesystems, swaps, loop devices, MD devices and DM devices detached.
systemd-shutdown[1]: Syncing filesystems and block devices.
systemd-shutdown[1]: Rebooting.
sd 1:0:0:0: [sdb] Synchronizing SCSI cache
sd 0:0:0:0: [sda] Synchronizing SCSI cache
reboot: Restarting system

--MP_/xQFfg_Dl4TlDy/Gy8DdNHbA
Content-Type: application/octet-stream; name=config_609_g4s
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename=config_609_g4s

IwojIEF1dG9tYXRpY2FsbHkgZ2VuZXJhdGVkIGZpbGU7IERPIE5PVCBFRElULgojIExpbnV4L3Bv
d2VycGMgNi4wLjktZ2VudG9vIEtlcm5lbCBDb25maWd1cmF0aW9uCiMKQ09ORklHX0NDX1ZFUlNJ
T05fVEVYVD0iZ2NjIChHZW50b28gMTIuMi4xX3AyMDIyMTAwOCBwMSkgMTIuMi4xIDIwMjIxMDA4
IgpDT05GSUdfQ0NfSVNfR0NDPXkKQ09ORklHX0dDQ19WRVJTSU9OPTEyMDIwMQpDT05GSUdfQ0xB
TkdfVkVSU0lPTj0wCkNPTkZJR19BU19JU19HTlU9eQpDT05GSUdfQVNfVkVSU0lPTj0yMzkwMApD
T05GSUdfTERfSVNfQkZEPXkKQ09ORklHX0xEX1ZFUlNJT049MjM5MDAKQ09ORklHX0xMRF9WRVJT
SU9OPTAKQ09ORklHX0NDX0hBU19BU01fR09UT19PVVRQVVQ9eQpDT05GSUdfQ0NfSEFTX0FTTV9H
T1RPX1RJRURfT1VUUFVUPXkKQ09ORklHX0NDX0hBU19BU01fSU5MSU5FPXkKQ09ORklHX0NDX0hB
U19OT19QUk9GSUxFX0ZOX0FUVFI9eQpDT05GSUdfUEFIT0xFX1ZFUlNJT049MApDT05GSUdfSVJR
X1dPUks9eQpDT05GSUdfQlVJTERUSU1FX1RBQkxFX1NPUlQ9eQpDT05GSUdfVEhSRUFEX0lORk9f
SU5fVEFTSz15CgojCiMgR2VuZXJhbCBzZXR1cAojCkNPTkZJR19CUk9LRU5fT05fU01QPXkKQ09O
RklHX0lOSVRfRU5WX0FSR19MSU1JVD0zMgojIENPTkZJR19DT01QSUxFX1RFU1QgaXMgbm90IHNl
dAojIENPTkZJR19XRVJST1IgaXMgbm90IHNldApDT05GSUdfTE9DQUxWRVJTSU9OPSItUE1hY0c0
IgojIENPTkZJR19MT0NBTFZFUlNJT05fQVVUTyBpcyBub3Qgc2V0CkNPTkZJR19CVUlMRF9TQUxU
PSIiCkNPTkZJR19IQVZFX0tFUk5FTF9HWklQPXkKQ09ORklHX0hBVkVfS0VSTkVMX1haPXkKQ09O
RklHX0tFUk5FTF9HWklQPXkKIyBDT05GSUdfS0VSTkVMX1haIGlzIG5vdCBzZXQKQ09ORklHX0RF
RkFVTFRfSU5JVD0iIgpDT05GSUdfREVGQVVMVF9IT1NUTkFNRT0iKG5vbmUpIgpDT05GSUdfU1lT
VklQQz15CkNPTkZJR19TWVNWSVBDX1NZU0NUTD15CkNPTkZJR19QT1NJWF9NUVVFVUU9eQpDT05G
SUdfUE9TSVhfTVFVRVVFX1NZU0NUTD15CkNPTkZJR19XQVRDSF9RVUVVRT15CkNPTkZJR19DUk9T
U19NRU1PUllfQVRUQUNIPXkKIyBDT05GSUdfVVNFTElCIGlzIG5vdCBzZXQKIyBDT05GSUdfQVVE
SVQgaXMgbm90IHNldApDT05GSUdfSEFWRV9BUkNIX0FVRElUU1lTQ0FMTD15CgojCiMgSVJRIHN1
YnN5c3RlbQojCkNPTkZJR19HRU5FUklDX0lSUV9TSE9XPXkKQ09ORklHX0dFTkVSSUNfSVJRX1NI
T1dfTEVWRUw9eQpDT05GSUdfSVJRX0RPTUFJTj15CkNPTkZJR19JUlFfRE9NQUlOX0hJRVJBUkNI
WT15CkNPTkZJR19HRU5FUklDX01TSV9JUlE9eQpDT05GSUdfR0VORVJJQ19NU0lfSVJRX0RPTUFJ
Tj15CkNPTkZJR19JUlFfRk9SQ0VEX1RIUkVBRElORz15CkNPTkZJR19TUEFSU0VfSVJRPXkKIyBl
bmQgb2YgSVJRIHN1YnN5c3RlbQoKQ09ORklHX0dFTkVSSUNfVElNRV9WU1lTQ0FMTD15CkNPTkZJ
R19HRU5FUklDX0NMT0NLRVZFTlRTPXkKQ09ORklHX0dFTkVSSUNfQ01PU19VUERBVEU9eQoKIwoj
IFRpbWVycyBzdWJzeXN0ZW0KIwpDT05GSUdfVElDS19PTkVTSE9UPXkKQ09ORklHX05PX0haX0NP
TU1PTj15CiMgQ09ORklHX0haX1BFUklPRElDIGlzIG5vdCBzZXQKQ09ORklHX05PX0haX0lETEU9
eQojIENPTkZJR19OT19IWiBpcyBub3Qgc2V0CkNPTkZJR19ISUdIX1JFU19USU1FUlM9eQojIGVu
ZCBvZiBUaW1lcnMgc3Vic3lzdGVtCgpDT05GSUdfQlBGPXkKQ09ORklHX0hBVkVfRUJQRl9KSVQ9
eQoKIwojIEJQRiBzdWJzeXN0ZW0KIwpDT05GSUdfQlBGX1NZU0NBTEw9eQojIENPTkZJR19CUEZf
SklUIGlzIG5vdCBzZXQKQ09ORklHX0JQRl9VTlBSSVZfREVGQVVMVF9PRkY9eQojIENPTkZJR19C
UEZfUFJFTE9BRCBpcyBub3Qgc2V0CiMgZW5kIG9mIEJQRiBzdWJzeXN0ZW0KCkNPTkZJR19QUkVF
TVBUX1ZPTFVOVEFSWV9CVUlMRD15CiMgQ09ORklHX1BSRUVNUFRfTk9ORSBpcyBub3Qgc2V0CkNP
TkZJR19QUkVFTVBUX1ZPTFVOVEFSWT15CiMgQ09ORklHX1BSRUVNUFQgaXMgbm90IHNldAoKIwoj
IENQVS9UYXNrIHRpbWUgYW5kIHN0YXRzIGFjY291bnRpbmcKIwpDT05GSUdfVElDS19DUFVfQUND
T1VOVElORz15CiMgQ09ORklHX1ZJUlRfQ1BVX0FDQ09VTlRJTkdfTkFUSVZFIGlzIG5vdCBzZXQK
IyBDT05GSUdfSVJRX1RJTUVfQUNDT1VOVElORyBpcyBub3Qgc2V0CkNPTkZJR19CU0RfUFJPQ0VT
U19BQ0NUPXkKQ09ORklHX0JTRF9QUk9DRVNTX0FDQ1RfVjM9eQpDT05GSUdfVEFTS1NUQVRTPXkK
Q09ORklHX1RBU0tfREVMQVlfQUNDVD15CkNPTkZJR19UQVNLX1hBQ0NUPXkKQ09ORklHX1RBU0tf
SU9fQUNDT1VOVElORz15CiMgQ09ORklHX1BTSSBpcyBub3Qgc2V0CiMgZW5kIG9mIENQVS9UYXNr
IHRpbWUgYW5kIHN0YXRzIGFjY291bnRpbmcKCiMKIyBSQ1UgU3Vic3lzdGVtCiMKQ09ORklHX1RJ
TllfUkNVPXkKIyBDT05GSUdfUkNVX0VYUEVSVCBpcyBub3Qgc2V0CkNPTkZJR19TUkNVPXkKQ09O
RklHX1RJTllfU1JDVT15CkNPTkZJR19UQVNLU19SQ1VfR0VORVJJQz15CkNPTkZJR19UQVNLU19U
UkFDRV9SQ1U9eQpDT05GSUdfUkNVX05FRURfU0VHQ0JMSVNUPXkKIyBlbmQgb2YgUkNVIFN1YnN5
c3RlbQoKIyBDT05GSUdfSUtDT05GSUcgaXMgbm90IHNldAojIENPTkZJR19JS0hFQURFUlMgaXMg
bm90IHNldApDT05GSUdfTE9HX0JVRl9TSElGVD0xNgpDT05GSUdfUFJJTlRLX1NBRkVfTE9HX0JV
Rl9TSElGVD0xMwoKIwojIFNjaGVkdWxlciBmZWF0dXJlcwojCiMgZW5kIG9mIFNjaGVkdWxlciBm
ZWF0dXJlcwoKQ09ORklHX0NDX0lNUExJQ0lUX0ZBTExUSFJPVUdIPSItV2ltcGxpY2l0LWZhbGx0
aHJvdWdoPTUiCkNPTkZJR19HQ0MxMl9OT19BUlJBWV9CT1VORFM9eQpDT05GSUdfQ0NfTk9fQVJS
QVlfQk9VTkRTPXkKQ09ORklHX0NHUk9VUFM9eQpDT05GSUdfUEFHRV9DT1VOVEVSPXkKIyBDT05G
SUdfQ0dST1VQX0ZBVk9SX0RZTk1PRFMgaXMgbm90IHNldApDT05GSUdfTUVNQ0c9eQpDT05GSUdf
TUVNQ0dfU1dBUD15CkNPTkZJR19NRU1DR19LTUVNPXkKQ09ORklHX0JMS19DR1JPVVA9eQpDT05G
SUdfQ0dST1VQX1dSSVRFQkFDSz15CkNPTkZJR19DR1JPVVBfU0NIRUQ9eQpDT05GSUdfRkFJUl9H
Uk9VUF9TQ0hFRD15CkNPTkZJR19DRlNfQkFORFdJRFRIPXkKIyBDT05GSUdfUlRfR1JPVVBfU0NI
RUQgaXMgbm90IHNldApDT05GSUdfQ0dST1VQX1BJRFM9eQpDT05GSUdfQ0dST1VQX1JETUE9eQpD
T05GSUdfQ0dST1VQX0ZSRUVaRVI9eQpDT05GSUdfQ0dST1VQX0RFVklDRT15CkNPTkZJR19DR1JP
VVBfQ1BVQUNDVD15CiMgQ09ORklHX0NHUk9VUF9QRVJGIGlzIG5vdCBzZXQKQ09ORklHX0NHUk9V
UF9CUEY9eQojIENPTkZJR19DR1JPVVBfTUlTQyBpcyBub3Qgc2V0CiMgQ09ORklHX0NHUk9VUF9E
RUJVRyBpcyBub3Qgc2V0CkNPTkZJR19TT0NLX0NHUk9VUF9EQVRBPXkKQ09ORklHX05BTUVTUEFD
RVM9eQpDT05GSUdfVVRTX05TPXkKQ09ORklHX1RJTUVfTlM9eQpDT05GSUdfSVBDX05TPXkKQ09O
RklHX1VTRVJfTlM9eQpDT05GSUdfUElEX05TPXkKQ09ORklHX05FVF9OUz15CkNPTkZJR19DSEVD
S1BPSU5UX1JFU1RPUkU9eQpDT05GSUdfU0NIRURfQVVUT0dST1VQPXkKIyBDT05GSUdfU1lTRlNf
REVQUkVDQVRFRCBpcyBub3Qgc2V0CiMgQ09ORklHX1JFTEFZIGlzIG5vdCBzZXQKIyBDT05GSUdf
QkxLX0RFVl9JTklUUkQgaXMgbm90IHNldAojIENPTkZJR19CT09UX0NPTkZJRyBpcyBub3Qgc2V0
CkNPTkZJR19JTklUUkFNRlNfUFJFU0VSVkVfTVRJTUU9eQpDT05GSUdfQ0NfT1BUSU1JWkVfRk9S
X1BFUkZPUk1BTkNFPXkKIyBDT05GSUdfQ0NfT1BUSU1JWkVfRk9SX1NJWkUgaXMgbm90IHNldApD
T05GSUdfSEFWRV9MRF9ERUFEX0NPREVfREFUQV9FTElNSU5BVElPTj15CiMgQ09ORklHX0xEX0RF
QURfQ09ERV9EQVRBX0VMSU1JTkFUSU9OIGlzIG5vdCBzZXQKQ09ORklHX0xEX09SUEhBTl9XQVJO
PXkKQ09ORklHX1NZU0NUTD15CkNPTkZJR19TWVNDVExfRVhDRVBUSU9OX1RSQUNFPXkKQ09ORklH
X0VYUEVSVD15CkNPTkZJR19NVUxUSVVTRVI9eQojIENPTkZJR19TR0VUTUFTS19TWVNDQUxMIGlz
IG5vdCBzZXQKIyBDT05GSUdfU1lTRlNfU1lTQ0FMTCBpcyBub3Qgc2V0CkNPTkZJR19GSEFORExF
PXkKQ09ORklHX1BPU0lYX1RJTUVSUz15CkNPTkZJR19QUklOVEs9eQpDT05GSUdfQlVHPXkKQ09O
RklHX0VMRl9DT1JFPXkKQ09ORklHX0JBU0VfRlVMTD15CkNPTkZJR19GVVRFWD15CkNPTkZJR19G
VVRFWF9QST15CkNPTkZJR19FUE9MTD15CkNPTkZJR19TSUdOQUxGRD15CkNPTkZJR19USU1FUkZE
PXkKQ09ORklHX0VWRU5URkQ9eQpDT05GSUdfU0hNRU09eQpDT05GSUdfQUlPPXkKQ09ORklHX0lP
X1VSSU5HPXkKQ09ORklHX0FEVklTRV9TWVNDQUxMUz15CkNPTkZJR19NRU1CQVJSSUVSPXkKQ09O
RklHX0tBTExTWU1TPXkKIyBDT05GSUdfS0FMTFNZTVNfQUxMIGlzIG5vdCBzZXQKQ09ORklHX0tB
TExTWU1TX0JBU0VfUkVMQVRJVkU9eQpDT05GSUdfQVJDSF9IQVNfTUVNQkFSUklFUl9DQUxMQkFD
S1M9eQpDT05GSUdfQVJDSF9IQVNfTUVNQkFSUklFUl9TWU5DX0NPUkU9eQpDT05GSUdfS0NNUD15
CkNPTkZJR19SU0VRPXkKIyBDT05GSUdfREVCVUdfUlNFUSBpcyBub3Qgc2V0CiMgQ09ORklHX0VN
QkVEREVEIGlzIG5vdCBzZXQKQ09ORklHX0hBVkVfUEVSRl9FVkVOVFM9eQojIENPTkZJR19QQzEw
NCBpcyBub3Qgc2V0CgojCiMgS2VybmVsIFBlcmZvcm1hbmNlIEV2ZW50cyBBbmQgQ291bnRlcnMK
IwpDT05GSUdfUEVSRl9FVkVOVFM9eQojIGVuZCBvZiBLZXJuZWwgUGVyZm9ybWFuY2UgRXZlbnRz
IEFuZCBDb3VudGVycwoKQ09ORklHX1NZU1RFTV9EQVRBX1ZFUklGSUNBVElPTj15CiMgQ09ORklH
X1BST0ZJTElORyBpcyBub3Qgc2V0CiMgZW5kIG9mIEdlbmVyYWwgc2V0dXAKCkNPTkZJR19QUEMz
Mj15CiMgQ09ORklHX1BQQzY0IGlzIG5vdCBzZXQKCiMKIyBQcm9jZXNzb3Igc3VwcG9ydAojCkNP
TkZJR19QUENfQk9PSzNTXzMyPXkKIyBDT05GSUdfUFBDXzg1eHggaXMgbm90IHNldAojIENPTkZJ
R19QUENfOHh4IGlzIG5vdCBzZXQKIyBDT05GSUdfNDB4IGlzIG5vdCBzZXQKIyBDT05GSUdfNDR4
IGlzIG5vdCBzZXQKIyBDT05GSUdfUFBDX0JPT0szU182MDMgaXMgbm90IHNldApDT05GSUdfUFBD
X0JPT0szU182MDQ9eQojIENPTkZJR19QT1dFUlBDX0NQVSBpcyBub3Qgc2V0CiMgQ09ORklHX0Uz
MDBDMl9DUFUgaXMgbm90IHNldAojIENPTkZJR19FMzAwQzNfQ1BVIGlzIG5vdCBzZXQKQ09ORklH
X0c0X0NQVT15CiMgQ09ORklHX1RPT0xDSEFJTl9ERUZBVUxUX0NQVSBpcyBub3Qgc2V0CkNPTkZJ
R19UQVJHRVRfQ1BVX0JPT0w9eQpDT05GSUdfVEFSR0VUX0NQVT0iRzQiCkNPTkZJR19QUENfQk9P
SzNTPXkKQ09ORklHX1BQQ19GUFVfUkVHUz15CkNPTkZJR19QUENfRlBVPXkKQ09ORklHX0FMVElW
RUM9eQpDT05GSUdfUFBDX0tVRVA9eQpDT05GSUdfUFBDX0tVQVA9eQojIENPTkZJR19QUENfS1VB
UF9ERUJVRyBpcyBub3Qgc2V0CkNPTkZJR19QUENfSEFWRV9QTVVfU1VQUE9SVD15CkNPTkZJR19Q
TVVfU1lTRlM9eQpDT05GSUdfUFBDX1BFUkZfQ1RSUz15CiMgQ09ORklHX1NNUCBpcyBub3Qgc2V0
CkNPTkZJR19OUl9DUFVTPTEKIyBlbmQgb2YgUHJvY2Vzc29yIHN1cHBvcnQKCkNPTkZJR19WRFNP
MzI9eQpDT05GSUdfQ1BVX0JJR19FTkRJQU49eQpDT05GSUdfMzJCSVQ9eQpDT05GSUdfTU1VPXkK
Q09ORklHX0FSQ0hfTU1BUF9STkRfQklUU19NQVg9MTcKQ09ORklHX0FSQ0hfTU1BUF9STkRfQklU
U19NSU49MTEKQ09ORklHX0FSQ0hfTU1BUF9STkRfQ09NUEFUX0JJVFNfTUFYPTE3CkNPTkZJR19B
UkNIX01NQVBfUk5EX0NPTVBBVF9CSVRTX01JTj0xMQpDT05GSUdfTlJfSVJRUz01MTIKQ09ORklH
X1NUQUNLVFJBQ0VfU1VQUE9SVD15CkNPTkZJR19MT0NLREVQX1NVUFBPUlQ9eQpDT05GSUdfR0VO
RVJJQ19IV0VJR0hUPXkKQ09ORklHX1BQQz15CkNPTkZJR19FQVJMWV9QUklOVEs9eQpDT05GSUdf
UEFOSUNfVElNRU9VVD00MApDT05GSUdfU0NIRURfT01JVF9GUkFNRV9QT0lOVEVSPXkKQ09ORklH
X0FSQ0hfTUFZX0hBVkVfUENfRkRDPXkKQ09ORklHX0FVRElUX0FSQ0g9eQpDT05GSUdfR0VORVJJ
Q19CVUc9eQpDT05GSUdfR0VORVJJQ19CVUdfUkVMQVRJVkVfUE9JTlRFUlM9eQpDT05GSUdfU1lT
X1NVUFBPUlRTX0FQTV9FTVVMQVRJT049eQpDT05GSUdfQVJDSF9ISUJFUk5BVElPTl9QT1NTSUJM
RT15CkNPTkZJR19BUkNIX1NVU1BFTkRfUE9TU0lCTEU9eQpDT05GSUdfQVJDSF9IQVNfQUREX1BB
R0VTPXkKQ09ORklHX0FSQ0hfU1VQUE9SVFNfVVBST0JFUz15CkNPTkZJR19QR1RBQkxFX0xFVkVM
Uz0yCkNPTkZJR19QUENfTVNJX0JJVE1BUD15CgojCiMgUGxhdGZvcm0gc3VwcG9ydAojCiMgQ09O
RklHX1BQQ19DSFJQIGlzIG5vdCBzZXQKIyBDT05GSUdfUFBDX01QQzUxMnggaXMgbm90IHNldAoj
IENPTkZJR19QUENfTVBDNTJ4eCBpcyBub3Qgc2V0CkNPTkZJR19QUENfUE1BQz15CiMgQ09ORklH
X1BQQ184Mnh4IGlzIG5vdCBzZXQKIyBDT05GSUdfUFBDXzgzeHggaXMgbm90IHNldAojIENPTkZJ
R19QUENfODZ4eCBpcyBub3Qgc2V0CiMgQ09ORklHX0VNQkVEREVENnh4IGlzIG5vdCBzZXQKIyBD
T05GSUdfQU1JR0FPTkUgaXMgbm90IHNldAojIENPTkZJR19LVk1fR1VFU1QgaXMgbm90IHNldAoj
IENPTkZJR19FUEFQUl9QQVJBVklSVCBpcyBub3Qgc2V0CkNPTkZJR19QUENfSEFTSF9NTVVfTkFU
SVZFPXkKQ09ORklHX1BQQ19PRl9CT09UX1RSQU1QT0xJTkU9eQpDT05GSUdfTVBJQz15CkNPTkZJ
R19NUElDX01TR1I9eQpDT05GSUdfUFBDX01QQzEwNj15CgojCiMgQ1BVIEZyZXF1ZW5jeSBzY2Fs
aW5nCiMKQ09ORklHX0NQVV9GUkVRPXkKQ09ORklHX0NQVV9GUkVRX0dPVl9BVFRSX1NFVD15CkNP
TkZJR19DUFVfRlJFUV9HT1ZfQ09NTU9OPXkKIyBDT05GSUdfQ1BVX0ZSRVFfU1RBVCBpcyBub3Qg
c2V0CiMgQ09ORklHX0NQVV9GUkVRX0RFRkFVTFRfR09WX1BFUkZPUk1BTkNFIGlzIG5vdCBzZXQK
IyBDT05GSUdfQ1BVX0ZSRVFfREVGQVVMVF9HT1ZfUE9XRVJTQVZFIGlzIG5vdCBzZXQKIyBDT05G
SUdfQ1BVX0ZSRVFfREVGQVVMVF9HT1ZfVVNFUlNQQUNFIGlzIG5vdCBzZXQKQ09ORklHX0NQVV9G
UkVRX0RFRkFVTFRfR09WX09OREVNQU5EPXkKIyBDT05GSUdfQ1BVX0ZSRVFfREVGQVVMVF9HT1Zf
Q09OU0VSVkFUSVZFIGlzIG5vdCBzZXQKQ09ORklHX0NQVV9GUkVRX0dPVl9QRVJGT1JNQU5DRT15
CiMgQ09ORklHX0NQVV9GUkVRX0dPVl9QT1dFUlNBVkUgaXMgbm90IHNldAojIENPTkZJR19DUFVf
RlJFUV9HT1ZfVVNFUlNQQUNFIGlzIG5vdCBzZXQKQ09ORklHX0NQVV9GUkVRX0dPVl9PTkRFTUFO
RD15CiMgQ09ORklHX0NQVV9GUkVRX0dPVl9DT05TRVJWQVRJVkUgaXMgbm90IHNldAoKIwojIENQ
VSBmcmVxdWVuY3kgc2NhbGluZyBkcml2ZXJzCiMKQ09ORklHX0NQVV9GUkVRX1BNQUM9eQojIGVu
ZCBvZiBDUFUgRnJlcXVlbmN5IHNjYWxpbmcKCiMKIyBDUFVJZGxlIGRyaXZlcgojCgojCiMgQ1BV
IElkbGUKIwojIENPTkZJR19DUFVfSURMRSBpcyBub3Qgc2V0CiMgZW5kIG9mIENQVSBJZGxlCiMg
ZW5kIG9mIENQVUlkbGUgZHJpdmVyCgpDT05GSUdfVEFVPXkKIyBDT05GSUdfVEFVX0lOVCBpcyBu
b3Qgc2V0CiMgQ09ORklHX1RBVV9BVkVSQUdFIGlzIG5vdCBzZXQKIyBDT05GSUdfR0VOX1JUQyBp
cyBub3Qgc2V0CiMgZW5kIG9mIFBsYXRmb3JtIHN1cHBvcnQKCiMKIyBLZXJuZWwgb3B0aW9ucwoj
CkNPTkZJR19ISUdITUVNPXkKIyBDT05GSUdfSFpfMTAwIGlzIG5vdCBzZXQKIyBDT05GSUdfSFpf
MjUwIGlzIG5vdCBzZXQKQ09ORklHX0haXzMwMD15CiMgQ09ORklHX0haXzEwMDAgaXMgbm90IHNl
dApDT05GSUdfSFo9MzAwCkNPTkZJR19TQ0hFRF9IUlRJQ0s9eQpDT05GSUdfS0VYRUM9eQojIENP
TkZJR19DUkFTSF9EVU1QIGlzIG5vdCBzZXQKQ09ORklHX0FSQ0hfRkxBVE1FTV9FTkFCTEU9eQpD
T05GSUdfSUxMRUdBTF9QT0lOVEVSX1ZBTFVFPTAKQ09ORklHX1BQQ180S19QQUdFUz15CkNPTkZJ
R19QQUdFX1NJWkVfNEtCPXkKQ09ORklHX1BQQ19QQUdFX1NISUZUPTEyCkNPTkZJR19USFJFQURf
U0hJRlQ9MTMKQ09ORklHX0RBVEFfU0hJRlQ9MjIKQ09ORklHX0ZPUkNFX01BWF9aT05FT1JERVI9
MTEKQ09ORklHX0NNRExJTkU9IiIKQ09ORklHX0VYVFJBX1RBUkdFVFM9IiIKQ09ORklHX0FSQ0hf
V0FOVFNfRlJFRVpFUl9DT05UUk9MPXkKIyBDT05GSUdfU1VTUEVORCBpcyBub3Qgc2V0CiMgQ09O
RklHX0hJQkVSTkFUSU9OIGlzIG5vdCBzZXQKQ09ORklHX1BNPXkKIyBDT05GSUdfUE1fREVCVUcg
aXMgbm90IHNldApDT05GSUdfQVBNX0VNVUxBVElPTj1tCiMgQ09ORklHX1dRX1BPV0VSX0VGRklD
SUVOVF9ERUZBVUxUIGlzIG5vdCBzZXQKIyBlbmQgb2YgS2VybmVsIG9wdGlvbnMKCkNPTkZJR19J
U0FfRE1BX0FQST15CgojCiMgQnVzIG9wdGlvbnMKIwpDT05GSUdfR0VORVJJQ19JU0FfRE1BPXkK
Q09ORklHX1BQQ19JTkRJUkVDVF9QQ0k9eQojIENPTkZJR19GU0xfTEJDIGlzIG5vdCBzZXQKIyBl
bmQgb2YgQnVzIG9wdGlvbnMKCiMKIyBBZHZhbmNlZCBzZXR1cAojCiMgQ09ORklHX0FEVkFOQ0VE
X09QVElPTlMgaXMgbm90IHNldAoKIwojIERlZmF1bHQgc2V0dGluZ3MgZm9yIGFkdmFuY2VkIGNv
bmZpZ3VyYXRpb24gb3B0aW9ucyBhcmUgdXNlZAojCkNPTkZJR19MT1dNRU1fU0laRT0weDMwMDAw
MDAwCkNPTkZJR19QQUdFX09GRlNFVD0weGMwMDAwMDAwCkNPTkZJR19LRVJORUxfU1RBUlQ9MHhj
MDAwMDAwMApDT05GSUdfUEhZU0lDQUxfU1RBUlQ9MHgwMDAwMDAwMApDT05GSUdfVEFTS19TSVpF
PTB4YjAwMDAwMDAKIyBlbmQgb2YgQWR2YW5jZWQgc2V0dXAKCiMgQ09ORklHX1ZJUlRVQUxJWkFU
SU9OIGlzIG5vdCBzZXQKQ09ORklHX0hBVkVfTElWRVBBVENIPXkKCiMKIyBHZW5lcmFsIGFyY2hp
dGVjdHVyZS1kZXBlbmRlbnQgb3B0aW9ucwojCkNPTkZJR19DUkFTSF9DT1JFPXkKQ09ORklHX0tF
WEVDX0NPUkU9eQojIENPTkZJR19LUFJPQkVTIGlzIG5vdCBzZXQKQ09ORklHX0pVTVBfTEFCRUw9
eQojIENPTkZJR19TVEFUSUNfS0VZU19TRUxGVEVTVCBpcyBub3Qgc2V0CiMgQ09ORklHX1NUQVRJ
Q19DQUxMX1NFTEZURVNUIGlzIG5vdCBzZXQKQ09ORklHX0hBVkVfRUZGSUNJRU5UX1VOQUxJR05F
RF9BQ0NFU1M9eQpDT05GSUdfQVJDSF9VU0VfQlVJTFRJTl9CU1dBUD15CkNPTkZJR19IQVZFX0lP
UkVNQVBfUFJPVD15CkNPTkZJR19IQVZFX0tQUk9CRVM9eQpDT05GSUdfSEFWRV9LUkVUUFJPQkVT
PXkKQ09ORklHX0hBVkVfT1BUUFJPQkVTPXkKQ09ORklHX0hBVkVfS1BST0JFU19PTl9GVFJBQ0U9
eQpDT05GSUdfSEFWRV9GVU5DVElPTl9FUlJPUl9JTkpFQ1RJT049eQpDT05GSUdfSEFWRV9OTUk9
eQpDT05GSUdfVFJBQ0VfSVJRRkxBR1NfU1VQUE9SVD15CkNPTkZJR19IQVZFX0FSQ0hfVFJBQ0VI
T09LPXkKQ09ORklHX0dFTkVSSUNfU01QX0lETEVfVEhSRUFEPXkKQ09ORklHX0FSQ0hfSEFTX0ZP
UlRJRllfU09VUkNFPXkKQ09ORklHX0FSQ0hfSEFTX1NFVF9NRU1PUlk9eQpDT05GSUdfQVJDSF9X
QU5UU19OT19JTlNUUj15CkNPTkZJR19BUkNIXzMyQklUX09GRl9UPXkKQ09ORklHX0hBVkVfQVNN
X01PRFZFUlNJT05TPXkKQ09ORklHX0hBVkVfUkVHU19BTkRfU1RBQ0tfQUNDRVNTX0FQST15CkNP
TkZJR19IQVZFX1JTRVE9eQpDT05GSUdfSEFWRV9IV19CUkVBS1BPSU5UPXkKQ09ORklHX0hBVkVf
UEVSRl9SRUdTPXkKQ09ORklHX0hBVkVfUEVSRl9VU0VSX1NUQUNLX0RVTVA9eQpDT05GSUdfSEFW
RV9BUkNIX0pVTVBfTEFCRUw9eQpDT05GSUdfSEFWRV9BUkNIX0pVTVBfTEFCRUxfUkVMQVRJVkU9
eQpDT05GSUdfTU1VX0dBVEhFUl9UQUJMRV9GUkVFPXkKQ09ORklHX01NVV9HQVRIRVJfUkNVX1RB
QkxFX0ZSRUU9eQpDT05GSUdfTU1VX0dBVEhFUl9QQUdFX1NJWkU9eQpDT05GSUdfTU1VX0dBVEhF
Ul9NRVJHRV9WTUFTPXkKQ09ORklHX0FSQ0hfV0FOVF9JUlFTX09GRl9BQ1RJVkFURV9NTT15CkNP
TkZJR19BUkNIX0hBVkVfTk1JX1NBRkVfQ01QWENIRz15CkNPTkZJR19BUkNIX1dFQUtfUkVMRUFT
RV9BQ1FVSVJFPXkKQ09ORklHX0FSQ0hfV0FOVF9JUENfUEFSU0VfVkVSU0lPTj15CkNPTkZJR19I
QVZFX0FSQ0hfU0VDQ09NUD15CkNPTkZJR19IQVZFX0FSQ0hfU0VDQ09NUF9GSUxURVI9eQpDT05G
SUdfU0VDQ09NUD15CkNPTkZJR19TRUNDT01QX0ZJTFRFUj15CiMgQ09ORklHX1NFQ0NPTVBfQ0FD
SEVfREVCVUcgaXMgbm90IHNldApDT05GSUdfSEFWRV9TVEFDS1BST1RFQ1RPUj15CkNPTkZJR19T
VEFDS1BST1RFQ1RPUj15CiMgQ09ORklHX1NUQUNLUFJPVEVDVE9SX1NUUk9ORyBpcyBub3Qgc2V0
CkNPTkZJR19MVE9fTk9ORT15CkNPTkZJR19IQVZFX1ZJUlRfQ1BVX0FDQ09VTlRJTkc9eQpDT05G
SUdfSEFWRV9JUlFfVElNRV9BQ0NPVU5USU5HPXkKQ09ORklHX0hBVkVfTU9EX0FSQ0hfU1BFQ0lG
SUM9eQpDT05GSUdfTU9EVUxFU19VU0VfRUxGX1JFTEE9eQpDT05GSUdfQVJDSF9XQU5UU19NT0RV
TEVTX0RBVEFfSU5fVk1BTExPQz15CkNPTkZJR19IQVZFX1NPRlRJUlFfT05fT1dOX1NUQUNLPXkK
Q09ORklHX1NPRlRJUlFfT05fT1dOX1NUQUNLPXkKQ09ORklHX0FSQ0hfSEFTX0VMRl9SQU5ET01J
WkU9eQpDT05GSUdfSEFWRV9BUkNIX01NQVBfUk5EX0JJVFM9eQpDT05GSUdfQVJDSF9NTUFQX1JO
RF9CSVRTPTExCkNPTkZJR19QQUdFX1NJWkVfTEVTU19USEFOXzY0S0I9eQpDT05GSUdfUEFHRV9T
SVpFX0xFU1NfVEhBTl8yNTZLQj15CkNPTkZJR19BUkNIX1dBTlRfREVGQVVMVF9UT1BET1dOX01N
QVBfTEFZT1VUPXkKQ09ORklHX0hBVkVfUkVMSUFCTEVfU1RBQ0tUUkFDRT15CkNPTkZJR19IQVZF
X0FSQ0hfTlZSQU1fT1BTPXkKQ09ORklHX0NMT05FX0JBQ0tXQVJEUz15CkNPTkZJR19PTERfU0lH
U1VTUEVORD15CkNPTkZJR19PTERfU0lHQUNUSU9OPXkKQ09ORklHX0NPTVBBVF8zMkJJVF9USU1F
PXkKQ09ORklHX0hBVkVfQVJDSF9WTUFQX1NUQUNLPXkKQ09ORklHX1ZNQVBfU1RBQ0s9eQpDT05G
SUdfSEFWRV9BUkNIX1JBTkRPTUlaRV9LU1RBQ0tfT0ZGU0VUPXkKQ09ORklHX1JBTkRPTUlaRV9L
U1RBQ0tfT0ZGU0VUPXkKQ09ORklHX1JBTkRPTUlaRV9LU1RBQ0tfT0ZGU0VUX0RFRkFVTFQ9eQpD
T05GSUdfQVJDSF9PUFRJT05BTF9LRVJORUxfUldYPXkKQ09ORklHX0FSQ0hfT1BUSU9OQUxfS0VS
TkVMX1JXWF9ERUZBVUxUPXkKQ09ORklHX0FSQ0hfSEFTX1NUUklDVF9LRVJORUxfUldYPXkKQ09O
RklHX1NUUklDVF9LRVJORUxfUldYPXkKQ09ORklHX0FSQ0hfSEFTX1NUUklDVF9NT0RVTEVfUldY
PXkKIyBDT05GSUdfU1RSSUNUX01PRFVMRV9SV1ggaXMgbm90IHNldApDT05GSUdfQVJDSF9IQVNf
UEhZU19UT19ETUE9eQpDT05GSUdfSEFWRV9TVEFUSUNfQ0FMTD15CkNPTkZJR19BUkNIX1dBTlRf
TERfT1JQSEFOX1dBUk49eQpDT05GSUdfQVJDSF9TVVBQT1JUU19ERUJVR19QQUdFQUxMT0M9eQoK
IwojIEdDT1YtYmFzZWQga2VybmVsIHByb2ZpbGluZwojCkNPTkZJR19BUkNIX0hBU19HQ09WX1BS
T0ZJTEVfQUxMPXkKIyBlbmQgb2YgR0NPVi1iYXNlZCBrZXJuZWwgcHJvZmlsaW5nCgpDT05GSUdf
SEFWRV9HQ0NfUExVR0lOUz15CkNPTkZJR19HQ0NfUExVR0lOUz15CkNPTkZJR19HQ0NfUExVR0lO
X0xBVEVOVF9FTlRST1BZPXkKIyBlbmQgb2YgR2VuZXJhbCBhcmNoaXRlY3R1cmUtZGVwZW5kZW50
IG9wdGlvbnMKCkNPTkZJR19SVF9NVVRFWEVTPXkKQ09ORklHX0JBU0VfU01BTEw9MApDT05GSUdf
TU9EVUxFUz15CiMgQ09ORklHX01PRFVMRV9GT1JDRV9MT0FEIGlzIG5vdCBzZXQKQ09ORklHX01P
RFVMRV9VTkxPQUQ9eQpDT05GSUdfTU9EVUxFX0ZPUkNFX1VOTE9BRD15CiMgQ09ORklHX01PRFVM
RV9VTkxPQURfVEFJTlRfVFJBQ0tJTkcgaXMgbm90IHNldApDT05GSUdfTU9EVkVSU0lPTlM9eQpD
T05GSUdfQVNNX01PRFZFUlNJT05TPXkKIyBDT05GSUdfTU9EVUxFX1NSQ1ZFUlNJT05fQUxMIGlz
IG5vdCBzZXQKIyBDT05GSUdfTU9EVUxFX1NJRyBpcyBub3Qgc2V0CkNPTkZJR19NT0RVTEVfQ09N
UFJFU1NfTk9ORT15CiMgQ09ORklHX01PRFVMRV9DT01QUkVTU19HWklQIGlzIG5vdCBzZXQKIyBD
T05GSUdfTU9EVUxFX0NPTVBSRVNTX1haIGlzIG5vdCBzZXQKIyBDT05GSUdfTU9EVUxFX0NPTVBS
RVNTX1pTVEQgaXMgbm90IHNldAojIENPTkZJR19NT0RVTEVfQUxMT1dfTUlTU0lOR19OQU1FU1BB
Q0VfSU1QT1JUUyBpcyBub3Qgc2V0CkNPTkZJR19NT0RQUk9CRV9QQVRIPSIvc2Jpbi9tb2Rwcm9i
ZSIKIyBDT05GSUdfVFJJTV9VTlVTRURfS1NZTVMgaXMgbm90IHNldApDT05GSUdfTU9EVUxFU19U
UkVFX0xPT0tVUD15CkNPTkZJR19CTE9DSz15CiMgQ09ORklHX0JMT0NLX0xFR0FDWV9BVVRPTE9B
RCBpcyBub3Qgc2V0CkNPTkZJR19CTEtfQ0dST1VQX1JXU1RBVD15CkNPTkZJR19CTEtfREVWX0JT
R19DT01NT049eQpDT05GSUdfQkxLX0lDUT15CkNPTkZJR19CTEtfREVWX0JTR0xJQj15CiMgQ09O
RklHX0JMS19ERVZfSU5URUdSSVRZIGlzIG5vdCBzZXQKIyBDT05GSUdfQkxLX0RFVl9aT05FRCBp
cyBub3Qgc2V0CkNPTkZJR19CTEtfREVWX1RIUk9UVExJTkc9eQojIENPTkZJR19CTEtfREVWX1RI
Uk9UVExJTkdfTE9XIGlzIG5vdCBzZXQKQ09ORklHX0JMS19XQlQ9eQpDT05GSUdfQkxLX1dCVF9N
UT15CiMgQ09ORklHX0JMS19DR1JPVVBfSU9MQVRFTkNZIGlzIG5vdCBzZXQKIyBDT05GSUdfQkxL
X0NHUk9VUF9JT0NPU1QgaXMgbm90IHNldAojIENPTkZJR19CTEtfQ0dST1VQX0lPUFJJTyBpcyBu
b3Qgc2V0CiMgQ09ORklHX0JMS19TRURfT1BBTCBpcyBub3Qgc2V0CiMgQ09ORklHX0JMS19JTkxJ
TkVfRU5DUllQVElPTiBpcyBub3Qgc2V0CgojCiMgUGFydGl0aW9uIFR5cGVzCiMKQ09ORklHX1BB
UlRJVElPTl9BRFZBTkNFRD15CiMgQ09ORklHX0FDT1JOX1BBUlRJVElPTiBpcyBub3Qgc2V0CiMg
Q09ORklHX0FJWF9QQVJUSVRJT04gaXMgbm90IHNldAojIENPTkZJR19PU0ZfUEFSVElUSU9OIGlz
IG5vdCBzZXQKQ09ORklHX0FNSUdBX1BBUlRJVElPTj15CkNPTkZJR19BVEFSSV9QQVJUSVRJT049
eQpDT05GSUdfTUFDX1BBUlRJVElPTj15CkNPTkZJR19NU0RPU19QQVJUSVRJT049eQpDT05GSUdf
QlNEX0RJU0tMQUJFTD15CkNPTkZJR19NSU5JWF9TVUJQQVJUSVRJT049eQpDT05GSUdfU09MQVJJ
U19YODZfUEFSVElUSU9OPXkKIyBDT05GSUdfVU5JWFdBUkVfRElTS0xBQkVMIGlzIG5vdCBzZXQK
Q09ORklHX0xETV9QQVJUSVRJT049eQojIENPTkZJR19MRE1fREVCVUcgaXMgbm90IHNldAojIENP
TkZJR19TR0lfUEFSVElUSU9OIGlzIG5vdCBzZXQKIyBDT05GSUdfVUxUUklYX1BBUlRJVElPTiBp
cyBub3Qgc2V0CiMgQ09ORklHX1NVTl9QQVJUSVRJT04gaXMgbm90IHNldAojIENPTkZJR19LQVJN
QV9QQVJUSVRJT04gaXMgbm90IHNldApDT05GSUdfRUZJX1BBUlRJVElPTj15CiMgQ09ORklHX1NZ
U1Y2OF9QQVJUSVRJT04gaXMgbm90IHNldAojIENPTkZJR19DTURMSU5FX1BBUlRJVElPTiBpcyBu
b3Qgc2V0CiMgZW5kIG9mIFBhcnRpdGlvbiBUeXBlcwoKQ09ORklHX0JMS19NUV9QQ0k9eQpDT05G
SUdfQkxLX01RX1ZJUlRJTz15CkNPTkZJR19CTEtfUE09eQpDT05GSUdfQkxPQ0tfSE9MREVSX0RF
UFJFQ0FURUQ9eQpDT05GSUdfQkxLX01RX1NUQUNLSU5HPXkKCiMKIyBJTyBTY2hlZHVsZXJzCiMK
IyBDT05GSUdfTVFfSU9TQ0hFRF9ERUFETElORSBpcyBub3Qgc2V0CkNPTkZJR19NUV9JT1NDSEVE
X0tZQkVSPXkKQ09ORklHX0lPU0NIRURfQkZRPXkKIyBDT05GSUdfQkZRX0dST1VQX0lPU0NIRUQg
aXMgbm90IHNldAojIGVuZCBvZiBJTyBTY2hlZHVsZXJzCgpDT05GSUdfQVNOMT15CkNPTkZJR19V
TklOTElORV9TUElOX1VOTE9DSz15CkNPTkZJR19BUkNIX1NVUFBPUlRTX0FUT01JQ19STVc9eQpD
T05GSUdfQVJDSF9IQVNfTk9OX09WRVJMQVBQSU5HX0FERFJFU1NfU1BBQ0U9eQpDT05GSUdfRlJF
RVpFUj15CgojCiMgRXhlY3V0YWJsZSBmaWxlIGZvcm1hdHMKIwpDT05GSUdfQklORk1UX0VMRj15
CkNPTkZJR19FTEZDT1JFPXkKQ09ORklHX0NPUkVfRFVNUF9ERUZBVUxUX0VMRl9IRUFERVJTPXkK
Q09ORklHX0JJTkZNVF9TQ1JJUFQ9eQojIENPTkZJR19CSU5GTVRfTUlTQyBpcyBub3Qgc2V0CkNP
TkZJR19DT1JFRFVNUD15CiMgZW5kIG9mIEV4ZWN1dGFibGUgZmlsZSBmb3JtYXRzCgojCiMgTWVt
b3J5IE1hbmFnZW1lbnQgb3B0aW9ucwojCkNPTkZJR19aUE9PTD15CkNPTkZJR19TV0FQPXkKQ09O
RklHX1pTV0FQPXkKQ09ORklHX1pTV0FQX0RFRkFVTFRfT049eQojIENPTkZJR19aU1dBUF9DT01Q
UkVTU09SX0RFRkFVTFRfREVGTEFURSBpcyBub3Qgc2V0CkNPTkZJR19aU1dBUF9DT01QUkVTU09S
X0RFRkFVTFRfTFpPPXkKIyBDT05GSUdfWlNXQVBfQ09NUFJFU1NPUl9ERUZBVUxUXzg0MiBpcyBu
b3Qgc2V0CiMgQ09ORklHX1pTV0FQX0NPTVBSRVNTT1JfREVGQVVMVF9MWjQgaXMgbm90IHNldAoj
IENPTkZJR19aU1dBUF9DT01QUkVTU09SX0RFRkFVTFRfTFo0SEMgaXMgbm90IHNldAojIENPTkZJ
R19aU1dBUF9DT01QUkVTU09SX0RFRkFVTFRfWlNURCBpcyBub3Qgc2V0CkNPTkZJR19aU1dBUF9D
T01QUkVTU09SX0RFRkFVTFQ9Imx6byIKIyBDT05GSUdfWlNXQVBfWlBPT0xfREVGQVVMVF9aQlVE
IGlzIG5vdCBzZXQKQ09ORklHX1pTV0FQX1pQT09MX0RFRkFVTFRfWjNGT0xEPXkKIyBDT05GSUdf
WlNXQVBfWlBPT0xfREVGQVVMVF9aU01BTExPQyBpcyBub3Qgc2V0CkNPTkZJR19aU1dBUF9aUE9P
TF9ERUZBVUxUPSJ6M2ZvbGQiCiMgQ09ORklHX1pCVUQgaXMgbm90IHNldApDT05GSUdfWjNGT0xE
PXkKIyBDT05GSUdfWlNNQUxMT0MgaXMgbm90IHNldAoKIwojIFNMQUIgYWxsb2NhdG9yIG9wdGlv
bnMKIwojIENPTkZJR19TTEFCIGlzIG5vdCBzZXQKQ09ORklHX1NMVUI9eQojIENPTkZJR19TTE9C
IGlzIG5vdCBzZXQKIyBDT05GSUdfU0xBQl9NRVJHRV9ERUZBVUxUIGlzIG5vdCBzZXQKQ09ORklH
X1NMQUJfRlJFRUxJU1RfUkFORE9NPXkKQ09ORklHX1NMQUJfRlJFRUxJU1RfSEFSREVORUQ9eQoj
IENPTkZJR19TTFVCX1NUQVRTIGlzIG5vdCBzZXQKIyBlbmQgb2YgU0xBQiBhbGxvY2F0b3Igb3B0
aW9ucwoKQ09ORklHX1NIVUZGTEVfUEFHRV9BTExPQ0FUT1I9eQojIENPTkZJR19DT01QQVRfQlJL
IGlzIG5vdCBzZXQKQ09ORklHX0ZMQVRNRU09eQpDT05GSUdfSEFWRV9GQVNUX0dVUD15CkNPTkZJ
R19BUkNIX0tFRVBfTUVNQkxPQ0s9eQpDT05GSUdfRVhDTFVTSVZFX1NZU1RFTV9SQU09eQpDT05G
SUdfQVJDSF9FTkFCTEVfTUVNT1JZX0hPVFBMVUc9eQpDT05GSUdfQVJDSF9FTkFCTEVfTUVNT1JZ
X0hPVFJFTU9WRT15CkNPTkZJR19TUExJVF9QVExPQ0tfQ1BVUz00CkNPTkZJR19DT01QQUNUSU9O
PXkKIyBDT05GSUdfUEFHRV9SRVBPUlRJTkcgaXMgbm90IHNldApDT05GSUdfTUlHUkFUSU9OPXkK
Q09ORklHX0JPVU5DRT15CkNPTkZJR19NTVVfTk9USUZJRVI9eQpDT05GSUdfS1NNPXkKQ09ORklH
X0RFRkFVTFRfTU1BUF9NSU5fQUREUj02NTUzNgpDT05GSUdfTkVFRF9QRVJfQ1BVX0tNPXkKQ09O
RklHX0ZST05UU1dBUD15CiMgQ09ORklHX0NNQSBpcyBub3Qgc2V0CkNPTkZJR19HRU5FUklDX0VB
UkxZX0lPUkVNQVA9eQojIENPTkZJR19JRExFX1BBR0VfVFJBQ0tJTkcgaXMgbm90IHNldApDT05G
SUdfQVJDSF9IQVNfQ1VSUkVOVF9TVEFDS19QT0lOVEVSPXkKQ09ORklHX1pPTkVfRE1BPXkKQ09O
RklHX1ZNX0VWRU5UX0NPVU5URVJTPXkKIyBDT05GSUdfUEVSQ1BVX1NUQVRTIGlzIG5vdCBzZXQK
CiMKIyBHVVBfVEVTVCBuZWVkcyB0byBoYXZlIERFQlVHX0ZTIGVuYWJsZWQKIwpDT05GSUdfQVJD
SF9IQVNfUFRFX1NQRUNJQUw9eQpDT05GSUdfS01BUF9MT0NBTD15CiMgQ09ORklHX0FOT05fVk1B
X05BTUUgaXMgbm90IHNldApDT05GSUdfVVNFUkZBVUxURkQ9eQoKIwojIERhdGEgQWNjZXNzIE1v
bml0b3JpbmcKIwojIENPTkZJR19EQU1PTiBpcyBub3Qgc2V0CiMgZW5kIG9mIERhdGEgQWNjZXNz
IE1vbml0b3JpbmcKIyBlbmQgb2YgTWVtb3J5IE1hbmFnZW1lbnQgb3B0aW9ucwoKQ09ORklHX05F
VD15CkNPTkZJR19TS0JfRVhURU5TSU9OUz15CgojCiMgTmV0d29ya2luZyBvcHRpb25zCiMKQ09O
RklHX1BBQ0tFVD15CkNPTkZJR19QQUNLRVRfRElBRz1tCkNPTkZJR19VTklYPXkKQ09ORklHX1VO
SVhfU0NNPXkKQ09ORklHX0FGX1VOSVhfT09CPXkKQ09ORklHX1VOSVhfRElBRz1tCkNPTkZJR19U
TFM9bQpDT05GSUdfVExTX0RFVklDRT15CiMgQ09ORklHX1RMU19UT0UgaXMgbm90IHNldApDT05G
SUdfWEZSTT15CkNPTkZJR19YRlJNX0FMR089bQpDT05GSUdfWEZSTV9VU0VSPW0KIyBDT05GSUdf
WEZSTV9JTlRFUkZBQ0UgaXMgbm90IHNldAojIENPTkZJR19YRlJNX1NVQl9QT0xJQ1kgaXMgbm90
IHNldAojIENPTkZJR19YRlJNX01JR1JBVEUgaXMgbm90IHNldAojIENPTkZJR19YRlJNX1NUQVRJ
U1RJQ1MgaXMgbm90IHNldApDT05GSUdfWEZSTV9BSD1tCkNPTkZJR19YRlJNX0VTUD1tCkNPTkZJ
R19YRlJNX0lQQ09NUD1tCkNPTkZJR19ORVRfS0VZPW0KIyBDT05GSUdfTkVUX0tFWV9NSUdSQVRF
IGlzIG5vdCBzZXQKIyBDT05GSUdfWERQX1NPQ0tFVFMgaXMgbm90IHNldApDT05GSUdfSU5FVD15
CiMgQ09ORklHX0lQX01VTFRJQ0FTVCBpcyBub3Qgc2V0CiMgQ09ORklHX0lQX0FEVkFOQ0VEX1JP
VVRFUiBpcyBub3Qgc2V0CiMgQ09ORklHX0lQX1BOUCBpcyBub3Qgc2V0CkNPTkZJR19ORVRfSVBJ
UD1tCiMgQ09ORklHX05FVF9JUEdSRV9ERU1VWCBpcyBub3Qgc2V0CkNPTkZJR19ORVRfSVBfVFVO
TkVMPW0KIyBDT05GSUdfU1lOX0NPT0tJRVMgaXMgbm90IHNldAojIENPTkZJR19ORVRfSVBWVEkg
aXMgbm90IHNldApDT05GSUdfTkVUX1VEUF9UVU5ORUw9bQojIENPTkZJR19ORVRfRk9VIGlzIG5v
dCBzZXQKIyBDT05GSUdfTkVUX0ZPVV9JUF9UVU5ORUxTIGlzIG5vdCBzZXQKQ09ORklHX0lORVRf
QUg9bQpDT05GSUdfSU5FVF9FU1A9bQojIENPTkZJR19JTkVUX0VTUF9PRkZMT0FEIGlzIG5vdCBz
ZXQKIyBDT05GSUdfSU5FVF9FU1BJTlRDUCBpcyBub3Qgc2V0CkNPTkZJR19JTkVUX0lQQ09NUD1t
CkNPTkZJR19JTkVUX1hGUk1fVFVOTkVMPW0KQ09ORklHX0lORVRfVFVOTkVMPW0KQ09ORklHX0lO
RVRfRElBRz1tCkNPTkZJR19JTkVUX1RDUF9ESUFHPW0KQ09ORklHX0lORVRfVURQX0RJQUc9bQpD
T05GSUdfSU5FVF9SQVdfRElBRz1tCiMgQ09ORklHX0lORVRfRElBR19ERVNUUk9ZIGlzIG5vdCBz
ZXQKQ09ORklHX1RDUF9DT05HX0FEVkFOQ0VEPXkKIyBDT05GSUdfVENQX0NPTkdfQklDIGlzIG5v
dCBzZXQKIyBDT05GSUdfVENQX0NPTkdfQ1VCSUMgaXMgbm90IHNldApDT05GSUdfVENQX0NPTkdf
V0VTVFdPT0Q9eQojIENPTkZJR19UQ1BfQ09OR19IVENQIGlzIG5vdCBzZXQKIyBDT05GSUdfVENQ
X0NPTkdfSFNUQ1AgaXMgbm90IHNldAojIENPTkZJR19UQ1BfQ09OR19IWUJMQSBpcyBub3Qgc2V0
CiMgQ09ORklHX1RDUF9DT05HX1ZFR0FTIGlzIG5vdCBzZXQKIyBDT05GSUdfVENQX0NPTkdfTlYg
aXMgbm90IHNldAojIENPTkZJR19UQ1BfQ09OR19TQ0FMQUJMRSBpcyBub3Qgc2V0CiMgQ09ORklH
X1RDUF9DT05HX0xQIGlzIG5vdCBzZXQKIyBDT05GSUdfVENQX0NPTkdfVkVOTyBpcyBub3Qgc2V0
CiMgQ09ORklHX1RDUF9DT05HX1lFQUggaXMgbm90IHNldAojIENPTkZJR19UQ1BfQ09OR19JTExJ
Tk9JUyBpcyBub3Qgc2V0CiMgQ09ORklHX1RDUF9DT05HX0RDVENQIGlzIG5vdCBzZXQKIyBDT05G
SUdfVENQX0NPTkdfQ0RHIGlzIG5vdCBzZXQKIyBDT05GSUdfVENQX0NPTkdfQkJSIGlzIG5vdCBz
ZXQKQ09ORklHX0RFRkFVTFRfV0VTVFdPT0Q9eQojIENPTkZJR19ERUZBVUxUX1JFTk8gaXMgbm90
IHNldApDT05GSUdfREVGQVVMVF9UQ1BfQ09ORz0id2VzdHdvb2QiCiMgQ09ORklHX1RDUF9NRDVT
SUcgaXMgbm90IHNldApDT05GSUdfSVBWNj15CkNPTkZJR19JUFY2X1JPVVRFUl9QUkVGPXkKIyBD
T05GSUdfSVBWNl9ST1VURV9JTkZPIGlzIG5vdCBzZXQKQ09ORklHX0lQVjZfT1BUSU1JU1RJQ19E
QUQ9eQpDT05GSUdfSU5FVDZfQUg9bQpDT05GSUdfSU5FVDZfRVNQPW0KIyBDT05GSUdfSU5FVDZf
RVNQX09GRkxPQUQgaXMgbm90IHNldAojIENPTkZJR19JTkVUNl9FU1BJTlRDUCBpcyBub3Qgc2V0
CkNPTkZJR19JTkVUNl9JUENPTVA9bQojIENPTkZJR19JUFY2X01JUDYgaXMgbm90IHNldApDT05G
SUdfSU5FVDZfWEZSTV9UVU5ORUw9bQpDT05GSUdfSU5FVDZfVFVOTkVMPW0KIyBDT05GSUdfSVBW
Nl9WVEkgaXMgbm90IHNldApDT05GSUdfSVBWNl9TSVQ9bQpDT05GSUdfSVBWNl9TSVRfNlJEPXkK
Q09ORklHX0lQVjZfTkRJU0NfTk9ERVRZUEU9eQojIENPTkZJR19JUFY2X1RVTk5FTCBpcyBub3Qg
c2V0CkNPTkZJR19JUFY2X01VTFRJUExFX1RBQkxFUz15CiMgQ09ORklHX0lQVjZfU1VCVFJFRVMg
aXMgbm90IHNldAojIENPTkZJR19JUFY2X01ST1VURSBpcyBub3Qgc2V0CiMgQ09ORklHX0lQVjZf
U0VHNl9MV1RVTk5FTCBpcyBub3Qgc2V0CiMgQ09ORklHX0lQVjZfU0VHNl9ITUFDIGlzIG5vdCBz
ZXQKIyBDT05GSUdfSVBWNl9SUExfTFdUVU5ORUwgaXMgbm90IHNldAojIENPTkZJR19JUFY2X0lP
QU02X0xXVFVOTkVMIGlzIG5vdCBzZXQKIyBDT05GSUdfTkVUTEFCRUwgaXMgbm90IHNldAojIENP
TkZJR19NUFRDUCBpcyBub3Qgc2V0CiMgQ09ORklHX05FVFdPUktfU0VDTUFSSyBpcyBub3Qgc2V0
CiMgQ09ORklHX05FVFdPUktfUEhZX1RJTUVTVEFNUElORyBpcyBub3Qgc2V0CiMgQ09ORklHX05F
VEZJTFRFUiBpcyBub3Qgc2V0CiMgQ09ORklHX0JQRklMVEVSIGlzIG5vdCBzZXQKIyBDT05GSUdf
SVBfRENDUCBpcyBub3Qgc2V0CkNPTkZJR19JUF9TQ1RQPW0KIyBDT05GSUdfU0NUUF9EQkdfT0JK
Q05UIGlzIG5vdCBzZXQKQ09ORklHX1NDVFBfREVGQVVMVF9DT09LSUVfSE1BQ19NRDU9eQojIENP
TkZJR19TQ1RQX0RFRkFVTFRfQ09PS0lFX0hNQUNfU0hBMSBpcyBub3Qgc2V0CiMgQ09ORklHX1ND
VFBfREVGQVVMVF9DT09LSUVfSE1BQ19OT05FIGlzIG5vdCBzZXQKQ09ORklHX1NDVFBfQ09PS0lF
X0hNQUNfTUQ1PXkKIyBDT05GSUdfU0NUUF9DT09LSUVfSE1BQ19TSEExIGlzIG5vdCBzZXQKQ09O
RklHX0lORVRfU0NUUF9ESUFHPW0KIyBDT05GSUdfUkRTIGlzIG5vdCBzZXQKIyBDT05GSUdfVElQ
QyBpcyBub3Qgc2V0CiMgQ09ORklHX0FUTSBpcyBub3Qgc2V0CiMgQ09ORklHX0wyVFAgaXMgbm90
IHNldAojIENPTkZJR19CUklER0UgaXMgbm90IHNldAojIENPTkZJR19ORVRfRFNBIGlzIG5vdCBz
ZXQKIyBDT05GSUdfVkxBTl84MDIxUSBpcyBub3Qgc2V0CiMgQ09ORklHX0RFQ05FVCBpcyBub3Qg
c2V0CiMgQ09ORklHX0xMQzIgaXMgbm90IHNldAojIENPTkZJR19BVEFMSyBpcyBub3Qgc2V0CiMg
Q09ORklHX1gyNSBpcyBub3Qgc2V0CiMgQ09ORklHX0xBUEIgaXMgbm90IHNldAojIENPTkZJR19Q
SE9ORVQgaXMgbm90IHNldAojIENPTkZJR182TE9XUEFOIGlzIG5vdCBzZXQKIyBDT05GSUdfSUVF
RTgwMjE1NCBpcyBub3Qgc2V0CkNPTkZJR19ORVRfU0NIRUQ9eQoKIwojIFF1ZXVlaW5nL1NjaGVk
dWxpbmcKIwojIENPTkZJR19ORVRfU0NIX0NCUSBpcyBub3Qgc2V0CiMgQ09ORklHX05FVF9TQ0hf
SFRCIGlzIG5vdCBzZXQKIyBDT05GSUdfTkVUX1NDSF9IRlNDIGlzIG5vdCBzZXQKIyBDT05GSUdf
TkVUX1NDSF9QUklPIGlzIG5vdCBzZXQKIyBDT05GSUdfTkVUX1NDSF9NVUxUSVEgaXMgbm90IHNl
dAojIENPTkZJR19ORVRfU0NIX1JFRCBpcyBub3Qgc2V0CiMgQ09ORklHX05FVF9TQ0hfU0ZCIGlz
IG5vdCBzZXQKIyBDT05GSUdfTkVUX1NDSF9TRlEgaXMgbm90IHNldAojIENPTkZJR19ORVRfU0NI
X1RFUUwgaXMgbm90IHNldAojIENPTkZJR19ORVRfU0NIX1RCRiBpcyBub3Qgc2V0CiMgQ09ORklH
X05FVF9TQ0hfQ0JTIGlzIG5vdCBzZXQKIyBDT05GSUdfTkVUX1NDSF9FVEYgaXMgbm90IHNldAoj
IENPTkZJR19ORVRfU0NIX1RBUFJJTyBpcyBub3Qgc2V0CiMgQ09ORklHX05FVF9TQ0hfR1JFRCBp
cyBub3Qgc2V0CiMgQ09ORklHX05FVF9TQ0hfRFNNQVJLIGlzIG5vdCBzZXQKIyBDT05GSUdfTkVU
X1NDSF9ORVRFTSBpcyBub3Qgc2V0CiMgQ09ORklHX05FVF9TQ0hfRFJSIGlzIG5vdCBzZXQKIyBD
T05GSUdfTkVUX1NDSF9NUVBSSU8gaXMgbm90IHNldAojIENPTkZJR19ORVRfU0NIX1NLQlBSSU8g
aXMgbm90IHNldAojIENPTkZJR19ORVRfU0NIX0NIT0tFIGlzIG5vdCBzZXQKIyBDT05GSUdfTkVU
X1NDSF9RRlEgaXMgbm90IHNldAojIENPTkZJR19ORVRfU0NIX0NPREVMIGlzIG5vdCBzZXQKQ09O
RklHX05FVF9TQ0hfRlFfQ09ERUw9eQojIENPTkZJR19ORVRfU0NIX0NBS0UgaXMgbm90IHNldAoj
IENPTkZJR19ORVRfU0NIX0ZRIGlzIG5vdCBzZXQKIyBDT05GSUdfTkVUX1NDSF9ISEYgaXMgbm90
IHNldAojIENPTkZJR19ORVRfU0NIX1BJRSBpcyBub3Qgc2V0CiMgQ09ORklHX05FVF9TQ0hfUExV
RyBpcyBub3Qgc2V0CiMgQ09ORklHX05FVF9TQ0hfRVRTIGlzIG5vdCBzZXQKQ09ORklHX05FVF9T
Q0hfREVGQVVMVD15CkNPTkZJR19ERUZBVUxUX0ZRX0NPREVMPXkKIyBDT05GSUdfREVGQVVMVF9Q
RklGT19GQVNUIGlzIG5vdCBzZXQKQ09ORklHX0RFRkFVTFRfTkVUX1NDSD0iZnFfY29kZWwiCgoj
CiMgQ2xhc3NpZmljYXRpb24KIwojIENPTkZJR19ORVRfQ0xTX0JBU0lDIGlzIG5vdCBzZXQKIyBD
T05GSUdfTkVUX0NMU19UQ0lOREVYIGlzIG5vdCBzZXQKIyBDT05GSUdfTkVUX0NMU19ST1VURTQg
aXMgbm90IHNldAojIENPTkZJR19ORVRfQ0xTX0ZXIGlzIG5vdCBzZXQKIyBDT05GSUdfTkVUX0NM
U19VMzIgaXMgbm90IHNldAojIENPTkZJR19ORVRfQ0xTX1JTVlAgaXMgbm90IHNldAojIENPTkZJ
R19ORVRfQ0xTX1JTVlA2IGlzIG5vdCBzZXQKIyBDT05GSUdfTkVUX0NMU19GTE9XIGlzIG5vdCBz
ZXQKIyBDT05GSUdfTkVUX0NMU19DR1JPVVAgaXMgbm90IHNldAojIENPTkZJR19ORVRfQ0xTX0JQ
RiBpcyBub3Qgc2V0CiMgQ09ORklHX05FVF9DTFNfRkxPV0VSIGlzIG5vdCBzZXQKIyBDT05GSUdf
TkVUX0NMU19NQVRDSEFMTCBpcyBub3Qgc2V0CiMgQ09ORklHX05FVF9FTUFUQ0ggaXMgbm90IHNl
dAojIENPTkZJR19ORVRfQ0xTX0FDVCBpcyBub3Qgc2V0CkNPTkZJR19ORVRfU0NIX0ZJRk89eQoj
IENPTkZJR19EQ0IgaXMgbm90IHNldApDT05GSUdfRE5TX1JFU09MVkVSPW0KIyBDT05GSUdfQkFU
TUFOX0FEViBpcyBub3Qgc2V0CiMgQ09ORklHX09QRU5WU1dJVENIIGlzIG5vdCBzZXQKIyBDT05G
SUdfVlNPQ0tFVFMgaXMgbm90IHNldAojIENPTkZJR19ORVRMSU5LX0RJQUcgaXMgbm90IHNldAoj
IENPTkZJR19NUExTIGlzIG5vdCBzZXQKIyBDT05GSUdfTkVUX05TSCBpcyBub3Qgc2V0CiMgQ09O
RklHX0hTUiBpcyBub3Qgc2V0CiMgQ09ORklHX05FVF9TV0lUQ0hERVYgaXMgbm90IHNldAojIENP
TkZJR19ORVRfTDNfTUFTVEVSX0RFViBpcyBub3Qgc2V0CiMgQ09ORklHX1FSVFIgaXMgbm90IHNl
dAojIENPTkZJR19ORVRfTkNTSSBpcyBub3Qgc2V0CkNPTkZJR19TT0NLX1JYX1FVRVVFX01BUFBJ
Tkc9eQojIENPTkZJR19DR1JPVVBfTkVUX1BSSU8gaXMgbm90IHNldApDT05GSUdfQ0dST1VQX05F
VF9DTEFTU0lEPXkKQ09ORklHX05FVF9SWF9CVVNZX1BPTEw9eQpDT05GSUdfQlFMPXkKIyBDT05G
SUdfQlBGX1NUUkVBTV9QQVJTRVIgaXMgbm90IHNldAoKIwojIE5ldHdvcmsgdGVzdGluZwojCiMg
Q09ORklHX05FVF9QS1RHRU4gaXMgbm90IHNldAojIGVuZCBvZiBOZXR3b3JrIHRlc3RpbmcKIyBl
bmQgb2YgTmV0d29ya2luZyBvcHRpb25zCgojIENPTkZJR19IQU1SQURJTyBpcyBub3Qgc2V0CiMg
Q09ORklHX0NBTiBpcyBub3Qgc2V0CkNPTkZJR19CVD1tCkNPTkZJR19CVF9CUkVEUj15CkNPTkZJ
R19CVF9SRkNPTU09bQpDT05GSUdfQlRfUkZDT01NX1RUWT15CkNPTkZJR19CVF9CTkVQPW0KQ09O
RklHX0JUX0JORVBfTUNfRklMVEVSPXkKQ09ORklHX0JUX0JORVBfUFJPVE9fRklMVEVSPXkKQ09O
RklHX0JUX0hJRFA9bQpDT05GSUdfQlRfSFM9eQpDT05GSUdfQlRfTEU9eQpDT05GSUdfQlRfTEVE
Uz15CkNPTkZJR19CVF9NU0ZURVhUPXkKQ09ORklHX0JUX0FPU1BFWFQ9eQojIENPTkZJR19CVF9T
RUxGVEVTVCBpcyBub3Qgc2V0CiMgQ09ORklHX0JUX0ZFQVRVUkVfREVCVUcgaXMgbm90IHNldAoK
IwojIEJsdWV0b290aCBkZXZpY2UgZHJpdmVycwojCkNPTkZJR19CVF9JTlRFTD1tCkNPTkZJR19C
VF9CQ009bQpDT05GSUdfQlRfUlRMPW0KQ09ORklHX0JUX01USz1tCkNPTkZJR19CVF9IQ0lCVFVT
Qj1tCkNPTkZJR19CVF9IQ0lCVFVTQl9BVVRPU1VTUEVORD15CkNPTkZJR19CVF9IQ0lCVFVTQl9C
Q009eQpDT05GSUdfQlRfSENJQlRVU0JfTVRLPXkKQ09ORklHX0JUX0hDSUJUVVNCX1JUTD15CiMg
Q09ORklHX0JUX0hDSVVBUlQgaXMgbm90IHNldAojIENPTkZJR19CVF9IQ0lCQ00yMDNYIGlzIG5v
dCBzZXQKIyBDT05GSUdfQlRfSENJQlBBMTBYIGlzIG5vdCBzZXQKIyBDT05GSUdfQlRfSENJQkZV
U0IgaXMgbm90IHNldAojIENPTkZJR19CVF9IQ0lEVEwxIGlzIG5vdCBzZXQKIyBDT05GSUdfQlRf
SENJQlQzQyBpcyBub3Qgc2V0CiMgQ09ORklHX0JUX0hDSUJMVUVDQVJEIGlzIG5vdCBzZXQKIyBD
T05GSUdfQlRfSENJVkhDSSBpcyBub3Qgc2V0CkNPTkZJR19CVF9NUlZMPW0KQ09ORklHX0JUX0FU
SDNLPW0KIyBDT05GSUdfQlRfTVRLVUFSVCBpcyBub3Qgc2V0CiMgQ09ORklHX0JUX1ZJUlRJTyBp
cyBub3Qgc2V0CiMgZW5kIG9mIEJsdWV0b290aCBkZXZpY2UgZHJpdmVycwoKIyBDT05GSUdfQUZf
UlhSUEMgaXMgbm90IHNldAojIENPTkZJR19BRl9LQ00gaXMgbm90IHNldApDT05GSUdfU1RSRUFN
X1BBUlNFUj15CiMgQ09ORklHX01DVFAgaXMgbm90IHNldApDT05GSUdfRklCX1JVTEVTPXkKQ09O
RklHX1dJUkVMRVNTPXkKQ09ORklHX0NGRzgwMjExPW0KIyBDT05GSUdfTkw4MDIxMV9URVNUTU9E
RSBpcyBub3Qgc2V0CiMgQ09ORklHX0NGRzgwMjExX0RFVkVMT1BFUl9XQVJOSU5HUyBpcyBub3Qg
c2V0CiMgQ09ORklHX0NGRzgwMjExX0NFUlRJRklDQVRJT05fT05VUyBpcyBub3Qgc2V0CkNPTkZJ
R19DRkc4MDIxMV9SRVFVSVJFX1NJR05FRF9SRUdEQj15CkNPTkZJR19DRkc4MDIxMV9VU0VfS0VS
TkVMX1JFR0RCX0tFWVM9eQpDT05GSUdfQ0ZHODAyMTFfREVGQVVMVF9QUz15CkNPTkZJR19DRkc4
MDIxMV9DUkRBX1NVUFBPUlQ9eQojIENPTkZJR19DRkc4MDIxMV9XRVhUIGlzIG5vdCBzZXQKQ09O
RklHX01BQzgwMjExPW0KQ09ORklHX01BQzgwMjExX0hBU19SQz15CkNPTkZJR19NQUM4MDIxMV9S
Q19NSU5TVFJFTD15CkNPTkZJR19NQUM4MDIxMV9SQ19ERUZBVUxUX01JTlNUUkVMPXkKQ09ORklH
X01BQzgwMjExX1JDX0RFRkFVTFQ9Im1pbnN0cmVsX2h0IgojIENPTkZJR19NQUM4MDIxMV9NRVNI
IGlzIG5vdCBzZXQKQ09ORklHX01BQzgwMjExX0xFRFM9eQojIENPTkZJR19NQUM4MDIxMV9NRVNT
QUdFX1RSQUNJTkcgaXMgbm90IHNldAojIENPTkZJR19NQUM4MDIxMV9ERUJVR19NRU5VIGlzIG5v
dCBzZXQKQ09ORklHX01BQzgwMjExX1NUQV9IQVNIX01BWF9TSVpFPTAKQ09ORklHX1JGS0lMTD1t
CkNPTkZJR19SRktJTExfTEVEUz15CkNPTkZJR19SRktJTExfSU5QVVQ9eQpDT05GSUdfUkZLSUxM
X0dQSU89bQojIENPTkZJR19ORVRfOVAgaXMgbm90IHNldAojIENPTkZJR19DQUlGIGlzIG5vdCBz
ZXQKIyBDT05GSUdfQ0VQSF9MSUIgaXMgbm90IHNldAojIENPTkZJR19ORkMgaXMgbm90IHNldAoj
IENPTkZJR19QU0FNUExFIGlzIG5vdCBzZXQKIyBDT05GSUdfTkVUX0lGRSBpcyBub3Qgc2V0CiMg
Q09ORklHX0xXVFVOTkVMIGlzIG5vdCBzZXQKQ09ORklHX0RTVF9DQUNIRT15CkNPTkZJR19HUk9f
Q0VMTFM9eQpDT05GSUdfU09DS19WQUxJREFURV9YTUlUPXkKQ09ORklHX05FVF9TT0NLX01TRz15
CkNPTkZJR19QQUdFX1BPT0w9eQojIENPTkZJR19QQUdFX1BPT0xfU1RBVFMgaXMgbm90IHNldAoj
IENPTkZJR19GQUlMT1ZFUiBpcyBub3Qgc2V0CkNPTkZJR19FVEhUT09MX05FVExJTks9eQoKIwoj
IERldmljZSBEcml2ZXJzCiMKQ09ORklHX0hBVkVfUENJPXkKQ09ORklHX0ZPUkNFX1BDST15CkNP
TkZJR19QQ0k9eQpDT05GSUdfUENJX0RPTUFJTlM9eQpDT05GSUdfUENJX1NZU0NBTEw9eQojIENP
TkZJR19QQ0lFUE9SVEJVUyBpcyBub3Qgc2V0CiMgQ09ORklHX1BDSUVBU1BNIGlzIG5vdCBzZXQK
IyBDT05GSUdfUENJRV9QVE0gaXMgbm90IHNldApDT05GSUdfUENJX01TST15CkNPTkZJR19QQ0lf
TVNJX0lSUV9ET01BSU49eQpDT05GSUdfUENJX01TSV9BUkNIX0ZBTExCQUNLUz15CkNPTkZJR19Q
Q0lfUVVJUktTPXkKIyBDT05GSUdfUENJX0RFQlVHIGlzIG5vdCBzZXQKIyBDT05GSUdfUENJX1NU
VUIgaXMgbm90IHNldAojIENPTkZJR19QQ0lfSU9WIGlzIG5vdCBzZXQKIyBDT05GSUdfUENJX1BS
SSBpcyBub3Qgc2V0CiMgQ09ORklHX1BDSV9QQVNJRCBpcyBub3Qgc2V0CiMgQ09ORklHX1BDSUVf
QlVTX1RVTkVfT0ZGIGlzIG5vdCBzZXQKQ09ORklHX1BDSUVfQlVTX0RFRkFVTFQ9eQojIENPTkZJ
R19QQ0lFX0JVU19TQUZFIGlzIG5vdCBzZXQKIyBDT05GSUdfUENJRV9CVVNfUEVSRk9STUFOQ0Ug
aXMgbm90IHNldAojIENPTkZJR19QQ0lFX0JVU19QRUVSMlBFRVIgaXMgbm90IHNldApDT05GSUdf
VkdBX0FSQj15CkNPTkZJR19WR0FfQVJCX01BWF9HUFVTPTQKIyBDT05GSUdfSE9UUExVR19QQ0kg
aXMgbm90IHNldAoKIwojIFBDSSBjb250cm9sbGVyIGRyaXZlcnMKIwojIENPTkZJR19QQ0lfRlRQ
Q0kxMDAgaXMgbm90IHNldAojIENPTkZJR19QQ0lfSE9TVF9HRU5FUklDIGlzIG5vdCBzZXQKIyBD
T05GSUdfUENJRV9YSUxJTlggaXMgbm90IHNldAojIENPTkZJR19QQ0lFX01JQ1JPQ0hJUF9IT1NU
IGlzIG5vdCBzZXQKCiMKIyBEZXNpZ25XYXJlIFBDSSBDb3JlIFN1cHBvcnQKIwojIENPTkZJR19Q
Q0lFX0RXX1BMQVRfSE9TVCBpcyBub3Qgc2V0CiMgQ09ORklHX1BDSV9NRVNPTiBpcyBub3Qgc2V0
CiMgZW5kIG9mIERlc2lnbldhcmUgUENJIENvcmUgU3VwcG9ydAoKIwojIE1vYml2ZWlsIFBDSWUg
Q29yZSBTdXBwb3J0CiMKIyBlbmQgb2YgTW9iaXZlaWwgUENJZSBDb3JlIFN1cHBvcnQKCiMKIyBD
YWRlbmNlIFBDSWUgY29udHJvbGxlcnMgc3VwcG9ydAojCiMgQ09ORklHX1BDSUVfQ0FERU5DRV9Q
TEFUX0hPU1QgaXMgbm90IHNldAojIENPTkZJR19QQ0lfSjcyMUVfSE9TVCBpcyBub3Qgc2V0CiMg
ZW5kIG9mIENhZGVuY2UgUENJZSBjb250cm9sbGVycyBzdXBwb3J0CiMgZW5kIG9mIFBDSSBjb250
cm9sbGVyIGRyaXZlcnMKCiMKIyBQQ0kgRW5kcG9pbnQKIwojIENPTkZJR19QQ0lfRU5EUE9JTlQg
aXMgbm90IHNldAojIGVuZCBvZiBQQ0kgRW5kcG9pbnQKCiMKIyBQQ0kgc3dpdGNoIGNvbnRyb2xs
ZXIgZHJpdmVycwojCiMgQ09ORklHX1BDSV9TV19TV0lUQ0hURUMgaXMgbm90IHNldAojIGVuZCBv
ZiBQQ0kgc3dpdGNoIGNvbnRyb2xsZXIgZHJpdmVycwoKIyBDT05GSUdfQ1hMX0JVUyBpcyBub3Qg
c2V0CkNPTkZJR19QQ0NBUkQ9bQpDT05GSUdfUENNQ0lBPW0KQ09ORklHX1BDTUNJQV9MT0FEX0NJ
Uz15CkNPTkZJR19DQVJEQlVTPXkKCiMKIyBQQy1jYXJkIGJyaWRnZXMKIwpDT05GSUdfWUVOVEE9
bQpDT05GSUdfWUVOVEFfTzI9eQpDT05GSUdfWUVOVEFfUklDT0g9eQpDT05GSUdfWUVOVEFfVEk9
eQpDT05GSUdfWUVOVEFfRU5FX1RVTkU9eQpDT05GSUdfWUVOVEFfVE9TSElCQT15CiMgQ09ORklH
X1BENjcyOSBpcyBub3Qgc2V0CiMgQ09ORklHX0k4MjA5MiBpcyBub3Qgc2V0CkNPTkZJR19QQ0NB
UkRfTk9OU1RBVElDPXkKIyBDT05GSUdfUkFQSURJTyBpcyBub3Qgc2V0CgojCiMgR2VuZXJpYyBE
cml2ZXIgT3B0aW9ucwojCiMgQ09ORklHX1VFVkVOVF9IRUxQRVIgaXMgbm90IHNldApDT05GSUdf
REVWVE1QRlM9eQpDT05GSUdfREVWVE1QRlNfTU9VTlQ9eQpDT05GSUdfREVWVE1QRlNfU0FGRT15
CkNPTkZJR19TVEFOREFMT05FPXkKQ09ORklHX1BSRVZFTlRfRklSTVdBUkVfQlVJTEQ9eQoKIwoj
IEZpcm13YXJlIGxvYWRlcgojCkNPTkZJR19GV19MT0FERVI9eQpDT05GSUdfRldfTE9BREVSX1BB
R0VEX0JVRj15CkNPTkZJR19GV19MT0FERVJfU1lTRlM9eQpDT05GSUdfRVhUUkFfRklSTVdBUkU9
IiIKQ09ORklHX0ZXX0xPQURFUl9VU0VSX0hFTFBFUj15CiMgQ09ORklHX0ZXX0xPQURFUl9VU0VS
X0hFTFBFUl9GQUxMQkFDSyBpcyBub3Qgc2V0CiMgQ09ORklHX0ZXX0xPQURFUl9DT01QUkVTUyBp
cyBub3Qgc2V0CiMgQ09ORklHX0ZXX1VQTE9BRCBpcyBub3Qgc2V0CiMgZW5kIG9mIEZpcm13YXJl
IGxvYWRlcgoKQ09ORklHX0FMTE9XX0RFVl9DT1JFRFVNUD15CiMgQ09ORklHX0RFQlVHX0RSSVZF
UiBpcyBub3Qgc2V0CiMgQ09ORklHX0RFQlVHX0RFVlJFUyBpcyBub3Qgc2V0CiMgQ09ORklHX0RF
QlVHX1RFU1RfRFJJVkVSX1JFTU9WRSBpcyBub3Qgc2V0CiMgQ09ORklHX1RFU1RfQVNZTkNfRFJJ
VkVSX1BST0JFIGlzIG5vdCBzZXQKQ09ORklHX0dFTkVSSUNfQ1BVX0FVVE9QUk9CRT15CkNPTkZJ
R19SRUdNQVA9eQpDT05GSUdfRE1BX1NIQVJFRF9CVUZGRVI9eQojIENPTkZJR19ETUFfRkVOQ0Vf
VFJBQ0UgaXMgbm90IHNldAojIGVuZCBvZiBHZW5lcmljIERyaXZlciBPcHRpb25zCgojCiMgQnVz
IGRldmljZXMKIwojIENPTkZJR19NSElfQlVTIGlzIG5vdCBzZXQKIyBDT05GSUdfTUhJX0JVU19F
UCBpcyBub3Qgc2V0CiMgZW5kIG9mIEJ1cyBkZXZpY2VzCgojIENPTkZJR19DT05ORUNUT1IgaXMg
bm90IHNldAoKIwojIEZpcm13YXJlIERyaXZlcnMKIwoKIwojIEFSTSBTeXN0ZW0gQ29udHJvbCBh
bmQgTWFuYWdlbWVudCBJbnRlcmZhY2UgUHJvdG9jb2wKIwojIGVuZCBvZiBBUk0gU3lzdGVtIENv
bnRyb2wgYW5kIE1hbmFnZW1lbnQgSW50ZXJmYWNlIFByb3RvY29sCgpDT05GSUdfRklSTVdBUkVf
TUVNTUFQPXkKIyBDT05GSUdfRldfQ0ZHX1NZU0ZTIGlzIG5vdCBzZXQKIyBDT05GSUdfR09PR0xF
X0ZJUk1XQVJFIGlzIG5vdCBzZXQKCiMKIyBUZWdyYSBmaXJtd2FyZSBkcml2ZXIKIwojIGVuZCBv
ZiBUZWdyYSBmaXJtd2FyZSBkcml2ZXIKIyBlbmQgb2YgRmlybXdhcmUgRHJpdmVycwoKIyBDT05G
SUdfR05TUyBpcyBub3Qgc2V0CiMgQ09ORklHX01URCBpcyBub3Qgc2V0CkNPTkZJR19EVEM9eQpD
T05GSUdfT0Y9eQojIENPTkZJR19PRl9VTklUVEVTVCBpcyBub3Qgc2V0CkNPTkZJR19PRl9GTEFU
VFJFRT15CkNPTkZJR19PRl9FQVJMWV9GTEFUVFJFRT15CkNPTkZJR19PRl9LT0JKPXkKQ09ORklH
X09GX0FERFJFU1M9eQpDT05GSUdfT0ZfSVJRPXkKQ09ORklHX09GX1JFU0VSVkVEX01FTT15CiMg
Q09ORklHX09GX09WRVJMQVkgaXMgbm90IHNldApDT05GSUdfT0ZfRE1BX0RFRkFVTFRfQ09IRVJF
TlQ9eQpDT05GSUdfQVJDSF9NSUdIVF9IQVZFX1BDX1BBUlBPUlQ9eQojIENPTkZJR19QQVJQT1JU
IGlzIG5vdCBzZXQKQ09ORklHX0JMS19ERVY9eQojIENPTkZJR19CTEtfREVWX05VTExfQkxLIGlz
IG5vdCBzZXQKIyBDT05GSUdfQkxLX0RFVl9GRCBpcyBub3Qgc2V0CiMgQ09ORklHX01BQ19GTE9Q
UFkgaXMgbm90IHNldApDT05GSUdfQ0RST009bQojIENPTkZJR19CTEtfREVWX1BDSUVTU0RfTVRJ
UDMyWFggaXMgbm90IHNldAojIENPTkZJR19aUkFNIGlzIG5vdCBzZXQKQ09ORklHX0JMS19ERVZf
TE9PUD1tCkNPTkZJR19CTEtfREVWX0xPT1BfTUlOX0NPVU5UPTgKIyBDT05GSUdfQkxLX0RFVl9E
UkJEIGlzIG5vdCBzZXQKIyBDT05GSUdfQkxLX0RFVl9OQkQgaXMgbm90IHNldAojIENPTkZJR19C
TEtfREVWX1JBTSBpcyBub3Qgc2V0CiMgQ09ORklHX0NEUk9NX1BLVENEVkQgaXMgbm90IHNldAoj
IENPTkZJR19BVEFfT1ZFUl9FVEggaXMgbm90IHNldAojIENPTkZJR19WSVJUSU9fQkxLIGlzIG5v
dCBzZXQKIyBDT05GSUdfQkxLX0RFVl9SQkQgaXMgbm90IHNldAojIENPTkZJR19CTEtfREVWX1VC
TEsgaXMgbm90IHNldAoKIwojIE5WTUUgU3VwcG9ydAojCiMgQ09ORklHX0JMS19ERVZfTlZNRSBp
cyBub3Qgc2V0CiMgQ09ORklHX05WTUVfRkMgaXMgbm90IHNldAojIENPTkZJR19OVk1FX1RDUCBp
cyBub3Qgc2V0CiMgQ09ORklHX05WTUVfVEFSR0VUIGlzIG5vdCBzZXQKIyBlbmQgb2YgTlZNRSBT
dXBwb3J0CgojCiMgTWlzYyBkZXZpY2VzCiMKIyBDT05GSUdfQUQ1MjVYX0RQT1QgaXMgbm90IHNl
dAojIENPTkZJR19EVU1NWV9JUlEgaXMgbm90IHNldAojIENPTkZJR19QSEFOVE9NIGlzIG5vdCBz
ZXQKIyBDT05GSUdfVElGTV9DT1JFIGlzIG5vdCBzZXQKIyBDT05GSUdfSUNTOTMyUzQwMSBpcyBu
b3Qgc2V0CiMgQ09ORklHX0VOQ0xPU1VSRV9TRVJWSUNFUyBpcyBub3Qgc2V0CiMgQ09ORklHX0hQ
X0lMTyBpcyBub3Qgc2V0CiMgQ09ORklHX0FQRFM5ODAyQUxTIGlzIG5vdCBzZXQKIyBDT05GSUdf
SVNMMjkwMDMgaXMgbm90IHNldAojIENPTkZJR19JU0wyOTAyMCBpcyBub3Qgc2V0CiMgQ09ORklH
X1NFTlNPUlNfVFNMMjU1MCBpcyBub3Qgc2V0CiMgQ09ORklHX1NFTlNPUlNfQkgxNzcwIGlzIG5v
dCBzZXQKIyBDT05GSUdfU0VOU09SU19BUERTOTkwWCBpcyBub3Qgc2V0CiMgQ09ORklHX0hNQzYz
NTIgaXMgbm90IHNldAojIENPTkZJR19EUzE2ODIgaXMgbm90IHNldAojIENPTkZJR19TUkFNIGlz
IG5vdCBzZXQKIyBDT05GSUdfRFdfWERBVEFfUENJRSBpcyBub3Qgc2V0CiMgQ09ORklHX1BDSV9F
TkRQT0lOVF9URVNUIGlzIG5vdCBzZXQKIyBDT05GSUdfWElMSU5YX1NERkVDIGlzIG5vdCBzZXQK
IyBDT05GSUdfSElTSV9ISUtFWV9VU0IgaXMgbm90IHNldAojIENPTkZJR19PUEVOX0RJQ0UgaXMg
bm90IHNldAojIENPTkZJR19WQ1BVX1NUQUxMX0RFVEVDVE9SIGlzIG5vdCBzZXQKIyBDT05GSUdf
QzJQT1JUIGlzIG5vdCBzZXQKCiMKIyBFRVBST00gc3VwcG9ydAojCiMgQ09ORklHX0VFUFJPTV9B
VDI0IGlzIG5vdCBzZXQKIyBDT05GSUdfRUVQUk9NX0xFR0FDWSBpcyBub3Qgc2V0CiMgQ09ORklH
X0VFUFJPTV9NQVg2ODc1IGlzIG5vdCBzZXQKQ09ORklHX0VFUFJPTV85M0NYNj1tCiMgQ09ORklH
X0VFUFJPTV9JRFRfODlIUEVTWCBpcyBub3Qgc2V0CiMgQ09ORklHX0VFUFJPTV9FRTEwMDQgaXMg
bm90IHNldAojIGVuZCBvZiBFRVBST00gc3VwcG9ydAoKIyBDT05GSUdfQ0I3MTBfQ09SRSBpcyBu
b3Qgc2V0CgojCiMgVGV4YXMgSW5zdHJ1bWVudHMgc2hhcmVkIHRyYW5zcG9ydCBsaW5lIGRpc2Np
cGxpbmUKIwojIENPTkZJR19USV9TVCBpcyBub3Qgc2V0CiMgZW5kIG9mIFRleGFzIEluc3RydW1l
bnRzIHNoYXJlZCB0cmFuc3BvcnQgbGluZSBkaXNjaXBsaW5lCgojIENPTkZJR19TRU5TT1JTX0xJ
UzNfSTJDIGlzIG5vdCBzZXQKIyBDT05GSUdfQUxURVJBX1NUQVBMIGlzIG5vdCBzZXQKIyBDT05G
SUdfRUNITyBpcyBub3Qgc2V0CiMgQ09ORklHX0JDTV9WSyBpcyBub3Qgc2V0CiMgQ09ORklHX01J
U0NfQUxDT1JfUENJIGlzIG5vdCBzZXQKIyBDT05GSUdfTUlTQ19SVFNYX1BDSSBpcyBub3Qgc2V0
CiMgQ09ORklHX01JU0NfUlRTWF9VU0IgaXMgbm90IHNldAojIENPTkZJR19IQUJBTkFfQUkgaXMg
bm90IHNldAojIENPTkZJR19QVlBBTklDIGlzIG5vdCBzZXQKIyBlbmQgb2YgTWlzYyBkZXZpY2Vz
CgojCiMgU0NTSSBkZXZpY2Ugc3VwcG9ydAojCkNPTkZJR19TQ1NJX01PRD15CiMgQ09ORklHX1JB
SURfQVRUUlMgaXMgbm90IHNldApDT05GSUdfU0NTSV9DT01NT049eQpDT05GSUdfU0NTST15CkNP
TkZJR19TQ1NJX0RNQT15CiMgQ09ORklHX1NDU0lfUFJPQ19GUyBpcyBub3Qgc2V0CgojCiMgU0NT
SSBzdXBwb3J0IHR5cGUgKGRpc2ssIHRhcGUsIENELVJPTSkKIwpDT05GSUdfQkxLX0RFVl9TRD15
CiMgQ09ORklHX0NIUl9ERVZfU1QgaXMgbm90IHNldApDT05GSUdfQkxLX0RFVl9TUj1tCkNPTkZJ
R19DSFJfREVWX1NHPW0KQ09ORklHX0JMS19ERVZfQlNHPXkKIyBDT05GSUdfQ0hSX0RFVl9TQ0gg
aXMgbm90IHNldAojIENPTkZJR19TQ1NJX0NPTlNUQU5UUyBpcyBub3Qgc2V0CiMgQ09ORklHX1ND
U0lfTE9HR0lORyBpcyBub3Qgc2V0CkNPTkZJR19TQ1NJX1NDQU5fQVNZTkM9eQoKIwojIFNDU0kg
VHJhbnNwb3J0cwojCiMgQ09ORklHX1NDU0lfU1BJX0FUVFJTIGlzIG5vdCBzZXQKIyBDT05GSUdf
U0NTSV9GQ19BVFRSUyBpcyBub3Qgc2V0CiMgQ09ORklHX1NDU0lfSVNDU0lfQVRUUlMgaXMgbm90
IHNldAojIENPTkZJR19TQ1NJX1NBU19BVFRSUyBpcyBub3Qgc2V0CiMgQ09ORklHX1NDU0lfU0FT
X0xJQlNBUyBpcyBub3Qgc2V0CiMgQ09ORklHX1NDU0lfU1JQX0FUVFJTIGlzIG5vdCBzZXQKIyBl
bmQgb2YgU0NTSSBUcmFuc3BvcnRzCgojIENPTkZJR19TQ1NJX0xPV0xFVkVMIGlzIG5vdCBzZXQK
IyBDT05GSUdfU0NTSV9ESCBpcyBub3Qgc2V0CiMgZW5kIG9mIFNDU0kgZGV2aWNlIHN1cHBvcnQK
CkNPTkZJR19BVEE9eQpDT05GSUdfU0FUQV9IT1NUPXkKQ09ORklHX0FUQV9WRVJCT1NFX0VSUk9S
PXkKIyBDT05GSUdfQVRBX0ZPUkNFIGlzIG5vdCBzZXQKIyBDT05GSUdfU0FUQV9QTVAgaXMgbm90
IHNldAoKIwojIENvbnRyb2xsZXJzIHdpdGggbm9uLVNGRiBuYXRpdmUgaW50ZXJmYWNlCiMKIyBD
T05GSUdfU0FUQV9BSENJIGlzIG5vdCBzZXQKIyBDT05GSUdfU0FUQV9BSENJX1BMQVRGT1JNIGlz
IG5vdCBzZXQKIyBDT05GSUdfQUhDSV9DRVZBIGlzIG5vdCBzZXQKIyBDT05GSUdfQUhDSV9RT1JJ
USBpcyBub3Qgc2V0CiMgQ09ORklHX1NBVEFfSU5JQzE2MlggaXMgbm90IHNldAojIENPTkZJR19T
QVRBX0FDQVJEX0FIQ0kgaXMgbm90IHNldAojIENPTkZJR19TQVRBX1NJTDI0IGlzIG5vdCBzZXQK
Q09ORklHX0FUQV9TRkY9eQoKIwojIFNGRiBjb250cm9sbGVycyB3aXRoIGN1c3RvbSBETUEgaW50
ZXJmYWNlCiMKIyBDT05GSUdfUERDX0FETUEgaXMgbm90IHNldAojIENPTkZJR19TQVRBX1FTVE9S
IGlzIG5vdCBzZXQKIyBDT05GSUdfU0FUQV9TWDQgaXMgbm90IHNldApDT05GSUdfQVRBX0JNRE1B
PXkKCiMKIyBTQVRBIFNGRiBjb250cm9sbGVycyB3aXRoIEJNRE1BCiMKIyBDT05GSUdfQVRBX1BJ
SVggaXMgbm90IHNldAojIENPTkZJR19TQVRBX01WIGlzIG5vdCBzZXQKIyBDT05GSUdfU0FUQV9O
ViBpcyBub3Qgc2V0CiMgQ09ORklHX1NBVEFfUFJPTUlTRSBpcyBub3Qgc2V0CkNPTkZJR19TQVRB
X1NJTD15CiMgQ09ORklHX1NBVEFfU0lTIGlzIG5vdCBzZXQKIyBDT05GSUdfU0FUQV9TVlcgaXMg
bm90IHNldAojIENPTkZJR19TQVRBX1VMSSBpcyBub3Qgc2V0CiMgQ09ORklHX1NBVEFfVklBIGlz
IG5vdCBzZXQKIyBDT05GSUdfU0FUQV9WSVRFU1NFIGlzIG5vdCBzZXQKCiMKIyBQQVRBIFNGRiBj
b250cm9sbGVycyB3aXRoIEJNRE1BCiMKIyBDT05GSUdfUEFUQV9BTEkgaXMgbm90IHNldAojIENP
TkZJR19QQVRBX0FNRCBpcyBub3Qgc2V0CiMgQ09ORklHX1BBVEFfQVJUT1AgaXMgbm90IHNldAoj
IENPTkZJR19QQVRBX0FUSUlYUCBpcyBub3Qgc2V0CiMgQ09ORklHX1BBVEFfQVRQODY3WCBpcyBu
b3Qgc2V0CiMgQ09ORklHX1BBVEFfQ01ENjRYIGlzIG5vdCBzZXQKIyBDT05GSUdfUEFUQV9DWVBS
RVNTIGlzIG5vdCBzZXQKIyBDT05GSUdfUEFUQV9FRkFSIGlzIG5vdCBzZXQKIyBDT05GSUdfUEFU
QV9IUFQzNjYgaXMgbm90IHNldAojIENPTkZJR19QQVRBX0hQVDM3WCBpcyBub3Qgc2V0CiMgQ09O
RklHX1BBVEFfSFBUM1gyTiBpcyBub3Qgc2V0CiMgQ09ORklHX1BBVEFfSFBUM1gzIGlzIG5vdCBz
ZXQKIyBDT05GSUdfUEFUQV9JVDgyMTMgaXMgbm90IHNldAojIENPTkZJR19QQVRBX0lUODIxWCBp
cyBub3Qgc2V0CiMgQ09ORklHX1BBVEFfSk1JQ1JPTiBpcyBub3Qgc2V0CkNPTkZJR19QQVRBX01B
Q0lPPXkKIyBDT05GSUdfUEFUQV9NQVJWRUxMIGlzIG5vdCBzZXQKIyBDT05GSUdfUEFUQV9ORVRD
RUxMIGlzIG5vdCBzZXQKIyBDT05GSUdfUEFUQV9OSU5KQTMyIGlzIG5vdCBzZXQKIyBDT05GSUdf
UEFUQV9OUzg3NDE1IGlzIG5vdCBzZXQKIyBDT05GSUdfUEFUQV9PTERQSUlYIGlzIG5vdCBzZXQK
IyBDT05GSUdfUEFUQV9PUFRJRE1BIGlzIG5vdCBzZXQKIyBDT05GSUdfUEFUQV9QREMyMDI3WCBp
cyBub3Qgc2V0CiMgQ09ORklHX1BBVEFfUERDX09MRCBpcyBub3Qgc2V0CiMgQ09ORklHX1BBVEFf
UkFESVNZUyBpcyBub3Qgc2V0CiMgQ09ORklHX1BBVEFfUkRDIGlzIG5vdCBzZXQKIyBDT05GSUdf
UEFUQV9TQ0ggaXMgbm90IHNldAojIENPTkZJR19QQVRBX1NFUlZFUldPUktTIGlzIG5vdCBzZXQK
IyBDT05GSUdfUEFUQV9TSUw2ODAgaXMgbm90IHNldAojIENPTkZJR19QQVRBX1NJUyBpcyBub3Qg
c2V0CiMgQ09ORklHX1BBVEFfVE9TSElCQSBpcyBub3Qgc2V0CiMgQ09ORklHX1BBVEFfVFJJRkxF
WCBpcyBub3Qgc2V0CiMgQ09ORklHX1BBVEFfVklBIGlzIG5vdCBzZXQKIyBDT05GSUdfUEFUQV9X
SU5CT05EIGlzIG5vdCBzZXQKCiMKIyBQSU8tb25seSBTRkYgY29udHJvbGxlcnMKIwojIENPTkZJ
R19QQVRBX0NNRDY0MF9QQ0kgaXMgbm90IHNldAojIENPTkZJR19QQVRBX01QSUlYIGlzIG5vdCBz
ZXQKIyBDT05GSUdfUEFUQV9OUzg3NDEwIGlzIG5vdCBzZXQKIyBDT05GSUdfUEFUQV9PUFRJIGlz
IG5vdCBzZXQKIyBDT05GSUdfUEFUQV9QQ01DSUEgaXMgbm90IHNldAojIENPTkZJR19QQVRBX1BM
QVRGT1JNIGlzIG5vdCBzZXQKIyBDT05GSUdfUEFUQV9SWjEwMDAgaXMgbm90IHNldAoKIwojIEdl
bmVyaWMgZmFsbGJhY2sgLyBsZWdhY3kgZHJpdmVycwojCiMgQ09ORklHX0FUQV9HRU5FUklDIGlz
IG5vdCBzZXQKIyBDT05GSUdfUEFUQV9MRUdBQ1kgaXMgbm90IHNldApDT05GSUdfTUQ9eQojIENP
TkZJR19CTEtfREVWX01EIGlzIG5vdCBzZXQKIyBDT05GSUdfQkNBQ0hFIGlzIG5vdCBzZXQKQ09O
RklHX0JMS19ERVZfRE1fQlVJTFRJTj15CkNPTkZJR19CTEtfREVWX0RNPW0KIyBDT05GSUdfRE1f
REVCVUcgaXMgbm90IHNldApDT05GSUdfRE1fQlVGSU89bQpDT05GSUdfRE1fREVCVUdfQkxPQ0tf
TUFOQUdFUl9MT0NLSU5HPXkKIyBDT05GSUdfRE1fREVCVUdfQkxPQ0tfU1RBQ0tfVFJBQ0lORyBp
cyBub3Qgc2V0CkNPTkZJR19ETV9CSU9fUFJJU09OPW0KQ09ORklHX0RNX1BFUlNJU1RFTlRfREFU
QT1tCiMgQ09ORklHX0RNX1VOU1RSSVBFRCBpcyBub3Qgc2V0CkNPTkZJR19ETV9DUllQVD1tCiMg
Q09ORklHX0RNX1NOQVBTSE9UIGlzIG5vdCBzZXQKQ09ORklHX0RNX1RISU5fUFJPVklTSU9OSU5H
PW0KIyBDT05GSUdfRE1fQ0FDSEUgaXMgbm90IHNldAojIENPTkZJR19ETV9XUklURUNBQ0hFIGlz
IG5vdCBzZXQKIyBDT05GSUdfRE1fRVJBIGlzIG5vdCBzZXQKIyBDT05GSUdfRE1fQ0xPTkUgaXMg
bm90IHNldAojIENPTkZJR19ETV9NSVJST1IgaXMgbm90IHNldAojIENPTkZJR19ETV9SQUlEIGlz
IG5vdCBzZXQKIyBDT05GSUdfRE1fWkVSTyBpcyBub3Qgc2V0CiMgQ09ORklHX0RNX01VTFRJUEFU
SCBpcyBub3Qgc2V0CiMgQ09ORklHX0RNX0RFTEFZIGlzIG5vdCBzZXQKIyBDT05GSUdfRE1fRFVT
VCBpcyBub3Qgc2V0CkNPTkZJR19ETV9VRVZFTlQ9eQojIENPTkZJR19ETV9GTEFLRVkgaXMgbm90
IHNldAojIENPTkZJR19ETV9WRVJJVFkgaXMgbm90IHNldAojIENPTkZJR19ETV9TV0lUQ0ggaXMg
bm90IHNldAojIENPTkZJR19ETV9MT0dfV1JJVEVTIGlzIG5vdCBzZXQKIyBDT05GSUdfRE1fSU5U
RUdSSVRZIGlzIG5vdCBzZXQKIyBDT05GSUdfVEFSR0VUX0NPUkUgaXMgbm90IHNldAojIENPTkZJ
R19GVVNJT04gaXMgbm90IHNldAoKIwojIElFRUUgMTM5NCAoRmlyZVdpcmUpIHN1cHBvcnQKIwpD
T05GSUdfRklSRVdJUkU9bQpDT05GSUdfRklSRVdJUkVfT0hDST1tCkNPTkZJR19GSVJFV0lSRV9T
QlAyPW0KQ09ORklHX0ZJUkVXSVJFX05FVD1tCiMgQ09ORklHX0ZJUkVXSVJFX05PU1kgaXMgbm90
IHNldAojIGVuZCBvZiBJRUVFIDEzOTQgKEZpcmVXaXJlKSBzdXBwb3J0CgpDT05GSUdfTUFDSU5U
T1NIX0RSSVZFUlM9eQpDT05GSUdfQURCPXkKIyBDT05GSUdfQURCX0NVREEgaXMgbm90IHNldApD
T05GSUdfQURCX1BNVT15CkNPTkZJR19BREJfUE1VX0VWRU5UPXkKQ09ORklHX0FEQl9QTVVfTEVE
PXkKIyBDT05GSUdfQURCX1BNVV9MRURfRElTSyBpcyBub3Qgc2V0CkNPTkZJR19QTUFDX0FQTV9F
TVU9bQojIENPTkZJR19QTUFDX01FRElBQkFZIGlzIG5vdCBzZXQKQ09ORklHX1BNQUNfQkFDS0xJ
R0hUPXkKIyBDT05GSUdfUE1BQ19CQUNLTElHSFRfTEVHQUNZIGlzIG5vdCBzZXQKQ09ORklHX0lO
UFVUX0FEQkhJRD15CkNPTkZJR19NQUNfRU1VTU9VU0VCVE49bQpDT05GSUdfVEhFUk1fV0lORFRV
Tk5FTD1tCkNPTkZJR19USEVSTV9BRFQ3NDZYPW0KQ09ORklHX1dJTkRGQVJNPW0KIyBDT05GSUdf
UE1BQ19SQUNLTUVURVIgaXMgbm90IHNldApDT05GSUdfU0VOU09SU19BTVM9bQpDT05GSUdfU0VO
U09SU19BTVNfUE1VPXkKQ09ORklHX1NFTlNPUlNfQU1TX0kyQz15CkNPTkZJR19ORVRERVZJQ0VT
PXkKQ09ORklHX05FVF9DT1JFPXkKIyBDT05GSUdfQk9ORElORyBpcyBub3Qgc2V0CiMgQ09ORklH
X0RVTU1ZIGlzIG5vdCBzZXQKQ09ORklHX1dJUkVHVUFSRD1tCiMgQ09ORklHX1dJUkVHVUFSRF9E
RUJVRyBpcyBub3Qgc2V0CiMgQ09ORklHX0VRVUFMSVpFUiBpcyBub3Qgc2V0CiMgQ09ORklHX05F
VF9GQyBpcyBub3Qgc2V0CiMgQ09ORklHX05FVF9URUFNIGlzIG5vdCBzZXQKIyBDT05GSUdfTUFD
VkxBTiBpcyBub3Qgc2V0CiMgQ09ORklHX0lQVkxBTiBpcyBub3Qgc2V0CiMgQ09ORklHX1ZYTEFO
IGlzIG5vdCBzZXQKIyBDT05GSUdfR0VORVZFIGlzIG5vdCBzZXQKIyBDT05GSUdfQkFSRVVEUCBp
cyBub3Qgc2V0CiMgQ09ORklHX0dUUCBpcyBub3Qgc2V0CiMgQ09ORklHX01BQ1NFQyBpcyBub3Qg
c2V0CkNPTkZJR19ORVRDT05TT0xFPXkKQ09ORklHX05FVFBPTEw9eQpDT05GSUdfTkVUX1BPTExf
Q09OVFJPTExFUj15CiMgQ09ORklHX1RVTiBpcyBub3Qgc2V0CiMgQ09ORklHX1RVTl9WTkVUX0NS
T1NTX0xFIGlzIG5vdCBzZXQKIyBDT05GSUdfVkVUSCBpcyBub3Qgc2V0CiMgQ09ORklHX1ZJUlRJ
T19ORVQgaXMgbm90IHNldAojIENPTkZJR19OTE1PTiBpcyBub3Qgc2V0CkNPTkZJR19TVU5HRU1f
UEhZPXkKIyBDT05GSUdfQVJDTkVUIGlzIG5vdCBzZXQKQ09ORklHX0VUSEVSTkVUPXkKIyBDT05G
SUdfTkVUX1ZFTkRPUl8zQ09NIGlzIG5vdCBzZXQKIyBDT05GSUdfTkVUX1ZFTkRPUl9BREFQVEVD
IGlzIG5vdCBzZXQKIyBDT05GSUdfTkVUX1ZFTkRPUl9BR0VSRSBpcyBub3Qgc2V0CiMgQ09ORklH
X05FVF9WRU5ET1JfQUxBQ1JJVEVDSCBpcyBub3Qgc2V0CiMgQ09ORklHX05FVF9WRU5ET1JfQUxU
RU9OIGlzIG5vdCBzZXQKIyBDT05GSUdfQUxURVJBX1RTRSBpcyBub3Qgc2V0CiMgQ09ORklHX05F
VF9WRU5ET1JfQU1BWk9OIGlzIG5vdCBzZXQKIyBDT05GSUdfTkVUX1ZFTkRPUl9BTUQgaXMgbm90
IHNldAojIENPTkZJR19ORVRfVkVORE9SX0FQUExFIGlzIG5vdCBzZXQKIyBDT05GSUdfTkVUX1ZF
TkRPUl9BUVVBTlRJQSBpcyBub3Qgc2V0CiMgQ09ORklHX05FVF9WRU5ET1JfQVJDIGlzIG5vdCBz
ZXQKIyBDT05GSUdfTkVUX1ZFTkRPUl9BU0lYIGlzIG5vdCBzZXQKIyBDT05GSUdfTkVUX1ZFTkRP
Ul9BVEhFUk9TIGlzIG5vdCBzZXQKIyBDT05GSUdfTkVUX1ZFTkRPUl9CUk9BRENPTSBpcyBub3Qg
c2V0CiMgQ09ORklHX05FVF9WRU5ET1JfQ0FERU5DRSBpcyBub3Qgc2V0CiMgQ09ORklHX05FVF9W
RU5ET1JfQ0FWSVVNIGlzIG5vdCBzZXQKIyBDT05GSUdfTkVUX1ZFTkRPUl9DSEVMU0lPIGlzIG5v
dCBzZXQKIyBDT05GSUdfTkVUX1ZFTkRPUl9DSVNDTyBpcyBub3Qgc2V0CiMgQ09ORklHX05FVF9W
RU5ET1JfQ09SVElOQSBpcyBub3Qgc2V0CiMgQ09ORklHX05FVF9WRU5ET1JfREFWSUNPTSBpcyBu
b3Qgc2V0CiMgQ09ORklHX0RORVQgaXMgbm90IHNldAojIENPTkZJR19ORVRfVkVORE9SX0RFQyBp
cyBub3Qgc2V0CiMgQ09ORklHX05FVF9WRU5ET1JfRExJTksgaXMgbm90IHNldAojIENPTkZJR19O
RVRfVkVORE9SX0VNVUxFWCBpcyBub3Qgc2V0CiMgQ09ORklHX05FVF9WRU5ET1JfRU5HTEVERVIg
aXMgbm90IHNldAojIENPTkZJR19ORVRfVkVORE9SX0VaQ0hJUCBpcyBub3Qgc2V0CiMgQ09ORklH
X05FVF9WRU5ET1JfRlVKSVRTVSBpcyBub3Qgc2V0CiMgQ09ORklHX05FVF9WRU5ET1JfRlVOR0lC
TEUgaXMgbm90IHNldAojIENPTkZJR19ORVRfVkVORE9SX0dPT0dMRSBpcyBub3Qgc2V0CiMgQ09O
RklHX05FVF9WRU5ET1JfSFVBV0VJIGlzIG5vdCBzZXQKIyBDT05GSUdfTkVUX1ZFTkRPUl9JTlRF
TCBpcyBub3Qgc2V0CiMgQ09ORklHX05FVF9WRU5ET1JfV0FOR1hVTiBpcyBub3Qgc2V0CiMgQ09O
RklHX0pNRSBpcyBub3Qgc2V0CiMgQ09ORklHX05FVF9WRU5ET1JfTElURVggaXMgbm90IHNldAoj
IENPTkZJR19ORVRfVkVORE9SX01BUlZFTEwgaXMgbm90IHNldAojIENPTkZJR19ORVRfVkVORE9S
X01FTExBTk9YIGlzIG5vdCBzZXQKIyBDT05GSUdfTkVUX1ZFTkRPUl9NSUNSRUwgaXMgbm90IHNl
dAojIENPTkZJR19ORVRfVkVORE9SX01JQ1JPQ0hJUCBpcyBub3Qgc2V0CiMgQ09ORklHX05FVF9W
RU5ET1JfTUlDUk9TRU1JIGlzIG5vdCBzZXQKIyBDT05GSUdfTkVUX1ZFTkRPUl9NSUNST1NPRlQg
aXMgbm90IHNldAojIENPTkZJR19ORVRfVkVORE9SX01ZUkkgaXMgbm90IHNldAojIENPTkZJR19G
RUFMTlggaXMgbm90IHNldAojIENPTkZJR19ORVRfVkVORE9SX05JIGlzIG5vdCBzZXQKIyBDT05G
SUdfTkVUX1ZFTkRPUl9OQVRTRU1JIGlzIG5vdCBzZXQKIyBDT05GSUdfTkVUX1ZFTkRPUl9ORVRF
UklPTiBpcyBub3Qgc2V0CiMgQ09ORklHX05FVF9WRU5ET1JfTkVUUk9OT01FIGlzIG5vdCBzZXQK
IyBDT05GSUdfTkVUX1ZFTkRPUl9OVklESUEgaXMgbm90IHNldAojIENPTkZJR19ORVRfVkVORE9S
X09LSSBpcyBub3Qgc2V0CiMgQ09ORklHX0VUSE9DIGlzIG5vdCBzZXQKIyBDT05GSUdfTkVUX1ZF
TkRPUl9QQUNLRVRfRU5HSU5FUyBpcyBub3Qgc2V0CiMgQ09ORklHX05FVF9WRU5ET1JfUEVOU0FO
RE8gaXMgbm90IHNldAojIENPTkZJR19ORVRfVkVORE9SX1FMT0dJQyBpcyBub3Qgc2V0CiMgQ09O
RklHX05FVF9WRU5ET1JfQlJPQ0FERSBpcyBub3Qgc2V0CiMgQ09ORklHX05FVF9WRU5ET1JfUVVB
TENPTU0gaXMgbm90IHNldAojIENPTkZJR19ORVRfVkVORE9SX1JEQyBpcyBub3Qgc2V0CiMgQ09O
RklHX05FVF9WRU5ET1JfUkVBTFRFSyBpcyBub3Qgc2V0CiMgQ09ORklHX05FVF9WRU5ET1JfUkVO
RVNBUyBpcyBub3Qgc2V0CiMgQ09ORklHX05FVF9WRU5ET1JfUk9DS0VSIGlzIG5vdCBzZXQKIyBD
T05GSUdfTkVUX1ZFTkRPUl9TQU1TVU5HIGlzIG5vdCBzZXQKIyBDT05GSUdfTkVUX1ZFTkRPUl9T
RUVRIGlzIG5vdCBzZXQKIyBDT05GSUdfTkVUX1ZFTkRPUl9TSUxBTiBpcyBub3Qgc2V0CiMgQ09O
RklHX05FVF9WRU5ET1JfU0lTIGlzIG5vdCBzZXQKIyBDT05GSUdfTkVUX1ZFTkRPUl9TT0xBUkZM
QVJFIGlzIG5vdCBzZXQKIyBDT05GSUdfTkVUX1ZFTkRPUl9TTVNDIGlzIG5vdCBzZXQKIyBDT05G
SUdfTkVUX1ZFTkRPUl9TT0NJT05FWFQgaXMgbm90IHNldAojIENPTkZJR19ORVRfVkVORE9SX1NU
TUlDUk8gaXMgbm90IHNldApDT05GSUdfTkVUX1ZFTkRPUl9TVU49eQojIENPTkZJR19IQVBQWU1F
QUwgaXMgbm90IHNldApDT05GSUdfU1VOR0VNPXkKIyBDT05GSUdfQ0FTU0lOSSBpcyBub3Qgc2V0
CiMgQ09ORklHX05JVSBpcyBub3Qgc2V0CiMgQ09ORklHX05FVF9WRU5ET1JfU1lOT1BTWVMgaXMg
bm90IHNldAojIENPTkZJR19ORVRfVkVORE9SX1RFSFVUSSBpcyBub3Qgc2V0CiMgQ09ORklHX05F
VF9WRU5ET1JfVEkgaXMgbm90IHNldAojIENPTkZJR19ORVRfVkVORE9SX1ZFUlRFWENPTSBpcyBu
b3Qgc2V0CiMgQ09ORklHX05FVF9WRU5ET1JfVklBIGlzIG5vdCBzZXQKIyBDT05GSUdfTkVUX1ZF
TkRPUl9XSVpORVQgaXMgbm90IHNldAojIENPTkZJR19ORVRfVkVORE9SX1hJTElOWCBpcyBub3Qg
c2V0CiMgQ09ORklHX05FVF9WRU5ET1JfWElSQ09NIGlzIG5vdCBzZXQKIyBDT05GSUdfRkRESSBp
cyBub3Qgc2V0CiMgQ09ORklHX0hJUFBJIGlzIG5vdCBzZXQKIyBDT05GSUdfUEhZTElCIGlzIG5v
dCBzZXQKIyBDT05GSUdfTURJT19ERVZJQ0UgaXMgbm90IHNldAoKIwojIFBDUyBkZXZpY2UgZHJp
dmVycwojCiMgZW5kIG9mIFBDUyBkZXZpY2UgZHJpdmVycwoKQ09ORklHX1BQUD1tCkNPTkZJR19Q
UFBfQlNEQ09NUD1tCkNPTkZJR19QUFBfREVGTEFURT1tCkNPTkZJR19QUFBfRklMVEVSPXkKQ09O
RklHX1BQUF9NUFBFPW0KQ09ORklHX1BQUF9NVUxUSUxJTks9eQpDT05GSUdfUFBQT0U9bQpDT05G
SUdfUFBQX0FTWU5DPW0KQ09ORklHX1BQUF9TWU5DX1RUWT1tCiMgQ09ORklHX1NMSVAgaXMgbm90
IHNldApDT05GSUdfU0xIQz1tCgojCiMgSG9zdC1zaWRlIFVTQiBzdXBwb3J0IGlzIG5lZWRlZCBm
b3IgVVNCIE5ldHdvcmsgQWRhcHRlciBzdXBwb3J0CiMKIyBDT05GSUdfVVNCX05FVF9EUklWRVJT
IGlzIG5vdCBzZXQKQ09ORklHX1dMQU49eQojIENPTkZJR19XTEFOX1ZFTkRPUl9BRE1URUsgaXMg
bm90IHNldApDT05GSUdfQVRIX0NPTU1PTj1tCkNPTkZJR19XTEFOX1ZFTkRPUl9BVEg9eQpDT05G
SUdfQVRIX0RFQlVHPXkKQ09ORklHX0FUSDVLPW0KQ09ORklHX0FUSDVLX0RFQlVHPXkKQ09ORklH
X0FUSDVLX1BDST15CiMgQ09ORklHX0FUSDlLIGlzIG5vdCBzZXQKIyBDT05GSUdfQVRIOUtfSFRD
IGlzIG5vdCBzZXQKIyBDT05GSUdfQ0FSTDkxNzAgaXMgbm90IHNldAojIENPTkZJR19BVEg2S0wg
aXMgbm90IHNldAojIENPTkZJR19BUjU1MjMgaXMgbm90IHNldAojIENPTkZJR19XSUw2MjEwIGlz
IG5vdCBzZXQKIyBDT05GSUdfQVRIMTBLIGlzIG5vdCBzZXQKIyBDT05GSUdfV0NOMzZYWCBpcyBu
b3Qgc2V0CiMgQ09ORklHX1dMQU5fVkVORE9SX0FUTUVMIGlzIG5vdCBzZXQKQ09ORklHX1dMQU5f
VkVORE9SX0JST0FEQ09NPXkKIyBDT05GSUdfQjQzIGlzIG5vdCBzZXQKQ09ORklHX0I0M0xFR0FD
WT1tCkNPTkZJR19CNDNMRUdBQ1lfUENJX0FVVE9TRUxFQ1Q9eQpDT05GSUdfQjQzTEVHQUNZX1BD
SUNPUkVfQVVUT1NFTEVDVD15CkNPTkZJR19CNDNMRUdBQ1lfTEVEUz15CkNPTkZJR19CNDNMRUdB
Q1lfREVCVUc9eQpDT05GSUdfQjQzTEVHQUNZX0RNQT15CkNPTkZJR19CNDNMRUdBQ1lfUElPPXkK
Q09ORklHX0I0M0xFR0FDWV9ETUFfQU5EX1BJT19NT0RFPXkKIyBDT05GSUdfQjQzTEVHQUNZX0RN
QV9NT0RFIGlzIG5vdCBzZXQKIyBDT05GSUdfQjQzTEVHQUNZX1BJT19NT0RFIGlzIG5vdCBzZXQK
IyBDT05GSUdfQlJDTVNNQUMgaXMgbm90IHNldAojIENPTkZJR19CUkNNRk1BQyBpcyBub3Qgc2V0
CiMgQ09ORklHX1dMQU5fVkVORE9SX0NJU0NPIGlzIG5vdCBzZXQKIyBDT05GSUdfV0xBTl9WRU5E
T1JfSU5URUwgaXMgbm90IHNldAojIENPTkZJR19XTEFOX1ZFTkRPUl9JTlRFUlNJTCBpcyBub3Qg
c2V0CiMgQ09ORklHX1dMQU5fVkVORE9SX01BUlZFTEwgaXMgbm90IHNldAojIENPTkZJR19XTEFO
X1ZFTkRPUl9NRURJQVRFSyBpcyBub3Qgc2V0CiMgQ09ORklHX1dMQU5fVkVORE9SX01JQ1JPQ0hJ
UCBpcyBub3Qgc2V0CiMgQ09ORklHX1dMQU5fVkVORE9SX1BVUkVMSUZJIGlzIG5vdCBzZXQKIyBD
T05GSUdfV0xBTl9WRU5ET1JfUkFMSU5LIGlzIG5vdCBzZXQKQ09ORklHX1dMQU5fVkVORE9SX1JF
QUxURUs9eQojIENPTkZJR19SVEw4MTgwIGlzIG5vdCBzZXQKIyBDT05GSUdfUlRMODE4NyBpcyBu
b3Qgc2V0CiMgQ09ORklHX1JUTF9DQVJEUyBpcyBub3Qgc2V0CkNPTkZJR19SVEw4WFhYVT1tCiMg
Q09ORklHX1JUTDhYWFhVX1VOVEVTVEVEIGlzIG5vdCBzZXQKIyBDT05GSUdfUlRXODggaXMgbm90
IHNldAojIENPTkZJR19SVFc4OSBpcyBub3Qgc2V0CiMgQ09ORklHX1dMQU5fVkVORE9SX1JTSSBp
cyBub3Qgc2V0CiMgQ09ORklHX1dMQU5fVkVORE9SX1NJTEFCUyBpcyBub3Qgc2V0CiMgQ09ORklH
X1dMQU5fVkVORE9SX1NUIGlzIG5vdCBzZXQKIyBDT05GSUdfV0xBTl9WRU5ET1JfVEkgaXMgbm90
IHNldAojIENPTkZJR19XTEFOX1ZFTkRPUl9aWURBUyBpcyBub3Qgc2V0CiMgQ09ORklHX1dMQU5f
VkVORE9SX1FVQU5URU5OQSBpcyBub3Qgc2V0CiMgQ09ORklHX1BDTUNJQV9SQVlDUyBpcyBub3Qg
c2V0CiMgQ09ORklHX1BDTUNJQV9XTDM1MDEgaXMgbm90IHNldAojIENPTkZJR19NQUM4MDIxMV9I
V1NJTSBpcyBub3Qgc2V0CiMgQ09ORklHX1VTQl9ORVRfUk5ESVNfV0xBTiBpcyBub3Qgc2V0CiMg
Q09ORklHX1ZJUlRfV0lGSSBpcyBub3Qgc2V0CiMgQ09ORklHX1dBTiBpcyBub3Qgc2V0CgojCiMg
V2lyZWxlc3MgV0FOCiMKIyBDT05GSUdfV1dBTiBpcyBub3Qgc2V0CiMgZW5kIG9mIFdpcmVsZXNz
IFdBTgoKIyBDT05GSUdfVk1YTkVUMyBpcyBub3Qgc2V0CiMgQ09ORklHX05FVF9GQUlMT1ZFUiBp
cyBub3Qgc2V0CiMgQ09ORklHX0lTRE4gaXMgbm90IHNldAoKIwojIElucHV0IGRldmljZSBzdXBw
b3J0CiMKQ09ORklHX0lOUFVUPXkKQ09ORklHX0lOUFVUX0xFRFM9eQpDT05GSUdfSU5QVVRfRkZf
TUVNTEVTUz1tCiMgQ09ORklHX0lOUFVUX1NQQVJTRUtNQVAgaXMgbm90IHNldAojIENPTkZJR19J
TlBVVF9NQVRSSVhLTUFQIGlzIG5vdCBzZXQKCiMKIyBVc2VybGFuZCBpbnRlcmZhY2VzCiMKIyBD
T05GSUdfSU5QVVRfTU9VU0VERVYgaXMgbm90IHNldApDT05GSUdfSU5QVVRfSk9ZREVWPW0KQ09O
RklHX0lOUFVUX0VWREVWPW0KIyBDT05GSUdfSU5QVVRfRVZCVUcgaXMgbm90IHNldAojIENPTkZJ
R19JTlBVVF9BUE1QT1dFUiBpcyBub3Qgc2V0CgojCiMgSW5wdXQgRGV2aWNlIERyaXZlcnMKIwoj
IENPTkZJR19JTlBVVF9LRVlCT0FSRCBpcyBub3Qgc2V0CkNPTkZJR19JTlBVVF9NT1VTRT15CiMg
Q09ORklHX01PVVNFX1BTMiBpcyBub3Qgc2V0CiMgQ09ORklHX01PVVNFX1NFUklBTCBpcyBub3Qg
c2V0CkNPTkZJR19NT1VTRV9BUFBMRVRPVUNIPW0KIyBDT05GSUdfTU9VU0VfQkNNNTk3NCBpcyBu
b3Qgc2V0CiMgQ09ORklHX01PVVNFX0NZQVBBIGlzIG5vdCBzZXQKIyBDT05GSUdfTU9VU0VfRUxB
Tl9JMkMgaXMgbm90IHNldAojIENPTkZJR19NT1VTRV9WU1hYWEFBIGlzIG5vdCBzZXQKIyBDT05G
SUdfTU9VU0VfR1BJTyBpcyBub3Qgc2V0CiMgQ09ORklHX01PVVNFX1NZTkFQVElDU19JMkMgaXMg
bm90IHNldAojIENPTkZJR19NT1VTRV9TWU5BUFRJQ1NfVVNCIGlzIG5vdCBzZXQKQ09ORklHX0lO
UFVUX0pPWVNUSUNLPXkKIyBDT05GSUdfSk9ZU1RJQ0tfQU5BTE9HIGlzIG5vdCBzZXQKIyBDT05G
SUdfSk9ZU1RJQ0tfQTNEIGlzIG5vdCBzZXQKIyBDT05GSUdfSk9ZU1RJQ0tfQURJIGlzIG5vdCBz
ZXQKIyBDT05GSUdfSk9ZU1RJQ0tfQ09CUkEgaXMgbm90IHNldAojIENPTkZJR19KT1lTVElDS19H
RjJLIGlzIG5vdCBzZXQKIyBDT05GSUdfSk9ZU1RJQ0tfR1JJUCBpcyBub3Qgc2V0CiMgQ09ORklH
X0pPWVNUSUNLX0dSSVBfTVAgaXMgbm90IHNldAojIENPTkZJR19KT1lTVElDS19HVUlMTEVNT1Qg
aXMgbm90IHNldAojIENPTkZJR19KT1lTVElDS19JTlRFUkFDVCBpcyBub3Qgc2V0CiMgQ09ORklH
X0pPWVNUSUNLX1NJREVXSU5ERVIgaXMgbm90IHNldAojIENPTkZJR19KT1lTVElDS19UTURDIGlz
IG5vdCBzZXQKIyBDT05GSUdfSk9ZU1RJQ0tfSUZPUkNFIGlzIG5vdCBzZXQKIyBDT05GSUdfSk9Z
U1RJQ0tfV0FSUklPUiBpcyBub3Qgc2V0CiMgQ09ORklHX0pPWVNUSUNLX01BR0VMTEFOIGlzIG5v
dCBzZXQKIyBDT05GSUdfSk9ZU1RJQ0tfU1BBQ0VPUkIgaXMgbm90IHNldAojIENPTkZJR19KT1lT
VElDS19TUEFDRUJBTEwgaXMgbm90IHNldAojIENPTkZJR19KT1lTVElDS19TVElOR0VSIGlzIG5v
dCBzZXQKIyBDT05GSUdfSk9ZU1RJQ0tfVFdJREpPWSBpcyBub3Qgc2V0CiMgQ09ORklHX0pPWVNU
SUNLX1pIRU5IVUEgaXMgbm90IHNldAojIENPTkZJR19KT1lTVElDS19BUzUwMTEgaXMgbm90IHNl
dAojIENPTkZJR19KT1lTVElDS19KT1lEVU1QIGlzIG5vdCBzZXQKQ09ORklHX0pPWVNUSUNLX1hQ
QUQ9bQojIENPTkZJR19KT1lTVElDS19YUEFEX0ZGIGlzIG5vdCBzZXQKQ09ORklHX0pPWVNUSUNL
X1hQQURfTEVEUz15CiMgQ09ORklHX0pPWVNUSUNLX1BYUkMgaXMgbm90IHNldAojIENPTkZJR19K
T1lTVElDS19RV0lJQyBpcyBub3Qgc2V0CiMgQ09ORklHX0pPWVNUSUNLX0ZTSUE2QiBpcyBub3Qg
c2V0CiMgQ09ORklHX0pPWVNUSUNLX1NFTlNFSEFUIGlzIG5vdCBzZXQKIyBDT05GSUdfSU5QVVRf
VEFCTEVUIGlzIG5vdCBzZXQKIyBDT05GSUdfSU5QVVRfVE9VQ0hTQ1JFRU4gaXMgbm90IHNldApD
T05GSUdfSU5QVVRfTUlTQz15CiMgQ09ORklHX0lOUFVUX0FENzE0WCBpcyBub3Qgc2V0CiMgQ09O
RklHX0lOUFVUX0FUTUVMX0NBUFRPVUNIIGlzIG5vdCBzZXQKIyBDT05GSUdfSU5QVVRfQk1BMTUw
IGlzIG5vdCBzZXQKIyBDT05GSUdfSU5QVVRfRTNYMF9CVVRUT04gaXMgbm90IHNldAojIENPTkZJ
R19JTlBVVF9NTUE4NDUwIGlzIG5vdCBzZXQKIyBDT05GSUdfSU5QVVRfR1BJT19CRUVQRVIgaXMg
bm90IHNldAojIENPTkZJR19JTlBVVF9HUElPX0RFQ09ERVIgaXMgbm90IHNldAojIENPTkZJR19J
TlBVVF9HUElPX1ZJQlJBIGlzIG5vdCBzZXQKIyBDT05GSUdfSU5QVVRfQVRJX1JFTU9URTIgaXMg
bm90IHNldAojIENPTkZJR19JTlBVVF9LRVlTUEFOX1JFTU9URSBpcyBub3Qgc2V0CiMgQ09ORklH
X0lOUFVUX0tYVEo5IGlzIG5vdCBzZXQKIyBDT05GSUdfSU5QVVRfUE9XRVJNQVRFIGlzIG5vdCBz
ZXQKIyBDT05GSUdfSU5QVVRfWUVBTElOSyBpcyBub3Qgc2V0CiMgQ09ORklHX0lOUFVUX0NNMTA5
IGlzIG5vdCBzZXQKIyBDT05GSUdfSU5QVVRfUkVHVUxBVE9SX0hBUFRJQyBpcyBub3Qgc2V0CkNP
TkZJR19JTlBVVF9VSU5QVVQ9bQojIENPTkZJR19JTlBVVF9QQ0Y4NTc0IGlzIG5vdCBzZXQKIyBD
T05GSUdfSU5QVVRfR1BJT19ST1RBUllfRU5DT0RFUiBpcyBub3Qgc2V0CiMgQ09ORklHX0lOUFVU
X0RBNzI4MF9IQVBUSUNTIGlzIG5vdCBzZXQKIyBDT05GSUdfSU5QVVRfQURYTDM0WCBpcyBub3Qg
c2V0CiMgQ09ORklHX0lOUFVUX0lNU19QQ1UgaXMgbm90IHNldAojIENPTkZJR19JTlBVVF9JUVMy
NjlBIGlzIG5vdCBzZXQKIyBDT05GSUdfSU5QVVRfSVFTNjI2QSBpcyBub3Qgc2V0CiMgQ09ORklH
X0lOUFVUX0lRUzcyMjIgaXMgbm90IHNldAojIENPTkZJR19JTlBVVF9DTUEzMDAwIGlzIG5vdCBz
ZXQKIyBDT05GSUdfSU5QVVRfRFJWMjYwWF9IQVBUSUNTIGlzIG5vdCBzZXQKIyBDT05GSUdfSU5Q
VVRfRFJWMjY2NV9IQVBUSUNTIGlzIG5vdCBzZXQKIyBDT05GSUdfSU5QVVRfRFJWMjY2N19IQVBU
SUNTIGlzIG5vdCBzZXQKIyBDT05GSUdfUk1JNF9DT1JFIGlzIG5vdCBzZXQKCiMKIyBIYXJkd2Fy
ZSBJL08gcG9ydHMKIwpDT05GSUdfU0VSSU89bQpDT05GSUdfQVJDSF9NSUdIVF9IQVZFX1BDX1NF
UklPPXkKIyBDT05GSUdfU0VSSU9fSTgwNDIgaXMgbm90IHNldAojIENPTkZJR19TRVJJT19TRVJQ
T1JUIGlzIG5vdCBzZXQKIyBDT05GSUdfU0VSSU9fUENJUFMyIGlzIG5vdCBzZXQKIyBDT05GSUdf
U0VSSU9fTElCUFMyIGlzIG5vdCBzZXQKIyBDT05GSUdfU0VSSU9fUkFXIGlzIG5vdCBzZXQKIyBD
T05GSUdfU0VSSU9fWElMSU5YX1hQU19QUzIgaXMgbm90IHNldAojIENPTkZJR19TRVJJT19BTFRF
UkFfUFMyIGlzIG5vdCBzZXQKIyBDT05GSUdfU0VSSU9fUFMyTVVMVCBpcyBub3Qgc2V0CiMgQ09O
RklHX1NFUklPX0FSQ19QUzIgaXMgbm90IHNldAojIENPTkZJR19TRVJJT19BUEJQUzIgaXMgbm90
IHNldAojIENPTkZJR19TRVJJT19HUElPX1BTMiBpcyBub3Qgc2V0CiMgQ09ORklHX1VTRVJJTyBp
cyBub3Qgc2V0CiMgQ09ORklHX0dBTUVQT1JUIGlzIG5vdCBzZXQKIyBlbmQgb2YgSGFyZHdhcmUg
SS9PIHBvcnRzCiMgZW5kIG9mIElucHV0IGRldmljZSBzdXBwb3J0CgojCiMgQ2hhcmFjdGVyIGRl
dmljZXMKIwpDT05GSUdfVFRZPXkKQ09ORklHX1ZUPXkKQ09ORklHX0NPTlNPTEVfVFJBTlNMQVRJ
T05TPXkKQ09ORklHX1ZUX0NPTlNPTEU9eQpDT05GSUdfSFdfQ09OU09MRT15CkNPTkZJR19WVF9I
V19DT05TT0xFX0JJTkRJTkc9eQpDT05GSUdfVU5JWDk4X1BUWVM9eQojIENPTkZJR19MRUdBQ1lf
UFRZUyBpcyBub3Qgc2V0CiMgQ09ORklHX0xESVNDX0FVVE9MT0FEIGlzIG5vdCBzZXQKCiMKIyBT
ZXJpYWwgZHJpdmVycwojCkNPTkZJR19TRVJJQUxfODI1MD1tCiMgQ09ORklHX1NFUklBTF84MjUw
X0RFUFJFQ0FURURfT1BUSU9OUyBpcyBub3Qgc2V0CiMgQ09ORklHX1NFUklBTF84MjUwXzE2NTUw
QV9WQVJJQU5UUyBpcyBub3Qgc2V0CiMgQ09ORklHX1NFUklBTF84MjUwX0ZJTlRFSyBpcyBub3Qg
c2V0CkNPTkZJR19TRVJJQUxfODI1MF9QQ0k9bQojIENPTkZJR19TRVJJQUxfODI1MF9FWEFSIGlz
IG5vdCBzZXQKIyBDT05GSUdfU0VSSUFMXzgyNTBfQ1MgaXMgbm90IHNldApDT05GSUdfU0VSSUFM
XzgyNTBfTlJfVUFSVFM9MgpDT05GSUdfU0VSSUFMXzgyNTBfUlVOVElNRV9VQVJUUz0yCiMgQ09O
RklHX1NFUklBTF84MjUwX0VYVEVOREVEIGlzIG5vdCBzZXQKIyBDT05GSUdfU0VSSUFMXzgyNTBf
RFcgaXMgbm90IHNldAojIENPTkZJR19TRVJJQUxfODI1MF9SVDI4OFggaXMgbm90IHNldAojIENP
TkZJR19TRVJJQUxfODI1MF9QRVJJQ09NIGlzIG5vdCBzZXQKQ09ORklHX1NFUklBTF9PRl9QTEFU
Rk9STT1tCgojCiMgTm9uLTgyNTAgc2VyaWFsIHBvcnQgc3VwcG9ydAojCiMgQ09ORklHX1NFUklB
TF9VQVJUTElURSBpcyBub3Qgc2V0CkNPTkZJR19TRVJJQUxfQ09SRT15CkNPTkZJR19TRVJJQUxf
Q09SRV9DT05TT0xFPXkKQ09ORklHX1NFUklBTF9QTUFDWklMT0c9eQojIENPTkZJR19TRVJJQUxf
UE1BQ1pJTE9HX1RUWVMgaXMgbm90IHNldApDT05GSUdfU0VSSUFMX1BNQUNaSUxPR19DT05TT0xF
PXkKIyBDT05GSUdfU0VSSUFMX0pTTSBpcyBub3Qgc2V0CiMgQ09ORklHX1NFUklBTF9TSUZJVkUg
aXMgbm90IHNldAojIENPTkZJR19TRVJJQUxfU0NDTlhQIGlzIG5vdCBzZXQKIyBDT05GSUdfU0VS
SUFMX1NDMTZJUzdYWCBpcyBub3Qgc2V0CiMgQ09ORklHX1NFUklBTF9BTFRFUkFfSlRBR1VBUlQg
aXMgbm90IHNldAojIENPTkZJR19TRVJJQUxfQUxURVJBX1VBUlQgaXMgbm90IHNldAojIENPTkZJ
R19TRVJJQUxfWElMSU5YX1BTX1VBUlQgaXMgbm90IHNldAojIENPTkZJR19TRVJJQUxfQVJDIGlz
IG5vdCBzZXQKIyBDT05GSUdfU0VSSUFMX1JQMiBpcyBub3Qgc2V0CiMgQ09ORklHX1NFUklBTF9G
U0xfTFBVQVJUIGlzIG5vdCBzZXQKIyBDT05GSUdfU0VSSUFMX0ZTTF9MSU5GTEVYVUFSVCBpcyBu
b3Qgc2V0CiMgQ09ORklHX1NFUklBTF9DT05FWEFOVF9ESUdJQ09MT1IgaXMgbm90IHNldAojIGVu
ZCBvZiBTZXJpYWwgZHJpdmVycwoKQ09ORklHX1NFUklBTF9NQ1RSTF9HUElPPW0KIyBDT05GSUdf
U0VSSUFMX05PTlNUQU5EQVJEIGlzIG5vdCBzZXQKIyBDT05GSUdfUFBDX0VQQVBSX0hWX0JZVEVD
SEFOIGlzIG5vdCBzZXQKIyBDT05GSUdfTl9HU00gaXMgbm90IHNldAojIENPTkZJR19OT1pPTUkg
aXMgbm90IHNldAojIENPTkZJR19OVUxMX1RUWSBpcyBub3Qgc2V0CkNPTkZJR19IVkNfRFJJVkVS
PXkKIyBDT05GSUdfSFZDX1VEQkcgaXMgbm90IHNldApDT05GSUdfU0VSSUFMX0RFVl9CVVM9bQoj
IENPTkZJR19UVFlfUFJJTlRLIGlzIG5vdCBzZXQKQ09ORklHX1ZJUlRJT19DT05TT0xFPW0KIyBD
T05GSUdfSVBNSV9IQU5ETEVSIGlzIG5vdCBzZXQKIyBDT05GSUdfSFdfUkFORE9NIGlzIG5vdCBz
ZXQKIyBDT05GSUdfQVBQTElDT00gaXMgbm90IHNldAoKIwojIFBDTUNJQSBjaGFyYWN0ZXIgZGV2
aWNlcwojCiMgQ09ORklHX1NZTkNMSU5LX0NTIGlzIG5vdCBzZXQKIyBDT05GSUdfQ0FSRE1BTl80
MDAwIGlzIG5vdCBzZXQKIyBDT05GSUdfQ0FSRE1BTl80MDQwIGlzIG5vdCBzZXQKIyBDT05GSUdf
U0NSMjRYIGlzIG5vdCBzZXQKIyBDT05GSUdfSVBXSVJFTEVTUyBpcyBub3Qgc2V0CiMgZW5kIG9m
IFBDTUNJQSBjaGFyYWN0ZXIgZGV2aWNlcwoKQ09ORklHX0RFVk1FTT15CkNPTkZJR19OVlJBTT1t
CkNPTkZJR19ERVZQT1JUPXkKIyBDT05GSUdfVENHX1RQTSBpcyBub3Qgc2V0CiMgQ09ORklHX1hJ
TExZQlVTIGlzIG5vdCBzZXQKIyBDT05GSUdfWElMTFlVU0IgaXMgbm90IHNldApDT05GSUdfUkFO
RE9NX1RSVVNUX0NQVT15CiMgQ09ORklHX1JBTkRPTV9UUlVTVF9CT09UTE9BREVSIGlzIG5vdCBz
ZXQKIyBlbmQgb2YgQ2hhcmFjdGVyIGRldmljZXMKCiMKIyBJMkMgc3VwcG9ydAojCkNPTkZJR19J
MkM9eQpDT05GSUdfSTJDX0JPQVJESU5GTz15CiMgQ09ORklHX0kyQ19DT01QQVQgaXMgbm90IHNl
dApDT05GSUdfSTJDX0NIQVJERVY9eQpDT05GSUdfSTJDX01VWD1tCgojCiMgTXVsdGlwbGV4ZXIg
STJDIENoaXAgc3VwcG9ydAojCiMgQ09ORklHX0kyQ19BUkJfR1BJT19DSEFMTEVOR0UgaXMgbm90
IHNldAojIENPTkZJR19JMkNfTVVYX0dQSU8gaXMgbm90IHNldAojIENPTkZJR19JMkNfTVVYX0dQ
TVVYIGlzIG5vdCBzZXQKIyBDT05GSUdfSTJDX01VWF9MVEM0MzA2IGlzIG5vdCBzZXQKIyBDT05G
SUdfSTJDX01VWF9QQ0E5NTQxIGlzIG5vdCBzZXQKIyBDT05GSUdfSTJDX01VWF9QQ0E5NTR4IGlz
IG5vdCBzZXQKIyBDT05GSUdfSTJDX01VWF9SRUcgaXMgbm90IHNldAojIENPTkZJR19JMkNfTVVY
X01MWENQTEQgaXMgbm90IHNldAojIGVuZCBvZiBNdWx0aXBsZXhlciBJMkMgQ2hpcCBzdXBwb3J0
CgpDT05GSUdfSTJDX0hFTFBFUl9BVVRPPXkKQ09ORklHX0kyQ19BTEdPQklUPW0KCiMKIyBJMkMg
SGFyZHdhcmUgQnVzIHN1cHBvcnQKIwoKIwojIFBDIFNNQnVzIGhvc3QgY29udHJvbGxlciBkcml2
ZXJzCiMKIyBDT05GSUdfSTJDX0FMSTE1MzUgaXMgbm90IHNldAojIENPTkZJR19JMkNfQUxJMTU2
MyBpcyBub3Qgc2V0CiMgQ09ORklHX0kyQ19BTEkxNVgzIGlzIG5vdCBzZXQKIyBDT05GSUdfSTJD
X0FNRDc1NiBpcyBub3Qgc2V0CiMgQ09ORklHX0kyQ19BTUQ4MTExIGlzIG5vdCBzZXQKIyBDT05G
SUdfSTJDX0k4MDEgaXMgbm90IHNldAojIENPTkZJR19JMkNfSVNDSCBpcyBub3Qgc2V0CiMgQ09O
RklHX0kyQ19QSUlYNCBpcyBub3Qgc2V0CiMgQ09ORklHX0kyQ19ORk9SQ0UyIGlzIG5vdCBzZXQK
IyBDT05GSUdfSTJDX05WSURJQV9HUFUgaXMgbm90IHNldAojIENPTkZJR19JMkNfU0lTNTU5NSBp
cyBub3Qgc2V0CiMgQ09ORklHX0kyQ19TSVM2MzAgaXMgbm90IHNldAojIENPTkZJR19JMkNfU0lT
OTZYIGlzIG5vdCBzZXQKIyBDT05GSUdfSTJDX1ZJQSBpcyBub3Qgc2V0CiMgQ09ORklHX0kyQ19W
SUFQUk8gaXMgbm90IHNldAoKIwojIE1hYyBTTUJ1cyBob3N0IGNvbnRyb2xsZXIgZHJpdmVycwoj
CkNPTkZJR19JMkNfUE9XRVJNQUM9eQoKIwojIEkyQyBzeXN0ZW0gYnVzIGRyaXZlcnMgKG1vc3Rs
eSBlbWJlZGRlZCAvIHN5c3RlbS1vbi1jaGlwKQojCiMgQ09ORklHX0kyQ19DQlVTX0dQSU8gaXMg
bm90IHNldAojIENPTkZJR19JMkNfREVTSUdOV0FSRV9QTEFURk9STSBpcyBub3Qgc2V0CiMgQ09O
RklHX0kyQ19ERVNJR05XQVJFX1BDSSBpcyBub3Qgc2V0CiMgQ09ORklHX0kyQ19HUElPIGlzIG5v
dCBzZXQKIyBDT05GSUdfSTJDX01QQyBpcyBub3Qgc2V0CiMgQ09ORklHX0kyQ19PQ09SRVMgaXMg
bm90IHNldAojIENPTkZJR19JMkNfUENBX1BMQVRGT1JNIGlzIG5vdCBzZXQKIyBDT05GSUdfSTJD
X1NJTVRFQyBpcyBub3Qgc2V0CiMgQ09ORklHX0kyQ19YSUxJTlggaXMgbm90IHNldAoKIwojIEV4
dGVybmFsIEkyQy9TTUJ1cyBhZGFwdGVyIGRyaXZlcnMKIwojIENPTkZJR19JMkNfRElPTEFOX1Uy
QyBpcyBub3Qgc2V0CiMgQ09ORklHX0kyQ19DUDI2MTUgaXMgbm90IHNldAojIENPTkZJR19JMkNf
Uk9CT1RGVVpaX09TSUYgaXMgbm90IHNldAojIENPTkZJR19JMkNfVEFPU19FVk0gaXMgbm90IHNl
dAojIENPTkZJR19JMkNfVElOWV9VU0IgaXMgbm90IHNldAoKIwojIE90aGVyIEkyQy9TTUJ1cyBi
dXMgZHJpdmVycwojCiMgQ09ORklHX0kyQ19WSVJUSU8gaXMgbm90IHNldAojIGVuZCBvZiBJMkMg
SGFyZHdhcmUgQnVzIHN1cHBvcnQKCiMgQ09ORklHX0kyQ19TVFVCIGlzIG5vdCBzZXQKIyBDT05G
SUdfSTJDX1NMQVZFIGlzIG5vdCBzZXQKIyBDT05GSUdfSTJDX0RFQlVHX0NPUkUgaXMgbm90IHNl
dAojIENPTkZJR19JMkNfREVCVUdfQUxHTyBpcyBub3Qgc2V0CiMgQ09ORklHX0kyQ19ERUJVR19C
VVMgaXMgbm90IHNldAojIGVuZCBvZiBJMkMgc3VwcG9ydAoKIyBDT05GSUdfSTNDIGlzIG5vdCBz
ZXQKIyBDT05GSUdfU1BJIGlzIG5vdCBzZXQKIyBDT05GSUdfU1BNSSBpcyBub3Qgc2V0CiMgQ09O
RklHX0hTSSBpcyBub3Qgc2V0CiMgQ09ORklHX1BQUyBpcyBub3Qgc2V0CgojCiMgUFRQIGNsb2Nr
IHN1cHBvcnQKIwojIENPTkZJR19QVFBfMTU4OF9DTE9DSyBpcyBub3Qgc2V0CkNPTkZJR19QVFBf
MTU4OF9DTE9DS19PUFRJT05BTD15CgojCiMgRW5hYmxlIFBIWUxJQiBhbmQgTkVUV09SS19QSFlf
VElNRVNUQU1QSU5HIHRvIHNlZSB0aGUgYWRkaXRpb25hbCBjbG9ja3MuCiMKIyBlbmQgb2YgUFRQ
IGNsb2NrIHN1cHBvcnQKCiMgQ09ORklHX1BJTkNUUkwgaXMgbm90IHNldApDT05GSUdfR1BJT0xJ
Qj15CkNPTkZJR19HUElPTElCX0ZBU1RQQVRIX0xJTUlUPTUxMgpDT05GSUdfT0ZfR1BJTz15CiMg
Q09ORklHX0RFQlVHX0dQSU8gaXMgbm90IHNldAojIENPTkZJR19HUElPX1NZU0ZTIGlzIG5vdCBz
ZXQKQ09ORklHX0dQSU9fQ0RFVj15CiMgQ09ORklHX0dQSU9fQ0RFVl9WMSBpcyBub3Qgc2V0Cgoj
CiMgTWVtb3J5IG1hcHBlZCBHUElPIGRyaXZlcnMKIwojIENPTkZJR19HUElPXzc0WFhfTU1JTyBp
cyBub3Qgc2V0CiMgQ09ORklHX0dQSU9fQUxURVJBIGlzIG5vdCBzZXQKIyBDT05GSUdfR1BJT19D
QURFTkNFIGlzIG5vdCBzZXQKIyBDT05GSUdfR1BJT19EV0FQQiBpcyBub3Qgc2V0CiMgQ09ORklH
X0dQSU9fRlRHUElPMDEwIGlzIG5vdCBzZXQKIyBDT05GSUdfR1BJT19HRU5FUklDX1BMQVRGT1JN
IGlzIG5vdCBzZXQKIyBDT05GSUdfR1BJT19HUkdQSU8gaXMgbm90IHNldAojIENPTkZJR19HUElP
X0hMV0QgaXMgbm90IHNldAojIENPTkZJR19HUElPX01CODZTN1ggaXMgbm90IHNldAojIENPTkZJ
R19HUElPX1NJRklWRSBpcyBub3Qgc2V0CiMgQ09ORklHX0dQSU9fWElMSU5YIGlzIG5vdCBzZXQK
IyBDT05GSUdfR1BJT19BTURfRkNIIGlzIG5vdCBzZXQKIyBlbmQgb2YgTWVtb3J5IG1hcHBlZCBH
UElPIGRyaXZlcnMKCiMKIyBJMkMgR1BJTyBleHBhbmRlcnMKIwojIENPTkZJR19HUElPX0FEUDU1
ODggaXMgbm90IHNldAojIENPTkZJR19HUElPX0FETlAgaXMgbm90IHNldAojIENPTkZJR19HUElP
X0dXX1BMRCBpcyBub3Qgc2V0CiMgQ09ORklHX0dQSU9fTUFYNzMwMCBpcyBub3Qgc2V0CiMgQ09O
RklHX0dQSU9fTUFYNzMyWCBpcyBub3Qgc2V0CiMgQ09ORklHX0dQSU9fUENBOTUzWCBpcyBub3Qg
c2V0CiMgQ09ORklHX0dQSU9fUENBOTU3MCBpcyBub3Qgc2V0CiMgQ09ORklHX0dQSU9fUENGODU3
WCBpcyBub3Qgc2V0CiMgQ09ORklHX0dQSU9fVFBJQzI4MTAgaXMgbm90IHNldAojIGVuZCBvZiBJ
MkMgR1BJTyBleHBhbmRlcnMKCiMKIyBNRkQgR1BJTyBleHBhbmRlcnMKIwojIGVuZCBvZiBNRkQg
R1BJTyBleHBhbmRlcnMKCiMKIyBQQ0kgR1BJTyBleHBhbmRlcnMKIwojIENPTkZJR19HUElPX0JU
OFhYIGlzIG5vdCBzZXQKIyBDT05GSUdfR1BJT19QQ0lfSURJT18xNiBpcyBub3Qgc2V0CiMgQ09O
RklHX0dQSU9fUENJRV9JRElPXzI0IGlzIG5vdCBzZXQKIyBDT05GSUdfR1BJT19SREMzMjFYIGlz
IG5vdCBzZXQKIyBlbmQgb2YgUENJIEdQSU8gZXhwYW5kZXJzCgojCiMgVVNCIEdQSU8gZXhwYW5k
ZXJzCiMKIyBlbmQgb2YgVVNCIEdQSU8gZXhwYW5kZXJzCgojCiMgVmlydHVhbCBHUElPIGRyaXZl
cnMKIwpDT05GSUdfR1BJT19BR0dSRUdBVE9SPW0KIyBDT05GSUdfR1BJT19NT0NLVVAgaXMgbm90
IHNldAojIENPTkZJR19HUElPX1ZJUlRJTyBpcyBub3Qgc2V0CiMgQ09ORklHX0dQSU9fU0lNIGlz
IG5vdCBzZXQKIyBlbmQgb2YgVmlydHVhbCBHUElPIGRyaXZlcnMKCiMgQ09ORklHX1cxIGlzIG5v
dCBzZXQKIyBDT05GSUdfUE9XRVJfUkVTRVQgaXMgbm90IHNldApDT05GSUdfUE9XRVJfU1VQUExZ
PXkKIyBDT05GSUdfUE9XRVJfU1VQUExZX0RFQlVHIGlzIG5vdCBzZXQKIyBDT05GSUdfUERBX1BP
V0VSIGlzIG5vdCBzZXQKQ09ORklHX0FQTV9QT1dFUj1tCiMgQ09ORklHX0lQNVhYWF9QT1dFUiBp
cyBub3Qgc2V0CiMgQ09ORklHX1RFU1RfUE9XRVIgaXMgbm90IHNldAojIENPTkZJR19DSEFSR0VS
X0FEUDUwNjEgaXMgbm90IHNldAojIENPTkZJR19CQVRURVJZX0NXMjAxNSBpcyBub3Qgc2V0CiMg
Q09ORklHX0JBVFRFUllfRFMyNzgwIGlzIG5vdCBzZXQKIyBDT05GSUdfQkFUVEVSWV9EUzI3ODEg
aXMgbm90IHNldAojIENPTkZJR19CQVRURVJZX0RTMjc4MiBpcyBub3Qgc2V0CkNPTkZJR19CQVRU
RVJZX1BNVT1tCiMgQ09ORklHX0JBVFRFUllfU0FNU1VOR19TREkgaXMgbm90IHNldAojIENPTkZJ
R19CQVRURVJZX1NCUyBpcyBub3Qgc2V0CiMgQ09ORklHX0NIQVJHRVJfU0JTIGlzIG5vdCBzZXQK
IyBDT05GSUdfTUFOQUdFUl9TQlMgaXMgbm90IHNldAojIENPTkZJR19CQVRURVJZX0JRMjdYWFgg
aXMgbm90IHNldAojIENPTkZJR19CQVRURVJZX01BWDE3MDQwIGlzIG5vdCBzZXQKIyBDT05GSUdf
QkFUVEVSWV9NQVgxNzA0MiBpcyBub3Qgc2V0CiMgQ09ORklHX0NIQVJHRVJfTUFYODkwMyBpcyBu
b3Qgc2V0CiMgQ09ORklHX0NIQVJHRVJfTFA4NzI3IGlzIG5vdCBzZXQKIyBDT05GSUdfQ0hBUkdF
Ul9HUElPIGlzIG5vdCBzZXQKIyBDT05GSUdfQ0hBUkdFUl9NQU5BR0VSIGlzIG5vdCBzZXQKIyBD
T05GSUdfQ0hBUkdFUl9MVDM2NTEgaXMgbm90IHNldAojIENPTkZJR19DSEFSR0VSX0xUQzQxNjJM
IGlzIG5vdCBzZXQKIyBDT05GSUdfQ0hBUkdFUl9ERVRFQ1RPUl9NQVgxNDY1NiBpcyBub3Qgc2V0
CiMgQ09ORklHX0NIQVJHRVJfTUFYNzc5NzYgaXMgbm90IHNldAojIENPTkZJR19DSEFSR0VSX0JR
MjQxNVggaXMgbm90IHNldAojIENPTkZJR19DSEFSR0VSX0JRMjQyNTcgaXMgbm90IHNldAojIENP
TkZJR19DSEFSR0VSX0JRMjQ3MzUgaXMgbm90IHNldAojIENPTkZJR19DSEFSR0VSX0JRMjUxNVgg
aXMgbm90IHNldAojIENPTkZJR19DSEFSR0VSX0JRMjU4OTAgaXMgbm90IHNldAojIENPTkZJR19D
SEFSR0VSX0JRMjU5ODAgaXMgbm90IHNldAojIENPTkZJR19DSEFSR0VSX0JRMjU2WFggaXMgbm90
IHNldAojIENPTkZJR19DSEFSR0VSX1NNQjM0NyBpcyBub3Qgc2V0CiMgQ09ORklHX0JBVFRFUllf
R0FVR0VfTFRDMjk0MSBpcyBub3Qgc2V0CiMgQ09ORklHX0JBVFRFUllfR09MREZJU0ggaXMgbm90
IHNldAojIENPTkZJR19CQVRURVJZX1JUNTAzMyBpcyBub3Qgc2V0CiMgQ09ORklHX0NIQVJHRVJf
UlQ5NDU1IGlzIG5vdCBzZXQKIyBDT05GSUdfQ0hBUkdFUl9VQ1MxMDAyIGlzIG5vdCBzZXQKIyBD
T05GSUdfQ0hBUkdFUl9CRDk5OTU0IGlzIG5vdCBzZXQKIyBDT05GSUdfQkFUVEVSWV9VRzMxMDUg
aXMgbm90IHNldApDT05GSUdfSFdNT049bQpDT05GSUdfSFdNT05fREVCVUdfQ0hJUD15CgojCiMg
TmF0aXZlIGRyaXZlcnMKIwojIENPTkZJR19TRU5TT1JTX0FENzQxNCBpcyBub3Qgc2V0CiMgQ09O
RklHX1NFTlNPUlNfQUQ3NDE4IGlzIG5vdCBzZXQKIyBDT05GSUdfU0VOU09SU19BRE0xMDIxIGlz
IG5vdCBzZXQKIyBDT05GSUdfU0VOU09SU19BRE0xMDI1IGlzIG5vdCBzZXQKIyBDT05GSUdfU0VO
U09SU19BRE0xMDI2IGlzIG5vdCBzZXQKIyBDT05GSUdfU0VOU09SU19BRE0xMDI5IGlzIG5vdCBz
ZXQKIyBDT05GSUdfU0VOU09SU19BRE0xMDMxIGlzIG5vdCBzZXQKIyBDT05GSUdfU0VOU09SU19B
RE0xMTc3IGlzIG5vdCBzZXQKIyBDT05GSUdfU0VOU09SU19BRE05MjQwIGlzIG5vdCBzZXQKIyBD
T05GSUdfU0VOU09SU19BRFQ3NDEwIGlzIG5vdCBzZXQKIyBDT05GSUdfU0VOU09SU19BRFQ3NDEx
IGlzIG5vdCBzZXQKIyBDT05GSUdfU0VOU09SU19BRFQ3NDYyIGlzIG5vdCBzZXQKIyBDT05GSUdf
U0VOU09SU19BRFQ3NDcwIGlzIG5vdCBzZXQKIyBDT05GSUdfU0VOU09SU19BRFQ3NDc1IGlzIG5v
dCBzZXQKIyBDT05GSUdfU0VOU09SU19BSFQxMCBpcyBub3Qgc2V0CiMgQ09ORklHX1NFTlNPUlNf
QVFVQUNPTVBVVEVSX0Q1TkVYVCBpcyBub3Qgc2V0CiMgQ09ORklHX1NFTlNPUlNfQVMzNzAgaXMg
bm90IHNldAojIENPTkZJR19TRU5TT1JTX0FTQzc2MjEgaXMgbm90IHNldAojIENPTkZJR19TRU5T
T1JTX0FYSV9GQU5fQ09OVFJPTCBpcyBub3Qgc2V0CiMgQ09ORklHX1NFTlNPUlNfQVNQRUVEIGlz
IG5vdCBzZXQKIyBDT05GSUdfU0VOU09SU19BVFhQMSBpcyBub3Qgc2V0CiMgQ09ORklHX1NFTlNP
UlNfQ09SU0FJUl9DUFJPIGlzIG5vdCBzZXQKIyBDT05GSUdfU0VOU09SU19DT1JTQUlSX1BTVSBp
cyBub3Qgc2V0CkNPTkZJR19TRU5TT1JTX0RSSVZFVEVNUD1tCiMgQ09ORklHX1NFTlNPUlNfRFM2
MjAgaXMgbm90IHNldAojIENPTkZJR19TRU5TT1JTX0RTMTYyMSBpcyBub3Qgc2V0CiMgQ09ORklH
X1NFTlNPUlNfSTVLX0FNQiBpcyBub3Qgc2V0CiMgQ09ORklHX1NFTlNPUlNfRjc1Mzc1UyBpcyBu
b3Qgc2V0CiMgQ09ORklHX1NFTlNPUlNfR0w1MThTTSBpcyBub3Qgc2V0CiMgQ09ORklHX1NFTlNP
UlNfR0w1MjBTTSBpcyBub3Qgc2V0CiMgQ09ORklHX1NFTlNPUlNfRzc2MEEgaXMgbm90IHNldAoj
IENPTkZJR19TRU5TT1JTX0c3NjIgaXMgbm90IHNldAojIENPTkZJR19TRU5TT1JTX0dQSU9fRkFO
IGlzIG5vdCBzZXQKIyBDT05GSUdfU0VOU09SU19ISUg2MTMwIGlzIG5vdCBzZXQKIyBDT05GSUdf
U0VOU09SU19KQzQyIGlzIG5vdCBzZXQKIyBDT05GSUdfU0VOU09SU19QT1dSMTIyMCBpcyBub3Qg
c2V0CiMgQ09ORklHX1NFTlNPUlNfTElORUFHRSBpcyBub3Qgc2V0CiMgQ09ORklHX1NFTlNPUlNf
TFRDMjk0NSBpcyBub3Qgc2V0CiMgQ09ORklHX1NFTlNPUlNfTFRDMjk0N19JMkMgaXMgbm90IHNl
dAojIENPTkZJR19TRU5TT1JTX0xUQzI5OTAgaXMgbm90IHNldAojIENPTkZJR19TRU5TT1JTX0xU
QzI5OTIgaXMgbm90IHNldAojIENPTkZJR19TRU5TT1JTX0xUQzQxNTEgaXMgbm90IHNldAojIENP
TkZJR19TRU5TT1JTX0xUQzQyMTUgaXMgbm90IHNldAojIENPTkZJR19TRU5TT1JTX0xUQzQyMjIg
aXMgbm90IHNldAojIENPTkZJR19TRU5TT1JTX0xUQzQyNDUgaXMgbm90IHNldAojIENPTkZJR19T
RU5TT1JTX0xUQzQyNjAgaXMgbm90IHNldAojIENPTkZJR19TRU5TT1JTX0xUQzQyNjEgaXMgbm90
IHNldAojIENPTkZJR19TRU5TT1JTX01BWDEyNyBpcyBub3Qgc2V0CiMgQ09ORklHX1NFTlNPUlNf
TUFYMTYwNjUgaXMgbm90IHNldAojIENPTkZJR19TRU5TT1JTX01BWDE2MTkgaXMgbm90IHNldAoj
IENPTkZJR19TRU5TT1JTX01BWDE2NjggaXMgbm90IHNldAojIENPTkZJR19TRU5TT1JTX01BWDE5
NyBpcyBub3Qgc2V0CiMgQ09ORklHX1NFTlNPUlNfTUFYMzE3MzAgaXMgbm90IHNldAojIENPTkZJ
R19TRU5TT1JTX01BWDY2MjAgaXMgbm90IHNldAojIENPTkZJR19TRU5TT1JTX01BWDY2MjEgaXMg
bm90IHNldAojIENPTkZJR19TRU5TT1JTX01BWDY2MzkgaXMgbm90IHNldAojIENPTkZJR19TRU5T
T1JTX01BWDY2NDIgaXMgbm90IHNldAojIENPTkZJR19TRU5TT1JTX01BWDY2NTAgaXMgbm90IHNl
dAojIENPTkZJR19TRU5TT1JTX01BWDY2OTcgaXMgbm90IHNldAojIENPTkZJR19TRU5TT1JTX01B
WDMxNzkwIGlzIG5vdCBzZXQKIyBDT05GSUdfU0VOU09SU19NQ1AzMDIxIGlzIG5vdCBzZXQKIyBD
T05GSUdfU0VOU09SU19UQzY1NCBpcyBub3Qgc2V0CiMgQ09ORklHX1NFTlNPUlNfVFBTMjM4NjEg
aXMgbm90IHNldAojIENPTkZJR19TRU5TT1JTX01SNzUyMDMgaXMgbm90IHNldAojIENPTkZJR19T
RU5TT1JTX0xNNjMgaXMgbm90IHNldAojIENPTkZJR19TRU5TT1JTX0xNNzMgaXMgbm90IHNldAoj
IENPTkZJR19TRU5TT1JTX0xNNzUgaXMgbm90IHNldAojIENPTkZJR19TRU5TT1JTX0xNNzcgaXMg
bm90IHNldAojIENPTkZJR19TRU5TT1JTX0xNNzggaXMgbm90IHNldAojIENPTkZJR19TRU5TT1JT
X0xNODAgaXMgbm90IHNldAojIENPTkZJR19TRU5TT1JTX0xNODMgaXMgbm90IHNldAojIENPTkZJ
R19TRU5TT1JTX0xNODUgaXMgbm90IHNldAojIENPTkZJR19TRU5TT1JTX0xNODcgaXMgbm90IHNl
dAojIENPTkZJR19TRU5TT1JTX0xNOTAgaXMgbm90IHNldAojIENPTkZJR19TRU5TT1JTX0xNOTIg
aXMgbm90IHNldAojIENPTkZJR19TRU5TT1JTX0xNOTMgaXMgbm90IHNldAojIENPTkZJR19TRU5T
T1JTX0xNOTUyMzQgaXMgbm90IHNldAojIENPTkZJR19TRU5TT1JTX0xNOTUyNDEgaXMgbm90IHNl
dAojIENPTkZJR19TRU5TT1JTX0xNOTUyNDUgaXMgbm90IHNldAojIENPTkZJR19TRU5TT1JTX05D
VDY3NzVfSTJDIGlzIG5vdCBzZXQKIyBDT05GSUdfU0VOU09SU19OQ1Q3ODAyIGlzIG5vdCBzZXQK
IyBDT05GSUdfU0VOU09SU19OUENNN1hYIGlzIG5vdCBzZXQKIyBDT05GSUdfU0VOU09SU19OWlhU
X0tSQUtFTjIgaXMgbm90IHNldAojIENPTkZJR19TRU5TT1JTX05aWFRfU01BUlQyIGlzIG5vdCBz
ZXQKIyBDT05GSUdfU0VOU09SU19QQ0Y4NTkxIGlzIG5vdCBzZXQKIyBDT05GSUdfUE1CVVMgaXMg
bm90IHNldAojIENPTkZJR19TRU5TT1JTX1NCVFNJIGlzIG5vdCBzZXQKIyBDT05GSUdfU0VOU09S
U19TQlJNSSBpcyBub3Qgc2V0CiMgQ09ORklHX1NFTlNPUlNfU0hUMTUgaXMgbm90IHNldAojIENP
TkZJR19TRU5TT1JTX1NIVDIxIGlzIG5vdCBzZXQKIyBDT05GSUdfU0VOU09SU19TSFQzeCBpcyBu
b3Qgc2V0CiMgQ09ORklHX1NFTlNPUlNfU0hUNHggaXMgbm90IHNldAojIENPTkZJR19TRU5TT1JT
X1NIVEMxIGlzIG5vdCBzZXQKIyBDT05GSUdfU0VOU09SU19TSVM1NTk1IGlzIG5vdCBzZXQKIyBD
T05GSUdfU0VOU09SU19TWTc2MzZBIGlzIG5vdCBzZXQKIyBDT05GSUdfU0VOU09SU19FTUMxNDAz
IGlzIG5vdCBzZXQKIyBDT05GSUdfU0VOU09SU19FTUMyMTAzIGlzIG5vdCBzZXQKIyBDT05GSUdf
U0VOU09SU19FTUM2VzIwMSBpcyBub3Qgc2V0CiMgQ09ORklHX1NFTlNPUlNfU01TQzQ3TTE5MiBp
cyBub3Qgc2V0CiMgQ09ORklHX1NFTlNPUlNfU1RUUzc1MSBpcyBub3Qgc2V0CiMgQ09ORklHX1NF
TlNPUlNfU01NNjY1IGlzIG5vdCBzZXQKIyBDT05GSUdfU0VOU09SU19BREMxMjhEODE4IGlzIG5v
dCBzZXQKIyBDT05GSUdfU0VOU09SU19BRFM3ODI4IGlzIG5vdCBzZXQKIyBDT05GSUdfU0VOU09S
U19BTUM2ODIxIGlzIG5vdCBzZXQKIyBDT05GSUdfU0VOU09SU19JTkEyMDkgaXMgbm90IHNldAoj
IENPTkZJR19TRU5TT1JTX0lOQTJYWCBpcyBub3Qgc2V0CiMgQ09ORklHX1NFTlNPUlNfSU5BMjM4
IGlzIG5vdCBzZXQKIyBDT05GSUdfU0VOU09SU19JTkEzMjIxIGlzIG5vdCBzZXQKIyBDT05GSUdf
U0VOU09SU19UQzc0IGlzIG5vdCBzZXQKIyBDT05GSUdfU0VOU09SU19USE1DNTAgaXMgbm90IHNl
dAojIENPTkZJR19TRU5TT1JTX1RNUDEwMiBpcyBub3Qgc2V0CiMgQ09ORklHX1NFTlNPUlNfVE1Q
MTAzIGlzIG5vdCBzZXQKIyBDT05GSUdfU0VOU09SU19UTVAxMDggaXMgbm90IHNldAojIENPTkZJ
R19TRU5TT1JTX1RNUDQwMSBpcyBub3Qgc2V0CiMgQ09ORklHX1NFTlNPUlNfVE1QNDIxIGlzIG5v
dCBzZXQKIyBDT05GSUdfU0VOU09SU19UTVA0NjQgaXMgbm90IHNldAojIENPTkZJR19TRU5TT1JT
X1RNUDUxMyBpcyBub3Qgc2V0CiMgQ09ORklHX1NFTlNPUlNfVklBNjg2QSBpcyBub3Qgc2V0CiMg
Q09ORklHX1NFTlNPUlNfVlQ4MjMxIGlzIG5vdCBzZXQKIyBDT05GSUdfU0VOU09SU19XODM3NzNH
IGlzIG5vdCBzZXQKIyBDT05GSUdfU0VOU09SU19XODM3ODFEIGlzIG5vdCBzZXQKIyBDT05GSUdf
U0VOU09SU19XODM3OTFEIGlzIG5vdCBzZXQKIyBDT05GSUdfU0VOU09SU19XODM3OTJEIGlzIG5v
dCBzZXQKIyBDT05GSUdfU0VOU09SU19XODM3OTMgaXMgbm90IHNldAojIENPTkZJR19TRU5TT1JT
X1c4Mzc5NSBpcyBub3Qgc2V0CiMgQ09ORklHX1NFTlNPUlNfVzgzTDc4NVRTIGlzIG5vdCBzZXQK
IyBDT05GSUdfU0VOU09SU19XODNMNzg2TkcgaXMgbm90IHNldApDT05GSUdfVEhFUk1BTD15CkNP
TkZJR19USEVSTUFMX05FVExJTks9eQpDT05GSUdfVEhFUk1BTF9TVEFUSVNUSUNTPXkKQ09ORklH
X1RIRVJNQUxfRU1FUkdFTkNZX1BPV0VST0ZGX0RFTEFZX01TPTAKQ09ORklHX1RIRVJNQUxfT0Y9
eQojIENPTkZJR19USEVSTUFMX1dSSVRBQkxFX1RSSVBTIGlzIG5vdCBzZXQKQ09ORklHX1RIRVJN
QUxfREVGQVVMVF9HT1ZfU1RFUF9XSVNFPXkKIyBDT05GSUdfVEhFUk1BTF9ERUZBVUxUX0dPVl9G
QUlSX1NIQVJFIGlzIG5vdCBzZXQKIyBDT05GSUdfVEhFUk1BTF9ERUZBVUxUX0dPVl9VU0VSX1NQ
QUNFIGlzIG5vdCBzZXQKQ09ORklHX1RIRVJNQUxfR09WX0ZBSVJfU0hBUkU9eQpDT05GSUdfVEhF
Uk1BTF9HT1ZfU1RFUF9XSVNFPXkKIyBDT05GSUdfVEhFUk1BTF9HT1ZfQkFOR19CQU5HIGlzIG5v
dCBzZXQKIyBDT05GSUdfVEhFUk1BTF9HT1ZfVVNFUl9TUEFDRSBpcyBub3Qgc2V0CkNPTkZJR19D
UFVfVEhFUk1BTD15CkNPTkZJR19DUFVfRlJFUV9USEVSTUFMPXkKIyBDT05GSUdfVEhFUk1BTF9F
TVVMQVRJT04gaXMgbm90IHNldApDT05GSUdfVEhFUk1BTF9NTUlPPW0KIyBDT05GSUdfV0FUQ0hE
T0cgaXMgbm90IHNldApDT05GSUdfU1NCX1BPU1NJQkxFPXkKQ09ORklHX1NTQj1tCkNPTkZJR19T
U0JfU1BST009eQpDT05GSUdfU1NCX1BDSUhPU1RfUE9TU0lCTEU9eQpDT05GSUdfU1NCX1BDSUhP
U1Q9eQpDT05GSUdfU1NCX0I0M19QQ0lfQlJJREdFPXkKQ09ORklHX1NTQl9QQ01DSUFIT1NUX1BP
U1NJQkxFPXkKQ09ORklHX1NTQl9QQ01DSUFIT1NUPXkKQ09ORklHX1NTQl9EUklWRVJfUENJQ09S
RV9QT1NTSUJMRT15CkNPTkZJR19TU0JfRFJJVkVSX1BDSUNPUkU9eQojIENPTkZJR19TU0JfRFJJ
VkVSX0dQSU8gaXMgbm90IHNldApDT05GSUdfQkNNQV9QT1NTSUJMRT15CkNPTkZJR19CQ01BPW0K
Q09ORklHX0JDTUFfSE9TVF9QQ0lfUE9TU0lCTEU9eQpDT05GSUdfQkNNQV9IT1NUX1BDST15CiMg
Q09ORklHX0JDTUFfSE9TVF9TT0MgaXMgbm90IHNldApDT05GSUdfQkNNQV9EUklWRVJfUENJPXkK
IyBDT05GSUdfQkNNQV9EUklWRVJfR01BQ19DTU4gaXMgbm90IHNldAojIENPTkZJR19CQ01BX0RS
SVZFUl9HUElPIGlzIG5vdCBzZXQKIyBDT05GSUdfQkNNQV9ERUJVRyBpcyBub3Qgc2V0CgojCiMg
TXVsdGlmdW5jdGlvbiBkZXZpY2UgZHJpdmVycwojCiMgQ09ORklHX01GRF9BQ1Q4OTQ1QSBpcyBu
b3Qgc2V0CiMgQ09ORklHX01GRF9BUzM3MTEgaXMgbm90IHNldAojIENPTkZJR19NRkRfQVMzNzIy
IGlzIG5vdCBzZXQKIyBDT05GSUdfUE1JQ19BRFA1NTIwIGlzIG5vdCBzZXQKIyBDT05GSUdfTUZE
X0FBVDI4NzBfQ09SRSBpcyBub3Qgc2V0CiMgQ09ORklHX01GRF9BVE1FTF9GTEVYQ09NIGlzIG5v
dCBzZXQKIyBDT05GSUdfTUZEX0FUTUVMX0hMQ0RDIGlzIG5vdCBzZXQKIyBDT05GSUdfTUZEX0JD
TTU5MFhYIGlzIG5vdCBzZXQKIyBDT05GSUdfTUZEX0JEOTU3MU1XViBpcyBub3Qgc2V0CiMgQ09O
RklHX01GRF9BWFAyMFhfSTJDIGlzIG5vdCBzZXQKIyBDT05GSUdfTUZEX01BREVSQSBpcyBub3Qg
c2V0CiMgQ09ORklHX1BNSUNfREE5MDNYIGlzIG5vdCBzZXQKIyBDT05GSUdfTUZEX0RBOTA1Ml9J
MkMgaXMgbm90IHNldAojIENPTkZJR19NRkRfREE5MDU1IGlzIG5vdCBzZXQKIyBDT05GSUdfTUZE
X0RBOTA2MiBpcyBub3Qgc2V0CiMgQ09ORklHX01GRF9EQTkwNjMgaXMgbm90IHNldAojIENPTkZJ
R19NRkRfREE5MTUwIGlzIG5vdCBzZXQKIyBDT05GSUdfTUZEX0RMTjIgaXMgbm90IHNldAojIENP
TkZJR19NRkRfR0FURVdPUktTX0dTQyBpcyBub3Qgc2V0CiMgQ09ORklHX01GRF9NQzEzWFhYX0ky
QyBpcyBub3Qgc2V0CiMgQ09ORklHX01GRF9NUDI2MjkgaXMgbm90IHNldAojIENPTkZJR19NRkRf
SEk2NDIxX1BNSUMgaXMgbm90IHNldAojIENPTkZJR19IVENfUEFTSUMzIGlzIG5vdCBzZXQKIyBD
T05GSUdfSFRDX0kyQ1BMRCBpcyBub3Qgc2V0CiMgQ09ORklHX0xQQ19JQ0ggaXMgbm90IHNldAoj
IENPTkZJR19MUENfU0NIIGlzIG5vdCBzZXQKIyBDT05GSUdfTUZEX0lRUzYyWCBpcyBub3Qgc2V0
CiMgQ09ORklHX01GRF9KQU5aX0NNT0RJTyBpcyBub3Qgc2V0CiMgQ09ORklHX01GRF9LRU1QTEQg
aXMgbm90IHNldAojIENPTkZJR19NRkRfODhQTTgwMCBpcyBub3Qgc2V0CiMgQ09ORklHX01GRF84
OFBNODA1IGlzIG5vdCBzZXQKIyBDT05GSUdfTUZEXzg4UE04NjBYIGlzIG5vdCBzZXQKIyBDT05G
SUdfTUZEX01BWDE0NTc3IGlzIG5vdCBzZXQKIyBDT05GSUdfTUZEX01BWDc3NjIwIGlzIG5vdCBz
ZXQKIyBDT05GSUdfTUZEX01BWDc3NjUwIGlzIG5vdCBzZXQKIyBDT05GSUdfTUZEX01BWDc3Njg2
IGlzIG5vdCBzZXQKIyBDT05GSUdfTUZEX01BWDc3NjkzIGlzIG5vdCBzZXQKIyBDT05GSUdfTUZE
X01BWDc3NzE0IGlzIG5vdCBzZXQKIyBDT05GSUdfTUZEX01BWDc3ODQzIGlzIG5vdCBzZXQKIyBD
T05GSUdfTUZEX01BWDg5MDcgaXMgbm90IHNldAojIENPTkZJR19NRkRfTUFYODkyNSBpcyBub3Qg
c2V0CiMgQ09ORklHX01GRF9NQVg4OTk3IGlzIG5vdCBzZXQKIyBDT05GSUdfTUZEX01BWDg5OTgg
aXMgbm90IHNldAojIENPTkZJR19NRkRfTVQ2MzYwIGlzIG5vdCBzZXQKIyBDT05GSUdfTUZEX01U
NjM5NyBpcyBub3Qgc2V0CiMgQ09ORklHX01GRF9NRU5GMjFCTUMgaXMgbm90IHNldAojIENPTkZJ
R19NRkRfVklQRVJCT0FSRCBpcyBub3Qgc2V0CiMgQ09ORklHX01GRF9OVFhFQyBpcyBub3Qgc2V0
CiMgQ09ORklHX01GRF9SRVRVIGlzIG5vdCBzZXQKIyBDT05GSUdfTUZEX1BDRjUwNjMzIGlzIG5v
dCBzZXQKIyBDT05GSUdfTUZEX1JEQzMyMVggaXMgbm90IHNldAojIENPTkZJR19NRkRfUlQ0ODMx
IGlzIG5vdCBzZXQKIyBDT05GSUdfTUZEX1JUNTAzMyBpcyBub3Qgc2V0CiMgQ09ORklHX01GRF9S
QzVUNTgzIGlzIG5vdCBzZXQKIyBDT05GSUdfTUZEX1JLODA4IGlzIG5vdCBzZXQKIyBDT05GSUdf
TUZEX1JONVQ2MTggaXMgbm90IHNldAojIENPTkZJR19NRkRfU0VDX0NPUkUgaXMgbm90IHNldAoj
IENPTkZJR19NRkRfU0k0NzZYX0NPUkUgaXMgbm90IHNldAojIENPTkZJR19NRkRfU0lNUExFX01G
RF9JMkMgaXMgbm90IHNldAojIENPTkZJR19NRkRfU001MDEgaXMgbm90IHNldAojIENPTkZJR19N
RkRfU0tZODE0NTIgaXMgbm90IHNldAojIENPTkZJR19NRkRfU1RNUEUgaXMgbm90IHNldAojIENP
TkZJR19NRkRfU1lTQ09OIGlzIG5vdCBzZXQKIyBDT05GSUdfTUZEX1RJX0FNMzM1WF9UU0NBREMg
aXMgbm90IHNldAojIENPTkZJR19NRkRfTFAzOTQzIGlzIG5vdCBzZXQKIyBDT05GSUdfTUZEX0xQ
ODc4OCBpcyBub3Qgc2V0CiMgQ09ORklHX01GRF9USV9MTVUgaXMgbm90IHNldAojIENPTkZJR19N
RkRfUEFMTUFTIGlzIG5vdCBzZXQKIyBDT05GSUdfVFBTNjEwNVggaXMgbm90IHNldAojIENPTkZJ
R19UUFM2NTAxMCBpcyBub3Qgc2V0CiMgQ09ORklHX1RQUzY1MDdYIGlzIG5vdCBzZXQKIyBDT05G
SUdfTUZEX1RQUzY1MDg2IGlzIG5vdCBzZXQKIyBDT05GSUdfTUZEX1RQUzY1MDkwIGlzIG5vdCBz
ZXQKIyBDT05GSUdfTUZEX1RQUzY1MjE3IGlzIG5vdCBzZXQKIyBDT05GSUdfTUZEX1RJX0xQODcz
WCBpcyBub3Qgc2V0CiMgQ09ORklHX01GRF9USV9MUDg3NTY1IGlzIG5vdCBzZXQKIyBDT05GSUdf
TUZEX1RQUzY1MjE4IGlzIG5vdCBzZXQKIyBDT05GSUdfTUZEX1RQUzY1ODZYIGlzIG5vdCBzZXQK
IyBDT05GSUdfTUZEX1RQUzY1OTEwIGlzIG5vdCBzZXQKIyBDT05GSUdfTUZEX1RQUzY1OTEyX0ky
QyBpcyBub3Qgc2V0CiMgQ09ORklHX1RXTDQwMzBfQ09SRSBpcyBub3Qgc2V0CiMgQ09ORklHX1RX
TDYwNDBfQ09SRSBpcyBub3Qgc2V0CiMgQ09ORklHX01GRF9XTDEyNzNfQ09SRSBpcyBub3Qgc2V0
CiMgQ09ORklHX01GRF9MTTM1MzMgaXMgbm90IHNldAojIENPTkZJR19NRkRfVEMzNTg5WCBpcyBu
b3Qgc2V0CiMgQ09ORklHX01GRF9UUU1YODYgaXMgbm90IHNldAojIENPTkZJR19NRkRfVlg4NTUg
aXMgbm90IHNldAojIENPTkZJR19NRkRfTE9DSE5BR0FSIGlzIG5vdCBzZXQKIyBDT05GSUdfTUZE
X0FSSVpPTkFfSTJDIGlzIG5vdCBzZXQKIyBDT05GSUdfTUZEX1dNODQwMCBpcyBub3Qgc2V0CiMg
Q09ORklHX01GRF9XTTgzMVhfSTJDIGlzIG5vdCBzZXQKIyBDT05GSUdfTUZEX1dNODM1MF9JMkMg
aXMgbm90IHNldAojIENPTkZJR19NRkRfV004OTk0IGlzIG5vdCBzZXQKIyBDT05GSUdfTUZEX1JP
SE1fQkQ3MThYWCBpcyBub3Qgc2V0CiMgQ09ORklHX01GRF9ST0hNX0JENzE4MjggaXMgbm90IHNl
dAojIENPTkZJR19NRkRfUk9ITV9CRDk1N1hNVUYgaXMgbm90IHNldAojIENPTkZJR19NRkRfU1RQ
TUlDMSBpcyBub3Qgc2V0CiMgQ09ORklHX01GRF9TVE1GWCBpcyBub3Qgc2V0CiMgQ09ORklHX01G
RF9BVEMyNjBYX0kyQyBpcyBub3Qgc2V0CiMgQ09ORklHX01GRF9RQ09NX1BNODAwOCBpcyBub3Qg
c2V0CiMgQ09ORklHX1JBVkVfU1BfQ09SRSBpcyBub3Qgc2V0CiMgQ09ORklHX01GRF9SU01VX0ky
QyBpcyBub3Qgc2V0CiMgZW5kIG9mIE11bHRpZnVuY3Rpb24gZGV2aWNlIGRyaXZlcnMKCkNPTkZJ
R19SRUdVTEFUT1I9eQojIENPTkZJR19SRUdVTEFUT1JfREVCVUcgaXMgbm90IHNldApDT05GSUdf
UkVHVUxBVE9SX0ZJWEVEX1ZPTFRBR0U9bQojIENPTkZJR19SRUdVTEFUT1JfVklSVFVBTF9DT05T
VU1FUiBpcyBub3Qgc2V0CiMgQ09ORklHX1JFR1VMQVRPUl9VU0VSU1BBQ0VfQ09OU1VNRVIgaXMg
bm90IHNldAojIENPTkZJR19SRUdVTEFUT1JfODhQRzg2WCBpcyBub3Qgc2V0CiMgQ09ORklHX1JF
R1VMQVRPUl9BQ1Q4ODY1IGlzIG5vdCBzZXQKIyBDT05GSUdfUkVHVUxBVE9SX0FENTM5OCBpcyBu
b3Qgc2V0CiMgQ09ORklHX1JFR1VMQVRPUl9EQTkxMjEgaXMgbm90IHNldAojIENPTkZJR19SRUdV
TEFUT1JfREE5MjEwIGlzIG5vdCBzZXQKIyBDT05GSUdfUkVHVUxBVE9SX0RBOTIxMSBpcyBub3Qg
c2V0CiMgQ09ORklHX1JFR1VMQVRPUl9GQU41MzU1NSBpcyBub3Qgc2V0CiMgQ09ORklHX1JFR1VM
QVRPUl9GQU41Mzg4MCBpcyBub3Qgc2V0CiMgQ09ORklHX1JFR1VMQVRPUl9HUElPIGlzIG5vdCBz
ZXQKIyBDT05GSUdfUkVHVUxBVE9SX0lTTDkzMDUgaXMgbm90IHNldAojIENPTkZJR19SRUdVTEFU
T1JfSVNMNjI3MUEgaXMgbm90IHNldAojIENPTkZJR19SRUdVTEFUT1JfTFAzOTcxIGlzIG5vdCBz
ZXQKIyBDT05GSUdfUkVHVUxBVE9SX0xQMzk3MiBpcyBub3Qgc2V0CiMgQ09ORklHX1JFR1VMQVRP
Ul9MUDg3MlggaXMgbm90IHNldAojIENPTkZJR19SRUdVTEFUT1JfTFA4NzU1IGlzIG5vdCBzZXQK
IyBDT05GSUdfUkVHVUxBVE9SX0xUQzM1ODkgaXMgbm90IHNldAojIENPTkZJR19SRUdVTEFUT1Jf
TFRDMzY3NiBpcyBub3Qgc2V0CiMgQ09ORklHX1JFR1VMQVRPUl9NQVgxNTg2IGlzIG5vdCBzZXQK
IyBDT05GSUdfUkVHVUxBVE9SX01BWDg2NDkgaXMgbm90IHNldAojIENPTkZJR19SRUdVTEFUT1Jf
TUFYODY2MCBpcyBub3Qgc2V0CiMgQ09ORklHX1JFR1VMQVRPUl9NQVg4ODkzIGlzIG5vdCBzZXQK
IyBDT05GSUdfUkVHVUxBVE9SX01BWDg5NTIgaXMgbm90IHNldAojIENPTkZJR19SRUdVTEFUT1Jf
TUFYODk3MyBpcyBub3Qgc2V0CiMgQ09ORklHX1JFR1VMQVRPUl9NQVgyMDA4NiBpcyBub3Qgc2V0
CiMgQ09ORklHX1JFR1VMQVRPUl9NQVg3NzgyNiBpcyBub3Qgc2V0CiMgQ09ORklHX1JFR1VMQVRP
Ul9NQ1AxNjUwMiBpcyBub3Qgc2V0CiMgQ09ORklHX1JFR1VMQVRPUl9NUDU0MTYgaXMgbm90IHNl
dAojIENPTkZJR19SRUdVTEFUT1JfTVA4ODU5IGlzIG5vdCBzZXQKIyBDT05GSUdfUkVHVUxBVE9S
X01QODg2WCBpcyBub3Qgc2V0CiMgQ09ORklHX1JFR1VMQVRPUl9NUFE3OTIwIGlzIG5vdCBzZXQK
IyBDT05GSUdfUkVHVUxBVE9SX01UNjMxMSBpcyBub3Qgc2V0CiMgQ09ORklHX1JFR1VMQVRPUl9Q
Q0E5NDUwIGlzIG5vdCBzZXQKIyBDT05GSUdfUkVHVUxBVE9SX1BGOFgwMCBpcyBub3Qgc2V0CiMg
Q09ORklHX1JFR1VMQVRPUl9QRlVaRTEwMCBpcyBub3Qgc2V0CiMgQ09ORklHX1JFR1VMQVRPUl9Q
Vjg4MDYwIGlzIG5vdCBzZXQKIyBDT05GSUdfUkVHVUxBVE9SX1BWODgwODAgaXMgbm90IHNldAoj
IENPTkZJR19SRUdVTEFUT1JfUFY4ODA5MCBpcyBub3Qgc2V0CiMgQ09ORklHX1JFR1VMQVRPUl9S
QVNQQkVSUllQSV9UT1VDSFNDUkVFTl9BVFRJTlkgaXMgbm90IHNldAojIENPTkZJR19SRUdVTEFU
T1JfUlQ0ODAxIGlzIG5vdCBzZXQKIyBDT05GSUdfUkVHVUxBVE9SX1JUNTE5MEEgaXMgbm90IHNl
dAojIENPTkZJR19SRUdVTEFUT1JfUlQ1NzU5IGlzIG5vdCBzZXQKIyBDT05GSUdfUkVHVUxBVE9S
X1JUNjE2MCBpcyBub3Qgc2V0CiMgQ09ORklHX1JFR1VMQVRPUl9SVDYyNDUgaXMgbm90IHNldAoj
IENPTkZJR19SRUdVTEFUT1JfUlRRMjEzNCBpcyBub3Qgc2V0CiMgQ09ORklHX1JFR1VMQVRPUl9S
VE1WMjAgaXMgbm90IHNldAojIENPTkZJR19SRUdVTEFUT1JfUlRRNjc1MiBpcyBub3Qgc2V0CiMg
Q09ORklHX1JFR1VMQVRPUl9TTEc1MTAwMCBpcyBub3Qgc2V0CiMgQ09ORklHX1JFR1VMQVRPUl9T
WTc2MzZBIGlzIG5vdCBzZXQKIyBDT05GSUdfUkVHVUxBVE9SX1NZODEwNkEgaXMgbm90IHNldAoj
IENPTkZJR19SRUdVTEFUT1JfU1k4ODI0WCBpcyBub3Qgc2V0CiMgQ09ORklHX1JFR1VMQVRPUl9T
WTg4MjdOIGlzIG5vdCBzZXQKIyBDT05GSUdfUkVHVUxBVE9SX1RQUzUxNjMyIGlzIG5vdCBzZXQK
IyBDT05GSUdfUkVHVUxBVE9SX1RQUzYyMzYwIGlzIG5vdCBzZXQKIyBDT05GSUdfUkVHVUxBVE9S
X1RQUzYyODZYIGlzIG5vdCBzZXQKIyBDT05GSUdfUkVHVUxBVE9SX1RQUzY1MDIzIGlzIG5vdCBz
ZXQKIyBDT05GSUdfUkVHVUxBVE9SX1RQUzY1MDdYIGlzIG5vdCBzZXQKIyBDT05GSUdfUkVHVUxB
VE9SX1RQUzY1MTMyIGlzIG5vdCBzZXQKIyBDT05GSUdfUkVHVUxBVE9SX1ZDVFJMIGlzIG5vdCBz
ZXQKIyBDT05GSUdfUkNfQ09SRSBpcyBub3Qgc2V0CgojCiMgQ0VDIHN1cHBvcnQKIwojIENPTkZJ
R19NRURJQV9DRUNfU1VQUE9SVCBpcyBub3Qgc2V0CiMgZW5kIG9mIENFQyBzdXBwb3J0CgojIENP
TkZJR19NRURJQV9TVVBQT1JUIGlzIG5vdCBzZXQKCiMKIyBHcmFwaGljcyBzdXBwb3J0CiMKQ09O
RklHX0FQRVJUVVJFX0hFTFBFUlM9eQojIENPTkZJR19BR1AgaXMgbm90IHNldApDT05GSUdfRFJN
PW0KIyBDT05GSUdfRFJNX0RFQlVHX1NFTEZURVNUIGlzIG5vdCBzZXQKQ09ORklHX0RSTV9LTVNf
SEVMUEVSPW0KIyBDT05GSUdfRFJNX0RFQlVHX0RQX01TVF9UT1BPTE9HWV9SRUZTIGlzIG5vdCBz
ZXQKQ09ORklHX0RSTV9ERUJVR19NT0RFU0VUX0xPQ0s9eQpDT05GSUdfRFJNX0ZCREVWX0VNVUxB
VElPTj15CkNPTkZJR19EUk1fRkJERVZfT1ZFUkFMTE9DPTEwMAojIENPTkZJR19EUk1fRkJERVZf
TEVBS19QSFlTX1NNRU0gaXMgbm90IHNldApDT05GSUdfRFJNX0xPQURfRURJRF9GSVJNV0FSRT15
CkNPTkZJR19EUk1fRElTUExBWV9IRUxQRVI9bQpDT05GSUdfRFJNX0RJU1BMQVlfRFBfSEVMUEVS
PXkKQ09ORklHX0RSTV9EUF9BVVhfQ0hBUkRFVj15CiMgQ09ORklHX0RSTV9EUF9DRUMgaXMgbm90
IHNldApDT05GSUdfRFJNX1RUTT1tCkNPTkZJR19EUk1fVFRNX0hFTFBFUj1tCkNPTkZJR19EUk1f
R0VNX1NITUVNX0hFTFBFUj1tCgojCiMgSTJDIGVuY29kZXIgb3IgaGVscGVyIGNoaXBzCiMKQ09O
RklHX0RSTV9JMkNfQ0g3MDA2PW0KQ09ORklHX0RSTV9JMkNfU0lMMTY0PW0KIyBDT05GSUdfRFJN
X0kyQ19OWFBfVERBOTk4WCBpcyBub3Qgc2V0CiMgQ09ORklHX0RSTV9JMkNfTlhQX1REQTk5NTAg
aXMgbm90IHNldAojIGVuZCBvZiBJMkMgZW5jb2RlciBvciBoZWxwZXIgY2hpcHMKCiMKIyBBUk0g
ZGV2aWNlcwojCiMgZW5kIG9mIEFSTSBkZXZpY2VzCgpDT05GSUdfRFJNX1JBREVPTj1tCkNPTkZJ
R19EUk1fUkFERU9OX1VTRVJQVFI9eQojIENPTkZJR19EUk1fQU1ER1BVIGlzIG5vdCBzZXQKIyBD
T05GSUdfRFJNX05PVVZFQVUgaXMgbm90IHNldApDT05GSUdfRFJNX1ZHRU09bQojIENPTkZJR19E
Uk1fVktNUyBpcyBub3Qgc2V0CiMgQ09ORklHX0RSTV9VREwgaXMgbm90IHNldAojIENPTkZJR19E
Uk1fQVNUIGlzIG5vdCBzZXQKIyBDT05GSUdfRFJNX01HQUcyMDAgaXMgbm90IHNldAojIENPTkZJ
R19EUk1fUkNBUl9EV19IRE1JIGlzIG5vdCBzZXQKIyBDT05GSUdfRFJNX1JDQVJfVVNFX0xWRFMg
aXMgbm90IHNldAojIENPTkZJR19EUk1fUkNBUl9NSVBJX0RTSSBpcyBub3Qgc2V0CiMgQ09ORklH
X0RSTV9RWEwgaXMgbm90IHNldApDT05GSUdfRFJNX1BBTkVMPXkKCiMKIyBEaXNwbGF5IFBhbmVs
cwojCiMgQ09ORklHX0RSTV9QQU5FTF9MVkRTIGlzIG5vdCBzZXQKIyBDT05GSUdfRFJNX1BBTkVM
X1NJTVBMRSBpcyBub3Qgc2V0CiMgQ09ORklHX0RSTV9QQU5FTF9FRFAgaXMgbm90IHNldAojIENP
TkZJR19EUk1fUEFORUxfT0xJTUVYX0xDRF9PTElOVVhJTk8gaXMgbm90IHNldAojIENPTkZJR19E
Uk1fUEFORUxfU0FNU1VOR19BVE5BMzNYQzIwIGlzIG5vdCBzZXQKIyBDT05GSUdfRFJNX1BBTkVM
X1NBTVNVTkdfUzZFNjNNMCBpcyBub3Qgc2V0CiMgQ09ORklHX0RSTV9QQU5FTF9TQU1TVU5HX1M2
RTg4QTBfQU1TNDUyRUYwMSBpcyBub3Qgc2V0CiMgQ09ORklHX0RSTV9QQU5FTF9TQU1TVU5HX1M2
RThBQTAgaXMgbm90IHNldAojIENPTkZJR19EUk1fUEFORUxfU0VJS09fNDNXVkYxRyBpcyBub3Qg
c2V0CiMgQ09ORklHX0RSTV9QQU5FTF9TSEFSUF9MUzAzN1Y3RFcwMSBpcyBub3Qgc2V0CiMgZW5k
IG9mIERpc3BsYXkgUGFuZWxzCgpDT05GSUdfRFJNX0JSSURHRT15CkNPTkZJR19EUk1fUEFORUxf
QlJJREdFPXkKCiMKIyBEaXNwbGF5IEludGVyZmFjZSBCcmlkZ2VzCiMKIyBDT05GSUdfRFJNX0NE
TlNfRFNJIGlzIG5vdCBzZXQKIyBDT05GSUdfRFJNX0NISVBPTkVfSUNONjIxMSBpcyBub3Qgc2V0
CiMgQ09ORklHX0RSTV9DSFJPTlRFTF9DSDcwMzMgaXMgbm90IHNldApDT05GSUdfRFJNX0RJU1BM
QVlfQ09OTkVDVE9SPW0KIyBDT05GSUdfRFJNX0lURV9JVDY1MDUgaXMgbm90IHNldAojIENPTkZJ
R19EUk1fTE9OVElVTV9MVDg5MTJCIGlzIG5vdCBzZXQKIyBDT05GSUdfRFJNX0xPTlRJVU1fTFQ5
MjExIGlzIG5vdCBzZXQKIyBDT05GSUdfRFJNX0xPTlRJVU1fTFQ5NjExIGlzIG5vdCBzZXQKIyBD
T05GSUdfRFJNX0xPTlRJVU1fTFQ5NjExVVhDIGlzIG5vdCBzZXQKIyBDT05GSUdfRFJNX0lURV9J
VDY2MTIxIGlzIG5vdCBzZXQKIyBDT05GSUdfRFJNX0xWRFNfQ09ERUMgaXMgbm90IHNldAojIENP
TkZJR19EUk1fTUVHQUNISVBTX1NURFBYWFhYX0dFX0I4NTBWM19GVyBpcyBub3Qgc2V0CiMgQ09O
RklHX0RSTV9OWFBfUFROMzQ2MCBpcyBub3Qgc2V0CiMgQ09ORklHX0RSTV9QQVJBREVfUFM4NjIy
IGlzIG5vdCBzZXQKIyBDT05GSUdfRFJNX1BBUkFERV9QUzg2NDAgaXMgbm90IHNldAojIENPTkZJ
R19EUk1fU0lMX1NJSTg2MjAgaXMgbm90IHNldAojIENPTkZJR19EUk1fU0lJOTAyWCBpcyBub3Qg
c2V0CiMgQ09ORklHX0RSTV9TSUk5MjM0IGlzIG5vdCBzZXQKQ09ORklHX0RSTV9TSU1QTEVfQlJJ
REdFPW0KIyBDT05GSUdfRFJNX1RISU5FX1RIQzYzTFZEMTAyNCBpcyBub3Qgc2V0CiMgQ09ORklH
X0RSTV9UT1NISUJBX1RDMzU4NzYyIGlzIG5vdCBzZXQKIyBDT05GSUdfRFJNX1RPU0hJQkFfVEMz
NTg3NjQgaXMgbm90IHNldAojIENPTkZJR19EUk1fVE9TSElCQV9UQzM1ODc2NyBpcyBub3Qgc2V0
CiMgQ09ORklHX0RSTV9UT1NISUJBX1RDMzU4NzY4IGlzIG5vdCBzZXQKIyBDT05GSUdfRFJNX1RP
U0hJQkFfVEMzNTg3NzUgaXMgbm90IHNldAojIENPTkZJR19EUk1fVElfRExQQzM0MzMgaXMgbm90
IHNldAojIENPTkZJR19EUk1fVElfVEZQNDEwIGlzIG5vdCBzZXQKIyBDT05GSUdfRFJNX1RJX1NO
NjVEU0k4MyBpcyBub3Qgc2V0CiMgQ09ORklHX0RSTV9USV9TTjY1RFNJODYgaXMgbm90IHNldAoj
IENPTkZJR19EUk1fVElfVFBEMTJTMDE1IGlzIG5vdCBzZXQKIyBDT05GSUdfRFJNX0FOQUxPR0lY
X0FOWDYzNDUgaXMgbm90IHNldAojIENPTkZJR19EUk1fQU5BTE9HSVhfQU5YNzhYWCBpcyBub3Qg
c2V0CiMgQ09ORklHX0RSTV9BTkFMT0dJWF9BTlg3NjI1IGlzIG5vdCBzZXQKIyBDT05GSUdfRFJN
X0kyQ19BRFY3NTExIGlzIG5vdCBzZXQKIyBDT05GSUdfRFJNX0NETlNfTUhEUDg1NDYgaXMgbm90
IHNldAojIGVuZCBvZiBEaXNwbGF5IEludGVyZmFjZSBCcmlkZ2VzCgojIENPTkZJR19EUk1fRVRO
QVZJViBpcyBub3Qgc2V0CiMgQ09ORklHX0RSTV9MT0dJQ1ZDIGlzIG5vdCBzZXQKIyBDT05GSUdf
RFJNX0FSQ1BHVSBpcyBub3Qgc2V0CiMgQ09ORklHX0RSTV9CT0NIUyBpcyBub3Qgc2V0CiMgQ09O
RklHX0RSTV9DSVJSVVNfUUVNVSBpcyBub3Qgc2V0CiMgQ09ORklHX0RSTV9HTTEyVTMyMCBpcyBu
b3Qgc2V0CiMgQ09ORklHX0RSTV9TSU1QTEVEUk0gaXMgbm90IHNldAojIENPTkZJR19EUk1fR1VE
IGlzIG5vdCBzZXQKIyBDT05GSUdfRFJNX1NTRDEzMFggaXMgbm90IHNldAojIENPTkZJR19EUk1f
TEVHQUNZIGlzIG5vdCBzZXQKQ09ORklHX0RSTV9QQU5FTF9PUklFTlRBVElPTl9RVUlSS1M9bQpD
T05GSUdfRFJNX05PTU9ERVNFVD15CgojCiMgRnJhbWUgYnVmZmVyIERldmljZXMKIwpDT05GSUdf
RkJfQ01ETElORT15CkNPTkZJR19GQl9OT1RJRlk9eQpDT05GSUdfRkI9eQpDT05GSUdfRklSTVdB
UkVfRURJRD15CkNPTkZJR19GQl9DRkJfRklMTFJFQ1Q9eQpDT05GSUdfRkJfQ0ZCX0NPUFlBUkVB
PXkKQ09ORklHX0ZCX0NGQl9JTUFHRUJMSVQ9eQpDT05GSUdfRkJfU1lTX0ZJTExSRUNUPW0KQ09O
RklHX0ZCX1NZU19DT1BZQVJFQT1tCkNPTkZJR19GQl9TWVNfSU1BR0VCTElUPW0KIyBDT05GSUdf
RkJfRk9SRUlHTl9FTkRJQU4gaXMgbm90IHNldApDT05GSUdfRkJfU1lTX0ZPUFM9bQpDT05GSUdf
RkJfREVGRVJSRURfSU89eQpDT05GSUdfRkJfTUFDTU9ERVM9eQpDT05GSUdfRkJfQkFDS0xJR0hU
PXkKQ09ORklHX0ZCX01PREVfSEVMUEVSUz15CkNPTkZJR19GQl9USUxFQkxJVFRJTkc9eQoKIwoj
IEZyYW1lIGJ1ZmZlciBoYXJkd2FyZSBkcml2ZXJzCiMKIyBDT05GSUdfRkJfQ0lSUlVTIGlzIG5v
dCBzZXQKIyBDT05GSUdfRkJfUE0yIGlzIG5vdCBzZXQKIyBDT05GSUdfRkJfQ1lCRVIyMDAwIGlz
IG5vdCBzZXQKQ09ORklHX0ZCX09GPXkKIyBDT05GSUdfRkJfQ09OVFJPTCBpcyBub3Qgc2V0CiMg
Q09ORklHX0ZCX1BMQVRJTlVNIGlzIG5vdCBzZXQKIyBDT05GSUdfRkJfVkFMS1lSSUUgaXMgbm90
IHNldApDT05GSUdfRkJfQ1Q2NTU1MD15CiMgQ09ORklHX0ZCX0FTSUxJQU5UIGlzIG5vdCBzZXQK
IyBDT05GSUdfRkJfSU1TVFQgaXMgbm90IHNldAojIENPTkZJR19GQl9WR0ExNiBpcyBub3Qgc2V0
CiMgQ09ORklHX0ZCX09QRU5DT1JFUyBpcyBub3Qgc2V0CiMgQ09ORklHX0ZCX1MxRDEzWFhYIGlz
IG5vdCBzZXQKIyBDT05GSUdfRkJfTlZJRElBIGlzIG5vdCBzZXQKIyBDT05GSUdfRkJfUklWQSBp
cyBub3Qgc2V0CiMgQ09ORklHX0ZCX0k3NDAgaXMgbm90IHNldAojIENPTkZJR19GQl9NQVRST1gg
aXMgbm90IHNldAojIENPTkZJR19GQl9SQURFT04gaXMgbm90IHNldAojIENPTkZJR19GQl9BVFkx
MjggaXMgbm90IHNldAojIENPTkZJR19GQl9BVFkgaXMgbm90IHNldAojIENPTkZJR19GQl9TMyBp
cyBub3Qgc2V0CiMgQ09ORklHX0ZCX1NBVkFHRSBpcyBub3Qgc2V0CiMgQ09ORklHX0ZCX1NJUyBp
cyBub3Qgc2V0CiMgQ09ORklHX0ZCX05FT01BR0lDIGlzIG5vdCBzZXQKIyBDT05GSUdfRkJfS1lS
TyBpcyBub3Qgc2V0CiMgQ09ORklHX0ZCXzNERlggaXMgbm90IHNldAojIENPTkZJR19GQl9WT09E
T08xIGlzIG5vdCBzZXQKIyBDT05GSUdfRkJfVlQ4NjIzIGlzIG5vdCBzZXQKIyBDT05GSUdfRkJf
VFJJREVOVCBpcyBub3Qgc2V0CiMgQ09ORklHX0ZCX0FSSyBpcyBub3Qgc2V0CiMgQ09ORklHX0ZC
X1BNMyBpcyBub3Qgc2V0CiMgQ09ORklHX0ZCX0NBUk1JTkUgaXMgbm90IHNldAojIENPTkZJR19G
Ql9TTVNDVUZYIGlzIG5vdCBzZXQKIyBDT05GSUdfRkJfVURMIGlzIG5vdCBzZXQKIyBDT05GSUdf
RkJfSUJNX0dYVDQ1MDAgaXMgbm90IHNldAojIENPTkZJR19GQl9WSVJUVUFMIGlzIG5vdCBzZXQK
IyBDT05GSUdfRkJfTUVUUk9OT01FIGlzIG5vdCBzZXQKIyBDT05GSUdfRkJfTUI4NjJYWCBpcyBu
b3Qgc2V0CiMgQ09ORklHX0ZCX1NJTVBMRSBpcyBub3Qgc2V0CiMgQ09ORklHX0ZCX1NTRDEzMDcg
aXMgbm90IHNldAojIENPTkZJR19GQl9TTTcxMiBpcyBub3Qgc2V0CiMgZW5kIG9mIEZyYW1lIGJ1
ZmZlciBEZXZpY2VzCgojCiMgQmFja2xpZ2h0ICYgTENEIGRldmljZSBzdXBwb3J0CiMKIyBDT05G
SUdfTENEX0NMQVNTX0RFVklDRSBpcyBub3Qgc2V0CkNPTkZJR19CQUNLTElHSFRfQ0xBU1NfREVW
SUNFPXkKIyBDT05GSUdfQkFDS0xJR0hUX0tURDI1MyBpcyBub3Qgc2V0CiMgQ09ORklHX0JBQ0tM
SUdIVF9RQ09NX1dMRUQgaXMgbm90IHNldAojIENPTkZJR19CQUNLTElHSFRfQURQODg2MCBpcyBu
b3Qgc2V0CiMgQ09ORklHX0JBQ0tMSUdIVF9BRFA4ODcwIGlzIG5vdCBzZXQKIyBDT05GSUdfQkFD
S0xJR0hUX0xNMzYzOSBpcyBub3Qgc2V0CiMgQ09ORklHX0JBQ0tMSUdIVF9HUElPIGlzIG5vdCBz
ZXQKIyBDT05GSUdfQkFDS0xJR0hUX0xWNTIwN0xQIGlzIG5vdCBzZXQKIyBDT05GSUdfQkFDS0xJ
R0hUX0JENjEwNyBpcyBub3Qgc2V0CiMgQ09ORklHX0JBQ0tMSUdIVF9BUkNYQ05OIGlzIG5vdCBz
ZXQKQ09ORklHX0JBQ0tMSUdIVF9MRUQ9bQojIGVuZCBvZiBCYWNrbGlnaHQgJiBMQ0QgZGV2aWNl
IHN1cHBvcnQKCkNPTkZJR19IRE1JPXkKCiMKIyBDb25zb2xlIGRpc3BsYXkgZHJpdmVyIHN1cHBv
cnQKIwpDT05GSUdfVkdBX0NPTlNPTEU9eQpDT05GSUdfRFVNTVlfQ09OU09MRT15CkNPTkZJR19E
VU1NWV9DT05TT0xFX0NPTFVNTlM9ODAKQ09ORklHX0RVTU1ZX0NPTlNPTEVfUk9XUz0yNQpDT05G
SUdfRlJBTUVCVUZGRVJfQ09OU09MRT15CiMgQ09ORklHX0ZSQU1FQlVGRkVSX0NPTlNPTEVfTEVH
QUNZX0FDQ0VMRVJBVElPTiBpcyBub3Qgc2V0CkNPTkZJR19GUkFNRUJVRkZFUl9DT05TT0xFX0RF
VEVDVF9QUklNQVJZPXkKQ09ORklHX0ZSQU1FQlVGRkVSX0NPTlNPTEVfUk9UQVRJT049eQojIENP
TkZJR19GUkFNRUJVRkZFUl9DT05TT0xFX0RFRkVSUkVEX1RBS0VPVkVSIGlzIG5vdCBzZXQKIyBl
bmQgb2YgQ29uc29sZSBkaXNwbGF5IGRyaXZlciBzdXBwb3J0CgojIENPTkZJR19MT0dPIGlzIG5v
dCBzZXQKIyBlbmQgb2YgR3JhcGhpY3Mgc3VwcG9ydAoKQ09ORklHX1NPVU5EPW0KQ09ORklHX1NO
RD1tCkNPTkZJR19TTkRfVElNRVI9bQpDT05GSUdfU05EX1BDTT1tCkNPTkZJR19TTkRfSFdERVA9
bQpDT05GSUdfU05EX1NFUV9ERVZJQ0U9bQpDT05GSUdfU05EX1JBV01JREk9bQpDT05GSUdfU05E
X0pBQ0s9eQpDT05GSUdfU05EX0pBQ0tfSU5QVVRfREVWPXkKIyBDT05GSUdfU05EX09TU0VNVUwg
aXMgbm90IHNldApDT05GSUdfU05EX1BDTV9USU1FUj15CkNPTkZJR19TTkRfSFJUSU1FUj1tCkNP
TkZJR19TTkRfRFlOQU1JQ19NSU5PUlM9eQpDT05GSUdfU05EX01BWF9DQVJEUz00CiMgQ09ORklH
X1NORF9TVVBQT1JUX09MRF9BUEkgaXMgbm90IHNldApDT05GSUdfU05EX1BST0NfRlM9eQpDT05G
SUdfU05EX1ZFUkJPU0VfUFJPQ0ZTPXkKIyBDT05GSUdfU05EX1ZFUkJPU0VfUFJJTlRLIGlzIG5v
dCBzZXQKIyBDT05GSUdfU05EX0NUTF9GQVNUX0xPT0tVUCBpcyBub3Qgc2V0CiMgQ09ORklHX1NO
RF9ERUJVRyBpcyBub3Qgc2V0CkNPTkZJR19TTkRfQ1RMX0lOUFVUX1ZBTElEQVRJT049eQpDT05G
SUdfU05EX1ZNQVNURVI9eQpDT05GSUdfU05EX1NFUVVFTkNFUj1tCkNPTkZJR19TTkRfU0VRX0RV
TU1ZPW0KQ09ORklHX1NORF9TRVFfSFJUSU1FUl9ERUZBVUxUPXkKQ09ORklHX1NORF9TRVFfTUlE
SV9FVkVOVD1tCkNPTkZJR19TTkRfU0VRX01JREk9bQpDT05GSUdfU05EX1NFUV9WSVJNSURJPW0K
Q09ORklHX1NORF9EUklWRVJTPXkKIyBDT05GSUdfU05EX0RVTU1ZIGlzIG5vdCBzZXQKQ09ORklH
X1NORF9BTE9PUD1tCkNPTkZJR19TTkRfVklSTUlEST1tCiMgQ09ORklHX1NORF9NVFBBViBpcyBu
b3Qgc2V0CiMgQ09ORklHX1NORF9TRVJJQUxfVTE2NTUwIGlzIG5vdCBzZXQKIyBDT05GSUdfU05E
X1NFUklBTF9HRU5FUklDIGlzIG5vdCBzZXQKIyBDT05GSUdfU05EX01QVTQwMSBpcyBub3Qgc2V0
CkNPTkZJR19TTkRfUENJPXkKIyBDT05GSUdfU05EX0FEMTg4OSBpcyBub3Qgc2V0CiMgQ09ORklH
X1NORF9BTFMzMDAgaXMgbm90IHNldAojIENPTkZJR19TTkRfQUxTNDAwMCBpcyBub3Qgc2V0CiMg
Q09ORklHX1NORF9BTEk1NDUxIGlzIG5vdCBzZXQKIyBDT05GSUdfU05EX0FUSUlYUCBpcyBub3Qg
c2V0CiMgQ09ORklHX1NORF9BVElJWFBfTU9ERU0gaXMgbm90IHNldAojIENPTkZJR19TTkRfQVU4
ODEwIGlzIG5vdCBzZXQKIyBDT05GSUdfU05EX0FVODgyMCBpcyBub3Qgc2V0CiMgQ09ORklHX1NO
RF9BVTg4MzAgaXMgbm90IHNldAojIENPTkZJR19TTkRfQVcyIGlzIG5vdCBzZXQKIyBDT05GSUdf
U05EX0FaVDMzMjggaXMgbm90IHNldAojIENPTkZJR19TTkRfQlQ4N1ggaXMgbm90IHNldAojIENP
TkZJR19TTkRfQ0EwMTA2IGlzIG5vdCBzZXQKIyBDT05GSUdfU05EX0NNSVBDSSBpcyBub3Qgc2V0
CiMgQ09ORklHX1NORF9PWFlHRU4gaXMgbm90IHNldAojIENPTkZJR19TTkRfQ1M0MjgxIGlzIG5v
dCBzZXQKIyBDT05GSUdfU05EX0NTNDZYWCBpcyBub3Qgc2V0CiMgQ09ORklHX1NORF9DVFhGSSBp
cyBub3Qgc2V0CiMgQ09ORklHX1NORF9EQVJMQTIwIGlzIG5vdCBzZXQKIyBDT05GSUdfU05EX0dJ
TkEyMCBpcyBub3Qgc2V0CiMgQ09ORklHX1NORF9MQVlMQTIwIGlzIG5vdCBzZXQKIyBDT05GSUdf
U05EX0RBUkxBMjQgaXMgbm90IHNldAojIENPTkZJR19TTkRfR0lOQTI0IGlzIG5vdCBzZXQKIyBD
T05GSUdfU05EX0xBWUxBMjQgaXMgbm90IHNldAojIENPTkZJR19TTkRfTU9OQSBpcyBub3Qgc2V0
CiMgQ09ORklHX1NORF9NSUEgaXMgbm90IHNldAojIENPTkZJR19TTkRfRUNITzNHIGlzIG5vdCBz
ZXQKIyBDT05GSUdfU05EX0lORElHTyBpcyBub3Qgc2V0CiMgQ09ORklHX1NORF9JTkRJR09JTyBp
cyBub3Qgc2V0CiMgQ09ORklHX1NORF9JTkRJR09ESiBpcyBub3Qgc2V0CiMgQ09ORklHX1NORF9J
TkRJR09JT1ggaXMgbm90IHNldAojIENPTkZJR19TTkRfSU5ESUdPREpYIGlzIG5vdCBzZXQKIyBD
T05GSUdfU05EX0VNVTEwSzEgaXMgbm90IHNldAojIENPTkZJR19TTkRfRU1VMTBLMVggaXMgbm90
IHNldAojIENPTkZJR19TTkRfRU5TMTM3MCBpcyBub3Qgc2V0CiMgQ09ORklHX1NORF9FTlMxMzcx
IGlzIG5vdCBzZXQKIyBDT05GSUdfU05EX0VTMTkzOCBpcyBub3Qgc2V0CiMgQ09ORklHX1NORF9F
UzE5NjggaXMgbm90IHNldAojIENPTkZJR19TTkRfRk04MDEgaXMgbm90IHNldAojIENPTkZJR19T
TkRfSERTUCBpcyBub3Qgc2V0CiMgQ09ORklHX1NORF9IRFNQTSBpcyBub3Qgc2V0CiMgQ09ORklH
X1NORF9JQ0UxNzEyIGlzIG5vdCBzZXQKIyBDT05GSUdfU05EX0lDRTE3MjQgaXMgbm90IHNldAoj
IENPTkZJR19TTkRfSU5URUw4WDAgaXMgbm90IHNldAojIENPTkZJR19TTkRfSU5URUw4WDBNIGlz
IG5vdCBzZXQKIyBDT05GSUdfU05EX0tPUkcxMjEyIGlzIG5vdCBzZXQKIyBDT05GSUdfU05EX0xP
TEEgaXMgbm90IHNldAojIENPTkZJR19TTkRfTFg2NDY0RVMgaXMgbm90IHNldAojIENPTkZJR19T
TkRfTUFFU1RSTzMgaXMgbm90IHNldAojIENPTkZJR19TTkRfTUlYQVJUIGlzIG5vdCBzZXQKIyBD
T05GSUdfU05EX05NMjU2IGlzIG5vdCBzZXQKIyBDT05GSUdfU05EX1BDWEhSIGlzIG5vdCBzZXQK
IyBDT05GSUdfU05EX1JJUFRJREUgaXMgbm90IHNldAojIENPTkZJR19TTkRfUk1FMzIgaXMgbm90
IHNldAojIENPTkZJR19TTkRfUk1FOTYgaXMgbm90IHNldAojIENPTkZJR19TTkRfUk1FOTY1MiBp
cyBub3Qgc2V0CiMgQ09ORklHX1NORF9TRTZYIGlzIG5vdCBzZXQKIyBDT05GSUdfU05EX1NPTklD
VklCRVMgaXMgbm90IHNldAojIENPTkZJR19TTkRfVFJJREVOVCBpcyBub3Qgc2V0CiMgQ09ORklH
X1NORF9WSUE4MlhYIGlzIG5vdCBzZXQKIyBDT05GSUdfU05EX1ZJQTgyWFhfTU9ERU0gaXMgbm90
IHNldAojIENPTkZJR19TTkRfVklSVFVPU08gaXMgbm90IHNldAojIENPTkZJR19TTkRfVlgyMjIg
aXMgbm90IHNldAojIENPTkZJR19TTkRfWU1GUENJIGlzIG5vdCBzZXQKCiMKIyBIRC1BdWRpbwoj
CkNPTkZJR19TTkRfSERBPW0KQ09ORklHX1NORF9IREFfSU5URUw9bQpDT05GSUdfU05EX0hEQV9I
V0RFUD15CkNPTkZJR19TTkRfSERBX1JFQ09ORklHPXkKIyBDT05GSUdfU05EX0hEQV9JTlBVVF9C
RUVQIGlzIG5vdCBzZXQKIyBDT05GSUdfU05EX0hEQV9QQVRDSF9MT0FERVIgaXMgbm90IHNldAoj
IENPTkZJR19TTkRfSERBX0NPREVDX1JFQUxURUsgaXMgbm90IHNldAojIENPTkZJR19TTkRfSERB
X0NPREVDX0FOQUxPRyBpcyBub3Qgc2V0CiMgQ09ORklHX1NORF9IREFfQ09ERUNfU0lHTUFURUwg
aXMgbm90IHNldAojIENPTkZJR19TTkRfSERBX0NPREVDX1ZJQSBpcyBub3Qgc2V0CkNPTkZJR19T
TkRfSERBX0NPREVDX0hETUk9bQojIENPTkZJR19TTkRfSERBX0NPREVDX0NJUlJVUyBpcyBub3Qg
c2V0CiMgQ09ORklHX1NORF9IREFfQ09ERUNfQ1M4NDA5IGlzIG5vdCBzZXQKIyBDT05GSUdfU05E
X0hEQV9DT0RFQ19DT05FWEFOVCBpcyBub3Qgc2V0CiMgQ09ORklHX1NORF9IREFfQ09ERUNfQ0Ew
MTEwIGlzIG5vdCBzZXQKIyBDT05GSUdfU05EX0hEQV9DT0RFQ19DQTAxMzIgaXMgbm90IHNldAoj
IENPTkZJR19TTkRfSERBX0NPREVDX0NNRURJQSBpcyBub3Qgc2V0CiMgQ09ORklHX1NORF9IREFf
Q09ERUNfU0kzMDU0IGlzIG5vdCBzZXQKIyBDT05GSUdfU05EX0hEQV9HRU5FUklDIGlzIG5vdCBz
ZXQKQ09ORklHX1NORF9IREFfUE9XRVJfU0FWRV9ERUZBVUxUPTAKIyBDT05GSUdfU05EX0hEQV9J
TlRFTF9IRE1JX1NJTEVOVF9TVFJFQU0gaXMgbm90IHNldAojIGVuZCBvZiBIRC1BdWRpbwoKQ09O
RklHX1NORF9IREFfQ09SRT1tCkNPTkZJR19TTkRfSERBX1BSRUFMTE9DX1NJWkU9MjA0OApDT05G
SUdfU05EX0lOVEVMX0RTUF9DT05GSUc9bQojIENPTkZJR19TTkRfUFBDIGlzIG5vdCBzZXQKQ09O
RklHX1NORF9BT0E9bQpDT05GSUdfU05EX0FPQV9GQUJSSUNfTEFZT1VUPW0KQ09ORklHX1NORF9B
T0FfT05ZWD1tCkNPTkZJR19TTkRfQU9BX1RBUz1tCkNPTkZJR19TTkRfQU9BX1RPT05JRT1tCkNP
TkZJR19TTkRfQU9BX1NPVU5EQlVTPW0KQ09ORklHX1NORF9BT0FfU09VTkRCVVNfSTJTPW0KIyBD
T05GSUdfU05EX1VTQiBpcyBub3Qgc2V0CkNPTkZJR19TTkRfRklSRVdJUkU9eQpDT05GSUdfU05E
X0ZJUkVXSVJFX0xJQj1tCiMgQ09ORklHX1NORF9ESUNFIGlzIG5vdCBzZXQKIyBDT05GSUdfU05E
X09YRlcgaXMgbm90IHNldApDT05GSUdfU05EX0lTSUdIVD1tCiMgQ09ORklHX1NORF9GSVJFV09S
S1MgaXMgbm90IHNldAojIENPTkZJR19TTkRfQkVCT0IgaXMgbm90IHNldAojIENPTkZJR19TTkRf
RklSRVdJUkVfRElHSTAwWCBpcyBub3Qgc2V0CiMgQ09ORklHX1NORF9GSVJFV0lSRV9UQVNDQU0g
aXMgbm90IHNldAojIENPTkZJR19TTkRfRklSRVdJUkVfTU9UVSBpcyBub3Qgc2V0CiMgQ09ORklH
X1NORF9GSVJFRkFDRSBpcyBub3Qgc2V0CiMgQ09ORklHX1NORF9QQ01DSUEgaXMgbm90IHNldAoj
IENPTkZJR19TTkRfU09DIGlzIG5vdCBzZXQKIyBDT05GSUdfU05EX1ZJUlRJTyBpcyBub3Qgc2V0
CgojCiMgSElEIHN1cHBvcnQKIwpDT05GSUdfSElEPW0KQ09ORklHX0hJRF9CQVRURVJZX1NUUkVO
R1RIPXkKQ09ORklHX0hJRFJBVz15CkNPTkZJR19VSElEPW0KQ09ORklHX0hJRF9HRU5FUklDPW0K
CiMKIyBTcGVjaWFsIEhJRCBkcml2ZXJzCiMKIyBDT05GSUdfSElEX0E0VEVDSCBpcyBub3Qgc2V0
CiMgQ09ORklHX0hJRF9BQ0NVVE9VQ0ggaXMgbm90IHNldAojIENPTkZJR19ISURfQUNSVVggaXMg
bm90IHNldApDT05GSUdfSElEX0FQUExFPW0KIyBDT05GSUdfSElEX0FQUExFSVIgaXMgbm90IHNl
dAojIENPTkZJR19ISURfQVNVUyBpcyBub3Qgc2V0CiMgQ09ORklHX0hJRF9BVVJFQUwgaXMgbm90
IHNldAojIENPTkZJR19ISURfQkVMS0lOIGlzIG5vdCBzZXQKIyBDT05GSUdfSElEX0JFVE9QX0ZG
IGlzIG5vdCBzZXQKIyBDT05GSUdfSElEX0JJR0JFTl9GRiBpcyBub3Qgc2V0CiMgQ09ORklHX0hJ
RF9DSEVSUlkgaXMgbm90IHNldAojIENPTkZJR19ISURfQ0hJQ09OWSBpcyBub3Qgc2V0CiMgQ09O
RklHX0hJRF9DT1JTQUlSIGlzIG5vdCBzZXQKIyBDT05GSUdfSElEX0NPVUdBUiBpcyBub3Qgc2V0
CiMgQ09ORklHX0hJRF9NQUNBTExZIGlzIG5vdCBzZXQKIyBDT05GSUdfSElEX1BST0RJS0VZUyBp
cyBub3Qgc2V0CiMgQ09ORklHX0hJRF9DTUVESUEgaXMgbm90IHNldAojIENPTkZJR19ISURfQ1Ay
MTEyIGlzIG5vdCBzZXQKIyBDT05GSUdfSElEX0NSRUFUSVZFX1NCMDU0MCBpcyBub3Qgc2V0CiMg
Q09ORklHX0hJRF9DWVBSRVNTIGlzIG5vdCBzZXQKIyBDT05GSUdfSElEX0RSQUdPTlJJU0UgaXMg
bm90IHNldAojIENPTkZJR19ISURfRU1TX0ZGIGlzIG5vdCBzZXQKIyBDT05GSUdfSElEX0VMQU4g
aXMgbm90IHNldAojIENPTkZJR19ISURfRUxFQ09NIGlzIG5vdCBzZXQKIyBDT05GSUdfSElEX0VM
TyBpcyBub3Qgc2V0CiMgQ09ORklHX0hJRF9FWktFWSBpcyBub3Qgc2V0CiMgQ09ORklHX0hJRF9G
VDI2MCBpcyBub3Qgc2V0CiMgQ09ORklHX0hJRF9HRU1CSVJEIGlzIG5vdCBzZXQKIyBDT05GSUdf
SElEX0dGUk0gaXMgbm90IHNldAojIENPTkZJR19ISURfR0xPUklPVVMgaXMgbm90IHNldAojIENP
TkZJR19ISURfSE9MVEVLIGlzIG5vdCBzZXQKIyBDT05GSUdfSElEX1ZJVkFMREkgaXMgbm90IHNl
dAojIENPTkZJR19ISURfR1Q2ODNSIGlzIG5vdCBzZXQKIyBDT05GSUdfSElEX0tFWVRPVUNIIGlz
IG5vdCBzZXQKIyBDT05GSUdfSElEX0tZRSBpcyBub3Qgc2V0CiMgQ09ORklHX0hJRF9VQ0xPR0lD
IGlzIG5vdCBzZXQKIyBDT05GSUdfSElEX1dBTFRPUCBpcyBub3Qgc2V0CiMgQ09ORklHX0hJRF9W
SUVXU09OSUMgaXMgbm90IHNldAojIENPTkZJR19ISURfWElBT01JIGlzIG5vdCBzZXQKIyBDT05G
SUdfSElEX0dZUkFUSU9OIGlzIG5vdCBzZXQKIyBDT05GSUdfSElEX0lDQURFIGlzIG5vdCBzZXQK
IyBDT05GSUdfSElEX0lURSBpcyBub3Qgc2V0CiMgQ09ORklHX0hJRF9KQUJSQSBpcyBub3Qgc2V0
CiMgQ09ORklHX0hJRF9UV0lOSEFOIGlzIG5vdCBzZXQKIyBDT05GSUdfSElEX0tFTlNJTkdUT04g
aXMgbm90IHNldAojIENPTkZJR19ISURfTENQT1dFUiBpcyBub3Qgc2V0CiMgQ09ORklHX0hJRF9M
RUQgaXMgbm90IHNldAojIENPTkZJR19ISURfTEVOT1ZPIGlzIG5vdCBzZXQKIyBDT05GSUdfSElE
X0xFVFNLRVRDSCBpcyBub3Qgc2V0CiMgQ09ORklHX0hJRF9MT0dJVEVDSCBpcyBub3Qgc2V0CkNP
TkZJR19ISURfTUFHSUNNT1VTRT1tCiMgQ09ORklHX0hJRF9NQUxUUk9OIGlzIG5vdCBzZXQKIyBD
T05GSUdfSElEX01BWUZMQVNIIGlzIG5vdCBzZXQKIyBDT05GSUdfSElEX01FR0FXT1JMRF9GRiBp
cyBub3Qgc2V0CiMgQ09ORklHX0hJRF9SRURSQUdPTiBpcyBub3Qgc2V0CkNPTkZJR19ISURfTUlD
Uk9TT0ZUPW0KIyBDT05GSUdfSElEX01PTlRFUkVZIGlzIG5vdCBzZXQKIyBDT05GSUdfSElEX01V
TFRJVE9VQ0ggaXMgbm90IHNldApDT05GSUdfSElEX05JTlRFTkRPPW0KIyBDT05GSUdfTklOVEVO
RE9fRkYgaXMgbm90IHNldAojIENPTkZJR19ISURfTlRJIGlzIG5vdCBzZXQKIyBDT05GSUdfSElE
X05UUklHIGlzIG5vdCBzZXQKIyBDT05GSUdfSElEX09SVEVLIGlzIG5vdCBzZXQKIyBDT05GSUdf
SElEX1BBTlRIRVJMT1JEIGlzIG5vdCBzZXQKIyBDT05GSUdfSElEX1BFTk1PVU5UIGlzIG5vdCBz
ZXQKIyBDT05GSUdfSElEX1BFVEFMWU5YIGlzIG5vdCBzZXQKIyBDT05GSUdfSElEX1BJQ09MQ0Qg
aXMgbm90IHNldAojIENPTkZJR19ISURfUExBTlRST05JQ1MgaXMgbm90IHNldAojIENPTkZJR19I
SURfUkFaRVIgaXMgbm90IHNldAojIENPTkZJR19ISURfUFJJTUFYIGlzIG5vdCBzZXQKIyBDT05G
SUdfSElEX1JFVFJPREUgaXMgbm90IHNldApDT05GSUdfSElEX1JPQ0NBVD1tCiMgQ09ORklHX0hJ
RF9TQUlURUsgaXMgbm90IHNldAojIENPTkZJR19ISURfU0FNU1VORyBpcyBub3Qgc2V0CiMgQ09O
RklHX0hJRF9TRU1JVEVLIGlzIG5vdCBzZXQKIyBDT05GSUdfSElEX1NJR01BTUlDUk8gaXMgbm90
IHNldAojIENPTkZJR19ISURfU09OWSBpcyBub3Qgc2V0CiMgQ09ORklHX0hJRF9TUEVFRExJTksg
aXMgbm90IHNldAojIENPTkZJR19ISURfU1RFQU0gaXMgbm90IHNldAojIENPTkZJR19ISURfU1RF
RUxTRVJJRVMgaXMgbm90IHNldAojIENPTkZJR19ISURfU1VOUExVUyBpcyBub3Qgc2V0CiMgQ09O
RklHX0hJRF9STUkgaXMgbm90IHNldAojIENPTkZJR19ISURfR1JFRU5BU0lBIGlzIG5vdCBzZXQK
IyBDT05GSUdfSElEX1NNQVJUSk9ZUExVUyBpcyBub3Qgc2V0CiMgQ09ORklHX0hJRF9USVZPIGlz
IG5vdCBzZXQKIyBDT05GSUdfSElEX1RPUFNFRUQgaXMgbm90IHNldAojIENPTkZJR19ISURfVE9Q
UkUgaXMgbm90IHNldAojIENPTkZJR19ISURfVEhJTkdNIGlzIG5vdCBzZXQKIyBDT05GSUdfSElE
X1RIUlVTVE1BU1RFUiBpcyBub3Qgc2V0CiMgQ09ORklHX0hJRF9VRFJBV19QUzMgaXMgbm90IHNl
dAojIENPTkZJR19ISURfV0FDT00gaXMgbm90IHNldAojIENPTkZJR19ISURfV0lJTU9URSBpcyBu
b3Qgc2V0CiMgQ09ORklHX0hJRF9YSU5NTyBpcyBub3Qgc2V0CiMgQ09ORklHX0hJRF9aRVJPUExV
UyBpcyBub3Qgc2V0CiMgQ09ORklHX0hJRF9aWURBQ1JPTiBpcyBub3Qgc2V0CiMgQ09ORklHX0hJ
RF9TRU5TT1JfSFVCIGlzIG5vdCBzZXQKIyBDT05GSUdfSElEX0FMUFMgaXMgbm90IHNldAojIENP
TkZJR19ISURfTUNQMjIyMSBpcyBub3Qgc2V0CiMgZW5kIG9mIFNwZWNpYWwgSElEIGRyaXZlcnMK
CiMKIyBVU0IgSElEIHN1cHBvcnQKIwpDT05GSUdfVVNCX0hJRD1tCkNPTkZJR19ISURfUElEPXkK
Q09ORklHX1VTQl9ISURERVY9eQoKIwojIFVTQiBISUQgQm9vdCBQcm90b2NvbCBkcml2ZXJzCiMK
IyBDT05GSUdfVVNCX0tCRCBpcyBub3Qgc2V0CiMgQ09ORklHX1VTQl9NT1VTRSBpcyBub3Qgc2V0
CiMgZW5kIG9mIFVTQiBISUQgQm9vdCBQcm90b2NvbCBkcml2ZXJzCiMgZW5kIG9mIFVTQiBISUQg
c3VwcG9ydAoKIwojIEkyQyBISUQgc3VwcG9ydAojCiMgQ09ORklHX0kyQ19ISURfT0YgaXMgbm90
IHNldAojIENPTkZJR19JMkNfSElEX09GX0VMQU4gaXMgbm90IHNldAojIENPTkZJR19JMkNfSElE
X09GX0dPT0RJWCBpcyBub3Qgc2V0CiMgZW5kIG9mIEkyQyBISUQgc3VwcG9ydAojIGVuZCBvZiBI
SUQgc3VwcG9ydAoKQ09ORklHX1VTQl9PSENJX0JJR19FTkRJQU5fREVTQz15CkNPTkZJR19VU0Jf
T0hDSV9CSUdfRU5ESUFOX01NSU89eQpDT05GSUdfVVNCX09IQ0lfTElUVExFX0VORElBTj15CkNP
TkZJR19VU0JfU1VQUE9SVD15CkNPTkZJR19VU0JfQ09NTU9OPW0KIyBDT05GSUdfVVNCX0xFRF9U
UklHIGlzIG5vdCBzZXQKIyBDT05GSUdfVVNCX1VMUElfQlVTIGlzIG5vdCBzZXQKIyBDT05GSUdf
VVNCX0NPTk5fR1BJTyBpcyBub3Qgc2V0CkNPTkZJR19VU0JfQVJDSF9IQVNfSENEPXkKQ09ORklH
X1VTQj1tCkNPTkZJR19VU0JfUENJPXkKQ09ORklHX1VTQl9BTk5PVU5DRV9ORVdfREVWSUNFUz15
CgojCiMgTWlzY2VsbGFuZW91cyBVU0Igb3B0aW9ucwojCkNPTkZJR19VU0JfREVGQVVMVF9QRVJT
SVNUPXkKIyBDT05GSUdfVVNCX0ZFV19JTklUX1JFVFJJRVMgaXMgbm90IHNldAojIENPTkZJR19V
U0JfRFlOQU1JQ19NSU5PUlMgaXMgbm90IHNldAojIENPTkZJR19VU0JfT1RHIGlzIG5vdCBzZXQK
IyBDT05GSUdfVVNCX09UR19QUk9EVUNUTElTVCBpcyBub3Qgc2V0CiMgQ09ORklHX1VTQl9PVEdf
RElTQUJMRV9FWFRFUk5BTF9IVUIgaXMgbm90IHNldAojIENPTkZJR19VU0JfTEVEU19UUklHR0VS
X1VTQlBPUlQgaXMgbm90IHNldApDT05GSUdfVVNCX0FVVE9TVVNQRU5EX0RFTEFZPTIKQ09ORklH
X1VTQl9NT049bQoKIwojIFVTQiBIb3N0IENvbnRyb2xsZXIgRHJpdmVycwojCiMgQ09ORklHX1VT
Ql9DNjdYMDBfSENEIGlzIG5vdCBzZXQKIyBDT05GSUdfVVNCX1hIQ0lfSENEIGlzIG5vdCBzZXQK
Q09ORklHX1VTQl9FSENJX0hDRD1tCkNPTkZJR19VU0JfRUhDSV9ST09UX0hVQl9UVD15CkNPTkZJ
R19VU0JfRUhDSV9UVF9ORVdTQ0hFRD15CkNPTkZJR19VU0JfRUhDSV9QQ0k9bQojIENPTkZJR19Y
UFNfVVNCX0hDRF9YSUxJTlggaXMgbm90IHNldAojIENPTkZJR19VU0JfRUhDSV9GU0wgaXMgbm90
IHNldApDT05GSUdfVVNCX0VIQ0lfSENEX1BQQ19PRj15CkNPTkZJR19VU0JfRUhDSV9IQ0RfUExB
VEZPUk09bQojIENPTkZJR19VU0JfT1hVMjEwSFBfSENEIGlzIG5vdCBzZXQKIyBDT05GSUdfVVNC
X0lTUDExNlhfSENEIGlzIG5vdCBzZXQKIyBDT05GSUdfVVNCX0ZPVEcyMTBfSENEIGlzIG5vdCBz
ZXQKQ09ORklHX1VTQl9PSENJX0hDRD1tCkNPTkZJR19VU0JfT0hDSV9IQ0RfUFBDX09GX0JFPXkK
IyBDT05GSUdfVVNCX09IQ0lfSENEX1BQQ19PRl9MRSBpcyBub3Qgc2V0CkNPTkZJR19VU0JfT0hD
SV9IQ0RfUFBDX09GPXkKQ09ORklHX1VTQl9PSENJX0hDRF9QQ0k9bQojIENPTkZJR19VU0JfT0hD
SV9IQ0RfU1NCIGlzIG5vdCBzZXQKQ09ORklHX1VTQl9PSENJX0hDRF9QTEFURk9STT1tCiMgQ09O
RklHX1VTQl9VSENJX0hDRCBpcyBub3Qgc2V0CiMgQ09ORklHX1VTQl9TTDgxMV9IQ0QgaXMgbm90
IHNldAojIENPTkZJR19VU0JfUjhBNjY1OTdfSENEIGlzIG5vdCBzZXQKIyBDT05GSUdfVVNCX0hD
RF9CQ01BIGlzIG5vdCBzZXQKQ09ORklHX1VTQl9IQ0RfU1NCPW0KIyBDT05GSUdfVVNCX0hDRF9U
RVNUX01PREUgaXMgbm90IHNldAoKIwojIFVTQiBEZXZpY2UgQ2xhc3MgZHJpdmVycwojCiMgQ09O
RklHX1VTQl9BQ00gaXMgbm90IHNldAojIENPTkZJR19VU0JfUFJJTlRFUiBpcyBub3Qgc2V0CiMg
Q09ORklHX1VTQl9XRE0gaXMgbm90IHNldAojIENPTkZJR19VU0JfVE1DIGlzIG5vdCBzZXQKCiMK
IyBOT1RFOiBVU0JfU1RPUkFHRSBkZXBlbmRzIG9uIFNDU0kgYnV0IEJMS19ERVZfU0QgbWF5CiMK
CiMKIyBhbHNvIGJlIG5lZWRlZDsgc2VlIFVTQl9TVE9SQUdFIEhlbHAgZm9yIG1vcmUgaW5mbwoj
CkNPTkZJR19VU0JfU1RPUkFHRT1tCiMgQ09ORklHX1VTQl9TVE9SQUdFX0RFQlVHIGlzIG5vdCBz
ZXQKQ09ORklHX1VTQl9TVE9SQUdFX1JFQUxURUs9bQpDT05GSUdfUkVBTFRFS19BVVRPUE09eQpD
T05GSUdfVVNCX1NUT1JBR0VfREFUQUZBQj1tCkNPTkZJR19VU0JfU1RPUkFHRV9GUkVFQ09NPW0K
Q09ORklHX1VTQl9TVE9SQUdFX0lTRDIwMD1tCkNPTkZJR19VU0JfU1RPUkFHRV9VU0JBVD1tCkNP
TkZJR19VU0JfU1RPUkFHRV9TRERSMDk9bQpDT05GSUdfVVNCX1NUT1JBR0VfU0REUjU1PW0KQ09O
RklHX1VTQl9TVE9SQUdFX0pVTVBTSE9UPW0KQ09ORklHX1VTQl9TVE9SQUdFX0FMQVVEQT1tCiMg
Q09ORklHX1VTQl9TVE9SQUdFX09ORVRPVUNIIGlzIG5vdCBzZXQKIyBDT05GSUdfVVNCX1NUT1JB
R0VfS0FSTUEgaXMgbm90IHNldApDT05GSUdfVVNCX1NUT1JBR0VfQ1lQUkVTU19BVEFDQj1tCkNP
TkZJR19VU0JfU1RPUkFHRV9FTkVfVUI2MjUwPW0KQ09ORklHX1VTQl9VQVM9bQoKIwojIFVTQiBJ
bWFnaW5nIGRldmljZXMKIwojIENPTkZJR19VU0JfTURDODAwIGlzIG5vdCBzZXQKIyBDT05GSUdf
VVNCX01JQ1JPVEVLIGlzIG5vdCBzZXQKIyBDT05GSUdfVVNCSVBfQ09SRSBpcyBub3Qgc2V0CiMg
Q09ORklHX1VTQl9DRE5TX1NVUFBPUlQgaXMgbm90IHNldAojIENPTkZJR19VU0JfTVVTQl9IRFJD
IGlzIG5vdCBzZXQKIyBDT05GSUdfVVNCX0RXQzMgaXMgbm90IHNldAojIENPTkZJR19VU0JfRFdD
MiBpcyBub3Qgc2V0CiMgQ09ORklHX1VTQl9DSElQSURFQSBpcyBub3Qgc2V0CiMgQ09ORklHX1VT
Ql9JU1AxNzYwIGlzIG5vdCBzZXQKCiMKIyBVU0IgcG9ydCBkcml2ZXJzCiMKQ09ORklHX1VTQl9T
RVJJQUw9bQpDT05GSUdfVVNCX1NFUklBTF9HRU5FUklDPXkKIyBDT05GSUdfVVNCX1NFUklBTF9T
SU1QTEUgaXMgbm90IHNldAojIENPTkZJR19VU0JfU0VSSUFMX0FJUkNBQkxFIGlzIG5vdCBzZXQK
IyBDT05GSUdfVVNCX1NFUklBTF9BUkszMTE2IGlzIG5vdCBzZXQKIyBDT05GSUdfVVNCX1NFUklB
TF9CRUxLSU4gaXMgbm90IHNldAojIENPTkZJR19VU0JfU0VSSUFMX0NIMzQxIGlzIG5vdCBzZXQK
IyBDT05GSUdfVVNCX1NFUklBTF9XSElURUhFQVQgaXMgbm90IHNldAojIENPTkZJR19VU0JfU0VS
SUFMX0RJR0lfQUNDRUxFUE9SVCBpcyBub3Qgc2V0CiMgQ09ORklHX1VTQl9TRVJJQUxfQ1AyMTBY
IGlzIG5vdCBzZXQKIyBDT05GSUdfVVNCX1NFUklBTF9DWVBSRVNTX004IGlzIG5vdCBzZXQKIyBD
T05GSUdfVVNCX1NFUklBTF9FTVBFRyBpcyBub3Qgc2V0CkNPTkZJR19VU0JfU0VSSUFMX0ZURElf
U0lPPW0KIyBDT05GSUdfVVNCX1NFUklBTF9WSVNPUiBpcyBub3Qgc2V0CiMgQ09ORklHX1VTQl9T
RVJJQUxfSVBBUSBpcyBub3Qgc2V0CiMgQ09ORklHX1VTQl9TRVJJQUxfSVIgaXMgbm90IHNldAoj
IENPTkZJR19VU0JfU0VSSUFMX0VER0VQT1JUIGlzIG5vdCBzZXQKIyBDT05GSUdfVVNCX1NFUklB
TF9FREdFUE9SVF9USSBpcyBub3Qgc2V0CiMgQ09ORklHX1VTQl9TRVJJQUxfRjgxMjMyIGlzIG5v
dCBzZXQKIyBDT05GSUdfVVNCX1NFUklBTF9GODE1M1ggaXMgbm90IHNldAojIENPTkZJR19VU0Jf
U0VSSUFMX0dBUk1JTiBpcyBub3Qgc2V0CiMgQ09ORklHX1VTQl9TRVJJQUxfSVBXIGlzIG5vdCBz
ZXQKIyBDT05GSUdfVVNCX1NFUklBTF9JVVUgaXMgbm90IHNldAojIENPTkZJR19VU0JfU0VSSUFM
X0tFWVNQQU5fUERBIGlzIG5vdCBzZXQKIyBDT05GSUdfVVNCX1NFUklBTF9LRVlTUEFOIGlzIG5v
dCBzZXQKIyBDT05GSUdfVVNCX1NFUklBTF9LTFNJIGlzIG5vdCBzZXQKIyBDT05GSUdfVVNCX1NF
UklBTF9LT0JJTF9TQ1QgaXMgbm90IHNldAojIENPTkZJR19VU0JfU0VSSUFMX01DVF9VMjMyIGlz
IG5vdCBzZXQKIyBDT05GSUdfVVNCX1NFUklBTF9NRVRSTyBpcyBub3Qgc2V0CiMgQ09ORklHX1VT
Ql9TRVJJQUxfTU9TNzcyMCBpcyBub3Qgc2V0CiMgQ09ORklHX1VTQl9TRVJJQUxfTU9TNzg0MCBp
cyBub3Qgc2V0CiMgQ09ORklHX1VTQl9TRVJJQUxfTVhVUE9SVCBpcyBub3Qgc2V0CiMgQ09ORklH
X1VTQl9TRVJJQUxfTkFWTUFOIGlzIG5vdCBzZXQKIyBDT05GSUdfVVNCX1NFUklBTF9QTDIzMDMg
aXMgbm90IHNldAojIENPTkZJR19VU0JfU0VSSUFMX09USTY4NTggaXMgbm90IHNldAojIENPTkZJ
R19VU0JfU0VSSUFMX1FDQVVYIGlzIG5vdCBzZXQKIyBDT05GSUdfVVNCX1NFUklBTF9RVUFMQ09N
TSBpcyBub3Qgc2V0CiMgQ09ORklHX1VTQl9TRVJJQUxfU1BDUDhYNSBpcyBub3Qgc2V0CiMgQ09O
RklHX1VTQl9TRVJJQUxfU0FGRSBpcyBub3Qgc2V0CiMgQ09ORklHX1VTQl9TRVJJQUxfU0lFUlJB
V0lSRUxFU1MgaXMgbm90IHNldAojIENPTkZJR19VU0JfU0VSSUFMX1NZTUJPTCBpcyBub3Qgc2V0
CiMgQ09ORklHX1VTQl9TRVJJQUxfVEkgaXMgbm90IHNldAojIENPTkZJR19VU0JfU0VSSUFMX0NZ
QkVSSkFDSyBpcyBub3Qgc2V0CiMgQ09ORklHX1VTQl9TRVJJQUxfT1BUSU9OIGlzIG5vdCBzZXQK
IyBDT05GSUdfVVNCX1NFUklBTF9PTU5JTkVUIGlzIG5vdCBzZXQKIyBDT05GSUdfVVNCX1NFUklB
TF9PUFRJQ09OIGlzIG5vdCBzZXQKIyBDT05GSUdfVVNCX1NFUklBTF9YU0VOU19NVCBpcyBub3Qg
c2V0CiMgQ09ORklHX1VTQl9TRVJJQUxfV0lTSEJPTkUgaXMgbm90IHNldAojIENPTkZJR19VU0Jf
U0VSSUFMX1NTVTEwMCBpcyBub3Qgc2V0CiMgQ09ORklHX1VTQl9TRVJJQUxfUVQyIGlzIG5vdCBz
ZXQKIyBDT05GSUdfVVNCX1NFUklBTF9VUEQ3OEYwNzMwIGlzIG5vdCBzZXQKIyBDT05GSUdfVVNC
X1NFUklBTF9YUiBpcyBub3Qgc2V0CiMgQ09ORklHX1VTQl9TRVJJQUxfREVCVUcgaXMgbm90IHNl
dAoKIwojIFVTQiBNaXNjZWxsYW5lb3VzIGRyaXZlcnMKIwojIENPTkZJR19VU0JfRU1JNjIgaXMg
bm90IHNldAojIENPTkZJR19VU0JfRU1JMjYgaXMgbm90IHNldAojIENPTkZJR19VU0JfQURVVFVY
IGlzIG5vdCBzZXQKIyBDT05GSUdfVVNCX1NFVlNFRyBpcyBub3Qgc2V0CiMgQ09ORklHX1VTQl9M
RUdPVE9XRVIgaXMgbm90IHNldAojIENPTkZJR19VU0JfTENEIGlzIG5vdCBzZXQKIyBDT05GSUdf
VVNCX0NZUFJFU1NfQ1k3QzYzIGlzIG5vdCBzZXQKIyBDT05GSUdfVVNCX0NZVEhFUk0gaXMgbm90
IHNldAojIENPTkZJR19VU0JfSURNT1VTRSBpcyBub3Qgc2V0CiMgQ09ORklHX1VTQl9GVERJX0VM
QU4gaXMgbm90IHNldApDT05GSUdfVVNCX0FQUExFRElTUExBWT1tCiMgQ09ORklHX0FQUExFX01G
SV9GQVNUQ0hBUkdFIGlzIG5vdCBzZXQKIyBDT05GSUdfVVNCX1NJU1VTQlZHQSBpcyBub3Qgc2V0
CiMgQ09ORklHX1VTQl9MRCBpcyBub3Qgc2V0CiMgQ09ORklHX1VTQl9UUkFOQ0VWSUJSQVRPUiBp
cyBub3Qgc2V0CiMgQ09ORklHX1VTQl9JT1dBUlJJT1IgaXMgbm90IHNldAojIENPTkZJR19VU0Jf
VEVTVCBpcyBub3Qgc2V0CiMgQ09ORklHX1VTQl9FSFNFVF9URVNUX0ZJWFRVUkUgaXMgbm90IHNl
dApDT05GSUdfVVNCX0lTSUdIVEZXPW0KIyBDT05GSUdfVVNCX1lVUkVYIGlzIG5vdCBzZXQKIyBD
T05GSUdfVVNCX0VaVVNCX0ZYMiBpcyBub3Qgc2V0CiMgQ09ORklHX1VTQl9IVUJfVVNCMjUxWEIg
aXMgbm90IHNldAojIENPTkZJR19VU0JfSFNJQ19VU0IzNTAzIGlzIG5vdCBzZXQKIyBDT05GSUdf
VVNCX0hTSUNfVVNCNDYwNCBpcyBub3Qgc2V0CiMgQ09ORklHX1VTQl9MSU5LX0xBWUVSX1RFU1Qg
aXMgbm90IHNldAojIENPTkZJR19VU0JfT05CT0FSRF9IVUIgaXMgbm90IHNldAoKIwojIFVTQiBQ
aHlzaWNhbCBMYXllciBkcml2ZXJzCiMKIyBDT05GSUdfTk9QX1VTQl9YQ0VJViBpcyBub3Qgc2V0
CiMgQ09ORklHX1VTQl9HUElPX1ZCVVMgaXMgbm90IHNldAojIENPTkZJR19VU0JfSVNQMTMwMSBp
cyBub3Qgc2V0CiMgZW5kIG9mIFVTQiBQaHlzaWNhbCBMYXllciBkcml2ZXJzCgojIENPTkZJR19V
U0JfR0FER0VUIGlzIG5vdCBzZXQKIyBDT05GSUdfVFlQRUMgaXMgbm90IHNldApDT05GSUdfVVNC
X1JPTEVfU1dJVENIPW0KIyBDT05GSUdfTU1DIGlzIG5vdCBzZXQKIyBDT05GSUdfU0NTSV9VRlNI
Q0QgaXMgbm90IHNldAojIENPTkZJR19NRU1TVElDSyBpcyBub3Qgc2V0CkNPTkZJR19ORVdfTEVE
Uz15CkNPTkZJR19MRURTX0NMQVNTPXkKIyBDT05GSUdfTEVEU19DTEFTU19GTEFTSCBpcyBub3Qg
c2V0CiMgQ09ORklHX0xFRFNfQ0xBU1NfTVVMVElDT0xPUiBpcyBub3Qgc2V0CkNPTkZJR19MRURT
X0JSSUdIVE5FU1NfSFdfQ0hBTkdFRD15CgojCiMgTEVEIGRyaXZlcnMKIwojIENPTkZJR19MRURT
X0FOMzAyNTlBIGlzIG5vdCBzZXQKIyBDT05GSUdfTEVEU19BVzIwMTMgaXMgbm90IHNldAojIENP
TkZJR19MRURTX0JDTTYzMjggaXMgbm90IHNldAojIENPTkZJR19MRURTX0JDTTYzNTggaXMgbm90
IHNldAojIENPTkZJR19MRURTX0xNMzUzMCBpcyBub3Qgc2V0CiMgQ09ORklHX0xFRFNfTE0zNTMy
IGlzIG5vdCBzZXQKIyBDT05GSUdfTEVEU19MTTM2NDIgaXMgbm90IHNldAojIENPTkZJR19MRURT
X0xNMzY5MlggaXMgbm90IHNldAojIENPTkZJR19MRURTX1BDQTk1MzIgaXMgbm90IHNldAojIENP
TkZJR19MRURTX0dQSU8gaXMgbm90IHNldAojIENPTkZJR19MRURTX0xQMzk0NCBpcyBub3Qgc2V0
CiMgQ09ORklHX0xFRFNfTFAzOTUyIGlzIG5vdCBzZXQKIyBDT05GSUdfTEVEU19MUDU1WFhfQ09N
TU9OIGlzIG5vdCBzZXQKIyBDT05GSUdfTEVEU19MUDg4NjAgaXMgbm90IHNldAojIENPTkZJR19M
RURTX1BDQTk1NVggaXMgbm90IHNldAojIENPTkZJR19MRURTX1BDQTk2M1ggaXMgbm90IHNldAoj
IENPTkZJR19MRURTX1JFR1VMQVRPUiBpcyBub3Qgc2V0CiMgQ09ORklHX0xFRFNfQkQyODAyIGlz
IG5vdCBzZXQKIyBDT05GSUdfTEVEU19MVDM1OTMgaXMgbm90IHNldAojIENPTkZJR19MRURTX1RD
QTY1MDcgaXMgbm90IHNldAojIENPTkZJR19MRURTX1RMQzU5MVhYIGlzIG5vdCBzZXQKIyBDT05G
SUdfTEVEU19MTTM1NXggaXMgbm90IHNldAojIENPTkZJR19MRURTX0lTMzFGTDMxOVggaXMgbm90
IHNldAojIENPTkZJR19MRURTX0lTMzFGTDMyWFggaXMgbm90IHNldAoKIwojIExFRCBkcml2ZXIg
Zm9yIGJsaW5rKDEpIFVTQiBSR0IgTEVEIGlzIHVuZGVyIFNwZWNpYWwgSElEIGRyaXZlcnMgKEhJ
RF9USElOR00pCiMKIyBDT05GSUdfTEVEU19CTElOS00gaXMgbm90IHNldAojIENPTkZJR19MRURT
X01MWFJFRyBpcyBub3Qgc2V0CiMgQ09ORklHX0xFRFNfVVNFUiBpcyBub3Qgc2V0CiMgQ09ORklH
X0xFRFNfVElfTE1VX0NPTU1PTiBpcyBub3Qgc2V0CgojCiMgRmxhc2ggYW5kIFRvcmNoIExFRCBk
cml2ZXJzCiMKCiMKIyBSR0IgTEVEIGRyaXZlcnMKIwoKIwojIExFRCBUcmlnZ2VycwojCkNPTkZJ
R19MRURTX1RSSUdHRVJTPXkKQ09ORklHX0xFRFNfVFJJR0dFUl9USU1FUj1tCkNPTkZJR19MRURT
X1RSSUdHRVJfT05FU0hPVD1tCkNPTkZJR19MRURTX1RSSUdHRVJfRElTSz15CkNPTkZJR19MRURT
X1RSSUdHRVJfSEVBUlRCRUFUPW0KQ09ORklHX0xFRFNfVFJJR0dFUl9CQUNLTElHSFQ9bQpDT05G
SUdfTEVEU19UUklHR0VSX0NQVT15CiMgQ09ORklHX0xFRFNfVFJJR0dFUl9BQ1RJVklUWSBpcyBu
b3Qgc2V0CiMgQ09ORklHX0xFRFNfVFJJR0dFUl9HUElPIGlzIG5vdCBzZXQKQ09ORklHX0xFRFNf
VFJJR0dFUl9ERUZBVUxUX09OPW0KCiMKIyBpcHRhYmxlcyB0cmlnZ2VyIGlzIHVuZGVyIE5ldGZp
bHRlciBjb25maWcgKExFRCB0YXJnZXQpCiMKQ09ORklHX0xFRFNfVFJJR0dFUl9UUkFOU0lFTlQ9
bQpDT05GSUdfTEVEU19UUklHR0VSX0NBTUVSQT1tCkNPTkZJR19MRURTX1RSSUdHRVJfUEFOSUM9
eQojIENPTkZJR19MRURTX1RSSUdHRVJfTkVUREVWIGlzIG5vdCBzZXQKQ09ORklHX0xFRFNfVFJJ
R0dFUl9QQVRURVJOPW0KQ09ORklHX0xFRFNfVFJJR0dFUl9BVURJTz1tCiMgQ09ORklHX0xFRFNf
VFJJR0dFUl9UVFkgaXMgbm90IHNldAoKIwojIFNpbXBsZSBMRUQgZHJpdmVycwojCiMgQ09ORklH
X0FDQ0VTU0lCSUxJVFkgaXMgbm90IHNldAojIENPTkZJR19JTkZJTklCQU5EIGlzIG5vdCBzZXQK
Q09ORklHX0VEQUNfQVRPTUlDX1NDUlVCPXkKQ09ORklHX0VEQUNfU1VQUE9SVD15CkNPTkZJR19S
VENfTElCPXkKQ09ORklHX1JUQ19DTEFTUz15CiMgQ09ORklHX1JUQ19IQ1RPU1lTIGlzIG5vdCBz
ZXQKIyBDT05GSUdfUlRDX1NZU1RPSEMgaXMgbm90IHNldAojIENPTkZJR19SVENfREVCVUcgaXMg
bm90IHNldApDT05GSUdfUlRDX05WTUVNPXkKCiMKIyBSVEMgaW50ZXJmYWNlcwojCkNPTkZJR19S
VENfSU5URl9TWVNGUz15CkNPTkZJR19SVENfSU5URl9QUk9DPXkKQ09ORklHX1JUQ19JTlRGX0RF
Vj15CiMgQ09ORklHX1JUQ19JTlRGX0RFVl9VSUVfRU1VTCBpcyBub3Qgc2V0CiMgQ09ORklHX1JU
Q19EUlZfVEVTVCBpcyBub3Qgc2V0CgojCiMgSTJDIFJUQyBkcml2ZXJzCiMKIyBDT05GSUdfUlRD
X0RSVl9BQkI1WkVTMyBpcyBub3Qgc2V0CiMgQ09ORklHX1JUQ19EUlZfQUJFT1o5IGlzIG5vdCBz
ZXQKIyBDT05GSUdfUlRDX0RSVl9BQlg4MFggaXMgbm90IHNldAojIENPTkZJR19SVENfRFJWX0RT
MTMwNyBpcyBub3Qgc2V0CiMgQ09ORklHX1JUQ19EUlZfRFMxMzc0IGlzIG5vdCBzZXQKIyBDT05G
SUdfUlRDX0RSVl9EUzE2NzIgaXMgbm90IHNldAojIENPTkZJR19SVENfRFJWX0hZTTg1NjMgaXMg
bm90IHNldAojIENPTkZJR19SVENfRFJWX01BWDY5MDAgaXMgbm90IHNldAojIENPTkZJR19SVENf
RFJWX05DVDMwMThZIGlzIG5vdCBzZXQKIyBDT05GSUdfUlRDX0RSVl9SUzVDMzcyIGlzIG5vdCBz
ZXQKIyBDT05GSUdfUlRDX0RSVl9JU0wxMjA4IGlzIG5vdCBzZXQKIyBDT05GSUdfUlRDX0RSVl9J
U0wxMjAyMiBpcyBub3Qgc2V0CiMgQ09ORklHX1JUQ19EUlZfSVNMMTIwMjYgaXMgbm90IHNldAoj
IENPTkZJR19SVENfRFJWX1gxMjA1IGlzIG5vdCBzZXQKIyBDT05GSUdfUlRDX0RSVl9QQ0Y4NTIz
IGlzIG5vdCBzZXQKIyBDT05GSUdfUlRDX0RSVl9QQ0Y4NTA2MyBpcyBub3Qgc2V0CiMgQ09ORklH
X1JUQ19EUlZfUENGODUzNjMgaXMgbm90IHNldAojIENPTkZJR19SVENfRFJWX1BDRjg1NjMgaXMg
bm90IHNldAojIENPTkZJR19SVENfRFJWX1BDRjg1ODMgaXMgbm90IHNldAojIENPTkZJR19SVENf
RFJWX000MVQ4MCBpcyBub3Qgc2V0CiMgQ09ORklHX1JUQ19EUlZfQlEzMksgaXMgbm90IHNldAoj
IENPTkZJR19SVENfRFJWX1MzNTM5MEEgaXMgbm90IHNldAojIENPTkZJR19SVENfRFJWX0ZNMzEz
MCBpcyBub3Qgc2V0CiMgQ09ORklHX1JUQ19EUlZfUlg4MDEwIGlzIG5vdCBzZXQKIyBDT05GSUdf
UlRDX0RSVl9SWDg1ODEgaXMgbm90IHNldAojIENPTkZJR19SVENfRFJWX1JYODAyNSBpcyBub3Qg
c2V0CiMgQ09ORklHX1JUQ19EUlZfRU0zMDI3IGlzIG5vdCBzZXQKIyBDT05GSUdfUlRDX0RSVl9S
VjMwMjggaXMgbm90IHNldAojIENPTkZJR19SVENfRFJWX1JWMzAzMiBpcyBub3Qgc2V0CiMgQ09O
RklHX1JUQ19EUlZfUlY4ODAzIGlzIG5vdCBzZXQKIyBDT05GSUdfUlRDX0RSVl9TRDMwNzggaXMg
bm90IHNldAoKIwojIFNQSSBSVEMgZHJpdmVycwojCkNPTkZJR19SVENfSTJDX0FORF9TUEk9eQoK
IwojIFNQSSBhbmQgSTJDIFJUQyBkcml2ZXJzCiMKIyBDT05GSUdfUlRDX0RSVl9EUzMyMzIgaXMg
bm90IHNldAojIENPTkZJR19SVENfRFJWX1BDRjIxMjcgaXMgbm90IHNldAojIENPTkZJR19SVENf
RFJWX1JWMzAyOUMyIGlzIG5vdCBzZXQKIyBDT05GSUdfUlRDX0RSVl9SWDYxMTAgaXMgbm90IHNl
dAoKIwojIFBsYXRmb3JtIFJUQyBkcml2ZXJzCiMKIyBDT05GSUdfUlRDX0RSVl9DTU9TIGlzIG5v
dCBzZXQKIyBDT05GSUdfUlRDX0RSVl9EUzEyODYgaXMgbm90IHNldAojIENPTkZJR19SVENfRFJW
X0RTMTUxMSBpcyBub3Qgc2V0CiMgQ09ORklHX1JUQ19EUlZfRFMxNTUzIGlzIG5vdCBzZXQKIyBD
T05GSUdfUlRDX0RSVl9EUzE2ODVfRkFNSUxZIGlzIG5vdCBzZXQKIyBDT05GSUdfUlRDX0RSVl9E
UzE3NDIgaXMgbm90IHNldAojIENPTkZJR19SVENfRFJWX0RTMjQwNCBpcyBub3Qgc2V0CiMgQ09O
RklHX1JUQ19EUlZfU1RLMTdUQTggaXMgbm90IHNldAojIENPTkZJR19SVENfRFJWX000OFQ4NiBp
cyBub3Qgc2V0CiMgQ09ORklHX1JUQ19EUlZfTTQ4VDM1IGlzIG5vdCBzZXQKIyBDT05GSUdfUlRD
X0RSVl9NNDhUNTkgaXMgbm90IHNldAojIENPTkZJR19SVENfRFJWX01TTTYyNDIgaXMgbm90IHNl
dAojIENPTkZJR19SVENfRFJWX0JRNDgwMiBpcyBub3Qgc2V0CiMgQ09ORklHX1JUQ19EUlZfUlA1
QzAxIGlzIG5vdCBzZXQKIyBDT05GSUdfUlRDX0RSVl9WMzAyMCBpcyBub3Qgc2V0CiMgQ09ORklH
X1JUQ19EUlZfWllOUU1QIGlzIG5vdCBzZXQKCiMKIyBvbi1DUFUgUlRDIGRyaXZlcnMKIwpDT05G
SUdfUlRDX0RSVl9HRU5FUklDPXkKIyBDT05GSUdfUlRDX0RSVl9DQURFTkNFIGlzIG5vdCBzZXQK
IyBDT05GSUdfUlRDX0RSVl9GVFJUQzAxMCBpcyBub3Qgc2V0CiMgQ09ORklHX1JUQ19EUlZfUjcz
MDEgaXMgbm90IHNldAoKIwojIEhJRCBTZW5zb3IgUlRDIGRyaXZlcnMKIwojIENPTkZJR19SVENf
RFJWX0dPTERGSVNIIGlzIG5vdCBzZXQKIyBDT05GSUdfRE1BREVWSUNFUyBpcyBub3Qgc2V0Cgoj
CiMgRE1BQlVGIG9wdGlvbnMKIwpDT05GSUdfU1lOQ19GSUxFPXkKQ09ORklHX1VETUFCVUY9eQoj
IENPTkZJR19ETUFCVUZfTU9WRV9OT1RJRlkgaXMgbm90IHNldApDT05GSUdfRE1BQlVGX0RFQlVH
PXkKIyBDT05GSUdfRE1BQlVGX1NFTEZURVNUUyBpcyBub3Qgc2V0CkNPTkZJR19ETUFCVUZfSEVB
UFM9eQojIENPTkZJR19ETUFCVUZfU1lTRlNfU1RBVFMgaXMgbm90IHNldApDT05GSUdfRE1BQlVG
X0hFQVBTX1NZU1RFTT15CiMgZW5kIG9mIERNQUJVRiBvcHRpb25zCgojIENPTkZJR19BVVhESVNQ
TEFZIGlzIG5vdCBzZXQKIyBDT05GSUdfVUlPIGlzIG5vdCBzZXQKIyBDT05GSUdfVkZJTyBpcyBu
b3Qgc2V0CiMgQ09ORklHX1ZJUlRfRFJJVkVSUyBpcyBub3Qgc2V0CkNPTkZJR19WSVJUSU9fQU5D
SE9SPXkKQ09ORklHX1ZJUlRJTz1tCiMgQ09ORklHX1ZJUlRJT19NRU5VIGlzIG5vdCBzZXQKIyBD
T05GSUdfVkRQQSBpcyBub3Qgc2V0CiMgQ09ORklHX1ZIT1NUX01FTlUgaXMgbm90IHNldAoKIwoj
IE1pY3Jvc29mdCBIeXBlci1WIGd1ZXN0IHN1cHBvcnQKIwojIGVuZCBvZiBNaWNyb3NvZnQgSHlw
ZXItViBndWVzdCBzdXBwb3J0CgojIENPTkZJR19HUkVZQlVTIGlzIG5vdCBzZXQKIyBDT05GSUdf
Q09NRURJIGlzIG5vdCBzZXQKIyBDT05GSUdfU1RBR0lORyBpcyBub3Qgc2V0CiMgQ09ORklHX0dP
TERGSVNIIGlzIG5vdCBzZXQKIyBDT05GSUdfQ09NTU9OX0NMSyBpcyBub3Qgc2V0CiMgQ09ORklH
X0hXU1BJTkxPQ0sgaXMgbm90IHNldAoKIwojIENsb2NrIFNvdXJjZSBkcml2ZXJzCiMKIyBDT05G
SUdfTUlDUk9DSElQX1BJVDY0QiBpcyBub3Qgc2V0CiMgZW5kIG9mIENsb2NrIFNvdXJjZSBkcml2
ZXJzCgojIENPTkZJR19NQUlMQk9YIGlzIG5vdCBzZXQKIyBDT05GSUdfSU9NTVVfU1VQUE9SVCBp
cyBub3Qgc2V0CgojCiMgUmVtb3RlcHJvYyBkcml2ZXJzCiMKIyBDT05GSUdfUkVNT1RFUFJPQyBp
cyBub3Qgc2V0CiMgZW5kIG9mIFJlbW90ZXByb2MgZHJpdmVycwoKIwojIFJwbXNnIGRyaXZlcnMK
IwojIENPTkZJR19SUE1TR19WSVJUSU8gaXMgbm90IHNldAojIGVuZCBvZiBScG1zZyBkcml2ZXJz
CgojIENPTkZJR19TT1VORFdJUkUgaXMgbm90IHNldAoKIwojIFNPQyAoU3lzdGVtIE9uIENoaXAp
IHNwZWNpZmljIERyaXZlcnMKIwoKIwojIEFtbG9naWMgU29DIGRyaXZlcnMKIwojIGVuZCBvZiBB
bWxvZ2ljIFNvQyBkcml2ZXJzCgojCiMgQnJvYWRjb20gU29DIGRyaXZlcnMKIwojIGVuZCBvZiBC
cm9hZGNvbSBTb0MgZHJpdmVycwoKIwojIE5YUC9GcmVlc2NhbGUgUW9ySVEgU29DIGRyaXZlcnMK
IwojIENPTkZJR19RVUlDQ19FTkdJTkUgaXMgbm90IHNldAojIGVuZCBvZiBOWFAvRnJlZXNjYWxl
IFFvcklRIFNvQyBkcml2ZXJzCgojCiMgZnVqaXRzdSBTb0MgZHJpdmVycwojCiMgZW5kIG9mIGZ1
aml0c3UgU29DIGRyaXZlcnMKCiMKIyBpLk1YIFNvQyBkcml2ZXJzCiMKIyBlbmQgb2YgaS5NWCBT
b0MgZHJpdmVycwoKIwojIEVuYWJsZSBMaXRlWCBTb0MgQnVpbGRlciBzcGVjaWZpYyBkcml2ZXJz
CiMKIyBDT05GSUdfTElURVhfU09DX0NPTlRST0xMRVIgaXMgbm90IHNldAojIGVuZCBvZiBFbmFi
bGUgTGl0ZVggU29DIEJ1aWxkZXIgc3BlY2lmaWMgZHJpdmVycwoKIwojIFF1YWxjb21tIFNvQyBk
cml2ZXJzCiMKIyBlbmQgb2YgUXVhbGNvbW0gU29DIGRyaXZlcnMKCiMgQ09ORklHX1NPQ19USSBp
cyBub3Qgc2V0CgojCiMgWGlsaW54IFNvQyBkcml2ZXJzCiMKIyBlbmQgb2YgWGlsaW54IFNvQyBk
cml2ZXJzCiMgZW5kIG9mIFNPQyAoU3lzdGVtIE9uIENoaXApIHNwZWNpZmljIERyaXZlcnMKCiMg
Q09ORklHX1BNX0RFVkZSRVEgaXMgbm90IHNldAojIENPTkZJR19FWFRDT04gaXMgbm90IHNldAoj
IENPTkZJR19NRU1PUlkgaXMgbm90IHNldAojIENPTkZJR19JSU8gaXMgbm90IHNldAojIENPTkZJ
R19OVEIgaXMgbm90IHNldAojIENPTkZJR19QV00gaXMgbm90IHNldAoKIwojIElSUSBjaGlwIHN1
cHBvcnQKIwpDT05GSUdfSVJRQ0hJUD15CiMgQ09ORklHX0FMX0ZJQyBpcyBub3Qgc2V0CiMgQ09O
RklHX1hJTElOWF9JTlRDIGlzIG5vdCBzZXQKIyBlbmQgb2YgSVJRIGNoaXAgc3VwcG9ydAoKIyBD
T05GSUdfSVBBQ0tfQlVTIGlzIG5vdCBzZXQKIyBDT05GSUdfUkVTRVRfQ09OVFJPTExFUiBpcyBu
b3Qgc2V0CgojCiMgUEhZIFN1YnN5c3RlbQojCkNPTkZJR19HRU5FUklDX1BIWT15CkNPTkZJR19H
RU5FUklDX1BIWV9NSVBJX0RQSFk9eQojIENPTkZJR19QSFlfQ0FOX1RSQU5TQ0VJVkVSIGlzIG5v
dCBzZXQKCiMKIyBQSFkgZHJpdmVycyBmb3IgQnJvYWRjb20gcGxhdGZvcm1zCiMKIyBDT05GSUdf
QkNNX0tPTkFfVVNCMl9QSFkgaXMgbm90IHNldAojIGVuZCBvZiBQSFkgZHJpdmVycyBmb3IgQnJv
YWRjb20gcGxhdGZvcm1zCgpDT05GSUdfUEhZX0NBREVOQ0VfRFBIWT1tCiMgQ09ORklHX1BIWV9D
QURFTkNFX0RQSFlfUlggaXMgbm90IHNldAojIENPTkZJR19QSFlfQ0FERU5DRV9TQUxWTyBpcyBu
b3Qgc2V0CiMgQ09ORklHX1BIWV9QWEFfMjhOTV9IU0lDIGlzIG5vdCBzZXQKIyBDT05GSUdfUEhZ
X1BYQV8yOE5NX1VTQjIgaXMgbm90IHNldAojIENPTkZJR19QSFlfTUFQUEhPTkVfTURNNjYwMCBp
cyBub3Qgc2V0CiMgZW5kIG9mIFBIWSBTdWJzeXN0ZW0KCiMgQ09ORklHX1BPV0VSQ0FQIGlzIG5v
dCBzZXQKIyBDT05GSUdfTUNCIGlzIG5vdCBzZXQKCiMKIyBQZXJmb3JtYW5jZSBtb25pdG9yIHN1
cHBvcnQKIwojIGVuZCBvZiBQZXJmb3JtYW5jZSBtb25pdG9yIHN1cHBvcnQKCiMgQ09ORklHX1JB
UyBpcyBub3Qgc2V0CiMgQ09ORklHX1VTQjQgaXMgbm90IHNldAoKIwojIEFuZHJvaWQKIwojIENP
TkZJR19BTkRST0lEX0JJTkRFUl9JUEMgaXMgbm90IHNldAojIGVuZCBvZiBBbmRyb2lkCgojIENP
TkZJR19EQVggaXMgbm90IHNldApDT05GSUdfTlZNRU09eQpDT05GSUdfTlZNRU1fU1lTRlM9eQoj
IENPTkZJR19OVk1FTV9STUVNIGlzIG5vdCBzZXQKCiMKIyBIVyB0cmFjaW5nIHN1cHBvcnQKIwoj
IENPTkZJR19TVE0gaXMgbm90IHNldAojIENPTkZJR19JTlRFTF9USCBpcyBub3Qgc2V0CiMgZW5k
IG9mIEhXIHRyYWNpbmcgc3VwcG9ydAoKIyBDT05GSUdfRlBHQSBpcyBub3Qgc2V0CiMgQ09ORklH
X0ZTSSBpcyBub3Qgc2V0CiMgQ09ORklHX1NJT1ggaXMgbm90IHNldAojIENPTkZJR19TTElNQlVT
IGlzIG5vdCBzZXQKIyBDT05GSUdfSU5URVJDT05ORUNUIGlzIG5vdCBzZXQKIyBDT05GSUdfQ09V
TlRFUiBpcyBub3Qgc2V0CiMgQ09ORklHX01PU1QgaXMgbm90IHNldAojIENPTkZJR19QRUNJIGlz
IG5vdCBzZXQKIyBDT05GSUdfSFRFIGlzIG5vdCBzZXQKIyBlbmQgb2YgRGV2aWNlIERyaXZlcnMK
CiMKIyBGaWxlIHN5c3RlbXMKIwojIENPTkZJR19WQUxJREFURV9GU19QQVJTRVIgaXMgbm90IHNl
dApDT05GSUdfRlNfSU9NQVA9eQojIENPTkZJR19FWFQyX0ZTIGlzIG5vdCBzZXQKIyBDT05GSUdf
RVhUM19GUyBpcyBub3Qgc2V0CkNPTkZJR19FWFQ0X0ZTPXkKQ09ORklHX0VYVDRfVVNFX0ZPUl9F
WFQyPXkKQ09ORklHX0VYVDRfRlNfUE9TSVhfQUNMPXkKQ09ORklHX0VYVDRfRlNfU0VDVVJJVFk9
eQojIENPTkZJR19FWFQ0X0RFQlVHIGlzIG5vdCBzZXQKQ09ORklHX0pCRDI9eQojIENPTkZJR19K
QkQyX0RFQlVHIGlzIG5vdCBzZXQKQ09ORklHX0ZTX01CQ0FDSEU9eQojIENPTkZJR19SRUlTRVJG
U19GUyBpcyBub3Qgc2V0CiMgQ09ORklHX0pGU19GUyBpcyBub3Qgc2V0CkNPTkZJR19YRlNfRlM9
bQpDT05GSUdfWEZTX1NVUFBPUlRfVjQ9eQojIENPTkZJR19YRlNfUVVPVEEgaXMgbm90IHNldAoj
IENPTkZJR19YRlNfUE9TSVhfQUNMIGlzIG5vdCBzZXQKIyBDT05GSUdfWEZTX1JUIGlzIG5vdCBz
ZXQKIyBDT05GSUdfWEZTX09OTElORV9TQ1JVQiBpcyBub3Qgc2V0CiMgQ09ORklHX1hGU19XQVJO
IGlzIG5vdCBzZXQKIyBDT05GSUdfWEZTX0RFQlVHIGlzIG5vdCBzZXQKIyBDT05GSUdfR0ZTMl9G
UyBpcyBub3Qgc2V0CiMgQ09ORklHX09DRlMyX0ZTIGlzIG5vdCBzZXQKQ09ORklHX0JUUkZTX0ZT
PXkKQ09ORklHX0JUUkZTX0ZTX1BPU0lYX0FDTD15CiMgQ09ORklHX0JUUkZTX0ZTX0NIRUNLX0lO
VEVHUklUWSBpcyBub3Qgc2V0CiMgQ09ORklHX0JUUkZTX0ZTX1JVTl9TQU5JVFlfVEVTVFMgaXMg
bm90IHNldAojIENPTkZJR19CVFJGU19ERUJVRyBpcyBub3Qgc2V0CiMgQ09ORklHX0JUUkZTX0FT
U0VSVCBpcyBub3Qgc2V0CiMgQ09ORklHX0JUUkZTX0ZTX1JFRl9WRVJJRlkgaXMgbm90IHNldAoj
IENPTkZJR19OSUxGUzJfRlMgaXMgbm90IHNldApDT05GSUdfRjJGU19GUz1tCkNPTkZJR19GMkZT
X1NUQVRfRlM9eQpDT05GSUdfRjJGU19GU19YQVRUUj15CkNPTkZJR19GMkZTX0ZTX1BPU0lYX0FD
TD15CiMgQ09ORklHX0YyRlNfRlNfU0VDVVJJVFkgaXMgbm90IHNldAojIENPTkZJR19GMkZTX0NI
RUNLX0ZTIGlzIG5vdCBzZXQKIyBDT05GSUdfRjJGU19GQVVMVF9JTkpFQ1RJT04gaXMgbm90IHNl
dApDT05GSUdfRjJGU19GU19DT01QUkVTU0lPTj15CkNPTkZJR19GMkZTX0ZTX0xaTz15CkNPTkZJ
R19GMkZTX0ZTX0xaT1JMRT15CiMgQ09ORklHX0YyRlNfRlNfTFo0IGlzIG5vdCBzZXQKQ09ORklH
X0YyRlNfRlNfWlNURD15CiMgQ09ORklHX0YyRlNfSU9TVEFUIGlzIG5vdCBzZXQKIyBDT05GSUdf
RjJGU19VTkZBSVJfUldTRU0gaXMgbm90IHNldApDT05GSUdfRlNfUE9TSVhfQUNMPXkKQ09ORklH
X0VYUE9SVEZTPXkKQ09ORklHX0VYUE9SVEZTX0JMT0NLX09QUz15CkNPTkZJR19GSUxFX0xPQ0tJ
Tkc9eQojIENPTkZJR19GU19FTkNSWVBUSU9OIGlzIG5vdCBzZXQKIyBDT05GSUdfRlNfVkVSSVRZ
IGlzIG5vdCBzZXQKQ09ORklHX0ZTTk9USUZZPXkKQ09ORklHX0ROT1RJRlk9eQpDT05GSUdfSU5P
VElGWV9VU0VSPXkKQ09ORklHX0ZBTk9USUZZPXkKIyBDT05GSUdfRkFOT1RJRllfQUNDRVNTX1BF
Uk1JU1NJT05TIGlzIG5vdCBzZXQKIyBDT05GSUdfUVVPVEEgaXMgbm90IHNldApDT05GSUdfQVVU
T0ZTNF9GUz15CkNPTkZJR19BVVRPRlNfRlM9eQpDT05GSUdfRlVTRV9GUz1tCkNPTkZJR19DVVNF
PW0KIyBDT05GSUdfVklSVElPX0ZTIGlzIG5vdCBzZXQKIyBDT05GSUdfT1ZFUkxBWV9GUyBpcyBu
b3Qgc2V0CgojCiMgQ2FjaGVzCiMKIyBDT05GSUdfRlNDQUNIRSBpcyBub3Qgc2V0CiMgZW5kIG9m
IENhY2hlcwoKIwojIENELVJPTS9EVkQgRmlsZXN5c3RlbXMKIwpDT05GSUdfSVNPOTY2MF9GUz1t
CkNPTkZJR19KT0xJRVQ9eQpDT05GSUdfWklTT0ZTPXkKQ09ORklHX1VERl9GUz1tCiMgZW5kIG9m
IENELVJPTS9EVkQgRmlsZXN5c3RlbXMKCiMKIyBET1MvRkFUL0VYRkFUL05UIEZpbGVzeXN0ZW1z
CiMKQ09ORklHX0ZBVF9GUz1tCkNPTkZJR19NU0RPU19GUz1tCkNPTkZJR19WRkFUX0ZTPW0KQ09O
RklHX0ZBVF9ERUZBVUxUX0NPREVQQUdFPTQzNwpDT05GSUdfRkFUX0RFRkFVTFRfSU9DSEFSU0VU
PSJpc284ODU5LTE1IgpDT05GSUdfRkFUX0RFRkFVTFRfVVRGOD15CkNPTkZJR19FWEZBVF9GUz1t
CkNPTkZJR19FWEZBVF9ERUZBVUxUX0lPQ0hBUlNFVD0idXRmOCIKIyBDT05GSUdfTlRGU19GUyBp
cyBub3Qgc2V0CkNPTkZJR19OVEZTM19GUz1tCkNPTkZJR19OVEZTM19MWlhfWFBSRVNTPXkKIyBD
T05GSUdfTlRGUzNfRlNfUE9TSVhfQUNMIGlzIG5vdCBzZXQKIyBlbmQgb2YgRE9TL0ZBVC9FWEZB
VC9OVCBGaWxlc3lzdGVtcwoKIwojIFBzZXVkbyBmaWxlc3lzdGVtcwojCkNPTkZJR19QUk9DX0ZT
PXkKIyBDT05GSUdfUFJPQ19LQ09SRSBpcyBub3Qgc2V0CkNPTkZJR19QUk9DX1NZU0NUTD15CkNP
TkZJR19QUk9DX1BBR0VfTU9OSVRPUj15CkNPTkZJR19QUk9DX0NISUxEUkVOPXkKQ09ORklHX0tF
Uk5GUz15CkNPTkZJR19TWVNGUz15CkNPTkZJR19UTVBGUz15CkNPTkZJR19UTVBGU19QT1NJWF9B
Q0w9eQpDT05GSUdfVE1QRlNfWEFUVFI9eQpDT05GSUdfTUVNRkRfQ1JFQVRFPXkKQ09ORklHX0NP
TkZJR0ZTX0ZTPW0KIyBlbmQgb2YgUHNldWRvIGZpbGVzeXN0ZW1zCgpDT05GSUdfTUlTQ19GSUxF
U1lTVEVNUz15CiMgQ09ORklHX09SQU5HRUZTX0ZTIGlzIG5vdCBzZXQKIyBDT05GSUdfQURGU19G
UyBpcyBub3Qgc2V0CkNPTkZJR19BRkZTX0ZTPW0KIyBDT05GSUdfRUNSWVBUX0ZTIGlzIG5vdCBz
ZXQKQ09ORklHX0hGU19GUz1tCkNPTkZJR19IRlNQTFVTX0ZTPW0KQ09ORklHX0JFRlNfRlM9bQpD
T05GSUdfQkVGU19ERUJVRz15CiMgQ09ORklHX0JGU19GUyBpcyBub3Qgc2V0CiMgQ09ORklHX0VG
U19GUyBpcyBub3Qgc2V0CiMgQ09ORklHX0NSQU1GUyBpcyBub3Qgc2V0CiMgQ09ORklHX1NRVUFT
SEZTIGlzIG5vdCBzZXQKIyBDT05GSUdfVlhGU19GUyBpcyBub3Qgc2V0CiMgQ09ORklHX01JTklY
X0ZTIGlzIG5vdCBzZXQKIyBDT05GSUdfT01GU19GUyBpcyBub3Qgc2V0CiMgQ09ORklHX0hQRlNf
RlMgaXMgbm90IHNldAojIENPTkZJR19RTlg0RlNfRlMgaXMgbm90IHNldAojIENPTkZJR19RTlg2
RlNfRlMgaXMgbm90IHNldAojIENPTkZJR19ST01GU19GUyBpcyBub3Qgc2V0CiMgQ09ORklHX1BT
VE9SRSBpcyBub3Qgc2V0CiMgQ09ORklHX1NZU1ZfRlMgaXMgbm90IHNldAojIENPTkZJR19VRlNf
RlMgaXMgbm90IHNldAojIENPTkZJR19FUk9GU19GUyBpcyBub3Qgc2V0CkNPTkZJR19ORVRXT1JL
X0ZJTEVTWVNURU1TPXkKQ09ORklHX05GU19GUz1tCiMgQ09ORklHX05GU19WMiBpcyBub3Qgc2V0
CiMgQ09ORklHX05GU19WMyBpcyBub3Qgc2V0CkNPTkZJR19ORlNfVjQ9bQpDT05GSUdfTkZTX1NX
QVA9eQpDT05GSUdfTkZTX1Y0XzE9eQpDT05GSUdfTkZTX1Y0XzI9eQpDT05GSUdfUE5GU19GSUxF
X0xBWU9VVD1tCkNPTkZJR19QTkZTX0JMT0NLPW0KQ09ORklHX05GU19WNF8xX0lNUExFTUVOVEFU
SU9OX0lEX0RPTUFJTj0ia2VybmVsLm9yZyIKQ09ORklHX05GU19WNF8xX01JR1JBVElPTj15CkNP
TkZJR19ORlNfVjRfU0VDVVJJVFlfTEFCRUw9eQojIENPTkZJR19ORlNfVVNFX0xFR0FDWV9ETlMg
aXMgbm90IHNldApDT05GSUdfTkZTX1VTRV9LRVJORUxfRE5TPXkKQ09ORklHX05GU19ESVNBQkxF
X1VEUF9TVVBQT1JUPXkKIyBDT05GSUdfTkZTX1Y0XzJfUkVBRF9QTFVTIGlzIG5vdCBzZXQKIyBD
T05GSUdfTkZTRCBpcyBub3Qgc2V0CkNPTkZJR19HUkFDRV9QRVJJT0Q9bQpDT05GSUdfTE9DS0Q9
bQpDT05GSUdfTkZTX0NPTU1PTj15CkNPTkZJR19ORlNfVjRfMl9TU0NfSEVMUEVSPXkKQ09ORklH
X1NVTlJQQz1tCkNPTkZJR19TVU5SUENfR1NTPW0KQ09ORklHX1NVTlJQQ19CQUNLQ0hBTk5FTD15
CkNPTkZJR19TVU5SUENfU1dBUD15CiMgQ09ORklHX1NVTlJQQ19ERUJVRyBpcyBub3Qgc2V0CiMg
Q09ORklHX0NFUEhfRlMgaXMgbm90IHNldApDT05GSUdfQ0lGUz1tCiMgQ09ORklHX0NJRlNfU1RB
VFMyIGlzIG5vdCBzZXQKQ09ORklHX0NJRlNfQUxMT1dfSU5TRUNVUkVfTEVHQUNZPXkKIyBDT05G
SUdfQ0lGU19VUENBTEwgaXMgbm90IHNldApDT05GSUdfQ0lGU19YQVRUUj15CkNPTkZJR19DSUZT
X1BPU0lYPXkKQ09ORklHX0NJRlNfREVCVUc9eQojIENPTkZJR19DSUZTX0RFQlVHMiBpcyBub3Qg
c2V0CiMgQ09ORklHX0NJRlNfREVCVUdfRFVNUF9LRVlTIGlzIG5vdCBzZXQKQ09ORklHX0NJRlNf
REZTX1VQQ0FMTD15CkNPTkZJR19DSUZTX1NXTl9VUENBTEw9eQojIENPTkZJR19TTUJfU0VSVkVS
IGlzIG5vdCBzZXQKQ09ORklHX1NNQkZTX0NPTU1PTj1tCiMgQ09ORklHX0NPREFfRlMgaXMgbm90
IHNldAojIENPTkZJR19BRlNfRlMgaXMgbm90IHNldApDT05GSUdfTkxTPXkKQ09ORklHX05MU19E
RUZBVUxUPSJ1dGY4IgpDT05GSUdfTkxTX0NPREVQQUdFXzQzNz1tCiMgQ09ORklHX05MU19DT0RF
UEFHRV83MzcgaXMgbm90IHNldAojIENPTkZJR19OTFNfQ09ERVBBR0VfNzc1IGlzIG5vdCBzZXQK
Q09ORklHX05MU19DT0RFUEFHRV84NTA9bQojIENPTkZJR19OTFNfQ09ERVBBR0VfODUyIGlzIG5v
dCBzZXQKIyBDT05GSUdfTkxTX0NPREVQQUdFXzg1NSBpcyBub3Qgc2V0CiMgQ09ORklHX05MU19D
T0RFUEFHRV84NTcgaXMgbm90IHNldAojIENPTkZJR19OTFNfQ09ERVBBR0VfODYwIGlzIG5vdCBz
ZXQKIyBDT05GSUdfTkxTX0NPREVQQUdFXzg2MSBpcyBub3Qgc2V0CiMgQ09ORklHX05MU19DT0RF
UEFHRV84NjIgaXMgbm90IHNldAojIENPTkZJR19OTFNfQ09ERVBBR0VfODYzIGlzIG5vdCBzZXQK
IyBDT05GSUdfTkxTX0NPREVQQUdFXzg2NCBpcyBub3Qgc2V0CiMgQ09ORklHX05MU19DT0RFUEFH
RV84NjUgaXMgbm90IHNldAojIENPTkZJR19OTFNfQ09ERVBBR0VfODY2IGlzIG5vdCBzZXQKIyBD
T05GSUdfTkxTX0NPREVQQUdFXzg2OSBpcyBub3Qgc2V0CiMgQ09ORklHX05MU19DT0RFUEFHRV85
MzYgaXMgbm90IHNldAojIENPTkZJR19OTFNfQ09ERVBBR0VfOTUwIGlzIG5vdCBzZXQKIyBDT05G
SUdfTkxTX0NPREVQQUdFXzkzMiBpcyBub3Qgc2V0CiMgQ09ORklHX05MU19DT0RFUEFHRV85NDkg
aXMgbm90IHNldAojIENPTkZJR19OTFNfQ09ERVBBR0VfODc0IGlzIG5vdCBzZXQKIyBDT05GSUdf
TkxTX0lTTzg4NTlfOCBpcyBub3Qgc2V0CkNPTkZJR19OTFNfQ09ERVBBR0VfMTI1MD1tCiMgQ09O
RklHX05MU19DT0RFUEFHRV8xMjUxIGlzIG5vdCBzZXQKIyBDT05GSUdfTkxTX0FTQ0lJIGlzIG5v
dCBzZXQKQ09ORklHX05MU19JU084ODU5XzE9bQojIENPTkZJR19OTFNfSVNPODg1OV8yIGlzIG5v
dCBzZXQKIyBDT05GSUdfTkxTX0lTTzg4NTlfMyBpcyBub3Qgc2V0CiMgQ09ORklHX05MU19JU084
ODU5XzQgaXMgbm90IHNldAojIENPTkZJR19OTFNfSVNPODg1OV81IGlzIG5vdCBzZXQKIyBDT05G
SUdfTkxTX0lTTzg4NTlfNiBpcyBub3Qgc2V0CiMgQ09ORklHX05MU19JU084ODU5XzcgaXMgbm90
IHNldAojIENPTkZJR19OTFNfSVNPODg1OV85IGlzIG5vdCBzZXQKIyBDT05GSUdfTkxTX0lTTzg4
NTlfMTMgaXMgbm90IHNldAojIENPTkZJR19OTFNfSVNPODg1OV8xNCBpcyBub3Qgc2V0CkNPTkZJ
R19OTFNfSVNPODg1OV8xNT1tCiMgQ09ORklHX05MU19LT0k4X1IgaXMgbm90IHNldAojIENPTkZJ
R19OTFNfS09JOF9VIGlzIG5vdCBzZXQKQ09ORklHX05MU19NQUNfUk9NQU49bQojIENPTkZJR19O
TFNfTUFDX0NFTFRJQyBpcyBub3Qgc2V0CiMgQ09ORklHX05MU19NQUNfQ0VOVEVVUk8gaXMgbm90
IHNldAojIENPTkZJR19OTFNfTUFDX0NST0FUSUFOIGlzIG5vdCBzZXQKIyBDT05GSUdfTkxTX01B
Q19DWVJJTExJQyBpcyBub3Qgc2V0CiMgQ09ORklHX05MU19NQUNfR0FFTElDIGlzIG5vdCBzZXQK
IyBDT05GSUdfTkxTX01BQ19HUkVFSyBpcyBub3Qgc2V0CiMgQ09ORklHX05MU19NQUNfSUNFTEFO
RCBpcyBub3Qgc2V0CiMgQ09ORklHX05MU19NQUNfSU5VSVQgaXMgbm90IHNldAojIENPTkZJR19O
TFNfTUFDX1JPTUFOSUFOIGlzIG5vdCBzZXQKIyBDT05GSUdfTkxTX01BQ19UVVJLSVNIIGlzIG5v
dCBzZXQKQ09ORklHX05MU19VVEY4PXkKIyBDT05GSUdfRExNIGlzIG5vdCBzZXQKIyBDT05GSUdf
VU5JQ09ERSBpcyBub3Qgc2V0CkNPTkZJR19JT19XUT15CiMgZW5kIG9mIEZpbGUgc3lzdGVtcwoK
IwojIFNlY3VyaXR5IG9wdGlvbnMKIwpDT05GSUdfS0VZUz15CiMgQ09ORklHX0tFWVNfUkVRVUVT
VF9DQUNIRSBpcyBub3Qgc2V0CiMgQ09ORklHX1BFUlNJU1RFTlRfS0VZUklOR1MgaXMgbm90IHNl
dAojIENPTkZJR19UUlVTVEVEX0tFWVMgaXMgbm90IHNldAojIENPTkZJR19FTkNSWVBURURfS0VZ
UyBpcyBub3Qgc2V0CkNPTkZJR19LRVlfREhfT1BFUkFUSU9OUz15CiMgQ09ORklHX0tFWV9OT1RJ
RklDQVRJT05TIGlzIG5vdCBzZXQKIyBDT05GSUdfU0VDVVJJVFlfRE1FU0dfUkVTVFJJQ1QgaXMg
bm90IHNldApDT05GSUdfU0VDVVJJVFk9eQojIENPTkZJR19TRUNVUklUWUZTIGlzIG5vdCBzZXQK
IyBDT05GSUdfU0VDVVJJVFlfTkVUV09SSyBpcyBub3Qgc2V0CiMgQ09ORklHX1NFQ1VSSVRZX1BB
VEggaXMgbm90IHNldApDT05GSUdfSEFWRV9IQVJERU5FRF9VU0VSQ09QWV9BTExPQ0FUT1I9eQpD
T05GSUdfSEFSREVORURfVVNFUkNPUFk9eQpDT05GSUdfRk9SVElGWV9TT1VSQ0U9eQojIENPTkZJ
R19TVEFUSUNfVVNFUk1PREVIRUxQRVIgaXMgbm90IHNldAojIENPTkZJR19TRUNVUklUWV9TTUFD
SyBpcyBub3Qgc2V0CiMgQ09ORklHX1NFQ1VSSVRZX1RPTU9ZTyBpcyBub3Qgc2V0CiMgQ09ORklH
X1NFQ1VSSVRZX0FQUEFSTU9SIGlzIG5vdCBzZXQKIyBDT05GSUdfU0VDVVJJVFlfTE9BRFBJTiBp
cyBub3Qgc2V0CkNPTkZJR19TRUNVUklUWV9ZQU1BPXkKIyBDT05GSUdfU0VDVVJJVFlfU0FGRVNF
VElEIGlzIG5vdCBzZXQKIyBDT05GSUdfU0VDVVJJVFlfTE9DS0RPV05fTFNNIGlzIG5vdCBzZXQK
IyBDT05GSUdfU0VDVVJJVFlfTEFORExPQ0sgaXMgbm90IHNldAojIENPTkZJR19JTlRFR1JJVFkg
aXMgbm90IHNldApDT05GSUdfREVGQVVMVF9TRUNVUklUWV9EQUM9eQpDT05GSUdfTFNNPSJ5YW1h
LGxvYWRwaW4sc2FmZXNldGlkLGludGVncml0eSxhcHBhcm1vcixzZWxpbnV4LHNtYWNrLHRvbW95
byIKCiMKIyBLZXJuZWwgaGFyZGVuaW5nIG9wdGlvbnMKIwoKIwojIE1lbW9yeSBpbml0aWFsaXph
dGlvbgojCkNPTkZJR19DQ19IQVNfQVVUT19WQVJfSU5JVF9QQVRURVJOPXkKQ09ORklHX0NDX0hB
U19BVVRPX1ZBUl9JTklUX1pFUk9fQkFSRT15CkNPTkZJR19DQ19IQVNfQVVUT19WQVJfSU5JVF9a
RVJPPXkKIyBDT05GSUdfSU5JVF9TVEFDS19OT05FIGlzIG5vdCBzZXQKQ09ORklHX0lOSVRfU1RB
Q0tfQUxMX1BBVFRFUk49eQojIENPTkZJR19JTklUX1NUQUNLX0FMTF9aRVJPIGlzIG5vdCBzZXQK
IyBDT05GSUdfSU5JVF9PTl9BTExPQ19ERUZBVUxUX09OIGlzIG5vdCBzZXQKIyBDT05GSUdfSU5J
VF9PTl9GUkVFX0RFRkFVTFRfT04gaXMgbm90IHNldApDT05GSUdfQ0NfSEFTX1pFUk9fQ0FMTF9V
U0VEX1JFR1M9eQpDT05GSUdfWkVST19DQUxMX1VTRURfUkVHUz15CiMgZW5kIG9mIE1lbW9yeSBp
bml0aWFsaXphdGlvbgoKIyBDT05GSUdfUkFORFNUUlVDVF9OT05FIGlzIG5vdCBzZXQKIyBDT05G
SUdfUkFORFNUUlVDVF9GVUxMIGlzIG5vdCBzZXQKQ09ORklHX1JBTkRTVFJVQ1RfUEVSRk9STUFO
Q0U9eQpDT05GSUdfUkFORFNUUlVDVD15CkNPTkZJR19HQ0NfUExVR0lOX1JBTkRTVFJVQ1Q9eQoj
IGVuZCBvZiBLZXJuZWwgaGFyZGVuaW5nIG9wdGlvbnMKIyBlbmQgb2YgU2VjdXJpdHkgb3B0aW9u
cwoKQ09ORklHX1hPUl9CTE9DS1M9eQpDT05GSUdfQ1JZUFRPPXkKCiMKIyBDcnlwdG8gY29yZSBv
ciBoZWxwZXIKIwpDT05GSUdfQ1JZUFRPX0FMR0FQST15CkNPTkZJR19DUllQVE9fQUxHQVBJMj15
CkNPTkZJR19DUllQVE9fQUVBRD1tCkNPTkZJR19DUllQVE9fQUVBRDI9eQpDT05GSUdfQ1JZUFRP
X1NLQ0lQSEVSPW0KQ09ORklHX0NSWVBUT19TS0NJUEhFUjI9eQpDT05GSUdfQ1JZUFRPX0hBU0g9
eQpDT05GSUdfQ1JZUFRPX0hBU0gyPXkKQ09ORklHX0NSWVBUT19STkc9bQpDT05GSUdfQ1JZUFRP
X1JORzI9eQpDT05GSUdfQ1JZUFRPX1JOR19ERUZBVUxUPW0KQ09ORklHX0NSWVBUT19BS0NJUEhF
UjI9eQpDT05GSUdfQ1JZUFRPX0FLQ0lQSEVSPXkKQ09ORklHX0NSWVBUT19LUFAyPXkKQ09ORklH
X0NSWVBUT19LUFA9eQpDT05GSUdfQ1JZUFRPX0FDT01QMj15CkNPTkZJR19DUllQVE9fTUFOQUdF
Uj15CkNPTkZJR19DUllQVE9fTUFOQUdFUjI9eQpDT05GSUdfQ1JZUFRPX1VTRVI9bQojIENPTkZJ
R19DUllQVE9fTUFOQUdFUl9ESVNBQkxFX1RFU1RTIGlzIG5vdCBzZXQKIyBDT05GSUdfQ1JZUFRP
X01BTkFHRVJfRVhUUkFfVEVTVFMgaXMgbm90IHNldApDT05GSUdfQ1JZUFRPX0dGMTI4TVVMPW0K
Q09ORklHX0NSWVBUT19OVUxMPW0KQ09ORklHX0NSWVBUT19OVUxMMj15CkNPTkZJR19DUllQVE9f
Q1JZUFREPW0KQ09ORklHX0NSWVBUT19BVVRIRU5DPW0KIyBDT05GSUdfQ1JZUFRPX1RFU1QgaXMg
bm90IHNldAoKIwojIFB1YmxpYy1rZXkgY3J5cHRvZ3JhcGh5CiMKQ09ORklHX0NSWVBUT19SU0E9
eQpDT05GSUdfQ1JZUFRPX0RIPXkKIyBDT05GSUdfQ1JZUFRPX0RIX1JGQzc5MTlfR1JPVVBTIGlz
IG5vdCBzZXQKQ09ORklHX0NSWVBUT19FQ0M9bQpDT05GSUdfQ1JZUFRPX0VDREg9bQojIENPTkZJ
R19DUllQVE9fRUNEU0EgaXMgbm90IHNldAojIENPTkZJR19DUllQVE9fRUNSRFNBIGlzIG5vdCBz
ZXQKIyBDT05GSUdfQ1JZUFRPX1NNMiBpcyBub3Qgc2V0CiMgQ09ORklHX0NSWVBUT19DVVJWRTI1
NTE5IGlzIG5vdCBzZXQKCiMKIyBBdXRoZW50aWNhdGVkIEVuY3J5cHRpb24gd2l0aCBBc3NvY2lh
dGVkIERhdGEKIwpDT05GSUdfQ1JZUFRPX0NDTT1tCkNPTkZJR19DUllQVE9fR0NNPW0KQ09ORklH
X0NSWVBUT19DSEFDSEEyMFBPTFkxMzA1PW0KIyBDT05GSUdfQ1JZUFRPX0FFR0lTMTI4IGlzIG5v
dCBzZXQKQ09ORklHX0NSWVBUT19TRVFJVj1tCkNPTkZJR19DUllQVE9fRUNIQUlOSVY9bQoKIwoj
IEJsb2NrIG1vZGVzCiMKQ09ORklHX0NSWVBUT19DQkM9bQojIENPTkZJR19DUllQVE9fQ0ZCIGlz
IG5vdCBzZXQKQ09ORklHX0NSWVBUT19DVFI9bQojIENPTkZJR19DUllQVE9fQ1RTIGlzIG5vdCBz
ZXQKQ09ORklHX0NSWVBUT19FQ0I9bQojIENPTkZJR19DUllQVE9fTFJXIGlzIG5vdCBzZXQKIyBD
T05GSUdfQ1JZUFRPX09GQiBpcyBub3Qgc2V0CkNPTkZJR19DUllQVE9fUENCQz1tCkNPTkZJR19D
UllQVE9fWFRTPW0KIyBDT05GSUdfQ1JZUFRPX0tFWVdSQVAgaXMgbm90IHNldApDT05GSUdfQ1JZ
UFRPX05IUE9MWTEzMDU9bQpDT05GSUdfQ1JZUFRPX0FESUFOVFVNPW0KIyBDT05GSUdfQ1JZUFRP
X0hDVFIyIGlzIG5vdCBzZXQKQ09ORklHX0NSWVBUT19FU1NJVj1tCgojCiMgSGFzaCBtb2Rlcwoj
CkNPTkZJR19DUllQVE9fQ01BQz1tCkNPTkZJR19DUllQVE9fSE1BQz15CiMgQ09ORklHX0NSWVBU
T19YQ0JDIGlzIG5vdCBzZXQKIyBDT05GSUdfQ1JZUFRPX1ZNQUMgaXMgbm90IHNldAoKIwojIERp
Z2VzdAojCkNPTkZJR19DUllQVE9fQ1JDMzJDPXkKQ09ORklHX0NSWVBUT19DUkMzMj1tCkNPTkZJ
R19DUllQVE9fWFhIQVNIPXkKQ09ORklHX0NSWVBUT19CTEFLRTJCPXkKQ09ORklHX0NSWVBUT19D
UkNUMTBESUY9eQpDT05GSUdfQ1JZUFRPX0dIQVNIPW0KQ09ORklHX0NSWVBUT19QT0xZMTMwNT1t
CkNPTkZJR19DUllQVE9fTUQ0PW0KQ09ORklHX0NSWVBUT19NRDU9bQpDT05GSUdfQ1JZUFRPX01E
NV9QUEM9bQojIENPTkZJR19DUllQVE9fTUlDSEFFTF9NSUMgaXMgbm90IHNldAojIENPTkZJR19D
UllQVE9fUk1EMTYwIGlzIG5vdCBzZXQKQ09ORklHX0NSWVBUT19TSEExPW0KQ09ORklHX0NSWVBU
T19TSEExX1BQQz1tCkNPTkZJR19DUllQVE9fU0hBMjU2PXkKQ09ORklHX0NSWVBUT19TSEE1MTI9
bQojIENPTkZJR19DUllQVE9fU0hBMyBpcyBub3Qgc2V0CiMgQ09ORklHX0NSWVBUT19TTTNfR0VO
RVJJQyBpcyBub3Qgc2V0CiMgQ09ORklHX0NSWVBUT19TVFJFRUJPRyBpcyBub3Qgc2V0CiMgQ09O
RklHX0NSWVBUT19XUDUxMiBpcyBub3Qgc2V0CgojCiMgQ2lwaGVycwojCkNPTkZJR19DUllQVE9f
QUVTPW0KIyBDT05GSUdfQ1JZUFRPX0FFU19USSBpcyBub3Qgc2V0CiMgQ09ORklHX0NSWVBUT19C
TE9XRklTSCBpcyBub3Qgc2V0CiMgQ09ORklHX0NSWVBUT19DQU1FTExJQSBpcyBub3Qgc2V0CiMg
Q09ORklHX0NSWVBUT19DQVNUNSBpcyBub3Qgc2V0CiMgQ09ORklHX0NSWVBUT19DQVNUNiBpcyBu
b3Qgc2V0CkNPTkZJR19DUllQVE9fREVTPW0KQ09ORklHX0NSWVBUT19GQ1JZUFQ9bQpDT05GSUdf
Q1JZUFRPX0NIQUNIQTIwPW0KIyBDT05GSUdfQ1JZUFRPX0FSSUEgaXMgbm90IHNldAojIENPTkZJ
R19DUllQVE9fU0VSUEVOVCBpcyBub3Qgc2V0CiMgQ09ORklHX0NSWVBUT19TTTRfR0VORVJJQyBp
cyBub3Qgc2V0CkNPTkZJR19DUllQVE9fVFdPRklTSD1tCkNPTkZJR19DUllQVE9fVFdPRklTSF9D
T01NT049bQoKIwojIENvbXByZXNzaW9uCiMKQ09ORklHX0NSWVBUT19ERUZMQVRFPW0KQ09ORklH
X0NSWVBUT19MWk89eQojIENPTkZJR19DUllQVE9fODQyIGlzIG5vdCBzZXQKIyBDT05GSUdfQ1JZ
UFRPX0xaNCBpcyBub3Qgc2V0CiMgQ09ORklHX0NSWVBUT19MWjRIQyBpcyBub3Qgc2V0CkNPTkZJ
R19DUllQVE9fWlNURD1tCgojCiMgUmFuZG9tIE51bWJlciBHZW5lcmF0aW9uCiMKQ09ORklHX0NS
WVBUT19BTlNJX0NQUk5HPW0KQ09ORklHX0NSWVBUT19EUkJHX01FTlU9bQpDT05GSUdfQ1JZUFRP
X0RSQkdfSE1BQz15CiMgQ09ORklHX0NSWVBUT19EUkJHX0hBU0ggaXMgbm90IHNldAojIENPTkZJ
R19DUllQVE9fRFJCR19DVFIgaXMgbm90IHNldApDT05GSUdfQ1JZUFRPX0RSQkc9bQpDT05GSUdf
Q1JZUFRPX0pJVFRFUkVOVFJPUFk9bQpDT05GSUdfQ1JZUFRPX0tERjgwMDEwOF9DVFI9eQpDT05G
SUdfQ1JZUFRPX1VTRVJfQVBJPXkKQ09ORklHX0NSWVBUT19VU0VSX0FQSV9IQVNIPXkKQ09ORklH
X0NSWVBUT19VU0VSX0FQSV9TS0NJUEhFUj1tCkNPTkZJR19DUllQVE9fVVNFUl9BUElfUk5HPW0K
IyBDT05GSUdfQ1JZUFRPX1VTRVJfQVBJX1JOR19DQVZQIGlzIG5vdCBzZXQKQ09ORklHX0NSWVBU
T19VU0VSX0FQSV9BRUFEPW0KIyBDT05GSUdfQ1JZUFRPX1VTRVJfQVBJX0VOQUJMRV9PQlNPTEVU
RSBpcyBub3Qgc2V0CiMgQ09ORklHX0NSWVBUT19TVEFUUyBpcyBub3Qgc2V0CkNPTkZJR19DUllQ
VE9fSEFTSF9JTkZPPXkKIyBDT05GSUdfQ1JZUFRPX0hXIGlzIG5vdCBzZXQKQ09ORklHX0FTWU1N
RVRSSUNfS0VZX1RZUEU9eQpDT05GSUdfQVNZTU1FVFJJQ19QVUJMSUNfS0VZX1NVQlRZUEU9eQpD
T05GSUdfWDUwOV9DRVJUSUZJQ0FURV9QQVJTRVI9eQpDT05GSUdfUEtDUzhfUFJJVkFURV9LRVlf
UEFSU0VSPW0KQ09ORklHX1BLQ1M3X01FU1NBR0VfUEFSU0VSPXkKIyBDT05GSUdfUEtDUzdfVEVT
VF9LRVkgaXMgbm90IHNldAojIENPTkZJR19TSUdORURfUEVfRklMRV9WRVJJRklDQVRJT04gaXMg
bm90IHNldAojIENPTkZJR19GSVBTX1NJR05BVFVSRV9TRUxGVEVTVCBpcyBub3Qgc2V0CgojCiMg
Q2VydGlmaWNhdGVzIGZvciBzaWduYXR1cmUgY2hlY2tpbmcKIwpDT05GSUdfU1lTVEVNX1RSVVNU
RURfS0VZUklORz15CkNPTkZJR19TWVNURU1fVFJVU1RFRF9LRVlTPSIiCiMgQ09ORklHX1NZU1RF
TV9FWFRSQV9DRVJUSUZJQ0FURSBpcyBub3Qgc2V0CiMgQ09ORklHX1NFQ09OREFSWV9UUlVTVEVE
X0tFWVJJTkcgaXMgbm90IHNldAojIENPTkZJR19TWVNURU1fQkxBQ0tMSVNUX0tFWVJJTkcgaXMg
bm90IHNldAojIGVuZCBvZiBDZXJ0aWZpY2F0ZXMgZm9yIHNpZ25hdHVyZSBjaGVja2luZwoKQ09O
RklHX0JJTkFSWV9QUklOVEY9eQoKIwojIExpYnJhcnkgcm91dGluZXMKIwpDT05GSUdfUkFJRDZf
UFE9eQpDT05GSUdfUkFJRDZfUFFfQkVOQ0hNQVJLPXkKQ09ORklHX0xJTkVBUl9SQU5HRVM9eQoj
IENPTkZJR19QQUNLSU5HIGlzIG5vdCBzZXQKQ09ORklHX0JJVFJFVkVSU0U9eQpDT05GSUdfR0VO
RVJJQ19TVFJOQ1BZX0ZST01fVVNFUj15CkNPTkZJR19HRU5FUklDX1NUUk5MRU5fVVNFUj15CkNP
TkZJR19HRU5FUklDX05FVF9VVElMUz15CiMgQ09ORklHX0NPUkRJQyBpcyBub3Qgc2V0CiMgQ09O
RklHX1BSSU1FX05VTUJFUlMgaXMgbm90IHNldApDT05GSUdfR0VORVJJQ19QQ0lfSU9NQVA9eQoK
IwojIENyeXB0byBsaWJyYXJ5IHJvdXRpbmVzCiMKQ09ORklHX0NSWVBUT19MSUJfQUVTPW0KQ09O
RklHX0NSWVBUT19MSUJfQVJDND1tCkNPTkZJR19DUllQVE9fTElCX0JMQUtFMlNfR0VORVJJQz15
CkNPTkZJR19DUllQVE9fTElCX0NIQUNIQV9HRU5FUklDPW0KQ09ORklHX0NSWVBUT19MSUJfQ0hB
Q0hBPW0KQ09ORklHX0NSWVBUT19MSUJfQ1VSVkUyNTUxOV9HRU5FUklDPW0KQ09ORklHX0NSWVBU
T19MSUJfQ1VSVkUyNTUxOT1tCkNPTkZJR19DUllQVE9fTElCX0RFUz1tCkNPTkZJR19DUllQVE9f
TElCX1BPTFkxMzA1X1JTSVpFPTEKQ09ORklHX0NSWVBUT19MSUJfUE9MWTEzMDVfR0VORVJJQz1t
CkNPTkZJR19DUllQVE9fTElCX1BPTFkxMzA1PW0KQ09ORklHX0NSWVBUT19MSUJfQ0hBQ0hBMjBQ
T0xZMTMwNT1tCkNPTkZJR19DUllQVE9fTElCX1NIQTE9eQpDT05GSUdfQ1JZUFRPX0xJQl9TSEEy
NTY9eQojIGVuZCBvZiBDcnlwdG8gbGlicmFyeSByb3V0aW5lcwoKQ09ORklHX0xJQl9NRU1ORVE9
eQpDT05GSUdfQ1JDX0NDSVRUPW0KQ09ORklHX0NSQzE2PXkKIyBDT05GSUdfQ1JDX1QxMERJRiBp
cyBub3Qgc2V0CiMgQ09ORklHX0NSQzY0X1JPQ0tTT0ZUIGlzIG5vdCBzZXQKQ09ORklHX0NSQ19J
VFVfVD1tCkNPTkZJR19DUkMzMj15CiMgQ09ORklHX0NSQzMyX1NFTEZURVNUIGlzIG5vdCBzZXQK
Q09ORklHX0NSQzMyX1NMSUNFQlk4PXkKIyBDT05GSUdfQ1JDMzJfU0xJQ0VCWTQgaXMgbm90IHNl
dAojIENPTkZJR19DUkMzMl9TQVJXQVRFIGlzIG5vdCBzZXQKIyBDT05GSUdfQ1JDMzJfQklUIGlz
IG5vdCBzZXQKIyBDT05GSUdfQ1JDNjQgaXMgbm90IHNldAojIENPTkZJR19DUkM0IGlzIG5vdCBz
ZXQKIyBDT05GSUdfQ1JDNyBpcyBub3Qgc2V0CkNPTkZJR19MSUJDUkMzMkM9eQojIENPTkZJR19D
UkM4IGlzIG5vdCBzZXQKQ09ORklHX1hYSEFTSD15CiMgQ09ORklHX1JBTkRPTTMyX1NFTEZURVNU
IGlzIG5vdCBzZXQKQ09ORklHX1pMSUJfSU5GTEFURT15CkNPTkZJR19aTElCX0RFRkxBVEU9eQpD
T05GSUdfTFpPX0NPTVBSRVNTPXkKQ09ORklHX0xaT19ERUNPTVBSRVNTPXkKQ09ORklHX1pTVERf
Q09NUFJFU1M9eQpDT05GSUdfWlNURF9ERUNPTVBSRVNTPXkKIyBDT05GSUdfWFpfREVDIGlzIG5v
dCBzZXQKQ09ORklHX0dFTkVSSUNfQUxMT0NBVE9SPXkKQ09ORklHX0lOVEVSVkFMX1RSRUU9eQpD
T05GSUdfQVNTT0NJQVRJVkVfQVJSQVk9eQpDT05GSUdfSEFTX0lPTUVNPXkKQ09ORklHX0hBU19J
T1BPUlRfTUFQPXkKQ09ORklHX0hBU19ETUE9eQpDT05GSUdfTkVFRF9TR19ETUFfTEVOR1RIPXkK
Q09ORklHX0RNQV9ERUNMQVJFX0NPSEVSRU5UPXkKIyBDT05GSUdfRE1BX0FQSV9ERUJVRyBpcyBu
b3Qgc2V0CkNPTkZJR19TR0xfQUxMT0M9eQpDT05GSUdfRFFMPXkKQ09ORklHX0dMT0I9eQojIENP
TkZJR19HTE9CX1NFTEZURVNUIGlzIG5vdCBzZXQKQ09ORklHX05MQVRUUj15CkNPTkZJR19HRU5F
UklDX0FUT01JQzY0PXkKQ09ORklHX0NMWl9UQUI9eQpDT05GSUdfSVJRX1BPTEw9eQpDT05GSUdf
TVBJTElCPXkKQ09ORklHX0xJQkZEVD15CkNPTkZJR19PSURfUkVHSVNUUlk9eQpDT05GSUdfSEFW
RV9HRU5FUklDX1ZEU089eQpDT05GSUdfR0VORVJJQ19HRVRUSU1FT0ZEQVk9eQpDT05GSUdfR0VO
RVJJQ19WRFNPX1RJTUVfTlM9eQpDT05GSUdfRk9OVF9TVVBQT1JUPXkKIyBDT05GSUdfRk9OVFMg
aXMgbm90IHNldApDT05GSUdfRk9OVF84eDg9eQpDT05GSUdfRk9OVF84eDE2PXkKQ09ORklHX1NH
X1BPT0w9eQpDT05GSUdfQVJDSF9IQVNfUE1FTV9BUEk9eQpDT05GSUdfQVJDSF9IQVNfVUFDQ0VT
U19GTFVTSENBQ0hFPXkKQ09ORklHX0FSQ0hfU1RBQ0tXQUxLPXkKQ09ORklHX1NUQUNLREVQT1Q9
eQpDT05GSUdfUkVGX1RSQUNLRVI9eQpDT05GSUdfU0JJVE1BUD15CiMgZW5kIG9mIExpYnJhcnkg
cm91dGluZXMKCiMKIyBLZXJuZWwgaGFja2luZwojCgojCiMgcHJpbnRrIGFuZCBkbWVzZyBvcHRp
b25zCiMKIyBDT05GSUdfUFJJTlRLX1RJTUUgaXMgbm90IHNldAojIENPTkZJR19QUklOVEtfQ0FM
TEVSIGlzIG5vdCBzZXQKIyBDT05GSUdfU1RBQ0tUUkFDRV9CVUlMRF9JRCBpcyBub3Qgc2V0CkNP
TkZJR19DT05TT0xFX0xPR0xFVkVMX0RFRkFVTFQ9NwpDT05GSUdfQ09OU09MRV9MT0dMRVZFTF9R
VUlFVD00CkNPTkZJR19NRVNTQUdFX0xPR0xFVkVMX0RFRkFVTFQ9NAojIENPTkZJR19EWU5BTUlD
X0RFQlVHIGlzIG5vdCBzZXQKIyBDT05GSUdfRFlOQU1JQ19ERUJVR19DT1JFIGlzIG5vdCBzZXQK
Q09ORklHX1NZTUJPTElDX0VSUk5BTUU9eQpDT05GSUdfREVCVUdfQlVHVkVSQk9TRT15CiMgZW5k
IG9mIHByaW50ayBhbmQgZG1lc2cgb3B0aW9ucwoKQ09ORklHX0RFQlVHX0tFUk5FTD15CiMgQ09O
RklHX0RFQlVHX01JU0MgaXMgbm90IHNldAoKIwojIENvbXBpbGUtdGltZSBjaGVja3MgYW5kIGNv
bXBpbGVyIG9wdGlvbnMKIwpDT05GSUdfREVCVUdfSU5GTz15CkNPTkZJR19BU19IQVNfTk9OX0NP
TlNUX0xFQjEyOD15CiMgQ09ORklHX0RFQlVHX0lORk9fTk9ORSBpcyBub3Qgc2V0CkNPTkZJR19E
RUJVR19JTkZPX0RXQVJGX1RPT0xDSEFJTl9ERUZBVUxUPXkKIyBDT05GSUdfREVCVUdfSU5GT19E
V0FSRjQgaXMgbm90IHNldAojIENPTkZJR19ERUJVR19JTkZPX0RXQVJGNSBpcyBub3Qgc2V0CkNP
TkZJR19ERUJVR19JTkZPX1JFRFVDRUQ9eQpDT05GSUdfREVCVUdfSU5GT19DT01QUkVTU0VEPXkK
Q09ORklHX0RFQlVHX0lORk9fU1BMSVQ9eQojIENPTkZJR19HREJfU0NSSVBUUyBpcyBub3Qgc2V0
CkNPTkZJR19GUkFNRV9XQVJOPTEwMjQKQ09ORklHX1NUUklQX0FTTV9TWU1TPXkKIyBDT05GSUdf
UkVBREFCTEVfQVNNIGlzIG5vdCBzZXQKIyBDT05GSUdfSEVBREVSU19JTlNUQUxMIGlzIG5vdCBz
ZXQKIyBDT05GSUdfREVCVUdfU0VDVElPTl9NSVNNQVRDSCBpcyBub3Qgc2V0CkNPTkZJR19TRUNU
SU9OX01JU01BVENIX1dBUk5fT05MWT15CiMgQ09ORklHX0RFQlVHX0ZPUkNFX0ZVTkNUSU9OX0FM
SUdOXzY0QiBpcyBub3Qgc2V0CiMgQ09ORklHX1ZNTElOVVhfTUFQIGlzIG5vdCBzZXQKIyBDT05G
SUdfREVCVUdfRk9SQ0VfV0VBS19QRVJfQ1BVIGlzIG5vdCBzZXQKIyBlbmQgb2YgQ29tcGlsZS10
aW1lIGNoZWNrcyBhbmQgY29tcGlsZXIgb3B0aW9ucwoKIwojIEdlbmVyaWMgS2VybmVsIERlYnVn
Z2luZyBJbnN0cnVtZW50cwojCiMgQ09ORklHX01BR0lDX1NZU1JRIGlzIG5vdCBzZXQKIyBDT05G
SUdfREVCVUdfRlMgaXMgbm90IHNldApDT05GSUdfSEFWRV9BUkNIX0tHREI9eQojIENPTkZJR19L
R0RCIGlzIG5vdCBzZXQKQ09ORklHX0FSQ0hfSEFTX1VCU0FOX1NBTklUSVpFX0FMTD15CiMgQ09O
RklHX1VCU0FOIGlzIG5vdCBzZXQKQ09ORklHX0hBVkVfS0NTQU5fQ09NUElMRVI9eQojIGVuZCBv
ZiBHZW5lcmljIEtlcm5lbCBEZWJ1Z2dpbmcgSW5zdHJ1bWVudHMKCiMKIyBOZXR3b3JraW5nIERl
YnVnZ2luZwojCkNPTkZJR19ORVRfREVWX1JFRkNOVF9UUkFDS0VSPXkKQ09ORklHX05FVF9OU19S
RUZDTlRfVFJBQ0tFUj15CkNPTkZJR19ERUJVR19ORVQ9eQojIGVuZCBvZiBOZXR3b3JraW5nIERl
YnVnZ2luZwoKIwojIE1lbW9yeSBEZWJ1Z2dpbmcKIwojIENPTkZJR19QQUdFX0VYVEVOU0lPTiBp
cyBub3Qgc2V0CkNPTkZJR19ERUJVR19QQUdFQUxMT0M9eQojIENPTkZJR19ERUJVR19QQUdFQUxM
T0NfRU5BQkxFX0RFRkFVTFQgaXMgbm90IHNldApDT05GSUdfU0xVQl9ERUJVRz15CiMgQ09ORklH
X1NMVUJfREVCVUdfT04gaXMgbm90IHNldAojIENPTkZJR19QQUdFX09XTkVSIGlzIG5vdCBzZXQK
Q09ORklHX1BBR0VfUE9JU09OSU5HPXkKQ09ORklHX0RFQlVHX1JPREFUQV9URVNUPXkKQ09ORklH
X0FSQ0hfSEFTX0RFQlVHX1dYPXkKQ09ORklHX0RFQlVHX1dYPXkKQ09ORklHX0dFTkVSSUNfUFRE
VU1QPXkKQ09ORklHX1BURFVNUF9DT1JFPXkKIyBDT05GSUdfREVCVUdfT0JKRUNUUyBpcyBub3Qg
c2V0CkNPTkZJR19IQVZFX0RFQlVHX0tNRU1MRUFLPXkKIyBDT05GSUdfREVCVUdfS01FTUxFQUsg
aXMgbm90IHNldAojIENPTkZJR19ERUJVR19TVEFDS19VU0FHRSBpcyBub3Qgc2V0CkNPTkZJR19T
Q0hFRF9TVEFDS19FTkRfQ0hFQ0s9eQpDT05GSUdfQVJDSF9IQVNfREVCVUdfVk1fUEdUQUJMRT15
CiMgQ09ORklHX0RFQlVHX1ZNIGlzIG5vdCBzZXQKQ09ORklHX0RFQlVHX1ZNX1BHVEFCTEU9eQpD
T05GSUdfQVJDSF9IQVNfREVCVUdfVklSVFVBTD15CiMgQ09ORklHX0RFQlVHX1ZJUlRVQUwgaXMg
bm90IHNldApDT05GSUdfREVCVUdfTUVNT1JZX0lOSVQ9eQojIENPTkZJR19ERUJVR19LTUFQX0xP
Q0FMIGlzIG5vdCBzZXQKIyBDT05GSUdfREVCVUdfSElHSE1FTSBpcyBub3Qgc2V0CkNPTkZJR19I
QVZFX0RFQlVHX1NUQUNLT1ZFUkZMT1c9eQpDT05GSUdfREVCVUdfU1RBQ0tPVkVSRkxPVz15CkNP
TkZJR19IQVZFX0FSQ0hfS0FTQU49eQpDT05GSUdfSEFWRV9BUkNIX0tBU0FOX1ZNQUxMT0M9eQpD
T05GSUdfQ0NfSEFTX0tBU0FOX0dFTkVSSUM9eQpDT05GSUdfQ0NfSEFTX1dPUktJTkdfTk9TQU5J
VElaRV9BRERSRVNTPXkKIyBDT05GSUdfS0FTQU4gaXMgbm90IHNldApDT05GSUdfSEFWRV9BUkNI
X0tGRU5DRT15CkNPTkZJR19LRkVOQ0U9eQpDT05GSUdfS0ZFTkNFX1NBTVBMRV9JTlRFUlZBTD0x
MDAKQ09ORklHX0tGRU5DRV9OVU1fT0JKRUNUUz0yNTUKIyBDT05GSUdfS0ZFTkNFX0RFRkVSUkFC
TEUgaXMgbm90IHNldAojIENPTkZJR19LRkVOQ0VfU1RBVElDX0tFWVMgaXMgbm90IHNldApDT05G
SUdfS0ZFTkNFX1NUUkVTU19URVNUX0ZBVUxUUz0wCiMgZW5kIG9mIE1lbW9yeSBEZWJ1Z2dpbmcK
CkNPTkZJR19ERUJVR19TSElSUT15CgojCiMgRGVidWcgT29wcywgTG9ja3VwcyBhbmQgSGFuZ3MK
IwojIENPTkZJR19QQU5JQ19PTl9PT1BTIGlzIG5vdCBzZXQKQ09ORklHX1BBTklDX09OX09PUFNf
VkFMVUU9MApDT05GSUdfTE9DS1VQX0RFVEVDVE9SPXkKQ09ORklHX1NPRlRMT0NLVVBfREVURUNU
T1I9eQpDT05GSUdfQk9PVFBBUkFNX1NPRlRMT0NLVVBfUEFOSUM9eQpDT05GSUdfREVURUNUX0hV
TkdfVEFTSz15CkNPTkZJR19ERUZBVUxUX0hVTkdfVEFTS19USU1FT1VUPTQwCiMgQ09ORklHX0JP
T1RQQVJBTV9IVU5HX1RBU0tfUEFOSUMgaXMgbm90IHNldApDT05GSUdfV1FfV0FUQ0hET0c9eQoj
IENPTkZJR19URVNUX0xPQ0tVUCBpcyBub3Qgc2V0CiMgZW5kIG9mIERlYnVnIE9vcHMsIExvY2t1
cHMgYW5kIEhhbmdzCgojCiMgU2NoZWR1bGVyIERlYnVnZ2luZwojCiMgQ09ORklHX1NDSEVEX0RF
QlVHIGlzIG5vdCBzZXQKQ09ORklHX1NDSEVEX0lORk89eQojIENPTkZJR19TQ0hFRFNUQVRTIGlz
IG5vdCBzZXQKIyBlbmQgb2YgU2NoZWR1bGVyIERlYnVnZ2luZwoKIyBDT05GSUdfREVCVUdfVElN
RUtFRVBJTkcgaXMgbm90IHNldAoKIwojIExvY2sgRGVidWdnaW5nIChzcGlubG9ja3MsIG11dGV4
ZXMsIGV0Yy4uLikKIwpDT05GSUdfTE9DS19ERUJVR0dJTkdfU1VQUE9SVD15CiMgQ09ORklHX1BS
T1ZFX0xPQ0tJTkcgaXMgbm90IHNldAojIENPTkZJR19MT0NLX1NUQVQgaXMgbm90IHNldApDT05G
SUdfREVCVUdfUlRfTVVURVhFUz15CkNPTkZJR19ERUJVR19TUElOTE9DSz15CkNPTkZJR19ERUJV
R19NVVRFWEVTPXkKIyBDT05GSUdfREVCVUdfV1dfTVVURVhfU0xPV1BBVEggaXMgbm90IHNldApD
T05GSUdfREVCVUdfUldTRU1TPXkKIyBDT05GSUdfREVCVUdfTE9DS19BTExPQyBpcyBub3Qgc2V0
CiMgQ09ORklHX0RFQlVHX0FUT01JQ19TTEVFUCBpcyBub3Qgc2V0CiMgQ09ORklHX0RFQlVHX0xP
Q0tJTkdfQVBJX1NFTEZURVNUUyBpcyBub3Qgc2V0CiMgQ09ORklHX0xPQ0tfVE9SVFVSRV9URVNU
IGlzIG5vdCBzZXQKIyBDT05GSUdfV1dfTVVURVhfU0VMRlRFU1QgaXMgbm90IHNldAojIENPTkZJ
R19TQ0ZfVE9SVFVSRV9URVNUIGlzIG5vdCBzZXQKIyBlbmQgb2YgTG9jayBEZWJ1Z2dpbmcgKHNw
aW5sb2NrcywgbXV0ZXhlcywgZXRjLi4uKQoKQ09ORklHX0RFQlVHX0lSUUZMQUdTPXkKQ09ORklH
X1NUQUNLVFJBQ0U9eQojIENPTkZJR19XQVJOX0FMTF9VTlNFRURFRF9SQU5ET00gaXMgbm90IHNl
dAojIENPTkZJR19ERUJVR19LT0JKRUNUIGlzIG5vdCBzZXQKCiMKIyBEZWJ1ZyBrZXJuZWwgZGF0
YSBzdHJ1Y3R1cmVzCiMKQ09ORklHX0RFQlVHX0xJU1Q9eQojIENPTkZJR19ERUJVR19QTElTVCBp
cyBub3Qgc2V0CkNPTkZJR19ERUJVR19TRz15CkNPTkZJR19ERUJVR19OT1RJRklFUlM9eQpDT05G
SUdfQlVHX09OX0RBVEFfQ09SUlVQVElPTj15CiMgZW5kIG9mIERlYnVnIGtlcm5lbCBkYXRhIHN0
cnVjdHVyZXMKCkNPTkZJR19ERUJVR19DUkVERU5USUFMUz15CgojCiMgUkNVIERlYnVnZ2luZwoj
CiMgQ09ORklHX1JDVV9TQ0FMRV9URVNUIGlzIG5vdCBzZXQKIyBDT05GSUdfUkNVX1RPUlRVUkVf
VEVTVCBpcyBub3Qgc2V0CiMgQ09ORklHX1JDVV9SRUZfU0NBTEVfVEVTVCBpcyBub3Qgc2V0CiMg
Q09ORklHX1JDVV9UUkFDRSBpcyBub3Qgc2V0CiMgQ09ORklHX1JDVV9FUVNfREVCVUcgaXMgbm90
IHNldAojIGVuZCBvZiBSQ1UgRGVidWdnaW5nCgojIENPTkZJR19ERUJVR19XUV9GT1JDRV9SUl9D
UFUgaXMgbm90IHNldAojIENPTkZJR19MQVRFTkNZVE9QIGlzIG5vdCBzZXQKQ09ORklHX0hBVkVf
RlVOQ1RJT05fVFJBQ0VSPXkKQ09ORklHX0hBVkVfRlVOQ1RJT05fR1JBUEhfVFJBQ0VSPXkKQ09O
RklHX0hBVkVfRFlOQU1JQ19GVFJBQ0U9eQpDT05GSUdfSEFWRV9EWU5BTUlDX0ZUUkFDRV9XSVRI
X1JFR1M9eQpDT05GSUdfSEFWRV9EWU5BTUlDX0ZUUkFDRV9XSVRIX0FSR1M9eQpDT05GSUdfSEFW
RV9GVFJBQ0VfTUNPVU5UX1JFQ09SRD15CkNPTkZJR19IQVZFX1NZU0NBTExfVFJBQ0VQT0lOVFM9
eQpDT05GSUdfSEFWRV9DX1JFQ09SRE1DT1VOVD15CkNPTkZJR19UUkFDSU5HX1NVUFBPUlQ9eQoj
IENPTkZJR19GVFJBQ0UgaXMgbm90IHNldAojIENPTkZJR19TQU1QTEVTIGlzIG5vdCBzZXQKQ09O
RklHX0FSQ0hfSEFTX0RFVk1FTV9JU19BTExPV0VEPXkKQ09ORklHX1NUUklDVF9ERVZNRU09eQpD
T05GSUdfSU9fU1RSSUNUX0RFVk1FTT15CgojCiMgcG93ZXJwYyBEZWJ1Z2dpbmcKIwojIENPTkZJ
R19QUENfRElTQUJMRV9XRVJST1IgaXMgbm90IHNldApDT05GSUdfUFBDX1dFUlJPUj15CkNPTkZJ
R19QUklOVF9TVEFDS19ERVBUSD02NAojIENPTkZJR19DT0RFX1BBVENISU5HX1NFTEZURVNUIGlz
IG5vdCBzZXQKIyBDT05GSUdfSlVNUF9MQUJFTF9GRUFUVVJFX0NIRUNLUyBpcyBub3Qgc2V0CiMg
Q09ORklHX0ZUUl9GSVhVUF9TRUxGVEVTVCBpcyBub3Qgc2V0CiMgQ09ORklHX01TSV9CSVRNQVBf
U0VMRlRFU1QgaXMgbm90IHNldAojIENPTkZJR19YTU9OIGlzIG5vdCBzZXQKIyBDT05GSUdfQkRJ
X1NXSVRDSCBpcyBub3Qgc2V0CkNPTkZJR19CT09UWF9URVhUPXkKIyBDT05GSUdfUFBDX0VBUkxZ
X0RFQlVHIGlzIG5vdCBzZXQKIyBlbmQgb2YgcG93ZXJwYyBEZWJ1Z2dpbmcKCiMKIyBLZXJuZWwg
VGVzdGluZyBhbmQgQ292ZXJhZ2UKIwojIENPTkZJR19LVU5JVCBpcyBub3Qgc2V0CiMgQ09ORklH
X05PVElGSUVSX0VSUk9SX0lOSkVDVElPTiBpcyBub3Qgc2V0CiMgQ09ORklHX0ZBVUxUX0lOSkVD
VElPTiBpcyBub3Qgc2V0CkNPTkZJR19BUkNIX0hBU19LQ09WPXkKQ09ORklHX0NDX0hBU19TQU5D
T1ZfVFJBQ0VfUEM9eQojIENPTkZJR19LQ09WIGlzIG5vdCBzZXQKIyBDT05GSUdfUlVOVElNRV9U
RVNUSU5HX01FTlUgaXMgbm90IHNldApDT05GSUdfQVJDSF9VU0VfTUVNVEVTVD15CiMgQ09ORklH
X01FTVRFU1QgaXMgbm90IHNldAojIGVuZCBvZiBLZXJuZWwgVGVzdGluZyBhbmQgQ292ZXJhZ2UK
IyBlbmQgb2YgS2VybmVsIGhhY2tpbmcKCiMKIyBHZW50b28gTGludXgKIwpDT05GSUdfR0VOVE9P
X0xJTlVYPXkKQ09ORklHX0dFTlRPT19MSU5VWF9VREVWPXkKQ09ORklHX0dFTlRPT19MSU5VWF9Q
T1JUQUdFPXkKCiMKIyBTdXBwb3J0IGZvciBpbml0IHN5c3RlbXMsIHN5c3RlbSBhbmQgc2Vydmlj
ZSBtYW5hZ2VycwojCkNPTkZJR19HRU5UT09fTElOVVhfSU5JVF9TQ1JJUFQ9eQpDT05GSUdfR0VO
VE9PX0xJTlVYX0lOSVRfU1lTVEVNRD15CiMgZW5kIG9mIFN1cHBvcnQgZm9yIGluaXQgc3lzdGVt
cywgc3lzdGVtIGFuZCBzZXJ2aWNlIG1hbmFnZXJzCgojIENPTkZJR19HRU5UT09fS0VSTkVMX1NF
TEZfUFJPVEVDVElPTiBpcyBub3Qgc2V0CkNPTkZJR19HRU5UT09fUFJJTlRfRklSTVdBUkVfSU5G
Tz15CiMgZW5kIG9mIEdlbnRvbyBMaW51eAo=

--MP_/xQFfg_Dl4TlDy/Gy8DdNHbA--
