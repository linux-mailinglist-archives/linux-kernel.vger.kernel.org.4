Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA1FF69C3B8
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Feb 2023 01:48:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229663AbjBTAs5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Feb 2023 19:48:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjBTAsz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Feb 2023 19:48:55 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C41DBBDD5
        for <linux-kernel@vger.kernel.org>; Sun, 19 Feb 2023 16:48:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676854133; x=1708390133;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=uGFhoAHp4bpjaWcIfWdgGu88h+N13xAJQDxfIS8X998=;
  b=MKtNDihE4Hk3YIGHeYB2U1XhrOwjCFN+IG2amfSvXQ+McFREj6+w0yjp
   PQoeohIy2ahfSPJKFVLQcKYTLGggdLKFKRqXpSlVb0ij+oYbByRWSmULw
   nB1lBuJRlAeYqbi6uVUxsyUmc7ZWk8nQWAfpvb8Zw1V/dq080NdN9+G0N
   P/E+WVUkdhfnkQ00Pf9La7oQJK31Vtnqug9RpPgSvvbmhdCM1+eUtP51r
   AYBsS21rl71nELt+Z7APf9lWV39MLA8OWqOqte7BvyZkuTcqcx6cmd/mh
   dR2dLlzZpQE/0a7KWbV3B1kbV+V2hTsyRQ8U1/SkL/3X73iCmiy8LiBjp
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10626"; a="394781423"
X-IronPort-AV: E=Sophos;i="5.97,311,1669104000"; 
   d="scan'208";a="394781423"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2023 16:48:53 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10626"; a="701509734"
X-IronPort-AV: E=Sophos;i="5.97,311,1669104000"; 
   d="scan'208";a="701509734"
Received: from lkp-server01.sh.intel.com (HELO 4455601a8d94) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 19 Feb 2023 16:48:51 -0800
Received: from kbuild by 4455601a8d94 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pTuMN-000DWC-0B;
        Mon, 20 Feb 2023 00:48:51 +0000
Date:   Mon, 20 Feb 2023 08:48:24 +0800
From:   kernel test robot <lkp@intel.com>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Nicolas Saenz Julienne <nsaenzju@redhat.com>
Subject: vmlinux.o: warning: objtool: ct_irq_enter+0x38: call to
 ftrace_likely_update() leaves .noinstr.text section
Message-ID: <202302200852.lvnSFWXv-lkp@intel.com>
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

Hi Frederic,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   c9c3395d5e3dcc6daee66c6908354d47bf98cb0c
commit: 3864caafe7c66f01b188ffccb6a4215f3bf56292 rcu/context-tracking: Remove rcu_irq_enter/exit()
date:   8 months ago
config: x86_64-randconfig-a001-20230220 (https://download.01.org/0day-ci/archive/20230220/202302200852.lvnSFWXv-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-8) 11.3.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=3864caafe7c66f01b188ffccb6a4215f3bf56292
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 3864caafe7c66f01b188ffccb6a4215f3bf56292
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=x86_64 olddefconfig
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202302200852.lvnSFWXv-lkp@intel.com/

All warnings (new ones prefixed by >>):

   ld: warning: net/bpfilter/bpfilter_umh_blob.o: missing .note.GNU-stack section implies executable stack
   ld: NOTE: This behaviour is deprecated and will be removed in a future version of the linker
   vmlinux.o: warning: objtool: __rdgsbase_inactive+0x34: call to ftrace_likely_update() leaves .noinstr.text section
   vmlinux.o: warning: objtool: __wrgsbase_inactive+0x39: call to ftrace_likely_update() leaves .noinstr.text section
   vmlinux.o: warning: objtool: fixup_bad_iret+0x89: call to ftrace_likely_update() leaves .noinstr.text section
   vmlinux.o: warning: objtool: noist_exc_debug+0x50: call to ftrace_likely_update() leaves .noinstr.text section
   vmlinux.o: warning: objtool: exc_nmi+0x35: call to ftrace_likely_update() leaves .noinstr.text section
   vmlinux.o: warning: objtool: poke_int3_handler+0x4b: call to ftrace_likely_update() leaves .noinstr.text section
   vmlinux.o: warning: objtool: rcu_dynticks_eqs_enter+0x1a: call to ftrace_likely_update() leaves .noinstr.text section
   vmlinux.o: warning: objtool: rcu_dynticks_eqs_exit+0x1a: call to ftrace_likely_update() leaves .noinstr.text section
   vmlinux.o: warning: objtool: rcu_eqs_exit.constprop.0+0x1b: call to ftrace_likely_update() leaves .noinstr.text section
   vmlinux.o: warning: objtool: rcu_eqs_enter.constprop.0+0x3c: call to ftrace_likely_update() leaves .noinstr.text section
   vmlinux.o: warning: objtool: rcu_idle_enter+0x14: call to ftrace_likely_update() leaves .noinstr.text section
   vmlinux.o: warning: objtool: rcu_nmi_enter+0x35: call to ftrace_likely_update() leaves .noinstr.text section
   vmlinux.o: warning: objtool: irqentry_nmi_enter+0x4c: call to ftrace_likely_update() leaves .noinstr.text section
   vmlinux.o: warning: objtool: irqentry_nmi_exit+0x53: call to ftrace_likely_update() leaves .noinstr.text section
   vmlinux.o: warning: objtool: enter_from_user_mode+0x5b: call to ftrace_likely_update() leaves .noinstr.text section
   vmlinux.o: warning: objtool: syscall_enter_from_user_mode+0x60: call to ftrace_likely_update() leaves .noinstr.text section
   vmlinux.o: warning: objtool: syscall_enter_from_user_mode_prepare+0x5b: call to ftrace_likely_update() leaves .noinstr.text section
   vmlinux.o: warning: objtool: irqentry_enter_from_user_mode+0x5b: call to ftrace_likely_update() leaves .noinstr.text section
   vmlinux.o: warning: objtool: irqentry_exit+0x40: call to ftrace_likely_update() leaves .noinstr.text section
>> vmlinux.o: warning: objtool: ct_irq_enter+0x38: call to ftrace_likely_update() leaves .noinstr.text section
>> vmlinux.o: warning: objtool: ct_irq_exit+0x38: call to ftrace_likely_update() leaves .noinstr.text section


objdump-func vmlinux.o ct_irq_enter:
0000 00000000000034ca <ct_irq_enter>:
0000     34ca:	f3 0f 1e fa          	endbr64
0004     34ce:	55                   	push   %rbp
0005     34cf:	8b 2d 00 00 00 00    	mov    0x0(%rip),%ebp        # 34d5 <ct_irq_enter+0xb>	34d1: R_X86_64_PC32	debug_locks-0x4
000b     34d5:	85 ed                	test   %ebp,%ebp
000d     34d7:	74 1c                	je     34f5 <ct_irq_enter+0x2b>
000f     34d9:	65 8b 05 00 00 00 00 	mov    %gs:0x0(%rip),%eax        # 34e0 <ct_irq_enter+0x16>	34dc: R_X86_64_PC32	lockdep_recursion-0x4
0016     34e0:	31 ed                	xor    %ebp,%ebp
0018     34e2:	85 c0                	test   %eax,%eax
001a     34e4:	75 0f                	jne    34f5 <ct_irq_enter+0x2b>
001c     34e6:	65 8b 05 00 00 00 00 	mov    %gs:0x0(%rip),%eax        # 34ed <ct_irq_enter+0x23>	34e9: R_X86_64_PC32	hardirqs_enabled-0x4
0023     34ed:	31 ed                	xor    %ebp,%ebp
0025     34ef:	85 c0                	test   %eax,%eax
0027     34f1:	40 0f 95 c5          	setne  %bpl
002b     34f5:	31 c9                	xor    %ecx,%ecx
002d     34f7:	31 d2                	xor    %edx,%edx
002f     34f9:	89 ee                	mov    %ebp,%esi
0031     34fb:	48 c7 c7 00 00 00 00 	mov    $0x0,%rdi	34fe: R_X86_64_32S	_ftrace_annotated_branch+0x545d0
0038     3502:	e8 00 00 00 00       	call   3507 <ct_irq_enter+0x3d>	3503: R_X86_64_PLT32	ftrace_likely_update-0x4
003d     3507:	85 ed                	test   %ebp,%ebp
003f     3509:	74 04                	je     350f <ct_irq_enter+0x45>
0041     350b:	90                   	nop
0042     350c:	0f 0b                	ud2
0044     350e:	90                   	nop
0045     350f:	89 ee                	mov    %ebp,%esi
0047     3511:	31 c9                	xor    %ecx,%ecx
0049     3513:	31 d2                	xor    %edx,%edx
004b     3515:	48 c7 c7 00 00 00 00 	mov    $0x0,%rdi	3518: R_X86_64_32S	_ftrace_annotated_branch+0x545a0
0052     351c:	e8 00 00 00 00       	call   3521 <ct_irq_enter+0x57>	351d: R_X86_64_PLT32	ftrace_likely_update-0x4
0057     3521:	5d                   	pop    %rbp
0058     3522:	eb 9d                	jmp    34c1 <ct_nmi_enter>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
