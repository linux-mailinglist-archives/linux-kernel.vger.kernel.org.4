Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F0C0719ECB
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 15:50:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232165AbjFANtw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 09:49:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233226AbjFANtt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 09:49:49 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA32413D;
        Thu,  1 Jun 2023 06:49:45 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4QX6rj4B41z683fS;
        Thu,  1 Jun 2023 21:47:33 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Thu, 1 Jun
 2023 14:49:43 +0100
Date:   Thu, 1 Jun 2023 14:49:42 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Terry Bowman <terry.bowman@amd.com>
CC:     <alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
        <ira.weiny@intel.com>, <bwidawsk@kernel.org>,
        <dan.j.williams@intel.com>, <dave.jiang@intel.com>,
        <linux-cxl@vger.kernel.org>, <rrichter@amd.com>,
        <linux-kernel@vger.kernel.org>, <bhelgaas@google.com>
Subject: Re: [PATCH v4 20/23] cxl/pci: Prepare for logging RCH downstream
 port protocol errors
Message-ID: <20230601144942.000075f5@Huawei.com>
In-Reply-To: <20230523232214.55282-21-terry.bowman@amd.com>
References: <20230523232214.55282-1-terry.bowman@amd.com>
        <20230523232214.55282-21-terry.bowman@amd.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml100006.china.huawei.com (7.191.160.224) To
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

On Tue, 23 May 2023 18:22:11 -0500
Terry Bowman <terry.bowman@amd.com> wrote:

The title is very vague.  Can it be more specific to what
is in this patch?  The description makes it seem like a bunch of
unconnected things, but in reality they all chain together
to get the registers and disable the interrupt.

> The restricted CXL host (RCH) error handler will log protocol errors
> using AER and RAS status registers. The AER and RAS registers need
> to be virtually memory mapped before enabling interrupts. Update
> __devm_cxl_add_dport() to include RCH RAS and AER mapping.
> 
> Add 'struct cxl_regs' to 'struct cxl_dport' for saving a unique copy of
> the RCH downstream port's mapped registers.
> 
> The RCH contains root command AER registers that should not be
> enabled.[1] Disable these to prevent root port interrupt generation.

> 
> [1] CXL3.0 - 12.2.1.1 RCH Downstream Port-detected Errors
I just noticed this formatting of CXL3.0
It's CXL 3.0 or CXL rev 3.0 in most existing references in the tree so
good to keep to one of those instead of introducing another form

> 
> Co-developed-by: Robert Richter <rrichter@amd.com>
> Signed-off-by: Robert Richter <rrichter@amd.com>
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> ---
>  drivers/cxl/core/port.c | 64 +++++++++++++++++++++++++++++++++++++++++
>  drivers/cxl/core/regs.c |  1 +
>  drivers/cxl/cxl.h       | 11 +++++++
>  3 files changed, 76 insertions(+)
> 
> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> index d147f08780d0..80c643254b86 100644
> --- a/drivers/cxl/core/port.c
> +++ b/drivers/cxl/core/port.c
> @@ -8,6 +8,7 @@
>  #include <linux/pci.h>
>  #include <linux/slab.h>
>  #include <linux/idr.h>
> +#include <linux/aer.h>
>  #include <cxlmem.h>
>  #include <cxlpci.h>
>  #include <cxl.h>
> @@ -940,6 +941,63 @@ static void cxl_dport_unlink(void *data)
>  	sysfs_remove_link(&port->dev.kobj, link_name);
>  }
>  
> +static void cxl_disable_rch_root_ints(struct cxl_dport *dport)
> +{
> +	void __iomem *aer_base = dport->regs.dport_aer;
> +	u32 aer_cmd_mask, aer_cmd;
> +
> +	if (!dport->rch || !aer_base)
> +		return;
> +
> +	/*
> +	 * Disable RCH root port command interrupts.
> +	 * CXL3.0 12.2.1.1 - RCH Downstream Port-detected Errors

Space after CXL?

> +	 *
> +	 * This sequnce may not be necessary. CXL spec states disabling
> +	 * the root cmd register's interrupts is required. But, PCI spec
> +	 * shows these are disabled by default on reset.
> +	 */
> +	aer_cmd_mask = (PCI_ERR_ROOT_CMD_COR_EN |
> +			PCI_ERR_ROOT_CMD_NONFATAL_EN |
> +			PCI_ERR_ROOT_CMD_FATAL_EN);
> +	aer_cmd = readl(aer_base + PCI_ERR_ROOT_COMMAND);
> +	aer_cmd &= ~aer_cmd_mask;
> +	writel(aer_cmd, aer_base + PCI_ERR_ROOT_COMMAND);
> +}
> +
> +static int cxl_dport_map_rch_aer(struct cxl_dport *dport)
> +{
> +	struct cxl_rcrb_info *ri = &dport->rcrb;
> +	resource_size_t aer_phys;
> +	void __iomem *dport_aer;
> +
> +	if (!dport->rch || !ri->aer_cap)
> +		return -ENODEV;
> +
> +	aer_phys = ri->aer_cap + ri->base;
> +	dport_aer = devm_cxl_iomap_block(dport->dev, aer_phys,
> +					 sizeof(struct aer_capability_regs));
> +	if (!dport_aer)
> +		return -ENOMEM;
> +
> +	dport->regs.dport_aer = dport_aer;
> +
> +	return 0;
> +}
> +
> +static int cxl_dport_map_regs(struct cxl_dport *dport)
> +{
> +	struct cxl_register_map *map = &dport->comp_map;
> +
> +	if (!map->component_map.ras.valid)
> +		dev_dbg(map->dev, "RAS registers not found\n");
> +	else if (cxl_map_component_regs(map, &dport->regs.component,
> +					BIT(CXL_CM_CAP_CAP_ID_RAS)))
> +		dev_dbg(dport->dev, "Failed to map RAS capability.\n");
> +
> +	return cxl_dport_map_rch_aer(dport);
> +}
> +
>  static struct cxl_dport *
>  __devm_cxl_add_dport(struct cxl_port *port, struct device *dport_dev,
>  		     int port_id, resource_size_t component_reg_phys,
> @@ -994,6 +1052,12 @@ __devm_cxl_add_dport(struct cxl_port *port, struct device *dport_dev,
>  	if (rc && rc != -ENODEV)
>  		return ERR_PTR(rc);
>  
> +	rc = cxl_dport_map_regs(dport);
> +	if (rc && rc != -ENODEV)
> +		return ERR_PTR(rc);
> +
> +	cxl_disable_rch_root_ints(dport);
> +
>  	cond_cxl_root_lock(port);
>  	rc = add_dport(port, dport);
>  	cond_cxl_root_unlock(port);
> diff --git a/drivers/cxl/core/regs.c b/drivers/cxl/core/regs.c
> index 045abc11add8..b34f9e04cae4 100644
> --- a/drivers/cxl/core/regs.c
> +++ b/drivers/cxl/core/regs.c
> @@ -198,6 +198,7 @@ void __iomem *devm_cxl_iomap_block(struct device *dev, resource_size_t addr,
>  
>  	return ret_val;
>  }
> +EXPORT_SYMBOL_NS_GPL(devm_cxl_iomap_block, CXL);
>  
>  int cxl_map_component_regs(struct cxl_register_map *map,
>  			   struct cxl_component_regs *regs,
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index 6134644b51f8..0e0bcbefefaf 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -209,6 +209,13 @@ struct cxl_regs {
>  	struct_group_tagged(cxl_device_regs, device_regs,
>  		void __iomem *status, *mbox, *memdev;
>  	);
> +	/*
> +	 * RCH downstream port specific RAS register
> +	 * @aer: CXL 3.0 8.2.1.1 RCH Downstream Port RCRB
> +	 */
> +	struct_group_tagged(cxl_rch_regs, rch_regs,
> +		void __iomem *dport_aer;
> +	);
>  };
>  
>  struct cxl_reg_map {
> @@ -255,6 +262,8 @@ void cxl_probe_component_regs(struct device *dev, void __iomem *base,
>  			      struct cxl_component_reg_map *map);
>  void cxl_probe_device_regs(struct device *dev, void __iomem *base,
>  			   struct cxl_device_reg_map *map);
> +void __iomem *devm_cxl_iomap_block(struct device *dev, resource_size_t addr,
> +				   resource_size_t length);
>  int cxl_map_component_regs(struct cxl_register_map *map,
>  			   struct cxl_component_regs *regs,
>  			   unsigned long map_mask);
> @@ -603,6 +612,7 @@ struct cxl_rcrb_info {
>   * @port_id: unique hardware identifier for dport in decoder target list
>   * @rch: Indicate whether this dport was enumerated in RCH or VH mode
>   * @rcrb: Data about the Root Complex Register Block layout
> + * @regs: Dport parsed register blocks
>   */
>  struct cxl_dport {
>  	struct device *dev;
> @@ -611,6 +621,7 @@ struct cxl_dport {
>  	int port_id;
>  	bool rch;
>  	struct cxl_rcrb_info rcrb;
> +	struct cxl_regs regs;
>  };
>  
>  /**

