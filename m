Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 607A874DAD2
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 18:14:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232972AbjGJQOB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 12:14:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229955AbjGJQOA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 12:14:00 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71D16DF
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 09:13:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689005639; x=1720541639;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=kWPp1hm5rkok5086Iyw9rFvuo3aqjsM9GZG0NJpiTOk=;
  b=PjPtkvOOMVrK6bC/lEdWbFWj9X1/qPkzGIbvtMRgoUlblkVaOgpc0q2F
   SVR4ta3QjMTK6vQ3meHWZS3ImHHCmwRO9jQe1o+Gr7sFmgXfryrTn3yqO
   3Pe7nXK+J+txvM3mORsKcr3xz8bF1x8pIxJy/o+k14Yc6lzaDMeEg2a3b
   QoJTBNL6qwZaGHS2hM+5pQuXz9u23cGOWZcuQR71lNxFJ+mR627LYBP9p
   NSYKGLqh6OFxq97CoGn4VYsfDRLdMWjnWr4akQ4/1eLp57kpAkZRR3EFU
   GtDkhQxFXyYaoKZnAyPyYjvYdmgnqrRn+9cW33OikVwv5/Z6yDMApOPl8
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10767"; a="430465292"
X-IronPort-AV: E=Sophos;i="6.01,195,1684825200"; 
   d="scan'208";a="430465292"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2023 09:13:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10767"; a="786246932"
X-IronPort-AV: E=Sophos;i="6.01,195,1684825200"; 
   d="scan'208";a="786246932"
Received: from rmirwin-mobl.amr.corp.intel.com (HELO [10.209.4.178]) ([10.209.4.178])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2023 09:13:57 -0700
Message-ID: <09180b7c53892c013c50434065ce91e5779b08ab.camel@linux.intel.com>
Subject: Re: [Patch v3 5/6] sched/x86: Add cluster topology to hybrid CPU
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
        Chen Yu <yu.c.chen@intel.com>, Hillf Danton <hdanton@sina.com>,
        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Date:   Mon, 10 Jul 2023 09:13:45 -0700
In-Reply-To: <20230708123137.GB2934075@hirez.programming.kicks-ass.net>
References: <cover.1688770494.git.tim.c.chen@linux.intel.com>
         <e64678a22c57d572dcac20a0d492d406d56bf881.1688770494.git.tim.c.chen@linux.intel.com>
         <20230708123137.GB2934075@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 (3.44.4-2.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2023-07-08 at 14:31 +0200, Peter Zijlstra wrote:
> On Fri, Jul 07, 2023 at 03:57:04PM -0700, Tim Chen wrote:
> > From: Tim C Chen <tim.c.chen@linux.intel.com>
> >=20
> > Cluster topology was not enabled on hybrid x86 CPU as load balance
> > was not properly working for cluster domain.  That has been fixed and
> > cluster domain can be enabled for hybrid CPU.
> >=20
> > Reviewed-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
> > Signed-off-by: Tim Chen <tim.c.chen@linux.intel.com>
>=20
> Yeah, you didn't actually try appling this to something recent did ya
> :-)
>=20
> You missed 8f2d6c41e5a6 ("x86/sched: Rewrite topology setup").
>=20
> I'll replace this patch with the below.

Thanks for catching it.

Tim

>=20
> ---
>  arch/x86/kernel/smpboot.c | 11 +++--------
>  1 file changed, 3 insertions(+), 8 deletions(-)
>=20
> diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
> index ed2d51960a7d..3b751d79cdfb 100644
> --- a/arch/x86/kernel/smpboot.c
> +++ b/arch/x86/kernel/smpboot.c
> @@ -632,14 +632,9 @@ static void __init build_sched_topology(void)
>  	};
>  #endif
>  #ifdef CONFIG_SCHED_CLUSTER
> -	/*
> -	 * For now, skip the cluster domain on Hybrid.
> -	 */
> -	if (!cpu_feature_enabled(X86_FEATURE_HYBRID_CPU)) {
> -		x86_topology[i++] =3D (struct sched_domain_topology_level){
> -			cpu_clustergroup_mask, x86_cluster_flags, SD_INIT_NAME(CLS)
> -		};
> -	}
> +	x86_topology[i++] =3D (struct sched_domain_topology_level){
> +		cpu_clustergroup_mask, x86_cluster_flags, SD_INIT_NAME(CLS)
> +	};
>  #endif
>  #ifdef CONFIG_SCHED_MC
>  	x86_topology[i++] =3D (struct sched_domain_topology_level){

