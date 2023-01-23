Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13271677DA3
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 15:08:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232184AbjAWOI3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 09:08:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232064AbjAWOI2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 09:08:28 -0500
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E33D1E5F7
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 06:07:56 -0800 (PST)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-4fd37a1551cso148183677b3.13
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 06:07:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tXL9LQ5roDJWuied04pX7Ta5au5zJmVXBf71j+Vm8wA=;
        b=gMlVGcz42hk30NiwmSVoERu1KjycoKNkH0r1j4tOERa0lHQUgf/m3zNy/3cngfokiz
         coTS0wT4etPnxLXiTKrQP+EaVDI4SB8YsR3MTsQ6LXzO95DxPQwW7VbeEZUZaiUQN4dh
         qmIgI0H4HdHRW7UznjxfFWCZTkN1oWx5VqKl4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tXL9LQ5roDJWuied04pX7Ta5au5zJmVXBf71j+Vm8wA=;
        b=RvgOFARh4cWHfRkwsN9j/wpI+PD+sVtClCQD9ZOlp6AIlD/GD0AG3baq6FzQrRww4B
         +3FmkDRwSvaoHMi4MN5jiFVsgb1MIyYceWG+OWEFqaL/Neda1ggKpu+JxRnPe/Cmxqvh
         UmQegD/gnNsQy0k1++4JOJbHZENDe+K4lk4vwqFPRcsIbRWkIYi8lVW9IZpe3YZyadWh
         Hy1SgYoUkQMtEseiIoV3vH8Mjcstx2TS43fMaw9vg6CaXq6hAi/TkSHCRKoD4iDYneLo
         Cog+UL2CziKfH8n8qgSjX/J+MszCZDqJdf5iejUiXwyFWzLY12+qw4b1f9kHdrjcf+ju
         uOLw==
X-Gm-Message-State: AFqh2kqq5PMfTfKvOBO1a2K6m3i/hthm/4kBvnNi6m9czRpCb40Vr/eB
        fN6dJQotij1V4aaLOpU13hf4+Q==
X-Google-Smtp-Source: AMrXdXvWkhbTYBUFSBxN67w1xnSsumiAMC5BbQJK9mN4IsHlogZxj7vr/V5gQs3lcM2fgDTu9tMOtA==
X-Received: by 2002:a0d:df15:0:b0:461:bc41:3c7a with SMTP id i21-20020a0ddf15000000b00461bc413c7amr17700018ywe.26.1674482875579;
        Mon, 23 Jan 2023 06:07:55 -0800 (PST)
Received: from smtpclient.apple (c-98-249-43-138.hsd1.va.comcast.net. [98.249.43.138])
        by smtp.gmail.com with ESMTPSA id bq35-20020a05620a46a300b0070209239b87sm12098090qkb.41.2023.01.23.06.07.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Jan 2023 06:07:54 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Joel Fernandes <joel@joelfernandes.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v3] rcu: Further comment and explain the state space of GP sequences
Date:   Mon, 23 Jan 2023 09:07:43 -0500
Message-Id: <A6B13595-00FE-4DF4-A5DC-0B54DD0C4E80@joelfernandes.org>
References: <Y85868Pei9VutSiW@lothringen>
Cc:     "Paul E . McKenney" <paulmck@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, rcu <rcu@vger.kernel.org>,
        quic_neeraju@quicinc.com, Uladzislau Rezki <urezki@gmail.com>
In-Reply-To: <Y85868Pei9VutSiW@lothringen>
To:     Frederic Weisbecker <frederic@kernel.org>
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



> On Jan 23, 2023, at 7:26 AM, Frederic Weisbecker <frederic@kernel.org> wro=
te:
>=20
> =EF=BB=BFOn Thu, Jan 19, 2023 at 05:06:27PM +0000, Joel Fernandes wrote:
>>> On Thu, Jan 19, 2023 at 2:15 PM Frederic Weisbecker <frederic@kernel.org=
> wrote:
>>>=20
>>> On Thu, Jan 19, 2023 at 03:11:35PM +0100, Frederic Weisbecker wrote:
>>>> The state space of the GP sequence number isn't documented and the
>>>> definitions of its special values are scattered. Try to gather some
>>>> common knowledge near the GP seq headers.
>>>>=20
>>>> Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
>>>> ---
>>>> kernel/rcu/rcu.h | 33 +++++++++++++++++++++++++++++++++
>>>> 1 file changed, 33 insertions(+)
>>>>=20
>>>> diff --git a/kernel/rcu/rcu.h b/kernel/rcu/rcu.h
>>>> index 115616ac3bfa..fb95de039596 100644
>>>> --- a/kernel/rcu/rcu.h
>>>> +++ b/kernel/rcu/rcu.h
>>>> @@ -14,6 +14,39 @@
>>>>=20
>>>> /*
>>>>  * Grace-period counter management.
>>>> + *
>>>> + * The two lowest significant bits gather the control flags.
>>>> + * The higher bits form the RCU sequence counter.
>>>> + *
>>>> + * About the control flags, a common value of 0 means that no GP is in=
 progress.
>>>> + * A value of 1 means that a grace period has started and is in progre=
ss. When
>>>> + * the grace period completes, the control flags are reset to 0 and th=
e sequence
>>>> + * counter is incremented.
>>>> + *
>>>> + * However some specific RCU usages make use of custom values.
>>>> + *
>>>> + * SRCU special control values:
>>>> + *
>>>> + *   SRCU_SNP_INIT_SEQ       :       Invalid/init value set when SRCU n=
ode
>>>> + *                                                   is initialized.
>>>> + *
>>>> + *   SRCU_STATE_IDLE         :       No SRCU gp is in progress
>>>> + *
>>>> + *   SRCU_STATE_SCAN1        :       State set by rcu_seq_start(). Ind=
icates
>>>> + *                                                           we are sc=
anning the inactive readers
>>>> + *                                                           index.
>>=20
>> The term "inactive reader" is confusing. The readers can very much be
>> active during scans. During a scan stage, there might be a reader on
>> any of the 2 indexes that can be right in the middle of their critical
>> section (and we don't know which index because they could have got
>> preempted, right after sampling idx). Maybe "inactive slot" is a
>> better term? And define "inactive slot" as the slot which is no longer
>> going to be sampled by new readers.
>=20
> That's why I used "inactive readers index".
> I guess I should have written "inactive readers' index" to disambiguate
> the fact that inactive refers to "index" and not "readers" but I almost
> never observe plural genitive written that way these days.
>=20
> As for the gory details of "inactive" being actually "bound to become
> inactive", I'm not sure that belongs here but here is what I can do:

Sounds good and the below change looks good to me.

Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>

Thanks,

 - Joel



>=20
> ---
> From: Frederic Weisbecker <frederic@kernel.org>
> Date: Thu, 19 Jan 2023 14:29:34 +0100
> Subject: [PATCH] rcu: Further comment and explain the state space of GP
> sequences
>=20
> The state space of the GP sequence number isn't documented and the
> definitions of its special values are scattered. Try to gather some
> common knowledge near the GP seq headers.
>=20
> Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> ---
> kernel/rcu/rcu.h | 37 +++++++++++++++++++++++++++++++++++++
> 1 file changed, 37 insertions(+)
>=20
> diff --git a/kernel/rcu/rcu.h b/kernel/rcu/rcu.h
> index 115616ac3bfa..5be983598b5a 100644
> --- a/kernel/rcu/rcu.h
> +++ b/kernel/rcu/rcu.h
> @@ -14,6 +14,43 @@
>=20
> /*
>  * Grace-period counter management.
> + *
> + * The two lowest significant bits gather the control flags.
> + * The higher bits form the RCU sequence counter.
> + *
> + * About the control flags, a common value of 0 means that no GP is in pr=
ogress.
> + * A value of 1 means that a grace period has started and is in progress.=
 When
> + * the grace period completes, the control flags are reset to 0 and the s=
equence
> + * counter is incremented.
> + *
> + * However some specific RCU usages make use of custom values.
> + *
> + * SRCU special control values:
> + *
> + *    SRCU_SNP_INIT_SEQ    :    Invalid/init value set when SRCU node
> + *                    is initialized.
> + *
> + *    SRCU_STATE_IDLE        :    No SRCU gp is in progress
> + *
> + *    SRCU_STATE_SCAN1    :    State set by rcu_seq_start(). Indicates
> + *                    we are scanning the readers on the slot
> + *                    defined as inactive (though there might
> + *                    be pending readers there but their number
> + *                    is bound).
> + *
> + *    SRCU_STATE_SCAN2    :    State set manually via rcu_seq_set_state()=

> + *                    Indicates we are flipping the readers
> + *                    index and then scanning the readers on the
> + *                    slot newly set as inactive (again there
> + *                    might remain a bound amount of pending
> + *                    readers there).
> + *
> + * RCU polled GP special control value:
> + *
> + *    RCU_GET_STATE_COMPLETED :    State value indicating that a polled G=
P
> + *                    has completed. It's an absolute value
> + *                    covering both the state and the counter of
> + *                    the GP sequence.
>  */
>=20
> #define RCU_SEQ_CTR_SHIFT    2
> --=20
> 2.34.1
>=20
