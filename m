Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0504B72BB4D
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 10:53:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234194AbjFLIxk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 04:53:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233781AbjFLIxJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 04:53:09 -0400
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18B5D2D4A;
        Mon, 12 Jun 2023 01:52:25 -0700 (PDT)
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4Qfln22Rxvz9sd2;
        Mon, 12 Jun 2023 10:52:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oltmanns.dev;
        s=MBO0001; t=1686559942;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=T2MJ+F0cRREqc9apuK/Y9l5PP1ml/WVEL7uBUhsIOhM=;
        b=AmtNWOEeOV8ZGTDCiTA9+LwCqvaGtuLcptDiEO4rk8YyGtg4ZXTKSOsAUpCR9qekTdQyek
        bhcca/VR59O4e96l1MfnZbk6TS9tJiwAbWTRht1KBuqDTPw6Bk7BSCAgCDefpPpe5/MJBj
        MX5GsA2AwmKTTqi5nKpYm0lnuE6rvJ2IBLof1mGM/y27LJjbkIoLDJjR47YS79A07wkT7U
        fNCn3EeKZo7qjtwTc/cMMO4U+bPiNSHCJbR4QhCbwLBZmRvAWIfYwSNf1WMRKTGCkHSr1e
        wM60L/hxSSHXnNNCTp7fcK7DtoEbQlfOURqgG8JZUNRdmhJfDajQFZhVM2NHaA==
References: <20230611090143.132257-1-frank@oltmanns.dev>
 <20230611090143.132257-2-frank@oltmanns.dev>
From:   Frank Oltmanns <frank@oltmanns.dev>
To:     Frank Oltmanns <frank@oltmanns.dev>
Cc:     Andre Przywara <andre.przywara@arm.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Maxime Ripard <maxime@cerno.tech>,
        Michael Turquette <mturquette@baylibre.com>,
        Roman Beranek <me@crly.cz>,
        Samuel Holland <samuel@sholland.org>,
        Stephen Boyd <sboyd@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-sunxi@lists.linux.dev
Subject: Re: [PATCH v2 1/2] clk: sunxi-ng: nkm: consider alternative parent
 rates when finding rate
In-reply-to: <20230611090143.132257-2-frank@oltmanns.dev>
Date:   Mon, 12 Jun 2023 10:51:52 +0200
Message-ID: <87edmh12s7.fsf@oltmanns.dev>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I just found in the Allwinner A64 User Manual V1.0, that there are
additional constraints on the combinations for pll-mipi, that are not
(and never were) enforced by by ccu_nkm.

On 2023-06-11 at 11:01:42 +0200, Frank Oltmanns <frank@oltmanns.dev> wrote:
> In case the CLK_SET_RATE_PARENT flag is set, consider using a different
> parent rate when determining a new rate.
>
> To find the best match for the requested rate, perform the following
> steps for each NKM combination:
>  - calculate the optimal parent rate,
>  - find the best parent rate that the parent clock actually supports
>  - use that parent rate to calculate the effective rate.
>
> In case the clk does not support setting the parent rate, use the same
> algorithm as before.
>
> Signed-off-by: Frank Oltmanns <frank@oltmanns.dev>
> ---
>  drivers/clk/sunxi-ng/ccu_nkm.c | 66 +++++++++++++++++++++++++++++-----
>  1 file changed, 58 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/clk/sunxi-ng/ccu_nkm.c b/drivers/clk/sunxi-ng/ccu_nkm.c
> index a0978a50edae..c49d5879fe73 100644
> --- a/drivers/clk/sunxi-ng/ccu_nkm.c
> +++ b/drivers/clk/sunxi-ng/ccu_nkm.c
> @@ -6,6 +6,7 @@
>
>  #include <linux/clk-provider.h>
>  #include <linux/io.h>
> +#include <linux/math.h>
>
>  #include "ccu_gate.h"
>  #include "ccu_nkm.h"
> @@ -16,10 +17,49 @@ struct _ccu_nkm {
>  	unsigned long	m, min_m, max_m;
>  };
>
> -static unsigned long ccu_nkm_find_best(unsigned long parent, unsigned long rate,
> -				       struct _ccu_nkm *nkm)
> +static unsigned long optimal_parent_rate(unsigned long rate, unsigned long n,
> +					 unsigned long k, unsigned long m)
>  {
> -	unsigned long best_rate = 0;
> +	unsigned long _rate, parent;
> +
> +	// We must first try to find the desired parent rate that is rounded up, because there are
> +	// cases where truncating makes us miss the requested rate.
> +	// E.g. rate=449035712, n=11, k=3, m=16
> +	// When truncating, we'd get parent=217714284 and calculating the rate from that would give
> +	// us 449035710. When rounding up, we get parent=217714285 which would give us the requested
> +	// rate of 449035712.
> +	parent = DIV_ROUND_UP(rate * m, n * k);
> +
> +	// But there are other cases, where rounding up the parent gives us a too high rate.
> +	// Therefore, we need to check for this case and, if necessary, truncate the parent rate
> +	// instead of rounding up.
> +	_rate = parent * n * k / m;
> +	if (_rate > rate)
> +		parent = rate * m / (n * k);
> +	return parent;
> +}
> +
> +/**
> + * ccu_nkm_find_best - Find the best nkm combination for a given rate
> + *
> + * @parent: rate of parent clock. This is used either as an input or out parameter:
> + *           - In cases where the parent clock can be set, this parameter will be updated to contain
> + *             the optimal rate for the parent to achieve the best rate for the nkm clock.
> + *           - In cases where the parent clock can not be set, this parameter must contain the
> + *             current rate of the parent, which is used to determine the best combination of n, k,
> + *             and m.
> + * @rate: requested rate.
> + * @nkm: Input/output parameter that contains the clocks constraints on the n, k, m combinations and
> + *       is updated in this function to contain the resulting best n, k, m combination.
> + * @parent_hw: parent clock. If set, this function assumes that the parent clock can be updated to a
> + *             rate that would be best to in order to get as close as possible to @rate. This
> + *             parameter must be set to NULL if this function shall not try to find the optimal
> + *             parent rate for the requested rate.
> + */
> +static unsigned long ccu_nkm_find_best(unsigned long *parent, unsigned long rate,
> +				       struct _ccu_nkm *nkm, struct clk_hw *parent_hw)
> +{
> +	unsigned long best_rate = 0, best_parent_rate = *parent, tmp_parent = *parent;
>  	unsigned long best_n = 0, best_k = 0, best_m = 0;
>  	unsigned long _n, _k, _m;
>
> @@ -28,12 +68,17 @@ static unsigned long ccu_nkm_find_best(unsigned long parent, unsigned long rate,
>  			for (_m = nkm->min_m; _m <= nkm->max_m; _m++) {

According to the manual M/N has to be <= 3. Therefore we need a
different maximum value for the _m-for-loop:

        unsigned long max_m = min(3 * _n, nkm->max_m);
        for (_m = nkm->min_m; _m <= max_m; _m++) {

I suggest that I add an optional member max_mn_ratio to the structs
ccu_nkm and _ccu_nkm. Optional meaning: Ignore if 0.

>  				unsigned long tmp_rate;
>
> -				tmp_rate = parent * _n * _k / _m;
> -
> +				if (parent_hw) {
> +					tmp_parent = optimal_parent_rate(rate, _n, _k, _m);
> +					tmp_parent = clk_hw_round_rate(parent_hw, tmp_parent);
> +				}

Another constraint is PLL-VIDEO0 rate / M >= 24 MHz. Therefore we also
need:
        if (tmp_parent < 24000000 * _m)
                continue;

So, we need another optional member min_m_times_parent or, for
shortness, maybe min_m_parent. I could use help finding a good name for
this.

I guess there needs to be a V3 of this patchset. :)

Regards,
  Frank

> +				tmp_rate = tmp_parent * _n * _k / _m;
>  				if (tmp_rate > rate)
>  					continue;
> +
>  				if ((rate - tmp_rate) < (rate - best_rate)) {
>  					best_rate = tmp_rate;
> +					best_parent_rate = tmp_parent;
>  					best_n = _n;
>  					best_k = _k;
>  					best_m = _m;
> @@ -46,6 +91,8 @@ static unsigned long ccu_nkm_find_best(unsigned long parent, unsigned long rate,
>  	nkm->k = best_k;
>  	nkm->m = best_m;
>
> +	*parent = best_parent_rate;
> +
>  	return best_rate;
>  }
>
> @@ -106,7 +153,7 @@ static unsigned long ccu_nkm_recalc_rate(struct clk_hw *hw,
>  }
>
>  static unsigned long ccu_nkm_round_rate(struct ccu_mux_internal *mux,
> -					struct clk_hw *hw,
> +					struct clk_hw *parent_hw,
>  					unsigned long *parent_rate,
>  					unsigned long rate,
>  					void *data)
> @@ -124,7 +171,10 @@ static unsigned long ccu_nkm_round_rate(struct ccu_mux_internal *mux,
>  	if (nkm->common.features & CCU_FEATURE_FIXED_POSTDIV)
>  		rate *= nkm->fixed_post_div;
>
> -	rate = ccu_nkm_find_best(*parent_rate, rate, &_nkm);
> +	if (!clk_hw_can_set_rate_parent(&nkm->common.hw))
> +		rate = ccu_nkm_find_best(parent_rate, rate, &_nkm, NULL);
> +	else
> +		rate = ccu_nkm_find_best(parent_rate, rate, &_nkm, parent_hw);
>
>  	if (nkm->common.features & CCU_FEATURE_FIXED_POSTDIV)
>  		rate /= nkm->fixed_post_div;
> @@ -159,7 +209,7 @@ static int ccu_nkm_set_rate(struct clk_hw *hw, unsigned long rate,
>  	_nkm.min_m = 1;
>  	_nkm.max_m = nkm->m.max ?: 1 << nkm->m.width;
>
> -	ccu_nkm_find_best(parent_rate, rate, &_nkm);
> +	ccu_nkm_find_best(&parent_rate, rate, &_nkm, NULL);
>
>  	spin_lock_irqsave(nkm->common.lock, flags);
