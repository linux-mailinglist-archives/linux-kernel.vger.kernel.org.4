Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE9057472E9
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 15:40:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230316AbjGDNku (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 09:40:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229943AbjGDNkt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 09:40:49 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58749E6B
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jul 2023 06:40:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=RsWQRKx/OeoTvY5pK5rxepY6U2b9R4mbMkfTJjNifSQ=; b=ox7WX9yAj0+KCrkHFWSZls1lw9
        5lO8dOaMK8RFQVwX0rg6uyhtB0ar8HB/GXCZPoKD/XWiUp8PetmGlgb+ru6qImq81dOFAO1vxUcyn
        niUt1MKSeWx5GV9NjTC0hsfbFwb/uNcCM0BU3lPHuMwio93tNfUSHyYW088OtobYwzxrGSqtn5Qf8
        Wc12zi9UEZlMnrbVjY+td3Nt0dKQbTRMaGlz1T6+SsKsCnTtWGo0v2QNsTDJAnBFXduHFUPAc5RRH
        dDp5E3i8sTNmdBN2Fjz99Ez0sYLoDsuNtn+R0dQgx+0zt7uW8M9/GAYoxKMU6VqiyDCtYCWogedF4
        LUEkSGiw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qGgGX-00AvzF-2N;
        Tue, 04 Jul 2023 13:40:26 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 148373001CD;
        Tue,  4 Jul 2023 15:40:25 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id E92912028FBD7; Tue,  4 Jul 2023 15:40:24 +0200 (CEST)
Date:   Tue, 4 Jul 2023 15:40:24 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Tobias Huschle <huschle@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org, mingo@redhat.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        sshegde@linux.vnet.ibm.com, srikar@linux.vnet.ibm.com,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [RFC 1/1] sched/fair: Consider asymmetric scheduler groups in
 load balancer
Message-ID: <20230704134024.GV4253@hirez.programming.kicks-ass.net>
References: <20230515114601.12737-1-huschle@linux.ibm.com>
 <20230515114601.12737-2-huschle@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230515114601.12737-2-huschle@linux.ibm.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 15, 2023 at 01:46:01PM +0200, Tobias Huschle wrote:
> The current load balancer implementation implies that scheduler groups,
> within the same domain, all host the same number of CPUs. This is
> reflected in the condition, that a scheduler group, which is load
> balancing and classified as having spare capacity, should pull work
> from the busiest group, if the local group runs less processes than
> the busiest one. This implies that these two groups should run the
> same number of processes, which is problematic if the groups are not 
> of the same size.
> 
> The assumption that scheduler groups within the same scheduler domain
> host the same number of CPUs appears to be true for non-s390 
> architectures.

Mostly; there's historically the cpuset case where we can create
lopsided groups like that. And today we're growing all these hybrid
things that will also tickle this, except they're looking towards
different balancer extentions to deal with the IPC difference so might
not be immediately caring about this here issue.


> Signed-off-by: Tobias Huschle <huschle@linux.ibm.com>
> ---
>  kernel/sched/fair.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 48b6f0ca13ac..b1307d7e4065 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -10426,7 +10426,8 @@ static struct sched_group *find_busiest_group(struct lb_env *env)
>  	 * group's child domain.
>  	 */
>  	if (sds.prefer_sibling && local->group_type == group_has_spare &&
> -	    busiest->sum_nr_running > local->sum_nr_running + 1)
> +	    busiest->sum_nr_running * local->group_weight >
> +			local->sum_nr_running * busiest->group_weight + 1)

Should that not be: busiest->group_weight * (local->sum_nr_running + 1) ?

I'm not opposed to this -- it seems fairly straight forward.

>  		goto force_balance;
>  
>  	if (busiest->group_type != group_overloaded) {
> -- 
> 2.34.1
> 
