Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8F17672EE5
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 03:19:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229943AbjASCTS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 21:19:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229923AbjASCTM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 21:19:12 -0500
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 5E08266EDA
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 18:19:08 -0800 (PST)
Received: (qmail 233345 invoked by uid 1000); 18 Jan 2023 21:19:07 -0500
Date:   Wed, 18 Jan 2023 21:19:07 -0500
From:   Alan Stern <stern@rowland.harvard.edu>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Andrea Parri <parri.andrea@gmail.com>,
        Jonas Oberhauser <jonas.oberhauser@huawei.com>,
        Peter Zijlstra <peterz@infradead.org>, will <will@kernel.org>,
        "boqun.feng" <boqun.feng@gmail.com>, npiggin <npiggin@gmail.com>,
        dhowells <dhowells@redhat.com>,
        "j.alglave" <j.alglave@ucl.ac.uk>,
        "luc.maranget" <luc.maranget@inria.fr>, akiyks <akiyks@gmail.com>,
        dlustig <dlustig@nvidia.com>, joel <joel@joelfernandes.org>,
        urezki <urezki@gmail.com>,
        quic_neeraju <quic_neeraju@quicinc.com>,
        frederic <frederic@kernel.org>,
        Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: Internal vs. external barriers (was: Re: Interesting LKMM litmus
 test)
Message-ID: <Y8iom6Mjz9rCX42A@rowland.harvard.edu>
References: <Y8aKlNY4Z0z2Yqs0@andrea>
 <20230117151416.GI2948950@paulmck-ThinkPad-P17-Gen-1>
 <Y8bFMgDSUZymXUsS@rowland.harvard.edu>
 <20230117174308.GK2948950@paulmck-ThinkPad-P17-Gen-1>
 <Y8cBypKx4gM3wBJa@rowland.harvard.edu>
 <20230118035041.GQ2948950@paulmck-ThinkPad-P17-Gen-1>
 <Y8gjUKoHxqR9+7Hx@rowland.harvard.edu>
 <20230118200601.GH2948950@paulmck-ThinkPad-P17-Gen-1>
 <Y8hclxuhpGm+krkz@rowland.harvard.edu>
 <20230119000214.GM2948950@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230119000214.GM2948950@paulmck-ThinkPad-P17-Gen-1>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_PASS,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 18, 2023 at 04:02:14PM -0800, Paul E. McKenney wrote:
> On Wed, Jan 18, 2023 at 03:54:47PM -0500, Alan Stern wrote:
> > How does this differ from srcu_read_lock() and srcu_read_unlock()?  And 
> > how do the "up" and "down" parts figure into it? -- what is going up or 
> > down?
> 
> Functionally and from a performance/scalability viewpoint, they
> are identical to srcu_read_lock() and srcu_read_unlock().  The only
> difference is that srcu_down_read() and srcu_up_read() lack the lockdep
> machinery that complains when a matching pair of srcu_read_lock() and
> srcu_read_unlock() are used from different tasks.

This makes me wonder if there's any need for srcu_down_read and 
srcu_up_read at all.  Why not just use srcu_read_lock and 
srcu_read_unlock, and remove the lockdep check?

> Within the implementation, nothing ever goes down, it is all
> this_cpu_inc().  The "down" and "up" are by analogy to down() and up(),
> where "down()" says acquire some rights to a resource and "up()" says
> release those rights.

Another reason not to use those names.  If you insist on making these 
operations distinct from srcu_read_lock and srcu_read_unlock, why not 
borrow the "_get" and "_put" nomenclature used by the device core?  I 
suspect more people would associate them with acquiring and releasing 
rights to a resource.  (Although in this case it might be so clear 
exactly what that resource is.)

> Wait, I can make "down" work.
> 
> A call to srcu_down_read() reduces the quantity computed by summing the
> unlocks then subtracting the sum of the locks.  A call to srcu_up_read()
> increases that same quantity.  ;-)

I can't honestly call that a resoundingly convincing argument.  :-)

Alan
