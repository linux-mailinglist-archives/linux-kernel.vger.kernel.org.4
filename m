Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F7855BC29A
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 07:49:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229690AbiISFtW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 01:49:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbiISFtU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 01:49:20 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B25213F19;
        Sun, 18 Sep 2022 22:49:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663566560; x=1695102560;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=herPt7lk9DdYodBrqmCQsFedxWRK6VJIeEv7qQ3JqNY=;
  b=PpTJUjr1S+wUYk5SMKwfz2KjNclHWutsucMkAIj1DbsUE0Y0DjJ6u7Ok
   qRq4VGTU1RMVjtoNzS7Y7w1SQXYTPzMWSEx0WiHooXAMffMl3MEvl+IUT
   CWcX+RfXpihO2/Qd3TxkkaKUPo9YUsTuxRoUouXfkCw6x67Sxlh/c/9KF
   suXfE/LqFZsDH+07kd7BFxipuNuLQ59I+2AJ6/lpdMH5mF1eSc085tuXc
   pn61VtgittObAu8FnUT/OpCVCTb/6vtunKH7CVYU8Wgqib3bLAZXUvniV
   zQVET/Yk0c9FeIDvSRiHlB1lXPIqHPDklsIduMxmo+h3nWG280hm8xmV9
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10474"; a="363268278"
X-IronPort-AV: E=Sophos;i="5.93,325,1654585200"; 
   d="scan'208";a="363268278"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2022 22:49:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,325,1654585200"; 
   d="scan'208";a="595944988"
Received: from lkp-server01.sh.intel.com (HELO c0a60f19fe7e) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 18 Sep 2022 22:49:16 -0700
Received: from kbuild by c0a60f19fe7e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oa9ee-0001mX-0w;
        Mon, 19 Sep 2022 05:49:16 +0000
Date:   Mon, 19 Sep 2022 13:49:06 +0800
From:   kernel test robot <lkp@intel.com>
To:     Yu Kuai <yukuai1@huaweicloud.com>, axboe@kernel.dk
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        yukuai3@huawei.com, yukuai1@huaweicloud.com, yi.zhang@huawei.com
Subject: Re: [PATCH -next 1/3] wbt: don't show valid wbt_lat_usec in sysfs
 while wbt is disabled
Message-ID: <202209191345.OaqfJF8y-lkp@intel.com>
References: <20220919014939.175497-2-yukuai1@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220919014939.175497-2-yukuai1@huaweicloud.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
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
config: x86_64-randconfig-a001-20220919 (https://download.01.org/0day-ci/archive/20220919/202209191345.OaqfJF8y-lkp@intel.com/config)
compiler: clang version 14.0.6 (https://github.com/llvm/llvm-project f28c006a5895fc0e329fe15fead81e37457cb1d1)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/dd5a7be692b8fc9794f29648d0805a2d65b9c4de
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Yu-Kuai/blk-wbt-simple-improvment-to-enable-wbt-correctly/20220919-094019
        git checkout dd5a7be692b8fc9794f29648d0805a2d65b9c4de
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> block/blk-sysfs.c:475:8: error: implicit declaration of function 'wbt_disabled' is invalid in C99 [-Werror,-Wimplicit-function-declaration]
           lat = wbt_disabled(q) ? 0 : div_u64(wbt_get_min_lat(q), 1000);
                 ^
   block/blk-sysfs.c:500:6: error: implicit declaration of function 'wbt_disabled' is invalid in C99 [-Werror,-Wimplicit-function-declaration]
           if (wbt_disabled(q))
               ^
   2 errors generated.


vim +/wbt_disabled +475 block/blk-sysfs.c

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
