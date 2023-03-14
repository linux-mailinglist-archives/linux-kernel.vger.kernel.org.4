Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88C006B96B2
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 14:46:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231524AbjCNNqa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 09:46:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231342AbjCNNqF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 09:46:05 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33A82A56B7;
        Tue, 14 Mar 2023 06:42:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678801371; x=1710337371;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=UButox8DsgHsAktpejVz/McnXXMI5zf9XAuDW8i/fMU=;
  b=cydUFsKzt1q7bPqrOskNnxHwr1/rFWzLh2ilK8Zsjmfc+X0y5VbTQoKt
   MYD5AFIOIN6IH6huAPP2TuCFK9wgOlho8CcSwug2NaWf+9++6dqILFH8W
   OLWAUaL5ehpOnzoKswIeJ6CgMQRJZdnjG+78HKwKF22ly0DyK8+zNKDfj
   p6ww3DSNzWHEoI6kWJre/Gk/4/4wQ1QM3yy6SFCvddBTX4J//ImuBTCV/
   cR4xyHWy3AlwEumcr2Hw0Na5cb5PmPQ5yeEylhDscVjo2rrYHI9AlJUl7
   sOYdwQXcm5ZXGhDag6u2pLH5X8uMrqKzvPeE+1dq1K+MipFpg9ZNdgcW7
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10648"; a="317815139"
X-IronPort-AV: E=Sophos;i="5.98,260,1673942400"; 
   d="scan'208";a="317815139"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2023 06:42:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10648"; a="672341803"
X-IronPort-AV: E=Sophos;i="5.98,260,1673942400"; 
   d="scan'208";a="672341803"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 14 Mar 2023 06:42:43 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pc4vG-0006wz-0R;
        Tue, 14 Mar 2023 13:42:38 +0000
Date:   Tue, 14 Mar 2023 21:41:42 +0800
From:   kernel test robot <lkp@intel.com>
To:     Paul Cercueil <paul@crapouillou.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
Cc:     oe-kbuild-all@lists.linux.dev,
        Paul Cercueil <paul@crapouillou.net>,
        michael.hennerich@analog.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        nuno.sa@analog.com, linaro-mm-sig@lists.linaro.org,
        linux-media@vger.kernel.org
Subject: Re: [PATCH 2/2] usb: gadget: functionfs: Add DMABUF import interface
Message-ID: <202303142140.ZQsw4C4V-lkp@intel.com>
References: <20230314105257.17345-3-paul@crapouillou.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230314105257.17345-3-paul@crapouillou.net>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paul,

I love your patch! Perhaps something to improve:

[auto build test WARNING on usb/usb-testing]
[also build test WARNING on usb/usb-next usb/usb-linus linus/master v6.3-rc2 next-20230314]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Paul-Cercueil/usb-gadget-Support-already-mapped-DMA-SGs/20230314-185522
base:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git usb-testing
patch link:    https://lore.kernel.org/r/20230314105257.17345-3-paul%40crapouillou.net
patch subject: [PATCH 2/2] usb: gadget: functionfs: Add DMABUF import interface
config: m68k-allyesconfig (https://download.01.org/0day-ci/archive/20230314/202303142140.ZQsw4C4V-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/4ee364ed5d112c4550344fd037f4e1ef7cc41878
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Paul-Cercueil/usb-gadget-Support-already-mapped-DMA-SGs/20230314-185522
        git checkout 4ee364ed5d112c4550344fd037f4e1ef7cc41878
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=m68k olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=m68k SHELL=/bin/bash drivers/usb/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202303142140.ZQsw4C4V-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/usb/gadget/function/f_fs.c:1401:5: warning: no previous prototype for 'ffs_dma_resv_lock' [-Wmissing-prototypes]
    1401 | int ffs_dma_resv_lock(struct dma_buf *dmabuf, bool nonblock)
         |     ^~~~~~~~~~~~~~~~~


vim +/ffs_dma_resv_lock +1401 drivers/usb/gadget/function/f_fs.c

  1400	
> 1401	int ffs_dma_resv_lock(struct dma_buf *dmabuf, bool nonblock)
  1402	{
  1403		int ret;
  1404	
  1405		ret = dma_resv_lock_interruptible(dmabuf->resv, NULL);
  1406		if (ret) {
  1407			if (ret != -EDEADLK)
  1408				goto out;
  1409			if (nonblock) {
  1410				ret = -EBUSY;
  1411				goto out;
  1412			}
  1413	
  1414			ret = dma_resv_lock_slow_interruptible(dmabuf->resv, NULL);
  1415		}
  1416	
  1417	out:
  1418		return ret;
  1419	}
  1420	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
