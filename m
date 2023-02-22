Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FF1A69F835
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 16:38:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232649AbjBVPia (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 10:38:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232524AbjBVPi3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 10:38:29 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AA7838B6F;
        Wed, 22 Feb 2023 07:38:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677080287; x=1708616287;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=lfkLtf5jtkBjJDFFtW5k1yPQC79CTUCrDVb1xySLDeQ=;
  b=lvatEBJ884pOsCUXpoiBctYitlL2gU/OkH4PLULej5d4rHPCOtu6XHhk
   jvfnLWkwjDMnYxwjoYWWDxnc1eniyCH3R7SSB1oLKgQkVwN/zVP/XjUXf
   0s/JH37uio9Z9Z7BoKMDxcDvbG92S4fCC2HRhrU7tzGeWYsf1wAavwPW9
   P7eoTsNkrjL6Eoy45pINvxYIMUaljPwbOS6LuwOS6B6rmzd7FaLbLK9c5
   0YGejCs6QQqdnxoKI+mkPEe3+0CBGJ2miKoAKvpxCUb+HIF3JcyP43Na/
   Nw1mKx7AdQiWEBgbOBzuGOIWs1xISsm98M9mwzfMR+4z+wmJMDt/53Deo
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10629"; a="313328775"
X-IronPort-AV: E=Sophos;i="5.97,319,1669104000"; 
   d="scan'208";a="313328775"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2023 07:37:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10629"; a="814976044"
X-IronPort-AV: E=Sophos;i="5.97,319,1669104000"; 
   d="scan'208";a="814976044"
Received: from lkp-server01.sh.intel.com (HELO 3895f5c55ead) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 22 Feb 2023 07:37:21 -0800
Received: from kbuild by 3895f5c55ead with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pUrBI-0000VL-16;
        Wed, 22 Feb 2023 15:37:20 +0000
Date:   Wed, 22 Feb 2023 23:37:01 +0800
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
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        Alexandre Ghiti <alexghiti@rivosinc.com>
Subject: Re: [PATCH v5 1/1] riscv: Allow to downgrade paging mode from the
 command line
Message-ID: <202302222359.LdNxjl1c-lkp@intel.com>
References: <20230222104322.1197763-2-alexghiti@rivosinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230222104322.1197763-2-alexghiti@rivosinc.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alexandre,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on linus/master]
[also build test WARNING on v6.2]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Alexandre-Ghiti/riscv-Allow-to-downgrade-paging-mode-from-the-command-line/20230222-184549
patch link:    https://lore.kernel.org/r/20230222104322.1197763-2-alexghiti%40rivosinc.com
patch subject: [PATCH v5 1/1] riscv: Allow to downgrade paging mode from the command line
config: riscv-randconfig-r042-20230222 (https://download.01.org/0day-ci/archive/20230222/202302222359.LdNxjl1c-lkp@intel.com/config)
compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project db89896bbbd2251fff457699635acbbedeead27f)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install riscv cross compiling tool for clang build
        # apt-get install binutils-riscv64-linux-gnu
        # https://github.com/intel-lab-lkp/linux/commit/f92dd2e351d9f51f678f2d7ac63cc3cf85effddd
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Alexandre-Ghiti/riscv-Allow-to-downgrade-paging-mode-from-the-command-line/20230222-184549
        git checkout f92dd2e351d9f51f678f2d7ac63cc3cf85effddd
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=riscv olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=riscv SHELL=/bin/bash arch/riscv/kernel/pi/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202302222359.LdNxjl1c-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> arch/riscv/kernel/pi/cmdline_early.c:50:12: warning: no previous prototype for function 'set_satp_mode_from_cmdline' [-Wmissing-prototypes]
   u64 __init set_satp_mode_from_cmdline(uintptr_t dtb_pa)
              ^
   arch/riscv/kernel/pi/cmdline_early.c:50:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   u64 __init set_satp_mode_from_cmdline(uintptr_t dtb_pa)
   ^
   static 
   1 warning generated.


vim +/set_satp_mode_from_cmdline +50 arch/riscv/kernel/pi/cmdline_early.c

    49	
  > 50	u64 __init set_satp_mode_from_cmdline(uintptr_t dtb_pa)

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
