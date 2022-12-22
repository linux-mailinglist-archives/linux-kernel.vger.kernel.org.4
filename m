Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A33A654445
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 16:26:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235822AbiLVP0W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 10:26:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235759AbiLVPZ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 10:25:57 -0500
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::222])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 003E52B268;
        Thu, 22 Dec 2022 07:24:42 -0800 (PST)
Received: (Authenticated sender: herve.codina@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id A6BD140002;
        Thu, 22 Dec 2022 15:24:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1671722681;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=paTDVkvAnOW0G/nrH5hLopHfXkzR9wnPXZ3DRptHKzE=;
        b=An1s8lISNjsPvQ1ituTK/aN3u0eD6UmoFmKwIL0GQfGp0XvXqvtsK7VWOQKsisikEGAN7q
        muHMLfnUj9yHCYDEFEMNgMuF7RfsFT/acVCNbJH7UNgauLLskDpn43sPiZ/dBSMYF7lrzA
        zP4cUUaSokxDZ4VxRXLq01Zun+/zSNg4/3lrpVCYkyojIls7kUtcdLgMNik5FrwTPJsBxp
        c4pm2wnqiWjeg+ZliKFWAAp/2G1W+ZeGAyrooqc7g9jfxp5qHhp8AGzu5JDv61DkzHMALr
        MDCoPNRIpRzb53IT9AqPTu59V4MlDFJOc2aZ9wTUQnOYjjAI8RhTisk42WDATg==
Date:   Thu, 22 Dec 2022 16:24:38 +0100
From:   Herve Codina <herve.codina@bootlin.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Magnus Damm <magnus.damm@gmail.com>,
        Gareth Williams <gareth.williams.jx@renesas.com>,
        linux-renesas-soc@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: Re: [PATCH v4 3/5] usb: gadget: udc: add Renesas RZ/N1 USBF
 controller support
Message-ID: <20221222162438.4d06bd77@bootlin.com>
In-Reply-To: <Y6MFKdOU4IUQo70L@kroah.com>
References: <20221213133302.218955-1-herve.codina@bootlin.com>
 <20221213133302.218955-4-herve.codina@bootlin.com>
 <CAMuHMdV7QNZ8Rv6iFLhj_MmBHL-vGWuWZdKB=REWba1UAWgkHw@mail.gmail.com>
 <Y6MFKdOU4IUQo70L@kroah.com>
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

Hi Geert, Greg,

On Wed, 21 Dec 2022 14:07:53 +0100
Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:

> On Wed, Dec 21, 2022 at 02:03:43PM +0100, Geert Uytterhoeven wrote:
> > Hi Herv=C3=A9,
> >=20
> > On Tue, Dec 13, 2022 at 2:33 PM Herve Codina <herve.codina@bootlin.com>=
 wrote: =20
> > > Add support for the Renesas USBF controller.
> > > This controller is an USB2.0 UDC controller available in the
> > > Renesas r9a06g032 SoC (RZ/N1 family).
> > >
> > > Signed-off-by: Herve Codina <herve.codina@bootlin.com> =20
> >=20
> > Thanks for your patch!
> >  =20
> > > --- /dev/null
> > > +++ b/drivers/usb/gadget/udc/renesas_usbf.c =20
> >  =20
> > > +#ifdef DEBUG
> > > +#define TRACE(_fmt, ...) trace_printk("%s: " _fmt, __func__, ##__VA_=
ARGS__)
> > > +#define USBF_TRACE_EP_MASK 0x0ffff /* All the 16 endpoints */
> > > +#define TRACEEP(_ep, _fmt, ...)                                     =
        \
> > > +       do {                                                         =
       \
> > > +               if ((1 << (_ep)->id) & USBF_TRACE_EP_MASK)           =
       \
> > > +                       trace_printk("%s: " _fmt, __func__, ##__VA_AR=
GS__); \
> > > +       } while (0)
> > > +#else
> > > +#define TRACE(_fmt, ...) do { } while (0)
> > > +#define TRACEEP(_ep, _fmt, ...) do { } while (0) =20
> >=20
> > Please use "no_printk(fmt, ##__VA_ARGS__)" instead of dummy loops,
> > to avoid bad callers going unnoticed if DEBUG is not defined. =20
>=20
> Even better, do NOT define custom debug/trace macros for a single
> driver, just use the ones that the rest of the kernel uses instead
> please.
>=20
> thanks,
>=20
> greg k-h

I would like to keep some granularity in debug messages and
also keep the function name automatically added.
I propose 3 kinds of messages:
- general ones,
- specific Endpoint0 ones,
- other Endpoints ones.

So before doing any modification in the source code, what do you
think about:
    /*
     * Suggested tracers:
     * - no_printk:    Disable tracing
     * - trace_printk: Print to trace buffer
     */
    #define usbf_dbg(_fmt, ...) no_printk("%s: " _fmt, __func__, ##__VA_ARG=
S__)
    #define usbf_dbg_ep0(_fmt, ...) no_printk("%s: " _fmt, __func__, ##__VA=
_ARGS__)
    #define usbf_dbg_epn(_fmt, ...) no_printk("%s: " _fmt, __func__, ##__VA=
_ARGS__)

The code will use only these macros instead of the previously
defined TRACE and TRACEEP as follow:
- usbf_dbg() will be called instead of TRACE()
- usbf_dbg_ep0() will be called instead of TRACEEP() for Endpoint0
- usbf_dbg_epn() will be called instead of TRACEEP() for other Endpoints

Is that ok for you ?

Best regards,
Herv=C3=A9

--=20
Herv=C3=A9 Codina, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
