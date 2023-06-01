Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 186EA7194DA
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 09:59:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231975AbjFAH7M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 03:59:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232011AbjFAH6j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 03:58:39 -0400
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::224])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43B49173A
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jun 2023 00:51:46 -0700 (PDT)
X-GND-Sasl: miquel.raynal@bootlin.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1685605905;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+e3wI1fiGsWTXmwy45Q9EAm7dA/PfrhNn8PVmuub8MY=;
        b=TgHA9VRFQkRXiNheNuKMUqBNVBf4NnoNZONHtuauHx+qh42PQfCljDf+8E1hPkA8QC2oc8
        fa8Nnerjm7B1SBFxtQVgQyrSeJa+fN1ljPwppadYcpWzF8xgK3Hz/1gmtkizHWroa5BDZj
        A/u0Qt1FrkOCkcHPaIXAXkvshawn9JTLP6LKc5rUbCTWoQPEvy/5ZeMgjNeDiqU+uOtLVB
        DUaADvukxsrrfeE5QKp/Asymr3fuJW2eGCF5Wwj75vrlWYxgfEHiEFqO4xNnWbUoKhmFmc
        UAryJpQBYJjvGF6WUrUkFZweWcI39buTkk0JpF8WVKwWpN+bql/oDquB6GrsYw==
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
Received: by mail.gandi.net (Postfix) with ESMTPSA id 7D4D7E000D;
        Thu,  1 Jun 2023 07:51:43 +0000 (UTC)
Date:   Thu, 1 Jun 2023 09:51:42 +0200
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
Subject: Re: [RFC PATCH v5 1/6] mtd: rawnand: meson: fix ready/busy command
Message-ID: <20230601095142.3a611b5a@xps-13>
In-Reply-To: <20230601061850.3907800-2-AVKrasnov@sberdevices.ru>
References: <20230601061850.3907800-1-AVKrasnov@sberdevices.ru>
        <20230601061850.3907800-2-AVKrasnov@sberdevices.ru>
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

AVKrasnov@sberdevices.ru wrote on Thu, 1 Jun 2023 09:18:44 +0300:

> This fixes ready/busy command value.

nit: "Fix the ready/busy command value."
>=20
> Signed-off-by: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
> ---
>  drivers/mtd/nand/raw/meson_nand.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/mtd/nand/raw/meson_nand.c b/drivers/mtd/nand/raw/mes=
on_nand.c
> index 074e14225c06..9dd4a676497b 100644
> --- a/drivers/mtd/nand/raw/meson_nand.c
> +++ b/drivers/mtd/nand/raw/meson_nand.c
> @@ -37,7 +37,7 @@
>  #define NFC_CMD_SCRAMBLER_ENABLE	BIT(19)
>  #define NFC_CMD_SCRAMBLER_DISABLE	0
>  #define NFC_CMD_SHORTMODE_DISABLE	0
> -#define NFC_CMD_RB_INT		BIT(14)
> +#define NFC_CMD_RB_INT		((0xb << 10) | BIT(18) | BIT(16))
> =20
>  #define NFC_CMD_GET_SIZE(x)	(((x) >> 22) & GENMASK(4, 0))
> =20


Thanks,
Miqu=C3=A8l
