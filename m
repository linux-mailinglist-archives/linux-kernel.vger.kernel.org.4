Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DEC274DDB7
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 21:03:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229688AbjGJTDj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 15:03:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjGJTDh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 15:03:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22DA0120;
        Mon, 10 Jul 2023 12:03:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AA023611AC;
        Mon, 10 Jul 2023 19:03:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3BF8C433C8;
        Mon, 10 Jul 2023 19:03:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689015816;
        bh=VTZvfRAy06sAh7uxVTfRbg0A+Kd+f5O4YAN7F9BRS6w=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=LLtwk6HFvxD6yDEp1Xo+TixynPYreZURmY0XcauMizEraiLePj1Ls/U/5bsvJu+iV
         Vk7dAEoJsJnOhNBkZWsm1Aap4iV68CzrOrOqrZzVJRZDfkwx+rSk2HAjqoMsomO0EV
         0ujVFurqnB4iq5SfghXTLWFOV2BmRmZCuqDIpALUG44l1eoTuJiP3STRcYAZbdYM+n
         NEz6CLiVfQfx2cPv2zSyV4xWccxekYglLFlD9heqhhufa1ptyThSFj+gcshuIq09Nu
         mOTVbLxiIb0QCRY17XFiacozq/n8ajeLOA+LqJ3GNuweCZHsxel6hrks/cunduDK2u
         2y+tt0VmLOCSQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 942E4CE00C6; Mon, 10 Jul 2023 12:03:35 -0700 (PDT)
Date:   Mon, 10 Jul 2023 12:03:35 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Zhen Lei <thunder.leizhen@huawei.com>
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
Message-ID: <f36c93ac-b735-4771-a4b5-4be80c431593@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20230705073020.2030-1-thunder.leizhen@huawei.com>
 <20230705073020.2030-2-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230705073020.2030-2-thunder.leizhen@huawei.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 05, 2023 at 03:30:19PM +0800, Zhen Lei wrote:
> The above condition "if (gpk)" already ensures that gp_kthread is created,
> so the local variable 'cpu' cannot be negative here.
> 
> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
> ---
>  kernel/rcu/tree_stall.h | 12 +++++-------
>  1 file changed, 5 insertions(+), 7 deletions(-)
> 
> diff --git a/kernel/rcu/tree_stall.h b/kernel/rcu/tree_stall.h
> index b10b8349bb2a48b..dcfaa3d5db2cbc7 100644
> --- a/kernel/rcu/tree_stall.h
> +++ b/kernel/rcu/tree_stall.h
> @@ -537,13 +537,11 @@ static void rcu_check_gp_kthread_starvation(void)
>  			pr_err("\tUnless %s kthread gets sufficient CPU time, OOM is now expected behavior.\n", rcu_state.name);
>  			pr_err("RCU grace-period kthread stack dump:\n");
>  			sched_show_task(gpk);
> -			if (cpu >= 0) {

I am not quite this trusting of the relation between the relationship
between the existence of the grace-period khread and its CPU number
being in range.  Let's please start with something like this:

			if (!WARN_ON_ONCE(cpu < 0)) {

Please note that this is not just me.  See for example the use of the
cpumask_check() function, albeit the opposite concern.

> -				if (cpu_is_offline(cpu)) {
> -					pr_err("RCU GP kthread last ran on offline CPU %d.\n", cpu);
> -				} else  {
> -					pr_err("Stack dump where RCU GP kthread last ran:\n");
> -					dump_cpu_task(cpu);
> -				}
> +			if (cpu_is_offline(cpu)) {
> +				pr_err("RCU GP kthread last ran on offline CPU %d.\n", cpu);
> +			} else  {
> +				pr_err("Stack dump where RCU GP kthread last ran:\n");
> +				dump_cpu_task(cpu);
>  			}
>  			wake_up_process(gpk);
>  		}
> -- 
> 2.25.1
> 
