Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 801C362C176
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 15:54:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229758AbiKPOyy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 09:54:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232126AbiKPOyp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 09:54:45 -0500
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E193F10B
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 06:54:43 -0800 (PST)
Received: by mail-il1-f198.google.com with SMTP id k3-20020a92c243000000b0030201475a6bso13283726ilo.9
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 06:54:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bUN/FpwVFx2Shx7k+l1VE9xLw/IMJFD/43fP0Y4FYAQ=;
        b=y1/djyFsopgs2nIUsLCQ06s3/dM9Dc/xMhiZeNBj+l2Ifp2+sW4mRtEnOsgQhBTy5n
         cTZu/j4i/u4Xx165rLl3LBcEPXc1oHzNrxE1uYxApR9wU5ciFsoQUMFgL6kkTTMHvtBb
         V4Q60s7yMdTA91SbDMnYthRlZtODMFBtVUHNVogYtB2dXEuvZjwWuLA3l2OIrix1YRg0
         DVIPqMtc0agIV+4Z08XQmJ0huloGqX2Hg7Vh3EBKYPmHxyn1TLiz9ponxC9agIsdzIRx
         Bnwtpb1udGIMioUl4wiy/dT9pgRcQCXQvoyIlYSIcAq8DAd6lkY3+YrYFpNdrT7UkdoA
         xnrA==
X-Gm-Message-State: ANoB5pn2Td0t+WoUUEtUShAT8XN4kw6o9GJlHelGmad6uXMEcsj24t1h
        OmY0iQsJUAsWo63KVzP3nGx+03ffm96eMUeSrGSmCfcvv56e
X-Google-Smtp-Source: AA0mqf76o4yj249xQO2NN7upqCvWE6yjt4wgPVQb8EoHioY+gZOrAfEK6vmnn3e4Pk1hF7TfGFgFZRS9d1ogno8UNPMDCQybsDpB
MIME-Version: 1.0
X-Received: by 2002:a02:3213:0:b0:374:c658:2141 with SMTP id
 j19-20020a023213000000b00374c6582141mr9822834jaa.210.1668610483183; Wed, 16
 Nov 2022 06:54:43 -0800 (PST)
Date:   Wed, 16 Nov 2022 06:54:43 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000001e68ff05ed97a712@google.com>
Subject: [syzbot] BUG: unable to handle kernel NULL pointer dereference in shmem_evict_inode
From:   syzbot <syzbot+b90b43fd4c6589e96a39@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, hughd@google.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
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

HEAD commit:    1621b6eaebf7 Merge branch 'for-next/fixes' into for-kernelci
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=14016169880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=606e57fd25c5c6cc
dashboard link: https://syzkaller.appspot.com/bug?extid=b90b43fd4c6589e96a39
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
userspace arch: arm64
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1112f7a9880000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17c33e69880000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/82aa7741098d/disk-1621b6ea.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/f6be08c4e4c2/vmlinux-1621b6ea.xz
kernel image: https://storage.googleapis.com/syzbot-assets/296b6946258a/Image-1621b6ea.gz.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+b90b43fd4c6589e96a39@syzkaller.appspotmail.com

Unable to handle kernel NULL pointer dereference at virtual address 0000000000000010
Mem abort info:
  ESR = 0x0000000096000004
  EC = 0x25: DABT (current EL), IL = 32 bits
  SET = 0, FnV = 0
  EA = 0, S1PTW = 0
  FSC = 0x04: level 0 translation fault
Data abort info:
  ISV = 0, ISS = 0x00000004
  CM = 0, WnR = 0
user pgtable: 4k pages, 48-bit VAs, pgdp=000000010bfaa000
[0000000000000010] pgd=0000000000000000, p4d=0000000000000000
Internal error: Oops: 0000000096000004 [#1] PREEMPT SMP
Modules linked in:

CPU: 1 PID: 3059 Comm: udevd Not tainted 6.1.0-rc4-syzkaller-31872-g1621b6eaebf7 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/30/2022
pstate: 80400005 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : simple_xattrs_free include/linux/xattr.h:111 [inline]
pc : shmem_evict_inode+0x2d0/0x3d8 mm/shmem.c:1164
lr : simple_xattrs_free include/linux/xattr.h:110 [inline]
lr : shmem_evict_inode+0x2f0/0x3d8 mm/shmem.c:1164
sp : ffff800012c0ba40
x29: ffff800012c0ba90
 x28: ffff80000d890000
 x27: ffff0000ccf252a0

x26: 00000000000800e0
 x25: 0000000000000001 x24: 0000000000000001
x23: ffff0000ccf254c8 x22: ffff0000c0cb6e00 x21: 0000000000000000
x20: 0000000000000000 x19: ffff0000ccf25310 x18: 0000000000000000
x17: 0000000000000000 x16: ffff80000db1a158 x15: ffff0000c64dcec0
x14: 0000000000000000 x13: 00000000ffffffff x12: ffff0000c64dcec0
x11: ff8080000842e558 x10: 0000000000000000 x9 : ffff80000842e558
x8 : ffff0000c64dcec0 x7 : ffff8000085252dc x6 : 0000000000000000
x5 : 0000000000000080 x4 : 0000000000000001 x3 : 0000000000000000
x2 : 0000000000000006 x1 : ffff80000cdfe6d9 x0 : ffff8001f1dbd000
Call trace:
 simple_xattrs_free include/linux/xattr.h:110 [inline]
 shmem_evict_inode+0x2d0/0x3d8 mm/shmem.c:1164
 evict+0xec/0x334 fs/inode.c:664
 iput_final fs/inode.c:1747 [inline]
 iput+0x2c4/0x324 fs/inode.c:1773
 dentry_unlink_inode+0x204/0x21c fs/dcache.c:401
 __dentry_kill+0x15c/0x37c fs/dcache.c:607
 dentry_kill+0x8c/0x194
 dput+0x194/0x2e0 fs/dcache.c:913
 do_renameat2+0x49c/0x758 fs/namei.c:4931
 __do_sys_renameat fs/namei.c:4969 [inline]
 __se_sys_renameat fs/namei.c:4966 [inline]
 __arm64_sys_renameat+0x64/0x7c fs/namei.c:4966
 __invoke_syscall arch/arm64/kernel/syscall.c:38 [inline]
 invoke_syscall arch/arm64/kernel/syscall.c:52 [inline]
 el0_svc_common+0x138/0x220 arch/arm64/kernel/syscall.c:142
 do_el0_svc+0x48/0x164 arch/arm64/kernel/syscall.c:206
 el0_svc+0x58/0x150 arch/arm64/kernel/entry-common.c:637
 el0t_64_sync_handler+0x84/0xf0 arch/arm64/kernel/entry-common.c:655
 el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:584
Code: 97f9cd15 f84d0f74 eb1b029f 540001a0 (f9400a80) 
---[ end trace 0000000000000000 ]---
----------------
Code disassembly (best guess):
   0:	97f9cd15 	bl	0xffffffffffe73454
   4:	f84d0f74 	ldr	x20, [x27, #208]!
   8:	eb1b029f 	cmp	x20, x27
   c:	540001a0 	b.eq	0x40  // b.none
* 10:	f9400a80 	ldr	x0, [x20, #16] <-- trapping instruction


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
