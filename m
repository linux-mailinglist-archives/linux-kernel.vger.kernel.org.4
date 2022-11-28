Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E33963B4E8
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 23:39:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232503AbiK1Wjj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 17:39:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234247AbiK1Wjf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 17:39:35 -0500
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78DD92F641
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 14:39:33 -0800 (PST)
Received: by mail-io1-f71.google.com with SMTP id be26-20020a056602379a00b006dd80a0ba1cso7028270iob.11
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 14:39:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VQRhnY5DyJNKgfP4EurS6ydyJfw4Wv2+nhVrLzqvsjE=;
        b=Xms6U+xynYxH84bViTeeckFX4Sq5I9tw8bynCJxIqOECr9xW9l5mdmDA+vsiM3Kn3W
         Qt9fy4pRgp/j2pe22vLqKkD5UFBoGEAYgFwGnC0V9JFGj+AOVAOJ4JXaGt48kY7htrd5
         7nyw76g9wFZRb1elHuu+3+l+vC4s45t0H2EzhqJpTKJYWvolvwk7JTmIFLe4TD4xbZFw
         NG32yAvgM2YYbo4vxucUZaCpYLfka6aB9fQX8HT09M3S4JpTzAT5bUjft/eN0Sfz0SRM
         0NvDQpNlx0VqD3ZNkHzcUS1eE3Qxj7z/GJoa96p7PtGiJcbzCI5G77ipj6E/4wJY4PPz
         80Lg==
X-Gm-Message-State: ANoB5pm2J/2YOJ6zmnDFl72ppxDBdLQR4EK8syKbam83XoLkxMbYbwBH
        /RhRQnjJPBewL0PXTrX6vP6ExIQE8TFGnGYYb0DwjGs6ckg1
X-Google-Smtp-Source: AA0mqf6PB9+bUiGxzE5uLhMVDQheaEbKgDevqV5HFf9GaZdYjb11yHdVJGfsoZZhq832dioqa9OG3/T88A1a2Glj4lpDxsFdafxY
MIME-Version: 1.0
X-Received: by 2002:a92:db05:0:b0:302:d373:2917 with SMTP id
 b5-20020a92db05000000b00302d3732917mr15096849iln.318.1669675172861; Mon, 28
 Nov 2022 14:39:32 -0800 (PST)
Date:   Mon, 28 Nov 2022 14:39:32 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000919f7b05ee8f8bc5@google.com>
Subject: [syzbot] BUG: unable to handle kernel paging request in tomoyo_encode
From:   syzbot <syzbot+2f0d91a12931a37dd85e@syzkaller.appspotmail.com>
To:     jmorris@namei.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, paul@paul-moore.com,
        penguin-kernel@I-love.SAKURA.ne.jp, serge@hallyn.com,
        syzkaller-bugs@googlegroups.com, takedakn@nttdata.co.jp
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

HEAD commit:    65762d97e6fa Merge branch 'for-next/perf' into for-kernelci
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=1152d68d880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=56d0c7c3a2304e8f
dashboard link: https://syzkaller.appspot.com/bug?extid=2f0d91a12931a37dd85e
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
userspace arch: arm64
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12f9e8a1880000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13125fe5880000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/52f702197b30/disk-65762d97.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/72189c2789ce/vmlinux-65762d97.xz
kernel image: https://storage.googleapis.com/syzbot-assets/ec0349196c98/Image-65762d97.gz.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+2f0d91a12931a37dd85e@syzkaller.appspotmail.com

Unable to handle kernel paging request at virtual address 00480000001a0040
Mem abort info:
  ESR = 0x0000000096000004
  EC = 0x25: DABT (current EL), IL = 32 bits
  SET = 0, FnV = 0
  EA = 0, S1PTW = 0
  FSC = 0x04: level 0 translation fault
Data abort info:
  ISV = 0, ISS = 0x00000004
  CM = 0, WnR = 0
[00480000001a0040] address between user and kernel address ranges
Internal error: Oops: 0000000096000004 [#1] PREEMPT SMP
Modules linked in:
CPU: 1 PID: 3263 Comm: syz-executor425 Not tainted 6.1.0-rc6-syzkaller-32653-g65762d97e6fa #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/30/2022
pstate: 40400005 (nZcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : __kmem_cache_alloc_node+0x17c/0x350 mm/slub.c:3437
lr : slab_pre_alloc_hook mm/slab.h:712 [inline]
lr : slab_alloc_node mm/slub.c:3318 [inline]
lr : __kmem_cache_alloc_node+0x80/0x350 mm/slub.c:3437
sp : ffff80000ff3b990
x29: ffff80000ff3b9a0 x28: ffff0000c681b480 x27: 0000000000000006
x26: 000000000000001d x25: 00000000ffffffff x24: ffff800009443294
x23: 0000000000000011 x22: 00480000001a0000 x21: 0000000000000000
x20: 0000000000000d40 x19: ffff0000c0001200 x18: 0000000000000000
x17: 0000000000000000 x16: ffff80000dbe6158 x15: ffff0000c681b480
x14: 0000000000000010 x13: 0000000000000000 x12: ffff0000c681b480
x11: 0000000000000001 x10: 0000000000000000 x9 : 0000000000000040
x8 : 00000000000a8cb9 x7 : ffff8000084bf248 x6 : 0000000000000000
x5 : 0000000000000000 x4 : 0000000000000001 x3 : 00000000000a8cc1
x2 : 0000000000000000 x1 : 0000000000000d40 x0 : fffffc00031ee180
Call trace:
 next_tid mm/slub.c:2349 [inline]
 slab_alloc_node mm/slub.c:3382 [inline]
 __kmem_cache_alloc_node+0x17c/0x350 mm/slub.c:3437
 __do_kmalloc_node mm/slab_common.c:954 [inline]
 __kmalloc+0xb4/0x140 mm/slab_common.c:968
 kmalloc include/linux/slab.h:558 [inline]
 kzalloc include/linux/slab.h:689 [inline]
 tomoyo_encode2 security/tomoyo/realpath.c:45 [inline]
 tomoyo_encode+0x1d8/0x2d0 security/tomoyo/realpath.c:80
 tomoyo_mount_acl security/tomoyo/mount.c:150 [inline]
 tomoyo_mount_permission+0x2c8/0x5ac security/tomoyo/mount.c:237
 tomoyo_sb_mount+0x48/0x60 security/tomoyo/tomoyo.c:401
 security_sb_mount+0x5c/0xb8 security/security.c:979
 path_mount+0xa0/0x890 fs/namespace.c:3312
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
Code: 54000ee1 34000eeb b9402a69 91002103 (f8696ada) 
---[ end trace 0000000000000000 ]---
----------------
Code disassembly (best guess):
   0:	54000ee1 	b.ne	0x1dc  // b.any
   4:	34000eeb 	cbz	w11, 0x1e0
   8:	b9402a69 	ldr	w9, [x19, #40]
   c:	91002103 	add	x3, x8, #0x8
* 10:	f8696ada 	ldr	x26, [x22, x9] <-- trapping instruction


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
