Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5B9B633267
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 02:52:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231368AbiKVBwM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 20:52:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231978AbiKVBwH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 20:52:07 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7028E2225;
        Mon, 21 Nov 2022 17:52:05 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 71A1CB8190A;
        Tue, 22 Nov 2022 01:52:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C694C43470;
        Tue, 22 Nov 2022 01:52:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669081923;
        bh=DJGYx9EZbvMPd63erzhkQ7/znuplLOsu/ELX137ez+Y=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=GxfIIkFMJTOmXEhvkEfsEIMmPjQAWiuj+OVeiY8Q5+6bovw5ogHhjKmcrNa07pWKI
         yTUh61QcjHNoJYy0+mNww3Wu6QFjFi6rdNEcwRVdnAu942cP5GGNLdM0sdpJxoODqi
         rVtgZUjg/E3RRYzCW9vy004gOpAbEkday5ZOxMuHUCg14LlfB3yl77b+rIFeuWji4Z
         fCjBC4cdsewtrEOajhkNiSagGi7ZQKYaVfQvMWgJeMi98fIv77cFp6qRy/odBvQIQD
         WJUpGLxtu0x8YVjaCx7AQB1OKAleD98xRW1CGVRL8wQL+VarrdIlhBMv9G3nAyqdKn
         Um/eWpDZVQelw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id D497E5C0641; Mon, 21 Nov 2022 17:52:02 -0800 (PST)
Date:   Mon, 21 Nov 2022 17:52:02 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Tejun Heo <tj@kernel.org>
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@meta.com, rostedt@goodmis.org,
        Uladzislau Rezki <urezki@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>
Subject: Re: [PATCH v2 rcu 13/16] workqueue: Make queue_rcu_work() use
 call_rcu_flush()
Message-ID: <20221122015202.GC4001@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20221122010408.GA3799268@paulmck-ThinkPad-P17-Gen-1>
 <20221122010421.3799681-13-paulmck@kernel.org>
 <Y3whScgTs0FgrVtY@slm.duckdns.org>
 <20221122012357.GV4001@paulmck-ThinkPad-P17-Gen-1>
 <Y3wn9AK1XxEZIIFw@slm.duckdns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y3wn9AK1XxEZIIFw@slm.duckdns.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 21, 2022 at 03:37:56PM -1000, Tejun Heo wrote:
> On Mon, Nov 21, 2022 at 05:23:57PM -0800, Paul E. McKenney wrote:
> > On Mon, Nov 21, 2022 at 03:09:29PM -1000, Tejun Heo wrote:
> > > On Mon, Nov 21, 2022 at 05:04:18PM -0800, Paul E. McKenney wrote:
> > > > And another call_rcu() instance that cannot be lazy is the one
> > > > in queue_rcu_work(), given that callers to queue_rcu_work() are
> > > > not necessarily OK with long delays.
> > > 
> > > So, this is fine but another thing we can do is propagating the distinction
> > > through the workqueue interface so that the the choice can be made by
> > > workqueue users. Would that make sense?
> > 
> > It might well!  My thought was to wait to suggest that until we found a
> > real-life case where this was needed, but I have no objection to being
> > proactive here.
> 
> Oh yeah, I'm completely fine either way too.
> 
> > But the hard part...  Thought for a good name?  ;-)
> 
> If we go with a separate interface, yeah, _flush would be confusing for
> workqueue. Maybe _quick or _hurry? Hmm... it'd be nice to keep the suffix
> consistent with RCU. What's the relationship with
> synchronize_rcu_expedited()? Would using _expedited be confusing?

I expect that _expedited() would be because this has nothing whatever
to do with expedited grace periods.

Maybe we should have used call_rcu_hurry()?

What is in a name?  ;-)

							Thanx, Paul
