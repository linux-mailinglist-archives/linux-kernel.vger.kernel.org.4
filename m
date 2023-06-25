Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5D5173D02C
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Jun 2023 12:46:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231688AbjFYKqN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Jun 2023 06:46:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230465AbjFYKqJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Jun 2023 06:46:09 -0400
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [IPv6:2001:67c:2050:0:465::202])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA837E4F;
        Sun, 25 Jun 2023 03:46:07 -0700 (PDT)
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:b231:465::1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4QpnhB0JYyz9sSq;
        Sun, 25 Jun 2023 12:46:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oltmanns.dev;
        s=MBO0001; t=1687689962;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kKhuHPV17HEOsXIDx1u91H9Dzw6TJlM2wdyZXCpCSZY=;
        b=JmpgZsrs8UUApbtKkjpXh+6ZRD/xTLPepvCw/G80dGvy1g6L7LKrt/qeZPmWTwbkA8SinH
        OJw6LvcPMoZ37Op7Wz4Yp7TvFTI0imO2cV5UaZgcPKpC/jS8Re7k8UJy7xxYq8k7fxNIjg
        UBxdsHP/tnC+qTxp4e6t4eAYFgLrzPR71kIQByKOqMQ/DezQ52oCDT1+77WGuFba33kEas
        b1xjWviSxxnmLYkgpk+O1vVMHjva/WTdj3gCDR6Itm99I5+VAnvahqW4mXUwf2bJVJrGp+
        D4sAmMLMtYLU6R0Uztd6PjcN2DyiWLNOsW+E79fSfchfLzXMWq6IhfAHHqspsQ==
References: <20230611090143.132257-1-frank@oltmanns.dev>
 <20230611090143.132257-2-frank@oltmanns.dev> <87edmh12s7.fsf@oltmanns.dev>
 <sfni3vehkhotsqrrirklhzrxzkcxzkq6nbtqokeab5if3jgm53@frh7z3iowsfe>
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
Subject: Re: [PATCH v2 1/2] clk: sunxi-ng: nkm: consider alternative parent
 rates when finding rate
In-reply-to: <sfni3vehkhotsqrrirklhzrxzkcxzkq6nbtqokeab5if3jgm53@frh7z3iowsfe>
Date:   Sun, 25 Jun 2023 12:45:45 +0200
Message-ID: <878rc7stuu.fsf@oltmanns.dev>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Queue-Id: 4QpnhB0JYyz9sSq
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Maxime,

On 2023-06-12 at 14:31:21 +0200, Maxime Ripard <maxime@cerno.tech> wrote:
> [[PGP Signed Part:Undecided]]
> On Mon, Jun 12, 2023 at 10:51:52AM +0200, Frank Oltmanns wrote:
>> > @@ -28,12 +68,17 @@ static unsigned long ccu_nkm_find_best(unsigned long parent, unsigned long rate,
>> >  			for (_m = nkm->min_m; _m <= nkm->max_m; _m++) {
>>
>> According to the manual M/N has to be <= 3. Therefore we need a
>> different maximum value for the _m-for-loop:
>>
>>         unsigned long max_m = min(3 * _n, nkm->max_m);
>>         for (_m = nkm->min_m; _m <= max_m; _m++) {
>>
>> I suggest that I add an optional member max_mn_ratio to the structs
>> ccu_nkm and _ccu_nkm. Optional meaning: Ignore if 0.
>
> Which workload is affected by this restriction?
>

Firstly, the restriction increases the minimum rate that pll-mipi of the
A64 SoC can use. The rate off pll-mipi is
        pll-video0 * K * N / M

The Allwinner's user manual ([1], p.94) states that the maximum ratio of
M/N (note how numerator and denominator changed) is 3. So, looking back
to the original formula, the N / M part can be at most 1/3. That
effectively limits the minimum rate that pll-mipi can provide to
        min(pll-video0) * 2 * 1 / 3

The minimum rate of pll-video0 is 192 MHz, i.e., the minimum rate for
pll-mipi becomes 128 MHz. Without the restriction, the minimum rate
currently is 24 MHz. It is my (albeit limited) understanding, that is no
real limitation because no panel would request such low rates. I should
also mention that Allwinner states in the user manual ([1], p. 94) that
the rate must be in the 500 MHz - 1.4 GHz range.

Secondly, it decreases the number of options for M for all N <= 6.
Therefore it reduces the number of meaningful NKM combinations from 275
(without the restriction) to 238. (With meaningful combinations, I mean
the combinations that result in a different rate for pll-mipi, e.g.,
K=2, M=1, N=2 is the same as K=4, M=1, N=1). The consequence is that the
precision of pll-mipi is slightly reduced. Note, however, that this loss
of precision is more than offset by the option that pll-mipi can now
"freely" choose its parent rate.

In conclusion, I don't see any real world limitation that this
restriction introduces.

>> >  				unsigned long tmp_rate;
>> >
>> > -				tmp_rate = parent * _n * _k / _m;
>> > -
>> > +				if (parent_hw) {
>> > +					tmp_parent = optimal_parent_rate(rate, _n, _k, _m);
>> > +					tmp_parent = clk_hw_round_rate(parent_hw, tmp_parent);
>> > +				}
>>
>> Another constraint is PLL-VIDEO0 rate / M >= 24 MHz. Therefore we also need:
>>         if (tmp_parent < 24000000 * _m)
>>                 continue;
>>
>> So, we need another optional member min_m_times_parent or, for
>> shortness, maybe min_m_parent. I could use help finding a good name for
>> this.
>
> Again, if it's not causing any harm I'd rather keep the code as simple
> and maintainable as possible.

Unfortunately, in Allwinner's User Manual, I could not find any
consequences of driving the SoC outside its specifications. Maybe
someone with more experience in that area could weigh in here.

I want to highlight, though, that currently (i.e., without this patch
series), the rate of pll-video0 is not set by the kernel. So in most
installations, it probably runs at 294 (u-boot) or 297 MHz (default
rate). That allows for M to be smaller than or equal to 12. But with
this patch series, we set pll-video0 to any rate that pll-mipi requests.
Where previously, people could have hand-crafted rates that were within
the SoC's specification - based on a well-known pll-video0 rate - this
no longer applies.

Therefore, I think we should be careful not to request rates from the
parent that drives pll-mipi outside its specification. What do you think
about implementing the min_m_parent functionality in a separate patch?
That would probably facilitate the assessment of the patch from a
simplicity and maintenance perspective. If we agree on a way forward, I
can still squash it with other patches in a later version of this patch
series. But if you are not convinced, I can simply drop it at any point
- including now ;).

In short, I don't know if violating the restriction causes any harm in a
real-world application. However, Allwinner may have reasons for listing
such limitations, even if they don't tell us the details. Those are my
two cents.

Thanks for your feedback,
  Frank

[1] https://github.com/OLIMEX/OLINUXINO/blob/027087da32d69651a58a4e6193bedadef9c036ec/DOCUMENTS/A64-PDFs/Allwinner%20A64%20User%20Manual%20v1.0.pdf

>
> Maxime
>
> [[End of PGP Signed Part]]
