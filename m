Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8034D602F7D
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 17:18:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230060AbiJRPS5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 11:18:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229958AbiJRPSv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 11:18:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD9B7D18E2;
        Tue, 18 Oct 2022 08:18:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E857961506;
        Tue, 18 Oct 2022 15:18:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51DB5C433D7;
        Tue, 18 Oct 2022 15:18:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666106327;
        bh=DT+xBIq3KLucEcQYj5yJMWsM59FQDbce08H2SNjYeg8=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=ehHMQGtnxm5egs3G9/maEaptkzg5UwDnQ8jbtuqPakZE0J2M8Op07EF/XSe6l0bxj
         HvXUG1GNsr5Hb51oSpmH9bpawG3nsbzS6iIDBjAeQvcnI1N+ST8fgHGZa05e/WsG5e
         uXvEqpaeUcVXH32bCwA/Bkyz+xPcPrBkEbRvHQGhzJCkLpk3+BZOmbwKknX1YZqSaj
         M58JKa9xYT5Qaladzg8i9WfDvaI97B3aAQc/PQ+sKlZZv193vYNNbHB/E/jOArqtkw
         8fzJdsJ5ZNqs8e0zTfijDfAbrJGDtePtMen0mLlAHPSiSfrG9l2A1psBpReK1s1uRr
         lx5p9uhZF8taw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id E6F115C0528; Tue, 18 Oct 2022 08:18:46 -0700 (PDT)
Date:   Tue, 18 Oct 2022 08:18:46 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, rostedt@goodmis.org,
        Randy Dunlap <rdunlap@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Petr Mladek <pmladek@suse.com>
Subject: Re: [PATCH RFC v2 rcu 2/8] srcu: Create an srcu_read_lock_nmisafe()
 and srcu_read_unlock_nmisafe()
Message-ID: <20221018151846.GQ5600@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20220929180714.GA2874192@paulmck-ThinkPad-P17-Gen-1>
 <20220929180731.2875722-2-paulmck@kernel.org>
 <87edv54316.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87edv54316.fsf@jogness.linutronix.de>
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 18, 2022 at 04:37:01PM +0206, John Ogness wrote:
> Hi Paul,
> 
> Sorry for the late response here. I am now trying to actually use this
> series.
> 
> On 2022-09-29, "Paul E. McKenney" <paulmck@kernel.org> wrote:
> > diff --git a/kernel/rcu/Kconfig b/kernel/rcu/Kconfig
> > index d471d22a5e21..f53ad63b2bc6 100644
> > --- a/kernel/rcu/Kconfig
> > +++ b/kernel/rcu/Kconfig
> > @@ -72,6 +72,9 @@ config TREE_SRCU
> >  	help
> >  	  This option selects the full-fledged version of SRCU.
> >  
> 
> You are missing a:
> 
> +config ARCH_HAS_NMI_SAFE_THIS_CPU_OPS
> +	bool
> +
> 
> Otherwise there is no CONFIG_ARCH_HAS_NMI_SAFE_THIS_CPU_OPS, so for
> example CONFIG_NEED_SRCU_NMI_SAFE always ends up with y on X86.

Good catch, thank you!  Pulling this in with attribution.

							Thanx, Paul

> > +config NEED_SRCU_NMI_SAFE
> > +	def_bool HAVE_NMI && !ARCH_HAS_NMI_SAFE_THIS_CPU_OPS && !TINY_SRCU
> > +
> 
> John
