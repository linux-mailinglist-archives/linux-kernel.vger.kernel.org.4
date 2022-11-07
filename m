Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FE3A61EC85
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 09:00:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231531AbiKGIAa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 03:00:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231509AbiKGIA1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 03:00:27 -0500
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6422F13EB6
        for <linux-kernel@vger.kernel.org>; Mon,  7 Nov 2022 00:00:26 -0800 (PST)
Received: by mail-io1-xd29.google.com with SMTP id 11so8236945iou.0
        for <linux-kernel@vger.kernel.org>; Mon, 07 Nov 2022 00:00:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=wbw8UlZFhQEVv28M6pF5vKJuxWk/eE+BiE2ImvUMr70=;
        b=ZiSlZjGp1IHwI4DBPdUNAPTypY58zT9rzzmGa03QZ4FoXl1HeH3HBfYuMb84vUZQc3
         Rmx55oTFzOEHlqnzxd63jOcLDOgxyAaSugUX882ynWyKtEBOqJQXKywH4zlIhOKscpaw
         U49mpE2tG2bMvX/7KGEzIygbKmRcgZbO86S8uq+f3UyfYcePUQudIm8hOaR4HOahSKGP
         +oBNHekUpuEyTZIQePZpcClBDntMbJSREiuhCHSvvrIvy09BY0gCQ1UfQvqQuyndT3b3
         ZOWgyTNj/Sa28Y0Hhwklg0bv70W+79QEcy7ZNy0qVVsZ8P0MgPCzInkfRWNqM5kCH2ut
         F/QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wbw8UlZFhQEVv28M6pF5vKJuxWk/eE+BiE2ImvUMr70=;
        b=tN3OVsT5qFK1PP5YlnP6wJ2O+fNr7QMCkxjcHW6zR7aDBNDmgHsydBLhLmlYWpp6Wo
         s+IYKz/tYoT9CYE+8RLkLP+1f1nWIGVWGMJ8bsMb1vr5LciJuQp0bUukRi04lvdSvZhO
         UGhv5xZsY0nIMKngkS67wiF3YPj4cGLYzE3nRr6r55ChpxdufgMGnOPVo2WLtmn1Lgxm
         tWrA8tYy0VPZ/CF7hh9zn0PI0uLVxg7mSreU/oE87TyQCxL6AJVjz52fSHo41f+RkEv4
         wixWD/t7bM9dWiw57hQvbNOGo2Tr6YozIP+usdgv4malZE9N4nw3Kq6wTI/cT3OqCsAk
         aPCg==
X-Gm-Message-State: ACrzQf22bWFkCrc9Ft6wQxVJ/bIY4lGSWBDXXFzVFT8CMA1htA9uBBWu
        QD3Mb1tH+N3JDVxcZFNsJrsS1jN7dAKr/7Mq02X7PA==
X-Google-Smtp-Source: AMsMyM642TcStkKvExEQMYCC8K0cw5B8x/6TqbrQng0B+ThiQwYKimQ/STLphUKQLC1crdvwfN3IkMFM8BKZNt66tyg=
X-Received: by 2002:a02:c006:0:b0:375:afec:565b with SMTP id
 y6-20020a02c006000000b00375afec565bmr7468891jai.135.1667808025546; Mon, 07
 Nov 2022 00:00:25 -0800 (PST)
MIME-Version: 1.0
References: <20221028093403.6673-1-vincent.guittot@linaro.org>
 <20221028093403.6673-2-vincent.guittot@linaro.org> <Y2Z0C2whs6pnPLvi@chenyu5-mobl1>
In-Reply-To: <Y2Z0C2whs6pnPLvi@chenyu5-mobl1>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Mon, 7 Nov 2022 09:00:12 +0100
Message-ID: <CAKfTPtDTsG=PmD=CQgAyhV0YfsWKDfgyJU2BSDbc4scUwzS3CQ@mail.gmail.com>
Subject: Re: [PATCH v7 1/9] sched/fair: fix unfairness at wakeup
To:     Chen Yu <yu.c.chen@intel.com>
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        linux-kernel@vger.kernel.org, parth@linux.ibm.com,
        qais.yousef@arm.com, chris.hyser@oracle.com,
        patrick.bellasi@matbug.net, David.Laight@aculab.com,
        pjt@google.com, pavel@ucw.cz, tj@kernel.org, qperret@google.com,
        tim.c.chen@linux.intel.com, joshdon@google.com, timj@gnu.org,
        kprateek.nayak@amd.com, youssefesmat@chromium.org,
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

On Sat, 5 Nov 2022 at 15:33, Chen Yu <yu.c.chen@intel.com> wrote:
>
> On 2022-10-28 at 11:33:55 +0200, Vincent Guittot wrote:
> [snip]
> > +static inline unsigned long  get_latency_max(void)
> > +{
> > +     unsigned long thresh = get_sched_latency(false);
> > +
> > +     thresh -= sysctl_sched_min_granularity;
> > +
> May I know why we substract sysctl_sched_min_granularity above?
> I thought thresh -= 1 would be enough to let the waking task preempt
> the current one, because:
> When a long sleeping task is enqueued on this rq, its vruntime is set
> to cfs_rq->min_vtime - latency, so
> diff = curr->vtime - cfs_rq->min_vtime + latency,
> since (curr->vtime - cfs_rq->min_vtime) >= 0, if we set the thresh to
> (latency - 1), the diff is guaranteed to be bigger than thresh and
> the waking task can preempt current task.

If the waking task failed to preempt current it could to wait up to
sysctl_sched_min_granularity before preempting it during next tick.

Vincent

>
> thanks,
> Chenyu
> > +     return thresh;
> > +}
