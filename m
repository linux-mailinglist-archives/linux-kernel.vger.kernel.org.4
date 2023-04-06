Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 235EA6DA608
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 00:58:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239387AbjDFW6T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 18:58:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232836AbjDFW6Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 18:58:16 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 192746A4D
        for <linux-kernel@vger.kernel.org>; Thu,  6 Apr 2023 15:58:16 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1a1ab42c601so521805ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Apr 2023 15:58:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1680821895;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:subject:cc:to:from:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=MlCMBaiF6CrM9E029g8nSryHni1f2kcvCzubhY5iI14=;
        b=gaAqTVzIv0GtrsT2gko7r/O1pDRuvli3yBUZkRnSoljXc7wh6yOCgO7trqieYfdWKk
         gRGuFYivjIm9pGiFCtw46AUgmINk/73ZEP5G8Q6BqMmXPkfX08PU9gneL4YHYcfjLlpA
         fnNkcCO2PknZiwLf1yGllWAcIZlmlhG403Fmk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680821895;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:subject:cc:to:from:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MlCMBaiF6CrM9E029g8nSryHni1f2kcvCzubhY5iI14=;
        b=w6Fzkwy+cHoMgsGw41P5ZjEYgpMFyPM3OkVtmodEnAMpeFiqIlhej4AwlJ1c6HRav5
         Crp6Rmxpt1ylffiLsPvPZuZgfgk+Ovg+FBsXLhRDwRmLmdYCIEkTJ1R/8QiGEzYmCqNS
         k2gvxfDfAOgsMh/fv/+mcjjzswlX35MbymlrSXF4tsFXSF5ehRy1UxDk29kMEOlJp9NA
         O5xa3IsVQO+EZzrLAeFxws4kPGOc71KcsUO1TmAIk1l6JEuHMf/d9o7EmpiChYM7WKnK
         YqWPhwJZlEEdcx1noditiS3B4aanS8AmxUFDGvO3+KcTOhGYwBAmT/Z9O8QG6OGRtN73
         bMew==
X-Gm-Message-State: AAQBX9c3WWIhRVl/6fL2PuLsl7y1Wx//PawTYd994Fqnb/UF4dMrdxYB
        7qfb/G4EM9vgC5nKyv1rzbjhSw==
X-Google-Smtp-Source: AKy350bgyVCFJBnbiJGa3rk5DD6kuc5x0UAVO9GqJwsqVmytbKzjyrHsJBAUy1++ISyALQXo9HUTsQ==
X-Received: by 2002:aa7:8f37:0:b0:624:3061:7dbf with SMTP id y23-20020aa78f37000000b0062430617dbfmr426545pfr.25.1680821895634;
        Thu, 06 Apr 2023 15:58:15 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id e20-20020aa78c54000000b0059085684b54sm1888972pfd.140.2023.04.06.15.58.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Apr 2023 15:58:15 -0700 (PDT)
Message-ID: <642f4e87.a70a0220.6d16d.4391@mx.google.com>
X-Google-Original-Message-ID: <202304061558.@keescook>
Date:   Thu, 6 Apr 2023 15:58:14 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
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
        Daniel Latypov <dlatypov@google.com>,
        =?iso-8859-1?Q?Jos=E9_Exp=F3sito?= <jose.exposito89@gmail.com>,
        linux-kernel@vger.kernel.org, kunit-dev@googlegroups.com
Subject: Re: [PATCH 4/9] fortify: Add protection for strlcat()
References: <20230405235832.never.487-kees@kernel.org>
 <20230406000212.3442647-4-keescook@chromium.org>
 <CANiq72nku=HWzOXgZkbjpC7ii=_SwJj0N+GnXoa=dgcpxR=MVg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANiq72nku=HWzOXgZkbjpC7ii=_SwJj0N+GnXoa=dgcpxR=MVg@mail.gmail.com>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 06, 2023 at 03:32:40PM +0200, Miguel Ojeda wrote:
> On Thu, Apr 6, 2023 at 2:02 AM Kees Cook <keescook@chromium.org> wrote:
> >
> > +       size_t p_size = __member_size(p);
> > +       size_t q_size = __member_size(q);
> 
> Since I noticed the patches appear to go for const-correctness even
> for parameters (which is great, I support it), these could be `const`
> too.

Will do. Thanks!

-- 
Kees Cook
