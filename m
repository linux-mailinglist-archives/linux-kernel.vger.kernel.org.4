Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CA84730479
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 18:01:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245276AbjFNQBt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 12:01:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245118AbjFNQBo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 12:01:44 -0400
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 073C8295B
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 09:01:21 -0700 (PDT)
X-GND-Sasl: miquel.raynal@bootlin.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1686758470;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qOV8LTn0vFlBeWdljLVATJ2Xq6J3HagcK9Y6oImy8+I=;
        b=fRGb2XnKJ8tgpUp/9ld7byMjVBjI+NtTqmuPLCJQswKll3RH+qfto8GuosQiirtT9+NZnS
        HF+mc5EJGkvXfdHHjlKJ8ZuZnEtq5zK/sgepxyCDk12T4bhqrAZQGtKSi5qE/SEmCJkn82
        vQ0e7s8aN9BLy3BMzSx79JEqpFVwFDxT94IZk7b/K7ZaAilMKpcHGGfLvEbqvAe8JLVf2R
        DW9Rgvf76DtSFQfStU8xfDwSg122Orq2k67dvdqEf89xf/UVICkA8wQOnzsN+8stD11FEz
        KVzgEbOSrFTejmgPrjkMyob9lZRTD77L3J3qFTQgxAxja/cH71wSruox1JRCtg==
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 7B83E20004;
        Wed, 14 Jun 2023 16:01:09 +0000 (UTC)
Date:   Wed, 14 Jun 2023 18:01:08 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Johan Jonker <jbx6244@gmail.com>
Cc:     richard@nod.at, vigneshr@ti.com, heiko@sntech.de,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, yifeng.zhao@rock-chips.com
Subject: Re: [PATCH v2 3/5] mtd: nand: raw: rockchip-nand-controller: fix
 oobfree offset and description
Message-ID: <20230614180108.5b202077@xps-13>
In-Reply-To: <8457ff3d-f033-8d06-42ca-d95f77ec8145@gmail.com>
References: <11e16c3b-6f7b-a6a9-b0ed-b7ac0cd703e3@gmail.com>
        <f2cebf54-a16c-c849-a988-bfd98c502748@gmail.com>
        <20230612192640.63baf3e8@xps-13>
        <8457ff3d-f033-8d06-42ca-d95f77ec8145@gmail.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Johan,

jbx6244@gmail.com wrote on Wed, 14 Jun 2023 11:23:44 +0200:

> On 6/12/23 19:26, Miquel Raynal wrote:
> > Hi Johan,
> >=20
> > jbx6244@gmail.com wrote on Mon, 12 Jun 2023 17:03:18 +0200:
> >  =20
> >> The MTD framework reserves 1 or 2 bytes for the bad block marker
> >> depending on the bus size. The rockchip-nand-controller driver
> >> currently only supports a 8 bit bus, but reserves standard 2 bytes
> >> for the BBM. =20
> >=20
> > We always reserve 2 bytes, no? =20
>=20
> Not always used, but for consistency/simplicity the author assumes/reserv=
es 2 bytes.=20

It's kind of an implicit rule in the raw NAND subsystem. It's not an
author choice.

> >> The first free OOB byte is therefore OOB2 at offset 2.
> >> Page address(PA) bytes are moved to the last 4 positions before
> >> ECC. Update the description for Linux. =20
> >=20
> > The description should just be:
> >  =20
>=20
> > Move Page Address (PA) bytes to the last 4 positions before ECC. =20
>=20
> Space is already reserved, but overwritten.

Well, I don't know, but I'm quoting your commit log "Page address(PA)
bytes are moved to the last 4 positions before ECC" and if this
sentence is right, I am proposing another way to say this which sounds
more declarative.

>=20
> >=20
> > And then you should justify why this is needed. Also, this would
> > break all existing jffs2 users, right? =20
>=20
> Hi Miquel,
>=20
> From your comments it seems that the chip->oob_poi buffer layout is
> still not clear to you. Hope that this text below helps.
> If existing jffs2 users of free OOB are writing

They are, it's the first thing that jjfs2 does: writing cleanmarkers in
the free area.

> they are corrupting
> our PA data in RAW mode. So that must be fixed.=20

I did not yet understand whether corrupting the PA data was an absolute
mistake or if it was specific to a given range of ROM codes. But let's
assume it must be fixed.

> Please advise how we
> split pre and post change users.

If you change the layout, you break users. There is no question here.
But if you do that, we need:
- a crystal clear explanation of why this is needed
- to say it clearly: this change breaks existing jffs2 users

> (With a Module parameter like
> skipbbt renamed to "user_mode" =3D 0 offset 6, "user_mode" =3D 1 offset

I know the cafe driver does that, it is awful IMHO.

> 2) Copying PA data in both RAW and HW mode has already reserved space
> in the layout. Let me know if I can help to get forward here.
>=20
> Johan
>=20
> =3D=3D=3D
>=20
> Given:
>=20
> Rockchip rk3066 MK808 with NAND:
> nand: Hynix H27UCG8T2ATR-BC 64G 3.3V 8-bit
> nand: 8192 MiB, MLC, erase size: 2048 KiB, page size: 8192, OOB size:
> 640
>=20
> =3D=3D=3D
>=20
> Calulations:
>=20
> #define NFC_SYS_DATA_SIZE		(4) /* 4 bytes sys data in
> oob pre 1024 data.*/
>=20
> So per step only 4 bytes of OOB can be read.

I think I get what you mean but the above sentence is wrong. You can
always read the full OOB in raw mode. And in general you can as well in
host ECC mode. Then what users do with the OOB information is
orthogonal. However, if they don't want their data to be smashed, they
can request the information about which bytes are free to be used
(typically what jffs2 does, while ubi does not care about OOB). The oob
layout helpers can then restrain the advertised free area to only share
bytes which are not used by the PA.

>=20
> =3D=3D=3D
>=20
> The NFC can read/write in 1024 data bytes per step.
> To read/write a full page it needs 8 steps.
>=20
> chip->ecc.size =3D 1024;
> chip->ecc.steps =3D mtd->writesize / chip->ecc.size;
>                 =3D 8192 / 1024
>                 =3D 8 steps
> =3D=3D=3D
>=20
> The total size of usefull OOB before ECC:
>=20
> rknand->metadata_size =3D NFC_SYS_DATA_SIZE * ecc->steps;
>                       =3D 4 * 8
>                       =3D 32
> =3D=3D=3D
>=20
> Wrong free OOB offset starts at OOB6:
> oob_region->offset =3D NFC_SYS_DATA_SIZE + 2;
>                    =3D 4 + 2
>                    =3D 6
>=20
> With a free OOB offset of 6 and a length of 26 =3D=3D> 6 + 26 =3D 32 we
> corrupt the PA address starting at offset 28.
>=20
> New offset OOB2:
> oob_region->offset =3D 2;
>=20
> The full range of free runs from OOB2 till/including OOB27.
> =3D=3D=3D
>=20
> The last 4 bytes of metadata are reserved for this Page Address(PA)
> for the bootrom. Currently only in use in RAW mode.

I'm not sure to understand what "currently on ly in use in raw mode".

In raw mode, the user can overwrite the whole OOB area, it is the user
input what should be written in each and every byte.

In ECC mode the ECC engine will smash some of this data to write its
own ECC bytes.

> The current PA calculation needed to write boot blocks for all
> Rockchip SoCs is however useless. The pattern of where the next page
> is written depends on the chip ID. As the MTD framework doesn't pass
> this chip ID in it's data structures, we must calculate that in
> userspace.

yes, I agree the right approach if you need to write these is to
perform raw OOB writes with values calculated manually.

> Therefore both RAW and HW mode must pass the PA bytes.

Yes, no problem with that.

> =3D=3D=3D
>=20
> The NFC hardware is capable for a 16 bit bus, but not implemented yet.
> Reserved are standard 2 bits for the BBM for a consistantency by the
> original author.
>=20
> =3D=3D=3D
>=20
> chip->oob_poi buffer layout for 8 steps:
>=20
> BBM0   BBM1  OOB2  OOB3  | OOB4  OOB5  OOB6  OOB7
>=20
> OOB8   OOB9  OOB10 OOB11 | OOB12 OOB13 OOB15 OOB15
> OOB16  OOB17 OOB18 OOB19 | OOB20 OOB21 OOB22 OOB23
>=20
> OOB24  OOB25 OOB26 OOB27 | PA0   PA1   PA2   PA3
>=20
> ECC0   ECC1  ECC2  ECC3  | ...   ...   ...   ...

Yes.

>=20
> =3D=3D=3D
>=20
> rk_nfc_ooblayout_free:
> oob_region->length =3D rknand->metadata_size - NFC_SYS_DATA_SIZE - 2;
>                    =3D 32 - 4 - 2
>                    =3D 26
>=20
> oob_region->offset =3D 2;
>=20
> Free OOB should start at OOB2 to not overwrite PA data.

Yes.

>=20
> =3D=3D=3D
>=20
> rk_nfc_ooblayout_ecc:
> 	oob_region->length =3D mtd->oobsize - rknand->metadata_size;
> 	                   =3D 640 - 32
> 	                   =3D 608
> 	oob_region->offset =3D rknand->metadata_size;
> 	                   =3D 32
>=20
> ECC data starts at offset 32.

Yes.

>=20
> =3D=3D=3D
>=20
>=20
> >  =20
> >>
> >> Signed-off-by: Johan Jonker <jbx6244@gmail.com>
> >> ---
> >>  drivers/mtd/nand/raw/rockchip-nand-controller.c | 11 ++++-------
> >>  1 file changed, 4 insertions(+), 7 deletions(-)
> >>
> >> diff --git a/drivers/mtd/nand/raw/rockchip-nand-controller.c
> >> b/drivers/mtd/nand/raw/rockchip-nand-controller.c index
> >> 31d8c7a87..fcda4c760 100644 ---
> >> a/drivers/mtd/nand/raw/rockchip-nand-controller.c +++
> >> b/drivers/mtd/nand/raw/rockchip-nand-controller.c @@ -566,9
> >> +566,10 @@ static int rk_nfc_write_page_raw(struct nand_chip
> >> *chip, const u8 *buf,
> >>  		 *    BBM  OOB1 OOB2 OOB3 |......|  PA0  PA1  PA2
> >>  PA3 *
> >>  		 * The rk_nfc_ooblayout_free() function already
> >> has reserved
> >> -		 * these 4 bytes with:
> >> +		 * these 4 bytes together with 2 bytes for BBM
> >> +		 * by reducing it's length:
> >>  		 *
> >> -		 * oob_region->offset =3D NFC_SYS_DATA_SIZE + 2;
> >> +		 * oob_region->length =3D rknand->metadata_size -
> >> NFC_SYS_DATA_SIZE - 2; */
> >>  		if (!i)
> >>  			memcpy(rk_nfc_oob_ptr(chip, i),
> >> @@ -945,12 +946,8 @@ static int rk_nfc_ooblayout_free(struct
> >> mtd_info *mtd, int section, if (section)
> >>  		return -ERANGE;
> >>
> >> -	/*
> >> -	 * The beginning of the OOB area stores the reserved data
> >> for the NFC,
> >> -	 * the size of the reserved data is NFC_SYS_DATA_SIZE
> >> bytes.
> >> -	 */
> >>  	oob_region->length =3D rknand->metadata_size -
> >> NFC_SYS_DATA_SIZE - 2;
> >> -	oob_region->offset =3D NFC_SYS_DATA_SIZE + 2;
> >> +	oob_region->offset =3D 2;
> >>
> >>  	return 0;
> >>  }
> >> --
> >> 2.30.2
> >> =20
> >=20
> >=20
> > Thanks,
> > Miqu=C3=A8l =20


Thanks,
Miqu=C3=A8l
