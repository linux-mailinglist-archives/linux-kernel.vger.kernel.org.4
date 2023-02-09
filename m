Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 862D4690CF9
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 16:30:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231269AbjBIPag (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 10:30:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230284AbjBIPaf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 10:30:35 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8EFB5BA5D;
        Thu,  9 Feb 2023 07:30:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675956633; x=1707492633;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=qOfl2BzXQFQWmUA0I1/ePCp+riFd97UKHJAZ2Zo0o50=;
  b=Hwda33b3cz1ULwSbDRSG1MLNqVWcPjpTKBEv9kOaUCXukqYlCK0oczlR
   5o8PLrgTNZmyc7bGJiRuhhMzCiVWjWvPeT97M6naO7t89gq/3DttnrFTS
   93zimoXuF3jz4YOR3ikzW1UlGF3EbPGmEHpwhBJZr5SYBiX58LR58NGp6
   46FTQZSOdEBfccroFg4oyiRQKdDurSehymcKNs+AqKrGWZ+0vu1m11hhN
   IPtHgZq36CdIaDZLgWTnwZqNKHFNGSjPFHg9DBRJVSTrpibWgxjmAVEW7
   xK1dyzPBAGmUZOWMnSrzJUQNtsHfX1ynb9x33sGPz2Mc6Hb62QYGbMhmO
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10615"; a="318150393"
X-IronPort-AV: E=Sophos;i="5.97,284,1669104000"; 
   d="scan'208";a="318150393"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2023 07:21:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10615"; a="669611643"
X-IronPort-AV: E=Sophos;i="5.97,284,1669104000"; 
   d="scan'208";a="669611643"
Received: from lkp-server01.sh.intel.com (HELO 4455601a8d94) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 09 Feb 2023 07:21:46 -0800
Received: from kbuild by 4455601a8d94 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pQ8k5-00058Q-1e;
        Thu, 09 Feb 2023 15:21:45 +0000
Date:   Thu, 9 Feb 2023 23:21:43 +0800
From:   kernel test robot <lkp@intel.com>
To:     Zqiang <qiang1.zhang@intel.com>, paulmck@kernel.org,
        frederic@kernel.org, quic_neeraju@quicinc.com,
        joel@joelfernandes.org, qiuxu.zhuo@intel.com
Cc:     oe-kbuild-all@lists.linux.dev, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] rcu: Keeping rcu-related kthreads running on
 housekeeping CPUS
Message-ID: <202302092354.9PFOG9CE-lkp@intel.com>
References: <20230209102730.974465-1-qiang1.zhang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230209102730.974465-1-qiang1.zhang@intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Zqiang,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on paulmck-rcu/dev]
[also build test WARNING on next-20230209]
[cannot apply to linus/master v6.2-rc7]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Zqiang/rcu-Keeping-rcu-related-kthreads-running-on-housekeeping-CPUS/20230209-182311
base:   https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git dev
patch link:    https://lore.kernel.org/r/20230209102730.974465-1-qiang1.zhang%40intel.com
patch subject: [PATCH v2] rcu: Keeping rcu-related kthreads running on housekeeping CPUS
config: m68k-allyesconfig (https://download.01.org/0day-ci/archive/20230209/202302092354.9PFOG9CE-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/af15a3ade363b21d823918088623f8564cbd9d08
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Zqiang/rcu-Keeping-rcu-related-kthreads-running-on-housekeeping-CPUS/20230209-182311
        git checkout af15a3ade363b21d823918088623f8564cbd9d08
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=m68k olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=m68k SHELL=/bin/bash kernel/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202302092354.9PFOG9CE-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from kernel/torture.c:40:
>> kernel/rcu/rcu.h:602:6: warning: no previous prototype for 'rcu_kthread_setaffinity' [-Wmissing-prototypes]
     602 | void rcu_kthread_setaffinity(struct task_struct *tsk, int outgoing) { }
         |      ^~~~~~~~~~~~~~~~~~~~~~~
--
   In file included from kernel/rcu/update.c:49:
>> kernel/rcu/rcu.h:602:6: warning: no previous prototype for 'rcu_kthread_setaffinity' [-Wmissing-prototypes]
     602 | void rcu_kthread_setaffinity(struct task_struct *tsk, int outgoing) { }
         |      ^~~~~~~~~~~~~~~~~~~~~~~
   In file included from kernel/rcu/update.c:649:
>> kernel/rcu/tasks.h:1970:6: warning: no previous prototype for 'rcu_tasks_generic_setaffinity' [-Wmissing-prototypes]
    1970 | void rcu_tasks_generic_setaffinity(int cpu)
         |      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~


vim +/rcu_kthread_setaffinity +602 kernel/rcu/rcu.h

   588	
   589	#ifdef CONFIG_TINY_RCU
   590	static inline bool rcu_dynticks_zero_in_eqs(int cpu, int *vp) { return false; }
   591	static inline unsigned long rcu_get_gp_seq(void) { return 0; }
   592	static inline unsigned long rcu_exp_batches_completed(void) { return 0; }
   593	static inline unsigned long
   594	srcu_batches_completed(struct srcu_struct *sp) { return 0; }
   595	static inline void rcu_force_quiescent_state(void) { }
   596	static inline bool rcu_check_boost_fail(unsigned long gp_state, int *cpup) { return true; }
   597	static inline void show_rcu_gp_kthreads(void) { }
   598	static inline int rcu_get_gp_kthreads_prio(void) { return 0; }
   599	static inline void rcu_fwd_progress_check(unsigned long j) { }
   600	static inline void rcu_gp_slow_register(atomic_t *rgssp) { }
   601	static inline void rcu_gp_slow_unregister(atomic_t *rgssp) { }
 > 602	void rcu_kthread_setaffinity(struct task_struct *tsk, int outgoing) { }
   603	#else /* #ifdef CONFIG_TINY_RCU */
   604	bool rcu_dynticks_zero_in_eqs(int cpu, int *vp);
   605	unsigned long rcu_get_gp_seq(void);
   606	unsigned long rcu_exp_batches_completed(void);
   607	unsigned long srcu_batches_completed(struct srcu_struct *sp);
   608	bool rcu_check_boost_fail(unsigned long gp_state, int *cpup);
   609	void show_rcu_gp_kthreads(void);
   610	int rcu_get_gp_kthreads_prio(void);
   611	void rcu_fwd_progress_check(unsigned long j);
   612	void rcu_force_quiescent_state(void);
   613	void rcu_kthread_setaffinity(struct task_struct *tsk, int outgoing);
   614	extern struct workqueue_struct *rcu_gp_wq;
   615	#ifdef CONFIG_RCU_EXP_KTHREAD
   616	extern struct kthread_worker *rcu_exp_gp_kworker;
   617	extern struct kthread_worker *rcu_exp_par_gp_kworker;
   618	#else /* !CONFIG_RCU_EXP_KTHREAD */
   619	extern struct workqueue_struct *rcu_par_gp_wq;
   620	#endif /* CONFIG_RCU_EXP_KTHREAD */
   621	void rcu_gp_slow_register(atomic_t *rgssp);
   622	void rcu_gp_slow_unregister(atomic_t *rgssp);
   623	#endif /* #else #ifdef CONFIG_TINY_RCU */
   624	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
