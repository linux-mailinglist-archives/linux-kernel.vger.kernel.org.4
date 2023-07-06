Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D770749507
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 07:36:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233263AbjGFFgJ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 6 Jul 2023 01:36:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232538AbjGFFgG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 01:36:06 -0400
Received: from mail-pf1-f207.google.com (mail-pf1-f207.google.com [209.85.210.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25F041BF7
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jul 2023 22:35:59 -0700 (PDT)
Received: by mail-pf1-f207.google.com with SMTP id d2e1a72fcca58-666e3dad70aso666361b3a.0
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jul 2023 22:35:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688621758; x=1691213758;
        h=content-transfer-encoding:to:from:subject:message-id:date
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=M8IG/7a1r+lbg72l7T26yvBl01awCMA71YiK77chGGY=;
        b=F+YsgGxqWOcPJ3fPHF3wOhKKAAFI2I5hugaBjF9NYvozaYplkRPAfDIIF/lceT0E/u
         vRcE58nIOKgyAtwbEF/Bw5REe5lYiKzsZ8h+HV7xoFzgAIoRxO/3D/LBaEjY0+KPXs6G
         V6mQZeMQ4sNsJL77lp4882cxO4ByKhdPouhIvnM1nx4/39J7eg2Xoab80Fg5iTj30yCR
         r/98GmcEquCLI2r8pGDZtMHCGFPcZ4hAJjRojuKCv6BU+xEZPAv8mCawvAlO33TkFqnQ
         clYiymHg6+6ISXKG+vx4bDAWMJzOilRk0xWAq9d88Rpz71iW6ZmgAoT2ZXQON5RwI1th
         oXcQ==
X-Gm-Message-State: ABy/qLaVb2C3kdbIZ+fcjnN1Dl9Uyq49C5pFv4Bh0Ry6J16gyyA75rgT
        e7V0taPG6NMdpvkwwGV+aZPRH4Rr/Z0OF841NAIfP/KP/6Iv
X-Google-Smtp-Source: APBJJlHZV14xswxelXjf2gNMVwi7ttbcjOZU6bY8KMzghjNPkZhZ4HCiV3TXsEZ54Vyvhpc7pg50NtR8npI/+S5dYgQVOThu6sJn
MIME-Version: 1.0
X-Received: by 2002:a05:6a00:2d16:b0:677:c9da:14b6 with SMTP id
 fa22-20020a056a002d1600b00677c9da14b6mr1140786pfb.4.1688621758557; Wed, 05
 Jul 2023 22:35:58 -0700 (PDT)
Date:   Wed, 05 Jul 2023 22:35:58 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000001432c105ffcae455@google.com>
Subject: [syzbot] [wireless?] WARNING in restore_regulatory_settings (2)
From:   syzbot <syzbot+dfe2fbeb4e710bbaddf9@syzkaller.appspotmail.com>
To:     axboe@kernel.dk, brauner@kernel.org, davem@davemloft.net,
        edumazet@google.com, hare@suse.de, hch@lst.de,
        johannes@sipsolutions.net, kuba@kernel.org,
        linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org, pabeni@redhat.com,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    6352a698ca5b Add linux-next specific files for 20230630
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=11f564a4a80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=39b764f3018462fe
dashboard link: https://syzkaller.appspot.com/bug?extid=dfe2fbeb4e710bbaddf9
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1640f4a0a80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11a10c40a80000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/55254daea013/disk-6352a698.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/cb343779c938/vmlinux-6352a698.xz
kernel image: https://storage.googleapis.com/syzbot-assets/3d451333dab6/bzImage-6352a698.xz

The issue was bisected to:

commit ae220766d87cd6799dbf918fea10613ae14c0654
Author: Christoph Hellwig <hch@lst.de>
Date:   Thu Jun 8 11:02:37 2023 +0000

    block: remove the unused mode argument to ->release

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1340a3f0a80000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=10c0a3f0a80000
console output: https://syzkaller.appspot.com/x/log.txt?x=1740a3f0a80000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+dfe2fbeb4e710bbaddf9@syzkaller.appspotmail.com
Fixes: ae220766d87c ("block: remove the unused mode argument to ->release")

------------[ cut here ]------------
Unexpected user alpha2: �I
WARNING: CPU: 0 PID: 9 at net/wireless/reg.c:438 is_user_regdom_saved net/wireless/reg.c:438 [inline]
WARNING: CPU: 0 PID: 9 at net/wireless/reg.c:438 restore_alpha2 net/wireless/reg.c:3399 [inline]
WARNING: CPU: 0 PID: 9 at net/wireless/reg.c:438 restore_regulatory_settings+0x210/0x1760 net/wireless/reg.c:3491
Modules linked in:
CPU: 0 PID: 9 Comm: kworker/0:1 Not tainted 6.4.0-next-20230630-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/27/2023
Workqueue: events_power_efficient crda_timeout_work
RIP: 0010:is_user_regdom_saved net/wireless/reg.c:438 [inline]
RIP: 0010:restore_alpha2 net/wireless/reg.c:3399 [inline]
RIP: 0010:restore_regulatory_settings+0x210/0x1760 net/wireless/reg.c:3491
Code: e6 03 44 89 f6 e8 50 d7 09 f8 45 84 f6 0f 85 7a 07 00 00 e8 62 db 09 f8 44 89 e2 44 89 ee 48 c7 c7 20 bc 9f 8b e8 c0 2b d1 f7 <0f> 0b e8 49 db 09 f8 48 8b 1d d2 80 f8 04 48 b8 00 00 00 00 00 fc
RSP: 0018:ffffc900000e7c30 EFLAGS: 00010282
RAX: 0000000000000000 RBX: 00000000000000bf RCX: 0000000000000000
RDX: ffff888016a68000 RSI: ffffffff814c65a7 RDI: 0000000000000001
RBP: 0000000000000001 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000001 R11: 0000000000000001 R12: 0000000000000049
R13: 00000000000000bf R14: 0000000000000000 R15: ffff8880b983bb80
FS:  0000000000000000(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020000140 CR3: 0000000073e5d000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 crda_timeout_work+0x28/0x50 net/wireless/reg.c:540
 process_one_work+0xa34/0x16f0 kernel/workqueue.c:2597
 worker_thread+0x67d/0x10c0 kernel/workqueue.c:2748
 kthread+0x344/0x440 kernel/kthread.c:389
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:308
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
For information about bisection process see: https://goo.gl/tpsmEJ#bisection

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
