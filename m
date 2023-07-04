Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 575217474F7
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 17:09:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231383AbjGDPJD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 11:09:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231243AbjGDPJC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 11:09:02 -0400
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::225])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E633910CF
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jul 2023 08:09:00 -0700 (PDT)
X-GND-Sasl: miquel.raynal@bootlin.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1688483339;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2e1y57kMTneCeOtV2lfhgiriEfxFx2Hg2M8j4ecPq1c=;
        b=mvQc7yb3VPnLvTVztzn7lcdFYh4ZeB0JalspSDn7QOQyDaubg3/7+6FEJzdWE8thvvxzxU
        Vu//sqJiKAkbN+g2DFQZAADDNiuYAAAEM05HlbKnaJ/QxbcC/nJhHcwPi8gA5Qomgx4t9Z
        GHmfk8VrTxcF/J90mfFusWsYsT0x5GIg34f1jch6fb9zibTBgL7YhPRLBySAa9mUdJi5Eo
        0pQSaHjHOLgSi8bB+VSynLPRpFhqOq/0yPZH4XP5hG4L6qtnj8SBele2sh7SDabyU+JgLm
        4ri/O3B/5Qs1FwtzJtKALdFX0fU8aDRB8JjzV+1GGtkFJlR/C9ZiGaw0/+xdXw==
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id E7DCF1C000A;
        Tue,  4 Jul 2023 15:08:58 +0000 (UTC)
Date:   Tue, 4 Jul 2023 17:08:58 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Johan Jonker <jbx6244@gmail.com>
Cc:     richard@nod.at, vigneshr@ti.com, heiko@sntech.de,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, yifeng.zhao@rock-chips.com
Subject: Re: [PATCH v3 2/3] mtd: rawnand: rockchip-nand-controller: copy
 hwecc PA data to oob_poi buffer
Message-ID: <20230704170858.2a64c181@xps-13>
In-Reply-To: <539cfba7-dd6f-015e-b990-a2335cb3aac9@gmail.com>
References: <0047fc52-bc45-a768-8bdd-c0f12cddc17e@gmail.com>
        <539cfba7-dd6f-015e-b990-a2335cb3aac9@gmail.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Johan,

jbx6244@gmail.com wrote on Thu, 15 Jun 2023 19:34:13 +0200:

> Rockchip boot blocks are written per 4 x 512 byte sectors per page.
> Each page must have a page address (PA) pointer in OOB to the next page.

Only when used as boot device I guess? It's a BootROM limitation.

> Pages are written in a pattern depending on the NAND chip ID.
> This logic used to build a page pattern table is not fully disclosed and
> is not easy to fit in the MTD framework.
> The formula in rk_nfc_write_page_hwecc() function is not correct.
> Make hwecc and raw behavior identical.

So this is a fix as well, deserves a tag. Whatever the reason why you
need this, the issue you are solving is: write_page_hwecc and
write_page_raw are not aligned.

> Generate boot block page address and pattern for hwecc in user space
> and copy PA data to/from the already reserved last 4 bytes before EEC

ECC

> in the chip->oob_poi data layout.
>=20
> This patch breaks all existing jffs2 users that have free OOB overlap
> with the reserved space for PA data.
>=20
> Signed-off-by: Johan Jonker <jbx6244@gmail.com>
> ---
>=20
> Changed V3:
>   Change prefixes
>   Reword
> ---
>  .../mtd/nand/raw/rockchip-nand-controller.c   | 34 ++++++++++++-------
>  1 file changed, 21 insertions(+), 13 deletions(-)
>=20
> diff --git a/drivers/mtd/nand/raw/rockchip-nand-controller.c b/drivers/mt=
d/nand/raw/rockchip-nand-controller.c
> index 37fc07ba5..5a0468034 100644
> --- a/drivers/mtd/nand/raw/rockchip-nand-controller.c
> +++ b/drivers/mtd/nand/raw/rockchip-nand-controller.c
> @@ -598,7 +598,7 @@ static int rk_nfc_write_page_hwecc(struct nand_chip *=
chip, const u8 *buf,
>  	int pages_per_blk =3D mtd->erasesize / mtd->writesize;
>  	int ret =3D 0, i, boot_rom_mode =3D 0;
>  	dma_addr_t dma_data, dma_oob;
> -	u32 reg;
> +	u32 tmp;
>  	u8 *oob;
>=20
>  	nand_prog_page_begin_op(chip, page, 0, NULL, 0);
> @@ -625,6 +625,13 @@ static int rk_nfc_write_page_hwecc(struct nand_chip =
*chip, const u8 *buf,
>  	 *
>  	 *   0xFF 0xFF 0xFF 0xFF | BBM OOB1 OOB2 OOB3 | ...
>  	 *
> +	 * The code here just swaps the first 4 bytes with the last
> +	 * 4 bytes without losing any data.
> +	 *
> +	 * The chip->oob_poi data layout:
> +	 *
> +	 *    BBM  OOB1 OOB2 OOB3 |......|  PA0  PA1  PA2  PA3
> +	 *
>  	 * Configure the ECC algorithm supported by the boot ROM.
>  	 */
>  	if ((page < (pages_per_blk * rknand->boot_blks)) &&
> @@ -635,21 +642,17 @@ static int rk_nfc_write_page_hwecc(struct nand_chip=
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

So we no longer need boot_rom_mode? Or do we?

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
> @@ -812,12 +815,17 @@ static int rk_nfc_read_page_hwecc(struct nand_chip =
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
