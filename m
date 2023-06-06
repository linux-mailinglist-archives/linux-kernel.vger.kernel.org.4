Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBD90723AA9
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 09:54:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235111AbjFFHyZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 03:54:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235255AbjFFHx6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 03:53:58 -0400
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41D1D106
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 00:50:28 -0700 (PDT)
X-GND-Sasl: miquel.raynal@bootlin.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1686037827;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2KqMPztr7hiHXP+1Ynp2WQJHqpjlFJterm7Ue0Xb7a8=;
        b=efYk/mp/GqY2gaRAM1u4E0/RnjrIyAEdu5r9KXTgGSS0a0rXNYb5NlcR40VTUAcAmmrl/A
        ZMep28lJje1jervWCmxNuG/l8taN7DRFLDxix/hnfmxOjYo7SRS8+9mGXVD8D1jM94ln4r
        GXdVHXlpQbmfwITCcqhtCU+Hgw/8SxyK1AOeBBulXhB4Fi9Wxc9S+TwrxJ3YyyQQMwm5Cf
        doRidcuGQic8YBihUi3NKHDQ3oXCNdDaoWIEHaQ/pFIO76eO0i6HwA53t3dIuMKuCVwTef
        F2wiU9KLNKV5x6E3BOj4iknEskYATxSRbYIVq06s/L3z44RAZEiZjY8XuykZyg==
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
Received: by mail.gandi.net (Postfix) with ESMTPSA id C751360003;
        Tue,  6 Jun 2023 07:50:24 +0000 (UTC)
Date:   Tue, 6 Jun 2023 09:50:23 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Arseniy Krasnov <avkrasnov@sberdevices.ru>
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
Message-ID: <20230606095023.26a056a3@xps-13>
In-Reply-To: <e31be327-b351-3a94-b2d8-0867f29bb9ec@sberdevices.ru>
References: <20230605191047.1820016-1-AVKrasnov@sberdevices.ru>
        <20230606091607.7b7b6814@xps-13>
        <e31be327-b351-3a94-b2d8-0867f29bb9ec@sberdevices.ru>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arseniy,

avkrasnov@sberdevices.ru wrote on Tue, 6 Jun 2023 10:37:43 +0300:

> On 06.06.2023 10:16, Miquel Raynal wrote:
> > Hi Arseniy,
> >=20
> > AVKrasnov@sberdevices.ru wrote on Mon, 5 Jun 2023 22:10:46 +0300:
> >  =20
> >> Meson NAND controller has limited buffer length, so check it before
> >> command execution to avoid length trim. Also check MTD write size on
> >> chip attach. =20
> >=20
> > Almost there :) =20
>=20
> Hello Miquel!
>=20
> You mean to rephrase it? :)

Not at all, I meant: there is something to change in this file (see
below) but the patch is close to be ready.

>=20
> Thanks, Arseniy
>=20
> >  =20
> >>
> >> Signed-off-by: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
> >> ---
> >>  drivers/mtd/nand/raw/meson_nand.c | 22 +++++++++++++++++++---
> >>  1 file changed, 19 insertions(+), 3 deletions(-)
> >>
> >> diff --git a/drivers/mtd/nand/raw/meson_nand.c b/drivers/mtd/nand/raw/=
meson_nand.c
> >> index 074e14225c06..bfb5363cac23 100644
> >> --- a/drivers/mtd/nand/raw/meson_nand.c
> >> +++ b/drivers/mtd/nand/raw/meson_nand.c
> >> @@ -108,6 +108,8 @@
> >> =20
> >>  #define PER_INFO_BYTE		8
> >> =20
> >> +#define NFC_CMD_RAW_LEN	GENMASK(13, 0)
> >> +
> >>  struct meson_nfc_nand_chip {
> >>  	struct list_head node;
> >>  	struct nand_chip nand;
> >> @@ -280,7 +282,7 @@ static void meson_nfc_cmd_access(struct nand_chip =
*nand, int raw, bool dir,
> >> =20
> >>  	if (raw) {
> >>  		len =3D mtd->writesize + mtd->oobsize;
> >> -		cmd =3D (len & GENMASK(13, 0)) | scrambler | DMA_DIR(dir);
> >> +		cmd =3D len | scrambler | DMA_DIR(dir);
> >>  		writel(cmd, nfc->reg_base + NFC_REG_CMD);
> >>  		return;
> >>  	}
> >> @@ -544,7 +546,7 @@ static int meson_nfc_read_buf(struct nand_chip *na=
nd, u8 *buf, int len)
> >>  	if (ret)
> >>  		goto out;
> >> =20
> >> -	cmd =3D NFC_CMD_N2M | (len & GENMASK(13, 0));
> >> +	cmd =3D NFC_CMD_N2M | len;
> >>  	writel(cmd, nfc->reg_base + NFC_REG_CMD);
> >> =20
> >>  	meson_nfc_drain_cmd(nfc);
> >> @@ -568,7 +570,7 @@ static int meson_nfc_write_buf(struct nand_chip *n=
and, u8 *buf, int len)
> >>  	if (ret)
> >>  		return ret;
> >> =20
> >> -	cmd =3D NFC_CMD_M2N | (len & GENMASK(13, 0));
> >> +	cmd =3D NFC_CMD_M2N | len;
> >>  	writel(cmd, nfc->reg_base + NFC_REG_CMD);
> >> =20
> >>  	meson_nfc_drain_cmd(nfc);
> >> @@ -936,6 +938,9 @@ static int meson_nfc_exec_op(struct nand_chip *nan=
d,
> >>  			break;
> >> =20
> >>  		case NAND_OP_DATA_IN_INSTR:
> >> +			if (instr->ctx.data.len > NFC_CMD_RAW_LEN)
> >> +				return -EINVAL; =20
> >=20
> > You need to refuse the operation earlier. That's what the check_op
> > boolean is about. Maybe you can take inspiration from anfc_check_op()
> > in the arasan controller. =20
>=20
> Ok! Thanks!
>=20
> >  =20
> >> +
> >>  			buf =3D meson_nand_op_get_dma_safe_input_buf(instr);
> >>  			if (!buf)
> >>  				return -ENOMEM;
> >> @@ -944,6 +949,9 @@ static int meson_nfc_exec_op(struct nand_chip *nan=
d,
> >>  			break;
> >> =20
> >>  		case NAND_OP_DATA_OUT_INSTR:
> >> +			if (instr->ctx.data.len > NFC_CMD_RAW_LEN)
> >> +				return -EINVAL; =20
> >=20
> > Same.
> >  =20
> >> +
> >>  			buf =3D meson_nand_op_get_dma_safe_output_buf(instr);
> >>  			if (!buf)
> >>  				return -ENOMEM;
> >> @@ -1181,6 +1189,7 @@ static int meson_nand_attach_chip(struct nand_ch=
ip *nand)
> >>  	struct meson_nfc_nand_chip *meson_chip =3D to_meson_nand(nand);
> >>  	struct mtd_info *mtd =3D nand_to_mtd(nand);
> >>  	int nsectors =3D mtd->writesize / 1024;
> >> +	int raw_writesize;
> >>  	int ret;
> >> =20
> >>  	if (!mtd->name) {
> >> @@ -1192,6 +1201,13 @@ static int meson_nand_attach_chip(struct nand_c=
hip *nand)
> >>  			return -ENOMEM;
> >>  	}
> >> =20
> >> +	raw_writesize =3D mtd->writesize + mtd->oobsize;
> >> +	if (raw_writesize > NFC_CMD_RAW_LEN) {
> >> +		dev_err(nfc->dev, "too big write size in raw mode: %d > %ld\n",
> >> +			raw_writesize, NFC_CMD_RAW_LEN);
> >> +		return -EINVAL;
> >> +	}
> >> +
> >>  	if (nand->bbt_options & NAND_BBT_USE_FLASH)
> >>  		nand->bbt_options |=3D NAND_BBT_NO_OOB;
> >>   =20
> >=20
> >=20
> > Thanks,
> > Miqu=C3=A8l =20


Thanks,
Miqu=C3=A8l
