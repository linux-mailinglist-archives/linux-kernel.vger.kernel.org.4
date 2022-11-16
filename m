Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8A0262C934
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 20:49:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233820AbiKPTtn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 14:49:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230205AbiKPTtl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 14:49:41 -0500
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E32359FD9
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 11:49:38 -0800 (PST)
Received: by mail-il1-f199.google.com with SMTP id s1-20020a056e021a0100b003026adad6a9so5314063ild.18
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 11:49:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ylx9QLebQ8HlwldCA/mF1PGxYhL2fUmTzgnhvgEJwW8=;
        b=s29/+5nhTx28xVTByif4D0U1rgrG6KadP0GbpukN+Zt91ue6CtE14i+tRK8vaFGVke
         xd1X7uykU327ZPQbmf1F3AYh/eR1uFBQJ0bcShLZcCBO1KmXT7gMBMiLio0noITmnc+T
         GSXC2X+XlEwtaiIlUhKCLHlUVTzKPJx9koH47de9jxFUHnlBjaY/D5B9RElrdr9iZsMN
         wxwgZpO1FtMFfG+5m8aF9OP5GoDqYi08/xAnJbsUvMtDW0cpyqSiyT4OQxnGoj97F9IV
         4aOQWgBxBkGZCg1wLbx7E7yZWrIhfON40lBsxX1NPu3D5qMg7QmW0igA+YEQ6/bTs4j4
         yAyQ==
X-Gm-Message-State: ANoB5pmjRBCGFFf1MdM59EojBv2CNHLXkGv+wra+/EN22X2cCh8rftUs
        gGTaXZkNGU/x8Ge1nQoV0pqP++slHSBRsFsKbKkZIquGTRXv
X-Google-Smtp-Source: AA0mqf69YPhcGGUxa9GkyzmgDq5B5IKNcF87mVDxLG211elxXgiSy1QpD2lEwGMPYSL4SZ8zHatI+575ZdDayi8LjVYE05btFqNP
MIME-Version: 1.0
X-Received: by 2002:a02:cba5:0:b0:375:175c:b00e with SMTP id
 v5-20020a02cba5000000b00375175cb00emr10778411jap.215.1668628178282; Wed, 16
 Nov 2022 11:49:38 -0800 (PST)
Date:   Wed, 16 Nov 2022 11:49:38 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000d433c705ed9bc569@google.com>
Subject: [syzbot] BUG: unable to handle kernel paging request in p9_client_prepare_req
From:   syzbot <syzbot+69c3bf057b7a81f47758@syzkaller.appspotmail.com>
To:     asmadeus@codewreck.org, davem@davemloft.net, edumazet@google.com,
        ericvh@gmail.com, kuba@kernel.org, linux-kernel@vger.kernel.org,
        linux_oss@crudebyte.com, lucho@ionkov.net, netdev@vger.kernel.org,
        pabeni@redhat.com, syzkaller-bugs@googlegroups.com,
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

HEAD commit:    9500fc6e9e60 Merge branch 'for-next/core' into for-kernelci
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=13bdf3f1880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b25c9f218686dd5e
dashboard link: https://syzkaller.appspot.com/bug?extid=69c3bf057b7a81f47758
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
userspace arch: arm64
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17f6d5cd880000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=154f2a45880000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/1363e60652f7/disk-9500fc6e.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/fcc4da811bb6/vmlinux-9500fc6e.xz
kernel image: https://storage.googleapis.com/syzbot-assets/0b554298f1fa/Image-9500fc6e.gz.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+69c3bf057b7a81f47758@syzkaller.appspotmail.com

Unable to handle kernel paging request at virtual address bf908d5e7640333a
Mem abort info:
  ESR = 0x0000000096000004
  EC = 0x25: DABT (current EL), IL = 32 bits
  SET = 0, FnV = 0
  EA = 0, S1PTW = 0
  FSC = 0x04: level 0 translation fault
Data abort info:
  ISV = 0, ISS = 0x00000004
  CM = 0, WnR = 0
[bf908d5e7640333a] address between user and kernel address ranges
Internal error: Oops: 0000000096000004 [#1] PREEMPT SMP
Modules linked in:
CPU: 0 PID: 3084 Comm: syz-executor291 Not tainted 6.1.0-rc5-syzkaller-32269-g9500fc6e9e60 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/30/2022
pstate: 40400005 (nZcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : __kmem_cache_alloc_node+0x17c/0x350 mm/slub.c:3437
lr : slab_pre_alloc_hook mm/slab.h:712 [inline]
lr : slab_alloc_node mm/slub.c:3318 [inline]
lr : __kmem_cache_alloc_node+0x80/0x350 mm/slub.c:3437
sp : ffff80000ff636c0
x29: ffff80000ff636d0 x28: ffff0000c9848000 x27: 0000000000000000
x26: 0000000000001000 x25: 00000000ffffffff x24: ffff80000bea07bc
x23: 0000000000001000 x22: bf908d5e76402b3a x21: 0000000000000000
x20: 0000000000000c40 x19: ffff0000c0001700 x18: 000000000000ba7e
x17: 000000000000b67e x16: ffff80000dc18158 x15: ffff0000c9848000
x14: 0000000000000010 x13: 0000000000000000 x12: ffff0000c9848000
x11: 0000000000000001 x10: 0000000000000000 x9 : 0000000000000800
x8 : 00000000000613f9 x7 : ffff8000084c0640 x6 : 0000000000000000
x5 : 0000000000000000 x4 : 0000000000000001 x3 : 0000000000061401
x2 : 0000000000000000 x1 : 0000000000000c40 x0 : fffffc00032ed000
Call trace:
 next_tid mm/slub.c:2349 [inline]
 slab_alloc_node mm/slub.c:3382 [inline]
 __kmem_cache_alloc_node+0x17c/0x350 mm/slub.c:3437
 __do_kmalloc_node mm/slab_common.c:954 [inline]
 __kmalloc+0xb4/0x140 mm/slab_common.c:968
 kmalloc include/linux/slab.h:558 [inline]
 p9_fcall_init net/9p/client.c:228 [inline]
 p9_tag_alloc net/9p/client.c:293 [inline]
 p9_client_prepare_req+0x2b0/0x53c net/9p/client.c:631
 p9_client_rpc+0xbc/0x548 net/9p/client.c:678
 p9_client_flush+0x118/0x1b0 net/9p/client.c:596
 p9_client_rpc+0x4cc/0x548 net/9p/client.c:724
 p9_client_create+0x4d8/0x758 net/9p/client.c:1015
 v9fs_session_init+0xa4/0x9f0 fs/9p/v9fs.c:408
 v9fs_mount+0x6c/0x568 fs/9p/vfs_super.c:126
 legacy_get_tree+0x30/0x74 fs/fs_context.c:610
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
