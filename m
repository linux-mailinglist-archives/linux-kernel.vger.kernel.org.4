Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEBAD6E0B67
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 12:29:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230351AbjDMK3Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 06:29:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbjDMK3X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 06:29:23 -0400
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 131982719
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 03:29:20 -0700 (PDT)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 3E34F20002;
        Thu, 13 Apr 2023 10:29:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1681381759;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=roaHWfd5xHsGPVWX8nxwTerxHDq6SfUOsNslVYye3ts=;
        b=bAr6Mi1DFaNLucZzmn1MGSduiKK7BQvzEARHrZK125+PLeTrhMYZN40rD8R9YPGevgl08+
        kN/AxTfnRulPkGg6kj4WUqkCeVz6YCYdwSkK9Fs1v3JjH72Svr7RlaqBr7eWtLdwGrhQ0B
        vB6qTqoaneydFC8JwWxtwSSm2KQzdnjzUPKs/Z6U8mk9Mq3sLwV9LryWvsqt3oih098Iza
        AjRzGs82g8qu2B2mM2ciYkJ1zXlBfaWx6aAy1sI61Ets46u2AHoEeQ4nqLkbntcz/h/3gY
        5M5SEgSseneO8XOGAoQ0W5Gt7ZM3a43EADeKvXGCKRRc6nNIQT+BbIt807iogQ==
Date:   Thu, 13 Apr 2023 12:29:16 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Dmitry Rokosov <ddrokosov@sberdevices.ru>
Cc:     Liang Yang <liang.yang@amlogic.com>,
        Arseniy Krasnov <avkrasnov@sberdevices.ru>,
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
Message-ID: <20230413122916.365269f0@xps-13>
In-Reply-To: <20230413092706.mzopdszyirnwnjnl@CAB-WSD-L081021>
References: <20230412094400.3c82f631@xps-13>
        <ac4b66da-6a76-c2ec-7e21-31632f3448d5@sberdevices.ru>
        <20230412113654.183350d0@xps-13>
        <4eace0a0-f6af-7d99-a52f-7913a2139330@sberdevices.ru>
        <20230412141824.755b2bca@xps-13>
        <eedaaed9-0a41-2c18-9eb2-792613566986@sberdevices.ru>
        <20230412145715.58c2be4a@xps-13>
        <7c996832-258f-001c-56bd-87bbdf23eeaa@amlogic.com>
        <20230412191548.ov5fufxkwqvdgrz2@CAB-WSD-L081021>
        <20230412225603.5fba1a9e@xps-13>
        <20230413092706.mzopdszyirnwnjnl@CAB-WSD-L081021>
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

Hi Dmitry,

ddrokosov@sberdevices.ru wrote on Thu, 13 Apr 2023 12:27:06 +0300:

> On Wed, Apr 12, 2023 at 10:56:03PM +0200, Miquel Raynal wrote:
> > Hi Dmitry,
> >=20
> > ddrokosov@sberdevices.ru wrote on Wed, 12 Apr 2023 22:15:48 +0300:
> >  =20
> > > On Wed, Apr 12, 2023 at 10:04:28PM +0800, Liang Yang wrote: =20
> > > > Hi Miquel and Arseniy,
> > > >=20
> > > > On 2023/4/12 20:57, Miquel Raynal wrote:   =20
> > > > > [ EXTERNAL EMAIL ]
> > > > >=20
> > > > > Hi Arseniy,
> > > > >=20
> > > > > avkrasnov@sberdevices.ru wrote on Wed, 12 Apr 2023 15:22:26 +0300:
> > > > >    =20
> > > > > > On 12.04.2023 15:18, Miquel Raynal wrote:   =20
> > > > > > > Hi Arseniy,
> > > > > > >=20
> > > > > > > avkrasnov@sberdevices.ru wrote on Wed, 12 Apr 2023 13:14:52 +=
0300:   =20
> > > > > > > > On 12.04.2023 12:36, Miquel Raynal wrote:   =20
> > > > > > > > > Hi Arseniy,
> > > > > > > > >=20
> > > > > > > > > avkrasnov@sberdevices.ru wrote on Wed, 12 Apr 2023 12:20:=
55 +0300:   =20
> > > > > > > > > > On 12.04.2023 10:44, Miquel Raynal wrote:   =20
> > > > > > > > > > > Hi Arseniy,
> > > > > > > > > > >=20
> > > > > > > > > > > AVKrasnov@sberdevices.ru wrote on Wed, 12 Apr 2023 09=
:16:58 +0300:   =20
> > > > > > > > > > > > This NAND reads only few user's bytes in ECC mode (=
not full OOB), so   =20
> > > > > > > > > > >=20
> > > > > > > > > > > "This NAND reads" does not look right, do you mean "S=
ubpage reads do
> > > > > > > > > > > not retrieve all the OOB bytes,"?   =20
> > > > > > > > > > > > fill OOB buffer with zeroes to not return garbage f=
rom previous reads
> > > > > > > > > > > > to user.
> > > > > > > > > > > > Otherwise 'nanddump' utility prints something like =
this for just erased
> > > > > > > > > > > > page:
> > > > > > > > > > > >=20
> > > > > > > > > > > > ...
> > > > > > > > > > > > 0x000007f0: ff ff ff ff ff ff ff ff ff ff ff ff ff =
ff ff ff
> > > > > > > > > > > >    OOB Data: ff ff ff ff 00 00 ff ff 80 cf 22 99 cb=
 ad d3 be
> > > > > > > > > > > >    OOB Data: 63 27 ae 06 16 0a 2f eb bb dd 46 74 41=
 8e 88 6e
> > > > > > > > > > > >    OOB Data: 38 a1 2d e6 77 d4 05 06 f2 a5 7e 25 eb=
 34 7c ff
> > > > > > > > > > > >    OOB Data: 38 ea de 14 10 de 9b 40 33 16 6a cc 9d=
 aa 2f 5e
> > > > > > > > > > > >=20
> > > > > > > > > > > > Signed-off-by: Arseniy Krasnov <AVKrasnov@sberdevic=
es.ru>
> > > > > > > > > > > > ---
> > > > > > > > > > > >   drivers/mtd/nand/raw/meson_nand.c | 5 +++++
> > > > > > > > > > > >   1 file changed, 5 insertions(+)
> > > > > > > > > > > >=20
> > > > > > > > > > > > diff --git a/drivers/mtd/nand/raw/meson_nand.c b/dr=
ivers/mtd/nand/raw/meson_nand.c
> > > > > > > > > > > > index f84a10238e4d..f2f2472cb511 100644
> > > > > > > > > > > > --- a/drivers/mtd/nand/raw/meson_nand.c
> > > > > > > > > > > > +++ b/drivers/mtd/nand/raw/meson_nand.c
> > > > > > > > > > > > @@ -858,9 +858,12 @@ static int meson_nfc_read_page=
_sub(struct nand_chip *nand,
> > > > > > > > > > > >   static int meson_nfc_read_page_raw(struct nand_ch=
ip *nand, u8 *buf,
> > > > > > > > > > > >   				   int oob_required, int page)
> > > > > > > > > > > >   {
> > > > > > > > > > > > +	struct mtd_info *mtd =3D nand_to_mtd(nand);
> > > > > > > > > > > >   	u8 *oob_buf =3D nand->oob_poi;
> > > > > > > > > > > >   	int ret;
> > > > > > > > > > > > +	memset(oob_buf, 0, mtd->oobsize);   =20
> > > > > > > > > > >=20
> > > > > > > > > > > I'm surprised raw reads do not read the entire OOB?  =
 =20
> > > > > > > > > >=20
> > > > > > > > > > Yes! Seems in case of raw access (what i see in this dr=
iver) number of OOB bytes read
> > > > > > > > > > still depends on ECC parameters: for each portion of da=
ta covered with ECC code we can
> > > > > > > > > > read it's ECC code and "user bytes" from OOB - it is wh=
at i see by dumping DMA buffer by
> > > > > > > > > > printk(). For example I'm working with 2K NAND pages, e=
ach page has 2 x 1K ECC blocks.
> > > > > > > > > > For each ECC block I have 16 OOB bytes which I can acce=
ss by read/write. Each 16 bytes
> > > > > > > > > > contains 2 bytes of user's data and 14 bytes ECC codes.=
 So when I read page in raw mode
> > > > > > > > > > controller returns 32 bytes (2 x (2 + 14)) of OOB. Whil=
e OOB is reported as 64 bytes.   =20
> > > > > > > > >=20
> > > > > > > > > In all modes, when you read OOB, you should get the full =
OOB. The fact
> > > > > > > > > that ECC correction is enabled or disabled does not matte=
r. If the NAND
> > > > > > > > > features OOB sections of 64 bytes, you should get the 64 =
bytes.
> > > > > > > > >=20
> > > > > > > > > What happens sometimes, is that some of the bytes are not=
 protected
> > > > > > > > > against bitflips, but the policy is to return the full bu=
ffer.   =20
> > > > > > > >=20
> > > > > > > > Ok, so to clarify case for this NAND controller:
> > > > > > > > 1) In both ECC and raw modes i need to return the same raw =
OOB data (e.g. user bytes
> > > > > > > >     + ECC codes)?   =20
> > > > > > >=20
> > > > > > > Well, you need to cover the same amount of data, yes. But in =
the ECC
> > > > > > > case the data won't be raw (at least not all of it).   =20
> > > > > >=20
> > > > > > So "same amount of data", in ECC mode current implementation re=
turns only user OOB bytes (e.g.
> > > > > > OOB data excluding ECC codes), in raw it returns user bytes + E=
CC codes. IIUC correct
> > > > > > behaviour is to always return user bytes + ECC codes as OOB dat=
a even in ECC mode ?   =20
> > > > >=20
> > > > > If the page are 2k+64B you should read 2k+64B when OOB are reques=
ted.
> > > > >=20
> > > > > If the controller only returns 2k+32B, then perform a random read=
 to
> > > > > just move the read pointer to mtd->size + mtd->oobsize - 32 and
> > > > > retrieve the missing 32 bytes?   =20
> > > >=20
> > > > 1) raw read can read out the whole page data 2k+64B, decided by the=
 len in
> > > > the controller raw read command:
> > > > 	cmd =3D (len & GENMASK(5, 0)) | scrambler | DMA_DIR(dir);
> > > > after that, the missing oob bytes(not used) can be copied from
> > > > meson_chip->data_buf. so the implementation of meson_nfc_read_page_=
raw() is
> > > > like this if need.
> > > > 	{
> > > > 		......
> > > > 		meson_nfc_read_page_sub(nand, page, 1);
> > > > 		meson_nfc_get_data_oob(nand, buf, oob_buf);
> > > > 		oob_len =3D (nand->ecc.bytes + 2) * nand->ecc.steps;
> > > > 		memcpy(oob_buf + oob_len, meson_chip->data_buf + oob_len, mtd->oo=
bsize -
> > > > oob_len);
> > > >=20
> > > > 	}
> > > > 2) In ECC mode, the controller can't bring back the missing OOB byt=
es. it
> > > > can read out the user bytes and ecc bytes per meson_ooblayout_ops d=
efine.
> > > >    =20
> > >=20
> > > How does the Meson controller know the actual NAND flash layout when =
the
> > > OOB is split into protected and unprotected areas, such as Free and E=
CC
> > > areas? If the controller has a static OOB layout, where is the mapping
> > > located? =20
> >=20
> > It's usually a set of values hardcoded in the driver. It's a per
> > geometry set.
> >  =20
>=20
> Sorry, I'm still confused. Before I developed spinand drivers, the OOB la=
yout
> was located on the flash driver side.

The spinand subsystem is different, most of the chips have on-die ECC,
which means the ECC layout is most of the time per-chip.

In the raw NAND layer, most of the time the ECC engine is merged with
the NAND controller and thus the list of available layouts depend on
the controller. But these layouts often adapt to the NAND chip
geometry, so you can only now which layout to use after identifying the
chip (there is an ->attach_chip() hook to handle things related to
geometry after controller base initialization.

> Do you mean if the OOB geometry in the rawnand subsystem is under the
> responsibility of the controller driver?

The geometry is NAND chip specific.
The OOB layout depends on the chip geometry, the ECC engine
capabilities and configuration (like the strength).
The discovery of the geometry is performed by the core (using raw NAND
controller driver callbacks of course).
If on-host ECC engine is picked (the default in the raw NAND
subsystem), then the controller driver picks the correct OOB layout and
refuses to probe otherwise.

Hope its clearer now :)

Thanks,
Miqu=C3=A8l
