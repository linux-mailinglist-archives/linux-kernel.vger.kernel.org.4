Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7BFE645E76
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 17:11:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229950AbiLGQL0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 11:11:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230035AbiLGQLI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 11:11:08 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C3F366CA7;
        Wed,  7 Dec 2022 08:11:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670429460; x=1701965460;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=EX/E0ogleACTNBrig1L1Gk1DF0Q6RlzzbCNh3rOpf7o=;
  b=RQxfZ3DPO0++VrU99eyIC3EjclXgnoWmLrXtwkec1xmRn4X7SBNszQV5
   N04eg55uNCW9JFZzhAOR/0nCLgsEJIkqGlC/5d6kgYi6vmnZGEjmNPKaH
   LCG+1dvoitZUXANiNYNzrMJCZNaUXsF+jd8CltSjWTNM9TU/4TrTKiy0y
   ngmRl7A5KOr6FaJpZcXL4MRwkzOdohgnRNQtyF7snUalS4eg7a5wbD8aC
   cZGhNqB426soDUc/5S8OVkw26EfDH4nyVwDUE05nhnYhwvULCUKqrvR3t
   vYrdS2EAZ4PQDeSCEcxVIm/gYyyoBtcQ60SUENiQZZGtdLxl+YPRSLfyv
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10554"; a="403199361"
X-IronPort-AV: E=Sophos;i="5.96,225,1665471600"; 
   d="scan'208";a="403199361"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2022 08:10:59 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10554"; a="975513608"
X-IronPort-AV: E=Sophos;i="5.96,225,1665471600"; 
   d="scan'208";a="975513608"
Received: from vkoppal-mobl.amr.corp.intel.com (HELO aschofie-mobl2) ([10.212.198.95])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2022 08:10:58 -0800
Date:   Wed, 7 Dec 2022 08:10:57 -0800
From:   Alison Schofield <alison.schofield@intel.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>, linux-cxl@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/6] cxl/mbox: Add GET_POISON_LIST mailbox command
Message-ID: <Y5C7EYz1VrG2H7jh@aschofie-mobl2>
References: <cover.1668115235.git.alison.schofield@intel.com>
 <46c7c7339224744fce424b196da3e5566effec17.1668115235.git.alison.schofield@intel.com>
 <638ffd5eaa3a7_c95729426@dwillia2-mobl3.amr.corp.intel.com.notmuch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <638ffd5eaa3a7_c95729426@dwillia2-mobl3.amr.corp.intel.com.notmuch>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 06, 2022 at 06:41:34PM -0800, Dan Williams wrote:
> alison.schofield@ wrote:
> > From: Alison Schofield <alison.schofield@intel.com>
> > 
> > CXL devices maintain a list of locations that are poisoned or result
> > in poison if the addresses are accessed by the host.
> > 
> > Per the spec (CXL 3.0 8.2.9.8.4.1), the device returns this Poison
> > list as a set of  Media Error Records that include the source of the
> > error, the starting device physical address and length. The length is
> > the number of adjacent DPAs in the record and is in units of 64 bytes.
> > 
> > Retrieve the list and log each Media Error Record as a trace event of
> > type 'cxl_poison'.
> > 
> > When the poison list is requested by region, include the region name
> > and uuid in the trace event.
> > 
> > Signed-off-by: Alison Schofield <alison.schofield@intel.com>
> > ---
> >  drivers/cxl/core/mbox.c | 81 +++++++++++++++++++++++++++++++++++++++++
> >  drivers/cxl/cxlmem.h    | 37 +++++++++++++++++++
> >  2 files changed, 118 insertions(+)
> > 
> > diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> > index 0c90f13870a4..88f034e97812 100644
> > --- a/drivers/cxl/core/mbox.c
> > +++ b/drivers/cxl/core/mbox.c
> > @@ -9,6 +9,9 @@
> >  
> >  #include "core.h"
> >  
> > +#define CREATE_TRACE_POINTS
> > +#include <trace/events/cxl.h>
> > +
> >  static bool cxl_raw_allow_all;
> >  
> >  /**
> > @@ -752,6 +755,7 @@ int cxl_dev_state_identify(struct cxl_dev_state *cxlds)
> >  {
> >  	/* See CXL 2.0 Table 175 Identify Memory Device Output Payload */
> >  	struct cxl_mbox_identify id;
> > +	__le32 val = 0;
> >  	int rc;
> >  
> >  	rc = cxl_mbox_send_cmd(cxlds, CXL_MBOX_OP_IDENTIFY, NULL, 0, &id,
> > @@ -771,6 +775,9 @@ int cxl_dev_state_identify(struct cxl_dev_state *cxlds)
> >  	cxlds->lsa_size = le32_to_cpu(id.lsa_size);
> >  	memcpy(cxlds->firmware_version, id.fw_revision, sizeof(id.fw_revision));
> >  
> > +	memcpy(&val, id.poison_list_max_mer, 3);
> 
> I see Jonathan already commented on the need for get_unaligned_le24()
> here, seconded.
> 
Got it.

> 
> > +	cxlds->poison_max = min_t(u32, le32_to_cpu(val), CXL_POISON_LIST_MAX);
> > +
> >  	return 0;
> >  }
> >  EXPORT_SYMBOL_NS_GPL(cxl_dev_state_identify, CXL);
> > @@ -835,6 +842,79 @@ int cxl_mem_create_range_info(struct cxl_dev_state *cxlds)
> >  }
> >  EXPORT_SYMBOL_NS_GPL(cxl_mem_create_range_info, CXL);
> >  
> > +static void cxl_trace_poison(struct cxl_mbox_poison_payload_out *po,
> > +			     struct cxl_region *cxlr,
> > +			     const char *memdev_name,
> > +			     const char *pcidev_name)
> 
> Type-safety please. Pass a 'struct cxl_memdev *' and 'struct pci_dev *'.
> Might need to be 'struct device *' instead of 'struct pci_dev *'
> depending on if this needs to be called from cxl_test, but anything is
> better than a non-specific string.
> 
Got it.

> > +{
> > +	const char *region_name = cxlr ? dev_name(&cxlr->dev) : NULL;
> 
> ...and push this conversion into the trace point.
> 
Got that, and also pushed the decode of struct cxl_poison_record to
the trace point like this:

TP_PROTO(const struct device *memdev, const struct pci_dev *pcidev,
                     const struct cxl_region *region,
                     const struct cxl_poison_record *record,
                     u8 flags, __le64 overflow_t),


> > +	struct cxl_region_params *p = cxlr ? &cxlr->params : NULL;
> > +	uuid_t *uuid = p ? &p->uuid : NULL;
> > +	u64 addr, dpa, overflow_t = 0;
> > +	u8 source;
> > +	u32 len;
> > +
> > +	if (po->flags & CXL_POISON_FLAG_OVERFLOW)
> > +		overflow_t = le64_to_cpu(po->overflow_timestamp);
> > +
> > +	for (int i = 0; i < le16_to_cpu(po->count); i++) {
> > +		len = le32_to_cpu(po->record[i].length) * CXL_POISON_LEN_MULT;
> > +		addr = le64_to_cpu(po->record[i].address);
> > +		source = addr & CXL_POISON_SOURCE_MASK;
> > +		dpa = addr & CXL_POISON_START_MASK;
> > +
> > +		trace_cxl_poison(memdev_name, pcidev_name, region_name, uuid,
> > +				 dpa, len, source, po->flags, overflow_t);
> > +	}
> > +}
> > +
> > +int cxl_mem_get_poison(struct cxl_memdev *cxlmd, u64 offset, u64 len,
> > +		       struct cxl_region *cxlr)
> > +{
> > +	struct cxl_dev_state *cxlds = cxlmd->cxlds;
> > +	const char *memdev_name = dev_name(&cxlmd->dev);
> > +	const char *pcidev_name = dev_name(cxlds->dev);
> > +	struct cxl_mbox_poison_payload_out *po;
> > +	struct cxl_mbox_poison_payload_in pi;
> > +	int nr_records = 0;
> > +	int rc;
> > +
> > +	po = kvmalloc(cxlds->payload_size, GFP_KERNEL);
> > +	if (!po)
> > +		return -ENOMEM;
> > +
> > +	pi.offset = cpu_to_le64(offset);
> > +	pi.length = cpu_to_le64(len);
> > +
> > +	rc = mutex_lock_interruptible(&cxlds->poison_list_mutex);
> 
> So I do not know what this mutex is protecting if there is an allocation
> per cxl_mem_get_poison() invocation. Although I suspect that's somewhat
> wasteful. Just allocate one buffer at the beginning of time and then use
> the lock to protect that buffer.

Intent was a single lock on the device to protect the state of the
poison list retrieval - do not allow > 1 reader. With > 1 reader
software may not know if it retrieved the complete list.

I'm not understanding about protecting a buffer, instead of protecting
the state. Here I try to protect the state.

> 
> Although, I wonder if this and Event handling should share locks and one
> preallocated buffer? Otherwise I do think it is important for Events and
> Poison handling to be able to make forward progress without needing to
> allocate up to a megabyte of memory at runtime. The other payload_size
> allocations are for one-off things that run at the beginning of time,
> but Poison and Events run repeatedly.
> 
> > 
snip
