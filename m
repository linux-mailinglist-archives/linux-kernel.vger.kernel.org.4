Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A77E7628ADD
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 21:54:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236399AbiKNUyQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 15:54:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235639AbiKNUyP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 15:54:15 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7680F645C
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 12:54:14 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1977F61467
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 20:54:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68429C433B5
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 20:54:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668459253;
        bh=RpzN8H68aCjb0/JyiJOBU4yllyMbTQCHOKuIqTWmxig=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=DdTo6iNMwueUq5L2aV3zlH4+Z00+xxAbM74tsJmd+hSy1WlH9bkshBKe3vD5UwhRk
         C95ctEs6Y38R+VgS4Pwe6PiZPcpdEAr9zSxpq5GZ21RElKBV2zR7+BJR1ASUkbwZ+Q
         CTBNQsuGzl08x3IFT9nK9LPJXU0kTPPAeCQGpCQIoUi1nJwuUF45MKquZANZ3XHEws
         wpFDHOQSUkCYVF5NnhS+HAjt+/plsTbuBzaQQunzUbphgohtgsH0/g1//YryeAKLyZ
         GVu0sd+8yyJLRCx5W0/Uv6jxo5t5n5Wl06ltdWj8eP9Jo4HMV7tGvzaOh+8QJ3DRTL
         YL5Iubo4TLzsQ==
Received: by mail-lf1-f46.google.com with SMTP id g12so21393122lfh.3
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 12:54:13 -0800 (PST)
X-Gm-Message-State: ANoB5pmIWG+fbhBEwdzKkJsBUgEyZDzp1ens2dZR9nQuHcvnHzxpKRyY
        On4oSP6Fy+VFUkETNBepPdexRtZaCCaL3pKubQ==
X-Google-Smtp-Source: AA0mqf6EQA5WXgdrOooku6hSuKEzcyytYAV+ZO6JbTyEPa6dLL2Hga6OwNfhWQ7IQEKnEJQmczYil+G5Rtz7RSgUxq8=
X-Received: by 2002:ac2:5396:0:b0:4a4:6ee3:f57b with SMTP id
 g22-20020ac25396000000b004a46ee3f57bmr4433710lfh.17.1668459251363; Mon, 14
 Nov 2022 12:54:11 -0800 (PST)
MIME-Version: 1.0
References: <20221017075702.4182846-1-victor.liu@nxp.com> <Y1/sUfeVy1a6EKZQ@google.com>
 <afa29fcc11436dd957314a4066c9141937f0470c.camel@nxp.com> <b7bcc99c006c91871f0518c1a132035d2a148f24.camel@nxp.com>
 <Y2jKRQ8VyauSfXmH@google.com> <4dfb7699c33974a682d798071c85b431b87e5432.camel@nxp.com>
In-Reply-To: <4dfb7699c33974a682d798071c85b431b87e5432.camel@nxp.com>
From:   Rob Herring <robh@kernel.org>
Date:   Mon, 14 Nov 2022 14:54:02 -0600
X-Gmail-Original-Message-ID: <CAL_JsqKoJimmbk5KoAs2yetrW4ONDy6-QMvvFdNdHH+HP6rk=w@mail.gmail.com>
Message-ID: <CAL_JsqKoJimmbk5KoAs2yetrW4ONDy6-QMvvFdNdHH+HP6rk=w@mail.gmail.com>
Subject: Re: [PATCH RESEND] mfd: Add Freescale i.MX8qxp Control and Status
 Registers (CSR) module driver
To:     Liu Ying <victor.liu@nxp.com>
Cc:     Lee Jones <lee@kernel.org>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 7, 2022 at 9:58 PM Liu Ying <victor.liu@nxp.com> wrote:
>
> Hi Lee,
>
> On Mon, 2022-11-07 at 09:05 +0000, Lee Jones wrote:
> > On Wed, 02 Nov 2022, Liu Ying wrote:
> >
> > > Hi Lee,
> > >
> > > On Tue, 2022-11-01 at 13:53 +0800, Liu Ying wrote:
> > > > Hi Lee,
> > > >
> > > > On Mon, 2022-10-31 at 15:40 +0000, Lee Jones wrote:
> > > > > On Mon, 17 Oct 2022, Liu Ying wrote:
> > > > >
> > > > > > Freescale i.MX8qxp Control and Status Registers (CSR) module is a
> > > > > > system
> > > > > > controller. It represents a set of miscellaneous registers of a
> > > > > > specific
> > > > > > subsystem. It may provide control and/or status report interfaces
> > > > > > to a
> > > > > > mix of standalone hardware devices within that subsystem.
> > > > > >
> > > > > > The CSR module in i.MX8qm/qxp SoCs is a child node of a simple
> > > > > > power-managed
> > > > > > bus(i.MX8qxp pixel link MSI bus). To propagate power management
> > > > > > operations
> > > > > > of the CSR module's child devices to that simple power-managed
> > > > > > bus, add a
> > > > > > dedicated driver for the CSR module. Also, the driver would
> > > > > > populate the CSR
> > > > > > module's child devices.
> > > > > >
> > > > > > Signed-off-by: Liu Ying <victor.liu@nxp.com>
> > > > > > ---
> > > > > > The Freescale i.MX8qxp CSR DT bindings is at
> > > > > > Documentation/devicetree/bindings/mfd/fsl,imx8qxp-csr.yaml.
> > > > > >
> > > > > > Resend the patch based on v6.1-rc1.
> > > > > >
> > > > > >  drivers/mfd/Kconfig           | 10 +++++++
> > > > > >  drivers/mfd/Makefile          |  1 +
> > > > > >  drivers/mfd/fsl-imx8qxp-csr.c | 53
> > > > > > +++++++++++++++++++++++++++++++++++
> > > > > >  3 files changed, 64 insertions(+)
> > > > > >  create mode 100644 drivers/mfd/fsl-imx8qxp-csr.c
> > > >
> > > > [...]
> > > >
> > > > > > diff --git a/drivers/mfd/fsl-imx8qxp-csr.c b/drivers/mfd/fsl-
> > > > > > imx8qxp-csr.c
> > > > > > new file mode 100644
> > > > > > index 000000000000..3915d3d6ca65
> > > > > > --- /dev/null
> > > > > > +++ b/drivers/mfd/fsl-imx8qxp-csr.c
> > > > > > @@ -0,0 +1,53 @@
> > > > > > +// SPDX-License-Identifier: GPL-2.0+
> > > > > > +
> > > > > > +/*
> > > > > > + * Copyright 2022 NXP
> > > > > > + */
> > > > > > +
> > > > > > +#include <linux/module.h>
> > > > > > +#include <linux/of_platform.h>
> > > > > > +#include <linux/platform_device.h>
> > > > > > +#include <linux/pm_runtime.h>
> > > > > > +
> > > > > > +static int imx8qxp_csr_probe(struct platform_device *pdev)
> > > > > > +{
> > > > > > +     int ret;
> > > > > > +
> > > > > > +     pm_runtime_enable(&pdev->dev);
> > > > > > +
> > > > > > +     ret = devm_of_platform_populate(&pdev->dev);
> > > > >
> > > > > The use of this API does not constitute a MFD.
> > > > >
> > > > > Please use "simple-mfd" instead.
> > > >
> > > > simple-mfd devices have "ONLY_BUS" set in simple-pm-bus.c, so the
> > > > simple-pm-bus driver would not populate child devices of simple-mfd
> > > > devices.
> >
> > Right, simple-pm-bus will not populate child devices, because:
>
> simple-pm-bus.c may populate child devices of simple-pm-bus devices
> because "ONLY_BUS" is _not_ set for simple-pm-bus devices.
>
> simple-pm-bus.c would _not_ populate child devices of simple-mfd
> devices because "ONLY_BUS" is set for simple-mfd devices.
>
> >
> >   /*
> >    * These are transparent bus devices (not simple-pm-bus matches) that
> >    * have their child nodes populated automatically.  So, don't need to
> >    * do anything more. We only match with the device if this driver is
> >    * the most specific match because we don't want to incorrectly bind to
> >    * a device that has a more specific driver.
> >    */
> >
> > So "simple-mfd" must be populated elsewhere i.e. drivers/of/platform.c.
>
> If simple-mfd device is a child device of one device listed in
> of_default_bus_match_table[], then it may be populated by
> drivers/of/platform.c.  But, in my case, simple-mfd device is a child
> device of simple-pm-bus device(not listed in that table), so it will
> not be populated by drivers/of/platform.c.  Instead,
> drivers/bus/simple-pm-bus.c would populate the simple-mfd device.
>
> >
> > > > Also, the simple-pm-bus driver would not enable runtime
> > > > power management for simple-mfd devices due to "ONLY_BUS", which
> > > > means it would not propagate power management operations from child
> > > > devices of simple-mfd devices to parent devices of simple-mfd
> > > > devices.  That's why a dedicated fsl-imx8qxp-csr driver is needed.
> >
> > This is more of an issue.
> >
> > Why can't this device use "simple-pm-bus" to have support for both
> > auto-registration AND Runtime PM?
>
> If I change the compatible string of the CSR module from
> "fsl,imx8qxp-mipi-lvds-csr", "syscon", "simple-mfd"
> to
> "fsl,imx8qxp-mipi-lvds-csr", "syscon", "simple-pm-bus",
> all devices I'm interested in are populated and all relevant drivers
> can probe.  But, this change makes 'make dt_binding_check' for the
> existing fsl,imx8qxp-csr.yaml fail:

As 'simple-bus' is for MMIO devices, so is 'simple-pm-bus' with the
addition of PM capabilities. That means you have registers defined
(reg), but you don't.

Either you have a block with mixed functions or you have separate
blocks. If the register space is all mixed together, then it is the
former and an MFD. Don't be designing your binding based on Linux
behavior.

Rob
