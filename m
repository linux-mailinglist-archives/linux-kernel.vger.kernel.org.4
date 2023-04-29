Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 553136F24F0
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Apr 2023 15:47:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231297AbjD2Nrs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Apr 2023 09:47:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231288AbjD2Nrq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Apr 2023 09:47:46 -0400
Received: from mail-il1-f208.google.com (mail-il1-f208.google.com [209.85.166.208])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE20619A3
        for <linux-kernel@vger.kernel.org>; Sat, 29 Apr 2023 06:47:43 -0700 (PDT)
Received: by mail-il1-f208.google.com with SMTP id e9e14a558f8ab-32a86b6ab85so4362565ab.3
        for <linux-kernel@vger.kernel.org>; Sat, 29 Apr 2023 06:47:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682776063; x=1685368063;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sJBbSPNx33O3Uic3H5MvMN9TsVhJ4u9iqfXiFHPsAdM=;
        b=aF7Nuxm97KoRVOh2SHhNsVXjyoz19NMfMCBbUJWfwNQwgnxiAclE8MagBPYOZZzhcN
         jJUVeyrbkPlLk2Pm36NEa2iMRjMRYsTVBOgC+wfNZtium0/ojdJ3E41JG5YKQMaZVspG
         TJO7j5J3tY3bRP0Bvllvs1QiCnxlNrnhmOXT0fEnbtLgbF6pvhB5yd+RvTfECXyqD3z/
         xA0TrrImXlhN4phMkNxzittdMcWyttn0kjLtYYF1iLjCsU2XqVK+4hx/KFsyTDEVWaox
         /kgL7fOMYUov/KV8KhjN5tVucRrOi/RFvgVBerZCwoVUEVwbC+o0FYF5Ke0qv0lJqg2H
         0FGQ==
X-Gm-Message-State: AC+VfDwEOiuE49DAVsgxPLFt7NHW8BTlEqee0cMVkYRIFKP0/QECOOIZ
        bhYCmNLPtGOyYwMl/oEe91tq/2GvvA0tyWAJSud/PIqXQY27
X-Google-Smtp-Source: ACHHUZ6NrAij3mdCxRTCsmmtSLAFpBUg1S40oGpD56jfCLH3ICqiTN+yRX8KpM01UvB32tDIGixdQO14FzvUNrhq519S4Gj0iyLs
MIME-Version: 1.0
X-Received: by 2002:a92:d448:0:b0:32b:4584:7316 with SMTP id
 r8-20020a92d448000000b0032b45847316mr4656801ilm.3.1682776063227; Sat, 29 Apr
 2023 06:47:43 -0700 (PDT)
Date:   Sat, 29 Apr 2023 06:47:43 -0700
In-Reply-To: <00000000000083d76d05f909f716@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000007c3e1f05fa79d594@google.com>
Subject: Re: [syzbot] [usb?] general protection fault in xpad_probe
From:   syzbot <syzbot+a3f758b8d8cb7e49afec@syzkaller.appspotmail.com>
To:     chaorace@gmail.com, dan.carpenter@linaro.org,
        dmitry.torokhov@gmail.com, dzm91@hust.edu.cn, error27@gmail.com,
        gregkh@linuxfoundation.org,
        hust-os-kernel-patches@googlegroups.com,
        kernel-janitors@vger.kernel.org, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        matthias.benkmann@gmail.com, mkorpershoek@baylibre.com,
        mudongliangabcd@gmail.com, nate@yocom.org,
        pgriffais@valvesoftware.com, radon86dev@gmail.com,
        rafael@kernel.org, rojtberg@gmail.com, s.demassari@gmail.com,
        syzkaller-bugs@googlegroups.com, vi@endrift.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SORTED_RECIPS,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has found a reproducer for the following issue on:

HEAD commit:    92e815cf07ed Add linux-next specific files for 20230428
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=104cb844280000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c8c8ae4d47d23592
dashboard link: https://syzkaller.appspot.com/bug?extid=a3f758b8d8cb7e49afec
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14a5408c280000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10d3b0e4280000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/c9e94856e6c9/disk-92e815cf.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/4c1c05a548a7/vmlinux-92e815cf.xz
kernel image: https://storage.googleapis.com/syzbot-assets/2a1bff6a133b/bzImage-92e815cf.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+a3f758b8d8cb7e49afec@syzkaller.appspotmail.com

usb 1-1: config 0 has no interface number 0
usb 1-1: New USB device found, idVendor=1949, idProduct=5e70, bcdDevice=d7.a2
usb 1-1: New USB device strings: Mfr=0, Product=0, SerialNumber=0
usb 1-1: config 0 descriptor??
usb 1-1: string descriptor 0 read error: -71
general protection fault, probably for non-canonical address 0xdffffc0000000068: 0000 [#1] PREEMPT SMP KASAN
KASAN: null-ptr-deref in range [0x0000000000000340-0x0000000000000347]
CPU: 0 PID: 9 Comm: kworker/0:1 Not tainted 6.3.0-next-20230428-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/14/2023
Workqueue: usb_hub_wq hub_event
RIP: 0010:dev_name include/linux/device.h:706 [inline]
RIP: 0010:__dev_printk+0x3b/0x270 drivers/base/core.c:4863
Code: f5 53 e8 c8 c3 6b fc 48 85 ed 0f 84 cb 01 00 00 e8 ba c3 6b fc 48 8d 7d 50 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 <80> 3c 02 00 0f 85 d7 01 00 00 48 8b 5d 50 48 85 db 0f 84 b5 00 00
RSP: 0018:ffffc900000e6f70 EFLAGS: 00010202
RAX: dffffc0000000000 RBX: fffff5200001cdf5 RCX: 0000000000000000
RDX: 0000000000000068 RSI: ffffffff85188a06 RDI: 0000000000000340
RBP: 00000000000002f0 R08: 0000000000000005 R09: 0000000000000000
R10: 00000000ffffffb9 R11: ffffffff81d6ff05 R12: ffffffff8ace98e0
R13: ffffc900000e6fc8 R14: ffff88801ed25a64 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f1361dc1111 CR3: 00000000210fe000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 _dev_warn+0xdc/0x120 drivers/base/core.c:4907
 xpad_probe+0x197e/0x2020 drivers/input/joystick/xpad.c:2053
 usb_probe_interface+0x30f/0x960 drivers/usb/core/driver.c:396
 call_driver_probe drivers/base/dd.c:579 [inline]
 really_probe+0x240/0xca0 drivers/base/dd.c:658
 __driver_probe_device+0x1df/0x4b0 drivers/base/dd.c:800
 driver_probe_device+0x4c/0x1a0 drivers/base/dd.c:830
 __device_attach_driver+0x1d4/0x2e0 drivers/base/dd.c:958
 bus_for_each_drv+0x149/0x1d0 drivers/base/bus.c:457
 __device_attach+0x1e4/0x4b0 drivers/base/dd.c:1030
 bus_probe_device+0x17c/0x1c0 drivers/base/bus.c:532
 device_add+0x112d/0x1a40 drivers/base/core.c:3625
 usb_set_configuration+0x1196/0x1bc0 drivers/usb/core/message.c:2211
 usb_generic_driver_probe+0xcf/0x130 drivers/usb/core/generic.c:238
 usb_probe_device+0xd8/0x2c0 drivers/usb/core/driver.c:293
 call_driver_probe drivers/base/dd.c:579 [inline]
 really_probe+0x240/0xca0 drivers/base/dd.c:658
 __driver_probe_device+0x1df/0x4b0 drivers/base/dd.c:800
 driver_probe_device+0x4c/0x1a0 drivers/base/dd.c:830
 __device_attach_driver+0x1d4/0x2e0 drivers/base/dd.c:958
 bus_for_each_drv+0x149/0x1d0 drivers/base/bus.c:457
 __device_attach+0x1e4/0x4b0 drivers/base/dd.c:1030
 bus_probe_device+0x17c/0x1c0 drivers/base/bus.c:532
 device_add+0x112d/0x1a40 drivers/base/core.c:3625
 usb_new_device+0xcb2/0x19d0 drivers/usb/core/hub.c:2575
 hub_port_connect drivers/usb/core/hub.c:5407 [inline]
 hub_port_connect_change drivers/usb/core/hub.c:5551 [inline]
 port_event drivers/usb/core/hub.c:5711 [inline]
 hub_event+0x2d9e/0x4e40 drivers/usb/core/hub.c:5793
 process_one_work+0x99a/0x15e0 kernel/workqueue.c:2405
 worker_thread+0x67d/0x10c0 kernel/workqueue.c:2552
 kthread+0x344/0x440 kernel/kthread.c:379
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:308
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:dev_name include/linux/device.h:706 [inline]
RIP: 0010:__dev_printk+0x3b/0x270 drivers/base/core.c:4863
Code: f5 53 e8 c8 c3 6b fc 48 85 ed 0f 84 cb 01 00 00 e8 ba c3 6b fc 48 8d 7d 50 48 b8 00 00 00 00 00 fc ff df 48 89
----------------
Code disassembly (best guess):
   0:	f5                   	cmc
   1:	53                   	push   %rbx
   2:	e8 c8 c3 6b fc       	callq  0xfc6bc3cf
   7:	48 85 ed             	test   %rbp,%rbp
   a:	0f 84 cb 01 00 00    	je     0x1db
  10:	e8 ba c3 6b fc       	callq  0xfc6bc3cf
  15:	48 8d 7d 50          	lea    0x50(%rbp),%rdi
  19:	48 b8 00 00 00 00 00 	movabs $0xdffffc0000000000,%rax
  20:	fc ff df
  23:	48 89 fa             	mov    %rdi,%rdx
  26:	48 c1 ea 03          	shr    $0x3,%rdx
* 2a:	80 3c 02 00          	cmpb   $0x0,(%rdx,%rax,1) <-- trapping instruction
  2e:	0f 85 d7 01 00 00    	jne    0x20b
  34:	48 8b 5d 50          	mov    0x50(%rbp),%rbx
  38:	48 85 db             	test   %rbx,%rbx
  3b:	0f                   	.byte 0xf
  3c:	84                   	.byte 0x84
  3d:	b5 00                	mov    $0x0,%ch


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.
