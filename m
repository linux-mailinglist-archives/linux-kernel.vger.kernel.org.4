Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDEBC6EC7DE
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 10:26:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231390AbjDXI0u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 04:26:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231256AbjDXI0n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 04:26:43 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FC0E198B
        for <linux-kernel@vger.kernel.org>; Mon, 24 Apr 2023 01:26:41 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id 2adb3069b0e04-4efd5e4d302so4133e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Apr 2023 01:26:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1682324799; x=1684916799;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=V7AW2hm1ZmUsP+5TXSnyjtQoQt9CgttsejTeP4uS+hs=;
        b=gZJOMydVPb+/ZKKzyMUyxBK4ZaDP4VpXj9tyw27CQNvP889xlGr8eXGQVSMDVnHK6u
         8EqoKvp9r8GPseK3gJ14PUVdciRytRptuc0MdGG6pL5woZnz+zTL5ekNsJ0iWC1L5m+T
         cZ+lSYXPGsUcltlAl097Rc9QbnsIFcvfylrgb9eMseS8oeq1Ec4H8TCH097j121I7ZQD
         NFi3RMNO64xZvFp56HQc5aHVtUS5Z7xgprGxr5IGTG/wBUaYVZofHrKEmoVojN2S+484
         EZimfvltRcTLuEzpC0aQzKtF3TrYQ1xun+VZ3TOHtEgj4qHbrvZE7TCLjjraP9VHAiUd
         BwIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682324799; x=1684916799;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=V7AW2hm1ZmUsP+5TXSnyjtQoQt9CgttsejTeP4uS+hs=;
        b=EyrFoXrXCaVWa1BVQ3Iuuek1zJ2eS5X7AM7WZmHiV8oBcUoa0FqxmdwJebEa4TKm1B
         RjKO5IxeRAzyEhEL6dutlO7YEn7DSyQ11xnA4sBwZOrEbC0Gk94P2igj/Lw/Sfstw5+K
         0PSDl2YvAxhaNA+KodmBrKAdzP9DjcmsjlC+G/njJ0uYc07kdvECi6MJ/MTJ0unfqgrz
         bHh09JWoEK9B+S7QTrMAhQ5FP1ARiJcP8gRGAA+MDfCzXY3K9TLL7KXp/4NgdeezZkcb
         HNYB2ZJhurOLhXnztCcmK39peaL8OK3pM8CozNzCqObFdRaMU/OpDiw85FC0DhBQ4Juy
         9rqQ==
X-Gm-Message-State: AAQBX9fOMGY+iaAZTB/we9cbo/wfis1mAnp1NvbqLplL52SdPvJslYPQ
        i/KtCWNTthnbKEjHXsEP9FAgYCvlqhLksy7qNGsz7g==
X-Google-Smtp-Source: AKy350ZbEnM0FOYf1sETOt6HWgMhUPzp/PyVOURn6rsxADirnRHCMRE8gPfPGZZ9cmVyakq0Cm5VQaaAV1ZxSIZ5/g0=
X-Received: by 2002:a05:6512:3e23:b0:4d0:e0ee:fc70 with SMTP id
 i35-20020a0565123e2300b004d0e0eefc70mr209330lfv.0.1682324798975; Mon, 24 Apr
 2023 01:26:38 -0700 (PDT)
MIME-Version: 1.0
References: <0000000000007337c705fa1060e2@google.com>
In-Reply-To: <0000000000007337c705fa1060e2@google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Mon, 24 Apr 2023 10:26:26 +0200
Message-ID: <CACT4Y+a=xWkNGw_iKibRp4ivSE8OJkWWT0VPQ4N4d1+vj0FMdg@mail.gmail.com>
Subject: Re: [syzbot] [mm?] KCSAN: data-race in generic_fillattr / shmem_mknod (2)
To:     syzbot <syzbot+702361cf7e3d95758761@syzkaller.appspotmail.com>
Cc:     akpm@linux-foundation.org, hughd@google.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        syzkaller-bugs@googlegroups.com
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

On Mon, 24 Apr 2023 at 09:58, syzbot
<syzbot+702361cf7e3d95758761@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    457391b03803 Linux 6.3
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=13226cf0280000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=8c81c9a3d360ebcf
> dashboard link: https://syzkaller.appspot.com/bug?extid=702361cf7e3d95758761
> compiler:       Debian clang version 15.0.7, GNU ld (GNU Binutils for Debian) 2.35.2
>
> Unfortunately, I don't have any reproducer for this issue yet.
>
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/6438dcb1c42d/disk-457391b0.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/20596c249e47/vmlinux-457391b0.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/cb715366a3e5/bzImage-457391b0.xz
>
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+702361cf7e3d95758761@syzkaller.appspotmail.com

I think shmem_mknod() needs to use i_size_write() to update the size.
Writes to i_size are not assumed to be atomic throughout the kernel
code.

> ==================================================================
> BUG: KCSAN: data-race in generic_fillattr / shmem_mknod
>
> read-write to 0xffff8881049a9408 of 8 bytes by task 3383 on cpu 0:
>  shmem_mknod+0xdd/0x180 mm/shmem.c:2942
>  shmem_create+0x34/0x40 mm/shmem.c:2994
>  lookup_open fs/namei.c:3416 [inline]
>  open_last_lookups fs/namei.c:3484 [inline]
>  path_openat+0xd96/0x1d00 fs/namei.c:3712
>  do_filp_open+0xf6/0x200 fs/namei.c:3742
>  do_sys_openat2+0xb5/0x2a0 fs/open.c:1348
>  do_sys_open fs/open.c:1364 [inline]
>  __do_sys_openat fs/open.c:1380 [inline]
>  __se_sys_openat fs/open.c:1375 [inline]
>  __x64_sys_openat+0xf3/0x120 fs/open.c:1375
>  do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>  do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
>  entry_SYSCALL_64_after_hwframe+0x63/0xcd
>
> read to 0xffff8881049a9408 of 8 bytes by task 4291 on cpu 1:
>  i_size_read include/linux/fs.h:866 [inline]
>  generic_fillattr+0x13f/0x1e0 fs/stat.c:58
>  shmem_getattr+0x32a/0x3b0 mm/shmem.c:1068
>  vfs_getattr_nosec+0x1e3/0x3c0 fs/stat.c:133
>  vfs_getattr fs/stat.c:170 [inline]
>  vfs_statx+0x156/0x300 fs/stat.c:242
>  vfs_fstatat fs/stat.c:276 [inline]
>  __do_sys_newfstatat fs/stat.c:446 [inline]
>  __se_sys_newfstatat+0x8a/0x2a0 fs/stat.c:440
>  __x64_sys_newfstatat+0x55/0x60 fs/stat.c:440
>  do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>  do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
>  entry_SYSCALL_64_after_hwframe+0x63/0xcd
>
> value changed: 0x0000000000001644 -> 0x0000000000001658
>
> Reported by Kernel Concurrency Sanitizer on:
> CPU: 1 PID: 4291 Comm: udevd Not tainted 6.3.0-syzkaller #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/14/2023
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
> To view this discussion on the web visit https://groups.google.com/d/msgid/syzkaller-bugs/0000000000007337c705fa1060e2%40google.com.
