Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8C58712B5A
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 19:04:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234888AbjEZRD6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 13:03:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbjEZRD4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 13:03:56 -0400
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::224])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE50DBC
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 10:03:53 -0700 (PDT)
X-GND-Sasl: miquel.raynal@bootlin.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1685120631;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wZAtIbKobVRsNsvxbSGu/98XFYPX6nWAdRcnWjHYmAc=;
        b=DWnWEw34M1++02P5eZv/kDxy9QYvXm7LFXTl0Cx9V9dF/KkiP9Q0z6vGT76rIgZuftGwtd
        soy8mqDa3fYzHl8BhtYghInOVmxbGJaWgtdFCuduC3UYks0rBIBk2Ow3U9lV9JZGN091bR
        OnRNB2eOTcssbygDV0LzJduArd/TflIb2T2bcGEbUli9kT9dL8TzrSxjZEgHs0kg4AdXrH
        ++NaOl9zOjA3Ep9ijnE8mm7ZwI1m85f6JaX+U8WKeGqmD2D/9J+m83Wu6CQ4FKxdmRdZ2h
        BVluWATk1+PduKzVekVvELsVvTs2i3bQp28gmXSq4I8+OJ+NBb8K6/2vLKTeEg==
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
Received: by mail.gandi.net (Postfix) with ESMTPSA id 112E1E0005;
        Fri, 26 May 2023 17:03:48 +0000 (UTC)
Date:   Fri, 26 May 2023 19:03:47 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Arseniy Krasnov <avkrasnov@sberdevices.ru>
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
Message-ID: <20230526190347.6e34a2be@xps-13>
In-Reply-To: <ebbc26e3-6a1c-eead-051c-8f93beba41f3@sberdevices.ru>
References: <20230515094440.3552094-1-AVKrasnov@sberdevices.ru>
        <20230515094440.3552094-3-AVKrasnov@sberdevices.ru>
        <20230522173334.7aa6f917@xps-13>
        <ebbc26e3-6a1c-eead-051c-8f93beba41f3@sberdevices.ru>
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

avkrasnov@sberdevices.ru wrote on Tue, 23 May 2023 20:17:14 +0300:

> Hello Miquel! Thanks for detailed review!
>=20
> On 22.05.2023 18:33, Miquel Raynal wrote:
> > Hi Arseniy,
> >=20
> > AVKrasnov@sberdevices.ru wrote on Mon, 15 May 2023 12:44:36 +0300:
> >=20
> > The title should perhaps be "only expose unprotected user OOB bytes".
> >  =20
> >> This moves free bytes of OOB to non-protected ECC area. It is needed to
> >> make JFFS2 works correctly with this NAND controller. Problem fires wh=
en
> >> JFFS2 driver writes cleanmarker to some page and later it tries to wri=
te
> >> to this page - write will be done successfully, but after that such pa=
ge
> >> becomes unreadable due to invalid ECC codes. This happens because seco=
nd
> >> write needs to update ECC codes, but it is impossible to do it correct=
ly
> >> without block erase. So idea of this patch is to =20
> >=20
> > "... is to use the unprotected OOB area to store the cleanmarkers, so
> > that they can be written by the filesystem without caring much about
> > the page being empty or not: the ECC codes will not be written anyway."
> > ? =20
>=20
> Ok
>=20
> >=20
> > JFFS2 is only useful on tiny NAND devices, where UBI does not fit,
> > which are usually true SLC flashes, with the capability of writing
> > a page with empty (0xFF) data, and still be able to write actual data
> > to it later in a second write. =20
>=20
> You mean to include text above to commit message also?

Yes, I believe this deserves to be in the commit message as well :)

>=20
> >  =20
> >> split accesses to OOB
> >> free bytes and data on each page - now both of them does not depends on
> >> each other.
> >>
> >> Signed-off-by: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
> >> ---
> >>  drivers/mtd/nand/raw/meson_nand.c | 192 ++++++++++++++++++++++++------
> >>  1 file changed, 155 insertions(+), 37 deletions(-)
> >>
> >> diff --git a/drivers/mtd/nand/raw/meson_nand.c b/drivers/mtd/nand/raw/=
meson_nand.c
> >> index 2f4d8c84186b..8526a6b87720 100644
> >> --- a/drivers/mtd/nand/raw/meson_nand.c
> >> +++ b/drivers/mtd/nand/raw/meson_nand.c
> >> @@ -108,6 +108,9 @@
> >> =20
> >>  #define PER_INFO_BYTE		8
> >> =20
> >> +#define NFC_USER_BYTES		2
> >> +#define NFC_OOB_PER_ECC(nand)	((nand)->ecc.bytes + NFC_USER_BYTES)
> >> +
> >>  struct meson_nfc_nand_chip {
> >>  	struct list_head node;
> >>  	struct nand_chip nand;
> >> @@ -122,6 +125,7 @@ struct meson_nfc_nand_chip {
> >>  	u8 *data_buf;
> >>  	__le64 *info_buf;
> >>  	u32 nsels;
> >> +	u8 *oob_buf;
> >>  	u8 sels[];
> >>  };
> >> =20
> >> @@ -338,7 +342,7 @@ static u8 *meson_nfc_oob_ptr(struct nand_chip *nan=
d, int i)
> >>  	struct meson_nfc_nand_chip *meson_chip =3D to_meson_nand(nand);
> >>  	int len;
> >> =20
> >> -	len =3D nand->ecc.size * (i + 1) + (nand->ecc.bytes + 2) * i;
> >> +	len =3D nand->ecc.size * (i + 1) + NFC_OOB_PER_ECC(nand) * i; =20
> >=20
> > This...
> >  =20
> >> =20
> >>  	return meson_chip->data_buf + len;
> >>  }
> >> @@ -349,7 +353,7 @@ static u8 *meson_nfc_data_ptr(struct nand_chip *na=
nd, int i)
> >>  	int len, temp;
> >> =20
> >>  	temp =3D nand->ecc.size + nand->ecc.bytes;
> >> -	len =3D (temp + 2) * i;
> >> +	len =3D (temp + NFC_USER_BYTES) * i; =20
> >=20
> > ... and this (same below)
> >=20
> > are purely cosmetic, should be in a patch aside.
> >  =20
>=20
> Ack, i'll move cosmetic updates to separate patch.
>=20
> >> =20
> >>  	return meson_chip->data_buf + len;
> >>  }
> >> @@ -357,29 +361,47 @@ static u8 *meson_nfc_data_ptr(struct nand_chip *=
nand, int i)
> >>  static void meson_nfc_get_data_oob(struct nand_chip *nand,
> >>  				   u8 *buf, u8 *oobbuf)
> >>  {
> >> +	struct meson_nfc_nand_chip *meson_chip =3D to_meson_nand(nand);
> >> +	struct mtd_info *mtd =3D nand_to_mtd(nand);
> >>  	int i, oob_len =3D 0;
> >>  	u8 *dsrc, *osrc;
> >> +	u8 *oobtail;
> >> =20
> >> -	oob_len =3D nand->ecc.bytes + 2;
> >> +	oob_len =3D NFC_OOB_PER_ECC(nand);
> >>  	for (i =3D 0; i < nand->ecc.steps; i++) {
> >>  		if (buf) {
> >>  			dsrc =3D meson_nfc_data_ptr(nand, i);
> >>  			memcpy(buf, dsrc, nand->ecc.size);
> >>  			buf +=3D nand->ecc.size;
> >>  		}
> >> -		osrc =3D meson_nfc_oob_ptr(nand, i);
> >> -		memcpy(oobbuf, osrc, oob_len);
> >> -		oobbuf +=3D oob_len;
> >> +
> >> +		if (oobbuf) {
> >> +			osrc =3D meson_nfc_oob_ptr(nand, i);
> >> +			memcpy(oobbuf, osrc, oob_len);
> >> +			oobbuf +=3D oob_len;
> >> +		}
> >>  	}
> >> +
> >> +	if (!oobbuf)
> >> +		return; =20
> >=20
> > The whole "if (oobbuf)" logic is nice to have, but should as well be in
> > a dedicated patch. =20
>=20
> Sorry, You mean that this logic implements read of ECC codes? And not
> related to OOB layout update in this patch?

You need to make cosmetic changes in a first patch (or even in several
patches if they are not related), then in another patch you might make
additions like a better handling of the OOB, and any change in the
layout might come last. I just want to split the patch to make
understandable atomic changes (also easier to review).

1 atomic change =3D=3D 1 patch

> >  =20
> >> +
> >> +	oobtail =3D meson_chip->data_buf + nand->ecc.steps *
> >> +		  (nand->ecc.size + oob_len);
> >> +
> >> +	/* 'oobbuf' if already shifted to the start of unused area. */ =20
> >=20
> > 		    is?
> > s/unused/user/? I'm not sure I get the comment. =20
>=20
> Yes, not clear comment.
>=20
> >  =20
> >> +	memcpy(oobbuf, oobtail, mtd->oobsize - nand->ecc.steps * oob_len);
> >>  }
> >> =20
> >>  static void meson_nfc_set_data_oob(struct nand_chip *nand,
> >>  				   const u8 *buf, u8 *oobbuf)
> >>  {
> >> +	struct meson_nfc_nand_chip *meson_chip =3D to_meson_nand(nand);
> >> +	struct mtd_info *mtd =3D nand_to_mtd(nand);
> >>  	int i, oob_len =3D 0;
> >>  	u8 *dsrc, *osrc;
> >> +	u8 *oobtail;
> >> =20
> >> -	oob_len =3D nand->ecc.bytes + 2;
> >> +	oob_len =3D NFC_OOB_PER_ECC(nand);
> >>  	for (i =3D 0; i < nand->ecc.steps; i++) {
> >>  		if (buf) {
> >>  			dsrc =3D meson_nfc_data_ptr(nand, i);
> >> @@ -390,6 +412,12 @@ static void meson_nfc_set_data_oob(struct nand_ch=
ip *nand,
> >>  		memcpy(osrc, oobbuf, oob_len);
> >>  		oobbuf +=3D oob_len;
> >>  	}
> >> +
> >> +	oobtail =3D meson_chip->data_buf + nand->ecc.steps *
> >> +		  (nand->ecc.size + oob_len);
> >> +
> >> +	/* 'oobbuf' if already shifted to the start of unused area. */
> >> +	memcpy(oobtail, oobbuf, mtd->oobsize - nand->ecc.steps * oob_len);
> >>  }
> >> =20
> >>  static int meson_nfc_queue_rb(struct meson_nfc *nfc, int timeout_ms, =
int cmd_read0)
> >> @@ -436,25 +464,12 @@ static void meson_nfc_set_user_byte(struct nand_=
chip *nand, u8 *oob_buf)
> >>  {
> >>  	struct meson_nfc_nand_chip *meson_chip =3D to_meson_nand(nand);
> >>  	__le64 *info;
> >> -	int i, count;
> >> -
> >> -	for (i =3D 0, count =3D 0; i < nand->ecc.steps; i++, count +=3D 2) {
> >> -		info =3D &meson_chip->info_buf[i];
> >> -		*info |=3D oob_buf[count];
> >> -		*info |=3D oob_buf[count + 1] << 8;
> >> -	}
> >> -}
> >> -
> >> -static void meson_nfc_get_user_byte(struct nand_chip *nand, u8 *oob_b=
uf)
> >> -{
> >> -	struct meson_nfc_nand_chip *meson_chip =3D to_meson_nand(nand);
> >> -	__le64 *info;
> >> -	int i, count;
> >> +	int i;
> >> =20
> >> -	for (i =3D 0, count =3D 0; i < nand->ecc.steps; i++, count +=3D 2) {
> >> +	for (i =3D 0; i < nand->ecc.steps; i++) {
> >>  		info =3D &meson_chip->info_buf[i];
> >> -		oob_buf[count] =3D *info;
> >> -		oob_buf[count + 1] =3D *info >> 8;
> >> +		/* Always ignore user bytes programming. */ =20
> >=20
> > Why? =20
>=20
> I think comment message is wrong a little bit. Here "user bytes" are
> user bytes protected by ECC (e.g. location of these bytes differs from new
> OOB layout introduced by this patch). During page write this hardware
> always writes these bytes along with data. But, new OOB layout always ign=
ores
> these 4 bytes, so set them to 0xFF always.

When performing page reads/writes, you need to take the data as it's
been provided. You may move the data around in the buffer provided to
the controller, so that it get the ECC data at the right location, and
you need of course to reorganize the data when reading as well, so that
the user sees XkiB of data + YB of OOB. That's all you need to do in
these helpers.

> > Also, maybe I should mention the helpers:
> > mtd_ooblayout_get_eccbytes and co
> > They are very useful to deal with OOB bytes. Everything seems extremely
> > hardcoded in this driver, while the user can tune read/write OOB
> > operations. =20
>=20
> Thanks for details, IIUC these helpers will work correctly with this driv=
er.
> What means "tune" here?

The user can provide data for the OOB part and tell the mtd layer to
place the bytes in the ->oob_buf following different constraints:
- the user bytes are already when they need to be (MTD_OPS_PLACE_OOB
  and MTD_OPS_RAW)
- the user bytes are packed at the beginning of the buffer, please move
  them where they belong (MTD_OPS_AUTO_OOB).

So in the controller driver, what needs to be done is to make the
switch between the "data1+data2+oob1+oob2" layout into your
ECC controller's layout, eg "data1+oob1+data2+oob2".

Hence you should not need anything like that:
> >> +		*info |=3D 0xffff;

> >>  	}
> >>  }
> >> =20
> >> @@ -698,18 +713,92 @@ static int meson_nfc_write_page_raw(struct nand_=
chip *nand, const u8 *buf,
> >>  	return meson_nfc_write_page_sub(nand, page, 1);
> >>  }
> >> =20
> >> +static u32 meson_nfc_get_oob_bytes(struct nand_chip *nand)
> >> +{
> >> +	struct mtd_info *mtd =3D nand_to_mtd(nand);
> >> +
> >> +	return mtd->oobsize - nand->ecc.steps * NFC_OOB_PER_ECC(nand);
> >> +}
> >> +
> >> +static int __meson_nfc_write_oob(struct nand_chip *nand, int page, u8=
 *oob_buf)
> >> +{
> >> +	struct meson_nfc_nand_chip *meson_chip =3D to_meson_nand(nand);
> >> +	struct mtd_info *mtd =3D nand_to_mtd(nand);
> >> +	u32 page_size =3D mtd->writesize + mtd->oobsize;
> >> +	u32 oob_bytes =3D meson_nfc_get_oob_bytes(nand);
> >> +	int ret;
> >> +
> >> +	if (!oob_bytes)
> >> +		return 0;
> >> +
> >> +	ret =3D nand_prog_page_begin_op(nand, page, 0, NULL, 0);
> >> +	if (ret)
> >> +		return ret;
> >> +
> >> +	memcpy(meson_chip->oob_buf, oob_buf + (mtd->oobsize - oob_bytes),
> >> +	       oob_bytes);
> >> +
> >> +	ret =3D nand_change_write_column_op(nand, page_size - oob_bytes,
> >> +					  meson_chip->oob_buf,
> >> +					  oob_bytes, false);
> >> +	if (ret)
> >> +		return ret;
> >> +
> >> +	return nand_prog_page_end_op(nand);
> >> +}
> >> +
> >> +static int __meson_nfc_read_oob(struct nand_chip *nand, int page,
> >> +				u8 *oob_buf)
> >> +{
> >> +	struct meson_nfc_nand_chip *meson_chip =3D to_meson_nand(nand);
> >> +	struct mtd_info *mtd =3D nand_to_mtd(nand);
> >> +	u32 oob_bytes;
> >> +	u32 page_size;
> >> +	int ret;
> >> +
> >> +	oob_bytes =3D meson_nfc_get_oob_bytes(nand);
> >> +
> >> +	if (!oob_bytes)
> >> +		return 0;
> >> +
> >> +	ret =3D nand_read_page_op(nand, page, 0, NULL, 0);
> >> +	if (ret)
> >> +		return ret;
> >> +
> >> +	page_size =3D mtd->writesize + mtd->oobsize;
> >> +
> >> +	ret =3D nand_change_read_column_op(nand, page_size - oob_bytes,
> >> +					 meson_chip->oob_buf,
> >> +					 oob_bytes, false);
> >> +
> >> +	if (!ret)
> >> +		memcpy(oob_buf + (mtd->oobsize - oob_bytes),
> >> +		       meson_chip->oob_buf,
> >> +		       oob_bytes);
> >> +
> >> +	return ret;
> >> +}
> >> +
> >>  static int meson_nfc_write_page_hwecc(struct nand_chip *nand,
> >>  				      const u8 *buf, int oob_required, int page)
> >>  {
> >>  	struct mtd_info *mtd =3D nand_to_mtd(nand);
> >>  	struct meson_nfc_nand_chip *meson_chip =3D to_meson_nand(nand);
> >>  	u8 *oob_buf =3D nand->oob_poi;
> >> +	int ret;
> >> =20
> >>  	memcpy(meson_chip->data_buf, buf, mtd->writesize);
> >>  	memset(meson_chip->info_buf, 0, nand->ecc.steps * PER_INFO_BYTE);
> >>  	meson_nfc_set_user_byte(nand, oob_buf);
> >> =20
> >> -	return meson_nfc_write_page_sub(nand, page, 0);
> >> +	ret =3D meson_nfc_write_page_sub(nand, page, 0);
> >> +	if (ret)
> >> +		return ret;
> >> +
> >> +	if (oob_required)
> >> +		ret =3D __meson_nfc_write_oob(nand, page, oob_buf); =20
> >=20
> > You should provide all the data including OOB bytes in a single write
> > call, otherwise you perform two writes on the same page, that's not
> > what this helper is expected to do. =20
>=20
> I see, so I need to check 'oob_required' here before programming page dat=
a?

Yes!

> If it is set -> place OOB data to DMA buffer and then call PAGEPROG once?

Exactly.

>=20
> >  =20
> >> +
> >> +	return ret;
> >>  }
> >> =20
> >>  static void meson_nfc_check_ecc_pages_valid(struct meson_nfc *nfc,
> >> @@ -783,7 +872,7 @@ static int meson_nfc_read_page_raw(struct nand_chi=
p *nand, u8 *buf,
> >>  	if (ret)
> >>  		return ret;
> >> =20
> >> -	meson_nfc_get_data_oob(nand, buf, oob_buf);
> >> +	meson_nfc_get_data_oob(nand, buf, oob_required ? oob_buf : NULL);
> >> =20
> >>  	return 0;
> >>  }
> >> @@ -803,12 +892,12 @@ static int meson_nfc_read_page_hwecc(struct nand=
_chip *nand, u8 *buf,
> >>  	if (ret)
> >>  		return ret;
> >> =20
> >> -	meson_nfc_get_user_byte(nand, oob_buf);
> >>  	ret =3D meson_nfc_ecc_correct(nand, &bitflips, &correct_bitmap);
> >>  	if (ret =3D=3D ECC_CHECK_RETURN_FF) {
> >>  		if (buf)
> >>  			memset(buf, 0xff, mtd->writesize);
> >>  		memset(oob_buf, 0xff, mtd->oobsize);
> >> +		return bitflips; =20
> >=20
> > That is something else =3D> other fix =3D> other patch? =20
>=20
> Idea of this 'return' is that when read fails, we return from this functi=
on
> without reading OOB below.

It seemed like the "return bitflips" thing was new, if it's just due to
the diff not being wide enough, then it's fine, otherwise if this is
something new, it should be in a dedicated patch.

>=20
> >  =20
> >>  	} else if (ret < 0) {
> >>  		if ((nand->options & NAND_NEED_SCRAMBLING) || !buf) {
> >>  			mtd->ecc_stats.failed++;
> >> @@ -820,12 +909,14 @@ static int meson_nfc_read_page_hwecc(struct nand=
_chip *nand, u8 *buf,
> >> =20
> >>  		for (i =3D 0; i < nand->ecc.steps ; i++) {
> >>  			u8 *data =3D buf + i * ecc->size;
> >> -			u8 *oob =3D nand->oob_poi + i * (ecc->bytes + 2);
> >> +			u8 *oob =3D nand->oob_poi + i * NFC_OOB_PER_ECC(nand);
> >> =20
> >>  			if (correct_bitmap & BIT_ULL(i))
> >>  				continue;
> >> +
> >>  			ret =3D nand_check_erased_ecc_chunk(data,	ecc->size,
> >> -							  oob, ecc->bytes + 2,
> >> +							  oob,
> >> +							  NFC_OOB_PER_ECC(nand),
> >>  							  NULL, 0,
> >>  							  ecc->strength);
> >>  			if (ret < 0) {
> >> @@ -839,17 +930,30 @@ static int meson_nfc_read_page_hwecc(struct nand=
_chip *nand, u8 *buf,
> >>  		memcpy(buf, meson_chip->data_buf, mtd->writesize);
> >>  	}
> >> =20
> >> +	if (oob_required)
> >> +		__meson_nfc_read_oob(nand, page, oob_buf); =20
> >=20
> > In the standalone "read_oob" hook, you have to send a READ0 command,
> > but not when you are in the read_page hook. It is a big waste of time. =
=20
>=20
> IIUC approach here must be exactly the same as in write? E.g. i need to
> send single READ0 and then fill provided OOB buffer if needed?

Yes.

For both reads and writes, the logic is:
- there are commands which are actually time consuming: there is
  something happening on the nand array which either reads or writes
  data to/from the internal sram.
- there are other commands which just change the "pointer" in the
  internal sram.

So you can basically say "I want to write into the sram at offset X,
then at offset Y" and when the sram has been filled you can commit the
write and that's the operation which should happen only once. In the
read path it's the opposite, you request a read from the NAND array into
the sram cache, and you can then request data randomly. Of course both
operations cannot be too random either, you need to follow the ECC
engine pattern which must be fed with X bytes of data and then will
produce the ECC bytes to write/compare.

>=20
> >  =20
> >> +
> >>  	return bitflips;
> >>  }
> >> =20
> >>  static int meson_nfc_read_oob_raw(struct nand_chip *nand, int page)
> >>  {
> >> -	return meson_nfc_read_page_raw(nand, NULL, 1, page);
> >> +	return __meson_nfc_read_oob(nand, page, nand->oob_poi);
> >>  }
> >> =20
> >>  static int meson_nfc_read_oob(struct nand_chip *nand, int page)
> >>  {
> >> -	return meson_nfc_read_page_hwecc(nand, NULL, 1, page);
> >> +	return __meson_nfc_read_oob(nand, page, nand->oob_poi);
> >> +}
> >> +
> >> +static int meson_nfc_write_oob_raw(struct nand_chip *nand, int page)
> >> +{
> >> +	return __meson_nfc_write_oob(nand, page, nand->oob_poi);
> >> +}
> >> +
> >> +static int meson_nfc_write_oob(struct nand_chip *nand, int page)
> >> +{
> >> +	return __meson_nfc_write_oob(nand, page, nand->oob_poi); =20
> >=20
> > Do we really need these indirections? =20
>=20
> Right, I think I can use only one function for OOB write in both ECC and =
raw modes.
>=20
> >  =20
> >>  }
> >> =20
> >>  static bool meson_nfc_is_buffer_dma_safe(const void *buffer)
> >> @@ -982,7 +1086,7 @@ static int meson_ooblayout_ecc(struct mtd_info *m=
td, int section,
> >>  	if (section >=3D nand->ecc.steps)
> >>  		return -ERANGE;
> >> =20
> >> -	oobregion->offset =3D  2 + (section * (2 + nand->ecc.bytes));
> >> +	oobregion->offset =3D NFC_USER_BYTES + section * NFC_OOB_PER_ECC(nan=
d); =20
> >=20
> > The () are still needed around the '*'
> >  =20
> >>  	oobregion->length =3D nand->ecc.bytes;
> >> =20
> >>  	return 0;
> >> @@ -992,12 +1096,16 @@ static int meson_ooblayout_free(struct mtd_info=
 *mtd, int section,
> >>  				struct mtd_oob_region *oobregion)
> >>  {
> >>  	struct nand_chip *nand =3D mtd_to_nand(mtd);
> >> +	u32 oob_bytes =3D meson_nfc_get_oob_bytes(nand);
> >> =20
> >>  	if (section >=3D nand->ecc.steps)
> >>  		return -ERANGE;
> >> =20
> >> -	oobregion->offset =3D section * (2 + nand->ecc.bytes);
> >> -	oobregion->length =3D 2;
> >> +	/* Split rest of OOB area (not covered by ECC engine) per each
> >> +	 * ECC section. This will be OOB data available to user.
> >> +	 */
> >> +	oobregion->offset =3D (section + nand->ecc.steps) * NFC_OOB_PER_ECC(=
nand);
> >> +	oobregion->length =3D oob_bytes / nand->ecc.steps;
> >> =20
> >>  	return 0;
> >>  }
> >> @@ -1184,6 +1292,9 @@ static int meson_nand_bch_mode(struct nand_chip =
*nand)
> >> =20
> >>  static void meson_nand_detach_chip(struct nand_chip *nand)
> >>  {
> >> +	struct meson_nfc_nand_chip *meson_chip =3D to_meson_nand(nand);
> >> +
> >> +	kfree(meson_chip->oob_buf);
> >>  	meson_nfc_free_buffer(nand);
> >>  }
> >> =20
> >> @@ -1225,9 +1336,9 @@ static int meson_nand_attach_chip(struct nand_ch=
ip *nand)
> >>  	nand->ecc.engine_type =3D NAND_ECC_ENGINE_TYPE_ON_HOST;
> >>  	nand->ecc.write_page_raw =3D meson_nfc_write_page_raw;
> >>  	nand->ecc.write_page =3D meson_nfc_write_page_hwecc;
> >> -	nand->ecc.write_oob_raw =3D nand_write_oob_std;
> >> -	nand->ecc.write_oob =3D nand_write_oob_std;
> >> =20
> >> +	nand->ecc.write_oob_raw =3D meson_nfc_write_oob_raw;
> >> +	nand->ecc.write_oob =3D meson_nfc_write_oob; =20
> >=20
> > Actually if you define the right OOB layouts, are these really needed
> > ?? I would expect the right bytes to be picked up by the default
> > implementation. I see nothing specific in your current implementation? =
=20
>=20
> You mean to use 'nand_write_oob_std()'? If so, I think it won't work,
> because it tries to write OOB data right after 'mtd->writesize', but
> page layout for this controller is like this:
> [       1024 bytes of data        ]
> [ 14 bytes ECC + 2 bytes for user ] <- with new layout we don't touch the=
se 2 bytes
> [       1024 bytes of data        ]
> [ 14 bytes ECC + 2 bytes for user ] <- with new layout we don't touch the=
se 2 bytes
> [      32 bytes of user bytes     ] <- we use there 32 bytes as free(user=
) bytes in OOB

Right.

>=20
> So with 'mtd->writesize' of 2048 we won't get into last 32 bytes in the p=
icture above.
> I'm not goot in NAND/MTD area, but I think that why i need special OOB ac=
cess callbacks.

Ok.

> Also in previous patches @Liang said, that default OOB read/write functio=
ns won't work
> on this controller and it is wrong to use them in currently merged driver.
>=20
> >  =20
> >>  	nand->ecc.read_page_raw =3D meson_nfc_read_page_raw;
> >>  	nand->ecc.read_page =3D meson_nfc_read_page_hwecc;
> >>  	nand->ecc.read_oob_raw =3D meson_nfc_read_oob_raw;
> >> @@ -1237,9 +1348,16 @@ static int meson_nand_attach_chip(struct nand_c=
hip *nand)
> >>  		dev_err(nfc->dev, "16bits bus width not supported");
> >>  		return -EINVAL;
> >>  	}
> >> +
> >> +	meson_chip->oob_buf =3D kmalloc(nand->ecc.bytes, GFP_KERNEL); =20
> >=20
> > devm_kmalloc? =20
>=20
> Ack
>=20
> >  =20
> >> +	if (!meson_chip->oob_buf)
> >> +		return -ENOMEM;
> >> +
> >>  	ret =3D meson_chip_buffer_init(nand);
> >> -	if (ret)
> >> +	if (ret) {
> >> +		kfree(meson_chip->oob_buf);
> >>  		return -ENOMEM;
> >> +	}
> >> =20
> >>  	return ret;
> >>  } =20
> >=20
> >=20
> > Thanks,
> > Miqu=C3=A8l =20
>=20
> Thanks, Arseniy


Thanks,
Miqu=C3=A8l
