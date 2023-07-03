Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D05E7456C0
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 10:03:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230088AbjGCIDM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 04:03:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231126AbjGCICn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 04:02:43 -0400
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [IPv6:2001:67c:2050:0:465::101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9E8B1994;
        Mon,  3 Jul 2023 01:02:20 -0700 (PDT)
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4QvdgX1rWXz9smc;
        Mon,  3 Jul 2023 10:02:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oltmanns.dev;
        s=MBO0001; t=1688371336;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=eJqGcK86nu+Tj/k/Nnx0V17iyu2NlxwPh1TXpPUIkuI=;
        b=TiBzr8CjGgz8pvWu3Eh6dO/ajYlZTZAIzZ7DqPZog9OojLFxJDXquWD2onATkCrhscI3ds
        aofx4mW9TDYwXadTnlfnA4+SoqztiVWUWEym7hE8ugNzBSOcMIzPHDWWmMtia6TtILYQ3P
        GgeTlk1PEbdLqx62ajGk4PbEo+BCcqljdxgVdmyN6xRta5WEDIdws2ukTOcfzGRE0fqUr7
        fGd7DmJzUq5h8KhOr6ndmKqXEfgjBW677pAHmsv8aBzvYfDRUqiQ/o8UtK8Iejk43JHuzW
        BAJXL6RNPoClDboSCysw7FeCdjO2K4ZzUOfeoGG5fFAThb3y9a/EKdTbJq2j0A==
References: <20230702-pll-mipi_set_rate_parent-v3-0-46dcb8aa9cbc@oltmanns.dev>
 <20230702-pll-mipi_set_rate_parent-v3-1-46dcb8aa9cbc@oltmanns.dev>
 <uxa7smoywmh75pzmpipdqbctbza6gjlqke3v7j4ijpfc3k4jul@dcxwsiajoomb>
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
Subject: Re: [PATCH v3 1/8] clk: sunxi-ng: nkm: consider alternative parent
 rates when determining rate
In-reply-to: <uxa7smoywmh75pzmpipdqbctbza6gjlqke3v7j4ijpfc3k4jul@dcxwsiajoomb>
Date:   Mon, 03 Jul 2023 10:02:12 +0200
Message-ID: <87sfa5s9rv.fsf@oltmanns.dev>
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


On 2023-07-03 at 08:47:43 +0200, Maxime Ripard <maxime@cerno.tech> wrote:
> [[PGP Signed Part:Undecided]]
> Hi,
>
> On Sun, Jul 02, 2023 at 07:55:20PM +0200, Frank Oltmanns wrote:
>> In case the CLK_SET_RATE_PARENT flag is set, consider using a different
>> parent rate when determining a new rate.
>>
>> To find the best match for the requested rate, perform the following
>> steps for each NKM combination:
>>  - calculate the optimal parent rate,
>>  - find the best parent rate that the parent clock actually supports
>>  - use that parent rate to calculate the effective rate.
>>
>> In case the clk does not support setting the parent rate, use the same
>> algorithm as before.
>>
>> Signed-off-by: Frank Oltmanns <frank@oltmanns.dev>
>> ---
>>  drivers/clk/sunxi-ng/ccu_nkm.c | 48 +++++++++++++++++++++++++++++++++++++++---
>>  1 file changed, 45 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/clk/sunxi-ng/ccu_nkm.c b/drivers/clk/sunxi-ng/ccu_nkm.c
>> index a0978a50edae..d83843e69c25 100644
>> --- a/drivers/clk/sunxi-ng/ccu_nkm.c
>> +++ b/drivers/clk/sunxi-ng/ccu_nkm.c
>> @@ -6,6 +6,7 @@
>>
>>  #include <linux/clk-provider.h>
>>  #include <linux/io.h>
>> +#include <linux/math.h>
>>
>>  #include "ccu_gate.h"
>>  #include "ccu_nkm.h"
>> @@ -16,6 +17,44 @@ struct _ccu_nkm {
>>  	unsigned long	m, min_m, max_m;
>>  };
>>
>> +static unsigned long ccu_nkm_find_best_with_parent_adj(unsigned long *parent, unsigned long rate,
>> +						       struct _ccu_nkm *nkm, struct clk_hw *phw)
>
> The usual order in that driver (and Linux in general) would make the
> clk_hw and nkm structure pointers first, and then the parent rate and
> rate.

I'll address that in v4.

>
> But something looks off to me: ccu_nkm_find_best_with_parent_adj takes a
> pointer to the parent rate which makes sense since we're going to modify
> it.
>
>> +{
>> +	unsigned long best_rate = 0, best_parent_rate = *parent, tmp_parent = *parent;
>> +	unsigned long best_n = 0, best_k = 0, best_m = 0;
>> +	unsigned long _n, _k, _m;
>> +
>> +	for (_k = nkm->min_k; _k <= nkm->max_k; _k++) {
>> +		for (_n = nkm->min_n; _n <= nkm->max_n; _n++) {
>> +			for (_m = nkm->min_m; _m <= nkm->max_m; _m++) {
>> +				unsigned long tmp_rate;
>> +
>> +				tmp_parent = clk_hw_round_rate(phw, rate * _m / (_n * _k));
>> +
>> +				tmp_rate = tmp_parent * _n * _k / _m;
>> +				if (tmp_rate > rate)
>> +					continue;
>> +
>> +				if ((rate - tmp_rate) < (rate - best_rate)) {
>> +					best_rate = tmp_rate;
>> +					best_parent_rate = tmp_parent;
>> +					best_n = _n;
>> +					best_k = _k;
>> +					best_m = _m;
>> +				}
>> +			}
>> +		}
>> +	}
>> +
>> +	nkm->n = best_n;
>> +	nkm->k = best_k;
>> +	nkm->m = best_m;
>> +
>> +	*parent = best_parent_rate;
>> +
>> +	return best_rate;
>> +}
>> +
>>  static unsigned long ccu_nkm_find_best(unsigned long parent, unsigned long rate,
>>  				       struct _ccu_nkm *nkm)
>
> You haven't modified ccu_nkm_find_best though, and it still takes the
> parent rate value.
>
>>  {
>> @@ -106,7 +145,7 @@ static unsigned long ccu_nkm_recalc_rate(struct clk_hw *hw,
>>  }
>>
>>  static unsigned long ccu_nkm_round_rate(struct ccu_mux_internal *mux,
>> -					struct clk_hw *hw,
>> +					struct clk_hw *parent_hw,
>
> (This should be another patch)

Ok, will do in v4.

>
>>  					unsigned long *parent_rate,
>>  					unsigned long rate,
>>  					void *data)
>> @@ -124,7 +163,10 @@ static unsigned long ccu_nkm_round_rate(struct ccu_mux_internal *mux,
>>  	if (nkm->common.features & CCU_FEATURE_FIXED_POSTDIV)
>>  		rate *= nkm->fixed_post_div;
>>
>> -	rate = ccu_nkm_find_best(*parent_rate, rate, &_nkm);
>
> parent_rate is a pointer, we were dereferencing it to pass its value to
> ccu_nkm_find_best. All good so far.
>
>> +	if (!clk_hw_can_set_rate_parent(&nkm->common.hw))
>> +		rate = ccu_nkm_find_best(*parent_rate, rate, &_nkm);
>
> Still passing by value
>
>> +	else
>> +		rate = ccu_nkm_find_best_with_parent_adj(parent_rate, rate, &_nkm, parent_hw);
>
> And passing the pointer there since it takes a pointer. Still good.
>
>>
>>  	if (nkm->common.features & CCU_FEATURE_FIXED_POSTDIV)
>>  		rate /= nkm->fixed_post_div;
>> @@ -159,7 +201,7 @@ static int ccu_nkm_set_rate(struct clk_hw *hw, unsigned long rate,
>>  	_nkm.min_m = 1;
>>  	_nkm.max_m = nkm->m.max ?: 1 << nkm->m.width;
>>
>> -	ccu_nkm_find_best(parent_rate, rate, &_nkm);
>> +	ccu_nkm_find_best(&parent_rate, rate, &_nkm);
>
> But here, we're passing a pointer to parent_rate to ccu_nkm_find_best,
> while it's still supposed to take it by value?

Ugh. Yeah, sorry. I had that error in V2 but squashed the correction
into patch 5 instead of patch 1. I'll fix that in v4.

Thanks,
  Frank

>
> Maxime
>
> [[End of PGP Signed Part]]
