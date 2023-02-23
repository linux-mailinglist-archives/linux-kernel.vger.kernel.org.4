Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CF606A0E44
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 17:58:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229505AbjBWQ6K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 11:58:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbjBWQ6I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 11:58:08 -0500
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1566B1EBC1
        for <linux-kernel@vger.kernel.org>; Thu, 23 Feb 2023 08:58:07 -0800 (PST)
Received: by mail-qt1-x831.google.com with SMTP id s12so11519659qtq.11
        for <linux-kernel@vger.kernel.org>; Thu, 23 Feb 2023 08:58:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:from:to:cc:subject:date:message-id
         :reply-to;
        bh=letdnKFIOPJEXHSrBGJ6vtigHfJzPCWiA2KxFKE2bVs=;
        b=eB8kMfMLPBAnAP7HWLvbMd+p7FoAuYOGMotIbSXku27qY5b+ltUzXIH1MdLY+9gmfl
         obRNwkawQhEG7uJCZobRXN8m9fLxJINwdemyQkms3Wi+NqVe9+iUi2EVjx9VkKpQCJdn
         0M/YEzULYUXr/eeZxhJkuS6WFUgCqK2JXzm4s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=letdnKFIOPJEXHSrBGJ6vtigHfJzPCWiA2KxFKE2bVs=;
        b=s7jlZrDldmDO02zED//+5F2MPG7lCPg4JfbDmje6oUVS/ONajmZ/XY4aXejfNMdqQm
         h26TJ7HDt7UVBNDnfuE5BbFFgOeW6helOWEYh85FybS2U8vv9CYMN0kJ8EpL3C3ssoi1
         XhDoy2h2Eicoya/3qjv3D+foSHxeKPKzB8TrMxsbCGx2z6rgChLNLroKCyqqEM84feaC
         332FS7IXDlhmPGejtXIL5nt9PdDWjE1eGKErBdeyACI7DNolfmApIr36RWxHBNRE9P8a
         lakIE55Ggy59EpGL9oSP+HBA3qUqYAfqPTmpar8oxpWqH62qJaWWSNtcFxVhDdeglKVU
         W0hA==
X-Gm-Message-State: AO0yUKWj/IMPho9X1GHRp1aKP6bTGi2YTRvKyHH48XCAqzXM6lGffk6E
        G4bjw5K6tekwwMBVPXlQfNeBCnlbJBXyF7Pu
X-Google-Smtp-Source: AK7set/dOa8VCz2TxH1eRhk9X+y+qezkFvFIQLtRv9ESUJaadfJbyzwzgrouoJ5CLXaPXKN++RFRIw==
X-Received: by 2002:a05:622a:654:b0:3b8:6c10:f52 with SMTP id a20-20020a05622a065400b003b86c100f52mr19807868qtb.46.1677171486077;
        Thu, 23 Feb 2023 08:58:06 -0800 (PST)
Received: from smtpclient.apple (c-98-249-43-138.hsd1.va.comcast.net. [98.249.43.138])
        by smtp.gmail.com with ESMTPSA id a126-20020ae9e884000000b0073b6a06911asm3703741qkg.95.2023.02.23.08.58.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Feb 2023 08:58:05 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Joel Fernandes <joel@joelfernandes.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH] rcu-tasks: Directly invoke rcuwait_wake_up() in call_rcu_tasks_generic()
Date:   Thu, 23 Feb 2023 11:57:54 -0500
Message-Id: <258C736B-5957-4874-9CD8-BBC1E321A092@joelfernandes.org>
References: <Y/eP4h/chB8J0rAj@google.com>
Cc:     "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>, paulmck@kernel.org,
        frederic@kernel.org, quic_neeraju@quicinc.com, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <Y/eP4h/chB8J0rAj@google.com>
To:     "Zhang, Qiang1" <qiang1.zhang@intel.com>
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



> On Feb 23, 2023, at 11:10 AM, Joel Fernandes <joel@joelfernandes.org> wrot=
e:
>=20
> =EF=BB=BFOn Thu, Feb 23, 2023 at 08:43:05AM +0000, Zhang, Qiang1 wrote:
>>> From: Zqiang <qiang1.zhang@intel.com>
>>> Sent: Thursday, February 23, 2023 2:30 PM
>>> To: paulmck@kernel.org; frederic@kernel.org; quic_neeraju@quicinc.com;
>>> joel@joelfernandes.org
>>> Cc: rcu@vger.kernel.org; linux-kernel@vger.kernel.org
>>> Subject: [PATCH] rcu-tasks: Directly invoke rcuwait_wake_up() in
>>> call_rcu_tasks_generic()
>>>=20
>>> According to commit '3063b33a347c ("Avoid raw-spinlocked wakeups from
>>> call_rcu_tasks_generic()")', the grace-period kthread is delayed to wake=
up
>>> using irq_work_queue() is because if the caller of
>>> call_rcu_tasks_generic() holds a raw spinlock, when the kernel is built w=
ith
>>> CONFIG_PROVE_RAW_LOCK_NESTING=3Dy, due to a spinlock will be hold in
>>> wake_up(), so the lockdep splats will happen. but now using
>>> rcuwait_wake_up() to wakeup grace-period kthread instead of wake_up(), i=
n
>>> rcuwait_wake_up() no spinlock will be acquired, so this commit remove us=
ing
>>>=20
>>> There are still spinlock-acquisition and spinlock-release invocations wi=
thin the call path from rcuwait_wake_up().
>>>=20
>>> rcuwait_wake_up() -> wake_up_process() -> try_to_wake_up(), then:
>>>=20
>>>   raw_spin_lock_irqsave()
>>>   ...
>>>   raw_spin_unlock_irqrestore
>>=20
>> Yes, but this is raw_spinlock acquisition and release(note: spinlock will=
 convert to
>> sleepable lock in Preempt-RT kernel, but raw spinlock is not change).
>>=20
>> acquire raw_spinlock -> acquire spinlock  will trigger lockdep warning.
>=20
> Is this really safe in the long run though? I seem to remember there are
> weird locking dependencies if RCU is used from within the scheduler [1].
>=20
> I prefer to keep it as irq_work_queue() unless you are seeing some benefit=
.
> Generally, there has to be a 'win' or other justification for adding more
> risk.

On second thought, you are deleting a decent number of lines.

What do others think?

I will take a closer look later, I am interested in researching the new lock=
 dependency this adds.

 - Joel

>=20
> thanks,
>=20
> - Joel
> [1] http://www.joelfernandes.org/rcu/scheduler/locking/2019/09/02/rcu-sche=
dlocks.html
>=20
>>> irq_work_queue(), invoke rcuwait_wake_up() directly in
>>> call_rcu_tasks_generic().
>>>=20
>>> Signed-off-by: Zqiang <qiang1.zhang@intel.com>
>>> ---
>>> kernel/rcu/tasks.h | 16 +---------------
>>> 1 file changed, 1 insertion(+), 15 deletions(-)
>>>=20
>>> diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h index
>>> baf7ec178155..757b8c6da1ad 100644
>>> --- a/kernel/rcu/tasks.h
>>> +++ b/kernel/rcu/tasks.h
>>> @@ -39,7 +39,6 @@ struct rcu_tasks_percpu {
>>>    unsigned long rtp_jiffies;
>>>    unsigned long rtp_n_lock_retries;
>>>    struct work_struct rtp_work;
>>> -    struct irq_work rtp_irq_work;
>>>    struct rcu_head barrier_q_head;
>>>    struct list_head rtp_blkd_tasks;
>>>    int cpu;
>>> @@ -112,12 +111,9 @@ struct rcu_tasks {
>>>    char *kname;
>>> };
>>>=20
>>> -static void call_rcu_tasks_iw_wakeup(struct irq_work *iwp);
>>> -
>>> #define DEFINE_RCU_TASKS(rt_name, gp, call, n)
>>>            \
>>> static DEFINE_PER_CPU(struct rcu_tasks_percpu, rt_name ## __percpu) =3D {=

>>>            \
>>>    .lock =3D __RAW_SPIN_LOCK_UNLOCKED(rt_name ##
>>> __percpu.cbs_pcpu_lock),        \
>>> -    .rtp_irq_work =3D IRQ_WORK_INIT_HARD(call_rcu_tasks_iw_wakeup),
>>>            \
>>> };
>>>        \
>>> static struct rcu_tasks rt_name =3D
>>>        \
>>> {
>>>        \
>>> @@ -273,16 +269,6 @@ static void cblist_init_generic(struct rcu_tasks *r=
tp)
>>>    pr_info("%s: Setting shift to %d and lim to %d.\n", __func__,
>>> data_race(rtp->percpu_enqueue_shift), data_race(rtp-
>>>> percpu_enqueue_lim));
>>> }
>>>=20
>>> -// IRQ-work handler that does deferred wakeup for call_rcu_tasks_generi=
c().
>>> -static void call_rcu_tasks_iw_wakeup(struct irq_work *iwp) -{
>>> -    struct rcu_tasks *rtp;
>>> -    struct rcu_tasks_percpu *rtpcp =3D container_of(iwp, struct
>>> rcu_tasks_percpu, rtp_irq_work);
>>> -
>>> -    rtp =3D rtpcp->rtpp;
>>> -    rcuwait_wake_up(&rtp->cbs_wait);
>>> -}
>>> -
>>> // Enqueue a callback for the specified flavor of Tasks RCU.
>>> static void call_rcu_tasks_generic(struct rcu_head *rhp, rcu_callback_t f=
unc,
>>>                   struct rcu_tasks *rtp)
>>> @@ -334,7 +320,7 @@ static void call_rcu_tasks_generic(struct rcu_head
>>> *rhp, rcu_callback_t func,
>>>    rcu_read_unlock();
>>>    /* We can't create the thread unless interrupts are enabled. */
>>>    if (needwake && READ_ONCE(rtp->kthread_ptr))
>>> -        irq_work_queue(&rtpcp->rtp_irq_work);
>>> +        rcuwait_wake_up(&rtp->cbs_wait);
>>> }
>>>=20
>>> // RCU callback function for rcu_barrier_tasks_generic().
>>> --
>>> 2.25.1
>>=20
