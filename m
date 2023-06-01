Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 122817195AA
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 10:33:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231237AbjFAIdO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 04:33:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232046AbjFAIcb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 04:32:31 -0400
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CB4DE57
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jun 2023 01:31:18 -0700 (PDT)
X-GND-Sasl: miquel.raynal@bootlin.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1685608274;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Cah2zLTpzlNGsP/8SUSmD1ez7BpuFUpsiaP0UNlHnqA=;
        b=LayGOI6JXCqX5cyoOrcKYQHDUxDUsFRYiLBJFDozVs6WJIBSROInUjVxGThdE6HaGdMryQ
        A4qnq70WlvRV0rVjYIsa7nnYoYtpKCNnSbvJm0ngAJux7WDoTiYsiX+4IwLPbOmjJqPcvD
        IJ11XkZK0v6xP5Nc9ZZlREv0LNhXDLHeo272qzEsbBZNFpCTBrPkP/dxEzoCQO5q4Ehx9R
        KuI86HFwEIPQOwRauirkxcv5tCK9k0IGiWt64z+e0MvzAxfoff410Zs+3w4PSnQtKL1E3b
        A3enSCg/ISp/8Y0fFFTVWhpK4zDlGBesBCeJfzfi6Xlx8ap7QblJ2EWplhnFng==
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
Received: by mail.gandi.net (Postfix) with ESMTPSA id 3E16D1BF205;
        Thu,  1 Jun 2023 08:31:12 +0000 (UTC)
Date:   Thu, 1 Jun 2023 10:31:11 +0200
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
Subject: Re: [RFC PATCH v5 3/6] mtd: rawnand: meson: only expose unprotected
 user OOB bytes
Message-ID: <20230601103111.6840acc0@xps-13>
In-Reply-To: <20230601061850.3907800-4-AVKrasnov@sberdevices.ru>
References: <20230601061850.3907800-1-AVKrasnov@sberdevices.ru>
        <20230601061850.3907800-4-AVKrasnov@sberdevices.ru>
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

AVKrasnov@sberdevices.ru wrote on Thu, 1 Jun 2023 09:18:46 +0300:

> This moves free bytes of OOB to non-protected ECC area. It is needed to

As we discussed, I expect this commit to just change the OOB layout to
expose unprotected OOB bytes to the user, that is the only change this
commit should carry. If that does not work, you should add a
preparation patch.

> make JFFS2 works correctly with this NAND controller. Problem fires when
> JFFS2 driver writes cleanmarker to some page and later it tries to write
> to this page - write will be done successfully, but after that such page
> becomes unreadable due to invalid ECC codes. This happens because second
> write needs to update ECC codes, but it is impossible to do it correctly
> without block erase. So idea of this patch is to use the unprotected OOB
> area to store the cleanmarkers, so that they can be written by the
> filesystem without caring much about the page being empty or not: the
> ECC codes will not be written anyway.
>=20
> JFFS2 is only useful on tiny NAND devices, where UBI does not fit, which
> are usually true SLC flashes, with the capability of writing a page with
> empty (0xFF) data, and still be able to write actual data to it later in
> a second write.
>=20
> Signed-off-by: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
> ---
>  Changelog v4->v5:
>  * Drop cosmetic changes from this patch.
>  * Do not ignore ECC protected user bytes provided by hw. Even these
>    bytes are out of user area of OOB, its values are still read from
>    the provided OOB buffer and written by hardware. Same behaviour is
>    preserved for read access - such bytes are read from DMA buffer and
>    placed to OOB buffer.
>  * OOB read and write become more lightweight because I removed heavy
>    READ0 and PAGEPROG command from it (both commands are still sent
>    when OOB access is performed using OOB callbacks). In case of page
>    read/write OOB data is handled in the internal SRAM of the controller.
>  * Commit message updated.
>  * Temporary buffer for OOB read/write is removed. Seems everything
>    works correctly without it.
>=20
>  drivers/mtd/nand/raw/meson_nand.c | 134 ++++++++++++++++++++++++++----
>  1 file changed, 117 insertions(+), 17 deletions(-)
>=20
> diff --git a/drivers/mtd/nand/raw/meson_nand.c b/drivers/mtd/nand/raw/mes=
on_nand.c
> index 82a629025adc..e42c28be02f3 100644
> --- a/drivers/mtd/nand/raw/meson_nand.c
> +++ b/drivers/mtd/nand/raw/meson_nand.c
> @@ -358,8 +358,11 @@ static u8 *meson_nfc_data_ptr(struct nand_chip *nand=
, int i)
>  static void meson_nfc_get_data_oob(struct nand_chip *nand,
>  				   u8 *buf, u8 *oobbuf)
>  {
> +	struct meson_nfc_nand_chip *meson_chip =3D to_meson_nand(nand);
> +	struct mtd_info *mtd =3D nand_to_mtd(nand);
>  	int i, oob_len =3D 0;
>  	u8 *dsrc, *osrc;
> +	u8 *oobtail;
> =20
>  	oob_len =3D nand->ecc.bytes + 2;
>  	for (i =3D 0; i < nand->ecc.steps; i++) {
> @@ -368,17 +371,27 @@ static void meson_nfc_get_data_oob(struct nand_chip=
 *nand,
>  			memcpy(buf, dsrc, nand->ecc.size);
>  			buf +=3D nand->ecc.size;
>  		}
> +
>  		osrc =3D meson_nfc_oob_ptr(nand, i);
>  		memcpy(oobbuf, osrc, oob_len);
>  		oobbuf +=3D oob_len;
>  	}
> +
> +	oobtail =3D meson_chip->data_buf + nand->ecc.steps *
> +		  (nand->ecc.size + oob_len);
> +
> +	/* 'oobbuf' points to the start of user area. */
> +	memcpy(oobbuf, oobtail, mtd->oobsize - nand->ecc.steps * oob_len);
>  }
> =20
>  static void meson_nfc_set_data_oob(struct nand_chip *nand,
>  				   const u8 *buf, u8 *oobbuf)
>  {
> +	struct meson_nfc_nand_chip *meson_chip =3D to_meson_nand(nand);
> +	struct mtd_info *mtd =3D nand_to_mtd(nand);
>  	int i, oob_len =3D 0;
>  	u8 *dsrc, *osrc;
> +	u8 *oobtail;
> =20
>  	oob_len =3D nand->ecc.bytes + 2;
>  	for (i =3D 0; i < nand->ecc.steps; i++) {
> @@ -391,6 +404,12 @@ static void meson_nfc_set_data_oob(struct nand_chip =
*nand,
>  		memcpy(osrc, oobbuf, oob_len);
>  		oobbuf +=3D oob_len;
>  	}
> +
> +	oobtail =3D meson_chip->data_buf + nand->ecc.steps *
> +		  (nand->ecc.size + oob_len);

This is always targeting the same area, so it looks strange to me.

> +
> +	/* 'oobbuf' points to the start of user area. */
> +	memcpy(oobtail, oobbuf, mtd->oobsize - nand->ecc.steps * oob_len);

TBH I don't get what you do here.

>  }
> =20
>  static int meson_nfc_queue_rb(struct nand_chip *nand, int timeout_ms)
> @@ -433,7 +452,7 @@ static void meson_nfc_set_user_byte(struct nand_chip =
*nand, u8 *oob_buf)
>  	__le64 *info;
>  	int i, count;
> =20
> -	for (i =3D 0, count =3D 0; i < nand->ecc.steps; i++, count +=3D 2) {
> +	for (i =3D 0, count =3D 0; i < nand->ecc.steps; i++, count +=3D (nand->=
ecc.bytes + 2)) {
>  		info =3D &meson_chip->info_buf[i];
>  		*info |=3D oob_buf[count];
>  		*info |=3D oob_buf[count + 1] << 8;
> @@ -446,7 +465,7 @@ static void meson_nfc_get_user_byte(struct nand_chip =
*nand, u8 *oob_buf)
>  	__le64 *info;
>  	int i, count;
> =20
> -	for (i =3D 0, count =3D 0; i < nand->ecc.steps; i++, count +=3D 2) {
> +	for (i =3D 0, count =3D 0; i < nand->ecc.steps; i++, count +=3D (nand->=
ecc.bytes + 2)) {
>  		info =3D &meson_chip->info_buf[i];
>  		oob_buf[count] =3D *info;
>  		oob_buf[count + 1] =3D *info >> 8;
> @@ -638,6 +657,84 @@ static int meson_nfc_rw_cmd_prepare_and_execute(stru=
ct nand_chip *nand,
>  	return 0;
>  }
> =20
> +static u32 meson_nfc_oob_free_bytes(struct nand_chip *nand)
> +{
> +	struct mtd_info *mtd =3D nand_to_mtd(nand);
> +
> +	return mtd->oobsize - nand->ecc.steps * (nand->ecc.bytes + 2);

This looks like a static value, just save it somewhere instead of
recomputing it?

> +}
> +
> +static int meson_nfc_write_oob(struct nand_chip *nand, int page)
> +{
> +	struct mtd_info *mtd =3D nand_to_mtd(nand);
> +	u32 page_size =3D mtd->writesize + mtd->oobsize;
> +	u32 oob_bytes =3D meson_nfc_oob_free_bytes(nand);
> +	u8 *oob_buf;
> +	int ret;
> +
> +	if (!oob_bytes)
> +		return 0;

Can this happen?

> +
> +	/* Called as OOB write helper, will send NAND_CMD_PAGEPROG. */
> +	if (page !=3D -1) {
> +		ret =3D nand_prog_page_begin_op(nand, page, 0, NULL, 0);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	oob_buf =3D nand->oob_poi;
> +
> +	ret =3D nand_change_write_column_op(nand, page_size - oob_bytes,
> +					  oob_buf + (mtd->oobsize - oob_bytes),
> +					  oob_bytes, false);
> +	if (ret)
> +		return ret;
> +
> +	return (page !=3D -1) ? nand_prog_page_end_op(nand) : 0;
> +}
> +
> +static int meson_nfc_read_oob(struct nand_chip *nand, int page)
> +{
> +	struct mtd_info *mtd =3D nand_to_mtd(nand);
> +	u8 *oob_buf =3D nand->oob_poi;
> +	u32 oob_bytes;
> +	u32 page_size;
> +	int ret;
> +	int i;
> +
> +	/* Called as OOB read helper, send NAND_CMD_READ0. */
> +	if (page !=3D -1) {

I don't like this logic with the "-1", it really hides what the
controller needs to do, if you need a helper to send a command, then
create that helper and give it a decent name.

> +		ret =3D nand_read_page_op(nand, page, 0, NULL, 0);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	/* Read ECC codes and user bytes. */
> +	for (i =3D 0; i < nand->ecc.steps; i++) {
> +		u32 ecc_offs =3D nand->ecc.size * (i + 1) +
> +			       (nand->ecc.bytes + 2) * i;
> +
> +		ret =3D nand_change_read_column_op(nand, ecc_offs,
> +						 oob_buf + i * (nand->ecc.bytes + 2),
> +						 (nand->ecc.bytes + 2), false);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	oob_bytes =3D meson_nfc_oob_free_bytes(nand);
> +
> +	if (!oob_bytes)
> +		return 0;
> +
> +	page_size =3D mtd->writesize + mtd->oobsize;
> +
> +	ret =3D nand_change_read_column_op(nand, page_size - oob_bytes,
> +					 oob_buf + (mtd->oobsize - oob_bytes),
> +					 oob_bytes, false);
> +
> +	return ret;
> +}
> +
>  static int meson_nfc_write_page_sub(struct nand_chip *nand,
>  				    int page, int raw)
>  {
> @@ -674,6 +771,12 @@ static int meson_nfc_write_page_sub(struct nand_chip=
 *nand,
>  				     NFC_CMD_SCRAMBLER_DISABLE);
>  	}
> =20
> +	if (!raw) {

Why this check?

You should instead propagate the oob_required field and check that
value I believe.

> +		ret =3D meson_nfc_write_oob(nand, -1);
> +		if (ret)
> +			return ret;
> +	}
> +
>  	cmd =3D nfc->param.chip_select | NFC_CMD_CLE | NAND_CMD_PAGEPROG;
>  	writel(cmd, nfc->reg_base + NFC_REG_CMD);
>  	meson_nfc_queue_rb(nand, PSEC_TO_MSEC(sdr->tPROG_max));
> @@ -834,17 +937,10 @@ static int meson_nfc_read_page_hwecc(struct nand_ch=
ip *nand, u8 *buf,
>  		memcpy(buf, meson_chip->data_buf, mtd->writesize);
>  	}
> =20
> -	return bitflips;
> -}
> -
> -static int meson_nfc_read_oob_raw(struct nand_chip *nand, int page)
> -{
> -	return meson_nfc_read_page_raw(nand, NULL, 1, page);
> -}
> +	if (oob_required && ret)

Unclear why you check ret here?

> +		meson_nfc_read_oob(nand, -1);
> =20
> -static int meson_nfc_read_oob(struct nand_chip *nand, int page)
> -{
> -	return meson_nfc_read_page_hwecc(nand, NULL, 1, page);
> +	return bitflips;
>  }
> =20
>  static bool meson_nfc_is_buffer_dma_safe(const void *buffer)
> @@ -987,12 +1083,16 @@ static int meson_ooblayout_free(struct mtd_info *m=
td, int section,
>  				struct mtd_oob_region *oobregion)
>  {
>  	struct nand_chip *nand =3D mtd_to_nand(mtd);
> +	u32 oob_bytes =3D meson_nfc_oob_free_bytes(nand);
> =20
>  	if (section >=3D nand->ecc.steps)
>  		return -ERANGE;
> =20
> -	oobregion->offset =3D section * (2 + nand->ecc.bytes);

The first two bytes of OOB are reserved for the bad block markers. This
is not related to your controller.

> -	oobregion->length =3D 2;
> +	/* Split rest of OOB area (not covered by ECC engine) per each
> +	 * ECC section. This will be OOB data available to user.
> +	 */
> +	oobregion->offset =3D (section + nand->ecc.steps) * (2 + nand->ecc.byte=
s);

This is not possible, see above.

> +	oobregion->length =3D oob_bytes / nand->ecc.steps;
> =20
>  	return 0;
>  }
> @@ -1220,12 +1320,12 @@ static int meson_nand_attach_chip(struct nand_chi=
p *nand)
>  	nand->ecc.engine_type =3D NAND_ECC_ENGINE_TYPE_ON_HOST;
>  	nand->ecc.write_page_raw =3D meson_nfc_write_page_raw;
>  	nand->ecc.write_page =3D meson_nfc_write_page_hwecc;
> -	nand->ecc.write_oob_raw =3D nand_write_oob_std;
> -	nand->ecc.write_oob =3D nand_write_oob_std;
> =20
> +	nand->ecc.write_oob_raw =3D meson_nfc_write_oob;
> +	nand->ecc.write_oob =3D meson_nfc_write_oob;
>  	nand->ecc.read_page_raw =3D meson_nfc_read_page_raw;
>  	nand->ecc.read_page =3D meson_nfc_read_page_hwecc;
> -	nand->ecc.read_oob_raw =3D meson_nfc_read_oob_raw;
> +	nand->ecc.read_oob_raw =3D meson_nfc_read_oob;
>  	nand->ecc.read_oob =3D meson_nfc_read_oob;
> =20
>  	if (nand->options & NAND_BUSWIDTH_16) {


Thanks,
Miqu=C3=A8l
