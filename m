Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FD0E727711
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 08:10:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234581AbjFHGKt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 02:10:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234156AbjFHGKq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 02:10:46 -0400
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::225])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4355A26AA
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 23:10:44 -0700 (PDT)
X-GND-Sasl: miquel.raynal@bootlin.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1686204642;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=L997pm3OZhsNoBTfFX2W/lctWbOsQWynn+RPco5OgpU=;
        b=MGa3vCMTokL6CKkH9wvmJbz/uqjVPW+/NE9H5ZTV6JyvdoH1/KXwWnGdMGOFxoid3HIsN1
        dSd3H2nMXLjvBy58xkjO7mhm45DBk1I2k2/AcUPbVr/kmGuCIjqN4Q3hwUar0k6h3DE5F/
        O5LcFMphiqp8AR7fAC/CXbTAZRiuirmVtLLDU30slKulDO732zi/vHyuvYr+vEtbwqesEz
        VAIJnv7zPP3cTDvJe8S1G0VgsHnO8BFMQa55JX2ObQkpzTVpF1VgHq23y46h+hu1nJs6Rg
        niJZUOw/HQ8A2+C4kNDeW8iWUkA36ParRGKITkIbLdkVVXaxjdjMMqoBiSyOiQ==
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
Received: by mail.gandi.net (Postfix) with ESMTPSA id 526B01C000F;
        Thu,  8 Jun 2023 06:10:41 +0000 (UTC)
Date:   Thu, 8 Jun 2023 08:10:40 +0200
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
Subject: Re: [PATCH v2] mtd: rawnand: meson: check buffer length
Message-ID: <20230608081040.78e74eb1@xps-13>
In-Reply-To: <3a9470ed-d7ad-6cae-0d58-732399590272@sberdevices.ru>
References: <20230606101644.3297859-1-AVKrasnov@sberdevices.ru>
        <9adef6da-5930-dcaa-f148-e4a398d39f2d@sberdevices.ru>
        <3a9470ed-d7ad-6cae-0d58-732399590272@sberdevices.ru>
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

Hi Arseniy,

avkrasnov@sberdevices.ru wrote on Thu, 8 Jun 2023 00:17:35 +0300:

> Hi again Miquel, Liang!
>=20
> What do You think about this patch?

I really appreciate all the effort you are putting into this but
please consider giving me a little bit of air as well, I'm already
spending a lot of time reviewing all your patches. Please mind a ping
is not relevant before a couple of weeks in general.

In this case I had it in my "to apply" list but actually looking at it
again I have a minor comment below.

>=20
> Thanks, Arseniy
>=20
> On 06.06.2023 19:29, Arseniy Krasnov wrote:
> > Sorry, here is changelog:
> > v1 -> v2:
> > * Move checks from 'switch/case' which executes commands in 'meson_nfc_=
exec_op()' to a special
> >   separated function 'meson_nfc_check_op()' which is called before comm=
ands processing.
> >=20
> > On 06.06.2023 13:16, Arseniy Krasnov wrote: =20
> >> Meson NAND controller has limited buffer length, so check it before
> >> command execution to avoid length trim. Also check MTD write size on
> >> chip attach.
> >>
> >> Signed-off-by: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
> >> ---
> >>  drivers/mtd/nand/raw/meson_nand.c | 47 +++++++++++++++++++++++++++----
> >>  1 file changed, 42 insertions(+), 5 deletions(-)
> >>
> >> diff --git a/drivers/mtd/nand/raw/meson_nand.c b/drivers/mtd/nand/raw/=
meson_nand.c
> >> index 23a73268421b..db6b18753071 100644
> >> --- a/drivers/mtd/nand/raw/meson_nand.c
> >> +++ b/drivers/mtd/nand/raw/meson_nand.c
> >> @@ -111,6 +111,8 @@
> >> =20
> >>  #define PER_INFO_BYTE		8
> >> =20
> >> +#define NFC_CMD_RAW_LEN	GENMASK(13, 0)
> >> +
> >>  struct meson_nfc_nand_chip {
> >>  	struct list_head node;
> >>  	struct nand_chip nand;
> >> @@ -284,7 +286,7 @@ static void meson_nfc_cmd_access(struct nand_chip =
*nand, int raw, bool dir,
> >> =20
> >>  	if (raw) {
> >>  		len =3D mtd->writesize + mtd->oobsize;
> >> -		cmd =3D (len & GENMASK(13, 0)) | scrambler | DMA_DIR(dir);
> >> +		cmd =3D len | scrambler | DMA_DIR(dir);
> >>  		writel(cmd, nfc->reg_base + NFC_REG_CMD);
> >>  		return;
> >>  	}
> >> @@ -573,7 +575,7 @@ static int meson_nfc_read_buf(struct nand_chip *na=
nd, u8 *buf, int len)
> >>  	if (ret)
> >>  		goto out;
> >> =20
> >> -	cmd =3D NFC_CMD_N2M | (len & GENMASK(13, 0));
> >> +	cmd =3D NFC_CMD_N2M | len;
> >>  	writel(cmd, nfc->reg_base + NFC_REG_CMD);
> >> =20
> >>  	meson_nfc_drain_cmd(nfc);
> >> @@ -597,7 +599,7 @@ static int meson_nfc_write_buf(struct nand_chip *n=
and, u8 *buf, int len)
> >>  	if (ret)
> >>  		return ret;
> >> =20
> >> -	cmd =3D NFC_CMD_M2N | (len & GENMASK(13, 0));
> >> +	cmd =3D NFC_CMD_M2N | len;
> >>  	writel(cmd, nfc->reg_base + NFC_REG_CMD);
> >> =20
> >>  	meson_nfc_drain_cmd(nfc);
> >> @@ -1007,6 +1009,31 @@ meson_nand_op_put_dma_safe_output_buf(const str=
uct nand_op_instr *instr,
> >>  		kfree(buf);
> >>  }
> >> =20
> >> +static int meson_nfc_check_op(struct nand_chip *chip,
> >> +			      const struct nand_operation *op)
> >> +{
> >> +	int op_id;
> >> +
> >> +	for (op_id =3D 0; op_id < op->ninstrs; op_id++) {
> >> +		const struct nand_op_instr *instr;
> >> +
> >> +		instr =3D &op->instrs[op_id];
> >> +
> >> +		switch (instr->type) {
> >> +		case NAND_OP_DATA_IN_INSTR:
> >> +		case NAND_OP_DATA_OUT_INSTR:
> >> +			if (instr->ctx.data.len > NFC_CMD_RAW_LEN)
> >> +				return -ENOTSUPP;
> >> +
> >> +			break;
> >> +		default:
> >> +			break;
> >> +		}
> >> +	}
> >> +
> >> +	return 0;
> >> +}
> >> +
> >>  static int meson_nfc_exec_op(struct nand_chip *nand,
> >>  			     const struct nand_operation *op, bool check_only)
> >>  {
> >> @@ -1015,10 +1042,12 @@ static int meson_nfc_exec_op(struct nand_chip =
*nand,
> >>  	const struct nand_op_instr *instr =3D NULL;
> >>  	void *buf;
> >>  	u32 op_id, delay_idle, cmd;
> >> +	int err;
> >>  	int i;
> >> =20
> >> -	if (check_only)
> >> -		return 0;
> >> +	err =3D meson_nfc_check_op(nand, op);
> >> +	if (err || check_only)
> >> +		return err;

For the sake of readability it is really important that we keep using
standard constructions, so don't mix orthogonal checks and please use
something like:

	err =3D check();
	if (err)
		return err;

	if (check_only)
		return 0;

> >> =20
> >>  	meson_nfc_select_chip(nand, op->cs);
> >>  	for (op_id =3D 0; op_id < op->ninstrs; op_id++) {
> >> @@ -1293,6 +1322,7 @@ static int meson_nand_attach_chip(struct nand_ch=
ip *nand)
> >>  	struct meson_nfc_nand_chip *meson_chip =3D to_meson_nand(nand);
> >>  	struct mtd_info *mtd =3D nand_to_mtd(nand);
> >>  	int nsectors =3D mtd->writesize / 1024;
> >> +	int raw_writesize;
> >>  	int ret;
> >> =20
> >>  	if (!mtd->name) {
> >> @@ -1304,6 +1334,13 @@ static int meson_nand_attach_chip(struct nand_c=
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


Thanks,
Miqu=C3=A8l
