Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F57D6DA600
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 00:54:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239196AbjDFWyG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 18:54:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230071AbjDFWyE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 18:54:04 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F80A59D8
        for <linux-kernel@vger.kernel.org>; Thu,  6 Apr 2023 15:54:03 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id c18so38749761ple.11
        for <linux-kernel@vger.kernel.org>; Thu, 06 Apr 2023 15:54:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1680821642;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=QPaVVGm2qUWSfNz4tA7arzn4mNtciwkt4EN4fGqYaQs=;
        b=n59sYTtqlD/xmJk02Aq4C3Fma1uygmEHaYsIbT9NSqVRwJX0M9RH93Rm4t5PnfM2+C
         0S1swQ/5MoXJtxmZ7OInbAGReQ5DRKj9ec0285syYJeYLIuAVM6uyVdbS4Nhf7qpxhOm
         eiT39dnkmEYHYLoWzHuU0oSRFxbxkpHE2Kew4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680821642;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QPaVVGm2qUWSfNz4tA7arzn4mNtciwkt4EN4fGqYaQs=;
        b=EYib250m6yyLVhABUtCYfR461zuuHUA6aLbiQUOuGMw++eBVu7sG4prhVZaHSAJvma
         yKGLoNh4aA5Jt4v6+ty4kLKslMlSxWihUywnQ6xxDTUVoSl1swLVn9Ugu8DsWZj4d4Qg
         wDPd2q89/gg4blIJZliNfY1oOBTQGdvBnIOJpIT0mgyYhhrsRz7ytj3QCMHADwtm1Q8j
         SJ4orA/FyDD/tfXz4XPfBazD4tAEgkN/aw7K0oAf5GM8xidPTsFhp7zVX1HGz0GRadlN
         d5lCmjCXeysrPt731QwRjoacdGVNnqUvcp9SDoliU+WgeG4r1lrBBTKH8UOjAX8bsKwN
         D5GQ==
X-Gm-Message-State: AAQBX9feHH8ZiV7KrJoohSIRcvRse1IzvTwkoUc5uzKZECU7MzClhhLm
        dTVaRay1rv2yvJvdY2WYyu4yOA==
X-Google-Smtp-Source: AKy350bR9zWuebqL/aA1LV8KxI7JWqQyZIsvvjMnLHlLZ3NbQXDSDF+xNCzWM/6aHQc/62ahVWwguw==
X-Received: by 2002:a05:6a20:659c:b0:d9:b820:10a4 with SMTP id p28-20020a056a20659c00b000d9b82010a4mr133641pzh.8.1680821642686;
        Thu, 06 Apr 2023 15:54:02 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id k20-20020a63d854000000b0050f7208b4bcsm1578608pgj.89.2023.04.06.15.54.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Apr 2023 15:54:02 -0700 (PDT)
Message-ID: <642f4d8a.630a0220.179b4.3576@mx.google.com>
X-Google-Original-Message-ID: <202304061551.@keescook>
Date:   Thu, 6 Apr 2023 15:54:01 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Alexander Lobakin <aleksander.lobakin@intel.com>
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
Subject: Re: [PATCH 6/9] fortify: Split reporting and avoid passing string
 pointer
References: <20230405235832.never.487-kees@kernel.org>
 <20230406000212.3442647-6-keescook@chromium.org>
 <0ff0548e-7348-d6cb-75a5-838a110b7d82@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0ff0548e-7348-d6cb-75a5-838a110b7d82@intel.com>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 06, 2023 at 05:23:54PM +0200, Alexander Lobakin wrote:
> From: Kees Cook <keescook@chromium.org>
> Date: Wed,  5 Apr 2023 17:02:05 -0700
> 
> > In preparation for KUnit testing and further improvements in fortify
> > failure reporting, split out the report and encode the function and
> > access failure (read or write overflow) into a single int argument. This
> > mainly ends up saving some space in the data segment. For a defconfig
> > with FORTIFY_SOURCE enabled:
> > 
> > $ size gcc/vmlinux.before gcc/vmlinux.after
> >    text  	  data     bss     dec    	    hex filename
> > 26132309        9760658 2195460 38088427        2452eeb gcc/vmlinux.before
> > 26132386        9748382 2195460 38076228        244ff44 gcc/vmlinux.after
> > 
> > Cc: Andy Shevchenko <andy@kernel.org>
> > Cc: Cezary Rojewski <cezary.rojewski@intel.com>
> > Cc: Puyou Lu <puyou.lu@gmail.com>
> > Cc: Mark Brown <broonie@kernel.org>
> > Cc: linux-hardening@vger.kernel.org
> > Signed-off-by: Kees Cook <keescook@chromium.org>
> > ---
> >  include/linux/fortify-string.h | 72 +++++++++++++++++++++++-----------
> >  lib/string_helpers.c           | 70 +++++++++++++++++++++++++++++++--
> >  tools/objtool/check.c          |  2 +-
> >  3 files changed, 118 insertions(+), 26 deletions(-)
> > 
> > diff --git a/include/linux/fortify-string.h b/include/linux/fortify-string.h
> > index 41dbd641f55c..6db4052db459 100644
> > --- a/include/linux/fortify-string.h
> > +++ b/include/linux/fortify-string.h
> > @@ -9,7 +9,34 @@
> >  #define __FORTIFY_INLINE extern __always_inline __gnu_inline __overloadable
> >  #define __RENAME(x) __asm__(#x)
> >  
> > -void fortify_panic(const char *name) __noreturn __cold;
> > +#define fortify_reason(func, write)	(((func) << 1) | !!(write))
> > +
> > +#define fortify_panic(func, write)	\
> > +	__fortify_panic(fortify_reason(func, write))
> > +
> > +#define FORTIFY_READ		 0
> > +#define FORTIFY_WRITE		 1
> > +
> > +#define FORTIFY_FUNC_strncpy	 0
> > +#define FORTIFY_FUNC_strnlen	 1
> > +#define FORTIFY_FUNC_strlen	 2
> > +#define FORTIFY_FUNC_strlcpy	 3
> > +#define FORTIFY_FUNC_strscpy	 4
> > +#define FORTIFY_FUNC_strlcat	 5
> > +#define FORTIFY_FUNC_strcat	 6
> > +#define FORTIFY_FUNC_strncat	 7
> > +#define FORTIFY_FUNC_memset	 8
> > +#define FORTIFY_FUNC_memcpy	 9
> > +#define FORTIFY_FUNC_memmove	10
> > +#define FORTIFY_FUNC_memscan	11
> > +#define FORTIFY_FUNC_memcmp	12
> > +#define FORTIFY_FUNC_memchr	13
> > +#define FORTIFY_FUNC_memchr_inv	14
> > +#define FORTIFY_FUNC_kmemdup	15
> > +#define FORTIFY_FUNC_strcpy	16
> 
> enum?

I opted to avoid an enum due to the binary operations used in
"fortify_reason" to collapse it to a u8. It just seemed like more work
to put in enums, and then do u8 casts, etc, all for a strictly
"internal" set of magic numbers.

> 
> > --- a/lib/string_helpers.c
> > +++ b/lib/string_helpers.c
> > @@ -1021,10 +1021,74 @@ EXPORT_SYMBOL(__read_overflow2_field);
> >  void __write_overflow_field(size_t avail, size_t wanted) { }
> >  EXPORT_SYMBOL(__write_overflow_field);
> >  
> > -void fortify_panic(const char *name)
> > +void __fortify_report(u8 reason)
> >  {
> > -	pr_emerg("detected buffer overflow in %s\n", name);
> > +	const char *name;
> > +	const bool write = !!(reason & 0x1);
> > +
> > +	switch (reason >> 1) {
> 
> As already mentioned, I'd use bitfield helpers + couple definitions to
> not miss something when changing the way it's encoded
> 
> #define FORTIFY_REASON_DIR(r)	FIELD_GET(BIT(0), r)
> #define FORTIFY_REASON_FUNC(r)	FIELD_GET(GENMASK(7, 1), r)

Yeah, good idea. Thanks for the FIELD_GET examples!

> [...]
> > +		break;
> > +	default:
> > +		name = "unknown";
> > +	}
> 
> I know this is far from hotpath, but could we save some object code and
> do that via O(1) array lookup? Plus some macro to compress things:
> 
> #define FORTIFY_ENTRY(name)		\
> 	[FORTIFY_FUNC_##name]	= #name
> 
> static const char * const fortify_funcs[] = {
> 	FORTIFY_ENTRY(strncpy),
> 	...
> }
> 
> 	// array bounds check here if you wish, I wouldn't bother as
> 	// we're panicking anyway
> 
> 	name = fortify_funcs[reason >> 1];

Fair enough. I had considered it and then forgot about it for some
reason. :)

-- 
Kees Cook
