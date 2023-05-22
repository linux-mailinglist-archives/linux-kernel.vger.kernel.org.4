Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADF5170C1EE
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 17:06:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234513AbjEVPGD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 11:06:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234510AbjEVPFs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 11:05:48 -0400
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::226])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0D8610F6
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 08:05:30 -0700 (PDT)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 0E419C000B;
        Mon, 22 May 2023 15:05:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1684767928;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kfGqNpqYGcaYDPFm+L0EvwvvX+xtHwS882MQS2NRtaE=;
        b=P8QdRGGHqZgASUf2kWEbUXEWYZEZrfhHtlq56cohDeT4cvM5/wcqr0XTxEahrzv0fJq8AK
        ISrfFGc80sWA74k9RLAvfNSm3+7QVA1vcHA099qpLV/eTdLMKcK7l6TKiDlDs9Fz2Sd8Rh
        iRcg64BxeKzaqyVNGYRyNjnv4fYf//LweLEFqnxQl0Bl+DzvtEueDiFuZguknwf9lH9ceQ
        33RKB9ok9NcpdcfJtgUUMeAHk7vpyUK2g//kzt+vRHL0nFcFItzAqfIJqKlUvNeJhK+eTs
        AG3sJ8Zp7fk3bk+DuUHkBRp41wcekq5hH9a1FM4LAZpfg3XvT+JfGVZoi74gUg==
Date:   Mon, 22 May 2023 17:05:26 +0200
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
Subject: Re: [PATCH v4 1/5] mtd: rawnand: meson: fix command sequence for
 read/write
Message-ID: <20230522170526.6486755a@xps-13>
In-Reply-To: <20230515094440.3552094-2-AVKrasnov@sberdevices.ru>
References: <20230515094440.3552094-1-AVKrasnov@sberdevices.ru>
        <20230515094440.3552094-2-AVKrasnov@sberdevices.ru>
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

AVKrasnov@sberdevices.ru wrote on Mon, 15 May 2023 12:44:35 +0300:

> This fixes read/write functionality by:
> 1) Changing NFC_CMD_RB_INT bit value.

I guess this is a separate fix

> 2) Adding extra NAND_CMD_STATUS command on each r/w request.

Is this really needed? Looks like you're delaying the next op only. Is
using a delay enough? If yes, then it's probably the wrong approach.

> 3) Adding extra idle commands during r/w request.

Question about this below, might also be a patch on its own?

> 4) Adding extra NAND_CMD_READ0 on each read request.
>=20
> Without this patch driver works unstable, for example there are a lot
> of ECC errors.

I believe all the fixes should be Cc'ed to stable, please add in your
commits:

Cc: stable@...

>=20
> Fixes: 8fae856c5350 ("mtd: rawnand: meson: add support for Amlogic NAND f=
lash controller")
> Suggested-by: Liang Yang <liang.yang@amlogic.com>
> Signed-off-by: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
> ---
>  drivers/mtd/nand/raw/meson_nand.c | 30 +++++++++++++++++++++---------
>  1 file changed, 21 insertions(+), 9 deletions(-)
>=20
> diff --git a/drivers/mtd/nand/raw/meson_nand.c b/drivers/mtd/nand/raw/mes=
on_nand.c
> index 074e14225c06..2f4d8c84186b 100644
> --- a/drivers/mtd/nand/raw/meson_nand.c
> +++ b/drivers/mtd/nand/raw/meson_nand.c
> @@ -37,7 +37,7 @@
>  #define NFC_CMD_SCRAMBLER_ENABLE	BIT(19)
>  #define NFC_CMD_SCRAMBLER_DISABLE	0
>  #define NFC_CMD_SHORTMODE_DISABLE	0
> -#define NFC_CMD_RB_INT		BIT(14)
> +#define NFC_CMD_RB_INT ((0xb << 10) | BIT(18) | BIT(16))
> =20
>  #define NFC_CMD_GET_SIZE(x)	(((x) >> 22) & GENMASK(4, 0))
> =20
> @@ -392,7 +392,7 @@ static void meson_nfc_set_data_oob(struct nand_chip *=
nand,
>  	}
>  }
> =20
> -static int meson_nfc_queue_rb(struct meson_nfc *nfc, int timeout_ms)
> +static int meson_nfc_queue_rb(struct meson_nfc *nfc, int timeout_ms, int=
 cmd_read0)
>  {
>  	u32 cmd, cfg;
>  	int ret =3D 0;
> @@ -407,17 +407,29 @@ static int meson_nfc_queue_rb(struct meson_nfc *nfc=
, int timeout_ms)
> =20
>  	reinit_completion(&nfc->completion);
> =20
> +	cmd =3D nfc->param.chip_select | NFC_CMD_CLE | NAND_CMD_STATUS;
> +	writel(cmd, nfc->reg_base + NFC_REG_CMD);
> +	meson_nfc_cmd_idle(nfc, 5);

Why 5 and 2 below? They look like magic values. Is this totally
experimental?

> +
>  	/* use the max erase time as the maximum clock for waiting R/B */
> -	cmd =3D NFC_CMD_RB | NFC_CMD_RB_INT
> -		| nfc->param.chip_select | nfc->timing.tbers_max;

This is not documented in the commit log, is it?

> +	cmd =3D NFC_CMD_RB | NFC_CMD_RB_INT | nfc->timing.tbers_max;
>  	writel(cmd, nfc->reg_base + NFC_REG_CMD);
> +	meson_nfc_cmd_idle(nfc, 2);
> =20
>  	ret =3D wait_for_completion_timeout(&nfc->completion,
>  					  msecs_to_jiffies(timeout_ms));
>  	if (ret =3D=3D 0)
> -		ret =3D -1;
> +		return -1;

Please use real error codes, such as ETIMEDOUT.

> =20
> -	return ret;
> +	if (!cmd_read0)
> +		return 0;
> +
> +	cmd =3D nfc->param.chip_select | NFC_CMD_CLE | NAND_CMD_READ0;

This looks really wrong, I don't get why you would need to send an
expensive READ0 command.

> +	writel(cmd, nfc->reg_base + NFC_REG_CMD);
> +	meson_nfc_drain_cmd(nfc);
> +	meson_nfc_wait_cmd_finish(nfc, CMD_FIFO_EMPTY_TIMEOUT);
> +
> +	return 0;
>  }
> =20
>  static void meson_nfc_set_user_byte(struct nand_chip *nand, u8 *oob_buf)
> @@ -623,7 +635,7 @@ static int meson_nfc_rw_cmd_prepare_and_execute(struc=
t nand_chip *nand,
>  	if (in) {
>  		nfc->cmdfifo.rw.cmd1 =3D cs | NFC_CMD_CLE | NAND_CMD_READSTART;
>  		writel(nfc->cmdfifo.rw.cmd1, nfc->reg_base + NFC_REG_CMD);
> -		meson_nfc_queue_rb(nfc, PSEC_TO_MSEC(sdr->tR_max));
> +		meson_nfc_queue_rb(nfc, PSEC_TO_MSEC(sdr->tR_max), 1);
>  	} else {
>  		meson_nfc_cmd_idle(nfc, nfc->timing.tadl);
>  	}
> @@ -669,7 +681,7 @@ static int meson_nfc_write_page_sub(struct nand_chip =
*nand,
> =20
>  	cmd =3D nfc->param.chip_select | NFC_CMD_CLE | NAND_CMD_PAGEPROG;
>  	writel(cmd, nfc->reg_base + NFC_REG_CMD);
> -	meson_nfc_queue_rb(nfc, PSEC_TO_MSEC(sdr->tPROG_max));
> +	meson_nfc_queue_rb(nfc, PSEC_TO_MSEC(sdr->tPROG_max), 0);
> =20
>  	meson_nfc_dma_buffer_release(nand, data_len, info_len, DMA_TO_DEVICE);
> =20
> @@ -952,7 +964,7 @@ static int meson_nfc_exec_op(struct nand_chip *nand,
>  			break;
> =20
>  		case NAND_OP_WAITRDY_INSTR:
> -			meson_nfc_queue_rb(nfc, instr->ctx.waitrdy.timeout_ms);
> +			meson_nfc_queue_rb(nfc, instr->ctx.waitrdy.timeout_ms, 1);
>  			if (instr->delay_ns)
>  				meson_nfc_cmd_idle(nfc, delay_idle);
>  			break;


Thanks,
Miqu=C3=A8l
