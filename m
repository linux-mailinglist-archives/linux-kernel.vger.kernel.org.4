Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5315E5FA2CE
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 19:43:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229669AbiJJRm7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 13:42:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbiJJRm5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 13:42:57 -0400
Received: from mail-vs1-xe2d.google.com (mail-vs1-xe2d.google.com [IPv6:2607:f8b0:4864:20::e2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35CA4754B9
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 10:42:56 -0700 (PDT)
Received: by mail-vs1-xe2d.google.com with SMTP id a2so6263518vsc.13
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 10:42:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=LuTDya1SYR+5x+G7NXr1W9ilZiBDc/shaVl+IykeTmE=;
        b=S2EThMYI7qHRybwkwrbxgP49ymXRkdbUP1TgcjlCnB3kPqbUYbAqw+stT0u0pjX4/p
         y6VPWWm4KHvwYm8uL/8okXcsJR4xRJOEIzKsS+nELMreRpuvcz6lLgx626lK/zuLHNy8
         C5+C5OXuc2uUmtaarYzCIUcZUCtkd1a14jmdcLTVDH+3HZwWKzsS4O3Iee4UYp9yQ6ea
         xo5lT4IEvM8sGWIzIzgakZ3owT43SHS/aN93SoQjojPdsB4/SmYhgnAQCOgcwFseoPSN
         5yPdVPQsjR1A+HKqlfImMjg8j5Ml5lZBk/fTyELOU4ILBZGRTSNe6IMXzUrgLFTWs3BN
         2gPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LuTDya1SYR+5x+G7NXr1W9ilZiBDc/shaVl+IykeTmE=;
        b=4zUxThaIWhRNt7LLS+dcbMZhLi3MkZNfYMsCxP69rtHkPF8V3HIcNWUmzPoUbGoz0B
         DfS+emPq3IR/EN4+VXboi6gF8UQcZiZqnZyvV8MwyJBTfAM9RIefrdMNHerfE0RQThZT
         Oo0eWWjGu7sZa7EtivmUoGcg6CCYJMFEZ1zQomxKwoKvyOQeQQWMSpjbmvfz77s3v/fK
         aHignBg31Yr2Zac042VYSJCG5y8KZPHgVBTZR3If4AfFhoohbgZOxkeYnOJIErQ8l4Al
         CtvRk+Lm9u1Ck8QcOprV+wUCm0Rv+1XLeIFN344lkCWFAf6obqGvfuFt5zqAMI365E6h
         g5dg==
X-Gm-Message-State: ACrzQf26Rz/CG/3/kDItG45EYCleXkahbX0a0KqL21In0zZyZRbwD0Qg
        j0EZKSeuhLyVcgXYnzVqBifE2NbpyoTBN9gv6So=
X-Google-Smtp-Source: AMsMyM6IrCPGmdiFas2mapwBKld/jJ11KmZPzrlBiOvJ8knSxiwBEr/aaoSASGRLfH1NRWfiBp1QToO+Wx2C+/JScnw=
X-Received: by 2002:a67:a248:0:b0:3a5:38a0:b610 with SMTP id
 t8-20020a67a248000000b003a538a0b610mr9105331vsh.2.1665423775266; Mon, 10 Oct
 2022 10:42:55 -0700 (PDT)
MIME-Version: 1.0
References: <00000000000013300305eaa8f1bf@google.com> <CACT4Y+bv5hO6V7Bo2J8VBV8KviOyW9LyHeiJbxM5xqTuPZM6vg@mail.gmail.com>
In-Reply-To: <CACT4Y+bv5hO6V7Bo2J8VBV8KviOyW9LyHeiJbxM5xqTuPZM6vg@mail.gmail.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Mon, 10 Oct 2022 20:42:43 +0300
Message-ID: <CAOQ4uxg+tM+heZ8f739SmMz-fBDDgc68hER+-iyBU+2q73VZWQ@mail.gmail.com>
Subject: Re: [syzbot] WARNING in kernfs_active
To:     Dmitry Vyukov <dvyukov@google.com>, tj@kernel.org
Cc:     syzbot <syzbot+590ce62b128e79cf0a35@syzkaller.appspotmail.com>,
        brauner@kernel.org, Miklos Szeredi <mszeredi@redhat.com>,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 10, 2022 at 10:34 AM Dmitry Vyukov <dvyukov@google.com> wrote:
>
> On Mon, 10 Oct 2022 at 09:16, syzbot
> <syzbot+590ce62b128e79cf0a35@syzkaller.appspotmail.com> wrote:
> >
> > Hello,
> >
> > syzbot found the following issue on:
> >
> > HEAD commit:    4899a36f91a9 Merge tag 'powerpc-6.1-1' of git://git.kernel..
> > git tree:       upstream
> > console output: https://syzkaller.appspot.com/x/log.txt?x=15428b1c880000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=82d4dadec8e02fa1
> > dashboard link: https://syzkaller.appspot.com/bug?extid=590ce62b128e79cf0a35
> > compiler:       aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
> > userspace arch: arm
> >
> > Unfortunately, I don't have any reproducer for this issue yet.
> >
> > IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > Reported-by: syzbot+590ce62b128e79cf0a35@syzkaller.appspotmail.com
>
> +exportfs maintainers (it looks like exportfs is the root cause)

What makes you say that?
And who are the "exportfs maintainers"?
As far as I can see the only MAINTAINERS filter to match exportfs is
fs/* (i.e. vfs)

The regressing commit is most likely:

c25491747b21 kernfs: Add KERNFS_REMOVING flags

Because before it, this specific stack trace was not possible.
kernfs_active() was not called from kernfs_find_and_get_node_by_id().

Thanks,
Amir.

>
> > ------------[ cut here ]------------
> > WARNING: CPU: 1 PID: 6191 at fs/kernfs/dir.c:36 kernfs_active+0xe8/0x120 fs/kernfs/dir.c:38
> > Modules linked in:
> > CPU: 1 PID: 6191 Comm: syz-executor.1 Not tainted 6.0.0-syzkaller-09413-g4899a36f91a9 #0
> > Hardware name: linux,dummy-virt (DT)
> > pstate: 10000005 (nzcV daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> > pc : kernfs_active+0xe8/0x120 fs/kernfs/dir.c:36
> > lr : lock_is_held include/linux/lockdep.h:283 [inline]
> > lr : kernfs_active+0x94/0x120 fs/kernfs/dir.c:36
> > sp : ffff8000182c7a00
> > x29: ffff8000182c7a00 x28: 0000000000000002 x27: 0000000000000001
> > x26: ffff00000ee1f6a8 x25: 1fffe00001dc3ed5 x24: 0000000000000000
> > x23: ffff80000ca1fba0 x22: ffff8000089efcb0 x21: 0000000000000001
> > x20: ffff0000091181d0 x19: ffff0000091181d0 x18: ffff00006a9e6b88
> > x17: 0000000000000000 x16: 0000000000000000 x15: ffff00006a9e6bc4
> > x14: 1ffff00003058f0e x13: 1fffe0000258c816 x12: ffff700003058f39
> > x11: 1ffff00003058f38 x10: ffff700003058f38 x9 : dfff800000000000
> > x8 : ffff80000e482f20 x7 : ffff0000091d8058 x6 : ffff80000e482c60
> > x5 : ffff000009402ee8 x4 : 1ffff00001bd1f46 x3 : 1fffe0000258c6d1
> > x2 : 0000000000000003 x1 : 00000000000000c0 x0 : 0000000000000000
> > Call trace:
> >  kernfs_active+0xe8/0x120 fs/kernfs/dir.c:38
> >  kernfs_find_and_get_node_by_id+0x6c/0x140 fs/kernfs/dir.c:708
> >  __kernfs_fh_to_dentry fs/kernfs/mount.c:102 [inline]
> >  kernfs_fh_to_dentry+0x88/0x1fc fs/kernfs/mount.c:128
> >  exportfs_decode_fh_raw+0x104/0x560 fs/exportfs/expfs.c:435
> >  exportfs_decode_fh+0x10/0x5c fs/exportfs/expfs.c:575
> >  do_handle_to_path fs/fhandle.c:152 [inline]
> >  handle_to_path fs/fhandle.c:207 [inline]
> >  do_handle_open+0x2a4/0x7b0 fs/fhandle.c:223
> >  __do_compat_sys_open_by_handle_at fs/fhandle.c:277 [inline]
> >  __se_compat_sys_open_by_handle_at fs/fhandle.c:274 [inline]
> >  __arm64_compat_sys_open_by_handle_at+0x6c/0x9c fs/fhandle.c:274
> >  __invoke_syscall arch/arm64/kernel/syscall.c:38 [inline]
> >  invoke_syscall+0x6c/0x260 arch/arm64/kernel/syscall.c:52
> >  el0_svc_common.constprop.0+0xc4/0x254 arch/arm64/kernel/syscall.c:142
> >  do_el0_svc_compat+0x40/0x70 arch/arm64/kernel/syscall.c:212
> >  el0_svc_compat+0x54/0x140 arch/arm64/kernel/entry-common.c:772
> >  el0t_32_sync_handler+0x90/0x140 arch/arm64/kernel/entry-common.c:782
> >  el0t_32_sync+0x190/0x194 arch/arm64/kernel/entry.S:586
> > irq event stamp: 232
> > hardirqs last  enabled at (231): [<ffff8000081edf70>] raw_spin_rq_unlock_irq kernel/sched/sched.h:1367 [inline]
> > hardirqs last  enabled at (231): [<ffff8000081edf70>] finish_lock_switch kernel/sched/core.c:4943 [inline]
> > hardirqs last  enabled at (231): [<ffff8000081edf70>] finish_task_switch.isra.0+0x200/0x880 kernel/sched/core.c:5061
> > hardirqs last disabled at (232): [<ffff80000c888bb4>] el1_dbg+0x24/0x80 arch/arm64/kernel/entry-common.c:404
> > softirqs last  enabled at (228): [<ffff800008010938>] _stext+0x938/0xf58
> > softirqs last disabled at (207): [<ffff800008019380>] ____do_softirq+0x10/0x20 arch/arm64/kernel/irq.c:79
> > ---[ end trace 0000000000000000 ]---
> >
> >
> > ---
> > This report is generated by a bot. It may contain errors.
> > See https://goo.gl/tpsmEJ for more information about syzbot.
> > syzbot engineers can be reached at syzkaller@googlegroups.com.
> >
> > syzbot will keep track of this issue. See:
> > https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> >
> > --
> > You received this message because you are subscribed to the Google Groups "syzkaller-bugs" group.
> > To unsubscribe from this group and stop receiving emails from it, send an email to syzkaller-bugs+unsubscribe@googlegroups.com.
> > To view this discussion on the web visit https://groups.google.com/d/msgid/syzkaller-bugs/00000000000013300305eaa8f1bf%40google.com.
