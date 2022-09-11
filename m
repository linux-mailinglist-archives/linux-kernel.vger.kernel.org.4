Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 657575B5209
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 01:44:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229552AbiIKXoU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Sep 2022 19:44:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbiIKXoS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Sep 2022 19:44:18 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 259452716D;
        Sun, 11 Sep 2022 16:44:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662939857; x=1694475857;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=6RA/2sRswC+ieF1+tMj4TsmPI50zlEycZSmfXulSoRk=;
  b=EGomgBO8Lb49nw1FJQDC/9t+QFxA2sl9W6yuVPz1r+3GDj+2zOa1CUBG
   Jm+fJFrYXsQgTg42ZJi4xuzeS3JJ9l346CHKWNRmeQOUUmivbRCkVCpf/
   3GD3go/vBbYV682ABG4oiShxvR6Kg43yN8m9gGCx2gTtBH3dNb0QGzW6W
   U3i7Gktc5kF7dGzufCbyb77uMV9g51if2T5K8Uh3stu1B3MgSwbRGYJUF
   F0WVOmq7whhCOH+D+F3SxW4BmetKdmKU2agAaK5If8JudqbdMk8mtW4IZ
   ttX7umFJcOriB/BsNnFehhnZ26Frn6fIT39ulInrQj7uML5tX4umlTEAd
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10467"; a="359484057"
X-IronPort-AV: E=Sophos;i="5.93,308,1654585200"; 
   d="scan'208";a="359484057"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2022 16:44:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,308,1654585200"; 
   d="scan'208";a="649067179"
Received: from lkp-server02.sh.intel.com (HELO 4011df4f4fd3) ([10.239.97.151])
  by orsmga001.jf.intel.com with ESMTP; 11 Sep 2022 16:44:14 -0700
Received: from kbuild by 4011df4f4fd3 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oXWcY-0001yt-0r;
        Sun, 11 Sep 2022 23:44:14 +0000
Date:   Mon, 12 Sep 2022 07:43:38 +0800
From:   kernel test robot <lkp@intel.com>
To:     Tiezhu Yang <yangtiezhu@loongson.cn>, davem@davemloft.net,
        Masami Hiramatsu <mhiramat@kernel.org>
Cc:     kbuild-all@lists.01.org, sparclinux@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sparc: kprobes: Free instructions in arch_remove_kprobe()
Message-ID: <202209120746.pxirzPMp-lkp@intel.com>
References: <1662604440-30524-1-git-send-email-yangtiezhu@loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1662604440-30524-1-git-send-email-yangtiezhu@loongson.cn>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tiezhu,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on v6.0-rc4]
[also build test ERROR on linus/master next-20220909]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Tiezhu-Yang/sparc-kprobes-Free-instructions-in-arch_remove_kprobe/20220908-103454
base:    7e18e42e4b280c85b76967a9106a13ca61c16179
config: sparc-allyesconfig (https://download.01.org/0day-ci/archive/20220912/202209120746.pxirzPMp-lkp@intel.com/config)
compiler: sparc64-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/13d8569b8b252a60b519215d42f438582f00a37f
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Tiezhu-Yang/sparc-kprobes-Free-instructions-in-arch_remove_kprobe/20220908-103454
        git checkout 13d8569b8b252a60b519215d42f438582f00a37f
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=sparc SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from include/linux/kprobes.h:32,
                    from arch/sparc/kernel/kprobes.c:8:
   arch/sparc/include/asm/kprobes.h:20:32: error: 'struct kprobe' declared inside parameter list will not be visible outside of this definition or declaration [-Werror]
      20 | void arch_remove_kprobe(struct kprobe *p);
         |                                ^~~~~~
>> arch/sparc/kernel/kprobes.c:77:16: error: conflicting types for 'arch_remove_kprobe'; have 'void(struct kprobe *)'
      77 | void __kprobes arch_remove_kprobe(struct kprobe *p)
         |                ^~~~~~~~~~~~~~~~~~
   arch/sparc/include/asm/kprobes.h:20:6: note: previous declaration of 'arch_remove_kprobe' with type 'void(struct kprobe *)'
      20 | void arch_remove_kprobe(struct kprobe *p);
         |      ^~~~~~~~~~~~~~~~~~
   arch/sparc/kernel/kprobes.c: In function 'arch_remove_kprobe':
>> arch/sparc/kernel/kprobes.c:79:13: error: the comparison will always evaluate as 'true' for the address of 'insn' will never be NULL [-Werror=address]
      79 |         if (p->ainsn.insn) {
         |             ^
   arch/sparc/include/asm/kprobes.h:32:25: note: 'insn' declared here
      32 |         kprobe_opcode_t insn[MAX_INSN_SIZE];
         |                         ^~~~
>> arch/sparc/kernel/kprobes.c:80:17: error: implicit declaration of function 'free_insn_slot'; did you mean 'flush_insn_slot'? [-Werror=implicit-function-declaration]
      80 |                 free_insn_slot(p->ainsn.insn, 0);
         |                 ^~~~~~~~~~~~~~
         |                 flush_insn_slot
>> arch/sparc/kernel/kprobes.c:81:31: error: assignment to expression with array type
      81 |                 p->ainsn.insn = NULL;
         |                               ^
   cc1: all warnings being treated as errors
--
   In file included from include/linux/kprobes.h:32,
                    from kernel/kprobes.c:23:
   arch/sparc/include/asm/kprobes.h:20:32: warning: 'struct kprobe' declared inside parameter list will not be visible outside of this definition or declaration
      20 | void arch_remove_kprobe(struct kprobe *p);
         |                                ^~~~~~
   kernel/kprobes.c: In function 'free_aggr_kprobe':
>> kernel/kprobes.c:1051:28: error: passing argument 1 of 'arch_remove_kprobe' from incompatible pointer type [-Werror=incompatible-pointer-types]
    1051 |         arch_remove_kprobe(p);
         |                            ^
         |                            |
         |                            struct kprobe *
   arch/sparc/include/asm/kprobes.h:20:40: note: expected 'struct kprobe *' but argument is of type 'struct kprobe *'
      20 | void arch_remove_kprobe(struct kprobe *p);
         |                         ~~~~~~~~~~~~~~~^
   kernel/kprobes.c: In function '__unregister_kprobe_bottom':
   kernel/kprobes.c:1792:36: error: passing argument 1 of 'arch_remove_kprobe' from incompatible pointer type [-Werror=incompatible-pointer-types]
    1792 |                 arch_remove_kprobe(p);
         |                                    ^
         |                                    |
         |                                    struct kprobe *
   arch/sparc/include/asm/kprobes.h:20:40: note: expected 'struct kprobe *' but argument is of type 'struct kprobe *'
      20 | void arch_remove_kprobe(struct kprobe *p);
         |                         ~~~~~~~~~~~~~~~^
   kernel/kprobes.c: In function 'kill_kprobe':
   kernel/kprobes.c:2371:28: error: passing argument 1 of 'arch_remove_kprobe' from incompatible pointer type [-Werror=incompatible-pointer-types]
    2371 |         arch_remove_kprobe(p);
         |                            ^
         |                            |
         |                            struct kprobe *
   arch/sparc/include/asm/kprobes.h:20:40: note: expected 'struct kprobe *' but argument is of type 'struct kprobe *'
      20 | void arch_remove_kprobe(struct kprobe *p);
         |                         ~~~~~~~~~~~~~~~^
   cc1: some warnings being treated as errors


vim +77 arch/sparc/kernel/kprobes.c

   > 8	#include <linux/kprobes.h>
     9	#include <linux/extable.h>
    10	#include <linux/kdebug.h>
    11	#include <linux/slab.h>
    12	#include <linux/context_tracking.h>
    13	#include <asm/signal.h>
    14	#include <asm/cacheflush.h>
    15	#include <linux/uaccess.h>
    16	
    17	/* We do not have hardware single-stepping on sparc64.
    18	 * So we implement software single-stepping with breakpoint
    19	 * traps.  The top-level scheme is similar to that used
    20	 * in the x86 kprobes implementation.
    21	 *
    22	 * In the kprobe->ainsn.insn[] array we store the original
    23	 * instruction at index zero and a break instruction at
    24	 * index one.
    25	 *
    26	 * When we hit a kprobe we:
    27	 * - Run the pre-handler
    28	 * - Remember "regs->tnpc" and interrupt level stored in
    29	 *   "regs->tstate" so we can restore them later
    30	 * - Disable PIL interrupts
    31	 * - Set regs->tpc to point to kprobe->ainsn.insn[0]
    32	 * - Set regs->tnpc to point to kprobe->ainsn.insn[1]
    33	 * - Mark that we are actively in a kprobe
    34	 *
    35	 * At this point we wait for the second breakpoint at
    36	 * kprobe->ainsn.insn[1] to hit.  When it does we:
    37	 * - Run the post-handler
    38	 * - Set regs->tpc to "remembered" regs->tnpc stored above,
    39	 *   restore the PIL interrupt level in "regs->tstate" as well
    40	 * - Make any adjustments necessary to regs->tnpc in order
    41	 *   to handle relative branches correctly.  See below.
    42	 * - Mark that we are no longer actively in a kprobe.
    43	 */
    44	
    45	DEFINE_PER_CPU(struct kprobe *, current_kprobe) = NULL;
    46	DEFINE_PER_CPU(struct kprobe_ctlblk, kprobe_ctlblk);
    47	
    48	struct kretprobe_blackpoint kretprobe_blacklist[] = {{NULL, NULL}};
    49	
    50	int __kprobes arch_prepare_kprobe(struct kprobe *p)
    51	{
    52		if ((unsigned long) p->addr & 0x3UL)
    53			return -EILSEQ;
    54	
    55		p->ainsn.insn[0] = *p->addr;
    56		flushi(&p->ainsn.insn[0]);
    57	
    58		p->ainsn.insn[1] = BREAKPOINT_INSTRUCTION_2;
    59		flushi(&p->ainsn.insn[1]);
    60	
    61		p->opcode = *p->addr;
    62		return 0;
    63	}
    64	
    65	void __kprobes arch_arm_kprobe(struct kprobe *p)
    66	{
    67		*p->addr = BREAKPOINT_INSTRUCTION;
    68		flushi(p->addr);
    69	}
    70	
    71	void __kprobes arch_disarm_kprobe(struct kprobe *p)
    72	{
    73		*p->addr = p->opcode;
    74		flushi(p->addr);
    75	}
    76	
  > 77	void __kprobes arch_remove_kprobe(struct kprobe *p)
    78	{
  > 79		if (p->ainsn.insn) {
  > 80			free_insn_slot(p->ainsn.insn, 0);
  > 81			p->ainsn.insn = NULL;
    82		}
    83	}
    84	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
