Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1C6C6F34EA
	for <lists+linux-kernel@lfdr.de>; Mon,  1 May 2023 19:16:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232532AbjEARQA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 May 2023 13:16:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233783AbjEARMg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 May 2023 13:12:36 -0400
Received: from mail-io1-xd4d.google.com (mail-io1-xd4d.google.com [IPv6:2607:f8b0:4864:20::d4d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36AEA3ABC
        for <linux-kernel@vger.kernel.org>; Mon,  1 May 2023 10:10:55 -0700 (PDT)
Received: by mail-io1-xd4d.google.com with SMTP id ca18e2360f4ac-76659fe1ac7so363877839f.1
        for <linux-kernel@vger.kernel.org>; Mon, 01 May 2023 10:10:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682960705; x=1685552705;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=c7hKOKbJMl2YcfkxcJZJbcJ0r0WbQba+Lj4vLNvcKOE=;
        b=YW7dFXLkDTVdBGP4VbDUK9tWsC07bfsJ+DmUwTrZ0FAVYWuRsA9SOJBStWvERJhRCw
         YhxBmda3v6Fs93ZYUbHXGdpkxSUq8ORQUuzUfROL7K6oIqvRSdYVDf6rRTe5hmI+ThUt
         xHO/J8/Xl/FLnWLehFaanDMVmf6Xo6snrnnPofYdrUWgUCeK7hfMwpDciC/mjZwcYZvu
         Jon9EVWlKw2OdAZEMVhRIil+uUnAcTnkkD0a6zgbwW/NYEjugh7MlQ/qplr4KJjyebKA
         YvdNe4ZUGz2c/CjH9gHFONn2NQCmTxGqmN+vwQiMQt/h4ZyTfv5gS3zSrHqZJarWgCvc
         jZZg==
X-Gm-Message-State: AC+VfDw+kYS/0EmeW7ty6HicR35+WfHgNVGYc/3sEM8TBC3qdItc3ltm
        bLYWbadMVts/EUMSqfbBfPCjKte6/uM1ec/0IFUS9b5iMvm9
X-Google-Smtp-Source: ACHHUZ5FVEo4YIYIOxSOTqYoStsO2FMW1fltRzaNlRIlAPBCKX6aQmNn7FN7CSNEMFtrbbLgQtxJDHAg67n5/kE75ozY5FZzLBwM
MIME-Version: 1.0
X-Received: by 2002:a02:6207:0:b0:40f:9262:b588 with SMTP id
 d7-20020a026207000000b0040f9262b588mr5871886jac.6.1682960705456; Mon, 01 May
 2023 10:05:05 -0700 (PDT)
Date:   Mon, 01 May 2023 10:05:05 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000000534da05faa4d3d4@google.com>
Subject: [syzbot] [f2fs?] WARNING: lock held when returning to user space in f2fs_write_single_data_page
From:   syzbot <syzbot+eb6201248f684e99b9f8@syzkaller.appspotmail.com>
To:     chao@kernel.org, jaegeuk@kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    58390c8ce1bd Merge tag 'iommu-updates-v6.4' of git://git.k..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=136e6ef8280000
kernel config:  https://syzkaller.appspot.com/x/.config?x=5eadbf0d3c2ece89
dashboard link: https://syzkaller.appspot.com/bug?extid=eb6201248f684e99b9f8
compiler:       Debian clang version 15.0.7, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16bbb03c280000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=140d36f8280000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/60130779f509/disk-58390c8c.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/d7f0cdd29b71/vmlinux-58390c8c.xz
kernel image: https://storage.googleapis.com/syzbot-assets/de415ad52ae4/bzImage-58390c8c.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/dc89d01cd6e9/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+eb6201248f684e99b9f8@syzkaller.appspotmail.com

syz-executor768: attempt to access beyond end of device
loop0: rw=2049, sector=77824, nr_sectors = 2048 limit=63271
syz-executor768: attempt to access beyond end of device
loop0: rw=2049, sector=79872, nr_sectors = 2048 limit=63271
================================================
WARNING: lock held when returning to user space!
6.3.0-syzkaller-12049-g58390c8ce1bd #0 Not tainted
------------------------------------------------
syz-executor768/4998 is leaving the kernel with locks still held!
1 lock held by syz-executor768/4998:
 #0: ffff88807e800448 (&sbi->node_write){++++}-{3:3}, at: f2fs_down_read fs/f2fs/f2fs.h:2087 [inline]
 #0: ffff88807e800448 (&sbi->node_write){++++}-{3:3}, at: f2fs_write_single_data_page+0xa10/0x1d50 fs/f2fs/data.c:2842


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
