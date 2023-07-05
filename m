Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90935747DFE
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 09:12:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232148AbjGEHMI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 03:12:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231598AbjGEHMG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 03:12:06 -0400
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1989195
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jul 2023 00:12:03 -0700 (PDT)
X-GND-Sasl: miquel.raynal@bootlin.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1688541122;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=L7jc5eO5JMencMFX5rVgNG4uz5Hx+04V7kPTSHBHoYk=;
        b=kb+tLd7fuJE8DgNzgVSRlmgLxcOsOM8NrhodvtvjGnCKwT25KER16HNPwA1bXuvqlcuEsq
        kY3h/wf8EwjREtY7FbB/C/EsOiS3NqxV7kPGoPrLEs3J2Hksz6Elvn5pSW/I6FVBPLu8YT
        PzHHSlKxlwfFPAUIdcTCMZ6aGG6FURigxcEPxgFVo98sX7+mpk+Nhir1SZwWRklNVcvTLL
        hrVOpQpJUXKYjVZ7ZnIFlEhrwtDxaBzU88CDNH3LjUvYJMPMxd9tSYCLKdVg9/ur8MRyKF
        R9Ct9hfJdNHiNy6laijYXleLgCv6N/LWcyvxxLG1Rt31rlwkcLKm+uafHJo3vg==
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
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 6699E2000D;
        Wed,  5 Jul 2023 07:11:59 +0000 (UTC)
Date:   Wed, 5 Jul 2023 09:11:58 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     William Zhang <william.zhang@broadcom.com>
Cc:     Broadcom Kernel List <bcm-kernel-feedback-list@broadcom.com>,
        Linux MTD List <linux-mtd@lists.infradead.org>,
        f.fainelli@gmail.com, rafal@milecki.pl, kursad.oney@broadcom.com,
        joel.peshkin@broadcom.com, computersforpeace@gmail.com,
        anand.gore@broadcom.com, dregan@mail.com, kamal.dasu@broadcom.com,
        tomer.yacoby@broadcom.com, dan.beygelman@broadcom.com,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        linux-kernel@vger.kernel.org,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Richard Weinberger <richard@nod.at>,
        Boris Brezillon <bbrezillon@kernel.org>,
        Kamal Dasu <kdasu.kdev@gmail.com>
Subject: Re: [PATCH v3 5/5] mtd: rawnand: brcmnand: Fix mtd oobsize
Message-ID: <20230705091158.2fe0a271@xps-13>
In-Reply-To: <c09a72df-c49f-75e9-e95e-4e19fe10a278@broadcom.com>
References: <20230627193738.19596-1-william.zhang@broadcom.com>
        <20230627193738.19596-6-william.zhang@broadcom.com>
        <20230704173047.395e445e@xps-13>
        <c09a72df-c49f-75e9-e95e-4e19fe10a278@broadcom.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi William,

william.zhang@broadcom.com wrote on Tue, 4 Jul 2023 17:50:28 -0700:

> Hi Miquel,
>=20
> On 07/04/2023 08:30 AM, Miquel Raynal wrote:
> > Hi William,
> >=20
> > william.zhang@broadcom.com wrote on Tue, 27 Jun 2023 12:37:38 -0700:
> >  =20
> >> brcmnand controller can only access the flash spare area up to certain
> >> bytes based on the ECC level. It can be less than the actual flash spa=
re
> >> area size. For example, for many NAND chip supporting ECC BCH-8, it has
> >> 226 bytes spare area. But controller can only uses 218 bytes. So brcma=
nd
> >> driver overrides the mtd oobsize with the controller's accessible spare
> >> area size. When the nand base driver utilizes the nand_device object, =
it
> >> resets the oobsize back to the actual flash spare aprea size from
> >> nand_memory_organization structure and controller may not able to acce=
ss
> >> all the oob area as mtd advises.
> >>
> >> This change fixes the issue by overriding the oobsize in the
> >> nand_memory_organization structure to the controller's accessible spare
> >> area size. =20
> >=20
> > I am clearly not a big fan of this solution. memorg should be and
> > remain a read only object. Can you please find another solution?
> >  =20
> I was debating on this too but I don't see option because there is no oth=
er hooks after nanddev_init to set the mtd->oobsize as far as I can see and=
 I see there were similar fixes for other controller drivers after the nand=
 device object init was committed, for example:
> Fixes: 629a442cad5f ("mtd: rawnand: Fill memorg during detection")

You are right, that was indeed the first approach, I'll remain on this
path then. Thanks for the pointer.

>=20
> I will think through this again but I am open to any suggestion.
>=20
> >>
> >> Fixes: a7ab085d7c16 ("mtd: rawnand: Initialize the nand_device object")
> >> Signed-off-by: William Zhang <william.zhang@broadcom.com>
> >>
> >> ---
> >>
> >> Changes in v3: None
> >> Changes in v2: None
> >>
> >>   drivers/mtd/nand/raw/brcmnand/brcmnand.c | 7 +++++--
> >>   1 file changed, 5 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/drivers/mtd/nand/raw/brcmnand/brcmnand.c b/drivers/mtd/na=
nd/raw/brcmnand/brcmnand.c
> >> index 407bf79cbaf4..39c7f547db1f 100644
> >> --- a/drivers/mtd/nand/raw/brcmnand/brcmnand.c
> >> +++ b/drivers/mtd/nand/raw/brcmnand/brcmnand.c
> >> @@ -2647,6 +2647,8 @@ static int brcmnand_setup_dev(struct brcmnand_ho=
st *host)
> >>   	struct nand_chip *chip =3D &host->chip;
> >>   	const struct nand_ecc_props *requirements =3D
> >>   		nanddev_get_ecc_requirements(&chip->base);
> >> +	struct nand_memory_organization *memorg =3D
> >> +		nanddev_get_memorg(&chip->base);
> >>   	struct brcmnand_controller *ctrl =3D host->ctrl;
> >>   	struct brcmnand_cfg *cfg =3D &host->hwcfg;
> >>   	char msg[128];
> >> @@ -2668,10 +2670,11 @@ static int brcmnand_setup_dev(struct brcmnand_=
host *host)
> >>   	if (cfg->spare_area_size > ctrl->max_oob)
> >>   		cfg->spare_area_size =3D ctrl->max_oob;
> >>   	/*
> >> -	 * Set oobsize to be consistent with controller's spare_area_size, as
> >> -	 * the rest is inaccessible.
> >> +	 * Set mtd and memorg oobsize to be consistent with controller's
> >> +	 * spare_area_size, as the rest is inaccessible.
> >>   	 */
> >>   	mtd->oobsize =3D cfg->spare_area_size * (mtd->writesize >> FC_SHIFT=
);
> >> +	memorg->oobsize =3D mtd->oobsize; =20
> >>   >>   	cfg->device_size =3D mtd->size; =20
> >>   	cfg->block_size =3D mtd->erasesize; =20
> >=20
> >=20
> > Thanks,
> > Miqu=C3=A8l
> >  =20


Thanks,
Miqu=C3=A8l
