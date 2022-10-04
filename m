Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D534B5F4084
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 12:02:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230138AbiJDKCh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 06:02:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230128AbiJDKC3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 06:02:29 -0400
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 348D13055E
        for <linux-kernel@vger.kernel.org>; Tue,  4 Oct 2022 03:02:15 -0700 (PDT)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 4A57FFF803;
        Tue,  4 Oct 2022 10:02:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1664877734;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PJNufpo5Aw2kWb7Q25v6A6DJV5qMXWZuPy0UHJWv6jw=;
        b=LTTypnWeYNiIp9gESF41TtCZdoFBxhpcREQdPnrPOcWYupwP3QgWi8s+ip94BDGmktFY6f
        VpZId9aCJwheyL3FNj3UHZO/nueNe/hMvgnu+9+1SLbdOQ1W4HNAYHOmhVEIcN3mPgEuEo
        J+d2IN1CyLFH46ACAPHAzaHbilC57SjbTMRRL2CXqx9IsC/2eZN4Hj6Yj19GGKT9s8qzrX
        +tCHi3KOPyABQAYf3OeU49XLpiR80u7CBWNo2gk8E3rnHRJvTnRdvsjwTX+WDmgsz1PN74
        76Zmc+TSOoRymoJ+jNcSn9cjIIXgZUHeYpc4JJrF/SX0B9n2Oxj5jzW5W/2YuQ==
Date:   Tue, 4 Oct 2022 12:02:12 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Chris Packham <Chris.Packham@alliedtelesis.co.nz>
Cc:     "richard@nod.at" <richard@nod.at>,
        "vigneshr@ti.com" <vigneshr@ti.com>,
        "bbrezillon@kernel.org" <bbrezillon@kernel.org>,
        Tony O'Brien <Tony.OBrien@alliedtelesis.co.nz>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mtd: rawnand: marvell: Use correct logic for
 nand-keep-config
Message-ID: <20221004120212.6389b96a@xps-13>
In-Reply-To: <e234270c-4169-bddb-5c2d-9c6ac48467b6@alliedtelesis.co.nz>
References: <20220927024728.28447-1-chris.packham@alliedtelesis.co.nz>
        <e234270c-4169-bddb-5c2d-9c6ac48467b6@alliedtelesis.co.nz>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chris,

Chris.Packham@alliedtelesis.co.nz wrote on Tue, 27 Sep 2022 02:54:40
+0000:

> On 27/09/22 15:47, Chris Packham wrote:
> > From: Tony O'Brien <tony.obrien@alliedtelesis.co.nz>
> >
> > Originally the absence of the marvell,nand-keep-config property caused
> > the setup_data_interface function to be provided. However when
> > setup_data_interface was moved into nand_controller_ops the logic was
> > unintentionally inverted. Update the logic so that only if the
> > marvell,nand-keep-config property is present the bootloader NAND config
> > kept.
> >
> > Fixes: 7a08dbaedd36 ("mtd: rawnand: Move ->setup_data_interface() to na=
nd_controller_ops")
> > Signed-off-by: Tony O'Brien <tony.obrien@alliedtelesis.co.nz>
> > Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
> > ---
> >
> > Notes:
> >      I think this is a bug that's been lurking for 4 years or so. I'm n=
ot
> >      sure that's particularly long in the life of an embedded device bu=
t it
> >      does make me wonder if there have been other bug reports about it.
> >     =20
> >      We noticed this because we had a bootloader that used maxed out NA=
ND
> >      timings which made the time it took the kernel to do anything on t=
he
> >      file system longer than we expected. =20
>=20
> I think there might be a similar logic inversion bug in=20
> drivers/mtd/nand/raw/denali.c but I lack the ability to test for that=20
> platform.

Agreed, the denali driver has the same issue. Could you please send a
patch?
=20
>=20
> >   drivers/mtd/nand/raw/marvell_nand.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/mtd/nand/raw/marvell_nand.c b/drivers/mtd/nand/raw=
/marvell_nand.c
> > index 2455a581fd70..b248c5f657d5 100644
> > --- a/drivers/mtd/nand/raw/marvell_nand.c
> > +++ b/drivers/mtd/nand/raw/marvell_nand.c
> > @@ -2672,7 +2672,7 @@ static int marvell_nand_chip_init(struct device *=
dev, struct marvell_nfc *nfc,
> >   	chip->controller =3D &nfc->controller;
> >   	nand_set_flash_node(chip, np);
> >  =20
> > -	if (!of_property_read_bool(np, "marvell,nand-keep-config"))
> > +	if (of_property_read_bool(np, "marvell,nand-keep-config"))
> >   		chip->options |=3D NAND_KEEP_TIMINGS;
> >  =20
> >   	mtd =3D nand_to_mtd(chip) =20


Thanks,
Miqu=C3=A8l
