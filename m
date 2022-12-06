Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AD3B644393
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 13:56:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234391AbiLFM4f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 07:56:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234853AbiLFM4R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 07:56:17 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D516718385
        for <linux-kernel@vger.kernel.org>; Tue,  6 Dec 2022 04:56:15 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EDEA6B819C8
        for <linux-kernel@vger.kernel.org>; Tue,  6 Dec 2022 12:56:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 143C5C433D7;
        Tue,  6 Dec 2022 12:56:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670331372;
        bh=mt4++JDWt1KoknBKcmnGSudtaelO/LGWQVmWksgM64A=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=g6+GX3xg/MjvjxAIkX1Bl4UDcmFpBqPZ44DH6MPbDdTQvIHHUFQIhsHOWxfnfsx1a
         UGOfIQ1+qagM0uTWL2tcdrUrKtDJ/Off8BonRezBCu3QOaGhuYGc4du7jzOhJuEDCZ
         39v4REbey169THlAILWVXvkauaBgPYdK6fDItHx2aAdVXxDrzgdKrkAczRcmqVPuBM
         kLsgk9DlRJMNtHjuZPOfe2UAoeEgKaQZlsw8tPRhJxfb6zkO++Dtn0tevt21hVLVMZ
         oCVy6jLAZAXIoaNW9235ZvebxGOHRA53pRN0h5iU9r+CTWDxIRBUADqiLTqpfBbeF4
         P4roRUxdGtN7w==
Date:   Tue, 6 Dec 2022 21:56:09 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     kernel test robot <lkp@intel.com>
Cc:     David Howells <dhowells@redhat.com>, oe-kbuild-all@lists.linux.dev,
        rostedt@goodmis.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tracing: Fix complicated dependency of
Message-Id: <20221206215609.d56e2dc519b5ab9bd03729a8@kernel.org>
In-Reply-To: <202212052253.VuhZ2ulJ-lkp@intel.com>
References: <20221205180617.9b9d3971cbe06ee536603523@kernel.org>
        <202212052253.VuhZ2ulJ-lkp@intel.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 5 Dec 2022 23:10:19 +0800
kernel test robot <lkp@intel.com> wrote:

> Hi Masami,
> 
> Thank you for the patch! Yet something to improve:
> 
> [auto build test ERROR on rostedt-trace/for-next]
> [also build test ERROR on linus/master]
> [cannot apply to rostedt-trace/for-next-urgent]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Masami-Hiramatsu/tracing-Fix-complicated-dependency-of/20221205-170923
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git for-next
> patch link:    https://lore.kernel.org/r/20221205180617.9b9d3971cbe06ee536603523%40kernel.org
> patch subject: [PATCH] tracing: Fix complicated dependency of
> config: arm64-randconfig-r011-20221205
> compiler: aarch64-linux-gcc (GCC) 12.1.0
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://github.com/intel-lab-lkp/linux/commit/32c12975c448f06f79a6797d4793d9e60b3040df
>         git remote add linux-review https://github.com/intel-lab-lkp/linux
>         git fetch --no-tags linux-review Masami-Hiramatsu/tracing-Fix-complicated-dependency-of/20221205-170923
>         git checkout 32c12975c448f06f79a6797d4793d9e60b3040df
>         # save the config file
>         mkdir build_dir && cp config build_dir/.config
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=arm64 SHELL=/bin/bash kernel/
> 
> If you fix the issue, kindly add following tag where applicable
> | Reported-by: kernel test robot <lkp@intel.com>
> 
> All errors (new ones prefixed by >>):
> 
>    kernel/trace/trace.c: In function 'update_max_tr':
>    kernel/trace/trace.c:1842:2: warning: label 'out_unlock' defined but not used [-Wunused-label]
>     1842 |  out_unlock:
>          |  ^~~~~~~~~~

OK, this seems clearly an issue in this function with/without this patch.
But this patch kicks the issue. Why? since the original code is under
a complicated #ifdef hell.

As I pointed, CONFIG_OSNOISE_TRACER and CONFIG_HWLAT_TRACER will enable
a part of the CONFIG_TRACER_MAX_TRACE code. And the update_max_tr() is
NOT included that part.
The rest of the CONFIG_TRACER_MAX_TRACE code is enabled either one of
CONFIG_IRQSOFF_TRACER, CONFIG_PREEMPT_TRACER or CONFIG_SCHED_TRACER.
And those 3 kconfigs also selects CONFIG_TRACER_SNAPSHOT.

In the result, when CONFIG_OSNOISE_TRACER or CONFIG_HWLAT_TRACER is
enabled but all of CONFIG_IRQSOFF_TRACER, CONFIG_PREEMPT_TRACER and
CONFIG_SCHED_TRACER are disabled, the update_max_tr() is NOT compiled.
When one of CONFIG_IRQSOFF_TRACER, CONFIG_PREEMPT_TRACER or
CONFIG_SCHED_TRACER is enabled, update_max_tr() is compiled with
CONFIG_TRACER_SNAPSHOT=y.

For simplifying the dependency, I made the CONFIG_OSNOISE_TRACER and
CONFIG_HWLAT_TRACER selected CONFIG_TRACER_MAX_TRACE, but didn't select
CONFIG_TRACER_SNAPSHOT. Thus this error happens.


>    kernel/trace/trace.c: In function 'trace_check_vprintf':
>    kernel/trace/trace.c:3860:17: warning: function 'trace_check_vprintf' might be a candidate for 'gnu_printf' format attribute [-Wsuggest-attribute=format]
>     3860 |                 trace_seq_vprintf(&iter->seq, iter->fmt, ap);
>          |                 ^~~~~~~~~~~~~~~~~
>    kernel/trace/trace.c:3927:17: warning: function 'trace_check_vprintf' might be a candidate for 'gnu_printf' format attribute [-Wsuggest-attribute=format]
>     3927 |                 trace_seq_vprintf(&iter->seq, p, ap);
>          |                 ^~~~~~~~~~~~~~~~~

These should be fixed by David's printf patch.

>    kernel/trace/trace.c: In function 'tracing_set_tracer':
> >> kernel/trace/trace.c:6445:17: error: implicit declaration of function 'free_snapshot'; did you mean 'boot_snapshot'? [-Werror=implicit-function-declaration]
>     6445 |                 free_snapshot(tr);
>          |                 ^~~~~~~~~~~~~
>          |                 boot_snapshot
>    cc1: some warnings being treated as errors

This is the same issue of the CONFIG_TRACER_MAX_TRACE and 
CONFIG_TRACER_SNAPSHOT. I will fix it by adding #ifdef 
CONFIG_TRACER_SNAPSHOT this time. But I'm not sure the
CONFIG_OSNOISE_TRACER and CONFIG_HWLAT_TRACER really don't need the
snapshot feature?

Thank you,

> 
> 
> vim +6445 kernel/trace/trace.c
> 
> 09d23a1d8a82e8 Steven Rostedt (Red Hat  2015-02-03  6362) 
> 9c5b9d3d65e485 Masami Hiramatsu         2020-01-11  6363  int tracing_set_tracer(struct trace_array *tr, const char *buf)
> 09d23a1d8a82e8 Steven Rostedt (Red Hat  2015-02-03  6364) {
> bc0c38d139ec7f Steven Rostedt           2008-05-12  6365  	struct tracer *t;
> 12883efb670c28 Steven Rostedt (Red Hat  2013-03-05  6366) #ifdef CONFIG_TRACER_MAX_TRACE
> 34600f0e9c33c9 Steven Rostedt           2013-01-22  6367  	bool had_max_tr;
> 12883efb670c28 Steven Rostedt (Red Hat  2013-03-05  6368) #endif
> d9e540762f5cdd Peter Zijlstra           2008-11-01  6369  	int ret = 0;
> bc0c38d139ec7f Steven Rostedt           2008-05-12  6370  
> 1027fcb206a0fb Steven Rostedt           2009-03-12  6371  	mutex_lock(&trace_types_lock);
> 1027fcb206a0fb Steven Rostedt           2009-03-12  6372  
> 73c5162aa362a5 Steven Rostedt           2009-03-11  6373  	if (!ring_buffer_expanded) {
> 2b6080f28c7cc3 Steven Rostedt           2012-05-11  6374  		ret = __tracing_resize_ring_buffer(tr, trace_buf_size,
> 438ced1720b584 Vaibhav Nagarnaik        2012-02-02  6375  						RING_BUFFER_ALL_CPUS);
> 73c5162aa362a5 Steven Rostedt           2009-03-11  6376  		if (ret < 0)
> 59f586db98919d Frederic Weisbecker      2009-03-15  6377  			goto out;
> 73c5162aa362a5 Steven Rostedt           2009-03-11  6378  		ret = 0;
> 73c5162aa362a5 Steven Rostedt           2009-03-11  6379  	}
> 73c5162aa362a5 Steven Rostedt           2009-03-11  6380  
> bc0c38d139ec7f Steven Rostedt           2008-05-12  6381  	for (t = trace_types; t; t = t->next) {
> bc0c38d139ec7f Steven Rostedt           2008-05-12  6382  		if (strcmp(t->name, buf) == 0)
> bc0c38d139ec7f Steven Rostedt           2008-05-12  6383  			break;
> bc0c38d139ec7f Steven Rostedt           2008-05-12  6384  	}
> c2931e05ec5965 Frederic Weisbecker      2008-10-04  6385  	if (!t) {
> c2931e05ec5965 Frederic Weisbecker      2008-10-04  6386  		ret = -EINVAL;
> c2931e05ec5965 Frederic Weisbecker      2008-10-04  6387  		goto out;
> c2931e05ec5965 Frederic Weisbecker      2008-10-04  6388  	}
> 2b6080f28c7cc3 Steven Rostedt           2012-05-11  6389  	if (t == tr->current_trace)
> bc0c38d139ec7f Steven Rostedt           2008-05-12  6390  		goto out;
> bc0c38d139ec7f Steven Rostedt           2008-05-12  6391  
> a35873a0993b4d Tom Zanussi              2019-02-13  6392  #ifdef CONFIG_TRACER_SNAPSHOT
> a35873a0993b4d Tom Zanussi              2019-02-13  6393  	if (t->use_max_tr) {
> c0a581d7126c0b Waiman Long              2022-09-22  6394  		local_irq_disable();
> a35873a0993b4d Tom Zanussi              2019-02-13  6395  		arch_spin_lock(&tr->max_lock);
> a35873a0993b4d Tom Zanussi              2019-02-13  6396  		if (tr->cond_snapshot)
> a35873a0993b4d Tom Zanussi              2019-02-13  6397  			ret = -EBUSY;
> a35873a0993b4d Tom Zanussi              2019-02-13  6398  		arch_spin_unlock(&tr->max_lock);
> c0a581d7126c0b Waiman Long              2022-09-22  6399  		local_irq_enable();
> a35873a0993b4d Tom Zanussi              2019-02-13  6400  		if (ret)
> a35873a0993b4d Tom Zanussi              2019-02-13  6401  			goto out;
> a35873a0993b4d Tom Zanussi              2019-02-13  6402  	}
> a35873a0993b4d Tom Zanussi              2019-02-13  6403  #endif
> c7b3ae0bd2ca65 Ziqian SUN (Zamir        2017-09-11  6404) 	/* Some tracers won't work on kernel command line */
> c7b3ae0bd2ca65 Ziqian SUN (Zamir        2017-09-11  6405) 	if (system_state < SYSTEM_RUNNING && t->noboot) {
> c7b3ae0bd2ca65 Ziqian SUN (Zamir        2017-09-11  6406) 		pr_warn("Tracer '%s' is not allowed on command line, ignored\n",
> c7b3ae0bd2ca65 Ziqian SUN (Zamir        2017-09-11  6407) 			t->name);
> c7b3ae0bd2ca65 Ziqian SUN (Zamir        2017-09-11  6408) 		goto out;
> c7b3ae0bd2ca65 Ziqian SUN (Zamir        2017-09-11  6409) 	}
> c7b3ae0bd2ca65 Ziqian SUN (Zamir        2017-09-11  6410) 
> 607e2ea167e56d Steven Rostedt (Red Hat  2013-11-06  6411) 	/* Some tracers are only allowed for the top level buffer */
> 607e2ea167e56d Steven Rostedt (Red Hat  2013-11-06  6412) 	if (!trace_ok_for_array(t, tr)) {
> 607e2ea167e56d Steven Rostedt (Red Hat  2013-11-06  6413) 		ret = -EINVAL;
> 607e2ea167e56d Steven Rostedt (Red Hat  2013-11-06  6414) 		goto out;
> 607e2ea167e56d Steven Rostedt (Red Hat  2013-11-06  6415) 	}
> 607e2ea167e56d Steven Rostedt (Red Hat  2013-11-06  6416) 
> cf6ab6d9143b15 Steven Rostedt (Red Hat  2014-12-15  6417) 	/* If trace pipe files are being read, we can't change the tracer */
> 7ef282e05132d5 Steven Rostedt (VMware   2020-06-29  6418) 	if (tr->trace_ref) {
> cf6ab6d9143b15 Steven Rostedt (Red Hat  2014-12-15  6419) 		ret = -EBUSY;
> cf6ab6d9143b15 Steven Rostedt (Red Hat  2014-12-15  6420) 		goto out;
> cf6ab6d9143b15 Steven Rostedt (Red Hat  2014-12-15  6421) 	}
> cf6ab6d9143b15 Steven Rostedt (Red Hat  2014-12-15  6422) 
> 9f029e83e968e5 Steven Rostedt           2008-11-12  6423  	trace_branch_disable();
> 613f04a0f51e6e Steven Rostedt (Red Hat  2013-03-14  6424) 
> 50512ab576e1ce Steven Rostedt (Red Hat  2014-01-14  6425) 	tr->current_trace->enabled--;
> 613f04a0f51e6e Steven Rostedt (Red Hat  2013-03-14  6426) 
> 2b6080f28c7cc3 Steven Rostedt           2012-05-11  6427  	if (tr->current_trace->reset)
> 2b6080f28c7cc3 Steven Rostedt           2012-05-11  6428  		tr->current_trace->reset(tr);
> 613f04a0f51e6e Steven Rostedt (Red Hat  2013-03-14  6429) 
> 7440172974e85b Paul E. McKenney         2018-11-06  6430  	/* Current trace needs to be nop_trace before synchronize_rcu */
> 2b6080f28c7cc3 Steven Rostedt           2012-05-11  6431  	tr->current_trace = &nop_trace;
> 34600f0e9c33c9 Steven Rostedt           2013-01-22  6432  
> 45ad21ca5530ef Steven Rostedt (Red Hat  2013-03-05  6433) #ifdef CONFIG_TRACER_MAX_TRACE
> 45ad21ca5530ef Steven Rostedt (Red Hat  2013-03-05  6434) 	had_max_tr = tr->allocated_snapshot;
> 34600f0e9c33c9 Steven Rostedt           2013-01-22  6435  
> 34600f0e9c33c9 Steven Rostedt           2013-01-22  6436  	if (had_max_tr && !t->use_max_tr) {
> 34600f0e9c33c9 Steven Rostedt           2013-01-22  6437  		/*
> 34600f0e9c33c9 Steven Rostedt           2013-01-22  6438  		 * We need to make sure that the update_max_tr sees that
> 34600f0e9c33c9 Steven Rostedt           2013-01-22  6439  		 * current_trace changed to nop_trace to keep it from
> 34600f0e9c33c9 Steven Rostedt           2013-01-22  6440  		 * swapping the buffers after we resize it.
> 34600f0e9c33c9 Steven Rostedt           2013-01-22  6441  		 * The update_max_tr is called from interrupts disabled
> 34600f0e9c33c9 Steven Rostedt           2013-01-22  6442  		 * so a synchronized_sched() is sufficient.
> 34600f0e9c33c9 Steven Rostedt           2013-01-22  6443  		 */
> 7440172974e85b Paul E. McKenney         2018-11-06  6444  		synchronize_rcu();
> 3209cff4490bee Steven Rostedt (Red Hat  2013-03-12 @6445) 		free_snapshot(tr);
> ef710e100c1068 KOSAKI Motohiro          2010-07-01  6446  	}
> 12883efb670c28 Steven Rostedt (Red Hat  2013-03-05  6447) 
> 34600f0e9c33c9 Steven Rostedt           2013-01-22  6448  	if (t->use_max_tr && !had_max_tr) {
> 2824f503324860 Steven Rostedt (VMware   2018-05-28  6449) 		ret = tracing_alloc_snapshot_instance(tr);
> ef710e100c1068 KOSAKI Motohiro          2010-07-01  6450  		if (ret < 0)
> ef710e100c1068 KOSAKI Motohiro          2010-07-01  6451  			goto out;
> ef710e100c1068 KOSAKI Motohiro          2010-07-01  6452  	}
> 12883efb670c28 Steven Rostedt (Red Hat  2013-03-05  6453) #endif
> 577b785f55168d Steven Rostedt           2009-02-26  6454  
> 1c80025a49855b Frederic Weisbecker      2008-11-16  6455  	if (t->init) {
> b6f11df26fdc28 Arnaldo Carvalho de Melo 2009-02-05  6456  		ret = tracer_init(t, tr);
> 1c80025a49855b Frederic Weisbecker      2008-11-16  6457  		if (ret)
> 1c80025a49855b Frederic Weisbecker      2008-11-16  6458  			goto out;
> 1c80025a49855b Frederic Weisbecker      2008-11-16  6459  	}
> bc0c38d139ec7f Steven Rostedt           2008-05-12  6460  
> 2b6080f28c7cc3 Steven Rostedt           2012-05-11  6461  	tr->current_trace = t;
> 50512ab576e1ce Steven Rostedt (Red Hat  2014-01-14  6462) 	tr->current_trace->enabled++;
> 9f029e83e968e5 Steven Rostedt           2008-11-12  6463  	trace_branch_enable(tr);
> bc0c38d139ec7f Steven Rostedt           2008-05-12  6464   out:
> bc0c38d139ec7f Steven Rostedt           2008-05-12  6465  	mutex_unlock(&trace_types_lock);
> bc0c38d139ec7f Steven Rostedt           2008-05-12  6466  
> d9e540762f5cdd Peter Zijlstra           2008-11-01  6467  	return ret;
> d9e540762f5cdd Peter Zijlstra           2008-11-01  6468  }
> d9e540762f5cdd Peter Zijlstra           2008-11-01  6469  
> 
> -- 
> 0-DAY CI Kernel Test Service
> https://01.org/lkp


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
