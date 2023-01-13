Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6673166A390
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 20:43:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231267AbjAMTn3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 14:43:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231144AbjAMTmt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 14:42:49 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F3D68A21C;
        Fri, 13 Jan 2023 11:42:11 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DB1E7B821AC;
        Fri, 13 Jan 2023 19:42:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 726D1C433EF;
        Fri, 13 Jan 2023 19:42:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673638928;
        bh=i5SPJ9ruDKdO5PXYBwEMgHw4eQ3C0NHYLRm6fxx4hbc=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=tOe7T6zrHqmhtikKHhD2/Tk53HWJzJD7S0mB40dvvplRG5gksdW+mnEbAb2mnFXZm
         Wq/mf81WAoR8E9v1vMJimY26ahEjgol080MbIKUHpixETGL30GlunSvKNNU/K/i2XQ
         9SM2szylTpDzRVMivfEbstB0teX/eH9uYiyFNGvA/RUEVAFAF+/RtGlRqA1f6dTqF6
         pfNyzkvB3lHG4te1oxeujIrClz45lM9ksLKR2qBO6OLPtBpR+EU6uvumTA2M/cbsh+
         MguU4c5N2++dYSgbzcoIno3sxLWAaQi1pqQ2421OhNLu367Uk5qLGR/oiymoEXSuOZ
         59TpV2nl7P9cA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 155B55C06D0; Fri, 13 Jan 2023 11:42:08 -0800 (PST)
Date:   Fri, 13 Jan 2023 11:42:08 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@meta.com, rostedt@goodmis.org,
        =?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
        Borislav Petkov <bp@suse.de>,
        Alan Stern <stern@rowland.harvard.edu>,
        John Ogness <john.ogness@linutronix.de>
Subject: Re: [PATCH rcu v2 15/20] kernel/notifier: Remove CONFIG_SRCU
Message-ID: <20230113194208.GE4028633@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20230113001103.GA3374173@paulmck-ThinkPad-P17-Gen-1>
 <20230113001132.3375334-15-paulmck@kernel.org>
 <608756bb-3012-e02c-5b16-04314cdc9889@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <608756bb-3012-e02c-5b16-04314cdc9889@intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 13, 2023 at 12:25:48PM +0100, Wysocki, Rafael J wrote:
> 
> On 1/13/2023 1:11 AM, Paul E. McKenney wrote:
> > Now that the SRCU Kconfig option is unconditionally selected, there is
> > no longer any point in conditional compilation based on CONFIG_SRCU.
> > Therefore, remove the #ifdef.
> > 
> > Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> > Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
> > Cc: "Michał Mirosław" <mirq-linux@rere.qmqm.pl>
> > Cc: Borislav Petkov <bp@suse.de>
> > Cc: Alan Stern <stern@rowland.harvard.edu>
> > Reviewed-by: John Ogness <john.ogness@linutronix.de>
> 
> Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Thank you!  I will apply both of your acks on my next rebase.

							Thanx, Paul

> > ---
> >   kernel/notifier.c | 3 ---
> >   1 file changed, 3 deletions(-)
> > 
> > diff --git a/kernel/notifier.c b/kernel/notifier.c
> > index ab75637fd904f..d353e4b5402d7 100644
> > --- a/kernel/notifier.c
> > +++ b/kernel/notifier.c
> > @@ -456,7 +456,6 @@ int raw_notifier_call_chain(struct raw_notifier_head *nh,
> >   }
> >   EXPORT_SYMBOL_GPL(raw_notifier_call_chain);
> > -#ifdef CONFIG_SRCU
> >   /*
> >    *	SRCU notifier chain routines.    Registration and unregistration
> >    *	use a mutex, and call_chain is synchronized by SRCU (no locks).
> > @@ -573,8 +572,6 @@ void srcu_init_notifier_head(struct srcu_notifier_head *nh)
> >   }
> >   EXPORT_SYMBOL_GPL(srcu_init_notifier_head);
> > -#endif /* CONFIG_SRCU */
> > -
> >   static ATOMIC_NOTIFIER_HEAD(die_chain);
> >   int notrace notify_die(enum die_val val, const char *str,
