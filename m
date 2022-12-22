Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 876076541CE
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 14:21:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235653AbiLVNVY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 08:21:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235438AbiLVNUu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 08:20:50 -0500
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90E2B30569
        for <linux-kernel@vger.kernel.org>; Thu, 22 Dec 2022 05:19:45 -0800 (PST)
Received: by mail-qt1-x831.google.com with SMTP id z12so1285155qtv.5
        for <linux-kernel@vger.kernel.org>; Thu, 22 Dec 2022 05:19:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Wk3pBbo7oihlFPssQ1OxlDxm4sHEv8p5gdZtboMH1O8=;
        b=CwiqSPCeU2+iq/h+7Wqn9UbqgHDma4zL0XpdC/uAoJscoDx58v4b3nIuiYo1IL3C8m
         fb/n6QHlP/tK0xWeewSjDkKnXDPO+ZPG3Svru2MpWQt+ndo8e1cLhw0HwfSElewDp1SI
         deH/2zs4rzUsYGvGVMzDiHCRfXgIFm09wPAKI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Wk3pBbo7oihlFPssQ1OxlDxm4sHEv8p5gdZtboMH1O8=;
        b=eYdbQDXsn0UI5w/RI1y1cs+y8P7kUnHf5+U8EGqy08Xr1x55+6QLYTowVhsD9i6g56
         K+LCTbkGvyup0Jy3qEcj3rH6UgRlaVWqwU7aY/3qWDVdh3uaWI6azkjYTKUMlpMdv5Jv
         6x2UbPvH+xPuHFC2gbVqzuzUS8SKShpuAHAMYGGPNoHb7DTTUcBerCY8qZvtC/AV+gqc
         UqWKlLUFzzG6KMB4eRazaYOrhR2NqD09rq936tulW816R31puxFXihSUjhrjY12M8RWE
         5dDveA+yPK0Bjd5qguVjociBbVDIIgLZ8gcjOqRTD537W33StgIuJSd1wyYPvHPxP7dc
         87nw==
X-Gm-Message-State: AFqh2kq4m7AOuMG/VWQ79MN7f8kRzSOS5cvxk56YiRcwIlHxTHaw1w9n
        fl06XpDd+o0z3oRt0dGYumIhRA==
X-Google-Smtp-Source: AMrXdXuLTbH3P0acYDjpZG3Gox2r2i9YrmLKNqeb32hxqsQpiZugkP0ANftLbKKTmkWlST1SXpZung==
X-Received: by 2002:a05:622a:400c:b0:3a9:80b6:8347 with SMTP id cf12-20020a05622a400c00b003a980b68347mr7037764qtb.1.1671715183976;
        Thu, 22 Dec 2022 05:19:43 -0800 (PST)
Received: from smtpclient.apple (c-98-249-43-138.hsd1.va.comcast.net. [98.249.43.138])
        by smtp.gmail.com with ESMTPSA id r12-20020ac8520c000000b0039a55f78792sm325244qtn.89.2022.12.22.05.19.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Dec 2022 05:19:43 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Joel Fernandes <joel@joelfernandes.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [RFC 0/2] srcu: Remove pre-flip memory barrier
Date:   Thu, 22 Dec 2022 08:19:32 -0500
Message-Id: <318A1705-D3B8-42B1-9BB1-AA9027166C96@joelfernandes.org>
References: <20221222124010.GC44777@lothringen>
Cc:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        linux-kernel@vger.kernel.org,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>
In-Reply-To: <20221222124010.GC44777@lothringen>
To:     Frederic Weisbecker <frederic@kernel.org>
X-Mailer: iPhone Mail (20B101)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Dec 22, 2022, at 7:40 AM, Frederic Weisbecker <frederic@kernel.org> wro=
te:
>=20
> =EF=BB=BFOn Wed, Dec 21, 2022 at 12:11:42PM -0500, Mathieu Desnoyers wrote=
:
>>> On 2022-12-21 06:59, Frederic Weisbecker wrote:
>>> On Tue, Dec 20, 2022 at 10:34:19PM -0500, Mathieu Desnoyers wrote:
>> [...]
>>>>=20
>>>> The memory ordering constraint I am concerned about here is:
>>>>=20
>>>>  * [...] In addition,
>>>>  * each CPU having an SRCU read-side critical section that extends beyo=
nd
>>>>  * the return from synchronize_srcu() is guaranteed to have executed a
>>>>  * full memory barrier after the beginning of synchronize_srcu() and be=
fore
>>>>  * the beginning of that SRCU read-side critical section. [...]
>>>>=20
>>>> So if we have a SRCU read-side critical section that begins after the b=
eginning
>>>> of synchronize_srcu, but before its first memory barrier, it would miss=
 the
>>>> guarantee that the full memory barrier is issued before the beginning o=
f that
>>>> SRCU read-side critical section. IOW, that memory barrier needs to be a=
t the
>>>> very beginning of the grace period.
>>>=20
>>> I'm confused, what's wrong with this ?
>>>=20
>>> UPDATER                  READER
>>> -------                  ------
>>> STORE X =3D 1              STORE srcu_read_lock++
>>> // rcu_seq_snap()        smp_mb()
>>> smp_mb()                 READ X
>>> // scans
>>> READ srcu_read_lock
>>=20
>> What you refer to here is only memory ordering of the store to X and load=

>> from X wrt loading/increment of srcu_read_lock, which is internal to the
>> srcu implementation. If we really want to model the provided high-level
>> memory ordering guarantees, we should consider a scenario where SRCU is u=
sed
>> for its memory ordering properties to synchronize other variables.
>>=20
>> I'm concerned about the following Dekker scenario, where synchronize_srcu=
()
>> and srcu_read_lock/unlock would be used instead of memory barriers:
>>=20
>> Initial state: X =3D 0, Y =3D 0
>>=20
>> Thread A                   Thread B
>> ---------------------------------------------
>> STORE X =3D 1                STORE Y =3D 1
>> synchronize_srcu()
>>                           srcu_read_lock()
>>                           r1 =3D LOAD X
>>                           srcu_read_unlock()
>> r0 =3D LOAD Y
>>=20
>> BUG_ON(!r0 && !r1)
>>=20
>> So in the synchronize_srcu implementation, there appears to be two
>> major scenarios: either srcu_gp_start_if_needed starts a gp or expedited g=
p,
>> or it uses an already started gp/expedited gp. When snapshotting with
>> rcu_seq_snap, the fact that the memory barrier is after the ssp->srcu_gp_=
seq
>> load means that it does not order prior memory accesses before that load.=

>> This sequence value is then used to identify which gp_seq to wait for whe=
n
>> piggy-backing on another already-started gp. I worry about reordering
>> between STORE X =3D 1 and load of ssp->srcu_gp_seq, which is then used to=

>> piggy-back on an already-started gp.
>>=20
>> I suspect that the implicit barrier in srcu_read_lock() invoked at the
>> beginning of srcu_gp_start_if_needed() is really the barrier that makes
>> all this behave as expected. But without documentation it's rather hard t=
o
>> follow.
>=20
> Oh ok I see now. It might be working that way by accident or on forgotten
> purpose. In any case, we really want to add a comment above that
> __srcu_read_lock_nmisafe() call.

Agreed on the analysis and the need for comments, thanks!

I think we also ought to document some more cases like, how the memory barri=
ers here relate to the other memory barrier A inside the scan loop. But I gu=
ess for me I need to understand the GP guarantee ordering first before attem=
pting documenting that aspect. Oh well, thank God for holidays. ;-)

Thanks,

 - Joel



>=20
