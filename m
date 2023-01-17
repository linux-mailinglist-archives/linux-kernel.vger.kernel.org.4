Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5728D66DA14
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 10:35:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236526AbjAQJfh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 04:35:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236176AbjAQJeV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 04:34:21 -0500
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DF8D14EB1
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 01:34:00 -0800 (PST)
Received: by mail-il1-f198.google.com with SMTP id r6-20020a92cd86000000b00304b2d1c2d7so22492187ilb.11
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 01:34:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=s8Mcb+WjwA5lh9pEwGYzzzg4uiht2eQVzYxZiEx1YGY=;
        b=vekqWstjlcRpuO3uEHPSWRs/32NZXVFOHBORu7/msyC4apB3iBAXSezbdvxgEVR9ka
         TaGEXsK5rwKSxnPg6CTMbJz12+a7acewIqfq00VvNBkT26sQ86oyqdO84u+jor0JgfPU
         mIMzGzc3bKjlumj+8PDWPJ7bnD5Ug9KMEWiwCY59qiV84HKHA2yI+BWMnfcWSKoN2qns
         NYPF1JBoVKOU/oJXm5VsI7iS5zu+5qP0h/V6yG0jerOFtkP+LhZxErfVk/tWmH/xNY68
         D0xgTftKQqmvCIbllZj8ztRoFWAaUkVwBIcQo2jphgSwhWo7B4kUv05vFmPmiv9X4bN+
         S5Zg==
X-Gm-Message-State: AFqh2krL3/GkO/EHp0kyN07k6W/Xud6Bf/syUiBCcRU3JdA+hUtL+dRv
        nhyPV977JdT5Lm0BN03BSWxGDYqYC2grNr9nwM1jlXldjXh2
X-Google-Smtp-Source: AMrXdXtvfxNg1WT225sLX7gseksnUf/8QuOfw2FKTAWF/cs7sj8JNyMjHR6FGQPz2bdWxPlY/gZBlXMu8Pr6//3ddpBC/78Pa5/q
MIME-Version: 1.0
X-Received: by 2002:a02:cdde:0:b0:3a0:719d:661c with SMTP id
 m30-20020a02cdde000000b003a0719d661cmr189744jap.229.1673948039876; Tue, 17
 Jan 2023 01:33:59 -0800 (PST)
Date:   Tue, 17 Jan 2023 01:33:59 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000004a196d05f27266c2@google.com>
Subject: [syzbot] [udf?] KASAN: use-after-free Write in udf_open_lvid
From:   syzbot <syzbot+f2f7a789f16fd4b09e88@syzkaller.appspotmail.com>
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

HEAD commit:    0a093b2893c7 Add linux-next specific files for 20230112
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=11c6b516480000
kernel config:  https://syzkaller.appspot.com/x/.config?x=835f3591019836d5
dashboard link: https://syzkaller.appspot.com/bug?extid=f2f7a789f16fd4b09e88
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=104bcf4a480000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10775c7e480000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/8111a570d6cb/disk-0a093b28.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/ecc135b7fc9a/vmlinux-0a093b28.xz
kernel image: https://storage.googleapis.com/syzbot-assets/ca8d73b446ea/bzImage-0a093b28.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/57302a8f5a77/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+f2f7a789f16fd4b09e88@syzkaller.appspotmail.com

UDF-fs: INFO Mounting volume 'LinuxUDF', timestamp 2022/11/22 14:59 (1000)
==================================================================
BUG: KASAN: use-after-free in udf_open_lvid.isra.0+0x24f/0x2a0 fs/udf/super.c:2043
Write of size 1 at addr ffff888094c48ac8 by task syz-executor318/5079

CPU: 0 PID: 5079 Comm: syz-executor318 Not tainted 6.2.0-rc3-next-20230112-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/26/2022
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xd1/0x138 lib/dump_stack.c:106
 print_address_description mm/kasan/report.c:306 [inline]
 print_report+0x15e/0x45d mm/kasan/report.c:417
 kasan_report+0xc0/0xf0 mm/kasan/report.c:517
 udf_open_lvid.isra.0+0x24f/0x2a0 fs/udf/super.c:2043
 udf_fill_super+0x1474/0x1a40 fs/udf/super.c:2279
 mount_bdev+0x351/0x410 fs/super.c:1359
 legacy_get_tree+0x109/0x220 fs/fs_context.c:610
 vfs_get_tree+0x8d/0x2f0 fs/super.c:1489
 do_new_mount fs/namespace.c:3145 [inline]
 path_mount+0x132a/0x1e20 fs/namespace.c:3475
 do_mount fs/namespace.c:3488 [inline]
 __do_sys_mount fs/namespace.c:3697 [inline]
 __se_sys_mount fs/namespace.c:3674 [inline]
 __x64_sys_mount+0x283/0x300 fs/namespace.c:3674
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f58020fdf1a
Code: 48 c7 c2 c0 ff ff ff f7 d8 64 89 02 b8 ff ff ff ff eb d2 e8 a8 00 00 00 0f 1f 84 00 00 00 00 00 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffd5ab081b8 EFLAGS: 00000282 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 00007f58020fdf1a
RDX: 0000000020000c00 RSI: 0000000020000c40 RDI: 00007ffd5ab081d0
RBP: 00007ffd5ab081d0 R08: 00007ffd5ab08210 R09: 0000000000000bea
R10: 0000000000000000 R11: 0000000000000282 R12: 0000000000000004
R13: 0000555555add2c0 R14: 0000000000000000 R15: 00007ffd5ab08210
 </TASK>

The buggy address belongs to the physical page:
page:ffffea0002531200 refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x94c48
flags: 0xfff00000000000(node=0|zone=1|lastcpupid=0x7ff)
raw: 00fff00000000000 ffffea0002531208 ffffea0002531208 0000000000000000
raw: 0000000000000000 0000000000000000 00000000ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner info is not present (never set?)

Memory state around the buggy address:
 ffff888094c48980: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
 ffff888094c48a00: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
>ffff888094c48a80: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
                                              ^
 ffff888094c48b00: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
 ffff888094c48b80: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
==================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
