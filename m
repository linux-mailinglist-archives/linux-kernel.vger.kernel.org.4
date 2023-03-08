Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED8856AFBD8
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 02:12:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229963AbjCHBMh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 20:12:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229548AbjCHBMe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 20:12:34 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF4A5A92D0
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 17:12:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678237952; x=1709773952;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=8/TaqzSsdqIyxZv8QQbHxcmlmEyYok4R2JIi/rwnyDY=;
  b=EaXYlfmSO788tx2srRBit39iUXcu+BtoBiCt2+pb6OlhEQ6tIAji6tCs
   wUC75fzxpofMlFnLajUu9h7rxUAOVZBFnuNsPiTnONOYi4ogH8kma78um
   sf8EjhuTi93DqwyMVKcVTtWO10T5WK8mopGr5j1+I9bqTnbg612g896ac
   Fz2qRAWCuoxj66FWSUPX/f1T6RKKghrE/BGiZ2KGCNBk3O1WkhjIQFG0m
   2FGBRfKV4d3mOuJyf5spyUWalJ4sks56IMc/7z9At1HA7V1HT91Rrnild
   pGvDhmbYb0Vj9fdVnyb4CZMScwUv156g3/4OT6wWnXjXiPk6vHnOt3S9G
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10642"; a="338345250"
X-IronPort-AV: E=Sophos;i="5.98,242,1673942400"; 
   d="scan'208";a="338345250"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2023 17:12:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10642"; a="626742306"
X-IronPort-AV: E=Sophos;i="5.98,242,1673942400"; 
   d="scan'208";a="626742306"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 07 Mar 2023 17:12:29 -0800
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pZiM1-0001kh-0m;
        Wed, 08 Mar 2023 01:12:29 +0000
Date:   Wed, 8 Mar 2023 09:12:00 +0800
From:   kernel test robot <lkp@intel.com>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: ERROR: modpost: "__st_r13_to_r22" [lib/zstd/zstd_decompress.ko]
 undefined!
Message-ID: <202303080904.9LRtrAgX-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Masahiro,

First bad commit (maybe != root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   63355b9884b3d1677de6bd1517cd2b8a9bf53978
commit: 0aa24a79ee3b603f6e6cd470c364edc2d746f613 kbuild: do not try to parse *.cmd files for objects provided by compiler
date:   9 months ago
config: arc-randconfig-r031-20230306 (https://download.01.org/0day-ci/archive/20230308/202303080904.9LRtrAgX-lkp@intel.com/config)
compiler: arceb-elf-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=0aa24a79ee3b603f6e6cd470c364edc2d746f613
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 0aa24a79ee3b603f6e6cd470c364edc2d746f613
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=arc olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=arc SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202303080904.9LRtrAgX-lkp@intel.com/

All errors (new ones prefixed by >>, old ones prefixed by <<):

ERROR: modpost: "__ld_r13_to_r23_ret" [lib/zstd/zstd_decompress.ko] undefined!
>> ERROR: modpost: "__st_r13_to_r22" [lib/zstd/zstd_decompress.ko] undefined!
>> ERROR: modpost: "__st_r13_to_r17" [lib/zstd/zstd_decompress.ko] undefined!
ERROR: modpost: "__ld_r13_to_r21_ret" [lib/zstd/zstd_decompress.ko] undefined!
>> ERROR: modpost: "__ld_r13_to_r19_ret" [lib/zstd/zstd_decompress.ko] undefined!
ERROR: modpost: "__ld_r13_to_r22_ret" [lib/zstd/zstd_decompress.ko] undefined!
ERROR: modpost: "__st_r13_to_r24" [lib/zstd/zstd_decompress.ko] undefined!
ERROR: modpost: "__ld_r13_to_r17_ret" [lib/zstd/zstd_decompress.ko] undefined!
ERROR: modpost: "__st_r13_to_r21" [lib/zstd/zstd_decompress.ko] undefined!
ERROR: modpost: "__st_r13_to_r19" [lib/zstd/zstd_decompress.ko] undefined!
WARNING: modpost: suppressed 5 unresolved symbol warnings because there were too many)

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
