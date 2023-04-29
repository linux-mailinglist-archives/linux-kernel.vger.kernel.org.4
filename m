Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 254276F2362
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Apr 2023 08:35:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231138AbjD2GfA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Apr 2023 02:35:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbjD2Ge7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Apr 2023 02:34:59 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CB792136
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 23:34:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682750098; x=1714286098;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=3krY6APKrqNmNaXo/EhJPNHUI7FPjrIDQZgus/0AbxE=;
  b=QKlx/YYOMU/vKMUlQr8B5B66arLgkZZdg4OydZeOOO7gnvfhPmerxwx6
   r1+24CZEvjnK9VhRFEEinaQkDXWQLNH+y2OeTiU7VBXBFdWNbi03IbNRx
   oF0YnTQw0MlZkwJp8RdcNk5sq6PD73K6w2VEBF3NvKYua74NvfFBE97Dd
   2c+xknAgkwxoEXBuaAJCt+CplhLeAYpmboZ5yXKZ3UwOZRHFoFFmjifzm
   lb3qv1d4Pn9Xi2hAwpkmp8M/nH/ov4T6YQFj5dp5BL2mccQGsA/V/Y0o7
   ggH1F2TsOprxqF+EUO1bysk9pqgQXJN6A1URoc1T8/vJPvg44swofl8gb
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10694"; a="345370472"
X-IronPort-AV: E=Sophos;i="5.99,236,1677571200"; 
   d="scan'208";a="345370472"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2023 23:34:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10694"; a="695090090"
X-IronPort-AV: E=Sophos;i="5.99,236,1677571200"; 
   d="scan'208";a="695090090"
Received: from lkp-server01.sh.intel.com (HELO 5bad9d2b7fcb) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 28 Apr 2023 23:34:55 -0700
Received: from kbuild by 5bad9d2b7fcb with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pseAZ-0000xV-1H;
        Sat, 29 Apr 2023 06:34:55 +0000
Date:   Sat, 29 Apr 2023 14:34:39 +0800
From:   kernel test robot <lkp@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Ingo Molnar <mingo@kernel.org>
Subject: vmlinux.o: warning: objtool: intel_idle_ibrs+0x12: call to
 sched_smt_active() leaves .noinstr.text section
Message-ID: <202304291444.8Uqp9A2n-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   89d77f71f493a3663b10fa812d17f472935d24be
commit: 2b5a0e425e6e319b1978db1e9564f6af4228a567 objtool/idle: Validate __cpuidle code as noinstr
date:   4 months ago
config: x86_64-randconfig-c022 (https://download.01.org/0day-ci/archive/20230429/202304291444.8Uqp9A2n-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-12) 11.3.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=2b5a0e425e6e319b1978db1e9564f6af4228a567
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 2b5a0e425e6e319b1978db1e9564f6af4228a567
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=x86_64 olddefconfig
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202304291444.8Uqp9A2n-lkp@intel.com/

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
   vmlinux.o: warning: objtool: mwait_idle+0x6: call to current_set_polling_and_test() leaves .noinstr.text section
   vmlinux.o: warning: objtool: acpi_processor_ffh_cstate_enter+0x24: call to current_set_polling_and_test() leaves .noinstr.text section
   vmlinux.o: warning: objtool: cpu_idle_poll.isra.0+0x7f: call to test_ti_thread_flag.constprop.0() leaves .noinstr.text section
   vmlinux.o: warning: objtool: intel_idle+0x35: call to current_set_polling_and_test() leaves .noinstr.text section
   vmlinux.o: warning: objtool: intel_idle_s2idle+0x3b: call to current_set_polling_and_test() leaves .noinstr.text section
   vmlinux.o: warning: objtool: intel_idle_xstate+0x11: call to fpu_idle_fpregs() leaves .noinstr.text section
>> vmlinux.o: warning: objtool: intel_idle_ibrs+0x12: call to sched_smt_active() leaves .noinstr.text section
   vmlinux.o: warning: objtool: intel_idle_irq+0x36: call to current_set_polling_and_test() leaves .noinstr.text section
   vmlinux.o: warning: objtool: acpi_safe_halt+0x8: call to test_ti_thread_flag.constprop.0() leaves .noinstr.text section
   vmlinux.o: warning: objtool: io_idle+0x3: call to __inb.isra.0() leaves .noinstr.text section
>> vmlinux.o: warning: objtool: acpi_idle_enter_s2idle+0x53: call to ftrace_likely_update() leaves .noinstr.text section
>> vmlinux.o: warning: objtool: acpi_idle_enter+0x4c: call to ftrace_likely_update() leaves .noinstr.text section


objdump-func vmlinux.o intel_idle_ibrs:
0000 000000000000047d <intel_idle_ibrs>:
0000  47d:	f3 0f 1e fa          	endbr64
0004  481:	41 56                	push   %r14
0006  483:	49 89 f6             	mov    %rsi,%r14
0009  486:	41 55                	push   %r13
000b  488:	41 54                	push   %r12
000d  48a:	41 89 d4             	mov    %edx,%r12d
0010  48d:	55                   	push   %rbp
0011  48e:	53                   	push   %rbx
0012  48f:	e8 00 00 00 00       	call   494 <intel_idle_ibrs+0x17>	490: R_X86_64_PC32	.text+0x9cb97d
0017  494:	89 c5                	mov    %eax,%ebp
0019  496:	e8 00 00 00 00       	call   49b <intel_idle_ibrs+0x1e>	497: R_X86_64_PLT32	spec_ctrl_current-0x4
001e  49b:	49 89 c5             	mov    %rax,%r13
0021  49e:	40 84 ed             	test   %bpl,%bpl
0024  4a1:	74 0c                	je     4af <intel_idle_ibrs+0x32>
0026  4a3:	31 f6                	xor    %esi,%esi
0028  4a5:	bf 48 00 00 00       	mov    $0x48,%edi
002d  4aa:	e8 00 00 00 00       	call   4af <intel_idle_ibrs+0x32>	4ab: R_X86_64_PC32	.text+0x9cb9a3
0032  4af:	49 63 dc             	movslq %r12d,%rbx
0035  4b2:	48 83 fb 0a          	cmp    $0xa,%rbx
0039  4b6:	76 0f                	jbe    4c7 <intel_idle_ibrs+0x4a>
003b  4b8:	48 89 de             	mov    %rbx,%rsi
003e  4bb:	48 c7 c7 00 00 00 00 	mov    $0x0,%rdi	4be: R_X86_64_32S	.data+0x8e65a0
0045  4c2:	e8 00 00 00 00       	call   4c7 <intel_idle_ibrs+0x4a>	4c3: R_X86_64_PLT32	__ubsan_handle_out_of_bounds-0x4
004a  4c7:	48 6b db 68          	imul   $0x68,%rbx,%rbx
004e  4cb:	41 8b 5c 1e 58       	mov    0x58(%r14,%rbx,1),%ebx
0053  4d0:	e9 00 00 00 00       	jmp    4d5 <intel_idle_ibrs+0x58>	4d1: R_X86_64_PC32	.altinstr_aux+0xda0
0058  4d5:	eb 09                	jmp    4e0 <intel_idle_ibrs+0x63>
005a  4d7:	e8 00 00 00 00       	call   4dc <intel_idle_ibrs+0x5f>	4d8: R_X86_64_PC32	.text+0x9cbb80
005f  4dc:	84 c0                	test   %al,%al
0061  4de:	75 5a                	jne    53a <intel_idle_ibrs+0xbd>
0063  4e0:	e9 00 00 00 00       	jmp    4e5 <intel_idle_ibrs+0x68>	4e1: R_X86_64_PC32	.altinstr_aux+0xdb2
0068  4e5:	0f ae f0             	mfence
006b  4e8:	48 8b 3c 25 00 00 00 00 	mov    0x0,%rdi	4ec: R_X86_64_32S	pcpu_hot
0073  4f0:	e8 00 00 00 00       	call   4f5 <intel_idle_ibrs+0x78>	4f1: R_X86_64_PC32	.text+0x9cb979
0078  4f5:	0f ae f0             	mfence
007b  4f8:	4c 8b 34 25 00 00 00 00 	mov    0x0,%r14	4fc: R_X86_64_32S	pcpu_hot
0083  500:	4c 89 f7             	mov    %r14,%rdi
0086  503:	e8 00 00 00 00       	call   508 <intel_idle_ibrs+0x8b>	504: R_X86_64_PC32	.text+0x9cbb0a
008b  508:	4c 89 f7             	mov    %r14,%rdi
008e  50b:	e8 00 00 00 00       	call   510 <intel_idle_ibrs+0x93>	50c: R_X86_64_PC32	.text+0x9cbb16
0093  510:	31 f6                	xor    %esi,%esi
0095  512:	48 c7 c7 00 00 00 00 	mov    $0x0,%rdi	515: R_X86_64_32S	_ftrace_annotated_branch+0xce2e0
009c  519:	85 c0                	test   %eax,%eax
009e  51b:	41 89 c6             	mov    %eax,%r14d
00a1  51e:	40 0f 95 c6          	setne  %sil
00a5  522:	31 c9                	xor    %ecx,%ecx
00a7  524:	31 d2                	xor    %edx,%edx
00a9  526:	e8 00 00 00 00       	call   52b <intel_idle_ibrs+0xae>	527: R_X86_64_PLT32	ftrace_likely_update-0x4
00ae  52b:	45 85 f6             	test   %r14d,%r14d
00b1  52e:	75 0a                	jne    53a <intel_idle_ibrs+0xbd>
00b3  530:	c1 eb 18             	shr    $0x18,%ebx
00b6  533:	89 df                	mov    %ebx,%edi
00b8  535:	e8 00 00 00 00       	call   53a <intel_idle_ibrs+0xbd>	536: R_X86_64_PC32	.text+0x9cbaf5
00bd  53a:	e8 00 00 00 00       	call   53f <intel_idle_ibrs+0xc2>	53b: R_X86_64_PC32	.text+0x9cbb4e
00c2  53f:	40 84 ed             	test   %bpl,%bpl
00c5  542:	74 0d                	je     551 <intel_idle_ibrs+0xd4>
00c7  544:	4c 89 ee             	mov    %r13,%rsi
00ca  547:	bf 48 00 00 00       	mov    $0x48,%edi
00cf  54c:	e8 00 00 00 00       	call   551 <intel_idle_ibrs+0xd4>	54d: R_X86_64_PC32	.text+0x9cb9a3
00d4  551:	5b                   	pop    %rbx
00d5  552:	44 89 e0             	mov    %r12d,%eax
00d8  555:	5d                   	pop    %rbp
00d9  556:	41 5c                	pop    %r12
00db  558:	41 5d                	pop    %r13
00dd  55a:	41 5e                	pop    %r14
00df  55c:	c3                   	ret

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
