Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FBF5652643
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 19:30:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233609AbiLTSaH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 13:30:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234078AbiLTS3e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 13:29:34 -0500
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 237921DDE8
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 10:29:15 -0800 (PST)
Received: by mail-qt1-x834.google.com with SMTP id c7so11723510qtw.8
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 10:29:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6yCocTDB5OSH/VtzLqUHfG/j1w+keIibLqLTgN0O3gw=;
        b=Jkb7RoZ+masMOXh4BqDrbPZhrwRljZIc3cafe3E+WwrFLcE17xM3H0N8GO0PmETJ3T
         KqR2feNrKMtvyE8yPS9K+rUfbO8t2VJcZUBfpb6jf+D6WKex8WHgiXpTtH6J4hZ2h0Nq
         QFfRE/si6bAcHiprPo66AI+cTBGsco23slPyc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6yCocTDB5OSH/VtzLqUHfG/j1w+keIibLqLTgN0O3gw=;
        b=5K7ZqO2vgzNdPgnhsP+Im4r+eRdM9oMOx43aHdCSQ+rtrQHwM+wOdowM//q8FYQuTc
         VlDwreP7BJ6a/wTYcSGjo0P0wjEQKZZVBmQGsyK69w71TZ18vRVOHkfvaZsOT+QM3IPW
         v/zj5L7cRV8cij4DKI4LT0q8UhYH6hcrjn7LY82WhdnQBcYfE4Jxh0rsZ6BLwzm88x64
         yzWSzqD31y6/Kw+A5f0/rg4eH9wnrHzBP+LD52Zm7GVK1i3L91Rv1FXDMIDPB029cdbK
         z8AFWDXw130W1VzOAAJBZJZCVB3vfewzZsCQf9VzagfQkK15dTqU/1Lznabtq+W4Gbj+
         +vOA==
X-Gm-Message-State: AFqh2kpJLn9xoP7K7HzLT1yRzHGIbMVrWbJM/Fz8qc3Tv94UTijVDnWB
        9HV+orzBCQ2wL6ALxKpHDfqrNA==
X-Google-Smtp-Source: AMrXdXs+utOBIwdTwZG5tOjC4V8vEXIM3T75bMBoG7T+4+pGey9KurF+rsWOqYfmpPpDHdM+Omhu+g==
X-Received: by 2002:ac8:140e:0:b0:3ab:5bb4:ae6d with SMTP id k14-20020ac8140e000000b003ab5bb4ae6dmr2130380qtj.43.1671560954153;
        Tue, 20 Dec 2022 10:29:14 -0800 (PST)
Received: from smtpclient.apple (c-98-249-43-138.hsd1.va.comcast.net. [98.249.43.138])
        by smtp.gmail.com with ESMTPSA id z26-20020ac8711a000000b003a816011d51sm7918404qto.38.2022.12.20.10.29.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Dec 2022 10:29:13 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Joel Fernandes <joel@joelfernandes.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [RFC 0/2] srcu: Remove pre-flip memory barrier
Date:   Tue, 20 Dec 2022 13:29:02 -0500
Message-Id: <7A9876BA-C375-42A7-A5C9-FD940D2898D7@joelfernandes.org>
References: <6438d903-ab97-48c7-c338-9f0bc2686f94@efficios.com>
Cc:     linux-kernel@vger.kernel.org,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>
In-Reply-To: <6438d903-ab97-48c7-c338-9f0bc2686f94@efficios.com>
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



> On Dec 20, 2022, at 1:13 PM, Mathieu Desnoyers <mathieu.desnoyers@efficios=
.com> wrote:
>=20
> =EF=BB=BFOn 2022-12-20 13:05, Joel Fernandes wrote:
>> Hi Mathieu,
>>> On Tue, Dec 20, 2022 at 5:00 PM Mathieu Desnoyers
>>> <mathieu.desnoyers@efficios.com> wrote:
>>>=20
>>> On 2022-12-19 20:04, Joel Fernandes wrote:
>>>> On Mon, Dec 19, 2022 at 7:55 PM Joel Fernandes <joel@joelfernandes.org>=
 wrote:
>> [...]
>>>>>> On a 64-bit system, where 64-bit counters are used, AFAIU this need t=
o
>>>>>> be exactly 2^64 read-side critical sections.
>>>>>=20
>>>>> Yes, but what about 32-bit systems?
>>>=20
>>> The overflow indeed happens after 2^32 increments, just like seqlock.
>>> The question we need to ask is therefore: if 2^32 is good enough for
>>> seqlock, why isn't it good enough for SRCU ?
>> I think Paul said wrap around does happen with SRCU on 32-bit but I'll
>> let him talk more about it. If 32-bit is good enough, let us also drop
>> the size of the counters for 64-bit then?
>>>>>> There are other synchronization algorithms such as seqlocks which are=

>>>>>> quite happy with much less protection against overflow (using a 32-bi=
t
>>>>>> counter even on 64-bit architectures).
>>>>>=20
>>>>> The seqlock is an interesting point.
>>>>>=20
>>>>>> For practical purposes, I suspect this issue is really just theoretic=
al.
>>>>>=20
>>>>> I have to ask, what is the benefit of avoiding a flip and scanning
>>>>> active readers? Is the issue about grace period delay or performance?
>>>>> If so, it might be worth prototyping that approach and measuring using=

>>>>> rcutorture/rcuscale. If there is significant benefit to current
>>>>> approach, then IMO it is worth exploring.
>>>=20
>>> The main benefit I expect is improved performance of the grace period
>>> implementation in common cases where there are few or no readers
>>> present, especially on machines with many cpus.
>>>=20
>>> It allows scanning both periods (0/1) for each cpu within the same pass,=

>>> therefore loading both period's unlock counters sitting in the same
>>> cache line at once (improved locality), and then loading both period's
>>> lock counters, also sitting in the same cache line.
>>>=20
>>> It also allows skipping the period flip entirely if there are no readers=

>>> present, which is an -arguably- tiny performance improvement as well.
>> The issue of counter wrap aside, what if a new reader always shows up
>> in the active index being scanned, then can you not delay the GP
>> indefinitely? It seems like writer-starvation is possible then (sure
>> it is possible also with preemption after reader-index-sampling, but
>> scanning active index deliberately will make that worse). Seqlock does
>> not have such writer starvation just because the writer does not care
>> about what the readers are doing.
>=20
> No, it's not possible for "current index" readers to starve the g.p. with t=
he side-rcu scheme, because the initial pass (sampling both periods) only op=
portunistically skips flipping the period if there happens to be no readers i=
n both periods.
>=20
> If there are readers in the "non-current" period, the grace period waits f=
or them.
>=20
> If there are readers in the "current" period, it flips the period and then=
 waits for them.

Ok glad you already do that, this is what I was sort of leaning at in my pre=
vious email as well, that is doing a hybrid approach. Sorry I did not know t=
he details of your side-RCU to know you were already doing something like th=
at.

>=20
>> That said, the approach of scanning both counters does seem attractive
>> for when there are no readers, for the reasons you mentioned. Maybe a
>> heuristic to count the number of readers might help? If we are not
>> reader-heavy, then scan both. Otherwise, just scan the inactive ones,
>> and also couple that heuristic with the number of CPUs. I am
>> interested in working on such a design with you! Let us do it and
>> prototype/measure. ;-)
>=20
> Considering that it would add extra complexity, I'm unsure what that extra=
 heuristic would improve over just scanning both periods in the first pass.

Makes sense, I think you indirectly implement a form of heuristic already by=
 flipping in case scanning both was not fruitful.

> I'll be happy to work with you on such a design :) I think we can borrow q=
uite a few concepts from side-rcu for this. Please be aware that my time is l=
imited though, as I'm currently supposed to be on vacation. :)

Oh, I was more referring to after the holidays. I am also starting vacation s=
oon and limited In cycles ;-). It is probably better to enjoy the holidays a=
nd come back to this after.

I do want to finish my memory barrier studies of SRCU over the holidays sinc=
e I have been deep in the hole with that already. Back to the post flip memo=
ry barrier here since I think now even that might not be needed=E2=80=A6

Cheers,

 - Joel


>=20
> Thanks,
>=20
> Mathieu
>=20
> --=20
> Mathieu Desnoyers
> EfficiOS Inc.
> https://www.efficios.com
>=20
