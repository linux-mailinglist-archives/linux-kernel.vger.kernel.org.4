Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A73BE66BBD0
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 11:34:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230320AbjAPKeq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 05:34:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230384AbjAPKec (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 05:34:32 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E8AD1ABE5
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 02:34:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=MgQ9FPXfMxLwxsk75gwYk68V1T/CXWg4RyfCf7l9qgU=; b=iQOgFIqZh0V/5D35t/qkSS9y2C
        r+hK+gz4WpRAbB+AtzHFcwHXGz6Ac3NS+hJydMh67XloEtibm18Ok8ceV5cl0+tJcKh7lQgdQ+Saz
        BlWpq+pSBJoP6dj0GH6MT1dpqRdlyFWlxg5fYwhfXmdsRKf6iSJrzv2vPQbHuCjXdlz81bPmcdnCo
        deCdfO3nJArbS6WMO78A/gv9bdmRtfO2/csqQha9Qs3ImlF6h2+S4oVPwhCWepSFsvWG6YWOvu7GN
        d1CNopgOWr0GfcwEUvfCz2FpIeH+yKcUjz7FBOxQ0dLTMrFeXagePX7vopN6nj8Y+g1Sj17LglsHV
        g/PdFPOw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pHMoC-008eKr-8k; Mon, 16 Jan 2023 10:33:45 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id A4F58300642;
        Mon, 16 Jan 2023 11:33:26 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 8853420D30489; Mon, 16 Jan 2023 11:33:26 +0100 (CET)
Date:   Mon, 16 Jan 2023 11:33:26 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     Chen Yu <yu.c.chen@intel.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Tim Chen <tim.c.chen@intel.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Juri Lelli <juri.lelli@redhat.com>,
        Rik van Riel <riel@surriel.com>,
        Aaron Lu <aaron.lu@intel.com>,
        Abel Wu <wuyun.abel@bytedance.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        Yicong Yang <yangyicong@hisilicon.com>,
        "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
        Ingo Molnar <mingo@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Hillf Danton <hdanton@sina.com>,
        Honglei Wang <wanghonglei@didichuxing.com>,
        Len Brown <len.brown@intel.com>,
        Chen Yu <yu.chen.surf@gmail.com>,
        Tianchen Ding <dtcccc@linux.alibaba.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Josh Don <joshdon@google.com>, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v4 1/2] sched/fair: Introduce short duration task
 check
Message-ID: <Y8Un9nmJauxpuSVE@hirez.programming.kicks-ass.net>
References: <cover.1671158588.git.yu.c.chen@intel.com>
 <ec049fd9b635f76a9e1d1ad380fd9184ebeeca53.1671158588.git.yu.c.chen@intel.com>
 <82689dd6-9db1-dd00-069b-73a637a21126@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <82689dd6-9db1-dd00-069b-73a637a21126@arm.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 05, 2023 at 12:33:16PM +0100, Dietmar Eggemann wrote:
> On 16/12/2022 07:11, Chen Yu wrote:
> 
> [...]
> 
> > @@ -5995,6 +6005,18 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
> >  
> >  static void set_next_buddy(struct sched_entity *se);
> >  
> > +static inline void dur_avg_update(struct task_struct *p, bool task_sleep)
> > +{
> > +	u64 dur;
> > +
> > +	if (!task_sleep)
> > +		return;
> > +
> > +	dur = p->se.sum_exec_runtime - p->se.prev_sum_exec_runtime_vol;
> > +	p->se.prev_sum_exec_runtime_vol = p->se.sum_exec_runtime;
> 
> Shouldn't se->prev_sum_exec_runtime_vol be set in enqueue_task_fair()
> and not in dequeue_task_fair()->dur_avg_update()? Otherwise `dur` will
> contain sleep time.
> 
> Like we do for se->prev_sum_exec_runtime in set_next_entity() but for
> one `set_next_entity()-put_prev_entity()` run section.
> 
> AFAICS, you want to measure the exec_runtime sum over all run sections
> between enqueue and dequeue.

You were thinking of the dynamic PELT window size thread? (which is what
I had to think of when I looked at this).

I think we can still do that with this prev_sum_exec_runtime_vol (can't
say I love the name though). At any point (assuming we update
sum_exec_runtime) sum_exec_runtime - prev_sum_exec_runtime_vol is the
duration of the current activation.
