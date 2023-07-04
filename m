Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB5AF74719B
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 14:44:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231550AbjGDMoP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 08:44:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230252AbjGDMoE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 08:44:04 -0400
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D675CFB;
        Tue,  4 Jul 2023 05:44:01 -0700 (PDT)
X-GND-Sasl: miquel.raynal@bootlin.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1688474640;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TFBgJrEZeCMisn4K3cT/6LMLCAanesji/lg/I3Qi+FA=;
        b=k7GBXfbKfyaqTThD/nVJolgMh3BCjTImYhZSE6UjMl7IFxgJDB/FyxK8oceufK70lC/X8W
        BvQD6dBa/b6ifPQsiuv2MBDLQhSxXyThtQsdKs8sWUW0+ZybO4MMpip1M9hx9Lv+FJhT8e
        Ll0q/m7BBJUmDt2Fh4mzN8FBOMy2/9CKju0lhWy7rEDfDbbwXRNY7VfvFm4TbTjjt0aovC
        QYUy/YBMhaR2/X8fxPV4winun8Sw9V1HyKdTIujGkHJWGpAbqNjgX+pvL3GJiPUJHX5ydx
        45MIk0h3Dhri5vUMx04Z+BNYiJ82lEkVmFEOTS2ycxdL7xvAXQVlL3quKZ3izQ==
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
Received: by mail.gandi.net (Postfix) with ESMTPSA id D629624000C;
        Tue,  4 Jul 2023 12:43:58 +0000 (UTC)
Date:   Tue, 4 Jul 2023 14:43:57 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Arseniy Krasnov <AVKrasnov@sberdevices.ru>
Cc:     Liang Yang <liang.yang@amlogic.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        <oxffffaa@gmail.com>, <kernel@sberdevices.ru>,
        <linux-mtd@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-amlogic@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 2/2] mtd: rawnand: meson: waiting w/o wired
 ready/busy pin
Message-ID: <20230704144357.286281dc@xps-13>
In-Reply-To: <20230608044728.1328506-3-AVKrasnov@sberdevices.ru>
References: <20230608044728.1328506-1-AVKrasnov@sberdevices.ru>
        <20230608044728.1328506-3-AVKrasnov@sberdevices.ru>
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

Hi Arseniy,

AVKrasnov@sberdevices.ru wrote on Thu, 8 Jun 2023 07:47:28 +0300:

> If there is no wired ready/busy pin, classic way to wait for command
> completion is to use function 'nand_soft_waitrdy()'. Meson NAND has
> special command which allows to wait for NAND_STATUS_READY bit without
> reading status in a software loop (as 'nand_soft_waitrdy()' does). To
> use it send this command along with NAND_CMD_STATUS, then wait for an
> interrupt, and after interrupt send NAND_CMD_READ0. So this feature
> allows to use interrupt driven waiting without wired ready/busy pin.
>=20
> Suggested-by: Liang Yang <liang.yang@amlogic.com>
> Signed-off-by: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
> ---
>  drivers/mtd/nand/raw/meson_nand.c | 77 +++++++++++++++++++++++++++++--
>  1 file changed, 73 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/mtd/nand/raw/meson_nand.c b/drivers/mtd/nand/raw/mes=
on_nand.c
> index 074e14225c06..9f05e113b4ea 100644
> --- a/drivers/mtd/nand/raw/meson_nand.c
> +++ b/drivers/mtd/nand/raw/meson_nand.c
> @@ -38,6 +38,7 @@
>  #define NFC_CMD_SCRAMBLER_DISABLE	0
>  #define NFC_CMD_SHORTMODE_DISABLE	0
>  #define NFC_CMD_RB_INT		BIT(14)
> +#define NFC_CMD_RB_INT_NO_PIN	((0xb << 10) | BIT(18) | BIT(16))
> =20
>  #define NFC_CMD_GET_SIZE(x)	(((x) >> 22) & GENMASK(4, 0))
> =20
> @@ -179,6 +180,7 @@ struct meson_nfc {
>  	u32 info_bytes;
> =20
>  	unsigned long assigned_cs;
> +	bool no_rb_pin;
>  };
> =20
>  enum {
> @@ -392,7 +394,42 @@ static void meson_nfc_set_data_oob(struct nand_chip =
*nand,
>  	}
>  }
> =20
> -static int meson_nfc_queue_rb(struct meson_nfc *nfc, int timeout_ms)
> +static int meson_nfc_wait_no_rb_pin(struct meson_nfc *nfc, int timeout_m=
s,
> +				    bool need_cmd_read0)
> +{
> +	u32 cmd, cfg;
> +
> +	meson_nfc_cmd_idle(nfc, nfc->timing.twb);
> +	meson_nfc_drain_cmd(nfc);
> +	meson_nfc_wait_cmd_finish(nfc, CMD_FIFO_EMPTY_TIMEOUT);
> +
> +	cfg =3D readl(nfc->reg_base + NFC_REG_CFG);
> +	cfg |=3D NFC_RB_IRQ_EN;
> +	writel(cfg, nfc->reg_base + NFC_REG_CFG);
> +
> +	reinit_completion(&nfc->completion);
> +	cmd =3D nfc->param.chip_select | NFC_CMD_CLE | NAND_CMD_STATUS;
> +	writel(cmd, nfc->reg_base + NFC_REG_CMD);
> +
> +	/* use the max erase time as the maximum clock for waiting R/B */
> +	cmd =3D NFC_CMD_RB | NFC_CMD_RB_INT_NO_PIN | nfc->timing.tbers_max;
> +	writel(cmd, nfc->reg_base + NFC_REG_CMD);
> +
> +	if (!wait_for_completion_timeout(&nfc->completion,
> +					 msecs_to_jiffies(timeout_ms)))
> +		return -ETIMEDOUT;
> +
> +	if (need_cmd_read0) {
> +		cmd =3D nfc->param.chip_select | NFC_CMD_CLE | NAND_CMD_READ0;
> +		writel(cmd, nfc->reg_base + NFC_REG_CMD);
> +		meson_nfc_drain_cmd(nfc);
> +		meson_nfc_wait_cmd_finish(nfc, CMD_FIFO_EMPTY_TIMEOUT);
> +	}

I forgot about this, you should avoid open coding core helpers, can you
please send a followup patch to use nand_status_op() and
nand_exit_status_op() ?

> +
> +	return 0;
> +}
> +
> +static int meson_nfc_wait_rb_pin(struct meson_nfc *nfc, int timeout_ms)
>  {
>  	u32 cmd, cfg;
>  	int ret =3D 0;
> @@ -420,6 +457,27 @@ static int meson_nfc_queue_rb(struct meson_nfc *nfc,=
 int timeout_ms)
>  	return ret;
>  }
> =20
> +static int meson_nfc_queue_rb(struct meson_nfc *nfc, int timeout_ms,
> +			      bool need_cmd_read0)
> +{
> +	if (nfc->no_rb_pin) {
> +		/* This mode is used when there is no wired R/B pin.
> +		 * It works like 'nand_soft_waitrdy()', but instead of
> +		 * polling NAND_CMD_STATUS bit in the software loop,
> +		 * it will wait for interrupt - controllers checks IO
> +		 * bus and when it detects NAND_CMD_STATUS on it, it
> +		 * raises interrupt. After interrupt, NAND_CMD_READ0 is
> +		 * sent as terminator of the ready waiting procedure if
> +		 * needed (for all cases except page programming - this
> +		 * is reason of 'need_cmd_read0' flag).
> +		 */
> +		return meson_nfc_wait_no_rb_pin(nfc, timeout_ms,
> +						need_cmd_read0);
> +	} else {
> +		return meson_nfc_wait_rb_pin(nfc, timeout_ms);
> +	}
> +}
> +
>  static void meson_nfc_set_user_byte(struct nand_chip *nand, u8 *oob_buf)
>  {
>  	struct meson_nfc_nand_chip *meson_chip =3D to_meson_nand(nand);
> @@ -623,7 +681,7 @@ static int meson_nfc_rw_cmd_prepare_and_execute(struc=
t nand_chip *nand,
>  	if (in) {
>  		nfc->cmdfifo.rw.cmd1 =3D cs | NFC_CMD_CLE | NAND_CMD_READSTART;
>  		writel(nfc->cmdfifo.rw.cmd1, nfc->reg_base + NFC_REG_CMD);
> -		meson_nfc_queue_rb(nfc, PSEC_TO_MSEC(sdr->tR_max));
> +		meson_nfc_queue_rb(nfc, PSEC_TO_MSEC(sdr->tR_max), true);
>  	} else {
>  		meson_nfc_cmd_idle(nfc, nfc->timing.tadl);
>  	}
> @@ -669,7 +727,7 @@ static int meson_nfc_write_page_sub(struct nand_chip =
*nand,
> =20
>  	cmd =3D nfc->param.chip_select | NFC_CMD_CLE | NAND_CMD_PAGEPROG;
>  	writel(cmd, nfc->reg_base + NFC_REG_CMD);
> -	meson_nfc_queue_rb(nfc, PSEC_TO_MSEC(sdr->tPROG_max));
> +	meson_nfc_queue_rb(nfc, PSEC_TO_MSEC(sdr->tPROG_max), false);
> =20
>  	meson_nfc_dma_buffer_release(nand, data_len, info_len, DMA_TO_DEVICE);
> =20
> @@ -952,7 +1010,8 @@ static int meson_nfc_exec_op(struct nand_chip *nand,
>  			break;
> =20
>  		case NAND_OP_WAITRDY_INSTR:
> -			meson_nfc_queue_rb(nfc, instr->ctx.waitrdy.timeout_ms);
> +			meson_nfc_queue_rb(nfc, instr->ctx.waitrdy.timeout_ms,
> +					   true);
>  			if (instr->delay_ns)
>  				meson_nfc_cmd_idle(nfc, delay_idle);
>  			break;
> @@ -1248,6 +1307,7 @@ meson_nfc_nand_chip_init(struct device *dev,
>  	struct mtd_info *mtd;
>  	int ret, i;
>  	u32 tmp, nsels;
> +	u32 nand_rb_val =3D 0;
> =20
>  	nsels =3D of_property_count_elems_of_size(np, "reg", sizeof(u32));
>  	if (!nsels || nsels > MAX_CE_NUM) {
> @@ -1287,6 +1347,15 @@ meson_nfc_nand_chip_init(struct device *dev,
>  	mtd->owner =3D THIS_MODULE;
>  	mtd->dev.parent =3D dev;
> =20
> +	ret =3D of_property_read_u32(np, "nand-rb", &nand_rb_val);
> +	if (ret =3D=3D -EINVAL)
> +		nfc->no_rb_pin =3D true;
> +	else if (ret)
> +		return ret;
> +
> +	if (nand_rb_val)
> +		return -EINVAL;
> +
>  	ret =3D nand_scan(nand, nsels);
>  	if (ret)
>  		return ret;


Thanks,
Miqu=C3=A8l
