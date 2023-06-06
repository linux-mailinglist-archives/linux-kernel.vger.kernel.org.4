Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DF747238A7
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 09:16:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231847AbjFFHQh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 03:16:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231139AbjFFHQO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 03:16:14 -0400
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::221])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0256FE6E
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 00:16:12 -0700 (PDT)
X-GND-Sasl: miquel.raynal@bootlin.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1686035771;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LJMd3X39gfloId/A1Wagf/3OEcwUvYfW467X78c7WYQ=;
        b=hlyB8kt5puxkU+DY/1dlQPALXQ2RVeYLgWpRd709I11yU6OwumbyQ1SoMJVnZGPx/LNWX5
        Tchhw7DIg+iEU3VPi1OWBmEO2zkPjPQvPV9vePMLzKx4PQGMFXdJoNIJ2bSQ/FIm8Yorq1
        +Gw4Kr0OcaWDHiSnauJOqpYp+SUu1SAMQmSgpOSKSyRhyzwxwBJJudM2r8F24MD+rwQ2OH
        vV4twKa6ShxXzDLN4bPenrqBkkSyGvLt3ZwA/lE6kJp6EXxkDo28iIP5YxzjSoN+U26Tx5
        nNBUPINAvHSaFT3vS7Cc1iDZRZqp+xeWiaTBHSwDnwGgPI/TuCbi5WUyPxXmew==
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
Received: by mail.gandi.net (Postfix) with ESMTPSA id 311C4240004;
        Tue,  6 Jun 2023 07:16:09 +0000 (UTC)
Date:   Tue, 6 Jun 2023 09:16:07 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Arseniy Krasnov <AVKrasnov@sberdevices.ru>
Cc:     Liang Yang <liang.yang@amlogic.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        <oxffffaa@gmail.com>, <kernel@sberdevices.ru>,
        <linux-mtd@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-amlogic@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1] mtd: rawnand: meson: check buffer length
Message-ID: <20230606091607.7b7b6814@xps-13>
In-Reply-To: <20230605191047.1820016-1-AVKrasnov@sberdevices.ru>
References: <20230605191047.1820016-1-AVKrasnov@sberdevices.ru>
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

Hi Arseniy,

AVKrasnov@sberdevices.ru wrote on Mon, 5 Jun 2023 22:10:46 +0300:

> Meson NAND controller has limited buffer length, so check it before
> command execution to avoid length trim. Also check MTD write size on
> chip attach.

Almost there :)

>=20
> Signed-off-by: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
> ---
>  drivers/mtd/nand/raw/meson_nand.c | 22 +++++++++++++++++++---
>  1 file changed, 19 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/mtd/nand/raw/meson_nand.c b/drivers/mtd/nand/raw/mes=
on_nand.c
> index 074e14225c06..bfb5363cac23 100644
> --- a/drivers/mtd/nand/raw/meson_nand.c
> +++ b/drivers/mtd/nand/raw/meson_nand.c
> @@ -108,6 +108,8 @@
> =20
>  #define PER_INFO_BYTE		8
> =20
> +#define NFC_CMD_RAW_LEN	GENMASK(13, 0)
> +
>  struct meson_nfc_nand_chip {
>  	struct list_head node;
>  	struct nand_chip nand;
> @@ -280,7 +282,7 @@ static void meson_nfc_cmd_access(struct nand_chip *na=
nd, int raw, bool dir,
> =20
>  	if (raw) {
>  		len =3D mtd->writesize + mtd->oobsize;
> -		cmd =3D (len & GENMASK(13, 0)) | scrambler | DMA_DIR(dir);
> +		cmd =3D len | scrambler | DMA_DIR(dir);
>  		writel(cmd, nfc->reg_base + NFC_REG_CMD);
>  		return;
>  	}
> @@ -544,7 +546,7 @@ static int meson_nfc_read_buf(struct nand_chip *nand,=
 u8 *buf, int len)
>  	if (ret)
>  		goto out;
> =20
> -	cmd =3D NFC_CMD_N2M | (len & GENMASK(13, 0));
> +	cmd =3D NFC_CMD_N2M | len;
>  	writel(cmd, nfc->reg_base + NFC_REG_CMD);
> =20
>  	meson_nfc_drain_cmd(nfc);
> @@ -568,7 +570,7 @@ static int meson_nfc_write_buf(struct nand_chip *nand=
, u8 *buf, int len)
>  	if (ret)
>  		return ret;
> =20
> -	cmd =3D NFC_CMD_M2N | (len & GENMASK(13, 0));
> +	cmd =3D NFC_CMD_M2N | len;
>  	writel(cmd, nfc->reg_base + NFC_REG_CMD);
> =20
>  	meson_nfc_drain_cmd(nfc);
> @@ -936,6 +938,9 @@ static int meson_nfc_exec_op(struct nand_chip *nand,
>  			break;
> =20
>  		case NAND_OP_DATA_IN_INSTR:
> +			if (instr->ctx.data.len > NFC_CMD_RAW_LEN)
> +				return -EINVAL;

You need to refuse the operation earlier. That's what the check_op
boolean is about. Maybe you can take inspiration from anfc_check_op()
in the arasan controller.

> +
>  			buf =3D meson_nand_op_get_dma_safe_input_buf(instr);
>  			if (!buf)
>  				return -ENOMEM;
> @@ -944,6 +949,9 @@ static int meson_nfc_exec_op(struct nand_chip *nand,
>  			break;
> =20
>  		case NAND_OP_DATA_OUT_INSTR:
> +			if (instr->ctx.data.len > NFC_CMD_RAW_LEN)
> +				return -EINVAL;

Same.

> +
>  			buf =3D meson_nand_op_get_dma_safe_output_buf(instr);
>  			if (!buf)
>  				return -ENOMEM;
> @@ -1181,6 +1189,7 @@ static int meson_nand_attach_chip(struct nand_chip =
*nand)
>  	struct meson_nfc_nand_chip *meson_chip =3D to_meson_nand(nand);
>  	struct mtd_info *mtd =3D nand_to_mtd(nand);
>  	int nsectors =3D mtd->writesize / 1024;
> +	int raw_writesize;
>  	int ret;
> =20
>  	if (!mtd->name) {
> @@ -1192,6 +1201,13 @@ static int meson_nand_attach_chip(struct nand_chip=
 *nand)
>  			return -ENOMEM;
>  	}
> =20
> +	raw_writesize =3D mtd->writesize + mtd->oobsize;
> +	if (raw_writesize > NFC_CMD_RAW_LEN) {
> +		dev_err(nfc->dev, "too big write size in raw mode: %d > %ld\n",
> +			raw_writesize, NFC_CMD_RAW_LEN);
> +		return -EINVAL;
> +	}
> +
>  	if (nand->bbt_options & NAND_BBT_USE_FLASH)
>  		nand->bbt_options |=3D NAND_BBT_NO_OOB;
> =20


Thanks,
Miqu=C3=A8l
