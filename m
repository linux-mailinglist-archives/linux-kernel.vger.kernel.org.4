Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AD5965AD3A
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Jan 2023 06:28:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230407AbjABF2k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Jan 2023 00:28:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230246AbjABF2h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jan 2023 00:28:37 -0500
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 721D21161
        for <linux-kernel@vger.kernel.org>; Sun,  1 Jan 2023 21:28:36 -0800 (PST)
Received: by mail-io1-f69.google.com with SMTP id w18-20020a5d9cd2000000b006e32359d7fcso7404145iow.15
        for <linux-kernel@vger.kernel.org>; Sun, 01 Jan 2023 21:28:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=C4uOy9OkEsZTHzkuQks1c5eDJDmK/nr6rd+3HMv9L8k=;
        b=qLIP9UJ3Wg39URaEGNC01kHXCpp0+0g76wNy23vnwDVAEZGDhG1plAdt8PGgnQvJm7
         o8sA2B5N2wgrl6ghdwvPb0TSoV+XGyeQxyoCBcIWLaP3FYhE2MYLXB39cK/kkFUXVz25
         FzD9NP+ig+L3J5yXwFGCd0ZSre1Epbmofp9awOW+YsEqTTMLyWs9qkQcYCOFuJvc4Mxq
         m5dg09aF28zOLG3Pw/oofZRcJLiJM8Val83ojUUvjvrCGe574v5shARffWVCnTgh9q3X
         Dv9ibC5y+fMOctrmRbN1N8Gdk/4zzm6VW0jxGHBsj0GoGnjo5Jke3psR14cvOESGWoLR
         /PDA==
X-Gm-Message-State: AFqh2kq+lpyZxedMc3f9cRbEovSUecCliYnXU09R7sfNtlGj1+BsvN7R
        zAG2c88pqkLp+IQnJOFfF/VcOs6s3+zm829OMmcHT8x9cv9s
X-Google-Smtp-Source: AMrXdXsZfYOGc83HgDZDj+gv/or1CgrEON3pQbuF8feBIlvRcoTkjLfZveu5esyNVSTO0Tohh+FVY3dtfkWM4/6syoyVas4kS856
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1566:b0:30b:d301:1ceb with SMTP id
 k6-20020a056e02156600b0030bd3011cebmr4124212ilu.23.1672637315826; Sun, 01 Jan
 2023 21:28:35 -0800 (PST)
Date:   Sun, 01 Jan 2023 21:28:35 -0800
In-Reply-To: <00000000000032020805ec75ae69@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000000c4df705f1413990@google.com>
Subject: Re: [syzbot] [jfs?] UBSAN: array-index-out-of-bounds in dbFindLeaf
From:   syzbot <syzbot+aea1ad91e854d0a83e04@syzkaller.appspotmail.com>
To:     jfs-discussion@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        mudongliangabcd@gmail.com, paskripkin@gmail.com, r33s3n6@gmail.com,
        shaggy@kernel.org, syzkaller-bugs@googlegroups.com,
        wuhoipok@gmail.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has found a reproducer for the following issue on:

HEAD commit:    e4cf7c25bae5 Merge tag 'kbuild-fixes-v6.2' of git://git.ke..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=141a6274480000
kernel config:  https://syzkaller.appspot.com/x/.config?x=68e0be42c8ee4bb4
dashboard link: https://syzkaller.appspot.com/bug?extid=aea1ad91e854d0a83e04
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10faef4c480000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13170968480000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/0a2dc7ed8cf1/disk-e4cf7c25.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/b35476d531fc/vmlinux-e4cf7c25.xz
kernel image: https://storage.googleapis.com/syzbot-assets/a66192aa25a5/bzImage-e4cf7c25.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/78eabe0740c8/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+aea1ad91e854d0a83e04@syzkaller.appspotmail.com

loop0: detected capacity change from 0 to 32768
================================================================================
UBSAN: array-index-out-of-bounds in fs/jfs/jfs_dmap.c:2941:16
index 1381 is out of range for type 's8 [1365]'
CPU: 0 PID: 5067 Comm: syz-executor239 Not tainted 6.2.0-rc1-syzkaller-00095-ge4cf7c25bae5 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/26/2022
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x1b1/0x290 lib/dump_stack.c:106
 ubsan_epilogue lib/ubsan.c:151 [inline]
 __ubsan_handle_out_of_bounds+0xe0/0x110 lib/ubsan.c:282
 dbFindLeaf+0x30a/0x440 fs/jfs/jfs_dmap.c:2941
 dbAllocDmapLev+0xa9/0x420 fs/jfs/jfs_dmap.c:1952
 dbAllocCtl+0x113/0x970 fs/jfs/jfs_dmap.c:1808
 dbAllocAG+0x28b/0x1100 fs/jfs/jfs_dmap.c:1349
 dbAlloc+0x661/0xc90 fs/jfs/jfs_dmap.c:873
 dtSplitUp fs/jfs/jfs_dtree.c:974 [inline]
 dtInsert+0xc0e/0x6b80 fs/jfs/jfs_dtree.c:863
 jfs_mkdir+0x757/0xb00 fs/jfs/namei.c:270
 vfs_mkdir+0x3b3/0x590 fs/namei.c:4036
 do_mkdirat+0x25b/0x530 fs/namei.c:4061
 __do_sys_mkdirat fs/namei.c:4076 [inline]
 __se_sys_mkdirat fs/namei.c:4074 [inline]
 __x64_sys_mkdirat+0x85/0x90 fs/namei.c:4074
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f2ba532cb29
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 51 14 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fffd3c83968 EFLAGS: 00000246 ORIG_RAX: 0000000000000102
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f2ba532cb29
RDX: 0000000000000000 RSI: 0000000020000180 RDI: 0000000000000004
RBP: 00007f2ba52ec130 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f2ba52ec1c0
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
 </TASK>
================================================================================

