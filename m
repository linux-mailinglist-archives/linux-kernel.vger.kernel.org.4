Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17B4D743F70
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 18:06:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232809AbjF3QF7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 12:05:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230388AbjF3QF5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 12:05:57 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DB70A9
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jun 2023 09:05:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=newNkzFEJllKnCBciXY0VHCy4kHIzTBuLOvHfxzKinM=; b=pkqQOggUhgvgXuDJ1UwGQ3uNAf
        u6cBJDoIo+iGE3e8Xa9sZ4Z0ulMPovK2BqxqCQUI+xI+5E96oJj5upoq71Kz7FC3N/DfNVx6Lui+B
        Sr3uwyErKaRHjT98US1DX0entxMAqDZ02UMZHd7wtMZiq/ikeCeJ0HR5pAGEu0M5eVzurS5sRLUwu
        0D0z+fLouH45PLNcpSxmvRWoR1ZB57eNxlE+IbNYvHcXKDOYm3Mn5IlRsvxzrGXCiLquF1PirOPIl
        Q948Jsa8l8QiG0C/dWTpb8sevwRNkFwgJ2gnoQ9xRRe59EOqNOA6mmxpj6JGJ4lm4OkbLadMCtLfY
        zdVuxpdw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qFGcp-005pZw-7M; Fri, 30 Jun 2023 16:05:35 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 5C1C03002D9;
        Fri, 30 Jun 2023 18:05:34 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 478152C2A6C41; Fri, 30 Jun 2023 18:05:34 +0200 (CEST)
Date:   Fri, 30 Jun 2023 18:05:34 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Phil Auld <pauld@redhat.com>
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
Message-ID: <20230630160534.GA2534344@hirez.programming.kicks-ass.net>
References: <20230630135714.1018434-1-pauld@redhat.com>
 <20230630150641.GH2533791@hirez.programming.kicks-ass.net>
 <20230630152824.GC43299@lorien.usersys.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230630152824.GC43299@lorien.usersys.redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 30, 2023 at 11:28:24AM -0400, Phil Auld wrote:

> No. Or at least not without plumbing the enqueued/dequeued task all the way
> through.  I can do it that way if you prefer but that seemed a lot more
> intrusive. When we are in sched_can_stop_tick() we don't have access to the
> cfs task which will end up running. Curr is idle in that case.  We'd have to
> essential run pick_next_task_fair() to find the task to check which seemed
> wrong. Maybe there is a better way?

Ah, you worry about where we have two runnable tasks, one is bandwidth
constrained the other is not. One task goes away, how can we tell what
the remaining task is?

This is never a concern for add_nr_running(), the only case there is
0->1 and then only the hierarchy you just walked for enqueue is
relevant.

But if you remove the unconstrained task, sub_nr_running() can't tell
what the remaining task is.

Unless, of course, you have enqueue() set a bit somewhere in
task_struct::sched_bw_constrained:1.

Then pick and your should_stop thing can look at that, no?
