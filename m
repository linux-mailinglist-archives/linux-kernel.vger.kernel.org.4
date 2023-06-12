Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF22D72CD10
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 19:41:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232637AbjFLRlJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 13:41:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231731AbjFLRlB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 13:41:01 -0400
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::225])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C6A798
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 10:41:00 -0700 (PDT)
X-GND-Sasl: miquel.raynal@bootlin.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1686591659;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DoTTbNvXBcUurbyeVpwbVMaij7JPELHRhQTKrmBNGoU=;
        b=dWOsGXQmoytY91UDXwndQC5STH0UWix9hZNTK5WTNFfo+is61jJkMNrbH7NZ0ypdb7YzH+
        sTcxF80ntZrI3Zj2DlX2xN/VWp4qJov3BKk3GQqrinXhpF3raefjDXCVFiOKziMpFRO0va
        7GpqvqGjXVhHnx5wCUutU95bL/iXELermj5QQrxjp+fCiL1Fvqy3IB7x3Dc21AWlh0V/MH
        I53bJgvIgZ1qivq9npwlFRosVoEmAOt1seJpJfUKLVdOQmXbXuoIVs2H8EeDMLVaZb1c1K
        uZNhEN4+YS72ia5Hjy6zFjL43tjV+vZQSjkgrbnEdN9DvB4aHzPIIVWUhkA5Kg==
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 388001C0007;
        Mon, 12 Jun 2023 17:40:58 +0000 (UTC)
Date:   Mon, 12 Jun 2023 19:40:56 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Johan Jonker <jbx6244@gmail.com>
Cc:     richard@nod.at, vigneshr@ti.com, heiko@sntech.de,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, yifeng.zhao@rock-chips.com
Subject: Re: [PATCH v2 1/5] mtd: nand: raw: rockchip-nand-controller: copy
 hwecc PA data to oob_poi buffer
Message-ID: <20230612194056.7b27edc5@xps-13>
In-Reply-To: <b4e73d0f-d3de-b3e1-26a4-cce5337fe07e@gmail.com>
References: <11e16c3b-6f7b-a6a9-b0ed-b7ac0cd703e3@gmail.com>
        <b4e73d0f-d3de-b3e1-26a4-cce5337fe07e@gmail.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Johan,

jbx6244@gmail.com wrote on Mon, 12 Jun 2023 17:02:40 +0200:

> Rockchip boot blocks are written per 4 x 512 byte sectors per page.
> Each page must have a page address (PA) pointer in OOB to the next page.
> Pages are written in a pattern depending on the NAND chip ID.
> This logic used to build a page pattern table is not fully disclosed and
> is not easy to fit in the MTD framework.
> The formula in rk_nfc_write_page_hwecc() function is not correct.
> Make hwecc and raw behavior identical.
> Generate boot block page address and pattern for hwecc in user space
> and copy PA data to/from the last 4 bytes in the
> chip->oob_poi data layout.
>=20
> Signed-off-by: Johan Jonker <jbx6244@gmail.com>
> ---
>  .../mtd/nand/raw/rockchip-nand-controller.c   | 34 ++++++++++++-------
>  1 file changed, 21 insertions(+), 13 deletions(-)
>=20
> diff --git a/drivers/mtd/nand/raw/rockchip-nand-controller.c b/drivers/mt=
d/nand/raw/rockchip-nand-controller.c
> index 2312e2736..cafccc324 100644
> --- a/drivers/mtd/nand/raw/rockchip-nand-controller.c
> +++ b/drivers/mtd/nand/raw/rockchip-nand-controller.c
> @@ -597,7 +597,7 @@ static int rk_nfc_write_page_hwecc(struct nand_chip *=
chip, const u8 *buf,
>  	int pages_per_blk =3D mtd->erasesize / mtd->writesize;
>  	int ret =3D 0, i, boot_rom_mode =3D 0;
>  	dma_addr_t dma_data, dma_oob;
> -	u32 reg;
> +	u32 tmp;
>  	u8 *oob;
>=20
>  	nand_prog_page_begin_op(chip, page, 0, NULL, 0);
> @@ -624,6 +624,13 @@ static int rk_nfc_write_page_hwecc(struct nand_chip =
*chip, const u8 *buf,
>  	 *
>  	 *   0xFF 0xFF 0xFF 0xFF | BBM OOB1 OOB2 OOB3 | ...
>  	 *
> +	 * The code here just swaps the first 4 bytes with the last
> +	 * 4 bytes without losing any data.

Maybe you don't loose any data, but you basically break all existing
jffs2 users, right? Is this page address only useful on your rk SoC or
are all the SoCs using the same logic?

I think it would be best to flag where this is required and avoid a
massive incompatible change like this one (and the previous one). BTW,
any reason not to merge the two first patches? It seems like the series
would not be bisectable between the two first commits.

Patches 4 and 5 look good as they are not directly related, I'll queue
them, you can avoid re-sending them.

> +	 *
> +	 * The chip->oob_poi data layout:
> +	 *
> +	 *    BBM  OOB1 OOB2 OOB3 |......|  PA0  PA1  PA2  PA3
> +	 *
>  	 * Configure the ECC algorithm supported by the boot ROM.
>  	 */
>  	if ((page < (pages_per_blk * rknand->boot_blks)) &&
> @@ -634,21 +641,17 @@ static int rk_nfc_write_page_hwecc(struct nand_chip=
 *chip, const u8 *buf,
>  	}
>=20
>  	for (i =3D 0; i < ecc->steps; i++) {
> -		if (!i) {
> -			reg =3D 0xFFFFFFFF;
> -		} else {
> +		if (!i)
> +			oob =3D chip->oob_poi + (ecc->steps - 1) * NFC_SYS_DATA_SIZE;
> +		else
>  			oob =3D chip->oob_poi + (i - 1) * NFC_SYS_DATA_SIZE;
> -			reg =3D oob[0] | oob[1] << 8 | oob[2] << 16 |
> -			      oob[3] << 24;
> -		}
>=20
> -		if (!i && boot_rom_mode)
> -			reg =3D (page & (pages_per_blk - 1)) * 4;
> +		tmp =3D oob[0] | oob[1] << 8 | oob[2] << 16 | oob[3] << 24;
>=20
>  		if (nfc->cfg->type =3D=3D NFC_V9)
> -			nfc->oob_buf[i] =3D reg;
> +			nfc->oob_buf[i] =3D tmp;
>  		else
> -			nfc->oob_buf[i * (oob_step / 4)] =3D reg;
> +			nfc->oob_buf[i * (oob_step / 4)] =3D tmp;
>  	}
>=20
>  	dma_data =3D dma_map_single(nfc->dev, (void *)nfc->page_buf,
> @@ -811,12 +814,17 @@ static int rk_nfc_read_page_hwecc(struct nand_chip =
*chip, u8 *buf, int oob_on,
>  		goto timeout_err;
>  	}
>=20
> -	for (i =3D 1; i < ecc->steps; i++) {
> -		oob =3D chip->oob_poi + (i - 1) * NFC_SYS_DATA_SIZE;
> +	for (i =3D 0; i < ecc->steps; i++) {
> +		if (!i)
> +			oob =3D chip->oob_poi + (ecc->steps - 1) * NFC_SYS_DATA_SIZE;
> +		else
> +			oob =3D chip->oob_poi + (i - 1) * NFC_SYS_DATA_SIZE;
> +
>  		if (nfc->cfg->type =3D=3D NFC_V9)
>  			tmp =3D nfc->oob_buf[i];
>  		else
>  			tmp =3D nfc->oob_buf[i * (oob_step / 4)];
> +
>  		*oob++ =3D (u8)tmp;
>  		*oob++ =3D (u8)(tmp >> 8);
>  		*oob++ =3D (u8)(tmp >> 16);
> --
> 2.30.2
>=20


Thanks,
Miqu=C3=A8l
