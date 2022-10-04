Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 836915F3B68
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 04:29:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229627AbiJDC34 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Oct 2022 22:29:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbiJDC3v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Oct 2022 22:29:51 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C59563B1
        for <linux-kernel@vger.kernel.org>; Mon,  3 Oct 2022 19:29:50 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id f37so842059lfv.8
        for <linux-kernel@vger.kernel.org>; Mon, 03 Oct 2022 19:29:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=LXc/Zr9rQnUyqTp1Msxz0HMk29xy25iHM+OGOUqnh3g=;
        b=P+9IwY0lgP4SjANLp/p6iC3wXSkCq1AxDeGJ0pqe4skyVfuFjM1M9zc/uAOrvH2PmB
         iJtz8uJl+JevvJjA5NF5/ETPwATuYwT2epaVgFLTusaz7g+T9e+TieLroDz6JBlFAX19
         Zz8gflffjQws1LnCy66HzYKz6lRkPZIP7kPKmQwax6veEg/svrGogvGXm3ImsfpFBA7c
         lkAiZgKqdCe6OGwz7402FAi/nrfYc9sPNH1HHLYXQZhUbTQc8M83JO327+AHaCaoM/OA
         BF4HMUlg5AziqwMl6iN2JAFlr5q0Z2I79K50LcKOxWuzVKSl4b73F3h7lo59z9OcZhy0
         tUCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=LXc/Zr9rQnUyqTp1Msxz0HMk29xy25iHM+OGOUqnh3g=;
        b=bZbA7U4fSN96hADtVU/yoajIVZcy7jVhxMaJXDi+DIKcZjdNR//8KQCsDOWTUoAJRK
         UzbfpWUSow7FO2Qq2+iVdOdQSmh5o6J3qhtsZlBonuESNgOPKXH7zW+uD+bHoPbNprU9
         s8IX6X1vqPh4ldbuw2gIGrVB8Bt8VMUBzmWUvaRnugTd+odGcpDLK3Dxp/3NfBpdGuDp
         ThXzi59O3Bm4isdIyxgIbRyNxDmjnyze3MaqezDugAVX0G/A2OylQuiJvCkiwnnPJkCN
         gfEaJAEaBtFOSZ8WWQVlcF1F87U0Emw+t4ACD+a94I3kTaCv0jsZmnyEsq1fjRXSj/Se
         X/lA==
X-Gm-Message-State: ACrzQf0K6jclnkLHwb+0EoT4NrMWC/TNxwfW3zmqm1VDhscwvAXqlO4y
        soMxlTSAk0MoMSo6kZXV+ILu3aIRgeHlDtBhOItrjCYZHg==
X-Google-Smtp-Source: AMsMyM7MyIdPOq0gTZwp9zWFUypig2W9uQTQgh+lBOZbwJxsVl+CWr1Rmi+5oWwOAh4ZNeXjxJb6VsA9YrxHWe3gAY0=
X-Received: by 2002:a05:6512:33d5:b0:49a:d2dc:e1e3 with SMTP id
 d21-20020a05651233d500b0049ad2dce1e3mr7608239lfg.628.1664850589042; Mon, 03
 Oct 2022 19:29:49 -0700 (PDT)
MIME-Version: 1.0
References: <20221003232033.3404802-3-jstultz@google.com> <20221004013611.1822-1-hdanton@sina.com>
In-Reply-To: <20221004013611.1822-1-hdanton@sina.com>
From:   John Stultz <jstultz@google.com>
Date:   Mon, 3 Oct 2022 19:29:36 -0700
Message-ID: <CANDhNCoVzJ_MSyAigMkE-TMgfRQRkiK=G0_S3OwPfnXPuKu1iA@mail.gmail.com>
Subject: Re: [RFC PATCH v4 2/3] sched: Avoid placing RT threads on cores
 handling long softirqs
To:     Hillf Danton <hdanton@sina.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
        "Connor O'Brien" <connoro@google.com>,
        Qais Yousef <qais.yousef@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>
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

On Mon, Oct 3, 2022 at 6:56 PM Hillf Danton <hdanton@sina.com> wrote:
> On 3 Oct 2022 23:20:32 +0000 John Stultz <jstultz@google.com>
> > +#ifdef CONFIG_RT_SOFTIRQ_OPTIMIZATION
> > +#define __use_softirq_opt 1
> > +/*
> > + * Return whether the given cpu is currently non-preemptible
> > + * while handling a potentially long softirq, or if the current
> > + * task is likely to block preemptions soon because it is a
> > + * ksoftirq thread that is handling slow softirq.
> > + */
> > +static bool cpu_busy_with_softirqs(int cpu)
> > +{
> > +     u32 softirqs = per_cpu(active_softirqs, cpu) |
> > +                    __cpu_softirq_pending(cpu);
> > +     struct task_struct *cpu_ksoftirqd = per_cpu(ksoftirqd, cpu);
> > +     struct task_struct *curr;
> > +     struct rq *rq = cpu_rq(cpu);
> > +     int ret;
> > +
> > +     rcu_read_lock();
> > +     curr = READ_ONCE(rq->curr); /* unlocked access */
> > +     ret = (softirqs & LONG_SOFTIRQ_MASK) &&
> > +              (curr == cpu_ksoftirqd ||
> > +               preempt_count() & SOFTIRQ_MASK);
> > +     rcu_read_unlock();
> > +     return ret;
> > +}
> > +#else
> > +#define __use_softirq_opt 0
> > +static bool cpu_busy_with_softirqs(int cpu)
> > +{
> > +     return false;
> > +}
> > +#endif /* CONFIG_RT_SOFTIRQ_OPTIMIZATION */
> > +
> > +static bool rt_task_fits_cpu(struct task_struct *p, int cpu)
> > +{
> > +     return !cpu_busy_with_softirqs(cpu) && rt_task_fits_capacity(p, cpu);
> > +}
>
> On one hand, RT task is not layency sensitive enough if it fails to preempt
> ksoftirqd. On the other, deferring softirq to ksoftirqd barely makes sense
> in 3/3 if it preempts the current RT task.

Apologies, I'm not sure I'm following you here. Why would ksoftirqd
preempt the rt task?

thanks
-john
