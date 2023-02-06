Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A932168C31B
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 17:24:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229681AbjBFQYO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 11:24:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbjBFQYN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 11:24:13 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 677536EAF
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 08:24:12 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 13265B81247
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 16:24:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21CBDC433D2;
        Mon,  6 Feb 2023 16:23:55 +0000 (UTC)
Date:   Mon, 6 Feb 2023 11:23:42 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Pietro Borrello <borrello@diag.uniroma1.it>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Dmitry Adamushko <dmitry.adamushko@gmail.com>,
        Cristiano Giuffrida <c.giuffrida@vu.nl>,
        "Bos, H.J." <h.j.bos@vu.nl>, Jakob Koschel <jkl820.git@gmail.com>,
        Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] sched: pick_next_rt_entity(): checked list_entry
Message-ID: <20230206112342.223d2c29@rorschach.local.home>
In-Reply-To: <20230128-list-entry-null-check-sched-v2-1-d8e010cce91b@diag.uniroma1.it>
References: <20230128-list-entry-null-check-sched-v2-1-d8e010cce91b@diag.uniroma1.it>
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

On Tue, 31 Jan 2023 13:01:16 +0000
Pietro Borrello <borrello@diag.uniroma1.it> wrote:

> index ed2a47e4ddae..c024529d8416 100644
> --- a/kernel/sched/rt.c
> +++ b/kernel/sched/rt.c
> @@ -1777,6 +1777,7 @@ static struct sched_rt_entity *pick_next_rt_entity(struct rt_rq *rt_rq)
>  	BUG_ON(idx >= MAX_RT_PRIO);
>  
>  	queue = array->queue + idx;
> +	SCHED_WARN_ON(list_empty(queue));

I wonder if we should make this:

	if (SCHED_WARN_ON(list_empty(queue)))
		return NULL;

>  	next = list_entry(queue->next, struct sched_rt_entity, run_list);
>  
>  	return next;
> @@ -1789,7 +1790,6 @@ static struct task_struct *_pick_next_task_rt(struct rq *rq)
>  
>  	do {
>  		rt_se = pick_next_rt_entity(rt_rq);
> -		BUG_ON(!rt_se);

		if (unlikely(!rt_se))
			return NULL;

-- Steve

>  		rt_rq = group_rt_rq(rt_se);
>  	} while (rt_rq);
>  

