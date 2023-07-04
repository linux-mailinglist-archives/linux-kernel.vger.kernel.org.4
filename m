Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BA7A7466F2
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 03:45:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231222AbjGDBpM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 21:45:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbjGDBpL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 21:45:11 -0400
Received: from mail-pl1-f205.google.com (mail-pl1-f205.google.com [209.85.214.205])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D23CE4E
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jul 2023 18:45:08 -0700 (PDT)
Received: by mail-pl1-f205.google.com with SMTP id d9443c01a7336-1b89712d613so18143465ad.2
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jul 2023 18:45:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688435108; x=1691027108;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=H2Ze2c0Kq8hkSX1P9VUvavVjaGi6+MVhTGXkCivFU20=;
        b=h9/5+NFkxx+FdzBMNgRMExodBf0njGecLzMk1gMv79Yz/FuNnkq+CGapyxmPU4CbSo
         7yk8zrLh/NTf3StUY+lUpk7LyN2zDudvhY3ODvuoPXUKDlttqA0eoPhG81fdqvgLl3FY
         iqUutRL3E0P13OuRiCLKwGXT+jybId0ueZy3m7/3geo8w7QwDXiX+nF5eA6CPY/ujJCP
         rJpb3NIvqFKB8AqisTWRZKYm8LcXCy/QSonXGYqVD1Gv17tFICf2lPjt8g5qzqB3UtNT
         k7bLrlqjYqSAGZCQsYO5y0VUyC09JDwBj0oixI8OWcqPhLqVenl6F4rC8foCVHwiFQiB
         zOdQ==
X-Gm-Message-State: ABy/qLaRqN6AB+UpTwUgp0yCyv0t6pMl6/p1XNsC/KGVSUnfVTdoKyCX
        KC6fgRXxCv77L96dSRgHTTveiCj6vkpSwwi9Onflsr/PsQms
X-Google-Smtp-Source: APBJJlE8AUmlax/N+jsu5a1mZQ8ukTFM+k/kgAiaz2tEeINfzgIlfRTNchLLvZv8mG+tQ/hCFEyRf6wmUezeiU6BuC2I1bTQOupI
MIME-Version: 1.0
X-Received: by 2002:a17:902:ef8d:b0:1b3:cbd9:c686 with SMTP id
 iz13-20020a170902ef8d00b001b3cbd9c686mr9724739plb.4.1688435108181; Mon, 03
 Jul 2023 18:45:08 -0700 (PDT)
Date:   Mon, 03 Jul 2023 18:45:08 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000d97d9305ff9f6e87@google.com>
Subject: [syzbot] [block?] KASAN: slab-out-of-bounds Read in bio_split_rw
From:   syzbot <syzbot+6f66f3e78821b0fff882@syzkaller.appspotmail.com>
To:     axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    3674fbf0451d Merge git://git.kernel.org/pub/scm/linux/kern..
git tree:       net
console output: https://syzkaller.appspot.com/x/log.txt?x=110c779f280000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c9bf1936936ca698
dashboard link: https://syzkaller.appspot.com/bug?extid=6f66f3e78821b0fff882
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16223cb8a80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13f13920a80000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/42ed556782c3/disk-3674fbf0.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/1913e16e8565/vmlinux-3674fbf0.xz
kernel image: https://storage.googleapis.com/syzbot-assets/469804b58a7c/bzImage-3674fbf0.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+6f66f3e78821b0fff882@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: slab-out-of-bounds in bio_split_rw+0x7e7/0x8b0 block/blk-merge.c:286
Read of size 8 at addr ffff88807a302100 by task syz-executor144/5006

CPU: 1 PID: 5006 Comm: syz-executor144 Not tainted 6.4.0-rc7-syzkaller-01944-g3674fbf0451d #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/27/2023
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xd9/0x150 lib/dump_stack.c:106
 print_address_description.constprop.0+0x2c/0x3c0 mm/kasan/report.c:351
 print_report mm/kasan/report.c:462 [inline]
 kasan_report+0x11c/0x130 mm/kasan/report.c:572
 bio_split_rw+0x7e7/0x8b0 block/blk-merge.c:286
 __bio_split_to_limits+0x235/0x9b0 block/blk-merge.c:370
 blk_mq_submit_bio+0x235/0x1f50 block/blk-mq.c:2940
 __submit_bio+0xfc/0x310 block/blk-core.c:594
 __submit_bio_noacct_mq block/blk-core.c:673 [inline]
 submit_bio_noacct_nocheck+0x7f9/0xb40 block/blk-core.c:702
 submit_bio_noacct+0x945/0x19f0 block/blk-core.c:801
 ext4_io_submit+0xa6/0x140 fs/ext4/page-io.c:378
 ext4_do_writepages+0x141c/0x3290 fs/ext4/inode.c:2723
 ext4_writepages+0x304/0x770 fs/ext4/inode.c:2792
 do_writepages+0x1a8/0x640 mm/page-writeback.c:2551
 filemap_fdatawrite_wbc mm/filemap.c:390 [inline]
 filemap_fdatawrite_wbc+0x147/0x1b0 mm/filemap.c:380
 __filemap_fdatawrite_range+0xb8/0xf0 mm/filemap.c:423
 filemap_write_and_wait_range mm/filemap.c:678 [inline]
 filemap_write_and_wait_range+0xa1/0x120 mm/filemap.c:669
 __iomap_dio_rw+0x65f/0x1f90 fs/iomap/direct-io.c:569
 iomap_dio_rw+0x40/0xa0 fs/iomap/direct-io.c:688
 ext4_dio_read_iter fs/ext4/file.c:94 [inline]
 ext4_file_read_iter+0x4be/0x690 fs/ext4/file.c:145
 call_read_iter include/linux/fs.h:1862 [inline]
 generic_file_splice_read+0x182/0x4b0 fs/splice.c:420
 do_splice_to+0x1b9/0x240 fs/splice.c:1007


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the bug is already fixed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

If you want to change bug's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the bug is a duplicate of another bug, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup
