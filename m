Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58EDE6A75D5
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 22:07:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229762AbjCAVHl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 16:07:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjCAVHj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 16:07:39 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 311A551FA0;
        Wed,  1 Mar 2023 13:07:35 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CDCD0B81144;
        Wed,  1 Mar 2023 21:07:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2112BC433EF;
        Wed,  1 Mar 2023 21:07:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677704852;
        bh=YU3OqR6PGCqyq60tMLnkQIYsH8ICE8R/mE5hLImogNY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CsWZVm2cutYXcKys2d2Qjp/oBkwa/j5pldnCm6GzISftZytANF4nhlO3bVhM+1vi0
         eRlfJgcVFkqS6PUNwgFG6MOCZHQPxBFWx5ny9h6dcZJeR6muwL1wRSckfvcmWXC0h/
         BPwDfBV53qMlvd5LKXivI8kJdbAFgjMQ3e/NQSbfr+oJxCx5QpIooobfyHsJVTY+Sf
         WpYOz5Nl+P4X3OhVYBKGvctVJagGn3S9pKSXhMjnNasN7w8elfGiZTNvoBT5nhZS2y
         4ct2rc4mlb4U3FcnDlcZBEpl0fNTyh17r+uRqY9pBYkRb+yWVf7Th/yvh1mFLnvifd
         gM1PsE0oUh8jw==
Date:   Wed, 1 Mar 2023 21:07:26 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Chancel Liu <chancel.liu@nxp.com>
Cc:     lgirdwood@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, perex@perex.cz, tiwai@suse.com,
        ckeepax@opensource.cirrus.com, patches@opensource.cirrus.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v2 2/2] ASoC: wm8524: Correct the MUTE setting while
 power up/down
Message-ID: <Y/++jj0bQustGAhl@sirena.org.uk>
References: <20230227091938.1671416-1-chancel.liu@nxp.com>
 <20230227091938.1671416-2-chancel.liu@nxp.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="h2bgY9riaA5HydEq"
Content-Disposition: inline
In-Reply-To: <20230227091938.1671416-2-chancel.liu@nxp.com>
X-Cookie: Life -- Love It or Leave It.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--h2bgY9riaA5HydEq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 27, 2023 at 05:19:38PM +0800, Chancel Liu wrote:

> wm8524 should be unmuted while power up and muted while power down.

> @@ -75,7 +75,7 @@ static int wm8524_startup(struct snd_pcm_substream *sub=
stream,
>  				   SNDRV_PCM_HW_PARAM_RATE,
>  				   &wm8524->rate_constraint);
> =20
> -	gpiod_set_value_cansleep(wm8524->mute, 1);
> +	gpiod_set_value_cansleep(wm8524->mute, 0);
> =20
>  	return 0;
>  }

I *think* the theory with these is that the device should be muted by
default so that any noise during startup is minimised, and only unmuted
when there's an actual audio stream, done in wm8524_mute_stream().  I am
unclear why this default state is set up in startup(), or why we unmute
in shutdown().  It could be that the startup thing is trying to work
around some suspend/resume thing?  In any case I'm not sure this helps,
I think really we should just not be managing the GPIO in these
functions at all and setting the default state to be muted when the GPIO
is requested.  With this change we'd move the unmute _mute_stream() does
much earlier, meaning that any noise output by the SoC during startup
will get played.

--h2bgY9riaA5HydEq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmP/vo0ACgkQJNaLcl1U
h9BVWQgAgHIQcJ7bDencNJpYBmtSKceFAd9HlLw0yDL6ceOi5m8NZJMKWADWory7
ybQhrjsTBz3YUg8yeeWL56j+XAVEIE387HmQdh1H/aZTA78/RVhd4Ntt/VYOiPZw
/b1VnTBZjnjBsCDTWwmhqo2Z6T69qaZLg4G1chiGvHON+rMTMXBeVhzVntlmO0vA
wkfFUmQpY5o8Uojb280mzqkJoOpsG1YbnD7XOv+NblOpdV4qGo+3s67E04p+AqPk
5pAwAIBPAcZaEnUZOtfV02gqQAeoBSn8WvU3weUzmsoexVgAnGSj0d/1X2ETiGtt
qzU90zZ3TD3qDBPBJcIaR0Y6AnvQbw==
=cAYB
-----END PGP SIGNATURE-----

--h2bgY9riaA5HydEq--
