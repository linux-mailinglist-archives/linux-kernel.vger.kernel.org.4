Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1529E60081F
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 09:53:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229799AbiJQHxm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 03:53:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229663AbiJQHxk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 03:53:40 -0400
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BA83537D2
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 00:53:39 -0700 (PDT)
Received: by mail-io1-f72.google.com with SMTP id 23-20020a5d9c57000000b006bbd963e8adso6431716iof.19
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 00:53:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AbDg6pzEyxcLVYL5n7+wxzx08ypgOKMiqK79CtC/x+o=;
        b=JRuwfbn54EhOLXFl/4jv3OeG5vz+k+XqYyZbnuMBwoyil3HEliZbxXzCk0mCOCjyGK
         htaEc6MuVWHHp0ZaDwmv9d4XQGeozVaJozP0GFojHngv2XAIy/NhfLRK2sh6t+840YbB
         CrfBcSavWQ/XA1rb6KO5eGxXr2MwjBRi+pZB/0honI5pUZ/cZuuP34V6vhI4HJxrVomk
         CdZizoHEhNAgjinm5nNkBQS/YrzCeLaAtJLDsu90ogGlWgYT9xv0WeMOrgZrryVnP56P
         hjjHuqdv0Jj44P+KsLk5VkMGQ58uVB0cUFR2umfrFOUpV1XYXsTIAxsl76TKbn7woOXR
         wHYA==
X-Gm-Message-State: ACrzQf0LgzNkBQY1kFuCdwal+nBYMXqFSmtXi9O1GyoXex01JGCc1b1c
        EpnAQP/X3natlJbOGktOXcDOkioswg7txnfXeTkJDjt0V5Ly
X-Google-Smtp-Source: AMsMyM5NJd4tXGlnNzzHPHITw+icwU0j0jBqMnVdJ48pV1eIxPJiRBnbaBkfO/8oWQJHlaAxT/efofzN3IBd06Ke7phpyKwN6vHy
MIME-Version: 1.0
X-Received: by 2002:a6b:2a83:0:b0:6bc:d2c8:fb8d with SMTP id
 q125-20020a6b2a83000000b006bcd2c8fb8dmr3912724ioq.79.1665993218451; Mon, 17
 Oct 2022 00:53:38 -0700 (PDT)
Date:   Mon, 17 Oct 2022 00:53:38 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000fbf46f05eb3645d0@google.com>
Subject: [syzbot] possible deadlock in nilfs_count_free_blocks
From:   syzbot <syzbot+45d6ce7b7ad7ef455d03@syzkaller.appspotmail.com>
To:     konishi.ryusuke@gmail.com, linux-kernel@vger.kernel.org,
        linux-nilfs@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    bbed346d5a96 Merge branch 'for-next/core' into for-kernelci
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=16341694880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3a4a45d2d827c1e
dashboard link: https://syzkaller.appspot.com/bug?extid=45d6ce7b7ad7ef455d03
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
userspace arch: arm64
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15bf870c880000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16b91e9a880000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/e8e91bc79312/disk-bbed346d.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/c1cb3fb3b77e/vmlinux-bbed346d.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/db0807eded60/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+45d6ce7b7ad7ef455d03@syzkaller.appspotmail.com

======================================================
WARNING: possible circular locking dependency detected
6.0.0-rc7-syzkaller-18095-gbbed346d5a96 #0 Not tainted
------------------------------------------------------
syz-executor408/3031 is trying to acquire lock:
ffff0000c0c18070 (&dat_lock_key){.+.+}-{3:3}, at: nilfs_count_free_blocks+0x2c/0x6c fs/nilfs2/the_nilfs.c:693

but task is already holding lock:
ffff0000cabc9890 (&nilfs->ns_sem){++++}-{3:3}, at: nilfs_put_super+0x4c/0x9c fs/nilfs2/super.c:471

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #1 (&nilfs->ns_sem){++++}-{3:3}:
       down_write+0x5c/0xcc kernel/locking/rwsem.c:1552
       nilfs_set_error fs/nilfs2/super.c:92 [inline]
       __nilfs_error+0xb4/0x284 fs/nilfs2/super.c:137
       nilfs_bmap_convert_error fs/nilfs2/bmap.c:35 [inline]
       nilfs_bmap_lookup_contig+0x98/0xc0 fs/nilfs2/bmap.c:95
       nilfs_get_block+0x7c/0x364 fs/nilfs2/inode.c:85
       block_truncate_page+0x1b4/0xab4 fs/buffer.c:2583
       nilfs_truncate+0xb8/0x178 fs/nilfs2/inode.c:857
       nilfs_setattr+0xf8/0x164 fs/nilfs2/inode.c:955
       notify_change+0x758/0x7f0 fs/attr.c:420
       do_truncate+0x108/0x150 fs/open.c:65
       vfs_truncate+0x1dc/0x24c fs/open.c:111
       do_sys_truncate+0x94/0x140 fs/open.c:134
       __do_sys_truncate fs/open.c:146 [inline]
       __se_sys_truncate fs/open.c:144 [inline]
       __arm64_sys_truncate+0x20/0x30 fs/open.c:144
       __invoke_syscall arch/arm64/kernel/syscall.c:38 [inline]
       invoke_syscall arch/arm64/kernel/syscall.c:52 [inline]
       el0_svc_common+0x138/0x220 arch/arm64/kernel/syscall.c:142
       do_el0_svc+0x48/0x164 arch/arm64/kernel/syscall.c:206
       el0_svc+0x58/0x150 arch/arm64/kernel/entry-common.c:636
       el0t_64_sync_handler+0x84/0xf0 arch/arm64/kernel/entry-common.c:654
       el0t_64_sync+0x18c/0x190 arch/arm64/kernel/entry.S:581

-> #0 (&dat_lock_key){.+.+}-{3:3}:
       check_prev_add kernel/locking/lockdep.c:3095 [inline]
       check_prevs_add kernel/locking/lockdep.c:3214 [inline]
       validate_chain kernel/locking/lockdep.c:3829 [inline]
       __lock_acquire+0x1530/0x30a4 kernel/locking/lockdep.c:5053
       lock_acquire+0x100/0x1f8 kernel/locking/lockdep.c:5666
       down_read+0x5c/0x78 kernel/locking/rwsem.c:1499
       nilfs_count_free_blocks+0x2c/0x6c fs/nilfs2/the_nilfs.c:693
       nilfs_set_log_cursor fs/nilfs2/super.c:236 [inline]
       nilfs_cleanup_super+0x118/0x1f0 fs/nilfs2/super.c:318
       nilfs_put_super+0x54/0x9c fs/nilfs2/super.c:472
       generic_shutdown_super+0x8c/0x190 fs/super.c:491
       kill_block_super+0x30/0x78 fs/super.c:1427
       deactivate_locked_super+0x70/0xe8 fs/super.c:332
       deactivate_super+0xd0/0xd4 fs/super.c:363
       cleanup_mnt+0x1f8/0x234 fs/namespace.c:1186
       __cleanup_mnt+0x20/0x30 fs/namespace.c:1193
       task_work_run+0xc4/0x14c kernel/task_work.c:177
       resume_user_mode_work include/linux/resume_user_mode.h:49 [inline]
       do_notify_resume+0x174/0x1f0 arch/arm64/kernel/signal.c:1127
       prepare_exit_to_user_mode arch/arm64/kernel/entry-common.c:137 [inline]
       exit_to_user_mode arch/arm64/kernel/entry-common.c:142 [inline]
       el0_svc+0x9c/0x150 arch/arm64/kernel/entry-common.c:637
       el0t_64_sync_handler+0x84/0xf0 arch/arm64/kernel/entry-common.c:654
       el0t_64_sync+0x18c/0x190 arch/arm64/kernel/entry.S:581

other info that might help us debug this:

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&nilfs->ns_sem);
                               lock(&dat_lock_key);
                               lock(&nilfs->ns_sem);
  lock(&dat_lock_key);

 *** DEADLOCK ***

2 locks held by syz-executor408/3031:
 #0: ffff0000c902f0e0 (&type->s_umount_key#41){+.+.}-{3:3}, at: deactivate_super+0xc8/0xd4 fs/super.c:362
 #1: ffff0000cabc9890 (&nilfs->ns_sem){++++}-{3:3}, at: nilfs_put_super+0x4c/0x9c fs/nilfs2/super.c:471

stack backtrace:
CPU: 0 PID: 3031 Comm: syz-executor408 Not tainted 6.0.0-rc7-syzkaller-18095-gbbed346d5a96 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/30/2022
Call trace:
 dump_backtrace+0x1c4/0x1f0 arch/arm64/kernel/stacktrace.c:156
 show_stack+0x2c/0x54 arch/arm64/kernel/stacktrace.c:163
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x104/0x16c lib/dump_stack.c:106
 dump_stack+0x1c/0x58 lib/dump_stack.c:113
 print_circular_bug+0x2c4/0x2c8 kernel/locking/lockdep.c:2053
 check_noncircular+0x14c/0x154 kernel/locking/lockdep.c:2175
 check_prev_add kernel/locking/lockdep.c:3095 [inline]
 check_prevs_add kernel/locking/lockdep.c:3214 [inline]
 validate_chain kernel/locking/lockdep.c:3829 [inline]
 __lock_acquire+0x1530/0x30a4 kernel/locking/lockdep.c:5053
 lock_acquire+0x100/0x1f8 kernel/locking/lockdep.c:5666
 down_read+0x5c/0x78 kernel/locking/rwsem.c:1499
 nilfs_count_free_blocks+0x2c/0x6c fs/nilfs2/the_nilfs.c:693
 nilfs_set_log_cursor fs/nilfs2/super.c:236 [inline]
 nilfs_cleanup_super+0x118/0x1f0 fs/nilfs2/super.c:318
 nilfs_put_super+0x54/0x9c fs/nilfs2/super.c:472
 generic_shutdown_super+0x8c/0x190 fs/super.c:491
 kill_block_super+0x30/0x78 fs/super.c:1427
 deactivate_locked_super+0x70/0xe8 fs/super.c:332
 deactivate_super+0xd0/0xd4 fs/super.c:363
 cleanup_mnt+0x1f8/0x234 fs/namespace.c:1186
 __cleanup_mnt+0x20/0x30 fs/namespace.c:1193
 task_work_run+0xc4/0x14c kernel/task_work.c:177
 resume_user_mode_work include/linux/resume_user_mode.h:49 [inline]
 do_notify_resume+0x174/0x1f0 arch/arm64/kernel/signal.c:1127
 prepare_exit_to_user_mode arch/arm64/kernel/entry-common.c:137 [inline]
 exit_to_user_mode arch/arm64/kernel/entry-common.c:142 [inline]
 el0_svc+0x9c/0x150 arch/arm64/kernel/entry-common.c:637
 el0t_64_sync_handler+0x84/0xf0 arch/arm64/kernel/entry-common.c:654
 el0t_64_sync+0x18c/0x190 arch/arm64/kernel/entry.S:581


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
