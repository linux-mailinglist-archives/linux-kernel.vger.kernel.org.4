Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E16395BA7D5
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 10:10:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229885AbiIPIKy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 04:10:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229703AbiIPIKv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 04:10:51 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C9D92E6B8
        for <linux-kernel@vger.kernel.org>; Fri, 16 Sep 2022 01:10:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663315851; x=1694851851;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=VF1urHLrZXDb1ERMuLgY6SLME86ioEfo4UKQ1oHzFlE=;
  b=WUPexV9RUAJpvgmzrY2lxXy9s4adm4pBSIHBodGj2Rd8qTFDxs5tBgXN
   s0YdUh6FGCxVap15xgGZwUgAxJctpI+ruXxtbWu1B4xi82AJ69VCuowGV
   QVWSzk/4wahQ692rrTDrQE7EkWLEm61Q2TGyBZL+Zm/PI0+u08mGkWwEy
   TQa8U5eo5nVXbAeSMmIMYnbJvUVtqymLyN8dawtOxN4PrZz9/f7C/kRO+
   IibFqd5Pr1+PF/sbeXBpjhUS1Mg2FQAXOH0ixg73pF0StMuXluQr+y/qs
   N245hz9X6FzGU6dOItqhhM7rKrdmk8B77+0Ezb+4WY3zIvqw9TEQLKxUW
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10471"; a="297665192"
X-IronPort-AV: E=Sophos;i="5.93,320,1654585200"; 
   d="scan'208";a="297665192"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2022 01:10:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,320,1654585200"; 
   d="scan'208";a="613185311"
Received: from lkp-server02.sh.intel.com (HELO 41300c7200ea) ([10.239.97.151])
  by orsmga007.jf.intel.com with ESMTP; 16 Sep 2022 01:10:48 -0700
Received: from kbuild by 41300c7200ea with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oZ6Qs-0001Zz-2q;
        Fri, 16 Sep 2022 08:10:42 +0000
Date:   Fri, 16 Sep 2022 16:10:17 +0800
From:   kernel test robot <lkp@intel.com>
To:     Nadav Amit <nadav.amit@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        VMware PV-Drivers Reviewers <pv-drivers@vmware.com>,
        Arnd Bergmann <arnd@arndb.de>, Nadav Amit <namit@vmware.com>
Subject: Re: [PATCH 3/3] vmw_balloon: open-code vmballoon_compaction_init()
Message-ID: <202209161512.GNTVEnlu-lkp@intel.com>
References: <20220913094306.317734-4-namit@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220913094306.317734-4-namit@vmware.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nadav,

I love your patch! Yet something to improve:

[auto build test ERROR on char-misc/char-misc-testing]
[also build test ERROR on linus/master v6.0-rc5 next-20220915]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Nadav-Amit/vmw_balloon-misc-fixes-and-enhancements/20220914-021333
base:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git ceecbbddbf549fe0b7ffa3804a6e255b3360030f
config: x86_64-randconfig-a014 (https://download.01.org/0day-ci/archive/20220916/202209161512.GNTVEnlu-lkp@intel.com/config)
compiler: clang version 14.0.6 (https://github.com/llvm/llvm-project f28c006a5895fc0e329fe15fead81e37457cb1d1)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/aa1f38765dd703cbeb3450454d0b5b2c7f5a8f8d
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Nadav-Amit/vmw_balloon-misc-fixes-and-enhancements/20220914-021333
        git checkout aa1f38765dd703cbeb3450454d0b5b2c7f5a8f8d
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> drivers/misc/vmw_balloon.c:1892:3: error: use of undeclared identifier 'b'
                   b->b_dev_info.migratepage = vmballoon_migratepage;
                   ^
   drivers/misc/vmw_balloon.c:1732:2: error: unterminated conditional directive
   #ifdef CONFIG_BALLOON_COMPACTION
    ^
   2 errors generated.


vim +/b +1892 drivers/misc/vmw_balloon.c

  1850	
  1851	static int __init vmballoon_init(void)
  1852	{
  1853		int error;
  1854	
  1855		/*
  1856		 * Check if we are running on VMware's hypervisor and bail out
  1857		 * if we are not.
  1858		 */
  1859		if (x86_hyper_type != X86_HYPER_VMWARE)
  1860			return -ENODEV;
  1861	
  1862		INIT_LIST_HEAD(&balloon.huge_pages);
  1863		spin_lock_init(&balloon.comm_lock);
  1864		init_rwsem(&balloon.conf_sem);
  1865		balloon.vmci_doorbell = VMCI_INVALID_HANDLE;
  1866		balloon.batch_page = NULL;
  1867		balloon.page = NULL;
  1868		balloon.reset_required = true;
  1869	
  1870		/*
  1871		 * Reset the balloon to check that it is indeed supported.
  1872		 */
  1873		error = vmballoon_reset(&balloon);
  1874		if (error) {
  1875			pr_err("memory ballooning is disabled");
  1876			goto fail;
  1877		}
  1878	
  1879		INIT_DELAYED_WORK(&balloon.dwork, vmballoon_work);
  1880	
  1881		error = vmballoon_register_shrinker(&balloon);
  1882		if (error)
  1883			goto fail;
  1884	
  1885		/*
  1886		 * Initialization of compaction must be done after the call to
  1887		 * balloon_devinfo_init() .
  1888		 */
  1889		balloon_devinfo_init(&balloon.b_dev_info);
  1890	
  1891		if (IS_ENABLED(CONFIG_BALLOON_COMPACTION))
> 1892			b->b_dev_info.migratepage = vmballoon_migratepage;
  1893	
  1894		queue_delayed_work(system_freezable_wq, &balloon.dwork, 0);
  1895	
  1896		vmballoon_debugfs_init(&balloon);
  1897	
  1898		return 0;
  1899	fail:
  1900		vmballoon_unregister_shrinker(&balloon);
  1901		return error;
  1902	}
  1903	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
