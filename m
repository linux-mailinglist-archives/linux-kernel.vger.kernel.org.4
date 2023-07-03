Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFB65745837
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 11:18:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230348AbjGCJSN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 05:18:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230112AbjGCJSI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 05:18:08 -0400
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52DB4E67;
        Mon,  3 Jul 2023 02:17:51 -0700 (PDT)
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4QvgLZ490vz9sqJ;
        Mon,  3 Jul 2023 11:17:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oltmanns.dev;
        s=MBO0001; t=1688375862;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wzL5L1lBY5rqvf78gNGZQXkCiKNDPWm58F8aOJ0dj7I=;
        b=G0ywYUvJ5zFc39jBJU87AUoesBe8B95rVsm9BKiVgv+kPdQO/Ep9vKlEOKYnlQnH/UYifx
        twGWoW8qkjEYbiQEg1riRhCP85B/BW/XuyAlMMf9nLprqZD+B+hxCRnNcJgfP6bCi/Ev50
        iShVRoQxQZ3LF0Jnxl277TobXcWIOhyLhL7dJ3F60jENETfxIkaNLnN7vVtjkLpEAEloCs
        nchnT5/G3+XyrSTUGFsDx6nSbcArbr06pX1eLKJliPorsBMKYlmujMFi8o7mihP2rv8wob
        tIEiq6uZyKMbAjZujN4L0h6iDcWRlLTIb7ak1O3cwHiHCnQ4DZdKLfAAt2A4bQ==
References: <20230702-pll-mipi_set_rate_parent-v3-0-46dcb8aa9cbc@oltmanns.dev>
 <20230702-pll-mipi_set_rate_parent-v3-6-46dcb8aa9cbc@oltmanns.dev>
 <b7gnap57aajkbhbbcbgallvqjdc7nzppjjwnancgmm5ibmhdaq@cftau72qyjdu>
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
Subject: Re: [PATCH v3 6/8] clk: sunxi-ng: mux: Support finding closest rate
In-reply-to: <b7gnap57aajkbhbbcbgallvqjdc7nzppjjwnancgmm5ibmhdaq@cftau72qyjdu>
Date:   Mon, 03 Jul 2023 11:17:24 +0200
Message-ID: <87fs65s6aj.fsf@oltmanns.dev>
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


On 2023-07-03 at 09:38:48 +0200, Maxime Ripard <maxime@cerno.tech> wrote:
> [[PGP Signed Part:Undecided]]
> On Sun, Jul 02, 2023 at 07:55:25PM +0200, Frank Oltmanns wrote:
>> When finding the best rate for a mux clock, consider rates that are
>> higher than the requested rate by introducing a new clk_ops structure
>> that uses the existing __clk_mux_determine_rate_closest function.
>> Furthermore introduce an initialization macro that uses this new
>> structure.
>>
>> Signed-off-by: Frank Oltmanns <frank@oltmanns.dev>
>> ---
>>  drivers/clk/sunxi-ng/ccu_mux.c | 13 +++++++++++++
>>  drivers/clk/sunxi-ng/ccu_mux.h | 17 +++++++++++++++++
>>  2 files changed, 30 insertions(+)
>>
>> diff --git a/drivers/clk/sunxi-ng/ccu_mux.c b/drivers/clk/sunxi-ng/ccu_mux.c
>> index 8594d6a4addd..49a592bdeacf 100644
>> --- a/drivers/clk/sunxi-ng/ccu_mux.c
>> +++ b/drivers/clk/sunxi-ng/ccu_mux.c
>> @@ -264,6 +264,19 @@ static unsigned long ccu_mux_recalc_rate(struct clk_hw *hw,
>>  					   parent_rate);
>>  }
>>
>> +const struct clk_ops ccu_mux_closest_ops = {
>> +	.disable	= ccu_mux_disable,
>> +	.enable		= ccu_mux_enable,
>> +	.is_enabled	= ccu_mux_is_enabled,
>> +
>> +	.get_parent	= ccu_mux_get_parent,
>> +	.set_parent	= ccu_mux_set_parent,
>> +
>> +	.determine_rate	= __clk_mux_determine_rate_closest,
>> +	.recalc_rate	= ccu_mux_recalc_rate,
>> +};
>> +EXPORT_SYMBOL_NS_GPL(ccu_mux_closest_ops, SUNXI_CCU);
>> +
>
> This is also a bit inconsistent with the other clocks: most (all?) of
> them will simply handle this through a flag, but this one requires a new
> set of clk_ops as well?
>
> I think we should create our own wrapper here around
> __clk_mux_determine_rate and either call
> __clk_mux_determine_rate_closest or __clk_mux_determine_rate depending
> on the state of the flags, or call __clk_mux_determine_rate_flags with
> the proper flags set for our clock.
>
> The former is probably slightly simpler.

Ok, I will address that in v4.

>
>>  const struct clk_ops ccu_mux_ops = {
>>  	.disable	= ccu_mux_disable,
>>  	.enable		= ccu_mux_enable,
>> diff --git a/drivers/clk/sunxi-ng/ccu_mux.h b/drivers/clk/sunxi-ng/ccu_mux.h
>> index 2c1811a445b0..c4ee14e43719 100644
>> --- a/drivers/clk/sunxi-ng/ccu_mux.h
>> +++ b/drivers/clk/sunxi-ng/ccu_mux.h
>> @@ -46,6 +46,22 @@ struct ccu_mux {
>>  	struct ccu_common	common;
>>  };
>>
>> +#define SUNXI_CCU_MUX_TABLE_WITH_GATE_CLOSEST(_struct, _name, _parents, _table,	\
>> +				     _reg, _shift, _width, _gate,	\
>> +				     _flags)				\
>> +	struct ccu_mux _struct = {					\
>> +		.enable	= _gate,					\
>> +		.mux	= _SUNXI_CCU_MUX_TABLE(_shift, _width, _table),	\
>> +		.common	= {						\
>> +			.reg		= _reg,				\
>> +			.hw.init	= CLK_HW_INIT_PARENTS(_name,	\
>> +							      _parents, \
>> +							      &ccu_mux_closest_ops, \
>> +							      _flags),	\
>> +			.features	= CCU_FEATURE_CLOSEST_RATE,	\
>> +		}							\
>> +	}
>> +
>
> I'm fine with that one, but like we discussed on the NM (I think?) patch
> already, this creates some clocks and macros that will use the feature
> as a flag, and some will encode it into their name.
>
> Given that we need it here too, I'm really inclined to prefer what you
> did there, and thus create a new macro for pll-video0 instead of
> modifying the existing one.

Ok. Just to be clear: What I did in this patch is fine and I should use
the same approach for NM. Did I get that right?

Thanks,
  Frank

>
> Maxime
>
> [[End of PGP Signed Part]]
