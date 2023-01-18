Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0506A67221C
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 16:51:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230501AbjARPvf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 10:51:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231287AbjARPul (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 10:50:41 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA0EB5423A;
        Wed, 18 Jan 2023 07:49:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674056941; x=1705592941;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=/S4y7oDBR7UHj4PnIE+PQukj/5U/90zDnFO+1s+hhgs=;
  b=XYiGLLwAwxgNnp5rmxYKhh+mT7NJ0dcRRB6z/IWuh5Y0CKuS8Ka3NXgp
   l+HkWwDsl918LAR5vrBDAi4vWJlKVFZ/XQFk7YC2IVzGVx89nMZdlBDGo
   I/90TBZQiYNLGIAIV1IGDl6ngdA31YM//HJVwejXTVM52tzdEDiebJiTf
   VI67Eq7zRE2i4xqDa3Hya+Jmp9lM072mjdt9L6MR0jurasZ4IB/LMAOqj
   +o1B0Ulw8w2eynrOUWK9VB7MVYNBCtNovGKhe3hhJ7ExIZrSigo12/GmU
   jQSW7eqzVdoIVVWgbNhPOmN+3m3WgMeGBxUw12FYCekZN7Oz2ULyKXNSE
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10594"; a="304694800"
X-IronPort-AV: E=Sophos;i="5.97,226,1669104000"; 
   d="scan'208";a="304694800"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2023 07:48:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10594"; a="723131293"
X-IronPort-AV: E=Sophos;i="5.97,226,1669104000"; 
   d="scan'208";a="723131293"
Received: from lkp-server01.sh.intel.com (HELO 5646d64e7320) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 18 Jan 2023 07:48:54 -0800
Received: from kbuild by 5646d64e7320 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pIAgH-0000TO-1A;
        Wed, 18 Jan 2023 15:48:53 +0000
Date:   Wed, 18 Jan 2023 23:47:58 +0800
From:   kernel test robot <lkp@intel.com>
To:     Perry Yuan <perry.yuan@amd.com>, rafael.j.wysocki@intel.com,
        Mario.Limonciello@amd.com, ray.huang@amd.com,
        viresh.kumar@linaro.org
Cc:     oe-kbuild-all@lists.linux.dev, Deepak.Sharma@amd.com,
        Nathan.Fontenot@amd.com, Alexander.Deucher@amd.com,
        Shimmer.Huang@amd.com, Xiaojian.Du@amd.com, Li.Meng@amd.com,
        wyes.karny@amd.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v11 04/11] cpufreq: amd-pstate: implement Pstate EPP
 support for the AMD processors
Message-ID: <202301182325.NoodiJ0K-lkp@intel.com>
References: <20230118075210.447418-5-perry.yuan@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230118075210.447418-5-perry.yuan@amd.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Perry,

I love your patch! Perhaps something to improve:

[auto build test WARNING on rafael-pm/linux-next]
[also build test WARNING on linus/master v6.2-rc4 next-20230118]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Perry-Yuan/ACPI-CPPC-Add-AMD-pstate-energy-performance-preference-cppc-control/20230118-163633
base:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git linux-next
patch link:    https://lore.kernel.org/r/20230118075210.447418-5-perry.yuan%40amd.com
patch subject: [PATCH v11 04/11] cpufreq: amd-pstate: implement Pstate EPP support for the AMD processors
config: x86_64-randconfig-a013-20230116 (https://download.01.org/0day-ci/archive/20230118/202301182325.NoodiJ0K-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-8) 11.3.0
reproduce (this is a W=1 build):
        # https://github.com/intel-lab-lkp/linux/commit/d596b3586a809f4f6b65ec216c168b6f01c82f67
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Perry-Yuan/ACPI-CPPC-Add-AMD-pstate-energy-performance-preference-cppc-control/20230118-163633
        git checkout d596b3586a809f4f6b65ec216c168b6f01c82f67
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=x86_64 olddefconfig
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash drivers/cpufreq/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from drivers/cpufreq/amd-pstate-ut.c:29:
>> include/linux/amd-pstate.h:142:21: warning: 'epp_values' defined but not used [-Wunused-variable]
     142 | static unsigned int epp_values[] = {
         |                     ^~~~~~~~~~
>> include/linux/amd-pstate.h:133:27: warning: 'energy_perf_strings' defined but not used [-Wunused-const-variable=]
     133 | static const char * const energy_perf_strings[] = {
         |                           ^~~~~~~~~~~~~~~~~~~
   include/linux/amd-pstate.h:97:27: warning: 'amd_pstate_mode_string' defined but not used [-Wunused-const-variable=]
      97 | static const char * const amd_pstate_mode_string[] = {
         |                           ^~~~~~~~~~~~~~~~~~~~~~


vim +/epp_values +142 include/linux/amd-pstate.h

   132	
 > 133	static const char * const energy_perf_strings[] = {
   134		[EPP_INDEX_DEFAULT] = "default",
   135		[EPP_INDEX_PERFORMANCE] = "performance",
   136		[EPP_INDEX_BALANCE_PERFORMANCE] = "balance_performance",
   137		[EPP_INDEX_BALANCE_POWERSAVE] = "balance_power",
   138		[EPP_INDEX_POWERSAVE] = "power",
   139		NULL
   140	};
   141	
 > 142	static unsigned int epp_values[] = {

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
