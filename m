Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63B6E624A86
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 20:20:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231298AbiKJTUr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 14:20:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230419AbiKJTUf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 14:20:35 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E2A97655
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 11:20:34 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id u8-20020a17090a5e4800b002106dcdd4a0so5729313pji.1
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 11:20:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=LYUlAFrEbyfFRH8XQ1Az8G9RGqh1QwMuiz/dtiN8PUg=;
        b=MvSKq5bWzN6iI6UuSuvm3YAvtXT6zn4H/yiJ0PhNblomXhHUUyQldLaOMl2hmiAtht
         4vTn1j1nCgmB/NkMlukrZlBS3ZB/lfBNG3BlcSF60mBiwodPbcZpMjcgGHuVY4mPlFT2
         TyuDzxEYUER8BlVVv3iTIuVsfQT1NI8YxRMHfEY2R5US3B8GkY/Pr799VJ8WMdYFW6Zu
         HJnL15REFVmPMtRTs//d7N8ohJElai+hUgNkU/n1y+J6SEDN08H14BoV1KjPjjp9ckxD
         cQBy5KnSlVKwyIVqM0aS6eDnWSz3aHezbDv7CTDMrGtthSf1y0WSLptxj48xn9Gekhsn
         S+JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LYUlAFrEbyfFRH8XQ1Az8G9RGqh1QwMuiz/dtiN8PUg=;
        b=x7twaLdbKLeQAZcFKMJAnbLX2UFNUQK5RUirVg1ywMFjysQGUOrAhdC7X0Yxgm3TW9
         8gquT3tdAvb0FCDE/23qAUI5pLkX9LZktHm44Idyr2NeIaJ1Neg4354bPw+n92rdxZaQ
         dr1VaZuSE2ik3QZsIpIgP3H4mK9sPnNag7exeZEvUg+hkHUlaeQAu0Rk81Kp3FO2kBte
         Zl+x7PWMY5MY0rmeqciUp0OgucjcsrfEO+9g+buOM+EhUTnsuxHP7TmTvWGqBtePyhB0
         kCEXXTatYXqpX3foj9h7yHxkFRjL7dCWEqPpPzZ+cM7XF0jFyNdx9qCDq5n4ljvOc6uv
         xQ0g==
X-Gm-Message-State: ACrzQf3iruy/ZkJKJ26+nEKrLOcgHcUuexfeMeJEuhGemshx2nbBprfz
        6bYSsf/0u2g8TgDjIHpYeklqXaROMfwIbM+kfN5ljg==
X-Google-Smtp-Source: AMsMyM5hSSiWzErPvPA3UO7DgFkaf9f2Sepd2Zbsy5SC5dhC3RtgvlDO+Mh+fydAA//KMHRn8zV04d2f8ftKVmlnZsE=
X-Received: by 2002:a17:902:7b98:b0:186:8558:ded2 with SMTP id
 w24-20020a1709027b9800b001868558ded2mr1798574pll.95.1668108033739; Thu, 10
 Nov 2022 11:20:33 -0800 (PST)
MIME-Version: 1.0
References: <20221106095106.849154-1-mailhol.vincent@wanadoo.fr>
 <20221106095106.849154-2-mailhol.vincent@wanadoo.fr> <Y2jSMz4GtXGJk6rS@hirez.programming.kicks-ass.net>
In-Reply-To: <Y2jSMz4GtXGJk6rS@hirez.programming.kicks-ass.net>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 10 Nov 2022 11:20:21 -0800
Message-ID: <CAKwvOdnDi9GmLL8iRDe1-LEnpbFWFPAsPqB5PWpnpGK8+0rYAw@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] x86/asm/bitops: Replace __fls() by its generic
 builtin implementation
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Vincent Mailhol <mailhol.vincent@wanadoo.fr>, x86@kernel.org,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, Yury Norov <yury.norov@gmail.com>,
        llvm@lists.linux.dev, Borislav Petkov <bp@suse.de>
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

On Mon, Nov 7, 2022 at 1:39 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Sun, Nov 06, 2022 at 06:51:05PM +0900, Vincent Mailhol wrote:
> > The builtin implementation is better for two reasons:
> >
> >   1/ it saves two instructions on clang (a push and a stack pointer
> >      decrement) because of a useless tentative to save rax.
>
> I'm thinking this is the same old clang-sucks-at-"rm" constraints and
> *really* should not be a reason to change things. Clang should get fixed
> already.

Well messing up constant folding for all compilers absolutely should
be a reason!

I did get a chance to speak with some colleagues more about this at
the LLVM developer meeting during the past 2 days.  We have some ideas
on approaches that might work.  There's some higher priority features
we're working on first, but I suspect we'll be able to visit that
issue soon.  It's a pretty tricky dance between instruction selection
and register allocation.

>
> >   2/ when used on constant expressions, the compiler is only able to
> >      fold the builtin version (c.f. [2]).
> >
> > For those two reasons, replace the assembly implementation by its
> > builtin counterpart.
> >
> > [1] https://elixir.bootlin.com/linux/v6.0/source/include/asm-generic/bitops/builtin-__fls.h
> >
> > [2] commit 146034fed6ee ("x86/asm/bitops: Use __builtin_ffs() to evaluate constant expressions")
>
> I would much prefer consistently with 146034fed6ee.

The bottom of this file arch/x86/include/asm/bitops.h is full of
#include <asm-generic/bitops/*.h>

-- 
Thanks,
~Nick Desaulniers
