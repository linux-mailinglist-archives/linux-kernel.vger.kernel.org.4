Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B10174F60B
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 18:48:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231255AbjGKQs3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 12:48:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233480AbjGKQsT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 12:48:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4386AE75;
        Tue, 11 Jul 2023 09:48:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CEA6A61579;
        Tue, 11 Jul 2023 16:48:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C47AC433C8;
        Tue, 11 Jul 2023 16:48:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689094097;
        bh=I7EPUEcPmgXOKW9N8oN9911bvyFE7uAdVt8F9c2RZVw=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=mpLApopi+LAsM5sYrpEmD9WcJ9xZEX8fcsbgA2kt8S4cKmvgxj0zD5TYFqdPEdSnZ
         SSCfWCiKKYFANB8796rZTRoiJrXzidVl0YM1+Bh53/F4Dq2tsd1b0F15fLpFU5g0bM
         tdHmJ59W6Ae4VjAFoD9bBKlEEiZpRAWxgpVcNgEbemcrgXPcfhdwDuvBll6HmZJWr/
         mk56IGzJMvsjE1uKX0oVr2Kt3iWH9nkBcIZGIpk9UD/YMO+rxatHtnRppzFiKdo3Dv
         UvOrfeS3IbpyMOI0Uqrwq18EKoMlrmruLUqrudtG1rgAH/gAcSlNzhs2qJ8t217PUM
         pnSVLlE0SJTiQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id B8F27CE03F1; Tue, 11 Jul 2023 09:48:16 -0700 (PDT)
Date:   Tue, 11 Jul 2023 09:48:16 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Zqiang <qiang.zhang1211@gmail.com>, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] rcu: Delete a redundant check in
 rcu_check_gp_kthread_starvation()
Message-ID: <eb12a97c-a1b5-497e-ab3a-31ac716e7631@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20230705073020.2030-1-thunder.leizhen@huawei.com>
 <20230705073020.2030-2-thunder.leizhen@huawei.com>
 <f36c93ac-b735-4771-a4b5-4be80c431593@paulmck-laptop>
 <4c8e0ea4-9dee-7915-e2eb-206ba50b79f2@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4c8e0ea4-9dee-7915-e2eb-206ba50b79f2@huawei.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 11, 2023 at 11:20:07AM +0800, Leizhen (ThunderTown) wrote:
> 
> 
> On 2023/7/11 3:03, Paul E. McKenney wrote:
> > On Wed, Jul 05, 2023 at 03:30:19PM +0800, Zhen Lei wrote:
> >> The above condition "if (gpk)" already ensures that gp_kthread is created,
> >> so the local variable 'cpu' cannot be negative here.
> >>
> >> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
> >> ---
> >>  kernel/rcu/tree_stall.h | 12 +++++-------
> >>  1 file changed, 5 insertions(+), 7 deletions(-)
> >>
> >> diff --git a/kernel/rcu/tree_stall.h b/kernel/rcu/tree_stall.h
> >> index b10b8349bb2a48b..dcfaa3d5db2cbc7 100644
> >> --- a/kernel/rcu/tree_stall.h
> >> +++ b/kernel/rcu/tree_stall.h
> >> @@ -537,13 +537,11 @@ static void rcu_check_gp_kthread_starvation(void)
> >>  			pr_err("\tUnless %s kthread gets sufficient CPU time, OOM is now expected behavior.\n", rcu_state.name);
> >>  			pr_err("RCU grace-period kthread stack dump:\n");
> >>  			sched_show_task(gpk);
> >> -			if (cpu >= 0) {
> > 
> > I am not quite this trusting of the relation between the relationship
> > between the existence of the grace-period khread and its CPU number
> > being in range.  Let's please start with something like this:
> > 
> > 			if (!WARN_ON_ONCE(cpu < 0)) {
> > 
> > Please note that this is not just me.  See for example the use of the
> > cpumask_check() function, albeit the opposite concern.
> 
> git grep -wn "\->cpu" kernel/ include/
> kernel/kthread.c:583:   to_kthread(p)->cpu = cpu;				//kthread_create_on_cpu()
> kernel/sched/sched.h:2024:      WRITE_ONCE(task_thread_info(p)->cpu, cpu);	//__set_task_cpu()
> include/linux/sched.h:2250:     return READ_ONCE(task_thread_info(p)->cpu);	//task_cpu()
> 
> git grep -wn "\.cpu" kernel/ include/						//There is no task related, the search result is omitted.
> 
> Therefore, there is only one path "set_task_cpu()-->__set_task_cpu()" that can dynamically
> change the value of task_cpu(p). In fact, this guarantee has been made in set_task_cpu().
> set_task_cpu
> 	WARN_ON_ONCE(!cpu_online(new_cpu));
> 	__set_task_cpu(p, new_cpu);
> 
> In addition, task_struct has member 'on_rq'. Therefore, when a task leaves the scheduling
> queue, setting the member 'cpu' to an invalid value will be thankless.

Thank you for digging into this!  Given that, as you say, we can dispense
with the check.

> Sorry, these two patches was posted too quickly, and I'm still regretting that I should have
> attached this to the commit description these days.

Please do resend the patches with this explanation in the commit log.
And please don't worry about making the English pretty, as I can always
wordsmith.

							Thanx, Paul

> >> -				if (cpu_is_offline(cpu)) {
> >> -					pr_err("RCU GP kthread last ran on offline CPU %d.\n", cpu);
> >> -				} else  {
> >> -					pr_err("Stack dump where RCU GP kthread last ran:\n");
> >> -					dump_cpu_task(cpu);
> >> -				}
> >> +			if (cpu_is_offline(cpu)) {
> >> +				pr_err("RCU GP kthread last ran on offline CPU %d.\n", cpu);
> >> +			} else  {
> >> +				pr_err("Stack dump where RCU GP kthread last ran:\n");
> >> +				dump_cpu_task(cpu);
> >>  			}
> >>  			wake_up_process(gpk);
> >>  		}
> >> -- 
> >> 2.25.1
> >>
> > .
> > 
> 
> -- 
> Regards,
>   Zhen Lei
