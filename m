Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F55C6FBE6B
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 06:48:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229579AbjEIEsH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 00:48:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234490AbjEIEra (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 00:47:30 -0400
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FFEE1B1
        for <linux-kernel@vger.kernel.org>; Mon,  8 May 2023 21:46:46 -0700 (PDT)
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-76c365e0114so388721339f.3
        for <linux-kernel@vger.kernel.org>; Mon, 08 May 2023 21:46:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683607546; x=1686199546;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Nka0UQDLy3l68Pe1UcuY6PZ6w5ZWCFXNDKJyD70sHRs=;
        b=eSYr0nwGVIl4PYAQPy9F4Ff/3iqKfNwhZN3xKPewUaxGhPbc927t3RPbCa3I7puoG2
         gK3IQC9TPlqTy6yLInVkVb3ybIJy9JWoTra7Xd7dc0ms0rOKgaVuetrD6fI+4shwMajh
         jUtMSpowU/ZIX2pc/iYMXEZjKIiRHbPavnCS9wuTGHyXWyBvBwslnTLHc3Ml3IO1mgx3
         zN8k2BosMbzqBTdQf6jzbVDRngFiEWv7qmcJKbmnvbamXcoIKeD0BHD6ase2y9+JLt+C
         haEg/XmNvHXImfG4KID7jdAkgciwHfbWKtQnselRjyW3ZWCsNZIj/107YEDe6mjwz5rX
         AE+g==
X-Gm-Message-State: AC+VfDwP7gfI3zKWl1a9l72FsUhwLMkrP9yAV9/iolFDZ+17CFWlqP2U
        ro3rHjtE+QN4Cnd0RijtzAHxaQeD6L7SNvkOiZGlLplLLtcr
X-Google-Smtp-Source: ACHHUZ7shSVpmodaX6RVegmcGe8XgRULmYBQuRb4Ww0tg08/7hT9bHiWeooxxQw/sSYOAUzb1CjNsQHniV3I6Pe4OGQWrOzcRmlr
MIME-Version: 1.0
X-Received: by 2002:a02:b11e:0:b0:3a7:e46e:ab64 with SMTP id
 r30-20020a02b11e000000b003a7e46eab64mr752942jah.1.1683607546669; Mon, 08 May
 2023 21:45:46 -0700 (PDT)
Date:   Mon, 08 May 2023 21:45:46 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c2b03c05fb3b6db0@google.com>
Subject: [syzbot] linux-next boot error: WARNING in workqueue_sysfs_register
From:   syzbot <syzbot+5b06ded6a65536fa99c2@syzkaller.appspotmail.com>
To:     jejb@linux.ibm.com, linux-kernel@vger.kernel.org,
        linux-next@vger.kernel.org, linux-scsi@vger.kernel.org,
        martin.petersen@oracle.com, sfr@canb.auug.org.au,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    47cba14ce6fc Add linux-next specific files for 20230509
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=17e063a8280000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d1f55a88ec660cdb
dashboard link: https://syzkaller.appspot.com/bug?extid=5b06ded6a65536fa99c2
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/0dff7f749545/disk-47cba14c.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/238b578b8345/vmlinux-47cba14c.xz
kernel image: https://storage.googleapis.com/syzbot-assets/2909e3e79ac1/bzImage-47cba14c.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+5b06ded6a65536fa99c2@syzkaller.appspotmail.com

Asymmetric key parser 'x509' registered
Asymmetric key parser 'pkcs8' registered
Key type pkcs7_test registered
Block layer SCSI generic (bsg) driver version 0.4 loaded (major 240)
io scheduler mq-deadline registered
io scheduler kyber registered
io scheduler bfq registered
input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/input/input0
ACPI: button: Power Button [PWRF]
input: Sleep Button as /devices/LNXSYSTM:00/LNXSLPBN:00/input/input1
ACPI: button: Sleep Button [SLPF]
ioatdma: Intel(R) QuickData Technology Driver 5.00
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
Linux agpgart interface v0.103
ACPI: bus type drm_connector registered
[drm] Initialized vgem 1.0.0 20120112 for vgem on minor 0
[drm] Initialized vkms 1.0.0 20180514 for vkms on minor 1
Console: switching to colour frame buffer device 128x48
platform vkms: [drm] fb0: vkmsdrmfb frame buffer device
usbcore: registered new interface driver udl
brd: module loaded
loop: module loaded
zram: Added device: zram0
null_blk: disk nullb0 created
null_blk: module loaded
Guest personality initialized and is inactive
VMCI host device registered (name=vmci, major=10, minor=118)
Initialized host personality
usbcore: registered new interface driver rtsx_usb
usbcore: registered new interface driver viperboard
usbcore: registered new interface driver dln2
usbcore: registered new interface driver pn533_usb
nfcsim 0.2 initialized
usbcore: registered new interface driver port100
usbcore: registered new interface driver nfcmrvl
Loading iSCSI transport class v2.0-870.
------------[ cut here ]------------
WARNING: CPU: 0 PID: 1 at kernel/workqueue.c:5925 workqueue_sysfs_register+0x32c/0x3f0 kernel/workqueue.c:5925
Modules linked in:
CPU: 0 PID: 1 Comm: swapper/0 Not tainted 6.4.0-rc1-next-20230509-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/14/2023
RIP: 0010:workqueue_sysfs_register+0x32c/0x3f0 kernel/workqueue.c:5925
Code: b8 00 00 00 00 00 fc ff df 48 c1 ea 03 80 3c 02 00 0f 85 ac 00 00 00 49 c7 84 24 18 01 00 00 00 00 00 00 eb b1 e8 a4 d4 2f 00 <0f> 0b 41 be ea ff ff ff eb a2 4c 89 ff e8 a2 d3 82 00 e9 9b fe ff
RSP: 0000:ffffc90000067910 EFLAGS: 00010293
RAX: 0000000000000000 RBX: 0000000000080000 RCX: 0000000000000000
RDX: ffff888140660000 RSI: ffffffff81546bac RDI: 0000000000000005
RBP: ffffc90000067a80 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000000080000 R11: 0000000000000000 R12: ffff88801f7ed800
R13: 0000000000000008 R14: ffff88801f7ed960 R15: ffff88801f7ed9c0
FS:  0000000000000000(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffff88823ffff000 CR3: 000000000c571000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 alloc_workqueue+0x637/0x1110 kernel/workqueue.c:4485
 scsi_host_alloc+0xd1f/0x11a0 drivers/scsi/hosts.c:513
 virtscsi_probe+0x206/0xc80 drivers/scsi/virtio_scsi.c:872
 virtio_dev_probe+0x57b/0x870 drivers/virtio/virtio.c:305
 call_driver_probe drivers/base/dd.c:579 [inline]
 really_probe+0x240/0xca0 drivers/base/dd.c:658
 __driver_probe_device+0x1df/0x4b0 drivers/base/dd.c:800
 driver_probe_device+0x4c/0x1a0 drivers/base/dd.c:830
 __driver_attach+0x271/0x570 drivers/base/dd.c:1216
 bus_for_each_dev+0x12a/0x1c0 drivers/base/bus.c:368
 bus_add_driver+0x2e9/0x640 drivers/base/bus.c:673
 driver_register+0x162/0x4a0 drivers/base/driver.c:246
 virtio_scsi_init+0x76/0x110 drivers/scsi/virtio_scsi.c:1019
 do_one_initcall+0x102/0x540 init/main.c:1246
 do_initcall_level init/main.c:1319 [inline]
 do_initcalls init/main.c:1335 [inline]
 do_basic_setup init/main.c:1354 [inline]
 kernel_init_freeable+0x5a4/0x890 init/main.c:1571
 kernel_init+0x1e/0x2c0 init/main.c:1462
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:308
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the bug is already fixed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want to change bug's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the bug is a duplicate of another bug, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup
