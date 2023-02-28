Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8A1E6A60C5
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 21:56:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229849AbjB1U42 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 15:56:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229679AbjB1U4Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 15:56:24 -0500
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B9C834F70
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 12:56:22 -0800 (PST)
Received: by mail-qv1-xf31.google.com with SMTP id nf5so7845777qvb.5
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 12:56:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1677617781;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1k1XmXsff3btuUGsie2pzFiOnlZVLd6pPcaArC3aVQs=;
        b=gmQXfguQviSRKLou+oUUzSbGaTJ9ngV0L/yjBbSllPFq5CjWR3J2W3ftRniJbEJZLG
         tz+tr7+GrkLgojwL4AmC8IlHQMcjefR6nZXWBI7jJNHOj5B1hpRKakgp63yY3St2O8iA
         iMs4QSzN4BLC4Lyzrp0TY2Q7WLwUzBLlW2TME=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677617781;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1k1XmXsff3btuUGsie2pzFiOnlZVLd6pPcaArC3aVQs=;
        b=B+IynXgn1yzHnNvZjBBIcWAAUixTwZAZLCXL9lqnRfKAj+LDxdCWiJ4mVKops2+PAS
         UPs2KvJnB+yUuiZ1MYVe4d6+2ZlvNSkXUqnG9H0S5lbV8z7D6GCkhx3wPhrbrBpW7fG0
         9SVR67iSX0laftsXuqyj9xOKlHWJLxXrc8CAUWog78zD0DJsRoE7etfZ8r4GyDlfTHUS
         xtBrrwc4lVAYs9BcqE4GqbBolVOsG/vSvblHqEDZqXrnpymRe6XJDl3iDim2goyW7dV/
         U+hQMop89JYvnXFStg3FyH34kN5qMDh9RIs0eihQrnCNWWB1SsRwB+5SSPu+lzLRINZV
         Nsjg==
X-Gm-Message-State: AO0yUKX0xwHv4M2byQSFVkCecGBbRdYMn3NwC3LREIPZUooTtrAKznre
        eqDLUYUzUIr7Bd/bVmjT1M84Fw==
X-Google-Smtp-Source: AK7set/wVX5+WV6VxKZvkpTsFI6BZFSZalcly9larjlq30KVCinUIpyb9ZcD4JgMAHH47oMcF3+7cQ==
X-Received: by 2002:a05:6214:e8f:b0:571:f87:a66e with SMTP id hf15-20020a0562140e8f00b005710f87a66emr7923388qvb.34.1677617781566;
        Tue, 28 Feb 2023 12:56:21 -0800 (PST)
Received: from smtpclient.apple (c-98-249-43-138.hsd1.va.comcast.net. [98.249.43.138])
        by smtp.gmail.com with ESMTPSA id bm26-20020a05620a199a00b007424376ca4bsm7545832qkb.18.2023.02.28.12.56.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Feb 2023 12:56:20 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Joel Fernandes <joel@joelfernandes.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH] rcu: use try_cmpxchg in check_cpu_stall
Date:   Tue, 28 Feb 2023 15:56:09 -0500
Message-Id: <944C2939-BE6B-431D-B751-F052A7684844@joelfernandes.org>
References: <Y/5mguXPPqdP3MZF@google.com>
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>
In-Reply-To: <Y/5mguXPPqdP3MZF@google.com>
To:     Uros Bizjak <ubizjak@gmail.com>
X-Mailer: iPhone Mail (20B101)
X-Spam-Status: No, score=-0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLACK autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Feb 28, 2023, at 3:39 PM, Joel Fernandes <joel@joelfernandes.org> wrote=
:
>=20
> =EF=BB=BFOn Tue, Feb 28, 2023 at 04:51:21PM +0100, Uros Bizjak wrote:
>> Use try_cmpxchg instead of cmpxchg (*ptr, old, new) =3D=3D old in
>> check_cpu_stall.  x86 CMPXCHG instruction returns success in ZF flag, so
>> this change saves a compare after cmpxchg (and related move instruction i=
n
>> front of cmpxchg).
>=20
> In my codegen, I am not seeing mov instruction before the cmp removed, how=

> can that be? The rax has to be populated with a mov before cmpxchg right?
>=20
> So try_cmpxchg gives: mov, cmpxchg, cmp, jne
> Where as cmpxchg gives: mov, cmpxchg, mov, jne
>=20
> So yeah you got rid of compare, but I am not seeing reduction in moves.
> Either way, I think it is an improvement due to dropping cmp so:
>=20
> Acked-by: Joel Fernandes (Google) <joel@joelfernandes.org>

Ah there probably is a lesser mov to hold the value to compare against,
but maybe not always?=20

Would be nice to clarify that in the changelog anyway.

Thanks,

 - Joel

>=20
> thanks,
>=20
> - Joel
>=20
>=20
>>=20
>> No functional change intended.
>>=20
>> Cc: "Paul E. McKenney" <paulmck@kernel.org>
>> Cc: Frederic Weisbecker <frederic@kernel.org>
>> Cc: Neeraj Upadhyay <quic_neeraju@quicinc.com>
>> Cc: Josh Triplett <josh@joshtriplett.org>
>> Cc: Steven Rostedt <rostedt@goodmis.org>
>> Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
>> Cc: Lai Jiangshan <jiangshanlai@gmail.com>
>> Cc: Joel Fernandes <joel@joelfernandes.org>
>> Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
>> ---
>> kernel/rcu/tree_stall.h | 4 ++--
>> 1 file changed, 2 insertions(+), 2 deletions(-)
>>=20
>> diff --git a/kernel/rcu/tree_stall.h b/kernel/rcu/tree_stall.h
>> index b10b8349bb2a..d81c88e66b42 100644
>> --- a/kernel/rcu/tree_stall.h
>> +++ b/kernel/rcu/tree_stall.h
>> @@ -760,7 +760,7 @@ static void check_cpu_stall(struct rcu_data *rdp)
>>    jn =3D jiffies + ULONG_MAX / 2;
>>    if (rcu_gp_in_progress() &&
>>        (READ_ONCE(rnp->qsmask) & rdp->grpmask) &&
>> -        cmpxchg(&rcu_state.jiffies_stall, js, jn) =3D=3D js) {
>> +        try_cmpxchg(&rcu_state.jiffies_stall, &js, jn)) {
>>=20
>>        /*
>>         * If a virtual machine is stopped by the host it can look to
>> @@ -778,7 +778,7 @@ static void check_cpu_stall(struct rcu_data *rdp)
>>=20
>>    } else if (rcu_gp_in_progress() &&
>>           ULONG_CMP_GE(j, js + RCU_STALL_RAT_DELAY) &&
>> -           cmpxchg(&rcu_state.jiffies_stall, js, jn) =3D=3D js) {
>> +           try_cmpxchg(&rcu_state.jiffies_stall, &js, jn)) {
>>=20
>>        /*
>>         * If a virtual machine is stopped by the host it can look to
>> --=20
>> 2.39.2
>>=20
