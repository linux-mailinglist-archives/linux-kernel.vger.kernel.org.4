Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0DE2609E5C
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 11:56:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229876AbiJXJ4h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 05:56:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbiJXJ4e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 05:56:34 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B50A94E189
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 02:56:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=SV4ZCNuMus3emTndqr5X6EoK99RX3qRV90SrSFqgFCU=; b=HxDMHB3hSAI2PizUjkkN5wDtwP
        cFB+NCRhvN+5wZIxLRZvq+VrgeQoM2oDpp2nb8mo14pEOt77iVNqM3DFzu3XNmJ9pXSA0vZfvylXX
        Z3EDNYiXOw/rZsnNRtdY4m6tY4hRoE+hs9myc00cbqExzMHRd44VkgJhBR3SiW577wee7W1VjsoZB
        HEQoxhKO7hzgdrpPStxw5kx0Y+Nmwa0Hu/Pg2dZFdm5OLchvyJ+eqsNZ+Y8mcWnmvj3pfyQfTEKse
        rFHGbgpz6+YHKcFqwoKjbm0PRXh/68nlLdMofAVdj16s7MFWnl7JbU8wNbEyjw7E2w7AAnI6n/ExP
        ItDjBU7g==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1omuBi-00626M-9Y; Mon, 24 Oct 2022 09:56:06 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 8E0813002AF;
        Mon, 24 Oct 2022 11:56:04 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 654BB2C356CBE; Mon, 24 Oct 2022 11:56:04 +0200 (CEST)
Date:   Mon, 24 Oct 2022 11:56:04 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     hannes@cmpxchg.org, mingo@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, matthias.bgg@gmail.com, minchan@google.com,
        yt.chang@mediatek.com, wenju.xu@mediatek.com,
        jonathan.jmchen@mediatek.com, show-hong.chen@mediatek.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, kernel-team@android.com
Subject: Re: [RESEND PATCH v4 1/1] psi: stop relying on timer_pending for
 poll_work rescheduling
Message-ID: <Y1ZhNDEoX3n9qOpk@hirez.programming.kicks-ass.net>
References: <20221010225744.101629-1-surenb@google.com>
 <CAJuCfpHeJuZBbv-q+WXjgNHwt_caMomFPL3L9rxosXOrZz3fBw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJuCfpHeJuZBbv-q+WXjgNHwt_caMomFPL3L9rxosXOrZz3fBw@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 20, 2022 at 03:25:47PM -0700, Suren Baghdasaryan wrote:
> On Mon, Oct 10, 2022 at 3:57 PM Suren Baghdasaryan <surenb@google.com> wrote:
> >
> > Psi polling mechanism is trying to minimize the number of wakeups to
> > run psi_poll_work and is currently relying on timer_pending() to detect
> > when this work is already scheduled. This provides a window of opportunity
> > for psi_group_change to schedule an immediate psi_poll_work after
> > poll_timer_fn got called but before psi_poll_work could reschedule itself.
> > Below is the depiction of this entire window:
> >
> > poll_timer_fn
> >   wake_up_interruptible(&group->poll_wait);
> >
> > psi_poll_worker
> >   wait_event_interruptible(group->poll_wait, ...)
> >   psi_poll_work
> >     psi_schedule_poll_work
> >       if (timer_pending(&group->poll_timer)) return;
> >       ...
> >       mod_timer(&group->poll_timer, jiffies + delay);
> >
> > Prior to 461daba06bdc we used to rely on poll_scheduled atomic which was
> > reset and set back inside psi_poll_work and therefore this race window
> > was much smaller.
> > The larger window causes increased number of wakeups and our partners
> > report visible power regression of ~10mA after applying 461daba06bdc.
> > Bring back the poll_scheduled atomic and make this race window even
> > narrower by resetting poll_scheduled only when we reach polling expiration
> > time. This does not completely eliminate the possibility of extra wakeups
> > caused by a race with psi_group_change however it will limit it to the
> > worst case scenario of one extra wakeup per every tracking window (0.5s
> > in the worst case).
> > This patch also ensures correct ordering between clearing poll_scheduled
> > flag and obtaining changed_states using memory barrier. Correct ordering
> > between updating changed_states and setting poll_scheduled is ensured by
> > atomic_xchg operation.
> > By tracing the number of immediate rescheduling attempts performed by
> > psi_group_change and the number of these attempts being blocked due to
> > psi monitor being already active, we can assess the effects of this change:
> >
> > Before the patch:
> >                                            Run#1    Run#2      Run#3
> > Immediate reschedules attempted:           684365   1385156    1261240
> > Immediate reschedules blocked:             682846   1381654    1258682
> > Immediate reschedules (delta):             1519     3502       2558
> > Immediate reschedules (% of attempted):    0.22%    0.25%      0.20%
> >
> > After the patch:
> >                                            Run#1    Run#2      Run#3
> > Immediate reschedules attempted:           882244   770298    426218
> > Immediate reschedules blocked:             881996   769796    426074
> > Immediate reschedules (delta):             248      502       144
> > Immediate reschedules (% of attempted):    0.03%    0.07%     0.03%
> >
> > The number of non-blocked immediate reschedules dropped from 0.22-0.25%
> > to 0.03-0.07%. The drop is attributed to the decrease in the race window
> > size and the fact that we allow this race only when psi monitors reach
> > polling window expiration time.
> >
> > Fixes: 461daba06bdc ("psi: eliminate kthread_worker from psi trigger scheduling mechanism")
> > Reported-by: Kathleen Chang <yt.chang@mediatek.com>
> > Reported-by: Wenju Xu <wenju.xu@mediatek.com>
> > Reported-by: Jonathan Chen <jonathan.jmchen@mediatek.com>
> > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> > Tested-by: SH Chen <show-hong.chen@mediatek.com>
> > Acked-by: Johannes Weiner <hannes@cmpxchg.org>
> > ---
> > This patch somehow slipped through the cracks after being acked by Johannes in
> > [1] and I didn't notice it until now because we cherry-picked it into Android
> > kernel trees due to the urgency at that time. On the bright side, this change
> > has been tested for about a year in the field by millions of devices.
> > Resending v4 of this patch previously posted at [2], rebased on the latest
> > Linus' TOT.
> 
> Hi Peter,
> We missed this Ack'ed patch last year and as I described above I
> didn't notice that up until now. With rc1 released, hopefully it's a
> good time to ping you to ask for inclusion of this patch in your tree.
> If the timing is not good, please let me know when to remind you and
> I'll send another email. Just want to make sure it does not slip
> again.
> 
> Just FYI, we have two other Ack'ed PSI patches for you to consider:
> 
> https://lore.kernel.org/all/20221014110551.22695-1-zhouchengming@bytedance.com/
> https://lore.kernel.org/all/20220919072356.GA29069@haolee.io/

Thanks for the poke; I've picked up all three and will place then in
sched/core.
