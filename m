Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B114E6DDD42
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 16:07:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229852AbjDKOH0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 10:07:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230007AbjDKOHV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 10:07:21 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D91CF10FD
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 07:07:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681222038; x=1712758038;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=xQc90EsiSgEeU2LsTXTSVoxUv73F2XLPrJjotGxGPEA=;
  b=ktjZDILdXKAtSz1DH3QtpT1PAD+5iJinXBZXi6b8WupBS52LZikVeP9i
   pWYqVlw3KzMEnfb48h7f7kE07jxELuZYuGCBgwoOzal/lVl2exMj1XV61
   MqpBF5vG8oKzfoRrVJvWalQCsRPutd4y3GfTrjsnZs/dzZaRW9WGwDTng
   XkxUDCl5/DqDGZNO2PcF47MTDI/IZMh3oD7s58xzkZEM3vGBeahqV+CtW
   Q6eVAtR1L2FBqOvtwUmJw6O4hjEgm5Wyzeo35TbI47cZBl6RAW9PU5SS4
   ALNcfcEftOAiBJLZdj6/FFeFkHv62r04A/lD5RoOvTZo3O5B6AxikVmtI
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10677"; a="408760516"
X-IronPort-AV: E=Sophos;i="5.98,336,1673942400"; 
   d="scan'208";a="408760516"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2023 07:07:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10677"; a="721202911"
X-IronPort-AV: E=Sophos;i="5.98,336,1673942400"; 
   d="scan'208";a="721202911"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 11 Apr 2023 07:07:13 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pmEeO-000WMf-0L;
        Tue, 11 Apr 2023 14:07:12 +0000
Date:   Tue, 11 Apr 2023 22:07:00 +0800
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
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: Re: [PATCH v3 08/14] sched: Replace rq->curr access w/ rq_curr(rq)
Message-ID: <202304112129.2DLHpwAl-lkp@intel.com>
References: <20230411042511.1606592-9-jstultz@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230411042511.1606592-9-jstultz@google.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi John,

kernel test robot noticed the following build errors:

[auto build test ERROR on tip/locking/core]
[also build test ERROR on tip/master tip/auto-latest linus/master v6.3-rc6 next-20230411]
[cannot apply to tip/sched/core]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/John-Stultz/locking-ww_mutex-Remove-wakeups-from-under-mutex-wait_lock/20230411-122859
patch link:    https://lore.kernel.org/r/20230411042511.1606592-9-jstultz%40google.com
patch subject: [PATCH v3 08/14] sched: Replace rq->curr access w/ rq_curr(rq)
config: s390-allyesconfig (https://download.01.org/0day-ci/archive/20230411/202304112129.2DLHpwAl-lkp@intel.com/config)
compiler: s390-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/b562351b6a0f874c80020dfc83b22a6f8959aaec
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review John-Stultz/locking-ww_mutex-Remove-wakeups-from-under-mutex-wait_lock/20230411-122859
        git checkout b562351b6a0f874c80020dfc83b22a6f8959aaec
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=s390 olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=s390 SHELL=/bin/bash kernel/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202304112129.2DLHpwAl-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from arch/s390/include/asm/rwonce.h:29,
                    from include/linux/compiler.h:247,
                    from include/linux/kernel.h:20,
                    from include/linux/cpumask.h:10,
                    from include/linux/energy_model.h:4,
                    from kernel/sched/fair.c:23:
   kernel/sched/fair.c: In function 'task_numa_compare':
>> include/asm-generic/rwonce.h:44:71: error: lvalue required as unary '&' operand
      44 | #define __READ_ONCE(x)  (*(const volatile __unqual_scalar_typeof(x) *)&(x))
         |                                                                       ^
   include/asm-generic/rwonce.h:50:9: note: in expansion of macro '__READ_ONCE'
      50 |         __READ_ONCE(x);                                                 \
         |         ^~~~~~~~~~~
   include/linux/rcupdate.h:462:50: note: in expansion of macro 'READ_ONCE'
     462 |         typeof(*p) *local = (typeof(*p) *__force)READ_ONCE(p); \
         |                                                  ^~~~~~~~~
   include/linux/rcupdate.h:610:9: note: in expansion of macro '__rcu_dereference_check'
     610 |         __rcu_dereference_check((p), __UNIQUE_ID(rcu), \
         |         ^~~~~~~~~~~~~~~~~~~~~~~
   include/linux/rcupdate.h:682:28: note: in expansion of macro 'rcu_dereference_check'
     682 | #define rcu_dereference(p) rcu_dereference_check(p, 0)
         |                            ^~~~~~~~~~~~~~~~~~~~~
   kernel/sched/fair.c:1961:15: note: in expansion of macro 'rcu_dereference'
    1961 |         cur = rcu_dereference(rq_curr(dst_rq));
         |               ^~~~~~~~~~~~~~~
   kernel/sched/fair.c: In function 'task_numa_group':
>> include/asm-generic/rwonce.h:44:71: error: lvalue required as unary '&' operand
      44 | #define __READ_ONCE(x)  (*(const volatile __unqual_scalar_typeof(x) *)&(x))
         |                                                                       ^
   include/asm-generic/rwonce.h:50:9: note: in expansion of macro '__READ_ONCE'
      50 |         __READ_ONCE(x);                                                 \
         |         ^~~~~~~~~~~
   kernel/sched/fair.c:2750:15: note: in expansion of macro 'READ_ONCE'
    2750 |         tsk = READ_ONCE(cpu_curr(cpu));
         |               ^~~~~~~~~
   kernel/sched/fair.c: At top level:
   kernel/sched/fair.c:11908:6: warning: no previous prototype for 'task_vruntime_update' [-Wmissing-prototypes]
   11908 | void task_vruntime_update(struct rq *rq, struct task_struct *p, bool in_fi)
         |      ^~~~~~~~~~~~~~~~~~~~


vim +44 include/asm-generic/rwonce.h

e506ea451254ab Will Deacon 2019-10-15  28  
e506ea451254ab Will Deacon 2019-10-15  29  /*
e506ea451254ab Will Deacon 2019-10-15  30   * Yes, this permits 64-bit accesses on 32-bit architectures. These will
e506ea451254ab Will Deacon 2019-10-15  31   * actually be atomic in some cases (namely Armv7 + LPAE), but for others we
e506ea451254ab Will Deacon 2019-10-15  32   * rely on the access being split into 2x32-bit accesses for a 32-bit quantity
e506ea451254ab Will Deacon 2019-10-15  33   * (e.g. a virtual address) and a strong prevailing wind.
e506ea451254ab Will Deacon 2019-10-15  34   */
e506ea451254ab Will Deacon 2019-10-15  35  #define compiletime_assert_rwonce_type(t)					\
e506ea451254ab Will Deacon 2019-10-15  36  	compiletime_assert(__native_word(t) || sizeof(t) == sizeof(long long),	\
e506ea451254ab Will Deacon 2019-10-15  37  		"Unsupported access size for {READ,WRITE}_ONCE().")
e506ea451254ab Will Deacon 2019-10-15  38  
e506ea451254ab Will Deacon 2019-10-15  39  /*
e506ea451254ab Will Deacon 2019-10-15  40   * Use __READ_ONCE() instead of READ_ONCE() if you do not require any
3c9184109e78ea Will Deacon 2019-10-30  41   * atomicity. Note that this may result in tears!
e506ea451254ab Will Deacon 2019-10-15  42   */
b78b331a3f5c07 Will Deacon 2019-10-15  43  #ifndef __READ_ONCE
e506ea451254ab Will Deacon 2019-10-15 @44  #define __READ_ONCE(x)	(*(const volatile __unqual_scalar_typeof(x) *)&(x))
b78b331a3f5c07 Will Deacon 2019-10-15  45  #endif
e506ea451254ab Will Deacon 2019-10-15  46  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
