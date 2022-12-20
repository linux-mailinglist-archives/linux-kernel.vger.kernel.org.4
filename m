Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C202652259
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 15:22:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229638AbiLTOVv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 09:21:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233884AbiLTOVP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 09:21:15 -0500
Received: from mail-vk1-xa2f.google.com (mail-vk1-xa2f.google.com [IPv6:2607:f8b0:4864:20::a2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 409E71CFF5
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 06:20:21 -0800 (PST)
Received: by mail-vk1-xa2f.google.com with SMTP id o136so5829438vka.2
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 06:20:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jXqd4DeCvaiHMvVaq9cytI+IuzgZuGKPfi29NnINfkE=;
        b=dAZyD+m3bgniuwaWLPaRBC5YwocyRFsx0wGLSyIYl2gLqm7j1bmSOaHcu00h/BuPyQ
         F6xpcobLLoNenZ9jpBOf04uQ11ooByc1VQCu9Py7RC3QULBl9Xb5Ez5bHqGjfLYpnXWb
         xbRYg0GjJQixNJWkXPg4jj9nxEicaarM01r2I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jXqd4DeCvaiHMvVaq9cytI+IuzgZuGKPfi29NnINfkE=;
        b=F8EBAk5o/SucZwMikBzkyEnSo2iob5Z/geAIfxK2qH9hzFjKoEmZx9hRitNHk3NKVR
         IPvyw4iyBUzlZ4a05/aBigPmUpUYbENewTvjEIpDwv/H0XdlR2pMI8Po09FaGzPX6GOF
         d2MOmndIbL648QdB+MztxM0PLUNTDtQ+HGL5qKkFfH1pf9rv3ogHSJ8jqUekj5Oldly/
         ZSNoDt5BDzRxDV6je+I7Iu8bFaVY/Tq3o0q9dCDHDokWc7TIvYs/5vS4ZLHXf1dQM1NX
         hMu6tZheT2oJ7/6pgMghMeFdraRL2izzxir8gOkpUe5appemSTu7A+mVxq07u9QqD0o/
         MAxw==
X-Gm-Message-State: AFqh2kpnbAoSl4fVMCIJ5FX+LnIiw7yzTw+0/AC5UAIB2BgfIA3MFynV
        +EvNCaiqszjD0PR2bQfSzovOJA==
X-Google-Smtp-Source: AMrXdXtJ2GG+nwNShqyvaTrXXvUFXW/zWGMJEZCBt4H5k90N6WB2mU9+U6pbmaxHFQ+cAvol6kMqrg==
X-Received: by 2002:a1f:9ed1:0:b0:3bc:961f:d9c with SMTP id h200-20020a1f9ed1000000b003bc961f0d9cmr4330132vke.8.1671546020224;
        Tue, 20 Dec 2022 06:20:20 -0800 (PST)
Received: from smtpclient.apple (c-98-249-43-138.hsd1.va.comcast.net. [98.249.43.138])
        by smtp.gmail.com with ESMTPSA id 195-20020a370ccc000000b006eee3a09ff3sm8818979qkm.69.2022.12.20.06.20.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Dec 2022 06:20:19 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Joel Fernandes <joel@joelfernandes.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [RFC 0/2] srcu: Remove pre-flip memory barrier
Date:   Tue, 20 Dec 2022 09:20:08 -0500
Message-Id: <CA83E649-8C79-4D39-9BFE-BBEF95968B98@joelfernandes.org>
References: <20221220140714.GB22763@lothringen>
Cc:     linux-kernel@vger.kernel.org,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>
In-Reply-To: <20221220140714.GB22763@lothringen>
To:     Frederic Weisbecker <frederic@kernel.org>
X-Mailer: iPhone Mail (20B101)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,MIME_QP_LONG_LINE,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Dec 20, 2022, at 9:07 AM, Frederic Weisbecker <frederic@kernel.org> wro=
te:
>=20
> =EF=BB=BFOn Tue, Dec 20, 2022 at 08:44:40AM -0500, Joel Fernandes wrote:
>>> C w-depend-r
>>>=20
>>> {
>>>   PLOCK=3DLOCK0;
>>> }
>>>=20
>>> // updater
>>> P0(int *LOCK1, int **PLOCK)
>>> {
>>>   int lock1;
>>>=20
>>>   lock1 =3D READ_ONCE(*LOCK1); // READ from inactive idx
>>>   smp_mb();
>>>   WRITE_ONCE(*PLOCK, LOCK1); // Flip idx
>>> }
>>>=20
>>> // reader
>>> P1(int **PLOCK)
>>> {
>>>   int *plock;
>>>=20
>>>   plock =3D READ_ONCE(*PLOCK);    // Read active idx
>>>   WRITE_ONCE(*plock, 1); // Write to active idx
>>=20
>> I am a bit lost here, why would the reader want to write to the active id=
x?
>> The reader does not update the idx, only the lock count.
>=20
> So &ssp->sda->srcu_lock_count is the base address and idx is the offset, r=
ight?
> The write is then displayed that way:
>=20
>     this_cpu_inc(ssp->sda->srcu_lock_count[idx].counter);
>=20
> But things could be also thought the other way around with idx being the b=
ase address and
> ssp->sda->srcu_lock_count being the offset.
>=20
>     this_cpu_inc(idx[ssp->sda->srcu_lock_count].counter);
>=20
> That would require to change some high level types but the result would be=
 the same from
> the memory point of view (and even from the ASM point of view). In the end=
 we
> are dealing with the same address and access.
>=20
> Now ssp->sda->srcu_lock_count is a constant address value. It doesn't chan=
ge.
> So it can be zero for example. Then the above increment becomes:
>=20
>   this_cpu_inc(idx.counter);
>=20
> And then it can be modelized as in the above litmus test.
>=20
> I had to play that trick because litmus doesn't support arrays but I belie=
ve
> it stands. Now of course I may well have got something wrong since I've al=
ways
> been terrible at maths...

Ah ok, I get where you were going with that. Yes there is address dependency=
 between reading idx and writing lock count. But IMHO, the access on the upd=
ate side is trying to order write to index, and reads from a lock count of a=
 previous index (as far as E / B+C is concerned). So IMHO, on the read side y=
ou have to consider 2 consecutive readers and not the same reader in order t=
o pair the same accesses correctly. But I could be missing something.

>> Further, the comment does not talk about implicit memory ordering, it=E2=80=
=99s talking about explicit ordering due to B+C on one side, and E on the ot=
her.
>=20
> Not arguing I'm also still confused by the comment...

;-)

Thanks,

 - Joel


>=20
> Thanks.
