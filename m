Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B51CD62EA18
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 01:15:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235091AbiKRAPl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 19:15:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234063AbiKRAPi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 19:15:38 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CD3D3F055;
        Thu, 17 Nov 2022 16:15:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668730537; x=1700266537;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=4D8EQNaryw9BA8CmQt73Epq0oJa7CxH/hx9+wFn8YdY=;
  b=ZXyzoAvkA+zbsErbHOyU2DAjekhLQ+zzoishi7gJ4bAbr1NPAbmphrjX
   r/+yyQ8QboAGjILirQaFRQtixqP/2co89v58HMwx/9jzHvbVyveN1dxen
   58GWJ0Ou0+/9gu3NDE8Uy4azeYZ/HqJsE/l0wW1Iqm6XzwS1vtQJj/VhW
   9h2dXIE1u1OraLTMljum3CBVhqQmSZhb56g6j/urN6k3j//3mWdSlpLQV
   VRhP8wJ0Jf2qUkbcVOIUu3u9WvGZUt2jCBRVKCndj1+azfYkQSYJUX27B
   /r+onsTBiv5ISqmUgKycN2AIsBd9XyJx8CgGFDCZ9n2FeCouHmJ8Sy9Q7
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10534"; a="375145523"
X-IronPort-AV: E=Sophos;i="5.96,172,1665471600"; 
   d="scan'208";a="375145523"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2022 16:15:37 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10534"; a="642303497"
X-IronPort-AV: E=Sophos;i="5.96,172,1665471600"; 
   d="scan'208";a="642303497"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO aschofie-mobl2) ([10.209.84.12])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2022 16:15:36 -0800
Date:   Thu, 17 Nov 2022 16:15:34 -0800
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
Subject: Re: [PATCH v3 3/6] cxl/memdev: Add trigger_poison_list sysfs
 attribute
Message-ID: <Y3bOpj/3SYUGVajf@aschofie-mobl2>
References: <cover.1668115235.git.alison.schofield@intel.com>
 <5055dd47526d900f85f43bb0d85f4ccd4c9502b6.1668115235.git.alison.schofield@intel.com>
 <20221116124855.00002f58@Huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221116124855.00002f58@Huawei.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 16, 2022 at 12:48:55PM +0000, Jonathan Cameron wrote:
> On Thu, 10 Nov 2022 19:12:41 -0800
> alison.schofield@intel.com wrote:
> 
> > From: Alison Schofield <alison.schofield@intel.com>
> > 
> > When a boolean 'true' is written to this attribute the memdev driver
> > retrieves the poison list from the device. The list includes addresses
> > that are poisoned, or would result in poison if accessed, and the
> > source of the poison. This attribute is only visible for devices
> > supporting the capability. The retrieved errors are logged as kernel
> > trace events with the label 'cxl_poison'.
> > 
> > Signed-off-by: Alison Schofield <alison.schofield@intel.com>
> Hi Alison,
> 
> A few comments inline.
> 
> Jonathan
> 
> > ---
> >  Documentation/ABI/testing/sysfs-bus-cxl | 14 +++++++++
> >  drivers/cxl/core/memdev.c               | 41 +++++++++++++++++++++++++
> >  2 files changed, 55 insertions(+)
> > 
> > diff --git a/Documentation/ABI/testing/sysfs-bus-cxl b/Documentation/ABI/testing/sysfs-bus-cxl
> > index 8494ef27e8d2..1c5f4a853ba2 100644
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
> > +		list includes addresses that are poisoned or would result in
> > +		poison if accessed, and the source of the poison. This
> 
> Trivial, but 'includes' kind of implies it might have other things as well.
> 
> The list consists of addresses that are... perhaps?
> 

Changed that to consists. Now, I will be on the lookout for other
usages of includes with unintended implications ;)


> > +		attribute is only visible for devices supporting the
> > +		capability. The retrieved errors are logged as kernel
> > +		trace events with the label 'cxl_poison'.
> > diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
> > index 20ce488a7754..06d265db5127 100644
> > --- a/drivers/cxl/core/memdev.c
> > +++ b/drivers/cxl/core/memdev.c
> > @@ -106,12 +106,45 @@ static ssize_t numa_node_show(struct device *dev, struct device_attribute *attr,
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
> > +
> > +	/* Per CXL Spec, separate the pmem and ram poison list reads */

/* Per CXL Spec 8.2.9.8.4.1 separate the pmem and ram requests */

Added this ^

> 
> Reference?  I assume this is the bit about what happens if the
> device doesn't support poison list retrieval for volatile memory?
> I can't find anything more specific but maybe I'm looking in wrong place.
> 
Section 8.2.9.8.4.1
Says this: 
The device may reject this command if the requested range spans the
device’s volatile and persistent partitions.

And this -
If the device does not support poison list for volatile ranges and
any location in the requested list maps to volatile, the device
shall return Invalid Physical Address.

And, the device only reports that it supports the Get Poison 
command, in general, not specifically for pmem or volatile.

So, we split the requests along ram and pmem boundaries.

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
> > +		if (rc)
> > +			return rc;
> 
> Hmm.  So should we handle the return of Invalid Physical Address as an
> error or not?  I think not given it's optional to support the poison
> list for volatile memory.
>
Double hmmm. It wasn't obvious what to do here. Users can look for the
events to see if anything was traced, regardless of the rc. But, if an
'rc' stopped a user from looking for results, that would be bad.

I'll go with no error return on ram failure.

> > +	}
> > +	return len;
> > +}
> > +static DEVICE_ATTR_WO(trigger_poison_list);
> > +
> >  static struct attribute *cxl_memdev_attributes[] = {
> >  	&dev_attr_serial.attr,
> >  	&dev_attr_firmware_version.attr,
> >  	&dev_attr_payload_max.attr,
> >  	&dev_attr_label_storage_size.attr,
> >  	&dev_attr_numa_node.attr,
> > +	&dev_attr_trigger_poison_list.attr,
> >  	NULL,
> >  };
> >  
> > @@ -130,6 +163,14 @@ static umode_t cxl_memdev_visible(struct kobject *kobj, struct attribute *a,
> >  {
> >  	if (!IS_ENABLED(CONFIG_NUMA) && a == &dev_attr_numa_node.attr)
> >  		return 0;
> > +
> > +	if (a == &dev_attr_trigger_poison_list.attr) {
> > +		struct device *dev = kobj_to_dev(kobj);
> > +
> > +		if (!test_bit(CXL_MEM_COMMAND_ID_GET_POISON,
> > +			      to_cxl_memdev(dev)->cxlds->enabled_cmds))
> > +			return 0;
> > +	}
> >  	return a->mode;
> >  }
> >  
> 
