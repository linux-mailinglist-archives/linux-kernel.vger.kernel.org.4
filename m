Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9641712B6F
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 19:10:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235975AbjEZRK2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 13:10:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242209AbjEZRK0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 13:10:26 -0400
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89B9B194
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 10:10:21 -0700 (PDT)
X-GND-Sasl: miquel.raynal@bootlin.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1685121019;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+2oPNUWNNL25fhmBEP3l9oxTPkh2QIa8Fcfla8UqYMY=;
        b=DwV60i4S9WpyISd2VMkM/2xs8g2l0LWowdoHRYXXw8GFrGpUfP4e+iMC9TEeBkY21WMcEc
        Ok2pf/zNCLj15Y0f7EYIf+MmoBpamRxnHiT0OqkaJ6Vh7UW+GIEpeWjech0ZRS4bVMhQFa
        nPq5qXEWp+L+yQDkEgrzSv5uR8OUAj4+hJiSrKlCo0k+iF3UVTtRFOQeN7BoLw3/XB8lW9
        Mokx+Dg6NoaDiq7+UIsX4pgP/E91nCHE/1bZXv6n91ny8XMzqVK1QRThaXV9RqiUfTFIs/
        hAnMSemzyD4/w1P8xR5/gw/6qDhw2ODPpcExZxI4tWAhc2aRu9UXcN+iIGEMqA==
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id B56FE2000C;
        Fri, 26 May 2023 17:10:16 +0000 (UTC)
Date:   Fri, 26 May 2023 19:10:15 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Chris Packham <Chris.Packham@alliedtelesis.co.nz>
Cc:     "richard@nod.at" <richard@nod.at>,
        "vigneshr@ti.com" <vigneshr@ti.com>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mtd: rawnand: marvell: ensure timing values are written
Message-ID: <20230526191015.2ea24813@xps-13>
In-Reply-To: <1c039840-25a4-875c-7dc5-f13c522b8156@alliedtelesis.co.nz>
References: <20230523032103.208213-1-chris.packham@alliedtelesis.co.nz>
        <20230523113930.48c631d4@xps-13>
        <1c039840-25a4-875c-7dc5-f13c522b8156@alliedtelesis.co.nz>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chris,

Chris.Packham@alliedtelesis.co.nz wrote on Tue, 23 May 2023 20:42:45
+0000:

> On 23/05/23 21:39, Miquel Raynal wrote:
> > Hi Chris,
> >
> > chris.packham@alliedtelesis.co.nz wrote on Tue, 23 May 2023 15:21:03
> > +1200:
> > =20
> >> When new timing values are calculated in marvell_nfc_setup_interface()
> >> ensure that they will be applied in marvell_nfc_select_target() by
> >> clearing the selected_chip pointer.
> >>
> >> Suggested-by: Miquel Raynal <miquel.raynal@bootlin.com>
> >> Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz> =20
> > I believe this patch deserves Fixes+Cc:stable? =20
>=20
> I agree. I just wasn't sure what to point at with the fixes tag since=20
> you mentioned that it's probably a result in some of the core NAND=20
> infrastructure changing.
>=20
> Maybe b25251414f6e00 ("mtd: rawnand: marvell: Stop implementing=20
> ->select_chip()") is the correct change to point at. =20

Sounds reasonable.

>=20
> >> ---
> >>
> >> Notes:
> >>      This at least gets me to a point where I can illustrated the prob=
lem
> >>      reported to me. It appears that despite the chip correctly report=
ing
> >>      support for SDR timing modes up to 4 the observed tWC is 20ns. I'=
ve not
> >>      seen any actual problem running in this state the only complaint =
is that
> >>      the datasheet says the minimum tWC is 25ns.
> >>     =20
> >>      If I make a change to my bootloader such that the NAND Clock Freq=
uency
> >>      Select bit (0xF2440700:0) to 1 before booting the kernel _and_ I =
remove
> >>      the extra factor of 2 from the period_ns calculation I observe tW=
C of
> >>      about 60ns. If I don't remove the factor of 2 the NAND interface =
doesn't
> >>      work (can't write BBT).
> >>
> >>   drivers/mtd/nand/raw/marvell_nand.c | 6 ++++++
> >>   1 file changed, 6 insertions(+)
> >>
> >> diff --git a/drivers/mtd/nand/raw/marvell_nand.c b/drivers/mtd/nand/ra=
w/marvell_nand.c
> >> index afb424579f0b..3b5e4d5d220f 100644
> >> --- a/drivers/mtd/nand/raw/marvell_nand.c
> >> +++ b/drivers/mtd/nand/raw/marvell_nand.c
> >> @@ -2457,6 +2457,12 @@ static int marvell_nfc_setup_interface(struct n=
and_chip *chip, int chipnr,
> >>   			NDTR1_WAIT_MODE;
> >>   	}
> >>  =20
> >> +	/*
> >> +	 * Reset nfc->selected_chip so the next command will cause the timing
> >> +	 * registers to be restored in marvell_nfc_select_target().
> >> +	 */ =20
> > s/restored/updated/ ?
> >
> > Restored feels like the content vanished. =20
> OK. Will send a v2 later today.
> >> +	nfc->selected_chip =3D NULL;
> >> +
> >>   	return 0;
> >>   }
> >>    =20
> >
> > Thanks,
> > Miqu=C3=A8 =20


Thanks,
Miqu=C3=A8l
