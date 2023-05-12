Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B466F7006DF
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 13:32:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241005AbjELLcx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 07:32:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240422AbjELLcs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 07:32:48 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72684D05E
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 04:32:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=fr5RqDNuP9UAJWvYniAU4zJwVuLlQEbB7PDS1yiTKlw=; b=eZ+p05ttQr/MYRdZJx+VXIgKyq
        BJMDMK+r919KyMi66mcLxIflfDMrEmaq7DdDituZ3R44cUQcQWPXKSMv7PVeBK+75s8jbqZJh2H3W
        bNFBGQmQgCUt+NI4Ju/r/wq2iaieBbPu6LzUvTKgaZ80i6PJNxcrWSm3QNmi9i3bzaLNSxbGsMk3Y
        5qevhzHWI/8Y4ziZM/86GTX3D1QN/C9VAzZAXlWaZODODakZnppu98mM8TW7HSUA8X8xS9ck5vmRB
        O7Noc805CYBykbrLHzynCjIIMoP1oONbAmHU655D0awnWYdi8y/nO8uGV3KZJLRwZNzOuSl0gdTqL
        DBiLL83w==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pxR0k-000ecj-16; Fri, 12 May 2023 11:32:34 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id E3495300338;
        Fri, 12 May 2023 13:32:32 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id C22D02C8B6AAE; Fri, 12 May 2023 13:32:32 +0200 (CEST)
Date:   Fri, 12 May 2023 13:32:32 +0200
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
Message-ID: <20230512113232.GX4253@hirez.programming.kicks-ass.net>
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

> diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
> index e3211455b203..3b902f533214 100644
> --- a/kernel/sched/cpufreq_schedutil.c
> +++ b/kernel/sched/cpufreq_schedutil.c
> @@ -155,10 +155,11 @@ static unsigned int get_next_freq(struct sugov_policy *sg_policy,
>  
>  static void sugov_get_util(struct sugov_cpu *sg_cpu)
>  {
> +	unsigned long util = cpu_util_cfs(sg_cpu->cpu, 1);
>  	struct rq *rq = cpu_rq(sg_cpu->cpu);
>  
>  	sg_cpu->bw_dl = cpu_bw_dl(rq);
> -	sg_cpu->util = effective_cpu_util(sg_cpu->cpu, cpu_util_cfs(sg_cpu->cpu),
> +	sg_cpu->util = effective_cpu_util(sg_cpu->cpu, util,
>  					  FREQUENCY_UTIL, NULL);
>  }
>  
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 1220cfbee258..3a10fe5988d6 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c

> @@ -7355,7 +7362,7 @@ eenv_pd_max_util(struct energy_env *eenv, struct cpumask *pd_cpus,
>  
>  	for_each_cpu(cpu, pd_cpus) {
>  		struct task_struct *tsk = (cpu == dst_cpu) ? p : NULL;
> -		unsigned long util = cpu_util(cpu, p, dst_cpu);
> +		unsigned long util = cpu_util(cpu, p, dst_cpu, 1);
>  		unsigned long cpu_util;
>  
>  		/*

> @@ -10561,7 +10568,7 @@ static struct rq *find_busiest_queue(struct lb_env *env,
>  			break;
>  
>  		case migrate_util:
> -			util = cpu_util_cfs(i);
> +			util = cpu_util_cfs(i, 1);
>  
>  			/*
>  			 * Don't try to pull utilization from a CPU with one

When you move that comment from cpu_util_cfs() to cpu_util() please also
add a paragraph about why boost=1 and why these locations, because I'm
sure we're going to be asking ouselves that at some point.


