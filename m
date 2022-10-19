Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13D166053FF
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 01:34:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231336AbiJSXed (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 19:34:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbiJSXea (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 19:34:30 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC3E02BF6;
        Wed, 19 Oct 2022 16:34:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 611B6B824C3;
        Wed, 19 Oct 2022 23:34:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00582C433C1;
        Wed, 19 Oct 2022 23:34:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666222460;
        bh=AZd2S+UDQ1sNGjp6/BePc0FXwRMYt8Wh9ZNECQ1T5hA=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=D9E4LUeGeKMKJ344SLsSPcsWxTOJ5pzjng7fcAcfJBCPmY6bjfu9VJmLANP78xhYk
         ePnRMfjGp37d/XtaTmbK5W259/cSlZmBa8loulhUbcXeYFgJwVAC9nwAfxnDWxlbjK
         sMQ1E3XqqDoaR9dzcJWiL3pCQbCONsBTVF7/YCIlQasYL7d+HViNqwh5gIhvKjU6x5
         GqtL4dsoKlqaMg3OUE5RzB8IyrJR7gw/e/sTEXnBPZiqCDmr8Neh5BqcGyZofUeXvx
         FsUBQ0nIZvZgrzCMG065kRuViim99f/c4eU0hApsuA6UypyBkxr8yBCgHHyPQOnmE2
         i17IpxQVWYU+g==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 923B65C06B4; Wed, 19 Oct 2022 16:34:19 -0700 (PDT)
Date:   Wed, 19 Oct 2022 16:34:19 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Zqiang <qiang1.zhang@intel.com>, frederic@kernel.org,
        rcu@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rcu: Make call_rcu() lazy only when CONFIG_RCU_LAZY is
 enabled
Message-ID: <20221019233419.GI5600@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20221019174458.GD5600@paulmck-ThinkPad-P17-Gen-1>
 <6E2C7AC3-9BA6-4C5B-A9D7-59F5F6279177@joelfernandes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6E2C7AC3-9BA6-4C5B-A9D7-59F5F6279177@joelfernandes.org>
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 19, 2022 at 02:25:29PM -0400, Joel Fernandes wrote:
> 
> 
> > On Oct 19, 2022, at 1:45 PM, Paul E. McKenney <paulmck@kernel.org> wrote:
> > 
> > ﻿On Wed, Oct 19, 2022 at 08:12:30AM -0400, Joel Fernandes wrote:
> >>> On Oct 19, 2022, at 8:10 AM, Joel Fernandes <joel@joelfernandes.org> wrote:
> >>>>> On Oct 19, 2022, at 6:34 AM, Zqiang <qiang1.zhang@intel.com> wrote:
> >>>>> 
> >>>>> ﻿Currently, regardless of whether the CONFIG_RCU_LAZY is enabled,
> >>>>> invoke the call_rcu() is always lazy, it also means that when
> >>>>> CONFIG_RCU_LAZY is disabled, invoke the call_rcu_flush() is also
> >>>>> lazy. therefore, this commit make call_rcu() lazy only when
> >>>>> CONFIG_RCU_LAZY is enabled.
> >> 
> >> First, good eyes!  Thank you for spotting this!!
> >>>>> Signed-off-by: Zqiang <qiang1.zhang@intel.com>
> >>>>> ---
> >>>>> kernel/rcu/tree.c | 8 +++++++-
> >>>>> 1 file changed, 7 insertions(+), 1 deletion(-)
> >>>>> 
> >>>>> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> >>>>> index abc615808b6e..97ef602da3d5 100644
> >>>>> --- a/kernel/rcu/tree.c
> >>>>> +++ b/kernel/rcu/tree.c
> >>>>> @@ -2839,7 +2839,6 @@ void call_rcu_flush(struct rcu_head *head, rcu_callback_t func)
> >>>>>  return __call_rcu_common(head, func, false);
> >>>>> }
> >>>>> EXPORT_SYMBOL_GPL(call_rcu_flush);
> >>>>> -#endif
> >>>>> 
> >>>>> /**
> >>>>> * call_rcu() - Queue an RCU callback for invocation after a grace period.
> >>>>> @@ -2890,6 +2889,13 @@ void call_rcu(struct rcu_head *head, rcu_callback_t func)
> >>>>>  return __call_rcu_common(head, func, true);
> >>>>> }
> >>>>> EXPORT_SYMBOL_GPL(call_rcu);
> >>>>> +#else
> >>>>> +void call_rcu(struct rcu_head *head, rcu_callback_t func)
> >>>>> +{
> >>>>> +    return __call_rcu_common(head, func, false);
> >>> 
> >>> Thanks. Instead of adding new function, you can also pass IS_ENABLED(CONFIG…) to the existing function of the same name.
> > 
> > I do like this approach better -- less code, more obvious what is going on.
> 
> Sounds good. Zqiang, do you mind updating your patch along these lines? That way you get the proper attribution.
> 
> More comments below:
> > 
> >>> Looks like though I made every one test the patch without having to enable the config option ;-). Hey, I’m a half glass full kind of guy, why do you ask?
> >>> 
> >>> Paul, I’ll take a closer look once I’m at the desk, but would you prefer to squash a diff into the existing patch, or want a new patch altogether?
> >> 
> >> On the other hand, what I’d want is to nuke the config option altogether or make it default y, we want to catch issues sooner than later.
> > 
> > That might be what we do at some point, but one thing at a time.  Let's
> > not penalize innocent bystanders, at least not just yet.
> 
> It’s a trade off, I thought that’s why we wanted to have the binary search stuff. If no one reports issue on Linux-next, then that code won’t be put to use in the near future at least.

Well, not to put too fine a point on it, but we currently really are
exposing -next to lazy call_rcu().  ;-)

> > I do very strongly encourage the ChromeOS and Android folks to test this
> > very severely, however.
> 
> Agreed. Yes that will happen, though I have to make a note for Android folks other than Vlad, to backports these (and enable the config option), carefully! Especially on pre-5.15 kernels. Luckily I had to do this (not so trivial) exercise myself.

And this is another situation in which the binary search stuff may prove
extremely useful.

							Thanx, Paul

> Thanks!
> 
>  - Joel
> 
> > 
> >                            Thanx, Paul
> > 
> >> Thanks.
> >> 
> >>> 
> >>> Thanks.
> >>> 
> >>> - Joel
> >>> 
> >>> 
> >>>> +}
> >>>> +EXPORT_SYMBOL_GPL(call_rcu);
> >>>> +#endif
> >>>> 
> >>>> /* Maximum number of jiffies to wait before draining a batch. */
> >>>> #define KFREE_DRAIN_JIFFIES (5 * HZ)
> >>>> -- 
> >>>> 2.25.1
> >>>> 
