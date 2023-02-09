Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87E49690195
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 08:50:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229701AbjBIHuV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 02:50:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229602AbjBIHuU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 02:50:20 -0500
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84DB810AB8
        for <linux-kernel@vger.kernel.org>; Wed,  8 Feb 2023 23:50:18 -0800 (PST)
Received: by mail-il1-f197.google.com with SMTP id s12-20020a056e021a0c00b0030efd0ed890so1095043ild.7
        for <linux-kernel@vger.kernel.org>; Wed, 08 Feb 2023 23:50:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZJ/37gqMHW+8XhfCwTsdR8Neup6tgWMZ3eUrRM0/XYs=;
        b=FavxxglcqvHc0qKFU1g5dZjyqCXShKbwVnBDuo3YAPCE7nK/sJxgAjjR1MdQ039jks
         T9jpMOq3U5t7tYNhNb6mDES8NYguY4+e1CV+5IJKe3tr8qpUAX6Rrm5kjsUWPHPBJkMd
         l5QL2paSbyWC5IG4AWVzwKbaa8xbkbRrvp1HW0Jl5jJJmOzxsye6hpten1vk+0Cnix2s
         vvL9X6BeR/LcO+G9kp+bn05UufzT7dixkcfEQJGegGxblGDx3bD84KFDmbyM17ZWwLCK
         nxK26x/QCpkJ5xQ06hIBN5rdGQjIT3qkQMaYdFG+bTRp8ckY5QCY95x98FOuMh70/g+o
         cGhQ==
X-Gm-Message-State: AO0yUKVZ5J0oGEoWHo4+ZVceJLESzoBeYDQr4UqGb3/61MVorwpTKG7V
        e/kOnx811/VDg4aw7SRy44PvfjswYFRVKfYh0jRQGf1XGQ9Y
X-Google-Smtp-Source: AK7set8SfXhCqi5D2jA2jHfP7TOyjRF6pj/wqXPfXqBic5vh+hBJGc+QFrTEv8u0QAPud45m7obynsUxXq6ouKJhI9huXiaNJ+CO
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:bc6:b0:313:d39f:f63 with SMTP id
 c6-20020a056e020bc600b00313d39f0f63mr5979815ilu.3.1675929017886; Wed, 08 Feb
 2023 23:50:17 -0800 (PST)
Date:   Wed, 08 Feb 2023 23:50:17 -0800
In-Reply-To: <20230209073104.2276-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c7b28d05f43fa1ce@google.com>
Subject: Re: [syzbot] INFO: rcu detected stall in ext4_file_write_iter (6)
From:   syzbot <syzbot+b9564ba6e8e00694511b@syzkaller.appspotmail.com>
To:     hdanton@sina.com, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
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

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
INFO: rcu detected stall in corrupted

rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
rcu: 	Tasks blocked on level-0 rcu_node (CPUs 0-1): P12/1:b..l
rcu: 	(detected by 1, t=10502 jiffies, g=11233, q=127 ncpus=2)
task:kworker/u4:1    state:R  running task     stack:24944 pid:12    ppid:2      flags:0x00004000
Workqueue: bat_events batadv_nc_worker
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5301 [inline]
 __schedule+0x245a/0x5a60 kernel/sched/core.c:6619
 preempt_schedule_notrace+0x5f/0xd0 kernel/sched/core.c:6881
 preempt_schedule_notrace_thunk+0x1a/0x20 arch/x86/entry/thunk_64.S:35
 rcu_read_unlock_sched_notrace include/linux/rcupdate.h:895 [inline]
 trace_lock_acquire+0x1e7/0x2b0 include/trace/events/lock.h:24
 lock_acquire+0x32/0xc0 kernel/locking/lockdep.c:5662
 rcu_lock_acquire include/linux/rcupdate.h:327 [inline]
 rcu_read_lock include/linux/rcupdate.h:773 [inline]
 batadv_nc_purge_orig_hash net/batman-adv/network-coding.c:408 [inline]
 batadv_nc_worker+0x131/0xfe0 net/batman-adv/network-coding.c:719
 process_one_work+0x9bf/0x1820 kernel/workqueue.c:2390
 worker_thread+0x669/0x1090 kernel/workqueue.c:2537
 kthread+0x2e8/0x3a0 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:308
 </TASK>
rcu: rcu_preempt kthread starved for 10510 jiffies! g11233 f0x0 RCU_GP_WAIT_FQS(5) ->state=0x0 ->cpu=1
rcu: 	Unless rcu_preempt kthread gets sufficient CPU time, OOM is now expected behavior.
rcu: RCU grace-period kthread stack dump:
task:rcu_preempt     state:R  running task     stack:28680 pid:16    ppid:2      flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5301 [inline]
 __schedule+0x245a/0x5a60 kernel/sched/core.c:6619
 schedule+0xde/0x1a0 kernel/sched/core.c:6695
 schedule_timeout+0x14e/0x2b0 kernel/time/timer.c:2167
 rcu_gp_fqs_loop+0x190/0x910 kernel/rcu/tree.c:1609
 rcu_gp_kthread+0x23a/0x360 kernel/rcu/tree.c:1808
 kthread+0x2e8/0x3a0 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:308
 </TASK>
rcu: Stack dump where RCU GP kthread last ran:
CPU: 1 PID: 5741 Comm: syz-executor.2 Not tainted 6.2.0-rc6-next-20230203-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/21/2023
RIP: 0010:lock_acquire.part.0+0x156/0x370 kernel/locking/lockdep.c:5656
Code: b8 ff ff ff ff 65 0f c1 05 07 84 9c 7e 83 f8 01 0f 85 c7 01 00 00 9c 58 f6 c4 02 0f 85 da 01 00 00 48 85 ed 0f 85 ad 01 00 00 <48> b8 00 00 00 00 00 fc ff df 48 01 c3 48 c7 03 00 00 00 00 48 c7
RSP: 0018:ffffc90005a8f238 EFLAGS: 00000206
RAX: 0000000000000046 RBX: 1ffff92000b51e48 RCX: ffffffff8165aaa6
RDX: 1ffff11005511896 RSI: 0000000000000001 RDI: 0000000000000000
RBP: 0000000000000200 R08: 0000000000000000 R09: ffffffff913e4c1f
R10: fffffbfff227c983 R11: 0000000000000000 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: ffff88802a48a0d8
FS:  00007f2908784700(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f2907b15829 CR3: 0000000028780000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 __raw_write_lock include/linux/rwlock_api_smp.h:209 [inline]
 _raw_write_lock+0x2e/0x40 kernel/locking/spinlock.c:300
 jbd2_log_start_commit+0x23/0x50 fs/jbd2/journal.c:521
 jbd2_journal_stop+0x53b/0xfd0 fs/jbd2/transaction.c:1932
 __ext4_journal_stop+0xe2/0x1f0 fs/ext4/ext4_jbd2.c:133
 ext4_dirty_inode+0xf1/0x130 fs/ext4/inode.c:6111
 __mark_inode_dirty+0x247/0x1250 fs/fs-writeback.c:2421
 mark_inode_dirty include/linux/fs.h:2127 [inline]
 generic_write_end+0x354/0x440 fs/buffer.c:2227
 ext4_da_write_end+0x1f5/0xa50 fs/ext4/inode.c:3174
 generic_perform_write+0x316/0x570 mm/filemap.c:3781
 ext4_buffered_write_iter+0x15b/0x460 fs/ext4/file.c:285
 ext4_file_write_iter+0x8bf/0x1710 fs/ext4/file.c:700
 call_write_iter include/linux/fs.h:1851 [inline]
 do_iter_readv_writev+0x20b/0x3b0 fs/read_write.c:735
 do_iter_write+0x182/0x700 fs/read_write.c:861
 vfs_iter_write+0x74/0xa0 fs/read_write.c:902
 iter_file_splice_write+0x745/0xc90 fs/splice.c:686
 do_splice_from fs/splice.c:764 [inline]
 direct_splice_actor+0x114/0x180 fs/splice.c:931
 splice_direct_to_actor+0x335/0x8a0 fs/splice.c:886
 do_splice_direct+0x1ab/0x280 fs/splice.c:974
 do_sendfile+0xb19/0x12c0 fs/read_write.c:1255
 __do_sys_sendfile64 fs/read_write.c:1317 [inline]
 __se_sys_sendfile64 fs/read_write.c:1309 [inline]
 __x64_sys_sendfile64+0x14d/0x210 fs/read_write.c:1309
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f2907a8c0c9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 f1 19 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f2908784168 EFLAGS: 00000246 ORIG_RAX: 0000000000000028
RAX: ffffffffffffffda RBX: 00007f2907babf80 RCX: 00007f2907a8c0c9
RDX: 00000000200001c0 RSI: 0000000000000003 RDI: 0000000000000003
RBP: 00007f2907ae7ae9 R08: 0000000000000000 R09: 0000000000000000
R10: 000000000200a198 R11: 0000000000000246 R12: 0000000000000000
R13: 00007fffcafd348f R14: 00007f2908784300 R15: 0000000000022000
 </TASK>


Tested on:

commit:         4fafd969 Add linux-next specific files for 20230203
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
console output: https://syzkaller.appspot.com/x/log.txt?x=17a0d91f480000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1d2fba7d42502ca4
dashboard link: https://syzkaller.appspot.com/bug?extid=b9564ba6e8e00694511b
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=12e562fb480000

