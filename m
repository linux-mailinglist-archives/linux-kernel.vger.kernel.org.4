Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C73A70C2AA
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 17:43:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234525AbjEVPnv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 11:43:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231397AbjEVPnu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 11:43:50 -0400
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B287D2
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 08:43:46 -0700 (PDT)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 3DFB82000D;
        Mon, 22 May 2023 15:43:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1684770225;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ox+wsPpRCNR227lvEXncicX9pnHGCiMOaGeBN0930yg=;
        b=DStJfJA4msEKW9NT2t6xDdbkIi2McFz+PEwtOSRxKG3ARYJmLpo50FI6A0PnUpTjVHZw5W
        AtJ1SqAfOIlQkS/6/97yOIrlwBQZWdjA+3E6fOX1bgPWGj3TzEqoDFVlxjfkI/lALSd9+K
        eMItGikC6vqJjvxBeAR5p8hurFbMnanzHwnLHJ9DrNDvaiM4NV3nRZd9bja8S+Gt39DWyr
        jH5cz+YZ/BLoL+KbW2paNL6QJsgNTZSdMPcKqJaFMup0MzEEOPkGi94mIe4q/+nKQb0umb
        7PHi88VFIJnjFkCGNeUd7jFo2RcY3/+m9sHFa3HM7ETGvxCW1cycGT49YbChRg==
Date:   Mon, 22 May 2023 17:43:42 +0200
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
Subject: Re: [PATCH v4 4/5] mtd: rawnand: meson: check buffer length
Message-ID: <20230522174342.71bf6e88@xps-13>
In-Reply-To: <20230515094440.3552094-5-AVKrasnov@sberdevices.ru>
References: <20230515094440.3552094-1-AVKrasnov@sberdevices.ru>
        <20230515094440.3552094-5-AVKrasnov@sberdevices.ru>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arseniy,

AVKrasnov@sberdevices.ru wrote on Mon, 15 May 2023 12:44:38 +0300:

> This NAND controller has limited buffer length, so check it before
> command execution to avoid length trim. Also check MTD write size on
> chip attach.
>=20
> Signed-off-by: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
> ---
>  drivers/mtd/nand/raw/meson_nand.c | 22 +++++++++++++++++++---
>  1 file changed, 19 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/mtd/nand/raw/meson_nand.c b/drivers/mtd/nand/raw/mes=
on_nand.c
> index a31106c943d7..dc0d7160520b 100644
> --- a/drivers/mtd/nand/raw/meson_nand.c
> +++ b/drivers/mtd/nand/raw/meson_nand.c
> @@ -111,6 +111,8 @@
>  #define NFC_USER_BYTES		2
>  #define NFC_OOB_PER_ECC(nand)	((nand)->ecc.bytes + NFC_USER_BYTES)
> =20
> +#define NFC_CMD_RAW_LEN		GENMASK(13, 0)
> +
>  struct meson_nfc_nand_chip {
>  	struct list_head node;
>  	struct nand_chip nand;
> @@ -284,7 +286,7 @@ static void meson_nfc_cmd_access(struct nand_chip *na=
nd, int raw, bool dir,
> =20
>  	if (raw) {
>  		len =3D mtd->writesize + mtd->oobsize;
> -		cmd =3D (len & GENMASK(13, 0)) | scrambler | DMA_DIR(dir);
> +		cmd =3D len | scrambler | DMA_DIR(dir);
>  		writel(cmd, nfc->reg_base + NFC_REG_CMD);
>  		return;
>  	}
> @@ -562,6 +564,9 @@ static int meson_nfc_read_buf(struct nand_chip *nand,=
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
> @@ -571,7 +576,7 @@ static int meson_nfc_read_buf(struct nand_chip *nand,=
 u8 *buf, int len)
>  	if (ret)
>  		goto out;
> =20
> -	cmd =3D NFC_CMD_N2M | (len & GENMASK(13, 0));
> +	cmd =3D NFC_CMD_N2M | len;
>  	writel(cmd, nfc->reg_base + NFC_REG_CMD);
> =20
>  	meson_nfc_drain_cmd(nfc);
> @@ -590,12 +595,15 @@ static int meson_nfc_write_buf(struct nand_chip *na=
nd, u8 *buf, int len)
>  	int ret =3D 0;
>  	u32 cmd;
> =20
> +	if (len > NFC_CMD_RAW_LEN)
> +		return -EINVAL;

I think this helper is related to exec_op, if yes, you should probably
ask an early check in the exec_op implementation (perhaps as part of a
dedicated helper).

Same above.

Otherwise looks good.

> +
>  	ret =3D meson_nfc_dma_buffer_setup(nand, buf, len, NULL,
>  					 0, DMA_TO_DEVICE);
>  	if (ret)
>  		return ret;
> =20
> -	cmd =3D NFC_CMD_M2N | (len & GENMASK(13, 0));
> +	cmd =3D NFC_CMD_M2N | len;
>  	writel(cmd, nfc->reg_base + NFC_REG_CMD);
> =20
>  	meson_nfc_drain_cmd(nfc);
> @@ -1328,6 +1336,7 @@ static int meson_nand_attach_chip(struct nand_chip =
*nand)
>  	struct meson_nfc_nand_chip *meson_chip =3D to_meson_nand(nand);
>  	struct mtd_info *mtd =3D nand_to_mtd(nand);
>  	int nsectors =3D mtd->writesize / 1024;
> +	int raw_writesize;
>  	int ret;
> =20
>  	if (!mtd->name) {
> @@ -1339,6 +1348,13 @@ static int meson_nand_attach_chip(struct nand_chip=
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
