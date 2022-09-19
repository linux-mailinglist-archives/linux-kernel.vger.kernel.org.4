Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A9CE5BC244
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 06:29:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229683AbiISE3P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 00:29:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbiISE3L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 00:29:11 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72E7617E23;
        Sun, 18 Sep 2022 21:29:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663561750; x=1695097750;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=lapmSdR46PI2I1SB/HzKmDP7F9qTl8rSzyuj1hqhyv4=;
  b=ZMa+sZvCypEtW1P1s+Qij53AY6QYTAdMzfc4HnffXUgclX/pmEEU453z
   yXXQ6qciWVS1HSWokR1fJm4Q7K+GKsoLKB3dBRNrzouzSc0r8kteuT7Lo
   GMtJdQ4zio+4/OBulAbj/kblurJVUKywpKjFimw/J7/prJq/Lcm9R6HPW
   8E41PwxYmoprbMgilCOAF0c4UaY0kwANtjioamDzZI7BDQwDn6v2SJk/5
   dDPWX/JYK+vMXrW2slLGq4JwL8BqfVo64oF82NTfMrHgpT0uxtIme++re
   +xH1L6bK4fzn8U4Hq1bBnsQBqDcTddmoYBvXg2q8ZR7odkTYVZCtGhiAy
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10474"; a="300122646"
X-IronPort-AV: E=Sophos;i="5.93,325,1654585200"; 
   d="scan'208";a="300122646"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2022 21:29:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,325,1654585200"; 
   d="scan'208";a="686819313"
Received: from lkp-server01.sh.intel.com (HELO c0a60f19fe7e) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 18 Sep 2022 21:29:08 -0700
Received: from kbuild by c0a60f19fe7e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oa8P5-0001jp-1N;
        Mon, 19 Sep 2022 04:29:07 +0000
Date:   Mon, 19 Sep 2022 12:28:15 +0800
From:   kernel test robot <lkp@intel.com>
To:     Yu Kuai <yukuai1@huaweicloud.com>, axboe@kernel.dk
Cc:     kbuild-all@lists.01.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, yukuai3@huawei.com,
        yukuai1@huaweicloud.com, yi.zhang@huawei.com
Subject: Re: [PATCH -next 1/3] wbt: don't show valid wbt_lat_usec in sysfs
 while wbt is disabled
Message-ID: <202209191232.Nwt56uMD-lkp@intel.com>
References: <20220919014939.175497-2-yukuai1@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220919014939.175497-2-yukuai1@huaweicloud.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yu,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on next-20220916]

url:    https://github.com/intel-lab-lkp/linux/commits/Yu-Kuai/blk-wbt-simple-improvment-to-enable-wbt-correctly/20220919-094019
base:    d5538ab91d3a9a237805be6f8c6c272af2987995
config: parisc-randconfig-r021-20220919 (https://download.01.org/0day-ci/archive/20220919/202209191232.Nwt56uMD-lkp@intel.com/config)
compiler: hppa-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/dd5a7be692b8fc9794f29648d0805a2d65b9c4de
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Yu-Kuai/blk-wbt-simple-improvment-to-enable-wbt-correctly/20220919-094019
        git checkout dd5a7be692b8fc9794f29648d0805a2d65b9c4de
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=parisc SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   block/blk-sysfs.c: In function 'queue_wb_lat_show':
>> block/blk-sysfs.c:475:15: error: implicit declaration of function 'wbt_disabled'; did you mean 'irqs_disabled'? [-Werror=implicit-function-declaration]
     475 |         lat = wbt_disabled(q) ? 0 : div_u64(wbt_get_min_lat(q), 1000);
         |               ^~~~~~~~~~~~
         |               irqs_disabled
   cc1: some warnings being treated as errors


vim +475 block/blk-sysfs.c

   467	
   468	static ssize_t queue_wb_lat_show(struct request_queue *q, char *page)
   469	{
   470		u64 lat;
   471	
   472		if (!wbt_rq_qos(q))
   473			return -EINVAL;
   474	
 > 475		lat = wbt_disabled(q) ? 0 : div_u64(wbt_get_min_lat(q), 1000);
   476	
   477		return sprintf(page, "%llu\n", lat);
   478	}
   479	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
