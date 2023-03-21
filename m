Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 531F26C2FE6
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 12:12:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229665AbjCULMs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 07:12:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230105AbjCULMl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 07:12:41 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 416B0497DA
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 04:12:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679397152; x=1710933152;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=czLPU8sCEuIwyErf7tpZWfu3yAeyn2lLgfqT8z7968Y=;
  b=QFWa3TPfPT6lRQrqeph1Z77c59STwT51m07ByKcrVsB2aE06jKD+lT0B
   g58O1z1wF5xPxMQQdd8Nu29/UA9a7iuvgkRw0o9gBPMLyYRqSqhWiiQnn
   RoC9RorUHNVz1ReYAczoH+42+MOo1v+999hMdE676BEXCGxQYeP/jchzG
   YfMs/UMtgnoz4V6GBqJLH+X/JCS3SkHoojmHtg4dI1cycwmOV3eS7tcQ0
   SHbHRHEz2K2YmXSj1640EgWy0jwZmUhb5oDwLOGpDxBlrrxVC5m8+RRL/
   76adJyj+6hKZpWy+7Gx09qpowLsMqn5IP+uEwokTKEsR7DRaBoOcNNBEq
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10655"; a="425184257"
X-IronPort-AV: E=Sophos;i="5.98,278,1673942400"; 
   d="scan'208";a="425184257"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2023 04:12:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10655"; a="745805867"
X-IronPort-AV: E=Sophos;i="5.98,278,1673942400"; 
   d="scan'208";a="745805867"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 21 Mar 2023 04:12:25 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1peZui-000BqI-2X;
        Tue, 21 Mar 2023 11:12:24 +0000
Date:   Tue, 21 Mar 2023 19:11:38 +0800
From:   kernel test robot <lkp@intel.com>
To:     John Stultz <jstultz@google.com>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     oe-kbuild-all@lists.linux.dev, John Stultz <jstultz@google.com>,
        Joel Fernandes <joelaf@google.com>,
        Qais Yousef <qyousef@google.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>,
        Zimuzo Ezeozue <zezeozue@google.com>,
        Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>, kernel-team@android.com
Subject: Re: [PATCH v2 07/12] sched: Replace rq->curr access w/ rq_curr(rq)
Message-ID: <202303211827.IXnKJ5rO-lkp@intel.com>
References: <20230320233720.3488453-8-jstultz@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230320233720.3488453-8-jstultz@google.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi John,

I love your patch! Yet something to improve:

[auto build test ERROR on tip/sched/core]
[also build test ERROR on tip/locking/core tip/master tip/auto-latest linus/master v6.3-rc3 next-20230321]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/John-Stultz/locking-ww_mutex-Remove-wakeups-from-under-mutex-wait_lock/20230321-074149
patch link:    https://lore.kernel.org/r/20230320233720.3488453-8-jstultz%40google.com
patch subject: [PATCH v2 07/12] sched: Replace rq->curr access w/ rq_curr(rq)
config: x86_64-rhel-8.3 (https://download.01.org/0day-ci/archive/20230321/202303211827.IXnKJ5rO-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-8) 11.3.0
reproduce (this is a W=1 build):
        # https://github.com/intel-lab-lkp/linux/commit/77507c3a77e09cdc627a73364246f252d918de41
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review John-Stultz/locking-ww_mutex-Remove-wakeups-from-under-mutex-wait_lock/20230321-074149
        git checkout 77507c3a77e09cdc627a73364246f252d918de41
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=x86_64 olddefconfig
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202303211827.IXnKJ5rO-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from include/linux/rculist.h:11,
                    from include/linux/sched/signal.h:5,
                    from include/linux/sched/cputime.h:5,
                    from kernel/sched/build_policy.c:17:
   kernel/sched/cputime.c: In function 'kcpustat_field':
>> kernel/sched/cputime.c:997:42: error: 'struct rq' has no member named 'curr'
     997 |                 curr = rcu_dereference(rq->curr);
         |                                          ^~
   include/linux/rcupdate.h:453:17: note: in definition of macro '__rcu_dereference_check'
     453 |         typeof(*p) *local = (typeof(*p) *__force)READ_ONCE(p); \
         |                 ^
   include/linux/rcupdate.h:673:28: note: in expansion of macro 'rcu_dereference_check'
     673 | #define rcu_dereference(p) rcu_dereference_check(p, 0)
         |                            ^~~~~~~~~~~~~~~~~~~~~
   kernel/sched/cputime.c:997:24: note: in expansion of macro 'rcu_dereference'
     997 |                 curr = rcu_dereference(rq->curr);
         |                        ^~~~~~~~~~~~~~~
>> kernel/sched/cputime.c:997:42: error: 'struct rq' has no member named 'curr'
     997 |                 curr = rcu_dereference(rq->curr);
         |                                          ^~
   include/linux/rcupdate.h:453:38: note: in definition of macro '__rcu_dereference_check'
     453 |         typeof(*p) *local = (typeof(*p) *__force)READ_ONCE(p); \
         |                                      ^
   include/linux/rcupdate.h:673:28: note: in expansion of macro 'rcu_dereference_check'
     673 | #define rcu_dereference(p) rcu_dereference_check(p, 0)
         |                            ^~~~~~~~~~~~~~~~~~~~~
   kernel/sched/cputime.c:997:24: note: in expansion of macro 'rcu_dereference'
     997 |                 curr = rcu_dereference(rq->curr);
         |                        ^~~~~~~~~~~~~~~
   In file included from <command-line>:
>> kernel/sched/cputime.c:997:42: error: 'struct rq' has no member named 'curr'
     997 |                 curr = rcu_dereference(rq->curr);
         |                                          ^~
   include/linux/compiler_types.h:352:23: note: in definition of macro '__compiletime_assert'
     352 |                 if (!(condition))                                       \
         |                       ^~~~~~~~~
   include/linux/compiler_types.h:372:9: note: in expansion of macro '_compiletime_assert'
     372 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ^~~~~~~~~~~~~~~~~~~
   include/asm-generic/rwonce.h:36:9: note: in expansion of macro 'compiletime_assert'
      36 |         compiletime_assert(__native_word(t) || sizeof(t) == sizeof(long long),  \
         |         ^~~~~~~~~~~~~~~~~~
   include/asm-generic/rwonce.h:36:28: note: in expansion of macro '__native_word'
      36 |         compiletime_assert(__native_word(t) || sizeof(t) == sizeof(long long),  \
         |                            ^~~~~~~~~~~~~
   include/asm-generic/rwonce.h:49:9: note: in expansion of macro 'compiletime_assert_rwonce_type'
      49 |         compiletime_assert_rwonce_type(x);                              \
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/rcupdate.h:453:50: note: in expansion of macro 'READ_ONCE'
     453 |         typeof(*p) *local = (typeof(*p) *__force)READ_ONCE(p); \
         |                                                  ^~~~~~~~~
   include/linux/rcupdate.h:601:9: note: in expansion of macro '__rcu_dereference_check'
     601 |         __rcu_dereference_check((p), __UNIQUE_ID(rcu), \
         |         ^~~~~~~~~~~~~~~~~~~~~~~
   include/linux/rcupdate.h:673:28: note: in expansion of macro 'rcu_dereference_check'
     673 | #define rcu_dereference(p) rcu_dereference_check(p, 0)
         |                            ^~~~~~~~~~~~~~~~~~~~~
   kernel/sched/cputime.c:997:24: note: in expansion of macro 'rcu_dereference'
     997 |                 curr = rcu_dereference(rq->curr);
         |                        ^~~~~~~~~~~~~~~
>> kernel/sched/cputime.c:997:42: error: 'struct rq' has no member named 'curr'
     997 |                 curr = rcu_dereference(rq->curr);
         |                                          ^~
   include/linux/compiler_types.h:352:23: note: in definition of macro '__compiletime_assert'
     352 |                 if (!(condition))                                       \
         |                       ^~~~~~~~~
   include/linux/compiler_types.h:372:9: note: in expansion of macro '_compiletime_assert'
     372 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ^~~~~~~~~~~~~~~~~~~
   include/asm-generic/rwonce.h:36:9: note: in expansion of macro 'compiletime_assert'
      36 |         compiletime_assert(__native_word(t) || sizeof(t) == sizeof(long long),  \
         |         ^~~~~~~~~~~~~~~~~~
   include/asm-generic/rwonce.h:36:28: note: in expansion of macro '__native_word'
      36 |         compiletime_assert(__native_word(t) || sizeof(t) == sizeof(long long),  \
         |                            ^~~~~~~~~~~~~
   include/asm-generic/rwonce.h:49:9: note: in expansion of macro 'compiletime_assert_rwonce_type'
      49 |         compiletime_assert_rwonce_type(x);                              \
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/rcupdate.h:453:50: note: in expansion of macro 'READ_ONCE'
     453 |         typeof(*p) *local = (typeof(*p) *__force)READ_ONCE(p); \
         |                                                  ^~~~~~~~~
   include/linux/rcupdate.h:601:9: note: in expansion of macro '__rcu_dereference_check'
     601 |         __rcu_dereference_check((p), __UNIQUE_ID(rcu), \
         |         ^~~~~~~~~~~~~~~~~~~~~~~
   include/linux/rcupdate.h:673:28: note: in expansion of macro 'rcu_dereference_check'
     673 | #define rcu_dereference(p) rcu_dereference_check(p, 0)
         |                            ^~~~~~~~~~~~~~~~~~~~~
   kernel/sched/cputime.c:997:24: note: in expansion of macro 'rcu_dereference'
     997 |                 curr = rcu_dereference(rq->curr);
         |                        ^~~~~~~~~~~~~~~
>> kernel/sched/cputime.c:997:42: error: 'struct rq' has no member named 'curr'
     997 |                 curr = rcu_dereference(rq->curr);
         |                                          ^~
   include/linux/compiler_types.h:352:23: note: in definition of macro '__compiletime_assert'
     352 |                 if (!(condition))                                       \
         |                       ^~~~~~~~~
   include/linux/compiler_types.h:372:9: note: in expansion of macro '_compiletime_assert'
     372 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ^~~~~~~~~~~~~~~~~~~
   include/asm-generic/rwonce.h:36:9: note: in expansion of macro 'compiletime_assert'
      36 |         compiletime_assert(__native_word(t) || sizeof(t) == sizeof(long long),  \
         |         ^~~~~~~~~~~~~~~~~~
   include/asm-generic/rwonce.h:36:28: note: in expansion of macro '__native_word'
      36 |         compiletime_assert(__native_word(t) || sizeof(t) == sizeof(long long),  \
         |                            ^~~~~~~~~~~~~
   include/asm-generic/rwonce.h:49:9: note: in expansion of macro 'compiletime_assert_rwonce_type'
      49 |         compiletime_assert_rwonce_type(x);                              \
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/rcupdate.h:453:50: note: in expansion of macro 'READ_ONCE'
     453 |         typeof(*p) *local = (typeof(*p) *__force)READ_ONCE(p); \
         |                                                  ^~~~~~~~~
   include/linux/rcupdate.h:601:9: note: in expansion of macro '__rcu_dereference_check'
     601 |         __rcu_dereference_check((p), __UNIQUE_ID(rcu), \
         |         ^~~~~~~~~~~~~~~~~~~~~~~
   include/linux/rcupdate.h:673:28: note: in expansion of macro 'rcu_dereference_check'
     673 | #define rcu_dereference(p) rcu_dereference_check(p, 0)
         |                            ^~~~~~~~~~~~~~~~~~~~~
   kernel/sched/cputime.c:997:24: note: in expansion of macro 'rcu_dereference'
     997 |                 curr = rcu_dereference(rq->curr);
         |                        ^~~~~~~~~~~~~~~
>> kernel/sched/cputime.c:997:42: error: 'struct rq' has no member named 'curr'
     997 |                 curr = rcu_dereference(rq->curr);
         |                                          ^~
   include/linux/compiler_types.h:352:23: note: in definition of macro '__compiletime_assert'
     352 |                 if (!(condition))                                       \
         |                       ^~~~~~~~~
   include/linux/compiler_types.h:372:9: note: in expansion of macro '_compiletime_assert'
     372 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ^~~~~~~~~~~~~~~~~~~
   include/asm-generic/rwonce.h:36:9: note: in expansion of macro 'compiletime_assert'
      36 |         compiletime_assert(__native_word(t) || sizeof(t) == sizeof(long long),  \
         |         ^~~~~~~~~~~~~~~~~~
   include/asm-generic/rwonce.h:36:28: note: in expansion of macro '__native_word'
      36 |         compiletime_assert(__native_word(t) || sizeof(t) == sizeof(long long),  \
         |                            ^~~~~~~~~~~~~
   include/asm-generic/rwonce.h:49:9: note: in expansion of macro 'compiletime_assert_rwonce_type'
      49 |         compiletime_assert_rwonce_type(x);                              \
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/rcupdate.h:453:50: note: in expansion of macro 'READ_ONCE'
     453 |         typeof(*p) *local = (typeof(*p) *__force)READ_ONCE(p); \
         |                                                  ^~~~~~~~~
   include/linux/rcupdate.h:601:9: note: in expansion of macro '__rcu_dereference_check'
     601 |         __rcu_dereference_check((p), __UNIQUE_ID(rcu), \
         |         ^~~~~~~~~~~~~~~~~~~~~~~
   include/linux/rcupdate.h:673:28: note: in expansion of macro 'rcu_dereference_check'
     673 | #define rcu_dereference(p) rcu_dereference_check(p, 0)
         |                            ^~~~~~~~~~~~~~~~~~~~~
   kernel/sched/cputime.c:997:24: note: in expansion of macro 'rcu_dereference'
     997 |                 curr = rcu_dereference(rq->curr);
         |                        ^~~~~~~~~~~~~~~
>> kernel/sched/cputime.c:997:42: error: 'struct rq' has no member named 'curr'
     997 |                 curr = rcu_dereference(rq->curr);
         |                                          ^~
   include/linux/compiler_types.h:352:23: note: in definition of macro '__compiletime_assert'
     352 |                 if (!(condition))                                       \
         |                       ^~~~~~~~~
   include/linux/compiler_types.h:372:9: note: in expansion of macro '_compiletime_assert'
     372 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ^~~~~~~~~~~~~~~~~~~
   include/asm-generic/rwonce.h:36:9: note: in expansion of macro 'compiletime_assert'
      36 |         compiletime_assert(__native_word(t) || sizeof(t) == sizeof(long long),  \
         |         ^~~~~~~~~~~~~~~~~~
   include/asm-generic/rwonce.h:49:9: note: in expansion of macro 'compiletime_assert_rwonce_type'
      49 |         compiletime_assert_rwonce_type(x);                              \
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/rcupdate.h:453:50: note: in expansion of macro 'READ_ONCE'
     453 |         typeof(*p) *local = (typeof(*p) *__force)READ_ONCE(p); \
         |                                                  ^~~~~~~~~
   include/linux/rcupdate.h:601:9: note: in expansion of macro '__rcu_dereference_check'
     601 |         __rcu_dereference_check((p), __UNIQUE_ID(rcu), \
         |         ^~~~~~~~~~~~~~~~~~~~~~~
   include/linux/rcupdate.h:673:28: note: in expansion of macro 'rcu_dereference_check'
     673 | #define rcu_dereference(p) rcu_dereference_check(p, 0)
         |                            ^~~~~~~~~~~~~~~~~~~~~
   kernel/sched/cputime.c:997:24: note: in expansion of macro 'rcu_dereference'
     997 |                 curr = rcu_dereference(rq->curr);
         |                        ^~~~~~~~~~~~~~~
>> kernel/sched/cputime.c:997:42: error: 'struct rq' has no member named 'curr'
     997 |                 curr = rcu_dereference(rq->curr);
         |                                          ^~
   include/linux/compiler_types.h:328:27: note: in definition of macro '__unqual_scalar_typeof'
     328 |                 _Generic((x),                                           \
         |                           ^
   include/asm-generic/rwonce.h:50:9: note: in expansion of macro '__READ_ONCE'
      50 |         __READ_ONCE(x);                                                 \
         |         ^~~~~~~~~~~
   include/linux/rcupdate.h:453:50: note: in expansion of macro 'READ_ONCE'
     453 |         typeof(*p) *local = (typeof(*p) *__force)READ_ONCE(p); \
         |                                                  ^~~~~~~~~
   include/linux/rcupdate.h:601:9: note: in expansion of macro '__rcu_dereference_check'
     601 |         __rcu_dereference_check((p), __UNIQUE_ID(rcu), \
         |         ^~~~~~~~~~~~~~~~~~~~~~~
   include/linux/rcupdate.h:673:28: note: in expansion of macro 'rcu_dereference_check'
     673 | #define rcu_dereference(p) rcu_dereference_check(p, 0)
         |                            ^~~~~~~~~~~~~~~~~~~~~
   kernel/sched/cputime.c:997:24: note: in expansion of macro 'rcu_dereference'
     997 |                 curr = rcu_dereference(rq->curr);
         |                        ^~~~~~~~~~~~~~~
   In file included from ./arch/x86/include/generated/asm/rwonce.h:1,
                    from include/linux/compiler.h:247,
                    from include/linux/build_bug.h:5,
                    from include/linux/container_of.h:5,
                    from include/linux/list.h:5,
                    from include/linux/smp.h:12,
                    from include/linux/sched/clock.h:5,
                    from kernel/sched/build_policy.c:16:
>> kernel/sched/cputime.c:997:42: error: 'struct rq' has no member named 'curr'
     997 |                 curr = rcu_dereference(rq->curr);
         |                                          ^~
   include/asm-generic/rwonce.h:44:73: note: in definition of macro '__READ_ONCE'
      44 | #define __READ_ONCE(x)  (*(const volatile __unqual_scalar_typeof(x) *)&(x))
         |                                                                         ^
   include/linux/rcupdate.h:453:50: note: in expansion of macro 'READ_ONCE'
     453 |         typeof(*p) *local = (typeof(*p) *__force)READ_ONCE(p); \
         |                                                  ^~~~~~~~~
   include/linux/rcupdate.h:601:9: note: in expansion of macro '__rcu_dereference_check'
     601 |         __rcu_dereference_check((p), __UNIQUE_ID(rcu), \
         |         ^~~~~~~~~~~~~~~~~~~~~~~
   include/linux/rcupdate.h:673:28: note: in expansion of macro 'rcu_dereference_check'
     673 | #define rcu_dereference(p) rcu_dereference_check(p, 0)
         |                            ^~~~~~~~~~~~~~~~~~~~~
   kernel/sched/cputime.c:997:24: note: in expansion of macro 'rcu_dereference'
     997 |                 curr = rcu_dereference(rq->curr);
         |                        ^~~~~~~~~~~~~~~
   In file included from include/linux/rculist.h:11,
                    from include/linux/sched/signal.h:5,
                    from include/linux/sched/cputime.h:5,
                    from kernel/sched/build_policy.c:17:
>> kernel/sched/cputime.c:997:42: error: 'struct rq' has no member named 'curr'
     997 |                 curr = rcu_dereference(rq->curr);
         |                                          ^~
   include/linux/rcupdate.h:456:19: note: in definition of macro '__rcu_dereference_check'
     456 |         ((typeof(*p) __force __kernel *)(local)); \
         |                   ^
   include/linux/rcupdate.h:673:28: note: in expansion of macro 'rcu_dereference_check'
     673 | #define rcu_dereference(p) rcu_dereference_check(p, 0)
         |                            ^~~~~~~~~~~~~~~~~~~~~
   kernel/sched/cputime.c:997:24: note: in expansion of macro 'rcu_dereference'
     997 |                 curr = rcu_dereference(rq->curr);
         |                        ^~~~~~~~~~~~~~~
   kernel/sched/cputime.c: In function 'kcpustat_cpu_fetch':
   kernel/sched/cputime.c:1084:42: error: 'struct rq' has no member named 'curr'
    1084 |                 curr = rcu_dereference(rq->curr);
         |                                          ^~
   include/linux/rcupdate.h:453:17: note: in definition of macro '__rcu_dereference_check'
     453 |         typeof(*p) *local = (typeof(*p) *__force)READ_ONCE(p); \
         |                 ^
   include/linux/rcupdate.h:673:28: note: in expansion of macro 'rcu_dereference_check'
     673 | #define rcu_dereference(p) rcu_dereference_check(p, 0)
         |                            ^~~~~~~~~~~~~~~~~~~~~
   kernel/sched/cputime.c:1084:24: note: in expansion of macro 'rcu_dereference'
    1084 |                 curr = rcu_dereference(rq->curr);
         |                        ^~~~~~~~~~~~~~~
   kernel/sched/cputime.c:1084:42: error: 'struct rq' has no member named 'curr'
    1084 |                 curr = rcu_dereference(rq->curr);
         |                                          ^~
   include/linux/rcupdate.h:453:38: note: in definition of macro '__rcu_dereference_check'
     453 |         typeof(*p) *local = (typeof(*p) *__force)READ_ONCE(p); \
         |                                      ^
   include/linux/rcupdate.h:673:28: note: in expansion of macro 'rcu_dereference_check'
     673 | #define rcu_dereference(p) rcu_dereference_check(p, 0)
         |                            ^~~~~~~~~~~~~~~~~~~~~
   kernel/sched/cputime.c:1084:24: note: in expansion of macro 'rcu_dereference'
    1084 |                 curr = rcu_dereference(rq->curr);
         |                        ^~~~~~~~~~~~~~~
   In file included from <command-line>:
   kernel/sched/cputime.c:1084:42: error: 'struct rq' has no member named 'curr'
    1084 |                 curr = rcu_dereference(rq->curr);
         |                                          ^~
   include/linux/compiler_types.h:352:23: note: in definition of macro '__compiletime_assert'
     352 |                 if (!(condition))                                       \
         |                       ^~~~~~~~~
   include/linux/compiler_types.h:372:9: note: in expansion of macro '_compiletime_assert'
     372 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ^~~~~~~~~~~~~~~~~~~
   include/asm-generic/rwonce.h:36:9: note: in expansion of macro 'compiletime_assert'
      36 |         compiletime_assert(__native_word(t) || sizeof(t) == sizeof(long long),  \
         |         ^~~~~~~~~~~~~~~~~~
   include/asm-generic/rwonce.h:36:28: note: in expansion of macro '__native_word'
      36 |         compiletime_assert(__native_word(t) || sizeof(t) == sizeof(long long),  \
         |                            ^~~~~~~~~~~~~
   include/asm-generic/rwonce.h:49:9: note: in expansion of macro 'compiletime_assert_rwonce_type'
      49 |         compiletime_assert_rwonce_type(x);                              \
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/rcupdate.h:453:50: note: in expansion of macro 'READ_ONCE'
     453 |         typeof(*p) *local = (typeof(*p) *__force)READ_ONCE(p); \
         |                                                  ^~~~~~~~~
   include/linux/rcupdate.h:601:9: note: in expansion of macro '__rcu_dereference_check'
     601 |         __rcu_dereference_check((p), __UNIQUE_ID(rcu), \
         |         ^~~~~~~~~~~~~~~~~~~~~~~
   include/linux/rcupdate.h:673:28: note: in expansion of macro 'rcu_dereference_check'
     673 | #define rcu_dereference(p) rcu_dereference_check(p, 0)
         |                            ^~~~~~~~~~~~~~~~~~~~~
   kernel/sched/cputime.c:1084:24: note: in expansion of macro 'rcu_dereference'
    1084 |                 curr = rcu_dereference(rq->curr);
         |                        ^~~~~~~~~~~~~~~
   kernel/sched/cputime.c:1084:42: error: 'struct rq' has no member named 'curr'
    1084 |                 curr = rcu_dereference(rq->curr);
         |                                          ^~
   include/linux/compiler_types.h:352:23: note: in definition of macro '__compiletime_assert'
     352 |                 if (!(condition))                                       \
         |                       ^~~~~~~~~
   include/linux/compiler_types.h:372:9: note: in expansion of macro '_compiletime_assert'
     372 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ^~~~~~~~~~~~~~~~~~~
   include/asm-generic/rwonce.h:36:9: note: in expansion of macro 'compiletime_assert'
      36 |         compiletime_assert(__native_word(t) || sizeof(t) == sizeof(long long),  \
         |         ^~~~~~~~~~~~~~~~~~
   include/asm-generic/rwonce.h:36:28: note: in expansion of macro '__native_word'
      36 |         compiletime_assert(__native_word(t) || sizeof(t) == sizeof(long long),  \
         |                            ^~~~~~~~~~~~~
   include/asm-generic/rwonce.h:49:9: note: in expansion of macro 'compiletime_assert_rwonce_type'
      49 |         compiletime_assert_rwonce_type(x);                              \
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/rcupdate.h:453:50: note: in expansion of macro 'READ_ONCE'
     453 |         typeof(*p) *local = (typeof(*p) *__force)READ_ONCE(p); \
         |                                                  ^~~~~~~~~
   include/linux/rcupdate.h:601:9: note: in expansion of macro '__rcu_dereference_check'
     601 |         __rcu_dereference_check((p), __UNIQUE_ID(rcu), \
         |         ^~~~~~~~~~~~~~~~~~~~~~~
   include/linux/rcupdate.h:673:28: note: in expansion of macro 'rcu_dereference_check'
     673 | #define rcu_dereference(p) rcu_dereference_check(p, 0)
         |                            ^~~~~~~~~~~~~~~~~~~~~
   kernel/sched/cputime.c:1084:24: note: in expansion of macro 'rcu_dereference'
    1084 |                 curr = rcu_dereference(rq->curr);
         |                        ^~~~~~~~~~~~~~~
   kernel/sched/cputime.c:1084:42: error: 'struct rq' has no member named 'curr'
    1084 |                 curr = rcu_dereference(rq->curr);
         |                                          ^~


vim +997 kernel/sched/cputime.c

64eea63c19a2c3 Frederic Weisbecker 2019-10-25   979  
64eea63c19a2c3 Frederic Weisbecker 2019-10-25   980  u64 kcpustat_field(struct kernel_cpustat *kcpustat,
64eea63c19a2c3 Frederic Weisbecker 2019-10-25   981  		   enum cpu_usage_stat usage, int cpu)
64eea63c19a2c3 Frederic Weisbecker 2019-10-25   982  {
64eea63c19a2c3 Frederic Weisbecker 2019-10-25   983  	u64 *cpustat = kcpustat->cpustat;
e0d648f9d883ec Borislav Petkov     2020-03-27   984  	u64 val = cpustat[usage];
64eea63c19a2c3 Frederic Weisbecker 2019-10-25   985  	struct rq *rq;
64eea63c19a2c3 Frederic Weisbecker 2019-10-25   986  	int err;
64eea63c19a2c3 Frederic Weisbecker 2019-10-25   987  
64eea63c19a2c3 Frederic Weisbecker 2019-10-25   988  	if (!vtime_accounting_enabled_cpu(cpu))
e0d648f9d883ec Borislav Petkov     2020-03-27   989  		return val;
64eea63c19a2c3 Frederic Weisbecker 2019-10-25   990  
64eea63c19a2c3 Frederic Weisbecker 2019-10-25   991  	rq = cpu_rq(cpu);
64eea63c19a2c3 Frederic Weisbecker 2019-10-25   992  
64eea63c19a2c3 Frederic Weisbecker 2019-10-25   993  	for (;;) {
64eea63c19a2c3 Frederic Weisbecker 2019-10-25   994  		struct task_struct *curr;
64eea63c19a2c3 Frederic Weisbecker 2019-10-25   995  
64eea63c19a2c3 Frederic Weisbecker 2019-10-25   996  		rcu_read_lock();
64eea63c19a2c3 Frederic Weisbecker 2019-10-25  @997  		curr = rcu_dereference(rq->curr);
64eea63c19a2c3 Frederic Weisbecker 2019-10-25   998  		if (WARN_ON_ONCE(!curr)) {
64eea63c19a2c3 Frederic Weisbecker 2019-10-25   999  			rcu_read_unlock();
64eea63c19a2c3 Frederic Weisbecker 2019-10-25  1000  			return cpustat[usage];
64eea63c19a2c3 Frederic Weisbecker 2019-10-25  1001  		}
64eea63c19a2c3 Frederic Weisbecker 2019-10-25  1002  
5a1c95580f1d89 Frederic Weisbecker 2019-11-21  1003  		err = kcpustat_field_vtime(cpustat, curr, usage, cpu, &val);
64eea63c19a2c3 Frederic Weisbecker 2019-10-25  1004  		rcu_read_unlock();
64eea63c19a2c3 Frederic Weisbecker 2019-10-25  1005  
64eea63c19a2c3 Frederic Weisbecker 2019-10-25  1006  		if (!err)
64eea63c19a2c3 Frederic Weisbecker 2019-10-25  1007  			return val;
64eea63c19a2c3 Frederic Weisbecker 2019-10-25  1008  
64eea63c19a2c3 Frederic Weisbecker 2019-10-25  1009  		cpu_relax();
64eea63c19a2c3 Frederic Weisbecker 2019-10-25  1010  	}
64eea63c19a2c3 Frederic Weisbecker 2019-10-25  1011  }
64eea63c19a2c3 Frederic Weisbecker 2019-10-25  1012  EXPORT_SYMBOL_GPL(kcpustat_field);
74722bb223d0f2 Frederic Weisbecker 2019-11-21  1013  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
