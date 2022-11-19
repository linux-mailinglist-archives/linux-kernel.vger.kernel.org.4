Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B6E9630BF1
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Nov 2022 05:50:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231909AbiKSEuo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 23:50:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229596AbiKSEul (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 23:50:41 -0500
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75679B7019
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 20:50:40 -0800 (PST)
Received: by mail-il1-f200.google.com with SMTP id g4-20020a92cda4000000b00301ff06da14so4615438ild.11
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 20:50:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ykusFFXkV4YV32sh0xr8cRt9KBmXgiJ3md6Pb/tudTA=;
        b=itytH3lnMrjgb891bSOgUrZkzFrGdPA1Vf/ZbFg/Het1j28gj/sKnrICN6f43vM4sv
         OcbgD+y4WP7RVfmuE7kzRzCBvjeYa5YkY600pu/93wOvz1EfjHA5ocAW0if0HoXToiQS
         v3e5cIwjAtwiBAT0/CA+Qsf+VC4Rcyuk6Kmksh7XOuGNZS8OMztZ+TZ4JCTWTu2DbKw4
         CUITujmHNewkIXo8UnStRc7PaEkWbK5z6ahI2OepmT7mgetpqZBxRU1u1lv2X5XQubc1
         zSU5SHzSn+jlkreEzUIP5zq6YHOX1zfXeQFpJJ8j9g9ZyNKKdFvLWcc9BZpaTx/iIEUf
         dzeA==
X-Gm-Message-State: ANoB5pkeRMO8C1qjvNsu9xnfa4PnXtLrFL6nHUwlk3V1OSpfDerBSD8I
        nf/2fk/NPXdvqBBiPZkwo7SaOCCCE8Bqwl1EWiE+EtdhSGW3
X-Google-Smtp-Source: AA0mqf514LqZR2cFbnr1/myamSoKgsY4ha3jIQfa0Cgt83bI3wgzQby3q1dDCrT+cqUKrgtHad1tbZ9SR2gCs552pecPYnGMhX8c
MIME-Version: 1.0
X-Received: by 2002:a6b:f414:0:b0:6d1:88ee:a64f with SMTP id
 i20-20020a6bf414000000b006d188eea64fmr4559935iog.61.1668833439812; Fri, 18
 Nov 2022 20:50:39 -0800 (PST)
Date:   Fri, 18 Nov 2022 20:50:39 -0800
In-Reply-To: <000000000000994fbe05e5b5d4d9@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000005e924a05edcb905e@google.com>
Subject: Re: [syzbot] possible deadlock in __jbd2_log_wait_for_space
From:   syzbot <syzbot+fa1bbda326271b8808c9@syzkaller.appspotmail.com>
To:     jack@suse.com, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has found a reproducer for the following issue on:

HEAD commit:    15f3bff12cf6 Add linux-next specific files for 20221116
git tree:       linux-next
console+strace: https://syzkaller.appspot.com/x/log.txt?x=1370fb65880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ec2a1d4f50866178
dashboard link: https://syzkaller.appspot.com/bug?extid=fa1bbda326271b8808c9
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=114241dd880000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14c2f42d880000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/b67307c8c3c9/disk-15f3bff1.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/956c7b56c5c1/vmlinux-15f3bff1.xz
kernel image: https://storage.googleapis.com/syzbot-assets/505ae2f65529/bzImage-15f3bff1.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+fa1bbda326271b8808c9@syzkaller.appspotmail.com

======================================================
WARNING: possible circular locking dependency detected
6.1.0-rc5-next-20221116-syzkaller #0 Not tainted
------------------------------------------------------
syz-executor164/5304 is trying to acquire lock:
ffff88814baea3f8 (&journal->j_checkpoint_mutex){+.+.}-{3:3}, at: __jbd2_log_wait_for_space+0x238/0x460 fs/jbd2/checkpoint.c:110

but task is already holding lock:
ffff888065608e08 (&sb->s_type->i_mutex_key#8){++++}-{3:3}, at: inode_lock include/linux/fs.h:756 [inline]
ffff888065608e08 (&sb->s_type->i_mutex_key#8){++++}-{3:3}, at: vfs_unlink+0xd9/0x930 fs/namei.c:4240

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #1 (&sb->s_type->i_mutex_key#8){++++}-{3:3}:
       down_read+0x9c/0x450 kernel/locking/rwsem.c:1509
       inode_lock_shared include/linux/fs.h:766 [inline]
       ext4_bmap+0x52/0x470 fs/ext4/inode.c:3164
       bmap+0xae/0x120 fs/inode.c:1798
       jbd2_journal_bmap+0xac/0x180 fs/jbd2/journal.c:977
       __jbd2_journal_erase fs/jbd2/journal.c:1789 [inline]
       jbd2_journal_flush+0x853/0xc00 fs/jbd2/journal.c:2492
       ext4_ioctl_checkpoint fs/ext4/ioctl.c:1081 [inline]
       __ext4_ioctl+0xae8/0x4d60 fs/ext4/ioctl.c:1586
       vfs_ioctl fs/ioctl.c:51 [inline]
       __do_sys_ioctl fs/ioctl.c:870 [inline]
       __se_sys_ioctl fs/ioctl.c:856 [inline]
       __x64_sys_ioctl+0x197/0x210 fs/ioctl.c:856
       do_syscall_x64 arch/x86/entry/common.c:50 [inline]
       do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
       entry_SYSCALL_64_after_hwframe+0x63/0xcd

-> #0 (&journal->j_checkpoint_mutex){+.+.}-{3:3}:
       check_prev_add kernel/locking/lockdep.c:3097 [inline]
       check_prevs_add kernel/locking/lockdep.c:3216 [inline]
       validate_chain kernel/locking/lockdep.c:3831 [inline]
       __lock_acquire+0x2a43/0x56d0 kernel/locking/lockdep.c:5055
       lock_acquire kernel/locking/lockdep.c:5668 [inline]
       lock_acquire+0x1e3/0x630 kernel/locking/lockdep.c:5633
       __mutex_lock_common kernel/locking/mutex.c:603 [inline]
       mutex_lock_io_nested+0x143/0x11a0 kernel/locking/mutex.c:833
       __jbd2_log_wait_for_space+0x238/0x460 fs/jbd2/checkpoint.c:110
       add_transaction_credits+0xa2d/0xb70 fs/jbd2/transaction.c:298
       start_this_handle+0x3ae/0x14a0 fs/jbd2/transaction.c:422
       jbd2__journal_start+0x39d/0x9b0 fs/jbd2/transaction.c:520
       __ext4_journal_start_sb+0x421/0x530 fs/ext4/ext4_jbd2.c:105
       __ext4_journal_start fs/ext4/ext4_jbd2.h:326 [inline]
       ext4_unlink+0x32b/0xae0 fs/ext4/namei.c:3284
       vfs_unlink+0x355/0x930 fs/namei.c:4251
       do_unlinkat+0x3b7/0x640 fs/namei.c:4319
       __do_sys_unlink fs/namei.c:4367 [inline]
       __se_sys_unlink fs/namei.c:4365 [inline]
       __x64_sys_unlink+0xca/0x110 fs/namei.c:4365
       do_syscall_x64 arch/x86/entry/common.c:50 [inline]
       do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
       entry_SYSCALL_64_after_hwframe+0x63/0xcd

other info that might help us debug this:

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&sb->s_type->i_mutex_key#8);
                               lock(&journal->j_checkpoint_mutex);
                               lock(&sb->s_type->i_mutex_key#8);
  lock(&journal->j_checkpoint_mutex);

 *** DEADLOCK ***

3 locks held by syz-executor164/5304:
 #0: ffff88814bae6460 (sb_writers#4){.+.+}-{0:0}, at: do_unlinkat+0x183/0x640 fs/namei.c:4298
 #1: ffff888076c1d440 (&type->i_mutex_dir_key#3/1){+.+.}-{3:3}, at: inode_lock_nested include/linux/fs.h:791 [inline]
 #1: ffff888076c1d440 (&type->i_mutex_dir_key#3/1){+.+.}-{3:3}, at: do_unlinkat+0x270/0x640 fs/namei.c:4302
 #2: ffff888065608e08 (&sb->s_type->i_mutex_key#8){++++}-{3:3}, at: inode_lock include/linux/fs.h:756 [inline]
 #2: ffff888065608e08 (&sb->s_type->i_mutex_key#8){++++}-{3:3}, at: vfs_unlink+0xd9/0x930 fs/namei.c:4240

stack backtrace:
CPU: 1 PID: 5304 Comm: syz-executor164 Not tainted 6.1.0-rc5-next-20221116-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/26/2022
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xd1/0x138 lib/dump_stack.c:106
 check_noncircular+0x25f/0x2e0 kernel/locking/lockdep.c:2177
 check_prev_add kernel/locking/lockdep.c:3097 [inline]
 check_prevs_add kernel/locking/lockdep.c:3216 [inline]
 validate_chain kernel/locking/lockdep.c:3831 [inline]
 __lock_acquire+0x2a43/0x56d0 kernel/locking/lockdep.c:5055
 lock_acquire kernel/locking/lockdep.c:5668 [inline]
 lock_acquire+0x1e3/0x630 kernel/locking/lockdep.c:5633
 __mutex_lock_common kernel/locking/mutex.c:603 [inline]
 mutex_lock_io_nested+0x143/0x11a0 kernel/locking/mutex.c:833
 __jbd2_log_wait_for_space+0x238/0x460 fs/jbd2/checkpoint.c:110
 add_transaction_credits+0xa2d/0xb70 fs/jbd2/transaction.c:298
 start_this_handle+0x3ae/0x14a0 fs/jbd2/transaction.c:422
 jbd2__journal_start+0x39d/0x9b0 fs/jbd2/transaction.c:520
 __ext4_journal_start_sb+0x421/0x530 fs/ext4/ext4_jbd2.c:105
 __ext4_journal_start fs/ext4/ext4_jbd2.h:326 [inline]
 ext4_unlink+0x32b/0xae0 fs/ext4/namei.c:3284
 vfs_unlink+0x355/0x930 fs/namei.c:4251
 do_unlinkat+0x3b7/0x640 fs/namei.c:4319
 __do_sys_unlink fs/namei.c:4367 [inline]
 __se_sys_unlink fs/namei.c:4365 [inline]
 __x64_sys_unlink+0xca/0x110 fs/namei.c:4365
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f3a0088bff7
Code: 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48 83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 b8 57 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffe6d2c0f28 EFLAGS: 00000206 ORIG_RAX: 0000000000000057
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f3a0088bff7
RDX: 00007ffe6d2c0f50 RSI: 00007ffe6d2c0f50 RDI: 00007ffe6d2c0fe0
RBP: 00007ffe6d2c0fe0 R08: 0000000000000001 R09: 00007ffe6d2c0dc0
R10: 0000555555f9e683 R11: 0000000000000206 R12: 00007ffe6d2c20a0
R13: 0000555555f9e5f0 R14: 00007ffe6d2c0f50 R15: 431bde82d7b634db
 </TASK>

