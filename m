Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 593AE62BB08
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 12:11:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239058AbiKPLLr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 06:11:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233746AbiKPLLW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 06:11:22 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D43C454B38
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 02:57:30 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 92F541F917;
        Wed, 16 Nov 2022 10:57:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1668596249; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1e07Z/KTHg2MfKfQrW/hU7xdJxwOoNY18Ye+Hw3SK8c=;
        b=KZYjeerS+nsjy3eWN0XXRUPeZ4wZiIs/EfES0OXfHGpb0RrZUh9E0qOnVPFZeiSE+8iOc4
        LbmtbWJuwibyNmt5IY/zqGpIisyFtChDflGh3Yww29S24oiz3dOtM0AfmOpQoPcFACnY3J
        ZAOlXU/bWKOAbKzWSrsnpXgAm+YyXIU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1668596249;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1e07Z/KTHg2MfKfQrW/hU7xdJxwOoNY18Ye+Hw3SK8c=;
        b=vBwWJPEN7UGibZOzoHF22sDslXAs6i6qKEI4BxjYKmLN21O3tIGbxnfW6wk3Jli7JCZRVh
        kPPuTDmYzliTUlDw==
Received: from suse.de (unknown [10.163.43.106])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 6E0EF2C14F;
        Wed, 16 Nov 2022 10:57:27 +0000 (UTC)
Date:   Wed, 16 Nov 2022 10:57:25 +0000
From:   Mel Gorman <mgorman@suse.de>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Andrei Vagin <avagin@google.com>, Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-kernel@vger.kernel.org, Andrei Vagin <avagin@gmail.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>
Subject: Re: [PATCH] sched: consider WF_SYNC to find idle siblings
Message-ID: <20221116105725.6hyyexgwexo52i5j@suse.de>
References: <20221027202603.670616-1-avagin@google.com>
 <Y1/GO1eWt+oTNA24@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <Y1/GO1eWt+oTNA24@hirez.programming.kicks-ass.net>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 31, 2022 at 01:57:31PM +0100, Peter Zijlstra wrote:
> On Thu, Oct 27, 2022 at 01:26:03PM -0700, Andrei Vagin wrote:
> > From: Andrei Vagin <avagin@gmail.com>
> > 
> > WF_SYNC means that the waker goes to sleep after wakeup, so the current
> > cpu can be considered idle if the waker is the only process that is
> > running on it.
> > 
> > The perf pipe benchmark shows that this change reduces the average time
> > per operation from 8.8 usecs/op to 3.7 usecs/op.
> > 
> > Before:
> >  $ ./tools/perf/perf bench sched pipe
> >  # Running 'sched/pipe' benchmark:
> >  # Executed 1000000 pipe operations between two processes
> > 
> >      Total time: 8.813 [sec]
> > 
> >        8.813985 usecs/op
> >          113456 ops/sec
> > 
> > After:
> >  $ ./tools/perf/perf bench sched pipe
> >  # Running 'sched/pipe' benchmark:
> >  # Executed 1000000 pipe operations between two processes
> > 
> >      Total time: 3.743 [sec]
> > 
> >        3.743971 usecs/op
> >          267096 ops/sec
> 
> But what; if anything, does it do for the myrad of other benchmarks we
> run?

Varies as expected.

For a basic IO benchmark like dbench, the headline difference is small
although on occasion bad for high thread counts. Variability tends to be
higher.

Tbench4 tended to look great for lower thread counts as it's quite
synchronous but regresses for larger thread counts.

perf pipe tends to look great as it's strictly synchronous. On one machine
(1 socket Skylake), it showed a regression of 27% but sometimes it was
the opposite with 70-80% gains depending on the machine.

Then something like netperf gets punished severely across all machines.
TCP_STREAM is variable but UDP_STREAM gets punished severely for all
machines. TCP_STREAM sometimes shows gains and losses but mostly losses
of around 5% except for 1 machine. UDP_STREAM consistently shows losses
in the 40-60% mark even for the simple case of running on a UMA machine

netperf-udp
                                  6.1.0-rc3              6.1.0-rc3
                                    vanilla      sched-wfsync-v1r1
Hmean     send-64         235.21 (   0.00%)      112.75 * -52.06%*
Hmean     send-128        475.87 (   0.00%)      227.27 * -52.24%*
Hmean     send-256        968.82 (   0.00%)      452.43 * -53.30%*
Hmean     send-1024      3859.30 (   0.00%)     1792.63 * -53.55%*
Hmean     send-2048      7720.07 (   0.00%)     3525.27 * -54.34%*
Hmean     send-3312     12095.78 (   0.00%)     5587.11 * -53.81%*
Hmean     send-4096     14498.47 (   0.00%)     6824.96 * -52.93%*
Hmean     send-8192     25713.27 (   0.00%)    12474.87 * -51.48%*
Hmean     send-16384    43537.08 (   0.00%)    23080.04 * -46.99%*

This is not too surprising as UDP_STREAM is blasting packets so there are
wakeups but the waker is not going to sleep immediately. So yeah, there are
cases where the patch helps but when it hurts, it can hurt a lot. The patch
certainly demonstrates that there is room for improvement on how WF_SYNC is
treated but as it stands, it would start a game of apply/revert ping-pong
as different bisections showed the patch caused one set of problems and
the revert caused another.

-- 
Mel Gorman
SUSE Labs
