Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E607769E241
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 15:25:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233959AbjBUOZw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 09:25:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233358AbjBUOZt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 09:25:49 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF0392B289
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 06:25:47 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id g14so5100565pjb.2
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 06:25:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=TQtwfob29dO020xR+nsdt79jc/m4GepwvY587uLem6Q=;
        b=Qwe+BLDHlhASfFsqXwjp1sJ8Ka1JNGxR4jj5LwZCeb2yjfO7BvpBfDcIjgM3ln+WeI
         kpKHI1DZzTnzmJLWe2O5CUhvT7nXmB7aBsEet8Tdc8gzMKdbZj1IFOzZUCIWB2XlIZux
         dg9nOb+XQYteg6LRyLscYg9Azo4dMplNRPqA28Xugg4oJ6H6EDQpgbOVXcTy1hWC3uPp
         yGffdErgwCUTq/1l0Xc68O15BgW3vIFTF/CnWJJC4SmbTlMIGefK7SBUlzkQFO41CFPY
         sDMwd9U5R5r1sA88LcQruESocHnpGHkIUPYmpb6yi5t+0OVhz6uS50ACwxuZeG9aNPD1
         rzOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TQtwfob29dO020xR+nsdt79jc/m4GepwvY587uLem6Q=;
        b=2otRPd+VQsOHwFUifahtw7/rMi+ivoOqpdyOPn5/pkvZurTKnbW3RtheWcoPVkyvDu
         pzictAZER5C6DOBxUssjmutpA1j+e9OodLL12kKGGKwrLSE5W9RBiMQ1cBcs2iIRwvdn
         aSic3kZcPwiYMequ7Q41FhsRjf6JrXBgrrtsNfkQIbmVWZvXBRfTx3WoVcnH5vUKs0ME
         E5BIoXr/3cEYc4fihKdopS45rfcilLfHlDsA0J3rs1yXtYnqeFND+n58963MxwBZ8/2J
         xKFDG4mohKrrwS26TNGQCL80oe47EwUJrMXWVQA1Wrum1yjrfEipvda6QY7MItJo90Gm
         wKAg==
X-Gm-Message-State: AO0yUKW9GZwmpS7WhjSmAyqsiRTnmpa8O6sQ/z0RY4YL5NuhmwVOxe2y
        OOYQ8vDXAubzNXApw67PJlHiWkCh2mxp9mAhMT+10Q==
X-Google-Smtp-Source: AK7set+YPslisVvXbDS80tJo5Qxl3/PELiXL8jZS8ZOeSMNaPgZ+EmecEkpv4R84I/CVFT5j62Ea0venY47uPYLcw0M=
X-Received: by 2002:a17:90b:3946:b0:233:f98e:3a37 with SMTP id
 oe6-20020a17090b394600b00233f98e3a37mr1152541pjb.15.1676989547358; Tue, 21
 Feb 2023 06:25:47 -0800 (PST)
MIME-Version: 1.0
References: <20230113141234.260128-1-vincent.guittot@linaro.org>
 <20230113141234.260128-6-vincent.guittot@linaro.org> <Y/S+qrschy+N+QCQ@hirez.programming.kicks-ass.net>
 <Y/TSAivRWwm2LaPh@hirez.programming.kicks-ass.net>
In-Reply-To: <Y/TSAivRWwm2LaPh@hirez.programming.kicks-ass.net>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Tue, 21 Feb 2023 15:25:36 +0100
Message-ID: <CAKfTPtAHuVFx=5w0p5DBShx42eEPCPXJ+DLc3z3_3yFv9jJWeA@mail.gmail.com>
Subject: Re: [PATCH v10 5/9] sched/fair: Take into account latency priority at wakeup
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     mingo@redhat.com, juri.lelli@redhat.com, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com,
        linux-kernel@vger.kernel.org, parth@linux.ibm.com,
        cgroups@vger.kernel.org, qyousef@layalina.io,
        chris.hyser@oracle.com, patrick.bellasi@matbug.net,
        David.Laight@aculab.com, pjt@google.com, pavel@ucw.cz,
        tj@kernel.org, qperret@google.com, tim.c.chen@linux.intel.com,
        joshdon@google.com, timj@gnu.org, kprateek.nayak@amd.com,
        yu.c.chen@intel.com, youssefesmat@chromium.org,
        joel@joelfernandes.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 Feb 2023 at 15:15, Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Tue, Feb 21, 2023 at 01:52:58PM +0100, Peter Zijlstra wrote:
> > On Fri, Jan 13, 2023 at 03:12:30PM +0100, Vincent Guittot wrote:
> >
> > > diff --git a/include/linux/sched.h b/include/linux/sched.h
> > > index 6c61bde49152..38decae3e156 100644
> > > --- a/include/linux/sched.h
> > > +++ b/include/linux/sched.h
> > > @@ -568,6 +568,8 @@ struct sched_entity {
> > >     /* cached value of my_q->h_nr_running */
> > >     unsigned long                   runnable_weight;
> > >  #endif
> > > +   /* preemption offset in ns */
> > > +   long                            latency_offset;
> >
> > I wonder about the type here; does it make sense to have it depend on
> > the bitness; that is if s32 is big enough on 32bit then surely it is so
> > too on 64bit, and if not, then it should be unconditionally s64.
> >
>
> The cgroup patch has this as 'int'. I'm thinking we ought to be
> consistent :-)

Yes, good point
