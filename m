Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E60D6798EA
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 14:08:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233889AbjAXNIO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 08:08:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232763AbjAXNIM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 08:08:12 -0500
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7670FF773;
        Tue, 24 Jan 2023 05:08:07 -0800 (PST)
Received: by mail-yb1-f174.google.com with SMTP id b1so13433385ybn.11;
        Tue, 24 Jan 2023 05:08:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UML2OHNxNDQ9md4fQq5mqL7oQYuWIRD223SWI0gFk9k=;
        b=Qx0IGQb3SqoCOnGGiWFeTwGi7624pqW90NnwzRgPUlWed8ABGEwY92/lLwShmsC1tu
         kF433dyx7rF7c89W23025gawmXLQVYYWE+RP3S8a7N5k0iVhU62nd04nbMG+7Wdrxjiz
         nY7jXLSg43XjctQXbzcEPgfszXPsHDO0fWtP0o1JKARu7OHdhSjM/lVYz5GBIIYGYUh/
         eOp56XiJJtFjIiGBriB+vd32SlWW0wtH8KJ1e++smArYpbKepT58dDn775wHCnNuZpNL
         F8ztwuY7EAJ4zOUyrQX9Rw8JNdBUYmvtfRL3xYzXB8ueC5fa8bK+lV2Dqt+nXp/p3rBN
         cE0g==
X-Gm-Message-State: AFqh2kosyeXvsyxxOZHfjfhbdiV1yb32F7luGXSXoJlVhG0Z/fGPY/Dz
        NHg88+x6srHDeMcVIj6lK3+plqtJjP7oAA==
X-Google-Smtp-Source: AMrXdXuZ/v6k5UNu3LD+be+Z/RsgES8CMlBADR0ldOYIbc0Q+NRZrI+nQg0zhvpgskp7DMLA6aK+sA==
X-Received: by 2002:a25:4602:0:b0:7f6:e722:ad12 with SMTP id t2-20020a254602000000b007f6e722ad12mr13255890yba.7.1674565686481;
        Tue, 24 Jan 2023 05:08:06 -0800 (PST)
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com. [209.85.219.174])
        by smtp.gmail.com with ESMTPSA id a69-20020ae9e848000000b006ce580c2663sm1397065qkg.35.2023.01.24.05.08.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Jan 2023 05:08:06 -0800 (PST)
Received: by mail-yb1-f174.google.com with SMTP id 123so18692257ybv.6;
        Tue, 24 Jan 2023 05:08:05 -0800 (PST)
X-Received: by 2002:a25:9801:0:b0:7d5:b884:3617 with SMTP id
 a1-20020a259801000000b007d5b8843617mr2485821ybo.380.1674565685630; Tue, 24
 Jan 2023 05:08:05 -0800 (PST)
MIME-Version: 1.0
References: <b41ea008-d9c4-fd76-a5ce-00fe435deed5@mkarcher.dialup.fu-berlin.de>
 <f540c26e-baa8-5c18-9502-622a4091b675@infradead.org>
In-Reply-To: <f540c26e-baa8-5c18-9502-622a4091b675@infradead.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 24 Jan 2023 14:07:54 +0100
X-Gmail-Original-Message-ID: <CAMuHMdUUq0FLmsRPw122My7tOUyRLJxsEKOSFgtfG3ec5OiyKQ@mail.gmail.com>
Message-ID: <CAMuHMdUUq0FLmsRPw122My7tOUyRLJxsEKOSFgtfG3ec5OiyKQ@mail.gmail.com>
Subject: Re: [PATCH v4 1/1] arch/sh: avoid spurious sizeof-pointer-div warning
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Michael Karcher <kernel@mkarcher.dialup.fu-berlin.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-sh list <linux-sh@vger.kernel.org>,
        Segher Boessenkool <segher@kernel.crashing.org>,
        Rich Felker <dalias@libc.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 23, 2023 at 8:40 PM Randy Dunlap <rdunlap@infradead.org> wrote:
> I'm curious how you generated this patch.
> 'patch' complains:
>
> patch: **** malformed patch at line 53:                prio_regs,    sense_regs, ack_regs)    \
>
> (more below)
>
> On 1/23/23 10:48, Michael Karcher wrote:
> > Gcc warns about the pattern sizeof(void*)/sizeof(void), as it looks like
> > the abuse of a pattern to calculate the array size. This pattern appears
> > in the unevaluated part of the ternary operator in _INTC_ARRAY if the
> > parameter is NULL.
> >
> > The replacement uses an alternate approach to return 0 in case of NULL
> > which does not generate the pattern sizeof(void*)/sizeof(void), but still
> > emits the warning if _INTC_ARRAY is called with a nonarray parameter.
> >
> > This patch is required for successful compilation with -Werror enabled.
> >
> > The idea to use _Generic for type distinction is taken from Comment #7
> > in https://gcc.gnu.org/bugzilla/show_bug.cgi?id=108483 by Jakub Jelinek
> >
> > Signed-off-by: Michael Karcher <kernel@mkarcher.dialup.fu-berlin.de>
> > ---
> > This edition of the mail has the correct "v4" designation in the subject.
> >
> > History:
> > v4:
> >   - Put the case distinction into the numerator instead of the denominator
> >   - Refactor the case disctinction into a second macro
> > v3:
> >   - I had a stern discussion with Thunderbird about not mangling the
> >     space characters in my email, and I hope spaces get sent as standard
> >     spaces now
> > v2:
> >   - improve title and remove mostly redundant first sentence of the
> >     description
> >   - adjust formatting of the _Generic construction
> >
> > diff --git a/include/linux/sh_intc.h b/include/linux/sh_intc.h
> > index c255273b0281..98d1da0d8e36 100644
> > --- a/include/linux/sh_intc.h
> > +++ b/include/linux/sh_intc.h
> > @@ -97,7 +97,9 @@ struct intc_hw_desc {
>
> That ,9 should be ,10.

Indeed.

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>

Note that I didn't receive v5 (neither did lore), only Adrian's reply.

> > -#define _INTC_ARRAY(a) a, __same_type(a, NULL) ? 0 : sizeof(a)/sizeof(*a)
> > +#define _INTC_SIZEOF_OR_ZERO(a) (_Generic(a,                 \
> > +                                 typeof(NULL):  0,           \
> > +                                 default:       sizeof(a)))

_INTC_SIZEOF_OR_ZERO() might be useful in general.

> > +#define _INTC_ARRAY(a) a, _INTC_SIZEOF_OR_ZERO(a)/sizeof(*a)
> >
> >  #define INTC_HW_DESC(vectors, groups, mask_regs,    \
> >               prio_regs,    sense_regs, ack_regs)    \

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
