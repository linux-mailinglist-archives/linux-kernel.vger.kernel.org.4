Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 057C96545E9
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 19:19:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231454AbiLVSTV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 13:19:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230357AbiLVSTU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 13:19:20 -0500
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A74E113B
        for <linux-kernel@vger.kernel.org>; Thu, 22 Dec 2022 10:19:19 -0800 (PST)
Received: by mail-qt1-x830.google.com with SMTP id c11so1953200qtn.11
        for <linux-kernel@vger.kernel.org>; Thu, 22 Dec 2022 10:19:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:from:to:cc:subject:date:message-id
         :reply-to;
        bh=izSwWPJ6y3lH+EuzVUHTuzemZUg/0p3iz1ZnqBmNFPM=;
        b=GpVLjzXsRu45a4gBSDavXvutE25nTliJ4P2mtVxJkep7KehSEiSWGfSjbQmQnw+Yej
         bnUa+iGpSkotXgVj4fGHQTpK37ZKEW+zuBVepi+0zPwVcvLxtjt0SaUBlk7PRkyfYCuN
         cMg8BNFNGjB/UrSx4mt1I5m4KtU33+KrkkTvI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=izSwWPJ6y3lH+EuzVUHTuzemZUg/0p3iz1ZnqBmNFPM=;
        b=Wte4HSqiMwc28C8kkprX4GW0zcBvnHFcy7Zuhf6V0154gDJ4aCN8xPui+rtEPEbqX1
         Bn8GIjpCxLtX5T8IE6oNeXqOAItyYVRr1S3Pe/a0dFYegZ8dQBS0GI0u7PQ/i1fkkUnV
         lt1xF/A+4Qjwfh2aINz8qXzY2UqYlshXwhTbURrc1QZPoc5E21za+alWs9wDBP3lg9ms
         uW27U4dfbaCIxoWF1264JNIY/fPc6HSykG+8XAqHtObyYKQPhuLUe4/hsLOMT67usxkV
         fRuEgG4ZJtXtoc1inCKzWOkhIPvG/RpgvH9DbDVHFOXTzU+znazul4ewRhFamUGoRYYO
         pEEg==
X-Gm-Message-State: AFqh2krn/yqx+b4b6b2UagagDjIMvm/ikheV7b0LZEe6MMTLx37e3ew+
        45R/os4tuPN7A0IClV5tHmIu9g==
X-Google-Smtp-Source: AMrXdXuQQBYYNbPy/pST2ZGImpqOqF2KaAebZWKwXGOXWrjQn2ReNkclQVmbNnJreRG0Cz8FBcfg7A==
X-Received: by 2002:a05:622a:2516:b0:3a9:70a2:2c59 with SMTP id cm22-20020a05622a251600b003a970a22c59mr9525514qtb.39.1671733158072;
        Thu, 22 Dec 2022 10:19:18 -0800 (PST)
Received: from smtpclient.apple (c-98-249-43-138.hsd1.va.comcast.net. [98.249.43.138])
        by smtp.gmail.com with ESMTPSA id r18-20020a05620a299200b006f9f714cb6asm730727qkp.50.2022.12.22.10.19.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Dec 2022 10:19:17 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Joel Fernandes <joel@joelfernandes.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [RFC 0/2] srcu: Remove pre-flip memory barrier
Date:   Thu, 22 Dec 2022 13:19:06 -0500
Message-Id: <71C23049-158C-4E43-A54F-714640393682@joelfernandes.org>
References: <20221222164302.GP4001@paulmck-ThinkPad-P17-Gen-1>
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        linux-kernel@vger.kernel.org,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>, rcu@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>
In-Reply-To: <20221222164302.GP4001@paulmck-ThinkPad-P17-Gen-1>
To:     paulmck@kernel.org
X-Mailer: iPhone Mail (20B101)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Dec 22, 2022, at 11:43 AM, Paul E. McKenney <paulmck@kernel.org> wrote:=

>=20
> =EF=BB=BFOn Thu, Dec 22, 2022 at 01:40:10PM +0100, Frederic Weisbecker wro=
te:
>>> On Wed, Dec 21, 2022 at 12:11:42PM -0500, Mathieu Desnoyers wrote:
>>> On 2022-12-21 06:59, Frederic Weisbecker wrote:
>>>>> On Tue, Dec 20, 2022 at 10:34:19PM -0500, Mathieu Desnoyers wrote:
>>> [...]
>>>>>=20
>>>>> The memory ordering constraint I am concerned about here is:
>>>>>=20
>>>>>  * [...] In addition,
>>>>>  * each CPU having an SRCU read-side critical section that extends bey=
ond
>>>>>  * the return from synchronize_srcu() is guaranteed to have executed a=

>>>>>  * full memory barrier after the beginning of synchronize_srcu() and b=
efore
>>>>>  * the beginning of that SRCU read-side critical section. [...]
>>>>>=20
>>>>> So if we have a SRCU read-side critical section that begins after the b=
eginning
>>>>> of synchronize_srcu, but before its first memory barrier, it would mis=
s the
>>>>> guarantee that the full memory barrier is issued before the beginning o=
f that
>>>>> SRCU read-side critical section. IOW, that memory barrier needs to be a=
t the
>>>>> very beginning of the grace period.
>>>>=20
>>>> I'm confused, what's wrong with this ?
>>>>=20
>>>> UPDATER                  READER
>>>> -------                  ------
>>>> STORE X =3D 1              STORE srcu_read_lock++
>>>> // rcu_seq_snap()        smp_mb()
>>>> smp_mb()                 READ X
>>>> // scans
>>>> READ srcu_read_lock
>>>=20
>>> What you refer to here is only memory ordering of the store to X and loa=
d
>>> from X wrt loading/increment of srcu_read_lock, which is internal to the=

>>> srcu implementation. If we really want to model the provided high-level
>>> memory ordering guarantees, we should consider a scenario where SRCU is u=
sed
>>> for its memory ordering properties to synchronize other variables.
>>>=20
>>> I'm concerned about the following Dekker scenario, where synchronize_src=
u()
>>> and srcu_read_lock/unlock would be used instead of memory barriers:
>>>=20
>>> Initial state: X =3D 0, Y =3D 0
>>>=20
>>> Thread A                   Thread B
>>> ---------------------------------------------
>>> STORE X =3D 1                STORE Y =3D 1
>>> synchronize_srcu()
>>>                           srcu_read_lock()
>>>                           r1 =3D LOAD X
>>>                           srcu_read_unlock()
>>> r0 =3D LOAD Y
>>>=20
>>> BUG_ON(!r0 && !r1)
>>>=20
>>> So in the synchronize_srcu implementation, there appears to be two
>>> major scenarios: either srcu_gp_start_if_needed starts a gp or expedited=
 gp,
>>> or it uses an already started gp/expedited gp. When snapshotting with
>>> rcu_seq_snap, the fact that the memory barrier is after the ssp->srcu_gp=
_seq
>>> load means that it does not order prior memory accesses before that load=
.
>>> This sequence value is then used to identify which gp_seq to wait for wh=
en
>>> piggy-backing on another already-started gp. I worry about reordering
>>> between STORE X =3D 1 and load of ssp->srcu_gp_seq, which is then used t=
o
>>> piggy-back on an already-started gp.
>>>=20
>>> I suspect that the implicit barrier in srcu_read_lock() invoked at the
>>> beginning of srcu_gp_start_if_needed() is really the barrier that makes
>>> all this behave as expected. But without documentation it's rather hard t=
o
>>> follow.
>>=20
>> Oh ok I see now. It might be working that way by accident or on forgotten=

>> purpose. In any case, we really want to add a comment above that
>> __srcu_read_lock_nmisafe() call.
>=20
> Another test for the safety (or not) of removing either D or E is
> to move that WRITE_ONCE() to follow (or, respectively, precede) the
> adjacent scans.

Good idea, though I believe the MBs that the above talk about are not the fl=
ip ones. They are the ones in synchronize_srcu() beginning and end, that ord=
er with respect to grace period start and end.

So that (flipping MBs) is unrelated, or did I miss something?

Thanks.



>=20
>                            Thanx, Paul
