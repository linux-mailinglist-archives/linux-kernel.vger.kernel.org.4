Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 658CF738896
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 17:15:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232911AbjFUPPp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 11:15:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232725AbjFUPPX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 11:15:23 -0400
Received: from mail-il1-f205.google.com (mail-il1-f205.google.com [209.85.166.205])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 435B44EFB
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 08:11:18 -0700 (PDT)
Received: by mail-il1-f205.google.com with SMTP id e9e14a558f8ab-34128d59c06so55955335ab.2
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 08:11:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687360265; x=1689952265;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2nk8zGziA31WDOuvA0aYlNn4pdInQRqMJ/p71b4Na7s=;
        b=aGbLgYdV9j0CMbOvWNEYJvbphp9niV645NxZDA11hwRqDMgUJrhPwCMO+LCHs7eOrD
         WWk835o2yhD/ahVWyIHJyDFm3pfEfWVWxCFoD5zfEzHn0nYZxS7FHNT7mDI3zVUPj+CG
         DJcrWB6VkG/tDSDa3q7ETeY30EREDoWga82qHRAKX0cGnCfuq+/Q32h2HAVyiq29mvSb
         44Sac7Pv2D1UkUx4cDefv7pQNx06nnTN3cXrD68vJw6/wop/AvLaj3uCCn59Zbl2w0Bx
         bUe/xqtTvf23RE9d1qzP/wUNJ/UG/16qr46woZVxsgKNOERJajstEjvAmDIY3hgpi2wy
         DSjw==
X-Gm-Message-State: AC+VfDxGsCwDuTQqob/suy0HO4TJQWH07tDx+wC9wpUUH/NlQqde7VWa
        O6xjk7TIfqVzkQjvrNTrNyrGUE2Wn/VL9PpubXJMj7sr28x3
X-Google-Smtp-Source: ACHHUZ6j3i+8aue6dZr8BsfRhQKrwEUClSXrs3xjVwi9IORjcw+NLtmFVF291c+rd0h0HVphtwF8nH2FGodfjWSb9oqH1IgXSZ2b
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:541:b0:33e:8aa2:4a0a with SMTP id
 i1-20020a056e02054100b0033e8aa24a0amr5897970ils.4.1687360265045; Wed, 21 Jun
 2023 08:11:05 -0700 (PDT)
Date:   Wed, 21 Jun 2023 08:11:05 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000034cf5d05fea52dd4@google.com>
Subject: [syzbot] [dri?] divide error in drm_mode_vrefresh
From:   syzbot <syzbot+622bba18029bcde672e1@syzkaller.appspotmail.com>
To:     airlied@gmail.com, daniel@ffwll.ch, davem@davemloft.net,
        dri-devel@lists.freedesktop.org, dsahern@kernel.org,
        edumazet@google.com, jacob.e.keller@intel.com, jiri@nvidia.com,
        kuba@kernel.org, linux-kernel@vger.kernel.org,
        maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        netdev@vger.kernel.org, pabeni@redhat.com,
        syzkaller-bugs@googlegroups.com, tzimmermann@suse.de
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

Hello,

syzbot found the following issue on:

HEAD commit:    1639fae5132b Merge tag 'drm-fixes-2023-06-17' of git://ano..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=153ae86b280000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ac246111fb601aec
dashboard link: https://syzkaller.appspot.com/bug?extid=622bba18029bcde672e1
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12fcd517280000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15de5137280000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/ddaf9fb256b7/disk-1639fae5.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/82b7be81b931/vmlinux-1639fae5.xz
kernel image: https://storage.googleapis.com/syzbot-assets/926a973a103a/bzImage-1639fae5.xz

The issue was bisected to:

commit 565b4824c39fa335cba2028a09d7beb7112f3c9a
Author: Jiri Pirko <jiri@nvidia.com>
Date:   Mon Feb 6 09:41:51 2023 +0000

    devlink: change port event netdev notifier from per-net to global

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1010a337280000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=1210a337280000
console output: https://syzkaller.appspot.com/x/log.txt?x=1410a337280000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+622bba18029bcde672e1@syzkaller.appspotmail.com
Fixes: 565b4824c39f ("devlink: change port event netdev notifier from per-net to global")

divide error: 0000 [#1] PREEMPT SMP KASAN
CPU: 1 PID: 5003 Comm: syz-executor375 Not tainted 6.4.0-rc6-syzkaller-00242-g1639fae5132b #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/27/2023
RIP: 0010:drm_mode_vrefresh+0x19d/0x1f0 drivers/gpu/drm/drm_modes.c:1303
Code: e8 58 3c e3 fc 66 83 fb 01 76 09 e8 4d 40 e3 fc 44 0f af e3 e8 44 40 e3 fc 48 69 ed e8 03 00 00 44 89 e0 31 d2 d1 e8 48 01 e8 <49> f7 f4 49 89 c4 eb 03 45 31 e4 e8 23 40 e3 fc 44 89 e0 5b 5d 41
RSP: 0018:ffffc90003bdfa00 EFLAGS: 00010206
RAX: 000000000001f400 RBX: 0000000000000400 RCX: 0000000000000000
RDX: 0000000000000000 RSI: ffffffff84a1069c RDI: 0000000000000003
RBP: 000000000001f400 R08: 0000000000000003 R09: 0000000000000001
R10: 0000000000000400 R11: ffffffff81d6ebf5 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000008
FS:  00005555561e3300(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00000000005fdeb8 CR3: 000000007b315000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 drm_mode_debug_printmodeline+0x22c/0x2f0 drivers/gpu/drm/drm_modes.c:60
 drm_mode_setcrtc+0x116b/0x1650 drivers/gpu/drm/drm_crtc.c:794
 drm_ioctl_kernel+0x281/0x4e0 drivers/gpu/drm/drm_ioctl.c:788
 drm_ioctl+0x577/0xb30 drivers/gpu/drm/drm_ioctl.c:891
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:870 [inline]
 __se_sys_ioctl fs/ioctl.c:856 [inline]
 __x64_sys_ioctl+0x197/0x210 fs/ioctl.c:856
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7fca321fac59
Code: 28 c3 e8 2a 14 00 00 66 2e 0f 1f 84 00 00 00 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fff9cb913d8 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007fca321fac59
RDX: 0000000020000180 RSI: 00000000c06864a2 RDI: 0000000000000003
RBP: 00007fca321ba4d0 R08: 00000000fffff4e6 R09: 0000000000000000
R10: 0000000000000003 R11: 0000000000000246 R12: 00007fca321ba560
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:drm_mode_vrefresh+0x19d/0x1f0 drivers/gpu/drm/drm_modes.c:1303
Code: e8 58 3c e3 fc 66 83 fb 01 76 09 e8 4d 40 e3 fc 44 0f af e3 e8 44 40 e3 fc 48 69 ed e8 03 00 00 44 89 e0 31 d2 d1 e8 48 01 e8 <49> f7 f4 49 89 c4 eb 03 45 31 e4 e8 23 40 e3 fc 44 89 e0 5b 5d 41
RSP: 0018:ffffc90003bdfa00 EFLAGS: 00010206
RAX: 000000000001f400 RBX: 0000000000000400 RCX: 0000000000000000
RDX: 0000000000000000 RSI: ffffffff84a1069c RDI: 0000000000000003
RBP: 000000000001f400 R08: 0000000000000003 R09: 0000000000000001
R10: 0000000000000400 R11: ffffffff81d6ebf5 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000008
FS:  00005555561e3300(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00000000005fdeb8 CR3: 000000007b315000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0:	e8 58 3c e3 fc       	callq  0xfce33c5d
   5:	66 83 fb 01          	cmp    $0x1,%bx
   9:	76 09                	jbe    0x14
   b:	e8 4d 40 e3 fc       	callq  0xfce3405d
  10:	44 0f af e3          	imul   %ebx,%r12d
  14:	e8 44 40 e3 fc       	callq  0xfce3405d
  19:	48 69 ed e8 03 00 00 	imul   $0x3e8,%rbp,%rbp
  20:	44 89 e0             	mov    %r12d,%eax
  23:	31 d2                	xor    %edx,%edx
  25:	d1 e8                	shr    %eax
  27:	48 01 e8             	add    %rbp,%rax
* 2a:	49 f7 f4             	div    %r12 <-- trapping instruction
  2d:	49 89 c4             	mov    %rax,%r12
  30:	eb 03                	jmp    0x35
  32:	45 31 e4             	xor    %r12d,%r12d
  35:	e8 23 40 e3 fc       	callq  0xfce3405d
  3a:	44 89 e0             	mov    %r12d,%eax
  3d:	5b                   	pop    %rbx
  3e:	5d                   	pop    %rbp
  3f:	41                   	rex.B


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
For information about bisection process see: https://goo.gl/tpsmEJ#bisection

If the bug is already fixed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

If you want to change bug's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the bug is a duplicate of another bug, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup
