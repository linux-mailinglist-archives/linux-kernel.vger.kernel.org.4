Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6AE76D3410
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Apr 2023 23:22:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230090AbjDAVWv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Apr 2023 17:22:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229584AbjDAVWs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Apr 2023 17:22:48 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C09B976C
        for <linux-kernel@vger.kernel.org>; Sat,  1 Apr 2023 14:22:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680384167; x=1711920167;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=fhwNesxe6ke8KocxC20SOUuPRnmmVMa1sYZs1M2LhAs=;
  b=cJZ3Q2iVyC5slJncWKU2IytlUGlRF+0wOeQFW0xLnw3GAXcnSlDSQpYt
   UwTtJVMqpbr5RMECd3GijvobrXTqjpPUkq4TbOdoc5+1kJthb39W1Ma4V
   CYmXaAr8W7ljqUCuoNE3cOIZzsoq+WcxW281HW72QwITGIa+YvSKGMdnm
   ggDL9faf48z9x0qOa0sM8sZebuui+HhwP15zvyZz5Tvftj4CLZfBIcfUg
   rvMPvuYoR08LQaICXkca3tg1DqBjRHy1OdTqklNeT8YHbTgfGE0nAN1/P
   mduyZjj3PIheO9GhGSnsgRRm+8k9P6mCCK9QTbMpPpoTwP4/fKN22QTVX
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10667"; a="406726433"
X-IronPort-AV: E=Sophos;i="5.98,311,1673942400"; 
   d="scan'208";a="406726433"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2023 14:22:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10667"; a="809415495"
X-IronPort-AV: E=Sophos;i="5.98,311,1673942400"; 
   d="scan'208";a="809415495"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 01 Apr 2023 14:22:40 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1piigJ-000N3J-11;
        Sat, 01 Apr 2023 21:22:39 +0000
Date:   Sun, 2 Apr 2023 05:22:16 +0800
From:   kernel test robot <lkp@intel.com>
To:     Evan Green <evan@rivosinc.com>,
        Palmer Dabbelt <palmer@rivosinc.com>
Cc:     oe-kbuild-all@lists.linux.dev, slewis@rivosinc.com,
        vineetg@rivosinc.com, heiko@sntech.de,
        Conor Dooley <conor@kernel.org>,
        Evan Green <evan@rivosinc.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Andrew Bresticker <abrestic@rivosinc.com>,
        Andrew Jones <ajones@ventanamicro.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Celeste Liu <coelacanthus@outlook.com>,
        Guo Ren <guoren@kernel.org>,
        Heiko Stuebner <heiko.stuebner@vrull.eu>,
        Jann Horn <jannh@google.com>,
        Jisheng Zhang <jszhang@kernel.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Peter Xu <peterx@redhat.com>, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org
Subject: Re: [PATCH v5 6/6] RISC-V: Add hwprobe vDSO function and data
Message-ID: <202304020554.WGmuSRal-lkp@intel.com>
References: <20230327163203.2918455-7-evan@rivosinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230327163203.2918455-7-evan@rivosinc.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Evan,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on shuah-kselftest/next]
[also build test ERROR on shuah-kselftest/fixes linus/master v6.3-rc4 next-20230331]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Evan-Green/RISC-V-Move-struct-riscv_cpuinfo-to-new-header/20230328-003521
base:   https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest.git next
patch link:    https://lore.kernel.org/r/20230327163203.2918455-7-evan%40rivosinc.com
patch subject: [PATCH v5 6/6] RISC-V: Add hwprobe vDSO function and data
config: riscv-nommu_k210_sdcard_defconfig (https://download.01.org/0day-ci/archive/20230402/202304020554.WGmuSRal-lkp@intel.com/config)
compiler: riscv64-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/36489c1f81535a512da07d7d0272dd607bb217ca
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Evan-Green/RISC-V-Move-struct-riscv_cpuinfo-to-new-header/20230328-003521
        git checkout 36489c1f81535a512da07d7d0272dd607bb217ca
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=riscv olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=riscv SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202304020554.WGmuSRal-lkp@intel.com/

All errors (new ones prefixed by >>):

   riscv64-linux-ld: arch/riscv/kernel/sys_riscv.o: in function `.L0 ':
>> sys_riscv.c:(.init.text+0x4): undefined reference to `vdso_data'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
