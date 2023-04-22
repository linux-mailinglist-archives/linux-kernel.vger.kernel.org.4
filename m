Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A03596EB89B
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Apr 2023 12:42:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229815AbjDVKmX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Apr 2023 06:42:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbjDVKmV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Apr 2023 06:42:21 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 035FC171C
        for <linux-kernel@vger.kernel.org>; Sat, 22 Apr 2023 03:42:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=nTBRzrCFMJSyQV3xF+3c2r7V805pGMBvCif9qSRYP6U=; b=I/OmNk/6ia8kuizDRcqmISarq/
        VI0CPyYAQ7iK6sj2K5lj7lMZFE5+Pg/gGC1/l89ozHCejHiF8CuqzyDCOfrI9In/SGG5sJIyF3ssn
        oWsir7QQ4RERRTuEt0jH5N5TTyi7fi+mz0RcGrdWD3Rhc7vij+gl2Wxy1pGM5r9REXZU9fgO0Cnqd
        pqSb4b5Tyd4fvSy50oNu5eXVvS3sTtjTAst/qJpmSOA3ToWhNz6KHxJ+2DDptnRAq1ooifILq469S
        Epkp6h5eD1AU74CyqFeoPrvdM668A0Hrpb3L/Vdul6/owy87NG8MJVpO/H/9MfYJNJkflaJuLpPY0
        D7UyHKtQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pqAgv-006D2A-36;
        Sat, 22 Apr 2023 10:42:06 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 6F62D3000DC;
        Sat, 22 Apr 2023 12:42:05 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 2CA2E206D2924; Sat, 22 Apr 2023 12:42:05 +0200 (CEST)
Date:   Sat, 22 Apr 2023 12:42:05 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     John Stultz <jstultz@google.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Joel Fernandes <joelaf@google.com>,
        Qais Yousef <qyousef@google.com>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>,
        Zimuzo Ezeozue <zezeozue@google.com>,
        Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: Re: [PATCH v3 08/14] sched: Replace rq->curr access w/ rq_curr(rq)
Message-ID: <20230422104205.GF1214746@hirez.programming.kicks-ass.net>
References: <20230411042511.1606592-1-jstultz@google.com>
 <20230411042511.1606592-9-jstultz@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230411042511.1606592-9-jstultz@google.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 11, 2023 at 04:25:05AM +0000, John Stultz wrote:
> +static inline struct task_struct *rq_curr(struct rq *rq)
> +{
> +	return rq->curr_exec;
> +}
> +
> +static inline struct task_struct *rq_curr_rcu(struct rq *rq)
> +{
> +	return rcu_dereference(rq->curr_exec);
> +}
> +
> +static inline struct task_struct *rq_curr_once(struct rq *rq)
> +{
> +	return READ_ONCE(rq->curr_exec);
> +}
> +
> +static inline void rq_set_curr(struct rq *rq, struct task_struct *task)
> +{
> +	rcu_assign_pointer(rq->curr_exec, task);
> +}
> +
> +/*
> + *  XXX jstultz: seems like rcu_assign_pointer above would also
> + *               work for this, but trying to match usage.
> + */
> +static inline void rq_set_curr_rcu_init(struct rq *rq, struct task_struct *task)
> +{
> +	RCU_INIT_POINTER(rq->curr_exec, task);
> +}

> +static inline struct task_struct *rq_selected(struct rq *rq)
> +{
> +       return rq->curr_sched;
> +}
> +
> +static inline struct task_struct *rq_selected_rcu(struct rq *rq)
> +{
> +       return rcu_dereference(rq->curr_sched);
> +}
> +
> +static inline struct task_struct *rq_selected_once(struct rq *rq)
> +{
> +       return READ_ONCE(rq->curr_sched);
> +}
> +
> +static inline void rq_set_selected(struct rq *rq, struct task_struct *t)
> +{
> +       rcu_assign_pointer(rq->curr_sched, t);
> +}

How is any of that helping? That's just making it harder to read.

Can we please just keep it rq->curr and rq->proxy and stop this wrapper
fettish.
