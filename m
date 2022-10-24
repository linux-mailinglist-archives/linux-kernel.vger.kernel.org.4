Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1238C60BD23
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 00:09:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231804AbiJXWJs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 18:09:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232542AbiJXWJF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 18:09:05 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC871300708;
        Mon, 24 Oct 2022 13:22:59 -0700 (PDT)
Received: from fraeml714-chm.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Mwz9Y6CVTz6HJXk;
        Mon, 24 Oct 2022 23:13:37 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (7.191.163.240) by
 fraeml714-chm.china.huawei.com (10.206.15.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 24 Oct 2022 17:14:56 +0200
Received: from localhost (10.202.226.42) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Mon, 24 Oct
 2022 16:14:56 +0100
Date:   Mon, 24 Oct 2022 16:14:54 +0100
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     Terry Bowman <terry.bowman@amd.com>
CC:     <alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
        <dave.jiang@intel.com>, <ira.weiny@intel.com>,
        <bwidawsk@kernel.org>, <dan.j.williams@intel.com>,
        <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <bhelgaas@google.com>, <rafael@kernel.org>, <lenb@kernel.org>,
        <dave@stgolabs.net>, <rrichter@amd.com>
Subject: Re: [PATCH 5/5] cxl/pci: Log CXL device's PCIe AER and CXL RAS
 error information
Message-ID: <20221024161454.00003d18@huawei.com>
In-Reply-To: <20221021185615.605233-6-terry.bowman@amd.com>
References: <20221021185615.605233-1-terry.bowman@amd.com>
        <20221021185615.605233-6-terry.bowman@amd.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.42]
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

On Fri, 21 Oct 2022 13:56:15 -0500
Terry Bowman <terry.bowman@amd.com> wrote:

> The CXL downport PCIe AER and CXL RAS capability information needs to be
> logged during PCIe AER error handling.
> 
> The existing PCIe AER error handler logs native AER errors but does not
> log upport/downport AER capability residing in the RCRB. The CXL1.1
> RCRB does not have a BDF and is not enunmerable. The existing error handler
> logic does not display CXL RAS details either.

So this is doing two things? 
If so split it into dealing with the non enumerable part, and then a separate
patch to deal with the CXL RAS information. However, I'm only spotting the
CXL RAS handling part in here.

Also, there are numerous drivers that provide additional logging in response
to an AER error. With the exception of providing a way to do that for
corrected errors (as I mentioned in David Jiang's series on CXL 2.0+ RAS handling)
I don't think we should be doing anything down in the PCI layers for this.
We should see an internal AER error and then the CXL driver should handle that,
adding more logging as needed.

> 
> Add a CXL error handler to the existing PCI error handlers. Add a call
> to the CXL error handler within the PCIe AER error handler. Implement the
> driver's CXL callback to log downport PCIe AER and CXL RAS capability
> information.
> 
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> ---
>  drivers/cxl/pci.c      | 76 ++++++++++++++++++++++++++++++++++++++++++
>  drivers/pci/pcie/aer.c | 45 ++++++++++++++++++++++++-
>  include/linux/pci.h    |  4 +++
>  3 files changed, 124 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> index 80a01b304efe..dceda9f9fc60 100644
> --- a/drivers/cxl/pci.c
> +++ b/drivers/cxl/pci.c
> @@ -7,6 +7,7 @@
>  #include <linux/sizes.h>
>  #include <linux/mutex.h>
>  #include <linux/list.h>
> +#include <linux/aer.h>
>  #include <linux/pci.h>
>  #include <linux/pci-doe.h>
>  #include <linux/io.h>
> @@ -14,6 +15,9 @@
>  #include "cxlpci.h"
>  #include "cxl.h"
>  
> +extern void cxl_print_aer(struct pci_dev *dev, int aer_severity,
> +			  struct aer_capability_regs *aer);
> +
>  /**
>   * DOC: cxl pci
>   *
> @@ -744,9 +748,80 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  	if (resource_size(&cxlds->pmem_res) && IS_ENABLED(CONFIG_CXL_PMEM))
>  		rc = devm_cxl_add_nvdimm(&pdev->dev, cxlmd);
>  
> +	dev_set_drvdata(&pdev->dev, cxlmd);
> +
>  	return rc;
>  }
>  
> +struct ras_cap {
> +	u32 uc_error_status;
> +	u32 uc_error_mask;
> +	u32 uc_error_severity;
> +	u32 c_error_status;
> +	u32 c_error_mask;
> +	u32 ctrl;
> +	u32 log[];
> +};
> +
> +/*
> + * Log the state of the CXL downport AER and RAS status registers.
> + */
> +static void cxl_error_report(struct cxl_memdev *cxlmd)
> +{
> +	struct pci_dev *pdev = to_pci_dev(cxlmd->cxlds->dev);
> +	struct aer_capability_regs *aer_cap;
> +	struct ras_cap *ras_cap;
> +
> +	aer_cap = (struct aer_capability_regs *)cxlmd->cxlds->aer_map.base;
> +	ras_cap = (struct ras_cap *)cxlmd->cxlds->ras_map.base;
> +
> +	pci_err(pdev, "CXL Error Report\n");
> +	pci_err(pdev, "AER Errors:\n");
> +	if (aer_cap) {
> +		cxl_print_aer(pdev, AER_CORRECTABLE, aer_cap);
> +		cxl_print_aer(pdev, AER_NONFATAL, aer_cap);
> +		cxl_print_aer(pdev, AER_FATAL, aer_cap);
> +	}
> +
> +	pci_err(pdev, "RAS Errors:\n");
> +	if (ras_cap) {
> +		pci_err(pdev, "RAS: uc_error_status = %X\n", readl(&ras_cap->uc_error_status));
> +		pci_err(pdev, "RAS: uc_error_mask = %X\n", readl(&ras_cap->uc_error_mask));
> +		pci_err(pdev, "RAS: uc_error_severity = %X\n", readl(&ras_cap->uc_error_severity));
> +		pci_err(pdev, "RAS: c_error_status = %X\n", readl(&ras_cap->c_error_status));
> +		pci_err(pdev, "RAS: c_error_mask = %X\n", readl(&ras_cap->c_error_mask));
> +		pci_err(pdev, "RAS: ras_caps->ctrl = %X\n", readl(&ras_cap->ctrl));
> +		pci_err(pdev, "RAS: log = %X\n", readl(&ras_cap->log));
> +	}
> +}
> +
> +static void cxl_error_detected(struct pci_dev *pdev)
> +{
> +	struct cxl_memdev *cxlmd;
> +
> +	if (!is_cxl_memdev(&pdev->dev)) {
> +		pci_err(pdev, "CXL memory device is invalid\n");
> +		return;
> +	}
> +
> +	cxlmd = dev_get_drvdata(&pdev->dev);
> +	if (!cxlmd) {
> +		pci_err(pdev, "CXL memory device is NULL\n");
> +		return;
> +	}
> +
> +	if (!cxlmd->cxlds) {
> +		pci_err(pdev, "CXL device state object is NULL\n");
> +		return;
> +	}
> +
> +	cxl_error_report(cxlmd);
> +}
> +
> +static struct pci_error_handlers cxl_error_handlers = {
> +	.cxl_error_detected = cxl_error_detected,
> +};
> +
>  static const struct pci_device_id cxl_mem_pci_tbl[] = {
>  	/* PCI class code for CXL.mem Type-3 Devices */
>  	{ PCI_DEVICE_CLASS((PCI_CLASS_MEMORY_CXL << 8 | CXL_MEMORY_PROGIF), ~0)},
> @@ -761,6 +836,7 @@ static struct pci_driver cxl_pci_driver = {
>  	.driver	= {
>  		.probe_type	= PROBE_PREFER_ASYNCHRONOUS,
>  	},
> +	.err_handler		= &cxl_error_handlers,
>  };
>  
>  MODULE_LICENSE("GPL v2");
> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> index e2d8a74f83c3..dea04d412406 100644
> --- a/drivers/pci/pcie/aer.c
> +++ b/drivers/pci/pcie/aer.c
> @@ -811,6 +811,13 @@ void cper_print_aer(struct pci_dev *dev, int aer_severity,
>  }
>  #endif
>  
> +void cxl_print_aer(struct pci_dev *dev, int aer_severity,
> +		    struct aer_capability_regs *aer)
> +{
> +	cper_print_aer(dev, aer_severity, aer);
> +}
> +EXPORT_SYMBOL_GPL(cxl_print_aer);
> +
>  /**
>   * add_error_device - list device to be handled
>   * @e_info: pointer to error info
> @@ -1169,6 +1176,40 @@ static void aer_isr_one_error(struct aer_rpc *rpc,
>  	}
>  }
>  
> +static int report_cxl_errors_iter(struct pci_dev *pdev, void *data)
> +{
> +	struct pci_driver *pdrv = pdev->driver;
> +
> +	if (pdrv &&
> +	    pdrv->err_handler &&
> +	    pdrv->err_handler->cxl_error_detected)
> +		pdrv->err_handler->cxl_error_detected(pdev);
> +
> +	return 0;
> +}
> +
> +static void report_cxl_errors(struct aer_rpc *rpc,
> +			      struct aer_err_source *e_src)
> +{
> +	struct pci_dev *pdev = rpc->rpd;
> +	struct aer_err_info e_info;
> +	u32 uncor_status, cor_status;
> +
> +	pci_read_config_dword(pdev, pdev->aer_cap + PCI_ERR_UNCOR_STATUS, &uncor_status);
> +	pci_read_config_dword(pdev, pdev->aer_cap + PCI_ERR_COR_STATUS, &cor_status);
> +
> +	if (!uncor_status && !cor_status)
> +		return;
> +
> +	if (pci_pcie_type(pdev) == PCI_EXP_TYPE_RC_EC)
> +		pcie_walk_rcec(pdev, report_cxl_errors_iter, &e_info);
> +	else
> +		pci_walk_bus(pdev->subordinate, report_cxl_errors_iter, &e_info);
> +
> +	pci_write_config_dword(pdev, pdev->aer_cap + PCI_ERR_UNCOR_STATUS, uncor_status);
> +	pci_write_config_dword(pdev, pdev->aer_cap + PCI_ERR_COR_STATUS, cor_status);
> +}
> +
>  /**
>   * aer_isr - consume errors detected by root port
>   * @irq: IRQ assigned to Root Port
> @@ -1185,8 +1226,10 @@ static irqreturn_t aer_isr(int irq, void *context)
>  	if (kfifo_is_empty(&rpc->aer_fifo))
>  		return IRQ_NONE;
>  
> -	while (kfifo_get(&rpc->aer_fifo, &e_src))
> +	while (kfifo_get(&rpc->aer_fifo, &e_src)) {
> +		report_cxl_errors(rpc, &e_src);
>  		aer_isr_one_error(rpc, &e_src);
> +	}
>  	return IRQ_HANDLED;
>  }
>  
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 2bda4a4e47e8..4f4b3a8f5454 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -827,6 +827,10 @@ enum pci_ers_result {
>  
>  /* PCI bus error event callbacks */
>  struct pci_error_handlers {
> +
> +	/* CXL error detected on this device */
> +	void (*cxl_error_detected)(struct pci_dev *dev);
> +
>  	/* PCI bus error detected on this device */
>  	pci_ers_result_t (*error_detected)(struct pci_dev *dev,
>  					   pci_channel_state_t error);

