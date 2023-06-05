Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB1E9722DFF
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 19:56:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231254AbjFER4t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 13:56:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229974AbjFER4s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 13:56:48 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C572ED3;
        Mon,  5 Jun 2023 10:56:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=qtXPOVUwv/0vffgfXDo1OC5mmgba+WXT0tEe3GMrRTI=; b=vWHXAWSWQaOKQtVQyiIM8w32o5
        S9d50NCVYfTYOM1+rN+OUZPNKvAOhitkDF7uPC+JV2D/KIzK2ptB2xAOnCRmGIwXPOeI/c+6inMet
        UruFZyQtCN6T1+D1P8+CA7QJzvEsUTM9c5PtOS7p6qAkEUeh77oUwDkxfK8d4cmxm8IEJrQNJpI1c
        GhYkpetIQgRvubjdY9OYWxSErJpGZGrt1skMwaeqQmEPQcy4Er6NtzijDXgm6msfu8qHI0hP+xrro
        WUA4QuxIRDdYCO0s9Nge+slA6vofeU1XlKMBOfdrB1np7SJk1B3GiBNiL5iFl0Re+SsDjvG9t+u7i
        JxOqPVKg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1q6ERa-00CFr5-En; Mon, 05 Jun 2023 17:56:38 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 2265A30031B;
        Mon,  5 Jun 2023 19:56:37 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id F0D25244F9E2F; Mon,  5 Jun 2023 19:56:36 +0200 (CEST)
Date:   Mon, 5 Jun 2023 19:56:36 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org,
        Tejun Heo <tj@kernel.org>, x86@kernel.org,
        kprateek.nayak@amd.com
Subject: Re: [tip: sched/core] sched/fair: Multi-LLC select_idle_sibling()
Message-ID: <20230605175636.GA4253@hirez.programming.kicks-ass.net>
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
> On 31.05.2023 14:04, tip-bot2 for Peter Zijlstra wrote:
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
> 
> This patch landed in today's linux next-20230605 as commit c5214e13ad60 
> ("sched/fair: Multi-LLC select_idle_sibling()"). Unfortunately it causes 
> regression on my ARM 64bit Exynos5433-based TM2e test board during the 
> CPU hotplug tests. From time to time I get the NULL pointer dereference. 
> Reverting $subject on top of linux-next fixes the issue. Let me know if 
> I can help somehow debugging this issue. Here is a complete log (I've 
> intentionally kept all the stack dumps, although they don't look very 
> relevant...):

Moo... OK, since our friends from AMD need some tuning on this anyway,
i'm going to pull the patch entirely. And we'll try again once they've
sorted out the best way to do this.


