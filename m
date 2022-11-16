Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C466362C174
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 15:54:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230343AbiKPOyf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 09:54:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232035AbiKPOyK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 09:54:10 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 544861057C;
        Wed, 16 Nov 2022 06:53:45 -0800 (PST)
Received: from fraeml701-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4NC5bC0LnHz6HJVM;
        Wed, 16 Nov 2022 22:51:19 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (7.191.163.240) by
 fraeml701-chm.china.huawei.com (10.206.15.50) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2375.31; Wed, 16 Nov 2022 15:53:42 +0100
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Wed, 16 Nov
 2022 14:53:42 +0000
Date:   Wed, 16 Nov 2022 14:53:41 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     <ira.weiny@intel.com>
CC:     Dan Williams <dan.j.williams@intel.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "Ben Widawsky" <bwidawsk@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        <linux-kernel@vger.kernel.org>, <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH 01/11] cxl/pci: Add generic MSI-X/MSI irq support
Message-ID: <20221116145341.00006411@Huawei.com>
In-Reply-To: <20221110185758.879472-2-ira.weiny@intel.com>
References: <20221110185758.879472-1-ira.weiny@intel.com>
        <20221110185758.879472-2-ira.weiny@intel.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml500004.china.huawei.com (7.191.163.9) To
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

On Thu, 10 Nov 2022 10:57:48 -0800
ira.weiny@intel.com wrote:

> From: Davidlohr Bueso <dave@stgolabs.net>
> 
> Currently the only CXL features targeted for irq support require their
> message numbers to be within the first 16 entries.  The device may
> however support less than 16 entries depending on the support it
> provides.
> 
> Attempt to allocate these 16 irq vectors.  If the device supports less
> then the PCI infrastructure will allocate that number.  Store the number
> of vectors actually allocated in the device state for later use
> by individual functions.
See later patch review, but I don't think we need to store the number
allocated because any vector is guaranteed to be below that point
(QEMU code is wrong on this at the momemt, but there are very few vectors
 so it hasn't mattered yet).

Otherwise, pcim fun deals with some of the cleanup you are doing again
here for us so can simplify this somewhat. See inline.

Jonathan



> 
> Upon successful allocation, users can plug in their respective isr at
> any point thereafter, for example, if the irq setup is not done in the
> PCI driver, such as the case of the CXL-PMU.
> 
> Cc: Bjorn Helgaas <helgaas@kernel.org>
> Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Co-developed-by: Ira Weiny <ira.weiny@intel.com>
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
> 
> ---
> Changes from Ira
> 	Remove reviews
> 	Allocate up to a static 16 vectors.
> 	Change cover letter
> ---
>  drivers/cxl/cxlmem.h |  3 +++
>  drivers/cxl/cxlpci.h |  6 ++++++
>  drivers/cxl/pci.c    | 32 ++++++++++++++++++++++++++++++++
>  3 files changed, 41 insertions(+)
> 
> diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> index 88e3a8e54b6a..b7b955ded3ac 100644
> --- a/drivers/cxl/cxlmem.h
> +++ b/drivers/cxl/cxlmem.h
> @@ -211,6 +211,7 @@ struct cxl_endpoint_dvsec_info {
>   * @info: Cached DVSEC information about the device.
>   * @serial: PCIe Device Serial Number
>   * @doe_mbs: PCI DOE mailbox array
> + * @nr_irq_vecs: Number of MSI-X/MSI vectors available
>   * @mbox_send: @dev specific transport for transmitting mailbox commands
>   *
>   * See section 8.2.9.5.2 Capacity Configuration and Label Storage for
> @@ -247,6 +248,8 @@ struct cxl_dev_state {
>  
>  	struct xarray doe_mbs;
>  
> +	int nr_irq_vecs;
> +
>  	int (*mbox_send)(struct cxl_dev_state *cxlds, struct cxl_mbox_cmd *cmd);
>  };
>  
> diff --git a/drivers/cxl/cxlpci.h b/drivers/cxl/cxlpci.h
> index eec597dbe763..b7f4e2f417d3 100644
> --- a/drivers/cxl/cxlpci.h
> +++ b/drivers/cxl/cxlpci.h
> @@ -53,6 +53,12 @@
>  #define	    CXL_DVSEC_REG_LOCATOR_BLOCK_ID_MASK			GENMASK(15, 8)
>  #define     CXL_DVSEC_REG_LOCATOR_BLOCK_OFF_LOW_MASK		GENMASK(31, 16)
>  
> +/*
> + * NOTE: Currently all the functions which are enabled for CXL require their
> + * vectors to be in the first 16.  Use this as the max.
> + */
> +#define CXL_PCI_REQUIRED_VECTORS 16
> +
>  /* Register Block Identifier (RBI) */
>  enum cxl_regloc_type {
>  	CXL_REGLOC_RBI_EMPTY = 0,
> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> index faeb5d9d7a7a..62e560063e50 100644
> --- a/drivers/cxl/pci.c
> +++ b/drivers/cxl/pci.c
> @@ -428,6 +428,36 @@ static void devm_cxl_pci_create_doe(struct cxl_dev_state *cxlds)
>  	}
>  }
>  
> +static void cxl_pci_free_irq_vectors(void *data)
> +{
> +	pci_free_irq_vectors(data);
> +}
> +
> +static void cxl_pci_alloc_irq_vectors(struct cxl_dev_state *cxlds)
> +{
> +	struct device *dev = cxlds->dev;
> +	struct pci_dev *pdev = to_pci_dev(dev);
> +	int nvecs;
> +	int rc;
> +
> +	nvecs = pci_alloc_irq_vectors(pdev, 1, CXL_PCI_REQUIRED_VECTORS,
> +				   PCI_IRQ_MSIX | PCI_IRQ_MSI);
> +	if (nvecs < 0) {
> +		dev_dbg(dev, "Not enough interrupts; use polling instead.\n");
> +		return;
> +	}
> +
> +	rc = devm_add_action_or_reset(dev, cxl_pci_free_irq_vectors, pdev);
The pci managed code always gives me a headache because there is a lot of magic
under the hood if you ever called pcim_enable_device() which we did.

Chasing through

pci_alloc_irq_vectors_affinity()->
either
	__pci_enable_msix_range()
or
	__pci_enable_msi_range()

they are similar
	pci_setup_msi_context()
		pci_setup_msi_release()
			adds pcmi_msi_release devm action.
and that frees the vectors for us.
So we don't need to do it here.


> +	if (rc) {
> +		dev_dbg(dev, "Device managed call failed; interrupts disabled.\n");
> +		/* some got allocated, clean them up */
> +		cxl_pci_free_irq_vectors(pdev);
We could just leave them lying around for devm cleanup to sweep up eventually
or free them as you have done here.

> +		return;
> +	}
> +
> +	cxlds->nr_irq_vecs = nvecs;
> +}
> +
>  static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  {
>  	struct cxl_register_map map;
> @@ -494,6 +524,8 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  	if (rc)
>  		return rc;
>  
> +	cxl_pci_alloc_irq_vectors(cxlds);
> +
>  	cxlmd = devm_cxl_add_memdev(cxlds);
>  	if (IS_ERR(cxlmd))
>  		return PTR_ERR(cxlmd);

