Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D53172D334
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 23:24:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236143AbjFLVYP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 17:24:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231325AbjFLVXv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 17:23:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 645D298
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 14:20:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EB87B62114
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 21:20:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5E35C433D2;
        Mon, 12 Jun 2023 21:20:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686604813;
        bh=YWUJnr8a0Tkqtaoozk0a0jjLG56PZ59XEY/xYJc11Z8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ggu6QFPiGAtsCTwrVtX5QenAoe26z/9Xc4vqe+PrCyUjLgr3knSngmEzc8RlzjoyE
         YCIxgQpLGKPWNwogED/1gFSQ/ttBJODEiMr/M56yq7a/+zDO4QkH4ZEeu0eBOoaXAa
         Eer6dHJ/Pi8OO/f1ChyO6s8ALKjZEu2RZMz5gRx1BpyNIUM1fKCyVHyK9eVMUcOF+E
         EM+v3w4pifywK/7u9Z5isJsVSQfV+MUHFMG4hh4Mnv31f/Xor0c4/4FdiSMtfL1e2j
         EUrfrxkCwXUtGZ1zFhnlVqjHWphgoPDcXE4pXmLpUK6cIZyV/ksEX7cQsqT03+FHSD
         gF80HM0bLnl8w==
Date:   Mon, 12 Jun 2023 23:20:10 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Anna-Maria Behnsen <anna-maria@linutronix.de>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        John Stultz <jstultz@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Eric Dumazet <edumazet@google.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Arjan van de Ven <arjan@infradead.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Rik van Riel <riel@surriel.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sebastian Siewior <bigeasy@linutronix.de>,
        Giovanni Gherdovich <ggherdovich@suse.cz>,
        Lukasz Luba <lukasz.luba@arm.com>,
        "Gautham R . Shenoy" <gautham.shenoy@amd.com>
Subject: Re: [PATCH v7 19/21] timer: Implement the hierarchical pull model
Message-ID: <ZIeMCguf4dZsHwB9@localhost.localdomain>
References: <20230524070629.6377-1-anna-maria@linutronix.de>
 <20230524070629.6377-20-anna-maria@linutronix.de>
 <ZIc1LX4Dm2HJ70bZ@2a01cb0980221ec3a67fd23915238df5.ipv6.abo.wanadoo.fr>
 <12d6e6ef-2b8a-7ed2-e386-60c0f4d76683@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <12d6e6ef-2b8a-7ed2-e386-60c0f4d76683@linutronix.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le Mon, Jun 12, 2023 at 05:57:00PM +0200, Anna-Maria Behnsen a écrit :
> Ok. This problem is around only for nohz_full and not for nohz idle?

Only nohz_full right.

> 
> > The crude trick used by nohz_full in order to re-evaluate the dynticks when
> > a timer is queued from the timer softirq is to launch a self IPI (from
> > trigger_dyntick_cpu()). Here you would need something like that but
> > that's not something we wish either.
> > 
> > In fact we don't want any nohz_full CPU to perform an idle migrator job.
> > And the problem here is that whenever a timer interrupt occurs while
> > tmc->idle == 1 (and that _might_ happen in nohz_full), it will go up the
> > hierarchy as long as there is no active migrator on a given level and
> > check for remote expiry. And if something expired it will not only perform
> > the remote callbacks handling but also reprogram the next tick to fire in
> > the next expiry. That's a potential disturbance on a nohz_full CPU.
> > 
> > There is always an active CPU in nohz_full so there is always an active
> > migrator at least at the top level. Therefore you can spare concurrent
> > idle migrators if they are nohz_full.
> >
> 
> As long as the top level group is not/never idle, the wakeup value will be
> KTIME_MAX and so it is no problem for nohz_full cpus - or? The check for
> handling remote expiry is still a problem but please read my proposal for
> this below.

Good point, I overlooked the fact that data->nextevt is only set if the
top level has no migrator.

So the only issue is that a nohz_full CPU may accidentally check/do the
remote expiry as a loose idle migrator. Which can add noise, etc...

> 
> > My suggestion is to make tmigr_requires_handle_remote() return 0 if
> > tick_nohz_full_cpu(smp_processor_id()), so that we don't even bother
> > raising the softirq. But if the timer softirq happens nevertheless, due
> > to some local timer to process, also make tmigr_handle_remote() to
> > return early.
> 
> Regarding this problem and also the two things you mentioned in the two
> earlier review remarks (timer IRQ which fires too early, IPI when CPU goes
> offline), I would propose to use the tmc->wakeup value slightly different
> as it is used right now:
> 
>  - Whenever a wakeup value is required, because top level group is
>    completely idle, the value is set in per CPU tmc struct. It could be
>    then reevaluated in idle code in irq exit path.

So you want to force reevaluation of tmc->wakeup unconditionally on
deactivate time through tmigr_new_timer(), right? That would indeed work
in any case. At the cost of some more overhead in the idle interrupt path,
but perhaps hardly measurable...

The alternative would be to reset tmc->wakeup only when that deadline is
reached in tmigr_requires_handle_remote(). And then have a special case
in the offlining case. That's less pretty of course.

> 
>  - For checking whether remote expiry is required, the wakeup value could
>    also be used.

Right.

> 
>  - For nohz_full CPUs wakeup will be always KTIME_MAX - under the
>    assumption that there is alwasy an active CPU in top level group.

Sounds good!

Thanks.
