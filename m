Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 042E35E5FD2
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 12:24:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231502AbiIVKYe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 06:24:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231465AbiIVKY0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 06:24:26 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A093DB941
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 03:24:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663842265; x=1695378265;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=wvn8y1NXWe3mNIRC9c0nB3nJ7aWEu4HVClH+v0vuDMQ=;
  b=aC+rRG/plhUL0g+YJVZXV2HXo8X/vBbqRiUez+AAliKUYc6OI1WAUu/8
   nT6ZNlrdP37sdfj+2fO8ha7Y2DfKhIrt0SwZy9WDA+j7V+Gy69JoitArg
   9GbJ5Sgk5oZ2vlUIC96QFdC4KxcPAg4zVKB7+Z96nBQ/kZZV7wZ7on2VD
   Y7RyTpWkA/Wu8JTDNdS+ha0g9lgQ4mgaanuO2DKvcJS2pL1d+c9Rm6+0d
   q2DqhrLYz28r+vCCMF5o6vLtlrySbsr12JAotSs1ZDZrJKRITKin4BSMp
   sV3vTwhE6aDFpaq0Jy3qSQn2xCfAsh1V0+W2dFWf9lteI3rspdwrLxDA+
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10477"; a="283311868"
X-IronPort-AV: E=Sophos;i="5.93,335,1654585200"; 
   d="scan'208";a="283311868"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2022 03:24:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,335,1654585200"; 
   d="scan'208";a="795032418"
Received: from lkp-server01.sh.intel.com (HELO c0a60f19fe7e) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 22 Sep 2022 03:24:20 -0700
Received: from kbuild by c0a60f19fe7e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1obJNT-0004b8-2H;
        Thu, 22 Sep 2022 10:24:19 +0000
Date:   Thu, 22 Sep 2022 18:23:53 +0800
From:   kernel test robot <lkp@intel.com>
To:     Binglei Wang <l3b2w1@gmail.com>, paul.walmsley@sifive.com,
        palmer@dabbelt.com, aou@eecs.berkeley.edu,
        naveen.n.rao@linux.ibm.com, anil.s.keshavamurthy@intel.com,
        davem@davemloft.net, hiramat@kernel.org
Cc:     kbuild-all@lists.01.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, Binglei Wang <l3b2w1@gmail.com>
Subject: Re: [PATCH] rethook: add riscv rethook implementation.
Message-ID: <202209221828.DpzmggxE-lkp@intel.com>
References: <20220922040443.605175-1-l3b2w1@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220922040443.605175-1-l3b2w1@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Binglei,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on rostedt-trace/for-next]
[also build test ERROR on linus/master v6.0-rc6 next-20220921]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Binglei-Wang/rethook-add-riscv-rethook-implementation/20220922-120748
base:   https://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git for-next
config: s390-allmodconfig (https://download.01.org/0day-ci/archive/20220922/202209221828.DpzmggxE-lkp@intel.com/config)
compiler: s390-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/3f86f610d114317cd7f7a7a1c9116fa0b916667a
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Binglei-Wang/rethook-add-riscv-rethook-implementation/20220922-120748
        git checkout 3f86f610d114317cd7f7a7a1c9116fa0b916667a
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=s390 SHELL=/bin/bash arch/s390/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from arch/s390/kernel/kprobes.c:13:
   include/linux/kprobes.h: In function 'arch_prepare_kretprobe':
   include/linux/kprobes.h:225:47: error: 'struct pt_regs' has no member named 'ra'
     225 |         ri->ret_addr = (kprobe_opcode_t *)regs->ra;
         |                                               ^~
   include/linux/kprobes.h:227:13: error: 'struct pt_regs' has no member named 'ra'
     227 |         regs->ra = (unsigned long) &__kretprobe_trampoline;
         |             ^~
   arch/s390/kernel/kprobes.c: At top level:
>> arch/s390/kernel/kprobes.c:285:6: error: redefinition of 'arch_prepare_kretprobe'
     285 | void arch_prepare_kretprobe(struct kretprobe_instance *ri, struct pt_regs *regs)
         |      ^~~~~~~~~~~~~~~~~~~~~~
   include/linux/kprobes.h:222:29: note: previous definition of 'arch_prepare_kretprobe' with type 'void(struct kretprobe_instance *, struct pt_regs *)'
     222 | static nokprobe_inline void arch_prepare_kretprobe(struct kretprobe_instance *ri,
         |                             ^~~~~~~~~~~~~~~~~~~~~~


vim +/arch_prepare_kretprobe +285 arch/s390/kernel/kprobes.c

4ba069b802c29e Michael Grundy   2006-09-20  284  
7a5388de5c70f7 Heiko Carstens   2014-10-22 @285  void arch_prepare_kretprobe(struct kretprobe_instance *ri, struct pt_regs *regs)
4ba069b802c29e Michael Grundy   2006-09-20  286  {
4ba069b802c29e Michael Grundy   2006-09-20  287  	ri->ret_addr = (kprobe_opcode_t *)regs->gprs[14];
09bc20c8fb35cf Vasily Gorbik    2022-03-05  288  	ri->fp = (void *)regs->gprs[15];
4ba069b802c29e Michael Grundy   2006-09-20  289  
4ba069b802c29e Michael Grundy   2006-09-20  290  	/* Replace the return addr with trampoline addr */
adf8a61a940c49 Masami Hiramatsu 2021-09-14  291  	regs->gprs[14] = (unsigned long)&__kretprobe_trampoline;
4ba069b802c29e Michael Grundy   2006-09-20  292  }
7a5388de5c70f7 Heiko Carstens   2014-10-22  293  NOKPROBE_SYMBOL(arch_prepare_kretprobe);
4ba069b802c29e Michael Grundy   2006-09-20  294  

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
