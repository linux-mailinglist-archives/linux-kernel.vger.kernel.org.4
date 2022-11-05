Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E58EB61DBE6
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Nov 2022 17:08:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230041AbiKEQIB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Nov 2022 12:08:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229776AbiKEQHy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Nov 2022 12:07:54 -0400
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 475A71006A
        for <linux-kernel@vger.kernel.org>; Sat,  5 Nov 2022 09:07:53 -0700 (PDT)
Received: by mail-io1-f70.google.com with SMTP id i3-20020a5d8403000000b006c9271c3465so4793081ion.4
        for <linux-kernel@vger.kernel.org>; Sat, 05 Nov 2022 09:07:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Hgagf5yt2ztu2Dh9gjwBpSIVGJIV3SmeqpqowU6PJR0=;
        b=aBUqfu/YoNwGr7ORMEjkGWzqRWOblLSN+SsHr/zB4bvw0Nm0Srk7CyJqcinXtTQC9O
         ZDqutQAXeiPUHs+0S6Ig+6y4nUHNpV1GxxM/hgflu/ku3bJ61FBXXj3oofRuSfm9vh6o
         LoIRLXUY3AGwsEv8B9wg+6rSNpZL4IgNoSni3AIrkl1MQ4433DTP68IW6Fveum9QZ2aU
         gsdNCw7pqbxvhXFOAxLbrvAqSpA2QDucWWvx9P07f10c/1Jye7AAHU4eQAz+oFUknwuu
         fxM89mmSxabqft++EqPVZkrTTOj6U498+1YsxFfj/M0Ns60fPKL3jD24C80gKPikZWNJ
         FrnA==
X-Gm-Message-State: ACrzQf0H8GDU2XUpglaTLuts2RT0dXqG6wu6dE5NlfUSZgouo4+sUFJc
        pAx2xh3yhOcEt2TkdzqZRT5QWy5xOjYQYBX1Ombn9MqPkX+3
X-Google-Smtp-Source: AMsMyM7+L/Ks+6LzUtDtTqj53oUeWY2zWjTgHCQ4Bm1/lzpOQd3wU44gns3zIg+NP3Tfc/YxqV9z6ZOXe+1uRXV+u8/hpGuna5jE
MIME-Version: 1.0
X-Received: by 2002:a05:6638:4910:b0:375:4b54:fcfb with SMTP id
 cx16-20020a056638491000b003754b54fcfbmr23910633jab.264.1667664472357; Sat, 05
 Nov 2022 09:07:52 -0700 (PDT)
Date:   Sat, 05 Nov 2022 09:07:52 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000007ac73805ecbb64f7@google.com>
Subject: [syzbot] BUG: unable to handle kernel NULL pointer dereference in udf_rename
From:   syzbot <syzbot+17fcf98a689ff64f669b@syzkaller.appspotmail.com>
To:     jack@suse.com, linux-kernel@vger.kernel.org,
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

HEAD commit:    bbed346d5a96 Merge branch 'for-next/core' into for-kernelci
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=17a63346880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3a4a45d2d827c1e
dashboard link: https://syzkaller.appspot.com/bug?extid=17fcf98a689ff64f669b
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
userspace arch: arm64
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=100d5e2e880000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17fb8b39880000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/e8e91bc79312/disk-bbed346d.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/c1cb3fb3b77e/vmlinux-bbed346d.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/b990eb66b8ea/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+17fcf98a689ff64f669b@syzkaller.appspotmail.com

loop0: detected capacity change from 0 to 2048
UDF-fs: INFO Mounting volume 'LinuxUDF', timestamp 2022/09/12 12:00 (1000)
Unable to handle kernel NULL pointer dereference at virtual address 0000000000000020
Mem abort info:
  ESR = 0x0000000096000046
  EC = 0x25: DABT (current EL), IL = 32 bits
  SET = 0, FnV = 0
  EA = 0, S1PTW = 0
  FSC = 0x06: level 2 translation fault
Data abort info:
  ISV = 0, ISS = 0x00000046
  CM = 0, WnR = 1
user pgtable: 4k pages, 48-bit VAs, pgdp=0000000109085000
[0000000000000020] pgd=0800000106b68003, p4d=0800000106b68003, pud=0800000106b69003, pmd=0000000000000000
Internal error: Oops: 0000000096000046 [#1] PREEMPT SMP
Modules linked in:
CPU: 0 PID: 3036 Comm: syz-executor863 Not tainted 6.0.0-rc7-syzkaller-18095-gbbed346d5a96 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/30/2022
pstate: 80400005 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : __memset+0x84/0x188 arch/arm64/lib/memset.S:100
lr : udf_write_fi+0x268/0x4e0
sp : ffff800012a53a50
x29: ffff800012a53a70 x28: 00000000000000d6 x27: 00000000000000d6
x26: 00000000fffffff0 x25: 0000000000000000 x24: 0000000000000006
x23: 00000000ffffffd4 x22: fffffffffffffff4 x21: ffff800012a53b40
x20: ffff800012a53b00 x19: 0000000000000003 x18: 0000000000000021
x17: 0000000000000000 x16: ffff80000db49158 x15: ffff0000c6401a80
x14: 0000000000000010 x13: 0000000000000000 x12: ffff0000c6401a80
x11: ff80800008d1bd1c x10: 0000000000000000 x9 : ffff800008d1bd1c
x8 : 0000000000000020 x7 : 0000000000000000 x6 : 0000000000000000
x5 : 0000000000000000 x4 : 0000000000000000 x3 : 0000000000000010
x2 : ffffffffffffffd4 x1 : 0000000000000000 x0 : 0000000000000020
Call trace:
 __memset+0x84/0x188 arch/arm64/lib/memset.S:98
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
Code: 54000060 5400006b a8811d07 a8811d07 (a8811d07) 
---[ end trace 0000000000000000 ]---
----------------
Code disassembly (best guess):
   0:	54000060 	b.eq	0xc  // b.none
   4:	5400006b 	b.lt	0x10  // b.tstop
   8:	a8811d07 	stp	x7, x7, [x8], #16
   c:	a8811d07 	stp	x7, x7, [x8], #16
* 10:	a8811d07 	stp	x7, x7, [x8], #16 <-- trapping instruction


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
