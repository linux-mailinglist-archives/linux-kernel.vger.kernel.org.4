Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1F72727B35
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 11:26:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235636AbjFHJ0o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 05:26:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232417AbjFHJ0n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 05:26:43 -0400
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9480B2136;
        Thu,  8 Jun 2023 02:26:39 -0700 (PDT)
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4QcJkN0BPlz9spJ;
        Thu,  8 Jun 2023 11:26:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oltmanns.dev;
        s=MBO0001; t=1686216396;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=WC+E0j9/A465/cq9Z16jbdoVUQlkJxw4cJqWxLv9qaU=;
        b=srYmoYFaSKsuPxwSQYGXBs0NnVGljK5EyHlibUc5HzP0yvyraFE3vC1ry4lczDZ162FR0Y
        atte+edyYs0HQ293KnBExruvvmHSZEOyDuraw/dk00jAPkV3xv4PBt3GvOBJGW97GPwvp3
        /4KYmEJramxTGvUcLVRWWibNpUA5xFpNcZ774E8fP5CgLd/3q764hYuQ8+dt9UK9ueFUSL
        J5vt0RyFK3vcJsFpekzgVjT1ME9nMF+SR+mufsIuByrl0uHcY0Oi5zX9UDXTIRfs8QCVpE
        oPrTP6mYed+kLQyxIfJkfukufYSFKx0Plh0nGbcZ0UsGgcQ+DDycw69tf1cJEQ==
References: <20230605190745.366882-1-frank@oltmanns.dev>
 <20230605190745.366882-2-frank@oltmanns.dev>
 <2bvcukogzhcdbfsrruylgw5fbezaqjpcojqaambfoiv5fc2upy@ffumn5sevbeb>
From:   Frank Oltmanns <frank@oltmanns.dev>
To:     Maxime Ripard <maxime@cerno.tech>
Cc:     Andre Przywara <andre.przywara@arm.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Roman Beranek <me@crly.cz>,
        Samuel Holland <samuel@sholland.org>,
        Stephen Boyd <sboyd@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-sunxi@lists.linux.dev
Subject: Re: [PATCH 1/2] clk: sunxi-ng: nkm: consider alternative parent
 rates when finding rate
Date:   Wed, 07 Jun 2023 09:39:35 +0200
In-reply-to: <2bvcukogzhcdbfsrruylgw5fbezaqjpcojqaambfoiv5fc2upy@ffumn5sevbeb>
Message-ID: <875y7y1f0d.fsf@oltmanns.dev>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DATE_IN_PAST_24_48,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Maxime,

On 2023-06-07 at 08:38:39 +0200, Maxime Ripard <maxime@cerno.tech> wrote:
> [[PGP Signed Part:Undecided]]
> On Mon, Jun 05, 2023 at 09:07:44PM +0200, Frank Oltmanns wrote:
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
>>  drivers/clk/sunxi-ng/ccu_nkm.c | 40 ++++++++++++++++++++++++++--------
>>  1 file changed, 31 insertions(+), 9 deletions(-)
>>
>> diff --git a/drivers/clk/sunxi-ng/ccu_nkm.c b/drivers/clk/sunxi-ng/ccu_nkm.c
>> index a0978a50edae..c71e237226f2 100644
>> --- a/drivers/clk/sunxi-ng/ccu_nkm.c
>> +++ b/drivers/clk/sunxi-ng/ccu_nkm.c
>> @@ -16,10 +16,10 @@ struct _ccu_nkm {
>>  	unsigned long	m, min_m, max_m;
>>  };
>>
>> -static unsigned long ccu_nkm_find_best(unsigned long parent, unsigned long rate,
>> -				       struct _ccu_nkm *nkm)
>> +static unsigned long ccu_nkm_find_best(unsigned long *parent, unsigned long rate,
>> +				       struct _ccu_nkm *nkm, struct clk_hw *parent_hw)
>>  {
>> -	unsigned long best_rate = 0;
>> +	unsigned long best_rate = 0, best_parent_rate = 0, tmp_parent = *parent;
>>  	unsigned long best_n = 0, best_k = 0, best_m = 0;
>>  	unsigned long _n, _k, _m;
>>
>> @@ -28,12 +28,29 @@ static unsigned long ccu_nkm_find_best(unsigned long parent, unsigned long rate,
>>  			for (_m = nkm->min_m; _m <= nkm->max_m; _m++) {
>>  				unsigned long tmp_rate;
>>
>> -				tmp_rate = parent * _n * _k / _m;
>> +				if (parent_hw) {
>
> NKM clocks always have a parent
>
> You should test if the CLK_SET_RATE_PARENT flag is set.

ccu_nkm_find_best is called in the following two situations:
 a. from ccu_nkm_set_rate when setting the rate
 b. from ccu_nkm_round_rate when determining the rate

In situation a. we never want ccu_nkm_find_best to try different parent
rates because setting the parent rate is a done deal (at least that's my
understanding).

In situation b. we only want ccu_nkm_find_best to try different parent
rates when, as you mentioned, the CLK_SET_RATE_PARENT flag is set.

So, what this patch does, it provides a NULL pointer as parent_hw when
we don't want ccu_nkm_find_best to try alternative parent rates.

Is it ok if I add a comment to ccu_nkm_find_best that explains the
function and explicitly also the parameters?

I also thought about using two different functions for the two
situations. I have no strong opinion which is better.

However, I don't think we should hand over the flags to this function,
because we'd still only need to provide the parent_hw if we want to find
the optimal parent rate, so having two parametes for the same purpose
seems redundant. Unless, there is a rule to not use NULL pointers.

>
>> +					// We must round up the desired parent rate, because the
>> +					// rounding down happens when calculating tmp_rate. If we
>> +					// round down also here, we'd round down twice.
>> +					unsigned long optimal_parent =
>> +							(rate * _m + (_n * _k - 1)) / _n / _k;
>
> I assume the addition of n * k - 1 is to round up, but I'm not sure we
> should hack around like that.
>
> You should compute the ideal parent rate for a given set of timings, and
> then just call round_rate on it. If the parent wants to round it one way
> or another, that's the parent concern.

I admit that the comment explaining this is not doing the complexity of
this issue any justice. Let me try to explain:

Let's say for our panel the optimal rate for pll-mipi is 449064000. The
best closest we can get is 449035712 with a parent rate of 217714285
(n=11, k=3, m=16).

Eventually, ccu_nkm_find_best is going to be called with 449035712 as
the rate. If we don't round up, like I proposend, but instead calculate:
  optimal_parent = rate * m / n / k
(which is, I think, what you you're proposing) leading to an optimal
parent of 217714284 (!). We can't get 217714284 from the parent (we
could get 217714285, but we're not asking for that) so the parent rounds
down.

To make things worse, this story continues for the new "best rate" as
well.

In the end, ccu_nkm_find_best claims:
 - the optimal rate for 449064000 is 449035712 (parent=217714285, n=11,
   k=3, m=16)
 - but ccu_nkm_find_best would claim that the optimal rate for 449035712
   is 449018181 (parent=235200000, n=7, k=3, m=11)
 - and finally, the optimal rate for 449018181 is 449018180
   (parent=213818181, n=7, k=3, m=10)

This doesn't seem right to me.

But you're also right, in that we can't just always round up. In a
hypothetical example that we request a parent rate of 450000000. With
rounding up, we'd get an optimal parent rate of 218181819 for n=11, k=3,
m=16. And let's now further claim that the parent could provide exactly
that rate, we'd end up with a rate of 450000001. So, we'd overshoot,
which (currently) is not acceptable.

Hmm... I currently can't think of a clever way to solve this other than
this:

    optimal_parent = (rate * _m + (_n * _k - 1)) / _n / _k;
    tmp_parent = clk_hw_round_rate(parent_hw, optimal_parent);
    tmp_rate = tmp_parent * _n * _k / _m;
    if (tmp_rate > rate) {
        optimal_parent = rate * m / n / k
        tmp_parent = clk_hw_round_rate(parent_hw, optimal_parent);
        tmp_rate = tmp_parent * _n * _k / _m;
    }
    if (tmp_parent > optimal_parent)
        continue;

This seems ugly, but at least it should work in all cases. Any opinions?

Cheers,
  Frank

>
> Maxime
>
> [[End of PGP Signed Part]]
