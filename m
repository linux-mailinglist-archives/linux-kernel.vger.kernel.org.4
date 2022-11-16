Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 287AC62BB1F
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 12:13:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238906AbiKPLNe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 06:13:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239125AbiKPLNR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 06:13:17 -0500
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2C4743ACF
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 03:00:42 -0800 (PST)
Received: by mail-ot1-x330.google.com with SMTP id cn2-20020a056830658200b0066c74617e3dso10183138otb.2
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 03:00:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=zsp+X9ABCT76iWTtEoaqjGL5gM3NfV4g/EtTOwznlHw=;
        b=Pyw7jK2Fwj/Xdz5fz8l3gCxHpg2DdViqnALVdHU2CNbPpfM6KStqpIW2X8MMuHt2BT
         IEVClOXAU6oEMT521wEnVOlAcxzc+nceb6pYFy0zBhyAtvoBxb/P73iyaW/rcZ2KgSDe
         4Rj1ycw7HjR6qakoBzT5cCJwZmkck9/xQk6iNYupiK0F1C1CwP1pFi/C3qk6I4t6G4Eh
         hPNG9AjOJa7yiKEsaCfRXMFe6uz3qvXdJx1nEVMZQ/KXehdZ5EeRkp0dDS2OjUsRSZzf
         9sGywpw6r3YZAzp9Va+NS0+DbARzqYp7ybDwzQpLIHRV/J5S5fIVTdy9RHCerLF7MZ4g
         qt0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zsp+X9ABCT76iWTtEoaqjGL5gM3NfV4g/EtTOwznlHw=;
        b=kVxnbrcSrxe0tgElpSHm7eEV6mSumN9AYYfP2B92MyyYCn3dc53L26NErtSe/2OnhO
         R/1JpRKx+O9BQmMGETkZcAGMZB8IKi32uJ5Hmnh72V1ApKIQUL6gRVd8VoZIP0nCJuc5
         jLfoPf01PExRarOF3rcCTU2LjQBUdOx5v4hR4UVu1xHIFjlRKSRKpRkNspKli2ECsgFs
         2XYE+ltaRNxNrUwqunbjENZq5be7ogo3P+aGH8fHNVYarwpHp+XG1NdNJDuFPDU2p9dy
         humuwGoVk9YXxOSSoZtTw+zThPB5S/27dshB2oE/b5yl0Tvg59laJh6uDNysD5TbalML
         6g8Q==
X-Gm-Message-State: ANoB5pkLpt/A3eifS8wl71q1FY2UUZn+H7/7bjBnoSwvsxbg3BaqIycH
        zmBffy4lf+2P3WJjLNeJZxfUngVArV22HolrD+Knng==
X-Google-Smtp-Source: AA0mqf4+qoddsm79YTI4zfeBzrqjC8J7p9p5874YQUcbd9RHp44PFX9ZNhfh35vT1eXYFMOkcHErIKZ7XhkdM4f9S/g=
X-Received: by 2002:a05:6830:43:b0:66c:9e9a:1f82 with SMTP id
 d3-20020a056830004300b0066c9e9a1f82mr10145905otp.269.1668596441235; Wed, 16
 Nov 2022 03:00:41 -0800 (PST)
MIME-Version: 1.0
References: <00000000000095e1b405ed8a284a@google.com>
In-Reply-To: <00000000000095e1b405ed8a284a@google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Wed, 16 Nov 2022 12:00:29 +0100
Message-ID: <CACT4Y+beM9sKkcxA03hPHo-ob0xuRtDXrs_yW+iBdjGY+f64gA@mail.gmail.com>
Subject: Re: [syzbot] kernel panic: stack is corrupted in __blk_flush_plug
To:     syzbot <syzbot+fade8a8e2bdc29b3a90b@syzkaller.appspotmail.com>,
        almaz.alexandrovich@paragon-software.com, ntfs3@lists.linux.dev
Cc:     broonie@kernel.org, catalin.marinas@arm.com,
        kaleshsingh@google.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, madvenka@linux.microsoft.com,
        mark.rutland@arm.com, maz@kernel.org,
        syzkaller-bugs@googlegroups.com, will@kernel.org
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

On Tue, 15 Nov 2022 at 23:48, syzbot
<syzbot+fade8a8e2bdc29b3a90b@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    9e4ce762f0e7 Merge branches 'for-next/acpi', 'for-next/asm..
> git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
> console output: https://syzkaller.appspot.com/x/log.txt?x=1502ad35880000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=20ffacc1ce1c99b5
> dashboard link: https://syzkaller.appspot.com/bug?extid=fade8a8e2bdc29b3a90b
> compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
> userspace arch: arm64
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14f33159880000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13e33ef1880000
>
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/a70eb29add74/disk-9e4ce762.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/769d096516a8/vmlinux-9e4ce762.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/9309615f51d5/Image-9e4ce762.gz.xz
> mounted in repro: https://storage.googleapis.com/syzbot-assets/0332fee8ec34/mount_0.gz

The reproducer mounts ntfs3, so I think it's related to ntfs3. +maintainers.


> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+fade8a8e2bdc29b3a90b@syzkaller.appspotmail.com
>
> loop0: detected capacity change from 0 to 8226
> ntfs3: loop0: Mark volume as dirty due to NTFS errors
> ntfs3: loop0: Failed to load $Extend.
> Kernel panic - not syncing: stack-protector: Kernel stack is corrupted in: __blk_flush_plug+0x1a4/0x1a4
> CPU: 0 PID: 4370 Comm: syz-executor220 Not tainted 6.1.0-rc5-syzkaller-32254-g9e4ce762f0e7 #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/30/2022
> Call trace:
>  dump_backtrace+0x1c4/0x1f0 arch/arm64/kernel/stacktrace.c:156
>  show_stack+0x2c/0x54 arch/arm64/kernel/stacktrace.c:163
>  __dump_stack lib/dump_stack.c:88 [inline]
>  dump_stack_lvl+0x104/0x16c lib/dump_stack.c:106
>  dump_stack+0x1c/0x58 lib/dump_stack.c:113
>  panic+0x218/0x508 kernel/panic.c:274
>  warn_bogus_irq_restore+0x0/0x40 kernel/panic.c:703
>  blk_finish_plug+0x0/0x54
> SMP: stopping secondary CPUs
> Kernel Offset: disabled
> CPU features: 0x00000,040e0108,4c017203
> Memory Limit: none
> Rebooting in 86400 seconds..
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
