Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6531174F598
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 18:34:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233302AbjGKQen (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 12:34:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233133AbjGKQe1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 12:34:27 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF947172A
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 09:33:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689093236; x=1720629236;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=RqB/lQPtyNAxJD2ZFNWUjUErQGFsTV+U4+xcKMWsCRg=;
  b=MHo83UkwoHjbnVWWggVWwwClxdNpOTHuWsphgI/kqsdscKVo8b0VJVIq
   2S468RjTboIDAnkfgBFdsHLjuK/FWCXOhZye1nxrcKh881x7qqWLCSGbG
   uSqwprxRlaC5i9mRpW+3mDHNXsgWuQv+93eCnZzGOg8OCTDFYQaXZDQL6
   ybOkkOUP9EbFKA59decA8LYHirkgfKDwHWhbiwWCly0SqCfg2Jqef7UVy
   2dLwATmIFj7KCOSoWSldddgTO1GFcVpAeckyKvMCXaXq0zq8HB4zDt8sX
   fETmDUtdhwra+uIXJ8nanBxszzh15RO1B6ciid0H0gpRgCQSFY/yLOxag
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10768"; a="364708090"
X-IronPort-AV: E=Sophos;i="6.01,196,1684825200"; 
   d="scan'208";a="364708090"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2023 09:32:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10768"; a="715204775"
X-IronPort-AV: E=Sophos;i="6.01,196,1684825200"; 
   d="scan'208";a="715204775"
Received: from araquino-mobl2.amr.corp.intel.com (HELO [10.209.35.37]) ([10.209.35.37])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2023 09:32:54 -0700
Message-ID: <53b65a17a8900cbe5b7e42e599390d62434205d8.camel@linux.intel.com>
Subject: Re: [Patch v3 2/6] sched/topology: Record number of cores in sched
 group
From:   Tim Chen <tim.c.chen@linux.intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
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
        Valentin Schneider <vschneid@redhat.com>,
        Ionela Voinescu <ionela.voinescu@arm.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        Shrikanth Hegde <sshegde@linux.vnet.ibm.com>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        naveen.n.rao@linux.vnet.ibm.com,
        Yicong Yang <yangyicong@hisilicon.com>,
        Barry Song <v-songbaohua@oppo.com>,
        Chen Yu <yu.c.chen@intel.com>, Hillf Danton <hdanton@sina.com>
Date:   Tue, 11 Jul 2023 09:32:54 -0700
In-Reply-To: <20230711113158.GJ3062772@hirez.programming.kicks-ass.net>
References: <cover.1688770494.git.tim.c.chen@linux.intel.com>
         <04641eeb0e95c21224352f5743ecb93dfac44654.1688770494.git.tim.c.chen@linux.intel.com>
         <4797e9147143decf561ede6b7658721d05dda4dc.camel@linux.intel.com>
         <20230711113158.GJ3062772@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 (3.44.4-2.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2023-07-11 at 13:31 +0200, Peter Zijlstra wrote:
> On Mon, Jul 10, 2023 at 03:40:34PM -0700, Tim Chen wrote:
> > On Fri, 2023-07-07 at 15:57 -0700, Tim Chen wrote:
> > > From: Tim C Chen <tim.c.chen@linux.intel.com>
> > >=20
> > > When balancing sibling domains that have different number of cores,
> > > tasks in respective sibling domain should be proportional to the numb=
er
> > > of cores in each domain. In preparation of implementing such a policy=
,
> > > record the number of tasks in a scheduling group.
> >=20
> > Caught a typo.  Should be "the number of cores" instead of
> > "the number of tasks" in a scheduling group.
> >=20
> > Peter, should I send you another patch with the corrected commit log?
>=20
> I'll fix it up, already had to fix the patch because due to robot
> finding a compile fail for SCHED_SMT=3Dn builds.
>=20
>=20
>=20
> > > @@ -1275,14 +1275,22 @@ build_sched_groups(struct sched_domain *sd, i=
nt cpu)
> > >  static void init_sched_groups_capacity(int cpu, struct sched_domain =
*sd)
> > >  {
> > >  	struct sched_group *sg =3D sd->groups;
> > > +	struct cpumask *mask =3D sched_domains_tmpmask2;
> > > =20
> > >  	WARN_ON(!sg);
> > > =20
> > >  	do {
> > > -		int cpu, max_cpu =3D -1;
> > > +		int cpu, cores =3D 0, max_cpu =3D -1;
> > > =20
> > >  		sg->group_weight =3D cpumask_weight(sched_group_span(sg));
> > > =20
> > > +		cpumask_copy(mask, sched_group_span(sg));
> > > +		for_each_cpu(cpu, mask) {
> > > +			cores++;
> #ifdef CONFIG_SCHED_SMT
> > > +			cpumask_andnot(mask, mask, cpu_smt_mask(cpu));
> #else
> 			__cpumask_clear_cpu(cpu, mask);

Thanks for fixing up the non SCHED_SMT.

I think "__cpumask_clear_cpu(cpu, mask);" can be removed.

Since we have already considered the CPU in the iterator, clearing it
is unnecessay.  So effectively

for_each_cpu(cpu, mask) {
	cores++;
}

should be good enough for the non SCHED_SMT case. =20

Or replace the patch with the patch below so we don't
have #ifdef in the middle of code body.  Either way
is fine.

---

From 9f19714db69739a7985e46bc1f8334d70a69cf2e Mon Sep 17 00:00:00 2001
Message-Id: <9f19714db69739a7985e46bc1f8334d70a69cf2e.1689092923.git.tim.c.=
chen@linux.intel.com>
In-Reply-To: <cover.1689092923.git.tim.c.chen@linux.intel.com>
References: <cover.1689092923.git.tim.c.chen@linux.intel.com>
From: Tim C Chen <tim.c.chen@linux.intel.com>
Date: Wed, 17 May 2023 09:09:54 -0700
Subject: [Patch v3 2/6] sched/topology: Record number of cores in sched gro=
up
To: Peter Zijlstra <peterz@infradead.org>
Cc: Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@li=
naro.org>, Ricardo Neri <ricardo.neri@intel.com>, Ravi V. Shankar <ravi.v.s=
hankar@intel.com>, Ben Segall
<bsegall@google.com>, Daniel Bristot de Oliveira <bristot@redhat.com>, Diet=
mar Eggemann <dietmar.eggemann@arm.com>, Len Brown <len.brown@intel.com>, M=
el Gorman <mgorman@suse.de>, Rafael J. Wysocki
<rafael.j.wysocki@intel.com>, Srinivas Pandruvada <srinivas.pandruvada@linu=
x.intel.com>, Steven Rostedt <rostedt@goodmis.org>, Tim Chen <tim.c.chen@li=
nux.intel.com>, Valentin Schneider
<vschneid@redhat.com>, Ionela Voinescu <ionela.voinescu@arm.com>, x86@kerne=
l.org, linux-kernel@vger.kernel.org, Shrikanth Hegde <sshegde@linux.vnet.ib=
m.com>, Srikar Dronamraju
<srikar@linux.vnet.ibm.com>, naveen.n.rao@linux.vnet.ibm.com, Yicong Yang <=
yangyicong@hisilicon.com>, Barry Song <v-songbaohua@oppo.com>, Chen Yu <yu.=
c.chen@intel.com>, Hillf Danton <hdanton@sina.com>

When balancing sibling domains that have different number of cores,
tasks in respective sibling domain should be proportional to the number
of cores in each domain. In preparation of implementing such a policy,
record the number of cores in a scheduling group.

Signed-off-by: Tim Chen <tim.c.chen@linux.intel.com>
---
 kernel/sched/sched.h    |  1 +
 kernel/sched/topology.c | 21 +++++++++++++++++++++
 2 files changed, 22 insertions(+)

diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 3d0eb36350d2..5f7f36e45b87 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1860,6 +1860,7 @@ struct sched_group {
 	atomic_t		ref;
=20
 	unsigned int		group_weight;
+	unsigned int		cores;
 	struct sched_group_capacity *sgc;
 	int			asym_prefer_cpu;	/* CPU of highest priority in group */
 	int			flags;
diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index 6d5628fcebcf..4ecdaef3f8ab 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -1262,6 +1262,26 @@ build_sched_groups(struct sched_domain *sd, int cpu)
 	return 0;
 }
=20
+#ifdef CONFIG_SCHED_SMT
+static inline int sched_group_cores(struct sched_group *sg)
+{
+	struct cpumask *mask =3D sched_domains_tmpmask2;
+	int cpu, cores =3D 0;
+
+	cpumask_copy(mask, sched_group_span(sg));
+	for_each_cpu(cpu, mask) {
+		cores++;
+		cpumask_andnot(mask, mask, cpu_smt_mask(cpu));
+	}
+	return cores;
+}
+#else
+static inline int sched_group_cores(struct sched_group *sg)
+{
+	return sg->group_weight;
+}
+#endif
+
 /*
  * Initialize sched groups cpu_capacity.
  *
@@ -1282,6 +1302,7 @@ static void init_sched_groups_capacity(int cpu, struc=
t sched_domain *sd)
 		int cpu, max_cpu =3D -1;
=20
 		sg->group_weight =3D cpumask_weight(sched_group_span(sg));
+		sg->cores =3D sched_group_cores(sg);
=20
 		if (!(sd->flags & SD_ASYM_PACKING))
 			goto next;
--=20
2.32.0





