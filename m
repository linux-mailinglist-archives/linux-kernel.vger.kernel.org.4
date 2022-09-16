Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D34F5BB45D
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Sep 2022 00:22:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229509AbiIPWV6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 18:21:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiIPWVz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 18:21:55 -0400
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A64AAA024A
        for <linux-kernel@vger.kernel.org>; Fri, 16 Sep 2022 15:21:54 -0700 (PDT)
Received: by mail-qt1-x834.google.com with SMTP id y2so17038729qtv.5
        for <linux-kernel@vger.kernel.org>; Fri, 16 Sep 2022 15:21:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=/Z4HioIHNMXZQnpDiGaKlQH+R1i37jGb7DQ/+FG9DY4=;
        b=oUVC0QClHNlhxYz78lza87f+pSlzjYsLRu3OF8G6xytxs7gvHTGh7Y7rmJF3PEBsYj
         oAxNiqG1254EaTVfzSZWle42RZCslH+C0vjsPJYAmVvAg14jTeDKKfpIoQARQ0zX/oke
         VJIugZnJFWHS1CWs4KhMzTfBp5XFl+ngOAcuQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=/Z4HioIHNMXZQnpDiGaKlQH+R1i37jGb7DQ/+FG9DY4=;
        b=7997VfiveLNG2TTDIcA+mNgTECe05UXwttoWhSPmcige4fAySVvEcsWXKuqGiSdxen
         iqgegFFz5bLgfE2pOoTYsnl5xoQKur9wZc1KujaXvWC8TKIyB77bylc/id+mPfbUiVq8
         hXiCLEoo7pDFq3m5b2QclLw0p+UVPbvwB1R+fJK0RB8Z8CGmL/N6mFzW4GTOttHxqmnf
         JyXcg9xd6ht7oaQYGz6ryVig0tb+e7sAl35Dmuu8PUCoPOMLO93ICX7C0oECqLja3Vo4
         ZGwIOCePGXDE5PCdKHtIruhjvQBskEeSQoVR8iPzouNl3oUGKNn5ph3ZKv3tYF0eD99Z
         6qVw==
X-Gm-Message-State: ACrzQf0f0RIrrhKEBOD6nFM1TD1SgVuOhUyDy+dA+UbhBOq3LExJ9Fxa
        gGF6leHRb8nkyGA7IYCmPxj19Q==
X-Google-Smtp-Source: AMsMyM7Q+Kg6EhID++gu/3/TvsOwzd5Eb/0EVG/vvc8+Rcm8fgjUCU65xPIAXEGd8MOBn4wV/DCmeQ==
X-Received: by 2002:a05:622a:1492:b0:35c:b7e6:12ef with SMTP id t18-20020a05622a149200b0035cb7e612efmr6481356qtx.94.1663366913808;
        Fri, 16 Sep 2022 15:21:53 -0700 (PDT)
Received: from localhost (228.221.150.34.bc.googleusercontent.com. [34.150.221.228])
        by smtp.gmail.com with ESMTPSA id l20-20020a05620a28d400b006ce1bfbd603sm7386322qkp.124.2022.09.16.15.21.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Sep 2022 15:21:53 -0700 (PDT)
Date:   Fri, 16 Sep 2022 22:21:53 +0000
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH rcu/next 2/3] rcu: Move trace_rcu_callback() before
 bypassing
Message-ID: <YyT3AfDnLxo3zbo1@google.com>
References: <20220915001419.55617-1-joel@joelfernandes.org>
 <20220915001419.55617-3-joel@joelfernandes.org>
 <20220916110949.GB25456@lothringen>
 <YyT2YlI9HK/Z2GPT@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YyT2YlI9HK/Z2GPT@google.com>
X-Spam-Status: No, score=-0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLACK autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 16, 2022 at 10:19:14PM +0000, Joel Fernandes wrote:
[...]
> >> +	if (rcu_nocb_try_bypass(rdp, head, &was_alldone, flags))
> >> +		return; // Enqueued onto ->nocb_bypass, so just leave.
> >> +	// If no-CBs CPU gets here, rcu_nocb_try_bypass() acquired
> >> ->nocb_lock.
> >> +	rcu_segcblist_enqueue(&rdp->cblist, head);
> >> +
> >>  	trace_rcu_segcb_stats(&rdp->cblist, TPS("SegCBQueued"));
> >>  
> >>  	/* Go handle any RCU core processing required. */
> >
> > Two subtle changes induced here:
> >
> > * rcu_segcblist_n_cbs() is now read lockless. It's just tracing so no huge
> > deal
> >   but still, if this races with callbacks invocation, we may on some rare
> >   occasion
> >   read stale numbers on traces while enqueuing (think about rcu_top for
> >   example)
> 
> Actually I disagree with this point now. Changes to the number of callbacks
> in the main ->cblist can be lockless. It uses atomic on CONFIG_RCU_NOCB. On
> non CONFIG_RCU_NOCB, CB cannot be queued as interrupts will be disabled.
> 
> Also, in rcu_do_batch(), the count is manipulated after calling
> rcu_nocb_lock_irqsave(rdp, flags);
> 
> > * trace_rcu_callback() will now show the number of callbacks _before_
> > enqueuing
> >   instead of _after_. Not sure if it matters, but sometimes tools rely on
> >   trace
> >   events.
> 
> Yeah this is fixable and good point. So how about the below?
> 
> ---8<-----------------------
> 
> From: "Joel Fernandes (Google)" <joel@joelfernandes.org>
> Subject: [PATCH] rcu: Call trace_rcu_callback() also for bypass queuing
> 
> If any CB is queued into the bypass list, then trace_rcu_callback() does
> not show it. This makes it not clear when a callback was actually
> queued, as you only end up getting a trace_rcu_invoke_callback() trace.
> Fix it by calling the tracing function even for bypass queue.
> 
> Also, while at it, optimize the tracing so that rcu_state is not
> accessed here if tracing is disabled, because that's useless if we are
> not tracing. A quick inspection of the generated assembler shows that
> rcu_state is accessed even if the jump label for the tracepoint is
> disabled.
> 
> __trace_rcu_callback:
>         movq    8(%rdi), %rcx
>         movq    rcu_state+3640(%rip), %rax
>         movq    %rdi, %rdx
>         cmpq    $4095, %rcx
>         ja      .L3100
>         movq    192(%rsi), %r8
>         1:jmp .L3101 # objtool NOPs this
>         .pushsection __jump_table,  "aw"
>          .balign 8
>         .long 1b - .
>         .long .L3101 - .
>          .quad __tracepoint_rcu_kvfree_callback+8 + 2 - .
>         .popsection
> 
> With this change, the jump label check which is NOOPed is moved to the
> beginning of the function.
> 
> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> ---
>  kernel/rcu/tree.c | 31 +++++++++++++++++++++++--------
>  1 file changed, 23 insertions(+), 8 deletions(-)
> 
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index 5ec97e3f7468..b64df55f7f55 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -2728,6 +2728,23 @@ static void check_cb_ovld(struct rcu_data *rdp)
>  	raw_spin_unlock_rcu_node(rnp);
>  }
>  
> +/*
> + * Trace RCU callback helper, call after enqueuing callback.
> + * The ->cblist must be locked when called.

Also sorry for the spam, this comment is stale now so will delete this line.

