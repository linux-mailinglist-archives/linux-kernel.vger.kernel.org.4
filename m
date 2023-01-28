Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C426067F7AC
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Jan 2023 12:53:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233962AbjA1Lxe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Jan 2023 06:53:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230074AbjA1Lxc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Jan 2023 06:53:32 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1F2810A8F
        for <linux-kernel@vger.kernel.org>; Sat, 28 Jan 2023 03:53:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674906810; x=1706442810;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=v56gkPCfVmp/5J0sTIEWbfckxqrXa5C8j87HJqOVgQA=;
  b=FiTrOhvOfsTIv9TolLrxNBYNZoIE2i5Tyr10GGvaFCfTK3zNOjBFhqtd
   vlK9076vN5JNKpGP8Lb5tbBLuwSlTIzLjgAc5gj8+vJ+WJ3T2k2YhVueo
   uxnym7JQpmAhk7xFUPbSssjGZLgqujYTH3S28/URehrtOU0Y4iRtHW1M0
   YlqTwc4uLBMDZ+l749v+CQf26aSLGAHznnVCW26jJMSn7Uc/OKL2/HQhq
   +N495o9avBBEAGku/pyt+Ef/5zWbKC+JvYMPNDML7R/cDLJptuYC3Q5X4
   vYOfzl0B0mK8usO/wgCZQKIJ/yQxoTQdwPZZZtECEFvfELMak/pSfA8h3
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10603"; a="329412098"
X-IronPort-AV: E=Sophos;i="5.97,254,1669104000"; 
   d="scan'208";a="329412098"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2023 03:53:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10603"; a="992368716"
X-IronPort-AV: E=Sophos;i="5.97,254,1669104000"; 
   d="scan'208";a="992368716"
Received: from lkp-server01.sh.intel.com (HELO ffa7f14d1d0f) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 28 Jan 2023 03:53:27 -0800
Received: from kbuild by ffa7f14d1d0f with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pLjlv-0000cP-06;
        Sat, 28 Jan 2023 11:53:27 +0000
Date:   Sat, 28 Jan 2023 19:52:54 +0800
From:   kernel test robot <lkp@intel.com>
To:     Nicolin Chen <nicolinc@nvidia.com>, jgg@nvidia.com,
        kevin.tian@intel.com
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        yi.l.liu@intel.com, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] iommufd/device: Make hwpt_list list_add/del symmetric
Message-ID: <202301281943.Jdvwci2p-lkp@intel.com>
References: <25b3b85b03fc2a7968c476b0533f451acecdfd13.1674872884.git.nicolinc@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <25b3b85b03fc2a7968c476b0533f451acecdfd13.1674872884.git.nicolinc@nvidia.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nicolin,

I love your patch! Perhaps something to improve:

[auto build test WARNING on v6.2-rc5]
[also build test WARNING on linus/master next-20230127]
[cannot apply to joro-iommu/next]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Nicolin-Chen/iommufd-Add-devices_users-to-track-the-hw_pagetable-usage-by-device/20230128-150429
patch link:    https://lore.kernel.org/r/25b3b85b03fc2a7968c476b0533f451acecdfd13.1674872884.git.nicolinc%40nvidia.com
patch subject: [PATCH 2/3] iommufd/device: Make hwpt_list list_add/del symmetric
config: x86_64-randconfig-a011-20230123 (https://download.01.org/0day-ci/archive/20230128/202301281943.Jdvwci2p-lkp@intel.com/config)
compiler: clang version 14.0.6 (https://github.com/llvm/llvm-project f28c006a5895fc0e329fe15fead81e37457cb1d1)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/4d48fdd86375f6d888bbcf830a10c48720008955
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Nicolin-Chen/iommufd-Add-devices_users-to-track-the-hw_pagetable-usage-by-device/20230128-150429
        git checkout 4d48fdd86375f6d888bbcf830a10c48720008955
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash drivers/iommu/iommufd/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/iommu/iommufd/device.c:279:23: warning: variable 'hwpt' is uninitialized when used here [-Wuninitialized]
           lockdep_assert_held(&hwpt->ioas->mutex);
                                ^~~~
   include/linux/lockdep.h:319:33: note: expanded from macro 'lockdep_assert_held'
           lockdep_assert(lockdep_is_held(l) != LOCK_STATE_NOT_HELD)
                                          ^
   include/linux/lockdep.h:286:47: note: expanded from macro 'lockdep_is_held'
   #define lockdep_is_held(lock)           lock_is_held(&(lock)->dep_map)
                                                          ^~~~
   include/linux/lockdep.h:313:32: note: expanded from macro 'lockdep_assert'
           do { WARN_ON(debug_locks && !(cond)); } while (0)
                                         ^~~~
   include/asm-generic/bug.h:122:25: note: expanded from macro 'WARN_ON'
           int __ret_warn_on = !!(condition);                              \
                                  ^~~~~~~~~
   drivers/iommu/iommufd/device.c:276:35: note: initialize the variable 'hwpt' to silence this warning
           struct iommufd_hw_pagetable *hwpt;
                                            ^
                                             = NULL
   1 warning generated.


vim +/hwpt +279 drivers/iommu/iommufd/device.c

   267	
   268	/*
   269	 * When automatically managing the domains we search for a compatible domain in
   270	 * the iopt and if one is found use it, otherwise create a new domain.
   271	 * Automatic domain selection will never pick a manually created domain.
   272	 */
   273	static int iommufd_device_auto_get_domain(struct iommufd_device *idev,
   274						  struct iommufd_ioas *ioas)
   275	{
   276		struct iommufd_hw_pagetable *hwpt;
   277		int rc;
   278	
 > 279		lockdep_assert_held(&hwpt->ioas->mutex);
   280	
   281		/*
   282		 * There is no differentiation when domains are allocated, so any domain
   283		 * that is willing to attach to the device is interchangeable with any
   284		 * other.
   285		 */
   286		list_for_each_entry(hwpt, &ioas->hwpt_list, hwpt_item) {
   287			if (!hwpt->auto_domain)
   288				continue;
   289	
   290			rc = iommufd_device_do_attach(idev, hwpt);
   291	
   292			/*
   293			 * -EINVAL means the domain is incompatible with the device.
   294			 * Other error codes should propagate to userspace as failure.
   295			 * Success means the domain is attached.
   296			 */
   297			if (rc == -EINVAL)
   298				continue;
   299			return rc;
   300		}
   301	
   302		hwpt = iommufd_hw_pagetable_alloc(idev->ictx, ioas, idev->dev);
   303		if (IS_ERR(hwpt))
   304			return PTR_ERR(hwpt);
   305		hwpt->auto_domain = true;
   306	
   307		rc = iommufd_device_do_attach(idev, hwpt);
   308		if (rc)
   309			goto out_abort;
   310	
   311		iommufd_object_finalize(idev->ictx, &hwpt->obj);
   312		return 0;
   313	
   314	out_abort:
   315		iommufd_object_abort_and_destroy(idev->ictx, &hwpt->obj);
   316		return rc;
   317	}
   318	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
