Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B046B678CEE
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 01:40:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231506AbjAXAkq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 19:40:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229589AbjAXAko (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 19:40:44 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3E7F1557B
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 16:40:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674520843; x=1706056843;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=v17R3QyYZCP4T22EmjJYvFeZBPZM3Q8P3+3lMWzi8To=;
  b=gTLhFSZTdzua/9K0wb82hu5jgcjJTa6PfJIB0XIQ+scbdYiNbdPJRzEN
   dXZP/dUSIlIpJscN8KK82UIsUxYBgcBLI5jPDxHAxocdBOFE5ko5SWbFF
   I0m3IB942OgZiXKxQeBmDvB/69X9UUeOWpxoHugf9zmrf5pLuj0fqj6as
   +D7upHgo9ajvJKvxIwUAHwtbcNnhfb0uweLpXzMIag/gzPBOgO/FHfHAs
   6PwJyysgXBrLg+NZnPx/03CxQKBL+1u4i1KLFqcb8X8JEPNE1MqDn7JGP
   wMCkDEpNYxOa1VdIEWRiFcZyJHlapFxZ4vGM54U4cqi8tbT15NVoR272t
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10599"; a="326234810"
X-IronPort-AV: E=Sophos;i="5.97,240,1669104000"; 
   d="scan'208";a="326234810"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2023 16:40:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10599"; a="692428776"
X-IronPort-AV: E=Sophos;i="5.97,240,1669104000"; 
   d="scan'208";a="692428776"
Received: from lkp-server01.sh.intel.com (HELO 5646d64e7320) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 23 Jan 2023 16:40:29 -0800
Received: from kbuild by 5646d64e7320 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pK7MS-0005zE-2E;
        Tue, 24 Jan 2023 00:40:28 +0000
Date:   Tue, 24 Jan 2023 08:39:40 +0800
From:   kernel test robot <lkp@intel.com>
To:     George Prekas <george@enfabrica.net>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Cc:     oe-kbuild-all@lists.linux.dev,
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
Message-ID: <202301240827.j2GJi7v5-lkp@intel.com>
References: <20230123170419.7292-2-george@enfabrica.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230123170419.7292-2-george@enfabrica.net>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi George,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on vbabka-slab/for-next]
[also build test ERROR on linus/master v6.2-rc5 next-20230123]
[cannot apply to akpm-mm/mm-everything]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/George-Prekas/mm-kmemleak-properly-disable-task-stack-scanning/20230124-010911
base:   git://git.kernel.org/pub/scm/linux/kernel/git/vbabka/slab.git for-next
patch link:    https://lore.kernel.org/r/20230123170419.7292-2-george%40enfabrica.net
patch subject: [PATCH 1/9] mm: kmemleak: properly disable task stack scanning
config: s390-defconfig (https://download.01.org/0day-ci/archive/20230124/202301240827.j2GJi7v5-lkp@intel.com/config)
compiler: s390-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/f0d9df4305849ecea4402bc614cadb0dd357da77
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review George-Prekas/mm-kmemleak-properly-disable-task-stack-scanning/20230124-010911
        git checkout f0d9df4305849ecea4402bc614cadb0dd357da77
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=s390 olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=s390 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   kernel/fork.c: In function 'alloc_thread_stack_node':
>> kernel/fork.c:320:9: error: implicit declaration of function 'kmemleak_mark_stack'; did you mean 'kmemleak_no_scan'? [-Werror=implicit-function-declaration]
     320 |         kmemleak_mark_stack(stack);
         |         ^~~~~~~~~~~~~~~~~~~
         |         kmemleak_no_scan
   kernel/fork.c: At top level:
   kernel/fork.c:865:20: warning: no previous prototype for 'arch_task_cache_init' [-Wmissing-prototypes]
     865 | void __init __weak arch_task_cache_init(void) { }
         |                    ^~~~~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors


vim +320 kernel/fork.c

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
