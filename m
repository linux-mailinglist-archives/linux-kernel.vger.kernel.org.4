Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4506738336
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 14:13:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232672AbjFULV0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 07:21:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232719AbjFULVL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 07:21:11 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C217E57
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 04:20:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=pzz3kAr/jtp/STGI1lj6cGLqTx0vMBu0KyQbjffPdII=; b=i3G3amVuidsra8ZYoCdCS5ZeAL
        rAAg6x28u5eU2suV0SRpx85/uf1773rWHAJvQGWWE2659aofcIzRnYx+4ba3mjQtllGq1Bdr3QYRz
        x/oe4zfnkofhA4ieDF88el6RCW2s4jss5ylaRKXhelTU/9ZI1fOh3GiZgcaPtV9oM8srjbw77l4Hb
        GoPE9NoL9bSSJ3uTbeifmyAi23fhEr7Ycl8KnGb+F0A0DeBcaK/tny5V8t/KuQ45XwsBaD7giJQf6
        amWa3mhzTqD78uS25E7dkBFDX6nuFvUfarnOiwv8YHEfC8v48Q5kt2PE7RmuyHjZHfBTR9e6PnRsc
        L+rexGcQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qBvsx-00HOjh-35;
        Wed, 21 Jun 2023 11:20:29 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 8F2AC3002F0;
        Wed, 21 Jun 2023 13:20:27 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 7750C246D37C5; Wed, 21 Jun 2023 13:20:27 +0200 (CEST)
Date:   Wed, 21 Jun 2023 13:20:27 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Gautham R. Shenoy" <gautham.shenoy@amd.com>
Cc:     Chen Yu <yu.c.chen@intel.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Tim Chen <tim.c.chen@intel.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        Abel Wu <wuyun.abel@bytedance.com>,
        Len Brown <len.brown@intel.com>,
        Chen Yu <yu.chen.surf@gmail.com>,
        Yicong Yang <yangyicong@hisilicon.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 3/4] sched/fair: Calculate the scan depth for idle
 balance based on system utilization
Message-ID: <20230621112027.GB2053369@hirez.programming.kicks-ass.net>
References: <cover.1686554037.git.yu.c.chen@intel.com>
 <bc96b53efb712337a645e2c2a340975545ed5a28.1686554037.git.yu.c.chen@intel.com>
 <ZIqpI0ScCT5pmrAO@BLR-5CG11610CF.amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZIqpI0ScCT5pmrAO@BLR-5CG11610CF.amd.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 15, 2023 at 11:31:07AM +0530, Gautham R. Shenoy wrote:

> Is there any particular reason why this is being limited only to the
> LLC domain ?

Yeah, agreed, this should be uniform across the domains below NUMA.
Above that we already have SD_SERIALIZE anyway -- and the interval is
fairly high.
