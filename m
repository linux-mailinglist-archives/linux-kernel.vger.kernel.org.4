Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AAE9636F8C
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 02:00:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229602AbiKXBAY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 20:00:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbiKXBAW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 20:00:22 -0500
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 503FA78D68
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 17:00:21 -0800 (PST)
Received: by mail-qv1-xf35.google.com with SMTP id h7so94884qvs.3
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 17:00:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OZUox7da7NgS3v6hjso4mfE8wJf8mF4cfDLgIf1o1rM=;
        b=a7cgmhJvfmdaSZgsxIp7YCdK5xR1KnroUd195Ydv21xGaGj4YRxD3fVqeq2Bjx/yBM
         YpT70gEvl8jLyu9CvdrP78Sxdw9zP7xJOnVQOneeseOj/TQb0sPiH+ZPqMX4fvs64XuD
         QxcnmEsTnnysOOOCBybe0XWLd0IGWeQUecDWA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OZUox7da7NgS3v6hjso4mfE8wJf8mF4cfDLgIf1o1rM=;
        b=i3wEiZ/oFnWb8BiInuv7yrLmm4HVsOmNsFpJIA5Uc+4vg+R0AxxEeTGsEdDlFjygYZ
         m9Cxr6UE3KHdxBHCWAdV+xs8I4IjrWA6nY+KZfTzmGE0Oro5TRX/3eT1iY+yVpVZf1C5
         HstCh+NgwOegUULJ6jZUeNw9qsLbtfm0Cx/924jHCbQi6+GAz4w0J2dg9mhmpaaBbvc5
         W9XASmHUYSQYQdL/CZhFsyS4LAZqRNOTgoUc8UStWURGWfmX/RgTGAhZX2nLOVHK9qhS
         bj2BAoZaK70VIdnvPNeCC7kFiVq6zSMb/d15axoTFEfFfAoaToGPkUmc8kYoNCfUiPyO
         olnQ==
X-Gm-Message-State: ANoB5plJlF+fPuNkdyGg6/YRwb29DqfH7u/GzHW4o37S/KKAoUhVjgks
        JF4GLntT1P65mgTcVaQR6H2Zek14t80Zng==
X-Google-Smtp-Source: AA0mqf4xkVWmMgFzLI8NzSImgfx/kKA1XoFMQq7ed5TI5PiwsRUgFgYbhvxOUGgn8+4PPOo9dLQXYw==
X-Received: by 2002:ad4:534b:0:b0:4b1:8429:a8a7 with SMTP id v11-20020ad4534b000000b004b18429a8a7mr10833373qvs.52.1669251619580;
        Wed, 23 Nov 2022 17:00:19 -0800 (PST)
Received: from smtpclient.apple (c-73-148-104-166.hsd1.va.comcast.net. [73.148.104.166])
        by smtp.gmail.com with ESMTPSA id fv11-20020a05622a4a0b00b003a526675c07sm10692431qtb.52.2022.11.23.17.00.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Nov 2022 17:00:19 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Joel Fernandes <joel@joelfernandes.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v2 rcu 05/16] rcu: Refactor code a bit in rcu_nocb_do_flush_bypass()
Date:   Wed, 23 Nov 2022 20:00:18 -0500
Message-Id: <F3FB7417-0E5F-487A-A880-15964B676020@joelfernandes.org>
References: <20221123175437.GA4001@paulmck-ThinkPad-P17-Gen-1>
Cc:     Frederic Weisbecker <frederic@kernel.org>, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@meta.com,
        rostedt@goodmis.org
In-Reply-To: <20221123175437.GA4001@paulmck-ThinkPad-P17-Gen-1>
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



> On Nov 23, 2022, at 12:54 PM, Paul E. McKenney <paulmck@kernel.org> wrote:=

>=20
> =EF=BB=BFOn Wed, Nov 23, 2022 at 04:59:29PM +0100, Frederic Weisbecker wro=
te:
>>> On Mon, Nov 21, 2022 at 05:04:10PM -0800, Paul E. McKenney wrote:
>>> From: "Joel Fernandes (Google)" <joel@joelfernandes.org>
>>>=20
>>> This consolidates the code a bit and makes it cleaner. Functionally it
>>> is the same.
>>>=20
>>> Reported-by: Paul E. McKenney <paulmck@kernel.org>
>>> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
>>> Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
>>> ---
>>> kernel/rcu/tree_nocb.h | 17 +++++++++--------
>>> 1 file changed, 9 insertions(+), 8 deletions(-)
>>>=20
>>> diff --git a/kernel/rcu/tree_nocb.h b/kernel/rcu/tree_nocb.h
>>> index d6e4c076b0515..213daf81c057f 100644
>>> --- a/kernel/rcu/tree_nocb.h
>>> +++ b/kernel/rcu/tree_nocb.h
>>> @@ -327,10 +327,11 @@ static void wake_nocb_gp_defer(struct rcu_data *rd=
p, int waketype,
>>>  *
>>>  * Note that this function always returns true if rhp is NULL.
>>>  */
>>> -static bool rcu_nocb_do_flush_bypass(struct rcu_data *rdp, struct rcu_h=
ead *rhp,
>>> +static bool rcu_nocb_do_flush_bypass(struct rcu_data *rdp, struct rcu_h=
ead *rhp_in,
>>>                     unsigned long j, bool lazy)
>>> {
>>>    struct rcu_cblist rcl;
>>> +    struct rcu_head *rhp =3D rhp_in;
>>=20
>> Why that intermediate rhp_in?
>=20
> To avoid modifying the formal parameter, should the original value prove
> useful, for example, for tracing or debugging.

So as to not re assign function parameter and introduce bugs down the line (=
someone reading code thinks they passed a certain rhp but code is using some=
thing else later in the function).

Thanks.



>=20
>>>    WARN_ON_ONCE(!rcu_rdp_is_offloaded(rdp));
>>>    rcu_lockdep_assert_cblist_protected(rdp);
>>> @@ -345,16 +346,16 @@ static bool rcu_nocb_do_flush_bypass(struct rcu_da=
ta *rdp, struct rcu_head *rhp,
>>>=20
>>>    /*
>>>     * If the new CB requested was a lazy one, queue it onto the main
>>> -     * ->cblist so we can take advantage of a sooner grade period.
>>> +     * ->cblist so that we can take advantage of the grace-period that w=
ill
>>> +     * happen regardless. But queue it onto the bypass list first so th=
at
>>> +     * the lazy CB is ordered with the existing CBs in the bypass list.=

>>>     */
>>>    if (lazy && rhp) {
>>> -        rcu_cblist_flush_enqueue(&rcl, &rdp->nocb_bypass, NULL);
>>> -        rcu_cblist_enqueue(&rcl, rhp);
>>> -        WRITE_ONCE(rdp->lazy_len, 0);
>>> -    } else {
>>> -        rcu_cblist_flush_enqueue(&rcl, &rdp->nocb_bypass, rhp);
>>> -        WRITE_ONCE(rdp->lazy_len, 0);
>>> +        rcu_cblist_enqueue(&rdp->nocb_bypass, rhp);
>>> +        rhp =3D NULL;
>>>    }
>>> +    rcu_cblist_flush_enqueue(&rcl, &rdp->nocb_bypass, rhp);
>>> +    WRITE_ONCE(rdp->lazy_len, 0);
>>=20
>> Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
>=20
> Thank you!  I will apply this on my next rebase.
>=20
>                            Thanx, Paul
>=20
>> Thanks.
>>=20
>>>=20
>>>    rcu_segcblist_insert_pend_cbs(&rdp->cblist, &rcl);
>>>    WRITE_ONCE(rdp->nocb_bypass_first, j);
>>> --=20
>>> 2.31.1.189.g2e36527f23
>>>=20
