Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A27F70E244
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 18:49:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237800AbjEWQsN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 12:48:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237806AbjEWQsL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 12:48:11 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E0B4E6;
        Tue, 23 May 2023 09:48:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684860490; x=1716396490;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=HW6IhTyUueCSfeJ7rWfhSJdEaQsGNU+FlBIEnOYHN0k=;
  b=J45rhaKL9O38OhbDRvgyNQVt/B1Znlk1o4qQF4joL0QfV3d3LBiNlIi6
   C7TxBGMwSnsCF94nx8yLoF26TJgMmj4mUHKVLeHlF0d9hpvJryx9paEq6
   OQEHHYGCpxCaGXKfFt8jJ8LPbceOE0mQOq1ZtZvbU2e9kD1ayyFQVHaCZ
   27dfYrW97Y5PfQivM8hKCVuR5AWpDw5sLynCZaJYLqdf91Esmpc4GK7A2
   bu1C/wVuGEY6PP7njB/GEx9MGc7qRav5F7ptKB+fY8egrsj4gB+q+ptTR
   dZik2kGRVf5JQhazJiDeem2NPTmY6zmKNusMCEwSFs/rHzYeKBap5KZb5
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10719"; a="342759206"
X-IronPort-AV: E=Sophos;i="6.00,186,1681196400"; 
   d="scan'208";a="342759206"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2023 09:48:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10719"; a="1034152694"
X-IronPort-AV: E=Sophos;i="6.00,186,1681196400"; 
   d="scan'208";a="1034152694"
Received: from lkp-server01.sh.intel.com (HELO dea6d5a4f140) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 23 May 2023 09:46:22 -0700
Received: from kbuild by dea6d5a4f140 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1q1V9R-000Dw1-2I;
        Tue, 23 May 2023 16:46:21 +0000
Date:   Wed, 24 May 2023 00:45:36 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kiwoong Kim <kwmad.kim@samsung.com>, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, alim.akhtar@samsung.com,
        avri.altman@wdc.com, bvanassche@acm.org, jejb@linux.ibm.com,
        martin.petersen@oracle.com, beanhuo@micron.com,
        adrian.hunter@intel.com, sc.suh@samsung.com, hy50.seo@samsung.com,
        sh425.lee@samsung.com, kwangwon.min@samsung.com,
        junwoo80.lee@samsung.com
Cc:     oe-kbuild-all@lists.linux.dev, Kiwoong Kim <kwmad.kim@samsung.com>
Subject: Re: [PATCH v1 1/3] ufs: make __ufshcd_send_uic_cmd not wrapped by
 host_lock
Message-ID: <202305240017.qlNZOZVe-lkp@intel.com>
References: <c511c7f03ce77a604aa5211c3ffac96022c3ee40.1684822284.git.kwmad.kim@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c511c7f03ce77a604aa5211c3ffac96022c3ee40.1684822284.git.kwmad.kim@samsung.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kiwoong,

kernel test robot noticed the following build warnings:

[auto build test WARNING on v6.4-rc3]
[also build test WARNING on linus/master next-20230523]
[cannot apply to jejb-scsi/for-next mkp-scsi/for-next]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Kiwoong-Kim/ufs-poll-HCS-UCRDY-before-issuing-a-UIC-command/20230523-215413
base:   44c026a73be8038f03dbdeef028b642880cf1511
patch link:    https://lore.kernel.org/r/c511c7f03ce77a604aa5211c3ffac96022c3ee40.1684822284.git.kwmad.kim%40samsung.com
patch subject: [PATCH v1 1/3] ufs: make __ufshcd_send_uic_cmd not wrapped by host_lock
config: x86_64-allmodconfig (https://download.01.org/0day-ci/archive/20230524/202305240017.qlNZOZVe-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-12) 11.3.0
reproduce (this is a W=1 build):
        # https://github.com/intel-lab-lkp/linux/commit/c3fdde6dc3c766e3141c3ed43ae136ceb345c1c1
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Kiwoong-Kim/ufs-poll-HCS-UCRDY-before-issuing-a-UIC-command/20230523-215413
        git checkout c3fdde6dc3c766e3141c3ed43ae136ceb345c1c1
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=x86_64 olddefconfig
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash drivers/ufs/core/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202305240017.qlNZOZVe-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/ufs/core/ufshcd.c: In function 'ufshcd_send_uic_cmd':
>> drivers/ufs/core/ufshcd.c:2479:23: warning: unused variable 'flags' [-Wunused-variable]
    2479 |         unsigned long flags;
         |                       ^~~~~


vim +/flags +2479 drivers/ufs/core/ufshcd.c

6ccf44fe4cd7c4 drivers/scsi/ufs/ufshcd.c Seungwon Jeon    2013-06-26  2468  
6ccf44fe4cd7c4 drivers/scsi/ufs/ufshcd.c Seungwon Jeon    2013-06-26  2469  /**
6ccf44fe4cd7c4 drivers/scsi/ufs/ufshcd.c Seungwon Jeon    2013-06-26  2470   * ufshcd_send_uic_cmd - Send UIC commands and retrieve the result
6ccf44fe4cd7c4 drivers/scsi/ufs/ufshcd.c Seungwon Jeon    2013-06-26  2471   * @hba: per adapter instance
6ccf44fe4cd7c4 drivers/scsi/ufs/ufshcd.c Seungwon Jeon    2013-06-26  2472   * @uic_cmd: UIC command
6ccf44fe4cd7c4 drivers/scsi/ufs/ufshcd.c Seungwon Jeon    2013-06-26  2473   *
6ccf44fe4cd7c4 drivers/scsi/ufs/ufshcd.c Seungwon Jeon    2013-06-26  2474   * Returns 0 only if success.
6ccf44fe4cd7c4 drivers/scsi/ufs/ufshcd.c Seungwon Jeon    2013-06-26  2475   */
e77044c5a8422e drivers/scsi/ufs/ufshcd.c Avri Altman      2018-10-07  2476  int ufshcd_send_uic_cmd(struct ufs_hba *hba, struct uic_command *uic_cmd)
6ccf44fe4cd7c4 drivers/scsi/ufs/ufshcd.c Seungwon Jeon    2013-06-26  2477  {
6ccf44fe4cd7c4 drivers/scsi/ufs/ufshcd.c Seungwon Jeon    2013-06-26  2478  	int ret;
57d104c153d3d6 drivers/scsi/ufs/ufshcd.c Subhash Jadavani 2014-09-25 @2479  	unsigned long flags;
6ccf44fe4cd7c4 drivers/scsi/ufs/ufshcd.c Seungwon Jeon    2013-06-26  2480  
a22bcfdbf10b41 drivers/scsi/ufs/ufshcd.c jongmin jeong    2021-10-18  2481  	if (hba->quirks & UFSHCD_QUIRK_BROKEN_UIC_CMD)
a22bcfdbf10b41 drivers/scsi/ufs/ufshcd.c jongmin jeong    2021-10-18  2482  		return 0;
a22bcfdbf10b41 drivers/scsi/ufs/ufshcd.c jongmin jeong    2021-10-18  2483  
1ab27c9cf8b63d drivers/scsi/ufs/ufshcd.c Sahitya Tummala  2014-09-25  2484  	ufshcd_hold(hba, false);
6ccf44fe4cd7c4 drivers/scsi/ufs/ufshcd.c Seungwon Jeon    2013-06-26  2485  	mutex_lock(&hba->uic_cmd_mutex);
cad2e03d860779 drivers/scsi/ufs/ufshcd.c Yaniv Gardi      2015-03-31  2486  	ufshcd_add_delay_before_dme_cmd(hba);
cad2e03d860779 drivers/scsi/ufs/ufshcd.c Yaniv Gardi      2015-03-31  2487  
d75f7fe495cf57 drivers/scsi/ufs/ufshcd.c Yaniv Gardi      2016-02-01  2488  	ret = __ufshcd_send_uic_cmd(hba, uic_cmd, true);
57d104c153d3d6 drivers/scsi/ufs/ufshcd.c Subhash Jadavani 2014-09-25  2489  	if (!ret)
57d104c153d3d6 drivers/scsi/ufs/ufshcd.c Subhash Jadavani 2014-09-25  2490  		ret = ufshcd_wait_for_uic_cmd(hba, uic_cmd);
57d104c153d3d6 drivers/scsi/ufs/ufshcd.c Subhash Jadavani 2014-09-25  2491  
6ccf44fe4cd7c4 drivers/scsi/ufs/ufshcd.c Seungwon Jeon    2013-06-26  2492  	mutex_unlock(&hba->uic_cmd_mutex);
6ccf44fe4cd7c4 drivers/scsi/ufs/ufshcd.c Seungwon Jeon    2013-06-26  2493  
1ab27c9cf8b63d drivers/scsi/ufs/ufshcd.c Sahitya Tummala  2014-09-25  2494  	ufshcd_release(hba);
6ccf44fe4cd7c4 drivers/scsi/ufs/ufshcd.c Seungwon Jeon    2013-06-26  2495  	return ret;
6ccf44fe4cd7c4 drivers/scsi/ufs/ufshcd.c Seungwon Jeon    2013-06-26  2496  }
6ccf44fe4cd7c4 drivers/scsi/ufs/ufshcd.c Seungwon Jeon    2013-06-26  2497  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
