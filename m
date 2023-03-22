Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 763AC6C4143
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 04:47:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230231AbjCVDra (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 23:47:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230127AbjCVDrV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 23:47:21 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 538FC2F7B7;
        Tue, 21 Mar 2023 20:47:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679456840; x=1710992840;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=4Qx8FlvzNHHlgWRW4V7LLgEkErNpSgGrzQJdEa45mTk=;
  b=M+p9qe0SWSf9Flakv86O7FG7Q61VueZ+igdEIk4m7A8o0rcyEZuUy1v7
   HTh4ho4WpCo0/fJhOL5pMqxwB9aHLhwg908cq/KaiiuhnFtJGD8ASxOTp
   KfEmSa6oz8r04786Kiuka+NJRFS/q4O0ppExeuQYvzBLAvL300igD8mdq
   cWda//dvinj21OrWz9fhy70CJqdaZO1DvXGkIUeNNscwhDgdVtAhetQsW
   wQ5mgWLlEEsiSCTzHvunOj851L0zR6TCGhwyqq4WHfUGHDpoFAOpMnGFc
   ju2iXzXnL2iQACid4+cBMGA5XAny1PwExmFLWEw7B4qpQrt4pVm0pD5AV
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10656"; a="340655853"
X-IronPort-AV: E=Sophos;i="5.98,280,1673942400"; 
   d="scan'208";a="340655853"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2023 20:47:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10656"; a="825227596"
X-IronPort-AV: E=Sophos;i="5.98,280,1673942400"; 
   d="scan'208";a="825227596"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 21 Mar 2023 20:47:15 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pepRS-000Cpy-2M;
        Wed, 22 Mar 2023 03:47:14 +0000
Date:   Wed, 22 Mar 2023 11:47:05 +0800
From:   kernel test robot <lkp@intel.com>
To:     Steven Rostedt <rostedt@goodmis.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>
Cc:     oe-kbuild-all@lists.linux.dev,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Ross Zwisler <zwisler@google.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Miroslav Benes <mbenes@suse.cz>
Subject: Re: [PATCH] tracing: Trace instrumentation begin and end
Message-ID: <202303221157.uDnuxtAh-lkp@intel.com>
References: <20230321215121.71b339c5@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230321215121.71b339c5@gandalf.local.home>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Steven,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on linus/master]
[also build test ERROR on v6.3-rc3 next-20230321]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Steven-Rostedt/tracing-Trace-instrumentation-begin-and-end/20230322-095354
patch link:    https://lore.kernel.org/r/20230321215121.71b339c5%40gandalf.local.home
patch subject: [PATCH] tracing: Trace instrumentation begin and end
config: m68k-allyesconfig (https://download.01.org/0day-ci/archive/20230322/202303221157.uDnuxtAh-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/1f40755bb9b4817135459d6cf76fcbd17ffb53dd
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Steven-Rostedt/tracing-Trace-instrumentation-begin-and-end/20230322-095354
        git checkout 1f40755bb9b4817135459d6cf76fcbd17ffb53dd
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=m68k olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=m68k prepare

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202303221157.uDnuxtAh-lkp@intel.com/

All errors (new ones prefixed by >>):

   scripts/genksyms/parse.y: warning: 9 shift/reduce conflicts [-Wconflicts-sr]
   scripts/genksyms/parse.y: warning: 5 reduce/reduce conflicts [-Wconflicts-rr]
   scripts/genksyms/parse.y: note: rerun with option '-Wcounterexamples' to generate conflict counterexamples
   In file included from include/asm-generic/bug.h:6,
                    from arch/m68k/include/asm/bug.h:32,
                    from include/linux/bug.h:5,
                    from include/linux/thread_info.h:13,
                    from include/asm-generic/preempt.h:5,
                    from ./arch/m68k/include/generated/asm/preempt.h:1,
                    from include/linux/preempt.h:78,
                    from arch/m68k/include/asm/irqflags.h:6,
                    from include/linux/irqflags.h:16,
                    from arch/m68k/include/asm/atomic.h:6,
                    from include/linux/atomic.h:7,
                    from include/linux/rcupdate.h:25,
                    from include/linux/rculist.h:11,
                    from include/linux/pid.h:5,
                    from include/linux/sched.h:14,
                    from arch/m68k/kernel/asm-offsets.c:15:
   include/linux/thread_info.h: In function 'check_copy_size':
>> include/linux/instrumentation.h:87:65: error: '_THIS_IP_' undeclared (first use in this function)
      87 | # define instrumentation_begin() do_trace_instrumentation_begin(_THIS_IP_, _RET_IP_);
         |                                                                 ^~~~~~~~~
   include/asm-generic/bug.h:96:17: note: in expansion of macro 'instrumentation_begin'
      96 |                 instrumentation_begin();                                \
         |                 ^~~~~~~~~~~~~~~~~~~~~
   include/asm-generic/bug.h:94:33: note: in expansion of macro '__WARN_printf'
      94 | #define __WARN()                __WARN_printf(TAINT_WARN, NULL)
         |                                 ^~~~~~~~~~~~~
   include/asm-generic/bug.h:124:17: note: in expansion of macro '__WARN'
     124 |                 __WARN();                                               \
         |                 ^~~~~~
   include/linux/once_lite.h:31:25: note: in expansion of macro 'WARN_ON'
      31 |                         func(__VA_ARGS__);                              \
         |                         ^~~~
   include/asm-generic/bug.h:147:9: note: in expansion of macro 'DO_ONCE_LITE_IF'
     147 |         DO_ONCE_LITE_IF(condition, WARN_ON, 1)
         |         ^~~~~~~~~~~~~~~
   include/linux/thread_info.h:249:13: note: in expansion of macro 'WARN_ON_ONCE'
     249 |         if (WARN_ON_ONCE(bytes > INT_MAX))
         |             ^~~~~~~~~~~~
   include/linux/instrumentation.h:87:65: note: each undeclared identifier is reported only once for each function it appears in
      87 | # define instrumentation_begin() do_trace_instrumentation_begin(_THIS_IP_, _RET_IP_);
         |                                                                 ^~~~~~~~~
   include/asm-generic/bug.h:96:17: note: in expansion of macro 'instrumentation_begin'
      96 |                 instrumentation_begin();                                \
         |                 ^~~~~~~~~~~~~~~~~~~~~
   include/asm-generic/bug.h:94:33: note: in expansion of macro '__WARN_printf'
      94 | #define __WARN()                __WARN_printf(TAINT_WARN, NULL)
         |                                 ^~~~~~~~~~~~~
   include/asm-generic/bug.h:124:17: note: in expansion of macro '__WARN'
     124 |                 __WARN();                                               \
         |                 ^~~~~~
   include/linux/once_lite.h:31:25: note: in expansion of macro 'WARN_ON'
      31 |                         func(__VA_ARGS__);                              \
         |                         ^~~~
   include/asm-generic/bug.h:147:9: note: in expansion of macro 'DO_ONCE_LITE_IF'
     147 |         DO_ONCE_LITE_IF(condition, WARN_ON, 1)
         |         ^~~~~~~~~~~~~~~
   include/linux/thread_info.h:249:13: note: in expansion of macro 'WARN_ON_ONCE'
     249 |         if (WARN_ON_ONCE(bytes > INT_MAX))
         |             ^~~~~~~~~~~~
>> include/linux/instrumentation.h:87:76: error: '_RET_IP_' undeclared (first use in this function)
      87 | # define instrumentation_begin() do_trace_instrumentation_begin(_THIS_IP_, _RET_IP_);
         |                                                                            ^~~~~~~~
   include/asm-generic/bug.h:96:17: note: in expansion of macro 'instrumentation_begin'
      96 |                 instrumentation_begin();                                \
         |                 ^~~~~~~~~~~~~~~~~~~~~
   include/asm-generic/bug.h:94:33: note: in expansion of macro '__WARN_printf'
      94 | #define __WARN()                __WARN_printf(TAINT_WARN, NULL)
         |                                 ^~~~~~~~~~~~~
   include/asm-generic/bug.h:124:17: note: in expansion of macro '__WARN'
     124 |                 __WARN();                                               \
         |                 ^~~~~~
   include/linux/once_lite.h:31:25: note: in expansion of macro 'WARN_ON'
      31 |                         func(__VA_ARGS__);                              \
         |                         ^~~~
   include/asm-generic/bug.h:147:9: note: in expansion of macro 'DO_ONCE_LITE_IF'
     147 |         DO_ONCE_LITE_IF(condition, WARN_ON, 1)
         |         ^~~~~~~~~~~~~~~
   include/linux/thread_info.h:249:13: note: in expansion of macro 'WARN_ON_ONCE'
     249 |         if (WARN_ON_ONCE(bytes > INT_MAX))
         |             ^~~~~~~~~~~~
   make[2]: *** [scripts/Makefile.build:114: arch/m68k/kernel/asm-offsets.s] Error 1
   make[2]: Target 'prepare' not remade because of errors.
   make[1]: *** [Makefile:1286: prepare0] Error 2
   make[1]: Target 'prepare' not remade because of errors.
   make: *** [Makefile:226: __sub-make] Error 2
   make: Target 'prepare' not remade because of errors.


vim +/_THIS_IP_ +87 include/linux/instrumentation.h

    46	
    47	/*
    48	 * Because instrumentation_{begin,end}() can nest, objtool validation considers
    49	 * _begin() a +1 and _end() a -1 and computes a sum over the instructions.
    50	 * When the value is greater than 0, we consider instrumentation allowed.
    51	 *
    52	 * There is a problem with code like:
    53	 *
    54	 * noinstr void foo()
    55	 * {
    56	 *	instrumentation_begin();
    57	 *	...
    58	 *	if (cond) {
    59	 *		instrumentation_begin();
    60	 *		...
    61	 *		instrumentation_end();
    62	 *	}
    63	 *	bar();
    64	 *	instrumentation_end();
    65	 * }
    66	 *
    67	 * If instrumentation_end() would be an empty label, like all the other
    68	 * annotations, the inner _end(), which is at the end of a conditional block,
    69	 * would land on the instruction after the block.
    70	 *
    71	 * If we then consider the sum of the !cond path, we'll see that the call to
    72	 * bar() is with a 0-value, even though, we meant it to happen with a positive
    73	 * value.
    74	 *
    75	 * To avoid this, have _end() be a NOP instruction, this ensures it will be
    76	 * part of the condition block and does not escape.
    77	 */
    78	#define __instrumentation_end(c) ({					\
    79		do_trace_instrumentation_end(_THIS_IP_, _RET_IP_);		\
    80		asm volatile(__stringify(c) ": nop\n\t"				\
    81			     ".pushsection .discard.instr_end\n\t"		\
    82			     ".long " __stringify(c) "b - .\n\t"		\
    83			     ".popsection\n\t" : : "i" (c));			\
    84	})
    85	#define instrumentation_end() __instrumentation_end(__COUNTER__)
    86	#else /* !CONFIG_NOINSTR_VALIDATION */
  > 87	# define instrumentation_begin() do_trace_instrumentation_begin(_THIS_IP_, _RET_IP_);
    88	# define instrumentation_end()	 do_trace_instrumentation_end(_THIS_IP_, _RET_IP_);
    89	#endif /* CONFIG_NOINSTR_VALIDATION */
    90	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
