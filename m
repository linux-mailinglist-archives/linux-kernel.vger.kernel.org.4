Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DC38745793
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 10:47:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229845AbjGCIrG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 04:47:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjGCIrF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 04:47:05 -0400
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0EC994;
        Mon,  3 Jul 2023 01:47:03 -0700 (PDT)
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4Qvfg767Fkz9sbm;
        Mon,  3 Jul 2023 10:46:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oltmanns.dev;
        s=MBO0001; t=1688374019;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8BKKT7/XaaDmbTWLQ1aTXQDnLvAVecmDZeZnywT7gPU=;
        b=kHy4OJOQ66RBinHFDj8nXIIHaDi5vVeZAd9R9bcJadNs4YA1aDz5ycOOdVdVtqi7ehAWlp
        U58riEooNdxWfPLJfosCmR3jSsr8ZPbQPIbUu/BY3BlAH6dr32jrxBTqa6mS9gpLLF0cTH
        YAXLOxm+AESkFvXHc67yDa3LrkIesdAviPdZ7gsVArEf4+JGJmZkSmjkfbXArnwq2hZPis
        wfBIM8hcYByG1MF11gcvR0fI6/pewd7rK/knYwBOTvAL8ibVtmrGDc0JTCkvMh+TlMsTV/
        0jh1ZfPFN7ibAWjpp+14fSolban+2TPQ3bedoK1bzF1z8KXx/ywclXX+1cxduw==
References: <20230702-pll-mipi_set_rate_parent-v3-0-46dcb8aa9cbc@oltmanns.dev>
 <20230702-pll-mipi_set_rate_parent-v3-4-46dcb8aa9cbc@oltmanns.dev>
 <i3vd7aetybulocuxzs3qnymc2o375bc6bbihnvzqbwt2kf6d5l@cohvb7vxl6q2>
From:   Frank Oltmanns <frank@oltmanns.dev>
To:     Maxime Ripard <maxime@cerno.tech>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Andre Przywara <andre.przywara@arm.com>,
        Roman Beranek <me@crly.cz>, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 4/8] clk: sunxi-ng: nm: Support finding closest rate
In-reply-to: <i3vd7aetybulocuxzs3qnymc2o375bc6bbihnvzqbwt2kf6d5l@cohvb7vxl6q2>
Date:   Mon, 03 Jul 2023 10:46:55 +0200
Message-ID: <87o7kts7pc.fsf@oltmanns.dev>
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


On 2023-07-03 at 09:24:53 +0200, Maxime Ripard <maxime@cerno.tech> wrote:
> [[PGP Signed Part:Undecided]]
> Hi,
>
> On Sun, Jul 02, 2023 at 07:55:23PM +0200, Frank Oltmanns wrote:
>> Incorporate a new function, ccu_nm_find_best_closest, that selects the
>> closest possible rate instead of the closest rate that is less than the
>> requested rate. Utilizing rational_best_approximation has the additional
>> effect of boosting performance in clock rate selection.
>>
>> In cases where the CCU_FEATURE_CLOSEST_RATE flag is set, use
>> ccu_nm_find_best_closest instead of the original ccu_nm_find_best
>> function.
>>
>> Extend the macro SUNXI_CCU_NM_WITH_FRAC_GATE_LOCK_MIN_MAX to allow
>> selecting additional features and update all usages of the macro with no
>> additional flags set.
>>
>> Signed-off-by: Frank Oltmanns <frank@oltmanns.dev>
>> ---
>>  drivers/clk/sunxi-ng/ccu-sun50i-a64.c |  6 ++++--
>>  drivers/clk/sunxi-ng/ccu-sun8i-h3.c   |  3 ++-
>>  drivers/clk/sunxi-ng/ccu-sun8i-r40.c  |  6 ++++--
>>  drivers/clk/sunxi-ng/ccu_nm.c         | 23 +++++++++++++++++++++--
>>  drivers/clk/sunxi-ng/ccu_nm.h         |  6 ++++--
>>  5 files changed, 35 insertions(+), 9 deletions(-)
>>
>> diff --git a/drivers/clk/sunxi-ng/ccu-sun50i-a64.c b/drivers/clk/sunxi-ng/ccu-sun50i-a64.c
>> index a139a5c438d4..ebfab1fdbb96 100644
>> --- a/drivers/clk/sunxi-ng/ccu-sun50i-a64.c
>> +++ b/drivers/clk/sunxi-ng/ccu-sun50i-a64.c
>> @@ -80,7 +80,8 @@ static SUNXI_CCU_NM_WITH_FRAC_GATE_LOCK_MIN_MAX(pll_video0_clk, "pll-video0",
>>  						297000000,	/* frac rate 1 */
>>  						BIT(31),	/* gate */
>>  						BIT(28),	/* lock */
>> -						CLK_SET_RATE_UNGATE);
>> +						CLK_SET_RATE_UNGATE,
>> +						0);		/* features */
>>
>>  static SUNXI_CCU_NM_WITH_FRAC_GATE_LOCK(pll_ve_clk, "pll-ve",
>>  					"osc24M", 0x018,
>> @@ -143,7 +144,8 @@ static SUNXI_CCU_NM_WITH_FRAC_GATE_LOCK_MIN_MAX(pll_video1_clk, "pll-video1",
>>  						297000000,	/* frac rate 1 */
>>  						BIT(31),	/* gate */
>>  						BIT(28),	/* lock */
>> -						CLK_SET_RATE_UNGATE);
>> +						CLK_SET_RATE_UNGATE,
>> +						0);		/* features */
>>
>>  static SUNXI_CCU_NM_WITH_FRAC_GATE_LOCK(pll_gpu_clk, "pll-gpu",
>>  					"osc24M", 0x038,
>> diff --git a/drivers/clk/sunxi-ng/ccu-sun8i-h3.c b/drivers/clk/sunxi-ng/ccu-sun8i-h3.c
>> index bfebe8dbbe65..1e2669648a24 100644
>> --- a/drivers/clk/sunxi-ng/ccu-sun8i-h3.c
>> +++ b/drivers/clk/sunxi-ng/ccu-sun8i-h3.c
>> @@ -76,7 +76,8 @@ static SUNXI_CCU_NM_WITH_FRAC_GATE_LOCK_MIN_MAX(pll_video_clk, "pll-video",
>>  						297000000, /* frac rate 1 */
>>  						BIT(31),   /* gate */
>>  						BIT(28),   /* lock */
>> -						CLK_SET_RATE_UNGATE);
>> +						CLK_SET_RATE_UNGATE,
>> +						0);        /* features */
>>
>>  static SUNXI_CCU_NM_WITH_FRAC_GATE_LOCK(pll_ve_clk, "pll-ve",
>>  					"osc24M", 0x0018,
>> diff --git a/drivers/clk/sunxi-ng/ccu-sun8i-r40.c b/drivers/clk/sunxi-ng/ccu-sun8i-r40.c
>> index 31eca0d3bc1e..63907b86ce06 100644
>> --- a/drivers/clk/sunxi-ng/ccu-sun8i-r40.c
>> +++ b/drivers/clk/sunxi-ng/ccu-sun8i-r40.c
>> @@ -82,7 +82,8 @@ static SUNXI_CCU_NM_WITH_FRAC_GATE_LOCK_MIN_MAX(pll_video0_clk, "pll-video0",
>>  						297000000,  /* frac rate 1 */
>>  						BIT(31),    /* gate */
>>  						BIT(28),    /* lock */
>> -						CLK_SET_RATE_UNGATE);
>> +						CLK_SET_RATE_UNGATE,
>> +						0);         /* features */
>>
>>  /* TODO: The result of N/M is required to be in [8, 25] range. */
>>  static SUNXI_CCU_NM_WITH_FRAC_GATE_LOCK(pll_ve_clk, "pll-ve",
>> @@ -169,7 +170,8 @@ static SUNXI_CCU_NM_WITH_FRAC_GATE_LOCK_MIN_MAX(pll_video1_clk, "pll-video1",
>>  						297000000,  /* frac rate 1 */
>>  						BIT(31),    /* gate */
>>  						BIT(28),    /* lock */
>> -						CLK_SET_RATE_UNGATE);
>> +						CLK_SET_RATE_UNGATE,
>> +						0);         /* features */
>>
>>  static struct ccu_nkm pll_sata_clk = {
>>  	.enable		= BIT(31),
>> diff --git a/drivers/clk/sunxi-ng/ccu_nm.c b/drivers/clk/sunxi-ng/ccu_nm.c
>> index c1fd11542c45..97d8d9e3255c 100644
>> --- a/drivers/clk/sunxi-ng/ccu_nm.c
>> +++ b/drivers/clk/sunxi-ng/ccu_nm.c
>> @@ -6,6 +6,7 @@
>>
>>  #include <linux/clk-provider.h>
>>  #include <linux/io.h>
>> +#include <linux/rational.h>
>>
>>  #include "ccu_frac.h"
>>  #include "ccu_gate.h"
>> @@ -56,6 +57,18 @@ static unsigned long ccu_nm_find_best(unsigned long parent, unsigned long rate,
>>  	return best_rate;
>>  }
>>
>> +static unsigned long ccu_nm_find_best_closest(unsigned long parent, unsigned long rate,
>> +				      struct _ccu_nm *nm)
>> +{
>> +	unsigned long best_rate = 0;
>> +
>> +	rational_best_approximation(rate, parent, nm->max_n, nm->max_m, &nm->n, &nm->m);
>> +
>> +	best_rate = ccu_nm_calc_rate(parent, nm->n, nm->m);
>> +
>> +	return best_rate;
>> +}
>> +
>>  static void ccu_nm_disable(struct clk_hw *hw)
>>  {
>>  	struct ccu_nm *nm = hw_to_ccu_nm(hw);
>> @@ -159,7 +172,10 @@ static long ccu_nm_round_rate(struct clk_hw *hw, unsigned long rate,
>>  	_nm.min_m = 1;
>>  	_nm.max_m = nm->m.max ?: 1 << nm->m.width;
>>
>> -	rate = ccu_nm_find_best(*parent_rate, rate, &_nm);
>> +	if (nm->common.features & CCU_FEATURE_CLOSEST_RATE)
>> +		rate = ccu_nm_find_best_closest(*parent_rate, rate, &_nm);
>> +	else
>> +		rate = ccu_nm_find_best(*parent_rate, rate, &_nm);
>
> So this ends up creating a completely different path and algo for the
> "closest" case, and I'm not super comfortable with that.

What I like about this (and why I proposed it), is that we can use the
same functionality that is proven to work well in other clocks. So, this
would bring us closer to other (not sunxi-ng) clocks, many of which are
using the clk-fractional-divider directly. We can't do that in
sunxi-ng, because we still need to control when overshooting is fine and
when it is not fine. Other frameworks don't make that distinction.

I thougth about if it was possible to scrap most of ccu_nm and replace
it with clk-fractional-divider, but due to this limitation I did not see
a good way forward there. I see the following options:
 a. Add a flag to clk-fractional-divider to support clocks that must not
    overshoot. --> I don't think, I want to do that.
 b. Analyze if it's it's really a requirement for ccu_nm to support
    clocks that don't overshoot. --> I don't know who could / would take
    up such a task, given that the current structure is proven to work.
 c. Add a new clock ccu_fd that uses clk-fractional-divider internally
    and must only be used by clock's that allow overshooting - such as
    A64's pll-video0. --> This could work as a migration path for
    scenario b as well. But it's even more complex than what I'm
    proposing in this patch, so I'm not sure how much you'd like that.

Anyway, all of this seems rather involved and therefore, for this
patchset it makes sense to follow your proposal below.

>
> I think you can simplify this a bit by creating a comparison function
> that will take two rates and a set of flags and will behave differently
> depending on whether CCU_FEATURE_CLOSEST_RATE is set, like
> mux_is_better_rate is doing for example.
>
> You'll also avoid code duplication that way that can be shown a bit in
> you subsequent patches.

I'll look into that.

>
>>
>>  	if (nm->common.features & CCU_FEATURE_FIXED_POSTDIV)
>>  		rate /= nm->fixed_post_div;
>> @@ -210,7 +226,10 @@ static int ccu_nm_set_rate(struct clk_hw *hw, unsigned long rate,
>>  					   &_nm.m, &_nm.n);
>>  	} else {
>>  		ccu_sdm_helper_disable(&nm->common, &nm->sdm);
>> -		ccu_nm_find_best(parent_rate, rate, &_nm);
>> +		if (nm->common.features & CCU_FEATURE_CLOSEST_RATE)
>> +			ccu_nm_find_best_closest(parent_rate, rate, &_nm);
>> +		else
>> +			ccu_nm_find_best(parent_rate, rate, &_nm);
>>  	}
>>
>>  	spin_lock_irqsave(nm->common.lock, flags);
>> diff --git a/drivers/clk/sunxi-ng/ccu_nm.h b/drivers/clk/sunxi-ng/ccu_nm.h
>> index 2904e67f05a8..a3825c4e8d42 100644
>> --- a/drivers/clk/sunxi-ng/ccu_nm.h
>> +++ b/drivers/clk/sunxi-ng/ccu_nm.h
>> @@ -116,7 +116,8 @@ struct ccu_nm {
>>  						 _frac_en, _frac_sel,	\
>>  						 _frac_rate_0,		\
>>  						 _frac_rate_1,		\
>> -						 _gate, _lock, _flags)	\
>> +						 _gate, _lock, _flags,	\
>> +						 _features)		\
>>  	struct ccu_nm _struct = {					\
>>  		.enable		= _gate,				\
>>  		.lock		= _lock,				\
>> @@ -129,7 +130,8 @@ struct ccu_nm {
>>  		.max_rate	= _max_rate,				\
>>  		.common		= {					\
>>  			.reg		= _reg,				\
>> -			.features	= CCU_FEATURE_FRACTIONAL,	\
>> +			.features	= CCU_FEATURE_FRACTIONAL |	\
>> +					  _features,	\
>
> It's a bit odd to me that some features are set by the macro function,
> and some are passed as an argument. I'm fine with either but we
> shouldn't allow both.
>
> It looks like (for NM clocks at least) we would only need the round
> closest flag for pll-video0, so we could maybe just add a new variant of
> the macro which will also reduce the changes in that patch.

Ok. I'll address that in v4.

>
> Maxime
>
> [[End of PGP Signed Part]]
