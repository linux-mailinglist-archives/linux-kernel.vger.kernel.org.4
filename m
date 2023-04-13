Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC2536E0B58
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 12:23:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230359AbjDMKXF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 06:23:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbjDMKXA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 06:23:00 -0400
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA1E8EB
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 03:22:57 -0700 (PDT)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 762D06000B;
        Thu, 13 Apr 2023 10:22:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1681381376;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sjeuKuQdJ32SSnMHoEKVcjD6pzbnJXHzPlVz49ABF44=;
        b=CVNzH2+6mP8oVST5TzUyPTk9Esauby0BOmNGbo4eBa3KbQRo6sqqokjx2R4DoTqEITC6Fc
        6hpRwvkuVpbAO7tCWjsWIRZ5C9wfs9oCwIY7kcBc5ZflYvnGAYW2T+11/bxaquTIsXXV/x
        oGFLJFn7iBuPwf+vnnTV/9+bukjV5CzOeJRSz3muC0HMq1uDLzDrKgd+KYKVfR9sI7gKTN
        nt1EvZxGLMyjQmihY11vNSDVAWejvtw2Wsl/g07MzFTPkzLZIGusfRpwfqqX4Pr2vtGpEX
        GXLVNSpkTxO5a9LJ1tIwO8x7H5+YiNg1nB5CCckttpemNB459+CPiz4CpZENtQ==
Date:   Thu, 13 Apr 2023 12:22:52 +0200
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
        <linux-amlogic@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        "yonghui.yu" <yonghui.yu@amlogic.com>
Subject: Re: [PATCH v1 4/5] mtd: rawnand: meson: clear OOB buffer before
 read
Message-ID: <20230413122252.0a8efcd8@xps-13>
In-Reply-To: <b3279de4-e89d-db03-a515-a6aa52ab90d3@sberdevices.ru>
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
        <20230412163214.0c764bb3@xps-13>
        <0c61eaae-053e-5768-a533-70b2ff0cc95d@amlogic.com>
        <fbb8cb2b-0996-3029-b368-f67087d73487@amlogic.com>
        <7520e512-8a19-ff04-364c-b5be0a579ef0@sberdevices.ru>
        <20230413102200.309fbe9c@xps-13>
        <b3279de4-e89d-db03-a515-a6aa52ab90d3@sberdevices.ru>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arseniy,

avkrasnov@sberdevices.ru wrote on Thu, 13 Apr 2023 12:36:24 +0300:

> On 13.04.2023 11:22, Miquel Raynal wrote:
> > Hi Arseniy,
> >=20
> > avkrasnov@sberdevices.ru wrote on Thu, 13 Apr 2023 10:00:24 +0300:
> >  =20
> >> On 13.04.2023 09:11, Liang Yang wrote: =20
> >>>
> >>> On 2023/4/13 13:32, Liang Yang wrote:   =20
> >>>> Hi Miquel,
> >>>>
> >>>> On 2023/4/12 22:32, Miquel Raynal wrote:   =20
> >>>>> [ EXTERNAL EMAIL ]
> >>>>>
> >>>>> Hello,
> >>>>>
> >>>>> liang.yang@amlogic.com wrote on Wed, 12 Apr 2023 22:04:28 +0800:
> >>>>>   =20
> >>>>>> Hi Miquel and Arseniy,
> >>>>>>
> >>>>>> On 2023/4/12 20:57, Miquel Raynal wrote:   =20
> >>>>>>> [ EXTERNAL EMAIL ]
> >>>>>>>
> >>>>>>> Hi Arseniy,
> >>>>>>>
> >>>>>>> avkrasnov@sberdevices.ru wrote on Wed, 12 Apr 2023 15:22:26 +0300=
:   =20
> >>>>>>>> On 12.04.2023 15:18, Miquel Raynal wrote:   =20
> >>>>>>>>> Hi Arseniy,
> >>>>>>>>>
> >>>>>>>>> avkrasnov@sberdevices.ru wrote on Wed, 12 Apr 2023 13:14:52 +03=
00:
> >>>>>>>>> =C2=A0=C2=A0=C2=A0 >>>> On 12.04.2023 12:36, Miquel Raynal wrot=
e:   =20
> >>>>>>>>>>> Hi Arseniy,
> >>>>>>>>>>>
> >>>>>>>>>>> avkrasnov@sberdevices.ru wrote on Wed, 12 Apr 2023 12:20:55 +=
0300:
> >>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 >>>>>> On 12.04.2023 10:44, Mi=
quel Raynal wrote:   =20
> >>>>>>>>>>>>> Hi Arseniy,
> >>>>>>>>>>>>>
> >>>>>>>>>>>>> AVKrasnov@sberdevices.ru wrote on Wed, 12 Apr 2023 09:16:58=
 +0300:
> >>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 >>>>>>>> This NA=
ND reads only few user's bytes in ECC mode (not full OOB), so
> >>>>>>>>>>>>>
> >>>>>>>>>>>>> "This NAND reads" does not look right, do you mean "Subpage=
 reads do
> >>>>>>>>>>>>> not retrieve all the OOB bytes,"?
> >>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 >>>>>>>> fill OO=
B buffer with zeroes to not return garbage from previous reads   =20
> >>>>>>>>>>>>>> to user.
> >>>>>>>>>>>>>> Otherwise 'nanddump' utility prints something like this fo=
r just erased
> >>>>>>>>>>>>>> page:
> >>>>>>>>>>>>>>
> >>>>>>>>>>>>>> ...
> >>>>>>>>>>>>>> 0x000007f0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> >>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0 OOB Data: ff ff ff ff 00 00 ff ff 80 cf=
 22 99 cb ad d3 be
> >>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0 OOB Data: 63 27 ae 06 16 0a 2f eb bb dd=
 46 74 41 8e 88 6e
> >>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0 OOB Data: 38 a1 2d e6 77 d4 05 06 f2 a5=
 7e 25 eb 34 7c ff
> >>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0 OOB Data: 38 ea de 14 10 de 9b 40 33 16=
 6a cc 9d aa 2f 5e
> >>>>>>>>>>>>>>
> >>>>>>>>>>>>>> Signed-off-by: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
> >>>>>>>>>>>>>> ---
> >>>>>>>>>>>>>> =C2=A0=C2=A0 drivers/mtd/nand/raw/meson_nand.c | 5 +++++
> >>>>>>>>>>>>>> =C2=A0=C2=A0 1 file changed, 5 insertions(+)
> >>>>>>>>>>>>>>
> >>>>>>>>>>>>>> diff --git a/drivers/mtd/nand/raw/meson_nand.c b/drivers/m=
td/nand/raw/meson_nand.c
> >>>>>>>>>>>>>> index f84a10238e4d..f2f2472cb511 100644
> >>>>>>>>>>>>>> --- a/drivers/mtd/nand/raw/meson_nand.c
> >>>>>>>>>>>>>> +++ b/drivers/mtd/nand/raw/meson_nand.c
> >>>>>>>>>>>>>> @@ -858,9 +858,12 @@ static int meson_nfc_read_page_sub(st=
ruct nand_chip *nand,
> >>>>>>>>>>>>>> =C2=A0=C2=A0 static int meson_nfc_read_page_raw(struct nan=
d_chip *nand, u8 *buf,
> >>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int o=
ob_required, int page)
> >>>>>>>>>>>>>> =C2=A0=C2=A0 {
> >>>>>>>>>>>>>> +=C2=A0=C2=A0=C2=A0 struct mtd_info *mtd =3D nand_to_mtd(n=
and);
> >>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 u8 *oob_buf =3D nand-=
>oob_poi;
> >>>>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int ret;
> >>>>>>>>>>>>>> =C2=A0=C2=A0 >>>>>>>> +=C2=A0=C2=A0=C2=A0 memset(oob_buf, =
0, mtd->oobsize);   =20
> >>>>>>>>>>>>>
> >>>>>>>>>>>>> I'm surprised raw reads do not read the entire OOB?   =20
> >>>>>>>>>>>>
> >>>>>>>>>>>> Yes! Seems in case of raw access (what i see in this driver)=
 number of OOB bytes read
> >>>>>>>>>>>> still depends on ECC parameters: for each portion of data co=
vered with ECC code we can
> >>>>>>>>>>>> read it's ECC code and "user bytes" from OOB - it is what i =
see by dumping DMA buffer by
> >>>>>>>>>>>> printk(). For example I'm working with 2K NAND pages, each p=
age has 2 x 1K ECC blocks.
> >>>>>>>>>>>> For each ECC block I have 16 OOB bytes which I can access by=
 read/write. Each 16 bytes
> >>>>>>>>>>>> contains 2 bytes of user's data and 14 bytes ECC codes. So w=
hen I read page in raw mode
> >>>>>>>>>>>> controller returns 32 bytes (2 x (2 + 14)) of OOB. While OOB=
 is reported as 64 bytes.   =20
> >>>>>>>>>>>
> >>>>>>>>>>> In all modes, when you read OOB, you should get the full OOB.=
 The fact
> >>>>>>>>>>> that ECC correction is enabled or disabled does not matter. I=
f the NAND
> >>>>>>>>>>> features OOB sections of 64 bytes, you should get the 64 byte=
s.
> >>>>>>>>>>>
> >>>>>>>>>>> What happens sometimes, is that some of the bytes are not pro=
tected
> >>>>>>>>>>> against bitflips, but the policy is to return the full buffer=
.   =20
> >>>>>>>>>>
> >>>>>>>>>> Ok, so to clarify case for this NAND controller:
> >>>>>>>>>> 1) In both ECC and raw modes i need to return the same raw OOB=
 data (e.g. user bytes
> >>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0 + ECC codes)?   =20
> >>>>>>>>>
> >>>>>>>>> Well, you need to cover the same amount of data, yes. But in th=
e ECC
> >>>>>>>>> case the data won't be raw (at least not all of it).   =20
> >>>>>>>>
> >>>>>>>> So "same amount of data", in ECC mode current implementation ret=
urns only user OOB bytes (e.g.
> >>>>>>>> OOB data excluding ECC codes), in raw it returns user bytes + EC=
C codes. IIUC correct
> >>>>>>>> behaviour is to always return user bytes + ECC codes as OOB data=
 even in ECC mode ?   =20
> >>>>>>>
> >>>>>>> If the page are 2k+64B you should read 2k+64B when OOB are reques=
ted.
> >>>>>>>
> >>>>>>> If the controller only returns 2k+32B, then perform a random read=
 to
> >>>>>>> just move the read pointer to mtd->size + mtd->oobsize - 32 and
> >>>>>>> retrieve the missing 32 bytes?   =20
> >>>>>>
> >>>>>> 1) raw read can read out the whole page data 2k+64B, decided by th=
e len in the controller raw read command:
> >>>>>> =C2=A0=C2=A0=C2=A0=C2=A0cmd =3D (len & GENMASK(5, 0)) | scrambler =
| DMA_DIR(dir);
> >>>>>> after that, the missing oob bytes(not used) can be copied from mes=
on_chip->data_buf. so the implementation of meson_nfc_read_page_raw() is li=
ke this if need.
> >>>>>> =C2=A0=C2=A0=C2=A0=C2=A0{
> >>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ......
> >>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 meson_nfc_read_page_sub=
(nand, page, 1);
> >>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 meson_nfc_get_data_oob(=
nand, buf, oob_buf);
> >>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 oob_len =3D (nand->ecc.=
bytes + 2) * nand->ecc.steps;
> >>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 memcpy(oob_buf + oob_le=
n, meson_chip->data_buf + oob_len, mtd->oobsize - oob_len);
> >>>>>>
> >>>>>> =C2=A0=C2=A0=C2=A0=C2=A0}
> >>>>>> 2) In ECC mode, the controller can't bring back the missing OOB by=
tes. it can read out the user bytes and ecc bytes per meson_ooblayout_ops d=
efine.   =20
> >>>>>
> >>>>> And then (if oob_required) you can bring the missing bytes with
> >>>>> something along:
> >>>>> nand_change_read_column_op(chip, mtd->writesize + oob_len,
> >>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 oob_buf + oob_len,
> >>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 mtd->oobsize - oob_len,
> >>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 false);
> >>>>> Should not be a huge performance hit.   =20
> >>>>
> >>>> After finishing ECC mode reading, the column address internal in NAN=
D device should be the right pos; it doesn't need to change the column agai=
n. so adding controller raw read for the missing bytes after ECC reading ma=
y works.
> >>>>   =20
> >>> use raw read for the missing bytes, but they are not protected by hos=
t ECC. to the NAND type of storage, is it ok or missing bytes better to be =
filled with 0xff?   =20
> >>
> >> IIUC Miqu=C3=A8l's reply, valid behaviour is to return full OOB data i=
n both modes. So in:
> >> ECC mode it is user bytes(corrected by ECC, read from info buffer) + E=
CC + missing bytes. ECC and missing bytes read in RAW mode. =20
> >=20
> > I believe the ECC bytes you'll get will be corrected.
> > You can check this by using nandflipbits in mtd-utils. =20
>=20
> Sorry, didn't get it, i'm new in NAND area. Bytes of ECC codes are availa=
ble only in raw mode (at least in this NAND
> driver) also as missing bytes of OOB.

Gasp. Yeah that's a controller limitation, okay.

> So IIUC ECC codes are metadata to correct data bytes, and thus
> couldn't be corrected.

We consider them metadata, but they are fully part of the ECC scheme
and thus their correction is part of the process, bitflips in the ECC
bytes will count as data bitflips actually.

I talked a bit about ECC engines at a previous conference if it can
help:
https://elinux.org/ELC_Europe_2020_Presentations
'Understand ECC Support for NAND Flash Devices in Linux'
And also wrote a blog post with a chapter about ECC engines:
https://bootlin.com/blog/supporting-a-misbehaving-nand-ecc-engine/

Thanks,
Miqu=C3=A8l
