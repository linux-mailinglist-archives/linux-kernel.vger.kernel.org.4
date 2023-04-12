Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFE4D6DECDC
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 09:47:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229816AbjDLHrM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 03:47:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229615AbjDLHrI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 03:47:08 -0400
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::222])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B80F41705
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 00:47:06 -0700 (PDT)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 3D6624000D;
        Wed, 12 Apr 2023 07:47:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1681285625;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Tl8qiw+0w9MXIDlH7WD7qEaE1rT27aC7+yddYMTRrAw=;
        b=lJFRUAVhi7QhjUM8KhE+bGlOqqK83Y/4D+qAyp5DwQQOZZI5l1bx4mxWQp8wABN4tq5s+E
        QBNuVdRF4QssaRpZ28GzbgW/xfL3D243aKGL9REjBJIuoogtrxz6VSWsWkBIBVqwa1U4Ng
        fqGRSjomysmXiRzUrMD67xfDO5il0YYbmpYM9Rtp+okcjoXkDgJvsX0r7lh7esFYhqgy4g
        Ra/urhTpfr3E/UGeLNwoJJqdxV+8QrjKnDEBNRAc1kHq7rRdAGYDLzpx2vR9Ucqz2Pnwav
        gZDnLUv7NEJWL4amjDFonyAXW3j9iH/i/h+mxmyS8+dVUlA2xcoripRiMxbT6A==
Date:   Wed, 12 Apr 2023 09:47:02 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Arseniy Krasnov <AVKrasnov@sberdevices.ru>
Cc:     Liang Yang <liang.yang@amlogic.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Jianxin Pan <jianxin.pan@amlogic.com>,
        Yixun Lan <yixun.lan@amlogic.com>, <oxffffaa@gmail.com>,
        <kernel@sberdevices.ru>, <linux-mtd@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-amlogic@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 4/5] mtd: rawnand: meson: clear OOB buffer before
 read
Message-ID: <20230412094651.39f4dbf6@xps-13>
In-Reply-To: <20230412094400.3c82f631@xps-13>
References: <20230412061700.1492474-1-AVKrasnov@sberdevices.ru>
        <20230412061700.1492474-5-AVKrasnov@sberdevices.ru>
        <20230412094400.3c82f631@xps-13>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi again,

miquel.raynal@bootlin.com wrote on Wed, 12 Apr 2023 09:44:00 +0200:

> Hi Arseniy,
>=20
> AVKrasnov@sberdevices.ru wrote on Wed, 12 Apr 2023 09:16:58 +0300:
>=20
> > This NAND reads only few user's bytes in ECC mode (not full OOB), so =20
>=20
> "This NAND reads" does not look right, do you mean "Subpage reads do
> not retrieve all the OOB bytes,"?
>=20
> > fill OOB buffer with zeroes to not return garbage from previous reads
> > to user.
> > Otherwise 'nanddump' utility prints something like this for just erased
> > page:
> >=20
> > ...
> > 0x000007f0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> >   OOB Data: ff ff ff ff 00 00 ff ff 80 cf 22 99 cb ad d3 be
> >   OOB Data: 63 27 ae 06 16 0a 2f eb bb dd 46 74 41 8e 88 6e
> >   OOB Data: 38 a1 2d e6 77 d4 05 06 f2 a5 7e 25 eb 34 7c ff
> >   OOB Data: 38 ea de 14 10 de 9b 40 33 16 6a cc 9d aa 2f 5e
> >=20
> > Signed-off-by: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
> > ---
> >  drivers/mtd/nand/raw/meson_nand.c | 5 +++++
> >  1 file changed, 5 insertions(+)
> >=20
> > diff --git a/drivers/mtd/nand/raw/meson_nand.c b/drivers/mtd/nand/raw/m=
eson_nand.c
> > index f84a10238e4d..f2f2472cb511 100644
> > --- a/drivers/mtd/nand/raw/meson_nand.c
> > +++ b/drivers/mtd/nand/raw/meson_nand.c
> > @@ -858,9 +858,12 @@ static int meson_nfc_read_page_sub(struct nand_chi=
p *nand,
> >  static int meson_nfc_read_page_raw(struct nand_chip *nand, u8 *buf,
> >  				   int oob_required, int page)
> >  {
> > +	struct mtd_info *mtd =3D nand_to_mtd(nand);
> >  	u8 *oob_buf =3D nand->oob_poi;
> >  	int ret;
> > =20
> > +	memset(oob_buf, 0, mtd->oobsize); =20

Should use 0xff instead of 0x00, that's the default state of a NAND
cell.

And also this memset should be conditioned to 'oob_required' I
guess?

>=20
> I'm surprised raw reads do not read the entire OOB?
>=20
> > +
> >  	ret =3D meson_nfc_read_page_sub(nand, page, 1);
> >  	if (ret)
> >  		return ret;
> > @@ -881,6 +884,8 @@ static int meson_nfc_read_page_hwecc(struct nand_ch=
ip *nand, u8 *buf,
> >  	u8 *oob_buf =3D nand->oob_poi;
> >  	int ret, i;
> > =20
> > +	memset(oob_buf, 0, mtd->oobsize);
> > +
> >  	ret =3D meson_nfc_read_page_sub(nand, page, 0);
> >  	if (ret)
> >  		return ret; =20
>=20
>=20
> Thanks,
> Miqu=C3=A8l


Thanks,
Miqu=C3=A8l
