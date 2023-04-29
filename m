Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6F4E6F24EB
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Apr 2023 15:46:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231171AbjD2NqK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Apr 2023 09:46:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229658AbjD2NqI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Apr 2023 09:46:08 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1063C19A0
        for <linux-kernel@vger.kernel.org>; Sat, 29 Apr 2023 06:46:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682775967; x=1714311967;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=hAu+XtSwJcGjVfSWxkoNl1m1zWjRYrLU/I9T88ck34Y=;
  b=mgSS3MGQKb2GfpxdTaqnuYRFEQABD3aNAKOrk3NCXKPBytHLca9Ae2+1
   GAUyjEI6JnoEBzE1mAFtHp6ypUxV9h5Hk1EYZjapfnuIDw+BY1RNoMLZ0
   xLgHxaMGh8ejHnXiKB1ed3XQjvoFTRayp/KgTKMasND9JG9YecZhoBPS+
   X2rTbhGc18iDM2qSgf0zOO36cQd5BSSKBFdqUh5qk0Guw4qZD/xbI75jd
   fbiIKHZUInhSCeCEn0EU7Chx/s1LgoZPTriiherB073C3dyhkRTvBkgaU
   cs5AtjvT6oE8SSOP3I2aJK7sAVzjgsGwbENh6MoU0xMGR8bgyjA/YPvs/
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10695"; a="413349106"
X-IronPort-AV: E=Sophos;i="5.99,237,1677571200"; 
   d="scan'208";a="413349106"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2023 06:46:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10695"; a="764697614"
X-IronPort-AV: E=Sophos;i="5.99,237,1677571200"; 
   d="scan'208";a="764697614"
Received: from lkp-server01.sh.intel.com (HELO 5bad9d2b7fcb) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 29 Apr 2023 06:46:04 -0700
Received: from kbuild by 5bad9d2b7fcb with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pskto-0001BF-04;
        Sat, 29 Apr 2023 13:46:04 +0000
Date:   Sat, 29 Apr 2023 21:45:50 +0800
From:   kernel test robot <lkp@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Ingo Molnar <mingo@kernel.org>
Subject: vmlinux.o: warning: objtool: mwait_idle+0x2a: call to
 ftrace_likely_update() leaves .noinstr.text section
Message-ID: <202304292130.LFKg2UgL-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   89d77f71f493a3663b10fa812d17f472935d24be
commit: e4df1511e1f4bcaa0d590aa7bbffe8bbbd6dfb49 cpuidle, sched: Remove instrumentation from TIF_{POLLING_NRFLAG,NEED_RESCHED}
date:   4 months ago
config: x86_64-randconfig-c022 (https://download.01.org/0day-ci/archive/20230429/202304292130.LFKg2UgL-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-12) 11.3.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=e4df1511e1f4bcaa0d590aa7bbffe8bbbd6dfb49
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout e4df1511e1f4bcaa0d590aa7bbffe8bbbd6dfb49
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=x86_64 olddefconfig
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202304292130.LFKg2UgL-lkp@intel.com/

All warnings (new ones prefixed by >>):

   vmlinux.o: warning: objtool: __rdgsbase_inactive+0x32: call to ftrace_likely_update() leaves .noinstr.text section
   vmlinux.o: warning: objtool: __wrgsbase_inactive+0x36: call to ftrace_likely_update() leaves .noinstr.text section
   vmlinux.o: warning: objtool: fixup_bad_iret+0x75: call to ftrace_likely_update() leaves .noinstr.text section
   vmlinux.o: warning: objtool: noist_exc_debug+0x3d: call to ftrace_likely_update() leaves .noinstr.text section
   vmlinux.o: warning: objtool: exc_nmi+0xbc: call to ftrace_likely_update() leaves .noinstr.text section
   vmlinux.o: warning: objtool: poke_int3_handler+0x34: call to ftrace_likely_update() leaves .noinstr.text section
   vmlinux.o: warning: objtool: mce_check_crashing_cpu+0xd: call to ftrace_likely_update() leaves .noinstr.text section
   vmlinux.o: warning: objtool: do_machine_check+0x4d: call to ftrace_likely_update() leaves .noinstr.text section
   vmlinux.o: warning: objtool: exc_machine_check+0x52: call to ftrace_likely_update() leaves .noinstr.text section
   vmlinux.o: warning: objtool: irqentry_nmi_enter+0x49: call to ftrace_likely_update() leaves .noinstr.text section
   vmlinux.o: warning: objtool: irqentry_nmi_exit+0x6b: call to ftrace_likely_update() leaves .noinstr.text section
   vmlinux.o: warning: objtool: enter_from_user_mode+0x3a: call to ftrace_likely_update() leaves .noinstr.text section
   vmlinux.o: warning: objtool: syscall_enter_from_user_mode+0x3f: call to ftrace_likely_update() leaves .noinstr.text section
   vmlinux.o: warning: objtool: syscall_enter_from_user_mode_prepare+0x3a: call to ftrace_likely_update() leaves .noinstr.text section
   vmlinux.o: warning: objtool: irqentry_enter_from_user_mode+0x3a: call to ftrace_likely_update() leaves .noinstr.text section
   vmlinux.o: warning: objtool: irqentry_exit+0x3e: call to ftrace_likely_update() leaves .noinstr.text section
   vmlinux.o: warning: objtool: default_idle+0x4: call to mds_idle_clear_cpu_buffers() leaves .noinstr.text section
>> vmlinux.o: warning: objtool: mwait_idle+0x2a: call to ftrace_likely_update() leaves .noinstr.text section
>> vmlinux.o: warning: objtool: acpi_processor_ffh_cstate_enter+0x45: call to ftrace_likely_update() leaves .noinstr.text section
   vmlinux.o: warning: objtool: intel_idle_ibrs+0x12: call to sched_smt_active() leaves .noinstr.text section
>> vmlinux.o: warning: objtool: intel_idle_xstate+0x5e: call to ftrace_likely_update() leaves .noinstr.text section
>> vmlinux.o: warning: objtool: intel_idle_s2idle+0x63: call to ftrace_likely_update() leaves .noinstr.text section
>> vmlinux.o: warning: objtool: intel_idle_irq+0x5a: call to ftrace_likely_update() leaves .noinstr.text section
>> vmlinux.o: warning: objtool: intel_idle+0x59: call to ftrace_likely_update() leaves .noinstr.text section
   vmlinux.o: warning: objtool: acpi_safe_halt+0xf: call to mds_idle_clear_cpu_buffers() leaves .noinstr.text section
   vmlinux.o: warning: objtool: io_idle+0x3: call to __inb.isra.0() leaves .noinstr.text section
   vmlinux.o: warning: objtool: acpi_idle_enter_s2idle+0x53: call to ftrace_likely_update() leaves .noinstr.text section
   vmlinux.o: warning: objtool: acpi_idle_enter+0x4c: call to ftrace_likely_update() leaves .noinstr.text section


objdump-func vmlinux.o mwait_idle:
0000 000000000000000d <mwait_idle>:
0000    d:	f3 0f 1e fa          	endbr64
0004   11:	55                   	push   %rbp
0005   12:	48 8b 2c 25 00 00 00 00 	mov    0x0,%rbp	16: R_X86_64_32S	pcpu_hot
000d   1a:	53                   	push   %rbx
000e   1b:	80 4d 02 20          	orb    $0x20,0x2(%rbp)
0012   1f:	48 8b 5d 00          	mov    0x0(%rbp),%rbx
0016   23:	31 c9                	xor    %ecx,%ecx
0018   25:	31 d2                	xor    %edx,%edx
001a   27:	48 c7 c7 00 00 00 00 	mov    $0x0,%rdi	2a: R_X86_64_32S	_ftrace_annotated_branch+0x91e0
0021   2e:	48 c1 eb 03          	shr    $0x3,%rbx
0025   32:	83 e3 01             	and    $0x1,%ebx
0028   35:	89 de                	mov    %ebx,%esi
002a   37:	e8 00 00 00 00       	call   3c <mwait_idle+0x2f>	38: R_X86_64_PLT32	ftrace_likely_update-0x4
002f   3c:	48 85 db             	test   %rbx,%rbx
0032   3f:	75 50                	jne    91 <mwait_idle+0x84>
0034   41:	48 8b 05 00 00 00 00 	mov    0x0(%rip),%rax        # 48 <mwait_idle+0x3b>	44: R_X86_64_PC32	boot_cpu_data+0x74
003b   48:	84 c0                	test   %al,%al
003d   4a:	79 0e                	jns    5a <mwait_idle+0x4d>
003f   4c:	0f ae f0             	mfence
0042   4f:	48 89 ef             	mov    %rbp,%rdi
0045   52:	e8 00 00 00 00       	call   57 <mwait_idle+0x4a>	53: R_X86_64_PC32	.text+0x3e2b0
004a   57:	0f ae f0             	mfence
004d   5a:	48 8b 1c 25 00 00 00 00 	mov    0x0,%rbx	5e: R_X86_64_32S	pcpu_hot
0055   62:	48 89 df             	mov    %rbx,%rdi
0058   65:	e8 00 00 00 00       	call   6a <mwait_idle+0x5d>	66: R_X86_64_PC32	.text+0x3e818
005d   6a:	48 8b 1b             	mov    (%rbx),%rbx
0060   6d:	31 c9                	xor    %ecx,%ecx
0062   6f:	31 d2                	xor    %edx,%edx
0064   71:	48 c7 c7 00 00 00 00 	mov    $0x0,%rdi	74: R_X86_64_32S	_ftrace_annotated_branch+0x9210
006b   78:	48 c1 eb 03          	shr    $0x3,%rbx
006f   7c:	83 e3 01             	and    $0x1,%ebx
0072   7f:	89 de                	mov    %ebx,%esi
0074   81:	e8 00 00 00 00       	call   86 <mwait_idle+0x79>	82: R_X86_64_PLT32	ftrace_likely_update-0x4
0079   86:	48 85 db             	test   %rbx,%rbx
007c   89:	75 06                	jne    91 <mwait_idle+0x84>
007e   8b:	e8 00 00 00 00       	call   90 <mwait_idle+0x83>	8c: R_X86_64_PC32	.text+0x3e809
0083   90:	fa                   	cli
0084   91:	48 8b 04 25 00 00 00 00 	mov    0x0,%rax	95: R_X86_64_32S	pcpu_hot
008c   99:	80 60 02 df          	andb   $0xdf,0x2(%rax)
0090   9d:	5b                   	pop    %rbx
0091   9e:	5d                   	pop    %rbp
0092   9f:	c3                   	ret

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
