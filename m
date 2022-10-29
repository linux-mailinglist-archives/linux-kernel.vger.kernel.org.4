Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E2B76122EF
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Oct 2022 14:31:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229520AbiJ2Mbn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Oct 2022 08:31:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbiJ2Mbk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Oct 2022 08:31:40 -0400
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08EF04362A
        for <linux-kernel@vger.kernel.org>; Sat, 29 Oct 2022 05:31:39 -0700 (PDT)
Received: by mail-io1-f71.google.com with SMTP id v18-20020a5d9412000000b006bfdf74fa3bso5827888ion.3
        for <linux-kernel@vger.kernel.org>; Sat, 29 Oct 2022 05:31:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ym004fsDFgx/zB/z0lLrgOKDV+xptGbFs4Xx7R2vGoI=;
        b=MnmjFAaYk7nzMJ17DjZkFXxAmmJ8dVhZNz/Mwg0L1UAzkP2xB1dnghlPWdyhxKzEpC
         AROagarjiswttCU0WuGePTIKf/ImsgwH2JIJlUmnvaQUpjOJsg6OZ51+GQkidaF9s9Lk
         f1N1gjQwuxHA0yxJIjlrRmeDepJVNRW6zZh4jZiF/9Xr39xrW5sbe8JomiZ+en5W1D1i
         m58xmYNEdPG+kL7AKsom4JJMX6QGiULguyiHAnczxfWpGWvJ1TB4LWZ3gsqproYADMH4
         zx7Dh9xpZXw2RpRSWTuWtPGzs840e4GRzLT3oq0YJ8U2friGI5QCXe0d8p/GB9muTDjG
         CxEg==
X-Gm-Message-State: ACrzQf0CZ9B1IbVxx4XDfDK5z4qjQJMUIc6MccXREaxTROgQ4lRABnx+
        udnMY2xlE0C3KrGbINu8fc+fD0wHaZu30Ht1Yn0pLYOwaA1P
X-Google-Smtp-Source: AMsMyM6yYj3Ven8dfhoBe0iy5V1zLOBlynZm+KkdUPxMxN8o120+l2MelMhpimtkNiCVBxysKUgEiKbvPrqv6L6CKlXDEe77EA8U
MIME-Version: 1.0
X-Received: by 2002:a92:6807:0:b0:300:8bcc:3f48 with SMTP id
 d7-20020a926807000000b003008bcc3f48mr1897718ilc.5.1667046698366; Sat, 29 Oct
 2022 05:31:38 -0700 (PDT)
Date:   Sat, 29 Oct 2022 05:31:38 -0700
In-Reply-To: <000000000000d1d6c205ebc4d512@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000047be1405ec2b8e4d@google.com>
Subject: Re: [syzbot] kernel BUG in nilfs_btnode_create_block
From:   syzbot <syzbot+b0a35a5c1f7e846d3b09@syzkaller.appspotmail.com>
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

syzbot has found a reproducer for the following issue on:

HEAD commit:    bbed346d5a96 Merge branch 'for-next/core' into for-kernelci
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=15170eb6880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3a4a45d2d827c1e
dashboard link: https://syzkaller.appspot.com/bug?extid=b0a35a5c1f7e846d3b09
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
userspace arch: arm64
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=172e12ee880000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=100e7bce880000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/e8e91bc79312/disk-bbed346d.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/c1cb3fb3b77e/vmlinux-bbed346d.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/ba34831a439a/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+b0a35a5c1f7e846d3b09@syzkaller.appspotmail.com

------------[ cut here ]------------
kernel BUG at fs/nilfs2/btnode.c:59!
Internal error: Oops - BUG: 00000000f2000800 [#1] PREEMPT SMP
Modules linked in:
CPU: 0 PID: 3084 Comm: syz-executor420 Not tainted 6.0.0-rc7-syzkaller-18095-gbbed346d5a96 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/30/2022
pstate: 80400005 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : nilfs_btnode_create_block+0x1c0/0x2f8 fs/nilfs2/btnode.c:58
lr : nilfs_btnode_create_block+0x1c0/0x2f8 fs/nilfs2/btnode.c:58
sp : ffff80001285b640
x29: ffff80001285b640 x28: 00000000000a0011 x27: ffff0000caea8498
x26: 00000000000a0011 x25: 0000000000000001 x24: ffff0000caea8498
x23: 000000000000000a x22: 0000000000020011 x21: ffff0000caec0748
x20: 0000000000000927 x19: ffff0000caf52f18 x18: 000000000000009a
x17: ffff8001f1d5e000 x16: 0000000000000000 x15: 0000000000000000
x14: 0000000000000000 x13: 0000000000000406 x12: ffff80000d4551e8
x11: ff80800008634750 x10: 0000000000000000 x9 : 00000000ffffffff
x8 : ffff0000caf52f78 x7 : ffff8000083d3920 x6 : 0000000000000000
x5 : 0000000000000000 x4 : 0000000000020000 x3 : 000000000000000a
x2 : 0000000000000000 x1 : 0000000000000001 x0 : 0000000000000000
Call trace:
 nilfs_btnode_create_block+0x1c0/0x2f8 fs/nilfs2/btnode.c:58
 nilfs_btnode_prepare_change_key+0x138/0x19c fs/nilfs2/btnode.c:219
 nilfs_btree_prepare_update_v+0x128/0x17c fs/nilfs2/btree.c:1921
 nilfs_btree_prepare_propagate_v fs/nilfs2/btree.c:1988 [inline]
 nilfs_btree_propagate_v+0x110/0x420 fs/nilfs2/btree.c:2033
 nilfs_btree_propagate+0x258/0x350 fs/nilfs2/btree.c:2090
 nilfs_bmap_propagate+0x40/0xa8 fs/nilfs2/bmap.c:337
 nilfs_collect_file_data+0x34/0xa8 fs/nilfs2/segment.c:568
 nilfs_segctor_apply_buffers+0x84/0x168 fs/nilfs2/segment.c:1012
 nilfs_segctor_scan_file_dsync fs/nilfs2/segment.c:1101 [inline]
 nilfs_segctor_collect_blocks+0x1bc/0x93c fs/nilfs2/segment.c:1255
 nilfs_segctor_collect fs/nilfs2/segment.c:1497 [inline]
 nilfs_segctor_do_construct+0x3e4/0xee8 fs/nilfs2/segment.c:2039
 nilfs_construct_dsync_segment+0x21c/0x2ec fs/nilfs2/segment.c:2306
 nilfs_writepages+0x6c/0xa8 fs/nilfs2/inode.c:170
 do_writepages+0x144/0x27c mm/page-writeback.c:2468
 filemap_fdatawrite_wbc+0xac/0xd0 mm/filemap.c:388
 __filemap_fdatawrite_range mm/filemap.c:421 [inline]
 filemap_write_and_wait_range+0x84/0x1e8 mm/filemap.c:673
 __generic_file_write_iter+0x188/0x21c mm/filemap.c:3852
 generic_file_write_iter+0x6c/0x168 mm/filemap.c:3898
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
 el0_svc+0x58/0x150 arch/arm64/kernel/entry-common.c:636
 el0t_64_sync_handler+0x84/0xf0 arch/arm64/kernel/entry-common.c:654
 el0t_64_sync+0x18c/0x190 arch/arm64/kernel/entry.S:581
Code: 14000002 97cd2111 aa1303e0 9400004f (d4210000) 
---[ end trace 0000000000000000 ]---

