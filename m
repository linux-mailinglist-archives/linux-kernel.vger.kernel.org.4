Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83AA46EAD6A
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 16:50:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232555AbjDUOts (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Apr 2023 10:49:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229712AbjDUOto (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Apr 2023 10:49:44 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA5F711A
        for <linux-kernel@vger.kernel.org>; Fri, 21 Apr 2023 07:49:39 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id 2adb3069b0e04-4ecb7fe8fb8so7084e87.0
        for <linux-kernel@vger.kernel.org>; Fri, 21 Apr 2023 07:49:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1682088578; x=1684680578;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=xVRMxfcjQGFVv7DrY1wDSZ0nImlTbkulAv9u9sf1tUA=;
        b=habJOUmIGxAySHNmx2R2Nf2WotKqohrIV4gvzvIrRBvffnvtZc1tTN+UdIKm5PFYxP
         dHtQ2KeEisnI2BJqZ6aFZ+woCI+mEJLDOaA0ezOip4ihTFcpUyPFDRnZrmbOFv/3yUdj
         pxZrTbRTJJPUByKxX0TTfLdfThmYSC6jEeue0KFwRsuunaP0rp6shzUBiN/K9IHxuAMU
         wkhJ30HOq93GMOmP+JY3kuFiFyAJlFpmkymWszHNnurHYVJW9ZWt2OjHXW7opyRrCkfU
         arHsxJnCtSWYBUok9udHVkVAoQQTKq33Vq5tagpmniCLlXbEmJ+adBPGjPsFUz/Dmjdy
         jNfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682088578; x=1684680578;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xVRMxfcjQGFVv7DrY1wDSZ0nImlTbkulAv9u9sf1tUA=;
        b=WmVXozKGZkn7DENC0qsXQHBYbKy1esgkLs3hn1slzfnqsM7oecxeL8iPrhoZe4Sqx4
         EaPWA8w3/1Ro8cmP1ucr5s8zNdGq+5TkiZlXfXH3BVrGU5cQVXkimJgeotrIRprgXjiH
         N58ITetfkxhGjRlMnskx/Jmf2CH3HfbmHIrwCZp5YWATJGoP+7R5vNB5z9AekD2Ob9kw
         DIhByfAKYZzuaY7y0amfCt2PwbNOFWvInrkGFpfJxkoeGnWrQB8hmh5Xh9E5h1EvvJd/
         VET/UNPyBmYh+3hYOT8hBV2CsahUKBzG33QvHkG0NAlZluIvgW/uVo4nNVb5GlF4SSlb
         zc5g==
X-Gm-Message-State: AAQBX9d+2Jn6YH3Z4lb0yq/onCJSjd/XdGarJb184YGVUaUFpMPd6FOc
        gIbSZ8E2xjRjeXpjKbUBDF6JrsT08K5lw0EVWIVICw==
X-Google-Smtp-Source: AKy350bqBTEyuYeoTp9dwglDeaCDtK5KkccAndCvgu/G10vRNfy3kVdU8vKXw43eOjMgymCOe8g6zIw1IO5i679/0Ds=
X-Received: by 2002:a05:6512:a96:b0:4ed:b131:3449 with SMTP id
 m22-20020a0565120a9600b004edb1313449mr177991lfu.7.1682088577800; Fri, 21 Apr
 2023 07:49:37 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000a3723305f9d98fc3@google.com>
In-Reply-To: <000000000000a3723305f9d98fc3@google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Fri, 21 Apr 2023 16:49:25 +0200
Message-ID: <CACT4Y+b2Bf6N=Wto686X=BJsjhpDJw7Xm4yJtszgxCSogX+0-g@mail.gmail.com>
Subject: Re: [syzbot] [kernel?] KCSAN: data-race in do_timer_create /
 do_timer_create (8)
To:     syzbot <syzbot+5c54bd3eb218bb595aa9@syzkaller.appspotmail.com>
Cc:     linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        tglx@linutronix.de, Marco Elver <elver@google.com>
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

On Fri, 21 Apr 2023 at 16:34, syzbot
<syzbot+5c54bd3eb218bb595aa9@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    6a8f57ae2eb0 Linux 6.3-rc7
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=154fe6c0280000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=fa4baf7c6b35b5d5
> dashboard link: https://syzkaller.appspot.com/bug?extid=5c54bd3eb218bb595aa9
> compiler:       Debian clang version 15.0.7, GNU ld (GNU Binutils for Debian) 2.35.2
>
> Unfortunately, I don't have any reproducer for this issue yet.
>
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/fd87c4c006cf/disk-6a8f57ae.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/2ac4347e9165/vmlinux-6a8f57ae.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/e5844a1e58ba/bzImage-6a8f57ae.xz
>
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+5c54bd3eb218bb595aa9@syzkaller.appspotmail.com

Here this:

int first_free_id = sig->posix_timer_id;

runs concurrently with:

if (++sig->posix_timer_id < 0)
    sig->posix_timer_id = 0;
if ((sig->posix_timer_id == first_free_id) && (ret == -ENOENT))
    /* Loop over all possible ids completed */
    ret = -EAGAIN;

I am not sure how important/realistic this wrap-around handling is,
but as the result of the race first_free_id can be negative (if it
reads the value at just the right moment). Then wrap-around will never
be detected and the loop will loop forever uninterruptably.



> ==================================================================
> BUG: KCSAN: data-race in do_timer_create / do_timer_create
>
> write to 0xffff888100ea9bc4 of 4 bytes by task 7660 on cpu 1:
>  do_timer_create+0x2fd/0xa30 kernel/time/posix-timers.c:516
>  __se_sys_timer_create kernel/time/posix-timers.c:577 [inline]
>  __x64_sys_timer_create+0xbb/0xe0 kernel/time/posix-timers.c:577
>  do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>  do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
>  entry_SYSCALL_64_after_hwframe+0x63/0xcd
>
> read to 0xffff888100ea9bc4 of 4 bytes by task 7659 on cpu 0:
>  posix_timer_add kernel/time/posix-timers.c:143 [inline]
>  do_timer_create+0x19f/0xa30 kernel/time/posix-timers.c:516
>  __se_sys_timer_create kernel/time/posix-timers.c:577 [inline]
>  __x64_sys_timer_create+0xbb/0xe0 kernel/time/posix-timers.c:577
>  do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>  do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
>  entry_SYSCALL_64_after_hwframe+0x63/0xcd
>
> value changed: 0x00000018 -> 0x00000026
>
> Reported by Kernel Concurrency Sanitizer on:
> CPU: 0 PID: 7659 Comm: syz-executor.1 Not tainted 6.3.0-rc7-syzkaller #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/30/2023
> ==================================================================
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
>
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
