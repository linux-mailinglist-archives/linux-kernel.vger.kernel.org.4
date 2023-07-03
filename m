Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAE3B7457E3
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 10:59:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230299AbjGCI75 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 04:59:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230205AbjGCI7y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 04:59:54 -0400
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A77093;
        Mon,  3 Jul 2023 01:59:50 -0700 (PDT)
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4Qvfxv02dpz9spf;
        Mon,  3 Jul 2023 10:59:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oltmanns.dev;
        s=MBO0001; t=1688374787;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=IgizOrynAySv2dLicDLGl13lYDf7Baoa0hm2ZdTCH8M=;
        b=hzqyvIoY1GLE4APTwgDMqFjTi1N9S0Tr21AZF0v44cOHMOKfT/Sl5UikMRTfTCpR+ZlIKv
        fwWiBr810bLDuL6G0UzbM8DjZzfLmSRJ5YlEof0laYNWHcREuEFkibFe2PejX6+Azx9bhA
        fO9hEx09A8YK5zEOVA8XLmveqfDYJLIFfHXqAJkPcQmJ0InSlPvTrg2akkW7OWS7EBX5Ud
        x/V3GLefSYRBmeYmVAcT5jmbf7pMX73tVpQHUFJMxstF8YVdcMDmXFGp3JIgZdKDcWULLl
        Xl1Iq3KVa3wy2lDMb05t0L90XNzlZUNmc06lmXsBLcTvRadFWLKgF8BJxG8P1w==
References: <20230702-pll-mipi_set_rate_parent-v3-0-46dcb8aa9cbc@oltmanns.dev>
 <20230702-pll-mipi_set_rate_parent-v3-5-46dcb8aa9cbc@oltmanns.dev>
 <87wmzhsbu0.fsf@oltmanns.dev>
 <zvxviyera3zxe2ro5ej52vz2o2vrinu6zo7osddojbys4tuqhd@3f2okcbpf5jr>
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
Subject: Re: [PATCH v3 5/8] clk: sunxi-ng: nkm: Support finding closest rate
In-reply-to: <zvxviyera3zxe2ro5ej52vz2o2vrinu6zo7osddojbys4tuqhd@3f2okcbpf5jr>
Date:   Mon, 03 Jul 2023 10:59:43 +0200
Message-ID: <87jzvhs740.fsf@oltmanns.dev>
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


On 2023-07-03 at 09:25:59 +0200, Maxime Ripard <maxime@cerno.tech> wrote:
> [[PGP Signed Part:Undecided]]
> On Mon, Jul 03, 2023 at 09:17:43AM +0200, Frank Oltmanns wrote:
>>
>> On 2023-07-02 at 19:55:24 +0200, Frank Oltmanns <frank@oltmanns.dev> wrote:
>> > When finding the best rate for a NKM clock, consider rates that are
>> > higher than the requested rate, if the CCU_FEATURE_CLOSEST_RATE flag is
>> > set.
>> >
>> > Accommodate ccu_mux_helper_determine_rate to this change.
>> >
>> > Signed-off-by: Frank Oltmanns <frank@oltmanns.dev>
>> > ---
>> >  drivers/clk/sunxi-ng/ccu_mux.c | 23 +++++++++++++++-----
>> >  drivers/clk/sunxi-ng/ccu_nkm.c | 48 +++++++++++++++++++++++++++++++-----------
>> >  2 files changed, 54 insertions(+), 17 deletions(-)
>> >
>> > diff --git a/drivers/clk/sunxi-ng/ccu_mux.c b/drivers/clk/sunxi-ng/ccu_mux.c
>> > index 1d557e323169..8594d6a4addd 100644
>> > --- a/drivers/clk/sunxi-ng/ccu_mux.c
>> > +++ b/drivers/clk/sunxi-ng/ccu_mux.c
>> > @@ -113,7 +113,7 @@ int ccu_mux_helper_determine_rate(struct ccu_common *common,
>> >  	}
>> >
>> >  	for (i = 0; i < clk_hw_get_num_parents(hw); i++) {
>> > -		unsigned long tmp_rate, parent_rate;
>> > +		unsigned long tmp_rate, parent_rate, best_diff = ULONG_MAX;
>> >  		struct clk_hw *parent;
>> >
>> >  		parent = clk_hw_get_parent_by_index(hw, i);
>> > @@ -139,10 +139,23 @@ int ccu_mux_helper_determine_rate(struct ccu_common *common,
>> >  			goto out;
>> >  		}
>> >
>> > -		if ((req->rate - tmp_rate) < (req->rate - best_rate)) {
>> > -			best_rate = tmp_rate;
>> > -			best_parent_rate = parent_rate;
>> > -			best_parent = parent;
>> > +		if (common->features & CCU_FEATURE_CLOSEST_RATE) {
>> > +			unsigned long tmp_diff = req->rate > tmp_rate ?
>> > +						 req->rate - tmp_rate :
>> > +						 tmp_rate - req->rate;
>> > +
>> > +			if (tmp_diff < best_diff) {
>> > +				best_rate = tmp_rate;
>> > +				best_parent_rate = parent_rate;
>> > +				best_parent = parent;
>> > +				best_diff = tmp_diff;
>> > +			}
>> > +		} else {
>> > +			if ((req->rate - tmp_rate) < (req->rate - best_rate)) {
>> > +				best_rate = tmp_rate;
>> > +				best_parent_rate = parent_rate;
>> > +				best_parent = parent;
>> > +			}
>> >  		}
>> >  	}
>> >
>> > diff --git a/drivers/clk/sunxi-ng/ccu_nkm.c b/drivers/clk/sunxi-ng/ccu_nkm.c
>> > index d83843e69c25..36d9e987e4d8 100644
>> > --- a/drivers/clk/sunxi-ng/ccu_nkm.c
>> > +++ b/drivers/clk/sunxi-ng/ccu_nkm.c
>> > @@ -18,9 +18,11 @@ struct _ccu_nkm {
>> >  };
>> >
>> >  static unsigned long ccu_nkm_find_best_with_parent_adj(unsigned long *parent, unsigned long rate,
>> > -						       struct _ccu_nkm *nkm, struct clk_hw *phw)
>> > +						       struct _ccu_nkm *nkm, struct clk_hw *phw,
>> > +						       unsigned long features)
>> >  {
>> > -	unsigned long best_rate = 0, best_parent_rate = *parent, tmp_parent = *parent;
>> > +	unsigned long best_rate = 0, best_parent_rate = 0, tmp_parent = *parent;
>> > +	unsigned long best_diff = ULONG_MAX;
>> >  	unsigned long best_n = 0, best_k = 0, best_m = 0;
>> >  	unsigned long _n, _k, _m;
>> >
>> > @@ -28,16 +30,26 @@ static unsigned long ccu_nkm_find_best_with_parent_adj(unsigned long *parent, un
>> >  		for (_n = nkm->min_n; _n <= nkm->max_n; _n++) {
>> >  			for (_m = nkm->min_m; _m <= nkm->max_m; _m++) {
>> >  				unsigned long tmp_rate;
>> > +				unsigned long tmp_diff;
>> >
>> >  				tmp_parent = clk_hw_round_rate(phw, rate * _m / (_n * _k));
>> >
>> >  				tmp_rate = tmp_parent * _n * _k / _m;
>> > -				if (tmp_rate > rate)
>> > -					continue;
>> >
>> > -				if ((rate - tmp_rate) < (rate - best_rate)) {
>> > +				if (features & CCU_FEATURE_CLOSEST_RATE) {
>> > +					tmp_diff = rate > tmp_rate ?
>> > +						   rate - tmp_rate :
>> > +						   tmp_rate - rate;
>> > +				} else {
>> > +					if (tmp_rate > rate)
>> > +						continue;
>> > +					tmp_diff = rate - tmp_diff;
>>
>> Sorry, this should of course be tmp_diff = rate - tmp_rate. I'll fix
>> that in v4. Also I'll do tests on my phone where
>> CCU_FEATURE_CLOSEST_RATE is not set (i.e., without PATCH 8), so see if
>> it replicates the old behaviour. I'll also look into adding kunit tests,
>> so that this doesn't happen again. I'm not sure if this is feasible, but
>> I'll ask here for advise, if/when I encounter obstacles.
>
> While this would obviously be great, I don't think we have the
> infrastructure just yet to allow to easily add kunit tests for entire
> clocks.

I think, clk_test.c provides a good blueprint. I tried to do that for
clk-fractional-divider [1], but Stephen wanted to go a different route,
so I dropped it. You could look at clk_fd_test_init() in [1]. A similar
approach might work for the sunxi-ng clocks. I don't see any real
blockers, but maybe that's me being naive.

[1]: https://lore.kernel.org/all/20230614185521.477924-3-frank@oltmanns.dev/

Best regards,
  Frank

>
> Maxime
>
> [[End of PGP Signed Part]]
