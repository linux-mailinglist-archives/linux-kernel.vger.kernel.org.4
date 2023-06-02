Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3412D720986
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 21:10:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237139AbjFBTJ4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 15:09:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237163AbjFBTJy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 15:09:54 -0400
Received: from mail-io1-f79.google.com (mail-io1-f79.google.com [209.85.166.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F04231B7
        for <linux-kernel@vger.kernel.org>; Fri,  2 Jun 2023 12:09:52 -0700 (PDT)
Received: by mail-io1-f79.google.com with SMTP id ca18e2360f4ac-76c27782e30so117716539f.3
        for <linux-kernel@vger.kernel.org>; Fri, 02 Jun 2023 12:09:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685732992; x=1688324992;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TfD67AHbNNO26mbSHwE6PpGn0aFEL+Rtn0yhkkG5vWA=;
        b=Y0dqNOuzH4f/bF2aS1ZctjzuC3wfCU+Onn36G2URqcrcjbR5pM0OXZn776GDE9hb6m
         6ccGzEYOrys4/bu2eC0wMPKd+PImefHNkXr2tvmWGXE75yNDHF6HneZvEWU5hj1KwrrN
         WUHpTDabIUT0I6dys5NucHN7sDYnaFZjhvOUESHIXQKRPiTzXf+82gzKp56pPAV4A4j3
         NzjbkMVxx3oLB3v5T5tZ9fKy5gE0nVuF8IUw9oSd2Ii7uUcX5x8EEgRsJp9qDobZIm4U
         RtdF3LR/0n1uEfMXebXXB/Zmd47r7KqQEa1McrmInHyQq8K1oExZeN22wPY916aBXqOf
         XBVg==
X-Gm-Message-State: AC+VfDxb+JkxNVtEbe3LmhWbMGuzSLXHgsrK2GOacgVCnYLxP2kE0Hyg
        fppMUQ/ZJJOMpAaKuZWezWI5IcjkgdSJpNOBtyFdbNdchWph
X-Google-Smtp-Source: ACHHUZ54Fo5E3lzJWH2y0mAX2bvbIdLc8dwrXN+GZzp2f8Vy4gizoRHIN7UYFLNDsKmhI4vAId24e3c2PnHrfVBS1wGPNOUXGmGz
MIME-Version: 1.0
X-Received: by 2002:a02:2383:0:b0:41a:c455:f4c8 with SMTP id
 u125-20020a022383000000b0041ac455f4c8mr5432177jau.3.1685732992346; Fri, 02
 Jun 2023 12:09:52 -0700 (PDT)
Date:   Fri, 02 Jun 2023 12:09:52 -0700
In-Reply-To: <0000000000002c404a05fd29e1f1@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000031f16805fd2a4cca@google.com>
Subject: Re: [syzbot] [usb?] kernel BUG in cdc_ncm_fill_tx_frame
From:   syzbot <syzbot+1994e2ecf323ed90f255@syzkaller.appspotmail.com>
To:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        netdev@vger.kernel.org, oliver@neukum.org, pabeni@redhat.com,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has found a reproducer for the following issue on:

HEAD commit:    243ff7e6a035 usb: typec: mux: fix static inline syntax error
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git usb-testing
console output: https://syzkaller.appspot.com/x/log.txt?x=157524c9280000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8f4cf51e432f1270
dashboard link: https://syzkaller.appspot.com/bug?extid=1994e2ecf323ed90f255
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16e8f82d280000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/10340f2fbad7/disk-243ff7e6.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/b167d8c15ccb/vmlinux-243ff7e6.xz
kernel image: https://storage.googleapis.com/syzbot-assets/3cad21c537c2/bzImage-243ff7e6.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+1994e2ecf323ed90f255@syzkaller.appspotmail.com

skbuff: skb_over_panic: text:ffffffff83e701ab len:428 put:172 head:ffff88810fbb7600 data:ffff88810fbb7600 tail:0x1ac end:0x140 dev:<NULL>
------------[ cut here ]------------
kernel BUG at net/core/skbuff.c:200!
invalid opcode: 0000 [#1] PREEMPT SMP KASAN
CPU: 1 PID: 2989 Comm: dhcpcd Not tainted 6.4.0-rc4-syzkaller-00151-g243ff7e6a035 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/25/2023
RIP: 0010:skb_panic+0x152/0x1d0 net/core/skbuff.c:200
Code: 0f b6 04 01 84 c0 74 04 3c 03 7e 20 8b 4b 70 41 56 45 89 e8 48 c7 c7 c0 28 16 87 41 57 56 48 89 ee 52 4c 89 e2 e8 3e db 00 fc <0f> 0b 4c 89 4c 24 10 48 89 54 24 08 48 89 34 24 e8 39 43 66 fc 4c
RSP: 0018:ffffc9000292f288 EFLAGS: 00010282
RAX: 0000000000000089 RBX: ffff888113ff4640 RCX: 0000000000000000
RDX: 0000000000000000 RSI: ffffffff812fd52c RDI: 0000000000000005
RBP: ffffffff87163720 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000080000403 R11: 0000000000000001 R12: ffffffff83e701ab
R13: 00000000000000ac R14: ffffffff87162880 R15: 0000000000000140
FS:  00007f85588ea740(0000) GS:ffff8881f6700000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ffe9be70bc8 CR3: 000000011ad10000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 skb_over_panic net/core/skbuff.c:205 [inline]
 skb_put+0x16f/0x1a0 net/core/skbuff.c:2390
 skb_put_zero include/linux/skbuff.h:2605 [inline]
 cdc_ncm_ndp16 drivers/net/usb/cdc_ncm.c:1135 [inline]
 cdc_ncm_fill_tx_frame+0x20fb/0x38d0 drivers/net/usb/cdc_ncm.c:1310
 cdc_ncm_tx_fixup+0xde/0x120 drivers/net/usb/cdc_ncm.c:1537
 usbnet_start_xmit+0x156/0x2180 drivers/net/usb/usbnet.c:1365
 __netdev_start_xmit include/linux/netdevice.h:4915 [inline]
 netdev_start_xmit include/linux/netdevice.h:4929 [inline]
 xmit_one net/core/dev.c:3578 [inline]
 dev_hard_start_xmit+0x187/0x700 net/core/dev.c:3594
 sch_direct_xmit+0x25f/0x7f0 net/sched/sch_generic.c:342
 __dev_xmit_skb net/core/dev.c:3805 [inline]
 __dev_queue_xmit+0x14c3/0x3ae0 net/core/dev.c:4210
 dev_queue_xmit include/linux/netdevice.h:3085 [inline]
 packet_xmit+0x268/0x390 net/packet/af_packet.c:276
 packet_snd net/packet/af_packet.c:3081 [inline]
 packet_sendmsg+0x348c/0x5040 net/packet/af_packet.c:3113
 sock_sendmsg_nosec net/socket.c:724 [inline]
 sock_sendmsg+0xde/0x190 net/socket.c:747
 sock_write_iter+0x295/0x3d0 net/socket.c:1140
 call_write_iter include/linux/fs.h:1868 [inline]
 do_iter_readv_writev+0x20b/0x3b0 fs/read_write.c:735
 do_iter_write+0x185/0x7e0 fs/read_write.c:860
 vfs_writev+0x1aa/0x670 fs/read_write.c:933
 do_writev+0x279/0x2f0 fs/read_write.c:976
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f85589b8e03
Code: 89 c7 48 89 44 24 08 e8 6a f2 f9 ff 48 8b 44 24 08 48 83 c4 28 c3 c3 64 8b 04 25 18 00 00 00 85 c0 75 20 b8 14 00 00 00 0f 05 <48> 3d 00 f0 ff ff 76 6d 48 8b 15 f6 5f 0d 00 f7 d8 64 89 02 48 83
RSP: 002b:00007ffe9be70b68 EFLAGS: 00000246 ORIG_RAX: 0000000000000014
RAX: ffffffffffffffda RBX: 00007ffe9be80e18 RCX: 00007f85589b8e03
RDX: 0000000000000002 RSI: 00007ffe9be70b80 RDI: 0000000000000005
RBP: 000055e28be2d9c7 R08: 0000000042424242 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 000055e28d0a7960 R14: 00007ffe9be70c18 R15: 00007ffe9be70bc8
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:skb_panic+0x152/0x1d0 net/core/skbuff.c:200
Code: 0f b6 04 01 84 c0 74 04 3c 03 7e 20 8b 4b 70 41 56 45 89 e8 48 c7 c7 c0 28 16 87 41 57 56 48 89 ee 52 4c 89 e2 e8 3e db 00 fc <0f> 0b 4c 89 4c 24 10 48 89 54 24 08 48 89 34 24 e8 39 43 66 fc 4c
RSP: 0018:ffffc9000292f288 EFLAGS: 00010282
RAX: 0000000000000089 RBX: ffff888113ff4640 RCX: 0000000000000000
RDX: 0000000000000000 RSI: ffffffff812fd52c RDI: 0000000000000005
RBP: ffffffff87163720 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000080000403 R11: 0000000000000001 R12: ffffffff83e701ab
R13: 00000000000000ac R14: ffffffff87162880 R15: 0000000000000140
FS:  00007f85588ea740(0000) GS:ffff8881f6700000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ffe9be70bc8 CR3: 000000011ad10000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.
