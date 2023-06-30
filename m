Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77D10743FD9
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 18:31:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232524AbjF3QbC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 12:31:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233053AbjF3Qao (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 12:30:44 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73C54449F
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jun 2023 09:29:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1688142576;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=v9Tnm8+RkpquEsyRl5/VynddgC5c1r8j2iKXHHOz2TI=;
        b=WzoFJpE2UUX0FARv/JVnJ5QNcaZADcbdIMSi2gBfX+PbqmSAnsSK2NC+BGAowvpNK8F47P
        UeFooaH6FnqLyCFhWLC8sPfp47I6hbBdWSG4a8aiWgyb8EiX2sdDny0Q9hGgqbgGRb0Tv0
        hEsFHbZPN7UKcI0mU3G1v7UVuDvnFYc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-199-FeVTz3k3OWiV_oiMp2cpBQ-1; Fri, 30 Jun 2023 12:29:31 -0400
X-MC-Unique: FeVTz3k3OWiV_oiMp2cpBQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id AE9CF8631DF;
        Fri, 30 Jun 2023 16:29:30 +0000 (UTC)
Received: from lorien.usersys.redhat.com (unknown [10.22.32.237])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 5E8DE2166B2D;
        Fri, 30 Jun 2023 16:29:13 +0000 (UTC)
Date:   Fri, 30 Jun 2023 12:29:10 -0400
From:   Phil Auld <pauld@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, Juri Lelli <juri.lelli@redhat.com>,
        Ingo Molnar <mingo@redhat.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Ben Segall <bsegall@google.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mel Gorman <mgorman@suse.de>,
        Frederic Weisbecker <frederic@kernel.org>
Subject: Re: [PATCH v4] Sched/fair: Block nohz tick_stop when cfs bandwidth
 in use
Message-ID: <20230630162910.GD43299@lorien.usersys.redhat.com>
References: <20230630135714.1018434-1-pauld@redhat.com>
 <20230630150641.GH2533791@hirez.programming.kicks-ass.net>
 <20230630152824.GC43299@lorien.usersys.redhat.com>
 <20230630160534.GA2534344@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230630160534.GA2534344@hirez.programming.kicks-ass.net>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 30, 2023 at 06:05:34PM +0200 Peter Zijlstra wrote:
> On Fri, Jun 30, 2023 at 11:28:24AM -0400, Phil Auld wrote:
> 
> > No. Or at least not without plumbing the enqueued/dequeued task all the way
> > through.  I can do it that way if you prefer but that seemed a lot more
> > intrusive. When we are in sched_can_stop_tick() we don't have access to the
> > cfs task which will end up running. Curr is idle in that case.  We'd have to
> > essential run pick_next_task_fair() to find the task to check which seemed
> > wrong. Maybe there is a better way?
> 
> Ah, you worry about where we have two runnable tasks, one is bandwidth
> constrained the other is not. One task goes away, how can we tell what
> the remaining task is?

It didn't even have to be an unconstrained task before I added the
check in sched_can_stop_tick(). But yes that check catches the case
where the one (still) running task is bw constrained.

> 
> This is never a concern for add_nr_running(), the only case there is
> 0->1 and then only the hierarchy you just walked for enqueue is
> relevant.
>

Right but we don't (currently) have the task here (hence the pick_next code).

> But if you remove the unconstrained task, sub_nr_running() can't tell
> what the remaining task is.
> 
> Unless, of course, you have enqueue() set a bit somewhere in
> task_struct::sched_bw_constrained:1.
> 
> Then pick and your should_stop thing can look at that, no?
> 

Yes.

I think you are agreeing that I need the pick next code but need to remove
the hierarchy walks, right?

If I set the bit in task_struct it would do that. I'll go poke at that. 


Thanks,
Phil

-- 

