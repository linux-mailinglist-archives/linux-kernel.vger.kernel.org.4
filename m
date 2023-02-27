Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79FCF6A3F5E
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 11:19:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230157AbjB0KT0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 05:19:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229921AbjB0KTR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 05:19:17 -0500
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::221])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9407F1E9F2
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 02:19:14 -0800 (PST)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id B22B224001A;
        Mon, 27 Feb 2023 10:19:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1677493152;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eyI6AhKtcqX0kbmsp5bQS7/ogwr7y58fU8y2Z142jtw=;
        b=aNVqwRlVeHBdeykUOOqk60lbXvvy3w7ZQvMvcJ6Mq2YeodXVmidT4C9kLfK9d0kS9gCtDq
        PvpUt/h6JWp8HyNb6cIXm6J2zBQax8rJCV80VSDptu+IWAlcT/TML91Cxa91w4hiAJu1P4
        taSF19XQa9YLvEMi4dmibRWKSZ7fZ7nUdzcdCF3QrXEJYM9ArAESVbl2jTgyu8YzBAC3eh
        r/+44vg59I2WJeY9SVPEict4DTmBQUBGIqKQ+HCtkcXUvYl6zf4cvewuHeBPC/NXnya61x
        3FZWWWyqj0AuOPDH2gk2q0Fn8TglU+qU0UEaLZq4FpdBMqAqEaUUH/15GQJa3A==
Date:   Mon, 27 Feb 2023 11:19:04 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Arseniy Krasnov <AVKrasnov@sberdevices.ru>
Cc:     Liang Yang <liang.yang@amlogic.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        <linux-mtd@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-amlogic@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <kernel@sberdevices.ru>,
        <oxffffaa@gmail.com>
Subject: Re: [PATCH v3] mtd: rawnand: meson: initialize struct with zeroes
Message-ID: <20230227111904.36c0a02d@xps-13>
In-Reply-To: <20230227095906.754178-1-AVKrasnov@sberdevices.ru>
References: <20230227095906.754178-1-AVKrasnov@sberdevices.ru>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arseniy,

AVKrasnov@sberdevices.ru wrote on Mon, 27 Feb 2023 12:59:06 +0300:

> This structure must be zeroed, because it's field 'hw->core' is used as
> 'parent' in 'clk_core_fill_parent_index()', but it will be uninitialized.
> This happens, because when this struct is not zeroed, pointer 'hw' is
> "initialized" by garbage, which is valid pointer, but points to some
> garbage. So 'hw' will be dereferenced, but 'core' contains some random
> data which will be interpreted as a pointer. The following backtrace is
> result of dereference of such pointer:
>=20
> [    1.081319]  __clk_register+0x414/0x820
> [    1.085113]  devm_clk_register+0x64/0xd0
> [    1.088995]  meson_nfc_probe+0x258/0x6ec
> [    1.092875]  platform_probe+0x70/0xf0
> [    1.096498]  really_probe+0xc8/0x3e0
> [    1.100034]  __driver_probe_device+0x84/0x190
> [    1.104346]  driver_probe_device+0x44/0x120
> [    1.108487]  __driver_attach+0xb4/0x220
> [    1.112282]  bus_for_each_dev+0x78/0xd0
> [    1.116077]  driver_attach+0x2c/0x40
> [    1.119613]  bus_add_driver+0x184/0x240
> [    1.123408]  driver_register+0x80/0x140
> [    1.127203]  __platform_driver_register+0x30/0x40
> [    1.131860]  meson_nfc_driver_init+0x24/0x30
>=20
> Fixes: 1e4d3ba66888 ("mtd: rawnand: meson: fix the clock")
> Signed-off-by: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
> Acked-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> ---

The changelog is missing, I need to know what's different.

Also if you resend with a changelog, please include Neil's tag.

>  drivers/mtd/nand/raw/meson_nand.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/mtd/nand/raw/meson_nand.c b/drivers/mtd/nand/raw/mes=
on_nand.c
> index 5ee01231ac4c..30e326adabfc 100644
> --- a/drivers/mtd/nand/raw/meson_nand.c
> +++ b/drivers/mtd/nand/raw/meson_nand.c
> @@ -991,7 +991,7 @@ static const struct mtd_ooblayout_ops meson_ooblayout=
_ops =3D {
> =20
>  static int meson_nfc_clk_init(struct meson_nfc *nfc)
>  {
> -	struct clk_parent_data nfc_divider_parent_data[1];
> +	struct clk_parent_data nfc_divider_parent_data[1] =3D {0};
>  	struct clk_init_data init =3D {0};
>  	int ret;
> =20


Thanks,
Miqu=C3=A8l
