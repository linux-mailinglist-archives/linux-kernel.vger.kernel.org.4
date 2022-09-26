Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDC7E5EA9D2
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 17:11:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235868AbiIZPLr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 11:11:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235459AbiIZPLE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 11:11:04 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FE75ECCD9
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 06:46:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664200007; x=1695736007;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=/UYDK7BRspiYP3xTNkziqak4wiWUPfvCfvdn303pc8c=;
  b=CFJW4zV7mCHBWQU9jeY7VJUKYXdAEWIzWKc9q+6Sk3+NJqjIj1BaSaM1
   MEzWFvllOYofcW+2mFGxSJpBW1P5ordRxXRLxNkaysGopike/Tk90rti2
   IycvjdxvHHgQ3ap7qRGPBcHtLq1YkMRKTd+4Yw0kuorQFkyH1eBPrBXAk
   7v+sGHvKr44/78u1/psX+ynzoVX5zpbbzjSnb7pNmodhOG+9ca07+zQZI
   YyWb51DL1LGHKOe/Vi5r52Vnnpls7I77dx1nH+4NQK1pbALApMrOlCVrS
   txIJMtLML+gXUkYzugCpeg6z0dZjQB/wE6UQisyoqwGPObFuHIkyEF5SQ
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10482"; a="301930705"
X-IronPort-AV: E=Sophos;i="5.93,346,1654585200"; 
   d="scan'208";a="301930705"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2022 06:46:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10482"; a="572219085"
X-IronPort-AV: E=Sophos;i="5.93,346,1654585200"; 
   d="scan'208";a="572219085"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga003.jf.intel.com with ESMTP; 26 Sep 2022 06:46:44 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1ocoRW-007xqO-1s;
        Mon, 26 Sep 2022 16:46:42 +0300
Date:   Mon, 26 Sep 2022 16:46:42 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH v3 1/2] minmax: sanity check constant bounds when clamping
Message-ID: <YzGtQnlG560rXQv9@smile.fi.intel.com>
References: <CAHmME9pRXpTc2g5R-xj7hTrG00iQ6WLSSRooag1NPzJnyV90Nw@mail.gmail.com>
 <20220926133435.1333846-1-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220926133435.1333846-1-Jason@zx2c4.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 26, 2022 at 03:34:34PM +0200, Jason A. Donenfeld wrote:
> The clamp family of functions only makes sense if hi>=lo. If hi and lo
> are compile-time constants, then raise a build error. Doing so has
> already caught buggy code. This also introduces the infrastructure to
> improve the clamping function in subsequent commits.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Thanks!

> Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Kees Cook <keescook@chromium.org>
> Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
> ---
>  include/linux/minmax.h | 26 ++++++++++++++++++++++++--
>  1 file changed, 24 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/minmax.h b/include/linux/minmax.h
> index 5433c08fcc68..293a66ad7830 100644
> --- a/include/linux/minmax.h
> +++ b/include/linux/minmax.h
> @@ -37,6 +37,28 @@
>  		__cmp(x, y, op), \
>  		__cmp_once(x, y, __UNIQUE_ID(__x), __UNIQUE_ID(__y), op))
>  
> +#define __clamp(val, lo, hi)							\
> +	__cmp(__cmp(val, lo, >), hi, <)
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
> +
> +#define __careful_clamp(val, lo, hi) ({						\
> +	__clamp_input_check(lo, hi) + 						\
> +	__builtin_choose_expr(__typecheck(val, lo) && __typecheck(val, hi) &&	\
> +			      __typecheck(hi, lo) && __is_constexpr(val) && 	\
> +			      __is_constexpr(lo) && __is_constexpr(hi),		\
> +		__clamp(val, lo, hi),						\
> +		__clamp_once(val, lo, hi, __UNIQUE_ID(__val),			\
> +			     __UNIQUE_ID(__lo), __UNIQUE_ID(__hi))); })
> +
>  /**
>   * min - return minimum of two values of the same or compatible types
>   * @x: first value
> @@ -86,7 +108,7 @@
>   * This macro does strict typechecking of @lo/@hi to make sure they are of the
>   * same type as @val.  See the unnecessary pointer comparisons.
>   */
> -#define clamp(val, lo, hi) min((typeof(val))max(val, lo), hi)
> +#define clamp(val, lo, hi) __careful_clamp(val, lo, hi)
>  
>  /*
>   * ..and if you can't take the strict
> @@ -121,7 +143,7 @@
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

-- 
With Best Regards,
Andy Shevchenko


