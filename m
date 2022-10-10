Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 722835F9A17
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 09:39:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232106AbiJJHju (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 03:39:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232140AbiJJHj0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 03:39:26 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3FC63AB2F
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 00:34:22 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id a12so12262954ljr.7
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 00:34:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=gVdhUW3grQbRAgQKnofj+xYXx/SW7Z1xu2ZKp8S4/4Y=;
        b=NbzrUKf3QIGoYVX66Fh21kKy3vRdV7OfVxDPpqs4amP0t4H+6BC4X0xv5FCFNdGHQy
         3djGyjDpXw5b0DqSiyE98GKohGVWC5fN4o23SubVSJ3a92ah2YbRG8MlT05Qin4qviaP
         wyFoFyprOf3nxNfIPWSlLL0bOeGkIYgpnx9+K+RsFsMcxDX5TgD3gkakKA0ZCsdargsa
         V1ulgKhMgeJwSLttBu+e/8KQ0yPld2Cjkq0H2voIhKmHMBQn1wvD5j5vyIAyAtzlPavE
         2i1BWT79tkq8y0E2fHr6PX0DN+9Cs+7Tzq6DoZ9cS8NFGCHKsYRdh+LJqA9LrFnnYLBp
         xMfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gVdhUW3grQbRAgQKnofj+xYXx/SW7Z1xu2ZKp8S4/4Y=;
        b=SKna/+n5VcWOV2FzfCYzX1gB21dxfJzTIaF7F7SN9w+exw1of5pgSsqYW0xj3ROReC
         CfybXrLWqyNgGAyIQPEO8XWVW3HjYkBbhDGwksNEOp+MIsIR61RLdxuHixq0lm2QrXq3
         pgrE4qYfNUuB0DOXkwb/sB1p5TMTfRexvu03zRNVIMT7SQQpR/AKqaLCyOmLNmKYO/Hz
         PLYqyYY29ONUkJH+aQRYy579wR1k/lhjhrbeX0b+zayts6iUr7ARjuRZPYTFE6fGRWej
         MXOoTcAtLPOs7pCT4Ljd7XakLB4bt5o70Zifmwk+8AMQfDrlW9sy3Pu14bMibhM5cVhp
         cDXQ==
X-Gm-Message-State: ACrzQf1nFQSPHJJ0L03t+NE+oPmIptNbKQoO6yJIdnBXnauatUh57SvO
        RVxX9sNntLApOTunedK++xhYjE/ulEX2f3RWn0HSVg==
X-Google-Smtp-Source: AMsMyM4MHPgD26glj34OKWKFFA9/1/q76B4A20yPM6TkkvwGhn9n8uLTk2fAJpqLJBZfDfyB+nNF05sPgBIG6l2HhNQ=
X-Received: by 2002:a2e:b0e6:0:b0:26e:4dd:16f5 with SMTP id
 h6-20020a2eb0e6000000b0026e04dd16f5mr6004569ljl.268.1665387260348; Mon, 10
 Oct 2022 00:34:20 -0700 (PDT)
MIME-Version: 1.0
References: <00000000000013300305eaa8f1bf@google.com>
In-Reply-To: <00000000000013300305eaa8f1bf@google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Mon, 10 Oct 2022 09:34:09 +0200
Message-ID: <CACT4Y+bv5hO6V7Bo2J8VBV8KviOyW9LyHeiJbxM5xqTuPZM6vg@mail.gmail.com>
Subject: Re: [syzbot] WARNING in kernfs_active
To:     syzbot <syzbot+590ce62b128e79cf0a35@syzkaller.appspotmail.com>,
        brauner@kernel.org, Amir Goldstein <amir73il@gmail.com>,
        Miklos Szeredi <mszeredi@redhat.com>
Cc:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, tj@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 10 Oct 2022 at 09:16, syzbot
<syzbot+590ce62b128e79cf0a35@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    4899a36f91a9 Merge tag 'powerpc-6.1-1' of git://git.kernel..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=15428b1c880000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=82d4dadec8e02fa1
> dashboard link: https://syzkaller.appspot.com/bug?extid=590ce62b128e79cf0a35
> compiler:       aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
> userspace arch: arm
>
> Unfortunately, I don't have any reproducer for this issue yet.
>
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+590ce62b128e79cf0a35@syzkaller.appspotmail.com

+exportfs maintainers (it looks like exportfs is the root cause)

> ------------[ cut here ]------------
> WARNING: CPU: 1 PID: 6191 at fs/kernfs/dir.c:36 kernfs_active+0xe8/0x120 fs/kernfs/dir.c:38
> Modules linked in:
> CPU: 1 PID: 6191 Comm: syz-executor.1 Not tainted 6.0.0-syzkaller-09413-g4899a36f91a9 #0
> Hardware name: linux,dummy-virt (DT)
> pstate: 10000005 (nzcV daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> pc : kernfs_active+0xe8/0x120 fs/kernfs/dir.c:36
> lr : lock_is_held include/linux/lockdep.h:283 [inline]
> lr : kernfs_active+0x94/0x120 fs/kernfs/dir.c:36
> sp : ffff8000182c7a00
> x29: ffff8000182c7a00 x28: 0000000000000002 x27: 0000000000000001
> x26: ffff00000ee1f6a8 x25: 1fffe00001dc3ed5 x24: 0000000000000000
> x23: ffff80000ca1fba0 x22: ffff8000089efcb0 x21: 0000000000000001
> x20: ffff0000091181d0 x19: ffff0000091181d0 x18: ffff00006a9e6b88
> x17: 0000000000000000 x16: 0000000000000000 x15: ffff00006a9e6bc4
> x14: 1ffff00003058f0e x13: 1fffe0000258c816 x12: ffff700003058f39
> x11: 1ffff00003058f38 x10: ffff700003058f38 x9 : dfff800000000000
> x8 : ffff80000e482f20 x7 : ffff0000091d8058 x6 : ffff80000e482c60
> x5 : ffff000009402ee8 x4 : 1ffff00001bd1f46 x3 : 1fffe0000258c6d1
> x2 : 0000000000000003 x1 : 00000000000000c0 x0 : 0000000000000000
> Call trace:
>  kernfs_active+0xe8/0x120 fs/kernfs/dir.c:38
>  kernfs_find_and_get_node_by_id+0x6c/0x140 fs/kernfs/dir.c:708
>  __kernfs_fh_to_dentry fs/kernfs/mount.c:102 [inline]
>  kernfs_fh_to_dentry+0x88/0x1fc fs/kernfs/mount.c:128
>  exportfs_decode_fh_raw+0x104/0x560 fs/exportfs/expfs.c:435
>  exportfs_decode_fh+0x10/0x5c fs/exportfs/expfs.c:575
>  do_handle_to_path fs/fhandle.c:152 [inline]
>  handle_to_path fs/fhandle.c:207 [inline]
>  do_handle_open+0x2a4/0x7b0 fs/fhandle.c:223
>  __do_compat_sys_open_by_handle_at fs/fhandle.c:277 [inline]
>  __se_compat_sys_open_by_handle_at fs/fhandle.c:274 [inline]
>  __arm64_compat_sys_open_by_handle_at+0x6c/0x9c fs/fhandle.c:274
>  __invoke_syscall arch/arm64/kernel/syscall.c:38 [inline]
>  invoke_syscall+0x6c/0x260 arch/arm64/kernel/syscall.c:52
>  el0_svc_common.constprop.0+0xc4/0x254 arch/arm64/kernel/syscall.c:142
>  do_el0_svc_compat+0x40/0x70 arch/arm64/kernel/syscall.c:212
>  el0_svc_compat+0x54/0x140 arch/arm64/kernel/entry-common.c:772
>  el0t_32_sync_handler+0x90/0x140 arch/arm64/kernel/entry-common.c:782
>  el0t_32_sync+0x190/0x194 arch/arm64/kernel/entry.S:586
> irq event stamp: 232
> hardirqs last  enabled at (231): [<ffff8000081edf70>] raw_spin_rq_unlock_irq kernel/sched/sched.h:1367 [inline]
> hardirqs last  enabled at (231): [<ffff8000081edf70>] finish_lock_switch kernel/sched/core.c:4943 [inline]
> hardirqs last  enabled at (231): [<ffff8000081edf70>] finish_task_switch.isra.0+0x200/0x880 kernel/sched/core.c:5061
> hardirqs last disabled at (232): [<ffff80000c888bb4>] el1_dbg+0x24/0x80 arch/arm64/kernel/entry-common.c:404
> softirqs last  enabled at (228): [<ffff800008010938>] _stext+0x938/0xf58
> softirqs last disabled at (207): [<ffff800008019380>] ____do_softirq+0x10/0x20 arch/arm64/kernel/irq.c:79
> ---[ end trace 0000000000000000 ]---
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
> --
> You received this message because you are subscribed to the Google Groups "syzkaller-bugs" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to syzkaller-bugs+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/syzkaller-bugs/00000000000013300305eaa8f1bf%40google.com.
