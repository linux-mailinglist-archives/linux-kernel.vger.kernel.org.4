Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94F0272CD40
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 19:53:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236366AbjFLRxQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 13:53:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231127AbjFLRxO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 13:53:14 -0400
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB816C7
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 10:53:11 -0700 (PDT)
X-GND-Sasl: miquel.raynal@bootlin.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1686592390;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eLGlTgvrhOiI7CIUt2StK8gMQZowawdoEviSYddzekk=;
        b=HWk/zjbuzfAc91L/H+00DKcMgNROXKfM8PErTKAN2EJzSVP3ef0FgZlJ74PLd7gHVXR2eJ
        4IAFHbHqfguHcOocRtCxK784SA0u09turJi550wQ6rXrTN8w9+d0gA0E8Ree+78OZGmNva
        m34Xr0DDpxuxv/mBzuHvgNafOf+NCqfAcqG9MjpQuTHzykBYklrqr+DcuVc7YMQSMhBsXV
        jL86MnMFaHeynyRincRfVyESkc0ePMkFmbgLPtrvklk5yOi1uGvGZ1J+litv4pAZ0FwR8N
        Td4af4mG6dTtq2+1nXH59z1GfzAjUIXaAL8gnH3vOyyUl+WEfqB8v8i8xQ14Kg==
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
Received: by mail.gandi.net (Postfix) with ESMTPSA id 8467A20004;
        Mon, 12 Jun 2023 17:53:07 +0000 (UTC)
Date:   Mon, 12 Jun 2023 19:53:05 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     William Zhang <william.zhang@broadcom.com>
Cc:     Broadcom Kernel List <bcm-kernel-feedback-list@broadcom.com>,
        Linux MTD List <linux-mtd@lists.infradead.org>,
        f.fainelli@gmail.com, rafal@milecki.pl, kursad.oney@broadcom.com,
        joel.peshkin@broadcom.com, computersforpeace@gmail.com,
        anand.gore@broadcom.com, dregan@mail.com, kamal.dasu@broadcom.com,
        tomer.yacoby@broadcom.com, dan.beygelman@broadcom.com,
        linux-kernel@vger.kernel.org,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Richard Weinberger <richard@nod.at>,
        Kamal Dasu <kdasu.kdev@gmail.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 10/12] mtd: rawnand: brcmnand: Add BCMBCA read data bus
 interface
Message-ID: <20230612195305.4b097c46@xps-13>
In-Reply-To: <20230612194908.5465bc56@xps-13>
References: <20230606231252.94838-1-william.zhang@broadcom.com>
        <20230606231252.94838-11-william.zhang@broadcom.com>
        <20230607102232.17c4a27b@xps-13>
        <7b393f47-4053-a8c7-f32e-3881d8130d80@broadcom.com>
        <20230608081821.1de5a50b@xps-13>
        <4ab08e3e-3be4-8b8b-6eb8-03a62337f46f@broadcom.com>
        <20230609103544.0f00f799@xps-13>
        <3d3b471b-c555-ee1c-96d6-c04d76979e76@broadcom.com>
        <20230612194908.5465bc56@xps-13>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello again,

> > >>>>> Perhaps we could have a single function that is statically assign=
ed at
> > >>>>> probe time instead of a first helper with two conditions which ca=
lls in
> > >>>>> one case another hook... This can be simplified I guess. =20
> > >>>>>     >> Well this will need to be done at the SoC specific impleme=
ntation level (bcm<xxx>_nand.c) and each SoC will need to have either gener=
al data bus read func with is_param option or data_bus_read_page, data_bus_=
read_param. =20
> > >>>
> > >>> You told me in case we would use exec_op we could avoid the param
> > >>> cache. If that's true then the whole support can be simplified. =20
> > >>>    >> Correct we may possibly unified the parameter data read but e=
xec_op is long shot and we are not fully ready for that yet. It also depend=
s on if the low level data register has endianess difference for the parame=
ter data between difference SoCs. =20
> > >>
> > >> So I would like to push the current implementation and we can explor=
e the exec_op option late which will be a much big and complete different i=
mplementation. =20
> > >=20
> > > I am sorry but this series is totally backwards, you're trying to gue=
ss
> > > what comes next with the 'is_param' thing, it's exactly what we are
> > > fighting against since 2017. There are plenty of ->exec_op()
> > > conversions out there, I don't believe this one will be harder. You
> > > need to convert the driver to this new API and get rid of this whole
> > > endianness non-sense to simplify a lot the driver.
> > >  =20
> > I am not guessing anything but just factor out the existing common nand=
 cache read logic into the single default function(or one for page read and=
 another for parameter read as I mentioned in another thread) and allow SoC=
 to overrides the implementation when needed.
>=20
> No, you are trying to guess what type of read the core is performing,
> either a regular data page read or a parameter page read.
>=20
> > I agree ->exec_op can possibly get rid of the parameter page read funct=
ion and is the way to go. But it won't help on the page read for endianess.
>=20
> You told me there is no endianess issue with the data pages, so why it
> won't help on the page read?
>=20
> > It's not that I am against exec_op but I want to take one step a time
> > and I'd like to get these fixes
>=20
> I don't see any fix here? Let me know if I am missing something but
> right now I see a new version of the controller being supported with
> its own constraints. If you are fixing existing code for already
> supported platform, then make it clear and we can discuss this. But if
> you just want to support the bcmbca flavor, then there is no risk
> mitigation involved here, and a conversion is the right step :)
>=20

I forgot to mention: the exec_op conversion is almost ready, Boris
worked on it but he lacked the hardware so maybe you'll just need to
revive the few patches which target your platform and do a little bit of
debugging?

https://github.com/bbrezillon/linux/commits/nand/exec-op-conversion?after=
=3D8a3cf6fd25d5e15c6667f9e95c1fc86e4cb735e6+34&branch=3Dnand%2Fexec-op-conv=
ersion&qualified_name=3Drefs%2Fheads%2Fnand%2Fexec-op-conversion

Cheers,
Miqu=C3=A8l
