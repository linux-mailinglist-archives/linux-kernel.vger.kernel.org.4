Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F06005EFD8C
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 21:02:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230100AbiI2TCE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 15:02:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230036AbiI2TB6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 15:01:58 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 462B312059C
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 12:01:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=8Z9l+iKfRNL4ZprThx3uP/VDdA1mXNoyK+Suc+haG4E=; b=iw/G8/+MmdIo+aBqx8qKIeRBuT
        LwEs9SN4D2yL7KIu8lad6Rbc7ArfHYPlLtAwWv6SJfe59EHq21BPdzZiSv7VlpXHQr8eKJ5tTnHZh
        h8XZgUmuMb74ZBkDpid3eqhkkIwMoS9/4191S7O9fteQ1ViloqOVx5gYuyLdlGMIMk5AYbx9MorVv
        Xcs6p4T2ovAQxJae5TFBadcKAp49Lm4ZLtP9SDX2N5Pg2FhYWQglZXpiP0PzqB3h4Th2Z3ZZvB9jQ
        vO5gisSL0ocZOF5HIzkDohCN6IeA+OxAvWW314rK5ONyGz5+aLSG0AGuFtx0akj6RNwjKGZfYwMba
        8u4xI8nA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1odyn9-00DWxl-Nq; Thu, 29 Sep 2022 19:01:51 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 2C3A5300110;
        Thu, 29 Sep 2022 21:01:47 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 17F752BCD47B3; Thu, 29 Sep 2022 21:01:47 +0200 (CEST)
Date:   Thu, 29 Sep 2022 21:01:46 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, Boqun Feng <boqun.feng@gmail.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: RCU vs NOHZ
Message-ID: <YzXrms/hMJgpa2JV@hirez.programming.kicks-ass.net>
References: <20220915191427.GC246308@paulmck-ThinkPad-P17-Gen-1>
 <YyOnilnwnLKA9ghN@hirez.programming.kicks-ass.net>
 <20220916075817.GE246308@paulmck-ThinkPad-P17-Gen-1>
 <YyQ/zn54D1uoaIc1@hirez.programming.kicks-ass.net>
 <20220917142508.GF246308@paulmck-ThinkPad-P17-Gen-1>
 <YzV5vqoLInptafJm@hirez.programming.kicks-ass.net>
 <20220929152044.GE4196@paulmck-ThinkPad-P17-Gen-1>
 <20220929154618.GA2864141@paulmck-ThinkPad-P17-Gen-1>
 <YzXGdEzkiw+5X8pC@hirez.programming.kicks-ass.net>
 <20220929164204.GO4196@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220929164204.GO4196@paulmck-ThinkPad-P17-Gen-1>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 29, 2022 at 09:42:04AM -0700, Paul E. McKenney wrote:
> On Thu, Sep 29, 2022 at 06:23:16PM +0200, Peter Zijlstra wrote:
> > On Thu, Sep 29, 2022 at 08:46:18AM -0700, Paul E. McKenney wrote:
> > > On Thu, Sep 29, 2022 at 08:20:44AM -0700, Paul E. McKenney wrote:
> > 
> > > > > > There is a directly invoked RCU hook for any transition that enables or
> > > > > > disables the tick, namely the ct_*_enter() and ct_*_exit() functions,
> > > > > > that is, those functions formerly known as rcu_*_enter() and rcu_*_exit().
> > > > > 
> > > > > Context tracking doesn't know about NOHZ, therefore RCU can't either.
> > > > > Context tracking knows about IDLE, but not all IDLE is NOHZ-IDLE.
> > > > > 
> > > > > Specifically we have:
> > > > > 
> > > > > 	ct_{idle,irq,nmi,user,kernel}_enter()
> > > > > 
> > > > > And none of them are related to NOHZ in the slightest. So no, RCU does
> > > > > not have a NOHZ callback.
> > > > > 
> > > > > I'm still thikning you're conflating NOHZ_FULL (stopping the tick when
> > > > > in userspace) and regular NOHZ (stopping the tick when idle).
> > > 
> > > Exactly how are ct_user_enter() and ct_user_exit() completely unrelated
> > > to nohz_full CPUs?
> > 
> > That's the thing; I'm not talking about nohz_full. I'm talking about
> > regular nohz. World of difference there.
> 
> And indeed, for !nohz_full CPUs, the tick continues throughout userspace
> execution.  But you really did have ct_user_enter() and ct_user_exit()
> on your list.
> 
> And for idle (as opposed to nohz_full userspace execution), there is still
> ct_{idle,irq,nmi}_enter().  And RCU does pay attention to these.
> 
> So exactly what are you trying to tell me here?  ;-)

That RCU doens't have a nohz callback -- you were arguing it does
through the ct_*_enter() things, I said none of them are related to
nohz.
