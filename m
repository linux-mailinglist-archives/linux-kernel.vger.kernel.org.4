Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E55015B874B
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 13:30:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229886AbiINLaQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 07:30:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229783AbiINLaM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 07:30:12 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DF26FD33;
        Wed, 14 Sep 2022 04:30:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CA677B819DC;
        Wed, 14 Sep 2022 11:30:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FFD5C433C1;
        Wed, 14 Sep 2022 11:30:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663155009;
        bh=vSZ2A3ZW8E08AXFK17PgjtALNq7eA35IpM9hBXnwfvA=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=i7Q/fIioVqqVTloKvGSZfQmEj/mui0A+OLnV45h58eeuDD6MxiZ9HHS9Wc0cfeQnm
         csmakQ2U/zKxrQq+ARBSEox7dx11SErDX3HPkFIOLZsEsYGX6ILoC0r6MAGEginBQp
         YuXKTrHOUQORn7uUbECFHEoCag1R/tbevSxS5iOZIC522k/Z9OuvBjWoL8p+HNtgbp
         HqkimxBP6zVGz4GBDKaQLw+vQ+BKwm3LnepIyAkzB5ZmF2QFgIk7T2OdG2BuXDsDQX
         JqniOid96elGby5SuLLwD5JORNJPHdzzOrGpgc2r+ovYzc49n5ifzdGrGrrBaO2NPc
         yVm/rMD+mSOuQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id C55C85C06AB; Wed, 14 Sep 2022 04:30:06 -0700 (PDT)
Date:   Wed, 14 Sep 2022 04:30:06 -0700
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
Message-ID: <20220914113006.GX246308@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20220913030036.1569-1-thunder.leizhen@huawei.com>
 <20220913030036.1569-2-thunder.leizhen@huawei.com>
 <20220914104634.GC1936@lothringen>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220914104634.GC1936@lothringen>
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 14, 2022 at 12:46:34PM +0200, Frederic Weisbecker wrote:
> On Tue, Sep 13, 2022 at 11:00:36AM +0800, Zhen Lei wrote:
> > In kernels built with either CONFIG_RCU_NOCB_CPU_DEFAULT_ALL=y or
> > CONFIG_NO_HZ_FULL=y, additional CPUs must be added to rcu_nocb_mask.
> > Except that kernels booted without the rcu_nocbs= will not have
> > allocated rcu_nocb_mask.  And the current rcu_init_nohz() function uses
> > its need_rcu_nocb_mask and offload_all local variables to track the
> > rcu_nocb and nohz_full state.
> > 
> > But there is a much simpler approach, namely creating a cpumask pointer
> > to track the default and then using cpumask_available() to check the
> > rcu_nocb_mask state.  This commit takes this approach, thereby simplifying
> > and shortening the rcu_init_nohz() function.
> > 
> > Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
> > Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> > Acked-by: Frederic Weisbecker <frederic@kernel.org>
> 
> Looks good, thanks!

Queued and pushed, thank you all!

							Thanx, Paul
