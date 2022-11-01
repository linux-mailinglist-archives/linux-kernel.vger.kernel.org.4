Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D46B614713
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 10:43:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230469AbiKAJnv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 05:43:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230468AbiKAJn1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 05:43:27 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5D4C19C01
        for <linux-kernel@vger.kernel.org>; Tue,  1 Nov 2022 02:42:03 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 3AD7C33881;
        Tue,  1 Nov 2022 09:42:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1667295722; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Kn8M6KMFGwQEzZ+dInrlEz4q7tDnQvuNf49qTal5GEk=;
        b=Eswc25Fsk84PqMCOPaH9cVIbvhFqfJUk9Ia89igeErlKBwaaddQNJKVWIBN2Vo+mwdAFPs
        ndxUPMLZad1c5I0pBQAlkk/+APJg65d5CD/ZVuUEXFK7QaOQ65RmGJK0Lo4AiLaym6I8TY
        6bc34fShvroG8Mnk+0LzLtSO+Vs9RXs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1667295722;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Kn8M6KMFGwQEzZ+dInrlEz4q7tDnQvuNf49qTal5GEk=;
        b=Efnpc3esw76W3bw2kRIdbk6oabrtisQmXqR7FgqbPXW0tkVAWvPgQ1Kr7OHa+u8FA1NJbe
        dfMS/S+zvbtqqdAw==
Received: from suse.de (unknown [10.163.32.246])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 6C1182C141;
        Tue,  1 Nov 2022 09:42:00 +0000 (UTC)
Date:   Tue, 1 Nov 2022 09:41:57 +0000
From:   Mel Gorman <mgorman@suse.de>
To:     Andrei Vagin <avagin@google.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-kernel@vger.kernel.org, Andrei Vagin <avagin@gmail.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>
Subject: Re: [PATCH] sched: consider WF_SYNC to find idle siblings
Message-ID: <20221101094157.a3gh2ko6otaa6cyw@suse.de>
References: <20221027202603.670616-1-avagin@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20221027202603.670616-1-avagin@google.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 27, 2022 at 01:26:03PM -0700, Andrei Vagin wrote:
> From: Andrei Vagin <avagin@gmail.com>
> 
> WF_SYNC means that the waker goes to sleep after wakeup, so the current
> cpu can be considered idle if the waker is the only process that is
> running on it.
> 
> The perf pipe benchmark shows that this change reduces the average time
> per operation from 8.8 usecs/op to 3.7 usecs/op.
> 
> Before:
>  $ ./tools/perf/perf bench sched pipe
>  # Running 'sched/pipe' benchmark:
>  # Executed 1000000 pipe operations between two processes
> 
>      Total time: 8.813 [sec]
> 
>        8.813985 usecs/op
>          113456 ops/sec
> 
> After:
>  $ ./tools/perf/perf bench sched pipe
>  # Running 'sched/pipe' benchmark:
>  # Executed 1000000 pipe operations between two processes
> 
>      Total time: 3.743 [sec]
> 
>        3.743971 usecs/op
>          267096 ops/sec
> 

The WF_SYNC hint in unreliable as the waking process does not always
go to sleep immediately. While it's great for a benchmark like a pipe
benchmark as the relationship is strictly synchronous, it does not work
out as well for networking which can use WF_SYNC for wakeups but either
multiple tasks are being woken up or the waker does not go to sleep as
there is sufficient inbound traffic to keep it awake. There used to be
an attempt to track how accurate WF_SYNC was, using avg_overlap I think,
but it was ultimately removed.

-- 
Mel Gorman
SUSE Labs
