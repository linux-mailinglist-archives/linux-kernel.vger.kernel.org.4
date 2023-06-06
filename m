Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2F61723856
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 09:03:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232832AbjFFHDz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 03:03:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231416AbjFFHDw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 03:03:52 -0400
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13B9BC5
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 00:03:50 -0700 (PDT)
X-GND-Sasl: miquel.raynal@bootlin.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1686035029;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=reafBMrUZj+7Va9OhYXaqDy3QOGdwu434t/u9hYeCkc=;
        b=fnifd9QSx/KpYKg+eS5X/XcAS3vs+xQ765oNv2AoThbgpBo4q/8H4ROsyNwUKf7a+GaNXU
        ihJW2gBv4OxsC7hs5iP1ukBE9v6lXuY/9lU7+ycDkRCe0k4mk0g0SrzPY3WtdGc4HPRB5m
        sksNXL/kJl9/jfeSV/ShbSMAm1zEUcF2pBjItDgHftHEf887pHrpPsyNMFgJQvUk9P5V4J
        YPqDsV70g4NU9caJyKhE2dnCmoDnkno6IRXzarZlDCjR8sXA1iIj4bhAez1YEsxc0VLaSR
        gW2mch4tYmr5PIRuFzvD6mRZrl/ufF0FkfBDayJpmkRBOUiLhO3CcxMDYvmF+A==
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
Received: by mail.gandi.net (Postfix) with ESMTPSA id 2734820010;
        Tue,  6 Jun 2023 07:03:46 +0000 (UTC)
Date:   Tue, 6 Jun 2023 09:03:44 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Arseniy Krasnov <avkrasnov@sberdevices.ru>
Cc:     Liang Yang <liang.yang@amlogic.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        <oxffffaa@gmail.com>, <kernel@sberdevices.ru>,
        <linux-mtd@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-amlogic@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH v5 2/6] mtd: rawnand: meson: wait for command in
 polling mode
Message-ID: <20230606090344.3aca96c8@xps-13>
In-Reply-To: <c316961d-6021-1cb4-9ff4-22fe9ca5a18a@sberdevices.ru>
References: <20230601061850.3907800-1-AVKrasnov@sberdevices.ru>
        <20230601061850.3907800-3-AVKrasnov@sberdevices.ru>
        <20230601100751.41c3ff0b@xps-13>
        <9e106d50-2524-c999-48b1-a20760238aaf@sberdevices.ru>
        <20230605110546.6cb00a8d@xps-13>
        <2a755783-1d56-9842-2eee-b5ab41152c81@amlogic.com>
        <163e0684-caff-77d0-1eaf-9a58290c200d@amlogic.com>
        <c316961d-6021-1cb4-9ff4-22fe9ca5a18a@sberdevices.ru>
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

Hi Arseniy,

avkrasnov@sberdevices.ru wrote on Mon, 5 Jun 2023 19:58:02 +0300:

> On 05.06.2023 16:30, Liang Yang wrote:
> >=20
> >=20
> > On 2023/6/5 21:19, Liang Yang wrote: =20
> >> Hi Miquel and Arseniy,
> >>
> >>
> >> On 2023/6/5 17:05, Miquel Raynal wrote: =20
> >>> [ EXTERNAL EMAIL ]
> >>>
> >>> Hi Arseniy,
> >>> =20
> >>>>>> @@ -1412,6 +1419,8 @@ static int meson_nfc_probe(struct platform_d=
evice *pdev)
> >>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 return ret;
> >>>>>> =C2=A0=C2=A0=C2=A0 }
> >>>>>>
> >>>>>> +=C2=A0 nfc->use_polling =3D of_property_read_bool(dev->of_node, "=
polling"); =20
> >>>>>
> >>>>> This is a problem. You cannot add a polling property like that.
> >>>>>
> >>>>> There is already a nand-rb property which is supposed to carry how =
are
> >>>>> wired the RB lines. I don't see any in-tree users of the compatible=
s, I
> >>>>> don't know how acceptable it is to consider using soft fallback when
> >>>>> this property is missing, otherwise take the values of the rb lines
> >>>>> provided in the DT and user hardware control, but I would definitely
> >>>>> prefer that. =20
> >>>>
> >>>> I see. So i need to implement processing of this property here? And =
if it
> >>>> is missed -> use software waiting. I think interesting thing will be=
 that:
> >>>>
> >>>> 1) Even with support of this property here, I really don't know how =
to pass
> >>>> =C2=A0=C2=A0=C2=A0 RB values to this controller - I just have define=
 for RB command and that's
> >>>> =C2=A0=C2=A0=C2=A0 it. I found that this property is an array of u32=
 - IIUC each element is
> >>>> =C2=A0=C2=A0=C2=A0 RB pin per chip. May be i need to dive into the o=
ld vendor's driver to find
> >>>> =C2=A0=C2=A0=C2=A0 how to use RB values (although this driver uses s=
oftware waiting so I'm not
> >>>> =C2=A0=C2=A0=C2=A0 sure that I'll find something in it). =20
> >>>
> >>> Liang, can you please give use the relevant information here? How do =
we
> >>> target RB0 and RB1? It seems like you use the CS as only information
> >>> like if the RB lines where hardwired internally to a CS. Can we invert
> >>> the lines with a specific configuration? =20
> >>
> >> Controllor has only one external RB pinmux (NAND_RB0). all the RB pins
> >> of different CEs need to be bound into one wire and connect with
> >> NAND_RB0 if want to use controller polling rb. the current operating
> >> CE of NAND is decided to "chip_select", of course controller internall=
y has different nfc commands to regconize which Ce's RB signal is polling.
> >>
> >> <&nand_pins> in dts/yaml should include the NAND_RB0 if hardware conne=
cts, or use software polling here.
> >>
> >> @Arseniy, sorry, i don't travel all the informations yet. but why don'=
t you use the new RB_INT command with irq that i provided in another thread=
. the new RB_INT command doesn't depend on the physical RB wires, it also s=
end the READ status command(0x70) and wait for the irq wake up completion. =
=20
>=20
> Technically no problem! I can use new RB_INT instead of 'nand_soft_waitrd=
y()' as software fallback, and currently
> implemented RB_INT as interrupt driven way. What do You think Miquel ?
>=20
> >=20
> > Use "nand-rb" in dts to decide old RB_INT(physical RB wires is needed) =
or new RB_INT(no physical RB wires). the new RB_INT command decides the RB0=
 or RB1 by the previous command with ce args.
> >  =20
>=20
> So I can implement "nand-rb" in dts as boolean value - "false" or missing=
 means use "no physical RB wires", "true" - means use "physical RB wires" ?

As long as it works and does not contain any extremely strange READ0 or
READ_STATUS in the middle of nothing, I'm fine, take the simplest
approach which will work for all.

>=20
> Thanks, Arseniy
>=20
> >> =20
> >>> Arseniy, if the answer to my above question is no, then you should
> >>> expect the nand-rb and reg arrays to be identical. If they are not,
> >>> then you can return -EINVAL.
> >>>
> >>> If the nand-rb property is missing, then fallback to software wait.
> >>> =20
> >>>> 2) I can't test RB mode - I don't have such device :(
> >>>>
> >>>> Also for example in arasan-nand-controller.c parsed 'nand-rb' values=
 are used
> >>>> in controller specific register for waiting (I guess Meson controlle=
r has something
> >>>> like that, but I don't have doc). While in marvell_nand.c it looks l=
ike that they parse
> >>>> 'nand-rb' property, but never use it. =20
> >>>
> >>> Yes, the logic around the second RB line (taking care of CS1/CS3) is
> >>> slightly broken or at least badly documented, and thus should not be
> >>> used.
> >>> =20
> >>>>> In any case you'll need a dt-binding update which must be acked by
> >>>>> dt-binding maintainers. =20
> >>>>
> >>>> You mean to add this property desc to Documentation/devicetree/bindi=
ngs/mtd/amlogic,meson-nand.yaml ? =20
> >>>
> >>> Yes. In a dedicated patch. Something along the lines:
> >>>
> >>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 nand-rb: true
> >>>
> >>> inside the nand chip object should be fine. And flag the change as a
> >>> fix because we should have used and parsed this property since the
> >>> beginning.
> >>>
> >>> Thanks,
> >>> Miqu=C3=A8l =20


Thanks,
Miqu=C3=A8l
