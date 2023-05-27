Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F3C07135A6
	for <lists+linux-kernel@lfdr.de>; Sat, 27 May 2023 18:13:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231469AbjE0QNS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 May 2023 12:13:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231740AbjE0QNN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 May 2023 12:13:13 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B0FDC7;
        Sat, 27 May 2023 09:13:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685203992; x=1716739992;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=HRz+uuIx0+xElN7wrpO41PLA0XnkoBsOOVf57+jeZVs=;
  b=ZZMBbPpx1urJOoHlk0vM/AqUaNE/ODOB4pvalvXDp3HJGbYuu+Wyfkdf
   yUPy06tqRlWatytujwB7wmoMia3wY6CmDVwg/hr+XYbAtch5r3CB1moca
   q/BYabtFaq30THFruo1zQLoB/8uRO2DTYlxVYV1souoeQJSolfIhME59Q
   8HRgRffyep8c8bL1axPH5+gCay7vQWTo30uMVZmpwnwpOu+V0LnZoZzhd
   j74nJfD7tQmfmODr73d+mPiR0jmtLCnkEZj3R43xpziy2p/aDeRmOYwtf
   RSdUPoRkQlB+jtTI+4JBKhf7Nfp9idVPiabVAqjhf7AGcSySlOEd1zFp9
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10723"; a="356796430"
X-IronPort-AV: E=Sophos;i="6.00,197,1681196400"; 
   d="scan'208";a="356796430"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2023 09:13:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10723"; a="1035682343"
X-IronPort-AV: E=Sophos;i="6.00,197,1681196400"; 
   d="scan'208";a="1035682343"
Received: from lkp-server01.sh.intel.com (HELO dea6d5a4f140) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 27 May 2023 09:13:06 -0700
Received: from kbuild by dea6d5a4f140 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1q2wXS-000K3U-0t;
        Sat, 27 May 2023 16:13:06 +0000
Date:   Sun, 28 May 2023 00:12:32 +0800
From:   kernel test robot <lkp@intel.com>
To:     Min Li <lm0963hack@gmail.com>, alexander.deucher@amd.com
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        christian.koenig@amd.com, Xinhui.Pan@amd.com, airlied@gmail.com,
        daniel@ffwll.ch, sumit.semwal@linaro.org,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linaro-mm-sig@lists.linaro.org
Subject: Re: [PATCH] drm/radeon: fix race condition UAF in
 radeon_gem_set_domain_ioctl
Message-ID: <202305272311.JHzuoUJZ-lkp@intel.com>
References: <20230526123753.16160-1-lm0963hack@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230526123753.16160-1-lm0963hack@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Min,

kernel test robot noticed the following build warnings:

[auto build test WARNING on drm-misc/drm-misc-next]
[also build test WARNING on linus/master v6.4-rc3 next-20230525]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Min-Li/drm-radeon-fix-race-condition-UAF-in-radeon_gem_set_domain_ioctl/20230527-155623
base:   git://anongit.freedesktop.org/drm/drm-misc drm-misc-next
patch link:    https://lore.kernel.org/r/20230526123753.16160-1-lm0963hack%40gmail.com
patch subject: [PATCH] drm/radeon: fix race condition UAF in radeon_gem_set_domain_ioctl
config: riscv-randconfig-r042-20230526 (https://download.01.org/0day-ci/archive/20230527/202305272311.JHzuoUJZ-lkp@intel.com/config)
compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project 4faf3aaf28226a4e950c103a14f6fc1d1fdabb1b)
reproduce (this is a W=1 build):
        mkdir -p ~/bin
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install riscv cross compiling tool for clang build
        # apt-get install binutils-riscv64-linux-gnu
        # https://github.com/intel-lab-lkp/linux/commit/66fb975494d21e80b90235b7d8bf0953990c5c89
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Min-Li/drm-radeon-fix-race-condition-UAF-in-radeon_gem_set_domain_ioctl/20230527-155623
        git checkout 66fb975494d21e80b90235b7d8bf0953990c5c89
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang ~/bin/make.cross W=1 O=build_dir ARCH=riscv olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang ~/bin/make.cross W=1 O=build_dir ARCH=riscv SHELL=/bin/bash drivers/gpu/drm/radeon/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202305272311.JHzuoUJZ-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/gpu/drm/radeon/radeon_gem.c:462:20: warning: variable 'robj' set but not used [-Wunused-but-set-variable]
           struct radeon_bo *robj;
                             ^
   1 warning generated.


vim +/robj +462 drivers/gpu/drm/radeon/radeon_gem.c

f72a113a71ab08 Christian König 2014-08-07  453  
771fe6b912fca5 Jerome Glisse   2009-06-05  454  int radeon_gem_set_domain_ioctl(struct drm_device *dev, void *data,
771fe6b912fca5 Jerome Glisse   2009-06-05  455  				struct drm_file *filp)
771fe6b912fca5 Jerome Glisse   2009-06-05  456  {
771fe6b912fca5 Jerome Glisse   2009-06-05  457  	/* transition the BO to a domain -
771fe6b912fca5 Jerome Glisse   2009-06-05  458  	 * just validate the BO into a certain domain */
dee53e7fb3ee01 Jerome Glisse   2012-07-02  459  	struct radeon_device *rdev = dev->dev_private;
771fe6b912fca5 Jerome Glisse   2009-06-05  460  	struct drm_radeon_gem_set_domain *args = data;
771fe6b912fca5 Jerome Glisse   2009-06-05  461  	struct drm_gem_object *gobj;
4c7886791264f0 Jerome Glisse   2009-11-20 @462  	struct radeon_bo *robj;
771fe6b912fca5 Jerome Glisse   2009-06-05  463  	int r;
771fe6b912fca5 Jerome Glisse   2009-06-05  464  
771fe6b912fca5 Jerome Glisse   2009-06-05  465  	/* for now if someone requests domain CPU -
771fe6b912fca5 Jerome Glisse   2009-06-05  466  	 * just make sure the buffer is finished with */
dee53e7fb3ee01 Jerome Glisse   2012-07-02  467  	down_read(&rdev->exclusive_lock);
771fe6b912fca5 Jerome Glisse   2009-06-05  468  
771fe6b912fca5 Jerome Glisse   2009-06-05  469  	/* just do a BO wait for now */
a8ad0bd84f9860 Chris Wilson    2016-05-09  470  	gobj = drm_gem_object_lookup(filp, args->handle);
771fe6b912fca5 Jerome Glisse   2009-06-05  471  	if (gobj == NULL) {
dee53e7fb3ee01 Jerome Glisse   2012-07-02  472  		up_read(&rdev->exclusive_lock);
bf79cb914dbfe8 Chris Wilson    2010-08-04  473  		return -ENOENT;
771fe6b912fca5 Jerome Glisse   2009-06-05  474  	}
7e4d15d90afe46 Daniel Vetter   2011-02-18  475  	robj = gem_to_radeon_bo(gobj);
771fe6b912fca5 Jerome Glisse   2009-06-05  476  
771fe6b912fca5 Jerome Glisse   2009-06-05  477  	r = radeon_gem_set_domain(gobj, args->read_domains, args->write_domain);
771fe6b912fca5 Jerome Glisse   2009-06-05  478  
f11fb66ae92193 Emil Velikov    2020-05-15  479  	drm_gem_object_put(gobj);
dee53e7fb3ee01 Jerome Glisse   2012-07-02  480  	up_read(&rdev->exclusive_lock);
66fb975494d21e Min Li          2023-05-26  481  	r = radeon_gem_handle_lockup(rdev, r);
771fe6b912fca5 Jerome Glisse   2009-06-05  482  	return r;
771fe6b912fca5 Jerome Glisse   2009-06-05  483  }
771fe6b912fca5 Jerome Glisse   2009-06-05  484  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
