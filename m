Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF4A8672220
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 16:51:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229753AbjARPvw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 10:51:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231361AbjARPut (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 10:50:49 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E04454B33;
        Wed, 18 Jan 2023 07:49:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674056946; x=1705592946;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ubxFEVMm5YYB3VrYIrqG9EKRH6fdQ+yOpwcejaGig3k=;
  b=F45Yg/+TxzFDdBoTl3Lz6gceN30d69WCMBoVJ+Lx3CtJgvOvkY1bcvBl
   5oCNPDl8ck3Ur8/nRkRqpTc0kP9ACBw0G3Qq1TloeLNbfWO7/E+WLsL10
   POLfEXdH2czTpCgQCVvizq43MB2chMFh6PPK/Wjb8ZwbSgL966ijRsa/7
   2XkN2J2S3gPFrsHtTwUIFq4loyZVlsZyp6IOAxIrSPUGmgBBvI8Ti37I4
   Jn2vaPY4ThCOwfBkr5jrDhejyBp/qg2rzwKvM357LzWHY1cty6kyoFQ3u
   pjHIgVATofRQyySUy88t2BhA8EMb2vh742ZAh63xKYGa8u/BDDO2j4e0W
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10594"; a="322702217"
X-IronPort-AV: E=Sophos;i="5.97,226,1669104000"; 
   d="scan'208";a="322702217"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2023 07:48:57 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10594"; a="661760688"
X-IronPort-AV: E=Sophos;i="5.97,226,1669104000"; 
   d="scan'208";a="661760688"
Received: from lkp-server01.sh.intel.com (HELO 5646d64e7320) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 18 Jan 2023 07:48:54 -0800
Received: from kbuild by 5646d64e7320 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pIAgH-0000TM-0x;
        Wed, 18 Jan 2023 15:48:53 +0000
Date:   Wed, 18 Jan 2023 23:47:59 +0800
From:   kernel test robot <lkp@intel.com>
To:     Danilo Krummrich <dakr@redhat.com>, daniel@ffwll.ch,
        airlied@redhat.com, christian.koenig@amd.com, bskeggs@redhat.com,
        jason@jlekstrand.net, tzimmermann@suse.de, mripard@kernel.org,
        corbet@lwn.net
Cc:     oe-kbuild-all@lists.linux.dev, nouveau@lists.freedesktop.org,
        Danilo Krummrich <dakr@redhat.com>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-doc@vger.kernel.org
Subject: Re: [PATCH drm-next 04/14] drm: debugfs: provide infrastructure to
 dump a DRM GPU VA space
Message-ID: <202301182345.0gL7pjUf-lkp@intel.com>
References: <20230118061256.2689-5-dakr@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230118061256.2689-5-dakr@redhat.com>
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

[auto build test WARNING on 0b45ac1170ea6416bc1d36798414c04870cd356d]

url:    https://github.com/intel-lab-lkp/linux/commits/Danilo-Krummrich/drm-execution-context-for-GEM-buffers/20230118-141552
base:   0b45ac1170ea6416bc1d36798414c04870cd356d
patch link:    https://lore.kernel.org/r/20230118061256.2689-5-dakr%40redhat.com
patch subject: [PATCH drm-next 04/14] drm: debugfs: provide infrastructure to dump a DRM GPU VA space
config: parisc-randconfig-s041-20230115 (https://download.01.org/0day-ci/archive/20230118/202301182345.0gL7pjUf-lkp@intel.com/config)
compiler: hppa-linux-gcc (GCC) 12.1.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-39-gce1a6720-dirty
        # https://github.com/intel-lab-lkp/linux/commit/e00f79934034ce7eb4e7fc0d722a3d28d75d44bf
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Danilo-Krummrich/drm-execution-context-for-GEM-buffers/20230118-141552
        git checkout e00f79934034ce7eb4e7fc0d722a3d28d75d44bf
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=parisc olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=parisc SHELL=/bin/bash drivers/gpu/drm/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>

sparse warnings: (new ones prefixed by >>)
>> drivers/gpu/drm/drm_debugfs.c:228:33: sparse: sparse: non size-preserving pointer to integer cast

vim +228 drivers/gpu/drm/drm_debugfs.c

   178	
   179	/**
   180	 * drm_debugfs_gpuva_info - dump the given DRM GPU VA space
   181	 * @m: pointer to the &seq_file to write
   182	 * @mgr: the &drm_gpuva_manager representing the GPU VA space
   183	 *
   184	 * Dumps the GPU VA regions and mappings of a given DRM GPU VA manager.
   185	 *
   186	 * For each DRM GPU VA space drivers should call this function from their
   187	 * &drm_info_list's show callback.
   188	 *
   189	 * Returns: 0 on success, -ENODEV if the &mgr is not initialized
   190	 */
   191	int drm_debugfs_gpuva_info(struct seq_file *m,
   192				   struct drm_gpuva_manager *mgr)
   193	{
   194		struct drm_gpuva_region *reg;
   195		struct drm_gpuva *va;
   196	
   197		if (!mgr->name)
   198			return -ENODEV;
   199	
   200		seq_printf(m, "DRM GPU VA space (%s)\n", mgr->name);
   201		seq_puts  (m, "\n");
   202		seq_puts  (m, " VA regions  | start              | range              | end                | sparse\n");
   203		seq_puts  (m, "------------------------------------------------------------------------------------\n");
   204		seq_printf(m, " VA space    | 0x%016llx | 0x%016llx | 0x%016llx |   -\n",
   205			   mgr->mm_start, mgr->mm_range, mgr->mm_start + mgr->mm_range);
   206		seq_puts  (m, "-----------------------------------------------------------------------------------\n");
   207		drm_gpuva_for_each_region(reg, mgr) {
   208			struct drm_mm_node *node = &reg->node;
   209	
   210			if (node == &mgr->kernel_alloc_node) {
   211				seq_printf(m, " kernel node | 0x%016llx | 0x%016llx | 0x%016llx |   -\n",
   212					   node->start, node->size, node->start + node->size);
   213				continue;
   214			}
   215	
   216			seq_printf(m, "             | 0x%016llx | 0x%016llx | 0x%016llx | %s\n",
   217				   node->start, node->size, node->start + node->size,
   218				   reg->sparse ? "true" : "false");
   219		}
   220		seq_puts(m, "\n");
   221		seq_puts(m, " VAs | start              | range              | end                | object             | object offset\n");
   222		seq_puts(m, "-------------------------------------------------------------------------------------------------------------\n");
   223		drm_gpuva_for_each_va(va, mgr) {
   224			struct drm_mm_node *node = &va->node;
   225	
   226			seq_printf(m, "     | 0x%016llx | 0x%016llx | 0x%016llx | 0x%016llx | 0x%016llx\n",
   227				   node->start, node->size, node->start + node->size,
 > 228				   (u64)va->gem.obj, va->gem.offset);
   229		}
   230	
   231		return 0;
   232	}
   233	EXPORT_SYMBOL(drm_debugfs_gpuva_info);
   234	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
