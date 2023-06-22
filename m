Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31D287395E3
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 05:48:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229902AbjFVDr7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 23:47:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbjFVDr4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 23:47:56 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D88821BCA
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 20:47:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Cc:Content-ID:Content-Description;
        bh=F3XXSu+N1iG+/xUm80loSBe6g1P122NWH55Ml+HL9xU=; b=hm5x5ZJzRK4Wj6AO+gBh/YY6+p
        1eV36gEX3YoHNbyYmLzVBSoTxhtjw1erJMNI9DYuljQdk1I3vXQviPDf/CArFrmNvtpqa4i06DQpo
        qjeekb4BEj+EYN31Le8HFbpGVZ4hc6vG5ZLfzdokJdsVAi4qWtZ32jUepmCsvf6LIX9tnmMEVOIA4
        01N9WSua5dRS+4ozAUwR09wTC70Q6vQP0C//Da+dszS9sXnzHH0XRO48CnDrgqKIrkgvtxJAYLtkZ
        cGI8iQcMsMx2KGP38vSi63R2KcgyNYUjHrEBtvbYN6149dBRkkjnxXbDsVLvti1DtUSQoCm5iATUw
        l/ekxF4w==;
Received: from [2601:1c2:980:9ec0::2764]
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qCBIY-00GhRq-2g;
        Thu, 22 Jun 2023 03:47:54 +0000
Message-ID: <88e569b6-69d6-90c2-8000-9dd542aaf007@infradead.org>
Date:   Wed, 21 Jun 2023 20:47:54 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH] workqueue: add cmdline parameter `unbound_workqueue_cpus`
 to further constrain wq_unbound_cpumask at boot time
Content-Language: en-US
To:     tj@kernel.org, jiangshanlai@gmail.com,
        linux-kernel@vger.kernel.org, zyhtheonly@yeah.net,
        zwp10758@gmail.com, zyhtheonly@gmail.com
References: <20230622033353.GA29115@didi-ThinkCentre-M930t-N000>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20230622033353.GA29115@didi-ThinkCentre-M930t-N000>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/21/23 20:34, tiozhang wrote:
> Motivation of doing this is to better improve boot times for devices when
> we want to prevent our workqueue works from running on some specific CPUs,
> e,g, some CPUs are busy with interrupts.
> 
> Signed-off-by: tiozhang <tiozhang@didiglobal.com>
> ---
>  kernel/workqueue.c | 25 +++++++++++++++++++++++++
>  1 file changed, 25 insertions(+)
> 

Documentation for this new command line parameter should be added to
Documentation/admin-guide/kernel-parameters.rst (in alphabetical order).

Thanks.

> diff --git a/kernel/workqueue.c b/kernel/workqueue.c
> index 7cd5f5e7e0a1..47e7b29df5fe 100644
> --- a/kernel/workqueue.c
> +++ b/kernel/workqueue.c
> @@ -329,6 +329,9 @@ static bool workqueue_freezing;		/* PL: have wqs started freezing? */
>  /* PL: allowable cpus for unbound wqs and work items */
>  static cpumask_var_t wq_unbound_cpumask;
>  
> +/* for further constrain wq_unbound_cpumask by cmdline parameter*/
> +static cpumask_var_t wq_cmdline_cpumask;
> +
>  /* CPU where unbound work was last round robin scheduled from this CPU */
>  static DEFINE_PER_CPU(int, wq_rr_cpu_last);
>  
> @@ -6006,6 +6009,10 @@ void __init workqueue_init_early(void)
>  	cpumask_copy(wq_unbound_cpumask, housekeeping_cpumask(HK_TYPE_WQ));
>  	cpumask_and(wq_unbound_cpumask, wq_unbound_cpumask, housekeeping_cpumask(HK_TYPE_DOMAIN));
>  
> +	if (!cpumask_empty(wq_cmdline_cpumask))
> +		cpumask_and(wq_unbound_cpumask, wq_unbound_cpumask, wq_cmdline_cpumask);
> +	free_bootmem_cpumask_var(wq_cmdline_cpumask);
> +
>  	pwq_cache = KMEM_CACHE(pool_workqueue, SLAB_PANIC);
>  
>  	/* initialize CPU pools */
> @@ -6129,3 +6136,21 @@ void __init workqueue_init(void)
>   */
>  void __warn_flushing_systemwide_wq(void) { }
>  EXPORT_SYMBOL(__warn_flushing_systemwide_wq);
> +
> +
> +static int __init unbound_workqueue_cpus_setup(char *str)
> +{
> +	cpumask_var_t cpumask;
> +
> +	alloc_bootmem_cpumask_var(&wq_cmdline_cpumask);
> +	alloc_bootmem_cpumask_var(&cpumask);
> +	if (cpulist_parse(str, cpumask) < 0)
> +		pr_warn("unbound_workqueue_cpus: incorrect CPU range\n");
> +	else
> +		cpumask_copy(wq_cmdline_cpumask, cpumask);
> +
> +	free_bootmem_cpumask_var(cpumask);
> +
> +	return 0;
> +}
> +__setup("unbound_workqueue_cpus=", unbound_workqueue_cpus_setup);

-- 
~Randy
