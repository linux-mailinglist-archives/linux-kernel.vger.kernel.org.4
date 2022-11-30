Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0777063E2E3
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 22:44:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229712AbiK3VoM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 16:44:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbiK3VoH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 16:44:07 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17A4631ED9;
        Wed, 30 Nov 2022 13:44:06 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C59BBB81B97;
        Wed, 30 Nov 2022 21:44:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50466C433D6;
        Wed, 30 Nov 2022 21:44:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669844643;
        bh=qD0Rli9JXd8tq5gzZqVcpKKh0sLQJzXsETSrA7cBLoE=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=iIsRvFPmlSFnfkTZGuPyoNqrQYobjXgXCUjn5jCIr3u0fhlfNCVbZfE6JxInH72mu
         qVHdTom2PfdjMF9kZr0zS68ge2WowIKoNJLhDmUyQnbCmXU0s64BePUn7LlAQhjS21
         zUMUVrXw8B/yMZ/O1uHzvKj9wxLD2M9/0U1QuCf1QOudMIM92xjSAnFXjmGTiK1xNM
         19gNfmEs6paVJAfrMsdnIM9M1mqegdAdqkm3eOonag1yXDtXEYxkXfy4OfGgFviH2a
         boljbCA0LhVcrI3sICI8kAVpmGxEpxLFIRAvP9d8HhHKuzpPrBSlauaeTpU3AuQT4n
         K1gTTNEeM8nDg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id E53B55C051C; Wed, 30 Nov 2022 13:44:02 -0800 (PST)
Date:   Wed, 30 Nov 2022 13:44:02 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Tejun Heo <tj@kernel.org>
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@meta.com, rostedt@goodmis.org,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Dennis Zhou <dennis@kernel.org>,
        Christoph Lameter <cl@linux.com>, linux-mm@kvack.org
Subject: Re: [PATCH rcu 12/16] percpu-refcount: Use call_rcu_hurry() for
 atomic switch
Message-ID: <20221130214402.GV4001@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20221130181316.GA1012431@paulmck-ThinkPad-P17-Gen-1>
 <20221130181325.1012760-12-paulmck@kernel.org>
 <Y4eycHpdYz7aoq10@slm.duckdns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y4eycHpdYz7aoq10@slm.duckdns.org>
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 30, 2022 at 09:43:44AM -1000, Tejun Heo wrote:
> On Wed, Nov 30, 2022 at 10:13:21AM -0800, Paul E. McKenney wrote:
> > From: "Joel Fernandes (Google)" <joel@joelfernandes.org>
> > 
> > Earlier commits in this series allow battery-powered systems to build
> > their kernels with the default-disabled CONFIG_RCU_LAZY=y Kconfig option.
> > This Kconfig option causes call_rcu() to delay its callbacks in order to
> > batch callbacks.  This means that a given RCU grace period covers more
> > callbacks, thus reducing the number of grace periods, in turn reducing
> > the amount of energy consumed, which increases battery lifetime which
> > can be a very good thing.  This is not a subtle effect: In some important
> > use cases, the battery lifetime is increased by more than 10%.
> > 
> > This CONFIG_RCU_LAZY=y option is available only for CPUs that offload
> > callbacks, for example, CPUs mentioned in the rcu_nocbs kernel boot
> > parameter passed to kernels built with CONFIG_RCU_NOCB_CPU=y.
> > 
> > Delaying callbacks is normally not a problem because most callbacks do
> > nothing but free memory.  If the system is short on memory, a shrinker
> > will kick all currently queued lazy callbacks out of their laziness,
> > thus freeing their memory in short order.  Similarly, the rcu_barrier()
> > function, which blocks until all currently queued callbacks are invoked,
> > will also kick lazy callbacks, thus enabling rcu_barrier() to complete
> > in a timely manner.
> > 
> > However, there are some cases where laziness is not a good option.
> > For example, synchronize_rcu() invokes call_rcu(), and blocks until
> > the newly queued callback is invoked.  It would not be a good for
> > synchronize_rcu() to block for ten seconds, even on an idle system.
> > Therefore, synchronize_rcu() invokes call_rcu_hurry() instead of
> > call_rcu().  The arrival of a non-lazy call_rcu_hurry() callback on a
> > given CPU kicks any lazy callbacks that might be already queued on that
> > CPU.  After all, if there is going to be a grace period, all callbacks
> > might as well get full benefit from it.
> > 
> > Yes, this could be done the other way around by creating a
> > call_rcu_lazy(), but earlier experience with this approach and
> > feedback at the 2022 Linux Plumbers Conference shifted the approach
> > to call_rcu() being lazy with call_rcu_hurry() for the few places
> > where laziness is inappropriate.
> > 
> > And another call_rcu() instance that cannot be lazy is the one on the
> > percpu refcounter's "per-CPU to atomic switch" code path, which
> > uses RCU when switching to atomic mode.  The enqueued callback
> > wakes up waiters waiting in the percpu_ref_switch_waitq.  Allowing
> > this callback to be lazy would result in unacceptable slowdowns for
> > users of per-CPU refcounts, such as blk_pre_runtime_suspend().
> > 
> > Therefore, make __percpu_ref_switch_to_atomic() use call_rcu_hurry()
> > in order to revert to the old behavior.
> > 
> > [ paulmck: Apply s/call_rcu_flush/call_rcu_hurry/ feedback from Tejun Heo. ]
> > 
> > Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> > Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> > Cc: Dennis Zhou <dennis@kernel.org>
> > Cc: Tejun Heo <tj@kernel.org>
> > Cc: Christoph Lameter <cl@linux.com>
> > Cc: <linux-mm@kvack.org>
> 
> Acked-by: Tejun Heo <tj@kernel.org>

I applied both, thank you very much!

							Thanx, Paul
