Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 390386763D4
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Jan 2023 05:38:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229566AbjAUEiw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 23:38:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbjAUEiu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 23:38:50 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4EA366EE2
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 20:38:48 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4047AB82AC2
        for <linux-kernel@vger.kernel.org>; Sat, 21 Jan 2023 04:38:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF2DDC433D2;
        Sat, 21 Jan 2023 04:38:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674275925;
        bh=EvKMLKhjfXncGTfr32q/jztf1GxsasxWfaXH+OAMr8s=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=Hqio0JiOc4+sEEmXffY5sSLXNr0cdPUCuSqBOEG5QvAligUFoWwiXgiRevRakSLXf
         8UTQ9aAUMT9/44VYP0svvyALES5rhoHwy84OjIYEA+ZoZqPVVOM8OglwKUmQNJrw3d
         gKhP/HjsouE+LgbEuhzGRBvm/iuYmFgs6OURrhmnAlgvlt7vUjxtpl2204PL5CNvka
         8tQPkxzOR9QmKBaPWJq5Uyyijb1Ai5/36nr9smc9M0S5rFgLpWos5LitztAuA0PKm4
         dfXensQRVHdZtHdNLeIZSeUQd/nC3+aCXbtT8y/opwG4qy3o0QGwf0Ez44rue1caYs
         Lxoj8pgTMJJIQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 6FC045C155D; Fri, 20 Jan 2023 20:38:45 -0800 (PST)
Date:   Fri, 20 Jan 2023 20:38:45 -0800
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
Message-ID: <20230121043845.GE2948950@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20230118201918.GI2948950@paulmck-ThinkPad-P17-Gen-1>
 <a5637181-1675-7973-489c-e5d24cbd25c2@huaweicloud.com>
 <20230118211201.GL2948950@paulmck-ThinkPad-P17-Gen-1>
 <09f084d2-6128-7f83-b2a5-cbe236b1678d@huaweicloud.com>
 <20230119001147.GN2948950@paulmck-ThinkPad-P17-Gen-1>
 <0fae983b-2a7c-d44e-8881-53d5cc053f09@huaweicloud.com>
 <20230119184107.GT2948950@paulmck-ThinkPad-P17-Gen-1>
 <64b48a7b-624c-26bd-be9b-0522fc490b28@huaweicloud.com>
 <Y8q+u09ynxnvjVi5@rowland.harvard.edu>
 <ea37d3d9-4ed3-872a-aed9-f34c4553f6f1@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ea37d3d9-4ed3-872a-aed9-f34c4553f6f1@huaweicloud.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 20, 2023 at 10:41:14PM +0100, Jonas Oberhauser wrote:
> 
> 
> On 1/20/2023 5:18 PM, Alan Stern wrote:
> > On Fri, Jan 20, 2023 at 11:13:00AM +0100, Jonas Oberhauser wrote:
> > > Perhaps we could say that reading an index without using it later is
> > > forbidden?
> > > 
> > > flag ~empty [Srcu-lock];data;rf;[~ domain(data;[Srcu-unlock])] as
> > > thrown-srcu-cookie-on-floor
> > We already flag locks that don't have a matching unlock.
> 
> Of course, but as you know this is completely orthogonal.
> 
> > I don't see any point in worrying about whatever else happens to the index.
> 
> Can you briefly explain how the operational model you have in mind for
> srcu's up and down allows x==1 (and y==0 and idx1==idx2) in the example I
> sent before (copied with minor edit below for convenience)?
> 
> P0{
>     idx1 = srcu_down(&ss);
>     store_rel(p1, true);
> 
> 
>     shared cs
> 
>     R x == 1
> 
>     while (! load_acq(p2));
>     R idx2 == idx1 // for some reason, we got lucky!
>     srcu_up(&ss,idx1);
> }
> 
> P1{
>     idx2 = srcu_down(&ss);
>     store_rel(p2, true);
> 
>     shared cs
> 
>     R y == 0
> 
>     while (! load_acq(p1));
>     srcu_up(&ss,idx2);
> }
> 
> P2 {
>     W y = 1
>     srcu_sync(&ss);
>     W x = 1
> }
> 
> 
> I can imagine models that allow this but they aren't pretty. Maybe you have
> a better operational model?
> 
> > 
> > > So if there is an srcu_down() that produces a cookie that is read by some
> > > read R, and R doesn't then pass that value into an srcu_up(), the
> > > srcu-warranty is voided.
> > No, it isn't.
> I quote Paul:
> "If you do anything else at all with it, anything at all, you just voided
> your SRCU warranty. For that matter, if you just throw that value on the
> floor and don't pass it to an srcu_up_read() execution, you also just voided
> your SRCU warranty."

I suspect that you guys are talking past one another.  My guess is that
one of you is saying "we could check" and the other "we are not required
to check", which are not necessarily in disagreement.

But that is just a guess.  You guys tell me!  ;-)

							Thanx, Paul
