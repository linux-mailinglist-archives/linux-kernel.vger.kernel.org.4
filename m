Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F1185EB5DD
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 01:37:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231339AbiIZXhx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 19:37:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231327AbiIZXhr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 19:37:47 -0400
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC87C88A2C
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 16:37:43 -0700 (PDT)
Received: by mail-qk1-x72f.google.com with SMTP id i17so2145002qkk.12
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 16:37:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:from:to:cc:subject:date;
        bh=GqDCGb2G8T9ccJAeYumKjy8OgsbpycnkZ9b+Bmb6pxw=;
        b=S9aMHTplkZNJpIHqtMfid0tls0+WS91Hcg7HoUIedGbdwp/KpnUiQeiQJUpsaxo2YJ
         VCjEFnVvIcRFOWUvv98Ijy+fQlW7b6bTJYi0b6pEjpZX32I9f07/wSNtrMTRv7ei27ir
         YFoLZ+x4oMe9EtwvwYHWQ8WfJ5h7duIjWVTqI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:x-gm-message-state:from:to:cc
         :subject:date;
        bh=GqDCGb2G8T9ccJAeYumKjy8OgsbpycnkZ9b+Bmb6pxw=;
        b=yXjn4FT0pogbsWHPICuzacIOVvxKIiqu34ByUeN/NsDoZpUtiSK1JQcF1jAXokZvIj
         mJIHXUymJFxJWxza50oEt3a6fu+oLAZySij0dauBFxMgMsK++OCg1Lvf/8nC3EQFhzdC
         wPhWxNA9ThfsxEiWgTYegnGouxgb1kesKnZks2yMY8BnizkVtiGCV3UGN8sqECcoLuSh
         CFdekC4rTeUudkGerDRGtDZb4ZtPFN/kwZ2bXY3zr41D0uYL8hTrrlUxwB1cPbomD95e
         vgBVBfvdk9KJgOJFYsLl/ayvspBwSuU9Gslaoe4sKSiY/yhorzoR/NADyNQn49HRC4Js
         J2kA==
X-Gm-Message-State: ACrzQf3Q9QV8UyTw8fRTpJkuGIkrDIF5C7YRDpzl0IjK0RfuFBKT2e6l
        ZPmstFhtbcXRj8FNoA1agGueRG+9+4cpRP9o
X-Google-Smtp-Source: AMsMyM5xjtIuxPYMxl+6nXv0OVdgpvH+lt4moiZMO+DvUC1jXJtoiImsZbevc6qum8b7zR9G6VhoLQ==
X-Received: by 2002:ae9:df42:0:b0:6ce:8dd2:bc48 with SMTP id t63-20020ae9df42000000b006ce8dd2bc48mr15412686qkf.217.1664235462430;
        Mon, 26 Sep 2022 16:37:42 -0700 (PDT)
Received: from smtpclient.apple ([2600:1003:b132:37f:2047:987d:1b5f:cf31])
        by smtp.gmail.com with ESMTPSA id fc11-20020a05622a488b00b003435bb7fe9csm11591900qtb.78.2022.09.26.16.37.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Sep 2022 16:37:41 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Joel Fernandes <joel@joelfernandes.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v6 1/4] rcu: Make call_rcu() lazy to save power
Date:   Mon, 26 Sep 2022 19:37:41 -0400
Message-Id: <D95D227C-1B30-41CC-9FA9-3B44B32838A3@joelfernandes.org>
References: <20220926173357.GN4196@paulmck-ThinkPad-P17-Gen-1>
Cc:     Frederic Weisbecker <frederic@kernel.org>, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org, rushikesh.s.kadam@intel.com,
        urezki@gmail.com, neeraj.iitr10@gmail.com, rostedt@goodmis.org
In-Reply-To: <20220926173357.GN4196@paulmck-ThinkPad-P17-Gen-1>
To:     paulmck@kernel.org
X-Mailer: iPhone Mail (19G82)
X-Spam-Status: No, score=-0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLACK autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Sep 26, 2022, at 1:33 PM, Paul E. McKenney <paulmck@kernel.org> wrote:
>=20
> =EF=BB=BFOn Mon, Sep 26, 2022 at 03:04:38PM +0000, Joel Fernandes wrote:
>>> On Mon, Sep 26, 2022 at 12:00:45AM +0200, Frederic Weisbecker wrote:
>>> On Sat, Sep 24, 2022 at 09:00:39PM -0400, Joel Fernandes wrote:
>>>>=20
>>>>=20
>>>>> On Sep 24, 2022, at 7:28 PM, Joel Fernandes <joel@joelfernandes.org> w=
rote:
>>>>>=20
>>>>> =EF=BB=BFHi Frederic, thanks for the response, replies
>>>>> below courtesy fruit company=E2=80=99s device:
>>>>>=20
>>>>>>> On Sep 24, 2022, at 6:46 PM, Frederic Weisbecker <frederic@kernel.or=
g> wrote:
>>>>>>>=20
>>>>>>> =EF=BB=BFOn Thu, Sep 22, 2022 at 10:01:01PM +0000, Joel Fernandes (G=
oogle) wrote:
>>>>>>> @@ -3902,7 +3939,11 @@ static void rcu_barrier_entrain(struct rcu_da=
ta *rdp)
>>>>>>>  rdp->barrier_head.func =3D rcu_barrier_callback;
>>>>>>>  debug_rcu_head_queue(&rdp->barrier_head);
>>>>>>>  rcu_nocb_lock(rdp);
>>>>>>> -    WARN_ON_ONCE(!rcu_nocb_flush_bypass(rdp, NULL, jiffies));
>>>>>>> +    /*
>>>>>>> +     * Flush the bypass list, but also wake up the GP thread as oth=
erwise
>>>>>>> +     * bypass/lazy CBs maynot be noticed, and can cause real long d=
elays!
>>>>>>> +     */
>>>>>>> +    WARN_ON_ONCE(!rcu_nocb_flush_bypass(rdp, NULL, jiffies, FLUSH_B=
P_WAKE));
>>>>>>=20
>>>>>> This fixes an issue that goes beyond lazy implementation. It should b=
e done
>>>>>> in a separate patch, handling rcu_segcblist_entrain() as well, with "=
Fixes: " tag.
>>>>>=20
>>>>> I wanted to do that, however on discussion with
>>>>> Paul I thought of making this optimization only for
>>>>> all lazy bypass CBs. That makes it directly related
>>>>> this patch since the laziness notion is first
>>>>> introduced here. On the other hand I could make
>>>>> this change in a later patch since we are not
>>>>> super bisectable anyway courtesy of the last
>>>>> patch (which is not really an issue if the CONFIG
>>>>> is kept off during someone=E2=80=99s bisection.
>>>>=20
>>>> Or are we saying it=E2=80=99s worth doing the wake up for rcu barrier e=
ven for
>>>> regular bypass CB? That=E2=80=99d save 2 jiffies on rcu barrier. If we a=
gree it=E2=80=99s
>>>> needed, then yes splitting the patch makes sense.
>>>>=20
>>>> Please let me know your opinions, thanks,
>>>>=20
>>>> - Joel
>>>=20
>>> Sure, I mean since we are fixing the buggy rcu_barrier_entrain() anyway,=
 let's
>>> just fix bypass as well. Such as in the following (untested):
>>=20
>> Got it. This sounds good to me, and will simplify the code a bit more for=
 sure.
>>=20
>> I guess a question for Paul - are you Ok with rcu_barrier() causing wake u=
ps
>> if the bypass list has any non-lazy CBs as well? That should be OK, IMO.
>=20
> In theory, I am OK with it.  In practice, you are the guys with the
> hardware that can measure power consumption, not me!  ;-)

Ok I=E2=80=99ll do it this way and I=E2=80=99ll add Frederic=E2=80=99s Sugge=
sted-by tag.  About power, I have already measured and it has no effect on p=
ower that I could find.

Thanks!

 - Joel



>=20
>>> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
>>> index b39e97175a9e..a0df964abb0e 100644
>>> --- a/kernel/rcu/tree.c
>>> +++ b/kernel/rcu/tree.c
>>> @@ -3834,6 +3834,8 @@ static void rcu_barrier_entrain(struct rcu_data *r=
dp)
>>> {
>>>    unsigned long gseq =3D READ_ONCE(rcu_state.barrier_sequence);
>>>    unsigned long lseq =3D READ_ONCE(rdp->barrier_seq_snap);
>>> +    bool wake_nocb =3D false;
>>> +    bool was_alldone =3D false;
>>>=20
>>>    lockdep_assert_held(&rcu_state.barrier_lock);
>>>    if (rcu_seq_state(lseq) || !rcu_seq_state(gseq) || rcu_seq_ctr(lseq) !=
=3D rcu_seq_ctr(gseq))
>>> @@ -3842,6 +3844,8 @@ static void rcu_barrier_entrain(struct rcu_data *r=
dp)
>>>    rdp->barrier_head.func =3D rcu_barrier_callback;
>>>    debug_rcu_head_queue(&rdp->barrier_head);
>>>    rcu_nocb_lock(rdp);
>>> +    if (rcu_rdp_is_offloaded(rdp) && !rcu_segcblist_pend_cbs(&rdp->cbli=
st))
>>> +        was_alldone =3D true;
>>>    WARN_ON_ONCE(!rcu_nocb_flush_bypass(rdp, NULL, jiffies));
>>>    if (rcu_segcblist_entrain(&rdp->cblist, &rdp->barrier_head)) {
>>>        atomic_inc(&rcu_state.barrier_cpu_count);
>>> @@ -3849,7 +3853,12 @@ static void rcu_barrier_entrain(struct rcu_data *=
rdp)
>>>        debug_rcu_head_unqueue(&rdp->barrier_head);
>>>        rcu_barrier_trace(TPS("IRQNQ"), -1, rcu_state.barrier_sequence);
>>>    }
>>> +    if (was_alldone && rcu_segcblist_pend_cbs(&rdp->cblist))
>>> +        wake_nocb =3D true;
>>>    rcu_nocb_unlock(rdp);
>>> +    if (wake_nocb)
>>> +        wake_nocb_gp(rdp, false);
>>> +
>>=20
>> Thanks for the code snippet, I like how you are checking if the bypass li=
st
>> is empty, without actually checking it ;-)
>=20
> That certainly is consistent with the RCU philosophy.  :-)
>=20
>                            Thanx, Paul
