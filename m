Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6733971376B
	for <lists+linux-kernel@lfdr.de>; Sun, 28 May 2023 03:46:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229481AbjE1BpA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 May 2023 21:45:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjE1Bo7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 May 2023 21:44:59 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D493DDE
        for <linux-kernel@vger.kernel.org>; Sat, 27 May 2023 18:44:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685238295; x=1716774295;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Gll6v8zxfLENN56Xlc2FVXBXa2vDekhM1BJGuQkgYbQ=;
  b=PvQ4C9p4jSa1+kClw9pXDRZ2OCL47BgUdCXTEo4x3Y+ny4yQMzxMGbdT
   3QMPs3izgEYx6S4x0EkhQTs9uh0b1zZBRqrSQGtW8Pf7MXgP2ZUjEeLpe
   tSIqAVGq38PwfpX7XjE5YZW0pSIoTfE1sC9TE0xfUy2p3n0VXB+5WrSXH
   LTckMK6c1uoEjPbEFrB770VtY5U9/q0/EnQYDHNeRn0H0WX4PJiu8CSf7
   TGY17iEQR25IDIBOxH+E8s9P3sdXq7qn8Yr4SbG6Uc1xTKAxqowdZoLx0
   Ii0cY5xHoJ9BC5tvpJQhSdpS9LHhOx85D1KVR5pWjKBfhXW4jhBL9X2Z4
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10723"; a="343968771"
X-IronPort-AV: E=Sophos;i="6.00,198,1681196400"; 
   d="scan'208";a="343968771"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2023 18:44:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10723"; a="736420199"
X-IronPort-AV: E=Sophos;i="6.00,198,1681196400"; 
   d="scan'208";a="736420199"
Received: from lkp-server01.sh.intel.com (HELO dea6d5a4f140) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 27 May 2023 18:44:52 -0700
Received: from kbuild by dea6d5a4f140 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1q35Sl-000KMu-0y;
        Sun, 28 May 2023 01:44:51 +0000
Date:   Sun, 28 May 2023 09:44:10 +0800
From:   kernel test robot <lkp@intel.com>
To:     Zhen Lei <thunder.leizhen@huawei.com>,
        Eric Biederman <ebiederm@xmission.com>,
        Baoquan He <bhe@redhat.com>, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     oe-kbuild-all@lists.linux.dev,
        Zhen Lei <thunder.leizhen@huawei.com>,
        Michael Holzheu <holzheu@linux.vnet.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Amerigo Wang <amwang@redhat.com>
Subject: Re: [PATCH 5/6] kexec: add helper __crash_shrink_memory()
Message-ID: <202305280949.yYtbjy5B-lkp@intel.com>
References: <20230527123439.772-6-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230527123439.772-6-thunder.leizhen@huawei.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Zhen,

kernel test robot noticed the following build warnings:

[auto build test WARNING on akpm-mm/mm-everything]
[also build test WARNING on linus/master v6.4-rc3 next-20230525]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Zhen-Lei/kexec-fix-a-memory-leak-in-crash_shrink_memory/20230527-203821
base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
patch link:    https://lore.kernel.org/r/20230527123439.772-6-thunder.leizhen%40huawei.com
patch subject: [PATCH 5/6] kexec: add helper __crash_shrink_memory()
config: mips-randconfig-r012-20230528 (https://download.01.org/0day-ci/archive/20230528/202305280949.yYtbjy5B-lkp@intel.com/config)
compiler: mipsel-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        mkdir -p ~/bin
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/dea97cef503d26e05d0e11818ae44176056ddf64
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Zhen-Lei/kexec-fix-a-memory-leak-in-crash_shrink_memory/20230527-203821
        git checkout dea97cef503d26e05d0e11818ae44176056ddf64
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 ~/bin/make.cross W=1 O=build_dir ARCH=mips olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 ~/bin/make.cross W=1 O=build_dir ARCH=mips SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202305280949.yYtbjy5B-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> kernel/kexec_core.c:1108:5: warning: no previous prototype for '__crash_shrink_memory' [-Wmissing-prototypes]
    1108 | int __crash_shrink_memory(struct resource *old_res, unsigned long new_size)
         |     ^~~~~~~~~~~~~~~~~~~~~


vim +/__crash_shrink_memory +1108 kernel/kexec_core.c

  1107	
> 1108	int __crash_shrink_memory(struct resource *old_res, unsigned long new_size)
  1109	{
  1110		struct resource *ram_res;
  1111	
  1112		ram_res = kzalloc(sizeof(*ram_res), GFP_KERNEL);
  1113		if (!ram_res)
  1114			return -ENOMEM;
  1115	
  1116		ram_res->start = old_res->start + new_size;
  1117		ram_res->end   = old_res->end;
  1118		ram_res->flags = IORESOURCE_BUSY | IORESOURCE_SYSTEM_RAM;
  1119		ram_res->name  = "System RAM";
  1120	
  1121		if (!new_size) {
  1122			release_resource(old_res);
  1123			old_res->start = 0;
  1124			old_res->end   = 0;
  1125		} else {
  1126			crashk_res.end = ram_res->start - 1;
  1127		}
  1128	
  1129		crash_free_reserved_phys_range(ram_res->start, ram_res->end);
  1130		insert_resource(&iomem_resource, ram_res);
  1131	
  1132		return 0;
  1133	}
  1134	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
