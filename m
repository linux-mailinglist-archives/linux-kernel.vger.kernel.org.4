Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E97E6F6B1F
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 14:25:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230253AbjEDMZW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 08:25:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229606AbjEDMZU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 08:25:20 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 499745FFE
        for <linux-kernel@vger.kernel.org>; Thu,  4 May 2023 05:24:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1683203074;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/P4j7QRgQZneWQhwJZYK9w8DqMxX3Ha033JwPfj4jik=;
        b=ToDH+svfxX16z7zo7Qm4V/sQkeMn6Rby3mpDyqn2Lpgd23DiNOmS3ZHSOUohKIzcM2M4El
        ZH9VeULZM9WOO7Twcp2ldbzKaMhuAiwIW9w23RiDIfR3BoNIlRP8E4nvPg+KAJFzPP/oKk
        V7Q2VT1iyIFXxijImbyfo1Hdmnez1O0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-623-QwPATtQPNy60_s4Ol1YkBQ-1; Thu, 04 May 2023 08:24:31 -0400
X-MC-Unique: QwPATtQPNy60_s4Ol1YkBQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1BDE4A0F380;
        Thu,  4 May 2023 12:24:30 +0000 (UTC)
Received: from fedora (unknown [10.22.9.13])
        by smtp.corp.redhat.com (Postfix) with SMTP id 5413D407D450;
        Thu,  4 May 2023 12:24:22 +0000 (UTC)
Date:   Thu, 4 May 2023 09:24:21 -0300
From:   Wander Lairson Costa <wander@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Brian Cain <bcain@quicinc.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Christian Brauner <brauner@kernel.org>,
        Andrei Vagin <avagin@gmail.com>,
        Shakeel Butt <shakeelb@google.com>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:PERFORMANCE EVENTS SUBSYSTEM" 
        <linux-perf-users@vger.kernel.org>, Hu Chunyu <chuhu@redhat.com>,
        Paul McKenney <paulmck@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v7 2/3] sched/task: Add the put_task_struct_atomic_safe()
 function
Message-ID: <marq2aq3jvgr6eiuqwq6q5eqcnw3inc3nv2iypcmvlyzcnwvoc@gksrj5pjyfzn>
References: <20230425114307.36889-1-wander@redhat.com>
 <20230425114307.36889-3-wander@redhat.com>
 <20230504084229.GI1734100@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230504084229.GI1734100@hirez.programming.kicks-ass.net>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 04, 2023 at 10:42:29AM +0200, Peter Zijlstra wrote:
> On Tue, Apr 25, 2023 at 08:43:02AM -0300, Wander Lairson Costa wrote:
> > diff --git a/include/linux/sched/task.h b/include/linux/sched/task.h
> > index b597b97b1f8f..cf774b83b2ec 100644
> > --- a/include/linux/sched/task.h
> > +++ b/include/linux/sched/task.h
> > @@ -141,6 +141,41 @@ static inline void put_task_struct_many(struct task_struct *t, int nr)
> >  
> >  void put_task_struct_rcu_user(struct task_struct *task);
> >  
> > +extern void __delayed_put_task_struct(struct rcu_head *rhp);
> > +
> > +static inline void put_task_struct_atomic_safe(struct task_struct *task)
> > +{
> > +	if (IS_ENABLED(CONFIG_PREEMPT_RT)) {
> > +		/*
> > +		 * Decrement the refcount explicitly to avoid unnecessarily
> > +		 * calling call_rcu.
> > +		 */
> > +		if (refcount_dec_and_test(&task->usage))
> > +			/*
> > +			 * under PREEMPT_RT, we can't call put_task_struct
> > +			 * in atomic context because it will indirectly
> > +			 * acquire sleeping locks.
> > +			 * call_rcu() will schedule __delayed_put_task_struct()
> > +			 * to be called in process context.
> > +			 *
> > +			 * __put_task_struct() is called when
> > +			 * refcount_dec_and_test(&t->usage) succeeds.
> > +			 *
> > +			 * This means that it can't conflict with
> > +			 * put_task_struct_rcu_user() which abuses ->rcu the same
> > +			 * way; rcu_users has a reference so task->usage can't be
> > +			 * zero after rcu_users 1 -> 0 transition.
> > +			 *
> > +			 * delayed_free_task() also uses ->rcu, but it is only called
> > +			 * when it fails to fork a process. Therefore, there is no
> > +			 * way it can conflict with put_task_struct().
> > +			 */
> > +			call_rcu(&task->rcu, __delayed_put_task_struct);
> > +	} else {
> > +		put_task_struct(task);
> > +	}
> > +}
> 
> Urgh.. that's plenty horrible. And I'm sure everybody plus kitchen sink
> has already asked why can't we just rcu free the thing unconditionally.
> 
> Google only found me an earlier version of this same patch set, but I'm
> sure we've had that discussion many times over the past several years.
> The above and your follow up patch is just horrible.
> 
> It requires users to know the RT specific context and gives them no help
> what so ever for !RT builds.
> 
> 

No problem, I will send a new version doing it unconditionally.

