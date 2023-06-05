Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51CBC722290
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 11:49:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230368AbjFEJtA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 05:49:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229815AbjFEJs6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 05:48:58 -0400
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F082CBD
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jun 2023 02:48:54 -0700 (PDT)
X-GND-Sasl: miquel.raynal@bootlin.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1685958533;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ohIP4UENYaF4STUtOvq2eetQpzHXBV2udweqWvPJ+y0=;
        b=lL8yRGXWiBjV9d9tKXjSd9EI1oR1rW3+VJIAeF3PVVph9jcn2a7EVfs5pFmWARqTdJbor8
        RpB5iLSpx+s1WXb93X+vpV7d6PuF+xlxw3Rw3LMY4R8Oz5cM4XzowyteUDrjicHAMXnU4w
        4p3Qcdg8oc+tJZa6q8c4yZkvEDUxr0FRZhI6l/qzXRE+j5sJALXle4a6GClNZVaU8BXAVS
        3hXnHRRgAalwEZQTr5nW3gJH8vwgT/voar7MPbQcWsHy+TTb24F98niqbDBi+AeYj7JAtB
        xcx1A6+2DJ9KATSNXUCn3zU9MgG5c8mlzBJ0Gq2oGvjBmqVcwls93PiedkyHmA==
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
Received: by mail.gandi.net (Postfix) with ESMTPSA id C307960018;
        Mon,  5 Jun 2023 09:48:51 +0000 (UTC)
Date:   Mon, 5 Jun 2023 11:48:50 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Arseniy Krasnov <avkrasnov@sberdevices.ru>
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
Message-ID: <20230605114850.77cf9197@xps-13>
In-Reply-To: <8242530c-7b6b-29ce-581b-c5644a965b60@sberdevices.ru>
References: <20230601061850.3907800-1-AVKrasnov@sberdevices.ru>
        <20230601061850.3907800-4-AVKrasnov@sberdevices.ru>
        <20230601103111.6840acc0@xps-13>
        <8242530c-7b6b-29ce-581b-c5644a965b60@sberdevices.ru>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arseniy,

avkrasnov@sberdevices.ru wrote on Fri, 2 Jun 2023 11:53:47 +0300:

> Hello Miquel, thanks for review!
>=20
> On 01.06.2023 11:31, Miquel Raynal wrote:
> > Hi Arseniy,
> >=20
> > AVKrasnov@sberdevices.ru wrote on Thu, 1 Jun 2023 09:18:46 +0300:
> >  =20
> >> This moves free bytes of OOB to non-protected ECC area. It is needed t=
o =20
> >=20
> > As we discussed, I expect this commit to just change the OOB layout to
> > expose unprotected OOB bytes to the user, that is the only change this
> > commit should carry. If that does not work, you should add a
> > preparation patch. =20
>=20
> Ok, but I thought, if i change only OOB layout, e.g. update 'free' callba=
ck of
> mtd_ooblayout_ops, I also need to implement code which performs read/write
> according new layout (it must be done in a single patch)?

No, this is orthogonal.

The driver must read the the whole OOB area (and perhaps reorder the
data), but you should not make any decision regarding what bytes you
want or not want to expose.

Then, the user (no matter what "user" is here) will decide how to deal
with the data.

> Main thing is:
>=20
> I guess that general confuse with this patch is that You consider
> that we change only OOB layout by moving user bytes out of ECC area, but =
at the same
> time I also increased size of OOB from 4 bytes (e.g. 2 x 2 bytes clean ma=
rkers)
> to 32 bytes (e.g. tail of page after data and ECC codes), so if this
> assumption is correct, in the next version I won't change size of user ar=
ea in
> OOB, thus this patch will be reduced as some comments from this review.

Exposing only 4 bytes was a mistake in the first place, please fix this
in a dedicated patch.

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
> >> without block erase. So idea of this patch is to use the unprotected O=
OB
> >> area to store the cleanmarkers, so that they can be written by the
> >> filesystem without caring much about the page being empty or not: the
> >> ECC codes will not be written anyway.
> >>
> >> JFFS2 is only useful on tiny NAND devices, where UBI does not fit, whi=
ch
> >> are usually true SLC flashes, with the capability of writing a page wi=
th
> >> empty (0xFF) data, and still be able to write actual data to it later =
in
> >> a second write.
> >>
> >> Signed-off-by: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
> >> ---
> >>  Changelog v4->v5:
> >>  * Drop cosmetic changes from this patch.
> >>  * Do not ignore ECC protected user bytes provided by hw. Even these
> >>    bytes are out of user area of OOB, its values are still read from
> >>    the provided OOB buffer and written by hardware. Same behaviour is
> >>    preserved for read access - such bytes are read from DMA buffer and
> >>    placed to OOB buffer.
> >>  * OOB read and write become more lightweight because I removed heavy
> >>    READ0 and PAGEPROG command from it (both commands are still sent
> >>    when OOB access is performed using OOB callbacks). In case of page
> >>    read/write OOB data is handled in the internal SRAM of the controll=
er.
> >>  * Commit message updated.
> >>  * Temporary buffer for OOB read/write is removed. Seems everything
> >>    works correctly without it.
> >>
> >>  drivers/mtd/nand/raw/meson_nand.c | 134 ++++++++++++++++++++++++++----
> >>  1 file changed, 117 insertions(+), 17 deletions(-)
> >>
> >> diff --git a/drivers/mtd/nand/raw/meson_nand.c b/drivers/mtd/nand/raw/=
meson_nand.c
> >> index 82a629025adc..e42c28be02f3 100644
> >> --- a/drivers/mtd/nand/raw/meson_nand.c
> >> +++ b/drivers/mtd/nand/raw/meson_nand.c
> >> @@ -358,8 +358,11 @@ static u8 *meson_nfc_data_ptr(struct nand_chip *n=
and, int i)
> >>  static void meson_nfc_get_data_oob(struct nand_chip *nand,
> >>  				   u8 *buf, u8 *oobbuf)
> >>  {
> >> +	struct meson_nfc_nand_chip *meson_chip =3D to_meson_nand(nand);
> >> +	struct mtd_info *mtd =3D nand_to_mtd(nand);
> >>  	int i, oob_len =3D 0;
> >>  	u8 *dsrc, *osrc;
> >> +	u8 *oobtail;
> >> =20
> >>  	oob_len =3D nand->ecc.bytes + 2;
> >>  	for (i =3D 0; i < nand->ecc.steps; i++) {
> >> @@ -368,17 +371,27 @@ static void meson_nfc_get_data_oob(struct nand_c=
hip *nand,
> >>  			memcpy(buf, dsrc, nand->ecc.size);
> >>  			buf +=3D nand->ecc.size;
> >>  		}
> >> +
> >>  		osrc =3D meson_nfc_oob_ptr(nand, i);
> >>  		memcpy(oobbuf, osrc, oob_len);
> >>  		oobbuf +=3D oob_len;
> >>  	}
> >> +
> >> +	oobtail =3D meson_chip->data_buf + nand->ecc.steps *
> >> +		  (nand->ecc.size + oob_len);
> >> +
> >> +	/* 'oobbuf' points to the start of user area. */
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
> >>  	oob_len =3D nand->ecc.bytes + 2;
> >>  	for (i =3D 0; i < nand->ecc.steps; i++) {
> >> @@ -391,6 +404,12 @@ static void meson_nfc_set_data_oob(struct nand_ch=
ip *nand,
> >>  		memcpy(osrc, oobbuf, oob_len);
> >>  		oobbuf +=3D oob_len;
> >>  	}
> >> +
> >> +	oobtail =3D meson_chip->data_buf + nand->ecc.steps *
> >> +		  (nand->ecc.size + oob_len); =20
> >=20
> > This is always targeting the same area, so it looks strange to me.
> >  =20
> >> +
> >> +	/* 'oobbuf' points to the start of user area. */
> >> +	memcpy(oobtail, oobbuf, mtd->oobsize - nand->ecc.steps * oob_len); =
=20
> >=20
> > TBH I don't get what you do here. =20
>=20
> This code works in raw mode and places OOB data from provided OOB buffer =
to DMA buffer.
> This is because number of user bytes is increased in this patch.
>=20
> >  =20
> >>  }
> >> =20
> >>  static int meson_nfc_queue_rb(struct nand_chip *nand, int timeout_ms)
> >> @@ -433,7 +452,7 @@ static void meson_nfc_set_user_byte(struct nand_ch=
ip *nand, u8 *oob_buf)
> >>  	__le64 *info;
> >>  	int i, count;
> >> =20
> >> -	for (i =3D 0, count =3D 0; i < nand->ecc.steps; i++, count +=3D 2) {
> >> +	for (i =3D 0, count =3D 0; i < nand->ecc.steps; i++, count +=3D (nan=
d->ecc.bytes + 2)) {
> >>  		info =3D &meson_chip->info_buf[i];
> >>  		*info |=3D oob_buf[count];
> >>  		*info |=3D oob_buf[count + 1] << 8;
> >> @@ -446,7 +465,7 @@ static void meson_nfc_get_user_byte(struct nand_ch=
ip *nand, u8 *oob_buf)
> >>  	__le64 *info;
> >>  	int i, count;
> >> =20
> >> -	for (i =3D 0, count =3D 0; i < nand->ecc.steps; i++, count +=3D 2) {
> >> +	for (i =3D 0, count =3D 0; i < nand->ecc.steps; i++, count +=3D (nan=
d->ecc.bytes + 2)) {
> >>  		info =3D &meson_chip->info_buf[i];
> >>  		oob_buf[count] =3D *info;
> >>  		oob_buf[count + 1] =3D *info >> 8;
> >> @@ -638,6 +657,84 @@ static int meson_nfc_rw_cmd_prepare_and_execute(s=
truct nand_chip *nand,
> >>  	return 0;
> >>  }
> >> =20
> >> +static u32 meson_nfc_oob_free_bytes(struct nand_chip *nand)
> >> +{
> >> +	struct mtd_info *mtd =3D nand_to_mtd(nand);
> >> +
> >> +	return mtd->oobsize - nand->ecc.steps * (nand->ecc.bytes + 2); =20
> >=20
> > This looks like a static value, just save it somewhere instead of
> > recomputing it? =20
>=20
> Ack
>=20
> >  =20
> >> +}
> >> +
> >> +static int meson_nfc_write_oob(struct nand_chip *nand, int page)
> >> +{
> >> +	struct mtd_info *mtd =3D nand_to_mtd(nand);
> >> +	u32 page_size =3D mtd->writesize + mtd->oobsize;
> >> +	u32 oob_bytes =3D meson_nfc_oob_free_bytes(nand);
> >> +	u8 *oob_buf;
> >> +	int ret;
> >> +
> >> +	if (!oob_bytes)
> >> +		return 0; =20
> >=20
> > Can this happen? =20
>=20
> Ack, seems forget to remove it
>=20
> >  =20
> >> +
> >> +	/* Called as OOB write helper, will send NAND_CMD_PAGEPROG. */
> >> +	if (page !=3D -1) {
> >> +		ret =3D nand_prog_page_begin_op(nand, page, 0, NULL, 0);
> >> +		if (ret)
> >> +			return ret;
> >> +	}
> >> +
> >> +	oob_buf =3D nand->oob_poi;
> >> +
> >> +	ret =3D nand_change_write_column_op(nand, page_size - oob_bytes,
> >> +					  oob_buf + (mtd->oobsize - oob_bytes),
> >> +					  oob_bytes, false);
> >> +	if (ret)
> >> +		return ret;
> >> +
> >> +	return (page !=3D -1) ? nand_prog_page_end_op(nand) : 0;
> >> +}
> >> +
> >> +static int meson_nfc_read_oob(struct nand_chip *nand, int page)
> >> +{
> >> +	struct mtd_info *mtd =3D nand_to_mtd(nand);
> >> +	u8 *oob_buf =3D nand->oob_poi;
> >> +	u32 oob_bytes;
> >> +	u32 page_size;
> >> +	int ret;
> >> +	int i;
> >> +
> >> +	/* Called as OOB read helper, send NAND_CMD_READ0. */
> >> +	if (page !=3D -1) { =20
> >=20
> > I don't like this logic with the "-1", it really hides what the
> > controller needs to do, if you need a helper to send a command, then
> > create that helper and give it a decent name. =20
>=20
> I see, so I think I need to implement this in the following way:
> 1) For OOB callback it always sends NAND_CMD_READ0 (e.g. without any 'if')
> 2) For read OOB with data page we don't need to send NAND_CMD_READ0. (als=
o without any 'if')
>=20
> >  =20
> >> +		ret =3D nand_read_page_op(nand, page, 0, NULL, 0);
> >> +		if (ret)
> >> +			return ret;
> >> +	}
> >> +
> >> +	/* Read ECC codes and user bytes. */
> >> +	for (i =3D 0; i < nand->ecc.steps; i++) {
> >> +		u32 ecc_offs =3D nand->ecc.size * (i + 1) +
> >> +			       (nand->ecc.bytes + 2) * i;
> >> +
> >> +		ret =3D nand_change_read_column_op(nand, ecc_offs,
> >> +						 oob_buf + i * (nand->ecc.bytes + 2),
> >> +						 (nand->ecc.bytes + 2), false);
> >> +		if (ret)
> >> +			return ret;
> >> +	}
> >> +
> >> +	oob_bytes =3D meson_nfc_oob_free_bytes(nand);
> >> +
> >> +	if (!oob_bytes)
> >> +		return 0;
> >> +
> >> +	page_size =3D mtd->writesize + mtd->oobsize;
> >> +
> >> +	ret =3D nand_change_read_column_op(nand, page_size - oob_bytes,
> >> +					 oob_buf + (mtd->oobsize - oob_bytes),
> >> +					 oob_bytes, false);
> >> +
> >> +	return ret;
> >> +}
> >> +
> >>  static int meson_nfc_write_page_sub(struct nand_chip *nand,
> >>  				    int page, int raw)
> >>  {
> >> @@ -674,6 +771,12 @@ static int meson_nfc_write_page_sub(struct nand_c=
hip *nand,
> >>  				     NFC_CMD_SCRAMBLER_DISABLE);
> >>  	}
> >> =20
> >> +	if (!raw) { =20
> >=20
> > Why this check?
> >=20
> > You should instead propagate the oob_required field and check that
> > value I believe. =20
>=20
>=20
> This check is for ECC mode, because in this mode we write user bytes of O=
OB.
> ECC bytes of OOB are written by hardware.

Just provide the buffer. The ECC engine will smash data if there was
any there. Otherwise it will fill the holes. It's expected. Don't try
to be smarter than you should :)

> I think I made a mistake, because
> I need new callback to write OOB in raw mode - it will write both ECC and=
 user
> parts,

There is no such thing as user and ECC part at the driver level. You
get a buffer, you need to write it to the flash.

The user expects:

| data | OOB |

The controller expects something like:

| data1 | OOB1 | data2 | OOB2 |

So just perform the reordering between data and OOB in the DMA buffer,
that is _all_.

> in current version I write only user part in raw mode.
>=20
> >  =20
> >> +		ret =3D meson_nfc_write_oob(nand, -1);
> >> +		if (ret)
> >> +			return ret;
> >> +	}
> >> +
> >>  	cmd =3D nfc->param.chip_select | NFC_CMD_CLE | NAND_CMD_PAGEPROG;
> >>  	writel(cmd, nfc->reg_base + NFC_REG_CMD);
> >>  	meson_nfc_queue_rb(nand, PSEC_TO_MSEC(sdr->tPROG_max));
> >> @@ -834,17 +937,10 @@ static int meson_nfc_read_page_hwecc(struct nand=
_chip *nand, u8 *buf,
> >>  		memcpy(buf, meson_chip->data_buf, mtd->writesize);
> >>  	}
> >> =20
> >> -	return bitflips;
> >> -}
> >> -
> >> -static int meson_nfc_read_oob_raw(struct nand_chip *nand, int page)
> >> -{
> >> -	return meson_nfc_read_page_raw(nand, NULL, 1, page);
> >> -}
> >> +	if (oob_required && ret) =20
> >=20
> > Unclear why you check ret here?

In general, if (ret) means there is an error.

Please consider using:

if (ret)
	goto error path;

do something else;

> >  =20
>=20
> If read was successful, we read OOB. If not - there is no sense in it.
>=20
> >> +		meson_nfc_read_oob(nand, -1);
> >> =20
> >> -static int meson_nfc_read_oob(struct nand_chip *nand, int page)
> >> -{
> >> -	return meson_nfc_read_page_hwecc(nand, NULL, 1, page);
> >> +	return bitflips;
> >>  }
> >> =20
> >>  static bool meson_nfc_is_buffer_dma_safe(const void *buffer)
> >> @@ -987,12 +1083,16 @@ static int meson_ooblayout_free(struct mtd_info=
 *mtd, int section,
> >>  				struct mtd_oob_region *oobregion)
> >>  {
> >>  	struct nand_chip *nand =3D mtd_to_nand(mtd);
> >> +	u32 oob_bytes =3D meson_nfc_oob_free_bytes(nand);
> >> =20
> >>  	if (section >=3D nand->ecc.steps)
> >>  		return -ERANGE;
> >> =20
> >> -	oobregion->offset =3D section * (2 + nand->ecc.bytes); =20
> >=20
> > The first two bytes of OOB are reserved for the bad block markers. This
> > is not related to your controller. =20
>=20
> I think first two bytes (in fact there are 4 bytes at positions 0, 1, 16 =
and 17)
> is considered by hardware as user bytes covered by ECC.

The two first bytes should not be available. They are not "ECC" bytes,
they are not "free" bytes. None of these two callbacks should give
access to these two bytes reserved for bad block markers.

Just to be clear: "ECC bytes" as in "meson_ooblayout_ecc" do *not* mean
"these are the protected bytes". They mean "these are the bytes in OOB
the hardware ECC engine will use to place its own data to make the
recovery process work".

Thanks,
Miqu=C3=A8l
