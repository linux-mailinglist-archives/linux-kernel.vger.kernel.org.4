Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5795973A1C0
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 15:17:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229914AbjFVNRJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 09:17:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230272AbjFVNRE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 09:17:04 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B845E26A8;
        Thu, 22 Jun 2023 06:16:46 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Qn1643fKdz6J6kK;
        Thu, 22 Jun 2023 21:13:48 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 22 Jun
 2023 14:16:27 +0100
Date:   Thu, 22 Jun 2023 14:16:27 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Terry Bowman <terry.bowman@amd.com>
CC:     <alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
        <ira.weiny@intel.com>, <bwidawsk@kernel.org>,
        <dan.j.williams@intel.com>, <dave.jiang@intel.com>,
        <linux-cxl@vger.kernel.org>, <rrichter@amd.com>,
        <linux-kernel@vger.kernel.org>, <bhelgaas@google.com>
Subject: Re: [PATCH v6 23/27] cxl/pci: Map RCH downstream AER registers for
 logging protocol errors
Message-ID: <20230622141627.00000383@Huawei.com>
In-Reply-To: <20230622035126.4130151-24-terry.bowman@amd.com>
References: <20230622035126.4130151-1-terry.bowman@amd.com>
        <20230622035126.4130151-24-terry.bowman@amd.com>
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
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 21 Jun 2023 22:51:22 -0500
Terry Bowman <terry.bowman@amd.com> wrote:

> The restricted CXL host (RCH) error handler will log protocol errors
> using AER and RAS status registers. The AER and RAS registers need
> to be virtually memory mapped before enabling interrupts. Update
> __devm_cxl_add_dport() to include RCH RAS and AER mapping.
> 
> Add 'struct cxl_regs' to 'struct cxl_dport' for saving a unique copy of
> the RCH downstream port's mapped registers.

Copy of the address at which they are mapped, not the registers.
Probably worth tweaking description to make that clearer.

> 
> Co-developed-by: Robert Richter <rrichter@amd.com>
> Signed-off-by: Robert Richter <rrichter@amd.com>
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
Otherwise LGTM
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
>  drivers/cxl/core/port.c | 33 +++++++++++++++++++++++++++++++++
>  drivers/cxl/core/regs.c |  1 +
>  drivers/cxl/cxl.h       | 11 +++++++++++
>  3 files changed, 45 insertions(+)
> 
> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> index 41e79a36c1ae..87a12e69aa8e 100644
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
> @@ -943,6 +944,36 @@ static void cxl_dport_unlink(void *data)
>  	sysfs_remove_link(&port->dev.kobj, link_name);
>  }
>  
> +static void cxl_dport_map_rch_aer(struct cxl_dport *dport)
> +{
> +	struct cxl_rcrb_info *ri = &dport->rcrb;
> +	struct cxl_port *port = dport->port;
> +	void __iomem *dport_aer = NULL;
> +	resource_size_t aer_phys;
> +
> +	if (dport->rch && ri->aer_cap) {
> +		aer_phys = ri->aer_cap + ri->base;
> +		dport_aer = devm_cxl_iomap_block(&port->dev, aer_phys,
> +				sizeof(struct aer_capability_regs));
> +	}
> +
> +	dport->regs.dport_aer = dport_aer;
> +}
> +
> +static void cxl_dport_map_regs(struct cxl_dport *dport)
> +{
> +	struct cxl_register_map *map = &dport->comp_map;
> +
> +	if (!map->component_map.ras.valid)
> +		dev_dbg(map->dev, "RAS registers not found\n");
> +	else if (cxl_map_component_regs(map, &dport->regs.component,
> +					BIT(CXL_CM_CAP_CAP_ID_RAS)))
> +		dev_dbg(dport->dport_dev, "Failed to map RAS capability.\n");
> +
> +	if (dport->rch)
> +		cxl_dport_map_rch_aer(dport);
> +}
> +
>  static struct cxl_dport *
>  __devm_cxl_add_dport(struct cxl_port *port, struct device *dport_dev,
>  		     int port_id, resource_size_t component_reg_phys,
> @@ -1002,6 +1033,8 @@ __devm_cxl_add_dport(struct cxl_port *port, struct device *dport_dev,
>  	if (rc)
>  		return ERR_PTR(rc);
>  
> +	cxl_dport_map_regs(dport);
> +
>  	cond_cxl_root_lock(port);
>  	rc = add_dport(port, dport);
>  	cond_cxl_root_unlock(port);
> diff --git a/drivers/cxl/core/regs.c b/drivers/cxl/core/regs.c
> index 60b7ba7f4030..982ef79670c7 100644
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
> index 9f46a4e1fbec..12f11cf8e280 100644
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
> @@ -598,6 +607,7 @@ struct cxl_rcrb_info {
>   * @rcrb: Data about the Root Complex Register Block layout
>   * @rch: Indicate whether this dport was enumerated in RCH or VH mode
>   * @port: reference to cxl_port that contains this downstream port
> + * @regs: Dport parsed register blocks
>   */
>  struct cxl_dport {
>  	struct device *dport_dev;
> @@ -606,6 +616,7 @@ struct cxl_dport {
>  	struct cxl_rcrb_info rcrb;
>  	bool rch;
>  	struct cxl_port *port;
> +	struct cxl_regs regs;
>  };
>  
>  /**

