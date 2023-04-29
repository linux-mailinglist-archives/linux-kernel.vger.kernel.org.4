Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B95466F2271
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Apr 2023 04:39:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347153AbjD2Ci6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Apr 2023 22:38:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346837AbjD2Ci4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Apr 2023 22:38:56 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 788042701;
        Fri, 28 Apr 2023 19:38:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682735935; x=1714271935;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=raEleY/CIN8OLflT7QsvmQGNlj3pjj/mEyGW4jOjITc=;
  b=GbLhKYN5E0Pcd1PcMaRDaoHb4ybAAlmojbyyetjOVSXH6bQmE7ungHLW
   0Y+Q+dU/FH4cJZNaAVP+6yvFalx04mBiQU9wl1/VlBCXpZNoDGdc17MaD
   vaaNfpimYvMQqzM8W1weRf1eFEPyrLQwxD19GDNJCR/dLn2x3ffDi2r2T
   QkW5mwOufhMeMqVvQ7CPNKmM+uPd/nmgdWBfr7z/CqbObFXu0aLrISQlq
   tdtCkG7s1+b75fBR+B/GbM3xIyzDK+lQp/nRmmYpEW74dRuEjUGJoJDla
   519pw22TaXmKCSQEtBBKU8qkXo20auZTxqt+y+pJvPiY9fPCy2nLDGEMI
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10694"; a="345353388"
X-IronPort-AV: E=Sophos;i="5.99,236,1677571200"; 
   d="scan'208";a="345353388"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2023 19:38:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10694"; a="806639170"
X-IronPort-AV: E=Sophos;i="5.99,236,1677571200"; 
   d="scan'208";a="806639170"
Received: from lkp-server01.sh.intel.com (HELO 5bad9d2b7fcb) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 28 Apr 2023 19:38:51 -0700
Received: from kbuild by 5bad9d2b7fcb with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1psaU6-0000qH-3C;
        Sat, 29 Apr 2023 02:38:50 +0000
Date:   Sat, 29 Apr 2023 10:37:58 +0800
From:   kernel test robot <lkp@intel.com>
To:     Casey Schaufler <casey@schaufler-ca.com>, paul@paul-moore.com,
        linux-security-module@vger.kernel.org
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        jmorris@namei.org, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, mic@digikod.net
Subject: Re: [PATCH v10 07/11] LSM: Helpers for attribute names and filling
 lsm_ctx
Message-ID: <202304291044.WjF3wC86-lkp@intel.com>
References: <20230428203417.159874-8-casey@schaufler-ca.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230428203417.159874-8-casey@schaufler-ca.com>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Casey,

kernel test robot noticed the following build errors:

[auto build test ERROR on tip/perf/core]
[also build test ERROR on acme/perf/core shuah-kselftest/next shuah-kselftest/fixes v6.3]
[cannot apply to linus/master next-20230428]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Casey-Schaufler/LSM-Maintain-a-table-of-LSM-attribute-data/20230429-053458
base:   tip/perf/core
patch link:    https://lore.kernel.org/r/20230428203417.159874-8-casey%40schaufler-ca.com
patch subject: [PATCH v10 07/11] LSM: Helpers for attribute names and filling lsm_ctx
config: riscv-randconfig-r003-20230428 (https://download.01.org/0day-ci/archive/20230429/202304291044.WjF3wC86-lkp@intel.com/config)
compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project 437b7602e4a998220871de78afcb020b9c14a661)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install riscv cross compiling tool for clang build
        # apt-get install binutils-riscv64-linux-gnu
        # https://github.com/intel-lab-lkp/linux/commit/9830f4776196e33bee604b8ce3339177f8fd37f8
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Casey-Schaufler/LSM-Maintain-a-table-of-LSM-attribute-data/20230429-053458
        git checkout 9830f4776196e33bee604b8ce3339177f8fd37f8
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=riscv olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=riscv prepare

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202304291044.WjF3wC86-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from arch/riscv/kernel/asm-offsets.c:12:
   In file included from arch/riscv/include/asm/kvm_host.h:21:
   In file included from arch/riscv/include/asm/kvm_vcpu_pmu.h:12:
   In file included from include/linux/perf/riscv_pmu.h:12:
   In file included from include/linux/perf_event.h:62:
>> include/linux/security.h:516:9: error: use of undeclared identifier 'LSM_ATTR_UNDEF'
           return LSM_ATTR_UNDEF;
                  ^
   1 error generated.
   make[2]: *** [scripts/Makefile.build:114: arch/riscv/kernel/asm-offsets.s] Error 1
   make[2]: Target 'prepare' not remade because of errors.
   make[1]: *** [Makefile:1286: prepare0] Error 2
   make[1]: Target 'prepare' not remade because of errors.
   make: *** [Makefile:226: __sub-make] Error 2
   make: Target 'prepare' not remade because of errors.


vim +/LSM_ATTR_UNDEF +516 include/linux/security.h

   513	
   514	static inline u64 lsm_name_to_attr(const char *name)
   515	{
 > 516		return LSM_ATTR_UNDEF;
   517	}
   518	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
