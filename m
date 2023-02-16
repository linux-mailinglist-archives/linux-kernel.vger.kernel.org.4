Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A0D3699422
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 13:17:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230101AbjBPMRI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 07:17:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229738AbjBPMRH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 07:17:07 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82CDA1BC3
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 04:17:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=FK9tWpvZ7mp27Zap/9OAx2LxADWYfZtTRCAted4oMfg=; b=EUvZYElmUVevJ9D8MA8O2yAhV+
        jQrVTHMM5qShE8fVV+5rVzMNseYAhlUGoLIu+kOpfUO7NZ0uHTkcaUuP6t9VHeyZCDFtxlxDTFvLo
        RXCdPeW77+pbepBGWF7HKBbPDtnnuYU+EvLdnWIN7hZqS6nSQyQckw+hQHTnhmgYJKWXf1a97An17
        glbC0OGlpuypfDmfIkm74TpCAhFr4qBmMmW4SDnq+YXdfrqch3TMJQtmYUDBH9x9aH3NmkQ7IdKoI
        KYLsP9Q5Lf9e6tWHF+/W/ZPh3dHOXyATwEHRWWH8gYBsfySNkVUDoZ1E4H1GwmlZZ9R8EL3tmBQrW
        /FkelnKw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pSdBC-00AGvj-2h;
        Thu, 16 Feb 2023 12:16:45 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id B4E8B3001E5;
        Thu, 16 Feb 2023 13:16:42 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 7304C20CB2A44; Thu, 16 Feb 2023 13:16:42 +0100 (CET)
Date:   Thu, 16 Feb 2023 13:16:42 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Cc:     Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Ricardo Neri <ricardo.neri@intel.com>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Ben Segall <bsegall@google.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Len Brown <len.brown@intel.com>, Mel Gorman <mgorman@suse.de>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Ionela Voinescu <ionela.voinescu@arm.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, "Tim C . Chen" <tim.c.chen@intel.com>
Subject: Re: [PATCH v3 06/10] sched/fair: Use the prefer_sibling flag of the
 current sched domain
Message-ID: <Y+4eqmq22fDuFZAJ@hirez.programming.kicks-ass.net>
References: <20230207045838.11243-1-ricardo.neri-calderon@linux.intel.com>
 <20230207045838.11243-7-ricardo.neri-calderon@linux.intel.com>
 <Y+YXrk5NRuWaSOGR@hirez.programming.kicks-ass.net>
 <xhsmhmt5lr2nz.mognet@vschneid.remote.csb>
 <Y+Z2b/OtZDk9cT53@hirez.programming.kicks-ass.net>
 <xhsmhk00pqwap.mognet@vschneid.remote.csb>
 <20230210183155.GA11997@ranerica-svr.sc.intel.com>
 <8300f288-7157-5e2d-3bb3-badcffd15d34@arm.com>
 <20230214064328.GA11859@ranerica-svr.sc.intel.com>
 <20230216052105.GA20785@ranerica-svr.sc.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230216052105.GA20785@ranerica-svr.sc.intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 15, 2023 at 09:21:05PM -0800, Ricardo Neri wrote:

> I tweaked the solution that Dietmar proposed:
> 
> -	sds->prefer_sibling = child && child->flags & SD_PREFER_SIBLING;
> +	if (sds->busiest)
> +		sds->prefer_sibling = sds->busiest->flags & SD_PREFER_SIBLING;
> 
> This comes from the observation that the prefer_sibling setting acts on
> busiest group. It then depends on whether the busiest group, not the local
> group, has child sched sched domains. Today it works because in most cases
> both the local and the busiest groups have child domains with the SD_
> PREFER_SIBLING flag.
> 
> This would also satisfy sched domains with the SD_ASYM_CPUCAPACITY flag as
> prefer_sibling would not be set in that case.
> 
> It would also conserve the current behavior at the NUMA level. We would
> not need to implement SD_SPREAD_TASKS.
> 
> This would both fix the SMT vs non-SMT bug and be less invasive.
> 
> Thoughts?

That does look nice. Be sure to put in a nice comment too.
