Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E7D96F7702
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 22:30:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232852AbjEDUau (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 16:30:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229944AbjEDUaa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 16:30:30 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3138818DD0
        for <linux-kernel@vger.kernel.org>; Thu,  4 May 2023 13:17:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1683231397;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/CxSMEostxLiZatH9TiyyAVyAfzpb47ON2iWXP0TsyU=;
        b=JP2kKC9NQjC41ZbJ11djvXtjIG+kzuXxc9LenPQDh1z/1zLiORZ7AsA92jjQYg7NLDLtYZ
        fxopjmtlv7fKzMIMXLl/Ta1AGPyEoE9MgcYAbirjw9TyHww64ND0xXLndS+DvBjBg1oqhv
        SXVqhML4NY0wiOn4nNisCZ63Fsir0ME=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-643-LonMkh6yNXuoi5co3KfoZQ-1; Thu, 04 May 2023 16:16:36 -0400
X-MC-Unique: LonMkh6yNXuoi5co3KfoZQ-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7460D3810B1A;
        Thu,  4 May 2023 20:16:34 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.225.24])
        by smtp.corp.redhat.com (Postfix) with SMTP id 1AA82492C13;
        Thu,  4 May 2023 20:16:26 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Thu,  4 May 2023 22:16:22 +0200 (CEST)
Date:   Thu, 4 May 2023 22:16:14 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     Wander Lairson Costa <wander@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
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
Message-ID: <20230504201614.GB4164@redhat.com>
References: <20230425114307.36889-1-wander@redhat.com>
 <20230425114307.36889-3-wander@redhat.com>
 <20230504084229.GI1734100@hirez.programming.kicks-ass.net>
 <20230504122945.GA28757@redhat.com>
 <20230504143303.GA1744142@hirez.programming.kicks-ass.net>
 <CAAq0SUmYrQbS1k9NNKGQP7hQRQJ308dk9NCiUimEiLeBJUavgA@mail.gmail.com>
 <20230504152306.GA1135@redhat.com>
 <CAAq0SU=G0WQBLP77Wgm8MJRcVwUCj25WOowh_X8jiGiHTKAQEA@mail.gmail.com>
 <20230504192246.GA4164@redhat.com>
 <CAAq0SUkJ40OeS3cRzhK3voGquJ1AFahYoyQ1fgWS+N=DkOQpig@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAAq0SUkJ40OeS3cRzhK3voGquJ1AFahYoyQ1fgWS+N=DkOQpig@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Wander,

I certainly missed something ;) plus I am already sleeping. but let me try to
reply anyway.

On 05/04, Wander Lairson Costa wrote:
> On Thu, May 4, 2023 at 4:23 PM Oleg Nesterov <oleg@redhat.com> wrote:
> >
> > On 05/04, Wander Lairson Costa wrote:
> > >
> > > On Thu, May 4, 2023 at 12:23 PM Oleg Nesterov <oleg@redhat.com> wrote:
> > > >
> > > > Yes, but as Sebastian explained CONFIG_PROVE_RAW_LOCK_NESTING won't like it.
> > > >
> > > >         https://lore.kernel.org/all/Y+zFNrCjBn53%2F+Q2@linutronix.de/
> > > >
> > >
> > > I think that was my confusion in that thread. My understanding is that
> > > CONFIG_PROVE_RAW_LOCK_NESTING will check lock ordering but not
> > > context.
> >
> > Sorry, I don't understand... perhaps I missed something. But iiuc
> > the problem is simple.
> >
> > So, this code
> >
> >         raw_spin_lock(one);
> >         spin_lock(two);
> >
> > is obviously wrong if CONFIG_PREEMPT_RT.
> >
> > Without PREEMPT_RT this code is fine because raw_spinlock_t and spinlock_t
> > are the same thing. Except they have different lockdep annotations if
> > CONFIG_PROVE_RAW_LOCK_NESTING is true, LD_WAIT_SPIN and LD_WAIT_CONFIG.
> >
> > So if CONFIG_PROVE_RAW_LOCK_NESTING is set, lockdep will complain even
> > on the !PREEMPT_RT kernel, iow it checks the nesting as if the code runs
> > on with PREEMPT_RT.
> >
> > Cough... not sure my explanation can help ;) It looks very confusing when
> > I read it.
> >
>
> Thanks for the explanation. That's my understanding too. The part I
> don't get is why this would fail with a call_rcu() inside
> put_task_struct().

the problem is that call_rcu() won't be called if !IS_ENABLED(PREEMPT_RT),
___put_task_struct() will be called.

CONFIG_PROVE_RAW_LOCK_NESTING can't know this can't happen if PREEMPT_RT
is set.

IOW. To simplify, suppose we have

	// can be called in atomic context, e.g. under
	// raw_spin_lock() so it is wrong with PREEMPT_RT
	void __put_task_struct(struct task_struct *tsk)
	{
		spin_lock(some_lock);
	}

lets "fix" the code above, lets change __put_task_struct,

	void __put_task_struct(struct task_struct *tsk)
	{
		if (!IS_ENABLED(CONFIG_PREEMPT_RT))
			return;

		spin_lock(some_lock);
	}

Now, if CONFIG_PREEMPT_RT is true then __put_task_struct() is fine
wrt lock nesting.

But, if CONFIG_PREEMPT_RT is not set, then __put_task_struct() still
does the same:

	void __put_task_struct(struct task_struct *tsk)
	{
		spin_lock(some_lock);
	}

and CONFIG_PROVE_RAW_LOCK_NESTING will complain. Because, once again,
it checks the nesting as if CONFIG_PREEMPT_RT is true, and in this case
__put_task_struct() if it is called under raw_spin_lock().

Oleg.

