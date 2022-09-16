Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A5885BB33A
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 22:09:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230238AbiIPUJr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 16:09:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230000AbiIPUJo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 16:09:44 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 763EB11C1F
        for <linux-kernel@vger.kernel.org>; Fri, 16 Sep 2022 13:09:42 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id k10so37254524lfm.4
        for <linux-kernel@vger.kernel.org>; Fri, 16 Sep 2022 13:09:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=TsMblmh+whw0Y6G/T+5phEJp9Ji8yHMxQQQ7u1lRyXY=;
        b=Ncmgb346gJscq3aycEEXnWjiY0CHuVAHV0RlaoWLU+j1MTRJpDoAsoEjr92c1ImEQE
         wUR2uXMmhrSr2EcRxP/0WQVj2BSKwChTvWjlVAhXdp87Y7fbMjzsZxXfpGgOfEtIIVq+
         iI+UrAMASxvdzeBx3yA0yusS+tMecl61oCiMU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=TsMblmh+whw0Y6G/T+5phEJp9Ji8yHMxQQQ7u1lRyXY=;
        b=Qyg0DLY8TYDk1dnbtiWAf7Ey9zWYkaJYgY3YrZ8emXIS7eKQw490ZMZnj2bW1HcRQA
         sqiwsE4l2BiSIb0i+ZvBvCsN6rti935btDNlyGUWDmavOHDskMGOzQ3L0mgomqL7FJpI
         0m7sOQiDgN11ZS2/zSqpKJEUmZXHk3tSwY5n29yc1j0Hig3oMfmH/NmqIzZ3W2Y9JvDA
         B1kqcXZceJX/YaTVs/Sqy4n0QGCy5e0A5TUyQ6jQTUB33vR7eAUwqd8hlQoNXbTjXb8M
         fMnDd2TdQVncDZeBzW//TF+1ShGgKXHP+Lt8ZSw10VGEUHmszcjdHbrfiYsD+lohcQcF
         ULgQ==
X-Gm-Message-State: ACrzQf3S2aGGO+BOAkXj8qqsoddrftJhy/OpRrqukKXsmxHOKBhU/9vF
        Y9qPi/N0okeRJ2h/8HsoinlA55jYwu7E1qXqaBc=
X-Google-Smtp-Source: AMsMyM5XpFBHSjd49EGk2pqRd3PKjIR0M2zqHezyjjvCH0LFfKlsDrMW4choTKhjzu2UbkhIxc77XQ==
X-Received: by 2002:a05:6512:6d6:b0:499:27c:1aa0 with SMTP id u22-20020a05651206d600b00499027c1aa0mr2302527lff.88.1663358980561;
        Fri, 16 Sep 2022 13:09:40 -0700 (PDT)
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com. [209.85.167.52])
        by smtp.gmail.com with ESMTPSA id x12-20020a056512078c00b00498fd423cc3sm1771497lfr.295.2022.09.16.13.09.39
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Sep 2022 13:09:40 -0700 (PDT)
Received: by mail-lf1-f52.google.com with SMTP id k10so37254461lfm.4
        for <linux-kernel@vger.kernel.org>; Fri, 16 Sep 2022 13:09:39 -0700 (PDT)
X-Received: by 2002:a19:4f45:0:b0:49a:63c9:190d with SMTP id
 a5-20020a194f45000000b0049a63c9190dmr2001777lfk.61.1663358979664; Fri, 16 Sep
 2022 13:09:39 -0700 (PDT)
MIME-Version: 1.0
References: <mhng-f5d21762-1321-4d35-927c-d47e0749abc0@palmer-ri-x1c9>
In-Reply-To: <mhng-f5d21762-1321-4d35-927c-d47e0749abc0@palmer-ri-x1c9>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 16 Sep 2022 13:09:21 -0700
X-Gmail-Original-Message-ID: <CAHk-=wihdDOSVVi1gBYo+rcJ7dG6tvN7mEU=XLir8WiEdR1kQQ@mail.gmail.com>
Message-ID: <CAHk-=wihdDOSVVi1gBYo+rcJ7dG6tvN7mEU=XLir8WiEdR1kQQ@mail.gmail.com>
Subject: Re: [GIT PULL] RISC-V Fixes for 6.0-rc6
To:     Palmer Dabbelt <palmer@rivosinc.com>
Cc:     linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 16, 2022 at 8:31 AM Palmer Dabbelt <palmer@rivosinc.com> wrote:
>
> I have one merge conflict as a result of a treewide fix, I'm getting some odd
> output from just showing the merge (it's showing some of the fix too), but I
> think the merge itself is OK.  My fix is to keep the write lock
>
> -       mmap_read_lock(mm);
> ++      mmap_write_lock(mm);
>  +      ret = walk_page_range_novma(mm, start, end, &pageattr_ops, NULL,
>  +                                  &masks);
> -       mmap_read_unlock(mm);
> ++      mmap_write_unlock(mm);

Yes, thatr's the proper merge resolution.

HOWEVER.

Looking at the *callers* of this new __set_memory_mm(), this is all
completely bogus and broken.

In particular, fix_kernel_mem_early() does that call under rcu_read_lock().

You can't do that. Not with the read-lock, and not with the
write-lock. You simply cannot (and must not) block while in a
read-side critical section, and trying to take any sleeping lock -
whether for reading or for writing - is just completely wrong.

So I'm not doing this pull. The merge resolution is trivial, but the
code is simply wrong.

                Linus
