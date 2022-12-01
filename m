Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACDED63F792
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 19:38:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229713AbiLASiC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 13:38:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229625AbiLASiA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 13:38:00 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DFB21EC65;
        Thu,  1 Dec 2022 10:37:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669919879; x=1701455879;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=iPRwggNOmQxuO71WGjy8ua4ueC+pvJHPP8yaHdcqSwM=;
  b=kSiqyCC2Uv3IP3+/jLMX1XoXADaIApRus99dGBMybSxW6eu51spTnlff
   d8uXLbqEKro1/+zknnoH6uh+gdx/pNuQZ4Qv6Rmps4uI5J8GW/h+CrBi9
   k8pimeKEKHfR34pqwoENmfIfJvB9RfdhQyofTtxRYyYEc2TAJ2pry6wJu
   Exle5vicRgj588oY6p4F8FeNlrp6ug+CpxRxGyt0MSybn5nfKBgaMKfNG
   OwqZ/ynL2TtSe5XS37kEBXF32pYwOi8LnNa/L2nMPUK15mC6wQOVmpVF4
   HcXr7flTRK3/UJ6n4nKVLt26uHwvd541B4/m98/YDkAbnnHs3lkMNS+kE
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10548"; a="402045606"
X-IronPort-AV: E=Sophos;i="5.96,210,1665471600"; 
   d="scan'208";a="402045606"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2022 10:37:59 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10548"; a="769333984"
X-IronPort-AV: E=Sophos;i="5.96,210,1665471600"; 
   d="scan'208";a="769333984"
Received: from djiang5-mobl2.amr.corp.intel.com (HELO [10.212.66.184]) ([10.212.66.184])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2022 10:37:56 -0800
Message-ID: <e896ca47-6192-190f-ad63-6a294c0c246e@intel.com>
Date:   Thu, 1 Dec 2022 11:37:54 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.5.0
Subject: Re: [PATCH V2 01/11] cxl/pci: Add generic MSI-X/MSI irq support
Content-Language: en-US
To:     ira.weiny@intel.com, Dan Williams <dan.j.williams@intel.com>
Cc:     Davidlohr Bueso <dave@stgolabs.net>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org
References: <20221201002719.2596558-1-ira.weiny@intel.com>
 <20221201002719.2596558-2-ira.weiny@intel.com>
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20221201002719.2596558-2-ira.weiny@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/30/2022 5:27 PM, ira.weiny@intel.com wrote:
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

Reviewed-by: Dave Jiang <dave.jiang@intel.com>

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
>   drivers/cxl/cxlmem.h |  3 +++
>   drivers/cxl/cxlpci.h |  6 ++++++
>   drivers/cxl/pci.c    | 23 +++++++++++++++++++++++
>   3 files changed, 32 insertions(+)
> 
> diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> index 88e3a8e54b6a..cd35f43fedd4 100644
> --- a/drivers/cxl/cxlmem.h
> +++ b/drivers/cxl/cxlmem.h
> @@ -211,6 +211,7 @@ struct cxl_endpoint_dvsec_info {
>    * @info: Cached DVSEC information about the device.
>    * @serial: PCIe Device Serial Number
>    * @doe_mbs: PCI DOE mailbox array
> + * @msi_enabled: MSI-X/MSI has been enabled
>    * @mbox_send: @dev specific transport for transmitting mailbox commands
>    *
>    * See section 8.2.9.5.2 Capacity Configuration and Label Storage for
> @@ -247,6 +248,8 @@ struct cxl_dev_state {
>   
>   	struct xarray doe_mbs;
>   
> +	bool msi_enabled;
> +
>   	int (*mbox_send)(struct cxl_dev_state *cxlds, struct cxl_mbox_cmd *cmd);
>   };
>   
> diff --git a/drivers/cxl/cxlpci.h b/drivers/cxl/cxlpci.h
> index eec597dbe763..b7f4e2f417d3 100644
> --- a/drivers/cxl/cxlpci.h
> +++ b/drivers/cxl/cxlpci.h
> @@ -53,6 +53,12 @@
>   #define	    CXL_DVSEC_REG_LOCATOR_BLOCK_ID_MASK			GENMASK(15, 8)
>   #define     CXL_DVSEC_REG_LOCATOR_BLOCK_OFF_LOW_MASK		GENMASK(31, 16)
>   
> +/*
> + * NOTE: Currently all the functions which are enabled for CXL require their
> + * vectors to be in the first 16.  Use this as the max.
> + */
> +#define CXL_PCI_REQUIRED_VECTORS 16
> +
>   /* Register Block Identifier (RBI) */
>   enum cxl_regloc_type {
>   	CXL_REGLOC_RBI_EMPTY = 0,
> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> index faeb5d9d7a7a..8f86f85d89c7 100644
> --- a/drivers/cxl/pci.c
> +++ b/drivers/cxl/pci.c
> @@ -428,6 +428,27 @@ static void devm_cxl_pci_create_doe(struct cxl_dev_state *cxlds)
>   	}
>   }
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
>   static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>   {
>   	struct cxl_register_map map;
> @@ -494,6 +515,8 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>   	if (rc)
>   		return rc;
>   
> +	cxl_pci_alloc_irq_vectors(cxlds);
> +
>   	cxlmd = devm_cxl_add_memdev(cxlds);
>   	if (IS_ERR(cxlmd))
>   		return PTR_ERR(cxlmd);
