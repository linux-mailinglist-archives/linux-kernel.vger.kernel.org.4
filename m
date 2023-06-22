Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54ACA73A3B9
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 16:54:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231609AbjFVOyC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 10:54:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232035AbjFVOx5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 10:53:57 -0400
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E3741BD7
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 07:53:56 -0700 (PDT)
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-763ddd51fcaso144144885a.0
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 07:53:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687445635; x=1690037635;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HX1RrWwW/NnSibUvG9uG8DYWqPYoRChsIEknMNwezRw=;
        b=QpmzyKKYtgcbe8KZy7IrrTsvQzaTTXkavIgWxl6bf8mrbXxKbaSzTvESljQQs2YQu2
         oTaliUmh1+K6zxZxUXdL6R0tiNzWWOghNwZE04cl6YmgB4f/Tl+GK/dHEpEeGxjb/vts
         zAEDa5q5X+zGiZ48wYwcv0m0j7BGJzIvZDVS6v/3C7MklXin0AIdRItaf+IEI1hjHm+M
         LELwj7tZnqPf0LNzc+a+vIJZZRqXlBsQKga24glIQyOdshxD9p1UEgBNJ9wJachBBv5E
         8aQOe1UqI85CHE29jIb0V+ejPk9FnTcQ3IHahvSm7xAQfjxUNtHoXGlxkhT2bHfBNwxB
         bPWw==
X-Gm-Message-State: AC+VfDz/5J6KrdHkY0vZrP8cGjN4dXiiIZ8ehf5VXNYZ7KI90H3IkgAI
        2DDbLIm/AZZb8LQNprO0nQA=
X-Google-Smtp-Source: ACHHUZ5qn2qnX6rwGnsABFXV1o4Mnc2E/tIQBtmZMkcNN4FM1TDTZPE2rV4BaK0UqDG17dlYjXGtdw==
X-Received: by 2002:ad4:5ba4:0:b0:632:952:4778 with SMTP id 4-20020ad45ba4000000b0063209524778mr7656809qvq.46.1687445635152;
        Thu, 22 Jun 2023 07:53:55 -0700 (PDT)
Received: from maniforge ([2620:10d:c091:400::5:d965])
        by smtp.gmail.com with ESMTPSA id b9-20020a0cc989000000b0062821057ac7sm3886332qvk.39.2023.06.22.07.53.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jun 2023 07:53:54 -0700 (PDT)
Date:   Thu, 22 Jun 2023 09:53:52 -0500
From:   David Vernet <void@manifault.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, mingo@redhat.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        rostedt@goodmis.org, dietmar.eggemann@arm.com, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        joshdon@google.com, roman.gushchin@linux.dev, tj@kernel.org,
        kernel-team@meta.com
Subject: Re: [RFC PATCH 2/3] sched/fair: Add SWQUEUE sched feature and
 skeleton calls
Message-ID: <20230622145352.GB113759@maniforge>
References: <20230613052004.2836135-1-void@manifault.com>
 <20230613052004.2836135-3-void@manifault.com>
 <20230621124933.GE2053369@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230621124933.GE2053369@hirez.programming.kicks-ass.net>
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

On Wed, Jun 21, 2023 at 02:49:33PM +0200, Peter Zijlstra wrote:
> On Tue, Jun 13, 2023 at 12:20:03AM -0500, David Vernet wrote:
> 
> I can't help but read this thing as software-queue :/ Can we please pick
> a better name?

Yes, I'll think of a better one. Suggestions welcome if you have a
preference.

> > @@ -6368,6 +6390,9 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
> >  	if (!task_new)
> >  		update_overutilized_status(rq);
> >  
> > +	if (sched_feat(SWQUEUE))
> > +		swqueue_enqueue(rq, p, flags);
> > +
> >  enqueue_throttle:
> >  	assert_list_leaf_cfs_rq(rq);
> >  
> > @@ -6449,6 +6474,9 @@ static void dequeue_task_fair(struct rq *rq, struct task_struct *p, int flags)
> >  dequeue_throttle:
> >  	util_est_update(&rq->cfs, p, task_sleep);
> >  	hrtick_update(rq);
> > +
> > +	if (sched_feat(SWQUEUE))
> > +		swqueue_remove_task(p);
> >  }
> >  
> >  #ifdef CONFIG_SMP
> 
> _enqueue() should obviously be complemented by _dequeue(). This naming
> is offensive :-)

Ack

> > @@ -8155,12 +8183,18 @@ done: __maybe_unused;
> >  
> >  	update_misfit_status(p, rq);
> >  
> > +	if (sched_feat(SWQUEUE))
> > +		swqueue_remove_task(p);
> > +
> >  	return p;
> >  
> >  idle:
> >  	if (!rf)
> >  		return NULL;
> >  
> > +	if (sched_feat(SWQUEUE) && swqueue_pick_next_task(rq, rf))
> > +		return RETRY_TASK;
> > +
> >  	new_tasks = newidle_balance(rq, rf);
> >  
> >  	/*
> 
> That's either not correct or insufficient or both.
> 
> It fails to consider the whole core-scheduling mess. But it also fails
> to consider the regular (non optimized) pick case that should do newidle
> through put_prev_task_balance() -> balance_fair().
> 
> I think placing the pick call in newidle_balance() itself is the
> simplest solution.

Yep, not sure where I went off the rails here -- the pick call clearly
belongs in newidle_balance(). I'll also make sure we handle core sched
correctly as well. Thanks for pointing those out.
