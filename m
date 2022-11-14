Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 871B26283D5
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 16:28:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236450AbiKNP2Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 10:28:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235925AbiKNP2F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 10:28:05 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 434982182A
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 07:28:03 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id EA28D200EA;
        Mon, 14 Nov 2022 15:28:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1668439681; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=uDkYMib/GgFoYO8BWZmtdju3uBIq03u2DIghxhGO4I8=;
        b=O0AF/55j+K/svd24osGi4E7TePw3HIM3uMhRTnR/TtPTvhLhEvI25XqVRX5l99+PiXXypB
        ePPTFfdR4jfCnHVQv5XNPxjCjIvPSojxmdgrpelOClGdLXgKwm4QgfU5E1Cq653SJ+oOJp
        B0snGIaCGiA3e4Skfw2kOxyiUkiyCh8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1668439681;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=uDkYMib/GgFoYO8BWZmtdju3uBIq03u2DIghxhGO4I8=;
        b=cw6ZujkGBPClD762zIBWkyFN3xNhnCmFkYLmDyXcD/Wegc3anIhbKOK7yCGrtvIWvPSDLV
        SN0gba/8/680+FBQ==
Received: from suse.de (mgorman.udp.ovpn2.nue.suse.de [10.163.43.106])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id CAEBA2C142;
        Mon, 14 Nov 2022 15:28:00 +0000 (UTC)
Date:   Mon, 14 Nov 2022 15:27:56 +0000
From:   Mel Gorman <mgorman@suse.de>
To:     Tianchen Ding <dtcccc@linux.alibaba.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] sched: Clear ttwu_pending after enqueue_task
Message-ID: <20221114152756.aqfxp5wlh47ncjwi@suse.de>
References: <20221101073630.2797-1-dtcccc@linux.alibaba.com>
 <20221104023601.12844-1-dtcccc@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20221104023601.12844-1-dtcccc@linux.alibaba.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 04, 2022 at 10:36:01AM +0800, Tianchen Ding wrote:
> We found a long tail latency in schbench whem m*t is close to nr_cpus.
> (e.g., "schbench -m 2 -t 16" on a machine with 32 cpus.)
> 
> This is because when the wakee cpu is idle, rq->ttwu_pending is cleared
> too early, and idle_cpu() will return true until the wakee task enqueued.
> This will mislead the waker when selecting idle cpu, and wake multiple
> worker threads on the same wakee cpu. This situation is enlarged by
> commit f3dd3f674555 ("sched: Remove the limitation of WF_ON_CPU on
> wakelist if wakee cpu is idle") because it tends to use wakelist.
> 
> Here is the result of "schbench -m 2 -t 16" on a VM with 32vcpu
> (Intel(R) Xeon(R) Platinum 8369B).
> 
> Latency percentiles (usec):
>                 base      base+revert_f3dd3f674555   base+this_patch
> 50.0000th:         9                            13                 9
> 75.0000th:        12                            19                12
> 90.0000th:        15                            22                15
> 95.0000th:        18                            24                17
> *99.0000th:       27                            31                24
> 99.5000th:      3364                            33                27
> 99.9000th:     12560                            36                30
> 
> We also tested on unixbench and hackbench, and saw no performance
> change.
> 
> Signed-off-by: Tianchen Ding <dtcccc@linux.alibaba.com>

I tested this on bare metal across a range of machines. The impact of the
patch is nowhere near as obvious as it is on a VM but even then, schbench
generally benefits (not by as much and not always at all percentiles). The
only workload that appeared to suffer was specjbb2015 but *only* on NUMA
machines, on UMA it was fine and the benchmark can be a little flaky for
getting stable results anyway. In the few cases where it showed a problem,
the NUMA balancing behaviour was also different so I think it can be ignored.

In most cases it was better than vanilla and better than a revert or at
least made marginal differences that were borderline noise. However, avoiding
stacking tasks due to false positives is also important because even though
that can help performance in some cases (strictly sync wakeups), it's not
necessarily a good idea. So while it's not a universal win, it wins more
than it loses and it appears to be more clearly a win on VMs so on that basis

Acked-by: Mel Gorman <mgorman@suse.de>

-- 
Mel Gorman
SUSE Labs
