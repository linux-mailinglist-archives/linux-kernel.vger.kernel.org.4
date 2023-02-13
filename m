Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78732693D1A
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 04:42:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229505AbjBMDmX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Feb 2023 22:42:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjBMDmW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Feb 2023 22:42:22 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81357CC12
        for <linux-kernel@vger.kernel.org>; Sun, 12 Feb 2023 19:42:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676259739; x=1707795739;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=HVqDQXlbesnHaw/YR8mVcUIQJwZTqRaPvwT4zYlERaQ=;
  b=VWS03hlF18+/KjUNtZWMrSFegrTjXYD5WrHcQex4KZrN7BdXqrNXGhdT
   PFgnQdkkak0kGhF7646BseTmWG4txaE99MKt1Hp8QaTKWcqcQS/iwZG9l
   Cj1y0aXSI/wAO6FiYdtdDFSukceHWBsL2DMhjgGlM7iX9GF8SGKmVteV+
   /9i8+GvxSMPD79hQA7Agkmr7nWUZxgZNQXZRrQ8Rp2Ud677H/ar/fEPr9
   rbLRvzyGYd7B8d5Hy7y+pO2ggropz6Saz6ZWiVjCUpFXORryhqKQlNQFo
   9YGKPDjZauVydqaStW0p7P8uc9T3WEKBcLsrvy7XpeV1z7NGKsvYHyXw5
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10619"; a="332938101"
X-IronPort-AV: E=Sophos;i="5.97,291,1669104000"; 
   d="scan'208";a="332938101"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2023 19:42:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10619"; a="668669990"
X-IronPort-AV: E=Sophos;i="5.97,291,1669104000"; 
   d="scan'208";a="668669990"
Received: from lkp-server01.sh.intel.com (HELO 4455601a8d94) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 12 Feb 2023 19:42:03 -0800
Received: from kbuild by 4455601a8d94 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pRPj9-0007Wl-0s;
        Mon, 13 Feb 2023 03:42:03 +0000
Date:   Mon, 13 Feb 2023 11:41:29 +0800
From:   kernel test robot <lkp@intel.com>
To:     Mike Christie <michael.christie@oracle.com>, brauner@kernel.org,
        ebiederm@xmission.com, torvalds@linux-foundation.org,
        linux-kernel@vger.kernel.org
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        Mike Christie <michael.christie@oracle.com>
Subject: Re: [PATCH 5/5] kernel: Convert kthread to use setup_thread_fn
Message-ID: <202302131159.2TPrVEmE-lkp@intel.com>
References: <20230213010020.1813-6-michael.christie@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230213010020.1813-6-michael.christie@oracle.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mike,

I love your patch! Perhaps something to improve:

[auto build test WARNING on tip/sched/core]
[also build test WARNING on vfs-idmapping/for-next linus/master]
[cannot apply to davem-sparc/master next-20230210]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Mike-Christie/kernel-Move-kernel_clone_args-s-fn-to-new-struct/20230213-090304
patch link:    https://lore.kernel.org/r/20230213010020.1813-6-michael.christie%40oracle.com
patch subject: [PATCH 5/5] kernel: Convert kthread to use setup_thread_fn
config: mips-randconfig-r021-20230213 (https://download.01.org/0day-ci/archive/20230213/202302131159.2TPrVEmE-lkp@intel.com/config)
compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project db0e6591612b53910a1b366863348bdb9d7d2fb1)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install mips cross compiling tool for clang build
        # apt-get install binutils-mipsel-linux-gnu
        # https://github.com/intel-lab-lkp/linux/commit/9b34e5869b059d529620a0144a93c7437411cca0
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Mike-Christie/kernel-Move-kernel_clone_args-s-fn-to-new-struct/20230213-090304
        git checkout 9b34e5869b059d529620a0144a93c7437411cca0
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=mips olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=mips SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202302131159.2TPrVEmE-lkp@intel.com/

All warnings (new ones prefixed by >>):

   kernel/fork.c:162:13: warning: no previous prototype for function 'arch_release_task_struct' [-Wmissing-prototypes]
   void __weak arch_release_task_struct(struct task_struct *tsk)
               ^
   kernel/fork.c:162:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void __weak arch_release_task_struct(struct task_struct *tsk)
   ^
   static 
   kernel/fork.c:862:20: warning: no previous prototype for function 'arch_task_cache_init' [-Wmissing-prototypes]
   void __init __weak arch_task_cache_init(void) { }
                      ^
   kernel/fork.c:862:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void __init __weak arch_task_cache_init(void) { }
   ^
   static 
>> kernel/fork.c:2565:1: warning: unused label 'bad_fork_cleanup_delayacct' [-Wunused-label]
   bad_fork_cleanup_delayacct:
   ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   3 warnings generated.


vim +/bad_fork_cleanup_delayacct +2565 kernel/fork.c

d741bf41d7c7db Peter Zijlstra             2020-08-29  2371  
7e47682ea555e7 Aleksa Sarai               2015-06-09  2372  	/*
7e47682ea555e7 Aleksa Sarai               2015-06-09  2373  	 * Ensure that the cgroup subsystem policies allow the new process to be
7b7b8a2c9560ef Randy Dunlap               2020-10-15  2374  	 * forked. It should be noted that the new process's css_set can be changed
7e47682ea555e7 Aleksa Sarai               2015-06-09  2375  	 * between here and cgroup_post_fork() if an organisation operation is in
7e47682ea555e7 Aleksa Sarai               2015-06-09  2376  	 * progress.
7e47682ea555e7 Aleksa Sarai               2015-06-09  2377  	 */
ef2c41cf38a755 Christian Brauner          2020-02-05  2378  	retval = cgroup_can_fork(p, args);
7e47682ea555e7 Aleksa Sarai               2015-06-09  2379  	if (retval)
5a5cf5cb30d781 Christian Brauner          2020-02-05  2380  		goto bad_fork_put_pidfd;
7e47682ea555e7 Aleksa Sarai               2015-06-09  2381  
b1e8206582f9d6 Peter Zijlstra             2022-02-14  2382  	/*
b1e8206582f9d6 Peter Zijlstra             2022-02-14  2383  	 * Now that the cgroups are pinned, re-clone the parent cgroup and put
b1e8206582f9d6 Peter Zijlstra             2022-02-14  2384  	 * the new task on the correct runqueue. All this *before* the task
b1e8206582f9d6 Peter Zijlstra             2022-02-14  2385  	 * becomes visible.
b1e8206582f9d6 Peter Zijlstra             2022-02-14  2386  	 *
b1e8206582f9d6 Peter Zijlstra             2022-02-14  2387  	 * This isn't part of ->can_fork() because while the re-cloning is
b1e8206582f9d6 Peter Zijlstra             2022-02-14  2388  	 * cgroup specific, it unconditionally needs to place the task on a
b1e8206582f9d6 Peter Zijlstra             2022-02-14  2389  	 * runqueue.
b1e8206582f9d6 Peter Zijlstra             2022-02-14  2390  	 */
b1e8206582f9d6 Peter Zijlstra             2022-02-14  2391  	sched_cgroup_fork(p, args);
b1e8206582f9d6 Peter Zijlstra             2022-02-14  2392  
7b55851367136b David Herrmann             2019-01-08  2393  	/*
7b55851367136b David Herrmann             2019-01-08  2394  	 * From this point on we must avoid any synchronous user-space
7b55851367136b David Herrmann             2019-01-08  2395  	 * communication until we take the tasklist-lock. In particular, we do
7b55851367136b David Herrmann             2019-01-08  2396  	 * not want user-space to be able to predict the process start-time by
7b55851367136b David Herrmann             2019-01-08  2397  	 * stalling fork(2) after we recorded the start_time but before it is
7b55851367136b David Herrmann             2019-01-08  2398  	 * visible to the system.
7b55851367136b David Herrmann             2019-01-08  2399  	 */
7b55851367136b David Herrmann             2019-01-08  2400  
7b55851367136b David Herrmann             2019-01-08  2401  	p->start_time = ktime_get_ns();
cf25e24db61cc9 Peter Zijlstra             2019-11-07  2402  	p->start_boottime = ktime_get_boottime_ns();
7b55851367136b David Herrmann             2019-01-08  2403  
18c830df771f2b Oleg Nesterov              2013-07-03  2404  	/*
18c830df771f2b Oleg Nesterov              2013-07-03  2405  	 * Make it visible to the rest of the system, but dont wake it up yet.
18c830df771f2b Oleg Nesterov              2013-07-03  2406  	 * Need tasklist lock for parent etc handling!
18c830df771f2b Oleg Nesterov              2013-07-03  2407  	 */
^1da177e4c3f41 Linus Torvalds             2005-04-16  2408  	write_lock_irq(&tasklist_lock);
^1da177e4c3f41 Linus Torvalds             2005-04-16  2409  
^1da177e4c3f41 Linus Torvalds             2005-04-16  2410  	/* CLONE_PARENT re-uses the old parent */
2d5516cbb9daf7 Oleg Nesterov              2009-03-02  2411  	if (clone_flags & (CLONE_PARENT|CLONE_THREAD)) {
^1da177e4c3f41 Linus Torvalds             2005-04-16  2412  		p->real_parent = current->real_parent;
2d5516cbb9daf7 Oleg Nesterov              2009-03-02  2413  		p->parent_exec_id = current->parent_exec_id;
b4e00444cab4c3 Eddy Wu                    2020-11-07  2414  		if (clone_flags & CLONE_THREAD)
b4e00444cab4c3 Eddy Wu                    2020-11-07  2415  			p->exit_signal = -1;
b4e00444cab4c3 Eddy Wu                    2020-11-07  2416  		else
b4e00444cab4c3 Eddy Wu                    2020-11-07  2417  			p->exit_signal = current->group_leader->exit_signal;
2d5516cbb9daf7 Oleg Nesterov              2009-03-02  2418  	} else {
^1da177e4c3f41 Linus Torvalds             2005-04-16  2419  		p->real_parent = current;
2d5516cbb9daf7 Oleg Nesterov              2009-03-02  2420  		p->parent_exec_id = current->self_exec_id;
b4e00444cab4c3 Eddy Wu                    2020-11-07  2421  		p->exit_signal = args->exit_signal;
2d5516cbb9daf7 Oleg Nesterov              2009-03-02  2422  	}
^1da177e4c3f41 Linus Torvalds             2005-04-16  2423  
d83a7cb375eec2 Josh Poimboeuf             2017-02-13  2424  	klp_copy_process(p);
d83a7cb375eec2 Josh Poimboeuf             2017-02-13  2425  
85dd3f61203c5c Peter Zijlstra             2021-03-29  2426  	sched_core_fork(p);
85dd3f61203c5c Peter Zijlstra             2021-03-29  2427  
^1da177e4c3f41 Linus Torvalds             2005-04-16  2428  	spin_lock(&current->sighand->siglock);
4a2c7a7837da1b Oleg Nesterov              2006-03-28  2429  
792575348ff70e Daniel Bristot de Oliveira 2022-07-29  2430  	rv_task_fork(p);
792575348ff70e Daniel Bristot de Oliveira 2022-07-29  2431  
d7822b1e24f2df Mathieu Desnoyers          2018-06-02  2432  	rseq_fork(p, clone_flags);
d7822b1e24f2df Mathieu Desnoyers          2018-06-02  2433  
4ca1d3ee46130e Eric W. Biederman          2018-07-13  2434  	/* Don't start children in a dying pid namespace */
e8cfbc245e2488 Gargi Sharma               2017-11-17  2435  	if (unlikely(!(ns_of_pid(pid)->pid_allocated & PIDNS_ADDING))) {
3fd37226216620 Kirill Tkhai               2017-05-12  2436  		retval = -ENOMEM;
3fd37226216620 Kirill Tkhai               2017-05-12  2437  		goto bad_fork_cancel_cgroup;
3fd37226216620 Kirill Tkhai               2017-05-12  2438  	}
4a2c7a7837da1b Oleg Nesterov              2006-03-28  2439  
7673bf553b2732 Eric W. Biederman          2018-07-23  2440  	/* Let kill terminate clone/fork in the middle */
7673bf553b2732 Eric W. Biederman          2018-07-23  2441  	if (fatal_signal_pending(current)) {
7673bf553b2732 Eric W. Biederman          2018-07-23  2442  		retval = -EINTR;
7673bf553b2732 Eric W. Biederman          2018-07-23  2443  		goto bad_fork_cancel_cgroup;
7673bf553b2732 Eric W. Biederman          2018-07-23  2444  	}
7673bf553b2732 Eric W. Biederman          2018-07-23  2445  
a1140cb215fa13 Kuniyuki Iwashima          2022-08-23  2446  	/* No more failure paths after this point. */
a1140cb215fa13 Kuniyuki Iwashima          2022-08-23  2447  
a1140cb215fa13 Kuniyuki Iwashima          2022-08-23  2448  	/*
a1140cb215fa13 Kuniyuki Iwashima          2022-08-23  2449  	 * Copy seccomp details explicitly here, in case they were changed
a1140cb215fa13 Kuniyuki Iwashima          2022-08-23  2450  	 * before holding sighand lock.
a1140cb215fa13 Kuniyuki Iwashima          2022-08-23  2451  	 */
a1140cb215fa13 Kuniyuki Iwashima          2022-08-23  2452  	copy_seccomp(p);
a1140cb215fa13 Kuniyuki Iwashima          2022-08-23  2453  
2c4704756cab7c Eric W. Biederman          2017-09-26  2454  	init_task_pid_links(p);
73b9ebfe126a4a Oleg Nesterov              2006-03-28  2455  	if (likely(p->pid)) {
4b9d33e6d83cc0 Tejun Heo                  2011-06-17  2456  		ptrace_init_task(p, (clone_flags & CLONE_PTRACE) || trace);
^1da177e4c3f41 Linus Torvalds             2005-04-16  2457  
8190773985141f Oleg Nesterov              2013-07-03  2458  		init_task_pid(p, PIDTYPE_PID, pid);
^1da177e4c3f41 Linus Torvalds             2005-04-16  2459  		if (thread_group_leader(p)) {
6883f81aac6f44 Eric W. Biederman          2017-06-04  2460  			init_task_pid(p, PIDTYPE_TGID, pid);
8190773985141f Oleg Nesterov              2013-07-03  2461  			init_task_pid(p, PIDTYPE_PGID, task_pgrp(current));
8190773985141f Oleg Nesterov              2013-07-03  2462  			init_task_pid(p, PIDTYPE_SID, task_session(current));
8190773985141f Oleg Nesterov              2013-07-03  2463  
1c4042c29bd2e8 Eric W. Biederman          2010-07-12  2464  			if (is_child_reaper(pid)) {
17cf22c33e1f1b Eric W. Biederman          2010-03-02  2465  				ns_of_pid(pid)->child_reaper = p;
1c4042c29bd2e8 Eric W. Biederman          2010-07-12  2466  				p->signal->flags |= SIGNAL_UNKILLABLE;
1c4042c29bd2e8 Eric W. Biederman          2010-07-12  2467  			}
c3ad2c3b02e953 Eric W. Biederman          2018-07-23  2468  			p->signal->shared_pending.signal = delayed.signal;
9c9f4ded90a59e Alan Cox                   2008-10-13  2469  			p->signal->tty = tty_kref_get(current->signal->tty);
749860ce242798 Pavel Tikhomirov           2017-01-30  2470  			/*
749860ce242798 Pavel Tikhomirov           2017-01-30  2471  			 * Inherit has_child_subreaper flag under the same
749860ce242798 Pavel Tikhomirov           2017-01-30  2472  			 * tasklist_lock with adding child to the process tree
749860ce242798 Pavel Tikhomirov           2017-01-30  2473  			 * for propagate_has_child_subreaper optimization.
749860ce242798 Pavel Tikhomirov           2017-01-30  2474  			 */
749860ce242798 Pavel Tikhomirov           2017-01-30  2475  			p->signal->has_child_subreaper = p->real_parent->signal->has_child_subreaper ||
749860ce242798 Pavel Tikhomirov           2017-01-30  2476  							 p->real_parent->signal->is_child_subreaper;
9cd80bbb07fcd6 Oleg Nesterov              2009-12-17  2477  			list_add_tail(&p->sibling, &p->real_parent->children);
5e85d4abe3f43b Eric W. Biederman          2006-04-18  2478  			list_add_tail_rcu(&p->tasks, &init_task.tasks);
6883f81aac6f44 Eric W. Biederman          2017-06-04  2479  			attach_pid(p, PIDTYPE_TGID);
8190773985141f Oleg Nesterov              2013-07-03  2480  			attach_pid(p, PIDTYPE_PGID);
8190773985141f Oleg Nesterov              2013-07-03  2481  			attach_pid(p, PIDTYPE_SID);
909ea96468096b Christoph Lameter          2010-12-08  2482  			__this_cpu_inc(process_counts);
80628ca06c5d42 Oleg Nesterov              2013-07-03  2483  		} else {
80628ca06c5d42 Oleg Nesterov              2013-07-03  2484  			current->signal->nr_threads++;
d80f7d7b2c75c5 Eric W. Biederman          2022-06-21  2485  			current->signal->quick_threads++;
80628ca06c5d42 Oleg Nesterov              2013-07-03  2486  			atomic_inc(&current->signal->live);
60d4de3ff7f775 Elena Reshetova            2019-01-18  2487  			refcount_inc(&current->signal->sigcnt);
924de3b8c9410c Eric W. Biederman          2018-07-23  2488  			task_join_group_stop(p);
80628ca06c5d42 Oleg Nesterov              2013-07-03  2489  			list_add_tail_rcu(&p->thread_group,
80628ca06c5d42 Oleg Nesterov              2013-07-03  2490  					  &p->group_leader->thread_group);
0c740d0afc3bff Oleg Nesterov              2014-01-21  2491  			list_add_tail_rcu(&p->thread_node,
0c740d0afc3bff Oleg Nesterov              2014-01-21  2492  					  &p->signal->thread_head);
^1da177e4c3f41 Linus Torvalds             2005-04-16  2493  		}
8190773985141f Oleg Nesterov              2013-07-03  2494  		attach_pid(p, PIDTYPE_PID);
^1da177e4c3f41 Linus Torvalds             2005-04-16  2495  		nr_threads++;
73b9ebfe126a4a Oleg Nesterov              2006-03-28  2496  	}
^1da177e4c3f41 Linus Torvalds             2005-04-16  2497  	total_forks++;
c3ad2c3b02e953 Eric W. Biederman          2018-07-23  2498  	hlist_del_init(&delayed.node);
3f17da699431ec Oleg Nesterov              2006-02-15  2499  	spin_unlock(&current->sighand->siglock);
4af4206be2bd19 Oleg Nesterov              2014-04-13  2500  	syscall_tracepoint_update(p);
^1da177e4c3f41 Linus Torvalds             2005-04-16  2501  	write_unlock_irq(&tasklist_lock);
4af4206be2bd19 Oleg Nesterov              2014-04-13  2502  
ddc204b517e60a Waiman Long                2022-02-08  2503  	if (pidfile)
ddc204b517e60a Waiman Long                2022-02-08  2504  		fd_install(pidfd, pidfile);
ddc204b517e60a Waiman Long                2022-02-08  2505  
c13cf856cbe16a Andrew Morton              2005-11-28  2506  	proc_fork_connector(p);
b1e8206582f9d6 Peter Zijlstra             2022-02-14  2507  	sched_post_fork(p);
ef2c41cf38a755 Christian Brauner          2020-02-05  2508  	cgroup_post_fork(p, args);
cdd6c482c9ff9c Ingo Molnar                2009-09-21  2509  	perf_event_fork(p);
43d2b113241d67 KAMEZAWA Hiroyuki          2012-01-10  2510  
43d2b113241d67 KAMEZAWA Hiroyuki          2012-01-10  2511  	trace_task_newtask(p, clone_flags);
3ab679661721b1 Oleg Nesterov              2013-10-16  2512  	uprobe_copy_process(p, clone_flags);
43d2b113241d67 KAMEZAWA Hiroyuki          2012-01-10  2513  
67197a4f28d28d Suren Baghdasaryan         2020-10-13  2514  	copy_oom_score_adj(clone_flags, p);
67197a4f28d28d Suren Baghdasaryan         2020-10-13  2515  
^1da177e4c3f41 Linus Torvalds             2005-04-16  2516  	return p;
^1da177e4c3f41 Linus Torvalds             2005-04-16  2517  
7e47682ea555e7 Aleksa Sarai               2015-06-09  2518  bad_fork_cancel_cgroup:
85dd3f61203c5c Peter Zijlstra             2021-03-29  2519  	sched_core_free(p);
3fd37226216620 Kirill Tkhai               2017-05-12  2520  	spin_unlock(&current->sighand->siglock);
3fd37226216620 Kirill Tkhai               2017-05-12  2521  	write_unlock_irq(&tasklist_lock);
ef2c41cf38a755 Christian Brauner          2020-02-05  2522  	cgroup_cancel_fork(p, args);
b3e5838252665e Christian Brauner          2019-03-27  2523  bad_fork_put_pidfd:
6fd2fe494b17bf Al Viro                    2019-06-26  2524  	if (clone_flags & CLONE_PIDFD) {
6fd2fe494b17bf Al Viro                    2019-06-26  2525  		fput(pidfile);
6fd2fe494b17bf Al Viro                    2019-06-26  2526  		put_unused_fd(pidfd);
6fd2fe494b17bf Al Viro                    2019-06-26  2527  	}
425fb2b4bf5dde Pavel Emelyanov            2007-10-18  2528  bad_fork_free_pid:
425fb2b4bf5dde Pavel Emelyanov            2007-10-18  2529  	if (pid != &init_struct_pid)
425fb2b4bf5dde Pavel Emelyanov            2007-10-18  2530  		free_pid(pid);
0740aa5f637568 Jiri Slaby                 2016-05-20  2531  bad_fork_cleanup_thread:
0740aa5f637568 Jiri Slaby                 2016-05-20  2532  	exit_thread(p);
fd0928df98b957 Jens Axboe                 2008-01-24  2533  bad_fork_cleanup_io:
b69f2292063d2c Louis Rilling              2009-12-04  2534  	if (p->io_context)
b69f2292063d2c Louis Rilling              2009-12-04  2535  		exit_io_context(p);
ab516013ad9ca4 Serge E. Hallyn            2006-10-02  2536  bad_fork_cleanup_namespaces:
444f378b237a0f Linus Torvalds             2007-01-30  2537  	exit_task_namespaces(p);
^1da177e4c3f41 Linus Torvalds             2005-04-16  2538  bad_fork_cleanup_mm:
c3f3ce049f7d97 Andrea Arcangeli           2019-05-14  2539  	if (p->mm) {
c3f3ce049f7d97 Andrea Arcangeli           2019-05-14  2540  		mm_clear_owner(p->mm, p);
^1da177e4c3f41 Linus Torvalds             2005-04-16  2541  		mmput(p->mm);
c3f3ce049f7d97 Andrea Arcangeli           2019-05-14  2542  	}
^1da177e4c3f41 Linus Torvalds             2005-04-16  2543  bad_fork_cleanup_signal:
4ab6c08336535f Oleg Nesterov              2009-08-26  2544  	if (!(clone_flags & CLONE_THREAD))
1c5354de90c900 Mike Galbraith             2011-01-05  2545  		free_signal_struct(p->signal);
^1da177e4c3f41 Linus Torvalds             2005-04-16  2546  bad_fork_cleanup_sighand:
a7e5328a06a2be Oleg Nesterov              2006-03-28  2547  	__cleanup_sighand(p->sighand);
^1da177e4c3f41 Linus Torvalds             2005-04-16  2548  bad_fork_cleanup_fs:
^1da177e4c3f41 Linus Torvalds             2005-04-16  2549  	exit_fs(p); /* blocking */
^1da177e4c3f41 Linus Torvalds             2005-04-16  2550  bad_fork_cleanup_files:
^1da177e4c3f41 Linus Torvalds             2005-04-16  2551  	exit_files(p); /* blocking */
^1da177e4c3f41 Linus Torvalds             2005-04-16  2552  bad_fork_cleanup_semundo:
^1da177e4c3f41 Linus Torvalds             2005-04-16  2553  	exit_sem(p);
e4e55b47ed9ae2 Tetsuo Handa               2017-03-24  2554  bad_fork_cleanup_security:
e4e55b47ed9ae2 Tetsuo Handa               2017-03-24  2555  	security_task_free(p);
^1da177e4c3f41 Linus Torvalds             2005-04-16  2556  bad_fork_cleanup_audit:
^1da177e4c3f41 Linus Torvalds             2005-04-16  2557  	audit_free(p);
6c72e3501d0d62 Peter Zijlstra             2014-10-02  2558  bad_fork_cleanup_perf:
cdd6c482c9ff9c Ingo Molnar                2009-09-21  2559  	perf_event_free_task(p);
6c72e3501d0d62 Peter Zijlstra             2014-10-02  2560  bad_fork_cleanup_policy:
b09be676e0ff25 Byungchul Park             2017-08-07  2561  	lockdep_free_task(p);
^1da177e4c3f41 Linus Torvalds             2005-04-16  2562  #ifdef CONFIG_NUMA
f0be3d32b05d3f Lee Schermerhorn           2008-04-28  2563  	mpol_put(p->mempolicy);
^1da177e4c3f41 Linus Torvalds             2005-04-16  2564  #endif
ff8288ff475e47 Eric W. Biederman          2021-12-20 @2565  bad_fork_cleanup_delayacct:
35df17c57cecb0 Shailabh Nagar             2006-08-31  2566  	delayacct_tsk_free(p);
^1da177e4c3f41 Linus Torvalds             2005-04-16  2567  bad_fork_cleanup_count:
21d1c5e386bc75 Alexey Gladkov             2021-04-22  2568  	dec_rlimit_ucounts(task_ucounts(p), UCOUNT_RLIMIT_NPROC, 1);
e0e817392b9acf David Howells              2009-09-02  2569  	exit_creds(p);
^1da177e4c3f41 Linus Torvalds             2005-04-16  2570  bad_fork_free:
2f064a59a11ff9 Peter Zijlstra             2021-06-11  2571  	WRITE_ONCE(p->__state, TASK_DEAD);
1a03d3f13ffe5d Sebastian Andrzej Siewior  2022-02-17  2572  	exit_task_stack_account(p);
68f24b08ee892d Andy Lutomirski            2016-09-15  2573  	put_task_stack(p);
c3f3ce049f7d97 Andrea Arcangeli           2019-05-14  2574  	delayed_free_task(p);
fe7d37d1fbf8ff Oleg Nesterov              2006-01-08  2575  fork_out:
c3ad2c3b02e953 Eric W. Biederman          2018-07-23  2576  	spin_lock_irq(&current->sighand->siglock);
c3ad2c3b02e953 Eric W. Biederman          2018-07-23  2577  	hlist_del_init(&delayed.node);
c3ad2c3b02e953 Eric W. Biederman          2018-07-23  2578  	spin_unlock_irq(&current->sighand->siglock);
fe7d37d1fbf8ff Oleg Nesterov              2006-01-08  2579  	return ERR_PTR(retval);
^1da177e4c3f41 Linus Torvalds             2005-04-16  2580  }
^1da177e4c3f41 Linus Torvalds             2005-04-16  2581  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
