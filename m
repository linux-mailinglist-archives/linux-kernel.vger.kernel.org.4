Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F02A667908A
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 06:58:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232873AbjAXF6S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 00:58:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232608AbjAXF6Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 00:58:16 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 522361449F
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 21:57:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674539871; x=1706075871;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=BWXT55pgTN05p8rmoGRsHN/Pu5yqlCqCpxTEG344HI0=;
  b=d5oqGGDp9U5MdVQvm60OROIdop46wZ8GD/isgF+l94axcbn2BGBk8M9k
   UgR9AyL1YbmX9QLbMA9c4MwuaYZAr7oLQo6R+Dd9YBsu3P9Bk25l0XY7N
   Xmk6xMbxUbmG5PftTqLqhTPySrFjIKFRjOdMus35LIiSj6OJDOb8YiqbO
   CgrhAqtslOHM8EELCSfGhoPOYtyUZv0pr0XBg+dZrV8al0Aw8F9pM/X9p
   qTC6jRyKEtHuRRLpyb1nVRAKrPV0vTvjaV4WTcEJZY+7FD3aVLMEt0mpo
   cNdf65OuBuJ2AbsP3QuDIU83KYxq1M52hn+xHQwz8VOgPSDYNkgWgClc5
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10599"; a="305896710"
X-IronPort-AV: E=Sophos;i="5.97,241,1669104000"; 
   d="scan'208";a="305896710"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2023 21:57:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10599"; a="662001918"
X-IronPort-AV: E=Sophos;i="5.97,241,1669104000"; 
   d="scan'208";a="662001918"
Received: from lkp-server01.sh.intel.com (HELO 5646d64e7320) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 23 Jan 2023 21:57:42 -0800
Received: from kbuild by 5646d64e7320 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pKCJR-0006BK-1d;
        Tue, 24 Jan 2023 05:57:41 +0000
Date:   Tue, 24 Jan 2023 13:57:28 +0800
From:   kernel test robot <lkp@intel.com>
To:     George Prekas <george@enfabrica.net>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        Catalin Marinas <catalin.marinas@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Christoph Lameter <cl@linux-foundation.org>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Andrei Vagin <avagin@gmail.com>,
        George Prekas <george@enfabrica.net>
Subject: Re: [PATCH 1/9] mm: kmemleak: properly disable task stack scanning
Message-ID: <202301241309.4F6LhLvK-lkp@intel.com>
References: <20230123170419.7292-2-george@enfabrica.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230123170419.7292-2-george@enfabrica.net>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi George,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on vbabka-slab/for-next]
[also build test ERROR on linus/master v6.2-rc5]
[cannot apply to akpm-mm/mm-everything]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/George-Prekas/mm-kmemleak-properly-disable-task-stack-scanning/20230124-010911
base:   git://git.kernel.org/pub/scm/linux/kernel/git/vbabka/slab.git for-next
patch link:    https://lore.kernel.org/r/20230123170419.7292-2-george%40enfabrica.net
patch subject: [PATCH 1/9] mm: kmemleak: properly disable task stack scanning
config: riscv-randconfig-r042-20230123 (https://download.01.org/0day-ci/archive/20230124/202301241309.4F6LhLvK-lkp@intel.com/config)
compiler: clang version 16.0.0 (https://github.com/llvm/llvm-project 4196ca3278f78c6e19246e54ab0ecb364e37d66a)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install riscv cross compiling tool for clang build
        # apt-get install binutils-riscv64-linux-gnu
        # https://github.com/intel-lab-lkp/linux/commit/f0d9df4305849ecea4402bc614cadb0dd357da77
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review George-Prekas/mm-kmemleak-properly-disable-task-stack-scanning/20230124-010911
        git checkout f0d9df4305849ecea4402bc614cadb0dd357da77
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=riscv olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=riscv SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   kernel/fork.c:163:13: warning: no previous prototype for function 'arch_release_task_struct' [-Wmissing-prototypes]
   void __weak arch_release_task_struct(struct task_struct *tsk)
               ^
   kernel/fork.c:163:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void __weak arch_release_task_struct(struct task_struct *tsk)
   ^
   static 
>> kernel/fork.c:320:2: error: call to undeclared function 'kmemleak_mark_stack'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
           kmemleak_mark_stack(stack);
           ^
   kernel/fork.c:865:20: warning: no previous prototype for function 'arch_task_cache_init' [-Wmissing-prototypes]
   void __init __weak arch_task_cache_init(void) { }
                      ^
   kernel/fork.c:865:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void __init __weak arch_task_cache_init(void) { }
   ^
   static 
   2 warnings and 1 error generated.


vim +/kmemleak_mark_stack +320 kernel/fork.c

   274	
   275	static int alloc_thread_stack_node(struct task_struct *tsk, int node)
   276	{
   277		struct vm_struct *vm;
   278		void *stack;
   279		int i;
   280	
   281		for (i = 0; i < NR_CACHED_STACKS; i++) {
   282			struct vm_struct *s;
   283	
   284			s = this_cpu_xchg(cached_stacks[i], NULL);
   285	
   286			if (!s)
   287				continue;
   288	
   289			/* Reset stack metadata. */
   290			kasan_unpoison_range(s->addr, THREAD_SIZE);
   291	
   292			stack = kasan_reset_tag(s->addr);
   293	
   294			/* Clear stale pointers from reused stack. */
   295			memset(stack, 0, THREAD_SIZE);
   296	
   297			if (memcg_charge_kernel_stack(s)) {
   298				vfree(s->addr);
   299				return -ENOMEM;
   300			}
   301	
   302			tsk->stack_vm_area = s;
   303			tsk->stack = stack;
   304			return 0;
   305		}
   306	
   307		/*
   308		 * Allocated stacks are cached and later reused by new threads,
   309		 * so memcg accounting is performed manually on assigning/releasing
   310		 * stacks to tasks. Drop __GFP_ACCOUNT.
   311		 */
   312		stack = __vmalloc_node_range(THREAD_SIZE, THREAD_ALIGN,
   313					     VMALLOC_START, VMALLOC_END,
   314					     THREADINFO_GFP & ~__GFP_ACCOUNT,
   315					     PAGE_KERNEL,
   316					     0, node, __builtin_return_address(0));
   317		if (!stack)
   318			return -ENOMEM;
   319	
 > 320		kmemleak_mark_stack(stack);
   321	
   322		vm = find_vm_area(stack);
   323		if (memcg_charge_kernel_stack(vm)) {
   324			vfree(stack);
   325			return -ENOMEM;
   326		}
   327		/*
   328		 * We can't call find_vm_area() in interrupt context, and
   329		 * free_thread_stack() can be called in interrupt context,
   330		 * so cache the vm_struct.
   331		 */
   332		tsk->stack_vm_area = vm;
   333		stack = kasan_reset_tag(stack);
   334		tsk->stack = stack;
   335		return 0;
   336	}
   337	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
