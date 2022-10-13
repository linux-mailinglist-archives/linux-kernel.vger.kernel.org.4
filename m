Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C76585FD91A
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 14:19:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229590AbiJMMTU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 08:19:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbiJMMTS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 08:19:18 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 034634B0E8;
        Thu, 13 Oct 2022 05:19:17 -0700 (PDT)
Received: from fraeml706-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Mp7nb3dCxz6H7LH;
        Thu, 13 Oct 2022 20:17:39 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (7.191.163.240) by
 fraeml706-chm.china.huawei.com (10.206.15.55) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2375.31; Thu, 13 Oct 2022 14:19:14 +0200
Received: from localhost (10.202.226.42) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Thu, 13 Oct
 2022 13:19:14 +0100
Date:   Thu, 13 Oct 2022 13:19:13 +0100
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     Davidlohr Bueso <dave@stgolabs.net>
CC:     <dan.j.williams@intel.com>, <ira.weiny@intel.com>,
        <alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
        <bwidawsk@kernel.org>, <a.manzanares@samsung.com>,
        <linux-kernel@vger.kernel.org>, <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH] cxl: Add generic MSI/MSI-X interrupt support
Message-ID: <20221013131913.0000038b@huawei.com>
In-Reply-To: <20221012180432.473373-1-dave@stgolabs.net>
References: <20221012180432.473373-1-dave@stgolabs.net>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.42]
X-ClientProxiedBy: lhrpeml500006.china.huawei.com (7.191.161.198) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 Oct 2022 11:04:32 -0700
Davidlohr Bueso <dave@stgolabs.net> wrote:

> Introduce a generic irq table for CXL components/features that can have
> standard irq support - DOE requires dynamic vector sizing and is not
> considered here.
> 
> Create an infrastructure to query the max vectors required for the CXL
> device.
> 
> Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>

Hi Davidlohr,

Basically good, but a few comments inline.

I'll role this onto front of the v2 of the CPMU set as well.

> ---
>  drivers/cxl/pci.c | 63 +++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 63 insertions(+)
> 
> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> index faeb5d9d7a7a..467f2d568e3e 100644
> --- a/drivers/cxl/pci.c
> +++ b/drivers/cxl/pci.c
> @@ -428,6 +428,66 @@ static void devm_cxl_pci_create_doe(struct cxl_dev_state *cxlds)
>  	}
>  }
>  
> +/**
> + * struct cxl_irq_cap - CXL feature that is capable of receiving MSI/MSI-X irqs.
> + *
> + * @name: Name of the device generating this interrupt.
> + * @get_max_msgnum: Get the feature's largest interrupt message number.  If the
> + *		    feature does not have the Interrupt Supported bit set, then
> + *		    return -1.
> + */
> +struct cxl_irq_cap {
> +	const char *name;
> +	int (*get_max_msgnum)(struct cxl_dev_state *cxlds);

For the CPMU case I need to walk the register locator dvsec block so need
the callback to take the pci_dev not the cxl_dev_state.

Also need it later to map the resulting register blocks to go find the irq before
then dropping them mappings so that the resulting CPMU device can grab them
later.

> +};
> +
> +static const struct cxl_irq_cap cxl_irq_cap_table[] = {
> +	{ "isolation", NULL },
> +	{ "pmu_overflow", NULL },
> +	{ "mailbox", NULL },
> +	{ "event", NULL },

Fill these in as we provide them, not upfront. I'd rather see this
attached to one (or possibly several) of the series that are coming along
than stand alone.  so start off with an empty table.



> +};
> +
> +static void cxl_pci_free_irq_vectors(void *data)
> +{
> +	pci_free_irq_vectors(data);
> +}
> +
> +static int cxl_pci_alloc_irq_vectors(struct cxl_dev_state *cxlds)
> +{
> +	struct device *dev = cxlds->dev;
> +	struct pci_dev *pdev = to_pci_dev(dev);
> +	int rc, i, vectors = -1;
> +
> +	for (i = 0; i < ARRAY_SIZE(cxl_irq_cap_table); i++) {
> +		int irq;
> +
> +		if (!cxl_irq_cap_table[i].get_max_msgnum)
> +			continue;
> +
> +		irq = cxl_irq_cap_table[i].get_max_msgnum(cxlds);
> +		vectors = max_t(int, irq, vectors);
> +	}
> +
> +	if (vectors == -1)
> +		return -EINVAL; /* no irq support whatsoever */

return 0 in this case.  No irqs present is a 'good' result if there
aren't any.  Will be up to the consumers of the interrupts to get
their own interrupt vector numbers and they should get the same
answers!

> +
> +	vectors++;
> +	rc = pci_alloc_irq_vectors(pdev, vectors, vectors,
> +				   PCI_IRQ_MSIX | PCI_IRQ_MSI);
> +	if (rc < 0)
> +		return rc;
> +
> +	if (rc != vectors) {
> +		dev_err(dev, "Not enough interrupts; use polling where supported\n");
> +		/* Some got allocated; clean them up */
> +		cxl_pci_free_irq_vectors(pdev);
> +		return -ENOSPC;
> +	}
> +
> +	return devm_add_action_or_reset(dev, cxl_pci_free_irq_vectors, pdev);
> +}
> +
>  static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  {
>  	struct cxl_register_map map;
> @@ -498,6 +558,9 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  	if (IS_ERR(cxlmd))
>  		return PTR_ERR(cxlmd);
>  
> +	/* TODO: When there are users, this return value must be checked */
> +	cxl_pci_alloc_irq_vectors(cxlds);
> +

Gut feeling is this will end up moving ahead of any of the sub device creation
because many of them end up needing interrupts.

Also check response from the start - can't see a reason to not do so as we
won't be registering any at all if no callbacks provided.

So I'd move it above the devm_cxl_add_memdev() call.



>  	if (resource_size(&cxlds->pmem_res) && IS_ENABLED(CONFIG_CXL_PMEM))
>  		rc = devm_cxl_add_nvdimm(&pdev->dev, cxlmd);
>  

