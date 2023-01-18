Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81388671FC6
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 15:38:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231434AbjAROiC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 09:38:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231341AbjAROhl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 09:37:41 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13D26366A3;
        Wed, 18 Jan 2023 06:26:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674052017; x=1705588017;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=bShIF2GzN0uCjfJDJnHZS1KX11YWPQMysT+sSLBfayw=;
  b=epX4rTXnAtqmFGzxEYmG/Ivu0oLoT+HDjs4jvOTsoKWN6J43OlI/iVnG
   Mg9vLyVKiUedBmtGXlur/J4FDF/hqc0oA6dLvEpN4Ucrg9Sxyk/dfXmyY
   5mmMpq3x4nwE1uDPYavls4iq+J+8RlDrMAQ2uY2cQ93RDZM1ReFWAJ0h7
   XcvF2n6QHHi/n47wlR6DTWev0f+S74hyJWwgUcgEJA4kkblSrLbLRHU/r
   7hFuEtmywoNk2tTeauG+++YpStMg2tMyMRSdNZyHp9enWUsLfrIMPyN2v
   vwmbKSjR2ivu3qlebifOwveJ54AouYs6jNizCydSgPm9lBz/uW724rAAA
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10593"; a="323678285"
X-IronPort-AV: E=Sophos;i="5.97,226,1669104000"; 
   d="scan'208";a="323678285"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2023 06:26:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10593"; a="652961213"
X-IronPort-AV: E=Sophos;i="5.97,226,1669104000"; 
   d="scan'208";a="652961213"
Received: from lkp-server01.sh.intel.com (HELO 5646d64e7320) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 18 Jan 2023 06:26:51 -0800
Received: from kbuild by 5646d64e7320 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pI9Ot-0000Qe-0n;
        Wed, 18 Jan 2023 14:26:51 +0000
Date:   Wed, 18 Jan 2023 22:26:03 +0800
From:   kernel test robot <lkp@intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        Shravan Sudhakar <s.shravan@intel.com>,
        Intel Corporation <linuxwwan@intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>
Subject: Re: [PATCH v1 1/1] platform/x86: int1092: Switch to use
 acpi_evaluate_dsm_typed()
Message-ID: <202301182233.vDnTdKEG-lkp@intel.com>
References: <20230118095152.41427-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230118095152.41427-1-andriy.shevchenko@linux.intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy,

I love your patch! Perhaps something to improve:

[auto build test WARNING on linus/master]
[also build test WARNING on v6.2-rc4 next-20230118]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Andy-Shevchenko/platform-x86-int1092-Switch-to-use-acpi_evaluate_dsm_typed/20230118-184845
patch link:    https://lore.kernel.org/r/20230118095152.41427-1-andriy.shevchenko%40linux.intel.com
patch subject: [PATCH v1 1/1] platform/x86: int1092: Switch to use acpi_evaluate_dsm_typed()
config: i386-randconfig-a004-20230116 (https://download.01.org/0day-ci/archive/20230118/202301182233.vDnTdKEG-lkp@intel.com/config)
compiler: clang version 14.0.6 (https://github.com/llvm/llvm-project f28c006a5895fc0e329fe15fead81e37457cb1d1)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/6051c9fba08cdbd6ea1baeac8664b8f4462b427d
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Andy-Shevchenko/platform-x86-int1092-Switch-to-use-acpi_evaluate_dsm_typed/20230118-184845
        git checkout 6051c9fba08cdbd6ea1baeac8664b8f4462b427d
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 SHELL=/bin/bash drivers/platform/x86/intel/int1092/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/platform/x86/intel/int1092/intel_sar.c:134:6: warning: unused variable 'value' [-Wunused-variable]
           int value;
               ^
   1 warning generated.


vim +/value +134 drivers/platform/x86/intel/int1092/intel_sar.c

dcfbd31ef4bcf6 Shravan S       2021-07-24  117  
dcfbd31ef4bcf6 Shravan S       2021-07-24  118  /**
dcfbd31ef4bcf6 Shravan S       2021-07-24  119   * sar_get_device_mode: Extraction of information from BIOS via DSM calls
dcfbd31ef4bcf6 Shravan S       2021-07-24  120   * @device: ACPI device for which to retrieve the data
dcfbd31ef4bcf6 Shravan S       2021-07-24  121   *
dcfbd31ef4bcf6 Shravan S       2021-07-24  122   * Retrieve the current device mode information from the BIOS.
dcfbd31ef4bcf6 Shravan S       2021-07-24  123   *
dcfbd31ef4bcf6 Shravan S       2021-07-24  124   * Return:
dcfbd31ef4bcf6 Shravan S       2021-07-24  125   * AE_OK on success
dcfbd31ef4bcf6 Shravan S       2021-07-24  126   * AE_ERROR on error
dcfbd31ef4bcf6 Shravan S       2021-07-24  127   */
dcfbd31ef4bcf6 Shravan S       2021-07-24  128  static acpi_status sar_get_device_mode(struct platform_device *device)
dcfbd31ef4bcf6 Shravan S       2021-07-24  129  {
dcfbd31ef4bcf6 Shravan S       2021-07-24  130  	struct wwan_sar_context *context = dev_get_drvdata(&device->dev);
dcfbd31ef4bcf6 Shravan S       2021-07-24  131  	acpi_status status = AE_OK;
dcfbd31ef4bcf6 Shravan S       2021-07-24  132  	union acpi_object *out;
dcfbd31ef4bcf6 Shravan S       2021-07-24  133  	u32 rev = 0;
dcfbd31ef4bcf6 Shravan S       2021-07-24 @134  	int value;
dcfbd31ef4bcf6 Shravan S       2021-07-24  135  
6051c9fba08cdb Andy Shevchenko 2023-01-18  136  	out = acpi_evaluate_dsm_typed(context->handle, &context->guid, rev,
6051c9fba08cdb Andy Shevchenko 2023-01-18  137  				      COMMAND_ID_DEV_MODE, NULL, ACPI_TYPE_INTEGER);
6051c9fba08cdb Andy Shevchenko 2023-01-18  138  	if (!out) {
dcfbd31ef4bcf6 Shravan S       2021-07-24  139  		dev_err(&device->dev, "DSM cmd:%d Failed to retrieve value\n", COMMAND_ID_DEV_MODE);
dcfbd31ef4bcf6 Shravan S       2021-07-24  140  		status = AE_ERROR;
dcfbd31ef4bcf6 Shravan S       2021-07-24  141  		goto dev_mode_error;
dcfbd31ef4bcf6 Shravan S       2021-07-24  142  	}
6051c9fba08cdb Andy Shevchenko 2023-01-18  143  	context->sar_data.device_mode = out->integer.value;
dcfbd31ef4bcf6 Shravan S       2021-07-24  144  	update_sar_data(context);
dcfbd31ef4bcf6 Shravan S       2021-07-24  145  	sysfs_notify(&device->dev.kobj, NULL, SYSFS_DATANAME);
dcfbd31ef4bcf6 Shravan S       2021-07-24  146  
dcfbd31ef4bcf6 Shravan S       2021-07-24  147  dev_mode_error:
dcfbd31ef4bcf6 Shravan S       2021-07-24  148  	ACPI_FREE(out);
dcfbd31ef4bcf6 Shravan S       2021-07-24  149  	return status;
dcfbd31ef4bcf6 Shravan S       2021-07-24  150  }
dcfbd31ef4bcf6 Shravan S       2021-07-24  151  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
