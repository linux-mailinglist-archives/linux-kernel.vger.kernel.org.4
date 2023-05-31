Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8448B717275
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 02:33:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233839AbjEaAdB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 20:33:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233855AbjEaAcz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 20:32:55 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27700100
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 17:32:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685493174; x=1717029174;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=5xEeiekejREC8LvTn5bR/XyYrA71WsI2XilvH/Jg91Y=;
  b=VXE6QqbVZK3K66bz4VaNJs0cNk+bj2wmuOQmoFo8RcAPCR6RLLxSSZP+
   9esGs9HoGzsLkcjeLymWN95MnCNQQm0qbMHCVDCo8xNPfoTuWi2eo3lIg
   gClK71AMHmb5G52m78fkWK/jgzjfxSMyGkOoM0G4hP+pmM5Ijk3wlmSF5
   njv4SQUEEEunsAHjyzcK7jj8WtgP42lZo28nukYvngTc8s2jJoDjZk27m
   Ki69ezW93/hhXTHOoI8XYaXqbD4UuiCQin07nVHv/E4TCLhXSinfKO97T
   k4dYelvAskPYUpMZj5cp8aITwBHtqyOQUVj0I6DeSA/x344dP2jht9qEz
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10726"; a="441445152"
X-IronPort-AV: E=Sophos;i="6.00,205,1681196400"; 
   d="scan'208";a="441445152"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 May 2023 17:32:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10726"; a="1036803686"
X-IronPort-AV: E=Sophos;i="6.00,205,1681196400"; 
   d="scan'208";a="1036803686"
Received: from lkp-server01.sh.intel.com (HELO fb1ced2c09fb) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 30 May 2023 17:32:50 -0700
Received: from kbuild by fb1ced2c09fb with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1q49li-0000vz-0c;
        Wed, 31 May 2023 00:32:50 +0000
Date:   Wed, 31 May 2023 08:32:26 +0800
From:   kernel test robot <lkp@intel.com>
To:     =?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org
Cc:     oe-kbuild-all@lists.linux.dev,
        =?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@rivosinc.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux@rivosinc.com, Alexandre Ghiti <alexghiti@rivosinc.com>,
        Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH] riscv: mm: Pre-allocate PGD entries vmalloc/modules area
Message-ID: <202305310822.dhnyydJC-lkp@intel.com>
References: <20230529180023.289904-1-bjorn@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230529180023.289904-1-bjorn@kernel.org>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Björn,

kernel test robot noticed the following build warnings:

[auto build test WARNING on ac9a78681b921877518763ba0e89202254349d1b]

url:    https://github.com/intel-lab-lkp/linux/commits/Bj-rn-T-pel/riscv-mm-Pre-allocate-PGD-entries-vmalloc-modules-area/20230530-020212
base:   ac9a78681b921877518763ba0e89202254349d1b
patch link:    https://lore.kernel.org/r/20230529180023.289904-1-bjorn%40kernel.org
patch subject: [PATCH] riscv: mm: Pre-allocate PGD entries vmalloc/modules area
config: riscv-randconfig-r042-20230530 (https://download.01.org/0day-ci/archive/20230531/202305310822.dhnyydJC-lkp@intel.com/config)
compiler: riscv64-linux-gcc (GCC) 12.3.0
reproduce (this is a W=1 build):
        mkdir -p ~/bin
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/9383adbcdfb7f850149742579615e8c174328a78
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Bj-rn-T-pel/riscv-mm-Pre-allocate-PGD-entries-vmalloc-modules-area/20230530-020212
        git checkout 9383adbcdfb7f850149742579615e8c174328a78
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.3.0 ~/bin/make.cross W=1 O=build_dir ARCH=riscv olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.3.0 ~/bin/make.cross W=1 O=build_dir ARCH=riscv SHELL=/bin/bash arch/riscv/mm/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202305310822.dhnyydJC-lkp@intel.com/

All warnings (new ones prefixed by >>):

   arch/riscv/mm/init.c: In function 'preallocate_pgd_pages_range':
   arch/riscv/mm/init.c:1381:30: error: implicit declaration of function 'pgd_offset_k'; did you mean 'p4d_offset'? [-Werror=implicit-function-declaration]
    1381 |                 pgd_t *pgd = pgd_offset_k(addr);
         |                              ^~~~~~~~~~~~
         |                              p4d_offset
>> arch/riscv/mm/init.c:1381:30: warning: initialization of 'pgd_t *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
   arch/riscv/mm/init.c:1387:23: error: implicit declaration of function 'p4d_alloc'; did you mean 'd_alloc'? [-Werror=implicit-function-declaration]
    1387 |                 p4d = p4d_alloc(&init_mm, pgd, addr);
         |                       ^~~~~~~~~
         |                       d_alloc
>> arch/riscv/mm/init.c:1387:21: warning: assignment to 'p4d_t *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
    1387 |                 p4d = p4d_alloc(&init_mm, pgd, addr);
         |                     ^
   arch/riscv/mm/init.c:1395:23: error: implicit declaration of function 'pud_alloc'; did you mean 'd_alloc'? [-Werror=implicit-function-declaration]
    1395 |                 pud = pud_alloc(&init_mm, p4d, addr);
         |                       ^~~~~~~~~
         |                       d_alloc
>> arch/riscv/mm/init.c:1395:21: warning: assignment to 'pud_t *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
    1395 |                 pud = pud_alloc(&init_mm, p4d, addr);
         |                     ^
   arch/riscv/mm/init.c:1403:23: error: implicit declaration of function 'pmd_alloc'; did you mean 'mm_alloc'? [-Werror=implicit-function-declaration]
    1403 |                 pmd = pmd_alloc(&init_mm, pud, addr);
         |                       ^~~~~~~~~
         |                       mm_alloc
>> arch/riscv/mm/init.c:1403:21: warning: assignment to 'pmd_t *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
    1403 |                 pmd = pmd_alloc(&init_mm, pud, addr);
         |                     ^
   arch/riscv/mm/init.c: In function 'pgtable_cache_init':
   arch/riscv/mm/init.c:1421:45: error: 'MODULES_VADDR' undeclared (first use in this function)
    1421 |                 preallocate_pgd_pages_range(MODULES_VADDR, MODULES_END, "bpf/modules");
         |                                             ^~~~~~~~~~~~~
   arch/riscv/mm/init.c:1421:45: note: each undeclared identifier is reported only once for each function it appears in
   arch/riscv/mm/init.c:1421:60: error: 'MODULES_END' undeclared (first use in this function)
    1421 |                 preallocate_pgd_pages_range(MODULES_VADDR, MODULES_END, "bpf/modules");
         |                                                            ^~~~~~~~~~~
   cc1: some warnings being treated as errors


vim +1381 arch/riscv/mm/init.c

  1366	
  1367	#ifdef CONFIG_64BIT
  1368	/*
  1369	 * Pre-allocates page-table pages for a specific area in the kernel
  1370	 * page-table. Only the level which needs to be synchronized between
  1371	 * all page-tables is allocated because the synchronization can be
  1372	 * expensive.
  1373	 */
  1374	static void __init preallocate_pgd_pages_range(unsigned long start, unsigned long end,
  1375						       const char *area)
  1376	{
  1377		unsigned long addr;
  1378		const char *lvl;
  1379	
  1380		for (addr = start; addr < end && addr >= start; addr = ALIGN(addr + 1, PGDIR_SIZE)) {
> 1381			pgd_t *pgd = pgd_offset_k(addr);
  1382			p4d_t *p4d;
  1383			pud_t *pud;
  1384			pmd_t *pmd;
  1385	
  1386			lvl = "p4d";
> 1387			p4d = p4d_alloc(&init_mm, pgd, addr);
  1388			if (!p4d)
  1389				goto failed;
  1390	
  1391			if (pgtable_l5_enabled)
  1392				continue;
  1393	
  1394			lvl = "pud";
> 1395			pud = pud_alloc(&init_mm, p4d, addr);
  1396			if (!pud)
  1397				goto failed;
  1398	
  1399			if (pgtable_l4_enabled)
  1400				continue;
  1401	
  1402			lvl = "pmd";
> 1403			pmd = pmd_alloc(&init_mm, pud, addr);
  1404			if (!pmd)
  1405				goto failed;
  1406		}
  1407		return;
  1408	
  1409	failed:
  1410		/*
  1411		 * The pages have to be there now or they will be missing in
  1412		 * process page-tables later.
  1413		 */
  1414		panic("Failed to pre-allocate %s pages for %s area\n", lvl, area);
  1415	}
  1416	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
