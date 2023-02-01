Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60F32686B1B
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 17:06:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232938AbjBAQGf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 11:06:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231665AbjBAQGe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 11:06:34 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAE86410BE
        for <linux-kernel@vger.kernel.org>; Wed,  1 Feb 2023 08:06:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=fj6ahy92rKfCR1279MTz18hOlL2WoO0toDXYsRxJvp4=; b=EFdNJ1jyIDj2naOFq/Lp1ePCzI
        v+g0t5/VuLUFRj2YJ4CzKsIZsz97VWAri1ycEN6hjC+WxUyzo9SkErQU0BzPXNRpzb/6JR+08dZWo
        K/FX3CuN2DfQ3hC6goXQWoVOQPrqMrQnk7SQ3E3kcRh8DIyWF0rc00Ra6bK/6zSD0p9LHO/InJHrt
        L7bPpuOLJMIg+zNBiFUVxX5T1Q9Ibn+6Y0Z91DKbkm34Clfd8K5bouv6uLok02X3yxOE3/iugXRDc
        8Z+UpBe0ovcXn8Ii7E0eNKrgvM4OSI4u22vcOIDVF/R/OJ7SMQotGfgL59uF2U0UftDUbsFcQ9Nvl
        90KY+Anw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pNFc3-004p6A-3B;
        Wed, 01 Feb 2023 16:05:32 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 1D8BE30031E;
        Wed,  1 Feb 2023 17:06:02 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id EC0DA23F285A9; Wed,  1 Feb 2023 17:06:01 +0100 (CET)
Date:   Wed, 1 Feb 2023 17:06:01 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Roman Kagan <rkagan@amazon.de>
Cc:     linux-kernel@vger.kernel.org, Juri Lelli <juri.lelli@redhat.com>,
        Zhang Qiao <zhangqiao22@huawei.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Waiman Long <longman@redhat.com>,
        Ben Segall <bsegall@google.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mel Gorman <mgorman@suse.de>,
        Valentin Schneider <vschneid@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Ingo Molnar <mingo@redhat.com>
Subject: Re: [PATCH v2] sched/fair: sanitize vruntime of entity being placed
Message-ID: <Y9qN6TEY/U4a8nks@hirez.programming.kicks-ass.net>
References: <20230130122216.3555094-1-rkagan@amazon.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230130122216.3555094-1-rkagan@amazon.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 30, 2023 at 01:22:16PM +0100, Roman Kagan wrote:
> From: Zhang Qiao <zhangqiao22@huawei.com>
> 
> When a scheduling entity is placed onto cfs_rq, its vruntime is pulled
> to the base level (around cfs_rq->min_vruntime), so that the entity
> doesn't gain extra boost when placed backwards.
> 
> However, if the entity being placed wasn't executed for a long time, its
> vruntime may get too far behind (e.g. while cfs_rq was executing a
> low-weight hog), which can inverse the vruntime comparison due to s64
> overflow.  This results in the entity being placed with its original
> vruntime way forwards, so that it will effectively never get to the cpu.
> 
> To prevent that, ignore the vruntime of the entity being placed if it
> didn't execute for much longer than the characteristic sheduler time
> scale.
> 
> Signed-off-by: Zhang Qiao <zhangqiao22@huawei.com>
> [rkagan: formatted, adjusted commit log, comments, cutoff value]
> Co-developed-by: Roman Kagan <rkagan@amazon.de>
> Signed-off-by: Roman Kagan <rkagan@amazon.de>

Thanks!
