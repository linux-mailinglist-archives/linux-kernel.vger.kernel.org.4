Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 520725F9A02
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 09:32:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232462AbiJJHcI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 03:32:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232123AbiJJHbp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 03:31:45 -0400
Received: from mail-il1-x145.google.com (mail-il1-x145.google.com [IPv6:2607:f8b0:4864:20::145])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87F821B9C8
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 00:25:46 -0700 (PDT)
Received: by mail-il1-x145.google.com with SMTP id i21-20020a056e021d1500b002f9e4f8eab7so8111124ila.7
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 00:25:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=H21dKt7zHeW3eXNrfU61MPCo4gXmaQ/hiU57H2sUBfQ=;
        b=f6t4qwN5kvkTMrqDvn4Sb/z5nyEiNGsul2g6DoimUguLcQWDkjBxZWBr5zGW7XM66y
         q8SKDUo38uC0tUnVxROOkVW6KlkTGfrGMbeeniacD3ehr2VCxZPI3LU+MJn3znz7REju
         dlZo4vukNL/yoXMQVb4KwoO6HI8w/ffLvdyYAwBKWOZkguYM78AJMW9o3Tqk0A8IdpMk
         Apwv7u/CZTMYfxO/xYK+MhKM5iCyhlw/tk2ONiDdwTKQN76Z7RrBTk9y2n6jnmUFleYo
         4XG6fgN659bPwcWKYXw+21Uf34v4M0UzCbvZbVY5TljtiVqvgYPQkhL9h/PMekufBdG0
         b7yA==
X-Gm-Message-State: ACrzQf11gVtaTLptb1RhmbbNP44TZh8sfYsDvxrmzyeXgDG/bNeUiBp0
        LFTToe5zpavGgvcihVho0h98o01vKeglcWQQsDCWNfHbi4No
X-Google-Smtp-Source: AMsMyM6BKVX2UJRUTPQhHoglbD72mvUdio9qT88kkJTQQIWq4GHhyc5sxLLc7wS57NHHw/QvxLRtXCC3mlCZzwsgnvHJOzz1yWuW
MIME-Version: 1.0
X-Received: by 2002:a05:6638:14cb:b0:358:4759:be8c with SMTP id
 l11-20020a05663814cb00b003584759be8cmr8727885jak.13.1665386203047; Mon, 10
 Oct 2022 00:16:43 -0700 (PDT)
Date:   Mon, 10 Oct 2022 00:16:43 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000000bef6205eaa8f181@google.com>
Subject: [syzbot] UBSAN: shift-out-of-bounds in dbJoin
From:   syzbot <syzbot+411debe54d318eaed386@syzkaller.appspotmail.com>
To:     jfs-discussion@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        shaggy@kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    62e6e5940c0c Merge tag 'scsi-misc' of git://git.kernel.org..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=16347cc8880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4c13637ccca17699
dashboard link: https://syzkaller.appspot.com/bug?extid=411debe54d318eaed386
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1768f51c880000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=175885cc880000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/b4f4f04cf38f/disk-62e6e594.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/dfb013b64867/vmlinux-62e6e594.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/64992a1b07af/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+411debe54d318eaed386@syzkaller.appspotmail.com

================================================================================
UBSAN: shift-out-of-bounds in fs/jfs/jfs_dmap.c:2760:11
shift exponent 78 is too large for 32-bit type 'int'
CPU: 1 PID: 122 Comm: jfsCommit Not tainted 6.0.0-syzkaller-07362-g62e6e5940c0c #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/22/2022
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x1b1/0x28e lib/dump_stack.c:106
 ubsan_epilogue lib/ubsan.c:151 [inline]
 __ubsan_handle_shift_out_of_bounds+0x33d/0x3b0 lib/ubsan.c:322
 dbJoin+0x2e4/0x2f0 fs/jfs/jfs_dmap.c:2760
 dbAdjCtl+0x3b1/0x9c0 fs/jfs/jfs_dmap.c:2500
 dbFreeDmap fs/jfs/jfs_dmap.c:2064 [inline]
 dbFree+0x3c6/0x660 fs/jfs/jfs_dmap.c:379
 txFreeMap+0x97c/0xd70 fs/jfs/jfs_txnmgr.c:2510
 xtTruncate+0xe74/0x32d0 fs/jfs/jfs_xtree.c:2467
 jfs_free_zero_link+0x3f5/0x680 fs/jfs/namei.c:758
 jfs_evict_inode+0x35a/0x440 fs/jfs/inode.c:153
 evict+0x2a4/0x620 fs/inode.c:664
 txUpdateMap+0x8eb/0xaa0 fs/jfs/jfs_txnmgr.c:2362
 txLazyCommit fs/jfs/jfs_txnmgr.c:2659 [inline]
 jfs_lazycommit+0x433/0xba0 fs/jfs/jfs_txnmgr.c:2727
 kthread+0x266/0x300 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:306
 </TASK>
================================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
