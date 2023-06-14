Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 737C972957D
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 11:38:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240946AbjFIJh7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 05:37:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241738AbjFIJhf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 05:37:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC3FD3A8E;
        Fri,  9 Jun 2023 02:32:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2A4D161EAF;
        Fri,  9 Jun 2023 09:31:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E9C2C4339B;
        Fri,  9 Jun 2023 09:31:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686303113;
        bh=Fbf5wmEcY0BFR5p2HwoLXJ+mhgERo0YQqlUyvrpbFec=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=laP9tGc2UlnJJoljSopHkiiiz9x5eGixxkzC6810AMdrqe2Q2v91uNAH0BXNVhqlK
         hBOMSINXGPx7hr/b4z0ECp3PEAEOHtn8K5QlM2Wt7tJqFP6u63vZkL68V1c7NDpaaL
         gIA/U1POorLNB9DwSLgusuTouR6Rr5TN0hYVvnEY=
Date:   Fri, 9 Jun 2023 11:31:51 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     zhuyinbo <zhuyinbo@loongson.cn>
Cc:     Minas Harutyunyan <hminas@synopsys.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jianmin Lv <lvjianmin@loongson.cn>, wanghongliang@loongson.cn,
        Liu Peibao <liupeibao@loongson.cn>,
        loongson-kernel@lists.loongnix.cn
Subject: Re: [PATCH v2] usb: dwc2: add pci_device_id driver_data parse support
Message-ID: <2023060912-shun-work-a667@gregkh>
References: <20230609025047.691-1-zhuyinbo@loongson.cn>
 <2023060915-uneasy-pedicure-35f4@gregkh>
 <1e2a07a4-f81f-3672-f29c-144d1a12ea21@loongson.cn>
 <2023060958-unvocal-flattery-256a@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2023060958-unvocal-flattery-256a@gregkh>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 09, 2023 at 11:25:15AM +0200, Greg Kroah-Hartman wrote:
> On Fri, Jun 09, 2023 at 05:07:03PM +0800, zhuyinbo wrote:
> > 
> > 
> > 在 2023/6/9 下午2:13, Greg Kroah-Hartman 写道:
> > > On Fri, Jun 09, 2023 at 10:50:47AM +0800, Yinbo Zhu wrote:
> > > > The dwc2 driver has everything we need to run in PCI mode except
> > > > for pci_device_id driver_data parse.  With that to set Loongson
> > > > dwc2 element and added identified as PCI_VENDOR_ID_LOONGSON
> > > > and PCI_DEVICE_ID_LOONGSON_DWC2 in dwc2_pci_ids, the Loongson
> > > > dwc2 controller will work.
> > > > 
> > > > Signed-off-by: Yinbo Zhu <zhuyinbo@loongson.cn>
> > > > ---
> > > > Change in v2:
> > > > 		1. Move the dwc2 pci ID from pci_ids.h to params.c.
> > > > 		2. Add some code logic to ensure that the current device is
> > > > 		   a PCI device.
> > > > 		3. Fix the compile issue when dwc2 pci driver as module.
> > > > 
> > > >   drivers/usb/dwc2/core.h   |  1 +
> > > >   drivers/usb/dwc2/params.c | 39 ++++++++++++++++++++++++++++++++++++++-
> > > >   drivers/usb/dwc2/pci.c    | 14 +-------------
> > > >   3 files changed, 40 insertions(+), 14 deletions(-)
> > > > 
> > > > diff --git a/drivers/usb/dwc2/core.h b/drivers/usb/dwc2/core.h
> > > > index 0bb4c0c845bf..c92a1da46a01 100644
> > > > --- a/drivers/usb/dwc2/core.h
> > > > +++ b/drivers/usb/dwc2/core.h
> > > > @@ -1330,6 +1330,7 @@ irqreturn_t dwc2_handle_common_intr(int irq, void *dev);
> > > >   /* The device ID match table */
> > > >   extern const struct of_device_id dwc2_of_match_table[];
> > > >   extern const struct acpi_device_id dwc2_acpi_match[];
> > > > +extern const struct pci_device_id dwc2_pci_ids[];
> > > >   int dwc2_lowlevel_hw_enable(struct dwc2_hsotg *hsotg);
> > > >   int dwc2_lowlevel_hw_disable(struct dwc2_hsotg *hsotg);
> > > > diff --git a/drivers/usb/dwc2/params.c b/drivers/usb/dwc2/params.c
> > > > index 21d16533bd2f..6b68a8830781 100644
> > > > --- a/drivers/usb/dwc2/params.c
> > > > +++ b/drivers/usb/dwc2/params.c
> > > > @@ -7,9 +7,14 @@
> > > >   #include <linux/module.h>
> > > >   #include <linux/of_device.h>
> > > >   #include <linux/usb/of.h>
> > > > +#include <linux/pci_ids.h>
> > > > +#include <linux/pci.h>
> > > >   #include "core.h"
> > > > +#define PCI_PRODUCT_ID_HAPS_HSOTG	0xabc0
> > > > +#define PCI_DEVICE_ID_LOONGSON_DWC2	0x7a04
> > > > +
> > > >   static void dwc2_set_bcm_params(struct dwc2_hsotg *hsotg)
> > > >   {
> > > >   	struct dwc2_core_params *p = &hsotg->params;
> > > > @@ -55,6 +60,14 @@ static void dwc2_set_jz4775_params(struct dwc2_hsotg *hsotg)
> > > >   		!device_property_read_bool(hsotg->dev, "disable-over-current");
> > > >   }
> > > > +static void dwc2_set_loongson_params(struct dwc2_hsotg *hsotg)
> > > > +{
> > > > +	struct dwc2_core_params *p = &hsotg->params;
> > > > +
> > > > +	p->phy_utmi_width = 8;
> > > > +	p->power_down = DWC2_POWER_DOWN_PARAM_PARTIAL;
> > > > +}
> > > > +
> > > >   static void dwc2_set_x1600_params(struct dwc2_hsotg *hsotg)
> > > >   {
> > > >   	struct dwc2_core_params *p = &hsotg->params;
> > > > @@ -281,6 +294,23 @@ const struct acpi_device_id dwc2_acpi_match[] = {
> > > >   };
> > > >   MODULE_DEVICE_TABLE(acpi, dwc2_acpi_match);
> > > > +const struct pci_device_id dwc2_pci_ids[] = {
> > > > +	{
> > > > +		PCI_DEVICE(PCI_VENDOR_ID_SYNOPSYS, PCI_PRODUCT_ID_HAPS_HSOTG),
> > > > +	},
> > > > +	{
> > > > +		PCI_DEVICE(PCI_VENDOR_ID_STMICRO,
> > > > +			   PCI_DEVICE_ID_STMICRO_USB_OTG),
> > > > +	},
> > > > +	{
> > > > +		PCI_DEVICE(PCI_VENDOR_ID_LOONGSON, PCI_DEVICE_ID_LOONGSON_DWC2),
> > > > +		.driver_data = (unsigned long)dwc2_set_loongson_params,
> > > > +	},
> > > > +	{ /* end: all zeroes */ }
> > > > +};
> > > > +MODULE_DEVICE_TABLE(pci, dwc2_pci_ids);
> > > > +EXPORT_SYMBOL_GPL(dwc2_pci_ids);
> > > > +
> > > >   static void dwc2_set_param_otg_cap(struct dwc2_hsotg *hsotg)
> > > >   {
> > > >   	switch (hsotg->hw_params.op_mode) {
> > > > @@ -927,13 +957,20 @@ int dwc2_init_params(struct dwc2_hsotg *hsotg)
> > > >   	if (match && match->data) {
> > > >   		set_params = match->data;
> > > >   		set_params(hsotg);
> > > > -	} else {
> > > > +	} else if (!match) {
> > > >   		const struct acpi_device_id *amatch;
> > > > +		const struct pci_device_id *pmatch = NULL;
> > > >   		amatch = acpi_match_device(dwc2_acpi_match, hsotg->dev);
> > > >   		if (amatch && amatch->driver_data) {
> > > >   			set_params = (set_params_cb)amatch->driver_data;
> > > >   			set_params(hsotg);
> > > > +		} else if (!amatch)
> > > > +			pmatch = pci_match_id(dwc2_pci_ids, to_pci_dev(hsotg->dev->parent));
> > > 
> > > At this point in time, how can you guarantee that the parent device
> > > really is a PCI one?  This function is being called from a platform
> > > device callback, and platform devices should NEVER be a child of a PCI
> > > device, as that's not how PCI or platform devices work.
> > > 
> > > So how is this even possible?
> > > 
> > > confused,
> > > 
> > 
> > 
> > Hi greg k-h,
> > 
> > My current considerations are based on that the dwc2 drivers support
> > three types of devices, they are Platform device / ACPI device / PCI
> > device, and The dwc2/platform.c can all cover the three type dwc2
> > device, no matter how it is registered.
> > 
> > So, when a dwc2 device wasn't platform device and acpi device and It
> > will be a PCI device, and the the dwc2/pci.c will register a dwc2
> > platform device that dwc2 device is a device that in dwc2/platform.c's
> > dwc2_driver_probe.  the "&dwc2->dev->parent" is the "hsotg->dev->parent"
> > and it was also the &pci->dev.
> 
> That's wrong, a PCI device should NEVER register a platform device under
> it, as obviously it's not a platform device at all.
> 
> So please work to fix that layering violation here, as that's not
> correct and will cause problems as you are showing here.
> 
> > So, We can use "to_pci_dev(hsotg->dev->parent)" to gain a dwc2 pci
> > device.
> 
> No, not if the parent is something else as you have no way of knowing
> this at this point in time.
> 
> > 
> > 1)  DWC2 PCI device driver (drivers/usb/dwc2/pci.c) :
> > 
> > static int dwc2_pci_probe(struct pci_dev *pci,
> >                           const struct pci_device_id *id)
> > {
> > ...
> >         struct platform_device  *dwc2;
> > ...
> >         struct device           *dev = &pci->dev;
> > ...
> > 	dwc2 = platform_device_alloc("dwc2", PLATFORM_DEVID_AUTO);
> > 	              //"dwc2" was used to match dwc2 platform driver
> 
> This needs to be fixed, it's not ok at all.  Just use the real PCI
> device here please.

Also, to be fair, you didn't cause this problem, I missed it previously.
But fixing it is essential, and will be required in order to get your
changes to work properly.  Sorry about that.

greg k-h
