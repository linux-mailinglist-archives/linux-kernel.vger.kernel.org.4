Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D3C16436F3
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 22:35:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233533AbiLEVfZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 16:35:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230254AbiLEVfW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 16:35:22 -0500
Received: from hall.aurel32.net (hall.aurel32.net [IPv6:2001:bc8:30d7:100::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36DA02CC80;
        Mon,  5 Dec 2022 13:35:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=aurel32.net
        ; s=202004.hall; h=In-Reply-To:Content-Transfer-Encoding:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:Reply-To:
        Subject:Content-ID:Content-Description:X-Debbugs-Cc;
        bh=RAu47D9qhSPeqGH6WidK6jmmj65HEM0DSNp12TyKSG0=; b=HZcoEtIlLfMXONr9DyEAs9FQGJ
        N84DVRwyt515vU6/4KRZVhPFYXo1ymWy0iln/LngK/DPsAdk044Vk6VKmhJhd7PT/OGGQ+QrJ/tA9
        jQnzMs6Io0kNHx3nN2MmnYIl6dG6Ukh02Qmu73N3yEQZsWh2Bs3bMhC7qfXm07L6R9djWP48nSUFJ
        xWD5uVLujymazwk9/QgVuVw9bGTiaebvYfbrgrDCG7xn6CI9xkN/huQZks6zlDyvsWHdxxOIp87Qt
        58piDtyB2EZNkgN/Ze1FuBEGebD6Qoa7/v/UoApuUmGw8L2ec0feCrqylDNALOPZGuLxCvgvBGt5G
        A4KdSbQw==;
Received: from [2a01:e34:ec5d:a741:8a4c:7c4e:dc4c:1787] (helo=ohm.rr44.fr)
        by hall.aurel32.net with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <aurelien@aurel32.net>)
        id 1p2J73-00BKxr-Kw; Mon, 05 Dec 2022 22:34:57 +0100
Received: from aurel32 by ohm.rr44.fr with local (Exim 4.96)
        (envelope-from <aurelien@aurel32.net>)
        id 1p2J70-00GGBC-2X;
        Mon, 05 Dec 2022 22:34:54 +0100
Date:   Mon, 5 Dec 2022 22:34:54 +0100
From:   Aurelien Jarno <aurelien@aurel32.net>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     Olivia Mackall <olivia@selenic.com>,
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
Message-ID: <Y45j/hd2MnnXzcAo@aurel32.net>
Mail-Followup-To: "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Olivia Mackall <olivia@selenic.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Lin Jinhan <troy.lin@rock-chips.com>,
        "open list:HARDWARE RANDOM NUMBER GENERATOR CORE" <linux-crypto@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
        "moderated list:ARM/Rockchip SoC support" <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Rockchip SoC support" <linux-rockchip@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20221128184718.1963353-1-aurelien@aurel32.net>
 <20221128184718.1963353-3-aurelien@aurel32.net>
 <Y43uiVo41vljLsZM@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <Y43uiVo41vljLsZM@zx2c4.com>
User-Agent: Mutt/2.2.7 (2022-08-07)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 2022-12-05 14:13, Jason A. Donenfeld wrote:
> On Mon, Nov 28, 2022 at 07:47:17PM +0100, Aurelien Jarno wrote:
> > The TRNG device does not seem to have a signal conditionner and the FIPS
> > 140-2 test returns a lot of failures. They can be reduced by increasing
> > RK_RNG_SAMPLE_CNT, in a tradeoff between quality and speed. This value
> > has been adjusted to get ~90% of successes and the quality value has
> > been set accordingly.
>=20
> Can't you reduce it even more to get 100%? All we need is 32 bytes every
> once in a while.

=46rom what I understood, we get the raw stream of the TRNG, there is no
conditionner and the TRNG is not FIPS compliant. So even with the
slowest speed, you don't reach 100% and you only get a very small
increase in the quality while it's way more slower.

> > +	rk_rng->rng.quality =3D 900;
>=20
> If your intention is "90%", this should be 921 or 922, because the
> quality knob is out of 1024, not 1000.

Well I am not sure it really matters. 90% is actually conservative, it's
the worst case I have seen, rounded down. However I often get much
better quality, see for instance the following run:

| Copyright (c) 2004 by Henrique de Moraes Holschuh
| This is free software; see the source for copying conditions.  There is N=
O warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOS=
E.
|=20
| rngtest: starting FIPS tests...
| rngtest: entropy source drained
| rngtest: bits received from input: 16777216
| rngtest: FIPS 140-2 successes: 819
| rngtest: FIPS 140-2 failures: 19
| rngtest: FIPS 140-2(2001-10-10) Monobit: 17
| rngtest: FIPS 140-2(2001-10-10) Poker: 0
| rngtest: FIPS 140-2(2001-10-10) Runs: 2
| rngtest: FIPS 140-2(2001-10-10) Long run: 2
| rngtest: FIPS 140-2(2001-10-10) Continuous run: 0
| rngtest: input channel speed: (min=3D132.138; avg=3D137.848; max=3D147.30=
8)Kibits/s
| rngtest: FIPS tests speed: (min=3D16.924; avg=3D20.272; max=3D20.823)Mibi=
ts/s
| rngtest: Program run time: 119647459 microseconds

Does the exact value has an importance there? I thought it was just
important to not overestimate the quality.

Regards
Aurelien

--=20
Aurelien Jarno                          GPG: 4096R/1DDD8C9B
aurelien@aurel32.net                 http://www.aurel32.net
