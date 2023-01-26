Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4013E67CB40
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 13:50:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235766AbjAZMuO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 07:50:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231124AbjAZMuK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 07:50:10 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63309A6
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 04:50:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:To:From:Date:Sender:Reply-To:Cc:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=dHKjrNk/NFGrB7AaN6ANRgp7XpWy3EkjZ2gfuY4MtVk=; b=OKTG92AucWDvcIwAczYeSVilkE
        kNor1NC+5rArZvbrWxmxxTQ3R7LsLCTKCtMW/x33vaUtWrbmifuSX3Y/nxvjijHRSf2T66ZYpGxF4
        BXVaHhi+J/RaY5b+9uWkyhCfa+TQt8eq34C14kfuCUkTF9VhHJ7GFxwaoudwQEIrw7JgotK+QqR7L
        gkhflGFgu9gAcRlTEoJo1qfts7iW9n7cZ+Cj1bdkpzzwQui4aZXa2G42QgHv9VPTBUnj2uti5fbln
        2R6gMixVf/sql9IYeJPldVhtlSYMLkCRigCncgRmowV8i+a9awV8eeaEs61G+awte7XyE4oIgSIVE
        +Ajx/8Dg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pL1hK-006jmW-CV; Thu, 26 Jan 2023 12:49:46 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 5EFEB300652;
        Thu, 26 Jan 2023 13:49:43 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 23531203C2B1E; Thu, 26 Jan 2023 13:49:43 +0100 (CET)
Date:   Thu, 26 Jan 2023 13:49:43 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Roman Kagan <rkagan@amazon.de>,
        Zhang Qiao <zhangqiao22@huawei.com>,
        Waiman Long <longman@redhat.com>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: [bug-report] possible s64 overflow in max_vruntime()
Message-ID: <Y9J25xMrItpeHIxD@hirez.programming.kicks-ass.net>
References: <73e639d5-702b-0d03-16d9-a965b1963ef6@huawei.com>
 <Y6RRfF5yRew7rdCp@hirez.programming.kicks-ass.net>
 <Y9GG3N5ivVvyETa2@u40bc5e070a0153.ant.amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y9GG3N5ivVvyETa2@u40bc5e070a0153.ant.amazon.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 25, 2023 at 08:45:32PM +0100, Roman Kagan wrote:

> The calculation is indeed safe against the overflow of the vruntimes
> themselves.  However, when the two vruntimes are more than 2^63 apart,
> their comparison gets inverted due to that s64 overflow.

Yes, but that's a whole different issue. vruntime are not expected to be
*that* far apart.

That is surely the abnormal case. The normal case is wrap around, and
that happens 'often' and should continue working.

> And this is what happens here: one scheduling entity has accumulated a
> vruntime more than 2^63 ahead of another.  Now the comparison is
> inverted due to s64 overflow, and the latter can't get to the cpu,
> because it appears to have vruntime (much) bigger than that of the
> former.

If it can be 2^63 ahead, it can also be 2^(64+) ahead and nothing will
help.

> This situation is reproducible e.g. when one scheduling entity is a
> multi-cpu hog, and the other is woken up from a long sleep.  Normally

A very low weight CPU hog?

> when a task is placed on a cfs_rq, its vruntime is pulled to
> min_vruntime, to avoid boosting the woken up task.  However in this case
> the task is so much behind in vruntime that it appears ahead instead,
> its vruntime is not adjusted in place_entity(), and then it looses the
> cpu to the current scheduling entity.

What I think might be a way out here is passing the the sleep wall-time
(cfs_rq_clock_pelt() time I suppose) to place entity and simply skip the
magic if 'big'.

All that only matters for small sleeps anyway.

Something like:

	sleep_time = U64_MAX;
	if (se->avg.last_update_time)
	  sleep_time = cfs_rq_clock_pelt(cfs_rq) - se->avg.last_update_time;

	if (sleep_time > 60*NSEC_PER_SEC) { // 1 minute is huge
	  se->vruntime = cfs_rq->min_vruntime;
	  return;
	}

	// ... rest of place_entity()

Hmm... ?
