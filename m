Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57B786521A7
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 14:44:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233652AbiLTNo4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 08:44:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232937AbiLTNoy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 08:44:54 -0500
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D29AA18E34
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 05:44:52 -0800 (PST)
Received: by mail-qt1-x82b.google.com with SMTP id s9so10908702qtx.6
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 05:44:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bS5GVakKfa9tWv6Lv91yeVdYC2dZL7mCPLtBOov0T4Q=;
        b=X+oz6PAcyFGjsg0JzDXb53wnAoGai0x2FYqzc4jaAzFq7gthGpYvOCo+3udJaSCM3e
         KYADxm5czubmW98JCbZrwjwRpICwvGOvX4sAJBFcMM4apEb4hlaD5jF1Thi82D4ZCD0F
         kzeOOvtjaLvfBDsdssWcaqrBF6wchcW9lpA4Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bS5GVakKfa9tWv6Lv91yeVdYC2dZL7mCPLtBOov0T4Q=;
        b=iWLf4i3sZbby5wM/C/PWmgPa8E4C6nBX1anKbolLEL8v/mzDXYilWE+tJGRkdPLfH3
         LVbwWSMvCfh06KF5Gj2sdkqTUZMbAbxNce7wdDURgNi7m6Gm2nwnfq5VUFsKgrZn/ctI
         4rs+qTlvHXopDzkvh5lvjJ2y/CPnptT4ZVwxtoGKMQsVFRn+dEqQUBcKFxRIe/Gprgsp
         ktswGtt+r6Y2XbzQ3OHwscwZgfv25+gYAFKX6kcIkpR7waEuZCenZ1XSHJApCQ2aFvv0
         Bh/esOMDz+5OUsGrM7+C4IPgCKM5Gqvf+vZYrPnqWRCYrKtL/5DpgUmZUYGy3PB8sYMp
         c6uQ==
X-Gm-Message-State: AFqh2koFz0sBM1Ja7zncXudksN4dvxpMTqROclbcuBRDvVQNqWZ9DwnU
        unddjqSYXChKoG2aQlDLn1KYOQ==
X-Google-Smtp-Source: AMrXdXuZdpxQ0wLcoJpRychEy5BHI38l79EsJ26HfxZVBvJnUs0bEjgMF08udVUozhPWOziNnElGKA==
X-Received: by 2002:a05:622a:4118:b0:3a9:756b:3db9 with SMTP id cc24-20020a05622a411800b003a9756b3db9mr26580027qtb.45.1671543891833;
        Tue, 20 Dec 2022 05:44:51 -0800 (PST)
Received: from smtpclient.apple (c-98-249-43-138.hsd1.va.comcast.net. [98.249.43.138])
        by smtp.gmail.com with ESMTPSA id o12-20020ac8554c000000b003972790deb9sm7592581qtr.84.2022.12.20.05.44.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Dec 2022 05:44:51 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Joel Fernandes <joel@joelfernandes.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [RFC 0/2] srcu: Remove pre-flip memory barrier
Date:   Tue, 20 Dec 2022 08:44:40 -0500
Message-Id: <D358FF0F-6F7C-413A-8CA6-7D36E9A64DB6@joelfernandes.org>
References: <20221220124033.GA22763@lothringen>
Cc:     linux-kernel@vger.kernel.org,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>
In-Reply-To: <20221220124033.GA22763@lothringen>
To:     Frederic Weisbecker <frederic@kernel.org>
X-Mailer: iPhone Mail (20B101)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,MIME_QP_LONG_LINE,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Dec 20, 2022, at 7:40 AM, Frederic Weisbecker <frederic@kernel.org> wro=
te:
>=20
> =EF=BB=BFOn Tue, Dec 20, 2022 at 01:34:43PM +0100, Frederic Weisbecker wro=
te:
>>> On Mon, Dec 19, 2022 at 11:07:17PM -0500, Joel Fernandes wrote:
>>> On Sun, Dec 18, 2022 at 2:13 PM Joel Fernandes (Google)
>>> <joel@joelfernandes.org> wrote:
>>>>=20
>>>> Hello, I believe the pre-flip memory barrier is not required. The only r=
eason I
>>>> can say to remove it, other than the possibility that it is unnecessary=
, is to
>>>> not have extra code that does not help. However, since we are issuing a=
 fully
>>>> memory-barrier after the flip, I cannot say that it hurts to do it anyw=
ay.
>>>>=20
>>>> For this reason, please consider these patches as "informational", than=
 a
>>>> "please merge". :-) Though, feel free to consider merging if you agree!=

>>>>=20
>>>> All SRCU scenarios pass with these, with 6 hours of testing.
>>>>=20
>>>> thanks,
>>>>=20
>>>> - Joel
>>>>=20
>>>> Joel Fernandes (Google) (2):
>>>> srcu: Remove comment about prior read lock counts
>>>> srcu: Remove memory barrier "E" as it is not required
>>>=20
>>> And litmus tests confirm that "E" does not really do what the comments
>>> say, PTAL:
>>> Test 1:
>>> C mbe
>>> (*
>>> * Result: sometimes
>>> * Does previous scan see old reader's lock count, if a new reader saw
>>> the new srcu_idx?
>>> *)
>>>=20
>>> {}
>>>=20
>>> P0(int *lockcount, int *srcu_idx) // updater
>>> {
>>>        int r0;
>>>        r0 =3D READ_ONCE(*lockcount);
>>>        smp_mb();       // E
>>>        WRITE_ONCE(*srcu_idx, 1);
>>> }
>>>=20
>>> P1(int *lockcount, int *srcu_idx) // reader
>>> {
>>>        int r0;
>>>        WRITE_ONCE(*lockcount, 1); // previous reader
>>>        smp_mb();       // B+C
>>>        r0 =3D READ_ONCE(*srcu_idx); // new reader
>>> }
>>> exists (0:r0=3D0 /\ 1:r0=3D1) (* Bad outcome. *)
>>>=20
>>> Test 2:
>>> C mbe2
>>>=20
>>> (*
>>> * Result: sometimes
>>> * If updater saw reader's lock count, was that reader using the old idx?=

>>> *)
>>>=20
>>> {}
>>>=20
>>> P0(int *lockcount, int *srcu_idx) // updater
>>> {
>>>        int r0;
>>>        r0 =3D READ_ONCE(*lockcount);
>>>        smp_mb();       // E
>>>        WRITE_ONCE(*srcu_idx, 1);
>>> }
>>>=20
>>> P1(int *lockcount, int *srcu_idx) // reader
>>> {
>>>        int r0;
>>>        int r1;
>>>        r1 =3D READ_ONCE(*srcu_idx); // previous reader
>>>        WRITE_ONCE(*lockcount, 1); // previous reader
>>>        smp_mb();       // B+C
>>>        r0 =3D READ_ONCE(*srcu_idx); // new reader
>>> }
>>> exists (0:r0=3D1 /\ 1:r1=3D1) (* Bad outcome. *)
>>=20
>> Actually, starring at this some more, there is some form of dependency
>> on the idx in order to build the address where the reader must write the
>> lockcount to. Litmus doesn't support arrays but assuming that
>> &ssp->sda->srcu_lock_count =3D=3D 0 (note the & in the beginning), it
>> could be modelized that way (I'm eluding the unlock part to simplify):
>>=20
>> ---
>> C w-depend-r
>>=20
>> {
>>    PLOCK=3DLOCK0;
>> }
>>=20
>> // updater
>> P0(int *LOCK0, int *LOCK1, int **PLOCK)
>> {
>>    int lock1;
>>=20
>>    lock1 =3D READ_ONCE(*LOCK1); // READ from inactive idx
>>    smp_mb();
>>    WRITE_ONCE(*PLOCK, LOCK1); // Flip idx
>> }
>>=20
>> // reader
>> P1(int **PLOCK)
>> {
>>    int *plock;
>>=20
>>    plock =3D READ_ONCE(*PLOCK);    // Read active idx
>>    WRITE_ONCE(*plock, 1); // Write to active idx
>> }
>>=20
>> exists (0:lock0=3D1) // never happens
>=20
> That's lock1=3D1, lemme do it again:
>=20
> C w-depend-r
>=20
> {
>    PLOCK=3DLOCK0;
> }
>=20
> // updater
> P0(int *LOCK1, int **PLOCK)
> {
>    int lock1;
>=20
>    lock1 =3D READ_ONCE(*LOCK1); // READ from inactive idx
>    smp_mb();
>    WRITE_ONCE(*PLOCK, LOCK1); // Flip idx
> }
>=20
> // reader
> P1(int **PLOCK)
> {
>    int *plock;
>=20
>    plock =3D READ_ONCE(*PLOCK);    // Read active idx
>    WRITE_ONCE(*plock, 1); // Write to active idx

I am a bit lost here, why would the reader want to write to the active idx? T=
he reader does not update the idx, only the lock count.

Further, the comment does not talk about implicit memory ordering, it=E2=80=99=
s talking about explicit ordering due to B+C on one side, and E on the other=
.

Thanks!

- Joel



> }
>=20
> exists (0:lock1=3D1) (* never *)
