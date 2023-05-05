Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 588736F8C3A
	for <lists+linux-kernel@lfdr.de>; Sat,  6 May 2023 00:07:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231445AbjEEWHo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 18:07:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229877AbjEEWHn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 18:07:43 -0400
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC17E46A8
        for <linux-kernel@vger.kernel.org>; Fri,  5 May 2023 15:07:22 -0700 (PDT)
Received: by mail-qt1-x831.google.com with SMTP id d75a77b69052e-3f0a2f8216fso1173941cf.0
        for <linux-kernel@vger.kernel.org>; Fri, 05 May 2023 15:07:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683324442; x=1685916442;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kMP5ioJGrU60cNcpfzBerjR4fTxCqVz4aeCY/oDwaZE=;
        b=jGmoQvPqGQckTNghjy0GdncOEUVLH6GD9Y7PwnYO/y/oL2awPezBRIHIBspYFbUhsB
         pgiYXBLQF86r5MoeYt9SdgzYna4Hebh3DnklIDNJXp/NunW4qUcyLzG+z8Dfhe7OV0kE
         zGldDaqpaWBYwsiZ/9UQT06AbBUTp21s0DxC/KBZ4gO++RYd/f2LpLE4iA8imKxi7kxM
         jGibBbBB9N4lw2dhzxb1O2og21oBUXIOVCqOMJRRzjmz+uAml/ETdSLdEqwOlWoSpW7I
         FSWmFxq/lz0tIAtC6zx0BKYPDoJB4TxkVzD07HmOdJbPs4g1JsWoZ2Jb0weYIcatthoB
         k57A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683324442; x=1685916442;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kMP5ioJGrU60cNcpfzBerjR4fTxCqVz4aeCY/oDwaZE=;
        b=hx9gPaxGh9kUVAdBzn3o7MvGsa3PpsFohzmzIuXnrRBhP8tHb8ZOa3/pbEYHg0NbFq
         1Qf1wHGWVmVxjAUfWXwepGyiBGyKKjEiD0meJExHhec+RVUy83RvLF00kbDs+UG15yt4
         PMorP3NOhcAzz39s0qZGUO7ft9oAKkzND+J8d1iCFTnMZ3S9OBKNSKr5e52o0h2b9pCb
         CxMd/0pPl8eTvR2LFT51mYo+e6yEbShAK5VKHCj1cv5C7vfMBj4E0pb+LgWZSGRdiGWd
         93XgTncKeMAeCY7IlXegFMhESiN6IwiYZBUbBompyHRMTOhuNGElw1slw82knTQXn7uf
         jmbA==
X-Gm-Message-State: AC+VfDyjmgubYITI7t+K+ZZ4hk0TX6lxACgqDt64JBveMY4bwBBFJeEV
        Qk4F5V+JXSjPn74z4aVP3zZYXPDnaN79UxZqVXllmQ==
X-Google-Smtp-Source: ACHHUZ7PjIDae4hy4gINUOz0ARGbTnTzdkXAFmSDDGTmUVuhiYxpR9HTnD8uv2O/8E68M0v/qs79hMq0E/pDJLH29z4=
X-Received: by 2002:ac8:5a86:0:b0:3ef:19fe:230d with SMTP id
 c6-20020ac85a86000000b003ef19fe230dmr39852qtc.17.1683324441770; Fri, 05 May
 2023 15:07:21 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000d3001a05faf979c8@google.com>
In-Reply-To: <000000000000d3001a05faf979c8@google.com>
From:   Aleksandr Nogikh <nogikh@google.com>
Date:   Sat, 6 May 2023 00:07:10 +0200
Message-ID: <CANp29Y4Q-VWEWeHmZu0f9tLLik1Va8oDF-s8hAeVkBZbX4K0gg@mail.gmail.com>
Subject: Re: [syzbot] upstream boot error: BUG: unable to handle kernel NULL
 pointer dereference in load_balance
To:     syzbot <syzbot+d4b00edc2d0c910d4bf4@syzkaller.appspotmail.com>,
        ardb@kernel.org, Dmitry Vyukov <dvyukov@google.com>
Cc:     andriy.shevchenko@linux.intel.com, linux-kernel@vger.kernel.org,
        linux@rasmusvillemoes.dk, syzkaller-bugs@googlegroups.com,
        yury.norov@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For the context: we've been seeing tons of different boot time errors
on the syzbot arm32 qemu instance.
Manual bisection points to this commit:

commit c76c6c4ecbec0deb56a4f9e932b26866024a508f
Author: Ard Biesheuvel <ardb@kernel.org>
Date:   Wed Apr 12 09:50:20 2023 +0100

    ARM: 9294/2: vfp: Fix broken softirq handling with instrumentation enab=
led


On Sat, May 6, 2023 at 12:04=E2=80=AFAM syzbot
<syzbot+d4b00edc2d0c910d4bf4@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    1a5304fecee5 Merge tag 'parisc-for-6.4-1' of git://git.ke=
r..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=3D125e1e5c28000=
0
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3D124f13edd5df0=
b0d
> dashboard link: https://syzkaller.appspot.com/bug?extid=3Dd4b00edc2d0c910=
d4bf4
> compiler:       arm-linux-gnueabi-gcc (Debian 10.2.1-6) 10.2.1 20210110, =
GNU ld (GNU Binutils for Debian) 2.35.2
> userspace arch: arm
>
> IMPORTANT: if you fix the issue, please add the following tag to the comm=
it:
> Reported-by: syzbot+d4b00edc2d0c910d4bf4@syzkaller.appspotmail.com
>
> 8<--- cut here ---
> Unable to handle kernel NULL pointer dereference at virtual address 00000=
018 when read
> [00000018] *pgd=3D80000080004003, *pmd=3D00000000
> Internal error: Oops: 207 [#1] PREEMPT SMP ARM
> Modules linked in:
> CPU: 1 PID: 0 Comm: swapper/1 Not tainted 6.3.0-syzkaller #0
> Hardware name: ARM-Versatile Express
> PC is at find_next_and_bit include/linux/find.h:93 [inline]
> PC is at should_we_balance kernel/sched/fair.c:10717 [inline]
> PC is at load_balance+0x130/0xcdc kernel/sched/fair.c:10760
> LR is at load_balance+0x78/0xcdc kernel/sched/fair.c:10743
> pc : [<8028b604>]    lr : [<8028b54c>]    psr: 80000113
> sp : df805df8  ip : df805e84  fp : df805ebc
> r10: 8309a800  r9 : df805e84  r8 : 00000001
> r7 : 8309a800  r6 : ddddb400  r5 : 830b4640  r4 : 00000001
> r3 : 00000000  r2 : ddddb400  r1 : 00000000  r0 : df805e48
> Flags: Nzcv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment none
> Control: 30c5387d  Table: 847ac040  DAC: 00000000
> Register r0 information:
> 8<--- cut here ---
> Unable to handle kernel paging request at virtual address df96bff8 when r=
ead
> [df96bff8] *pgd=3D80000080007003, *pmd=3D83093003, *pte=3D8261d0a80000000=
0
> Internal error: Oops: 207 [#2] PREEMPT SMP ARM
> Modules linked in:
> CPU: 1 PID: 0 Comm: swapper/1 Not tainted 6.3.0-syzkaller #0
> Hardware name: ARM-Versatile Express
> PC is at __find_vmap_area mm/vmalloc.c:841 [inline]
> PC is at find_vmap_area mm/vmalloc.c:1862 [inline]
> PC is at find_vm_area mm/vmalloc.c:2623 [inline]
> PC is at vmalloc_dump_obj+0x38/0xb4 mm/vmalloc.c:4221
> LR is at __raw_spin_lock include/linux/spinlock_api_smp.h:132 [inline]
> LR is at _raw_spin_lock+0x18/0x58 kernel/locking/spinlock.c:154
> pc : [<8047a200>]    lr : [<818015f4>]    psr: a0000193
> sp : df805c88  ip : df805c70  fp : df805c9c
> r10: 831f4680  r9 : 8261c9a4  r8 : 8285041c
> r7 : 60000113  r6 : 00000001  r5 : df806000  r4 : df96c000
> r3 : 00000000  r2 : 00002268  r1 : 00000000  r0 : 00000001
> Flags: NzCv  IRQs off  FIQs on  Mode SVC_32  ISA ARM  Segment none
> Control: 30c5387d  Table: 847ac040  DAC: 00000000
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
> If the bug is a duplicate of another bug, reply with:
> #syz dup: exact-subject-of-another-report
>
> If you want to undo deduplication, reply with:
> #syz undup
>
> --
> You received this message because you are subscribed to the Google Groups=
 "syzkaller-bugs" group.
> To unsubscribe from this group and stop receiving emails from it, send an=
 email to syzkaller-bugs+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgi=
d/syzkaller-bugs/000000000000d3001a05faf979c8%40google.com.
