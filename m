Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C07674E0E4
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 00:13:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229591AbjGJWNr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 18:13:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjGJWNp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 18:13:45 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B045F186
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 15:13:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689027224; x=1720563224;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=fT6p44pWryViVUU+L5d4KhFH3YedtPBQg6yoCla9z2M=;
  b=N6/tucD15whvbpQeTCxhYXW43bE9H2hiUIYsU5N6LPNKLBkjITn7eajh
   rS/PL0VIZ9Q3vhFGoTYgzLrkCO+oTN1CFdS3j1kSuteSpcUavW4J3JKTJ
   5tQq/wDiYMpudB5tklnuVA5wnYUK3dAwud9/mYg3e157xg+8WTiQ6rKjR
   kVSnTlDSTAQUClHUdnqjp2PomXPqHzAjDGus4/rM8Jue5jjrsUSqW9YTB
   2I91DUi8X09BTMbQVj8dYv7Q898H0BlUjdxz3aDq0i5W2+KGOonOmrjsH
   WRPbvqH74zOaAXcTzFe11F2p3pSHIHLHsh3poOu8BIG+q6pTT8YS7/kin
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10767"; a="367969815"
X-IronPort-AV: E=Sophos;i="6.01,195,1684825200"; 
   d="scan'208";a="367969815"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2023 15:13:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10767"; a="845040744"
X-IronPort-AV: E=Sophos;i="6.01,195,1684825200"; 
   d="scan'208";a="845040744"
Received: from rmirwin-mobl.amr.corp.intel.com (HELO [10.209.4.178]) ([10.209.4.178])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2023 15:13:43 -0700
Message-ID: <0b20535f4bd6908942c91be86bd17bc3c07514f2.camel@linux.intel.com>
Subject: Re: [Patch v3 2/6] sched/topology: Record number of cores in sched
 group
From:   Tim Chen <tim.c.chen@linux.intel.com>
To:     Valentin Schneider <vschneid@redhat.com>,
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
Date:   Mon, 10 Jul 2023 15:13:43 -0700
In-Reply-To: <xhsmhedlfv74k.mognet@vschneid.remote.csb>
References: <cover.1688770494.git.tim.c.chen@linux.intel.com>
         <04641eeb0e95c21224352f5743ecb93dfac44654.1688770494.git.tim.c.chen@linux.intel.com>
         <xhsmhedlfv74k.mognet@vschneid.remote.csb>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 (3.44.4-2.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2023-07-10 at 21:33 +0100, Valentin Schneider wrote:
> On 07/07/23 15:57, Tim Chen wrote:
> > From: Tim C Chen <tim.c.chen@linux.intel.com>
> >=20
> > When balancing sibling domains that have different number of cores,
> > tasks in respective sibling domain should be proportional to the number
> > of cores in each domain. In preparation of implementing such a policy,
> > record the number of tasks in a scheduling group.
> >=20
> > Signed-off-by: Tim Chen <tim.c.chen@linux.intel.com>
> > ---
> >  kernel/sched/sched.h    |  1 +
> >  kernel/sched/topology.c | 10 +++++++++-
> >  2 files changed, 10 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> > index 3d0eb36350d2..5f7f36e45b87 100644
> > --- a/kernel/sched/sched.h
> > +++ b/kernel/sched/sched.h
> > @@ -1860,6 +1860,7 @@ struct sched_group {
> >       atomic_t		ref;
> >=20
> >       unsigned int		group_weight;
> > +	unsigned int		cores;
> >       struct sched_group_capacity *sgc;
> >       int			asym_prefer_cpu;	/* CPU of highest priority in group */
> >       int			flags;
> > diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
> > index 6d5628fcebcf..6b099dbdfb39 100644
> > --- a/kernel/sched/topology.c
> > +++ b/kernel/sched/topology.c
> > @@ -1275,14 +1275,22 @@ build_sched_groups(struct sched_domain *sd, int=
 cpu)
> >  static void init_sched_groups_capacity(int cpu, struct sched_domain *s=
d)
> >  {
> >       struct sched_group *sg =3D sd->groups;
> > +	struct cpumask *mask =3D sched_domains_tmpmask2;
> >=20
> >       WARN_ON(!sg);
> >=20
> >       do {
> > -		int cpu, max_cpu =3D -1;
> > +		int cpu, cores =3D 0, max_cpu =3D -1;
> >=20
> >               sg->group_weight =3D cpumask_weight(sched_group_span(sg))=
;
> >=20
> > +		cpumask_copy(mask, sched_group_span(sg));
> > +		for_each_cpu(cpu, mask) {
> > +			cores++;
> > +			cpumask_andnot(mask, mask, cpu_smt_mask(cpu));
> > +		}
>=20
>=20
> This rekindled my desire for an SMT core cpumask/iterator. I played aroun=
d
> with a global mask but that's a headache: what if we end up with a core
> whose SMT threads are split across two exclusive cpusets?

Peter and I pondered that for a while.  But it seems like partitioning
threads in a core between two different sched domains is not a very
reasonable thing to do.=20

https://lore.kernel.org/all/20230612112945.GK4253@hirez.programming.kicks-a=
ss.net/

Tim

>=20
> I ended up necro'ing a patch from Peter [1], but didn't get anywhere nice
> (the LLC shared storage caused me issues).
>=20
> All that to say, I couldn't think of a nicer way :(
>=20
> [1]: https://lore.kernel.org/all/20180530143106.082002139@infradead.org/#=
t
>=20

