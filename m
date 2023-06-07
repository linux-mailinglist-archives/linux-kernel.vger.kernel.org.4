Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B12F7256BC
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 10:03:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238753AbjFGIDM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 04:03:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238750AbjFGIDF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 04:03:05 -0400
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::225])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E49810DE
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 01:03:01 -0700 (PDT)
X-GND-Sasl: miquel.raynal@bootlin.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1686124980;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TPtobzb++j+FXVO8cp/kj3PoJZPInkCcA1UC+qnSrzo=;
        b=nf+3Nj4bwgyX0tyG12f+zUP+DsYAF9pNp2Ne6ZLnFzKUOIUXynGzw7vGLwF5NGF7zMHOLS
        A5xkpOP2sAlv355HiQZCDg/1qsJBqvfiBOOnFOOBkDG3/j8opS6G6Rf2KZ0MqvuyvirZ/p
        4bxb+fTS/o3ats3RZ8iazMARWLLrrI/jYtDMKuSh2irHnU3PCVy9jkEF3why/KoeVuEYzB
        zhfqHP/JbvzU2LOInA00qjLymhbH04Pz7FTHiVhXcbPO+qY4b0vfSJkA5cRpsDr8Z46pVy
        rQWhqTAxvn+8+zdB2giYp+2SMzKSkAIeqfzZ/EvcA5DiuX7VroZs6sDiteTtpQ==
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
Received: by mail.gandi.net (Postfix) with ESMTPSA id CA4011C0010;
        Wed,  7 Jun 2023 08:02:58 +0000 (UTC)
Date:   Wed, 7 Jun 2023 10:02:57 +0200
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
Subject: Re: [PATCH v2] mtd: rawnand: meson: waiting w/o wired ready/busy
 pin
Message-ID: <20230607100257.627fc438@xps-13>
In-Reply-To: <20230607073015.1280085-1-AVKrasnov@sberdevices.ru>
References: <20230607073015.1280085-1-AVKrasnov@sberdevices.ru>
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

AVKrasnov@sberdevices.ru wrote on Wed, 7 Jun 2023 10:30:15 +0300:

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
>  Changelog:
>  v1 -> v2:
>   * Remove small delays from 'meson_nfc_wait_no_rb_pin()'. Both have no
>     effect according Liang's message.
>   * Type of 'no_rb_pin' is u32, the same as for 'nand-rb' property.
>   * 'meson_nfc_wait_no_rb_pin()' doesn't send NAND_CMD_READ0 in case of
>     page programming. Extra argument is added to 'meson_nfc_queue_rb()'
>     to check that case.
>=20
>  drivers/mtd/nand/raw/meson_nand.c | 74 +++++++++++++++++++++++++++++--
>  1 file changed, 70 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/mtd/nand/raw/meson_nand.c b/drivers/mtd/nand/raw/mes=
on_nand.c
> index 074e14225c06..ae404655b68c 100644
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
> +	u32 no_rb_pin;
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
> +
> +	return 0;
> +}
> +
> +static int meson_nfc_wait_rb_pin(struct meson_nfc *nfc, int timeout_ms)
>  {
>  	u32 cmd, cfg;
>  	int ret =3D 0;
> @@ -420,6 +457,25 @@ static int meson_nfc_queue_rb(struct meson_nfc *nfc,=
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
> +		 * sent as terminator of the ready waiting procedure.

Please also tell us in which case this is needed/not needed.

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
> @@ -623,7 +679,7 @@ static int meson_nfc_rw_cmd_prepare_and_execute(struc=
t nand_chip *nand,
>  	if (in) {
>  		nfc->cmdfifo.rw.cmd1 =3D cs | NFC_CMD_CLE | NAND_CMD_READSTART;
>  		writel(nfc->cmdfifo.rw.cmd1, nfc->reg_base + NFC_REG_CMD);
> -		meson_nfc_queue_rb(nfc, PSEC_TO_MSEC(sdr->tR_max));
> +		meson_nfc_queue_rb(nfc, PSEC_TO_MSEC(sdr->tR_max), true);
>  	} else {
>  		meson_nfc_cmd_idle(nfc, nfc->timing.tadl);
>  	}
> @@ -669,7 +725,7 @@ static int meson_nfc_write_page_sub(struct nand_chip =
*nand,
> =20
>  	cmd =3D nfc->param.chip_select | NFC_CMD_CLE | NAND_CMD_PAGEPROG;
>  	writel(cmd, nfc->reg_base + NFC_REG_CMD);
> -	meson_nfc_queue_rb(nfc, PSEC_TO_MSEC(sdr->tPROG_max));
> +	meson_nfc_queue_rb(nfc, PSEC_TO_MSEC(sdr->tPROG_max), false);
> =20
>  	meson_nfc_dma_buffer_release(nand, data_len, info_len, DMA_TO_DEVICE);
> =20
> @@ -952,7 +1008,8 @@ static int meson_nfc_exec_op(struct nand_chip *nand,
>  			break;
> =20
>  		case NAND_OP_WAITRDY_INSTR:
> -			meson_nfc_queue_rb(nfc, instr->ctx.waitrdy.timeout_ms);
> +			meson_nfc_queue_rb(nfc, instr->ctx.waitrdy.timeout_ms,
> +					   true);
>  			if (instr->delay_ns)
>  				meson_nfc_cmd_idle(nfc, delay_idle);
>  			break;
> @@ -1412,6 +1469,15 @@ static int meson_nfc_probe(struct platform_device =
*pdev)
>  		return ret;
>  	}
> =20
> +	ret =3D of_property_read_u32(dev->of_node, "nand-rb", &nfc->no_rb_pin);
> +	if (ret) {
> +		/* If property was not found, don't use rb pin. */
> +		if (ret =3D=3D -EINVAL)
> +			nfc->no_rb_pin =3D 1;

You mix two things:
- the presence of the RB pin
- the RB line
Just turn no_rb_pin into a boolean but d'ont use it to read the
property. Use another local u32 and just check the value is 0. If the
value is not 0, then return -EINVAL.

Also you should constrain the dt property in the binding to be either
absent or 0 but nothing else, with something like:
maxItems: 1
  minimum: 0
  maximum: 0

> +		else
> +			return ret;
> +	}
> +
>  	writel(0, nfc->reg_base + NFC_REG_CFG);
>  	ret =3D devm_request_irq(dev, irq, meson_nfc_irq, 0, dev_name(dev), nfc=
);
>  	if (ret) {


Thanks,
Miqu=C3=A8l
