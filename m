Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BE177256F1
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 10:07:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239167AbjFGIG6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 04:06:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239074AbjFGIGs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 04:06:48 -0400
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::225])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C7A21FE3
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 01:06:29 -0700 (PDT)
X-GND-Sasl: miquel.raynal@bootlin.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1686125169;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rTWChzRyayI78lhaVUyNkBtUmmWF3hQHhfD/t1f4gmM=;
        b=Sy2QbKFD8xw5UqJnG7YiQuQLZDV5+PmStmjpqY4S/04TYotd2+Ow/S9wQcGptwGnNf1uxM
        SmHzSRTKL5png8d9FrgWQD/RSqjFSxqiwHVI2pXLh1ohRFXtO7vM1HlRPpc7noix8mz32v
        jRyIfPQSMd2J4NTFrXpLj160MPrkOAaoHLtaCDpk33uXpVo36o36+rJRozF7DObYJRQtht
        hyKtFRLxI83vuElPcpfwH2J7JPXETRPYJxAXL/XRtRZ1h1fOSI9b4OMCqwAaY4Kt8OkQHF
        W+TZZdnacem7zQaq3Hu86wbZmIu0ssQFrEvtDuX/4N7moZqqCzPX+fdM9prJ5g==
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 431341C0006;
        Wed,  7 Jun 2023 08:06:08 +0000 (UTC)
Date:   Wed, 7 Jun 2023 10:06:07 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     William Zhang <william.zhang@broadcom.com>
Cc:     Broadcom Kernel List <bcm-kernel-feedback-list@broadcom.com>,
        Linux MTD List <linux-mtd@lists.infradead.org>,
        f.fainelli@gmail.com, rafal@milecki.pl, kursad.oney@broadcom.com,
        joel.peshkin@broadcom.com, computersforpeace@gmail.com,
        anand.gore@broadcom.com, dregan@mail.com, kamal.dasu@broadcom.com,
        tomer.yacoby@broadcom.com, dan.beygelman@broadcom.com,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Richard Weinberger <richard@nod.at>,
        Boris Brezillon <bbrezillon@kernel.org>,
        Kamal Dasu <kdasu.kdev@gmail.com>
Subject: Re: [PATCH 01/12] mtd: rawnand: brcmnand: Fix ECC level field
 setting for v7.2 controller
Message-ID: <20230607100607.135bfba4@xps-13>
In-Reply-To: <20230606231252.94838-2-william.zhang@broadcom.com>
References: <20230606231252.94838-1-william.zhang@broadcom.com>
        <20230606231252.94838-2-william.zhang@broadcom.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi William,

william.zhang@broadcom.com wrote on Tue,  6 Jun 2023 16:12:41 -0700:

> v7.2 controller has different ECC level field size and shift in the acc
> control register than its predecessor and successor controller. It needs
> to be set specifically.
>=20
> Fixes: decba6d47869 ("mtd: brcmnand: Add v7.2 controller support")
> Signed-off-by: William Zhang <william.zhang@broadcom.com>
> Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
> ---
>=20
>  drivers/mtd/nand/raw/brcmnand/brcmnand.c | 14 +++++++++++---
>  1 file changed, 11 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/mtd/nand/raw/brcmnand/brcmnand.c b/drivers/mtd/nand/=
raw/brcmnand/brcmnand.c
> index 2e9c2e2d9c9f..b2cde1082b3b 100644
> --- a/drivers/mtd/nand/raw/brcmnand/brcmnand.c
> +++ b/drivers/mtd/nand/raw/brcmnand/brcmnand.c
> @@ -977,12 +977,20 @@ static inline u32 brcmnand_ecc_level_mask(struct br=
cmnand_controller *ctrl)
>  	mask <<=3D NAND_ACC_CONTROL_ECC_SHIFT;
> =20
>  	/* v7.2 includes additional ECC levels */
> -	if (ctrl->nand_version >=3D 0x0702)
> +	if (ctrl->nand_version =3D=3D 0x0702)
>  		mask |=3D 0x7 << NAND_ACC_CONTROL_ECC_EXT_SHIFT;
> =20
>  	return mask;
>  }
> =20
> +static inline int brcmnand_ecc_level_shift(struct brcmnand_controller *c=
trl)
> +{
> +	if (ctrl->nand_version =3D=3D 0x0702)
> +		return NAND_ACC_CONTROL_ECC_EXT_SHIFT;
> +	else
> +		return NAND_ACC_CONTROL_ECC_SHIFT;
> +}
> +
>  static void brcmnand_set_ecc_enabled(struct brcmnand_host *host, int en)
>  {
>  	struct brcmnand_controller *ctrl =3D host->ctrl;
> @@ -992,8 +1000,8 @@ static void brcmnand_set_ecc_enabled(struct brcmnand=
_host *host, int en)
> =20
>  	if (en) {
>  		acc_control |=3D ecc_flags; /* enable RD/WR ECC */
> -		acc_control |=3D host->hwcfg.ecc_level
> -			       << NAND_ACC_CONTROL_ECC_SHIFT;
> +		acc_control &=3D ~brcmnand_ecc_level_mask(ctrl);

Could we use static driver data instead? Let's avoid making
non-useful function calls when this can easily be avoided.

> +		acc_control |=3D host->hwcfg.ecc_level << brcmnand_ecc_level_shift(ctr=
l);
>  	} else {
>  		acc_control &=3D ~ecc_flags; /* disable RD/WR ECC */
>  		acc_control &=3D ~brcmnand_ecc_level_mask(ctrl);


Thanks,
Miqu=C3=A8l
