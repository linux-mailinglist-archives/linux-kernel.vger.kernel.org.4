Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E070722F48
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 21:08:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230030AbjFETI3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 15:08:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232598AbjFETI1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 15:08:27 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0ABC011C;
        Mon,  5 Jun 2023 12:08:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=hL5n7COSgJewUYLdr3pIlMLv/l/WFdfImP62rc7BcMI=; b=Myozm7A9r8XitGgf7HiMO3Pvxc
        DzGg9y4BqW/BQ0bPlJ8mK9DWV2oZT37H1LiXBmY0i1R5hVSR9FTqDECfcyH9bvudES4l9sRRixqL7
        XRxe4pIw8k0xGWJzUFw0G3jF/cqaJ6SKc5bqSGpeCC7eV2iL8kWSC6Oug9OFpRQCQ7cOfcjw5qBbG
        IrNj+Xj7LHE2SjZZBvv7ncLelqnM1Qkmplsdu6Rr0Axsv3m6L1FU0kIkfQf+daoTDlY6nr1w15y4o
        q8rRqtFCgxnyo4RnSZMnGI6nxgAVJxcQMae4XAc72z6gf6p+NifPjz20oCgYRpVEgBQR+NlF72d5m
        oIdGK9BQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1q6FYS-003R2p-1P;
        Mon, 05 Jun 2023 19:07:49 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id B88F2300322;
        Mon,  5 Jun 2023 21:07:46 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 9C1C220AC06F4; Mon,  5 Jun 2023 21:07:46 +0200 (CEST)
Date:   Mon, 5 Jun 2023 21:07:46 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org,
        Tejun Heo <tj@kernel.org>, x86@kernel.org
Subject: Re: [tip: sched/core] sched/fair: Multi-LLC select_idle_sibling()
Message-ID: <20230605190746.GX83892@hirez.programming.kicks-ass.net>
References: <168553468754.404.2298362895524875073.tip-bot2@tip-bot2>
 <CGME20230605152531eucas1p2a10401ec2180696cc9a5f2e94a67adca@eucas1p2.samsung.com>
 <3051ad44-0ac3-e77b-3178-fac7cac3b3f2@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3051ad44-0ac3-e77b-3178-fac7cac3b3f2@samsung.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 05, 2023 at 05:25:30PM +0200, Marek Szyprowski wrote:

> nfortunately it causes 
> regression on my ARM 64bit Exynos5433-based TM2e test board during the 
> CPU hotplug tests. 

Can you elucidate an ARM illiterate on the actual topology of that
machine?


> CPU: 6 PID: 43 Comm: cpuhp/6 Not tainted 6.4.0-rc1+ #13640
> Hardware name: Samsung TM2E board (DT)
> pstate: 000000c5 (nzcv daIF -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> pc : __bitmap_and+0x4c/0x78
> lr : select_idle_cpu+0x64/0x450

Btw, where is lr at? Is that perhaps per_cpu(sd_llc) being NULL  or
something?


> > ---
> >   kernel/sched/fair.c     | 38 ++++++++++++++++++++++++++++++++++++++
> >   kernel/sched/features.h |  1 +
> >   2 files changed, 39 insertions(+)
> >
> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > index 48b6f0c..0172458 100644
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -7028,6 +7028,38 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, bool
> >   }
> >   
> >   /*
> > + * For the multiple-LLC per node case, make sure to try the other LLC's if the
> > + * local LLC comes up empty.
> > + */
> > +static int
> > +select_idle_node(struct task_struct *p, struct sched_domain *sd, int target)
> > +{
> > +	struct sched_domain *parent = sd->parent;
> > +	struct sched_group *sg;
> > +
> > +	/* Make sure to not cross nodes. */
> > +	if (!parent || parent->flags & SD_NUMA)
> > +		return -1;
> > +
> > +	sg = parent->groups;
> > +	do {
> > +		int cpu = cpumask_first(sched_group_span(sg));
> > +		struct sched_domain *sd_child;
> > +
> > +		sd_child = per_cpu(sd_llc, cpu);

IOW, sd_child end up NULL?

> > +		if (sd_child != sd) {
> > +			int i = select_idle_cpu(p, sd_child, test_idle_cores(cpu), cpu);
> > +			if ((unsigned)i < nr_cpumask_bits)
> > +				return i;
> > +		}
> > +
> > +		sg = sg->next;
> > +	} while (sg != parent->groups);
> > +
> > +	return -1;
> > +}
