Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9B6F6A61E2
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 22:57:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229667AbjB1V46 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 16:56:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229580AbjB1V44 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 16:56:56 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26A1F1259F;
        Tue, 28 Feb 2023 13:56:56 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9BE27611EC;
        Tue, 28 Feb 2023 21:56:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06A12C4339B;
        Tue, 28 Feb 2023 21:56:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677621415;
        bh=ZCslAg5mFuG+VQFYzF+2mINX4NCH81xqNvRV9QNFhFQ=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=WevWBYjL9MKzeWAsPIQLf17NiK5O+jqGcEIQJRbVOVb/r6a9I34m3h4zD8Bxc7+st
         26lr65BfYkjAbmFcr6pTDwUHopIrR1/0yvCZM2u3sARlyw2W44yJWsk8dKElE9dilw
         DHWbpgWBK/eqQaO8S7/BNzlAvysREUqn3TzS7ago+FteUo8AZMHSKkK5HHQqAeWRe0
         moZpdZljTe929XTkRbHTZ6ebLJqvfgbJqvmurtUBl/VYgqeaUxHmAYWyH5H9TQ2uMZ
         mSPVyy4w9IumiPCSfqIu2Q5n327zsp4YrZXBLVJC0Q38Xt40vkmr5t9yNNBFAPgog2
         4hVWkDsK/Ij7A==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id A03775C018D; Tue, 28 Feb 2023 13:56:54 -0800 (PST)
Date:   Tue, 28 Feb 2023 13:56:54 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        Uros Bizjak <ubizjak@gmail.com>, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>
Subject: Re: [PATCH] rcu: use try_cmpxchg in check_cpu_stall
Message-ID: <20230228215654.GY2948950@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20230228155121.3416-1-ubizjak@gmail.com>
 <Y/5mguXPPqdP3MZF@google.com>
 <20230228160324.2a7c1012@gandalf.local.home>
 <20230228212911.GX2948950@paulmck-ThinkPad-P17-Gen-1>
 <20230228164124.77c126d2@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230228164124.77c126d2@gandalf.local.home>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 28, 2023 at 04:41:24PM -0500, Steven Rostedt wrote:
> On Tue, 28 Feb 2023 13:29:11 -0800
> "Paul E. McKenney" <paulmck@kernel.org> wrote:
> 
> > All well and good, but the stall-warning code is nowhere near a fastpath.
> > 
> > Is try_cmpxchg() considered more readable in this context?
> 
> 
> -	    cmpxchg(&rcu_state.jiffies_stall, js, jn) == js) {
> +	    try_cmpxchg(&rcu_state.jiffies_stall, &js, jn)) {
> 
> It's basically the same :-/

That was my assessment.  ;-)

> But looking at this use case, I'd actually NAK it, as it is misleading.
> 
> As try_cmpxchg() is used to get rid of the updating of the old value. As in
> the ring buffer code we had:
> 
> void ring_buffer_record_off(struct trace_buffer *buffer)
> {
> 	unsigned int rd;
> 	unsigned int new_rd;
> 
> 	do {
> 		rd = atomic_read(&buffer->record_disabled);
> 		new_rd = rd | RB_BUFFER_OFF;
> 	} while (!atomic_cmpxchg(&buffer->record_disabled, &rd, new_rd) != rd);
> }
> 
> and the try_cmpxchg() converted it to:
> 
> void ring_buffer_record_off(struct trace_buffer *buffer)
> {
> 	unsigned int rd;
> 	unsigned int new_rd;
> 
> 	rd = atomic_read(&buffer->record_disabled);
> 	do {
> 		new_rd = rd | RB_BUFFER_OFF;
> 	} while (!atomic_try_cmpxchg(&buffer->record_disabled, &rd, new_rd));
> }
> 
> Which got rid of the need to constantly update the rd variable (cmpxchg
> will load rax with the value read, so it removes the need for an extra
> move).
> 
> But in your case, we don't need to update js, in which case the
> try_cmpxchg() does.
> 
> The patch that Uros sent me for the ring buffer code also does some of
> that, which I feel is wrong.
> 
> So with that, I would nack the patch.

OK, I will leave this one out.

							Thanx, Paul
