Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 396B55E9773
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 02:37:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232705AbiIZAhf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Sep 2022 20:37:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233169AbiIZAhN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Sep 2022 20:37:13 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10F0325EA5
        for <linux-kernel@vger.kernel.org>; Sun, 25 Sep 2022 17:37:13 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id j6-20020a17090a694600b00200bba67dadso5205200pjm.5
        for <linux-kernel@vger.kernel.org>; Sun, 25 Sep 2022 17:37:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=JUqSNEPLCMNTTpKfM7Crxzu6WwUvly/09+gzrj81knI=;
        b=oIwNpZQ5Y1z1143vFXyrfwGUJZ75JghkszOcBwSh0YmtZPbQHOcWWnAfns5g+sbQ/D
         wiZ6Ijn8aWt3loyhafcrd2u+HcNQ1wlNI/8R7IsXEDiIp43xc5Tl50hy97o7WZC7QwAe
         AYwaR/MB0DrbVUA991Ly8rZD21O7YmLTAEl4A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=JUqSNEPLCMNTTpKfM7Crxzu6WwUvly/09+gzrj81knI=;
        b=J3P7+tgo+dLiZ24+NUGqkt4Tmql/nFGjtChO8jH0yofLoMvrHmg13sPyUQ4imRmOgX
         caSAaF9f/iM2MeM6ZBaw8QGO8nrKKxam19KMDMuLSP/2j/guKv3r2qTuYsQsZNub1CuN
         R6Ya7NO7Wa93UzZF2dFQghVNj0gbOPqg9ezh63fXc7mfSOb0xnda+PuOwBNH0Yaqblrv
         W/ISdwpgxK13Y0n7eC0K52Fgx6dloJJ/TNwj7Ug/xLgBRI3Xgui3ETzP6WzU5j0EglAJ
         LPpoqplojxhLsHmlEyUy5WwH86ABOXh/8paZRhnmYvdkmIFROOW2FXxbnzh4XU+CWWTw
         fzFA==
X-Gm-Message-State: ACrzQf3hGfs18zWzk2xyClDFIZCjXGuarCz3JEt6KXoCK8pXCWUVmY3X
        dl9P+BMVf0OcLM3UbLoo4GO1Nw==
X-Google-Smtp-Source: AMsMyM6cpOhuwKFpZGu/GN3489Z0nCbt+/1a9GngZAzI09XYZxSG0DMGO11e73UWrmykWT+QugME+g==
X-Received: by 2002:a17:903:120d:b0:179:d027:66f0 with SMTP id l13-20020a170903120d00b00179d02766f0mr7587416plh.61.1664152632485;
        Sun, 25 Sep 2022 17:37:12 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id 69-20020a621748000000b0053725e331a1sm10589061pfx.82.2022.09.25.17.37.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Sep 2022 17:37:11 -0700 (PDT)
Date:   Sun, 25 Sep 2022 17:37:10 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Gwan-gyeong Mun <gwan-gyeong.mun@intel.com>
Cc:     intel-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, mchehab@kernel.org,
        chris@chris-wilson.co.uk, matthew.auld@intel.com,
        thomas.hellstrom@linux.intel.com, jani.nikula@intel.com,
        nirmoy.das@intel.com, airlied@redhat.com, daniel@ffwll.ch,
        andi.shyti@linux.intel.com, andrzej.hajda@intel.com,
        mauro.chehab@linux.intel.com, linux@rasmusvillemoes.dk,
        vitor@massaru.org, dlatypov@google.com, ndesaulniers@google.com
Subject: Re: [PATCH v11 3/9] compiler_types.h: Add assert_same_type to catch
 type mis-match while compiling
Message-ID: <202209251032.71251A8@keescook>
References: <20220923082628.3061408-1-gwan-gyeong.mun@intel.com>
 <20220923082628.3061408-4-gwan-gyeong.mun@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220923082628.3061408-4-gwan-gyeong.mun@intel.com>
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 23, 2022 at 11:26:22AM +0300, Gwan-gyeong Mun wrote:
> Adds assert_same_type and assert_same_typable macros to catch type
> mis-match while compiling. The existing typecheck() macro outputs build
> warnings, but the newly added assert_same_type() macro uses the
> static_assert macro (which uses _Static_assert keyword and it introduced
> in C11) to generate a build break when the types are different and can be
> used to detect explicit build errors. Unlike the assert_same_type() macro,
> assert_same_typable() macro allows a constant value as the second argument.
> Since static_assert is used at compile time and it requires
> constant-expression as an argument [1][2], overflows_type_ret_const_expr()
> is newly added. There is overflows_type() that has the same behavior, but
> the macro uses __builtin_add_overflow() internally, and
> __builtin_add_overflows returns a bool type [3], so it is difficult to use
> as an argument of _Static_assert. The assert_same_type and
> assert_same_typable macros have been added to compiler_types.h, but the
> overflows_type_ret_const_expr macro has been added to overflow.h
> So, overflow.h has to be included to use assert_same_typable which
> internally uses overflows_type_ret_const_expr.
> And it adds unit tests for overflows_type, overflows_type_ret_const_expr,
> assert_same_type and assert_same_typable. The overflows_type has been added
> as well to compare whether the overflows_type_ret_const_expr unit test has
> the same as the result.

I spent some time rewriting the code in this patch. I think it's really
close, but I wanted to tweak how things were being defined, naming, etc.

Notes below, and I'll send my proposed patch separately...

> [...]
> +#define overflows_type_ret_const_expr(x,T) (			\

For the "overflows_type" defines, I think this reads a bit better:

#define __overflows_type_constexpr(x, T) (                      \
        is_unsigned_type(typeof(x)) ?                           \
                (x) > type_max(typeof(T)) ? 1 : 0               \
        : is_unsigned_type(typeof(T)) ?                         \
                (x) < 0 || (x) > type_max(typeof(T)) ? 1 : 0    \
                : (x) < type_min(typeof(T)) ||                  \
                  (x) > type_max(typeof(T)) ? 1 : 0 )

#define __overflows_type(x, T)          ({      \
        typeof(T) v = 0;                        \
        check_add_overflow((x), v, &v);         \
})

#define overflows_type(n, T)                                    \
        __builtin_choose_expr(__is_constexpr(n),                \
                              __overflows_type_constexpr(n, T), \
                              __overflows_type(n, T))

> [...]
> +/**
> + * assert_same_type - abort compilation if the first argument's data type and
> + *                    the second argument's data type are not the same
> + * @t1: data type or variable
> + * @t2: data type or variable
> + *
> + * The first and second arguments can be data types or variables or mixed (the
> + * first argument is the data type and the second argument is variable or vice
> + * versa). It determines whether the first argument's data type and the second
> + * argument's data type are the same while compiling, and it aborts compilation
> + * if the two types are not the same.
> + * See also assert_same_typable().
> + */
> +#define assert_same_type(t1, t2) static_assert(__same_type(t1, t2))

I still think I'd rather avoid a define for this. It doesn't seem worth
4 characters of savings to just have to type it out:

	static_assert(__same_type(a, b))

> [...]
> +#define assert_same_typable(t, n) static_assert(			       \
> +		__builtin_choose_expr(__builtin_constant_p(n),		       \
> +				      overflows_type_ret_const_expr(n,t) == 0, \
> +				      __same_type(t, n)))

This one I'd like to convert into something closer in naming convention to
"__same_type". Also note that "__builtin_constant_p()" doesn't actually
work here: it needs to be __is_constexpr(). So, I propose:

#define __castable_to_type(n, T)				\
		__builtin_choose_expr(__is_constexpr(n),	\
			__overflows_type_constexpr(n, T),	\
			__same_type(n, T))

Then we can do:

	static_assert(__castable_to_type(INT_MAX, size_t));

> [...[
> +static void overflows_type_test(struct kunit *test)
> +{
> +/* Args are: first type, secound type, value, overflow expected */
> +#define TEST_OVERFLOWS_TYPE(t1, t2, v, of) do {				\
> +	t1 __t1 = v;							\
> +	t2 __t2;							\
> +	bool __of;							\
> +	__of = overflows_type(v, t2);					\
> +	if (__of != of) {						\
> +		KUNIT_EXPECT_EQ_MSG(test, __of, of,			\
> +			"expected overflows_type(%s, %s) to%s overflow\n", \
> +			#v, #t2, of ? "" : " not");			\
> +	}								\
> [...]
> +	__of = overflows_type_ret_const_expr(__t1, __t2) ? true : false;\
> +	if (__of != of) {						\
> +		KUNIT_EXPECT_EQ_MSG(test, __of, of,			\
> +			"expected overflows_type_ret_const_expr(%s, %s) to%s overflow\n", \
> +			#t1" __t1 = "#v, #t2" __t2", of ? "" : " not");	\
> +	}								\

These tests are excellent! I've adapted them a little bit to avoid some
of their internal redundancy. (i.e. the above blocks are basically
almost entire the same, etc).

-Kees

-- 
Kees Cook
