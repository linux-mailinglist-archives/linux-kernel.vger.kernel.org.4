Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28F5B6763D9
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Jan 2023 05:43:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229643AbjAUEnE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 23:43:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229644AbjAUEm7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 23:42:59 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BB745087D;
        Fri, 20 Jan 2023 20:42:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674276178; x=1705812178;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=kCNVyHhNIwA6ePSSurZL/eEV1rQKY6c6i+QOq90+b+E=;
  b=kmqG6J2vFT7UdEGDgmvEqud7RpoYr9Lk46jcQXGESbZltPaHwROfvyC4
   k0N3XxmuM0fR76oUdC6NTwi83KNqvRKcFEKmphGW8KJ5l26L3q9uxuFd8
   +D2fny0H2RWwaATNHmd6rr9NW0iQ8o4+u1Jc2KM7rjDEz8z3eYLn88v+s
   Gvg6bFhR6hnMybsjs67EKJVNX3XMP9Nxan5+mX/K6/uFvxgZP6Ogh/qmQ
   3LrMTQaOA1fu1iey/FMrCrimEdukOZWKUxHWhoCaO6oVo1S8HU3ZcpfiL
   sUR8wDsUrRChEJ8BvY7E4AnH8catPbCyBSvggVRtnR+0QIZioiMhgTi6G
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10596"; a="306117863"
X-IronPort-AV: E=Sophos;i="5.97,234,1669104000"; 
   d="scan'208";a="306117863"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2023 20:42:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10596"; a="662767018"
X-IronPort-AV: E=Sophos;i="5.97,234,1669104000"; 
   d="scan'208";a="662767018"
Received: from lkp-server01.sh.intel.com (HELO 5646d64e7320) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 20 Jan 2023 20:42:52 -0800
Received: from kbuild by 5646d64e7320 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pJ5iN-0003Ua-0d;
        Sat, 21 Jan 2023 04:42:51 +0000
Date:   Sat, 21 Jan 2023 12:42:35 +0800
From:   kernel test robot <lkp@intel.com>
To:     Anjana Hari <quic_ahari@quicinc.com>, agross@kernel.org,
        andersson@kernel.org, jejb@linux.ibm.com,
        martin.petersen@oracle.com
Cc:     oe-kbuild-all@lists.linux.dev, alim.akhtar@samsung.com,
        avri.altman@wdc.com, bvanassche@acm.org, konrad.dybcio@linaro.org,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_narepall@quicinc.com, quic_nitirawa@quicinc.com,
        quic_rampraka@quicinc.com, Anjana Hari <quic_ahari@quicinc.com>
Subject: Re: [PATCH v3 1/1] scsi: ufs: Add hibernation callbacks
Message-ID: <202301211209.zKDppcLI-lkp@intel.com>
References: <20230120113321.30433-2-quic_ahari@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230120113321.30433-2-quic_ahari@quicinc.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Anjana,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on mkp-scsi/for-next]
[also build test ERROR on next-20230120]
[cannot apply to jejb-scsi/for-next linus/master v6.2-rc4]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Anjana-Hari/scsi-ufs-Add-hibernation-callbacks/20230120-193447
base:   https://git.kernel.org/pub/scm/linux/kernel/git/mkp/scsi.git for-next
patch link:    https://lore.kernel.org/r/20230120113321.30433-2-quic_ahari%40quicinc.com
patch subject: [PATCH v3 1/1] scsi: ufs: Add hibernation callbacks
config: arc-randconfig-r043-20230119 (https://download.01.org/0day-ci/archive/20230121/202301211209.zKDppcLI-lkp@intel.com/config)
compiler: arceb-elf-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/239ad2244616006dd39bc9a5380108435d168a86
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Anjana-Hari/scsi-ufs-Add-hibernation-callbacks/20230120-193447
        git checkout 239ad2244616006dd39bc9a5380108435d168a86
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=arc olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=arc SHELL=/bin/bash drivers/ufs/core/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   drivers/ufs/core/ufshcd.c: In function 'ufshcd_system_freeze':
>> drivers/ufs/core/ufshcd.c:10004:15: error: implicit declaration of function 'ufshcd_system_suspend'; did you mean 'trace_ufshcd_system_suspend'? [-Werror=implicit-function-declaration]
   10004 |         ret = ufshcd_system_suspend(dev);
         |               ^~~~~~~~~~~~~~~~~~~~~
         |               trace_ufshcd_system_suspend
   drivers/ufs/core/ufshcd.c: In function 'ufshcd_system_restore':
>> drivers/ufs/core/ufshcd.c:10017:16: error: implicit declaration of function 'ufshcd_system_resume'; did you mean 'ufshcd_system_restore'? [-Werror=implicit-function-declaration]
   10017 |         return ufshcd_system_resume(dev);
         |                ^~~~~~~~~~~~~~~~~~~~
         |                ufshcd_system_restore
   cc1: some warnings being treated as errors


vim +10004 drivers/ufs/core/ufshcd.c

  9993	
  9994		struct ufs_hba *hba = dev_get_drvdata(dev);
  9995		int ret = 0;
  9996	
  9997		/*
  9998		 * Run time resume the controller to make sure
  9999		 * the PM work queue threads do not try to resume
 10000		 * the child (scsi host), which leads to errors as
 10001		 * the controller is not yet resumed.
 10002		 */
 10003		pm_runtime_get_sync(hba->dev);
 10004		ret = ufshcd_system_suspend(dev);
 10005		pm_runtime_put_sync(hba->dev);
 10006	
 10007		return ret;
 10008	}
 10009	EXPORT_SYMBOL_GPL(ufshcd_system_freeze);
 10010	
 10011	int ufshcd_system_restore(struct device *dev)
 10012	{
 10013	
 10014		struct ufs_hba *hba = dev_get_drvdata(dev);
 10015	
 10016		hba->restore = true;
 10017		return ufshcd_system_resume(dev);
 10018	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
