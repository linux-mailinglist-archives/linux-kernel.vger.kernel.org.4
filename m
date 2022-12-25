Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21602655D95
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Dec 2022 16:51:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230366AbiLYPvt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Dec 2022 10:51:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229592AbiLYPvs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Dec 2022 10:51:48 -0500
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2D23261E
        for <linux-kernel@vger.kernel.org>; Sun, 25 Dec 2022 07:51:46 -0800 (PST)
Received: by mail-il1-f198.google.com with SMTP id o10-20020a056e02102a00b003006328df7bso5762807ilj.17
        for <linux-kernel@vger.kernel.org>; Sun, 25 Dec 2022 07:51:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8TrQckoKvz3w5GOc/SCODLpLecT+ozdvYKg/HaqgeK4=;
        b=yz+2203XcWFXdYiugEf8HmN9d585yylX/pN8mS3LQZ4LKXEMPvnK66Vz8WMG43nZJn
         hYQh7dhBeGfu1iTU/IYQx4SYKLfwYUo7DjEPe4l2d0NLClpquXu6ITZT2HIZqvAqTBtV
         IGA8AYXb5cw7ghuA/RoRBmJpwSkYnoKiOkEodDIVc0HQRZMhUOTsn9iJ+qQM9RLydYgF
         Xvf7XxstClH+OhnOlC2434jCV9i4tRTulZT0grPFCXbn+0F05cDj66ewxKYxb7tbN5z0
         plPTQfcLRDUJvVf0mLwYtOjhhql3CJBQh/nkZ90gYKY5hWJx1QOcoYY4YB5CQynBL/I2
         k7kg==
X-Gm-Message-State: AFqh2kqDNRFATvbwoP9soQJX/6bprMsn1VlLfhmEbe1bVWU0dtY9zdLL
        gbwT/tCyDQiHG+lH97ijWJBOLuWZcwNsjoTMJ3FA7axGFiQB
X-Google-Smtp-Source: AMrXdXvM/RGYXZpLup5ds5LVkKHdP6YaO5O1eaHxdKwrZOGkSbuuMGAMEGLbnA6vkfvY05fTo1gXqRhyl9LLp0VBv9lZ5sgSD26V
MIME-Version: 1.0
X-Received: by 2002:a92:cf43:0:b0:30b:c00c:24ce with SMTP id
 c3-20020a92cf43000000b0030bc00c24cemr1614093ilr.94.1671983506130; Sun, 25 Dec
 2022 07:51:46 -0800 (PST)
Date:   Sun, 25 Dec 2022 07:51:46 -0800
In-Reply-To: <0000000000007e22cb05dd7cbada@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f40e6d05f0a8fec7@google.com>
Subject: Re: [syzbot] [gfs2?] BUG: sleeping function called from invalid
 context in do_page_fault (3)
From:   syzbot <syzbot+2845b2dfa28dec36e215@syzkaller.appspotmail.com>
To:     agruenba@redhat.com, boqun.feng@gmail.com,
        cluster-devel@redhat.com, linux-kernel@vger.kernel.org,
        longman@redhat.com, mingo@redhat.com, peterz@infradead.org,
        rpeterso@redhat.com, syzkaller-bugs@googlegroups.com,
        will@kernel.org
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

HEAD commit:    a5541c0811a0 Merge branch 'for-next/core' into for-kernelci
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=11b79928480000
kernel config:  https://syzkaller.appspot.com/x/.config?x=cbd4e584773e9397
dashboard link: https://syzkaller.appspot.com/bug?extid=2845b2dfa28dec36e215
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
userspace arch: arm64
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=156dcd50480000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1337f2e4480000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/4b7702208fb9/disk-a5541c08.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/9ec0153ec051/vmlinux-a5541c08.xz
kernel image: https://storage.googleapis.com/syzbot-assets/6f8725ad290a/Image-a5541c08.gz.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/9d323fcb08fb/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+2845b2dfa28dec36e215@syzkaller.appspotmail.com

gfs2: fsid=syz:syz.0:  H: s:SH f:H e:0 p:4002 [syz-executor363] __gfs2_lookup+0x5c/0x1dc fs/gfs2/inode.c:870
BUG: sleeping function called from invalid context at arch/arm64/mm/fault.c:599
in_atomic(): 0, irqs_disabled(): 0, non_block: 0, pid: 4011, name: syz-executor363
preempt_count: 0, expected: 0
RCU nest depth: 1, expected: 0
3 locks held by syz-executor363/4011:
 #0: 
ffff0000cfa98dd0
 (
&type->i_mutex_dir_key
#8
){.+.+}-{3:3}
, at: inode_lock_shared include/linux/fs.h:766 [inline]
, at: open_last_lookups fs/namei.c:3480 [inline]
, at: path_openat+0x2e4/0x11c4 fs/namei.c:3711
 #1: 
ffff80000d4a4640
 (
rcu_read_lock
){....}-{1:2}, at: rcu_lock_acquire+0x10/0x4c include/linux/rcupdate.h:303
 #2: 
ffff0000c0e15648
 (
&mm->mmap_lock){++++}-{3:3}, at: mmap_read_trylock include/linux/mmap_lock.h:136 [inline]
&mm->mmap_lock){++++}-{3:3}, at: do_page_fault+0x1ec/0x79c arch/arm64/mm/fault.c:589
CPU: 1 PID: 4011 Comm: syz-executor363 Not tainted 6.1.0-rc8-syzkaller-33330-ga5541c0811a0 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/26/2022
Call trace:
 dump_backtrace+0x1c4/0x1f0 arch/arm64/kernel/stacktrace.c:156
 show_stack+0x2c/0x3c arch/arm64/kernel/stacktrace.c:163
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x104/0x16c lib/dump_stack.c:106
 dump_stack+0x1c/0x58 lib/dump_stack.c:113
 __might_resched+0x208/0x218 kernel/sched/core.c:9908
 __might_sleep+0x48/0x78 kernel/sched/core.c:9837
 do_page_fault+0x214/0x79c arch/arm64/mm/fault.c:599
 do_translation_fault+0x78/0x194 arch/arm64/mm/fault.c:691
 do_mem_abort+0x54/0x130 arch/arm64/mm/fault.c:827
 el1_abort+0x3c/0x5c arch/arm64/kernel/entry-common.c:367
 el1h_64_sync_handler+0x60/0xac arch/arm64/kernel/entry-common.c:427
 el1h_64_sync+0x64/0x68 arch/arm64/kernel/entry.S:579
 rcu_read_lock include/linux/rcupdate.h:739 [inline]
 dump_holder fs/gfs2/glock.c:2332 [inline]
 gfs2_dump_glock+0x4f4/0x904 fs/gfs2/glock.c:2447
 gfs2_consist_inode_i+0x68/0x88 fs/gfs2/util.c:465
 gfs2_dirent_scan+0x2dc/0x3b4 fs/gfs2/dir.c:602
 gfs2_dirent_search+0x134/0x494 fs/gfs2/dir.c:850
 gfs2_dir_search+0x58/0x130 fs/gfs2/dir.c:1650
 gfs2_lookupi+0x23c/0x354 fs/gfs2/inode.c:323
 __gfs2_lookup+0x5c/0x1dc fs/gfs2/inode.c:870
 gfs2_atomic_open+0x74/0x148 fs/gfs2/inode.c:1274
 atomic_open fs/namei.c:3276 [inline]
 lookup_open fs/namei.c:3384 [inline]
 open_last_lookups fs/namei.c:3481 [inline]
 path_openat+0x67c/0x11c4 fs/namei.c:3711
 do_filp_open+0xdc/0x1b8 fs/namei.c:3741
 do_sys_openat2+0xb8/0x22c fs/open.c:1310
 do_sys_open fs/open.c:1326 [inline]
 __do_sys_openat fs/open.c:1342 [inline]
 __se_sys_openat fs/open.c:1337 [inline]
 __arm64_sys_openat+0xb0/0xe0 fs/open.c:1337
 __invoke_syscall arch/arm64/kernel/syscall.c:38 [inline]
 invoke_syscall arch/arm64/kernel/syscall.c:52 [inline]
 el0_svc_common+0x138/0x220 arch/arm64/kernel/syscall.c:142
 do_el0_svc+0x48/0x140 arch/arm64/kernel/syscall.c:197
 el0_svc+0x58/0x150 arch/arm64/kernel/entry-common.c:637
 el0t_64_sync_handler+0x84/0xf0 arch/arm64/kernel/entry-common.c:655
 el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:584
Unable to handle kernel NULL pointer dereference at virtual address 0000000000000021
Mem abort info:
  ESR = 0x0000000096000006
  EC = 0x25: DABT (current EL), IL = 32 bits
  SET = 0, FnV = 0
  EA = 0, S1PTW = 0
  FSC = 0x06: level 2 translation fault
Data abort info:
  ISV = 0, ISS = 0x00000006
  CM = 0, WnR = 0
user pgtable: 4k pages, 48-bit VAs, pgdp=0000000113364000
[0000000000000021] pgd=0800000111d8b003, p4d=0800000111d8b003, pud=0800000111d8c003, pmd=0000000000000000
Internal error: Oops: 0000000096000006 [#1] PREEMPT SMP
Modules linked in:
CPU: 1 PID: 4011 Comm: syz-executor363 Tainted: G        W          6.1.0-rc8-syzkaller-33330-ga5541c0811a0 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/26/2022
pstate: 80400005 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : pid_is_meaningful fs/gfs2/glock.c:1464 [inline]
pc : dump_holder fs/gfs2/glock.c:2333 [inline]
pc : gfs2_dump_glock+0x4f4/0x904 fs/gfs2/glock.c:2447
lr : rcu_read_lock include/linux/rcupdate.h:739 [inline]
lr : dump_holder fs/gfs2/glock.c:2332 [inline]
lr : gfs2_dump_glock+0x498/0x904 fs/gfs2/glock.c:2447
sp : ffff800013503600
x29: ffff8000135037d0 x28: ffff80000cd3bac3 x27: ffff0000d1c12218
x26: 0000000000000fa2 x25: ffff8000135037a1 x24: ffff0000d07809a0
x23: 0000000000000001 x22: 0000000000000040 x21: ffff80000d4a4640
x20: ffff80000d95c000 x19: ffff0000d0780a20 x18: 00000000000003a2
x17: 000000000000b67e x16: ffff80000dbe6158 x15: ffff0000d07f9a40
x14: 0000000000000000 x13: 00000000ffffffff x12: ffff0000d07f9a40
x11: ff8080000926ce78 x10: 0000000000000000 x9 : ffff80000926ce78
x8 : ffff0000d07f9a40 x7 : ffff800009273590 x6 : 0000000000000000
x5 : 0000000000000000 x4 : 0000000000000000 x3 : 0000000000000002
x2 : 0000000000000008 x1 : ffff80000ce893cb x0 : 0000000000000001
Call trace:
 rcu_read_lock include/linux/rcupdate.h:739 [inline]
 dump_holder fs/gfs2/glock.c:2332 [inline]
 gfs2_dump_glock+0x4f4/0x904 fs/gfs2/glock.c:2447
 gfs2_consist_inode_i+0x68/0x88 fs/gfs2/util.c:465
 gfs2_dirent_scan+0x2dc/0x3b4 fs/gfs2/dir.c:602
 gfs2_dirent_search+0x134/0x494 fs/gfs2/dir.c:850
 gfs2_dir_search+0x58/0x130 fs/gfs2/dir.c:1650
 gfs2_lookupi+0x23c/0x354 fs/gfs2/inode.c:323
 __gfs2_lookup+0x5c/0x1dc fs/gfs2/inode.c:870
 gfs2_atomic_open+0x74/0x148 fs/gfs2/inode.c:1274
 atomic_open fs/namei.c:3276 [inline]
 lookup_open fs/namei.c:3384 [inline]
 open_last_lookups fs/namei.c:3481 [inline]
 path_openat+0x67c/0x11c4 fs/namei.c:3711
 do_filp_open+0xdc/0x1b8 fs/namei.c:3741
 do_sys_openat2+0xb8/0x22c fs/open.c:1310
 do_sys_open fs/open.c:1326 [inline]
 __do_sys_openat fs/open.c:1342 [inline]
 __se_sys_openat fs/open.c:1337 [inline]
 __arm64_sys_openat+0xb0/0xe0 fs/open.c:1337
 __invoke_syscall arch/arm64/kernel/syscall.c:38 [inline]
 invoke_syscall arch/arm64/kernel/syscall.c:52 [inline]
 el0_svc_common+0x138/0x220 arch/arm64/kernel/syscall.c:142
 do_el0_svc+0x48/0x140 arch/arm64/kernel/syscall.c:197
 el0_svc+0x58/0x150 arch/arm64/kernel/entry-common.c:637
 el0t_64_sync_handler+0x84/0xf0 arch/arm64/kernel/entry-common.c:655
 el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:584
Code: 91178800 9117ec42 391e2688 97bcdabc (794042f4) 
---[ end trace 0000000000000000 ]---
----------------
Code disassembly (best guess):
   0:	91178800 	add	x0, x0, #0x5e2
   4:	9117ec42 	add	x2, x2, #0x5fb
   8:	391e2688 	strb	w8, [x20, #1929]
   c:	97bcdabc 	bl	0xfffffffffef36afc
* 10:	794042f4 	ldrh	w20, [x23, #32] <-- trapping instruction

