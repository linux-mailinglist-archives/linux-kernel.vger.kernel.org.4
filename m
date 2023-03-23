Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 233D96C5D0C
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 04:09:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229905AbjCWDJa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 23:09:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbjCWDJ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 23:09:27 -0400
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3139921A3E
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 20:09:25 -0700 (PDT)
Received: by mail-io1-f72.google.com with SMTP id s1-20020a6bd301000000b0073e7646594aso11002383iob.8
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 20:09:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679540964;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EpG+cBS1whAxm3J6/w7OvxKml+n6Q4ipSLvL7aZF0OI=;
        b=DVNNA6lXOu1RDbATTIcciS6gsQ3WeYNI+Vn29cjZbkt8hQmsd6cpBD2KudjOhwlcV5
         3Qnfjr0PyWNja52QJFmfyHRvgvrxgjcm1Ev7pqhJ3VkTe6iw4mBFizvHAxb1qHh6d8tN
         acttEX0B6eCUobNHPK4v0AasRAxiJu5fADlT6ai53rX0+SMekx9Q1wwfGvuINASC9bC5
         u+E8RHEMQKBSV0eXEWEDY0Xw3cF7WKXZRLKb0XlwVuoe+PmgJ+zSC9KZWElAHtszuLfL
         GqXgx0Jve0SMbYkXq6x//hq8K1/IKeX/cEVQX7g8bvEbqT/efPm4RfU/m/uWJcokiKYi
         vrDA==
X-Gm-Message-State: AO0yUKVwmXk+mAeJeePQjEANRyPzy6sxt8JGbgjm4SaAdKgEAKjPXgqh
        eTySyl3oKky9UWxUGJc/yyPBL0fi3bXEksAqmMiNHN6FZ5lO
X-Google-Smtp-Source: AK7set9gRpwlogrR9GI5SqkL+z8OiijD2HgKUZdLDYThD5uMphLsjTFH1GoeMf6AuyHX1BTlvnGGYld+ThMb1nyZauhn+JkGzMwf
MIME-Version: 1.0
X-Received: by 2002:a02:9388:0:b0:404:a43c:65b7 with SMTP id
 z8-20020a029388000000b00404a43c65b7mr3961723jah.4.1679540964591; Wed, 22 Mar
 2023 20:09:24 -0700 (PDT)
Date:   Wed, 22 Mar 2023 20:09:24 -0700
In-Reply-To: <20230323025348.2693-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000094908d05f7889a56@google.com>
Subject: Re: [syzbot] [sctp?] general protection fault in sctp_outq_tail
From:   syzbot <syzbot+47c24ca20a2fa01f082e@syzkaller.appspotmail.com>
To:     hdanton@sina.com, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.6 required=5.0 tests=FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
general protection fault in sctp_sched_fcfs_dequeue

general protection fault, probably for non-canonical address 0xdffffc0000000006: 0000 [#1] PREEMPT SMP KASAN
KASAN: null-ptr-deref in range [0x0000000000000030-0x0000000000000037]
CPU: 0 PID: 6276 Comm: syz-executor.1 Not tainted 6.2.0-syzkaller-12889-gcdd28833100c-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/02/2023
RIP: 0010:sctp_sched_fcfs_dequeue+0xcd/0x140 net/sctp/stream_sched.c:68
Code: 89 fa 48 c1 ea 03 80 3c 02 00 0f 85 80 00 00 00 48 b8 00 00 00 00 00 fc ff df 49 8b 5c 24 08 48 8d 7b 30 48 89 fa 48 c1 ea 03 <80> 3c 02 00 75 59 4c 8b 63 30 49 83 ec 18 e8 d0 a2 1c f8 4c 89 e6
RSP: 0018:ffffc9000365f4c0 EFLAGS: 00010206
RAX: dffffc0000000000 RBX: 0000000000000000 RCX: 0000000000000000
RDX: 0000000000000006 RSI: ffffffff89685ef3 RDI: 0000000000000030
RBP: ffff8880298307e0 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: ffff888026cde0c0
R13: ffff88802adfe800 R14: ffffc9000365f5c8 R15: ffff8880271258d8
FS:  00007f0035bea700(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020034000 CR3: 000000001f088000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 sctp_outq_dequeue_data net/sctp/outqueue.c:76 [inline]
 sctp_outq_flush_data+0x8bf/0x26a0 net/sctp/outqueue.c:1086
 sctp_outq_flush net/sctp/outqueue.c:1219 [inline]
 sctp_outq_uncork+0x17c/0x200 net/sctp/outqueue.c:766
 sctp_cmd_interpreter net/sctp/sm_sideeffect.c:1816 [inline]
 sctp_side_effects net/sctp/sm_sideeffect.c:1199 [inline]
 sctp_do_sm+0x25a5/0x5310 net/sctp/sm_sideeffect.c:1170
 sctp_primitive_SEND+0x9f/0xc0 net/sctp/primitive.c:163
 sctp_sendmsg_to_asoc+0x10eb/0x1a30 net/sctp/socket.c:1868
 sctp_sendmsg+0x8d4/0x1d90 net/sctp/socket.c:2026
 inet_sendmsg+0x9d/0xe0 net/ipv4/af_inet.c:825
 sock_sendmsg_nosec net/socket.c:722 [inline]
 sock_sendmsg+0xde/0x190 net/socket.c:745
 __sys_sendto+0x23a/0x340 net/socket.c:2145
 __do_sys_sendto net/socket.c:2157 [inline]
 __se_sys_sendto net/socket.c:2153 [inline]
 __x64_sys_sendto+0xe1/0x1b0 net/socket.c:2153
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f0034e8c0f9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 f1 19 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f0035bea168 EFLAGS: 00000246 ORIG_RAX: 000000000000002c
RAX: ffffffffffffffda RBX: 00007f0034fac050 RCX: 00007f0034e8c0f9
RDX: 0000000000034000 RSI: 0000000020000080 RDI: 0000000000000003
RBP: 00007f0034ee7ae9 R08: 00000000200005c0 R09: 000000000000001c
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007ffcb991317f R14: 00007f0035bea300 R15: 0000000000022000
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:sctp_sched_fcfs_dequeue+0xcd/0x140 net/sctp/stream_sched.c:68
Code: 89 fa 48 c1 ea 03 80 3c 02 00 0f 85 80 00 00 00 48 b8 00 00 00 00 00 fc ff df 49 8b 5c 24 08 48 8d 7b 30 48 89 fa 48 c1 ea 03 <80> 3c 02 00 75 59 4c 8b 63 30 49 83 ec 18 e8 d0 a2 1c f8 4c 89 e6
RSP: 0018:ffffc9000365f4c0 EFLAGS: 00010206
RAX: dffffc0000000000 RBX: 0000000000000000 RCX: 0000000000000000
RDX: 0000000000000006 RSI: ffffffff89685ef3 RDI: 0000000000000030
RBP: ffff8880298307e0 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: ffff888026cde0c0
R13: ffff88802adfe800 R14: ffffc9000365f5c8 R15: ffff8880271258d8
FS:  00007f0035bea700(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00005604e5e9d950 CR3: 000000001f088000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0:	89 fa                	mov    %edi,%edx
   2:	48 c1 ea 03          	shr    $0x3,%rdx
   6:	80 3c 02 00          	cmpb   $0x0,(%rdx,%rax,1)
   a:	0f 85 80 00 00 00    	jne    0x90
  10:	48 b8 00 00 00 00 00 	movabs $0xdffffc0000000000,%rax
  17:	fc ff df
  1a:	49 8b 5c 24 08       	mov    0x8(%r12),%rbx
  1f:	48 8d 7b 30          	lea    0x30(%rbx),%rdi
  23:	48 89 fa             	mov    %rdi,%rdx
  26:	48 c1 ea 03          	shr    $0x3,%rdx
* 2a:	80 3c 02 00          	cmpb   $0x0,(%rdx,%rax,1) <-- trapping instruction
  2e:	75 59                	jne    0x89
  30:	4c 8b 63 30          	mov    0x30(%rbx),%r12
  34:	49 83 ec 18          	sub    $0x18,%r12
  38:	e8 d0 a2 1c f8       	callq  0xf81ca30d
  3d:	4c 89 e6             	mov    %r12,%rsi


Tested on:

commit:         cdd28833 net: microchip: sparx5: fix deletion of exist..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git
console output: https://syzkaller.appspot.com/x/log.txt?x=13ec7aa1c80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=cab35c936731a347
dashboard link: https://syzkaller.appspot.com/bug?extid=47c24ca20a2fa01f082e
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1391497ac80000

