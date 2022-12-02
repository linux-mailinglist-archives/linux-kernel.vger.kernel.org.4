Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9700A64072F
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 13:54:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232776AbiLBMya (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 07:54:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231493AbiLBMy1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 07:54:27 -0500
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C65E0CCFFD;
        Fri,  2 Dec 2022 04:54:22 -0800 (PST)
Received: by mail-lf1-x129.google.com with SMTP id g7so7271621lfv.5;
        Fri, 02 Dec 2022 04:54:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=l9W1Hv3Dlzb+WKX0QBUokG3jGm+nbrLB+SsrtoKPZC8=;
        b=mAPHioh/WkhX60/wzurR2vy6uSenQmrj+wr0AFqtKNO6AlsiDL0nH+iHfwETlTPLXo
         gtdDKPMC32GIIUOFvuR5m7P40dqR8hkQOIbIZ7rATKqrpXo+2fwD4qgJAMDSrq6JMWZi
         6C+Y47maD4U628qsYWDmkNAtR0mnlFZgVNGP7LmpgHufbWpYBuRnRFFopKU+taR/ugqj
         /ohEmMhsx0Yw5S/xC1Qnoda0V5Nt5BJgHRrRRJQhZCFZOA4yoPD5n45AsxyP7U1du28T
         4ODdPRDsPlD/qfZrrk5mUxP+zgeBHYQR7n8riA1q1ymViI++KB2EA5oOn+pAvRt8jM9J
         SrrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l9W1Hv3Dlzb+WKX0QBUokG3jGm+nbrLB+SsrtoKPZC8=;
        b=nRmYuHZCxLHlUVFuup3JAzJ60OxQlMNp9RNiQ7VNquBqL4tVQATzJU6zWMG8VDhiY2
         Fl2CYaOHfnRVVXQmcQPvSNTl4t8k/oIxlPiMwkvYSKrgSzDYzIss1Klkp9b7mkl3N+4I
         Su3BbHnNo8/GW3s8Fu9G+QVrBmjaE3VOWewkeBsXd4P9CMb+ask0DZDJUUGsgUBzFsFK
         t0vXE+lRaYSqpiaNH0FQDzMRlUPkMiH3mwiuWYQw5tu1UhR0xAiFBMK8JB0JroZtPI6x
         iPsAi1O7BqYmAaOsw4ptlecHG1iQtKpK6rz36glY1BJkHjFqpfkjXPgBlC3xyZgHpSH+
         lItw==
X-Gm-Message-State: ANoB5pmBN+fydHQ22rkaLdWaV8GA4QrhefP4cFjEfROq7zjpSwXO4AWd
        aYaszBQFNsPqyHPvT7EgFaU=
X-Google-Smtp-Source: AA0mqf5rn83kHn099TvB8lfM9nKMCyv8U/6IX3kqf5nUWh1zjvYYfKErQ3tw3VNvDKMDegFA5ntMVg==
X-Received: by 2002:a05:6512:2512:b0:4ac:9008:482 with SMTP id be18-20020a056512251200b004ac90080482mr23209924lfb.402.1669985660873;
        Fri, 02 Dec 2022 04:54:20 -0800 (PST)
Received: from pc636 (host-90-235-25-230.mobileonline.telia.com. [90.235.25.230])
        by smtp.gmail.com with ESMTPSA id d10-20020a056512368a00b004972b0bb426sm1011377lfs.257.2022.12.02.04.54.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Dec 2022 04:54:20 -0800 (PST)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Fri, 2 Dec 2022 13:54:17 +0100
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>, RCU <rcu@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <neeraj.iitr10@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>
Subject: Re: [PATCH v2 4/4] rcu/kvfree: Use a polled API to speedup a reclaim
 process
Message-ID: <Y4n1eWpLMkaEGxtP@pc636>
References: <20221129155822.538434-1-urezki@gmail.com>
 <20221129155822.538434-5-urezki@gmail.com>
 <20221201234559.GA1520591@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221201234559.GA1520591@paulmck-ThinkPad-P17-Gen-1>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> A couple more questions interspersed below upon further reflection.
> 
> Thoughts?
> 
See below my thoughts:

> 						Thanx, Paul
> 
> > ---
> >  kernel/rcu/tree.c | 47 +++++++++++++++++++++++++++++++++++++++--------
> >  1 file changed, 39 insertions(+), 8 deletions(-)
> > 
> > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> > index c94c17194299..44279ca488ef 100644
> > --- a/kernel/rcu/tree.c
> > +++ b/kernel/rcu/tree.c
> > @@ -2741,11 +2741,13 @@ EXPORT_SYMBOL_GPL(call_rcu);
> >  /**
> >   * struct kvfree_rcu_bulk_data - single block to store kvfree_rcu() pointers
> >   * @list: List node. All blocks are linked between each other
> > + * @gp_snap: Snapshot of RCU state for objects placed to this bulk
> >   * @nr_records: Number of active pointers in the array
> >   * @records: Array of the kvfree_rcu() pointers
> >   */
> >  struct kvfree_rcu_bulk_data {
> >  	struct list_head list;
> > +	unsigned long gp_snap;
> >  	unsigned long nr_records;
> >  	void *records[];
> >  };
> > @@ -2762,13 +2764,15 @@ struct kvfree_rcu_bulk_data {
> >   * struct kfree_rcu_cpu_work - single batch of kfree_rcu() requests
> >   * @rcu_work: Let queue_rcu_work() invoke workqueue handler after grace period
> >   * @head_free: List of kfree_rcu() objects waiting for a grace period
> > + * @head_free_gp_snap: Snapshot of RCU state for objects placed to "@head_free"
> >   * @bulk_head_free: Bulk-List of kvfree_rcu() objects waiting for a grace period
> >   * @krcp: Pointer to @kfree_rcu_cpu structure
> >   */
> >  
> >  struct kfree_rcu_cpu_work {
> > -	struct rcu_work rcu_work;
> > +	struct work_struct rcu_work;
> >  	struct rcu_head *head_free;
> > +	unsigned long head_free_gp_snap;
> >  	struct list_head bulk_head_free[FREE_N_CHANNELS];
> >  	struct kfree_rcu_cpu *krcp;
> >  };
> > @@ -2964,10 +2968,11 @@ static void kfree_rcu_work(struct work_struct *work)
> >  	struct rcu_head *head;
> >  	struct kfree_rcu_cpu *krcp;
> >  	struct kfree_rcu_cpu_work *krwp;
> > +	unsigned long head_free_gp_snap;
> >  	int i;
> >  
> > -	krwp = container_of(to_rcu_work(work),
> > -			    struct kfree_rcu_cpu_work, rcu_work);
> > +	krwp = container_of(work,
> > +		struct kfree_rcu_cpu_work, rcu_work);
> >  	krcp = krwp->krcp;
> >  
> >  	raw_spin_lock_irqsave(&krcp->lock, flags);
> > @@ -2978,12 +2983,29 @@ static void kfree_rcu_work(struct work_struct *work)
> >  	// Channel 3.
> >  	head = krwp->head_free;
> >  	krwp->head_free = NULL;
> > +	head_free_gp_snap = krwp->head_free_gp_snap;
> >  	raw_spin_unlock_irqrestore(&krcp->lock, flags);
> >  
> >  	// Handle the first two channels.
> > -	for (i = 0; i < FREE_N_CHANNELS; i++)
> > +	for (i = 0; i < FREE_N_CHANNELS; i++) {
> > +		// Start from the tail page, so a GP is likely passed for it.
> > +		list_for_each_entry_safe_reverse(bnode, n, &bulk_head[i], list) {
> > +			// Not yet ready? Bail out since we need one more GP.
> > +			if (!poll_state_synchronize_rcu(bnode->gp_snap))
> > +				break;
> > +
> > +			list_del_init(&bnode->list);
> > +			kvfree_rcu_bulk(krcp, bnode, i);
> > +		}
> > +
> > +		// Please note a request for one more extra GP can
> > +		// occur only once for all objects in this batch.
> > +		if (!list_empty(&bulk_head[i]))
> > +			synchronize_rcu();
> 
> Does directly invoking synchronize_rcu() instead of using queue_rcu_work()
> provide benefits, for example, reduced memory footprint?
>
queue_rcu_work() will delay freeing of all objects in a batch. We can
make use of it but it should be only for the ones which still require
a grace period. A memory footprint and a time depends on when our
callback is invoked by the RCU-core to queue the reclaim work.

Such time can be long, because it depends on many factors:

- scheduling delays in waking gp;
- scheduling delays in kicking nocb;
- delays in waiting in a "cblist":
    - dequeuing and invoking f(rhp);
- delay in waking our final reclaim work and giving it a CPU time.

This patch combines a possibility to reclaim asap for objects which
passed a grace period and requesting one more GP for the ones which
have not passed it yet.

>
> If not, it would be good to instead use queue_rcu_work() in order
> to avoid an unnecessary context switch in this workqueue handler.
>
I went by the most easiest way from code perspective since i do not
see problems with a current approach from testing and personal point
of views.

If we are about to do that i need to add extra logic to split ready
and not ready pointers for direct reclaim and the rest over the
queu_rcu_work().

I can check how it goes.

> 
> My concern is that an RCU CPU stall might otherwise end up tying up more
> workqueue kthreads as well as more memory.
> 
There is a limit. We have two batches, one work for each. Suppose the
reclaim kthread is stuck in synchronize_rcu() so it does not do any
progress. In this case same work can be only in pending state and
nothing more no matter how many times the queue_work() is invoked:

2 * num_possible_cpus();

If we end up in RCU stall we will not be able to reclaim anyway.

--
Uladzislau Rezki
