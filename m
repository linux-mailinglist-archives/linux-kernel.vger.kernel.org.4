Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B38295EFE38
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 21:56:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229576AbiI2T4r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 15:56:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbiI2T4o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 15:56:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C06F41EC9B2
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 12:56:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B66296216A
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 19:56:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25813C433C1;
        Thu, 29 Sep 2022 19:56:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664481402;
        bh=nppm+sLoKjXXKAFW+4L5wobI8BPs7jkgM6v5WRbgCJM=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=OsnKtNeihCRcHtHXa3pG5UO46PjSYEGQ6Eg4ZNcXYfnLZtD/7PJMEajaZvSSszvQD
         PspL4PZEiN9bLkuPRe/Yp5qv9v3JjoAjVu67JYRu+7Avb2ziEjw9L5iwKk1R5HRkzy
         zSOM1AMK7qly2qWR8WW158a+JrgmRbkFwGaPDbozv0yMoyiw/iT3z3+yBcD4hqHqrh
         AxG/2qOmcHwjEygwHHpVX6pac4+BB+sQ7JFAYw1ZrbCkoYKBJiZSv6a92YV9STZIPd
         I8AB7XDTac8/H7qHrJa6ZaJLYybJu/caHz3YxfrYqelcgM0XLmBzCwzhuELxS0xawG
         h+SV+SQhaTwTQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id C21855C0AC7; Thu, 29 Sep 2022 12:56:41 -0700 (PDT)
Date:   Thu, 29 Sep 2022 12:56:41 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, Boqun Feng <boqun.feng@gmail.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: RCU vs NOHZ
Message-ID: <20220929195641.GZ4196@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20220915191427.GC246308@paulmck-ThinkPad-P17-Gen-1>
 <YyOnilnwnLKA9ghN@hirez.programming.kicks-ass.net>
 <20220916075817.GE246308@paulmck-ThinkPad-P17-Gen-1>
 <YyQ/zn54D1uoaIc1@hirez.programming.kicks-ass.net>
 <20220917142508.GF246308@paulmck-ThinkPad-P17-Gen-1>
 <YzV5vqoLInptafJm@hirez.programming.kicks-ass.net>
 <20220929152044.GE4196@paulmck-ThinkPad-P17-Gen-1>
 <YzXFWEL52MRp2s5j@hirez.programming.kicks-ass.net>
 <20220929163624.GN4196@paulmck-ThinkPad-P17-Gen-1>
 <YzXtOi7rjjWI0ea0@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YzXtOi7rjjWI0ea0@hirez.programming.kicks-ass.net>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 29, 2022 at 09:08:42PM +0200, Peter Zijlstra wrote:
> On Thu, Sep 29, 2022 at 09:36:24AM -0700, Paul E. McKenney wrote:
> 
> > > How has this been tried; and why did the energy cost go up? Is this
> > > because the offload thread ends up waking up the CPU we just put to
> > > sleep?
> > 
> > Because doing the additional work consumes energy.  I am not clear on
> > exactly what you are asking for here, given the limitations of the tools
> > that measure energy consumption.
> 
> What additional work? Splicing the cpu pending list onto another list
> with or without atomic op barely qualifies for work. The main point is
> making sure the pending list isn't in the way of going (deep) idle.

Very good.  Send a patch.

After some time, its successor might correctly handle lock/memory
contention, CPU hotplug, presumed upcoming runtime changes in CPUs'
housekeeping status, frequent idle entry/exit, grace period begin/end,
quiet embedded systems, and so on.

Then we can see if it actually reduces power consumption.

							Thanx, Paul
