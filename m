Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69D3764B4AC
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 13:02:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235163AbiLMMCR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 07:02:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234978AbiLMMBy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 07:01:54 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AE0211D
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 04:01:53 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C42FBB8118C
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 12:01:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3EB6C433EF;
        Tue, 13 Dec 2022 12:01:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670932910;
        bh=0tjz21vWlpIXp3TLdb4r9CVVlQoLyWocCkbF9DIyBoI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GWaA8Bt2KWdyyLNuJo0KV4ecEDglbT6ZxML4yxNkBGu7J/PemO63bNYzZe0TY7+Dh
         GEAdfgtoxvY2HM2azMMwpxNrTJaW7pv9gj0X4dHc8pPFA+nisMWfJdxiUz9dEzFc5C
         JZmSeO2ZnSO9s2OGuZls1ltdNBXuGtYTN3nwGt8sQRljfvYXLHmSvSL4qDPOevg3+a
         3h1+knjJTaw1P8nnbX2r3wbvInw7VYNZpoxhSnGcrFNLRNQh34ukUxT14QQZN2PYq5
         SHVRMxOT3d2vNHI/+TQ0ZbekqWyQhpw0gwhNneokfqEgZLGCLEeiI60f4TiIHpCRkA
         u1QW1LMe57vCw==
Date:   Tue, 13 Dec 2022 12:01:45 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Rouven Czerwinski <r.czerwinski@pengutronix.de>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, kernel@pengutronix.de,
        Marco Felsch <m.felsch@pengutronix.de>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] ASoC: max98088: fix initial dai mute state
Message-ID: <Y5hpqWH2WuSIUHil@sirena.org.uk>
References: <20221213095328.122309-1-r.czerwinski@pengutronix.de>
 <20221213095328.122309-2-r.czerwinski@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Ahb+Hr5djRLqjeHT"
Content-Disposition: inline
In-Reply-To: <20221213095328.122309-2-r.czerwinski@pengutronix.de>
X-Cookie: Edwin Meese made me wear CORDOVANS!!
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Ahb+Hr5djRLqjeHT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 13, 2022 at 10:53:28AM +0100, Rouven Czerwinski wrote:

> To fix that we need to explicit set the mute state. Now the first
> playback request gets played correctly.

> +++ b/sound/soc/codecs/max98088.c
> @@ -1710,6 +1710,11 @@ static int max98088_probe(struct snd_soc_component=
 *component)
>         snd_soc_component_write(component, M98088_REG_1E_DAI2_IOCFG,
>                 M98088_S2NORMAL|M98088_SDATA);
> =20
> +       snd_soc_component_update_bits(component, M98088_REG_2F_LVL_DAI1_P=
LAY,
> +               M98088_DAI_MUTE_MASK, M98088_DAI_MUTE);
> +       snd_soc_component_update_bits(component, M98088_REG_31_LVL_DAI2_P=
LAY,
> +               M98088_DAI_MUTE_MASK, M98088_DAI_MUTE);
> +

Won't this be broken again after suspend?  The device gets powered off
over suspend, then when it powers on again with the output unmuted
nothing will do another write since the register is already in the state
in the cache.

--Ahb+Hr5djRLqjeHT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmOYaagACgkQJNaLcl1U
h9DExgf+PM0QBKDQrbq0B1g9m3LgtHCePmmk+o7alaV9i82GcY9PpXzb7FxJp3lS
Ux4Y+QIfzyxhItX8da2NiV/ETmAASVgZm+aclYTVXfIQfnBl1kaq+0B9BQ2ix73B
EVRx0Q5L4SYp0m+4iAPE6rfG/yfXWkm0Vq827pRdIohN6yLfBBl4uVaSbBbHdlMV
vTA8Cp8R/1dACDa5MFpE1GzcNt5SHoyMdHJkAopC8jHQCTSqhAxe5fekmYayFjK4
KHN5tEoX7cMVFLpYYC6j1HG5FgXY6oPkGeQHFc2XB5LyAEHHkygpqzJQeOhF9Mrx
p7FBXm5/8ZZeatGoVdtkcbCuxBD17w==
=NVO8
-----END PGP SIGNATURE-----

--Ahb+Hr5djRLqjeHT--
