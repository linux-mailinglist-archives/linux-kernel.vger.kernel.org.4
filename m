Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 507EC726512
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 17:53:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241504AbjFGPxa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 11:53:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235682AbjFGPx2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 11:53:28 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B7A3199D;
        Wed,  7 Jun 2023 08:53:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686153207; x=1717689207;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=uPnMmCmZE1Xlj5mTktqTOUCGshsLZyVT68mlGsmxeg0=;
  b=XFbzJ/uxYweMIZYbkTLFzWypo2Qh3Hq5At0V1qmfd7nONlRGQXpPqyKm
   ziLCel2IA2b+Yvtr4NYoBxPb5TM3P8aoVQjDgMTxRYbUVhPd56Yu9g0QT
   PtQ7qen6tDMGBY6c3BLZV43hOsTOoJQPp+SLlHUlkGOE7x/UblpZShwL4
   EXL65rTd92PSJI9B9fCXnHTy2LdXORbqi0VnZ+0T2y0RzeLShGip9f+EB
   HTlwx1sk852xl+ozqAPFHv2iyXkM+iW4rIHDdzJIAHQw5m6azoFAM8r/M
   P0ZcWvJl1Vx+YiQjL2LKtr7qeL5YP7BC1QX1ntqTklyABSCQDDmdK1GeP
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10734"; a="360359262"
X-IronPort-AV: E=Sophos;i="6.00,224,1681196400"; 
   d="scan'208";a="360359262"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2023 08:53:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10734"; a="739333990"
X-IronPort-AV: E=Sophos;i="6.00,224,1681196400"; 
   d="scan'208";a="739333990"
Received: from lkp-server01.sh.intel.com (HELO 15ab08e44a81) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 07 Jun 2023 08:53:20 -0700
Received: from kbuild by 15ab08e44a81 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1q6vTL-0006iF-31;
        Wed, 07 Jun 2023 15:53:19 +0000
Date:   Wed, 7 Jun 2023 23:52:59 +0800
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
Subject: Re: [PATCH drm-next v4 12/14] drm/nouveau: nvkm/vmm: implement raw
 ops to manage uvmm
Message-ID: <202306072317.vpcwyh1W-lkp@intel.com>
References: <20230606223130.6132-13-dakr@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230606223130.6132-13-dakr@redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
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
patch link:    https://lore.kernel.org/r/20230606223130.6132-13-dakr%40redhat.com
patch subject: [PATCH drm-next v4 12/14] drm/nouveau: nvkm/vmm: implement raw ops to manage uvmm
config: riscv-rv32_defconfig (https://download.01.org/0day-ci/archive/20230607/202306072317.vpcwyh1W-lkp@intel.com/config)
compiler: riscv32-linux-gcc (GCC) 12.3.0
reproduce (this is a W=1 build):
        mkdir -p ~/bin
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git checkout 33a86170888b7e4aa0cea94ebb9c67180139cea9
        b4 shazam https://lore.kernel.org/r/20230606223130.6132-13-dakr@redhat.com
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.3.0 ~/bin/make.cross W=1 O=build_dir ARCH=riscv olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.3.0 ~/bin/make.cross W=1 O=build_dir ARCH=riscv SHELL=/bin/bash drivers/gpu/drm/

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202306072317.vpcwyh1W-lkp@intel.com/

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
https://github.com/intel/lkp-tests/wiki
