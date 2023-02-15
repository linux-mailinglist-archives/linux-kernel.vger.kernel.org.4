Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49C79698742
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 22:19:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229978AbjBOVTe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 16:19:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229818AbjBOVTc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 16:19:32 -0500
Received: from aposti.net (aposti.net [89.234.176.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A3DF3A0A1;
        Wed, 15 Feb 2023 13:19:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1676495967; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jvmc+szWvCJd5vMT83nrhc2iRC0huJbQ9LpoyvNuebg=;
        b=X4J6nFTd0/PDg6McY8CM9/0xkcIgfF6xE/p3oE2UKSw3hNR/wPWhRqYCNI69GDDyLRs/Rj
        kY4ZzUO3+yxImfdQdZjZ1KN6OGvvIB3wFNDezyVLkDG5H/G6Mf9/RDXtqBfmpE1ffh2JC2
        4XFzivFw3nviDQSZnS/nEy2UMtkLZcM=
Message-ID: <4485f880f7b41bdb833d1153682530cd4bc3ed94.camel@crapouillou.net>
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
Date:   Wed, 15 Feb 2023 21:19:24 +0000
In-Reply-To: <B1706E39-202F-417C-A7A4-B07482B787B0@goldelico.com>
References: <cover.1676482318.git.hns@goldelico.com>
         <e1f92dc94a3e3df7c4bb32b441802cb333ccb6db.camel@crapouillou.net>
         <B1706E39-202F-417C-A7A4-B07482B787B0@goldelico.com>
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

Le mercredi 15 f=C3=A9vrier 2023 =C3=A0 21:32 +0100, H. Nikolaus Schaller a
=C3=A9crit=C2=A0:
> Hi Paul,
> I wasn't aware of your work and it could have saved me a lot of time
> to
> experiment and try to make my patch set work.
>=20
> But we are still lucky, as we can merge ideas and find the really
> best solution.
>=20
> Anyways you can take my patch 1/3 and 3/3 and we have only to discuss
> details of 2/3.
>=20
> Interesting is your setup of several fixed regulators using
> regulator-settling-time-us
> to take care of power up sequencing. What I don't understand is the
> fixedregulator-5
> which has no controlling gpio but is always on. What is it needed
> for? Maybe just to
> be used to silence v(q)mmc-supply warnings etc.?

It's wired to the various inputs of the ACT8600 chip. The driver will
complain if they are not connected to anything. And while we're at it,
it will also silence the v(q)mmc-supply warnings, yes.

> But you do not really switch or enable/disable power of the SDIO or
> bluetooth UART
> interface?

The badly named "bt_power" regulator powers on the chip, while the
"wifi_io" regulator controls the voltage on the VDDIO pins. So these
are enabled/disabled when needed.

> Is it necessary to add a compatible of "ingenic,iw8103-fmac"? If it
> works with the
> standard "brcm,bcm4329-fmac" driver (note that I have "brcm,bcm4330-
> fmac" because that
> is how the module identifies itself) there seems to be no need for
> another compatible
> and a special bindings documentation.

The chip has a different name so we can't guarantee that it works
exactly like the BCM4330. So that was my reason behind using a new
compatible string with a fallback.

However I sent a patch to add the new compatible string to the
documentation and it got refused and I was told to just use the
brcm,bcm4330-fmac, so I'll just do that.

> For bluetooth you could add brcm,bt-pcm-int-params =3D [01 02 00 01
> 01]; so that we
> can eventually add some PCM stream to the sound setup.

Sure, does that work though?

One (unrelated) note about Bluetooth, I didn't get it to work properly;
it works enough to detect my keyboard and allow me to pair with it
(typing the password on the BT keyboard) but it will never connect
properly after that.

> Finally you have made node labels more consistent by calling them
> wifi* while I made
> them wlan0*... Well, just a matter of taste.

Actually the node names should use as much as possible the generic
names specified in the devicetree specification
(https://www.devicetree.org/specifications/) and "wifi" is one of
those.

> Then I tried to take your tree, add my defconfig (because it seems as
> if you have not
> updated configs), but I could only see=20
>=20
> [=C2=A0=C2=A0=C2=A0 0.929072] Bluetooth: hci0: BCM: firmware Patch file n=
ot found,
> tried:
> [=C2=A0=C2=A0=C2=A0 0.935704] Bluetooth: hci0: BCM: 'brcm/BCM4330B1.img,c=
i20.hcd'
> [=C2=A0=C2=A0=C2=A0 0.941683] Bluetooth: hci0: BCM: 'brcm/BCM4330B1.hcd'
> [=C2=A0=C2=A0=C2=A0 0.946827] Bluetooth: hci0: BCM: 'brcm/BCM.img,ci20.hc=
d'
> [=C2=A0=C2=A0=C2=A0 0.952278] Bluetooth: hci0: BCM: 'brcm/BCM.hcd'
>=20
> and then the kernel is stuck.
>=20
> So what is your defconfig that I can test your build?

I test with the OpenDingux userspace so my defconfig is probably very
different from yours. What are you using?

About the crash: make sure you have the *very* latest WiFi firmware
from
https://git.kernel.org/pub/scm/linux/kernel/git/firmware/linux-firmware.git=
/

I do remember that one particular version of the firmware will crash
the kernel. You also don't need the .hcd firmware for Bluetooth to
(somewhat) work.

> BR and thanks,
> Nikolaus

Cheers,
-Paul

> > Am 15.02.2023 um 18:55 schrieb Paul Cercueil
> > <paul@crapouillou.net>:
> >=20
> > Hi Nikolaus,
> >=20
> > Le mercredi 15 f=C3=A9vrier 2023 =C3=A0 18:31 +0100, H. Nikolaus Schall=
er a
> > =C3=A9crit :
> > > RFC V1 2023-02-15 18:31:58:
> > > With the applied patch
> > >=20
> > > rtc: jz4740: Register clock provider for the CLK32K pin
> > >=20
> > > by Paul Cercueil <paul@crapouillou.net> it is now possible to
> > > make
> > > the
> > > CI20 WiFi and Bluetooth setup do something reasonable.
> > >=20
> > > This series adds #clock-cells to the jz4780 and fixes the device
> > > tree
> > > for
> > > the CI20. It contains two ugly workarounds since BL_WAKE and
> > > WL_WAKE
> > > can not
> > > be controlled as shutdown-gpios or device-wakeup-gpios by the
> > > drivers.
> > > We also update the power setup and sequencing and add a clock
> > > chain
> > > for
> > > the 32 kHz clock.
> > > Finally, we enable some required CONFIGs for the CI20.
> >=20
> > I do have my own patchset that I wanted to send in time for 6.3-
> > rc1,
> > but the RTC patchset was merged very late so I was waiting for -rc1
> > to
> > be out before sending it to Thomas.
> >=20
> > I think my DT changes are better as I have no workarounds. I need
> > to
> > clean up the commits (and have proper commit messages) but you can
> > find
> > my current work there:
> > https://github.com/OpenDingux/linux/commits/for-upstream-ci20
> >=20
> > Cheers,
> > -Paul
> >=20
> > >=20
> > > Tested on CI20 with v6.2-rc6.
> > >=20
> > > H. Nikolaus Schaller (3):
> > > =C2=A0 MIPS: DTS: jz4780: add #clock-cells to rtc_dev
> > > =C2=A0 MIPS: DTS: CI20: fixes for WiFi/Bluetooth
> > > =C2=A0 MIPS: configs: ci20: enable drivers we need for WiFi/Bluetooth
> > >=20
> > > =C2=A0arch/mips/boot/dts/ingenic/ci20.dts=C2=A0=C2=A0=C2=A0 | 77
> > > ++++++++++++++++++++++--
> > > --
> > > =C2=A0arch/mips/boot/dts/ingenic/jz4780.dtsi |=C2=A0 2 +
> > > =C2=A0arch/mips/configs/ci20_defconfig=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 | 18 +++++-
> > > =C2=A03 files changed, 84 insertions(+), 13 deletions(-)
> > >=20
> >=20
>=20

