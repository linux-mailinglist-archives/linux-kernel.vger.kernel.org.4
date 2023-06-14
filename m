Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A13572FE62
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 14:22:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244514AbjFNMWV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 08:22:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244510AbjFNMWR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 08:22:17 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D24F71FDC
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 05:22:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686745336; x=1718281336;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=JZVfxrwUIK3Wdo4307QCQsPD4ASj/0JzwbGG4o3QQcM=;
  b=OoNSGocfe/zEveglHvuAOdnXEqkBkogAxvZGI+tmF0v3G9arW+TRR8R2
   i8JC8tSP5Skjz2sGnrB2QkZE9ayGf1l35Fukp3+4qVmpCBbxPK66UQUO9
   XL17Jst4+WCJ/loqx7r2iQY+VcmGEjW3ZLIj1wMvF2U1lKjlevEQ+uLw7
   V+fioQNSQsEYIG48Dhg1WFEuSmId064a7+JoQpxlPeya+l19SCXqytR7U
   LeU8ivvNYCVvqYcuJ27zVidYtjaZQgdfqFj2YxMgHmEujwOCltC8iALLE
   c8zoTeF3eL4GVUfQ2RGjI3bSolCode3wDZnjbI2qL9X0TVcSUAWeLHaHy
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10741"; a="356089046"
X-IronPort-AV: E=Sophos;i="6.00,242,1681196400"; 
   d="scan'208";a="356089046"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2023 05:22:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10741"; a="741821027"
X-IronPort-AV: E=Sophos;i="6.00,242,1681196400"; 
   d="scan'208";a="741821027"
Received: from lkp-server02.sh.intel.com (HELO d59cacf64e9e) ([10.239.97.151])
  by orsmga008.jf.intel.com with ESMTP; 14 Jun 2023 05:22:13 -0700
Received: from kbuild by d59cacf64e9e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1q9PVn-0000ck-0W;
        Wed, 14 Jun 2023 12:22:08 +0000
Date:   Wed, 14 Jun 2023 20:21:33 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        Felix.Kuehling@amd.com
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        Xinhui.Pan@amd.com, Abaci Robot <abaci@linux.alibaba.com>,
        linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, alexander.deucher@amd.com,
        christian.koenig@amd.com
Subject: Re: [PATCH] drm/amdkfd: Switch over to memdup_user()
Message-ID: <202306142005.G5XIz3fm-lkp@intel.com>
References: <20230614020432.44044-1-jiapeng.chong@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230614020432.44044-1-jiapeng.chong@linux.alibaba.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jiapeng,

kernel test robot noticed the following build errors:

[auto build test ERROR on next-20230613]
[cannot apply to drm-misc/drm-misc-next v6.4-rc6 v6.4-rc5 v6.4-rc4 linus/master v6.4-rc6]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Jiapeng-Chong/drm-amdkfd-Switch-over-to-memdup_user/20230614-100553
base:   next-20230613
patch link:    https://lore.kernel.org/r/20230614020432.44044-1-jiapeng.chong%40linux.alibaba.com
patch subject: [PATCH] drm/amdkfd: Switch over to memdup_user()
config: x86_64-buildonly-randconfig-r006-20230614 (https://download.01.org/0day-ci/archive/20230614/202306142005.G5XIz3fm-lkp@intel.com/config)
compiler: clang version 15.0.7 (https://github.com/llvm/llvm-project.git 8dfdcc7b7bf66834a761bd8de445840ef68e4d1a)
reproduce (this is a W=1 build):
        mkdir -p ~/bin
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git checkout next-20230613
        b4 shazam https://lore.kernel.org/r/20230614020432.44044-1-jiapeng.chong@linux.alibaba.com
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang ~/bin/make.cross W=1 O=build_dir ARCH=x86_64 olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang ~/bin/make.cross W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash drivers/gpu/

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202306142005.G5XIz3fm-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/gpu/drm/amd/amdgpu/../amdkfd/kfd_device_queue_manager.c:2815:10: error: incompatible integer to pointer conversion returning 'long' from a function with result type 'uint32_t *' (aka 'unsigned int *') [-Wint-conversion]
                   return PTR_ERR(queue_ids);
                          ^~~~~~~~~~~~~~~~~~
   1 error generated.


vim +2815 drivers/gpu/drm/amd/amdgpu/../amdkfd/kfd_device_queue_manager.c

  2804	
  2805	static uint32_t *get_queue_ids(uint32_t num_queues, uint32_t *usr_queue_id_array)
  2806	{
  2807		size_t array_size = num_queues * sizeof(uint32_t);
  2808		uint32_t *queue_ids = NULL;
  2809	
  2810		if (!usr_queue_id_array)
  2811			return NULL;
  2812	
  2813		queue_ids = memdup_user(usr_queue_id_array, array_size);
  2814		if (IS_ERR(queue_ids))
> 2815			return PTR_ERR(queue_ids);
  2816	
  2817		return queue_ids;
  2818	}
  2819	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
