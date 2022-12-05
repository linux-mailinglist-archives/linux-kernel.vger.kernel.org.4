Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34158643701
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 22:41:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233676AbiLEVlc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 16:41:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230289AbiLEVlb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 16:41:31 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3816B27171;
        Mon,  5 Dec 2022 13:41:30 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 99B9D6146E;
        Mon,  5 Dec 2022 21:41:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87684C433C1;
        Mon,  5 Dec 2022 21:41:27 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="UcX63CxV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1670276485;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Cd+XRNCKmMHT7hFR6etWaPdNaLOAGBor4KfIYpxPTiU=;
        b=UcX63CxVLud3xJ7yYliyJ2IPekJGw8CsCg51VN7p+kv/6TMbQQMqBvjp8wY1lFXz77JzbG
        wj4Tt4uzLPi3/F2UV8+PDDSsDKUQ+23n6PVQt+bYvBivST7DuFFlmeClAkyoZ9zEoddIDf
        tL5RJVSkldP8/nY7JBdBKQE+J7nR3no=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 0357b102 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Mon, 5 Dec 2022 21:41:25 +0000 (UTC)
Date:   Mon, 5 Dec 2022 22:41:22 +0100
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     Olivia Mackall <olivia@selenic.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Lin Jinhan <troy.lin@rock-chips.com>,
        "open list:HARDWARE RANDOM NUMBER GENERATOR CORE" 
        <linux-crypto@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "moderated list:ARM/Rockchip SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Rockchip SoC support" 
        <linux-rockchip@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 2/3] hwrng: add Rockchip SoC hwrng driver
Message-ID: <Y45lguC4ZiniiWS/@zx2c4.com>
References: <20221128184718.1963353-1-aurelien@aurel32.net>
 <20221128184718.1963353-3-aurelien@aurel32.net>
 <Y43uiVo41vljLsZM@zx2c4.com>
 <Y45j/hd2MnnXzcAo@aurel32.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y45j/hd2MnnXzcAo@aurel32.net>
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Aurelien,

On Mon, Dec 05, 2022 at 10:34:54PM +0100, Aurelien Jarno wrote:
> Well I am not sure it really matters. 90% is actually conservative, it's
> the worst case I have seen, rounded down. However I often get much
> better quality, see for instance the following run:
> 
> | Copyright (c) 2004 by Henrique de Moraes Holschuh
> | This is free software; see the source for copying conditions.  There is NO warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
> | 
> | rngtest: starting FIPS tests...
> | rngtest: entropy source drained
> | rngtest: bits received from input: 16777216
> | rngtest: FIPS 140-2 successes: 819
> | rngtest: FIPS 140-2 failures: 19
> | rngtest: FIPS 140-2(2001-10-10) Monobit: 17
> | rngtest: FIPS 140-2(2001-10-10) Poker: 0
> | rngtest: FIPS 140-2(2001-10-10) Runs: 2
> | rngtest: FIPS 140-2(2001-10-10) Long run: 2
> | rngtest: FIPS 140-2(2001-10-10) Continuous run: 0
> | rngtest: input channel speed: (min=132.138; avg=137.848; max=147.308)Kibits/s
> | rngtest: FIPS tests speed: (min=16.924; avg=20.272; max=20.823)Mibits/s
> | rngtest: Program run time: 119647459 microseconds
> 
> Does the exact value has an importance there? I thought it was just
> important to not overestimate the quality.

That's the right principle. I just worry about estimating it like that
from looking at the output, rather than being derived from some
knowledge about the hardware. Maybe 50% (quality=512) is more
reasonable, so that it collects two bits for every one?

Jason
