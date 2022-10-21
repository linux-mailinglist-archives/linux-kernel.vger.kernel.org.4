Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 201CC606E68
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 05:45:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229760AbiJUDpa convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 20 Oct 2022 23:45:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbiJUDpZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 23:45:25 -0400
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE1EC12E0DF
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 20:45:21 -0700 (PDT)
Received: by mail-io1-f69.google.com with SMTP id w16-20020a6b4a10000000b006a5454c789eso1431836iob.20
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 20:45:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:to:from:subject:message-id:in-reply-to
         :date:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BkHmi2EVY9rorUpBk8+D72Ir+bcXAmGJkjQFq8c4fjo=;
        b=FXWbZkk8BlLst60fX1hNnjyZQBJJv36fP3Zl+Bv36qol5jYSI7b2APi0wC3Xowqhqz
         kl+jjSVIQHFGLFfWIzuFgECwdXfnvwgcIEbXp5L0Ff8zZhVimXeATcPEPJAFo4ucEtT4
         sDH2jnf+eKT5BjN3hGdA+vqAkOZ1kukdso2iTUcO7HlClebqEl1o/87NPxlFVVluUQ7g
         Cb0rT18q0ysoSpPREgjyOo4vpdv0sXV1jdGhSS4m2gdBg4nHoxvRGJtf+pxUOFbV0rDA
         U/IXHg6eHtyVus8DV/MXI4As9iKoeYD2vm8uKJsTcYk9a8wGwJDT4y//pOJQF9RQTWEf
         B6Gw==
X-Gm-Message-State: ACrzQf3lZMR732wYxDoJJCxkNrSd/mBzig+3wVExrlPWZhgotoMSdMLw
        rg9rMRIHC9Ku5PFqdr2Bv7u4puIHX1aGpO0FZ5VQ/R63mZiO
X-Google-Smtp-Source: AMsMyM7PGVBDjhhoTvzdX+Jf6swRUGHSkU4LZM2PzW20pcyonjC3wZPTKNorT4YU3xnOKvJJ0Ujb4xUthfA9hgKtVv9w+eJU1oLQ
MIME-Version: 1.0
X-Received: by 2002:a05:6638:d96:b0:363:9ed9:1112 with SMTP id
 l22-20020a0566380d9600b003639ed91112mr12178128jaj.171.1666323921029; Thu, 20
 Oct 2022 20:45:21 -0700 (PDT)
Date:   Thu, 20 Oct 2022 20:45:21 -0700
In-Reply-To: <20221021032341.1481-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000064d19605eb8345de@google.com>
Subject: Re: [syzbot] KASAN: use-after-free Read in kernfs_next_descendant_post
 (2)
From:   syzbot <syzbot+6bc35f3913193fe7f0d3@syzkaller.appspotmail.com>
To:     hdanton@sina.com, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, tj@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

her
[    5.597695][    T1] NFS: Registering the id_resolver key type
[    5.599149][    T1] Key type id_resolver registered
[    5.600622][    T1] Key type id_legacy registered
[    5.601685][    T1] nfs4filelayout_init: NFSv4 File Layout Driver Registering...
[    5.602778][    T1] nfs4flexfilelayout_init: NFSv4 Flexfile Layout Driver Registering...
[    5.611543][    T1] Key type cifs.spnego registered
[    5.613253][    T1] Key type cifs.idmap registered
[    5.614650][    T1] ntfs: driver 2.1.32 [Flags: R/W].
[    5.616739][    T1] ntfs3: Max link count 4000
[    5.617506][    T1] ntfs3: Enabled Linux POSIX ACLs support
[    5.618484][    T1] ntfs3: Read-only LZX/Xpress compression included
[    5.621078][    T1] efs: 1.0a - http://aeschi.ch.eu.org/efs/
[    5.622255][    T1] jffs2: version 2.2. (NAND) (SUMMARY)  © 2001-2006 Red Hat, Inc.
[    5.626600][    T1] romfs: ROMFS MTD (C) 2007 Red Hat, Inc.
[    5.628348][    T1] QNX4 filesystem 0.2.3 registered.
[    5.630193][    T1] qnx6: QNX6 filesystem 1.0.0 registered.
[    5.632221][    T1] fuse: init (API version 7.37)
[    5.636288][    T1] orangefs_debugfs_init: called with debug mask: :none: :0:
[    5.637940][    T1] orangefs_init: module version upstream loaded
[    5.639824][    T1] JFS: nTxBlock = 8192, nTxLock = 65536
[    5.653813][    T1] SGI XFS with ACLs, security attributes, realtime, quota, fatal assert, debug enabled
[    5.666765][    T1] 9p: Installing v9fs 9p2000 file system support
[    5.669394][    T1] NILFS version 2 loaded
[    5.670723][    T1] befs: version: 0.9.3
[    5.672670][    T1] ocfs2: Registered cluster interface o2cb
[    5.674777][    T1] ocfs2: Registered cluster interface user
[    5.676600][    T1] OCFS2 User DLM kernel interface loaded
[    5.687111][    T1] gfs2: GFS2 installed
[    5.698581][    T1] ceph: loaded (mds proto 32)
[    5.710024][    T1] NET: Registered PF_ALG protocol family
[    5.711181][    T1] xor: automatically using best checksumming function   avx       
[    5.712855][    T1] async_tx: api initialized (async)
[    5.714028][    T1] Key type asymmetric registered
[    5.714899][    T1] Asymmetric key parser 'x509' registered
[    5.715986][    T1] Asymmetric key parser 'pkcs8' registered
[    5.716969][    T1] Key type pkcs7_test registered
[    5.720754][    T1] alg: self-tests for CTR-KDF (hmac(sha256)) passed
[    5.721886][    T1] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 240)
[    5.723595][    T1] io scheduler mq-deadline registered
[    5.725006][    T1] io scheduler kyber registered
[    5.726238][    T1] io scheduler bfq registered
[    5.733302][    T1] input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/input/input0
[    5.760627][    T1] ACPI: button: Power Button [PWRF]
[    5.763071][    T1] input: Sleep Button as /devices/LNXSYSTM:00/LNXSLPBN:00/input/input1
[    5.765552][    T1] ACPI: button: Sleep Button [SLPF]
[    5.785152][    T1] ACPI: \_SB_.LNKC: Enabled at IRQ 11
[    5.786468][    T1] virtio-pci 0000:00:03.0: virtio_pci: leaving for legacy driver
[    5.800106][    T1] ACPI: \_SB_.LNKD: Enabled at IRQ 10
[    5.801283][    T1] virtio-pci 0000:00:04.0: virtio_pci: leaving for legacy driver
[    5.818083][    T1] ACPI: \_SB_.LNKB: Enabled at IRQ 10
[    5.819227][    T1] virtio-pci 0000:00:06.0: virtio_pci: leaving for legacy driver
[    6.139234][    T1] N_HDLC line discipline registered with maxframe=4096
[    6.143191][    T1] Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
[    6.145743][    T1] 00:03: ttyS0 at I/O 0x3f8 (irq = 4, base_baud = 115200) is a 16550A
[    6.153400][    T1] 00:04: ttyS1 at I/O 0x2f8 (irq = 3, base_baud = 115200) is a 16550A
[    6.158094][    T1] 00:05: ttyS2 at I/O 0x3e8 (irq = 6, base_baud = 115200) is a 16550A
[    6.164827][    T1] 00:06: ttyS3 at I/O 0x2e8 (irq = 7, base_baud = 115200) is a 16550A
[    6.173085][    T1] Non-volatile memory driver v1.3
[    6.191613][    T1] Linux agpgart interface v0.103
[    6.194194][    T1] ACPI: bus type drm_connector registered
[    6.199163][    T1] [drm] Initialized vgem 1.0.0 20120112 for vgem on minor 0
[    6.204590][    T1] [drm] Initialized vkms 1.0.0 20180514 for vkms on minor 1
[    6.264084][    T1] Console: switching to colour frame buffer device 128x48
[    6.281271][    T1] platform vkms: [drm] fb0: vkmsdrmfb frame buffer device
[    6.282951][    T1] usbcore: registered new interface driver udl
[    6.331971][    T1] brd: module loaded
[    6.381966][    T1] loop: module loaded
[    6.450450][    T1] zram: Added device: zram0
[    6.456807][    T1] null_blk: disk nullb0 created
[    6.457559][    T1] null_blk: module loaded
[    6.458703][    T1] Guest personality initialized and is inactive
[    6.460362][    T1] VMCI host device registered (name=vmci, major=10, minor=119)
[    6.461772][    T1] Initialized host personality
[    6.463064][    T1] usbcore: registered new interface driver rtsx_usb
[    6.464912][    T1] usbcore: registered new interface driver viperboard
[    6.466543][    T1] usbcore: registered new interface driver dln2
[    6.468098][    T1] usbcore: registered new interface driver pn533_usb
[    6.472749][    T1] nfcsim 0.2 initialized
[    6.473704][    T1] usbcore: registered new interface driver port100
[    6.475083][    T1] usbcore: registered new interface driver nfcmrvl
[    6.478962][    T1] Loading iSCSI transport class v2.0-870.
[    6.507427][    T1] scsi host0: Virtio SCSI HBA
[    6.546621][    T1] st: Version 20160209, fixed bufsize 32768, s/g segs 256
[    6.549977][   T91] scsi 0:0:1:0: Direct-Access     Google   PersistentDisk   1    PQ: 0 ANSI: 6
[    6.577518][    T1] Rounding down aligned max_sectors from 4294967295 to 4294967288
[    6.579716][    T1] db_root: cannot open: /etc/target
[    6.581597][    T1] slram: not enough parameters.
[    6.589382][    T1] ftl_cs: FTL header not found.
[    6.626146][    T1] wireguard: WireGuard 1.0.0 loaded. See www.wireguard.com for information.
[    6.627700][    T1] wireguard: Copyright (C) 2015-2019 Jason A. Donenfeld <Jason@zx2c4.com>. All Rights Reserved.
[    6.637162][    T1] eql: Equalizer2002: Simon Janes (simon@ncm.com) and David S. Miller (davem@redhat.com)
[    6.647509][    T1] MACsec IEEE 802.1AE
[    6.657940][    T1] tun: Universal TUN/TAP device driver, 1.6
[    6.715241][    T1] ------------[ cut here ]------------
[    6.716632][    T1] WARNING: CPU: 0 PID: 1 at include/linux/cpumask.h:110 __netif_set_xps_queue+0x88e/0x1f30
[    6.718427][    T1] Modules linked in:
[    6.719252][    T1] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 6.1.0-rc1-syzkaller-00025-gaae703b02f92-dirty #0
[    6.721441][    T1] Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/11/2022
[    6.723065][    T1] RIP: 0010:__netif_set_xps_queue+0x88e/0x1f30
[    6.724387][    T1] Code: fa 48 c7 c2 a0 a8 f4 8a be 2e 0a 00 00 48 c7 c7 40 a7 f4 8a c6 05 a2 69 74 06 01 e8 f2 e3 f1 01 e9 ef fd ff ff e8 e2 ae 24 fa <0f> 0b e9 8e fa ff ff 8b 6c 24 38 e8 d2 ae 24 fa 49 8d 7c 24 04 48
[    6.727854][    T1] RSP: 0018:ffffc90000067898 EFLAGS: 00010293
[    6.728833][    T1] RAX: 0000000000000000 RBX: 0000000000000002 RCX: 0000000000000000
[    6.731435][    T1] RDX: ffff88813fe50000 RSI: ffffffff8757dc0e RDI: 0000000000000004
[    6.734156][    T1] RBP: 0000000000000002 R08: 0000000000000004 R09: 0000000000000002
[    6.735691][    T1] R10: 0000000000000002 R11: 000000000008c07e R12: ffff88801fb48680
[    6.737253][    T1] R13: 0000000000000003 R14: ffff88801fb48698 R15: 0000000000000002
[    6.738658][    T1] FS:  0000000000000000(0000) GS:ffff8880b9a00000(0000) knlGS:0000000000000000
[    6.740493][    T1] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    6.741783][    T1] CR2: ffff88823ffff000 CR3: 000000000bc8e000 CR4: 0000000000350ef0
[    6.743162][    T1] Call Trace:
[    6.744268][    T1]  <TASK>
[    6.744948][    T1]  ? vp_bus_name+0xc0/0xc0
[    6.745802][    T1]  virtnet_set_affinity+0x4f0/0x750
[    6.746726][    T1]  ? skb_recv_done+0x120/0x120
[    6.747533][    T1]  virtnet_probe+0x12ae/0x31e0
[    6.748436][    T1]  ? virtnet_find_vqs+0xc30/0xc30
[    6.749270][    T1]  virtio_dev_probe+0x577/0x870
[    6.750252][    T1]  ? virtio_features_ok+0x1e0/0x1e0
[    6.751234][    T1]  really_probe+0x249/0xb90
[    6.752007][    T1]  __driver_probe_device+0x1df/0x4d0
[    6.752884][    T1]  driver_probe_device+0x4c/0x1a0
[    6.753955][    T1]  __driver_attach+0x1d0/0x550
[    6.754899][    T1]  ? __device_attach_driver+0x2e0/0x2e0
[    6.756222][    T1]  bus_for_each_dev+0x147/0x1d0
[    6.756970][    T1]  ? subsys_dev_iter_exit+0x20/0x20
[    6.758183][    T1]  bus_add_driver+0x4c9/0x640
[    6.759241][    T1]  driver_register+0x220/0x3a0
[    6.760270][    T1]  ? veth_init+0x11/0x11
[    6.761196][    T1]  virtio_net_driver_init+0x93/0xd2
[    6.762104][    T1]  do_one_initcall+0x13d/0x780
[    6.763172][    T1]  ? trace_event_raw_event_initcall_level+0x1f0/0x1f0
[    6.764469][    T1]  ? parameq+0x140/0x170
[    6.765271][    T1]  kernel_init_freeable+0x6ff/0x788
[    6.766089][    T1]  ? rest_init+0x270/0x270
[    6.766807][    T1]  kernel_init+0x1a/0x1d0
[    6.767976][    T1]  ? rest_init+0x270/0x270
[    6.768818][    T1]  ret_from_fork+0x1f/0x30
[    6.770003][    T1]  </TASK>
[    6.770460][    T1] Kernel panic - not syncing: panic_on_warn set ...
[    6.771442][    T1] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 6.1.0-rc1-syzkaller-00025-gaae703b02f92-dirty #0
[    6.773956][    T1] Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/11/2022
[    6.776134][    T1] Call Trace:
[    6.776861][    T1]  <TASK>
[    6.777450][    T1]  dump_stack_lvl+0xcd/0x134
[    6.779001][    T1]  panic+0x2c8/0x622
[    6.779782][    T1]  ? panic_print_sys_info.part.0+0x110/0x110
[    6.781025][   T34] sd 0:0:1:0: [sda] 4194304 512-byte logical blocks: (2.15 GB/2.00 GiB)
[    6.781062][   T34] sd 0:0:1:0: [sda] 4096-byte physical blocks
[    6.781197][   T34] sd 0:0:1:0: [sda] Write Protect is off
[    6.781220][   T34] sd 0:0:1:0: [sda] Mode Sense: 1f 00 00 08
[    6.781450][   T34] sd 0:0:1:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[    6.787778][    T1]  ? __warn.cold+0x24b/0x350
[    6.789536][   T91] sd 0:0:1:0: Attached scsi generic sg0 type 0
[    6.790433][    T1]  ? __netif_set_xps_queue+0x88e/0x1f30
[    6.790433][    T1]  __warn.cold+0x25c/0x350
[    6.790433][    T1]  ? __netif_set_xps_queue+0x88e/0x1f30
[    6.790433][    T1]  report_bug+0x1bc/0x210
[    6.790433][    T1]  handle_bug+0x3c/0x70
[    6.794504][   T34]  sda: sda1
[    6.795927][   T34] sd 0:0:1:0: [sda] Attached SCSI disk
[    6.790433][    T1]  exc_invalid_op+0x14/0x40
[    6.790433][    T1]  asm_exc_invalid_op+0x16/0x20
[    6.799643][    T1] RIP: 0010:__netif_set_xps_queue+0x88e/0x1f30
[    6.799643][    T1] Code: fa 48 c7 c2 a0 a8 f4 8a be 2e 0a 00 00 48 c7 c7 40 a7 f4 8a c6 05 a2 69 74 06 01 e8 f2 e3 f1 01 e9 ef fd ff ff e8 e2 ae 24 fa <0f> 0b e9 8e fa ff ff 8b 6c 24 38 e8 d2 ae 24 fa 49 8d 7c 24 04 48
[    6.799643][    T1] RSP: 0018:ffffc90000067898 EFLAGS: 00010293
[    6.799643][    T1] RAX: 0000000000000000 RBX: 0000000000000002 RCX: 0000000000000000
[    6.799643][    T1] RDX: ffff88813fe50000 RSI: ffffffff8757dc0e RDI: 0000000000000004
[    6.799643][    T1] RBP: 0000000000000002 R08: 0000000000000004 R09: 0000000000000002
[    6.799643][    T1] R10: 0000000000000002 R11: 000000000008c07e R12: ffff88801fb48680
[    6.799643][    T1] R13: 0000000000000003 R14: ffff88801fb48698 R15: 0000000000000002
[    6.799643][    T1]  ? __netif_set_xps_queue+0x88e/0x1f30
[    6.799643][    T1]  ? __netif_set_xps_queue+0x88e/0x1f30
[    6.799643][    T1]  ? vp_bus_name+0xc0/0xc0
[    6.799643][    T1]  virtnet_set_affinity+0x4f0/0x750
[    6.799643][    T1]  ? skb_recv_done+0x120/0x120
[    6.799643][    T1]  virtnet_probe+0x12ae/0x31e0
[    6.799643][    T1]  ? virtnet_find_vqs+0xc30/0xc30
[    6.799643][    T1]  virtio_dev_probe+0x577/0x870
[    6.799643][    T1]  ? virtio_features_ok+0x1e0/0x1e0
[    6.799643][    T1]  really_probe+0x249/0xb90
[    6.799643][    T1]  __driver_probe_device+0x1df/0x4d0
[    6.799643][    T1]  driver_probe_device+0x4c/0x1a0
[    6.799643][    T1]  __driver_attach+0x1d0/0x550
[    6.799643][    T1]  ? __device_attach_driver+0x2e0/0x2e0
[    6.799643][    T1]  bus_for_each_dev+0x147/0x1d0
[    6.799643][    T1]  ? subsys_dev_iter_exit+0x20/0x20
[    6.799643][    T1]  bus_add_driver+0x4c9/0x640
[    6.799643][    T1]  driver_register+0x220/0x3a0
[    6.799643][    T1]  ? veth_init+0x11/0x11
[    6.829623][    T1]  virtio_net_driver_init+0x93/0xd2
[    6.829623][    T1]  do_one_initcall+0x13d/0x780
[    6.829623][    T1]  ? trace_event_raw_event_initcall_level+0x1f0/0x1f0
[    6.829623][    T1]  ? parameq+0x140/0x170
[    6.829623][    T1]  kernel_init_freeable+0x6ff/0x788
[    6.829623][    T1]  ? rest_init+0x270/0x270
[    6.829623][    T1]  kernel_init+0x1a/0x1d0
[    6.829623][    T1]  ? rest_init+0x270/0x270
[    6.829623][    T1]  ret_from_fork+0x1f/0x30
[    6.829623][    T1]  </TASK>
[    6.829623][    T1] Kernel Offset: disabled
[    6.829623][    T1] Rebooting in 86400 seconds..


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
GOGCCFLAGS="-fPIC -m64 -pthread -fmessage-length=0 -fdebug-prefix-map=/tmp/go-build2307492022=/tmp/go-build -gno-record-gcc-switches"

git status (err=<nil>)
HEAD detached at b31320fc8
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
GOOS=linux GOARCH=amd64 go build "-ldflags=-s -w -X github.com/google/syzkaller/prog.GitRevision=b31320fc8f3519e40494f64ebf77c13d16284bfd -X 'github.com/google/syzkaller/prog.gitRevisionDate=20221018-073740'" "-tags=syz_target syz_os_linux syz_arch_amd64 " -o ./bin/linux_amd64/syz-fuzzer github.com/google/syzkaller/syz-fuzzer
GOOS=linux GOARCH=amd64 go build "-ldflags=-s -w -X github.com/google/syzkaller/prog.GitRevision=b31320fc8f3519e40494f64ebf77c13d16284bfd -X 'github.com/google/syzkaller/prog.gitRevisionDate=20221018-073740'" "-tags=syz_target syz_os_linux syz_arch_amd64 " -o ./bin/linux_amd64/syz-execprog github.com/google/syzkaller/tools/syz-execprog
GOOS=linux GOARCH=amd64 go build "-ldflags=-s -w -X github.com/google/syzkaller/prog.GitRevision=b31320fc8f3519e40494f64ebf77c13d16284bfd -X 'github.com/google/syzkaller/prog.gitRevisionDate=20221018-073740'" "-tags=syz_target syz_os_linux syz_arch_amd64 " -o ./bin/linux_amd64/syz-stress github.com/google/syzkaller/tools/syz-stress
mkdir -p ./bin/linux_amd64
gcc -o ./bin/linux_amd64/syz-executor executor/executor.cc \
	-m64 -O2 -pthread -Wall -Werror -Wparentheses -Wunused-const-variable -Wframe-larger-than=16384 -Wno-stringop-overflow -Wno-array-bounds -Wno-format-overflow -static-pie -fpermissive -w -DGOOS_linux=1 -DGOARCH_amd64=1 \
	-DHOSTGOOS_linux=1 -DGIT_REVISION=\"b31320fc8f3519e40494f64ebf77c13d16284bfd\"


Error text is too large and was truncated, full error text is at:
https://syzkaller.appspot.com/x/error.txt?x=16f2e14a880000


Tested on:

commit:         aae703b0 Merge tag 'for-6.1-rc1-tag' of git://git.kern..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
kernel config:  https://syzkaller.appspot.com/x/.config?x=ea03ca45176080bc
dashboard link: https://syzkaller.appspot.com/bug?extid=6bc35f3913193fe7f0d3
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=135783e6880000

