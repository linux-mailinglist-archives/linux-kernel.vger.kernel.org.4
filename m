Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22EE3744E46
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jul 2023 17:16:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229848AbjGBPQD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Jul 2023 11:16:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229808AbjGBPQA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jul 2023 11:16:00 -0400
Received: from mail-pl1-f205.google.com (mail-pl1-f205.google.com [209.85.214.205])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6179E69
        for <linux-kernel@vger.kernel.org>; Sun,  2 Jul 2023 08:15:58 -0700 (PDT)
Received: by mail-pl1-f205.google.com with SMTP id d9443c01a7336-1b8959fb3c7so2462165ad.0
        for <linux-kernel@vger.kernel.org>; Sun, 02 Jul 2023 08:15:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688310958; x=1690902958;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Uqx05DsOQphTiupSJnXSJDQY0vj7xZsIgdvTNkwdc4I=;
        b=hJrczI7TRE22C8DE0Kckxd62rU5bFcmOQ/hO3fECzTVJIpfZtedcn8FDTvK6/cxM3E
         UUcpAdBnijkoKtMyZ6WLeiO2tttGTCVwTODNDVNzzsLxSsqfLLLe23iNdkKW0mW+DuKY
         FhYXZOQRs6En7r9vu2k778iLSZIKO1APd9rclk0u/8AYSHSDcCrG11uoCdDEzTH1l+i5
         8CTpNWo+Giv7Zny8CI+/TsGTfdbLSozus4k+6EtM7yvKvT8kCVDZCuLLgtH+djhFj/Rj
         X6LlGNGjtqk+Sl4x1iAX2W+T1XX0eT+Y1qwNN3uPcdTZ8hmm0DskpktWdkp0kws9RJag
         jEOA==
X-Gm-Message-State: ABy/qLYMdBHSYxhXb1PJUT+zfBVwjWkFJjPsfFy9TdFzxmux9NC0i39r
        aoAZNtDgHPyoDwZSG9fKBlT34mUEcDDRzxPAqgG3q8xhfj8Z
X-Google-Smtp-Source: APBJJlGq9lPKarcsUF7brIRq5xJr+f1dOKBFojk/wn5gzcGstP+bS9/Z+X3ogEpttE7OoTGn0J2Nzuo+izXpAWX/Up0fjn2Y/sb+
MIME-Version: 1.0
X-Received: by 2002:a17:902:e847:b0:1b8:919e:bd with SMTP id
 t7-20020a170902e84700b001b8919e00bdmr1177364plg.13.1688310958243; Sun, 02 Jul
 2023 08:15:58 -0700 (PDT)
Date:   Sun, 02 Jul 2023 08:15:58 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000efc64705ff8286a1@google.com>
Subject: [syzbot] [wireless?] WARNING in rate_control_rate_init (2)
From:   syzbot <syzbot+62d7eef57b09bfebcd84@syzkaller.appspotmail.com>
To:     davem@davemloft.net, edumazet@google.com,
        johannes@sipsolutions.net, kuba@kernel.org,
        linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
        llvm@lists.linux.dev, nathan@kernel.org, ndesaulniers@google.com,
        netdev@vger.kernel.org, pabeni@redhat.com,
        syzkaller-bugs@googlegroups.com, trix@redhat.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    6e2332e0ab53 Merge tag 'cgroup-for-6.5' of git://git.kerne..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=16e1c60b280000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b8f24c1070268858
dashboard link: https://syzkaller.appspot.com/bug?extid=62d7eef57b09bfebcd84
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=171c0767280000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10113ebd280000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7bc7510fe41f/non_bootable_disk-6e2332e0.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/5c6bc163c340/vmlinux-6e2332e0.xz
kernel image: https://storage.googleapis.com/syzbot-assets/f1e705993336/bzImage-6e2332e0.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+62d7eef57b09bfebcd84@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 0 PID: 5126 at net/mac80211/rate.c:48 rate_control_rate_init+0x548/0x740 net/mac80211/rate.c:48
Modules linked in:
CPU: 0 PID: 5126 Comm: syz-executor279 Not tainted 6.4.0-syzkaller-01647-g6e2332e0ab53 #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.14.0-2 04/01/2014
RIP: 0010:rate_control_rate_init+0x548/0x740 net/mac80211/rate.c:48
Code: f7 48 c7 c2 00 84 7f 8b be 09 03 00 00 48 c7 c7 c0 83 7f 8b c6 05 f9 bc d6 04 01 e8 22 ac d6 f7 e9 d8 fd ff ff e8 a8 16 f6 f7 <0f> 0b e8 c1 32 83 00 31 ff 89 c3 89 c6 e8 b6 12 f6 f7 85 db 75 27
RSP: 0018:ffffc90003197280 EFLAGS: 00010293
RAX: 0000000000000000 RBX: ffff8881070796c0 RCX: 0000000000000000
RDX: ffff88802a51cb80 RSI: ffffffff898db228 RDI: 0000000000000005
RBP: ffff8880255c0000 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000000000001 R11: 0000000000000001 R12: 0000000000000001
R13: 0000000000000000 R14: ffff888021f30de0 R15: ffff888032530000
FS:  000055555570f300(0000) GS:ffff88806b600000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020000080 CR3: 000000001f594000 CR4: 0000000000350ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 sta_apply_auth_flags.constprop.0+0x424/0x4a0 net/mac80211/cfg.c:1678
 sta_apply_parameters+0xaf8/0x16f0 net/mac80211/cfg.c:2005
 ieee80211_add_station+0x3d0/0x620 net/mac80211/cfg.c:2070
 rdev_add_station net/wireless/rdev-ops.h:201 [inline]
 nl80211_new_station+0x1258/0x1b20 net/wireless/nl80211.c:7564
 genl_family_rcv_msg_doit.isra.0+0x1e6/0x2d0 net/netlink/genetlink.c:968
 genl_family_rcv_msg net/netlink/genetlink.c:1048 [inline]
 genl_rcv_msg+0x4ff/0x7e0 net/netlink/genetlink.c:1065
 netlink_rcv_skb+0x165/0x440 net/netlink/af_netlink.c:2546
 genl_rcv+0x28/0x40 net/netlink/genetlink.c:1076
 netlink_unicast_kernel net/netlink/af_netlink.c:1339 [inline]
 netlink_unicast+0x547/0x7f0 net/netlink/af_netlink.c:1365
 netlink_sendmsg+0x925/0xe30 net/netlink/af_netlink.c:1913
 sock_sendmsg_nosec net/socket.c:725 [inline]
 sock_sendmsg+0xde/0x190 net/socket.c:748
 ____sys_sendmsg+0x722/0x900 net/socket.c:2504
 ___sys_sendmsg+0x110/0x1b0 net/socket.c:2558
 __sys_sendmsg+0xf7/0x1c0 net/socket.c:2587
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7fc033504a69
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 e1 14 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffe0868f2d8 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 000000000000ae5a RCX: 00007fc033504a69
RDX: 0000000000000000 RSI: 0000000020000280 RDI: 0000000000000004
RBP: 0000000000000000 R08: 00007ffe0868f478 R09: 00007ffe0868f478
R10: 0000000000000000 R11: 0000000000000246 R12: 00007ffe0868f2ec
R13: 431bde82d7b634db R14: 0000000000000000 R15: 0000000000000000
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the bug is already fixed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

If you want to change bug's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the bug is a duplicate of another bug, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup
