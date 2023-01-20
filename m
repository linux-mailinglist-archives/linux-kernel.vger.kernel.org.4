Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63BE6675C61
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 19:04:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229730AbjATSEB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 13:04:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229764AbjATSD4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 13:03:56 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E014459E46;
        Fri, 20 Jan 2023 10:03:50 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7BF9362047;
        Fri, 20 Jan 2023 18:03:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D00E3C433EF;
        Fri, 20 Jan 2023 18:03:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674237829;
        bh=ap8FyQeJDDy3jM707/8Gq4iOiU+FGtOYe43VN4brGaA=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=MYcF5iztC5a6KZKWsW69MJEXn20PjbBeKsah9PQeQuIWY1kcu+XFqlrykl0sYyGTX
         gNEcjEeklbvnfiMkQyGGzPlZw6hFFlbyRLjvEJducqEJosp8AXsAd09lijOxhQUwI2
         GnLB+s7vLeWLx6Z5wR/+4cLdme5LrGwEzP4d9+JntA9naUEh1bydTIC9hz5/uEpDak
         1ABCrmWdIihMLvDQqxhmS4712z0TSwuWSzNN7mUb7R5vjtuIIrG0jL7vAKskp4POAf
         b6c6wNPlT3rBEzGKRBYdMH4Alsya3x08CWk10Z+KJ5rotivVQcHqS1wgoLpO4ZEGxU
         kPMyxiVkDizjQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 772BB5C17DC; Fri, 20 Jan 2023 10:03:49 -0800 (PST)
Date:   Fri, 20 Jan 2023 10:03:49 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@meta.com, rostedt@goodmis.org,
        Viresh Kumar <viresh.kumar@linaro.org>,
        linux-pm@vger.kernel.org, John Ogness <john.ogness@linutronix.de>,
        sfr@canb.auug.org.au
Subject: Re: [PATCH rcu v2 03/20] drivers/cpufreq: Remove "select SRCU"
Message-ID: <20230120180349.GO2948950@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20230113001103.GA3374173@paulmck-ThinkPad-P17-Gen-1>
 <20230113001132.3375334-3-paulmck@kernel.org>
 <CAJZ5v0ge-bYk+PM7c98+wNi28q9aOwERxfqC9K9ZSfCmUOzFfg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0ge-bYk+PM7c98+wNi28q9aOwERxfqC9K9ZSfCmUOzFfg@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 20, 2023 at 05:54:17PM +0100, Rafael J. Wysocki wrote:
> On Fri, Jan 13, 2023 at 1:11 AM Paul E. McKenney <paulmck@kernel.org> wrote:
> >
> > Now that the SRCU Kconfig option is unconditionally selected, there is
> > no longer any point in selecting it.  Therefore, remove the "select SRCU"
> > Kconfig statements.
> >
> > Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> > Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> > Cc: Viresh Kumar <viresh.kumar@linaro.org>
> > Cc: <linux-pm@vger.kernel.org>
> > Acked-by: "Rafael J. Wysocki" <rafael@kernel.org>
> > Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> > Reviewed-by: John Ogness <john.ogness@linutronix.de>
> > ---
> >  drivers/cpufreq/Kconfig | 1 -
> >  1 file changed, 1 deletion(-)
> >
> > diff --git a/drivers/cpufreq/Kconfig b/drivers/cpufreq/Kconfig
> > index 2a84fc63371e2..785541df59379 100644
> > --- a/drivers/cpufreq/Kconfig
> > +++ b/drivers/cpufreq/Kconfig
> > @@ -3,7 +3,6 @@ menu "CPU Frequency scaling"
> >
> >  config CPU_FREQ
> >         bool "CPU Frequency scaling"
> > -       select SRCU
> >         help
> >           CPU Frequency scaling allows you to change the clock speed of
> >           CPUs on the fly. This is a nice method to save power, because
> > --
> 
> Applied as 6.3 material, thanks!

Thank you, I will drop it from my tree on my next rebase.

							Thanx, Paul
