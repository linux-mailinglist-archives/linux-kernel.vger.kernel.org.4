Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 956586DF08E
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 11:37:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230291AbjDLJhD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 05:37:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229995AbjDLJhB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 05:37:01 -0400
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::225])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5D5C139
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 02:36:58 -0700 (PDT)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 55AE11C0016;
        Wed, 12 Apr 2023 09:36:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1681292217;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zjAW3sbnqjC4RD0jM6Lfr+B+vyxCfa8273h/4IpoFAI=;
        b=W+a/1wnc3Yf9nMGLvyToyer/4s32mDzQcVuiqsEQAORqqeroXYGnnmyqM1luAsPxHGAxY8
        y9wIBoK2H4KBIKbJZAvv10MwQSQssxV8h875/K2cH/NqFtputacVb8EguSdhS5IF/rLYup
        fwa2pexXTUf+TjnIuKLgcARBVScdt8JJWz28ARJ/o+5TsMjwcQBnhzef/pIejEEngIboz7
        kmzxLM9F46nQcW0N/+l1HjLkxoWbBnDkc9qSCs68r+ADXYP3aOBUq65np/DRP49kRSf/1A
        s0HkjTC6qa40BJeB1iI9HRGs1RvQSFjZhEtRYSIZBY0a23YKzl/DiKQ78rXjMw==
Date:   Wed, 12 Apr 2023 11:36:54 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Arseniy Krasnov <avkrasnov@sberdevices.ru>
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
Message-ID: <20230412113654.183350d0@xps-13>
In-Reply-To: <ac4b66da-6a76-c2ec-7e21-31632f3448d5@sberdevices.ru>
References: <20230412061700.1492474-1-AVKrasnov@sberdevices.ru>
        <20230412061700.1492474-5-AVKrasnov@sberdevices.ru>
        <20230412094400.3c82f631@xps-13>
        <ac4b66da-6a76-c2ec-7e21-31632f3448d5@sberdevices.ru>
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

Hi Arseniy,

avkrasnov@sberdevices.ru wrote on Wed, 12 Apr 2023 12:20:55 +0300:

> On 12.04.2023 10:44, Miquel Raynal wrote:
> > Hi Arseniy,
> >=20
> > AVKrasnov@sberdevices.ru wrote on Wed, 12 Apr 2023 09:16:58 +0300:
> >  =20
> >> This NAND reads only few user's bytes in ECC mode (not full OOB), so =
=20
> >=20
> > "This NAND reads" does not look right, do you mean "Subpage reads do
> > not retrieve all the OOB bytes,"?
> >  =20
> >> fill OOB buffer with zeroes to not return garbage from previous reads
> >> to user.
> >> Otherwise 'nanddump' utility prints something like this for just erased
> >> page:
> >>
> >> ...
> >> 0x000007f0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> >>   OOB Data: ff ff ff ff 00 00 ff ff 80 cf 22 99 cb ad d3 be
> >>   OOB Data: 63 27 ae 06 16 0a 2f eb bb dd 46 74 41 8e 88 6e
> >>   OOB Data: 38 a1 2d e6 77 d4 05 06 f2 a5 7e 25 eb 34 7c ff
> >>   OOB Data: 38 ea de 14 10 de 9b 40 33 16 6a cc 9d aa 2f 5e
> >>
> >> Signed-off-by: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
> >> ---
> >>  drivers/mtd/nand/raw/meson_nand.c | 5 +++++
> >>  1 file changed, 5 insertions(+)
> >>
> >> diff --git a/drivers/mtd/nand/raw/meson_nand.c b/drivers/mtd/nand/raw/=
meson_nand.c
> >> index f84a10238e4d..f2f2472cb511 100644
> >> --- a/drivers/mtd/nand/raw/meson_nand.c
> >> +++ b/drivers/mtd/nand/raw/meson_nand.c
> >> @@ -858,9 +858,12 @@ static int meson_nfc_read_page_sub(struct nand_ch=
ip *nand,
> >>  static int meson_nfc_read_page_raw(struct nand_chip *nand, u8 *buf,
> >>  				   int oob_required, int page)
> >>  {
> >> +	struct mtd_info *mtd =3D nand_to_mtd(nand);
> >>  	u8 *oob_buf =3D nand->oob_poi;
> >>  	int ret;
> >> =20
> >> +	memset(oob_buf, 0, mtd->oobsize); =20
> >=20
> > I'm surprised raw reads do not read the entire OOB? =20
>=20
> Yes! Seems in case of raw access (what i see in this driver) number of OO=
B bytes read
> still depends on ECC parameters: for each portion of data covered with EC=
C code we can
> read it's ECC code and "user bytes" from OOB - it is what i see by dumpin=
g DMA buffer by
> printk(). For example I'm working with 2K NAND pages, each page has 2 x 1=
K ECC blocks.
> For each ECC block I have 16 OOB bytes which I can access by read/write. =
Each 16 bytes
> contains 2 bytes of user's data and 14 bytes ECC codes. So when I read pa=
ge in raw mode
> controller returns 32 bytes (2 x (2 + 14)) of OOB. While OOB is reported =
as 64 bytes.

In all modes, when you read OOB, you should get the full OOB. The fact
that ECC correction is enabled or disabled does not matter. If the NAND
features OOB sections of 64 bytes, you should get the 64 bytes.

What happens sometimes, is that some of the bytes are not protected
against bitflips, but the policy is to return the full buffer.

>=20
> Thanks, Arseniy
>=20
> >  =20
> >> +
> >>  	ret =3D meson_nfc_read_page_sub(nand, page, 1);
> >>  	if (ret)
> >>  		return ret;
> >> @@ -881,6 +884,8 @@ static int meson_nfc_read_page_hwecc(struct nand_c=
hip *nand, u8 *buf,
> >>  	u8 *oob_buf =3D nand->oob_poi;
> >>  	int ret, i;
> >> =20
> >> +	memset(oob_buf, 0, mtd->oobsize);
> >> +
> >>  	ret =3D meson_nfc_read_page_sub(nand, page, 0);
> >>  	if (ret)
> >>  		return ret; =20
> >=20
> >=20
> > Thanks,
> > Miqu=C3=A8l =20


Thanks,
Miqu=C3=A8l
