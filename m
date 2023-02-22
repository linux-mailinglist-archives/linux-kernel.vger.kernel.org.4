Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F02069F6FD
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 15:47:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232144AbjBVOrT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 09:47:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231905AbjBVOrQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 09:47:16 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 757423B3C8
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 06:46:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677077217; x=1708613217;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=GhDylQILz6LEI2dCAs70wjx9Rj6YJKQKds53I9AkC9I=;
  b=gMShymeB7KeeeoNPQmviI0qE1GsQe0R6ToZqkYasl4tMAWdNjwlDg2W6
   Vvl3k5y95mhwA1kRTTEWBJb3f+JWlF5leDUJwEvyM79knN8S+5F5I5nFi
   o3REb8kOcw7VHwA4x6JnzyDiFnO5VPjejfKJhwPBo5BhYjMq3M0QLJ29R
   BXGeegmVMyn7OEaY/j+oTKFeDs1nlJpALYHGlsU7UOATq7cUANEAndRcq
   qTmBEK9BgxkK6OZQMdiGnXbcgn0Dkh9udvUW0wdZAlK2HVGt42q3BTim1
   8qOPFR6MEfwQ9TYP9M8ZeaqQs/BFUd0GSNZ8TQM3bMgQKGTwSJIBaUO7l
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10629"; a="397624644"
X-IronPort-AV: E=Sophos;i="5.97,319,1669104000"; 
   d="scan'208";a="397624644"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2023 06:45:20 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10629"; a="1001016928"
X-IronPort-AV: E=Sophos;i="5.97,319,1669104000"; 
   d="scan'208";a="1001016928"
Received: from lkp-server01.sh.intel.com (HELO 3895f5c55ead) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 22 Feb 2023 06:45:19 -0800
Received: from kbuild by 3895f5c55ead with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pUqMw-0000Sn-1S;
        Wed, 22 Feb 2023 14:45:18 +0000
Date:   Wed, 22 Feb 2023 22:44:54 +0800
From:   kernel test robot <lkp@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Ingo Molnar <mingo@kernel.org>
Subject: vmlinux.o: warning: objtool: intel_idle_ibrs+0x169: call to
 ftrace_likely_update() leaves .noinstr.text section
Message-ID: <202302222203.CR5fNzF4-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   5b7c4cabbb65f5c469464da6c5f614cbd7f730f2
commit: 9b461a6faae7b220c32466261965778b10189e54 cpuidle, intel_idle: Fix CPUIDLE_FLAG_IBRS
date:   6 weeks ago
config: x86_64-randconfig-r002-20230220 (https://download.01.org/0day-ci/archive/20230222/202302222203.CR5fNzF4-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-8) 11.3.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=9b461a6faae7b220c32466261965778b10189e54
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 9b461a6faae7b220c32466261965778b10189e54
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=x86_64 olddefconfig
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202302222203.CR5fNzF4-lkp@intel.com/

All warnings (new ones prefixed by >>):

   vmlinux.o: warning: objtool: __rdgsbase_inactive+0x22: call to ftrace_likely_update() leaves .noinstr.text section
   vmlinux.o: warning: objtool: __wrgsbase_inactive+0x26: call to ftrace_likely_update() leaves .noinstr.text section
   vmlinux.o: warning: objtool: fixup_bad_iret+0x7f: call to ftrace_likely_update() leaves .noinstr.text section
   vmlinux.o: warning: objtool: noist_exc_debug+0x3c: call to ftrace_likely_update() leaves .noinstr.text section
   vmlinux.o: warning: objtool: exc_nmi+0x31: call to ftrace_likely_update() leaves .noinstr.text section
   vmlinux.o: warning: objtool: poke_int3_handler+0x2d: call to ftrace_likely_update() leaves .noinstr.text section
   vmlinux.o: warning: objtool: irqentry_nmi_enter+0x48: call to ftrace_likely_update() leaves .noinstr.text section
   vmlinux.o: warning: objtool: irqentry_nmi_exit+0x43: call to ftrace_likely_update() leaves .noinstr.text section
   vmlinux.o: warning: objtool: enter_from_user_mode+0x2f: call to ftrace_likely_update() leaves .noinstr.text section
   vmlinux.o: warning: objtool: syscall_enter_from_user_mode+0x34: call to ftrace_likely_update() leaves .noinstr.text section
   vmlinux.o: warning: objtool: syscall_enter_from_user_mode_prepare+0x2f: call to ftrace_likely_update() leaves .noinstr.text section
   vmlinux.o: warning: objtool: irqentry_enter_from_user_mode+0x2f: call to ftrace_likely_update() leaves .noinstr.text section
   vmlinux.o: warning: objtool: irqentry_exit+0x29: call to ftrace_likely_update() leaves .noinstr.text section
   vmlinux.o: warning: objtool: ct_kernel_exit_state+0x3d: call to ftrace_likely_update() leaves .noinstr.text section
   vmlinux.o: warning: objtool: ct_kernel_enter_state+0x3d: call to ftrace_likely_update() leaves .noinstr.text section
   vmlinux.o: warning: objtool: context_tracking_recursion_enter+0x46: call to ftrace_likely_update() leaves .noinstr.text section
   vmlinux.o: warning: objtool: ct_kernel_enter.constprop.0+0x2a: call to ftrace_likely_update() leaves .noinstr.text section
   vmlinux.o: warning: objtool: ct_kernel_exit.constprop.0+0x48: call to ftrace_likely_update() leaves .noinstr.text section
   vmlinux.o: warning: objtool: ct_idle_enter+0x15: call to ftrace_likely_update() leaves .noinstr.text section
   vmlinux.o: warning: objtool: __ct_user_enter+0x4f: call to ftrace_likely_update() leaves .noinstr.text section
   vmlinux.o: warning: objtool: ct_nmi_enter+0x3d: call to ftrace_likely_update() leaves .noinstr.text section
   vmlinux.o: warning: objtool: ct_irq_enter+0x34: call to ftrace_likely_update() leaves .noinstr.text section
   vmlinux.o: warning: objtool: ct_irq_exit+0x34: call to ftrace_likely_update() leaves .noinstr.text section
   vmlinux.o: warning: objtool: mwait_idle+0x2a: call to ftrace_likely_update() leaves .noinstr.text section
   vmlinux.o: warning: objtool: acpi_processor_ffh_cstate_enter+0x120: call to ftrace_likely_update() leaves .noinstr.text section
>> vmlinux.o: warning: objtool: intel_idle_ibrs+0x169: call to ftrace_likely_update() leaves .noinstr.text section
   vmlinux.o: warning: objtool: intel_idle+0x113: call to ftrace_likely_update() leaves .noinstr.text section
   vmlinux.o: warning: objtool: intel_idle_xstate+0x118: call to ftrace_likely_update() leaves .noinstr.text section
   vmlinux.o: warning: objtool: intel_idle_irq+0x115: call to ftrace_likely_update() leaves .noinstr.text section
   vmlinux.o: warning: objtool: intel_idle_s2idle+0x11c: call to ftrace_likely_update() leaves .noinstr.text section
   vmlinux.o: warning: objtool: acpi_idle_enter_s2idle+0x8b: call to ftrace_likely_update() leaves .noinstr.text section
   vmlinux.o: warning: objtool: acpi_idle_enter+0x6b: call to ftrace_likely_update() leaves .noinstr.text section


objdump-func vmlinux.o intel_idle_ibrs:
0000 0000000000000500 <intel_idle_ibrs>:
0000      500:	41 56                	push   %r14
0002      502:	49 89 f6             	mov    %rsi,%r14
0005      505:	41 55                	push   %r13
0007      507:	41 54                	push   %r12
0009      509:	41 89 d4             	mov    %edx,%r12d
000c      50c:	55                   	push   %rbp
000d      50d:	53                   	push   %rbx
000e      50e:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)	50f: R_X86_64_NONE	__sanitizer_cov_trace_pc-0x4
0013      513:	e9 64 01 00 00       	jmp    67c <intel_idle_ibrs+0x17c>
0018      518:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)	519: R_X86_64_NONE	__sanitizer_cov_trace_pc-0x4
001d      51d:	e8 00 00 00 00       	call   522 <intel_idle_ibrs+0x22>	51e: R_X86_64_PLT32	spec_ctrl_current-0x4
0022      522:	b9 48 00 00 00       	mov    $0x48,%ecx
0027      527:	48 89 c3             	mov    %rax,%rbx
002a      52a:	31 c0                	xor    %eax,%eax
002c      52c:	89 c2                	mov    %eax,%edx
002e      52e:	0f 30                	wrmsr
0030      530:	41 bd 01 00 00 00    	mov    $0x1,%r13d
0036      536:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)	537: R_X86_64_NONE	__sanitizer_cov_trace_pc-0x4
003b      53b:	49 63 ec             	movslq %r12d,%rbp
003e      53e:	48 83 fd 0a          	cmp    $0xa,%rbp
0042      542:	0f 87 49 01 00 00    	ja     691 <intel_idle_ibrs+0x191>
0048      548:	48 8d 44 6d 00       	lea    0x0(%rbp,%rbp,2),%rax
004d      54d:	48 8d 44 85 00       	lea    0x0(%rbp,%rax,4),%rax
0052      552:	41 8b 6c c6 58       	mov    0x58(%r14,%rax,8),%ebp
0057      557:	e9 00 00 00 00       	jmp    55c <intel_idle_ibrs+0x5c>	558: R_X86_64_PC32	.altinstr_aux+0x1bc2
005c      55c:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)	55d: R_X86_64_NONE	__sanitizer_cov_trace_pc-0x4
0061      561:	e9 00 00 00 00       	jmp    566 <intel_idle_ibrs+0x66>	562: R_X86_64_PC32	.altinstr_aux+0x1bd4
0066      566:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)	567: R_X86_64_NONE	__sanitizer_cov_trace_pc-0x4
006b      56b:	0f ae f0             	mfence
006e      56e:	65 48 8b 04 25 00 00 00 00 	mov    %gs:0x0,%rax	573: R_X86_64_32S	pcpu_hot
0077      577:	0f ae 38             	clflush (%rax)
007a      57a:	0f ae f0             	mfence
007d      57d:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)	57e: R_X86_64_NONE	__sanitizer_cov_trace_pc-0x4
0082      582:	31 d2                	xor    %edx,%edx
0084      584:	48 89 d1             	mov    %rdx,%rcx
0087      587:	65 48 8b 04 25 00 00 00 00 	mov    %gs:0x0,%rax	58c: R_X86_64_32S	pcpu_hot
0090      590:	0f 01 c8             	monitor %rax,%ecx,%edx
0093      593:	48 8b 30             	mov    (%rax),%rsi
0096      596:	48 c7 c7 00 00 00 00 	mov    $0x0,%rdi	599: R_X86_64_32S	_ftrace_annotated_branch+0x1d2d70
009d      59d:	48 c1 ee 03          	shr    $0x3,%rsi
00a1      5a1:	41 89 f6             	mov    %esi,%r14d
00a4      5a4:	83 e6 01             	and    $0x1,%esi
00a7      5a7:	41 83 e6 01          	and    $0x1,%r14d
00ab      5ab:	e8 00 00 00 00       	call   5b0 <intel_idle_ibrs+0xb0>	5ac: R_X86_64_PLT32	ftrace_likely_update-0x4
00b0      5b0:	45 84 f6             	test   %r14b,%r14b
00b3      5b3:	75 25                	jne    5da <intel_idle_ibrs+0xda>
00b5      5b5:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)	5b6: R_X86_64_NONE	__sanitizer_cov_trace_pc-0x4
00ba      5ba:	eb 0c                	jmp    5c8 <intel_idle_ibrs+0xc8>
00bc      5bc:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)	5bd: R_X86_64_NONE	__sanitizer_cov_trace_pc-0x4
00c1      5c1:	0f 00 2d 00 00 00 00 	verw   0x0(%rip)        # 5c8 <intel_idle_ibrs+0xc8>	5c4: R_X86_64_PC32	.rodata+0x2ca048
00c8      5c8:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)	5c9: R_X86_64_NONE	__sanitizer_cov_trace_pc-0x4
00cd      5cd:	c1 ed 18             	shr    $0x18,%ebp
00d0      5d0:	b9 01 00 00 00       	mov    $0x1,%ecx
00d5      5d5:	89 e8                	mov    %ebp,%eax
00d7      5d7:	0f 01 c9             	mwait  %eax,%ecx
00da      5da:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)	5db: R_X86_64_NONE	__sanitizer_cov_trace_pc-0x4
00df      5df:	65 48 8b 04 25 00 00 00 00 	mov    %gs:0x0,%rax	5e4: R_X86_64_32S	pcpu_hot
00e8      5e8:	f0 80 60 02 df       	lock andb $0xdf,0x2(%rax)
00ed      5ed:	f0 83 44 24 fc 00    	lock addl $0x0,-0x4(%rsp)
00f3      5f3:	48 8b 00             	mov    (%rax),%rax
00f6      5f6:	a8 08                	test   $0x8,%al
00f8      5f8:	74 10                	je     60a <intel_idle_ibrs+0x10a>
00fa      5fa:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)	5fb: R_X86_64_NONE	__sanitizer_cov_trace_pc-0x4
00ff      5ff:	65 81 25 00 00 00 00 ff ff ff 7f 	andl   $0x7fffffff,%gs:0x0(%rip)        # 60a <intel_idle_ibrs+0x10a>	602: R_X86_64_PC32	pcpu_hot
010a      60a:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)	60b: R_X86_64_NONE	__sanitizer_cov_trace_pc-0x4
010f      60f:	45 84 ed             	test   %r13b,%r13b
0112      612:	74 15                	je     629 <intel_idle_ibrs+0x129>
0114      614:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)	615: R_X86_64_NONE	__sanitizer_cov_trace_pc-0x4
0119      619:	48 89 da             	mov    %rbx,%rdx
011c      61c:	b9 48 00 00 00       	mov    $0x48,%ecx
0121      621:	89 d8                	mov    %ebx,%eax
0123      623:	48 c1 ea 20          	shr    $0x20,%rdx
0127      627:	0f 30                	wrmsr
0129      629:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)	62a: R_X86_64_NONE	__sanitizer_cov_trace_pc-0x4
012e      62e:	44 89 e0             	mov    %r12d,%eax
0131      631:	5b                   	pop    %rbx
0132      632:	5d                   	pop    %rbp
0133      633:	41 5c                	pop    %r12
0135      635:	41 5d                	pop    %r13
0137      637:	41 5e                	pop    %r14
0139      639:	c3                   	ret
013a      63a:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)	63b: R_X86_64_NONE	__sanitizer_cov_trace_pc-0x4
013f      63f:	65 48 8b 04 25 00 00 00 00 	mov    %gs:0x0,%rax	644: R_X86_64_32S	pcpu_hot
0148      648:	f0 80 48 02 20       	lock orb $0x20,0x2(%rax)
014d      64d:	48 8b 30             	mov    (%rax),%rsi
0150      650:	31 c9                	xor    %ecx,%ecx
0152      652:	31 d2                	xor    %edx,%edx
0154      654:	48 c7 c7 00 00 00 00 	mov    $0x0,%rdi	657: R_X86_64_32S	_ftrace_annotated_branch+0x1d2d40
015b      65b:	48 c1 ee 03          	shr    $0x3,%rsi
015f      65f:	41 89 f6             	mov    %esi,%r14d
0162      662:	83 e6 01             	and    $0x1,%esi
0165      665:	41 83 e6 01          	and    $0x1,%r14d
0169      669:	e8 00 00 00 00       	call   66e <intel_idle_ibrs+0x16e>	66a: R_X86_64_PLT32	ftrace_likely_update-0x4
016e      66e:	45 84 f6             	test   %r14b,%r14b
0171      671:	0f 85 63 ff ff ff    	jne    5da <intel_idle_ibrs+0xda>
0177      677:	e9 e0 fe ff ff       	jmp    55c <intel_idle_ibrs+0x5c>
017c      67c:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)	67d: R_X86_64_NONE	__sanitizer_cov_trace_pc-0x4
0181      681:	45 31 ed             	xor    %r13d,%r13d
0184      684:	e8 00 00 00 00       	call   689 <intel_idle_ibrs+0x189>	685: R_X86_64_PLT32	spec_ctrl_current-0x4
0189      689:	48 89 c3             	mov    %rax,%rbx
018c      68c:	e9 a5 fe ff ff       	jmp    536 <intel_idle_ibrs+0x36>
0191      691:	48 89 ee             	mov    %rbp,%rsi
0194      694:	48 c7 c7 00 00 00 00 	mov    $0x0,%rdi	697: R_X86_64_32S	.data+0x640b00
019b      69b:	e8 00 00 00 00       	call   6a0 <intel_idle_ibrs+0x1a0>	69c: R_X86_64_PLT32	__ubsan_handle_out_of_bounds-0x4
01a0      6a0:	e9 a3 fe ff ff       	jmp    548 <intel_idle_ibrs+0x48>
01a5      6a5:	66 66 2e 0f 1f 84 00 00 00 00 00 	data16 cs nopw 0x0(%rax,%rax,1)
01b0      6b0:	66 66 2e 0f 1f 84 00 00 00 00 00 	data16 cs nopw 0x0(%rax,%rax,1)
01bb      6bb:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
