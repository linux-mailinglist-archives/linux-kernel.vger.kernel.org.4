Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7422701B84
	for <lists+linux-kernel@lfdr.de>; Sun, 14 May 2023 06:29:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231664AbjENE3a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 May 2023 00:29:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjENE31 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 May 2023 00:29:27 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CD0E1BCF;
        Sat, 13 May 2023 21:29:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684038565; x=1715574565;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=vMQva3pTlSExbdM0d9uf24IiN+CfddvAn6rg4NC6ukQ=;
  b=Emo1W+EoZSibVyqLtV7UYHFnOnbMweeiH9OA9S/k4dBiYvn44kpLvaZc
   ND38TAV5AsLiWN7t1vTU/hesgCAqWK0bXSa/3T9kXER8TLPmwVmrvsP0V
   qbMUn16loFT23E84M2mDWESAuv2w0z65G60wQM8NonCZxrnlXyin79vvk
   L7yO3rCIbVbAqDa9v6w0bukkGIHFj49YEvDaTWuOp/PwF4LWez2+T1hVN
   mEwFhTFYVoOK34MpWv6uB56J971mhPsgohHRHHAW5azqqtnZP/v9VRLF7
   F2RMMX+F574qLvsVvzW7ccFr/KEK9JyzcOT/qtR8Q/KLIOpHHhyw2sYcf
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10709"; a="354157776"
X-IronPort-AV: E=Sophos;i="5.99,273,1677571200"; 
   d="scan'208";a="354157776"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2023 21:29:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10709"; a="703585362"
X-IronPort-AV: E=Sophos;i="5.99,273,1677571200"; 
   d="scan'208";a="703585362"
Received: from lkp-server01.sh.intel.com (HELO dea6d5a4f140) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 13 May 2023 21:29:21 -0700
Received: from kbuild by dea6d5a4f140 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1py3MG-0005pC-1A;
        Sun, 14 May 2023 04:29:20 +0000
Date:   Sun, 14 May 2023 12:28:23 +0800
From:   kernel test robot <lkp@intel.com>
To:     Lukasz Luba <lukasz.luba@arm.com>, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, rafael@kernel.org
Cc:     oe-kbuild-all@lists.linux.dev, lukasz.luba@arm.com,
        dietmar.eggemann@arm.com, rui.zhang@intel.com,
        amit.kucheria@verdurent.com, amit.kachhap@gmail.com,
        daniel.lezcano@linaro.org, viresh.kumar@linaro.org,
        len.brown@intel.com, pavel@ucw.cz, Pierre.Gondois@arm.com,
        ionela.voinescu@arm.com, rostedt@goodmis.org, mhiramat@kernel.org
Subject: Re: [PATCH v2 08/17] PM: EM: Introduce runtime modifiable table
Message-ID: <202305141200.aaTHzYOJ-lkp@intel.com>
References: <20230512095743.3393563-9-lukasz.luba@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230512095743.3393563-9-lukasz.luba@arm.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lukasz,

kernel test robot noticed the following build warnings:

[auto build test WARNING on rafael-pm/linux-next]
[also build test WARNING on rafael-pm/thermal linus/master]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Lukasz-Luba/PM-EM-Refactor-em_cpufreq_update_efficiencies-arguments/20230512-180158
base:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git linux-next
patch link:    https://lore.kernel.org/r/20230512095743.3393563-9-lukasz.luba%40arm.com
patch subject: [PATCH v2 08/17] PM: EM: Introduce runtime modifiable table
config: arm64-randconfig-s041-20230514 (https://download.01.org/0day-ci/archive/20230514/202305141200.aaTHzYOJ-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 12.1.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-39-gce1a6720-dirty
        # https://github.com/intel-lab-lkp/linux/commit/d12d8d1010d7b093d6b64c204d77484d6fc268ab
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Lukasz-Luba/PM-EM-Refactor-em_cpufreq_update_efficiencies-arguments/20230512-180158
        git checkout d12d8d1010d7b093d6b64c204d77484d6fc268ab
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=arm64 olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=arm64 SHELL=/bin/bash kernel/power/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202305141200.aaTHzYOJ-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> kernel/power/energy_model.c:472:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct em_perf_table *tmp @@     got struct em_perf_table [noderef] __rcu *runtime_table @@
   kernel/power/energy_model.c:472:13: sparse:     expected struct em_perf_table *tmp
   kernel/power/energy_model.c:472:13: sparse:     got struct em_perf_table [noderef] __rcu *runtime_table

vim +472 kernel/power/energy_model.c

   444	
   445	/**
   446	 * em_dev_unregister_perf_domain() - Unregister Energy Model (EM) for a device
   447	 * @dev		: Device for which the EM is registered
   448	 *
   449	 * Unregister the EM for the specified @dev (but not a CPU device).
   450	 */
   451	void em_dev_unregister_perf_domain(struct device *dev)
   452	{
   453		struct em_perf_domain *pd;
   454		struct em_perf_table *tmp;
   455	
   456		if (IS_ERR_OR_NULL(dev) || !dev->em_pd)
   457			return;
   458	
   459		if (_is_cpu_device(dev))
   460			return;
   461	
   462		pd = dev->em_pd;
   463		/*
   464		 * The mutex separates all register/unregister requests and protects
   465		 * from potential clean-up/setup issues in the debugfs directories.
   466		 * The debugfs directory name is the same as device's name.
   467		 */
   468		mutex_lock(&em_pd_mutex);
   469	
   470		em_debug_remove_pd(dev);
   471	
 > 472		tmp = pd->runtime_table;

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
