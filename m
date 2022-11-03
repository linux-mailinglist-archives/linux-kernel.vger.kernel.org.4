Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F14586187A1
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 19:36:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230096AbiKCSgj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 14:36:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbiKCSge (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 14:36:34 -0400
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F6F5C29
        for <linux-kernel@vger.kernel.org>; Thu,  3 Nov 2022 11:36:33 -0700 (PDT)
Received: by mail-qv1-xf2a.google.com with SMTP id n18so1715964qvt.11
        for <linux-kernel@vger.kernel.org>; Thu, 03 Nov 2022 11:36:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:from:to:cc:subject:date:message-id
         :reply-to;
        bh=S380dCKKg+A8bwJUTQWjtqzaOyXFXP7JJeY17NUMHEs=;
        b=asnCQKbz6DWupBln1HDqgQERBYic/Pm9wz9FThG1CSb8qOWiTFSvEmXfjKa99bCrzr
         lFRci5S3aBNk/W0a9BWdgW7InK1B8yKgXLpK0sU0+2QSE3am4qIPQFJvo/YTDzMSL/Ul
         d2xHPkqUQiCEPxHHtPufwo5NPvtzuNipmn/p4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S380dCKKg+A8bwJUTQWjtqzaOyXFXP7JJeY17NUMHEs=;
        b=mEfZEhf5I6IcxcxRRTYTKZ6qXCyftrEGUqXvFJCRawIQsr8EsoPBp6EX6CTajPqCEV
         8ubmX7DiJHc4LTrE8LRU5i6aDo8MO/MXKRkTnQE4F/zLCOKmbv1K9ehNbDzysyHdBKTD
         DF8/moB6SSDvtYqQS+QEgtDCHHgftGynWrdze5wC7GuQefg8+TQlRj682Q3hMg57sj30
         w9PXsFphGoojbpChnhCMvMOioH4bKROF/j7EHJipsSAzwM9fRRgeq0Bp1TzT1p8pSh98
         dPX9LONjf4xO1kqTXDJNg1tJLh9L/JItPrmxYv406IMWOtPxESEjAE/1e5/cxB0P0M5Z
         jndA==
X-Gm-Message-State: ACrzQf0TU4ddwsMgiQuK0q2WYdirbkfbVdYPoZ/uTunNbez81Ins4PCr
        tZ1ZM1F4PxBgHFmbbe6yMj1KZQ==
X-Google-Smtp-Source: AMsMyM4u7w/stQ68aks1Ab43yVkPtehYePGVAMOabmDSVp/Q6qrfXEGSPeAEJVHddhzsweSth9H51w==
X-Received: by 2002:ad4:5d41:0:b0:4b8:9fd2:c7e2 with SMTP id jk1-20020ad45d41000000b004b89fd2c7e2mr28669239qvb.91.1667500592421;
        Thu, 03 Nov 2022 11:36:32 -0700 (PDT)
Received: from smtpclient.apple (c-73-148-104-166.hsd1.va.comcast.net. [73.148.104.166])
        by smtp.gmail.com with ESMTPSA id c10-20020ac86e8a000000b003a54a19c550sm947652qtv.57.2022.11.03.11.36.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Nov 2022 11:36:31 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Joel Fernandes <joel@joelfernandes.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH RFC] rcu/kfree: Do not request RCU when not needed
Date:   Thu, 3 Nov 2022 14:36:30 -0400
Message-Id: <ACF5E134-0C17-484B-AF9E-D4E6FAC9535F@joelfernandes.org>
References: <20221103175143.GB5600@paulmck-ThinkPad-P17-Gen-1>
Cc:     Uladzislau Rezki <urezki@gmail.com>, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20221103175143.GB5600@paulmck-ThinkPad-P17-Gen-1>
To:     paulmck@kernel.org
X-Mailer: iPhone Mail (19G82)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Nov 3, 2022, at 1:51 PM, Paul E. McKenney <paulmck@kernel.org> wrote:
>=20
> =EF=BB=BFOn Thu, Nov 03, 2022 at 01:41:43PM +0100, Uladzislau Rezki wrote:=

>>>>>> /**
>>>>>> @@ -3066,10 +3068,12 @@ static void kfree_rcu_work(struct work_struct=
 *work)
>>>>>>   struct kfree_rcu_cpu_work *krwp;
>>>>>>   int i, j;
>>>>>>=20
>>>>>> -    krwp =3D container_of(to_rcu_work(work),
>>>>>> +    krwp =3D container_of(work,
>>>>>>               struct kfree_rcu_cpu_work, rcu_work);
>>>>>>   krcp =3D krwp->krcp;
>>>>>>=20
>>>>>> +    cond_synchronize_rcu(krwp->gp_snap);
>>>>>=20
>>>>> Might this provoke OOMs in case of callback flooding?
>>>>>=20
>>>>> An alternative might be something like this:
>>>>>=20
>>>>>   if (!poll_state_synchronize_rcu(krwp->gp_snap)) {
>>>>>       queue_rcu_work(system_wq, &krwp->rcu_work);
>>>>>       return;
>>>>>   }
>>>>>=20
>>>>> Either way gets you a non-lazy callback in the case where a grace
>>>>> period has not yet elapsed.
>>>>> Or am I missing something that prevents OOMs here?
>>>>=20
>>>> The memory consumptions appears to be much less in his testing with the=
 onslaught of kfree, which makes OOM probably less likely.
>>>>=20
>>>> Though, was your reasoning that in case of a grace period not elapsing,=
 we need a non lazy callback queued, so as to make the reclaim happen sooner=
?
>>>>=20
>>>> If so, the cond_synchronize_rcu() should already be conditionally queue=
ing non-lazy CB since we don=E2=80=99t make synchronous users wait for secon=
ds. Or did I miss something?
>>>=20
>>> My concern is that the synchronize_rcu() will block a kworker kthread
>>> for some time, and that in callback-flood situations this might slow
>>> things down due to exhausting the supply of kworkers.
>>>=20
>> This concern works in both cases. I mean in default configuration and
>> with a posted patch. The reclaim work, which name is kfree_rcu_work() onl=
y
>> does a progress when a gp is passed so the rcu_work_rcufn() can queue
>> our reclaim kworker.
>>=20
>> As it is now:
>>=20
>> 1. Collect pointers, then we decide to drop them we queue the
>>   monitro_work() worker to the system_wq.
>>=20
>> 2. The monitor work, kfree_rcu_work(), tries to attach or saying
>> it by another words bypass a "backlog" to "free" channels.
>>=20
>> 3. It invokes the queue_rcu_work() that does call_rcu_flush() and
>> in its turn it queues our worker from the handler. So the worker
>> is run after GP is passed.
>=20
> So as it is now, we are not tying up a kworker kthread while waiting
> for the grace period, correct?  We instead have an RCU callback queued
> during that time, and the kworker kthread gets involved only after the
> grace period ends.
>=20
>> With a patch:=20
>>=20
>> [1] and [2] steps are the same. But on third step we do:
>>=20
>> 1. Record the GP status for last in channel;
>> 2. Directly queue the drain work without any call_rcu() helpers;
>> 3. On the reclaim worker entry we check if GP is passed;
>> 4. If not it invokes synchronize_rcu().
>=20
> And #4 changes that, by (sometimes) tying up a kworker kthread for the
> full grace period.
>=20
>> The patch eliminates extra steps by not going via RCU-core route
>> instead it directly invokes the reclaim worker where it either
>> proceed or wait a GP if needed.
>=20
> I agree that the use of the polled API could be reducing delays, which
> is a good thing.  Just being my usual greedy self and asking "Why not
> both?", that is use queue_rcu_work() instead of synchronize_rcu() in
> conjunction with the polled APIs so as to avoid both the grace-period
> delay and the tying up of the kworker kthread.
>=20
> Or am I missing something here?

Yeah I am with Paul on this, NAK on =E2=80=9Cblocking in kworker=E2=80=9D in=
stead of =E2=80=9Cchecking for grace period + queuing either regular work or=
 RCU work=E2=80=9D. Note that blocking also adds a pointless and fully avoid=
able scheduler round trip.

 - Joel


>=20
>                            Thanx, Paul
