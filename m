Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17C726F32B7
	for <lists+linux-kernel@lfdr.de>; Mon,  1 May 2023 17:19:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232711AbjEAPTe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 May 2023 11:19:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232376AbjEAPTc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 May 2023 11:19:32 -0400
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id C464F9D
        for <linux-kernel@vger.kernel.org>; Mon,  1 May 2023 08:19:29 -0700 (PDT)
Received: (qmail 304556 invoked by uid 1000); 1 May 2023 11:19:29 -0400
Date:   Mon, 1 May 2023 11:19:29 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     syzbot <syzbot+ce77725b89b7bd52425c@syzkaller.appspotmail.com>
Cc:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [usb?] WARNING in usbtmc_ioctl/usb_submit_urb (2)
Message-ID: <38c0a2fd-cd9c-43b3-99f0-4f9ed2fdc69f@rowland.harvard.edu>
References: <000000000000716a3705f9adb8ee@google.com>
 <00000000000082cdb705faa08ffb@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <00000000000082cdb705faa08ffb@google.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 01, 2023 at 04:59:52AM -0700, syzbot wrote:
> syzbot has found a reproducer for the following issue on:
> 
> HEAD commit:    58390c8ce1bd Merge tag 'iommu-updates-v6.4' of git://git.k..
> git tree:       upstream
> console+strace: https://syzkaller.appspot.com/x/log.txt?x=17d08158280000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=d56ffc213bf6bf4a
> dashboard link: https://syzkaller.appspot.com/bug?extid=ce77725b89b7bd52425c
> compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15027ef7c80000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16d7550c280000
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/51c43e265c8a/disk-58390c8c.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/7c64f4eeaf4d/vmlinux-58390c8c.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/e5d8f49c4804/bzImage-58390c8c.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+ce77725b89b7bd52425c@syzkaller.appspotmail.com
> 
> ------------[ cut here ]------------
> usb 3-1: BOGUS control dir, pipe 80000b80 doesn't match bRequestType fd
> WARNING: CPU: 0 PID: 5100 at drivers/usb/core/urb.c:411 usb_submit_urb+0x14a7/0x1880 drivers/usb/core/urb.c:411
> Modules linked in:
> CPU: 0 PID: 5100 Comm: syz-executor428 Not tainted 6.3.0-syzkaller-12049-g58390c8ce1bd #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/14/2023
> RIP: 0010:usb_submit_urb+0x14a7/0x1880 drivers/usb/core/urb.c:411
> Code: 7c 24 40 e8 1b 13 5c fb 48 8b 7c 24 40 e8 21 1d f0 fe 45 89 e8 44 89 f1 4c 89 e2 48 89 c6 48 c7 c7 e0 b5 fc 8a e8 19 c8 23 fb <0f> 0b e9 9f ee ff ff e8 ed 12 5c fb 0f b6 1d 12 8a 3c 08 31 ff 41
> RSP: 0018:ffffc90003d2fb00 EFLAGS: 00010282
> RAX: 0000000000000000 RBX: ffff8880789e9058 RCX: 0000000000000000
> RDX: ffff888029593b80 RSI: ffffffff814c1447 RDI: 0000000000000001
> RBP: ffff88801ea742f8 R08: 0000000000000001 R09: 0000000000000000
> R10: 0000000000000001 R11: 0000000000000001 R12: ffff88802915e528
> R13: 00000000000000fd R14: 0000000080000b80 R15: ffff8880222b3100
> FS:  0000555556ca63c0(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007f9ef4d18150 CR3: 0000000073e5b000 CR4: 00000000003506f0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  <TASK>
>  usb_start_wait_urb+0x101/0x4b0 drivers/usb/core/message.c:58
>  usb_internal_control_msg drivers/usb/core/message.c:102 [inline]
>  usb_control_msg+0x320/0x4a0 drivers/usb/core/message.c:153
>  usbtmc_ioctl_request drivers/usb/class/usbtmc.c:1954 [inline]
>  usbtmc_ioctl+0x1b3d/0x2840 drivers/usb/class/usbtmc.c:2097
>  vfs_ioctl fs/ioctl.c:51 [inline]
>  __do_sys_ioctl fs/ioctl.c:870 [inline]
>  __se_sys_ioctl fs/ioctl.c:856 [inline]
>  __x64_sys_ioctl+0x197/0x210 fs/ioctl.c:856
>  do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>  do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
>  entry_SYSCALL_64_after_hwframe+0x63/0xcd
> RIP: 0033:0x7f9ef4ca4e49
> Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 41 15 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007fff8d0be0d8 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
> RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 00007f9ef4ca4e49
> RDX: 0000000020000040 RSI: 00000000c0105b08 RDI: 0000000000000004
> RBP: 0000000000000000 R08: 000000000000000f R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000015f73
> R13: 00007fff8d0be160 R14: 00007fff8d0be150 R15: 00007fff8d0be11c
>  </TASK>
> 
> 
> ---
> If you want syzbot to run the reproducer, reply with:
> #syz test: git://repo/address.git branch-or-commit-hash
> If you attach or paste a git patch, syzbot will apply it before testing.

usbtmc needs to check whether the user got the direction wrong for 
0-length control transfers.

Alan Stern

#syz test: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/ 58390c8ce1bd

Index: usb-devel/drivers/usb/class/usbtmc.c
===================================================================
--- usb-devel.orig/drivers/usb/class/usbtmc.c
+++ usb-devel/drivers/usb/class/usbtmc.c
@@ -1928,6 +1928,8 @@ static int usbtmc_ioctl_request(struct u
 
 	if (request.req.wLength > USBTMC_BUFSIZE)
 		return -EMSGSIZE;
+	if (request.req.wLength == 0)	/* Length-0 requests are never IN */
+		request.req.bRequestType &= ~USB_DIR_IN;
 
 	is_in = request.req.bRequestType & USB_DIR_IN;
 
