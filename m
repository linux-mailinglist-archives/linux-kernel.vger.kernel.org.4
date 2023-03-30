Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D9BC6D0092
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 12:03:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231147AbjC3KDu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 06:03:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231164AbjC3KDm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 06:03:42 -0400
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 221118A54
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 03:03:32 -0700 (PDT)
Received: by mail-qt1-x82f.google.com with SMTP id d75a77b69052e-3e392e10cc4so480001cf.0
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 03:03:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680170611;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nzB6uhmWn7pcdvMNIhOZORQN4ZImdgHhEgL7Nyl6dNU=;
        b=WbyzV0fkTWS4iG/bqZoe9wX9ealNshlPL9Vb4PXKdG6ADwoBsWJx9o/2gRylmnHMK1
         VgClaJjj4fyFWuHsv8b2u1Sl8vohPpjUIiNKVY1sm8pw2M3W8SPYzeSB9zB1t9WzwG3E
         cIr08dbocoFumDuCwk2jM1Hxst3+QlGPXtio2aphbMemX2NchNOgW29IyqpXMPsYNvdj
         0SrHpjHFMjNQwo7M/0Q3kt4YNJVNcYg0HHatWv4tSlP38m8POznnx3jsZTPHIaSGZmLg
         87GwDSnOMtev/ayFKhd2JYkf204C+mLMyygOGhHvVFqEbKu2MXylNhJ2YV2/1GNNQAhB
         cctQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680170611;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nzB6uhmWn7pcdvMNIhOZORQN4ZImdgHhEgL7Nyl6dNU=;
        b=G7O3Z7QPHhuEMfdCiTC4aQYpJOvjUEuPEEi0ciFKJij58zLqlGaFgjSvKS/h4C1pAh
         b2wawh8RSuCRFDcUhGmp0Fs2PWO2Jy/lR2FG04sNJ2xM4fxr75BTuYUPZiF0DCbhgZvg
         948q3ushBqlzLpp+A06Hc3mqtOpsK6w/fl7XExyrEEVDDUg1uvZ0rVpfZfbP8RVMYHE5
         XdSr1BcPDOgX9WueqcW7tiCIGHGpc+oeqgNosUuBjrNZ7jkpdDH0D9b1twPAgZdf6xHe
         aB+W8o9L/kNfioJpoUpcTpiDpVqk558j0iuqynXbmfFsqOpKbsMRO7IPY/Lnr+CGo7Vh
         girQ==
X-Gm-Message-State: AAQBX9eYdFIs6h/ibuElY9bsJxgaFLRbdliuUeoqf4NxTCwNjSh0ZOa/
        +e0HMj/gV/37zwQ1kV30llvrVhmz0av97fzpu2Aapg==
X-Google-Smtp-Source: AKy350ZvyBZ1hNMiHiwttM9WrbLve8bSqMrZ1r+WbwZldQY1aL7Agm/q5vBCYlPGD/a65hhrWvPmedKCoseb20aeam8=
X-Received: by 2002:ac8:5c47:0:b0:3b3:20d8:a84 with SMTP id
 j7-20020ac85c47000000b003b320d80a84mr274148qtj.2.1680170610982; Thu, 30 Mar
 2023 03:03:30 -0700 (PDT)
MIME-Version: 1.0
References: <00000000000094982205f0874589@google.com>
In-Reply-To: <00000000000094982205f0874589@google.com>
From:   Aleksandr Nogikh <nogikh@google.com>
Date:   Thu, 30 Mar 2023 12:03:18 +0200
Message-ID: <CANp29Y5Tm=afYVjhruewwFVzzY=Bq8Xk_2xVxzsCLkBks4ct4g@mail.gmail.com>
Subject: Re: [syzbot] [jfs?] [fat?] general protection fault in txEnd
To:     syzbot <syzbot+1d096d31de6a0491b55e@syzkaller.appspotmail.com>
Cc:     jfs-discussion@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        shaggy@kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-15.7 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

#syz set subsystems: jfs

On Sat, Dec 24, 2022 at 12:37=E2=80=AFAM syzbot
<syzbot+1d096d31de6a0491b55e@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    aeba12b26c79 Merge tag 'nfsd-6.2-1' of git://git.kernel.o=
r..
> git tree:       upstream
> console+strace: https://syzkaller.appspot.com/x/log.txt?x=3D17485bf048000=
0
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3D4d348fc1e0f48=
3c9
> dashboard link: https://syzkaller.appspot.com/bug?extid=3D1d096d31de6a049=
1b55e
> compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da=
-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D117aef10480=
000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D1520609048000=
0
>
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/661fe33f851b/dis=
k-aeba12b2.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/c938bdcf3ad0/vmlinu=
x-aeba12b2.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/e7f738de30b7/b=
zImage-aeba12b2.xz
> mounted in repro: https://storage.googleapis.com/syzbot-assets/9ee3cffc61=
51/mount_0.gz
>
> IMPORTANT: if you fix the issue, please add the following tag to the comm=
it:
> Reported-by: syzbot+1d096d31de6a0491b55e@syzkaller.appspotmail.com
>
> ERROR: (device loop0): remounting filesystem as read-only
> general protection fault, probably for non-canonical address 0xdffffc0000=
000029: 0000 [#1] PREEMPT SMP KASAN
> KASAN: null-ptr-deref in range [0x0000000000000148-0x000000000000014f]
> CPU: 1 PID: 5116 Comm: syz-executor317 Not tainted 6.1.0-syzkaller-13781-=
gaeba12b26c79 #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS G=
oogle 10/26/2022
> RIP: 0010:txEnd+0x1dc/0x560 fs/jfs/jfs_txnmgr.c:534
> Code: 00 84 c0 0f 85 d8 02 00 00 66 41 89 1e 41 0f b7 c5 89 05 e7 5c 0b 0=
f 4c 8b 74 24 08 49 8d 9e 4c 01 00 00 48 89 d8 48 c1 e8 03 <42> 8a 04 20 84=
 c0 0f 85 c8 02 00 00 8b 2b 8d 75 ff 89 33 31 ff e8
> RSP: 0018:ffffc90003d5f9f0 EFLAGS: 00010203
> RAX: 0000000000000029 RBX: 000000000000014c RCX: 0000000000000000
> RDX: ffff88807eb93a80 RSI: 0000000000000000 RDI: 0000000000000000
> RBP: 1ffff920004c6227 R08: ffffffff830c3c2f R09: fffffbfff20fb43a
> R10: fffffbfff20fb43a R11: 1ffffffff20fb439 R12: dffffc0000000000
> R13: 0000000000000001 R14: 0000000000000000 R15: 0000000000000110
> FS:  00007f2738801700(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000=
000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007f273fc23000 CR3: 000000007e7a4000 CR4: 00000000003506e0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  <TASK>
>  add_missing_indices fs/jfs/jfs_dtree.c:2658 [inline]
>  jfs_readdir+0x277c/0x44b0 fs/jfs/jfs_dtree.c:3004
>  iterate_dir+0x257/0x5f0
>  __do_sys_getdents fs/readdir.c:286 [inline]
>  __se_sys_getdents+0x1db/0x4d0 fs/readdir.c:271
>  do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>  do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
>  entry_SYSCALL_64_after_hwframe+0x63/0xcd
> RIP: 0033:0x7f273fc76709
> Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 71 15 00 00 90 48 89 f8 48 89 f=
7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff=
 ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007f27388012f8 EFLAGS: 00000246 ORIG_RAX: 000000000000004e
> RAX: ffffffffffffffda RBX: 00007f273fd017b0 RCX: 00007f273fc76709
> RDX: 000000000000004c RSI: 0000000020000100 RDI: 0000000000000004
> RBP: 0030656c69662f2e R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 61746f7571727375
> R13: 726765746e696f6e R14: 7261637369646f6e R15: 00007f273fd017b8
>  </TASK>
> Modules linked in:
> ---[ end trace 0000000000000000 ]---
> RIP: 0010:txEnd+0x1dc/0x560 fs/jfs/jfs_txnmgr.c:534
> Code: 00 84 c0 0f 85 d8 02 00 00 66 41 89 1e 41 0f b7 c5 89 05 e7 5c 0b 0=
f 4c 8b 74 24 08 49 8d 9e 4c 01 00 00 48 89 d8 48 c1 e8 03 <42> 8a 04 20 84=
 c0 0f 85 c8 02 00 00 8b 2b 8d 75 ff 89 33 31 ff e8
> RSP: 0018:ffffc90003d5f9f0 EFLAGS: 00010203
> RAX: 0000000000000029 RBX: 000000000000014c RCX: 0000000000000000
> RDX: ffff88807eb93a80 RSI: 0000000000000000 RDI: 0000000000000000
> RBP: 1ffff920004c6227 R08: ffffffff830c3c2f R09: fffffbfff20fb43a
> R10: fffffbfff20fb43a R11: 1ffffffff20fb439 R12: dffffc0000000000
> R13: 0000000000000001 R14: 0000000000000000 R15: 0000000000000110
> FS:  00007f2738801700(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000=
000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007f273fc23000 CR3: 000000007e7a4000 CR4: 00000000003506e0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> ----------------
> Code disassembly (best guess):
>    0:   00 84 c0 0f 85 d8 02    add    %al,0x2d8850f(%rax,%rax,8)
>    7:   00 00                   add    %al,(%rax)
>    9:   66 41 89 1e             mov    %bx,(%r14)
>    d:   41 0f b7 c5             movzwl %r13w,%eax
>   11:   89 05 e7 5c 0b 0f       mov    %eax,0xf0b5ce7(%rip)        # 0xf0=
b5cfe
>   17:   4c 8b 74 24 08          mov    0x8(%rsp),%r14
>   1c:   49 8d 9e 4c 01 00 00    lea    0x14c(%r14),%rbx
>   23:   48 89 d8                mov    %rbx,%rax
>   26:   48 c1 e8 03             shr    $0x3,%rax
> * 2a:   42 8a 04 20             mov    (%rax,%r12,1),%al <-- trapping ins=
truction
>   2e:   84 c0                   test   %al,%al
>   30:   0f 85 c8 02 00 00       jne    0x2fe
>   36:   8b 2b                   mov    (%rbx),%ebp
>   38:   8d 75 ff                lea    -0x1(%rbp),%esi
>   3b:   89 33                   mov    %esi,(%rbx)
>   3d:   31 ff                   xor    %edi,%edi
>   3f:   e8                      .byte 0xe8
>
>
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
>
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> syzbot can test patches for this issue, for details see:
> https://goo.gl/tpsmEJ#testing-patches
>
> --
> You received this message because you are subscribed to the Google Groups=
 "syzkaller-bugs" group.
> To unsubscribe from this group and stop receiving emails from it, send an=
 email to syzkaller-bugs+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgi=
d/syzkaller-bugs/00000000000094982205f0874589%40google.com.
