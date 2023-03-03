Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D6C66A9DC5
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 18:35:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230349AbjCCRfS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 12:35:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229974AbjCCRfQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 12:35:16 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA51015C84;
        Fri,  3 Mar 2023 09:35:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677864914; x=1709400914;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=8ao04V1VfOFZM4Kz7NYrrxVrK41QA5tkemgEEvrB1iE=;
  b=BvQ5zkMY3WxKljT7vakBuBQeD7ChzsErnSEJ1NNG4BGJucPvqaQnn4+m
   25brrn5rBn40klgnB8lWTdVH/OVcTahqiRJ14Bl8n3pRuFYon8guAhJGw
   zhpJ+bmGoGKzxWrdfv+fO716RmrKOLK3BAo6+KFQPsvoyf4f+gYRLSioU
   yOCwdaLa0ZNt+vHYaidE7ARCd1rLdHZ1fiJEJ/hAC01LxDXJjPbn1oWaY
   lytq2oyInMTiNSyGLP3L58JUWfBs0yzlHjwewVGlwGEB4Fipfd6GpFOpB
   HwlAFYw1dZUXiE4oOPL/yGWoTVOvecW9cRIBuffEUQEzFZK9UHfer0/PC
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10638"; a="399914043"
X-IronPort-AV: E=Sophos;i="5.98,231,1673942400"; 
   d="scan'208";a="399914043"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2023 09:35:12 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10638"; a="785332990"
X-IronPort-AV: E=Sophos;i="5.98,231,1673942400"; 
   d="scan'208";a="785332990"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO aschofie-mobl2) ([10.212.155.56])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2023 09:35:08 -0800
Date:   Fri, 3 Mar 2023 09:35:06 -0800
From:   Alison Schofield <alison.schofield@intel.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 4/6] cxl/region: Provide region info to the cxl_poison
 trace event
Message-ID: <ZAIvytPqEyfLsb+a@aschofie-mobl2>
References: <cover.1676685180.git.alison.schofield@intel.com>
 <62d24b380514c8c39b651aca79c81a424f0b5b37.1676685180.git.alison.schofield@intel.com>
 <20230303164658.00006b4f@Huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230303164658.00006b4f@Huawei.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 03, 2023 at 04:46:58PM +0000, Jonathan Cameron wrote:
> On Fri, 17 Feb 2023 18:18:52 -0800
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
> > maps the memdev where poison is being read. After the poison list is
> > read for all the mapped resources, poison is read for the unmapped
> > resources, and those events are logged without the region info.
> > 
> > Mixed mode decoders are not currently supported in Linux. Add a debug
> > message to the poison request path. That will serve as an alert that
> > poison list retrieval needs to add support for mixed mode.
> > 
> > The default method remains: read the poison by memdev resource.
> > 
> > Signed-off-by: Alison Schofield <alison.schofield@intel.com>
> Hi Alison,
> 
> I decided to give this a test run on to of a single emulated direct
> attached EP with both persistent and volatile memory, but only
> part of each added to a region (so we get a skip).

This looks like issues with 'unsupported' mixed mode decoders.
How are you getting past the mixed mode decoder check?

Is there a logic error here:

A device paritioned into ram and pmem, may have:
zero or more ram decodes
  followed by zero or one skip
    followed by zero or more pmem decodes
      followed by maybe unused space

So EPs may look like these: 
ram-01, ram-02, skip-pmem-03, pmem-04
skip-pmem-01, pmem-02

But never these: (no multiple skips and only skip over ram)
ram-01, skip-ram-02, skip-pmem-03
skip-pmem-01, skip-pmem-02, 

I'm still looking at the snippets below.

Thanks,
Jonathan

> 
> Without regions it all works as expected. With them not so much - see inline
> 
> region uuid is also a bit pointless for volatile regions as I think
> current code makes it all 0s.
> 
> Jonathan
> 
> 
> > ---
> >  drivers/cxl/core/core.h   |  5 +++
> >  drivers/cxl/core/memdev.c | 14 +++++-
> >  drivers/cxl/core/region.c | 89 +++++++++++++++++++++++++++++++++++++++
> >  3 files changed, 107 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
> > index cde475e13216..4f507cb85926 100644
> > --- a/drivers/cxl/core/core.h
> > +++ b/drivers/cxl/core/core.h
> > @@ -25,7 +25,12 @@ void cxl_decoder_kill_region(struct cxl_endpoint_decoder *cxled);
> >  #define CXL_DAX_REGION_TYPE(x) (&cxl_dax_region_type)
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
> > index ea996057815e..c11b7bc253b4 100644
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
> 
> So this had me confused for a while.  If I setup a couple of regions
> on a mixed device with a skip between (may happen anyway)
> then this returns 1 which is not what we are aiming for.
> 
> Chasing it through we are reaching the last part of
> cxl_get_poison_by_endpoint() which has the comment
> "... Return rc or 1 to stop iteration." which is exactly 
> what it is doing.
> 
> so need an if (rc == 1) rc = 0; here
> 
> 
> 
> > +
> >  	up_read(&cxl_dpa_rwsem);
> >  
> >  	return rc ? rc : len;
> > diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> > index f29028148806..a055f8e36ef1 100644
> > --- a/drivers/cxl/core/region.c
> > +++ b/drivers/cxl/core/region.c
> > @@ -2213,6 +2213,95 @@ struct cxl_pmem_region *to_cxl_pmem_region(struct device *dev)
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
> > +	 * Regions are only created with single mode decoders: pmem or ram.
> > +	 * Linux does not currently support mixed mode decoders. This means
> > +	 * that reading poison per endpoint decoder adheres to the spec
> > +	 * requirement that poison reads of pmem and ram must be separated.
> > +	 * CXL 3.0 Spec 8.2.9.8.4.1
> > +	 *
> > +	 * Watch for future support of mixed with a dev_dbg() msg.
> > +	 */
> > +	if (cxled->mode == CXL_DECODER_MIXED) {
> > +		dev_dbg(dev, "poison list read unsupported in mixed mode\n");
> > +		goto out;
> > +	}
> > +
> > +	cxlmd = cxled_to_memdev(cxled);
> > +	if (cxled->skip) {
> > +		rc = cxl_mem_get_poison(cxlmd, 0, cxled->skip, NULL);
> 
> The base of this should be the top fo the previous decoder. I'm not immediately
> sure how you can get hold of that.
> 
> In my test with 1GB volatile and 1GB persistent the queries that are sent are:
> 0 to 0x10000000 (correct)
> 0 to 0x30000000 (wrong start, should be 0x10000000)
> 
> 0x40000000 to 0x50000000 (correct)
> 0x50000000 to 0x40000000 (not correct but at least the start is correct).
> See below for this one.
> 
> > +		if (rc == -EFAULT && cxled->mode == CXL_DECODER_RAM)
> > +			rc = 0;
> > +		if (rc)
> > +			goto out;
> > +	}
> > +	length = cxled->dpa_res->end - cxled->dpa_res->start + 1;
> > +	rc = cxl_mem_get_poison(cxlmd, cxled->dpa_res->start, length,
> > +				cxled->cxld.region);
> > +	if (rc == -EFAULT && cxled->mode == CXL_DECODER_RAM)
> > +		rc = 0;
> > +	if (rc)
> > +		goto out;
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
> 
> This is fine, unless you have a ram region in which case
> the offset computed here includes that as well as the
> persistent bit.
> 
> > +		length = resource_size(&cxlds->pmem_res) - offset;
> 
> So you need to take that into account with something like
> - (offset - cxlds->pmem_res.start);
> 
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
