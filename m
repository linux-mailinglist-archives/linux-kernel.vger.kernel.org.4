Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8A226A9950
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 15:19:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230115AbjCCOTZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 09:19:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229803AbjCCOTX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 09:19:23 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3F211FC6
        for <linux-kernel@vger.kernel.org>; Fri,  3 Mar 2023 06:19:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677853161; x=1709389161;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=1wnEZkA3pxEN1ki3zirkYIIVEuxqXMawj7Ozlqv74lc=;
  b=i5tb+vBgnCOGZQXQyickKDLKU4e3SWXx3aFTaNcmiGyaexuwH5oMQt/P
   ncUhJj6GuO/mgS4hlUWxHvxKcRUsVdO+vn2+ROIqShRD3Q6eKKJIDRByl
   QmKhFAST00UffTXdCru6/NYQVLZynP2ZShrckGg48QNUqze4IOme3JUMK
   2YdPoOwMRjt5As75CTWVs+oGHqnlTwji6y5iRv301rFb8QRAg6HF4N96O
   VK9FFXrkaY8OZAcTru94LSakn+yW5Xr+6zsH8tBI3gCaSG6lykYRvKt/Z
   9LbDces6ccRlI35sClPgX9InBWQPQDZaCVCHDyaNkI25lbvsQjq3fHKXb
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10637"; a="336571861"
X-IronPort-AV: E=Sophos;i="5.98,230,1673942400"; 
   d="scan'208";a="336571861"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2023 06:19:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10637"; a="705656748"
X-IronPort-AV: E=Sophos;i="5.98,230,1673942400"; 
   d="scan'208";a="705656748"
Received: from lkp-server01.sh.intel.com (HELO 776573491cc5) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 03 Mar 2023 06:19:16 -0800
Received: from kbuild by 776573491cc5 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pY6Ff-0001TW-1H;
        Fri, 03 Mar 2023 14:19:15 +0000
Date:   Fri, 3 Mar 2023 22:18:41 +0800
From:   kernel test robot <lkp@intel.com>
To:     Marek Maslanka <mmaslanka@chromium.org>,
        dri-devel@lists.freedesktop.org
Cc:     oe-kbuild-all@lists.linux.dev, Lijo Lazar <lijo.lazar@amd.com>,
        linux-kernel@vger.kernel.org,
        Michel =?iso-8859-1?Q?D=E4nzer?= <mdaenzer@redhat.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Guchun Chen <guchun.chen@amd.com>,
        amd-gfx@lists.freedesktop.org, Marek Maslanka <mm@semihalf.com>,
        Luben Tuikov <luben.tuikov@amd.com>,
        Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>,
        Dominik Behr <dbehr@chromium.org>,
        Evan Quan <evan.quan@amd.com>, Tong Liu01 <Tong.Liu01@amd.com>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>,
        YiPeng Chai <YiPeng.Chai@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        Hawking Zhang <Hawking.Zhang@amd.com>
Subject: Re: [PATCH] drm/amdgpu: Implement mmap of imported dma-bufs
Message-ID: <202303032218.9kvEePUv-lkp@intel.com>
References: <20230303110951.3777850-1-mmaslanka@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230303110951.3777850-1-mmaslanka@chromium.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marek,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on drm-misc/drm-misc-next]
[also build test WARNING on drm/drm-next drm-intel/for-linux-next drm-tip/drm-tip linus/master next-20230303]
[cannot apply to drm-intel/for-linux-next-fixes v6.2]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Marek-Maslanka/drm-amdgpu-Implement-mmap-of-imported-dma-bufs/20230303-191145
base:   git://anongit.freedesktop.org/drm/drm-misc drm-misc-next
patch link:    https://lore.kernel.org/r/20230303110951.3777850-1-mmaslanka%40chromium.org
patch subject: [PATCH] drm/amdgpu: Implement mmap of imported dma-bufs
config: sparc-allyesconfig (https://download.01.org/0day-ci/archive/20230303/202303032218.9kvEePUv-lkp@intel.com/config)
compiler: sparc64-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/2916257baab842afa387781faf1b595b73249767
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Marek-Maslanka/drm-amdgpu-Implement-mmap-of-imported-dma-bufs/20230303-191145
        git checkout 2916257baab842afa387781faf1b595b73249767
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=sparc olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=sparc SHELL=/bin/bash drivers/gpu/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202303032218.9kvEePUv-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c: In function 'amdgpu_try_dma_buf_mmap':
>> drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c:286:27: warning: variable 'bo' set but not used [-Wunused-but-set-variable]
     286 |         struct amdgpu_bo *bo = NULL;
         |                           ^~
   In file included from drivers/gpu/drm/amd/amdgpu/../display/dc/dc_types.h:36,
                    from drivers/gpu/drm/amd/amdgpu/../display/dc/dm_services_types.h:30,
                    from drivers/gpu/drm/amd/amdgpu/../include/dm_pp_interface.h:26,
                    from drivers/gpu/drm/amd/amdgpu/amdgpu.h:64,
                    from drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c:34:
   drivers/gpu/drm/amd/amdgpu/../display/dc/dc_hdmi_types.h: At top level:
   drivers/gpu/drm/amd/amdgpu/../display/dc/dc_hdmi_types.h:53:22: warning: 'dp_hdmi_dongle_signature_str' defined but not used [-Wunused-const-variable=]
      53 | static const uint8_t dp_hdmi_dongle_signature_str[] = "DP-HDMI ADAPTOR";
         |                      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~


vim +/bo +286 drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c

   278	
   279	int amdgpu_try_dma_buf_mmap(struct file *filp, struct vm_area_struct *vma)
   280	{
   281		struct drm_file *priv = filp->private_data;
   282		struct drm_device *dev = priv->minor->dev;
   283		struct amdgpu_device *adev = drm_to_adev(dev);
   284		struct ttm_device *bdev = &adev->mman.bdev;
   285		struct ttm_buffer_object *tbo = NULL;
 > 286		struct amdgpu_bo *bo = NULL;
   287		struct drm_gem_object *obj = NULL;
   288		struct drm_vma_offset_node *node;
   289		int ret;
   290	
   291		if (drm_dev_is_unplugged(dev))
   292			return -ENODEV;
   293	
   294		drm_vma_offset_lock_lookup(bdev->vma_manager);
   295		node = drm_vma_offset_exact_lookup_locked(bdev->vma_manager,
   296							  vma->vm_pgoff,
   297							  vma_pages(vma));
   298	
   299		if (likely(node)) {
   300			tbo = container_of(node, struct ttm_buffer_object,
   301					   base.vma_node);
   302			tbo = ttm_bo_get_unless_zero(tbo);
   303		}
   304		drm_vma_offset_unlock_lookup(bdev->vma_manager);
   305	
   306		if (!tbo)
   307			return -EINVAL;
   308	
   309		bo = ttm_to_amdgpu_bo(tbo);
   310		obj = &tbo->base;
   311	
   312		if (!obj->import_attach) {
   313			ret = -EINVAL;
   314			goto done;
   315		}
   316	
   317		ret = dma_buf_mmap(obj->import_attach->dmabuf, vma, 0);
   318	
   319	done:
   320		ttm_bo_put(tbo);
   321		return ret;
   322	}
   323	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
