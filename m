Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19497739D8A
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 11:37:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232457AbjFVJhD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 05:37:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231777AbjFVJgN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 05:36:13 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 683501995;
        Thu, 22 Jun 2023 02:29:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687426180; x=1718962180;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=mVEis/WqWWY+Y0u9TfS2GzXtVSmOeIPHMKAdIbtLulg=;
  b=RHom6d0pcOuEqSpltwSzCoOXRUjGVXwj0bWfTw3klfut408xA09pZHfn
   xTiD4plq3jKd1I+eJdEta7k/k3kuLNWyx0pMi7ZVB7h514hRNGMZkjM4P
   HAcVnpKCRjKvrZXvzDtYNDBMeYiFIp7ziiFtSMd9HVC9/pfZSiCuM6JkT
   pGw3Ztib8I1ShubXkNceIRBJ9SQ/z2P7rl0gO+UWFKUO6jhbsnlBCP0q+
   qO6/FEvhbfbRNEL6Frb5sNdJlUyXqD6/oVy3Xh340xZxiijiSAb+OwoBJ
   DYN1JOok21/nTAEC/c4Gnv6Xrnb8JqT8fWzgUXHJbpTUbbRD8Eu3GvRgf
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10748"; a="390124941"
X-IronPort-AV: E=Sophos;i="6.00,263,1681196400"; 
   d="scan'208";a="390124941"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2023 02:29:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10748"; a="718010339"
X-IronPort-AV: E=Sophos;i="6.00,263,1681196400"; 
   d="scan'208";a="718010339"
Received: from lkp-server01.sh.intel.com (HELO 783282924a45) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 22 Jun 2023 02:29:35 -0700
Received: from kbuild by 783282924a45 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qCGdC-0007Tz-2q;
        Thu, 22 Jun 2023 09:29:34 +0000
Date:   Thu, 22 Jun 2023 17:29:07 +0800
From:   kernel test robot <lkp@intel.com>
To:     Benjamin Bara <bbara93@gmail.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Benjamin Bara <benjamin.bara@skidata.com>
Cc:     oe-kbuild-all@lists.linux.dev,
        Alexander Stein <alexander.stein@ew.tq-group.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v5 1/3] usb: misc: onboard-hub: support multiple power
 supplies
Message-ID: <202306221742.xnLvAlnW-lkp@intel.com>
References: <20230620-hx3-v5-1-319c9c4c846f@skidata.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230620-hx3-v5-1-319c9c4c846f@skidata.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Benjamin,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 45a3e24f65e90a047bef86f927ebdc4c710edaa1]

url:    https://github.com/intel-lab-lkp/linux/commits/Benjamin-Bara/usb-misc-onboard-hub-support-multiple-power-supplies/20230622-161859
base:   45a3e24f65e90a047bef86f927ebdc4c710edaa1
patch link:    https://lore.kernel.org/r/20230620-hx3-v5-1-319c9c4c846f%40skidata.com
patch subject: [PATCH v5 1/3] usb: misc: onboard-hub: support multiple power supplies
config: alpha-allyesconfig (https://download.01.org/0day-ci/archive/20230622/202306221742.xnLvAlnW-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 12.3.0
reproduce: (https://download.01.org/0day-ci/archive/20230622/202306221742.xnLvAlnW-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202306221742.xnLvAlnW-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/usb/misc/onboard_usb_hub.c: In function 'onboard_hub_probe':
>> drivers/usb/misc/onboard_usb_hub.c:262:58: warning: format '%d' expects argument of type 'int', but argument 4 has type 'long unsigned int' [-Wformat=]
     262 |                 return dev_err_probe(dev, -EINVAL, "max %d supplies supported!\n",
         |                                                         ~^
         |                                                          |
         |                                                          int
         |                                                         %ld


vim +262 drivers/usb/misc/onboard_usb_hub.c

   240	
   241	static int onboard_hub_probe(struct platform_device *pdev)
   242	{
   243		const struct of_device_id *of_id;
   244		struct device *dev = &pdev->dev;
   245		struct onboard_hub *hub;
   246		unsigned int i;
   247		int err;
   248	
   249		hub = devm_kzalloc(dev, sizeof(*hub), GFP_KERNEL);
   250		if (!hub)
   251			return -ENOMEM;
   252	
   253		of_id = of_match_device(onboard_hub_match, &pdev->dev);
   254		if (!of_id)
   255			return -ENODEV;
   256	
   257		hub->pdata = of_id->data;
   258		if (!hub->pdata)
   259			return -EINVAL;
   260	
   261		if (hub->pdata->num_supplies > MAX_SUPPLIES)
 > 262			return dev_err_probe(dev, -EINVAL, "max %d supplies supported!\n",
   263					     MAX_SUPPLIES);
   264	
   265		for (i = 0; i < hub->pdata->num_supplies; i++)
   266			hub->supplies[i].supply = supply_names[i];
   267	
   268		err = devm_regulator_bulk_get(dev, hub->pdata->num_supplies, hub->supplies);
   269		if (err) {
   270			dev_err(dev, "Failed to get regulator supplies: %d\n", err);
   271			return err;
   272		}
   273	
   274		hub->reset_gpio = devm_gpiod_get_optional(dev, "reset",
   275							  GPIOD_OUT_HIGH);
   276		if (IS_ERR(hub->reset_gpio))
   277			return dev_err_probe(dev, PTR_ERR(hub->reset_gpio), "failed to get reset GPIO\n");
   278	
   279		hub->dev = dev;
   280		mutex_init(&hub->lock);
   281		INIT_LIST_HEAD(&hub->udev_list);
   282	
   283		dev_set_drvdata(dev, hub);
   284	
   285		err = onboard_hub_power_on(hub);
   286		if (err)
   287			return err;
   288	
   289		/*
   290		 * The USB driver might have been detached from the USB devices by
   291		 * onboard_hub_remove() (e.g. through an 'unbind' by userspace),
   292		 * make sure to re-attach it if needed.
   293		 *
   294		 * This needs to be done deferred to avoid self-deadlocks on systems
   295		 * with nested onboard hubs.
   296		 */
   297		schedule_work(&attach_usb_driver_work);
   298	
   299		return 0;
   300	}
   301	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
