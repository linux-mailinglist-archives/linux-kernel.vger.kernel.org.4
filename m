Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84A3C75030D
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 11:28:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232948AbjGLJ2Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 05:28:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233270AbjGLJ17 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 05:27:59 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75654139
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 02:27:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1689154041;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0yxfOZOJtDRYGe4/9MKRDlesJmocqo4vTSXNb7waQqE=;
        b=d2I67wZJ31WnN9XjGsBiOT772ZFv/uwtkGxqFy1VZ9emjrhcGwIYfmq43bvW1Dv19qIQUX
        CHDdFieUNXKIDxmtE0QLojPdw1nFw6nWX9dXiV8hJQhUz9/tl7/ca/YXrqbqh3StPEoLUh
        dpwAe8vSZCzFZC//vyPqEGdfU2mot0E=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-550-uXPIjshcPWOEh7o_PeF_yA-1; Wed, 12 Jul 2023 05:27:14 -0400
X-MC-Unique: uXPIjshcPWOEh7o_PeF_yA-1
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-767564705f5so785488585a.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 02:27:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689154033; x=1691746033;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0yxfOZOJtDRYGe4/9MKRDlesJmocqo4vTSXNb7waQqE=;
        b=GyfH2mhF/Qv/RrbMMCV65vxkXeYsvCuGmlJtGRLozHzCVJTDklZYO9KUI/3w/yT9vW
         czlrIvtnuv+j4iOoiPZ81iA6JKzPU4k0UpSZpsrduChbupb5W1TtV2hlkXC8TO0VmZvz
         4s/aW0oIFkDv6IOeEaZn/uDSzRYnoqq/dsz84o7TSov8n6t7kHwOVL99zo+9Ob/3MHcu
         7d5jtPV8lknBFZ1GL9ZKeh1RzD2tEMpcAzzJPwR1DjVeFRSfVWpyYGnpt4E2Zky825Yp
         ZoaPQjdeDTZQxi/+vGbLtCyecYHsNaAmysQ319NXVHM6Wc0VBX5xLkwiW2oUh9aC15fJ
         u9RQ==
X-Gm-Message-State: ABy/qLZ0xYxSElA9KAsPoKSISDBz34pd/v0iSPORHTctMMqR/T5gC5rs
        T4ueST6rK65pohbbBeUHQuRmNKtbPa9fRPyq4nBJV88/lO/PelRXzuB6SmCJA4vUSDufBDyBA5m
        OV9bwZXU6GBKBejhKvZ9uuJWO
X-Received: by 2002:a05:620a:3729:b0:75b:23a1:8345 with SMTP id de41-20020a05620a372900b0075b23a18345mr21053566qkb.64.1689154033739;
        Wed, 12 Jul 2023 02:27:13 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHcuT+LWLJMRYybWHS7tPBaDEHbi3bklMy3/Ye0pN5/67siO1tvIx6/T8qfyB8/qG8b3OiHYQ==
X-Received: by 2002:a05:620a:3729:b0:75b:23a1:8345 with SMTP id de41-20020a05620a372900b0075b23a18345mr21053545qkb.64.1689154033514;
        Wed, 12 Jul 2023 02:27:13 -0700 (PDT)
Received: from vschneid.remote.csb ([154.57.232.159])
        by smtp.gmail.com with ESMTPSA id g7-20020ae9e107000000b0075cd80fde9esm1984023qkm.89.2023.07.12.02.27.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jul 2023 02:27:12 -0700 (PDT)
From:   Valentin Schneider <vschneid@redhat.com>
To:     Tim Chen <tim.c.chen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Juri Lelli <juri.lelli@redhat.com>,
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
In-Reply-To: <0b20535f4bd6908942c91be86bd17bc3c07514f2.camel@linux.intel.com>
References: <cover.1688770494.git.tim.c.chen@linux.intel.com>
 <04641eeb0e95c21224352f5743ecb93dfac44654.1688770494.git.tim.c.chen@linux.intel.com>
 <xhsmhedlfv74k.mognet@vschneid.remote.csb>
 <0b20535f4bd6908942c91be86bd17bc3c07514f2.camel@linux.intel.com>
Date:   Wed, 12 Jul 2023 10:27:08 +0100
Message-ID: <xhsmh4jm9v5sj.mognet@vschneid.remote.csb>
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

On 10/07/23 15:13, Tim Chen wrote:
> On Mon, 2023-07-10 at 21:33 +0100, Valentin Schneider wrote:
>> On 07/07/23 15:57, Tim Chen wrote:
>> > From: Tim C Chen <tim.c.chen@linux.intel.com>
>> >
>> > When balancing sibling domains that have different number of cores,
>> > tasks in respective sibling domain should be proportional to the number
>> > of cores in each domain. In preparation of implementing such a policy,
>> > record the number of tasks in a scheduling group.
>> >
>> > Signed-off-by: Tim Chen <tim.c.chen@linux.intel.com>
>> > ---
>> >  kernel/sched/sched.h    |  1 +
>> >  kernel/sched/topology.c | 10 +++++++++-
>> >  2 files changed, 10 insertions(+), 1 deletion(-)
>> >
>> > diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
>> > index 3d0eb36350d2..5f7f36e45b87 100644
>> > --- a/kernel/sched/sched.h
>> > +++ b/kernel/sched/sched.h
>> > @@ -1860,6 +1860,7 @@ struct sched_group {
>> >       atomic_t		ref;
>> >
>> >       unsigned int		group_weight;
>> > +	unsigned int		cores;
>> >       struct sched_group_capacity *sgc;
>> >       int			asym_prefer_cpu;	/* CPU of highest priority in group */
>> >       int			flags;
>> > diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
>> > index 6d5628fcebcf..6b099dbdfb39 100644
>> > --- a/kernel/sched/topology.c
>> > +++ b/kernel/sched/topology.c
>> > @@ -1275,14 +1275,22 @@ build_sched_groups(struct sched_domain *sd, int cpu)
>> >  static void init_sched_groups_capacity(int cpu, struct sched_domain *sd)
>> >  {
>> >       struct sched_group *sg = sd->groups;
>> > +	struct cpumask *mask = sched_domains_tmpmask2;
>> >
>> >       WARN_ON(!sg);
>> >
>> >       do {
>> > -		int cpu, max_cpu = -1;
>> > +		int cpu, cores = 0, max_cpu = -1;
>> >
>> >               sg->group_weight = cpumask_weight(sched_group_span(sg));
>> >
>> > +		cpumask_copy(mask, sched_group_span(sg));
>> > +		for_each_cpu(cpu, mask) {
>> > +			cores++;
>> > +			cpumask_andnot(mask, mask, cpu_smt_mask(cpu));
>> > +		}
>>
>>
>> This rekindled my desire for an SMT core cpumask/iterator. I played around
>> with a global mask but that's a headache: what if we end up with a core
>> whose SMT threads are split across two exclusive cpusets?
>
> Peter and I pondered that for a while.  But it seems like partitioning
> threads in a core between two different sched domains is not a very
> reasonable thing to do.
>
> https://lore.kernel.org/all/20230612112945.GK4253@hirez.programming.kicks-ass.net/
>

Thanks for the link. I'll poke at this a bit more, but regardless:

Reviewed-by: Valentin Schneider <vschneid@redhat.com>

