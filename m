Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEEA66269B7
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Nov 2022 15:03:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234695AbiKLODt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Nov 2022 09:03:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231404AbiKLODs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Nov 2022 09:03:48 -0500
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB2FDD2F0
        for <linux-kernel@vger.kernel.org>; Sat, 12 Nov 2022 06:03:47 -0800 (PST)
Received: by mail-io1-f70.google.com with SMTP id c23-20020a6b4e17000000b006db1063fc9aso4537565iob.14
        for <linux-kernel@vger.kernel.org>; Sat, 12 Nov 2022 06:03:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GTNIDi4tuH2wjZZmdgphpOxC1TdVuhbw+c5p53uePaY=;
        b=GV7of3eJsODRFrgHsAYZ0AmXtwu/KtE1AiFLwG4Kl1RePOKuEwkuR2HDug2Q1I1LzY
         C5VLaZMIk+yR2jOY1WuA8NWcFhbyZmulVHfvjZq4JfXwx2or2aSrdEWLHGGbM+HIU4xz
         hudWRfcN6yGSGhfsEXo2D5T4a/JBVw2l45JtjRVGSm1ZUgrSx/TuSXKX0e+S/VDQveWf
         2bvzxI0MQiXgT8T15j/oTU6DjNvDfoTnRreWnBQ/MzY8ee7mBnvgF/8gENead2uagXsh
         Md3SPsC0ICMbjVzzGmHWktH4XusFR+InLgdP5CwRaj97P5mTqOFVB4iDNP6FzRHpzYIx
         sLZA==
X-Gm-Message-State: ANoB5pkB16BISqcsE2/UbrV9mqQPFqgHSBd1+t6MwJwcYJyN3VZGD1k5
        Doji2KHh2DgfvhBQA83TNnnrRcyP6nlzG8YTRI3foVM/fkqJ
X-Google-Smtp-Source: AA0mqf7OqKvHkIk5nZajIjM+0YJ2IiW1v+tPNhDVhoJY+LGQuDiVzBrzw9jJ5qcSZNyQ2m6Qjj7gIpKxu1A3/CnXVvPaSsQSYd+u
MIME-Version: 1.0
X-Received: by 2002:a02:3213:0:b0:374:c658:2141 with SMTP id
 j19-20020a023213000000b00374c6582141mr2502205jaa.210.1668261826887; Sat, 12
 Nov 2022 06:03:46 -0800 (PST)
Date:   Sat, 12 Nov 2022 06:03:46 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000009586e205ed4679f4@google.com>
Subject: [syzbot] WARNING: locking bug in hugetlb_no_page
From:   syzbot <syzbot+d07c65298d2c15eafcb0@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, llvm@lists.linux.dev, mike.kravetz@oracle.com,
        nathan@kernel.org, ndesaulniers@google.com,
        songmuchun@bytedance.com, syzkaller-bugs@googlegroups.com,
        trix@redhat.com
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

HEAD commit:    1621b6eaebf7 Merge branch 'for-next/fixes' into for-kernelci
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=13bd511e880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=606e57fd25c5c6cc
dashboard link: https://syzkaller.appspot.com/bug?extid=d07c65298d2c15eafcb0
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
userspace arch: arm64
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13315856880000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=173614d1880000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/82aa7741098d/disk-1621b6ea.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/f6be08c4e4c2/vmlinux-1621b6ea.xz
kernel image: https://storage.googleapis.com/syzbot-assets/296b6946258a/Image-1621b6ea.gz.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+d07c65298d2c15eafcb0@syzkaller.appspotmail.com

------------[ cut here ]------------
DEBUG_LOCKS_WARN_ON(!test_bit(class_idx, lock_classes_in_use))
WARNING: CPU: 1 PID: 3290 at kernel/locking/lockdep.c:5025 __lock_acquire+0x2758/0x3084
Modules linked in:
CPU: 1 PID: 3290 Comm: syz-executor317 Not tainted 6.1.0-rc4-syzkaller-31872-g1621b6eaebf7 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/30/2022
pstate: 604000c5 (nZCv daIF +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : __lock_acquire+0x2758/0x3084
lr : __lock_acquire+0x2754/0x3084 kernel/locking/lockdep.c:5025
sp : ffff800012e3b3e0
x29: ffff800012e3b4c0 x28: 0000000000000001 x27: ffff0000cb891a68
x26: ffff0000cb892450 x25: ffff0000cb892470 x24: ffff0000cb892470
x23: 00000000000000c0 x22: 0000000000000001 x21: 0000000000000000
x20: ffff0000cb891a40 x19: aaaaaa0000fb22ca x18: 0000000000000358
x17: ffff80000c04d83c x16: 0000000000000000 x15: 0000000000000000
x14: 0000000000000000 x13: 0000000000000012 x12: ffff80000d86ff30
x11: ff808000081c06c8 x10: 0000000000000000 x9 : ddc86c2f228f9600
x8 : ddc86c2f228f9600 x7 : 4e5241575f534b43 x6 : ffff80000c01775c
x5 : 0000000000000000 x4 : 0000000000000001 x3 : 0000000000000000
x2 : 0000000000000000 x1 : 0000000100000000 x0 : 0000000000000000
Call trace:
 __lock_acquire+0x2758/0x3084
 reacquire_held_locks+0x120/0x1c0 kernel/locking/lockdep.c:5193
 __lock_release kernel/locking/lockdep.c:5382 [inline]
 lock_release+0x148/0x2b4 kernel/locking/lockdep.c:5688
 __mutex_unlock_slowpath+0x44/0x1cc kernel/locking/mutex.c:907
 mutex_unlock+0x24/0x30 kernel/locking/mutex.c:543
 hugetlb_no_page+0x284/0xe1c mm/hugetlb.c:5771
 hugetlb_fault+0x3a0/0xdfc mm/hugetlb.c:5874
 handle_mm_fault+0x904/0xa48 mm/memory.c:5216
 __do_page_fault arch/arm64/mm/fault.c:506 [inline]
 do_page_fault+0x428/0x79c arch/arm64/mm/fault.c:606
 do_translation_fault+0x78/0x194 arch/arm64/mm/fault.c:689
 do_mem_abort+0x54/0x130 arch/arm64/mm/fault.c:825
 el1_abort+0x3c/0x5c arch/arm64/kernel/entry-common.c:367
 el1h_64_sync_handler+0x60/0xac arch/arm64/kernel/entry-common.c:427
 el1h_64_sync+0x64/0x68 arch/arm64/kernel/entry.S:579
 __arch_copy_from_user+0x24/0x1f4 arch/arm64/lib/copy_from_user.S:77
 __import_iovec+0x60/0x248 lib/iov_iter.c:1773
 import_iovec+0x6c/0x88 lib/iov_iter.c:1838
 vfs_writev fs/read_write.c:931 [inline]
 do_writev+0xf8/0x234 fs/read_write.c:977
 __do_sys_writev fs/read_write.c:1050 [inline]
 __se_sys_writev fs/read_write.c:1047 [inline]
 __arm64_sys_writev+0x28/0x38 fs/read_write.c:1047
 __invoke_syscall arch/arm64/kernel/syscall.c:38 [inline]
 invoke_syscall arch/arm64/kernel/syscall.c:52 [inline]
 el0_svc_common+0x138/0x220 arch/arm64/kernel/syscall.c:142
 do_el0_svc+0x48/0x164 arch/arm64/kernel/syscall.c:206
 el0_svc+0x58/0x150 arch/arm64/kernel/entry-common.c:637
 el0t_64_sync_handler+0x84/0xf0 arch/arm64/kernel/entry-common.c:655
 el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:584
irq event stamp: 941
hardirqs last  enabled at (941): [<ffff80000c01c86c>] __raw_spin_unlock_irq include/linux/spinlock_api_smp.h:159 [inline]
hardirqs last  enabled at (941): [<ffff80000c01c86c>] _raw_spin_unlock_irq+0x3c/0x70 kernel/locking/spinlock.c:202
hardirqs last disabled at (940): [<ffff80000c01c66c>] __raw_spin_lock_irq include/linux/spinlock_api_smp.h:117 [inline]
hardirqs last disabled at (940): [<ffff80000c01c66c>] _raw_spin_lock_irq+0x34/0x9c kernel/locking/spinlock.c:170
softirqs last  enabled at (744): [<ffff80000801c38c>] local_bh_enable+0x10/0x34 include/linux/bottom_half.h:32
softirqs last disabled at (742): [<ffff80000801c358>] local_bh_disable+0x10/0x34 include/linux/bottom_half.h:19
---[ end trace 0000000000000000 ]---


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
