Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD68C72DCE1
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 10:42:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241758AbjFMImc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 04:42:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241628AbjFMImT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 04:42:19 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 191892954
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 01:41:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=PD0ugoBFvpWR/+a0HA9IOzygd4biSYYN6wBzkBBbZ9w=; b=vAyweJECx5bv+AJFDlVjtNBuk5
        Fs2ypmsEORp4aDCaMxdUYGTOWvTm9J1JgjyMA8CCtPJemOscfFrSDOHUTNZZA6SfmKPQTpkd+/X5Y
        Vph6VxTJpcRtUQD/wF5j0S2MoVEcVlMBdgVhp9LjMS4kwpTKimGC+HJ82rnE2cf3p7KO8H9NBwYAO
        R3xL1MW8iOgxvNf/Va6fH28OcPo/uYF6rDHM10oY8UirB3xKM35vOgwOSJpzXnUSqAE71IAGZqoWT
        W4eq2DkOVYOhCTsvAlvr+RZ4gf8kuKiIqdIH0EORWT9T9yr7Jqguz2Xh8CJwZNI/5pL544bjjsN8N
        bmsdiatg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1q8zaS-003i2m-Jf; Tue, 13 Jun 2023 08:41:12 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 9D3C1300188;
        Tue, 13 Jun 2023 10:41:11 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 746C1262C92A6; Tue, 13 Jun 2023 10:41:11 +0200 (CEST)
Date:   Tue, 13 Jun 2023 10:41:11 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     David Vernet <void@manifault.com>
Cc:     linux-kernel@vger.kernel.org, mingo@redhat.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        rostedt@goodmis.org, dietmar.eggemann@arm.com, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        joshdon@google.com, roman.gushchin@linux.dev, tj@kernel.org,
        kernel-team@meta.com
Subject: Re: [RFC PATCH 3/3] sched: Implement shared wakequeue in CFS
Message-ID: <20230613084111.GS4253@hirez.programming.kicks-ass.net>
References: <20230613052004.2836135-1-void@manifault.com>
 <20230613052004.2836135-4-void@manifault.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230613052004.2836135-4-void@manifault.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 13, 2023 at 12:20:04AM -0500, David Vernet wrote:
> +struct swqueue {
> +	struct list_head list;
> +	spinlock_t lock;
> +} ____cacheline_aligned;
> +
>  #ifdef CONFIG_SMP
> +static struct swqueue *rq_swqueue(struct rq *rq)
> +{
> +	return rq->cfs.swqueue;
> +}
> +
> +static struct task_struct *swqueue_pull_task(struct swqueue *swqueue)
> +{
> +	unsigned long flags;
> +
> +	struct task_struct *p;
> +
> +	spin_lock_irqsave(&swqueue->lock, flags);
> +	p = list_first_entry_or_null(&swqueue->list, struct task_struct,
> +				     swqueue_node);
> +	if (p)
> +		list_del_init(&p->swqueue_node);
> +	spin_unlock_irqrestore(&swqueue->lock, flags);
> +
> +	return p;
> +}
> +
> +static void swqueue_enqueue(struct rq *rq, struct task_struct *p, int enq_flags)
> +{
> +	unsigned long flags;
> +	struct swqueue *swqueue;
> +	bool task_migrated = enq_flags & ENQUEUE_MIGRATED;
> +	bool task_wakeup = enq_flags & ENQUEUE_WAKEUP;
> +
> +	/*
> +	 * Only enqueue the task in the shared wakequeue if:
> +	 *
> +	 * - SWQUEUE is enabled
> +	 * - The task is on the wakeup path
> +	 * - The task wasn't purposefully migrated to the current rq by
> +	 *   select_task_rq()
> +	 * - The task isn't pinned to a specific CPU
> +	 */
> +	if (!task_wakeup || task_migrated || p->nr_cpus_allowed == 1)
> +		return;
> +
> +	swqueue = rq_swqueue(rq);
> +	spin_lock_irqsave(&swqueue->lock, flags);
> +	list_add_tail(&p->swqueue_node, &swqueue->list);
> +	spin_unlock_irqrestore(&swqueue->lock, flags);
> +}
> +
>  static int swqueue_pick_next_task(struct rq *rq, struct rq_flags *rf)
>  {
> -	return 0;
> +	struct swqueue *swqueue;
> +	struct task_struct *p = NULL;
> +	struct rq *src_rq;
> +	struct rq_flags src_rf;
> +	int ret;
> +
> +	swqueue = rq_swqueue(rq);
> +	if (!list_empty(&swqueue->list))
> +		p = swqueue_pull_task(swqueue);
> +
> +	if (!p)
> +		return 0;
> +
> +	rq_unpin_lock(rq, rf);
> +	raw_spin_rq_unlock(rq);
> +
> +	src_rq = task_rq_lock(p, &src_rf);
> +
> +	if (task_on_rq_queued(p) && !task_on_cpu(rq, p))
> +		src_rq = migrate_task_to(src_rq, &src_rf, p, cpu_of(rq));
> +
> +	if (src_rq->cpu != rq->cpu)
> +		ret = 1;
> +	else
> +		ret = -1;
> +
> +	task_rq_unlock(src_rq, p, &src_rf);
> +
> +	raw_spin_rq_lock(rq);
> +	rq_repin_lock(rq, rf);
> +
> +	return ret;
>  }
>  
>  static void swqueue_remove_task(struct task_struct *p)
> -{}
> +{
> +	unsigned long flags;
> +	struct swqueue *swqueue;
> +
> +	if (!list_empty(&p->swqueue_node)) {
> +		swqueue = rq_swqueue(task_rq(p));
> +		spin_lock_irqsave(&swqueue->lock, flags);
> +		list_del_init(&p->swqueue_node);
> +		spin_unlock_irqrestore(&swqueue->lock, flags);
> +	}
> +}
>  
>  /*
>   * For asym packing, by default the lower numbered CPU has higher priority.

*sigh*... pretty much all, if not all of this is called with rq->lock
held. So why the irqsave and big fat fail for using spinlock :-(
