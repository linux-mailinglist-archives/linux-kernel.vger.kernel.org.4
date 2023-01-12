Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0369667BEF
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 17:52:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241323AbjALQtt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 11:49:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240749AbjALQmo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 11:42:44 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52E4A6577;
        Thu, 12 Jan 2023 08:37:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673541463; x=1705077463;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=TSG4u748WjZJlHl+rwGyBIdChhQBX7AI0cR8Hc3k8hI=;
  b=AG20ijXzWLeeinsGbt8nu5taLGLT6TVYYwGPkxf4Sh3jG5G+2cyx42Zm
   IA84F4s9tsUIeADUKqQwTwixLZHnlLDsygEkwvHala5qJm6crJOzYHSqt
   LrmKQq3rlMlZ0Iigwv33JxhoCft0sPKBBdBakrH7HqRdhiQfFrMM6Ov4Z
   8lOX1G9VtZDbG2/9nsHNl3tP1M8ToebAr6jligMY7YDEJ/ZU7RghnKbMn
   0XnNHbdFAi77t+kKDVDQccw1bPfzVbKmPRAiyUMlnHSaT4liQx1Rquxhw
   7SlsDGk8oUbHE8Z9cpRFyMEAi+Yu0yq5dklwZZ1luzkpSFMoahG+z1Rxy
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10588"; a="350983266"
X-IronPort-AV: E=Sophos;i="5.97,211,1669104000"; 
   d="scan'208";a="350983266"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2023 08:37:41 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10588"; a="986655648"
X-IronPort-AV: E=Sophos;i="5.97,211,1669104000"; 
   d="scan'208";a="986655648"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO aschofie-mobl2) ([10.212.250.89])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2023 08:37:39 -0800
Date:   Thu, 12 Jan 2023 08:37:38 -0800
From:   Alison Schofield <alison.schofield@intel.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
        shiju.jose@huawei.com
Subject: Re: [PATCH v4 2/5] cxl/trace: Add TRACE support for CXL media-error
 records
Message-ID: <Y8A3Ulo/DnflNVQu@aschofie-mobl2>
References: <cover.1671135967.git.alison.schofield@intel.com>
 <3417fd29fda6cd60b5a93a8f77dc57ad71693fa8.1671135967.git.alison.schofield@intel.com>
 <20230112111652.00000266@Huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230112111652.00000266@Huawei.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 12, 2023 at 11:16:52AM +0000, Jonathan Cameron wrote:
> On Thu, 15 Dec 2022 13:17:44 -0800
> alison.schofield@intel.com wrote:
> 
> > From: Alison Schofield <alison.schofield@intel.com>
> > 
> > CXL devices may support the retrieval of a device poison list.
> > Add a new trace event that the CXL subsystem may use to log
> > the media-error records returned in the poison list.
> > 
> > Log each media-error record as a trace event of type 'cxl_poison'.
> > 
> > When the poison list is requested by region, include the region name
> > and uuid in the trace event.
> > 
> > Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > Signed-off-by: Alison Schofield <alison.schofield@intel.com>
> 
> Hi Alison,
> 
> I'm wondering a bit if it makes sense to log/trace the MORE flag for each
> record.  That has some unusual semantics.  Like the other flags it's a
> characteristic of the underlying Get Poison List Output Payload, not a
> particularly Poison list entry. Unlike overflow and scanning which are
> reasonably a characteristic of each poison record in a given set read
> in one command, MORE is not.
> Imagine the following.
> 
> Read first N records, MORE set so we have that flag in all the trace
> records.
> Read next M records, MORE not set as list is less than N+M records.
> 
> Now userspace tooling has no idea about the mapping to underlying
> mailbox commands. So it sees this bit set for first N which is fine
> as there are more records following, but for the next M - 1 it might
> reasonably expect to see MORE set (as more records are getting traced)
> but it doesn't see it for any of them.
> 
> That seems less than intuitive. 
> 
> I'm not sure what to suggest... Seems wrong to 'make up a MORE flag' for
> those M-1 records.  Does it make sense to expose this flag at all?  In
> what way is it useful?
> 
> Jonathan

Thanks Jonathan - 

The FLAGs field today simply reflects the contents of the flags
field of the payload, which can be MORE, OVERFLOW, SCANNING.

Understand that 'MORE' seems useless to userspace however, I lean
towards giving userspace the complete truth, and letting userspace
ignore what is of no interest.

Perhaps a user wants to explore the boundaries of a devices
poison handling capacity. ie...use inject and get_poison and
see when the MORE flag appears. I don't know if it may appear
before the inject_max is reached.

So - I say keep MORE as is.

This discussion triggers another thought...

ATM, a devices max_mer - Max Media Error Records is not exposed in
sysfs, and this conversation makes me think it should be. It also,
comes to mind because I am exposing the inject_poison_limit to sysfs.

Users wanting to explore poison capabilities would be interested in
max_mer.

I'll add the max_mer to syfs in next rev.

Alison

> 
> 
> > ---
> >  drivers/cxl/core/mbox.c  |  6 ++-
> >  drivers/cxl/core/trace.h | 83 ++++++++++++++++++++++++++++++++++++++++
> >  2 files changed, 88 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> > index dfe24a2adfdb..c345af8a4afd 100644
> > --- a/drivers/cxl/core/mbox.c
> > +++ b/drivers/cxl/core/mbox.c
> > @@ -10,6 +10,7 @@
> >  #include <cxl.h>
> >  
> >  #include "core.h"
> > +#include "trace.h"
> >  
> >  static bool cxl_raw_allow_all;
> >  
> > @@ -899,7 +900,10 @@ int cxl_mem_get_poison(struct cxl_memdev *cxlmd, u64 offset, u64 len,
> >  		if (rc)
> >  			break;
> >  
> > -		/* TODO TRACE the media error records */
> > +		for (int i = 0; i < le16_to_cpu(po->count); i++)
> > +			trace_cxl_poison(cxlmd, to_pci_dev(cxlds->dev),
> > +					 cxlr, &po->record[i], po->flags,
> > +					 po->overflow_t);
> >  
> >  		/* Protect against an uncleared _FLAG_MORE */
> >  		nr_records = nr_records + le16_to_cpu(po->count);
> > diff --git a/drivers/cxl/core/trace.h b/drivers/cxl/core/trace.h
> > index 20ca2fe2ca8e..c7958311ce5f 100644
> > --- a/drivers/cxl/core/trace.h
> > +++ b/drivers/cxl/core/trace.h
> > @@ -8,6 +8,9 @@
> >  
> >  #include <cxl.h>
> >  #include <linux/tracepoint.h>
> > +#include <linux/pci.h>
> > +
> > +#include <cxlmem.h>
> >  
> >  #define CXL_RAS_UC_CACHE_DATA_PARITY	BIT(0)
> >  #define CXL_RAS_UC_CACHE_ADDR_PARITY	BIT(1)
> > @@ -103,6 +106,86 @@ TRACE_EVENT(cxl_aer_correctable_error,
> >  	)
> >  );
> >  
> > +#define __show_poison_source(source)                          \
> > +	__print_symbolic(source,                              \
> > +		{ CXL_POISON_SOURCE_UNKNOWN,   "Unknown"  },  \
> > +		{ CXL_POISON_SOURCE_EXTERNAL,  "External" },  \
> > +		{ CXL_POISON_SOURCE_INTERNAL,  "Internal" },  \
> > +		{ CXL_POISON_SOURCE_INJECTED,  "Injected" },  \
> > +		{ CXL_POISON_SOURCE_VENDOR,    "Vendor"   })
> > +
> > +#define show_poison_source(source)			     \
> > +	(((source > CXL_POISON_SOURCE_INJECTED) &&	     \
> > +	 (source != CXL_POISON_SOURCE_VENDOR)) ? "Reserved"  \
> > +	 : __show_poison_source(source))
> > +
> > +#define show_poison_flags(flags)                             \
> > +	__print_flags(flags, "|",                            \
> > +		{ CXL_POISON_FLAG_MORE,      "More"     },   \
> > +		{ CXL_POISON_FLAG_OVERFLOW,  "Overflow"  },  \
> > +		{ CXL_POISON_FLAG_SCANNING,  "Scanning"  })
> > +
> > +#define __cxl_poison_addr(record)					\
> > +	(le64_to_cpu(record->address))
> > +#define cxl_poison_record_dpa(record)					\
> > +	(__cxl_poison_addr(record) & CXL_POISON_START_MASK)
> > +#define cxl_poison_record_source(record)				\
> > +	(__cxl_poison_addr(record)  & CXL_POISON_SOURCE_MASK)
> > +#define cxl_poison_record_length(record)				\
> > +	(le32_to_cpu(record->length) * CXL_POISON_LEN_MULT)
> > +#define cxl_poison_overflow(flags, time)				\
> > +	(flags & CXL_POISON_FLAG_OVERFLOW ? le64_to_cpu(time) : 0)
> > +
> > +TRACE_EVENT(cxl_poison,
> > +
> > +	    TP_PROTO(struct cxl_memdev *memdev, const struct pci_dev *pcidev,
> > +		     struct cxl_region *region,
> > +		     const struct cxl_poison_record *record,
> > +		     u8 flags, __le64 overflow_t),
> > +
> > +	    TP_ARGS(memdev, pcidev, region, record, flags, overflow_t),
> > +
> > +	    TP_STRUCT__entry(
> > +		__string(memdev, dev_name(&memdev->dev))
> > +		__string(pcidev, dev_name(&pcidev->dev))
> > +		__string(region, region)
> > +		__field(u64, overflow_t)
> > +		__field(u64, dpa)
> > +		__field(u32, length)
> > +		__array(char, uuid, 16)
> > +		__field(u8, source)
> > +		__field(u8, flags)
> > +	    ),
> > +
> > +	    TP_fast_assign(
> > +		__assign_str(memdev, dev_name(&memdev->dev));
> > +		__assign_str(pcidev, dev_name(&pcidev->dev));
> > +		__entry->overflow_t = cxl_poison_overflow(flags, overflow_t);
> > +		__entry->dpa = cxl_poison_record_dpa(record);
> > +		__entry->length = cxl_poison_record_length(record);
> > +		__entry->source = cxl_poison_record_source(record);
> > +		__entry->flags = flags;
> > +		if (region) {
> > +			__assign_str(region, dev_name(&region->dev));
> > +			memcpy(__entry->uuid, &region->params.uuid, 16);
> > +		} else {
> > +			__assign_str(region, "");
> > +			memset(__entry->uuid, 0, 16);
> > +		}
> > +	    ),
> > +
> > +	    TP_printk("memdev=%s pcidev=%s region=%s region_uuid=%pU dpa=0x%llx length=0x%x source=%s flags=%s overflow_time=%llu",
> > +		__get_str(memdev),
> > +		__get_str(pcidev),
> > +		__get_str(region),
> > +		__entry->uuid,
> > +		__entry->dpa,
> > +		__entry->length,
> > +		show_poison_source(__entry->source),
> > +		show_poison_flags(__entry->flags),
> > +		__entry->overflow_t)
> > +);
> > +
> >  #endif /* _CXL_EVENTS_H */
> >  
> >  #define TRACE_INCLUDE_FILE trace
> 
