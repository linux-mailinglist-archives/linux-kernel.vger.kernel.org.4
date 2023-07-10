Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 534F074E180
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 00:40:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230393AbjGJWkj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 18:40:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230281AbjGJWkh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 18:40:37 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B10719C
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 15:40:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689028836; x=1720564836;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=2PGHiZTbE9WmEOrGsLfCFHLRDzE9rVhZjD1SYYpb2Ms=;
  b=TQLs/XNZT9nP3Gan14uCJFltnEwPL7yCjo4FkcJkbxao6IVOEbVE17r7
   wuCMnsNOwzaM59i006P/n/Hj0x0WLG57BB4jydhJgB/3yh6xT5M7UMEND
   +cmIxYpuqIXQs0OCt8IHjr2stMMRCBVg3dSy0NROn2a1+wIUXGdihVrzG
   kNB1IXdRnMTy3BcSafNrNj4K82He1wdlbMbM2H72A0ANVc5+X6qMF5IZd
   NgaoP5NGXM3ROetKyPsoEN4tAk4gS0OByk8ON00SIeqUeO5GOeVoh5dB7
   d6VynMuAKTgvnm1mS6QdUf8rvYWvenW9H4Jmb+61ZxBTqBP4oc975ll8i
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10767"; a="450837200"
X-IronPort-AV: E=Sophos;i="6.01,195,1684825200"; 
   d="scan'208";a="450837200"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2023 15:40:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10767"; a="698202410"
X-IronPort-AV: E=Sophos;i="6.01,195,1684825200"; 
   d="scan'208";a="698202410"
Received: from rmirwin-mobl.amr.corp.intel.com (HELO [10.209.4.178]) ([10.209.4.178])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2023 15:40:35 -0700
Message-ID: <4797e9147143decf561ede6b7658721d05dda4dc.camel@linux.intel.com>
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
Date:   Mon, 10 Jul 2023 15:40:34 -0700
In-Reply-To: <04641eeb0e95c21224352f5743ecb93dfac44654.1688770494.git.tim.c.chen@linux.intel.com>
References: <cover.1688770494.git.tim.c.chen@linux.intel.com>
         <04641eeb0e95c21224352f5743ecb93dfac44654.1688770494.git.tim.c.chen@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 (3.44.4-2.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2023-07-07 at 15:57 -0700, Tim Chen wrote:
> From: Tim C Chen <tim.c.chen@linux.intel.com>
>=20
> When balancing sibling domains that have different number of cores,
> tasks in respective sibling domain should be proportional to the number
> of cores in each domain. In preparation of implementing such a policy,
> record the number of tasks in a scheduling group.

Caught a typo.  Should be "the number of cores" instead of
"the number of tasks" in a scheduling group.

Peter, should I send you another patch with the corrected commit log?

Tim

>=20
> Signed-off-by: Tim Chen <tim.c.chen@linux.intel.com>
> ---
>  kernel/sched/sched.h    |  1 +
>  kernel/sched/topology.c | 10 +++++++++-
>  2 files changed, 10 insertions(+), 1 deletion(-)
>=20
> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index 3d0eb36350d2..5f7f36e45b87 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -1860,6 +1860,7 @@ struct sched_group {
>  	atomic_t		ref;
> =20
>  	unsigned int		group_weight;
> +	unsigned int		cores;
>  	struct sched_group_capacity *sgc;
>  	int			asym_prefer_cpu;	/* CPU of highest priority in group */
>  	int			flags;
> diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
> index 6d5628fcebcf..6b099dbdfb39 100644
> --- a/kernel/sched/topology.c
> +++ b/kernel/sched/topology.c
> @@ -1275,14 +1275,22 @@ build_sched_groups(struct sched_domain *sd, int c=
pu)
>  static void init_sched_groups_capacity(int cpu, struct sched_domain *sd)
>  {
>  	struct sched_group *sg =3D sd->groups;
> +	struct cpumask *mask =3D sched_domains_tmpmask2;
> =20
>  	WARN_ON(!sg);
> =20
>  	do {
> -		int cpu, max_cpu =3D -1;
> +		int cpu, cores =3D 0, max_cpu =3D -1;
> =20
>  		sg->group_weight =3D cpumask_weight(sched_group_span(sg));
> =20
> +		cpumask_copy(mask, sched_group_span(sg));
> +		for_each_cpu(cpu, mask) {
> +			cores++;
> +			cpumask_andnot(mask, mask, cpu_smt_mask(cpu));
> +		}
> +		sg->cores =3D cores;
> +
>  		if (!(sd->flags & SD_ASYM_PACKING))
>  			goto next;
> =20

