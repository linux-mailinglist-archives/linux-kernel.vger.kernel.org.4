Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 216605B3E1F
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 19:45:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231167AbiIIRpg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 13:45:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229813AbiIIRpd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 13:45:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9B30B6D77
        for <linux-kernel@vger.kernel.org>; Fri,  9 Sep 2022 10:45:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 734036206C
        for <linux-kernel@vger.kernel.org>; Fri,  9 Sep 2022 17:45:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2482DC433D6;
        Fri,  9 Sep 2022 17:45:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662745530;
        bh=KdPZ5U4EtJZbXVT6+9r/auhCgT6zhp52ldzOwpEGufI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lE0Q59peidqpfqCr5rwID2so6f9iQIwghhiR8I8idiD/eC/uM3t4ssp4jnIg41eqa
         +PUbTkEsLCddgx+9zCfZA6JDlXWhn56ZWSHXX9K/7W2GilhenR4C6ZJ7KucuSyztqE
         STW+tdexhxx8rkaBLa+tUr4pxUZZGsQuK5bdLUBYEOKjvmLlyVJcv4uJh69TkHz+7i
         GTcS4D/UH1dCjUvVzNNUhrtJAfa2Jvpk5KFDym3K84U6xui9tZHLjJJqWfRWpP9ggV
         w9tM2d+HCAoBgcYAdiBGvy9JT4d6H2z2FfOEKtPli7u33GR1giiagl2u7CDuQMiDyu
         F4FXQwQqO3D9Q==
Date:   Fri, 9 Sep 2022 18:45:25 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Astrid Rost <astrid.rost@axis.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, kernel@axis.com,
        alsa-devel-mejlinglistan <alsa-devel@alsa-project.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ASoC: ts3a227e: allow enabling the jack detect in driver
Message-ID: <Yxt7tfm6MRMaDthO@sirena.org.uk>
References: <20220909093001.13110-1-astrid.rost@axis.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="iaEPXYJpK/+YHHRT"
Content-Disposition: inline
In-Reply-To: <20220909093001.13110-1-astrid.rost@axis.com>
X-Cookie: FORTH IF HONK THEN
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--iaEPXYJpK/+YHHRT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Sep 09, 2022 at 11:30:01AM +0200, Astrid Rost wrote:

> ti,jack-detect enables the jack detection input device

New properties need to be documented, I'm happy for that to be in the
existing document though obviously a conversion to YAML would be very
much appreciated.  However...

> +	if (enable) {
> +		/* Enable Headset and 4 Buttons Jack detection */
> +		ts3a227e->jack = devm_kzalloc(component->dev,
> +				sizeof(struct snd_soc_jack), GFP_KERNEL);
> +
> +		ret = snd_soc_card_jack_new_pins(card, "Headset Jack",
> +					    SND_JACK_HEADSET |
> +					    SND_JACK_BTN_0 | SND_JACK_BTN_1 |
> +					    SND_JACK_BTN_2 | SND_JACK_BTN_3,
> +					    ts3a227e->jack,
> +					    ts3a227e_jack_pins,
> +					    ARRAY_SIZE(ts3a227e_jack_pins));
> +		if (ret)
> +			return ret;
> +
> +		ret = ts3a227e_enable_jack_detect(component, ts3a227e->jack);
> +	}

...this is something that should be done in the machine driver rather
than the CODEC, the way the device is wired up in an individual system
may be surprising or the system may have some more specific labelling
that can be usefully applied so this is all deferred to the card.

It would sense to convert ts3a277e_enable_jack_detect() to be a
component set_jack() operation, that'd enable it to be used more easily
with generic cards (though I see that it's not yet wired up for
audio-graph-card unfortunately).

--iaEPXYJpK/+YHHRT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmMbe7QACgkQJNaLcl1U
h9C7nAf/QdfOK4zJRdJvo2aFm0+Re0RQ56ntnchc2zx6RmSDPMQ6JKO3yHNVSQp0
hll5NvMnaDhaCOj0NaoXKq1hk8lAW5nsHINJZAU7M7QjrhJ2c6yskIDtlyPJHVOI
1sT8YNwlwTvKDlPWvnmz8rqcHoXx2IN4m1e/uDtKWu3edI50pKNuz06YB0dJIzt9
NXpaRlrCLQVUtE9Rb6iKW/pH6fRIe3l/nCd6PhA6GCPtL4TKglTOWkaQkB0p0kXP
hnGfThWfAf8SVe19JNwg2X2IsNdDe7bJ3Y9AqWoEH6fLBxmzqiBvcjsfWXI2mKQw
bY38NzYd3Ls9HTWRaCpTMmJ/Iy5PxQ==
=L8qU
-----END PGP SIGNATURE-----

--iaEPXYJpK/+YHHRT--
