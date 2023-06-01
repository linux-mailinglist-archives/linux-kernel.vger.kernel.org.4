Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF8D5719510
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 10:09:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232003AbjFAIJd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 04:09:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231513AbjFAIJb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 04:09:31 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0601AA;
        Thu,  1 Jun 2023 01:09:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=mtFgV8eACLKQFJHJFujVPURFtEkzWXu7lq5nF4jbGSQ=; b=IbmC7XvsXQkC5nJUxTNhIGjBIj
        +r4c/LAOPXcaZvHzbkvWkp/9avzr8ozwFDKkQ7dtulElh6Qr5RAlEEDm/ok1CUEPPaLmBzjFOcAm6
        ZHhFe9YUkWQtI57I8glUeMecrZ82km4f3gnLJjSCFnwTHUY6BE5YEQSUodYJ5e3f8TPGdhqkUbk2v
        GtmYbIWsNcrZQI3JzsTZBLfYmHXAgxdPEQab2nfPeijmWS2kMHk2FXiJQO0hUZlgBkgt/p7AwsaDC
        EaJNm6SUHIVxTukHf2ykmf5LyiKuRD5+YlfjtYhyk2sFySEuk/wJRNg1l19xjl0Wtu7qrzDp38AR5
        g7LNVB1w==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1q4dMz-0089bt-GH; Thu, 01 Jun 2023 08:09:17 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 7AA323002F0;
        Thu,  1 Jun 2023 10:09:14 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 44FD5212B5B01; Thu,  1 Jun 2023 10:09:14 +0200 (CEST)
Date:   Thu, 1 Jun 2023 10:09:14 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Abel Wu <wuyun.abel@bytedance.com>
Cc:     linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org,
        Tejun Heo <tj@kernel.org>, x86@kernel.org
Subject: Re: [tip: sched/core] sched/fair: Multi-LLC select_idle_sibling()
Message-ID: <20230601080914.GQ4253@hirez.programming.kicks-ass.net>
References: <168553468754.404.2298362895524875073.tip-bot2@tip-bot2>
 <5903fc0a-787e-9471-0256-77ff66f0bdef@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5903fc0a-787e-9471-0256-77ff66f0bdef@bytedance.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 01, 2023 at 11:41:14AM +0800, Abel Wu wrote:
> On 5/31/23 8:04 PM, tip-bot2 for Peter Zijlstra wrote:
> > The following commit has been merged into the sched/core branch of tip:
> > 
> > Commit-ID:     c7dfd6b9122d29d0e9a4587ab470c0564d7f92ab
> > Gitweb:        https://git.kernel.org/tip/c7dfd6b9122d29d0e9a4587ab470c0564d7f92ab
> > Author:        Peter Zijlstra <peterz@infradead.org>
> > AuthorDate:    Tue, 30 May 2023 13:20:46 +02:00
> > Committer:     Peter Zijlstra <peterz@infradead.org>
> > CommitterDate: Tue, 30 May 2023 22:46:27 +02:00
> > 
> > sched/fair: Multi-LLC select_idle_sibling()
> > 
> > Tejun reported that when he targets workqueues towards a specific LLC
> > on his Zen2 machine with 3 cores / LLC and 4 LLCs in total, he gets
> > significant idle time.
> > 
> > This is, of course, because of how select_idle_sibling() will not
> > consider anything outside of the local LLC, and since all these tasks
> > are short running the periodic idle load balancer is ineffective.
> > 
> > And while it is good to keep work cache local, it is better to not
> > have significant idle time. Therefore, have select_idle_sibling() try
> > other LLCs inside the same node when the local one comes up empty.
> > 
> > Reported-by: Tejun Heo <tj@kernel.org>
> > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
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
> > +		if (sd_child != sd) {
> 
> Since sd_llc is cpu private, I think it should be:
> 
> 		if (!cpus_share_cache(cpu, target))

Hmm, yes.. either that or ensure sd is from the first cpu in it's mask.
Let me go fix that.

Thanks!
