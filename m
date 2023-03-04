Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65BA66AAAC7
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Mar 2023 16:35:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229622AbjCDPfY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Mar 2023 10:35:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjCDPfW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Mar 2023 10:35:22 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 603E313D6E;
        Sat,  4 Mar 2023 07:35:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677944121; x=1709480121;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=cJlmuGUZxNOAw/hV8pBizD2WZB0epT5sT+vGv5l/brU=;
  b=nC0sdAZUn0vtnrxW1qK46u//WW5lMlLAcdDy7W1lvM/3qggcC+9oB5dO
   geJ8F0R1ogCcqNcSDGqwyPoAxWLb0PJncjdAWSkkajNqG0cLdoawUZ4Cg
   OIe16+4PHrZ9rZlmLDTKZ7Z8WoY17+0x3VJfJQBSpoCeyTlpPncDIDmEd
   w7nfngqm2w3GE28LHDnqEC+slxODL3bhNlljIEkxwrw+kCLtMPuwUROFP
   DgS3fT9dRHpvoVICAhr8I6ZqFRZ3mMovS/H4AitBh/pahOfyFZFVX7lZ8
   S7U/JA9EFqwu1BthmbSRnMPRCMa77QtICokUbTCNqeqQiDTUlnhF0GHM6
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10639"; a="421544779"
X-IronPort-AV: E=Sophos;i="5.98,233,1673942400"; 
   d="scan'208";a="421544779"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2023 07:35:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10639"; a="1004908616"
X-IronPort-AV: E=Sophos;i="5.98,233,1673942400"; 
   d="scan'208";a="1004908616"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by fmsmga005.fm.intel.com with ESMTP; 04 Mar 2023 07:35:19 -0800
Date:   Sat, 4 Mar 2023 23:24:12 +0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     Marco Pagani <marpagan@redhat.com>
Cc:     linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 2/4] fpga: add fake FPGA region
Message-ID: <ZANinDPnETI9TDe6@yilunxu-OptiPlex-7050>
References: <20230203170653.414990-1-marpagan@redhat.com>
 <20230203170653.414990-3-marpagan@redhat.com>
 <Y/Ckw+F/sb2er2oK@yilunxu-OptiPlex-7050>
 <3f17060a-69ce-fb39-61ab-a892b9a1e8c6@redhat.com>
 <Y/hlUOy26HBfdJFR@yilunxu-OptiPlex-7050>
 <98baa5ba-1254-86e5-de9b-ef1a03912a55@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <98baa5ba-1254-86e5-de9b-ef1a03912a55@redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-03-01 at 11:51:44 +0100, Marco Pagani wrote:
> 
> 
> On 2023-02-24 08:20, Xu Yilun wrote:
> > On 2023-02-21 at 15:53:20 +0100, Marco Pagani wrote:
> >>
> >>
> >> On 2023-02-18 11:13, Xu Yilun wrote:
> >>> On 2023-02-03 at 18:06:51 +0100, Marco Pagani wrote:
> >>>> Add fake FPGA region platform driver with support functions. This
> >>>> module is part of the KUnit test suite for the FPGA subsystem.
> >>>>
> >>>> Signed-off-by: Marco Pagani <marpagan@redhat.com>
> >>>> ---
> >>>>  drivers/fpga/tests/fake-fpga-region.c | 186 ++++++++++++++++++++++++++
> >>>>  drivers/fpga/tests/fake-fpga-region.h |  37 +++++
> >>>>  2 files changed, 223 insertions(+)
> >>>>  create mode 100644 drivers/fpga/tests/fake-fpga-region.c
> >>>>  create mode 100644 drivers/fpga/tests/fake-fpga-region.h
> >>>>
> >>>> diff --git a/drivers/fpga/tests/fake-fpga-region.c b/drivers/fpga/tests/fake-fpga-region.c
> >>>> new file mode 100644
> >>>> index 000000000000..095397e41837
> >>>> --- /dev/null
> >>>> +++ b/drivers/fpga/tests/fake-fpga-region.c
> >>>> @@ -0,0 +1,186 @@
> >>>> +// SPDX-License-Identifier: GPL-2.0
> >>>> +/*
> >>>> + * Driver for fake FPGA region
> >>>> + *
> >>>> + * Copyright (C) 2023 Red Hat, Inc. All rights reserved.
> >>>> + *
> >>>> + * Author: Marco Pagani <marpagan@redhat.com>
> >>>> + */
> >>>> +
> >>>> +#include <linux/device.h>
> >>>> +#include <linux/platform_device.h>
> >>>> +#include <linux/fpga/fpga-mgr.h>
> >>>> +#include <linux/fpga/fpga-region.h>
> >>>> +#include <linux/fpga/fpga-bridge.h>
> >>>> +#include <kunit/test.h>
> >>>> +
> >>>> +#include "fake-fpga-region.h"
> >>>> +
> >>>> +#define FAKE_FPGA_REGION_DEV_NAME	"fake_fpga_region"
> >>>> +
> >>>> +struct fake_region_priv {
> >>>> +	int id;
> >>>> +	struct kunit *test;
> >>>> +};
> >>>> +
> >>>> +struct fake_region_data {
> >>>> +	struct fpga_manager *mgr;
> >>>> +	struct kunit *test;
> >>>> +};
> >>>> +
> >>>> +/**
> >>>> + * fake_fpga_region_register - register a fake FPGA region
> >>>> + * @region_ctx: fake FPGA region context data structure.
> >>>> + * @test: KUnit test context object.
> >>>> + *
> >>>> + * Return: 0 if registration succeeded, an error code otherwise.
> >>>> + */
> >>>> +int fake_fpga_region_register(struct fake_fpga_region *region_ctx,
> >>>> +			      struct fpga_manager *mgr, struct kunit *test)
> >>>> +{
> >>>> +	struct fake_region_data pdata;
> >>>> +	struct fake_region_priv *priv;
> >>>> +	int ret;
> >>>> +
> >>>> +	pdata.mgr = mgr;
> >>>> +	pdata.test = test;
> >>>> +
> >>>> +	region_ctx->pdev = platform_device_alloc(FAKE_FPGA_REGION_DEV_NAME,
> >>>> +						 PLATFORM_DEVID_AUTO);
> >>>> +	if (IS_ERR(region_ctx->pdev)) {
> >>>> +		pr_err("Fake FPGA region device allocation failed\n");
> >>>> +		return -ENOMEM;
> >>>> +	}
> >>>> +
> >>>> +	platform_device_add_data(region_ctx->pdev, &pdata, sizeof(pdata));
> >>>> +
> >>>> +	ret = platform_device_add(region_ctx->pdev);
> >>>> +	if (ret) {
> >>>> +		pr_err("Fake FPGA region device add failed\n");
> >>>> +		platform_device_put(region_ctx->pdev);
> >>>> +		return ret;
> >>>> +	}
> >>>> +
> >>>> +	region_ctx->region = platform_get_drvdata(region_ctx->pdev);
> >>>> +
> >>>> +	if (test) {
> >>>> +		priv = region_ctx->region->priv;
> >>>> +		kunit_info(test, "Fake FPGA region %d registered\n", priv->id);
> >>>> +	}
> >>>> +
> >>>> +	return 0;
> >>>> +}
> >>>> +EXPORT_SYMBOL_GPL(fake_fpga_region_register);
> >>>> +
> >>>> +/**
> >>>> + * fake_fpga_region_unregister - unregister a fake FPGA region
> >>>> + * @region_ctx: fake FPGA region context data structure.
> >>>> + */
> >>>> +void fake_fpga_region_unregister(struct fake_fpga_region *region_ctx)
> >>>> +{
> >>>> +	struct fake_region_priv *priv;
> >>>> +	struct kunit *test;
> >>>> +	int id;
> >>>> +
> >>>> +	priv = region_ctx->region->priv;
> >>>> +	test = priv->test;
> >>>> +	id = priv->id;
> >>>> +
> >>>> +	if (region_ctx->pdev) {
> >>>> +		platform_device_unregister(region_ctx->pdev);
> >>>> +		if (test)
> >>>> +			kunit_info(test, "Fake FPGA region %d unregistered\n", id);
> >>>> +	}
> >>>> +}
> >>>> +EXPORT_SYMBOL_GPL(fake_fpga_region_unregister);
> >>>> +
> >>>> +/**
> >>>> + * fake_fpga_region_add_bridge - add a bridge to a fake FPGA region
> >>>> + * @region_ctx: fake FPGA region context data structure.
> >>>> + * @bridge: FPGA bridge.
> >>>> + *
> >>>> + * Return: 0 if registration succeeded, an error code otherwise.
> >>>> + */
> >>>> +int fake_fpga_region_add_bridge(struct fake_fpga_region *region_ctx,
> >>>> +				struct fpga_bridge *bridge)
> >>>> +{
> >>>> +	struct fake_region_priv *priv;
> >>>> +	int ret;
> >>>> +
> >>>> +	priv = region_ctx->region->priv;
> >>>> +
> >>>> +	ret = fpga_bridge_get_to_list(bridge->dev.parent, NULL,
> >>>> +				      &region_ctx->region->bridge_list);
> >>>> +
> >>>> +	if (priv->test && !ret)
> >>>> +		kunit_info(priv->test, "Bridge added to fake FPGA region %d\n",
> >>>> +			   priv->id);
> >>>> +
> >>>> +	return ret;
> >>>> +}
> >>>> +EXPORT_SYMBOL_GPL(fake_fpga_region_add_bridge);
> >>>> +
> >>>> +static int fake_fpga_region_probe(struct platform_device *pdev)
> >>>> +{
> >>>> +	struct device *dev;
> >>>> +	struct fpga_region *region;
> >>>> +	struct fpga_manager *mgr;
> >>>> +	struct fake_region_data *pdata;
> >>>> +	struct fake_region_priv *priv;
> >>>> +	static int id_count;
> >>>> +
> >>>> +	dev = &pdev->dev;
> >>>> +	pdata = dev_get_platdata(dev);
> >>>> +
> >>>> +	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
> >>>> +	if (!priv)
> >>>> +		return -ENOMEM;
> >>>> +
> >>>> +	mgr = fpga_mgr_get(pdata->mgr->dev.parent);
> >>>> +	if (IS_ERR(mgr))
> >>>> +		return PTR_ERR(mgr);
> >>>> +
> >>>> +	/*
> >>>> +	 * No get_bridges() method since the bridges list is
> >>>> +	 * pre-built using fake_fpga_region_add_bridge()
> >>>> +	 */
> >>>
> >>> This is not the common use for drivers to associate the region & bridge,
> >>> Better to realize the get_bridges() method.
> >>
> >> Initially, I was using a get_bridges() method to create the list of bridges
> >> before each reconfiguration. However, this required having a "duplicated"
> >> list of bridges in the context of the fake region low-level driver.
> >>
> >> Since I couldn't find a reason to keep a duplicate list of bridges in the
> >> fake region driver, I decided then to change the approach and build the
> >> list of bridges at device instantiation time.
> >>
> >> In my understanding, the approach of creating the list of bridges just
> >> before reconfiguration with a get_bridges() method works best for the
> >> OF case, where the topology is already encoded in the DT. I feel using
> >> this approach on platforms without OF support would increase complexity
> >> and create unnecessary duplication.
> > 
> > I'm not fully get your point. My understanding is we don't have to
> > always grab the bridge driver module if we don't reprogram. In many
> > cases, we just work with the existing bitstream before Linux is started.
> > So generally I prefer not to have an example that gets all bridges at
> > initialization unless there is a real need.
> 
> The fake region can be used without bridges to model the scenario where
> the FPGA is statically configured by the bootloader.
> 
> I was referring to the choice between building the bridge list of the
> region (fpga_region->bridge_list) ahead of programming vs. just before
> programming.
> 
> Currently, fake_fpga_region_add_bridge() attaches the bridge directly
> to the bridge_list of the fpga_region struct.
> 
> Alternatively, I could change fake_fpga_region_add_bridge() to attach
> the bridge to a secondary list in the low-level driver. The secondary
> list would then be copied to the fpga_region->bridge_list by a
> get_bridges() method just before programming.

I prefer to attach bridges just before programming in the test, as this
is the logic for fpga region core and all fpga drivers now. It is better
the first few tests covers the normal workflow.

Thanks,
Yilun

> 
> However, I feel that using this approach would make test code more
> complicated than necessary. Ideally, I would like to keep fake modules
> as simple as possible.
> 
> 
> Thanks,
> Marco
> 
