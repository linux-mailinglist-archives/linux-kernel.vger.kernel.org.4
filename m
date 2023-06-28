Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 139FC741408
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 16:46:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231638AbjF1Opy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 10:45:54 -0400
Received: from mga17.intel.com ([192.55.52.151]:30340 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231264AbjF1Opr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 10:45:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687963547; x=1719499547;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=0TW8rORFbvHsvw57ZLLsdr8StY03qMWB1yRd8wqTDj4=;
  b=brW51ZFVE1iNLbAbH6+S+5Xbr0377AozjYBD9hAa0dGCtSoUVumGs8e3
   JTYmitkqMqMA69OgYJxrGoFbhEv16oEIdDQ10o7lxv+5GWS+Om/I1w1Nn
   uqTv7f1gb6c3Zao+Z0cWt3iKnvkUJoUtrMQuYqLv+K3S7ZemgsdoZrMTV
   gi6hJQZIoIg8uleVgaPpifck/X5PyJ3CCNQuR6wpFzKl1fqRtt2DAETbE
   rbUbv01CA6tY/CAUecLAGjY0qzeuFUr/vtA5721l4I8sceP7qe77NJ+or
   akHheeaXD9Ml/9Bb7LYU/mZc13XtxM5zdTEw8QanEYvArvR0j7aqhlbnM
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10755"; a="342200186"
X-IronPort-AV: E=Sophos;i="6.01,165,1684825200"; 
   d="scan'208";a="342200186"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2023 07:45:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10755"; a="806941940"
X-IronPort-AV: E=Sophos;i="6.01,165,1684825200"; 
   d="scan'208";a="806941940"
Received: from lkp-server01.sh.intel.com (HELO 783282924a45) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 28 Jun 2023 07:45:45 -0700
Received: from kbuild by 783282924a45 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qEWQS-000DJN-0I;
        Wed, 28 Jun 2023 14:45:44 +0000
Date:   Wed, 28 Jun 2023 22:45:41 +0800
From:   kernel test robot <lkp@intel.com>
To:     Alexandre Ghiti <alexghiti@rivosinc.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Palmer Dabbelt <palmer@rivosinc.com>,
        =?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@rivosinc.com>
Subject: arch/riscv/mm/kasan_init.c:28:7: sparse: sparse: symbol 'tmp_pud'
 was not declared. Should it be static?
Message-ID: <202306282202.bODptiGE-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   6aeadf7896bff4ca230702daba8788455e6b866e
commit: 96f9d4daf745205fe869e9e5ac23199ef11c5448 riscv: Rework kasan population functions
date:   2 months ago
config: riscv-randconfig-r083-20230628 (https://download.01.org/0day-ci/archive/20230628/202306282202.bODptiGE-lkp@intel.com/config)
compiler: riscv64-linux-gcc (GCC) 12.3.0
reproduce: (https://download.01.org/0day-ci/archive/20230628/202306282202.bODptiGE-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202306282202.bODptiGE-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
   WARNING: invalid argument to '-march': '_zicbom_zihintpause'
   arch/riscv/mm/kasan_init.c:27:7: sparse: sparse: symbol 'tmp_p4d' was not declared. Should it be static?
>> arch/riscv/mm/kasan_init.c:28:7: sparse: sparse: symbol 'tmp_pud' was not declared. Should it be static?

vim +/tmp_pud +28 arch/riscv/mm/kasan_init.c

    13	
    14	/*
    15	 * Kasan shadow region must lie at a fixed address across sv39, sv48 and sv57
    16	 * which is right before the kernel.
    17	 *
    18	 * For sv39, the region is aligned on PGDIR_SIZE so we only need to populate
    19	 * the page global directory with kasan_early_shadow_pmd.
    20	 *
    21	 * For sv48 and sv57, the region start is aligned on PGDIR_SIZE whereas the end
    22	 * region is not and then we have to go down to the PUD level.
    23	 */
    24	
    25	extern pgd_t early_pg_dir[PTRS_PER_PGD];
    26	pgd_t tmp_pg_dir[PTRS_PER_PGD] __page_aligned_bss;
    27	p4d_t tmp_p4d[PTRS_PER_P4D] __page_aligned_bss;
  > 28	pud_t tmp_pud[PTRS_PER_PUD] __page_aligned_bss;
    29	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
