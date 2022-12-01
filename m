Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CEC663ED7A
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 11:19:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230090AbiLAKTL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 05:19:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229977AbiLAKSv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 05:18:51 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94DC952896;
        Thu,  1 Dec 2022 02:18:40 -0800 (PST)
Received: from frapeml100005.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4NNBm40ZnTz6HJbY;
        Thu,  1 Dec 2022 18:15:32 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (7.191.163.240) by
 frapeml100005.china.huawei.com (7.182.85.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 1 Dec 2022 11:18:38 +0100
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 1 Dec
 2022 10:18:37 +0000
Date:   Thu, 1 Dec 2022 10:18:36 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     <ira.weiny@intel.com>
CC:     Dan Williams <dan.j.williams@intel.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "Ben Widawsky" <bwidawsk@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        "Dave Jiang" <dave.jiang@intel.com>,
        <linux-kernel@vger.kernel.org>, <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH V2 01/11] cxl/pci: Add generic MSI-X/MSI irq support
Message-ID: <20221201101836.00004582@Huawei.com>
In-Reply-To: <20221201002719.2596558-2-ira.weiny@intel.com>
References: <20221201002719.2596558-1-ira.weiny@intel.com>
        <20221201002719.2596558-2-ira.weiny@intel.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml500001.china.huawei.com (7.191.163.213) To
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

On Wed, 30 Nov 2022 16:27:09 -0800
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

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> 
> ---
> Changes from V1:
> 	Jonathan
> 		pci_alloc_irq_vectors() cleans up the vectors automatically
> 		use msi_enabled rather than nr_irq_vecs
> 
> Changes from Ira
> 	Remove reviews
> 	Allocate up to a static 16 vectors.
> 	Change cover letter
> ---
>  drivers/cxl/cxlmem.h |  3 +++
>  drivers/cxl/cxlpci.h |  6 ++++++
>  drivers/cxl/pci.c    | 23 +++++++++++++++++++++++
>  3 files changed, 32 insertions(+)
> 
> diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> index 88e3a8e54b6a..cd35f43fedd4 100644
> --- a/drivers/cxl/cxlmem.h
> +++ b/drivers/cxl/cxlmem.h
> @@ -211,6 +211,7 @@ struct cxl_endpoint_dvsec_info {
>   * @info: Cached DVSEC information about the device.
>   * @serial: PCIe Device Serial Number
>   * @doe_mbs: PCI DOE mailbox array
> + * @msi_enabled: MSI-X/MSI has been enabled
>   * @mbox_send: @dev specific transport for transmitting mailbox commands
>   *
>   * See section 8.2.9.5.2 Capacity Configuration and Label Storage for
> @@ -247,6 +248,8 @@ struct cxl_dev_state {
>  
>  	struct xarray doe_mbs;
>  
> +	bool msi_enabled;
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
> index faeb5d9d7a7a..8f86f85d89c7 100644
> --- a/drivers/cxl/pci.c
> +++ b/drivers/cxl/pci.c
> @@ -428,6 +428,27 @@ static void devm_cxl_pci_create_doe(struct cxl_dev_state *cxlds)
>  	}
>  }
>  
> +static void cxl_pci_alloc_irq_vectors(struct cxl_dev_state *cxlds)
> +{
> +	struct device *dev = cxlds->dev;
> +	struct pci_dev *pdev = to_pci_dev(dev);
> +	int nvecs;
> +
> +	/*
> +	 * NOTE: pci_alloc_irq_vectors() handles calling pci_free_irq_vectors()
> +	 * automatically despite not being called pcim_*.  See
> +	 * pci_setup_msi_context().
> +	 */
> +	nvecs = pci_alloc_irq_vectors(pdev, 1, CXL_PCI_REQUIRED_VECTORS,
> +				   PCI_IRQ_MSIX | PCI_IRQ_MSI);
> +	if (nvecs < 0) {
> +		dev_dbg(dev, "Failed to alloc irq vectors; use polling instead.\n");
> +		return;
> +	}
> +
> +	cxlds->msi_enabled = true;
> +}
> +
>  static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  {
>  	struct cxl_register_map map;
> @@ -494,6 +515,8 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  	if (rc)
>  		return rc;
>  
> +	cxl_pci_alloc_irq_vectors(cxlds);
> +
>  	cxlmd = devm_cxl_add_memdev(cxlds);
>  	if (IS_ERR(cxlmd))
>  		return PTR_ERR(cxlmd);

