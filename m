Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90C416755C7
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 14:27:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229761AbjATN1U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 08:27:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229609AbjATN1S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 08:27:18 -0500
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9385EBCE06
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 05:27:16 -0800 (PST)
Received: by mail-qv1-xf30.google.com with SMTP id j9so3873512qvt.0
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 05:27:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Wax/FnCd+G23LzFKL+3+NhjrVkCOoQ9ELrsUrn0rg8A=;
        b=b2ZC/nDwG6t1eXrvvXo23gx4nm1wGk55TTAD8Ee/t8Id3MKJA6ZKVD3JPEAvsDzIj6
         WPLGfi4ODHxWh8XVZ7RNCOQ0mHQ9UC5vQDTIxQYQI533kOXt5y2LujB4NTpI8BJpsKkE
         ao3FZaxTuuf4nF6EVSGvkoyI5dUT9V2n0G56Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Wax/FnCd+G23LzFKL+3+NhjrVkCOoQ9ELrsUrn0rg8A=;
        b=SL+eK2Op5FK+Lm291dQSLCENfbHP51m5Iy2uV8myGhf7zmuo5Siz7UFbaW3c7uVY7l
         VFZYHXtGQEXxkCQW17ZxN4/1tJAlvrxIl0UIl7HqRE1oxPVKM5bijGwonEexHbm8s1Mj
         AsAoi0uxfvIqbTxtlkeWXv1adqkZvh2ARO1iixmoa3CEirf/C3k/20reOKAIBlpJNIBp
         eZBv1aQNkaFsLa2FqnlhlJmNl5mXMfDdd2VzS5WMADKcd58iUrXodkKzb442gZ0ASiEW
         gfGBZkcoEavzAsTZMeC06Ui9KQ3NPRvNX1uC2qMe6Zqg8zDV8jwwV9UvvQ1RZJxYYlt2
         Afkg==
X-Gm-Message-State: AFqh2kqS4GVUKEcIpNU0Uc5G+3e/ggIrn0xZUIJscn6vS8yBW5mOhJmj
        +/w2PWSIQ7liIvTENiyMfaEM+w==
X-Google-Smtp-Source: AMrXdXvdMbeA2DLOpPseOiuOtG1tvir0dVr1//dKps6LH1zCaP7Ha49TgNh6OzKtCVGGM9wD8A8tFA==
X-Received: by 2002:a05:6214:1043:b0:535:a43d:76d0 with SMTP id l3-20020a056214104300b00535a43d76d0mr2848252qvr.11.1674221235554;
        Fri, 20 Jan 2023 05:27:15 -0800 (PST)
Received: from smtpclient.apple (c-98-249-43-138.hsd1.va.comcast.net. [98.249.43.138])
        by smtp.gmail.com with ESMTPSA id y4-20020a05620a44c400b007069375e0f4sm8010615qkp.122.2023.01.20.05.27.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Jan 2023 05:27:14 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Joel Fernandes <joel@joelfernandes.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v3] rcu: Remove impossible wakeup rcu GP kthread action from rcu_report_qs_rdp()
Date:   Fri, 20 Jan 2023 08:27:03 -0500
Message-Id: <B3E458A6-9279-4716-B242-873C77EC1E3A@joelfernandes.org>
References: <PH0PR11MB5880A16045A842AB80A25C4BDAC59@PH0PR11MB5880.namprd11.prod.outlook.com>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>, frederic@kernel.org,
        quic_neeraju@quicinc.com, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <PH0PR11MB5880A16045A842AB80A25C4BDAC59@PH0PR11MB5880.namprd11.prod.outlook.com>
To:     "Zhang, Qiang1" <qiang1.zhang@intel.com>
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



> On Jan 20, 2023, at 3:19 AM, Zhang, Qiang1 <qiang1.zhang@intel.com> wrote:=

>=20
> =EF=BB=BF
>>=20
>>=20
>>>> On Wed, Jan 18, 2023 at 03:30:14PM +0800, Zqiang wrote:
>>>>> When inovke rcu_report_qs_rdp(), if current CPU's rcu_data structure's=
 ->
>>>>> grpmask has not been cleared from the corresponding rcu_node structure=
's
>>>>> ->qsmask, after that will clear and report quiescent state, but in thi=
s
>>>>> time, this also means that current grace period is not end, the curren=
t
>>>>> grace period is ongoing, because the rcu_gp_in_progress() currently re=
turn
>>>>> true, so for non-offloaded rdp, invoke rcu_accelerate_cbs() is impossi=
ble
>>>>> to return true.
>>>>>=20
>>>>> This commit therefore remove impossible rcu_gp_kthread_wake() calling.=

>>>>>=20
>>>>> Signed-off-by: Zqiang <qiang1.zhang@intel.com>
>>>>> Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
>>>=20
>>> Queued (wordsmithed as shown below, as always, please check) for further=

>>> testing and review, thank you both!
>>>=20
>>>                                                      Thanx, Paul
>>>=20
>>> ------------------------------------------------------------------------=

>>>=20
>>> commit fbe3e300ec8b3edd2b8f84dab4dc98947cf71eb8
>>> Author: Zqiang <qiang1.zhang@intel.com>
>>> Date:   Wed Jan 18 15:30:14 2023 +0800
>>>=20
>>>    rcu: Remove never-set needwake assignment from rcu_report_qs_rdp()
>>>=20
>>>    The rcu_accelerate_cbs() function is invoked by rcu_report_qs_rdp()
>>>    only if there is a grace period in progress that is still blocked
>>>    by at least one CPU on this rcu_node structure.  This means that
>>>    rcu_accelerate_cbs() should never return the value true, and thus tha=
t
>>>    this function should never set the needwake variable and in turn neve=
r
>>>    invoke rcu_gp_kthread_wake().
>>>=20
>>>    This commit therefore removes the needwake variable and the invocatio=
n
>>>    of rcu_gp_kthread_wake() in favor of a WARN_ON_ONCE() on the call to
>>>    rcu_accelerate_cbs().  The purpose of this new WARN_ON_ONCE() is to
>>>    detect situations where the system's opinion differs from ours.
>>>=20
>>>    Signed-off-by: Zqiang <qiang1.zhang@intel.com>
>>>    Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
>>>    Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
>>>=20
>>> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
>>> index b2c2045294780..7a3085ad0a7df 100644
>>> --- a/kernel/rcu/tree.c
>>> +++ b/kernel/rcu/tree.c
>>> @@ -1956,7 +1956,6 @@ rcu_report_qs_rdp(struct rcu_data *rdp)
>>> {
>>>      unsigned long flags;
>>>      unsigned long mask;
>>> -     bool needwake =3D false;
>>>      bool needacc =3D false;
>>>      struct rcu_node *rnp;
>>>=20
>>> @@ -1988,7 +1987,12 @@ rcu_report_qs_rdp(struct rcu_data *rdp)
>>>               * NOCB kthreads have their own way to deal with that...
>>>               */
>>>              if (!rcu_rdp_is_offloaded(rdp)) {
>>> -                     needwake =3D rcu_accelerate_cbs(rnp, rdp);
>>> +                     /*
>>> +                      * The current GP has not yet ended, so it
>>> +                      * should not be possible for rcu_accelerate_cbs()=

>>> +                      * to return true.  So complain, but don't awaken.=

>>> +                      */
>>> +                     WARN_ON_ONCE(rcu_accelerate_cbs(rnp, rdp));
>>>              } else if (!rcu_segcblist_completely_offloaded(&rdp->cblist=
)) {
>>>                      /*
>>>                       * ...but NOCB kthreads may miss or delay callbacks=
 acceleration
>>> @@ -2000,8 +2004,6 @@ rcu_report_qs_rdp(struct rcu_data *rdp)
>>>              rcu_disable_urgency_upon_qs(rdp);
>>>              rcu_report_qs_rnp(mask, rnp, rnp->gp_seq, flags);
>>>              /* ^^^ Released rnp->lock */
>>> -             if (needwake)
>>> -                     rcu_gp_kthread_wake();
>>>=20
>>> AFAICS, there is almost no compiler benefit of doing this, and zero runt=
ime
>>> benefit of doing this. The WARN_ON_ONCE() also involves a runtime condit=
ion
>>> check of the return value of rcu_accelerate_cbs(), so you still have a
>>> branch. Yes, maybe slightly smaller code without the wake call, but I'm n=
ot
>>> sure that is worth it.
>>>=20
>>> And, if the opinion of system differs, its a bug anyway, so more added r=
isk.
>>>=20
>>>=20
>>>=20
>>>              if (needacc) {
>>>                      rcu_nocb_lock_irqsave(rdp, flags);
>>>=20
>>> And when needacc =3D true, rcu_accelerate_cbs_unlocked() tries to do a w=
ake up
>>> anyway, so it is consistent with nocb vs !nocb.
>>=20
>> For !nocb, we invoked rcu_accelerate_cbs() before report qs,  so this GP i=
s impossible to end
>> and we also not set RCU_GP_FLAG_INIT to start new GP in rcu_accelerate_cb=
s().
>> but for nocb, when needacc =3D true, we invoke rcu_accelerate_cbs_unlocke=
d() after current CPU
>> has reported qs,  if all CPU have been reported qs,  we will wakeup gp kt=
hread to end this GP in
>> rcu_report_qs_rnp().   after that, the rcu_accelerate_cbs_unlocked() is  p=
ossible to try to wake up
>> gp kthread if this GP has ended at this time.   so nocb vs !nocb is likel=
y to be inconsistent.
>>=20
>>=20
>> That is a fair point. But after gp ends,  rcu_check_quiescent_state()
>> -> note_gp_changes() which will do a accel + GP thread wake up at that
>> point anyway, once it notices that a GP has come to an end. That
>> should happen for both the nocb and !nocb cases right?
>=20
> For nocb rdp, we won't invoke rcu_accelerate_cbs() and rcu_advance_cbs() i=
n
> note_gp_changes().  so also not wakeup gp kthread in note_gp_changes().=20=


Yes correct, ok but=E2=80=A6
>=20
>>=20
>> I am wondering if rcu_report_qs_rdp() needs to be rethought to make
>> both cases consistent.
>>=20
>> Why does the nocb case need an accel + GP thread wakeup in the
>> rcu_report_qs_rdp() function, but the !nocb case does not?
>=20
> For nocb accel + GP kthread wakeup only happen in the middle of a (de-)off=
loading process.
> this is an intermediate state.

Sure, I know what the code currently does, I am asking why and it feels wron=
g.

I suggest you slightly change your approach to not assuming the code should b=
e bonafide correct and then fixing it (which is ok once in a while), and ask=
ing higher level questions to why things are the way they are in the first p=
lace (that is just my suggestion and I am not in a place to provide advice, f=
ar from it, but I am just telling you my approach =E2=80=94 I care more abou=
t the code than increasing my patch count :P).

If you are in an intermediate state, part way to a !nocb state =E2=80=94 you=
 may have missed a nocb-related accel and wake, correct? Why does that matte=
r? Once we transition to a !nocb state, we do not do a post-qs-report accel+=
wake anyway as we clearly know from the discussion. So why do we need to do i=
t if we missed it for the intermediate stage? So, I am not fully sure yet wh=
at that needac is doing and why it is needed.

Do not get me wrong, stellar work here. But I suggest challenge the assumpti=
ons and the design, not always just the code that was already written :), ap=
ologies for any misplaced or noisy advice.

Thanks!

 - Joel


>   =20
> Thanks
> Zqiang
>=20
>>=20
>> (I am out of office till Monday but will intermittently (maybe) check
>> in, RCU is one of those things that daydreaming tends to lend itself
>> to...)
>>=20
>> - Joel
