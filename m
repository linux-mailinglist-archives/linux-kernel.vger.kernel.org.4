Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB0785EAE57
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 19:40:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231171AbiIZRkn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 13:40:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230510AbiIZRkL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 13:40:11 -0400
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2854E8A1D7
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 10:05:46 -0700 (PDT)
Received: by mail-io1-f72.google.com with SMTP id f25-20020a5d8799000000b006a44e33ddb6so4179844ion.1
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 10:05:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date;
        bh=y28CCcBuJ1ylNWh8a512gzTxThjJ7xoc0njafP1n4Lk=;
        b=r1q96kYj+P4WxfbTz9WA3Ti6MVWL3rFsc1guBJcCY3QaHoc6Rqc35WQwnMg87833ap
         OJ5/St43wgl4FYTRCwYQG0webGkU5ntLuq3gllEiAbHddNtcBQ7t0DSm1r+BhOcwmYd4
         J3ZHkQodf+XYZT61HL4EJfRlx2kq7rh1i3k9ODxDM4/1sA7Ea2AywuvMDwFGW+fAmNU+
         ymAXwM8OzHdJue5qK4yGBDUzzewX+7uZFjgYTDCggpXfuYzt706n3fDMNOpuvj27Wa/E
         9UDtalzyYaL4AUY0xOj29xTI50FI5imPAGrI5l723bzb5Ajje41Y6h87669SD0VpOeI1
         U7qQ==
X-Gm-Message-State: ACrzQf2GfBJFa/u7HUT/KZw17Th3XQS5DAFlD+Cgyf0VPzzFLVPRDOKc
        gdfvE2cAfYuQZ9nCaitXW/dl0F+0IfVOu6kvpo2IH22mmgL+
X-Google-Smtp-Source: AMsMyM5a/dR1igz98v9x/QuvU++r0t3bOtDiGDqubbY/vXledqC4nj+kfqJEoJWSr5sLzgvxZExw/wcqju6Xt5+ffLIslvzgIFl+
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d92:b0:2f6:a470:cb4f with SMTP id
 h18-20020a056e021d9200b002f6a470cb4fmr10448434ila.221.1664211945555; Mon, 26
 Sep 2022 10:05:45 -0700 (PDT)
Date:   Mon, 26 Sep 2022 10:05:45 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000d890a405e997896e@google.com>
Subject: [syzbot] kernel BUG in jfs_evict_inode
From:   syzbot <syzbot+9c0c58ea2e4887ab502e@syzkaller.appspotmail.com>
To:     jfs-discussion@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        shaggy@kernel.org, syzkaller-bugs@googlegroups.com
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

HEAD commit:    c194837ebb57 Merge branch 'for-next/core', remote-tracking..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=117dbdc4880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=15a770deac0c935a
dashboard link: https://syzkaller.appspot.com/bug?extid=9c0c58ea2e4887ab502e
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
userspace arch: arm64
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11f2e288880000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=127d1ae4880000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/8d8ae425e7fa/disk-c194837e.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/c540d501ebe7/vmlinux-c194837e.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+9c0c58ea2e4887ab502e@syzkaller.appspotmail.com

loop0: detected capacity change from 0 to 264192
ERROR: (device loop0): xtTruncate: XT_GETPAGE: xtree page corrupt
ERROR: (device loop0): remounting filesystem as read-only
------------[ cut here ]------------
kernel BUG at fs/jfs/inode.c:169!
Internal error: Oops - BUG: 00000000f2000800 [#1] PREEMPT SMP
Modules linked in:
CPU: 1 PID: 3065 Comm: syz-executor105 Not tainted 6.0.0-rc6-syzkaller-17742-gc194837ebb57 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/26/2022
pstate: 80400005 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : jfs_evict_inode+0x1c0/0x1e8 fs/jfs/inode.c:169
lr : jfs_evict_inode+0x1c0/0x1e8 fs/jfs/inode.c:169
sp : ffff8000126f3ac0
x29: ffff8000126f3ac0 x28: ffff0000cb292a00 x27: ffff0000ca9e85f8
x26: ffff0000c759b500 x25: ffff0000cb292a00 x24: ffff8000126f3b38
x23: ffff0000ca9eba98 x22: ffff0000ca9eb4b0 x21: ffff800008d32a0c
x20: 0000000000000001 x19: ffff0000ca9eb8e0 x18: 00000000000000c0
x17: ffff80000dd0b198 x16: ffff80000db49158 x15: ffff0000c759b500
x14: 0000000000000050 x13: 00000000ffffffff x12: ffff0000c759b500
x11: ff80800008d32bcc x10: 0000000000000000 x9 : ffff800008d32bcc
x8 : ffff0000c759b500 x7 : ffff8000085e852c x6 : 0000000000000000
x5 : 0000000000000080 x4 : 0000000000000001 x3 : 0000000000000000
x2 : 0000000000000006 x1 : 0000000000000000 x0 : ffff0000ca9eb8c0
Call trace:
 jfs_evict_inode+0x1c0/0x1e8 fs/jfs/inode.c:169
 evict+0xec/0x334 fs/inode.c:665
 dispose_list fs/inode.c:698 [inline]
 evict_inodes+0x2e0/0x354 fs/inode.c:748
 generic_shutdown_super+0x50/0x190 fs/super.c:480
 kill_block_super+0x30/0x78 fs/super.c:1427
 deactivate_locked_super+0x70/0xe8 fs/super.c:332
 deactivate_super+0xd0/0xd4 fs/super.c:363
 cleanup_mnt+0x1f8/0x234 fs/namespace.c:1186
 __cleanup_mnt+0x20/0x30 fs/namespace.c:1193
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
 el0t_64_sync+0x18c/0x190
Code: aa1303e0 97e62ca1 17ffffaf 97d5b63d (d4210000) 
---[ end trace 0000000000000000 ]---


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
