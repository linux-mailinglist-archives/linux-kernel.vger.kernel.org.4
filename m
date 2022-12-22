Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AC8F654639
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 19:56:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235379AbiLVS4f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 13:56:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229984AbiLVS4b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 13:56:31 -0500
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 288515FD0
        for <linux-kernel@vger.kernel.org>; Thu, 22 Dec 2022 10:56:30 -0800 (PST)
Received: by mail-qt1-x829.google.com with SMTP id bq12so2074834qtb.3
        for <linux-kernel@vger.kernel.org>; Thu, 22 Dec 2022 10:56:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AyzbZhj/sevqH9K1VabpvvJ0X5bM1/62pGgsjeAJLZU=;
        b=PA1HkvImMApo2F0Vn69Qf84j8Edaj3TyuyoWz/DwzLFjcu0aCNEBG8Y2f4uVE8LGID
         QKt420WVs5iGg8it8E6eSOnltPg82WYqjMnAkx6dRHmSU8NHSDOBeENCYh1dnKa6kz04
         rDJGjWQkXQsxjJfpmvLEKGM4en1jDabnPpFAE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AyzbZhj/sevqH9K1VabpvvJ0X5bM1/62pGgsjeAJLZU=;
        b=I6/zXA+PFSMgXescCXlMlgz/Hs6wTrSaEQU1MViQ7EFF9z+Uq+lF17smVRxXLgl91r
         O+gUk8LxmaQUn1Ki6ENyTt/TN3H7qCrDf0WvuvqElpNdg58ZU+M0AgTxaiQ3BTMuybUl
         O5WUN8NGlt1/0bFgFvBlnZbTaZ6SQ08aaqCXu4zCZMJjSvHfU/Rl1Eb5kUq6/9KjwlUI
         KAm8XuNokLN5/M61d8R//ETOnvKNxmakJKNLfN2qTWo6skI0B8wGWh7eEQmjWbEe448V
         /xPfHACQ+gUN6XVZ0PBZ7omuZw111rqb5KEiUXiWo7s0UWgBjUgAfTGmQBokxmsfXWTT
         4ONA==
X-Gm-Message-State: AFqh2kowV5wdG/8jKHheYxsT4B+IfdWobKpuK2omBQFkLsAL07ZpnzvU
        5EMrefZXgcO5p0gYrqOcYuZmvA==
X-Google-Smtp-Source: AMrXdXuHzBuiZ7RDHxoenXy5PQuevThXaYcF6dNW8Mqfgcztor0xXbrHKQm/O1LoK4aIYZwl+VUT0g==
X-Received: by 2002:ac8:524c:0:b0:3a9:7dd5:6a33 with SMTP id y12-20020ac8524c000000b003a97dd56a33mr15681340qtn.64.1671735389189;
        Thu, 22 Dec 2022 10:56:29 -0800 (PST)
Received: from smtpclient.apple (c-98-249-43-138.hsd1.va.comcast.net. [98.249.43.138])
        by smtp.gmail.com with ESMTPSA id z24-20020ac87118000000b0039cc0fbdb61sm743454qto.53.2022.12.22.10.56.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Dec 2022 10:56:28 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Joel Fernandes <joel@joelfernandes.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [RFC 0/2] srcu: Remove pre-flip memory barrier
Date:   Thu, 22 Dec 2022 13:56:17 -0500
Message-Id: <F492F726-00AA-4FC8-A5E5-BBF006CE946C@joelfernandes.org>
References: <20221222185314.GR4001@paulmck-ThinkPad-P17-Gen-1>
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        linux-kernel@vger.kernel.org,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>, rcu@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>
In-Reply-To: <20221222185314.GR4001@paulmck-ThinkPad-P17-Gen-1>
To:     paulmck@kernel.org
X-Mailer: iPhone Mail (20B101)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Dec 22, 2022, at 1:53 PM, Paul E. McKenney <paulmck@kernel.org> wrote:
>=20
> =EF=BB=BFOn Thu, Dec 22, 2022 at 01:19:06PM -0500, Joel Fernandes wrote:
>>=20
>>=20
>>>> On Dec 22, 2022, at 11:43 AM, Paul E. McKenney <paulmck@kernel.org> wro=
te:
>>>=20
>>> =EF=BB=BFOn Thu, Dec 22, 2022 at 01:40:10PM +0100, Frederic Weisbecker w=
rote:
>>>>> On Wed, Dec 21, 2022 at 12:11:42PM -0500, Mathieu Desnoyers wrote:
>>>>> On 2022-12-21 06:59, Frederic Weisbecker wrote:
>>>>>>> On Tue, Dec 20, 2022 at 10:34:19PM -0500, Mathieu Desnoyers wrote:
>>>>> [...]
>>>>>>>=20
>>>>>>> The memory ordering constraint I am concerned about here is:
>>>>>>>=20
>>>>>>> * [...] In addition,
>>>>>>> * each CPU having an SRCU read-side critical section that extends be=
yond
>>>>>>> * the return from synchronize_srcu() is guaranteed to have executed a=

>>>>>>> * full memory barrier after the beginning of synchronize_srcu() and b=
efore
>>>>>>> * the beginning of that SRCU read-side critical section. [...]
>>>>>>>=20
>>>>>>> So if we have a SRCU read-side critical section that begins after th=
e beginning
>>>>>>> of synchronize_srcu, but before its first memory barrier, it would m=
iss the
>>>>>>> guarantee that the full memory barrier is issued before the beginnin=
g of that
>>>>>>> SRCU read-side critical section. IOW, that memory barrier needs to b=
e at the
>>>>>>> very beginning of the grace period.
>>>>>>=20
>>>>>> I'm confused, what's wrong with this ?
>>>>>>=20
>>>>>> UPDATER                  READER
>>>>>> -------                  ------
>>>>>> STORE X =3D 1              STORE srcu_read_lock++
>>>>>> // rcu_seq_snap()        smp_mb()
>>>>>> smp_mb()                 READ X
>>>>>> // scans
>>>>>> READ srcu_read_lock
>>>>>=20
>>>>> What you refer to here is only memory ordering of the store to X and l=
oad
>>>>> from X wrt loading/increment of srcu_read_lock, which is internal to t=
he
>>>>> srcu implementation. If we really want to model the provided high-leve=
l
>>>>> memory ordering guarantees, we should consider a scenario where SRCU i=
s used
>>>>> for its memory ordering properties to synchronize other variables.
>>>>>=20
>>>>> I'm concerned about the following Dekker scenario, where synchronize_s=
rcu()
>>>>> and srcu_read_lock/unlock would be used instead of memory barriers:
>>>>>=20
>>>>> Initial state: X =3D 0, Y =3D 0
>>>>>=20
>>>>> Thread A                   Thread B
>>>>> ---------------------------------------------
>>>>> STORE X =3D 1                STORE Y =3D 1
>>>>> synchronize_srcu()
>>>>>                          srcu_read_lock()
>>>>>                          r1 =3D LOAD X
>>>>>                          srcu_read_unlock()
>>>>> r0 =3D LOAD Y
>>>>>=20
>>>>> BUG_ON(!r0 && !r1)
>>>>>=20
>>>>> So in the synchronize_srcu implementation, there appears to be two
>>>>> major scenarios: either srcu_gp_start_if_needed starts a gp or expedit=
ed gp,
>>>>> or it uses an already started gp/expedited gp. When snapshotting with
>>>>> rcu_seq_snap, the fact that the memory barrier is after the ssp->srcu_=
gp_seq
>>>>> load means that it does not order prior memory accesses before that lo=
ad.
>>>>> This sequence value is then used to identify which gp_seq to wait for w=
hen
>>>>> piggy-backing on another already-started gp. I worry about reordering
>>>>> between STORE X =3D 1 and load of ssp->srcu_gp_seq, which is then used=
 to
>>>>> piggy-back on an already-started gp.
>>>>>=20
>>>>> I suspect that the implicit barrier in srcu_read_lock() invoked at the=

>>>>> beginning of srcu_gp_start_if_needed() is really the barrier that make=
s
>>>>> all this behave as expected. But without documentation it's rather har=
d to
>>>>> follow.
>>>>=20
>>>> Oh ok I see now. It might be working that way by accident or on forgott=
en
>>>> purpose. In any case, we really want to add a comment above that
>>>> __srcu_read_lock_nmisafe() call.
>>>=20
>>> Another test for the safety (or not) of removing either D or E is
>>> to move that WRITE_ONCE() to follow (or, respectively, precede) the
>>> adjacent scans.
>>=20
>> Good idea, though I believe the MBs that the above talk about are not the=
 flip ones. They are the ones in synchronize_srcu() beginning and end, that o=
rder with respect to grace period start and end.
>>=20
>> So that (flipping MBs) is unrelated, or did I miss something?
>=20
> The thought is to manually similate in the source code the maximum
> memory-reference reordering that a maximally hostile compiler and CPU
> would be permitted to carry out.  So yes, given that there are other
> memory barriers before and after, these other memory barriers limit how
> far the flip may be moved in the source code.
>=20
> Here I am talking about the memory barriers associated with the flip,
> but the same trick can of course be applied to other memory barriers.
> In general, remove a given memory barrier and (in the source code)
> maximally rearrange the memory references that were previously ordered
> by the memory barrier in question.
>=20
> Again, the presence of other memory barriers will limit the permitted
> maximal source-code rearrangement.


Makes sense if the memory barrier is explicit. In this case, the memory barr=
iers are implicit apparently, with a srcu_read_lock() in the beginning of sy=
nchronize_rcu() having the implicit / indirect memory barrier. So I am not s=
ure if that can be implemented without breaking SRCU readers.

Thanks.




>=20
>                            Thanx, Paul
