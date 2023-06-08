Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DF937280AA
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 14:55:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234908AbjFHMzq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 08:55:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234678AbjFHMzo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 08:55:44 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3EB630FE;
        Thu,  8 Jun 2023 05:55:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686228921; x=1717764921;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ANx6CbIhekRQ83tFcSsoMWFj7V/9tdCSO1pg4R3s0Pw=;
  b=B3q67o5qfyNEfwR+i1FvGfA7KglTezB298gnA0QxSkZT4bRi6eDH8bWH
   S4GabtqYp+6HG3G64Y0JDkJKu0uVcJaZrLWZc3K35oX6ZQv8ueeO0S2Nc
   9UucgREdjmH92SqT9qBs2jZDPR+zrLYv1bkVEpBbkQQ1DkQ6EwphQloG4
   DamjRRnyBDlE2vHafnAzTvM0PPOXCLhPdaqvevA7RVmkyDvTVRDUh5kt4
   j4skVu60sUSQ7XFKZ9aAaCfvjHA424ZAaqDdHrYIWVP9nU4kt9HwS4tDA
   k0rOtlCPcjocLKg/LICtf1MW6noLLSiFAJ40EK56KqilgbisI0LQeDDyE
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10734"; a="346912550"
X-IronPort-AV: E=Sophos;i="6.00,226,1681196400"; 
   d="scan'208";a="346912550"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2023 05:54:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10734"; a="743098987"
X-IronPort-AV: E=Sophos;i="6.00,226,1681196400"; 
   d="scan'208";a="743098987"
Received: from lkp-server01.sh.intel.com (HELO 15ab08e44a81) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 08 Jun 2023 05:54:08 -0700
Received: from kbuild by 15ab08e44a81 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1q7F9U-0007mw-0z;
        Thu, 08 Jun 2023 12:54:08 +0000
Date:   Thu, 8 Jun 2023 20:53:34 +0800
From:   kernel test robot <lkp@intel.com>
To:     Danilo Krummrich <dakr@redhat.com>, airlied@gmail.com,
        daniel@ffwll.ch, tzimmermann@suse.de, mripard@kernel.org,
        corbet@lwn.net, christian.koenig@amd.com, bskeggs@redhat.com,
        Liam.Howlett@oracle.com, matthew.brost@intel.com,
        boris.brezillon@collabora.com, alexdeucher@gmail.com,
        ogabbay@kernel.org, bagasdotme@gmail.com, willy@infradead.org,
        jason@jlekstrand.net
Cc:     oe-kbuild-all@lists.linux.dev, dri-devel@lists.freedesktop.org,
        nouveau@lists.freedesktop.org, linux-doc@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Danilo Krummrich <dakr@redhat.com>
Subject: Re: [PATCH drm-next v4 13/14] drm/nouveau: implement new VM_BIND uAPI
Message-ID: <202306082035.J4ZJW2HE-lkp@intel.com>
References: <20230606223130.6132-14-dakr@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230606223130.6132-14-dakr@redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Danilo,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 33a86170888b7e4aa0cea94ebb9c67180139cea9]

url:    https://github.com/intel-lab-lkp/linux/commits/Danilo-Krummrich/drm-execution-context-for-GEM-buffers-v4/20230607-063442
base:   33a86170888b7e4aa0cea94ebb9c67180139cea9
patch link:    https://lore.kernel.org/r/20230606223130.6132-14-dakr%40redhat.com
patch subject: [PATCH drm-next v4 13/14] drm/nouveau: implement new VM_BIND uAPI
config: alpha-randconfig-s041-20230608 (https://download.01.org/0day-ci/archive/20230608/202306082035.J4ZJW2HE-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 12.3.0
reproduce:
        mkdir -p ~/bin
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-39-gce1a6720-dirty
        # https://github.com/intel-lab-lkp/linux/commit/28d9f3973f9ed165312943fb05304fad878abb33
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Danilo-Krummrich/drm-execution-context-for-GEM-buffers-v4/20230607-063442
        git checkout 28d9f3973f9ed165312943fb05304fad878abb33
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.3.0 ~/bin/make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=alpha olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.3.0 ~/bin/make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=alpha SHELL=/bin/bash drivers/gpu/drm/

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202306082035.J4ZJW2HE-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/gpu/drm/nouveau/nouveau_drm.c:1194:9: sparse: sparse: incorrect type in initializer (incompatible argument 2 (different address spaces)) @@     expected int ( [usertype] *func )( ... ) @@     got int ( * )( ... ) @@
   drivers/gpu/drm/nouveau/nouveau_drm.c:1194:9: sparse:     expected int ( [usertype] *func )( ... )
   drivers/gpu/drm/nouveau/nouveau_drm.c:1194:9: sparse:     got int ( * )( ... )
   drivers/gpu/drm/nouveau/nouveau_drm.c:1195:9: sparse: sparse: incorrect type in initializer (incompatible argument 2 (different address spaces)) @@     expected int ( [usertype] *func )( ... ) @@     got int ( * )( ... ) @@
   drivers/gpu/drm/nouveau/nouveau_drm.c:1195:9: sparse:     expected int ( [usertype] *func )( ... )
   drivers/gpu/drm/nouveau/nouveau_drm.c:1195:9: sparse:     got int ( * )( ... )
   drivers/gpu/drm/nouveau/nouveau_drm.c:1196:9: sparse: sparse: incorrect type in initializer (incompatible argument 2 (different address spaces)) @@     expected int ( [usertype] *func )( ... ) @@     got int ( * )( ... ) @@
   drivers/gpu/drm/nouveau/nouveau_drm.c:1196:9: sparse:     expected int ( [usertype] *func )( ... )
   drivers/gpu/drm/nouveau/nouveau_drm.c:1196:9: sparse:     got int ( * )( ... )
--
>> drivers/gpu/drm/nouveau/nouveau_exec.c:305:19: sparse: sparse: dereference of noderef expression
   drivers/gpu/drm/nouveau/nouveau_exec.c:306:19: sparse: sparse: dereference of noderef expression
   drivers/gpu/drm/nouveau/nouveau_exec.c:307:20: sparse: sparse: dereference of noderef expression
   drivers/gpu/drm/nouveau/nouveau_exec.c:308:20: sparse: sparse: dereference of noderef expression
   drivers/gpu/drm/nouveau/nouveau_exec.c:309:21: sparse: sparse: dereference of noderef expression
   drivers/gpu/drm/nouveau/nouveau_exec.c:310:21: sparse: sparse: dereference of noderef expression
   drivers/gpu/drm/nouveau/nouveau_exec.c:378:43: sparse: sparse: dereference of noderef expression
   drivers/gpu/drm/nouveau/nouveau_exec.c:393:13: sparse: sparse: dereference of noderef expression
   drivers/gpu/drm/nouveau/nouveau_exec.c:396:13: sparse: sparse: dereference of noderef expression
   drivers/gpu/drm/nouveau/nouveau_exec.c:397:17: sparse: sparse: dereference of noderef expression
--
   drivers/gpu/drm/nouveau/nouveau_uvmm.c:1637:1: sparse: sparse: symbol 'nouveau_uvmm_ioctl_vm_init' redeclared with different type (incompatible argument 2 (different address spaces)):
>> drivers/gpu/drm/nouveau/nouveau_uvmm.c:1637:1: sparse:    int extern [addressable] [signed] [toplevel] nouveau_uvmm_ioctl_vm_init( ... )
   drivers/gpu/drm/nouveau/nouveau_uvmm.c: note: in included file (through drivers/gpu/drm/nouveau/nouveau_drv.h):
   drivers/gpu/drm/nouveau/nouveau_uvmm.h:91:5: sparse: note: previously declared as:
>> drivers/gpu/drm/nouveau/nouveau_uvmm.h:91:5: sparse:    int extern [addressable] [signed] [toplevel] nouveau_uvmm_ioctl_vm_init( ... )
   drivers/gpu/drm/nouveau/nouveau_uvmm.c:342:17: sparse: sparse: context imbalance in '__nouveau_uvma_region_insert' - unexpected unlock
>> drivers/gpu/drm/nouveau/nouveau_uvmm.c:1674:19: sparse: sparse: dereference of noderef expression
   drivers/gpu/drm/nouveau/nouveau_uvmm.c:1675:19: sparse: sparse: dereference of noderef expression
   drivers/gpu/drm/nouveau/nouveau_uvmm.c:1676:20: sparse: sparse: dereference of noderef expression
   drivers/gpu/drm/nouveau/nouveau_uvmm.c:1677:20: sparse: sparse: dereference of noderef expression
   drivers/gpu/drm/nouveau/nouveau_uvmm.c:1678:19: sparse: sparse: dereference of noderef expression
   drivers/gpu/drm/nouveau/nouveau_uvmm.c:1679:19: sparse: sparse: dereference of noderef expression
   drivers/gpu/drm/nouveau/nouveau_uvmm.c:1682:23: sparse: sparse: dereference of noderef expression

vim +1194 drivers/gpu/drm/nouveau/nouveau_drm.c

  1177	
  1178	static const struct drm_ioctl_desc
  1179	nouveau_ioctls[] = {
  1180		DRM_IOCTL_DEF_DRV(NOUVEAU_GETPARAM, nouveau_abi16_ioctl_getparam, DRM_RENDER_ALLOW),
  1181		DRM_IOCTL_DEF_DRV(NOUVEAU_SETPARAM, drm_invalid_op, DRM_AUTH|DRM_MASTER|DRM_ROOT_ONLY),
  1182		DRM_IOCTL_DEF_DRV(NOUVEAU_CHANNEL_ALLOC, nouveau_abi16_ioctl_channel_alloc, DRM_RENDER_ALLOW),
  1183		DRM_IOCTL_DEF_DRV(NOUVEAU_CHANNEL_FREE, nouveau_abi16_ioctl_channel_free, DRM_RENDER_ALLOW),
  1184		DRM_IOCTL_DEF_DRV(NOUVEAU_GROBJ_ALLOC, nouveau_abi16_ioctl_grobj_alloc, DRM_RENDER_ALLOW),
  1185		DRM_IOCTL_DEF_DRV(NOUVEAU_NOTIFIEROBJ_ALLOC, nouveau_abi16_ioctl_notifierobj_alloc, DRM_RENDER_ALLOW),
  1186		DRM_IOCTL_DEF_DRV(NOUVEAU_GPUOBJ_FREE, nouveau_abi16_ioctl_gpuobj_free, DRM_RENDER_ALLOW),
  1187		DRM_IOCTL_DEF_DRV(NOUVEAU_SVM_INIT, nouveau_svmm_init, DRM_RENDER_ALLOW),
  1188		DRM_IOCTL_DEF_DRV(NOUVEAU_SVM_BIND, nouveau_svmm_bind, DRM_RENDER_ALLOW),
  1189		DRM_IOCTL_DEF_DRV(NOUVEAU_GEM_NEW, nouveau_gem_ioctl_new, DRM_RENDER_ALLOW),
  1190		DRM_IOCTL_DEF_DRV(NOUVEAU_GEM_PUSHBUF, nouveau_gem_ioctl_pushbuf, DRM_RENDER_ALLOW),
  1191		DRM_IOCTL_DEF_DRV(NOUVEAU_GEM_CPU_PREP, nouveau_gem_ioctl_cpu_prep, DRM_RENDER_ALLOW),
  1192		DRM_IOCTL_DEF_DRV(NOUVEAU_GEM_CPU_FINI, nouveau_gem_ioctl_cpu_fini, DRM_RENDER_ALLOW),
  1193		DRM_IOCTL_DEF_DRV(NOUVEAU_GEM_INFO, nouveau_gem_ioctl_info, DRM_RENDER_ALLOW),
> 1194		DRM_IOCTL_DEF_DRV(NOUVEAU_VM_INIT, nouveau_uvmm_ioctl_vm_init, DRM_RENDER_ALLOW),
  1195		DRM_IOCTL_DEF_DRV(NOUVEAU_VM_BIND, nouveau_uvmm_ioctl_vm_bind, DRM_RENDER_ALLOW),
  1196		DRM_IOCTL_DEF_DRV(NOUVEAU_EXEC, nouveau_exec_ioctl_exec, DRM_RENDER_ALLOW),
  1197	};
  1198	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
