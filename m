Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78F6E6C3692
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 17:06:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230462AbjCUQGg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 12:06:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229574AbjCUQGd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 12:06:33 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2F3B241EE
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 09:06:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=LGcrA/92iocLdxzo9zFP6Q6N2Fzda6nnfsrYKDpnP3I=; b=G4JtkLq7UIgsauPSXwxCvBumgw
        U73sYw2F79vPTCOQV8fSsYQnWEJu6AcwphA3j4Vmby2pz9+vSuGi38HCR3lI6AKSTQBeqBmPnA75I
        d4orFkm54FaLe/cb6v6OG8dxQCXCVgutSfrywwyolEeW+tIho1P2Mka/wDXgnIYQk9SjImywupi0Q
        YRlzrvEognLkk5LK+aK0YIOJO73Mbo/s5bQo+pLIs26FtXn18PXyGeO9lsQ5fsmqWSTsnYXyLKzDl
        FKh7/w+esubO5dyEXbLOU3ZeQpoumntoJR0BiWcgg0+3etASWp3BWAMOQI+HS/P4XcCBZdvyRD3i7
        Jrxytadw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1peeTr-004J04-35;
        Tue, 21 Mar 2023 16:05:00 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 7307430006D;
        Tue, 21 Mar 2023 17:04:58 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 5AB3020F030E0; Tue, 21 Mar 2023 17:04:58 +0100 (CET)
Date:   Tue, 21 Mar 2023 17:04:58 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Chen Yu <yu.c.chen@intel.com>
Cc:     mingo@kernel.org, vincent.guittot@linaro.org,
        linux-kernel@vger.kernel.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, corbet@lwn.net,
        qyousef@layalina.io, chris.hyser@oracle.com,
        patrick.bellasi@matbug.net, pjt@google.com, pavel@ucw.cz,
        qperret@google.com, tim.c.chen@linux.intel.com, joshdon@google.com,
        timj@gnu.org, kprateek.nayak@amd.com, youssefesmat@chromium.org,
        joel@joelfernandes.org
Subject: Re: [PATCH 06/10] sched/fair: Add avg_vruntime
Message-ID: <20230321160458.GB2273492@hirez.programming.kicks-ass.net>
References: <20230306132521.968182689@infradead.org>
 <20230306141502.569748782@infradead.org>
 <ZBm39VNJCwioq+V4@chenyu5-mobl1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZBm39VNJCwioq+V4@chenyu5-mobl1>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 21, 2023 at 09:58:13PM +0800, Chen Yu wrote:
> On 2023-03-06 at 14:25:27 +0100, Peter Zijlstra wrote:
> [...]
> >  
> > +/*
> > + * Compute virtual time from the per-task service numbers:
> > + *
> > + * Fair schedulers conserve lag: \Sum lag_i = 0
> > + *
> > + * lag_i = S - s_i = w_i * (V - v_i)
> > + *
> The definination of above lag_i seems to be inconsistent with the defininatin
> of se->lag in PATCH 8. Maybe rename lag_i to something other to avoid confusion?

Yeah, I ran into that the other day, I think I'll introduce vlag_i = V - v_i
or so.

> > + * \Sum lag_i = 0 -> \Sum w_i * (V - v_i) = V * \Sum w_i - \Sum w_i * v_i = 0
> > + *
> > + * From which we solve V:
> > + *
> > + *     \Sum v_i * w_i
> > + * V = --------------
> > + *        \Sum w_i
> > + *
> > + * However, since v_i is u64, and the multiplcation could easily overflow
> > + * transform it into a relative form that uses smaller quantities:
> > + *
> > + * Substitute: v_i == (v_i - v) + v
> > + *
> > + *     \Sum ((v_i - v) + v) * w_i   \Sum (v_i - v) * w_i
> > + * V = -------------------------- = -------------------- + v
> > + *              \Sum w_i                   \Sum w_i
> > + *
> > + *

> Not sure if I understand it correctly, does it mean  (v_i - v) * w_i will not
> overflow? If the weight of task is 15 (nice 19), then if v_i - v > (S64_MAX / 15)
> it gets overflow. Is it possible that v_i is much larger than cfs_rq->min_vruntime
> in this case?

Or worse, SCHED_IDLE, where weight is 2 (IIRC) or cgroups, then vtime
advances at 512 times realtime. Now, the tick puts a limit on how long
we'll overshoot these super low weight entities, for HZ=1000 we still
only get 0.5s of vtime for weight=2.

That would be only 30 bits used, except we use double FIXEDPOINT_SHIFT
on 64bit, so we'll end up at 40-ish.

That should give us enough room to carry an average of deltas around
min_vruntime.

But yes, I've seen this go sideways and I need to stare a bit more at
this. One of the things I've considered is changing the min_vruntime
update rules to instead move to avg_vruntime() to minimize the deltas.
But I've not yet actually written that code.

