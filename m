Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 460996DF4DA
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 14:18:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230020AbjDLMSd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 08:18:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229661AbjDLMSb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 08:18:31 -0400
Received: from relay11.mail.gandi.net (relay11.mail.gandi.net [217.70.178.231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D5851FEA
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 05:18:29 -0700 (PDT)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id C8495100005;
        Wed, 12 Apr 2023 12:18:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1681301907;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ari64ibrXeBZr1oJcL8eONeaaIGC3ERYNDijfDPX6C0=;
        b=H/6tM8Io1DfAGX9v9ttE5SkAZGoMGZAsc3DWINLyZClBbGTac3EizJwsJWf+yGjAB836eY
        7Ki6Gh9ALfuigZ9lkTuby6lFqvQ2hdS9AU459CD1M8I01JfLc462cE6P7T7s/w4VLN7sFh
        0WAMY3oiY5QFX5qSd/bARXk07qI4mprDQyQKYrH33HBEVFPuOPYshbOn1zt5a1d2+E/rD6
        2TaOKYIS3CVBuHso2mL19Agnjt/eftcyRW6U5O3XqE6bGZWBtOWtg9GTAHeoQQ7dk9SwJr
        FR8sIOTLA2NXfBF+fwKn9qgda0LPjdHRoOR4LWHJessuxZ17V38mAvFI121sSg==
Date:   Wed, 12 Apr 2023 14:18:24 +0200
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
Message-ID: <20230412141824.755b2bca@xps-13>
In-Reply-To: <4eace0a0-f6af-7d99-a52f-7913a2139330@sberdevices.ru>
References: <20230412061700.1492474-1-AVKrasnov@sberdevices.ru>
        <20230412061700.1492474-5-AVKrasnov@sberdevices.ru>
        <20230412094400.3c82f631@xps-13>
        <ac4b66da-6a76-c2ec-7e21-31632f3448d5@sberdevices.ru>
        <20230412113654.183350d0@xps-13>
        <4eace0a0-f6af-7d99-a52f-7913a2139330@sberdevices.ru>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arseniy,

avkrasnov@sberdevices.ru wrote on Wed, 12 Apr 2023 13:14:52 +0300:

> On 12.04.2023 12:36, Miquel Raynal wrote:
> > Hi Arseniy,
> >=20
> > avkrasnov@sberdevices.ru wrote on Wed, 12 Apr 2023 12:20:55 +0300:
> >  =20
> >> On 12.04.2023 10:44, Miquel Raynal wrote: =20
> >>> Hi Arseniy,
> >>>
> >>> AVKrasnov@sberdevices.ru wrote on Wed, 12 Apr 2023 09:16:58 +0300:
> >>>    =20
> >>>> This NAND reads only few user's bytes in ECC mode (not full OOB), so=
   =20
> >>>
> >>> "This NAND reads" does not look right, do you mean "Subpage reads do
> >>> not retrieve all the OOB bytes,"?
> >>>    =20
> >>>> fill OOB buffer with zeroes to not return garbage from previous reads
> >>>> to user.
> >>>> Otherwise 'nanddump' utility prints something like this for just era=
sed
> >>>> page:
> >>>>
> >>>> ...
> >>>> 0x000007f0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> >>>>   OOB Data: ff ff ff ff 00 00 ff ff 80 cf 22 99 cb ad d3 be
> >>>>   OOB Data: 63 27 ae 06 16 0a 2f eb bb dd 46 74 41 8e 88 6e
> >>>>   OOB Data: 38 a1 2d e6 77 d4 05 06 f2 a5 7e 25 eb 34 7c ff
> >>>>   OOB Data: 38 ea de 14 10 de 9b 40 33 16 6a cc 9d aa 2f 5e
> >>>>
> >>>> Signed-off-by: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
> >>>> ---
> >>>>  drivers/mtd/nand/raw/meson_nand.c | 5 +++++
> >>>>  1 file changed, 5 insertions(+)
> >>>>
> >>>> diff --git a/drivers/mtd/nand/raw/meson_nand.c b/drivers/mtd/nand/ra=
w/meson_nand.c
> >>>> index f84a10238e4d..f2f2472cb511 100644
> >>>> --- a/drivers/mtd/nand/raw/meson_nand.c
> >>>> +++ b/drivers/mtd/nand/raw/meson_nand.c
> >>>> @@ -858,9 +858,12 @@ static int meson_nfc_read_page_sub(struct nand_=
chip *nand,
> >>>>  static int meson_nfc_read_page_raw(struct nand_chip *nand, u8 *buf,
> >>>>  				   int oob_required, int page)
> >>>>  {
> >>>> +	struct mtd_info *mtd =3D nand_to_mtd(nand);
> >>>>  	u8 *oob_buf =3D nand->oob_poi;
> >>>>  	int ret;
> >>>> =20
> >>>> +	memset(oob_buf, 0, mtd->oobsize);   =20
> >>>
> >>> I'm surprised raw reads do not read the entire OOB?   =20
> >>
> >> Yes! Seems in case of raw access (what i see in this driver) number of=
 OOB bytes read
> >> still depends on ECC parameters: for each portion of data covered with=
 ECC code we can
> >> read it's ECC code and "user bytes" from OOB - it is what i see by dum=
ping DMA buffer by
> >> printk(). For example I'm working with 2K NAND pages, each page has 2 =
x 1K ECC blocks.
> >> For each ECC block I have 16 OOB bytes which I can access by read/writ=
e. Each 16 bytes
> >> contains 2 bytes of user's data and 14 bytes ECC codes. So when I read=
 page in raw mode
> >> controller returns 32 bytes (2 x (2 + 14)) of OOB. While OOB is report=
ed as 64 bytes. =20
> >=20
> > In all modes, when you read OOB, you should get the full OOB. The fact
> > that ECC correction is enabled or disabled does not matter. If the NAND
> > features OOB sections of 64 bytes, you should get the 64 bytes.
> >=20
> > What happens sometimes, is that some of the bytes are not protected
> > against bitflips, but the policy is to return the full buffer. =20
>=20
> Ok, so to clarify case for this NAND controller:
> 1) In both ECC and raw modes i need to return the same raw OOB data (e.g.=
 user bytes
>    + ECC codes)?

Well, you need to cover the same amount of data, yes. But in the ECC
case the data won't be raw (at least not all of it).

> 2) If I have access to only 32 bytes of OOB (in case above), I must repor=
t that size
>    of OOB is only 32 bytes during initialization?

I believe it's just an implementation error in the controller driver.
This controller can be used on NAND chips with other geometries, please
don't play with it.

Thanks,
Miqu=C3=A8l
