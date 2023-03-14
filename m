Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAE6D6B8F17
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 11:00:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229868AbjCNKAE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 06:00:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229785AbjCNJ75 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 05:59:57 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 986862FCCB
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 02:59:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=97VKYwICbOHx1XIKx6Q8BzjIkflBjQMwSUfJuFvg78s=; b=FVu3uUGwKrMzwHNOwcmV/mUtOr
        xJpVBEw97Jgjnd9hxqq+LEldkAqMskIv1FRrMDx7vrgKw1k4k0jt9WmgVtB9717K+HPYLPq19ujZ+
        P6LdXW/xqHZtMPbn3VrtkVcZC3W8R86X0tV1C1lcyD0BSKYqfZHRCelyRnPcZ88eqwq4cJbuGARoz
        oQTdA1UTqS3p6Q7iT8A/nHF5M+0q8KtXpjESNhJznqaMAWSwhrhrNrSXQ+Cp9ldOYcsM0gqn88RXD
        5TukZQlS8mNRhiG7i5uHswrfW8eOf41DHbD2evDsa7iYHr9pSwsQ/ekWzVgnoTZELl6+DsZQFbPki
        WRJfGLIA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pc1RR-001jlM-2y;
        Tue, 14 Mar 2023 09:59:38 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 44819300293;
        Tue, 14 Mar 2023 10:59:37 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 0179323B4E89E; Tue, 14 Mar 2023 10:59:36 +0100 (CET)
Date:   Tue, 14 Mar 2023 10:59:36 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Shrikanth Hegde <sshegde@linux.vnet.ibm.com>
Cc:     mingo@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, bsegall@google.com, tglx@linutronix.de,
        srikar@linux.vnet.ibm.com, arjan@linux.intel.com,
        svaidy@linux.ibm.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V3] Interleave cfs bandwidth timers for improved single
 thread performance at low utilization
Message-ID: <20230314095936.GC1845660@hirez.programming.kicks-ass.net>
References: <20230223185153.1499710-1-sshegde@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230223185153.1499710-1-sshegde@linux.vnet.ibm.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 24, 2023 at 12:21:53AM +0530, Shrikanth Hegde wrote:
> CPU cfs bandwidth controller uses hrtimer. Currently there is no initial
> value set. Hence all period timers would align at expiry.
> This happens when there are multiple CPU cgroup's.
> 
> There is a performance gain that can be achieved here if the timers are
> interleaved when the utilization of each CPU cgroup is low and total
> utilization of all the CPU cgroup's is less than 50%. If the timers are
> interleaved, then the unthrottled cgroup can run freely without many
> context switches and can also benefit from SMT Folding. This effect will
> be further amplified in SPLPAR environment.
> 
> This commit adds a random offset after initializing each hrtimer. This
> would result in interleaving the timers at expiry, which helps in achieving
> the said performance gain.
> 
> This was tested on powerpc platform with 8 core SMT=8. Socket power was
> measured when the workload. Benchmarked the stress-ng with power
> information. Throughput oriented benchmarks show significant gain up to
> 25% while power consumption increases up to 15%.
> 
> Workload: stress-ng --cpu=32 --cpu-ops=50000.
> 1CG - 1 cgroup is running.
> 2CG - 2 cgroups are running together.
> Time taken to complete stress-ng in seconds and power is in watts.
> each cgroup is throttled at 25% with 100ms as the period value.
>            6.2-rc6                     |   with patch
> 8 core   1CG    power   2CG     power  |  1CG    power  2 CG    power
>         27.5    80.6    40      90     |  27.3    82    32.3    104
>         27.5    81      40.2    91     |  27.5    81    38.7     96
>         27.7    80      40.1    89     |  27.6    80    29.7    106
>         27.7    80.1    40.3    94     |  27.6    80    31.5    105
> 
> Latency might be affected by this change. That could happen if the CPU was
> in a deep idle state which is possible if we interleave the timers. Used
> schbench for measuring the latency. Each cgroup is throttled at 25% with
> period value is set to 100ms. Numbers are when both the cgroups are
> running simultaneously. Latency values don't degrade much. Some
> improvement is seen in tail latencies.
> 
> 		6.2-rc6        with patch
> Groups: 16
> 50.0th:          39.5            42.5
> 75.0th:         924.0           922.0
> 90.0th:         972.0           968.0
> 95.0th:        1005.5           994.0
> 99.0th:        4166.0          2287.0
> 99.5th:        7314.0          7448.0
> 99.9th:       15024.0         13600.0
> 
> Groups: 32
> 50.0th:         819.0           463.0
> 75.0th:        1596.0           918.0
> 90.0th:        5992.0          1281.5
> 95.0th:       13184.0          2765.0
> 99.0th:       21792.0         14240.0
> 99.5th:       25696.0         18920.0
> 99.9th:       33280.0         35776.0
> 
> Groups: 64
> 50.0th:        4806.0          3440.0
> 75.0th:       31136.0         33664.0
> 90.0th:       54144.0         58752.0
> 95.0th:       66176.0         67200.0
> 99.0th:       84736.0         91520.0
> 99.5th:       97408.0        114048.0
> 99.9th:      136448.0        140032.0
> 
> Signed-off-by: Shrikanth Hegde<sshegde@linux.vnet.ibm.com>
> Suggested-by: Peter Zijlstra <peterz@infradead.org>
> Suggested-by: Thomas Gleixner <tglx@linutronix.de>
> 
> Initial RFC PATCH, discussions and details on the problem:
> Link1: https://lore.kernel.org/lkml/5ae3cb09-8c9a-11e8-75a7-cc774d9bc283@linux.vnet.ibm.com/
> Link2: https://lore.kernel.org/lkml/9c57c92c-3e0c-b8c5-4be9-8f4df344a347@linux.vnet.ibm.com/

Picked up for tip/sched/core.
