Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDA6D7255D6
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 09:36:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232517AbjFGHgU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 03:36:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239800AbjFGHfr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 03:35:47 -0400
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 741EC10D2;
        Wed,  7 Jun 2023 00:35:35 -0700 (PDT)
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4QbfJg6xQMz9smV;
        Wed,  7 Jun 2023 09:35:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oltmanns.dev;
        s=MBO0001; t=1686123332;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=DQz0BkcH35hQLm3KjeljrzdxrPKkYEXuRwVXLyaLMKk=;
        b=FT70/16Q8OGXxY+Rmc9LSho9yADPBkWrdZWlobH5A8EWzR/fHAWf/xyT1ttJKCEJK76zDB
        DksuWzc/v9pg2SS6t+PyceoptaofhXe6GZgnZXlQA0SjgtH5OXApqIb11xAtkLgxlRWXW7
        Jrpveca3LLoorR/iu/haCW4QC+p5DbXsF2xdVy66pAnm3tbfJWI1CZsb7amL6pU7c3u7dA
        xglQTTVJuKd4YN/BtbmL78XExuW1zftU8ehzVMZ4Q17iacCyoWi/vZ73hV5byZWHrQqYuG
        2BecKpAr456fhcYqE2jq5zLTOrvgzNs40rG7SjpaJ2+RcKNlg14682ERcdZuHw==
References: <20230605190745.366882-1-frank@oltmanns.dev>
From:   Frank Oltmanns <frank@oltmanns.dev>
To:     Andre Przywara <andre.przywara@arm.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Maxime Ripard <maxime@cerno.tech>,
        Michael Turquette <mturquette@baylibre.com>,
        Roman Beranek <me@crly.cz>,
        Samuel Holland <samuel@sholland.org>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-sunxi@lists.linux.dev
Subject: Re: [PATCH 0/2] clk: sunxi-ng: Consider alternative parent rates
 when determining NKM clock rate
In-reply-to: <20230605190745.366882-1-frank@oltmanns.dev>
Date:   Wed, 07 Jun 2023 09:35:20 +0200
Message-ID: <87legv2093.fsf@oltmanns.dev>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-06-05 at 21:07:43 +0200, Frank Oltmanns <frank@oltmanns.dev> wrote:
> I would like to share a patchset that enables the NKM clock in pll-video0 to
> consider alternative parent rates. I have found this feature particularly useful
> to adjust the pll-video0's clock on Allwinner A64, as it allows me to achieve an
> optimal rate for driving the board's panel (in my case, the Pinephone).
>
> To provide some context, the clock structure involved in this process is as follows:
>     clock                       clock type
>     --------------------------------------
>     pll-video0                  ccu_nm
>        pll-mipi                 ccu_nkm
>           tcon0                 ccu_mux
>              tcon-data-clock    sun4i_dclk
>
> The divider between tcon0 and tcon-data-clock is fixed at 4. Therefore, in order
> to achieve a rate that closely matches the desired rate of the panel, I need
> pll-mipi to operate at a specific rate.
>
> However, I must emphasize that setting the parent's rate for NKM clocks results
> in a significant increase in the time required to find the optimal rate. For
> instance, setting DCLK on the pinephone has seen a 60-fold increase in the time
> taken, from approximately 0.5 ms to around 30 ms. These figures were obtained
> through informal measurements on my pinephone, involving kernel logging and a
> few reboots. The worst-case scenario observed was approximately 37 ms, while the
> majority of cases were just under 30 ms.
>
> The reason for this considerable increase in time is that the code now iterates
> over all combinations of NKM for pll-mipi. For each combination, it subsequently
> iterates over all combinations of NM for pll-video0.

I don't know if this increase is problematic, but if it is, there are
options to mitigate it:
 a. Binary search for finding parent rate:
    Precalculate an _ordered_ table of meaningful combinations of NM for
    pll-video0. That means that combinations that result in the same
    clock rate shall only be listed once. For example, since both
      { .n = 8, .m = 1} and  { .n = 16, .m = 2 }
    are valid values for n and m, only one of them would be allowed
    because both result in a factor of 8.

    Furthermore, the table should only contain combinations that can
    result in a valid clock rate. I.e., since the parent is a fixed rate
    clock at 24 MHz and the ccu_nm's min_rate is 192 MHz, the
    combination
      { .n = 1, .m = 1 }
    should _not_ appear in the table as the resulting rate would be 96
    MHz.

    Utilizing this table, we can then do a binary search in
    ccu_nm_find_best instead of iterating over all combinations of NM.

 b. rational_best_approximation for finding parent rate:
    Using the rational best approximation from linux/rational.h for the
    parent's rate also significantly reduces the time. Instead of
    iterating over all combinations of NM, the algorithm uses continued
    fractions to "calculate best rational approximation for a given
    fraction taking into account restricted register size" (quote from
    the function's description).

    This reduces the ccu_nm_find_best function to the following two
    lines:
       rational_best_approximation(rate, parent, nm->max_n, nm->max_m, &nm->n, &nm->m);
       return ccu_nm_calc_rate(parent, nm->n, nm->m);

I did a rough implementation of both and found that both approaches
reduce the time spent to set DCLK to less than 2 ms, i.e., not quite the
original 0.5 ms, but not as bad as 30 ms.

Option a. either requires addional ROM space if we generate the table
off-line or some code to generate the table during initialization (which
of course would also require time to execute, but only once).

Option b. finds the closest approximation, whereas the current
implementation of ccu_nm_find_rate finds the closest rate that is less
than the requested rate. This means that option b. requires that all of
pll-video0's children (and grand-children a.s.o.) support rates higher
than the requested rate. Currently, the sunxi-ng driver in a lot of
places only expects rates that are less than the requested rate, so all
of these would need to be changed.

So, my question: Is spending the 30 ms fine or do I need to optimize for
speed in order for this patchset to be accepted? Or is 2 ms also too
much of an increase, in which case I'm out of ideas. :-)

I'm looking forward to receiving your feedback.

Thanks,
  Frank

> I greatly appreciate your feedback and suggestions for further improving this
> patchset.
>
> Thanks,
>   Frank
>
> Frank Oltmanns (2):
>   clk: sunxi-ng: nkm: consider alternative parent rates when finding
>     rate
>   clk: sunxi-ng: a64: allow pll-mipi to set parent's rate
>
>  drivers/clk/sunxi-ng/ccu-sun50i-a64.c |  3 +-
>  drivers/clk/sunxi-ng/ccu_nkm.c        | 40 +++++++++++++++++++++------
>  2 files changed, 33 insertions(+), 10 deletions(-)
