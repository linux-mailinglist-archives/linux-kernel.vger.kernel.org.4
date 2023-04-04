Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B9AC6D573D
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 05:34:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232473AbjDDDeH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 23:34:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229684AbjDDDeE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 23:34:04 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABA68198A;
        Mon,  3 Apr 2023 20:34:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680579242; x=1712115242;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=y95LcMuCpo5c7PKsq3CMbqvqoeAr4Ga5Vqhi17tTnUM=;
  b=OgGza8xd+sNjLhVp4cNgOAioaCIw3LryOMErHKGt7vRa8oP3Awo+sXob
   ieVMWP1kLcoVNJQGoYQRnZjD+so+3ROarbIRhhd/F+oySKoyOwoSnYr5M
   GVetjEsgVkqg730Bn3+C9ufnHXpQf7xGPLJrVu5nWf9tZtdoqx6tq2L4b
   sQe75v7VyG8H3UzmDbnguJFipwksUumGlU3nxkCF+0x+M2QUA8RB9N5Jk
   mwcZlZtuYxAO32SkeF7G2cJbEc5MCpij5d2ZuyBWCltnrbVZnudRX7rqA
   jN9rnZ970TxknI9iqIto9yvM2D21WXqPBNFLtcpaK8t/R7kh9mXRmTA7J
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10669"; a="322472770"
X-IronPort-AV: E=Sophos;i="5.98,316,1673942400"; 
   d="scan'208";a="322472770"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2023 20:34:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10669"; a="755494807"
X-IronPort-AV: E=Sophos;i="5.98,316,1673942400"; 
   d="scan'208";a="755494807"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 03 Apr 2023 20:33:59 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pjXQk-000P7Q-1I;
        Tue, 04 Apr 2023 03:33:58 +0000
Date:   Tue, 4 Apr 2023 11:33:39 +0800
From:   kernel test robot <lkp@intel.com>
To:     Andrew Davis <afd@ti.com>, Arnd Bergmann <arnd@arndb.de>,
        Christian Gmeiner <christian.gmeiner@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        John Stultz <jstultz@google.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Sumit Semwal <sumit.semwal@linaro.org>
Cc:     oe-kbuild-all@lists.linux.dev, linux-media@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
        linux-kernel@vger.kernel.org, Andrew Davis <afd@ti.com>
Subject: Re: [PATCH v2] misc: sram: Add DMA-BUF Heap exporting of SRAM areas
Message-ID: <202304041144.t5JCOGsE-lkp@intel.com>
References: <20230403192433.26648-1-afd@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230403192433.26648-1-afd@ti.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

kernel test robot noticed the following build warnings:

[auto build test WARNING on char-misc/char-misc-testing]
[also build test WARNING on char-misc/char-misc-next char-misc/char-misc-linus soc/for-next pza/reset/next linus/master v6.3-rc5 next-20230403]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Andrew-Davis/misc-sram-Add-DMA-BUF-Heap-exporting-of-SRAM-areas/20230404-032607
patch link:    https://lore.kernel.org/r/20230403192433.26648-1-afd%40ti.com
patch subject: [PATCH v2] misc: sram: Add DMA-BUF Heap exporting of SRAM areas
config: loongarch-allyesconfig (https://download.01.org/0day-ci/archive/20230404/202304041144.t5JCOGsE-lkp@intel.com/config)
compiler: loongarch64-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/6fcaa3c7cfbc144dd982f9abaa1c5af50dde24a8
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Andrew-Davis/misc-sram-Add-DMA-BUF-Heap-exporting-of-SRAM-areas/20230404-032607
        git checkout 6fcaa3c7cfbc144dd982f9abaa1c5af50dde24a8
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=loongarch olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=loongarch SHELL=/bin/bash drivers/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202304041144.t5JCOGsE-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/misc/sram-dma-heap.c:161:17: warning: no previous prototype for 'sram_dma_heap_allocate' [-Wmissing-prototypes]
     161 | struct dma_buf *sram_dma_heap_allocate(struct dma_heap *heap,
         |                 ^~~~~~~~~~~~~~~~~~~~~~


vim +/sram_dma_heap_allocate +161 drivers/misc/sram-dma-heap.c

   160	
 > 161	struct dma_buf *sram_dma_heap_allocate(struct dma_heap *heap,
   162					       unsigned long len,
   163					       unsigned long fd_flags,
   164					       unsigned long heap_flags)
   165	{
   166		struct sram_dma_heap *sram_dma_heap = dma_heap_get_drvdata(heap);
   167		struct sram_dma_heap_buffer *buffer;
   168	
   169		DEFINE_DMA_BUF_EXPORT_INFO(exp_info);
   170		struct dma_buf *dmabuf;
   171		int ret;
   172	
   173		buffer = kzalloc(sizeof(*buffer), GFP_KERNEL);
   174		if (!buffer)
   175			return ERR_PTR(-ENOMEM);
   176		buffer->pool = sram_dma_heap->pool;
   177		INIT_LIST_HEAD(&buffer->attachments);
   178		mutex_init(&buffer->attachments_lock);
   179		buffer->len = len;
   180	
   181		buffer->vaddr = (void *)gen_pool_alloc(buffer->pool, buffer->len);
   182		if (!buffer->vaddr) {
   183			ret = -ENOMEM;
   184			goto free_buffer;
   185		}
   186	
   187		buffer->paddr = gen_pool_virt_to_phys(buffer->pool, (unsigned long)buffer->vaddr);
   188		if (buffer->paddr == -1) {
   189			ret = -ENOMEM;
   190			goto free_pool;
   191		}
   192	
   193		/* create the dmabuf */
   194		exp_info.exp_name = dma_heap_get_name(heap);
   195		exp_info.ops = &sram_dma_heap_buf_ops;
   196		exp_info.size = buffer->len;
   197		exp_info.flags = fd_flags;
   198		exp_info.priv = buffer;
   199		dmabuf = dma_buf_export(&exp_info);
   200		if (IS_ERR(dmabuf)) {
   201			ret = PTR_ERR(dmabuf);
   202			goto free_pool;
   203		}
   204	
   205		return dmabuf;
   206	
   207	free_pool:
   208		gen_pool_free(buffer->pool, (unsigned long)buffer->vaddr, buffer->len);
   209	free_buffer:
   210		kfree(buffer);
   211	
   212		return ERR_PTR(ret);
   213	}
   214	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
