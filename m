Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E8D964E9F2
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Dec 2022 12:05:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230284AbiLPLFE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Dec 2022 06:05:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229879AbiLPLFC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Dec 2022 06:05:02 -0500
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B99553EFC
        for <linux-kernel@vger.kernel.org>; Fri, 16 Dec 2022 03:05:00 -0800 (PST)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 6F0D16000C;
        Fri, 16 Dec 2022 11:04:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1671188699;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cc15E8qfpFQPzwFN+i7Fa1zEjs2q/85OLqjlHHQnE8M=;
        b=Nu8oEEFquMqSFjafKjSo64ODymjLtgk2CilDQNoxz5RFXZ6HBFI0Fdx9q/3b91tkEJeliq
        DiKjEYkU+2Ju/HIOL8lI5CJ7837f4kdL16emctdHl5axyY8hg9wA9Zf/6vZurwQgwvpeTy
        D7IG4njrvnh0czSYUaCgmybuDbiR0nLJxw8pOJlW+CPDxhvHXglG1qVPea562DUq0GstN/
        L4/rVXNeNVXKZST1wzSbEGZZOdXCooQqxX879K61h+KUEvC3BFuFO2t0KYOQVzwNiSw0a0
        XE8p+rUaLccpLPaAFRxBxH4qMOqnBJWm2tyLNfV+B8m1d9S7oh7HvLP/Q4+mpQ==
Date:   Fri, 16 Dec 2022 12:04:56 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Saravana Kannan <saravanak@google.com>
Cc:     Maxim Kiselev <bigunclemax@gmail.com>,
        Maxim Kochetkov <fido_max@inbox.ru>,
        Thorsten Leemhuis <regressions@leemhuis.info>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Richard Weinberger <richard@nod.at>,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: nvmem-cells regression after adding 'call
 of_platform_populate() for MTD partitions'
Message-ID: <20221216120456.52072f9f@xps-13>
In-Reply-To: <CAGETcx8YvD5JABuJhah_6oOAUe=QgnOG5gWNL7Hcfxbvq0C2YQ@mail.gmail.com>
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
        <20221213175424.79895b63@xps-13>
        <CAGETcx8YvD5JABuJhah_6oOAUe=QgnOG5gWNL7Hcfxbvq0C2YQ@mail.gmail.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Saravana, Maxim, Maxim,

saravanak@google.com wrote on Wed, 14 Dec 2022 13:53:54 -0800:

> On Tue, Dec 13, 2022 at 8:54 AM Miquel Raynal <miquel.raynal@bootlin.com>=
 wrote:
> >
> > Hi Maxim,
> >
> > bigunclemax@gmail.com wrote on Tue, 13 Dec 2022 14:02:34 +0300:
> > =20
> > > I looked closer at commit 658c4448bbbf and bcdf0315a61a, 5db1c2dbc04c=
16 commits.
> > > Looks like we have two different features binded to one property - "c=
ompatible".
> > >
> > > From one side it is the ability to forward the subnode of the mtd
> > > partition to the nvmem subsystem (658c4448bbbf and ac42c46f983e).
> > > And from another side is the ability to use custom initialization of
> > > the mtd partition (bcdf0315a61a and 5db1c2dbc04c16).
> > >
> > > What I mean:
> > > According to ac42c46f983e I can create DT like this:
> > >  - |
> > >     partitions {
> > >         compatible =3D "fixed-partitions";
> > >         #address-cells =3D <1>;
> > >         #size-cells =3D <1>;
> > >
> > >         partition@0 {
> > >             compatible =3D "nvmem-cells";
> > >             reg =3D <0x40000 0x10000>;
> > >             #address-cells =3D <1>;
> > >             #size-cells =3D <1>;
> > >             macaddr_gmac1: macaddr_gmac1@0 {
> > >                 reg =3D <0x0 0x6>;
> > >             };
> > >         };
> > >     };
> > >
> > >
> > > And according to 5db1c2dbc04c16 I can create DT like this:
> > >  - |
> > >     partitions {
> > >         compatible =3D "fixed-partitions";
> > >         #address-cells =3D <1>;
> > >         #size-cells =3D <1>;
> > >
> > >         partition@0 {
> > >             compatible =3D "u-boot,env";
> > >             reg =3D <0x40000 0x10000>;
> > >         };
> > >     };
> > >
> > > But I can not use them both, because only one "compatible" property a=
llowed.
> > > This will be incorrect:
> > >  - |
> > >     partitions {
> > >         compatible =3D "fixed-partitions";
> > >         #address-cells =3D <1>;
> > >         #size-cells =3D <1>;
> > >
> > >         partition@0 {
> > >             compatible =3D "u-boot,env";  # from ac42c46f983e
> > >             compatible =3D "nvmem-cells"; # from 5db1c2dbc04c =20
> >
> > What about:
> >
> >               compatible =3D "u-boot,env", "nvmem-cells";
> >
> > instead? that should actually work.
> > =20
> > >             reg =3D <0x40000 0x10000>;
> > >             #address-cells =3D <1>;
> > >             #size-cells =3D <1>;
> > >             macaddr_gmac1: macaddr_gmac1@0 {
> > >                 reg =3D <0x0 0x6>;
> > >             };
> > >         };
> > >     };
> > > =20
> > > > compatible: Duplicate property name =20
> > >
> > > =D0=B2=D1=82, 13 =D0=B4=D0=B5=D0=BA. 2022 =D0=B3. =D0=B2 12:46, Mique=
l Raynal <miquel.raynal@bootlin.com>: =20
> > > >
> > > > Hi Maxim,
> > > >
> > > > fido_max@inbox.ru wrote on Mon, 12 Dec 2022 20:57:49 +0300:
> > > > =20
> > > > > Hi, Miquel!
> > > > >
> > > > > On 12.12.2022 19:37, Miquel Raynal wrote:
> > > > > =20
> > > > > > Let me try to recap the situation for all the people I just inv=
olved:
> > > > > >
> > > > > > * An Ethernet driver gets its mac address from an nvmem cell. T=
he
> > > > > >    Ethernet controller DT node then has an "nvmem-cells" proper=
ty
> > > > > >    pointing towards an nvmem cell.
> > > > > > * The nvmem cell comes from an mtd partition.
> > > > > > * The mtd partition is flagged with a particular compatible
> > > > > >    (which is also named "nvmem-cells") to tell the kernel that =
the node
> > > > > >    produces nvmem cells.
> > > > > > * The mtd partition itself has no driver, but is the child node=
 of a
> > > > > >    "partitions" container which has one (in this case,
> > > > > >    "fixed-partitions", see the snippet below).
> > > > > >
> > > > > > Because the "nvmem-cells" property of the Ethernet node points =
at the
> > > > > > nvmem-cell node, the core create a device link between the Ethe=
rnet
> > > > > > controller (consumer) and the mtd partition (producer).
> > > > > >
> > > > > > The device link in this case will never be satisfied because no=
 driver
> > > > > > matches the "nvmem-cells" compatible of the partition node.
> > > > > >
> > > > > > Reverting commit bcdf0315a61a ("mtd: call of_platform_populate(=
) for MTD
> > > > > > partitions") would IMHO not make much sense, the problem comes =
from the
> > > > > > device link side and even there, there is nothing really "wrong=
",
> > > > > > because I really expect the mtd device to be ready before the
> > > > > > Ethernet controller probe, the device link is legitimate.
> > > > > >
> > > > > > So I would like to explore other alternatives. Here are a bunch=
 of
> > > > > > ideas, but I'm open: =20
> > > > >
> > > > > How about to create simple driver with compatible=3D"nvmem-cell" =
and to move all the suff from main mtd driver which serves nvmem-cell to th=
e probe function? =20
> > > >
> > > > This is probably worth the try but I doubt you can make it work wit=
hout
> > > > regressions because IIRC the nvmem registration happens no matter t=
he
> > > > compatible (not mentioning the user-otp and factory-otp cases). You=
 can
> > > > definitely try this out if you think you can come up with something
> > > > though.
> > > >
> > > > But I would like to hear from the device-link gurus :) because even=
 if
> > > > we fix mtd with a "trick" like above, I guess we'll very likely find
> > > > other corner cases like that and I am interested in understanding t=
he
> > > > rationale of what could be a proper fix.
> > > > =20
>=20
> Responding to the whole thread.
>=20
> I'm going by Miquel's first email in which he cc'ed me and haven't
> actually looked at the mtd code. Couple of comments:
>=20
> Independent of mtd/nvmem-cell, I generally frown on having a
> compatible string for a child node that you don't treat as a device.
> Even more so if you actually create a struct device for it and then
> don't do anything else with it. That's just a waste of memory. So, in
> general try to avoid that in the future if you can.

Agreed, it didn't triggered any warnings in my head in the first place,
sorry about that.

> Also, there are flags the parent device's driver can set that'll tell
> fw_devlink not to treat a specific DT node as a real device. So, if we
> really need that I'll dig up and suggest a fix.

Interesting, that would indeed very likely fix it.

> Lastly and more importantly, I've a series[1] that stops depending on
> the compatible property for fw_devlink to work. So it should be
> smarter than it is today. But that series has known bugs for which I
> gave test fixes in that thread. I plan to make a v2 of that series
> with that fix and I'm expecting it'll fix a bunch of fw_devlink
> issues.
>=20
> Feel free to give v1 + squashing the fixes a shot if you are excited
> to try it. Otherwise, I'll try my best to get around to it this week
> (kinda swamped though + holidays coming up, so no promises).

Can you please include us in your next submission?
* Maxim Kiselev <bigunclemax@gmail.com>
* Maxim Kochetkov <fido_max@inbox.ru>
* Miquel Raynal <miquel.raynal@bootlin.com>

> [1] - https://lore.kernel.org/lkml/20220810060040.321697-1-saravanak@goog=
le.com/

Maxim, any chance you give this a try?

Thanks,
Miqu=C3=A8l
