Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E20D15F27E9
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Oct 2022 05:53:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229550AbiJCDxj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Oct 2022 23:53:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbiJCDxd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Oct 2022 23:53:33 -0400
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 240F327153
        for <linux-kernel@vger.kernel.org>; Sun,  2 Oct 2022 20:53:31 -0700 (PDT)
Received: by mail-il1-f198.google.com with SMTP id g1-20020a92cda1000000b002f612391d5bso7518548ild.2
        for <linux-kernel@vger.kernel.org>; Sun, 02 Oct 2022 20:53:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date;
        bh=5UX8UvFELFPf+hJe9Pw+hJuyDg2PnF+1lGkZkcSAJUE=;
        b=X94lV0GZekZ83+rcEsRmnqskpyLujaIC+Xrqqkyg8PWcjOQvAdEe7nKopjy3+/BqZv
         iyjUivu40oza0Aw8vNw1IulW6xYwc+DvaQnbyI32By0x4B4VxOUob8hoGFEMiIXAgEa/
         cxFyuiYlGZob1A5rWDFUlFm3kEUo4KcdZ+tZu9soB/VNwJURQPeXA9kQ9zOI2nDOtNmq
         Ccqg3+qHzLmHRxEhO03TRXmFCmbL1jaQOveW4HZtMTRVz5qBWnxMiznTxErR082l1jT6
         7g0+FO7PlB28sFvknvf7Mj3e7nAsNmEKUejWZyn8U7NC8gSji3qC9tHvKkYrAU2Y3zEK
         Nu7w==
X-Gm-Message-State: ACrzQf3naZgm6I1ggY1sGERoZ7Dcwbr/fX5+aFytdqmD7j18NxBWKtBp
        QsdOH5P53OpmQ9dlKQAa8bsdqmIAwHHvnv87JKr1R1mZigtV
X-Google-Smtp-Source: AMsMyM4tIse+vTF2vTGYf88YS+ZbvTLfYLud4mHfj6888dXkC8/x211A1QvMeXbgJeV5vxTyx6A1rFozzZLDb7cJk/Pxi6ZdLL+I
MIME-Version: 1.0
X-Received: by 2002:a6b:e714:0:b0:6a1:35af:82dc with SMTP id
 b20-20020a6be714000000b006a135af82dcmr7585539ioh.205.1664769211197; Sun, 02
 Oct 2022 20:53:31 -0700 (PDT)
Date:   Sun, 02 Oct 2022 20:53:31 -0700
In-Reply-To: <00000000000068e76205e2ec0e6b@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000776f5005ea1949d8@google.com>
Subject: Re: [syzbot] WARNING in match_held_lock
From:   syzbot <syzbot+6c67d4224af196c99976@syzkaller.appspotmail.com>
To:     almaz.alexandrovich@paragon-software.com, boqun.feng@gmail.com,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        llvm@lists.linux.dev, longman@redhat.com, mingo@redhat.com,
        nathan@kernel.org, ndesaulniers@google.com, ntfs3@lists.linux.dev,
        peterz@infradead.org, syzkaller-bugs@googlegroups.com,
        trix@redhat.com, will@kernel.org
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

HEAD commit:    a962b54e162c Merge tag 'i2c-for-6.0-rc8' of git://git.kern..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=11833a82880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=755695d26ad09807
dashboard link: https://syzkaller.appspot.com/bug?extid=6c67d4224af196c99976
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13b51e14880000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10b33c68880000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/c0d6002d7b4b/disk-a962b54e.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/cf0a29408406/vmlinux-a962b54e.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+6c67d4224af196c99976@syzkaller.appspotmail.com

ntfs3: loop3: Different NTFS' sector size (1024) and media sector size (512)
------------[ cut here ]------------
DEBUG_LOCKS_WARN_ON(!hlock->nest_lock)
WARNING: CPU: 0 PID: 5565 at kernel/locking/lockdep.c:5135 match_held_lock+0xad/0xc0 kernel/locking/lockdep.c:5135
Modules linked in:
CPU: 0 PID: 5565 Comm: syz-executor151 Not tainted 6.0.0-rc7-syzkaller-00250-ga962b54e162c #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/22/2022
RIP: 0010:match_held_lock+0xad/0xc0 kernel/locking/lockdep.c:5135
Code: e8 b8 c4 7a fa 85 c0 74 e4 8b 05 26 e5 5e 04 85 c0 75 da 48 c7 c6 60 ac ec 89 48 c7 c7 e0 a8 ec 89 89 44 24 04 e8 45 e7 ba ff <0f> 0b 8b 44 24 04 eb bd 66 66 2e 0f 1f 84 00 00 00 00 00 41 57 41
RSP: 0018:ffffc900058c79d8 EFLAGS: 00010086
RAX: 0000000000000000 RBX: ffff88807e390aa0 RCX: 0000000000000000
RDX: ffff88807e390000 RSI: ffffffff8161f2a8 RDI: fffff52000b18f2d
RBP: ffffffff8bf89640 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000080000002 R11: 0000000000000001 R12: ffff88807e390000
R13: ffff88807e390a78 R14: 00000000ffffffff R15: ffff88807e390aa0
FS:  0000555556d9c300(0000) GS:ffff8880b9a00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fbbd6497056 CR3: 0000000016c2f000 CR4: 0000000000350ef0
Call Trace:
 <TASK>
 __lock_is_held kernel/locking/lockdep.c:5407 [inline]
 lock_is_held_type+0xa7/0x140 kernel/locking/lockdep.c:5709
 lock_is_held include/linux/lockdep.h:283 [inline]
 rcu_read_lock_sched_held+0x3a/0x70 kernel/rcu/update.c:125
 trace_lock_release include/trace/events/lock.h:69 [inline]
 lock_release+0x560/0x780 kernel/locking/lockdep.c:5677
 __raw_spin_unlock include/linux/spinlock_api_smp.h:141 [inline]
 _raw_spin_unlock+0x12/0x40 kernel/locking/spinlock.c:186
 spin_unlock include/linux/spinlock.h:389 [inline]
 inode_sb_list_del fs/inode.c:505 [inline]
 evict+0x2aa/0x6b0 fs/inode.c:654
 iput_final fs/inode.c:1748 [inline]
 iput.part.0+0x55d/0x810 fs/inode.c:1774
 iput+0x58/0x70 fs/inode.c:1764
 ntfs_fill_super+0x2e89/0x37f0 fs/ntfs3/super.c:1190
 get_tree_bdev+0x440/0x760 fs/super.c:1323
 vfs_get_tree+0x89/0x2f0 fs/super.c:1530
 do_new_mount fs/namespace.c:3040 [inline]
 path_mount+0x1326/0x1e20 fs/namespace.c:3370
 do_mount fs/namespace.c:3383 [inline]
 __do_sys_mount fs/namespace.c:3591 [inline]
 __se_sys_mount fs/namespace.c:3568 [inline]
 __x64_sys_mount+0x27f/0x300 fs/namespace.c:3568
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7fbbd6459e7a
Code: 48 c7 c2 c0 ff ff ff f7 d8 64 89 02 b8 ff ff ff ff eb d2 e8 c8 03 00 00 0f 1f 84 00 00 00 00 00 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffd6a35b568 EFLAGS: 00000286 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 00007fbbd6459e7a
RDX: 0000000020000000 RSI: 0000000020000100 RDI: 00007ffd6a35b580
RBP: 00007ffd6a35b580 R08: 00007ffd6a35b5c0 R09: 00007ffd6a35b5c0
R10: 0000000000000000 R11: 0000000000000286 R12: 0000000000000004
R13: 00007ffd6a35b5c0 R14: 000000000000010e R15: 0000000020001b50
 </TASK>

