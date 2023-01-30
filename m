Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 998B5680527
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 05:46:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235502AbjA3EqN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Jan 2023 23:46:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232883AbjA3EqK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jan 2023 23:46:10 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DEC51F5C3
        for <linux-kernel@vger.kernel.org>; Sun, 29 Jan 2023 20:46:09 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B600560EC5
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 04:46:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16EEDC433D2;
        Mon, 30 Jan 2023 04:46:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675053968;
        bh=NGrl8WA9e6ZS2gic40qKN6qyWVwQZUSTRKLR+5l4xtU=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=uAQ4mfGYVZVl/xaPyU5OmnHuZQHL4XbcASuvdFAx1aKzXpmia4HFVzPbzcKWn6rVb
         yK3fcSmJD5igrcgE04gnmP62bhfvpNv2pRnXy4Sy7zbGKC8n7XQVEF7XLvzg+Dq4h4
         aJZfTa6k/7IDWCZzF+aDE/pXRNb15SOnOmU0uLVdZ/ARpL9o1uAzdnA5LPnMnFX2O+
         jEL4ZeV/IMXySJbOtJg3tprtuN3akHJaAHEufxdDsim+OuY3IILUsMNwDjlZK/Vilw
         rKVRDUJyfWIEHE/3DynDqH7jh/Y2/5U+T+zAKKBDnXO0xEnhSgHMkkUqadg7XwFdhY
         +E+MfaJDDSFgQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id A0B1D5C089F; Sun, 29 Jan 2023 20:46:07 -0800 (PST)
Date:   Sun, 29 Jan 2023 20:46:07 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>
Cc:     Alan Stern <stern@rowland.harvard.edu>,
        Andrea Parri <parri.andrea@gmail.com>, will@kernel.org,
        peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com,
        dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr,
        akiyks@gmail.com, dlustig@nvidia.com, joel@joelfernandes.org,
        urezki@gmail.com, quic_neeraju@quicinc.com, frederic@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] tools/memory-model: Make ppo a subrelation of po
Message-ID: <20230130044607.GP2948950@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20230126134604.2160-1-jonas.oberhauser@huaweicloud.com>
 <20230126134604.2160-3-jonas.oberhauser@huaweicloud.com>
 <Y9Kr+GntQyGKPH3K@rowland.harvard.edu>
 <47acbaa7-8280-48f2-678f-53762cf3fe9d@huaweicloud.com>
 <Y9V+CyKIjg8sgVAC@rowland.harvard.edu>
 <Y9WeOTmGCCfjMUtG@andrea>
 <Y9Wo6OttHC4sUxCS@rowland.harvard.edu>
 <0da94668-c041-1d59-a46d-bd13562e385e@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0da94668-c041-1d59-a46d-bd13562e385e@huaweicloud.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 29, 2023 at 11:19:32PM +0100, Jonas Oberhauser wrote:
> 
> Hi all, apologies on the confusion about the litmus test.
> I should have explained it better but it seems you mostly figured it out.
> As Alan said I'm tricking a little bit by not unlocking in certain places to
> filter out all executions that aren't what I'm looking for.
> I didn't have much time when I sent it (hence also the lack of explanation
> and why I haven't responded earlier), so I didn't have time to play around
> with the filter feature to do this the "proper"/non-cute way.
> As such it really isn't about deadlocks.

Not a problem!

> I think one question is whether the distinction between the models could be
> reproduced without using any kind of filtering at all.
> I have a feeling it should be possible but I haven't had time to think up a
> litmus test that does that.

Here is an example litmus test using filter, if this helps.

You put it right before the "exists" clause, and the condition is the
same as in the "exists" clause.  If an execution does not satisfy the
condition in the filter clause, it is tossed.

							Thanx, Paul

------------------------------------------------------------------------

C C-srcu-nest-6

(*
 * Result: Never
 *
 * This would be valid for srcu_down_read() and srcu_up_read().
 *)

{}

P0(int *x, int *y, struct srcu_struct *s1, int *idx, int *f)
{
	int r2;
	int r3;

	r3 = srcu_down_read(s1);
	WRITE_ONCE(*idx, r3);
	r2 = READ_ONCE(*y);
	smp_store_release(f, 1);
}

P1(int *x, int *y, struct srcu_struct *s1, int *idx, int *f)
{
	int r1;
	int r3;
	int r4;

	r4 = smp_load_acquire(f);
	r1 = READ_ONCE(*x);
	r3 = READ_ONCE(*idx);
	srcu_up_read(s1, r3);
}

P2(int *x, int *y, struct srcu_struct *s1)
{
	WRITE_ONCE(*y, 1);
	synchronize_srcu(s1);
	WRITE_ONCE(*x, 1);
}

locations [0:r1]
filter (1:r4=1)
exists (1:r1=1 /\ 0:r2=0)
