Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AE07746382
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 21:47:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230472AbjGCTrU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 15:47:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230032AbjGCTrS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 15:47:18 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB7C4E70
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jul 2023 12:47:08 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-66872d4a141so2867169b3a.1
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jul 2023 12:47:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1688413628; x=1691005628;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=3tIZB00K/5DyFOSj72DNhfsbX4trIet39LY1NrmW8Vw=;
        b=AkpyuutSLbeUjtbZF+QmadDfTbhq/EuiSh//1Up5pIfPVr+I8c84RSjjKLRl4P5kT5
         bs3Lu14sC+zBkSYbKvj6g1LHxz1HuoYxTXJnov78sDj1v05OZb1t985LBXDNVKvZx0vI
         bV1VSjEA8t3K4oPX6WdVI7c5C785+5UIkUMBQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688413628; x=1691005628;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3tIZB00K/5DyFOSj72DNhfsbX4trIet39LY1NrmW8Vw=;
        b=QACDd717TOeqa+Rb1ZxEuhnSk50lolLEFK7rd+45c5zgynuLVuTLOSrY4eK1X//T9E
         18G/P1wdMvVJQDmYq7CXtk/RPE+5Ut/tglWt3kTb3dN6kXH0zW26+tTImqI4PsK6k8o4
         GzVrs/HCXhsM5tuwBsO8XvORKuenLqnjs/kKWPzOYc263IaBnUpbZeRyBbJpAf/zZXxE
         xxXLyNMbC802Fov4T7e27nIa5Q/JoP4cBMXOaink+2G0wkqPv3B2ATnwHJkVhmBGaeRU
         3vhVKAnzs5NR0zlyFuq7wRmbYwrMj72ll53I1/kq54w+KDavlawD2Oe6cIwRnxZoYn2/
         fdog==
X-Gm-Message-State: ABy/qLbh0CZwJy3rCLbFTvtTeGrxvyjF86F/2X5Ii5/xg3n31W6ewo5N
        OU/Oa2kBK/F+JtwBHshiaTKQAw==
X-Google-Smtp-Source: APBJJlHGlNpbJK0poTpyCHoYeLlS3DXyJ5HsjBSAz+GG6ulUW2Bv0vD8SynkqOmIk2lbOaMMDEHcoQ==
X-Received: by 2002:a05:6a00:228b:b0:682:4edf:b9b4 with SMTP id f11-20020a056a00228b00b006824edfb9b4mr8627237pfe.23.1688413628287;
        Mon, 03 Jul 2023 12:47:08 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id h21-20020aa786d5000000b00678cb336f3csm12269834pfo.142.2023.07.03.12.47.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jul 2023 12:47:07 -0700 (PDT)
Date:   Mon, 3 Jul 2023 12:47:07 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
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
Subject: Re: [PATCH v2 02/10] fortify: Allow KUnit test to build without
 FORTIFY
Message-ID: <202307031245.D3DDB0E@keescook>
References: <20230407191904.gonna.522-kees@kernel.org>
 <20230407192717.636137-2-keescook@chromium.org>
 <CAMuHMdUrxOEroHVUt7-mAnKSBjY=a-D3jr+XiAifuwv06Ob9Pw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMuHMdUrxOEroHVUt7-mAnKSBjY=a-D3jr+XiAifuwv06Ob9Pw@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 02, 2023 at 05:07:05PM +0200, Geert Uytterhoeven wrote:
> Hi Kees,
> 
> On Fri, Apr 7, 2023 at 9:27 PM Kees Cook <keescook@chromium.org> wrote:
> > In order for CI systems to notice all the skipped tests related to
> > CONFIG_FORTIFY_SOURCE, allow the FORTIFY_SOURCE KUnit tests to build
> > with or without CONFIG_FORTIFY_SOURCE.
> >
> > Signed-off-by: Kees Cook <keescook@chromium.org>
> 
> Thanks for your patch, which is now commit a9dc8d0442294b42
> ("fortify: Allow KUnit test to build without FORTIFY") upstream.
> 
> > --- a/lib/Kconfig.debug
> > +++ b/lib/Kconfig.debug
> > @@ -2614,7 +2614,7 @@ config STACKINIT_KUNIT_TEST
> >
> >  config FORTIFY_KUNIT_TEST
> >         tristate "Test fortified str*() and mem*() function internals at runtime" if !KUNIT_ALL_TESTS
> > -       depends on KUNIT && FORTIFY_SOURCE
> > +       depends on KUNIT
> 
> All other tests depend on the functionality they test.
> Which makes sense, as you only want to test the functionality that is
> available in the kernel you want to run.

Yeah, that is true for KUnit.

> 
> >         default KUNIT_ALL_TESTS
> >         help
> >           Builds unit tests for checking internals of FORTIFY_SOURCE as used
> > diff --git a/lib/fortify_kunit.c b/lib/fortify_kunit.c
> > index c8c33cbaae9e..524132f33cf0 100644
> > --- a/lib/fortify_kunit.c
> > +++ b/lib/fortify_kunit.c
> 
> > @@ -307,6 +312,14 @@ DEFINE_ALLOC_SIZE_TEST_PAIR(kvmalloc)
> >  } while (0)
> >  DEFINE_ALLOC_SIZE_TEST_PAIR(devm_kmalloc)
> >
> > +static int fortify_test_init(struct kunit *test)
> > +{
> > +       if (!IS_ENABLED(CONFIG_FORTIFY_SOURCE))
> > +               kunit_skip(test, "Not built with CONFIG_FORTIFY_SOURCE=y");
> 
> I was greeted by this message, which wasn't that helpful, as
> CONFIG_FORTIFY_SOURCE depends on CONFIG_ARCH_HAS_FORTIFY_SOURCE,
> which is not available yet on all architectures.
> 
> So I think the proper thing to do is to revert this patch.
> Thanks!

I created this patch so that I could add CONFIG_FORTIFY_SOURCE support
to UML, but you have a good point about other archs. I'll prepare a
revert.

-- 
Kees Cook
