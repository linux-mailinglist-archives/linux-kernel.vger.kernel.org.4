Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B090A64E209
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 20:59:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229789AbiLOT7B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 14:59:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbiLOT65 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 14:58:57 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68CB22ED51;
        Thu, 15 Dec 2022 11:58:56 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 058CA61EFE;
        Thu, 15 Dec 2022 19:58:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54873C433EF;
        Thu, 15 Dec 2022 19:58:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671134335;
        bh=Zx9ma7/5lFMJQesW6o8ux/+Vin72c34PJvibgWse7nA=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=nbVOWxpp4fPBvH9uzkyllCc0lUc7Om6MHWaMdiKkYiUFWHDH9dE/iVOYftqxUg4R1
         3Of7Oj+OvDa1lZD6vDiC72JK6ME4Xl8KkBMKZsRS1UxpMA1WpkXCKG62eoVdFaEjD5
         Uh5FmonE446lolDNLwXmkiJThLXYL+CIsdzpdlnEwjGc7UR8r50KqwGS0ZlTlE+97g
         XlOHr/EesM+bvb+Sdc7jPQSEhH0O06ykO/NrTADrQQWau0DkcLQqZiZQse3d5hTVlL
         JWISKFYZXIcKJyADnLh5TfLtz5NBcuwU35QK4wehyFkynkARmt5G9o2PFu6cL4sW2R
         qmK0Gpt10dd4Q==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id E33AB5C09D0; Thu, 15 Dec 2022 11:58:54 -0800 (PST)
Date:   Thu, 15 Dec 2022 11:58:54 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Frederic Weisbecker <frederic@kernel.org>, boqun.feng@gmail.com,
        neeraj.iitr10@gmail.com, urezki@gmail.com, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC] srcu: Yet more detail for
 srcu_readers_active_idx_check() comments
Message-ID: <20221215195854.GL4001@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20221214191355.GA2596199@paulmck-ThinkPad-P17-Gen-1>
 <20221215165452.GA1957735@lothringen>
 <20221215170834.GH4001@paulmck-ThinkPad-P17-Gen-1>
 <CAEXW_YTSW9kr3DsJm6hTQ0FfwVbVjzDa8=7H29+ysD10ZCbnHA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEXW_YTSW9kr3DsJm6hTQ0FfwVbVjzDa8=7H29+ysD10ZCbnHA@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 15, 2022 at 05:48:46PM +0000, Joel Fernandes wrote:
> On Thu, Dec 15, 2022 at 5:08 PM Paul E. McKenney <paulmck@kernel.org> wrote:
> 
> > > Scenario for the reader to increment the old idx once:
> > >
> > > _ Assume ssp->srcu_idx is initially 0.
> > > _ The READER reads idx that is 0
> > > _ The updater runs and flips the idx that is now 1
> > > _ The reader resumes with 0 as an index but on the next srcu_read_lock()
> > >   it will see the new idx which is 1
> > >
> > > What could be the scenario for it to increment the old idx twice?
> >
> > Unless I am missing something, the reader must reference the
> > srcu_unlock_count[old_idx] and then do smp_mb() before it will be
> > absolutely guaranteed of seeing the new value of ->srcu_idx.
> 
> I think both of you are right depending on how the flip raced with the
> first reader's unlock in that specific task.

There are indeed a variety of scenarios and also a variety of failure
cases.

> If the first read section's srcu_read_unlock() and its corresponding
> smp_mb()  happened before the flip, then the increment of old idx
> would happen only once. The next srcu_read_lock() will read the new
> index. If the srcu_read_unlock() and it's corresponding smp_mb()
> happened after the flip, the old_idx will be sampled again and can be
> incremented twice. So it depends on how the flip races with
> srcu_read_unlock().

I do understand that a number of people like reasoning about
memory-barrier ordering, courtesy of the sequentially consistent portions
of the C and C++ memory models, but thinking in terms of the accesses
surrounding the memory barriers has been far less error-prone.

> Also, since this is all hard to reason about I started making some
> diagrams, LOL. For your amusement, here is why need to scan both idx
> during grace period detection: https://i.imgur.com/jz4bNKd.png

Nice!

I suggest placing a gap between GP 2 and GP 3.  That way, you can make it
very clear that Reader 1's critical section starts after the end of GP 2
(thus clearly never blocking GP 2) and before GP 3 (thus possibly having
a reference to some data that is going to be freed at the end of GP 3).

I also suggest coloring Reader 1 red and Reader 2 green, given that the
color red generally indicates danger.

							Thanx, Paul
