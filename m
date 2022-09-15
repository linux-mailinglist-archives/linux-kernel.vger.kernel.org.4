Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 823015B920D
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 03:17:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229562AbiIOBRi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 21:17:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbiIOBRf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 21:17:35 -0400
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C46FD8B9B9
        for <linux-kernel@vger.kernel.org>; Wed, 14 Sep 2022 18:17:33 -0700 (PDT)
Received: by mail-io1-f72.google.com with SMTP id e4-20020a5d85c4000000b0068bb3c11e72so9883979ios.5
        for <linux-kernel@vger.kernel.org>; Wed, 14 Sep 2022 18:17:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date;
        bh=Scr9jBcKRqCpRy9j3Cd8BIVPcViR5mnf4BfHjCpxE3E=;
        b=H1XWQkU0Ck4EuHAx1W1TrpABDTNClvg4cMFUeTINxDbx+LTQZWu0mABwrEYwsTPtFq
         Xqy+dD8iXK+tV7yZ+Xjamsa7YTrMljgSs2iQVOC8UFDAmOZ75l6RTT5AlkRzGZz/gW7h
         mRCibL2kfeaMe+DKAIQdFRpYoDreGFXORCwZ1srjW209kipcn7t6j3z2ajiB8gAr+7qj
         Hp22YUDXB12UvgA8iZHPiuaOEpvjov3OEqNnxUjn1oKb1sUYiIRYNQiSUM5A8/ZKzYE1
         NiA3+S3xsg1kjeyRBGZeIgw4a3Z1utd+Remcr96zVoA0C6lu0dOqDwt/flWnoRTEAVaM
         l/KA==
X-Gm-Message-State: ACgBeo1TmcfQw2kaLBf9qxUKCIYPvtQh7n8AviE6n3oe7IinRQZnuAR6
        JF5ENUjZ5uvS69/AkLPq80BGgtbAKJZPOx3UFqqj2uwL1MAp
X-Google-Smtp-Source: AA6agR4D9NBZfuCORuhqy4BIYUdmpRjrCbp2Yc6iGuSHf6p4zvcW9axe9YyyKyLEsEuREPQ7DNfbMhL4fkIPLrMRCDEEkwGYL3gV
MIME-Version: 1.0
X-Received: by 2002:a05:6638:40a3:b0:35a:3f2d:a21c with SMTP id
 m35-20020a05663840a300b0035a3f2da21cmr8095440jam.221.1663204653166; Wed, 14
 Sep 2022 18:17:33 -0700 (PDT)
Date:   Wed, 14 Sep 2022 18:17:33 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000008a7a3f05e8ad02f6@google.com>
Subject: [syzbot] BUG: corrupted list in kobject_add_internal (4)
From:   syzbot <syzbot+e653e3f67251b6139aaa@syzkaller.appspotmail.com>
To:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        rafael@kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    b96fbd602d35 Merge tag 's390-6.0-4' of git://git.kernel.or..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=1226a500880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c79df237bd9a0448
dashboard link: https://syzkaller.appspot.com/bug?extid=e653e3f67251b6139aaa
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10f618e8880000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1090704f080000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+e653e3f67251b6139aaa@syzkaller.appspotmail.com

list_add double add: new=ffff88807cd08540, prev=ffff88807cd08540, next=ffff888144a30000.
------------[ cut here ]------------
kernel BUG at lib/list_debug.c:33!
invalid opcode: 0000 [#1] PREEMPT SMP KASAN
CPU: 0 PID: 3610 Comm: kworker/u5:2 Not tainted 6.0.0-rc4-syzkaller-00302-gb96fbd602d35 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/26/2022
Workqueue: hci0 hci_rx_work
RIP: 0010:__list_add_valid.cold+0x42/0x58 lib/list_debug.c:33
Code: e8 73 f6 f0 ff 0f 0b 48 c7 c7 40 f9 48 8a e8 65 f6 f0 ff 0f 0b 48 89 f2 4c 89 e1 48 89 ee 48 c7 c7 40 fb 48 8a e8 4e f6 f0 ff <0f> 0b 48 89 f1 48 c7 c7 c0 fa 48 8a 4c 89 e6 e8 3a f6 f0 ff 0f 0b
RSP: 0018:ffffc9000398f800 EFLAGS: 00010282
RAX: 0000000000000058 RBX: ffff8880216bd298 RCX: 0000000000000000
RDX: ffff888076949d80 RSI: ffffffff8161f408 RDI: fffff52000731ef2
RBP: ffff88807cd08540 R08: 0000000000000058 R09: 0000000000000000
R10: 0000000080000001 R11: 0000000000000000 R12: ffff888144a30000
R13: ffff88807cd08550 R14: ffff88807cd08558 R15: ffff88807cd08540
FS:  0000000000000000(0000) GS:ffff8880b9a00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020000000 CR3: 0000000078c49000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 __list_add include/linux/list.h:69 [inline]
 list_add_tail include/linux/list.h:102 [inline]
 kobj_kset_join lib/kobject.c:164 [inline]
 kobject_add_internal+0x18f/0x8f0 lib/kobject.c:214
 kobject_add_varg lib/kobject.c:358 [inline]
 kobject_add+0x150/0x1c0 lib/kobject.c:410
 device_add+0x368/0x1e90 drivers/base/core.c:3452
 hci_conn_add_sysfs+0x9b/0x1b0 net/bluetooth/hci_sysfs.c:53
 hci_le_cis_estabilished_evt+0x57c/0xae0 net/bluetooth/hci_event.c:6799
 hci_le_meta_evt+0x2b8/0x510 net/bluetooth/hci_event.c:7110
 hci_event_func net/bluetooth/hci_event.c:7440 [inline]
 hci_event_packet+0x63d/0xfd0 net/bluetooth/hci_event.c:7495
 hci_rx_work+0xae7/0x1230 net/bluetooth/hci_core.c:4007
 process_one_work+0x991/0x1610 kernel/workqueue.c:2289
 worker_thread+0x665/0x1080 kernel/workqueue.c:2436
 kthread+0x2e4/0x3a0 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:306
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:__list_add_valid.cold+0x42/0x58 lib/list_debug.c:33
Code: e8 73 f6 f0 ff 0f 0b 48 c7 c7 40 f9 48 8a e8 65 f6 f0 ff 0f 0b 48 89 f2 4c 89 e1 48 89 ee 48 c7 c7 40 fb 48 8a e8 4e f6 f0 ff <0f> 0b 48 89 f1 48 c7 c7 c0 fa 48 8a 4c 89 e6 e8 3a f6 f0 ff 0f 0b
RSP: 0018:ffffc9000398f800 EFLAGS: 00010282
RAX: 0000000000000058 RBX: ffff8880216bd298 RCX: 0000000000000000
RDX: ffff888076949d80 RSI: ffffffff8161f408 RDI: fffff52000731ef2
RBP: ffff88807cd08540 R08: 0000000000000058 R09: 0000000000000000
R10: 0000000080000001 R11: 0000000000000000 R12: ffff888144a30000
R13: ffff88807cd08550 R14: ffff88807cd08558 R15: ffff88807cd08540
FS:  0000000000000000(0000) GS:ffff8880b9a00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020000000 CR3: 000000000bc8e000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
