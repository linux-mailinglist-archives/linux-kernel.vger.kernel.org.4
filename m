Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55ACA63D89E
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 15:58:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229601AbiK3O6M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 09:58:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbiK3O6J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 09:58:09 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D514303F7;
        Wed, 30 Nov 2022 06:58:07 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A6AB561C32;
        Wed, 30 Nov 2022 14:58:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2419C433C1;
        Wed, 30 Nov 2022 14:58:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669820284;
        bh=8qCtikAAK5ewVDLbkyFaVd5mw/YPRA/xoHRbnUNco6E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CAcY2kH/2zAdyjKKueldIyXfICaXuvzKuZRPy8r/7GZORaNctWvPrXkMgUd6A4mnS
         BGSgQzoPAEGQ2oCF+2hfDMoTdt8qzacuM2hbyIpTMMtyT5KwuS2w0980IDO623J1Sk
         49NslQa6HisN1wtnMZTUCjgCxf0FWj8IbcjyPwn3ZryNvdRSq2Odt4HKwMHUsgJz4L
         TIVlw/gGceQjkGI5UOrCfIA/bFYeU0fusdJwhY8Ll9YShXiWs6T53wv9jnAVfbwm6L
         MECg8lqtDQMpFdP2I97DWGusxQguZAMa1RAuqhZdAX/Y0vFu4jVqD7q1cjjLQs2Xd6
         uq7MugyilxkkA==
Date:   Wed, 30 Nov 2022 14:57:59 +0000
From:   Mark Brown <broonie@kernel.org>
To:     "A. Sverdlin" <alexander.sverdlin@siemens.com>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Lukas Wunner <lukas@wunner.de>
Subject: Re: [PATCH] spi: spidev: mask SPI_CS_HIGH in SPI_IOC_RD_MODE
Message-ID: <Y4dvdzVQZDEt09+p@sirena.org.uk>
References: <20221130143948.426640-1-alexander.sverdlin@siemens.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="dzZ2XdGmVBkCOrh6"
Content-Disposition: inline
In-Reply-To: <20221130143948.426640-1-alexander.sverdlin@siemens.com>
X-Cookie: Jesus is my POSTMASTER GENERAL ...
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--dzZ2XdGmVBkCOrh6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Nov 30, 2022 at 03:39:48PM +0100, A. Sverdlin wrote:

>  	/* read requests */
>  	case SPI_IOC_RD_MODE:
> -		retval = put_user(spi->mode & SPI_MODE_MASK,
> -					(__u8 __user *)arg);
> +		tmp = spi->mode;
> +
> +		{
> +			struct spi_controller *ctlr = spi->controller;
> +
> +			if (ctlr->use_gpio_descriptors && ctlr->cs_gpiods &&
> +			    ctlr->cs_gpiods[spi->chip_select])
> +				tmp &= ~SPI_CS_HIGH;
> +		}
> +
> +		retval = put_user(tmp & SPI_MODE_MASK, (__u8 __user *)arg);
>  		break;
>  	case SPI_IOC_RD_MODE32:
>  		retval = put_user(spi->mode & SPI_MODE_MASK,

What about SPI_IOC_RD_MODE_32?  On the write path the code is shared...

--dzZ2XdGmVBkCOrh6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmOHb3YACgkQJNaLcl1U
h9CQJgf/daoxEQABFU5PoGFf/jNfQvZzeIJqAAztUAaw61V0mVzndC36v23iuL3V
Fj1dBlPh1oZ/e+rDgTS6kJVdYhsnQK0z8hCDSHvBcFclBWfmT1SnMehlN0913sQ7
GU1m/2xnDv8OVis3SY6SYpK4lcRgM6Dn97JO1JtMu9PXCg56bTfSSE/WGnZSahtN
BOGXweozbj3VWmq/IIUWa1stWGMPsfU+3Rtg5dIXOUU52knv2Q7rTnX1u50x0RgA
7ND0EqaR8EL7MlPl85SRRQ1BKbbOF1RZWAwLtGqwYnfzldZLoDjZPdZ6BG5I/yVQ
h5JIsT4eVW0JMEsu8jhk9R6w84KwMg==
=XgeV
-----END PGP SIGNATURE-----

--dzZ2XdGmVBkCOrh6--
