Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A14F366689F
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 02:57:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235778AbjALB5S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 20:57:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235233AbjALB5M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 20:57:12 -0500
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 444971182C
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 17:57:11 -0800 (PST)
Received: by mail-qt1-x82e.google.com with SMTP id x7so5334425qtv.13
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 17:57:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Pk4n6j74pVPRfGLW3MNGLi4Yk38ZJHY8XUjjy5UlLg4=;
        b=qAQv12wBcOdEvg/ENr7CxeYsPZmUrWh3bCIhmiMsYqgLptlzcf82tzIfYocJSa+Pca
         2TCAbq7REraCC3tGZfN5nTOEjClY/U35NytH/2qWnm2tpk0vLqZM0SaBrDLzYV5dWGSN
         Dmc14jvgr3U5b1MDlz3eEmqsIr791uPz9mpBY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Pk4n6j74pVPRfGLW3MNGLi4Yk38ZJHY8XUjjy5UlLg4=;
        b=JQB1CRlQKnalVargtAevmtQFPgmfkztXtCPBItJzqqhZCD04SVwS3YRZCItLq64Kc2
         b8CQaTKNrrafB/sg1lYj27qF7nN4JX/xcqZ3jY2tjS65xNK4gVAHsRR86+VeudymapHZ
         IgXJcwTRZ4OC2CI0t968GBh0okhIwb/PkqpHoMh/P5bMue/bBd9U4TfMH4lDIypMBNCV
         7TwunhjLEaIfu6rsIPPoXM5KRB39FSfSkzBvj/bxoMMB68ASyKP9N+MMtLA3Iynt9HO2
         oPiMYPYMVrYmw1QrBsiqGJggfVBN5KR/PerVrqLCfMiZ+A1w5+LkacoVgmAzIMe2WRBe
         XC3Q==
X-Gm-Message-State: AFqh2kpRHtq8k8No+OLCKLfsfMQ4PaUvFpSnevjaBr0cXL8crDr0BCKM
        WDRAtwF8Ul9W67lDj7eJu+HHXw==
X-Google-Smtp-Source: AMrXdXvc475eC4ao1HQtlgbhiAmDl3T6dmQbbHaT8TfGR1LYpElSpZGvcbFhAkiKRTF33oUfiWqBJw==
X-Received: by 2002:ac8:7ca:0:b0:3b0:fe24:9b89 with SMTP id m10-20020ac807ca000000b003b0fe249b89mr4455097qth.63.1673488630248;
        Wed, 11 Jan 2023 17:57:10 -0800 (PST)
Received: from smtpclient.apple (c-98-249-43-138.hsd1.va.comcast.net. [98.249.43.138])
        by smtp.gmail.com with ESMTPSA id d15-20020a05620a140f00b006fc92cf4703sm9852628qkj.132.2023.01.11.17.57.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Jan 2023 17:57:08 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Joel Fernandes <joel@joelfernandes.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v2 rcu/dev 1/2] rcu: Track laziness during boot and suspend
Date:   Wed, 11 Jan 2023 20:56:57 -0500
Message-Id: <CED4D47F-BEA3-4F53-9934-939454DDEE2B@joelfernandes.org>
References: <20230112012950.GE4028633@paulmck-ThinkPad-P17-Gen-1>
Cc:     linux-kernel@vger.kernel.org,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        rcu@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        fweisbec@gmail.com, urezki@gmail.com
In-Reply-To: <20230112012950.GE4028633@paulmck-ThinkPad-P17-Gen-1>
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



> On Jan 11, 2023, at 8:29 PM, Paul E. McKenney <paulmck@kernel.org> wrote:
>=20
> =EF=BB=BFOn Thu, Jan 12, 2023 at 12:52:22AM +0000, Joel Fernandes (Google)=
 wrote:
>> During boot and suspend/resume, it is desired to prevent RCU laziness fro=
m
>> effecting performance and in some cases failures like with suspend.
>>=20
>> Track whether RCU laziness is to be ignored or not, in kernels with
>> CONFIG_RCU_LAZY enabled. We do such tracking for expedited-RCU already, h=
owever
>> since Android currently expedites synchronous_rcu() always, we cannot rel=
y on
>> that. The next patch ignores laziness hints based on this tracking.
>>=20
>> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
>> ---
>> Paul, could we take this and the next one for 6.2 -rc cycle?
>=20
> Given how late it is in v6.2, I would need you to make it all depend on
> CONFIG_RCU_LAZY, so that it is blindingly and immediately obvious that
> there is no change in behavior for kernels built with CONFIG_RCU_LAZY=3Dn.=

>=20
> If you are OK with the v6.3 merge window and backports, what you have
> likely suffices, modulo review and testing.
>=20
> So, how would you like to proceed?

Yes that is fine with me. Though, it is right now fully compile-time depende=
nt on the lazy config, except the definition of the integer which I can=E2=80=
=99t put behind a config because of ugly ifdefs. I would expect LTO to remov=
e the integer definition automatically. But it has no effect otherwise.

I do worry a bit about users who are not using stable and have their own ker=
nel versions with backports. But maybe a fixes tag will get their attention?=


Android and ChromeOS should both be fine though, given they swear by stable.=


Thanks,

 - Joel=20


>=20
>                            Thanx, Paul
>=20
>> I also booted debian Linux and verified the flag is reset correctly after=
 boot
>> completes. Thanks.
>>=20
>> kernel/rcu/rcu.h    |  6 ++++++
>> kernel/rcu/tree.c   |  2 ++
>> kernel/rcu/update.c | 40 +++++++++++++++++++++++++++++++++++++++-
>> 5 files changed, 55 insertions(+), 1 deletion(-)
>> create mode 100644 cc_list
>> create mode 100644 to_list
>>=20
>> diff --git a/kernel/rcu/rcu.h b/kernel/rcu/rcu.h
>> index 5c8013f7085f..115616ac3bfa 100644
>> --- a/kernel/rcu/rcu.h
>> +++ b/kernel/rcu/rcu.h
>> @@ -449,14 +449,20 @@ do {                                    \
>> /* Tiny RCU doesn't expedite, as its purpose in life is instead to be tin=
y. */
>> static inline bool rcu_gp_is_normal(void) { return true; }
>> static inline bool rcu_gp_is_expedited(void) { return false; }
>> +static inline bool rcu_async_should_hurry(void) { return false; }
>> static inline void rcu_expedite_gp(void) { }
>> static inline void rcu_unexpedite_gp(void) { }
>> +static inline void rcu_async_hurry(void) { }
>> +static inline void rcu_async_relax(void) { }
>> static inline void rcu_request_urgent_qs_task(struct task_struct *t) { }
>> #else /* #ifdef CONFIG_TINY_RCU */
>> bool rcu_gp_is_normal(void);     /* Internal RCU use. */
>> bool rcu_gp_is_expedited(void);  /* Internal RCU use. */
>> +bool rcu_async_should_hurry(void);  /* Internal RCU use. */
>> void rcu_expedite_gp(void);
>> void rcu_unexpedite_gp(void);
>> +void rcu_async_hurry(void);
>> +void rcu_async_relax(void);
>> void rcupdate_announce_bootup_oddness(void);
>> #ifdef CONFIG_TASKS_RCU_GENERIC
>> void show_rcu_tasks_gp_kthreads(void);
>> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
>> index 63545d79da51..78b2e999c904 100644
>> --- a/kernel/rcu/tree.c
>> +++ b/kernel/rcu/tree.c
>> @@ -4504,11 +4504,13 @@ static int rcu_pm_notify(struct notifier_block *s=
elf,
>>    switch (action) {
>>    case PM_HIBERNATION_PREPARE:
>>    case PM_SUSPEND_PREPARE:
>> +        rcu_async_hurry();
>>        rcu_expedite_gp();
>>        break;
>>    case PM_POST_HIBERNATION:
>>    case PM_POST_SUSPEND:
>>        rcu_unexpedite_gp();
>> +        rcu_async_relax();
>>        break;
>>    default:
>>        break;
>> diff --git a/kernel/rcu/update.c b/kernel/rcu/update.c
>> index 3893022f8ed8..19bf6fa3ee6a 100644
>> --- a/kernel/rcu/update.c
>> +++ b/kernel/rcu/update.c
>> @@ -144,8 +144,45 @@ bool rcu_gp_is_normal(void)
>> }
>> EXPORT_SYMBOL_GPL(rcu_gp_is_normal);
>>=20
>> -static atomic_t rcu_expedited_nesting =3D ATOMIC_INIT(1);
>> +static atomic_t rcu_async_hurry_nesting =3D ATOMIC_INIT(1);
>> +/*
>> + * Should call_rcu() callbacks be processed with urgency or are
>> + * they OK being executed with arbitrary delays?
>> + */
>> +bool rcu_async_should_hurry(void)
>> +{
>> +    return !IS_ENABLED(CONFIG_RCU_LAZY) ||
>> +           atomic_read(&rcu_async_hurry_nesting);
>> +}
>> +EXPORT_SYMBOL_GPL(rcu_async_should_hurry);
>> +
>> +/**
>> + * rcu_async_hurry - Make future async RCU callbacks not lazy.
>> + *
>> + * After a call to this function, future calls to call_rcu()
>> + * will be processed in a timely fashion.
>> + */
>> +void rcu_async_hurry(void)
>> +{
>> +    if (IS_ENABLED(CONFIG_RCU_LAZY))
>> +        atomic_inc(&rcu_async_hurry_nesting);
>> +}
>> +EXPORT_SYMBOL_GPL(rcu_async_hurry);
>>=20
>> +/**
>> + * rcu_async_relax - Make future async RCU callbacks lazy.
>> + *
>> + * After a call to this function, future calls to call_rcu()
>> + * will be processed in a lazy fashion.
>> + */
>> +void rcu_async_relax(void)
>> +{
>> +    if (IS_ENABLED(CONFIG_RCU_LAZY))
>> +        atomic_dec(&rcu_async_hurry_nesting);
>> +}
>> +EXPORT_SYMBOL_GPL(rcu_async_relax);
>> +
>> +static atomic_t rcu_expedited_nesting =3D ATOMIC_INIT(1);
>> /*
>>  * Should normal grace-period primitives be expedited?  Intended for
>>  * use within RCU.  Note that this function takes the rcu_expedited
>> @@ -195,6 +232,7 @@ static bool rcu_boot_ended __read_mostly;
>> void rcu_end_inkernel_boot(void)
>> {
>>    rcu_unexpedite_gp();
>> +    rcu_async_relax();
>>    if (rcu_normal_after_boot)
>>        WRITE_ONCE(rcu_normal, 1);
>>    rcu_boot_ended =3D true;
>> --=20
>> 2.39.0.314.g84b9a713c41-goog
