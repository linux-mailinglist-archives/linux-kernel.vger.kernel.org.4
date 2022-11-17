Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BDFE62E7A6
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 23:02:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241053AbiKQWCY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 17:02:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241232AbiKQWCB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 17:02:01 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64BC384323
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 14:00:32 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0A8B1622A0
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 22:00:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22538C433D7;
        Thu, 17 Nov 2022 22:00:30 +0000 (UTC)
Date:   Thu, 17 Nov 2022 17:00:28 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Xuewen Yan <xuewen.yan@unisoc.com>
Cc:     <peterz@infradead.org>, <mingo@redhat.com>,
        <juri.lelli@redhat.com>, <vincent.guittot@linaro.org>,
        <dietmar.eggemann@arm.com>, <bsegall@google.com>,
        <mgorman@suse.de>, <bristot@redhat.com>, <vschneid@redhat.com>,
        <ke.wang@unisoc.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] sched/rt: Use cpu_active_mask to prevent
 rto_push_irq_work's dead loop
Message-ID: <20221117170028.04fd7013@gandalf.local.home>
In-Reply-To: <20221114120453.3233-1-xuewen.yan@unisoc.com>
References: <20221114120453.3233-1-xuewen.yan@unisoc.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 14 Nov 2022 20:04:53 +0800
Xuewen Yan <xuewen.yan@unisoc.com> wrote:

> +++ b/kernel/sched/rt.c
> @@ -2219,6 +2219,7 @@ static int rto_next_cpu(struct root_domain *rd)
>  {
>  	int next;
>  	int cpu;
> +	struct cpumask tmp_cpumask;

If you have a machine with thousands of CPUs, this will likely kill the
stack.

>  
>  	/*
>  	 * When starting the IPI RT pushing, the rto_cpu is set to -1,
> @@ -2238,6 +2239,11 @@ static int rto_next_cpu(struct root_domain *rd)
>  		/* When rto_cpu is -1 this acts like cpumask_first() */
>  		cpu = cpumask_next(rd->rto_cpu, rd->rto_mask);
>  
> +		cpumask_and(&tmp_cpumask, rd->rto_mask, cpu_active_mask);
> +		if (rd->rto_cpu == -1 && cpumask_weight(&tmp_cpumask) == 1 &&
> +		    cpumask_test_cpu(smp_processor_id(), &tmp_cpumask))
> +			break;
> +

Kill the above.

>  		rd->rto_cpu = cpu;
>  
>  		if (cpu < nr_cpu_ids) {

Why not just add here:

			if (!cpumask_test_cpu(cpu, cpu_active_mask))
				continue;
			return cpu;
		}

?

-- Steve
