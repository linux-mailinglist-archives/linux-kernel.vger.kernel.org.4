Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C08065AEA8
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Jan 2023 10:30:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229982AbjABJaU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Jan 2023 04:30:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229640AbjABJaS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jan 2023 04:30:18 -0500
Received: from relay10.mail.gandi.net (relay10.mail.gandi.net [217.70.178.230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86AFE25D8
        for <linux-kernel@vger.kernel.org>; Mon,  2 Jan 2023 01:30:16 -0800 (PST)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id AE638240006;
        Mon,  2 Jan 2023 09:30:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1672651814;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TfPe+kgpzqsrNLM0lsYjTizOT0I17cc9ihmNZot7mDo=;
        b=na67jTXPFjGOJo9yKW1IMOLZCDBRSYhxSkkDdqa5rv+LuIIbGFLvjknm7M7gXNci/HPTx8
        mgAaeOyv9TIZIigUS5TfUEE8IgaWYxfJBVVZS2Ysj89naOX9bOfLeDYptHTtJ0HZ87yaoP
        8Zbl1BdNB5wHZOXvPnZUpbycH6/Z9hx8mY8Z7bv3Q+4qKGytQN4toyQjlUsqVjCMTaqFsa
        APMd0257i8bQZqro16cklz3uFD07+omQUxlHk0WolZbjSvViu51LUQyUxNfSgZFaquFoUM
        AX8pETa1zv90Sq5mMf1aFNbdrBu22y0Cl3IvEOlXMSF0/CKf6+J+UGQroA+LEQ==
Date:   Mon, 2 Jan 2023 10:30:09 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Samuel Holland <samuel@sholland.org>
Cc:     Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Boris Brezillon <bbrezillon@kernel.org>,
        Brian Norris <computersforpeace@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-sunxi@lists.linux.dev
Subject: Re: [PATCH 7/7] mtd: rawnand: sunxi: Precompute the ECC_CTL
 register value
Message-ID: <20230102103009.00486aa3@xps-13>
In-Reply-To: <20221229181526.53766-8-samuel@sholland.org>
References: <20221229181526.53766-1-samuel@sholland.org>
        <20221229181526.53766-8-samuel@sholland.org>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Samuel,

samuel@sholland.org wrote on Thu, 29 Dec 2022 12:15:26 -0600:

> This removes an unnecessary memory allocation, and avoids recomputing
> the same register value every time ECC is enabled.

I am fine with the "let's not recompute the register value each time"
idea, but I like having a dedicated object reserved for the ECC
engine, that is separated from the main controller structure (both
are two different things, even though they are usually well
integrated).

If it's actually useless you can still get rid of the allocation and in
the structure you can save the ecc_ctrl reg value instead of mode.

The other patches in the series look good to me.

Thanks,
Miqu=C3=A8l

> Signed-off-by: Samuel Holland <samuel@sholland.org>
> ---
>=20
>  drivers/mtd/nand/raw/sunxi_nand.c | 75 ++++++-------------------------
>  1 file changed, 13 insertions(+), 62 deletions(-)
>=20
> diff --git a/drivers/mtd/nand/raw/sunxi_nand.c b/drivers/mtd/nand/raw/sun=
xi_nand.c
> index a3bc9f7f9e5a..5c5a567d8870 100644
> --- a/drivers/mtd/nand/raw/sunxi_nand.c
> +++ b/drivers/mtd/nand/raw/sunxi_nand.c
> @@ -169,22 +169,13 @@ struct sunxi_nand_chip_sel {
>  	s8 rb;
>  };
> =20
> -/**
> - * struct sunxi_nand_hw_ecc - stores information related to HW ECC suppo=
rt
> - *
> - * @mode: the sunxi ECC mode field deduced from ECC requirements
> - */
> -struct sunxi_nand_hw_ecc {
> -	int mode;
> -};
> -
>  /**
>   * struct sunxi_nand_chip - stores NAND chip device related information
>   *
>   * @node: used to store NAND chips into a list
>   * @nand: base NAND chip structure
> - * @ecc: ECC controller structure
>   * @clk_rate: clk_rate required for this NAND chip
> + * @ecc_ctl: ECC_CTL register value for this NAND chip
>   * @timing_cfg: TIMING_CFG register value for this NAND chip
>   * @timing_ctl: TIMING_CTL register value for this NAND chip
>   * @nsels: number of CS lines required by the NAND chip
> @@ -193,8 +184,8 @@ struct sunxi_nand_hw_ecc {
>  struct sunxi_nand_chip {
>  	struct list_head node;
>  	struct nand_chip nand;
> -	struct sunxi_nand_hw_ecc *ecc;
>  	unsigned long clk_rate;
> +	u32 ecc_ctl;
>  	u32 timing_cfg;
>  	u32 timing_ctl;
>  	int nsels;
> @@ -689,26 +680,15 @@ static void sunxi_nfc_hw_ecc_enable(struct nand_chi=
p *nand)
>  {
>  	struct sunxi_nand_chip *sunxi_nand =3D to_sunxi_nand(nand);
>  	struct sunxi_nfc *nfc =3D to_sunxi_nfc(nand->controller);
> -	u32 ecc_ctl;
> -
> -	ecc_ctl =3D readl(nfc->regs + NFC_REG_ECC_CTL);
> -	ecc_ctl &=3D ~(NFC_ECC_MODE_MSK | NFC_ECC_PIPELINE |
> -		     NFC_ECC_BLOCK_SIZE_MSK);
> -	ecc_ctl |=3D NFC_ECC_EN | NFC_ECC_MODE(sunxi_nand->ecc->mode) |
> -		   NFC_ECC_EXCEPTION | NFC_ECC_PIPELINE;
> -
> -	if (nand->ecc.size =3D=3D 512)
> -		ecc_ctl |=3D NFC_ECC_BLOCK_512;
> =20
> -	writel(ecc_ctl, nfc->regs + NFC_REG_ECC_CTL);
> +	writel(sunxi_nand->ecc_ctl, nfc->regs + NFC_REG_ECC_CTL);
>  }
> =20
>  static void sunxi_nfc_hw_ecc_disable(struct nand_chip *nand)
>  {
>  	struct sunxi_nfc *nfc =3D to_sunxi_nfc(nand->controller);
> =20
> -	writel(readl(nfc->regs + NFC_REG_ECC_CTL) & ~NFC_ECC_EN,
> -	       nfc->regs + NFC_REG_ECC_CTL);
> +	writel(0, nfc->regs + NFC_REG_ECC_CTL);
>  }
> =20
>  static inline void sunxi_nfc_user_data_to_buf(u32 user_data, u8 *buf)
> @@ -1626,11 +1606,6 @@ static const struct mtd_ooblayout_ops sunxi_nand_o=
oblayout_ops =3D {
>  	.free =3D sunxi_nand_ooblayout_free,
>  };
> =20
> -static void sunxi_nand_hw_ecc_ctrl_cleanup(struct sunxi_nand_chip *sunxi=
_nand)
> -{
> -	kfree(sunxi_nand->ecc);
> -}
> -
>  static int sunxi_nand_hw_ecc_ctrl_init(struct nand_chip *nand,
>  				       struct nand_ecc_ctrl *ecc,
>  				       struct device_node *np)
> @@ -1641,7 +1616,6 @@ static int sunxi_nand_hw_ecc_ctrl_init(struct nand_=
chip *nand,
>  	struct mtd_info *mtd =3D nand_to_mtd(nand);
>  	struct nand_device *nanddev =3D mtd_to_nanddev(mtd);
>  	int nsectors;
> -	int ret;
>  	int i;
> =20
>  	if (nanddev->ecc.user_conf.flags & NAND_ECC_MAXIMIZE_STRENGTH) {
> @@ -1675,10 +1649,6 @@ static int sunxi_nand_hw_ecc_ctrl_init(struct nand=
_chip *nand,
>  	if (ecc->size !=3D 512 && ecc->size !=3D 1024)
>  		return -EINVAL;
> =20
> -	sunxi_nand->ecc =3D kzalloc(sizeof(*sunxi_nand->ecc), GFP_KERNEL);
> -	if (!sunxi_nand->ecc)
> -		return -ENOMEM;
> -
>  	/* Prefer 1k ECC chunk over 512 ones */
>  	if (ecc->size =3D=3D 512 && mtd->writesize > 512) {
>  		ecc->size =3D 1024;
> @@ -1699,12 +1669,9 @@ static int sunxi_nand_hw_ecc_ctrl_init(struct nand=
_chip *nand,
> =20
>  	if (i >=3D ARRAY_SIZE(strengths)) {
>  		dev_err(nfc->dev, "unsupported strength\n");
> -		ret =3D -ENOTSUPP;
> -		goto err;
> +		return -ENOTSUPP;
>  	}
> =20
> -	sunxi_nand->ecc->mode =3D i;
> -
>  	/* HW ECC always request ECC bytes for 1024 bytes blocks */
>  	ecc->bytes =3D DIV_ROUND_UP(ecc->strength * fls(8 * 1024), 8);
> =20
> @@ -1713,10 +1680,14 @@ static int sunxi_nand_hw_ecc_ctrl_init(struct nan=
d_chip *nand,
> =20
>  	nsectors =3D mtd->writesize / ecc->size;
> =20
> -	if (mtd->oobsize < ((ecc->bytes + 4) * nsectors)) {
> -		ret =3D -EINVAL;
> -		goto err;
> -	}
> +	if (mtd->oobsize < ((ecc->bytes + 4) * nsectors))
> +		return -EINVAL;
> +
> +	sunxi_nand->ecc_ctl =3D NFC_ECC_MODE(i) | NFC_ECC_EXCEPTION |
> +			      NFC_ECC_PIPELINE | NFC_ECC_EN;
> +
> +	if (ecc->size =3D=3D 512)
> +		sunxi_nand->ecc_ctl |=3D NFC_ECC_BLOCK_512;
> =20
>  	ecc->read_oob =3D sunxi_nfc_hw_ecc_read_oob;
>  	ecc->write_oob =3D sunxi_nfc_hw_ecc_write_oob;
> @@ -1739,25 +1710,6 @@ static int sunxi_nand_hw_ecc_ctrl_init(struct nand=
_chip *nand,
>  	ecc->write_oob_raw =3D nand_write_oob_std;
> =20
>  	return 0;
> -
> -err:
> -	kfree(sunxi_nand->ecc);
> -
> -	return ret;
> -}
> -
> -static void sunxi_nand_ecc_cleanup(struct sunxi_nand_chip *sunxi_nand)
> -{
> -	struct nand_ecc_ctrl *ecc =3D &sunxi_nand->nand.ecc;
> -
> -	switch (ecc->engine_type) {
> -	case NAND_ECC_ENGINE_TYPE_ON_HOST:
> -		sunxi_nand_hw_ecc_ctrl_cleanup(sunxi_nand);
> -		break;
> -	case NAND_ECC_ENGINE_TYPE_NONE:
> -	default:
> -		break;
> -	}
>  }
> =20
>  static int sunxi_nand_attach_chip(struct nand_chip *nand)
> @@ -1970,7 +1922,6 @@ static void sunxi_nand_chips_cleanup(struct sunxi_n=
fc *nfc)
>  		ret =3D mtd_device_unregister(nand_to_mtd(chip));
>  		WARN_ON(ret);
>  		nand_cleanup(chip);
> -		sunxi_nand_ecc_cleanup(sunxi_nand);
>  		list_del(&sunxi_nand->node);
>  	}
>  }
