Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93A0D675FB0
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 22:37:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229511AbjATVhe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 16:37:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjATVhd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 16:37:33 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFCA543914
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 13:37:31 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id DE4A6CE2AB6
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 21:37:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE4F5C433EF;
        Fri, 20 Jan 2023 21:37:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674250648;
        bh=0DBSmP2vyNqu+oxytuTdeFsmN6xFvQcBg4PiuLnSEd8=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=IHDxRfuiZw/KNe5MEbpxwpw6kn57dkRVF0ZUgDRCs0kY7g5JaAy+dRMAI+J81c2BV
         bZHhoyvMERS68GIfJhuwzCGsiMSlg+KYzaG4/bF5HQzEPfSQa/QJlib7dlBKQyv5nv
         CJ7tq+BQW9C1sxogRGx2pgBUrlSboX6NJTuMzT1SzsbjhiZXyG1CVnUjZmrn7lOs1X
         x9RF1zEHOn+DFbo8lEkyT+HagjghNoURc61L1+zmnTMITMeIVc++kuh39JnJvFuqXD
         v3XKNladg7l4osnvH1y+rICs+ZhSqpg9gSca0HgrMbyZGxOhmxzXQD2jU4oa8Q+TtH
         ghvFP9YbMYIBg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 81DF15C08A4; Fri, 20 Jan 2023 13:37:27 -0800 (PST)
Date:   Fri, 20 Jan 2023 13:37:27 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>
Cc:     Alan Stern <stern@rowland.harvard.edu>,
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
Message-ID: <20230120213727.GX2948950@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20230118211201.GL2948950@paulmck-ThinkPad-P17-Gen-1>
 <09f084d2-6128-7f83-b2a5-cbe236b1678d@huaweicloud.com>
 <20230119001147.GN2948950@paulmck-ThinkPad-P17-Gen-1>
 <0fae983b-2a7c-d44e-8881-53d5cc053f09@huaweicloud.com>
 <20230119184107.GT2948950@paulmck-ThinkPad-P17-Gen-1>
 <Y8mfWTX7V69pAwo8@rowland.harvard.edu>
 <20230119215304.GA2948950@paulmck-ThinkPad-P17-Gen-1>
 <c5902c18-e0cc-125e-c2f5-7971f0a7ce07@huaweicloud.com>
 <20230120153909.GF2948950@paulmck-ThinkPad-P17-Gen-1>
 <cc3686b3-b234-b0ee-4d2d-15f54da4331b@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cc3686b3-b234-b0ee-4d2d-15f54da4331b@huaweicloud.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 20, 2023 at 09:46:55PM +0100, Jonas Oberhauser wrote:
> 
> 
> On 1/20/2023 4:39 PM, Paul E. McKenney wrote:
> > On Fri, Jan 20, 2023 at 10:43:10AM +0100, Jonas Oberhauser wrote:
> > 
> > > I don't think Boqun's patch is hard to repair.
> > > Besides the issue you mention, I think it's also missing Sync-srcu, which
> > > seems to be linked by loc based on its first argument.
> > > 
> > > How about something like this?
> > > 
> > > let ALL-LOCKS = LKR | LKW | UL | LF | RU | Srcu-lock | Srcu-unlock |
> > > Sync-srcu   flag ~empty ~[ALL_LOCKS | IW] ; loc ; [ALL-LOCKS] as
> > > mixed-lock-accesses
> > > 
> > > If you're using something that isn't a lock or intial write on the same location as a lock, you get the flag.
> > Wouldn't that unconditionally complain about the first srcu_read_lock()
> > in a given process?  Or am I misreading those statements?
> > 							
> 
> I unfolded the definition step by step and it seems I was careless when
> distributing the ~ over the [] operator.
> I should have written:
> 
> flag ~empty [~(ALL_LOCKS | IW)] ; loc ; [ALL-LOCKS] as mixed-lock-accesses
> 
> but somehow I thought I can save the parentheses by putting the ~ on the
> outside.
> Now on the off-chance that this is kind of how you already read the
> relation, let me unfold it step-by-step.
> 
> Let's assume that the sequence s of operations on this location is
>   s = initial write , (perhaps some gps) , first read lock , read
> lock&unlock&gp ...
> then the flag would appear if the specified relation isn't empty. That would
> be the case if there are a and b that are linked by
> 
>   a ->[~(ALL_LOCKS | IW)] ; loc ; [ALL-LOCKS] b
> 
> This means a is neither in ALL_LOCKS nor in IW, while b is ALL-LOCKS; and furthermore, they are equal to a' and b' resp. that are related by loc, i.e., appear in this sequence s. Thus both a and b are actually appearing both in the sequence s.
> However, every event in the sequence s is either in ALL_LOCKS or in IW, which contradicts the assumption that a is in the sequence and in neither of the sets. Because of this contradiction, the flag doesn't appear if the sequence looks like this.
> 
> More generally, if every event in the sequence is either the initial write or one of (srcu-) lock,unlock,up,down,sync, there won't be a flag.
> 
> In contrast, if the sequence has the form
>  s' = initial write, (normal srcu events), some other acces x, (normal srcu events)
> and y is one of the srcu events in this sequence, then
>  x ->[~(ALL_LOCKS | IW)] ; loc ; [ALL_LOCKS] y
> and you get a flag.

Thank you!  When I get done messing with NMIs, I will give this a go.

Just out of curiosity, are you sent up to run LKMM locally at your end?

							Thanx, Paul
