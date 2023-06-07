Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE94A72577E
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 10:25:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238994AbjFGIZh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 04:25:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238425AbjFGIZa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 04:25:30 -0400
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::225])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92A3F184
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 01:25:28 -0700 (PDT)
X-GND-Sasl: miquel.raynal@bootlin.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1686126327;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HH/cng7bNv0Q6+Hy8DU1tyWKgJYv/7rMDAdOo17bcu8=;
        b=hDR8CVNP6ZJPvLTqE6Op24qxDTLiBo7UozzNueq5MOgC3Ad9IlcFi/fi+lh2PUJOFX/Cze
        JXlgs31bXcuRJBpJ5NHb4sE2+RPFUCaFVlhBDItyM2Ys6LV7Ej7dCUDZDR2b0QtRFvZZXq
        NJBd3agDFDqOMP66UPwiAcrnOxebD/KMtxin/QBOxG531GCFBbfMci8MDYUxBt3bvZaxh5
        69pPSolNkTYcr0zu9uac1psdVbD8IZsVL+7XXHLogE1qAv6d5ctcx7UtQKxqB7qdLsXF6D
        3RkYI1BV2ifZSM+pLOiP/Xcm21FX4qf+kD2rMb9T2NZV+e4pUgZeA/ZP7EN8og==
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
Received: by mail.gandi.net (Postfix) with ESMTPSA id A1BC91C0002;
        Wed,  7 Jun 2023 08:25:25 +0000 (UTC)
Date:   Wed, 7 Jun 2023 10:25:24 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     William Zhang <william.zhang@broadcom.com>
Cc:     Broadcom Kernel List <bcm-kernel-feedback-list@broadcom.com>,
        Linux MTD List <linux-mtd@lists.infradead.org>,
        f.fainelli@gmail.com, rafal@milecki.pl, kursad.oney@broadcom.com,
        joel.peshkin@broadcom.com, computersforpeace@gmail.com,
        anand.gore@broadcom.com, dregan@mail.com, kamal.dasu@broadcom.com,
        tomer.yacoby@broadcom.com, dan.beygelman@broadcom.com,
        linux-kernel@vger.kernel.org,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Richard Weinberger <richard@nod.at>,
        Kamal Dasu <kdasu.kdev@gmail.com>
Subject: Re: [PATCH 11/12] mtd: rawnand: brcmnand: Add support for getting
 ecc setting from strap
Message-ID: <20230607102524.10a7a928@xps-13>
In-Reply-To: <20230606231252.94838-12-william.zhang@broadcom.com>
References: <20230606231252.94838-1-william.zhang@broadcom.com>
        <20230606231252.94838-12-william.zhang@broadcom.com>
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

william.zhang@broadcom.com wrote on Tue,  6 Jun 2023 16:12:51 -0700:

> BCMBCA broadband SoC based board design does not specify ecc setting in
> dts but rather use the SoC NAND strap info to obtain the ecc strength
> and spare area size setting. Add brcm,nand-ecc-use-strap dts propety for
> this purpose and update driver to support this option.
>=20
> The generic nand ecc settings still take precedence over this flag. For
> example, if nand-ecc-strength is set in the dts, the driver ignores the
> strap setting and falls back to original behavior. This makes sure that
> the existing BCMBCA board dts still works the old way even the strap
> flag is set in the BCMBCA chip dtsi.
>=20
> Signed-off-by: William Zhang <william.zhang@broadcom.com>
> ---
>=20
>  drivers/mtd/nand/raw/brcmnand/brcmnand.c | 72 +++++++++++++++++++++---
>  1 file changed, 64 insertions(+), 8 deletions(-)
>=20
> diff --git a/drivers/mtd/nand/raw/brcmnand/brcmnand.c b/drivers/mtd/nand/=
raw/brcmnand/brcmnand.c
> index 656be4d73016..8c7cea36ac71 100644
> --- a/drivers/mtd/nand/raw/brcmnand/brcmnand.c
> +++ b/drivers/mtd/nand/raw/brcmnand/brcmnand.c
> @@ -1076,6 +1076,38 @@ static void brcmnand_set_sector_size_1k(struct brc=
mnand_host *host, int val)
>  	nand_writereg(ctrl, acc_control_offs, tmp);
>  }
> =20
> +static int brcmnand_get_spare_size(struct brcmnand_host *host)
> +{
> +	struct brcmnand_controller *ctrl =3D host->ctrl;
> +	u16 acc_control_offs =3D brcmnand_cs_offset(ctrl, host->cs,
> +						  BRCMNAND_CS_ACC_CONTROL);
> +	u32 acc =3D nand_readreg(ctrl, acc_control_offs);
> +
> +	return (acc&brcmnand_spare_area_mask(ctrl));
> +}
> +
> +static int brcmnand_get_ecc_strength(struct brcmnand_host *host)
> +{
> +	struct brcmnand_controller *ctrl =3D host->ctrl;
> +	u16 acc_control_offs =3D brcmnand_cs_offset(ctrl, host->cs,
> +						  BRCMNAND_CS_ACC_CONTROL);
> +	int sector_size_1k =3D brcmnand_get_sector_size_1k(host);
> +	int spare_area_size, ecc_level, ecc_strength;
> +	u32 acc;
> +
> +	spare_area_size =3D brcmnand_get_spare_size(host);
> +	acc =3D nand_readreg(ctrl, acc_control_offs);
> +	ecc_level =3D (acc & brcmnand_ecc_level_mask(ctrl)) >> brcmnand_ecc_lev=
el_shift(ctrl);
> +	if (sector_size_1k)
> +		ecc_strength =3D ecc_level<<1;

                                          ?

If you mean "x2" then let the compiler do that.

> +	else if (spare_area_size =3D=3D 16 && ecc_level =3D=3D 15)
> +		ecc_strength =3D 1; /* hamming */
> +	else
> +		ecc_strength =3D ecc_level;
> +
> +	return ecc_strength;
> +}
> +
>  /***********************************************************************
>   * CS_NAND_SELECT
>   ***********************************************************************/
> @@ -2656,19 +2688,43 @@ static int brcmnand_setup_dev(struct brcmnand_hos=
t *host)
>  		nanddev_get_ecc_requirements(&chip->base);
>  	struct brcmnand_controller *ctrl =3D host->ctrl;
>  	struct brcmnand_cfg *cfg =3D &host->hwcfg;
> -	char msg[128];
> +	struct device_node *np =3D nand_get_flash_node(chip);
>  	u32 offs, tmp, oob_sector;
> -	int ret;
> +	int ret, sector_size_1k =3D 0;
> +	bool use_strap =3D false;
> +	char msg[128];
> =20
>  	memset(cfg, 0, sizeof(*cfg));
> +	use_strap =3D of_property_read_bool(np, "brcm,nand-ecc-use-strap");
> +
> +	/*
> +	 * Set ECC size and strength based on hw configuration from strap
> +	 * if device tree does not specify them and use strap property is set
> +	 * If ecc strength is set in dts, don't use strap setting.
> +	 */
> +	if (chip->ecc.strength)
> +		use_strap =3D 0;
> +
> +	if (use_strap) {
> +		chip->ecc.strength =3D brcmnand_get_ecc_strength(host);
> +		sector_size_1k =3D brcmnand_get_sector_size_1k(host);
> +		if (chip->ecc.size =3D=3D 0) {
> +			if (sector_size_1k < 0)
> +				chip->ecc.size =3D 512;
> +			else
> +				chip->ecc.size =3D 512<<sector_size_1k;

Please run checkpatch.pl --strict

> +		}
> +	}
> =20
> -	ret =3D of_property_read_u32(nand_get_flash_node(chip),
> -				   "brcm,nand-oob-sector-size",
> -				   &oob_sector);
> +	ret =3D of_property_read_u32(np, "brcm,nand-oob-sector-size",
> +			   &oob_sector);
>  	if (ret) {
> -		/* Use detected size */
> -		cfg->spare_area_size =3D mtd->oobsize /
> -					(mtd->writesize >> FC_SHIFT);
> +		if (use_strap)
> +			cfg->spare_area_size =3D brcmnand_get_spare_size(host);
> +		else
> +			/* Use detected size */
> +			cfg->spare_area_size =3D mtd->oobsize /
> +						(mtd->writesize >> FC_SHIFT);
>  	} else {
>  		cfg->spare_area_size =3D oob_sector;
>  	}


Thanks,
Miqu=C3=A8l
