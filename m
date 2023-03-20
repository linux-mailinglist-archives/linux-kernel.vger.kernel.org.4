Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F086A6C210D
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 20:15:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230476AbjCTTP0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 15:15:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231537AbjCTTOv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 15:14:51 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39C4147805;
        Mon, 20 Mar 2023 12:06:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679339216; x=1710875216;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=rOfjKAAWxv0XMnzWuGIfCrmikj+4etpj1/XdDsgGUfQ=;
  b=W0ekHHkGpHS5iAeYlB8EiiUxW9B4EUmwEOy8KUv7yEcQ2+QAGtAddvI/
   htlred8gxHkf5R0YOwno+wwWLeEZqGlJ+2bIZU1IZzlV0jJ69XLE/svYb
   JYp+/vC6NewpWEkdQYdNRteylzAKxxSLkNLPS6XWv1seTI0nxRk6lQpeX
   qMw5bW+5NgSZIAoA+HqtPQUy+7LtNaZMpTsgqviPvzEmSottO5m8sQAbY
   FrUqEU081iWVP/poxmWco77tbqsUBDEHwWM9Rv6LKpvYTVysrOIXQw7BQ
   pKsFw4yTPm9eL6CZzEUDXGTWPJVU9EvnjjwCvYOpW67J6NOHRlW0BNWVT
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10655"; a="338780132"
X-IronPort-AV: E=Sophos;i="5.98,276,1673942400"; 
   d="scan'208";a="338780132"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2023 12:06:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10655"; a="713665718"
X-IronPort-AV: E=Sophos;i="5.98,276,1673942400"; 
   d="scan'208";a="713665718"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO aschofie-mobl2) ([10.209.60.228])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2023 12:06:37 -0700
Date:   Mon, 20 Mar 2023 12:06:36 -0700
From:   Alison Schofield <alison.schofield@intel.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v9 5/6] cxl/trace: Add an HPA to cxl_poison trace events
Message-ID: <ZBiuvHx8otTLnOM5@aschofie-mobl2>
References: <cover.1679284567.git.alison.schofield@intel.com>
 <00b34ab93ffd2737b33d4f1c74fbd98968a58a60.1679284567.git.alison.schofield@intel.com>
 <20230320163059.00003b7a@Huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230320163059.00003b7a@Huawei.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 20, 2023 at 04:30:59PM +0000, Jonathan Cameron wrote:
> On Sun, 19 Mar 2023 21:31:50 -0700
> alison.schofield@intel.com wrote:
> 
> > From: Alison Schofield <alison.schofield@intel.com>
> > 
> > When a cxl_poison trace event is reported for a region, the poisoned
> > Device Physical Address (DPA) can be translated to a Host Physical
> > Address (HPA) for consumption by user space.
> > 
> > Translate and add the resulting HPA to the cxl_poison trace event.
> > Follow the device decode logic as defined in the CXL Spec 3.0 Section
> > 8.2.4.19.13.
> > 
> > If no region currently maps the poison, assign ULLONG_MAX to the
> > cxl_poison event hpa field.
> > 
> > Signed-off-by: Alison Schofield <alison.schofield@intel.com>
> > Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> > Reviewed-by: Ira Weiny <ira.weiny@intel.com>
> 
> Hi Alison,
> 
> I poked this with a few more test cases in QEMU and ran into a corner that
> probably wants addressing.
> 
> What should the tracepoints contain if the poisoned DPA length of a single
> record returned by the device is greater than the interleave granularity of
> of an interleaved region?

Jonathan,

How does that happen now that we are reading poison by endpoint decoder,
when committed decoders exist?

If we are always bounding the poison read requests by the decoder
resource, then the device cannot give us a length that goes beyond
that decoder's mapping.

For an endpoint decoder - a contiguous DPA space maps to a contiguous
HPA space.

Or not?

Alison

> 
> That didn't matter until HPA was added as we were just reporting a DPA
> base and length, but with the HPA present, the length is only in DPA space
> not HPA space.  Userspace can figure this out, but that's rather inelegant
> and would require ras-daemon or similar to go and query the interleave granularity
> and ways.
> 
> I think the best thing to do in this case would be to break the single returned DPA
> base record up into multiple trace points at the interleave granual boundaries.
> 
> What do you think we should do?
> 
> Jonathan
> 
> > ---
> >  drivers/cxl/core/trace.c | 94 ++++++++++++++++++++++++++++++++++++++++
> >  drivers/cxl/core/trace.h |  9 +++-
> >  2 files changed, 102 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/cxl/core/trace.c b/drivers/cxl/core/trace.c
> > index 29ae7ce81dc5..d0403dc3c8ab 100644
> > --- a/drivers/cxl/core/trace.c
> > +++ b/drivers/cxl/core/trace.c
> > @@ -1,5 +1,99 @@
> >  // SPDX-License-Identifier: GPL-2.0-only
> >  /* Copyright(c) 2022 Intel Corporation. All rights reserved. */
> >  
> > +#include <cxl.h>
> > +#include "core.h"
> > +
> >  #define CREATE_TRACE_POINTS
> >  #include "trace.h"
> > +
> > +static bool cxl_is_hpa_in_range(u64 hpa, struct cxl_region *cxlr, int pos)
> > +{
> > +	struct cxl_region_params *p = &cxlr->params;
> > +	int gran = p->interleave_granularity;
> > +	int ways = p->interleave_ways;
> > +	u64 offset;
> > +
> > +	/* Is the hpa within this region at all */
> > +	if (hpa < p->res->start || hpa > p->res->end) {
> > +		dev_dbg(&cxlr->dev,
> > +			"Addr trans fail: hpa 0x%llx not in region\n", hpa);
> > +		return false;
> > +	}
> > +
> > +	/* Is the hpa in an expected chunk for its pos(-ition) */
> > +	offset = hpa - p->res->start;
> > +	offset = do_div(offset, gran * ways);
> > +	if ((offset >= pos * gran) && (offset < (pos + 1) * gran))
> > +		return true;
> > +
> > +	dev_dbg(&cxlr->dev,
> > +		"Addr trans fail: hpa 0x%llx not in expected chunk\n", hpa);
> > +
> > +	return false;
> > +}
> > +
> > +static u64 cxl_dpa_to_hpa(u64 dpa,  struct cxl_region *cxlr,
> > +			  struct cxl_endpoint_decoder *cxled)
> > +{
> > +	u64 dpa_offset, hpa_offset, bits_upper, mask_upper, hpa;
> > +	struct cxl_region_params *p = &cxlr->params;
> > +	int pos = cxled->pos;
> > +	u16 eig = 0;
> > +	u8 eiw = 0;
> > +
> > +	ways_to_eiw(p->interleave_ways, &eiw);
> > +	granularity_to_eig(p->interleave_granularity, &eig);
> > +
> > +	/*
> > +	 * The device position in the region interleave set was removed
> > +	 * from the offset at HPA->DPA translation. To reconstruct the
> > +	 * HPA, place the 'pos' in the offset.
> > +	 *
> > +	 * The placement of 'pos' in the HPA is determined by interleave
> > +	 * ways and granularity and is defined in the CXL Spec 3.0 Section
> > +	 * 8.2.4.19.13 Implementation Note: Device Decode Logic
> > +	 */
> > +
> > +	/* Remove the dpa base */
> > +	dpa_offset = dpa - cxl_dpa_resource_start(cxled);
> > +
> > +	mask_upper = GENMASK_ULL(51, eig + 8);
> > +
> > +	if (eiw < 8) {
> > +		hpa_offset = (dpa_offset & mask_upper) << eiw;
> > +		hpa_offset |= pos << (eig + 8);
> > +	} else {
> > +		bits_upper = (dpa_offset & mask_upper) >> (eig + 8);
> > +		bits_upper = bits_upper * 3;
> > +		hpa_offset = ((bits_upper << (eiw - 8)) + pos) << (eig + 8);
> > +	}
> > +
> > +	/* The lower bits remain unchanged */
> > +	hpa_offset |= dpa_offset & GENMASK_ULL(eig + 7, 0);
> > +
> > +	/* Apply the hpa_offset to the region base address */
> > +	hpa = hpa_offset + p->res->start;
> > +
> > +	if (!cxl_is_hpa_in_range(hpa, cxlr, cxled->pos))
> > +		return ULLONG_MAX;
> > +
> > +	return hpa;
> > +}
> > +
> > +u64 cxl_trace_hpa(struct cxl_region *cxlr, struct cxl_memdev *cxlmd,
> > +		  u64 dpa)
> > +{
> > +	struct cxl_region_params *p = &cxlr->params;
> > +	struct cxl_endpoint_decoder *cxled = NULL;
> > +
> > +	for (int i = 0; i <  p->nr_targets; i++) {
> > +		cxled = p->targets[i];
> > +		if (cxlmd == cxled_to_memdev(cxled))
> > +			break;
> > +	}
> > +	if (!cxled || cxlmd != cxled_to_memdev(cxled))
> > +		return ULLONG_MAX;
> > +
> > +	return cxl_dpa_to_hpa(dpa, cxlr, cxled);
> > +}
> > diff --git a/drivers/cxl/core/trace.h b/drivers/cxl/core/trace.h
> > index 33a22d26e742..25dbf52ac327 100644
> > --- a/drivers/cxl/core/trace.h
> > +++ b/drivers/cxl/core/trace.h
> > @@ -631,6 +631,8 @@ TRACE_EVENT(cxl_memory_module,
> >  #define cxl_poison_overflow(flags, time)				\
> >  	(flags & CXL_POISON_FLAG_OVERFLOW ? le64_to_cpu(time) : 0)
> >  
> > +u64 cxl_trace_hpa(struct cxl_region *cxlr, struct cxl_memdev *memdev, u64 dpa);
> > +
> >  TRACE_EVENT(cxl_poison,
> >  
> >  	TP_PROTO(struct cxl_memdev *cxlmd, struct cxl_region *region,
> > @@ -645,6 +647,7 @@ TRACE_EVENT(cxl_poison,
> >  		__field(u64, serial)
> >  		__string(region, region)
> >  		__field(u64, overflow_t)
> > +		__field(u64, hpa)
> >  		__field(u64, dpa)
> >  		__field(u32, length)
> >  		__array(char, uuid, 16)
> > @@ -664,18 +667,22 @@ TRACE_EVENT(cxl_poison,
> >  		if (region) {
> >  			__assign_str(region, dev_name(&region->dev));
> >  			memcpy(__entry->uuid, &region->params.uuid, 16);
> > +			__entry->hpa = cxl_trace_hpa(region, cxlmd,
> > +						     __entry->dpa);
> >  		} else {
> >  			__assign_str(region, "");
> >  			memset(__entry->uuid, 0, 16);
> > +			__entry->hpa = ULLONG_MAX;
> >  		}
> >  	    ),
> >  
> > -	TP_printk("memdev=%s host=%s serial=%lld region=%s region_uuid=%pU dpa=0x%llx length=0x%x source=%s flags=%s overflow_time=%llu",
> > +	TP_printk("memdev=%s host=%s serial=%lld region=%s region_uuid=%pU hpa=0x%llx dpa=0x%llx length=0x%x source=%s flags=%s overflow_time=%llu",
> >  		__get_str(memdev),
> >  		__get_str(host),
> >  		__entry->serial,
> >  		__get_str(region),
> >  		__entry->uuid,
> > +		__entry->hpa,
> >  		__entry->dpa,
> >  		__entry->length,
> >  		show_poison_source(__entry->source),
> 
