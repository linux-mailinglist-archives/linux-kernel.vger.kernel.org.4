Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F2766611D0
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Jan 2023 22:35:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232859AbjAGVfY convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sat, 7 Jan 2023 16:35:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230170AbjAGVfW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Jan 2023 16:35:22 -0500
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B56B21ADB6
        for <linux-kernel@vger.kernel.org>; Sat,  7 Jan 2023 13:35:20 -0800 (PST)
Received: by mail-il1-f197.google.com with SMTP id h4-20020a056e021b8400b0030d901a84d9so2307755ili.6
        for <linux-kernel@vger.kernel.org>; Sat, 07 Jan 2023 13:35:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:to:from:subject:message-id:in-reply-to
         :date:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uriG6vAO8t12sCs5qTUoqZ/yZB+TT8LvZnOXh/eWalw=;
        b=VgCkxFTs18ayuA4OlhPljeoCanVDRA+1nRVv/uVGAd2H+jOHqULBjgF3LVdKdnymfI
         WV7u+9bEacfM8Kv7iASu5qKCYRo3GnqG5+3Bg9NH2T8oQG9F8/oy+NE135hhiIa37Kzh
         pjzUnHzaPQWav0wXHx+EJSv4Ci3qugi3Tw8AruVtic+DwVr+lTotPlU4QZG/LcXJBLcj
         tmqynNQouujGsRN3bFcs6+/jsTeu6EXyqXvD1Jh+1ozA1sH0w22d5+JVYei1bSqhcNcV
         QU3PlD8RslPCInds3SX/PutdLlzVzNlZD7z8XCrBDGoNOhEZGnMUp790a1XG43mlsgq+
         ixEg==
X-Gm-Message-State: AFqh2koEYDEKyHeCKwvaXyej0zmXrRxFKMH10LSKDgbhsb92mk3trK4X
        IIQqtzesglhyxWGIjv3N46W0jg8bhmD1Zugw+e0jOba1P1Ck
X-Google-Smtp-Source: AMrXdXsikUxl2iUzKDMupq+4WRd35EiLsa9uPIx8v9DfD484J3tC+SMT5EsIaEnrGYzB2rJTznhR5hCprcElmM4bqIE/H3aGz4eW
MIME-Version: 1.0
X-Received: by 2002:a92:dc85:0:b0:30c:266:4957 with SMTP id
 c5-20020a92dc85000000b0030c02664957mr2959007iln.285.1673127320031; Sat, 07
 Jan 2023 13:35:20 -0800 (PST)
Date:   Sat, 07 Jan 2023 13:35:20 -0800
In-Reply-To: <20230107121634.4974-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000931c7e05f1b34f42@google.com>
Subject: Re: [syzbot] BUG: unable to handle kernel paging request in p9_client_disconnect
From:   syzbot <syzbot+ea8b28e8dca42fc3bcbe@syzkaller.appspotmail.com>
To:     hdanton@sina.com, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

_idle_ns: 19112604462750000 ns
[    0.145941][    T1] futex hash table entries: 512 (order: 4, 65536 bytes, linear)
[    0.153846][   T12] Callback from call_rcu_tasks_trace() invoked.
[    0.162653][    T1] SMBIOS 3.4.0 present.
[    0.162677][    T1] DMI: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/26/2022
[    0.165306][    T1] NET: Registered PF_NETLINK/PF_ROUTE protocol family
[    0.167194][    T1] DMA: preallocated 1024 KiB GFP_KERNEL pool for atomic allocations
[    0.167351][    T1] DMA: preallocated 1024 KiB GFP_KERNEL|GFP_DMA pool for atomic allocations
[    0.168428][    T1] DMA: preallocated 1024 KiB GFP_KERNEL|GFP_DMA32 pool for atomic allocations
[    0.168529][    T1] audit: initializing netlink subsys (disabled)
[    0.168770][   T26] audit: type=2000 audit(0.160:1): state=initialized audit_enabled=0 res=1
[    0.173355][    T1] thermal_sys: Registered thermal governor 'step_wise'
[    0.173365][    T1] thermal_sys: Registered thermal governor 'power_allocator'
[    0.173462][    T1] cpuidle: using governor menu
[    0.173489][    T1] NET: Registered PF_QIPCRTR protocol family
[    0.173821][    T1] hw-breakpoint: found 6 breakpoint and 4 watchpoint registers.
[    0.173920][    T1] ASID allocator initialised with 65536 entries
[    0.173945][    T1] acpiphp: ACPI Hot Plug PCI Controller Driver version: 0.5
[    0.174119][    T1] Serial: AMBA PL011 UART driver
[    0.267352][    T1] HugeTLB: registered 1.00 GiB page size, pre-allocated 0 pages
[    0.267362][    T1] HugeTLB: 16380 KiB vmemmap can be freed for a 1.00 GiB page
[    0.267372][    T1] HugeTLB: registered 32.0 MiB page size, pre-allocated 0 pages
[    0.267380][    T1] HugeTLB: 508 KiB vmemmap can be freed for a 32.0 MiB page
[    0.267389][    T1] HugeTLB: registered 2.00 MiB page size, pre-allocated 0 pages
[    0.267396][    T1] HugeTLB: 28 KiB vmemmap can be freed for a 2.00 MiB page
[    0.267406][    T1] HugeTLB: registered 64.0 KiB page size, pre-allocated 0 pages
[    0.267413][    T1] HugeTLB: 0 KiB vmemmap can be freed for a 64.0 KiB page
[    0.435009][   T11] Callback from call_rcu_tasks() invoked.
[    0.435038][    T1] raid6: neonx8   gen()  6167 MB/s
[    0.605099][    T1] raid6: neonx4   gen()  5716 MB/s
[    0.775312][    T1] raid6: neonx2   gen()  5058 MB/s
[    0.945507][    T1] raid6: neonx1   gen()  3461 MB/s
[    1.115682][    T1] raid6: int64x8  gen()  4604 MB/s
[    1.285876][    T1] raid6: int64x4  gen()  4521 MB/s
[    1.456022][    T1] raid6: int64x2  gen()  2718 MB/s
[    1.626187][    T1] raid6: int64x1  gen()  1947 MB/s
[    1.626196][    T1] raid6: using algorithm neonx8 gen() 6167 MB/s
[    1.796401][    T1] raid6: .... xor() 3991 MB/s, rmw enabled
[    1.796408][    T1] raid6: using neon recovery algorithm
[    1.797126][    T1] ACPI: Added _OSI(Module Device)
[    1.797136][    T1] ACPI: Added _OSI(Processor Device)
[    1.797145][    T1] ACPI: Added _OSI(3.0 _SCP Extensions)
[    1.797155][    T1] ACPI: Added _OSI(Processor Aggregator Device)
[    1.804470][    T1] ACPI: 2 ACPI AML tables successfully acquired and loaded
[    1.807824][    T1] ACPI: Interpreter enabled
[    1.807830][    T1] ACPI: Using GIC for interrupt routing
[    1.807911][    T1] ACPI: MCFG table detected, 1 entries
[    1.822240][    T1] ARMH0011:00: ttyAMA0 at MMIO 0x9000000 (irq = 12, base_baud = 0) is a SBSA
[    2.114413][    T1] printk: console [ttyAMA0] enabled
[    2.118289][    T1] ARMH0011:01: ttyAMA1 at MMIO 0x9001000 (irq = 13, base_baud = 0) is a SBSA
[    2.122577][    T1] ARMH0011:02: ttyAMA2 at MMIO 0x9002000 (irq = 14, base_baud = 0) is a SBSA
[    2.126853][    T1] ARMH0011:03: ttyAMA3 at MMIO 0x9003000 (irq = 15, base_baud = 0) is a SBSA
[    2.131890][    T1] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-0f])
[    2.133622][    T1] acpi PNP0A08:00: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI HPX-Type3]
[    2.136536][    T1] acpi PNP0A08:00: _OSC: platform does not support [LTR]
[    2.139330][    T1] acpi PNP0A08:00: _OSC: OS now controls [PCIeHotplug PME AER PCIeCapability]
[    2.142523][    T1] acpi PNP0A08:00: ECAM area [mem 0x3f000000-0x3fffffff] reserved by PNP0C02:00
[    2.144915][    T1] acpi PNP0A08:00: ECAM at [mem 0x3f000000-0x3fffffff] for [bus 00-0f]
[    2.146937][    T1] ACPI: Remapped I/O 0x000000003eff0000 to [io  0x0000-0xffff window]
[    2.149516][    T1] PCI host bridge to bus 0000:00
[    2.150611][    T1] pci_bus 0000:00: root bus resource [mem 0x10000000-0x3efeffff window]
[    2.152451][    T1] pci_bus 0000:00: root bus resource [io  0x0000-0xffff window]
[    2.154158][    T1] pci_bus 0000:00: root bus resource [mem 0x8000000000-0xffffffffff window]
[    2.156180][    T1] pci_bus 0000:00: root bus resource [bus 00-0f]
[    2.158027][    T1] pci 0000:00:00.0: [1ae0:0042] type 00 class 0x020000
[    2.162051][    T1] pci 0000:00:00.0: reg 0x10: [mem 0x10203000-0x10203fff]
[    2.164772][    T1] pci 0000:00:00.0: reg 0x14: [mem 0x10202000-0x1020203f]
[    2.167519][    T1] pci 0000:00:00.0: reg 0x18: [mem 0x10100000-0x101fffff]
[    2.169988][    T1] pci 0000:00:01.0: [1af4:1005] type 00 class 0x00ff00
[    2.174885][    T1] pci 0000:00:01.0: reg 0x10: [io  0x0000-0x001f]
[    2.178422][    T1] pci 0000:00:01.0: reg 0x14: [mem 0x10201000-0x1020103f]
[    2.187023][    T1] pci 0000:00:02.0: [1ae0:001f] type 00 class 0x010802
[    2.195507][    T1] pci 0000:00:02.0: reg 0x10: [mem 0x10000000-0x10003fff 64bit]
[    2.201196][    T1] pci 0000:00:02.0: reg 0x20: [mem 0x10200000-0x1020003f]
[    2.205888][    T1] pci 0000:00:00.0: BAR 2: assigned [mem 0x10000000-0x100fffff]
[    2.208238][    T1] pci 0000:00:02.0: BAR 0: assigned [mem 0x8000000000-0x8000003fff 64bit]
[    2.212164][    T1] pci 0000:00:00.0: BAR 0: assigned [mem 0x10100000-0x10100fff]
[    2.214485][    T1] pci 0000:00:00.0: BAR 1: assigned [mem 0x10101000-0x1010103f]
[    2.216701][    T1] pci 0000:00:01.0: BAR 1: assigned [mem 0x10101040-0x1010107f]
[    2.219099][    T1] pci 0000:00:02.0: BAR 4: assigned [mem 0x10101080-0x101010bf]
[    2.221381][    T1] pci 0000:00:01.0: BAR 0: assigned [io  0x1000-0x101f]
[    2.223779][    T1] pci_bus 0000:00: resource 4 [mem 0x10000000-0x3efeffff window]
[    2.225489][    T1] pci_bus 0000:00: resource 5 [io  0x0000-0xffff window]
[    2.227050][    T1] pci_bus 0000:00: resource 6 [mem 0x8000000000-0xffffffffff window]
[    2.229280][    T1] ACPI: PCI: Interrupt link GSI0 configured for IRQ 35
[    2.230931][    T1] ACPI: PCI: Interrupt link GSI1 configured for IRQ 36
[    2.232544][    T1] ACPI: PCI: Interrupt link GSI2 configured for IRQ 37
[    2.234175][    T1] ACPI: PCI: Interrupt link GSI3 configured for IRQ 38
[    2.236654][    T1] iommu: Default domain type: Translated 
[    2.237970][    T1] iommu: DMA domain TLB invalidation policy: strict mode 
[    2.240686][    T1] SCSI subsystem initialized
[    2.247822][    T1] ACPI: bus type USB registered
[    2.249117][    T1] usbcore: registered new interface driver usbfs
[    2.250631][    T1] usbcore: registered new interface driver hub
[    2.252080][    T1] usbcore: registered new device driver usb
[    2.253854][    T1] mc: Linux media interface: v0.10
[    2.255083][    T1] videodev: Linux video capture interface: v2.00
[    2.256625][    T1] pps_core: LinuxPPS API ver. 1 registered
[    2.257922][    T1] pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolfo Giometti <giometti@linux.it>
[    2.260272][    T1] PTP clock support registered
[    2.261702][    T1] EDAC MC: Ver: 3.0.0
[    2.263527][    T1] Registered efivars operations
[    2.267725][    T1] Advanced Linux Sound Architecture Driver Initialized.
[    2.275977][    T1] Bluetooth: Core ver 2.22
[    2.277053][    T1] NET: Registered PF_BLUETOOTH protocol family
[    2.278430][    T1] Bluetooth: HCI device and connection manager initialized
[    2.281883][    T1] Bluetooth: HCI socket layer initialized
[    2.283177][    T1] Bluetooth: L2CAP socket layer initialized
[    2.284536][    T1] Bluetooth: SCO socket layer initialized
[    2.285863][    T1] NET: Registered PF_ATMPVC protocol family
[    2.287177][    T1] NET: Registered PF_ATMSVC protocol family
[    2.288601][    T1] NetLabel: Initializing
[    2.289545][    T1] NetLabel:  domain hash size = 128
[    2.290692][    T1] NetLabel:  protocols = UNLABELED CIPSOv4 CALIPSO
[    2.292282][    T1] NetLabel:  unlabeled traffic allowed by default
[    2.294406][    T1] nfc: nfc_init: NFC Core ver 0.1
[    2.295626][    T1] NET: Registered PF_NFC protocol family
[    2.297230][    T1] vgaarb: loaded
[    2.298450][    T1] clocksource: Switched to clocksource arch_sys_counter
[    2.300886][    T1] VFS: Disk quotas dquot_6.6.0
[    2.302050][    T1] VFS: Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
[    2.304109][    T1] FS-Cache: Loaded
[    2.305439][    T1] CacheFiles: Loaded
[    2.306559][    T1] TOMOYO: 2.6.0
[    2.307343][    T1] Mandatory Access Control activated.
[    2.308814][    T1] pnp: PnP ACPI init
[    2.310414][    T1] system 00:00: [mem 0x3f000000-0x3fffffff window] could not be reserved
[    2.312652][    T1] pnp: PnP ACPI: found 1 devices
[    2.328790][    T1] NET: Registered PF_INET protocol family
[    2.330287][    T1] IP idents hash table entries: 131072 (order: 8, 1048576 bytes, linear)
[    2.334837][    T1] tcp_listen_portaddr_hash hash table entries: 4096 (order: 6, 294912 bytes, linear)
[    2.337070][    T1] Table-perturb hash table entries: 65536 (order: 6, 262144 bytes, linear)
[    2.339191][    T1] TCP established hash table entries: 65536 (order: 7, 524288 bytes, linear)
[    2.343832][    T1] TCP bind hash table entries: 65536 (order: 11, 9437184 bytes, vmalloc)
[    2.347508][    T1] TCP: Hash tables configured (established 65536 bind 65536)
[    2.349781][    T1] MPTCP token hash table entries: 8192 (order: 7, 720896 bytes, linear)
[    2.352221][    T1] UDP hash table entries: 4096 (order: 7, 655360 bytes, linear)
[    2.354420][    T1] UDP-Lite hash table entries: 4096 (order: 7, 655360 bytes, linear)
[    2.356557][    T1] NET: Registered PF_UNIX/PF_LOCAL protocol family
[    2.358770][    T1] RPC: Registered named UNIX socket transport module.
[    2.360302][    T1] RPC: Registered udp transport module.
[    2.361528][    T1] RPC: Registered tcp transport module.
[    2.362754][    T1] RPC: Registered tcp NFSv4.1 backchannel transport module.
[    2.365056][    T1] NET: Registered PF_XDP protocol family
[    2.366399][    T1] PCI: CLS 0 bytes, default 64
[    2.367541][    T1] ACPI: bus type thunderbolt registered
[    2.369586][    T1] kvm [1]: HYP mode not available
[    2.372486][   T54] ------------[ cut here ]------------
[    2.373725][   T54] kernel BUG at mm/mmap.c:3113!
[    2.374836][   T54] Internal error: Oops - BUG: 00000000f2000800 [#1] PREEMPT SMP
[    2.376532][   T54] Modules linked in:
[    2.377394][   T54] CPU: 1 PID: 54 Comm: kworker/u4:1 Not tainted 6.1.0-rc2-syzkaller-dirty #0
[    2.378680][   T56] ------------[ cut here ]------------
[    2.379407][   T54] Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/26/2022
[    2.380637][   T56] kernel BUG at mm/mmap.c:3113!
[    2.383014][   T54] pstate: 80400005 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[    2.385925][   T54] pc : exit_mmap+0x384/0x3b8
[    2.386997][   T54] lr : exit_mmap+0x384/0x3b8
[    2.388046][   T54] sp : ffff80000f743c80
[    2.388995][   T54] x29: ffff80000f743d50 x28: 0000000000000008 x27: 0000000000000000
[    2.390858][   T54] x26: ffff0000c0e6cec0 x25: 0000000000000000 x24: ffff80000cbe686a
[    2.392727][   T54] x23: 00000000fffffffe x22: 0000000000000001 x21: 0000000000000000
[    2.394598][   T54] x20: ffff0000c0e140d8 x19: ffff0000c0e14000 x18: 00000000000000c0
[    2.396453][   T54] x17: ffff80000dda9198 x16: 0000000000000000 x15: 0000000000000000
[    2.398296][   T54] x14: 0000000000000000 x13: 0000000000000002 x12: ffff80000d93a6a8
[    2.400164][   T54] x11: ff80800008497ac4 x10: 0000000000000000 x9 : ffff800008497ac4
[    2.402002][   T54] x8 : ffff0000c0e6cec0 x7 : ffff8000084c08bc x6 : 0000000000000000
[    2.403846][   T54] x5 : ffff80000dff9ad0 x4 : 0000000000000000 x3 : 0000000000000000
[    2.405671][   T54] x2 : ffffffffffffffff x1 : 0000000000000001 x0 : 0000000000000000
[    2.407536][   T54] Call trace:
[    2.408290][   T54]  exit_mmap+0x384/0x3b8
[    2.409269][   T54]  __mmput+0x90/0x204
[    2.410190][   T54]  mmput+0x64/0xa0
[    2.411070][   T54]  free_bprm+0xac/0x19c
[    2.412027][   T54]  kernel_execve+0x4ec/0x540
[    2.413089][   T54]  call_usermodehelper_exec_async+0x10c/0x214
[    2.414481][   T54]  ret_from_fork+0x10/0x20
[    2.415496][   T54] Code: aa1303e0 97ff561d 17ffff64 97f83d94 (d4210000) 
[    2.417094][   T54] ---[ end trace 0000000000000000 ]---
[    2.418343][   T54] Kernel panic - not syncing: Oops - BUG: Fatal exception
[    2.420007][   T54] SMP: stopping secondary CPUs
[    3.500390][   T54] SMP: failed to stop secondary CPUs 0-1
[    3.501773][   T54] Kernel Offset: disabled
[    3.502802][   T54] CPU features: 0x00000,02070084,26017203
[    3.504126][   T54] Memory Limit: none
[    3.505051][   T54] Rebooting in 86400 seconds..


syzkaller build log:
go env (err=<nil>)
GO111MODULE="auto"
GOARCH="amd64"
GOBIN=""
GOCACHE="/syzkaller/.cache/go-build"
GOENV="/syzkaller/.config/go/env"
GOEXE=""
GOEXPERIMENT=""
GOFLAGS=""
GOHOSTARCH="amd64"
GOHOSTOS="linux"
GOINSECURE=""
GOMODCACHE="/syzkaller/jobs/linux/gopath/pkg/mod"
GONOPROXY=""
GONOSUMDB=""
GOOS="linux"
GOPATH="/syzkaller/jobs/linux/gopath"
GOPRIVATE=""
GOPROXY="https://proxy.golang.org,direct"
GOROOT="/usr/local/go"
GOSUMDB="sum.golang.org"
GOTMPDIR=""
GOTOOLDIR="/usr/local/go/pkg/tool/linux_amd64"
GOVCS=""
GOVERSION="go1.17"
GCCGO="gccgo"
AR="ar"
CC="gcc"
CXX="g++"
CGO_ENABLED="1"
GOMOD="/syzkaller/jobs/linux/gopath/src/github.com/google/syzkaller/go.mod"
CGO_CFLAGS="-g -O2"
CGO_CPPFLAGS=""
CGO_CXXFLAGS="-g -O2"
CGO_FFLAGS="-g -O2"
CGO_LDFLAGS="-g -O2"
PKG_CONFIG="pkg-config"
GOGCCFLAGS="-fPIC -m64 -pthread -fmessage-length=0 -fdebug-prefix-map=/tmp/go-build4137696923=/tmp/go-build -gno-record-gcc-switches"

git status (err=<nil>)
HEAD detached at 1dac8c7a0
nothing to commit, working tree clean


tput: No value for $TERM and no -T specified
tput: No value for $TERM and no -T specified
Makefile:32: run command via tools/syz-env for best compatibility, see:
Makefile:33: https://github.com/google/syzkaller/blob/master/docs/contributing.md#using-syz-env
go list -f '{{.Stale}}' ./sys/syz-sysgen | grep -q false || go install ./sys/syz-sysgen
make .descriptions
tput: No value for $TERM and no -T specified
tput: No value for $TERM and no -T specified
bin/syz-sysgen
touch .descriptions
GOOS=linux GOARCH=arm64 go build "-ldflags=-s -w -X github.com/google/syzkaller/prog.GitRevision=1dac8c7a01e2bdd35cb04eb4901ddb157291ac2d -X 'github.com/google/syzkaller/prog.gitRevisionDate=20230103-123455'" "-tags=syz_target syz_os_linux syz_arch_arm64 " -o ./bin/linux_arm64/syz-fuzzer github.com/google/syzkaller/syz-fuzzer
GOOS=linux GOARCH=arm64 go build "-ldflags=-s -w -X github.com/google/syzkaller/prog.GitRevision=1dac8c7a01e2bdd35cb04eb4901ddb157291ac2d -X 'github.com/google/syzkaller/prog.gitRevisionDate=20230103-123455'" "-tags=syz_target syz_os_linux syz_arch_arm64 " -o ./bin/linux_arm64/syz-execprog github.com/google/syzkaller/tools/syz-execprog
GOOS=linux GOARCH=arm64 go build "-ldflags=-s -w -X github.com/google/syzkaller/prog.GitRevision=1dac8c7a01e2bdd35cb04eb4901ddb157291ac2d -X 'github.com/google/syzkaller/prog.gitRevisionDate=20230103-123455'" "-tags=syz_target syz_os_linux syz_arch_arm64 " -o ./bin/linux_arm64/syz-stress github.com/google/syzkaller/tools/syz-stress
mkdir -p ./bin/linux_arm64
aarch64-linux-gnu-gcc -o ./bin/linux_arm64/syz-executor executor/executor.cc \
	-O2 -pthread -Wall -Werror -Wparentheses -Wunused-const-variable -Wframe-larger-than=16384 -Wno-stringop-overflow -Wno-array-bounds -Wno-format-overflow -static-pie -fpermissive -w -DGOOS_linux=1 -DGOARCH_arm64=1 \
	-DHOSTGOOS_linux=1 -DGIT_REVISION=\"1dac8c7a01e2bdd35cb04eb4901ddb157291ac2d\"


Error text is too large and was truncated, full error text is at:
https://syzkaller.appspot.com/x/error.txt?x=14f971d6480000


Tested on:

commit:         247f34f7 Linux 6.1-rc2
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git
kernel config:  https://syzkaller.appspot.com/x/.config?x=fa9bed8d6a8992a0
dashboard link: https://syzkaller.appspot.com/bug?extid=ea8b28e8dca42fc3bcbe
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
userspace arch: arm64
patch:          https://syzkaller.appspot.com/x/patch.diff?x=10ccfc6c480000

