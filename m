Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58A1A5FE807
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 06:39:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229691AbiJNEjb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 00:39:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbiJNEj3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 00:39:29 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABB6B18D80A;
        Thu, 13 Oct 2022 21:39:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1665722368; x=1697258368;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=JhpdOQamWt50D+BM2qWOyaiUIxaEclavw7aiBjqjFCM=;
  b=N8u4Rev4IoJv058iVWSvuDzJvrz7mpGKGPl3DNkg4VKHtmcokBWCElHd
   YjgT6zLppb03QqnQu/0qhtn+1/ITXuWKA0Z9Dm2djisjuvLtGdVWPIsd8
   gvw1xFqWb6d981daJMao9yILdJvPnSvNfJMEhYbmdiRSwQ4z8Xc3ug8fO
   iA6SOlldL6jsp5zRgUA5vw3u+VpcjXiJNkavo6b2lL73PjGuoIdn2VQ5p
   EMMwNDeb/nz+RIpyLyDNBHwci/0iy4+b7nxn6nSDd7Shxd3whTxPCHVmD
   xsivMEvdVDYrMVo5sK2JCZByJfhLgbxWnh6g6hcYwRQKFtHosarsGlMqE
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10499"; a="285667609"
X-IronPort-AV: E=Sophos;i="5.95,182,1661842800"; 
   d="scan'208";a="285667609"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2022 21:39:28 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10499"; a="769895135"
X-IronPort-AV: E=Sophos;i="5.95,182,1661842800"; 
   d="scan'208";a="769895135"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO aschofie-mobl2) ([10.212.171.186])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2022 21:39:27 -0700
Date:   Thu, 13 Oct 2022 21:39:26 -0700
From:   Alison Schofield <alison.schofield@intel.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, linux-cxl@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/4] trace, cxl: Introduce a TRACE_EVENT for CXL
 poison records
Message-ID: <Y0jn/omLjS7pkq/B@aschofie-mobl2>
References: <cover.1665606782.git.alison.schofield@intel.com>
 <17ee0f309e4287510e4e68f2cbcfc9d111a6e69d.1665606782.git.alison.schofield@intel.com>
 <20221012174620.7cd7d062@rorschach.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221012174620.7cd7d062@rorschach.local.home>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 12, 2022 at 05:46:20PM -0400, Steven Rostedt wrote:
> On Wed, 12 Oct 2022 14:28:17 -0700
> alison.schofield@intel.com wrote:
> 
> > +TRACE_EVENT(cxl_poison,
> > +
> > +	    TP_PROTO(pid_t pid, const char *region, const char *memdev,
> > +		     const char *pcidev, u64 hpa, u64 dpa, u32 length,
> > +		     u8 source, u8 flags, u64 overflow_t),
> > +
> > +	    TP_ARGS(pid, region, memdev, pcidev, hpa, dpa,
> > +		    length, source, flags, overflow_t),
> > +
> > +	    TP_STRUCT__entry(
> > +		__field(pid_t, pid)
> > +		__string(region, region ? region : "")
> > +		__string(memdev, memdev)
> > +		__string(pcidev, pcidev)
> > +		__field(u64, hpa)
> > +		__field(u64, dpa)
> > +		__field(u32, length)
> > +		__field(u8, source)
> > +		__field(u8, flags)
> > +		__field(u64, overflow_t)
> 
> The above looks nice and compact.
> 
> > +	    ),
> > +
> > +	    TP_fast_assign(
> > +		__entry->pid = pid;
> > +		__assign_str(region, region ? region : "");
> > +		__assign_str(memdev, memdev);
> > +		__assign_str(pcidev, pcidev);
> > +		__entry->hpa = hpa;
> > +		__entry->dpa = dpa;
> > +		__entry->length = length;
> > +		__entry->source = source;
> > +		__entry->flags = flags;
> > +		__entry->overflow_t = overflow_t;
> 
> But I wonder if it would be better to move the computation of patch 2
> here?
> 
> That is, this:
> 
> > +		for (i = 0; i < le16_to_cpu(po->count); i++) {
> > +			u32 len = le32_to_cpu(po->record[i].length) *
> > +					      CXL_POISON_LEN_MULT;
> > +			u64 addr = le64_to_cpu(po->record[i].address);
> > +			u8 source = addr & CXL_POISON_SOURCE_MASK;
> > +			u64 dpa = addr & CXL_POISON_START_MASK;
> > +			u64 hpa = 0;
> > +
> > +			trace_cxl_poison(current->pid, region_name,
> > +					 dev_name(&cxlmd->dev),
> > +					 dev_name(cxlds->dev), hpa, dpa, len,
> > +					 source, po->flags, overflow_t);
> > +		}
> 
> As:
> 
> // The trace_*_enabled() is a static branch which is true when the
> // tracepoint is enabled, and a nop when not (skipping the for block)

Thanks for pointing it out Steve. I will take advantage of that in next
version.

In this case, we'd expect, but not enforce, that the tracepoint would
be enabled, because otherwise we're just reading the data from the
device and throwing it away. 

I appreciate your help here!
Alison

> 
> 		for (i = 0; trace_cxl_poison_enabled() && i < le16_to_cpu(po->count); i++)
> 			trace_cxl_poison(region_name, cxlmd, cxlds, &po->record[i]);
> 
> And then have:
> 
> 	    TP_fast_assign(
> 		u32 len = le32_to_cpu(record->length) *
> 				      CXL_POISON_LEN_MULT;
> 		u64 addr = le64_to_cpu(record->address);
> 		u8 source = addr & CXL_POISON_SOURCE_MASK;
> 		u64 dpa = addr & CXL_POISON_START_MASK;
> 		u64 hpa = 0;
> 
> 		__entry->pid = current->pid;
> 
> { the above isn't needed as the trace event will have common_pid = current->pid }

got it, thanks.

> 
> 		__assign_str(region, region ? region : "");
> 		__assign_str(memdev, dev_name(&cxlmd->dev));
> 		__assign_str(pcidev, dev_name(cxlds->dev));
> 		__entry->hpa = hpa;
> 		__entry->dpa = dpa;
> 		__entry->length = length;
> 		__entry->source = source;
> 		__entry->flags = flags;
> 		__entry->overflow_t = overflow_t;
> 
> 
> Or something similar. This will keep the work out of the code path.
> 
> -- Steve
> 
> 
> > +	    ),
> > +
> > +	    TP_printk("pid:%d region:%s memdev:%s pcidev:%s hpa:0x%llx dpa:0x%llx length:0x%x source:%s flags:%s overflow_time:%llu",
> > +		__entry->pid,
> > +		__get_str(region),
> > +		__get_str(memdev),
> > +		__get_str(pcidev),
> > +		__entry->hpa,
> > +		__entry->dpa,
> > +		__entry->length,
> > +		show_poison_source(__entry->source),
> > +		show_poison_flags(__entry->flags),
> > +		__entry->overflow_t)
> > +);
> > +#endif /* _CXL_TRACE_H */
