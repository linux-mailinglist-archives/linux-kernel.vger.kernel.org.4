Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69CED641789
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Dec 2022 16:36:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229698AbiLCPgC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Dec 2022 10:36:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbiLCPgA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Dec 2022 10:36:00 -0500
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0303F1F2CF
        for <linux-kernel@vger.kernel.org>; Sat,  3 Dec 2022 07:35:59 -0800 (PST)
Received: by mail-qk1-x72a.google.com with SMTP id x24so1291559qkf.5
        for <linux-kernel@vger.kernel.org>; Sat, 03 Dec 2022 07:35:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:from:to:cc:subject:date:message-id
         :reply-to;
        bh=J3IhEJou5baGYMDYXLPZW8UqlEc+MfCXTEyktgIRSTQ=;
        b=PltGozi3WOrJ+my4OWUkffiB5UIIBkPwDO8Lvu2QF3LWTC65D5N8AyE2dxnY3cnVIX
         pSfmbI/kEIpXlEh8HBQoQ+ajxQBhQopA8+17D4RXqdjh719sHxmu7tjOQJ6sURonrfUH
         CRmiNt9R8w7DLFxCfU4f/6x1dDNHhPsyJM9PQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J3IhEJou5baGYMDYXLPZW8UqlEc+MfCXTEyktgIRSTQ=;
        b=SCVye9uN1yvRk3gJHk1hcDF5S7rxnpPx2UqH3Od2rvY38UiS6bR0dqCxTn6YFWKPYZ
         np0B5JR9DCYCIQydca5Rd7RIQqWr0LtFklh2SYwGv66p/uCx6QhcBcxm9ZhmawPC4zGL
         ChmeXVmhAPSoizfymFYfJ/OUzthh5k5jmQJcsaAGzrsQF2376ITmy9qpGSyZv6RGNZhK
         X7PiSSujj7yb6MtDAu6KA6UeXhuUd1IhDRQAEmrSwUrRfXd856a6nQMnTI3Zdk5L5L0A
         VvjIEw7BcCCUkEV7Frlyf/M6GX6w6hlAXXG57vn9pkp3Tlvg02zrOvUZipTHAxm9U6/J
         HY7g==
X-Gm-Message-State: ANoB5pmBdijW+SEdE5wyEdnJGq4b4A6EB+pswnwH+J57CXxiZTL+xX//
        xR+P8wkGP63YlPmtD4xRJp2tVg==
X-Google-Smtp-Source: AA0mqf5lT63wFhrGVLbpSxZt1EYLTO4ZqZl5PWNl9W8p67FhXxyOTkLMmRba/7Xhc9IcyArpVAGNCg==
X-Received: by 2002:a37:58a:0:b0:6fa:d64:c018 with SMTP id 132-20020a37058a000000b006fa0d64c018mr51727066qkf.145.1670081758042;
        Sat, 03 Dec 2022 07:35:58 -0800 (PST)
Received: from smtpclient.apple (c-98-249-43-138.hsd1.va.comcast.net. [98.249.43.138])
        by smtp.gmail.com with ESMTPSA id s190-20020ae9dec7000000b006f7ee901674sm7862491qkf.2.2022.12.03.07.35.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 03 Dec 2022 07:35:57 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Joel Fernandes <joel@joelfernandes.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v3 1/2] sched/fair: Introduce short duration task check
Date:   Sat, 3 Dec 2022 10:35:46 -0500
Message-Id: <3A5DA66F-4330-4FC4-9229-998CF98F663E@joelfernandes.org>
References: <Y4r/iuqyLG4MOK4d@chenyu5-mobl1>
Cc:     Honglei Wang <wanghonglei@didichuxing.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Tim Chen <tim.c.chen@intel.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Juri Lelli <juri.lelli@redhat.com>,
        Rik van Riel <riel@surriel.com>,
        Aaron Lu <aaron.lu@intel.com>,
        Abel Wu <wuyun.abel@bytedance.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        Yicong Yang <yangyicong@hisilicon.com>,
        "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
        Ingo Molnar <mingo@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Hillf Danton <hdanton@sina.com>,
        Len Brown <len.brown@intel.com>,
        Chen Yu <yu.chen.surf@gmail.com>,
        Tianchen Ding <dtcccc@linux.alibaba.com>,
        Josh Don <joshdon@google.com>, linux-kernel@vger.kernel.org
In-Reply-To: <Y4r/iuqyLG4MOK4d@chenyu5-mobl1>
To:     Chen Yu <yu.c.chen@intel.com>
X-Mailer: iPhone Mail (20B101)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Dec 3, 2022, at 2:50 AM, Chen Yu <yu.c.chen@intel.com> wrote:
>=20
> =EF=BB=BFHi Honglei,
>> On 2022-12-02 at 15:44:18 +0800, Honglei Wang wrote:
>>=20
>>=20
>>> On 2022/12/1 16:44, Chen Yu wrote:
>>> Introduce short-duration task checks, as there is requirement
>>> to leverage this attribute for better task placement.
>>>=20
>>> There are several choices of metrics that could be used to
>>> indicate if a task is a short-duration task.
>>>=20
>>> At first thought the (p->se.sum_exec_runtime / p->nvcsw)
>>> could be used to measure the task duration. However, the
>>> history long past was factored too heavily in such a formula.
>>> Ideally, the old activity should decay and not affect
>>> the current status too much.
>>>=20
>>> Although something based on PELT could be used, se.util_avg might
>>> not be appropriate to describe the task duration:
>>> 1. Task p1 and task p2 are doing frequent ping-pong scheduling on
>>>    one CPU, both p1 and p2 have a short duration, but the util_avg
>>>    can be up to 50%.
>>> 2. Suppose a task lasting less than 4ms is regarded as a short task.
>>>    If task p3 runs for 6ms and sleeps for 32ms, p3 should not be a
>>>    short-duration task. However, PELT would decay p3's accumulated
>>>    running time from 6ms to 3ms, because 32ms is the half-life in PELT.
>>>    As a result, p3 would be incorrectly treated as a short task.
>>>=20
>>> It was found that there was once a similar feature to track the
>>> duration of a task, which is in Commit ad4b78bbcbab ("sched: Add
>>> new wakeup preemption mode: WAKEUP_RUNNING"). Unfortunately, it
>>> was reverted because it was an experiment. So pick the patch up
>>> again, by recording the average duration when a task voluntarily
>>> switches out. Introduce SIS_SHORT to control this strategy.
>>>=20
>>> The threshold of short duration reuses sysctl_sched_min_granularity,
>>> so it can be tuned by the user. Ideally there should be a dedicated
>>> parameter for the threshold, but that might introduce complexity.
>>>=20
>>> Suggested-by: Tim Chen <tim.c.chen@intel.com>
>>> Suggested-by: Vincent Guittot <vincent.guittot@linaro.org>
>>> Signed-off-by: Chen Yu <yu.c.chen@intel.com>
>>> ---
>>>  include/linux/sched.h   |  4 ++++
>>>  kernel/sched/core.c     |  2 ++
>>>  kernel/sched/fair.c     | 17 +++++++++++++++++
>>>  kernel/sched/features.h |  1 +
>>>  4 files changed, 24 insertions(+)
>>>=20
>>> diff --git a/include/linux/sched.h b/include/linux/sched.h
>>> index ffb6eb55cd13..64b7acb77a11 100644
>>> --- a/include/linux/sched.h
>>> +++ b/include/linux/sched.h
>>> @@ -558,6 +558,10 @@ struct sched_entity {
>>>      u64                nr_migrations;
>>> +    u64                prev_sum_exec_runtime_vol;
>>> +    /* average duration of a task */
>>> +    u64                dur_avg;
>>> +
>>>  #ifdef CONFIG_FAIR_GROUP_SCHED
>>>      int                depth;
>>>      struct sched_entity        *parent;
>>> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
>>> index daff72f00385..c5202f1be3f7 100644
>>> --- a/kernel/sched/core.c
>>> +++ b/kernel/sched/core.c
>>> @@ -4348,6 +4348,8 @@ static void __sched_fork(unsigned long clone_flags=
, struct task_struct *p)
>>>      p->se.prev_sum_exec_runtime    =3D 0;
>>>      p->se.nr_migrations        =3D 0;
>>>      p->se.vruntime            =3D 0;
>>> +    p->se.dur_avg            =3D 0;
>>> +    p->se.prev_sum_exec_runtime_vol    =3D 0;
>>>      INIT_LIST_HEAD(&p->se.group_node);
>>>  #ifdef CONFIG_FAIR_GROUP_SCHED
>>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
>>> index e4a0b8bd941c..a4b314b664f8 100644
>>> --- a/kernel/sched/fair.c
>>> +++ b/kernel/sched/fair.c
>>> @@ -6200,6 +6200,16 @@ static int wake_wide(struct task_struct *p)
>>>      return 1;
>>>  }
>>> +/*
>>> + * If a task switches in and then voluntarily relinquishes the
>>> + * CPU quickly, it is regarded as a short duration task.
>>> + */
>>> +static inline int is_short_task(struct task_struct *p)
>>> +{
>>> +    return sched_feat(SIS_SHORT) &&
>>> +        (p->se.dur_avg <=3D sysctl_sched_min_granularity);
>>> +}
>>> +
>>=20
>> Hi Yu,
>>=20
>> I still have a bit concern about the sysctl_sched_min_granularity stuff..=

>> This grab can be set to different value which will impact the action of t=
his
>> patch and make things not totally under control.

There are already ways to misconfigure sched sysctl to make bad/weird things=
 happen.

>> Not sure if we can add a new grab for this.. The test result shows good
>> improvement for short task, and with this grab, admins will be able to
>> custom the system base on their own 'short task' view.
>>=20
> It would be ideal to have a dedicated parameter to tweak this. For example=
,
> something under /sys/kernel/debug/sched/, and initilized to sysctl_sched_m=
in_granularity
> by default.=20

It would be nice to not have to introduce a new knob for this. IMO, min_gran=
ularity is reasonable.

Thanks.



>=20
> thanks,
> Chenyu
