Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FDDE711868
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 22:47:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241717AbjEYUrK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 16:47:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233284AbjEYUrI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 16:47:08 -0400
Received: from smtp.smtpout.orange.fr (smtp-29.smtpout.orange.fr [80.12.242.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7BE23135
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 13:47:03 -0700 (PDT)
Received: from [192.168.1.18] ([86.243.2.178])
        by smtp.orange.fr with ESMTPA
        id 2GKMq0dJafPgg2GKMqWAgb; Thu, 25 May 2023 21:08:54 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
        s=t20230301; t=1685041734;
        bh=3aimI6STBYAt/4Ogpc6VsM7BIeMI40FG7v2LxQxwQAI=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To;
        b=gX3SCaZQg5EPTYI31bq/oR3T1qvCOEQ0li4E60dFzmH/3gGs9KS/wCuubTKkk28mi
         +hr2M7ZLBCNUu9J3bp9z/FG27zlp+xsEwdAwwb8aTlM96/1TEXvL5SJDpaitriHfGf
         V4BbYzJpTkT8erO4pVjGlu6cWIxxp4G0/N44VXofnCiFV0kEDn7KTfqyZafiVw87m0
         Xe/yN8xKuaAkqPfBh/3VpwaFfBXhuh6LuWGgteQAG0g+oTb+l2S2OtEjXMyr/FhT55
         kdUbxnRt4qXZRpc8Ok8r5Dj8/PHEvvz9aqxis6Oa7gqEm6urhWXadRGZzOIN0J8y0L
         PCYqOTJsnuFSA==
X-ME-Helo: [192.168.1.18]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Thu, 25 May 2023 21:08:54 +0200
X-ME-IP: 86.243.2.178
Message-ID: <99737c85-625f-9067-f72c-ddc6822866e2@wanadoo.fr>
Date:   Thu, 25 May 2023 21:08:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v3 2/4] usb: cdns2: Add main part of Cadence USBHS driver
Content-Language: fr
To:     pawell@cadence.com
Cc:     Cliff.Holden@siriusxm.com, Daisy.Barrera@siriusxm.com,
        biju.das.jz@bp.renesas.com, egtvedt@samfundet.no,
        gregkh@linuxfoundation.org, herve.codina@bootlin.com,
        jdelvare@suse.de, linus.walleij@linaro.org,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        neal_liu@aspeedtech.com, tony@atomide.com
References: <20230525054916.243330-1-pawell@cadence.com>
 <20230525054916.243330-3-pawell@cadence.com>
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <20230525054916.243330-3-pawell@cadence.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 25/05/2023 à 07:49, Pawel Laszczak a écrit :
> This patch introduces the main part of Cadence USBHS driver
> to Linux kernel.
> To reduce the patch size a little bit, the header file gadget.h was
> intentionally added as separate patch.
> 
> The Cadence USB 2.0 Controller is a highly configurable IP Core which
> supports both full and high speed data transfer.
> 
> The current driver has been validated with FPGA platform. We have
> support for PCIe bus, which is used on FPGA prototyping.
> 
> Signed-off-by: Pawel Laszczak <pawell-vna1KIf7WgpBDgjK7y7TUQ@public.gmane.org>
> ---
>   drivers/usb/gadget/udc/Kconfig              |    2 +
>   drivers/usb/gadget/udc/Makefile             |    1 +
>   drivers/usb/gadget/udc/cdns2/Kconfig        |   11 +
>   drivers/usb/gadget/udc/cdns2/Makefile       |    5 +
>   drivers/usb/gadget/udc/cdns2/cdns2-ep0.c    |  638 +++++
>   drivers/usb/gadget/udc/cdns2/cdns2-gadget.c | 2426 +++++++++++++++++++
>   drivers/usb/gadget/udc/cdns2/cdns2-pci.c    |  149 ++
>   7 files changed, 3232 insertions(+)
>   create mode 100644 drivers/usb/gadget/udc/cdns2/Kconfig
>   create mode 100644 drivers/usb/gadget/udc/cdns2/Makefile
>   create mode 100644 drivers/usb/gadget/udc/cdns2/cdns2-ep0.c
>   create mode 100644 drivers/usb/gadget/udc/cdns2/cdns2-gadget.c
>   create mode 100644 drivers/usb/gadget/udc/cdns2/cdns2-pci.c
> 
> diff --git a/drivers/usb/gadget/udc/Kconfig b/drivers/usb/gadget/udc/Kconfig
> index 83cae6bb12eb..aae1787320d4 100644
> --- a/drivers/usb/gadget/udc/Kconfig
> +++ b/drivers/usb/gadget/udc/Kconfig
> @@ -463,6 +463,8 @@ config USB_ASPEED_UDC
>   
>   source "drivers/usb/gadget/udc/aspeed-vhub/Kconfig"
>   
> +source "drivers/usb/gadget/udc/cdns2/Kconfig"
> +
>   #
>   # LAST -- dummy/emulated controller
>   #
> diff --git a/drivers/usb/gadget/udc/Makefile b/drivers/usb/gadget/udc/Makefile
> index ee569f63c74a..b52f93e9c61d 100644
> --- a/drivers/usb/gadget/udc/Makefile
> +++ b/drivers/usb/gadget/udc/Makefile
> @@ -42,3 +42,4 @@ obj-$(CONFIG_USB_ASPEED_VHUB)	+= aspeed-vhub/
>   obj-$(CONFIG_USB_ASPEED_UDC)	+= aspeed_udc.o
>   obj-$(CONFIG_USB_BDC_UDC)	+= bdc/
>   obj-$(CONFIG_USB_MAX3420_UDC)	+= max3420_udc.o
> +obj-$(CONFIG_USB_CDNS2_UDC)	+= cdns2/
> diff --git a/drivers/usb/gadget/udc/cdns2/Kconfig b/drivers/usb/gadget/udc/cdns2/Kconfig
> new file mode 100644
> index 000000000000..310db4788353
> --- /dev/null
> +++ b/drivers/usb/gadget/udc/cdns2/Kconfig
> @@ -0,0 +1,11 @@
> +config USB_CDNS2_UDC
> +	tristate "Cadence USBHS Device Controller"
> +	depends on USB_PCI && ACPI && HAS_DMA
> +	help
> +	  Cadence USBHS Device controller is a PCI based USB peripheral
> +	  controller which supports both full and high speed USB 2.0
> +	  data transfers.
> +
> +	  Say "y" to link the driver statically, or "m" to build a
> +	  dynamically linked module called "cdns2-pci.ko" and to

I'm not expert in module naming, but isn't it cdns2-udc-pci?

> +	  force all gadget drivers to also be dynamically linked.

[...]

> +static void cdns2_ep_tx_isoc(struct cdns2_endpoint *pep,
> +			     struct cdns2_request *preq,
> +			     int num_trbs)
> +{
> +	struct scatterlist *sg = NULL;
> +	u32 remaining_packet_size = 0;
> +	struct cdns2_trb *trb;
> +	bool first_trb = true;
> +	dma_addr_t trb_dma;
> +	u32 trb_buff_len;
> +	u32 block_length;
> +	int sg_iter = 0;

Not need to init.

> +	int sent_len;
> +	int td_idx = 0;
> +	int split_size;
> +	u32 control;

[...]

> +/* Prepare and start transfer for all not started requests. */
> +static int cdns2_start_all_request(struct cdns2_device *pdev,
> +				   struct cdns2_endpoint *pep)
> +{
> +	struct cdns2_request *preq;
> +	int ret = 0;
> +
> +	while (!list_empty(&pep->deferred_list)) {
> +		preq = cdns2_next_preq(&pep->deferred_list);
> +
> +		ret = cdns2_ep_run_transfer(pep, preq);
> +		if (ret)
> +			return ret;
> +
> +		list_move_tail(&preq->list, &pep->pending_list);
> +	}
> +
> +	pep->ep_state &= ~EP_RING_FULL;
> +
> +	return ret;

Maybe return 0; would be more explicit? (and would remove the "= 0" above)

> +}

[...]

> diff --git a/drivers/usb/gadget/udc/cdns2/cdns2-pci.c b/drivers/usb/gadget/udc/cdns2/cdns2-pci.c
> new file mode 100644
> index 000000000000..ab2891c79b5c
> --- /dev/null
> +++ b/drivers/usb/gadget/udc/cdns2/cdns2-pci.c
> @@ -0,0 +1,149 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Cadence USBHS-DEV controller - PCI Glue driver.
> + *
> + * Copyright (C) 2023 Cadence.
> + *
> + * Author: Pawel Laszczak <pawell-vna1KIf7WgpBDgjK7y7TUQ@public.gmane.org>
> + *
> + */
> +
> +#include <linux/pm_runtime.h>
> +#include <linux/slab.h>
> +#include <linux/pci.h>
> +
> +#include "cdns2-gadget.h"
> +
> +#define PCI_DRIVER_NAME		"cdns-pci-usbhs"
> +#define CDNS_VENDOR_ID		0x17cd
> +#define CDNS_DEVICE_ID		0x0120
> +#define PCI_BAR_DEV		0
> +#define PCI_DEV_FN_DEVICE	0
> +
> +static int cdns2_pci_probe(struct pci_dev *pdev,
> +			   const struct pci_device_id *id)
> +{
> +	resource_size_t rsrc_start, rsrc_len;
> +	struct device *dev = &pdev->dev;
> +	struct cdns2_device *priv_dev;
> +	struct resource *res;
> +	int ret;
> +
> +	/* For GADGET PCI (devfn) function number is 0. */
> +	if (!id || pdev->devfn != PCI_DEV_FN_DEVICE ||
> +	    pdev->class != PCI_CLASS_SERIAL_USB_DEVICE)
> +		return -EINVAL;
> +
> +	ret = pcim_enable_device(pdev);
> +	if (ret)
> +		dev_err(&pdev->dev, "Enabling PCI device has failed %d\n", ret);

Should we bail out in this case?

> +
> +	pci_set_master(pdev);
> +
> +	priv_dev = kzalloc(sizeof(*priv_dev), GFP_KERNEL);
> +	if (!priv_dev) {
> +		ret = -ENOMEM;
> +		goto disable_pci;

Any reason, not to use devm_kzalloc() and manually hanfle kfree() in the 
error handling path and in the removbe function ?

> +	}
> +
> +	dev_dbg(dev, "Initialize resources\n");
> +	rsrc_start = pci_resource_start(pdev, PCI_BAR_DEV);
> +	rsrc_len = pci_resource_len(pdev, PCI_BAR_DEV);
> +
> +	res = devm_request_mem_region(dev, rsrc_start, rsrc_len, "dev");
> +	if (!res) {
> +		dev_dbg(dev, "controller already in use\n");
> +		ret = -EBUSY;
> +		goto free_priv_dev;
> +	}
> +
> +	priv_dev->regs = devm_ioremap(dev, rsrc_start, rsrc_len);
> +	if (!priv_dev->regs) {
> +		dev_dbg(dev, "error mapping memory\n");
> +		ret = -EFAULT;
> +		goto free_priv_dev;
> +	}
> +
> +	priv_dev->irq = pdev->irq;
> +	dev_dbg(dev, "USBSS-DEV physical base addr: %pa\n",
> +		&rsrc_start);
> +
> +	priv_dev->dev = dev;
> +
> +	priv_dev->eps_supported = 0x000f000f;
> +	priv_dev->onchip_tx_buf = 16;
> +	priv_dev->onchip_rx_buf = 16;
> +
> +	ret = cdns2_gadget_init(priv_dev);
> +	if (ret)
> +		goto free_priv_dev;
> +
> +	pci_set_drvdata(pdev, priv_dev);
> +
> +	device_wakeup_enable(&pdev->dev);
> +	if (pci_dev_run_wake(pdev))
> +		pm_runtime_put_noidle(&pdev->dev);
> +
> +	return 0;
> +
> +free_priv_dev:
> +	kfree(priv_dev);
> +
> +disable_pci:
> +	pci_disable_device(pdev);
> +
> +	return ret;
> +}
> +
> +static void cdns2_pci_remove(struct pci_dev *pdev)
> +{
> +	struct cdns2_device *priv_dev = pci_get_drvdata(pdev);
> +
> +	if (pci_dev_run_wake(pdev))
> +		pm_runtime_get_noresume(&pdev->dev);
> +
> +	cdns2_gadget_remove(priv_dev);
> +	kfree(priv_dev);

There is a pci_disable_device() in the error handling path of the probe, 
but not in the remove function.

Is it on purpose?
Since pcim_enable_device() is used, is it needed above?

CJ

[...]

> +static struct pci_driver cdns2_pci_driver = {
> +	.name = "cdns2-pci",
> +	.id_table = &cdns2_pci_ids[0],
> +	.probe = cdns2_pci_probe,
> +	.remove = cdns2_pci_remove,
> +	.driver = {
> +		.pm = pm_ptr(&cdns2_pci_pm_ops),
> +	}
> +};
> +
> +module_pci_driver(cdns2_pci_driver);
> +MODULE_DEVICE_TABLE(pci, cdns2_pci_ids);
> +
> +MODULE_ALIAS("pci:cdns2");
> +MODULE_AUTHOR("Pawel Laszczak <pawell-vna1KIf7WgpBDgjK7y7TUQ@public.gmane.org>");
> +MODULE_LICENSE("GPL");
> +MODULE_DESCRIPTION("Cadence CDNS2 PCI driver");

