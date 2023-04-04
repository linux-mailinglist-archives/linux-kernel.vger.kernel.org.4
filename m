Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01E936D5834
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 07:51:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233411AbjDDFvS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 01:51:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233417AbjDDFvR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 01:51:17 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5B2C1713;
        Mon,  3 Apr 2023 22:51:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680587475; x=1712123475;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=n3G2OuYaOWQow3ISG9SZGQT2IwS+n1euaI1EX7smRF0=;
  b=OqUWTeNoDqJHI4xoNdyySCyWpXO/hgnT35tu2vYAnhQ1xCL7ni5bGcIN
   1RbwObcRoBDHPQP7DO3xFic7HCQmh6j+xAlPm2+TziW513Z2HnHGmXX4D
   bnoOo8qLoM359sSQtV2le2qGFRBz/7xel+UXoTz783zqPO8xCNYA+1Yhx
   zjv7qvMouw7mpLyM/Bw9voQILRcgSgTLxp8nzlwAdpK3i79R7z7DFcvWV
   bifiGSssSF5gvWN/6KD+NjOPLkJZQJhnhl5lyMG/Gc7nTNYnI198/jRJa
   zn1PFie/iW8c1OSNlVoN80s+v52+avdeMM86D2EaDnEodPOBs4a3P2/tq
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10669"; a="322489006"
X-IronPort-AV: E=Sophos;i="5.98,316,1673942400"; 
   d="scan'208";a="322489006"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2023 22:51:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10669"; a="750793445"
X-IronPort-AV: E=Sophos;i="5.98,316,1673942400"; 
   d="scan'208";a="750793445"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 03 Apr 2023 22:51:08 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pjZZT-000PG2-2l;
        Tue, 04 Apr 2023 05:51:07 +0000
Date:   Tue, 4 Apr 2023 13:50:41 +0800
From:   kernel test robot <lkp@intel.com>
To:     Danilo Krummrich <dakr@redhat.com>, airlied@gmail.com,
        daniel@ffwll.ch, tzimmermann@suse.de, mripard@kernel.org,
        corbet@lwn.net, christian.koenig@amd.com, bskeggs@redhat.com,
        Liam.Howlett@oracle.com, matthew.brost@intel.com,
        boris.brezillon@collabora.com, alexdeucher@gmail.com,
        ogabbay@kernel.org, bagasdotme@gmail.com, willy@infradead.org,
        jason@jlekstrand.net
Cc:     oe-kbuild-all@lists.linux.dev, linux-doc@vger.kernel.org,
        nouveau@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-mm@kvack.org,
        Danilo Krummrich <dakr@redhat.com>
Subject: Re: [PATCH drm-next v3 13/15] drm/nouveau: nvkm/vmm: implement raw
 ops to manage uvmm
Message-ID: <202304041311.bWxdWPX0-lkp@intel.com>
References: <20230404012741.116502-14-dakr@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230404012741.116502-14-dakr@redhat.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Danilo,

kernel test robot noticed the following build warnings:

[auto build test WARNING on d36d68fd1925d33066d52468b7c7c6aca6521248]

url:    https://github.com/intel-lab-lkp/linux/commits/Danilo-Krummrich/drm-execution-context-for-GEM-buffers-v3/20230404-093042
base:   d36d68fd1925d33066d52468b7c7c6aca6521248
patch link:    https://lore.kernel.org/r/20230404012741.116502-14-dakr%40redhat.com
patch subject: [PATCH drm-next v3 13/15] drm/nouveau: nvkm/vmm: implement raw ops to manage uvmm
config: arc-randconfig-r043-20230403 (https://download.01.org/0day-ci/archive/20230404/202304041311.bWxdWPX0-lkp@intel.com/config)
compiler: arc-elf-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/ff73c969805aef784d47f6bedea6c15c8548d0bf
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Danilo-Krummrich/drm-execution-context-for-GEM-buffers-v3/20230404-093042
        git checkout ff73c969805aef784d47f6bedea6c15c8548d0bf
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=arc olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=arc SHELL=/bin/bash drivers/gpu/drm/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202304041311.bWxdWPX0-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from drivers/gpu/drm/nouveau/nvkm/subdev/mmu/vmm.h:4,
                    from drivers/gpu/drm/nouveau/nvkm/subdev/mmu/uvmm.h:5,
                    from drivers/gpu/drm/nouveau/nvkm/subdev/mmu/uvmm.c:22:
   drivers/gpu/drm/nouveau/nvkm/subdev/mmu/uvmm.c: In function 'nvkm_uvmm_mthd_raw_map':
>> drivers/gpu/drm/nouveau/nvkm/subdev/mmu/uvmm.c:422:31: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]
     422 |                               (void *)args->argv, args->argc);
         |                               ^
   drivers/gpu/drm/nouveau/include/nvkm/core/memory.h:66:43: note: in definition of macro 'nvkm_memory_map'
      66 |         (p)->func->map((p),(o),(vm),(va),(av),(ac))
         |                                           ^~


vim +422 drivers/gpu/drm/nouveau/nvkm/subdev/mmu/uvmm.c

   388	
   389	static int
   390	nvkm_uvmm_mthd_raw_map(struct nvkm_uvmm *uvmm, struct nvif_vmm_raw_v0 *args)
   391	{
   392		struct nvkm_client *client = uvmm->object.client;
   393		struct nvkm_vmm *vmm = uvmm->vmm;
   394		struct nvkm_vma vma = {
   395			.addr = args->addr,
   396			.size = args->size,
   397			.used = true,
   398			.mapref = false,
   399			.no_comp = true,
   400		};
   401		struct nvkm_memory *memory;
   402		u64 handle = args->memory;
   403		u8 refd;
   404		int ret;
   405	
   406		if (!nvkm_vmm_in_managed_range(vmm, args->addr, args->size))
   407			return -EINVAL;
   408	
   409		ret = nvkm_uvmm_page_index(uvmm, args->size, args->shift, &refd);
   410		if (ret)
   411			return ret;
   412	
   413		vma.page = vma.refd = refd;
   414	
   415		memory = nvkm_umem_search(client, args->memory);
   416		if (IS_ERR(memory)) {
   417			VMM_DEBUG(vmm, "memory %016llx %ld\n", handle, PTR_ERR(memory));
   418			return PTR_ERR(memory);
   419		}
   420	
   421		ret = nvkm_memory_map(memory, args->offset, vmm, &vma,
 > 422				      (void *)args->argv, args->argc);
   423	
   424		nvkm_memory_unref(&vma.memory);
   425		nvkm_memory_unref(&memory);
   426		return ret;
   427	}
   428	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
