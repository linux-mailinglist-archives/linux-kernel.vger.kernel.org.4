Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB0F76DF888
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 16:32:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230400AbjDLOcX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 10:32:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbjDLOcV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 10:32:21 -0400
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::223])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1C0C10C0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 07:32:19 -0700 (PDT)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 90C1560010;
        Wed, 12 Apr 2023 14:32:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1681309938;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uCd7H5EeqX9ceDa1o2Gu1VTH9DFW1VCWxDjFDqiS1qQ=;
        b=LKssq84Kl7yR39PBhA4l0CwJ9oc9/BCtrGaYHkESai2vuN384nsxSGkEHyADJqsH4TeLAx
        Sg01bTRmMbhiF0xOq3TF2CGT1fvDHT726d3d0nvJqLPHqgg6wrOxbMuE5Y7g1kC3ksnJ5d
        xU52cXuq5ryHiOxSMZ0QrXgrccjV05YlNsARc3+owYGJFDRQK3zBPIJEwR5AdbqaQU4UWu
        mJdI1mZKBCwRp9IT8jcTWdYfvvQJ7Onfil2a/Y1AXQ5mSmoAblFW5ewLra82q53mTzjlhI
        geYWaL+9GrYyRpl7hE7PbNLzfJf2JX/oXbR7xB2CqvHQhDUxH4KB1ywJQ0pihw==
Date:   Wed, 12 Apr 2023 16:32:14 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Liang Yang <liang.yang@amlogic.com>
Cc:     Arseniy Krasnov <avkrasnov@sberdevices.ru>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Jianxin Pan <jianxin.pan@amlogic.com>,
        Yixun Lan <yixun.lan@amlogic.com>, oxffffaa@gmail.com,
        kernel@sberdevices.ru, linux-mtd@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 4/5] mtd: rawnand: meson: clear OOB buffer before
 read
Message-ID: <20230412163214.0c764bb3@xps-13>
In-Reply-To: <7c996832-258f-001c-56bd-87bbdf23eeaa@amlogic.com>
References: <20230412061700.1492474-1-AVKrasnov@sberdevices.ru>
        <20230412061700.1492474-5-AVKrasnov@sberdevices.ru>
        <20230412094400.3c82f631@xps-13>
        <ac4b66da-6a76-c2ec-7e21-31632f3448d5@sberdevices.ru>
        <20230412113654.183350d0@xps-13>
        <4eace0a0-f6af-7d99-a52f-7913a2139330@sberdevices.ru>
        <20230412141824.755b2bca@xps-13>
        <eedaaed9-0a41-2c18-9eb2-792613566986@sberdevices.ru>
        <20230412145715.58c2be4a@xps-13>
        <7c996832-258f-001c-56bd-87bbdf23eeaa@amlogic.com>
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

Hello,

liang.yang@amlogic.com wrote on Wed, 12 Apr 2023 22:04:28 +0800:

> Hi Miquel and Arseniy,
>=20
> On 2023/4/12 20:57, Miquel Raynal wrote:
> > [ EXTERNAL EMAIL ]
> >=20
> > Hi Arseniy,
> >=20
> > avkrasnov@sberdevices.ru wrote on Wed, 12 Apr 2023 15:22:26 +0300:
> >  =20
> >> On 12.04.2023 15:18, Miquel Raynal wrote: =20
> >>> Hi Arseniy,
> >>>
> >>> avkrasnov@sberdevices.ru wrote on Wed, 12 Apr 2023 13:14:52 +0300: =20
> >>>    >>>> On 12.04.2023 12:36, Miquel Raynal wrote: =20
> >>>>> Hi Arseniy,
> >>>>>
> >>>>> avkrasnov@sberdevices.ru wrote on Wed, 12 Apr 2023 12:20:55 +0300: =
=20
> >>>>>      >>>>>> On 12.04.2023 10:44, Miquel Raynal wrote: =20
> >>>>>>> Hi Arseniy,
> >>>>>>>
> >>>>>>> AVKrasnov@sberdevices.ru wrote on Wed, 12 Apr 2023 09:16:58 +0300=
: =20
> >>>>>>>        >>>>>>>> This NAND reads only few user's bytes in ECC mode=
 (not full OOB), so =20
> >>>>>>>
> >>>>>>> "This NAND reads" does not look right, do you mean "Subpage reads=
 do
> >>>>>>> not retrieve all the OOB bytes,"? =20
> >>>>>>>        >>>>>>>> fill OOB buffer with zeroes to not return garbage=
 from previous reads =20
> >>>>>>>> to user.
> >>>>>>>> Otherwise 'nanddump' utility prints something like this for just=
 erased
> >>>>>>>> page:
> >>>>>>>>
> >>>>>>>> ...
> >>>>>>>> 0x000007f0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> >>>>>>>>    OOB Data: ff ff ff ff 00 00 ff ff 80 cf 22 99 cb ad d3 be
> >>>>>>>>    OOB Data: 63 27 ae 06 16 0a 2f eb bb dd 46 74 41 8e 88 6e
> >>>>>>>>    OOB Data: 38 a1 2d e6 77 d4 05 06 f2 a5 7e 25 eb 34 7c ff
> >>>>>>>>    OOB Data: 38 ea de 14 10 de 9b 40 33 16 6a cc 9d aa 2f 5e
> >>>>>>>>
> >>>>>>>> Signed-off-by: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
> >>>>>>>> ---
> >>>>>>>>   drivers/mtd/nand/raw/meson_nand.c | 5 +++++
> >>>>>>>>   1 file changed, 5 insertions(+)
> >>>>>>>>
> >>>>>>>> diff --git a/drivers/mtd/nand/raw/meson_nand.c b/drivers/mtd/nan=
d/raw/meson_nand.c
> >>>>>>>> index f84a10238e4d..f2f2472cb511 100644
> >>>>>>>> --- a/drivers/mtd/nand/raw/meson_nand.c
> >>>>>>>> +++ b/drivers/mtd/nand/raw/meson_nand.c
> >>>>>>>> @@ -858,9 +858,12 @@ static int meson_nfc_read_page_sub(struct n=
and_chip *nand,
> >>>>>>>>   static int meson_nfc_read_page_raw(struct nand_chip *nand, u8 =
*buf,
> >>>>>>>>   				   int oob_required, int page)
> >>>>>>>>   {
> >>>>>>>> +	struct mtd_info *mtd =3D nand_to_mtd(nand);
> >>>>>>>>   	u8 *oob_buf =3D nand->oob_poi;
> >>>>>>>>   	int ret; =20
> >>>>>>>>   >>>>>>>> +	memset(oob_buf, 0, mtd->oobsize); =20
> >>>>>>>
> >>>>>>> I'm surprised raw reads do not read the entire OOB? =20
> >>>>>>
> >>>>>> Yes! Seems in case of raw access (what i see in this driver) numbe=
r of OOB bytes read
> >>>>>> still depends on ECC parameters: for each portion of data covered =
with ECC code we can
> >>>>>> read it's ECC code and "user bytes" from OOB - it is what i see by=
 dumping DMA buffer by
> >>>>>> printk(). For example I'm working with 2K NAND pages, each page ha=
s 2 x 1K ECC blocks.
> >>>>>> For each ECC block I have 16 OOB bytes which I can access by read/=
write. Each 16 bytes
> >>>>>> contains 2 bytes of user's data and 14 bytes ECC codes. So when I =
read page in raw mode
> >>>>>> controller returns 32 bytes (2 x (2 + 14)) of OOB. While OOB is re=
ported as 64 bytes. =20
> >>>>>
> >>>>> In all modes, when you read OOB, you should get the full OOB. The f=
act
> >>>>> that ECC correction is enabled or disabled does not matter. If the =
NAND
> >>>>> features OOB sections of 64 bytes, you should get the 64 bytes.
> >>>>>
> >>>>> What happens sometimes, is that some of the bytes are not protected
> >>>>> against bitflips, but the policy is to return the full buffer. =20
> >>>>
> >>>> Ok, so to clarify case for this NAND controller:
> >>>> 1) In both ECC and raw modes i need to return the same raw OOB data =
(e.g. user bytes
> >>>>     + ECC codes)? =20
> >>>
> >>> Well, you need to cover the same amount of data, yes. But in the ECC
> >>> case the data won't be raw (at least not all of it). =20
> >>
> >> So "same amount of data", in ECC mode current implementation returns o=
nly user OOB bytes (e.g.
> >> OOB data excluding ECC codes), in raw it returns user bytes + ECC code=
s. IIUC correct
> >> behaviour is to always return user bytes + ECC codes as OOB data even =
in ECC mode ? =20
> >=20
> > If the page are 2k+64B you should read 2k+64B when OOB are requested.
> >=20
> > If the controller only returns 2k+32B, then perform a random read to
> > just move the read pointer to mtd->size + mtd->oobsize - 32 and
> > retrieve the missing 32 bytes? =20
>=20
> 1) raw read can read out the whole page data 2k+64B, decided by the len i=
n the controller raw read command:
> 	cmd =3D (len & GENMASK(5, 0)) | scrambler | DMA_DIR(dir);
> after that, the missing oob bytes(not used) can be copied from meson_chip=
->data_buf. so the implementation of meson_nfc_read_page_raw() is like this=
 if need.
> 	{
> 		......
> 		meson_nfc_read_page_sub(nand, page, 1);
> 		meson_nfc_get_data_oob(nand, buf, oob_buf);
> 		oob_len =3D (nand->ecc.bytes + 2) * nand->ecc.steps;
> 		memcpy(oob_buf + oob_len, meson_chip->data_buf + oob_len, mtd->oobsize =
- oob_len);
>=20
> 	}
> 2) In ECC mode, the controller can't bring back the missing OOB bytes. it=
 can read out the user bytes and ecc bytes per meson_ooblayout_ops define.

And then (if oob_required) you can bring the missing bytes with
something along:
nand_change_read_column_op(chip, mtd->writesize + oob_len,
			   oob_buf + oob_len,
			   mtd->oobsize - oob_len,
			   false);
Should not be a huge performance hit.

>=20
> >=20
> > This applies to the two modes, the only difference is:
> > - with correction (commonly named "ECC mode"): the user bytes and ECC
> >    bytes should be fixed if there are any bitflips
> > - without correction (commonly referred as "raw mode"): no correction
> >    applies, if there are bitflips, give them
> >=20
> > Please mind the raw mode can be slow, it's meant for debugging and
> > testing, mainly. Page reads however should be fast, so if just moving
> > the column pointer works, then do it, otherwise we'll consider
> > returning FFs.
> >=20
> > Thanks,
> > Miqu=C3=A8l
> >  =20
>=20


Thanks,
Miqu=C3=A8l
