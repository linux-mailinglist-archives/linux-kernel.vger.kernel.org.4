Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4985686D1E
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 18:34:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231482AbjBAReF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 12:34:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231335AbjBARd4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 12:33:56 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17B0C7D6FC
        for <linux-kernel@vger.kernel.org>; Wed,  1 Feb 2023 09:33:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675272812; x=1706808812;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=1lwTGWBj0+y9xsU+27/cINJlAnAQZb4KD0qasn/kJlM=;
  b=YdLqN+gY2/f7i6ivPfVANRpWndmsrflfhv7lM3g27XxrkI6GP3ugfO/R
   peR00a5nruL1aUPXIB0t6zQiuigwoKzkF3m02oyZFq2iTpqT/xtkRc+sh
   wGT7FHeAn0yI+dXYfQnWkFnQ4TkTk9cwpyPkNSA+ZNP4Zso7IfyapWOs4
   NNY5dgFNOtk0KJzK/zCSFFXV5VzXGo1W1lLoCS4mqo5H65AAIt6fcdk2i
   UdEk5RvD1rGGU1MIUyIo4M0BqavSpTh9id/N3RMGqcn8YF1q1y5gUkotJ
   0xsRfw6PEn8+DukQCJG8aCkdu7GceDyN9AfxpxON88HCN4WhOR7yPsyhC
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10608"; a="316211314"
X-IronPort-AV: E=Sophos;i="5.97,263,1669104000"; 
   d="scan'208";a="316211314"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2023 09:32:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10608"; a="697336396"
X-IronPort-AV: E=Sophos;i="5.97,263,1669104000"; 
   d="scan'208";a="697336396"
Received: from lkp-server01.sh.intel.com (HELO ffa7f14d1d0f) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 01 Feb 2023 09:32:38 -0800
Received: from kbuild by ffa7f14d1d0f with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pNGyM-0005d9-08;
        Wed, 01 Feb 2023 17:32:38 +0000
Date:   Thu, 2 Feb 2023 01:31:42 +0800
From:   kernel test robot <lkp@intel.com>
To:     Logan Gunthorpe <logang@deltatee.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Chaitanya Kulkarni <kch@nvidia.com>
Subject: drivers/pci/p2pdma.c:199:44: sparse: sparse: dereference of noderef
 expression
Message-ID: <202302020153.4eL3mwiK-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   c0b67534c95c537f7a506a06b98e5e85d72e2b7d
commit: 7e9c7ef83d785236f5a8c3761dd053fae9b92fb8 PCI/P2PDMA: Allow userspace VMA allocations through sysfs
date:   3 months ago
config: arm64-randconfig-s042-20230201 (https://download.01.org/0day-ci/archive/20230202/202302020153.4eL3mwiK-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 12.1.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-39-gce1a6720-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=7e9c7ef83d785236f5a8c3761dd053fae9b92fb8
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 7e9c7ef83d785236f5a8c3761dd053fae9b92fb8
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=arm64 olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=arm64 SHELL=/bin/bash drivers/pci/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>

sparse warnings: (new ones prefixed by >>)
>> drivers/pci/p2pdma.c:199:44: sparse: sparse: dereference of noderef expression

vim +199 drivers/pci/p2pdma.c

   193	
   194	static void p2pdma_page_free(struct page *page)
   195	{
   196		struct pci_p2pdma_pagemap *pgmap = to_p2p_pgmap(page->pgmap);
   197		struct percpu_ref *ref;
   198	
 > 199		gen_pool_free_owner(pgmap->provider->p2pdma->pool,
   200				    (uintptr_t)page_to_virt(page), PAGE_SIZE,
   201				    (void **)&ref);
   202		percpu_ref_put(ref);
   203	}
   204	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
