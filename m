Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17A80606F06
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 06:45:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229604AbiJUEps (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 00:45:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229657AbiJUEpp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 00:45:45 -0400
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F376153E10
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 21:45:41 -0700 (PDT)
Received: by mail-il1-f198.google.com with SMTP id u2-20020a056e021a4200b002f9ecfa353cso2202856ilv.20
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 21:45:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=orlZny6iNDk2EejWQTGbzbNNRKmJ3AK2gBOcpMbMKK0=;
        b=7LS5EJsnTzVscccVx7RXJFwWWBuUfqBunsLixZo5GWvNtdhHz0SdMZxgqY69nCIxS2
         PxppMne048qvQMFbGdcenSl1sR2DnrLvB1tzxIw48XVo4pEfaBFoOw3IIJYiFmQertEU
         lEKwAI33sxvsZp7GvXIqOAKhOpGZe2vMrbfDm87xwCw7T7PZEixsF2hIxS1+tL7GUJyp
         vFNmDYN/m00u3pGzZWmW78JhA0MBR3UcUUYWTAisi/+udcIJQCd1RHUDR5CiUabADP73
         n4BrMHkJJcr1QDmhh7rLmaHJKKWD/rxEa5vSBVlw/YyVNo40QvQnnZMVeL1TNGIG2OXN
         qedA==
X-Gm-Message-State: ACrzQf2bmOBsKMCc17ocgO3hcYUdGtYA8qVTiE6olVgUzZ2aqvwxBJ8b
        +iVcFp5eIUWdOxo55d0//5lToKkn0ICzyedp4VMRQ2mUAAn4
X-Google-Smtp-Source: AMsMyM6XPSdsldy7eaHzyo6/N0/ero2go/ewz033gZNMTycOWuvcqOSgIjWJsQogcC1L31f0/kBwFSu0GXr2/Xo4qy9ovJt7ae6C
MIME-Version: 1.0
X-Received: by 2002:a02:a519:0:b0:363:b5c6:564e with SMTP id
 e25-20020a02a519000000b00363b5c6564emr13027015jam.253.1666327541346; Thu, 20
 Oct 2022 21:45:41 -0700 (PDT)
Date:   Thu, 20 Oct 2022 21:45:41 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000002e7a8905eb841ddd@google.com>
Subject: [syzbot] general protection fault in erofs_bread
From:   syzbot <syzbot+3faecbfd845a895c04cb@syzkaller.appspotmail.com>
To:     chao@kernel.org, huyue2@coolpad.com, jefflexu@linux.alibaba.com,
        linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, xiang@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    493ffd6605b2 Merge tag 'ucount-rlimits-cleanups-for-v5.19'..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=168c673c880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d19f5d16783f901
dashboard link: https://syzkaller.appspot.com/bug?extid=3faecbfd845a895c04cb
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17fb206a880000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13b166ba880000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/f1ff6481e26f/disk-493ffd66.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/101bd3c7ae47/vmlinux-493ffd66.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/c1b35fb0988a/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+3faecbfd845a895c04cb@syzkaller.appspotmail.com

loop0: detected capacity change from 0 to 264192
erofs: (device loop0): mounted with root inode @ nid 36.
general protection fault, probably for non-canonical address 0xdffffc0000000006: 0000 [#1] PREEMPT SMP KASAN
KASAN: null-ptr-deref in range [0x0000000000000030-0x0000000000000037]
CPU: 0 PID: 3611 Comm: syz-executor373 Not tainted 6.0.0-syzkaller-09423-g493ffd6605b2 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/11/2022
RIP: 0010:erofs_bread+0x33/0x760 fs/erofs/data.c:35
Code: 53 48 83 ec 28 89 cb 41 89 d6 48 89 f5 49 89 fd 49 bc 00 00 00 00 00 fc ff df e8 78 b3 a5 fd 48 83 c5 30 48 89 e8 48 c1 e8 03 <42> 80 3c 20 00 74 08 48 89 ef e8 0e 1e f9 fd 89 5c 24 04 4c 8b 7d
RSP: 0018:ffffc90003bdf2e0 EFLAGS: 00010206
RAX: 0000000000000006 RBX: 0000000000000001 RCX: ffff888018de5880
RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffffc90003bdf4e0
RBP: 0000000000000030 R08: ffffffff83e25022 R09: ffffc90003bdf4e0
R10: fffff5200077be9f R11: 1ffff9200077be9c R12: dffffc0000000000
R13: ffffc90003bdf4e0 R14: 000000007ec94954 R15: 000032487ec94954
FS:  00005555571fa300(0000) GS:ffff8880b9a00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fa00d733260 CR3: 000000007d91f000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 z_erofs_read_fragment fs/erofs/zdata.c:667 [inline]
 z_erofs_do_read_page+0x219c/0x36c0 fs/erofs/zdata.c:780
 z_erofs_pcluster_readmore+0x292/0x450 fs/erofs/zdata.c:1592
 z_erofs_read_folio+0x28a/0x650 fs/erofs/zdata.c:1619
 filemap_read_folio+0x187/0x7d0 mm/filemap.c:2399
 do_read_cache_folio+0x2d3/0x790 mm/filemap.c:3526
 erofs_bread+0x20a/0x760 fs/erofs/data.c:46
 find_target_block_classic fs/erofs/namei.c:108 [inline]
 erofs_namei+0x1bd/0xdb0 fs/erofs/namei.c:184
 erofs_lookup+0xd6/0x1b0 fs/erofs/namei.c:212
 __lookup_hash+0x115/0x240 fs/namei.c:1601
 filename_create+0x25f/0x4f0 fs/namei.c:3785
 do_mkdirat+0xb5/0x550 fs/namei.c:4028
 __do_sys_mkdirat fs/namei.c:4053 [inline]
 __se_sys_mkdirat fs/namei.c:4051 [inline]
 __x64_sys_mkdirat+0x85/0x90 fs/namei.c:4051
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f92785b7039
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffd2273aad8 EFLAGS: 00000246 ORIG_RAX: 0000000000000102
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f92785b7039
RDX: 0000000000000000 RSI: 00000000200002c0 RDI: 0000000000000005
RBP: 00007f9278576830 R08: 00005555571fa2c0 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f92785768c0
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:erofs_bread+0x33/0x760 fs/erofs/data.c:35
Code: 53 48 83 ec 28 89 cb 41 89 d6 48 89 f5 49 89 fd 49 bc 00 00 00 00 00 fc ff df e8 78 b3 a5 fd 48 83 c5 30 48 89 e8 48 c1 e8 03 <42> 80 3c 20 00 74 08 48 89 ef e8 0e 1e f9 fd 89 5c 24 04 4c 8b 7d
RSP: 0018:ffffc90003bdf2e0 EFLAGS: 00010206
RAX: 0000000000000006 RBX: 0000000000000001 RCX: ffff888018de5880
RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffffc90003bdf4e0
RBP: 0000000000000030 R08: ffffffff83e25022 R09: ffffc90003bdf4e0
R10: fffff5200077be9f R11: 1ffff9200077be9c R12: dffffc0000000000
R13: ffffc90003bdf4e0 R14: 000000007ec94954 R15: 000032487ec94954
FS:  00005555571fa300(0000) GS:ffff8880b9a00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00005593dd0b6000 CR3: 000000007d91f000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0:	53                   	push   %rbx
   1:	48 83 ec 28          	sub    $0x28,%rsp
   5:	89 cb                	mov    %ecx,%ebx
   7:	41 89 d6             	mov    %edx,%r14d
   a:	48 89 f5             	mov    %rsi,%rbp
   d:	49 89 fd             	mov    %rdi,%r13
  10:	49 bc 00 00 00 00 00 	movabs $0xdffffc0000000000,%r12
  17:	fc ff df
  1a:	e8 78 b3 a5 fd       	callq  0xfda5b397
  1f:	48 83 c5 30          	add    $0x30,%rbp
  23:	48 89 e8             	mov    %rbp,%rax
  26:	48 c1 e8 03          	shr    $0x3,%rax
* 2a:	42 80 3c 20 00       	cmpb   $0x0,(%rax,%r12,1) <-- trapping instruction
  2f:	74 08                	je     0x39
  31:	48 89 ef             	mov    %rbp,%rdi
  34:	e8 0e 1e f9 fd       	callq  0xfdf91e47
  39:	89 5c 24 04          	mov    %ebx,0x4(%rsp)
  3d:	4c                   	rex.WR
  3e:	8b                   	.byte 0x8b
  3f:	7d                   	.byte 0x7d


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
