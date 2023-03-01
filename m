Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7F066A752A
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 21:20:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229821AbjCAUUI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 15:20:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229766AbjCAUUC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 15:20:02 -0500
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7C9948E2D
        for <linux-kernel@vger.kernel.org>; Wed,  1 Mar 2023 12:19:30 -0800 (PST)
Received: by mail-qv1-xf35.google.com with SMTP id op8so10147547qvb.11
        for <linux-kernel@vger.kernel.org>; Wed, 01 Mar 2023 12:19:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1677701910;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0gQXOTQSV2ARCOgkFMSKtn3VE9UmkR63oqSEKggRBeI=;
        b=rbxcD0XPWx6LcnRZefQEe02u20spE/5QPIfbFtw/+jXVUQo4I1v+a0HiGaOSc9S0Ly
         dwVHgoHDp0z0fUQ64/2sKFbLZ6N7Ux1qTRkEKxjDhdcSgUcHJxMDTGYSW62zT7x0bVRR
         CYHz4FwCz291HnXBdRHXM21C9EdnzseqOXZWc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677701910;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0gQXOTQSV2ARCOgkFMSKtn3VE9UmkR63oqSEKggRBeI=;
        b=UlJ/4CORvH03XQlaGqP1hhOTU7zzJCF1/u+UKXpV2iepsdhDUP4Gs40Fcara2hfAYA
         1nDv/rVoXVO2OpltoQB1tqtkFw2nIF34BqYnj2E1iE/ATRMbMmIeXMuRt+hOA/3+dtP0
         bFP+U12fUCfwjp75p1g3GVJgUdbKDI28tPo9VHHceAl7eggoa3YKKDJxil9A1FzpLv9f
         6Y2ITwiFhEluNWC3WxMAiJIOeixXCThcOYA5QKXZ7PnsU6LXZYr1whL/3Qd/zbaX2mcx
         iMsJLQSIudu2zFfmQZKPF9EoNxdfeYWBMIDE1VNO1WatAmOAqO68OyY4dGV7aYaEQOm0
         wDMw==
X-Gm-Message-State: AO0yUKU/DEHM32jIbo34gFDE3gyKmrYnt3XvscwywjLuYdxim+itYsPC
        DpRfMfiKlK6Urgcr/0eNSMNNdA==
X-Google-Smtp-Source: AK7set8PlZDEXu2RmKzXoAyGNoL0QDyGGiC2f55Y211NYj/sUTrGD5dY520IkwELbGfQEmgWnbylhw==
X-Received: by 2002:ad4:5cc7:0:b0:537:4b09:670f with SMTP id iu7-20020ad45cc7000000b005374b09670fmr16250104qvb.25.1677701909981;
        Wed, 01 Mar 2023 12:18:29 -0800 (PST)
Received: from smtpclient.apple (c-98-249-43-138.hsd1.va.comcast.net. [98.249.43.138])
        by smtp.gmail.com with ESMTPSA id d184-20020a37b4c1000000b0073b69922cfesm9321348qkf.85.2023.03.01.12.18.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Mar 2023 12:18:28 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Joel Fernandes <joel@joelfernandes.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH] rcu: use try_cmpxchg in check_cpu_stall
Date:   Wed, 1 Mar 2023 15:18:18 -0500
Message-Id: <8075146A-38A7-4CF0-9809-4E40BD120BF1@joelfernandes.org>
References: <20230301200820.GF2948950@paulmck-ThinkPad-P17-Gen-1>
Cc:     Uros Bizjak <ubizjak@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>
In-Reply-To: <20230301200820.GF2948950@paulmck-ThinkPad-P17-Gen-1>
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



> On Mar 1, 2023, at 3:08 PM, Paul E. McKenney <paulmck@kernel.org> wrote:
>=20
> =EF=BB=BFOn Wed, Mar 01, 2023 at 07:43:34PM +0100, Uros Bizjak wrote:
>>> On Wed, Mar 1, 2023 at 5:38=E2=80=AFPM Steven Rostedt <rostedt@goodmis.o=
rg> wrote:
>>>=20
>>> On Wed, 1 Mar 2023 11:28:47 +0100
>>> Uros Bizjak <ubizjak@gmail.com> wrote:
>>>=20
>>>> These benefits are the reason the change to try_cmpxchg was accepted
>>>> also in the linear code elsewhere in the linux kernel, e.g. [2,3] to
>>>> name a few commits, with a thumbs-up and a claim that the new code is
>>>> actually *clearer* at the merge commit [4].
>>>=20
>>> I'll say it here too. I really like Joel's suggestion of having a
>>> cmpxchg_success() that does not have the added side effect of modifying t=
he
>>> old variable.
>>>=20
>>> I think that would allow for the arch optimizations that you are trying t=
o
>>> achieve, as well as remove the side effect that might cause issues down t=
he
>>> road.
>>=20
>> Attached patch implements this suggestion.
>=20
> Please help me out here.
>=20
> Why on earth are we even discussing making this change to code that
> normally never executes?  Performance is not a consideration here.
>=20
> What am I missing here?  Is there some sort of forward-progress
> issue that this change addresses?

I do not think it is anything with performance. The suggestion just makes
the code easier to read. In the case of ftrace (not RCU), it results in furt=
her
deleted lines of code.

Maybe it got confusing because we are discussing the change as it
applies to both ftrace and RCU.

You could argue that it has to do with performance in the fast path, but it
is probably down in the noise.

 - Joel=20


>=20
>                            Thanx, Paul
>=20
>> Uros.
>=20
>> diff --git a/kernel/rcu/tree_stall.h b/kernel/rcu/tree_stall.h
>> index b10b8349bb2a..229263ebba3b 100644
>> --- a/kernel/rcu/tree_stall.h
>> +++ b/kernel/rcu/tree_stall.h
>> @@ -709,6 +709,12 @@ static void print_cpu_stall(unsigned long gps)
>>    set_preempt_need_resched();
>> }
>>=20
>> +#define cmpxchg_success(ptr, old, new)                \
>> +({                                \
>> +    __typeof__(*(ptr)) __tmp =3D (old);            \
>> +    try_cmpxchg((ptr), &__tmp, (new));            \
>> +})
>> +
>> static void check_cpu_stall(struct rcu_data *rdp)
>> {
>>    bool didstall =3D false;
>> @@ -760,7 +766,7 @@ static void check_cpu_stall(struct rcu_data *rdp)
>>    jn =3D jiffies + ULONG_MAX / 2;
>>    if (rcu_gp_in_progress() &&
>>        (READ_ONCE(rnp->qsmask) & rdp->grpmask) &&
>> -        cmpxchg(&rcu_state.jiffies_stall, js, jn) =3D=3D js) {
>> +        cmpxchg_success(&rcu_state.jiffies_stall, js, jn)) {
>>=20
>>        /*
>>         * If a virtual machine is stopped by the host it can look to
>> @@ -778,7 +784,7 @@ static void check_cpu_stall(struct rcu_data *rdp)
>>=20
>>    } else if (rcu_gp_in_progress() &&
>>           ULONG_CMP_GE(j, js + RCU_STALL_RAT_DELAY) &&
>> -           cmpxchg(&rcu_state.jiffies_stall, js, jn) =3D=3D js) {
>> +           cmpxchg_success(&rcu_state.jiffies_stall, js, jn)) {
>>=20
>>        /*
>>         * If a virtual machine is stopped by the host it can look to
>=20
