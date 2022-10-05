Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D2575F52BC
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Oct 2022 12:39:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229459AbiJEKja (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Oct 2022 06:39:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229586AbiJEKj0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Oct 2022 06:39:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCAC458DD7;
        Wed,  5 Oct 2022 03:39:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D52CC61631;
        Wed,  5 Oct 2022 10:39:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDA2DC4347C;
        Wed,  5 Oct 2022 10:39:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664966363;
        bh=34r0VvrhY3RK5Xag76GfQPTcTj8nQrZw7LsztzDMZ5s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KmZE/Zzbw6CH4z4rbZtBj92r0jhmLY/7Dh5LJ8ZCj6cCPRbZcSrL8TbpImLuC/JFy
         kcrEOwsN0bOvK12Rw9rpAHCW5THGP5ZGBI7qQk5NWWfo0wXX/LFS4SX6q5ek9dIRwO
         PCGctggnIufOK5j6tKLbCx/3yeEgB8XoP6isLVgC8wlfRPJVcYK4R3XpoFC8AqAOP6
         tnmZpkl49z35OLeRhOh9iB2xuH9n8lcCcRU/SXh3ZoXttc1eQxboGA6335vmtqzfoX
         bK/0C0bujBbYZTAvA0Evbm0smczkS930T2Ph+kR8VXLIJpspfNrunu/9chTLhkVyrx
         qEDvsqkXRei7Q==
Date:   Wed, 5 Oct 2022 12:39:20 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        rushikesh.s.kadam@intel.com, urezki@gmail.com,
        neeraj.iitr10@gmail.com, paulmck@kernel.org, rostedt@goodmis.org,
        youssefesmat@google.com, surenb@google.com
Subject: Re: [PATCH v7 01/11] rcu: Wake up nocb gp thread on
 rcu_barrier_entrain()
Message-ID: <20221005103920.GA326169@lothringen>
References: <20221004024157.2470238-1-joel@joelfernandes.org>
 <20221004024157.2470238-2-joel@joelfernandes.org>
 <20221004222853.GA323878@lothringen>
 <c634e41e-3c6c-0896-0873-b9d1bb317cea@joelfernandes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c634e41e-3c6c-0896-0873-b9d1bb317cea@joelfernandes.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 04, 2022 at 06:57:59PM -0400, Joel Fernandes wrote:
> >> needed after an entrain. Otherwise, the RCU barrier callback can wait in
> >> the queue for several seconds before the lazy callbacks in front of it
> >> are serviced.
> > 
> > It's not about lazy callbacks here (but you can mention the fact that
> > waking nocb_gp if necessary after flushing bypass is a beneficial side
> > effect for further lazy implementation).
> > 
> > So here is the possible bad scenario:
> > 
> > 1) CPU 0 is nocb, it queues a callback
> > 2) CPU 0 goes idle (or userspace with nohz_full) forever
> > 3) The grace period related to that callback elapses
> > 4) The callback is moved to the done list (but is not invoked yet), there are no more pending for CPU 0
> > 5) CPU 1 calls rcu_barrier() and entrains to CPU 0 cblist
> 
> CPU 1 can only entrain into CPU 0 if the CPU is offline:
> 
> 		if (!rcu_rdp_cpu_online(rdp)) {
> 			rcu_barrier_entrain(rdp);
> 			WARN_ON_ONCE(READ_ONCE(rdp->barrier_seq_snap) != gseq);
> 			raw_spin_unlock_irqrestore(&rcu_state.barrier_lock,
> 			...
> 			continue;
> 		}

Ah good point. So CPU 1 sends an IPI to CPU 0 which entrains itself.
And then looks like the result is the same.


> 
> Otherwise an IPI does the entraining. So I do not see how CPU 0 being idle
> causes the cross-CPU entraining.

It doesn't but it shows that the CPU isn't going to enqueue any further
callback before a while. Though even if it did, it may not even solve the
situation, not until an RCU_NOCB_WAKE_FORCE is issued...

> 
> > 6) CPU 1 waits forever
> 
> But, I agree it can still wait forever, once the IPI handler does the
> entraining, since nothing will do the GP thread wakeup.
> 
> >>
> >> Reported-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> > 
> > Fixes: 5d6742b37727 ("rcu/nocb: Use rcu_segcblist for no-CBs CPUs")
> 
> So, do you mind writing a proper patch with a proper commit message and Fixes
> tag then? It can independent of this series and add my Reported-by tag,
> thanks!

Ok will do.

Thanks!

> 
> Thanks!
> 
>  - Joel
> 
