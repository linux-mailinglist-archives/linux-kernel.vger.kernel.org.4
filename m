Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 115E25F9A42
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 09:43:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232539AbiJJHnN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 03:43:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232500AbiJJHmZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 03:42:25 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 368C712D2F
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 00:37:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=8EgVy9ViY0ofGUrloiqV5BEx/NHdOj+9NbJK8esqUWc=; b=XUlx4lvD/8SgVzkg1iyqqyz073
        LutHEi+rCNt2nWAZzFCFIFD5TSfOHUUYeFdRLKJb44FN2yy22rW30eeyId9A3OwDBSGnzmjVmNe1u
        LlSoXb9mPOaUBreXjreSTJ4hb/BTo6o4Knlfi8pGho4zxUmT6ficgtyKwgyZjWeymylWv/HjSH9qk
        mPl27fBCNHpQX0/YoLaxnU0RO/t95Gn88/v3ab3/B+oBl9vy3wFXJ8w0bIAsmGTvDL/QnjdzeHXrk
        wAHVlRl86dfmCi4C0zK+0mZP4Z1NPseUlpPyzgD3O9etaIW7+SW+IEHBV2mwV3AJTHmEQ9LBGGk1P
        NK5JWdSA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ohnLi-002E95-FZ; Mon, 10 Oct 2022 07:37:18 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id C950E300023;
        Mon, 10 Oct 2022 09:37:14 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id A85892BF1DAC2; Mon, 10 Oct 2022 09:37:14 +0200 (CEST)
Date:   Mon, 10 Oct 2022 09:37:14 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Lin Shengwang <linshengwang1@huawei.com>
Cc:     mingo@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, aubrey.li@linux.intel.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        linux-kernel@vger.kernel.org, cj.chengjian@huawei.com
Subject: Re: [PATCH -next] sched/core: Fix the bug that traversal in
 sched_group_cookie_match is wrong
Message-ID: <Y0PLqng6tdbWA0/Z@hirez.programming.kicks-ass.net>
References: <20221008022709.642-1-linshengwang1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221008022709.642-1-linshengwang1@huawei.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 08, 2022 at 10:27:09AM +0800, Lin Shengwang wrote:
> In commit 97886d9dcd86 ("sched: Migration changes for core scheduling"),
> sched_group_cookie_match() was added to help finding cookie matched
> group, but was inconsistent with the actual purpose.
> 
> Using cpu_rq(cpu) instead of rq to fix the bug.
> 
> Fixes: 97886d9dcd86 ("sched: Migration changes for core scheduling")
> Signed-off-by: Lin Shengwang <linshengwang1@huawei.com>
> ---
>  kernel/sched/sched.h | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)
> 
> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index 23c6f9f42ba1..1ba602139840 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h

> @@ -1269,7 +1277,7 @@ static inline bool sched_group_cookie_match(struct rq *rq,
>  		return true;
>  
>  	for_each_cpu_and(cpu, sched_group_span(group), p->cpus_ptr) {
> -		if (sched_core_cookie_match(rq, p))
> +		if (sched_core_cookie_match(cpu_rq(cpu), p))
>  			return true;

Urgh.. Thanks!
