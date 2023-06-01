Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CCF97195B5
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 10:36:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232330AbjFAIgR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 04:36:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232199AbjFAIfi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 04:35:38 -0400
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36A89E70
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jun 2023 01:34:11 -0700 (PDT)
X-GND-Sasl: miquel.raynal@bootlin.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1685608450;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=663IAskSouGvSvR75PHPprqPibZidxQMt5gFnwQhwKw=;
        b=N9LC6jiIgSsRnMoqd4fOu94yzBOqz5ZALVcfI3eIolqZxTZyzsAg+yxpRCz6ELtRAiUYyd
        2h6byanGwpXngLqwp3gUhuHEfSyj/SCVJVT+I/d5FWTnC7LzH3dTcUM64dmXYVpeWndXWh
        mqOpXCTwAyJmoS7ROmQUVES/ShT7mwcZT5rmgSUDM5mi8X44jotikO6TXQiQn5PB6gWjKu
        ErHfcirIYe6jeMSa2E2dPwz5wM1/fGZBjLEPRtSHccM+72dHg2g6CkGN1A9TCfhTeilir+
        82nF6inbzu008F/EWwZvmxFHvUy++vpVi2EPyEsrzqJckmGMbifrX4icsAWlLg==
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
Received: by mail.gandi.net (Postfix) with ESMTPSA id EA7B3C000E;
        Thu,  1 Jun 2023 08:34:07 +0000 (UTC)
Date:   Thu, 1 Jun 2023 10:34:05 +0200
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
Subject: Re: [RFC PATCH v5 4/6] mtd: rawnand: meson: use macro for OOB area
Message-ID: <20230601103405.51cb459a@xps-13>
In-Reply-To: <20230601061850.3907800-5-AVKrasnov@sberdevices.ru>
References: <20230601061850.3907800-1-AVKrasnov@sberdevices.ru>
        <20230601061850.3907800-5-AVKrasnov@sberdevices.ru>
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

AVKrasnov@sberdevices.ru wrote on Thu, 1 Jun 2023 09:18:47 +0300:

> This replaces constants and same patterns for OOB handling with special
> macroses.
>=20
> Signed-off-by: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
> ---
>  drivers/mtd/nand/raw/meson_nand.c | 33 ++++++++++++++++++-------------
>  1 file changed, 19 insertions(+), 14 deletions(-)
>=20
> diff --git a/drivers/mtd/nand/raw/meson_nand.c b/drivers/mtd/nand/raw/mes=
on_nand.c
> index e42c28be02f3..23a73268421b 100644
> --- a/drivers/mtd/nand/raw/meson_nand.c
> +++ b/drivers/mtd/nand/raw/meson_nand.c
> @@ -108,6 +108,9 @@
> =20
>  #define PER_INFO_BYTE		8
> =20
> +#define NFC_USER_BYTES		2
> +#define NFC_OOB_PER_ECC(nand)	((nand)->ecc.bytes + NFC_USER_BYTES)

OOB per ECC for me does not make sense.
OOB is the whole area after the data.
What about NFC_OOB_SZ_PER_ECC_STEP ?

> +
>  struct meson_nfc_nand_chip {
>  	struct list_head node;
>  	struct nand_chip nand;
> @@ -339,7 +342,7 @@ static u8 *meson_nfc_oob_ptr(struct nand_chip *nand, =
int i)
>  	struct meson_nfc_nand_chip *meson_chip =3D to_meson_nand(nand);
>  	int len;
> =20
> -	len =3D nand->ecc.size * (i + 1) + (nand->ecc.bytes + 2) * i;
> +	len =3D nand->ecc.size * (i + 1) + NFC_OOB_PER_ECC(nand) * i;
> =20
>  	return meson_chip->data_buf + len;
>  }
> @@ -350,7 +353,7 @@ static u8 *meson_nfc_data_ptr(struct nand_chip *nand,=
 int i)
>  	int len, temp;
> =20
>  	temp =3D nand->ecc.size + nand->ecc.bytes;
> -	len =3D (temp + 2) * i;
> +	len =3D (temp + NFC_USER_BYTES) * i;
> =20
>  	return meson_chip->data_buf + len;
>  }
> @@ -364,7 +367,7 @@ static void meson_nfc_get_data_oob(struct nand_chip *=
nand,
>  	u8 *dsrc, *osrc;
>  	u8 *oobtail;
> =20
> -	oob_len =3D nand->ecc.bytes + 2;
> +	oob_len =3D NFC_OOB_PER_ECC(nand);
>  	for (i =3D 0; i < nand->ecc.steps; i++) {
>  		if (buf) {
>  			dsrc =3D meson_nfc_data_ptr(nand, i);
> @@ -393,7 +396,7 @@ static void meson_nfc_set_data_oob(struct nand_chip *=
nand,
>  	u8 *dsrc, *osrc;
>  	u8 *oobtail;
> =20
> -	oob_len =3D nand->ecc.bytes + 2;
> +	oob_len =3D NFC_OOB_PER_ECC(nand);
>  	for (i =3D 0; i < nand->ecc.steps; i++) {
>  		if (buf) {
>  			dsrc =3D meson_nfc_data_ptr(nand, i);
> @@ -452,7 +455,7 @@ static void meson_nfc_set_user_byte(struct nand_chip =
*nand, u8 *oob_buf)
>  	__le64 *info;
>  	int i, count;
> =20
> -	for (i =3D 0, count =3D 0; i < nand->ecc.steps; i++, count +=3D (nand->=
ecc.bytes + 2)) {
> +	for (i =3D 0, count =3D 0; i < nand->ecc.steps; i++, count +=3D NFC_OOB=
_PER_ECC(nand)) {
>  		info =3D &meson_chip->info_buf[i];
>  		*info |=3D oob_buf[count];
>  		*info |=3D oob_buf[count + 1] << 8;
> @@ -465,7 +468,7 @@ static void meson_nfc_get_user_byte(struct nand_chip =
*nand, u8 *oob_buf)
>  	__le64 *info;
>  	int i, count;
> =20
> -	for (i =3D 0, count =3D 0; i < nand->ecc.steps; i++, count +=3D (nand->=
ecc.bytes + 2)) {
> +	for (i =3D 0, count =3D 0; i < nand->ecc.steps; i++, count +=3D NFC_OOB=
_PER_ECC(nand)) {
>  		info =3D &meson_chip->info_buf[i];
>  		oob_buf[count] =3D *info;
>  		oob_buf[count + 1] =3D *info >> 8;
> @@ -661,7 +664,7 @@ static u32 meson_nfc_oob_free_bytes(struct nand_chip =
*nand)
>  {
>  	struct mtd_info *mtd =3D nand_to_mtd(nand);
> =20
> -	return mtd->oobsize - nand->ecc.steps * (nand->ecc.bytes + 2);
> +	return mtd->oobsize - nand->ecc.steps * NFC_OOB_PER_ECC(nand);
>  }
> =20
>  static int meson_nfc_write_oob(struct nand_chip *nand, int page)
> @@ -712,11 +715,11 @@ static int meson_nfc_read_oob(struct nand_chip *nan=
d, int page)
>  	/* Read ECC codes and user bytes. */
>  	for (i =3D 0; i < nand->ecc.steps; i++) {
>  		u32 ecc_offs =3D nand->ecc.size * (i + 1) +
> -			       (nand->ecc.bytes + 2) * i;
> +			       NFC_OOB_PER_ECC(nand) * i;
> =20
>  		ret =3D nand_change_read_column_op(nand, ecc_offs,
> -						 oob_buf + i * (nand->ecc.bytes + 2),
> -						 (nand->ecc.bytes + 2), false);
> +						 oob_buf + i * NFC_OOB_PER_ECC(nand),
> +						 NFC_OOB_PER_ECC(nand), false);
>  		if (ret)
>  			return ret;
>  	}
> @@ -918,12 +921,14 @@ static int meson_nfc_read_page_hwecc(struct nand_ch=
ip *nand, u8 *buf,
> =20
>  		for (i =3D 0; i < nand->ecc.steps ; i++) {
>  			u8 *data =3D buf + i * ecc->size;
> -			u8 *oob =3D nand->oob_poi + i * (ecc->bytes + 2);
> +			u8 *oob =3D nand->oob_poi + i * NFC_OOB_PER_ECC(nand);
> =20
>  			if (correct_bitmap & BIT_ULL(i))
>  				continue;
> +
>  			ret =3D nand_check_erased_ecc_chunk(data,	ecc->size,
> -							  oob, ecc->bytes + 2,
> +							  oob,
> +							  NFC_OOB_PER_ECC(nand),
>  							  NULL, 0,
>  							  ecc->strength);
>  			if (ret < 0) {
> @@ -1073,7 +1078,7 @@ static int meson_ooblayout_ecc(struct mtd_info *mtd=
, int section,
>  	if (section >=3D nand->ecc.steps)
>  		return -ERANGE;
> =20
> -	oobregion->offset =3D  2 + (section * (2 + nand->ecc.bytes));
> +	oobregion->offset =3D NFC_USER_BYTES + (section * NFC_OOB_PER_ECC(nand)=
);

No, the first "2" here is for bad block markers, it is not related to
your ECC engine layout I believe.

>  	oobregion->length =3D nand->ecc.bytes;
> =20
>  	return 0;
> @@ -1091,7 +1096,7 @@ static int meson_ooblayout_free(struct mtd_info *mt=
d, int section,
>  	/* Split rest of OOB area (not covered by ECC engine) per each
>  	 * ECC section. This will be OOB data available to user.
>  	 */
> -	oobregion->offset =3D (section + nand->ecc.steps) * (2 + nand->ecc.byte=
s);
> +	oobregion->offset =3D (section + nand->ecc.steps) * NFC_OOB_PER_ECC(nan=
d);
>  	oobregion->length =3D oob_bytes / nand->ecc.steps;
> =20
>  	return 0;


Thanks,
Miqu=C3=A8l
