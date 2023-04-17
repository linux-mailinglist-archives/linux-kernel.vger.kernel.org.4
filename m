Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B517D6E4DDA
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 17:58:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229783AbjDQP6l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 11:58:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjDQP6j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 11:58:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A378184
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 08:58:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B6B4962186
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 15:58:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54C06C433D2;
        Mon, 17 Apr 2023 15:58:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681747118;
        bh=Rnzz3GERW74u+MLWW8EQinbIqSNnWVSb2Kn3TBoIaQo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lxA4+tDdcZ3QYB4UAIxj/2Z9JfC/1OfhjjMjtRS8Q8uww6uYzQePkd5ZcTNMF6YHl
         C2T5vT9auWyNRDzTCmW4FrH9hmMzDIJX3qe87EC7+KjfVuItzSpGu4PbWKsVuZcMl+
         7XX2ugtsXUr3P78cZAHS/C+m2J9lQzzDkuTPHdju+SIKS3FpGwSQ7Dk4cExK9i4Chr
         JRzAW/dEVLP1xnrlENvhWgsSW/1pyuPIITS4AYkD/1ZK7GJAk2XS9ZuYVCgsJRsrnx
         16FHwyAEDMm1pkHVZayV/6o7sfAJ9luLu1Y66alp70hutP3KVH133J/FGMXSTYJoD/
         +8+Ga553plygg==
Date:   Mon, 17 Apr 2023 16:58:33 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Banajit Goswami <bgoswami@quicinc.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] ASoC: codecs: wcd934x: Simplify with dev_err_probe
Message-ID: <5d753a8a-b979-43f6-a403-8a51f69bac29@sirena.org.uk>
References: <20230417141453.919158-1-krzysztof.kozlowski@linaro.org>
 <20230417141453.919158-2-krzysztof.kozlowski@linaro.org>
 <20aa9662-9cbb-4fbe-b6ed-3a6ba33e820a@sirena.org.uk>
 <c294d672-c2fa-7468-f02d-18d5230a1d95@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="yQshKBcUYTpK5P3W"
Content-Disposition: inline
In-Reply-To: <c294d672-c2fa-7468-f02d-18d5230a1d95@linaro.org>
X-Cookie: Two heads are more numerous than one.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--yQshKBcUYTpK5P3W
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Apr 17, 2023 at 05:43:03PM +0200, Krzysztof Kozlowski wrote:
> On 17/04/2023 17:33, Mark Brown wrote:
> > On Mon, Apr 17, 2023 at 04:14:51PM +0200, Krzysztof Kozlowski wrote:

> >> -	if (IS_ERR(wcd->if_regmap)) {
> >> -		dev_err(dev, "Failed to allocate ifc register map\n");
> >> -		return PTR_ERR(wcd->if_regmap);
> >> -	}
> >> +	if (IS_ERR(wcd->if_regmap))
> >> +		return dev_err_probe(dev, PTR_ERR(wcd->if_regmap),
> >> +				     "Failed to allocate ifc register map\n");

> > This is a functional change.

> Hmm... I don't see it. Return value is the same, same message is
> printed, same condition. Did I make some copy-paste error?

You've replaced an unconditional dev_err() with dev_err_probe().

--yQshKBcUYTpK5P3W
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmQ9bKgACgkQJNaLcl1U
h9A5eAf/V44Ba6yb3a6YmDlgNmrPlfJw61Ind9ikhM3isXbEY6mNHHVXK2bTaRyq
S92EYU+HklYIUaooXBh/pqhXzcJVL1vxjK/tFO+j81KW3z9D77dbQ41RiYu43nC1
uqE8Lu0CJbGoja6t2uL3DlBoYiygvARFKCuc0cN4b/Yaf4ynO+6utmd9PrYz+L0+
BhgGmmce+4wK9Yh9NpceDuW7OUCo6YMrWW96dL6z1gcp5+VaLNRUzH0/Ro21IzhC
6hzb/zGlWE3osHk91PRO2og+veylpbXO4LTTCxgrs1ElgFesi7giSiwJ2Y8klNEt
d88QqmfZXTLk9VZzkXRgRozDP/lc/w==
=oifx
-----END PGP SIGNATURE-----

--yQshKBcUYTpK5P3W--
