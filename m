Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98B9D6F0D85
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 22:57:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230114AbjD0U5x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 16:57:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbjD0U5v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 16:57:51 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E93B1FFB
        for <linux-kernel@vger.kernel.org>; Thu, 27 Apr 2023 13:57:49 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id 41be03b00d2f7-51b0f9d7d70so8887147a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 27 Apr 2023 13:57:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682629069; x=1685221069;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FLwuP92GDfOvPMRtZaBWMYpp0kL/TwjkG4jKKsiFN2s=;
        b=drl4ZY7jDmLnog0HDTCuWMijhLCuhH06IYJxu+S/odKOccKbdgrB4n1lMu3/JeixKB
         s8goBo2rWSvaIlAuZMspNGyoOG9oMaALClUKCJchnAseKI2leiClT5t+PQbrEdiYR4rc
         cm1jVsuPr9CnW8ALy9QXqwpNqUPLoQW69k2e5vPqmTJ3xlOA/k92/nAvUdrvmiW+exiR
         ly/g5ypbuXQuCrYqrA38/3LEUjhH3sFhJ6lDWw7xbx+pj+GEdK2wwxnjmmIXvY2Su2V6
         lfYMzYcATmdA0TT7WrZOWXwkCEJoxe1rjR5/57bCvWPQlSEwiobGRWF4OaYIZ3ZYzfJv
         Ok2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682629069; x=1685221069;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FLwuP92GDfOvPMRtZaBWMYpp0kL/TwjkG4jKKsiFN2s=;
        b=Y9MeXgtUB7b0N6t9+WGoJ06UmlwbtRY9o+dUrtP5PWYuiPVlfL/1cneJZsvG1rQBbg
         NiJR5hlfueFOmmwtzN9iiXOlDjWv4xHwiKVc+PLMdqKM02vxHfelCy2Xtg9RaSAX8INx
         0UchSptbPXds4EA6LUjFwa1HJGU3+rIoEAPpLa1lbuZntoDG+v8k2vq0eleZZ4jancPP
         sT4iKr67NWkY9vH1bWE7FWLsrnY4w9Ed5LVt6PIzBO5jv4WVt9Hh1CNGDHCmbL3RfGcx
         t2rdSJdyE09b/GkEmZZsKR+Y4e7khOb3fI+GQ4GHeQSiH0O2OhW0ytmdfZXZhyMNulAR
         Ar0w==
X-Gm-Message-State: AC+VfDxTC2MQdjBEcYyXN8C2M1M5TUKbIfWkoWZrj3InpsGsPSvDcMeU
        qDtMznZSr82FEZjtgy6j7cwtWY4h/g3cO/GbSQ6zLnOPWyM=
X-Google-Smtp-Source: ACHHUZ6qjE0jNq9wyLzgnnXjTsWc9T6sewCPF11tTkGhKVcwqjx+7gcY3UFq7Vs2TebYMQk7zfOHg/0cnzAXFvzkMA4=
X-Received: by 2002:a17:90a:988:b0:23d:376a:c2bc with SMTP id
 8-20020a17090a098800b0023d376ac2bcmr3085174pjo.5.1682629068754; Thu, 27 Apr
 2023 13:57:48 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000e6cd7405fa52e6ad@google.com>
In-Reply-To: <000000000000e6cd7405fa52e6ad@google.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Thu, 27 Apr 2023 13:57:37 -0700
Message-ID: <CAHbLzkp74vFh1RW9dj68wYh79Bo4db16uCWvv44Avy1LVzYCbQ@mail.gmail.com>
Subject: Re: [syzbot] [mm?] kernel BUG in folio_unlock
To:     syzbot <syzbot+1b2ce6d050776f4403cf@syzkaller.appspotmail.com>,
        Hugh Dickins <hughd@google.com>
Cc:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 27, 2023 at 8:20=E2=80=AFAM syzbot
<syzbot+1b2ce6d050776f4403cf@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    d3e1ee0e67e7 Add linux-next specific files for 20230421
> git tree:       linux-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=3D110654a428000=
0
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3D53c789efbcc06=
cf6
> dashboard link: https://syzkaller.appspot.com/bug?extid=3D1b2ce6d050776f4=
403cf
> compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binuti=
ls for Debian) 2.35.2
>
> Unfortunately, I don't have any reproducer for this issue yet.
>
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/c558a9e1fe6a/dis=
k-d3e1ee0e.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/2ec100a34c4c/vmlinu=
x-d3e1ee0e.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/1afcd9936dc1/b=
zImage-d3e1ee0e.xz
>
> IMPORTANT: if you fix the issue, please add the following tag to the comm=
it:
> Reported-by: syzbot+1b2ce6d050776f4403cf@syzkaller.appspotmail.com

It looks like next-20230421 doesn't have Hugh's fix:

https://lore.kernel.org/linux-mm/b6c881-c352-bb91-85a8-febeb09dfd71@google.=
com/

Although I'm not sure whether this is the same problem or not, it
doesn't hurt to retest with this fix. next-20230427 already included
this fix.

>
>  faultin_page mm/gup.c:925 [inline]
>  __get_user_pages+0x614/0x10e0 mm/gup.c:1147
>  populate_vma_page_range+0x2df/0x420 mm/gup.c:1543
>  __mm_populate+0x105/0x3b0 mm/gup.c:1652
>  mm_populate include/linux/mm.h:3191 [inline]
>  vm_mmap_pgoff+0x2c6/0x3b0 mm/util.c:548
>  ksys_mmap_pgoff+0x7d/0x5a0 mm/mmap.c:1440
>  do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>  do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
>  entry_SYSCALL_64_after_hwframe+0x63/0xcd
> ------------[ cut here ]------------
> kernel BUG at mm/filemap.c:1529!
> invalid opcode: 0000 [#1] PREEMPT SMP KASAN
> CPU: 0 PID: 7377 Comm: syz-executor.1 Not tainted 6.3.0-rc7-next-20230421=
-syzkaller #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS G=
oogle 04/14/2023
> RIP: 0010:folio_unlock+0xb2/0xd0 mm/filemap.c:1529
> Code: e8 63 4b d4 ff 48 89 ef 31 f6 e8 f9 fc ff ff 5b 5d e9 52 4b d4 ff e=
8 4d 4b d4 ff 48 c7 c6 c0 a7 56 8a 48 89 ef e8 ee e0 0f 00 <0f> 0b 48 89 df=
 e8 74 2a 27 00 e9 7c ff ff ff 66 66 2e 0f 1f 84 00
> RSP: 0018:ffffc9001531f7a8 EFLAGS: 00010293
> RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
> RDX: ffff88803c570000 RSI: ffffffff81af9a12 RDI: 0000000000000000
> RBP: ffffea0002128000 R08: 0000000000000001 R09: ffffffff8e796e17
> R10: fffffbfff1cf2dc2 R11: 0000000000000000 R12: ffffc9001531f8d8
> R13: ffffc9001531f8d0 R14: ffffc9001531f8d8 R15: 000000000000001e
> FS:  00007fe54afbc700(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000=
000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007eff0bb831b8 CR3: 0000000023ba2000 CR4: 00000000003506f0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  <TASK>
>  collapse_file+0x1f6d/0x5db0 mm/khugepaged.c:2316
>  hpage_collapse_scan_file+0xbef/0x1550 mm/khugepaged.c:2415
>  madvise_collapse+0x53b/0xca0 mm/khugepaged.c:2877
>  madvise_vma_behavior+0x649/0x20a0 mm/madvise.c:1074
>  madvise_walk_vmas+0x1c7/0x2b0 mm/madvise.c:1248
>  do_madvise.part.0+0x287/0x5e0 mm/madvise.c:1428
>  do_madvise mm/madvise.c:1441 [inline]
>  __do_sys_madvise mm/madvise.c:1441 [inline]
>  __se_sys_madvise mm/madvise.c:1439 [inline]
>  __x64_sys_madvise+0x117/0x150 mm/madvise.c:1439
>  do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>  do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
>  entry_SYSCALL_64_after_hwframe+0x63/0xcd
> RIP: 0033:0x7fe54c48c169
> Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 f1 19 00 00 90 48 89 f8 48 89 f=
7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff=
 ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007fe54afbc168 EFLAGS: 00000246 ORIG_RAX: 000000000000001c
> RAX: ffffffffffffffda RBX: 00007fe54c5ac120 RCX: 00007fe54c48c169
> RDX: 0000000000000019 RSI: 000000000060005f RDI: 0000000020000000
> RBP: 00007fe54c4e7ca1 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
> R13: 00007fff8070a1ff R14: 00007fe54afbc300 R15: 0000000000022000
>  </TASK>
> Modules linked in:
> ---[ end trace 0000000000000000 ]---
> RIP: 0010:folio_unlock+0xb2/0xd0 mm/filemap.c:1529
> Code: e8 63 4b d4 ff 48 89 ef 31 f6 e8 f9 fc ff ff 5b 5d e9 52 4b d4 ff e=
8 4d 4b d4 ff 48 c7 c6 c0 a7 56 8a 48 89 ef e8 ee e0 0f 00 <0f> 0b 48 89 df=
 e8 74 2a 27 00 e9 7c ff ff ff 66 66 2e 0f 1f 84 00
> RSP: 0018:ffffc9001531f7a8 EFLAGS: 00010293
> RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
> RDX: ffff88803c570000 RSI: ffffffff81af9a12 RDI: 0000000000000000
> RBP: ffffea0002128000 R08: 0000000000000001 R09: ffffffff8e796e17
> R10: fffffbfff1cf2dc2 R11: 0000000000000000 R12: ffffc9001531f8d8
> R13: ffffc9001531f8d0 R14: ffffc9001531f8d8 R15: 000000000000001e
> FS:  00007fe54afbc700(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000=
000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007fd2aa586058 CR3: 0000000023ba2000 CR4: 00000000003506e0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
>
>
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
>
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
>
> If the bug is already fixed, let syzbot know by replying with:
> #syz fix: exact-commit-title
>
> If you want to change bug's subsystems, reply with:
> #syz set subsystems: new-subsystem
> (See the list of subsystem names on the web dashboard)
>
> If you want to unassign a label, reply with:
> #syz unset some-label
>
> If the bug is a duplicate of another bug, reply with:
> #syz dup: exact-subject-of-another-report
>
> If you want to undo deduplication, reply with:
> #syz undup
>
