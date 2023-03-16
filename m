Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 455FE6BDBF3
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 23:49:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230051AbjCPWtf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 18:49:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229798AbjCPWte (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 18:49:34 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 435DF93F3
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 15:49:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679006973; x=1710542973;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=XKwkQJ0bdfOgGhhbgRIu/ZDdq4XL/bigHbAEq4aoOnc=;
  b=dyLcjnaxeToEFU0Bdu3NpnWFipKjBdu+vziDmUMR73D3tDQYvoJjBfuz
   ICOxc0pQuej60V0QX8bKohi0tVnzKAHgLYX5ci2z2sXowZ48Iwv3cWQs5
   UOq9BdTIqJ/djBg76hqiN1kMLe7jjSreuihfiwAc4VBU+J5W36y3Y0Bcn
   bhsrJgpJwf/yIVogxYun3LSycYyldWGcdOxopyi6lb2v55e0zYbl0LEay
   r+2ovUI0wFeRKbSXF4x7geByNaDSEZlzQN0QiFuJrFCxgR3bYA5pUbYHQ
   wHeCOo7JKx1Btuckd6JfX5zVcUaB+geH8lxY7Y7NfapeHFWzj6V+j0WuJ
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10651"; a="424400306"
X-IronPort-AV: E=Sophos;i="5.98,267,1673942400"; 
   d="scan'208";a="424400306"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2023 15:49:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10651"; a="854230161"
X-IronPort-AV: E=Sophos;i="5.98,267,1673942400"; 
   d="scan'208";a="854230161"
Received: from johanir-mobl.amr.corp.intel.com (HELO [10.212.200.250]) ([10.212.200.250])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2023 15:49:32 -0700
Message-ID: <75730c46f226722b71dd1ec9634a1eb90017f116.camel@linux.intel.com>
Subject: Re: [PATCH 08/10] sched/fair: Add lag based placement
From:   Tim Chen <tim.c.chen@linux.intel.com>
To:     Peter Zijlstra <peterz@infradead.org>, mingo@kernel.org,
        vincent.guittot@linaro.org
Cc:     linux-kernel@vger.kernel.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, corbet@lwn.net,
        qyousef@layalina.io, chris.hyser@oracle.com,
        patrick.bellasi@matbug.net, pjt@google.com, pavel@ucw.cz,
        qperret@google.com, joshdon@google.com, timj@gnu.org,
        kprateek.nayak@amd.com, yu.c.chen@intel.com,
        youssefesmat@chromium.org, joel@joelfernandes.org
Date:   Thu, 16 Mar 2023 15:49:31 -0700
In-Reply-To: <20230306141502.691294694@infradead.org>
References: <20230306132521.968182689@infradead.org>
         <20230306141502.691294694@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 (3.44.4-2.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2023-03-06 at 14:25 +0100, Peter Zijlstra wrote:
> With the introduction of avg_vruntime, it is possible to approximate
> lag (the entire purpose of introducing it in fact). Use this to do lag
> based placement over sleep+wake.
>=20
> Specifically, the FAIR_SLEEPERS thing places things too far to the
> left and messes up the deadline aspect of EEVDF.
>=20
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>  include/linux/sched.h   |    1=20
>  kernel/sched/core.c     |    1=20
>  kernel/sched/fair.c     |   63 +++++++++++++++++++++++++++--------------=
-------
>  kernel/sched/features.h |    8 ++++++
>  4 files changed, 46 insertions(+), 27 deletions(-)
>=20
> --- a/include/linux/sched.h
> +++ b/include/linux/sched.h
> @@ -555,6 +555,7 @@ struct sched_entity {
>  	u64				sum_exec_runtime;
>  	u64				vruntime;
>  	u64				prev_sum_exec_runtime;
> +	s64				lag;
> =20
>  	u64				nr_migrations;
> =20
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -4436,6 +4436,7 @@ static void __sched_fork(unsigned long c
>  	p->se.prev_sum_exec_runtime	=3D 0;
>  	p->se.nr_migrations		=3D 0;
>  	p->se.vruntime			=3D 0;
> +	p->se.lag			=3D 0;
>  	INIT_LIST_HEAD(&p->se.group_node);
> =20
>  	set_latency_offset(p);
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -4749,39 +4749,45 @@ static void
>  place_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int initial=
)
>  {
>  	u64 vruntime =3D avg_vruntime(cfs_rq);
> -	u64 sleep_time;
> =20
> -	/* sleeps up to a single latency don't count. */
> -	if (!initial) {
> -		unsigned long thresh;
> -
> -		if (se_is_idle(se))
> -			thresh =3D sysctl_sched_min_granularity;
> -		else
> -			thresh =3D sysctl_sched_latency;
> +	if (sched_feat(FAIR_SLEEPERS)) {
> +		u64 sleep_time;
> +
> +		/* sleeps up to a single latency don't count. */
> +		if (!initial) {
> +			unsigned long thresh;
> +
> +			if (se_is_idle(se))
> +				thresh =3D sysctl_sched_min_granularity;
> +			else
> +				thresh =3D sysctl_sched_latency;
> +
> +			/*
> +			 * Halve their sleep time's effect, to allow
> +			 * for a gentler effect of sleepers:
> +			 */
> +			if (sched_feat(GENTLE_FAIR_SLEEPERS))
> +				thresh >>=3D 1;
> +
> +			vruntime -=3D thresh;
> +		}
> =20
>  		/*
> -		 * Halve their sleep time's effect, to allow
> -		 * for a gentler effect of sleepers:
> +		 * Pull vruntime of the entity being placed to the base level of
> +		 * cfs_rq, to prevent boosting it if placed backwards.  If the entity
> +		 * slept for a long time, don't even try to compare its vruntime with
> +		 * the base as it may be too far off and the comparison may get
> +		 * inversed due to s64 overflow.
>  		 */
> -		if (sched_feat(GENTLE_FAIR_SLEEPERS))
> -			thresh >>=3D 1;
> -
> -		vruntime -=3D thresh;
> +		sleep_time =3D rq_clock_task(rq_of(cfs_rq)) - se->exec_start;
> +		if ((s64)sleep_time < 60LL * NSEC_PER_SEC)
> +			vruntime =3D max_vruntime(se->vruntime, vruntime);
>  	}
> =20
> -	/*
> -	 * Pull vruntime of the entity being placed to the base level of
> -	 * cfs_rq, to prevent boosting it if placed backwards.  If the entity
> -	 * slept for a long time, don't even try to compare its vruntime with
> -	 * the base as it may be too far off and the comparison may get
> -	 * inversed due to s64 overflow.
> -	 */
> -	sleep_time =3D rq_clock_task(rq_of(cfs_rq)) - se->exec_start;
> -	if ((s64)sleep_time > 60LL * NSEC_PER_SEC)
> -		se->vruntime =3D vruntime;
> -	else
> -		se->vruntime =3D max_vruntime(se->vruntime, vruntime);
> +	if (sched_feat(PRESERVE_LAG))
> +		vruntime -=3D se->lag;
> +
> +	se->vruntime =3D vruntime;

I was going to say that
when we migrate a task to a new runqueue, we subtract vruntime
by old queue's min_vruntime and that math needs update.

But then I saw you did that in=20
https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git/commit/ker=
nel/sched?h=3Dsched/eevdf

With this new lag based placement, I think it should properly fix
the starvation issues we have seen caused by quickly cpu hopping tasks.=20

Tim

>  }
> =20
>  static void check_enqueue_throttle(struct cfs_rq *cfs_rq);
> @@ -4949,6 +4955,9 @@ dequeue_entity(struct cfs_rq *cfs_rq, st
> =20
>  	clear_buddies(cfs_rq, se);
> =20
> +	if (sched_feat(PRESERVE_LAG) && (flags & DEQUEUE_SLEEP))
> +		se->lag =3D avg_vruntime(cfs_rq) - se->vruntime;
> +
>  	if (se !=3D cfs_rq->curr)
>  		__dequeue_entity(cfs_rq, se);
>  	se->on_rq =3D 0;
> --- a/kernel/sched/features.h
> +++ b/kernel/sched/features.h
> @@ -1,12 +1,20 @@
>  /* SPDX-License-Identifier: GPL-2.0 */
> +
>  /*
>   * Only give sleepers 50% of their service deficit. This allows
>   * them to run sooner, but does not allow tons of sleepers to
>   * rip the spread apart.
>   */
> +SCHED_FEAT(FAIR_SLEEPERS, false)
>  SCHED_FEAT(GENTLE_FAIR_SLEEPERS, true)
> =20
>  /*
> + * Using the avg_vruntime, do the right thing and preserve lag
> + * across sleep+wake cycles.
> + */
> +SCHED_FEAT(PRESERVE_LAG, true)
> +
> +/*
>   * Prefer to schedule the task we woke last (assuming it failed
>   * wakeup-preemption), since its likely going to consume data we
>   * touched, increases cache locality.
>=20
>=20

