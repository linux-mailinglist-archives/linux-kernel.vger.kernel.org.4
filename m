Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72DE86CC14D
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 15:44:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231238AbjC1Nof (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 09:44:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232546AbjC1NoM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 09:44:12 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17CC6C168;
        Tue, 28 Mar 2023 06:43:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9D9E8B81CF9;
        Tue, 28 Mar 2023 13:43:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87C1BC433D2;
        Tue, 28 Mar 2023 13:43:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680011035;
        bh=KzYDwfsH+YX81gSdDwsXHqP3ZoSOdKrPj4OVMe0JLWY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WxvlcsctzYdjsBHlZsV0eGLBm1jk/H/OwlR9XgvA/XAjNg3cC+7Ug0lLHSmdxCraH
         r3q0XBUsepMwwl21+wlvotubYqthAfADE7y9Qb/6HqhXZvQW9qiLda32SUfYZRC7Zb
         gJlCOOd66RnzajgNRCbm86XRIlBzMZ0qQ+9g2gQOoLIKP4Xc4X6FaD6RAMr0BwHqDr
         Qaw5V5Gi94S0RAQ8UlI4V0QZRGtKsBNEdoLNwG37Ylaa8NWA0KWouaKRXgl+FH2GY+
         2rd/6B1SQAhukf1ZLOdwBFj2+f9yoD2cSxZvuqW/sO2cz1NtbX7hjatmJXzNFctK81
         9CYigjPxYadNg==
Date:   Tue, 28 Mar 2023 14:43:50 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Tharun Kumar P <tharunkumar.pasumarthi@microchip.com>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH SPI for-next] spi: microchip: pci1xxxx: Fix minor bugs in
 spi-pci1xxxx driver
Message-ID: <97c57e1b-9779-4e36-9eac-754fdcb9c504@sirena.org.uk>
References: <20230328054212.139312-1-tharunkumar.pasumarthi@microchip.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="2PS2/CgMOCO2Hp2O"
Content-Disposition: inline
In-Reply-To: <20230328054212.139312-1-tharunkumar.pasumarthi@microchip.com>
X-Cookie: Oh, wow!  Look at the moon!
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--2PS2/CgMOCO2Hp2O
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 28, 2023 at 11:12:12AM +0530, Tharun Kumar P wrote:
> Following bugs are fixed in this patch:
> 1. pci1xxxx_spi_resume API masks SPI interrupt bit which prohibits
> firing of interrupt to the host at the end of the transaction after
> suspend-resume. This patch unmasks this bit at resume.
> 2. In=A0pci1xxxx_spi_transfer_one API, length of SPI transaction gets
> cleared by unmasking length field. Set length of transaction after
> unmasking length field.
> 3. Remove support for disabling chip select as hardware does not support
> the same.

As covered in submitting-patches.rst you should send one patch per
change, this makes things much easier to review.

>  drivers/spi/spi-pci1xxxx.c | 12 ++++--------
>  1 file changed, 4 insertions(+), 8 deletions(-)

The subject says this is a patch for the microchip driver...

>  	/* Set the DEV_SEL bits of the SPI_MST_CTL_REG */
>  	regval =3D readl(par->reg_base + SPI_MST_CTL_REG_OFFSET(p->hw_inst));
> -	if (enable) {
> +	if (!enable) {
>  		regval &=3D ~SPI_MST_CTL_DEVSEL_MASK;
>  		regval |=3D (spi_get_chipselect(spi, 0) << 25);
>  		writel(regval,
>  		       par->reg_base + SPI_MST_CTL_REG_OFFSET(p->hw_inst));
> -	} else {
> -		regval &=3D ~(spi_get_chipselect(spi, 0) << 25);
> -		writel(regval,
> -		       par->reg_base + SPI_MST_CTL_REG_OFFSET(p->hw_inst));
> -

I am unclear how chip select will ever be asserted with this change?
Now the value is only written if we are disabling.

--2PS2/CgMOCO2Hp2O
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmQi7xIACgkQJNaLcl1U
h9Ch8gf+O/MluZL0YuDTHhZLLMwc6B5ISaKg7aLC6AxuIXjQ/I04oR+OhSexo/p7
KvgYa4WouYJxeZim7h98p2qWUjMrTTfUltXnbifLd6L1N3g/l/S1jr6DPGaa2SwV
KiFB5DO7cNuc6GVun1Sv2Q/15w39UbMwRUfqioeHluDn2Na1dCjab8t8G2AokU0B
gzWGZ7mSU+aSf+kmNlDHImh6rsQJqDIkD39CxLppbcyTSIB3WBI2kyCY5LbUhxUE
wdGKDtuVwyfHZHBY/EY+ejyb0mccWoxdshAlcyCN6gj5WVo8Y45B5eoZliBEc60b
6epymPQxByl5AL6IX+XyDTxHg12TLA==
=eYBI
-----END PGP SIGNATURE-----

--2PS2/CgMOCO2Hp2O--
