Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F80660BF59
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 02:17:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230490AbiJYARV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 20:17:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231201AbiJYAQl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 20:16:41 -0400
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 880B214BB7F
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 15:36:13 -0700 (PDT)
Received: by mail-il1-x12f.google.com with SMTP id e19so3289883ili.4
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 15:36:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=TcxHuhAd7wVGSA9XpZAb1LdhYwSZC2XiHU7WQHajr6g=;
        b=TS8c2NogcS6NsjbbbOKcUzGQmCkK7Nd8/R8JzTCpgT026m4JUCC1OYiwKt/KWBC16+
         EeyS3mOiO/E38FHj4RMauAe0oBEFvfJgtI3xkiFV0DPiOxPZ1UsDE60zcCGihBg48CKo
         Cy4yYQ4MUN5KBb4C6v5edF3OOTNf7Vv47iTrZqI/JDx3O2HxaB7haw5NGd7cus1h5JDm
         89l+qrZC/Ei7n4GQraGm5TlgGjNDlxQm/pnxqFx8mPIE/owyuGHXiGZVwgRe9v0Fkqrq
         ImltVUVzinV/vCGGbzkBcLPyGlQ4DDle8KUS1WcxBi2oDlgMh3nn6CvNkj48CffNfZ+U
         KJ+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TcxHuhAd7wVGSA9XpZAb1LdhYwSZC2XiHU7WQHajr6g=;
        b=n5EkhoXdC+GKbHw0vTS0Klf4q5553c6gWNI75BkvLYo2oVGZeDumsO0kChObK7zsvd
         ICF0C3VAHyhjrgmv2QYCEYwhGRiYOK7YaWr3k3ftvMXut8bvAk2eTcezcwCO+IMU8EJ1
         4v3Y+F9kfgtCoNJuNTN+29eCWlbTgbDRT3eRE8Qm1HuTuskvr5k+vcjvKawn2jkKj9L+
         CrIDsAm/u9YisMUxb+a7Og1qBfISQNd0XTX0RsLexWxggmAlkKynrH6UxcNc5mTdb7hr
         6UaJVnCsqXAcMN2yOrjvkgGouW77PJkhSgJFKrOsYGuzz6nKwfu871rrfZS+gmjOmzIP
         I+4Q==
X-Gm-Message-State: ACrzQf0uG3O9W4/rrqknbs1TYcmbYPo9e1JjQCeiY4ToWwlrwi5fiM1c
        Ahn7CeEjeQQpbAnjcCk7S8+eGbu7Tjk8Qh3XuX7Nvw==
X-Google-Smtp-Source: AMsMyM6FISk1xJ3qyhP3Lmj2MXMwb7zE5y+Jql3j3eYbQ5VtsGHm2FjhSjm5e5QvpJiHzTW1kdJzAbyf7f+EN1h6rk4=
X-Received: by 2002:a05:6e02:1354:b0:2ff:d9a7:cdc9 with SMTP id
 k20-20020a056e02135400b002ffd9a7cdc9mr5170605ilr.19.1666650973038; Mon, 24
 Oct 2022 15:36:13 -0700 (PDT)
MIME-Version: 1.0
References: <20220925143908.10846-1-vincent.guittot@linaro.org>
 <20220925143908.10846-5-vincent.guittot@linaro.org> <Y1QHcZSmKAX2SWgu@chenyu5-mobl1>
In-Reply-To: <Y1QHcZSmKAX2SWgu@chenyu5-mobl1>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Tue, 25 Oct 2022 00:36:01 +0200
Message-ID: <CAKfTPtDQT9LwEZwPkZOnq11gZdUUVZfcFB33bPMd34K8rpVHgA@mail.gmail.com>
Subject: Re: [PATCH v5 4/7] sched/fair: Take into account latency priority at wakeup
To:     Chen Yu <yu.c.chen@intel.com>
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        linux-kernel@vger.kernel.org, parth@linux.ibm.com,
        qais.yousef@arm.com, chris.hyser@oracle.com,
        valentin.schneider@arm.com, patrick.bellasi@matbug.net,
        David.Laight@aculab.com, pjt@google.com, pavel@ucw.cz,
        tj@kernel.org, qperret@google.com, tim.c.chen@linux.intel.com,
        joshdon@google.com, timj@gnu.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 22 Oct 2022 at 17:09, Chen Yu <yu.c.chen@intel.com> wrote:
>
> Hi Vincent,
> On 2022-09-25 at 16:39:05 +0200, Vincent Guittot wrote:
> [...]
> > +static long wakeup_latency_gran(struct sched_entity *curr, struct sched_entity *se)
> > +{
> > +     long latency_offset = se->latency_offset;
> > +
> > +     /*
> > +      * A negative latency offset means that the sched_entity has latency
> > +      * requirement that needs to be evaluated versus other entity.
> > +      * Otherwise, use the latency weight to evaluate how much scheduling
> > +      * delay is acceptable by se.
> > +      */
> > +     if ((se->latency_offset < 0) || (curr->latency_offset < 0))
> Maybe use latency_offset < 0 directly?

yes

> BTW, is it the policy that requires the user to provide a negative
> latency nice so as to tell the kernel to compare between two tasks?

Only tasks with negative latency nice value want to be more aggressive
than the default behavior to preempt at wakeup.

> Maybe I missed the scenario, I'm thinking of the reason why we used
> " || " rather than " && " above. To be more specific, why not comparing
> se and curr only when they both have high requirement on latency(negative)?

When one task wants to be scheduled in priority (negative latency
nice), we want to keep the same offset for a same delta between the
latency nice prio.


>
> The benefit of using "||" I'm thinking of is that, if se->latency_offset < 0
> and curr->latency_offset > 0, the latency_offset would be even smaller than
> se->latency_offset, which will make the preemption easier. And vice verse.
>
> thanks,
> Chenyu
> > +             latency_offset -= curr->latency_offset;
> > +
> > +     return latency_offset;
> > +}
