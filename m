Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5ABB7199F1
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 12:38:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232547AbjFAKiT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 06:38:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232545AbjFAKiR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 06:38:17 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F5D6107;
        Thu,  1 Jun 2023 03:38:15 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4QX2fC6cTRz6J7Ts;
        Thu,  1 Jun 2023 18:38:11 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Thu, 1 Jun
 2023 11:38:12 +0100
Date:   Thu, 1 Jun 2023 11:38:11 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Terry Bowman <terry.bowman@amd.com>
CC:     <alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
        <ira.weiny@intel.com>, <bwidawsk@kernel.org>,
        <dan.j.williams@intel.com>, <dave.jiang@intel.com>,
        <linux-cxl@vger.kernel.org>, <rrichter@amd.com>,
        <linux-kernel@vger.kernel.org>, <bhelgaas@google.com>
Subject: Re: [PATCH v4 02/23] cxl/rch: Prepare for caching the MMIO mapped
 PCIe AER capability
Message-ID: <20230601113811.00006cd5@Huawei.com>
In-Reply-To: <20230523232214.55282-3-terry.bowman@amd.com>
References: <20230523232214.55282-1-terry.bowman@amd.com>
        <20230523232214.55282-3-terry.bowman@amd.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml100001.china.huawei.com (7.191.160.183) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 23 May 2023 18:21:53 -0500
Terry Bowman <terry.bowman@amd.com> wrote:

> From: Dan Williams <dan.j.williams@intel.com>
> 
> Prepare cxl_probe_rcrb() for retrieving more than just the component
> register block. The RCH AER handling code wants to get back to the AER
> capability that happens to be MMIO mapped rather then configuration
> cycles.
> 
> Move RCRB specific downstream port data, like the RCRB base and the
> AER capability offset, into its own data structure ('struct
> cxl_rcrb_info') for cxl_probe_rcrb() to fill. Extend 'struct
> cxl_dport' to include a 'struct cxl_rcrb_info' attribute.
>
There are several other refactors going on in here. I'd rather
see it broken down into a few separate patches. See inline.
 
> This centralizes all RCRB scanning in one routine.
> 
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> Co-developed-by: Robert Richter <rrichter@amd.com>
> Signed-off-by: Robert Richter <rrichter@amd.com>
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> ---
>  drivers/cxl/core/port.c       |  7 ++++---
>  drivers/cxl/core/regs.c       | 10 ++++++----
>  drivers/cxl/cxl.h             | 19 ++++++++++++-------
>  drivers/cxl/mem.c             | 16 +++++++++-------
>  tools/testing/cxl/Kbuild      |  2 +-
>  tools/testing/cxl/test/cxl.c  | 10 ++++++----
>  tools/testing/cxl/test/mock.c | 12 ++++++------
>  tools/testing/cxl/test/mock.h |  7 ++++---
>  8 files changed, 48 insertions(+), 35 deletions(-)
> 
> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> index 1a3f8729a616..618865ca6a9f 100644
> --- a/drivers/cxl/core/port.c
> +++ b/drivers/cxl/core/port.c
> @@ -939,8 +939,9 @@ __devm_cxl_add_dport(struct cxl_port *port, struct device *dport_dev,
>  		return ERR_PTR(-ENOMEM);
>  
>  	if (rcrb != CXL_RESOURCE_NONE) {
> -		component_reg_phys = cxl_rcrb_to_component(dport_dev,
> -						rcrb, CXL_RCRB_DOWNSTREAM);
> +		component_reg_phys =
> +			cxl_probe_rcrb(dport_dev, rcrb, &dport->rcrb,
> +				       CXL_RCRB_DOWNSTREAM);
>  		if (component_reg_phys == CXL_RESOURCE_NONE) {
>  			dev_warn(dport_dev, "Invalid Component Registers in RCRB");
>  			return ERR_PTR(-ENXIO);
> @@ -957,7 +958,7 @@ __devm_cxl_add_dport(struct cxl_port *port, struct device *dport_dev,
>  	dport->port_id = port_id;
>  	dport->component_reg_phys = component_reg_phys;
>  	dport->port = port;
> -	dport->rcrb = rcrb;
> +	dport->rcrb.base = rcrb;
>  
>  	cond_cxl_root_lock(port);
>  	rc = add_dport(port, dport);
> diff --git a/drivers/cxl/core/regs.c b/drivers/cxl/core/regs.c
> index 1476a0299c9b..08da4c917f99 100644
> --- a/drivers/cxl/core/regs.c
> +++ b/drivers/cxl/core/regs.c
> @@ -332,9 +332,8 @@ int cxl_find_regblock(struct pci_dev *pdev, enum cxl_regloc_type type,
>  }
>  EXPORT_SYMBOL_NS_GPL(cxl_find_regblock, CXL);
>  
> -resource_size_t cxl_rcrb_to_component(struct device *dev,
> -				      resource_size_t rcrb,
> -				      enum cxl_rcrb which)
> +resource_size_t cxl_probe_rcrb(struct device *dev, resource_size_t rcrb,
> +			       struct cxl_rcrb_info *ri, enum cxl_rcrb which)
>  {
>  	resource_size_t component_reg_phys;
>  	void __iomem *addr;
> @@ -344,6 +343,8 @@ resource_size_t cxl_rcrb_to_component(struct device *dev,
>  
>  	if (which == CXL_RCRB_UPSTREAM)
>  		rcrb += SZ_4K;
> +	else if (ri)
> +		ri->base = rcrb;

I'm struggling a bit to follow flow, but I 'think' you set this to the same
address here and at the end of __devm_cxl_add_dport()

>  
>  	/*
>  	 * RCRB's BAR[0..1] point to component block containing CXL
> @@ -364,6 +365,7 @@ resource_size_t cxl_rcrb_to_component(struct device *dev,
>  	cmd = readw(addr + PCI_COMMAND);
>  	bar0 = readl(addr + PCI_BASE_ADDRESS_0);
>  	bar1 = readl(addr + PCI_BASE_ADDRESS_1);
> +

Trivial but I love to moan about these :)
Stray change that shouldn't be in this patch...

>  	iounmap(addr);
>  	release_mem_region(rcrb, SZ_4K);
>  
> @@ -395,4 +397,4 @@ resource_size_t cxl_rcrb_to_component(struct device *dev,
>  
>  	return component_reg_phys;
>  }
> -EXPORT_SYMBOL_NS_GPL(cxl_rcrb_to_component, CXL);
> +EXPORT_SYMBOL_NS_GPL(cxl_probe_rcrb, CXL);
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index a5cd661face2..29e0bd2b8f2a 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -267,9 +267,9 @@ enum cxl_rcrb {
>  	CXL_RCRB_DOWNSTREAM,
>  	CXL_RCRB_UPSTREAM,
>  };
> -resource_size_t cxl_rcrb_to_component(struct device *dev,
> -				      resource_size_t rcrb,
> -				      enum cxl_rcrb which);
> +struct cxl_rcrb_info;
> +resource_size_t cxl_probe_rcrb(struct device *dev, resource_size_t rcrb,
> +			       struct cxl_rcrb_info *ri, enum cxl_rcrb which);
>  
>  #define CXL_RESOURCE_NONE ((resource_size_t) -1)
>  #define CXL_TARGET_STRLEN 20
> @@ -587,22 +587,27 @@ cxl_find_dport_by_dev(struct cxl_port *port, const struct device *dport_dev)
>  	return xa_load(&port->dports, (unsigned long)dport_dev);
>  }
>  
> +struct cxl_rcrb_info {
> +	resource_size_t base;
> +	u16 aer_cap;
> +};
> +
>  /**
>   * struct cxl_dport - CXL downstream port
>   * @dport: PCI bridge or firmware device representing the downstream link
> + * @port: reference to cxl_port that contains this downstream port
>   * @port_id: unique hardware identifier for dport in decoder target list
>   * @component_reg_phys: downstream port component registers
> - * @rcrb: base address for the Root Complex Register Block
>   * @rch: Indicate whether this dport was enumerated in RCH or VH mode
> - * @port: reference to cxl_port that contains this downstream port
> + * @rcrb: Data about the Root Complex Register Block layout
>   */
>  struct cxl_dport {
>  	struct device *dport;
> +	struct cxl_port *port;

Why the reorder?  It's adding noise we don't need in this patch...

>  	int port_id;
>  	resource_size_t component_reg_phys;
> -	resource_size_t rcrb;
>  	bool rch;
> -	struct cxl_port *port;
> +	struct cxl_rcrb_info rcrb;
>  };
>  
>  /**
> diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
> index 519edd0eb196..7ecdaa7f9315 100644
> --- a/drivers/cxl/mem.c
> +++ b/drivers/cxl/mem.c
> @@ -51,7 +51,6 @@ static int devm_cxl_add_endpoint(struct device *host, struct cxl_memdev *cxlmd,
>  	struct cxl_port *parent_port = parent_dport->port;
>  	struct cxl_dev_state *cxlds = cxlmd->cxlds;
>  	struct cxl_port *endpoint, *iter, *down;
> -	resource_size_t component_reg_phys;
>  	int rc;
>  
>  	/*
> @@ -71,12 +70,15 @@ static int devm_cxl_add_endpoint(struct device *host, struct cxl_memdev *cxlmd,
>  	 * host-bridge RCRB if they are not already mapped via the
>  	 * typical register locator mechanism.
>  	 */
> -	if (parent_dport->rch && cxlds->component_reg_phys == CXL_RESOURCE_NONE)
> -		component_reg_phys = cxl_rcrb_to_component(
> -			&cxlmd->dev, parent_dport->rcrb, CXL_RCRB_UPSTREAM);
> -	else
> -		component_reg_phys = cxlds->component_reg_phys;
> -	endpoint = devm_cxl_add_port(host, &cxlmd->dev, component_reg_phys,
> +	if (parent_dport->rch &&
> +	    cxlds->component_reg_phys == CXL_RESOURCE_NONE) {
> +		cxlds->component_reg_phys =
> +			cxl_probe_rcrb(&cxlmd->dev, parent_dport->rcrb.base,
> +				       NULL, CXL_RCRB_UPSTREAM);

This use of the component_reg_phys pointer in cxlds isn't closely related
to the other changes. This patch would (I think) be more readable
if that change was done in a precursor patch.

> +	}
> +
> +	endpoint = devm_cxl_add_port(host, &cxlmd->dev,
> +				     cxlds->component_reg_phys,
>  				     parent_dport);
>  	if (IS_ERR(endpoint))
>  		return PTR_ERR(endpoint);

