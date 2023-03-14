Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14AC76B86F1
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 01:35:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229813AbjCNAfk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 20:35:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjCNAfj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 20:35:39 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A310465126;
        Mon, 13 Mar 2023 17:35:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678754137; x=1710290137;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=wim5EM0qnSaEJUm8SqU1JlzCrYqhyEYyMPmofoPjiWQ=;
  b=WkBye9zaHRdVCx3bSrtyy51WgCOxaKsENMgtkXCT75MwrNfU0Ogr8A4X
   Th8K5LgWNhKTvoBf23A699ncbXvCBSfbhLA0zER55MLfbAJszPkhOdsRq
   8HXkr71XtR9yb0GNL7bL6+nSv93zlPWSUVv+OCPiCuDhA6Pv4hW27N+1K
   SlOCri1CiZjzRv+dsc6rf3A8tiXXd5IOOwNtfTWeOpRpwJm0MBaq0nRgx
   lmoMX1Ts8pK+V5N/DxaztogKDZJY7YccXTfayhsOvB8nh8fgjzqxx57OU
   AEMV1Ib1tpd0dNeYDYZkQCBgnzpRW9u3Y/ICxsx9BVUHfJlIuo4lBd7wM
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10648"; a="364956439"
X-IronPort-AV: E=Sophos;i="5.98,258,1673942400"; 
   d="scan'208";a="364956439"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2023 17:35:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10648"; a="767900958"
X-IronPort-AV: E=Sophos;i="5.98,258,1673942400"; 
   d="scan'208";a="767900958"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO aschofie-mobl2) ([10.209.44.112])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2023 17:35:36 -0700
Date:   Mon, 13 Mar 2023 17:35:34 -0700
From:   Alison Schofield <alison.schofield@intel.com>
To:     Ira Weiny <ira.weiny@intel.com>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 4/6] cxl/region: Provide region info to the cxl_poison
 trace event
Message-ID: <ZA/BVmrsmksBmfih@aschofie-mobl2>
References: <cover.1678468593.git.alison.schofield@intel.com>
 <b5ba1187b04a18f49be9ebb91b699cfa8573eef2.1678468593.git.alison.schofield@intel.com>
 <640fa740be63_22c07f2949e@iweiny-mobl.notmuch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <640fa740be63_22c07f2949e@iweiny-mobl.notmuch>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 13, 2023 at 03:44:16PM -0700, Ira Weiny wrote:
> alison.schofield@ wrote:
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
> > ---
> >  drivers/cxl/core/core.h   |  5 ++
> >  drivers/cxl/core/memdev.c | 17 ++++++-
> >  drivers/cxl/core/region.c | 96 +++++++++++++++++++++++++++++++++++++++
> >  3 files changed, 117 insertions(+), 1 deletion(-)
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
> > index ea996057815e..5e65818d2171 100644
> > --- a/drivers/cxl/core/memdev.c
> > +++ b/drivers/cxl/core/memdev.c
> > @@ -139,14 +139,29 @@ static ssize_t trigger_poison_list_store(struct device *dev,
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
> > +	if (port->commit_end == -1) {
> > +		/* No regions mapped to this memdev */
> > +		rc = cxl_get_poison_by_memdev(cxlmd);
> > +	} else {
> > +		/* Regions mapped, collect poison by endpoint */
> > +		rc = device_for_each_child(&port->dev, port,
> > +					   cxl_get_poison_by_endpoint);
> > +		if (rc == 1)
> > +			rc = 0;
> > +	}
> > +
> >  	up_read(&cxl_dpa_rwsem);
> >  
> >  	return rc ? rc : len;
> > diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> > index f29028148806..1a558adfe32d 100644
> > --- a/drivers/cxl/core/region.c
> > +++ b/drivers/cxl/core/region.c
> > @@ -2213,6 +2213,102 @@ struct cxl_pmem_region *to_cxl_pmem_region(struct device *dev)
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
> > +		offset = cxled->dpa_res->start - cxled->skip;
> > +		length = cxled->skip;
> > +		rc = cxl_mem_get_poison(cxlmd, offset, length, NULL);
> > +		if (rc == -EFAULT && cxled->mode == CXL_DECODER_RAM)
> > +			rc = 0;
> > +		if (rc)
> > +			goto out;
> > +	}
> > +
> > +	offset = cxled->dpa_res->start;
> > +	length = cxled->dpa_res->end - offset + 1;
> > +	rc = cxl_mem_get_poison(cxlmd, offset, length, cxled->cxld.region);
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
> 
> I wonder if this is the best place to put this final logic vs in
> trigger_poison_list_store()?

Appreciate that feedback. I get it, we're over here in the core region
driver because we're doing stuff by region. The thing that keeps the
work here after all the poison per region is retrieved, is that we're
holding the cxl_dpa_rwsem so no new regions get created in the
'remains'. 

> 
> I see that you need that last cxled info...  So I think it is probably ok.
> But it was odd trying to understand here.

I'll look at this last part further. 

> 
> Reviewed-by: Ira Weiny <ira.weiny@intel.com>

> 
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
> > +		length = resource_size(&cxlds->dpa_res) - offset;
> > +		if (!length) {
> > +			rc = 1;
> > +			goto out;
> > +		}
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
> > -- 
> > 2.37.3
> > 
> 
> 
