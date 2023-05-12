Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCC897006A0
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 13:22:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240929AbjELLWq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 07:22:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241093AbjELLWl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 07:22:41 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E241186
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 04:22:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=k9tENOtTF4pQAE+JZzSZ4l7E5kO9k14V5nUvVvkpzPU=; b=FaGJV4VEgQPtxB9nUikY/10AlB
        Xhv7AvL6UteKPE7jX5YHtUFMs9lJ5U9XWQd46kTR4qbk9tv1+xcj4Pe9eVzjKoYPB4UPBitCXLGyz
        yCAOC+QF4X9EK34wF5bhbg3FNh4/d/AJOBCqzjs9S/MybW9AIZyBrxCe0gXLdCKNDHxvHIx3IjeyA
        wYXuiErR6ZG2+jDT6CkAkJ5vcmbLrLq1jO8aTnVTCoM1RLSp/d7YgiQ+sf7KzkEX4w7I8nEEC27rQ
        4o+pCU0MDo/i0bm7j5r6SfWhU3VRQHiFn+QFZzX9m+wPA+1zrrHiUxZRdmCSLwLUzgMT/rZhjEjY7
        JSSmfHIQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pxQr1-0098Hq-0x;
        Fri, 12 May 2023 11:22:31 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 256D4300338;
        Fri, 12 May 2023 13:22:29 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id D03E82C8B6AAE; Fri, 12 May 2023 13:22:29 +0200 (CEST)
Date:   Fri, 12 May 2023 13:22:29 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Qais Yousef <qyousef@layalina.io>,
        Kajetan Puchalski <kajetan.puchalski@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Vincent Donnefort <vdonnefort@google.com>,
        Quentin Perret <qperret@google.com>,
        Abhijeet Dharmapurikar <adharmap@quicinc.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] sched/fair, cpufreq: Introduce 'runnable boosting'
Message-ID: <20230512112229.GW4253@hirez.programming.kicks-ass.net>
References: <20230512101029.342823-1-dietmar.eggemann@arm.com>
 <20230512101029.342823-3-dietmar.eggemann@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230512101029.342823-3-dietmar.eggemann@arm.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 12, 2023 at 12:10:29PM +0200, Dietmar Eggemann wrote:

> -static unsigned long cpu_util(int cpu, struct task_struct *p, int dst_cpu)
> +static unsigned long
> +cpu_util(int cpu, struct task_struct *p, int dst_cpu, int boost)
>  {
>  	struct cfs_rq *cfs_rq = &cpu_rq(cpu)->cfs;
>  	unsigned long util = READ_ONCE(cfs_rq->avg.util_avg);
> +	unsigned long runnable;
> +
> +	runnable = boost ? READ_ONCE(cfs_rq->avg.runnable_avg) : 0;
> +	util = max(util, runnable);
>  
	if (boost)
		util = max(util, READ_ONCE(cfs_rq->avg.runnable_avg));


> @@ -7239,9 +7246,9 @@ static unsigned long cpu_util(int cpu, struct task_struct *p, int dst_cpu)
>   *
>   * Return: (Estimated) utilization for the specified CPU.
>   */

Given that cpu_util() is the base function should this comment move
there?

> -unsigned long cpu_util_cfs(int cpu)
> +unsigned long cpu_util_cfs(int cpu, int boost)
>  {
> -	return cpu_util(cpu, NULL, -1);
> +	return cpu_util(cpu, NULL, -1, boost);
>  }

AFAICT the @boost argument is always a constant (0 or 1). Would it not
make more sense to simply add:

unsigned long cpu_util_cfs_boost(int cpu)
{
	return cpu_util(cpu, NULL, -1, 1);
}

and use that in the few sites that actually need it?
