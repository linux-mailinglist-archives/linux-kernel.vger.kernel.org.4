Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1312F5E7F42
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 18:05:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231255AbiIWQFt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 12:05:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231207AbiIWQFn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 12:05:43 -0400
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1412AC261
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 09:05:40 -0700 (PDT)
Received: by mail-io1-f69.google.com with SMTP id h205-20020a6bb7d6000000b006a1e6bef9c7so174350iof.17
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 09:05:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date;
        bh=+Kcl3/2lVeEfyVip4L1rMeXIn8tGANryRAg7CHpn59s=;
        b=ZT7WzAAL0GXFhSrVxjK/07hIm/xLpbCaZiUKB1bjrxFiarArayPu6rQyaqCo9//RQu
         b/XtsK5n74fMdvNiLrpwr1RsWV0Mn+Hw7JHhX6neYYJjZ4IQz4KzAGm5Vylx8922ggKu
         4lyI0PwBkBrvAGGSMC6vBvYgIwbfuB2tY90OYgLzAsNtjqrFnp3DC9UAhG2soHhifYnt
         zWOTEVw9+RYfBOCszbYefg5lQszN3dGCjKn0/ya2poRCDdJc9+VCB9hOI3YX+9/enDM6
         VwVjwSWMymDpC3OAlsMYgs7VwIMv0AxK08rNxwcT042rak8Y90cu16evRQEOp9ikWnHa
         KXtg==
X-Gm-Message-State: ACrzQf3hvWKYFb2NrGtV9kQnrwWLuFWLAcdJkmbeajdYvGg6jc7WahXF
        FgaMKMYmEH5jEMDX83Hu+PQTr/aBEzlb2fIRtBbqYkvXvPRp
X-Google-Smtp-Source: AMsMyM4Pr2YHz+Bkb1+3ezzw7OUpNDWtGNZ/oCvrs+RmnV2aFwQuP2T25aGhBy/WSgiuJkWiQpZpVDZrrLLH7G+ayiG3iGHSOfci
MIME-Version: 1.0
X-Received: by 2002:a05:6638:1644:b0:35a:5304:f19f with SMTP id
 a4-20020a056638164400b0035a5304f19fmr5396371jat.270.1663949140142; Fri, 23
 Sep 2022 09:05:40 -0700 (PDT)
Date:   Fri, 23 Sep 2022 09:05:40 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000006c300705e95a59db@google.com>
Subject: [syzbot] general protection fault in PageHeadHuge
From:   syzbot <syzbot+152d76c44ba142f8992b@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, llvm@lists.linux.dev, mike.kravetz@oracle.com,
        nathan@kernel.org, ndesaulniers@google.com,
        songmuchun@bytedance.com, syzkaller-bugs@googlegroups.com,
        trix@redhat.com
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
console output: https://syzkaller.appspot.com/x/log.txt?x=16f0a418880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=849cb9f70f15b1ba
dashboard link: https://syzkaller.appspot.com/bug?extid=152d76c44ba142f8992b
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12b97b64880000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11fb9040880000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/1cb3f4618323/disk-483fed3b.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/cc02cb30b495/vmlinux-483fed3b.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+152d76c44ba142f8992b@syzkaller.appspotmail.com

general protection fault, probably for non-canonical address 0xdffffc0000000000: 0000 [#1] PREEMPT SMP KASAN
KASAN: null-ptr-deref in range [0x0000000000000000-0x0000000000000007]
CPU: 1 PID: 3617 Comm: syz-executor722 Not tainted 6.0.0-rc6-next-20220921-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/16/2022
RIP: 0010:PagePoisoned include/linux/page-flags.h:304 [inline]
RIP: 0010:PageHead include/linux/page-flags.h:787 [inline]
RIP: 0010:PageHeadHuge+0x1d/0x200 mm/hugetlb.c:1892
Code: ff 66 66 2e 0f 1f 84 00 00 00 00 00 90 41 54 55 48 89 fd 53 e8 54 c9 b9 ff 48 89 ea 48 b8 00 00 00 00 00 fc ff df 48 c1 ea 03 <80> 3c 02 00 0f 85 a2 01 00 00 48 8b 5d 00 48 c7 c7 ff ff ff ff 48
RSP: 0018:ffffc90003e7f5a0 EFLAGS: 00010246
RAX: dffffc0000000000 RBX: ffffc90003e7f788 RCX: 0000000000000000
RDX: 0000000000000000 RSI: ffffffff81c2cb2c RDI: 0000000000000000
RBP: 0000000000000000 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000001 R12: ffffc90003e7f798
R13: 0000000000000000 R14: 0000000000000000 R15: 00000000000003f4
FS:  00007f5642262700(0000) GS:ffff8880b9b00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00000000203f4ef0 CR3: 000000007adcc000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 folio_test_hugetlb include/linux/page-flags.h:831 [inline]
 folio_file_page include/linux/pagemap.h:683 [inline]
 shmem_fault+0x27c/0x8a0 mm/shmem.c:2130
 __do_fault+0x107/0x600 mm/memory.c:4191
 do_shared_fault mm/memory.c:4597 [inline]
 do_fault mm/memory.c:4675 [inline]
 handle_pte_fault mm/memory.c:4943 [inline]
 __handle_mm_fault+0x2200/0x3a40 mm/memory.c:5085
 handle_mm_fault+0x1c8/0x780 mm/memory.c:5206
 do_user_addr_fault+0x475/0x1210 arch/x86/mm/fault.c:1428
 handle_page_fault arch/x86/mm/fault.c:1519 [inline]
 exc_page_fault+0x94/0x170 arch/x86/mm/fault.c:1575
 asm_exc_page_fault+0x22/0x30 arch/x86/include/asm/idtentry.h:570
RIP: 0010:__put_user_nocheck_4+0x3/0x11
Code: 00 00 48 39 d9 73 54 0f 01 cb 66 89 01 31 c9 0f 01 ca c3 0f 1f 44 00 00 48 bb fd ef ff ff ff 7f 00 00 48 39 d9 73 34 0f 01 cb <89> 01 31 c9 0f 01 ca c3 66 0f 1f 44 00 00 48 bb f9 ef ff ff ff 7f
RSP: 0018:ffffc90003e7fa00 EFLAGS: 00050293
RAX: 0000000000000000 RBX: ffffc90003e7fdf4 RCX: 00000000203f4ef0
RDX: ffff888020c51d40 RSI: ffffffff8726d52f RDI: 0000000000000005
RBP: ffffc90003e7fdb0 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000000000002 R11: 0000000000000001 R12: 0000000000000000
R13: 0000000000000002 R14: 00000000203f4ef0 R15: 0000000000000000
 ____sys_recvmsg+0x3ba/0x610 net/socket.c:2714
 ___sys_recvmsg+0xf2/0x180 net/socket.c:2743
 do_recvmmsg+0x25e/0x6e0 net/socket.c:2837
 __sys_recvmmsg net/socket.c:2916 [inline]
 __do_sys_recvmmsg net/socket.c:2939 [inline]
 __se_sys_recvmmsg net/socket.c:2932 [inline]
 __x64_sys_recvmmsg+0x20b/0x260 net/socket.c:2932
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f56422dabb9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 91 18 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f5642262208 EFLAGS: 00000246 ORIG_RAX: 000000000000012b
RAX: ffffffffffffffda RBX: 00007f564235c4b8 RCX: 00007f56422dabb9
RDX: 0000000000010106 RSI: 00000000200000c0 RDI: 0000000000000003
RBP: 00007f564235c4b0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000002 R11: 0000000000000246 R12: 00007f564235c4bc
R13: 00007fffbde3618f R14: 00007f5642262300 R15: 0000000000022000
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:PagePoisoned include/linux/page-flags.h:304 [inline]
RIP: 0010:PageHead include/linux/page-flags.h:787 [inline]
RIP: 0010:PageHeadHuge+0x1d/0x200 mm/hugetlb.c:1892
Code: ff 66 66 2e 0f 1f 84 00 00 00 00 00 90 41 54 55 48 89 fd 53 e8 54 c9 b9 ff 48 89 ea 48 b8 00 00 00 00 00 fc ff df 48 c1 ea 03 <80> 3c 02 00 0f 85 a2 01 00 00 48 8b 5d 00 48 c7 c7 ff ff ff ff 48
RSP: 0018:ffffc90003e7f5a0 EFLAGS: 00010246
RAX: dffffc0000000000 RBX: ffffc90003e7f788 RCX: 0000000000000000
RDX: 0000000000000000 RSI: ffffffff81c2cb2c RDI: 0000000000000000
RBP: 0000000000000000 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000001 R12: ffffc90003e7f798
R13: 0000000000000000 R14: 0000000000000000 R15: 00000000000003f4
FS:  00007f5642262700(0000) GS:ffff8880b9a00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f56419ff718 CR3: 000000007adcc000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0:	ff 66 66             	jmpq   *0x66(%rsi)
   3:	2e 0f 1f 84 00 00 00 	nopl   %cs:0x0(%rax,%rax,1)
   a:	00 00
   c:	90                   	nop
   d:	41 54                	push   %r12
   f:	55                   	push   %rbp
  10:	48 89 fd             	mov    %rdi,%rbp
  13:	53                   	push   %rbx
  14:	e8 54 c9 b9 ff       	callq  0xffb9c96d
  19:	48 89 ea             	mov    %rbp,%rdx
  1c:	48 b8 00 00 00 00 00 	movabs $0xdffffc0000000000,%rax
  23:	fc ff df
  26:	48 c1 ea 03          	shr    $0x3,%rdx
* 2a:	80 3c 02 00          	cmpb   $0x0,(%rdx,%rax,1) <-- trapping instruction
  2e:	0f 85 a2 01 00 00    	jne    0x1d6
  34:	48 8b 5d 00          	mov    0x0(%rbp),%rbx
  38:	48 c7 c7 ff ff ff ff 	mov    $0xffffffffffffffff,%rdi
  3f:	48                   	rex.W


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
