Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9EE76B5737
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Mar 2023 02:03:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229963AbjCKBC6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 20:02:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230075AbjCKBCr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 20:02:47 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CEEF12BAC2
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 17:02:45 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id s11so27526717edy.8
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 17:02:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1678496564;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BNeo4Q+YBzB6+k/1T0KBlBv8lS3nFA3RB32TXvnq+ZE=;
        b=s2hHDqKQ+3WYWekbPQkFW5wMC1cF+w3qJjybbqezMKkv0fmC/e0ZR6YHuOHuw74Gcs
         S7RtzxPtf3P/046EWeLTi9kmZtwb0kiXgVvc2wsribi2zCpuwgAjRMdxSoFKAN6wgahg
         0obQ7sbHM9PC8kT9NTTcoxZhha4NpY6LLFzLZG+/f0JA6Fe5hJCwmiSqT0yv/fAsKKdt
         LkRmy3AhDg+N9czjTx6TubG6+rSafMIvqsVpWal4g7dwhY0XfMQWmnezeMvjnGc8tkGX
         tsWB8hkhWdJJUHKHGKgp729LUkN4+ZkOea37hvbZrkJRlQSZZ4i55PVVAPHyhk7JIVUX
         vRzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678496564;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BNeo4Q+YBzB6+k/1T0KBlBv8lS3nFA3RB32TXvnq+ZE=;
        b=GEFtZ4Wf3UeRdkGQ7GFvKQ3MLv5lK3Ro76c8OV3XL4SWXP3v2t2wECWCmpmihxMtBi
         /Ga2Hfv1yZPahvmXRj0XnRKCBNaz6It2Xev+U5gX0hUxxrgaNyovjbvSq2hq8WPPJQ7k
         50ec5stJdqiH8JnQiz93IARTCZ81/70GE2NA7nkYca9kzz1wweN6RuBB7Px0dTpkLZAq
         aP5Smh2h+dMJ7Ffo8MNszK+gzzQkUy9UjsRacyIh3wtzVNo18dcOAI2/NbdpjVOSlBx5
         L6sVvMik3H6or5xHIoyW+N8DjVO8x4iYgTAFNKDkW//Wk1Jw4W8Bty9A69qNPKZqDG3B
         A7oA==
X-Gm-Message-State: AO0yUKX4t8RjcVON1GxX0tyn6Fny89wSLHYjJ4oFlIZYBMBsDuEvl7jz
        ayFrsOxTZfhm/pfidEa3afDVht0+ey8QLgS6HlE9pUBX3IfiTG1J/XxIVQ==
X-Google-Smtp-Source: AK7set+Gap6CiHY6IOZLSsQSxwbaC38OW1hIQ1zD+5oGW3MpLx6ATMPwJiklefK1K4P1YUsUq8pdcCYAvQb1F6CcxnI=
X-Received: by 2002:a17:906:80c8:b0:8b1:81fa:b07a with SMTP id
 a8-20020a17090680c800b008b181fab07amr12806858ejx.12.1678496563589; Fri, 10
 Mar 2023 17:02:43 -0800 (PST)
MIME-Version: 1.0
References: <000000000000226a6105f6954b47@google.com>
In-Reply-To: <000000000000226a6105f6954b47@google.com>
From:   "Zach O'Keefe" <zokeefe@google.com>
Date:   Fri, 10 Mar 2023 17:02:06 -0800
Message-ID: <CAAa6QmSH-c4voB2vg=ohdeQwmGDJ8X5rUw97-99cFkVaOPD5mg@mail.gmail.com>
Subject: Re: [syzbot] [mm?] kernel BUG in hpage_collapse_scan_file
To:     syzbot <syzbot+9578faa5475acb35fa50@syzkaller.appspotmail.com>
Cc:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, syzkaller-bugs@googlegroups.com,
        Matthew Wilcox <willy@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 10, 2023 at 4:52=E2=80=AFPM syzbot
<syzbot+9578faa5475acb35fa50@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    857f1268a591 Merge tag 'objtool-core-2023-03-02' of git:/=
/..
> git tree:       upstream
> console+strace: https://syzkaller.appspot.com/x/log.txt?x=3D168e1032c8000=
0
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3Df763d89e26d3d=
4c4
> dashboard link: https://syzkaller.appspot.com/bug?extid=3D9578faa5475acb3=
5fa50
> compiler:       Debian clang version 15.0.7, GNU ld (GNU Binutils for Deb=
ian) 2.35.2
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D179e4e12c80=
000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D119cce98c8000=
0
>
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/b3b7a7e333f1/dis=
k-857f1268.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/5940be1cf171/vmlinu=
x-857f1268.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/986015398e4a/b=
zImage-857f1268.xz
>
> IMPORTANT: if you fix the issue, please add the following tag to the comm=
it:
> Reported-by: syzbot+9578faa5475acb35fa50@syzkaller.appspotmail.com
>
> ------------[ cut here ]------------
> kernel BUG at mm/khugepaged.c:1823!
> invalid opcode: 0000 [#1] PREEMPT SMP KASAN
> CPU: 1 PID: 5097 Comm: syz-executor220 Not tainted 6.2.0-syzkaller-13154-=
g857f1268a591 #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS G=
oogle 02/16/2023
> RIP: 0010:collapse_file mm/khugepaged.c:1823 [inline]
> RIP: 0010:hpage_collapse_scan_file+0x67c8/0x7580 mm/khugepaged.c:2233
> Code: 00 00 89 de e8 c9 66 a3 ff 31 ff 89 de e8 c0 66 a3 ff 45 84 f6 0f 8=
5 28 0d 00 00 e8 22 64 a3 ff e9 dc f7 ff ff e8 18 64 a3 ff <0f> 0b f3 0f 1e=
 fa e8 0d 64 a3 ff e9 93 f6 ff ff f3 0f 1e fa 4c 89
> RSP: 0018:ffffc90003dff4e0 EFLAGS: 00010093
> RAX: ffffffff81e95988 RBX: 00000000000001c1 RCX: ffff8880205b3a80
> RDX: 0000000000000000 RSI: 00000000000001c0 RDI: 00000000000001c1
> RBP: ffffc90003dff830 R08: ffffffff81e90e67 R09: fffffbfff1a433c3
> R10: 0000000000000000 R11: dffffc0000000001 R12: 0000000000000000
> R13: ffffc90003dff6c0 R14: 00000000000001c0 R15: 0000000000000000
> FS:  00007fdbae5ee700(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000=
000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007fdbae6901e0 CR3: 000000007b2dd000 CR4: 00000000003506e0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  <TASK>
>  madvise_collapse+0x721/0xf50 mm/khugepaged.c:2693
>  madvise_vma_behavior mm/madvise.c:1086 [inline]
>  madvise_walk_vmas mm/madvise.c:1260 [inline]
>  do_madvise+0x9e5/0x4680 mm/madvise.c:1439
>  __do_sys_madvise mm/madvise.c:1452 [inline]
>  __se_sys_madvise mm/madvise.c:1450 [inline]
>  __x64_sys_madvise+0xa5/0xb0 mm/madvise.c:1450
>  do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>  do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
>  entry_SYSCALL_64_after_hwframe+0x63/0xcd
> RIP: 0033:0x7fdbae65dc39
> Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 11 15 00 00 90 48 89 f8 48 89 f=
7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff=
 ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007fdbae5ee2f8 EFLAGS: 00000246 ORIG_RAX: 000000000000001c
> RAX: ffffffffffffffda RBX: 00007fdbae6e64b8 RCX: 00007fdbae65dc39
> RDX: 0000000000000019 RSI: 000000000060005f RDI: 0000000020000000
> RBP: 00007fdbae6e64b0 R08: 0000000000000001 R09: 0000000000000033
> R10: 0000000000000000 R11: 0000000000000246 R12: 00007fdbae5ee300
> R13: 0000000000000001 R14: 00007fdbae5ee400 R15: 0000000000022000
>  </TASK>
> Modules linked in:
> ---[ end trace 0000000000000000 ]---
> RIP: 0010:collapse_file mm/khugepaged.c:1823 [inline]
> RIP: 0010:hpage_collapse_scan_file+0x67c8/0x7580 mm/khugepaged.c:2233
> Code: 00 00 89 de e8 c9 66 a3 ff 31 ff 89 de e8 c0 66 a3 ff 45 84 f6 0f 8=
5 28 0d 00 00 e8 22 64 a3 ff e9 dc f7 ff ff e8 18 64 a3 ff <0f> 0b f3 0f 1e=
 fa e8 0d 64 a3 ff e9 93 f6 ff ff f3 0f 1e fa 4c 89
> RSP: 0018:ffffc90003dff4e0 EFLAGS: 00010093
> RAX: ffffffff81e95988 RBX: 00000000000001c1 RCX: ffff8880205b3a80
> RDX: 0000000000000000 RSI: 00000000000001c0 RDI: 00000000000001c1
> RBP: ffffc90003dff830 R08: ffffffff81e90e67 R09: fffffbfff1a433c3
> R10: 0000000000000000 R11: dffffc0000000001 R12: 0000000000000000
> R13: ffffc90003dff6c0 R14: 00000000000001c0 R15: 0000000000000000
> FS:  00007fdbae5ee700(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000=
000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007fdbae6901e0 CR3: 000000007b2dd000 CR4: 00000000003506e0
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
> syzbot can test patches for this issue, for details see:
> https://goo.gl/tpsmEJ#testing-patches

I had a look at this, and the issue is stemming from failed (due to
error injection here) xas_store() in collapse_file() (in this report,
specifically was picking on shmem after MADV_REMOVE punch). This puts
the xa_state into an error state (-ENOMEM) and the subsequent
xas_next() will (a) not increment xas->xa_index (which trips the
VM_BUG_ON), and (b) returns NULL (which is confusing, since AFAIU,
that's a "valid" entry for a truncated page cache entry, but also
being used to indicate error).

I think the right thing to do is to check xas_invalid() at the top of
the loop, or checking return value of all those xas_store()'s and
taking appropriate action. There is also the possibility this never
occurs in practice due to the "Ensure we have slots for all the pages
in the range" check at the top of the function, and that we are only
able to trip this from error injection.
