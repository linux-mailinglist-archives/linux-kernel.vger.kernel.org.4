Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B249962543A
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 08:02:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232732AbiKKHCe convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 11 Nov 2022 02:02:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230075AbiKKHCd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 02:02:33 -0500
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4C1F77220
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 23:02:31 -0800 (PST)
Received: by mail-pj1-f44.google.com with SMTP id k5so3695300pjo.5
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 23:02:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fOUPI2HSi+pvD6Q+zBNwercPei7ZAzC0wrzHEy7HnN8=;
        b=J/AAYO53yTOgQgYqkUR/68IewgUddwY+GQh8zQoJtQ/e3dFwar9vnL5rRg3nlfg1Tw
         +IhHcF8jKtVueottYgbZAGgTf5FoFcWofyL1lgaijW+TXQCbu3icCK0V5hf7fgWJH2m4
         yGDh4l4Gx1O8/7dvvXnqpa9+EJZmnqIWDlchAxbYZ47l8PIh6YoYOb5OLO2IBB9xgrOj
         ngw925tiSHA3FwbLMsVxZZvwsw9Rs6uH6dN/a8wUL4WA9sOnoUImnUDjwtRirVi8rUFO
         utqTxUSqGeSUZCvFvksm4mDGalLZda8n91ZZNM6mI6IDFKjoO/04tkAqL7tulvJXhZJE
         Grzw==
X-Gm-Message-State: ANoB5pk35hZv6pwj4ErE+k79+gtfSMnv6xqUvUC+IrW0Tbw2WOXmwahi
        16nVNqXEMGS1t4MpXBYXJVeEYbBE7eUEzXU0Qq8=
X-Google-Smtp-Source: AA0mqf44hY4oy4yK+oBHgzJpJaRLRF7tiuLNug/OgdxFe5ZpSsyu8v23Ye5hX4Sd3WmRiwNRal6WtKvNr0JAVNuhQzM=
X-Received: by 2002:a17:902:b609:b0:186:ac81:2aa9 with SMTP id
 b9-20020a170902b60900b00186ac812aa9mr1335007pls.95.1668150151316; Thu, 10 Nov
 2022 23:02:31 -0800 (PST)
MIME-Version: 1.0
References: <20221106095106.849154-1-mailhol.vincent@wanadoo.fr>
 <20221106095106.849154-3-mailhol.vincent@wanadoo.fr> <CAKwvOdmN2==9tG0fxRO8K-eAJudeemaKUuhJEAuGHc=P8GpGwA@mail.gmail.com>
 <CAMZ6RqKRP3cp=FhpA6DkKNKjgRV2ak18k=Ad-mnBPkT++gARCA@mail.gmail.com> <Y23DIRG60iaei7Ft@yury-laptop>
In-Reply-To: <Y23DIRG60iaei7Ft@yury-laptop>
From:   Vincent MAILHOL <mailhol.vincent@wanadoo.fr>
Date:   Fri, 11 Nov 2022 16:02:20 +0900
Message-ID: <CAMZ6Rq+qm=hVdWw=MSgBJ2qLbkCxG10v5yUH7hpGDOvq2QBOuA@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] x86/asm/bitops: Use __builtin_clz*() to evaluate
 constant expressions
To:     Yury Norov <yury.norov@gmail.com>
Cc:     Nick Desaulniers <ndesaulniers@google.com>, x86@kernel.org,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        Borislav Petkov <bp@suse.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri. 11 nov. 2022 à 12:36, Yury Norov <yury.norov@gmail.com> a écrit :
> On Fri, Nov 11, 2022 at 10:57:17AM +0900, Vincent MAILHOL wrote:
> > On Fri. 11 Nov. 2022 at 04:01, Nick Desaulniers <ndesaulniers@google.com> wrote:
> > > On Sun, Nov 6, 2022 at 1:51 AM Vincent Mailhol
> > > <mailhol.vincent@wanadoo.fr> wrote:
> > > >
> > > >  #ifdef CONFIG_X86_64
> > > > -static __always_inline int fls64(__u64 x)
> > > > +static __always_inline int constant_fls64(u64 x)
> > > > +{
> > > > +       BUILD_BUG_ON(sizeof(unsigned long long) != sizeof(x));
> > >
> > > Thanks for the patches! They LGTM; but why do we need this BUILD_BUG_ON here?
> >
> > There is no absolute need for sure.
> >
> > Call this a paranoiac check and you will be correct. My reasoning for still
> > using it is that:
> >
> >   1/ It is a compile time check, so no runtime penalty.
> >   2/ Strictly speaking, the C standard doesn't guarantee 'u64' and
> >      'unsigned long long int' to be the same (and you can argue that in clang
> >      and gcc long long is always 64 bits on all platforms and one more time
> >      you will be correct).
> >   3/ It serves as a documentation to say: "hey I am using the clz long long
> >      version on a u64 and I know what I am doing."
> >
> > If you want me to remove it, OK for me. Let me know.
>
> In fact, compiler's typecheck would be more strict than your BUG().
> For example, your check allows pointers, but compiler will complain.

Here, x is a scalar, so in that specific case, it is equivalent. But
the compiler type check is more explicit and more natural because it
would work if ported to other contexts as you pointed. So it is a good
idea.

The check would become:
        static_assert(__builtin_types_compatible_p(typeof(x),
                                                   unsigned long long int));

Alternatively, we could use the assert_arg_type() macro from
https://elixir.bootlin.com/linux/latest/source/arch/x86/include/asm/irq_stack.h#L126
which does exactly the same thing.

But in such a case, it would be better to first move assert_arg_type()
to a more appropriate header (maybe linux/build_bug.h ?)


Yours sincerely,
Vincent Mailhol
