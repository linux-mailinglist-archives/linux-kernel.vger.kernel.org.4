Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E26047308D4
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 21:54:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234666AbjFNTym (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 15:54:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234621AbjFNTyP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 15:54:15 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09FCC10A;
        Wed, 14 Jun 2023 12:54:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686772454; x=1718308454;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=o3obp4i2jUIjt8vzR2TGZg5v1YKLTj/rBX9LHefdqSg=;
  b=bAAuQ/qjwD0pbsh/Wm9NO7SAZpI07Q5sUVaKamXMWGe7IF4H9za2AHzQ
   1WQyt9LyWWJ15JzY6r7/OPv17BzcS6GWXBfGxe0WzzRpenK7p6xbvfOnC
   LY2SYCHrrmP96pNQugsrwfPoRK+vK6UB5+HDSHdrJTC9j2HfdXSGUeYFV
   9Afs9SlaOTABQ7wPiOn8ICSMpKiLkAqdBt0ezPD9tUhiaQYXPbFuygbcX
   f/+MGcuSi3QmodTmYYEpadet8LqWQsvJiT78BDCbf1fPSVqzN7B67tK/J
   VO/5TJSlc19z5nTdc6/JRHAgLiwKk8LcoDd0UhnVY7OOZD8Xqe/gKijlN
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10741"; a="339070183"
X-IronPort-AV: E=Sophos;i="6.00,243,1681196400"; 
   d="scan'208";a="339070183"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2023 12:54:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10741"; a="706355766"
X-IronPort-AV: E=Sophos;i="6.00,243,1681196400"; 
   d="scan'208";a="706355766"
Received: from lkp-server02.sh.intel.com (HELO d59cacf64e9e) ([10.239.97.151])
  by orsmga007.jf.intel.com with ESMTP; 14 Jun 2023 12:53:59 -0700
Received: from kbuild by d59cacf64e9e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1q9WYh-000123-2X;
        Wed, 14 Jun 2023 19:53:44 +0000
Date:   Thu, 15 Jun 2023 03:51:05 +0800
From:   kernel test robot <lkp@intel.com>
To:     JuenKit Yip <JuenKit_Yip@hotmail.com>, linux@roeck-us.net,
        jdelvare@suse.com
Cc:     oe-kbuild-all@lists.linux.dev, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org, JuenKit Yip <JuenKit_Yip@hotmail.com>
Subject: Re: [PATCH 2/3] hwmon: (sht3x) add medium repeatability support
Message-ID: <202306150333.vy0slw1N-lkp@intel.com>
References: <DB4PR10MB62615481D91BA8A598234A18925AA@DB4PR10MB6261.EURPRD10.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DB4PR10MB62615481D91BA8A598234A18925AA@DB4PR10MB6261.EURPRD10.PROD.OUTLOOK.COM>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi JuenKit,

kernel test robot noticed the following build warnings:

[auto build test WARNING on groeck-staging/hwmon-next]
[also build test WARNING on linus/master v6.4-rc6 next-20230614]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/JuenKit-Yip/hwmon-sht3x-add-medium-repeatability-support/20230614-143100
base:   https://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git hwmon-next
patch link:    https://lore.kernel.org/r/DB4PR10MB62615481D91BA8A598234A18925AA%40DB4PR10MB6261.EURPRD10.PROD.OUTLOOK.COM
patch subject: [PATCH 2/3] hwmon: (sht3x) add medium repeatability support
config: i386-allyesconfig (https://download.01.org/0day-ci/archive/20230615/202306150333.vy0slw1N-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build):
        git remote add groeck-staging https://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git
        git fetch groeck-staging hwmon-next
        git checkout groeck-staging/hwmon-next
        b4 shazam https://lore.kernel.org/r/DB4PR10MB62615481D91BA8A598234A18925AA@DB4PR10MB6261.EURPRD10.PROD.OUTLOOK.COM
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=i386 olddefconfig
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash drivers/hwmon/

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202306150333.vy0slw1N-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/hwmon/sht3x.c:33:28: warning: 'sht3x_cmd_measure_blocking_lpm' defined but not used [-Wunused-const-variable=]
      33 | static const unsigned char sht3x_cmd_measure_blocking_lpm[]    = { 0x2c, 0x10 };
         |                            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/hwmon/sht3x.c:29:28: warning: 'sht3x_cmd_measure_blocking_mpm' defined but not used [-Wunused-const-variable=]
      29 | static const unsigned char sht3x_cmd_measure_blocking_mpm[]    = { 0x2c, 0x0d };
         |                            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/hwmon/sht3x.c:25:28: warning: 'sht3x_cmd_measure_blocking_hpm' defined but not used [-Wunused-const-variable=]
      25 | static const unsigned char sht3x_cmd_measure_blocking_hpm[]    = { 0x2c, 0x06 };
         |                            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


vim +/sht3x_cmd_measure_blocking_mpm +29 drivers/hwmon/sht3x.c

    27	
    28	/* commands (medium repeatability mode) */
  > 29	static const unsigned char sht3x_cmd_measure_blocking_mpm[]    = { 0x2c, 0x0d };
    30	static const unsigned char sht3x_cmd_measure_nonblocking_mpm[] = { 0x24, 0x0b };
    31	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
