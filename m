Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6877E74DF5F
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 22:34:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231540AbjGJUel (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 16:34:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231602AbjGJUeh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 16:34:37 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1A81AD
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 13:33:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1689021233;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=AuYEoP0Nqpryc2PYnmyV89QNq2H9DQnGxj0KyoT+e7E=;
        b=TxoA6MF9LNhU4B2mepOY+AzPDctICC3AtoT09CNi9rpwIr5HdbaD4ORezdkosTRXPzzfba
        poDfoTvCcJAN6v1JZa04zLxJ9+bn0RtEfWzTULHk0QwBn1MH0TJ2vfZpvVOjwaAA+9OBfJ
        PnsCHkBsyHpwquS1WGad8GBMJ6YDyNI=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-475-TeUO3txOPy-ERJsVYndBuA-1; Mon, 10 Jul 2023 16:33:51 -0400
X-MC-Unique: TeUO3txOPy-ERJsVYndBuA-1
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-7673e4eee45so440870485a.0
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 13:33:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689021231; x=1691613231;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AuYEoP0Nqpryc2PYnmyV89QNq2H9DQnGxj0KyoT+e7E=;
        b=GMLaVWJhjhJHRaCXFIWhtQHJvU2ppOzSFjvMTPj15FHEYeadmbC3Bc+vuLUfQGvJoK
         aM0UHP9A3yHqlk8fdw6swPOT4AN6BdAcFB+d10AxT8Jn2ZpXuZTbe1Oc6sSl05LNBeAk
         Mc/q1NTdBG4ukBgjy8Cm/fC7FVPxAb98a0kica/4rYeXCL8xLq/8qZtBiZ2865spMYjN
         2AYELI036gtfAJk2a+g6pBj8ZQqQATC7kZMTogoifcs2sbhaEOJ+C7XGNrqndeLT+gVX
         vfwjDAfZkN0Z5V9Qdu5+JIwsKuX1dNl0ub3Nm5xM6GrD94Xacdvq4o+DVVso+9pLE0A4
         QkZg==
X-Gm-Message-State: ABy/qLauylLc1QxHaL3Ro5dXwqexp2O10SXxehtCmw/pz4CJHJiOg1pk
        fXuac/pkTpyeKdwxDqfY82Jr8pCl91hLg7MiUzmMc7AcqJ1wdMCfMDt1bBlc5Fm0JepDwOG7/fq
        Z5AU4Ty8nad01nKfJZcIl4++g
X-Received: by 2002:a05:620a:2a09:b0:767:15ee:cc51 with SMTP id o9-20020a05620a2a0900b0076715eecc51mr13580800qkp.6.1689021231364;
        Mon, 10 Jul 2023 13:33:51 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFPNH358eVNNPuYkgQaqRyj3aEDdtD47y0dK123LtIz1lWlk+PdWu1N5uBZ6N/UAeqLFp3xiw==
X-Received: by 2002:a05:620a:2a09:b0:767:15ee:cc51 with SMTP id o9-20020a05620a2a0900b0076715eecc51mr13580773qkp.6.1689021231124;
        Mon, 10 Jul 2023 13:33:51 -0700 (PDT)
Received: from vschneid.remote.csb ([154.57.232.159])
        by smtp.gmail.com with ESMTPSA id c9-20020a05620a134900b00767d62ed8e6sm229826qkl.19.2023.07.10.13.33.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jul 2023 13:33:50 -0700 (PDT)
From:   Valentin Schneider <vschneid@redhat.com>
To:     Tim Chen <tim.c.chen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Tim C Chen <tim.c.chen@linux.intel.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Ricardo Neri <ricardo.neri@intel.com>,
        "Ravi V . Shankar" <ravi.v.shankar@intel.com>,
        Ben Segall <bsegall@google.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Len Brown <len.brown@intel.com>, Mel Gorman <mgorman@suse.de>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ionela Voinescu <ionela.voinescu@arm.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        Shrikanth Hegde <sshegde@linux.vnet.ibm.com>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        naveen.n.rao@linux.vnet.ibm.com,
        Yicong Yang <yangyicong@hisilicon.com>,
        Barry Song <v-songbaohua@oppo.com>,
        Chen Yu <yu.c.chen@intel.com>, Hillf Danton <hdanton@sina.com>
Subject: Re: [Patch v3 2/6] sched/topology: Record number of cores in sched
 group
In-Reply-To: <04641eeb0e95c21224352f5743ecb93dfac44654.1688770494.git.tim.c.chen@linux.intel.com>
References: <cover.1688770494.git.tim.c.chen@linux.intel.com>
 <04641eeb0e95c21224352f5743ecb93dfac44654.1688770494.git.tim.c.chen@linux.intel.com>
Date:   Mon, 10 Jul 2023 21:33:47 +0100
Message-ID: <xhsmhedlfv74k.mognet@vschneid.remote.csb>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/07/23 15:57, Tim Chen wrote:
> From: Tim C Chen <tim.c.chen@linux.intel.com>
>
> When balancing sibling domains that have different number of cores,
> tasks in respective sibling domain should be proportional to the number
> of cores in each domain. In preparation of implementing such a policy,
> record the number of tasks in a scheduling group.
>
> Signed-off-by: Tim Chen <tim.c.chen@linux.intel.com>
> ---
>  kernel/sched/sched.h    |  1 +
>  kernel/sched/topology.c | 10 +++++++++-
>  2 files changed, 10 insertions(+), 1 deletion(-)
>
> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index 3d0eb36350d2..5f7f36e45b87 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -1860,6 +1860,7 @@ struct sched_group {
>       atomic_t		ref;
>
>       unsigned int		group_weight;
> +	unsigned int		cores;
>       struct sched_group_capacity *sgc;
>       int			asym_prefer_cpu;	/* CPU of highest priority in group */
>       int			flags;
> diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
> index 6d5628fcebcf..6b099dbdfb39 100644
> --- a/kernel/sched/topology.c
> +++ b/kernel/sched/topology.c
> @@ -1275,14 +1275,22 @@ build_sched_groups(struct sched_domain *sd, int cpu)
>  static void init_sched_groups_capacity(int cpu, struct sched_domain *sd)
>  {
>       struct sched_group *sg = sd->groups;
> +	struct cpumask *mask = sched_domains_tmpmask2;
>
>       WARN_ON(!sg);
>
>       do {
> -		int cpu, max_cpu = -1;
> +		int cpu, cores = 0, max_cpu = -1;
>
>               sg->group_weight = cpumask_weight(sched_group_span(sg));
>
> +		cpumask_copy(mask, sched_group_span(sg));
> +		for_each_cpu(cpu, mask) {
> +			cores++;
> +			cpumask_andnot(mask, mask, cpu_smt_mask(cpu));
> +		}


This rekindled my desire for an SMT core cpumask/iterator. I played around
with a global mask but that's a headache: what if we end up with a core
whose SMT threads are split across two exclusive cpusets?

I ended up necro'ing a patch from Peter [1], but didn't get anywhere nice
(the LLC shared storage caused me issues).

All that to say, I couldn't think of a nicer way :(

[1]: https://lore.kernel.org/all/20180530143106.082002139@infradead.org/#t

