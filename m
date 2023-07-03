Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5B6E745880
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 11:36:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230247AbjGCJgX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 05:36:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229895AbjGCJgV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 05:36:21 -0400
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D057B91;
        Mon,  3 Jul 2023 02:36:20 -0700 (PDT)
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:b231:465::102])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4Qvgm12Zkmz9sqG;
        Mon,  3 Jul 2023 11:36:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oltmanns.dev;
        s=MBO0001; t=1688376977;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=c1JsEa02ZZ9hIj8kyijs4IOojCm49i+SpDKQ3wmc3yc=;
        b=T2S1+Z5Uj9uWyp7TSiQRdyGVNHHsOm810YWrvKvShxenZFNvbiJhuzYubsNJ8OZzB9jKd5
        yGZioIJ4Zv3pBGO412OBh2/jv75oH47Ou6HYddT6U3POWvqijE5Dw4I1i4R8DFR6BFS9mo
        /KaEkn/Z6xrg6K4bgKZSVBDBLgB9o1mCa0kmrzYiVgbGuhpzE9u6Cm0dhhMVRxkje3Do9Q
        BjZUBD2lxkgPDAFsDl/rGb1nYeCSoCLgYbjt8wBUiJVRKo2jDATdq5HrXBdzmmytB/XYDA
        IUODHDwaW7X8McsOzdwaUwJse4e55cFQeMbXDmqbZVZJ8+1C1vQJAEralUSN5Q==
References: <20230702-pll-mipi_set_rate_parent-v3-0-46dcb8aa9cbc@oltmanns.dev>
 <tz2mcnyn32kedmkme2abaohhlveu37rohghddgg5njzw3534jq@qg3pevlpy4si>
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
Subject: Re: [PATCH v3 0/8] clk: sunxi-ng: Consider alternative parent rates
 when determining NKM clock rate
In-reply-to: <tz2mcnyn32kedmkme2abaohhlveu37rohghddgg5njzw3534jq@qg3pevlpy4si>
Date:   Mon, 03 Jul 2023 11:36:15 +0200
Message-ID: <874jmls5f4.fsf@oltmanns.dev>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Queue-Id: 4Qvgm12Zkmz9sqG
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2023-07-03 at 09:51:22 +0200, Maxime Ripard <maxime@cerno.tech> wrote:
> [[PGP Signed Part:Undecided]]
> Hi,
>
> On Sun, Jul 02, 2023 at 07:55:19PM +0200, Frank Oltmanns wrote:
>> Changes in v3:
>>  - Use dedicated function for finding the best rate in cases where an
>>    nkm clock supports setting its parent's rate, streamlining it with
>>    the structure that is used in other sunxi-ng ccus such as ccu_mp
>>    (PATCH 1).
>>  - Therefore, remove the now obsolete comments that were introduced in
>>    v2 (PATCH 1).
>>  - Remove the dedicated function for calculating the optimal parent rate
>>    for nkm clocks that was introduced in v2. Instead use a simple
>>    calculation and require the parent clock to select the closest rate to
>>    achieve optimal results (PATCH 1).
>>  - Therefore, add support to set the closest rate for nm clocks (because
>>    pll-mipi's parent pll-video0 is an nm clock) and all clock types that
>>    are descendants of a64's pll-video0, i.e., nkm, mux, and div (PATCH 3
>>    et. seq.).
>>  - Link to v2: https://lore.kernel.org/all/20230611090143.132257-1-frank@oltmanns.dev/
>
> Thanks so much for that new version. I know it's been a long discussion,
> but it definitely moves in the right direction and we're fairly close to
> a final version now.
>

I think it was a good discussion. So, thank you for that! I appreciate
your feedback even though we don't always agree. :)

Thanks,
  Frank

>
> Maxime
>
> [[End of PGP Signed Part]]
