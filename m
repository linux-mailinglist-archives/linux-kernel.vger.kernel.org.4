Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5389D61972C
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 14:13:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231543AbiKDNNQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 09:13:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230164AbiKDNNN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 09:13:13 -0400
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F13802E686
        for <linux-kernel@vger.kernel.org>; Fri,  4 Nov 2022 06:13:12 -0700 (PDT)
Received: by mail-qk1-x733.google.com with SMTP id v8so2966394qkg.12
        for <linux-kernel@vger.kernel.org>; Fri, 04 Nov 2022 06:13:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UZDUFAOcL/RWTxU01Fonl1AWaFKtNcoZ+QGr4PWfeeo=;
        b=lo9JpHPOCN5f+FT9jZqAw1Fesqu0+ruMOoclWFDIikC4H4npzBB0Ayr5GKNV8Ov4e5
         oc5o/wf5uaEasxorju1ASVDVqU/EXkTV4pXVnjLSMY0+aj5oUxYRn2kB3NBoiBO3fPt1
         SvuAuNmBrK8tWwG3BIgEH/nhBGeOGwZ9lYJI4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UZDUFAOcL/RWTxU01Fonl1AWaFKtNcoZ+QGr4PWfeeo=;
        b=oTyHVJEKVviuF4R3/3EPKpPDrxuu6KZRz1Sby4ahRWjIGMzDN7XalGL+NyxCHtr/9d
         2F/ZQr+EBpZdlLaszikQ6edA8nOe/ghP0hEnSP24hc2Y671U74r8fMtBAUH4ADKt4D0V
         DR35RnqX1Aa43K04zApe5IqrfZB6bsItTqm9/8hzH21EzLriswV4qKKtZtAxu0wQBvtV
         MdxaMCBzQxHOXa4Cycchp9DYSV72ArD0BeVyPXwNiWjbEP7jAxbgODZG9g8dwQBEsBl1
         B2z8+RnT5eg6lAjs94+ntrK57qVa40ZKV1lTUZpHdgOWcmQR4yaxBStFU1y+941ri9OT
         M9Qw==
X-Gm-Message-State: ACrzQf3yFlAKvsdBPbEvxSJDJSZnRcMrTfh0O1VLJJ0ooP236Z9pck89
        c8zqKEdDLykc3omjRMn5vwduIA==
X-Google-Smtp-Source: AMsMyM72wMXoJ7BeCRLb6g/EOnjaEd/iLEwevdXsQoXGqceWEcW/8jZ609rY6Ze9OLxwHyQ8FuHgYw==
X-Received: by 2002:a05:620a:4008:b0:6ee:afac:8e9a with SMTP id h8-20020a05620a400800b006eeafac8e9amr25651852qko.317.1667567591976;
        Fri, 04 Nov 2022 06:13:11 -0700 (PDT)
Received: from smtpclient.apple (c-73-148-104-166.hsd1.va.comcast.net. [73.148.104.166])
        by smtp.gmail.com with ESMTPSA id j6-20020ac85f86000000b00397e97baa96sm2527666qta.0.2022.11.04.06.13.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Nov 2022 06:13:11 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Joel Fernandes <joel@joelfernandes.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v7 6/9] sched/fair: Add sched group latency support
Date:   Fri, 4 Nov 2022 09:13:10 -0400
Message-Id: <B7E91F49-3053-44E7-A515-8647A4C93D2D@joelfernandes.org>
References: <20221104112138.hlnwjmw2ls4gswuo@airbuntu>
Cc:     Vincent Guittot <vincent.guittot@linaro.org>, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        linux-kernel@vger.kernel.org, parth@linux.ibm.com,
        qais.yousef@arm.com, chris.hyser@oracle.com,
        patrick.bellasi@matbug.net, David.Laight@aculab.com,
        pjt@google.com, pavel@ucw.cz, tj@kernel.org, qperret@google.com,
        tim.c.chen@linux.intel.com, joshdon@google.com, timj@gnu.org,
        kprateek.nayak@amd.com, yu.c.chen@intel.com,
        youssefesmat@chromium.org
In-Reply-To: <20221104112138.hlnwjmw2ls4gswuo@airbuntu>
To:     Qais Yousef <qyousef@layalina.io>
X-Mailer: iPhone Mail (19G82)
X-Spam-Status: No, score=-0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLACK autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Nov 4, 2022, at 7:21 AM, Qais Yousef <qyousef@layalina.io> wrote:
>=20
> =EF=BB=BFOn 11/03/22 18:02, Vincent Guittot wrote:
>>> On Thu, 3 Nov 2022 at 15:27, Qais Yousef <qyousef@layalina.io> wrote:
>>>=20
>>> On 11/03/22 09:46, Vincent Guittot wrote:
>>>> On Tue, 1 Nov 2022 at 20:28, Qais Yousef <qyousef@layalina.io> wrote:
>>>>>=20
>>>>> On 10/28/22 11:34, Vincent Guittot wrote:
>>>>>> Task can set its latency priority with sched_setattr(), which is then=
 used
>>>>>> to set the latency offset of its sched_enity, but sched group entitie=
s
>>>>>> still have the default latency offset value.
>>>>>>=20
>>>>>> Add a latency.nice field in cpu cgroup controller to set the latency
>>>>>> priority of the group similarly to sched_setattr(). The latency prior=
ity
>>>>>> is then used to set the offset of the sched_entities of the group.
>>>>>>=20
>>>>>> Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
>>>>>> ---
>>>>>> Documentation/admin-guide/cgroup-v2.rst |  8 ++++
>>>>>> kernel/sched/core.c                     | 52 ++++++++++++++++++++++++=
+
>>>>>> kernel/sched/fair.c                     | 33 ++++++++++++++++
>>>>>> kernel/sched/sched.h                    |  4 ++
>>>>>> 4 files changed, 97 insertions(+)
>>>>>>=20
>>>>>> diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/=
admin-guide/cgroup-v2.rst
>>>>>> index be4a77baf784..d8ae7e411f9c 100644
>>>>>> --- a/Documentation/admin-guide/cgroup-v2.rst
>>>>>> +++ b/Documentation/admin-guide/cgroup-v2.rst
>>>>>> @@ -1095,6 +1095,14 @@ All time durations are in microseconds.
>>>>>>         values similar to the sched_setattr(2). This maximum utilizat=
ion
>>>>>>         value is used to clamp the task specific maximum utilization c=
lamp.
>>>>>>=20
>>>>>> +  cpu.latency.nice
>>>>>> +     A read-write single value file which exists on non-root
>>>>>> +     cgroups.  The default is "0".
>>>>>> +
>>>>>> +     The nice value is in the range [-20, 19].
>>>>>> +
>>>>>> +     This interface file allows reading and setting latency using th=
e
>>>>>> +     same values used by sched_setattr(2).
>>>>>=20
>>>>> I'm still not sure about this [1].
>>>>=20
>>>> I'm still not sure about what you are trying to say here ...
>>>>=20
>>>> This is about setting a latency nice prio to a group level.
>>>>=20
>>>>>=20
>>>>> In some scenarios we'd like to get the effective latency_nice of the t=
ask. How
>>>>> will the task inherit the cgroup value or be impacted by it?
>>>>>=20
>>>>> For example if there are tasks that belong to a latency sensitive cgro=
up; and
>>>>> I'd like to skip some searches in EAS to improve that latency sensitiv=
ity - how
>>>>> would I extract this info in EAS path given these tasks are using defa=
ult
>>>>> latency_nice value? And if should happen if their latency_nice is set t=
o
>>>>> something else other than default?
>>>>>=20
>>>>> [1] https://lore.kernel.org/lkml/20221012160734.hrkb5jcjdq7r23pr@wubun=
tu/
>>>>=20
>>>> Hmm so you are speaking about something that is not part of the patch.
>>>> Let focus on the patchset for now
>>>=20
>>> I am focusing on this patchset. Isn't this an essential part of the desi=
gn?
>>> Once the interface is out we can't change it. As it stands, I can't see h=
ow it
>>=20
>> So, are you speaking about the interface i.e. setting a value between [-2=
0:19]
>=20
> About how the cgroup and per task interface interact.
>=20
> How to get the effective value of latency_nice for a task that belongs to
> a hierarchy?
>=20
> If I have a task that has p->latency_nice =3D 20 but it belongs to a cgrou=
p that
> has tg->cpu.latency.nice =3D -19

Just for the task placement signal, One way is to go through the se hierarch=
y till the root and get the minimum. Then make that the effective value. So I=
n your example that would make it -19 so prefer idle =3D 1.  We should need a=
 Boolean signal. Not pretty but not the end of the world imho.

> And I want to use this interface in EAS; how should I interpret these valu=
es?
> How should I walk up the hierarchy and decide the _effective_ latency_nice=

> value

Ah, using a min function?

Joel



>>=20
> Thanks
>=20
> --
> Qais Yousef
>=20
>>=20
>>>=20
>>>=20
>>> Thanks
>>>=20
>>> --
>>> Qais Yousef
