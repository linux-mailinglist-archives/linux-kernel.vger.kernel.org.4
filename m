Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 982B85E8015
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 18:42:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231701AbiIWQmP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 12:42:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232226AbiIWQlv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 12:41:51 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DC9414DAE4
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 09:41:22 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id b23so659277pfp.9
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 09:41:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=CCcB2IivbnzKK3Fhxx9t3mrn1ZxfWfp+R3o89Fj/9Xo=;
        b=Mx88uG+fKQFt0HG6PwPXEdC0yY3iRmRPGPewaxChkzvXtJKUGeYM/pI1BU+Y8URAEZ
         EC2SuutpN7N6YweCdakgehETgcNl4RDNZKYrw5+Su46g8RDWjVB3JeNuJ65ktUfgcI7K
         f+McPnrD/zMU/7WRaOOaDcMmDCBnlCaz7AU1U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=CCcB2IivbnzKK3Fhxx9t3mrn1ZxfWfp+R3o89Fj/9Xo=;
        b=iIovvEJzV248u8aMtTqIE+uyOAjNhpdRxWERDvFt0kifSEnSEMQpEtGxtPvEJkDyda
         E+3XIQKeye7dWBCjf7apnfPYQtHDlHWVl6T3rznMjJHbwyXgyopc51VqFsWhuHevX7rE
         C7BeS9v2aJUcFdx2vY0Rct27QPINC9txSlGn5KuEJgdYnOQw/ltDrY791Otkhl1DZeBL
         su7J+DITbXCxSg/WfVmWsFiuX112Cl6kRcKFk9BceWpSqC6L8qoZSv4P6QjVWS9kt1Mn
         S0+/BAQ/nBSwaHtfycnQjkzbT1o7pee34Uh+FLM/PqwB1jLtnym6vti7uU/v1tdis49a
         akbA==
X-Gm-Message-State: ACrzQf3XhYv0gMbpsnMcxPJCEDU6yJfUSJDwV2kf6v7maHvwo+hC4MGq
        rYxMJc7oXOZSrcE+0PkP9EMT261t5oxObQ==
X-Google-Smtp-Source: AMsMyM7AaNJiN1wSNNbkFT/PjzVg7VYkaKDZs/IqSwZA6DAcrWp/Z12rHxuCW0NtyIjOiQxgwZLqmw==
X-Received: by 2002:a63:2cd2:0:b0:41c:5901:67d8 with SMTP id s201-20020a632cd2000000b0041c590167d8mr8323352pgs.365.1663951281340;
        Fri, 23 Sep 2022 09:41:21 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id c5-20020a170902d48500b0017684444f57sm6332171plg.224.2022.09.23.09.41.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Sep 2022 09:41:20 -0700 (PDT)
Date:   Fri, 23 Sep 2022 09:41:19 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v2] minmax: clamp more efficiently by avoiding extra
 comparison
Message-ID: <202209230932.1FA2FF39@keescook>
References: <CAHmME9rH47UFp6sXbDU0UZrTosFrDAa+m_FtqMqRFFNzmOzTdA@mail.gmail.com>
 <20220923154001.4074849-1-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220923154001.4074849-1-Jason@zx2c4.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 23, 2022 at 05:40:01PM +0200, Jason A. Donenfeld wrote:
> Currently the clamp algorithm does:
> 
> 	if (val > hi)
> 		val = hi;
> 	if (val < lo)
> 		val = lo;
> 
> But since hi > lo by definition, this can be made more efficient with:
> 
> 	if (val > hi)
> 		val = hi;
> 	else if (val < lo)
> 		val = lo;
> 
> So fix up the clamp and clamp_t functions to do this, adding the same
> argument checking as for min and min_t.
> 
> Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Kees Cook <keescook@chromium.org>
> Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
> ---
>  include/linux/minmax.h | 25 +++++++++++++++++++++++--
>  1 file changed, 23 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/minmax.h b/include/linux/minmax.h
> index 5433c08fcc68..30e2e2cd0f44 100644
> --- a/include/linux/minmax.h
> +++ b/include/linux/minmax.h
> @@ -37,6 +37,27 @@
>  		__cmp(x, y, op), \
>  		__cmp_once(x, y, __UNIQUE_ID(__x), __UNIQUE_ID(__y), op))
>  
> +#define __clamp(val, lo, hi)							\
> +	((val) >= (hi) ? (hi) : ((val) <= (lo) ? (lo) : (val)))
> +
> +#define __clamp_once(val, lo, hi, unique_val, unique_lo, unique_hi) ({		\
> +		typeof(val) unique_val = (val);					\
> +		typeof(lo) unique_lo = (lo);					\
> +		typeof(hi) unique_hi = (hi);					\
> +		__clamp(unique_val, unique_lo, unique_hi); })
> +
> +#define __clamp_input_check(lo, hi)						\
> +        (BUILD_BUG_ON_ZERO(__builtin_choose_expr(				\
> +                __is_constexpr((lo) > (hi)), (lo) > (hi), false)))

Nice. :)

> +
> +#define __careful_clamp(val, lo, hi) ({						\
> +	__clamp_input_check(lo, hi) + 						\
> +	__builtin_choose_expr(__typecheck(val, lo) && __typecheck(val, hi) &&	\
> +			      __typecheck(hi, lo) && __is_constexpr(val) && 	\
> +			      __is_constexpr(lo) && __is_constexpr(hi),		\

I really like it! I might have used:

	__safe_cmp(val, lo) && __safe_cmp(val, hi)

instead of the "open coded" __typecheck()s and __is_constexpr()s, but
it's the same result.

> +		__clamp(val, lo, hi),						\
> +		__clamp_once(val, lo, hi, __UNIQUE_ID(__val), __UNIQUE_ID(__lo), __UNIQUE_ID(__hi))); })

*complaint about line being >100 characters, but I don't really care* If
anyone is really bothered, this looks fine, too:

		__clamp_once(val, lo, hi,					\
			     __UNIQUE_ID(__val), __UNIQUE_ID(__lo), __UNIQUE_ID(__hi))); })

*shrug*

> +
>  /**
>   * min - return minimum of two values of the same or compatible types
>   * @x: first value
> @@ -86,7 +107,7 @@
>   * This macro does strict typechecking of @lo/@hi to make sure they are of the
>   * same type as @val.  See the unnecessary pointer comparisons.
>   */
> -#define clamp(val, lo, hi) min((typeof(val))max(val, lo), hi)
> +#define clamp(val, lo, hi) __careful_clamp(val, lo, hi)
>  
>  /*
>   * ..and if you can't take the strict
> @@ -121,7 +142,7 @@
>   * This macro does no typechecking and uses temporary variables of type
>   * @type to make all the comparisons.
>   */
> -#define clamp_t(type, val, lo, hi) min_t(type, max_t(type, val, lo), hi)
> +#define clamp_t(type, val, lo, hi) __careful_clamp((type)(val), (type)(lo), (type)(hi))
>  
>  /**
>   * clamp_val - return a value clamped to a given range using val's type
> -- 
> 2.37.3
> 

Reviewed-by: Kees Cook <keescook@chromium.org>

I can take this unless akpm wants it?

-- 
Kees Cook
