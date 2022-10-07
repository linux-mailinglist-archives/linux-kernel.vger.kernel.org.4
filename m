Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A94705F769A
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Oct 2022 12:02:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229603AbiJGKCV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Oct 2022 06:02:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229563AbiJGKCQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Oct 2022 06:02:16 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EDE6A8791
        for <linux-kernel@vger.kernel.org>; Fri,  7 Oct 2022 03:02:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=4hahp+Izp721BwnW+eNndYzSvuTszSLx1OVNf8pb7JA=; b=TRAEpnrHmsr5NA/PoMP+Vl44UR
        ZXOq/9onyiTOCghhTkM2dm6zjsOUHNcpuUgYAXUPquLHyyWx6IRJuHrYpSQCqP0LM1N0UpmR8vud9
        1qBbuoDgmG9c8CL82rOszLRZH0SoZvpXwGihHJuFFiIcsiWqRqOoOFs7IPlUNqx+9jERltNmjqfxd
        DkkuRvMSUGnmWMUjP4S1tJX5LXQvq62Y8aVMnECR3TbxBZ7XRCayl+wk1xZBFbMzShPzwMqCstPoj
        rj8MFfsqH2S9WoOHyTYu111OaJ7suK+aVD3Gyy20UXRZJzeE3edHSFIGmFBK3Z1aFI8zBzNBDuzXQ
        fCiU11vg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ogkAt-001ROh-QP; Fri, 07 Oct 2022 10:01:49 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 7E8D230007E;
        Fri,  7 Oct 2022 12:01:45 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 5A39B2BD38D6E; Fri,  7 Oct 2022 12:01:45 +0200 (CEST)
Date:   Fri, 7 Oct 2022 12:01:45 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>
Subject: Re: [PATCH v10 3/5] sched: Enforce user requested affinity
Message-ID: <Yz/5CZ8nj7MI+cO2@hirez.programming.kicks-ass.net>
References: <20220922180041.1768141-1-longman@redhat.com>
 <20220922180041.1768141-4-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220922180041.1768141-4-longman@redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 22, 2022 at 02:00:39PM -0400, Waiman Long wrote:
> @@ -9647,6 +9656,9 @@ void __init sched_init(void)
>  			cpumask_size(), GFP_KERNEL, cpu_to_node(i));
>  		per_cpu(select_rq_mask, i) = (cpumask_var_t)kzalloc_node(
>  			cpumask_size(), GFP_KERNEL, cpu_to_node(i));
> +		per_cpu(runqueues.scratch_mask, i) =
> +			(cpumask_var_t)kzalloc_node(cpumask_size(),
> +						    GFP_KERNEL, cpu_to_node(i));
>  	}
>  #endif /* CONFIG_CPUMASK_OFFSTACK */
>  

That doesn't actually apply; I've made it:

--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -9748,6 +9748,7 @@ void __init sched_init(void)
 
 		rq->core_cookie = 0UL;
 #endif
+		zalloc_cpumask_var_node(&per_cpu(runqueues.scratch_mask, i), GFP_KERNEL, cpu_to_node(i));
 	}
 
 	set_load_weight(&init_task, false);
