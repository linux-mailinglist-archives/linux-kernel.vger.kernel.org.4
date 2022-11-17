Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F1A662D106
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 03:11:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238401AbiKQCLS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 21:11:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230303AbiKQCLR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 21:11:17 -0500
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E3CF65FA
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 18:11:16 -0800 (PST)
Received: by mail-il1-f197.google.com with SMTP id z19-20020a056e02089300b002fffe186ac4so348403ils.8
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 18:11:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=j2nuageR+5smNYItBvRC4sGcay7Fn6JSsAdMoiN1rl8=;
        b=wRv+zOJcLP8yrusg8wvR7f4C8m0rw6iuZNcKq12vXkBbkCAOy2Wkbtt0xsRR6uieRq
         gt4NKQ+MsFnBf85nRQv3iWrx2zkeT2hKSBEkSk/Rbutqq53iIZNOfNysU62ATyQth/pi
         A/nQxaTNaiG4O258nWy/lLkYZ5mSsv+PMRBT9jjsm1FE6MaI+w/TiY63XQdlrl6L8Jdt
         5vDMAjGKq9nLIKCFzva7MOqF5eCSEzXJOlxXgUaLnfN/GemnPj6rjlv/moHOqVlmrL8O
         F8rz62XYVCfZaUFasKrRS2cFaI5GDiII332lbyubOdrEveIgyfMAGGxadw7PE/kSEthw
         zZrg==
X-Gm-Message-State: ANoB5pm1kR3TEOYJ5lmM/17FEt0M4NimFJXmDOmxrSHm5ZWiUqZEER0z
        U0pZfL0Di8YkI76dvM7KIMbUAhd6MmyfP+woy4qsCzDqmyrn
X-Google-Smtp-Source: AA0mqf6gG9qdN2uT5uOUUiUlTXp1MFKzBQ1uxhyREmAwO0uOvLz3LWhQzJz/iEfEFAl8XjMVdLDJrxXd/MJB2ICoWrZXrpU86I23
MIME-Version: 1.0
X-Received: by 2002:a6b:d215:0:b0:6bb:b955:185e with SMTP id
 q21-20020a6bd215000000b006bbb955185emr504681iob.22.1668651075814; Wed, 16 Nov
 2022 18:11:15 -0800 (PST)
Date:   Wed, 16 Nov 2022 18:11:15 -0800
In-Reply-To: <20221117015628.3543-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a0cc2005eda11a59@google.com>
Subject: Re: [syzbot] BUG: unable to handle kernel NULL pointer dereference in shmem_evict_inode
From:   syzbot <syzbot+b90b43fd4c6589e96a39@syzkaller.appspotmail.com>
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
BUG: corrupted list in __sk_destruct

list_del corruption. next->prev should be ffff0000d3a73b80, but was 0000000000000000. (next=ffff0000d43c9680)
------------[ cut here ]------------
kernel BUG at lib/list_debug.c:64!
Internal error: Oops - BUG: 00000000f2000800 [#1] PREEMPT SMP
Modules linked in:
CPU: 1 PID: 3500 Comm: syz-executor.1 Not tainted 6.1.0-rc4-syzkaller-00039-g1621b6eaebf7-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/30/2022
pstate: 604000c5 (nZCv daIF +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : __list_del_entry_valid+0xcc/0xd0 lib/list_debug.c:62
lr : __list_del_entry_valid+0xcc/0xd0 lib/list_debug.c:62
sp : ffff800012d8bb50
x29: ffff800012d8bb50 x28: 00000000002e0003 x27: 0000000000000000
x26: ffff0000cdf283a8 x25: 0000000000000000 x24: 0000000000000001
x23: 0000000000000000 x22: ffff0000cc951cf0 x21: ffff0000d3a73b80
x20: 0000000000000000 x19: ffff0000cc951c90 x18: 00000000000000c0
x17: 20747562202c3038 x16: ffff80000db2a158 x15: ffff0000c7b39a40
x14: 0000000000000000 x13: 00000000ffffffff x12: ffff0000c7b39a40
x11: ff808000081c06c8 x10: 0000000000000000 x9 : 09ff774b4a8bd800
x8 : 09ff774b4a8bd800 x7 : ffff80000c01881c x6 : 0000000000000000
x5 : 0000000000000080 x4 : 0000000000000001 x3 : 0000000000000000
x2 : ffff0001fefddcc8 x1 : 0000000100000001 x0 : 000000000000006d
Call trace:
 __list_del_entry_valid+0xcc/0xd0 lib/list_debug.c:62
 __list_del_entry include/linux/list.h:134 [inline]
 list_del include/linux/list.h:148 [inline]
 ref_tracker_free+0x188/0x340 lib/ref_tracker.c:146
 netns_tracker_free include/net/net_namespace.h:335 [inline]
 put_net_track include/net/net_namespace.h:349 [inline]
 __sk_destruct+0x27c/0x4e4 net/core/sock.c:2151
 sk_destruct net/core/sock.c:2167 [inline]
 __sk_free+0x238/0x290 net/core/sock.c:2178
 sk_free+0x54/0xbc net/core/sock.c:2189
 sock_put include/net/sock.h:1987 [inline]
 tcp_close+0x78/0xe0 net/ipv4/tcp.c:3034
 inet_release+0xc8/0xe4 net/ipv4/af_inet.c:428
 __sock_release net/socket.c:650 [inline]
 sock_close+0x50/0xf0 net/socket.c:1365
 __fput+0x198/0x3e4 fs/file_table.c:320
 ____fput+0x20/0x30 fs/file_table.c:348
 task_work_run+0x100/0x148 kernel/task_work.c:179
 resume_user_mode_work include/linux/resume_user_mode.h:49 [inline]
 do_notify_resume+0x174/0x1f0 arch/arm64/kernel/signal.c:1127
 prepare_exit_to_user_mode arch/arm64/kernel/entry-common.c:137 [inline]
 exit_to_user_mode arch/arm64/kernel/entry-common.c:142 [inline]
 el0_svc+0x9c/0x150 arch/arm64/kernel/entry-common.c:638
 el0t_64_sync_handler+0x84/0xf0 arch/arm64/kernel/entry-common.c:655
 el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:584
Code: d4210000 d001b140 913ac800 94a82811 (d4210000) 
---[ end trace 0000000000000000 ]---


Tested on:

commit:         1621b6ea Merge branch 'for-next/fixes' into for-kernelci
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=165acf59880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=606e57fd25c5c6cc
dashboard link: https://syzkaller.appspot.com/bug?extid=b90b43fd4c6589e96a39
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
userspace arch: arm64
patch:          https://syzkaller.appspot.com/x/patch.diff?x=10a9080d880000

