Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E86B8652814
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 21:56:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234116AbiLTU4E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 15:56:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229677AbiLTU4A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 15:56:00 -0500
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9F592DEE
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 12:55:58 -0800 (PST)
Received: by mail-qt1-x829.google.com with SMTP id h26so8299470qtu.2
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 12:55:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hiSQNEY4B0E+BbOauF0x9FLaWdH7A6Ones+1uirtexk=;
        b=x51ozonbovYCE61g4LkC7KPUy7SQFSxSulduQHM4MchkRAhZdgHNusCshH8SZl/eXC
         L2Pa1e7iQZRvwhkVBwyym2HjfeoNyl81NQvMY2khq6SLkBUuoSW1KHt8R1xjd6buUNbx
         TWqc7jb6tIw66PBDuYcA40V0lz8SF+oQzHsjk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hiSQNEY4B0E+BbOauF0x9FLaWdH7A6Ones+1uirtexk=;
        b=N84wD087FZd39ThDo9SqMRC+I/b+DSG/hzIwjUdaRyO3BL20BT7uuTnj1AF9z8mR1d
         EsGwU3+JYugBLaeG9MXnhPdipXwUZZXqisvLmS4OIx0NR8Ohw8Ws/ecVECZ11tQAr+ES
         UU7lqiyg2h0ubeP9igBzYX8Ih4CWMOl9bbOoCj2mmFPlsgmZH5TyJgG3dOM6dC+rfUqk
         mZnHek2OX/vomxZJqL/Tioz+W0629bdLFVWVGTRs7LAK5mtBZ7pp1XiYBSl67mVT8u/t
         4WfQyahaEmCCqtHg7gxhedz8+YRspUNCse3gK3hVzWEyVLR6wPHNnhCJAmUl9a53Sotq
         v5VQ==
X-Gm-Message-State: ANoB5plkWhULL66TCMIwmxogaCxosGF9CAgtJXRLSGlQUWCDxGCBhZhT
        xG0j65csAkrBmcGfcq7kXp7ejw==
X-Google-Smtp-Source: AA0mqf4PrNxbCahlBgMO7IeE4e0+Q6ArFuKWWvdh/mieSYcxI2M6BKnPlTcxP19v7GEhY+GjemwMTQ==
X-Received: by 2002:ac8:6988:0:b0:3a5:2644:bcd2 with SMTP id o8-20020ac86988000000b003a52644bcd2mr56646469qtq.8.1671569757713;
        Tue, 20 Dec 2022 12:55:57 -0800 (PST)
Received: from smtpclient.apple (c-98-249-43-138.hsd1.va.comcast.net. [98.249.43.138])
        by smtp.gmail.com with ESMTPSA id w7-20020ac843c7000000b003a8163c1c96sm8012953qtn.14.2022.12.20.12.55.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Dec 2022 12:55:56 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Joel Fernandes <joel@joelfernandes.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [RFC 0/2] srcu: Remove pre-flip memory barrier
Date:   Tue, 20 Dec 2022 15:55:45 -0500
Message-Id: <B9B73CDE-4C2C-4BC6-A23C-A59C22AD2EB1@joelfernandes.org>
References: <7A9876BA-C375-42A7-A5C9-FD940D2898D7@joelfernandes.org>
Cc:     linux-kernel@vger.kernel.org,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>
In-Reply-To: <7A9876BA-C375-42A7-A5C9-FD940D2898D7@joelfernandes.org>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Neeraj Upadhyay <neeraj.iitr10@gmail.com>
X-Mailer: iPhone Mail (20B101)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Dec 20, 2022, at 1:29 PM, Joel Fernandes <joel@joelfernandes.org> wrote=
:
>=20
> =EF=BB=BF
>=20
>>> On Dec 20, 2022, at 1:13 PM, Mathieu Desnoyers <mathieu.desnoyers@effici=
os.com> wrote:
>>>=20
>>> =EF=BB=BFOn 2022-12-20 13:05, Joel Fernandes wrote:
>>> Hi Mathieu,
>>>> On Tue, Dec 20, 2022 at 5:00 PM Mathieu Desnoyers
>>>> <mathieu.desnoyers@efficios.com> wrote:
>>>>=20
>>>> On 2022-12-19 20:04, Joel Fernandes wrote:
>>>>>> On Mon, Dec 19, 2022 at 7:55 PM Joel Fernandes <joel@joelfernandes.or=
g> wrote:
>>> [...]
>>>>>>> On a 64-bit system, where 64-bit counters are used, AFAIU this need t=
o
>>>>>>> be exactly 2^64 read-side critical sections.
>>>>>>=20
>>>>>> Yes, but what about 32-bit systems?
>>>>=20
>>>> The overflow indeed happens after 2^32 increments, just like seqlock.
>>>> The question we need to ask is therefore: if 2^32 is good enough for
>>>> seqlock, why isn't it good enough for SRCU ?
>>> I think Paul said wrap around does happen with SRCU on 32-bit but I'll
>>> let him talk more about it. If 32-bit is good enough, let us also drop
>>> the size of the counters for 64-bit then?
>>>>>>> There are other synchronization algorithms such as seqlocks which ar=
e
>>>>>>> quite happy with much less protection against overflow (using a 32-b=
it
>>>>>>> counter even on 64-bit architectures).
>>>>>>=20
>>>>>> The seqlock is an interesting point.
>>>>>>=20
>>>>>>> For practical purposes, I suspect this issue is really just theoreti=
cal.
>>>>>>=20
>>>>>> I have to ask, what is the benefit of avoiding a flip and scanning
>>>>>> active readers? Is the issue about grace period delay or performance?=

>>>>>> If so, it might be worth prototyping that approach and measuring usin=
g
>>>>>> rcutorture/rcuscale. If there is significant benefit to current
>>>>>> approach, then IMO it is worth exploring.
>>>>=20
>>>> The main benefit I expect is improved performance of the grace period
>>>> implementation in common cases where there are few or no readers
>>>> present, especially on machines with many cpus.
>>>>=20
>>>> It allows scanning both periods (0/1) for each cpu within the same pass=
,
>>>> therefore loading both period's unlock counters sitting in the same
>>>> cache line at once (improved locality), and then loading both period's
>>>> lock counters, also sitting in the same cache line.
>>>>=20
>>>> It also allows skipping the period flip entirely if there are no reader=
s
>>>> present, which is an -arguably- tiny performance improvement as well.
>>> The issue of counter wrap aside, what if a new reader always shows up
>>> in the active index being scanned, then can you not delay the GP
>>> indefinitely? It seems like writer-starvation is possible then (sure
>>> it is possible also with preemption after reader-index-sampling, but
>>> scanning active index deliberately will make that worse). Seqlock does
>>> not have such writer starvation just because the writer does not care
>>> about what the readers are doing.
>>=20
>> No, it's not possible for "current index" readers to starve the g.p. with=
 the side-rcu scheme, because the initial pass (sampling both periods) only o=
pportunistically skips flipping the period if there happens to be no readers=
 in both periods.
>>=20
>> If there are readers in the "non-current" period, the grace period waits f=
or them.
>>=20
>> If there are readers in the "current" period, it flips the period and the=
n waits for them.
>=20
> Ok glad you already do that, this is what I was sort of leaning at in my p=
revious email as well, that is doing a hybrid approach. Sorry I did not know=
 the details of your side-RCU to know you were already doing something like t=
hat.
>=20
>>=20
>>> That said, the approach of scanning both counters does seem attractive
>>> for when there are no readers, for the reasons you mentioned. Maybe a
>>> heuristic to count the number of readers might help? If we are not
>>> reader-heavy, then scan both. Otherwise, just scan the inactive ones,
>>> and also couple that heuristic with the number of CPUs. I am
>>> interested in working on such a design with you! Let us do it and
>>> prototype/measure. ;-)
>>=20
>> Considering that it would add extra complexity, I'm unsure what that extr=
a heuristic would improve over just scanning both periods in the first pass.=

>=20
> Makes sense, I think you indirectly implement a form of heuristic already b=
y flipping in case scanning both was not fruitful.
>=20
>> I'll be happy to work with you on such a design :) I think we can borrow q=
uite a few concepts from side-rcu for this. Please be aware that my time is l=
imited though, as I'm currently supposed to be on vacation. :)
>=20
> Oh, I was more referring to after the holidays. I am also starting vacatio=
n soon and limited In cycles ;-). It is probably better to enjoy the holiday=
s and come back to this after.
>=20
> I do want to finish my memory barrier studies of SRCU over the holidays si=
nce I have been deep in the hole with that already. Back to the post flip me=
mory barrier here since I think now even that might not be needed=E2=80=A6

In my view,  the mb between the totaling of unlocks and totaling of locks se=
rves as the mb that is required to enforce the GP guarantee, which I think i=
s what Mathieu is referring to.

Neeraj, do you agree?

Thanks.





>=20
> Cheers,
>=20
> - Joel
>=20
>=20
>>=20
>> Thanks,
>>=20
>> Mathieu
>>=20
>> --=20
>> Mathieu Desnoyers
>> EfficiOS Inc.
>> https://www.efficios.com
>>=20
