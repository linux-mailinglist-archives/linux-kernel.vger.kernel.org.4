Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07B045F1C64
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Oct 2022 15:37:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229583AbiJANhE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Oct 2022 09:37:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229563AbiJANgt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Oct 2022 09:36:49 -0400
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56D277AC3D
        for <linux-kernel@vger.kernel.org>; Sat,  1 Oct 2022 06:36:38 -0700 (PDT)
Received: by mail-il1-f198.google.com with SMTP id w2-20020a056e021c8200b002f5c95226e0so5410994ill.9
        for <linux-kernel@vger.kernel.org>; Sat, 01 Oct 2022 06:36:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date;
        bh=hVDZHY1FwdtfySEWL/MeOlaNQBKfkoDFaSYQFbe5uZg=;
        b=k56pwZ7Fo3vhtLkiCy9RTjvE8O6dqsz4I6knTWlJQiY2mI2CqobrNq7i//51KM/+Au
         nZXJExy+wJJi1wpXBzicR4p3osrEDDUqtu28uk7N7Empb/kZyGBYCUauYseaK56B35Od
         0xaE1cjEc/3QDhh/1WKm9M8Vcbl16f1oX3uT1xrUUN0J92HoFpraq/nNBIf9ln5ripBq
         5SKDjd8NHt7rQfMEab06z2y+UqxaFyvQ/tkDEvskyk8hwskf2zAEsLhdjKvTQwoLryOo
         K6i05agDpDS7UdGgYNTIgX0nVQaSKit1yLtmqIPzKDdgehVFv4zfH+qI8529UJjGI/+O
         GAuQ==
X-Gm-Message-State: ACrzQf2tQGuCa6UHZrwKqcRPmXbF3lcpMkW4WHjdf0gk75nRSN8fsHMT
        94ZUsRqVJ4/0z6ZgWh2kqqErPsINHVtSEMNxV+QpClfFMR0p
X-Google-Smtp-Source: AMsMyM5YTvaiYCCdA0Tnck7ELhzF/KA3HchIBH7aBWN36mcZatLLiY1qwzCc1OS6H7YAq8vgnx+uWZ7lCGhBWeJNqfrsY++YpTWX
MIME-Version: 1.0
X-Received: by 2002:a6b:5f16:0:b0:69e:2e4e:b25c with SMTP id
 t22-20020a6b5f16000000b0069e2e4eb25cmr5770711iob.12.1664631397533; Sat, 01
 Oct 2022 06:36:37 -0700 (PDT)
Date:   Sat, 01 Oct 2022 06:36:37 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000021d27005e9f9332c@google.com>
Subject: [syzbot] UBSAN: shift-out-of-bounds in dbUpdatePMap
From:   syzbot <syzbot+9a9e47d79d7201c7b73e@syzkaller.appspotmail.com>
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

HEAD commit:    49c13ed0316d Merge tag 'soc-fixes-6.0-rc7' of git://git.ke..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=146eade4880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ba0d23aa7e1ffaf5
dashboard link: https://syzkaller.appspot.com/bug?extid=9a9e47d79d7201c7b73e
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=120912e0880000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=124eb2e0880000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/418654aab051/disk-49c13ed0.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/49c501fc7ae3/vmlinux-49c13ed0.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+9a9e47d79d7201c7b73e@syzkaller.appspotmail.com

================================================================================
UBSAN: shift-out-of-bounds in fs/jfs/jfs_dmap.c:454:12
shift exponent 4096 is too large for 64-bit type 'long long'
CPU: 0 PID: 122 Comm: jfsCommit Not tainted 6.0.0-rc7-syzkaller-00068-g49c13ed0316d #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/26/2022
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x1b1/0x28e lib/dump_stack.c:106
 ubsan_epilogue lib/ubsan.c:151 [inline]
 __ubsan_handle_shift_out_of_bounds+0x33d/0x3b0 lib/ubsan.c:322
 dbUpdatePMap+0xdf5/0xef0 fs/jfs/jfs_dmap.c:454
 txAllocPMap+0x581/0x6c0 fs/jfs/jfs_txnmgr.c:2420
 txUpdateMap+0x883/0xaa0 fs/jfs/jfs_txnmgr.c:2358
 txLazyCommit fs/jfs/jfs_txnmgr.c:2659 [inline]
 jfs_lazycommit+0x433/0xba0 fs/jfs/jfs_txnmgr.c:2727
 kthread+0x266/0x300 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:306
 </TASK>
================================================================================
Kernel panic - not syncing: panic_on_warn set ...
CPU: 0 PID: 122 Comm: jfsCommit Not tainted 6.0.0-rc7-syzkaller-00068-g49c13ed0316d #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/26/2022
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x1b1/0x28e lib/dump_stack.c:106
 panic+0x2d6/0x715 kernel/panic.c:274
 ubsan_epilogue lib/ubsan.c:158 [inline]
 __ubsan_handle_shift_out_of_bounds+0x3af/0x3b0 lib/ubsan.c:322
 dbUpdatePMap+0xdf5/0xef0 fs/jfs/jfs_dmap.c:454
 txAllocPMap+0x581/0x6c0 fs/jfs/jfs_txnmgr.c:2420
 txUpdateMap+0x883/0xaa0 fs/jfs/jfs_txnmgr.c:2358
 txLazyCommit fs/jfs/jfs_txnmgr.c:2659 [inline]
 jfs_lazycommit+0x433/0xba0 fs/jfs/jfs_txnmgr.c:2727
 kthread+0x266/0x300 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:306
 </TASK>
Kernel Offset: disabled
Rebooting in 86400 seconds..


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
