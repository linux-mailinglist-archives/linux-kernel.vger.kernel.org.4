Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4CFF750A2F
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 15:58:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232824AbjGLN5u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 09:57:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230505AbjGLN5s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 09:57:48 -0400
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B11410C7
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 06:57:45 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id A2FDC20004;
        Wed, 12 Jul 2023 13:57:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1689170264;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nxYieBDD/UDWjFAzPZZdyOGHwowhnvx3mmO2fP0LAKE=;
        b=Q2DVoSXcl1KdQCDPhgpypP7YTE87CmV9UJndeYvo4HwwZFjZ0YiOIaXUhadMYsXYbsrVXz
        +rxDzWWb8Tkosf/kmAnzF4mFCJJ7DAKynfcwlxJjZsSkR4f7ODqPZpExnl6IwQGlbBSRCc
        O34S5ULzW4ix2Se2jW0tbUuRwreikKhJycCkwysA5BMsYlbFzvtplU8/cp2oroPEpqHAKE
        ecXOGXq58AbdGjXXi0QaaHOFMB6a6RH4HOUx/6117PkweBWITXZ88uPae1E54f+T74rEMs
        b/vefBV2tY/fG746gAgj6Aq4nIY2SQ/7Pn+XXJb5psIwBEjQoqHkur9Sp9MAAA==
Date:   Wed, 12 Jul 2023 15:57:40 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Johan Jonker <jbx6244@gmail.com>
Cc:     richard@nod.at, vigneshr@ti.com, heiko@sntech.de,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, yifeng.zhao@rock-chips.com
Subject: Re: [PATCH v3 3/3] mtd: rawnand: rockchip-nand-controller: add
 skipbbt option
Message-ID: <20230712154142.3c49d782@xps-13>
In-Reply-To: <3af40582-d350-8eac-8639-10c285964c49@gmail.com>
References: <0047fc52-bc45-a768-8bdd-c0f12cddc17e@gmail.com>
        <457c1da7-61dc-2a56-4f86-47413795138c@gmail.com>
        <20230704171348.5eee98f7@xps-13>
        <3af40582-d350-8eac-8639-10c285964c49@gmail.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: miquel.raynal@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Johan,

Richard, a question for you below :-)

jbx6244@gmail.com wrote on Fri, 7 Jul 2023 17:27:56 +0200:

> Hi Miquel,
>=20
> Some comments/questions below,

There are a lot, I've selected the ones which appear the most relevant
to me right now.

> On 7/4/23 17:13, Miquel Raynal wrote:
> > Hi Johan,
> >=20
> > jbx6244@gmail.com wrote on Thu, 15 Jun 2023 19:34:26 +0200:
> >  =20
> >> On Rockchip SoCs the first boot stages are written on NAND =20
>=20
> >> with help of manufacturer software that uses a different format
> >> then the MTD framework. Skip the automatic BBT scan with the =20
>=20
> Not only about the boot blocks.
> The rest of the Nand is formatted as well by closed source.
> It formats the location at the new BBT pages as well.
>=20
> >> NAND_SKIP_BBTSCAN option so that the original content is unchanged
> >> during the driver probe.
> >> The NAND_NO_BBM_QUIRK option allows us to erase bad blocks with
> >> the nand_erase_nand() function and the flash_erase command.
> >> With these options the user has the "freedom of choice" by neutral
> >> access mode to read and write in whatever format is needed. =20
> >  =20
>=20
> > Can the boot_rom_mode thing help? =20
>=20
> This boot_rom_mode thing is for switching ECC mode in boot block pages an=
d is not related to BBT pages.
>=20
> >=20
> > For writing this part you can disable the bad block protection using
> > debugfs and then write an externally processed file in raw mode I guess=
. =20
>=20
> The use of debugfs only might make sense when the driver can pass the pro=
be function without errors.
> It does however not save guard existing data when it creates and writes t=
o a new BBT page location.
> When the data at the new BBT pages previously is written with a different=
 ECC or data/OOB format the hardware driver probe fails.
>=20
> Your suggestion does not work for the Rockchip case.
> Please advise what to do with this patch.
>=20
> =3D=3D=3D
>=20
> [ 2148.026403] calling  rk_nfc_driver_init+0x0/0x1000 [rockchip_nand_cont=
roller] @ 2062
> [ 2148.039156] rockchip-nfc 10500000.nand-controller: timing 11e1
> [ 2148.056891] nand: device found, Manufacturer ID: 0xad, Chip ID: 0xde
> [ 2148.067700] nand: Hynix H27UCG8T2ATR-BC 64G 3.3V 8-bit
> [ 2148.076717] nand: 8192 MiB, MLC, erase size: 2048 KiB, page size: 8192=
, OOB size: 640
> [ 2148.089022] rockchip-nfc 10500000.nand-controller: hynix_nand_init
> [ 2148.099317] rockchip-nfc 10500000.nand-controller: h27ucg8t2atrbc_choo=
se_interface_config
> [ 2148.111779] rockchip-nfc 10500000.nand-controller: timing 11e1
> [ 2148.129836] rockchip-nfc 10500000.nand-controller: rd hw page: 1048575
> [ 2148.149364] rockchip-nfc 10500000.nand-controller: read page: fffff ec=
c error!
> [ 2148.160742] rockchip-nfc 10500000.nand-controller: rd hw page: 1048319
> [ 2148.180164] rockchip-nfc 10500000.nand-controller: read page: ffeff ec=
c error!
> [ 2148.191413] rockchip-nfc 10500000.nand-controller: rd hw page: 1048063
>=20
> [..]
>=20
> Check for existing BBT pages.
>=20
> [ 2148.339836] rockchip-nfc 10500000.nand-controller: read page: ffdff ec=
c error!
> [ 2148.350864] rockchip-nfc 10500000.nand-controller: rd hw page: 1047807
> [ 2148.369835] rockchip-nfc 10500000.nand-controller: read page: ffcff ec=
c error!
> [ 2148.380597] Bad block table not found for chip 0
> [ 2148.388479] Scanning device for bad blocks
> [ 2148.395591] rockchip-nfc 10500000.nand-controller: rd hw page: 255
> [ 2148.414087] rockchip-nfc 10500000.nand-controller: read page: max_bitf=
lips: 0
>=20
> [..]
>=20
> Check all pages to create a new BBT.
>=20
> [ 2258.693279] rockchip-nfc 10500000.nand-controller: rd hw page: 1030143
> [ 2258.710970] rockchip-nfc 10500000.nand-controller: read page: max_bitf=
lips: 0
> [ 2258.720804] rockchip-nfc 10500000.nand-controller: rd hw page: 1030399
> [ 2258.738394] rockchip-nfc 10500000.nand-controller: read page: fb8ff ec=
c error!
> [ 2258.748229] Bad eraseblock 4024 at 0x0001f7000000
>=20
> [..]
>=20
> All BBT pages are marked bad, so it thinks there's no space left
>=20
> [ 2261.403708] rockchip-nfc 10500000.nand-controller: rd hw page: 1048575
> [ 2261.422750] rockchip-nfc 10500000.nand-controller: read page: fffff ec=
c error!
> [ 2261.433634] Bad eraseblock 4095 at 0x0001ffe00000
>=20
> [ 2261.441723] No space left to write bad block table
>=20
> This is not done.
> A Nand disk should not be altered if it's formatted in a different format=
 unless an explicit command is given.
>=20
> [ 2261.449860] nand_bbt: error while writing bad block table -28
> [ 2261.467156] rockchip-nfc 10500000.nand-controller: failed to init NAND=
 chips
> [ 2261.477917] rockchip-nfc: probe of 10500000.nand-controller failed wit=
h error -28
> [ 2261.497011] probe of 10500000.nand-controller returned 28 after 113456=
649 usecs
> [ 2261.508273] initcall rk_nfc_driver_init+0x0/0x1000 [rockchip_nand_cont=
roller] returned 0 after 113468040 usecs
>=20
> Probe failed, but there nothing wrong with hardware.
> MTDx partitions are not created.
> User space commands that rely strings like "/dev/mtd0" don't work.
>=20
> =3D=3D=3D
>=20
> Application
> Kernel
> Drivers
> Hardware
>=20
> Why do we fail a hardware driver probe when the level above doesn't deal =
with all real world situations.
> Shouldn't that be more separated in MTD levels.
>=20
> =3D=3D=3D
>=20
> >=20
> > For the boot I think I proposed a DT property. I don't remember how far
> > the discussion went. =20
>=20
> Is there a web link of that discussion?

https://lore.kernel.org/linux-mtd/20230609104426.3901df54@xps-13/

Maybe the term "DT property" did not appear but that's what I had in
mind :-) I don't know if it must be a chip or a partition property.

Richard, here is where I would like your feedback, I am kind of opposed
to a "skip_bbt" module parameter. It's not a strong opinion, if you
think it's fine I'm open.

I would rather prefer a DT property which says "do not use the
standard pattern".

Johan, how are bad blocks supposed to be tracked if the bad block
tables are written in a way which does not allow Linux to read it?

> How do I link 'compatible' to '/dev/mtd0' for example.
> In a '/proc/mtd' entry?
> See /drivers/mtd/spi-nor/debugfs.c
>=20
>=20
> In order to write boot blocks in a pattern it needs to know the chip ID a=
s used in nand_flash_ids[].
> How can we export this ID to userspace?

There was an attempt a few days back, it's not upstream, I can't find
it back ATM. I'll send it once I find it back.

> Also in a '/proc/mtd' entry?
>=20
> =3D=3D=3D
>=20
> 		partitions {
> 			compatible =3D "fixed-partitions";
> 			#address-cells =3D <2>;
> 			#size-cells =3D <2>;
>=20
> 			partition@0 {
> 				reg =3D <0x0 0x0 0x0 0x02000000>;
> 				compatible =3D "rockchip,boot-blk";
> 				label =3D "boot-blk";
> 			};
>=20
> 			partition@2000000 {
> 				reg =3D <0x0 0x02000000 0x1 0xfa000000>;
> 				label =3D "rootfs";
> 			};
>=20
> 			partition@1fc000000 {
> 				reg =3D <0x1 0xfc000000 0x0 0x04000000>;
> 				compatible =3D "mtd,bbt"
> 				label =3D "bbt";

This does not work, it would take me hours to explain why, it's all
about:
- stability
- how mtd has been implemented

> 			};
> 		};
>=20
> How many erase blocks is MTD using for BBT pages? 4 or 8 or ?

As many blocks are needed to cover the size of the device, times 2.

> BBT pages are not clearly defined in the DT.

No, because this is software, not hardware. MTD is a Linux thing, which
gives you access to an mtd device through a number of operations. It
handles bad blocks.

> They are somehow marked bad in the overlapping partition.

Not sure what "overlapping partition" means.

> How are suppose to erase BBT pages in a automated way?
> Is there a need for a new BBT compatible?

No, Linux has run with this standard pattern for 20 years, downstream
kernels sometimes make silly design decisions, we do not want to
support them.

> What is your idea about compatibles suggestion:
> rockchip,boot-blk
> mtd,bbt
>=20
> =3D=3D=3D
>=20
> Johan
>=20
> >  =20
> >>
> >> Signed-off-by: Johan Jonker <jbx6244@gmail.com>
> >> ---
> >>
> >> Changes V3:
> >>   Change prefixes
> >>
> >> Changed V2:
> >>   reword
> >>
> >> ---
> >>
> >> I'm aware that the maintainer finds it "awful",
> >> but it's absolute necessary to:
> >> 1: read/write boot blocks in user space without touching original cont=
ent
> >> 2: format a NAND for MTD either with built in or external driver module
> >>
> >> So we keep it include in this serie.
> >> ---
> >>  drivers/mtd/nand/raw/rockchip-nand-controller.c | 7 +++++++
> >>  1 file changed, 7 insertions(+)
> >>
> >> diff --git a/drivers/mtd/nand/raw/rockchip-nand-controller.c b/drivers=
/mtd/nand/raw/rockchip-nand-controller.c
> >> index 5a0468034..fcda4c760 100644
> >> --- a/drivers/mtd/nand/raw/rockchip-nand-controller.c
> >> +++ b/drivers/mtd/nand/raw/rockchip-nand-controller.c
> >> @@ -188,6 +188,10 @@ struct rk_nfc {
> >>  	unsigned long assigned_cs;
> >>  };
> >>
> >> +static int skipbbt;
> >> +module_param(skipbbt, int, 0644);
> >> +MODULE_PARM_DESC(skipbbt, "Skip BBT scan if data on the NAND chip is =
not in MTD format.");
> >> +
> >>  static inline struct rk_nfc_nand_chip *rk_nfc_to_rknand(struct nand_c=
hip *chip)
> >>  {
> >>  	return container_of(chip, struct rk_nfc_nand_chip, chip);
> >> @@ -1153,6 +1157,9 @@ static int rk_nfc_nand_chip_init(struct device *=
dev, struct rk_nfc *nfc,
> >>
> >>  	nand_set_controller_data(chip, nfc);
> >>
> >> +	if (skipbbt)
> >> +		chip->options |=3D NAND_SKIP_BBTSCAN | NAND_NO_BBM_QUIRK;
> >> +
> >>  	chip->options |=3D NAND_USES_DMA | NAND_NO_SUBPAGE_WRITE;
> >>  	chip->bbt_options =3D NAND_BBT_USE_FLASH | NAND_BBT_NO_OOB;
> >>
> >> --
> >> 2.30.2
> >> =20
> >=20
> >=20
> > Thanks,
> > Miqu=C3=A8l =20


Thanks,
Miqu=C3=A8l
