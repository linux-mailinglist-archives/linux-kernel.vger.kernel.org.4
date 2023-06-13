Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 153B272DA09
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 08:42:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235093AbjFMGmb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 02:42:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234850AbjFMGmZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 02:42:25 -0400
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BBAA10C2
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 23:42:23 -0700 (PDT)
X-GND-Sasl: miquel.raynal@bootlin.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1686638541;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OrXtx3q+fEY1tPmCeQlf9j6nownlqedt7spCGcPEGYo=;
        b=bbZgiNRa0Lfg7M4kZerXFAix5Uih85EN7RBfhf+hXRj/BAN+z58sdh83Fv5PQcnkTq/o1E
        GSo44gGf3JnwrSZA4FJTdvsbaZjd1WV063cqzRNVcOf8w5bGSgViy7qW3pyL+4VWz4ZRMC
        uXZbiQnA3Ojc9CKWV96LEtLHFgKEJbjFOTLTsH/jhugDeE2uZXQmIgmUzQfgFjnQIGDgcW
        9cRv3yDI5omSbAGl8bLNafqcrUbQa3GZRcto2n03yKVFSf/5UDCDzNtbYalFXfg3kFIg/y
        XOCCZ3L0mFWrJEKyqKPgf6sDROejqCJBRbmTT/cN9beF7BJCPvMenpmHvRMcmg==
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
Received: by mail.gandi.net (Postfix) with ESMTPSA id C58B81C000E;
        Tue, 13 Jun 2023 06:42:19 +0000 (UTC)
Date:   Tue, 13 Jun 2023 08:42:18 +0200
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
Message-ID: <20230613084218.65a6da15@xps-13>
In-Reply-To: <da4cb6a6-aa7d-3747-3f64-19b5582b15e8@broadcom.com>
References: <20230606231252.94838-1-william.zhang@broadcom.com>
        <20230606231252.94838-11-william.zhang@broadcom.com>
        <20230607102232.17c4a27b@xps-13>
        <7b393f47-4053-a8c7-f32e-3881d8130d80@broadcom.com>
        <20230608081821.1de5a50b@xps-13>
        <4ab08e3e-3be4-8b8b-6eb8-03a62337f46f@broadcom.com>
        <20230609103544.0f00f799@xps-13>
        <3d3b471b-c555-ee1c-96d6-c04d76979e76@broadcom.com>
        <20230612194908.5465bc56@xps-13>
        <20230612195305.4b097c46@xps-13>
        <da4cb6a6-aa7d-3747-3f64-19b5582b15e8@broadcom.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi William,

william.zhang@broadcom.com wrote on Mon, 12 Jun 2023 12:18:58 -0700:

> On 06/12/2023 10:53 AM, Miquel Raynal wrote:
> > Hello again,
> >  =20
> >>>>>>>> Perhaps we could have a single function that is statically assig=
ned at
> >>>>>>>> probe time instead of a first helper with two conditions which c=
alls in
> >>>>>>>> one case another hook... This can be simplified I guess. =20
> >>>>>>>>      >> Well this will need to be done at the SoC specific imple=
mentation level (bcm<xxx>_nand.c) and each SoC will need to have either gen=
eral data bus read func with is_param option or data_bus_read_page, data_bu=
s_read_param. =20
> >>>>>>
> >>>>>> You told me in case we would use exec_op we could avoid the param
> >>>>>> cache. If that's true then the whole support can be simplified. =20
> >>>>>>     >> Correct we may possibly unified the parameter data read but=
 exec_op is long shot and we are not fully ready for that yet. It also depe=
nds on if the low level data register has endianess difference for the para=
meter data between difference SoCs. =20
> >>>>>
> >>>>> So I would like to push the current implementation and we can explo=
re the exec_op option late which will be a much big and complete different =
implementation. =20
> >>>>
> >>>> I am sorry but this series is totally backwards, you're trying to gu=
ess
> >>>> what comes next with the 'is_param' thing, it's exactly what we are
> >>>> fighting against since 2017. There are plenty of ->exec_op()
> >>>> conversions out there, I don't believe this one will be harder. You
> >>>> need to convert the driver to this new API and get rid of this whole
> >>>> endianness non-sense to simplify a lot the driver. =20
> >>>>    >>> I am not guessing anything but just factor out the existing c=
ommon nand cache read logic into the single default function(or one for pag=
e read and another for parameter read as I mentioned in another thread) and=
 allow SoC to overrides the implementation when needed. =20
> >>
> >> No, you are trying to guess what type of read the core is performing,
> >> either a regular data page read or a parameter page read.
> >> =20
> >>> I agree ->exec_op can possibly get rid of the parameter page read fun=
ction and is the way to go. But it won't help on the page read for endianes=
s. =20
> >>
> >> You told me there is no endianess issue with the data pages, so why it
> >> won't help on the page read?
> >> =20
> >>> It's not that I am against exec_op but I want to take one step a time
> >>> and I'd like to get these fixes =20
> >>
> >> I don't see any fix here? Let me know if I am missing something but
> >> right now I see a new version of the controller being supported with
> >> its own constraints. If you are fixing existing code for already
> >> supported platform, then make it clear and we can discuss this. But if
> >> you just want to support the bcmbca flavor, then there is no risk
> >> mitigation involved here, and a conversion is the right step :)
> >> =20
> >=20
> > I forgot to mention: the exec_op conversion is almost ready, Boris
> > worked on it but he lacked the hardware so maybe you'll just need to
> > revive the few patches which target your platform and do a little bit of
> > debugging?
> >=20
> > https://github.com/bbrezillon/linux/commits/nand/exec-op-conversion?aft=
er=3D8a3cf6fd25d5e15c6667f9e95c1fc86e4cb735e6+34&branch=3Dnand%2Fexec-op-co=
nversion&qualified_name=3Drefs%2Fheads%2Fnand%2Fexec-op-conversion
> >  =20
> Yes this is the patch what our exec_op work is based on. Thanks Boris! Th=
e issue with patch is that performance is very slow for anything that rely =
on nand_read_page_op as the patch implementing it using the low level cmd a=
nd data register to transfer the data byte by byte.

You don't need to use exec_op for your read_page/write_page hooks,
quite the opposite actually. exec_op is not meant for high throughput.
exec_op is meant to be simple. You can have fast I/Os with a different
mechanism in your read/write_page hooks.

>  I actually sent out email regarding this to Boris and he cc'ed you in
>  sept last year. We have to use the nand parser to match the page read
>  from exec_op so we can actually match and use the brcmnand_page_read
>  fast path. But there are many situations that we need to match so the
>  project to migrate exce_op are still work in progress just on our
>  bcmbca chip as of now.  Just forward that email again to you and I
>  appreciate it if you have any inputs there. So IMHO it is just too
>  risky and too big of scope to have the exec_op added to this patch
>  series and definitively better to do it afterwards with a dedicated
>  patch.

As long as you add small and orthogonal changes to cmd_ctrl/cmd_func
I don't mind, but what you want now is to force me to pull dirty
changes "first", the type of change we are refusing since 2018, making
me expect you'll perform the conversion after. It would have been
terribly less dirty and you would have all your code already upstreamed
if you had performed the exec_op conversion since September.

Thanks,
Miqu=C3=A8l
