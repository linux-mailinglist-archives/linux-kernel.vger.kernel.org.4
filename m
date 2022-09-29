Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F6025EFAFB
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 18:36:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235452AbiI2Qgc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 12:36:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235120AbiI2Qg2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 12:36:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95FC912BD87
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 09:36:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CD13761AEC
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 16:36:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 317A4C433C1;
        Thu, 29 Sep 2022 16:36:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664469385;
        bh=Exf5U9+1cf47ntnwsKyKHqWoAfjf0CKJh2shETDkJwg=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=lHa8WvKOAGLIegCcaA3nZtGjPbtP2LOSjU8sv1uZqPD3x5umPNHUIasjvkwl3FROk
         ZMpZPA4A/qPnyy5+tEuM3MC8Pe2c5jVR2Et84wAC3ON+gO9ddZvhc28sroj7Hmvhdn
         8O9SW+tHuh9YMDhaXut7d6mGWQ6fCPyWcJIFiEliBJZMOSx8hQjtlJoEziDiGG+lQT
         pYtHmAc0EU6WlIy22BR+NJWNaWqV9ik7dnXX8Jueubksde+gJ9MPYoAPa3aBelL1Ip
         FgTnr/eM6Uj1adc3tHV1PaWJqQopqDmBIXmSthU/i6I/BCX+L2oRXYwzFqKfJPdJnP
         4CVI7dRFNtjVg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id AC50B5C0BCA; Thu, 29 Sep 2022 09:36:24 -0700 (PDT)
Date:   Thu, 29 Sep 2022 09:36:24 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, Boqun Feng <boqun.feng@gmail.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: RCU vs NOHZ
Message-ID: <20220929163624.GN4196@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20220915160600.GA246308@paulmck-ThinkPad-P17-Gen-1>
 <YyN0BKEoDbe4hcIl@hirez.programming.kicks-ass.net>
 <20220915191427.GC246308@paulmck-ThinkPad-P17-Gen-1>
 <YyOnilnwnLKA9ghN@hirez.programming.kicks-ass.net>
 <20220916075817.GE246308@paulmck-ThinkPad-P17-Gen-1>
 <YyQ/zn54D1uoaIc1@hirez.programming.kicks-ass.net>
 <20220917142508.GF246308@paulmck-ThinkPad-P17-Gen-1>
 <YzV5vqoLInptafJm@hirez.programming.kicks-ass.net>
 <20220929152044.GE4196@paulmck-ThinkPad-P17-Gen-1>
 <YzXFWEL52MRp2s5j@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YzXFWEL52MRp2s5j@hirez.programming.kicks-ass.net>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 29, 2022 at 06:18:32PM +0200, Peter Zijlstra wrote:
> On Thu, Sep 29, 2022 at 08:20:44AM -0700, Paul E. McKenney wrote:
> 
> > > To recap; we want the CPU to go into deeper idle states, no?
> > > 
> > > RCU can currently inhibit this by having callbacks pending for this CPU
> > > -- in this case RCU inhibits NOHZ-IDLE and deep power states are not
> > > selected or less effective.
> > > 
> > > Now, deep idle states actually purge the caches, so cache locality
> > > cannot be an argument to keep the callbacks local.
> > > 
> > > We know when we're doing deep idle we stop the tick.
> > > 
> > > So why not, when stopping the tick, move the RCU pending crud elsewhere
> > > and let the CPU get on with going idle instead of inhibiting the
> > > stopping of the tick and wrecking deep idle?
> > 
> > Because doing so in the past has cost more energy than is saved.
> 
> How has this been tried; and why did the energy cost go up? Is this
> because the offload thread ends up waking up the CPU we just put to
> sleep?

Because doing the additional work consumes energy.  I am not clear on
exactly what you are asking for here, given the limitations of the tools
that measure energy consumption.

> By default I think the offload stuff just doesn't work well for
> !NOHZ_FULL situations; that is, NOHZ_FULL is the only case where there
> are housekeeper CPUs that take care of the offload threads.
> 
> Hence my initial suggestion to force the pending work into the jiffy
> owner CPU.

By all means, please feel free to prove me wrong.  But doing so requires
real code and real testing of real energy consumption by real hardware
running real workloads.

It also requires correctly handling races with all and sundry.

							Thanx, Paul
