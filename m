Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 075ED6A5C28
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 16:40:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230113AbjB1Pkl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 10:40:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229792AbjB1Pki (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 10:40:38 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2554029E33
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 07:40:33 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8AF6CB80E6C
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 15:40:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27D11C433EF;
        Tue, 28 Feb 2023 15:40:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677598831;
        bh=VxCn3XWriHTW8YjvIK4DPsYbOK48hiwgEOBiGZ3LUI8=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=h6d4zLvOKREpFeVevff8Fh7nfZ5TAmbT+eAJqCEyiRgDZ7UGl+DelWcncZJW5zJeC
         jUxeNJYZX/c1TkU4MweG0XHjRACLTaPbfyt6IRZhFACWqWd9idAbmm/vP0BDouw3vI
         7pST4w6YWCJ44EuqZY/XP0ZT2BNXcQTeBxA8R4LSTNevB7f/t9KCaF033Z9UoXXc9f
         Gk28cwypEtKmrMS7LxChjldOhwfVLIrqtTaj5a6Kq3o4hevXOKpkFmfE0AwVWgG46d
         xnQFZSuxTIPLcE2BEhAvehNrynZrTxmxNAo1Xu79xdxxIF5l2psGG+1en03CGrM8zY
         C9AQfiR7DC/Kg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id BD1205C0368; Tue, 28 Feb 2023 07:40:30 -0800 (PST)
Date:   Tue, 28 Feb 2023 07:40:30 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>
Cc:     Andrea Parri <parri.andrea@gmail.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Jonas Oberhauser <jonas.oberhauser@huawei.com>,
        will@kernel.org, peterz@infradead.org, boqun.feng@gmail.com,
        npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk,
        luc.maranget@inria.fr, akiyks@gmail.com, dlustig@nvidia.com,
        joel@joelfernandes.org, urezki@gmail.com, quic_neeraju@quicinc.com,
        frederic@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] tools/memory-model: Make ppo a subrelation of po
Message-ID: <20230228154030.GT2948950@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20230224135251.24989-1-jonas.oberhauser@huaweicloud.com>
 <Y/jYm0AZfPHkIalK@rowland.harvard.edu>
 <20230224183758.GQ2948950@paulmck-ThinkPad-P17-Gen-1>
 <20230226010110.GA1576556@paulmck-ThinkPad-P17-Gen-1>
 <Y/rEH2r9i0BtfxEW@rowland.harvard.edu>
 <Y/0HEESX2wDWtPS1@andrea>
 <bf2881fb-039b-06ab-68f9-806b29a84188@huaweicloud.com>
 <20230227222120.GI2948950@paulmck-ThinkPad-P17-Gen-1>
 <9b5a04e9-39e7-ffa1-b43e-831a4f0c4b73@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9b5a04e9-39e7-ffa1-b43e-831a4f0c4b73@huaweicloud.com>
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,URIBL_SBL_A autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 28, 2023 at 09:49:07AM +0100, Jonas Oberhauser wrote:
> 
> 
> On 2/27/2023 11:21 PM, Paul E. McKenney wrote:
> > On Mon, Feb 27, 2023 at 09:13:01PM +0100, Jonas Oberhauser wrote:
> > > 
> > > On 2/27/2023 8:40 PM, Andrea Parri wrote:
> > > > > The LKMM doesn't believe that a control or data dependency orders a
> > > > > plain write after a marked read.  Hence in this test it thinks that P1's
> > > > > store to u0 can happen before the load of x1.  I don't remember why we
> > > > > did it this way -- probably we just wanted to minimize the restrictions
> > > > > on when plain accesses can execute.  (I do remember the reason for
> > > > > making address dependencies induce order; it was so RCU would work.)
> > > > > 
> > > > > The patch below will change what the LKMM believes.  It eliminates the
> > > > > positive outcome of the litmus test and the data race.  Should it be
> > > > > adopted into the memory model?
> > > > (Unpopular opinion I know,) it should drop dependencies ordering, not
> > > > add/promote it.
> > > > 
> > > >     Andrea
> > > Maybe not as unpopular as you think... :)
> > > But either way IMHO it should be consistent; either take all the
> > > dependencies that are true and add them, or drop them all.
> > > In the latter case, RCU should change to an acquire barrier. (also, one
> > > would have to deal with OOTA in some yet different way).
> > > 
> > > Generally my position is that unless there's a real-world benchmark with
> > > proven performance benefits of relying on dependency ordering, one should
> > > use an acquire barrier. I haven't yet met such a case, but maybe one of you
> > > has...
> > https://www.msully.net/thesis/thesis.pdf page 128 (PDF page 141).
> > 
> > Though this is admittedly for ARMv7 and PowerPC.
> > 
> 
> Thanks for the link.
> 
> It's true that on architectures that don't have an acquire load (and have to
> use a fence), the penalty will be bigger.
> 
> But the more obvious discussion would be what constitutes a real-world
> benchmark : )
> In my experience you can get a lot of performance benefits out of optimizing
> barriers in code if all you execute is that code.
> But once you embed that into a real-world application, often 90%-99% of time
> spent will be in the business logic, not in the data structure.
> 
> And then the benefits suddenly disappear.
> Note that a lot of barriers are a lot cheaper as well when there's no
> contention.
> 
> Because of that, making optimization decisions based on microbenchmarks can
> sometimes lead to a very poor "time invested" vs "total product improvement"
> ratio.

All true, though that 2x and 4x should be worth something.

The real-world examples I know of involved garbage collectors, and the
improvement was said to be a few percent system-wide.  But that was a
verbal exchange, so I don't have a citation for you.

							Thanx, Paul
