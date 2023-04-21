Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 597926EAD5D
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 16:46:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232904AbjDUOq0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Apr 2023 10:46:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232098AbjDUOqX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Apr 2023 10:46:23 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B21014452
        for <linux-kernel@vger.kernel.org>; Fri, 21 Apr 2023 07:46:03 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id 2adb3069b0e04-4efd5e4d302so266e87.0
        for <linux-kernel@vger.kernel.org>; Fri, 21 Apr 2023 07:46:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1682088361; x=1684680361;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=I/sa1rICPVvzthwW5ZMdXLXSP1MQ4T/stV2pj7k4W6g=;
        b=4rPA8jXlm8S7XYy5Ha6N3MddNd9lQVcxkwNTLhztOXN8OkWbUIgsYxlMKrUmKr7hFp
         B+zssQe1H86jwUNz5zxKu8JwHJV2pUDehR0xa9vAzylJHrT9SExtUG6dm6rmpBYoRRc3
         GF6Y69xJ6n8RvlseGVb0H1HnWzWajEuFrfsHqlpH/GU6I7/P8KfMf9L7FgSdF5KKfBgG
         0HjwUG1qUVQnyHR/8gTgJc3SZe5D7BRhuQwcGqR142WHcgff1ZLIxkEJHfdqUc6NLUV/
         49pWW4vut2MDAT5XMiXRps5LcsCrNAgOpBZQwT3vY17/NSGFLax863dXxJj7kREII3B1
         C4qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682088361; x=1684680361;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=I/sa1rICPVvzthwW5ZMdXLXSP1MQ4T/stV2pj7k4W6g=;
        b=du8xcnt8e5WmJH6/8ZsoSBH3RES55mFbMhq3QMIOOexgBelJNmR/Zxa9XKIbH2FL6B
         0TTHCvxcsmWg5EIEe4bj7oI2yxyNksrmQFISz5XvQ+ggW1OBLXV7FM06mVJ1dzRq79U6
         QoPhqQudJcac4avuPRtJdTOW5U1jVyrnY3c83JeS9D6Ws8zywEqxgO0fHpzjEyN182I3
         2d2HecVpZ5j7niOq9XOFeCXLpCB+byctLz4k3bi05zqbQMASGtidxALBNFoiDsx5eMca
         QaIudZmT+wunU+kNi891zXMRz3jmMNHOSQmaL+zA6Huh4xEsC8mOMsJX3RX8uT0emDbX
         fIdg==
X-Gm-Message-State: AAQBX9c+2Who7lcnjaOJwtQY0VgPJ85ifM9ISi0MMh/uSVwf3Ff651Ql
        9KTL9slCXKxGCBeMwjwy7xCbkfrfPbISnuCBWXxBAw==
X-Google-Smtp-Source: AKy350aOIpVCOWRJFxjPyu/0rGOjsgl/vpiE35LhCpAa4+xJjwBhIxFvcWYV7RmsfQeCac/qhl79NpXBxQkm/QtPxag=
X-Received: by 2002:a05:6512:3d90:b0:4d0:e0ee:fc70 with SMTP id
 k16-20020a0565123d9000b004d0e0eefc70mr178731lfv.0.1682088360819; Fri, 21 Apr
 2023 07:46:00 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000be9fa205f9d98b5b@google.com>
In-Reply-To: <000000000000be9fa205f9d98b5b@google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Fri, 21 Apr 2023 16:45:48 +0200
Message-ID: <CACT4Y+ZamRvmkZJCLkM06y=ZVjhF6gfV-Rf7mxrONhEt+tTV+A@mail.gmail.com>
Subject: Re: [syzbot] [kernel?] KCSAN: data-race in complete_signal /
 do_group_exit (7)
To:     syzbot <syzbot+0864692611e2ae4cc85f@syzkaller.appspotmail.com>
Cc:     brauner@kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, Oleg Nesterov <oleg@redhat.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>
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

On Fri, 21 Apr 2023 at 16:33, syzbot
<syzbot+0864692611e2ae4cc85f@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    3a93e40326c8 Merge tag 'for-linus' of git://git.kernel.org..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=1769d1dec80000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=f7350c77b8056a38
> dashboard link: https://syzkaller.appspot.com/bug?extid=0864692611e2ae4cc85f
> compiler:       Debian clang version 15.0.7, GNU ld (GNU Binutils for Debian) 2.35.2
>
> Unfortunately, I don't have any reproducer for this issue yet.
>
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/2122926bc9fe/disk-3a93e403.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/8392992358bc/vmlinux-3a93e403.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/6398a2d19a7e/bzImage-3a93e403.xz
>
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+0864692611e2ae4cc85f@syzkaller.appspotmail.com

Here this:

signal->flags = SIGNAL_GROUP_EXIT;
signal->group_exit_code = sig;

runs concurrently with:

if (sig->flags & SIGNAL_GROUP_EXIT)
   exit_code = sig->group_exit_code;

If I am reading this correctly, do_group_exit() can use a wrong/uninit
exit code as the result.





> ==================================================================
> BUG: KCSAN: data-race in complete_signal / do_group_exit
>
> write to 0xffff88810491e534 of 4 bytes by task 13425 on cpu 0:
>  complete_signal+0x541/0x6d0 kernel/signal.c:1053
>  __send_signal_locked+0x5cc/0x700 kernel/signal.c:1190
>  send_signal_locked+0x28d/0x3a0 kernel/signal.c:1253
>  do_send_sig_info+0x9f/0xf0 kernel/signal.c:1296
>  send_sig_info kernel/signal.c:1636 [inline]
>  send_sig+0x53/0x60 kernel/signal.c:1646
>  pipe_write+0x8b1/0xd70 fs/pipe.c:482
>  call_write_iter include/linux/fs.h:1851 [inline]
>  new_sync_write fs/read_write.c:491 [inline]
>  vfs_write+0x45a/0x750 fs/read_write.c:584
>  ksys_write+0xeb/0x1a0 fs/read_write.c:637
>  __do_sys_write fs/read_write.c:649 [inline]
>  __se_sys_write fs/read_write.c:646 [inline]
>  __x64_sys_write+0x42/0x50 fs/read_write.c:646
>  do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>  do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
>  entry_SYSCALL_64_after_hwframe+0x63/0xcd
>
> read to 0xffff88810491e534 of 4 bytes by task 13410 on cpu 1:
>  do_group_exit+0x3e/0x150 kernel/exit.c:998
>  __do_sys_exit_group kernel/exit.c:1030 [inline]
>  __se_sys_exit_group kernel/exit.c:1028 [inline]
>  __x64_sys_exit_group+0x1f/0x20 kernel/exit.c:1028
>  do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>  do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
>  entry_SYSCALL_64_after_hwframe+0x63/0xcd
>
> value changed: 0x00000002 -> 0x00000004
>
> Reported by Kernel Concurrency Sanitizer on:
> CPU: 1 PID: 13410 Comm: syz-executor.0 Not tainted 6.3.0-rc4-syzkaller-00025-g3a93e40326c8 #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/02/2023
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
>
> --
> You received this message because you are subscribed to the Google Groups "syzkaller-bugs" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to syzkaller-bugs+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/syzkaller-bugs/000000000000be9fa205f9d98b5b%40google.com.
