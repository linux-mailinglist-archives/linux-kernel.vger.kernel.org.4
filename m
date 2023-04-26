Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD1E86EEE75
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 08:40:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239564AbjDZGku (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 02:40:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239223AbjDZGkt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 02:40:49 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F49C2694
        for <linux-kernel@vger.kernel.org>; Tue, 25 Apr 2023 23:40:38 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id 2adb3069b0e04-4efea87c578so7096e87.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Apr 2023 23:40:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1682491237; x=1685083237;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=26EaJCB4BLLjpmwn+UJgLwabpmkPDEPq9rinV+1slYg=;
        b=VDIVNx8LrwzttePAvdnXS2sDN2anEP+SmBVydC+gTIck5cs4NM01wEgckxFMBH/8DB
         Fj29SrK1x8MLN7v/rA5mQg5Z7ai9GdF/tuYZpKTkAI77zFORov6oyciyadm1vr4xipxM
         n3lY1Dbh0xQ/asAgJJMz3gzsb1oFS2/5DAoftRk3WUOfPehnCVlh0vc9LeOvzWC9Rd6C
         nLX81wAUVKYDjTRmapCXJZjDjvhh1kYV67j4tsJJn5m+CaiwKrThuufoKGxnsnjSyTZ8
         yWH8uUpOy850MNsLVVOCzlwBYW+awdFfPQYzAOUeWf90+uvCsErqJ9gISEvLcHf0bsNJ
         ZepQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682491237; x=1685083237;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=26EaJCB4BLLjpmwn+UJgLwabpmkPDEPq9rinV+1slYg=;
        b=O45TFYTvlS+lq6aCt7d2AE/1BbhzRZvD6M4pX+nmUKOA41vpzygwxaOHdleNfd5IJI
         DWPbwlW5+PBekOyoNOsXB2BBQqqNHN0KM3guOs+9Jz6d88y5zjpoCaM7zv1mNJQeM9/L
         2VkPVvQkj0iE8UEPXW3zNv+5eMRaJ0QDPvZvkSiv1oWR3mRjLMb/JC4WRINvgXb/iOBC
         vbUQbxanaTmtDEuIB1g91DX+wRgLKeEyYF4d8VnPAOxa6S598rkUYeVEmS0s5FQkDX48
         Z8LNAN+5TpRagG/4Dm+Rba6Gi+RBKVlBX9qM+UU58w8tMJyuknHHRezwdITS2QuWZ97W
         GDGA==
X-Gm-Message-State: AC+VfDyK+I/7WPhmN+a3UUi81K64uNSXhCr+5z4OItR28B4KUbRNBZqX
        qPzjmRmmvdTuVo3BThilX64kSQZHePEGvWBDljQJRA==
X-Google-Smtp-Source: ACHHUZ5cVNzl395xaBLbIB0gf8rLCrYPuaZPJN0WZn147Mwa5s1vko3C35Ob71ekGdCqtq/gzHms8ZpADoD8xdj8JKI=
X-Received: by 2002:a05:6512:4023:b0:4ea:e5e2:c893 with SMTP id
 br35-20020a056512402300b004eae5e2c893mr65339lfb.1.1682491236524; Tue, 25 Apr
 2023 23:40:36 -0700 (PDT)
MIME-Version: 1.0
References: <00000000000079eebe05fa2ea9ad@google.com> <20230426044928.GD1496740@google.com>
In-Reply-To: <20230426044928.GD1496740@google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Wed, 26 Apr 2023 08:40:23 +0200
Message-ID: <CACT4Y+bJQOYV4_VumkrwobDio8CH-oqT2Wuo4Gzz2+BkX6tqzA@mail.gmail.com>
Subject: Re: [syzbot] upstream boot error: BUG: unable to handle kernel NULL
 pointer dereference in __dabt_svc
To:     Sergey Senozhatsky <senozhatsky@chromium.org>
Cc:     syzbot <syzbot+d692037148a8169fc9dd@syzkaller.appspotmail.com>,
        alex.gaynor@gmail.com, andriy.shevchenko@linux.intel.com,
        bjorn3_gh@protonmail.com, boqun.feng@gmail.com,
        bpf@vger.kernel.org, gary@garyguo.net,
        linux-kernel@vger.kernel.org, linux@rasmusvillemoes.dk,
        ojeda@kernel.org, pmladek@suse.com, rostedt@goodmis.org,
        rust-for-linux@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        wedsonaf@gmail.com,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 26 Apr 2023 at 06:49, Sergey Senozhatsky
<senozhatsky@chromium.org> wrote:
>
> On (23/04/25 13:06), syzbot wrote:
> > 8<--- cut here ---
> > Unable to handle kernel NULL pointer dereference at virtual address 000005fc when read
> > [000005fc] *pgd=80000080004003, *pmd=00000000
> > Internal error: Oops: 206 [#1] PREEMPT SMP ARM
> > Modules linked in:
> > CPU: 1 PID: 0 Comm: swapper/1 Not tainted 6.3.0-syzkaller #0
> > Hardware name: ARM-Versatile Express
>
> > Insufficient stack space to handle exception!
>
> So much stuff is going on there.
>
> > Task stack:     [0xdf85c000..0xdf85e000]
> > IRQ stack:      [0xdf804000..0xdf806000]
> > Overflow stack: [0x828ae000..0x828af000]
> > Internal error: kernel stack overflow: 0 [#2] PREEMPT SMP ARM
> > Modules linked in:
> > CPU: 1 PID: 0 Comm: swapper/1 Not tainted 6.3.0-syzkaller #0
> > Hardware name: ARM-Versatile Express
> > PC is at __dabt_svc+0x14/0x60 arch/arm/kernel/entry-armv.S:210
> > LR is at vsnprintf+0x378/0x408 lib/vsprintf.c:2862
> > pc : [<80200a74>]    lr : [<817ad5d8>]    psr: 00000193
> > sp : df804028  ip : df805868  fp : df805864
> > r10: 00000060  r9 : ffffffff  r8 : 00000010
> > r7 : 00000020  r6 : 00000004  r5 : ffffffff  r4 : df805960
> > r3 : ffffffff  r2 : 00000040  r1 : ffffffff  r0 : 8264d250
> > Flags: nzcv  IRQs off  FIQs on  Mode SVC_32  ISA ARM  Segment none
> > Control: 30c5387d  Table: 80003000  DAC: 00000000
> > Register r0 information:
> > 8<--- cut here ---
> > Unable to handle kernel NULL pointer dereference at virtual address 000001ff when read
> > [000001ff] *pgd=80000080004003, *pmd=00000000
> > Internal error: Oops: 206 [#3] PREEMPT SMP ARM
> > Modules linked in:
> > CPU: 1 PID: 0 Comm: swapper/1 Not tainted 6.3.0-syzkaller #0
> > Hardware name: ARM-Versatile Express
> > PC is at __find_vmap_area mm/vmalloc.c:841 [inline]
> > PC is at find_vmap_area mm/vmalloc.c:1862 [inline]
> > PC is at find_vm_area mm/vmalloc.c:2571 [inline]
> > PC is at vmalloc_dump_obj+0x38/0xb4 mm/vmalloc.c:4108
> > LR is at __raw_spin_lock include/linux/spinlock_api_smp.h:132 [inline]
> > LR is at _raw_spin_lock+0x18/0x58 kernel/locking/spinlock.c:154
>
> Not sure if I can make sense out of this.

+linux-arm-kernel@

I suspect this is some recent arch/arm related corruption.
There are also these similar boot crashes that started happening at
roughly the same time:
https://syzkaller.appspot.com/bug?id=4d697346183db2f86ba2f76acb7d66e7731f88df
https://syzkaller.appspot.com/bug?id=dcd98d67539fe4d0d28d2e655e510569eda6f4de
