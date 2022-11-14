Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62F57627B1C
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 11:55:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235905AbiKNKza (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 05:55:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235948AbiKNKz0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 05:55:26 -0500
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E32B4A19F
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 02:55:22 -0800 (PST)
Received: by mail-io1-f69.google.com with SMTP id r197-20020a6b8fce000000b006c3fc33424dso5572361iod.5
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 02:55:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rPHirDNYZGOb9G0F4uhvferJfA0hAYFD9vf7BKRoDk0=;
        b=LZ9qt4ZlpjlOSYhrmbryfNmUl+zYedUhyoXG0R8O4ePCmxT6jJR/u3ztVSS5pTlxxk
         fbhElCyxvQzfmMj5tLCvEimbGI+Oqgjakv/4No6jFLJSJC1dtKbbKpE6HZ1nPgdl7Fur
         uRQILR7CkO55Qi4gCajHwSy3acqqr02Jp2UX+4c5dJMRfXaONqwIKxoYfzOziTZE783Q
         eirRJobvyX6Elr3NV+6VeaJ44hJ4j3dMtdOkZdxCE7oTYJIxIdHHRXR8lS3AmPOFl/Iw
         9EpT+pcdZcOCz9159V9F8lpY9XEpsG0gQgdvvfQQHaS7UJp+0c5PDR57lPA9fuKaGV+c
         5WxQ==
X-Gm-Message-State: ANoB5pmx2tzf8sVefOwdzYruRo4mDBDWlCaMotkECGn5K4HVHKWWBwje
        ESDOazechCj+dtA33YsmHB1kt1ceGjsz80h3LyzshcuD5z7e
X-Google-Smtp-Source: AA0mqf4GdpZ10adCvarMJOcpxEwyu3PXZcdSGhLPkzK4dSKkbnJ/vdibWqO/X5xkE27Jt7HxQrMy+ZHvZLAKf7NklcJBCXtqtC5p
MIME-Version: 1.0
X-Received: by 2002:a92:dc82:0:b0:2fc:b8b7:484e with SMTP id
 c2-20020a92dc82000000b002fcb8b7484emr5920683iln.122.1668423322222; Mon, 14
 Nov 2022 02:55:22 -0800 (PST)
Date:   Mon, 14 Nov 2022 02:55:22 -0800
In-Reply-To: <20221114094900.2080-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000074c83e05ed6c135c@google.com>
Subject: Re: [syzbot] WARNING in anon_vma_name
From:   syzbot <syzbot+62ed954113bf02c79f74@syzkaller.appspotmail.com>
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
possible deadlock in show_map_vma

============================================
WARNING: possible recursive locking detected
6.1.0-rc4-next-20221111-syzkaller-dirty #0 Not tainted
--------------------------------------------
syz-executor.0/5772 is trying to acquire lock:
ffff88807dd89b98 (&mm->mmap_lock){++++}-{3:3}, at: mmap_read_lock_killable include/linux/mmap_lock.h:126 [inline]
ffff88807dd89b98 (&mm->mmap_lock){++++}-{3:3}, at: show_map_vma+0x1dd/0x8a0 fs/proc/task_mmu.c:298

but task is already holding lock:
ffff88807dd89b98 (&mm->mmap_lock){++++}-{3:3}, at: mmap_read_lock_killable include/linux/mmap_lock.h:126 [inline]
ffff88807dd89b98 (&mm->mmap_lock){++++}-{3:3}, at: m_start+0x1d6/0x670 fs/proc/task_mmu.c:162

other info that might help us debug this:
 Possible unsafe locking scenario:

       CPU0
       ----
  lock(&mm->mmap_lock);
  lock(&mm->mmap_lock);

 *** DEADLOCK ***

 May be due to missing lock nesting notation

2 locks held by syz-executor.0/5772:
 #0: ffff88801d4c28b8 (&p->lock){+.+.}-{3:3}, at: seq_read_iter+0xdf/0x1280 fs/seq_file.c:182
 #1: ffff88807dd89b98 (&mm->mmap_lock){++++}-{3:3}, at: mmap_read_lock_killable include/linux/mmap_lock.h:126 [inline]
 #1: ffff88807dd89b98 (&mm->mmap_lock){++++}-{3:3}, at: m_start+0x1d6/0x670 fs/proc/task_mmu.c:162

stack backtrace:
CPU: 1 PID: 5772 Comm: syz-executor.0 Not tainted 6.1.0-rc4-next-20221111-syzkaller-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/26/2022
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:106
 print_deadlock_bug kernel/locking/lockdep.c:2990 [inline]
 check_deadlock kernel/locking/lockdep.c:3033 [inline]
 validate_chain kernel/locking/lockdep.c:3818 [inline]
 __lock_acquire.cold+0x116/0x3a7 kernel/locking/lockdep.c:5055
 lock_acquire kernel/locking/lockdep.c:5668 [inline]
 lock_acquire+0x1df/0x630 kernel/locking/lockdep.c:5633
 down_read_killable+0x9b/0x490 kernel/locking/rwsem.c:1532
 mmap_read_lock_killable include/linux/mmap_lock.h:126 [inline]
 show_map_vma+0x1dd/0x8a0 fs/proc/task_mmu.c:298
 show_smap+0xe4/0x490 fs/proc/task_mmu.c:873
 traverse.part.0+0xcf/0x5f0 fs/seq_file.c:111
 traverse fs/seq_file.c:101 [inline]
 seq_read_iter+0x90f/0x1280 fs/seq_file.c:195
 seq_read+0x16d/0x210 fs/seq_file.c:162
 do_loop_readv_writev fs/read_write.c:756 [inline]
 do_loop_readv_writev fs/read_write.c:743 [inline]
 do_iter_read+0x4f8/0x750 fs/read_write.c:798
 vfs_readv+0xe5/0x150 fs/read_write.c:916
 do_preadv fs/read_write.c:1008 [inline]
 __do_sys_preadv fs/read_write.c:1058 [inline]
 __se_sys_preadv fs/read_write.c:1053 [inline]
 __x64_sys_preadv+0x22b/0x310 fs/read_write.c:1053
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7fdc27c8b639
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fdc28980168 EFLAGS: 00000246 ORIG_RAX: 0000000000000127
RAX: ffffffffffffffda RBX: 00007fdc27dabf80 RCX: 00007fdc27c8b639
RDX: 0000000000000001 RSI: 00000000200006c0 RDI: 0000000000000003
RBP: 00007fdc27ce67e1 R08: 0000000000000000 R09: 0000000000000000
R10: 00000000fffffffe R11: 0000000000000246 R12: 0000000000000000
R13: 00007ffc20c7d9af R14: 00007fdc28980300 R15: 0000000000022000
 </TASK>


Tested on:

commit:         f8f60f32 Add linux-next specific files for 20221111
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
console output: https://syzkaller.appspot.com/x/log.txt?x=13a0e2f1880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=85ba52c07cd97289
dashboard link: https://syzkaller.appspot.com/bug?extid=62ed954113bf02c79f74
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1069e0f1880000

