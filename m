Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F5A96ECBF0
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 14:20:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231556AbjDXMUx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 08:20:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbjDXMUv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 08:20:51 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E832B271D;
        Mon, 24 Apr 2023 05:20:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682338850; x=1713874850;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=4KfjW5andPwqW6uLOs9vLZL8WFNeU3iKh7SfGRSAdnM=;
  b=fUj8tAEPQ7cO26f/gD55mVT0nMeNivF9OrukEJ4w5XIhHDJtPK2h733k
   zRap9H/wqt1Uu6J7IID/1DKTm5cBupFYf43OHk5F0McPTnC85m+dcrmkF
   sHR84EXxRB6/icsEjuG6wLIPYWlUmFzlW0Zxmo31yPagh06R9eYqFaDC5
   UZmCN5Qg51BYxncLent9s8aQTvc6DZPxZ929YIjMT9HaiPqRU3kkhUnD3
   zmUaGJ7CL1QACoj4dCGrC63ExfwnF2eybErwHjzx4NsEXxT+VX/hVwBpl
   qSLcblaSdgh9uN4RTQbb/bW0aLK0RUX+Rzwf26SGhQbi1C0XMvSSEceu1
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10689"; a="411713521"
X-IronPort-AV: E=Sophos;i="5.99,222,1677571200"; 
   d="scan'208";a="411713521"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2023 05:20:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10689"; a="686821618"
X-IronPort-AV: E=Sophos;i="5.99,222,1677571200"; 
   d="scan'208";a="686821618"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 24 Apr 2023 05:20:46 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pqvBV-000iNc-0d;
        Mon, 24 Apr 2023 12:20:45 +0000
Date:   Mon, 24 Apr 2023 20:20:28 +0800
From:   kernel test robot <lkp@intel.com>
To:     Mario Limonciello <mario.limonciello@amd.com>, rafael@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        linux-pm@vger.kernel.org, Shyam-sundar.S-k@amd.com,
        Mario Limonciello <mario.limonciello@amd.com>,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org
Subject: Re: [PATCH] ACPI: x86: Separate out the Microsoft _DSM function calls
Message-ID: <202304242025.fz8SDA8d-lkp@intel.com>
References: <20230420160923.14127-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230420160923.14127-1-mario.limonciello@amd.com>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mario,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 7124d7671af0facf115d70f9d1fadde0d768d325]

url:    https://github.com/intel-lab-lkp/linux/commits/Mario-Limonciello/ACPI-x86-Separate-out-the-Microsoft-_DSM-function-calls/20230421-001547
base:   7124d7671af0facf115d70f9d1fadde0d768d325
patch link:    https://lore.kernel.org/r/20230420160923.14127-1-mario.limonciello%40amd.com
patch subject: [PATCH] ACPI: x86: Separate out the Microsoft _DSM function calls
config: i386-randconfig-a002-20230424 (https://download.01.org/0day-ci/archive/20230424/202304242025.fz8SDA8d-lkp@intel.com/config)
compiler: clang version 14.0.6 (https://github.com/llvm/llvm-project f28c006a5895fc0e329fe15fead81e37457cb1d1)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/e4ea0d2f15f2d0486bc3b4f59cbf9cea6c63fda1
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Mario-Limonciello/ACPI-x86-Separate-out-the-Microsoft-_DSM-function-calls/20230421-001547
        git checkout e4ea0d2f15f2d0486bc3b4f59cbf9cea6c63fda1
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 SHELL=/bin/bash drivers/acpi/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202304242025.fz8SDA8d-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/acpi/x86/s2idle.c:552:6: warning: no previous prototype for function 'lps0_s2idle_wake' [-Wmissing-prototypes]
   bool lps0_s2idle_wake(void)
        ^
   drivers/acpi/x86/s2idle.c:552:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   bool lps0_s2idle_wake(void)
   ^
   static 
   1 warning generated.


vim +/lps0_s2idle_wake +552 drivers/acpi/x86/s2idle.c

   551	
 > 552	bool lps0_s2idle_wake(void)
   553	{
   554		if (!lps0_device_handle || sleep_no_lps0)
   555			goto out;
   556	
   557		/* avoid running on the first go through the s2idle loop */
   558		if (lps0_dsm_func_mask_microsoft > 0) {
   559			int target;
   560	
   561			if (lps0_dsm_state == ACPI_LPS0_ENTRY ||
   562			    lps0_dsm_state == ACPI_LPS0_MS_EXIT)
   563				target = ACPI_LPS0_MS_ENTRY;
   564			else
   565				target = ACPI_LPS0_MS_EXIT;
   566			acpi_sleep_run_lps0_dsm(target,
   567						lps0_dsm_func_mask_microsoft,
   568						lps0_dsm_guid_microsoft);
   569		}
   570	out:
   571		return acpi_s2idle_wake();
   572	}
   573	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
