Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 735CB5F5A1C
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Oct 2022 20:49:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229379AbiJEStv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Oct 2022 14:49:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230481AbiJESti (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Oct 2022 14:49:38 -0400
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29925CF7
        for <linux-kernel@vger.kernel.org>; Wed,  5 Oct 2022 11:49:36 -0700 (PDT)
Received: by mail-io1-f70.google.com with SMTP id n10-20020a5e8c0a000000b006b4fbf1b1c4so2746849ioj.21
        for <linux-kernel@vger.kernel.org>; Wed, 05 Oct 2022 11:49:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date;
        bh=b1pBWjlCo4VzFoj5xLzA9z5YqrxWUn64R2jAdqvgzSU=;
        b=nEf5Rn4zd3gH6VLYmEk8YpFWcF85bketwmm0uHFRCdYzSuD9wh/nmzzOwoyYc4xJBL
         b8PFKR5P76Jk7mBUufuvUskJseRPVMzR1xvD0q60w0KeUulExt2eGrr330KcCqDSdnpz
         oW7b+iFUcu0qVOJA2jwWzO/q85yD8NP0evFOLiN0GvQH1scx0/YzwVvFFmM64iXI8zn4
         lnhfu6BAXZ98GB1JJR0NRXUwE7M89BBXwA694Wt0t/Mzc4ZtSJz6kMEEBlbhsVGiLqHO
         tjSADFDAV6tXBzkaU3pZQSPIWbOTLwyTnROh+IysLf/RbymVF0+Okp0FtqJVduP6xCgB
         1sbg==
X-Gm-Message-State: ACrzQf0vwWMHEBLZ0YTL2igol24b2rS68IKhLnOQ/SkAAOWTr47j6gbr
        oC0gVU5KHDc5kxiF6CNb1HSD+m0o2V40sx/Fto2/pa8hOwLY
X-Google-Smtp-Source: AMsMyM7Kl3IKq2SpPxOnlyaFFvkXK83biyRAB/rAQNQYK34Mtd9Uw8uhIk9yid1k39Dg2Xkr9o/LSbBjR7jVCd5t43YkLiO98aYU
MIME-Version: 1.0
X-Received: by 2002:a05:6638:3285:b0:356:4df5:5d10 with SMTP id
 f5-20020a056638328500b003564df55d10mr492348jav.19.1664995776109; Wed, 05 Oct
 2022 11:49:36 -0700 (PDT)
Date:   Wed, 05 Oct 2022 11:49:36 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c9a8c405ea4e096e@google.com>
Subject: [syzbot] BUG: unable to handle kernel NULL pointer dereference in klist_next
From:   syzbot <syzbot+dd585485bb7caaa89f57@syzkaller.appspotmail.com>
To:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        rafael@kernel.org, syzkaller-bugs@googlegroups.com
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
console output: https://syzkaller.appspot.com/x/log.txt?x=13d5fa0a880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=aae2d21e7dd80684
dashboard link: https://syzkaller.appspot.com/bug?extid=dd585485bb7caaa89f57
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
userspace arch: arm64
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1006b058880000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=100b0484880000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/11078f50b80b/disk-bbed346d.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/398e5f1e6c84/vmlinux-bbed346d.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+dd585485bb7caaa89f57@syzkaller.appspotmail.com

Unable to handle kernel NULL pointer dereference at virtual address 0000000000000058
Mem abort info:
  ESR = 0x0000000096000004
  EC = 0x25: DABT (current EL), IL = 32 bits
  SET = 0, FnV = 0
  EA = 0, S1PTW = 0
  FSC = 0x04: level 0 translation fault
Data abort info:
  ISV = 0, ISS = 0x00000004
  CM = 0, WnR = 0
user pgtable: 4k pages, 48-bit VAs, pgdp=0000000107dda000
[0000000000000058] pgd=0000000000000000, p4d=0000000000000000
Internal error: Oops: 0000000096000004 [#1] PREEMPT SMP
Modules linked in:
CPU: 1 PID: 3030 Comm: syz-executor336 Not tainted 6.0.0-rc7-syzkaller-18095-gbbed346d5a96 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/30/2022
pstate: 80400005 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : klist_next+0x28/0x18c lib/klist.c:377
lr : klist_next+0x24/0x18c lib/klist.c:376
sp : ffff8000126fba20
x29: ffff8000126fba20 x28: 00000000000e0003 x27: 0000000000002000
x26: 0000000000000000 x25: 0000000000000000 x24: ffff0000c657b000
x23: ffff80000d832b20 x22: ffff0000ca924000 x21: ffff0000c6578538
x20: 0000000000000000 x19: ffff8000126fba78 x18: 00000000000000c0
x17: ffff80000dd0b198 x16: 0000000000000000 x15: 0000000000000000
x14: 0000000000000000 x13: 0000000000000002 x12: ffff80000d833180
x11: ff808000096ae804 x10: 0000000000000000 x9 : ffff8000096ae804
x8 : ffff0000c62c0000 x7 : ffff8000095d2cfc x6 : 0000000000000000
x5 : 0000000000000080 x4 : 0000000000000001 x3 : 0000000000000000
x2 : ffff80000b97020c x1 : ffff8000126fba78 x0 : 0000000000000000
Call trace:
 klist_next+0x28/0x18c lib/klist.c:377
 next_device drivers/base/core.c:3756 [inline]
 device_find_child+0x50/0x114 drivers/base/core.c:3899
 hci_conn_del_sysfs+0x54/0xfc net/bluetooth/hci_sysfs.c:71
 hci_conn_cleanup+0x2d4/0x380 net/bluetooth/hci_conn.c:147
 hci_conn_del+0x144/0x2a8 net/bluetooth/hci_conn.c:1022
 hci_conn_hash_flush+0xe8/0x148 net/bluetooth/hci_conn.c:2367
 hci_dev_close_sync+0x48c/0x9e0 net/bluetooth/hci_sync.c:4476
 hci_dev_do_close net/bluetooth/hci_core.c:554 [inline]
 hci_unregister_dev+0xe4/0x280 net/bluetooth/hci_core.c:2682
 vhci_release+0x44/0x80 drivers/bluetooth/hci_vhci.c:568
 __fput+0x198/0x3dc fs/file_table.c:320
 ____fput+0x20/0x30 fs/file_table.c:353
 task_work_run+0xc4/0x14c kernel/task_work.c:177
 exit_task_work include/linux/task_work.h:38 [inline]
 do_exit+0x26c/0xbe0 kernel/exit.c:795
 do_group_exit+0x60/0xe8 kernel/exit.c:925
 __do_sys_exit_group kernel/exit.c:936 [inline]
 __se_sys_exit_group kernel/exit.c:934 [inline]
 __wake_up_parent+0x0/0x40 kernel/exit.c:934
 __invoke_syscall arch/arm64/kernel/syscall.c:38 [inline]
 invoke_syscall arch/arm64/kernel/syscall.c:52 [inline]
 el0_svc_common+0x138/0x220 arch/arm64/kernel/syscall.c:142
 do_el0_svc+0x48/0x164 arch/arm64/kernel/syscall.c:206
 el0_svc+0x58/0x150 arch/arm64/kernel/entry-common.c:636
 el0t_64_sync_handler+0x84/0xf0 arch/arm64/kernel/entry-common.c:654
 el0t_64_sync+0x18c/0x190 arch/arm64/kernel/entry.S:581
Code: 910003fd aa0003f3 97afc505 a9405260 (f9402c18) 
---[ end trace 0000000000000000 ]---
----------------
Code disassembly (best guess):
   0:	910003fd 	mov	x29, sp
   4:	aa0003f3 	mov	x19, x0
   8:	97afc505 	bl	0xfffffffffebf141c
   c:	a9405260 	ldp	x0, x20, [x19]
* 10:	f9402c18 	ldr	x24, [x0, #88] <-- trapping instruction


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
