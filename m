Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 010D56E7EF5
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 17:56:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233701AbjDSP40 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 11:56:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233025AbjDSP4Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 11:56:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F3EA2721;
        Wed, 19 Apr 2023 08:56:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CE9DE64093;
        Wed, 19 Apr 2023 15:56:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B6C6C433D2;
        Wed, 19 Apr 2023 15:56:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681919782;
        bh=nvxf91IZA13U9SiA5t6TZYEJqcyil96kcEWzpNxXu14=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gD1P+NCUTLvEthQmNMDGFVXxkRgXw0BrpxWV13ruufTKw7J0cIwFV88kLEdD0PBZA
         iIxux7K0TfFvgXUXMZT+v78W8zXKG6l5I3CKbUGclWuCDmOJFxHzlUUsS9Mr/IJeJT
         dsGNn1mPkYvDFMEcylhvo9ogJavWEodQBMMrILwpQCRyzhauVjl2wExBHRkuFcF+cn
         AUWPF52ZIHUOFLdgX6O1DMMV6ReR19fpG43rOmplpCyVkIYNgC+W/mT0CQdb5hTP4S
         50zDONfIEtuiN0eeGeg6kBCq4zDfnWF8FAoQ+cHlvUJ2v8VIFwyA6Pgj+ejV7eWgnJ
         k7E1PZcbH3W/g==
Date:   Wed, 19 Apr 2023 17:56:17 +0200
From:   Andi Shyti <andi.shyti@kernel.org>
To:     Jaewon Kim <jaewon02.kim@samsung.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Mark Brown <broonie@kernel.org>, Andi Shyti <andi@etezian.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        linux-spi@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Chanho Park <chanho61.park@samsung.com>
Subject: Re: [PATCH v2 3/4] spi: s3c64xx: add sleep during transfer
Message-ID: <20230419155617.gobedupbdmdaj4kz@intel.intel>
References: <20230419060639.38853-1-jaewon02.kim@samsung.com>
 <CGME20230419062755epcas2p1bca14bbd5200ebe5241780d2d7ec1596@epcas2p1.samsung.com>
 <20230419060639.38853-4-jaewon02.kim@samsung.com>
 <b91c6cfb-4fd2-1189-72fd-92b40d1b4743@linaro.org>
 <9d2e2bda-4213-35d0-55d7-827bad9b13a1@samsung.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="lpnfxvg6q5y66f32"
Content-Disposition: inline
In-Reply-To: <9d2e2bda-4213-35d0-55d7-827bad9b13a1@samsung.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--lpnfxvg6q5y66f32
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Jaewon,

> >> In polling mode, the status register is constantly read to check trans=
fer
> >> completion. It cause excessive CPU usage.
> >> So, it calculates the SPI transfer time and made it sleep.
> >>
> >> Signed-off-by: Jaewon Kim <jaewon02.kim@samsung.com>
> >> ---
> >>   drivers/spi/spi-s3c64xx.c | 8 ++++++++
> >>   1 file changed, 8 insertions(+)
> >>
> >> diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
> >> index 886722fb40ea..cf3060b2639b 100644
> >> --- a/drivers/spi/spi-s3c64xx.c
> >> +++ b/drivers/spi/spi-s3c64xx.c
> >> @@ -561,6 +561,14 @@ static int s3c64xx_wait_for_pio(struct s3c64xx_sp=
i_driver_data *sdd,
> >>   	u32 cpy_len;
> >>   	u8 *buf;
> >>   	int ms;
> >> +	u32 tx_time;
> >> +
> >> +	/* sleep during signal transfer time */
> >> +	status =3D readl(regs + S3C64XX_SPI_STATUS);
> >> +	if (RX_FIFO_LVL(status, sdd) < xfer->len) {
> >> +		tx_time =3D (xfer->len * 8 * 1000 * 1000) / sdd->cur_speed;
> >> +		usleep_range(tx_time / 2, tx_time);
> >> +	}
> > Did you actually check the delays introduced by it? Is it worth?
>=20
> Yes, I already test it.
>=20
> Throughput was the same, CPU utilization decreased to 30~40% from 100%.
>=20
> Tested board is ExynosAutov9 SADK.
>=20
>=20
> >
> >>  =20
> >>   	/* millisecs to xfer 'len' bytes @ 'cur_speed' */
> >>   	ms =3D xfer->len * 8 * 1000 / sdd->cur_speed;
> > You have now some code duplication so this could be combined.

you could put the 'if' under the 'ms =3D ...' and just use ms
without declaring any tx_time.

Andi

--lpnfxvg6q5y66f32
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQScDfrjQa34uOld1VLaeAVmJtMtbgUCZEAPIQAKCRDaeAVmJtMt
bl9sAQD2KwYXJUe6dy2fLex4Y9UuGAihcSgb/Wa9N975crk9jwD+JUTSU1epIcx1
qB02nuF53TZR5uR0n1e5gKLxHeCCdgc=
=45qL
-----END PGP SIGNATURE-----

--lpnfxvg6q5y66f32--
