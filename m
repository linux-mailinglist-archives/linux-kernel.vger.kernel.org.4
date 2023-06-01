Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 001D1719CEC
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 15:06:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233332AbjFANGJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 09:06:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232848AbjFANGI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 09:06:08 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C341D97;
        Thu,  1 Jun 2023 06:06:06 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4QX5tr3TJMz67lVg;
        Thu,  1 Jun 2023 21:04:20 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Thu, 1 Jun
 2023 14:06:04 +0100
Date:   Thu, 1 Jun 2023 14:06:03 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Terry Bowman <terry.bowman@amd.com>
CC:     <alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
        <ira.weiny@intel.com>, <bwidawsk@kernel.org>,
        <dan.j.williams@intel.com>, <dave.jiang@intel.com>,
        <linux-cxl@vger.kernel.org>, <rrichter@amd.com>,
        <linux-kernel@vger.kernel.org>, <bhelgaas@google.com>
Subject: Re: [PATCH v4 10/23] cxl/port: Store the port's Component Register
 mappings in struct cxl_port
Message-ID: <20230601140603.00007ba2@Huawei.com>
In-Reply-To: <20230523232214.55282-11-terry.bowman@amd.com>
References: <20230523232214.55282-1-terry.bowman@amd.com>
        <20230523232214.55282-11-terry.bowman@amd.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml500005.china.huawei.com (7.191.163.240) To
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

On Tue, 23 May 2023 18:22:01 -0500
Terry Bowman <terry.bowman@amd.com> wrote:

> From: Robert Richter <rrichter@amd.com>
> 
> CXL capabilities are stored in the Component Registers. To use them,
> the specific I/O ranges of the capabilities must be determined by
> probing the registers. For this, the whole Component Register range
> needs to be mapped temporarily to detect the offset and length of a
> capability range.
> 
> In order to use more than one capability of a component (e.g. RAS and
> HDM) the Component Register are probed and its mappings created
> multiple times. This also causes overlapping I/O ranges as the whole
> Component Register range must be mapped again while a capability's I/O
> range is already mapped.
> 
> Different capabilities cannot be setup at the same time. E.g. the RAS
> capability must be made available as soon as the PCI driver is bound,
> the HDM decoder is setup later during port enumeration. Moreover,
> during early setup it is still unknown if a certain capability is
> needed. A central capability setup is therefore not possible,
> capabilities must be individually enabled once needed during
> initialization.
> 
> To avoid a duplicate register probe and overlapping I/O mappings, only
> probe the Component Registers one time and store the Component
> Register mapping in struct port. The stored mappings can be used later
> to iomap the capability register range when enabling the capability,
> which will be implemented in a follow-on patch.
> 
> Signed-off-by: Robert Richter <rrichter@amd.com>
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
Some minor comments...


> ---
>  drivers/cxl/core/port.c | 26 ++++++++++++++++++++++++++
>  drivers/cxl/cxl.h       |  2 ++
>  2 files changed, 28 insertions(+)
> 
> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> index eff91f141fde..34e929f1723b 100644
> --- a/drivers/cxl/core/port.c
> +++ b/drivers/cxl/core/port.c
> @@ -686,6 +686,28 @@ static struct cxl_port *cxl_port_alloc(struct device *uport,
>  	return ERR_PTR(rc);
>  }
>  
> +static int cxl_setup_comp_regs(struct device *dev, struct cxl_register_map *map,
> +			       resource_size_t component_reg_phys)
> +{
> +	if (component_reg_phys == CXL_RESOURCE_NONE)
> +		return -ENODEV;
> +
> +	memset(map, 0, sizeof(*map));
> +	map->dev = dev;
> +	map->reg_type = CXL_REGLOC_RBI_COMPONENT;
> +	map->resource = component_reg_phys;
> +	map->max_size = CXL_COMPONENT_REG_BLOCK_SIZE;
setting most elements. Maybe
	*map = (struct cxl_register_map) {
		.dev = ...
etc is cleaner and effectively the same thing.
	};
> +
> +	return cxl_setup_regs(map);
> +}
> +
> +static inline int cxl_port_setup_regs(struct cxl_port *port,
> +				      resource_size_t component_reg_phys)
> +{
> +	return cxl_setup_comp_regs(&port->dev, &port->comp_map,
> +				   component_reg_phys);
> +}
> +
>  static struct cxl_port *__devm_cxl_add_port(struct device *host,
>  					    struct device *uport,
>  					    resource_size_t component_reg_phys,
> @@ -709,6 +731,10 @@ static struct cxl_port *__devm_cxl_add_port(struct device *host,
>  	if (rc)
>  		goto err;
>  
> +	rc = cxl_port_setup_regs(port, component_reg_phys);
> +	if (rc && rc != -ENODEV)
> +		goto err;

I'd add a comment on why not being present is fine here.


> +
>  	rc = device_add(dev);
>  	if (rc)
>  		goto err;
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index e5ae5f4e6669..c76e1f84ba61 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -552,6 +552,7 @@ struct cxl_dax_region {
>   * @regions: cxl_region_ref instances, regions mapped by this port
>   * @parent_dport: dport that points to this port in the parent
>   * @decoder_ida: allocator for decoder ids
> + * @comp_map: component register capability mappings
>   * @nr_dports: number of entries in @dports
>   * @hdm_end: track last allocated HDM decoder instance for allocation ordering
>   * @commit_end: cursor to track highest committed decoder for commit ordering
> @@ -571,6 +572,7 @@ struct cxl_port {
>  	struct xarray regions;
>  	struct cxl_dport *parent_dport;
>  	struct ida decoder_ida;
> +	struct cxl_register_map comp_map;
>  	int nr_dports;
>  	int hdm_end;
>  	int commit_end;

