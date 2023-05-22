Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B34F470C275
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 17:33:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234391AbjEVPdn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 11:33:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230293AbjEVPdl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 11:33:41 -0400
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::225])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FFBAAA
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 08:33:38 -0700 (PDT)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 2A4A31C0005;
        Mon, 22 May 2023 15:33:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1684769616;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oTNkxoXNH5nvERaedEuKHmNcyqjQZ3XwX/bJPv/WU2E=;
        b=IMfkVryp9hj5PV2VbxjCP00/4UBpe7QvP7AMSW1tCJYsSxYTfaqfamdu967u9eZ6yiNe0t
        SDMkMU05PlO5frq8G1ylfScOAt07sko9Lp7twLGrUT0lgJkInzkhhAUMetD88+ho+cqzZt
        qtMsnt2Ya1wyWfDbJitR82/79DlbC4su/82/cN0+7fjDgKpb63mmrsMOEtaoRthcA2mCye
        u8N6U9wB5um5tfwEA5rW/Z7rJtHhH7MJsg5r00HOv+uqYSwz8xii/CyW7bBMIjCwLeMMw+
        osue2lKX/WEXPJTx7w8p9Er2+2G31gbt2gYX0k90MBCEo/w2SGUSiTMcIo1rIg==
Date:   Mon, 22 May 2023 17:33:34 +0200
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
Subject: Re: [PATCH v4 2/5] mtd: rawnand: meson: move OOB to non-protected
 ECC area
Message-ID: <20230522173334.7aa6f917@xps-13>
In-Reply-To: <20230515094440.3552094-3-AVKrasnov@sberdevices.ru>
References: <20230515094440.3552094-1-AVKrasnov@sberdevices.ru>
        <20230515094440.3552094-3-AVKrasnov@sberdevices.ru>
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

AVKrasnov@sberdevices.ru wrote on Mon, 15 May 2023 12:44:36 +0300:

The title should perhaps be "only expose unprotected user OOB bytes".

> This moves free bytes of OOB to non-protected ECC area. It is needed to
> make JFFS2 works correctly with this NAND controller. Problem fires when
> JFFS2 driver writes cleanmarker to some page and later it tries to write
> to this page - write will be done successfully, but after that such page
> becomes unreadable due to invalid ECC codes. This happens because second
> write needs to update ECC codes, but it is impossible to do it correctly
> without block erase. So idea of this patch is to

"... is to use the unprotected OOB area to store the cleanmarkers, so
that they can be written by the filesystem without caring much about
the page being empty or not: the ECC codes will not be written anyway."
?

JFFS2 is only useful on tiny NAND devices, where UBI does not fit,
which are usually true SLC flashes, with the capability of writing
a page with empty (0xFF) data, and still be able to write actual data
to it later in a second write.

> split accesses to OOB
> free bytes and data on each page - now both of them does not depends on
> each other.
>=20
> Signed-off-by: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
> ---
>  drivers/mtd/nand/raw/meson_nand.c | 192 ++++++++++++++++++++++++------
>  1 file changed, 155 insertions(+), 37 deletions(-)
>=20
> diff --git a/drivers/mtd/nand/raw/meson_nand.c b/drivers/mtd/nand/raw/mes=
on_nand.c
> index 2f4d8c84186b..8526a6b87720 100644
> --- a/drivers/mtd/nand/raw/meson_nand.c
> +++ b/drivers/mtd/nand/raw/meson_nand.c
> @@ -108,6 +108,9 @@
> =20
>  #define PER_INFO_BYTE		8
> =20
> +#define NFC_USER_BYTES		2
> +#define NFC_OOB_PER_ECC(nand)	((nand)->ecc.bytes + NFC_USER_BYTES)
> +
>  struct meson_nfc_nand_chip {
>  	struct list_head node;
>  	struct nand_chip nand;
> @@ -122,6 +125,7 @@ struct meson_nfc_nand_chip {
>  	u8 *data_buf;
>  	__le64 *info_buf;
>  	u32 nsels;
> +	u8 *oob_buf;
>  	u8 sels[];
>  };
> =20
> @@ -338,7 +342,7 @@ static u8 *meson_nfc_oob_ptr(struct nand_chip *nand, =
int i)
>  	struct meson_nfc_nand_chip *meson_chip =3D to_meson_nand(nand);
>  	int len;
> =20
> -	len =3D nand->ecc.size * (i + 1) + (nand->ecc.bytes + 2) * i;
> +	len =3D nand->ecc.size * (i + 1) + NFC_OOB_PER_ECC(nand) * i;

This...

> =20
>  	return meson_chip->data_buf + len;
>  }
> @@ -349,7 +353,7 @@ static u8 *meson_nfc_data_ptr(struct nand_chip *nand,=
 int i)
>  	int len, temp;
> =20
>  	temp =3D nand->ecc.size + nand->ecc.bytes;
> -	len =3D (temp + 2) * i;
> +	len =3D (temp + NFC_USER_BYTES) * i;

... and this (same below)

are purely cosmetic, should be in a patch aside.

> =20
>  	return meson_chip->data_buf + len;
>  }
> @@ -357,29 +361,47 @@ static u8 *meson_nfc_data_ptr(struct nand_chip *nan=
d, int i)
>  static void meson_nfc_get_data_oob(struct nand_chip *nand,
>  				   u8 *buf, u8 *oobbuf)
>  {
> +	struct meson_nfc_nand_chip *meson_chip =3D to_meson_nand(nand);
> +	struct mtd_info *mtd =3D nand_to_mtd(nand);
>  	int i, oob_len =3D 0;
>  	u8 *dsrc, *osrc;
> +	u8 *oobtail;
> =20
> -	oob_len =3D nand->ecc.bytes + 2;
> +	oob_len =3D NFC_OOB_PER_ECC(nand);
>  	for (i =3D 0; i < nand->ecc.steps; i++) {
>  		if (buf) {
>  			dsrc =3D meson_nfc_data_ptr(nand, i);
>  			memcpy(buf, dsrc, nand->ecc.size);
>  			buf +=3D nand->ecc.size;
>  		}
> -		osrc =3D meson_nfc_oob_ptr(nand, i);
> -		memcpy(oobbuf, osrc, oob_len);
> -		oobbuf +=3D oob_len;
> +
> +		if (oobbuf) {
> +			osrc =3D meson_nfc_oob_ptr(nand, i);
> +			memcpy(oobbuf, osrc, oob_len);
> +			oobbuf +=3D oob_len;
> +		}
>  	}
> +
> +	if (!oobbuf)
> +		return;

The whole "if (oobbuf)" logic is nice to have, but should as well be in
a dedicated patch.

> +
> +	oobtail =3D meson_chip->data_buf + nand->ecc.steps *
> +		  (nand->ecc.size + oob_len);
> +
> +	/* 'oobbuf' if already shifted to the start of unused area. */

		    is?
s/unused/user/? I'm not sure I get the comment.

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
> -	oob_len =3D nand->ecc.bytes + 2;
> +	oob_len =3D NFC_OOB_PER_ECC(nand);
>  	for (i =3D 0; i < nand->ecc.steps; i++) {
>  		if (buf) {
>  			dsrc =3D meson_nfc_data_ptr(nand, i);
> @@ -390,6 +412,12 @@ static void meson_nfc_set_data_oob(struct nand_chip =
*nand,
>  		memcpy(osrc, oobbuf, oob_len);
>  		oobbuf +=3D oob_len;
>  	}
> +
> +	oobtail =3D meson_chip->data_buf + nand->ecc.steps *
> +		  (nand->ecc.size + oob_len);
> +
> +	/* 'oobbuf' if already shifted to the start of unused area. */
> +	memcpy(oobtail, oobbuf, mtd->oobsize - nand->ecc.steps * oob_len);
>  }
> =20
>  static int meson_nfc_queue_rb(struct meson_nfc *nfc, int timeout_ms, int=
 cmd_read0)
> @@ -436,25 +464,12 @@ static void meson_nfc_set_user_byte(struct nand_chi=
p *nand, u8 *oob_buf)
>  {
>  	struct meson_nfc_nand_chip *meson_chip =3D to_meson_nand(nand);
>  	__le64 *info;
> -	int i, count;
> -
> -	for (i =3D 0, count =3D 0; i < nand->ecc.steps; i++, count +=3D 2) {
> -		info =3D &meson_chip->info_buf[i];
> -		*info |=3D oob_buf[count];
> -		*info |=3D oob_buf[count + 1] << 8;
> -	}
> -}
> -
> -static void meson_nfc_get_user_byte(struct nand_chip *nand, u8 *oob_buf)
> -{
> -	struct meson_nfc_nand_chip *meson_chip =3D to_meson_nand(nand);
> -	__le64 *info;
> -	int i, count;
> +	int i;
> =20
> -	for (i =3D 0, count =3D 0; i < nand->ecc.steps; i++, count +=3D 2) {
> +	for (i =3D 0; i < nand->ecc.steps; i++) {
>  		info =3D &meson_chip->info_buf[i];
> -		oob_buf[count] =3D *info;
> -		oob_buf[count + 1] =3D *info >> 8;
> +		/* Always ignore user bytes programming. */

Why?

Also, maybe I should mention the helpers:
mtd_ooblayout_get_eccbytes and co
They are very useful to deal with OOB bytes. Everything seems extremely
hardcoded in this driver, while the user can tune read/write OOB
operations.

> +		*info |=3D 0xffff;
>  	}
>  }
> =20
> @@ -698,18 +713,92 @@ static int meson_nfc_write_page_raw(struct nand_chi=
p *nand, const u8 *buf,
>  	return meson_nfc_write_page_sub(nand, page, 1);
>  }
> =20
> +static u32 meson_nfc_get_oob_bytes(struct nand_chip *nand)
> +{
> +	struct mtd_info *mtd =3D nand_to_mtd(nand);
> +
> +	return mtd->oobsize - nand->ecc.steps * NFC_OOB_PER_ECC(nand);
> +}
> +
> +static int __meson_nfc_write_oob(struct nand_chip *nand, int page, u8 *o=
ob_buf)
> +{
> +	struct meson_nfc_nand_chip *meson_chip =3D to_meson_nand(nand);
> +	struct mtd_info *mtd =3D nand_to_mtd(nand);
> +	u32 page_size =3D mtd->writesize + mtd->oobsize;
> +	u32 oob_bytes =3D meson_nfc_get_oob_bytes(nand);
> +	int ret;
> +
> +	if (!oob_bytes)
> +		return 0;
> +
> +	ret =3D nand_prog_page_begin_op(nand, page, 0, NULL, 0);
> +	if (ret)
> +		return ret;
> +
> +	memcpy(meson_chip->oob_buf, oob_buf + (mtd->oobsize - oob_bytes),
> +	       oob_bytes);
> +
> +	ret =3D nand_change_write_column_op(nand, page_size - oob_bytes,
> +					  meson_chip->oob_buf,
> +					  oob_bytes, false);
> +	if (ret)
> +		return ret;
> +
> +	return nand_prog_page_end_op(nand);
> +}
> +
> +static int __meson_nfc_read_oob(struct nand_chip *nand, int page,
> +				u8 *oob_buf)
> +{
> +	struct meson_nfc_nand_chip *meson_chip =3D to_meson_nand(nand);
> +	struct mtd_info *mtd =3D nand_to_mtd(nand);
> +	u32 oob_bytes;
> +	u32 page_size;
> +	int ret;
> +
> +	oob_bytes =3D meson_nfc_get_oob_bytes(nand);
> +
> +	if (!oob_bytes)
> +		return 0;
> +
> +	ret =3D nand_read_page_op(nand, page, 0, NULL, 0);
> +	if (ret)
> +		return ret;
> +
> +	page_size =3D mtd->writesize + mtd->oobsize;
> +
> +	ret =3D nand_change_read_column_op(nand, page_size - oob_bytes,
> +					 meson_chip->oob_buf,
> +					 oob_bytes, false);
> +
> +	if (!ret)
> +		memcpy(oob_buf + (mtd->oobsize - oob_bytes),
> +		       meson_chip->oob_buf,
> +		       oob_bytes);
> +
> +	return ret;
> +}
> +
>  static int meson_nfc_write_page_hwecc(struct nand_chip *nand,
>  				      const u8 *buf, int oob_required, int page)
>  {
>  	struct mtd_info *mtd =3D nand_to_mtd(nand);
>  	struct meson_nfc_nand_chip *meson_chip =3D to_meson_nand(nand);
>  	u8 *oob_buf =3D nand->oob_poi;
> +	int ret;
> =20
>  	memcpy(meson_chip->data_buf, buf, mtd->writesize);
>  	memset(meson_chip->info_buf, 0, nand->ecc.steps * PER_INFO_BYTE);
>  	meson_nfc_set_user_byte(nand, oob_buf);
> =20
> -	return meson_nfc_write_page_sub(nand, page, 0);
> +	ret =3D meson_nfc_write_page_sub(nand, page, 0);
> +	if (ret)
> +		return ret;
> +
> +	if (oob_required)
> +		ret =3D __meson_nfc_write_oob(nand, page, oob_buf);

You should provide all the data including OOB bytes in a single write
call, otherwise you perform two writes on the same page, that's not
what this helper is expected to do.

> +
> +	return ret;
>  }
> =20
>  static void meson_nfc_check_ecc_pages_valid(struct meson_nfc *nfc,
> @@ -783,7 +872,7 @@ static int meson_nfc_read_page_raw(struct nand_chip *=
nand, u8 *buf,
>  	if (ret)
>  		return ret;
> =20
> -	meson_nfc_get_data_oob(nand, buf, oob_buf);
> +	meson_nfc_get_data_oob(nand, buf, oob_required ? oob_buf : NULL);
> =20
>  	return 0;
>  }
> @@ -803,12 +892,12 @@ static int meson_nfc_read_page_hwecc(struct nand_ch=
ip *nand, u8 *buf,
>  	if (ret)
>  		return ret;
> =20
> -	meson_nfc_get_user_byte(nand, oob_buf);
>  	ret =3D meson_nfc_ecc_correct(nand, &bitflips, &correct_bitmap);
>  	if (ret =3D=3D ECC_CHECK_RETURN_FF) {
>  		if (buf)
>  			memset(buf, 0xff, mtd->writesize);
>  		memset(oob_buf, 0xff, mtd->oobsize);
> +		return bitflips;

That is something else =3D> other fix =3D> other patch?

>  	} else if (ret < 0) {
>  		if ((nand->options & NAND_NEED_SCRAMBLING) || !buf) {
>  			mtd->ecc_stats.failed++;
> @@ -820,12 +909,14 @@ static int meson_nfc_read_page_hwecc(struct nand_ch=
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
> @@ -839,17 +930,30 @@ static int meson_nfc_read_page_hwecc(struct nand_ch=
ip *nand, u8 *buf,
>  		memcpy(buf, meson_chip->data_buf, mtd->writesize);
>  	}
> =20
> +	if (oob_required)
> +		__meson_nfc_read_oob(nand, page, oob_buf);

In the standalone "read_oob" hook, you have to send a READ0 command,
but not when you are in the read_page hook. It is a big waste of time.

> +
>  	return bitflips;
>  }
> =20
>  static int meson_nfc_read_oob_raw(struct nand_chip *nand, int page)
>  {
> -	return meson_nfc_read_page_raw(nand, NULL, 1, page);
> +	return __meson_nfc_read_oob(nand, page, nand->oob_poi);
>  }
> =20
>  static int meson_nfc_read_oob(struct nand_chip *nand, int page)
>  {
> -	return meson_nfc_read_page_hwecc(nand, NULL, 1, page);
> +	return __meson_nfc_read_oob(nand, page, nand->oob_poi);
> +}
> +
> +static int meson_nfc_write_oob_raw(struct nand_chip *nand, int page)
> +{
> +	return __meson_nfc_write_oob(nand, page, nand->oob_poi);
> +}
> +
> +static int meson_nfc_write_oob(struct nand_chip *nand, int page)
> +{
> +	return __meson_nfc_write_oob(nand, page, nand->oob_poi);

Do we really need these indirections?

>  }
> =20
>  static bool meson_nfc_is_buffer_dma_safe(const void *buffer)
> @@ -982,7 +1086,7 @@ static int meson_ooblayout_ecc(struct mtd_info *mtd,=
 int section,
>  	if (section >=3D nand->ecc.steps)
>  		return -ERANGE;
> =20
> -	oobregion->offset =3D  2 + (section * (2 + nand->ecc.bytes));
> +	oobregion->offset =3D NFC_USER_BYTES + section * NFC_OOB_PER_ECC(nand);

The () are still needed around the '*'

>  	oobregion->length =3D nand->ecc.bytes;
> =20
>  	return 0;
> @@ -992,12 +1096,16 @@ static int meson_ooblayout_free(struct mtd_info *m=
td, int section,
>  				struct mtd_oob_region *oobregion)
>  {
>  	struct nand_chip *nand =3D mtd_to_nand(mtd);
> +	u32 oob_bytes =3D meson_nfc_get_oob_bytes(nand);
> =20
>  	if (section >=3D nand->ecc.steps)
>  		return -ERANGE;
> =20
> -	oobregion->offset =3D section * (2 + nand->ecc.bytes);
> -	oobregion->length =3D 2;
> +	/* Split rest of OOB area (not covered by ECC engine) per each
> +	 * ECC section. This will be OOB data available to user.
> +	 */
> +	oobregion->offset =3D (section + nand->ecc.steps) * NFC_OOB_PER_ECC(nan=
d);
> +	oobregion->length =3D oob_bytes / nand->ecc.steps;
> =20
>  	return 0;
>  }
> @@ -1184,6 +1292,9 @@ static int meson_nand_bch_mode(struct nand_chip *na=
nd)
> =20
>  static void meson_nand_detach_chip(struct nand_chip *nand)
>  {
> +	struct meson_nfc_nand_chip *meson_chip =3D to_meson_nand(nand);
> +
> +	kfree(meson_chip->oob_buf);
>  	meson_nfc_free_buffer(nand);
>  }
> =20
> @@ -1225,9 +1336,9 @@ static int meson_nand_attach_chip(struct nand_chip =
*nand)
>  	nand->ecc.engine_type =3D NAND_ECC_ENGINE_TYPE_ON_HOST;
>  	nand->ecc.write_page_raw =3D meson_nfc_write_page_raw;
>  	nand->ecc.write_page =3D meson_nfc_write_page_hwecc;
> -	nand->ecc.write_oob_raw =3D nand_write_oob_std;
> -	nand->ecc.write_oob =3D nand_write_oob_std;
> =20
> +	nand->ecc.write_oob_raw =3D meson_nfc_write_oob_raw;
> +	nand->ecc.write_oob =3D meson_nfc_write_oob;

Actually if you define the right OOB layouts, are these really needed
?? I would expect the right bytes to be picked up by the default
implementation. I see nothing specific in your current implementation?

>  	nand->ecc.read_page_raw =3D meson_nfc_read_page_raw;
>  	nand->ecc.read_page =3D meson_nfc_read_page_hwecc;
>  	nand->ecc.read_oob_raw =3D meson_nfc_read_oob_raw;
> @@ -1237,9 +1348,16 @@ static int meson_nand_attach_chip(struct nand_chip=
 *nand)
>  		dev_err(nfc->dev, "16bits bus width not supported");
>  		return -EINVAL;
>  	}
> +
> +	meson_chip->oob_buf =3D kmalloc(nand->ecc.bytes, GFP_KERNEL);

devm_kmalloc?

> +	if (!meson_chip->oob_buf)
> +		return -ENOMEM;
> +
>  	ret =3D meson_chip_buffer_init(nand);
> -	if (ret)
> +	if (ret) {
> +		kfree(meson_chip->oob_buf);
>  		return -ENOMEM;
> +	}
> =20
>  	return ret;
>  }


Thanks,
Miqu=C3=A8l
