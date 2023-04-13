Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F08896E112A
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 17:31:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231347AbjDMPa6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 11:30:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230219AbjDMPa4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 11:30:56 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD5B410F3;
        Thu, 13 Apr 2023 08:30:54 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Py3MR1PB0z67lVH;
        Thu, 13 Apr 2023 23:26:27 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Thu, 13 Apr
 2023 16:30:51 +0100
Date:   Thu, 13 Apr 2023 16:30:50 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Terry Bowman <terry.bowman@amd.com>
CC:     <alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
        <ira.weiny@intel.com>, <bwidawsk@kernel.org>,
        <dan.j.williams@intel.com>, <dave.jiang@intel.com>,
        <linux-cxl@vger.kernel.org>, <rrichter@amd.com>,
        <linux-kernel@vger.kernel.org>, <bhelgaas@google.com>
Subject: Re: [PATCH v3 1/6] cxl/pci: Add RCH downstream port AER and RAS
 register discovery
Message-ID: <20230413163050.00006bfb@Huawei.com>
In-Reply-To: <20230411180302.2678736-2-terry.bowman@amd.com>
References: <20230411180302.2678736-1-terry.bowman@amd.com>
        <20230411180302.2678736-2-terry.bowman@amd.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml500003.china.huawei.com (7.191.162.67) To
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

On Tue, 11 Apr 2023 13:02:57 -0500
Terry Bowman <terry.bowman@amd.com> wrote:

> Restricted CXL host (RCH) downstream port AER information is not currently
> logged while in the error state. One problem preventing existing PCIe AER
> functions from logging errors is the AER registers are not accessible. The
> CXL driver requires changes to find RCH downstream port AER registers for
> purpose of error logging.
> 
> RCH downstream ports are not enumerated during a PCI bus scan and are
> instead discovered using system firmware, ACPI in this case.[1] The
> downstream port is implemented as a Root Complex Register Block (RCRB).
> The RCRB is a 4k memory block containing PCIe registers based on the PCIe
> root port.[2] The RCRB includes AER extended capability registers used for
> reporting errors. Note, the RCH's AER Capability is located in the RCRB
> memory space instead of PCI configuration space, thus its register access
> is different. Existing kernel PCIe AER functions can not be used to manage
> the downstream port AER capabilities because the port was not enumerated
> during PCI scan and the registers are not PCI config accessible.
> 
> Discover RCH downstream port AER extended capability registers. This
> requires using MMIO accesses to search for extended AER capability in
> RCRB register space.
> 
> [1] CXL 3.0 Spec, 9.11.2 - System Firmware View of CXL 1.1 Hierarchy
> [2] CXL 3.0 Spec, 8.2.1.1 - RCH Downstream Port RCRB
> 
> Co-developed-by: Robert Richter <rrichter@amd.com>
> Signed-off-by: Robert Richter <rrichter@amd.com>
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>

Hi Terry,

Sorry I missed first few versions.  Playing catch up.

A few minor comments only inline.



> ---
>  drivers/cxl/core/regs.c | 93 +++++++++++++++++++++++++++++++++++------
>  drivers/cxl/cxl.h       |  5 +++
>  drivers/cxl/mem.c       | 39 +++++++++++------
>  3 files changed, 113 insertions(+), 24 deletions(-)
> 
> diff --git a/drivers/cxl/core/regs.c b/drivers/cxl/core/regs.c
> index 1476a0299c9b..bde1fffab09e 100644
> --- a/drivers/cxl/core/regs.c
> +++ b/drivers/cxl/core/regs.c
> @@ -332,10 +332,36 @@ int cxl_find_regblock(struct pci_dev *pdev, enum cxl_regloc_type type,
>  }
>  EXPORT_SYMBOL_NS_GPL(cxl_find_regblock, CXL);
>  
> +static void __iomem *cxl_map_reg(struct device *dev, struct cxl_register_map *map,
> +				 char *name)

dev isn't used.

> +{
> +

Trivial but no point in blank line here.

> +	if (!request_mem_region(map->resource, map->max_size, name))
> +		return NULL;
> +
> +	map->base = ioremap(map->resource, map->max_size);
> +	if (!map->base) {
> +		release_mem_region(map->resource, map->max_size);
> +		return NULL;
> +	}
> +
> +	return map->base;

Why return a value you've already stashed in map->base?

> +}
> +

This is similar enough to devm_cxl_iomap_block() that I'd kind
of like them them take the same parameters.  That would mean
moving the map structure outside of the calls and instead passing
in the 3 relevant parameters.  Perhaps not worth it.

> +static void cxl_unmap_reg(struct device *dev, struct cxl_register_map *map)
> +{

dev isn't used here either. Makes little sense to pass it in to either funtion.

> +	iounmap(map->base);
> +	release_mem_region(map->resource, map->max_size);
> +}
> +
>  resource_size_t cxl_rcrb_to_component(struct device *dev,
>  				      resource_size_t rcrb,
>  				      enum cxl_rcrb which)
>  {
> +	struct cxl_register_map map = {
> +		.resource = rcrb,
> +		.max_size = SZ_4K
> +	};
>  	resource_size_t component_reg_phys;
>  	void __iomem *addr;
>  	u32 bar0, bar1;
> @@ -343,7 +369,10 @@ resource_size_t cxl_rcrb_to_component(struct device *dev,
>  	u32 id;
>  
>  	if (which == CXL_RCRB_UPSTREAM)
> -		rcrb += SZ_4K;
> +		map.resource += SZ_4K;
> +
> +	if (!cxl_map_reg(dev, &map, "CXL RCRB"))
> +		return CXL_RESOURCE_NONE;
>  
>  	/*
>  	 * RCRB's BAR[0..1] point to component block containing CXL
> @@ -351,21 +380,12 @@ resource_size_t cxl_rcrb_to_component(struct device *dev,
>  	 * the PCI Base spec here, esp. 64 bit extraction and memory
>  	 * ranges alignment (6.0, 7.5.1.2.1).
>  	 */
> -	if (!request_mem_region(rcrb, SZ_4K, "CXL RCRB"))
> -		return CXL_RESOURCE_NONE;
> -	addr = ioremap(rcrb, SZ_4K);
> -	if (!addr) {
> -		dev_err(dev, "Failed to map region %pr\n", addr);
> -		release_mem_region(rcrb, SZ_4K);
> -		return CXL_RESOURCE_NONE;
> -	}
> -
> +	addr = map.base;

I'd have preferred to see this refactor as a precursor patch to the
'real changes' that follow.

>  	id = readl(addr + PCI_VENDOR_ID);
>  	cmd = readw(addr + PCI_COMMAND);
>  	bar0 = readl(addr + PCI_BASE_ADDRESS_0);
>  	bar1 = readl(addr + PCI_BASE_ADDRESS_1);
> -	iounmap(addr);
> -	release_mem_region(rcrb, SZ_4K);
> +	cxl_unmap_reg(dev, &map);
>  
>  	/*
>  	 * Sanity check, see CXL 3.0 Figure 9-8 CXL Device that Does Not
> @@ -396,3 +416,52 @@ resource_size_t cxl_rcrb_to_component(struct device *dev,
>  	return component_reg_phys;
>  }
>  EXPORT_SYMBOL_NS_GPL(cxl_rcrb_to_component, CXL);


...

> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index 044a92d9813e..df64c402e6e6 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -270,6 +270,9 @@ enum cxl_rcrb {
>  resource_size_t cxl_rcrb_to_component(struct device *dev,
>  				      resource_size_t rcrb,
>  				      enum cxl_rcrb which);
> +u16 cxl_rcrb_to_aer(struct device *dev, resource_size_t rcrb);
> +u16 cxl_component_to_ras(struct device *dev,
> +			 resource_size_t component_reg_phys);
>  
>  #define CXL_RESOURCE_NONE ((resource_size_t) -1)
>  #define CXL_TARGET_STRLEN 20
> @@ -601,6 +604,8 @@ struct cxl_dport {
>  	int port_id;
>  	resource_size_t component_reg_phys;
>  	resource_size_t rcrb;
> +	u16 aer_cap;
> +	u16 ras_cap;

This structure has kernel-doc that needs to be updated for these new entries.

>  	bool rch;
>  	struct cxl_port *port;
>  };
> diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
> index 39c4b54f0715..014295ab6bc6 100644
> --- a/drivers/cxl/mem.c
> +++ b/drivers/cxl/mem.c
> @@ -45,13 +45,36 @@ static int cxl_mem_dpa_show(struct seq_file *file, void *data)
>  	return 0;
>  }
>  
> +static void cxl_setup_rcrb(struct cxl_dev_state *cxlds,
> +			   struct cxl_dport *parent_dport)
> +{
> +	struct cxl_memdev *cxlmd  = cxlds->cxlmd;

extra space before =

> +
> +	if (!parent_dport->rch)
> +		return;
> +
> +	/*
> +	 * The component registers for an RCD might come from the
> +	 * host-bridge RCRB if they are not already mapped via the
> +	 * typical register locator mechanism.
> +	 */
> +	if (cxlds->component_reg_phys == CXL_RESOURCE_NONE)
> +		cxlds->component_reg_phys = cxl_rcrb_to_component(
> +			&cxlmd->dev, parent_dport->rcrb, CXL_RCRB_UPSTREAM);
> +
> +	parent_dport->aer_cap = cxl_rcrb_to_aer(parent_dport->dport,
> +						parent_dport->rcrb);
> +
> +	parent_dport->ras_cap = cxl_component_to_ras(parent_dport->dport,
> +						     parent_dport->component_reg_phys);
> +}
> +
>  static int devm_cxl_add_endpoint(struct device *host, struct cxl_memdev *cxlmd,
>  				 struct cxl_dport *parent_dport)
>  {
>  	struct cxl_port *parent_port = parent_dport->port;
>  	struct cxl_dev_state *cxlds = cxlmd->cxlds;
>  	struct cxl_port *endpoint, *iter, *down;
> -	resource_size_t component_reg_phys;
>  	int rc;
>  
>  	/*
> @@ -66,17 +89,9 @@ static int devm_cxl_add_endpoint(struct device *host, struct cxl_memdev *cxlmd,
>  		ep->next = down;
>  	}
>  
> -	/*
> -	 * The component registers for an RCD might come from the
> -	 * host-bridge RCRB if they are not already mapped via the
> -	 * typical register locator mechanism.
> -	 */
> -	if (parent_dport->rch && cxlds->component_reg_phys == CXL_RESOURCE_NONE)
> -		component_reg_phys = cxl_rcrb_to_component(
> -			&cxlmd->dev, parent_dport->rcrb, CXL_RCRB_UPSTREAM);
> -	else
> -		component_reg_phys = cxlds->component_reg_phys;
> -	endpoint = devm_cxl_add_port(host, &cxlmd->dev, component_reg_phys,
> +	cxl_setup_rcrb(cxlds, parent_dport);
> +
> +	endpoint = devm_cxl_add_port(host, &cxlmd->dev, cxlds->component_reg_phys,
>  				     parent_dport);
As above, I'd prefer to see this refactor done in a precursor patch before the new
stuff is added.  I like reviewing noop patches as I don't have to think much (so
can do it when I'm supposedly in a meeting ;)

Jonathan
>  	if (IS_ERR(endpoint))
>  		return PTR_ERR(endpoint);

