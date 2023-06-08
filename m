Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A95572893D
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 22:15:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236089AbjFHUPq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 16:15:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235711AbjFHUPo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 16:15:44 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F24D72D59
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jun 2023 13:15:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686255340; x=1717791340;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Phl7fDmkus2PeS9ivNtDJ8RW9/vb2OrkmuL0yboDYVo=;
  b=RX3102AM4HoxZ90GI+b+kEW11mVJTjneETPHU3OM1zHc5b5X1rx1NsEc
   eH6duLuohtySF6cmOcWdvgDrZrI/yAiMRmNvry3INgZnlCVfc829JxmQK
   /QSZyh47cYAjOW43LEnGl7BUi5Yb0ROGvzSrG72c2OxH8Lc8dLQS2m3hN
   uYp35lrtDlArSKgcLvgU+yJi2nCWQ78vNk3eaZ6Pk9j0O0BxquFuk3oCu
   1AtvKX+mt1P0e6HJVWX+/tcC75qzg3LjuKgLRjoqRmztbxMe0texQh09A
   OrTeSGeOKfVmIVPc8xCsliUCmYfkXC0R1ZQkxqdaAyjEk/XU8W5vhQB7J
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10735"; a="385773179"
X-IronPort-AV: E=Sophos;i="6.00,227,1681196400"; 
   d="scan'208";a="385773179"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2023 13:15:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10735"; a="687489082"
X-IronPort-AV: E=Sophos;i="6.00,227,1681196400"; 
   d="scan'208";a="687489082"
Received: from lkp-server01.sh.intel.com (HELO 15ab08e44a81) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 08 Jun 2023 13:15:38 -0700
Received: from kbuild by 15ab08e44a81 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1q7M2j-0008EC-08;
        Thu, 08 Jun 2023 20:15:37 +0000
Date:   Fri, 9 Jun 2023 04:14:51 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org, Marco Elver <elver@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>
Subject: drivers/gpu/drm/radeon/ci_dpm.c:5637:5: warning: stack frame size
 (2080) exceeds limit (2048) in 'ci_dpm_init'
Message-ID: <202306090414.9ZouARLE-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kees,

First bad commit (maybe != root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   25041a4c02c7cf774d8b6ed60586fd64f1cdaa81
commit: 69d0db01e210e07fe915e5da91b54a867cda040f ubsan: remove CONFIG_UBSAN_OBJECT_SIZE
date:   1 year, 5 months ago
config: riscv-randconfig-r012-20230608 (https://download.01.org/0day-ci/archive/20230609/202306090414.9ZouARLE-lkp@intel.com/config)
compiler: clang version 14.0.6 (https://github.com/llvm/llvm-project.git f28c006a5895fc0e329fe15fead81e37457cb1d1)
reproduce (this is a W=1 build):
        mkdir -p ~/bin
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install riscv cross compiling tool for clang build
        # apt-get install binutils-riscv64-linux-gnu
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=69d0db01e210e07fe915e5da91b54a867cda040f
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 69d0db01e210e07fe915e5da91b54a867cda040f
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang ~/bin/make.cross W=1 O=build_dir ARCH=riscv olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang ~/bin/make.cross W=1 O=build_dir ARCH=riscv SHELL=/bin/bash drivers/gpu/drm/ drivers/hid/ drivers/media/tuners/ lib/

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202306090414.9ZouARLE-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/gpu/drm/radeon/ci_dpm.c:5637:5: warning: stack frame size (2080) exceeds limit (2048) in 'ci_dpm_init' [-Wframe-larger-than]
   int ci_dpm_init(struct radeon_device *rdev)
       ^
   1 warning generated.
--
>> drivers/gpu/drm/radeon/si_dpm.c:6880:5: warning: stack frame size (2160) exceeds limit (2048) in 'si_dpm_init' [-Wframe-larger-than]
   int si_dpm_init(struct radeon_device *rdev)
       ^
   1 warning generated.


vim +/ci_dpm_init +5637 drivers/gpu/drm/radeon/ci_dpm.c

cc8dbbb4f62aa53 Alex Deucher 2013-08-14  5636  
cc8dbbb4f62aa53 Alex Deucher 2013-08-14 @5637  int ci_dpm_init(struct radeon_device *rdev)
cc8dbbb4f62aa53 Alex Deucher 2013-08-14  5638  {
cc8dbbb4f62aa53 Alex Deucher 2013-08-14  5639  	int index = GetIndexIntoMasterTable(DATA, ASIC_InternalSS_Info);
34fc0b58d91f7ee Alex Deucher 2014-11-07  5640  	SMU7_Discrete_DpmTable  *dpm_table;
34fc0b58d91f7ee Alex Deucher 2014-11-07  5641  	struct radeon_gpio_rec gpio;
cc8dbbb4f62aa53 Alex Deucher 2013-08-14  5642  	u16 data_offset, size;
cc8dbbb4f62aa53 Alex Deucher 2013-08-14  5643  	u8 frev, crev;
cc8dbbb4f62aa53 Alex Deucher 2013-08-14  5644  	struct ci_power_info *pi;
089888c46841cef Alex Deucher 2019-01-15  5645  	enum pci_bus_speed speed_cap = PCI_SPEED_UNKNOWN;
5f152a572c10cae Alex Deucher 2018-06-25  5646  	struct pci_dev *root = rdev->pdev->bus->self;
cc8dbbb4f62aa53 Alex Deucher 2013-08-14  5647  	int ret;
cc8dbbb4f62aa53 Alex Deucher 2013-08-14  5648  
cc8dbbb4f62aa53 Alex Deucher 2013-08-14  5649  	pi = kzalloc(sizeof(struct ci_power_info), GFP_KERNEL);
cc8dbbb4f62aa53 Alex Deucher 2013-08-14  5650  	if (pi == NULL)
cc8dbbb4f62aa53 Alex Deucher 2013-08-14  5651  		return -ENOMEM;
cc8dbbb4f62aa53 Alex Deucher 2013-08-14  5652  	rdev->pm.dpm.priv = pi;
cc8dbbb4f62aa53 Alex Deucher 2013-08-14  5653  
089888c46841cef Alex Deucher 2019-01-15  5654  	if (!pci_is_root_bus(rdev->pdev->bus))
5f152a572c10cae Alex Deucher 2018-06-25  5655  		speed_cap = pcie_get_speed_cap(root);
5f152a572c10cae Alex Deucher 2018-06-25  5656  	if (speed_cap == PCI_SPEED_UNKNOWN) {
cc8dbbb4f62aa53 Alex Deucher 2013-08-14  5657  		pi->sys_pcie_mask = 0;
5f152a572c10cae Alex Deucher 2018-06-25  5658  	} else {
5f152a572c10cae Alex Deucher 2018-06-25  5659  		if (speed_cap == PCIE_SPEED_8_0GT)
5f152a572c10cae Alex Deucher 2018-06-25  5660  			pi->sys_pcie_mask = RADEON_PCIE_SPEED_25 |
5f152a572c10cae Alex Deucher 2018-06-25  5661  				RADEON_PCIE_SPEED_50 |
5f152a572c10cae Alex Deucher 2018-06-25  5662  				RADEON_PCIE_SPEED_80;
5f152a572c10cae Alex Deucher 2018-06-25  5663  		else if (speed_cap == PCIE_SPEED_5_0GT)
5f152a572c10cae Alex Deucher 2018-06-25  5664  			pi->sys_pcie_mask = RADEON_PCIE_SPEED_25 |
5f152a572c10cae Alex Deucher 2018-06-25  5665  				RADEON_PCIE_SPEED_50;
cc8dbbb4f62aa53 Alex Deucher 2013-08-14  5666  		else
5f152a572c10cae Alex Deucher 2018-06-25  5667  			pi->sys_pcie_mask = RADEON_PCIE_SPEED_25;
5f152a572c10cae Alex Deucher 2018-06-25  5668  	}
cc8dbbb4f62aa53 Alex Deucher 2013-08-14  5669  	pi->force_pcie_gen = RADEON_PCIE_GEN_INVALID;
cc8dbbb4f62aa53 Alex Deucher 2013-08-14  5670  
cc8dbbb4f62aa53 Alex Deucher 2013-08-14  5671  	pi->pcie_gen_performance.max = RADEON_PCIE_GEN1;
cc8dbbb4f62aa53 Alex Deucher 2013-08-14  5672  	pi->pcie_gen_performance.min = RADEON_PCIE_GEN3;
cc8dbbb4f62aa53 Alex Deucher 2013-08-14  5673  	pi->pcie_gen_powersaving.max = RADEON_PCIE_GEN1;
cc8dbbb4f62aa53 Alex Deucher 2013-08-14  5674  	pi->pcie_gen_powersaving.min = RADEON_PCIE_GEN3;
cc8dbbb4f62aa53 Alex Deucher 2013-08-14  5675  
cc8dbbb4f62aa53 Alex Deucher 2013-08-14  5676  	pi->pcie_lane_performance.max = 0;
cc8dbbb4f62aa53 Alex Deucher 2013-08-14  5677  	pi->pcie_lane_performance.min = 16;
cc8dbbb4f62aa53 Alex Deucher 2013-08-14  5678  	pi->pcie_lane_powersaving.max = 0;
cc8dbbb4f62aa53 Alex Deucher 2013-08-14  5679  	pi->pcie_lane_powersaving.min = 16;
cc8dbbb4f62aa53 Alex Deucher 2013-08-14  5680  
cc8dbbb4f62aa53 Alex Deucher 2013-08-14  5681  	ret = ci_get_vbios_boot_values(rdev, &pi->vbios_boot_state);
cc8dbbb4f62aa53 Alex Deucher 2013-08-14  5682  	if (ret) {
cc8dbbb4f62aa53 Alex Deucher 2013-08-14  5683  		ci_dpm_fini(rdev);
cc8dbbb4f62aa53 Alex Deucher 2013-08-14  5684  		return ret;
cc8dbbb4f62aa53 Alex Deucher 2013-08-14  5685  	}
82f79cc54b6a67c Alex Deucher 2013-08-21  5686  
82f79cc54b6a67c Alex Deucher 2013-08-21  5687  	ret = r600_get_platform_caps(rdev);
82f79cc54b6a67c Alex Deucher 2013-08-21  5688  	if (ret) {
82f79cc54b6a67c Alex Deucher 2013-08-21  5689  		ci_dpm_fini(rdev);
82f79cc54b6a67c Alex Deucher 2013-08-21  5690  		return ret;
82f79cc54b6a67c Alex Deucher 2013-08-21  5691  	}
8cd366823e0045b Alex Deucher 2013-08-23  5692  
8cd366823e0045b Alex Deucher 2013-08-23  5693  	ret = r600_parse_extended_power_table(rdev);
cc8dbbb4f62aa53 Alex Deucher 2013-08-14  5694  	if (ret) {
cc8dbbb4f62aa53 Alex Deucher 2013-08-14  5695  		ci_dpm_fini(rdev);
cc8dbbb4f62aa53 Alex Deucher 2013-08-14  5696  		return ret;
cc8dbbb4f62aa53 Alex Deucher 2013-08-14  5697  	}
8cd366823e0045b Alex Deucher 2013-08-23  5698  
8cd366823e0045b Alex Deucher 2013-08-23  5699  	ret = ci_parse_power_table(rdev);
cc8dbbb4f62aa53 Alex Deucher 2013-08-14  5700  	if (ret) {
cc8dbbb4f62aa53 Alex Deucher 2013-08-14  5701  		ci_dpm_fini(rdev);
cc8dbbb4f62aa53 Alex Deucher 2013-08-14  5702  		return ret;
cc8dbbb4f62aa53 Alex Deucher 2013-08-14  5703  	}
cc8dbbb4f62aa53 Alex Deucher 2013-08-14  5704  
cc8dbbb4f62aa53 Alex Deucher 2013-08-14  5705  	pi->dll_default_on = false;
cc8dbbb4f62aa53 Alex Deucher 2013-08-14  5706  	pi->sram_end = SMC_RAM_END;
cc8dbbb4f62aa53 Alex Deucher 2013-08-14  5707  
cc8dbbb4f62aa53 Alex Deucher 2013-08-14  5708  	pi->activity_target[0] = CISLAND_TARGETACTIVITY_DFLT;
cc8dbbb4f62aa53 Alex Deucher 2013-08-14  5709  	pi->activity_target[1] = CISLAND_TARGETACTIVITY_DFLT;
cc8dbbb4f62aa53 Alex Deucher 2013-08-14  5710  	pi->activity_target[2] = CISLAND_TARGETACTIVITY_DFLT;
cc8dbbb4f62aa53 Alex Deucher 2013-08-14  5711  	pi->activity_target[3] = CISLAND_TARGETACTIVITY_DFLT;
cc8dbbb4f62aa53 Alex Deucher 2013-08-14  5712  	pi->activity_target[4] = CISLAND_TARGETACTIVITY_DFLT;
cc8dbbb4f62aa53 Alex Deucher 2013-08-14  5713  	pi->activity_target[5] = CISLAND_TARGETACTIVITY_DFLT;
cc8dbbb4f62aa53 Alex Deucher 2013-08-14  5714  	pi->activity_target[6] = CISLAND_TARGETACTIVITY_DFLT;
cc8dbbb4f62aa53 Alex Deucher 2013-08-14  5715  	pi->activity_target[7] = CISLAND_TARGETACTIVITY_DFLT;
cc8dbbb4f62aa53 Alex Deucher 2013-08-14  5716  
cc8dbbb4f62aa53 Alex Deucher 2013-08-14  5717  	pi->mclk_activity_target = CISLAND_MCLK_TARGETACTIVITY_DFLT;
cc8dbbb4f62aa53 Alex Deucher 2013-08-14  5718  
cc8dbbb4f62aa53 Alex Deucher 2013-08-14  5719  	pi->sclk_dpm_key_disabled = 0;
cc8dbbb4f62aa53 Alex Deucher 2013-08-14  5720  	pi->mclk_dpm_key_disabled = 0;
cc8dbbb4f62aa53 Alex Deucher 2013-08-14  5721  	pi->pcie_dpm_key_disabled = 0;
0e4ed1c1908e48e Alex Deucher 2014-09-15  5722  	pi->thermal_sclk_dpm_enabled = 0;
cc8dbbb4f62aa53 Alex Deucher 2013-08-14  5723  
7e1858f9aff7d60 Alex Deucher 2014-04-11  5724  	/* mclk dpm is unstable on some R7 260X cards with the old mc ucode */
7e1858f9aff7d60 Alex Deucher 2014-04-11  5725  	if ((rdev->pdev->device == 0x6658) &&
7e1858f9aff7d60 Alex Deucher 2014-04-11  5726  	    (rdev->mc_fw->size == (BONAIRE_MC_UCODE_SIZE * 4))) {
57700ad1f2f21d5 Alex Deucher 2014-04-10  5727  		pi->mclk_dpm_key_disabled = 1;
7e1858f9aff7d60 Alex Deucher 2014-04-11  5728  	}
57700ad1f2f21d5 Alex Deucher 2014-04-10  5729  
cc8dbbb4f62aa53 Alex Deucher 2013-08-14  5730  	pi->caps_sclk_ds = true;
cc8dbbb4f62aa53 Alex Deucher 2013-08-14  5731  
cc8dbbb4f62aa53 Alex Deucher 2013-08-14  5732  	pi->mclk_strobe_mode_threshold = 40000;
cc8dbbb4f62aa53 Alex Deucher 2013-08-14  5733  	pi->mclk_stutter_mode_threshold = 40000;
cc8dbbb4f62aa53 Alex Deucher 2013-08-14  5734  	pi->mclk_edc_enable_threshold = 40000;
cc8dbbb4f62aa53 Alex Deucher 2013-08-14  5735  	pi->mclk_edc_wr_enable_threshold = 40000;
cc8dbbb4f62aa53 Alex Deucher 2013-08-14  5736  
cc8dbbb4f62aa53 Alex Deucher 2013-08-14  5737  	ci_initialize_powertune_defaults(rdev);
cc8dbbb4f62aa53 Alex Deucher 2013-08-14  5738  
cc8dbbb4f62aa53 Alex Deucher 2013-08-14  5739  	pi->caps_fps = false;
cc8dbbb4f62aa53 Alex Deucher 2013-08-14  5740  
cc8dbbb4f62aa53 Alex Deucher 2013-08-14  5741  	pi->caps_sclk_throttle_low_notification = false;
cc8dbbb4f62aa53 Alex Deucher 2013-08-14  5742  
9597fe1e6aa4a16 Alex Deucher 2013-08-23  5743  	pi->caps_uvd_dpm = true;
ee35b0024a9d85f Alex Deucher 2013-08-23  5744  	pi->caps_vce_dpm = true;
9597fe1e6aa4a16 Alex Deucher 2013-08-23  5745  
cc8dbbb4f62aa53 Alex Deucher 2013-08-14  5746  	ci_get_leakage_voltages(rdev);
cc8dbbb4f62aa53 Alex Deucher 2013-08-14  5747  	ci_patch_dependency_tables_with_leakage(rdev);
cc8dbbb4f62aa53 Alex Deucher 2013-08-14  5748  	ci_set_private_data_variables_based_on_pptable(rdev);
cc8dbbb4f62aa53 Alex Deucher 2013-08-14  5749  
cc8dbbb4f62aa53 Alex Deucher 2013-08-14  5750  	rdev->pm.dpm.dyn_state.vddc_dependency_on_dispclk.entries =
6396bb221514d28 Kees Cook    2018-06-12  5751  		kcalloc(4,
6396bb221514d28 Kees Cook    2018-06-12  5752  			sizeof(struct radeon_clock_voltage_dependency_entry),
6396bb221514d28 Kees Cook    2018-06-12  5753  			GFP_KERNEL);
cc8dbbb4f62aa53 Alex Deucher 2013-08-14  5754  	if (!rdev->pm.dpm.dyn_state.vddc_dependency_on_dispclk.entries) {
cc8dbbb4f62aa53 Alex Deucher 2013-08-14  5755  		ci_dpm_fini(rdev);
cc8dbbb4f62aa53 Alex Deucher 2013-08-14  5756  		return -ENOMEM;
cc8dbbb4f62aa53 Alex Deucher 2013-08-14  5757  	}
cc8dbbb4f62aa53 Alex Deucher 2013-08-14  5758  	rdev->pm.dpm.dyn_state.vddc_dependency_on_dispclk.count = 4;
cc8dbbb4f62aa53 Alex Deucher 2013-08-14  5759  	rdev->pm.dpm.dyn_state.vddc_dependency_on_dispclk.entries[0].clk = 0;
cc8dbbb4f62aa53 Alex Deucher 2013-08-14  5760  	rdev->pm.dpm.dyn_state.vddc_dependency_on_dispclk.entries[0].v = 0;
cc8dbbb4f62aa53 Alex Deucher 2013-08-14  5761  	rdev->pm.dpm.dyn_state.vddc_dependency_on_dispclk.entries[1].clk = 36000;
cc8dbbb4f62aa53 Alex Deucher 2013-08-14  5762  	rdev->pm.dpm.dyn_state.vddc_dependency_on_dispclk.entries[1].v = 720;
cc8dbbb4f62aa53 Alex Deucher 2013-08-14  5763  	rdev->pm.dpm.dyn_state.vddc_dependency_on_dispclk.entries[2].clk = 54000;
cc8dbbb4f62aa53 Alex Deucher 2013-08-14  5764  	rdev->pm.dpm.dyn_state.vddc_dependency_on_dispclk.entries[2].v = 810;
cc8dbbb4f62aa53 Alex Deucher 2013-08-14  5765  	rdev->pm.dpm.dyn_state.vddc_dependency_on_dispclk.entries[3].clk = 72000;
cc8dbbb4f62aa53 Alex Deucher 2013-08-14  5766  	rdev->pm.dpm.dyn_state.vddc_dependency_on_dispclk.entries[3].v = 900;
cc8dbbb4f62aa53 Alex Deucher 2013-08-14  5767  
cc8dbbb4f62aa53 Alex Deucher 2013-08-14  5768  	rdev->pm.dpm.dyn_state.mclk_sclk_ratio = 4;
cc8dbbb4f62aa53 Alex Deucher 2013-08-14  5769  	rdev->pm.dpm.dyn_state.sclk_mclk_delta = 15000;
cc8dbbb4f62aa53 Alex Deucher 2013-08-14  5770  	rdev->pm.dpm.dyn_state.vddc_vddci_delta = 200;
cc8dbbb4f62aa53 Alex Deucher 2013-08-14  5771  
cc8dbbb4f62aa53 Alex Deucher 2013-08-14  5772  	rdev->pm.dpm.dyn_state.valid_sclk_values.count = 0;
cc8dbbb4f62aa53 Alex Deucher 2013-08-14  5773  	rdev->pm.dpm.dyn_state.valid_sclk_values.values = NULL;
cc8dbbb4f62aa53 Alex Deucher 2013-08-14  5774  	rdev->pm.dpm.dyn_state.valid_mclk_values.count = 0;
cc8dbbb4f62aa53 Alex Deucher 2013-08-14  5775  	rdev->pm.dpm.dyn_state.valid_mclk_values.values = NULL;
cc8dbbb4f62aa53 Alex Deucher 2013-08-14  5776  
2d40038d3f99a48 Alex Deucher 2013-08-09  5777  	if (rdev->family == CHIP_HAWAII) {
2d40038d3f99a48 Alex Deucher 2013-08-09  5778  		pi->thermal_temp_setting.temperature_low = 94500;
2d40038d3f99a48 Alex Deucher 2013-08-09  5779  		pi->thermal_temp_setting.temperature_high = 95000;
2d40038d3f99a48 Alex Deucher 2013-08-09  5780  		pi->thermal_temp_setting.temperature_shutdown = 104000;
2d40038d3f99a48 Alex Deucher 2013-08-09  5781  	} else {
cc8dbbb4f62aa53 Alex Deucher 2013-08-14  5782  		pi->thermal_temp_setting.temperature_low = 99500;
cc8dbbb4f62aa53 Alex Deucher 2013-08-14  5783  		pi->thermal_temp_setting.temperature_high = 100000;
cc8dbbb4f62aa53 Alex Deucher 2013-08-14  5784  		pi->thermal_temp_setting.temperature_shutdown = 104000;
2d40038d3f99a48 Alex Deucher 2013-08-09  5785  	}
cc8dbbb4f62aa53 Alex Deucher 2013-08-14  5786  
cc8dbbb4f62aa53 Alex Deucher 2013-08-14  5787  	pi->uvd_enabled = false;
cc8dbbb4f62aa53 Alex Deucher 2013-08-14  5788  
34fc0b58d91f7ee Alex Deucher 2014-11-07  5789  	dpm_table = &pi->smc_state_table;
34fc0b58d91f7ee Alex Deucher 2014-11-07  5790  
34fc0b58d91f7ee Alex Deucher 2014-11-07  5791  	gpio = radeon_atombios_lookup_gpio(rdev, VDDC_VRHOT_GPIO_PINID);
34fc0b58d91f7ee Alex Deucher 2014-11-07  5792  	if (gpio.valid) {
34fc0b58d91f7ee Alex Deucher 2014-11-07  5793  		dpm_table->VRHotGpio = gpio.shift;
34fc0b58d91f7ee Alex Deucher 2014-11-07  5794  		rdev->pm.dpm.platform_caps |= ATOM_PP_PLATFORM_CAP_REGULATOR_HOT;
34fc0b58d91f7ee Alex Deucher 2014-11-07  5795  	} else {
34fc0b58d91f7ee Alex Deucher 2014-11-07  5796  		dpm_table->VRHotGpio = CISLANDS_UNUSED_GPIO_PIN;
34fc0b58d91f7ee Alex Deucher 2014-11-07  5797  		rdev->pm.dpm.platform_caps &= ~ATOM_PP_PLATFORM_CAP_REGULATOR_HOT;
34fc0b58d91f7ee Alex Deucher 2014-11-07  5798  	}
34fc0b58d91f7ee Alex Deucher 2014-11-07  5799  
34fc0b58d91f7ee Alex Deucher 2014-11-07  5800  	gpio = radeon_atombios_lookup_gpio(rdev, PP_AC_DC_SWITCH_GPIO_PINID);
34fc0b58d91f7ee Alex Deucher 2014-11-07  5801  	if (gpio.valid) {
34fc0b58d91f7ee Alex Deucher 2014-11-07  5802  		dpm_table->AcDcGpio = gpio.shift;
34fc0b58d91f7ee Alex Deucher 2014-11-07  5803  		rdev->pm.dpm.platform_caps |= ATOM_PP_PLATFORM_CAP_HARDWAREDC;
34fc0b58d91f7ee Alex Deucher 2014-11-07  5804  	} else {
34fc0b58d91f7ee Alex Deucher 2014-11-07  5805  		dpm_table->AcDcGpio = CISLANDS_UNUSED_GPIO_PIN;
34fc0b58d91f7ee Alex Deucher 2014-11-07  5806  		rdev->pm.dpm.platform_caps &= ~ATOM_PP_PLATFORM_CAP_HARDWAREDC;
34fc0b58d91f7ee Alex Deucher 2014-11-07  5807  	}
34fc0b58d91f7ee Alex Deucher 2014-11-07  5808  
34fc0b58d91f7ee Alex Deucher 2014-11-07  5809  	gpio = radeon_atombios_lookup_gpio(rdev, VDDC_PCC_GPIO_PINID);
34fc0b58d91f7ee Alex Deucher 2014-11-07  5810  	if (gpio.valid) {
34fc0b58d91f7ee Alex Deucher 2014-11-07  5811  		u32 tmp = RREG32_SMC(CNB_PWRMGT_CNTL);
34fc0b58d91f7ee Alex Deucher 2014-11-07  5812  
34fc0b58d91f7ee Alex Deucher 2014-11-07  5813  		switch (gpio.shift) {
34fc0b58d91f7ee Alex Deucher 2014-11-07  5814  		case 0:
34fc0b58d91f7ee Alex Deucher 2014-11-07  5815  			tmp &= ~GNB_SLOW_MODE_MASK;
34fc0b58d91f7ee Alex Deucher 2014-11-07  5816  			tmp |= GNB_SLOW_MODE(1);
34fc0b58d91f7ee Alex Deucher 2014-11-07  5817  			break;
34fc0b58d91f7ee Alex Deucher 2014-11-07  5818  		case 1:
34fc0b58d91f7ee Alex Deucher 2014-11-07  5819  			tmp &= ~GNB_SLOW_MODE_MASK;
34fc0b58d91f7ee Alex Deucher 2014-11-07  5820  			tmp |= GNB_SLOW_MODE(2);
34fc0b58d91f7ee Alex Deucher 2014-11-07  5821  			break;
34fc0b58d91f7ee Alex Deucher 2014-11-07  5822  		case 2:
34fc0b58d91f7ee Alex Deucher 2014-11-07  5823  			tmp |= GNB_SLOW;
34fc0b58d91f7ee Alex Deucher 2014-11-07  5824  			break;
34fc0b58d91f7ee Alex Deucher 2014-11-07  5825  		case 3:
34fc0b58d91f7ee Alex Deucher 2014-11-07  5826  			tmp |= FORCE_NB_PS1;
34fc0b58d91f7ee Alex Deucher 2014-11-07  5827  			break;
34fc0b58d91f7ee Alex Deucher 2014-11-07  5828  		case 4:
34fc0b58d91f7ee Alex Deucher 2014-11-07  5829  			tmp |= DPM_ENABLED;
34fc0b58d91f7ee Alex Deucher 2014-11-07  5830  			break;
34fc0b58d91f7ee Alex Deucher 2014-11-07  5831  		default:
bda5e3e97ffe80c Alex Deucher 2015-07-16  5832  			DRM_DEBUG("Invalid PCC GPIO: %u!\n", gpio.shift);
34fc0b58d91f7ee Alex Deucher 2014-11-07  5833  			break;
34fc0b58d91f7ee Alex Deucher 2014-11-07  5834  		}
34fc0b58d91f7ee Alex Deucher 2014-11-07  5835  		WREG32_SMC(CNB_PWRMGT_CNTL, tmp);
34fc0b58d91f7ee Alex Deucher 2014-11-07  5836  	}
34fc0b58d91f7ee Alex Deucher 2014-11-07  5837  
cc8dbbb4f62aa53 Alex Deucher 2013-08-14  5838  	pi->voltage_control = CISLANDS_VOLTAGE_CONTROL_NONE;
cc8dbbb4f62aa53 Alex Deucher 2013-08-14  5839  	pi->vddci_control = CISLANDS_VOLTAGE_CONTROL_NONE;
cc8dbbb4f62aa53 Alex Deucher 2013-08-14  5840  	pi->mvdd_control = CISLANDS_VOLTAGE_CONTROL_NONE;
cc8dbbb4f62aa53 Alex Deucher 2013-08-14  5841  	if (radeon_atom_is_voltage_gpio(rdev, VOLTAGE_TYPE_VDDC, VOLTAGE_OBJ_GPIO_LUT))
cc8dbbb4f62aa53 Alex Deucher 2013-08-14  5842  		pi->voltage_control = CISLANDS_VOLTAGE_CONTROL_BY_GPIO;
cc8dbbb4f62aa53 Alex Deucher 2013-08-14  5843  	else if (radeon_atom_is_voltage_gpio(rdev, VOLTAGE_TYPE_VDDC, VOLTAGE_OBJ_SVID2))
cc8dbbb4f62aa53 Alex Deucher 2013-08-14  5844  		pi->voltage_control = CISLANDS_VOLTAGE_CONTROL_BY_SVID2;
cc8dbbb4f62aa53 Alex Deucher 2013-08-14  5845  
cc8dbbb4f62aa53 Alex Deucher 2013-08-14  5846  	if (rdev->pm.dpm.platform_caps & ATOM_PP_PLATFORM_CAP_VDDCI_CONTROL) {
cc8dbbb4f62aa53 Alex Deucher 2013-08-14  5847  		if (radeon_atom_is_voltage_gpio(rdev, VOLTAGE_TYPE_VDDCI, VOLTAGE_OBJ_GPIO_LUT))
cc8dbbb4f62aa53 Alex Deucher 2013-08-14  5848  			pi->vddci_control = CISLANDS_VOLTAGE_CONTROL_BY_GPIO;
cc8dbbb4f62aa53 Alex Deucher 2013-08-14  5849  		else if (radeon_atom_is_voltage_gpio(rdev, VOLTAGE_TYPE_VDDCI, VOLTAGE_OBJ_SVID2))
cc8dbbb4f62aa53 Alex Deucher 2013-08-14  5850  			pi->vddci_control = CISLANDS_VOLTAGE_CONTROL_BY_SVID2;
cc8dbbb4f62aa53 Alex Deucher 2013-08-14  5851  		else
cc8dbbb4f62aa53 Alex Deucher 2013-08-14  5852  			rdev->pm.dpm.platform_caps &= ~ATOM_PP_PLATFORM_CAP_VDDCI_CONTROL;
cc8dbbb4f62aa53 Alex Deucher 2013-08-14  5853  	}
cc8dbbb4f62aa53 Alex Deucher 2013-08-14  5854  
cc8dbbb4f62aa53 Alex Deucher 2013-08-14  5855  	if (rdev->pm.dpm.platform_caps & ATOM_PP_PLATFORM_CAP_MVDDCONTROL) {
cc8dbbb4f62aa53 Alex Deucher 2013-08-14  5856  		if (radeon_atom_is_voltage_gpio(rdev, VOLTAGE_TYPE_MVDDC, VOLTAGE_OBJ_GPIO_LUT))
cc8dbbb4f62aa53 Alex Deucher 2013-08-14  5857  			pi->mvdd_control = CISLANDS_VOLTAGE_CONTROL_BY_GPIO;
cc8dbbb4f62aa53 Alex Deucher 2013-08-14  5858  		else if (radeon_atom_is_voltage_gpio(rdev, VOLTAGE_TYPE_MVDDC, VOLTAGE_OBJ_SVID2))
cc8dbbb4f62aa53 Alex Deucher 2013-08-14  5859  			pi->mvdd_control = CISLANDS_VOLTAGE_CONTROL_BY_SVID2;
cc8dbbb4f62aa53 Alex Deucher 2013-08-14  5860  		else
cc8dbbb4f62aa53 Alex Deucher 2013-08-14  5861  			rdev->pm.dpm.platform_caps &= ~ATOM_PP_PLATFORM_CAP_MVDDCONTROL;
cc8dbbb4f62aa53 Alex Deucher 2013-08-14  5862  	}
cc8dbbb4f62aa53 Alex Deucher 2013-08-14  5863  
cc8dbbb4f62aa53 Alex Deucher 2013-08-14  5864  	pi->vddc_phase_shed_control = true;
cc8dbbb4f62aa53 Alex Deucher 2013-08-14  5865  

:::::: The code at line 5637 was first introduced by commit
:::::: cc8dbbb4f62aa53e604e7c61dedc03ee4e8dfed4 drm/radeon: add dpm support for CI dGPUs (v2)

:::::: TO: Alex Deucher <alexander.deucher@amd.com>
:::::: CC: Alex Deucher <alexander.deucher@amd.com>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
