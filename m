Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AA7E70B862
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 11:04:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232718AbjEVJEO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 05:04:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232632AbjEVJDx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 05:03:53 -0400
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::223])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1AE7186
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 02:03:33 -0700 (PDT)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 4D50060010;
        Mon, 22 May 2023 09:03:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1684746212;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=R0HcuTU2UCgw9VcTnmEo+XoqYG8ERjbKkITJFS/jwPs=;
        b=o8umssakrgdfoZtB3GvflVD8uShVyzA0rYtAVC0EiXg71bJ4TN5+e1oSFq1LwILmshm2nm
        UonmQinev9HZR3BK6Bbl9Bnh5hszGB6+W4cum1XUJn59CaalrrdOn7Y4AoAdHn8LthxA0p
        EUoFF04vTyVBqiNB7mlMuXzviFDQT8STCSJhjr90VJPJtC68Ne+WIDx1FldP67c0AOELDv
        vtpVIoDIHT4EgNSc+bkvAB1Mb8sWlUFzTpWIQoFNadG+6KQMOHx/PnE/kaNe/TNkAtkYE/
        60BLRGqxKjv3KjkIVFjlJ3AXc2bSJlYdZT8U35OYyjIIJ/dh8+evVubl9Hg6aA==
Date:   Mon, 22 May 2023 11:03:30 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Chris Packham <Chris.Packham@alliedtelesis.co.nz>
Cc:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Marvell NFC timings on CN9130
Message-ID: <20230522110330.6763a008@xps-13>
In-Reply-To: <7eb842b6-77c4-05ad-b984-4bb7ae11c278@alliedtelesis.co.nz>
References: <17a9eee2-d84f-549d-a5ff-da88d43393c1@alliedtelesis.co.nz>
        <20230516192538.45b35b6b@xps-13>
        <40c38662-221f-b9bb-9699-625dd788defd@alliedtelesis.co.nz>
        <82b16918-8930-80ab-a87f-a5eefbff2a70@alliedtelesis.co.nz>
        <7eb842b6-77c4-05ad-b984-4bb7ae11c278@alliedtelesis.co.nz>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chris,

Chris.Packham@alliedtelesis.co.nz wrote on Mon, 22 May 2023 04:53:54
+0000:

> On 22/05/23 10:53, Chris Packham wrote:
> >
> > On 17/05/23 14:22, Chris Packham wrote: =20
> >>
> >> On 17/05/23 05:25, Miquel Raynal wrote: =20
> >>> Hi Chris!
> >>>
> >>> Chris.Packham@alliedtelesis.co.nz wrote on Tue, 16 May 2023 04:46:38
> >>> +0000:
> >>> =20
> >>>> Hi Miquel, Thomas,
> >>>>
> >>>> A hardware colleague reported a concern to me about a new design we=
=20
> >>>> have
> >>>> using the Marvell CN9130 SoC (which I think was called Armada-8K=20
> >>>> before
> >>>> they rebranded).
> >>>>
> >>>> Basically their concern is that the tWC timing they observe is faster
> >>>> (~18ns) than the documented minimum in the hardware datasheet for the
> >>>> CN9130 (25ns). Aside from not meeting the datasheet spec we've not
> >>>> observed any other issue (yet). =20
> >>> I would have expected the controller to support almost any kind of
> >>> timings, including SDR EDO mode 5. tWC is 25ns with mode 4, but 20 on
> >>> mode 5 (ONFI). So I believe you're running a system with a chip that =
is
> >>> not compatible with the fastest mode. If that is the case, it may
> >>> explain why you don't see errors with this chip: it may support
> >>> slightly faster timings than it advertises.
> >>>
> >>> Anyway, if your findings are true, it means the current implementation
> >>> is slightly out of spec and the timing calculation might require to be
> >>> tweaked a little bit to reduce tWC.
> >>> =20
> >>>> I notice in the marvell_nand.c driver that marvell_nfc_init() sets t=
he
> >>>> NAND Clock Frequency Select bit (0xF2440700:0) to 1 which runs=20
> >>>> according
> >>>> to the datasheet the NAND flash at 400MHz . But the calculations in
> >>>> marvell_nfc_setup_interface() use the value from
> >>>> clk_get_rate(nfc->core_clk) which is still 250MHz so I'm wondering if
> >>>> maybe the fact that the NAND flash is being run faster is having an
> >>>> impact on timings that are calculated around the core_clk frequency.=
 =20
> >>> What if you reset this bit? Do you observe different timings? I hope
> >>> you do, otherwise this is a dead-end. =20
> >> Yes if we clear the bit the timings go from ~18ns to about 30ns. =20
> >>> The timings are derived from this clock but I remember seeing differe=
nt
> >>> rates than the ones I expected with no obvious explanation (see the "*
> >>> 2" in the calculation of period_ns and the comment right below). So
> >>> maybe this is due to the 400MHz vs. 250MHz issue you are reporting, or
> >>> there is an undocumented pre-scaler in-between (this is my original
> >>> guess). =20
> >>
> >> I wondered if the * 2 was because of this or because of the comment=20
> >> that the ECC_CLK is 2*NF_CLK. That probably also means that a number=20
> >> of SoCs are running with an extra *2 that don't need to be (e.g.=20
> >> Armada-385). =20
> > Interestingly cp110-system-controller.c is aware of the 400MHz option=20
> > but that's only effective if it's been set prior to the kernel=20
> > booting. I'm not really familiar with clk drivers but I assume it must=
=20
> > be possible to make it look up the frequency dynamically instead of=20
> > using a single fixed value. =20
> >> =20
> >>>> Do you think that the timings calculations should take the NAND Clock
> >>>> Frequency Select setting into account? =20
> >>> There is not much about this clock in the manual, so if the clock is
> >>> feeding the logic of the controller generating the signals on the bus,
> >>> then yes. You can verify this with the test mentioned above.
> >>>
> >>> Could you check the values set to tWP and tWH with and without the bit
> >>> and probe the signals in both cases? Maybe the "* 2" in the
> >>> period_ns calculation will vanish if we use 400MHz as input clock=20
> >>> rather
> >>> than clk_get_rate() (or better, expose the bit as a mux-clock and use
> >>> it to tell the CCF the right frequency) and you'll get a sharper tWC =
in
> >>> the end, which hopefully should match the spec this time. =20
> >>
> >> I was going to have a look to see if I can get the NAND clock to=20
> >> correctly reflect the value when the NAND Clock Frequency Select bit=20
> >> is set. In the meantime I'll also do some experiments removing the *=20
> >> 2 and hard-coding the frequency at 400MHz. =20
>=20
> I learnt something over the course of the day. Given timezones I thought=
=20
> it might be worthwhile getting them out there even if I don't have a=20
> patch to offer.

Of course :)

> It appears that only the first set of timings calculated by=20
> marvell_nfc_setup_interface() are used. This is because=20
> marvell_nfc_select_target() returns early if we are addressing the same=20
> chip. So even when we take the SDR timings into account we don't make=20
> full use of them in NDTR0/1.

The logic in the core has changed in the past, it is possible
that we did not catch a corner case in this driver.

Maybe this would cleanly solve the problem (there is similar operation
somewhere else in the driver):

--- a/drivers/mtd/nand/raw/marvell_nand.c
+++ b/drivers/mtd/nand/raw/marvell_nand.c
@@ -2457,6 +2457,9 @@ static int marvell_nfc_setup_interface(struct nand_ch=
ip *chip, int chipnr,
                        NDTR1_WAIT_MODE;
        }
=20
+       /* Ensure the next *_select_target() call will write the timing reg=
isters */
+       nfc->selected_chip =3D NULL;
+
        return 0;
 }

> The original problem I reported was from a customized kernel which=20
> included a change to write out the NDTR0/1 registers at the end of=20
> marvell_nfc_setup_interface(). So I can make my problem go away by=20
> removing the writes to NDTR0/1 but then instead of being too fast they=20
> are now way too slow. That'd probably keep the HW engineers happy but it=
=20
> feels a bit wrong.

Yeah, not the right approach.

Thanks,
Miqu=C3=A8l
