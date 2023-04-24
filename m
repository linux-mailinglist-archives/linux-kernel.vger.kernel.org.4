Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8A576EC7E5
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 10:28:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230319AbjDXI2g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 04:28:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230005AbjDXI2d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 04:28:33 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BE81B0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Apr 2023 01:28:30 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id 2adb3069b0e04-4edc63e066fso10847e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 24 Apr 2023 01:28:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1682324908; x=1684916908;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=VFMTmlVWBZjr89OQrKH7/MRmetj8HLxd8IgMdt30Tx4=;
        b=cTaBjQGPn56LG5HNY3wnY9vaMc37zuIgM5L8lrM1ZLFZuk22y4/RbmsIa2xyGtueOP
         itdvMOItTOlhE0dWcJidcUWEAcwZh77I04qcoAqoFvxI7fkVNHNdaw99s8iaGUw7+nQU
         vrdMlExhj0xZeo1cR20q+ErorfvJ08ZV7NssBiSgOtsH/ulCj1LQsrkTC33M62VRIRRC
         DeDF3ZCU+1Ru8Uf1eOj7v0rYMP1cXH5QbD9+e08zac+rLp2lBeZK+fTfVBPpM6awXEB/
         uIsQ8pHk4wL/Imykd56JcV7eXxV6SQA9QZPdreao/gTtZIMK9yIAva1+UbyoWTjqHI1F
         IzlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682324908; x=1684916908;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VFMTmlVWBZjr89OQrKH7/MRmetj8HLxd8IgMdt30Tx4=;
        b=YlQeAKw1s4tWZixaIAhITYvMxcuYoOtxWJ4bCvat7np102OBGT7pAPe9eehkof4ln7
         qt1SJRtzFC+eM1LFfxglorrRkVovE61y4c4+4KPeB/ic+lGvSXa/+zGIBU8dFgl4tlnS
         86xgZQbmGkHZeipkI2RD1oNlxZn83cYdAnFoyy2vXgm4rOBrvQA25ATKOS6tgVPw8Pd3
         xm7vd7MdV9kIBmVTopqaNt1BwN4DBX69n37k1FyUePpDtF5BlsWsd6SKwEHL2CvBbNgx
         10MYhGCICy9L68wBzx/hMYClrUR+gUK8Jv258jzLUbc7vPeiTrGJNaJ0jMEL8QCeHIIw
         dkvA==
X-Gm-Message-State: AAQBX9fYPNk0nDbLwkrLxLqDfk+7e841aL/Y5qzRNL/lIMl7kx0Dy/da
        If2cQC8GelV6dFsinuUUY8vekz0+msl60eXaIBVreg==
X-Google-Smtp-Source: AKy350b+WaKh8fxWvfSxoSxOnK+mlFdf9ptoFPEn+SBLsre6reSOPk9Lhm7E00BRsLkNtpzZg2x135zcY02Ae+4P2pU=
X-Received: by 2002:a05:6512:2825:b0:4ec:5157:bb37 with SMTP id
 cf37-20020a056512282500b004ec5157bb37mr181892lfb.2.1682324908111; Mon, 24 Apr
 2023 01:28:28 -0700 (PDT)
MIME-Version: 1.0
References: <0000000000001db82205fa108b35@google.com>
In-Reply-To: <0000000000001db82205fa108b35@google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Mon, 24 Apr 2023 10:28:15 +0200
Message-ID: <CACT4Y+b+myUC25qe6Z7L4ZKaUFjRujNB0HOrMDC2U6dpSOf0bA@mail.gmail.com>
Subject: Re: [syzbot] [mm?] KCSAN: data-race in generic_fillattr /
 shmem_unlink (3)
To:     syzbot <syzbot+f682b67a78ce05867e78@syzkaller.appspotmail.com>
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

On Mon, 24 Apr 2023 at 10:10, syzbot
<syzbot+f682b67a78ce05867e78@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    cb0856346a60 Merge tag 'mm-hotfixes-stable-2023-04-19-16-3..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=10b9e8bfc80000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=fa4baf7c6b35b5d5
> dashboard link: https://syzkaller.appspot.com/bug?extid=f682b67a78ce05867e78
> compiler:       Debian clang version 15.0.7, GNU ld (GNU Binutils for Debian) 2.35.2
>
> Unfortunately, I don't have any reproducer for this issue yet.
>
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/a02dd7789fb2/disk-cb085634.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/a1a1eac454f6/vmlinux-cb085634.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/bb0447014913/bzImage-cb085634.xz
>
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+f682b67a78ce05867e78@syzkaller.appspotmail.com

I think shmem_unlink() needs to use i_size_write() to update the size.
Writes to i_size are not assumed to be atomic throughout the kernel
code.

> ==================================================================
> BUG: KCSAN: data-race in generic_fillattr / shmem_unlink
>
> read-write to 0xffff888104d167b8 of 8 bytes by task 23887 on cpu 1:
>  shmem_unlink+0x102/0x190 mm/shmem.c:3036
>  vfs_unlink+0x261/0x3e0 fs/namei.c:4250
>  do_unlinkat+0x266/0x4f0 fs/namei.c:4316
>  __do_sys_unlink fs/namei.c:4364 [inline]
>  __se_sys_unlink fs/namei.c:4362 [inline]
>  __x64_sys_unlink+0x30/0x40 fs/namei.c:4362
>  do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>  do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
>  entry_SYSCALL_64_after_hwframe+0x63/0xcd
>
> read to 0xffff888104d167b8 of 8 bytes by task 27823 on cpu 0:
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
> value changed: 0x00000000000000c8 -> 0x00000000000000b4
>
> Reported by Kernel Concurrency Sanitizer on:
> CPU: 0 PID: 27823 Comm: udevd Not tainted 6.3.0-rc7-syzkaller-00089-gcb0856346a60 #0
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
> To view this discussion on the web visit https://groups.google.com/d/msgid/syzkaller-bugs/0000000000001db82205fa108b35%40google.com.
