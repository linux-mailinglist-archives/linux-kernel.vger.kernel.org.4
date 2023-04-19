Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B4C16E77A8
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 12:45:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232713AbjDSKpD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 06:45:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232440AbjDSKoy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 06:44:54 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CC29BE;
        Wed, 19 Apr 2023 03:44:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681901092; x=1713437092;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=XnfoaCcH3MWyJZkIKskW2BAZXpZylboTWI3thPO1+Yo=;
  b=dN/JmMBJ3oCVjeqKnoct1A9BHknqPTpzNmeuDQ47+DHT3h70ogWs/BwL
   wEyT8hUw6rCaIp9brZ0VXNmaLzB4+pfeo7+KiNyGhKH+BGmEAcfJF2+s5
   XXX/A667MWqIFeTbvE6iVqOo1DFJMiSYRmFvTqPCaIBJ9hyHn8WJINBQZ
   MlPnSgI4xWnyvXfOCFYj0+dfGwp0ClyU4rRxG8rhVqZ1amSEyAz38LRfX
   fCG6zCk9SamvIxReYF8Azt+KTTsf3YtAclRbPrKGRzlux0Ng5H+2EM88e
   w2doDnqRlxSO/1DkeGwXnTqA8DosZiXm2Ry16uJaIhBulDchrAiiWQXal
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10684"; a="325748500"
X-IronPort-AV: E=Sophos;i="5.99,208,1677571200"; 
   d="scan'208";a="325748500"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2023 03:44:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10684"; a="691462456"
X-IronPort-AV: E=Sophos;i="5.99,208,1677571200"; 
   d="scan'208";a="691462456"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 19 Apr 2023 03:44:48 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pp5It-000ep9-16;
        Wed, 19 Apr 2023 10:44:47 +0000
Date:   Wed, 19 Apr 2023 18:44:37 +0800
From:   kernel test robot <lkp@intel.com>
To:     hackyzh002 <hackyzh002@gmail.com>, alexander.deucher@amd.com
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        christian.koenig@amd.com, Xinhui.Pan@amd.com, airlied@gmail.com,
        daniel@ffwll.ch, sumit.semwal@linaro.org,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linaro-mm-sig@lists.linaro.org, hackyzh002 <hackyzh002@gmail.com>
Subject: Re: [PATCH 2/2] drm/amdgpu: Fix integer overflow in amdgpu_cs_pass1
Message-ID: <202304191814.1O8ppodq-lkp@intel.com>
References: <20230419045157.69829-1-hackyzh002@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230419045157.69829-1-hackyzh002@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi hackyzh002,

kernel test robot noticed the following build errors:

[auto build test ERROR on drm-misc/drm-misc-next]
[also build test ERROR on linus/master v6.3-rc7 next-20230418]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/hackyzh002/drm-amdgpu-Fix-integer-overflow-in-amdgpu_cs_pass1/20230419-125344
base:   git://anongit.freedesktop.org/drm/drm-misc drm-misc-next
patch link:    https://lore.kernel.org/r/20230419045157.69829-1-hackyzh002%40gmail.com
patch subject: [PATCH 2/2] drm/amdgpu: Fix integer overflow in amdgpu_cs_pass1
config: arm64-buildonly-randconfig-r004-20230416 (https://download.01.org/0day-ci/archive/20230419/202304191814.1O8ppodq-lkp@intel.com/config)
compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project 437b7602e4a998220871de78afcb020b9c14a661)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm64 cross compiling tool for clang build
        # apt-get install binutils-aarch64-linux-gnu
        # https://github.com/intel-lab-lkp/linux/commit/c4a89869bcb6b68ad0e1eed0dd4f18c8cc7fbfc5
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review hackyzh002/drm-amdgpu-Fix-integer-overflow-in-amdgpu_cs_pass1/20230419-125344
        git checkout c4a89869bcb6b68ad0e1eed0dd4f18c8cc7fbfc5
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm64 olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm64 SHELL=/bin/bash drivers/gpu/drm/amd/amdgpu/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202304191814.1O8ppodq-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c:195:11: error: cannot combine with previous 'type-name' declaration specifier
           uint64_t int size;
                    ^
   1 error generated.


vim +195 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c

   184	
   185	/* Copy the data from userspace and go over it the first time */
   186	static int amdgpu_cs_pass1(struct amdgpu_cs_parser *p,
   187				   union drm_amdgpu_cs *cs)
   188	{
   189		struct amdgpu_fpriv *fpriv = p->filp->driver_priv;
   190		unsigned int num_ibs[AMDGPU_CS_GANG_SIZE] = { };
   191		struct amdgpu_vm *vm = &fpriv->vm;
   192		uint64_t *chunk_array_user;
   193		uint64_t *chunk_array;
   194		uint32_t uf_offset = 0;
 > 195		uint64_t int size;
   196		int ret;
   197		int i;
   198	
   199		chunk_array = kvmalloc_array(cs->in.num_chunks, sizeof(uint64_t),
   200					     GFP_KERNEL);
   201		if (!chunk_array)
   202			return -ENOMEM;
   203	
   204		/* get chunks */
   205		chunk_array_user = u64_to_user_ptr(cs->in.chunks);
   206		if (copy_from_user(chunk_array, chunk_array_user,
   207				   sizeof(uint64_t)*cs->in.num_chunks)) {
   208			ret = -EFAULT;
   209			goto free_chunk;
   210		}
   211	
   212		p->nchunks = cs->in.num_chunks;
   213		p->chunks = kvmalloc_array(p->nchunks, sizeof(struct amdgpu_cs_chunk),
   214				    GFP_KERNEL);
   215		if (!p->chunks) {
   216			ret = -ENOMEM;
   217			goto free_chunk;
   218		}
   219	
   220		for (i = 0; i < p->nchunks; i++) {
   221			struct drm_amdgpu_cs_chunk __user **chunk_ptr = NULL;
   222			struct drm_amdgpu_cs_chunk user_chunk;
   223			uint32_t __user *cdata;
   224	
   225			chunk_ptr = u64_to_user_ptr(chunk_array[i]);
   226			if (copy_from_user(&user_chunk, chunk_ptr,
   227					       sizeof(struct drm_amdgpu_cs_chunk))) {
   228				ret = -EFAULT;
   229				i--;
   230				goto free_partial_kdata;
   231			}
   232			p->chunks[i].chunk_id = user_chunk.chunk_id;
   233			p->chunks[i].length_dw = user_chunk.length_dw;
   234	
   235			size = p->chunks[i].length_dw;
   236			cdata = u64_to_user_ptr(user_chunk.chunk_data);
   237	
   238			p->chunks[i].kdata = kvcalloc(size, sizeof(uint32_t),
   239							    GFP_KERNEL);
   240			if (p->chunks[i].kdata == NULL) {
   241				ret = -ENOMEM;
   242				i--;
   243				goto free_partial_kdata;
   244			}
   245			size *= sizeof(uint32_t);
   246			if (copy_from_user(p->chunks[i].kdata, cdata, size)) {
   247				ret = -EFAULT;
   248				goto free_partial_kdata;
   249			}
   250	
   251			/* Assume the worst on the following checks */
   252			ret = -EINVAL;
   253			switch (p->chunks[i].chunk_id) {
   254			case AMDGPU_CHUNK_ID_IB:
   255				if (size < sizeof(struct drm_amdgpu_cs_chunk_ib))
   256					goto free_partial_kdata;
   257	
   258				ret = amdgpu_cs_p1_ib(p, p->chunks[i].kdata, num_ibs);
   259				if (ret)
   260					goto free_partial_kdata;
   261				break;
   262	
   263			case AMDGPU_CHUNK_ID_FENCE:
   264				if (size < sizeof(struct drm_amdgpu_cs_chunk_fence))
   265					goto free_partial_kdata;
   266	
   267				ret = amdgpu_cs_p1_user_fence(p, p->chunks[i].kdata,
   268							      &uf_offset);
   269				if (ret)
   270					goto free_partial_kdata;
   271				break;
   272	
   273			case AMDGPU_CHUNK_ID_BO_HANDLES:
   274				if (size < sizeof(struct drm_amdgpu_bo_list_in))
   275					goto free_partial_kdata;
   276	
   277				ret = amdgpu_cs_p1_bo_handles(p, p->chunks[i].kdata);
   278				if (ret)
   279					goto free_partial_kdata;
   280				break;
   281	
   282			case AMDGPU_CHUNK_ID_DEPENDENCIES:
   283			case AMDGPU_CHUNK_ID_SYNCOBJ_IN:
   284			case AMDGPU_CHUNK_ID_SYNCOBJ_OUT:
   285			case AMDGPU_CHUNK_ID_SCHEDULED_DEPENDENCIES:
   286			case AMDGPU_CHUNK_ID_SYNCOBJ_TIMELINE_WAIT:
   287			case AMDGPU_CHUNK_ID_SYNCOBJ_TIMELINE_SIGNAL:
   288				break;
   289	
   290			default:
   291				goto free_partial_kdata;
   292			}
   293		}
   294	
   295		if (!p->gang_size) {
   296			ret = -EINVAL;
   297			goto free_partial_kdata;
   298		}
   299	
   300		for (i = 0; i < p->gang_size; ++i) {
   301			ret = amdgpu_job_alloc(p->adev, vm, p->entities[i], vm,
   302					       num_ibs[i], &p->jobs[i]);
   303			if (ret)
   304				goto free_all_kdata;
   305		}
   306		p->gang_leader = p->jobs[p->gang_leader_idx];
   307	
   308		if (p->ctx->vram_lost_counter != p->gang_leader->vram_lost_counter) {
   309			ret = -ECANCELED;
   310			goto free_all_kdata;
   311		}
   312	
   313		if (p->uf_entry.tv.bo)
   314			p->gang_leader->uf_addr = uf_offset;
   315		kvfree(chunk_array);
   316	
   317		/* Use this opportunity to fill in task info for the vm */
   318		amdgpu_vm_set_task_info(vm);
   319	
   320		return 0;
   321	
   322	free_all_kdata:
   323		i = p->nchunks - 1;
   324	free_partial_kdata:
   325		for (; i >= 0; i--)
   326			kvfree(p->chunks[i].kdata);
   327		kvfree(p->chunks);
   328		p->chunks = NULL;
   329		p->nchunks = 0;
   330	free_chunk:
   331		kvfree(chunk_array);
   332	
   333		return ret;
   334	}
   335	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
