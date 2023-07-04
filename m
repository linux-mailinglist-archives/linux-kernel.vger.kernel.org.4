Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AC1B747560
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 17:32:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231694AbjGDPca (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 11:32:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231488AbjGDPc3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 11:32:29 -0400
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2407AE41;
        Tue,  4 Jul 2023 08:32:27 -0700 (PDT)
X-GND-Sasl: miquel.raynal@bootlin.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1688484746;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DmZggtDAqIb+3H1DsPGwwstHZSthhYTo+MwlhjHAqx4=;
        b=bxCsWMXFWRSn3xc8vS5MZRFRhjSv4lVUq9yZ9VsYWfa5AuX342bdiV3TkSRHxUpB0L1zK1
        qDhQbAFUgylbk4X/p0Pn6souCDlx1rLvCd4cceP1NTvG9OR+uDywHn92+VnoHLmobYTiNg
        2vG70IOMxjhvxbujHZWZ+Vgfd1IDFcteMdffHBOkfyGcHJ0Syt1fmwjc5wq8ruz62HwWR4
        yG7DLXfuRwMrKP7/3qXA61FZZSDahDz9EkJIdROeeD0ZndkdfM7fbCMoUTu8DTjGOHq3dR
        da45tf+8+tJwZ6OLiHF+5w2RgI8aqVvexYC2g0QiW9LCpXKAyYiMlcdOmS/VCg==
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
Received: by mail.gandi.net (Postfix) with ESMTPSA id C4787FF80F;
        Tue,  4 Jul 2023 15:32:24 +0000 (UTC)
Date:   Tue, 4 Jul 2023 17:32:23 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Arseniy Krasnov <avkrasnov@sberdevices.ru>
Cc:     Liang Yang <liang.yang@amlogic.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        <oxffffaa@gmail.com>, <kernel@sberdevices.ru>,
        <linux-mtd@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-amlogic@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH v1 2/2] mtd: rawnand: meson: support for 512B ECC
 step size
Message-ID: <20230704173223.771acd99@xps-13>
In-Reply-To: <e45afb19-d77b-6ef3-08bf-68e8626371be@sberdevices.ru>
References: <20230628092937.538683-1-AVKrasnov@sberdevices.ru>
        <20230628092937.538683-3-AVKrasnov@sberdevices.ru>
        <20230704103617.4affae8a@xps-13>
        <9e6eaa87-887c-f955-113a-43860c8ea00c@sberdevices.ru>
        <20230704114110.25ca9de4@xps-13>
        <aede4639-0e99-565a-c997-c414342c66af@sberdevices.ru>
        <20230704115628.55320428@xps-13>
        <ee2eb73a-fb25-58ae-cf7e-83d971b7b8b2@sberdevices.ru>
        <20230704154106.5c5aafd8@xps-13>
        <e45afb19-d77b-6ef3-08bf-68e8626371be@sberdevices.ru>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arseniy,

avkrasnov@sberdevices.ru wrote on Tue, 4 Jul 2023 18:07:04 +0300:

> On 04.07.2023 16:41, Miquel Raynal wrote:
> > Hi Arseniy,
> >  =20
> >>>>>> Yes, this code looks strange. 'nsectors' is used to calculate spac=
e in OOB
> >>>>>> that could be used by ECC engine (this value will be passed as 'oo=
bavail'
> >>>>>> to 'nand_ecc_choose_conf()'). Idea of 512 is to consider "worst" c=
ase
> >>>>>> for ECC, e.g. minimal number of bytes for ECC engine (and at the s=
ame time
> >>>>>> maximum number of free bytes). For Meson, if ECC step size is 512,=
 then we
> >>>>>> have 4 x 2 free bytes in OOB (if step size if 1024 then we have 2 =
x 2 free
> >>>>>> bytes in OOB).
> >>>>>>
> >>>>>> I think this code could be reworked in the following way:
> >>>>>>
> >>>>>> if ECC step size is already known here (from DTS), calculate 'nsec=
tors' using
> >>>>>> given value (div by 512 for example). Otherwise calculate 'nsector=
s' in the
> >>>>>> current manner:     =20
> >>>>>
> >>>>> It will always be known when these function are run. There is no
> >>>>> guessing here.     =20
> >>>>
> >>>> Hm I checked, that but if step size is not set in DTS, here it will =
be 0,=20
> >>>> then it will be selected in 'nand_ecc_choose_conf()' according provi=
ded 'ecc_caps'
> >>>> and 'oobavail'...
> >>>>
> >>>> Anyway, I'll do the following thing:
> >>>>
> >>>> int nsectors;
> >>>>
> >>>> if (nand->ecc.size)
> >>>>     nsectors =3D mtd->writesize / nand->ecc.size; <--- this is for 5=
12 ECC   =20
> >>>
> >>> You should set nand->ecc.size in ->attach_chip() instead.   =20
> >>
> >> Sorry, didn't get it... if ECC step size is set in DTS, then here, in =
chip attach
> >> callback it will be already known (DT part was processed in 'rawnand_d=
t_init()').
> >> If ECC step size is unknown (e.g. 0 here), 'nand_ecc_choose_conf()' wi=
ll set it
> >> according provided ecc caps. What do You mean for "You should set ..."=
 ? =20
> >=20
> > The current approach is wrong, it decides the number of ECC chunks
> > (called nsectors in the driver) and then asks the core to decide the
> > number of ECC chunks to use. =20
>=20
> Yes! I was also confused about that.
>=20
> >=20
> > Just provide mtd->oobsize - 2 as last parameter and then rely on the
> > core's logic to find the right ECC step-size/strength?
> >=20
> > There is no point in requesting a particular step size without a
> > specific strength, or? So I believe you should provide both in the DTS
> > if you want particular parameters to be applied, otherwise you can let
> > the core decide what is best. =20
>=20
> So I think this could be a separated patch as it doesn't rely on 512 step=
 size ECC
> support for Meson and may be it should be "Fix" tagged.

Yup! Thanks for cleaning so thoroughly this driver :)

Cheers,
Miqu=C3=A8l
