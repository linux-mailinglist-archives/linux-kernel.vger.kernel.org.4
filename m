Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F9B0746C15
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 10:36:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231794AbjGDIgx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 04:36:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231705AbjGDIgY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 04:36:24 -0400
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::223])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3901B10C6;
        Tue,  4 Jul 2023 01:36:21 -0700 (PDT)
X-GND-Sasl: miquel.raynal@bootlin.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1688459780;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zeaw/mEHipmGdPt6yz1DrOUPKlcqLWAbkNQPWyuHIOg=;
        b=lTJwhZHjYgSCiEdAOpVIQXoP+mdtHnW8eXahIbKbFodDULRUSrqNoKFvbJvZSu5b+dSsmz
        oOK0YDOl+hmesqjpFxHQRiGMWf4aDBrlENbAcZh2QmPhbuDICsCUFYle2GSFD2bQAClkHV
        JBcTWRPUNCb+9/m/24xVbYFeSURdwQhd9zhcKLe00OOMjdnhWHP6hbvaYIFhX0Q4N0T+4X
        n+9ITuzvkkDQxYQlM03MfEOD4VHPjYEd7RtNjNXKXXnChzaFa5ZOpXXCvtSaVlErDr/SYj
        Cl6rc9NkOS4Gts4/3TwWzyQYoOjJXW/Clk430udZ1yZqEXIPfYC+FyE63mAhQg==
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
X-GND-Sasl: miquel.raynal@bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id D6E9D6000D;
        Tue,  4 Jul 2023 08:36:18 +0000 (UTC)
Date:   Tue, 4 Jul 2023 10:36:17 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Arseniy Krasnov <AVKrasnov@sberdevices.ru>
Cc:     Liang Yang <liang.yang@amlogic.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        <oxffffaa@gmail.com>, <kernel@sberdevices.ru>,
        <linux-mtd@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-amlogic@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH v1 2/2] mtd: rawnand: meson: support for 512B ECC
 step size
Message-ID: <20230704103617.4affae8a@xps-13>
In-Reply-To: <20230628092937.538683-3-AVKrasnov@sberdevices.ru>
References: <20230628092937.538683-1-AVKrasnov@sberdevices.ru>
        <20230628092937.538683-3-AVKrasnov@sberdevices.ru>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arseniy,

AVKrasnov@sberdevices.ru wrote on Wed, 28 Jun 2023 12:29:36 +0300:

> Meson NAND supports both 512B and 1024B ECC step size.
>=20
> Signed-off-by: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
> ---
>  drivers/mtd/nand/raw/meson_nand.c | 47 +++++++++++++++++++++++--------
>  1 file changed, 35 insertions(+), 12 deletions(-)
>=20
> diff --git a/drivers/mtd/nand/raw/meson_nand.c b/drivers/mtd/nand/raw/mes=
on_nand.c
> index 345212e8c691..6cc4f63b86c8 100644
> --- a/drivers/mtd/nand/raw/meson_nand.c
> +++ b/drivers/mtd/nand/raw/meson_nand.c
> @@ -135,6 +135,7 @@ struct meson_nfc_nand_chip {
>  struct meson_nand_ecc {
>  	u32 bch;
>  	u32 strength;
> +	u32 size;
>  };
> =20
>  struct meson_nfc_data {
> @@ -190,7 +191,8 @@ struct meson_nfc {
>  };
> =20
>  enum {
> -	NFC_ECC_BCH8_1K		=3D 2,
> +	NFC_ECC_BCH8_512	=3D 1,
> +	NFC_ECC_BCH8_1K,
>  	NFC_ECC_BCH24_1K,
>  	NFC_ECC_BCH30_1K,
>  	NFC_ECC_BCH40_1K,
> @@ -198,15 +200,16 @@ enum {
>  	NFC_ECC_BCH60_1K,
>  };
> =20
> -#define MESON_ECC_DATA(b, s)	{ .bch =3D (b),	.strength =3D (s)}
> +#define MESON_ECC_DATA(b, s, sz)	{ .bch =3D (b), .strength =3D (s), .siz=
e =3D (sz) }
> =20
>  static struct meson_nand_ecc meson_ecc[] =3D {
> -	MESON_ECC_DATA(NFC_ECC_BCH8_1K, 8),
> -	MESON_ECC_DATA(NFC_ECC_BCH24_1K, 24),
> -	MESON_ECC_DATA(NFC_ECC_BCH30_1K, 30),
> -	MESON_ECC_DATA(NFC_ECC_BCH40_1K, 40),
> -	MESON_ECC_DATA(NFC_ECC_BCH50_1K, 50),
> -	MESON_ECC_DATA(NFC_ECC_BCH60_1K, 60),
> +	MESON_ECC_DATA(NFC_ECC_BCH8_512, 8,  512),
> +	MESON_ECC_DATA(NFC_ECC_BCH8_1K,  8,  1024),
> +	MESON_ECC_DATA(NFC_ECC_BCH24_1K, 24, 1024),
> +	MESON_ECC_DATA(NFC_ECC_BCH30_1K, 30, 1024),
> +	MESON_ECC_DATA(NFC_ECC_BCH40_1K, 40, 1024),
> +	MESON_ECC_DATA(NFC_ECC_BCH50_1K, 50, 1024),
> +	MESON_ECC_DATA(NFC_ECC_BCH60_1K, 60, 1024),
>  };
> =20
>  static int meson_nand_calc_ecc_bytes(int step_size, int strength)
> @@ -224,8 +227,27 @@ static int meson_nand_calc_ecc_bytes(int step_size, =
int strength)
> =20
>  NAND_ECC_CAPS_SINGLE(meson_gxl_ecc_caps,
>  		     meson_nand_calc_ecc_bytes, 1024, 8, 24, 30, 40, 50, 60);
> -NAND_ECC_CAPS_SINGLE(meson_axg_ecc_caps,
> -		     meson_nand_calc_ecc_bytes, 1024, 8);
> +
> +static const int axg_stepinfo_strengths[] =3D { 8 };
> +static const struct nand_ecc_step_info axg_stepinfo_1024 =3D {
> +	.stepsize =3D 1024,
> +	.strengths =3D axg_stepinfo_strengths,
> +	.nstrengths =3D ARRAY_SIZE(axg_stepinfo_strengths)
> +};
> +
> +static const struct nand_ecc_step_info axg_stepinfo_512 =3D {
> +	.stepsize =3D 512,
> +	.strengths =3D axg_stepinfo_strengths,
> +	.nstrengths =3D ARRAY_SIZE(axg_stepinfo_strengths)
> +};
> +
> +static const struct nand_ecc_step_info axg_stepinfo[] =3D { axg_stepinfo=
_1024, axg_stepinfo_512 };
> +
> +static const struct nand_ecc_caps meson_axg_ecc_caps =3D {
> +	.stepinfos =3D axg_stepinfo,
> +	.nstepinfos =3D ARRAY_SIZE(axg_stepinfo),
> +	.calc_ecc_bytes =3D meson_nand_calc_ecc_bytes,
> +};
> =20
>  static struct meson_nfc_nand_chip *to_meson_nand(struct nand_chip *nand)
>  {
> @@ -1259,7 +1281,8 @@ static int meson_nand_bch_mode(struct nand_chip *na=
nd)
>  		return -EINVAL;
> =20
>  	for (i =3D 0; i < ARRAY_SIZE(meson_ecc); i++) {
> -		if (meson_ecc[i].strength =3D=3D nand->ecc.strength) {
> +		if (meson_ecc[i].strength =3D=3D nand->ecc.strength &&
> +		    meson_ecc[i].size =3D=3D nand->ecc.size) {
>  			meson_chip->bch_mode =3D meson_ecc[i].bch;
>  			return 0;
>  		}
> @@ -1278,7 +1301,7 @@ static int meson_nand_attach_chip(struct nand_chip =
*nand)
>  	struct meson_nfc *nfc =3D nand_get_controller_data(nand);
>  	struct meson_nfc_nand_chip *meson_chip =3D to_meson_nand(nand);
>  	struct mtd_info *mtd =3D nand_to_mtd(nand);
> -	int nsectors =3D mtd->writesize / 1024;
> +	int nsectors =3D mtd->writesize / 512;

This cannot be unconditional, right?

>  	int raw_writesize;
>  	int ret;
> =20


Thanks,
Miqu=C3=A8l
