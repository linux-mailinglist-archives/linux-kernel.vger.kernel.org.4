Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64364607F37
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 21:44:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230432AbiJUTn5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 15:43:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230180AbiJUTno (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 15:43:44 -0400
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 398E5285111
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 12:43:42 -0700 (PDT)
Received: by mail-il1-f199.google.com with SMTP id a8-20020a92c548000000b002f6440ff96bso4438489ilj.22
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 12:43:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xh+/uHbBfqTwYHBQyuE4yJvKOyOgPf1lL6+dRZHX3p8=;
        b=l4h/8qkx+m3KVN2t1G+zMsTekKu+UYa0IP4QehF/CDXat00ON1bwCey+2YHKnpcqzn
         6OdG7N29r6ncyoJBJ7ZLcWtKf6TNVTXZufvOzsviB8y2jkmyYysnlkE4N95bkWDMNZMb
         tqI/ZDA0NRH8DwdMhwP7PenR/82tHZjTnBRebGXzI3IbyLQcPODD2vsJdaO8G7Vy0E+e
         fcF2jHvdNOt8IUNDmzEPZ5modO0woLafzXzREWCHV3I6KJcYVGMC3c/c2v5gN1jfwrdz
         uQtKE52ZlLYFZr3vQGEuuMBXaHyhdP8iQwTxA9WJzgmS/6CRzcRyDlj2XWMZVBYBjRTa
         giEg==
X-Gm-Message-State: ACrzQf0JNuNtkq3hfkcryC1Ux2GbKjkpzzFBql7f+OyCN2cjhGC7jdYj
        Bpt6AJW+2l1nMOTCS6drhd3UxsB55ARGHshZnwVPvf9mYu78
X-Google-Smtp-Source: AMsMyM6BF6cf79YAE8HKxFLnIycKYXedYvWNbCoI0C8pXm3JWSH0ohuR5QJXiL0mF/N2+MT+8PyxWlXro70FAre0MvXPN0KDSpFj
MIME-Version: 1.0
X-Received: by 2002:a02:ca0d:0:b0:363:8e90:913c with SMTP id
 i13-20020a02ca0d000000b003638e90913cmr16817826jak.97.1666381421403; Fri, 21
 Oct 2022 12:43:41 -0700 (PDT)
Date:   Fri, 21 Oct 2022 12:43:41 -0700
In-Reply-To: <000000000000f8389205e9f9ec5f@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000aee20105eb90a803@google.com>
Subject: Re: [syzbot] KASAN: use-after-free Read in crc_itu_t
From:   syzbot <syzbot+d8fc21bfa138a5ae916d@syzkaller.appspotmail.com>
To:     jack@suse.com, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has found a reproducer for the following issue on:

HEAD commit:    bbed346d5a96 Merge branch 'for-next/core' into for-kernelci
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=1160ec86880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3a4a45d2d827c1e
dashboard link: https://syzkaller.appspot.com/bug?extid=d8fc21bfa138a5ae916d
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
userspace arch: arm64
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15b5373a880000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11200026880000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/e8e91bc79312/disk-bbed346d.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/c1cb3fb3b77e/vmlinux-bbed346d.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/f8dde53eb773/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+d8fc21bfa138a5ae916d@syzkaller.appspotmail.com

netdevsim netdevsim0 netdevsim2: set [1, 0] type 2 family 0 port 6081 - 0
netdevsim netdevsim0 netdevsim3: set [1, 0] type 2 family 0 port 6081 - 0
loop0: detected capacity change from 0 to 2048
Unable to handle kernel NULL pointer dereference at virtual address 000000000000001a
Mem abort info:
  ESR = 0x0000000096000006
  EC = 0x25: DABT (current EL), IL = 32 bits
  SET = 0, FnV = 0
  EA = 0, S1PTW = 0
  FSC = 0x06: level 2 translation fault
Data abort info:
  ISV = 0, ISS = 0x00000006
  CM = 0, WnR = 0
user pgtable: 4k pages, 48-bit VAs, pgdp=0000000107067000
[000000000000001a] pgd=080000010904b003, p4d=080000010904b003, pud=0800000109e4e003, pmd=0000000000000000
Internal error: Oops: 0000000096000006 [#1] PREEMPT SMP
Modules linked in:
CPU: 0 PID: 3031 Comm: syz-executor632 Not tainted 6.0.0-rc7-syzkaller-18095-gbbed346d5a96 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/30/2022
pstate: 80400005 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : crc_itu_t+0x40/0x88 lib/crc-itu-t.c:60
lr : crc_itu_t+0x30/0x88 lib/crc-itu-t.c:59
sp : ffff800012a03a20
x29: ffff800012a03a20 x28: 0000000000000026 x27: 000000000000002c
x26: 00000000fffffff0 x25: 0000000000000000 x24: 00000000b147c223
x23: ffff0000c752c690 x22: ffff80000c170b50 x21: 000000000000ffd9
x20: 000000000000001a x19: 00000000b147c223 x18: 00000000000000c0
x17: ffff80000dd0b198 x16: ffff80000db49158 x15: ffff0000c5d8cf80
x14: 0000000000000010 x13: 0000000000000000 x12: ffff0000c5d8cf80
x11: ff808000095d5cec x10: 0000000000000000 x9 : ffff0000c5d8cf80
x8 : ffff8000095d5cec x7 : 0000000000000000 x6 : 0000000000000000
x5 : 0000000000000000 x4 : 0000000000000004 x3 : 0000000000000010
x2 : 000000000000ffda x1 : 000000000000ffda x0 : 0000000000000000
Call trace:
 crc_itu_t+0x40/0x88
 udf_write_fi+0x308/0x4e0
 udf_delete_entry fs/udf/namei.c:577 [inline]
 udf_rename+0x47c/0x6d0 fs/udf/namei.c:1173
 vfs_rename+0x59c/0x7f8 fs/namei.c:4756
 do_renameat2+0x490/0x758 fs/namei.c:4907
 __do_sys_renameat2 fs/namei.c:4940 [inline]
 __se_sys_renameat2 fs/namei.c:4937 [inline]
 __arm64_sys_renameat2+0x6c/0x88 fs/namei.c:4937
 __invoke_syscall arch/arm64/kernel/syscall.c:38 [inline]
 invoke_syscall arch/arm64/kernel/syscall.c:52 [inline]
 el0_svc_common+0x138/0x220 arch/arm64/kernel/syscall.c:142
 do_el0_svc+0x48/0x164 arch/arm64/kernel/syscall.c:206
 el0_svc+0x58/0x150 arch/arm64/kernel/entry-common.c:636
 el0t_64_sync_handler+0x84/0xf0 arch/arm64/kernel/entry-common.c:654
 el0t_64_sync+0x18c/0x190 arch/arm64/kernel/entry.S:581
Code: b40001f5 f0015cd6 d10006b5 912d42d6 (38401688) 
---[ end trace 0000000000000000 ]---
----------------
Code disassembly (best guess):
   0:	b40001f5 	cbz	x21, 0x3c
   4:	f0015cd6 	adrp	x22, 0x2b9b000
   8:	d10006b5 	sub	x21, x21, #0x1
   c:	912d42d6 	add	x22, x22, #0xb50
* 10:	38401688 	ldrb	w8, [x20], #1 <-- trapping instruction

