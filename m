Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 135FF6800DB
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Jan 2023 19:44:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235257AbjA2SoH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Jan 2023 13:44:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229605AbjA2SoF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jan 2023 13:44:05 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A7781E1E9
        for <linux-kernel@vger.kernel.org>; Sun, 29 Jan 2023 10:44:04 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3EB9460DED
        for <linux-kernel@vger.kernel.org>; Sun, 29 Jan 2023 18:44:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 908A2C433EF;
        Sun, 29 Jan 2023 18:44:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675017843;
        bh=SwxcVcFFqesS0Bq+035ob0IRTXSQDqwLkncyTXP7jcI=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=n1xo8zl1JG3hEQ75OAwN8dIWAUQDXuztRC8Ng/t9gD4koX/64M/5KrlxRQAbODnOa
         DhK42aO7jhVfmMZmCj8YPv6Hm/GUWCNQDOirfL+Jg+TwSpC8SlMvkfzUzl+r+XGw+m
         0+W8mgwg8IqiIe7I4fjtQ4fuFRW+TxxR4XWU4Jnk9W7v5MwSQ7y9qU4FsoDT8j7IuE
         dTVMfAhUmFxPoDzCbaqwWWNkgw3IrhHn+nF1HQOyXJhz2BgvZEfshDkCCgfNwsA317
         P+5Ip8ea1SSw3PWWK7WYvJgb61L6hQtZekAUJ7H491RVMgrFptyCXhZE9zpzZiql20
         4q28jLAR+ODlg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 2815D5C08B3; Sun, 29 Jan 2023 10:44:03 -0800 (PST)
Date:   Sun, 29 Jan 2023 10:44:03 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Andrea Parri <parri.andrea@gmail.com>
Cc:     Alan Stern <stern@rowland.harvard.edu>,
        Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>,
        will@kernel.org, peterz@infradead.org, boqun.feng@gmail.com,
        npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk,
        luc.maranget@inria.fr, akiyks@gmail.com, dlustig@nvidia.com,
        joel@joelfernandes.org, urezki@gmail.com, quic_neeraju@quicinc.com,
        frederic@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] tools/memory-model: Make ppo a subrelation of po
Message-ID: <20230129184403.GJ2948950@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20230126134604.2160-3-jonas.oberhauser@huaweicloud.com>
 <Y9Kr+GntQyGKPH3K@rowland.harvard.edu>
 <47acbaa7-8280-48f2-678f-53762cf3fe9d@huaweicloud.com>
 <Y9V+CyKIjg8sgVAC@rowland.harvard.edu>
 <Y9WeOTmGCCfjMUtG@andrea>
 <Y9Wo6OttHC4sUxCS@rowland.harvard.edu>
 <20230129051734.GE2948950@paulmck-ThinkPad-P17-Gen-1>
 <Y9aY4hG3p+82vVIw@rowland.harvard.edu>
 <20230129162156.GG2948950@paulmck-ThinkPad-P17-Gen-1>
 <Y9asu0CswZZ3yyls@andrea>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y9asu0CswZZ3yyls@andrea>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 29, 2023 at 06:28:27PM +0100, Andrea Parri wrote:
> > Why can't P3's spin_lock() read from that initial write?
> 
> Mmh, sounds like you want to play with something like below?
> 
>   Andrea
> 
> diff --git a/tools/memory-model/lock.cat b/tools/memory-model/lock.cat
> index 6b52f365d73ac..20c3af4511255 100644
> --- a/tools/memory-model/lock.cat
> +++ b/tools/memory-model/lock.cat
> @@ -74,7 +74,6 @@ flag ~empty UL \ range(critical) as unmatched-unlock
>  
>  (* Allow up to one unmatched LKW per location; more must deadlock *)
>  let UNMATCHED-LKW = LKW \ domain(critical)
> -empty ([UNMATCHED-LKW] ; loc ; [UNMATCHED-LKW]) \ id as unmatched-locks
>  
>  (* rfi for LF events: link each LKW to the LF events in its critical section *)
>  let rfi-lf = ([LKW] ; po-loc ; [LF]) \ ([LKW] ; po-loc ; [UL] ; po-loc)
> @@ -120,8 +119,7 @@ let rf-ru = rfe-ru | rfi-ru
>  let rf = rf | rf-lf | rf-ru
>  
>  (* Generate all co relations, including LKW events but not UL *)
> -let co0 = co0 | ([IW] ; loc ; [LKW]) |
> -	(([LKW] ; loc ; [UNMATCHED-LKW]) \ [UNMATCHED-LKW])
> +let co0 = co0 | ([IW] ; loc ; [LKW])
>  include "cos-opt.cat"
>  let W = W | UL
>  let M = R | W

No idea.  But the following litmus test gets no executions whatsoever,
so point taken about my missing at least one corner case.  ;-)

Adding a spin_unlock() to the end of either process allows both to
run.

One could argue that this is a bug, but one could equally well argue
that if you have a deadlock, you have a deadlock.

Thoughts?

							Thanx, Paul

------------------------------------------------------------------------

C lock

{
}


P0(int *a, int *b, spinlock_t *l)
{
	spin_lock(l);
	WRITE_ONCE(*a, 1);
}

P1(int *a, int *b, spinlock_t *l)
{
	spin_lock(l);
	WRITE_ONCE(*b, 1);
}

exists (a=1 /\ b=1)
