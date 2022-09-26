Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B7325EB5CD
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 01:33:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229824AbiIZXdb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 19:33:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231292AbiIZXdW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 19:33:22 -0400
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80C2F7B782
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 16:33:19 -0700 (PDT)
Received: by mail-qv1-xf30.google.com with SMTP id l14so5285134qvq.8
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 16:33:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:from:to:cc:subject:date;
        bh=g1wLBAvnQ8SzjlNR0NcnJNCPTuqcD1TxoST+iFzU5DU=;
        b=TPtmNCxRdqwoGgun2c+N57orO9Thu5oxdH9XRQCtiekHggtCaEF4mWFRlIZhPp7rR3
         T8ZSY5slsDiczjGUJqHtXxRmDg9KvvyD/Pj+a04YmwF1Z2uL74F2fDm9dSzQoH1L1O1x
         y6yTrikL7h19tF3NFAyo0jx9bgCKOjhczDkyY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:x-gm-message-state:from:to:cc
         :subject:date;
        bh=g1wLBAvnQ8SzjlNR0NcnJNCPTuqcD1TxoST+iFzU5DU=;
        b=2RDcMfHFwJiFOMsOAkIn+HdqMa4uXDc3mo0GsgGB3tQQBRBwdVzSrhdOdG7rnrjUFu
         3Am3skOc1pjTeizb64hSsxXzzx5v1zyiBTv9S+/YY6rRHLL8PCk6KwLcwRXJJfgZfGJv
         0qLBHWFhDioXvxEIayFVEofMSTfuExvrjs5ap+5LhMQV0C33beMMmw93Lkbo40DxSbfG
         oeDQ30Gr7lnKy4J07LkQ10wk4IYnsLQHpQtt9ZOz0jNXgBQzIFelj/BcJYeVSjXyBuRW
         XR3HB0naR93jUi1oPDRUrFU0dWLM/z5jeiZRFOis5xpJN6tLtO0ycM7RQyfol4aQbr+r
         +fIg==
X-Gm-Message-State: ACrzQf0TMuKsuMwEmsMWnQfdoYyQwk4PREWwWaIPx1JEnRjfAyUrk8bY
        R6JzSfQ06PJRJRZLwW10VH99YGzM2FPY3x28
X-Google-Smtp-Source: AMsMyM6+YJngYvppWphoKw9V7qsQF5A2jFzjuVp+Qu7qykiaG+ayy+yia8vuWbFHitrQUEJjYm8W1A==
X-Received: by 2002:a0c:b20b:0:b0:4ad:c33:8ad with SMTP id x11-20020a0cb20b000000b004ad0c3308admr19599545qvd.129.1664235198434;
        Mon, 26 Sep 2022 16:33:18 -0700 (PDT)
Received: from smtpclient.apple ([2600:1003:b132:37f:2047:987d:1b5f:cf31])
        by smtp.gmail.com with ESMTPSA id x1-20020a05620a14a100b006ced196a73fsm12500071qkj.135.2022.09.26.16.33.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Sep 2022 16:33:18 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Joel Fernandes <joel@joelfernandes.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v6 1/4] rcu: Make call_rcu() lazy to save power
Date:   Mon, 26 Sep 2022 19:33:17 -0400
Message-Id: <A78761F4-5922-418A-AFA3-01101C399778@joelfernandes.org>
References: <20220926223751.GZ4196@paulmck-ThinkPad-P17-Gen-1>
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        rushikesh.s.kadam@intel.com, urezki@gmail.com,
        neeraj.iitr10@gmail.com, frederic@kernel.org, rostedt@goodmis.org
In-Reply-To: <20220926223751.GZ4196@paulmck-ThinkPad-P17-Gen-1>
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



> On Sep 26, 2022, at 6:37 PM, Paul E. McKenney <paulmck@kernel.org> wrote:
>=20
> =EF=BB=BFOn Mon, Sep 26, 2022 at 09:07:12PM +0000, Joel Fernandes wrote:
>> Hi Paul,
>>=20
>> On Mon, Sep 26, 2022 at 10:42:40AM -0700, Paul E. McKenney wrote:
>> [..]
>>>>>>>> +        WRITE_ONCE(rdp->lazy_len, 0);
>>>>>>>> +    } else {
>>>>>>>> +        rcu_cblist_flush_enqueue(&rcl, &rdp->nocb_bypass, rhp);
>>>>>>>> +        WRITE_ONCE(rdp->lazy_len, 0);
>>>>>>>=20
>>>>>>> This WRITE_ONCE() can be dropped out of the "if" statement, correct?=

>>>>>>=20
>>>>>> Yes will update.
>>>>>=20
>>>>> Thank you!
>>>>>=20
>>>>>>> If so, this could be an "if" statement with two statements in its "t=
hen"
>>>>>>> clause, no "else" clause, and two statements following the "if" stat=
ement.
>>>>>>=20
>>>>>> I don=E2=80=99t think we can get rid of the else part but I=E2=80=99l=
l see what it looks like.
>>>>>=20
>>>>> In the function header, s/rhp/rhp_in/, then:
>>>>>=20
>>>>>    struct rcu_head *rhp =3D rhp_in;
>>>>>=20
>>>>> And then:
>>>>>=20
>>>>>    if (lazy && rhp) {
>>>>>        rcu_cblist_enqueue(&rdp->nocb_bypass, rhp);
>>>>>        rhp =3D NULL;
>>>>=20
>>>> This enqueues on to the bypass list, where as if lazy && rhp, I want to=
 queue
>>>> the new rhp on to the main cblist. So the pseudo code in my patch is:
>>>>=20
>>>> if (lazy and rhp) then
>>>>    1. flush bypass CBs on to main list.
>>>>    2. queue new CB on to main list.
>>>=20
>>> And the difference is here, correct?  I enqueue to the bypass list,
>>> which is then flushed (in order) to the main list.  In contrast, you
>>> flush the bypass list, then enqueue to the main list.  Either way,
>>> the callback referenced by rhp ends up at the end of ->cblist.
>>>=20
>>> Or am I on the wrong branch of this "if" statement?
>>=20
>> But we have to flush first, and then queue the new one. Otherwise wouldn'=
t
>> the callbacks be invoked out of order? Or did I miss something?
>=20
> I don't think so...
>=20
> We want the new callback to be last, right?  One way to do that is to
> flush the bypass, then queue the new callback onto ->cblist.  Another way
> to do that is to enqueue the new callback onto the end of the bypass,
> then flush the bypass.  Why wouldn't these result in the same order?

Yes you are right, sorry. I was fixated on the main list. Both your snippet a=
nd my patch will be equivalent then. However I find your snippet a bit confu=
sing, as in it is not immediately obvious - why would we queue something on t=
o a list, if we were about to flush it. But any way, it does make it a cleve=
r piece of code in some sense and I am ok with doing it this way ;-)

Thanks,

  - Joel


>=20
>>>> else
>>>>    1. flush bypass CBs on to main list
>>>>    2. queue new CB on to bypass list.
>>>>=20
>>>>>    }
>>>>>    rcu_cblist_flush_enqueue(&rcl, &rdp->nocb_bypass, rhp);
>>>>>    WRITE_ONCE(rdp->lazy_len, 0);
>>>>>=20
>>>>> Or did I mess something up?
>>>>=20
>>>> So the rcu_cblist_flush_enqueue() has to happen before the
>>>> rcu_cblist_enqueue() to preserve the ordering of flushing into the main=
 list,
>>>> and queuing on to the main list for the "if". Where as in your snip, th=
e
>>>> order is reversed.
>>>=20
>>> Did I pick the correct branch of the "if" statement above?  Or were you
>>> instead talking about the "else" clause?
>>>=20
>>> I would have been more worried about getting cblist->len right.
>>=20
>> Hmm, I think my concern was more the ordering of callbacks, and moving th=
e
>> write to length should be Ok.
>=20
> OK, sounds good to me!  ;-)
>=20
>>>> If I consolidate it then, it looks like the following. However, it is a=
 bit
>>>> more unreadable. I could instead just take the WRITE_ONCE out of both i=
f/else
>>>> and move it to after the if/else, that would be cleanest. Does that sou=
nd
>>>> good to you? Thanks!
>>>=20
>>> Let's first figure out whether or not we are talking past one another.  ;=
-)
>>=20
>> Haha yeah :-)
>=20
> So were we?  ;-)
>=20
>                            Thanx, Paul
