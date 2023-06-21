Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4163A7382C7
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 14:13:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232429AbjFULTL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 07:19:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232298AbjFULSY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 07:18:24 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 868381BC
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 04:18:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=NTnjGZKBu9TEe19lHWWEX9W303Dh2DKZfeOIZZMKAR8=; b=V4RocZfXblFLdVojirHUgpuHi4
        BN1wr42TI+yB6elo4QjVPFiE4NVSB8EPLpY+O/UpCdm9191ekTVUl+Zzrj/+5iP8U2y2RqjnG11CB
        u6dW7ZcQf5dExDGUQ4RKUVeXj891ZOlyJEmHdRIMPA4IMpMmPwCKJH41sylyibSYJfoFT1J5HL6N7
        bFXOKgaj6E6997w+mHKUQxe+fcOEOJpJR53MUb1Pqq0RvuyvHfg2X54g8P7JJOSybAvUKt8fgREQG
        InNLoM4Z2wQvgKRcgDwK6NQHkVY7bid5WSAjGBr922WqqW4Oqn6aDRceT6XHFZl8w2HXPDbkBihSW
        /KhKKBOw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qBvq0-00HOeE-1k;
        Wed, 21 Jun 2023 11:17:24 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 65ED23002F0;
        Wed, 21 Jun 2023 13:17:21 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 4CF22246D37FC; Wed, 21 Jun 2023 13:17:21 +0200 (CEST)
Date:   Wed, 21 Jun 2023 13:17:21 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Chen Yu <yu.c.chen@intel.com>
Cc:     Vincent Guittot <vincent.guittot@linaro.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Tim Chen <tim.c.chen@intel.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        Abel Wu <wuyun.abel@bytedance.com>,
        "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
        Len Brown <len.brown@intel.com>,
        Chen Yu <yu.chen.surf@gmail.com>,
        Yicong Yang <yangyicong@hisilicon.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 3/4] sched/fair: Calculate the scan depth for idle
 balance based on system utilization
Message-ID: <20230621111721.GA2053369@hirez.programming.kicks-ass.net>
References: <cover.1686554037.git.yu.c.chen@intel.com>
 <bc96b53efb712337a645e2c2a340975545ed5a28.1686554037.git.yu.c.chen@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bc96b53efb712337a645e2c2a340975545ed5a28.1686554037.git.yu.c.chen@intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 13, 2023 at 12:18:57AM +0800, Chen Yu wrote:
> When CPU is about to enter idle, it invokes newidle_balance() to pull
> some tasks from other runqueues. Although there is per domain
> max_newidle_lb_cost to throttle the newidle_balance(), it would be
> good to further limit the scan based on overall system utilization.
> The reason is that there is no limitation for newidle_balance() to
> launch this balance simultaneously on multiple CPUs. Since each
> newidle_balance() has to traverse all the CPUs to calculate the
> statistics one by one, this total time cost on newidle_balance()
> could be O(n^2). This is not good for performance or power saving.

Another possible solution is to keep struct sg_lb_stats in
sd->child->shared (below the NUMA domains) and put a lock around it.

Then have update_sd_lb_stats() do something like:

	struct sg_lb_stats *sgs = &sds->sgs;

	if (raw_spin_trylock(&sds->sg_lock)) {
		struct sg_lb_stats tmp;

		... collect tmp

		sds->sgs = tmp;
		raw_spin_unlock(&sds->sg_lock);
	}

	... use sgs

Then you know you've always got a 'recent' copy but avoid the concurrent
updates.
