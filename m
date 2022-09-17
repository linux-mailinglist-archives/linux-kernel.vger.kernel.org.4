Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E18F5BBAD7
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Sep 2022 00:21:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229528AbiIQWVS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Sep 2022 18:21:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbiIQWVP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Sep 2022 18:21:15 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12BC72B1B9;
        Sat, 17 Sep 2022 15:21:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id AFCC0B80E23;
        Sat, 17 Sep 2022 22:21:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03BB5C433C1;
        Sat, 17 Sep 2022 22:21:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663453271;
        bh=QcxphjV+XpiadsnUCmiAF/lR0/3egacEFo2hy+/98aI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XV0BDaJ7/ze7SY1yMcUjQoxz4oB4xm/ZXGo0k0A2Au7nmJcl5XFZiIb4BEpIY3tfi
         aJpWfegWuS6kx+L4JEQRxWE8uVdW5r8TX+2p1Cx6WGqPa8zDVkej8CL2ghfETFLu22
         ec/0WjJoHFRf80d3wwMkSzjL3yR0yp148YPzaCg2gCIo0jbMa7g/p1xR17ULd+NJ/S
         63fZtWdgsNNLIN1Smc2XuoNzJU3MidP4tfbXugVkHKv5ii65BzZfGlYjT0wLDwqG0z
         IVoKfgCf93nDlhHEmAdUwJtfIOfphvZQPhnPh8fvoJxmGJilPwzHewmoNVr5l10WYu
         w7gLQJRm7GnKw==
Date:   Sun, 18 Sep 2022 00:21:08 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Neeraj upadhyay <neeraj.iitr10@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, rcu <rcu@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Rushikesh S Kadam <rushikesh.s.kadam@intel.com>,
        "Uladzislau Rezki (Sony)" <urezki@gmail.com>
Subject: Re: [PATCH rcu/next 3/3] rcu: Call trace_rcu_callback() also for
 bypass queuing (v2)
Message-ID: <20220917222108.GB40100@lothringen>
References: <20220917164200.511783-1-joel@joelfernandes.org>
 <20220917164200.511783-4-joel@joelfernandes.org>
 <20220917195807.GA39579@lothringen>
 <CAEXW_YQxwDF5jhS9gdLa0FsNeD+WoZL0PQydMbT4hsUtLm0hMA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEXW_YQxwDF5jhS9gdLa0FsNeD+WoZL0PQydMbT4hsUtLm0hMA@mail.gmail.com>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 17, 2022 at 05:43:06PM -0400, Joel Fernandes wrote:
> On Sat, Sep 17, 2022 at 3:58 PM Frederic Weisbecker <frederic@kernel.org> wrote:
> >
> > On Sat, Sep 17, 2022 at 04:42:00PM +0000, Joel Fernandes (Google) wrote:
> > > @@ -2809,17 +2825,15 @@ void call_rcu(struct rcu_head *head, rcu_callback_t func)
> > >       }
> > >
> > >       check_cb_ovld(rdp);
> > > -     if (rcu_nocb_try_bypass(rdp, head, &was_alldone, flags))
> > > +
> > > +     if (rcu_nocb_try_bypass(rdp, head, &was_alldone, flags)) {
> > > +             __trace_rcu_callback(head, rdp);
> > >               return; // Enqueued onto ->nocb_bypass, so just leave.
> > > +     }
> >
> > I think the bypass enqueues should be treated differently. Either with extending
> > the current trace_rcu_callback/trace_rcu_kvfree_callback (might break tools)
> >
> > or
> > with creating a new trace_rcu_callback_bypass()/trace_rcu_kvfree_callback_bypass().
> >
> > Those could later be paired with a trace_rcu_bypass_flush().
> 
> I am having a hard time seeing why it should be treated differently.
> We already increment the length of the main segcblist even when
> bypassing. Why not just call the trace point instead of omitting it?

I'm not suggesting to omit it. I'm suggesting to improve its precision.

> Otherwise it becomes a bit confusing IMO (say someone does not enable
> your proposed new bypass tracepoint and only enables the existing one,
> then they would see weird traces where call_rcu is called but their
> traces are missing trace_rcu_callback).

Well, if they decided to see only half of the information...

> Not to mention - your
> suggestion will also complicate writing tools that use the existing
> rcu_callback tracepoint to monitor call_rcu().

If we add another tracepoint, the prototype will be the same as the
existing one, not many lines to add. If instead we extend the existing
tracepoint, it's merely just a flag to check or ignore.

OTOH your suggestion doesn't provide any bypass related information.

> 
> Also if you see the definition of rcu_callback, "Tracepoint for the
> registration of a single RCU callback function.".  That pretty much
> fits the usage here.

Doesn't tell if it's a bypass or not.

> 
> As for tracing of the flushing, I don’t care about tracing that at the
> moment using tracepoints

You will soon enough ;-)

> but I don’t mind if it is added later.
> Maybe let’s let Paul help resolve our disagreement on this one? :)

FWIW, I would be personally interested in such tracepoints (or the extension
of the existing ones, whichever way you guys prefer), they would be of great help
for debugging.

Also if rcu_top is ever released, I really hope the kernel will be ready in
case we want the tool to display bypass related informations.

Please be careful while designing tracepoints that may be consumed by userspace
released tools. Such tracepoints eventually turn into ABI and there is no way
back after that.

Thanks.
