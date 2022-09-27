Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A81915EC155
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 13:29:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229962AbiI0L3I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 07:29:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232064AbiI0L14 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 07:27:56 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBCAA14D325
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 04:26:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=h/MydmqVDnPt6+f27hhhnktf+VsTmJD1gi7+Db/6BfI=; b=DzERKva0wO6ot7cHj4artBe64N
        14uwKlXGuxUGglPtEUdPWdJK3aFNEfGa5QA5jj5+7SeJCnStNP2SSmL2RPeL444vtpR4+wz1reEhb
        EbcI1g5V+L1JMWUVQnDgRCj8Q81OhosysNmYh+Br/uppOS5sutNHN30q6bT0H5rP8LIIFpdQCvIjc
        wmdzhFjt1jjw/LAYdiyFcqCEmzEi2AnwOnGqjAP+ioQdbxb9wiYLWrOKUuo/kTeUvQmAzGt1JuEUu
        0Wbk5KY7U6aV0UZlG/f2Y+N2AtBjZ1T6M39S8OWyc186M7Y0GGmBEvEz4n5ohzSDCoCLfkBpueN7t
        F6nC3gww==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1od8is-00GH6W-Aw; Tue, 27 Sep 2022 11:25:58 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 3C9A630024D;
        Tue, 27 Sep 2022 13:25:57 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 1E7F22BDDB529; Tue, 27 Sep 2022 13:25:57 +0200 (CEST)
Date:   Tue, 27 Sep 2022 13:25:57 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Cc:     Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Ricardo Neri <ricardo.neri@intel.com>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Ben Segall <bsegall@google.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Len Brown <len.brown@intel.com>, Mel Gorman <mgorman@suse.de>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Valentin Schneider <vschneid@redhat.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, "Tim C . Chen" <tim.c.chen@intel.com>
Subject: Re: [RFC PATCH 10/23] sched/fair: Use classes of tasks when
 selecting a busiest runqueue
Message-ID: <YzLdxS3dXCHq+bLa@hirez.programming.kicks-ass.net>
References: <20220909231205.14009-1-ricardo.neri-calderon@linux.intel.com>
 <20220909231205.14009-11-ricardo.neri-calderon@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220909231205.14009-11-ricardo.neri-calderon@linux.intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 09, 2022 at 04:11:52PM -0700, Ricardo Neri wrote:

> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 7368a0b453ee..085b1f75d90b 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -10009,6 +10009,7 @@ static struct rq *find_busiest_queue(struct lb_env *env,
>  	int i;
>  
>  	for_each_cpu_and(i, sched_group_span(group), env->cpus) {
> +		int busiest_class_delta_score = INT_MIN;

You sure you want to break ties toward a negative IPC 'improvement' ?

>  		unsigned long capacity, load, util;
>  		unsigned int nr_running;
>  		enum fbq_type rt;
> @@ -10118,6 +10119,20 @@ static struct rq *find_busiest_queue(struct lb_env *env,
>  			if (busiest_nr < nr_running) {
>  				busiest_nr = nr_running;
>  				busiest = rq;
> +			} else if (sched_task_classes_enabled() &&
> +				   busiest_nr == nr_running) {
> +				int curr_class_delta_score;
> +
> +				curr_class_delta_score = arch_get_task_class_score(rq->curr->class,
> +										   env->dst_cpu) -
> +							 arch_get_task_class_score(rq->curr->class,
> +										   cpu_of(rq));

*sigh*, you really couldn't find a more ugly layout if you tried.

Perhaps use less than novella length identifiers?

> +
> +				if (busiest_class_delta_score < curr_class_delta_score) {
> +					busiest_class_delta_score = curr_class_delta_score;
> +					busiest_nr = nr_running;
> +					busiest = rq;
> +				}
>  			}
>  			break;


