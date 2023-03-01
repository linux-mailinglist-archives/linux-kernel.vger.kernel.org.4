Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D8A76A7528
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 21:20:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229791AbjCAUUA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 15:20:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229674AbjCAUT6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 15:19:58 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51CD11F4A3;
        Wed,  1 Mar 2023 12:19:27 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8B213614B6;
        Wed,  1 Mar 2023 20:18:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1610C433EF;
        Wed,  1 Mar 2023 20:18:28 +0000 (UTC)
Date:   Wed, 1 Mar 2023 15:18:26 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Uros Bizjak <ubizjak@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>
Subject: Re: [PATCH] rcu: use try_cmpxchg in check_cpu_stall
Message-ID: <20230301151826.014c5977@gandalf.local.home>
In-Reply-To: <20230301200820.GF2948950@paulmck-ThinkPad-P17-Gen-1>
References: <20230228155121.3416-1-ubizjak@gmail.com>
        <Y/5mguXPPqdP3MZF@google.com>
        <20230228160324.2a7c1012@gandalf.local.home>
        <20230228212911.GX2948950@paulmck-ThinkPad-P17-Gen-1>
        <20230228164124.77c126d2@gandalf.local.home>
        <CAEXW_YQ515_DOLVUm48GvDADuaY2mSrYTaKa7u6jYDNqBncJww@mail.gmail.com>
        <20230228190846.79b06089@gandalf.local.home>
        <CAFULd4aY3Y8tyLN70oebZDagBebvH0erwRxKDaEX8L83Xo8gYw@mail.gmail.com>
        <20230301113813.4f16a689@gandalf.local.home>
        <CAFULd4aWZ+fvVZ+MEt6JD1rFaQZeO5DDWAHtPKOrx8R8DETFBw@mail.gmail.com>
        <20230301200820.GF2948950@paulmck-ThinkPad-P17-Gen-1>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 1 Mar 2023 12:08:20 -0800
"Paul E. McKenney" <paulmck@kernel.org> wrote:

> > Attached patch implements this suggestion.  
> 
> Please help me out here.
> 
> Why on earth are we even discussing making this change to code that
> normally never executes?  Performance is not a consideration here.
> 
> What am I missing here?  Is there some sort of forward-progress
> issue that this change addresses?

Well, we sorta hijacked this thread. It turned into a more general
discussion, as there is code that this change will be useful for
(ring_buffer.c), but we just happen to be having the discussion here.

Where it will at most remove some text and give you back a few extra bytes
of memory ;-)

But if we do use cmpxchg_success() IMHO, it does improve readability.

> -	    cmpxchg(&rcu_state.jiffies_stall, js, jn) == js) {
> +	    cmpxchg_success(&rcu_state.jiffies_stall, js, jn)) {

-- Steve
