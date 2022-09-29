Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E3605EFA61
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 18:26:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235709AbiI2Q0G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 12:26:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236272AbiI2QZj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 12:25:39 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C3ED13F70F
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 09:23:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=KZ3fV59CesKghMkILeqQGGCDBJNNycBOEuAGsaJgiig=; b=PUugdqj6xeGCEsg1OqJcdJ+4Hb
        +S9oWEo2Qc/aLAOovpMWhK8/buecIbNLCifwg1d2M4SUHjfssD3hPe+ZPt7iPBjwIq2okn4EJ5Gur
        /PWckTC7hvWbqW2mDUtqZm+2YusKojMPBN4vV8AXNs1e+xWge9ZQo/cR/1Xrm7QOEweZdOcVkpeTm
        TJtlol98s0AjWUWZia0kkNKC4rcTjfcTS0DJODyir2B65B9/WTa1WA1dgrRjaeqxIPNHwz2f1QUBP
        ZsKblRckGqym6icO7xH9s74Ztqw99yXpI+wGVxgHWqK1N1PuT4vMmSjNV0ndmQXD6tJn+ZcLXHjLj
        sfr6+jjA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1odwJh-00GwHg-G8; Thu, 29 Sep 2022 16:23:17 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 22078300462;
        Thu, 29 Sep 2022 18:23:17 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 0CE232BCB5D70; Thu, 29 Sep 2022 18:23:17 +0200 (CEST)
Date:   Thu, 29 Sep 2022 18:23:16 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, Boqun Feng <boqun.feng@gmail.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: RCU vs NOHZ
Message-ID: <YzXGdEzkiw+5X8pC@hirez.programming.kicks-ass.net>
References: <20220915160600.GA246308@paulmck-ThinkPad-P17-Gen-1>
 <YyN0BKEoDbe4hcIl@hirez.programming.kicks-ass.net>
 <20220915191427.GC246308@paulmck-ThinkPad-P17-Gen-1>
 <YyOnilnwnLKA9ghN@hirez.programming.kicks-ass.net>
 <20220916075817.GE246308@paulmck-ThinkPad-P17-Gen-1>
 <YyQ/zn54D1uoaIc1@hirez.programming.kicks-ass.net>
 <20220917142508.GF246308@paulmck-ThinkPad-P17-Gen-1>
 <YzV5vqoLInptafJm@hirez.programming.kicks-ass.net>
 <20220929152044.GE4196@paulmck-ThinkPad-P17-Gen-1>
 <20220929154618.GA2864141@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220929154618.GA2864141@paulmck-ThinkPad-P17-Gen-1>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 29, 2022 at 08:46:18AM -0700, Paul E. McKenney wrote:
> On Thu, Sep 29, 2022 at 08:20:44AM -0700, Paul E. McKenney wrote:

> > > > There is a directly invoked RCU hook for any transition that enables or
> > > > disables the tick, namely the ct_*_enter() and ct_*_exit() functions,
> > > > that is, those functions formerly known as rcu_*_enter() and rcu_*_exit().
> > > 
> > > Context tracking doesn't know about NOHZ, therefore RCU can't either.
> > > Context tracking knows about IDLE, but not all IDLE is NOHZ-IDLE.
> > > 
> > > Specifically we have:
> > > 
> > > 	ct_{idle,irq,nmi,user,kernel}_enter()
> > > 
> > > And none of them are related to NOHZ in the slightest. So no, RCU does
> > > not have a NOHZ callback.
> > > 
> > > I'm still thikning you're conflating NOHZ_FULL (stopping the tick when
> > > in userspace) and regular NOHZ (stopping the tick when idle).
> 
> Exactly how are ct_user_enter() and ct_user_exit() completely unrelated
> to nohz_full CPUs?

That's the thing; I'm not talking about nohz_full. I'm talking about
regular nohz. World of difference there.

nohz_full is a gimmick that shouldn't be used outside of very specific
cases. Regular nohz otoh is used by everybody always.
