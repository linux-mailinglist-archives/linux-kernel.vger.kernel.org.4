Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 535D36BE7B2
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 12:09:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230045AbjCQLJU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 07:09:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230011AbjCQLJO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 07:09:14 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32D653E09B
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 04:09:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679051352; x=1710587352;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=v10ok78XmnbTvrOG0ZyBDbG2rIV540KEKIp/CoL6i84=;
  b=MjL/iBR1mMQGxfI/Ef3BT9KpjhRCjImqL1r9BCGMjgWldL9ZNO5EztCv
   4COgOgmzeYzLeVO5Fx8LnSuosq4byeI0zz1ta/BufJmRnPIWI3hha8NyJ
   Nze6i2NwkaqjwQf2a687VTOsjtkrLgedTkmXbJo/Q5YsCh15XN5jLyAzy
   zj3rYYEj1czR1n9Bwra7UspwkOwJM0huQl9YreGwVlr3pToaLqtWnNY9b
   q8pytD5akpvsdJWS57bZ3UPqGTyJs2w66KRziqpz/DIsLNUi8WgVnKk6y
   C5i8kYOEgWA6F03Yl4WaforVyltQNdyYZhk1gS75SIosDXEjXx6BtwDN6
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10651"; a="424508723"
X-IronPort-AV: E=Sophos;i="5.98,268,1673942400"; 
   d="scan'208";a="424508723"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2023 04:09:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10651"; a="926107442"
X-IronPort-AV: E=Sophos;i="5.98,268,1673942400"; 
   d="scan'208";a="926107442"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 17 Mar 2023 04:09:05 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pd7xJ-0009JS-14;
        Fri, 17 Mar 2023 11:09:05 +0000
Date:   Fri, 17 Mar 2023 19:08:31 +0800
From:   kernel test robot <lkp@intel.com>
To:     Evan Green <evan@rivosinc.com>,
        Palmer Dabbelt <palmer@rivosinc.com>
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        slewis@rivosinc.com, heiko@sntech.de,
        Conor Dooley <conor@kernel.org>, vineetg@rivosinc.com,
        Evan Green <evan@rivosinc.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Andrew Bresticker <abrestic@rivosinc.com>,
        Atish Patra <atishp@rivosinc.com>,
        Celeste Liu <coelacanthus@outlook.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Guo Ren <guoren@kernel.org>, Jann Horn <jannh@google.com>,
        Jisheng Zhang <jszhang@kernel.org>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: Re: [PATCH v4 6/6] RISC-V: Add hwprobe vDSO function and data
Message-ID: <202303171804.y0iCB2XM-lkp@intel.com>
References: <20230314183220.513101-7-evan@rivosinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230314183220.513101-7-evan@rivosinc.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED,WEIRD_PORT autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Evan,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on v6.2]
[cannot apply to shuah-kselftest/next shuah-kselftest/fixes linus/master v6.3-rc2 v6.3-rc1 next-20230317]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Evan-Green/RISC-V-Move-struct-riscv_cpuinfo-to-new-header/20230315-023754
patch link:    https://lore.kernel.org/r/20230314183220.513101-7-evan%40rivosinc.com
patch subject: [PATCH v4 6/6] RISC-V: Add hwprobe vDSO function and data
config: riscv-randconfig-r033-20230312 (https://download.01.org/0day-ci/archive/20230317/202303171804.y0iCB2XM-lkp@intel.com/config)
compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project 67409911353323ca5edf2049ef0df54132fa1ca7)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install riscv cross compiling tool for clang build
        # apt-get install binutils-riscv-linux-gnu
        # https://github.com/intel-lab-lkp/linux/commit/8ded35c1c6a29c13d7509e1e845fe6bb27a4c109
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Evan-Green/RISC-V-Move-struct-riscv_cpuinfo-to-new-header/20230315-023754
        git checkout 8ded35c1c6a29c13d7509e1e845fe6bb27a4c109
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=riscv olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=riscv prepare

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202303171804.y0iCB2XM-lkp@intel.com/

All errors (new ones prefixed by >>):

>> ld.lld: error: relocation R_RISCV_HI20 cannot be used against symbol '_vdso_data'; recompile with -fPIC
   >>> defined in arch/riscv/kernel/vdso/vdso.lds:101
   >>> referenced by hwprobe.c:35 (arch/riscv/kernel/vdso/hwprobe.c:35)
   >>>               arch/riscv/kernel/vdso/hwprobe.o:(__vdso_riscv_hwprobe)
--
>> ld.lld: error: relocation R_RISCV_LO12_I cannot be used against symbol '_vdso_data'; recompile with -fPIC
   >>> defined in arch/riscv/kernel/vdso/vdso.lds:101
   >>> referenced by hwprobe.c:0 (arch/riscv/kernel/vdso/hwprobe.c:0)
   >>>               arch/riscv/kernel/vdso/hwprobe.o:(__vdso_riscv_hwprobe)
--
>> ld.lld: error: relocation R_RISCV_HI20 cannot be used against symbol '_vdso_data'; recompile with -fPIC
   >>> defined in arch/riscv/kernel/vdso/vdso.lds:101
   >>> referenced by hwprobe.c:0 (arch/riscv/kernel/vdso/hwprobe.c:0)
   >>>               arch/riscv/kernel/vdso/hwprobe.o:(__vdso_riscv_hwprobe)
--
>> ld.lld: error: relocation R_RISCV_LO12_I cannot be used against symbol '_vdso_data'; recompile with -fPIC
   >>> defined in arch/riscv/kernel/vdso/vdso.lds:101
   >>> referenced by hwprobe.c:0 (arch/riscv/kernel/vdso/hwprobe.c:0)
   >>>               arch/riscv/kernel/vdso/hwprobe.o:(__vdso_riscv_hwprobe)

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
