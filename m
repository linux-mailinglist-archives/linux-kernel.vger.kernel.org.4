Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 666156A64EF
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 02:46:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229616AbjCABqq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 20:46:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229602AbjCABqo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 20:46:44 -0500
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0586A29E24
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 17:46:41 -0800 (PST)
Received: by mail-il1-f199.google.com with SMTP id r13-20020a92c5ad000000b00316ecbf63c9so7032223ilt.13
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 17:46:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eQwVoECXOQyMsnlLVCVZRg4wJkJssoDqIHLnAqHX2IE=;
        b=Dl2Lmia+fTCpR1uJyFQ1gFNT6RJBXEjB+P1FPB5RB/42UWFKnVnTOJXniI3LKeHpWo
         V3vktU7pgVj06aTkuc8+u7ufJLIJPovC5Sxk9L+sdJ4F+fdJlXVh2FfiB7b/5a8dLS+g
         BNe1O6+OLvj+6k64pgeHwZoBnHR+SsDJJ6aOsqNBNtX5QufaLK7Jq3Rq+IR9wp8KKeOZ
         20PiucAgqvgrKuo9duzlbk4SuC+XEmiXPFLnFMrJDfR1wz5Y0DH2QpY4OfQdYV51/q1j
         8k5fbVzPJx6oDkQk7y/0/YpHqjTGKA9kKrVgR7qO8GdkVqQV/fX0CcTdPhPjdUUpkUcy
         oc0g==
X-Gm-Message-State: AO0yUKWQqZyuaodjkwL0epvn5c6dS5Xv0sLWCDK3ojuOf0VDGm9PNYXj
        fGDMJjqr0jm/NEdws41IEz8/5D1jhwqqRRpN6zoOOvAteZbS
X-Google-Smtp-Source: AK7set/ZQLtnSWIAiLo/sNNmRnq0oW9KYq/WBGqgtYAnl+aa3N0NQUfCEBKJltPqJ7VlpBWq/fv92cMLHPxrBqk89jDlgzzgjCxj
MIME-Version: 1.0
X-Received: by 2002:a92:2001:0:b0:315:9a9a:2cd with SMTP id
 j1-20020a922001000000b003159a9a02cdmr2190416ile.4.1677635201228; Tue, 28 Feb
 2023 17:46:41 -0800 (PST)
Date:   Tue, 28 Feb 2023 17:46:41 -0800
In-Reply-To: <00000000000052865105f5c8f2c8@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000003b68bb05f5cce269@google.com>
Subject: Re: [syzbot] [ext4?] possible deadlock in jbd2_log_wait_commit
From:   syzbot <syzbot+9d16c39efb5fade84574@syzkaller.appspotmail.com>
To:     jack@suse.com, linux-ext4@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, tytso@mit.edu
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

HEAD commit:    e492250d5252 Merge tag 'pwm/for-6.3-rc1' of git://git.kern..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=13eff33cc80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ff98a3b3c1aed3ab
dashboard link: https://syzkaller.appspot.com/bug?extid=9d16c39efb5fade84574
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12317df8c80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=150109acc80000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/50a19d2021d0/disk-e492250d.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/eb6e11bcecdf/vmlinux-e492250d.xz
kernel image: https://storage.googleapis.com/syzbot-assets/6946b530d74f/bzImage-e492250d.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+9d16c39efb5fade84574@syzkaller.appspotmail.com

======================================================
WARNING: possible circular locking dependency detected
6.2.0-syzkaller-12944-ge492250d5252 #0 Not tainted
------------------------------------------------------
syz-executor109/5071 is trying to acquire lock:
ffff88814afd4990 (jbd2_handle){++++}-{0:0}, at: jbd2_log_wait_commit+0x146/0x430 fs/jbd2/journal.c:689

but task is already holding lock:
ffff888070a4f780 (&type->i_mutex_dir_key#3/4){+.+.}-{3:3}, at: inode_lock_nested include/linux/fs.h:793 [inline]
ffff888070a4f780 (&type->i_mutex_dir_key#3/4){+.+.}-{3:3}, at: ext4_rename+0x1924/0x26d0 fs/ext4/namei.c:3879

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #1 (&type->i_mutex_dir_key#3/4){+.+.}-{3:3}:
       down_write_nested+0x96/0x200 kernel/locking/rwsem.c:1689
       inode_lock_nested include/linux/fs.h:793 [inline]
       ext4_rename+0x1924/0x26d0 fs/ext4/namei.c:3879
       ext4_rename2+0x1c7/0x270 fs/ext4/namei.c:4193
       vfs_rename+0xef6/0x17a0 fs/namei.c:4772
       do_renameat2+0xb62/0xc90 fs/namei.c:4923
       __do_sys_renameat2 fs/namei.c:4956 [inline]
       __se_sys_renameat2 fs/namei.c:4953 [inline]
       __x64_sys_renameat2+0xe8/0x120 fs/namei.c:4953
       do_syscall_x64 arch/x86/entry/common.c:50 [inline]
       do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
       entry_SYSCALL_64_after_hwframe+0x63/0xcd

-> #0 (jbd2_handle){++++}-{0:0}:
       check_prev_add kernel/locking/lockdep.c:3098 [inline]
       check_prevs_add kernel/locking/lockdep.c:3217 [inline]
       validate_chain kernel/locking/lockdep.c:3832 [inline]
       __lock_acquire+0x2ec7/0x5d40 kernel/locking/lockdep.c:5056
       lock_acquire kernel/locking/lockdep.c:5669 [inline]
       lock_acquire+0x1e3/0x670 kernel/locking/lockdep.c:5634
       jbd2_log_wait_commit+0x17b/0x430 fs/jbd2/journal.c:692
       jbd2_journal_stop+0x5f5/0xfd0 fs/jbd2/transaction.c:1959
       __ext4_journal_stop+0xe2/0x1f0 fs/ext4/ext4_jbd2.c:133
       ext4_rename+0x1470/0x26d0 fs/ext4/namei.c:4011
       ext4_rename2+0x1c7/0x270 fs/ext4/namei.c:4193
       vfs_rename+0xef6/0x17a0 fs/namei.c:4772
       do_renameat2+0xb62/0xc90 fs/namei.c:4923
       __do_sys_renameat2 fs/namei.c:4956 [inline]
       __se_sys_renameat2 fs/namei.c:4953 [inline]
       __x64_sys_renameat2+0xe8/0x120 fs/namei.c:4953
       do_syscall_x64 arch/x86/entry/common.c:50 [inline]
       do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
       entry_SYSCALL_64_after_hwframe+0x63/0xcd

other info that might help us debug this:

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&type->i_mutex_dir_key#3/4);
                               lock(jbd2_handle);
                               lock(&type->i_mutex_dir_key#3/4);
  lock(jbd2_handle);

 *** DEADLOCK ***

5 locks held by syz-executor109/5071:
 #0: ffff88814afd0460 (sb_writers#5){.+.+}-{0:0}, at: do_renameat2+0x37f/0xc90 fs/namei.c:4859
 #1: ffff88814afd0748 (&type->s_vfs_rename_key#2){+.+.}-{3:3}, at: lock_rename+0x58/0x280 fs/namei.c:2995
 #2: ffff888070a4b680 (&type->i_mutex_dir_key#3/1){+.+.}-{3:3}, at: inode_lock_nested include/linux/fs.h:793 [inline]
 #2: ffff888070a4b680 (&type->i_mutex_dir_key#3/1){+.+.}-{3:3}, at: lock_rename+0x136/0x280 fs/namei.c:3006
 #3: ffff888070a4e740 (&type->i_mutex_dir_key#3/2){+.+.}-{3:3}, at: inode_lock_nested include/linux/fs.h:793 [inline]
 #3: ffff888070a4e740 (&type->i_mutex_dir_key#3/2){+.+.}-{3:3}, at: lock_rename+0x16a/0x280 fs/namei.c:3007
 #4: ffff888070a4f780 (&type->i_mutex_dir_key#3/4){+.+.}-{3:3}, at: inode_lock_nested include/linux/fs.h:793 [inline]
 #4: ffff888070a4f780 (&type->i_mutex_dir_key#3/4){+.+.}-{3:3}, at: ext4_rename+0x1924/0x26d0 fs/ext4/namei.c:3879

stack backtrace:
CPU: 0 PID: 5071 Comm: syz-executor109 Not tainted 6.2.0-syzkaller-12944-ge492250d5252 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/16/2023
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xd9/0x150 lib/dump_stack.c:106
 check_noncircular+0x25f/0x2e0 kernel/locking/lockdep.c:2178
 check_prev_add kernel/locking/lockdep.c:3098 [inline]
 check_prevs_add kernel/locking/lockdep.c:3217 [inline]
 validate_chain kernel/locking/lockdep.c:3832 [inline]
 __lock_acquire+0x2ec7/0x5d40 kernel/locking/lockdep.c:5056
 lock_acquire kernel/locking/lockdep.c:5669 [inline]
 lock_acquire+0x1e3/0x670 kernel/locking/lockdep.c:5634
 jbd2_log_wait_commit+0x17b/0x430 fs/jbd2/journal.c:692
 jbd2_journal_stop+0x5f5/0xfd0 fs/jbd2/transaction.c:1959
 __ext4_journal_stop+0xe2/0x1f0 fs/ext4/ext4_jbd2.c:133
 ext4_rename+0x1470/0x26d0 fs/ext4/namei.c:4011
 ext4_rename2+0x1c7/0x270 fs/ext4/namei.c:4193
 vfs_rename+0xef6/0x17a0 fs/namei.c:4772
 do_renameat2+0xb62/0xc90 fs/namei.c:4923
 __do_sys_renameat2 fs/namei.c:4956 [inline]
 __se_sys_renameat2 fs/namei.c:4953 [inline]
 __x64_sys_renameat2+0xe8/0x120 fs/namei.c:4953
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7fd5477525c9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 e1 14 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffe53888c48 EFLAGS: 00000246 ORIG_RAX: 000000000000013c
RAX: ffffffffffffffda RBX: 00007fd5477960af RCX: 00007fd5477525c9
RDX: 0000000000000004 RSI: 0000000020000140 RDI: 0000000000000004
RBP: 0000000000000000 R08: 0000000000000004 R09: 00007ffe53888c70
R10: 00000000200002c0 R11: 0000000000000246 R12: 00007ffe53888c6c
R13: 00007ffe53888ca0 R14: 00007ffe53888c80 R15: 0000000000000001
 </TASK>

