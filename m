Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA3CE611BB1
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 22:43:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229890AbiJ1Umt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 16:42:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229765AbiJ1Umq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 16:42:46 -0400
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FD4F239225
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 13:42:45 -0700 (PDT)
Received: by mail-io1-f70.google.com with SMTP id i21-20020a6bf415000000b006bc987bf9faso5015591iog.6
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 13:42:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dHuE4Tv+Ng/r/K7FPtFTwJ2FeGTPLZX2YmrHQjDPskA=;
        b=ItfmNZKQDIxvPD9Nt2lFwZmPvvWQe8IglkCs6mbFJ1zNgxqgxI13GLklVn0ujuqXDn
         dMY8nPxU5t4S8S6/GT1JNnI3/V5kqzVPSzBI4iBE6BQzTa8E1D9qzvuaxbiCwA1FlPtn
         iTeEdLWfFsUj0hU7iCYy0S8m1D4grzf/HYRsFVVzfIwQvj/vjBUnwoJQ9ituB9XLbUCQ
         iJ37WIq6nj5KdF2G7oiwFWDZU7KFjQ4t9m84fvMLvxmUfdLz5crJ0T+o9oOnENIwRtyX
         gpCCpeM0ADrYfofG65AJJqh0/wUd9aH+jAlXDKbvrLkO3ZKz9vc4mCvjfvTjHKvfmoOy
         ADbw==
X-Gm-Message-State: ACrzQf2Ys6pAbirW+E3a4of9MsOXWgslqf0BybdMAR/Eyn1LkSdQlrGF
        WovEezaD5kuYYl9Hd//sganES+thmTTNesCjxxrd5er/t3yg
X-Google-Smtp-Source: AMsMyM7DZ228E7OHeDOmnGNGIn7HEFMrYFobmajan+6eR8oQ33wGqcvkQYN/Or3DkHO3M9i1KkdIOdHH5D12dg4CdjwAjCaPk9KI
MIME-Version: 1.0
X-Received: by 2002:a05:6638:378d:b0:363:b8c7:13cc with SMTP id
 w13-20020a056638378d00b00363b8c713ccmr766924jal.114.1666989764919; Fri, 28
 Oct 2022 13:42:44 -0700 (PDT)
Date:   Fri, 28 Oct 2022 13:42:44 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c8457f05ec1e4c69@google.com>
Subject: [syzbot] BUG: unable to handle kernel NULL pointer dereference in lock_page
From:   syzbot <syzbot+77e4f005cb899d4268d1@syzkaller.appspotmail.com>
To:     konishi.ryusuke@gmail.com, linux-kernel@vger.kernel.org,
        linux-nilfs@vger.kernel.org, syzkaller-bugs@googlegroups.com
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
console output: https://syzkaller.appspot.com/x/log.txt?x=100804a6880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3a4a45d2d827c1e
dashboard link: https://syzkaller.appspot.com/bug?extid=77e4f005cb899d4268d1
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
userspace arch: arm64
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=111fa5f2880000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13687212880000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/e8e91bc79312/disk-bbed346d.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/c1cb3fb3b77e/vmlinux-bbed346d.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/c8d7f5e1917f/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+77e4f005cb899d4268d1@syzkaller.appspotmail.com

NILFS (loop0): segctord starting. Construction interval = 5 seconds, CP frequency < 30 seconds
Unable to handle kernel NULL pointer dereference at virtual address 0000000000000168
Mem abort info:
  ESR = 0x0000000096000004
  EC = 0x25: DABT (current EL), IL = 32 bits
  SET = 0, FnV = 0
  EA = 0, S1PTW = 0
  FSC = 0x04: level 0 translation fault
Data abort info:
  ISV = 0, ISS = 0x00000004
  CM = 0, WnR = 0
user pgtable: 4k pages, 48-bit VAs, pgdp=0000000108bcf000
[0000000000000168] pgd=0000000000000000, p4d=0000000000000000
Internal error: Oops: 0000000096000004 [#1] PREEMPT SMP
Modules linked in:
CPU: 1 PID: 3032 Comm: segctord Not tainted 6.0.0-rc7-syzkaller-18095-gbbed346d5a96 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/30/2022
pstate: 60400005 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : _compound_head include/linux/page-flags.h:253 [inline]
pc : lock_page+0x28/0x1e0 include/linux/pagemap.h:958
lr : lock_page+0x28/0x1e0 include/linux/pagemap.h:956
sp : ffff80001290bc00
x29: ffff80001290bc00 x28: ffff80001290bde0 x27: 000000000000001b
x26: fffffc000330d7c0 x25: ffff0000caa56d68 x24: ffff0000ca9fb1c0
x23: 0000000000000080 x22: ffff0000ca9fb130 x21: 0000000000000160
x20: ffff0000c91e10b8 x19: 0000000000000160 x18: 00000000000000c0
x17: ffff80000dd0b198 x16: ffff80000db49158 x15: ffff0000c3e63500
x14: 0000000000000000 x13: 00000000ffffffff x12: ffff0000c3e63500
x11: ff808000095d1a0c x10: 0000000000000000 x9 : 0000000000000000
x8 : 0000000000000000 x7 : ffff80000856806c x6 : 0000000000000000
x5 : 0000000000000080 x4 : 0000000000000000 x3 : 0000000000000000
x2 : 0000000000000000 x1 : ffff80000cb431b1 x0 : 0000000000000000
Call trace:
 lock_page+0x28/0x1e0 include/linux/pagemap.h:956
 nilfs_segctor_prepare_write+0x6c/0x21c fs/nilfs2/segment.c:1658
 nilfs_segctor_do_construct+0x9f4/0xee8 fs/nilfs2/segment.c:2068
 nilfs_segctor_construct+0xa0/0x380 fs/nilfs2/segment.c:2375
 nilfs_segctor_thread_construct fs/nilfs2/segment.c:2483 [inline]
 nilfs_segctor_thread+0x180/0x660 fs/nilfs2/segment.c:2566
 kthread+0x12c/0x158 kernel/kthread.c:376
 ret_from_fork+0x10/0x20 arch/arm64/kernel/entry.S:860
Code: 9001df80 912a5000 52807781 97c7bd0e (f9400674) 
---[ end trace 0000000000000000 ]---
----------------
Code disassembly (best guess):
   0:	9001df80 	adrp	x0, 0x3bf0000
   4:	912a5000 	add	x0, x0, #0xa94
   8:	52807781 	mov	w1, #0x3bc                 	// #956
   c:	97c7bd0e 	bl	0xffffffffff1ef444
* 10:	f9400674 	ldr	x20, [x19, #8] <-- trapping instruction


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
