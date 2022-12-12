Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B107C64A528
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Dec 2022 17:42:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232516AbiLLQkV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 11:40:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232361AbiLLQjh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 11:39:37 -0500
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CECD15711
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 08:37:35 -0800 (PST)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 495B02000B;
        Mon, 12 Dec 2022 16:37:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1670863053;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EwAVmfbQnTSieCtcswoJ97vbaPvFPni/g9UwtMvJmpM=;
        b=lem34E/k0RLu3OXl8hiO1RFuk+SXVYnKW449Yzz+marWp6we8vlbLAtckjLj1ESJjMfGHd
        keDbJdMbF3iRf2UcvICPiuPAWDN8Q3pTiQLVDyd9+wDRlLyo4+3GZZf7IiCs6tUA5kp0vO
        I/AGhrvBintywrFwoiq1X7+hLlj12CQ6fSJU/pR+mhuP2xYpqI2pcJgpVdUzRaTR4s34pD
        jhudDceNBOkBZJlshtnQF24k31zIVEHXmJ+nvQ2WOUddmpG6ojVUejRUZCN/wu9FCwxWYB
        lBqwkSFdIqPWTeynXuSfT/SEJbD3dxA5MbsUJU/DEalUsGO3pFSCNz7rfIOGrA==
Date:   Mon, 12 Dec 2022 17:37:30 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Maxim Kiselev <bigunclemax@gmail.com>
Cc:     Thorsten Leemhuis <regressions@leemhuis.info>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Richard Weinberger <richard@nod.at>,
        Maxim Kochetkov <fido_max@inbox.ru>,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Saravana Kannan <saravanak@google.com>
Subject: Re: nvmem-cells regression after adding 'call
 of_platform_populate() for MTD partitions'
Message-ID: <20221212173730.64224599@xps-13>
In-Reply-To: <CALHCpMimCqZB0bnHaOdCzucey+92NcRRZXCHXYYH5c9vj0nZaQ@mail.gmail.com>
References: <CALHCpMgSZOZdOGpLwTYf0sFD5EMNL7CuqHuFJV_6w5VPSWZnUw@mail.gmail.com>
        <CALHCpMgEZjnR39upkR6iozSk-b5A_GHRo9rcDSPXzzQi6x_qCw@mail.gmail.com>
        <b1b7935d-0785-2e57-bad9-ab2476f0acf2@leemhuis.info>
        <CALHCpMhsM2j=bSXEDC9BWYpOAyvCccgJpJmqXfiRTHvp6=y3tA@mail.gmail.com>
        <20221212101449.4e465181@xps-13>
        <CALHCpMimCqZB0bnHaOdCzucey+92NcRRZXCHXYYH5c9vj0nZaQ@mail.gmail.com>
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

Hi Maxim,

+ Rob & Krzysztof for the binding side
+ Greg, Rafael & Saravana for the device links side

bigunclemax@gmail.com wrote on Mon, 12 Dec 2022 16:06:35 +0300:

> > At a first glance I don't get why the compatible would matter so much
> > here, can you point to some core DT logic that would have an effect? I
> > mean besides leading to the creation of a cell. IOW, what would be done
> > differently if the compatible was different? =20
>=20
> After adding a call of_platform_populate() for MTD partitions (bcdf0315)
> we got a call of 'device_add' for each mtd partition which have
> a 'compatible' property in its DT node. As a result any other devices
> which have a DT reference to 'nvmem-cell' compatible mtd partition
> got dependence from it (see attached log below). Now they will be waiting=
 until
> a 'nvmem-cell' device will be probed. But this will never happen because =
there
> is no 'nvmem-cell' driver.
>=20
>=20
> Here is part of kernel log after bcdf0315 commit:
>   device: 'spi0.0': device_add
>   spi-nor spi0.0: mx66l51235f (65536 Kbytes)
>   7 fixed-partitions partitions found on MTD device spi0.0
>   device: 'f1010600.spi:m25p80@0:partitions:partition@1': device_add
>   device: 'platform:f1010600.spi:m25p80@0:partitions:partition@1--platfor=
m:f1070000.ethernet':
> device_add
>   devices_kset: Moving f1070000.ethernet to end of list
>   platform f1070000.ethernet: Linked as a consumer to
> f1010600.spi:m25p80@0:partitions:partition@1
>   ethernet@70000 Dropping the fwnode link to partition@1
>   Creating 7 MTD partitions on "spi0.0":
>   platform f1070000.ethernet: error -EPROBE_DEFER: supplier
> f1010600.spi:m25p80@0:partitions:partition@1 not ready
>   devices_kset: Moving f1070000.ethernet to end of list
>   platform f1070000.ethernet: error -EPROBE_DEFER: supplier
> f1010600.spi:m25p80@0:partitions:partition@1 not ready
>=20
> Here is part of kernel log with reverted bcdf0315 commit:
>   device: 'spi0.0': device_add
>   spi-nor spi0.0: mx66l51235f (65536 Kbytes)
>   7 fixed-partitions partitions found on MTD device spi0.0
>   Creating 7 MTD partitions on "spi0.0":
>   ethernet@70000 Dropping the fwnode link to partition@1
>   device: 'eth0': device_add
>   mvneta f1070000.ethernet eth0: Using device tree mac address de:fa:ce:d=
b:ab:e1
>=20
> Look at strings below which exists only in the first log (with bcdf0315):
>   device: 'f1010600.spi:m25p80@0:partitions:partition@1': device_add
>   device: 'platform:f1010600.spi:m25p80@0:partitions:partition@1--platfor=
m:f1070000.ethernet':
> device_add
>   platform f1070000.ethernet: error -EPROBE_DEFER: supplier
> f1010600.spi:m25p80@0:partitions:partition@1 not ready
>=20
>=20
> > because this just works with eeproms (non-mtd cells), so let's find out=
. =20
> This works for eeproms and even for whole mtd partitions because there
> are compatible drivers and those devices
> can be probed, ulike a mtd subnode which is compatible with
> non-existent 'nvmem-cell' driver.

Let me try to recap the situation for all the people I just involved:

* An Ethernet driver gets its mac address from an nvmem cell. The
  Ethernet controller DT node then has an "nvmem-cells" property
  pointing towards an nvmem cell.
* The nvmem cell comes from an mtd partition.
* The mtd partition is flagged with a particular compatible
  (which is also named "nvmem-cells") to tell the kernel that the node
  produces nvmem cells.
* The mtd partition itself has no driver, but is the child node of a
  "partitions" container which has one (in this case,
  "fixed-partitions", see the snippet below).

Because the "nvmem-cells" property of the Ethernet node points at the
nvmem-cell node, the core create a device link between the Ethernet
controller (consumer) and the mtd partition (producer).

The device link in this case will never be satisfied because no driver
matches the "nvmem-cells" compatible of the partition node.

Reverting commit bcdf0315a61a ("mtd: call of_platform_populate() for MTD
partitions") would IMHO not make much sense, the problem comes from the
device link side and even there, there is nothing really "wrong",
because I really expect the mtd device to be ready before the
Ethernet controller probe, the device link is legitimate.

So I would like to explore other alternatives. Here are a bunch of
ideas, but I'm open:

1. compatible =3D "nvmem-cells" was maybe not the right way to say "this
   is an nvmem-cells producer":
     1a. Maybe we could use the (new) nvmem-layout container [1]?
     1b. Or we could force users to use the user-otp container [2]?
     1c. Or replace the compatible by a property?

   1c is ugly, all three solutions would break the current bindings,
   hence I would really prefer to got for #2.

2. I don't understand the device link state/flags deeply enough to
   understand what they all convey exactly, but I guess we
   should be able to tell the driver model that the "device" (ie. the
   partition) was created by a driver which owns this device. In this
   case an mtd device owned by the mtd core was created by a parser,
   and there is no additional probe step that should be expected.

   Maybe there is a way to tell this to the driver core at device
   registration time?

   Or perhaps we should workaround it by calling one of:
	- device_links_driver_bound()
	- device_links_no_driver()
   from the mtd core, after registering all the mtd partition devices?

   I am really interested to understand better how the device links are
   expected to evolve, so any pointers would be appreciated.

[1] https://lore.kernel.org/all/20221114085659.847611-1-miquel.raynal@bootl=
in.com/T/#m5c6ed1efd675fda0e2cd174502d38c1565f0274b

[2] https://lore.kernel.org/all/20210424110608.15748-4-michael@walle.cc/

Thanks,
Miqu=C3=A8l

>=20
> =D0=BF=D0=BD, 12 =D0=B4=D0=B5=D0=BA. 2022 =D0=B3. =D0=B2 12:14, Miquel Ra=
ynal <miquel.raynal@bootlin.com>:
> >
> > Hi Maxim,
> >
> > bigunclemax@gmail.com wrote on Sun, 11 Dec 2022 11:26:29 +0300:
> > =20
> > > >On 10.12.22 10:52, Maxim Kiselev wrote: =20
> > > >>
> > > >> After applying =20
> > > >
> > > >This makes me wonder: "applying" as in "applying it to some version =
that
> > > >doesn't contain this change normally" or as it "after it was applied=
 to
> > > >mainline I have the following problem with vanilla kernel version <?=
??>"? =20
> > >
> > > Sorry for confusing you, I mean "after it was applied to mainline".
> > > I have this problem with vanilla kernel version 6.0.
> > > =20
> > > >>> I faced with a problem that my ethernet device can't be probed be=
cause it
> > > >>> wait when 'nvmem-cells' device will be probed first. =20
> > > >>
> > > >>FWIW, there is a discussion about a problems that at least to my
> > > >>untrained eyes looks similar:
> > > >>https://lore.kernel.org/all/Yyj7wJlqJkCwObRn@lx2k/ =20
> > >
> > > Yes it looks like the same issue.
> > >
> > >
> > > I think the root of the problem was the choice of 'compatible'
> > > device tree property to mark the mtd partition node as a nvmem provid=
er.
> > >
> > > I'm talking about this part in 'mtd_nvmem_add' function. =20
> > > > config.no_of_node =3D !of_device_is_compatible(node, "nvmem-cells")=
; =20
> > >
> > > Maybe we should change the 'compatible' property to something else? =
=20
> >
> > At a first glance I don't get why the compatible would matter so much
> > here, can you point to some core DT logic that would have an effect? I
> > mean besides leading to the creation of a cell. IOW, what would be done
> > differently if the compatible was different?
> >
> > Can you also dump the device links (if you can reach a prompt) from
> > sysfs?
> >
> > In theory there should be a link between ethernet and spi-nor which is
> > fulfilled when the spi-nor device probes and leads to the creation of
> > device links. Maybe there is "something else" that the mtd core should
> > do, because this just works with eeproms (non-mtd cells), so let's find
> > out.
> > =20
> > > =D1=81=D0=B1, 10 =D0=B4=D0=B5=D0=BA. 2022 =D0=B3. =D0=B2 15:35, Thors=
ten Leemhuis <regressions@leemhuis.info>: =20
> > > >
> > > > [CCing the regression mailing list, as it should be in the loop for=
 all
> > > > regressions, as explained in
> > > > https://docs.kernel.org/admin-guide/reporting-regressions.html ]
> > > >
> > > > Hi, this is your Linux kernel regression tracker. Thx for the repor=
t.
> > > >
> > > > On 10.12.22 10:52, Maxim Kiselev wrote: =20
> > > > >
> > > > > After applying =20
> > > >
> > > > This makes me wonder: "applying" as in "applying it to some version=
 that
> > > > doesn't contain this change normally" or as it "after it was applie=
d to
> > > > mainline I have the following problem with vanilla kernel version <=
???>"?
> > > > =20
> > > > > this commit 'mtd: call of_platform_populate() for MTD
> > > > > partitions' (bcdf0315), =20
> > > >
> > > > CCing Rafa=C5=82, who authored bcdf0315.
> > > > =20
> > > > > I faced with a problem that my ethernet device can't be probed be=
cause it
> > > > > wait when 'nvmem-cells' device will be probed first. =20
> > > >
> > > > FWIW, there is a discussion about a problems that at least to my
> > > > untrained eyes looks similar:
> > > > https://lore.kernel.org/all/Yyj7wJlqJkCwObRn@lx2k/
> > > >
> > > > Rafa=C5=82, has some progress been made to resolve this?
> > > >
> > > > To me it sounds like this might warrant a "revert, and reapply later
> > > > when the cause for the regression was addressed". Rafa=C5=82, it se=
ems you
> > > > suggested something like that, but it doesn't look like that happen=
ed
> > > > for one reason or another. Or am I missing something?
> > > >
> > > > Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker'=
 hat)
> > > >
> > > > P.S.: As the Linux kernel's regression tracker I deal with a lot of
> > > > reports and sometimes miss something important when writing mails l=
ike
> > > > this. If that's the case here, don't hesitate to tell me in a public
> > > > reply, it's in everyone's interest to set the public record straigh=
t.
> > > > =20
> > > > > But there is no such driver which is compatible with 'nvmem-cells=
' because
> > > > > 'nvmem-cells' is just a mark used by the 'mtd_nvmem_add' function.
> > > > >
> > > > > So this leads to appeating of unresolved dependency for the ether=
net device.
> > > > > And that's why the ethernet device can't be added and probed.
> > > > >
> > > > > Here is a part of kernel log when spi flash probe start:
> > > > > =20
> > > > >> device: 'spi0': device_add
> > > > >> device: 'spi0.0': device_add
> > > > >> spi-nor spi0.0: mx66l51235f (65536 Kbytes)
> > > > >> 7 fixed-partitions partitions found on MTD device spi0.0 =20
> > > > >
> > > > > After 'm25p80' probe 'f1070000.ethernet' linked to 'partition@1' :
> > > > > =20
> > > > >> device: 'f1010600.spi:m25p80@0: =20
> > > > > partitions:partition@1': device_add =20
> > > > >> device: 'platform:f1010600.spi:m25p80@0:partitions:partition@1--=
platform:f1070000.ethernet': device_add
> > > > >> devices_kset: Moving f1070000.ethernet to end of list
> > > > >> platform f1070000.ethernet: Linked as a consumer to f1010600.spi=
:m25p80@0:partitions:partition@1
> > > > >> ethernet@70000 Dropping the fwnode link to partition@1 =20
> > > > >
> > > > > And as a result I got `-EPROBE_DEFER` for `f1070000.ethernet`
> > > > > =20
> > > > >> platform f1070000.ethernet: error -EPROBE_DEFER: supplier f10106=
00.spi:m25p80@0:partitions:partition@1 not ready =20
> > > > >
> > > > > Here is a part of my device tree:
> > > > >
> > > > >     enet1: ethernet@70000 {
> > > > >         status =3D "okay";
> > > > >         nvmem-cells =3D <&macaddr>;
> > > > >         nvmem-cell-names =3D "mac-address";
> > > > >         phy-mode =3D "rgmii";
> > > > >         phy =3D <&phy0>;
> > > > >     };
> > > > >
> > > > >     spi@10600 {
> > > > >         status =3D "okay";
> > > > >
> > > > >         m25p80@0 {
> > > > >             compatible =3D "mx66l51235l";
> > > > >             reg =3D <0>;
> > > > >             #address-cells =3D <1>;
> > > > >             #size-cells =3D <1>;
> > > > >
> > > > >             partitions {
> > > > >                 compatible =3D "fixed-partitions";
> > > > >                 #address-cells =3D <1>;
> > > > >                 #size-cells =3D <1>;
> > > > >
> > > > >                 partition@0 {
> > > > >                     reg =3D <0x00000000 0x000080000>;
> > > > >                     label =3D "SPI.U_BOOT";
> > > > >                 };
> > > > >
> > > > >                 partition@1 {
> > > > >                     compatible =3D "nvmem-cells";
> > > > >                     reg =3D <0x000A0000 0x00020000>;
> > > > >                     label =3D "SPI.INV_INFO";
> > > > >                     #address-cells =3D <1>;
> > > > >                     #size-cells =3D <1>;
> > > > >                     ranges =3D <0 0x000A0000 0x00020000>;
> > > > >
> > > > >                     macaddr: mac@6 {
> > > > >                         reg =3D <0x6 0x6>;
> > > > >                     };
> > > > >                 };
> > > > >
> > > > >             };
> > > > >         };
> > > > >     };
> > > > >
> > > > > In the example above 'ethernet@70000' requires 'macaddr: mac@6' w=
hich is
> > > > > located inside mtd 'partition@1' of 'm25p80@0' spi flash. =20
> > > >
> > > > P.P.S.: let me add this to the regression tracking:
> > > >
> > > > #regzbot ^introduced bcdf0315
> > > > #regzbot title mtd: ethernet device can't be probed anymore due to
> > > > broken nvmem-cells dep
> > > > #regzbot monitor: https://lore.kernel.org/all/Yyj7wJlqJkCwObRn@lx2k/
> > > > #regzbot ignore-activity =20
> >
> >
> > Thanks,
> > Miqu=C3=A8l =20
