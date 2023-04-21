Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E08276EA5BC
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 10:22:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231573AbjDUIWC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Apr 2023 04:22:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231559AbjDUIWA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Apr 2023 04:22:00 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F522A260
        for <linux-kernel@vger.kernel.org>; Fri, 21 Apr 2023 01:21:46 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id 2adb3069b0e04-4eb146d466aso6242e87.1
        for <linux-kernel@vger.kernel.org>; Fri, 21 Apr 2023 01:21:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1682065305; x=1684657305;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=eCkGX3P+lTDwHs0E52ucuAUtvZAIvG656M6Wgqb+vyA=;
        b=1VXCQftsS+hsOxo+MioK2RVSoVQ18BbB0+pEubSzgh2FMzZG5PAPIu3TXSw4jFHaNZ
         gCNMtJ+K/0tDnP+/y9KsiS7G69Hd4Slr4zwesU/m3WCZDYzQkjvUR3HRemf/KHzSp9Oa
         1zc8X2T3mTKrXNAc6Tp2OrE+IufOX9TiuA7J32o8gMtvXZUpGQvehy0CqccRnlngaHCU
         P7SMSWQBn36daYNefcY8Aa7RpDpET2sHlDOjpBMRKAJWOpPCy1Nm68KfB3H0nAgMDkVq
         CnFXL90I9ZOHMiYlaQE1XARBgqiFtJ//C7eQTE8HsJehdnltrxsnW4f7mVJNQFEr30AT
         OTYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682065305; x=1684657305;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eCkGX3P+lTDwHs0E52ucuAUtvZAIvG656M6Wgqb+vyA=;
        b=Sxq4wPBvOrJNUp+YimQKMKkyFq+EgsdKA+bzA5eeT95bqhNDvI80Dqe4RveXZv93oA
         JPUqAySheAz7MvXdV4jxu+PjOcEm5TkkzeGQS/Oy+N3ddtHdmSnhOcX5/EJKUD2BcHJR
         NgMdRBIAJNsvsVsrAFEfxVoLTlfIXd686e5iooy46snaiMRGcR1NBNYWOxcmbuzDES+j
         qcvNcuAJzUm6JSG2QOd2ZeC0rHnoQmxNdOaaKylF4ids564Eoo8dNFkKJB+rCwwp7Sl9
         dpsjlMVMZOKHJZ+WsBA7andiKbJrVmDzdxqV5jR/UY5QnOuP/a8yRgJkmyLeOxa2nsED
         xsYg==
X-Gm-Message-State: AAQBX9eCSTDU7E8upWKglmA962G6sWy7Z/l0AK6krPZxlKM6rtVKzUc0
        IkHwl5ZhurCBz36tcUrACXD8PzTP13AwKG4a2C5kBg==
X-Google-Smtp-Source: AKy350Zh+mXNlcLtBciKC1QRwaJP9OKWmgOiycrDG/casDPv/zNROa0fGePkN78PJbcV9cPKQdEOqiqMjZ7j7S/uDmA=
X-Received: by 2002:a05:6512:b08:b0:4d1:b201:e43 with SMTP id
 w8-20020a0565120b0800b004d1b2010e43mr112120lfu.2.1682065304516; Fri, 21 Apr
 2023 01:21:44 -0700 (PDT)
MIME-Version: 1.0
References: <00000000000013aaac05f9d44e7a@google.com>
In-Reply-To: <00000000000013aaac05f9d44e7a@google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Fri, 21 Apr 2023 10:21:31 +0200
Message-ID: <CACT4Y+bj7jCOjGV5jCUPzN5zjgdHxRn9vkwQEBuPWVzMbMCnXw@mail.gmail.com>
Subject: Re: [syzbot] [kernel?] KCSAN: data-race in __fput / __tty_hangup (4)
To:     syzbot <syzbot+b7c3ba8cdc2f6cf83c21@syzkaller.appspotmail.com>
Cc:     gregkh@linuxfoundation.org, jirislaby@kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 21 Apr 2023 at 10:18, syzbot
<syzbot+b7c3ba8cdc2f6cf83c21@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    fcd476ea6a88 Merge tag 'urgent-rcu.2023.03.28a' of git://g..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=146618b9c80000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=f7350c77b8056a38
> dashboard link: https://syzkaller.appspot.com/bug?extid=b7c3ba8cdc2f6cf83c21
> compiler:       Debian clang version 15.0.7, GNU ld (GNU Binutils for Debian) 2.35.2
>
> Unfortunately, I don't have any reproducer for this issue yet.
>
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/f3d8ce4faab0/disk-fcd476ea.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/fc53d9dee279/vmlinux-fcd476ea.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/22ad755d39b2/bzImage-fcd476ea.xz
>
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+b7c3ba8cdc2f6cf83c21@syzkaller.appspotmail.com

If I am reading this correctly, this race can lead to NULL derefs
among other things.
hung_up_tty_fops does not have splice_read, while other fops have.

So the following code in splice can execute NULL callback:

if (unlikely(!in->f_op->splice_read))
    return warn_unsupported(in, "read");
return in->f_op->splice_read(in, ppos, pipe, len, flags);




> ==================================================================
> BUG: KCSAN: data-race in __fput / __tty_hangup
>
> write to 0xffff88813b31e828 of 8 bytes by task 17702 on cpu 0:
>  __tty_hangup+0x1e2/0x510 drivers/tty/tty_io.c:622
>  tty_vhangup+0x17/0x20 drivers/tty/tty_io.c:701
>  pty_close+0x262/0x280 drivers/tty/pty.c:79
>  tty_release+0x204/0x930 drivers/tty/tty_io.c:1753
>  __fput+0x245/0x570 fs/file_table.c:321
>  ____fput+0x15/0x20 fs/file_table.c:349
>  task_work_run+0x123/0x160 kernel/task_work.c:179
>  get_signal+0xe5c/0xfe0 kernel/signal.c:2635
>  arch_do_signal_or_restart+0x89/0x2b0 arch/x86/kernel/signal.c:306
>  exit_to_user_mode_loop+0x6d/0xe0 kernel/entry/common.c:168
>  exit_to_user_mode_prepare+0x6a/0xa0 kernel/entry/common.c:204
>  __syscall_exit_to_user_mode_work kernel/entry/common.c:286 [inline]
>  syscall_exit_to_user_mode+0x26/0x140 kernel/entry/common.c:297
>  do_syscall_64+0x4d/0xc0 arch/x86/entry/common.c:86
>  entry_SYSCALL_64_after_hwframe+0x63/0xcd
>
> read to 0xffff88813b31e828 of 8 bytes by task 17705 on cpu 1:
>  __fput+0x21c/0x570 fs/file_table.c:320
>  ____fput+0x15/0x20 fs/file_table.c:349
>  task_work_run+0x123/0x160 kernel/task_work.c:179
>  get_signal+0xe5c/0xfe0 kernel/signal.c:2635
>  arch_do_signal_or_restart+0x89/0x2b0 arch/x86/kernel/signal.c:306
>  exit_to_user_mode_loop+0x6d/0xe0 kernel/entry/common.c:168
>  exit_to_user_mode_prepare+0x6a/0xa0 kernel/entry/common.c:204
>  __syscall_exit_to_user_mode_work kernel/entry/common.c:286 [inline]
>  syscall_exit_to_user_mode+0x26/0x140 kernel/entry/common.c:297
>  do_syscall_64+0x4d/0xc0 arch/x86/entry/common.c:86
>  entry_SYSCALL_64_after_hwframe+0x63/0xcd
>
> value changed: 0xffffffff84e91ed0 -> 0xffffffff84e91dc0
>
> Reported by Kernel Concurrency Sanitizer on:
> CPU: 1 PID: 17705 Comm: syz-executor.0 Not tainted 6.3.0-rc4-syzkaller-00034-gfcd476ea6a88 #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/17/2023
> ==================================================================
>
>
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
>
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
