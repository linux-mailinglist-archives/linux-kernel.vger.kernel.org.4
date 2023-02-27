Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 740046A463E
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 16:41:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229897AbjB0PlA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 10:41:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229864AbjB0Pk6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 10:40:58 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2731233C8
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 07:40:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=EWERy2ZX+ci8h6fBPOkgknuqPhCIluqOB1x4vONuL2g=; b=ScF1acwowJj5meVgneRVn4aPNz
        +GXdEe09EGxXBNxRFubfDIkGLabaIN7eMjnP+PEjqyXJwC5FLtcvupcW7yDJbafHs+EGbmsH4cMmn
        AVW+YUZ6MGfPXHfISaf03XIP9jdZI1onDgPMzyEiwOZJhcJSrKvxmHTyNbAyyuYc8NbLKmY/vlkzN
        M+Mb7I3/aGjB3EeU+/P9ugMudTv92lpVqlEaaqweiTd2b1wFZkUxEPs3YPIS2MEM6UNtFTWvvBHQN
        WEfITQnz2liwJ85TS9tW59IA8pLwim+dwv9GBuiygMkn4J8+mI+wnzhpsBt3puo/lXsxdIkEDJbfA
        CMVtll8Q==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pWfcC-00EGQK-0C;
        Mon, 27 Feb 2023 15:40:36 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id ED93F3001E7;
        Mon, 27 Feb 2023 16:40:33 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 9A58B21F8E081; Mon, 27 Feb 2023 16:40:33 +0100 (CET)
Date:   Mon, 27 Feb 2023 16:40:33 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Xuewen Yan <xuewen.yan@unisoc.com>
Cc:     vincent.guittot@linaro.org, mingo@redhat.com,
        juri.lelli@redhat.com, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com, qyousef@layalina.io,
        linux-kernel@vger.kernel.org, ke.wang@unisoc.com,
        zhaoyang.huang@unisoc.com
Subject: Re: [RFC PATCH] sched/fair: update the vruntime to be max vruntime
 when yield
Message-ID: <Y/zO8WZV2kvcU78b@hirez.programming.kicks-ass.net>
References: <20230222080314.2146-1-xuewen.yan@unisoc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230222080314.2146-1-xuewen.yan@unisoc.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 22, 2023 at 04:03:14PM +0800, Xuewen Yan wrote:
> When task call the sched_yield, cfs would set the cfs's skip buddy.
> If there is no other task call the sched_yield syscall, the task would
> always be skiped when there are tasks in rq. 

So you have two tasks A) which does sched_yield() and becomes ->skip,
and B) which is while(1). And you're saying that once A does it's thing,
B runs forever and starves A?

> As a result, the task's
> vruntime would not be updated for long time, and the cfs's min_vruntime
> is almost not updated.

But the condition in pick_next_entity() should ensure that we still pick
->skip when it becomes too old. Specifically, when it gets more than
wakeup_gran() behind.

> When this scenario happens, when the yield task had wait for a long time,
> and other tasks run a long time, once there is other task call the sched_yield,
> the cfs's skip_buddy is covered, at this time, the first task can run normally,
> but the task's vruntime is small, as a result, the task would always run,
> because other task's vruntime is big. This would lead to other tasks can not
> run for a long time.

I'm not seeing how this could happen, it should never get behind that
far.

Additionally, check_preempt_tick() will explicitly clear the buddies
when it finds the current task has consumed it's ideal slice.

I really cannot see how your scenario can happen.

> In order to mitigate this, update the yield_task's vruntime to be cfs's max vruntime.
> This way, the cfs's min vruntime can be updated as the process running.

This is a bad solution, SCHED_IDLE tasks have very low weight and can be
shot really far to the right, leading to other trouble.

