Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 904656F83C8
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 15:20:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232449AbjEENUC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 09:20:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232133AbjEENT6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 09:19:58 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA2E72688
        for <linux-kernel@vger.kernel.org>; Fri,  5 May 2023 06:19:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Axx0Ai+E7uI/gopDqIjvpCC5ufvysxbF5WjvYPweVkM=; b=PH8CrB2OE6jBsMgZgc1Ns/uAoL
        DpKoU8g9HX2xjBDpMXOePDuT6PqtImvr9RMPe28EU84KDI5NGxEFPw40oV/Qque4rV0CFYj6ujnVP
        oMJCzBJkKS3gNT8jqSTlHWIyQjSXVFETI5vz+5EI17MEcczZNOi6ShhrjTTMSkYK8bvmc4Bb0B8tt
        oJ/PfTNi3U35cXHgIK/nRfvY2YIfz6HgzFe6oOOinaiBju8fFe8JSkz1gh7UNPk2X8fVLYDXsp4Yq
        5lMYjOm2lZPbFUtfYcovjNf6EGedwZEOd+N+4PwuWiXLY9wGqjERJSbgqobMF9pNkj694nrJsFVFN
        SshN9gRw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1puvKz-003G5G-2G;
        Fri, 05 May 2023 13:19:07 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 8061C306128;
        Fri,  5 May 2023 15:19:03 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 55A4321353003; Fri,  5 May 2023 15:19:03 +0200 (CEST)
Date:   Fri, 5 May 2023 15:19:03 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Tim Chen <tim.c.chen@linux.intel.com>
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
        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Subject: Re: [PATCH 3/6] sched/fair: Fix busiest group selection for asym
 groups
Message-ID: <20230505131903.GP83892@hirez.programming.kicks-ass.net>
References: <cover.1683156492.git.tim.c.chen@linux.intel.com>
 <2e2e6844fb3ed28594d86c5e45295df7c4335c08.1683156492.git.tim.c.chen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2e2e6844fb3ed28594d86c5e45295df7c4335c08.1683156492.git.tim.c.chen@linux.intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 04, 2023 at 09:09:53AM -0700, Tim Chen wrote:
> From: Tim C Chen <tim.c.chen@linux.intel.com>
> 
> For two groups that have spare capacity and are partially busy, the
> busier group should be the group with pure CPUs rather than the group
> with SMT CPUs.  We do not want to make the SMT group the busiest one to
> pull task off the SMT and makes the whole core empty.
> 
> Otherwise suppose in the search for busiest group,
> we first encounter an SMT group with 1 task and set it as the busiest.
> The local group is an atom cluster with 1 task and we then encounter an atom
> cluster group with 3 tasks, we will not pick this atom cluster group over the
> SMT group, even though we should.  As a result, we do not load balance
> the busier Atom cluster (with 3 tasks) towards the local Atom cluster
> (with 1 task).  And it doesn't make sense to pick the 1 task SMT group
> as the busier group as we also should not pull task off the SMT towards
> the 1 task atom cluster and make the SMT core completely empty.
> 
> Fix this case.
> 
> Reviewed-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
> Signed-off-by: Tim Chen <tim.c.chen@linux.intel.com>
> ---
>  kernel/sched/fair.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index bde962aa160a..8a325db34b02 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -9548,6 +9548,18 @@ static bool update_sd_pick_busiest(struct lb_env *env,
>  		break;
>  
>  	case group_has_spare:
> +		/*
> +		 * Do not pick sg with SMT CPUs over sg with pure CPUs,
> +		 * as we do not want to pull task off half empty SMT core
> +		 * and make the core idle.
> +		 */

Comment says what the code does; not why.

> +		if (asymmetric_groups(sds->busiest, sg)) {
> +			if (sds->busiest->flags & SD_SHARE_CPUCAPACITY)
> +				return true;
> +			else
> +				return false;

			return (sds->busiest->flags & SD_SHARE_CPUCAPACITY)
> +		}

Also, should this not be part of the previous patch?
