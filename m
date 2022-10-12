Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A3FF5FC895
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 17:43:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229639AbiJLPnF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 11:43:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbiJLPnB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 11:43:01 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AD79AE872
        for <linux-kernel@vger.kernel.org>; Wed, 12 Oct 2022 08:43:00 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id h8so9112232lja.11
        for <linux-kernel@vger.kernel.org>; Wed, 12 Oct 2022 08:42:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=y4UhhqJ3Oy5m10obzfeCNIu6uYRDzLagc7ZKXtuv5pA=;
        b=AkEAzKnBFxMhZ3pp2TPSSUkFltWSBDEIRoxIXEyh8HGDb8xqq9TVqSiznTY8BhHrjw
         BxB4bAM8bAV4Aiyti5oBdnz74FvaQhbobNWI+vYO3lD4RyFcjN9Rtf9TwzH8NXSKH19q
         2psY+FHZ5NWA5+5jB62aLetgsu3KzRYnS41gPmAphyrQB/m2vM+115QDn1MEoe5pdotv
         MiMRdZiizCG7Je4IPvg/7H9I+e1SjmgdlmhARHJicYfMOk69rR2cS5WElgx4gMOMGHpe
         iVuATRlN4MHuNnnRJkLEBnbwAcq+vhsgizzU03+8CPS3uPPjmfMs1hFMzQAYOF7im1bA
         12cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=y4UhhqJ3Oy5m10obzfeCNIu6uYRDzLagc7ZKXtuv5pA=;
        b=bKEViuLS1g5n0XN/t+QxtB4sZFOaIbOqomLatB31GWXNcr6jCH/w4hCMThoG8nIVDY
         AKKcQwqjf8LTKBqHBr9eMaa5sZCyAG8T4P7nJOIOah7M06plopeGvQjHFDZ21erziHZt
         fdwHkIT4M6FueA4oA4c6HcXd/vdnHmIoZYJtf0d2YDvqSxiVNFr+D/IHUUi2CFiq2JM7
         RZud2QVYiCjiM6PHeMBqVupAxtR10mDWdvVJiX9k5R18gTT5xFXuyyplLp4GuGNEck4A
         FH+c/l0TzvDi8IdkKYQG1vXUWi090qKSmTyLY0WKyWvDXlq4VbE1Ya0e+eIIbLNxu0N3
         UIhw==
X-Gm-Message-State: ACrzQf2H8XvtsanbGqheBy9dM2TuvGKzCBwIa/KJ401RV346aVTcPnA8
        qmAyr/d05UVj5vPKAnIIjL7EJis4K/0wHbqNrw8cnA==
X-Google-Smtp-Source: AMsMyM7EY/h+UhTrJZ4Pyz4Lq8smIvuC/YLM/Lg3P3wF36BIjUEbefgD8koPi0WZnrSYdsaILp0kRjPFKi420Xf4ImU=
X-Received: by 2002:a05:651c:1548:b0:26c:61b3:7129 with SMTP id
 y8-20020a05651c154800b0026c61b37129mr10314609ljp.381.1665589378239; Wed, 12
 Oct 2022 08:42:58 -0700 (PDT)
MIME-Version: 1.0
References: <20220925143908.10846-1-vincent.guittot@linaro.org>
 <20220925143908.10846-6-vincent.guittot@linaro.org> <20221012142248.k6pdjgxwkk2cshuu@wubuntu>
In-Reply-To: <20221012142248.k6pdjgxwkk2cshuu@wubuntu>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Wed, 12 Oct 2022 17:42:46 +0200
Message-ID: <CAKfTPtADxP7eSETpazO9LFr+Et=GnSuWc45s3cfRACq82tRO_g@mail.gmail.com>
Subject: Re: [PATCH v5 5/7] sched/fair: Add sched group latency support
To:     Qais Yousef <qais.yousef@arm.com>
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        linux-kernel@vger.kernel.org, parth@linux.ibm.com,
        chris.hyser@oracle.com, valentin.schneider@arm.com,
        patrick.bellasi@matbug.net, David.Laight@aculab.com,
        pjt@google.com, pavel@ucw.cz, tj@kernel.org, qperret@google.com,
        tim.c.chen@linux.intel.com, joshdon@google.com, timj@gnu.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 Oct 2022 at 16:22, Qais Yousef <qais.yousef@arm.com> wrote:
>
> On 09/25/22 16:39, Vincent Guittot wrote:
> > Task can set its latency priority with sched_setattr(), which is then used
> > to set the latency offset of its sched_entity, but sched group entities
> > still have the default latency offset value.
> >
> > Add a latency.nice field in cpu cgroup controller to set the latency
> > priority of the group similarly to sched_setattr(). The latency priority
> > is then used to set the offset of the sched_entities of the group.
> >
> > Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> > ---
> >  Documentation/admin-guide/cgroup-v2.rst |  8 ++++
> >  kernel/sched/core.c                     | 53 +++++++++++++++++++++++++
> >  kernel/sched/fair.c                     | 33 +++++++++++++++
> >  kernel/sched/sched.h                    |  4 ++
> >  4 files changed, 98 insertions(+)
> >
> > diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
> > index be4a77baf784..d8ae7e411f9c 100644
> > --- a/Documentation/admin-guide/cgroup-v2.rst
> > +++ b/Documentation/admin-guide/cgroup-v2.rst
> > @@ -1095,6 +1095,14 @@ All time durations are in microseconds.
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
> > +     same values used by sched_setattr(2).
>
> I still don't understand how tasks will inherit the latency_nice value from
> cgroups they're attached to.

The behavior is the same as for sched_entity weight. The latency is
applied on the sched_entity of the group

>
> For example, in EAS path we operate at task level only. If the task's
> p->latency_nice = 0, but it belongs to a task group tg->latency_nice = -19;
> what should the task's latency_nice be in this case? If it's in a hierarchy,
> how would the effective value be calculated?
>
>
> Thanks
>
> --
> Qais Yousef
