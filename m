Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35723747521
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 17:19:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231807AbjGDPTA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 11:19:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231230AbjGDPSm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 11:18:42 -0400
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B312BD
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jul 2023 08:18:41 -0700 (PDT)
X-GND-Sasl: miquel.raynal@bootlin.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1688483920;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OOvkfol+in6TlFekwc6yFBfYV4hihVZfvdrg+oeWEiY=;
        b=fuoeTIaHM53J4Bi7m2dpkM3y/mKzgeEGAk93wTuSL4DYZBF3IVUoDBQid1s6kWvHgkdl9Y
        vWmuCiD+pdV/lpY1ypI/M+BlhfFoSXKrsqD/EcMM/9NWAjwIdVjt1UYbxlUREMGJwkUhEk
        jTv1zJXMEytp1Q9gpyss6KkThWksLHl7JfHSrus2KGFTzhhtVaw9MZKD5VxE4f/UQVuXS6
        FVZTjkXdZIpAj4VzYJW8tGSTN5G2Mg6bozCbmolEMspZRI+FOAXjhTsmtjTi/g/QsRMM1I
        MvWwx6zEqqLmTVL2kAYDpnLyI+wcpMxqQCo00veg5dMeF7Wzr6p3s2aEskrLZQ==
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
Received: by mail.gandi.net (Postfix) with ESMTPSA id 33B5B240006;
        Tue,  4 Jul 2023 15:18:38 +0000 (UTC)
Date:   Tue, 4 Jul 2023 17:18:37 +0200
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
Subject: Re: [PATCH v3 1/5] mtd: rawnand: brcmnand: Fix ECC level field
 setting for v7.2 controller
Message-ID: <20230704171837.3db54fb8@xps-13>
In-Reply-To: <20230627193738.19596-2-william.zhang@broadcom.com>
References: <20230627193738.19596-1-william.zhang@broadcom.com>
        <20230627193738.19596-2-william.zhang@broadcom.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi William,

william.zhang@broadcom.com wrote on Tue, 27 Jun 2023 12:37:34 -0700:

> v7.2 controller has different ECC level field size and shift in the acc
> control register than its predecessor and successor controller. It needs
> to be set specifically.
>=20
> Fixes: decba6d47869 ("mtd: brcmnand: Add v7.2 controller support")
> Signed-off-by: William Zhang <william.zhang@broadcom.com>
> Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
>=20
> ---
>=20
> Changes in v3: None
> Changes in v2:
> - Use driver static data for ECC level shift
>=20
>  drivers/mtd/nand/raw/brcmnand/brcmnand.c | 74 +++++++++++++-----------
>  1 file changed, 41 insertions(+), 33 deletions(-)
>=20
> diff --git a/drivers/mtd/nand/raw/brcmnand/brcmnand.c b/drivers/mtd/nand/=
raw/brcmnand/brcmnand.c
> index 2e9c2e2d9c9f..69709419516a 100644
> --- a/drivers/mtd/nand/raw/brcmnand/brcmnand.c
> +++ b/drivers/mtd/nand/raw/brcmnand/brcmnand.c
> @@ -272,6 +272,7 @@ struct brcmnand_controller {
>  	const unsigned int	*page_sizes;
>  	unsigned int		page_size_shift;
>  	unsigned int		max_oob;
> +	u32			ecc_level_shift;
>  	u32			features;
> =20
>  	/* for low-power standby/resume only */
> @@ -596,6 +597,34 @@ enum {
>  	INTFC_CTLR_READY		=3D BIT(31),
>  };
> =20
> +/***********************************************************************
> + * NAND ACC CONTROL bitfield
> + *
> + * Some bits have remained constant throughout hardware revision, while
> + * others have shifted around.
> + ***********************************************************************/
> +
> +/* Constant for all versions (where supported) */
> +enum {
> +	/* See BRCMNAND_HAS_CACHE_MODE */
> +	ACC_CONTROL_CACHE_MODE				=3D BIT(22),
> +
> +	/* See BRCMNAND_HAS_PREFETCH */
> +	ACC_CONTROL_PREFETCH				=3D BIT(23),
> +
> +	ACC_CONTROL_PAGE_HIT				=3D BIT(24),
> +	ACC_CONTROL_WR_PREEMPT				=3D BIT(25),
> +	ACC_CONTROL_PARTIAL_PAGE			=3D BIT(26),
> +	ACC_CONTROL_RD_ERASED				=3D BIT(27),
> +	ACC_CONTROL_FAST_PGM_RDIN			=3D BIT(28),
> +	ACC_CONTROL_WR_ECC				=3D BIT(30),
> +	ACC_CONTROL_RD_ECC				=3D BIT(31),
> +
> +	ACC_CONTROL_ECC_SHIFT				=3D 16,
> +	/* Only for v7.2 */
> +	ACC_CONTROL_ECC_EXT_SHIFT			=3D 13,
> +};

These do not look like they fit the purpose of enums. At least keep
these two last definitions outside like before (you can rename them, I
don't mind).

LGTM otherwise.

> +
>  static inline bool brcmnand_non_mmio_ops(struct brcmnand_controller *ctr=
l)
>  {
>  #if IS_ENABLED(CONFIG_MTD_NAND_BRCMNAND_BCMA)
> @@ -737,6 +766,12 @@ static int brcmnand_revision_init(struct brcmnand_co=
ntroller *ctrl)
>  	else if (of_property_read_bool(ctrl->dev->of_node, "brcm,nand-has-wp"))
>  		ctrl->features |=3D BRCMNAND_HAS_WP;
> =20
> +	/* v7.2 has different ecc level shift in the acc register */
> +	if (ctrl->nand_version =3D=3D 0x0702)
> +		ctrl->ecc_level_shift =3D ACC_CONTROL_ECC_EXT_SHIFT;
> +	else
> +		ctrl->ecc_level_shift =3D ACC_CONTROL_ECC_SHIFT;
> +
>  	return 0;
>  }
> =20
> @@ -931,30 +966,6 @@ static inline int brcmnand_cmd_shift(struct brcmnand=
_controller *ctrl)
>  	return 0;
>  }
> =20
> -/***********************************************************************
> - * NAND ACC CONTROL bitfield
> - *
> - * Some bits have remained constant throughout hardware revision, while
> - * others have shifted around.
> - ***********************************************************************/
> -
> -/* Constant for all versions (where supported) */
> -enum {
> -	/* See BRCMNAND_HAS_CACHE_MODE */
> -	ACC_CONTROL_CACHE_MODE				=3D BIT(22),
> -
> -	/* See BRCMNAND_HAS_PREFETCH */
> -	ACC_CONTROL_PREFETCH				=3D BIT(23),
> -
> -	ACC_CONTROL_PAGE_HIT				=3D BIT(24),
> -	ACC_CONTROL_WR_PREEMPT				=3D BIT(25),
> -	ACC_CONTROL_PARTIAL_PAGE			=3D BIT(26),
> -	ACC_CONTROL_RD_ERASED				=3D BIT(27),
> -	ACC_CONTROL_FAST_PGM_RDIN			=3D BIT(28),
> -	ACC_CONTROL_WR_ECC				=3D BIT(30),
> -	ACC_CONTROL_RD_ECC				=3D BIT(31),
> -};
> -
>  static inline u32 brcmnand_spare_area_mask(struct brcmnand_controller *c=
trl)
>  {
>  	if (ctrl->nand_version =3D=3D 0x0702)
> @@ -967,18 +978,15 @@ static inline u32 brcmnand_spare_area_mask(struct b=
rcmnand_controller *ctrl)
>  		return GENMASK(4, 0);
>  }
> =20
> -#define NAND_ACC_CONTROL_ECC_SHIFT	16
> -#define NAND_ACC_CONTROL_ECC_EXT_SHIFT	13
> -
>  static inline u32 brcmnand_ecc_level_mask(struct brcmnand_controller *ct=
rl)
>  {
>  	u32 mask =3D (ctrl->nand_version >=3D 0x0600) ? 0x1f : 0x0f;
> =20
> -	mask <<=3D NAND_ACC_CONTROL_ECC_SHIFT;
> +	mask <<=3D ACC_CONTROL_ECC_SHIFT;
> =20
>  	/* v7.2 includes additional ECC levels */
> -	if (ctrl->nand_version >=3D 0x0702)
> -		mask |=3D 0x7 << NAND_ACC_CONTROL_ECC_EXT_SHIFT;
> +	if (ctrl->nand_version =3D=3D 0x0702)
> +		mask |=3D 0x7 << ACC_CONTROL_ECC_EXT_SHIFT;
> =20
>  	return mask;
>  }
> @@ -992,8 +1000,8 @@ static void brcmnand_set_ecc_enabled(struct brcmnand=
_host *host, int en)
> =20
>  	if (en) {
>  		acc_control |=3D ecc_flags; /* enable RD/WR ECC */
> -		acc_control |=3D host->hwcfg.ecc_level
> -			       << NAND_ACC_CONTROL_ECC_SHIFT;
> +		acc_control &=3D ~brcmnand_ecc_level_mask(ctrl);
> +		acc_control |=3D host->hwcfg.ecc_level << ctrl->ecc_level_shift;
>  	} else {
>  		acc_control &=3D ~ecc_flags; /* disable RD/WR ECC */
>  		acc_control &=3D ~brcmnand_ecc_level_mask(ctrl);
> @@ -2561,7 +2569,7 @@ static int brcmnand_set_cfg(struct brcmnand_host *h=
ost,
>  	tmp &=3D ~brcmnand_ecc_level_mask(ctrl);
>  	tmp &=3D ~brcmnand_spare_area_mask(ctrl);
>  	if (ctrl->nand_version >=3D 0x0302) {
> -		tmp |=3D cfg->ecc_level << NAND_ACC_CONTROL_ECC_SHIFT;
> +		tmp |=3D cfg->ecc_level << ctrl->ecc_level_shift;
>  		tmp |=3D cfg->spare_area_size;
>  	}
>  	nand_writereg(ctrl, acc_control_offs, tmp);


Thanks,
Miqu=C3=A8l
