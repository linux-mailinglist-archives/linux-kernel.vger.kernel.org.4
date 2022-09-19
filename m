Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 376885BD0D3
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 17:25:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230251AbiISPYt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 11:24:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229816AbiISPYR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 11:24:17 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C032DF2A
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 08:23:22 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id f9so46788151lfr.3
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 08:23:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=q9xkDIjHbOek3ToR7rP6kThR2hXoiK0Z+zPNyyWXldI=;
        b=VFeLln+8hfrk+UCqDM3rC2Tcxol5UvQSbMpRJu8tOMfIvifyp+XI0nKGxG6tCqcu7t
         kVYWtb5lEtXTdFP5egBTmJnhImpg2/RAylhbKVfUaR3614Sl/NBAOZ1Xg7Jfw4SPoddU
         ReXqC/2IMelXCKlquAeEunjDpKhaLJYWFYcjI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=q9xkDIjHbOek3ToR7rP6kThR2hXoiK0Z+zPNyyWXldI=;
        b=nDH2CYI1clDFB9mHb2v60Nu5U34xXTvSxwtzYlHfBuN0yYoELEkWrXravv1z/X35UM
         IhBcS+rrx9O9u8Vpv7czm8K76O3+PWK6KjVT7BxffpgLxSGbgFlMvhvfTTFAUj6GtQ2u
         CiWxF15wWGYnIZyWJKtSCoZAyQwHAMv6mroVHGPUElUsEbPm2yGcNXLl3h43VgqJNUrj
         T+xmTle8dt6L+YOsuJRCJWjLmGMMAw7+ZQnNW9ZUhtHhFxeh8fkEqt+yi7cJAAB21NLy
         XHob9TESv/dFgc/HI/82pnHnpZFYLG4FQBwOoeW9JeWHET0uaXbj9FDhpj9QJqvSobe+
         A7lg==
X-Gm-Message-State: ACrzQf2Fq00Xrg2hrvVPQ4NC/Z4eXxCobNjYETVmF2B+NuAQiuhmRo1v
        IoI0qFSkAq29aM+aqwswGSoSfiFBgifMNhQu
X-Google-Smtp-Source: AMsMyM6KM0WfkqnkE3p+RH+95VVlhcDPaHhR6NtjUjCChv9lbNyF3SKVbTB5CoiAFOdrJmHBShAUog==
X-Received: by 2002:a19:7619:0:b0:49f:6cd7:45c2 with SMTP id c25-20020a197619000000b0049f6cd745c2mr3948569lff.7.1663600999205;
        Mon, 19 Sep 2022 08:23:19 -0700 (PDT)
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com. [209.85.208.177])
        by smtp.gmail.com with ESMTPSA id k2-20020a05651239c200b00499cf3e3edcsm5063863lfu.296.2022.09.19.08.23.17
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Sep 2022 08:23:18 -0700 (PDT)
Received: by mail-lj1-f177.google.com with SMTP id l12so34278440ljg.9
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 08:23:17 -0700 (PDT)
X-Received: by 2002:a05:651c:160b:b0:26c:252a:91a5 with SMTP id
 f11-20020a05651c160b00b0026c252a91a5mr5152641ljq.266.1663600997349; Mon, 19
 Sep 2022 08:23:17 -0700 (PDT)
MIME-Version: 1.0
References: <20220915020730.852234-1-yury.norov@gmail.com> <20220915020730.852234-4-yury.norov@gmail.com>
 <YyhykvFCOskPAp59@smile.fi.intel.com>
In-Reply-To: <YyhykvFCOskPAp59@smile.fi.intel.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 19 Sep 2022 08:23:00 -0700
X-Gmail-Original-Message-ID: <CAHk-=whELT9vVs+K1KqkySz+6LL21t7TqQXM_VWmrgGXancUHQ@mail.gmail.com>
Message-ID: <CAHk-=whELT9vVs+K1KqkySz+6LL21t7TqQXM_VWmrgGXancUHQ@mail.gmail.com>
Subject: Re: [PATCH v4 3/4] lib/find_bit: optimize find_next_bit() functions
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Yury Norov <yury.norov@gmail.com>, linux-kernel@vger.kernel.org,
        Alexey Klimov <klimov.linux@gmail.com>,
        Andy Whitcroft <apw@canonical.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        David Laight <David.Laight@aculab.com>,
        Dennis Zhou <dennis@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Kees Cook <keescook@chromium.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Valentin Schneider <vschneid@redhat.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Russell King <linux@armlinux.org.uk>
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

On Mon, Sep 19, 2022 at 6:46 AM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> > +#define FIND_NEXT_BIT(FETCH, MUNGE, size, start)                             \
> > +({                                                                           \
[..]
> > +out:                                                                         \
>
> I dunno if GCC expression limits the scope of goto labels

No. Labels are function-global by default. If you need block-scope for
them, you need to declare them explicitly in tha block before use with
"__label__".

> but on the safe side you can add a prefix to it, so it becomes:
>
> FIND_NEXT_BIT_out:

That doesn't really help, since if you were to use the macro twice,
you'd still get a name clash.

That said, I'm not convinced any of this matters, since these macros
aren't supposed to be used anywhere else, and in fact, they aren't
even in any header file that would allow anybody else to use them.

So I think all the normal "make macros safe" rules are simply
irrelevant for these cases - despite the readable name, these macros
are local special cases for code generation and avoiding duplication,
not generic "use this macro to find a bit".

So it's one thing if a macro is in a header file to be used by random
code. It's a different thing entirely if it's a specialized local
macro for a local issue, that nobody else is ever going to even see.

So I don't think it would be wrong to use __label__ to block-scope it,
or to use a longer name, but I also don't think it's really required.

It's not exactly super-common, but we have various cases of macros
that generate full (or partial) function bodies in various places,
where the macro does various things that should *never* be done in a
"regular" macro that gets used by normal code.

You can see one class of this with something like

   git grep '^static.*##.*(.*\\$' -- '*.c'

but to *really* go blind, see the "SYSCALL_DEFINE*()" macros in
<linux/syscalls.h>.

Those will mess with your mind, and go "whoever wrote those macros
needs to be institutionalized". They do some impressive things,
including creating local functions _and_ starting a new function
definition where the actual code then isn't part of the macro, but
actually just continues where the macro was used.

Which is all very natural and actually looks quite nice and readable
in the places that use it, with users looking like

  SYSCALL_DEFINE2(pidfd_open, pid_t, pid, unsigned int, flags)
  {
        int fd;
        struct pid *p;
   ...

which is all pretty legible. But there's no question that that macro
violates every single "normal" macro rule.

The FIND_NEXT_BIT() macro in comparison is pretty tame.

                  Linus
