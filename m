Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1FBD5BB5AF
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Sep 2022 04:54:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229669AbiIQCxh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 22:53:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229662AbiIQCxf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 22:53:35 -0400
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 757CFBB699
        for <linux-kernel@vger.kernel.org>; Fri, 16 Sep 2022 19:53:34 -0700 (PDT)
Received: by mail-il1-f200.google.com with SMTP id r12-20020a92cd8c000000b002f32d0d9fceso15589287ilb.11
        for <linux-kernel@vger.kernel.org>; Fri, 16 Sep 2022 19:53:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date;
        bh=Yp2X7w1yEP4g/p40zM4jk+01H6za5StpOqokGZuT1Uc=;
        b=WwvhdsewWUL9m2qQGlLZ4zDsJ5OsObUTcwnKZd45ol05Szw7wM+ba+DctwmCQXJ53d
         WbpGncYjfqSvsMy1OGouHNQbQkssWTw1zVn5dV9ZrWPLjVQuG4nDPQgje23++Z8BvAeW
         cstuHwhTVnCLzUgjhwsHqINaOSV2vyw13/+JpoQHU+y59PwsYlH+11TqPCtdwPzvAcKd
         x5LLjA5JgtzNWbpEB32Zce8FGZIIl2Dh110opj5gKtJOD0Bv0C3Q5Xyv8+w/JYRsvhnP
         81pWB0o8fC2XCvI2kkOsYz9BX3/6IgprfH+GCzlimKd3ugdl+MhVhILQ2w6grnFJmYlf
         WQuA==
X-Gm-Message-State: ACrzQf3/F7iVKZ7pg+jNy9bwFsUZfWwVInw7TXCYSlMcaJrnQIFSB1pK
        dPPuPuRVOWzHeRVcvqkO+Nu51NY+VWDJlWxhnQH9wHkr6iWD
X-Google-Smtp-Source: AMsMyM6UkJpZJt11/Nj2uenr/i+CwhOSLk+TTXL4Ce4o3k5QggrGcdjuM6wC/ebRekGPcHTNfulsA/f8uzgaVMMxNZY6Ni6pR42r
MIME-Version: 1.0
X-Received: by 2002:a02:bb0a:0:b0:35a:100f:74f3 with SMTP id
 y10-20020a02bb0a000000b0035a100f74f3mr3821473jan.237.1663383213780; Fri, 16
 Sep 2022 19:53:33 -0700 (PDT)
Date:   Fri, 16 Sep 2022 19:53:33 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000095339805e8d6958e@google.com>
Subject: [syzbot] BUG: unable to handle kernel paging request in kernfs_put_active
From:   syzbot <syzbot+258ad6d2cb6685e145bc@syzkaller.appspotmail.com>
To:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, tj@kernel.org
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

HEAD commit:    a6b443748715 Merge branch 'for-next/core', remote-tracking..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=17025144880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=14bf9ec0df433b27
dashboard link: https://syzkaller.appspot.com/bug?extid=258ad6d2cb6685e145bc
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
userspace arch: arm64
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=106b8164880000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1040a75d080000

Downloadable assets:
disk image: https://storage.googleapis.com/81b491dd5861/disk-a6b44374.raw.xz
vmlinux: https://storage.googleapis.com/69c979cdc99a/vmlinux-a6b44374.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+258ad6d2cb6685e145bc@syzkaller.appspotmail.com

Unable to handle kernel paging request at virtual address 004065676e6168fb
Mem abort info:
  ESR = 0x0000000096000004
  EC = 0x25: DABT (current EL), IL = 32 bits
  SET = 0, FnV = 0
  EA = 0, S1PTW = 0
  FSC = 0x04: level 0 translation fault
Data abort info:
  ISV = 0, ISS = 0x00000004
  CM = 0, WnR = 0
[004065676e6168fb] address between user and kernel address ranges
Internal error: Oops: 96000004 [#1] PREEMPT SMP
Modules linked in:
CPU: 0 PID: 2562 Comm: udevd Not tainted 6.0.0-rc4-syzkaller-17255-ga6b443748715 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/26/2022
pstate: 80400005 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : kernfs_lockdep fs/kernfs/dir.c:43 [inline]
pc : kernfs_put_active+0x24/0x11c fs/kernfs/dir.c:449
lr : kernfs_put_active+0x20/0x11c fs/kernfs/dir.c:443
sp : ffff800015fcbc50
x29: ffff800015fcbc50 x28: ffff0000c4810000 x27: 0001000000000000
x26: 0000000000000152 x25: ffff0000c538f348 x24: ffff8000086fe770
x23: ffff0000c92e5620 x22: 0000000000000007 x21: ffff0000cbc31500
x20: ffff8000086fba20 x19: 2f4065676e616863 x18: 0000000000000000
x17: 0000000000000000 x16: ffff80000db78658 x15: ffff0000c4810000
x14: 0000000000000000 x13: 00000000ffffffff x12: ffff0000c4810000
x11: ff808000086f6a0c x10: 0000000000000000 x9 : ffff8000086f6a0c
x8 : ffff0000c4810000 x7 : ffff8000095d8f84 x6 : 0000000000000000
x5 : 0000000000000080 x4 : ffff0001fefd3740 x3 : 0000000000083500
x2 : ffff0000c8aa3000 x1 : 0000000000000000 x0 : 2f4065676e616863
Call trace:
 kernfs_put_active+0x24/0x11c fs/kernfs/dir.c:446
 kernfs_fop_write_iter+0x1fc/0x294 fs/kernfs/file.c:358
 call_write_iter include/linux/fs.h:2187 [inline]
 new_sync_write fs/read_write.c:491 [inline]
 vfs_write+0x2dc/0x46c fs/read_write.c:578
 ksys_write+0xb4/0x160 fs/read_write.c:631
 __do_sys_write fs/read_write.c:643 [inline]
 __se_sys_write fs/read_write.c:640 [inline]
 __arm64_sys_write+0x24/0x34 fs/read_write.c:640
 __invoke_syscall arch/arm64/kernel/syscall.c:38 [inline]
 invoke_syscall arch/arm64/kernel/syscall.c:52 [inline]
 el0_svc_common+0x138/0x220 arch/arm64/kernel/syscall.c:142
 do_el0_svc+0x48/0x164 arch/arm64/kernel/syscall.c:206
 el0_svc+0x58/0x150 arch/arm64/kernel/entry-common.c:624
 el0t_64_sync_handler+0x84/0xf0 arch/arm64/kernel/entry-common.c:642
 el0t_64_sync+0x18c/0x190
Code: aa1e03f4 aa0003f3 97eea9d1 b40004f3 (79413275) 
---[ end trace 0000000000000000 ]---
----------------
Code disassembly (best guess):
   0:	aa1e03f4 	mov	x20, x30
   4:	aa0003f3 	mov	x19, x0
   8:	97eea9d1 	bl	0xffffffffffbaa74c
   c:	b40004f3 	cbz	x19, 0xa8
* 10:	79413275 	ldrh	w21, [x19, #152] <-- trapping instruction


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
