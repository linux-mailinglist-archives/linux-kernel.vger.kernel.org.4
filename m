Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C081B74EBFA
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 12:50:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231210AbjGKKuf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 06:50:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229903AbjGKKud (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 06:50:33 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA56EE74
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 03:50:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ecCqrheGFPVMgRUOdp7TQlIig7O7kKKA9pd8sM96z/Y=; b=Rf3KwuXMbgkJzpPw9km4D9JP+n
        zaJ41Gw8OMgHlAq79Tqm1Kb+33M0rCt/koRJvDD6u6QacHrWzrsqmSCwSZDGYThs9EpSqYnGFIVm7
        ZoQKdqTK/q4womBZXDUJ23QK1Hb6bRs37icmmO7mjFRoc4+ZsXDcJm7K3rOJJhzDY+AFg5ASiXAsX
        qM8wkUBOy+lxALSxqKqQaOlo0Gr46eO/ITBil1R7g7G6pSQBEWT9u/Vp1Wo+E0pCVf/Q3IOFFbSkZ
        5/y2sNXwmJjd1eQmiXPLxLZ8+zrmGDAqKa23efFMWCVmt8Dw5ry7vuPg6sHjpv0sS+gtywhfn+jWC
        OVqoT0vQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qJAwU-002NAX-09;
        Tue, 11 Jul 2023 10:50:02 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 2B1C930036B;
        Tue, 11 Jul 2023 12:49:59 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 12982243429D0; Tue, 11 Jul 2023 12:49:59 +0200 (CEST)
Date:   Tue, 11 Jul 2023 12:49:58 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     David Vernet <void@manifault.com>
Cc:     linux-kernel@vger.kernel.org, mingo@redhat.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        gautham.shenoy@amd.com, kprateek.nayak@amd.com, aaron.lu@intel.com,
        clm@meta.com, tj@kernel.org, roman.gushchin@linux.dev,
        kernel-team@meta.com
Subject: Re: [PATCH v2 6/7] sched: Shard per-LLC shared runqueues
Message-ID: <20230711104958.GG3062772@hirez.programming.kicks-ass.net>
References: <20230710200342.358255-1-void@manifault.com>
 <20230710200342.358255-7-void@manifault.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230710200342.358255-7-void@manifault.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 10, 2023 at 03:03:41PM -0500, David Vernet wrote:

> +struct shared_runq_shard {
>  	struct list_head list;
>  	spinlock_t lock;
>  } ____cacheline_aligned;
>  
> +struct shared_runq {
> +	u32 num_shards;
> +	struct shared_runq_shard shards[];
> +} ____cacheline_aligned;
> +
> +/* This would likely work better as a configurable knob via debugfs */
> +#define SHARED_RUNQ_SHARD_SZ 6
> +
>  #ifdef CONFIG_SMP
>  static struct shared_runq *rq_shared_runq(struct rq *rq)
>  {
>  	return rq->cfs.shared_runq;
>  }
>  
> -static struct task_struct *shared_runq_pop_task(struct rq *rq)
> +static struct shared_runq_shard *rq_shared_runq_shard(struct rq *rq)
> +{
> +	return rq->cfs.shard;
> +}
> +
> +static int shared_runq_shard_idx(const struct shared_runq *runq, int cpu)
> +{
> +	return cpu % runq->num_shards;

I would suggest either:

	(cpu >> 1) % num_shards

or keeping num_shards even, to give SMT siblings a fighting chance to
hit the same bucket.

(I've no idea how SMT4 (or worse SMT8) is typically enumerated, so
someone from the Power/Sparc/MIPS world would have to go play with that
if they so care)

> +}

> +			num_shards = max(per_cpu(sd_llc_size, i) /
> +					 SHARED_RUNQ_SHARD_SZ, 1);

> +			shared_runq->num_shards = num_shards;


