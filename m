Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CBF267C28B
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 02:45:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229477AbjAZBpt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 20:45:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230208AbjAZBpq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 20:45:46 -0500
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 715A2611D2
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 17:45:45 -0800 (PST)
Received: (qmail 239293 invoked by uid 1000); 25 Jan 2023 20:45:44 -0500
Date:   Wed, 25 Jan 2023 20:45:44 -0500
From:   Alan Stern <stern@rowland.harvard.edu>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>,
        Andrea Parri <parri.andrea@gmail.com>,
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
Message-ID: <Y9HbSBLrNJ9O2ad6@rowland.harvard.edu>
References: <20230125022019.GB2948950@paulmck-ThinkPad-P17-Gen-1>
 <cedf3a39-12cd-1cb1-ad5a-7c10768cee40@huaweicloud.com>
 <20230125150520.GG2948950@paulmck-ThinkPad-P17-Gen-1>
 <Y9FMEATzv3gcTUe2@rowland.harvard.edu>
 <20230125171832.GH2948950@paulmck-ThinkPad-P17-Gen-1>
 <Y9F+SyLpxHwdK0rE@rowland.harvard.edu>
 <20230125194651.GN2948950@paulmck-ThinkPad-P17-Gen-1>
 <Y9GVFkVRRRs5/rBd@rowland.harvard.edu>
 <20230125213832.GQ2948950@paulmck-ThinkPad-P17-Gen-1>
 <20230125233308.GA1552266@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230125233308.GA1552266@paulmck-ThinkPad-P17-Gen-1>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_PASS,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 25, 2023 at 03:33:08PM -0800, Paul E. McKenney wrote:
> Ah, and returning to the earlier question as to whether srcu_read_unlock()
> can use release semantics instead of smp_mb(), at the very least, this
> portion of the synchronize_srcu() function's header comment must change:
> 
> 	On systems with more than one CPU, when synchronize_srcu()
> 	returns, each CPU is guaranteed to have executed a full
> 	memory barrier since the end of its last corresponding SRCU
> 	read-side critical section whose beginning preceded the call
> 	to synchronize_srcu().

Yes, that would not be true.  But on the other hand, it would be true 
that each CPU is guaranteed to have executed a release memory barrier 
since the end of its last corresponding SRCU read-side critical section 
whose beginning preceded the call to synchronize_srcu(), _and_ the CPU 
executing synchronize_srcu() is guaranteed to have executed a full 
memory barrier after seeing the values from all those release stores.
This is not quite the same thing but it ought to be just as good.

> I don't know of any SRCU code that relies on this, but it would be good to
> check.	There used to (and might still) be RCU code relying on this, which
> is why this sentence was added to the header comment in the first place.

If there is code relying on that guarantee, it ought to work just as 
well by relying on the modified guarantee.

Of course, there might be code relying on a guarantee that 
srcu_read_unlock() executes a full memory barrier.  This guarantee would 
certainly no longer hold.  But as I understand it, this guarantee was 
never promised by the SRCU subsystem.

Alan
