Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4152604F19
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 19:45:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229645AbiJSRpE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 13:45:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231218AbiJSRpB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 13:45:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C7ED103D87;
        Wed, 19 Oct 2022 10:44:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 26C6761984;
        Wed, 19 Oct 2022 17:44:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F993C433D6;
        Wed, 19 Oct 2022 17:44:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666201498;
        bh=TY3Uw+0Ns5PZLGxTpKA9rqUhndKRKfptNAqFbQfXUpc=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=a4ZQTiFg/oYQVKEJ/ttMK/JDMU7KOH8Z7LBMi26f0WRT4dbVpddTWKAAPuUckOaUk
         o6fYr3kFy0aCet7spC289fis8xKS0vwyTi3/9eHhTdi4oK4OIAArmn6oSO/R2xYrWj
         OvyxhZ5CLcBJW5vuggFe/0oYHyvWyOqTXahTEBCKEux5lgXmsdqzcMrGV5t1fLFz+h
         9RPHfKvx6eRbZGfAIGIIuNLEhOIFCY9Pds0VUJDvcT9KM6OzulYQ3tl82CUo6zIWXP
         JiX7gm2XLtGIaEAYXQwLmjmjSTmYQbNcRfeBVSLPMssKZdufeitysOPMgv6TpGWtHD
         Z4gd0lVdYPZ0g==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 1D1F55C06B4; Wed, 19 Oct 2022 10:44:58 -0700 (PDT)
Date:   Wed, 19 Oct 2022 10:44:58 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Zqiang <qiang1.zhang@intel.com>, frederic@kernel.org,
        rcu@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rcu: Make call_rcu() lazy only when CONFIG_RCU_LAZY is
 enabled
Message-ID: <20221019174458.GD5600@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <B3E5FB1F-3184-4C56-8B11-6F422DBF1B53@joelfernandes.org>
 <F24713AB-9AC8-494F-A677-D52C9CE591CF@joelfernandes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <F24713AB-9AC8-494F-A677-D52C9CE591CF@joelfernandes.org>
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 19, 2022 at 08:12:30AM -0400, Joel Fernandes wrote:
> > On Oct 19, 2022, at 8:10 AM, Joel Fernandes <joel@joelfernandes.org> wrote:
> >> On Oct 19, 2022, at 6:34 AM, Zqiang <qiang1.zhang@intel.com> wrote:
> >> 
> >> ﻿Currently, regardless of whether the CONFIG_RCU_LAZY is enabled,
> >> invoke the call_rcu() is always lazy, it also means that when
> >> CONFIG_RCU_LAZY is disabled, invoke the call_rcu_flush() is also
> >> lazy. therefore, this commit make call_rcu() lazy only when
> >> CONFIG_RCU_LAZY is enabled.

First, good eyes!  Thank you for spotting this!!!

> >> Signed-off-by: Zqiang <qiang1.zhang@intel.com>
> >> ---
> >> kernel/rcu/tree.c | 8 +++++++-
> >> 1 file changed, 7 insertions(+), 1 deletion(-)
> >> 
> >> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> >> index abc615808b6e..97ef602da3d5 100644
> >> --- a/kernel/rcu/tree.c
> >> +++ b/kernel/rcu/tree.c
> >> @@ -2839,7 +2839,6 @@ void call_rcu_flush(struct rcu_head *head, rcu_callback_t func)
> >>   return __call_rcu_common(head, func, false);
> >> }
> >> EXPORT_SYMBOL_GPL(call_rcu_flush);
> >> -#endif
> >> 
> >> /**
> >> * call_rcu() - Queue an RCU callback for invocation after a grace period.
> >> @@ -2890,6 +2889,13 @@ void call_rcu(struct rcu_head *head, rcu_callback_t func)
> >>   return __call_rcu_common(head, func, true);
> >> }
> >> EXPORT_SYMBOL_GPL(call_rcu);
> >> +#else
> >> +void call_rcu(struct rcu_head *head, rcu_callback_t func)
> >> +{
> >> +    return __call_rcu_common(head, func, false);
> > 
> > Thanks. Instead of adding new function, you can also pass IS_ENABLED(CONFIG…) to the existing function of the same name.

I do like this approach better -- less code, more obvious what is going on.

> > Looks like though I made every one test the patch without having to enable the config option ;-). Hey, I’m a half glass full kind of guy, why do you ask?
> > 
> > Paul, I’ll take a closer look once I’m at the desk, but would you prefer to squash a diff into the existing patch, or want a new patch altogether?
> 
> On the other hand, what I’d want is to nuke the config option altogether or make it default y, we want to catch issues sooner than later.

That might be what we do at some point, but one thing at a time.  Let's
not penalize innocent bystanders, at least not just yet.

I do very strongly encourage the ChromeOS and Android folks to test this
very severely, however.

							Thanx, Paul

> Thanks.
> 
> > 
> > Thanks.
> > 
> > - Joel
> > 
> > 
> >> +}
> >> +EXPORT_SYMBOL_GPL(call_rcu);
> >> +#endif
> >> 
> >> /* Maximum number of jiffies to wait before draining a batch. */
> >> #define KFREE_DRAIN_JIFFIES (5 * HZ)
> >> -- 
> >> 2.25.1
> >> 
