Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BFDE624E38
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 00:08:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230419AbiKJXIR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 18:08:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230232AbiKJXIP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 18:08:15 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75F7A1DA41;
        Thu, 10 Nov 2022 15:08:14 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0D7C161B89;
        Thu, 10 Nov 2022 23:08:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55593C433C1;
        Thu, 10 Nov 2022 23:08:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668121693;
        bh=c/H+SRQDywVylukBno5yzc5O9o1JiQF0nc6WN+K5JPM=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=g3hpCfbKPUBcxYC0z3qscirzviTmLo89FWRgKpnMcooBErVZVZ9QJjmDSqMLzJnnO
         9i1jCTdCVV9/RsN/2wOXd5xktNoAOZ+g7Ri4eyPWfrO0Lcyxl5pQYb1dLlY5uLkMrB
         1zMdUGY6vMzNRcZH8pd8U9yAmDNev6J6etzWWvjbUa0p16YyaU+ftKEq8qbpg7rxn3
         MaPQzo3aRsUcaE97hOQEdtvE31urPl6Er2BTnDfIfmFN9XzQUVCpwAWKpPNDYOIYDD
         mDrob6CXjB2Od8MM8sFikTLE2GpuPWWiDl9O46SUGLGS3lIR5x7lCAd8ZBN16IPjfP
         GTuNKH2XcZRbQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 03B1C5C13DD; Thu, 10 Nov 2022 15:08:07 -0800 (PST)
Date:   Thu, 10 Nov 2022 15:08:06 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "rcu@vger.kernel.org" <rcu@vger.kernel.org>,
        "kernel-dev@igalia.com" <kernel-dev@igalia.com>,
        "Guilherme G. Piccoli" <kernel@gpiccoli.net>
Subject: Re: RCU stall on 6.1-rc4 (and some previous releases) related to
 ftrace
Message-ID: <20221110230806.GN725751@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <1ef5fe19-a82f-835e-fda5-455e9c2b94b4@igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1ef5fe19-a82f-835e-fda5-455e9c2b94b4@igalia.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 10, 2022 at 06:25:41PM -0300, Guilherme G. Piccoli wrote:
> Hi folks, I've noticed some RCU stalls when enabling ftrace filtering in
> 6.1-rc4 (also 6.1-rc3 and I guess I've seen this before, but only in
> 6.0+). Here is the full dmesg: https://termbin.com/4xo6 , see below for
> a small snippet of the stall [0].
> 
> I've briefly talked to Steve on IRC, and he mentioned that my kernel
> seemed to have PREEMPT_VOLUNTARY=y (and indeed, this is the case - see
> the full config here: https://termbin.com/t48d), saying that maybe
> adding a cond_resched() in the loop would help.
> 
> So, I've cooked a small hack (see the patch attached) and it seems to
> work. Steve: lemme know if you want to send it (since it's your idea and
> maybe my hack is not covering all cases), or if you prefer, I can work a
> commit message and send myself.
> 
> Any other advice / tests required, please lemme me know and I'll be glad
> in contributing.

I will let others give feedback on the commit log, signoffs, and so
on.  From an RCU CPU stall warning perspective:

Acked-by: Paul E. McKenney <paulmck@kernel.org>

> Cheers,
> 
> 
> Guilherme
> 
> 
> [0]
> rcu: INFO: rcu_preempt detected expedited stalls on CPUs/tasks: { 1-....
> } 6 jiffies s: 1289 root: 0x2/.
> rcu: blocking rcu_node structures (internal RCU debug):
> Sending NMI from CPU 4 to CPUs 1:
> NMI backtrace for cpu 1
> [...]
> RIP: 0010:find_kallsyms_symbol+0x85/0x1a0
> [...]
> Call Trace:
>  <TASK>
>  ? get_refcyc_per_delivery.constprop.0+0x200/0x200 [amdgpu]
>  module_address_lookup+0x63/0xc0
>  ? get_refcyc_per_delivery.constprop.0+0x200/0x200 [amdgpu]
>  kallsyms_lookup_buildid+0xb6/0x130
>  ftrace_match_record+0x43/0xf0
>  ? match_records+0x210/0x3b0
>  ? __kmem_cache_alloc_node+0x165/0x260
>  match_records+0x13a/0x3b0
>  ftrace_process_regex.isra.0+0x101/0x120
>  ftrace_filter_write+0x57/0x90
> [...]
> rcu: INFO: rcu_preempt detected expedited stalls on CPUs/tasks: { 1-....
> } 25 jiffies s: 1289 root: 0x2/.
> rcu: blocking rcu_node structures (internal RCU debug):
> Sending NMI from CPU 4 to CPUs 1:
> [...]
> RIP: 0010:find_kallsyms_symbol+0x8f/0x1a0
> [...]
> Call Trace:
>  <TASK>
>  ? dcn21_dmcu_create+0xd0/0xd0 [amdgpu]
>  module_address_lookup+0x63/0xc0
>  ? dcn21_dmcu_create+0xd0/0xd0 [amdgpu]
>  kallsyms_lookup_buildid+0xb6/0x130
>  ftrace_match_record+0x43/0xf0
>  ? match_records+0x210/0x3b0
>  ? __kmem_cache_alloc_node+0x165/0x260
>  match_records+0x13a/0x3b0
>  ftrace_process_regex.isra.0+0x101/0x120
>  ftrace_filter_write+0x57/0x90
> [...]

> From 45fda369a49d0e59689e4a6b9babc12598265825 Mon Sep 17 00:00:00 2001
> From: "Guilherme G. Piccoli" <gpiccoli@igalia.com>
> Date: Thu, 10 Nov 2022 16:42:17 -0300
> Subject: [PATCH] ftrace/hack: Add cond_resched() to prevent RCU stall
> 
> Suggestion from Steve on IRC
> ---
>  kernel/trace/ftrace.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
> index 7dc023641bf1..8c2c04b2eb52 100644
> --- a/kernel/trace/ftrace.c
> +++ b/kernel/trace/ftrace.c
> @@ -4184,6 +4184,7 @@ match_records(struct ftrace_hash *hash, char *func, int len, char *mod)
>  		if (rec->flags & FTRACE_FL_DISABLED)
>  			continue;
>  
> +		cond_resched();
>  		if (ftrace_match_record(rec, &func_g, mod_match, exclude_mod)) {
>  			ret = enter_record(hash, rec, clear_filter);
>  			if (ret < 0) {
> -- 
> 2.38.0
> 

