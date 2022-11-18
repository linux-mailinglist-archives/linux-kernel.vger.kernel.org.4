Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DDEF62EA2F
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 01:24:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234080AbiKRAYo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 19:24:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240604AbiKRAYh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 19:24:37 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C6C56B3B5;
        Thu, 17 Nov 2022 16:24:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668731075; x=1700267075;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=9c5T7Id5N/dIrGsW19u1DxMTz5rLx41JpV24RUmXqUA=;
  b=DGIfVz3VD6Mkv3jSR822pa7OlYpA0H0BbJ4LLqGFg392Esb0hcD6GVLx
   bP6xEotf5qKVvyZ0340cnKTJbCDt4Djhel53KXD/5/dtxb+PNCwIJ2i8i
   g94FiLrYvuiiqlZEeWYS1jk5Swrjrv0IQZU3e2sQDHKihySg98u7uGjcn
   l0Usbtx0ltMNyrFgYTysqiKHKoqqG/9ZLQ2N+4veN0cVmbOgC7I8civeu
   QZJlsZFhwqzMu/D6OfA2cgQTl2xdQL/IzCwy0pPuJ6mwkb8O/+Kh9ubRW
   Tzb5Lh32+/20S1zDXNh4v0Dya4Ox/SRWHdvVaaY0ui3TZ+BF7mdI2VTcC
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10534"; a="314831141"
X-IronPort-AV: E=Sophos;i="5.96,172,1665471600"; 
   d="scan'208";a="314831141"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2022 16:24:34 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10534"; a="708834634"
X-IronPort-AV: E=Sophos;i="5.96,172,1665471600"; 
   d="scan'208";a="708834634"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO aschofie-mobl2) ([10.209.84.12])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2022 16:24:33 -0800
Date:   Thu, 17 Nov 2022 16:24:31 -0800
From:   Alison Schofield <alison.schofield@intel.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>, linux-cxl@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 4/6] cxl/region: Add trigger_poison_list sysfs
 attribute
Message-ID: <Y3bQvywgOxBJUtbm@aschofie-mobl2>
References: <cover.1668115235.git.alison.schofield@intel.com>
 <a696d91e34fc845673345a6b024545df849a8fef.1668115235.git.alison.schofield@intel.com>
 <20221116125038.00006273@Huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221116125038.00006273@Huawei.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 16, 2022 at 12:50:38PM +0000, Jonathan Cameron wrote:
> On Thu, 10 Nov 2022 19:12:42 -0800
> alison.schofield@intel.com wrote:
> 
> > From: Alison Schofield <alison.schofield@intel.com>
> > 
> > When a boolean 'true' is written to this attribute the region driver
> > retrieves the poison list for the capacity each device contributes
> > to this region. The list includes addresses that are poisoned, or
> > would result in poison if accessed, and the source of the poison.
> > The retrieved errors are logged as kernel trace events with the
> > label 'cxl_poison'.
> > 
> > Devices not supporting the poison list capability are ignored.
> > 
> > Signed-off-by: Alison Schofield <alison.schofield@intel.com>
> Trivial comment inline you might want to consider.

Thanks, got it!  I will 'include' your tag going forward.
> 
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> > ---
> >  Documentation/ABI/testing/sysfs-bus-cxl | 14 +++++++++++
> >  drivers/cxl/core/region.c               | 33 +++++++++++++++++++++++++
> >  2 files changed, 47 insertions(+)
> > 
> > diff --git a/Documentation/ABI/testing/sysfs-bus-cxl b/Documentation/ABI/testing/sysfs-bus-cxl
> > index 1c5f4a853ba2..54fad3bdcb2b 100644
> > --- a/Documentation/ABI/testing/sysfs-bus-cxl
> > +++ b/Documentation/ABI/testing/sysfs-bus-cxl
> > @@ -402,3 +402,17 @@ Description:
> >  		attribute is only visible for devices supporting the
> >  		capability. The retrieved errors are logged as kernel
> >  		trace events with the label 'cxl_poison'.
> > +
> > +
> > +What:		/sys/bus/cxl/devices/regionZ/trigger_poison_list
> > +Date:		November, 2022
> > +KernelVersion:	v6.2
> > +Contact:	linux-cxl@vger.kernel.org
> > +Description:
> > +		(WO) When a boolean 'true' is written to this attribute the
> > +		region driver retrieves the poison list for the capacity
> > +		each device contributes to this region. The list includes
> Trivial: Same as in previous patch. "includes" is too vague.
> 
> > +		addresses that are poisoned, or would result in poison if
> > +		accessed, and the source of the poison. The retrieved
> > +		errors are logged as kernel trace events with the label
> > +		'cxl_poison'.
> > diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> > index f9ae5ad284ff..68821238491e 100644
> > --- a/drivers/cxl/core/region.c
> > +++ b/drivers/cxl/core/region.c
> > @@ -72,6 +72,38 @@ static int is_dup(struct device *match, void *data)
> >  	return 0;
> >  }
> >  
> > +static ssize_t trigger_poison_list_store(struct device *dev,
> > +					 struct device_attribute *attr,
> > +					 const char *buf, size_t len)
> > +{
> > +	struct cxl_region *cxlr = to_cxl_region(dev);
> > +	struct cxl_region_params *p = &cxlr->params;
> > +	struct cxl_endpoint_decoder *cxled;
> > +	struct cxl_memdev *cxlmd;
> > +	u64 offset, length;
> > +	int rc, i;
> > +	bool tmp;
> > +
> > +	if (kstrtobool(buf, &tmp))
> > +		return -EINVAL;
> > +
> > +	for (i = 0; i <  p->nr_targets; i++) {
> > +		cxled = p->targets[i];
> > +		cxlmd = cxled_to_memdev(cxled);
> > +		if (!test_bit(CXL_MEM_COMMAND_ID_GET_POISON,
> > +			      cxlmd->cxlds->enabled_cmds))
> > +			continue;
> > +
> > +		offset = cxl_dpa_resource_start(cxled);
> > +		length = cxl_dpa_size(cxled);
> > +		rc = cxl_mem_get_poison(cxlmd, offset, length, cxlr);
> > +		if (rc)
> > +			return rc;
> > +	}
> > +	return len;
> > +}
> > +static DEVICE_ATTR_WO(trigger_poison_list);
> > +
> >  static ssize_t uuid_store(struct device *dev, struct device_attribute *attr,
> >  			  const char *buf, size_t len)
> >  {
> > @@ -570,6 +602,7 @@ static struct attribute *cxl_region_attrs[] = {
> >  	&dev_attr_interleave_granularity.attr,
> >  	&dev_attr_resource.attr,
> >  	&dev_attr_size.attr,
> > +	&dev_attr_trigger_poison_list.attr,
> >  	NULL,
> >  };
> >  
> 
