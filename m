Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BAE6658B8F
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Dec 2022 11:16:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233329AbiL2KQY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Dec 2022 05:16:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232753AbiL2KNv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Dec 2022 05:13:51 -0500
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB90E238
        for <linux-kernel@vger.kernel.org>; Thu, 29 Dec 2022 02:10:42 -0800 (PST)
Received: by mail-il1-f200.google.com with SMTP id l3-20020a056e021aa300b00304be32e9e5so11643764ilv.12
        for <linux-kernel@vger.kernel.org>; Thu, 29 Dec 2022 02:10:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=S97zZjYwnpI6YqLvYJXm6ctfa/y9VI6lmrB2DEyZSAk=;
        b=7MlwWvDm+pRs3qe3BGmUfRFS5MivB7Bzx8HfBgT0PG5vbzmhCH8tR/+YgVNk2p4Rwf
         tvfgT6LzbFSLe2EbgCuPHKUZFQrSvI5/bNmyWyM2zeOWS68T9BjKTgkEeGdkyotCfsq7
         rqeuuEdHeCn82QIDhmsy0Tg49mK1vCbMC72gFyUO381xwkxmjBTqMP7bmLcH8z29KXxf
         CnyEYA7F64jgt7IqYzOMlHXI0hRfT1jaQx4HSpSGAj7g1Klm31FziSAq1KUnLHMZmLTQ
         PbO3N3sXWjgCxHK32P7ln9USRNMt7vVnPNVrfc8XOIA8MgTBVHtSvMGSL7wsEfSDSUzs
         +3Lg==
X-Gm-Message-State: AFqh2kq9TQbdgih9vEUtdG1gDlTkmRoBAN9PQWvNUTIM+T/BFIe9/Hbt
        di106lp6x0OfcKK1ySb/YiOayFWV3g4S2zmUMAbFXqNnPOE/
X-Google-Smtp-Source: AMrXdXs/InDKv6EXIbaVmYdCzw9A31EE/FkPxdnv4GxfUbkTKcM5eyyVsC7BS9ukRcV9s+AnyS1y+f4tRaunsf8RJfNTVaAbnljk
MIME-Version: 1.0
X-Received: by 2002:a92:cb42:0:b0:305:eba6:78ab with SMTP id
 f2-20020a92cb42000000b00305eba678abmr1775338ilq.316.1672308642172; Thu, 29
 Dec 2022 02:10:42 -0800 (PST)
Date:   Thu, 29 Dec 2022 02:10:42 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000092558d05f0f4b219@google.com>
Subject: [syzbot] [xfs?] BUG: corrupted list in xfs_trans_del_item
From:   syzbot <syzbot+5d3521f1abbb5c599e55@syzkaller.appspotmail.com>
To:     dchinner@redhat.com, djwong@kernel.org,
        linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
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

HEAD commit:    a5541c0811a0 Merge branch 'for-next/core' into for-kernelci
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=10dd01ac480000
kernel config:  https://syzkaller.appspot.com/x/.config?x=cbd4e584773e9397
dashboard link: https://syzkaller.appspot.com/bug?extid=5d3521f1abbb5c599e55
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
userspace arch: arm64
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13bf9550480000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=146deeb0480000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/4b7702208fb9/disk-a5541c08.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/9ec0153ec051/vmlinux-a5541c08.xz
kernel image: https://storage.googleapis.com/syzbot-assets/6f8725ad290a/Image-a5541c08.gz.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/0b962d567fb3/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+5d3521f1abbb5c599e55@syzkaller.appspotmail.com

XFS (loop0): Metadata corruption detected at xfs_btree_lookup_get_block+0x220/0x2b0 fs/xfs/libxfs/xfs_btree.c:1846, xfs_refcountbt block 0x18
XFS (loop0): Unmount and run xfs_repair
list_del corruption, ffff0000c66a53f8->next is NULL
------------[ cut here ]------------
kernel BUG at lib/list_debug.c:50!
Internal error: Oops - BUG: 00000000f2000800 [#1] PREEMPT SMP
Modules linked in:
CPU: 0 PID: 3071 Comm: syz-executor314 Not tainted 6.1.0-rc8-syzkaller-33330-ga5541c0811a0 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/26/2022
pstate: 60400005 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : __list_del_entry_valid+0x70/0xd0 lib/list_debug.c:49
lr : __list_del_entry_valid+0x70/0xd0 lib/list_debug.c:49
sp : ffff80000fedb8e0
x29: ffff80000fedb8e0 x28: ffff0000c71ab480 x27: 0000000000000000
x26: ffff0000c970b400 x25: 0000000000000000 x24: 000000000000000d
x23: ffff0000c66a5128 x22: ffff0000c66a5190 x21: 0000000000000000
x20: ffff0000c66a53f8 x19: ffff0000c66a53e8 x18: 00000000000000c0
x17: ffff80000dda8198 x16: ffff80000dbe6158 x15: ffff0000c71ab480
x14: 0000000000000000 x13: 00000000ffffffff x12: ffff0000c71ab480
x11: ff808000081c4d64 x10: 0000000000000000 x9 : 0c68720d3549f800
x8 : 0c68720d3549f800 x7 : ffff80000c091ebc x6 : 0000000000000000
x5 : 0000000000000080 x4 : 0000000000000001 x3 : 0000000000000000
x2 : 0000000000000000 x1 : 0000000100000000 x0 : 0000000000000033
Call trace:
 __list_del_entry_valid+0x70/0xd0 lib/list_debug.c:49
 __list_del_entry include/linux/list.h:134 [inline]
 list_del_init include/linux/list.h:206 [inline]
 xfs_trans_del_item+0x38/0x94 fs/xfs/xfs_trans.c:696
 xfs_trans_brelse+0xa0/0xdc fs/xfs/xfs_trans_buf.c:385
 xfs_btree_del_cursor+0x64/0x134 fs/xfs/libxfs/xfs_btree.c:440
 xfs_refcount_recover_cow_leftovers+0x150/0x344 fs/xfs/libxfs/xfs_refcount.c:1834
 xfs_reflink_recover_cow+0x5c/0x100 fs/xfs/xfs_reflink.c:930
 xlog_recover_finish+0x310/0x3bc fs/xfs/xfs_log_recover.c:3493
 xfs_log_mount_finish+0xd4/0x250 fs/xfs/xfs_log.c:827
 xfs_mountfs+0x7e4/0xb38 fs/xfs/xfs_mount.c:919
 xfs_fs_fill_super+0x804/0x880 fs/xfs/xfs_super.c:1666
 get_tree_bdev+0x1e8/0x2a0 fs/super.c:1324
 xfs_fs_get_tree+0x28/0x38 fs/xfs/xfs_super.c:1713
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
 do_el0_svc+0x48/0x140 arch/arm64/kernel/syscall.c:197
 el0_svc+0x58/0x150 arch/arm64/kernel/entry-common.c:637
 el0t_64_sync_handler+0x84/0xf0 arch/arm64/kernel/entry-common.c:655
 el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:584
Code: d65f03c0 b001b740 91013000 94aa89fa (d4210000) 
---[ end trace 0000000000000000 ]---


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
