Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DAD3665D54
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 15:10:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233857AbjAKOJ7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 09:09:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233532AbjAKOJy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 09:09:54 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 578CCEAF;
        Wed, 11 Jan 2023 06:09:53 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E40FC61D2A;
        Wed, 11 Jan 2023 14:09:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72B3FC43392;
        Wed, 11 Jan 2023 14:09:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673446192;
        bh=r1wM7/yHq5NV7R6TCxJGfIMno376i/B/rQVt1D7xN/Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iMuERo5k+KsB3S3hp0TnvDtzeBftTp20pyryM6ZNjpPySf3WdeO/aJfaC/hyBcgc0
         4ye5TP99kvBTWO3+YNtOIshHK2QuLanXKSLIl6iKNc7aDy1Y/mbLxKof13Fa83XMRM
         p5FwWvy1q+mdXdVdO8SGV2rssr7MUIoaNxKnhxt8FhJMv++9VNRB+wUw/JE/lIam6J
         pc/NnKmnW4Eyzude6bfcPr5OSPfbZ9pEoNGjeQPV7OQkymBufRLAd3XLQbCmVYyrr6
         VeaZJxfWgBsEDSNp8omcTTfN/Uu5xNj0dqBfFWmHEu+69WdvYlEG62g9X6B4NR3bzU
         FM/bcRVsSvN5Q==
Date:   Wed, 11 Jan 2023 14:09:45 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Herve Codina <herve.codina@bootlin.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH 2/3] ASoC: codecs: Add support for the Renesas IDT821034
 codec
Message-ID: <Y77DKSdZf27qE+xl@sirena.org.uk>
References: <20230111134905.248305-1-herve.codina@bootlin.com>
 <20230111134905.248305-3-herve.codina@bootlin.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="rXCTJvaRov4/huRj"
Content-Disposition: inline
In-Reply-To: <20230111134905.248305-3-herve.codina@bootlin.com>
X-Cookie: Life is not for everyone.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--rXCTJvaRov4/huRj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jan 11, 2023 at 02:49:04PM +0100, Herve Codina wrote:

> +++ b/sound/soc/codecs/idt821034.c
> @@ -0,0 +1,1234 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * IDT821034 ALSA SoC driver

Please make the entire comment a C++ one so things look more
intentional.

> +static int idt821034_8bit_write(struct idt821034 *idt821034, u8 val)
> +{
> +	struct spi_transfer xfer[] = {
> +		{
> +			.tx_buf = &idt821034->spi_tx_buf,
> +			.len = 1,
> +		}, {
> +			.cs_off = 1,
> +			.tx_buf = &idt821034->spi_tx_buf,
> +			.len = 1,
> +		}
> +	};
> +	int ret;
> +
> +	idt821034->spi_tx_buf = val;
> +
> +	dev_vdbg(&idt821034->spi->dev, "spi xfer wr 0x%x\n", val);
> +
> +	ret = spi_sync_transfer(idt821034->spi, xfer, 2);

Why is this open coding register I/O rather than using regmap?

> +	conf = 0x80 | idt821034->cache.codec_conf | IDT821034_CONF_CHANNEL(ch);

regmap provides cache support too.

> +static int idt821034_reg_write_gain(struct idt821034 *idt821034,
> +				    unsigned int reg, unsigned int val)
> +{
> +	u16 gain_val;
> +	u8 gain_type;
> +	u8 ch;
> +
> +	ch = IDT821034_REGMAP_ADDR_GET_CH(reg);
> +	gain_type = IDT821034_REGMAP_ADDR_IS_DIR_OUT(reg) ?
> +			IDT821034_GAIN_RX : IDT821034_GAIN_TX;
> +	gain_val = (val & 0x01) ? 0 : val >> 1;
> +
> +	return idt821034_set_gain_channel(idt821034, ch, gain_type, gain_val);
> +}

So if the low bit of the gain is zero we just discard the value?  This
really needs some comments...

> +static int idt821034_reg_write(void *context, unsigned int reg, unsigned int val)
> +{
> +	struct idt821034 *idt821034 = context;
> +
> +	dev_dbg(&idt821034->spi->dev, "reg_write(0x%x, 0x%x)\n", reg, val);
> +
> +	switch (IDT821034_REGMAP_ADDR_GET_TYPE(reg)) {
> +	case IDT821034_REGMAP_ADDR_TYPE_GBLCONF:
> +		return idt821034_reg_write_gblconf(idt821034, reg, val);
> +

Oh, so there is some regmap stuff but it's not actually a regmap and is
instead some virtual thing which rewrites all the values with no
comments or anything explaining what's going on....  this all feels very
confused.  I would expect the regmap usage to be such that the regmap
represents the physical device, any rewriting of the values or anything
like that should be done on top of the regmap rather than underneath it.

Without knowing why things are written in this way or what it's trying
to accomplish it's hard to comment in detail on what specifically should
be done.

--rXCTJvaRov4/huRj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmO+wygACgkQJNaLcl1U
h9A/Igf+PQ1ShrcRD3k3H3n9SAIuOQpQ6nv8CejZwcMG372n/XkUcH8kDGyxuNPg
WNf44QOf08x1SxV6xYjtdMe+j4YHy/mnyuIB6y8W9JQL/el9XVQ9fVfzkulVdBHP
JURgqpsUHrScih6xs5Zwzr4X8rpO67V9wt4IJvM2XJHwU70160ERUD3iH28d/h7m
sFSxJ7+Ig7t+XyPrS5tMABL0Qcre7RKdsTZGWHz2rjHcedOhH7xKMcAv2/klRfcA
YqQkCIuV8pouM6xZgCVHXVlYNYRw+scsBK0m2YqAYp/L/9O7BP1QTCftmEqkRlK2
lPS1EOKeXLJWSLYafmWEIGdkd+6CZg==
=g5JT
-----END PGP SIGNATURE-----

--rXCTJvaRov4/huRj--
