Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72A675F3C1C
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 06:30:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229548AbiJDEas (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 00:30:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbiJDEap (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 00:30:45 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 766E622B22
        for <linux-kernel@vger.kernel.org>; Mon,  3 Oct 2022 21:30:43 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id hy2so26260773ejc.8
        for <linux-kernel@vger.kernel.org>; Mon, 03 Oct 2022 21:30:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=YrZJ8n5n4xqOkzPQJHlDZNj6f3cJzeEg186nmWnKR6Y=;
        b=IENOH+3dQJykA3faO1a29fHH0JdpUHXLqmWbdtWNJEuo4cX7d4SNzKQlO3gnO+axlB
         l5iDt3SpknbbZoEHLzFY/jPtNuvsDufWX3nigAxHv9FfYA64kbe/+kwizhaevfzGchjP
         vugqUvFUFvspQCPYQYEPbT+rbhE9hjssVbRE+4JpmE1Qam8QLv3l+ZTa+ocbqzhGS0aw
         k2OrE/nu7uOIEclUrFzSFn5ic8BKD5sN62Wzm3+Wl6qkVAyqauCJdw9TGlPFbF3fT/Vj
         CC6lxUEdUyLhJMbekpwwgX9yG+67GgANiKoQbc2S/yLeU4CLZGWBRwgAZspudOaYuc1U
         PoUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=YrZJ8n5n4xqOkzPQJHlDZNj6f3cJzeEg186nmWnKR6Y=;
        b=fIkEaJHB9aHTUNplm+cD9/pT7Oqp5gHj/VhDiCckbSMYDfj2I67NreJPvQ+VgmDcpP
         2AKg8flocaLWPs/KsmHVnOLsXdxc2tEX74yHbxI1b/YqPn8EIP+qdd59c0abni1EDc9P
         R46pxBlO45xIIT6Gan00KZ2GS//iSPENgV1smtp6weXN916O2sXSqOrz9Lni7uacdsJB
         NIoJDkIFV0Fp6A7YHOqcZ7LdgZsOq1wai2XSmOdQvMNupKbEhy3yLx3F3urwQIcimjaV
         tS5IbNB4GTS0N7xiyilHY2CSe7PaiA16XKvzXRAJUwTRo8KSDTUgOAilUIL9RY6flWC+
         ZdYg==
X-Gm-Message-State: ACrzQf2811rpdSa87yDSFnd2Xt3dRXbANkU4+lv3Kr9HMK04BGAjho+Z
        gqCmNoQet+vy/moupUONa5xxdSvfp4KVVGHzUa4sQA==
X-Google-Smtp-Source: AMsMyM6YGYU7VQSs52fltaPH4CqmqtxkgYKg6X9ImuQD2BPRTm7eb8gazO5Lmh6rIjmKrHcANbh1SMb2T5tTJmScHRY=
X-Received: by 2002:a17:906:ee81:b0:77e:829a:76e9 with SMTP id
 wt1-20020a170906ee8100b0077e829a76e9mr18569885ejb.207.1664857841694; Mon, 03
 Oct 2022 21:30:41 -0700 (PDT)
MIME-Version: 1.0
References: <20220727043829.151794-1-apatel@ventanamicro.com> <mhng-0acf8089-a53c-41cb-92a8-0c873e0c284c@palmer-ri-x1c9>
In-Reply-To: <mhng-0acf8089-a53c-41cb-92a8-0c873e0c284c@palmer-ri-x1c9>
From:   Anup Patel <anup@brainfault.org>
Date:   Tue, 4 Oct 2022 10:00:30 +0530
Message-ID: <CAAhSdy3kgXOfMvs5wkrQVto-=uQmkwNmNsP_Qek7nUxyGOG9GQ@mail.gmail.com>
Subject: Re: [PATCH v2] RISC-V: Add mvendorid, marchid, and mimpid to
 /proc/cpuinfo output
To:     Palmer Dabbelt <palmer@dabbelt.com>
Cc:     apatel@ventanamicro.com, Paul Walmsley <paul.walmsley@sifive.com>,
        Arnd Bergmann <arnd@arndb.de>, atishp@atishpatra.org,
        nikita.shubin@maquefel.me, heinrich.schuchardt@canonical.com,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        n.shubin@yadro.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Palmer,

On Tue, Oct 4, 2022 at 8:24 AM Palmer Dabbelt <palmer@dabbelt.com> wrote:
>
> On Tue, 26 Jul 2022 21:38:29 PDT (-0700), apatel@ventanamicro.com wrote:
> > Identifying the underlying RISC-V implementation can be important
> > for some of the user space applications. For example, the perf tool
> > uses arch specific CPU implementation id (i.e. CPUID) to select a
> > JSON file describing custom perf events on a CPU.
> >
> > Currently, there is no way to identify RISC-V implementation so we
> > add mvendorid, marchid, and mimpid to /proc/cpuinfo output.
> >
> > Signed-off-by: Anup Patel <apatel@ventanamicro.com>
> > Reviewed-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> > Tested-by: Nikita Shubin <n.shubin@yadro.com>
> > ---
> > Changes since v1:
> >  - Use IS_ENABLED() to check CONFIG defines
> >  - Added RB and TB tags in commit description
> > ---
> >  arch/riscv/kernel/cpu.c | 51 +++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 51 insertions(+)
>
> Sorry for being slow on this one.  I'd been worried about sticking more
> stuff into /proc/cpuinfo, as having the only user interface for these
> involve parsing /proc/cpuinfo is really just a recipe for disaster.  I
> didn't get around do doing something better, though, and waiting for
> another release seems kind of silly.
>
> I was going to go put this on for-next, but it looks like it's causing
> kasan boot failures.  I'm not actually quite sure how this is triggering
> these, at least based on the backtrace, but there's a bunch of them and
> boot hangs.
>
> Here's the first of them:
>
> [    3.830416] Hardware name: riscv-virtio,qemu (DT)
> [    3.830828] epc : kasan_check_range+0x116/0x14c
> [    3.832377]  ra : memset+0x1e/0x4c
> [    3.832699] epc : ffffffff8026468e ra : ffffffff80264d6e sp : ff600000832afa60
> [    3.833051]  gp : ffffffff81d800a0 tp : ff600000831d2400 t0 : ff60000083224360
> [    3.833397]  t1 : ffebfffefffef000 t2 : 0000000000000000 s0 : ff600000832afa90
> [    3.833811]  s1 : 0000000000000004 a0 : 0000000000000010 a1 : 0000000000000004
> [    3.834210]  a2 : 0000000000000001 a3 : ffffffff801fa22c a4 : ff5ffffffff78000
> [    3.834558]  a5 : ffebfffefffef000 a6 : ffebfffefffef001 a7 : ff5ffffffff78003
> [    3.834931]  s2 : ff5ffffffff78000 s3 : 0000000000000000 s4 : ffffffff815b59b0
> [    3.835292]  s5 : ffffffff81d815e0 s6 : 0000000000000000 s7 : 0000000000000008
> [    3.836400]  s8 : ffffffff81d8b0e0 s9 : 0000000000000000 s10: 0000000000000008
> [    3.836817]  s11: ff5ffffffff78000 t3 : 0000000000000000 t4 : ffebfffefffef000
> [    3.837154]  t5 : ffebfffefffef001 t6 : 0000000000000002
> [    3.837471] status: 0000000000000120 badaddr: ffebfffefffef000 cause: 000000000000000d
> [    3.837933] [<ffffffff801fa22c>] pcpu_alloc+0x494/0x838
> [    3.838324] [<ffffffff801fa5fc>] __alloc_percpu+0x14/0x1c
> [    3.838623] [<ffffffff800930fa>] __percpu_init_rwsem+0x1a/0x98
> [    3.838995] [<ffffffff80286c5a>] alloc_super+0x148/0x3da
> [    3.839631] [<ffffffff80287af2>] sget_fc+0x90/0x2c4
> [    3.840240] [<ffffffff80288498>] get_tree_nodev+0x24/0xa4
> [    3.840598] [<ffffffff801e919a>] shmem_get_tree+0x14/0x1c
> [    3.840891] [<ffffffff80286436>] vfs_get_tree+0x3a/0x11a
> [    3.841172] [<ffffffff802ba746>] path_mount+0x2ea/0xb44
> [    3.841468] [<ffffffff802bb69a>] sys_mount+0x1b2/0x270
> [    3.841790] [<ffffffff80003d1c>] ret_from_syscall+0x0/0x2
> [    3.842480] ---[ end trace 0000000000000000 ]---
>

I tried several times but I am not able to reproduce this issue
with this patch applied on the latest Linux-6.0. It seems some
other patch is causing the KASAN trace which you are seeing.

Here's the complete boot log .....

$ qemu-system-riscv64 -M virt -m 512M -nographic -bios
opensbi/build/platform/generic/firmware/fw_jump.bin -kernel
./build-riscv64/arch/riscv/boot/Image -append "root=/dev/ram rw
console=ttyS0 earlycon" -initrd ./rootfs_riscv64.img -smp 4

OpenSBI v1.1-54-g7f09fba
   ____                    _____ ____ _____
  / __ \                  / ____|  _ \_   _|
 | |  | |_ __   ___ _ __ | (___ | |_) || |
 | |  | | '_ \ / _ \ '_ \ \___ \|  _ < | |
 | |__| | |_) |  __/ | | |____) | |_) || |_
  \____/| .__/ \___|_| |_|_____/|____/_____|
        | |
        |_|

Platform Name             : riscv-virtio,qemu
Platform Features         : medeleg
Platform HART Count       : 4
Platform IPI Device       : aclint-mswi
Platform Timer Device     : aclint-mtimer @ 10000000Hz
Platform Console Device   : uart8250
Platform HSM Device       : ---
Platform PMU Device       : ---
Platform Reboot Device    : sifive_test
Platform Shutdown Device  : sifive_test
Firmware Base             : 0x80000000
Firmware Size             : 232 KB
Runtime SBI Version       : 1.0

Domain0 Name              : root
Domain0 Boot HART         : 3
Domain0 HARTs             : 0*,1*,2*,3*
Domain0 Region00          : 0x0000000002000000-0x000000000200ffff (I)
Domain0 Region01          : 0x0000000080000000-0x000000008003ffff ()
Domain0 Region02          : 0x0000000000000000-0xffffffffffffffff (R,W,X)
Domain0 Next Address      : 0x0000000080200000
Domain0 Next Arg1         : 0x0000000082200000
Domain0 Next Mode         : S-mode
Domain0 SysReset          : yes

Boot HART ID              : 3
Boot HART Domain          : root
Boot HART Priv Version    : v1.12
Boot HART Base ISA        : rv64imafdch
Boot HART ISA Extensions  : time,sstc
Boot HART PMP Count       : 16
Boot HART PMP Granularity : 4
Boot HART PMP Address Bits: 54
Boot HART MHPM Count      : 16
Boot HART MIDELEG         : 0x0000000000001666
Boot HART MEDELEG         : 0x0000000000f0b509
[    0.000000] Linux version 6.0.0-00001-g04097fca4bd6
(anup@anup-ubuntu64-vm) (riscv64-unknown-linux-gnu-gcc (g1ea978e3066)
12.1.0, GNU ld (GNU Binutils) 2.39) #1 SMP Mon Oct 3 11:04:02 IST 2022
[    0.000000] random: crng init done
[    0.000000] OF: fdt: Ignoring memory range 0x80000000 - 0x80200000
[    0.000000] Machine model: riscv-virtio,qemu
[    0.000000] earlycon: ns16550a0 at MMIO 0x0000000010000000 (options '')
[    0.000000] printk: bootconsole [ns16550a0] enabled
[    0.000000] efi: UEFI not found.
[    0.000000] Zone ranges:
[    0.000000]   DMA32    [mem 0x0000000080200000-0x000000009fffffff]
[    0.000000]   Normal   empty
[    0.000000] Movable zone start for each node
[    0.000000] Early memory node ranges
[    0.000000]   node   0: [mem 0x0000000080200000-0x000000009fffffff]
[    0.000000] Initmem setup node 0 [mem 0x0000000080200000-0x000000009fffffff]
[    0.000000] SBI specification v1.0 detected
[    0.000000] SBI implementation ID=0x1 Version=0x10001
[    0.000000] SBI TIME extension detected
[    0.000000] SBI IPI extension detected
[    0.000000] SBI RFENCE extension detected
[    0.000000] SBI SRST extension detected
[    0.000000] SBI HSM extension detected
[    0.000000] riscv: base ISA extensions acdfhim
[    0.000000] riscv: ELF capabilities acdfim
[    0.000000] percpu: Embedded 17 pages/cpu s30840 r8192 d30600 u69632
[    0.000000] Built 1 zonelists, mobility grouping on.  Total pages: 128520
[    0.000000] Kernel command line: root=/dev/ram rw console=ttyS0 earlycon
[    0.000000] Dentry cache hash table entries: 65536 (order: 7,
524288 bytes, linear)
[    0.000000] Inode-cache hash table entries: 32768 (order: 6, 262144
bytes, linear)
[    0.000000] mem auto-init: stack:all(zero), heap alloc:off, heap free:off
[    0.000000] stackdepot hash table entries: 1048576 (order: 11,
8388608 bytes, linear)
[    0.000000] Virtual kernel memory layout:
[    0.000000]       fixmap : 0xff1bfffffee00000 - 0xff1bffffff000000
 (2048 kB)
[    0.000000]       pci io : 0xff1bffffff000000 - 0xff1c000000000000
 (  16 MB)
[    0.000000]      vmemmap : 0xff1c000000000000 - 0xff20000000000000
 (1024 TB)
[    0.000000]      vmalloc : 0xff20000000000000 - 0xff60000000000000
 (16384 TB)
[    0.000000]      modules : 0xffffffff01e22000 - 0xffffffff80000000
 (2017 MB)
[    0.000000]       lowmem : 0xff60000000000000 - 0xff6000001fe00000
 ( 510 MB)
[    0.000000]        kasan : 0xffdf000000000000 - 0xffffffff00000000
 (8447 TB)
[    0.000000]       kernel : 0xffffffff80000000 - 0xffffffffffffffff
 (2047 MB)
[    0.000000] Memory: 132036K/522240K available (12642K kernel code,
7564K rwdata, 6144K rodata, 2193K init, 612K bss, 390204K reserved, 0K
cma-reserved)
[    0.000000] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=4, Nodes=1
[    0.000000] rcu: Hierarchical RCU implementation.
[    0.000000] rcu:     RCU restricting CPUs from NR_CPUS=8 to nr_cpu_ids=4.
[    0.000000] rcu:     RCU debug extended QS entry/exit.
[    0.000000]     Tracing variant of Tasks RCU enabled.
[    0.000000] rcu: RCU calculated value of scheduler-enlistment delay
is 25 jiffies.
[    0.000000] rcu: Adjusting geometry for rcu_fanout_leaf=16, nr_cpu_ids=4
[    0.000000] NR_IRQS: 64, nr_irqs: 64, preallocated irqs: 0
[    0.000000] riscv-intc: 64 local interrupts mapped
[    0.000000] plic: plic@c000000: mapped 96 interrupts with 4
handlers for 8 contexts.
[    0.000000] rcu: srcu_init: Setting srcu_struct sizes based on contention.
[    0.000000] riscv-timer: riscv_timer_init_dt: Registering
clocksource cpuid [0] hartid [3]
[    0.000000] clocksource: riscv_clocksource: mask:
0xffffffffffffffff max_cycles: 0x24e6a1710, max_idle_ns: 440795202120
ns
[    0.000167] sched_clock: 64 bits at 10MHz, resolution 100ns, wraps
every 4398046511100ns
[    0.006196] riscv-timer: Timer interrupt in S-mode is available via
sstc extension
[    0.033533] Console: colour dummy device 80x25
[    0.039665] Calibrating delay loop (skipped), value calculated
using timer frequency.. 20.00 BogoMIPS (lpj=40000)
[    0.041873] pid_max: default: 32768 minimum: 301
[    0.047970] LSM: Security Framework initializing
[    0.056472] Mount-cache hash table entries: 1024 (order: 1, 8192
bytes, linear)
[    0.057651] Mountpoint-cache hash table entries: 1024 (order: 1,
8192 bytes, linear)
[    0.194551] cblist_init_generic: Setting adjustable number of
callback queues.
[    0.196019] cblist_init_generic: Setting shift to 2 and lim to 1.
[    0.198820] riscv: ELF compat mode supported
[    0.199475] ASID allocator using 16 bits (65536 entries)
[    0.204535] rcu: Hierarchical SRCU implementation.
[    0.205144] rcu:     Max phase no-delay instances is 1000.
[    0.220950] EFI services will not be available.
[    0.257578] smp: Bringing up secondary CPUs ...
[    0.330519] smp: Brought up 1 node, 4 CPUs
[    0.364217] devtmpfs: initialized
[    0.441404] clocksource: jiffies: mask: 0xffffffff max_cycles:
0xffffffff, max_idle_ns: 7645041785100000 ns
[    0.442783] futex hash table entries: 1024 (order: 4, 65536 bytes, linear)
[    0.449422] pinctrl core: initialized pinctrl subsystem
[    0.463479] NET: Registered PF_NETLINK/PF_ROUTE protocol family
[    0.480895] DMA: preallocated 128 KiB GFP_KERNEL pool for atomic allocations
[    0.482798] DMA: preallocated 128 KiB GFP_KERNEL|GFP_DMA32 pool for
atomic allocations
[    0.487607] audit: initializing netlink subsys (disabled)
[    0.496356] audit: type=2000 audit(0.352:1): state=initialized
audit_enabled=0 res=1
[    0.521944] cpuidle: using governor menu
[    0.764786] HugeTLB: registered 2.00 MiB page size, pre-allocated 0 pages
[    0.765347] HugeTLB: 0 KiB vmemmap can be freed for a 2.00 MiB page
[    0.778167] iommu: Default domain type: Translated
[    0.778797] iommu: DMA domain TLB invalidation policy: strict mode
[    0.785936] SCSI subsystem initialized
[    0.793815] usbcore: registered new interface driver usbfs
[    0.795355] usbcore: registered new interface driver hub
[    0.796867] usbcore: registered new device driver usb
[    0.862701] vgaarb: loaded
[    0.873160] clocksource: Switched to clocksource riscv_clocksource
[    1.090734] NET: Registered PF_INET protocol family
[    1.094533] IP idents hash table entries: 8192 (order: 4, 65536
bytes, linear)
[    1.116613] tcp_listen_portaddr_hash hash table entries: 256
(order: 1, 8192 bytes, linear)
[    1.119396] Table-perturb hash table entries: 65536 (order: 6,
262144 bytes, linear)
[    1.122509] TCP established hash table entries: 4096 (order: 3,
32768 bytes, linear)
[    1.125009] TCP bind hash table entries: 4096 (order: 5, 131072
bytes, linear)
[    1.130044] TCP: Hash tables configured (established 4096 bind 4096)
[    1.136668] UDP hash table entries: 256 (order: 2, 24576 bytes, linear)
[    1.138039] UDP-Lite hash table entries: 256 (order: 2, 24576 bytes, linear)
[    1.142935] NET: Registered PF_UNIX/PF_LOCAL protocol family
[    1.166580] RPC: Registered named UNIX socket transport module.
[    1.168292] RPC: Registered udp transport module.
[    1.169043] RPC: Registered tcp transport module.
[    1.169616] RPC: Registered tcp NFSv4.1 backchannel transport module.
[    1.170766] PCI: CLS 0 bytes, default 64
[    1.193634] Unpacking initramfs...
[    1.234821] workingset: timestamp_bits=46 max_order=16 bucket_order=0
[    1.481070] NFS: Registering the id_resolver key type
[    1.486758] Key type id_resolver registered
[    1.488052] Key type id_legacy registered
[    1.492906] nfs4filelayout_init: NFSv4 File Layout Driver Registering...
[    1.494170] nfs4flexfilelayout_init: NFSv4 Flexfile Layout Driver
Registering...
[    1.499783] 9p: Installing v9fs 9p2000 file system support
[    1.509514] NET: Registered PF_ALG protocol family
[    1.512535] Block layer SCSI generic (bsg) driver version 0.4
loaded (major 250)
[    1.514517] io scheduler mq-deadline registered
[    1.515786] io scheduler kyber registered
[    1.625664] pci-host-generic 30000000.pci: host bridge
/soc/pci@30000000 ranges:
[    1.628610] pci-host-generic 30000000.pci:       IO
0x0003000000..0x000300ffff -> 0x0000000000
[    1.631279] pci-host-generic 30000000.pci:      MEM
0x0040000000..0x007fffffff -> 0x0040000000
[    1.632791] pci-host-generic 30000000.pci:      MEM
0x0400000000..0x07ffffffff -> 0x0400000000
[    1.635612] pci-host-generic 30000000.pci: Memory resource size
exceeds max for 32 bits
[    1.651366] pci-host-generic 30000000.pci: ECAM at [mem
0x30000000-0x3fffffff] for [bus 00-ff]
[    1.663042] pci-host-generic 30000000.pci: PCI host bridge to bus 0000:00
[    1.665769] pci_bus 0000:00: root bus resource [bus 00-ff]
[    1.667976] pci_bus 0000:00: root bus resource [io  0x0000-0xffff]
[    1.669508] pci_bus 0000:00: root bus resource [mem 0x40000000-0x7fffffff]
[    1.670762] pci_bus 0000:00: root bus resource [mem 0x400000000-0x7ffffffff]
[    1.676881] pci 0000:00:00.0: [1b36:0008] type 00 class 0x060000
[    1.811192] Freeing initrd memory: 12484K
[    2.748960] Serial: 8250/16550 driver, 4 ports, IRQ sharing disabled
[    2.788856] printk: console [ttyS0] disabled
[    2.796353] 10000000.serial: ttyS0 at MMIO 0x10000000 (irq = 1,
base_baud = 230400) is a 16550A
[    2.800108] printk: console [ttyS0] enabled
[    2.800108] printk: console [ttyS0] enabled
[    2.801134] printk: bootconsole [ns16550a0] disabled
[    2.801134] printk: bootconsole [ns16550a0] disabled
[    2.942562] loop: module loaded
[    2.977068] e1000e: Intel(R) PRO/1000 Network Driver
[    2.977716] e1000e: Copyright(c) 1999 - 2015 Intel Corporation.
[    2.981896] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
[    2.983611] ehci-pci: EHCI PCI platform driver
[    2.984953] ehci-platform: EHCI generic platform driver
[    2.986438] ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
[    2.988260] ohci-pci: OHCI PCI platform driver
[    2.990070] ohci-platform: OHCI generic platform driver
[    2.996940] usbcore: registered new interface driver uas
[    2.998376] usbcore: registered new interface driver usb-storage
[    3.003800] mousedev: PS/2 mouse device common for all mice
[    3.025924] goldfish_rtc 101000.rtc: registered as rtc0
[    3.027210] goldfish_rtc 101000.rtc: setting system clock to
2022-10-04T04:25:44 UTC (1664857544)
[    3.050953] syscon-poweroff poweroff: pm_power_off already claimed
for sbi_srst_power_off
[    3.053152] syscon-poweroff: probe of poweroff failed with error -16
[    3.062649] sdhci: Secure Digital Host Controller Interface driver
[    3.063888] sdhci: Copyright(c) Pierre Ossman
[    3.064920] sdhci-pltfm: SDHCI platform and OF driver helper
[    3.071575] usbcore: registered new interface driver usbhid
[    3.074086] usbhid: USB HID core driver
[    3.078343] riscv-pmu-sbi: SBI PMU extension is available
[    3.082211] riscv-pmu-sbi: 16 firmware and 18 hardware counters
[    3.082844] riscv-pmu-sbi: Perf sampling/filtering is not supported
as sscof extension is not available
[    3.117166] NET: Registered PF_INET6 protocol family
[    3.157784] Segment Routing with IPv6
[    3.159593] In-situ OAM (IOAM) with IPv6
[    3.162181] sit: IPv6, IPv4 and MPLS over IPv4 tunneling driver
[    3.175768] NET: Registered PF_PACKET protocol family
[    3.181457] 9pnet: Installing 9P2000 support
[    3.183152] Key type dns_resolver registered
[    3.210151] debug_vm_pgtable: [debug_vm_pgtable         ]:
Validating architecture page table helpers
[    3.335692] Freeing unused kernel image (initmem) memory: 2192K
[    3.359821] Run /init as init process
           _  _
          | ||_|
          | | _ ____  _   _  _  _
          | || |  _ \| | | |\ \/ /
          | || | | | | |_| |/    \
          |_||_|_| |_|\____|\_/\_/

               Busybox Rootfs

Please press Enter to activate this console.
/ #
/ # dmesg | grep -i kasan
[    0.000000]        kasan : 0xffdf000000000000 - 0xffffffff00000000
 (8447 TB)
/ #
/ #
/ #
/ #
/ # uptime
 04:26:31 up 0 min,  0 users,  load average: 0.00, 0.00, 0.00
/ # cat /proc/cpuinfo
processor    : 0
hart        : 3
isa        : rv64imafdch_zihintpause_sstc
mmu        : sv57
mvendorid    : 0x0
marchid        : 0x70132
mimpid        : 0x70132

processor    : 1
hart        : 0
isa        : rv64imafdch_zihintpause_sstc
mmu        : sv57
mvendorid    : 0x0
marchid        : 0x70132
mimpid        : 0x70132

processor    : 2
hart        : 1
isa        : rv64imafdch_zihintpause_sstc
mmu        : sv57
mvendorid    : 0x0
marchid        : 0x70132
mimpid        : 0x70132

processor    : 3
hart        : 2
isa        : rv64imafdch_zihintpause_sstc
mmu        : sv57
mvendorid    : 0x0
marchid        : 0x70132
mimpid        : 0x70132

Regards,
Anup
