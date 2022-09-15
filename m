Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC76C5BA0FA
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 20:51:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229567AbiIOSvC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 14:51:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbiIOSu5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 14:50:57 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FE3B895F9
        for <linux-kernel@vger.kernel.org>; Thu, 15 Sep 2022 11:50:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Y3/OsDB+tCXSurOGbQPCyu5Vi3DPFNawOvXCBwr6bCs=; b=MNx3Ny3fbabrb2MySFIgszB18E
        tWM+b/8WSpP9OgKLedDdjMVRra+O7Ts2ucg20TRzpd+Gob0aJXBVJXUFCEOMmfLbr3cbiNDPmAQ7h
        m0+B24Zh6X2368PzX6LIfXjWlwpVkKMJrir9Fhg69eAxJNoB6dni1sYbv1YRcCGJ/EyzlfxvJJF2t
        EMGOhCNJbA6c071P/pWeKl3IU7m4zsU4jJZxOWAIlplwdpCKoMStes1ShfzGIZ+ZDI8y37b/kblqr
        hYMuIEovYVY2m/oKMsY/D3/VVLLnwmcK975E70GSKyTqnGBEEU49b8UQX95kUfZzbNj2+0/uGy/Tw
        U3CgrtJA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oYtwn-001Mlx-1O; Thu, 15 Sep 2022 18:50:49 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 2DB6830013F;
        Thu, 15 Sep 2022 20:50:45 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 03D0B2BA9C050; Thu, 15 Sep 2022 20:50:44 +0200 (CEST)
Date:   Thu, 15 Sep 2022 20:50:44 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, Boqun Feng <boqun.feng@gmail.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: RCU vs NOHZ
Message-ID: <YyN0BKEoDbe4hcIl@hirez.programming.kicks-ass.net>
References: <YyLksEr05QTNo05Q@hirez.programming.kicks-ass.net>
 <20220915160600.GA246308@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220915160600.GA246308@paulmck-ThinkPad-P17-Gen-1>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 15, 2022 at 09:06:00AM -0700, Paul E. McKenney wrote:
> On Thu, Sep 15, 2022 at 10:39:12AM +0200, Peter Zijlstra wrote:
> > Hi,
> > 
> > After watching Joel's talk about RCU and idle ticks I was wondering
> > about why RCU doesn't have NOHZ hooks -- that is regular NOHZ, not the
> > NOHZ_FULL stuff.
> 
> It actually does, but they have recently moved into the context-tracking
> code, courtesy of Frederic's recent patch series.

afair that's idle and that is not nohz.

> > These deep idle states are only feasible during NOHZ idle, and the NOHZ
> > path is already relatively expensive (which is offset by then mostly
> > staying idle for a long while).
> > 
> > Specifically my thinking was that when a CPU goes NOHZ it can splice
> > it's callback list onto a global list (cmpxchg), and then the
> > jiffy-updater CPU can look at and consume this global list (xchg).
> > 
> > Before you say... but globals suck (they do), NOHZ already has a fair
> > amount of global state, and as said before, it's offset by the CPU then
> > staying idle for a fair while. If there is heavy contention on the NOHZ
> > data, the idle governor is doing a bad job by selecting deep idle states
> > whilst we're not actually idle for long.
> > 
> > The above would remove the reason for RCU to inhibit NOHZ.
> > 
> > 
> > Additionally; when the very last CPU goes idle (I think we know this
> > somewhere, but I can't reaily remember where) we can insta-advance the
> > QS machinery and run the callbacks before going (NOHZ) idle.
> > 
> > 
> > Is there a reason this couldn't work? To me this seems like a much
> > simpler solution than the whole rcu-cb thing.
> 
> To restate Joel's reply a bit...
> 
> Maybe.
> 
> Except that we need rcu_nocbs anyway for low latency and HPC applications.
> Given that we have it, and given that it totally eliminates RCU-induced
> idle ticks, how would it help to add cmpxchg-based global offloading?

Because that nocb stuff isn't default enabled?
