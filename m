Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 037316DA611
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 01:07:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237453AbjDFXHm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 19:07:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229604AbjDFXHj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 19:07:39 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D46B99754
        for <linux-kernel@vger.kernel.org>; Thu,  6 Apr 2023 16:07:37 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id ix20so38800493plb.3
        for <linux-kernel@vger.kernel.org>; Thu, 06 Apr 2023 16:07:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1680822457;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ftgRsIRurrmlei9zUcdBf7zAoeZBAD6u0Ofdt2c7jnY=;
        b=gDI/38A0QEyvcJdTvryj/RlJjLyzOWuva3RsRYFTi8qUyOfx3nw3R7QznN+qkPY4XZ
         ccBxZVG2TeyU8kWTP7Vl9hXvSEQksG56WepXqoO1fxxRZMOCyOw95mzWHTagFgyfM91G
         084RlrL1xam833IRUiHKAMotebiV1mYW32ypw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680822457;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ftgRsIRurrmlei9zUcdBf7zAoeZBAD6u0Ofdt2c7jnY=;
        b=XjpHHcS9XEItZH9w17TpEb9wn328ba1/VPPSyicQ1IJxNuiUVAcIin6WrhqydKoNEr
         cppOUlSnl74UoznWDXTrVXFXd47riQkD+4gt8HcCH0RKbLJXqICN8Zw9usSrCwZfjBf1
         XzFlpJlTsax4KhGiRhpl0/tFGLtLrbswZ/7LgdE0crwkKuv5ECSODpurP2/mJn1I89CD
         Xc2dZFY015yeNJ41oWUq8HpBev1cr0kZqWVeUaH10Hlyu4CBph2lMjTb29RFb6P/c5+P
         McwfDJ90u1aQxC3XZS1GtguiXCdbq/Y0J0Qc//YtRHhPYlVaKAtrPiMM2CjduGtHiJcj
         Evsg==
X-Gm-Message-State: AAQBX9eZpW8GWICBW0Fcf16MoXAthW2xjjvCFcUKcvXgZu3/hj1Mu9m0
        afTc4l28A2uEAjmJH6pHSfddYw==
X-Google-Smtp-Source: AKy350aDCdI3xpZAS/LyiI5Pa/nh6KeIByrtcQXya3W6Z/vwPJpRvLBF4YpbooBaSix0ke9dKSmyuw==
X-Received: by 2002:a17:90b:1c88:b0:23f:9439:9a27 with SMTP id oo8-20020a17090b1c8800b0023f94399a27mr261706pjb.20.1680822457326;
        Thu, 06 Apr 2023 16:07:37 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id nn12-20020a17090b38cc00b00231224439c1sm3605704pjb.27.2023.04.06.16.07.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Apr 2023 16:07:36 -0700 (PDT)
Message-ID: <642f50b8.170a0220.95ab9.859f@mx.google.com>
X-Google-Original-Message-ID: <202304061602.@keescook>
Date:   Thu, 6 Apr 2023 16:07:35 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Alexander Potapenko <glider@google.com>
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
        Daniel Latypov <dlatypov@google.com>,
        =?iso-8859-1?Q?Jos=E9_Exp=F3sito?= <jose.exposito89@gmail.com>,
        linux-kernel@vger.kernel.org, kunit-dev@googlegroups.com
Subject: Re: [PATCH 3/9] string: Add Kunit tests for strcat() family
References: <20230405235832.never.487-kees@kernel.org>
 <20230406000212.3442647-3-keescook@chromium.org>
 <CAG_fn=V-3yxPihQdt+OJuOfF6sBuNvQ2OQfYNZak1xbx6viU2w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAG_fn=V-3yxPihQdt+OJuOfF6sBuNvQ2OQfYNZak1xbx6viU2w@mail.gmail.com>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 06, 2023 at 11:11:09AM +0200, Alexander Potapenko wrote:
> > +static void strncat_test(struct kunit *test)
> > +{
> > +       char dest[8];
> > +
> > +       /* Destination is terminated. */
> > +       memset(dest, 0, sizeof(dest));
> > +       KUNIT_EXPECT_EQ(test, strlen(dest), 0);
> > +       /* Empty copy of size 0 does nothing. */
> > +       KUNIT_EXPECT_TRUE(test, strncat(dest, "", 0) == dest);
> > +       KUNIT_EXPECT_STREQ(test, dest, "");
> > +       /* Empty copy of size 1 does nothing too. */
> > +       KUNIT_EXPECT_TRUE(test, strncat(dest, "", 1) == dest);
> > +       KUNIT_EXPECT_STREQ(test, dest, "");
> > +       /* Copy of max 0 characters should do nothing. */
> > +       KUNIT_EXPECT_TRUE(test, strncat(dest, "asdf", 0) == dest);
> > +       KUNIT_EXPECT_STREQ(test, dest, "");
> > +
> > +       /* 4 characters copied in, even if max is 8. */
> > +       KUNIT_EXPECT_TRUE(test, strncat(dest, "four\000123", 8) == dest);
> > +       KUNIT_EXPECT_STREQ(test, dest, "four");
> > +       KUNIT_EXPECT_EQ(test, dest[5], '\0');
> 
> Maybe also add a test case for strncat(dest, "four", 4) that checks
> that the fourth byte of dest is not 0?

I think I don't understand what state you want to test for? The line
above (STREQ is checking dest is "four". Maybe I should check for
dest[6] being 0 as well as dest[5]. But if that's not what you mean, I'm
not sure. Is it something here:

char dest[16];
memset(dest, 0, sizeof(dest));
// dest == ""
strncat(dest, "four", 4);
// dest == "four"
strncat(dest, "four", 4);
// dest == "fourfour"

strncat's "n" is how much to reach from source -- dest will always be
terminated.

-- 
Kees Cook
