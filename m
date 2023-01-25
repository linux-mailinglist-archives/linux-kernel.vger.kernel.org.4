Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCEF967B882
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 18:28:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235594AbjAYR1z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 12:27:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235483AbjAYR1x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 12:27:53 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FA9935AB
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 09:27:52 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D1A0F6159E
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 17:27:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34310C433EF;
        Wed, 25 Jan 2023 17:27:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674667671;
        bh=X24O50MJPUisyFOFQtTGCX/DnZX/g6rd3OU490ntEI4=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=oBa/Cd8yrDu7NOJUhHYv9tHNN92fYmTdcciDIWGSx01QYZpXkbEK3SvibpTEg/uR2
         WDAqP/7+cXw7GJqc1zIt2OqkEx7lyxnFwWi76D6MyxdHI06P5GQr3IyqDTV8GSTcwj
         QvC5i5GSQX+ybtpnpX39UffbMY7bGjAl4sd/XyeO0xYTuH9/gckblbakzLSwSKjDyX
         d9NTc9TBdD8t/1qCvy2gIxWuuyW3NFOixNpgcIrh/Ojjg62nuPh4leoOnKzfA6vyQ4
         GP2Q7XXTh+usHfXtqGHIRIXPN9+l8fdR57OWuCtR46rkkEHpcE+9Bf+NC+3AtFgaKI
         mRUaoDX809kCw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id C8E235C03B9; Wed, 25 Jan 2023 09:27:50 -0800 (PST)
Date:   Wed, 25 Jan 2023 09:27:50 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>
Cc:     Alan Stern <stern@rowland.harvard.edu>, parri.andrea@gmail.com,
        will@kernel.org, peterz@infradead.org, boqun.feng@gmail.com,
        npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk,
        luc.maranget@inria.fr, akiyks@gmail.com, dlustig@nvidia.com,
        joel@joelfernandes.org, urezki@gmail.com, quic_neeraju@quicinc.com,
        frederic@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tools/memory-model Flag suspicious use of srcu cookies
Message-ID: <20230125172750.GA1522225@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20230124143951.23372-1-jonas.oberhauser@huaweicloud.com>
 <Y9ATHMm/iVG8goln@rowland.harvard.edu>
 <20230124191535.GT2948950@paulmck-ThinkPad-P17-Gen-1>
 <87b8e8ba-a53d-c3e5-1478-9e6cc2b78fee@huaweicloud.com>
 <20230124221915.GW2948950@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230124221915.GW2948950@paulmck-ThinkPad-P17-Gen-1>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 24, 2023 at 02:19:15PM -0800, Paul E. McKenney wrote:
> On Tue, Jan 24, 2023 at 08:36:53PM +0100, Jonas Oberhauser wrote:
> > 
> > 
> > On 1/24/2023 8:15 PM, Paul E. McKenney wrote:
> > > On Tue, Jan 24, 2023 at 12:19:24PM -0500, Alan Stern wrote:
> > > > On Tue, Jan 24, 2023 at 03:39:51PM +0100, Jonas Oberhauser wrote:
> > > > > The herd model of LKMM deviates from actual implementations in the
> > > > > range of cookies that might be returned by srcu_lock() and similar
> > > > > functions.  As a consequence, code that relies on srcu_lock()
> > > > > returning specific values might pass on the herd model but fail in
> > > > > the real world.
> > > > > 
> > > > > This patch flags any code that looks at the value of a cookie
> > > > > without passing it on to an srcu_unlock().  This indicates that the
> > > > > cookie value might be being used in ways that can lead herd to
> > > > > produce incorrect results, as in the following (contrived) case:
> > > > > 
> > > > > P0(struct srcu_struct *ss)
> > > > > {
> > > > > 	int r = srcu_read_lock(ss);
> > > > > 	if (r==0)
> > > > > 		srcu_read_unlock(ss, r);
> > > > > }
> > > > > 
> > > > > Without this patch, the code passes herd7 without any warnings.
> > > > > 
> > > > > With this patch, this code is flagged with illegal-srcu-cookie-ctrl,
> > > > > indicating that a cookie is used to compute a control condition.
> > > > > Such scenarios potentially lead to other branches of the code that
> > > > > are possible in real usage not being evaluated by herd7.  In this
> > > > > example, this affects the branch where r!=0, which would lead to
> > > > > an unmatched read side critical section and thus to hangs of
> > > > > synchronize_srcu() calls.
> > > > > 
> > > > > Besides use of cookies in control conditions, the patch also flags
> > > > > use in address computation and any time a cookie is inspected but
> > > > > not later passed to srcu_read_unlock().
> > > > > 
> > > > > Signed-off-by: Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>
> > > > > ---
> > > > Acked-by: Alan Stern <stern@rowland.harvard.edu>
> > > Thank you both!
> > > 
> > > I wordsmithed the commit log as follows, but then realized that this
> > > depends on Alan's earlier patch.
> > 
> > Yeah, I don't know if I did this correctly. I based it on the
> > lkmm-srcu.2023.01.20a branch.
> > Let me know if I should have done this differently.
> 
> You got it right.
> 
> > Looking through your changes to learn for future submissions:
> > 
> > > [...]
> > > 
> > > This patch flags any code that looks at the value of a cookie
> > > without passing it on to an srcu_unlock().
> > 
> > You missed this one : )
> 
> No I didn't!  I missed *two*!  ;-)
> 
> Though that comment could be Srcu-unlock, I suppose.  But making it
> srcu_read_unlock() seems more straightforward.  Update below!

And I also added this to the lkmm-srcu.2023.01.20a branch just for
experimental purposes.

							Thanx, Paul
