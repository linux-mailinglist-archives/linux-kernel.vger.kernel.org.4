Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B6C66CFB7F
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 08:28:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230222AbjC3G2y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 02:28:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjC3G2x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 02:28:53 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C36CD4C3B;
        Wed, 29 Mar 2023 23:28:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680157731; x=1711693731;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=dMIpxtZhNrHRgy4hDqTvo4WSn4xHgM65jT7zx1crFVs=;
  b=chCAw6zGccfVKemf7gGsPGbhKHkqs3rR/+cWGfgGpeTHkR69ZDAciwlZ
   qisjx86IuBqyxXXdqq4cvf56RqeWisARk2RVKLfGydMJPW52JVJP2u604
   3VkwlUDXxx79vIUZbrNbdT5V6Fnv1bS6pOfcnX2ZPlI28LA2dIjM7AeK/
   mMKcd8EQoxkkf44S4t1EZQxQ5ab2wqp7l/DUcxZAxoCtH1MySIEKd9y+Z
   fcvYsYB+pYXc7LY3Qn5I+py8mqbu5ZKIOUimygs5KhnDl5imCqDi6V9hK
   OkiwwWiWDttUhBZ/Vn5+TNE+JWd1LeCKDlJlS6TLGpkoPmwwqz3G2wSLb
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10664"; a="325003963"
X-IronPort-AV: E=Sophos;i="5.98,303,1673942400"; 
   d="scan'208";a="325003963"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2023 23:28:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10664"; a="753872371"
X-IronPort-AV: E=Sophos;i="5.98,303,1673942400"; 
   d="scan'208";a="753872371"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 29 Mar 2023 23:28:34 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1phllx-000KRQ-35;
        Thu, 30 Mar 2023 06:28:33 +0000
Date:   Thu, 30 Mar 2023 14:28:11 +0800
From:   kernel test robot <lkp@intel.com>
To:     Sui Jingfeng <15330273260@189.cn>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        suijingfeng <suijingfeng@loongson.cn>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Christian Koenig <christian.koenig@amd.com>
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        linaro-mm-sig@lists.linaro.org, loongson-kernel@lists.loongnix.cn,
        Li Yi <liyi@loongson.cn>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, nathan@kernel.org,
        linux-media@vger.kernel.org
Subject: Re: [PATCH v9 2/2] drm: add kms driver for loongson display
 controller
Message-ID: <202303301403.lRjtbd5K-lkp@intel.com>
References: <20230329155033.1303550-3-15330273260@189.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230329155033.1303550-3-15330273260@189.cn>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sui,

I love your patch! Perhaps something to improve:

[auto build test WARNING on drm-misc/drm-misc-next]
[also build test WARNING on linus/master v6.3-rc4 next-20230329]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Sui-Jingfeng/MAINTAINERS-add-maintainers-for-DRM-LOONGSON-driver/20230329-235338
base:   git://anongit.freedesktop.org/drm/drm-misc drm-misc-next
patch link:    https://lore.kernel.org/r/20230329155033.1303550-3-15330273260%40189.cn
patch subject: [PATCH v9 2/2] drm: add kms driver for loongson display controller
config: x86_64-allyesconfig (https://download.01.org/0day-ci/archive/20230330/202303301403.lRjtbd5K-lkp@intel.com/config)
compiler: clang version 14.0.6 (https://github.com/llvm/llvm-project f28c006a5895fc0e329fe15fead81e37457cb1d1)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/ed6a57085a2dc87999193a71c28399a56e29097b
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Sui-Jingfeng/MAINTAINERS-add-maintainers-for-DRM-LOONGSON-driver/20230329-235338
        git checkout ed6a57085a2dc87999193a71c28399a56e29097b
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash drivers/fpga/ drivers/gpu/drm/loongson/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202303301403.lRjtbd5K-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/gpu/drm/loongson/lsdc_drv.c:342:11: warning: variable 'ddev' is uninitialized when used here [-Wuninitialized]
                   drm_err(ddev, "Not known device, the driver need update!\n");
                           ^~~~
   include/drm/drm_print.h:469:16: note: expanded from macro 'drm_err'
           __drm_printk((drm), err,, "*ERROR* " fmt, ##__VA_ARGS__)
                         ^~~
   include/drm/drm_print.h:456:21: note: expanded from macro '__drm_printk'
           dev_##level##type((drm)->dev, "[drm] " fmt, ##__VA_ARGS__)
                              ^~~
   include/linux/dev_printk.h:144:44: note: expanded from macro 'dev_err'
           dev_printk_index_wrap(_dev_err, KERN_ERR, dev, dev_fmt(fmt), ##__VA_ARGS__)
                                                     ^~~
   include/linux/dev_printk.h:110:11: note: expanded from macro 'dev_printk_index_wrap'
                   _p_func(dev, fmt, ##__VA_ARGS__);                       \
                           ^~~
   drivers/gpu/drm/loongson/lsdc_drv.c:326:25: note: initialize the variable 'ddev' to silence this warning
           struct drm_device *ddev;
                                  ^
                                   = NULL
   1 warning generated.


vim +/ddev +342 drivers/gpu/drm/loongson/lsdc_drv.c

   321	
   322	static int lsdc_pci_probe(struct pci_dev *pdev,
   323				  const struct pci_device_id *ent)
   324	{
   325		const struct lsdc_desc *descp;
   326		struct drm_device *ddev;
   327		struct lsdc_device *ldev;
   328		int ret;
   329	
   330		ret = pcim_enable_device(pdev);
   331		if (ret)
   332			return ret;
   333	
   334		pci_set_master(pdev);
   335	
   336		ret = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(40));
   337		if (ret)
   338			return ret;
   339	
   340		descp = lsdc_detect_chip(pdev, ent);
   341		if (IS_ERR_OR_NULL(descp)) {
 > 342			drm_err(ddev, "Not known device, the driver need update!\n");
   343			return -ENODEV;
   344		}
   345	
   346		dev_info(&pdev->dev, "%s found, revision: %u",
   347			 chip_to_str(descp->chip), pdev->revision);
   348	
   349		ldev = lsdc_create_device(pdev, descp, &lsdc_drm_driver);
   350		if (IS_ERR(ldev))
   351			return PTR_ERR(ldev);
   352	
   353		ddev = &ldev->base;
   354	
   355		pci_set_drvdata(pdev, ddev);
   356	
   357		ret = devm_request_irq(&pdev->dev,
   358				       pdev->irq,
   359				       lsdc_get_irq_handler(descp),
   360				       IRQF_SHARED,
   361				       dev_name(&pdev->dev),
   362				       ddev);
   363		if (ret) {
   364			drm_err(ddev, "Failed to register interrupt: %d\n", ret);
   365			return ret;
   366		}
   367	
   368		ret = drm_dev_register(ddev, 0);
   369		if (ret)
   370			return ret;
   371	
   372		drm_fbdev_generic_setup(ddev, 32);
   373	
   374		return 0;
   375	}
   376	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
