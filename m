Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D861702AE0
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 12:49:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240720AbjEOKtz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 06:49:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241004AbjEOKtw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 06:49:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19089187;
        Mon, 15 May 2023 03:49:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AA5D2615C4;
        Mon, 15 May 2023 10:49:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5016C433EF;
        Mon, 15 May 2023 10:49:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684147790;
        bh=RIjBR85/BsnzTjsO+JKPrg7vBNHVMCaFolp5adcF3FQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=b3hPpoCUEyXjNyn+0Ai1hxCLb1SUdPw02tkyQ+lrmHcKuGenLIKyQGgGeMRGOMCso
         fmzWCRcx+I2BhGDwNw6CXdpmITBFmWJF2hUEjTC9OhH4n2zBmHLagaxwZLAflPCHUH
         NshtDG1gVrkAye/hEsoSGAJZHZNgubiZdHzJdXWFaCP0pLk36Cb8LZoxmy2fFdN+HV
         R9wpXZ/0aVV/OVxK0w41Q8ZgS6Fz69cy9o8sJF8ERwgFCiwBCZzjOsB1QPn2y8L1Lu
         M/6L4GQcENpXiOrx3NLiDwBw8hKAo48Ytg2w+V6+rlnfEbsJhm9mP95URqLy3rEt8T
         RJTiCyVCgP8gA==
Date:   Mon, 15 May 2023 19:49:47 +0900
From:   Mark Brown <broonie@kernel.org>
To:     Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
Cc:     lgirdwood@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] ASoC: Add ESS ES9218P codec driver
Message-ID: <ZGIOSwDduR+Ihe4p@finisterre.sirena.org.uk>
References: <20230515074021.31257-1-aidanmacdonald.0x0@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="TTuW6cRhBiN1JvNK"
Content-Disposition: inline
In-Reply-To: <20230515074021.31257-1-aidanmacdonald.0x0@gmail.com>
X-Cookie: Avoid contact with eyes.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--TTuW6cRhBiN1JvNK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, May 15, 2023 at 08:40:19AM +0100, Aidan MacDonald wrote:

> +++ b/sound/soc/codecs/ess-es9218p.c
> @@ -0,0 +1,805 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (c) 2022-2023 Aidan MacDonald
> + */

Please make the entire comment a C++ one so things look more
intentional.

> +enum es9218p_supply_id {
> +	ES9218P_SUPPLY_AVDD,
> +	ES9218P_SUPPLY_VCCA,
> +	ES9218P_SUPPLY_AVCC3V3,
> +	ES9218P_SUPPLY_AVCC1V8,
> +	ES9218P_NUM_SUPPLIES
> +};
> +
> +static const char * const es9218p_supply_names[ES9218P_NUM_SUPPLIES] = {
> +	"avdd",
> +	"vcca",
> +	"avcc3v3",
> +	"avcc1v8",
> +};

These could easily get out of sync, it would be better to explicitly
assign the names to the slots identified by the constants

	[ES9218P_SUPPLY_VCCA] = "vcca",

for example.

> +static int es9218p_wide_write(struct regmap *regmap, unsigned int reg,
> +			      int count, unsigned int value)
> +{
> +	u8 data[4];
> +	int i;
> +
> +	for (i = 0; i < count; i++) {
> +		data[i] = value & 0xff;
> +		value >>= 8;
> +	}

This needs a bounds check to make sure we don't overflow data.

> +static int outlevel_put(struct snd_kcontrol *kcontrol,
> +			struct snd_ctl_elem_value *ucontrol)
> +{
> +	struct snd_soc_component *component = snd_soc_kcontrol_component(kcontrol);
> +	struct es9218p_priv *priv = snd_soc_component_get_drvdata(component);
> +
> +	priv->output_2v = ucontrol->value.enumerated.item[0];
> +	es9218p_update_amp_mode(component);
> +	return 1;
> +}

Running the mixer-test selftest on a card with this driver will report
that the driver generates spurious events when there is no change in
value and doesn't validate input.  Similar issues apply to the other
enums.

--TTuW6cRhBiN1JvNK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmRiDkoACgkQJNaLcl1U
h9AP6gf/dNn2DGt53OeralAJP2Y5G89tKyYlSRgYuW/GN/mBiCQQfdbiAAn2FlUc
Jzbzp/ekvr0JfPfwizAOxbGmx70kOO7WO0y/jndTH5mLcCADpKawSCzV+dck4Vs/
wn6tX/um/Z0ufqvxSaNC5ARP54obPa0oJJwd2jaNTtML+pnjWNqL2UT9unkGpRK/
ehNS0pXvC4OKEvX1H5XDJpm4gV0gaAYTyesprYzrE5aM81YBhbYVAZylDIdXGspx
h+wjEE/WzH/bkBd7pCdfKE/RNyZA48ef/a2HWpALkZeLwBWECrKh6rs4FDSFHOC/
heNoKK3dB16ZW71fgEXtXE1kbZVHag==
=7dKY
-----END PGP SIGNATURE-----

--TTuW6cRhBiN1JvNK--
