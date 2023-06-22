Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EC87739DDE
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 11:57:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231262AbjFVJ47 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 05:56:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231211AbjFVJ4f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 05:56:35 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1006272C;
        Thu, 22 Jun 2023 02:54:29 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Qmwd02cb9z6J7h0;
        Thu, 22 Jun 2023 17:51:48 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 22 Jun
 2023 10:54:27 +0100
Date:   Thu, 22 Jun 2023 10:54:26 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Terry Bowman <terry.bowman@amd.com>
CC:     <alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
        <ira.weiny@intel.com>, <bwidawsk@kernel.org>,
        <dan.j.williams@intel.com>, <dave.jiang@intel.com>,
        <linux-cxl@vger.kernel.org>, <rrichter@amd.com>,
        <linux-kernel@vger.kernel.org>, <bhelgaas@google.com>
Subject: Re: [PATCH v6 05/27] cxl: Rename member @dport of struct cxl_dport
 to @dport_dev
Message-ID: <20230622105426.0000145d@Huawei.com>
In-Reply-To: <20230622035126.4130151-6-terry.bowman@amd.com>
References: <20230622035126.4130151-1-terry.bowman@amd.com>
        <20230622035126.4130151-6-terry.bowman@amd.com>
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
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 21 Jun 2023 22:51:04 -0500
Terry Bowman <terry.bowman@amd.com> wrote:

> From: Robert Richter <rrichter@amd.com>
> 
> Reading code like dport->dport does not immediately suggest that this
> points to the corresponding device structure of the dport. Rename
> struct member @dport to @dport_dev.
> 
> While at it, also rename @new argument of add_dport() to @dport. This
> better describes the variable as a dport (e.g. new->dport becomes to
> dport->dport_dev).
> 
> Co-developed-by: Terry Bowman <terry.bowman@amd.com>
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> Signed-off-by: Robert Richter <rrichter@amd.com>
Excellent improvement in readability.  I've fallen down this trap a few times
so glad to have it closed.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
>  drivers/cxl/core/port.c   | 20 ++++++++++----------
>  drivers/cxl/core/region.c |  4 ++--
>  drivers/cxl/cxl.h         |  4 ++--
>  3 files changed, 14 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> index 76888c75dae4..7d3079f5b7b5 100644
> --- a/drivers/cxl/core/port.c
> +++ b/drivers/cxl/core/port.c
> @@ -605,7 +605,7 @@ static int devm_cxl_link_parent_dport(struct device *host,
>  	if (!parent_dport)
>  		return 0;
>  
> -	rc = sysfs_create_link(&port->dev.kobj, &parent_dport->dport->kobj,
> +	rc = sysfs_create_link(&port->dev.kobj, &parent_dport->dport_dev->kobj,
>  			       "parent_dport");
>  	if (rc)
>  		return rc;
> @@ -658,7 +658,7 @@ static struct cxl_port *cxl_port_alloc(struct device *uport,
>  		if (iter->host_bridge)
>  			port->host_bridge = iter->host_bridge;
>  		else if (parent_dport->rch)
> -			port->host_bridge = parent_dport->dport;
> +			port->host_bridge = parent_dport->dport_dev;
>  		else
>  			port->host_bridge = iter->uport;
>  		dev_dbg(uport, "host-bridge: %s\n", dev_name(port->host_bridge));
> @@ -847,22 +847,22 @@ static struct cxl_dport *find_dport(struct cxl_port *port, int id)
>  	return NULL;
>  }
>  
> -static int add_dport(struct cxl_port *port, struct cxl_dport *new)
> +static int add_dport(struct cxl_port *port, struct cxl_dport *dport)
>  {
>  	struct cxl_dport *dup;
>  	int rc;
>  
>  	device_lock_assert(&port->dev);
> -	dup = find_dport(port, new->port_id);
> +	dup = find_dport(port, dport->port_id);
>  	if (dup) {
>  		dev_err(&port->dev,
>  			"unable to add dport%d-%s non-unique port id (%s)\n",
> -			new->port_id, dev_name(new->dport),
> -			dev_name(dup->dport));
> +			dport->port_id, dev_name(dport->dport_dev),
> +			dev_name(dup->dport_dev));
>  		return -EBUSY;
>  	}
>  
> -	rc = xa_insert(&port->dports, (unsigned long)new->dport, new,
> +	rc = xa_insert(&port->dports, (unsigned long)dport->dport_dev, dport,
>  		       GFP_KERNEL);
>  	if (rc)
>  		return rc;
> @@ -895,8 +895,8 @@ static void cxl_dport_remove(void *data)
>  	struct cxl_dport *dport = data;
>  	struct cxl_port *port = dport->port;
>  
> -	xa_erase(&port->dports, (unsigned long) dport->dport);
> -	put_device(dport->dport);
> +	xa_erase(&port->dports, (unsigned long) dport->dport_dev);
> +	put_device(dport->dport_dev);
>  }
>  
>  static void cxl_dport_unlink(void *data)
> @@ -954,7 +954,7 @@ __devm_cxl_add_dport(struct cxl_port *port, struct device *dport_dev,
>  		dev_dbg(dport_dev, "Component Registers found for dport: %pa\n",
>  			&component_reg_phys);
>  
> -	dport->dport = dport_dev;
> +	dport->dport_dev = dport_dev;
>  	dport->port_id = port_id;
>  	dport->component_reg_phys = component_reg_phys;
>  	dport->port = port;
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index f822de44bee0..13cda989d944 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -1162,7 +1162,7 @@ static int cxl_port_setup_targets(struct cxl_port *port,
>  			dev_dbg(&cxlr->dev, "%s:%s: %s expected %s at %d\n",
>  				dev_name(port->uport), dev_name(&port->dev),
>  				dev_name(&cxlsd->cxld.dev),
> -				dev_name(ep->dport->dport),
> +				dev_name(ep->dport->dport_dev),
>  				cxl_rr->nr_targets_set);
>  			return -ENXIO;
>  		}
> @@ -1173,7 +1173,7 @@ static int cxl_port_setup_targets(struct cxl_port *port,
>  	cxl_rr->nr_targets_set += inc;
>  	dev_dbg(&cxlr->dev, "%s:%s target[%d] = %s for %s:%s @ %d\n",
>  		dev_name(port->uport), dev_name(&port->dev),
> -		cxl_rr->nr_targets_set - 1, dev_name(ep->dport->dport),
> +		cxl_rr->nr_targets_set - 1, dev_name(ep->dport->dport_dev),
>  		dev_name(&cxlmd->dev), dev_name(&cxled->cxld.dev), pos);
>  
>  	return 0;
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index 7c8674079f1a..7232c2a0e27c 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -589,7 +589,7 @@ struct cxl_rcrb_info {
>  
>  /**
>   * struct cxl_dport - CXL downstream port
> - * @dport: PCI bridge or firmware device representing the downstream link
> + * @dport_dev: PCI bridge or firmware device representing the downstream link
>   * @port_id: unique hardware identifier for dport in decoder target list
>   * @component_reg_phys: downstream port component registers
>   * @rcrb: Data about the Root Complex Register Block layout
> @@ -597,7 +597,7 @@ struct cxl_rcrb_info {
>   * @port: reference to cxl_port that contains this downstream port
>   */
>  struct cxl_dport {
> -	struct device *dport;
> +	struct device *dport_dev;
>  	int port_id;
>  	resource_size_t component_reg_phys;
>  	struct cxl_rcrb_info rcrb;

