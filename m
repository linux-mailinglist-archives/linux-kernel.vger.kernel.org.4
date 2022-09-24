Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C8055E906E
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Sep 2022 01:28:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234069AbiIXX2Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Sep 2022 19:28:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233535AbiIXX2T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Sep 2022 19:28:19 -0400
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7EC7474FE
        for <linux-kernel@vger.kernel.org>; Sat, 24 Sep 2022 16:28:18 -0700 (PDT)
Received: by mail-qv1-xf30.google.com with SMTP id c6so2261256qvn.6
        for <linux-kernel@vger.kernel.org>; Sat, 24 Sep 2022 16:28:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:from:to:cc:subject:date;
        bh=OhH30xzwA4dmz340BVUkylIq/5//Pt8HpJ0yMHqpHUA=;
        b=DPaAM66mjM+JGEaO0sq92daxkcYM0tS4ttLW06nPi47nlaRbqu5JPPyMaOck2U/iu8
         o97yRw80nMtMQDHcJjb/N7+XX4iBvttO1011GpEYVMJj+kdasSj27bFnpZCvF+YT5sJK
         a9muK4I7wjGZL8VI/tHk1WqMPdEMF7FXN5kdo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:x-gm-message-state:from:to:cc
         :subject:date;
        bh=OhH30xzwA4dmz340BVUkylIq/5//Pt8HpJ0yMHqpHUA=;
        b=Sgy3/fcuS1pL5Yb0xfK1Q9JakFKgL0mWMJFc2l/AIcQ5szA08kp3UUxF8qSaF1Ow9K
         XCN0E5z4J/iJGEQp27CEBvCKtLHH9xP2zlszLmmjVMLUb7lGKbgNybf5RQlnsDDqdi9H
         iYXIJc/+5jHHNnQEFYGV8gBEr3vfhxUxI0hFPjoIBYf1yXzRW66063dEWuAu7Y7SMlO/
         NCd8WRyQtPyPSRF0r2A9ogRfDBewO2Fq9VOttLpVEZb06quSxPsIvibyyf6e3lggNXDi
         BN5Er1fjH155elp7Ka/Wr+wVsA6/a8SG2bbEeGiYWtRLCpuh1t1K6lgdp7AQM+mb98sq
         CRyw==
X-Gm-Message-State: ACrzQf3lmJaoLzVZ3ZJEr2pLpYflkCBSn8XYnb8fd/3LeCYXV/TWAt0v
        tnOTdOAHvjArBRsDYWwFx0RYEK69iebsUOYtL+A=
X-Google-Smtp-Source: AMsMyM4Dy9vBZHLKd593zq563DCXiSEGGIltB+0yYKgk+TWcNFMTh1KWwfjZCNhyqSJIDOGhciBt/Q==
X-Received: by 2002:a05:6214:2686:b0:4af:630c:78f2 with SMTP id gm6-20020a056214268600b004af630c78f2mr2201673qvb.52.1664062097575;
        Sat, 24 Sep 2022 16:28:17 -0700 (PDT)
Received: from smtpclient.apple (c-73-148-104-166.hsd1.va.comcast.net. [73.148.104.166])
        by smtp.gmail.com with ESMTPSA id o1-20020a05622a008100b003431446588fsm8711259qtw.5.2022.09.24.16.28.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 24 Sep 2022 16:28:17 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Joel Fernandes <joel@joelfernandes.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v6 1/4] rcu: Make call_rcu() lazy to save power
Date:   Sat, 24 Sep 2022 19:28:16 -0400
Message-Id: <19217A4C-7183-4D78-A714-FBFE7BB20742@joelfernandes.org>
References: <20220924224637.GA161871@lothringen>
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        rushikesh.s.kadam@intel.com, urezki@gmail.com,
        neeraj.iitr10@gmail.com, paulmck@kernel.org, rostedt@goodmis.org
In-Reply-To: <20220924224637.GA161871@lothringen>
To:     Frederic Weisbecker <frederic@kernel.org>
X-Mailer: iPhone Mail (19G82)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Frederic, thanks for the response, replies
below courtesy fruit company=E2=80=99s device:

> On Sep 24, 2022, at 6:46 PM, Frederic Weisbecker <frederic@kernel.org> wro=
te:
>=20
> =EF=BB=BFOn Thu, Sep 22, 2022 at 10:01:01PM +0000, Joel Fernandes (Google)=
 wrote:
>> @@ -3902,7 +3939,11 @@ static void rcu_barrier_entrain(struct rcu_data *r=
dp)
>>    rdp->barrier_head.func =3D rcu_barrier_callback;
>>    debug_rcu_head_queue(&rdp->barrier_head);
>>    rcu_nocb_lock(rdp);
>> -    WARN_ON_ONCE(!rcu_nocb_flush_bypass(rdp, NULL, jiffies));
>> +    /*
>> +     * Flush the bypass list, but also wake up the GP thread as otherwis=
e
>> +     * bypass/lazy CBs maynot be noticed, and can cause real long delays=
!
>> +     */
>> +    WARN_ON_ONCE(!rcu_nocb_flush_bypass(rdp, NULL, jiffies, FLUSH_BP_WAK=
E));
>=20
> This fixes an issue that goes beyond lazy implementation. It should be don=
e
> in a separate patch, handling rcu_segcblist_entrain() as well, with "Fixes=
: " tag.

I wanted to do that, however on discussion with
Paul I thought of making this optimization only for
all lazy bypass CBs. That makes it directly related
this patch since the laziness notion is first
introduced here. On the other hand I could make
this change in a later patch since we are not
super bisectable anyway courtesy of the last
patch (which is not really an issue if the CONFIG
is kept off during someone=E2=80=99s bisection.

> And then FLUSH_BP_WAKE is probably not needed anymore.=20

It is needed as the API is in tree_nocb.h and we
have to have that handle the details of laziness
there rather than tree.c. We could add new apis
to get rid of flag but it=E2=80=99s cleaner (and Paul seemed
to be ok with it).

>>    if (rcu_segcblist_entrain(&rdp->cblist, &rdp->barrier_head)) {
>>        atomic_inc(&rcu_state.barrier_cpu_count);
>>    } else {
>> @@ -269,10 +294,14 @@ static void wake_nocb_gp_defer(struct rcu_data *rdp=
, int waketype,
>>    raw_spin_lock_irqsave(&rdp_gp->nocb_gp_lock, flags);
>>=20
>>    /*
>> -     * Bypass wakeup overrides previous deferments. In case
>> -     * of callback storm, no need to wake up too early.
>> +     * Bypass wakeup overrides previous deferments. In case of
>> +     * callback storm, no need to wake up too early.
>>     */
>> -    if (waketype =3D=3D RCU_NOCB_WAKE_BYPASS) {
>> +    if (waketype =3D=3D RCU_NOCB_WAKE_LAZY
>> +        && READ_ONCE(rdp->nocb_defer_wakeup) =3D=3D RCU_NOCB_WAKE_NOT) {=

>=20
> This can be a plain READ since ->nocb_defer_wakeup is only written under -=
>nocb_gp_lock.

Yes makes sense, will do.

>> +        mod_timer(&rdp_gp->nocb_timer, jiffies + jiffies_till_flush);
>> +        WRITE_ONCE(rdp_gp->nocb_defer_wakeup, waketype);
>> +    } else if (waketype =3D=3D RCU_NOCB_WAKE_BYPASS) {
>>        mod_timer(&rdp_gp->nocb_timer, jiffies + 2);
>>        WRITE_ONCE(rdp_gp->nocb_defer_wakeup, waketype);
>>    } else {
>> @@ -512,9 +598,16 @@ static void __call_rcu_nocb_wake(struct rcu_data *rd=
p, bool was_alldone,
>>    }
>>    // Need to actually to a wakeup.
>>    len =3D rcu_segcblist_n_cbs(&rdp->cblist);
>> +    bypass_len =3D rcu_cblist_n_cbs(&rdp->nocb_bypass);
>> +    lazy_len =3D READ_ONCE(rdp->lazy_len);
>>    if (was_alldone) {
>>        rdp->qlen_last_fqs_check =3D len;
>> -        if (!irqs_disabled_flags(flags)) {
>> +        // Only lazy CBs in bypass list
>> +        if (lazy_len && bypass_len =3D=3D lazy_len) {
>> +            rcu_nocb_unlock_irqrestore(rdp, flags);
>> +            wake_nocb_gp_defer(rdp, RCU_NOCB_WAKE_LAZY,
>> +                       TPS("WakeLazy"));
>=20
> I'm trying to think of a case where rcu_nocb_try_bypass() returns false
> (queue to regular list) but then call_rcu() -> __call_rcu_nocb_wake() ends=
 up
> seeing a lazy bypass queue even though we are queueing a non-lazy callback=

> (should have flushed in this case).
>=20
> Looks like it shouldn't happen, even with concurrent (de-offloading) but j=
ust
> in case, can we add:

Yes I also feel this couldn=E2=80=99t happen because irq is
off and nocb lock is held throughout the calls to
the above 2 functions. Unless I missed the race
you=E2=80=99re describing?

>=20
>      WARN_ON_ONCE(lazy_len !=3D len)

But this condition can be true even in normal
circumstances? len also contains DONE CBs
which are ready to be invoked. Or did I miss
something?

Thanks,

  - Joel

>=20
>> +        } else if (!irqs_disabled_flags(flags)) {
>>            /* ... if queue was empty ... */
>>            rcu_nocb_unlock_irqrestore(rdp, flags);
>>            wake_nocb_gp(rdp, false);
>=20
> Thanks.
