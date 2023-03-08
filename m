Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 853E26B0BA1
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 15:41:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231683AbjCHOlr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 09:41:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231596AbjCHOlX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 09:41:23 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77F80D008B;
        Wed,  8 Mar 2023 06:39:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=wwJqwTSg/nZUGQBDfBIfh8KJSRZGxt8BFXfaKwtU+Ak=; b=dopG2kxEYwqx3T1vODi+1MWtJU
        nyRzT3DtGFdLQZxe690buTczy2NUUH4G7N/g7698ZkYpa/oxQ47QOmJtyRhbm1LTGmClLs+q+MOpj
        7M76Zgsfkb7ZzbA0SHgrY3Em5iz7sW89Wa1qlX7c6FhUsh1Z+5+0KRN1/z6r1SEwJ1UFHuJpH54Km
        /r4L4R4yyatEdpYTWSbYv5lRldjP8pdK+tkeNWNUtxmcFPNNUhXajqdQBBFttOlp2pGJKYQvf65xG
        iiyE70iT57q3cXFQWw6Ez62/sWuepTCFE7fobZvIpvCEDxjgQBozJFeO6n2L/1RBkw+PCmeTHHEqS
        9Ne66LqQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pZuwx-00HPC7-1X;
        Wed, 08 Mar 2023 14:39:27 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id E0C70300033;
        Wed,  8 Mar 2023 15:39:25 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 7EAAE20A28FE2; Wed,  8 Mar 2023 15:39:25 +0100 (CET)
Date:   Wed, 8 Mar 2023 15:39:25 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Ross Zwisler <zwisler@google.com>
Subject: Re: [PATCH] tracing, hardirq: Do not test lockdep on irq trace
 points when disabled
Message-ID: <20230308143925.GJ2017917@hirez.programming.kicks-ass.net>
References: <20230307184645.521db5c9@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230307184645.521db5c9@gandalf.local.home>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 07, 2023 at 06:46:45PM -0500, Steven Rostedt wrote:
> From: "Steven Rostedt (Google)" <rostedt@goodmis.org>
> 
> When CONFIG_LOCKDEP is enabled, the trace points have:
> 
> 	static inline void trace_##name(proto)				\
> 	{								\
> 		if (static_key_false(&__tracepoint_##name.key))		\
> 			__DO_TRACE(name,				\
> 				TP_ARGS(args),				\
> 				TP_CONDITION(cond), 0);			\
> 		if (IS_ENABLED(CONFIG_LOCKDEP) && (cond)) {		\
> 			rcu_read_lock_sched_notrace();			\
> 			rcu_dereference_sched(__tracepoint_##name.funcs);\
> 			rcu_read_unlock_sched_notrace();		\
> 		}							\
> 	}								\

> Where it will test lockdep for trace points even when they are not
> enabled, to make sure they do not cause RCU issues, and lockdep will
> trigger even when the trace points are not enabled.

I'm confused what that's actually trying to do..

You're not tickling the rcu_is_watching() check, because
rcu_read_lock_sched_notrace() doesn't have that. You're not tickling
RCU_LOCKDEP_WARN() because you did rcu_read_lock_sched_notrace().

So what?!?
