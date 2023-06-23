Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C2AA73B914
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 15:49:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232080AbjFWNs6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 09:48:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231767AbjFWNsa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 09:48:30 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A06812D53
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 06:48:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687528092; x=1719064092;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=p9NgACVaiSspactyT3RJcYZ9XddCzihsMDcpJG30mCs=;
  b=MnUx7kXgOfgBnyXUHguVWplIWYlToJWFNvUyEK/Pq3nCJL3AvqLCF4Ny
   zU0BdFHzZAfqUEi3oZQR+iL94SM24ZBKxCR8IYIFrswgksqAs85sXXXBv
   tJ6bKHWJ1allM5gr8yIasNoiWvj3+3K6Ioy0klJ8Y0xGS09B6cq1NYwAX
   ptdJMi/cvg48u0hyFG+vBWoASyQznhmNwdKqx5oPrTZjKkGivTcitZri7
   dLOgk8s7joDoBKRrqyN1PpOGm3e+XTpTAUyaTJYmL9aSMTQyOFtw7UIr6
   xLoz2KEue8EYmEqG19hS7hlcXTJSsW2wKMCg+PuphgG2j4brXrRBTGqGp
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10750"; a="364212121"
X-IronPort-AV: E=Sophos;i="6.01,152,1684825200"; 
   d="scan'208";a="364212121"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2023 06:48:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10750"; a="805209567"
X-IronPort-AV: E=Sophos;i="6.01,152,1684825200"; 
   d="scan'208";a="805209567"
Received: from lkp-server01.sh.intel.com (HELO 783282924a45) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 23 Jun 2023 06:48:09 -0700
Received: from kbuild by 783282924a45 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qCh8y-0008IZ-1j;
        Fri, 23 Jun 2023 13:48:08 +0000
Date:   Fri, 23 Jun 2023 21:47:12 +0800
From:   kernel test robot <lkp@intel.com>
To:     Heiko Stuebner <heiko@sntech.de>, palmer@dabbelt.com,
        paul.walmsley@sifive.com
Cc:     oe-kbuild-all@lists.linux.dev, linux-riscv@lists.infradead.org,
        samuel@sholland.org, guoren@kernel.org,
        christoph.muellner@vrull.eu, heiko@sntech.de,
        conor.dooley@microchip.com, linux-kernel@vger.kernel.org,
        Heiko Stuebner <heiko.stuebner@vrull.eu>
Subject: Re: [PATCH v2 2/3] RISC-V: move vector-available status into a
 dedicated variable
Message-ID: <202306232112.kwDtMcou-lkp@intel.com>
References: <20230622231305.631331-3-heiko@sntech.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230622231305.631331-3-heiko@sntech.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Heiko,

kernel test robot noticed the following build errors:

[auto build test ERROR on next-20230622]
[cannot apply to linus/master v6.4-rc7 v6.4-rc6 v6.4-rc5 v6.4-rc7]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Heiko-Stuebner/RISC-V-move-vector-available-status-into-a-dedicated-variable/20230623-081314
base:   next-20230622
patch link:    https://lore.kernel.org/r/20230622231305.631331-3-heiko%40sntech.de
patch subject: [PATCH v2 2/3] RISC-V: move vector-available status into a dedicated variable
config: riscv-allnoconfig (https://download.01.org/0day-ci/archive/20230623/202306232112.kwDtMcou-lkp@intel.com/config)
compiler: riscv64-linux-gcc (GCC) 12.3.0
reproduce: (https://download.01.org/0day-ci/archive/20230623/202306232112.kwDtMcou-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202306232112.kwDtMcou-lkp@intel.com/

All errors (new ones prefixed by >>):

   arch/riscv/kernel/setup.c: In function 'setup_arch':
>> arch/riscv/kernel/setup.c:315:17: error: implicit declaration of function 'riscv_vector_supported'; did you mean 'riscv_noncoherent_supported'? [-Werror=implicit-function-declaration]
     315 |                 riscv_vector_supported();
         |                 ^~~~~~~~~~~~~~~~~~~~~~
         |                 riscv_noncoherent_supported
   cc1: some warnings being treated as errors


vim +315 arch/riscv/kernel/setup.c

   304	
   305		if (!acpi_disabled)
   306			acpi_init_rintc_map();
   307	
   308		riscv_init_cbo_blocksizes();
   309		riscv_fill_hwcap();
   310		init_rt_signal_env();
   311		apply_boot_alternatives();
   312	
   313		if (IS_ENABLED(CONFIG_RISCV_ISA_V) &&
   314		    riscv_isa_extension_available(NULL, v))
 > 315			riscv_vector_supported();
   316	
   317		if (IS_ENABLED(CONFIG_RISCV_ISA_ZICBOM) &&
   318		    riscv_isa_extension_available(NULL, ZICBOM))
   319			riscv_noncoherent_supported();
   320	}
   321	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
