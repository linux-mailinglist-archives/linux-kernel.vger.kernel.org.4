Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F86A6279B7
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 10:58:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236911AbiKNJ5u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 04:57:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236956AbiKNJ5K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 04:57:10 -0500
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01B7B1F2EA
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 01:56:43 -0800 (PST)
Received: by mail-io1-f69.google.com with SMTP id w16-20020a6b4a10000000b006a5454c789eso5574552iob.20
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 01:56:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QhmCtMXD13ueqkEPZREgdJx37AC/Qnw0CsLe+089Zis=;
        b=HUYr4Z2/RlaQ8uDk09bl9Q0k1hJCAqIUaTenZL5/2VN5fvL1QlO/ttIm6iopJjEowW
         zwomlCnvhVuT1B4/c0k7+8BvmEO719vJXG4vXUj4DFySB2vBApVdecqJj1xndHFwSiTw
         /+lZYZxRTAhkLS68/c9S7yDljaxOafAlAg5N0z5VRW/TFDVrkaPqDqwKt7t/ayDiMYhm
         IFgYQDf+TR/Rawol84MnGJC55YJXZVcHyySDHRZf38KDbMXAazybY4zq8IY6nTxqab5C
         gIJwE5EhAG82gpUt+fJrK2O/olkpX6yMO05LWHNFnbaqYfSDIgyiT0kGPVwJ1DilE1uD
         V0pQ==
X-Gm-Message-State: ANoB5pnpL3IiGMLWAxQszga+Xelp24eCASy5AjCRn/Ss4La4/dRgoCmH
        FmzSYrtMOKVBNUBgcoqrkP8IjgPfNe+Ge/uOnSI/ZIVzBPYd
X-Google-Smtp-Source: AA0mqf7L+JTal+ITZw6aDxmWMgHo8rXeseo7JGoiFTBUi14IZ00prgBvc40QzRHCQc4WSwwZZj1SPZs8+/si6JrSSNmAEcS6r0yc
MIME-Version: 1.0
X-Received: by 2002:a02:2121:0:b0:363:b82d:d510 with SMTP id
 e33-20020a022121000000b00363b82dd510mr5198968jaa.112.1668419803302; Mon, 14
 Nov 2022 01:56:43 -0800 (PST)
Date:   Mon, 14 Nov 2022 01:56:43 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b64f3d05ed6b41fe@google.com>
Subject: [syzbot] BUG: spinlock bad magic in writeback_single_inode
From:   syzbot <syzbot+7b2e428bac8cb2ca2f49@syzkaller.appspotmail.com>
To:     almaz.alexandrovich@paragon-software.com,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        nathan@kernel.org, ndesaulniers@google.com, ntfs3@lists.linux.dev,
        syzkaller-bugs@googlegroups.com, trix@redhat.com
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
console output: https://syzkaller.appspot.com/x/log.txt?x=155d51fe880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=606e57fd25c5c6cc
dashboard link: https://syzkaller.appspot.com/bug?extid=7b2e428bac8cb2ca2f49
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
userspace arch: arm64
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13289456880000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/82aa7741098d/disk-1621b6ea.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/f6be08c4e4c2/vmlinux-1621b6ea.xz
kernel image: https://storage.googleapis.com/syzbot-assets/296b6946258a/Image-1621b6ea.gz.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/3d4302e293b8/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+7b2e428bac8cb2ca2f49@syzkaller.appspotmail.com

ntfs3: loop5: Different NTFS' sector size (1024) and media sector size (512)
BUG: spinlock bad magic on CPU#0, syz-executor.5/5077
Unable to handle kernel NULL pointer dereference at virtual address 0000000000000470
Mem abort info:
  ESR = 0x0000000096000006
  EC = 0x25: DABT (current EL), IL = 32 bits
  SET = 0, FnV = 0
  EA = 0, S1PTW = 0
  FSC = 0x06: level 2 translation fault
Data abort info:
  ISV = 0, ISS = 0x00000006
  CM = 0, WnR = 0
user pgtable: 4k pages, 48-bit VAs, pgdp=000000011343b000
[0000000000000470] pgd=0800000112346003, p4d=0800000112346003, pud=08000001135b3003, pmd=0000000000000000
Internal error: Oops: 0000000096000006 [#1] PREEMPT SMP
Modules linked in:
CPU: 0 PID: 5077 Comm: syz-executor.5 Not tainted 6.1.0-rc4-syzkaller-31872-g1621b6eaebf7 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/30/2022
pstate: a0400005 (NzCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : task_pid_nr include/linux/sched.h:1568 [inline]
pc : spin_dump kernel/locking/spinlock_debug.c:63 [inline]
pc : spin_bug+0x88/0xec kernel/locking/spinlock_debug.c:77
lr : spin_dump kernel/locking/spinlock_debug.c:60 [inline]
lr : spin_bug+0x68/0xec kernel/locking/spinlock_debug.c:77
sp : ffff800016e73940
x29: ffff800016e73940 x28: ffffffffffffffff x27: 0000000000000140
x26: 0000000000000002 x25: 0000000000000000 x24: 0000000000000001
x23: ffff800016e73a60 x22: 0000000000000000 x21: ffffffffffffff00
x20: ffff80000cb4a08d x19: ffff0000d12af157 x18: 00000000000000c0
x17: ffff80000dcdc198 x16: 0000000000000002 x15: 0000000000000000
x14: 0000000000000000 x13: 205d373730355420 x12: 5b5d343333323131
x11: ff808000081c06c8 x10: 0000000000000000 x9 : 824be9ae2b942600
x8 : ffffffffffffff01 x7 : 205b5d3433333231 x6 : ffff80000c01775c
x5 : 0000000000000000 x4 : 0000000000000001 x3 : 0000000000000000
x2 : 00000000ad4ead00 x1 : 0000000000000001 x0 : 0000000000000035
Call trace:
 spin_bug+0x88/0xec kernel/locking/spinlock_debug.c:77
 debug_spin_lock_before kernel/locking/spinlock_debug.c:85 [inline]
 do_raw_spin_lock+0xb0/0x110 kernel/locking/spinlock_debug.c:114
 __raw_spin_lock include/linux/spinlock_api_smp.h:134 [inline]
 _raw_spin_lock+0x5c/0x6c kernel/locking/spinlock.c:154
 spin_lock include/linux/spinlock.h:350 [inline]
 writeback_single_inode+0x44/0x54c fs/fs-writeback.c:1676
 write_inode_now+0xb0/0xdc fs/fs-writeback.c:2736
 iput_final fs/inode.c:1734 [inline]
 iput+0x1e4/0x324 fs/inode.c:1773
 ntfs_fill_super+0x1254/0x14a4 fs/ntfs3/super.c:1190
 get_tree_bdev+0x1e8/0x2a0 fs/super.c:1324
 ntfs_fs_get_tree+0x28/0x38 fs/ntfs3/super.c:1358
 vfs_get_tree+0x40/0x140 fs/super.c:1531
 do_new_mount+0x1dc/0x4e4 fs/namespace.c:3040
 path_mount+0x358/0x890 fs/namespace.c:3370
 do_mount fs/namespace.c:3383 [inline]
 __do_sys_mount fs/namespace.c:3591 [inline]
 __se_sys_mount fs/namespace.c:3568 [inline]
 __arm64_sys_mount+0x2c4/0x3c4 fs/namespace.c:3568
 __invoke_syscall arch/arm64/kernel/syscall.c:38 [inline]
 invoke_syscall arch/arm64/kernel/syscall.c:52 [inline]
 el0_svc_common+0x138/0x220 arch/arm64/kernel/syscall.c:142
 do_el0_svc+0x48/0x164 arch/arm64/kernel/syscall.c:206
 el0_svc+0x58/0x150 arch/arm64/kernel/entry-common.c:637
 el0t_64_sync_handler+0x84/0xf0 arch/arm64/kernel/entry-common.c:655
 el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:584
Code: b0025463 12800004 91238c63 14000003 (b94572a4) 
---[ end trace 0000000000000000 ]---
----------------
Code disassembly (best guess):
   0:	b0025463 	adrp	x3, 0x4a8d000
   4:	12800004 	mov	w4, #0xffffffff            	// #-1
   8:	91238c63 	add	x3, x3, #0x8e3
   c:	14000003 	b	0x18
* 10:	b94572a4 	ldr	w4, [x21, #1392] <-- trapping instruction


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
