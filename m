Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C19D6E7F12
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 18:03:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232664AbjDSQD3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 12:03:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231779AbjDSQD1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 12:03:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4132A11A;
        Wed, 19 Apr 2023 09:03:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C0BF4625B3;
        Wed, 19 Apr 2023 16:03:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B9EBC433EF;
        Wed, 19 Apr 2023 16:03:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681920205;
        bh=9T7UQHtdAnXUUr6hdalOiNL5nYc0LiD1Eei3O6sKj50=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GQyFuTs1A5/UTQmk/GgfgTtFeoEPV7gubqdXdE2951PctWLb7rNyskZijFC0JgG1H
         h4sUDIzxvlBYecWrwm3t8aGtsoi/laa/U0ex0hPothE0JDNXMfYtiBEGoHXVbbTRtc
         OkUArVM8mWPXcAps6fwUCJOWZo6qhx18RXxTwxZODxan+s0LuumFSEkRQqs1ag4L0r
         4/ML+qml2780fmX4cgdgi60gXm7DiDBhYbiroOu3gBBK9N9AadTAzcN+WuYdwZUpOJ
         gKzJ9vyCQCFss1wNTa4W5lbIPyk/v6bdw08pAyQvLXmiBVbtBwSpckWTKmwkYvJhmn
         Q6EPtGl9Ojpdg==
Date:   Wed, 19 Apr 2023 18:03:20 +0200
From:   Andi Shyti <andi.shyti@kernel.org>
To:     Jaewon Kim <jaewon02.kim@samsung.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andi Shyti <andi@etezian.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        linux-spi@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Chanho Park <chanho61.park@samsung.com>
Subject: Re: [PATCH v2 4/4] spi: s3c64xx: support interrupt based pio mode
Message-ID: <20230419160320.ydgqqftsfn3y33p4@intel.intel>
References: <20230419060639.38853-1-jaewon02.kim@samsung.com>
 <CGME20230419062755epcas2p43a1127f4bb28cf1cf3f42e5d3cc597cd@epcas2p4.samsung.com>
 <20230419060639.38853-5-jaewon02.kim@samsung.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="zygm74jtlgdew5uq"
Content-Disposition: inline
In-Reply-To: <20230419060639.38853-5-jaewon02.kim@samsung.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--zygm74jtlgdew5uq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Jaewon,

On Wed, Apr 19, 2023 at 03:06:39PM +0900, Jaewon Kim wrote:
> Interrupt based pio mode is supported to reduce CPU load.
> If transfer size is larger than 32 byte, it is processed using interrupt.
>=20
> Signed-off-by: Jaewon Kim <jaewon02.kim@samsung.com>
> ---
>  drivers/spi/spi-s3c64xx.c | 82 ++++++++++++++++++++++++++++++++-------
>  1 file changed, 67 insertions(+), 15 deletions(-)
>=20
> diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
> index cf3060b2639b..ce1afb9a4ed4 100644
> --- a/drivers/spi/spi-s3c64xx.c
> +++ b/drivers/spi/spi-s3c64xx.c
> @@ -58,6 +58,8 @@
>  #define S3C64XX_SPI_MODE_BUS_TSZ_HALFWORD	(1<<17)
>  #define S3C64XX_SPI_MODE_BUS_TSZ_WORD		(2<<17)
>  #define S3C64XX_SPI_MODE_BUS_TSZ_MASK		(3<<17)
> +#define S3C64XX_SPI_MODE_RX_RDY_LVL		GENMASK(16, 11)
> +#define S3C64XX_SPI_MODE_RX_RDY_LVL_SHIFT	11
>  #define S3C64XX_SPI_MODE_SELF_LOOPBACK		(1<<3)
>  #define S3C64XX_SPI_MODE_RXDMA_ON		(1<<2)
>  #define S3C64XX_SPI_MODE_TXDMA_ON		(1<<1)
> @@ -114,6 +116,8 @@
> =20
>  #define S3C64XX_SPI_TRAILCNT		S3C64XX_SPI_MAX_TRAILCNT
> =20
> +#define S3C64XX_SPI_POLLING_SIZE	32
> +
>  #define msecs_to_loops(t) (loops_per_jiffy / 1000 * HZ * t)
>  #define is_polling(x)	(x->cntrlr_info->polling)
> =20
> @@ -552,10 +556,11 @@ static int s3c64xx_wait_for_dma(struct s3c64xx_spi_=
driver_data *sdd,
>  }
> =20
>  static int s3c64xx_wait_for_pio(struct s3c64xx_spi_driver_data *sdd,
> -				struct spi_transfer *xfer)
> +				struct spi_transfer *xfer, int use_irq)

bool use_irq

>  {
>  	void __iomem *regs =3D sdd->regs;
>  	unsigned long val;
> +	unsigned long time;

this time is used only in "if (use_irq)" can you move its
declaration under the if?

>  	u32 status;
>  	int loops;
>  	u32 cpy_len;
> @@ -563,17 +568,24 @@ static int s3c64xx_wait_for_pio(struct s3c64xx_spi_=
driver_data *sdd,
>  	int ms;
>  	u32 tx_time;
> =20
> -	/* sleep during signal transfer time */
> -	status =3D readl(regs + S3C64XX_SPI_STATUS);
> -	if (RX_FIFO_LVL(status, sdd) < xfer->len) {
> -		tx_time =3D (xfer->len * 8 * 1000 * 1000) / sdd->cur_speed;
> -		usleep_range(tx_time / 2, tx_time);
> -	}
> -
>  	/* millisecs to xfer 'len' bytes @ 'cur_speed' */
>  	ms =3D xfer->len * 8 * 1000 / sdd->cur_speed;
>  	ms +=3D 10; /* some tolerance */
> =20
> +	if (use_irq) {
> +		val =3D msecs_to_jiffies(ms);
> +		time =3D wait_for_completion_timeout(&sdd->xfer_completion, val);
> +		if (!time)
> +			return -EIO;
> +	} else {
> +		/* sleep during signal transfer time */
> +		status =3D readl(regs + S3C64XX_SPI_STATUS);
> +		if (RX_FIFO_LVL(status, sdd) < xfer->len) {
> +			tx_time =3D (xfer->len * 8 * 1000 * 1000) / sdd->cur_speed;
> +			usleep_range(tx_time / 2, tx_time);

yeah... just use 'ms'.

> +		}
> +	}
> +
>  	val =3D msecs_to_loops(ms);
>  	do {
>  		cpu_relax();
> @@ -737,10 +749,13 @@ static int s3c64xx_spi_transfer_one(struct spi_mast=
er *master,
>  	void *rx_buf =3D NULL;
>  	int target_len =3D 0, origin_len =3D 0;
>  	int use_dma =3D 0;
> +	int use_irq =3D 0;
>  	int status;
>  	u32 speed;
>  	u8 bpw;
>  	unsigned long flags;
> +	u32 rdy_lv;
> +	u32 val;
> =20
>  	reinit_completion(&sdd->xfer_completion);
> =20
> @@ -761,17 +776,46 @@ static int s3c64xx_spi_transfer_one(struct spi_mast=
er *master,
>  	    sdd->rx_dma.ch && sdd->tx_dma.ch) {
>  		use_dma =3D 1;
> =20
> -	} else if (xfer->len > fifo_len) {
> +	} else if (xfer->len >=3D fifo_len) {
>  		tx_buf =3D xfer->tx_buf;
>  		rx_buf =3D xfer->rx_buf;
>  		origin_len =3D xfer->len;
> -
>  		target_len =3D xfer->len;
> -		if (xfer->len > fifo_len)
> -			xfer->len =3D fifo_len;
> +		xfer->len =3D fifo_len - 1;
>  	}

Is this change related to this patch?

The rest looks good.

Andi

--zygm74jtlgdew5uq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQScDfrjQa34uOld1VLaeAVmJtMtbgUCZEAQyAAKCRDaeAVmJtMt
bs2eAQDotXXRybKKzzGuqYu7pgJoJR7ZiCFr79RgsoeNXuSlJQD+LIZqpkkESIpj
EeRs8M1GsIXlaUNp0rU4y9e1QTDS5w8=
=5+Vw
-----END PGP SIGNATURE-----

--zygm74jtlgdew5uq--
