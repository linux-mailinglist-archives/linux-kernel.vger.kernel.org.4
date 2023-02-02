Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C2C668783E
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 10:06:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232273AbjBBJGv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 04:06:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231760AbjBBJGr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 04:06:47 -0500
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0232CF75E
        for <linux-kernel@vger.kernel.org>; Thu,  2 Feb 2023 01:06:45 -0800 (PST)
Received: by mail-il1-f200.google.com with SMTP id g5-20020a92d7c5000000b00310afb74005so874540ilq.11
        for <linux-kernel@vger.kernel.org>; Thu, 02 Feb 2023 01:06:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7BexTbuzCJcM40PhEyrA9kwTjm0ZWEgvvczrpWvtMrM=;
        b=gDgJDnHQZVBjOkDJdAaoheQR3dPz3DUeUApFOH9V9Ks0wDab5enzKoQboYhZejvnG+
         81vI0/EMEIWAClVeEa+OdnbUH+vMa+CdGucWTjmrI9RH+QoZcAl7ktwLBiQ+AkCmMIeg
         1hAnWUEUuSQYjwIArNj9yih9x/Te0b2vQFKEQFPvfpyd6HG+cxaN9FHGnsdnTpXglJBy
         sR3VpKLGDg9Hj36Rybi0VFFtV38lh/5P2vWuGrFKz8FTpS/FXUtMkawgODTvapuEX18h
         RPhMP1LjobE8eG9TDInHKaI8VOZWYVkCtRjGi9dTXvMgGVD1/V+9viUea+7jV8Myf3Ya
         3egA==
X-Gm-Message-State: AO0yUKXwYWF272/7gQ2ZUndpKXrOfR7U+8lsA+QpHBU3d8RicxcAi19R
        b8n73DLcMRkDu0vWAah4NgNeVDUaoyuBfRNxOr/5YDAetTpB
X-Google-Smtp-Source: AK7set/PyaiO/Q8bsEdXym6R0hcjEha7YpZGp5e0svpEFtW4eBa27teIjia89X481X5fkd0NAn/4lpwPAzwTw/2bDiy3S/nBGo4B
MIME-Version: 1.0
X-Received: by 2002:a5d:9b86:0:b0:71b:3f4f:95f9 with SMTP id
 r6-20020a5d9b86000000b0071b3f4f95f9mr1174877iom.30.1675328805274; Thu, 02 Feb
 2023 01:06:45 -0800 (PST)
Date:   Thu, 02 Feb 2023 01:06:45 -0800
In-Reply-To: <00000000000008f1d405f1999228@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000052099f05f3b3e298@google.com>
Subject: Re: [syzbot] WARNING in __usbnet_read_cmd/usb_submit_urb
From:   syzbot <syzbot+2a0e7abd24f1eb90ce25@syzkaller.appspotmail.com>
To:     gregkh@linuxfoundation.org, kuba@kernel.org,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        mailhol.vincent@wanadoo.fr, mkl@pengutronix.de, oneukum@suse.com,
        stern@rowland.harvard.edu, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has found a reproducer for the following issue on:

HEAD commit:    9f266ccaa2f5 Merge tag 'for_linus' of git://git.kernel.org..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=103b6ea5480000
kernel config:  https://syzkaller.appspot.com/x/.config?x=94f93727847d4d81
dashboard link: https://syzkaller.appspot.com/bug?extid=2a0e7abd24f1eb90ce25
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13c8afb3480000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14bebfb5480000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/710b69f64bd2/disk-9f266cca.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/f155d6966517/vmlinux-9f266cca.xz
kernel image: https://storage.googleapis.com/syzbot-assets/07672b7ba2df/bzImage-9f266cca.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+2a0e7abd24f1eb90ce25@syzkaller.appspotmail.com

------------[ cut here ]------------
usb 1-1: BOGUS control dir, pipe 80000280 doesn't match bRequestType c0
WARNING: CPU: 0 PID: 4645 at drivers/usb/core/urb.c:411 usb_submit_urb+0x14a7/0x1880 drivers/usb/core/urb.c:411
Modules linked in:
CPU: 1 PID: 4645 Comm: dhcpcd Not tainted 6.2.0-rc6-syzkaller-00050-g9f266ccaa2f5 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/12/2023
RIP: 0010:usb_submit_urb+0x14a7/0x1880 drivers/usb/core/urb.c:411
Code: 7c 24 40 e8 ab 4c 80 fb 48 8b 7c 24 40 e8 71 14 01 ff 45 89 e8 44 89 f1 4c 89 e2 48 89 c6 48 c7 c7 20 b0 fa 8a e8 d3 ab be 03 <0f> 0b e9 9f ee ff ff e8 7d 4c 80 fb 0f b6 1d 17 b2 5c 08 31 ff 41
RSP: 0018:ffffc9000355f5a0 EFLAGS: 00010282
RAX: 0000000000000000 RBX: ffff888017d2c058 RCX: 0000000000000000
RDX: ffff88801f901d40 RSI: ffffffff816680ec RDI: fffff520006abea6
RBP: ffff88801cc501e0 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000080000000 R11: 0000000000000000 R12: ffff888017a92d98
R13: 00000000000000c0 R14: 0000000080000280 R15: ffff888017a25200
FS:  00007f2a38e6d740(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f2f3dabf300 CR3: 0000000021a8d000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 usb_start_wait_urb+0x101/0x4b0 drivers/usb/core/message.c:58
 usb_internal_control_msg drivers/usb/core/message.c:102 [inline]
 usb_control_msg+0x320/0x4a0 drivers/usb/core/message.c:153
 __usbnet_read_cmd+0xb9/0x390 drivers/net/usb/usbnet.c:2010
 usbnet_read_cmd+0x96/0xf0 drivers/net/usb/usbnet.c:2068
 pl_vendor_req drivers/net/usb/plusb.c:60 [inline]
 pl_set_QuickLink_features drivers/net/usb/plusb.c:75 [inline]
 pl_reset+0x2f/0xf0 drivers/net/usb/plusb.c:85
 usbnet_open+0xcc/0x5d0 drivers/net/usb/usbnet.c:889
 __dev_open+0x297/0x4d0 net/core/dev.c:1417
 __dev_change_flags+0x587/0x750 net/core/dev.c:8530
 dev_change_flags+0x97/0x170 net/core/dev.c:8602
 devinet_ioctl+0x15a2/0x1d70 net/ipv4/devinet.c:1147
 inet_ioctl+0x33f/0x380 net/ipv4/af_inet.c:979
 sock_do_ioctl+0xcc/0x230 net/socket.c:1169
 sock_ioctl+0x1f8/0x680 net/socket.c:1286
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:870 [inline]
 __se_sys_ioctl fs/ioctl.c:856 [inline]
 __x64_sys_ioctl+0x197/0x210 fs/ioctl.c:856
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f2a38f5b0e7
Code: 3c 1c e8 1c ff ff ff 85 c0 79 87 49 c7 c4 ff ff ff ff 5b 5d 4c 89 e0 41 5c c3 66 0f 1f 84 00 00 00 00 00 b8 10 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 61 9d 0c 00 f7 d8 64 89 01 48
RSP: 002b:00007ffd77152e38 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f2a38e6d6c8 RCX: 00007f2a38f5b0e7
RDX: 00007ffd77163028 RSI: 0000000000008914 RDI: 0000000000000018
RBP: 00007ffd771731d8 R08: 00007ffd77162fe8 R09: 00007ffd77162f98
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007ffd77163028 R14: 0000000000000028 R15: 0000000000008914
 </TASK>

