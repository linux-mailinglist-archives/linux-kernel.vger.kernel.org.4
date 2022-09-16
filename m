Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E37A5BA94E
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 11:23:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229743AbiIPJU0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 05:20:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbiIPJUX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 05:20:23 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12AFF491DF
        for <linux-kernel@vger.kernel.org>; Fri, 16 Sep 2022 02:20:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=yyGS+WmRbcBSpUYkZXt6Ui9Bdjdm1BlPe9z08aqPrwg=; b=DFjdBU5FL1x/EL8FPYVj+YnkSu
        1CsusjCdi8NFzvGCD2xCmp0Yt/ZeXpYmHnoGM3lDTEtqfb+CzIjtyrOskLgN73s3htWCgW2KzH+hU
        6rQfucpjpiQyv6XN0nzKwSEdsEZormSs2445unBq6v7O/AxiOizw0rx+P0C1ioVoMAS19rdE72may
        Bk2uUvqNCMp0DTwpS34Y4pWdGKgisitTVze/nBFxiakC6m0zDDb1tAhWXNgm9VaPLq2GpIVjywMub
        WHTX1/j/5DOUCRkQ2Nn6BUlYuyXm6HQCM+sjCEmKs1zZvqieSSTdgM7dBJv0C/1JbbIMc0G6sZGj7
        dYKuOWTA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oZ7WE-0023gs-V0; Fri, 16 Sep 2022 09:20:19 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 03B773002AE;
        Fri, 16 Sep 2022 11:20:15 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id E00F52BAB8706; Fri, 16 Sep 2022 11:20:14 +0200 (CEST)
Date:   Fri, 16 Sep 2022 11:20:14 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, Boqun Feng <boqun.feng@gmail.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: RCU vs NOHZ
Message-ID: <YyQ/zn54D1uoaIc1@hirez.programming.kicks-ass.net>
References: <YyLksEr05QTNo05Q@hirez.programming.kicks-ass.net>
 <20220915160600.GA246308@paulmck-ThinkPad-P17-Gen-1>
 <YyN0BKEoDbe4hcIl@hirez.programming.kicks-ass.net>
 <20220915191427.GC246308@paulmck-ThinkPad-P17-Gen-1>
 <YyOnilnwnLKA9ghN@hirez.programming.kicks-ass.net>
 <20220916075817.GE246308@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220916075817.GE246308@paulmck-ThinkPad-P17-Gen-1>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 16, 2022 at 12:58:17AM -0700, Paul E. McKenney wrote:

> To the best of my knowledge at this point in time, agreed.  Who knows
> what someone will come up with next week?  But for people running certain
> types of real-time and HPC workloads, context tracking really does handle
> both idle and userspace transitions.

Sure, but idle != nohz. Nohz is where we disable the tick, and currently
RCU can inhibit this -- rcu_needs_cpu().

AFAICT there really isn't an RCU hook for this, not through context
tracking not through anything else.

> It wasn't enabled for ChromeOS.
> 
> When fully enabled, it gave them the energy-efficiency advantages Joel
> described.  And then Joel described some additional call_rcu_lazy()
> changes that provided even better energy efficiency.  Though I believe
> that the application should also be changed to avoid incessantly opening
> and closing that file while the device is idle, as this would remove
> -all- RCU work when nearly idle.  But some of the other call_rcu_lazy()
> use cases would likely remain.

So I'm thinking the scheme I outlined gets you most if not all of what
lazy would get you without having to add the lazy thing. A CPU is never
refused deep idle when it passes off the callbacks.

The NOHZ thing is a nice hook for 'this-cpu-wants-to-go-idle-long-term'
and do our utmost bestest to move work away from it. You *want* to break
affinity at this point.

If you hate on the global, push it to a per rcu_node offload list until
the whole node is idle and then push it up the next rcu_node level until
you reach the top.

Then when the top rcu_node is full idle; you can insta progress the QS
state and run the callbacks and go idle.
