Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B89546D5BBD
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 11:22:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234173AbjDDJWC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 05:22:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234140AbjDDJWA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 05:22:00 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A97D11981
        for <linux-kernel@vger.kernel.org>; Tue,  4 Apr 2023 02:21:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=r5aK41JlmJ+wuIMmAeBq19Fz0dTVrVv8FNnEIqiUcs0=; b=pl/uWVk2g8WaNL+TeyByZcKuir
        2DhHktRl0GxFg6D/gKiUOa+lBtcN+ihigAqKadwxiR09f1nXVr6oRt3mZGaqo1BvONkvcPAdf6tGs
        So9RcovZCAfF2R4Y1t3nFMJ6sEtr3DnLSqrg6Hq/D3CewOnF/IBhK/Mo7QDEj8tARvn2vNzje1hsO
        oew2b1plv8AQOVXAxhM7iP0LstnQ+Uy5uQnx6m7/NdpH3hykhXNFPw9VPdoYX+YmVBT+crgeWeCWH
        E4pqwkR3vxzrfnNYZ4JXL4+h7SxtbcTZFVbPQnmkrWzf04t1prmj1/LHdZd2IeRrNkhiOYHAbt5oD
        cmDUX0aQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pjcrN-009DaY-1x;
        Tue, 04 Apr 2023 09:21:49 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 992A930003A;
        Tue,  4 Apr 2023 11:21:48 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 7F113242109F9; Tue,  4 Apr 2023 11:21:48 +0200 (CEST)
Date:   Tue, 4 Apr 2023 11:21:48 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     linux-kernel@vger.kernel.org, Aaron Lu <aaron.lu@intel.com>
Subject: Re: [RFC PATCH] sched: Fix performance regression introduced by
 mm_cid
Message-ID: <20230404092148.GC284733@hirez.programming.kicks-ass.net>
References: <20230403181342.210896-1-mathieu.desnoyers@efficios.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230403181342.210896-1-mathieu.desnoyers@efficios.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 03, 2023 at 02:13:42PM -0400, Mathieu Desnoyers wrote:
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 0d18c3969f90..775c7da6ec7f 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -2326,16 +2326,20 @@ static inline bool is_cpu_allowed(struct task_struct *p, int cpu)
>  static struct rq *move_queued_task(struct rq *rq, struct rq_flags *rf,
>  				   struct task_struct *p, int new_cpu)
>  {
> +	int cid;
> +
>  	lockdep_assert_rq_held(rq);
>  
>  	deactivate_task(rq, p, DEQUEUE_NOCLOCK);
>  	set_task_cpu(p, new_cpu);
> +	cid = sched_mm_cid_migrate_from(rq, p);
>  	rq_unlock(rq, rf);
>  
>  	rq = cpu_rq(new_cpu);
>  
>  	rq_lock(rq, rf);
>  	WARN_ON_ONCE(task_cpu(p) != new_cpu);
> +	sched_mm_cid_migrate_to(rq, p, cid);
>  	activate_task(rq, p, 0);
>  	check_preempt_curr(rq, p, 0);
>  

I can't find more uses? Yet there are a ton more ways to actually
migrate tasks.
