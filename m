Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1E6972055D
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 17:07:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236346AbjFBPHO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 11:07:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236232AbjFBPHL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 11:07:11 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B85AE123
        for <linux-kernel@vger.kernel.org>; Fri,  2 Jun 2023 08:07:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=2P/0VkzKVJOS1cOc/XDmvQmJB9iQarOFqgM5/wR+Ai4=; b=eCmOR2tXH2SWjYhaCSBEjU1MQ6
        Iyf/I/bwPuO6rRl1vGydlK+izGSEw4CIJ2bMDJLy3T4xQW7Q//E+12jpF8WYUZHMZ1ncuBoIXAc83
        v2WYN8axL1PxG8WFBao9GFOH90GhZP9U8Q8tf7uTjirHd7EdPQnrCbMfuK9SYOy76B0dFnzCIrQGD
        7V1yMB2uGaSNY9f6om42TRWnzoUePrU/L4AEGbAUZAM3qDSRieji5XLT+gLS+eAUC956tGgtynd/y
        3ZRZw1d52W+X8en1umKxsF3sMY2QpJn7rQnA4vcw0OYL/SJgY0k58kkJc80Zij/kBYnoSzOnDj+Tn
        ZTLukxug==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1q56MO-001MIW-07;
        Fri, 02 Jun 2023 15:06:36 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id DA3553002F0;
        Fri,  2 Jun 2023 17:06:33 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id C0E91202BDCAE; Fri,  2 Jun 2023 17:06:33 +0200 (CEST)
Date:   Fri, 2 Jun 2023 17:06:33 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     mingo@kernel.org, linux-kernel@vger.kernel.org,
        juri.lelli@redhat.com, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, corbet@lwn.net, qyousef@layalina.io,
        chris.hyser@oracle.com, patrick.bellasi@matbug.net, pjt@google.com,
        pavel@ucw.cz, qperret@google.com, tim.c.chen@linux.intel.com,
        joshdon@google.com, timj@gnu.org, kprateek.nayak@amd.com,
        yu.c.chen@intel.com, youssefesmat@chromium.org,
        joel@joelfernandes.org, efault@gmx.de, tglx@linutronix.de
Subject: Re: [PATCH 11/15] sched/eevdf: Better handle mixed slice length
Message-ID: <20230602150633.GJ620383@hirez.programming.kicks-ass.net>
References: <20230531115839.089944915@infradead.org>
 <20230531124604.341527144@infradead.org>
 <CAKfTPtCnEdPpZSu3=t4tTEm-nWEwkyTwQuTLngcgABhcMGWvZA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKfTPtCnEdPpZSu3=t4tTEm-nWEwkyTwQuTLngcgABhcMGWvZA@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 02, 2023 at 03:45:18PM +0200, Vincent Guittot wrote:
> On Wed, 31 May 2023 at 14:47, Peter Zijlstra <peterz@infradead.org> wrote:

> > +static inline bool
> > +entity_has_slept(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
> > +{
> > +       u64 now;
> > +
> > +       if (!(flags & ENQUEUE_WAKEUP))
> > +               return false;
> > +
> > +       if (flags & ENQUEUE_MIGRATED)
> > +               return true;
> > +
> > +       now = rq_clock_task(rq_of(cfs_rq));
> > +       return (s64)(se->exec_start - now) >= se->slice;
> > +}
> > +
> >  static void
> >  place_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
> >  {
> > @@ -4930,6 +4947,19 @@ place_entity(struct cfs_rq *cfs_rq, stru
> >                 lag = se->vlag;
> >
> >                 /*
> > +                * For latency sensitive tasks; those that have a shorter than
> > +                * average slice and do not fully consume the slice, transition
> > +                * to EEVDF placement strategy #2.
> > +                */
> > +               if (sched_feat(PLACE_FUDGE) &&
> > +                   (cfs_rq->avg_slice > se->slice * cfs_rq->avg_load) &&
> > +                   entity_has_slept(cfs_rq, se, flags)) {
> > +                       lag += vslice;
> > +                       if (lag > 0)
> > +                               lag = 0;
> 
> This PLACE_FUDGE looks quite not a good heuristic because it breaks
> the better fair sharing of cpu bandwidth that EEVDF is supposed to
> bring. Furthermore, it breaks the isolation between cpu bandwidth and
> latency because playing with latency_nice will impact your cpu
> bandwidth

Yeah, probably :/ Even though entity_has_slept() ensures the task slept
for at least one slice, that's probably not enough to preserve the
bandwidth contraints.

The fairness analysis in the paper conveniently avoids all 'interesting'
cases, including their own placement policies.

I'll sit on this one longer and think a bit more about it.
