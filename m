Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BE64609EBD
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 12:09:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230408AbiJXKJZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 06:09:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231247AbiJXKIq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 06:08:46 -0400
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6AC56A53F
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 03:08:30 -0700 (PDT)
Received: by mail-io1-f72.google.com with SMTP id y26-20020a5d9b1a000000b006bc71505e97so6148481ion.16
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 03:08:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5/ph2+H3Trne1yiKW3qaHgPJwMgm6RCNSzQdLyP5X4c=;
        b=Gm1gAY3PhIn0fJ8Npj/WRzbealQi35XyMfLlY4hM5MN8Z073e8zI6V1Ympk+mcflE/
         CqnuTF3nMn2AlGu7eHW1JJ1YeA5+iAc8KM3S3/YKh2BmdUyzX3Mt+viOLgz92fvC+4TB
         mwrmDnX7sUM3WBRI8ymjBAqfiWzhfhX2T5xXJTNe5llxCteU8kJky0V5oqSj6lYtIi9J
         sVug0MWshY+TwXDGJtYv8RYTp9cy3V3ASWn70aKFnmQ9ZY2BH8c+OA03mzeQwr2CIX5R
         IEiBJB42CV+97DD4kqbY9evImIAomMMTQKXYdpMrzTodmuqlI6I7nmnXPb0QBEP0LzBx
         PezA==
X-Gm-Message-State: ACrzQf0E6DTXgCASsGXfD6iTTH8cg/YNVJ9h8BhBiZsmbIgYWddlF+F6
        hNbzq7YsytgmxpIXEyZ94pXFdxOHx9T1RkmWDbB9CQ2TiWFv
X-Google-Smtp-Source: AMsMyM4QBOPAD3/t1YC3VJwY1O83zmHzq88mtWMNMBKPbU8D0Z/607i+hq6gHYwnZpmKqNNb7UYabfriW9OS++Di3ziiVO55z6QW
MIME-Version: 1.0
X-Received: by 2002:a05:6638:4190:b0:372:4b79:5d93 with SMTP id
 az16-20020a056638419000b003724b795d93mr3954715jab.216.1666606058573; Mon, 24
 Oct 2022 03:07:38 -0700 (PDT)
Date:   Mon, 24 Oct 2022 03:07:38 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000001a167a05ebc4f62b@google.com>
Subject: [syzbot] INFO: task hung in nilfs_detach_log_writer
From:   syzbot <syzbot+e3973c409251e136fdd0@syzkaller.appspotmail.com>
To:     brauner@kernel.org, broonie@kernel.org, catalin.marinas@arm.com,
        ebiederm@xmission.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, madvenka@linux.microsoft.com,
        mark.rutland@arm.com, scott@os.amperecomputing.com,
        syzkaller-bugs@googlegroups.com, will@kernel.org
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

Hello,

syzbot found the following issue on:

HEAD commit:    bbed346d5a96 Merge branch 'for-next/core' into for-kernelci
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=12c63b3c880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3a4a45d2d827c1e
dashboard link: https://syzkaller.appspot.com/bug?extid=e3973c409251e136fdd0
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
userspace arch: arm64
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13010d3c880000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16c58e6e880000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/e8e91bc79312/disk-bbed346d.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/c1cb3fb3b77e/vmlinux-bbed346d.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/ef6217a5c5b6/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+e3973c409251e136fdd0@syzkaller.appspotmail.com

INFO: task syz-executor217:3091 blocked for more than 143 seconds.
      Not tainted 6.0.0-rc7-syzkaller-18095-gbbed346d5a96 #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor217 state:D stack:    0 pid: 3091 ppid:  3089 flags:0x00000008
Call trace:
 __switch_to+0x180/0x298 arch/arm64/kernel/process.c:557
 context_switch kernel/sched/core.c:5182 [inline]
 __schedule+0x414/0x5a0 kernel/sched/core.c:6494
 schedule+0x64/0xa4 kernel/sched/core.c:6570
 schedule_timeout+0x64/0x1b4 kernel/time/timer.c:1911
 do_wait_for_common+0xf4/0x184 kernel/sched/completion.c:85
 __wait_for_common kernel/sched/completion.c:106 [inline]
 wait_for_common kernel/sched/completion.c:117 [inline]
 wait_for_completion+0x48/0x60 kernel/sched/completion.c:138
 __flush_work+0xd4/0x144 kernel/workqueue.c:3073
 flush_work+0x24/0x38 kernel/workqueue.c:3094
 nilfs_segctor_destroy fs/nilfs2/segment.c:2726 [inline]
 nilfs_detach_log_writer+0x1e0/0x4d0 fs/nilfs2/segment.c:2810
 nilfs_put_super+0x28/0x9c fs/nilfs2/super.c:468
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

Showing all locks held in the system:
1 lock held by rcu_tasks_kthre/11:
 #0: ffff80000d433568 (rcu_tasks.tasks_gp_mutex){+.+.}-{3:3}, at: rcu_tasks_one_gp+0x3c/0x450 kernel/rcu/tasks.h:507
1 lock held by rcu_tasks_trace/12:
 #0: ffff80000d433bb8 (rcu_tasks_trace.tasks_gp_mutex){+.+.}-{3:3}, at: rcu_tasks_one_gp+0x3c/0x450 kernel/rcu/tasks.h:507
1 lock held by khungtaskd/27:
 #0: ffff80000d433440 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire+0x4/0x48 include/linux/rcupdate.h:279
2 locks held by getty/2727:
 #0: ffff0000c7906098 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x28/0x58 drivers/tty/tty_ldisc.c:244
 #1: ffff80000f6162f0 (&ldata->atomic_read_lock){+.+.}-{3:3}, at: n_tty_read+0x19c/0x89c drivers/tty/n_tty.c:2177
1 lock held by syz-executor217/3091:
 #0: ffff0000c90930e0 (&type->s_umount_key#41){+.+.}-{3:3}, at: deactivate_super+0xc8/0xd4 fs/super.c:362
3 locks held by kworker/1:0/3113:
 #0: ffff0000c0010738 ((wq_completion)events){+.+.}-{0:0}, at: process_one_work+0x270/0x504 kernel/workqueue.c:2262
 #1: ffff800012703d80 ((work_completion)(&sci->sc_iput_work)){+.+.}-{0:0}, at: process_one_work+0x29c/0x504 kernel/workqueue.c:2264
 #2: ffff0000c9093650 (sb_internal#2){.+.+}-{0:0}, at: nilfs_evict_inode+0x94/0x1cc fs/nilfs2/inode.c:911

=============================================



---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
