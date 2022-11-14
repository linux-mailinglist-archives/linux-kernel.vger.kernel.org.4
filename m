Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98631628653
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 17:59:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238159AbiKNQ7N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 11:59:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237747AbiKNQ6h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 11:58:37 -0500
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05F172FFD6
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 08:57:42 -0800 (PST)
Received: by mail-il1-x130.google.com with SMTP id d3so6043543ils.1
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 08:57:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=mxPjJl19vuPi34g5mWzoQtUzWrzx70SGGhy6GFnbKUg=;
        b=cX80NK6y7G8kTyANdhOD7kdjcjAH/TRYp3kZmubOqU3dQGR44+98vV3HsF5YRDibRv
         p/wD7OoQUPAxu3ZsTFoTTOcQEh5I9gIFRxIL7JCfgOyW9p5rpZ+D6KRaseaJ92caY0Zp
         EfcSZf1GguJSeng3mIanXLUDFX7v/9OrFviriPp1rTFvZjaDcXcXuIzmao4br7/EatPe
         OWq04yPdN9GoqegH6WVdiI7Te1MYeuNdwEaJck4eAjkwlItLpYAonuM8vAWLtSBlkTXD
         D34d263J70pjkn7q6SbeBKbWGph/+Ruc1TpXhEWQHO1HEYY4S14tiSAycZT0iNqC3/ti
         3Lmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mxPjJl19vuPi34g5mWzoQtUzWrzx70SGGhy6GFnbKUg=;
        b=bmwJfUs7Wj49o7sPr7X9MML5ZmnCCkXB+X/ecuV4Yj3TrVeEoBjJEYeKW4Yyz0gJv/
         /WueZ+2RYJME0eawd3oq5cyLHXyVuTvL24f2Sr+YyTaUKsxtVOedGIdedHfX8NgvMd73
         DzT/k6Hkyy0bVYpqKUgTPF+Ixy8eGaDfgxbBL8F9PCdpqAz4lC9/KhgvRMjmOJvZ+mFJ
         5ticweu6731BesJxBbl9tLbtADLu8Phnbad0MzlLwJHy13EszgS6pU6aeD5NvXB1zKiW
         NX/53bXY/YI5cMdgxJXOj/D/MtN5aEJQbpqFclurnaWBDA73cpz+PUPMDjHZxVkn2BzK
         4UZw==
X-Gm-Message-State: ANoB5plD7ZdvrSUjaBFQGV7ub1jg6uRp9VvVSZFYTR0kVfnd/UZrqjoG
        boU9cSQsBq+pp6QYkaHDBddHXBooeCCxotU4cNkt8Q==
X-Google-Smtp-Source: AA0mqf52zgqMXbpl+qW5Z9hVw/XrSGXUFHb3JSWLNZf40N01pqzDsROhxN38pm+h7Jgy7GeXTdXRliBC58MIVMzNIqM=
X-Received: by 2002:a05:6e02:cce:b0:300:cf38:174f with SMTP id
 c14-20020a056e020cce00b00300cf38174fmr6750221ilj.22.1668445062085; Mon, 14
 Nov 2022 08:57:42 -0800 (PST)
MIME-Version: 1.0
References: <20221110175009.18458-1-vincent.guittot@linaro.org>
 <20221110175009.18458-7-vincent.guittot@linaro.org> <Y3Jq4gBB5+Qg67u7@google.com>
In-Reply-To: <Y3Jq4gBB5+Qg67u7@google.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Mon, 14 Nov 2022 17:57:30 +0100
Message-ID: <CAKfTPtDiKF7x0obCFXmNsmJdsJ9yXzAf4vuOVJmN_eO_bA8KHQ@mail.gmail.com>
Subject: Re: [PATCH v8 6/9] sched/fair: Add sched group latency support
To:     Patrick Bellasi <patrick.bellasi@matbug.net>
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        linux-kernel@vger.kernel.org, parth@linux.ibm.com,
        qyousef@layalina.io, chris.hyser@oracle.com,
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

On Mon, 14 Nov 2022 at 17:20, Patrick Bellasi
<patrick.bellasi@matbug.net> wrote:
>
> Hi Vincent,
>
> On 10-Nov 18:50, Vincent Guittot wrote:
>
> [...]
>
> > diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
> > index be4a77baf784..a4866cd4e58c 100644
> > --- a/Documentation/admin-guide/cgroup-v2.rst
> > +++ b/Documentation/admin-guide/cgroup-v2.rst
> > @@ -1095,6 +1095,16 @@ All time durations are in microseconds.
> >          values similar to the sched_setattr(2). This maximum utilization
> >          value is used to clamp the task specific maximum utilization clamp.
> >
> > +  cpu.latency.nice
> > +     A read-write single value file which exists on non-root
> > +     cgroups.  The default is "0".
> > +
> > +     The nice value is in the range [-20, 19].
> > +
> > +     This interface file allows reading and setting latency using the
> > +     same values used by sched_setattr(2). The latency_nice of a group is
> > + used to limit the impact of the latency_nice of a task outside the
> > + group.
>
> This control model is not clear to me.
>
> It does not seem matching what we have for uclamp, where the cgroup values are
> used to restrict how much a task can ask or give (in terms of latency here).
>
> in the uclamp's requested-vs-effective values model:
>
> A) a task can "request" (or give up) latency as much as it likes
>
> B) the cgroup in which the task is in any moment limits wthe maximum
>    latency a task can "request" (or give up)
>
> C) the system wide knob set the "request" limit for the root cgroup an any task
>    not in a cgroup.
>
> This model seems to be what we should use here too.
>
> IOW, for each task compute an "effective" latency_nice value which is defined
> starting for a task "requested" latency value and by restricting this value
> based on the (B) cgroup value and the (C) system wide value.
>
> That's what we do in uclamp_eff_get():
>    https://elixir.bootlin.com/linux/v6.0/source/kernel/sched/core.c#L1484
>
> Why such a model cannot be used for latency_nice too?
> Am I missing something?

Have you read the previous email thread on the subject ?

As I mentioned previously we don't need an effective latency for this
patchset because the current use of cgroup latency_nice is done at
each scheduling level just like the cgroup weight is used at each
level.

Regards,
Vincent

>
>
> Best,
> patrick
>
> --
> #include <best/regards.h>
>
> Patrick Bellasi
