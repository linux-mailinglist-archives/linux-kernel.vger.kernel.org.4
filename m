Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FD335BA1CA
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 22:25:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229637AbiIOUZI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 16:25:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbiIOUZE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 16:25:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11BC65725E;
        Thu, 15 Sep 2022 13:25:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A00E862446;
        Thu, 15 Sep 2022 20:25:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA742C433D6;
        Thu, 15 Sep 2022 20:25:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663273503;
        bh=2mlgeLCCM9tgN/+2+P7WYlBHu2uO/quU2wwweklHWC0=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=EQCBBlYXft7dDfY4y0E22efFuLqrOqifVcdaPE7i3Y63Tg0m0UGLfz0mELFWClKXA
         HyNVeAZp59Duzd38P74206XpoCXjsQmk+dtOu6R5oJUbYRTy8wPyWqp5ti+LRg6Ca7
         CYK+gBjmhgFbtjDzvHs4FFTIsgDNS2L5mChnEF4LGAW2S7qkpqYN3jC5wKdzwp4OCf
         vNYruYU0RriM/8DERH6sGuhZxfktXptxxcbNUdWpUvc8jY5U8AEiLHouUOIp79bbqa
         1sXooEseEWJRBjNAJUGWvPR4T+CJLVZfHyhnY72QFy4vkdZlPNlVzLQve9BXL6aVFv
         1bJoc26Z9hMPQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 4CA205C0514; Thu, 15 Sep 2022 13:25:00 -0700 (PDT)
Date:   Thu, 15 Sep 2022 13:25:00 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     Zhen Lei <thunder.leizhen@huawei.com>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 1/1] rcu: Simplify rcu_init_nohz() cpumask handling
Message-ID: <20220915202500.GA346406@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20220913030036.1569-1-thunder.leizhen@huawei.com>
 <20220913030036.1569-2-thunder.leizhen@huawei.com>
 <20220914104634.GC1936@lothringen>
 <20220914113006.GX246308@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220914113006.GX246308@paulmck-ThinkPad-P17-Gen-1>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 14, 2022 at 04:30:06AM -0700, Paul E. McKenney wrote:
> On Wed, Sep 14, 2022 at 12:46:34PM +0200, Frederic Weisbecker wrote:
> > On Tue, Sep 13, 2022 at 11:00:36AM +0800, Zhen Lei wrote:
> > > In kernels built with either CONFIG_RCU_NOCB_CPU_DEFAULT_ALL=y or
> > > CONFIG_NO_HZ_FULL=y, additional CPUs must be added to rcu_nocb_mask.
> > > Except that kernels booted without the rcu_nocbs= will not have
> > > allocated rcu_nocb_mask.  And the current rcu_init_nohz() function uses
> > > its need_rcu_nocb_mask and offload_all local variables to track the
> > > rcu_nocb and nohz_full state.
> > > 
> > > But there is a much simpler approach, namely creating a cpumask pointer
> > > to track the default and then using cpumask_available() to check the
> > > rcu_nocb_mask state.  This commit takes this approach, thereby simplifying
> > > and shortening the rcu_init_nohz() function.
> > > 
> > > Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
> > > Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> > > Acked-by: Frederic Weisbecker <frederic@kernel.org>
> > 
> > Looks good, thanks!
> 
> Queued and pushed, thank you all!

And this time, actually queued the most recent version.  Apologies for
my confusion.

							Thanx, Paul
