Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 547375E5DAC
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 10:41:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230301AbiIVIlU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 04:41:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229603AbiIVIlS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 04:41:18 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3FCCCDCD7
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 01:41:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663836077; x=1695372077;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=XQUe670CShxlWUDBqu1z+myoybYpLDIoh+28QXjCsow=;
  b=GaFRPgClEHaWx12EiNUqBVla+crH26D6WAwMMOYbfNsW4RQN+PlPf74E
   zqngTvVXf45CM+IX32yggx5H+wkPrzum/sao24tnwitLti5H/NGELACBp
   ofy/+872utR64rcWm+1dNNwtaL8yBhxrO7F+HVxVLI6ytofMSY8uJzi5j
   Ps6C5bnCbb21kI47wRlBe6F1xBmS95amXoTjrmdaOnQe2UdnbdMSBGiUG
   dbsU3k+rgKjV4nfnfFBu6ayaKis2VwyD+8Nw0lUroRnCf67rOiVozPCn2
   971dk7FVyFja4stMKmAAY+rIlhAkwfFPwhkLmc2CxOsq4Ei78VM0ZvF6r
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10477"; a="362006875"
X-IronPort-AV: E=Sophos;i="5.93,335,1654585200"; 
   d="scan'208";a="362006875"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2022 01:41:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,335,1654585200"; 
   d="scan'208";a="652883646"
Received: from lkp-server01.sh.intel.com (HELO c0a60f19fe7e) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 22 Sep 2022 01:41:14 -0700
Received: from kbuild by c0a60f19fe7e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1obHlh-0004VQ-17;
        Thu, 22 Sep 2022 08:41:13 +0000
Date:   Thu, 22 Sep 2022 16:40:33 +0800
From:   kernel test robot <lkp@intel.com>
To:     Binglei Wang <l3b2w1@gmail.com>, paul.walmsley@sifive.com,
        palmer@dabbelt.com, aou@eecs.berkeley.edu,
        naveen.n.rao@linux.ibm.com, anil.s.keshavamurthy@intel.com,
        davem@davemloft.net, hiramat@kernel.org
Cc:     kbuild-all@lists.01.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, Binglei Wang <l3b2w1@gmail.com>
Subject: Re: [PATCH] rethook: add riscv rethook implementation.
Message-ID: <202209221624.rWsWQbRt-lkp@intel.com>
References: <20220922040443.605175-1-l3b2w1@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220922040443.605175-1-l3b2w1@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
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
config: arc-defconfig (https://download.01.org/0day-ci/archive/20220922/202209221624.rWsWQbRt-lkp@intel.com/config)
compiler: arc-elf-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/3f86f610d114317cd7f7a7a1c9116fa0b916667a
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Binglei-Wang/rethook-add-riscv-rethook-implementation/20220922-120748
        git checkout 3f86f610d114317cd7f7a7a1c9116fa0b916667a
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=arc SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from arch/arc/kernel/kprobes.c:7:
   include/linux/kprobes.h: In function 'arch_prepare_kretprobe':
   include/linux/kprobes.h:225:49: error: 'struct pt_regs' has no member named 'ra'; did you mean 'r0'?
     225 |         ri->ret_addr = (kprobe_opcode_t *)regs->ra;
         |                                                 ^~
         |                                                 r0
   include/linux/kprobes.h:227:15: error: 'struct pt_regs' has no member named 'ra'; did you mean 'r0'?
     227 |         regs->ra = (unsigned long) &__kretprobe_trampoline;
         |               ^~
         |               r0
   arch/arc/kernel/kprobes.c: At top level:
   arch/arc/kernel/kprobes.c:193:15: warning: no previous prototype for 'arc_kprobe_handler' [-Wmissing-prototypes]
     193 | int __kprobes arc_kprobe_handler(unsigned long addr, struct pt_regs *regs)
         |               ^~~~~~~~~~~~~~~~~~
>> arch/arc/kernel/kprobes.c:371:16: error: redefinition of 'arch_prepare_kretprobe'
     371 | void __kprobes arch_prepare_kretprobe(struct kretprobe_instance *ri,
         |                ^~~~~~~~~~~~~~~~~~~~~~
   include/linux/kprobes.h:222:29: note: previous definition of 'arch_prepare_kretprobe' with type 'void(struct kretprobe_instance *, struct pt_regs *)'
     222 | static nokprobe_inline void arch_prepare_kretprobe(struct kretprobe_instance *ri,
         |                             ^~~~~~~~~~~~~~~~~~~~~~


vim +/arch_prepare_kretprobe +371 arch/arc/kernel/kprobes.c

4d86dfbbda09b3 Vineet Gupta     2013-01-22  370  
4d86dfbbda09b3 Vineet Gupta     2013-01-22 @371  void __kprobes arch_prepare_kretprobe(struct kretprobe_instance *ri,
4d86dfbbda09b3 Vineet Gupta     2013-01-22  372  				      struct pt_regs *regs)
4d86dfbbda09b3 Vineet Gupta     2013-01-22  373  {
4d86dfbbda09b3 Vineet Gupta     2013-01-22  374  
4d86dfbbda09b3 Vineet Gupta     2013-01-22  375  	ri->ret_addr = (kprobe_opcode_t *) regs->blink;
f75dd136b65ccc Masami Hiramatsu 2020-08-29  376  	ri->fp = NULL;
4d86dfbbda09b3 Vineet Gupta     2013-01-22  377  
4d86dfbbda09b3 Vineet Gupta     2013-01-22  378  	/* Replace the return addr with trampoline addr */
adf8a61a940c49 Masami Hiramatsu 2021-09-14  379  	regs->blink = (unsigned long)&__kretprobe_trampoline;
4d86dfbbda09b3 Vineet Gupta     2013-01-22  380  }
4d86dfbbda09b3 Vineet Gupta     2013-01-22  381  

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
