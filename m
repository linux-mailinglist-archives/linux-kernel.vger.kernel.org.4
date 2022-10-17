Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACF726015DE
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 20:02:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230406AbiJQSCK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 14:02:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230364AbiJQSCH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 14:02:07 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DDC863FFB;
        Mon, 17 Oct 2022 11:02:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666029727; x=1697565727;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=uYk0ndVVX1m8lJ1xXsSeXQNj8KaTwzcRPHZ/Ix74hRI=;
  b=E5m/LTt/fXJnxQw6AcJzqFSxieiae+4ti1cl+kURbO+E6jw8/jwC3RA/
   JE+o1MYoqvrpzaiZoDV8K2GeAZQkD1Dz0rFdHRmmLESqsF8rCfKe6WzrR
   XGrAOfWBMdcQN2WLy5iH9TtHSZNMXix3VtlhbcHp820wlP2PgcpKFzr7u
   aS2LgewQfJPxgw7+V4+VDckT3uv/kSnktlT2VeLqzcqxmtytOIjveFyL6
   mWja1ez7GAqVUA0N0Z8thDWWmgm7FuHaNS9WGHLmYg5IR5oZwxhimJq+t
   RZTc87ojqBzcUQwB2Nwu4fBbAVjfH/F1t4DlYRJOJat5G5Cl1upSkRheR
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10503"; a="367901327"
X-IronPort-AV: E=Sophos;i="5.95,192,1661842800"; 
   d="scan'208";a="367901327"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2022 11:01:56 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10503"; a="770855596"
X-IronPort-AV: E=Sophos;i="5.95,192,1661842800"; 
   d="scan'208";a="770855596"
Received: from lingyaom-mobl.amr.corp.intel.com (HELO aschofie-mobl2) ([10.255.230.132])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2022 11:01:55 -0700
Date:   Mon, 17 Oct 2022 11:01:53 -0700
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
Subject: Re: [PATCH v2 4/4] cxl/region: Add trigger_poison_list sysfs
 attribute
Message-ID: <Y02YkXawtM4IK7wL@aschofie-mobl2>
References: <cover.1665606782.git.alison.schofield@intel.com>
 <b5e7787816326854b736c922f7fcf195fba71338.1665606782.git.alison.schofield@intel.com>
 <20221017144302.0000521c@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221017144302.0000521c@huawei.com>
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 17, 2022 at 02:43:02PM +0100, Jonathan Cameron wrote:
> On Wed, 12 Oct 2022 14:28:20 -0700
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
> 
> Hi Alison,
> 
> For some reason I don't have cxl_dpa_resource().
> Should that be cxl_dpa_resource_start()?

Yes.
> 
> Looks like it got renamed in
> cxl/hdm: Add support for allocating DPA to an endpoint decoder
> cf880423b6a0599499c1f83542cab0b75daa29ba

Looks like it got renamed during the patches review. Not worth
unravelling now. I will rebase in next version.

Sorry about that and thanks!
Alison

> 
> Jonathan
> 
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
> > +		offset = cxl_dpa_resource(cxled);
> > +		length = cxl_dpa_size(cxled);
> > +		rc = cxl_mem_get_poison(cxlmd, offset, length,
> > +					dev_name(&cxlr->dev));
> > +		if (rc)
> > +			return rc;
> > +	}
> > +	return len;
> > +}
> > +static DEVICE_ATTR_WO(trigger_poison_list);
