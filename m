Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF5505BD170
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 17:49:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230326AbiISPts (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 11:49:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230256AbiISPtn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 11:49:43 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A572A457
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 08:49:42 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id o2so45444807lfc.10
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 08:49:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=727A2Egyd+TlAq1hzqfr+ueFM+evWuNk6RTOLKSgVdk=;
        b=EbR2L2j68a7CD/15XHZ22f2U/ayx/P4h648AaT4K8/YwwbDXHmHXln4Rcfgz9Ath5V
         srtHBEIwnWI9vaxkm1SyV2713bqLef6P4aV/tBetWZOV3D9DI6VpxL1JsaBdJCSKsZgd
         4Byp08vzbSSRPRh6py8Ck7+gvMjyr7igHUfYWJMk6EBncBP1GrD1x0CQsFfYcopu01Pm
         3Uia3hniihIGgdBpHvBJtrKSVdY0K+qNWjTNYbrFkDjxUVrPBz674tle5n0pG0mErhxU
         HvCUKJHbQnr3DuicIrU2sOgG9z0h/lGW+42QsZ46kBVFjA5xLbRjWMT2Vt5g29Zl4f9k
         sXEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=727A2Egyd+TlAq1hzqfr+ueFM+evWuNk6RTOLKSgVdk=;
        b=lUvoUFDT8ba2Wm8LYQRaV3WfKA+oBD6qjEozAiaTX76YZnt8a5oCQkyN+4ErBKYyfs
         hOqTCgxBj7aOPUwYLJm7tsV96Ek814c9SEg9ZZJqYvif0TB/Eukz9yH5dWrVO7hmVBly
         QWdzWcZYe8qR3W1tXelbKx9J/r54IT+DOa40xH2KHFfHY0k11MkKF0jp6x0OS5BjIiVu
         bY+Xhr/s6++aOcjNPjz45w4tVqqh09UB7haBWooL6R+bXH9yOr21bYmNrWOqO3GVaS0h
         XUB6KmdTAN2K5qbw36mZW/v/EkqLoR7ntc8CCpQCM9aZkuATylC1Y0gGAEdHmO3+vS8r
         IB/Q==
X-Gm-Message-State: ACrzQf2EoNHHbolljwjQCKjbTlhPxQEOS6wUjGgoRaWIYS4J725WmA2Q
        ObOkvud3NbeQJk+H9BT18207oxORe8ocbKfLA2+vyw==
X-Google-Smtp-Source: AMsMyM7rCVIQS/uAzfmkW6vAAd+oVX5H8dLSoxhi0C7dLx6HnCEBSd2KUM4/4h6AeG1FRgkJLf29/2yRHdiroIW58j4=
X-Received: by 2002:a05:6512:3183:b0:498:fa29:35fe with SMTP id
 i3-20020a056512318300b00498fa2935femr6271367lfe.523.1663602580349; Mon, 19
 Sep 2022 08:49:40 -0700 (PDT)
MIME-Version: 1.0
References: <20220916080305.29574-1-vincent.guittot@linaro.org>
 <20220916080305.29574-7-vincent.guittot@linaro.org> <000c2893-feb4-373d-2234-2ca74be94714@arm.com>
In-Reply-To: <000c2893-feb4-373d-2234-2ca74be94714@arm.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Mon, 19 Sep 2022 17:49:27 +0200
Message-ID: <CAKfTPtASminP4ogVRhcvQ4R3-x-E+UUzuMaEu-xQU_MtLr9+Xg@mail.gmail.com>
Subject: Re: [PATCH v4 6/8] sched/fair: Add sched group latency support
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com,
        linux-kernel@vger.kernel.org, parth@linux.ibm.com,
        qais.yousef@arm.com, chris.hyser@oracle.com,
        valentin.schneider@arm.com, patrick.bellasi@matbug.net,
        David.Laight@aculab.com, pjt@google.com, pavel@ucw.cz,
        tj@kernel.org, qperret@google.com, tim.c.chen@linux.intel.com,
        joshdon@google.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 19 Sept 2022 at 13:55, Dietmar Eggemann
<dietmar.eggemann@arm.com> wrote:
>
> s/valentin.schneider@arm.com//
>
> On 16/09/2022 10:03, Vincent Guittot wrote:
> > Task can set its latency priority, which is then used to decide to preempt
> > the current running entity of the cfs, but sched group entities still have
> > the default latency offset.
> >
> > Add a latency field in task group to set the latency offset of the
> > sched_eneities of the group, which will be used against other entities in
>
> s/sched_eneities/sched_entity
>
> > the parent cfs when deciding which entity to schedule first.
>
> So latency for cgroups does not follow any (existing) Resource
> Distribution Model/Scheme (Documentation/admin-guide/cgroup-v2.rst)?
> Latency values are only used to compare sched entities at the same level.

Just like share/cpu.weight value does for time sharing

>
> [...]
>
> > +static int cpu_latency_write_s64(struct cgroup_subsys_state *css,
> > +                             struct cftype *cft, s64 latency)
> > +{
>
> There is no [MIN, MAX] checking?

This is done is sched_group_set_latency() which checks that
abs(latency) < sysctl_sched_latency

>
> min_weight = sched_latency_to_weight[0]  = -1024
> max_weight = sched_latency_to_weight[39] =   973
>
> [MIN, MAX] = [sysctl_sched_latency * min_weight >> NICE_LATENCY_SHIFT,
>               sysctl_sched_latency * max_weight >> NICE_LATENCY_SHIFT]
>
>
> With the `cpu.latency` knob user would have to know for example that the
> value is -24,000,000ns to get the same behaviour as for a task latency
> nice = -20 (latency prio = 0) (w/ sysctl_sched_latency = 24ms)?

Yes, Tejun raised some concerns about adding an interface like nice in
the task group in v2 so I have removed it.

>
> For `nice` we have `cpu.weight.nice` next to `cpu.weight` in cgroup v2 ?

If everybody is ok, I can add back the cpu.latency.nice interface in
the v5 in addition to the cpu.latency

>
> [...]
