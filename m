Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 026556D2445
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 17:45:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232966AbjCaPpj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 11:45:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232520AbjCaPph (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 11:45:37 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 911CE6E98;
        Fri, 31 Mar 2023 08:45:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680277536; x=1711813536;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=SbFjtHEfruWCCROSNuIXINiYa1mSZj2wItHEcqOS6Es=;
  b=ZTxkJ15cxWzGj194cNnUuojQWE1bvA/avFGmvbUgM2MbSWM3XxrL06U9
   WKsIQiks+779zW3K+78qOlpex1kDaA5+HqkXkjO6PwNM6U39MXpYW4fvL
   fS2i7Mdtfzrt30zniuL//WK4o5b6395eP/xGVSWbBYuyKebNgxLWyWJIg
   AFigDJz0Iy+yT8gKB5bRYoT5ZiObJJZ6WZ+BpBZeujlBfahMX8dIhDOLg
   BcFRHnXK9AbsRF2qZ4LevFQarF1fC2gGfb49AU1RUuM0860L1Vh0u21bm
   zxvO1RCToOtoZFoMLVyTWgN5XR9m7exG2QPOAI4t6Gx7g8wLcBjby1fHN
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10666"; a="338979746"
X-IronPort-AV: E=Sophos;i="5.98,307,1673942400"; 
   d="scan'208";a="338979746"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2023 08:45:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10666"; a="1014871164"
X-IronPort-AV: E=Sophos;i="5.98,307,1673942400"; 
   d="scan'208";a="1014871164"
Received: from ssayachi-mobl.amr.corp.intel.com (HELO aschofie-mobl2) ([10.209.63.54])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2023 08:45:35 -0700
Date:   Fri, 31 Mar 2023 08:45:33 -0700
From:   Alison Schofield <alison.schofield@intel.com>
To:     Dave Jiang <dave.jiang@intel.com>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v10 3/6] cxl/memdev: Add trigger_poison_list sysfs
 attribute
Message-ID: <ZCcAHbnGu5c46Tg4@aschofie-mobl2>
References: <cover.1679448904.git.alison.schofield@intel.com>
 <b0d0296b7001f2646c54b56ac15cda319d133097.1679448904.git.alison.schofield@intel.com>
 <6e59a3d6-0b68-2d36-d25a-652167168db8@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6e59a3d6-0b68-2d36-d25a-652167168db8@intel.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 30, 2023 at 03:55:46PM -0700, Dave Jiang wrote:
> 
> 
> On 3/21/23 7:12 PM, alison.schofield@intel.com wrote:
> > From: Alison Schofield <alison.schofield@intel.com>
> > 
> > When a boolean 'true' is written to this attribute the memdev driver
> > retrieves the poison list from the device. The list consists of
> > addresses that are poisoned, or would result in poison if accessed,
> > and the source of the poison. This attribute is only visible for
> > devices supporting the capability. The retrieved errors are logged
> > as kernel trace events with the label 'cxl_poison'.
> > 
> > Signed-off-by: Alison Schofield <alison.schofield@intel.com>
> > Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > Reviewed-by: Ira Weiny <ira.weiny@intel.com>
> > ---
> >   Documentation/ABI/testing/sysfs-bus-cxl | 14 ++++++++
> >   drivers/cxl/core/memdev.c               | 48 +++++++++++++++++++++++++
> >   drivers/cxl/cxlmem.h                    |  5 ++-
> >   drivers/cxl/mem.c                       | 36 +++++++++++++++++++
> >   4 files changed, 102 insertions(+), 1 deletion(-)
> > 

snip

> > +static int cxl_get_poison_by_memdev(struct cxl_memdev *cxlmd)
> > +{
> > +	struct cxl_dev_state *cxlds = cxlmd->cxlds;
> > +	u64 offset, length;
> > +	int rc = 0;
> > +
> > +	/* CXL 3.0 Spec 8.2.9.8.4.1 Separate pmem and ram poison requests */
> > +	if (resource_size(&cxlds->pmem_res)) {
> > +		offset = cxlds->pmem_res.start;
> > +		length = resource_size(&cxlds->pmem_res);
> > +		rc = cxl_mem_get_poison(cxlmd, offset, length, NULL);
> > +		if (rc)
> > +			return rc;
> > +	}
> > +	if (resource_size(&cxlds->ram_res)) {
> > +		offset = cxlds->ram_res.start;
> > +		length = resource_size(&cxlds->ram_res);
> > +		rc = cxl_mem_get_poison(cxlmd, offset, length, NULL);
> > +		/*
> > +		 * Invalid Physical Address is not an error for
> > +		 * volatile addresses. Device support is optional.
> > +		 */
> > +		if (rc == -EFAULT)

See this EFAULT.  That is why I changed table further down to
allow EFAULT to get through explicitly.

snip

> > @@ -130,6 +177,7 @@ static umode_t cxl_memdev_visible(struct kobject *kobj, struct attribute *a,
> >   {
> >   	if (!IS_ENABLED(CONFIG_NUMA) && a == &dev_attr_numa_node.attr)
> >   		return 0;
> > +
> 
> Stray blank line?

Yes.

> 
> >   	return a->mode;
> >   }
> > diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> > index 57a5999ddb35..5febaa3f9b04 100644
> > --- a/drivers/cxl/cxlmem.h
> > +++ b/drivers/cxl/cxlmem.h
> > @@ -145,7 +145,7 @@ struct cxl_mbox_cmd {
> >   	C(FWROLLBACK, -ENXIO, "rolled back to the previous active FW"),         \
> >   	C(FWRESET, -ENXIO, "FW failed to activate, needs cold reset"),		\
> >   	C(HANDLE, -ENXIO, "one or more Event Record Handles were invalid"),     \
> > -	C(PADDR, -ENXIO, "physical address specified is invalid"),		\
> > +	C(PADDR, -EFAULT, "physical address specified is invalid"),		\
> 
> Seems unrelated change? Does it go with previous patch?

See prior note. Need this one explicitly.

> 
snip to end.
