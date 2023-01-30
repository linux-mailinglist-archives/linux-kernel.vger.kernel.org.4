Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE35968051E
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 05:43:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233731AbjA3EnQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Jan 2023 23:43:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230335AbjA3EnN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jan 2023 23:43:13 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C45511EB8
        for <linux-kernel@vger.kernel.org>; Sun, 29 Jan 2023 20:43:08 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 48A9DB80E17
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 04:43:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1B34C433D2;
        Mon, 30 Jan 2023 04:43:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675053785;
        bh=Isk4xzUOSGKw95sCzKmiuuuOOBvJCDhjCDX/cZ3ljN8=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=WnAnQlCxGodcioFgzKwJ3BTqrXZsabFEcLV+se9zR8QCLMfyzoqXVm+ZGLIXMTddb
         1sDUlgS3BWXVljNdpl4nKfEot0tODLjZRNjFqZobZ2onqWx98Ss2jRTKYlFobfY/ni
         HFSzaqryxbMeNRfAyA6lZWMKsXnAv7NhRIml+Py0SzsHAA7RrSNxFS5VuJCvaCREqi
         1oXfd85j5V1vy1kv1xCL76u/O6kYJP7/IbypmSShJoicB2qQ5wZ9ugQkHs0Obs55rQ
         sKO5epHVVeYb+27JsApV0kgwbDBVubFALWE+vGgsVMfYhnJjt2XpWa1K7QBDHyuIGN
         lAo4ipq9nY/pg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 7CB735C089F; Sun, 29 Jan 2023 20:43:05 -0800 (PST)
Date:   Sun, 29 Jan 2023 20:43:05 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     Boqun Feng <boqun.feng@gmail.com>,
        Andrea Parri <parri.andrea@gmail.com>,
        Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>,
        will@kernel.org, peterz@infradead.org, npiggin@gmail.com,
        dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr,
        akiyks@gmail.com, dlustig@nvidia.com, joel@joelfernandes.org,
        urezki@gmail.com, quic_neeraju@quicinc.com, frederic@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] tools/memory-model: Make ppo a subrelation of po
Message-ID: <20230130044305.GO2948950@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <Y9WeOTmGCCfjMUtG@andrea>
 <Y9Wo6OttHC4sUxCS@rowland.harvard.edu>
 <20230129051734.GE2948950@paulmck-ThinkPad-P17-Gen-1>
 <Y9aY4hG3p+82vVIw@rowland.harvard.edu>
 <20230129162156.GG2948950@paulmck-ThinkPad-P17-Gen-1>
 <Y9asu0CswZZ3yyls@andrea>
 <20230129184403.GJ2948950@paulmck-ThinkPad-P17-Gen-1>
 <Y9bomciHJ/6WGYM0@boqun-archlinux>
 <20230129230900.GK2948950@paulmck-ThinkPad-P17-Gen-1>
 <Y9co8OxyRehs8mob@rowland.harvard.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y9co8OxyRehs8mob@rowland.harvard.edu>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 29, 2023 at 09:18:24PM -0500, Alan Stern wrote:
> On Sun, Jan 29, 2023 at 03:09:00PM -0800, Paul E. McKenney wrote:
> > On Sun, Jan 29, 2023 at 01:43:53PM -0800, Boqun Feng wrote:
> > > in lock.cat: 
> > > 
> > > 	(* Allow up to one unmatched LKW per location; more must deadlock *)
> > > 	let UNMATCHED-LKW = LKW \ domain(critical)
> > > 	empty ([UNMATCHED-LKW] ; loc ; [UNMATCHED-LKW]) \ id as unmatched-locks
> > > 
> > > we rule out deadlocks from the execution candidates we care about.
> > 
> > Thank you, Boqun!
> 
> Actually that's only part of it.  The other part is rather obscure:
> 
> (* Generate all co relations, including LKW events but not UL *)
> let co0 = co0 | ([IW] ; loc ; [LKW]) |
> 	(([LKW] ; loc ; [UNMATCHED-LKW]) \ [UNMATCHED-LKW])
> 
> Implicitly this says that any lock with no corresponding unlock must 
> come last in the coherence order, which implies the unmatched-locks rule 
> (since only one lock event can be last).  By itself, the unmatched-locks 
> rule would not prevent P3 from executing before P1, provided P1 executes 
> both its lock and unlock.

And thank you, Alan, as well!

And RCU looks to operate in a similar manner:

------------------------------------------------------------------------

C rcudeadlock

{
}


P0(int *a, int *b)
{
	rcu_read_lock();
	WRITE_ONCE(*a, 1);
	synchronize_rcu();
	WRITE_ONCE(*b, 1);
	rcu_read_unlock();
}

P1(int *a, int *b)
{
	int r1;
	int r2;

	r1 = READ_ONCE(*b);
	smp_mb();
	r2 = READ_ONCE(*a);
}

exists (1:r1=1 /\ 1:r2=0)

------------------------------------------------------------------------

$ herd7 -conf linux-kernel.cfg rcudeadlock.litmus 
Test rcudeadlock Allowed
States 0
No
Witnesses
Positive: 0 Negative: 0
Condition exists (1:r1=1 /\ 1:r2=0)
Observation rcudeadlock Never 0 0
Time rcudeadlock 0.00
Hash=4f7f336ad39d724d93b089133b00d1e2

------------------------------------------------------------------------

So good enough!  ;-)

							Thanx, Paul
