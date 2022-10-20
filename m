Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B64E606B21
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 00:17:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229911AbiJTWRQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 18:17:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229843AbiJTWRM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 18:17:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3316A219FDD;
        Thu, 20 Oct 2022 15:17:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C3A8261D40;
        Thu, 20 Oct 2022 22:17:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29C46C433D6;
        Thu, 20 Oct 2022 22:17:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666304230;
        bh=Il3d0PlX0wY6nzksO56o3AO8e9bOL8S6BjAlHket0ug=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=jd41YewXS1bdCjMK58vj9ft4COtTK5GVIjLuBXrSQzggVFdwxOEDlSGnLXPLopykT
         ZGXWTuUA8j9vDuvx3WwAboeAFWj8F+RZaDC77DkSPGcaMlS34cnYOMhD7TAmFV9VX2
         Ry+zqeOa+uJiFbtS1BBm4JXR5N4Xzq6G3Zq/KHVeddOSlH3EjVpZ/5fkrBXjRyA82g
         03oicmFFS1N8ffnTOM2kj4QZ/h8WYvXfzRqw9kJ+NB01rMk1P1iq5yOIGQmbMXT56f
         aYuaorvNHsAssCdNf+gH+sLrU/nMNXU2on16O0A68B51DQb+/rhEcMl9t+DAkbFGF1
         dxd/j5Kg5dlRA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id C29315C1109; Thu, 20 Oct 2022 15:17:09 -0700 (PDT)
Date:   Thu, 20 Oct 2022 15:17:09 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Zqiang <qiang1.zhang@intel.com>, frederic@kernel.org,
        rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH] rcu: Make call_rcu() lazy only when CONFIG_RCU_LAZY is
 enabled
Message-ID: <20221020221709.GX5600@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <95331C23-3632-4E0B-9959-43CE159FE60F@joelfernandes.org>
 <DC93C5EB-91A5-4291-A642-8A57179930E4@joelfernandes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <DC93C5EB-91A5-4291-A642-8A57179930E4@joelfernandes.org>
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 20, 2022 at 05:33:37PM -0400, Joel Fernandes wrote:
> 
> 
> > On Oct 20, 2022, at 2:46 PM, Joel Fernandes <joel@joelfernandes.org> wrote:
> >>> 
> >>>>> More comments below:
> >>>>>> 
> >>>>>>>> Looks like though I made every one test the patch without having to enable the config option ;-). Hey, I’m a half glass full kind of guy, why do you ask?
> >>>>>>>> 
> >>>>>>>> Paul, I’ll take a closer look once I’m at the desk, but would you prefer to squash a diff into the existing patch, or want a new patch altogether?
> >>>>>>> 
> >>>>>>> On the other hand, what I’d want is to nuke the config option altogether or make it default y, we want to catch issues sooner than later.
> >>>>>> 
> >>>>>> That might be what we do at some point, but one thing at a time.  Let's
> >>>>>> not penalize innocent bystanders, at least not just yet.
> >>>>> 
> >>>>> It’s a trade off, I thought that’s why we wanted to have the binary search stuff. If no one reports issue on Linux-next, then that code won’t be put to use in the near future at least.
> >>>> 
> >>>> Well, not to put too fine a point on it, but we currently really are
> >>>> exposing -next to lazy call_rcu().  ;-)
> >>> 
> >>> This is true. I think I assumed nobody will enable a default off config option but I probably meant a smaller percentage will.
> >>> 
> >>>>>> I do very strongly encourage the ChromeOS and Android folks to test this
> >>>>>> very severely, however.
> >>>>> 
> >>>>> Agreed. Yes that will happen, though I have to make a note for Android folks other than Vlad, to backports these (and enable the config option), carefully! Especially on pre-5.15 kernels. Luckily I had to do this (not so trivial) exercise myself.
> >>>> 
> >>>> And this is another situation in which the binary search stuff may prove
> >>>> extremely useful.
> >>> 
> >>> Agreed. Thanks. Very least I owe per-rdp splitting of the hashtable, to that code.  Steven and me talked today that probably the hashtable can go into the rcu_segcblist itself, and protect it by the nocb lock.
> >> 
> >> I have to ask...
> >> 
> >> How does this fit in with CPU-hotplug and callback migration?
> > 
> > Yes it will require change and I already thought of that, have to update the hashtable on all such events.
> > 
> >> More to the point, what events would cause us to decide that this is
> >> required?  For example, shouldn't we give your current binary-search
> >> code at least a few chances to save the day?
> > 
> > Totally, if you’re taking the patch as is, I would be very happy. And I’ll continue to improve it with the above. But I was not sure yet if you’re taking it.
> > 
> > I think it’s a worthwhile to take it for mainline in the current state and I’ll also add more data about callbacks to it in future (queuing time of callback, etc) — basically all the stuff I wanted to add to rcu_head.
> > 
> > One reason for the above proposal is I also want to keep it turned on in production, and the current solution cannot be, due to the global locking and is not expected to be kept on in production. But is still a worthwhile addition for debug kernels IMO.
> 
> I realized while talking to Steve that the hashtable has to be per CPU if we are to store more than a lazy flag, such as queuing timestamps. This is because you can have multiple callbacks of the same function pointer queued on multiple CPUs. So you can have multiple timestamps to store. Same thing if we stored automata. It’s per callback instance, not per callback function.

Agreed, to be useful, this must be per callback instance.

							Thanx, Paul

> Thanks,
> 
>  - Joel
> 
> 
> > 
> > Thanks,
> > 
> > - Joel
> > 
> > 
> >>                           Thanx, Paul
> >> 
> >>>>>>>>> +}
> >>>>>>>>> +EXPORT_SYMBOL_GPL(call_rcu);
> >>>>>>>>> +#endif
> >>>>>>>>> 
> >>>>>>>>> /* Maximum number of jiffies to wait before draining a batch. */
> >>>>>>>>> #define KFREE_DRAIN_JIFFIES (5 * HZ)
> >>>>>>>>> -- 
> >>>>>>>>> 2.25.1
> >>>>>>>>> 
