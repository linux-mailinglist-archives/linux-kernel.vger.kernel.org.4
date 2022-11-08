Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 398F0621C12
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 19:39:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232037AbiKHSjx convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 8 Nov 2022 13:39:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231998AbiKHSjo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 13:39:44 -0500
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DA8D6828F
        for <linux-kernel@vger.kernel.org>; Tue,  8 Nov 2022 10:39:41 -0800 (PST)
Received: by mail-il1-f199.google.com with SMTP id d2-20020a056e020be200b00300ecc7e0d4so9193523ilu.5
        for <linux-kernel@vger.kernel.org>; Tue, 08 Nov 2022 10:39:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:to:from:subject:message-id:date
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LdYYNdvvULBDfna+ja4PuVviLX+ydCR/WPM5KJJ79Ig=;
        b=ds56ink7hUiD0s10AHdnMMHUni813dnkqDClIa1l7Y5Qm5OeHhkLhPd0ZITc29t5VO
         mc33GWgwh/DCpOMdLWXV8TMlZbAnHQAgTIvoMTJ/pgXuLGCZHiVJHPUadFm0mMmPNUoT
         Lj24B3iE7O7+cgSkr2CbQnXHnabjZQLnnyonrt4c/BETkKW0iQEWgrrDCzR6W8CWXRg4
         d39mvZL6FU/MqBZj8nODtwC+AgSm/w/QVtVQzkPdLN2MIhMmGTJY5lljN5jgX7GqF1f6
         U9a3/KeZk7IMdRml14nmMtD0eqqb20NVel3m5KP6jBeUEkEwq2QOP50djUyXZYCV/5RT
         qwJg==
X-Gm-Message-State: ACrzQf3DhX28kXDsnQ799swuYyiOVDejMs0IY1TQbWdv1vnfnpwLCq6S
        k2EYakBowSkfvDskyUwKeOJ1snn50jG89cG+rEXGy/r7ZIAa
X-Google-Smtp-Source: AMsMyM6SZR6vb4SztIWl9PyvXrG0HM0mXf+VzI6g1JBkE7oJv1L3EvlYO/8Bdncezl2RzrmEY5Px8whmOCln8/7/UpQ73cnKAcgu
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a2a:b0:300:e703:34b7 with SMTP id
 g10-20020a056e021a2a00b00300e70334b7mr766239ile.250.1667932780825; Tue, 08
 Nov 2022 10:39:40 -0800 (PST)
Date:   Tue, 08 Nov 2022 10:39:40 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000e915eb05ecf9dc4d@google.com>
Subject: [syzbot] linux-next boot error: WARNING in kthread_should_stop
From:   syzbot <syzbot+25aae26fb74bd5909706@syzkaller.appspotmail.com>
To:     Jason@zx2c4.com, herbert@gondor.apana.org.au,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-next@vger.kernel.org, linux@dominikbrodowski.net,
        olivia@selenic.com, sfr@canb.auug.org.au,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    b6fc3fddade7 Add linux-next specific files for 20221108
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=10b69576880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c01b9a44770695e7
dashboard link: https://syzkaller.appspot.com/bug?extid=25aae26fb74bd5909706
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/15edfbb79353/disk-b6fc3fdd.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/13c2669d9d08/vmlinux-b6fc3fdd.xz
kernel image: https://storage.googleapis.com/syzbot-assets/9d6adc8ab98a/bzImage-b6fc3fdd.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+25aae26fb74bd5909706@syzkaller.appspotmail.com

ntfs3: Read-only LZX/Xpress compression included
efs: 1.0a - http://aeschi.ch.eu.org/efs/
jffs2: version 2.2. (NAND) (SUMMARY)  © 2001-2006 Red Hat, Inc.
romfs: ROMFS MTD (C) 2007 Red Hat, Inc.
QNX4 filesystem 0.2.3 registered.
qnx6: QNX6 filesystem 1.0.0 registered.
fuse: init (API version 7.38)
orangefs_debugfs_init: called with debug mask: :none: :0:
orangefs_init: module version upstream loaded
JFS: nTxBlock = 8192, nTxLock = 65536
SGI XFS with ACLs, security attributes, realtime, quota, fatal assert, debug enabled
9p: Installing v9fs 9p2000 file system support
NILFS version 2 loaded
befs: version: 0.9.3
ocfs2: Registered cluster interface o2cb
ocfs2: Registered cluster interface user
OCFS2 User DLM kernel interface loaded
gfs2: GFS2 installed
ceph: loaded (mds proto 32)
NET: Registered PF_ALG protocol family
xor: automatically using best checksumming function   avx       
async_tx: api initialized (async)
Key type asymmetric registered
Asymmetric key parser 'x509' registered
Asymmetric key parser 'pkcs8' registered
Key type pkcs7_test registered
alg: self-tests for CTR-KDF (hmac(sha256)) passed
Block layer SCSI generic (bsg) driver version 0.4 loaded (major 240)
io scheduler mq-deadline registered
io scheduler kyber registered
io scheduler bfq registered
input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/input/input0
ACPI: button: Power Button [PWRF]
input: Sleep Button as /devices/LNXSYSTM:00/LNXSLPBN:00/input/input1
ACPI: button: Sleep Button [SLPF]
ACPI: \_SB_.LNKC: Enabled at IRQ 11
virtio-pci 0000:00:03.0: virtio_pci: leaving for legacy driver
ACPI: \_SB_.LNKD: Enabled at IRQ 10
virtio-pci 0000:00:04.0: virtio_pci: leaving for legacy driver
ACPI: \_SB_.LNKB: Enabled at IRQ 10
virtio-pci 0000:00:06.0: virtio_pci: leaving for legacy driver
virtio-pci 0000:00:07.0: virtio_pci: leaving for legacy driver
N_HDLC line discipline registered with maxframe=4096
Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
00:03: ttyS0 at I/O 0x3f8 (irq = 4, base_baud = 115200) is a 16550A
00:04: ttyS1 at I/O 0x2f8 (irq = 3, base_baud = 115200) is a 16550A
00:05: ttyS2 at I/O 0x3e8 (irq = 6, base_baud = 115200) is a 16550A
00:06: ttyS3 at I/O 0x2e8 (irq = 7, base_baud = 115200) is a 16550A
Non-volatile memory driver v1.3
------------[ cut here ]------------
WARNING: CPU: 0 PID: 1 at kernel/kthread.c:75 to_kthread kernel/kthread.c:75 [inline]
WARNING: CPU: 0 PID: 1 at kernel/kthread.c:75 kthread_should_stop+0xaf/0xd0 kernel/kthread.c:157
Modules linked in:
CPU: 0 PID: 1 Comm: swapper/0 Not tainted 6.1.0-rc4-next-20221108-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/26/2022
RIP: 0010:to_kthread kernel/kthread.c:75 [inline]
RIP: 0010:kthread_should_stop+0xaf/0xd0 kernel/kthread.c:157
Code: 79 00 48 89 da 48 b8 00 00 00 00 00 fc ff df 48 c1 ea 03 80 3c 02 00 75 1c 48 8b 03 5b 5d 48 d1 e8 83 e0 01 c3 e8 51 c4 2c 00 <0f> 0b eb 9d e8 18 9c 79 00 eb 80 48 89 df e8 1e 9c 79 00 eb da e8
RSP: 0000:ffffc90000067af0 EFLAGS: 00010293
RAX: 0000000000000000 RBX: ffff888140168000 RCX: 0000000000000000
RDX: ffff888140168000 RSI: ffffffff815016df RDI: 0000000000000005
RBP: 0000000000000000 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
R13: 00000000000000fa R14: ffff8881455f2e00 R15: 0000000000000020
FS:  0000000000000000(0000) GS:ffff8880b9a00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffff88823ffff000 CR3: 000000000bc8e000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 add_hwgenerator_randomness+0x5a/0x170 drivers/char/random.c:907
 add_early_randomness+0x104/0x1d0 drivers/char/hw_random/core.c:74
 hwrng_register+0x3b6/0x530 drivers/char/hw_random/core.c:587
 virtrng_scan+0x37/0x90 drivers/char/hw_random/virtio-rng.c:207
 virtio_dev_probe+0x639/0x870 drivers/virtio/virtio.c:314
 call_driver_probe drivers/base/dd.c:560 [inline]
 really_probe+0x249/0xb90 drivers/base/dd.c:639
 __driver_probe_device+0x1df/0x4d0 drivers/base/dd.c:778
 driver_probe_device+0x4c/0x1a0 drivers/base/dd.c:808
 __driver_attach+0x1d0/0x550 drivers/base/dd.c:1190
 bus_for_each_dev+0x147/0x1d0 drivers/base/bus.c:301
 bus_add_driver+0x4c9/0x640 drivers/base/bus.c:618
 driver_register+0x220/0x3a0 drivers/base/driver.c:246
 do_one_initcall+0x13d/0x780 init/main.c:1306
 do_initcall_level init/main.c:1379 [inline]
 do_initcalls init/main.c:1395 [inline]
 do_basic_setup init/main.c:1414 [inline]
 kernel_init_freeable+0x6f9/0x782 init/main.c:1634
 kernel_init+0x1a/0x1d0 init/main.c:1522
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:308
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
