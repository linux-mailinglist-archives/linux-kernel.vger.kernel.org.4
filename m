Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FC2F5EE4B5
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 21:00:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234200AbiI1TAl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 15:00:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232439AbiI1TAc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 15:00:32 -0400
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9929A6715B
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 12:00:31 -0700 (PDT)
Received: by mail-oi1-x22e.google.com with SMTP id t62so16383203oie.10
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 12:00:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=un08nCcMg2c1Bks3IVOtg7+kiIVa7Qq4kDC+GJMXpwI=;
        b=WvOhAv7ka7uu1ZxTrSvTuloMqcxvP/WvnrE9siyfWUbmT7s+0yjpuLw1ZrdYRkWbMJ
         9Gc/xJbpomgRAOWWoaZ6fI84rffSZQtmmnZqAeQTE2wLdA4alNEz7rEfwlbbhPxhnPdc
         C7ie0l/WkYdXkgLph2wxwJyati7fTe7uzlshY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=un08nCcMg2c1Bks3IVOtg7+kiIVa7Qq4kDC+GJMXpwI=;
        b=V/ZjxIkuqA37J/U3CvXT3krfIVpl3k7wQo/mXk0lcfPOsrp2YPawrzRh3yYxxye7IU
         Iz6ak22+CIiJBxGY+LaTpJ651WgShMcAMt9yS5SGRukAFoUNk/TqUdUMTU3EoMGWndbr
         9/dA/KE76K56sUZ9EE6hdhLuAK/UPA6tatjhTl7aXAJCHSWKn58K669QoZ12xheUOodN
         T0I4EFs5XLYvw3L7zPcJYo7iHNMSmZWk4io3Bbvi0fiINfFhbwTuhJ6W7qws7BvgXCxR
         r6niy9FlsbEBE20z5nFIZLPm5YGDmNMKxWl3GjMvnwwAVxJfWy6PVJKcWD6OeMQybMjZ
         tpZw==
X-Gm-Message-State: ACrzQf1OD4Ew9f7b+KtRe/OrWN0MukiT21+kJTyYBfuOeMJy56BiR3Tg
        XJc6EHi7KCbDXqCJRc1OO9lm6hr5h4U0fg==
X-Google-Smtp-Source: AMsMyM5CdTw3PO8RPFs7mg7NvnIcuYHz3FGe9TMISGDsN7U5ToYZ34uAAU3BqzH4T/actSlcauHdhw==
X-Received: by 2002:a05:6808:a05:b0:350:d047:8878 with SMTP id n5-20020a0568080a0500b00350d0478878mr5255666oij.138.1664391629775;
        Wed, 28 Sep 2022 12:00:29 -0700 (PDT)
Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com. [209.85.160.50])
        by smtp.gmail.com with ESMTPSA id m7-20020a4a9507000000b00475f26931c8sm2280823ooi.13.2022.09.28.12.00.27
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Sep 2022 12:00:27 -0700 (PDT)
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-1319cf91d8aso4524004fac.5
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 12:00:27 -0700 (PDT)
X-Received: by 2002:a05:6870:c888:b0:12c:7f3b:d67d with SMTP id
 er8-20020a056870c88800b0012c7f3bd67dmr6575667oab.229.1664391627405; Wed, 28
 Sep 2022 12:00:27 -0700 (PDT)
MIME-Version: 1.0
References: <202209271333.10AE3E1D@keescook> <20220927210248.3950201-1-ndesaulniers@google.com>
 <a753c608-813a-f880-67ca-f16fe503b152@rasmusvillemoes.dk>
In-Reply-To: <a753c608-813a-f880-67ca-f16fe503b152@rasmusvillemoes.dk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 28 Sep 2022 12:00:11 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgFM3zjzWC44iPuRiAe9VYamU931nSGDCHQ8Q3B9087Wg@mail.gmail.com>
Message-ID: <CAHk-=wgFM3zjzWC44iPuRiAe9VYamU931nSGDCHQ8Q3B9087Wg@mail.gmail.com>
Subject: Re: [PATCH v3] x86, mem: move memmove to out of line assembler
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H . Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Kees Cook <keescook@chromium.org>,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        Andy Lutomirski <luto@kernel.org>
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

On Wed, Sep 28, 2022 at 12:24 AM Rasmus Villemoes
<linux@rasmusvillemoes.dk> wrote:
>
> > +     /*
> > +      * movs instruction have many startup latency
> > +      * so we handle small size by general register.
> > +      */
> > +     cmpl    $680, n
> > +     jb      .Ltoo_small_forwards
>
> OK, this I get, there's some overhead, and hence we need _some_ cutoff
> value; 680 is probably chosen by some trial-and-error, but the exact
> value likely doesn't matter too much.
>
> > +     /*
> > +      * movs instruction is only good for aligned case.
> > +      */
> > +     movl    src, tmp0
> > +     xorl    dest, tmp0
> > +     andl    $0xff, tmp0
> > +     jz      .Lforward_movs
>
> But this part I don't understand at all. This checks that the src and
> dest have the same %256 value, which is a rather odd thing,

Both of these checks basically reflect the time the original code was
added, back in 2011, and are basically "that was the "rep movs
implementation of the time".

Neither of them is very relevant today, and not the right way to check
anyway (ie FSRM should replace that test for 680 bytes etc).

But fixing the code to check the right things should probably be a
separate issue from the "move from inline asm to explicit asm", so I
think the patch is right this way.

                    Linus
