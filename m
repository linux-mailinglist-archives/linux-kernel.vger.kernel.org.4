Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF25174F516
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 18:26:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230385AbjGKQ0S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 12:26:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229917AbjGKQ0R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 12:26:17 -0400
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0607299
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 09:26:16 -0700 (PDT)
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-4039f7e1d3aso36814991cf.0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 09:26:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689092775; x=1691684775;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M+BkpkIHt91LsKtHrn/2FR5YLMK0MGV5JFPJ48/dm8Q=;
        b=ZaqyP+TAMmtCWQfji0bFR06kGdpDFM6pvXV4KXoFIs6VJPqvvgLQFD+WcZTpaCIB0d
         DyMK61GiErCg6ExsWD9AcjRxlto4GzOWZnNvYNgUjnXVFN4g0jBtamnimbuXNWNl31Ag
         sVloclZcGslF29WkVH6yNKE6Td918YRHyXV9tF+AONwO0a2pRtqoK0T7KMjWejm89kHU
         v3YSB5iY3P1i2pYIcD3XU16TSdBjBNDnE8JLu+NJmcuW8cS40nlHLMhOxfHlabVFUs9j
         5ueciJ4rU/nqO0Zov7llS7dITZ198eQ6reEtTqeXvfkBl2T/WxpBY6jKaSFcdbmUnoym
         iyBg==
X-Gm-Message-State: ABy/qLYMwGW+VIjWfabcXZBzxfs40uSN8SyUjCHjRW5tSQAVx4sCExrS
        ozoz3tU/vcKAYtnLNDiCukE=
X-Google-Smtp-Source: APBJJlGvSHbgYR01MbzFjWtH9+ob8NCBZBw2c2Df/K35PSaVp9cL5y6fADX7z3Z3V93fLu1rn8cIIA==
X-Received: by 2002:a05:622a:1646:b0:3f6:bb5b:8111 with SMTP id y6-20020a05622a164600b003f6bb5b8111mr22302350qtj.60.1689092774941;
        Tue, 11 Jul 2023 09:26:14 -0700 (PDT)
Received: from maniforge ([2620:10d:c091:400::5:1d49])
        by smtp.gmail.com with ESMTPSA id o14-20020ac8554e000000b004016edea7dfsm1226135qtr.63.2023.07.11.09.26.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jul 2023 09:26:14 -0700 (PDT)
Date:   Tue, 11 Jul 2023 11:26:11 -0500
From:   David Vernet <void@manifault.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, mingo@redhat.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        gautham.shenoy@amd.com, kprateek.nayak@amd.com, aaron.lu@intel.com,
        clm@meta.com, tj@kernel.org, roman.gushchin@linux.dev,
        kernel-team@meta.com
Subject: Re: [PATCH v2 5/7] sched: Implement shared runqueue in CFS
Message-ID: <20230711162611.GB389526@maniforge>
References: <20230710200342.358255-1-void@manifault.com>
 <20230710200342.358255-6-void@manifault.com>
 <20230711101832.GF3062772@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230711101832.GF3062772@hirez.programming.kicks-ass.net>
User-Agent: Mutt/2.2.10 (2023-03-25)
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 11, 2023 at 12:18:32PM +0200, Peter Zijlstra wrote:
> On Mon, Jul 10, 2023 at 03:03:40PM -0500, David Vernet wrote:
> 
> > diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> > index 1451f5aa82ac..3ad437d4ea3d 100644
> > --- a/kernel/sched/core.c
> > +++ b/kernel/sched/core.c
> 
> > @@ -9842,6 +9843,7 @@ void __init sched_init_smp(void)
> >  
> >  	init_sched_rt_class();
> >  	init_sched_dl_class();
> > +	init_sched_fair_class_late();
> >  
> >  	sched_smp_initialized = true;
> >  }
> 
> > @@ -12854,3 +12999,34 @@ __init void init_sched_fair_class(void)
> >  #endif /* SMP */
> >  
> >  }
> > +
> > +__init void init_sched_fair_class_late(void)
> > +{
> > +#ifdef CONFIG_SMP
> > +	int i;
> > +	struct shared_runq *shared_runq;
> > +	struct rq *rq;
> > +	struct rq *llc_rq;
> > +
> > +	for_each_possible_cpu(i) {
> > +		if (per_cpu(sd_llc_id, i) == i) {
> > +			llc_rq = cpu_rq(i);
> > +
> > +			shared_runq = kzalloc_node(sizeof(struct shared_runq),
> > +					       GFP_KERNEL, cpu_to_node(i));
> > +			INIT_LIST_HEAD(&shared_runq->list);
> > +			spin_lock_init(&shared_runq->lock);
> > +			llc_rq->cfs.shared_runq = shared_runq;
> > +		}
> > +	}
> > +
> > +	for_each_possible_cpu(i) {
> > +		rq = cpu_rq(i);
> > +		llc_rq = cpu_rq(per_cpu(sd_llc_id, i));
> > +
> > +		if (rq == llc_rq)
> > +			continue;
> > +		rq->cfs.shared_runq = llc_rq->cfs.shared_runq;
> > +	}
> > +#endif /* SMP */
> > +}
> 
> I don't think this is right; the llc_id thing depends on the online
> mask, not on possible mask. So if you boot with a number of CPUs offline
> and late bring them online, you're screwy (IIRC this is actually a very
> common thing in virt land).
> 
> Additionally, llc_id depends on the sched_domain tree, if someone were
> to go create partitions, they can split an LLC and llc_id would split
> right along with it.
> 
> I think you need to move this into sched/topology.c and handle hotplug /
> domain (re) creation.

Yeah, you're right. This falls apart if we hotplug when we do domain
recreation. I'll address this in v3.

> And yes, that's going to be a pain, because you might need to re-hash
> existing lists.

Eh, it needs to be done. I played around with this for a bit before
sending the v1 RFC code but ended up keeping the series simple because
it was RFC, and fixing this is pretty involved. I should have taken care
of it regardless before dropping the RFC tag, so glad you pointed it
out.
