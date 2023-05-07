Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F38586F968D
	for <lists+linux-kernel@lfdr.de>; Sun,  7 May 2023 04:12:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230144AbjEGCMc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 May 2023 22:12:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229653AbjEGCMa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 May 2023 22:12:30 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFF3C1A1C4
        for <linux-kernel@vger.kernel.org>; Sat,  6 May 2023 19:12:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683425548; x=1714961548;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=CdIcUerw2pUzaKk3ebkC8nNz3yp/UlzXSe1GZh9P4lE=;
  b=S1lpR2KEc6v8U7jva4uK/wrwsnTQSB2AIKx42sjltT2oLAxdjygZcEpP
   CGlEL4v4GnsJK8QQ+KFiB1ikxWwe9Fesj0MtX0MCFH1t7BoiqSEAfVC7B
   8hR2G7gQuLznBR+vKScJpKz5y1myDWfYo11uDrlFnVq6uR4Kv38jE7D9H
   SHWP4N3zObuT3TK3XBIZSKsrBL/D1qGyF4w8ZHgVtT3x1E2md5StSjBYy
   mf6F4djANqWcB6VFdk2sxIKT+eIM7ap0i3QrF+CVugwFYKg2qhE1iF4NX
   B5HWjBDhROqZhn9sPG9rNubf9OVSD1WWR9V+RtoF+dgV8oO/cObhFVbi+
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10702"; a="338656372"
X-IronPort-AV: E=Sophos;i="5.99,256,1677571200"; 
   d="scan'208";a="338656372"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2023 19:12:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10702"; a="648425361"
X-IronPort-AV: E=Sophos;i="5.99,256,1677571200"; 
   d="scan'208";a="648425361"
Received: from lkp-server01.sh.intel.com (HELO dea6d5a4f140) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 06 May 2023 19:12:26 -0700
Received: from kbuild by dea6d5a4f140 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pvTsv-0000ZN-1r;
        Sun, 07 May 2023 02:12:25 +0000
Date:   Sun, 7 May 2023 10:11:31 +0800
From:   kernel test robot <lkp@intel.com>
To:     Yimin Gu <ustcymgu@gmail.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Palmer Dabbelt <palmer@rivosinc.com>,
        Jesse Taube <Mr.Bossman075@gmail.com>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Conor Dooley <conor.dooley@microchip.com>
Subject: kernel/events/core.c:7429 perf_virt_to_phys() warn: always true
 condition '(virt >= 0) => (0-u64max >= 0)'
Message-ID: <202305071045.e0D7M8pZ-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yimin,

FYI, the error/warning was bisected to this commit, please ignore it if it's irrelevant.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   fc4354c6e5c21257cf4a50b32f7c11c7d65c55b3
commit: b5e2c507b06c9d36411845149162a804ae7b04a9 riscv: Kconfig: Allow RV32 to build with no MMU
date:   6 weeks ago
config: riscv-randconfig-m041-20230507 (https://download.01.org/0day-ci/archive/20230507/202305071045.e0D7M8pZ-lkp@intel.com/config)
compiler: riscv32-linux-gcc (GCC) 12.1.0

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202305071045.e0D7M8pZ-lkp@intel.com/

New smatch warnings:
kernel/events/core.c:7429 perf_virt_to_phys() warn: always true condition '(virt >= 0) => (0-u64max >= 0)'

Old smatch warnings:
arch/riscv/include/asm/atomic.h:204 arch_atomic_fetch_add_unless() warn: inconsistent indenting

vim +7429 kernel/events/core.c

5622f295b53fb6 kernel/perf_counter.c Markus Metzger   2009-09-15  7418  
fc7ce9c74c3ad2 kernel/events/core.c  Kan Liang        2017-08-28  7419  static u64 perf_virt_to_phys(u64 virt)
fc7ce9c74c3ad2 kernel/events/core.c  Kan Liang        2017-08-28  7420  {
fc7ce9c74c3ad2 kernel/events/core.c  Kan Liang        2017-08-28  7421  	u64 phys_addr = 0;
fc7ce9c74c3ad2 kernel/events/core.c  Kan Liang        2017-08-28  7422  
fc7ce9c74c3ad2 kernel/events/core.c  Kan Liang        2017-08-28  7423  	if (!virt)
fc7ce9c74c3ad2 kernel/events/core.c  Kan Liang        2017-08-28  7424  		return 0;
fc7ce9c74c3ad2 kernel/events/core.c  Kan Liang        2017-08-28  7425  
fc7ce9c74c3ad2 kernel/events/core.c  Kan Liang        2017-08-28  7426  	if (virt >= TASK_SIZE) {
fc7ce9c74c3ad2 kernel/events/core.c  Kan Liang        2017-08-28  7427  		/* If it's vmalloc()d memory, leave phys_addr as 0 */
fc7ce9c74c3ad2 kernel/events/core.c  Kan Liang        2017-08-28  7428  		if (virt_addr_valid((void *)(uintptr_t)virt) &&
fc7ce9c74c3ad2 kernel/events/core.c  Kan Liang        2017-08-28 @7429  		    !(virt >= VMALLOC_START && virt < VMALLOC_END))
fc7ce9c74c3ad2 kernel/events/core.c  Kan Liang        2017-08-28  7430  			phys_addr = (u64)virt_to_phys((void *)(uintptr_t)virt);
fc7ce9c74c3ad2 kernel/events/core.c  Kan Liang        2017-08-28  7431  	} else {
fc7ce9c74c3ad2 kernel/events/core.c  Kan Liang        2017-08-28  7432  		/*
fc7ce9c74c3ad2 kernel/events/core.c  Kan Liang        2017-08-28  7433  		 * Walking the pages tables for user address.
fc7ce9c74c3ad2 kernel/events/core.c  Kan Liang        2017-08-28  7434  		 * Interrupts are disabled, so it prevents any tear down
fc7ce9c74c3ad2 kernel/events/core.c  Kan Liang        2017-08-28  7435  		 * of the page tables.
dadbb612f6e50b kernel/events/core.c  Souptick Joarder 2020-06-07  7436  		 * Try IRQ-safe get_user_page_fast_only first.
fc7ce9c74c3ad2 kernel/events/core.c  Kan Liang        2017-08-28  7437  		 * If failed, leave phys_addr as 0.
fc7ce9c74c3ad2 kernel/events/core.c  Kan Liang        2017-08-28  7438  		 */
d3296fb372bf74 kernel/events/core.c  Jiri Olsa        2020-04-07  7439  		if (current->mm != NULL) {
4716023a8f6a0f kernel/events/core.c  Greg Thelen      2021-11-10  7440  			struct page *p;
4716023a8f6a0f kernel/events/core.c  Greg Thelen      2021-11-10  7441  
d3296fb372bf74 kernel/events/core.c  Jiri Olsa        2020-04-07  7442  			pagefault_disable();
4716023a8f6a0f kernel/events/core.c  Greg Thelen      2021-11-10  7443  			if (get_user_page_fast_only(virt, 0, &p)) {
fc7ce9c74c3ad2 kernel/events/core.c  Kan Liang        2017-08-28  7444  				phys_addr = page_to_phys(p) + virt % PAGE_SIZE;
4716023a8f6a0f kernel/events/core.c  Greg Thelen      2021-11-10  7445  				put_page(p);
4716023a8f6a0f kernel/events/core.c  Greg Thelen      2021-11-10  7446  			}
d3296fb372bf74 kernel/events/core.c  Jiri Olsa        2020-04-07  7447  			pagefault_enable();
d3296fb372bf74 kernel/events/core.c  Jiri Olsa        2020-04-07  7448  		}
fc7ce9c74c3ad2 kernel/events/core.c  Kan Liang        2017-08-28  7449  	}
fc7ce9c74c3ad2 kernel/events/core.c  Kan Liang        2017-08-28  7450  
fc7ce9c74c3ad2 kernel/events/core.c  Kan Liang        2017-08-28  7451  	return phys_addr;
fc7ce9c74c3ad2 kernel/events/core.c  Kan Liang        2017-08-28  7452  }
fc7ce9c74c3ad2 kernel/events/core.c  Kan Liang        2017-08-28  7453  

:::::: The code at line 7429 was first introduced by commit
:::::: fc7ce9c74c3ad232b084d80148654f926d01ece7 perf/core, x86: Add PERF_SAMPLE_PHYS_ADDR

:::::: TO: Kan Liang <kan.liang@intel.com>
:::::: CC: Ingo Molnar <mingo@kernel.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
