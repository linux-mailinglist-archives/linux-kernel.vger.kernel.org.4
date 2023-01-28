Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1291067F908
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Jan 2023 16:20:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232424AbjA1PUy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Jan 2023 10:20:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229619AbjA1PUv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Jan 2023 10:20:51 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 719493EFD7
        for <linux-kernel@vger.kernel.org>; Sat, 28 Jan 2023 07:20:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674919244; x=1706455244;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=MTadVaHuNSrAWek3uXcZTKVCMsw+1O+SvEEAAMoi1tI=;
  b=WN2OHnT/4n99/Zetkpm7ULPgLJfCCqzfl+VVqazMgMPxMN3lZHalOUA0
   9aoc5PW7LOr0Sjo3iEzemBRuLDvuFJ4IX+T1/lmIlZdOklxiMGNIr80c/
   dE0QtoJybethO6B0CTdmNMbc/wKlCQ04NlMtIG5jqV3yIuV9pENUHq1l3
   /8tjSE5K1POfw/App3/NJXy+6GLVyFmR+QF2/9nQ+PsjiRXeYeSYgqqZe
   a/jMyBbbztXpIas7I5dxMoZsxblqDJfBNDsojBY+ZagFW3EmTBtMV0pbz
   CYf8+y8FyLQA34IAk33rvWaTMkOaoiN0wnYiWb1R+C3hLB31Hzd4U+CSi
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10604"; a="324992081"
X-IronPort-AV: E=Sophos;i="5.97,254,1669104000"; 
   d="scan'208";a="324992081"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2023 07:20:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10604"; a="665580238"
X-IronPort-AV: E=Sophos;i="5.97,254,1669104000"; 
   d="scan'208";a="665580238"
Received: from lkp-server01.sh.intel.com (HELO ffa7f14d1d0f) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 28 Jan 2023 07:20:38 -0800
Received: from kbuild by ffa7f14d1d0f with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pLn0P-0000q9-27;
        Sat, 28 Jan 2023 15:20:37 +0000
Date:   Sat, 28 Jan 2023 23:19:53 +0800
From:   kernel test robot <lkp@intel.com>
To:     Waiman Long <longman@redhat.com>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Will Deacon <will@kernel.org>
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        Phil Auld <pauld@redhat.com>, linux-kernel@vger.kernel.org,
        Waiman Long <longman@redhat.com>
Subject: Re: [PATCH v3] sched: Store restrict_cpus_allowed_ptr() call state
Message-ID: <202301282334.C5NLDEZd-lkp@intel.com>
References: <20230127015527.466367-1-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230127015527.466367-1-longman@redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Waiman,

I love your patch! Yet something to improve:

[auto build test ERROR on tip/sched/core]
[also build test ERROR on tip/master tip/auto-latest linux/master linus/master v6.2-rc5 next-20230127]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Waiman-Long/sched-Store-restrict_cpus_allowed_ptr-call-state/20230128-155441
patch link:    https://lore.kernel.org/r/20230127015527.466367-1-longman%40redhat.com
patch subject: [PATCH v3] sched: Store restrict_cpus_allowed_ptr() call state
config: hexagon-randconfig-r041-20230124 (https://download.01.org/0day-ci/archive/20230128/202301282334.C5NLDEZd-lkp@intel.com/config)
compiler: clang version 16.0.0 (https://github.com/llvm/llvm-project 4196ca3278f78c6e19246e54ab0ecb364e37d66a)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/25582b263f75c0348a967ce5da36c1f87fd5d175
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Waiman-Long/sched-Store-restrict_cpus_allowed_ptr-call-state/20230128-155441
        git checkout 25582b263f75c0348a967ce5da36c1f87fd5d175
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=hexagon olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=hexagon SHELL=/bin/bash kernel/bpf/ kernel/sched/ net/core/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from kernel/sched/core.c:9:
   In file included from include/linux/highmem.h:12:
   In file included from include/linux/hardirq.h:11:
   In file included from ./arch/hexagon/include/generated/asm/hardirq.h:1:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/hexagon/include/asm/io.h:334:
   include/asm-generic/io.h:547:31: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           val = __raw_readb(PCI_IOBASE + addr);
                             ~~~~~~~~~~ ^
   include/asm-generic/io.h:560:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           val = __le16_to_cpu((__le16 __force)__raw_readw(PCI_IOBASE + addr));
                                                           ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/little_endian.h:37:51: note: expanded from macro '__le16_to_cpu'
   #define __le16_to_cpu(x) ((__force __u16)(__le16)(x))
                                                     ^
   In file included from kernel/sched/core.c:9:
   In file included from include/linux/highmem.h:12:
   In file included from include/linux/hardirq.h:11:
   In file included from ./arch/hexagon/include/generated/asm/hardirq.h:1:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/hexagon/include/asm/io.h:334:
   include/asm-generic/io.h:573:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           val = __le32_to_cpu((__le32 __force)__raw_readl(PCI_IOBASE + addr));
                                                           ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/little_endian.h:35:51: note: expanded from macro '__le32_to_cpu'
   #define __le32_to_cpu(x) ((__force __u32)(__le32)(x))
                                                     ^
   In file included from kernel/sched/core.c:9:
   In file included from include/linux/highmem.h:12:
   In file included from include/linux/hardirq.h:11:
   In file included from ./arch/hexagon/include/generated/asm/hardirq.h:1:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/hexagon/include/asm/io.h:334:
   include/asm-generic/io.h:584:33: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           __raw_writeb(value, PCI_IOBASE + addr);
                               ~~~~~~~~~~ ^
   include/asm-generic/io.h:594:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           __raw_writew((u16 __force)cpu_to_le16(value), PCI_IOBASE + addr);
                                                         ~~~~~~~~~~ ^
   include/asm-generic/io.h:604:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           __raw_writel((u32 __force)cpu_to_le32(value), PCI_IOBASE + addr);
                                                         ~~~~~~~~~~ ^
>> kernel/sched/core.c:3021:9: error: no member named 'user_cpu_ptr' in 'struct task_struct'; did you mean 'user_cpus_ptr'?
           if (p->user_cpu_ptr &&
                  ^~~~~~~~~~~~
                  user_cpus_ptr
   include/linux/sched.h:830:15: note: 'user_cpus_ptr' declared here
           cpumask_t                       *user_cpus_ptr;
                                            ^
   kernel/sched/core.c:3022:32: error: no member named 'user_cpu_ptr' in 'struct task_struct'; did you mean 'user_cpus_ptr'?
               !cpumask_and(new_mask, p->user_cpu_ptr, subset_mask)) {
                                         ^~~~~~~~~~~~
                                         user_cpus_ptr
   include/linux/sched.h:830:15: note: 'user_cpus_ptr' declared here
           cpumask_t                       *user_cpus_ptr;
                                            ^
>> kernel/sched/core.c:3091:33: error: expected '}'
                   .new_mask  = cpu_possible_mask;
                                                 ^
   kernel/sched/core.c:3090:31: note: to match this '{'
           struct affinity_context ac = {
                                        ^
>> kernel/sched/core.c:3092:3: error: expected expression
                   .flags     = SCA_CLR_RESTRICT,
                   ^
>> kernel/sched/core.c:3097:2: error: expected identifier or '('
           if (!data_race(p->cpus_allowed_restricted))
           ^
>> kernel/sched/core.c:3104:2: error: type specifier missing, defaults to 'int'; ISO C99 and later do not support implicit int [-Wimplicit-int]
           ret = __sched_setaffinity(p, &ac);
           ^
           int
>> kernel/sched/core.c:3104:28: error: use of undeclared identifier 'p'
           ret = __sched_setaffinity(p, &ac);
                                     ^
>> kernel/sched/core.c:3104:32: error: use of undeclared identifier 'ac'
           ret = __sched_setaffinity(p, &ac);
                                         ^
   kernel/sched/core.c:3105:2: error: expected identifier or '('
           WARN_ON_ONCE(ret);
           ^
   include/asm-generic/bug.h:180:33: note: expanded from macro 'WARN_ON_ONCE'
   #define WARN_ON_ONCE(condition) WARN_ON(condition)
                                   ^
   include/asm-generic/bug.h:166:29: note: expanded from macro 'WARN_ON'
   #define WARN_ON(condition) ({                                           \
                               ^
>> kernel/sched/core.c:3105:2: error: expected ')'
   include/asm-generic/bug.h:180:33: note: expanded from macro 'WARN_ON_ONCE'
   #define WARN_ON_ONCE(condition) WARN_ON(condition)
                                   ^
   include/asm-generic/bug.h:166:29: note: expanded from macro 'WARN_ON'
   #define WARN_ON(condition) ({                                           \
                               ^
   kernel/sched/core.c:3105:2: note: to match this '('
   include/asm-generic/bug.h:180:33: note: expanded from macro 'WARN_ON_ONCE'
   #define WARN_ON_ONCE(condition) WARN_ON(condition)
                                   ^
   include/asm-generic/bug.h:166:28: note: expanded from macro 'WARN_ON'
   #define WARN_ON(condition) ({                                           \
                              ^
>> kernel/sched/core.c:3106:1: error: extraneous closing brace ('}')
   }
   ^
   6 warnings and 11 errors generated.


vim +3021 kernel/sched/core.c

  2986	
  2987	/*
  2988	 * Change a given task's CPU affinity to the intersection of its current
  2989	 * affinity mask and @subset_mask, writing the resulting mask to @new_mask.
  2990	 * The cpus_allowed_restricted bit is set to indicate to a later
  2991	 * relax_compatible_cpus_allowed_ptr() call to relax the cpumask.
  2992	 *
  2993	 * If the resulting mask is empty, leave the affinity unchanged and return
  2994	 * -EINVAL.
  2995	 */
  2996	static int restrict_cpus_allowed_ptr(struct task_struct *p,
  2997					     struct cpumask *new_mask,
  2998					     const struct cpumask *subset_mask)
  2999	{
  3000		struct affinity_context ac = {
  3001			.new_mask  = new_mask,
  3002			.flags     = 0,
  3003		};
  3004		struct rq_flags rf;
  3005		struct rq *rq;
  3006		int err;
  3007	
  3008		rq = task_rq_lock(p, &rf);
  3009		p->cpus_allowed_restricted = 1;
  3010	
  3011		/*
  3012		 * Forcefully restricting the affinity of a deadline task is
  3013		 * likely to cause problems, so fail and noisily override the
  3014		 * mask entirely.
  3015		 */
  3016		if (task_has_dl_policy(p) && dl_bandwidth_enabled()) {
  3017			err = -EPERM;
  3018			goto err_unlock;
  3019		}
  3020	
> 3021		if (p->user_cpu_ptr &&
> 3022		    !cpumask_and(new_mask, p->user_cpu_ptr, subset_mask)) {
  3023			err = -EINVAL;
  3024			goto err_unlock;
  3025		}
  3026	
  3027		return __set_cpus_allowed_ptr_locked(p, &ac, rq, &rf);
  3028	
  3029	err_unlock:
  3030		task_rq_unlock(rq, p, &rf);
  3031		return err;
  3032	}
  3033	
  3034	/*
  3035	 * Restrict the CPU affinity of task @p so that it is a subset of
  3036	 * task_cpu_possible_mask(). If the resulting mask is empty, we warn
  3037	 * and walk up the cpuset hierarchy until we find a suitable mask.
  3038	 */
  3039	void force_compatible_cpus_allowed_ptr(struct task_struct *p)
  3040	{
  3041		cpumask_var_t new_mask;
  3042		const struct cpumask *override_mask = task_cpu_possible_mask(p);
  3043	
  3044		alloc_cpumask_var(&new_mask, GFP_KERNEL);
  3045	
  3046		/*
  3047		 * __migrate_task() can fail silently in the face of concurrent
  3048		 * offlining of the chosen destination CPU, so take the hotplug
  3049		 * lock to ensure that the migration succeeds.
  3050		 */
  3051		cpus_read_lock();
  3052		if (!cpumask_available(new_mask))
  3053			goto out_set_mask;
  3054	
  3055		if (!restrict_cpus_allowed_ptr(p, new_mask, override_mask))
  3056			goto out_free_mask;
  3057	
  3058		/*
  3059		 * We failed to find a valid subset of the affinity mask for the
  3060		 * task, so override it based on its cpuset hierarchy.
  3061		 */
  3062		cpuset_cpus_allowed(p, new_mask);
  3063		override_mask = new_mask;
  3064	
  3065	out_set_mask:
  3066		if (printk_ratelimit()) {
  3067			printk_deferred("Overriding affinity for process %d (%s) to CPUs %*pbl\n",
  3068					task_pid_nr(p), p->comm,
  3069					cpumask_pr_args(override_mask));
  3070		}
  3071	
  3072		WARN_ON(set_cpus_allowed_ptr(p, override_mask));
  3073	out_free_mask:
  3074		cpus_read_unlock();
  3075		free_cpumask_var(new_mask);
  3076	}
  3077	
  3078	static int
  3079	__sched_setaffinity(struct task_struct *p, struct affinity_context *ctx);
  3080	
  3081	/*
  3082	 * Restore the affinity of a task @p which was previously restricted by a
  3083	 * call to force_compatible_cpus_allowed_ptr().
  3084	 *
  3085	 * It is the caller's responsibility to serialise this with any calls to
  3086	 * force_compatible_cpus_allowed_ptr(@p).
  3087	 */
  3088	void relax_compatible_cpus_allowed_ptr(struct task_struct *p)
  3089	{
> 3090		struct affinity_context ac = {
> 3091			.new_mask  = cpu_possible_mask;
> 3092			.flags     = SCA_CLR_RESTRICT,
  3093		};
  3094		int ret;
  3095	
  3096		/* Return if no previous force_compatible_cpus_allowed_ptr() call */
> 3097		if (!data_race(p->cpus_allowed_restricted))
  3098			return;
  3099	
  3100		/*
  3101		 * Try to restore the old affinity mask with __sched_setaffinity().
  3102		 * Cpuset masking will be done there too.
  3103		 */
> 3104		ret = __sched_setaffinity(p, &ac);
> 3105		WARN_ON_ONCE(ret);
> 3106	}
  3107	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
