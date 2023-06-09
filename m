Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57ACC729410
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 11:03:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239759AbjFIJDT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 05:03:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230476AbjFIJDK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 05:03:10 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50509210A
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jun 2023 02:03:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686301387; x=1717837387;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Z7CDYQ9fN77GTiWbac1E7CKF9yq11wZi/oPdaLG6Ai0=;
  b=Z+iR79QYbmNdC0iD0m4pPP5WCTS49+uQcVU0ZFofaXbSJEmsotU8mGal
   Oe2mNCw3xnn0EAYbfU+Z4LHBwuYSQ4ud6PZYkoMIQDzRTjqqe7mtZ666n
   hLwG7tuAIyJYNjqoOdsqy7S2KSNalfVRPtnmDcaRmuw/m1VZVEMRMmkEj
   /0DQ0HJhTHefmQbGD9zQFLNvgt8r8aeiaDPSnH9uU7XGDECHY9t9hiLca
   Myr6Z9BN65+tDuJaYKoQciKOstVhrk+8luOUsbZMDdXA5Rw6yUqFQNFDT
   NzAi9Mz1uAHwKWvgKty5Loy9NK8nMuzfsGwk9GIikX5Ncse/lPzM9hzGi
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10735"; a="423434359"
X-IronPort-AV: E=Sophos;i="6.00,228,1681196400"; 
   d="scan'208";a="423434359"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2023 02:02:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10735"; a="704480870"
X-IronPort-AV: E=Sophos;i="6.00,228,1681196400"; 
   d="scan'208";a="704480870"
Received: from lkp-server01.sh.intel.com (HELO 15ab08e44a81) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 09 Jun 2023 02:02:00 -0700
Received: from kbuild by 15ab08e44a81 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1q7Y0N-0008sG-0c;
        Fri, 09 Jun 2023 09:01:59 +0000
Date:   Fri, 9 Jun 2023 17:01:20 +0800
From:   kernel test robot <lkp@intel.com>
To:     Alex Deucher <alexander.deucher@amd.com>
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org, Dave Airlie <airlied@redhat.com>
Subject: drivers/gpu/drm/amd/amdgpu/../pm/legacy-dpm/si_dpm.c:7386:12:
 warning: stack frame size (2112) exceeds limit (2048) in 'si_dpm_init'
Message-ID: <202306091633.KUdquWVa-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dave,

First bad commit (maybe != root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   33f2b5785a2b6b0ed1948aafee60d3abb12f1e3a
commit: 123db17ddff007080d464e785689fb14f94cbc7a Merge tag 'amd-drm-next-5.18-2022-02-11-1' of https://gitlab.freedesktop.org/agd5f/linux into drm-next
date:   1 year, 4 months ago
config: riscv-randconfig-r012-20230608 (https://download.01.org/0day-ci/archive/20230609/202306091633.KUdquWVa-lkp@intel.com/config)
compiler: clang version 14.0.6 (https://github.com/llvm/llvm-project.git f28c006a5895fc0e329fe15fead81e37457cb1d1)
reproduce (this is a W=1 build):
        mkdir -p ~/bin
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install riscv cross compiling tool for clang build
        # apt-get install binutils-riscv64-linux-gnu
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=123db17ddff007080d464e785689fb14f94cbc7a
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 123db17ddff007080d464e785689fb14f94cbc7a
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang ~/bin/make.cross W=1 O=build_dir ARCH=riscv olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang ~/bin/make.cross W=1 O=build_dir ARCH=riscv SHELL=/bin/bash drivers/gpu/drm/ drivers/hid/ lib/

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202306091633.KUdquWVa-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/gpu/drm/amd/amdgpu/../pm/legacy-dpm/si_dpm.c:7386:12: warning: stack frame size (2112) exceeds limit (2048) in 'si_dpm_init' [-Wframe-larger-than]
   static int si_dpm_init(struct amdgpu_device *adev)
              ^
   1 warning generated.


vim +/si_dpm_init +7386 drivers/gpu/drm/amd/amdgpu/../pm/legacy-dpm/si_dpm.c

841686df9f7d29 drivers/gpu/drm/amd/amdgpu/si_dpm.c       Maruthi Bayyavarapu 2016-08-01  7385  
841686df9f7d29 drivers/gpu/drm/amd/amdgpu/si_dpm.c       Maruthi Bayyavarapu 2016-08-01 @7386  static int si_dpm_init(struct amdgpu_device *adev)
841686df9f7d29 drivers/gpu/drm/amd/amdgpu/si_dpm.c       Maruthi Bayyavarapu 2016-08-01  7387  {
841686df9f7d29 drivers/gpu/drm/amd/amdgpu/si_dpm.c       Maruthi Bayyavarapu 2016-08-01  7388  	struct rv7xx_power_info *pi;
841686df9f7d29 drivers/gpu/drm/amd/amdgpu/si_dpm.c       Maruthi Bayyavarapu 2016-08-01  7389  	struct evergreen_power_info *eg_pi;
841686df9f7d29 drivers/gpu/drm/amd/amdgpu/si_dpm.c       Maruthi Bayyavarapu 2016-08-01  7390  	struct ni_power_info *ni_pi;
841686df9f7d29 drivers/gpu/drm/amd/amdgpu/si_dpm.c       Maruthi Bayyavarapu 2016-08-01  7391  	struct si_power_info *si_pi;
841686df9f7d29 drivers/gpu/drm/amd/amdgpu/si_dpm.c       Maruthi Bayyavarapu 2016-08-01  7392  	struct atom_clock_dividers dividers;
841686df9f7d29 drivers/gpu/drm/amd/amdgpu/si_dpm.c       Maruthi Bayyavarapu 2016-08-01  7393  	int ret;
841686df9f7d29 drivers/gpu/drm/amd/amdgpu/si_dpm.c       Maruthi Bayyavarapu 2016-08-01  7394  
841686df9f7d29 drivers/gpu/drm/amd/amdgpu/si_dpm.c       Maruthi Bayyavarapu 2016-08-01  7395  	si_pi = kzalloc(sizeof(struct si_power_info), GFP_KERNEL);
841686df9f7d29 drivers/gpu/drm/amd/amdgpu/si_dpm.c       Maruthi Bayyavarapu 2016-08-01  7396  	if (si_pi == NULL)
841686df9f7d29 drivers/gpu/drm/amd/amdgpu/si_dpm.c       Maruthi Bayyavarapu 2016-08-01  7397  		return -ENOMEM;
841686df9f7d29 drivers/gpu/drm/amd/amdgpu/si_dpm.c       Maruthi Bayyavarapu 2016-08-01  7398  	adev->pm.dpm.priv = si_pi;
841686df9f7d29 drivers/gpu/drm/amd/amdgpu/si_dpm.c       Maruthi Bayyavarapu 2016-08-01  7399  	ni_pi = &si_pi->ni;
841686df9f7d29 drivers/gpu/drm/amd/amdgpu/si_dpm.c       Maruthi Bayyavarapu 2016-08-01  7400  	eg_pi = &ni_pi->eg;
841686df9f7d29 drivers/gpu/drm/amd/amdgpu/si_dpm.c       Maruthi Bayyavarapu 2016-08-01  7401  	pi = &eg_pi->rv7xx;
841686df9f7d29 drivers/gpu/drm/amd/amdgpu/si_dpm.c       Maruthi Bayyavarapu 2016-08-01  7402  
0bf6718537cf11 drivers/gpu/drm/amd/amdgpu/si_dpm.c       Alex Deucher        2018-02-26  7403  	si_pi->sys_pcie_mask =
5d9a6330403271 drivers/gpu/drm/amd/amdgpu/si_dpm.c       Alex Deucher        2018-06-25  7404  		adev->pm.pcie_gen_mask & CAIL_PCIE_LINK_SPEED_SUPPORT_MASK;
a79110f2dc0194 drivers/gpu/drm/amd/pm/powerplay/si_dpm.c Evan Quan           2021-11-11  7405  	si_pi->force_pcie_gen = SI_PCIE_GEN_INVALID;
841686df9f7d29 drivers/gpu/drm/amd/amdgpu/si_dpm.c       Maruthi Bayyavarapu 2016-08-01  7406  	si_pi->boot_pcie_gen = si_get_current_pcie_speed(adev);
841686df9f7d29 drivers/gpu/drm/amd/amdgpu/si_dpm.c       Maruthi Bayyavarapu 2016-08-01  7407  
841686df9f7d29 drivers/gpu/drm/amd/amdgpu/si_dpm.c       Maruthi Bayyavarapu 2016-08-01  7408  	si_set_max_cu_value(adev);
841686df9f7d29 drivers/gpu/drm/amd/amdgpu/si_dpm.c       Maruthi Bayyavarapu 2016-08-01  7409  
841686df9f7d29 drivers/gpu/drm/amd/amdgpu/si_dpm.c       Maruthi Bayyavarapu 2016-08-01  7410  	rv770_get_max_vddc(adev);
841686df9f7d29 drivers/gpu/drm/amd/amdgpu/si_dpm.c       Maruthi Bayyavarapu 2016-08-01  7411  	si_get_leakage_vddc(adev);
841686df9f7d29 drivers/gpu/drm/amd/amdgpu/si_dpm.c       Maruthi Bayyavarapu 2016-08-01  7412  	si_patch_dependency_tables_based_on_leakage(adev);
841686df9f7d29 drivers/gpu/drm/amd/amdgpu/si_dpm.c       Maruthi Bayyavarapu 2016-08-01  7413  
841686df9f7d29 drivers/gpu/drm/amd/amdgpu/si_dpm.c       Maruthi Bayyavarapu 2016-08-01  7414  	pi->acpi_vddc = 0;
841686df9f7d29 drivers/gpu/drm/amd/amdgpu/si_dpm.c       Maruthi Bayyavarapu 2016-08-01  7415  	eg_pi->acpi_vddci = 0;
841686df9f7d29 drivers/gpu/drm/amd/amdgpu/si_dpm.c       Maruthi Bayyavarapu 2016-08-01  7416  	pi->min_vddc_in_table = 0;
841686df9f7d29 drivers/gpu/drm/amd/amdgpu/si_dpm.c       Maruthi Bayyavarapu 2016-08-01  7417  	pi->max_vddc_in_table = 0;
841686df9f7d29 drivers/gpu/drm/amd/amdgpu/si_dpm.c       Maruthi Bayyavarapu 2016-08-01  7418  
841686df9f7d29 drivers/gpu/drm/amd/amdgpu/si_dpm.c       Maruthi Bayyavarapu 2016-08-01  7419  	ret = amdgpu_get_platform_caps(adev);
841686df9f7d29 drivers/gpu/drm/amd/amdgpu/si_dpm.c       Maruthi Bayyavarapu 2016-08-01  7420  	if (ret)
841686df9f7d29 drivers/gpu/drm/amd/amdgpu/si_dpm.c       Maruthi Bayyavarapu 2016-08-01  7421  		return ret;
841686df9f7d29 drivers/gpu/drm/amd/amdgpu/si_dpm.c       Maruthi Bayyavarapu 2016-08-01  7422  
841686df9f7d29 drivers/gpu/drm/amd/amdgpu/si_dpm.c       Maruthi Bayyavarapu 2016-08-01  7423  	ret = amdgpu_parse_extended_power_table(adev);
841686df9f7d29 drivers/gpu/drm/amd/amdgpu/si_dpm.c       Maruthi Bayyavarapu 2016-08-01  7424  	if (ret)
841686df9f7d29 drivers/gpu/drm/amd/amdgpu/si_dpm.c       Maruthi Bayyavarapu 2016-08-01  7425  		return ret;
841686df9f7d29 drivers/gpu/drm/amd/amdgpu/si_dpm.c       Maruthi Bayyavarapu 2016-08-01  7426  
841686df9f7d29 drivers/gpu/drm/amd/amdgpu/si_dpm.c       Maruthi Bayyavarapu 2016-08-01  7427  	ret = si_parse_power_table(adev);
841686df9f7d29 drivers/gpu/drm/amd/amdgpu/si_dpm.c       Maruthi Bayyavarapu 2016-08-01  7428  	if (ret)
841686df9f7d29 drivers/gpu/drm/amd/amdgpu/si_dpm.c       Maruthi Bayyavarapu 2016-08-01  7429  		return ret;
841686df9f7d29 drivers/gpu/drm/amd/amdgpu/si_dpm.c       Maruthi Bayyavarapu 2016-08-01  7430  
841686df9f7d29 drivers/gpu/drm/amd/amdgpu/si_dpm.c       Maruthi Bayyavarapu 2016-08-01  7431  	adev->pm.dpm.dyn_state.vddc_dependency_on_dispclk.entries =
6396bb221514d2 drivers/gpu/drm/amd/amdgpu/si_dpm.c       Kees Cook           2018-06-12  7432  		kcalloc(4,
6396bb221514d2 drivers/gpu/drm/amd/amdgpu/si_dpm.c       Kees Cook           2018-06-12  7433  			sizeof(struct amdgpu_clock_voltage_dependency_entry),
6396bb221514d2 drivers/gpu/drm/amd/amdgpu/si_dpm.c       Kees Cook           2018-06-12  7434  			GFP_KERNEL);
841686df9f7d29 drivers/gpu/drm/amd/amdgpu/si_dpm.c       Maruthi Bayyavarapu 2016-08-01  7435  	if (!adev->pm.dpm.dyn_state.vddc_dependency_on_dispclk.entries) {
841686df9f7d29 drivers/gpu/drm/amd/amdgpu/si_dpm.c       Maruthi Bayyavarapu 2016-08-01  7436  		amdgpu_free_extended_power_table(adev);
841686df9f7d29 drivers/gpu/drm/amd/amdgpu/si_dpm.c       Maruthi Bayyavarapu 2016-08-01  7437  		return -ENOMEM;
841686df9f7d29 drivers/gpu/drm/amd/amdgpu/si_dpm.c       Maruthi Bayyavarapu 2016-08-01  7438  	}
841686df9f7d29 drivers/gpu/drm/amd/amdgpu/si_dpm.c       Maruthi Bayyavarapu 2016-08-01  7439  	adev->pm.dpm.dyn_state.vddc_dependency_on_dispclk.count = 4;
841686df9f7d29 drivers/gpu/drm/amd/amdgpu/si_dpm.c       Maruthi Bayyavarapu 2016-08-01  7440  	adev->pm.dpm.dyn_state.vddc_dependency_on_dispclk.entries[0].clk = 0;
841686df9f7d29 drivers/gpu/drm/amd/amdgpu/si_dpm.c       Maruthi Bayyavarapu 2016-08-01  7441  	adev->pm.dpm.dyn_state.vddc_dependency_on_dispclk.entries[0].v = 0;
841686df9f7d29 drivers/gpu/drm/amd/amdgpu/si_dpm.c       Maruthi Bayyavarapu 2016-08-01  7442  	adev->pm.dpm.dyn_state.vddc_dependency_on_dispclk.entries[1].clk = 36000;
841686df9f7d29 drivers/gpu/drm/amd/amdgpu/si_dpm.c       Maruthi Bayyavarapu 2016-08-01  7443  	adev->pm.dpm.dyn_state.vddc_dependency_on_dispclk.entries[1].v = 720;
841686df9f7d29 drivers/gpu/drm/amd/amdgpu/si_dpm.c       Maruthi Bayyavarapu 2016-08-01  7444  	adev->pm.dpm.dyn_state.vddc_dependency_on_dispclk.entries[2].clk = 54000;
841686df9f7d29 drivers/gpu/drm/amd/amdgpu/si_dpm.c       Maruthi Bayyavarapu 2016-08-01  7445  	adev->pm.dpm.dyn_state.vddc_dependency_on_dispclk.entries[2].v = 810;
841686df9f7d29 drivers/gpu/drm/amd/amdgpu/si_dpm.c       Maruthi Bayyavarapu 2016-08-01  7446  	adev->pm.dpm.dyn_state.vddc_dependency_on_dispclk.entries[3].clk = 72000;
841686df9f7d29 drivers/gpu/drm/amd/amdgpu/si_dpm.c       Maruthi Bayyavarapu 2016-08-01  7447  	adev->pm.dpm.dyn_state.vddc_dependency_on_dispclk.entries[3].v = 900;
841686df9f7d29 drivers/gpu/drm/amd/amdgpu/si_dpm.c       Maruthi Bayyavarapu 2016-08-01  7448  
841686df9f7d29 drivers/gpu/drm/amd/amdgpu/si_dpm.c       Maruthi Bayyavarapu 2016-08-01  7449  	if (adev->pm.dpm.voltage_response_time == 0)
841686df9f7d29 drivers/gpu/drm/amd/amdgpu/si_dpm.c       Maruthi Bayyavarapu 2016-08-01  7450  		adev->pm.dpm.voltage_response_time = R600_VOLTAGERESPONSETIME_DFLT;
841686df9f7d29 drivers/gpu/drm/amd/amdgpu/si_dpm.c       Maruthi Bayyavarapu 2016-08-01  7451  	if (adev->pm.dpm.backbias_response_time == 0)
841686df9f7d29 drivers/gpu/drm/amd/amdgpu/si_dpm.c       Maruthi Bayyavarapu 2016-08-01  7452  		adev->pm.dpm.backbias_response_time = R600_BACKBIASRESPONSETIME_DFLT;
841686df9f7d29 drivers/gpu/drm/amd/amdgpu/si_dpm.c       Maruthi Bayyavarapu 2016-08-01  7453  
841686df9f7d29 drivers/gpu/drm/amd/amdgpu/si_dpm.c       Maruthi Bayyavarapu 2016-08-01  7454  	ret = amdgpu_atombios_get_clock_dividers(adev, COMPUTE_ENGINE_PLL_PARAM,
841686df9f7d29 drivers/gpu/drm/amd/amdgpu/si_dpm.c       Maruthi Bayyavarapu 2016-08-01  7455  					     0, false, &dividers);
841686df9f7d29 drivers/gpu/drm/amd/amdgpu/si_dpm.c       Maruthi Bayyavarapu 2016-08-01  7456  	if (ret)
841686df9f7d29 drivers/gpu/drm/amd/amdgpu/si_dpm.c       Maruthi Bayyavarapu 2016-08-01  7457  		pi->ref_div = dividers.ref_div + 1;
841686df9f7d29 drivers/gpu/drm/amd/amdgpu/si_dpm.c       Maruthi Bayyavarapu 2016-08-01  7458  	else
841686df9f7d29 drivers/gpu/drm/amd/amdgpu/si_dpm.c       Maruthi Bayyavarapu 2016-08-01  7459  		pi->ref_div = R600_REFERENCEDIVIDER_DFLT;
841686df9f7d29 drivers/gpu/drm/amd/amdgpu/si_dpm.c       Maruthi Bayyavarapu 2016-08-01  7460  
841686df9f7d29 drivers/gpu/drm/amd/amdgpu/si_dpm.c       Maruthi Bayyavarapu 2016-08-01  7461  	eg_pi->smu_uvd_hs = false;
841686df9f7d29 drivers/gpu/drm/amd/amdgpu/si_dpm.c       Maruthi Bayyavarapu 2016-08-01  7462  
841686df9f7d29 drivers/gpu/drm/amd/amdgpu/si_dpm.c       Maruthi Bayyavarapu 2016-08-01  7463  	pi->mclk_strobe_mode_threshold = 40000;
841686df9f7d29 drivers/gpu/drm/amd/amdgpu/si_dpm.c       Maruthi Bayyavarapu 2016-08-01  7464  	if (si_is_special_1gb_platform(adev))
841686df9f7d29 drivers/gpu/drm/amd/amdgpu/si_dpm.c       Maruthi Bayyavarapu 2016-08-01  7465  		pi->mclk_stutter_mode_threshold = 0;
841686df9f7d29 drivers/gpu/drm/amd/amdgpu/si_dpm.c       Maruthi Bayyavarapu 2016-08-01  7466  	else
841686df9f7d29 drivers/gpu/drm/amd/amdgpu/si_dpm.c       Maruthi Bayyavarapu 2016-08-01  7467  		pi->mclk_stutter_mode_threshold = pi->mclk_strobe_mode_threshold;
841686df9f7d29 drivers/gpu/drm/amd/amdgpu/si_dpm.c       Maruthi Bayyavarapu 2016-08-01  7468  	pi->mclk_edc_enable_threshold = 40000;
841686df9f7d29 drivers/gpu/drm/amd/amdgpu/si_dpm.c       Maruthi Bayyavarapu 2016-08-01  7469  	eg_pi->mclk_edc_wr_enable_threshold = 40000;
841686df9f7d29 drivers/gpu/drm/amd/amdgpu/si_dpm.c       Maruthi Bayyavarapu 2016-08-01  7470  
841686df9f7d29 drivers/gpu/drm/amd/amdgpu/si_dpm.c       Maruthi Bayyavarapu 2016-08-01  7471  	ni_pi->mclk_rtt_mode_threshold = eg_pi->mclk_edc_wr_enable_threshold;
841686df9f7d29 drivers/gpu/drm/amd/amdgpu/si_dpm.c       Maruthi Bayyavarapu 2016-08-01  7472  
841686df9f7d29 drivers/gpu/drm/amd/amdgpu/si_dpm.c       Maruthi Bayyavarapu 2016-08-01  7473  	pi->voltage_control =
841686df9f7d29 drivers/gpu/drm/amd/amdgpu/si_dpm.c       Maruthi Bayyavarapu 2016-08-01  7474  		amdgpu_atombios_is_voltage_gpio(adev, SET_VOLTAGE_TYPE_ASIC_VDDC,
841686df9f7d29 drivers/gpu/drm/amd/amdgpu/si_dpm.c       Maruthi Bayyavarapu 2016-08-01  7475  					    VOLTAGE_OBJ_GPIO_LUT);
841686df9f7d29 drivers/gpu/drm/amd/amdgpu/si_dpm.c       Maruthi Bayyavarapu 2016-08-01  7476  	if (!pi->voltage_control) {
841686df9f7d29 drivers/gpu/drm/amd/amdgpu/si_dpm.c       Maruthi Bayyavarapu 2016-08-01  7477  		si_pi->voltage_control_svi2 =
841686df9f7d29 drivers/gpu/drm/amd/amdgpu/si_dpm.c       Maruthi Bayyavarapu 2016-08-01  7478  			amdgpu_atombios_is_voltage_gpio(adev, SET_VOLTAGE_TYPE_ASIC_VDDC,
841686df9f7d29 drivers/gpu/drm/amd/amdgpu/si_dpm.c       Maruthi Bayyavarapu 2016-08-01  7479  						    VOLTAGE_OBJ_SVID2);
841686df9f7d29 drivers/gpu/drm/amd/amdgpu/si_dpm.c       Maruthi Bayyavarapu 2016-08-01  7480  		if (si_pi->voltage_control_svi2)
841686df9f7d29 drivers/gpu/drm/amd/amdgpu/si_dpm.c       Maruthi Bayyavarapu 2016-08-01  7481  			amdgpu_atombios_get_svi2_info(adev, SET_VOLTAGE_TYPE_ASIC_VDDC,
841686df9f7d29 drivers/gpu/drm/amd/amdgpu/si_dpm.c       Maruthi Bayyavarapu 2016-08-01  7482  						  &si_pi->svd_gpio_id, &si_pi->svc_gpio_id);
841686df9f7d29 drivers/gpu/drm/amd/amdgpu/si_dpm.c       Maruthi Bayyavarapu 2016-08-01  7483  	}
841686df9f7d29 drivers/gpu/drm/amd/amdgpu/si_dpm.c       Maruthi Bayyavarapu 2016-08-01  7484  
841686df9f7d29 drivers/gpu/drm/amd/amdgpu/si_dpm.c       Maruthi Bayyavarapu 2016-08-01  7485  	pi->mvdd_control =
841686df9f7d29 drivers/gpu/drm/amd/amdgpu/si_dpm.c       Maruthi Bayyavarapu 2016-08-01  7486  		amdgpu_atombios_is_voltage_gpio(adev, SET_VOLTAGE_TYPE_ASIC_MVDDC,
841686df9f7d29 drivers/gpu/drm/amd/amdgpu/si_dpm.c       Maruthi Bayyavarapu 2016-08-01  7487  					    VOLTAGE_OBJ_GPIO_LUT);
841686df9f7d29 drivers/gpu/drm/amd/amdgpu/si_dpm.c       Maruthi Bayyavarapu 2016-08-01  7488  
841686df9f7d29 drivers/gpu/drm/amd/amdgpu/si_dpm.c       Maruthi Bayyavarapu 2016-08-01  7489  	eg_pi->vddci_control =
841686df9f7d29 drivers/gpu/drm/amd/amdgpu/si_dpm.c       Maruthi Bayyavarapu 2016-08-01  7490  		amdgpu_atombios_is_voltage_gpio(adev, SET_VOLTAGE_TYPE_ASIC_VDDCI,
841686df9f7d29 drivers/gpu/drm/amd/amdgpu/si_dpm.c       Maruthi Bayyavarapu 2016-08-01  7491  					    VOLTAGE_OBJ_GPIO_LUT);
841686df9f7d29 drivers/gpu/drm/amd/amdgpu/si_dpm.c       Maruthi Bayyavarapu 2016-08-01  7492  	if (!eg_pi->vddci_control)
841686df9f7d29 drivers/gpu/drm/amd/amdgpu/si_dpm.c       Maruthi Bayyavarapu 2016-08-01  7493  		si_pi->vddci_control_svi2 =
841686df9f7d29 drivers/gpu/drm/amd/amdgpu/si_dpm.c       Maruthi Bayyavarapu 2016-08-01  7494  			amdgpu_atombios_is_voltage_gpio(adev, SET_VOLTAGE_TYPE_ASIC_VDDCI,
841686df9f7d29 drivers/gpu/drm/amd/amdgpu/si_dpm.c       Maruthi Bayyavarapu 2016-08-01  7495  						    VOLTAGE_OBJ_SVID2);
841686df9f7d29 drivers/gpu/drm/amd/amdgpu/si_dpm.c       Maruthi Bayyavarapu 2016-08-01  7496  
841686df9f7d29 drivers/gpu/drm/amd/amdgpu/si_dpm.c       Maruthi Bayyavarapu 2016-08-01  7497  	si_pi->vddc_phase_shed_control =
841686df9f7d29 drivers/gpu/drm/amd/amdgpu/si_dpm.c       Maruthi Bayyavarapu 2016-08-01  7498  		amdgpu_atombios_is_voltage_gpio(adev, SET_VOLTAGE_TYPE_ASIC_VDDC,
841686df9f7d29 drivers/gpu/drm/amd/amdgpu/si_dpm.c       Maruthi Bayyavarapu 2016-08-01  7499  					    VOLTAGE_OBJ_PHASE_LUT);
841686df9f7d29 drivers/gpu/drm/amd/amdgpu/si_dpm.c       Maruthi Bayyavarapu 2016-08-01  7500  
841686df9f7d29 drivers/gpu/drm/amd/amdgpu/si_dpm.c       Maruthi Bayyavarapu 2016-08-01  7501  	rv770_get_engine_memory_ss(adev);
841686df9f7d29 drivers/gpu/drm/amd/amdgpu/si_dpm.c       Maruthi Bayyavarapu 2016-08-01  7502  
841686df9f7d29 drivers/gpu/drm/amd/amdgpu/si_dpm.c       Maruthi Bayyavarapu 2016-08-01  7503  	pi->asi = RV770_ASI_DFLT;
841686df9f7d29 drivers/gpu/drm/amd/amdgpu/si_dpm.c       Maruthi Bayyavarapu 2016-08-01  7504  	pi->pasi = CYPRESS_HASI_DFLT;
841686df9f7d29 drivers/gpu/drm/amd/amdgpu/si_dpm.c       Maruthi Bayyavarapu 2016-08-01  7505  	pi->vrc = SISLANDS_VRC_DFLT;
841686df9f7d29 drivers/gpu/drm/amd/amdgpu/si_dpm.c       Maruthi Bayyavarapu 2016-08-01  7506  
841686df9f7d29 drivers/gpu/drm/amd/amdgpu/si_dpm.c       Maruthi Bayyavarapu 2016-08-01  7507  	pi->gfx_clock_gating = true;
841686df9f7d29 drivers/gpu/drm/amd/amdgpu/si_dpm.c       Maruthi Bayyavarapu 2016-08-01  7508  
841686df9f7d29 drivers/gpu/drm/amd/amdgpu/si_dpm.c       Maruthi Bayyavarapu 2016-08-01  7509  	eg_pi->sclk_deep_sleep = true;
841686df9f7d29 drivers/gpu/drm/amd/amdgpu/si_dpm.c       Maruthi Bayyavarapu 2016-08-01  7510  	si_pi->sclk_deep_sleep_above_low = false;
841686df9f7d29 drivers/gpu/drm/amd/amdgpu/si_dpm.c       Maruthi Bayyavarapu 2016-08-01  7511  
841686df9f7d29 drivers/gpu/drm/amd/amdgpu/si_dpm.c       Maruthi Bayyavarapu 2016-08-01  7512  	if (adev->pm.int_thermal_type != THERMAL_TYPE_NONE)
841686df9f7d29 drivers/gpu/drm/amd/amdgpu/si_dpm.c       Maruthi Bayyavarapu 2016-08-01  7513  		pi->thermal_protection = true;
841686df9f7d29 drivers/gpu/drm/amd/amdgpu/si_dpm.c       Maruthi Bayyavarapu 2016-08-01  7514  	else
841686df9f7d29 drivers/gpu/drm/amd/amdgpu/si_dpm.c       Maruthi Bayyavarapu 2016-08-01  7515  		pi->thermal_protection = false;
841686df9f7d29 drivers/gpu/drm/amd/amdgpu/si_dpm.c       Maruthi Bayyavarapu 2016-08-01  7516  
841686df9f7d29 drivers/gpu/drm/amd/amdgpu/si_dpm.c       Maruthi Bayyavarapu 2016-08-01  7517  	eg_pi->dynamic_ac_timing = true;
841686df9f7d29 drivers/gpu/drm/amd/amdgpu/si_dpm.c       Maruthi Bayyavarapu 2016-08-01  7518  
841686df9f7d29 drivers/gpu/drm/amd/amdgpu/si_dpm.c       Maruthi Bayyavarapu 2016-08-01  7519  	eg_pi->light_sleep = true;
841686df9f7d29 drivers/gpu/drm/amd/amdgpu/si_dpm.c       Maruthi Bayyavarapu 2016-08-01  7520  #if defined(CONFIG_ACPI)
841686df9f7d29 drivers/gpu/drm/amd/amdgpu/si_dpm.c       Maruthi Bayyavarapu 2016-08-01  7521  	eg_pi->pcie_performance_request =
841686df9f7d29 drivers/gpu/drm/amd/amdgpu/si_dpm.c       Maruthi Bayyavarapu 2016-08-01  7522  		amdgpu_acpi_is_pcie_performance_request_supported(adev);
841686df9f7d29 drivers/gpu/drm/amd/amdgpu/si_dpm.c       Maruthi Bayyavarapu 2016-08-01  7523  #else
841686df9f7d29 drivers/gpu/drm/amd/amdgpu/si_dpm.c       Maruthi Bayyavarapu 2016-08-01  7524  	eg_pi->pcie_performance_request = false;
841686df9f7d29 drivers/gpu/drm/amd/amdgpu/si_dpm.c       Maruthi Bayyavarapu 2016-08-01  7525  #endif
841686df9f7d29 drivers/gpu/drm/amd/amdgpu/si_dpm.c       Maruthi Bayyavarapu 2016-08-01  7526  
841686df9f7d29 drivers/gpu/drm/amd/amdgpu/si_dpm.c       Maruthi Bayyavarapu 2016-08-01  7527  	si_pi->sram_end = SMC_RAM_END;
841686df9f7d29 drivers/gpu/drm/amd/amdgpu/si_dpm.c       Maruthi Bayyavarapu 2016-08-01  7528  
841686df9f7d29 drivers/gpu/drm/amd/amdgpu/si_dpm.c       Maruthi Bayyavarapu 2016-08-01  7529  	adev->pm.dpm.dyn_state.mclk_sclk_ratio = 4;
841686df9f7d29 drivers/gpu/drm/amd/amdgpu/si_dpm.c       Maruthi Bayyavarapu 2016-08-01  7530  	adev->pm.dpm.dyn_state.sclk_mclk_delta = 15000;
841686df9f7d29 drivers/gpu/drm/amd/amdgpu/si_dpm.c       Maruthi Bayyavarapu 2016-08-01  7531  	adev->pm.dpm.dyn_state.vddc_vddci_delta = 200;
841686df9f7d29 drivers/gpu/drm/amd/amdgpu/si_dpm.c       Maruthi Bayyavarapu 2016-08-01  7532  	adev->pm.dpm.dyn_state.valid_sclk_values.count = 0;
841686df9f7d29 drivers/gpu/drm/amd/amdgpu/si_dpm.c       Maruthi Bayyavarapu 2016-08-01  7533  	adev->pm.dpm.dyn_state.valid_sclk_values.values = NULL;
841686df9f7d29 drivers/gpu/drm/amd/amdgpu/si_dpm.c       Maruthi Bayyavarapu 2016-08-01  7534  	adev->pm.dpm.dyn_state.valid_mclk_values.count = 0;
841686df9f7d29 drivers/gpu/drm/amd/amdgpu/si_dpm.c       Maruthi Bayyavarapu 2016-08-01  7535  	adev->pm.dpm.dyn_state.valid_mclk_values.values = NULL;
841686df9f7d29 drivers/gpu/drm/amd/amdgpu/si_dpm.c       Maruthi Bayyavarapu 2016-08-01  7536  
841686df9f7d29 drivers/gpu/drm/amd/amdgpu/si_dpm.c       Maruthi Bayyavarapu 2016-08-01  7537  	si_initialize_powertune_defaults(adev);
841686df9f7d29 drivers/gpu/drm/amd/amdgpu/si_dpm.c       Maruthi Bayyavarapu 2016-08-01  7538  
841686df9f7d29 drivers/gpu/drm/amd/amdgpu/si_dpm.c       Maruthi Bayyavarapu 2016-08-01  7539  	/* make sure dc limits are valid */
841686df9f7d29 drivers/gpu/drm/amd/amdgpu/si_dpm.c       Maruthi Bayyavarapu 2016-08-01  7540  	if ((adev->pm.dpm.dyn_state.max_clock_voltage_on_dc.sclk == 0) ||
841686df9f7d29 drivers/gpu/drm/amd/amdgpu/si_dpm.c       Maruthi Bayyavarapu 2016-08-01  7541  	    (adev->pm.dpm.dyn_state.max_clock_voltage_on_dc.mclk == 0))
841686df9f7d29 drivers/gpu/drm/amd/amdgpu/si_dpm.c       Maruthi Bayyavarapu 2016-08-01  7542  		adev->pm.dpm.dyn_state.max_clock_voltage_on_dc =
841686df9f7d29 drivers/gpu/drm/amd/amdgpu/si_dpm.c       Maruthi Bayyavarapu 2016-08-01  7543  			adev->pm.dpm.dyn_state.max_clock_voltage_on_ac;
841686df9f7d29 drivers/gpu/drm/amd/amdgpu/si_dpm.c       Maruthi Bayyavarapu 2016-08-01  7544  
841686df9f7d29 drivers/gpu/drm/amd/amdgpu/si_dpm.c       Maruthi Bayyavarapu 2016-08-01  7545  	si_pi->fan_ctrl_is_in_default_mode = true;
841686df9f7d29 drivers/gpu/drm/amd/amdgpu/si_dpm.c       Maruthi Bayyavarapu 2016-08-01  7546  
841686df9f7d29 drivers/gpu/drm/amd/amdgpu/si_dpm.c       Maruthi Bayyavarapu 2016-08-01  7547  	return 0;
841686df9f7d29 drivers/gpu/drm/amd/amdgpu/si_dpm.c       Maruthi Bayyavarapu 2016-08-01  7548  }
841686df9f7d29 drivers/gpu/drm/amd/amdgpu/si_dpm.c       Maruthi Bayyavarapu 2016-08-01  7549  

:::::: The code at line 7386 was first introduced by commit
:::::: 841686df9f7d2942cfd94d024b8591fa3f74ef7c drm/amdgpu: add SI DPM support (v4)

:::::: TO: Maruthi Bayyavarapu <maruthi.bayyavarapu@amd.com>
:::::: CC: Alex Deucher <alexander.deucher@amd.com>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
