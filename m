Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F5C76FF9A8
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 20:55:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238053AbjEKSz5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 14:55:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238906AbjEKSzy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 14:55:54 -0400
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D54272BB
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 11:55:53 -0700 (PDT)
Received: by mail-ot1-x329.google.com with SMTP id 46e09a7af769-6aaef8ca776so2394878a34.2
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 11:55:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bitbyteword.org; s=google; t=1683831351; x=1686423351;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bWM1jp+eGvaqbsAh0eljWb7kApkfVmgcMHgGBYQZHSA=;
        b=GgloZoW20h5o6vrR1LE41TasgCd5QxHVF4k+Yg8PDrsYtPXvGiyKNlzekAFTv1Burv
         kp1qiAXhTQJQumU00gqBboSeP+CqWLRCBksA3U44VRfpjbez66PefpE0DjmCcc+z1lm2
         elyKq5Ehhqeoy6DsHwLIAxeLRQnXKJm3H0K4nV0eRK73w25GJBYlNOge/+4gsahweYfV
         Kp1GHbHC3fspqw9LsE/v/PG+wSb3vdIPTn9u4vNf88lhAtQqnsmgYUP8gJ1wcamgpVjZ
         8kPR9v6MuN+ilshxJ1HvhurI9G0ILD+Fk5O9c9aA5YgJAR4tOiW2YoqgybcYYY5UUvKI
         d68g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683831351; x=1686423351;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bWM1jp+eGvaqbsAh0eljWb7kApkfVmgcMHgGBYQZHSA=;
        b=gFZRjjW1HkbHWKynU36BwqSgMn40rWDIW/jVejoJ0JJ7LFd8FTWaU19A6YvkyQy5Q+
         igfWyCrskh3RG0qRSEwnLPXs+Swi6tNMAkWoa/jOK4ZlE680XSwmtQSQCPyylJZwZHen
         jlBxDu2H3WicSVh6/27KnNCm/X8CR8sCp3aF7S9GMu2o5vFokZrm4Fdu3yI/GQ1WB19m
         CMM3TccnHzZ58HY1BjY8qI7viCQZU0vB46MJagOy3OoDuOzctHatQIc2sz6bUJ8RaoGj
         REKv0cWbvyBxsHSAceHNQs/3b8a+rJ0GowCHyqHiDOK3p6hTC75zxcLi4gJVBDuRq09D
         bUyw==
X-Gm-Message-State: AC+VfDxN7LI+JRqFFFT/u1vj5RKTYlUCqK93Ow71rEgqLuhkhGBgyfwH
        iz/WzCdbJM+39WoMkIFJ04UWC1SVO0pid9xGPDADJw==
X-Google-Smtp-Source: ACHHUZ4ZDemwFdKa6QBjBELIU5y8cF6okicN9YUVEbfjUx++crs5h184yLAhqdbTqoBfz4gOEBGMT31VW7zAEiQ9mP0=
X-Received: by 2002:a05:6808:6087:b0:38f:76d7:38cb with SMTP id
 de7-20020a056808608700b0038f76d738cbmr5025661oib.0.1683831351468; Thu, 11 May
 2023 11:55:51 -0700 (PDT)
MIME-Version: 1.0
References: <20230511014625.3443409-1-vineeth@bitbyteword.org> <CAEXW_YRjNAUXFD8rPQQ53Vu8j8ka=Z-WEZS54JXEroVH7TPVjg@mail.gmail.com>
In-Reply-To: <CAEXW_YRjNAUXFD8rPQQ53Vu8j8ka=Z-WEZS54JXEroVH7TPVjg@mail.gmail.com>
From:   Vineeth Remanan Pillai <vineeth@bitbyteword.org>
Date:   Thu, 11 May 2023 14:55:40 -0400
Message-ID: <CAO7JXPhnTWgqUYXBsGoczHC0RVJgsCHeKgVn+-cxtPkjspopMA@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] sched/deadline: Improve reclaim bandwidth accuracy
 for GRUB
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     luca.abeni@santannapisa.it, Juri Lelli <juri.lelli@redhat.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Valentin Schneider <vschneid@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Joel,

On Thu, May 11, 2023 at 2:19=E2=80=AFAM Joel Fernandes <joel@joelfernandes.=
org> wrote:
>
> Hi Vineeth,
> Nice work. ;-) Few quick comments below:
>
Thanks :-)

> On Wed, May 10, 2023 at 6:46=E2=80=AFPM Vineeth Pillai <vineeth@bitbytewo=
rd.org> wrote:

> > This patch fixes the issue by appropriatley caping the max allowed
> > utilization and also slightly adjusting GRUB algorithm to account
> > for a mix of normal deadline and SCHED_FLAG_RECLAIM tasks.
>
> Looked at the patch quickly as I am due for bedtime ;-). I feel like
> this does more than should be done in one patch. So you should
> consider splitting it IMHO.
I think the explanatory comments are what makes this patch look huge.
The code changes are pretty small and simple:
- track bw of SCHED_RECLAIM_TASKS
- modify the reclamation equation.

> > According to the GRUB rule, the runtime is depreciated as a factor
> > of active bandwidth of the runqueue: "dq =3D -dt", where U is the
>
> Saying "dq =3D -dt" where U does not make sense because U is not in the
> equation ;-). Suggest rephrase.
>
Sorry about this, I will rephrase it.

>
> > active bandwidth. Also, we do not allocate the full bandwidth of a
> > cpu to deadline task, but only a portion(Umax) to it, so as to avoid
> > deadline tasks starving lower class tasks. The equation could be
> > re-written as "dq =3D -(U / Umax) * dt"
>
> Isn't the equation in the code right now as:
> dq =3D -max{ Ui / Umax, (1 - Uinact - Uextra) } dt
>
> ?
>
> That's what the kernel docs say [1].
>
> So what do you mean by "could be re-written" ?
>
> [1] https://docs.kernel.org/scheduler/sched-deadline.html
>
This patch uses a different equation than [1] and updated the kernel
doc as well in patch 2 of this series. I understand "re-written" is
confusing and will rephrase it.

> > Following are the results with this patch:
> >
> > RUN 1: runtime=3D7ms, deadline=3Dperiod=3D10ms, RT capacity =3D 95%
> > TID[616]: RECLAIM=3D1, (r=3D7ms, d=3D10ms, p=3D10ms), Util: 94.98
> > TID[616]: RECLAIM=3D1, (r=3D7ms, d=3D10ms, p=3D10ms), Util: 95.04
> > TID[616]: RECLAIM=3D1, (r=3D7ms, d=3D10ms, p=3D10ms), Util: 95.01
>
> All these look 100% correct to me. Do these tasks start at the same
> time or are they shifted in their respective activations? Just wanted
> to be sure it behaves the same either way...
>
I have tested both. Actually I tested 3 scenarios:
- Started the threads at the same time
- Started the threads separately (5-10 seconds apart)
- Started the threads at the same time with some of them sleeping for
  a while before spinning. This was to see if transition from
  NonContending to Inactive was showing any issues with this patch.

> > +static inline bool dl_entity_is_reclaim(const struct sched_dl_entity *=
dl_se)
> > +{
> > +       return dl_se->flags & SCHED_FLAG_RECLAIM;
> > +}
> > +
>
> Can this helper addition be split out to a different patch?
>
I feel it could go with this patch as the code changes in this patch
are fairly small and the function is trivial. But I can split it if
you feel that this patch is really huge and needs splitting.

> > +        * Maximum available bandwidth for this runqueue. This is used =
to
> > +        * calculate reclaimable bandwidth for SCHED_FLAG_RECLAIM tasks=
.
> > +        * By restricting maximum usable bandwidth, we aim to give othe=
r
> > +        * tasks on lower classes a chance to run, when competing with
> > +        * SCHED_FLAG_RECLAIM tasks.
> >          */
> > -       u64                     bw_ratio;
> > +       u64                     max_bw;
> > +
> > +       /*
> > +        * Active bandwidth of SCHED_FLAG_RECLAIM tasks on this rq.
> > +        * This will be a subset of running_bw.
> > +        */
> > +       u64                     reclaim_bw;
> > +
>
> And perhaps addition and use of these new fields if it makes sense.
>
> I will take a closer look at your patches later or after v2..
>
Thanks :-)

Vineeth
