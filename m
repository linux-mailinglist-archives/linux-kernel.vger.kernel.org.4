Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02C416FFBD0
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 23:24:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239033AbjEKVYK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 17:24:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238254AbjEKVYJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 17:24:09 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2EBE1992
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 14:24:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=YGvjbVJeEnnZOcEdB2dZ3X5QRK86G6DhtCmPpXVjJFM=; b=t4CGddKyKjlWEubeV7xtkTp3mT
        fB5NNhKE9zA/z68Khu5rdZz1qp8DeI+u5oIRH+6rLalRvfqLH/AQF7koUk5RJQ8ThTX2GtmObDJbS
        iVlL6JJEfhTZsYLN4h4N/JRM6yp0kkJyrnsZOmis6PqxTTXn5gbZ/k3HuXAxgrfAW9aeMaZsDPgZe
        iJymYkzWUKmwCk2WpYQkofF6sbI8gx+HWF/0EWx7KD+liDHW2WMMDN+ygwCsd1SxSt/oITp5sWL8f
        hOfCXjsgij4zkHPzj/lS3FrFeggOETED0o2Q00utRvLRbuz6wO11P4X/WknJ/xlfVkkef82rhP5Oe
        ZxhYAXUA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pxDlX-00HaK9-Bi; Thu, 11 May 2023 21:23:59 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id D93F1300244;
        Thu, 11 May 2023 23:23:58 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id B404A2C7C5BED; Thu, 11 May 2023 23:23:58 +0200 (CEST)
Date:   Thu, 11 May 2023 23:23:58 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Tejun Heo <tj@kernel.org>
Cc:     jiangshanlai@gmail.com, torvalds@linux-foundation.org,
        linux-kernel@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH 5/7] workqueue: Automatically mark CPU-hogging work items
 CPU_INTENSIVE
Message-ID: <20230511212358.GH2296992@hirez.programming.kicks-ass.net>
References: <20230511181931.869812-1-tj@kernel.org>
 <20230511181931.869812-6-tj@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230511181931.869812-6-tj@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 11, 2023 at 08:19:29AM -1000, Tejun Heo wrote:
> If a per-cpu work item hogs the CPU, it can prevent other work items from
> starting through concurrency management. A per-cpu workqueue which intends
> to host such CPU-hogging work items can choose to not participate in
> concurrency management by setting %WQ_CPU_INTENSIVE; however, this can be
> error-prone and difficult to debug when missed.
> 
> This patch adds an automatic CPU usage based detection. If a
> concurrency-managed work item consumes more CPU time than the threshold
> (10ms by default) continuously without intervening sleeps, wq_worker_tick()
> which is called from scheduler_tick() will detect the condition and
> automatically mark it CPU_INTENSIVE.
> 
> The mechanism isn't foolproof:
> 
> * Detection depends on tick hitting the work item. Getting preempted at the
>   right timings may allow a violating work item to evade detection at least
>   temporarily.

Right, if you have active tick avoidance in your work items you've got
bigger problems :-)

> * nohz_full CPUs may not be running ticks and thus can fail detection.

We do have sched_tick_remote() for the NOHZ_FULL case; it's all a big
can of tricky but it might just do -- if you really care ofc.

> * Even when detection is working, the 10ms detection delays can add up if
>   many CPU-hogging work items are queued at the same time.

HZ=100 assumption there :-) My HZs are bigger 'n yours etc.

> However, in vast majority of cases, this should be able to detect violations
> reliably and provide reasonable protection with a small increase in code
> complexity.
> 
> If some work items trigger this condition repeatedly, the bigger problem
> likely is the CPU being saturated with such per-cpu work items and the
> solution would be making them UNBOUND. The next patch will add a debug
> mechanism to help spot such cases.
> 
> v3: Switch to use wq_worker_tick() instead of hooking into preemptions as
>     suggested by Peter.
> 
> v2: Lai pointed out that wq_worker_stopping() also needs to be called from
>     preemption and rtlock paths and an earlier patch was updated
>     accordingly. This patch adds a comment describing the risk of infinte
>     recursions and how they're avoided.

I tend to prefer these changelog-changelogs to go below the --- so that
they go away on applying, they're not really relevant when reading the
patch in a year's time when trying to figure out wtf this patch did.

> Signed-off-by: Tejun Heo <tj@kernel.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Linus Torvalds <torvalds@linux-foundation.org>
> Cc: Lai Jiangshan <jiangshanlai@gmail.com>
> ---

Anyway, this seems entirely reasonable.

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>


