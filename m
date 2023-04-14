Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 560086E19E9
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 03:59:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229739AbjDNB7W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 21:59:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbjDNB7S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 21:59:18 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68F7A422B;
        Thu, 13 Apr 2023 18:59:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681437554; x=1712973554;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=24W6fHIJHtRcP3UdUj06bJT3QNFuCv4G1Dj+jqhkAKI=;
  b=b2z1yX+Buerc1LO5vrAKwFVZBTTU9AIVtIxYu9emWBgUCGapMSz5dAPP
   cPxBozYTyWBe99nNcnHlqmdc0eZmgmlGysma9KjU9UoMf1J7Xk49N00DU
   x9DYeNztM/g8cRo2yT2DjEH8wFRZfC72ySGlnJglOf4zdwdPaVuwAQ+43
   Un3CDIVPd4N8RwMSsr8kp9EvNJIzHdB19P9wPdrQ9KeKyI3MEg3IAQO8U
   j8vNRY3pfqia/O6PM7yG6oZPwbku2C90f1CK91CFrfzy5i4DJsjqZGSQ/
   boszLbuh1p7+e/RTA91IpLS+B0WXO5AqrWv9Wf5P2vrAn9DMLg+JyX1Kw
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10679"; a="343122366"
X-IronPort-AV: E=Sophos;i="5.99,195,1677571200"; 
   d="scan'208";a="343122366"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2023 18:59:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10679"; a="864025103"
X-IronPort-AV: E=Sophos;i="5.99,195,1677571200"; 
   d="scan'208";a="864025103"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 13 Apr 2023 18:59:10 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pn8iT-000Z7b-2a;
        Fri, 14 Apr 2023 01:59:09 +0000
Date:   Fri, 14 Apr 2023 09:58:59 +0800
From:   kernel test robot <lkp@intel.com>
To:     Mario Limonciello <mario.limonciello@amd.com>,
        Box David E <david.e.box@intel.com>, jstultz@google.com,
        pavel@ucw.cz, svenva@chromium.org,
        Rajneesh Bhardwaj <irenic.rajneesh@gmail.com>
Cc:     oe-kbuild-all@lists.linux.dev, Shyam-sundar.S-k@amd.com,
        rrangel@chromium.org, Jain Rajat <rajatja@google.com>,
        hdegoede@redhat.com, Mario Limonciello <mario.limonciello@amd.com>,
        Mark Gross <markgross@kernel.org>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 4/4] platform/x86/intel/pmc: core: Report duration of
 time in HW sleep state
Message-ID: <202304140957.hkvWzLzM-lkp@intel.com>
References: <20230412194917.7164-5-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230412194917.7164-5-mario.limonciello@amd.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mario,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 09a9639e56c01c7a00d6c0ca63f4c7c41abe075d]

url:    https://github.com/intel-lab-lkp/linux/commits/Mario-Limonciello/PM-Add-sysfs-files-to-represent-time-spent-in-hardware-sleep-state/20230413-035220
base:   09a9639e56c01c7a00d6c0ca63f4c7c41abe075d
patch link:    https://lore.kernel.org/r/20230412194917.7164-5-mario.limonciello%40amd.com
patch subject: [PATCH v8 4/4] platform/x86/intel/pmc: core: Report duration of time in HW sleep state
config: i386-randconfig-a001 (https://download.01.org/0day-ci/archive/20230414/202304140957.hkvWzLzM-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-8) 11.3.0
reproduce (this is a W=1 build):
        # https://github.com/intel-lab-lkp/linux/commit/315b1dd23cbedfd2848c8ac8ec1f77c3610b955e
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Mario-Limonciello/PM-Add-sysfs-files-to-represent-time-spent-in-hardware-sleep-state/20230413-035220
        git checkout 315b1dd23cbedfd2848c8ac8ec1f77c3610b955e
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=i386 olddefconfig
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash drivers/platform/x86/intel/pmc/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202304140957.hkvWzLzM-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/platform/x86/intel/pmc/core.c: In function 'pmc_core_probe':
>> drivers/platform/x86/intel/pmc/core.c:1156:38: warning: left shift count >= width of type [-Wshift-count-overflow]
    1156 |         pm_report_max_hw_sleep(((1UL << 32) - 1) * pmc_core_adjust_slp_s0_step(pmcdev, 1));
         |                                      ^~


vim +1156 drivers/platform/x86/intel/pmc/core.c

  1097	
  1098	static int pmc_core_probe(struct platform_device *pdev)
  1099	{
  1100		static bool device_initialized;
  1101		struct pmc_dev *pmcdev;
  1102		const struct x86_cpu_id *cpu_id;
  1103		void (*core_init)(struct pmc_dev *pmcdev);
  1104		u64 slp_s0_addr;
  1105	
  1106		if (device_initialized)
  1107			return -ENODEV;
  1108	
  1109		pmcdev = devm_kzalloc(&pdev->dev, sizeof(*pmcdev), GFP_KERNEL);
  1110		if (!pmcdev)
  1111			return -ENOMEM;
  1112	
  1113		platform_set_drvdata(pdev, pmcdev);
  1114		pmcdev->pdev = pdev;
  1115	
  1116		cpu_id = x86_match_cpu(intel_pmc_core_ids);
  1117		if (!cpu_id)
  1118			return -ENODEV;
  1119	
  1120		core_init = (void  (*)(struct pmc_dev *))cpu_id->driver_data;
  1121	
  1122		/*
  1123		 * Coffee Lake has CPU ID of Kaby Lake and Cannon Lake PCH. So here
  1124		 * Sunrisepoint PCH regmap can't be used. Use Cannon Lake PCH regmap
  1125		 * in this case.
  1126		 */
  1127		if (core_init == spt_core_init && !pci_dev_present(pmc_pci_ids))
  1128			core_init = cnp_core_init;
  1129	
  1130		mutex_init(&pmcdev->lock);
  1131		core_init(pmcdev);
  1132	
  1133	
  1134		if (lpit_read_residency_count_address(&slp_s0_addr)) {
  1135			pmcdev->base_addr = PMC_BASE_ADDR_DEFAULT;
  1136	
  1137			if (page_is_ram(PHYS_PFN(pmcdev->base_addr)))
  1138				return -ENODEV;
  1139		} else {
  1140			pmcdev->base_addr = slp_s0_addr - pmcdev->map->slp_s0_offset;
  1141		}
  1142	
  1143		pmcdev->regbase = ioremap(pmcdev->base_addr,
  1144					  pmcdev->map->regmap_length);
  1145		if (!pmcdev->regbase)
  1146			return -ENOMEM;
  1147	
  1148		if (pmcdev->core_configure)
  1149			pmcdev->core_configure(pmcdev);
  1150	
  1151		pmcdev->pmc_xram_read_bit = pmc_core_check_read_lock_bit(pmcdev);
  1152		pmc_core_get_low_power_modes(pdev);
  1153		pmc_core_do_dmi_quirks(pmcdev);
  1154	
  1155		pmc_core_dbgfs_register(pmcdev);
> 1156		pm_report_max_hw_sleep(((1UL << 32) - 1) * pmc_core_adjust_slp_s0_step(pmcdev, 1));
  1157	
  1158		device_initialized = true;
  1159		dev_info(&pdev->dev, " initialized\n");
  1160	
  1161		return 0;
  1162	}
  1163	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
