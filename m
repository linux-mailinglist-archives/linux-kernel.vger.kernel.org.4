Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 678DB654D7B
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Dec 2022 09:29:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236082AbiLWI3i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Dec 2022 03:29:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235701AbiLWI3g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Dec 2022 03:29:36 -0500
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E000734D1A
        for <linux-kernel@vger.kernel.org>; Fri, 23 Dec 2022 00:29:34 -0800 (PST)
Received: by mail-il1-f197.google.com with SMTP id a10-20020a056e02180a00b0030bc09c6b94so2350610ilv.6
        for <linux-kernel@vger.kernel.org>; Fri, 23 Dec 2022 00:29:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yq9FN37EjnzFvzk0X4kPUox4xYL4nnb5F7GXVPf/ZN4=;
        b=13xiZRwNxmEFz2n7TnTfU9x4pGl9WRp3wqpDwhf4cAzvK5qZ2Cfm94o02mwVrgtdk0
         yjnZS8QF6BVRny/fpp8H0hcKKrAJn0sSBTiPP/+bcalFdACIVph1fivtEe7bj3hKWZ/v
         gm/E4V/XRUBFEu58JbMmsf8XtCrEJXNfjZO+WUPdGXJ7PzkjijZBybSnix24FRiAtSB0
         1QvosxXKX+MBDH8owcEAHh8lhHqbXDjdWx/09mafAdFIdcfD3+WdZUek7eNxN/EPlqO2
         7s9yXO/ikVfEYgVEeiTCQ9dqb+ISPwbku5U8HdudsAJO9YxalBLkBbLTM+V9xhoPVj+n
         B5Xg==
X-Gm-Message-State: AFqh2krVbeU+NYeeUNEXzRD19Y8uhUvuoNCMW3UXJ1Po5gbDelAiDXzT
        ScU/mNOk2b8SWur6KEaJPR++CAy0vfx2YdJFdvN+6nekPw6V
X-Google-Smtp-Source: AMrXdXvcNDEnFCMzndQipkM5q65XtBP5dMUearBBfqtC/kvI8F9d93JReEEzrFy9V217dd7oTQklAbCsaJOP+u09PaM6C2il6FNJ
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1048:b0:30b:b94e:522 with SMTP id
 p8-20020a056e02104800b0030bb94e0522mr890795ilj.195.1671784174287; Fri, 23 Dec
 2022 00:29:34 -0800 (PST)
Date:   Fri, 23 Dec 2022 00:29:34 -0800
In-Reply-To: <0000000000002b4a9f05ef2b616f@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000d9826e05f07a95b3@google.com>
Subject: Re: [syzbot] kernel BUG in rxrpc_put_peer
From:   syzbot <syzbot+c22650d2844392afdcfd@syzkaller.appspotmail.com>
To:     davem@davemloft.net, dhowells@redhat.com, edumazet@google.com,
        kuba@kernel.org, linux-afs@lists.infradead.org,
        linux-kernel@vger.kernel.org, marc.dionne@auristor.com,
        netdev@vger.kernel.org, pabeni@redhat.com,
        syzkaller-bugs@googlegroups.com
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

HEAD commit:    8395ae05cb5a Merge tag 'scsi-misc' of git://git.kernel.org..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=1458e1cf880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b0e81c4eb13a67cd
dashboard link: https://syzkaller.appspot.com/bug?extid=c22650d2844392afdcfd
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14386450480000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17223f80480000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/185a22278a16/disk-8395ae05.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/852ad4c6710f/vmlinux-8395ae05.xz
kernel image: https://storage.googleapis.com/syzbot-assets/d0b9daae6d3a/bzImage-8395ae05.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+c22650d2844392afdcfd@syzkaller.appspotmail.com

rxrpc: Assertion failed
------------[ cut here ]------------
kernel BUG at net/rxrpc/peer_object.c:413!
invalid opcode: 0000 [#1] PREEMPT SMP KASAN
CPU: 1 PID: 27502 Comm: krxrpcio/0 Not tainted 6.1.0-syzkaller-14446-g8395ae05cb5a #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/26/2022
RIP: 0010:__rxrpc_put_peer net/rxrpc/peer_object.c:413 [inline]
RIP: 0010:rxrpc_put_peer.cold+0x11/0x13 net/rxrpc/peer_object.c:437
Code: ff e9 21 62 f9 fe e8 74 30 7e f7 48 c7 c7 a0 16 76 8b e8 04 ef bc ff 0f 0b e8 61 30 7e f7 48 c7 c7 a0 1b 76 8b e8 f1 ee bc ff <0f> 0b e8 4e 30 7e f7 4c 8b 4c 24 30 48 89 ea 48 89 ee 48 c7 c1 a0
RSP: 0018:ffffc9000607fbe8 EFLAGS: 00010282
RAX: 0000000000000017 RBX: ffff88801eeb7800 RCX: 0000000000000000
RDX: ffff88802b638280 RSI: ffffffff8165927c RDI: fffff52000c0ff6f
RBP: ffff888028d23c00 R08: 0000000000000017 R09: 0000000000000000
R10: 0000000080000000 R11: 0000000000000000 R12: ffff888028550000
R13: ffff888028d23d28 R14: ffff888028d23c10 R15: ffff888028d23c30
FS:  0000000000000000(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020000140 CR3: 0000000077fb2000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 rxrpc_clean_up_connection+0x37d/0x4b0 net/rxrpc/conn_object.c:317
 rxrpc_put_connection.part.0+0x1e8/0x210 net/rxrpc/conn_object.c:356
 rxrpc_put_connection+0x25/0x30 net/rxrpc/conn_object.c:339
 rxrpc_clean_up_local_conns+0x3ad/0x530 net/rxrpc/conn_client.c:1129
 rxrpc_destroy_local+0x170/0x2f0 net/rxrpc/local_object.c:395
 rxrpc_io_thread+0xce8/0xfb0 net/rxrpc/io_thread.c:496
 kthread+0x2e8/0x3a0 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:308
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:__rxrpc_put_peer net/rxrpc/peer_object.c:413 [inline]
RIP: 0010:rxrpc_put_peer.cold+0x11/0x13 net/rxrpc/peer_object.c:437
Code: ff e9 21 62 f9 fe e8 74 30 7e f7 48 c7 c7 a0 16 76 8b e8 04 ef bc ff 0f 0b e8 61 30 7e f7 48 c7 c7 a0 1b 76 8b e8 f1 ee bc ff <0f> 0b e8 4e 30 7e f7 4c 8b 4c 24 30 48 89 ea 48 89 ee 48 c7 c1 a0
RSP: 0018:ffffc9000607fbe8 EFLAGS: 00010282
RAX: 0000000000000017 RBX: ffff88801eeb7800 RCX: 0000000000000000
RDX: ffff88802b638280 RSI: ffffffff8165927c RDI: fffff52000c0ff6f
RBP: ffff888028d23c00 R08: 0000000000000017 R09: 0000000000000000
R10: 0000000080000000 R11: 0000000000000000 R12: ffff888028550000
R13: ffff888028d23d28 R14: ffff888028d23c10 R15: ffff888028d23c30
FS:  0000000000000000(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020000140 CR3: 000000000c48e000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400

