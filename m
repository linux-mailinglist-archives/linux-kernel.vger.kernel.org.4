Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D61C69C45C
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Feb 2023 04:06:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229652AbjBTDGB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Feb 2023 22:06:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbjBTDF7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Feb 2023 22:05:59 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6D6B8A5B
        for <linux-kernel@vger.kernel.org>; Sun, 19 Feb 2023 19:05:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676862357; x=1708398357;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=RM4eXjQHbqlzn7GyqU4NeWYxcc4BEN6iCP/UFyCc9iI=;
  b=oABIKNxEhkrRewfSscsGQOtxjM/KOHIjW2g243IGM1W4NLEspWb+RJRm
   /WXmgA3F8i3QkNm4kOQSFeHpOE4Ukq3CRtgP+3EUKPKOl+qu90XPbUizD
   sXwz3a+3EYz1DSgYI50tv/BEGqYWdeqSUkJcz1svuPwBPGWwYlZNMM2jU
   KqWP2AEA7WgsYp3zRbzRc1DF7oGB0xL5uAPdCg2SQmWKtT+w+Tl4BL/6+
   33Jyod7JBhMl6lmy4Dm9R1weluU0ksNsqBBIcRXsShj8tBWm3YakOsVye
   5704OYfFLTvUiczRVhLv/zkmtZ7TzbYJs4oEuRlcF6P3TDTLIj0ea8UoY
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10626"; a="394793919"
X-IronPort-AV: E=Sophos;i="5.97,311,1669104000"; 
   d="scan'208";a="394793919"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2023 19:05:57 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10626"; a="701529419"
X-IronPort-AV: E=Sophos;i="5.97,311,1669104000"; 
   d="scan'208";a="701529419"
Received: from lkp-server01.sh.intel.com (HELO 4455601a8d94) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 19 Feb 2023 19:05:56 -0800
Received: from kbuild by 4455601a8d94 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pTwV1-000Dbd-0s;
        Mon, 20 Feb 2023 03:05:55 +0000
Date:   Mon, 20 Feb 2023 11:05:21 +0800
From:   kernel test robot <lkp@intel.com>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Nicolas Saenz Julienne <nsaenzju@redhat.com>
Subject: vmlinux.o: warning: objtool: ct_idle_enter+0x14: call to
 ftrace_likely_update() leaves .noinstr.text section
Message-ID: <202302201112.den9cybf-lkp@intel.com>
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
commit: c33ef43a359001415032665dfcd433979c462b71 rcu/context-tracking: Remove unused and/or unecessary middle functions
date:   8 months ago
config: x86_64-randconfig-a001-20230220 (https://download.01.org/0day-ci/archive/20230220/202302201112.den9cybf-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-8) 11.3.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=c33ef43a359001415032665dfcd433979c462b71
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout c33ef43a359001415032665dfcd433979c462b71
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=x86_64 olddefconfig
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202302201112.den9cybf-lkp@intel.com/

All warnings (new ones prefixed by >>):

   ld: warning: net/bpfilter/bpfilter_umh_blob.o: missing .note.GNU-stack section implies executable stack
   ld: NOTE: This behaviour is deprecated and will be removed in a future version of the linker
   vmlinux.o: warning: objtool: __rdgsbase_inactive+0x34: call to ftrace_likely_update() leaves .noinstr.text section
   vmlinux.o: warning: objtool: __wrgsbase_inactive+0x39: call to ftrace_likely_update() leaves .noinstr.text section
   vmlinux.o: warning: objtool: fixup_bad_iret+0x89: call to ftrace_likely_update() leaves .noinstr.text section
   vmlinux.o: warning: objtool: noist_exc_debug+0x50: call to ftrace_likely_update() leaves .noinstr.text section
   vmlinux.o: warning: objtool: exc_nmi+0x35: call to ftrace_likely_update() leaves .noinstr.text section
   vmlinux.o: warning: objtool: poke_int3_handler+0x4b: call to ftrace_likely_update() leaves .noinstr.text section
   vmlinux.o: warning: objtool: irqentry_nmi_enter+0x4c: call to ftrace_likely_update() leaves .noinstr.text section
   vmlinux.o: warning: objtool: irqentry_nmi_exit+0x53: call to ftrace_likely_update() leaves .noinstr.text section
   vmlinux.o: warning: objtool: enter_from_user_mode+0x5b: call to ftrace_likely_update() leaves .noinstr.text section
   vmlinux.o: warning: objtool: syscall_enter_from_user_mode+0x60: call to ftrace_likely_update() leaves .noinstr.text section
   vmlinux.o: warning: objtool: syscall_enter_from_user_mode_prepare+0x5b: call to ftrace_likely_update() leaves .noinstr.text section
   vmlinux.o: warning: objtool: irqentry_enter_from_user_mode+0x5b: call to ftrace_likely_update() leaves .noinstr.text section
   vmlinux.o: warning: objtool: irqentry_exit+0x40: call to ftrace_likely_update() leaves .noinstr.text section
   vmlinux.o: warning: objtool: rcu_dynticks_eqs_enter+0x28: call to ftrace_likely_update() leaves .noinstr.text section
   vmlinux.o: warning: objtool: rcu_dynticks_eqs_exit+0x28: call to ftrace_likely_update() leaves .noinstr.text section
   vmlinux.o: warning: objtool: rcu_eqs_exit.constprop.0+0x26: call to ftrace_likely_update() leaves .noinstr.text section
   vmlinux.o: warning: objtool: rcu_eqs_enter.constprop.0+0x3d: call to ftrace_likely_update() leaves .noinstr.text section
>> vmlinux.o: warning: objtool: ct_idle_enter+0x14: call to ftrace_likely_update() leaves .noinstr.text section
>> vmlinux.o: warning: objtool: ct_nmi_enter+0x36: call to ftrace_likely_update() leaves .noinstr.text section
   vmlinux.o: warning: objtool: ct_irq_enter+0x38: call to ftrace_likely_update() leaves .noinstr.text section
   vmlinux.o: warning: objtool: ct_irq_exit+0x38: call to ftrace_likely_update() leaves .noinstr.text section


objdump-func vmlinux.o ct_idle_enter:
0000 000000000000325e <ct_idle_enter>:
0000     325e:	f3 0f 1e fa          	endbr64
0004     3262:	31 d2                	xor    %edx,%edx
0006     3264:	31 f6                	xor    %esi,%esi
0008     3266:	b9 01 00 00 00       	mov    $0x1,%ecx
000d     326b:	48 c7 c7 00 00 00 00 	mov    $0x0,%rdi	326e: R_X86_64_32S	_ftrace_annotated_branch+0x54090
0014     3272:	e8 00 00 00 00       	call   3277 <ct_idle_enter+0x19>	3273: R_X86_64_PLT32	ftrace_likely_update-0x4
0019     3277:	b9 01 00 00 00       	mov    $0x1,%ecx
001e     327c:	31 d2                	xor    %edx,%edx
0020     327e:	31 f6                	xor    %esi,%esi
0022     3280:	48 c7 c7 00 00 00 00 	mov    $0x0,%rdi	3283: R_X86_64_32S	_ftrace_annotated_branch+0x54060
0029     3287:	e8 00 00 00 00       	call   328c <ct_idle_enter+0x2e>	3288: R_X86_64_PLT32	ftrace_likely_update-0x4
002e     328c:	e9 44 fe ff ff       	jmp    30d5 <rcu_eqs_enter.constprop.0>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
