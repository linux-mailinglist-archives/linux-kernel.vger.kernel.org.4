Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB6F15BB5A3
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Sep 2022 04:52:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229572AbiIQCv5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 22:51:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbiIQCv4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 22:51:56 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03CE0BB699
        for <linux-kernel@vger.kernel.org>; Fri, 16 Sep 2022 19:51:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663383115; x=1694919115;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=8bsMJuYcMiiRmBbzCultx6M+qoWX/K6RuDq8bj/JIf4=;
  b=GqUlF/ZEQQEhynCE285OETqQjbRmtynj3JATbIg45Tniv9A78yMle7qk
   usc8wIDmsWWvsB6hr2AikGRlQZa+glo/4sh4ILVS9oS2gB77CToTLx3sW
   5vGUU54c+EMlMLtrKKNDkJcRcv1tCUZX1uXm0PebqeQ82D56KImNm5GRE
   HeWr0fuhji/XVYWd7mJ6xNp/8f58moRuB7618GWJ7O3EV+xdqvXslW6iG
   B343Ig1N/wJh9abZ9YlrCfENaABSJuYHdAsRAB3mtZWiSR0pbxiuw6wg4
   z5ybgGt2oYiT+sN0TyP8+JSF4k5EMiXd/+j4QUX+TLyR7b4Jdem0ANmqU
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10472"; a="282143450"
X-IronPort-AV: E=Sophos;i="5.93,322,1654585200"; 
   d="scan'208";a="282143450"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2022 19:51:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,322,1654585200"; 
   d="scan'208";a="760258151"
Received: from lkp-server02.sh.intel.com (HELO 41300c7200ea) ([10.239.97.151])
  by fmsmga001.fm.intel.com with ESMTP; 16 Sep 2022 19:51:52 -0700
Received: from kbuild by 41300c7200ea with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oZNvs-0002PG-0R;
        Sat, 17 Sep 2022 02:51:52 +0000
Date:   Sat, 17 Sep 2022 10:51:28 +0800
From:   kernel test robot <lkp@intel.com>
To:     Robin Murphy <robin.murphy@arm.com>, joro@8bytes.org,
        will@kernel.org
Cc:     kbuild-all@lists.01.org, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iommu: Optimise PCI SAC address trick
Message-ID: <202209171032.XILNq94O-lkp@intel.com>
References: <cd0a0f8ae2c8e05a9322cd180920f9d422f52034.1663354405.git.robin.murphy@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cd0a0f8ae2c8e05a9322cd180920f9d422f52034.1663354405.git.robin.murphy@arm.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Robin,

I love your patch! Yet something to improve:

[auto build test ERROR on linus/master]
[also build test ERROR on v6.0-rc5 next-20220916]
[cannot apply to joro-iommu/next]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Robin-Murphy/iommu-Optimise-PCI-SAC-address-trick/20220917-025450
base:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 6879c2d3b96039ff1668b4328a4d0dd3ea952cff
config: x86_64-randconfig-a011 (https://download.01.org/0day-ci/archive/20220917/202209171032.XILNq94O-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-5) 11.3.0
reproduce (this is a W=1 build):
        # https://github.com/intel-lab-lkp/linux/commit/1ca86b189e7b2485d270f516a4547306fa8dc941
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Robin-Murphy/iommu-Optimise-PCI-SAC-address-trick/20220917-025450
        git checkout 1ca86b189e7b2485d270f516a4547306fa8dc941
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   drivers/iommu/iommu.c: In function '__iommu_probe_device':
>> drivers/iommu/iommu.c:259:14: error: 'iommu_dma_forcedac' undeclared (first use in this function)
     259 |         if (!iommu_dma_forcedac && dev_is_pci(dev))
         |              ^~~~~~~~~~~~~~~~~~
   drivers/iommu/iommu.c:259:14: note: each undeclared identifier is reported only once for each function it appears in


vim +/iommu_dma_forcedac +259 drivers/iommu/iommu.c

   220	
   221	static int __iommu_probe_device(struct device *dev, struct list_head *group_list)
   222	{
   223		const struct iommu_ops *ops = dev->bus->iommu_ops;
   224		struct iommu_device *iommu_dev;
   225		struct iommu_group *group;
   226		int ret;
   227	
   228		if (!ops)
   229			return -ENODEV;
   230	
   231		if (!dev_iommu_get(dev))
   232			return -ENOMEM;
   233	
   234		if (!try_module_get(ops->owner)) {
   235			ret = -EINVAL;
   236			goto err_free;
   237		}
   238	
   239		iommu_dev = ops->probe_device(dev);
   240		if (IS_ERR(iommu_dev)) {
   241			ret = PTR_ERR(iommu_dev);
   242			goto out_module_put;
   243		}
   244	
   245		dev->iommu->iommu_dev = iommu_dev;
   246	
   247		group = iommu_group_get_for_dev(dev);
   248		if (IS_ERR(group)) {
   249			ret = PTR_ERR(group);
   250			goto out_release;
   251		}
   252		iommu_group_put(group);
   253	
   254		if (group_list && !group->default_domain && list_empty(&group->entry))
   255			list_add_tail(&group->entry, group_list);
   256	
   257		iommu_device_link(iommu_dev, dev);
   258	
 > 259		if (!iommu_dma_forcedac && dev_is_pci(dev))
   260			dev->iommu->pci_workaround = true;
   261	
   262		return 0;
   263	
   264	out_release:
   265		if (ops->release_device)
   266			ops->release_device(dev);
   267	
   268	out_module_put:
   269		module_put(ops->owner);
   270	
   271	err_free:
   272		dev_iommu_free(dev);
   273	
   274		return ret;
   275	}
   276	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
