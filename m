Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8566069E959
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 22:18:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229647AbjBUVSB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 16:18:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229708AbjBUVRv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 16:17:51 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2238C83
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 13:17:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677014268; x=1708550268;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=2Z8HpLXCWddG+Jt9ywudS/nE++JVzN3twAynOXAq0E0=;
  b=XUTstL8ZguDO6bomCiOH9kBnD1nXIvGoRBo8Y5tvT9SU3T81zKWMDDnZ
   5bPbI5hTCyufP5jE+QSCTbHnJsGZYWSdwNySF12wCKj5gOWhUXaJ/6veq
   jybCCxQzpZ8/uV5KFeras50lGZdQpQUcqNTH6CdTsQSKZMSU8Z0tMwEyB
   GLeONUEufI+wbsUjq0a91cxJU2SEr0l39t+iSMMUBaBYOVIWzSOXKFcLc
   UhHVWgMyLt52DHKrAx3ZT0DJsMbXZDpbYVbolyp6PdNXFHfhXCMIaa1fh
   ob8qEUDadfN6+MeLzzI4eazgu+trIcJbVxYkme1hfEpDskNWAshSYsjIj
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10628"; a="331423417"
X-IronPort-AV: E=Sophos;i="5.97,315,1669104000"; 
   d="scan'208";a="331423417"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2023 13:17:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10628"; a="1000749794"
X-IronPort-AV: E=Sophos;i="5.97,315,1669104000"; 
   d="scan'208";a="1000749794"
Received: from lkp-server01.sh.intel.com (HELO eac18b5d7d93) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 21 Feb 2023 13:17:42 -0800
Received: from kbuild by eac18b5d7d93 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pUa17-0000FP-1J;
        Tue, 21 Feb 2023 21:17:41 +0000
Date:   Wed, 22 Feb 2023 05:17:23 +0800
From:   kernel test robot <lkp@intel.com>
To:     Evan Green <evan@rivosinc.com>,
        Palmer Dabbelt <palmer@rivosinc.com>
Cc:     oe-kbuild-all@lists.linux.dev, heiko@sntech.de,
        Conor Dooley <conor@kernel.org>, slewis@rivosinc.com,
        vineetg@rivosinc.com, Evan Green <evan@rivosinc.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Andrew Bresticker <abrestic@rivosinc.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Celeste Liu <coelacanthus@outlook.com>,
        Guo Ren <guoren@kernel.org>,
        Jisheng Zhang <jszhang@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: Re: [PATCH v3 7/7] RISC-V: Add hwprobe vDSO function and data
Message-ID: <202302220534.zLN2kaHH-lkp@intel.com>
References: <20230221190858.3159617-8-evan@rivosinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230221190858.3159617-8-evan@rivosinc.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Evan,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on shuah-kselftest/next]
[also build test WARNING on shuah-kselftest/fixes robh/for-next soc/for-next linus/master v6.2]
[cannot apply to next-20230221]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Evan-Green/RISC-V-Move-struct-riscv_cpuinfo-to-new-header/20230222-031210
base:   https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest.git next
patch link:    https://lore.kernel.org/r/20230221190858.3159617-8-evan%40rivosinc.com
patch subject: [PATCH v3 7/7] RISC-V: Add hwprobe vDSO function and data
config: riscv-allyesconfig (https://download.01.org/0day-ci/archive/20230222/202302220534.zLN2kaHH-lkp@intel.com/config)
compiler: riscv64-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/3f47f3f920ffcb37a461d04a1ee0e245451c869e
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Evan-Green/RISC-V-Move-struct-riscv_cpuinfo-to-new-header/20230222-031210
        git checkout 3f47f3f920ffcb37a461d04a1ee0e245451c869e
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=riscv olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=riscv prepare

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202302220534.zLN2kaHH-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> arch/riscv/kernel/vdso/hwprobe.c:14:5: warning: no previous prototype for '__vdso_riscv_hwprobe' [-Wmissing-prototypes]
      14 | int __vdso_riscv_hwprobe(struct riscv_hwprobe *pairs, long pair_count,
         |     ^~~~~~~~~~~~~~~~~~~~
--
   scripts/genksyms/parse.y: warning: 9 shift/reduce conflicts [-Wconflicts-sr]
   scripts/genksyms/parse.y: warning: 5 reduce/reduce conflicts [-Wconflicts-rr]
   scripts/genksyms/parse.y: note: rerun with option '-Wcounterexamples' to generate conflict counterexamples
>> arch/riscv/kernel/vdso/hwprobe.c:14:5: warning: no previous prototype for '__vdso_riscv_hwprobe' [-Wmissing-prototypes]
      14 | int __vdso_riscv_hwprobe(struct riscv_hwprobe *pairs, long pair_count,
         |     ^~~~~~~~~~~~~~~~~~~~


vim +/__vdso_riscv_hwprobe +14 arch/riscv/kernel/vdso/hwprobe.c

     9	
    10	extern int riscv_hwprobe(struct riscv_hwprobe *pairs, long pair_count,
    11				 long cpu_count, unsigned long *cpus,
    12				 unsigned long flags);
    13	
  > 14	int __vdso_riscv_hwprobe(struct riscv_hwprobe *pairs, long pair_count,

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
