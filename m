Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4885D69A491
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 04:50:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230349AbjBQDuH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 22:50:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjBQDuD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 22:50:03 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B048A5A3AD
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 19:50:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676605802; x=1708141802;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=O+c6MjNUQXeadDzpM+t8VgVjrw7GBTRFLweCYRCA8HY=;
  b=h5qjlYo/iEqYxVqQWZORRbvtg+d4jRkZSQc1nw86U+9iQB0O/lMZB/Zv
   Ll74fEl4dTKiGdVnEOcPl6YuuxLZO0di/zlqRL1xartDwYYfnrvzIkocA
   QxYhxfCQIaErX0STS8F4I4jD5yACMkfhrYJrxoRoiwCe4OVP2aLoEOe3s
   oVv83mNYasZGmKHmR+vGhmXsbHMJfKURtZHrUQbl7xlAoE43YCjy8RM5C
   j4SAPZbRumMNrP6+DNA+iss0RtioFRChkOoTgkUbyRoqQpm7Np8PUFCYr
   ogyNqgeARQzBQ9Nt8dZEXkr/iCLWDdYgf2ibccJY8kxwsVrV1ANqYcUDi
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10623"; a="331903909"
X-IronPort-AV: E=Sophos;i="5.97,304,1669104000"; 
   d="scan'208";a="331903909"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2023 19:50:00 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10623"; a="915946649"
X-IronPort-AV: E=Sophos;i="5.97,304,1669104000"; 
   d="scan'208";a="915946649"
Received: from lkp-server01.sh.intel.com (HELO 4455601a8d94) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 16 Feb 2023 19:49:59 -0800
Received: from kbuild by 4455601a8d94 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pSrl0-000B5h-01;
        Fri, 17 Feb 2023 03:49:58 +0000
Date:   Fri, 17 Feb 2023 11:49:51 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jingbo Xu <jefflexu@linux.alibaba.com>, xiang@kernel.or,
        chao@kernel.org, huyue2@coolpad.com, linux-erofs@lists.ozlabs.org
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] erofs: convert hardcoded blocksize to sb->s_blocksize
Message-ID: <202302171143.RmhVCgqe-lkp@intel.com>
References: <20230216094745.47868-1-jefflexu@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230216094745.47868-1-jefflexu@linux.alibaba.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jingbo,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on xiang-erofs/dev-test]
[also build test ERROR on xiang-erofs/dev next-20230216]
[cannot apply to xiang-erofs/fixes linus/master v6.2-rc8]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Jingbo-Xu/erofs-set-block-size-to-the-on-disk-block-size/20230216-175045
base:   https://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git dev-test
patch link:    https://lore.kernel.org/r/20230216094745.47868-1-jefflexu%40linux.alibaba.com
patch subject: [PATCH 1/2] erofs: convert hardcoded blocksize to sb->s_blocksize
config: mips-allyesconfig (https://download.01.org/0day-ci/archive/20230217/202302171143.RmhVCgqe-lkp@intel.com/config)
compiler: mips-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/30b09ec3be57f3777d22e71d2d4e5ec70d9227f8
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Jingbo-Xu/erofs-set-block-size-to-the-on-disk-block-size/20230216-175045
        git checkout 30b09ec3be57f3777d22e71d2d4e5ec70d9227f8
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=mips olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=mips SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202302171143.RmhVCgqe-lkp@intel.com/

All errors (new ones prefixed by >>):

   arch/mips/kernel/head.o: in function `kernel_entry':
   (.ref.text+0xac): relocation truncated to fit: R_MIPS_26 against `start_kernel'
   init/main.o: in function `set_reset_devices':
   main.c:(.init.text+0x20): relocation truncated to fit: R_MIPS_26 against `_mcount'
   main.c:(.init.text+0x30): relocation truncated to fit: R_MIPS_26 against `__sanitizer_cov_trace_pc'
   init/main.o: in function `debug_kernel':
   main.c:(.init.text+0xa4): relocation truncated to fit: R_MIPS_26 against `_mcount'
   main.c:(.init.text+0xb4): relocation truncated to fit: R_MIPS_26 against `__sanitizer_cov_trace_pc'
   init/main.o: in function `quiet_kernel':
   main.c:(.init.text+0x128): relocation truncated to fit: R_MIPS_26 against `_mcount'
   main.c:(.init.text+0x138): relocation truncated to fit: R_MIPS_26 against `__sanitizer_cov_trace_pc'
   init/main.o: in function `warn_bootconfig':
   main.c:(.init.text+0x1ac): relocation truncated to fit: R_MIPS_26 against `_mcount'
   main.c:(.init.text+0x1bc): relocation truncated to fit: R_MIPS_26 against `__sanitizer_cov_trace_pc'
   init/main.o: in function `init_setup':
   main.c:(.init.text+0x234): relocation truncated to fit: R_MIPS_26 against `_mcount'
   main.c:(.init.text+0x254): additional relocation overflows omitted from the output
   mips-linux-ld: fs/erofs/data.o: in function `erofs_map_blocks_flatmode.constprop.0':
>> data.c:(.text.erofs_map_blocks_flatmode.constprop.0+0x118): undefined reference to `__divdi3'
   mips-linux-ld: fs/erofs/namei.o: in function `erofs_find_target_block.constprop.0':
>> namei.c:(.text.erofs_find_target_block.constprop.0+0xf8): undefined reference to `__divdi3'
   mips-linux-ld: fs/erofs/zmap.o: in function `compacted_load_cluster_from_disk':
>> zmap.c:(.text.compacted_load_cluster_from_disk+0x224): undefined reference to `__divdi3'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
