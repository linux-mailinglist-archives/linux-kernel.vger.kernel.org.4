Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9F8A730926
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 22:26:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236157AbjFNU0d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 16:26:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229889AbjFNU0b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 16:26:31 -0400
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB2872116
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 13:26:29 -0700 (PDT)
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-62de1a3e354so22063756d6.3
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 13:26:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686774389; x=1689366389;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=em1IKDNT20+10FhYEXO378gTthD1d4n1/JfncF+AfPo=;
        b=UWRqumFCWr77dO4gT+58GS23r/RmdKx3hDHfddsdEtWNjezg6XD7gOWgqk9qzjq/cC
         miW83uFv8+POhaxkLWyYq1z9lWP07eqFuYoYyKoZRpiOmCp6/vV/cFFB6gPQGy9lbIdM
         CuI2ttkJM9DRZrPKMDfu69bWvbhgcaoC0RhBluimcTZhkAwl0JoyOiBHRaOcl0Dh2j+r
         Bt2f1ydSoAAglKRvXcE2dPSR1sPBj+ycboptUairUHABoULUOrj45ONndHATaXCfaW8Q
         c2lX1izltDS9LkmAGnOItN3a95tzmNZT/j5it1lndpKus4G7CQtMFnb3uKRkbw3NVHJG
         zKyg==
X-Gm-Message-State: AC+VfDx4B9QF35h39m2Cqb5TfieSNRi0DhWonUuWUJaIrSTx7Rq4sh0S
        jvE8di+kjAq1ca6dih2hCZ8=
X-Google-Smtp-Source: ACHHUZ4IfiY76OK41ddNTg5F0tLit0fSdi0O2GTiYxzx6cPM6ASuvIjecc6U3ub1r3pgaIh1/lmhsQ==
X-Received: by 2002:ad4:5fce:0:b0:625:a982:857 with SMTP id jq14-20020ad45fce000000b00625a9820857mr18637924qvb.50.1686774388731;
        Wed, 14 Jun 2023 13:26:28 -0700 (PDT)
Received: from maniforge ([24.1.27.177])
        by smtp.gmail.com with ESMTPSA id h2-20020a0cf442000000b00623927281c2sm5002728qvm.40.2023.06.14.13.26.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jun 2023 13:26:28 -0700 (PDT)
Date:   Wed, 14 Jun 2023 15:26:25 -0500
From:   David Vernet <void@manifault.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, mingo@redhat.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        rostedt@goodmis.org, dietmar.eggemann@arm.com, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        joshdon@google.com, roman.gushchin@linux.dev, tj@kernel.org,
        kernel-team@meta.com
Subject: Re: [RFC PATCH 3/3] sched: Implement shared wakequeue in CFS
Message-ID: <20230614202625.GB2883716@maniforge>
References: <20230613052004.2836135-1-void@manifault.com>
 <20230613052004.2836135-4-void@manifault.com>
 <20230613084111.GS4253@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230613084111.GS4253@hirez.programming.kicks-ass.net>
User-Agent: Mutt/2.2.10 (2023-03-25)
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 13, 2023 at 10:41:11AM +0200, Peter Zijlstra wrote:
> On Tue, Jun 13, 2023 at 12:20:04AM -0500, David Vernet wrote:
> > +struct swqueue {
> > +	struct list_head list;
> > +	spinlock_t lock;
> > +} ____cacheline_aligned;
> > +
> >  #ifdef CONFIG_SMP
> > +static struct swqueue *rq_swqueue(struct rq *rq)
> > +{
> > +	return rq->cfs.swqueue;
> > +}
> > +
> > +static struct task_struct *swqueue_pull_task(struct swqueue *swqueue)
> > +{
> > +	unsigned long flags;
> > +
> > +	struct task_struct *p;
> > +
> > +	spin_lock_irqsave(&swqueue->lock, flags);
> > +	p = list_first_entry_or_null(&swqueue->list, struct task_struct,
> > +				     swqueue_node);
> > +	if (p)
> > +		list_del_init(&p->swqueue_node);
> > +	spin_unlock_irqrestore(&swqueue->lock, flags);
> > +
> > +	return p;
> > +}
> > +
> > +static void swqueue_enqueue(struct rq *rq, struct task_struct *p, int enq_flags)
> > +{
> > +	unsigned long flags;
> > +	struct swqueue *swqueue;
> > +	bool task_migrated = enq_flags & ENQUEUE_MIGRATED;
> > +	bool task_wakeup = enq_flags & ENQUEUE_WAKEUP;
> > +
> > +	/*
> > +	 * Only enqueue the task in the shared wakequeue if:
> > +	 *
> > +	 * - SWQUEUE is enabled
> > +	 * - The task is on the wakeup path
> > +	 * - The task wasn't purposefully migrated to the current rq by
> > +	 *   select_task_rq()
> > +	 * - The task isn't pinned to a specific CPU
> > +	 */
> > +	if (!task_wakeup || task_migrated || p->nr_cpus_allowed == 1)
> > +		return;
> > +
> > +	swqueue = rq_swqueue(rq);
> > +	spin_lock_irqsave(&swqueue->lock, flags);
> > +	list_add_tail(&p->swqueue_node, &swqueue->list);
> > +	spin_unlock_irqrestore(&swqueue->lock, flags);
> > +}
> > +
> >  static int swqueue_pick_next_task(struct rq *rq, struct rq_flags *rf)
> >  {
> > -	return 0;
> > +	struct swqueue *swqueue;
> > +	struct task_struct *p = NULL;
> > +	struct rq *src_rq;
> > +	struct rq_flags src_rf;
> > +	int ret;
> > +
> > +	swqueue = rq_swqueue(rq);
> > +	if (!list_empty(&swqueue->list))
> > +		p = swqueue_pull_task(swqueue);
> > +
> > +	if (!p)
> > +		return 0;
> > +
> > +	rq_unpin_lock(rq, rf);
> > +	raw_spin_rq_unlock(rq);
> > +
> > +	src_rq = task_rq_lock(p, &src_rf);
> > +
> > +	if (task_on_rq_queued(p) && !task_on_cpu(rq, p))
> > +		src_rq = migrate_task_to(src_rq, &src_rf, p, cpu_of(rq));
> > +
> > +	if (src_rq->cpu != rq->cpu)
> > +		ret = 1;
> > +	else
> > +		ret = -1;
> > +
> > +	task_rq_unlock(src_rq, p, &src_rf);
> > +
> > +	raw_spin_rq_lock(rq);
> > +	rq_repin_lock(rq, rf);
> > +
> > +	return ret;
> >  }
> >  
> >  static void swqueue_remove_task(struct task_struct *p)
> > -{}
> > +{
> > +	unsigned long flags;
> > +	struct swqueue *swqueue;
> > +
> > +	if (!list_empty(&p->swqueue_node)) {
> > +		swqueue = rq_swqueue(task_rq(p));
> > +		spin_lock_irqsave(&swqueue->lock, flags);
> > +		list_del_init(&p->swqueue_node);
> > +		spin_unlock_irqrestore(&swqueue->lock, flags);
> > +	}
> > +}
> >  
> >  /*
> >   * For asym packing, by default the lower numbered CPU has higher priority.
> 
> *sigh*... pretty much all, if not all of this is called with rq->lock
> held. So why the irqsave and big fat fail for using spinlock :-(

Hi Peter,

Thanks for the quick review. Yeah good call about the irq's -- looks
like we're holding an rq lock on all swqueue paths so we can just use a
raw spinlock. I'll make that change for v2.

Regarding the per-swqueue spinlock being a potential bottleneck, I'll
reply to Aaron's thread on [0] with some numbers I collected locally on
a 26 core / 52 thread Cooperlake host, and a 20/40 x 2 Skylake. The
TL;DR is that I'm not observing the spinlock be contended on either
netperf or kernel compile workloads, with swqueue actually performing
~1 - 2% better than non-swqueue on both of these hosts for netperf.

[0]: https://lore.kernel.org/all/20230614043529.GA1942@ziqianlu-dell/

Thanks,
David
