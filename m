Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C995719CD0
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 14:59:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232820AbjFAM7i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 08:59:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231607AbjFAM7g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 08:59:36 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 890F7E7;
        Thu,  1 Jun 2023 05:59:34 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4QX5lH6yzBz67n3K;
        Thu,  1 Jun 2023 20:57:47 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Thu, 1 Jun
 2023 13:59:31 +0100
Date:   Thu, 1 Jun 2023 13:59:31 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Terry Bowman <terry.bowman@amd.com>
CC:     <alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
        <ira.weiny@intel.com>, <bwidawsk@kernel.org>,
        <dan.j.williams@intel.com>, <dave.jiang@intel.com>,
        <linux-cxl@vger.kernel.org>, <rrichter@amd.com>,
        <linux-kernel@vger.kernel.org>, <bhelgaas@google.com>
Subject: Re: [PATCH v4 09/23] cxl/pci: Early setup RCH dport component
 registers from RCRB
Message-ID: <20230601135931.000046fa@Huawei.com>
In-Reply-To: <20230523232214.55282-10-terry.bowman@amd.com>
References: <20230523232214.55282-1-terry.bowman@amd.com>
        <20230523232214.55282-10-terry.bowman@amd.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml100002.china.huawei.com (7.191.160.241) To
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

On Tue, 23 May 2023 18:22:00 -0500
Terry Bowman <terry.bowman@amd.com> wrote:

> From: Robert Richter <rrichter@amd.com>
> 
> CXL RAS capabilities must be enabled and accessible as soon as the CXL
> endpoint is detected in the PCI hierarchy and bound to the cxl_pci
> driver. This needs to be independent of other modules such as cxl_port
> or cxl_mem.
> 
> CXL RAS capabilities reside in the Component Registers. For an RCH
> this is determined by probing RCRB which is implemented very late once
> the CXL Memory Device is created.
> 
> Change this by moving the RCRB probe to the cxl_pci driver. Do this by
> using a new introduced function cxl_pci_find_port() similar to
> cxl_mem_find_port() to determine the involved dport by the endpoint's
> PCI handle. Plug this into the existing cxl_pci_setup_regs() function
> to setup Component Registers. Probe the RCRB in case the Component
> Registers cannot be located through the CXL Register Locator
> capability.
> 
> This unifies code and early sets up the Component Registers at the
> same time for both, VH and RCH mode. Only the cxl_pci driver is
> involved for this. This allows an early mapping of the CXL RAS
> capability registers.
> 
> Signed-off-by: Robert Richter <rrichter@amd.com>
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>

One minor wording suggestion inline. I'm don't really care
that much about it though, so.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>


> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> index 945ca0304d68..54c486cd65dd 100644
> --- a/drivers/cxl/pci.c
> +++ b/drivers/cxl/pci.c
> @@ -274,13 +274,48 @@ static int cxl_pci_setup_mailbox(struct cxl_dev_state *cxlds)
>  	return 0;
>  }
>  
> +/* Extract RCRB, use same function interface as cxl_find_regblock(). */
> +static int cxl_rcrb_get_comp_regs(struct pci_dev *pdev,
> +				  enum cxl_regloc_type type,
> +				  struct cxl_register_map *map)
> +{
> +	struct cxl_dport *dport;
> +	resource_size_t component_reg_phys;
> +
> +	memset(map, 0, sizeof(*map));
> +	map->dev = &pdev->dev;
> +	map->resource = CXL_RESOURCE_NONE;
> +
> +	if (type != CXL_REGLOC_RBI_COMPONENT)
> +		return -ENODEV;
> +
> +	if (!cxl_pci_find_port(pdev, &dport) || !dport->rch)
> +		return -ENXIO;
> +
> +	component_reg_phys = cxl_probe_rcrb(&pdev->dev, dport->rcrb.base,
> +					    NULL, CXL_RCRB_UPSTREAM);
> +	if (component_reg_phys == CXL_RESOURCE_NONE)
> +		return -ENXIO;
> +
> +	map->resource = component_reg_phys;
> +	map->reg_type = type;
> +	map->max_size = CXL_COMPONENT_REG_BLOCK_SIZE;
> +
> +	return 0;
> +}
> +
>  static int cxl_pci_setup_regs(struct pci_dev *pdev, enum cxl_regloc_type type,
>  			      struct cxl_register_map *map)
>  {
>  	int rc;
>  
> +	/*
> +	 * If the Register Locator DVSEC does not contain the
> +	 * Component Registers, try to extract them from the RCRB if
> +	 * it is an RCH.

My instinct here was to wonder why having said 'if it is an RCH'
you don't seem to be checking that first.  Perhaps
change this text to something like.
* Component Registers, assume it is an RCH and try to extra them
* from an RCRB.
*/
?

> +	 */
>  	rc = cxl_find_regblock(pdev, type, map);
> -	if (rc)
> +	if (rc && cxl_rcrb_get_comp_regs(pdev, type, map))
>  		return rc;
>  
>  	return cxl_setup_regs(map);

