Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19EE86EC74F
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 09:42:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231405AbjDXHmk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 03:42:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231165AbjDXHmi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 03:42:38 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BF46A7
        for <linux-kernel@vger.kernel.org>; Mon, 24 Apr 2023 00:42:36 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id 2adb3069b0e04-4efd5e4d302so4016e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Apr 2023 00:42:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1682322155; x=1684914155;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=23a1E0HIFpgHSlb82ihOoDCUEgYGChUX8rdYg8ouJPE=;
        b=SDk0ywpSJg4VWH1VUThXYnGnxzOmvg4LtOZL4gGtJp7UcvOSs4k35qL7bzjz4Z4TWc
         X+yDXh84KZtPtQpJjwNGO/WsHQ/YKbbypQZGVI+Csnl5jgBsjakrG7nmruqBskTXk40X
         HYFqG4J53wgOi2s/3uBwpIZauFj3ouelxfiQ2RSKOtVI/X/Ihonv8zTi+sR1Dastqsra
         i9lls/9F8V/cbh0M3cTiChbvE5wlEzGOyQiWueAikoCYI4mbP4o+5m1qhcE/YTe6MJuV
         nbr2uTrhDkwknPOTsVxRfMytJHdKcte4w3+oWI7to9cEl/AfvwsQ42oPM7PbiSt3PIht
         99Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682322155; x=1684914155;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=23a1E0HIFpgHSlb82ihOoDCUEgYGChUX8rdYg8ouJPE=;
        b=buMsx6fwLi40S9weoE6JJ+3oT6cCDcWbuZaBhJCUZX38roapJ1UWn27AjE6c9U2LyY
         FvT75eC8ZPGY87RVL2aPYKeP5/ZnfwZ35zE85x3HeioOsQrIy1G1oDdELNYJYQfu8p/I
         BJOo/3s3TQqEjLiA4p0xWCdzQ+bhl8Osp8A+Qhf2zYxfovYp3D95JIW7LYNd0exhe5Ph
         M8RoKKfYWdFQp38bDHIsOMMDKwACCz0P3mPfwP3QRAggPL36oESAGgVgHbRmZJt79nGE
         D4mP9Ml9h85mOHY5XZlC8kVKNZYWxX1SR1++kBVwFeVvCTop3ATd6zyeNxQO+Ldt1XJ9
         uuQA==
X-Gm-Message-State: AAQBX9cAJgp0VvZr6CWaiB3oPl2lsIu/bgH3bcoyupzb2lxXsZn3u03s
        MUhyF4q7EJ4W9pwUudgDNmqMxqAKCUy/sTxudyr4kg==
X-Google-Smtp-Source: AKy350Z167ghQt6zojoVa5Lzeq1YqkQgBD6oFOX3LLSAmZyTzOi3rQvaIMTRp8U2WAMJTZUpD+x8EEufVqLYVvvovYE=
X-Received: by 2002:a05:6512:12ce:b0:4e8:3f1e:de43 with SMTP id
 p14-20020a05651212ce00b004e83f1ede43mr219269lfg.7.1682322154730; Mon, 24 Apr
 2023 00:42:34 -0700 (PDT)
MIME-Version: 1.0
References: <00000000000071af7a05fa0fd8dc@google.com>
In-Reply-To: <00000000000071af7a05fa0fd8dc@google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Mon, 24 Apr 2023 09:42:22 +0200
Message-ID: <CACT4Y+aBxmUzoOaG99Wucj7b3pJH1DUMSvKw7SHRiFJ9OuZq2g@mail.gmail.com>
Subject: Re: [syzbot] [block?] KCSAN: data-race in __get_task_ioprio / set_task_ioprio
To:     syzbot <syzbot+28ed267c18c614a9376f@syzkaller.appspotmail.com>
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
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

On Mon, 24 Apr 2023 at 09:20, syzbot
<syzbot+28ed267c18c614a9376f@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    44149752e998 Merge tag 'cgroup-for-6.3-rc6-fixes' of git:/..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=147afc8fc80000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=710057cbb8def08c
> dashboard link: https://syzkaller.appspot.com/bug?extid=28ed267c18c614a9376f
> compiler:       Debian clang version 15.0.7, GNU ld (GNU Binutils for Debian) 2.35.2
>
> Unfortunately, I don't have any reproducer for this issue yet.
>
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/7bfa303f05cc/disk-44149752.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/4e8ea8730409/vmlinux-44149752.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/e584bce13ba7/bzImage-44149752.xz
>
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+28ed267c18c614a9376f@syzkaller.appspotmail.com

It looks like it can lead to reading wrong/uninit ioprio in __get_task_ioprio.
I think set_task_ioprio() should init ioprio before publishing and
publish with a release store, __get_task_ioprio needs to use load
acquire to ensure proper ordering.

> ==================================================================
> BUG: KCSAN: data-race in __get_task_ioprio / set_task_ioprio
>
> write to 0xffff888108c83888 of 8 bytes by task 15748 on cpu 0:
>  set_task_ioprio+0x23b/0x260 block/blk-ioc.c:291
>  __do_sys_ioprio_set block/ioprio.c:124 [inline]
>  __se_sys_ioprio_set+0x272/0x5a0 block/ioprio.c:68
>  __x64_sys_ioprio_set+0x43/0x50 block/ioprio.c:68
>  do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>  do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
>  entry_SYSCALL_64_after_hwframe+0x63/0xcd
>
> read to 0xffff888108c83888 of 8 bytes by task 15749 on cpu 1:
>  __get_task_ioprio+0x1c/0x110 block/ioprio.c:150
>  get_current_ioprio include/linux/ioprio.h:60 [inline]
>  init_sync_kiocb include/linux/fs.h:2003 [inline]
>  __kernel_write_iter+0xe2/0x380 fs/read_write.c:515
>  dump_emit_page fs/coredump.c:885 [inline]
>  dump_user_range+0x258/0x480 fs/coredump.c:912
>  elf_core_dump+0x1a73/0x1b90 fs/binfmt_elf.c:2142
>  do_coredump+0xfeb/0x1840 fs/coredump.c:762
>  get_signal+0xd65/0xff0 kernel/signal.c:2845
>  arch_do_signal_or_restart+0x89/0x2a0 arch/x86/kernel/signal.c:306
>  exit_to_user_mode_loop+0x6f/0xe0 kernel/entry/common.c:168
>  exit_to_user_mode_prepare+0x6c/0xb0 kernel/entry/common.c:204
>  irqentry_exit_to_user_mode+0x9/0x20 kernel/entry/common.c:310
>  irqentry_exit+0x12/0x40 kernel/entry/common.c:413
>  exc_general_protection+0x339/0x4c0 arch/x86/kernel/traps.c:728
>  asm_exc_general_protection+0x26/0x30 arch/x86/include/asm/idtentry.h:564
>
> value changed: 0x0000000000000000 -> 0xffff8881049b5c90
>
> Reported by Kernel Concurrency Sanitizer on:
> CPU: 1 PID: 15749 Comm: syz-executor.5 Tainted: G        W          6.3.0-rc6-syzkaller-00138-g44149752e998 #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/30/2023
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
> To view this discussion on the web visit https://groups.google.com/d/msgid/syzkaller-bugs/00000000000071af7a05fa0fd8dc%40google.com.
