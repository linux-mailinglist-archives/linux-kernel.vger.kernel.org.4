Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A1A769B0EB
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 17:30:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230159AbjBQQaK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 11:30:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230007AbjBQQaG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 11:30:06 -0500
Received: from aposti.net (aposti.net [89.234.176.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 043795BD92;
        Fri, 17 Feb 2023 08:29:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1676651344; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9WHYd6ObSJOqmsG9FQ4cLfYbvvNT5mHeWMKeCszGPnU=;
        b=xZVJx4pZXzcxhUpv4DnRpEZ6xjsxCp6ky6cFuR0tEIUJEYPdqN2cMmylySOOAr5CKTzlpe
        +K/0WUBmyQoN1kb9gCkqKMq1uzNrMqdwgC4ATIarFM+amArt44aIza+lAsklusmlFFBMyb
        Mfrv6Kd4OSGyK2fJLU3+Ne1yBopp+ws=
Message-ID: <de203bdd289124013838244cf0dd0a698d209e9b.camel@crapouillou.net>
Subject: Re: [RFC 0/3] Make WLAN and Bluetooth basically work for CI20
From:   Paul Cercueil <paul@crapouillou.net>
To:     "H. Nikolaus Schaller" <hns@goldelico.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Arnd Bergmann <arnd@arndb.de>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        =?UTF-8?Q?Rafa=C5=82_Mi=C5=82ecki?= <rafal@milecki.pl>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Riccardo Mottola <riccardo.mottola@libero.it>,
        Paul Boddie <paul@boddie.org.uk>,
        linux-mips <linux-mips@vger.kernel.org>,
        OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS 
        <devicetree@vger.kernel.org>,
        linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Discussions about the Letux Kernel 
        <letux-kernel@openphoenux.org>
Date:   Fri, 17 Feb 2023 16:29:01 +0000
In-Reply-To: <809FC192-DBC6-45A7-AF91-A30179E6830C@goldelico.com>
References: <cover.1676482318.git.hns@goldelico.com>
         <e1f92dc94a3e3df7c4bb32b441802cb333ccb6db.camel@crapouillou.net>
         <B1706E39-202F-417C-A7A4-B07482B787B0@goldelico.com>
         <4485f880f7b41bdb833d1153682530cd4bc3ed94.camel@crapouillou.net>
         <809FC192-DBC6-45A7-AF91-A30179E6830C@goldelico.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nikolaus,

Le jeudi 16 f=C3=A9vrier 2023 =C3=A0 07:58 +0100, H. Nikolaus Schaller a =
=C3=A9crit=C2=A0:
> Hi Paul,
>=20
> > Am 15.02.2023 um 22:19 schrieb Paul Cercueil
> > <paul@crapouillou.net>:
> >=20
> > Hi Nikolaus,
> >=20
> > Le mercredi 15 f=C3=A9vrier 2023 =C3=A0 21:32 +0100, H. Nikolaus Schall=
er a
> > =C3=A9crit :
> > > Hi Paul,
> > > I wasn't aware of your work and it could have saved me a lot of
> > > time
> > > to
> > > experiment and try to make my patch set work.
> > >=20
> > > But we are still lucky, as we can merge ideas and find the really
> > > best solution.
> > >=20
> > > Anyways you can take my patch 1/3 and 3/3 and we have only to
> > > discuss
> > > details of 2/3.
> > >=20
> > > Interesting is your setup of several fixed regulators using
> > > regulator-settling-time-us
> > > to take care of power up sequencing. What I don't understand is
> > > the
> > > fixedregulator-5
> > > which has no controlling gpio but is always on. What is it needed
> > > for? Maybe just to
> > > be used to silence v(q)mmc-supply warnings etc.?
> >=20
> > It's wired to the various inputs of the ACT8600 chip. The driver
> > will
> > complain if they are not connected to anything. And while we're at
> > it,
> > it will also silence the v(q)mmc-supply warnings, yes.
> >=20
> > > But you do not really switch or enable/disable power of the SDIO
> > > or
> > > bluetooth UART
> > > interface?
> >=20
> > The badly named "bt_power" regulator powers on the chip, while the
> > "wifi_io" regulator controls the voltage on the VDDIO pins. So
> > these
> > are enabled/disabled when needed.
> >=20
> > > Is it necessary to add a compatible of "ingenic,iw8103-fmac"? If
> > > it
> > > works with the
> > > standard "brcm,bcm4329-fmac" driver (note that I have
> > > "brcm,bcm4330-
> > > fmac" because that
> > > is how the module identifies itself) there seems to be no need
> > > for
> > > another compatible
> > > and a special bindings documentation.
> >=20
> > The chip has a different name so we can't guarantee that it works
> > exactly like the BCM4330. So that was my reason behind using a new
> > compatible string with a fallback.
>=20
> Ok, that would be a good reason.
>=20
> >=20
> > However I sent a patch to add the new compatible string to the
> > documentation and it got refused and I was told to just use the
> > brcm,bcm4330-fmac, so I'll just do that.
> >=20
> > > For bluetooth you could add brcm,bt-pcm-int-params =3D [01 02 00 01
> > > 01]; so that we
> > > can eventually add some PCM stream to the sound setup.
> >=20
> > Sure, does that work though?
>=20
> Well, I don't know. We have no sound setup.
>=20
> > One (unrelated) note about Bluetooth, I didn't get it to work
> > properly;
> > it works enough to detect my keyboard and allow me to pair with it
> > (typing the password on the BT keyboard) but it will never connect
> > properly after that.
>=20
> I haven't tested it that way in my setup.
>=20
> >=20
> > > Finally you have made node labels more consistent by calling them
> > > wifi* while I made
> > > them wlan0*... Well, just a matter of taste.
> >=20
> > Actually the node names should use as much as possible the generic
> > names specified in the devicetree specification
> > (https://www.devicetree.org/specifications/) and "wifi" is one of
> > those.
>=20
> I meant the node labels, not the node names.
>=20
> BTW: Wi-Fi is a trademark of the Wi-Fi Alliance and means
> certification
> while WLAN means the function. Of course the first must be compatible
> to 802.11 and other standards while a WLAN could use some different
> technology.
>=20
> >=20
> > > Then I tried to take your tree, add my defconfig (because it
> > > seems as
> > > if you have not
> > > updated configs), but I could only see=20
> > >=20
> > > [=C2=A0=C2=A0=C2=A0 0.929072] Bluetooth: hci0: BCM: firmware Patch fi=
le not
> > > found,
> > > tried:
> > > [=C2=A0=C2=A0=C2=A0 0.935704] Bluetooth: hci0: BCM:
> > > 'brcm/BCM4330B1.img,ci20.hcd'
> > > [=C2=A0=C2=A0=C2=A0 0.941683] Bluetooth: hci0: BCM: 'brcm/BCM4330B1.h=
cd'
> > > [=C2=A0=C2=A0=C2=A0 0.946827] Bluetooth: hci0: BCM: 'brcm/BCM.img,ci2=
0.hcd'
> > > [=C2=A0=C2=A0=C2=A0 0.952278] Bluetooth: hci0: BCM: 'brcm/BCM.hcd'
> > >=20
> > > and then the kernel is stuck.
> > >=20
> > > So what is your defconfig that I can test your build?
> >=20
> > I test with the OpenDingux userspace so my defconfig is probably
> > very
> > different from yours. What are you using?
>=20
> upstream ci20_defconfig + my patch 3/3.
> Otherwise I test with Debian user-space.
>=20
> Can you share your defconfig just for testing purposes?

There are my changes to ci20_defconfig:
https://github.com/OpenDingux/linux/commit/52278b1871e6eb7fbdba7a4bda608b37=
b6cbc1c7

Some of these changes are irrelevant for you and are only for booting
the OpenDingux userspace.

Note that all the WEXT stuff in your config can go away if you use a
more recent userspace (and use e.g. ip/iw instead of
ifconfig/iwconfig).

Cheers,
-Paul

>=20
> >=20
> > About the crash: make sure you have the *very* latest WiFi firmware
> > from
> > https://git.kernel.org/pub/scm/linux/kernel/git/firmware/linux-firmware=
.git/
>=20
> The BCM4330B1.hcd firmware is missing there. I get mine from
>=20
> https://github.com/armbian/firmware/raw/master/brcm
>=20
> And it works with my setup but not yours. So I think something
> else is missing or wrong. Note that it is loaded from the SD card
> but the kernel is stuck earlier.
>=20
> > I do remember that one particular version of the firmware will
> > crash
> > the kernel. You also don't need the .hcd firmware for Bluetooth to
> > (somewhat) work.
>=20
> Yes, I know. There may also be some race if the drivers are compiled
> into the kernel that the bluetooth subsystem searches for the .hcd
> files before the mmc subsystem has found and SD card. Then we have no
> firmware even if it is stored.
>=20
> BR,
> Nikolaus
>=20
> > > >=20
> > > > >=20
> > > > > Tested on CI20 with v6.2-rc6.
> > > > >=20
> > > > > H. Nikolaus Schaller (3):
> > > > > =C2=A0 MIPS: DTS: jz4780: add #clock-cells to rtc_dev
> > > > > =C2=A0 MIPS: DTS: CI20: fixes for WiFi/Bluetooth
> > > > > =C2=A0 MIPS: configs: ci20: enable drivers we need for
> > > > > WiFi/Bluetooth
> > > > >=20
> > > > > =C2=A0arch/mips/boot/dts/ingenic/ci20.dts=C2=A0=C2=A0=C2=A0 | 77
> > > > > ++++++++++++++++++++++--
> > > > > --
> > > > > =C2=A0arch/mips/boot/dts/ingenic/jz4780.dtsi |=C2=A0 2 +
> > > > > =C2=A0arch/mips/configs/ci20_defconfig=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 | 18 +++++-
> > > > > =C2=A03 files changed, 84 insertions(+), 13 deletions(-)
>=20

