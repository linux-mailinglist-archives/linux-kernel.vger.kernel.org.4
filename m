Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D195B6A8F13
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 03:14:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229651AbjCCCOh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 21:14:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229614AbjCCCOf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 21:14:35 -0500
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2C2639BBD
        for <linux-kernel@vger.kernel.org>; Thu,  2 Mar 2023 18:14:34 -0800 (PST)
Received: by mail-il1-f199.google.com with SMTP id l5-20020a92d8c5000000b00316f26477d6so694036ilo.10
        for <linux-kernel@vger.kernel.org>; Thu, 02 Mar 2023 18:14:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kt/ojrbCEEux7lv8kXEWL9bgMxS9Unie25S5rwp8MVk=;
        b=DtbZYQIk0DRUq1CO/QEGOEAWvk7aMtv7IzcvVU2+KZEwfuZV4ZIVKUrCL9ItltWmcQ
         MGSJ7+XQNsyR6rCOisDZzLA+5mxdwg4xCIlny0Itwfw/Z72+jhjsygo9za5UP9HvcaA1
         gjPmB/cVW/n6gBP5GNfC1QaHhMUKB3+Hak64cpAi9CNGUSh2V+7rKYFIB5nR7ikg6moc
         PC8nhTFYBfm8dgx3vH1nnbc+kHQDxb9F7t3inCd4bWfODb4NFCC7BDXcNY5kKWySjdM0
         IRJMWvaTTFEZvhlJTCUY7N0c3ayKdbzpgKGESLlGH/pgWxmDK2VZBCYSCozRSSL7uXdZ
         pwWg==
X-Gm-Message-State: AO0yUKVrZqdz6PM/Si+9dxh5hu/bnPvvyRYUu9xo/PrIPt1dLXDCRRrG
        HSkKDRLH8PwfcQ9W1JFvzus4VZD9M/uPe5gHXMh/wE8nBoVu
X-Google-Smtp-Source: AK7set8T7k307jX8PR4vVULLcCxlYHotK8bXcfGsUI39HTGoLqe3i0cX7I3IiGdRpzDCE08IU2imsCRU4bRbnVpME5kCa3EutlKH
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:10c3:b0:317:b01:229 with SMTP id
 s3-20020a056e0210c300b003170b010229mr287173ilj.2.1677809674091; Thu, 02 Mar
 2023 18:14:34 -0800 (PST)
Date:   Thu, 02 Mar 2023 18:14:34 -0800
In-Reply-To: <20230303015934.2578-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a0063805f5f5813e@google.com>
Subject: Re: [syzbot] [block?] WARNING in blkdev_put (2)
From:   syzbot <syzbot+2bcc0d79e548c4f62a59@syzkaller.appspotmail.com>
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
WARNING in blkdev_flush_mapping

------------[ cut here ]------------
WARNING: CPU: 1 PID: 5617 at block/bdev.c:582 blkdev_flush_mapping+0x293/0x310 block/bdev.c:582
Modules linked in:
CPU: 1 PID: 5617 Comm: syz-executor.0 Not tainted 6.2.0-syzkaller-13277-g2eb29d59ddf0-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/16/2023
RIP: 0010:blkdev_flush_mapping+0x293/0x310 block/bdev.c:582
Code: e8 a2 24 6c fd e9 5a ff ff ff e8 18 82 88 fd 48 89 ef 48 83 c4 08 5b 5d 41 5c 41 5d 41 5e 41 5f e9 32 f8 1e 06 e8 fd 81 88 fd <0f> 0b e9 bc fd ff ff e8 b1 fd d9 fd e9 9a fd ff ff 48 8b 3c 24 e8
RSP: 0018:ffffc90004b0fd10 EFLAGS: 00010293
RAX: 0000000000000000 RBX: 0000000000000002 RCX: 0000000000000000
RDX: ffff8880241f9d40 RSI: ffffffff83fc7843 RDI: 0000000000000005
RBP: ffff88801ea51001 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000000000002 R11: 0000000000000000 R12: 00000000484e009f
R13: ffff88801bd36328 R14: ffff88801bd36300 R15: 0000000000000000
FS:  000055555667d400(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ffd2b67cf70 CR3: 0000000029003000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 blkdev_put_whole+0xd1/0xf0 block/bdev.c:615
 blkdev_put+0x224/0x7e0 block/bdev.c:878
 blkdev_close+0x68/0x80 block/fops.c:507
 __fput+0x27c/0xa90 fs/file_table.c:321
 task_work_run+0x16f/0x270 kernel/task_work.c:179
 resume_user_mode_work include/linux/resume_user_mode.h:49 [inline]
 exit_to_user_mode_loop kernel/entry/common.c:171 [inline]
 exit_to_user_mode_prepare+0x23c/0x250 kernel/entry/common.c:203
 __syscall_exit_to_user_mode_work kernel/entry/common.c:285 [inline]
 syscall_exit_to_user_mode+0x1d/0x50 kernel/entry/common.c:296
 do_syscall_64+0x46/0xb0 arch/x86/entry/common.c:86
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f657123dfab
Code: 0f 05 48 3d 00 f0 ff ff 77 45 c3 0f 1f 40 00 48 83 ec 18 89 7c 24 0c e8 63 fc ff ff 8b 7c 24 0c 41 89 c0 b8 03 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 35 44 89 c7 89 44 24 0c e8 a1 fc ff ff 8b 44
RSP: 002b:00007ffc3ff573b0 EFLAGS: 00000293 ORIG_RAX: 0000000000000003
RAX: 0000000000000000 RBX: 0000000000000004 RCX: 00007f657123dfab
RDX: 00007f6570e00120 RSI: ffffffffffffffff RDI: 0000000000000003
RBP: 00007f65713ad980 R08: 0000000000000000 R09: 00007f6570e00000
R10: 00007f6570e00128 R11: 0000000000000293 R12: 0000000000015b6b
R13: 00007ffc3ff574b0 R14: 00007f65713abf80 R15: 0000000000000032
 </TASK>


Tested on:

commit:         2eb29d59 Merge tag 'drm-next-2023-03-03-1' of git://an..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
console output: https://syzkaller.appspot.com/x/log.txt?x=111f9404c80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=cab35c936731a347
dashboard link: https://syzkaller.appspot.com/bug?extid=2bcc0d79e548c4f62a59
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=12380f7f480000

