Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01655646A6A
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 09:24:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229773AbiLHIYz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 03:24:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbiLHIYw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 03:24:52 -0500
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87EB110B52;
        Thu,  8 Dec 2022 00:24:46 -0800 (PST)
Received: (Authenticated sender: herve.codina@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id BE90120005;
        Thu,  8 Dec 2022 08:24:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1670487883;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LeAya0VSpti9hnkxK7KJZn2L3jCrFe71dZh0PwM8o4M=;
        b=Ob1mKJGguYVoZg10T2JV0hnjOIefvmLjS80xg/9qkLZft+dH8O6lOo9VeFhN5X474piEsW
        fBNIgVFELeFqGllqebNYkUsWnuLRh7Yb9fhS6PPkK/vtuJ9QvJ5gi1rAyFxZ/9LeO4ULlW
        xV+MV1cjiZXom9/QqQOkR6R/lc+g6K/xW9YlCitY+ZX0yKd73GYOOz/xAi7fG2irOQ6v9t
        vAcRrBU+a1SUVrpbWXP40rkOEQcdTFPE92BJA+rqW0ojmqBJGLH5NjbnSlwxM4vJeZ9Gps
        h5/lrDoN6lyko52fUkTSUGCPPI2jjKD3/OVq6QcOzD4Fc3KOBPqS2tSLTfUOmw==
Date:   Thu, 8 Dec 2022 09:24:39 +0100
From:   Herve Codina <herve.codina@bootlin.com>
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Magnus Damm <magnus.damm@gmail.com>,
        Gareth Williams <gareth.williams.jx@renesas.com>,
        linux-renesas-soc@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: Re: [PATCH v3 0/9] Add the Renesas USBF controller support
Message-ID: <20221208092439.6170cf5e@bootlin.com>
In-Reply-To: <CAL_JsqJiZU=sHVPc92nDNoqUjm7FUb=u0izGYa+irkUW1XmA_w@mail.gmail.com>
References: <20221207162435.1001782-1-herve.codina@bootlin.com>
        <CAL_JsqJiZU=sHVPc92nDNoqUjm7FUb=u0izGYa+irkUW1XmA_w@mail.gmail.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.34; x86_64-redhat-linux-gnu)
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

Hi Rob,

On Wed, 7 Dec 2022 16:19:42 -0600
Rob Herring <robh+dt@kernel.org> wrote:

> On Wed, Dec 7, 2022 at 10:24 AM Herve Codina <herve.codina@bootlin.com> w=
rote:
> >
> > Hi,
> >
> > This series add support for the Renesas USBF controller (USB Device
> > Controller) available in the Renesas RZ/N1 SoC.
> >
> > Based on previous review:
> >   https://lore.kernel.org/all/20221114111513.1436165-3-herve.codina@boo=
tlin.com/
> >
> > A new strategy is proposed to handle the H2MODE bit from CFG_USB
> > register compared to the previous versions on the series. As a
> > reminder, H2MODE bit allows to configure the internal USB Port
> > interface for two hosts or one host and one device. =20
>=20
> Is this case any different from all the phandle properties we have in
> bindings that point to some misc registers somewhere else you need to
> poke? If so, I'm not really a fan of duplicating the information.

Our case is that there is a bit in a register that affect several
devices. This bit must be set before the devices are started.
If this bit is changed while affected devices are running, system
hangs can occurs (datasheet).

So, in order to do that we need the device in charge to set
this bit (sysctrl) to set this bit before other devices (USBF
and PCI bridge) were started.

At sysctrl level, the bit is set during the probe() call.
The property 'depends-on' aim is to ensure the probe() calls
order between provider (sysctrl) and consumers (USBF and PCI
bridge).

regmap and syscon are used to export registers from one device
to an other and the probe() calls order is not ensured by the
core or regmap infrastructure. Indeed, the regmap provider
probe() will not be called if the regmap provider was not probed
before the consumer ask for the regmap.
  https://elixir.bootlin.com/linux/latest/source/drivers/mfd/syscon.c#L152
  https://elixir.bootlin.com/linux/latest/source/drivers/mfd/syscon.c#L43
No specific action synchronisation are done with regmap/syscon
other than the regmap creation itself.

I don't think the regmap/syscon will help in our case.

>=20
> We also have cases of of_find_compatible_node(NULL, NULL,
> "foo-bar-syscon") which is a dependency expressed in the driver, but
> not DT. In either case, adding 'depends-on' would be an ABI break as
> you are requiring a DT change.

In order to avoid the DT change, I can keep the 'depends-on'
optional in the PCI bridge binding.
This will be functionnal as sysctrl is already used in this node
(power-domain =3D <&sysctrl>). The relationship is already present
with this power-domain link.

If ok, I will do this change in v4 series.

>=20
> > This new strategy is:
> >   - Add the new generic 'depends-on' property in the device tree.
> >
> >     This generic property expresses an simple functionnal dependency
> >     that does not rely on a specific topic. It is an 'order only'
> >     dependency that can be used for dependencies between consumers
> >     and producers that are not based on a specific infrastructure
> >     and not need other relationship than this simple 'order only'
> >     (ie no API is provided between the provider and the consumer) =20
>=20
> Isn't getting a regmap an API?
>=20
> Rob

--=20
Herv=C3=A9 Codina, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
