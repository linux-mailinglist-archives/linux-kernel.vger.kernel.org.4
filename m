Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD74E6194E2
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 11:55:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231665AbiKDKz5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 06:55:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbiKDKzv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 06:55:51 -0400
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 636E12B1BD
        for <linux-kernel@vger.kernel.org>; Fri,  4 Nov 2022 03:55:50 -0700 (PDT)
Received: by mail-qv1-xf35.google.com with SMTP id h10so2927779qvq.7
        for <linux-kernel@vger.kernel.org>; Fri, 04 Nov 2022 03:55:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:from:to:cc:subject:date:message-id
         :reply-to;
        bh=m6rrlAfBsKD8gTPvCkh1Ab4cJUCPWtD+C8D8BepOwzI=;
        b=pyHdnTd/0a6HLbDG+yMbapvIpgqafaYF1+DwCx63LJGKcQtxmnOf4qZBdUYZ2E8oOy
         LzQBKefvl/U/lXkdmL4cfz0hV6qjS+LCI7e21VcPp1tINnmO4guiYOzki6xmiC1ZLeSl
         k1I6B1tn4AD8S38pMR9veTSjIIKSpoYFN14H4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m6rrlAfBsKD8gTPvCkh1Ab4cJUCPWtD+C8D8BepOwzI=;
        b=Eai+L1dQrSx1PwpEJCtczni6rEnPteeMunVds6nIQrUwwzNypu9mzw7S6RPOlUuREf
         eGIFb9acixGcYMPIKmArgnqvRsADYZUFXRkD5L5APR8dBpm+cnJQDrUGke+0ZIWs8CJT
         6sFBy6BmRPAAdP1w/S1wYaiBJF4SUvE7sXMrBxlKVice19ktiidNEeEi4qKpq1cQga/o
         VPOcu6ZUM4Oe0tApGHW1o7skdyyMdBQ7Scd+IiS8j1m0VC/NYmN30W4GiFrkQWiVfbUD
         NKADpmzY3rggsLkXJ0zBtZwZP2TksvSeSVHJJsXGxZVw+Ce59FjAJiro/2BTBf1E0rHW
         NZ2Q==
X-Gm-Message-State: ACrzQf2Bt4IrThRapP7U/w4qGnrm37jLfC6AUwI+KhAkwZ1WZ5eoYdlU
        dXEAjZCSMRhIcpv9ZhS3f8kWzg==
X-Google-Smtp-Source: AMsMyM5JmE5SEXSAY3N+qlWjqCIiBukkWULJvkpAaMnGuCcqWU7MDCSwZdmIwh6X2y/ftIGAtm1xxg==
X-Received: by 2002:a0c:dd13:0:b0:4bb:664c:5aaa with SMTP id u19-20020a0cdd13000000b004bb664c5aaamr31708936qvk.121.1667559349437;
        Fri, 04 Nov 2022 03:55:49 -0700 (PDT)
Received: from smtpclient.apple (c-73-148-104-166.hsd1.va.comcast.net. [73.148.104.166])
        by smtp.gmail.com with ESMTPSA id x4-20020a05620a258400b006ec771d8f89sm2708412qko.112.2022.11.04.03.55.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Nov 2022 03:55:48 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Joel Fernandes <joel@joelfernandes.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v7 6/9] sched/fair: Add sched group latency support
Date:   Fri, 4 Nov 2022 06:55:48 -0400
Message-Id: <CD57BDD3-5919-48EC-992A-3879D8AA074F@joelfernandes.org>
References: <CAKfTPtBJQOY7UUkm1=wvG18UWgLLiTW0dr3bTGUJY=siM_LLxQ@mail.gmail.com>
Cc:     Qais Yousef <qyousef@layalina.io>, mingo@redhat.com,
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
In-Reply-To: <CAKfTPtBJQOY7UUkm1=wvG18UWgLLiTW0dr3bTGUJY=siM_LLxQ@mail.gmail.com>
To:     Vincent Guittot <vincent.guittot@linaro.org>
X-Mailer: iPhone Mail (19G82)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Nov 4, 2022, at 6:37 AM, Vincent Guittot <vincent.guittot@linaro.org> w=
rote:
>=20
> =EF=BB=BFOn Fri, 4 Nov 2022 at 11:15, Joel Fernandes <joel@joelfernandes.o=
rg> wrote:
>>=20
>>> On Thu, Nov 3, 2022 at 5:03 PM Vincent Guittot
>>> <vincent.guittot@linaro.org> wrote:
>>>=20
>>> On Thu, 3 Nov 2022 at 15:27, Qais Yousef <qyousef@layalina.io> wrote:
>>>>=20
>>>> On 11/03/22 09:46, Vincent Guittot wrote:
>>>>> On Tue, 1 Nov 2022 at 20:28, Qais Yousef <qyousef@layalina.io> wrote:
>>>>>>=20
>>>>>> On 10/28/22 11:34, Vincent Guittot wrote:
>>>>>>> Task can set its latency priority with sched_setattr(), which is the=
n used
>>>>>>> to set the latency offset of its sched_enity, but sched group entiti=
es
>>>>>>> still have the default latency offset value.
>>>>>>>=20
>>>>>>> Add a latency.nice field in cpu cgroup controller to set the latency=

>>>>>>> priority of the group similarly to sched_setattr(). The latency prio=
rity
>>>>>>> is then used to set the offset of the sched_entities of the group.
>>>>>>>=20
>>>>>>> Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
>>>>>>> ---
>>>>>>> Documentation/admin-guide/cgroup-v2.rst |  8 ++++
>>>>>>> kernel/sched/core.c                     | 52 +++++++++++++++++++++++=
++
>>>>>>> kernel/sched/fair.c                     | 33 ++++++++++++++++
>>>>>>> kernel/sched/sched.h                    |  4 ++
>>>>>>> 4 files changed, 97 insertions(+)
>>>>>>>=20
>>>>>>> diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation=
/admin-guide/cgroup-v2.rst
>>>>>>> index be4a77baf784..d8ae7e411f9c 100644
>>>>>>> --- a/Documentation/admin-guide/cgroup-v2.rst
>>>>>>> +++ b/Documentation/admin-guide/cgroup-v2.rst
>>>>>>> @@ -1095,6 +1095,14 @@ All time durations are in microseconds.
>>>>>>>         values similar to the sched_setattr(2). This maximum utiliza=
tion
>>>>>>>         value is used to clamp the task specific maximum utilization=
 clamp.
>>>>>>>=20
>>>>>>> +  cpu.latency.nice
>>>>>>> +     A read-write single value file which exists on non-root
>>>>>>> +     cgroups.  The default is "0".
>>>>>>> +
>>>>>>> +     The nice value is in the range [-20, 19].
>>>>>>> +
>>>>>>> +     This interface file allows reading and setting latency using t=
he
>>>>>>> +     same values used by sched_setattr(2).
>>>>>>=20
>>>>>> I'm still not sure about this [1].
>>>>>=20
>>>>> I'm still not sure about what you are trying to say here ...
>>>>>=20
>>>>> This is about setting a latency nice prio to a group level.
>>>>>=20
>>>>>>=20
>>>>>> In some scenarios we'd like to get the effective latency_nice of the t=
ask. How
>>>>>> will the task inherit the cgroup value or be impacted by it?
>>>>>>=20
>>>>>> For example if there are tasks that belong to a latency sensitive cgr=
oup; and
>>>>>> I'd like to skip some searches in EAS to improve that latency sensiti=
vity - how
>>>>>> would I extract this info in EAS path given these tasks are using def=
ault
>>>>>> latency_nice value? And if should happen if their latency_nice is set=
 to
>>>>>> something else other than default?
>>>>>>=20
>>>>>> [1] https://lore.kernel.org/lkml/20221012160734.hrkb5jcjdq7r23pr@wubu=
ntu/
>>>>>=20
>>>>> Hmm so you are speaking about something that is not part of the patch.=

>>>>> Let focus on the patchset for now
>>>>=20
>>>> I am focusing on this patchset. Isn't this an essential part of the des=
ign?
>>>> Once the interface is out we can't change it. As it stands, I can't see=
 how it
>>>=20
>>> So, are you speaking about the interface i.e. setting a value between [-=
20:19]
>>>=20
>>>> can be used to replace prefer_idle in cgroup as used in Android. I can'=
t see
>>>> how this could happen if we don't define how the task will inherit the c=
group
>>>> value. If we can, mind elaborating how please?
>>>=20
>>> Or how to take into account the value set for a cgroup ?
>>>=20
>>> Regarding the behavior, the rule remains the same that a sched_entity
>>> attached to a cgroup will not get more (latency in this case) than
>>> what has been set for the group entity.
>>=20
>> I think the interface solves a different problem which is latency of
>> task or cgroup wrt other group. Vincent, you are setting this for a
>> =E2=80=9Ctop app=E2=80=9D group in android in your tests, and seeing impr=
ovement
>> correct? AFAICS, this improvement comes because of lower latency
>=20
> Yes Top app and display group
>=20
>> during *same CPU* competition between different groups by juggling
>> around the wakeup-preemption window -- which maybe is good for
>> Android.
>>=20
>> OTOH, the =E2=80=9Cprefer idle=E2=80=9D flag in android that Qais is refe=
rring to,
>> will need a completely different method as I cannot see how a nice
>> value can communicate that (that can complement Vincent's changes
>> here). And it will need to have a per-task interface as well. We have
>=20
> Why a negative latency_nice value condition can't be used ? or latency -20=
  ?

Ah and forgot to reply about negative.

Maybe, but it=E2=80=99s still a horrible overload of the meaning of the valu=
e. I am not terribly against choosing negative value if there is consensus a=
mong everyone. Qais?

- Joel


>=20
>> something in ChromeOS as well, which is a proc knob and also
>> out-of-tree patch for that [1]. Without [1] we fail Android CTS
>> testing on a recent ARM64 ChromeOS device.
>> [1] https://chromium-review.googlesource.com/c/chromiumos/third_party/ker=
nel/+/3884575
>> The changelog in [1] also has a detailed description of the ChromeOS usec=
ase.
>>=20
>> Qais, any other reason you can see why Vincent's change will not be a
>> good thing for Android? Since you 1 CGroup for the whole user-facing
>> app (top app), you can just set that to a low "latency_nice" and get
>> better wake-up latency for that.
>>=20
>> (Side rant about latency and CFS -- IMHO a better long term solution
>> for lower latency is to use RT but don't throttle -- rather demote. Or
>> break CFS into multiple tiers, and apply demotion. This is in a way
>> what Vincent is doing, as the task becomes more CPU bound'ish, he's
>> taking away the latency boost. Vincent/Qais, somebody was working on
>> the RT demotion vs throttling a while back, any idea on the latest on
>> that?).
>>=20
>> thanks,
>>=20
>> - Joel
>>=20
>>=20
>>>=20
>>>>=20
>>>>=20
>>>> Thanks
>>>>=20
>>>> --
>>>> Qais Yousef
