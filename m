Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6FBD6E0FA6
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 16:07:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231698AbjDMOHT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 10:07:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230305AbjDMOHR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 10:07:17 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29D52E2;
        Thu, 13 Apr 2023 07:07:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681394836; x=1712930836;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=o3ui4+B9QONrA1DxR7CqtVx0f1GoF/Cuz8I+r7IyAkc=;
  b=NPHSldpaqA+quQpdXwfcscHG2bdMX2MitIjReA2H4IiJWc8OiI2I1bUK
   m2eOgy2nYfyfjhyYGRnxaRscVYpJntHRVyIjNKwTg/uPLvipMnuJykBr7
   UcNySSudqCXuJ2pVWSXuGL1q3JMCi21AXt11ZUdQEZXUqOJxRLj3QxIZM
   1lPXgM4hFsbsc1SAheKkvF4pyJM+JhLLiZIHjIImRgr4PWmrP61YIhiYE
   wrl30KGotx8P4IxZeSoFB011Orq1CxXZpTdDlRGr9oGLlldinWKj4gcqg
   nSqpiKabMcSRm/lH9KA7u+NW0cHillIa2ak3a1Y6dEsytzSH82rS32rQ8
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10679"; a="409359221"
X-IronPort-AV: E=Sophos;i="5.99,193,1677571200"; 
   d="scan'208";a="409359221"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2023 06:34:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10679"; a="833154339"
X-IronPort-AV: E=Sophos;i="5.99,193,1677571200"; 
   d="scan'208";a="833154339"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 13 Apr 2023 06:34:50 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pmx69-000YiI-2u;
        Thu, 13 Apr 2023 13:34:49 +0000
Date:   Thu, 13 Apr 2023 21:34:41 +0800
From:   kernel test robot <lkp@intel.com>
To:     Yi-De Wu <yi-de.wu@mediatek.com>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Yingshiuan Pan <yingshiuan.pan@mediatek.com>
Cc:     oe-kbuild-all@lists.linux.dev, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Jades Shih <jades.shih@mediatek.com>,
        Miles Chen <miles.chen@mediatek.com>,
        Ivan Tseng <ivan.tseng@mediatek.com>,
        My Chuang <my.chuang@mediatek.com>,
        Shawn Hsiao <shawn.hsiao@mediatek.com>,
        PeiLun Suei <peilun.suei@mediatek.com>,
        Ze-Yu Wang <ze-yu.wang@mediatek.com>,
        Liju Chen <liju-clr.chen@mediatek.com>,
        Yi-De Wu <yi-de.wu@mediatek.com>
Subject: Re: [PATCH v1 6/6] soc: mediatek: virt: geniezone: Add irqfd support
Message-ID: <202304132123.rrVq3AEP-lkp@intel.com>
References: <20230413090735.4182-7-yi-de.wu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230413090735.4182-7-yi-de.wu@mediatek.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yi-De,

kernel test robot noticed the following build warnings:

[auto build test WARNING on robh/for-next]
[also build test WARNING on krzk-dt/for-next arm64/for-next/core lwn/docs-next linus/master v6.3-rc6 next-20230412]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Yi-De-Wu/docs-geniezone-Introduce-GenieZone-hypervisor/20230413-170932
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
patch link:    https://lore.kernel.org/r/20230413090735.4182-7-yi-de.wu%40mediatek.com
patch subject: [PATCH v1 6/6] soc: mediatek: virt: geniezone: Add irqfd support
config: arm64-allyesconfig (https://download.01.org/0day-ci/archive/20230413/202304132123.rrVq3AEP-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/ae996a1c7d12837f16f28975712a8bf63525cac4
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Yi-De-Wu/docs-geniezone-Introduce-GenieZone-hypervisor/20230413-170932
        git checkout ae996a1c7d12837f16f28975712a8bf63525cac4
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=arm64 olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=arm64 SHELL=/bin/bash drivers/soc/mediatek/virt/geniezone/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202304132123.rrVq3AEP-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/soc/mediatek/virt/geniezone/gzvm_eventfd.c:463:6: warning: no previous prototype for 'gzvm_irqfd_release' [-Wmissing-prototypes]
     463 | void gzvm_irqfd_release(struct gzvm *gzvm)
         |      ^~~~~~~~~~~~~~~~~~


vim +/gzvm_irqfd_release +463 drivers/soc/mediatek/virt/geniezone/gzvm_eventfd.c

   458	
   459	/*
   460	 * This function is called as the gzvm VM fd is being released. Shutdown all
   461	 * irqfds that still remain open
   462	 */
 > 463	void gzvm_irqfd_release(struct gzvm *gzvm)
   464	{
   465		struct gzvm_kernel_irqfd *irqfd, *tmp;
   466	
   467		spin_lock_irq(&gzvm->irqfds.lock);
   468	
   469		list_for_each_entry_safe(irqfd, tmp, &gzvm->irqfds.items, list)
   470			irqfd_deactivate(irqfd);
   471	
   472		spin_unlock_irq(&gzvm->irqfds.lock);
   473	
   474		/*
   475		 * Block until we know all outstanding shutdown jobs have completed.
   476		 */
   477		flush_workqueue(irqfd_cleanup_wq);
   478	}
   479	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
