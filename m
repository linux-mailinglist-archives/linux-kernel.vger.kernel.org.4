Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D9B96124AD
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Oct 2022 19:27:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229849AbiJ2R1X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Oct 2022 13:27:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229961AbiJ2R1J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Oct 2022 13:27:09 -0400
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B1EB3136E
        for <linux-kernel@vger.kernel.org>; Sat, 29 Oct 2022 10:26:41 -0700 (PDT)
Received: by mail-il1-f199.google.com with SMTP id n8-20020a056e02100800b00300906a2170so1505734ilj.2
        for <linux-kernel@vger.kernel.org>; Sat, 29 Oct 2022 10:26:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9jRH01WseHmgUfGGHnAG/rDItunZjLsXKMaTjGkm2Qg=;
        b=c5250UcvGhTjxNuPswVtExDkwimhp8P3voruP1+5ZmPRJy3zshi7IgL2NxBhO2jBbg
         SKapv4ve6VyC3dR1pJWCRLWqhRr0JVEBMnQMyrpQA5Q5jCT+6CimZWRI09RMZ8vyCw6K
         41i7BQcQlP9XOzRB06hmKyfOuQPJ+yW6MpdKOsF7zZ5bs+6x+Xyr/oDc6hgD2OpEP/jp
         r8rPEz2iM0sQydsO5S7OO2deI2+0EHwID8fgl2/H5FN8pZNo+hiKDZKgIxRqack+kDqG
         geMcIhDBqgCFHdDW9B7bpVacUYlC6KMO7j8U83igNDtwIz1c2jefSloc7XzfoJSsxBy0
         +v1g==
X-Gm-Message-State: ACrzQf2LGpY74q6WLp4GITqAAAZbIoWhJ6X5I12DgQS8Kns8h5tmdRXW
        s+e2DyVfeX/V3BPHDhfRoOTAtU9RGGJBqmr8RdNVPA+gICJb
X-Google-Smtp-Source: AMsMyM5vrpssUZDA3C53AAhmnW3V7MYZoHtAtw30E6Vr6iqAo/L+BfcIMXhBXKtGywkv1Y3zLlNIiAxXCieWxh3NTK8O6XII31CC
MIME-Version: 1.0
X-Received: by 2002:a05:6602:2a4c:b0:6bc:e0aa:51b6 with SMTP id
 k12-20020a0566022a4c00b006bce0aa51b6mr2513807iov.146.1667064400849; Sat, 29
 Oct 2022 10:26:40 -0700 (PDT)
Date:   Sat, 29 Oct 2022 10:26:40 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000006e342d05ec2fad3d@google.com>
Subject: [syzbot] WARNING in nf_tables_exit_net
From:   syzbot <syzbot+178efee9e2d7f87f5103@syzkaller.appspotmail.com>
To:     coreteam@netfilter.org, davem@davemloft.net, edumazet@google.com,
        fw@strlen.de, kadlec@netfilter.org, kuba@kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        netfilter-devel@vger.kernel.org, pabeni@redhat.com,
        pablo@netfilter.org, syzkaller-bugs@googlegroups.com
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

Hello,

syzbot found the following issue on:

HEAD commit:    b229b6ca5abb Merge tag 'perf-tools-fixes-for-v6.1-2022-10-..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=126df922880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a66c6c673fb555e8
dashboard link: https://syzkaller.appspot.com/bug?extid=178efee9e2d7f87f5103
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1607b841880000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=153ceafc880000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/7a7054f95968/disk-b229b6ca.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/907d97ef4d30/vmlinux-b229b6ca.xz
kernel image: https://storage.googleapis.com/syzbot-assets/5f5f3eb6d623/bzImage-b229b6ca.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+178efee9e2d7f87f5103@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 0 PID: 41 at net/netfilter/nf_tables_api.c:10096 nf_tables_exit_net+0x714/0x830 net/netfilter/nf_tables_api.c:10096
Modules linked in:
CPU: 0 PID: 41 Comm: kworker/u4:2 Not tainted 6.1.0-rc2-syzkaller-00105-gb229b6ca5abb #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/11/2022
Workqueue: netns cleanup_net
RIP: 0010:nf_tables_exit_net+0x714/0x830 net/netfilter/nf_tables_api.c:10096
Code: 1e 06 01 e8 f4 6c 9c 01 e9 af f9 ff ff e8 74 e9 ce f9 0f 0b e9 87 fd ff ff e8 68 e9 ce f9 0f 0b e9 19 fd ff ff e8 5c e9 ce f9 <0f> 0b e9 3e fd ff ff e8 90 39 1b fa e9 ac fb ff ff 48 89 ef e8 a3
RSP: 0018:ffffc90000b27bd0 EFLAGS: 00010293
RAX: 0000000000000000 RBX: ffff88801e637620 RCX: 0000000000000000
RDX: ffff8880175d1d40 RSI: ffffffff87adb324 RDI: ffffc90000b27b18
RBP: ffff88801e637600 R08: 0000000000000001 R09: ffffc90000b27b1f
R10: fffff52000164f63 R11: 000000000008c07e R12: 0000000000000001
R13: ffff88801e637600 R14: ffff8880239b8000 R15: ffff88801e637600
FS:  0000000000000000(0000) GS:ffff8880b9a00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fc41202e01d CR3: 000000001d891000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 ops_exit_list+0xb0/0x170 net/core/net_namespace.c:169
 cleanup_net+0x4ea/0xb00 net/core/net_namespace.c:601
 process_one_work+0x9bf/0x1710 kernel/workqueue.c:2289
 worker_thread+0x665/0x1080 kernel/workqueue.c:2436
 kthread+0x2e4/0x3a0 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:306
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
