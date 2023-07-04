Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F80D747554
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 17:30:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231626AbjGDPa4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 11:30:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231273AbjGDPay (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 11:30:54 -0400
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E17E1B6
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jul 2023 08:30:53 -0700 (PDT)
X-GND-Sasl: miquel.raynal@bootlin.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1688484652;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dZX16cb0vysqNBL15q7yQtbXUFPDe1wHeaQILrdlWpc=;
        b=alTsk9caUlt0vIzwV4iDsME7+ossT3XY51toxhwiV9KXtoCzrCr/PnkHy/Y/lWRttvIfQz
        p020Sm1vdFCREet1PQwSNBSIncyv4tBC9tED4Jsvvwaw8lzXNwuQNb1Mw0owQb0+2SIkiU
        C6eVevnS/CCllnnNTCf1WAOFnH6FGvs6ijt1xgtCP5dlhr7aCtkgYt1K2mA6O2LHLgZTuZ
        RIMyOZD14q0WKNNPfg8z3c8Fun0gmYC5OnAbfBXq8hlormHJT47ajC6VXq7oDQFk0P4HIk
        iqZhzHGrQzCvcj1zTuLfzdb8N7WvC+nbAs48vqdiv7dH+mCd0QXeK4T6rNncUg==
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
Received: by mail.gandi.net (Postfix) with ESMTPSA id 82425E0011;
        Tue,  4 Jul 2023 15:30:48 +0000 (UTC)
Date:   Tue, 4 Jul 2023 17:30:47 +0200
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
Message-ID: <20230704173047.395e445e@xps-13>
In-Reply-To: <20230627193738.19596-6-william.zhang@broadcom.com>
References: <20230627193738.19596-1-william.zhang@broadcom.com>
        <20230627193738.19596-6-william.zhang@broadcom.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi William,

william.zhang@broadcom.com wrote on Tue, 27 Jun 2023 12:37:38 -0700:

> brcmnand controller can only access the flash spare area up to certain
> bytes based on the ECC level. It can be less than the actual flash spare
> area size. For example, for many NAND chip supporting ECC BCH-8, it has
> 226 bytes spare area. But controller can only uses 218 bytes. So brcmand
> driver overrides the mtd oobsize with the controller's accessible spare
> area size. When the nand base driver utilizes the nand_device object, it
> resets the oobsize back to the actual flash spare aprea size from
> nand_memory_organization structure and controller may not able to access
> all the oob area as mtd advises.
>=20
> This change fixes the issue by overriding the oobsize in the
> nand_memory_organization structure to the controller's accessible spare
> area size.

I am clearly not a big fan of this solution. memorg should be and
remain a read only object. Can you please find another solution?

>=20
> Fixes: a7ab085d7c16 ("mtd: rawnand: Initialize the nand_device object")
> Signed-off-by: William Zhang <william.zhang@broadcom.com>
>=20
> ---
>=20
> Changes in v3: None
> Changes in v2: None
>=20
>  drivers/mtd/nand/raw/brcmnand/brcmnand.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/mtd/nand/raw/brcmnand/brcmnand.c b/drivers/mtd/nand/=
raw/brcmnand/brcmnand.c
> index 407bf79cbaf4..39c7f547db1f 100644
> --- a/drivers/mtd/nand/raw/brcmnand/brcmnand.c
> +++ b/drivers/mtd/nand/raw/brcmnand/brcmnand.c
> @@ -2647,6 +2647,8 @@ static int brcmnand_setup_dev(struct brcmnand_host =
*host)
>  	struct nand_chip *chip =3D &host->chip;
>  	const struct nand_ecc_props *requirements =3D
>  		nanddev_get_ecc_requirements(&chip->base);
> +	struct nand_memory_organization *memorg =3D
> +		nanddev_get_memorg(&chip->base);
>  	struct brcmnand_controller *ctrl =3D host->ctrl;
>  	struct brcmnand_cfg *cfg =3D &host->hwcfg;
>  	char msg[128];
> @@ -2668,10 +2670,11 @@ static int brcmnand_setup_dev(struct brcmnand_hos=
t *host)
>  	if (cfg->spare_area_size > ctrl->max_oob)
>  		cfg->spare_area_size =3D ctrl->max_oob;
>  	/*
> -	 * Set oobsize to be consistent with controller's spare_area_size, as
> -	 * the rest is inaccessible.
> +	 * Set mtd and memorg oobsize to be consistent with controller's
> +	 * spare_area_size, as the rest is inaccessible.
>  	 */
>  	mtd->oobsize =3D cfg->spare_area_size * (mtd->writesize >> FC_SHIFT);
> +	memorg->oobsize =3D mtd->oobsize;
> =20
>  	cfg->device_size =3D mtd->size;
>  	cfg->block_size =3D mtd->erasesize;


Thanks,
Miqu=C3=A8l
