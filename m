Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15EAC617BC2
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 12:40:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230098AbiKCLk2 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 3 Nov 2022 07:40:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229600AbiKCLk0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 07:40:26 -0400
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8A5712615
        for <linux-kernel@vger.kernel.org>; Thu,  3 Nov 2022 04:40:23 -0700 (PDT)
Received: by mail-io1-f71.google.com with SMTP id y26-20020a5d9b1a000000b006bc71505e97so870528ion.16
        for <linux-kernel@vger.kernel.org>; Thu, 03 Nov 2022 04:40:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:to:from:subject:message-id:in-reply-to
         :date:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R1AST0DvAOGfdUJiMwlXbS3FIuZS0DIVWb4ACLKs0ZE=;
        b=7EXQcyLix/8JS33ZCBkXtLEJ6+OWqmez0RqKyVk6nIwtCZceC9EIdGo7+sB8pZ/Rl5
         T9NhA86TFQSwnfJp8s7IahnKwife0y9WTGZ9ej7Tdv2/v4RAuNmJTXNKChYLYM+G+gzu
         0mTlUX1RHuNrNZHcRK4/9x/ZxtLSxaXH3XUllolMVSvIhX3gXVsCtwhCYJr/KhBe4yRf
         MY6ZNlFiMumKPDlWv2y0b7gxYT7fyv/j8H+u750Ami33NmFl2k+3aMd2Hsslt53DGyW5
         B0qYjPCjxktuHYk5PpeGNiisXTnqFuIdBjGrd16hHwxxUj7yNTWb9sAakKY5XFXt6COZ
         TQfA==
X-Gm-Message-State: ACrzQf38qNMRD/19eRpeeR75G4W1pgzkBIho+18BoDRE4BRkEuD0nwhY
        NbsOLrjbH0E9X7ofJ50j4eFfB/fNcU1jk6ODuLIQ5mEj+J3i
X-Google-Smtp-Source: AMsMyM7feBimRpKHsFaNcBu3/h68GmWH0dYWE8roYZu3+yd+WSKf2fQ4thxJ8/LvhIRVASsBcZaVDdLb3LmrKNrMwiEq2nKnG/i0
MIME-Version: 1.0
X-Received: by 2002:a05:6602:2c04:b0:6ab:d29a:7000 with SMTP id
 w4-20020a0566022c0400b006abd29a7000mr18163691iov.204.1667475622919; Thu, 03
 Nov 2022 04:40:22 -0700 (PDT)
Date:   Thu, 03 Nov 2022 04:40:22 -0700
In-Reply-To: <20221103072557.qc2hsowoaatstrbh@wittgenstein>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000002d057805ec8f6cb5@google.com>
Subject: Re: [syzbot] BUG: unable to handle kernel paging request in ovl_set_acl
From:   syzbot <syzbot+3f6ef1c4586bb6fd1f61@syzkaller.appspotmail.com>
To:     brauner@kernel.org, linux-kernel@vger.kernel.org,
        linux-unionfs@vger.kernel.org, miklos@szeredi.hu,
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

ut Driver Registering...
[    7.160509][    T1] Key type cifs.spnego registered
[    7.161598][    T1] Key type cifs.idmap registered
[    7.162926][    T1] ntfs: driver 2.1.32 [Flags: R/W].
[    7.165563][    T1] ntfs3: Max link count 4000
[    7.167071][    T1] ntfs3: Enabled Linux POSIX ACLs support
[    7.167935][    T1] ntfs3: Read-only LZX/Xpress compression included
[    7.170325][    T1] efs: 1.0a - http://aeschi.ch.eu.org/efs/
[    7.171768][    T1] jffs2: version 2.2. (NAND) (SUMMARY)  © 2001-2006 Red Hat, Inc.
[    7.177918][    T1] romfs: ROMFS MTD (C) 2007 Red Hat, Inc.
[    7.179712][    T1] QNX4 filesystem 0.2.3 registered.
[    7.180796][    T1] qnx6: QNX6 filesystem 1.0.0 registered.
[    7.182825][    T1] fuse: init (API version 7.37)
[    7.188322][    T1] orangefs_debugfs_init: called with debug mask: :none: :0:
[    7.190047][    T1] orangefs_init: module version upstream loaded
[    7.192129][    T1] JFS: nTxBlock = 8192, nTxLock = 65536
[    7.210458][    T1] SGI XFS with ACLs, security attributes, realtime, quota, fatal assert, debug enabled
[    7.225322][    T1] 9p: Installing v9fs 9p2000 file system support
[    7.228885][    T1] NILFS version 2 loaded
[    7.230107][    T1] befs: version: 0.9.3
[    7.232727][    T1] ocfs2: Registered cluster interface o2cb
[    7.235500][    T1] ocfs2: Registered cluster interface user
[    7.237529][    T1] OCFS2 User DLM kernel interface loaded
[    7.250453][    T1] gfs2: GFS2 installed
[    7.264209][    T1] ceph: loaded (mds proto 32)
[    7.278952][    T1] NET: Registered PF_ALG protocol family
[    7.280354][    T1] xor: automatically using best checksumming function   avx       
[    7.281560][    T1] async_tx: api initialized (async)
[    7.282618][    T1] Key type asymmetric registered
[    7.283598][    T1] Asymmetric key parser 'x509' registered
[    7.284695][    T1] Asymmetric key parser 'pkcs8' registered
[    7.285759][    T1] Key type pkcs7_test registered
[    7.290183][    T1] alg: self-tests for CTR-KDF (hmac(sha256)) passed
[    7.291911][    T1] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 240)
[    7.294225][    T1] io scheduler mq-deadline registered
[    7.295495][    T1] io scheduler kyber registered
[    7.297344][    T1] io scheduler bfq registered
[    7.309105][    T1] input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/input/input0
[    7.346741][    T1] ACPI: button: Power Button [PWRF]
[    7.349041][    T1] input: Sleep Button as /devices/LNXSYSTM:00/LNXSLPBN:00/input/input1
[    7.351595][    T1] ACPI: button: Sleep Button [SLPF]
[    7.377641][    T1] ACPI: \_SB_.LNKC: Enabled at IRQ 11
[    7.378625][    T1] virtio-pci 0000:00:03.0: virtio_pci: leaving for legacy driver
[    7.396163][    T1] ACPI: \_SB_.LNKD: Enabled at IRQ 10
[    7.397343][    T1] virtio-pci 0000:00:04.0: virtio_pci: leaving for legacy driver
[    7.417084][    T1] ACPI: \_SB_.LNKB: Enabled at IRQ 10
[    7.418128][    T1] virtio-pci 0000:00:06.0: virtio_pci: leaving for legacy driver
[    7.431573][    T1] virtio-pci 0000:00:07.0: virtio_pci: leaving for legacy driver
[    7.467042][  T220] kworker/u4:1 (220) used greatest stack depth: 27056 bytes left
[    7.472746][  T221] kworker/u4:1 (221) used greatest stack depth: 26960 bytes left
[    7.880988][    T1] N_HDLC line discipline registered with maxframe=4096
[    7.882545][    T1] Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
[    7.884539][    T1] 00:03: ttyS0 at I/O 0x3f8 (irq = 4, base_baud = 115200) is a 16550A
[    7.893541][    T1] 00:04: ttyS1 at I/O 0x2f8 (irq = 3, base_baud = 115200) is a 16550A
[    7.903006][    T1] 00:05: ttyS2 at I/O 0x3e8 (irq = 6, base_baud = 115200) is a 16550A
[    7.910260][    T1] 00:06: ttyS3 at I/O 0x2e8 (irq = 7, base_baud = 115200) is a 16550A
[    7.930315][    T1] Non-volatile memory driver v1.3
[    7.944423][    T1] Linux agpgart interface v0.103
[    7.947331][    T1] ACPI: bus type drm_connector registered
[    7.954182][    T1] [drm] Initialized vgem 1.0.0 20120112 for vgem on minor 0
[    7.964299][    T1] [drm] Initialized vkms 1.0.0 20180514 for vkms on minor 1
[    8.028476][    T1] Console: switching to colour frame buffer device 128x48
[    8.046434][    T1] platform vkms: [drm] fb0: vkmsdrmfb frame buffer device
[    8.047778][    T1] usbcore: registered new interface driver udl
[    8.112535][    T1] brd: module loaded
[    8.178418][    T1] loop: module loaded
[    8.269685][    T1] zram: Added device: zram0
[    8.277914][    T1] null_blk: disk nullb0 created
[    8.279227][    T1] null_blk: module loaded
[    8.280291][    T1] Guest personality initialized and is inactive
[    8.282253][    T1] VMCI host device registered (name=vmci, major=10, minor=119)
[    8.283868][    T1] Initialized host personality
[    8.285398][    T1] usbcore: registered new interface driver rtsx_usb
[    8.288036][    T1] usbcore: registered new interface driver viperboard
[    8.290550][    T1] usbcore: registered new interface driver dln2
[    8.292673][    T1] usbcore: registered new interface driver pn533_usb
[    8.299242][    T1] nfcsim 0.2 initialized
[    8.300323][    T1] usbcore: registered new interface driver port100
[    8.301868][    T1] usbcore: registered new interface driver nfcmrvl
[    8.308006][    T1] Loading iSCSI transport class v2.0-870.
[    8.345112][    T1] scsi host0: Virtio SCSI HBA
[    8.389808][    T1] st: Version 20160209, fixed bufsize 32768, s/g segs 256
[    8.394047][   T11] scsi 0:0:1:0: Direct-Access     Google   PersistentDisk   1    PQ: 0 ANSI: 6
[    8.427169][    T1] Rounding down aligned max_sectors from 4294967295 to 4294967288
[    8.430280][    T1] db_root: cannot open: /etc/target
[    8.432877][    T1] slram: not enough parameters.
[    8.441807][    T1] ftl_cs: FTL header not found.
[    8.500648][    T1] wireguard: WireGuard 1.0.0 loaded. See www.wireguard.com for information.
[    8.502726][    T1] wireguard: Copyright (C) 2015-2019 Jason A. Donenfeld <Jason@zx2c4.com>. All Rights Reserved.
[    8.505442][    T1] eql: Equalizer2002: Simon Janes (simon@ncm.com) and David S. Miller (davem@redhat.com)
[    8.516453][    T1] MACsec IEEE 802.1AE
[    8.525424][    T1] tun: Universal TUN/TAP device driver, 1.6
[    8.571093][    T1] ------------[ cut here ]------------
[    8.572622][    T1] WARNING: CPU: 0 PID: 1 at include/linux/cpumask.h:110 __netif_set_xps_queue+0x88e/0x1f30
[    8.574863][    T1] Modules linked in:
[    8.575981][    T1] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 6.1.0-rc1-syzkaller-00034-g5b52aebef895 #0
[    8.578509][    T1] Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/11/2022
[    8.581053][    T1] RIP: 0010:__netif_set_xps_queue+0x88e/0x1f30
[    8.582714][    T1] Code: fa 48 c7 c2 a0 a8 f4 8a be 2e 0a 00 00 48 c7 c7 40 a7 f4 8a c6 05 c2 40 74 06 01 e8 52 ca f1 01 e9 ef fd ff ff e8 d2 81 24 fa <0f> 0b e9 8e fa ff ff 8b 6c 24 38 e8 c2 81 24 fa 49 8d 7c 24 04 48
[    8.587669][    T1] RSP: 0000:ffffc90000067898 EFLAGS: 00010293
[    8.589339][    T1] RAX: 0000000000000000 RBX: 0000000000000002 RCX: 0000000000000000
[    8.591592][    T1] RDX: ffff88813fe50000 RSI: ffffffff875805ae RDI: 0000000000000004
[    8.593717][    T1] RBP: 0000000000000002 R08: 0000000000000004 R09: 0000000000000002
[    8.595628][    T1] R10: 0000000000000002 R11: 000000000008c07e R12: ffff88801ce1c280
[    8.597437][    T1] R13: 0000000000000003 R14: ffff88801ce1c298 R15: 0000000000000002
[    8.599572][    T1] FS:  0000000000000000(0000) GS:ffff8880b9a00000(0000) knlGS:0000000000000000
[    8.601992][    T1] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    8.603566][    T1] CR2: ffff88823ffff000 CR3: 000000000bc8e000 CR4: 00000000003506f0
[    8.605629][    T1] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[    8.607162][    T1] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[    8.608617][    T1] Call Trace:
[    8.609378][    T1]  <TASK>
[    8.610085][    T1]  ? vp_bus_name+0xc0/0xc0
[    8.611086][    T1]  virtnet_set_affinity+0x4f0/0x750
[    8.612333][    T1]  ? skb_recv_done+0x120/0x120
[    8.613675][    T1]  virtnet_probe+0x12ae/0x31e0
[    8.614678][    T1]  ? virtnet_find_vqs+0xc30/0xc30
[    8.615861][    T1]  virtio_dev_probe+0x577/0x870
[    8.617108][    T1]  ? virtio_features_ok+0x1e0/0x1e0
[    8.618369][    T1]  really_probe+0x249/0xb90
[    8.619549][    T1]  __driver_probe_device+0x1df/0x4d0
[    8.621025][    T1]  driver_probe_device+0x4c/0x1a0
[    8.622503][    T1]  __driver_attach+0x1d0/0x550
[    8.623795][    T1]  ? __device_attach_driver+0x2e0/0x2e0
[    8.625384][    T1]  bus_for_each_dev+0x147/0x1d0
[    8.626734][    T1]  ? subsys_dev_iter_exit+0x20/0x20
[    8.628079][    T1]  bus_add_driver+0x4c9/0x640
[    8.629430][    T1]  driver_register+0x220/0x3a0
[    8.630693][    T1]  ? veth_init+0x11/0x11
[    8.631946][    T1]  virtio_net_driver_init+0x93/0xd2
[    8.633254][    T1]  do_one_initcall+0x13d/0x780
[    8.634741][    T1]  ? trace_event_raw_event_initcall_level+0x1f0/0x1f0
[    8.636673][    T1]  ? parameq+0x140/0x170
[    8.637876][    T1]  kernel_init_freeable+0x6ff/0x788
[    8.639145][    T1]  ? rest_init+0x270/0x270
[    8.640483][    T1]  kernel_init+0x1a/0x1d0
[    8.641440][    T1]  ? rest_init+0x270/0x270
[    8.642564][    T1]  ret_from_fork+0x1f/0x30
[    8.643863][    T1]  </TASK>
[    8.644754][    T1] Kernel panic - not syncing: panic_on_warn set ...
[    8.646087][    T1] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 6.1.0-rc1-syzkaller-00034-g5b52aebef895 #0
[    8.646528][    T1] Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/11/2022
[    8.646528][    T1] Call Trace:
[    8.646528][    T1]  <TASK>
[    8.646528][    T1]  dump_stack_lvl+0xcd/0x134
[    8.646528][    T1]  panic+0x2c8/0x622
[    8.646528][    T1]  ? panic_print_sys_info.part.0+0x110/0x110
[    8.646528][    T1]  ? __warn.cold+0x24b/0x350
[    8.646528][    T1]  ? __netif_set_xps_queue+0x88e/0x1f30
[    8.646528][    T1]  __warn.cold+0x25c/0x350
[    8.646528][    T1]  ? __netif_set_xps_queue+0x88e/0x1f30
[    8.646528][    T1]  report_bug+0x1bc/0x210
[    8.646528][    T1]  handle_bug+0x3c/0x70
[    8.646528][    T1]  exc_invalid_op+0x14/0x40
[    8.646528][    T1]  asm_exc_invalid_op+0x16/0x20
[    8.646528][    T1] RIP: 0010:__netif_set_xps_queue+0x88e/0x1f30
[    8.646528][    T1] Code: fa 48 c7 c2 a0 a8 f4 8a be 2e 0a 00 00 48 c7 c7 40 a7 f4 8a c6 05 c2 40 74 06 01 e8 52 ca f1 01 e9 ef fd ff ff e8 d2 81 24 fa <0f> 0b e9 8e fa ff ff 8b 6c 24 38 e8 c2 81 24 fa 49 8d 7c 24 04 48
[    8.646528][    T1] RSP: 0000:ffffc90000067898 EFLAGS: 00010293
[    8.646528][    T1] RAX: 0000000000000000 RBX: 0000000000000002 RCX: 0000000000000000
[    8.646528][    T1] RDX: ffff88813fe50000 RSI: ffffffff875805ae RDI: 0000000000000004
[    8.646528][    T1] RBP: 0000000000000002 R08: 0000000000000004 R09: 0000000000000002
[    8.646528][    T1] R10: 0000000000000002 R11: 000000000008c07e R12: ffff88801ce1c280
[    8.646528][    T1] R13: 0000000000000003 R14: ffff88801ce1c298 R15: 0000000000000002
[    8.646528][    T1]  ? __netif_set_xps_queue+0x88e/0x1f30
[    8.646528][    T1]  ? __netif_set_xps_queue+0x88e/0x1f30
[    8.646528][    T1]  ? vp_bus_name+0xc0/0xc0
[    8.646528][    T1]  virtnet_set_affinity+0x4f0/0x750
[    8.646528][    T1]  ? skb_recv_done+0x120/0x120
[    8.646528][    T1]  virtnet_probe+0x12ae/0x31e0
[    8.646528][    T1]  ? virtnet_find_vqs+0xc30/0xc30
[    8.646528][    T1]  virtio_dev_probe+0x577/0x870
[    8.646528][    T1]  ? virtio_features_ok+0x1e0/0x1e0
[    8.646528][    T1]  really_probe+0x249/0xb90
[    8.694969][    T1]  __driver_probe_device+0x1df/0x4d0
[    8.694969][    T1]  driver_probe_device+0x4c/0x1a0
[    8.694969][    T1]  __driver_attach+0x1d0/0x550
[    8.694969][    T1]  ? __device_attach_driver+0x2e0/0x2e0
[    8.699777][ T1090] sd 0:0:1:0: [sda] 4194304 512-byte logical blocks: (2.15 GB/2.00 GiB)
[    8.699831][ T1090] sd 0:0:1:0: [sda] 4096-byte physical blocks
[    8.699980][ T1090] sd 0:0:1:0: [sda] Write Protect is off
[    8.700013][ T1090] sd 0:0:1:0: [sda] Mode Sense: 1f 00 00 08
[    8.700333][ T1090] sd 0:0:1:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[    8.703866][    T1]  bus_for_each_dev+0x147/0x1d0
[    8.703866][    T1]  ? subsys_dev_iter_exit+0x20/0x20
[    8.711881][   T11] sd 0:0:1:0: Attached scsi generic sg0 type 0
[    8.711687][    T1]  bus_add_driver+0x4c9/0x640
[    8.711687][    T1]  driver_register+0x220/0x3a0
[    8.715821][    T1]  ? veth_init+0x11/0x11
[    8.715821][    T1]  virtio_net_driver_init+0x93/0xd2
[    8.715821][    T1]  do_one_initcall+0x13d/0x780
[    8.715821][    T1]  ? trace_event_raw_event_initcall_level+0x1f0/0x1f0
[    8.715821][    T1]  ? parameq+0x140/0x170
[    8.715821][    T1]  kernel_init_freeable+0x6ff/0x788
[    8.715821][    T1]  ? rest_init+0x270/0x270
[    8.715821][    T1]  kernel_init+0x1a/0x1d0
[    8.715821][    T1]  ? rest_init+0x270/0x270
[    8.715821][    T1]  ret_from_fork+0x1f/0x30
[    8.715821][    T1]  </TASK>
[    8.715821][    T1] Kernel Offset: disabled
[    8.715821][    T1] Rebooting in 86400 seconds..


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
GOGCCFLAGS="-fPIC -m64 -pthread -fmessage-length=0 -fdebug-prefix-map=/tmp/go-build1866141968=/tmp/go-build -gno-record-gcc-switches"

git status (err=<nil>)
HEAD detached at 08977f5d5
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
GOOS=linux GOARCH=amd64 go build "-ldflags=-s -w -X github.com/google/syzkaller/prog.GitRevision=08977f5d5e344fa0ac0b80af0b72fc3f1468d6a5 -X 'github.com/google/syzkaller/prog.gitRevisionDate=20221101-102309'" "-tags=syz_target syz_os_linux syz_arch_amd64 " -o ./bin/linux_amd64/syz-fuzzer github.com/google/syzkaller/syz-fuzzer
GOOS=linux GOARCH=amd64 go build "-ldflags=-s -w -X github.com/google/syzkaller/prog.GitRevision=08977f5d5e344fa0ac0b80af0b72fc3f1468d6a5 -X 'github.com/google/syzkaller/prog.gitRevisionDate=20221101-102309'" "-tags=syz_target syz_os_linux syz_arch_amd64 " -o ./bin/linux_amd64/syz-execprog github.com/google/syzkaller/tools/syz-execprog
GOOS=linux GOARCH=amd64 go build "-ldflags=-s -w -X github.com/google/syzkaller/prog.GitRevision=08977f5d5e344fa0ac0b80af0b72fc3f1468d6a5 -X 'github.com/google/syzkaller/prog.gitRevisionDate=20221101-102309'" "-tags=syz_target syz_os_linux syz_arch_amd64 " -o ./bin/linux_amd64/syz-stress github.com/google/syzkaller/tools/syz-stress
mkdir -p ./bin/linux_amd64
gcc -o ./bin/linux_amd64/syz-executor executor/executor.cc \
	-m64 -O2 -pthread -Wall -Werror -Wparentheses -Wunused-const-variable -Wframe-larger-than=16384 -Wno-stringop-overflow -Wno-array-bounds -Wno-format-overflow -static-pie -fpermissive -w -DGOOS_linux=1 -DGOARCH_amd64=1 \
	-DHOSTGOOS_linux=1 -DGIT_REVISION=\"08977f5d5e344fa0ac0b80af0b72fc3f1468d6a5\"


Error text is too large and was truncated, full error text is at:
https://syzkaller.appspot.com/x/error.txt?x=14d2420a880000


Tested on:

commit:         5b52aebe ovl: call posix_acl_release() after error che..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/vfs/idmapping.git/
kernel config:  https://syzkaller.appspot.com/x/.config?x=551658738d0ad6d
dashboard link: https://syzkaller.appspot.com/bug?extid=3f6ef1c4586bb6fd1f61
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

Note: no patches were applied.
