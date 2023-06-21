Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3127073791A
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 04:27:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229836AbjFUC1A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 22:27:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbjFUC06 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 22:26:58 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 759C4B4;
        Tue, 20 Jun 2023 19:26:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687314417; x=1718850417;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=EoAhUS47E9izYuucHbuu0d9aZFBnVw73UJlUamg3hvE=;
  b=fjj6ndaV2lMaW+rySiUGJ0MJRLJABKhwJgWcwd+Zcf39pxv9UUvX3gA+
   3INuHgIIeeAmHfkDMIMx5MF31dd+3qzaR3MCnZD6C8lX7dK2KPIOQsnKg
   HP+dT9qxLhUD8KqkIca8iqOA0Qt3tJabWZqBZ+JDS7Rg/qEwkf6LbE4IR
   qCxdaHHIsw13g6F1YReo9lWeYQNtDOexA1UCUYV3wK7fyneNTAW6ytsPo
   GF2g2yXhXBaqXgcyI4xQ5TDv1KhbHVNMIWxVZH2xn7J4SRkJnBFecMoU+
   T5iZhnm8Qll8lD+sZTTTtdYkaWa0ibdrahxtGOyOCY0G2Duf+hiLnL26z
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10747"; a="362584507"
X-IronPort-AV: E=Sophos;i="6.00,259,1681196400"; 
   d="scan'208";a="362584507"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2023 19:26:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10747"; a="779670492"
X-IronPort-AV: E=Sophos;i="6.00,259,1681196400"; 
   d="scan'208";a="779670492"
Received: from lkp-server01.sh.intel.com (HELO 783282924a45) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 20 Jun 2023 19:26:52 -0700
Received: from kbuild by 783282924a45 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qBnYZ-0006Sg-1R;
        Wed, 21 Jun 2023 02:26:51 +0000
Date:   Wed, 21 Jun 2023 10:26:16 +0800
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
Subject: Re: [PATCH drm-next v5 09/14] drm/nouveau: fence: separate fence
 alloc and emit
Message-ID: <202306211017.r9G5NqSc-lkp@intel.com>
References: <20230620004217.4700-10-dakr@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230620004217.4700-10-dakr@redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Danilo,

kernel test robot noticed the following build errors:

[auto build test ERROR on 2222dcb0775d36de28992f56455ab3967b30d380]

url:    https://github.com/intel-lab-lkp/linux/commits/Danilo-Krummrich/drm-execution-context-for-GEM-buffers-v4/20230620-084448
base:   2222dcb0775d36de28992f56455ab3967b30d380
patch link:    https://lore.kernel.org/r/20230620004217.4700-10-dakr%40redhat.com
patch subject: [PATCH drm-next v5 09/14] drm/nouveau: fence: separate fence alloc and emit
config: arm64-allyesconfig (https://download.01.org/0day-ci/archive/20230621/202306211017.r9G5NqSc-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 12.3.0
reproduce: (https://download.01.org/0day-ci/archive/20230621/202306211017.r9G5NqSc-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202306211017.r9G5NqSc-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/gpu/drm/nouveau/nouveau_dmem.c: In function 'nouveau_dmem_migrate_chunk':
>> drivers/gpu/drm/nouveau/nouveau_dmem.c:681:43: error: 'chunk' undeclared (first use in this function)
     681 |                 nouveau_fence_emit(fence, chunk->drm->dmem->migrate.chan);
         |                                           ^~~~~
   drivers/gpu/drm/nouveau/nouveau_dmem.c:681:43: note: each undeclared identifier is reported only once for each function it appears in


vim +/chunk +681 drivers/gpu/drm/nouveau/nouveau_dmem.c

   664	
   665	static void nouveau_dmem_migrate_chunk(struct nouveau_drm *drm,
   666			struct nouveau_svmm *svmm, struct migrate_vma *args,
   667			dma_addr_t *dma_addrs, u64 *pfns)
   668	{
   669		struct nouveau_fence *fence;
   670		unsigned long addr = args->start, nr_dma = 0, i;
   671	
   672		for (i = 0; addr < args->end; i++) {
   673			args->dst[i] = nouveau_dmem_migrate_copy_one(drm, svmm,
   674					args->src[i], dma_addrs + nr_dma, pfns + i);
   675			if (!dma_mapping_error(drm->dev->dev, dma_addrs[nr_dma]))
   676				nr_dma++;
   677			addr += PAGE_SIZE;
   678		}
   679	
   680		if (!nouveau_fence_new(&fence))
 > 681			nouveau_fence_emit(fence, chunk->drm->dmem->migrate.chan);
   682		migrate_vma_pages(args);
   683		nouveau_dmem_fence_done(&fence);
   684		nouveau_pfns_map(svmm, args->vma->vm_mm, args->start, pfns, i);
   685	
   686		while (nr_dma--) {
   687			dma_unmap_page(drm->dev->dev, dma_addrs[nr_dma], PAGE_SIZE,
   688					DMA_BIDIRECTIONAL);
   689		}
   690		migrate_vma_finalize(args);
   691	}
   692	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
