Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DCE26F2590
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Apr 2023 20:09:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229668AbjD2SJm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Apr 2023 14:09:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229648AbjD2SJl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Apr 2023 14:09:41 -0400
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 1D5231701
        for <linux-kernel@vger.kernel.org>; Sat, 29 Apr 2023 11:09:37 -0700 (PDT)
Received: (qmail 245150 invoked by uid 1000); 29 Apr 2023 14:09:36 -0400
Date:   Sat, 29 Apr 2023 14:09:36 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     syzbot <syzbot+a3f758b8d8cb7e49afec@syzkaller.appspotmail.com>,
        dmitry.torokhov@gmail.com
Cc:     chaorace@gmail.com, dan.carpenter@linaro.org, dzm91@hust.edu.cn,
        error27@gmail.com, gregkh@linuxfoundation.org,
        hust-os-kernel-patches@googlegroups.com,
        kernel-janitors@vger.kernel.org, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        matthias.benkmann@gmail.com, mkorpershoek@baylibre.com,
        mudongliangabcd@gmail.com, nate@yocom.org,
        pgriffais@valvesoftware.com, radon86dev@gmail.com,
        rafael@kernel.org, rojtberg@gmail.com, s.demassari@gmail.com,
        syzkaller-bugs@googlegroups.com, vi@endrift.com
Subject: Re: [syzbot] [usb?] general protection fault in xpad_probe
Message-ID: <606e7f3a-8ad5-43b3-b3c9-e75aa0180e8a@rowland.harvard.edu>
References: <00000000000083d76d05f909f716@google.com>
 <0000000000007c3e1f05fa79d594@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0000000000007c3e1f05fa79d594@google.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dmitry:

On Sat, Apr 29, 2023 at 06:47:43AM -0700, syzbot wrote:
> syzbot has found a reproducer for the following issue on:
> 
> HEAD commit:    92e815cf07ed Add linux-next specific files for 20230428
> git tree:       linux-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=104cb844280000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=c8c8ae4d47d23592
> dashboard link: https://syzkaller.appspot.com/bug?extid=a3f758b8d8cb7e49afec
> compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14a5408c280000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10d3b0e4280000
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/c9e94856e6c9/disk-92e815cf.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/4c1c05a548a7/vmlinux-92e815cf.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/2a1bff6a133b/bzImage-92e815cf.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+a3f758b8d8cb7e49afec@syzkaller.appspotmail.com
> 
> usb 1-1: config 0 has no interface number 0
> usb 1-1: New USB device found, idVendor=1949, idProduct=5e70, bcdDevice=d7.a2
> usb 1-1: New USB device strings: Mfr=0, Product=0, SerialNumber=0
> usb 1-1: config 0 descriptor??
> usb 1-1: string descriptor 0 read error: -71
> general protection fault, probably for non-canonical address 0xdffffc0000000068: 0000 [#1] PREEMPT SMP KASAN
> KASAN: null-ptr-deref in range [0x0000000000000340-0x0000000000000347]
> CPU: 0 PID: 9 Comm: kworker/0:1 Not tainted 6.3.0-next-20230428-syzkaller #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/14/2023
> Workqueue: usb_hub_wq hub_event
> RIP: 0010:dev_name include/linux/device.h:706 [inline]
> RIP: 0010:__dev_printk+0x3b/0x270 drivers/base/core.c:4863
> Code: f5 53 e8 c8 c3 6b fc 48 85 ed 0f 84 cb 01 00 00 e8 ba c3 6b fc 48 8d 7d 50 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 <80> 3c 02 00 0f 85 d7 01 00 00 48 8b 5d 50 48 85 db 0f 84 b5 00 00
> RSP: 0018:ffffc900000e6f70 EFLAGS: 00010202
> RAX: dffffc0000000000 RBX: fffff5200001cdf5 RCX: 0000000000000000
> RDX: 0000000000000068 RSI: ffffffff85188a06 RDI: 0000000000000340
> RBP: 00000000000002f0 R08: 0000000000000005 R09: 0000000000000000
> R10: 00000000ffffffb9 R11: ffffffff81d6ff05 R12: ffffffff8ace98e0
> R13: ffffc900000e6fc8 R14: ffff88801ed25a64 R15: 0000000000000000
> FS:  0000000000000000(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007f1361dc1111 CR3: 00000000210fe000 CR4: 00000000003506f0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  <TASK>
>  _dev_warn+0xdc/0x120 drivers/base/core.c:4907
>  xpad_probe+0x197e/0x2020 drivers/input/joystick/xpad.c:2053
>  usb_probe_interface+0x30f/0x960 drivers/usb/core/driver.c:396

It looks like the problem is caused by commit db7220c48d8d ("Input: 
xpad - fix support for some third-party controllers").  In the line

			dev_warn(&xpad->dev->dev,

the xpad->dev ought to be xpad->udev.

Alan Stern
