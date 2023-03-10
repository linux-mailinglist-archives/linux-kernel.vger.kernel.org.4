Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCD326B388B
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 09:28:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230377AbjCJI2L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 03:28:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229774AbjCJI2I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 03:28:08 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30AB41E1FC;
        Fri, 10 Mar 2023 00:28:05 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 748ECB821E5;
        Fri, 10 Mar 2023 08:28:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E05DFC433D2;
        Fri, 10 Mar 2023 08:28:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678436883;
        bh=qsrSwXZko/tTXpRe9p1GPDISHLEs2ScFa2sr3Aj8QRk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=qGiBUA12F4dRCFu1TLVc0bPhuxohaHzY5cIF7FkI8bsw+UHYfx59FKehYi20GNxJY
         FYlfM3OMwQiyBwhGf+XNEwI4uLFD39LqkWCikGbnaGGw52l36XOKNmV7GxYxSr8nq0
         4JTLiirvXg6jAnhKOG8oI/a0pDmW4c2fp/S6Tr9weQNMIZ+RkKv+p9wuI8/adMYAjp
         2Uha7rg6bxBwwJoOs982nkmHrTH+o2cKmHR+oiqWNGu+ASZnxX98ZLEwMYPrBmlhba
         T6gYMOJZCVaAAhkxmr9IUOAKXRdeDOTSGY+zUicKmZCGpELRj3FXSn60UoH89RuyD3
         Kmi9oKnjvvJlQ==
Date:   Fri, 10 Mar 2023 17:27:58 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Joel Fernandes <joel@joelfernandes.org>
Subject: Re: [PATCH] tracing: Make tracepoint lockdep check actually test
 something
Message-Id: <20230310172758.38c1ec9c6272e41a579ff820@kernel.org>
In-Reply-To: <20230309165603.6967197d@gandalf.local.home>
References: <20230309165603.6967197d@gandalf.local.home>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 9 Mar 2023 16:56:03 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> From: "Steven Rostedt (Google)" <rostedt@goodmis.org>
> 
> A while ago where the trace events had the following:
> 
>    rcu_read_lock_sched_notrace();
>    rcu_dereference_sched(...);
>    rcu_read_unlock_sched_notrace();
> 
> If the tracepoint is enabled, it could trigger RCU issues if called in
> the wrong place. And this warning was only triggered if lockdep was
> enabled. If the tracepoint was never enabled with lockdep, the bug would
> not be caught. To handle this, the above sequence was done when lockdep
> was enabled regardless if the tracepoint was enabled or not (although the
> always enabled code really didn't do anything, it would still trigger a
> warning).
> 
> But a lot has changed since that lockdep code was added. One is, that
> sequence no longer triggers any warning. Another is, the tracepoint when
> enabled doesn't even do that sequence anymore.
> 
> The main check we care about today is whether RCU is "watching" or not.
> So if lockdep is enabled, always check if rcu_is_watching() which will
> trigger a warning if it is not (tracepoints require RCU to be watching).
> 
> Note, that old sequence did add a bit of overhead when lockdep was enabled,
> and with the latest kernel updates, would cause the system to slow down
> enough to trigger kernel "stalled" warnings.
> 
> Link: http://lore.kernel.org/lkml/20140806181801.GA4605@redhat.com
> Link: http://lore.kernel.org/lkml/20140807175204.C257CAC5@viggo.jf.intel.com
> Link: https://lore.kernel.org/lkml/20230307184645.521db5c9@gandalf.local.home/
> 

This check has been introduced by commit 3a630178fd5f ("tracing: generate RCU
warnings even when tracepoints are disabled"), and it also added a comment
above this macro.

 * When lockdep is enabled, we make sure to always do the RCU portions of
 * the tracepoint code, regardless of whether tracing is on. However,
 * don't check if the condition is false, due to interaction with idle
 * instrumentation. This lets us find RCU issues triggered with tracepoints
 * even when this tracepoint is off. This code has no purpose other than
 * poking RCU a bit.

I think at least the last sentence will be outdated by this fix.

Thank you,


> Cc: stable@vger.kernel.org
> Fixes: e6753f23d961 ("tracepoint: Make rcuidle tracepoint callers use SRCU")
> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> ---
>  include/linux/tracepoint.h | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/include/linux/tracepoint.h b/include/linux/tracepoint.h
> index e299f29375bb..d3a221158ab1 100644
> --- a/include/linux/tracepoint.h
> +++ b/include/linux/tracepoint.h
> @@ -260,9 +260,7 @@ static inline struct tracepoint *tracepoint_ptr_deref(tracepoint_ptr_t *p)
>  				TP_ARGS(args),				\
>  				TP_CONDITION(cond), 0);			\
>  		if (IS_ENABLED(CONFIG_LOCKDEP) && (cond)) {		\
> -			rcu_read_lock_sched_notrace();			\
> -			rcu_dereference_sched(__tracepoint_##name.funcs);\
> -			rcu_read_unlock_sched_notrace();		\
> +			WARN_ON_ONCE(!rcu_is_watching());		\
>  		}							\
>  	}								\
>  	__DECLARE_TRACE_RCU(name, PARAMS(proto), PARAMS(args),		\
> -- 
> 2.39.1
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
