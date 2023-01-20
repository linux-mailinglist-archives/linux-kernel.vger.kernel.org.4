Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EDB06755FB
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 14:38:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229496AbjATNik (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 08:38:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjATNii (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 08:38:38 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 372035421A;
        Fri, 20 Jan 2023 05:38:30 -0800 (PST)
Date:   Fri, 20 Jan 2023 14:38:27 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1674221908;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=NsKNz+h7l7zK73sE5jHBFOsX4kUSjPMG5HGuXT67KNU=;
        b=hMVb0C/qwtLknqlm9ZTWsZp8gViVTHq3936ul8+F/rjZ2C/sgt5+DFrbylMt7YcpAHU3oH
        s5YRhw0mbmU5xAOUw11TSsuYNR6BabwKiK0BUZH6EnHXFtJrzjrfU7+jk9sLeRQFhl52bM
        noYQvDhJmie3ohgf6vlqG25yiFWOsAwo294gs5CU+91q19gh2Ous1s4W2gLWSXf4hfFq5g
        N/SSCNdKYGIkOYGevx1ji2XNC15o/itV2b+YKslr31hccta4mAL/107ExcW87kQo7dXxix
        HZ6fc5RqejZNFrSOnc60iWEfw7mR8Tr5XafJoL8j51qB5CsHiSldM4D/A+x0Yw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1674221908;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=NsKNz+h7l7zK73sE5jHBFOsX4kUSjPMG5HGuXT67KNU=;
        b=1/EOPOv6QyXT4fegGzYXsWuax92mLA9Ez2GeK/k4fouB6Yl9u7shmtVu/E/cx6Mcn5/W6Z
        NQC1tgrEqUl2cjDA==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Linux-RT <linux-rt-users@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] locking/rwbase: Prevent indefinite writer starvation
Message-ID: <Y8qZU33Cvbc7p7DE@linutronix.de>
References: <Y8avJm1FQI9vB9cv@linutronix.de>
 <20230117165021.t5m7c2d6frbbfzig@techsingularity.net>
 <Y8gPhTGkfCbGwoUu@linutronix.de>
 <20230118173130.4n2b3cs4pxiqnqd3@techsingularity.net>
 <Y8j+lENBWNWgt4mf@linutronix.de>
 <20230119110220.kphftcehehhi5l5u@techsingularity.net>
 <Y8lvwKHmmnikVDgk@linutronix.de>
 <20230119174101.rddtxk5xlamlnquh@techsingularity.net>
 <Y8pP3CD1PQ4KWhXF@linutronix.de>
 <20230120132441.4jjke47rnpikiuf5@techsingularity.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230120132441.4jjke47rnpikiuf5@techsingularity.net>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-01-20 13:24:41 [+0000], Mel Gorman wrote:
> --- a/kernel/locking/rwbase_rt.c
> +++ b/kernel/locking/rwbase_rt.c
> @@ -264,12 +291,17 @@ static int __sched rwbase_write_lock(struct rwbase_rt *rwb,
>  		if (__rwbase_write_trylock(rwb))
>  			break;
>  
> +		/* Record timeout when reader bias is ignored. */
> +		rwb->waiter_timeout = jiffies + RWBASE_RT_WAIT_TIMEOUT;
		rwb->waiter_timeout = (jiffies + RWBASE_RT_WAIT_TIMEOUT) | 1;

There is the unlikely case that (jiffies + RWBASE_RT_WAIT_TIMEOUT) = 0
on 32bit where it is not jiffies64.

Reviewed-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

> +
>  		raw_spin_unlock_irqrestore(&rtm->wait_lock, flags);
>  		rwbase_schedule();
>  		raw_spin_lock_irqsave(&rtm->wait_lock, flags);
>  
>  		set_current_state(state);
>  	}
> +
> +	rwb->waiter_timeout = 0;
>  	rwbase_restore_current_state();
>  	trace_contention_end(rwb, 0);

Sebastian
