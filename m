Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C6EE5E7F86
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 18:18:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229891AbiIWQSJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 12:18:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232193AbiIWQRm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 12:17:42 -0400
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D66B214B84C
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 09:17:01 -0700 (PDT)
Received: by mail-io1-f70.google.com with SMTP id j20-20020a6b3114000000b006a3211a0ff0so218398ioa.7
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 09:17:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date;
        bh=GMwDSGFnm2GFMzJ4MWSvEgNZvThA12X05V380Vfyex8=;
        b=HpTkkiRtTATHh6FSfKo9nYLSa3bsfNx5TDZBSP3b15ckQ6W1krrgya8MMkBwVrevSA
         y3FLjj4gJGO3Td/eiIrs3JnIe6UmWOYnrM3iKZABXxYdqGHthHUBWs24+sFdgqHeHLM8
         fY4ZGSpUAa/uLsn0Pn3UM7pSNfNFT/I7YPKVDt2VPgOIhQh9EHOn96KTqZARsaI5Tmhh
         uE+qoQEWkSZrhOzgmu/v2POrDH4MU66Vvu/ylwyACo028Mq2TvnJdtHpkvBphpiIyed3
         7tF82GpbFSX61dct3R3AwKnEiwFpyw7xoHDt/+p5l4PIYLpaT3L6B7hyJ4EN/nRpvq6F
         pnHw==
X-Gm-Message-State: ACrzQf2KkEQfg73t57WY9oi3K+dLpQ4XVR0PZVkBwmHtgTUPB8Pg8HJF
        Lk+IJATktRNOqAbQR7xK5NY/HhbY5AfWfT/fKpIwnEkusYNE
X-Google-Smtp-Source: AMsMyM6SoStmsF7msAMqBk7Q1pOlrtqxoZZz9b2tVrTy+VGKGHSk42OkBLBaygCHIwVo5TVRpX5B7yzzsaBSWg5VVtcJiEWu/olB
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1bea:b0:2f6:5e61:bf0d with SMTP id
 y10-20020a056e021bea00b002f65e61bf0dmr4869815ilv.117.1663949805136; Fri, 23
 Sep 2022 09:16:45 -0700 (PDT)
Date:   Fri, 23 Sep 2022 09:16:45 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000000f316f05e95a815f@google.com>
Subject: [syzbot] BUG: unable to handle kernel NULL pointer dereference in ni_write_inode
From:   syzbot <syzbot+f45957555ed4a808cc7a@syzkaller.appspotmail.com>
To:     almaz.alexandrovich@paragon-software.com,
        linux-kernel@vger.kernel.org, ntfs3@lists.linux.dev,
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

HEAD commit:    16c9f284e746 Merge branch 'for-next/core', remote-tracking..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=15e17bf8880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=15a770deac0c935a
dashboard link: https://syzkaller.appspot.com/bug?extid=f45957555ed4a808cc7a
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
userspace arch: arm64
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11827ec4880000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1518404c880000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/fd8978a3a764/disk-16c9f284.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/73ab1c321ad6/vmlinux-16c9f284.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+f45957555ed4a808cc7a@syzkaller.appspotmail.com

loop0: detected capacity change from 0 to 264192
ntfs3: loop0: Failed to load $Extend.
Unable to handle kernel NULL pointer dereference at virtual address 0000000000000016
Mem abort info:
  ESR = 0x0000000096000006
  EC = 0x25: DABT (current EL), IL = 32 bits
  SET = 0, FnV = 0
  EA = 0, S1PTW = 0
  FSC = 0x06: level 2 translation fault
Data abort info:
  ISV = 0, ISS = 0x00000006
  CM = 0, WnR = 0
user pgtable: 4k pages, 48-bit VAs, pgdp=000000010af56000
[0000000000000016] pgd=08000001090da003, p4d=08000001090da003, pud=08000001090ce003, pmd=0000000000000000
Internal error: Oops: 0000000096000006 [#1] PREEMPT SMP
Modules linked in:
CPU: 1 PID: 3036 Comm: syz-executor206 Not tainted 6.0.0-rc6-syzkaller-17739-g16c9f284e746 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/26/2022
pstate: 80400005 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : is_rec_inuse fs/ntfs3/ntfs.h:313 [inline]
pc : ni_write_inode+0xac/0x798 fs/ntfs3/frecord.c:3232
lr : ni_write_inode+0xa0/0x798 fs/ntfs3/frecord.c:3226
sp : ffff8000126c3800
x29: ffff8000126c3860 x28: 0000000000000000 x27: ffff0000c8b02000
x26: ffff0000c7502320 x25: ffff0000c7502288 x24: 0000000000000000
x23: ffff80000cbec91c x22: ffff0000c8b03000 x21: ffff0000c8b02000
x20: 0000000000000001 x19: ffff0000c75024d8 x18: 00000000000000c0
x17: ffff80000dd1b198 x16: ffff80000db59158 x15: ffff0000c4b6b500
x14: 00000000000000b8 x13: 0000000000000000 x12: ffff0000c4b6b500
x11: ff80800008be1b60 x10: 0000000000000000 x9 : ffff0000c4b6b500
x8 : 0000000000000000 x7 : ffff800008be1b50 x6 : 0000000000000000
x5 : 0000000000000000 x4 : 0000000000000001 x3 : 0000000000000000
x2 : 0000000000000008 x1 : 0000000000000001 x0 : 0000000000000000
Call trace:
 is_rec_inuse fs/ntfs3/ntfs.h:313 [inline]
 ni_write_inode+0xac/0x798 fs/ntfs3/frecord.c:3232
 ntfs_evict_inode+0x54/0x84 fs/ntfs3/inode.c:1744
 evict+0xec/0x334 fs/inode.c:665
 iput_final fs/inode.c:1748 [inline]
 iput+0x2c4/0x324 fs/inode.c:1774
 ntfs_new_inode+0x7c/0xe0 fs/ntfs3/fsntfs.c:1660
 ntfs_create_inode+0x20c/0xe78 fs/ntfs3/inode.c:1278
 ntfs_create+0x54/0x74 fs/ntfs3/namei.c:100
 lookup_open fs/namei.c:3413 [inline]
 open_last_lookups fs/namei.c:3481 [inline]
 path_openat+0x804/0x11c4 fs/namei.c:3688
 do_filp_open+0xdc/0x1b8 fs/namei.c:3718
 do_sys_openat2+0xb8/0x22c fs/open.c:1311
 do_sys_open fs/open.c:1327 [inline]
 __do_sys_openat fs/open.c:1343 [inline]
 __se_sys_openat fs/open.c:1338 [inline]
 __arm64_sys_openat+0xb0/0xe0 fs/open.c:1338
 __invoke_syscall arch/arm64/kernel/syscall.c:38 [inline]
 invoke_syscall arch/arm64/kernel/syscall.c:52 [inline]
 el0_svc_common+0x138/0x220 arch/arm64/kernel/syscall.c:142
 do_el0_svc+0x48/0x164 arch/arm64/kernel/syscall.c:206
 el0_svc+0x58/0x150 arch/arm64/kernel/entry-common.c:636
 el0t_64_sync_handler+0x84/0xf0 arch/arm64/kernel/entry-common.c:654
 el0t_64_sync+0x18c/0x190
Code: 97dafee4 340001b4 f9401328 2a1f03e0 (79402d14) 
---[ end trace 0000000000000000 ]---
----------------
Code disassembly (best guess):
   0:	97dafee4 	bl	0xffffffffff6bfb90
   4:	340001b4 	cbz	w20, 0x38
   8:	f9401328 	ldr	x8, [x25, #32]
   c:	2a1f03e0 	mov	w0, wzr
* 10:	79402d14 	ldrh	w20, [x8, #22] <-- trapping instruction


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
