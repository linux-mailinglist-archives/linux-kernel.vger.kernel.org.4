Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1B5F683869
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 22:11:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232112AbjAaVLn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 16:11:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231731AbjAaVLl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 16:11:41 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D05C953982
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 13:11:40 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 88BBBB81F02
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 21:11:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA328C433EF;
        Tue, 31 Jan 2023 21:11:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675199498;
        bh=qNn349B2YjAHWUomDhP6kZx8TNaQHedpwxpakwXDTHc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=R8aNyKvyJsdl+xmcr86LQgduEe5115P6CA/LFTVkRNQEmEOER0jWi2HcShFxQ1s9B
         CTnshaCq48zY5I1c/WkBDbRitpaXXxIzdQ6mApQpnY9Vj1JH5pXdu7FYEOuFtTxvqH
         pvUU7wWMC3EeUClL65z/NBvoxSWqNxMs6fHqOub/968r7LgLZ8FPZKw2sT0Za0QxF4
         DJRO77N/ur95sNXmvQa2IUogChhzQNOLk2gRqiSJDwvxMldYHM+oEuqzt/GQLpuL9G
         mrTn0pNJtS8+HYrRtRWfHBvzwgLbg4GpmCP+8a5Zkff/0JiHsM+HEet9p5jWJVSKiL
         /cd5I3sptuFOQ==
Date:   Tue, 31 Jan 2023 22:11:35 +0100
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Yu Liao <liaoyu15@huawei.com>, fweisbec@gmail.com,
        mingo@kernel.org, liwei391@huawei.com, adobriyan@gmail.com,
        mirsad.todorovac@alu.unizg.hr, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC] tick/nohz: fix data races in get_cpu_idle_time_us()
Message-ID: <Y9mEB7LMaZ0dMQS/@lothringen>
References: <20230128020051.2328465-1-liaoyu15@huawei.com>
 <87357q228f.ffs@tglx>
 <Y9lyx38kHmKEF5CQ@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y9lyx38kHmKEF5CQ@hirez.programming.kicks-ass.net>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 31, 2023 at 08:57:59PM +0100, Peter Zijlstra wrote:
> On Tue, Jan 31, 2023 at 03:44:00PM +0100, Thomas Gleixner wrote:
> 
> > P.S.: I hate the spinlock in the idle code path, but I don't have a
> >       better idea.
> 
> seqcount? It would avoid the obvious interleave and put most of the onus
> on the reader (which never happens anyway).

Yep, and do the update locally only on idle exit. But note that neither
seqcount nor spinlock will fix the nr_iowait_cpu() based thing. This counter
can be decremented remotely even during the idle period so the reader
can see an iowait period that may eventually be accounted as !iowait,
or the reverse. Breaking the monotonicity and even coherency.

That stuff is broken by design and this is the reason why it got never
really fixed. The seqcount/spinlock would make it just a bit less worse.
