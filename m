Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86B096C1B48
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 17:23:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232441AbjCTQXA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 12:23:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232322AbjCTQWe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 12:22:34 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4896931E17;
        Mon, 20 Mar 2023 09:15:29 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4PgK4q3BJkz6J7vw;
        Mon, 20 Mar 2023 23:52:43 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21; Mon, 20 Mar
 2023 15:53:06 +0000
Date:   Mon, 20 Mar 2023 15:53:06 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     <alison.schofield@intel.com>
CC:     Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v9 4/6] cxl/region: Provide region info to the
 cxl_poison trace event
Message-ID: <20230320155306.00004f5e@Huawei.com>
In-Reply-To: <f0f98437873ce86db9d97e5dee61e7399f8ddc14.1679284567.git.alison.schofield@intel.com>
References: <cover.1679284567.git.alison.schofield@intel.com>
        <f0f98437873ce86db9d97e5dee61e7399f8ddc14.1679284567.git.alison.schofield@intel.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml500006.china.huawei.com (7.191.161.198) To
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

On Sun, 19 Mar 2023 21:31:49 -0700
alison.schofield@intel.com wrote:

> From: Alison Schofield <alison.schofield@intel.com>
> 
> User space may need to know which region, if any, maps the poison
> address(es) logged in a cxl_poison trace event. Since the mapping
> of DPAs (device physical addresses) to a region can change, the
> kernel must provide this information at the time the poison list
> is read. The event informs user space that at event <timestamp>
> this <region> mapped to this <DPA>, which is poisoned.
> 
> The cxl_poison trace event is already wired up to log the region
> name and uuid if it receives param 'struct cxl_region'.
> 
> In order to provide that cxl_region, add another method for gathering
> poison - by committed endpoint decoder mappings. This method is only
> available with CONFIG_CXL_REGION and is only used if a region actually
> maps the memdev where poison is being read. After the region driver
> reads the poison list for all the mapped resources, control returns
> to the memdev driver, where poison is read for any remaining unmapped
> resources.
> 
> Mixed mode decoders are not currently supported in Linux. Add a debug
> message to the poison request path. That will serve as an alert that
> poison list retrieval needs to add support for mixed mode.
> 
> The default method remains: read the poison by memdev resource.
> 
> Signed-off-by: Alison Schofield <alison.schofield@intel.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Hi Alison,

I could be wrong but I don't think I gave a reviewed-by for this individual patch
(I made a note locally that I still needed to test v8 before doing so).
Doesn't matter in the end though..

Tested-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
+ keep the RB.

A few whitespace changes have sneaked in here though that would be good to 
clean up. (inline)

Thanks,

Jonathan

> ---
>  drivers/cxl/core/core.h   | 11 +++++++
>  drivers/cxl/core/memdev.c | 64 +++++++++++++++++++++++++++++++++++++--
>  drivers/cxl/core/region.c | 63 ++++++++++++++++++++++++++++++++++++++
>  3 files changed, 136 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
> index cde475e13216..3d1b38255ab4 100644
> --- a/drivers/cxl/core/core.h
> +++ b/drivers/cxl/core/core.h
> @@ -25,7 +25,12 @@ void cxl_decoder_kill_region(struct cxl_endpoint_decoder *cxled);
>  #define CXL_DAX_REGION_TYPE(x) (&cxl_dax_region_type)
>  int cxl_region_init(void);
>  void cxl_region_exit(void);
> +int cxl_get_poison_by_endpoint(struct device *dev, void *data);
>  #else
> +static inline int cxl_get_poison_by_endpoint(struct device *dev, void *data)
> +{
> +	return 0;
> +}
>  static inline void cxl_decoder_kill_region(struct cxl_endpoint_decoder *cxled)
>  {
>  }
> @@ -64,4 +69,10 @@ int cxl_memdev_init(void);
>  void cxl_memdev_exit(void);
>  void cxl_mbox_init(void);
>  
> +struct cxl_trigger_poison_context {
> +	struct cxl_port *port;
> +	enum cxl_decoder_mode mode;
> +	u64 offset;
> +};
> +
>  #endif /* __CXL_CORE_H__ */
> diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
> index 5ef40c36f1a3..0b8b8996e588 100644
> --- a/drivers/cxl/core/memdev.c
> +++ b/drivers/cxl/core/memdev.c
> @@ -106,6 +106,47 @@ static ssize_t numa_node_show(struct device *dev, struct device_attribute *attr,
>  }
>  static DEVICE_ATTR_RO(numa_node);
>  
> +static int cxl_get_poison_unmapped(struct cxl_memdev *cxlmd,
> +				   struct cxl_trigger_poison_context *ctx)
> +{
> +	struct cxl_dev_state *cxlds = cxlmd->cxlds;
> +	u64 offset, length;
> +	int rc = 0;
> +
> +	/*
> +	 * Collect poison for the remaining unmapped resources
> +	 * after poison is collected by committed endpoints.
> +	 *
> +	 * Knowing that PMEM must always follow RAM, get poison
> +	 * for unmapped resources based on the last decoder's mode:
> +	 *	ram: scan remains of ram range, then any pmem range
> +	 *	pmem: scan remains of pmem range
> +	 */
> +
> +	if (ctx->mode == CXL_DECODER_RAM) {
> +		offset = ctx->offset;
> +		length = resource_size(&cxlds->ram_res) - offset;
> +		rc = cxl_mem_get_poison(cxlmd, offset, length, NULL);
> +		if (rc == -EFAULT)
> +			rc = 0;
> +		if (rc)
> +			return rc;
> +	}
> +	if (ctx->mode == CXL_DECODER_PMEM) {
> +		offset = ctx->offset;
> +		length = resource_size(&cxlds->dpa_res) - offset;
> +		if (!length)
> +			return 0;
> +	} else if (resource_size(&cxlds->pmem_res)) {
> +		offset = cxlds->pmem_res.start;
> +		length = resource_size(&cxlds->pmem_res);
> +	} else {
> +		return 0;
> +	}
> +
> +	return cxl_mem_get_poison(cxlmd, offset, length, NULL);
> +}
> +
>  static int cxl_get_poison_by_memdev(struct cxl_memdev *cxlmd)
>  {
>  	struct cxl_dev_state *cxlds = cxlmd->cxlds;
> @@ -139,17 +180,36 @@ ssize_t cxl_trigger_poison_list(struct device *dev,
>  				const char *buf, size_t len)
>  {
>  	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
> +	struct cxl_trigger_poison_context ctx;
> +	struct cxl_port *port;
>  	bool trigger;
>  	int rc;
>  
>  	if (kstrtobool(buf, &trigger) || !trigger)
>  		return -EINVAL;
>  
> +	port = dev_get_drvdata(&cxlmd->dev);
> +	if (!port || !is_cxl_endpoint(port))
> +		return -EINVAL;
> +
>  	down_read(&cxl_dpa_rwsem);
> -	rc = cxl_get_poison_by_memdev(cxlmd);
> +	if (port->commit_end == -1) {
> +		/* No regions mapped to this memdev */
> +		rc = cxl_get_poison_by_memdev(cxlmd);
> +	} else {
> +		/* Regions mapped, collect poison by endpoint */
> +		ctx = (struct cxl_trigger_poison_context) {
> +			.port = port,
> +		};
> +		rc = device_for_each_child(&port->dev, &ctx,
> +					   cxl_get_poison_by_endpoint);
> +		if (rc == 1)
> +			rc = cxl_get_poison_unmapped(cxlmd, &ctx);
> +	}
> +
>  	up_read(&cxl_dpa_rwsem);
> -
I'd keep this one.
>  	return rc ? rc : len;
> +
Doesn't want to be here.

>  }
>  EXPORT_SYMBOL_NS_GPL(cxl_trigger_poison_list, CXL);
>  
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index f29028148806..4c4d3a6d631d 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -2213,6 +2213,69 @@ struct cxl_pmem_region *to_cxl_pmem_region(struct device *dev)
>  }
>  EXPORT_SYMBOL_NS_GPL(to_cxl_pmem_region, CXL);
>  
> +int cxl_get_poison_by_endpoint(struct device *dev, void *arg)
> +{
> +	struct cxl_trigger_poison_context *ctx = arg;
> +	struct cxl_endpoint_decoder *cxled;
> +	struct cxl_port *port = ctx->port;
> +	struct cxl_memdev *cxlmd;
> +	u64 offset, length;
> +	int rc = 0;
> +
> +	down_read(&cxl_region_rwsem);
> +
> +	if (!is_endpoint_decoder(dev))
> +		goto out;
> +
> +	cxled = to_cxl_endpoint_decoder(dev);
> +	if (!cxled->dpa_res || !resource_size(cxled->dpa_res))
> +		goto out;
> +
> +	/*
> +	 * Regions are only created with single mode decoders: pmem or ram.
> +	 * Linux does not currently support mixed mode decoders. This means
> +	 * that reading poison per endpoint decoder adheres to the spec
> +	 * requirement that poison reads of pmem and ram must be separated.
> +	 * CXL 3.0 Spec 8.2.9.8.4.1
> +	 *
> +	 * Watch for future support of mixed with a dev_dbg() msg.
> +	 */
> +	if (cxled->mode == CXL_DECODER_MIXED) {
> +		dev_dbg(dev, "poison list read unsupported in mixed mode\n");
> +		goto out;
> +	}
> +
> +	cxlmd = cxled_to_memdev(cxled);
> +	if (cxled->skip) {
> +		offset = cxled->dpa_res->start - cxled->skip;
> +		length = cxled->skip;
> +		rc = cxl_mem_get_poison(cxlmd, offset, length, NULL);
> +		if (rc == -EFAULT && cxled->mode == CXL_DECODER_RAM)
> +			rc = 0;
> +		if (rc)
> +			goto out;
> +	}
> +
> +	offset = cxled->dpa_res->start;
> +	length = cxled->dpa_res->end - offset + 1;
> +	rc = cxl_mem_get_poison(cxlmd, offset, length, cxled->cxld.region);
> +	if (rc == -EFAULT && cxled->mode == CXL_DECODER_RAM)
> +		rc = 0;
> +	if (rc)
> +		goto out;
> +
> +	/* Iterate until commit_end is reached */
> +	if (cxled->cxld.id == port->commit_end)
> +		rc = 1;
> +
> +	/* ctx informs the memdev driver of last read poison */
> +	ctx->mode = cxled->mode;
> +	ctx->offset = cxled->dpa_res->end + 1;
> +out:
> +	up_read(&cxl_region_rwsem);
> +	return rc;
> +}
> +
>  static struct lock_class_key cxl_pmem_region_key;
>  
>  static struct cxl_pmem_region *cxl_pmem_region_alloc(struct cxl_region *cxlr)

