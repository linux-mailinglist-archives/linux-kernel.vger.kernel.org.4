Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 881E46E12CE
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 18:50:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230147AbjDMQuv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 12:50:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbjDMQut (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 12:50:49 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8418CBF;
        Thu, 13 Apr 2023 09:50:47 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Py59t5S0vz6J79x;
        Fri, 14 Apr 2023 00:48:18 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Thu, 13 Apr
 2023 17:50:44 +0100
Date:   Thu, 13 Apr 2023 17:50:43 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Terry Bowman <terry.bowman@amd.com>
CC:     <alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
        <ira.weiny@intel.com>, <bwidawsk@kernel.org>,
        <dan.j.williams@intel.com>, <dave.jiang@intel.com>,
        <linux-cxl@vger.kernel.org>, <rrichter@amd.com>,
        <linux-kernel@vger.kernel.org>, <bhelgaas@google.com>
Subject: Re: [PATCH v3 4/6] cxl/pci: Add RCH downstream port error logging
Message-ID: <20230413175043.0000523e@Huawei.com>
In-Reply-To: <20230411180302.2678736-5-terry.bowman@amd.com>
References: <20230411180302.2678736-1-terry.bowman@amd.com>
        <20230411180302.2678736-5-terry.bowman@amd.com>
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

On Tue, 11 Apr 2023 13:03:00 -0500
Terry Bowman <terry.bowman@amd.com> wrote:

> RCH downstream port error logging is missing in the current CXL driver. The
> missing AER and RAS error logging is needed for communicating driver error
> details to userspace. Update the driver to include PCIe AER and CXL RAS
> error logging.
> 
> Add RCH downstream port error handling into the existing RCiEP handler.
> The downstream port error handler is added to the RCiEP error handler
> because the downstream port is implemented in a RCRB, is not PCI
> enumerable, and as a result is not directly accessible to the PCI AER
> root port driver. The AER root port driver calls the RCiEP handler for
> handling RCD errors and RCH downstream port protocol errors.
> 
> Update mem.c to include RAS and AER setup. This includes AER and RAS
> capability discovery and mapping for later use in the error handler.
> 
> Disable RCH downstream port's root port cmd interrupts.[1]
> 
> Update existing RCiEP correctable and uncorrectable handlers to also call
> the RCH handler. The RCH handler will read the RCH AER registers, check for
> error severity, and if an error exists will log using an existing kernel
> AER trace routine. The RCH handler will also log downstream port RAS errors
> if they exist.
> 
> [1] CXL 3.0 Spec, 12.2.1.1 - RCH Downstream Port Detected Errors
> 
> Co-developed-by: Robert Richter <rrichter@amd.com>
> Signed-off-by: Robert Richter <rrichter@amd.com>
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
Some minor stuff inline. Looks fine to me otherwise.

I do find it a little confusing how often we go into an RCD or RCH specific
function then drop out directly for 2.0+ case, but you do seem to be consistent
with existing code so fair enough.

Jonathan

> ---
>  drivers/cxl/core/pci.c  | 126 ++++++++++++++++++++++++++++++++++++----
>  drivers/cxl/core/regs.c |   1 +
>  drivers/cxl/cxl.h       |  13 +++++
>  drivers/cxl/mem.c       |  73 +++++++++++++++++++++++
>  4 files changed, 201 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
> index 523d5b9fd7fc..d435ed2ff8b6 100644
> --- a/drivers/cxl/core/pci.c
> +++ b/drivers/cxl/core/pci.c


> +/*
> + * Copy the AER capability registers to a buffer. This is necessary
> + * because RCRB AER capability is MMIO mapped. Clear the status
> + * after copying.
> + *
> + * @aer_base: base address of AER capability block in RCRB
> + * @aer_regs: destination for copying AER capability
> + */
> +static bool cxl_rch_get_aer_info(void __iomem *aer_base,
> +				 struct aer_capability_regs *aer_regs)
> +{
> +	int read_cnt = PCI_AER_CAPABILITY_LENGTH / sizeof(u32);
> +	u32 *aer_regs_buf = (u32 *)aer_regs;
> +	int n;
> +
> +	if (!aer_base)
> +		return false;
> +
> +	for (n = 0; n < read_cnt; n++)
> +		aer_regs_buf[n] = readl(aer_base + n * sizeof(u32));

Maybe add a comment here on why memcpy_fromio() doesn't work for us.
I'm assuming we need these to definitely be 32bit reads.
Otherwise someone will 'optimize' it in future.

> +
> +	writel(aer_regs->uncor_status, aer_base + PCI_ERR_UNCOR_STATUS);
> +	writel(aer_regs->cor_status, aer_base + PCI_ERR_COR_STATUS);
> +
> +	return true;
> +}
=
> diff --git a/drivers/cxl/core/regs.c b/drivers/cxl/core/regs.c
> index bde1fffab09e..dfa6fcfc428a 100644
> --- a/drivers/cxl/core/regs.c
> +++ b/drivers/cxl/core/regs.c
> @@ -198,6 +198,7 @@ void __iomem *devm_cxl_iomap_block(struct device *dev, resource_size_t addr,
>  
>  	return ret_val;
>  }
> +EXPORT_SYMBOL_NS_GPL(devm_cxl_iomap_block, CXL);
>  
>  int cxl_map_component_regs(struct device *dev, struct cxl_component_regs *regs,
>  			   struct cxl_register_map *map, unsigned long map_mask)
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index df64c402e6e6..dae3f141ffcb 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -66,6 +66,8 @@
>  #define CXL_DECODER_MIN_GRANULARITY 256
>  #define CXL_DECODER_MAX_ENCODED_IG 6
>  
> +#define PCI_AER_CAPABILITY_LENGTH 56

Odd place to find a PCI specific define. Also a spec reference is
always good for these.  What's the the length of? PCI r6.0 has
cap going up to address 0x5c  so length 0x60.  This seems to be igoring
the header log register.

> +
>  static inline int cxl_hdm_decoder_count(u32 cap_hdr)
>  {
>  	int val = FIELD_GET(CXL_HDM_DECODER_COUNT_MASK, cap_hdr);
> @@ -209,6 +211,15 @@ struct cxl_regs {
>  	struct_group_tagged(cxl_device_regs, device_regs,
>  		void __iomem *status, *mbox, *memdev;
>  	);
> +
> +	/*
> +	 * Pointer to RCH cxl_dport AER. (only for RCH/RCD mode)
> +	 * @dport_aer: CXL 2.0 12.2.11 RCH Downstream Port-detected Errors

As with other cases, I'd like full comments, so something for @aer as well.

> +	 */
> +	struct_group_tagged(cxl_rch_regs, rch_regs,
> +		void __iomem *aer;
> +		void __iomem *dport_ras;
> +	);
>  };
>  
>  struct cxl_reg_map {
> @@ -249,6 +260,8 @@ struct cxl_register_map {
>  	};
>  };
>  
> +void __iomem *devm_cxl_iomap_block(struct device *dev, resource_size_t addr,
> +				   resource_size_t length);
>  void cxl_probe_component_regs(struct device *dev, void __iomem *base,
>  			      struct cxl_component_reg_map *map);
>  void cxl_probe_device_regs(struct device *dev, void __iomem *base,
> diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
> index 014295ab6bc6..dd5ae0a4560c 100644
> --- a/drivers/cxl/mem.c
> +++ b/drivers/cxl/mem.c
> @@ -4,6 +4,7 @@
>  #include <linux/device.h>
>  #include <linux/module.h>
>  #include <linux/pci.h>
> +#include <linux/aer.h>
>  
>  #include "cxlmem.h"
>  #include "cxlpci.h"
> @@ -45,6 +46,71 @@ static int cxl_mem_dpa_show(struct seq_file *file, void *data)
>  	return 0;
>  }
>  
> +static void rch_disable_root_ints(void __iomem *aer_base)
> +{
> +	u32 aer_cmd_mask, aer_cmd;
> +
> +	/*
> +	 * Disable RCH root port command interrupts.
> +	 * CXL3.0 12.2.1.1 - RCH Downstream Port-detected Errors
> +	 */
> +	aer_cmd_mask = (PCI_ERR_ROOT_CMD_COR_EN |
> +			PCI_ERR_ROOT_CMD_NONFATAL_EN |
> +			PCI_ERR_ROOT_CMD_FATAL_EN);
> +	aer_cmd = readl(aer_base + PCI_ERR_ROOT_COMMAND);
> +	aer_cmd &= ~aer_cmd_mask;
> +	writel(aer_cmd, aer_base + PCI_ERR_ROOT_COMMAND);

Should we be touching these if firmware hasn't granted control to
the OS?  Description in the spec refers to 'software'. Is that
the kernel? No idea.  I guess this is safe even if it has already
been done. Perhaps a comment to say it should already be in this state?


> +}
> +
> +static int cxl_rch_map_ras(struct cxl_dev_state *cxlds,
> +			   struct cxl_dport *parent_dport)
> +{
> +	struct device *dev = parent_dport->dport;
> +	resource_size_t aer_phys, ras_phys;
> +	void __iomem *aer, *dport_ras;
> +
> +	if (!parent_dport->rch)
> +		return 0;
> +
> +	if (!parent_dport->aer_cap || !parent_dport->ras_cap ||
> +	    parent_dport->component_reg_phys == CXL_RESOURCE_NONE)
> +		return -ENODEV;
> +
> +	aer_phys = parent_dport->aer_cap + parent_dport->rcrb;
> +	aer = devm_cxl_iomap_block(dev, aer_phys,
> +				   PCI_AER_CAPABILITY_LENGTH);
> +
> +	if (!aer)
> +		return -ENOMEM;
> +
> +	ras_phys = parent_dport->ras_cap + parent_dport->component_reg_phys;
> +	dport_ras = devm_cxl_iomap_block(dev, ras_phys,
> +					 CXL_RAS_CAPABILITY_LENGTH);
> +
> +	if (!dport_ras)
> +		return -ENOMEM;
> +
> +	cxlds->regs.aer = aer;
> +	cxlds->regs.dport_ras = dport_ras;
> +
> +	return 0;
> +}
> +
> +static int cxl_setup_ras(struct cxl_dev_state *cxlds,
> +			 struct cxl_dport *parent_dport)
> +{
> +	int rc;
> +
> +	rc = cxl_rch_map_ras(cxlds, parent_dport);
> +	if (rc)
> +		return rc;
> +
> +	if (cxlds->rcd)
> +		rch_disable_root_ints(cxlds->regs.aer);
> +
> +	return rc;
> +}
> +
>  static void cxl_setup_rcrb(struct cxl_dev_state *cxlds,
>  			   struct cxl_dport *parent_dport)
>  {
> @@ -91,6 +157,13 @@ static int devm_cxl_add_endpoint(struct device *host, struct cxl_memdev *cxlmd,
>  
>  	cxl_setup_rcrb(cxlds, parent_dport);
>  
> +	rc = cxl_setup_ras(cxlds, parent_dport);
> +	/* Continue with RAS setup errors */
> +	if (rc)
> +		dev_warn(&cxlmd->dev, "CXL RAS setup failed: %d\n", rc);
> +	else
> +		dev_info(&cxlmd->dev, "CXL error handling enabled\n");

This feels a little noisy as something to add given we didn't shout about it for
non RCD cases (I think).  Maybe a dev_dbg()?

> +
>  	endpoint = devm_cxl_add_port(host, &cxlmd->dev, cxlds->component_reg_phys,
>  				     parent_dport);
>  	if (IS_ERR(endpoint))

