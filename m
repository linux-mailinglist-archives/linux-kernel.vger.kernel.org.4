Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF4C46DA615
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 01:09:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239426AbjDFXJm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 19:09:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239411AbjDFXJj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 19:09:39 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4DDB9ECC
        for <linux-kernel@vger.kernel.org>; Thu,  6 Apr 2023 16:09:37 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id d22-20020a17090a111600b0023d1b009f52so88065pja.2
        for <linux-kernel@vger.kernel.org>; Thu, 06 Apr 2023 16:09:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1680822577;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:subject:cc:to:from:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=yNpperMVoMjGe9P/2ZjLt4qAm5WmNOqgf9FRwnhU5yY=;
        b=BoVVuhpGsaWDgIhUoJKJ8LMVbXoLy7l490DOcO7JCwh6ZAlgfwSRVAHgYUuknWbX1u
         sMMAKyFSTNzK8Zp9rf3/68Fo3YDv8qlzsKpJsf5+RHt0jLINxttU1+6vBvSAWgR5y/l+
         YJqW1e/9kctB910imujLtuoqhv3RWB8RSpSfI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680822577;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:subject:cc:to:from:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yNpperMVoMjGe9P/2ZjLt4qAm5WmNOqgf9FRwnhU5yY=;
        b=y3Qr6j/0RFYzVRCzOtJ0EgnJKjoXttoSjiIcLI83dW3FmMM4PlHqiB5L+uLpdsG3R8
         t/UmxA2hsgoBiv1cB6ftTz3/Nxrr6i70CbaBZNjDBusAp5IqMpNB+2TL9q6bke/x7Qbo
         PYMRKm5vPRQjiBR0bQQQz4Ti4KUI5noyG1AyT9aLz7+fBcr4HdU7ChEkPFspxV8JcLJv
         UIc/Kw2jl26RxRh0ExhIXPhrPKiLiD6U3elobaPMtT4/sxtfl5nXWvnNH8BLEfbqX+1J
         CoCg+ceF/mZ79+ReaVb6QOSYMGfl/Qjl/JHuRBzy9lSwYBeoiYvX9jmw7u5sWF3Qu37O
         PALQ==
X-Gm-Message-State: AAQBX9eI9y5dsIm7nFNPorehzycnP07f5tXQo7OZpP88N/xgLmST0vbn
        AP8RY0Ei8VuGj5XwfKSv9ebKew==
X-Google-Smtp-Source: AKy350Y7EMNHpY8SCwxAMY9mxN3PXWxb8SWhW7shIy5yxuVgWWOlnRZriKL6TlCUKzrgmFWHbdPRRg==
X-Received: by 2002:a17:90b:17d1:b0:237:2edb:d4e3 with SMTP id me17-20020a17090b17d100b002372edbd4e3mr218072pjb.27.1680822577189;
        Thu, 06 Apr 2023 16:09:37 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id g8-20020a17090ace8800b00234e6d2de3dsm1627452pju.11.2023.04.06.16.09.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Apr 2023 16:09:36 -0700 (PDT)
Message-ID: <642f5130.170a0220.2a780.356a@mx.google.com>
X-Google-Original-Message-ID: <202304061608.@keescook>
Date:   Thu, 6 Apr 2023 16:09:36 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Daniel Latypov <dlatypov@google.com>
Cc:     linux-hardening@vger.kernel.org, Kees Cook <kees@outflux.net>,
        Andy Shevchenko <andy@kernel.org>,
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
        Nick Desaulniers <ndesaulniers@google.com>,
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
        =?iso-8859-1?Q?Jos=E9_Exp=F3sito?= <jose.exposito89@gmail.com>,
        linux-kernel@vger.kernel.org, kunit-dev@googlegroups.com
Subject: Re: [PATCH 2/9] fortify: Allow KUnit test to build without FORTIFY
References: <20230405235832.never.487-kees@kernel.org>
 <20230406000212.3442647-2-keescook@chromium.org>
 <CAGS_qxpk8WsPjN702nhQcEsK4yzzXZCc5n5cTVMSpwnVhCHSvA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGS_qxpk8WsPjN702nhQcEsK4yzzXZCc5n5cTVMSpwnVhCHSvA@mail.gmail.com>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 05, 2023 at 06:22:25PM -0700, Daniel Latypov wrote:
> On Wed, Apr 5, 2023 at 5:08 PM Kees Cook <keescook@chromium.org> wrote:
> > In order for CI systems to notice all the skipped tests related to
> > CONFIG_FORTIFY_SOURCE, allow the FORTIFY_SOURCE KUnit tests to build
> > with or without CONFIG_FORTIFY_SOURCE.
> 
> Hmm, I wonder if this warrants a deeper discussion.
> It's a lot easier to have tests get disabled by kconfig if their deps
> aren't met.

Yeah, I wasn't sure where to put the "kunit defconfig" settings.
"default.config" didn't seem to actually work as I was expecting. The
real "problem" I'm solving is that FORTIFY_SOURCE isn't in the standard
defconfig.

> If there's pressure to have them compiled and just get marked skipped,
> that sounds like that could be annoying.
> Esp. in the cases where more code needs to be put behind
> 
> #ifdef CONFIG_MY_DEP
> <test helpers, etc>
> #endif
> 
> But I have a suggestion below to simplify this a bit
> 
> >
> > Signed-off-by: Kees Cook <kees@outflux.net>
> > ---
> >  lib/Kconfig.debug   |  2 +-
> >  lib/fortify_kunit.c | 15 +++++++++++++++
> >  2 files changed, 16 insertions(+), 1 deletion(-)
> >
> > diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> > index c8b379e2e9ad..d48a5f4b471e 100644
> > --- a/lib/Kconfig.debug
> > +++ b/lib/Kconfig.debug
> > @@ -2614,7 +2614,7 @@ config STACKINIT_KUNIT_TEST
> >
> >  config FORTIFY_KUNIT_TEST
> >         tristate "Test fortified str*() and mem*() function internals at runtime" if !KUNIT_ALL_TESTS
> > -       depends on KUNIT && FORTIFY_SOURCE
> > +       depends on KUNIT
> >         default KUNIT_ALL_TESTS
> >         help
> >           Builds unit tests for checking internals of FORTIFY_SOURCE as used
> > diff --git a/lib/fortify_kunit.c b/lib/fortify_kunit.c
> > index c8c33cbaae9e..d054fc20a7d5 100644
> > --- a/lib/fortify_kunit.c
> > +++ b/lib/fortify_kunit.c
> > @@ -25,8 +25,21 @@ static const char array_of_10[] = "this is 10";
> >  static const char *ptr_of_11 = "this is 11!";
> >  static char array_unknown[] = "compiler thinks I might change";
> >
> > +/* Handle being built without CONFIG_FORTIFY_SOURCE */
> > +#ifndef __compiletime_strlen
> > +# define __compiletime_strlen __builtin_strlen
> > +#endif
> > +
> > +#define skip_without_fortify() \
> > +do {                           \
> > +       if (!IS_ENABLED(CONFIG_FORTIFY_SOURCE)) \
> > +               kunit_skip(test, "Not built with CONFIG_FORTIFY_SOURCE=y"); \
> > +} while (0)
> 
> Note: you can add an `init` function to the suite and skip the tests there.
> 
> static void fortify_init(struct kunit *test) {
>        if (!IS_ENABLED(CONFIG_FORTIFY_SOURCE))
>                kunit_skip(test, "Not built with CONFIG_FORTIFY_SOURCE=y");
> }
> 
> ...
>   static struct kunit_suite fortify_test_suite = {
>           .name = "fortify",
> +         .init = fortify_init,
>           .test_cases = fortify_test_cases,
>   };
> 
> That way we don't have to add it to each test case.

Ah! Excellent. I didn't realize it would have that effect. I will do
that. :)

-- 
Kees Cook
