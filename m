Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FD7361EE2A
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 10:05:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231139AbiKGJFT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 04:05:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230434AbiKGJFQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 04:05:16 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1451120AD
        for <linux-kernel@vger.kernel.org>; Mon,  7 Nov 2022 01:05:15 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 343C660F1C
        for <linux-kernel@vger.kernel.org>; Mon,  7 Nov 2022 09:05:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88B5FC43148;
        Mon,  7 Nov 2022 09:05:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667811914;
        bh=dQUl7/g2deHQHg56f4HOG512Ok3mw3uMyxBnPD5nMGQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jspR5KW7AKgSMQTAtag8X2CW6uXYboNG2QGtwY0fLz9dPQ1XMNhJMSQOgM/S8DFRm
         cre6eWAzcPOIJRFzy5S4mv7mEzUyaC5H5nPeOpJafn522zgwNYwbTaCblwmERvVFvY
         6I8D4xuelfUGBH8Gz5OcSaCMlNhMhF2fiLh5+qSQHsR9pw59R3+ejsjr5pvfEODYZw
         UtorxcVB+qAHX1lATGruS98uqU8Z1tCFlKirAAZaGSlqHTQJ4JYR3ZG4jSB7gRGmCp
         TQw4lhOvTmgv131tgBYT1UKeEVcDjcWBTr826IqhaN4mhwdZvE3giGqeiCEX8Dd8ub
         c9aTEjuMYkqvg==
Date:   Mon, 7 Nov 2022 09:05:09 +0000
From:   Lee Jones <lee@kernel.org>
To:     Liu Ying <victor.liu@nxp.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com
Subject: Re: [PATCH RESEND] mfd: Add Freescale i.MX8qxp Control and Status
 Registers (CSR) module driver
Message-ID: <Y2jKRQ8VyauSfXmH@google.com>
References: <20221017075702.4182846-1-victor.liu@nxp.com>
 <Y1/sUfeVy1a6EKZQ@google.com>
 <afa29fcc11436dd957314a4066c9141937f0470c.camel@nxp.com>
 <b7bcc99c006c91871f0518c1a132035d2a148f24.camel@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b7bcc99c006c91871f0518c1a132035d2a148f24.camel@nxp.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 02 Nov 2022, Liu Ying wrote:

> Hi Lee,
> 
> On Tue, 2022-11-01 at 13:53 +0800, Liu Ying wrote:
> > Hi Lee,
> > 
> > On Mon, 2022-10-31 at 15:40 +0000, Lee Jones wrote:
> > > On Mon, 17 Oct 2022, Liu Ying wrote:
> > > 
> > > > Freescale i.MX8qxp Control and Status Registers (CSR) module is a
> > > > system
> > > > controller. It represents a set of miscellaneous registers of a
> > > > specific
> > > > subsystem. It may provide control and/or status report interfaces
> > > > to a
> > > > mix of standalone hardware devices within that subsystem.
> > > > 
> > > > The CSR module in i.MX8qm/qxp SoCs is a child node of a simple
> > > > power-managed
> > > > bus(i.MX8qxp pixel link MSI bus). To propagate power management
> > > > operations
> > > > of the CSR module's child devices to that simple power-managed
> > > > bus, add a
> > > > dedicated driver for the CSR module. Also, the driver would
> > > > populate the CSR
> > > > module's child devices.
> > > > 
> > > > Signed-off-by: Liu Ying <victor.liu@nxp.com>
> > > > ---
> > > > The Freescale i.MX8qxp CSR DT bindings is at
> > > > Documentation/devicetree/bindings/mfd/fsl,imx8qxp-csr.yaml.
> > > > 
> > > > Resend the patch based on v6.1-rc1.
> > > > 
> > > >  drivers/mfd/Kconfig           | 10 +++++++
> > > >  drivers/mfd/Makefile          |  1 +
> > > >  drivers/mfd/fsl-imx8qxp-csr.c | 53
> > > > +++++++++++++++++++++++++++++++++++
> > > >  3 files changed, 64 insertions(+)
> > > >  create mode 100644 drivers/mfd/fsl-imx8qxp-csr.c
> > 
> > [...]
> > 
> > > > diff --git a/drivers/mfd/fsl-imx8qxp-csr.c b/drivers/mfd/fsl-
> > > > imx8qxp-csr.c
> > > > new file mode 100644
> > > > index 000000000000..3915d3d6ca65
> > > > --- /dev/null
> > > > +++ b/drivers/mfd/fsl-imx8qxp-csr.c
> > > > @@ -0,0 +1,53 @@
> > > > +// SPDX-License-Identifier: GPL-2.0+
> > > > +
> > > > +/*
> > > > + * Copyright 2022 NXP
> > > > + */
> > > > +
> > > > +#include <linux/module.h>
> > > > +#include <linux/of_platform.h>
> > > > +#include <linux/platform_device.h>
> > > > +#include <linux/pm_runtime.h>
> > > > +
> > > > +static int imx8qxp_csr_probe(struct platform_device *pdev)
> > > > +{
> > > > +	int ret;
> > > > +
> > > > +	pm_runtime_enable(&pdev->dev);
> > > > +
> > > > +	ret = devm_of_platform_populate(&pdev->dev);
> > > 
> > > The use of this API does not constitute a MFD.
> > > 
> > > Please use "simple-mfd" instead.
> > 
> > simple-mfd devices have "ONLY_BUS" set in simple-pm-bus.c, so the
> > simple-pm-bus driver would not populate child devices of simple-mfd
> > devices.

Right, simple-pm-bus will not populate child devices, because:

  /*                                                                     
   * These are transparent bus devices (not simple-pm-bus matches) that  
   * have their child nodes populated automatically.  So, don't need to  
   * do anything more. We only match with the device if this driver is   
   * the most specific match because we don't want to incorrectly bind to
   * a device that has a more specific driver.                           
   */                                                                    

So "simple-mfd" must be populated elsewhere i.e. drivers/of/platform.c.

> > Also, the simple-pm-bus driver would not enable runtime
> > power management for simple-mfd devices due to "ONLY_BUS", which
> > means it would not propagate power management operations from child
> > devices of simple-mfd devices to parent devices of simple-mfd
> > devices.  That's why a dedicated fsl-imx8qxp-csr driver is needed. 

This is more of an issue.

Why can't this device use "simple-pm-bus" to have support for both
auto-registration AND Runtime PM?

> One more point which might be overlooked - as mentioned in commit
> message, the CSR module is a child node of a simple power-managed
> bus(i.MX8qxp pixel link MSI bus), which means the child devices of the
> CSR module(as a simple-mfd device) won't be populated by
> of_platform_default_populate() from of_platform_default_populate_init()
> because "simple-pm-bus" is not listed in of_default_bus_match_table[]
> and hence recursion of of_platform_bus_create() will stop at the
> simple-pm-bus. This is also a reason why a dedicated fsl-imx8qxp-csr
> driver is needed to populated those child devices of the CSR module.

Not sure I know the semantics well enough (anymore) to get a
meaningful picture of what you're trying to explain, and I do not have
any suitable H/W here to mock-up a real-world test-bed / concept
demonstrator to debug this for you.

The long and the short of it is; we have a bunch of automatic
child-device-registering helpers in the kernel.  One of the mechanisms
is bound to work for you if you structure your code appropriately.

Introducing an empty, meaningless driver, simply to call a single
function it not acceptable.  Please make the infrastructure already
offered specifically to solve this category of issue work for your
use-case.

-- 
Lee Jones [李琼斯]
