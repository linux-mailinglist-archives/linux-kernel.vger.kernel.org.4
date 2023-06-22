Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9A16739860
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 09:47:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230013AbjFVHrb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 03:47:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230190AbjFVHr3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 03:47:29 -0400
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E7241BE1
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 00:47:27 -0700 (PDT)
X-GND-Sasl: miquel.raynal@bootlin.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1687420045;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=89WP1q/8S6g2s5tTpGK/iOZXZ5QteoJHJMjMT1W427M=;
        b=C5SSSVQk7NMUCrYxoxCCtHop04npnYWlkIUxThInbZrqvNGHLr9zQGLT3M9Bei4Qp1HD7/
        ikSTpjyatD6tYhBcqkfccGPmZ/91N7F9gAedkeJ2BwGAY728ozlgn3FsmjtD6qQb3vn0Kp
        k1jMSr/gn8FBXSPr9I5bJ0IvBZrvU1tsP/gC+Sf2nAFQuK69qotxdV3qssbhs6UxkT25Ae
        kFkboaUsRi6gkDPu2jstaz3SZMJH3jr8kFowwXVYH/B0h1lFKEps7EHW6p+6NDiQHMvuK3
        l/weV/JA/jPcgp00VG0AaK7Pahms5b0ZgSvDrXUa6aM0oTklSqkt0uphCS/tcw==
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id B706E24000C;
        Thu, 22 Jun 2023 07:47:24 +0000 (UTC)
Date:   Thu, 22 Jun 2023 09:47:23 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Olivier Maignial <olivier.maignial@hotmail.fr>
Cc:     olivier.maignial@somfy.com, Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mtd: spinand: winbond|toshiba: Fix ecc_get_status
Message-ID: <20230622094723.37b70bd3@xps-13>
In-Reply-To: <DB4P250MB103296BD8C6C8CD514A46E83FE5CA@DB4P250MB1032.EURP250.PROD.OUTLOOK.COM>
References: <DB4P250MB103296BD8C6C8CD514A46E83FE5CA@DB4P250MB1032.EURP250.PROD.OUTLOOK.COM>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Olivier,

olivier.maignial@hotmail.fr wrote on Tue, 20 Jun 2023 23:16:15 +0200:

> Reading ECC status is failing in toshiba & winbond spi-nand drivers.
>=20
> tx58cxgxsxraix_ecc_get_status() and w25n02kv_ecc_get_status()
> functions are using on-stack buffers which are not suitable
> for DMA needs of spi-mem.
>=20
> Fix this by using the spi-mem operations dedicated buffer
> spinand->scratchbuf

Missing period       .

>=20
> See
> spinand->scratchbuf:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/i=
nclude/linux/mtd/spinand.h?h=3Dv6.3#n418
> spi_mem_check_op():
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/d=
rivers/spi/spi-mem.c?h=3Dv6.3#n199

Could you add a Cc: stable and a Fixes tag? It might require to address
both drivers independently (in two different commits), this is not a
problem.

Otherwise LGTM!

Thanks,
Miqu=C3=A8l

> Signed-off-by: Olivier Maignial <olivier.maignial@hotmail.fr>
> ---
>  drivers/mtd/nand/spi/toshiba.c | 4 ++--
>  drivers/mtd/nand/spi/winbond.c | 4 ++--
>  2 files changed, 4 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/mtd/nand/spi/toshiba.c b/drivers/mtd/nand/spi/toshib=
a.c
> index 7380b1ebaccd..a80427c13121 100644
> --- a/drivers/mtd/nand/spi/toshiba.c
> +++ b/drivers/mtd/nand/spi/toshiba.c
> @@ -73,7 +73,7 @@ static int tx58cxgxsxraix_ecc_get_status(struct spinand=
_device *spinand,
>  {
>  	struct nand_device *nand =3D spinand_to_nand(spinand);
>  	u8 mbf =3D 0;
> -	struct spi_mem_op op =3D SPINAND_GET_FEATURE_OP(0x30, &mbf);
> +	struct spi_mem_op op =3D SPINAND_GET_FEATURE_OP(0x30, spinand->scratchb=
uf);
> =20
>  	switch (status & STATUS_ECC_MASK) {
>  	case STATUS_ECC_NO_BITFLIPS:
> @@ -92,7 +92,7 @@ static int tx58cxgxsxraix_ecc_get_status(struct spinand=
_device *spinand,
>  		if (spi_mem_exec_op(spinand->spimem, &op))
>  			return nanddev_get_ecc_conf(nand)->strength;
> =20
> -		mbf >>=3D 4;
> +		mbf =3D *(spinand->scratchbuf) >> 4;
> =20
>  		if (WARN_ON(mbf > nanddev_get_ecc_conf(nand)->strength || !mbf))
>  			return nanddev_get_ecc_conf(nand)->strength;
> diff --git a/drivers/mtd/nand/spi/winbond.c b/drivers/mtd/nand/spi/winbon=
d.c
> index 3ad58cd284d8..f507e3759301 100644
> --- a/drivers/mtd/nand/spi/winbond.c
> +++ b/drivers/mtd/nand/spi/winbond.c
> @@ -108,7 +108,7 @@ static int w25n02kv_ecc_get_status(struct spinand_dev=
ice *spinand,
>  {
>  	struct nand_device *nand =3D spinand_to_nand(spinand);
>  	u8 mbf =3D 0;
> -	struct spi_mem_op op =3D SPINAND_GET_FEATURE_OP(0x30, &mbf);
> +	struct spi_mem_op op =3D SPINAND_GET_FEATURE_OP(0x30, spinand->scratchb=
uf);
> =20
>  	switch (status & STATUS_ECC_MASK) {
>  	case STATUS_ECC_NO_BITFLIPS:
> @@ -126,7 +126,7 @@ static int w25n02kv_ecc_get_status(struct spinand_dev=
ice *spinand,
>  		if (spi_mem_exec_op(spinand->spimem, &op))
>  			return nanddev_get_ecc_conf(nand)->strength;
> =20
> -		mbf >>=3D 4;
> +		mbf =3D *(spinand->scratchbuf) >> 4;
> =20
>  		if (WARN_ON(mbf > nanddev_get_ecc_conf(nand)->strength || !mbf))
>  			return nanddev_get_ecc_conf(nand)->strength;

