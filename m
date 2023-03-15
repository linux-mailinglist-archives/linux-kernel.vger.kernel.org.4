Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC9B56BAC47
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 10:38:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232020AbjCOJix (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 05:38:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231360AbjCOJiu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 05:38:50 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C80E20D28
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 02:38:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678873129; x=1710409129;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=l5NmdGHedxZEYR/M2dpo1rb+Pszqn3k4irRAb6fhhf8=;
  b=NFTfDs6h/q+zBKz2I5fU21TYnDkBqzh6QW2i8AaNBSrMduv6gzQABn1Y
   u4a4ybIDsPFPrIncRqSDlPViiLF4sbWpZ1PwF6Ax9qoFCs7evyw8dP0lf
   +uFOQlvCW2FNGJpC83etjOCl4t9FHkjyVNH5ybi03NC2YUj/zYbv00bgs
   ZSlNKouGJzvvHvvVhggTRrrAUeDfBIvzUnGBCJI0AYS9S71MZYC9jEou8
   O3lYWGsly+2z81Jbu3Y4Xrr5i3cuMJ7aJLv+w4L0oDRqgxUELuWNJGbPn
   su5sHqa5v85X5g4a7qjGuHqOUqmv4wm963yYo1FrpuFWc8wbjHfYfVGXr
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10649"; a="326017166"
X-IronPort-AV: E=Sophos;i="5.98,262,1673942400"; 
   d="scan'208";a="326017166"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2023 02:38:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10649"; a="748352300"
X-IronPort-AV: E=Sophos;i="5.98,262,1673942400"; 
   d="scan'208";a="748352300"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 15 Mar 2023 02:38:47 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pcNaj-0007ab-0Y;
        Wed, 15 Mar 2023 09:38:41 +0000
Date:   Wed, 15 Mar 2023 17:38:19 +0800
From:   kernel test robot <lkp@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Ingo Molnar <mingo@kernel.org>,
        "Srivatsa S. Bhat (VMware)" <srivatsa@csail.mit.edu>,
        Juergen Gross <jgross@suse.com>
Subject: vmlinux.o: warning: objtool: default_idle+0x24: call to
 ftrace_likely_update() leaves .noinstr.text section
Message-ID: <202303151730.MMpcNp5k-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   6015b1aca1a233379625385feb01dd014aca60b5
commit: 10a099405fdf96c3205ae775abf19fcd301b31b4 cpuidle, xenpv: Make more PARAVIRT_XXL noinstr clean
date:   9 weeks ago
config: x86_64-randconfig-a011-20220124 (https://download.01.org/0day-ci/archive/20230315/202303151730.MMpcNp5k-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-8) 11.3.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=10a099405fdf96c3205ae775abf19fcd301b31b4
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 10a099405fdf96c3205ae775abf19fcd301b31b4
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=x86_64 olddefconfig
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202303151730.MMpcNp5k-lkp@intel.com/

All warnings (new ones prefixed by >>):

   vmlinux.o: warning: objtool: __rdgsbase_inactive+0x25: call to ftrace_likely_update() leaves .noinstr.text section
   vmlinux.o: warning: objtool: __wrgsbase_inactive+0x2a: call to ftrace_likely_update() leaves .noinstr.text section
   vmlinux.o: warning: objtool: exc_double_fault+0x3c: call to ftrace_likely_update() leaves .noinstr.text section
   vmlinux.o: warning: objtool: fixup_bad_iret+0x7e: call to ftrace_likely_update() leaves .noinstr.text section
   vmlinux.o: warning: objtool: exc_debug+0x33: call to ftrace_likely_update() leaves .noinstr.text section
   vmlinux.o: warning: objtool: noist_exc_debug+0x31: call to ftrace_likely_update() leaves .noinstr.text section
   vmlinux.o: warning: objtool: exc_nmi+0x4c: call to ftrace_likely_update() leaves .noinstr.text section
   vmlinux.o: warning: objtool: poke_int3_handler+0x36: call to ftrace_likely_update() leaves .noinstr.text section
   vmlinux.o: warning: objtool: mce_check_crashing_cpu+0x11: call to ftrace_likely_update() leaves .noinstr.text section
   vmlinux.o: warning: objtool: do_machine_check+0x57: call to ftrace_likely_update() leaves .noinstr.text section
   vmlinux.o: warning: objtool: exc_machine_check+0x43: call to ftrace_likely_update() leaves .noinstr.text section
   vmlinux.o: warning: objtool: noist_exc_machine_check+0x41: call to ftrace_likely_update() leaves .noinstr.text section
   vmlinux.o: warning: objtool: exc_page_fault+0x32: call to ftrace_likely_update() leaves .noinstr.text section
   vmlinux.o: warning: objtool: irqentry_nmi_enter+0x50: call to ftrace_likely_update() leaves .noinstr.text section
   vmlinux.o: warning: objtool: irqentry_nmi_exit+0x44: call to ftrace_likely_update() leaves .noinstr.text section
   vmlinux.o: warning: objtool: enter_from_user_mode+0x38: call to ftrace_likely_update() leaves .noinstr.text section
   vmlinux.o: warning: objtool: syscall_enter_from_user_mode+0x3d: call to ftrace_likely_update() leaves .noinstr.text section
   vmlinux.o: warning: objtool: syscall_enter_from_user_mode_prepare+0x38: call to ftrace_likely_update() leaves .noinstr.text section
   vmlinux.o: warning: objtool: irqentry_enter_from_user_mode+0x38: call to ftrace_likely_update() leaves .noinstr.text section
   vmlinux.o: warning: objtool: irqentry_exit+0x31: call to ftrace_likely_update() leaves .noinstr.text section
   vmlinux.o: warning: objtool: context_tracking_recursion_enter+0x30: call to ftrace_likely_update() leaves .noinstr.text section
   vmlinux.o: warning: objtool: __ct_user_exit+0x47: call to __kasan_check_write() leaves .noinstr.text section
   vmlinux.o: warning: objtool: __ct_user_enter+0x34: call to ftrace_likely_update() leaves .noinstr.text section
   vmlinux.o: warning: objtool: tdx_safe_halt+0x2d: call to ftrace_likely_update() leaves .noinstr.text section
>> vmlinux.o: warning: objtool: default_idle+0x24: call to ftrace_likely_update() leaves .noinstr.text section
   vmlinux.o: warning: objtool: mwait_idle+0x31: call to ftrace_likely_update() leaves .noinstr.text section
   vmlinux.o: warning: objtool: acpi_processor_ffh_cstate_enter+0xbe: call to ftrace_likely_update() leaves .noinstr.text section
   vmlinux.o: warning: objtool: cpu_idle_poll.isra.0+0x7d: call to ftrace_likely_update() leaves .noinstr.text section
   vmlinux.o: warning: objtool: intel_idle+0xd0: call to ftrace_likely_update() leaves .noinstr.text section
   vmlinux.o: warning: objtool: intel_idle_irq+0x2e: call to ftrace_likely_update() leaves .noinstr.text section
   vmlinux.o: warning: objtool: intel_idle_s2idle+0xe0: call to ftrace_likely_update() leaves .noinstr.text section
   vmlinux.o: warning: objtool: intel_idle_xstate+0xd5: call to ftrace_likely_update() leaves .noinstr.text section
   vmlinux.o: warning: objtool: intel_idle_ibrs+0x17: call to sched_smt_active() leaves .noinstr.text section


objdump-func vmlinux.o default_idle:
0000 0000000000000110 <default_idle>:
0000  110:	f3 0f 1e fa          	endbr64
0004  114:	55                   	push   %rbp
0005  115:	31 f6                	xor    %esi,%esi
0007  117:	48 c7 c7 00 00 00 00 	mov    $0x0,%rdi	11a: R_X86_64_32S	_ftrace_annotated_branch+0x13fe0
000e  11e:	48 89 e5             	mov    %rsp,%rbp
0011  121:	53                   	push   %rbx
0012  122:	48 8b 1d 00 00 00 00 	mov    0x0(%rip),%rbx        # 129 <default_idle+0x19>	125: R_X86_64_PC32	pv_ops+0x104
0019  129:	48 85 db             	test   %rbx,%rbx
001c  12c:	40 0f 94 c6          	sete   %sil
0020  130:	31 c9                	xor    %ecx,%ecx
0022  132:	31 d2                	xor    %edx,%edx
0024  134:	e8 00 00 00 00       	call   139 <default_idle+0x29>	135: R_X86_64_PLT32	ftrace_likely_update-0x4
0029  139:	48 85 db             	test   %rbx,%rbx
002c  13c:	74 37                	je     175 <default_idle+0x65>
002e  13e:	ff 15 00 00 00 00    	call   *0x0(%rip)        # 144 <default_idle+0x34>	140: R_X86_64_PC32	pv_ops+0x104
0034  144:	48 8b 1d 00 00 00 00 	mov    0x0(%rip),%rbx        # 14b <default_idle+0x3b>	147: R_X86_64_PC32	pv_ops+0xf4
003b  14b:	31 f6                	xor    %esi,%esi
003d  14d:	48 c7 c7 00 00 00 00 	mov    $0x0,%rdi	150: R_X86_64_32S	_ftrace_annotated_branch+0x13e90
0044  154:	48 85 db             	test   %rbx,%rbx
0047  157:	40 0f 94 c6          	sete   %sil
004b  15b:	31 c9                	xor    %ecx,%ecx
004d  15d:	31 d2                	xor    %edx,%edx
004f  15f:	e8 00 00 00 00       	call   164 <default_idle+0x54>	160: R_X86_64_PLT32	ftrace_likely_update-0x4
0054  164:	48 85 db             	test   %rbx,%rbx
0057  167:	74 0f                	je     178 <default_idle+0x68>
0059  169:	ff 15 00 00 00 00    	call   *0x0(%rip)        # 16f <default_idle+0x5f>	16b: R_X86_64_PC32	pv_ops+0xf4
005f  16f:	48 8b 5d f8          	mov    -0x8(%rbp),%rbx
0063  173:	c9                   	leave
0064  174:	c3                   	ret
0065  175:	90                   	nop
0066  176:	0f 0b                	ud2
0068  178:	90                   	nop
0069  179:	0f 0b                	ud2
006b  17b:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
