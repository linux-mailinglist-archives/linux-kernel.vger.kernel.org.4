Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06204705955
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 23:15:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230373AbjEPVPG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 17:15:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229649AbjEPVPE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 17:15:04 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 317B9121
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 14:15:03 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-1ae4baa77b2so966065ad.2
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 14:15:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1684271702; x=1686863702;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=VR8MPIIli3X+0w90ArGaOIS0O6gxUxvBWBFob2QExGc=;
        b=JJwxsdvpGVs+0EDt8UAqXDXYtojAG1dm4ioe8n6I0DrFJNG3f5T3C2Goe+40f9qRww
         HfTuWYu2HxNDdflU3a4vvlaSZPMPqGgVyR/M6WsxnrRMEZQpZz2WdczB50mowo/Z4Sr8
         d2K+oxvKCkAXkRhu9lD0TwUQ7YczXF7ahWqAw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684271702; x=1686863702;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VR8MPIIli3X+0w90ArGaOIS0O6gxUxvBWBFob2QExGc=;
        b=AloVpCa6Gxa6FkG7pfwCdrVVuebTMLs+Nq6qXLf4qHZuhme7QhyN6EResA+QEHsTKO
         QnmHOrEydzaGezvZdalbbbNLA80YC3EmI4+q+DTFiM+qnx9ODjCOX+BudazlpMnL1M8S
         mlIfaat9uHjpu01V9rztafoUKiR6eRCjOF1KxZeJP/E9OzzNrNHiF6mq0ixK/H46wDuU
         9Iy8HGwD7MsjygwALMsO8SN8yQ1Ew6nCJqXLsIJaBmoIkyJk7uq/sMEwoR6AXs2NuNGC
         grrOFWYFeCzWDo2zViZfuZsaEXO+VjDAgiQs2JQIbRut0J6v2ItZ6zcf8YomjPAbIAGl
         Ej5Q==
X-Gm-Message-State: AC+VfDx9U13Bm5NCcNrooRXQuqJm2SDLMwy26iHRhdZF/Mh+Icnqwe8D
        FIXuygtfALrQZsZEFNfOAgjY7A==
X-Google-Smtp-Source: ACHHUZ4PKGsOzYGNj1xP8rBaXRc7Tbpy5DWOQDAbTOANvxwCCYpLYpIyW0kqSB8gjnlHTa+N6IWdUg==
X-Received: by 2002:a17:903:2405:b0:1a6:4b60:3195 with SMTP id e5-20020a170903240500b001a64b603195mr45748542plo.66.1684271702592;
        Tue, 16 May 2023 14:15:02 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id h4-20020a170902704400b001aaf370b1c7sm15894501plt.278.2023.05.16.14.15.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 May 2023 14:15:02 -0700 (PDT)
Date:   Tue, 16 May 2023 14:15:01 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     linux-hardening@vger.kernel.org, Andy Shevchenko <andy@kernel.org>,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        Puyou Lu <puyou.lu@gmail.com>, Mark Brown <broonie@kernel.org>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Brendan Higgins <brendan.higgins@linux.dev>,
        David Gow <davidgow@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Alexander Potapenko <glider@google.com>,
        Zhaoyang Huang <zhaoyang.huang@unisoc.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Miguel Ojeda <ojeda@kernel.org>,
        Alexander Lobakin <aleksander.lobakin@intel.com>,
        Liam Howlett <liam.howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Dan Williams <dan.j.williams@intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Yury Norov <yury.norov@gmail.com>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Sander Vanheule <sander@svanheule.net>,
        Eric Biggers <ebiggers@google.com>,
        "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Daniel Latypov <dlatypov@google.com>,
        =?iso-8859-1?Q?Jos=E9_Exp=F3sito?= <jose.exposito89@gmail.com>,
        linux-kernel@vger.kernel.org, kunit-dev@googlegroups.com
Subject: Re: [PATCH v2 06/10] fortify: strcat: Move definition to use
 fortified strlcat()
Message-ID: <202305161411.C0ED6E86F4@keescook>
References: <20230407191904.gonna.522-kees@kernel.org>
 <20230407192717.636137-6-keescook@chromium.org>
 <CAKwvOdk+CT6S6LjLb2aRVsMSgnsyHRcoT-yyifNTW8vVVwTA-A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKwvOdk+CT6S6LjLb2aRVsMSgnsyHRcoT-yyifNTW8vVVwTA-A@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 18, 2023 at 11:09:41AM -0700, Nick Desaulniers wrote:
> On Fri, Apr 7, 2023 at 12:27 PM Kees Cook <keescook@chromium.org> wrote:
> >
> > Move the definition of fortified strcat() to after strlcat() to use it
> > for bounds checking.
> >
> > Signed-off-by: Kees Cook <keescook@chromium.org>
> > ---
> >  include/linux/fortify-string.h | 53 +++++++++++++++++-----------------
> >  1 file changed, 26 insertions(+), 27 deletions(-)
> >
> > diff --git a/include/linux/fortify-string.h b/include/linux/fortify-string.h
> > index 8cf17ef81905..ab058d092817 100644
> > --- a/include/linux/fortify-string.h
> > +++ b/include/linux/fortify-string.h
> > @@ -151,33 +151,6 @@ char *strncpy(char * const POS p, const char *q, __kernel_size_t size)
> >         return __underlying_strncpy(p, q, size);
> >  }
> >
> > -/**
> > - * strcat - Append a string to an existing string
> > - *
> > - * @p: pointer to NUL-terminated string to append to
> > - * @q: pointer to NUL-terminated source string to append from
> > - *
> > - * Do not use this function. While FORTIFY_SOURCE tries to avoid
> > - * read and write overflows, this is only possible when the
> > - * destination buffer size is known to the compiler. Prefer
> > - * building the string with formatting, via scnprintf() or similar.
> > - * At the very least, use strncat().
> > - *
> > - * Returns @p.
> > - *
> > - */
> > -__FORTIFY_INLINE __diagnose_as(__builtin_strcat, 1, 2)
> > -char *strcat(char * const POS p, const char *q)
> > -{
> > -       const size_t p_size = __member_size(p);
> > -
> > -       if (p_size == SIZE_MAX)
> > -               return __underlying_strcat(p, q);
> > -       if (strlcat(p, q, p_size) >= p_size)
> > -               fortify_panic(__func__);
> > -       return p;
> > -}
> > -
> >  extern __kernel_size_t __real_strnlen(const char *, __kernel_size_t) __RENAME(strnlen);
> >  /**
> >   * strnlen - Return bounded count of characters in a NUL-terminated string
> > @@ -435,6 +408,32 @@ size_t strlcat(char * const POS p, const char * const POS q, size_t avail)
> >         return wanted;
> >  }
> >
> > +/* Defined after fortified strlcat() to reuse it. */
> 
> I don't follow; the previous location was already defined in terms of
> calls to strlcat.  Why is this patch necessary?
> 
> Could this be fixed in 5/10
> https://lore.kernel.org/linux-hardening/20230407192717.636137-5-keescook@chromium.org/
> by just putting strlcat in the expected place in the first place?

I wanted to collect all the str*cat functions together.

> > +/**
> > + * strcat - Append a string to an existing string
> > + *
> > + * @p: pointer to NUL-terminated string to append to
> > + * @q: pointer to NUL-terminated source string to append from
> > + *
> > + * Do not use this function. While FORTIFY_SOURCE tries to avoid
> > + * read and write overflows, this is only possible when the
> > + * destination buffer size is known to the compiler. Prefer
> > + * building the string with formatting, via scnprintf() or similar.
> > + * At the very least, use strncat().
> > + *
> > + * Returns @p.
> > + *
> > + */
> > +__FORTIFY_INLINE __diagnose_as(__builtin_strcat, 1, 2)
> > +char *strcat(char * const POS p, const char *q)
> > +{
> > +       const size_t p_size = __member_size(p);
> > +
> 
> This drops the `p_size == SIZE_MAX` guard.  Might it be faster at
> runtime to dispatch to __underlying_strcat rather than __real_strlcat
> in such cases?

I wanted to avoid repeating the same checks, so since strlcat() already
does the right checking, I avoided repeating it here.

> What's the convention for __underlying_ vs __real_ prefixes in
> include/linux/fortify-string.h?

__underlying may be wrapped by K*SAN before being implemented via
__builtin, where as __real is used for things that aren't wrapped and/or
aren't available with a __builtin (e.g. strscpy).

-- 
Kees Cook
