Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CA266B24E4
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 14:06:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230432AbjCINF6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 08:05:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229905AbjCINFy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 08:05:54 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF287B693B
        for <linux-kernel@vger.kernel.org>; Thu,  9 Mar 2023 05:05:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=TZfdDs8qDZg5zNftRfBSY4rpDI3RPoFJwkprcQmgbBk=; b=q1CGsas7sgGsKNkg9VLjByeRfR
        WWZtURxvq8zfHnT4cvGUYE58ldfJPi1T4AtnZ6+XhzznuE2PM+5q+2gy2+l0NwnBv4xwIbOipvt8F
        1CmR/N5YLDyGlAIlc67LxSO7TR+zTdFk9fQOD2gqNurixRQBZROq7dKCmRiz8mkdtwh0M+Dwv7qEn
        pZ6pgaWiyAFpgoTUegfTrYfCoeQlMD+pwnoseLkGPd4TZAI3aejNxdusk0PPFuV/qTPOYyYOlYGuX
        90Tb5+kP2wh9AgHBZ0qonDrPByO5+D0/wu5CQkteKKDgQkT3D+mTcAGDzzDl8tS/Z4PF+v+QQpYJJ
        910TV7pg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1paFxY-0007bR-1a;
        Thu, 09 Mar 2023 13:05:29 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id DAE3D300033;
        Thu,  9 Mar 2023 14:05:24 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id B60602BBCE28C; Thu,  9 Mar 2023 14:05:24 +0100 (CET)
Date:   Thu, 9 Mar 2023 14:05:24 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Zhang Qiao <zhangqiao22@huawei.com>
Cc:     linux-kernel@vger.kernel.org, mingo@redhat.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        rkagan@amazon.de
Subject: Re: [PATCH v2] sched/fair: sanitize vruntime of entity being migrated
Message-ID: <20230309130524.GA273121@hirez.programming.kicks-ass.net>
References: <20230306132418.50389-1-zhangqiao22@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230306132418.50389-1-zhangqiao22@huawei.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 06, 2023 at 09:24:18PM +0800, Zhang Qiao wrote:
> Commit 829c1651e9c4 ("sched/fair: sanitize vruntime of
> entity being placed") fix an overflowing bug, but ignore
> a case that se->exec_start is reset after a migration.
> 
> For fixing this case, we reset the vruntime of a long
> sleeping task in migrate_task_rq_fair().
> 

> @@ -7635,7 +7653,23 @@ static void migrate_task_rq_fair(struct task_struct *p, int new_cpu)
>  	if (READ_ONCE(p->__state) == TASK_WAKING) {
>  		struct cfs_rq *cfs_rq = cfs_rq_of(se);
>  
> -		se->vruntime -= u64_u32_load(cfs_rq->min_vruntime);
> +		/*
> +		 * We determine whether a task sleeps for long by checking
> +		 * se->exec_start, and if it is, we sanitize its vruntime at
> +		 * place_entity(). However, after a migration, this detection
> +		 * method fails due to se->exec_start being reset.
> +		 *
> +		 * For fixing this case, we add the same check here. For a task
> +		 * which has slept for a long time, its vruntime should be reset
> +		 * to cfs_rq->min_vruntime with a sleep credit. Because waking
> +		 * task's vruntime will be added to cfs_rq->min_vruntime when
> +		 * enqueue, we only need to reset the se->vruntime of waking task
> +		 * to a credit here.
> +		 */
> +		if (entity_is_long_sleep(se))
> +			se->vruntime = -sched_sleeper_credit(se);
> +		else
> +			se->vruntime -= u64_u32_load(cfs_rq->min_vruntime);
>  	}

*groan*, that again...

Can't we simply do:

https://lkml.kernel.org/r/68832dfbb60fda030540b5f4e39c5801942689b1.1648228023.git.tim.c.chen@linux.intel.com

?
