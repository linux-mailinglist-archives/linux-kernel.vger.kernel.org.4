Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5332967F0AB
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 22:53:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229496AbjA0Vw7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 16:52:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231611AbjA0Vw5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 16:52:57 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06FB4126E3;
        Fri, 27 Jan 2023 13:52:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674856371; x=1706392371;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=9Ii69Mw+ITtCryrVzceNJaInNNbxTdiKPALVlpnKbxQ=;
  b=XFPKmMzzNIuVcBOniXO0gyo+vU5RrngZfQNvUmlLJo/aEN87SMMYJHKI
   f9eHP0yGjBDaCi5bwvIxG1PCyh/LD8saF/HdsAEfZQC+Sdefb+vpiGVRB
   +gPQOzcj58xrAzjcmtwo3W3XMZRS0Lsza4X8dcqZbKpeWXFCqL1czVyjU
   zmAwlN/xh4cNz09W2fzbtVheAz8FqHLZ2Np+UR4P6qr6ts4u6h1pbQrC/
   yjjR3k9YhVZNIDkLr/YWY9Uo+HmhW9sCTNBOqPmR6P+c/7ZDDPtvzEh7F
   Ppz1MjMuESFO3gE8JYrook+T1x3JOC7BXldlbkAVi6DpVy61ENi2F+PfO
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10603"; a="389581092"
X-IronPort-AV: E=Sophos;i="5.97,252,1669104000"; 
   d="scan'208";a="389581092"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2023 13:52:49 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10603"; a="693858269"
X-IronPort-AV: E=Sophos;i="5.97,252,1669104000"; 
   d="scan'208";a="693858269"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO aschofie-mobl2) ([10.212.161.50])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2023 13:52:49 -0800
Date:   Fri, 27 Jan 2023 13:52:47 -0800
From:   Alison Schofield <alison.schofield@intel.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v5 3/5] cxl/memdev: Add trigger_poison_list sysfs
 attribute
Message-ID: <Y9RHr0kQqfLiT3Cq@aschofie-mobl2>
References: <cover.1674070170.git.alison.schofield@intel.com>
 <fc1a2f51834888c2ea585efb0b4fa41cd251e52d.1674070170.git.alison.schofield@intel.com>
 <63d429435984f_3a36e5294b2@dwillia2-xfh.jf.intel.com.notmuch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <63d429435984f_3a36e5294b2@dwillia2-xfh.jf.intel.com.notmuch>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 27, 2023 at 11:42:59AM -0800, Dan Williams wrote:
> alison.schofield@ wrote:
> > From: Alison Schofield <alison.schofield@intel.com>
> > 
> > When a boolean 'true' is written to this attribute the memdev driver
> > retrieves the poison list from the device. The list consists of
> > addresses that are poisoned, or would result in poison if accessed,
> > and the source of the poison. This attribute is only visible for
> > devices supporting the capability. The retrieved errors are logged
> > as kernel trace events with the label 'cxl_poison'.
> > 
> > Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > Signed-off-by: Alison Schofield <alison.schofield@intel.com>
> > ---
> >  Documentation/ABI/testing/sysfs-bus-cxl | 14 ++++++++
> >  drivers/cxl/core/memdev.c               | 45 +++++++++++++++++++++++++
> >  drivers/cxl/cxlmem.h                    |  2 +-
> >  3 files changed, 60 insertions(+), 1 deletion(-)
> > 
> > diff --git a/Documentation/ABI/testing/sysfs-bus-cxl b/Documentation/ABI/testing/sysfs-bus-cxl
> > index 8494ef27e8d2..df40ed09ea67 100644
> > --- a/Documentation/ABI/testing/sysfs-bus-cxl
> > +++ b/Documentation/ABI/testing/sysfs-bus-cxl
> > @@ -388,3 +388,17 @@ Description:
> >  		1), and checks that the hardware accepts the commit request.
> >  		Reading this value indicates whether the region is committed or
> >  		not.
> > +
> > +
> > +What:		/sys/bus/cxl/devices/memX/trigger_poison_list
> > +Date:		November, 2022
> > +KernelVersion:	v6.2
> > +Contact:	linux-cxl@vger.kernel.org
> > +Description:
> > +		(WO) When a boolean 'true' is written to this attribute the
> > +		memdev driver retrieves the poison list from the device. The
> > +		list consists of addresses that are poisoned, or would result
> > +		in poison if accessed, and the source of the poison. This
> > +		attribute is only visible for devices supporting the
> > +		capability. The retrieved errors are logged as kernel
> > +		trace events with the label 'cxl_poison'.
> > diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
> > index a74a93310d26..e0af7e9c9989 100644
> > --- a/drivers/cxl/core/memdev.c
> > +++ b/drivers/cxl/core/memdev.c
> > @@ -106,12 +106,49 @@ static ssize_t numa_node_show(struct device *dev, struct device_attribute *attr,
> >  }
> >  static DEVICE_ATTR_RO(numa_node);
> >  
> > +static ssize_t trigger_poison_list_store(struct device *dev,
> > +					 struct device_attribute *attr,
> > +					 const char *buf, size_t len)
> > +{
> > +	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
> > +	struct cxl_dev_state *cxlds = cxlmd->cxlds;
> > +	u64 offset, length;
> > +	bool tmp;
> > +	int rc;
> > +
> > +	if (kstrtobool(buf, &tmp))
> > +		return -EINVAL;
> 
> Wait, where's the check for "if (tmp)"? Otherwise I can do "echo N >
> trigger_poison_list" and it will still run. Should probably
> s/tmp/trigger/.

Got it.
(I guess I was too loose w the trigger, thinking you write anything to
it, I'm triggering.)
> 
> > +
> > +	/* CXL 3.0 Spec 8.2.9.8.4.1 Separate pmem and ram poison requests */
> > +	if (resource_size(&cxlds->pmem_res)) {
> > +		offset = cxlds->pmem_res.start;
> > +		length = resource_size(&cxlds->pmem_res);
> > +		rc = cxl_mem_get_poison(cxlmd, offset, length, NULL);
> 
> Ah now I see why the region information is not provided in the memdev
> triggers. I think while the scan needs to be done on partition boundary
> basis, like you have here, I think the region lookup needs to happen on
> a per-record basis.
> 
> However, that's a significant architectural change, so I am going to
> think out loud about the implications.

I'm thinking that adding region info to the trace event isn't starting
here. That will be looked up when we log the event. Basically assuming
assuming find regions memdev participates in, and look for which one
maps this DPA.

> 
> A site operator wants to know "is FRU (field-replaceable-unit) X bad,
> and if so what's the damage?". In that report I expect they want to know
> if poison impacts media that is allocated to a region (an imminent
> danger) or is in free space (a problem for a later date). If the memdev
> trigger does all the region lookup per record it provides that
> information. Further if the memdev trigger reliably provides region
> information it allows the region trigger ABI to be deleted. The region
> trigger can be replaced in userspace with logic that does:
> 
>    set tracepoint filter to look for region_id == $region
>    for endpoint decoder in $region
>        trigger associated memdev
> 
> ...so I do think the arch change is worth it, but I am willing to hear
> counter arguments.

My only counter argument was that we could let them have it both ways,
but, simplifying and reducing code in kernel is good!


