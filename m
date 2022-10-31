Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05A586140BD
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 23:37:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229955AbiJaWhh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 18:37:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229562AbiJaWhf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 18:37:35 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 491D115718
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 15:37:34 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id l32so7958372wms.2
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 15:37:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=32Qe8bmBZ7pII79RFwCpK+3GOxPstNnomF/ebeGJTnM=;
        b=CEkFr1Q5rbPhDsqDTgm8r/bNCNZ2IRwU43A4d21qT+qUEzXwGlsns1GuxihgRS+Pws
         TzR92Rq4M5egbl4trrR5Y+bdxlT/2ZQTmDA6tEgG8SKQxKOwpMuS8SYUS160BLI5+JXW
         kI2n80wBXzoB/T/4Ay3Ka2M2RNALkRSRnuuznv65HBGL0FNihkzQ1T2py5vEjGT4Qoaz
         rLpMhvFaxBDO6R149nSyARMA66BqF/Y9HVEhrZ1HhoZ/smqrzGvWUUzjgQ3CSDOukCXU
         Fi2Xsk0F7b9242+1vg6wg9OpgmFDW77KmMx3UwbTvRcNwJmcUrhFL7Aljxi4kwvpOk3V
         wu9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=32Qe8bmBZ7pII79RFwCpK+3GOxPstNnomF/ebeGJTnM=;
        b=nZO35QiaznRU0xieRondWNSWw4K8lekPW9EE7C2NYvzF2xc5vOwIC28YibnMTmPzBa
         z4YbdnzWa2edilf/+E1DIC45rdPiboqrranZ+XWiTjAMMNPZGmr0P7AVdj0CvoyaAPYT
         EoTUEZi8Ug2KmnDPbMq47qzcv83eqsVkwz+GpEXBqWrTCIL0OTI3iFvMLEj5yFhI323F
         fL48QsPttX0xKbyu5IaDz7uyj+MUjy4RTcHhQktSA3S+aWAkny5WcFwjJ4C/fKaQX1N7
         Hxr8YQS5cPQrh6bRJTDMbh8IWki04/4MGAFyfdb4dUKKRLjzu1y2AKyfs3rYurICiMBu
         /x5A==
X-Gm-Message-State: ACrzQf18PnoqMAiWaz9+tBsjQ/MaqWjMT5ytH4owmpz4d4DaPt7IQbgW
        xpnarje5ClsGqfHt4hlWOdw4lgui90oaNCQfKYmANA==
X-Google-Smtp-Source: AMsMyM7cK3nFA6pExpB9Vrej4Pi0gdqIDS+AN4fCmL3iZmDnlUygCnYRwGljLiTBMyqyyHpkS6CWBRtcfARwtAK8PhE=
X-Received: by 2002:a05:600c:310b:b0:3cf:33c4:bc7 with SMTP id
 g11-20020a05600c310b00b003cf33c40bc7mr9725643wmo.25.1667255852653; Mon, 31
 Oct 2022 15:37:32 -0700 (PDT)
MIME-Version: 1.0
References: <20221027202603.670616-1-avagin@google.com> <Y1/GO1eWt+oTNA24@hirez.programming.kicks-ass.net>
In-Reply-To: <Y1/GO1eWt+oTNA24@hirez.programming.kicks-ass.net>
From:   Andrei Vagin <avagin@google.com>
Date:   Mon, 31 Oct 2022 15:37:21 -0700
Message-ID: <CAEWA0a7jDTGs3uYY6FyAeOYWgvhQDdGs+bUFi_4S92eoOCa+Rg@mail.gmail.com>
Subject: Re: [PATCH] sched: consider WF_SYNC to find idle siblings
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-kernel@vger.kernel.org, Andrei Vagin <avagin@gmail.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 31, 2022 at 5:57 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
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

I've run these set of benchmarks:
* perf bench sched messaging
* perf bench epoll all
* perf bench futex all
* schbench
* tbench
*  kernel compilation

Results look the same with and without this change for all benchmarks except
tbench.  tbench shows improvements when a number of processes is less than a
number of cpu-s.

Here are results from my test host with 8 cpu-s.

$ tbench_srv &  "tbench" "-t" "15" "1" "127.0.0.1"
Before: Throughput 260.498 MB/sec  1 clients  1 procs  max_latency=1.301 ms
After:  Throughput 462.047 MB/sec  1 clients  1 procs  max_latency=1.066 ms

$ tbench_srv &  "tbench" "-t" "15" "4" "127.0.0.1"
Before: Throughput 733.44 MB/sec  4 clients  4 procs  max_latency=0.935 ms
After:  Throughput 1778.94 MB/sec  4 clients  4 procs  max_latency=0.882 ms

$ tbench_srv &  "tbench" "-t" "15" "8" "127.0.0.1"
Before: Throughput 1965.41 MB/sec  8 clients  8 procs  max_latency=2.145 ms
After:  Throughput 2002.96 MB/sec  8 clients  8 procs  max_latency=1.881 ms

$ tbench_srv &  "tbench" "-t" "15" "32" "127.0.0.1"
Before: Throughput 1881.79 MB/sec  32 clients  32 procs  max_latency=16.365 ms
After:  Throughput 1891.87 MB/sec  32 clients  32 procs  max_latency=4.050 ms

Let me know if you want to see results for any other specific benchmark.

Thanks,
Andrei
