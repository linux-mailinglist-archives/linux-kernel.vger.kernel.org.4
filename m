Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5AFF5EC28F
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 14:23:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231434AbiI0MXy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 08:23:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229596AbiI0MXV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 08:23:21 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D58072B72;
        Tue, 27 Sep 2022 05:23:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4DA6CB81BB6;
        Tue, 27 Sep 2022 12:23:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41452C433C1;
        Tue, 27 Sep 2022 12:23:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664281398;
        bh=afj7llXxrifwZaowZIAJp2ar5s4Dwn8Iu7HXu53vABI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=B0bF9QMSXM81hym4g2vWUW9Xyg8s/XLrXhqc/WOv1uknOgLuagCD6oZGwUk06MAQh
         HdM9Wqza3fLyt7f3TAKAqwi8yko5Z5wWrBkoI+oTDzknXaF2glu9KDtHLbL8LiS0sM
         Sz4pUhM/ZfGt+lXmGWgb5h4Nw+1laxe4PErCiPJmIXvJa5NN5SSuJyvJIAi54a7d6f
         oxvh7VwjSJpvkBkFSRrLch1p9jroK839BGfiC5tlZwF0LHidROglLcoWgn7zSfgMfw
         +wYarlHnD3q69oJSi3jDC6OWbdTkeL4f16H+Gm76Tk8/+w83mH8e1CB6Id2ciOVb4l
         NMFb46gVblpKg==
Date:   Tue, 27 Sep 2022 13:23:12 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Bert Vermeulen <bert@biot.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, John Crispin <john@phrozen.org>,
        Benjamin Larsson <benjamin.larsson@iopsys.eu>
Subject: Re: [PATCH v2 2/3] spi: Add support for the Airoha EN7523 SoC SPI
 controller
Message-ID: <YzLrMHVU3mTJVVh6@sirena.org.uk>
References: <20220927113229.1214224-1-bert@biot.com>
 <20220927113229.1214224-3-bert@biot.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="inRlknFBlKRNn326"
Content-Disposition: inline
In-Reply-To: <20220927113229.1214224-3-bert@biot.com>
X-Cookie: Vote anarchist.
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--inRlknFBlKRNn326
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 27, 2022 at 01:32:28PM +0200, Bert Vermeulen wrote:

> =20
> +config SPI_AIROHA_EN7523
> +	bool "Airoha EN7523 SPI controller support"

Why not tristate?

> +	depends on ARCH_AIROHA

I don't see a reason we couldn't have an || COMPILE_TEST here to improve
coverage?

> +	default ARCH_AIROHA

It's unusual to default a SPI controller on, they tend not to be ultra
critical like a clock driver or similar can be?

> +static void __iomem *iobase;

This should be driver data rather than a global, your current SoC might
only have one controller but some other model might build two and it's
fairly trivial to do.

> +static void opfifo_write(u32 cmd, u32 len)
> +{
> +	u32 tmp =3D ((cmd & 0x1f) << 9) | (len & 0x1ff);
> +
> +	writel(tmp, REG(ENSPI_MANUAL_OPFIFO_WDATA));
> +
> +	/* Wait for room in OPFIFO */
> +	while (readl(REG(ENSPI_MANUAL_OPFIFO_FULL)))
> +		cpu_relax();
> +

Some sort of timeout would be good with these loops, if things go wrong
we'll just lock up which isn't good.

> +       ret =3D clk_prepare_enable(clk);
> +       if (ret)
> +               return ret;

Nothing ever reverses this unless clk_set_rate() fails.

> +	ret =3D clk_set_rate(clk, 40000000);
> +	if (ret) {
> +		clk_disable_unprepare(clk);
> +		return ret;
> +	}

Could this be pushed into DT via the clock bindings?  The hard coded
number might need to vary by SoC.

> +static int xfer_read(struct spi_transfer *xfer)
> +{
> +	int opcode;
> +	uint8_t *buf =3D xfer->rx_buf;
> +
> +	switch (xfer->rx_nbits) {
> +	case SPI_NBITS_SINGLE:
> +		opcode =3D OP_INS;
> +		break;
> +	case SPI_NBITS_DUAL:
> +		opcode =3D OP_IND;
> +		break;
> +	}

This should have a default case that returns an error.

> +static int transfer_one_message(struct spi_controller *ctrl, struct spi_=
message *msg)
> +{
> +	struct spi_transfer *xfer;
> +	int next_xfer_is_rx =3D 0;
> +
> +	manual_begin_cmd();
> +	set_cs(0);

The driver should not be setting chip select itself, it should just
provide the set_cs() operation to the core and let the core worry about
when to call it.

> +	ctrl->transfer_one_message =3D transfer_one_message;
> +	err =3D devm_spi_register_controller(&pdev->dev, ctrl);
> +	if (err) {
> +		dev_err(&pdev->dev, "Could not register SPI controller\n");
> +		return -ENODEV;
> +	}

Don't discard the error code that registeration returned, include it in
the log message and pass it back to the caller. =20

--inRlknFBlKRNn326
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmMy6zAACgkQJNaLcl1U
h9C8oAf9F6JurerXV3JEhRYVqQeE+E+PGovqffTvtfViQp4w02wB26HgqFgpWgRV
uf9b9bwC5ohdggXwODKMl8bHXmcO02DXxqk8k/1Npgy3ASmboASEdaVt6oeCH8tM
NBA0ROjKdc0g6cs/EL1VqqaGqLejaN99yWsFAck2wcYYQN6hrOwSiyp1tVHEAFow
Rqw5nZlKfbFa/3WtP//Vqma8PxBwmO5onY3JKqymDZV1Z9Jq7+viRgUaVaHqSMQu
Z6KbRpxPBlRrxZH7ofDDORBGATkaTgFxKBHHgTngiG52iwogRtFWMjuoHc5sUcav
AtQvF3QHTvuvri+/rI7xBeNjBM6jbA==
=7wpB
-----END PGP SIGNATURE-----

--inRlknFBlKRNn326--
