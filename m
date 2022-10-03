Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EDA75F2BA6
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Oct 2022 10:23:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230118AbiJCIXn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Oct 2022 04:23:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230184AbiJCIXN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Oct 2022 04:23:13 -0400
Received: from mail-io1-xd47.google.com (mail-io1-xd47.google.com [IPv6:2607:f8b0:4864:20::d47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A65D551A09
        for <linux-kernel@vger.kernel.org>; Mon,  3 Oct 2022 00:57:48 -0700 (PDT)
Received: by mail-io1-xd47.google.com with SMTP id d24-20020a05660225d800b006a466ec7746so6432019iop.3
        for <linux-kernel@vger.kernel.org>; Mon, 03 Oct 2022 00:57:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date;
        bh=zc9bQW2WnjLcj5rE2zO59zS9YxZHrsetD1mQn91Tncg=;
        b=EU0OyvnfNm1VQ0D1vmhjzbIeWVGbAY1h1pBMQ4GIOAYuTk/j5h5wsp+dnZfcUoyjoc
         IDuIhFNCC+es6xurdd5gNFJDCixVme2qEEQhyuk4LEjTDlhwCgF/hKAStMeC+dUjPHuX
         Y6ZWqrimiQXCCh1C6QN2VyC0QdtPUqDA8zB7KxWC4nBsqC/lm2tXw0/glaXoIt2TO0w9
         0HpC08o0mq98Skpi/afQNm1+QqMquAXtGbz9UO+ifRfuAlgEU7hMyHu05jLKNT4NW52U
         mHV6blfZPiUAsHs5CzHXVi2JLP3v9TjD7LJORPBGvZ6AkQmi9br0J4HfVdyBMVdcqvgW
         S11A==
X-Gm-Message-State: ACrzQf1JD2GGGJK/XfPQGNpRHdG3BbyZ6seoyLHm628pzWrW8tv1UE+v
        SeZe/ASn6IrUThxRGrPpODfNi9h0+NuY6KKqzbP78ixiTs3Q
X-Google-Smtp-Source: AMsMyM5yLkRGf7jT43gi1HgyVMJyWh8U3jyUrSDIeduW2/aJal8ivx7hEJ215GNivvpGz41SaCUSzXatpmIASRXEI5UOyflKF74m
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1785:b0:2f7:e7f8:7c6 with SMTP id
 y5-20020a056e02178500b002f7e7f807c6mr8602774ilu.305.1664783738924; Mon, 03
 Oct 2022 00:55:38 -0700 (PDT)
Date:   Mon, 03 Oct 2022 00:55:38 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000062f7a505ea1cab97@google.com>
Subject: [syzbot] BUG: corrupted list in vcs_remove_sysfs
From:   syzbot <syzbot+a1aa6dc8a74dbbaa251f@syzkaller.appspotmail.com>
To:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        rafael@kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    49c13ed0316d Merge tag 'soc-fixes-6.0-rc7' of git://git.ke..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=13910538880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4520785fccee9b40
dashboard link: https://syzkaller.appspot.com/bug?extid=a1aa6dc8a74dbbaa251f
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+a1aa6dc8a74dbbaa251f@syzkaller.appspotmail.com

list_del corruption. prev->next should be ffff88807a8d9008, but was ffff88803a1e0540. (prev=ffff88803a1e0540)
------------[ cut here ]------------
kernel BUG at lib/list_debug.c:61!
invalid opcode: 0000 [#1] PREEMPT SMP KASAN
CPU: 1 PID: 29413 Comm: syz-executor.0 Not tainted 6.0.0-rc7-syzkaller-00068-g49c13ed0316d #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/26/2022
RIP: 0010:__list_del_entry_valid+0x118/0x130 lib/list_debug.c:59
Code: 05 0f 0b 48 c7 c7 20 6c 0a 8b 4c 89 fe 31 c0 e8 85 c8 fc 05 0f 0b 48 c7 c7 80 6c 0a 8b 4c 89 fe 48 89 d9 31 c0 e8 6f c8 fc 05 <0f> 0b 48 c7 c7 00 6d 0a 8b 4c 89 fe 4c 89 f1 31 c0 e8 59 c8 fc 05
RSP: 0018:ffffc90006237740 EFLAGS: 00010246
RAX: 000000000000006d RBX: ffff88803a1e0540 RCX: 07e0edd39d6fce00
RDX: ffffc900039b1000 RSI: 00000000000169a1 RDI: 00000000000169a2
RBP: 1ffff1100f51b204 R08: ffffffff816d5a8d R09: ffffed10173667f1
R10: ffffed10173667f1 R11: 1ffff110173667f0 R12: dffffc0000000000
R13: ffff88807a8d9000 R14: ffff88807afe9008 R15: ffff88807a8d9008
FS:  00007ff8983f1700(0000) GS:ffff8880b9b00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000001b2ed21000 CR3: 0000000017934000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 __list_del_entry include/linux/list.h:134 [inline]
 list_del_init include/linux/list.h:206 [inline]
 kobj_kset_leave lib/kobject.c:175 [inline]
 __kobject_del+0x132/0x300 lib/kobject.c:592
 kobject_del+0x41/0x60 lib/kobject.c:611
 device_del+0xa10/0xbe0 drivers/base/core.c:3715
 device_unregister drivers/base/core.c:3736 [inline]
 device_destroy+0xad/0x180 drivers/base/core.c:4302
 vcs_remove_sysfs+0x1d/0x50 drivers/tty/vt/vc_screen.c:796
 vc_deallocate+0x1d2/0x3e0 drivers/tty/vt/vt.c:1399
 vt_disallocate_all+0x2b9/0x470 drivers/tty/vt/vt_ioctl.c:657
 vt_ioctl+0x1914/0x1d00 drivers/tty/vt/vt_ioctl.c:902
 tty_ioctl+0x874/0xc60 drivers/tty/tty_io.c:2778
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:870 [inline]
 __se_sys_ioctl+0xfb/0x170 fs/ioctl.c:856
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x2b/0x70 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7ff89728a5a9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ff8983f1168 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007ff8973abf80 RCX: 00007ff89728a5a9
RDX: 0000000000000000 RSI: 0000000000005608 RDI: 0000000000000003
RBP: 00007ff8972e5560 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007fff8b4be86f R14: 00007ff8983f1300 R15: 0000000000022000
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:__list_del_entry_valid+0x118/0x130 lib/list_debug.c:59
Code: 05 0f 0b 48 c7 c7 20 6c 0a 8b 4c 89 fe 31 c0 e8 85 c8 fc 05 0f 0b 48 c7 c7 80 6c 0a 8b 4c 89 fe 48 89 d9 31 c0 e8 6f c8 fc 05 <0f> 0b 48 c7 c7 00 6d 0a 8b 4c 89 fe 4c 89 f1 31 c0 e8 59 c8 fc 05
RSP: 0018:ffffc90006237740 EFLAGS: 00010246
RAX: 000000000000006d RBX: ffff88803a1e0540 RCX: 07e0edd39d6fce00
RDX: ffffc900039b1000 RSI: 00000000000169a1 RDI: 00000000000169a2
RBP: 1ffff1100f51b204 R08: ffffffff816d5a8d R09: ffffed10173667f1
R10: ffffed10173667f1 R11: 1ffff110173667f0 R12: dffffc0000000000
R13: ffff88807a8d9000 R14: ffff88807afe9008 R15: ffff88807a8d9008
FS:  00007ff8983f1700(0000) GS:ffff8880b9b00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000001b2ed21000 CR3: 0000000017934000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
