Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00F5A6FE476
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 21:24:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231313AbjEJTYo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 15:24:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230181AbjEJTYl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 15:24:41 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBA035276
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 12:24:39 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-1ab032d9266so71618315ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 12:24:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1683746679; x=1686338679;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=HXHY5peLySfKV7fD6H1ijt1olAC50bP9lGE3KVhNLQg=;
        b=OI0aC+/AEAMnd83LFI8Aag6udSJxYUe+70XR+T/z67fLGkrTod0pjrlql618r+gvqx
         MfuO8oonl8fVsdJ+f+WQ4arWAtwK8c/6z+qrZvix2Vh05m2QjIWoVs5Sl0fTRTBCPCfl
         kZQXXzaXVoWrhYFa80roLq9Q2Id2j6Yv55LBY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683746679; x=1686338679;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HXHY5peLySfKV7fD6H1ijt1olAC50bP9lGE3KVhNLQg=;
        b=f6Lsc9JRjWJ7zzY4FyuYox0GPBpkGIficWo1BvDbogyVIpx9POfrffcweAxWFQw6/d
         tjxi6UT683OcZWLw5sbEJgbzwulMqUaRy+xbtwo22bLqDOKk4yFqPY+J1Dxj/8xAQhna
         s9+KjXCd7iCFzH6+eDYT3ThFOUhVP51K/5YsXyu2Wtf3aM3YGcV9ch2v141vCg0jU26y
         qDnzukoIcgdjBkP1zKiPwsrvSpaCQT9VgcuzqC2aOQKfqAyTFg7vlZAsW9Ei+J2pFUeG
         aJOaZI3RBQMXnPcZdIRrDiKpCoCulTgt/qG84NgeEqe+V/N9Mbz57rTVSDL9DxK33Fo4
         zdCA==
X-Gm-Message-State: AC+VfDzBPrtqMaCFOi6IztUYhIjxBMR2UKojtlGFYEYRKFu9OVsrmdAY
        ZtHiB+lcqgO4BUo7n2r4DdRdZg==
X-Google-Smtp-Source: ACHHUZ5CF7fA3Kqg/UxBd853ruj1Tzn0GgcCvZUFaYGJR4zX/wzc7t2kMAj1WEzPP7kw9FfgfS/0Aw==
X-Received: by 2002:a17:902:e84d:b0:1ab:eee:c609 with SMTP id t13-20020a170902e84d00b001ab0eeec609mr23964108plg.40.1683746679344;
        Wed, 10 May 2023 12:24:39 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id u17-20020a170903125100b001aafe4f9b8esm4163639plh.180.2023.05.10.12.24.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 May 2023 12:24:38 -0700 (PDT)
Date:   Wed, 10 May 2023 12:24:38 -0700
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
Subject: Re: [PATCH v2 01/10] kunit: tool: Enable CONFIG_FORTIFY_SOURCE under
 UML
Message-ID: <202305101223.B940A881@keescook>
References: <20230407191904.gonna.522-kees@kernel.org>
 <20230407192717.636137-1-keescook@chromium.org>
 <CAKwvOdk5JjB21FU85Zxubs+LV8bTY-az598V1hvewndAfhohQA@mail.gmail.com>
 <CAKwvOd=yZw_Ju67D52GfUz39MaAFA639hOxR5Jo2dRdp+xciyQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKwvOd=yZw_Ju67D52GfUz39MaAFA639hOxR5Jo2dRdp+xciyQ@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 07, 2023 at 04:42:27PM -0700, Nick Desaulniers wrote:
> On Fri, Apr 7, 2023 at 4:33 PM Nick Desaulniers <ndesaulniers@google.com> wrote:
> >
> > On Fri, Apr 7, 2023 at 12:27 PM Kees Cook <keescook@chromium.org> wrote:
> > >
> > > Since commit ba38961a069b ("um: Enable FORTIFY_SOURCE"), it's possible
> > > to run the FORTIFY tests under UML. Enable CONFIG_FORTIFY_SOURCE when
> > > running with --altests to gain additional coverage, and by default under
> >
> > two L's in alltest?
> 
> Also, while testing this series:
> ```
> $ LLVM=1 ./tools/testing/kunit/kunit.py run
> ...
> [16:40:09] ================== fortify (24 subtests) ===================
> [16:40:09] [PASSED] known_sizes_test
> [16:40:09] [PASSED] control_flow_split_test
> [16:40:09] [PASSED] alloc_size_kmalloc_const_test
> [16:40:09]     # alloc_size_kmalloc_dynamic_test: EXPECTATION FAILED
> at lib/fortify_kunit.c:249
> [16:40:09]     Expected __builtin_dynamic_object_size(p, 1) == expected, but
> [16:40:09]         __builtin_dynamic_object_size(p, 1) == -1
> (0xffffffffffffffff)
> [16:40:09]         expected == 11 (0xb)
> [16:40:09] __alloc_size() not working with __bdos on kmemdup("hello
> there", len, gfp)

I'm still tracking this down. I'm not sure what's happening here, but it
seems to be Clang-specific, and due to some interaction with the changes
I made for Kunit examination. WHY it happens I haven't found yet.

-- 
Kees Cook
