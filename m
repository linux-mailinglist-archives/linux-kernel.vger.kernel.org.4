Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 654606120B5
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Oct 2022 08:28:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229531AbiJ2G2X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Oct 2022 02:28:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbiJ2G2U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Oct 2022 02:28:20 -0400
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A228B1CCCCC
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 23:28:19 -0700 (PDT)
Received: by mail-io1-f70.google.com with SMTP id q16-20020a5e9410000000b006bfe9222a2aso5549073ioj.15
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 23:28:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nSgscWgSb1VL8tdx5OblC2vGgJTXmbMo6WXu2dV5OrY=;
        b=O6cX2NOd0kEbQquIZpVPbrIEkF+oczfYSI5CDa6PKb8AKBX02dA/gGfhZklPWuftCu
         rsGmIQhibf/vjKjP3gRhiDUxzPf53FwMrCXY+LlEOBngzOt8r0WZ4KEoo92t6n/VCM7Y
         iS0xk9dhuL7CiLrNESB5XkOCTkJWZdaJE2BvuJmvcQMm3ytNpiY1gZw4l859JAFHUJOU
         sWm7CGhQimX8kGsE1fdJ6OJ0n+9ZI89W2pdcZPHgqUrNtd4Q5INe+/oV4K0C1QRUUeNF
         5YVJhJBLhaIdMCJFbb4Nw9DfZM2ylL6OmGtV1HDaQN36AXXMUJT6AN9X+cZVEVcb7Mie
         /a7w==
X-Gm-Message-State: ACrzQf3jRQk+mdxyndWXvhrXGKlr0LyT4b9qBnELJ/pSOBcAorSnXE52
        W0YK/HIDYrzJ73zz5LQcXvs7KljT7xN47TJDPgUL6Vh7zTLc
X-Google-Smtp-Source: AMsMyM4dX41QqobjYKQMyRSTjGJcCT+oAP9x1/YLhgneAkFjbPMV5GrDsNJmxTK+hRFPQKRhvrc9K4DZ8XI3YXlGAyPhlQKalYBk
MIME-Version: 1.0
X-Received: by 2002:a05:6602:2c47:b0:6bf:df74:fa5e with SMTP id
 x7-20020a0566022c4700b006bfdf74fa5emr1449922iov.177.1667024898928; Fri, 28
 Oct 2022 23:28:18 -0700 (PDT)
Date:   Fri, 28 Oct 2022 23:28:18 -0700
In-Reply-To: <20221029060343.3425-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000eeb4ed05ec267ad8@google.com>
Subject: Re: [syzbot] kernel BUG in dnotify_free_mark
From:   syzbot <syzbot+06cc05ddc896f12b7ec5@syzkaller.appspotmail.com>
To:     hdanton@sina.com, linux-kernel@vger.kernel.org,
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

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
WARNING in fsnotify_put_mark

------------[ cut here ]------------
WARNING: CPU: 0 PID: 4068 at fs/notify/mark.c:336 fsnotify_put_mark+0x8b6/0x9c0
Modules linked in:
CPU: 0 PID: 4068 Comm: syz-executor.0 Not tainted 6.1.0-rc2-syzkaller-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/11/2022
RIP: 0010:fsnotify_put_mark+0x8b6/0x9c0 fs/notify/mark.c:336
Code: 0c b9 01 00 00 00 bf 08 00 00 00 48 c7 c2 e0 9b c4 8c 48 83 c4 40 5b 41 5c 41 5d 41 5e 41 5f 5d e9 2f c7 58 ff e8 fa 34 8a ff <0f> 0b e9 02 ff ff ff e8 ee 34 8a ff 0f 0b e9 24 f9 ff ff e8 e2 34
RSP: 0018:ffffc90004d1fb48 EFLAGS: 00010293
RAX: ffffffff81fd9a26 RBX: 0000000000000001 RCX: ffff888020cd9d40
RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000000000000
RBP: ffff88806eda6000 R08: ffffffff81fd991b R09: fffffbfff1c1b5e6
R10: fffffbfff1c1b5e6 R11: 1ffffffff1c1b5e5 R12: dffffc0000000000
R13: 0000000000000000 R14: ffff88807efa7900 R15: 1ffff1100ddb4c0e
FS:  0000555556a00400(0000) GS:ffff8880b9b00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000056399dba2950 CR3: 000000006d41b000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 fsnotify_destroy_marks+0x57d/0x6f0 fs/notify/mark.c:868
 fsnotify_clear_marks_by_inode fs/notify/fsnotify.h:60 [inline]
 __fsnotify_inode_delete fs/notify/fsnotify.c:22 [inline]
 fsnotify_inode_delete include/linux/fsnotify.h:176 [inline]
 fsnotify_unmount_inodes fs/notify/fsnotify.c:78 [inline]
 fsnotify_sb_delete+0x287/0x4e0 fs/notify/fsnotify.c:92
 generic_shutdown_super+0x9c/0x310 fs/super.c:481
 kill_block_super+0x79/0xd0 fs/super.c:1427
 deactivate_locked_super+0xa7/0xf0 fs/super.c:331
 cleanup_mnt+0x494/0x520 fs/namespace.c:1186
 task_work_run+0x243/0x300 kernel/task_work.c:179
 resume_user_mode_work include/linux/resume_user_mode.h:49 [inline]
 exit_to_user_mode_loop+0x124/0x150 kernel/entry/common.c:171
 exit_to_user_mode_prepare+0xb2/0x140 kernel/entry/common.c:203
 __syscall_exit_to_user_mode_work kernel/entry/common.c:285 [inline]
 syscall_exit_to_user_mode+0x26/0x60 kernel/entry/common.c:296
 do_syscall_64+0x49/0xb0 arch/x86/entry/common.c:86
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f7892a8ca67
Code: ff ff ff f7 d8 64 89 01 48 83 c8 ff c3 66 0f 1f 44 00 00 31 f6 e9 09 00 00 00 66 0f 1f 84 00 00 00 00 00 b8 a6 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffe3a5680c8 EFLAGS: 00000246 ORIG_RAX: 00000000000000a6
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 00007f7892a8ca67
RDX: 00007ffe3a568199 RSI: 000000000000000a RDI: 00007ffe3a568190
RBP: 00007ffe3a568190 R08: 00000000ffffffff R09: 00007ffe3a567f60
R10: 0000555556a018b3 R11: 0000000000000246 R12: 00007f7892ae5826
R13: 00007ffe3a569250 R14: 0000555556a01810 R15: 00007ffe3a569290
 </TASK>


Tested on:

commit:         247f34f7 Linux 6.1-rc2
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=1479cab6880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1d3548a4365ba17d
dashboard link: https://syzkaller.appspot.com/bug?extid=06cc05ddc896f12b7ec5
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=11cb6f5e880000

