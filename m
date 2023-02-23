Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83A3B6A10FD
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 21:04:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229688AbjBWUEl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 15:04:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjBWUEk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 15:04:40 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8727158B1;
        Thu, 23 Feb 2023 12:04:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677182679; x=1708718679;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=bMM8jrE3GaTMJ5jxYncWrywv+nAQI6dAHrUKTQF4Qzg=;
  b=mFP//MjPxzKA9B3xb6NT+3US68x3dOC/RTDTJtU6kWq6CzXicoGI91BU
   JI4SjVSPaU2p2bgNnoa8LDf8ocr70LBU40lrlP97gsFyfiKO54dV76ca7
   aCNv/3aX96F3XZzzFdoDzs3ohqrdTai5TnmDVZ66CAqXCs9HXwlkwEfCi
   ouZPVlKXPRUAolCMmaBbydPT5bunTTLA8i76qRV/UN4rwuuM/vLtEU2mm
   EcBfO9H7UfMJjX/OdjvgRy3bTL0jR7vjmopuHF2jMWVDkoOrtOwYeABhn
   ZcfrDkr6/joUhNVXMcflj04XeqwtTAeu0XOuOl5BrpsRoEto2FJ+st4w7
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10630"; a="312947304"
X-IronPort-AV: E=Sophos;i="5.97,322,1669104000"; 
   d="scan'208";a="312947304"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2023 12:04:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10630"; a="702921729"
X-IronPort-AV: E=Sophos;i="5.97,322,1669104000"; 
   d="scan'208";a="702921729"
Received: from lkp-server01.sh.intel.com (HELO 3895f5c55ead) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 23 Feb 2023 12:04:17 -0800
Received: from kbuild by 3895f5c55ead with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pVHpB-0001hR-0R;
        Thu, 23 Feb 2023 20:04:17 +0000
Date:   Fri, 24 Feb 2023 04:03:33 +0800
From:   kernel test robot <lkp@intel.com>
To:     Alexandre Ghiti <alexghiti@rivosinc.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Conor Dooley <conor@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        =?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@kernel.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org
Cc:     oe-kbuild-all@lists.linux.dev,
        Alexandre Ghiti <alexghiti@rivosinc.com>
Subject: Re: [PATCH v6 1/1] riscv: Allow to downgrade paging mode from the
 command line
Message-ID: <202302240308.1CC475U8-lkp@intel.com>
References: <20230223082434.1280957-2-alexghiti@rivosinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230223082434.1280957-2-alexghiti@rivosinc.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alexandre,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on linus/master]
[also build test ERROR on v6.2 next-20230223]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Alexandre-Ghiti/riscv-Allow-to-downgrade-paging-mode-from-the-command-line/20230223-162702
patch link:    https://lore.kernel.org/r/20230223082434.1280957-2-alexghiti%40rivosinc.com
patch subject: [PATCH v6 1/1] riscv: Allow to downgrade paging mode from the command line
config: riscv-rv32_defconfig (https://download.01.org/0day-ci/archive/20230224/202302240308.1CC475U8-lkp@intel.com/config)
compiler: riscv32-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/7e18f795579f897e63812ca9dcb5b48ef2b7b4d2
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Alexandre-Ghiti/riscv-Allow-to-downgrade-paging-mode-from-the-command-line/20230223-162702
        git checkout 7e18f795579f897e63812ca9dcb5b48ef2b7b4d2
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=riscv olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=riscv SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202302240308.1CC475U8-lkp@intel.com/

All errors (new ones prefixed by >>):

   arch/riscv/kernel/pi/cmdline_early.c: In function 'match_noXlvl':
>> arch/riscv/kernel/pi/cmdline_early.c:50:24: error: 'SATP_MODE_48' undeclared (first use in this function); did you mean 'SATP_MODE_32'?
      50 |                 return SATP_MODE_48;
         |                        ^~~~~~~~~~~~
         |                        SATP_MODE_32
   arch/riscv/kernel/pi/cmdline_early.c:50:24: note: each undeclared identifier is reported only once for each function it appears in
>> arch/riscv/kernel/pi/cmdline_early.c:52:24: error: 'SATP_MODE_57' undeclared (first use in this function); did you mean 'SATP_MODE_32'?
      52 |                 return SATP_MODE_57;
         |                        ^~~~~~~~~~~~
         |                        SATP_MODE_32


vim +50 arch/riscv/kernel/pi/cmdline_early.c

    46	
    47	static u64 __init match_noXlvl(char *cmdline)
    48	{
    49		if (strstr(cmdline, "no4lvl"))
  > 50			return SATP_MODE_48;
    51		else if (strstr(cmdline, "no5lvl"))
  > 52			return SATP_MODE_57;
    53	
    54		return 0;
    55	}
    56	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
