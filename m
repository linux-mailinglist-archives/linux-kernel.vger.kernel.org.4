Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9540267C298
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 02:53:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230058AbjAZBxe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 20:53:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbjAZBxc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 20:53:32 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBA7F5CFDB
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 17:53:31 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 590E9616FD
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 01:53:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A762FC433EF;
        Thu, 26 Jan 2023 01:53:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674698010;
        bh=wJBCpvOUggRZAzpKmkRbE+EqH0eTmD+JjRf4yHZ1aNs=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=AkL89hc3VbiPFAzKU/KIYYLuHF3QW0R1DgW/xTcvrj3fgqVMY3yrbguM4NLv5W1xo
         i9OWBoiScO1oesk5qjAj0HI/K2YOwnHR08ZGbS2JeVDj8ygH/48HA6n3i3WB1o3R8/
         OIrtYzGb0cBZzov2TGT8c/r/gGnl5bG1EgowfN/dcuW3An0AD2G+BqZ7SstF/r5Ovl
         Dzgmu9gflK/w9iDOZBwPy2mvQEAEFcUYdUON4EK84AKHUTKgRRidBYjfTwVAt9YjjG
         6kK1WKN56eu8xUyUbOfatk03md8S4uBbgaY8635W/TM0Ap5DX8+yY1djVp+thNwier
         q82y4swowT3Rg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 4D4585C08EF; Wed, 25 Jan 2023 17:53:30 -0800 (PST)
Date:   Wed, 25 Jan 2023 17:53:30 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Alan Stern <stern@rowland.harvard.edu>
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
Message-ID: <20230126015330.GX2948950@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <cedf3a39-12cd-1cb1-ad5a-7c10768cee40@huaweicloud.com>
 <20230125150520.GG2948950@paulmck-ThinkPad-P17-Gen-1>
 <Y9FMEATzv3gcTUe2@rowland.harvard.edu>
 <20230125171832.GH2948950@paulmck-ThinkPad-P17-Gen-1>
 <Y9F+SyLpxHwdK0rE@rowland.harvard.edu>
 <20230125194651.GN2948950@paulmck-ThinkPad-P17-Gen-1>
 <Y9GVFkVRRRs5/rBd@rowland.harvard.edu>
 <20230125213832.GQ2948950@paulmck-ThinkPad-P17-Gen-1>
 <20230125233308.GA1552266@paulmck-ThinkPad-P17-Gen-1>
 <Y9HbSBLrNJ9O2ad6@rowland.harvard.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y9HbSBLrNJ9O2ad6@rowland.harvard.edu>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 25, 2023 at 08:45:44PM -0500, Alan Stern wrote:
> On Wed, Jan 25, 2023 at 03:33:08PM -0800, Paul E. McKenney wrote:
> > Ah, and returning to the earlier question as to whether srcu_read_unlock()
> > can use release semantics instead of smp_mb(), at the very least, this
> > portion of the synchronize_srcu() function's header comment must change:
> > 
> > 	On systems with more than one CPU, when synchronize_srcu()
> > 	returns, each CPU is guaranteed to have executed a full
> > 	memory barrier since the end of its last corresponding SRCU
> > 	read-side critical section whose beginning preceded the call
> > 	to synchronize_srcu().
> 
> Yes, that would not be true.  But on the other hand, it would be true 
> that each CPU is guaranteed to have executed a release memory barrier 
> since the end of its last corresponding SRCU read-side critical section 
> whose beginning preceded the call to synchronize_srcu(), _and_ the CPU 
> executing synchronize_srcu() is guaranteed to have executed a full 
> memory barrier after seeing the values from all those release stores.
> This is not quite the same thing but it ought to be just as good.

Here is hoping!

> > I don't know of any SRCU code that relies on this, but it would be good to
> > check.	There used to (and might still) be RCU code relying on this, which
> > is why this sentence was added to the header comment in the first place.
> 
> If there is code relying on that guarantee, it ought to work just as 
> well by relying on the modified guarantee.

Again, here is hoping!

> Of course, there might be code relying on a guarantee that 
> srcu_read_unlock() executes a full memory barrier.  This guarantee would 
> certainly no longer hold.  But as I understand it, this guarantee was 
> never promised by the SRCU subsystem.

That indented sentence was copied from the synchronize_srcu() function's
header comment, which might be interpreted by some as a promise by the
SRCU subsystem.

							Thanx, Paul
