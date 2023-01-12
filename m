Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50ACD6686F5
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 23:29:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240516AbjALW3Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 17:29:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240873AbjALW2n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 17:28:43 -0500
Received: from mail-vk1-xa2c.google.com (mail-vk1-xa2c.google.com [IPv6:2607:f8b0:4864:20::a2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4B8314038
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 14:26:04 -0800 (PST)
Received: by mail-vk1-xa2c.google.com with SMTP id l129so8581788vkh.6
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 14:26:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ExCBfBInQrrVHcmvCyckryvqYShRsjmQ+BuegMbZFyk=;
        b=fmzJ0UQnki4wTaYa4tph2ycWhrfi+LzT5+o0T5+RzYbD+G1AfsmxRZcCjG8ct8wfF2
         HG8MMOwwWJeKC/YNCKwHp0hQR4WMNIaSCCGLVobr9NMkKX018d/8Ge6GHKh5MyQbdFgC
         rJrFGu5+wGoV4ed77PjNCy1StktW38KdaQVAw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ExCBfBInQrrVHcmvCyckryvqYShRsjmQ+BuegMbZFyk=;
        b=oEjdVts2KjAoQT8HHV6uQsOkZXxie64hNPnMkgXUz2a+hQNyOQyFhjo+I4d3kCIjhr
         9GVnU/m8lgTnxD9ka/C+G9Ba7Rm7dp//SVZM9ThP7DVwGlkPjcvO0BM/EbaXrVNGQawt
         kP1rlzt20OvrTZTXIqytxsHWY/aqjwcGHtT0WqhUz7y6l60uQtM7kUKltom7kbVBzncF
         2bUZOIihpP97r4Keynro3ZvbQwTOD5db6YOTMCpT7xVFy8iibnTcf4rkcNs6Cd4yYifM
         PJ2PQKcEWhrL2oHQoeseLcHyYyPz6+/7g8mEkZTNJ0WsmDbvSfHTQt+oYQuM1ViXar8B
         QFkg==
X-Gm-Message-State: AFqh2kqGhKITNhOAvHjeGS9aJVrcXSZQTAGC4TlWcNksabUNH89Tl1vR
        bBsAbyOOQLrpG5bfr3PX2yejnw==
X-Google-Smtp-Source: AMrXdXvI61QBUAVzOgUKroqnPi39EBXptRmO2DNkHLEiiP+9nAdrENx9Ug7iWcjSytCHHtRD659U9A==
X-Received: by 2002:a1f:9bc6:0:b0:3da:1e0a:a864 with SMTP id d189-20020a1f9bc6000000b003da1e0aa864mr5301229vke.8.1673562363890;
        Thu, 12 Jan 2023 14:26:03 -0800 (PST)
Received: from smtpclient.apple (c-98-249-43-138.hsd1.va.comcast.net. [98.249.43.138])
        by smtp.gmail.com with ESMTPSA id bk14-20020a05620a1a0e00b006ce580c2663sm11581197qkb.35.2023.01.12.14.26.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Jan 2023 14:26:02 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Joel Fernandes <joel@joelfernandes.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v2 rcu/dev 1/2] rcu: Track laziness during boot and suspend
Date:   Thu, 12 Jan 2023 17:25:51 -0500
Message-Id: <E588EAC4-D8F2-4893-A668-816C0C7104B2@joelfernandes.org>
References: <20230112192724.GA3610129@paulmck-ThinkPad-P17-Gen-1>
Cc:     linux-kernel@vger.kernel.org,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        rcu@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        fweisbec@gmail.com, urezki@gmail.com
In-Reply-To: <20230112192724.GA3610129@paulmck-ThinkPad-P17-Gen-1>
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



> On Jan 12, 2023, at 2:27 PM, Paul E. McKenney <paulmck@kernel.org> wrote:
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
>>=20
>> I also booted debian Linux and verified the flag is reset correctly after=
 boot
>> completes. Thanks.
>=20
> After going back and forth a bit, I took these two as-is (aside from
> the usual commit-log wordsmithing).
>=20
> At some point, the state-change-notification from things like boot,
> suspend/resume, sysrq-t, and panic() should probably be refactored.
> But I do not believe that we are yet at that point, and there is not
> much point in half-refactorings in cases such as this one.
>=20
> I added the Fixes tags, and, if testing goes well, I plan to submit
> them into the upcoming merge window.  I have no reason to believe that
> anyone is hitting this, it is only a few weeks away anyhow, and a good
> chunk of that would be consumed by testing and review.
>=20
> And if someone does hit it, we do have your fixes to send to them, so
> thank you for that!
> (These won't become visible on -rcu until I complete today's rebase,
> in case you were wondering.)

Thanks and this sounds good to me. Meanwhile I pulled into our product kerne=
l so all is good.

Thanks,

 - Joel


>=20
>                        Thanx, Paul
>=20
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
