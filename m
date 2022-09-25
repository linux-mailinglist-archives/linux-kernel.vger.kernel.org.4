Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDDED5E92A7
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Sep 2022 13:18:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231705AbiIYLSj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Sep 2022 07:18:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229621AbiIYLSh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Sep 2022 07:18:37 -0400
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BDD12A428
        for <linux-kernel@vger.kernel.org>; Sun, 25 Sep 2022 04:18:36 -0700 (PDT)
Received: by mail-io1-f69.google.com with SMTP id 5-20020a5d9c05000000b006a44709a638so2340916ioe.11
        for <linux-kernel@vger.kernel.org>; Sun, 25 Sep 2022 04:18:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date;
        bh=jM+kD9stAQEL9o9G2v1HS1KzsDhdCnHhpXb2+7ZeIYU=;
        b=y1zXLEjRoNZFx6QqJsiM2OHXAZeqkz42wTfn+Pq/ZDlgTnq2iDhcfWyRK3cQYmLkVR
         mXgSYzF1k8Lz1IzWvpsoZ5ir8IJp7nvGBurEAH+D/XkJe9SkMatP+lukfGBVLo9RV1o3
         GIlGujmWQM2NdOsAN6Ea8jOHhRjCP+HNk0Flu6k2pEbALkJjnirQykgJKOXh6iEEe+7L
         KW5h8I9CAaYcJTNgOdyVgsk+rMsOL6vWGUv69GpfIdZxfiEmf1/Bmutz8RbilCwtmsjG
         TXAOB5EW6BP4RMm+v+5ZBUr7y9XlGmdMWz7EynbtAS0rZ/jeu5mv0dXV9bMO9swYyWi3
         U+OQ==
X-Gm-Message-State: ACrzQf1qk6veCPBbrMoCb7H3CVmB8RHAz6s2HZ5WgxJOvYcYeRyDJhyw
        IAs3EiGTTLqNkea4lb7dZSJJWINQ8U01HH0X8ZgXj28C1KYL
X-Google-Smtp-Source: AMsMyM4xFtTitOsfmSFm6FTzSi51pTHlFTLEdhhfUAOvmrTAg/YNXVq/19RFFaA/HzAe6Cf8gZnHJd5UP95K0GWrAGqHtj36Jdfp
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:8e8:b0:2f3:3e10:d013 with SMTP id
 n8-20020a056e0208e800b002f33e10d013mr7592825ilt.225.1664104715971; Sun, 25
 Sep 2022 04:18:35 -0700 (PDT)
Date:   Sun, 25 Sep 2022 04:18:35 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000076f3a305e97e9229@google.com>
Subject: [syzbot] WARNING in __change_page_attr_set_clr
From:   syzbot <syzbot+cdcd5043ce8155d92ab1@syzkaller.appspotmail.com>
To:     bp@alien8.de, brijesh.singh@amd.com, dan.j.williams@intel.com,
        dave.hansen@linux.intel.com, hpa@zytor.com, jane.chu@oracle.com,
        kirill.shutemov@linux.intel.com, linux-kernel@vger.kernel.org,
        luto@kernel.org, mingo@redhat.com, peterz@infradead.org,
        seanjc@google.com, syzkaller-bugs@googlegroups.com,
        tglx@linutronix.de, thomas.lendacky@amd.com, x86@kernel.org
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

HEAD commit:    483fed3b5dc8 Add linux-next specific files for 20220921
git tree:       linux-next
console+strace: https://syzkaller.appspot.com/x/log.txt?x=13450b0f080000
kernel config:  https://syzkaller.appspot.com/x/.config?x=849cb9f70f15b1ba
dashboard link: https://syzkaller.appspot.com/bug?extid=cdcd5043ce8155d92ab1
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15e2a1b0880000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=154e7d08880000

Downloadable assets:
disk image: https://storage.googleapis.com/1cb3f4618323/disk-483fed3b.raw.xz
vmlinux: https://storage.googleapis.com/cc02cb30b495/vmlinux-483fed3b.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+cdcd5043ce8155d92ab1@syzkaller.appspotmail.com

------------[ cut here ]------------
CPA refuse W^X violation: 8000000000000163 -> 0000000000000163 range: 0xffffffffa0401000 - 0xffffffffa0401fff PFN 7d8d5
WARNING: CPU: 0 PID: 3607 at arch/x86/mm/pat/set_memory.c:600 verify_rwx arch/x86/mm/pat/set_memory.c:600 [inline]
WARNING: CPU: 0 PID: 3607 at arch/x86/mm/pat/set_memory.c:600 __change_page_attr arch/x86/mm/pat/set_memory.c:1569 [inline]
WARNING: CPU: 0 PID: 3607 at arch/x86/mm/pat/set_memory.c:600 __change_page_attr_set_clr+0x1f40/0x2020 arch/x86/mm/pat/set_memory.c:1691
Modules linked in:
CPU: 0 PID: 3607 Comm: syz-executor178 Not tainted 6.0.0-rc6-next-20220921-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/16/2022
RIP: 0010:verify_rwx arch/x86/mm/pat/set_memory.c:600 [inline]
RIP: 0010:__change_page_attr arch/x86/mm/pat/set_memory.c:1569 [inline]
RIP: 0010:__change_page_attr_set_clr+0x1f40/0x2020 arch/x86/mm/pat/set_memory.c:1691
Code: 8b 44 24 50 4d 89 f1 4c 89 e2 4c 89 ee 48 c7 c7 80 0c ea 89 c6 05 1f 3b 94 0c 01 4c 8d 80 ff 0f 00 00 48 89 c1 e8 fd 62 10 08 <0f> 0b e9 8a fc ff ff e8 f4 a1 91 00 e9 14 f8 ff ff 48 8b 7c 24 08
RSP: 0018:ffffc90003c9ebf8 EFLAGS: 00010286
RAX: 0000000000000000 RBX: 800000007d8d5163 RCX: 0000000000000000
RDX: ffff8880217c57c0 RSI: ffffffff81620348 RDI: fffff52000793d71
RBP: 0000000000000001 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000000000001 R11: 7566657220415043 R12: 0000000000000163
R13: 8000000000000163 R14: 000000000007d8d5 R15: 0000000000000000
FS:  0000555556be0300(0000) GS:ffff8880b9a00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000000045b630 CR3: 0000000073ec9000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 change_page_attr_set_clr+0x333/0x500 arch/x86/mm/pat/set_memory.c:1784
 change_page_attr_clear arch/x86/mm/pat/set_memory.c:1821 [inline]
 set_memory_x+0xb2/0x110 arch/x86/mm/pat/set_memory.c:1999
 bpf_jit_alloc_exec_page+0x69/0x80 kernel/bpf/trampoline.c:131
 bpf_dispatcher_change_prog+0x303/0x8f0 kernel/bpf/dispatcher.c:143
 dev_xdp_install+0x198/0x2b0 net/core/dev.c:9134
 dev_xdp_attach+0xa30/0x12a0 net/core/dev.c:9274
 dev_change_xdp_fd+0x246/0x300 net/core/dev.c:9520
 do_setlink+0x31e3/0x3bb0 net/core/rtnetlink.c:3002
 rtnl_group_changelink net/core/rtnetlink.c:3303 [inline]
 __rtnl_newlink+0xb96/0x17e0 net/core/rtnetlink.c:3557
 rtnl_newlink+0x64/0xa0 net/core/rtnetlink.c:3594
 rtnetlink_rcv_msg+0x43a/0xca0 net/core/rtnetlink.c:6091
 netlink_rcv_skb+0x153/0x420 net/netlink/af_netlink.c:2540
 netlink_unicast_kernel net/netlink/af_netlink.c:1319 [inline]
 netlink_unicast+0x543/0x7f0 net/netlink/af_netlink.c:1345
 netlink_sendmsg+0x917/0xe10 net/netlink/af_netlink.c:1921
 sock_sendmsg_nosec net/socket.c:714 [inline]
 sock_sendmsg+0xcf/0x120 net/socket.c:734
 ____sys_sendmsg+0x712/0x8c0 net/socket.c:2482
 ___sys_sendmsg+0x110/0x1b0 net/socket.c:2536
 __sys_sendmsg+0xf3/0x1c0 net/socket.c:2565
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7fe786b1ce59
Code: 28 c3 e8 2a 14 00 00 66 2e 0f 1f 84 00 00 00 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffecfcfcf28 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007fe786b1ce59
RDX: 0000000000000000 RSI: 0000000020000140 RDI: 0000000000000003
RBP: 00007fe786ae1000 R08: 0000000000000008 R09: 0000000000000000
R10: 0000000000000001 R11: 0000000000000246 R12: 00007fe786ae1090
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
