Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D187647CC7
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 05:05:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229500AbiLIEBi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 23:01:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229865AbiLIEBU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 23:01:20 -0500
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10298B3DBA
        for <linux-kernel@vger.kernel.org>; Thu,  8 Dec 2022 20:00:54 -0800 (PST)
Received: by mail-il1-f200.google.com with SMTP id x10-20020a056e021bca00b00302b6c0a683so2986458ilv.23
        for <linux-kernel@vger.kernel.org>; Thu, 08 Dec 2022 20:00:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YSwaBNASf/XaKNIWXNCuf6xPOT92jeHUWF4JiDHmLTc=;
        b=F0j6vhoxKEPcuk/fPO+hnez64zKNi1IldWYkG0kgnxGmRw3NNpgjdmn1ZZ3dmiXURc
         rLIWGt8yS9ixso7mwNe4JpyC3SOm1g+j7qx3GLrjJSvtCoxwR0gByRJnUgNW24qhlsEK
         4L1FoGNh8KtHvnz9NaNiWvjllvhBM71WEZeoGuIfO8gljrcYmQIEkdkviuOZ1P20oLdI
         +modbJir2YB4P/03EAEjoC/Nun/ZPTC/DdWT2recqhiU90mJBLD9aI7bXiiekB62DZhQ
         cXWRsEXZie7jci7nGFQWmmYMnFJZEeJYmfPTVojWPQSDXVfOwcKm6E9zW79utRUvgFQH
         kWyw==
X-Gm-Message-State: ANoB5pk7XvPD6xU9S7gEhCYUmm1PZ+kDInXyOiNDPA4+siNNed4hfRIv
        sXeZH9o5FvoBxMOuQAjPh7JaDYkJe9ODaFjHUvQNOteMtdnN
X-Google-Smtp-Source: AA0mqf7jnybrFQJrsBtL7xe3RCh595HHrdToEfyWH6pxxgSG588Jnda7e+f2TWbanPIwYM/0wY1DTpedDWLS3B1EiTH/ib9zVT8z
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:144:b0:303:48f7:f0ac with SMTP id
 j4-20020a056e02014400b0030348f7f0acmr10968425ilr.166.1670558453444; Thu, 08
 Dec 2022 20:00:53 -0800 (PST)
Date:   Thu, 08 Dec 2022 20:00:53 -0800
In-Reply-To: <000000000000e2102c05eeaf9113@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000031b80705ef5d33d1@google.com>
Subject: Re: [syzbot] possible deadlock in ntfs_fiemap
From:   syzbot <syzbot+96cee7d33ca3f87eee86@syzkaller.appspotmail.com>
To:     almaz.alexandrovich@paragon-software.com,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        nathan@kernel.org, ndesaulniers@google.com, ntfs3@lists.linux.dev,
        syzkaller-bugs@googlegroups.com, trix@redhat.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SORTED_RECIPS,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has found a reproducer for the following issue on:

HEAD commit:    f3e8416619ce Merge tag 'soc-fixes-6.1-5' of git://git.kern..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=10e21467880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d58e7fe7f9cf5e24
dashboard link: https://syzkaller.appspot.com/bug?extid=96cee7d33ca3f87eee86
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=116f8843880000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11646857880000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/628abc27cbe7/disk-f3e84166.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/2f19ea836174/vmlinux-f3e84166.xz
kernel image: https://storage.googleapis.com/syzbot-assets/f2e1347e85a5/bzImage-f3e84166.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/d38a9877608a/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+96cee7d33ca3f87eee86@syzkaller.appspotmail.com

======================================================
WARNING: possible circular locking dependency detected
6.1.0-rc8-syzkaller-00035-gf3e8416619ce #0 Not tainted
------------------------------------------------------
syz-executor145/3632 is trying to acquire lock:
ffff88801981bb58 (&mm->mmap_lock#2){++++}-{3:3}, at: __might_fault+0x8f/0x110 mm/memory.c:5644

but task is already holding lock:
ffff88807288d220 (&ni->ni_lock/4){+.+.}-{3:3}, at: ni_lock fs/ntfs3/ntfs_fs.h:1108 [inline]
ffff88807288d220 (&ni->ni_lock/4){+.+.}-{3:3}, at: ntfs_fiemap+0x101/0x180 fs/ntfs3/file.c:1243

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #1 (&ni->ni_lock/4){+.+.}-{3:3}:
       lock_acquire+0x182/0x3c0 kernel/locking/lockdep.c:5668
       __mutex_lock_common+0x1bd/0x26e0 kernel/locking/mutex.c:603
       __mutex_lock kernel/locking/mutex.c:747 [inline]
       mutex_lock_nested+0x17/0x20 kernel/locking/mutex.c:799
       ni_lock fs/ntfs3/ntfs_fs.h:1108 [inline]
       attr_data_get_block+0x301/0x2370 fs/ntfs3/attrib.c:917
       ntfs_file_mmap+0x48c/0x730 fs/ntfs3/file.c:387
       call_mmap include/linux/fs.h:2204 [inline]
       mmap_region+0xfe6/0x1e20 mm/mmap.c:2622
       do_mmap+0x8d9/0xf30 mm/mmap.c:1412
       vm_mmap_pgoff+0x19e/0x2b0 mm/util.c:520
       ksys_mmap_pgoff+0x48c/0x6d0 mm/mmap.c:1458
       do_syscall_x64 arch/x86/entry/common.c:50 [inline]
       do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
       entry_SYSCALL_64_after_hwframe+0x63/0xcd

-> #0 (&mm->mmap_lock#2){++++}-{3:3}:
       check_prev_add kernel/locking/lockdep.c:3097 [inline]
       check_prevs_add kernel/locking/lockdep.c:3216 [inline]
       validate_chain+0x1898/0x6ae0 kernel/locking/lockdep.c:3831
       __lock_acquire+0x1292/0x1f60 kernel/locking/lockdep.c:5055
       lock_acquire+0x182/0x3c0 kernel/locking/lockdep.c:5668
       __might_fault+0xb2/0x110 mm/memory.c:5645
       _copy_to_user+0x26/0x130 lib/usercopy.c:29
       copy_to_user include/linux/uaccess.h:169 [inline]
       fiemap_fill_next_extent+0x22e/0x410 fs/ioctl.c:144
       ni_fiemap+0xf57/0x1130 fs/ntfs3/frecord.c:1934
       ntfs_fiemap+0x134/0x180 fs/ntfs3/file.c:1245
       ioctl_fiemap fs/ioctl.c:219 [inline]
       do_vfs_ioctl+0x187f/0x29a0 fs/ioctl.c:810
       __do_sys_ioctl fs/ioctl.c:868 [inline]
       __se_sys_ioctl+0x83/0x170 fs/ioctl.c:856
       do_syscall_x64 arch/x86/entry/common.c:50 [inline]
       do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
       entry_SYSCALL_64_after_hwframe+0x63/0xcd

other info that might help us debug this:

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&ni->ni_lock/4);
                               lock(&mm->mmap_lock#2);
                               lock(&ni->ni_lock/4);
  lock(&mm->mmap_lock#2);

 *** DEADLOCK ***

1 lock held by syz-executor145/3632:
 #0: ffff88807288d220 (&ni->ni_lock/4){+.+.}-{3:3}, at: ni_lock fs/ntfs3/ntfs_fs.h:1108 [inline]
 #0: ffff88807288d220 (&ni->ni_lock/4){+.+.}-{3:3}, at: ntfs_fiemap+0x101/0x180 fs/ntfs3/file.c:1243

stack backtrace:
CPU: 0 PID: 3632 Comm: syz-executor145 Not tainted 6.1.0-rc8-syzkaller-00035-gf3e8416619ce #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/26/2022
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x1b1/0x28e lib/dump_stack.c:106
 check_noncircular+0x2cc/0x390 kernel/locking/lockdep.c:2177
 check_prev_add kernel/locking/lockdep.c:3097 [inline]
 check_prevs_add kernel/locking/lockdep.c:3216 [inline]
 validate_chain+0x1898/0x6ae0 kernel/locking/lockdep.c:3831
 __lock_acquire+0x1292/0x1f60 kernel/locking/lockdep.c:5055
 lock_acquire+0x182/0x3c0 kernel/locking/lockdep.c:5668
 __might_fault+0xb2/0x110 mm/memory.c:5645
 _copy_to_user+0x26/0x130 lib/usercopy.c:29
 copy_to_user include/linux/uaccess.h:169 [inline]
 fiemap_fill_next_extent+0x22e/0x410 fs/ioctl.c:144
 ni_fiemap+0xf57/0x1130 fs/ntfs3/frecord.c:1934
 ntfs_fiemap+0x134/0x180 fs/ntfs3/file.c:1245
 ioctl_fiemap fs/ioctl.c:219 [inline]
 do_vfs_ioctl+0x187f/0x29a0 fs/ioctl.c:810
 __do_sys_ioctl fs/ioctl.c:868 [inline]
 __se_sys_ioctl+0x83/0x170 fs/ioctl.c:856
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f84c755aca9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 51 14 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffdcb203e18 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f84c755aca9
RDX: 0000000020000040 RSI: 00000000c020660b RDI: 0000000000000006
RBP: 00007f84c751a2b0 R08: 0000000000000000 R09: 0000000000000000

