Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90A6F62A45D
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 22:42:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231638AbiKOVmQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 16:42:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232694AbiKOVlx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 16:41:53 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C782317C0;
        Tue, 15 Nov 2022 13:41:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668548477; x=1700084477;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=lJ9FAOEWNGpF/gfwGQHYQslkX4L7S9TxFwlifaibAf0=;
  b=c69W3iqhvo1ijhuzV9ngQF0XiflQfOZd+2M8qM4Uztc9dI7Hivf5C6HU
   Fk6irUUlMMaA9oiVRXrim3goQNVd54ug/WCNlrrdMAjxKW49fcQjDilPG
   GrgvuFGBMJLwBrcjHv/H8JbPo2P3ei5TeW0qow8vO+qb/z39A7ProNypK
   BuXAMjZX/3a48nAUl+eSu1PHvIvNQqIgmdq7LgGswnugluK2TvsEHTY2S
   Ga1fDWMaD2DuR9Kj59SbaImdzYuaRm1qcO8RMpFg93lCGuqG7tzkkN0fn
   9iIEuCjB5Rh11FEjl1B/QC0AhnuK3XqEi2CxInDy8gsRo1e76agZ0tcYl
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10532"; a="398662952"
X-IronPort-AV: E=Sophos;i="5.96,167,1665471600"; 
   d="scan'208";a="398662952"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2022 13:41:17 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10532"; a="702596153"
X-IronPort-AV: E=Sophos;i="5.96,167,1665471600"; 
   d="scan'208";a="702596153"
Received: from djiang5-mobl2.amr.corp.intel.com (HELO [10.212.7.249]) ([10.212.7.249])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2022 13:41:16 -0800
Message-ID: <176515c1-ecdb-7772-f2c4-521921295b20@intel.com>
Date:   Tue, 15 Nov 2022 14:41:15 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.4.1
Subject: Re: [PATCH 01/11] cxl/pci: Add generic MSI-X/MSI irq support
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
References: <20221110185758.879472-1-ira.weiny@intel.com>
 <20221110185758.879472-2-ira.weiny@intel.com>
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20221110185758.879472-2-ira.weiny@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/10/2022 10:57 AM, ira.weiny@intel.com wrote:
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
> Changes from Ira
> 	Remove reviews
> 	Allocate up to a static 16 vectors.
> 	Change cover letter
> ---
>   drivers/cxl/cxlmem.h |  3 +++
>   drivers/cxl/cxlpci.h |  6 ++++++
>   drivers/cxl/pci.c    | 32 ++++++++++++++++++++++++++++++++
>   3 files changed, 41 insertions(+)
> 
> diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> index 88e3a8e54b6a..b7b955ded3ac 100644
> --- a/drivers/cxl/cxlmem.h
> +++ b/drivers/cxl/cxlmem.h
> @@ -211,6 +211,7 @@ struct cxl_endpoint_dvsec_info {
>    * @info: Cached DVSEC information about the device.
>    * @serial: PCIe Device Serial Number
>    * @doe_mbs: PCI DOE mailbox array
> + * @nr_irq_vecs: Number of MSI-X/MSI vectors available
>    * @mbox_send: @dev specific transport for transmitting mailbox commands
>    *
>    * See section 8.2.9.5.2 Capacity Configuration and Label Storage for
> @@ -247,6 +248,8 @@ struct cxl_dev_state {
>   
>   	struct xarray doe_mbs;
>   
> +	int nr_irq_vecs;
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
> index faeb5d9d7a7a..62e560063e50 100644
> --- a/drivers/cxl/pci.c
> +++ b/drivers/cxl/pci.c
> @@ -428,6 +428,36 @@ static void devm_cxl_pci_create_doe(struct cxl_dev_state *cxlds)
>   	}
>   }
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
> +	if (rc) {
> +		dev_dbg(dev, "Device managed call failed; interrupts disabled.\n");
> +		/* some got allocated, clean them up */
> +		cxl_pci_free_irq_vectors(pdev);
> +		return;
> +	}
> +
> +	cxlds->nr_irq_vecs = nvecs;
> +}
> +
>   static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>   {
>   	struct cxl_register_map map;
> @@ -494,6 +524,8 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>   	if (rc)
>   		return rc;
>   
> +	cxl_pci_alloc_irq_vectors(cxlds);
> +
>   	cxlmd = devm_cxl_add_memdev(cxlds);
>   	if (IS_ERR(cxlmd))
>   		return PTR_ERR(cxlmd);
