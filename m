Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1D7D66482E
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 19:09:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235395AbjAJSJD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 13:09:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238949AbjAJSHz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 13:07:55 -0500
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBE38B89
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 10:05:52 -0800 (PST)
Received: by mail-io1-f70.google.com with SMTP id t3-20020a6bc303000000b006f7844c6298so7490211iof.23
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 10:05:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DsPpQXl2ln9dsF59TAVn1ScDwWogVaNrdBMt6IAktRE=;
        b=tHXOC5nMF8mIQhWGzrXGsby1oWFVPustv12I6APGfxP7daS41RuMspctj6R+WEaZdm
         hkLdn4pfWyajqEjU/TqMG2tEMmxsaFnY+w2QTbJCRnE2og2oFP8GL8NYFHqYGqESaOqp
         oeI8GTrtMgriBfmiJHt+tJxivPsbgHibfBjmKSHZkhN1iKttZMT/X5nIYI8vja7mqD8m
         N7/pMMdIy5XeBoEaZURPzkb/b1/OjdBHyoVdcWYmUcddlCCdZrIg/LoxqEAFrhpq15Gp
         dSVEg2LyweI4slk1+gM44X6th2y8vaCLx8Ioo7LBJUU6dZ581mrP1lTxTT5InFpeAxmj
         2YZw==
X-Gm-Message-State: AFqh2koMkSB7qA688yK9p53muNGjOb5N1/O7AfqnQoNT+c3FMoL3X9xt
        8+JF//eYnhoLm/AkQHR2u3okUWG5Lhe1HcfL4EpAP3Elt+EC
X-Google-Smtp-Source: AMrXdXtuO7PHXC/9t6BJRm3T+rtebSqZWTrTlWNeQktyg6HSJXI0bO4GfuDgaAB/0Zl8pI1IO7CMVbb2yx3YzjypDJIRv23jTEPm
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:8aa:b0:30c:5f8d:886f with SMTP id
 a10-20020a056e0208aa00b0030c5f8d886fmr3413282ilt.7.1673373952169; Tue, 10 Jan
 2023 10:05:52 -0800 (PST)
Date:   Tue, 10 Jan 2023 10:05:52 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000fee03205f1ecbb8a@google.com>
Subject: [syzbot] WARNING: refcount bug in v9fs_vfs_lookup
From:   syzbot <syzbot+00234de93b9131d4d7d7@syzkaller.appspotmail.com>
To:     asmadeus@codewreck.org, ericvh@gmail.com,
        linux-kernel@vger.kernel.org, linux_oss@crudebyte.com,
        lucho@ionkov.net, syzkaller-bugs@googlegroups.com,
        v9fs-developer@lists.sourceforge.net
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

HEAD commit:    247f34f7b803 Linux 6.1-rc2
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=1299c9cc480000
kernel config:  https://syzkaller.appspot.com/x/.config?x=fa9bed8d6a8992a0
dashboard link: https://syzkaller.appspot.com/bug?extid=00234de93b9131d4d7d7
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
userspace arch: arm64
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=115972c4480000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15b43f56480000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/05f9a7fca332/disk-247f34f7.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/ec50c3ad7d48/vmlinux-247f34f7.xz
kernel image: https://storage.googleapis.com/syzbot-assets/1446f94b11ed/Image-247f34f7.gz.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+00234de93b9131d4d7d7@syzkaller.appspotmail.com

------------[ cut here ]------------
refcount_t: underflow; use-after-free.
WARNING: CPU: 0 PID: 3078 at lib/refcount.c:28 refcount_warn_saturate+0x1a0/0x1c8 lib/refcount.c:28
Modules linked in:
CPU: 0 PID: 3078 Comm: syz-executor896 Not tainted 6.1.0-rc2-syzkaller-154433-g247f34f7b803 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/26/2022
pstate: 60400005 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : refcount_warn_saturate+0x1a0/0x1c8 lib/refcount.c:28
lr : refcount_warn_saturate+0x1a0/0x1c8 lib/refcount.c:28
sp : ffff80000ff2bc10
x29: ffff80000ff2bc10 x28: ffff0000c626b480 x27: 0000000000000000
x26: 0000000000000000 x25: 0000000000000000 x24: ffff0000cb86ec8c
x23: ffff0000c690a040 x22: ffff0000ccd88c00 x21: 00000000ffffffff
x20: 0000000000000003 x19: ffff80000d95f000 x18: 000000000000005a
x17: ffff80000c0cd83c x16: 0000000000000001 x15: 0000000000000000
x14: 0000000000000000 x13: 205d383730335420 x12: 5b5d373634343736
x11: ff808000081c650c x10: 0000000000000000 x9 : e7557c2201ef4a00
x8 : e7557c2201ef4a00 x7 : 205b5d3736343437 x6 : ffff80000c0903b4
x5 : 0000000000000000 x4 : 0000000000000001 x3 : 0000000000000000
x2 : ffff0001fefbecc8 x1 : 0000000100000000 x0 : 0000000000000026
Call trace:
 refcount_warn_saturate+0x1a0/0x1c8 lib/refcount.c:28
 __refcount_sub_and_test include/linux/refcount.h:283 [inline]
 __refcount_dec_and_test include/linux/refcount.h:315 [inline]
 refcount_dec_and_test include/linux/refcount.h:333 [inline]
 p9_fid_put include/net/9p/client.h:275 [inline]
 v9fs_vfs_lookup+0x2e8/0x37c fs/9p/vfs_inode.c:778
 __lookup_hash+0xa0/0x164 fs/namei.c:1601
 filename_create+0x108/0x218 fs/namei.c:3807
 do_mknodat+0x120/0x3e8 fs/namei.c:3951
 __do_sys_mknodat fs/namei.c:3992 [inline]
 __se_sys_mknodat fs/namei.c:3989 [inline]
 __arm64_sys_mknodat+0x4c/0x64 fs/namei.c:3989
 __invoke_syscall arch/arm64/kernel/syscall.c:38 [inline]
 invoke_syscall arch/arm64/kernel/syscall.c:52 [inline]
 el0_svc_common+0x138/0x220 arch/arm64/kernel/syscall.c:142
 do_el0_svc+0x48/0x164 arch/arm64/kernel/syscall.c:206
 el0_svc+0x58/0x150 arch/arm64/kernel/entry-common.c:636
 el0t_64_sync_handler+0x84/0xf0 arch/arm64/kernel/entry-common.c:654
 el0t_64_sync+0x18c/0x190 arch/arm64/kernel/entry.S:581
irq event stamp: 0
hardirqs last  enabled at (0): [<0000000000000000>] 0x0
hardirqs last disabled at (0): [<ffff8000080f30f0>] copy_process+0x928/0x16ec kernel/fork.c:2197
softirqs last  enabled at (0): [<ffff8000080f3100>] copy_process+0x938/0x16ec kernel/fork.c:2198
softirqs last disabled at (0): [<0000000000000000>] 0x0
---[ end trace 0000000000000000 ]---
------------[ cut here ]------------
refcount_t: saturated; leaking memory.
WARNING: CPU: 0 PID: 3078 at lib/refcount.c:22 refcount_warn_saturate+0x160/0x1c8 lib/refcount.c:22
Modules linked in:
CPU: 0 PID: 3078 Comm: syz-executor896 Tainted: G        W          6.1.0-rc2-syzkaller-154433-g247f34f7b803 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/26/2022
pstate: 60400005 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : refcount_warn_saturate+0x160/0x1c8 lib/refcount.c:22
lr : refcount_warn_saturate+0x160/0x1c8 lib/refcount.c:22
sp : ffff80000ff2bb60
x29: ffff80000ff2bb60 x28: ffff0000ccd88c00 x27: ffff0000c68ffe58
x26: 00000000c0000001 x25: ffff0000cb86ec8c x24: 0000000000000000
x23: 0000000000000000 x22: ffff0000cb86ec80 x21: 0000000000000000
x20: 0000000000000001 x19: ffff80000d95f000 x18: 000000000000005a
x17: ffff80000c0cd83c x16: 0000000000000002 x15: 0000000000000000
x14: 0000000000000000 x13: 205d383730335420 x12: 5b5d383739373337
x11: ff808000081c650c x10: 0000000000000000 x9 : e7557c2201ef4a00
x8 : e7557c2201ef4a00 x7 : 205b5d3837393733 x6 : ffff80000c0903b4
x5 : 0000000000000000 x4 : 0000000000000001 x3 : 0000000000000000
x2 : 0000000000000000 x1 : 0000000100000001 x0 : 0000000000000026
Call trace:
 refcount_warn_saturate+0x160/0x1c8 lib/refcount.c:22
 __refcount_inc include/linux/refcount.h:250 [inline]
 refcount_inc include/linux/refcount.h:267 [inline]
 p9_fid_get include/net/9p/client.h:262 [inline]
 v9fs_fid_find fs/9p/fid.c:115 [inline]
 v9fs_fid_lookup_with_uid+0x8a0/0xa80 fs/9p/fid.c:167
 v9fs_fid_lookup+0xc8/0xdc fs/9p/fid.c:300
 v9fs_parent_fid fs/9p/fid.h:14 [inline]
 v9fs_vfs_mknod_dotl+0x64/0x414 fs/9p/vfs_inode_dotl.c:847
 v9fs_vfs_create_dotl+0x40/0x54 fs/9p/vfs_inode_dotl.c:226
 vfs_create+0x1c8/0x270 fs/namei.c:3115
 do_mknodat+0x274/0x3e8 fs/namei.c:3964
 __do_sys_mknodat fs/namei.c:3992 [inline]
 __se_sys_mknodat fs/namei.c:3989 [inline]
 __arm64_sys_mknodat+0x4c/0x64 fs/namei.c:3989
 __invoke_syscall arch/arm64/kernel/syscall.c:38 [inline]
 invoke_syscall arch/arm64/kernel/syscall.c:52 [inline]
 el0_svc_common+0x138/0x220 arch/arm64/kernel/syscall.c:142
 do_el0_svc+0x48/0x164 arch/arm64/kernel/syscall.c:206
 el0_svc+0x58/0x150 arch/arm64/kernel/entry-common.c:636
 el0t_64_sync_handler+0x84/0xf0 arch/arm64/kernel/entry-common.c:654
 el0t_64_sync+0x18c/0x190 arch/arm64/kernel/entry.S:581
irq event stamp: 0
hardirqs last  enabled at (0): [<0000000000000000>] 0x0
hardirqs last disabled at (0): [<ffff8000080f30f0>] copy_process+0x928/0x16ec kernel/fork.c:2197
softirqs last  enabled at (0): [<ffff8000080f3100>] copy_process+0x938/0x16ec kernel/fork.c:2198
softirqs last disabled at (0): [<0000000000000000>] 0x0
---[ end trace 0000000000000000 ]---
Unable to handle kernel NULL pointer dereference at virtual address 0000000000000048
Mem abort info:
  ESR = 0x0000000096000006
  EC = 0x25: DABT (current EL), IL = 32 bits
  SET = 0, FnV = 0
  EA = 0, S1PTW = 0
  FSC = 0x06: level 2 translation fault
Data abort info:
  ISV = 0, ISS = 0x00000006
  CM = 0, WnR = 0
user pgtable: 4k pages, 48-bit VAs, pgdp=000000010743b000
[0000000000000048] pgd=080000010b9e9003, p4d=080000010b9e9003, pud=080000010b856003, pmd=0000000000000000
Internal error: Oops: 0000000096000006 [#1] PREEMPT SMP
Modules linked in:
CPU: 0 PID: 3078 Comm: syz-executor896 Tainted: G        W          6.1.0-rc2-syzkaller-154433-g247f34f7b803 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/26/2022
pstate: 80400005 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : p9_client_rpc+0x4c/0x548 net/9p/client.c:675
lr : p9_client_rpc+0x4c/0x548 net/9p/client.c:662
sp : ffff80000ff2bb00
x29: ffff80000ff2bb80 x28: 0000000000000000 x27: ffff0000c68ffea0
x26: ffff0000c626b480 x25: ffff0000cb86ec80 x24: ffff0000c68fff10
x23: 0000000000008000 x22: 0000000000000000 x21: ffff80000cf52863
x20: 0000000000000012 x19: 0000000000000000 x18: 000000000000005a
x17: ffff80000c0cd83c x16: 0000000000000000 x15: 0000000000000000
x14: 0000000000000000 x13: 0000000000008000 x12: ffff80000d4f0680
x11: ff8080000be7a890 x10: 0000000000000000 x9 : ffff80000be7a890
x8 : ffff0000c626b480 x7 : 0000000000000000 x6 : 0000000000000000
x5 : 0000000000008000 x4 : ffff0000c68fff10 x3 : 0000000000000000
x2 : ffff80000cf52863 x1 : 0000000000000012 x0 : 0000000000000000
Call trace:
 p9_client_rpc+0x4c/0x548 net/9p/client.c:662
 p9_client_mknod_dotl+0x70/0x100 net/9p/client.c:2115
 v9fs_vfs_mknod_dotl+0x1b0/0x414 fs/9p/vfs_inode_dotl.c:865
 v9fs_vfs_create_dotl+0x40/0x54 fs/9p/vfs_inode_dotl.c:226
 vfs_create+0x1c8/0x270 fs/namei.c:3115
 do_mknodat+0x274/0x3e8 fs/namei.c:3964
 __do_sys_mknodat fs/namei.c:3992 [inline]
 __se_sys_mknodat fs/namei.c:3989 [inline]
 __arm64_sys_mknodat+0x4c/0x64 fs/namei.c:3989
 __invoke_syscall arch/arm64/kernel/syscall.c:38 [inline]
 invoke_syscall arch/arm64/kernel/syscall.c:52 [inline]
 el0_svc_common+0x138/0x220 arch/arm64/kernel/syscall.c:142
 do_el0_svc+0x48/0x164 arch/arm64/kernel/syscall.c:206
 el0_svc+0x58/0x150 arch/arm64/kernel/entry-common.c:636
 el0t_64_sync_handler+0x84/0xf0 arch/arm64/kernel/entry-common.c:654
 el0t_64_sync+0x18c/0x190 arch/arm64/kernel/entry.S:581
Code: a9019be5 f90017e7 f81f83a8 9710b221 (f9402668) 
---[ end trace 0000000000000000 ]---
----------------
Code disassembly (best guess):
   0:	a9019be5 	stp	x5, x6, [sp, #24]
   4:	f90017e7 	str	x7, [sp, #40]
   8:	f81f83a8 	stur	x8, [x29, #-8]
   c:	9710b221 	bl	0xfffffffffc42c890
* 10:	f9402668 	ldr	x8, [x19, #72] <-- trapping instruction


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
