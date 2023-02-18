Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E74E269B751
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Feb 2023 02:06:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229811AbjBRBGu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 20:06:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229805AbjBRBGq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 20:06:46 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AFF2457E9;
        Fri, 17 Feb 2023 17:06:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676682405; x=1708218405;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=yqcTpH8JDrzqr0UESTfYfiiFLiZTLM14iR9yAw77QO8=;
  b=h5D6cVOJP2SR/51sE0pech51vpHZc0xz16vB8zTa5QaBNNJSST/Hv+yR
   b7HPeSFyDQzHxzv1iK4G8twJyHCH6YxOJZFphMOMTxAWpDPMi3Kn5ae1k
   kiuC7NVSTpyqcJ9Pj/uqF71v88Nlv1N4o+270v2VL1eCiI0+CbQqfXFLc
   M4ogBkzS2oGaQe82vGAk3KWXdmzuB9pz3UdTT4aswnIYmeFOaUUBT729I
   qKw+mYvCCScb1SgZz4oNwy+jzv6sGhW6muPLJfROGTGiaTI+D2LcBp06a
   7GL0hwYQXCL0vIl7FP7onxVFf9ilcw4M8wgz9itrD0fxVYz9TTPJItAMa
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10624"; a="394611763"
X-IronPort-AV: E=Sophos;i="5.97,306,1669104000"; 
   d="scan'208";a="394611763"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2023 17:06:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10624"; a="734496298"
X-IronPort-AV: E=Sophos;i="5.97,306,1669104000"; 
   d="scan'208";a="734496298"
Received: from lkp-server01.sh.intel.com (HELO 4455601a8d94) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 17 Feb 2023 17:06:40 -0800
Received: from kbuild by 4455601a8d94 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pTBgV-000BxN-1w;
        Sat, 18 Feb 2023 01:06:39 +0000
Date:   Sat, 18 Feb 2023 09:05:55 +0800
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
        Danilo Krummrich <dakr@redhat.com>,
        Dave Airlie <airlied@redhat.com>
Subject: Re: [PATCH drm-next v2 05/16] drm: manager to keep track of GPUs VA
 mappings
Message-ID: <202302180805.b0ab40V5-lkp@intel.com>
References: <20230217134422.14116-6-dakr@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230217134422.14116-6-dakr@redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Danilo,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on 48075a66fca613477ac1969b576a93ef5db0164f]

url:    https://github.com/intel-lab-lkp/linux/commits/Danilo-Krummrich/drm-execution-context-for-GEM-buffers/20230217-215101
base:   48075a66fca613477ac1969b576a93ef5db0164f
patch link:    https://lore.kernel.org/r/20230217134422.14116-6-dakr%40redhat.com
patch subject: [PATCH drm-next v2 05/16] drm: manager to keep track of GPUs VA mappings
config: mips-allyesconfig (https://download.01.org/0day-ci/archive/20230218/202302180805.b0ab40V5-lkp@intel.com/config)
compiler: mips-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/00132cc92b6745cfd51c0d5df4c246a848f2ceaa
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Danilo-Krummrich/drm-execution-context-for-GEM-buffers/20230217-215101
        git checkout 00132cc92b6745cfd51c0d5df4c246a848f2ceaa
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=mips olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=mips SHELL=/bin/bash drivers/gpu/drm/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202302180805.b0ab40V5-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/gpu/drm/drm_gpuva_mgr.c:1383:5: warning: no previous prototype for 'drm_gpuva_sm_step' [-Wmissing-prototypes]
    1383 | int drm_gpuva_sm_step(struct drm_gpuva_op *__op, void *priv)
         |     ^~~~~~~~~~~~~~~~~
--
>> drivers/gpu/drm/drm_gpuva_mgr.c:529: warning: expecting prototype for drm_gpuva_remove_iter(). Prototype was for drm_gpuva_iter_remove() instead
   drivers/gpu/drm/drm_gpuva_mgr.c:549: warning: Excess function parameter 'addr' description in 'drm_gpuva_insert'
   drivers/gpu/drm/drm_gpuva_mgr.c:549: warning: Excess function parameter 'range' description in 'drm_gpuva_insert'
   drivers/gpu/drm/drm_gpuva_mgr.c:765: warning: Excess function parameter 'addr' description in 'drm_gpuva_region_insert'
   drivers/gpu/drm/drm_gpuva_mgr.c:765: warning: Excess function parameter 'range' description in 'drm_gpuva_region_insert'
   drivers/gpu/drm/drm_gpuva_mgr.c:1345: warning: Excess function parameter 'ops' description in 'drm_gpuva_sm_unmap'
   drivers/gpu/drm/drm_gpuva_mgr.c:1589: warning: Function parameter or member 'addr' not described in 'drm_gpuva_prefetch_ops_create'
   drivers/gpu/drm/drm_gpuva_mgr.c:1589: warning: Function parameter or member 'range' not described in 'drm_gpuva_prefetch_ops_create'
   drivers/gpu/drm/drm_gpuva_mgr.c:1589: warning: Excess function parameter 'req_addr' description in 'drm_gpuva_prefetch_ops_create'
   drivers/gpu/drm/drm_gpuva_mgr.c:1589: warning: Excess function parameter 'req_range' description in 'drm_gpuva_prefetch_ops_create'


vim +/drm_gpuva_sm_step +1383 drivers/gpu/drm/drm_gpuva_mgr.c

  1382	
> 1383	int drm_gpuva_sm_step(struct drm_gpuva_op *__op, void *priv)
  1384	{
  1385		struct {
  1386			struct drm_gpuva_manager *mgr;
  1387			struct drm_gpuva_ops *ops;
  1388		} *args = priv;
  1389		struct drm_gpuva_manager *mgr = args->mgr;
  1390		struct drm_gpuva_ops *ops = args->ops;
  1391		struct drm_gpuva_op *op;
  1392	
  1393		op = gpuva_op_alloc(mgr);
  1394		if (unlikely(!op))
  1395			goto err;
  1396	
  1397		memcpy(op, __op, sizeof(*op));
  1398	
  1399		if (op->op == DRM_GPUVA_OP_REMAP) {
  1400			struct drm_gpuva_op_remap *__r = &__op->remap;
  1401			struct drm_gpuva_op_remap *r = &op->remap;
  1402	
  1403			r->unmap = kmemdup(__r->unmap, sizeof(*r->unmap),
  1404					   GFP_KERNEL);
  1405			if (unlikely(!r->unmap))
  1406				goto err_free_op;
  1407	
  1408			if (__r->prev) {
  1409				r->prev = kmemdup(__r->prev, sizeof(*r->prev),
  1410						  GFP_KERNEL);
  1411				if (unlikely(!r->prev))
  1412					goto err_free_unmap;
  1413			}
  1414	
  1415			if (__r->next) {
  1416				r->next = kmemdup(__r->next, sizeof(*r->next),
  1417						  GFP_KERNEL);
  1418				if (unlikely(!r->next))
  1419					goto err_free_prev;
  1420			}
  1421		}
  1422	
  1423		list_add_tail(&op->entry, &ops->list);
  1424	
  1425		return 0;
  1426	
  1427	err_free_unmap:
  1428		kfree(op->remap.unmap);
  1429	err_free_prev:
  1430		kfree(op->remap.prev);
  1431	err_free_op:
  1432		gpuva_op_free(mgr, op);
  1433	err:
  1434		return -ENOMEM;
  1435	}
  1436	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
