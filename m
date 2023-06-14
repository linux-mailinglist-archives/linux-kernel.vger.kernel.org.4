Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1303719A1C
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 12:49:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233067AbjFAKti (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 06:49:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233034AbjFAKtf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 06:49:35 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AEC8107;
        Thu,  1 Jun 2023 03:49:33 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4QX2sH0VVxz67ydC;
        Thu,  1 Jun 2023 18:47:47 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Thu, 1 Jun
 2023 11:49:30 +0100
Date:   Thu, 1 Jun 2023 11:49:30 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Terry Bowman <terry.bowman@amd.com>
CC:     <alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
        <ira.weiny@intel.com>, <bwidawsk@kernel.org>,
        <dan.j.williams@intel.com>, <dave.jiang@intel.com>,
        <linux-cxl@vger.kernel.org>, <rrichter@amd.com>,
        <linux-kernel@vger.kernel.org>, <bhelgaas@google.com>
Subject: Re: [PATCH v4 04/23] cxl/core/regs: Add @dev to cxl_register_map
Message-ID: <20230601114930.000065ad@Huawei.com>
In-Reply-To: <20230523232214.55282-5-terry.bowman@amd.com>
References: <20230523232214.55282-1-terry.bowman@amd.com>
        <20230523232214.55282-5-terry.bowman@amd.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml500002.china.huawei.com (7.191.160.78) To
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

On Tue, 23 May 2023 18:21:55 -0500
Terry Bowman <terry.bowman@amd.com> wrote:

> From: Robert Richter <rrichter@amd.com>
> 
> The corresponding device of a register mapping is used for devm
> operations and logging. For operations with struct cxl_register_map
> the device needs to be kept track separately. To simpify the involved
> function interfaces, add @dev to cxl_register_map.
> 
> While at it also reorder function arguments of cxl_map_device_regs()
> and cxl_map_component_regs() to have the object @cxl_register_map
> first.
> 
> In a result a bunch of functions are available to be used with a
> @cxl_register_map object.
> 
> This patch is in preparation of reworking the component register setup
> code.
> 
> Signed-off-by: Robert Richter <rrichter@amd.com>
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> ---
>  drivers/cxl/core/hdm.c  |  4 ++--
>  drivers/cxl/core/regs.c | 22 ++++++++++++---------
>  drivers/cxl/cxl.h       | 10 ++++++----
>  drivers/cxl/pci.c       | 42 ++++++++++++++++++++---------------------
>  4 files changed, 41 insertions(+), 37 deletions(-)
> 
> diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
> index 7889ff203a34..5abfa9276dac 100644
> --- a/drivers/cxl/core/hdm.c
> +++ b/drivers/cxl/core/hdm.c
> @@ -85,6 +85,7 @@ static int map_hdm_decoder_regs(struct cxl_port *port, void __iomem *crb,
>  				struct cxl_component_regs *regs)
>  {
>  	struct cxl_register_map map = {
> +		.dev = &port->dev,
>  		.resource = port->component_reg_phys,
>  		.base = crb,
>  		.max_size = CXL_COMPONENT_REG_BLOCK_SIZE,
> @@ -97,8 +98,7 @@ static int map_hdm_decoder_regs(struct cxl_port *port, void __iomem *crb,
>  		return -ENODEV;
>  	}
>  
> -	return cxl_map_component_regs(&port->dev, regs, &map,
> -				      BIT(CXL_CM_CAP_CAP_ID_HDM));
> +	return cxl_map_component_regs(&map, regs, BIT(CXL_CM_CAP_CAP_ID_HDM));
>  }
>  
>  static bool should_emulate_decoders(struct cxl_endpoint_dvsec_info *info)
> diff --git a/drivers/cxl/core/regs.c b/drivers/cxl/core/regs.c
> index 08da4c917f99..9888bdf43e55 100644
> --- a/drivers/cxl/core/regs.c
> +++ b/drivers/cxl/core/regs.c
> @@ -199,8 +199,9 @@ void __iomem *devm_cxl_iomap_block(struct device *dev, resource_size_t addr,
>  	return ret_val;
>  }
>  
> -int cxl_map_component_regs(struct device *dev, struct cxl_component_regs *regs,
> -			   struct cxl_register_map *map, unsigned long map_mask)
> +int cxl_map_component_regs(struct cxl_register_map *map,
> +			   struct cxl_component_regs *regs,
> +			   unsigned long map_mask)
>  {
>  	struct mapinfo {
>  		struct cxl_reg_map *rmap;
> @@ -213,16 +214,16 @@ int cxl_map_component_regs(struct device *dev, struct cxl_component_regs *regs,
>  
>  	for (i = 0; i < ARRAY_SIZE(mapinfo); i++) {
>  		struct mapinfo *mi = &mapinfo[i];
> -		resource_size_t phys_addr;
> +		resource_size_t addr;

This rename not mentioned in the patch description. I guess it's
stepping towards consistency between the different paths, but
in this patch it looks like noise...

>  		resource_size_t length;
>  
>  		if (!mi->rmap->valid)
>  			continue;
>  		if (!test_bit(mi->rmap->id, &map_mask))
>  			continue;
> -		phys_addr = map->resource + mi->rmap->offset;
> +		addr = map->resource + mi->rmap->offset;
>  		length = mi->rmap->size;
> -		*(mi->addr) = devm_cxl_iomap_block(dev, phys_addr, length);
> +		*(mi->addr) = devm_cxl_iomap_block(map->dev, addr, length);
>  		if (!*(mi->addr))
>  			return -ENOMEM;
>  	}
> @@ -231,9 +232,8 @@ int cxl_map_component_regs(struct device *dev, struct cxl_component_regs *regs,
>  }
>  EXPORT_SYMBOL_NS_GPL(cxl_map_component_regs, CXL);
>  
> -int cxl_map_device_regs(struct device *dev,
> -			struct cxl_device_regs *regs,
> -			struct cxl_register_map *map)
> +int cxl_map_device_regs(struct cxl_register_map *map,
> +			struct cxl_device_regs *regs)
>  {
>  	resource_size_t phys_addr = map->resource;
>  	struct mapinfo {
> @@ -256,7 +256,7 @@ int cxl_map_device_regs(struct device *dev,
>  
>  		addr = phys_addr + mi->rmap->offset;
>  		length = mi->rmap->size;
> -		*(mi->addr) = devm_cxl_iomap_block(dev, addr, length);
> +		*(mi->addr) = devm_cxl_iomap_block(map->dev, addr, length);
>  		if (!*(mi->addr))
>  			return -ENOMEM;
>  	}
> @@ -302,7 +302,10 @@ int cxl_find_regblock(struct pci_dev *pdev, enum cxl_regloc_type type,
>  	u32 regloc_size, regblocks;
>  	int regloc, i;
>  
> +	memset(map, 0, sizeof(*map));
> +	map->dev = &pdev->dev;
>  	map->resource = CXL_RESOURCE_NONE;
> +

No comment :)

>  	regloc = pci_find_dvsec_capability(pdev, PCI_DVSEC_VENDOR_ID_CXL,
>  					   CXL_DVSEC_REG_LOCATOR);
>  	if (!regloc)
> @@ -328,6 +331,7 @@ int cxl_find_regblock(struct pci_dev *pdev, enum cxl_regloc_type type,
>  	}
>  
>  	map->resource = CXL_RESOURCE_NONE;
> +
Not here either.

White space changes go in a patch on their own - not mixed in!

>  	return -ENODEV;
>  }
>  EXPORT_SYMBOL_NS_GPL(cxl_find_regblock, CXL);
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index a8bda2c74a85..095b767c21e9 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -231,6 +231,7 @@ struct cxl_device_reg_map {
>  
>  /**
>   * struct cxl_register_map - DVSEC harvested register block mapping parameters
> + * @dev: device for devm operations and logging
>   * @base: virtual base of the register-block-BAR + @block_offset
>   * @resource: physical resource base of the register block
>   * @max_size: maximum mapping size to perform register search
> @@ -239,6 +240,7 @@ struct cxl_device_reg_map {
>   * @device_map: cxl_reg_maps for device registers
>   */
>  struct cxl_register_map {
> +	struct device *dev;
>  	void __iomem *base;
>  	resource_size_t resource;
>  	resource_size_t max_size;
> @@ -253,11 +255,11 @@ void cxl_probe_component_regs(struct device *dev, void __iomem *base,
>  			      struct cxl_component_reg_map *map);
>  void cxl_probe_device_regs(struct device *dev, void __iomem *base,
>  			   struct cxl_device_reg_map *map);
> -int cxl_map_component_regs(struct device *dev, struct cxl_component_regs *regs,
> -			   struct cxl_register_map *map,
> +int cxl_map_component_regs(struct cxl_register_map *map,
> +			   struct cxl_component_regs *regs,
>  			   unsigned long map_mask);
> -int cxl_map_device_regs(struct device *dev, struct cxl_device_regs *regs,
> -			struct cxl_register_map *map);
> +int cxl_map_device_regs(struct cxl_register_map *map,
> +			struct cxl_device_regs *regs);
>  
>  enum cxl_regloc_type;
>  int cxl_find_regblock(struct pci_dev *pdev, enum cxl_regloc_type type,
> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> index 0872f2233ed0..2a9f65be148b 100644
> --- a/drivers/cxl/pci.c
> +++ b/drivers/cxl/pci.c
> @@ -274,61 +274,59 @@ static int cxl_pci_setup_mailbox(struct cxl_dev_state *cxlds)
>  	return 0;
>  }
>  
> -static int cxl_map_regblock(struct pci_dev *pdev, struct cxl_register_map *map)
> +static int cxl_map_regblock(struct cxl_register_map *map)
>  {
> -	struct device *dev = &pdev->dev;
It think equivalent is still a nice to have + smaller diff which is nice.

	struct device *dev = &map->dev;

> -
>  	map->base = ioremap(map->resource, map->max_size);
>  	if (!map->base) {
> -		dev_err(dev, "failed to map registers\n");
> +		dev_err(map->dev, "failed to map registers\n");
>  		return -ENOMEM;
>  	}
>  
> -	dev_dbg(dev, "Mapped CXL Memory Device resource %pa\n", &map->resource);
> +	dev_dbg(map->dev, "Mapped CXL Memory Device resource %pa\n",
> +		&map->resource);
> +
>  	return 0;
>  }
>  
> -static void cxl_unmap_regblock(struct pci_dev *pdev,
> -			       struct cxl_register_map *map)
> +static void cxl_unmap_regblock(struct cxl_register_map *map)
>  {
>  	iounmap(map->base);
>  	map->base = NULL;
>  }
>  
> -static int cxl_probe_regs(struct pci_dev *pdev, struct cxl_register_map *map)
> +static int cxl_probe_regs(struct cxl_register_map *map)
>  {
>  	struct cxl_component_reg_map *comp_map;
>  	struct cxl_device_reg_map *dev_map;
> -	struct device *dev = &pdev->dev;

Same comment.  Keep the local variable and this patch gets
smaller.  I guess there might be a reason for this later in the
set though.  If there is shout about it in the patch introduction.

>  	void __iomem *base = map->base;
>  
>  	switch (map->reg_type) {
>  	case CXL_REGLOC_RBI_COMPONENT:
>  		comp_map = &map->component_map;
> -		cxl_probe_component_regs(dev, base, comp_map);
> +		cxl_probe_component_regs(map->dev, base, comp_map);
>  		if (!comp_map->hdm_decoder.valid) {
> -			dev_err(dev, "HDM decoder registers not found\n");
> +			dev_err(map->dev, "HDM decoder registers not found\n");
>  			return -ENXIO;
>  		}
>  
>  		if (!comp_map->ras.valid)
> -			dev_dbg(dev, "RAS registers not found\n");
> +			dev_dbg(map->dev, "RAS registers not found\n");
>  
> -		dev_dbg(dev, "Set up component registers\n");
> +		dev_dbg(map->dev, "Set up component registers\n");
>  		break;
>  	case CXL_REGLOC_RBI_MEMDEV:
>  		dev_map = &map->device_map;
> -		cxl_probe_device_regs(dev, base, dev_map);
> +		cxl_probe_device_regs(map->dev, base, dev_map);
>  		if (!dev_map->status.valid || !dev_map->mbox.valid ||
>  		    !dev_map->memdev.valid) {
> -			dev_err(dev, "registers not found: %s%s%s\n",
> +			dev_err(map->dev, "registers not found: %s%s%s\n",
>  				!dev_map->status.valid ? "status " : "",
>  				!dev_map->mbox.valid ? "mbox " : "",
>  				!dev_map->memdev.valid ? "memdev " : "");
>  			return -ENXIO;
>  		}
>  
> -		dev_dbg(dev, "Probing device registers...\n");
> +		dev_dbg(map->dev, "Probing device registers...\n");
>  		break;
>  	default:
>  		break;
> @@ -346,12 +344,12 @@ static int cxl_setup_regs(struct pci_dev *pdev, enum cxl_regloc_type type,
>  	if (rc)
>  		return rc;
>  
> -	rc = cxl_map_regblock(pdev, map);
> +	rc = cxl_map_regblock(map);
>  	if (rc)
>  		return rc;
>  
> -	rc = cxl_probe_regs(pdev, map);
> -	cxl_unmap_regblock(pdev, map);
> +	rc = cxl_probe_regs(map);
> +	cxl_unmap_regblock(map);
>  
>  	return rc;
>  }
> @@ -688,7 +686,7 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  	if (rc)
>  		return rc;
>  
> -	rc = cxl_map_device_regs(&pdev->dev, &cxlds->regs.device_regs, &map);
> +	rc = cxl_map_device_regs(&map, &cxlds->regs.device_regs);
>  	if (rc)
>  		return rc;
>  
> @@ -703,8 +701,8 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  
>  	cxlds->component_reg_phys = map.resource;
>  
> -	rc = cxl_map_component_regs(&pdev->dev, &cxlds->regs.component,
> -				    &map, BIT(CXL_CM_CAP_CAP_ID_RAS));
> +	rc = cxl_map_component_regs(&map, &cxlds->regs.component,
> +				    BIT(CXL_CM_CAP_CAP_ID_RAS));
>  	if (rc)
>  		dev_dbg(&pdev->dev, "Failed to map RAS capability.\n");
>  

