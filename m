Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 836037019AE
	for <lists+linux-kernel@lfdr.de>; Sat, 13 May 2023 22:36:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230085AbjEMUgX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 May 2023 16:36:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbjEMUgV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 May 2023 16:36:21 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E70A52D40;
        Sat, 13 May 2023 13:36:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684010178; x=1715546178;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=onYFYVldXP9dx3srsdPLwnPSsSURVschs6xcAcd8kOI=;
  b=dqgoAdcFBsE57M6yFgLQCN/dBTgay6qW5QHwe+Mj3ZoI9NK4Ievdlbxg
   vNxkoFwqIkSsC1bVtIgs07m9TWmfbZ0iInWEdwfSw1Ijy/3/GNZ7CTLES
   muH9wOfDmsArPjHHXAmVvA6+bv0K2JNg0yty6FGwOifvck22zbrh7A6eT
   V6Kb5BSfxay++1qxP/MdRoqAAe/flVEd4vkUn7/HLnPDTAVWSIJLLl8Wb
   j1ezRPBSqmhFpuqzo4Sc16J1WqbS/nOlkTlBxVz3t7sCbpiFm16Ti6i9B
   T5sVD9zWT/MITRPp/6HSdL+qyCJ73Q8LybeM7kPT/s+IzQjGjHV0/e2cq
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10709"; a="348480329"
X-IronPort-AV: E=Sophos;i="5.99,273,1677571200"; 
   d="scan'208";a="348480329"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2023 13:36:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10709"; a="844772599"
X-IronPort-AV: E=Sophos;i="5.99,273,1677571200"; 
   d="scan'208";a="844772599"
Received: from lkp-server01.sh.intel.com (HELO dea6d5a4f140) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 13 May 2023 13:36:16 -0700
Received: from kbuild by dea6d5a4f140 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pxvyR-0005fe-35;
        Sat, 13 May 2023 20:36:15 +0000
Date:   Sun, 14 May 2023 04:35:55 +0800
From:   kernel test robot <lkp@intel.com>
To:     Genjian <zhanggenjian123@gmail.com>, tsbogend@alpha.franken.de,
        rdunlap@infradead.org
Cc:     oe-kbuild-all@lists.linux.dev, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org, zhanggenjian123@gmail.com,
        Genjian Zhang <zhanggenjian@kylinos.cn>,
        k2ci <kernel-bot@kylinos.cn>
Subject: Re: [PATCH v2] fix ___SYNC () build error when PROFILE_ALL_BRANCHES
 is enabled
Message-ID: <202305140443.2830m30j-lkp@intel.com>
References: <20230427150332.2978867-1-zhanggenjian@kylinos.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230427150332.2978867-1-zhanggenjian@kylinos.cn>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Genjian,

kernel test robot noticed the following build warnings:

[auto build test WARNING on linus/master]
[also build test WARNING on v6.4-rc1 next-20230512]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Genjian/fix-___SYNC-build-error-when-PROFILE_ALL_BRANCHES-is-enabled/20230427-230626
base:   linus/master
patch link:    https://lore.kernel.org/r/20230427150332.2978867-1-zhanggenjian%40kylinos.cn
patch subject: [PATCH v2] fix ___SYNC () build error when PROFILE_ALL_BRANCHES is enabled
config: mips-decstation_defconfig (https://download.01.org/0day-ci/archive/20230514/202305140443.2830m30j-lkp@intel.com/config)
compiler: mipsel-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/6eb50851d61ca808629a062e0545704eba5be950
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Genjian/fix-___SYNC-build-error-when-PROFILE_ALL_BRANCHES-is-enabled/20230427-230626
        git checkout 6eb50851d61ca808629a062e0545704eba5be950
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=mips olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=mips SHELL=/bin/bash arch/mips/mm/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202305140443.2830m30j-lkp@intel.com/

All warnings (new ones prefixed by >>):

   arch/mips/mm/c-r3k.c:28:15: warning: no previous prototype for 'r3k_cache_size' [-Wmissing-prototypes]
      28 | unsigned long r3k_cache_size(unsigned long ca_flags)
         |               ^~~~~~~~~~~~~~
   arch/mips/mm/c-r3k.c:63:15: warning: no previous prototype for 'r3k_cache_lsize' [-Wmissing-prototypes]
      63 | unsigned long r3k_cache_lsize(unsigned long ca_flags)
         |               ^~~~~~~~~~~~~~~
   arch/mips/mm/c-r3k.c:286:6: warning: no previous prototype for 'r3k_cache_init' [-Wmissing-prototypes]
     286 | void r3k_cache_init(void)
         |      ^~~~~~~~~~~~~~
   {standard input}: Assembler messages:
   {standard input}:422: Error: non-constant expression in ".if" statement
   {standard input}: Error: end of file inside conditional
   {standard input}:422: Error: here is the start of the unterminated conditional
>> {standard input}: Warning: missing .end at end of assembly

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
