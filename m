Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D73936DECBA
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 09:40:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229611AbjDLHjx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 03:39:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbjDLHjc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 03:39:32 -0400
Received: from relay11.mail.gandi.net (relay11.mail.gandi.net [217.70.178.231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E26DD2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 00:39:30 -0700 (PDT)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id C7053100018;
        Wed, 12 Apr 2023 07:39:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1681285168;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=17BPQPrbGfoG/9Y+BnpABrCjBoUgqhojyRjXMZSD+8c=;
        b=PfRltgJ1Ic+5NX5hMrhg2PjLHxVBR8qIDRKeEQUmT9+oRHTMJXbAourYqKl0z5uG6K6TuD
        DcbxHoMVNnY3Jaol01OwcUCkcakHD+Glp6SQ22R2TPCE/9hINgQfScuE3msXJb6Oh7Xp4P
        owEbhQEurMr67d639FR00rh9BlpPievAzMuoB08vtA3/wG/Fzy4Cs3uW1hTpo0kSe5Jyw7
        s5zTNYiRtFxhVC9GlMqR0idX7pLB09VCPy9d06roQ5swBkAHoUb2jJARoVWH4n8elGKeFh
        WT7MW9yG9I2DFhK9bjqwgwms9dnr1Zx+Y1XIcGWbqYGXb+jR7fC+eIl9mO/n6g==
Date:   Wed, 12 Apr 2023 09:39:25 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Arseniy Krasnov <AVKrasnov@sberdevices.ru>
Cc:     Liang Yang <liang.yang@amlogic.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Yixun Lan <yixun.lan@amlogic.com>,
        Jianxin Pan <jianxin.pan@amlogic.com>, <oxffffaa@gmail.com>,
        <kernel@sberdevices.ru>, <linux-mtd@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-amlogic@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 3/5] mtd: rawnand: meson: check buffer length
Message-ID: <20230412093925.4718ac6f@xps-13>
In-Reply-To: <20230412061700.1492474-4-AVKrasnov@sberdevices.ru>
References: <20230412061700.1492474-1-AVKrasnov@sberdevices.ru>
 <20230412061700.1492474-4-AVKrasnov@sberdevices.ru>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arseniy,

AVKrasnov@sberdevices.ru wrote on Wed, 12 Apr 2023 09:16:57 +0300:

> With this chip, buffer length is limited by hardware, so check it before
> command execution to avoid length trim.

What is "this chip"? Are you talking about the controller itself? Is
there any specific SoC version targeted?

>=20
> Signed-off-by: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
> ---
>  drivers/mtd/nand/raw/meson_nand.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
>=20
> diff --git a/drivers/mtd/nand/raw/meson_nand.c b/drivers/mtd/nand/raw/mes=
on_nand.c
> index 45b53d420aed..f84a10238e4d 100644
> --- a/drivers/mtd/nand/raw/meson_nand.c
> +++ b/drivers/mtd/nand/raw/meson_nand.c
> @@ -543,6 +543,9 @@ static int meson_nfc_read_buf(struct nand_chip *nand,=
 u8 *buf, int len)
>  	u32 cmd;
>  	u8 *info;
> =20
> +	if (len > NFC_CMD_RAW_LEN)
> +		return -EINVAL;
> +
>  	info =3D kzalloc(PER_INFO_BYTE, GFP_KERNEL);
>  	if (!info)
>  		return -ENOMEM;
> @@ -571,6 +574,9 @@ static int meson_nfc_write_buf(struct nand_chip *nand=
, u8 *buf, int len)
>  	int ret =3D 0;
>  	u32 cmd;
> =20
> +	if (len > NFC_CMD_RAW_LEN)
> +		return -EINVAL;
> +
>  	ret =3D meson_nfc_dma_buffer_setup(nand, buf, len, NULL,
>  					 0, DMA_TO_DEVICE);
>  	if (ret)
> @@ -1269,6 +1275,7 @@ static int meson_nand_attach_chip(struct nand_chip =
*nand)
>  	struct meson_nfc_nand_chip *meson_chip =3D to_meson_nand(nand);
>  	struct mtd_info *mtd =3D nand_to_mtd(nand);
>  	int nsectors =3D mtd->writesize / 1024;
> +	int raw_writesize;
>  	int ret;
> =20
>  	if (!mtd->name) {
> @@ -1280,6 +1287,13 @@ static int meson_nand_attach_chip(struct nand_chip=
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
