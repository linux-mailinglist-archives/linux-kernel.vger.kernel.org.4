Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70C8F5B6CB3
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 14:01:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231974AbiIMMBb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 08:01:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231633AbiIMMB1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 08:01:27 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC646371A6
        for <linux-kernel@vger.kernel.org>; Tue, 13 Sep 2022 05:01:26 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id t3so11593307ply.2
        for <linux-kernel@vger.kernel.org>; Tue, 13 Sep 2022 05:01:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date;
        bh=1pj33muzPsJpUhNcBT0o05+VQt0cQ00T/48YoaU8PHs=;
        b=d/lOC17WeCAmAwvxW/N1bb7kaPeC/aK5SUy4mCsFXE+sUgxwzHqejSFjPte6c2BscC
         Jsy19VHeRmjWLFSqi9P2NPitXTP7wZRBBRvM0rnquiMAsqhNBa3v5Ow/9ksWRcWqVw76
         lHWGeMEzT0Msv8IbkZ5bqbrdwsBtu7ZZ2+mhg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date;
        bh=1pj33muzPsJpUhNcBT0o05+VQt0cQ00T/48YoaU8PHs=;
        b=V0GU4mL+At75JWwI12TqLrH1CbeUHkoAq8yNChVHNXOtuCM95s06nPLThIdarYKuiL
         /10TsOBOvdElYv0CRnxnwUCDRkzRtgLK4S4oRJEEnqV5p/DCfB+/xhgRtoQWPPhM+k8F
         85MUVOowtipghIFs2guZEEJ0ZHL/79L4eCljvRc8EFOO/WLeDDT0LD6SA45rg/RfLaeX
         k341RYTnNcGvhSm9sE0gCeICTkkpVIk0ApflVplmIxjFV6PCohzzQ9ARyvbETjTg370t
         XOs+ZyyeSNlWZf2r3+HrOBVE6/n94la1aFaMk0LujzwWg/tT0waMFpNUnzkduZrmxfUU
         esPg==
X-Gm-Message-State: ACgBeo2ou/7VRU7tG5lVGCkMijE1u1ha7c9iwXL+IIr6X37UMh5uF245
        AySp/5s5ss4EuyMcIgLfr0kdJg==
X-Google-Smtp-Source: AA6agR4lG2Wr58F5IZD2hOfAAdpXddSRPOIQgSQteCRZSJphcxFM58CRtQHLZjzUCr/58UBt/YhjQA==
X-Received: by 2002:a17:903:22cc:b0:178:18a1:d16c with SMTP id y12-20020a17090322cc00b0017818a1d16cmr17420970plg.155.1663070485873;
        Tue, 13 Sep 2022 05:01:25 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id d21-20020a170902729500b0017441330392sm8058363pll.63.2022.09.13.05.01.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Sep 2022 05:01:24 -0700 (PDT)
Date:   Tue, 13 Sep 2022 05:01:23 -0700
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
Subject: Re: [PATCH v10 3/9] compiler_types.h: Add assert_type to catch type
 mis-match while compiling
Message-ID: <202209130455.E7CF976A@keescook>
References: <20220909105913.752049-1-gwan-gyeong.mun@intel.com>
 <20220909105913.752049-4-gwan-gyeong.mun@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220909105913.752049-4-gwan-gyeong.mun@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 09, 2022 at 07:59:07PM +0900, Gwan-gyeong Mun wrote:
> It adds assert_type and assert_typable macros to catch type mis-match while
> compiling. The existing typecheck() macro outputs build warnings, but the
> newly added assert_type() macro uses the _Static_assert() keyword (which is
> introduced in C11) to generate a build break when the types are different
> and can be used to detect explicit build errors.
> Unlike the assert_type() macro, assert_typable() macro allows a constant
> value as the second argument.
> 
> Suggested-by: Kees Cook <keescook@chromium.org>
> Signed-off-by: Gwan-gyeong Mun <gwan-gyeong.mun@intel.com>
> Cc: Thomas Hellström <thomas.hellstrom@linux.intel.com>
> Cc: Matthew Auld <matthew.auld@intel.com>
> Cc: Nirmoy Das <nirmoy.das@intel.com>
> Cc: Jani Nikula <jani.nikula@intel.com>
> Cc: Andi Shyti <andi.shyti@linux.intel.com>
> Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
> Cc: Andrzej Hajda <andrzej.hajda@intel.com>
> Cc: Kees Cook <keescook@chromium.org>
> ---
>  include/linux/compiler_types.h | 39 ++++++++++++++++++++++++++++++++++
>  1 file changed, 39 insertions(+)
> 
> diff --git a/include/linux/compiler_types.h b/include/linux/compiler_types.h
> index 4f2a819fd60a..19cc125918bb 100644
> --- a/include/linux/compiler_types.h
> +++ b/include/linux/compiler_types.h
> @@ -294,6 +294,45 @@ struct ftrace_likely_data {
>  /* Are two types/vars the same type (ignoring qualifiers)? */
>  #define __same_type(a, b) __builtin_types_compatible_p(typeof(a), typeof(b))
>  
> +/**
> + * assert_type - break compile if the first argument's data type and the second
> + *               argument's data type are not the same
> + *
> + * @t1: data type or variable
> + * @t2: data type or variable
> + *
> + * The first and second arguments can be data types or variables or mixed (the
> + * first argument is the data type and the second argument is variable or vice
> + * versa). It determines whether the first argument's data type and the second
> + * argument's data type are the same while compiling, and it breaks compile if
> + * the two types are not the same.
> + * See also assert_typable().
> + */
> +#define assert_type(t1, t2) _Static_assert(__same_type(t1, t2))
> +
> +/**
> + * assert_typable - break compile if the first argument's data type and the
> + *                  second argument's data type are not the same
> + *
> + * @t: data type or variable
> + * @n: data type or variable or constant value
> + *
> + * The first and second arguments can be data types or variables or mixed (the
> + * first argument is the data type and the second argument is variable or vice
> + * versa). Unlike the assert_type() macro, this macro allows a constant value
> + * as the second argument. And if the second argument is a constant value, it
> + * always passes. And it doesn't mean that the types are explicitly the same.
> + * When a constant value is used as the second argument, if you need an
> + * overflow check when assigning a constant value to a variable of the type of
> + * the first argument, you can use the overflows_type() macro. When a constant

I wonder if the overflows_type() check should happen in this test? It
seems weird that assert_typable(u8, 1024) would pass...

> + * value is not used as a second argument, it determines whether the first
> + * argument's data type and the second argument's data type are the same while
> + * compiling, and it breaks compile if the two types are not the same.
> + * See also assert_type() and overflows_type().
> + */
> +#define assert_typable(t, n) _Static_assert(__builtin_constant_p(n) ||	\
> +					    __same_type(t, typeof(n)))

Totally untested -- I'm not sure if this gets the right semantics for
constant expressoins, etc...

static_assert(__builtin_choose_expression(__builtin_constant_p(n), \
			overflows_type(n, typeof(t)), \
			__same_type(t, typeof(n))))


Also, can you please add KUnit tests for these new helpers into
lib/overflow_kunit.c?

-- 
Kees Cook
