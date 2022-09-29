Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E14C65EFA17
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 18:19:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236113AbiI2QS6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 12:18:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236145AbiI2QSo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 12:18:44 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53BD5134
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 09:18:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=RRcgouIhRpsXRYbTpALW7dcfON9bMmeEmfVVxT01Qu8=; b=cFuINGEJcFcfQa4/PWs3f5aBmm
        kUIgmMp/nqGb1MN4ljiwgMFlWsZwTEs/nJrHlTnuokG5AZ36P9cLMI8CK6Q3STc6AZLJaHMV67/EZ
        Ts5v7Eu7K8YJn84Gp6JGqWwtqqmiVj09JRvfD14bDFcZsxIk+5gEJvSu/S0fiNAGTHFuGDMpDRnfE
        O26ff47sKYHyxXoJICqLFydK9XfbQle35UhS7vrBdfjqJjEgjnuD2ujWNZmifRjYi/K45mRbLfiXQ
        E9pXD/UrVy6li1IEqx+lnY1bCPpjMl0rS1JQtmZR1Uyybff2PlRO3IZ884cGpeGWssl9Kr7A6+3yA
        Xa5Xxyug==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1odwF7-00GwE4-LP; Thu, 29 Sep 2022 16:18:34 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 790B830008D;
        Thu, 29 Sep 2022 18:18:32 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 623092BCABC64; Thu, 29 Sep 2022 18:18:32 +0200 (CEST)
Date:   Thu, 29 Sep 2022 18:18:32 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, Boqun Feng <boqun.feng@gmail.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: RCU vs NOHZ
Message-ID: <YzXFWEL52MRp2s5j@hirez.programming.kicks-ass.net>
References: <YyLksEr05QTNo05Q@hirez.programming.kicks-ass.net>
 <20220915160600.GA246308@paulmck-ThinkPad-P17-Gen-1>
 <YyN0BKEoDbe4hcIl@hirez.programming.kicks-ass.net>
 <20220915191427.GC246308@paulmck-ThinkPad-P17-Gen-1>
 <YyOnilnwnLKA9ghN@hirez.programming.kicks-ass.net>
 <20220916075817.GE246308@paulmck-ThinkPad-P17-Gen-1>
 <YyQ/zn54D1uoaIc1@hirez.programming.kicks-ass.net>
 <20220917142508.GF246308@paulmck-ThinkPad-P17-Gen-1>
 <YzV5vqoLInptafJm@hirez.programming.kicks-ass.net>
 <20220929152044.GE4196@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220929152044.GE4196@paulmck-ThinkPad-P17-Gen-1>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 29, 2022 at 08:20:44AM -0700, Paul E. McKenney wrote:

> > To recap; we want the CPU to go into deeper idle states, no?
> > 
> > RCU can currently inhibit this by having callbacks pending for this CPU
> > -- in this case RCU inhibits NOHZ-IDLE and deep power states are not
> > selected or less effective.
> > 
> > Now, deep idle states actually purge the caches, so cache locality
> > cannot be an argument to keep the callbacks local.
> > 
> > We know when we're doing deep idle we stop the tick.
> > 
> > So why not, when stopping the tick, move the RCU pending crud elsewhere
> > and let the CPU get on with going idle instead of inhibiting the
> > stopping of the tick and wrecking deep idle?
> 
> Because doing so in the past has cost more energy than is saved.

How has this been tried; and why did the energy cost go up? Is this
because the offload thread ends up waking up the CPU we just put to
sleep?

By default I think the offload stuff just doesn't work well for
!NOHZ_FULL situations; that is, NOHZ_FULL is the only case where there
are housekeeper CPUs that take care of the offload threads.

Hence my initial suggestion to force the pending work into the jiffy
owner CPU.
