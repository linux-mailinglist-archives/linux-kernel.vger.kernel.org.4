Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 662FE68AC4B
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Feb 2023 21:44:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232778AbjBDUoC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Feb 2023 15:44:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229560AbjBDUoA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Feb 2023 15:44:00 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E35A212A8
        for <linux-kernel@vger.kernel.org>; Sat,  4 Feb 2023 12:43:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675543439; x=1707079439;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=IR+38awXRWxdcpHN+7aQRcTcrCcg3s4/G2wGNCzeLis=;
  b=kxv/8wxrqULAfFb0lRymSMEA5jMyTcjk03a8nhr5BlJ0BBuh1XMUSdRu
   wkwp4PqL9HndKVic6n3HxU/CcDa3ro1q7jGTHke1idavijQxddN+EF3T5
   a57FjfGQPAh2jHa24nSmjZLfv8z2Ca64tsgaNto1JLWlYzUUQ9QZzX4JN
   xjJNt043psZBCy2n9YLDSZJvKPzlc75usF7wmBEVTQh+YtTFc8DALT5kP
   CcjPsxookmjia2SYDKl2A16bp+5AjsWgw8wKYaWypX9mw1yvv+PSH6gGl
   Gb1bTEjINV3TZGZRX5g/tqPkEYodjFR1qWyu1C+zt2UQVa9utLZlvr4wM
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10611"; a="327617103"
X-IronPort-AV: E=Sophos;i="5.97,272,1669104000"; 
   d="scan'208";a="327617103"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2023 12:43:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10611"; a="729621552"
X-IronPort-AV: E=Sophos;i="5.97,272,1669104000"; 
   d="scan'208";a="729621552"
Received: from lkp-server01.sh.intel.com (HELO 4455601a8d94) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 04 Feb 2023 12:43:56 -0800
Received: from kbuild by 4455601a8d94 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pOPO7-0001WS-1q;
        Sat, 04 Feb 2023 20:43:55 +0000
Date:   Sun, 5 Feb 2023 04:42:58 +0800
From:   kernel test robot <lkp@intel.com>
To:     Sia Jee Heng <jeeheng.sia@starfivetech.com>,
        paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu
Cc:     oe-kbuild-all@lists.linux.dev, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, jeeheng.sia@starfivetech.com,
        leyfoon.tan@starfivetech.com, mason.huo@starfivetech.com
Subject: Re: [PATCH v3 4/4] RISC-V: Add arch functions to support
 hibernation/suspend-to-disk
Message-ID: <202302050450.VM99IQpW-lkp@intel.com>
References: <20230127091051.1465278-5-jeeheng.sia@starfivetech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230127091051.1465278-5-jeeheng.sia@starfivetech.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sia,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on 7c46948a6e9cf47ed03b0d489fde894ad46f1437]

url:    https://github.com/intel-lab-lkp/linux/commits/Sia-Jee-Heng/RISC-V-Change-suspend_save_csrs-and-suspend_restore_csrs-to-public-function/20230128-114249
base:   7c46948a6e9cf47ed03b0d489fde894ad46f1437
patch link:    https://lore.kernel.org/r/20230127091051.1465278-5-jeeheng.sia%40starfivetech.com
patch subject: [PATCH v3 4/4] RISC-V: Add arch functions to support hibernation/suspend-to-disk
config: riscv-randconfig-r001-20230205 (https://download.01.org/0day-ci/archive/20230205/202302050450.VM99IQpW-lkp@intel.com/config)
compiler: riscv64-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/642c1b119b3d33fe0ee22ff6823085cb847cfe79
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Sia-Jee-Heng/RISC-V-Change-suspend_save_csrs-and-suspend_restore_csrs-to-public-function/20230128-114249
        git checkout 642c1b119b3d33fe0ee22ff6823085cb847cfe79
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=riscv olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=riscv SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   riscv64-linux-ld: arch/riscv/kernel/hibernate.o: in function `arch_hibernation_header_restore':
>> arch/riscv/kernel/hibernate.c:133: undefined reference to `__cpu_suspend_enter'
>> riscv64-linux-ld: arch/riscv/kernel/hibernate.c:137: undefined reference to `suspend_save_csrs'
>> riscv64-linux-ld: arch/riscv/kernel/hibernate.c:137: undefined reference to `suspend_restore_csrs'
   pahole: .tmp_vmlinux.btf: No such file or directory
   .btf.vmlinux.bin.o: file not recognized: file format not recognized


vim +133 arch/riscv/kernel/hibernate.c

   106	
   107	/*
   108	 * Retrieve the helper parameters from the hibernation image header
   109	 */
   110	int arch_hibernation_header_restore(void *addr)
   111	{
   112		struct arch_hibernate_hdr_invariants invariants;
   113		struct arch_hibernate_hdr *hdr = addr;
   114		int ret = 0;
   115	
   116		arch_hdr_invariants(&invariants);
   117	
   118		if (memcmp(&hdr->invariants, &invariants, sizeof(invariants))) {
   119			pr_crit("Hibernate image not generated by this kernel!\n");
   120			return -EINVAL;
   121		}
   122	
   123		sleep_cpu = riscv_hartid_to_cpuid(hdr->hartid);
   124		if (sleep_cpu < 0) {
   125			pr_crit("Hibernated on a CPU not known to this kernel!\n");
   126			sleep_cpu = -EINVAL;
   127			return -EINVAL;
   128		}
   129	
   130	#ifdef CONFIG_SMP
   131		ret = bringup_hibernate_cpu(sleep_cpu);
   132		if (ret) {
 > 133			sleep_cpu = -EINVAL;
   134			return ret;
   135		}
   136	#endif
 > 137		resume_hdr = *hdr;
   138	
   139		return ret;
   140	}
   141	EXPORT_SYMBOL(arch_hibernation_header_restore);
   142	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
