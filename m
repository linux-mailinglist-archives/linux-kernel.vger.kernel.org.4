Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFF5469E3CA
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 16:43:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234465AbjBUPnM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 10:43:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234560AbjBUPmw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 10:42:52 -0500
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8580A2717
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 07:42:50 -0800 (PST)
Received: by mail-pf1-x42f.google.com with SMTP id cb13so2709703pfb.5
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 07:42:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=pgJoew5uSEhDOZSrg2jVXTz7ZRs9T5t38ejwKJjnfNc=;
        b=vRuRw5Ip1otM+28WxOzAbghLRjYEHZe4RWCNG7lf98qoXAKX0zLO5rRroIHpTA8tCW
         cidxPyx4eumCtj3ns4zK3AB4YSqL8rusHgjnG1O6cXngiSERzr5ReARfFOIMud8JBr9s
         4ZLtqam/3ItxgRS2GEoRDZsamVjWTagDE0EZ4Yna2QAxEp2tIuTgJkAtMNXsdJJF4hAe
         dwEdodqsbiQEhYaGGdXryLnumt7MYgqzPo/qnqwJAXvqXGUqa2fS/CzOzYJITAk+a+Mu
         lH70xu4ZNSpWSsZ2tDnb3WWX6jx83qZUMl8gLqlsgIyUkhRpG3Q6EcitnziuodUyVmpL
         J/kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pgJoew5uSEhDOZSrg2jVXTz7ZRs9T5t38ejwKJjnfNc=;
        b=1ytMuC0jB24inNNVkAg86gEa0Qul10PJHH6mxlZwgKvKvWw2GbTzI5WZFY9nIik3hW
         qMCRZsd9a/Gii6NazF/UskgExANgE1knpo2USauAzoIVtGCEd4kUIncGE+wfbKiXfF9y
         o2+rOJIz5T0XPiuCSDncR4kcLxJx4IU4tGYBBQxspgLuNstv7R8bJywLZGghGdkpSiE0
         SSenFkwJIG8B7fN47sZ7t0daDparRi06ou76/P8mdI7do1Jh5p5+j+truLyQQqSQNyJL
         KAjC/ojoDF/lHe2fQ2QJLC0S7H/EDoibTtq6yWROtDUZOGpvOzB+gGRTjaA341XiOl9d
         VlBw==
X-Gm-Message-State: AO0yUKXspyMuLWky4aSCrF2VrBhkeIcxpPGcvD4qhCezjWUocZcUlwTN
        rN2fqxOhKl5Q1qzLvrSeVRWwevhscB1IsaGBNsR6Ow==
X-Google-Smtp-Source: AK7set9ZWcKrK/yqSYv3MTq11vSyKz6NPMDcJAwxQs3l7xKPnC7GulnYeMRfW4THqcKMIzQUAjtCjl4HLPDxs1ENHgk=
X-Received: by 2002:a63:368b:0:b0:4fb:d4d1:c320 with SMTP id
 d133-20020a63368b000000b004fbd4d1c320mr661707pga.11.1676994169985; Tue, 21
 Feb 2023 07:42:49 -0800 (PST)
MIME-Version: 1.0
References: <20230113141234.260128-1-vincent.guittot@linaro.org>
 <20230113141234.260128-9-vincent.guittot@linaro.org> <Y/TfN1upxApdSERP@hirez.programming.kicks-ass.net>
In-Reply-To: <Y/TfN1upxApdSERP@hirez.programming.kicks-ass.net>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Tue, 21 Feb 2023 16:42:38 +0100
Message-ID: <CAKfTPtDQ0hgiqdO7ywUEw3htpiBS3NxWMxXL9LqmBpA8E25quw@mail.gmail.com>
Subject: Re: [PATCH v10 8/9] sched/fair: Add latency list
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

On Tue, 21 Feb 2023 at 16:12, Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Fri, Jan 13, 2023 at 03:12:33PM +0100, Vincent Guittot wrote:
> > @@ -12552,8 +12634,15 @@ int sched_group_set_latency(struct task_group *tg, s64 latency)
> >
> >       for_each_possible_cpu(i) {
> >               struct sched_entity *se = tg->se[i];
> > +             struct rq *rq = cpu_rq(i);
> > +             struct rq_flags rf;
> > +
> > +             rq_lock_irqsave(rq, &rf);
> >
> > +             __dequeue_latency(se->cfs_rq, se);
> >               WRITE_ONCE(se->latency_offset, latency);
> > +
> > +             rq_unlock_irqrestore(rq, &rf);
> >       }
>
> This seems asymmetric; maybe something like:
>
>         queued = __dequeue_latency(..);
>         WRITE_ONCE(...);
>         if (queued)
>                 __enqueue_latency(...);
>
> ?

Fair enough
