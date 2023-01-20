Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 924DC674A4A
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 04:38:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229834AbjATDis (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 22:38:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjATDin (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 22:38:43 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FFD9A2594;
        Thu, 19 Jan 2023 19:38:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674185922; x=1705721922;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=EJl2wtDgpfUKTXoKSyUkpNnhZlVNVqNRsJl+mn9CCy8=;
  b=gFKX0tA3HHNoGhp0COhJw2M4PRZT/bFJEfEnKpEc41an1+dN8hjUG6qr
   LEla2pfZmuYdW90Rlcbin604tUz65ruhcjRWgX3tEtDqEv0wxc+5qqx/i
   Zepo3v4yO/JC219JstLxEjxpZfzJ/lggWlDFaku5g1sHkxauaDYZitm9t
   eAXQt0ZFr3Rsw2IhgvOjyaRtqPEnv2aDrUACBRB/J60Q6KEJa0Zzn2An8
   /UXfMLlfTN+dEkN5w7ihlPKDAIkpJA/aYcUUEeugSKHNjarDQyo5krgJn
   8Nfuacl8iQ9YpZNa3pEQ3tRnMmdgqsFPeABaTB7apc1IBH7sAGVpwztjl
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10595"; a="313387639"
X-IronPort-AV: E=Sophos;i="5.97,230,1669104000"; 
   d="scan'208";a="313387639"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2023 19:38:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10595"; a="638014484"
X-IronPort-AV: E=Sophos;i="5.97,230,1669104000"; 
   d="scan'208";a="638014484"
Received: from lkp-server01.sh.intel.com (HELO 5646d64e7320) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 19 Jan 2023 19:38:38 -0800
Received: from kbuild by 5646d64e7320 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pIiEf-00028w-22;
        Fri, 20 Jan 2023 03:38:37 +0000
Date:   Fri, 20 Jan 2023 11:37:55 +0800
From:   kernel test robot <lkp@intel.com>
To:     Danilo Krummrich <dakr@redhat.com>, daniel@ffwll.ch,
        airlied@redhat.com, christian.koenig@amd.com, bskeggs@redhat.com,
        jason@jlekstrand.net, tzimmermann@suse.de, mripard@kernel.org,
        corbet@lwn.net
Cc:     oe-kbuild-all@lists.linux.dev, nouveau@lists.freedesktop.org,
        Danilo Krummrich <dakr@redhat.com>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-doc@vger.kernel.org
Subject: Re: [PATCH drm-next 11/14] drm/nouveau: nvkm/vmm: implement raw ops
 to manage uvmm
Message-ID: <202301201115.THLpCShO-lkp@intel.com>
References: <20230118061256.2689-12-dakr@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230118061256.2689-12-dakr@redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Danilo,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on 0b45ac1170ea6416bc1d36798414c04870cd356d]

url:    https://github.com/intel-lab-lkp/linux/commits/Danilo-Krummrich/drm-execution-context-for-GEM-buffers/20230118-141552
base:   0b45ac1170ea6416bc1d36798414c04870cd356d
patch link:    https://lore.kernel.org/r/20230118061256.2689-12-dakr%40redhat.com
patch subject: [PATCH drm-next 11/14] drm/nouveau: nvkm/vmm: implement raw ops to manage uvmm
config: arc-randconfig-s051-20230119 (https://download.01.org/0day-ci/archive/20230120/202301201115.THLpCShO-lkp@intel.com/config)
compiler: arc-elf-gcc (GCC) 12.1.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-39-gce1a6720-dirty
        # https://github.com/intel-lab-lkp/linux/commit/5fca471110e52d7c8db10f9ff483134a546174a1
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Danilo-Krummrich/drm-execution-context-for-GEM-buffers/20230118-141552
        git checkout 5fca471110e52d7c8db10f9ff483134a546174a1
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=arc olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=arc SHELL=/bin/bash drivers/gpu/drm/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>

sparse warnings: (new ones prefixed by >>)
>> drivers/gpu/drm/nouveau/nvkm/subdev/mmu/uvmm.c:413:34: sparse: sparse: non size-preserving integer to pointer cast

vim +413 drivers/gpu/drm/nouveau/nvkm/subdev/mmu/uvmm.c

   406	
   407	static int
   408	nvkm_uvmm_mthd_raw_unmap(struct nvkm_uvmm *uvmm, struct nvif_vmm_raw_v0 *args)
   409	{
   410		struct nvkm_vmm *vmm = uvmm->vmm;
   411		struct nvkm_vma *vma;
   412	
 > 413		vma = (struct nvkm_vma *)args->handle;
   414		if (!vma)
   415			return -EINVAL;
   416	
   417		mutex_lock(&vmm->mutex);
   418		if (vma->busy) {
   419			VMM_DEBUG(vmm, "denied %016llx: %d", vma->addr, vma->busy);
   420			mutex_unlock(&vmm->mutex);
   421			return -ENOENT;
   422		}
   423		vma->sparse = args->sparse;
   424		nvkm_vmm_raw_unmap_locked(vmm, vma);
   425		mutex_unlock(&vmm->mutex);
   426	
   427		args->handle = 0;
   428		kfree(vma);
   429		return 0;
   430	}
   431	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
