Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7506074EB0E
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 11:46:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231395AbjGKJqY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 05:46:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231201AbjGKJqW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 05:46:22 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0F07A1
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 02:46:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=zpa+DwUgXhfw23ATtzr9y8HfeT093YZc/Ka29TN/0Wk=; b=EilLBq57mEejxsVUVLHBms8YGC
        H8cQXR4SkYlcjQ09cwk5Kb1gxld3j1/3J1QdsQRmqp/QYMbJl3iZpJuIinUHwqafmbIt/lmqMVfIg
        gTPe8K9mPBm8qajsDjcZJJhYDPqggCOAK5PcD5H7gtFdQXqGi5ej2eL3Rq4L3qIDzbQhVXq1vF253
        wp/4oCVEdIdR4fXbU5tGecMtKrlno53zcnzdwiFqZa/+MuIux3TYL0e9FHM4sz0LehZyoDAp/nyxm
        Vyp0/T9NtQsaNCDB2iBtqSYSciKDBneDx0jjm3phkoNTdUNeqM2LgKupwg3cNB6EIcA9NKUk5h/Eu
        ei+n3eWQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qJ9wL-00Fb1p-NT; Tue, 11 Jul 2023 09:45:49 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 9CA39300155;
        Tue, 11 Jul 2023 11:45:47 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 7E822240EBDB4; Tue, 11 Jul 2023 11:45:47 +0200 (CEST)
Date:   Tue, 11 Jul 2023 11:45:47 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     David Vernet <void@manifault.com>
Cc:     linux-kernel@vger.kernel.org, mingo@redhat.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        gautham.shenoy@amd.com, kprateek.nayak@amd.com, aaron.lu@intel.com,
        clm@meta.com, tj@kernel.org, roman.gushchin@linux.dev,
        kernel-team@meta.com
Subject: Re: [PATCH v2 4/7] sched/fair: Add SHARED_RUNQ sched feature and
 skeleton calls
Message-ID: <20230711094547.GE3062772@hirez.programming.kicks-ass.net>
References: <20230710200342.358255-1-void@manifault.com>
 <20230710200342.358255-5-void@manifault.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230710200342.358255-5-void@manifault.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 10, 2023 at 03:03:39PM -0500, David Vernet wrote:

> @@ -11843,6 +11871,9 @@ static int newidle_balance(struct rq *this_rq, struct rq_flags *rf)
>  	if (!cpu_active(this_cpu))
>  		return 0;
>  
> +	if (sched_feat(SHARED_RUNQ) && shared_runq_pick_next_task(this_rq, rf))
> +		return -1;
> +

Next patch implements shared_runq_pick_next_task() with the same return
values as newidle_balance(), which would seem to suggest the following
instead:

	if (sched_feat(SHARED_RUNQ)) {
		pulled_task = shared_runq_pick_next_task(this_rq, rf);
		if (pulled_task)
			return pulled_task;
	}

Additionally, I think we wants something like:

	sd = rcu_dereference_check_sched_domain(this_rq->sd);
	if (sched_feat(SHARED_RUNQ)) {
		... /* see above */

		sd = rcu_dereference(*this_cpu_ptr(&sd_llc));
		sd = sd->parent;
	}

to ensure we skip <=LLC domains, since those have already been covered
by this shiny new thing, no?
