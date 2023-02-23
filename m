Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A55256A0845
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 13:11:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233630AbjBWMLl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 07:11:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233897AbjBWMLc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 07:11:32 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F25455C07;
        Thu, 23 Feb 2023 04:11:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677154269; x=1708690269;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=c3/6mmV17tShYWq3QB6unXyeKS83+JV/EnZRZDWCD5A=;
  b=A90uAVGi60IStygHGKiUmSzotz5zMWLqAKrGOy9roMOUNI3s5vSe5BCa
   id3VxJ9UewNVw2mQ35UniKOPTzOS+ler9ZAyhqy9YkBOQiZ23ztQXAYKZ
   7qnx6bb1vXkxxjaUm2Dy3iDa/weF4ZHEooWVQ0E8VtiXcF47vsm6I+YY7
   1Hb6uU4wTHBFAFt/xJhsP4wPoCIYxUzfImftr9ZX7g7X+t4jl2OqcHeMY
   k4wSV1Ml+/6TQholvncfYSyDFnDi5NJIBOMF1B3xAR5zfIo+NuE8I2/+z
   any3mWTtM1RUXMrhzwp/bY2ZB2ocDlAIBV1wNoz9whyGzO/+BePDypnYZ
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10629"; a="330921138"
X-IronPort-AV: E=Sophos;i="5.97,320,1669104000"; 
   d="scan'208";a="330921138"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2023 04:10:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10629"; a="781858049"
X-IronPort-AV: E=Sophos;i="5.97,320,1669104000"; 
   d="scan'208";a="781858049"
Received: from lkp-server01.sh.intel.com (HELO 3895f5c55ead) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 23 Feb 2023 04:09:59 -0800
Received: from kbuild by 3895f5c55ead with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pVAQA-0001JW-1a;
        Thu, 23 Feb 2023 12:09:58 +0000
Date:   Thu, 23 Feb 2023 20:09:07 +0800
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
Subject: Re: [PATCH v6 1/1] riscv: Allow to downgrade paging mode from the
 command line
Message-ID: <202302231942.6C2mSFYv-lkp@intel.com>
References: <20230223082434.1280957-2-alexghiti@rivosinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230223082434.1280957-2-alexghiti@rivosinc.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alexandre,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on linus/master]
[also build test ERROR on v6.2]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Alexandre-Ghiti/riscv-Allow-to-downgrade-paging-mode-from-the-command-line/20230223-162702
patch link:    https://lore.kernel.org/r/20230223082434.1280957-2-alexghiti%40rivosinc.com
patch subject: [PATCH v6 1/1] riscv: Allow to downgrade paging mode from the command line
config: riscv-buildonly-randconfig-r002-20230222 (https://download.01.org/0day-ci/archive/20230223/202302231942.6C2mSFYv-lkp@intel.com/config)
compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project db89896bbbd2251fff457699635acbbedeead27f)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install riscv cross compiling tool for clang build
        # apt-get install binutils-riscv-linux-gnu
        # https://github.com/intel-lab-lkp/linux/commit/7e18f795579f897e63812ca9dcb5b48ef2b7b4d2
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Alexandre-Ghiti/riscv-Allow-to-downgrade-paging-mode-from-the-command-line/20230223-162702
        git checkout 7e18f795579f897e63812ca9dcb5b48ef2b7b4d2
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=riscv olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=riscv SHELL=/bin/bash arch/riscv/kernel/pi/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202302231942.6C2mSFYv-lkp@intel.com/

All errors (new ones prefixed by >>):

>> arch/riscv/kernel/pi/cmdline_early.c:50:10: error: use of undeclared identifier 'SATP_MODE_48'
                   return SATP_MODE_48;
                          ^
>> arch/riscv/kernel/pi/cmdline_early.c:52:10: error: use of undeclared identifier 'SATP_MODE_57'
                   return SATP_MODE_57;
                          ^
   2 errors generated.


vim +/SATP_MODE_48 +50 arch/riscv/kernel/pi/cmdline_early.c

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
