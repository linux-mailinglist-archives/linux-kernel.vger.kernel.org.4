Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D381B60573E
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 08:17:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230108AbiJTGRp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 02:17:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229588AbiJTGRn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 02:17:43 -0400
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1977184994
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 23:17:41 -0700 (PDT)
Received: by mail-il1-f199.google.com with SMTP id i4-20020a056e02152400b002fa876e95b3so19196230ilu.17
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 23:17:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DBc7Xw2HbF4h3gnckV7KCo2QmXlEWnaB1MHtVlvS1GA=;
        b=ML0PYUvFu2A9lXO9iW3zBsNp26soX2kkpyp7hGxz/xxmXLI4GIUGFRsBA+tGW/Dgm7
         4ncWc3dWjrWCfB9GHSphqA+DjYBUlrUvGbIa7L/2gz9TPWoHyswUo+osEPtWK29xi0K4
         wJKPyPuip3bcTxTGWkJyRgBd3DfKw4EM27pAZOKwo5vSKdP0k86iPd3ekNvj/kwhv9AS
         R6E4lVpYkJ+/8dKEO8E7mSAtVrbmPwNagO7yrGVbbPuXR8zmoUvovwI/SS2zZck73kxL
         918TDkG3JswrdC05UZxNqCcQZmqcqcCCgfYjWfMEJGikSS69sVrp3y12miJGkiG0sn69
         qyDA==
X-Gm-Message-State: ACrzQf3rA90dWzRLV+CLij/imE9lPQVln6szs3rfw46aID8EnRginwKP
        aPySWhxp6QOfzXi1itoIVEIlYC/d7PHOZs+DIIzOcoiyw+Nd
X-Google-Smtp-Source: AMsMyM6hGq6RnqsBwy9BdPUy8QoOU8kxV/JmTATMK+MpM8POvOLd7QLNVGkBULbGVELkHEBXdw9fhvl7uZogrshcgaFWnePZx6LO
MIME-Version: 1.0
X-Received: by 2002:a05:6638:2685:b0:363:dfd1:a144 with SMTP id
 o5-20020a056638268500b00363dfd1a144mr10086616jat.249.1666246661293; Wed, 19
 Oct 2022 23:17:41 -0700 (PDT)
Date:   Wed, 19 Oct 2022 23:17:41 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000005ad00405eb7148c6@google.com>
Subject: [syzbot] general protection fault in hugetlbfs_parse_param
From:   syzbot <syzbot+a3e6acd85ded5c16a709@syzkaller.appspotmail.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        mike.kravetz@oracle.com, songmuchun@bytedance.com,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    a72b55bc981b Add linux-next specific files for 20221019
git tree:       linux-next
console+strace: https://syzkaller.appspot.com/x/log.txt?x=14510b06880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=200524babbc01b2a
dashboard link: https://syzkaller.appspot.com/bug?extid=a3e6acd85ded5c16a709
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15bbe2d2880000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16678bd6880000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/fa24fb5893fd/disk-a72b55bc.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/cf1b7e7b579c/vmlinux-a72b55bc.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+a3e6acd85ded5c16a709@syzkaller.appspotmail.com

general protection fault, probably for non-canonical address 0xdffffc0000000000: 0000 [#1] PREEMPT SMP KASAN
KASAN: null-ptr-deref in range [0x0000000000000000-0x0000000000000007]
CPU: 1 PID: 3607 Comm: syz-executor454 Not tainted 6.1.0-rc1-next-20221019-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/22/2022
RIP: 0010:hugetlbfs_parse_param+0x1dd/0x8e0 fs/hugetlbfs/inode.c:1380
Code: 00 fc ff df 48 89 fa 48 c1 ea 03 80 3c 02 00 0f 85 84 06 00 00 48 b8 00 00 00 00 00 fc ff df 4d 8b 65 10 4c 89 e2 48 c1 ea 03 <0f> b6 04 02 4c 89 e2 83 e2 07 38 d0 7f 0c 84 c0 74 08 4c 89 e7 e8
RSP: 0018:ffffc90003a5fb48 EFLAGS: 00010246
RAX: dffffc0000000000 RBX: 1ffff9200074bf6b RCX: 0000000000000000
RDX: 0000000000000000 RSI: ffffffff82350899 RDI: ffffc90003a5fc78
RBP: ffff88801db5ac00 R08: 0000000000000005 R09: 0000000000000006
R10: 0000000000000005 R11: 000000000008c001 R12: 0000000000000000
R13: ffffc90003a5fc68 R14: ffff88801d5fbf00 R15: ffff88801db5acd0
FS:  00005555569383c0(0000) GS:ffff8880b9b00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020001000 CR3: 0000000074e4c000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 vfs_parse_fs_param fs/fs_context.c:148 [inline]
 vfs_parse_fs_param+0x1f9/0x3c0 fs/fs_context.c:129
 vfs_parse_fs_string+0xdb/0x170 fs/fs_context.c:191
 generic_parse_monolithic+0x16f/0x1f0 fs/fs_context.c:231
 do_new_mount fs/namespace.c:3036 [inline]
 path_mount+0x12de/0x1e20 fs/namespace.c:3370
 do_mount fs/namespace.c:3383 [inline]
 __do_sys_mount fs/namespace.c:3591 [inline]
 __se_sys_mount fs/namespace.c:3568 [inline]
 __x64_sys_mount+0x27f/0x300 fs/namespace.c:3568
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f06d8633fe9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffe278e8e18 EFLAGS: 00000246 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 00007ffe278e8e28 RCX: 00007f06d8633fe9
RDX: 0000000020000040 RSI: 0000000020000000 RDI: 0000000000000000
RBP: 00007ffe278e8e20 R08: 0000000020000280 R09: 00007f06d85f20a0
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:hugetlbfs_parse_param+0x1dd/0x8e0 fs/hugetlbfs/inode.c:1380
Code: 00 fc ff df 48 89 fa 48 c1 ea 03 80 3c 02 00 0f 85 84 06 00 00 48 b8 00 00 00 00 00 fc ff df 4d 8b 65 10 4c 89 e2 48 c1 ea 03 <0f> b6 04 02 4c 89 e2 83 e2 07 38 d0 7f 0c 84 c0 74 08 4c 89 e7 e8
RSP: 0018:ffffc90003a5fb48 EFLAGS: 00010246
RAX: dffffc0000000000 RBX: 1ffff9200074bf6b RCX: 0000000000000000
RDX: 0000000000000000 RSI: ffffffff82350899 RDI: ffffc90003a5fc78
RBP: ffff88801db5ac00 R08: 0000000000000005 R09: 0000000000000006
R10: 0000000000000005 R11: 000000000008c001 R12: 0000000000000000
R13: ffffc90003a5fc68 R14: ffff88801d5fbf00 R15: ffff88801db5acd0
FS:  00005555569383c0(0000) GS:ffff8880b9a00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f06d86453c0 CR3: 0000000074e4c000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess), 3 bytes skipped:
   0:	df 48 89             	fisttps -0x77(%rax)
   3:	fa                   	cli
   4:	48 c1 ea 03          	shr    $0x3,%rdx
   8:	80 3c 02 00          	cmpb   $0x0,(%rdx,%rax,1)
   c:	0f 85 84 06 00 00    	jne    0x696
  12:	48 b8 00 00 00 00 00 	movabs $0xdffffc0000000000,%rax
  19:	fc ff df
  1c:	4d 8b 65 10          	mov    0x10(%r13),%r12
  20:	4c 89 e2             	mov    %r12,%rdx
  23:	48 c1 ea 03          	shr    $0x3,%rdx
* 27:	0f b6 04 02          	movzbl (%rdx,%rax,1),%eax <-- trapping instruction
  2b:	4c 89 e2             	mov    %r12,%rdx
  2e:	83 e2 07             	and    $0x7,%edx
  31:	38 d0                	cmp    %dl,%al
  33:	7f 0c                	jg     0x41
  35:	84 c0                	test   %al,%al
  37:	74 08                	je     0x41
  39:	4c 89 e7             	mov    %r12,%rdi
  3c:	e8                   	.byte 0xe8


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
