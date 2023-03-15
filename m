Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AC3A6BAF5B
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 12:35:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231405AbjCOLfF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 07:35:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231889AbjCOLee (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 07:34:34 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5673C75857;
        Wed, 15 Mar 2023 04:33:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678880032; x=1710416032;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=el4QWUuHMHO09Aw74RD2UQUc2eNAgoNjoLUKMEMhVYQ=;
  b=cwabQNQV5+Ba34MJSVeqgpH/g6yA3a6QW52NQkKXgUskYpgrdbo3zMO9
   4898x/RO64rRYslFFnrB12+TN1I1PJftps2n8Ifz96sSc0uiqsiwlLh5l
   QG/C1NN8H3cTdpk8cL7aS3Rnlxq2z/tB/W0S1mX4fMYCrgzNtXh58rMa8
   WLeL7+m9iZ5uPks1scQ7c6SV9zasHYA55oQOaclVsy4QNIh+IwPhiZw0Z
   2tF6SBUDrid07TGGJGfcZ/j0tpoiHyvc+Akbd+CQsGWiEQxMMdfcsPZpR
   FwwxOmDhJU3zVnxQCWzVaRqq5rejYKF3OWqSxmBPpYU0kWBEw+CiHM6nA
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10649"; a="336365039"
X-IronPort-AV: E=Sophos;i="5.98,262,1673942400"; 
   d="scan'208";a="336365039"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2023 04:32:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10649"; a="672704573"
X-IronPort-AV: E=Sophos;i="5.98,262,1673942400"; 
   d="scan'208";a="672704573"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 15 Mar 2023 04:32:45 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pcPN6-0007db-0x;
        Wed, 15 Mar 2023 11:32:44 +0000
Date:   Wed, 15 Mar 2023 19:32:10 +0800
From:   kernel test robot <lkp@intel.com>
To:     Lukasz Luba <lukasz.luba@arm.com>, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, rafael@kernel.org
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        lukasz.luba@arm.com, dietmar.eggemann@arm.com, rui.zhang@intel.com,
        amit.kucheria@verdurent.com, amit.kachhap@gmail.com,
        daniel.lezcano@linaro.org, viresh.kumar@linaro.org,
        len.brown@intel.com, pavel@ucw.cz, Pierre.Gondois@arm.com,
        ionela.voinescu@arm.com, rostedt@goodmis.org, mhiramat@kernel.org
Subject: Re: [PATCH 13/17] PM: EM: Refactor struct em_perf_domain and add
 default_table
Message-ID: <202303151927.WD6O0PWN-lkp@intel.com>
References: <20230314103357.26010-14-lukasz.luba@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230314103357.26010-14-lukasz.luba@arm.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lukasz,

I love your patch! Perhaps something to improve:

[auto build test WARNING on rafael-pm/linux-next]
[also build test WARNING on rafael-pm/thermal linus/master pavel-leds/for-next v6.3-rc2 next-20230315]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Lukasz-Luba/PM-EM-Refactor-em_cpufreq_update_efficiencies-arguments/20230314-184448
base:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git linux-next
patch link:    https://lore.kernel.org/r/20230314103357.26010-14-lukasz.luba%40arm.com
patch subject: [PATCH 13/17] PM: EM: Refactor struct em_perf_domain and add default_table
config: x86_64-randconfig-a003 (https://download.01.org/0day-ci/archive/20230315/202303151927.WD6O0PWN-lkp@intel.com/config)
compiler: clang version 14.0.6 (https://github.com/llvm/llvm-project f28c006a5895fc0e329fe15fead81e37457cb1d1)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/ce3aad5db08006a2a6b6d52f9c26b11448cd8bb4
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Lukasz-Luba/PM-EM-Refactor-em_cpufreq_update_efficiencies-arguments/20230314-184448
        git checkout ce3aad5db08006a2a6b6d52f9c26b11448cd8bb4
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash drivers/thermal/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202303151927.WD6O0PWN-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/thermal/cpufreq_cooling.c:381:24: warning: unused variable 'table' [-Wunused-variable]
           struct em_perf_state *table;
                                 ^
   1 warning generated.


vim +/table +381 drivers/thermal/cpufreq_cooling.c

   376	
   377	static unsigned int get_state_freq(struct cpufreq_cooling_device *cpufreq_cdev,
   378					   unsigned long state)
   379	{
   380		struct cpufreq_policy *policy;
 > 381		struct em_perf_state *table;
   382		unsigned long idx;
   383	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
