Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0CDB708F2D
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 07:08:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230036AbjESFIF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 01:08:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbjESFIC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 01:08:02 -0400
Received: from mail-il1-f207.google.com (mail-il1-f207.google.com [209.85.166.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87FF319C
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 22:08:00 -0700 (PDT)
Received: by mail-il1-f207.google.com with SMTP id e9e14a558f8ab-3383a678225so41010955ab.3
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 22:08:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684472880; x=1687064880;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ov4QQm0JydaGMHrp1yxQSvuQlIX0EGiZNpxY1dyh4l0=;
        b=UVvNvIv3tz8WA+8KpwaefA5YEc/BTTfvvcVQLk71CeflmXctC+1c2maS3VSZcsWKFG
         2NsthxxAVfSBSpDZhFo+EBgyFS4nUn+BVXl9//1xYUt+k+yfBo0j2rxLFpKyn6CfErlL
         Im15+4WsV/wZkyU03RhpeANteVu88DI0BqXlHbeKmRjc0si2qe+tyA0gepgshoLAKE93
         SYS+D+R0749pfWfkmMF19BicjJ/hexZX3kivxghtcP4xvkIJeWK3XdE7xKB4PzS6lgU1
         VFlFVY7+WIq2cXQvKsY/Pyz0kVv5gJO/gkFCFWhtYVFNMphH556qjH5KITEiyh0bPdVf
         SONQ==
X-Gm-Message-State: AC+VfDwNqrEUaf+E1NSlOSW6YYGGp6HL+yioMiN7p13bP5qWQSU1tp3G
        NHXiUGpQ3VMKRMmwGjCsSigTw2Bu2QEAIX+d8C5GlvvSxY/D
X-Google-Smtp-Source: ACHHUZ7i8tN/1mj5L5+qYpan9qiUfcq3aScPX/LQzRW9caWeC8lx4Ok4VcEczUo8bbLyokSH16CcuGv659KheWsY23SaXptL9oO3
MIME-Version: 1.0
X-Received: by 2002:a92:dc89:0:b0:329:4c5e:15d8 with SMTP id
 c9-20020a92dc89000000b003294c5e15d8mr301567iln.2.1684472879932; Thu, 18 May
 2023 22:07:59 -0700 (PDT)
Date:   Thu, 18 May 2023 22:07:59 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a46bbe05fc04e756@google.com>
Subject: [syzbot] [mm?] linux-next boot error: WARNING: refcount bug in __reset_page_owner
From:   syzbot <syzbot+2a0e61ee9fcd4f7fd8ef@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-next@vger.kernel.org,
        sfr@canb.auug.org.au, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    dbd91ef4e91c Add linux-next specific files for 20230519
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=15dc2e41280000
kernel config:  https://syzkaller.appspot.com/x/.config?x=7c3f91bf21078a94
dashboard link: https://syzkaller.appspot.com/bug?extid=2a0e61ee9fcd4f7fd8ef
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/bf2a6fb63fa5/disk-dbd91ef4.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/3f60e95ad655/vmlinux-dbd91ef4.xz
kernel image: https://storage.googleapis.com/syzbot-assets/4097b8dec6a9/bzImage-dbd91ef4.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+2a0e61ee9fcd4f7fd8ef@syzkaller.appspotmail.com

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
refcount_t: decrement hit 0; leaking memory.
WARNING: CPU: 1 PID: 1 at lib/refcount.c:31 refcount_warn_saturate+0x1d7/0x1f0 lib/refcount.c:31
Modules linked in:
CPU: 1 PID: 1 Comm: swapper/0 Not tainted 6.4.0-rc2-next-20230519-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/28/2023
RIP: 0010:refcount_warn_saturate+0x1d7/0x1f0 lib/refcount.c:31
Code: 05 cd ec 5e 0a 01 e8 f8 0f 37 fd 0f 0b e9 d3 fe ff ff e8 dc 78 6f fd 48 c7 c7 a0 01 a7 8a c6 05 aa ec 5e 0a 01 e8 d9 0f 37 fd <0f> 0b e9 b4 fe ff ff 48 89 ef e8 ea 92 c2 fd e9 5c fe ff ff 0f 1f
RSP: 0000:ffffc900000673e0 EFLAGS: 00010282
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
RDX: ffff888014e48000 RSI: ffffffff814bd507 RDI: 0000000000000001
RBP: ffff888141b64e24 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000001 R12: 0000000000000001
R13: 0000000000000000 R14: dffffc0000000000 R15: 00000001fd845ca9
FS:  0000000000000000(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000000 CR3: 000000000c575000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 __reset_page_owner+0xf7/0x1c0 mm/page_owner.c:162
 reset_page_owner include/linux/page_owner.h:24 [inline]
 free_pages_prepare mm/page_alloc.c:1159 [inline]
 __free_pages_ok+0x690/0xf30 mm/page_alloc.c:1298
 make_alloc_exact+0x17f/0x260 mm/page_alloc.c:4753
 vring_alloc_queue drivers/virtio/virtio_ring.c:311 [inline]
 vring_alloc_queue+0x7f/0x110 drivers/virtio/virtio_ring.c:303
 vring_alloc_queue_split.part.0+0x16c/0x420 drivers/virtio/virtio_ring.c:1078
 vring_alloc_queue_split drivers/virtio/virtio_ring.c:1131 [inline]
 vring_create_virtqueue_split+0x139/0x2f0 drivers/virtio/virtio_ring.c:1128
 vring_create_virtqueue+0xdb/0x150 drivers/virtio/virtio_ring.c:2587
 setup_vq+0x111/0x2e0 drivers/virtio/virtio_pci_legacy.c:131
 vp_setup_vq+0xae/0x3b0 drivers/virtio/virtio_pci_common.c:189
 vp_find_vqs_msix+0x760/0xe90 drivers/virtio/virtio_pci_common.c:328
 vp_find_vqs+0x58/0x560 drivers/virtio/virtio_pci_common.c:405
 virtio_find_vqs include/linux/virtio_config.h:229 [inline]
 virtscsi_init+0x2e8/0x970 drivers/scsi/virtio_scsi.c:827
 virtscsi_probe+0x353/0xc80 drivers/scsi/virtio_scsi.c:884
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
 do_one_initcall+0x105/0x630 init/main.c:1239
 do_initcall_level init/main.c:1301 [inline]
 do_initcalls init/main.c:1317 [inline]
 do_basic_setup init/main.c:1336 [inline]
 kernel_init_freeable+0x5a4/0x890 init/main.c:1553
 kernel_init+0x1e/0x2c0 init/main.c:1444
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
