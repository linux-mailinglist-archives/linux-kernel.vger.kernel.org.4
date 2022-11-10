Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3E8C623D10
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 09:02:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232864AbiKJICk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 03:02:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232964AbiKJICY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 03:02:24 -0500
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF57C31EF9;
        Thu, 10 Nov 2022 00:02:22 -0800 (PST)
Received: (Authenticated sender: herve.codina@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 2B6201C000B;
        Thu, 10 Nov 2022 08:02:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1668067341;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WqL93lMbLibNFmjL/ZxBaK+pr+dw8H6VpJCHP8INXo0=;
        b=YpgztuC1ou+CSt9KwkJAV0BNxbZsErmlR2pB2E8hM4PMlV73AzNMLA4wWIK+DXC4wgmS/C
        37S+lQKONQsNz0MXyt/8MfyfXoRn4GarhrqBruI/sMv4pH/oA1/Ab1xQT11XdP8iHU7GXM
        JEkIWte037BqcOCj9kklk60g8Jpa69S/FzVRzjvVnuOfUZtaaKMemAvQ8PJ4eoppoGMe1N
        LrSamTKWWWSzbBX7WzFne0CpdJfqjxBJm/IrCz+sISAYHLZVTHEc6Eb5Ri5eBrXlGgXBqz
        WIDduuYZxTaI5PYmRhq5A9rl1F5y+4PNSPnDd5mGWOGUJlQ4562sSLh7LdGdqw==
Date:   Thu, 10 Nov 2022 09:02:17 +0100
From:   Herve Codina <herve.codina@bootlin.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Magnus Damm <magnus.damm@gmail.com>,
        Gareth Williams <gareth.williams.jx@renesas.com>,
        linux-renesas-soc@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: Re: [PATCH 1/7] soc: renesas: r9a06g032-sysctrl: Export function to
 get H2MODE from CFG_USB register
Message-ID: <20221110090217.4f4f4a0e@bootlin.com>
In-Reply-To: <CAMuHMdUGz3z12Wwg8AoYwC7SN7xtAj7Osq6S9gO1mA+_KD4-vg@mail.gmail.com>
References: <20221107135825.583877-1-herve.codina@bootlin.com>
        <20221107135825.583877-2-herve.codina@bootlin.com>
        <CAMuHMdVbWGYPkspMx40S02cr6sX2LZkGwye3JQCtiPtLhuDCPw@mail.gmail.com>
        <20221107175446.29c93376@bootlin.com>
        <CAMuHMdUGz3z12Wwg8AoYwC7SN7xtAj7Osq6S9gO1mA+_KD4-vg@mail.gmail.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-redhat-linux-gnu)
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

Hi Geert,

Oops, my bad I removed all people from the email previously.
Re-added them on this reply.=20

On Mon, 7 Nov 2022 20:23:06 +0100
Geert Uytterhoeven <geert@linux-m68k.org> wrote:

> Hi Herv=C3=A9,
>=20
> On Mon, Nov 7, 2022 at 5:54 PM Herve Codina <herve.codina@bootlin.com> wr=
ote:
> > On Mon, 7 Nov 2022 15:40:53 +0100
> > Geert Uytterhoeven <geert@linux-m68k.org> wrote: =20
> > > On Mon, Nov 7, 2022 at 2:59 PM Herve Codina <herve.codina@bootlin.com=
> wrote: =20
> > > > The CFG_USB register is located within the system controller.
> > > >
> > > > We need a helper to get the H2MODE value from the CFG_USB register
> > > > without syscon.
> > > >
> > > > Signed-off-by: Herve Codina <herve.codina@bootlin.com> =20
> > > =20
> > > > --- a/drivers/clk/renesas/r9a06g032-clocks.c
> > > > +++ b/drivers/clk/renesas/r9a06g032-clocks.c
> > > > @@ -25,6 +25,8 @@
> > > >  #include <linux/spinlock.h>
> > > >  #include <dt-bindings/clock/r9a06g032-sysctrl.h>
> > > >
> > > > +#define R9A06G032_SYSCTRL_USB    0x00
> > > > +#define R9A06G032_SYSCTRL_USB_H2MODE  (1<<1)
> > > >  #define R9A06G032_SYSCTRL_DMAMUX 0xA0
> > > >
> > > >  struct r9a06g032_gate {
> > > > @@ -341,6 +343,22 @@ int r9a06g032_sysctrl_set_dmamux(u32 mask, u32=
 val)
> > > >  }
> > > >  EXPORT_SYMBOL_GPL(r9a06g032_sysctrl_set_dmamux);
> > > >
> > > > +
> > > > +/* Exported helper to get the H2MODE bit from USB register */
> > > > +int r9a06g032_sysctrl_get_usb_h2mode(bool *h2mode)
> > > > +{
> > > > +       u32 usb;
> > > > +
> > > > +       if (!sysctrl_priv)
> > > > +               return -EPROBE_DEFER;
> > > > +
> > > > +       usb =3D readl(sysctrl_priv->reg + R9A06G032_SYSCTRL_USB);
> > > > +       *h2mode =3D (usb & R9A06G032_SYSCTRL_USB_H2MODE) ? true : f=
alse;
> > > > +
> > > > +       return 0; =20
> > >
> > > Perhaps not pass *h2mode, but just return USB_ROLE_{HOST,DEVICE}
> > > (enum usb_role in <linux/usb/role.h>), or a negative error code? =20
> >
> > Yes, good idea.
> > I will also rename the function :
> >   enum usb_role r9a06g032_sysctrl_get_usb_role(void);
> >
> > Is that ok for you or do you prefer that I keep the previous name ? =20
>=20
> r9a06g032_sysctrl_get_usb_role() sounds fine!
> But it should return "int", as the return value can be a negative error c=
ode,
> too.

All right, I will do that in v2 series.

Thanks,
Herv=C3=A9

--=20
Herv=C3=A9 Codina, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
