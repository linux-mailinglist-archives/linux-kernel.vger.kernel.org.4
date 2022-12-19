Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C9D86506BE
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Dec 2022 04:18:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231265AbiLSDSy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Dec 2022 22:18:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbiLSDSu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Dec 2022 22:18:50 -0500
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D05963F4
        for <linux-kernel@vger.kernel.org>; Sun, 18 Dec 2022 19:18:46 -0800 (PST)
Received: by mail-il1-f197.google.com with SMTP id r6-20020a92cd86000000b00304b2d1c2d7so5888378ilb.11
        for <linux-kernel@vger.kernel.org>; Sun, 18 Dec 2022 19:18:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Mkk0r7s32VnhsK8f0b281jDggdvjHhxrJJu5EjZFaaI=;
        b=GNM58rBJNbsBU+rqxGd//m478TSaHZ3HYd/MpYZNnV+HY3X7Z4yUv5IHnkWkXX39Zn
         YhanQkIwhut2Q1mOHXW6mA2fm8GOxhsd9pPDLrXhqhs2qftTnmrRklWd3PXiqu3yyRGx
         QxD0l5Fv+zMrAoiwgRS5IyXOMbAmVzh/ZzdPjuEm0bcWRt5GqK4BhXqdCG0uac6aD8KU
         q/DJ41ZsqZS5WH57/65WFGFoqvz0bf1DiWk7QxlW9cYZ+NagQX95jIZKSqSSvgltgMTH
         YlzIIIS3SM50mrskEBT6SxxFRi20i7CJqgEnxdTG8GlHeTH4p411ToeVku/5B6sMQHHW
         37fA==
X-Gm-Message-State: ANoB5pnhNv5M/5pfEq1JsSLN+ZfDqjemoDV3sSGJ3I/nDSJ09Dhpxarz
        Fl8XjGeKOWATmXp7oNKGAr7lla/yXheuEiE6uHqAuS+Gufrr
X-Google-Smtp-Source: AA0mqf7ZkE66DByY7xjoi4uDMrkpRbI1CLWhgl8v03Eheq8xW2Te9AsMx59qwnOdHBTZoCfMK3QmnRN6Yl6mll/TIANYucK55oWX
MIME-Version: 1.0
X-Received: by 2002:a6b:fd0e:0:b0:6df:5e6c:f5c7 with SMTP id
 c14-20020a6bfd0e000000b006df5e6cf5c7mr27082566ioi.207.1671419925866; Sun, 18
 Dec 2022 19:18:45 -0800 (PST)
Date:   Sun, 18 Dec 2022 19:18:45 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f3aeec05f025c6b8@google.com>
Subject: [syzbot] BUG: unable to handle kernel NULL pointer dereference in
 unlock_page (2)
From:   syzbot <syzbot+9d014e6e0df70d97c103@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, syzkaller-bugs@googlegroups.com
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

HEAD commit:    a5541c0811a0 Merge branch 'for-next/core' into for-kernelci
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=10d2ebe0480000
kernel config:  https://syzkaller.appspot.com/x/.config?x=cbd4e584773e9397
dashboard link: https://syzkaller.appspot.com/bug?extid=9d014e6e0df70d97c103
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
userspace arch: arm64
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=107f999d880000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=170205af880000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/4b7702208fb9/disk-a5541c08.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/9ec0153ec051/vmlinux-a5541c08.xz
kernel image: https://storage.googleapis.com/syzbot-assets/6f8725ad290a/Image-a5541c08.gz.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/327f2cb22964/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+9d014e6e0df70d97c103@syzkaller.appspotmail.com

 ksys_pread64 fs/read_write.c:665 [inline]
 __do_sys_pread64 fs/read_write.c:675 [inline]
 __se_sys_pread64 fs/read_write.c:672 [inline]
 __arm64_sys_pread64+0xbc/0x11c fs/read_write.c:672
 __invoke_syscall arch/arm64/kernel/syscall.c:38 [inline]
 invoke_syscall arch/arm64/kernel/syscall.c:52 [inline]
 el0_svc_common+0x138/0x220 arch/arm64/kernel/syscall.c:142
 do_el0_svc+0x48/0x140 arch/arm64/kernel/syscall.c:197
 el0_svc+0x58/0x150 arch/arm64/kernel/entry-common.c:637
 el0t_64_sync_handler+0x84/0xf0 arch/arm64/kernel/entry-common.c:655
 el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:584
Unable to handle kernel NULL pointer dereference at virtual address 0000000000000008
Mem abort info:
  ESR = 0x0000000096000006
  EC = 0x25: DABT (current EL), IL = 32 bits
  SET = 0, FnV = 0
  EA = 0, S1PTW = 0
  FSC = 0x06: level 2 translation fault
Data abort info:
  ISV = 0, ISS = 0x00000006
  CM = 0, WnR = 0
user pgtable: 4k pages, 48-bit VAs, pgdp=000000010adf6000
[0000000000000008] pgd=0800000106a37003, p4d=0800000106a37003, pud=0800000106a36003, pmd=0000000000000000
Internal error: Oops: 0000000096000006 [#1] PREEMPT SMP
Modules linked in:
CPU: 1 PID: 3072 Comm: syz-executor288 Not tainted 6.1.0-rc8-syzkaller-33330-ga5541c0811a0 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/26/2022
pstate: 80400005 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : _compound_head include/linux/page-flags.h:253 [inline]
pc : unlock_page+0x18/0xb8 mm/folio-compat.c:20
lr : unlock_page+0x18/0xb8 mm/folio-compat.c:19
sp : ffff80000ff1b910
x29: ffff80000ff1b910 x28: 0000000000000007 x27: fffffc000330a480
x26: 00000000ffffffff x25: 0000000000000000 x24: 0000000000000000
x23: 0000000000000001 x22: 0000000000000000 x21: 00000000fffffff4
x20: ffff0000c95b4880 x19: 0000000000000000 x18: 0000000000000073
x17: 6e69676e45206574 x16: ffff80000dbe6158 x15: ffff0000c4423480
x14: 0000000000000000 x13: 00000000ffffffff x12: ffff0000c4423480
x11: ff808000083f6804 x10: 0000000000000000 x9 : ffff8000083f6804
x8 : ffff0000c4423480 x7 : ffff80000c091ebc x6 : 0000000000000000
x5 : 0000000000000080 x4 : 0000000000000001 x3 : 0000000000000000
x2 : 0000000000000000 x1 : 0000000000000000 x0 : 0000000000000000
Call trace:
 unlock_page+0x18/0xb8 mm/folio-compat.c:19
 ni_readpage_cmpr+0x328/0x7cc fs/ntfs3/frecord.c:2139
 ntfs_read_folio+0xd8/0x128 fs/ntfs3/inode.c:697
 filemap_read_folio+0xc4/0x468 mm/filemap.c:2407
 filemap_create_folio+0xc0/0x1b4 mm/filemap.c:2536
 filemap_get_pages+0x388/0x598 mm/filemap.c:2588
 filemap_read+0x14c/0x6f4 mm/filemap.c:2675
 generic_file_read_iter+0x6c/0x25c mm/filemap.c:2821
 ntfs_file_read_iter+0xe4/0x118 fs/ntfs3/file.c:853
 call_read_iter include/linux/fs.h:2193 [inline]
 new_sync_read fs/read_write.c:389 [inline]
 vfs_read+0x2d4/0x448 fs/read_write.c:470
 ksys_pread64 fs/read_write.c:665 [inline]
 __do_sys_pread64 fs/read_write.c:675 [inline]
 __se_sys_pread64 fs/read_write.c:672 [inline]
 __arm64_sys_pread64+0xbc/0x11c fs/read_write.c:672
 __invoke_syscall arch/arm64/kernel/syscall.c:38 [inline]
 invoke_syscall arch/arm64/kernel/syscall.c:52 [inline]
 el0_svc_common+0x138/0x220 arch/arm64/kernel/syscall.c:142
 do_el0_svc+0x48/0x140 arch/arm64/kernel/syscall.c:197
 el0_svc+0x58/0x150 arch/arm64/kernel/entry-common.c:637
 el0t_64_sync_handler+0x84/0xf0 arch/arm64/kernel/entry-common.c:655
 el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:584
Code: a9014ff4 910003fd aa0003f3 97fac089 (f9400674) 
---[ end trace 0000000000000000 ]---
----------------
Code disassembly (best guess):
   0:	a9014ff4 	stp	x20, x19, [sp, #16]
   4:	910003fd 	mov	x29, sp
   8:	aa0003f3 	mov	x19, x0
   c:	97fac089 	bl	0xffffffffffeb0230
* 10:	f9400674 	ldr	x20, [x19, #8] <-- trapping instruction


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
