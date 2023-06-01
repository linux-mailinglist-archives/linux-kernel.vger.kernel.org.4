Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55EDA71F1F4
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 20:38:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232380AbjFAS2y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 14:28:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230151AbjFAS2u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 14:28:50 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 744AC19F
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jun 2023 11:28:25 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1b075e13a5eso10310945ad.3
        for <linux-kernel@vger.kernel.org>; Thu, 01 Jun 2023 11:28:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1685644092; x=1688236092;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZZLQgV5OTogJ1ylkCDiOjxfc1T+CJXFQFeKoN9hX3ug=;
        b=ac+D7llpyM/BXxwdJaEuWvmMQMeui0FxZcRRZfnSpxqEIcArtXlCuZLwdqvfE3qGok
         4YJ2vXhKuTgstjkSaUUfSn4yhgRW5lkYVmqdpxgsomkqIhx3z9M67ufAL1kVHNnkKSkr
         AnBhc03iHLRfh7oBDG/8KKFHGAinTY75WMNeA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685644092; x=1688236092;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZZLQgV5OTogJ1ylkCDiOjxfc1T+CJXFQFeKoN9hX3ug=;
        b=SDflWdNrli4bw6ctaj0W/GqVrJZazqmPWcxtNEMaAhWUEPw4CjZlIx1+aj3hQ4pL6/
         N2qsoYA1z2tMeVMSC2If6pYOk+a59CIhkmq6XFAcqtViD8MAIEsqmgL9GIAo2Ye9ZAGD
         ge23ccC4k4MBxJJizglu0zjeXgpUCBRHv48nBZPBeeQE+isTk2GNH1MXI+J/LaVg9WMv
         iDeWIfWG1UfB2ASugk6J8D+BYfmvystWxArf69IWUyxGJdC9Nl6v65uopXblLTXtVsjf
         E7U/H1J4jKzHHdpQVABw8DK15v5CHm3ULGZ1kKHoM7nioFkIXNGf53VggsYI9TjC1BR/
         tLPg==
X-Gm-Message-State: AC+VfDwiXQx0zWM/2GGWJahdsNl0SD0mbt6+XfxG9Mnm69DTyj0UD1iP
        G6H5p+faRzrx5XhbMOgtOq21UA==
X-Google-Smtp-Source: ACHHUZ6VsAWG8Oi4STZkNdzz+9GCCgAqrG0b/8X2yp5U2lZsp1m4pLUb6tcFZsc1F6+QClxMAWQwkQ==
X-Received: by 2002:a17:903:2286:b0:1b0:1036:608c with SMTP id b6-20020a170903228600b001b01036608cmr261752plh.25.1685644092279;
        Thu, 01 Jun 2023 11:28:12 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id n18-20020a170903111200b001ac4e316b51sm3833178plh.109.2023.06.01.11.28.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jun 2023 11:28:11 -0700 (PDT)
Date:   Thu, 1 Jun 2023 11:28:11 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Arnd Bergmann <arnd@kernel.org>, kasan-dev@googlegroups.com,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Marco Elver <elver@google.com>, linux-media@vger.kernel.org,
        linux-crypto@vger.kernel.org,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Ard Biesheuvel <ardb@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Dan Carpenter <dan.carpenter@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, llvm@lists.linux.dev
Subject: Re: [PATCH] [RFC] ubsan: disallow bounds checking with gcov on
 broken gcc
Message-ID: <202306011127.B801968@keescook>
References: <20230601151832.3632525-1-arnd@kernel.org>
 <202306010909.89C4BED@keescook>
 <f6fcae8a-9b50-48e4-84e9-c37613226c63@app.fastmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f6fcae8a-9b50-48e4-84e9-c37613226c63@app.fastmail.com>
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 01, 2023 at 07:50:38PM +0200, Arnd Bergmann wrote:
> On Thu, Jun 1, 2023, at 18:14, Kees Cook wrote:
> > On Thu, Jun 01, 2023 at 05:18:11PM +0200, Arnd Bergmann wrote:
> >
> > I think more production systems will have CONFIG_UBSAN_BOUNDS enabled
> > (e.g. Ubuntu has had it enabled for more than a year now) than GCOV,
> > so I'd prefer we maintain all*config coverage for the more commonly
> > used config.
> 
> Fair enough, I can send that as v2, but let's see what the others
> think first.
> 
> >>  config CC_HAS_UBSAN_BOUNDS_STRICT
> >>  	def_bool $(cc-option,-fsanitize=bounds-strict)
> >> +	# work around https://gcc.gnu.org/bugzilla/show_bug.cgi?id=110074
> >> +	depends on GCC_VERSION > 140000 || !GCOV_PROFILE_ALL
> >>  	help
> >>  	  The -fsanitize=bounds-strict option is only available on GCC,
> >>  	  but uses the more strict handling of arrays that includes knowledge
> >
> > Alternatively, how about falling back to -fsanitize=bounds instead, as
> > that (which has less coverage) wasn't triggering the stack frame
> > warnings?
> >
> > i.e. fall back through these:
> > 	-fsanitize=array-bounds (Clang)
> > 	-fsanitize=bounds-strict (!GCOV || bug fixed in GCC)
> > 	-fsanitize=bounds
> 
> From what I can tell, -fsanitize=bounds has the same problem
> as -fsanitize=bounds-strict, so that would not help.

Ah, did something change with GCOV? This (bounds vs bounds-strict) is
the only recent change to CONFIG_UBSAN_BOUNDS...

-- 
Kees Cook
