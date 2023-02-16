Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13190698A4A
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 03:04:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229646AbjBPCEg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 21:04:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229583AbjBPCEe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 21:04:34 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4A9F22026;
        Wed, 15 Feb 2023 18:04:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676513071; x=1708049071;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=hb7vpaFy1+xNq//qwF1yWdxFMR3v3oby6ZiTClQzpLU=;
  b=YUc/YMTvlPRP2Cozpbw6qxFRv5Qtl6mBsq+TOEOGsefYqoo74pTi4KY9
   lvwZY1JjB6SJzQVeN7/J7ZGGktOcDUViYh2BHbytNnXzS5Byi4CWb6iwQ
   Zug9UKnmr4rzefVnHWasa5intg02qguYOMl1TaZHDFL1qIjUHXW16M6oH
   SWLff1qHtuOQMOqHuOJrqNFk5zlLX285D2CfH+OrDBjt1IoVBd1oc0cQX
   rwNzCZxrMvl1tdERegFu5bwyd59v53CuoQsmb8e7yxRdUFeiLNcuFsbY7
   CH30wnSdapITaHXOqA33mH+z8tJWSkMOHgtwjRDV2t39ycu6Fgy1qG2Zx
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10622"; a="329322594"
X-IronPort-AV: E=Sophos;i="5.97,301,1669104000"; 
   d="scan'208";a="329322594"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2023 18:04:31 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10622"; a="758750806"
X-IronPort-AV: E=Sophos;i="5.97,301,1669104000"; 
   d="scan'208";a="758750806"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO aschofie-mobl2) ([10.209.33.161])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2023 18:04:30 -0800
Date:   Wed, 15 Feb 2023 18:04:28 -0800
From:   Alison Schofield <alison.schofield@intel.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 4/6] cxl/region: Provide region info to the cxl_poison
 trace event
Message-ID: <Y+2PLGynCGRDLmVl@aschofie-mobl2>
References: <cover.1675983077.git.alison.schofield@intel.com>
 <7862ef793a3b4fce49b0c8074b014b53b389ce12.1675983077.git.alison.schofield@intel.com>
 <20230210125641.00004744@Huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230210125641.00004744@Huawei.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 10, 2023 at 12:56:41PM +0000, Jonathan Cameron wrote:
> On Thu,  9 Feb 2023 15:32:57 -0800
> alison.schofield@intel.com wrote:
> 
> > From: Alison Schofield <alison.schofield@intel.com>
> > 
> > User space may need to know which region, if any, maps the poison
> > address(es) logged in a cxl_poison trace event. Since the mapping
> > of DPAs (device physical addresses) to a region can change, the
> > kernel must provide this information at the time the poison list
> > is read. The event informs user space that at event <timestamp>
> > this <region> mapped to this <DPA>, which is poisoned.
> > 
> > The cxl_poison trace event is already wired up to log the region
> > name and uuid if it receives param 'struct cxl_region'.
> > 
> > In order to provide that cxl_region, add another method for gathering
> > poison - by committed endpoint decoder mappings. This method is only
> > available with CONFIG_CXL_REGION and is only used if a region actually
> > maps the memdev where poison is being read. The default method remains:
> > read the poison by memdev resource.
> 
> Mention here that you also cover memory that isn't mapped.
Ok, will do. And will also mention that we don't cover
CXL_DECODER_MIXED, as I'm noting below...

> 
> A few minor comments inline.
> 
> Thanks,
> 
> Jonathan
> 
> 
> > 
> > Signed-off-by: Alison Schofield <alison.schofield@intel.com>
> > ---
> >  drivers/cxl/core/core.h   |  5 +++
> >  drivers/cxl/core/memdev.c | 14 ++++++-
> >  drivers/cxl/core/region.c | 82 +++++++++++++++++++++++++++++++++++++++
> >  3 files changed, 100 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
> > index 8c04672dca56..2f9bd8651eb1 100644
> > --- a/drivers/cxl/core/core.h
> > +++ b/drivers/cxl/core/core.h
> > @@ -22,7 +22,12 @@ void cxl_decoder_kill_region(struct cxl_endpoint_decoder *cxled);
> >  #define CXL_PMEM_REGION_TYPE(x) (&cxl_pmem_region_type)
> >  int cxl_region_init(void);
> >  void cxl_region_exit(void);
> > +int cxl_get_poison_by_endpoint(struct device *dev, void *data);
> >  #else
> > +static inline int cxl_get_poison_by_endpoint(struct device *dev, void *data)
> > +{
> > +	return 0;
> > +}
> >  static inline void cxl_decoder_kill_region(struct cxl_endpoint_decoder *cxled)
> >  {
> >  }
> > diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
> > index 19b833c9cf35..8696d7b508b6 100644
> > --- a/drivers/cxl/core/memdev.c
> > +++ b/drivers/cxl/core/memdev.c
> > @@ -139,14 +139,26 @@ static ssize_t trigger_poison_list_store(struct device *dev,
> >  					 const char *buf, size_t len)
> >  {
> >  	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
> > +	struct cxl_port *port;
> >  	bool trigger;
> >  	int rc;
> >  
> >  	if (kstrtobool(buf, &trigger) || !trigger)
> >  		return -EINVAL;
> >  
> > +	port = dev_get_drvdata(&cxlmd->dev);
> > +	if (!port || !is_cxl_endpoint(port))
> > +		return -EINVAL;
> > +
> >  	down_read(&cxl_dpa_rwsem);
> > -	rc = cxl_get_poison_by_memdev(cxlmd);
> > +	if (port->commit_end == -1)
> > +		/* No regions mapped to this memdev */
> > +		rc = cxl_get_poison_by_memdev(cxlmd);
> > +	else
> > +		/* Regions mapped, collect poison by endpoint */
> > +		rc = device_for_each_child(&port->dev, port,
> > +					   cxl_get_poison_by_endpoint);
> > +
> >  	up_read(&cxl_dpa_rwsem);
> >  
> >  	return rc ? rc : len;
> > diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> > index 67e83d961670..0ac08e9106af 100644
> > --- a/drivers/cxl/core/region.c
> > +++ b/drivers/cxl/core/region.c
> > @@ -1826,6 +1826,88 @@ struct cxl_pmem_region *to_cxl_pmem_region(struct device *dev)
> >  }
> >  EXPORT_SYMBOL_NS_GPL(to_cxl_pmem_region, CXL);
> >  
> > +int cxl_get_poison_by_endpoint(struct device *dev, void *data)
> > +{
> > +	struct cxl_endpoint_decoder *cxled;
> > +	struct cxl_port *port = data;
> > +	struct cxl_dev_state *cxlds;
> > +	struct cxl_memdev *cxlmd;
> > +	u64 offset, length;
> > +	int rc = 0;
> > +
> > +	down_read(&cxl_dpa_rwsem);
> > +
> > +	if (!is_endpoint_decoder(dev))
> > +		goto out;
> > +
> > +	cxled = to_cxl_endpoint_decoder(dev);
> > +	if (!cxled->dpa_res || !resource_size(cxled->dpa_res))
> > +		goto out;
> > +
> > +	/*
> > +	 * Get the poison by decoder for mapped resources. This
> > +	 * separates pmem and ram poison list reads, as the spec
> > +	 * requires, and provides the region for the trace event.
> > +	 */
> 
> Does the spec actually require separate decoders for PMEM and MEM?
> Sure, Linux only sets it up like that, but a BIOS might have set
> them up as a single decoder I think - even if we don't handle
> that form of crazy yet. If the spec requires it, then a reference
> would be great.
> 

No, the spec allows mixed mode decoders. I chatted w Dan about this,
and we're suggesting skipping poison reads when mode == CXL_DECODER_MIXED.
That skip would be quiet, just a dev_debug(). But, add some more noise
to the front end by changing adding this dev_warn() :

diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
index dcc16d7cb8f3..349a16b7c97a 100644
--- a/drivers/cxl/core/hdm.c
+++ b/drivers/cxl/core/hdm.c
@@ -268,8 +268,8 @@ static int __cxl_dpa_reserve(struct cxl_endpoint_decoder *cxled,
        else if (resource_contains(&cxlds->ram_res, res))
                cxled->mode = CXL_DECODER_RAM;
        else {
-               dev_dbg(dev, "decoder%d.%d: %pr mixed\n", port->id,
-                       cxled->cxld.id, cxled->dpa_res);
+               dev_warn(dev, "decoder%d.%d: %pr mixed mode not supported\n",
+                        port->id, cxled->cxld.id, cxled->dpa_res);
                cxled->mode = CXL_DECODER_MIXED;
        }

> > +	cxlmd = cxled_to_memdev(cxled);
> > +	length = cxled->dpa_res->end - cxled->dpa_res->start + 1;
> > +	rc = cxl_mem_get_poison(cxlmd, cxled->dpa_res->start, length,
> > +				cxled->cxld.region);
> > +	if (rc == -EFAULT && cxled->mode == CXL_DECODER_RAM)
> > +		rc = 0;
> > +	if (rc)
> > +		goto out;
> > +
> > +	/* Get poison in a skip range */
> 
> Seems odd to do it in this order. I'd do the skip first as then
> the records will appear in address order (subject to whatever
> random order the device is tracking them and the resulting ordering
> in each request)
> 
Yes - skip should be logically first, since those addresses would be
before any mapped addresses. Thanks for pointing it out.

> > +	if (cxled->skip) {
> > +		rc = cxl_mem_get_poison(cxlmd, 0, cxled->skip, NULL);
> > +		if (rc == -EFAULT && cxled->mode == CXL_DECODER_RAM)
> > +			rc = 0;
> > +		if (rc)
> > +			goto out;
> > +	}
> > +
> > +	/* Iterate until commit_end is reached */
> > +	if (cxled->cxld.id < port->commit_end)
> > +		goto out;
> > +
> > +	/*
> > +	 * Reach here with the last committed decoder only.
> > +	 * Knowing that PMEM must always follow RAM, get poison
> > +	 * for unmapped ranges based on the last decoder's mode:
> > +	 *	ram: scan remains of ram range, then scan for pmem
> > +	 *	pmem: scan remains of pmem range
> > +	 */
> > +	cxlds = cxlmd->cxlds;
> > +
> > +	if (cxled->mode == CXL_DECODER_RAM) {
> > +		offset = cxled->dpa_res->end + 1;
> > +		length = resource_size(&cxlds->ram_res) - offset;
> > +		rc = cxl_mem_get_poison(cxlmd, offset, length, NULL);
> > +		if (rc == -EFAULT)
> > +			rc = 0;
> > +		if (rc)
> > +			goto out;
> > +	}
> > +	if (cxled->mode == CXL_DECODER_PMEM) {
> > +		offset = cxled->dpa_res->end + 1;
> > +		length = resource_size(&cxlds->pmem_res) - offset;
> > +	} else if (resource_size(&cxlds->pmem_res)) {
> > +		offset = cxlds->pmem_res.start;
> > +		length = resource_size(&cxlds->pmem_res);
> > +	} else {
> > +		rc = 1;
> > +		goto out;
> > +	}
> > +	/* Final get poison call. Return rc or 1 to stop iteration. */
> > +	rc = cxl_mem_get_poison(cxlmd, offset, length, NULL);
> > +	if (!rc)
> > +		rc = 1;
> > +out:
> > +	up_read(&cxl_dpa_rwsem);
> > +	return rc;
> > +}
> > +
> >  static struct lock_class_key cxl_pmem_region_key;
> >  
> >  static struct cxl_pmem_region *cxl_pmem_region_alloc(struct cxl_region *cxlr)
> 
