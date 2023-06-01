Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 111E871950C
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 10:08:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231887AbjFAIIA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 04:08:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231513AbjFAIH6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 04:07:58 -0400
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BA9D9F
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jun 2023 01:07:56 -0700 (PDT)
X-GND-Sasl: miquel.raynal@bootlin.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1685606875;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ChLnjqmwWfzJ5+Tb3ibgVLi5VLJmMO5y6xFDB/IzaH4=;
        b=V51IguIPPOGfQX0ofhE6ioEnODqOTBnmH1XV7FWBrW0b2OnmC9XQvk9LaSFioXP+uuTNx1
        VBATLS6LAevGnXLd8srt7P0XqoAQldm4lUVdph6NeJpjGD0nhQipzsuN06mvr2/o/stCZu
        +riWyFwkNEvW47ZcKLCeEDbo/zA71PfhgwL6Iapy+MdzLIpNzP/mQ9CwazhmRdb5jRAdnT
        b3OrNLHWgthPjbLEisaJpMHhn/PrLPN1YXobX85UZLKlaLvIETpOG5SO5UIR5wjVlBfoQZ
        ZmJiD1owBwQ5ahNnJ0ggrKFmIznc/QW2UOqa3i82f45CWY7LYYXLqD5eu5Ix5w==
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
Received: by mail.gandi.net (Postfix) with ESMTPSA id 6DA30C0009;
        Thu,  1 Jun 2023 08:07:52 +0000 (UTC)
Date:   Thu, 1 Jun 2023 10:07:51 +0200
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
Subject: Re: [RFC PATCH v5 2/6] mtd: rawnand: meson: wait for command in
 polling mode
Message-ID: <20230601100751.41c3ff0b@xps-13>
In-Reply-To: <20230601061850.3907800-3-AVKrasnov@sberdevices.ru>
References: <20230601061850.3907800-1-AVKrasnov@sberdevices.ru>
        <20230601061850.3907800-3-AVKrasnov@sberdevices.ru>
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

AVKrasnov@sberdevices.ru wrote on Thu, 1 Jun 2023 09:18:45 +0300:

> This adds support of waiting for command completion in sofyware polling

							software

> mode. It is needed when ready/busy pin is not implemented in hardware.

Please also use (here and in all your commits) the affirmative tense:

"Add support for "

instead of

"This adds support"

or

"This commit adds"

Also, this is not a fix but a feature, so it should be introduced after
all the fixes. This way I can take all the fixes first without
dependency.

> Signed-off-by: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
> ---
>  drivers/mtd/nand/raw/meson_nand.c | 53 ++++++++++++++++++-------------
>  1 file changed, 31 insertions(+), 22 deletions(-)
>=20
> diff --git a/drivers/mtd/nand/raw/meson_nand.c b/drivers/mtd/nand/raw/mes=
on_nand.c
> index 9dd4a676497b..82a629025adc 100644
> --- a/drivers/mtd/nand/raw/meson_nand.c
> +++ b/drivers/mtd/nand/raw/meson_nand.c
> @@ -179,6 +179,7 @@ struct meson_nfc {
>  	u32 info_bytes;
> =20
>  	unsigned long assigned_cs;
> +	bool use_polling;

Very ambiguous wording. Polling is usually what you do to get the data.
Here you want a control signal so I would rename this flag with
something like "no_rb_pin".

Do you have a driver structure to represent the nand chip? Because
there is one RB per chip (even per die), not per controller.

>  };
> =20
>  enum {
> @@ -392,32 +393,38 @@ static void meson_nfc_set_data_oob(struct nand_chip=
 *nand,
>  	}
>  }
> =20
> -static int meson_nfc_queue_rb(struct meson_nfc *nfc, int timeout_ms)
> +static int meson_nfc_queue_rb(struct nand_chip *nand, int timeout_ms)

I would rather prefer keeping the controller pointer here. It's your
main structure here.

>  {
> -	u32 cmd, cfg;
> -	int ret =3D 0;
> +	struct meson_nfc *nfc =3D nand_get_controller_data(nand);
> =20
> -	meson_nfc_cmd_idle(nfc, nfc->timing.twb);
> -	meson_nfc_drain_cmd(nfc);
> -	meson_nfc_wait_cmd_finish(nfc, CMD_FIFO_EMPTY_TIMEOUT);
> +	if (nfc->use_polling) {
> +		return nand_soft_waitrdy(nand, timeout_ms);

You could simplify the diff by a lot by avoiding this extra tab
you added in the second part of the function, using:

	if (no_rb_pin)
		return nand_soft_waitrdy();

	...

> +	} else {
> +		u32 cmd, cfg;
> +		int ret =3D 0;
> =20
> -	cfg =3D readl(nfc->reg_base + NFC_REG_CFG);
> -	cfg |=3D NFC_RB_IRQ_EN;
> -	writel(cfg, nfc->reg_base + NFC_REG_CFG);
> +		meson_nfc_cmd_idle(nfc, nfc->timing.twb);
> +		meson_nfc_drain_cmd(nfc);
> +		meson_nfc_wait_cmd_finish(nfc, CMD_FIFO_EMPTY_TIMEOUT);
> =20
> -	reinit_completion(&nfc->completion);
> +		cfg =3D readl(nfc->reg_base + NFC_REG_CFG);
> +		cfg |=3D NFC_RB_IRQ_EN;
> +		writel(cfg, nfc->reg_base + NFC_REG_CFG);
> =20
> -	/* use the max erase time as the maximum clock for waiting R/B */
> -	cmd =3D NFC_CMD_RB | NFC_CMD_RB_INT
> -		| nfc->param.chip_select | nfc->timing.tbers_max;
> -	writel(cmd, nfc->reg_base + NFC_REG_CMD);
> +		reinit_completion(&nfc->completion);
> =20
> -	ret =3D wait_for_completion_timeout(&nfc->completion,
> -					  msecs_to_jiffies(timeout_ms));
> -	if (ret =3D=3D 0)
> -		ret =3D -1;
> +		/* use the max erase time as the maximum clock for waiting R/B */
> +		cmd =3D NFC_CMD_RB | NFC_CMD_RB_INT
> +			| nfc->param.chip_select | nfc->timing.tbers_max;
> +		writel(cmd, nfc->reg_base + NFC_REG_CMD);
> =20
> -	return ret;
> +		ret =3D wait_for_completion_timeout(&nfc->completion,
> +						  msecs_to_jiffies(timeout_ms));
> +		if (ret =3D=3D 0)
> +			return -ETIMEDOUT;
> +
> +		return 0;
> +	}
>  }
> =20
>  static void meson_nfc_set_user_byte(struct nand_chip *nand, u8 *oob_buf)
> @@ -623,7 +630,7 @@ static int meson_nfc_rw_cmd_prepare_and_execute(struc=
t nand_chip *nand,
>  	if (in) {
>  		nfc->cmdfifo.rw.cmd1 =3D cs | NFC_CMD_CLE | NAND_CMD_READSTART;
>  		writel(nfc->cmdfifo.rw.cmd1, nfc->reg_base + NFC_REG_CMD);
> -		meson_nfc_queue_rb(nfc, PSEC_TO_MSEC(sdr->tR_max));
> +		meson_nfc_queue_rb(nand, PSEC_TO_MSEC(sdr->tR_max));

Let's avoid that.

>  	} else {
>  		meson_nfc_cmd_idle(nfc, nfc->timing.tadl);
>  	}
> @@ -669,7 +676,7 @@ static int meson_nfc_write_page_sub(struct nand_chip =
*nand,
> =20
>  	cmd =3D nfc->param.chip_select | NFC_CMD_CLE | NAND_CMD_PAGEPROG;
>  	writel(cmd, nfc->reg_base + NFC_REG_CMD);
> -	meson_nfc_queue_rb(nfc, PSEC_TO_MSEC(sdr->tPROG_max));
> +	meson_nfc_queue_rb(nand, PSEC_TO_MSEC(sdr->tPROG_max));
> =20
>  	meson_nfc_dma_buffer_release(nand, data_len, info_len, DMA_TO_DEVICE);
> =20
> @@ -952,7 +959,7 @@ static int meson_nfc_exec_op(struct nand_chip *nand,
>  			break;
> =20
>  		case NAND_OP_WAITRDY_INSTR:
> -			meson_nfc_queue_rb(nfc, instr->ctx.waitrdy.timeout_ms);
> +			meson_nfc_queue_rb(nand, instr->ctx.waitrdy.timeout_ms);
>  			if (instr->delay_ns)
>  				meson_nfc_cmd_idle(nfc, delay_idle);
>  			break;
> @@ -1412,6 +1419,8 @@ static int meson_nfc_probe(struct platform_device *=
pdev)
>  		return ret;
>  	}
> =20
> +	nfc->use_polling =3D of_property_read_bool(dev->of_node, "polling");

This is a problem. You cannot add a polling property like that.

There is already a nand-rb property which is supposed to carry how are
wired the RB lines. I don't see any in-tree users of the compatibles, I
don't know how acceptable it is to consider using soft fallback when
this property is missing, otherwise take the values of the rb lines
provided in the DT and user hardware control, but I would definitely
prefer that.

In any case you'll need a dt-binding update which must be acked by
dt-binding maintainers.

> +
>  	writel(0, nfc->reg_base + NFC_REG_CFG);
>  	ret =3D devm_request_irq(dev, irq, meson_nfc_irq, 0, dev_name(dev), nfc=
);
>  	if (ret) {


Thanks,
Miqu=C3=A8l
