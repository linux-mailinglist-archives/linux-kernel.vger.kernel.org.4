Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 330A272E86D
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 18:26:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232428AbjFMQZq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 12:25:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230380AbjFMQZm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 12:25:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9DBDB5;
        Tue, 13 Jun 2023 09:25:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E075F618B9;
        Tue, 13 Jun 2023 16:25:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E4D4C433F0;
        Tue, 13 Jun 2023 16:25:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686673539;
        bh=f4lAwk+LRCT6e2zfzrPLg93CA6TlPHVpgA6J1/rlXls=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=tNRT6G4bGetZeO47IbtMeQC2vx0hh96m8zSEn7Erm8bRRKpf1uwMSsHMYLc5ZRr8D
         zhkyJ00NzcccAFaXrGGNdC6ACFIR5gH45OBdkGrrGkqJqEArIBH4EEiQOVRCvWzrTq
         Sl+M99EL2C4rQm1fTO+i/qg9I800NY/TRUJZt04YcrSxbDdFL33sddmC6kjw4tlCcY
         eBae53jwPJ4doKNvkr8OMv8GcNWeHSlMzjRQSLUCyemF5cS2JnXX5lR0XtBlWza9/I
         iqDhO1ijhds83s2YxTS//WYnveOyEYZkDRqIMRvVxUOLh3xvjRHMjxg6WKRRpuIUAY
         +CypN/TFVgueg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id D2103CE3A33; Tue, 13 Jun 2023 09:25:38 -0700 (PDT)
Date:   Tue, 13 Jun 2023 09:25:38 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Arnd Bergmann <arnd@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Arnd Bergmann <arnd@arndb.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Zqiang <qiang.zhang1211@gmail.com>,
        Mukesh Ojha <quic_mojha@quicinc.com>,
        Nicolas Saenz Julienne <nsaenzju@redhat.com>,
        Zhen Lei <thunder.leizhen@huawei.com>,
        Qiuxu Zhuo <qiuxu.zhuo@intel.com>, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rcuscale: fix building with RCU_TINY
Message-ID: <e2a4332b-fcc3-4eb3-846e-302e056821c6@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20230609120522.3921015-1-arnd@kernel.org>
 <9fd81723-4ba2-4a0b-a7da-f9fb121021de@paulmck-laptop>
 <a3952f99-7ae9-8f8f-d87a-713690cbe1fb@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a3952f99-7ae9-8f8f-d87a-713690cbe1fb@infradead.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 13, 2023 at 07:42:17AM -0700, Randy Dunlap wrote:
> Paul-
> 
> On 6/9/23 15:51, Paul E. McKenney wrote:
> > On Fri, Jun 09, 2023 at 02:05:14PM +0200, Arnd Bergmann wrote:
> >> From: Arnd Bergmann <arnd@arndb.de>
> >>
> >> Both the CONFIG_TASKS_RCU and CONFIG_TASKS_RUDE_RCU options
> >> are broken when RCU_TINY is enabled as well, as some functions
> >> are missing a declaration.
> >>
> >> In file included from kernel/rcu/update.c:649:
> >> kernel/rcu/tasks.h:1271:21: error: no previous prototype for 'get_rcu_tasks_rude_gp_kthread' [-Werror=missing-prototypes]
> >>  1271 | struct task_struct *get_rcu_tasks_rude_gp_kthread(void)
> >>       |                     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> >> kernel/rcu/rcuscale.c:330:27: error: 'get_rcu_tasks_rude_gp_kthread' undeclared here (not in a function); did you mean 'get_rcu_tasks_trace_gp_kthread'?
> >>   330 |         .rso_gp_kthread = get_rcu_tasks_rude_gp_kthread,
> >>       |                           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> >>       |                           get_rcu_tasks_trace_gp_kthread
> >>
> >> In file included from /home/arnd/arm-soc/kernel/rcu/update.c:649:
> >> kernel/rcu/tasks.h:1113:21: error: no previous prototype for 'get_rcu_tasks_gp_kthread' [-Werror=missing-prototypes]
> >>  1113 | struct task_struct *get_rcu_tasks_gp_kthread(void)
> >>       |                     ^~~~~~~~~~~~~~~~~~~~~~~~
> >>
> >> Also, building with CONFIG_TASKS_RUDE_RCU but not CONFIG_TASKS_RCU is
> >> broken because of some missing stub functions:
> >>
> >> kernel/rcu/rcuscale.c:322:27: error: 'tasks_scale_read_lock' undeclared here (not in a function); did you mean 'srcu_scale_read_lock'?
> >>   322 |         .readlock       = tasks_scale_read_lock,
> >>       |                           ^~~~~~~~~~~~~~~~~~~~~
> >>       |                           srcu_scale_read_lock
> >> kernel/rcu/rcuscale.c:323:27: error: 'tasks_scale_read_unlock' undeclared here (not in a function); did you mean 'srcu_scale_read_unlock'?
> >>   323 |         .readunlock     = tasks_scale_read_unlock,
> >>       |                           ^~~~~~~~~~~~~~~~~~~~~~~
> >>       |                           srcu_scale_read_unlock
> >>
> >> Move the declarations outside of the RCU_TINY #ifdef and duplicate the
> >> shared stub functions to address all of the above.
> >>
> >> Fixes: 88d7ff818f0ce ("rcuscale: Add RCU Tasks Rude testing")
> >> Fixes: 755f1c5eb416b ("rcuscale: Measure RCU Tasks Trace grace-period kthread CPU time")
> >> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > 
> > Queued and pushed, thank you!
> > 
> > I clearly need to improve my Kconfig coverage here...
> 
> Pushed where. I'm still seeing this build error in linux-next 20230613.

To rcu/dev.  There have been some testing bottlenecks, but it should
reach rcu/next soon.

							Thanx, Paul

> Thanks.
> 
> > 
> >> ---
> >>  kernel/rcu/rcu.h      | 14 ++++++++------
> >>  kernel/rcu/rcuscale.c | 13 +++++++++++--
> >>  2 files changed, 19 insertions(+), 8 deletions(-)
> >>
> >> diff --git a/kernel/rcu/rcu.h b/kernel/rcu/rcu.h
> >> index 9829d8161b213..5befd8780dcd3 100644
> >> --- a/kernel/rcu/rcu.h
> >> +++ b/kernel/rcu/rcu.h
> >> @@ -505,18 +505,20 @@ void rcu_async_relax(void);
> >>  void rcupdate_announce_bootup_oddness(void);
> >>  #ifdef CONFIG_TASKS_RCU_GENERIC
> >>  void show_rcu_tasks_gp_kthreads(void);
> >> -# ifdef CONFIG_TASKS_RCU
> >> -struct task_struct *get_rcu_tasks_gp_kthread(void);
> >> -# endif // # ifdef CONFIG_TASKS_RCU
> >> -# ifdef CONFIG_TASKS_RUDE_RCU
> >> -struct task_struct *get_rcu_tasks_rude_gp_kthread(void);
> >> -# endif // # ifdef CONFIG_TASKS_RUDE_RCU
> >>  #else /* #ifdef CONFIG_TASKS_RCU_GENERIC */
> >>  static inline void show_rcu_tasks_gp_kthreads(void) {}
> >>  #endif /* #else #ifdef CONFIG_TASKS_RCU_GENERIC */
> >>  void rcu_request_urgent_qs_task(struct task_struct *t);
> >>  #endif /* #else #ifdef CONFIG_TINY_RCU */
> >>  
> >> +#ifdef CONFIG_TASKS_RCU
> >> +struct task_struct *get_rcu_tasks_gp_kthread(void);
> >> +#endif // # ifdef CONFIG_TASKS_RCU
> >> +
> >> +#ifdef CONFIG_TASKS_RUDE_RCU
> >> +struct task_struct *get_rcu_tasks_rude_gp_kthread(void);
> >> +#endif // # ifdef CONFIG_TASKS_RUDE_RCU
> >> +
> >>  #define RCU_SCHEDULER_INACTIVE	0
> >>  #define RCU_SCHEDULER_INIT	1
> >>  #define RCU_SCHEDULER_RUNNING	2
> >> diff --git a/kernel/rcu/rcuscale.c b/kernel/rcu/rcuscale.c
> >> index 5ce3b4e7ce711..a0eae19007088 100644
> >> --- a/kernel/rcu/rcuscale.c
> >> +++ b/kernel/rcu/rcuscale.c
> >> @@ -316,11 +316,20 @@ static struct rcu_scale_ops tasks_ops = {
> >>   * Definitions for RCU-tasks-rude scalability testing.
> >>   */
> >>  
> >> +static int tasks_rude_scale_read_lock(void)
> >> +{
> >> +	return 0;
> >> +}
> >> +
> >> +static void tasks_rude_scale_read_unlock(int idx)
> >> +{
> >> +}
> >> +
> >>  static struct rcu_scale_ops tasks_rude_ops = {
> >>  	.ptype		= RCU_TASKS_RUDE_FLAVOR,
> >>  	.init		= rcu_sync_scale_init,
> >> -	.readlock	= tasks_scale_read_lock,
> >> -	.readunlock	= tasks_scale_read_unlock,
> >> +	.readlock	= tasks_rude_scale_read_lock,
> >> +	.readunlock	= tasks_rude_scale_read_unlock,
> >>  	.get_gp_seq	= rcu_no_completed,
> >>  	.gp_diff	= rcu_seq_diff,
> >>  	.async		= call_rcu_tasks_rude,
> >> -- 
> >> 2.39.2
> >>
> 
> -- 
> ~Randy
