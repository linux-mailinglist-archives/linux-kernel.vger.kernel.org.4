Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 720FA61F786
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 16:23:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232349AbiKGPXc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 10:23:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231438AbiKGPX3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 10:23:29 -0500
Received: from relay10.mail.gandi.net (relay10.mail.gandi.net [217.70.178.230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A9CECD9;
        Mon,  7 Nov 2022 07:23:24 -0800 (PST)
Received: (Authenticated sender: herve.codina@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 4F5BF240007;
        Mon,  7 Nov 2022 15:23:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1667834603;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SJd93Y5HIkbd3Alvti1JPtGvDBLfYghJCCdXFuuDQuY=;
        b=oa6r8eHOhRqhyq8m0OyGQMeXXLO+mcrcHTch6Sxrcj+ToRz4YE1Pjfq5pgFZyZ+KoSMwf9
        oZrCPxvhvmALjaTn2UyYyKJIqTOz8HEuqVpkCYHBbMjEAQ0+Q5CWMcFZ7d4np9xSjS1z8M
        5ZETcxVWIiJ59CLrOBZzIuIqVfHcmEUNSrMTUfTp60LirRgQzSKMVoAQNrXSnrgPZ6i4lA
        b4vFUl1iCad/M8DwIiK8RcISyYi7J1BebN4suQzD4xBTVORiwfLer29EeEHbDv/3zhpb28
        ykYPaKzQgdmBxAhRPtOFbMb5BlmCoSe3coP40G18XD/FOZ8eMYQP3+QNC8hR5g==
Date:   Mon, 7 Nov 2022 16:23:19 +0100
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
Subject: Re: [PATCH 5/7] usb: gadget: udc: add Renesas RZ/N1 USBF controller
 support
Message-ID: <20221107162319.7945f241@bootlin.com>
In-Reply-To: <CAMuHMdVod1VqKSBFa5syeSPU=RzgqQ=3tg70V1OSZFOext7kgw@mail.gmail.com>
References: <20221107135825.583877-1-herve.codina@bootlin.com>
        <20221107135825.583877-6-herve.codina@bootlin.com>
        <CAMuHMdVod1VqKSBFa5syeSPU=RzgqQ=3tg70V1OSZFOext7kgw@mail.gmail.com>
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

On Mon, 7 Nov 2022 15:37:40 +0100
Geert Uytterhoeven <geert@linux-m68k.org> wrote:

> Hi Herv=C3=A9,
>=20
> On Mon, Nov 7, 2022 at 3:00 PM Herve Codina <herve.codina@bootlin.com> wr=
ote:
> > Add support for the Renesas USBF controller.
> > This controller is an USB2.0 UDC controller available in the
> > Renesas r9a06g032 SoC (RZ/N1 family).
> >
> > Signed-off-by: Herve Codina <herve.codina@bootlin.com> =20
>=20
> > --- /dev/null
> > +++ b/drivers/usb/gadget/udc/renesas_usbf.c =20
>=20
> > +struct usbf_udc {
> > +       struct usb_gadget               gadget;
> > +       struct usb_gadget_driver        *driver;
> > +       struct device                   *dev;
> > +       struct clk_bulk_data            *clocks;
> > +       int                             nclocks;
> > +       void __iomem                    *regs;
> > +       spinlock_t                      lock;
> > +       bool                            is_remote_wakeup;
> > +       bool                            is_usb_suspended;
> > +       struct usbf_ep                  ep[USBF_NUM_ENDPOINTS];
> > +       /* for EP0 control messages */
> > +       enum usbf_ep0state              ep0state;
> > +       struct usbf_req                 setup_reply;
> > +       u8                              ep0_buf[USBF_EP0_MAX_PCKT_SIZE];
> > +}; =20
>=20
> > +static int usbf_probe(struct platform_device *pdev)
> > +{
> > +       struct device *dev =3D &pdev->dev;
> > +       struct usbf_udc *udc;
> > +       struct usbf_ep *ep;
> > +       bool h2mode;
> > +       int irq;
> > +       int ret;
> > +       int i;
> > +
> > +       ret =3D r9a06g032_sysctrl_get_usb_h2mode(&h2mode);
> > +       if (ret)
> > +               return ret;
> > +       if (h2mode) {
> > +               dev_warn(dev, "Disabled in H2 (host) mode\n");
> > +               return -ENODEV;
> > +       }
> > +
> > +       udc =3D devm_kzalloc(dev, sizeof(*udc), GFP_KERNEL);
> > +       if (!udc)
> > +               return -ENOMEM;
> > +       platform_set_drvdata(pdev, udc);
> > +
> > +       udc->dev =3D dev;
> > +       spin_lock_init(&udc->lock);
> > +
> > +       udc->regs =3D devm_platform_ioremap_resource(pdev, 0);
> > +       if (IS_ERR(udc->regs))
> > +               return PTR_ERR(udc->regs);
> > +
> > +       devm_pm_runtime_enable(&pdev->dev);
> > +       ret =3D pm_runtime_resume_and_get(&pdev->dev);
> > +       if (ret < 0)
> > +               return ret;
> > +
> > +       ret =3D devm_clk_bulk_get_all(dev, &udc->clocks);
> > +       if (ret < 1) {
> > +               dev_err(dev, "failed to get clocks %d\n", ret);
> > +               return ret;
> > +       }
> > +       udc->nclocks =3D ret;
> > +
> > +       ret =3D clk_bulk_prepare_enable(udc->nclocks, udc->clocks);
> > +       if (ret) {
> > +               dev_err(dev, "can not enable the clock\n");
> > +               return ret;
> > +       } =20
>=20
> As this driver only enables/disables the clocks, perhaps you could
> just delegate this to Runtime PM (through the clock domain pointed
> by the power-domains property in DT), and drop the .clocks and
> .nclocks fields?

Yes, indeed.
I tested it and it works.
I will remove the the clocks handling from this driver in v2 series.

>=20
> > +clk_disable:
> > +       clk_bulk_disable_unprepare(udc->nclocks, udc->clocks);
> > +       return ret;
> > +}
> > +
> > +static int usbf_remove(struct platform_device *pdev)
> > +{
> > +       struct usbf_udc *udc =3D platform_get_drvdata(pdev);
> > +
> > +       usb_del_gadget_udc(&udc->gadget);
> > +
> > +       clk_bulk_disable_unprepare(udc->nclocks, udc->clocks);
> > +
> > +       pm_runtime_put(&pdev->dev);
> > +
> > +       return 0;
> > +} =20
>=20
> > +MODULE_AUTHOR("Herve Codina <herve.codina@bootlin.com>"); =20
>=20
> Herv=C3=A9? ;-)

Just to be consistent with other places where my email appears,
I keep "Herve" :)

>=20
> > +MODULE_DESCRIPTION("Renesas R-Car Gen3 & RZ/N1 USB Function driver");
> > +MODULE_LICENSE("GPL"); =20
>=20
> > --
> > 2.37.3
> > =20
>=20
>=20
> --
> Gr{oetje,eeting}s,
>=20
>                         Geert
>=20
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m6=
8k.org
>=20
> In personal conversations with technical people, I call myself a hacker. =
But
> when I'm talking to journalists I just say "programmer" or something like=
 that.
>                                 -- Linus Torvalds

Thanks for this review,
Herv=C3=A9

--=20
Herv=C3=A9 Codina, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
