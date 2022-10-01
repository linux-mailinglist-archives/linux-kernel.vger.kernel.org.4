Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E7D35F1C7E
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Oct 2022 15:47:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229629AbiJANrt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Oct 2022 09:47:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbiJANrn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Oct 2022 09:47:43 -0400
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62207ABD5C
        for <linux-kernel@vger.kernel.org>; Sat,  1 Oct 2022 06:47:42 -0700 (PDT)
Received: by mail-io1-f72.google.com with SMTP id a15-20020a6b660f000000b006a0d0794ad1so4411422ioc.6
        for <linux-kernel@vger.kernel.org>; Sat, 01 Oct 2022 06:47:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date;
        bh=oInPToETubw9qbmsXHkOW3CaEdCf6DsdV1dMZyMcoKg=;
        b=v2EA8BJrbM9s9zUVgATta+VeGBRfAInWnEd5n7gTOAilKvgEYN3wRYBHFca4PAV9yG
         /Bc/hPiRD4vU7pF9sW6V5lKxuBP+zNKkX3E6l0cbe11tlqHYnk205ww/HFaCvVmN1pJi
         KeUc07VKhQSwyvKvy2bl9fCTLNCnuzlhk004eW6ldncWngDPfoIgNEYRAa5jbukuxs8f
         deJ2ueptDeU90pPSslwrqvGe9Ft5jIEhA7CQtCdtvoT/s1XJwTUDwU9DwAiXr9jPyBY/
         ART7Y69WZU8gxISIH3IDGhfrrasfYO5ZoLK+VTp1DM9xNRSO8fHAIyZ1IMwkGQ8wpqof
         I86w==
X-Gm-Message-State: ACrzQf2sdYGOTkCOwtZ5sMlcnpUWi751X8a0bImv0b4iJ8Tw7Kv6L1en
        hCMUTrymdrCms3uUFjgupYQBSNvnfPWznM03qncLwF5Y3y0v
X-Google-Smtp-Source: AMsMyM6dEEMT24PJiUpYG6t0WOlEY3BpzI9WR6Ch0ZXhaOWHVQv7CFkbnnClHn4UPNbdJdfJoOg99D0cok3Roh8J6z54jGSmTbx1
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1b8a:b0:2f9:7d5d:e476 with SMTP id
 h10-20020a056e021b8a00b002f97d5de476mr1718699ili.183.1664632061619; Sat, 01
 Oct 2022 06:47:41 -0700 (PDT)
Date:   Sat, 01 Oct 2022 06:47:41 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b6f58d05e9f95a0c@google.com>
Subject: [syzbot] possible deadlock in mi_read
From:   syzbot <syzbot+bc7ca0ae4591cb2550f9@syzkaller.appspotmail.com>
To:     almaz.alexandrovich@paragon-software.com,
        linux-kernel@vger.kernel.org, ntfs3@lists.linux.dev,
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

syzbot found the following issue on:

HEAD commit:    bbed346d5a96 Merge branch 'for-next/core' into for-kernelci
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=111f3904880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=aae2d21e7dd80684
dashboard link: https://syzkaller.appspot.com/bug?extid=bc7ca0ae4591cb2550f9
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
userspace arch: arm64
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13a49000880000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14ace23f080000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/11078f50b80b/disk-bbed346d.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/398e5f1e6c84/vmlinux-bbed346d.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+bc7ca0ae4591cb2550f9@syzkaller.appspotmail.com

loop0: detected capacity change from 0 to 4096
ntfs3: loop0: Different NTFS' sector size (1024) and media sector size (512)
============================================
WARNING: possible recursive locking detected
6.0.0-rc7-syzkaller-18095-gbbed346d5a96 #0 Not tainted
--------------------------------------------
syz-executor243/3030 is trying to acquire lock:
ffff0000caa09ca0 (&ni->ni_lock/4){+.+.}-{3:3}, at: ni_lock fs/ntfs3/ntfs_fs.h:1108 [inline]
ffff0000caa09ca0 (&ni->ni_lock/4){+.+.}-{3:3}, at: mi_read+0x140/0x274 fs/ntfs3/record.c:148

but task is already holding lock:
ffff0000caa0d3e0 (&ni->ni_lock/4){+.+.}-{3:3}, at: ntfs_lookup+0x84/0xe8 fs/ntfs/namei.c:111

other info that might help us debug this:
 Possible unsafe locking scenario:

       CPU0
       ----
  lock(&ni->ni_lock/4);
  lock(&ni->ni_lock/4);

 *** DEADLOCK ***

 May be due to missing lock nesting notation

2 locks held by syz-executor243/3030:
 #0: ffff0000caa0d680 (&type->i_mutex_dir_key#6){++++}-{3:3}, at: inode_lock_shared include/linux/fs.h:766 [inline]
 #0: ffff0000caa0d680 (&type->i_mutex_dir_key#6){++++}-{3:3}, at: lookup_slow+0x34/0x68 fs/namei.c:1701
 #1: ffff0000caa0d3e0 (&ni->ni_lock/4){+.+.}-{3:3}, at: ntfs_lookup+0x84/0xe8 fs/ntfs/namei.c:111

stack backtrace:
CPU: 1 PID: 3030 Comm: syz-executor243 Not tainted 6.0.0-rc7-syzkaller-18095-gbbed346d5a96 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/26/2022
Call trace:
 dump_backtrace+0x1c4/0x1f0 arch/arm64/kernel/stacktrace.c:156
 show_stack+0x2c/0x54 arch/arm64/kernel/stacktrace.c:163
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x104/0x16c lib/dump_stack.c:106
 dump_stack+0x1c/0x58 lib/dump_stack.c:113
 __lock_acquire+0x808/0x30a4
 lock_acquire+0x100/0x1f8 kernel/locking/lockdep.c:5666
 __mutex_lock_common+0xd4/0xca8 kernel/locking/mutex.c:603
 __mutex_lock kernel/locking/mutex.c:747 [inline]
 mutex_lock_nested+0x38/0x44 kernel/locking/mutex.c:799
 ni_lock fs/ntfs3/ntfs_fs.h:1108 [inline]
 mi_read+0x140/0x274 fs/ntfs3/record.c:148
 ntfs_read_mft fs/ntfs3/inode.c:69 [inline]
 ntfs_iget5+0x15c/0x138c fs/ntfs3/inode.c:501
 dir_search_u+0x18c/0x1e0 fs/ntfs3/dir.c:264
 ntfs_lookup+0x94/0xe8 fs/ntfs/namei.c:111
 __lookup_slow+0x14c/0x204 fs/namei.c:1685
 lookup_slow+0x44/0x68 fs/namei.c:1702
 walk_component+0x178/0x1b0 fs/namei.c:1993
 lookup_last fs/namei.c:2450 [inline]
 path_lookupat+0xc4/0x208 fs/namei.c:2474
 filename_lookup+0xf8/0x264 fs/namei.c:2503
 user_path_at_empty+0x5c/0x114 fs/namei.c:2876
 user_path_at include/linux/namei.h:57 [inline]
 __do_sys_open_tree fs/namespace.c:2537 [inline]
 __se_sys_open_tree fs/namespace.c:2504 [inline]
 __arm64_sys_open_tree+0x130/0x4a4 fs/namespace.c:2504
 __invoke_syscall arch/arm64/kernel/syscall.c:38 [inline]
 invoke_syscall arch/arm64/kernel/syscall.c:52 [inline]
 el0_svc_common+0x138/0x220 arch/arm64/kernel/syscall.c:142
 do_el0_svc+0x48/0x164 arch/arm64/kernel/syscall.c:206
 el0_svc+0x58/0x150 arch/arm64/kernel/entry-common.c:636
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
