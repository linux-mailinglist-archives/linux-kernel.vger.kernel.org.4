Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5329674129
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 19:43:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230310AbjASSnn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 13:43:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229630AbjASSnl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 13:43:41 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAA365244
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 10:43:39 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7515261D12
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 18:43:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D26B7C433D2;
        Thu, 19 Jan 2023 18:43:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674153818;
        bh=r9BPSDUS8mqlBvmsXRq+sQLqmfkEfzZt7oZC+21HoEg=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=XxSltk754tzpSmRlyAm/oOqUhiYnkvsxw5YKmKwrmj+eKQifuVk2ZSlR4VqICVP4U
         IHbx5jqa/kObv/HXPPVIlmGcEiPiP0sNO0xFKOFANlS/bbWyZWnTf/57C0rizFRHzJ
         Rh0IL3eiGbCKEDiBiVGZYu3bh37jZOqamhKFDTpKZPT9XelMkeHoUICxqwK33QEQtW
         g6PM5lqzfTvJGdKN6G6DCS4+URTwi+2t9Fk5sfYuEJbdAnj48vzQQPpoKQPsaaaHix
         60zXLl8t9rMW/xsHz7uLgPtGeuT8mJH1I9c4CE1+GOpVj+kcAo63jMMQZWmjfszf+f
         5n4ujQruUfb+Q==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 801985C1A49; Thu, 19 Jan 2023 10:43:38 -0800 (PST)
Date:   Thu, 19 Jan 2023 10:43:38 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     Jonas Oberhauser <jonas.oberhauser@huawei.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "parri.andrea" <parri.andrea@gmail.com>, will <will@kernel.org>,
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
Message-ID: <20230119184338.GU2948950@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20220921173109.GA1214281@paulmck-ThinkPad-P17-Gen-1>
 <YytfFiMT2Xsdwowf@rowland.harvard.edu>
 <YywXuzZ/922LHfjI@hirez.programming.kicks-ass.net>
 <114ECED5-FED1-4361-94F7-8D9BC02449B7>
 <Y8iqzJXVZX1lS7Kp@rowland.harvard.edu>
 <a2b89243-ddd7-c114-541f-0aff7806d217@huaweicloud.com>
 <Y8lynRI35cFeuqb5@rowland.harvard.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y8lynRI35cFeuqb5@rowland.harvard.edu>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 19, 2023 at 11:41:01AM -0500, Alan Stern wrote:
> On Thu, Jan 19, 2023 at 12:22:50PM +0100, Jonas Oberhauser wrote:
> > 
> > 
> > On 1/19/2023 3:28 AM, Alan Stern wrote:
> > > > This is a permanent error; I've given up. Sorry it didn't
> > > work out.
> > 
> > [It seems the e-mail still reached me through the mailing list]
> 
> [For everyone else, Jonas is referring to the fact that the last two 
> emails I sent to his huaweicloud.com address could not be delivered, so 
> I copied them off-list to his huawei.com address.]
> 
> > > > I consider that a hack though and don't like it.
> > > It _is_ a bit of a hack, but not a huge one.  srcu_read_lock() really
> > > is a lot like a load, in that it returns a value obtained by reading
> > > something from memory (along with some other operations, though, so it
> > > isn't a simple straightforward read -- perhaps more like an
> > > atomic_inc_return_relaxed).
> > The issue I have with this is that it might create accidental ordering. How
> > does it behave when you throw fences in the mix?
> 
> I think this isn't going to be a problem.  Certainly any real 
> implementation of scru_read_lock() is going to involve some actual load 
> operations, so any unintentional ordering caused by fences will also 
> apply to real executions.  Likewise for srcu_read_unlock and store 
> operations.
> 
> > It really does not work like an increment at all, I think srcu_read_lock()
> > only reads the currently active index, but the index is changed by
> > srcu_sync. But even that is an implementation detail of sorts. I think the
> > best way to think of it would be for srcu_read_lock to just return an
> > arbitrary value.
> 
> I think I'll stick to it always returning the initial value.  Paul said 
> that would be okay.

Just confirming.

> > The user can not rely on any kind of "accidental" rfe edges between these
> > events for ordering.
> > 
> > Perhaps if you flag any use of these values in address or control
> > dependencies, as well as any event which depends on more than one of these
> > values, you could prove that it's impossible to contrain the behavior
> > through these rfe(and/or co) edges because you can anyways never inspect the
> > value returned by the operation (except to pass it into srcu_unlock).
> > 
> > Or you might be able to explicitly eliminate the events everywhere, just
> > like you have done for carry-dep in your patch.
> 
> On second thought, I'll make it impossible to read from the 
> srcu_read_unlock events by removing them from the rf (and rfi/rfe) 
> relation.  Then it won't be necessary to change carry-dep or anything 
> else.

Although that works very well for srcu_read_lock() and srcu_read_unlock(),
it would be an issue for srcu_down_read() and srcu_up_read().  But one
thing at a time!  ;-)

							Thanx, Paul
