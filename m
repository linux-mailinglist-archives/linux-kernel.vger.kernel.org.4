Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6CAA6EA39F
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 08:16:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229587AbjDUGQq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Apr 2023 02:16:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229573AbjDUGQJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Apr 2023 02:16:09 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E54083FB;
        Thu, 20 Apr 2023 23:16:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682057768; x=1713593768;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=9eud3u4+mkWYwqeIwbUATFLc797StiR+cc7u4K8A5yo=;
  b=iNTXjqf62jINq1Bbc2UZSl+sAiOFhcMeC/Ww0D9M+hYez0YIqpn3Hk77
   lr/SxkiUKk1ar1olel9MonmJHip+n4xTZ5n8P08yrc8oL7sF8RizQcUXC
   xrR/G55JcGYyzdYzExZcXyqd6axmcmcOpTq2kis0Fad1uo42fvgz23Nvo
   QuSyp8qeF+oceCNVnhRTYbiHLAYfjPfra/3VaSvQa8Z9CX2Ky+6ExpVeG
   ji2+feeezhlfOtLQDC1F9WuEphd1ow85HG683wDdTCXqoTSUEBObEOrMw
   vikN2q4b5wf1OhkzzQrEfy8fGnGgH9zorNr4NvHfwR8MVir/MfgcHbkRP
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10686"; a="330124513"
X-IronPort-AV: E=Sophos;i="5.99,214,1677571200"; 
   d="scan'208";a="330124513"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2023 23:16:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10686"; a="1021816705"
X-IronPort-AV: E=Sophos;i="5.99,214,1677571200"; 
   d="scan'208";a="1021816705"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 20 Apr 2023 23:16:05 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1ppk3w-000gNW-34;
        Fri, 21 Apr 2023 06:16:04 +0000
Date:   Fri, 21 Apr 2023 14:15:25 +0800
From:   kernel test robot <lkp@intel.com>
To:     Mario Limonciello <mario.limonciello@amd.com>, rafael@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     oe-kbuild-all@lists.linux.dev, linux-pm@vger.kernel.org,
        Shyam-sundar.S-k@amd.com,
        Mario Limonciello <mario.limonciello@amd.com>,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org
Subject: Re: [PATCH] ACPI: x86: Separate out the Microsoft _DSM function calls
Message-ID: <202304211425.SUKWdyf7-lkp@intel.com>
References: <20230420160923.14127-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230420160923.14127-1-mario.limonciello@amd.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
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
config: x86_64-defconfig (https://download.01.org/0day-ci/archive/20230421/202304211425.SUKWdyf7-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-8) 11.3.0
reproduce (this is a W=1 build):
        # https://github.com/intel-lab-lkp/linux/commit/e4ea0d2f15f2d0486bc3b4f59cbf9cea6c63fda1
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Mario-Limonciello/ACPI-x86-Separate-out-the-Microsoft-_DSM-function-calls/20230421-001547
        git checkout e4ea0d2f15f2d0486bc3b4f59cbf9cea6c63fda1
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=x86_64 olddefconfig
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash drivers/acpi/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202304211425.SUKWdyf7-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/acpi/x86/s2idle.c:552:6: warning: no previous prototype for 'lps0_s2idle_wake' [-Wmissing-prototypes]
     552 | bool lps0_s2idle_wake(void)
         |      ^~~~~~~~~~~~~~~~


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
