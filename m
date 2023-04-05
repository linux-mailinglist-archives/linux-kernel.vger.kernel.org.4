Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3B096D8AE3
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 01:04:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229481AbjDEXEq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 19:04:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232869AbjDEXEn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 19:04:43 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEC037A9F
        for <linux-kernel@vger.kernel.org>; Wed,  5 Apr 2023 16:04:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680735879; x=1712271879;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=DUFoSzec5fZiiQaU9RW0QF5RKVNJleEQFUuWZQ4zhgI=;
  b=UQrTagLxQWM3HQSrCQQX42owEXt0Laz4ydI07xcGzbEd3P4xrB7qfUoB
   A0/h0dLpyxJn87j0VVVeBrmXipL+arMdQk+jytfKqmAzgzs+qYziewIo5
   IjcSkJcUjxqa9vaeaACmpPNmjXoUyrXe9pXn96CGm6D0aS04otBE3s1Sf
   BJHBVc8TM/oQ+HdxQqZ7m8cYhenKc6Cl1LQ5gQC5falKLKHulqLNiuI1z
   IZz+Er3xx0n2s84IZJDjP48yq/nSXvKHK/SAECn0x5vdDqPQWffAgpx86
   nXedqIkuE+cvZe9o3wJrsy6H3On7XX0CXFhy4AkDNhkz+vFFntiYRx0vp
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10671"; a="345179016"
X-IronPort-AV: E=Sophos;i="5.98,322,1673942400"; 
   d="scan'208";a="345179016"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2023 16:04:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10671"; a="664225729"
X-IronPort-AV: E=Sophos;i="5.98,322,1673942400"; 
   d="scan'208";a="664225729"
Received: from skansra-mobl.amr.corp.intel.com (HELO [10.209.62.228]) ([10.209.62.228])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2023 16:04:38 -0700
Message-ID: <5b8bbe752ce03cc690441cf4b6f6fe0f608a1e54.camel@linux.intel.com>
Subject: Re: [PATCH] sched: rt: Optimization function 'pick_next_rt_entity'
From:   Tim Chen <tim.c.chen@linux.intel.com>
To:     Li zeming <zeming@nfschina.com>, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com
Cc:     linux-kernel@vger.kernel.org
Date:   Wed, 05 Apr 2023 16:04:38 -0700
In-Reply-To: <20230405232900.4019-1-zeming@nfschina.com>
References: <20230405232900.4019-1-zeming@nfschina.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 (3.44.4-2.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2023-04-06 at 07:29 +0800, Li zeming wrote:
> The moral of this function is to obtain the next RT scheduling entity
> object,while 'list_entry' Implementation function of  'container_of'
> returns the next RT scheduling entity object (no new code should be
> added afterwards), directly returning 'list_entry' The execution result
> is sufficient.

Suggest changing the subject from "Optimization function 'pick_next_rt_enti=
ty'
to "Simplify pick_next_rt_entity()"

Suggest simplifying the comment:

Remove useless intermediate variable "next" and its initialization.  Direct=
ly return the
next RT scheduling entity obtained from list_entry().

Otherwise the patch itself looks fine.

Reviewed-by: Tim Chen <tim.c.chen@linux.intel.com>
>=20
> Signed-off-by: Li zeming <zeming@nfschina.com>
> ---
>  kernel/sched/rt.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>=20
> diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
> index 0a11f44adee5..e9b1c08c20a7 100644
> --- a/kernel/sched/rt.c
> +++ b/kernel/sched/rt.c
> @@ -1769,7 +1769,6 @@ static inline void set_next_task_rt(struct rq *rq, =
struct task_struct *p, bool f
>  static struct sched_rt_entity *pick_next_rt_entity(struct rt_rq *rt_rq)
>  {
>  	struct rt_prio_array *array =3D &rt_rq->active;
> -	struct sched_rt_entity *next =3D NULL;
>  	struct list_head *queue;
>  	int idx;
> =20
> @@ -1779,9 +1778,8 @@ static struct sched_rt_entity *pick_next_rt_entity(=
struct rt_rq *rt_rq)
>  	queue =3D array->queue + idx;
>  	if (SCHED_WARN_ON(list_empty(queue)))
>  		return NULL;
> -	next =3D list_entry(queue->next, struct sched_rt_entity, run_list);
> =20
> -	return next;
> +	return list_entry(queue->next, struct sched_rt_entity, run_list);
>  }
> =20
>  static struct task_struct *_pick_next_task_rt(struct rq *rq)

