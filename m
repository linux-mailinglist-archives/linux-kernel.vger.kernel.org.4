Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 789A3652C1B
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Dec 2022 05:26:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234396AbiLUE0b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 23:26:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbiLUE00 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 23:26:26 -0500
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE2A8F03D
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 20:26:24 -0800 (PST)
Received: by mail-qv1-xf29.google.com with SMTP id d13so9595281qvj.8
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 20:26:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TCgpNOZquvWN/9Ttvx6v+EBz7WzNJvsJWIJuT0Mli4o=;
        b=rsydt1487DQ+I36CTrPO9KN4tP5ytKwJD9mZbgEOkURy38DZoBqVFTo8J7Cr8nll8s
         huS0jz1y88YJVXoI06pAUoqTPxYiKPJlI1kDGDe6rV14henfbVsolzaxgq3ETm1Ia8tk
         XO4ugVh72EGwTa+BW87vcpOvfB0lDbb27iUkk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TCgpNOZquvWN/9Ttvx6v+EBz7WzNJvsJWIJuT0Mli4o=;
        b=fqrd7L6F5r/8TNEDwHGNqwEdxu8Z6Ktx9jEhVs9pBWrRRr3sUQLhD5kkSTGXEYS5Bg
         qft8lXt18FkoDBZt3P4rUU1EP3Apj1cgKtSkTUa12vzk6yi/SB+Z/I6BDC0hHPlWmNCh
         0Bwi/YuC48x+8Mo66McQqGqaAnBqp+fNNpqKNYAN0n49gV+5JwE8XUUU6aBn4T3NKvx1
         IfDOj1Xyw9BmjyiGngsM0Clfiapgwmn8t9yKcRb3a+v+QWT+PCJGMkjzeViTT38e0qgG
         04wkFMcYcWzUacAcCP3ipscEAQE0ZkR9u3Ri5+PdHnsNM5vxyvmGCMy34PqBV5FLbSa2
         +R2A==
X-Gm-Message-State: AFqh2krxQPfQX6yw+mPHBi4nhdVErdomWmDtHBhM2eblvBPM2/WX9nQN
        XyOd4dbIALaC7C6OHilYKkBSgH3wBqPyjPOcRPA=
X-Google-Smtp-Source: AMrXdXuIgc10HzBZ3I3C3kZF2bbt5BV3lGXNCccWEyFVLPGrrgUNKt9Ho3ZiWcKwn7QLbLo2DCe47Q==
X-Received: by 2002:a0c:ed34:0:b0:4d8:42df:19d7 with SMTP id u20-20020a0ced34000000b004d842df19d7mr176862qvq.36.1671596783841;
        Tue, 20 Dec 2022 20:26:23 -0800 (PST)
Received: from smtpclient.apple (c-98-249-43-138.hsd1.va.comcast.net. [98.249.43.138])
        by smtp.gmail.com with ESMTPSA id dm36-20020a05620a1d6400b006bbc3724affsm10030526qkb.45.2022.12.20.20.26.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Dec 2022 20:26:23 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Joel Fernandes <joel@joelfernandes.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [RFC 0/2] srcu: Remove pre-flip memory barrier
Date:   Tue, 20 Dec 2022 23:26:12 -0500
Message-Id: <6BD506EA-77D2-4AC9-87A5-C8781594CF0F@joelfernandes.org>
References: <f4199d1f-306c-681f-8bb9-26d66ecf5121@efficios.com>
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        linux-kernel@vger.kernel.org,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>
In-Reply-To: <f4199d1f-306c-681f-8bb9-26d66ecf5121@efficios.com>
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



> On Dec 20, 2022, at 10:43 PM, Mathieu Desnoyers <mathieu.desnoyers@efficio=
s.com> wrote:
>=20
> =EF=BB=BFOn 2022-12-20 19:58, Frederic Weisbecker wrote:
>>> On Wed, Dec 21, 2022 at 01:49:57AM +0100, Frederic Weisbecker wrote:
>>> On Tue, Dec 20, 2022 at 07:15:00PM -0500, Joel Fernandes wrote:
>>>> On Tue, Dec 20, 2022 at 5:45 PM Frederic Weisbecker <frederic@kernel.or=
g> wrote:
>>>> Agreed about (1).
>>>>=20
>>>>> _ In (2), E pairs with the address-dependency between idx and lock_cou=
nt.
>>>>=20
>>>> But that is not the only reason. If that was the only reason for (2),
>>>> then there is an smp_mb() just before the next-scan post-flip before
>>>> the lock counts are read.
>>>=20
>>> The post-flip barrier makes sure the new idx is visible on the next READ=
ER's
>>> turn, but it doesn't protect against the fact that "READ idx then WRITE l=
ock[idx]"
>>> may appear unordered from the update side POV if there is no barrier bet=
ween the
>>> scan and the flip.
>>>=20
>>> If you remove the smp_mb() from the litmus test I sent, things explode.
>> Or rather, look at it the other way, if there is no barrier between the l=
ock
>> scan and the index flip (E), then the index flip can appear to be written=
 before the
>> lock is read. Which means you may start activating the index before you f=
inish
>> reading it (at least it appears that way from the readers pont of view).
>=20
> Considering that you can have pre-existing readers from arbitrary index ap=
pearing anywhere in the grace period (because a reader can fetch the
> index and be preempted for an arbitrary amount of time before incrementing=
 the lock count), the grace period algorithm needs to deal with the fact tha=
t a newcoming reader can appear in a given index either before or after the f=
lip.
>=20
> I don't see how flipping the index before or after loading the unlock/lock=
 values would break anything (except for unlikely counter overflow situation=
s as previously discussed).

If you say unlikely, that means it can happen some times which is bad enough=
 ;-). Maybe you mean impossible. I would not settle for anything less than k=
eeping the memory barrier around if it helps unlikely cases, but only D does=
 help for the theoretical wrapping/overflow issue. E is broken and does not e=
ven help the theoretical issue IMO. And both D and E do not affect correctne=
ss IMO.

Anyway in all likelihood, I will be trying to remove E completely and clarif=
y docs on D in the coming weeks. And also try to drop the size of the counte=
rs per our discussions

Thanks.



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
