Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B22676DF1E1
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 12:23:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230294AbjDLKXj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 06:23:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230345AbjDLKXN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 06:23:13 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 929127DA4;
        Wed, 12 Apr 2023 03:23:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681294990; x=1712830990;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=NYVZJBLrI4AK1v6HThNOAVJ+dk8TflhyXolcYHdUZuo=;
  b=DpqbQSlc8g8kGne14Ejn1Jy6VAuziBgghOGJ7Ap8yitOK1Yt3Y6L1GcM
   V3ugUP600SKlEItBalUGtQMsPVuPcs+7ILl2vZiE8+uS9hKLzPzkOyDkG
   vbTvjWJ2ZB67U5lyZlGmYeBEykapkujRc/ZkREY8jyc+f/TqMfwWyPz5N
   coO/c6mATpC+lZ8VmNNmWVhjLsik5Fom7ZRfj4Iwwzob64FUxEB37QhHS
   oCN2esMmPUZckl+hoRgnwzhJtus9m9GvfrmeCAqZfY4xjyOQRkEB2IvX4
   4lZppX0QjPRPrDNOz9t00MwiwBHF50MEhobphZVsffKHQAyKRsDpBC1Yg
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10677"; a="406685892"
X-IronPort-AV: E=Sophos;i="5.98,339,1673942400"; 
   d="scan'208";a="406685892"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2023 03:23:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10677"; a="1018691016"
X-IronPort-AV: E=Sophos;i="5.98,339,1673942400"; 
   d="scan'208";a="1018691016"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 12 Apr 2023 03:23:06 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pmXd3-000Xct-2F;
        Wed, 12 Apr 2023 10:23:05 +0000
Date:   Wed, 12 Apr 2023 18:22:56 +0800
From:   kernel test robot <lkp@intel.com>
To:     Junxiao Bi <junxiao.bi@oracle.com>, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org
Cc:     oe-kbuild-all@lists.linux.dev, paul@paul-moore.com,
        jmorris@namei.org, serge@hallyn.com, nathanl@linux.ibm.com,
        axboe@kernel.dk, konrad.wilk@oracle.com, joe.jin@oracle.com
Subject: Re: [PATCH] debugfs: allow access relay files in lockdown mode
Message-ID: <202304121808.IDucPQw7-lkp@intel.com>
References: <20230412001030.88441-1-junxiao.bi@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230412001030.88441-1-junxiao.bi@oracle.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Junxiao,

kernel test robot noticed the following build errors:

[auto build test ERROR on driver-core/driver-core-testing]
[also build test ERROR on driver-core/driver-core-next driver-core/driver-core-linus linus/master v6.3-rc6 next-20230412]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Junxiao-Bi/debugfs-allow-access-relay-files-in-lockdown-mode/20230412-081241
patch link:    https://lore.kernel.org/r/20230412001030.88441-1-junxiao.bi%40oracle.com
patch subject: [PATCH] debugfs: allow access relay files in lockdown mode
config: powerpc-buildonly-randconfig-r003-20230410 (https://download.01.org/0day-ci/archive/20230412/202304121808.IDucPQw7-lkp@intel.com/config)
compiler: powerpc-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/7891278613631bb6076e7b4603c1e907d1304cfa
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Junxiao-Bi/debugfs-allow-access-relay-files-in-lockdown-mode/20230412-081241
        git checkout 7891278613631bb6076e7b4603c1e907d1304cfa
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=powerpc olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=powerpc SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202304121808.IDucPQw7-lkp@intel.com/

All errors (new ones prefixed by >>):

   powerpc-linux-ld: fs/debugfs/file.o: in function `debugfs_locked_down':
   fs/debugfs/file.c:163: undefined reference to `relay_file_operations'
>> powerpc-linux-ld: fs/debugfs/file.c:163: undefined reference to `relay_file_operations'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
