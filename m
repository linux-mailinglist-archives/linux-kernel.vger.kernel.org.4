Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0242652C3C
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Dec 2022 06:03:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229591AbiLUFDI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Dec 2022 00:03:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbiLUFDD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Dec 2022 00:03:03 -0500
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 936021CB1A
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 21:03:00 -0800 (PST)
Received: by mail-qv1-xf30.google.com with SMTP id mn15so9624534qvb.13
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 21:03:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VwujNE44iVgoBOHodnRgRRanSX+Q9n1m4X8xH8g+7sM=;
        b=ap85Sybm93zsxVaMi8bpUlC8wEntx/SEma58OrHgtIrcDSqOXU4eEzxbaKx5ctrgjR
         trJxr7ikyZe7ZeHZAp2KJkE5kjJH5edzeDLHiQAWqxqBhH/DXwzrwZtkjCsKScIwXBXh
         B+jK5Ixm5ZucyHAS2BvtVpA0XyNLCZJAVzAW8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VwujNE44iVgoBOHodnRgRRanSX+Q9n1m4X8xH8g+7sM=;
        b=HGcFaMkjlVEV4qVC0iDiM0Coc0Pqk/el80bE9l+0FSNeWgald1IFCytkgyYCi4wfn8
         cjZgv+8D2joQoqP58r3d5mAAIPSs4LBRh+1dJ4dyYrvsbkoohskSRgDluoH79AeCp1A3
         z8YUkaX4I5msy+v/qt9rl7HTxRtHNnKyWawBNlgKyf8MqJPcvIvniuybx8t2cMA8JHsw
         X7+i5QaD1t6RMrUmVIfv6zsSOeiZBT80QFJVHM8IDVan1P5KGneeHZq/723t7QfduAMi
         nZ7ZFBrEoIO0rKrvtMxfoeiV+4XH9dS7A0e3TrkrDcHY7yizdOQSwbvvrlnLNHR5wxfF
         kzlA==
X-Gm-Message-State: AFqh2koEzDB0nlg4oyr7QGQk+MOOABdpuVWdb04nA1bXnUUfrqijnfN7
        jjf6oUqKO/P0A4WMGvT6Q4spIg==
X-Google-Smtp-Source: AMrXdXuSLNHKjeBWuGm1h5b1to192LogWAy1QpRlpAQxP5nonBRhmpywfufNttvQjpwpmSR9bHU6Xg==
X-Received: by 2002:a0c:ea51:0:b0:51a:a201:5619 with SMTP id u17-20020a0cea51000000b0051aa2015619mr747057qvp.13.1671598979604;
        Tue, 20 Dec 2022 21:02:59 -0800 (PST)
Received: from smtpclient.apple (c-98-249-43-138.hsd1.va.comcast.net. [98.249.43.138])
        by smtp.gmail.com with ESMTPSA id bm32-20020a05620a19a000b0070209239b87sm10119612qkb.41.2022.12.20.21.02.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Dec 2022 21:02:58 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Joel Fernandes <joel@joelfernandes.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [RFC 0/2] srcu: Remove pre-flip memory barrier
Date:   Wed, 21 Dec 2022 00:02:48 -0500
Message-Id: <969CAAB7-5CBE-45F4-AE12-93E51D13F146@joelfernandes.org>
References: <d010a8ca-79a4-bd25-dff1-cb7dee627365@efficios.com>
Cc:     Neeraj Upadhyay <neeraj.iitr10@gmail.com>,
        linux-kernel@vger.kernel.org,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>
In-Reply-To: <d010a8ca-79a4-bd25-dff1-cb7dee627365@efficios.com>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
X-Mailer: iPhone Mail (20B101)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Dec 20, 2022, at 10:51 PM, Mathieu Desnoyers <mathieu.desnoyers@efficio=
s.com> wrote:
>=20
> =EF=BB=BFOn 2022-12-20 15:55, Joel Fernandes wrote:
>>>> On Dec 20, 2022, at 1:29 PM, Joel Fernandes <joel@joelfernandes.org> wr=
ote:
>>>=20
>>> =EF=BB=BF
>>>=20
>>>>> On Dec 20, 2022, at 1:13 PM, Mathieu Desnoyers <mathieu.desnoyers@effi=
cios.com> wrote:
>>>>>=20
>>>>> =EF=BB=BFOn 2022-12-20 13:05, Joel Fernandes wrote:
>>>>> Hi Mathieu,
>>>>>> On Tue, Dec 20, 2022 at 5:00 PM Mathieu Desnoyers
>>>>>> <mathieu.desnoyers@efficios.com> wrote:
>>>>>>=20
>>>>>> On 2022-12-19 20:04, Joel Fernandes wrote:
>>>>>>>> On Mon, Dec 19, 2022 at 7:55 PM Joel Fernandes <joel@joelfernandes.=
org> wrote:
>>>>> [...]
>>>>>>>>> On a 64-bit system, where 64-bit counters are used, AFAIU this nee=
d to
>>>>>>>>> be exactly 2^64 read-side critical sections.
>>>>>>>>=20
>>>>>>>> Yes, but what about 32-bit systems?
>>>>>>=20
>>>>>> The overflow indeed happens after 2^32 increments, just like seqlock.=

>>>>>> The question we need to ask is therefore: if 2^32 is good enough for
>>>>>> seqlock, why isn't it good enough for SRCU ?
>>>>> I think Paul said wrap around does happen with SRCU on 32-bit but I'll=

>>>>> let him talk more about it. If 32-bit is good enough, let us also drop=

>>>>> the size of the counters for 64-bit then?
>>>>>>>>> There are other synchronization algorithms such as seqlocks which a=
re
>>>>>>>>> quite happy with much less protection against overflow (using a 32=
-bit
>>>>>>>>> counter even on 64-bit architectures).
>>>>>>>>=20
>>>>>>>> The seqlock is an interesting point.
>>>>>>>>=20
>>>>>>>>> For practical purposes, I suspect this issue is really just theore=
tical.
>>>>>>>>=20
>>>>>>>> I have to ask, what is the benefit of avoiding a flip and scanning
>>>>>>>> active readers? Is the issue about grace period delay or performanc=
e?
>>>>>>>> If so, it might be worth prototyping that approach and measuring us=
ing
>>>>>>>> rcutorture/rcuscale. If there is significant benefit to current
>>>>>>>> approach, then IMO it is worth exploring.
>>>>>>=20
>>>>>> The main benefit I expect is improved performance of the grace period=

>>>>>> implementation in common cases where there are few or no readers
>>>>>> present, especially on machines with many cpus.
>>>>>>=20
>>>>>> It allows scanning both periods (0/1) for each cpu within the same pa=
ss,
>>>>>> therefore loading both period's unlock counters sitting in the same
>>>>>> cache line at once (improved locality), and then loading both period'=
s
>>>>>> lock counters, also sitting in the same cache line.
>>>>>>=20
>>>>>> It also allows skipping the period flip entirely if there are no read=
ers
>>>>>> present, which is an -arguably- tiny performance improvement as well.=

>>>>> The issue of counter wrap aside, what if a new reader always shows up
>>>>> in the active index being scanned, then can you not delay the GP
>>>>> indefinitely? It seems like writer-starvation is possible then (sure
>>>>> it is possible also with preemption after reader-index-sampling, but
>>>>> scanning active index deliberately will make that worse). Seqlock does=

>>>>> not have such writer starvation just because the writer does not care
>>>>> about what the readers are doing.
>>>>=20
>>>> No, it's not possible for "current index" readers to starve the g.p. wi=
th the side-rcu scheme, because the initial pass (sampling both periods) onl=
y opportunistically skips flipping the period if there happens to be no read=
ers in both periods.
>>>>=20
>>>> If there are readers in the "non-current" period, the grace period wait=
s for them.
>>>>=20
>>>> If there are readers in the "current" period, it flips the period and t=
hen waits for them.
>>>=20
>>> Ok glad you already do that, this is what I was sort of leaning at in my=
 previous email as well, that is doing a hybrid approach. Sorry I did not kn=
ow the details of your side-RCU to know you were already doing something lik=
e that.
>>>=20
>>>>=20
>>>>> That said, the approach of scanning both counters does seem attractive=

>>>>> for when there are no readers, for the reasons you mentioned. Maybe a
>>>>> heuristic to count the number of readers might help? If we are not
>>>>> reader-heavy, then scan both. Otherwise, just scan the inactive ones,
>>>>> and also couple that heuristic with the number of CPUs. I am
>>>>> interested in working on such a design with you! Let us do it and
>>>>> prototype/measure. ;-)
>>>>=20
>>>> Considering that it would add extra complexity, I'm unsure what that ex=
tra heuristic would improve over just scanning both periods in the first pas=
s.
>>>=20
>>> Makes sense, I think you indirectly implement a form of heuristic alread=
y by flipping in case scanning both was not fruitful.
>>>=20
>>>> I'll be happy to work with you on such a design :) I think we can borro=
w quite a few concepts from side-rcu for this. Please be aware that my time i=
s limited though, as I'm currently supposed to be on vacation. :)
>>>=20
>>> Oh, I was more referring to after the holidays. I am also starting vacat=
ion soon and limited In cycles ;-). It is probably better to enjoy the holid=
ays and come back to this after.
>>>=20
>>> I do want to finish my memory barrier studies of SRCU over the holidays s=
ince I have been deep in the hole with that already. Back to the post flip m=
emory barrier here since I think now even that might not be needed=E2=80=A6
>> In my view,  the mb between the totaling of unlocks and totaling of locks=
 serves as the mb that is required to enforce the GP guarantee, which I thin=
k is what Mathieu is referring to.
>=20
> No, AFAIU you also need barriers at the beginning and end of synchronize_s=
rcu to provide those guarantees:

My bad, I got too hung up on the scan code. Indeed we need additional orderi=
ng on synchronize side.

Anyway, the full memory barriers are already implemented in the synchronize c=
ode AFAICS (beginning and end). At least one of them full memory barriers di=
rectly appears at the end of __synchronize_srcu(). But I dont want to say so=
mething stupid in the middle of the night, so I will take my time to get bac=
k on that.

Thanks,

Joel


>=20
> * There are memory-ordering constraints implied by synchronize_srcu().
>=20
> Need for a barrier at the end of synchronize_srcu():
>=20
> * On systems with more than one CPU, when synchronize_srcu() returns,
> * each CPU is guaranteed to have executed a full memory barrier since
> * the end of its last corresponding SRCU read-side critical section
> * whose beginning preceded the call to synchronize_srcu().
>=20
> Need for a barrier at the beginning of synchronize_srcu():
>=20
> * In addition,
> * each CPU having an SRCU read-side critical section that extends beyond
> * the return from synchronize_srcu() is guaranteed to have executed a
> * full memory barrier after the beginning of synchronize_srcu() and before=

> * the beginning of that SRCU read-side critical section.  Note that these
> * guarantees include CPUs that are offline, idle, or executing in user mod=
e,
> * as well as CPUs that are executing in the kernel.
>=20
> Thanks,
>=20
> Mathieu
>=20
>> Neeraj, do you agree?
>> Thanks.
>>>=20
>>> Cheers,
>>>=20
>>> - Joel
>>>=20
>>>=20
>>>>=20
>>>> Thanks,
>>>>=20
>>>> Mathieu
>>>>=20
>>>> --=20
>>>> Mathieu Desnoyers
>>>> EfficiOS Inc.
>>>> https://www.efficios.com
>>>>=20
>=20
> --=20
> Mathieu Desnoyers
> EfficiOS Inc.
> https://www.efficios.com
>=20
