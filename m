Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 710C875088C
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 14:43:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232571AbjGLMnW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 08:43:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232674AbjGLMnV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 08:43:21 -0400
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10C8C1712
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 05:43:18 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 1AD812000A;
        Wed, 12 Jul 2023 12:43:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1689165797;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bgCEtpw/2ywQe+5zhfpcOaErOdeD5eykmJdU7LyMHX8=;
        b=M7YjwCqNDmhN39RnojS1kcJ1YcoClgR1+4xtaPyiwmt5FV1S6chEBRZRPF8kk57+XmmNfi
        99sV097TfdxqJqBsw2oWB0MbLqbO/wSeVgqVay/RN+etoyk73B/rN7cXU+WF7PhRPo3ugm
        Kvu+u1ds2dUNB7Pw8bl9tFHkBRqCmCeL76x01In2374pZWdOCs6yTJ2pH24Gy1gif182+G
        t+EYZqbfv15kjRH8uC6XOOIvDdFXOXuyWtNDN3t9+/1IH5qL9jyOyOhbG8HMoIsKXbusyO
        t0TuG2ki35Dd3DASHEFaPzNxR0SfzXSBaoUE22XJtjXLzhVUHc/htdyTPB4fWg==
Date:   Wed, 12 Jul 2023 14:43:11 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Johan Jonker <jbx6244@gmail.com>
Cc:     richard@nod.at, vigneshr@ti.com, heiko@sntech.de,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, yifeng.zhao@rock-chips.com
Subject: Re: [PATCH v4 2/3] mtd: rawnand: rockchip: copy hwecc PA data to
 oob_poi buffer
Message-ID: <20230712144311.6e9a0b19@xps-13>
In-Reply-To: <04ed6472-13e4-d139-2ed0-ce2b1aa9e90c@gmail.com>
References: <08f694df-4c1d-f059-43fd-f1aee678062c@gmail.com>
        <04ed6472-13e4-d139-2ed0-ce2b1aa9e90c@gmail.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: miquel.raynal@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Johan,

jbx6244@gmail.com wrote on Mon, 10 Jul 2023 14:42:28 +0200:

> Rockchip boot blocks are written per 4 x 512 byte sectors per page.
> Each page with boot blocks must have a page address (PA) pointer in OOB
> to the next page. Pages are written in a pattern depending on the NAND ch=
ip ID.
> This logic used to build a page pattern table is not fully disclosed and
> is not easy to fit in the MTD framework.
> The formula in rk_nfc_write_page_hwecc() function is not correct.
> read/write_page_hwecc and read/write_page_raw are not aligned.
> Make hwecc and raw behavior identical.
> Generate boot block page address and pattern for hwecc in user space
> and copy PA data to/from the already reserved last 4 bytes before ECC
> in the chip->oob_poi data layout.
>=20
> This patch breaks all existing jffs2 users that have free OOB overlap
> with the reserved space for PA data.

I think I am fine with your patch, but the description is still way too
imprecise.

You need to separate two things: what is done wrong and perhaps why you
detected it or why you need it. Let me propose something:

"
mtd: rawnand: rockchip: Align hwecc vs. raw page helper layouts

Currently, read/write_page_hwecc() and read/write_page_raw() are not
aligned: there is a mismatch in the OOB bytes which are not
read/written at the same offset in both cases (raw vs. hwecc).

This is a real problem when relying on the presence of the Page
Addresses (PA) when using the NAND chip as a boot device, as the
BootROM expects additional data in the OOB area at specific locations.
<here you can put more context about this, like you do in your current
commit log>.

Align the different helpers. This change breaks existing jffs2 users.
"

>=20
> Fixes: 058e0e847d54 ("mtd: rawnand: rockchip: NFC driver for RK3308, RK29=
28 and others")
> Signed-off-by: Johan Jonker <jbx6244@gmail.com>
> ---
>=20
> Changed V4:
>   Reduce subject size
>   Add 'Fixes:' tag
>   Fix abbreviation
>   Reword
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
> index 37fc07ba57aa..5a04680342c3 100644
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
