Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98792611FC3
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Oct 2022 05:31:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229716AbiJ2Db0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 23:31:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229726AbiJ2DbS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 23:31:18 -0400
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4665FC7077
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 20:31:16 -0700 (PDT)
Received: by mail-qk1-x729.google.com with SMTP id l9so4674259qkk.11
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 20:31:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EF1zpD5BOyTq7o1Q088kDG9r4IK1Pn2H8NFlWhQILKc=;
        b=qZgKYsRzd3kTkgl8c4QnZxvvDIz6nEe5+wFXsvekvEKHq0TyOa3Nw3MtADg0clXY5L
         QeLh9HF2NmFT7A6G5DE4r4o8SBSpMWHILqvTjgd6Fsyqv+yeERAKye7+NWMPM/TO97pG
         sq7u47qbpIW3Q2VqjbuCcmnGCkUuQCvZ+/zHk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EF1zpD5BOyTq7o1Q088kDG9r4IK1Pn2H8NFlWhQILKc=;
        b=eGp4DlJ1wCSVlU2dS7sML8MURW2XM2mbuMSzzCMbEWNdtOMslSZECd7kKVm/nRLPhl
         GnkvHk+1pbUWwzeiiOKP0MVkKEl1DPt4T8pj1b/qS9cnCVPYtMR9QYaASTZFKJDMYg6l
         MyEKaUD5abMhlMlRCYqUWNSvCRgDkllW00w5NVoI7vEYaYQMS851X1gQ1zB5H0G1qVEu
         xIup9dlMAzP+zCOt/kBF1rNdgF6QrbXOO0NTuQYUbMzskuA6cpNzspIhJxxEMgj4MfwH
         jqDs9m7cTJS6RFANxGtQNmE5MtqWngqHexqgcD73MGS9WPXgFNo0DKEJVrLy2MA8L4vS
         38GA==
X-Gm-Message-State: ACrzQf0xUNrvvtKrkIj/lCq3zzsFUs9nPsFgLYr5Yv0D1HEeMBHCgpYT
        vtZuhdH52JzI+OBR5RtpjioZEg==
X-Google-Smtp-Source: AMsMyM56T3TVc0urjlevQBeo43mGWmFeDDERgmVQRRT5xnpBfaCCzmxTk4NrMLjPuFRWmVmzPI8WOA==
X-Received: by 2002:a05:620a:9d5:b0:6fa:d03:aa03 with SMTP id y21-20020a05620a09d500b006fa0d03aa03mr1815473qky.453.1667014275370;
        Fri, 28 Oct 2022 20:31:15 -0700 (PDT)
Received: from smtpclient.apple ([2600:1003:b137:2fbb:f416:6248:fd9f:d1bb])
        by smtp.gmail.com with ESMTPSA id y27-20020a37f61b000000b006b8e8c657ccsm292380qkj.117.2022.10.28.20.31.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Oct 2022 20:31:14 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Joel Fernandes <joel@joelfernandes.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [RFC PATCH 07/11] sched: Add proxy execution
Date:   Fri, 28 Oct 2022 23:31:13 -0400
Message-Id: <34B2D8B9-A0C1-4280-944D-17224FB24339@joelfernandes.org>
References: <dab347c1-3724-8ac6-c051-9d2caea20101@arm.com>
Cc:     Connor O'Brien <connoro@google.com>, linux-kernel@vger.kernel.org,
        kernel-team@android.com, John Stultz <jstultz@google.com>,
        Joel Fernandes <joelaf@google.com>,
        Qais Yousef <qais.yousef@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>
In-Reply-To: <dab347c1-3724-8ac6-c051-9d2caea20101@arm.com>
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>
X-Mailer: iPhone Mail (19G82)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Dietmar,

> On Oct 24, 2022, at 6:13 AM, Dietmar Eggemann <dietmar.eggemann@arm.com> w=
rote:
>=20
> =EF=BB=BFOn 03/10/2022 23:44, Connor O'Brien wrote:
>> From: Peter Zijlstra <peterz@infradead.org>
>=20
> [...]
>=20
>> + * Returns the task that is going to be used as execution context (the o=
ne
>> + * that is actually going to be put to run on cpu_of(rq)).
>> + */
>> +static struct task_struct *
>> +proxy(struct rq *rq, struct task_struct *next, struct rq_flags *rf)
>> +{
>=20
> [...]
>=20
>> +migrate_task:
>=20
> [...]
>=20
>> +    /*
>> +     * Since we're going to drop @rq, we have to put(@next) first,
>> +     * otherwise we have a reference that no longer belongs to us.  Use
>> +     * @fake_task to fill the void and make the next pick_next_task()
>           ^^^^^^^^^^
>=20
> There was a `static struct task_struct fake_task` in
> https://lkml.kernel.org/r/20181009092434.26221-6-juri.lelli@redhat.com
> but now IMHO we use `rq->idle` <-- (1)

Ok.

>> +     * invocation happy.
>> +     *
>> +     * XXX double, triple think about this.
>> +     * XXX put doesn't work with ON_RQ_MIGRATE
>> +     *
>> +     * CPU0                CPU1
>> +     *
>> +     *                B mutex_lock(X)
>> +     *
>> +     * A mutex_lock(X) <- B
>> +     * A __schedule()
>> +     * A pick->A
>> +     * A proxy->B
>> +     * A migrate A to CPU1
>> +     *                B mutex_unlock(X) -> A
>> +     *                B __schedule()
>> +     *                B pick->A
>> +     *                B switch_to (A)
>> +     *                A ... does stuff
>> +     * A ... is still running here
>> +     *
>> +     *        * BOOM *
>> +     */
>> +    put_prev_task(rq, next);
>> +    if (curr_in_chain) {
>> +        rq->proxy =3D rq->idle;
>> +        set_tsk_need_resched(rq->idle);
>> +        /*
>> +         * XXX [juril] don't we still need to migrate @next to
>> +         * @owner's CPU?
>> +         */
>> +        return rq->idle;
>> +    }
>=20
> --> (1)

Sorry but what has this got to do with your comment below?

>> +    rq->proxy =3D rq->idle;
>> +
>> +    for (; p; p =3D p->blocked_proxy) {
>> +        int wake_cpu =3D p->wake_cpu;
>> +
>> +        WARN_ON(p =3D=3D rq->curr);
>> +
>> +        deactivate_task(rq, p, 0);
>> +        set_task_cpu(p, that_cpu);
>> +        /*
>> +         * We can abuse blocked_entry to migrate the thing, because @p i=
s
>> +         * still on the rq.
>> +         */
>> +        list_add(&p->blocked_entry, &migrate_list);
>> +
>> +        /*
>> +         * Preserve p->wake_cpu, such that we can tell where it
>> +         * used to run later.
>> +         */
>> +        p->wake_cpu =3D wake_cpu;
>> +    }
>> +
>> +    rq_unpin_lock(rq, rf);
>> +    raw_spin_rq_unlock(rq);
>=20
> Don't we run into rq_pin_lock()'s:
>=20
> SCHED_WARN_ON(rq->balance_callback && rq->balance_callback !=3D
> &balance_push_callback)
>=20
> by releasing rq lock between queue_balance_callback(, push_rt/dl_tasks)
> and __balance_callbacks()?

Apologies, I=E2=80=99m a bit lost here. The code you are responding to inlin=
e does not call rq_pin_lock, it calls rq_unpin_lock.  So what scenario does t=
he warning trigger according to you?

Thanks,

- Joel=20


>=20
> [...]
