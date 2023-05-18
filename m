Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CDAA707E28
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 12:32:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230346AbjERKcj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 06:32:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230271AbjERKci (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 06:32:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC8781FC2;
        Thu, 18 May 2023 03:32:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 89E7164C1A;
        Thu, 18 May 2023 10:32:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E776C433EF;
        Thu, 18 May 2023 10:32:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684405956;
        bh=qcuIIFrV0HYuCZo4MxhSdAtu2G9Vl6jJfQro0EV5jFE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EezV9kRvovmhiPavc7xv9MDzTnxhP630H/UmxugMEifElrQf9RyQD8fB809XfbjWo
         brJuCjqY9KLIC/B8gznaPBjEtTx5tvSVKTNZWUiQus6ImRXFtG2sXXmpa/9DhPpSJt
         Oty3KT9wYLkucE89lGw5oKPNWcGuoxrGnULu6ojo=
Date:   Thu, 18 May 2023 12:32:32 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Yinbo Zhu <zhuyinbo@loongson.cn>
Cc:     Minas Harutyunyan <hminas@synopsys.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        Jianmin Lv <lvjianmin@loongson.cn>, wanghongliang@loongson.cn,
        Liu Peibao <liupeibao@loongson.cn>,
        loongson-kernel@lists.loongnix.cn
Subject: Re: [PATCH v1] usb: dwc2: add pci_device_id driver_data parse support
Message-ID: <2023051843-scruffy-gush-cdec@gregkh>
References: <20230518092240.8023-1-zhuyinbo@loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230518092240.8023-1-zhuyinbo@loongson.cn>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 18, 2023 at 05:22:40PM +0800, Yinbo Zhu wrote:
> The dwc2 driver has everything we need to run in PCI mode except
> for pci_device_id driver_data parse.  With that to set Loongson
> dwc2 element and added identified as PCI_VENDOR_ID_LOONGSON
> and PCI_DEVICE_ID_LOONGSON_DWC2 in dwc2_pci_ids, the Loongson
> dwc2 controller will work.
> 
> Signed-off-by: Yinbo Zhu <zhuyinbo@loongson.cn>
> ---
>  drivers/usb/dwc2/core.h   |  1 +
>  drivers/usb/dwc2/params.c | 33 +++++++++++++++++++++++++++++++--
>  drivers/usb/dwc2/pci.c    | 14 +-------------
>  include/linux/pci_ids.h   |  2 ++
>  4 files changed, 35 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/usb/dwc2/core.h b/drivers/usb/dwc2/core.h
> index 0bb4c0c845bf..c92a1da46a01 100644
> --- a/drivers/usb/dwc2/core.h
> +++ b/drivers/usb/dwc2/core.h
> @@ -1330,6 +1330,7 @@ irqreturn_t dwc2_handle_common_intr(int irq, void *dev);
>  /* The device ID match table */
>  extern const struct of_device_id dwc2_of_match_table[];
>  extern const struct acpi_device_id dwc2_acpi_match[];
> +extern const struct pci_device_id dwc2_pci_ids[];
>  
>  int dwc2_lowlevel_hw_enable(struct dwc2_hsotg *hsotg);
>  int dwc2_lowlevel_hw_disable(struct dwc2_hsotg *hsotg);
> diff --git a/drivers/usb/dwc2/params.c b/drivers/usb/dwc2/params.c
> index 21d16533bd2f..f7550d293c2d 100644
> --- a/drivers/usb/dwc2/params.c
> +++ b/drivers/usb/dwc2/params.c
> @@ -7,6 +7,8 @@
>  #include <linux/module.h>
>  #include <linux/of_device.h>
>  #include <linux/usb/of.h>
> +#include <linux/pci_ids.h>
> +#include <linux/pci.h>
>  
>  #include "core.h"
>  
> @@ -55,6 +57,14 @@ static void dwc2_set_jz4775_params(struct dwc2_hsotg *hsotg)
>  		!device_property_read_bool(hsotg->dev, "disable-over-current");
>  }
>  
> +static void dwc2_set_loongson_params(struct dwc2_hsotg *hsotg)
> +{
> +	struct dwc2_core_params *p = &hsotg->params;
> +
> +	p->phy_utmi_width = 8;
> +	p->power_down = DWC2_POWER_DOWN_PARAM_NONE;
> +}
> +
>  static void dwc2_set_x1600_params(struct dwc2_hsotg *hsotg)
>  {
>  	struct dwc2_core_params *p = &hsotg->params;
> @@ -281,6 +291,22 @@ const struct acpi_device_id dwc2_acpi_match[] = {
>  };
>  MODULE_DEVICE_TABLE(acpi, dwc2_acpi_match);
>  
> +const struct pci_device_id dwc2_pci_ids[] = {
> +	{
> +		PCI_DEVICE(PCI_VENDOR_ID_SYNOPSYS, PCI_PRODUCT_ID_HAPS_HSOTG),
> +	},
> +	{
> +		PCI_DEVICE(PCI_VENDOR_ID_STMICRO,
> +			   PCI_DEVICE_ID_STMICRO_USB_OTG),
> +	},
> +	{
> +		PCI_DEVICE(PCI_VENDOR_ID_LOONGSON, PCI_DEVICE_ID_LOONGSON_DWC2),
> +		.driver_data = (unsigned long)dwc2_set_loongson_params,
> +	},
> +	{ /* end: all zeroes */ }
> +};
> +MODULE_DEVICE_TABLE(pci, dwc2_pci_ids);
> +
>  static void dwc2_set_param_otg_cap(struct dwc2_hsotg *hsotg)
>  {
>  	switch (hsotg->hw_params.op_mode) {
> @@ -929,10 +955,13 @@ int dwc2_init_params(struct dwc2_hsotg *hsotg)
>  		set_params(hsotg);
>  	} else {
>  		const struct acpi_device_id *amatch;
> +		const struct pci_device_id *pmatch;
>  
>  		amatch = acpi_match_device(dwc2_acpi_match, hsotg->dev);
> -		if (amatch && amatch->driver_data) {
> -			set_params = (set_params_cb)amatch->driver_data;
> +		pmatch = pci_match_id(dwc2_pci_ids, to_pci_dev(hsotg->dev->parent));

Ick, this means this is not a "real" PCI driver, right?  Why not?

Please tie into the PCI device probe call, don't walk all PCI devices
like this.

How are you _sure_ that the parent is really a PCI device?  That is very
very fragile and will break.

Do this properly instead.


> +
> +		if ((amatch && amatch->driver_data) || (pmatch && pmatch->driver_data)) {
> +			set_params = (set_params_cb)pmatch->driver_data;
>  			set_params(hsotg);
>  		}
>  	}
> diff --git a/drivers/usb/dwc2/pci.c b/drivers/usb/dwc2/pci.c
> index b7306ed8be4c..f3a1e4232a31 100644
> --- a/drivers/usb/dwc2/pci.c
> +++ b/drivers/usb/dwc2/pci.c
> @@ -24,7 +24,7 @@
>  #include <linux/platform_device.h>
>  #include <linux/usb/usb_phy_generic.h>
>  
> -#define PCI_PRODUCT_ID_HAPS_HSOTG	0xabc0
> +#include "core.h"
>  
>  static const char dwc2_driver_name[] = "dwc2-pci";
>  
> @@ -122,18 +122,6 @@ static int dwc2_pci_probe(struct pci_dev *pci,
>  	return ret;
>  }
>  
> -static const struct pci_device_id dwc2_pci_ids[] = {
> -	{
> -		PCI_DEVICE(PCI_VENDOR_ID_SYNOPSYS, PCI_PRODUCT_ID_HAPS_HSOTG),
> -	},
> -	{
> -		PCI_DEVICE(PCI_VENDOR_ID_STMICRO,
> -			   PCI_DEVICE_ID_STMICRO_USB_OTG),
> -	},
> -	{ /* end: all zeroes */ }
> -};
> -MODULE_DEVICE_TABLE(pci, dwc2_pci_ids);
> -
>  static struct pci_driver dwc2_pci_driver = {
>  	.name = dwc2_driver_name,
>  	.id_table = dwc2_pci_ids,
> diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
> index e43ab203054a..6481f648695a 100644
> --- a/include/linux/pci_ids.h
> +++ b/include/linux/pci_ids.h
> @@ -157,6 +157,7 @@
>  #define PCI_VENDOR_ID_PCI_SIG		0x0001
>  
>  #define PCI_VENDOR_ID_LOONGSON		0x0014
> +#define PCI_DEVICE_ID_LOONGSON_DWC2	0x7a04
>  
>  #define PCI_VENDOR_ID_SOLIDIGM		0x025e
>  
> @@ -2356,6 +2357,7 @@
>  #define PCI_DEVICE_ID_SYNOPSYS_HAPSUSB3_AXI	0xabce
>  #define PCI_DEVICE_ID_SYNOPSYS_HAPSUSB31	0xabcf
>  #define PCI_DEVICE_ID_SYNOPSYS_EDDA	0xedda
> +#define PCI_PRODUCT_ID_HAPS_HSOTG       0xabc0

Please read the top of this file for why you should not add new ids
here.

thanks,

greg k-h
