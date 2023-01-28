Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 538F467F5BE
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Jan 2023 08:46:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233397AbjA1Hqi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Jan 2023 02:46:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229619AbjA1Hqh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Jan 2023 02:46:37 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD7F613D5E
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 23:46:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674891995; x=1706427995;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=z2XYMfIj1jdvBuGFknlCYVhV0le0R/9Zvjo9QIX6thc=;
  b=AQoIZ9qDjKuxwKoa2KdqkdJjehV5upsBlyGRHkX6Df50ao38tFa3/rbV
   eZul3uwf+hidSjG+Sr+zXI9yjhnZyw52WYh23vd0rT/3JR1jCTYNkR0ca
   U9KxsfvZESNDjFpsenccmcQ/n14QtFBxXeNKL3njf9d1dYuoqhTamj12f
   VwP7VmaWqPYVR/rh1i221wS7L/sXJ1xy4PjMf3izrPO8oBh3keDRunk+u
   cbNG3r08RdaHzyW0hE00mYM3+u0PkJ5iXJqSre/Bv0J2GkDAmnuL9uKCu
   KeBmGajVPEVfrBVUA7BZ7aqATqA3NhrAIbjlYsNmL6OehkNKxleSXnYr/
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10603"; a="327289364"
X-IronPort-AV: E=Sophos;i="5.97,253,1669104000"; 
   d="scan'208";a="327289364"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2023 23:46:34 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10603"; a="726946178"
X-IronPort-AV: E=Sophos;i="5.97,253,1669104000"; 
   d="scan'208";a="726946178"
Received: from lkp-server01.sh.intel.com (HELO ffa7f14d1d0f) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 27 Jan 2023 23:46:22 -0800
Received: from kbuild by ffa7f14d1d0f with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pLfun-0000V9-2x;
        Sat, 28 Jan 2023 07:46:21 +0000
Date:   Sat, 28 Jan 2023 15:45:42 +0800
From:   kernel test robot <lkp@intel.com>
To:     Roman Kagan <rkagan@amazon.de>, linux-kernel@vger.kernel.org
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Ben Segall <bsegall@google.com>,
        Zhang Qiao <zhangqiao22@huawei.com>,
        Ingo Molnar <mingo@redhat.com>,
        Waiman Long <longman@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Valentin Schneider <vschneid@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Mel Gorman <mgorman@suse.de>,
        Juri Lelli <juri.lelli@redhat.com>
Subject: Re: [PATCH] sched/fair: sanitize vruntime of entity being placed
Message-ID: <202301281536.CiaoBlBO-lkp@intel.com>
References: <20230127163230.3339408-1-rkagan@amazon.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230127163230.3339408-1-rkagan@amazon.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DIET_1,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Roman,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on tip/sched/core]
[also build test WARNING on linus/master v6.2-rc5]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Roman-Kagan/sched-fair-sanitize-vruntime-of-entity-being-placed/20230128-130846
patch link:    https://lore.kernel.org/r/20230127163230.3339408-1-rkagan%40amazon.de
patch subject: [PATCH] sched/fair: sanitize vruntime of entity being placed
config: hexagon-randconfig-r041-20230123 (https://download.01.org/0day-ci/archive/20230128/202301281536.CiaoBlBO-lkp@intel.com/config)
compiler: clang version 16.0.0 (https://github.com/llvm/llvm-project 4196ca3278f78c6e19246e54ab0ecb364e37d66a)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/2db31a18bcb88c280481672d7721f7e003d8df5a
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Roman-Kagan/sched-fair-sanitize-vruntime-of-entity-being-placed/20230128-130846
        git checkout 2db31a18bcb88c280481672d7721f7e003d8df5a
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=hexagon olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=hexagon SHELL=/bin/bash kernel/sched/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from kernel/sched/fair.c:28:
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
   In file included from kernel/sched/fair.c:28:
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
   In file included from kernel/sched/fair.c:28:
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
>> kernel/sched/fair.c:4697:27: warning: overflow in expression; result is -129542144 with type 'long' [-Winteger-overflow]
           if ((s64)sleep_time > 60 * NSEC_PER_SEC)
                                    ^
   kernel/sched/fair.c:6078:6: warning: no previous prototype for function 'init_cfs_bandwidth' [-Wmissing-prototypes]
   void init_cfs_bandwidth(struct cfs_bandwidth *cfs_b) {}
        ^
   kernel/sched/fair.c:6078:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void init_cfs_bandwidth(struct cfs_bandwidth *cfs_b) {}
   ^
   static 
   kernel/sched/fair.c:12498:6: warning: no previous prototype for function 'free_fair_sched_group' [-Wmissing-prototypes]
   void free_fair_sched_group(struct task_group *tg) { }
        ^
   kernel/sched/fair.c:12498:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void free_fair_sched_group(struct task_group *tg) { }
   ^
   static 
   kernel/sched/fair.c:12500:5: warning: no previous prototype for function 'alloc_fair_sched_group' [-Wmissing-prototypes]
   int alloc_fair_sched_group(struct task_group *tg, struct task_group *parent)
       ^
   kernel/sched/fair.c:12500:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   int alloc_fair_sched_group(struct task_group *tg, struct task_group *parent)
   ^
   static 
   kernel/sched/fair.c:12505:6: warning: no previous prototype for function 'online_fair_sched_group' [-Wmissing-prototypes]
   void online_fair_sched_group(struct task_group *tg) { }
        ^
   kernel/sched/fair.c:12505:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void online_fair_sched_group(struct task_group *tg) { }
   ^
   static 
   kernel/sched/fair.c:12507:6: warning: no previous prototype for function 'unregister_fair_sched_group' [-Wmissing-prototypes]
   void unregister_fair_sched_group(struct task_group *tg) { }
        ^
   kernel/sched/fair.c:12507:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void unregister_fair_sched_group(struct task_group *tg) { }
   ^
   static 
   kernel/sched/fair.c:535:20: warning: unused function 'list_del_leaf_cfs_rq' [-Wunused-function]
   static inline void list_del_leaf_cfs_rq(struct cfs_rq *cfs_rq)
                      ^
   kernel/sched/fair.c:556:19: warning: unused function 'tg_is_idle' [-Wunused-function]
   static inline int tg_is_idle(struct task_group *tg)
                     ^
   kernel/sched/fair.c:6051:20: warning: unused function 'cfs_bandwidth_used' [-Wunused-function]
   static inline bool cfs_bandwidth_used(void)
                      ^
   kernel/sched/fair.c:6059:20: warning: unused function 'sync_throttle' [-Wunused-function]
   static inline void sync_throttle(struct task_group *tg, int cpu) {}
                      ^
   kernel/sched/fair.c:6084:37: warning: unused function 'tg_cfs_bandwidth' [-Wunused-function]
   static inline struct cfs_bandwidth *tg_cfs_bandwidth(struct task_group *tg)
                                       ^
   kernel/sched/fair.c:6088:20: warning: unused function 'destroy_cfs_bandwidth' [-Wunused-function]
   static inline void destroy_cfs_bandwidth(struct cfs_bandwidth *cfs_b) {}
                      ^
   18 warnings generated.


vim +/long +4697 kernel/sched/fair.c

  4654	
  4655	static void
  4656	place_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int initial)
  4657	{
  4658		u64 vruntime = cfs_rq->min_vruntime;
  4659		u64 sleep_time;
  4660	
  4661		/*
  4662		 * The 'current' period is already promised to the current tasks,
  4663		 * however the extra weight of the new task will slow them down a
  4664		 * little, place the new task so that it fits in the slot that
  4665		 * stays open at the end.
  4666		 */
  4667		if (initial && sched_feat(START_DEBIT))
  4668			vruntime += sched_vslice(cfs_rq, se);
  4669	
  4670		/* sleeps up to a single latency don't count. */
  4671		if (!initial) {
  4672			unsigned long thresh;
  4673	
  4674			if (se_is_idle(se))
  4675				thresh = sysctl_sched_min_granularity;
  4676			else
  4677				thresh = sysctl_sched_latency;
  4678	
  4679			/*
  4680			 * Halve their sleep time's effect, to allow
  4681			 * for a gentler effect of sleepers:
  4682			 */
  4683			if (sched_feat(GENTLE_FAIR_SLEEPERS))
  4684				thresh >>= 1;
  4685	
  4686			vruntime -= thresh;
  4687		}
  4688	
  4689		/*
  4690		 * Pull vruntime of the entity being placed to the base level of
  4691		 * cfs_rq, to prevent boosting it if placed backwards.  If the entity
  4692		 * slept for a long time, don't even try to compare its vruntime with
  4693		 * the base as it may be too far off and the comparison may get
  4694		 * inversed due to s64 overflow.
  4695		 */
  4696		sleep_time = rq_clock_task(rq_of(cfs_rq)) - se->exec_start;
> 4697		if ((s64)sleep_time > 60 * NSEC_PER_SEC)
  4698			se->vruntime = vruntime;
  4699		else
  4700			se->vruntime = max_vruntime(se->vruntime, vruntime);
  4701	}
  4702	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
