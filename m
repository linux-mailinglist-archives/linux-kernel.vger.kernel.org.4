Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FABF6CD423
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 10:13:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229791AbjC2INV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 04:13:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbjC2INT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 04:13:19 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD3512135
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 01:13:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=W40vDHtoJmObncWgxYoxKYDsKdaYlYAC6KyZk/aXhEM=; b=cGP9/a7d4e0owfavrz97c1MxwJ
        eB4dcA6xv5FEnRa/jZ2GdG4ULvOzil+V7NCeweB/YWOJqsTvF5ZsVQvPDrvrA1pIiVXU8B//HYxoe
        aft0CTx754Ibfr/CLms1xs3boxMfUzoPcPuOceCtj9dRsnqca4xU84wDS2jei/k30tiiVB5BhUcie
        GXFSHF89EmMy/NydvdDhtLqOqBeArAR3uVCYpJp6rn/ymOTqs/H5kM1NySZEKkWQj7+nfgQx1owPp
        9wYmDuW7DhZhjg3dADtG6t9EXez+y2BhFY/PYn/Kamu1yiPYNsdjYlj76obeb5I5n7wJE7UOoQ8kj
        RbCngG1A==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1phQvC-006na0-18;
        Wed, 29 Mar 2023 08:12:43 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 41DF8300379;
        Wed, 29 Mar 2023 10:12:39 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 207E0200C122E; Wed, 29 Mar 2023 10:12:39 +0200 (CEST)
Date:   Wed, 29 Mar 2023 10:12:39 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Josh Don <joshdon@google.com>
Cc:     mingo@kernel.org, vincent.guittot@linaro.org,
        linux-kernel@vger.kernel.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, corbet@lwn.net,
        qyousef@layalina.io, chris.hyser@oracle.com,
        patrick.bellasi@matbug.net, pjt@google.com, pavel@ucw.cz,
        qperret@google.com, tim.c.chen@linux.intel.com, timj@gnu.org,
        kprateek.nayak@amd.com, yu.c.chen@intel.com,
        youssefesmat@chromium.org, joel@joelfernandes.org, efault@gmx.de
Subject: Re: [PATCH 08/17] sched/fair: Implement an EEVDF like policy
Message-ID: <20230329081239.GM4253@hirez.programming.kicks-ass.net>
References: <20230328092622.062917921@infradead.org>
 <20230328110354.141543852@infradead.org>
 <CABk29Nt4T67S+L9Qs1qeOUyo5gY1Qy5KuOwuCYNM74E58J81Eg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABk29Nt4T67S+L9Qs1qeOUyo5gY1Qy5KuOwuCYNM74E58J81Eg@mail.gmail.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 28, 2023 at 06:26:51PM -0700, Josh Don wrote:

> > @@ -5088,19 +5307,20 @@ dequeue_entity(struct cfs_rq *cfs_rq, st
> >  static void
> >  check_preempt_tick(struct cfs_rq *cfs_rq, struct sched_entity *curr)
> >  {
> > -       unsigned long ideal_runtime, delta_exec;
> > +       unsigned long delta_exec;
> >         struct sched_entity *se;
> >         s64 delta;
> >
> > -       /*
> > -        * When many tasks blow up the sched_period; it is possible that
> > -        * sched_slice() reports unusually large results (when many tasks are
> > -        * very light for example). Therefore impose a maximum.
> > -        */
> > -       ideal_runtime = min_t(u64, sched_slice(cfs_rq, curr), sysctl_sched_latency);
> > +       if (sched_feat(EEVDF)) {
> > +               if (pick_eevdf(cfs_rq) != curr)
> > +                       goto preempt;
> 
> This could shortcircuit the loop in pick_eevdf once we find a best
> that has less vruntime and sooner deadline than curr, since we know
> we'll never pick curr in that case. Might help performance when we
> have a large tree for this cfs_rq.

Yeah, one of the things I did consider was having this set cfs_rq->next
such that the reschedule pick doesn't have to do the pick again. But I
figured keep things simple for now.

