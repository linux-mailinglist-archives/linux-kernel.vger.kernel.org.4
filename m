Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B36B3719F99
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 16:19:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233357AbjFAOTp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 10:19:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231979AbjFAOTm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 10:19:42 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0306898
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jun 2023 07:19:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685629181; x=1717165181;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=DSDN5k1kg7zMtn4HoSQecnaxCAPv4uA/njqSSLYpFfk=;
  b=IVzJXgRGiVXrkc9VRULyVe9fKockEKSUF5Q/I6Dbf5DEhX9aW0E3UgKi
   gZ1HPQAAtnnw9tYR1ILhxCa3uaNEl0x9g1z6H71nx0MK2gGAjZwerXCkk
   GXlF1Jp1T9Wu/qVl7WcIv31rLOycyFTHJn0PnA0fpKRPlU6zTbVoKJNhF
   QreoB0ImaN/uwu03/RPOA/GJYSM6Ys77lnWgEBDlRCCdIP3qjQI2ckBoX
   jyQFz8KIQhAeREaCgihBN3BYr4xO3tRMcp3OjpJc3+ooYJTU7jTGxVmEz
   +evuuW7rB/2VNHNjnjb93rwVCY3nTrTxvxx07C+PuHin4N7a6MxmzoW16
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10728"; a="441931598"
X-IronPort-AV: E=Sophos;i="6.00,210,1681196400"; 
   d="scan'208";a="441931598"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2023 07:19:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10728"; a="819811079"
X-IronPort-AV: E=Sophos;i="6.00,210,1681196400"; 
   d="scan'208";a="819811079"
Received: from lkp-server01.sh.intel.com (HELO fb1ced2c09fb) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 01 Jun 2023 07:19:17 -0700
Received: from kbuild by fb1ced2c09fb with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1q4j93-0002M7-0g;
        Thu, 01 Jun 2023 14:19:17 +0000
Date:   Thu, 1 Jun 2023 22:18:16 +0800
From:   kernel test robot <lkp@intel.com>
To:     John Stultz <jstultz@google.com>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     oe-kbuild-all@lists.linux.dev, Connor O'Brien <connoro@google.com>,
        Joel Fernandes <joelaf@google.com>,
        Qais Yousef <qyousef@google.com>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>,
        Zimuzo Ezeozue <zezeozue@google.com>,
        Youssef Esmat <youssefesmat@google.com>,
        Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>, kernel-team@android.com,
        John Stultz <jstultz@google.com>
Subject: Re: [PATCH v4 12/13] sched: Attempt to fix rt/dl load balancing via
 chain level balance
Message-ID: <202306011700.Ej6S3znC-lkp@intel.com>
References: <20230601055846.2349566-13-jstultz@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230601055846.2349566-13-jstultz@google.com>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi John,

kernel test robot noticed the following build warnings:

[auto build test WARNING on tip/sched/core]
[also build test WARNING on tip/locking/core tip/master tip/auto-latest linus/master v6.4-rc4 next-20230601]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/John-Stultz/sched-Unify-runtime-accounting-across-classes/20230601-140200
base:   tip/sched/core
patch link:    https://lore.kernel.org/r/20230601055846.2349566-13-jstultz%40google.com
patch subject: [PATCH v4 12/13] sched: Attempt to fix rt/dl load balancing via chain level balance
config: m68k-allyesconfig (https://download.01.org/0day-ci/archive/20230601/202306011700.Ej6S3znC-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 12.3.0
reproduce (this is a W=1 build):
        mkdir -p ~/bin
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/82593266398c6feaed3ed5ec458986d8e16b6b74
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review John-Stultz/sched-Unify-runtime-accounting-across-classes/20230601-140200
        git checkout 82593266398c6feaed3ed5ec458986d8e16b6b74
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.3.0 ~/bin/make.cross W=1 O=build_dir ARCH=m68k olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.3.0 ~/bin/make.cross W=1 O=build_dir ARCH=m68k SHELL=/bin/bash kernel/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202306011700.Ej6S3znC-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> kernel/sched/core.c:3838:6: warning: no previous prototype for 'push_task_chain' [-Wmissing-prototypes]
    3838 | void push_task_chain(struct rq *rq, struct rq *dst_rq, struct task_struct *task)
         |      ^~~~~~~~~~~~~~~
   kernel/sched/core.c: In function 'push_task_chain':
   kernel/sched/core.c:3858:42: error: 'struct rq' has no member named 'cpu'
    3858 |                 set_task_cpu(task, dst_rq->cpu);
         |                                          ^~
   kernel/sched/core.c: At top level:
>> kernel/sched/core.c:3870:21: warning: no previous prototype for 'find_exec_ctx' [-Wmissing-prototypes]
    3870 | struct task_struct *find_exec_ctx(struct rq *rq, struct task_struct *p)
         |                     ^~~~~~~~~~~~~
>> kernel/sched/core.c:3898:5: warning: no previous prototype for 'pushable_chain' [-Wmissing-prototypes]
    3898 | int pushable_chain(struct rq *rq, struct task_struct *p, int cpu)
         |     ^~~~~~~~~~~~~~
   kernel/sched/core.c:3930:6: warning: no previous prototype for 'ttwu_proxy_skip_wakeup' [-Wmissing-prototypes]
    3930 | bool ttwu_proxy_skip_wakeup(struct rq *rq, struct task_struct *p)
         |      ^~~~~~~~~~~~~~~~~~~~~~
   kernel/sched/core.c: In function 'proxy_migrate_task':
   kernel/sched/core.c:6835:35: error: 'struct task_struct' has no member named 'wake_cpu'; did you mean 'wake_q'?
    6835 |                 int wake_cpu = p->wake_cpu;
         |                                   ^~~~~~~~
         |                                   wake_q
   kernel/sched/core.c:6851:20: error: 'struct task_struct' has no member named 'wake_cpu'; did you mean 'wake_q'?
    6851 |                 p->wake_cpu = wake_cpu;
         |                    ^~~~~~~~
         |                    wake_q
   kernel/sched/core.c:6854:15: error: 'struct rq' has no member named 'balance_callback'
    6854 |         if (rq->balance_callback)
         |               ^~


vim +/push_task_chain +3838 kernel/sched/core.c

  3837	
> 3838	void push_task_chain(struct rq *rq, struct rq *dst_rq, struct task_struct *task)
  3839	{
  3840		struct task_struct *owner;
  3841	
  3842		lockdep_assert_rq_held(rq);
  3843		lockdep_assert_rq_held(dst_rq);
  3844	
  3845		BUG_ON(!task_queued_on_rq(rq, task));
  3846		BUG_ON(task_current_selected(rq, task));
  3847	
  3848		while (task) {
  3849			if (!task_queued_on_rq(rq, task) || task_current_selected(rq, task))
  3850				break;
  3851	
  3852			if (task_is_blocked(task))
  3853				owner = __mutex_owner(task->blocked_on);
  3854			else
  3855				owner = NULL;
  3856	
  3857			deactivate_task(rq, task, 0);
> 3858			set_task_cpu(task, dst_rq->cpu);
  3859			activate_task(dst_rq, task, 0);
  3860			if (task == owner)
  3861				break;
  3862			task = owner;
  3863		}
  3864	}
  3865	
  3866	/*
  3867	 * Returns the unblocked task at the end of the blocked chain starting with p
  3868	 * if that chain is composed entirely of tasks enqueued on rq, or NULL otherwise.
  3869	 */
> 3870	struct task_struct *find_exec_ctx(struct rq *rq, struct task_struct *p)
  3871	{
  3872		struct task_struct *exec_ctx, *owner;
  3873		struct mutex *mutex;
  3874	
  3875		lockdep_assert_rq_held(rq);
  3876	
  3877		for (exec_ctx = p; task_is_blocked(exec_ctx) && !task_on_cpu(rq, exec_ctx);
  3878								exec_ctx = owner) {
  3879			mutex = exec_ctx->blocked_on;
  3880			owner = __mutex_owner(mutex);
  3881			if (owner == exec_ctx)
  3882				break;
  3883	
  3884			if (!task_queued_on_rq(rq, owner) || task_current_selected(rq, owner)) {
  3885				exec_ctx = NULL;
  3886				break;
  3887			}
  3888		}
  3889		return exec_ctx;
  3890	}
  3891	
  3892	/*
  3893	 * Returns:
  3894	 * 1 if chain is pushable and affinity does not prevent pushing to cpu
  3895	 * 0 if chain is unpushable
  3896	 * -1 if chain is pushable but affinity blocks running on cpu.
  3897	 */
> 3898	int pushable_chain(struct rq *rq, struct task_struct *p, int cpu)
  3899	{
  3900		struct task_struct *exec_ctx;
  3901	
  3902		lockdep_assert_rq_held(rq);
  3903	
  3904		if (task_rq(p) != rq || !task_on_rq_queued(p))
  3905			return 0;
  3906	
  3907		exec_ctx = find_exec_ctx(rq, p);
  3908		/*
  3909		 * Chain leads off the rq, we're free to push it anywhere.
  3910		 *
  3911		 * One wrinkle with relying on find_exec_ctx is that when the chain
  3912		 * leads to a task currently migrating to rq, we see the chain as
  3913		 * pushable & push everything prior to the migrating task. Even if
  3914		 * we checked explicitly for this case, we could still race with a
  3915		 * migration after the check.
  3916		 * This shouldn't permanently produce a bad state though, as proxy()
  3917		 * will send the chain back to rq and by that point the migration
  3918		 * should be complete & a proper push can occur.
  3919		 */
  3920		if (!exec_ctx)
  3921			return 1;
  3922	
  3923		if (task_on_cpu(rq, exec_ctx) || exec_ctx->nr_cpus_allowed <= 1)
  3924			return 0;
  3925	
  3926		return cpumask_test_cpu(cpu, &exec_ctx->cpus_mask) ? 1 : -1;
  3927	}
  3928	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
