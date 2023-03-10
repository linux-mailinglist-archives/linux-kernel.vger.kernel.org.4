Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FFD86B5615
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Mar 2023 00:57:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232036AbjCJX5R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 18:57:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231537AbjCJX5P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 18:57:15 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E0A712CBCE;
        Fri, 10 Mar 2023 15:57:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=apH1q+cCj7BHOOFHzKRoP24Y/6OcQc9IVy03k3952ns=; b=tDnypKjeMJzwspXNIkw8eDOAAC
        eUlobV5HH3/2uhd8ujkNXPNih8A8N14Gqd2m/aLOK9KU+szI3yI/knN2qSlHqfMy8ilL7xhJDdtOB
        9MANI2/fugNQuAArlSyb/DTLanVdQtS2tZu4ug26n4oxaLemcHrtPL9i6r3aAzcoB3LykncuvrDLJ
        razRW/0zBdPH1X7kSP2QiqOkxHZPU18MPuB0URza1G/asGSkjtHnuHRBvvXYdgInzMD468mPH93Y2
        8yNeN7D7C/lqGAQ0C7rhtagBajHM5updNuMg0XsfPM4AJUkGPNYyecXQSpxlXxyhSiqyYYdljVn5M
        BcopNVxg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pambX-009oKY-J1; Fri, 10 Mar 2023 23:56:56 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id C50FB30030B;
        Sat, 11 Mar 2023 00:56:53 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 8D5672130975A; Sat, 11 Mar 2023 00:56:53 +0100 (CET)
Date:   Sat, 11 Mar 2023 00:56:53 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Joel Fernandes <joel@joelfernandes.org>
Subject: Re: [PATCH v2] tracing: Make tracepoint lockdep check actually test
 something
Message-ID: <20230310235653.GC1605437@hirez.programming.kicks-ass.net>
References: <20230310172856.77406446@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230310172856.77406446@gandalf.local.home>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 10, 2023 at 05:28:56PM -0500, Steven Rostedt wrote:

> @@ -249,9 +248,7 @@ static inline struct tracepoint *tracepoint_ptr_deref(tracepoint_ptr_t *p)
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

Yep, that makes heaps more sense. If you so care you can save one more
line and make the {} go away too.

In any case,

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
