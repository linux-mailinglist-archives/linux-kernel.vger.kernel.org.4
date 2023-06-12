Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA58872D04A
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 22:15:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229479AbjFLUPF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 16:15:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236137AbjFLUO6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 16:14:58 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16C2210F5
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 13:14:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=6BbL2ODIFwkt+lqUgAMEgkVWfvfOK2CnYjX9LOgUDao=; b=Sr5GsWRlBf642yYB2WQx4VNriy
        O/KE3tt2MWjxmNdj3xPl/Orev5Bp6j14jGxm8ELabpIoul1cfR6ielJsyO2Vl19ICiS6Q6scvVzI6
        jzolMTgQMhE7gi8Z1H6Es8YC9UL8zRYUTpFLl0E7KISGSsMjAzjwOCRYitDUd3sUcCoUN7Ydrxf7W
        iXyF5uDkRVkGDViJmH/pib40nSqtBSi1y7GoyZzeM5oYP4exWr9V4fboPEEO5O6cXYQYwHck4yXVp
        Hak5upkLGmXJcswf8aUJH+26VR/a52uTNFBkWATBHAJjPtH6uWPQl/ClE0sE5C9CbiIJ1CPLyNVca
        NMoNYeKw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1q8nvb-00900q-3A;
        Mon, 12 Jun 2023 20:14:16 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id A4FB3300195;
        Mon, 12 Jun 2023 22:14:14 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 63C4D245BF230; Mon, 12 Jun 2023 22:14:14 +0200 (CEST)
Date:   Mon, 12 Jun 2023 22:14:14 +0200
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
        Chen Yu <yu.c.chen@intel.com>, Hillf Danton <hdanton@sina.com>
Subject: Re: [Patch v2 1/6] sched/fair: Determine active load balance for SMT
 sched groups
Message-ID: <20230612201414.GG83892@hirez.programming.kicks-ass.net>
References: <cover.1686263351.git.tim.c.chen@linux.intel.com>
 <253f5272200d3cec3f24427262bb4e95244f681c.1686263351.git.tim.c.chen@linux.intel.com>
 <20230612111359.GI4253@hirez.programming.kicks-ass.net>
 <f7dc49b5fb80b25ad1f3968a623f993da29c0526.camel@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f7dc49b5fb80b25ad1f3968a623f993da29c0526.camel@linux.intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 12, 2023 at 01:12:10PM -0700, Tim Chen wrote:
> How about making this modification to take care of SMT-4 case?
> 

Yep, that works.

> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 33246dce10db..e2261c24e536 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -9642,11 +9642,11 @@ static bool update_sd_pick_busiest(struct lb_env *env,
>         case group_has_spare:
>                 /*
>                  * Do not pick sg with SMT CPUs over sg with pure CPUs,
> -                * as we do not want to pull task off half empty SMT core
> +                * as we do not want to pull task off SMT core with one task
>                  * and make the core idle.
>                  */
>                 if (smt_vs_nonsmt_groups(sds->busiest, sg)) {
> -                       if (sg->flags & SD_SHARE_CPUCAPACITY)
> +                       if (sg->flags & SD_SHARE_CPUCAPACITY && sgs->sum_h_nr_running <= 1)
>                                 return false;
>                         else
>                                 return true;
> 
> 		
