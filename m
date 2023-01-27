Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB78A67EA7A
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 17:11:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234578AbjA0QLQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 11:11:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234500AbjA0QLO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 11:11:14 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EB545CD2A;
        Fri, 27 Jan 2023 08:11:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674835871; x=1706371871;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=QOzaDuDJVI2iCLV4Lb3ob1aL5f7nt+w5a8r1p9mfh9w=;
  b=YnLyyLOGBE7d5dw2L5yyHO3Ag9/UJct9XzbzvQjTZifJZaPy0YpnzBPr
   4NXbosPw1sPBh8SvGDl2GJW1ogmlUnb02PK9cgRRsuIHBJfrrUjdbkiz1
   i2T93KJbpISQztC7gGmQa3XYz6ZnG1gGJ7VbKizEH456gypRYTZr+kaXu
   jsW/Gz2bCVhWU7+5gjcNGjKdMYHVk8uDX77HSSFh9J0qAeH0A0yf9/rgg
   wigQyfgE1GFKbNg1NsDRmuYJ35FRbowkvfXZgj71B3/m5aVkWhO7g+P3f
   1N5MCd6xMQC65KskqIkjL47c7JhmYuUosuVpDe/qQBC2tCsIlMP9UMECW
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10603"; a="328407645"
X-IronPort-AV: E=Sophos;i="5.97,251,1669104000"; 
   d="scan'208";a="328407645"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2023 08:11:03 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10603"; a="640745108"
X-IronPort-AV: E=Sophos;i="5.97,251,1669104000"; 
   d="scan'208";a="640745108"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO aschofie-mobl2) ([10.212.161.50])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2023 08:10:51 -0800
Date:   Fri, 27 Jan 2023 08:10:50 -0800
From:   Alison Schofield <alison.schofield@intel.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re:
Message-ID: <Y9P3ipL28W7N1bLm@aschofie-mobl2>
References: <cover.1674070170.git.alison.schofield@intel.com>
 <63d32fe783ee2_ea2222949f@dwillia2-xfh.jf.intel.com.notmuch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <63d32fe783ee2_ea2222949f@dwillia2-xfh.jf.intel.com.notmuch>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 26, 2023 at 05:59:03PM -0800, Dan Williams wrote:
> alison.schofield@ wrote:
> > From: Alison Schofield <alison.schofield@intel.com>
> > 
> > Subject: [PATCH v5 0/5] CXL Poison List Retrieval & Tracing
> > 
> > Changes in v5:
> > - Rebase on cxl/next 
> > - Use struct_size() to calc mbox cmd payload .min_out
> > - s/INTERNAL/INJECTED mocked poison record source
> > - Added Jonathan Reviewed-by tag on Patch 3
> > 
> > Link to v4:
> > https://lore.kernel.org/linux-cxl/cover.1671135967.git.alison.schofield@intel.com/
> > 
> > Add support for retrieving device poison lists and store the returned
> > error records as kernel trace events.
> > 
> > The handling of the poison list is guided by the CXL 3.0 Specification
> > Section 8.2.9.8.4.1. [1] 
> > 
> > Example, triggered by memdev:
> > $ echo 1 > /sys/bus/cxl/devices/mem3/trigger_poison_list
> > cxl_poison: memdev=mem3 pcidev=cxl_mem.3 region= region_uuid=00000000-0000-0000-0000-000000000000 dpa=0x0 length=0x40 source=Internal flags= overflow_time=0
> 
> I think the pcidev= field wants to be called something like "host" or
> "parent", because there is no strict requirement that a 'struct
> cxl_memdev' is related to a 'struct pci_dev'. In fact in that example
> "cxl_mem.3" is a 'struct platform_device'. Now that I think about it, I
> think all CXL device events should be emitting the PCIe serial number
> for the memdev.
]

Will do, 'host' and add PCIe serial no.

> 
> I will look in the implementation, but do region= and region_uuid= get
> populated when mem3 is a member of the region?

Not always.
In the case above, where the trigger was by memdev, no.
Region= and region_uuid= (and in the follow-on patch, hpa=) only get
populated if the poison was triggered by region, like the case below.

It could be looked up for the by memdev cases. Is that wanted?

Thanks for the reviews Dan!
> 
> > 
> > Example, triggered by region:
> > $ echo 1 > /sys/bus/cxl/devices/region5/trigger_poison_list
> > cxl_poison: memdev=mem0 pcidev=cxl_mem.0 region=region5 region_uuid=bfcb7a29-890e-4a41-8236-fe22221fc75c dpa=0x0 length=0x40 source=Internal flags= overflow_time=0
> > cxl_poison: memdev=mem1 pcidev=cxl_mem.1 region=region5 region_uuid=bfcb7a29-890e-4a41-8236-fe22221fc75c dpa=0x0 length=0x40 source=Internal flags= overflow_time=0
> > 
> > [1]: https://www.computeexpresslink.org/download-the-specification
> > 
> > Alison Schofield (5):
> >   cxl/mbox: Add GET_POISON_LIST mailbox command
> >   cxl/trace: Add TRACE support for CXL media-error records
> >   cxl/memdev: Add trigger_poison_list sysfs attribute
> >   cxl/region: Add trigger_poison_list sysfs attribute
> >   tools/testing/cxl: Mock support for Get Poison List
> > 
> >  Documentation/ABI/testing/sysfs-bus-cxl | 28 +++++++++
> >  drivers/cxl/core/mbox.c                 | 78 +++++++++++++++++++++++
> >  drivers/cxl/core/memdev.c               | 45 ++++++++++++++
> >  drivers/cxl/core/region.c               | 33 ++++++++++
> >  drivers/cxl/core/trace.h                | 83 +++++++++++++++++++++++++
> >  drivers/cxl/cxlmem.h                    | 69 +++++++++++++++++++-
> >  drivers/cxl/pci.c                       |  4 ++
> >  tools/testing/cxl/test/mem.c            | 42 +++++++++++++
> >  8 files changed, 381 insertions(+), 1 deletion(-)
> > 
> > 
> > base-commit: 589c3357370a596ef7c99c00baca8ac799fce531
> > -- 
> > 2.37.3
> > 
> 
> 
