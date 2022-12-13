Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD05464BA5A
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 17:56:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235780AbiLMQzP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 11:55:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236101AbiLMQyc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 11:54:32 -0500
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B56D622516
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 08:54:30 -0800 (PST)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id AA6A1FF80C;
        Tue, 13 Dec 2022 16:54:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1670950469;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6i+2/HPdAURjp6RtvmxYlKckI0Zp1d0ZU+1+vdt2LPM=;
        b=nCauKpCkinbLKRtBfPsHoK1kLxryO91ZfnZobkfPWaB2fnoh0Byw2Iqsrc/u8hH3GICRAy
        sSQJEEY+wcB7guQHaVHQ3IBY20o3pX3t0tXQyRPVh5aUf+WiTwVHdskYfz0XrjjFNTVEfx
        wrc3Hs1stmZtQXExvmQpcPQCWZFcCi2Mp0l2iwHoreod71UpuJhWcR65fOWCrpiLaad1dF
        fFXGegRiBK0LkKcFeZLaStIet5lcz0LSGaqrr30KXigt5DvWz7INxQ71s4rDiSgBmFAFQI
        I56Cyrz1Tx/pxkecLNK2U5G0nVwvUqnvSIBVGs2VQP+qHU66TINAU6n2CBgVsA==
Date:   Tue, 13 Dec 2022 17:54:24 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Maxim Kiselev <bigunclemax@gmail.com>
Cc:     Maxim Kochetkov <fido_max@inbox.ru>,
        Thorsten Leemhuis <regressions@leemhuis.info>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Richard Weinberger <richard@nod.at>,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Saravana Kannan <saravanak@google.com>
Subject: Re: nvmem-cells regression after adding 'call
 of_platform_populate() for MTD partitions'
Message-ID: <20221213175424.79895b63@xps-13>
In-Reply-To: <CALHCpMhOku2b+1y5Z=N5RJ6SvCvNakD2rSyRAqp6Gz3JWVvXGg@mail.gmail.com>
References: <CALHCpMgSZOZdOGpLwTYf0sFD5EMNL7CuqHuFJV_6w5VPSWZnUw@mail.gmail.com>
        <CALHCpMgEZjnR39upkR6iozSk-b5A_GHRo9rcDSPXzzQi6x_qCw@mail.gmail.com>
        <b1b7935d-0785-2e57-bad9-ab2476f0acf2@leemhuis.info>
        <CALHCpMhsM2j=bSXEDC9BWYpOAyvCccgJpJmqXfiRTHvp6=y3tA@mail.gmail.com>
        <20221212101449.4e465181@xps-13>
        <CALHCpMimCqZB0bnHaOdCzucey+92NcRRZXCHXYYH5c9vj0nZaQ@mail.gmail.com>
        <20221212173730.64224599@xps-13>
        <b75a8769-0cc8-beb3-931a-6755aede3af0@inbox.ru>
        <20221213104643.052d4a06@xps-13>
        <CALHCpMhOku2b+1y5Z=N5RJ6SvCvNakD2rSyRAqp6Gz3JWVvXGg@mail.gmail.com>
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

Hi Maxim,

bigunclemax@gmail.com wrote on Tue, 13 Dec 2022 14:02:34 +0300:

> I looked closer at commit 658c4448bbbf and bcdf0315a61a, 5db1c2dbc04c16 c=
ommits.
> Looks like we have two different features binded to one property - "compa=
tible".
>=20
> From one side it is the ability to forward the subnode of the mtd
> partition to the nvmem subsystem (658c4448bbbf and ac42c46f983e).
> And from another side is the ability to use custom initialization of
> the mtd partition (bcdf0315a61a and 5db1c2dbc04c16).
>=20
> What I mean:
> According to ac42c46f983e I can create DT like this:
>  - |
>     partitions {
>         compatible =3D "fixed-partitions";
>         #address-cells =3D <1>;
>         #size-cells =3D <1>;
>=20
>         partition@0 {
>             compatible =3D "nvmem-cells";
>             reg =3D <0x40000 0x10000>;
>             #address-cells =3D <1>;
>             #size-cells =3D <1>;
>             macaddr_gmac1: macaddr_gmac1@0 {
>                 reg =3D <0x0 0x6>;
>             };
>         };
>     };
>=20
>=20
> And according to 5db1c2dbc04c16 I can create DT like this:
>  - |
>     partitions {
>         compatible =3D "fixed-partitions";
>         #address-cells =3D <1>;
>         #size-cells =3D <1>;
>=20
>         partition@0 {
>             compatible =3D "u-boot,env";
>             reg =3D <0x40000 0x10000>;
>         };
>     };
>=20
> But I can not use them both, because only one "compatible" property allow=
ed.
> This will be incorrect:
>  - |
>     partitions {
>         compatible =3D "fixed-partitions";
>         #address-cells =3D <1>;
>         #size-cells =3D <1>;
>=20
>         partition@0 {
>             compatible =3D "u-boot,env";  # from ac42c46f983e
>             compatible =3D "nvmem-cells"; # from 5db1c2dbc04c

What about:

	      compatible =3D "u-boot,env", "nvmem-cells";

instead? that should actually work.

>             reg =3D <0x40000 0x10000>;
>             #address-cells =3D <1>;
>             #size-cells =3D <1>;
>             macaddr_gmac1: macaddr_gmac1@0 {
>                 reg =3D <0x0 0x6>;
>             };
>         };
>     };
>=20
> > compatible: Duplicate property name =20
>=20
> =D0=B2=D1=82, 13 =D0=B4=D0=B5=D0=BA. 2022 =D0=B3. =D0=B2 12:46, Miquel Ra=
ynal <miquel.raynal@bootlin.com>:
> >
> > Hi Maxim,
> >
> > fido_max@inbox.ru wrote on Mon, 12 Dec 2022 20:57:49 +0300:
> > =20
> > > Hi, Miquel!
> > >
> > > On 12.12.2022 19:37, Miquel Raynal wrote:
> > > =20
> > > > Let me try to recap the situation for all the people I just involve=
d:
> > > >
> > > > * An Ethernet driver gets its mac address from an nvmem cell. The
> > > >    Ethernet controller DT node then has an "nvmem-cells" property
> > > >    pointing towards an nvmem cell.
> > > > * The nvmem cell comes from an mtd partition.
> > > > * The mtd partition is flagged with a particular compatible
> > > >    (which is also named "nvmem-cells") to tell the kernel that the =
node
> > > >    produces nvmem cells.
> > > > * The mtd partition itself has no driver, but is the child node of a
> > > >    "partitions" container which has one (in this case,
> > > >    "fixed-partitions", see the snippet below).
> > > >
> > > > Because the "nvmem-cells" property of the Ethernet node points at t=
he
> > > > nvmem-cell node, the core create a device link between the Ethernet
> > > > controller (consumer) and the mtd partition (producer).
> > > >
> > > > The device link in this case will never be satisfied because no dri=
ver
> > > > matches the "nvmem-cells" compatible of the partition node.
> > > >
> > > > Reverting commit bcdf0315a61a ("mtd: call of_platform_populate() fo=
r MTD
> > > > partitions") would IMHO not make much sense, the problem comes from=
 the
> > > > device link side and even there, there is nothing really "wrong",
> > > > because I really expect the mtd device to be ready before the
> > > > Ethernet controller probe, the device link is legitimate.
> > > >
> > > > So I would like to explore other alternatives. Here are a bunch of
> > > > ideas, but I'm open: =20
> > >
> > > How about to create simple driver with compatible=3D"nvmem-cell" and =
to move all the suff from main mtd driver which serves nvmem-cell to the pr=
obe function? =20
> >
> > This is probably worth the try but I doubt you can make it work without
> > regressions because IIRC the nvmem registration happens no matter the
> > compatible (not mentioning the user-otp and factory-otp cases). You can
> > definitely try this out if you think you can come up with something
> > though.
> >
> > But I would like to hear from the device-link gurus :) because even if
> > we fix mtd with a "trick" like above, I guess we'll very likely find
> > other corner cases like that and I am interested in understanding the
> > rationale of what could be a proper fix.
> >
> > Thanks,
> > Miqu=C3=A8l =20


Thanks,
Miqu=C3=A8l
