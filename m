Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34A2C5F407B
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 12:01:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229914AbiJDKBL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 06:01:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbiJDKBF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 06:01:05 -0400
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::226])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02560220F1
        for <linux-kernel@vger.kernel.org>; Tue,  4 Oct 2022 03:01:03 -0700 (PDT)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id E476CC001A;
        Tue,  4 Oct 2022 10:00:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1664877662;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WiWAu1BS1430Fu+5esZ1phhP6sKKWe2L+ad7HMfvpk4=;
        b=j5p/5rhwGwMoQSmr2Yhyk814sHn81cwgnnHZ+i7RrfutZU2Kwje6OUKfUXx/V77NwYMBmh
        LVq8CIB9PJeZV5dL8uuO5ugwrYFpZWiotwWvrbGgovMVxLj3JA3aQ4olIldk+GywTF1Q18
        0tJYJRHwm807E4QvtBCXGUNM/U5ubyY60dqX9NkNpSlCarqzi9CgccMH0AV275zlVThOh5
        bRyJ1XJmMXP9BoOindgC+YWJKIW/TFlS56CRWtJQVzaOpS1zqOWSJ3hU+uyfTcHrSNRaSE
        RUjcAcZQjzze5U9UP5JJHus7f5R8MeMZA0Jg5rTDJLY9H6suTHfitS4CQYJayQ==
Date:   Tue, 4 Oct 2022 12:00:58 +0200
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
Message-ID: <20221004120058.409a9552@xps-13>
In-Reply-To: <482a4114-eeb1-2303-2896-8e480abda876@alliedtelesis.co.nz>
References: <20220927024728.28447-1-chris.packham@alliedtelesis.co.nz>
        <482a4114-eeb1-2303-2896-8e480abda876@alliedtelesis.co.nz>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chris,

Chris.Packham@alliedtelesis.co.nz wrote on Mon, 3 Oct 2022 21:46:31
+0000:

> Hi All,
>=20
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
> > Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz> =20
>=20
> Just following up on this. I know things have probably been busy with=20
> the 6.0 release but it's been a week so I figured I'd give this a bump.

I was just off the past week :)

I will queue it soon.

>=20
> > ---
> >
> > Notes:
> >      I think this is a bug that's been lurking for 4 years or so. I'm n=
ot
> >      sure that's particularly long in the life of an embedded device bu=
t it
> >      does make me wonder if there have been other bug reports about it.

I don't remember any... Indeed this must be fixed.

> >      We noticed this because we had a bootloader that used maxed out NA=
ND
> >      timings which made the time it took the kernel to do anything on t=
he
> >      file system longer than we expected.
> >
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
