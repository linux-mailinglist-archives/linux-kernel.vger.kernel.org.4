Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CF126B33B7
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 02:36:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229922AbjCJBgy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 20:36:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229706AbjCJBgv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 20:36:51 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFF4AE487F;
        Thu,  9 Mar 2023 17:36:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678412209; x=1709948209;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Z8WEPEBvcsSYGpL3dfPVY08NGxsidG3XT6+r94Jo1R4=;
  b=a15yVvqT/pTdIR14D/O8eU+q5Dl+i9MC9/vUn9bGvi10WOer3KY4a1nB
   biVVYnAp5+7gCQA1Uwou2B4j0fMLCZYnW+JUA+Bt76XXB7+z9P3q1rs8W
   ylUowo3cvBfdR8s5KPa6iS99GlZF+ZA6S66UP59y9BiFfosUB8qDxqsoJ
   lfRoq2XEonPXO6vqglo3WFBl0EUQsPRSGC7X6tITCQ79ZUVc6d0ey9jOI
   LYqhkkTHq/x69fbnX3Jsbz66bucFe9R1WJ+EyNJGdABp8Wt9ZlQmUHOrL
   CwSdUtIMw6Mwp2WaGXAbUWQXwFCbdbpkClJCMpYcdkIlxo8bjTqTsZZmE
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10644"; a="324970315"
X-IronPort-AV: E=Sophos;i="5.98,248,1673942400"; 
   d="scan'208";a="324970315"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2023 17:36:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10644"; a="670926283"
X-IronPort-AV: E=Sophos;i="5.98,248,1673942400"; 
   d="scan'208";a="670926283"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 09 Mar 2023 17:36:46 -0800
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1paRgb-0003Ln-2I;
        Fri, 10 Mar 2023 01:36:45 +0000
Date:   Fri, 10 Mar 2023 09:36:18 +0800
From:   kernel test robot <lkp@intel.com>
To:     Sebastian Reichel <sre@kernel.org>
Cc:     oe-kbuild-all@lists.linux.dev,
        Linus Walleij <linus.walleij@linaro.org>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Matti Vaittinen <mazziesaccount@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCHv1 02/11] power: supply: core: auto-exposure of
 simple-battery data
Message-ID: <202303100854.V2YFWYZu-lkp@intel.com>
References: <20230309225041.477440-3-sre@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230309225041.477440-3-sre@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sebastian,

I love your patch! Perhaps something to improve:

[auto build test WARNING on sre-power-supply/for-next]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Sebastian-Reichel/dt-bindings-power-supply-adc-battery-add-binding/20230310-065229
base:   https://git.kernel.org/pub/scm/linux/kernel/git/sre/linux-power-supply.git for-next
patch link:    https://lore.kernel.org/r/20230309225041.477440-3-sre%40kernel.org
patch subject: [PATCHv1 02/11] power: supply: core: auto-exposure of simple-battery data
config: x86_64-allyesconfig (https://download.01.org/0day-ci/archive/20230310/202303100854.V2YFWYZu-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-8) 11.3.0
reproduce (this is a W=1 build):
        # https://github.com/intel-lab-lkp/linux/commit/83ec4c841d68a66bc95f5e534a805e765785f934
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Sebastian-Reichel/dt-bindings-power-supply-adc-battery-add-binding/20230310-065229
        git checkout 83ec4c841d68a66bc95f5e534a805e765785f934
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=x86_64 olddefconfig
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash drivers/power/supply/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202303100854.V2YFWYZu-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from drivers/power/supply/power_supply_core.c:21:
>> include/linux/power_supply.h:777:41: warning: 'power_supply_battery_info_properties' defined but not used [-Wunused-const-variable=]
     777 | static const enum power_supply_property power_supply_battery_info_properties[] = {
         |                                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


vim +/power_supply_battery_info_properties +777 include/linux/power_supply.h

   776	
 > 777	static const enum power_supply_property power_supply_battery_info_properties[] = {
   778		POWER_SUPPLY_PROP_TECHNOLOGY,
   779		POWER_SUPPLY_PROP_ENERGY_FULL_DESIGN,
   780		POWER_SUPPLY_PROP_CHARGE_FULL_DESIGN,
   781		POWER_SUPPLY_PROP_VOLTAGE_MIN_DESIGN,
   782		POWER_SUPPLY_PROP_VOLTAGE_MAX_DESIGN,
   783		POWER_SUPPLY_PROP_PRECHARGE_CURRENT,
   784		POWER_SUPPLY_PROP_CHARGE_TERM_CURRENT,
   785		POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT_MAX,
   786		POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE_MAX,
   787		POWER_SUPPLY_PROP_TEMP_AMBIENT_ALERT_MIN,
   788		POWER_SUPPLY_PROP_TEMP_AMBIENT_ALERT_MAX,
   789		POWER_SUPPLY_PROP_TEMP_ALERT_MIN,
   790		POWER_SUPPLY_PROP_TEMP_ALERT_MAX,
   791		POWER_SUPPLY_PROP_TEMP_MIN,
   792		POWER_SUPPLY_PROP_TEMP_MAX,
   793	};
   794	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
