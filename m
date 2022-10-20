Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07CB760684C
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 20:39:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229967AbiJTSjL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 14:39:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbiJTSjK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 14:39:10 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D8861FAE6A;
        Thu, 20 Oct 2022 11:39:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 4A236CE2781;
        Thu, 20 Oct 2022 18:39:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52297C433D6;
        Thu, 20 Oct 2022 18:39:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666291142;
        bh=2IEnIhsZ/ggObgGJtVdutDm0mfUrlryP2aN6GgYhzbo=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=eoHmo9VrfhPUqdAno6Fc/em/BqOzlL1/Gc1/rY6YH1xU3PnywwH8SMML28C5xWruk
         IJEZdglKxXWbQfDILzcoUPBRhXun3uNFqr1pQbPUJTl5+iOf/+SubSgxc0qIlbc9XT
         Fr2rtyELnHekimMN5kY/u2HV5+rcQtPmssi+5JMnAI1jEi9caowW7eZTrHfsPzNtgX
         zB+rxW9rHx7SdCOqun4XRIRjXV24LpmBHd4C6wKWJi0Okr19J+h3rQ+TZ9DISsUPIm
         ZH1Cnpt9yos3uEDIMxlhMPdah76c6/BN89yNZoNyrq7t5rUmHVMIW8gYNcfycKbYcK
         heCGuc/3eCqFw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id E76A05C0624; Thu, 20 Oct 2022 11:39:01 -0700 (PDT)
Date:   Thu, 20 Oct 2022 11:39:01 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Zqiang <qiang1.zhang@intel.com>, frederic@kernel.org,
        rcu@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rcu: Make call_rcu() lazy only when CONFIG_RCU_LAZY is
 enabled
Message-ID: <20221020183901.GU5600@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20221019233419.GI5600@paulmck-ThinkPad-P17-Gen-1>
 <D7F0EE3F-0A06-4868-87E3-B88B9BD6480C@joelfernandes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <D7F0EE3F-0A06-4868-87E3-B88B9BD6480C@joelfernandes.org>
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 20, 2022 at 04:42:05AM -0400, Joel Fernandes wrote:
> > On Oct 19, 2022, at 7:34 PM, Paul E. McKenney <paulmck@kernel.org> wrote:
> > 
> > ﻿On Wed, Oct 19, 2022 at 02:25:29PM -0400, Joel Fernandes wrote:
> >> 
> >> 
> >>>> On Oct 19, 2022, at 1:45 PM, Paul E. McKenney <paulmck@kernel.org> wrote:
> >>> 
> >>> ﻿On Wed, Oct 19, 2022 at 08:12:30AM -0400, Joel Fernandes wrote:
> >>>>> On Oct 19, 2022, at 8:10 AM, Joel Fernandes <joel@joelfernandes.org> wrote:
> >>>>>>> On Oct 19, 2022, at 6:34 AM, Zqiang <qiang1.zhang@intel.com> wrote:
> >>>>>>> 
> >>>>>>> ﻿Currently, regardless of whether the CONFIG_RCU_LAZY is enabled,
> >>>>>>> invoke the call_rcu() is always lazy, it also means that when
> >>>>>>> CONFIG_RCU_LAZY is disabled, invoke the call_rcu_flush() is also
> >>>>>>> lazy. therefore, this commit make call_rcu() lazy only when
> >>>>>>> CONFIG_RCU_LAZY is enabled.
> >>>> 
> >>>> First, good eyes!  Thank you for spotting this!!
> 
> Indeed.
> 
> >>>>>>> Signed-off-by: Zqiang <qiang1.zhang@intel.com>
> >>>>>>> ---
> >>>>>>> kernel/rcu/tree.c | 8 +++++++-
> >>>>>>> 1 file changed, 7 insertions(+), 1 deletion(-)
> >>>>>>> 
> >>>>>>> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> >>>>>>> index abc615808b6e..97ef602da3d5 100644
> >>>>>>> --- a/kernel/rcu/tree.c
> >>>>>>> +++ b/kernel/rcu/tree.c
> >>>>>>> @@ -2839,7 +2839,6 @@ void call_rcu_flush(struct rcu_head *head, rcu_callback_t func)
> >>>>>>> return __call_rcu_common(head, func, false);
> >>>>>>> }
> >>>>>>> EXPORT_SYMBOL_GPL(call_rcu_flush);
> >>>>>>> -#endif
> >>>>>>> 
> >>>>>>> /**
> >>>>>>> * call_rcu() - Queue an RCU callback for invocation after a grace period.
> >>>>>>> @@ -2890,6 +2889,13 @@ void call_rcu(struct rcu_head *head, rcu_callback_t func)
> >>>>>>> return __call_rcu_common(head, func, true);
> >>>>>>> }
> >>>>>>> EXPORT_SYMBOL_GPL(call_rcu);
> >>>>>>> +#else
> >>>>>>> +void call_rcu(struct rcu_head *head, rcu_callback_t func)
> >>>>>>> +{
> >>>>>>> +    return __call_rcu_common(head, func, false);
> >>>>> 
> >>>>> Thanks. Instead of adding new function, you can also pass IS_ENABLED(CONFIG…) to the existing function of the same name.
> >>> 
> >>> I do like this approach better -- less code, more obvious what is going on.
> >> 
> >> Sounds good. Zqiang, do you mind updating your patch along these lines? That way you get the proper attribution.
> 
> Acked that patch.
> 
> >> More comments below:
> >>> 
> >>>>> Looks like though I made every one test the patch without having to enable the config option ;-). Hey, I’m a half glass full kind of guy, why do you ask?
> >>>>> 
> >>>>> Paul, I’ll take a closer look once I’m at the desk, but would you prefer to squash a diff into the existing patch, or want a new patch altogether?
> >>>> 
> >>>> On the other hand, what I’d want is to nuke the config option altogether or make it default y, we want to catch issues sooner than later.
> >>> 
> >>> That might be what we do at some point, but one thing at a time.  Let's
> >>> not penalize innocent bystanders, at least not just yet.
> >> 
> >> It’s a trade off, I thought that’s why we wanted to have the binary search stuff. If no one reports issue on Linux-next, then that code won’t be put to use in the near future at least.
> > 
> > Well, not to put too fine a point on it, but we currently really are
> > exposing -next to lazy call_rcu().  ;-)
> 
> This is true. I think I assumed nobody will enable a default off config option but I probably meant a smaller percentage will.
> 
> >>> I do very strongly encourage the ChromeOS and Android folks to test this
> >>> very severely, however.
> >> 
> >> Agreed. Yes that will happen, though I have to make a note for Android folks other than Vlad, to backports these (and enable the config option), carefully! Especially on pre-5.15 kernels. Luckily I had to do this (not so trivial) exercise myself.
> > 
> > And this is another situation in which the binary search stuff may prove
> > extremely useful.
> 
> Agreed. Thanks. Very least I owe per-rdp splitting of the hashtable, to that code.  Steven and me talked today that probably the hashtable can go into the rcu_segcblist itself, and protect it by the nocb lock.

I have to ask...

How does this fit in with CPU-hotplug and callback migration?

More to the point, what events would cause us to decide that this is
required?  For example, shouldn't we give your current binary-search
code at least a few chances to save the day?

							Thanx, Paul

> >>>>>> +}
> >>>>>> +EXPORT_SYMBOL_GPL(call_rcu);
> >>>>>> +#endif
> >>>>>> 
> >>>>>> /* Maximum number of jiffies to wait before draining a batch. */
> >>>>>> #define KFREE_DRAIN_JIFFIES (5 * HZ)
> >>>>>> -- 
> >>>>>> 2.25.1
> >>>>>> 
