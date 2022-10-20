Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86FC7606862
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 20:46:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229967AbiJTSqO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 14:46:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229588AbiJTSqM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 14:46:12 -0400
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FCCE10CF8F
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 11:46:10 -0700 (PDT)
Received: by mail-qt1-x830.google.com with SMTP id g16so212388qtu.2
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 11:46:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sMoQnphRgKnegKqjWv37RW/oY6k9oR1LdgG69oo1zNE=;
        b=uutyY8Kzsswex3LJ2NwzB3+830HoHyWn6QeNQKVpYrhDFWN+MVJS2eChQCXIlY1KX4
         zh/GjPwsE6SfqHbJpyPNLuMDfVbrK2y+AluveWLL93oecV34x65CS1x2bgPLwjbt5soI
         nwhENF0hjyIIutAexXdVhagA0DQgsX4Kj4m3s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sMoQnphRgKnegKqjWv37RW/oY6k9oR1LdgG69oo1zNE=;
        b=2fGnKO8M3E4dJGFc+bj2KRnwJ+/9JUvzyIbkMG4iz5NT5Wn+4NYPKwepQmIF4we2XR
         NBiLo8mq/loOZcrsVN7BwnWQ87VhrgmF0SDtYuooV8Fduvb1gdwuLvKIPh0XVs8hYVWQ
         L+ZfiYS+kql95uSm/Ib6sJeyYiegIxa2SBAFGaSQKdyl6bwesJz1v4owvKD28DQAMtEz
         SVd5XwAZiE9BIMs014tiZb33W7CJff5r0nER+CGhCC2lQ2URTEqBqNlyHsNZv4pn4tkj
         B4/kDM4y8uB/kFGSY+SRB8ENttnN0lUa/R4VCwvgCNSdqqs2yL3blkBJtBf9mbGjbLl0
         EVNA==
X-Gm-Message-State: ACrzQf01VGdp0esjhkdCo1GScZTEVU1/YuK71kaKF/4fFDOBNJ/6YYwP
        JBD047rkkL8sURV1lEG5j6oY4A==
X-Google-Smtp-Source: AMsMyM5SLc5r30Oox5re8QhwZd4ek9Z8nhW5IsB4MNt/eytSoZ1aBDBHwBO7//xWeTxI7LUXl/mhOw==
X-Received: by 2002:ac8:5a44:0:b0:39d:d06:610d with SMTP id o4-20020ac85a44000000b0039d0d06610dmr3438208qta.363.1666291569159;
        Thu, 20 Oct 2022 11:46:09 -0700 (PDT)
Received: from smtpclient.apple (c-73-148-104-166.hsd1.va.comcast.net. [73.148.104.166])
        by smtp.gmail.com with ESMTPSA id m10-20020ac8444a000000b0039b03ac2f72sm6584596qtn.46.2022.10.20.11.46.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Oct 2022 11:46:08 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Joel Fernandes <joel@joelfernandes.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH] rcu: Make call_rcu() lazy only when CONFIG_RCU_LAZY is enabled
Date:   Thu, 20 Oct 2022 14:46:08 -0400
Message-Id: <95331C23-3632-4E0B-9959-43CE159FE60F@joelfernandes.org>
References: <20221020183901.GU5600@paulmck-ThinkPad-P17-Gen-1>
Cc:     Zqiang <qiang1.zhang@intel.com>, frederic@kernel.org,
        rcu@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20221020183901.GU5600@paulmck-ThinkPad-P17-Gen-1>
To:     paulmck@kernel.org
X-Mailer: iPhone Mail (19G82)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Oct 20, 2022, at 2:39 PM, Paul E. McKenney <paulmck@kernel.org> wrote:
>=20
> =EF=BB=BFOn Thu, Oct 20, 2022 at 04:42:05AM -0400, Joel Fernandes wrote:
>>>> On Oct 19, 2022, at 7:34 PM, Paul E. McKenney <paulmck@kernel.org> wrot=
e:
>>>=20
>>> =EF=BB=BFOn Wed, Oct 19, 2022 at 02:25:29PM -0400, Joel Fernandes wrote:=

>>>>=20
>>>>=20
>>>>>> On Oct 19, 2022, at 1:45 PM, Paul E. McKenney <paulmck@kernel.org> wr=
ote:
>>>>>=20
>>>>> =EF=BB=BFOn Wed, Oct 19, 2022 at 08:12:30AM -0400, Joel Fernandes wrot=
e:
>>>>>>> On Oct 19, 2022, at 8:10 AM, Joel Fernandes <joel@joelfernandes.org>=
 wrote:
>>>>>>>>> On Oct 19, 2022, at 6:34 AM, Zqiang <qiang1.zhang@intel.com> wrote=
:
>>>>>>>>>=20
>>>>>>>>> =EF=BB=BFCurrently, regardless of whether the CONFIG_RCU_LAZY is e=
nabled,
>>>>>>>>> invoke the call_rcu() is always lazy, it also means that when
>>>>>>>>> CONFIG_RCU_LAZY is disabled, invoke the call_rcu_flush() is also
>>>>>>>>> lazy. therefore, this commit make call_rcu() lazy only when
>>>>>>>>> CONFIG_RCU_LAZY is enabled.
>>>>>>=20
>>>>>> First, good eyes!  Thank you for spotting this!!
>>=20
>> Indeed.
>>=20
>>>>>>>>> Signed-off-by: Zqiang <qiang1.zhang@intel.com>
>>>>>>>>> ---
>>>>>>>>> kernel/rcu/tree.c | 8 +++++++-
>>>>>>>>> 1 file changed, 7 insertions(+), 1 deletion(-)
>>>>>>>>>=20
>>>>>>>>> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
>>>>>>>>> index abc615808b6e..97ef602da3d5 100644
>>>>>>>>> --- a/kernel/rcu/tree.c
>>>>>>>>> +++ b/kernel/rcu/tree.c
>>>>>>>>> @@ -2839,7 +2839,6 @@ void call_rcu_flush(struct rcu_head *head, r=
cu_callback_t func)
>>>>>>>>> return __call_rcu_common(head, func, false);
>>>>>>>>> }
>>>>>>>>> EXPORT_SYMBOL_GPL(call_rcu_flush);
>>>>>>>>> -#endif
>>>>>>>>>=20
>>>>>>>>> /**
>>>>>>>>> * call_rcu() - Queue an RCU callback for invocation after a grace p=
eriod.
>>>>>>>>> @@ -2890,6 +2889,13 @@ void call_rcu(struct rcu_head *head, rcu_ca=
llback_t func)
>>>>>>>>> return __call_rcu_common(head, func, true);
>>>>>>>>> }
>>>>>>>>> EXPORT_SYMBOL_GPL(call_rcu);
>>>>>>>>> +#else
>>>>>>>>> +void call_rcu(struct rcu_head *head, rcu_callback_t func)
>>>>>>>>> +{
>>>>>>>>> +    return __call_rcu_common(head, func, false);
>>>>>>>=20
>>>>>>> Thanks. Instead of adding new function, you can also pass IS_ENABLED=
(CONFIG=E2=80=A6) to the existing function of the same name.
>>>>>=20
>>>>> I do like this approach better -- less code, more obvious what is goin=
g on.
>>>>=20
>>>> Sounds good. Zqiang, do you mind updating your patch along these lines?=
 That way you get the proper attribution.
>>=20
>> Acked that patch.
>>=20
>>>> More comments below:
>>>>>=20
>>>>>>> Looks like though I made every one test the patch without having to e=
nable the config option ;-). Hey, I=E2=80=99m a half glass full kind of guy,=
 why do you ask?
>>>>>>>=20
>>>>>>> Paul, I=E2=80=99ll take a closer look once I=E2=80=99m at the desk, b=
ut would you prefer to squash a diff into the existing patch, or want a new p=
atch altogether?
>>>>>>=20
>>>>>> On the other hand, what I=E2=80=99d want is to nuke the config option=
 altogether or make it default y, we want to catch issues sooner than later.=

>>>>>=20
>>>>> That might be what we do at some point, but one thing at a time.  Let'=
s
>>>>> not penalize innocent bystanders, at least not just yet.
>>>>=20
>>>> It=E2=80=99s a trade off, I thought that=E2=80=99s why we wanted to hav=
e the binary search stuff. If no one reports issue on Linux-next, then that c=
ode won=E2=80=99t be put to use in the near future at least.
>>>=20
>>> Well, not to put too fine a point on it, but we currently really are
>>> exposing -next to lazy call_rcu().  ;-)
>>=20
>> This is true. I think I assumed nobody will enable a default off config o=
ption but I probably meant a smaller percentage will.
>>=20
>>>>> I do very strongly encourage the ChromeOS and Android folks to test th=
is
>>>>> very severely, however.
>>>>=20
>>>> Agreed. Yes that will happen, though I have to make a note for Android f=
olks other than Vlad, to backports these (and enable the config option), car=
efully! Especially on pre-5.15 kernels. Luckily I had to do this (not so tri=
vial) exercise myself.
>>>=20
>>> And this is another situation in which the binary search stuff may prove=

>>> extremely useful.
>>=20
>> Agreed. Thanks. Very least I owe per-rdp splitting of the hashtable, to t=
hat code.  Steven and me talked today that probably the hashtable can go int=
o the rcu_segcblist itself, and protect it by the nocb lock.
>=20
> I have to ask...
>=20
> How does this fit in with CPU-hotplug and callback migration?

Yes it will require change and I already thought of that, have to update the=
 hashtable on all such events.

> More to the point, what events would cause us to decide that this is
> required?  For example, shouldn't we give your current binary-search
> code at least a few chances to save the day?

Totally, if you=E2=80=99re taking the patch as is, I would be very happy. An=
d I=E2=80=99ll continue to improve it with the above. But I was not sure yet=
 if you=E2=80=99re taking it.

I think it=E2=80=99s a worthwhile to take it for mainline in the current sta=
te and I=E2=80=99ll also add more data about callbacks to it in future (queu=
ing time of callback, etc) =E2=80=94 basically all the stuff I wanted to add=
 to rcu_head.

One reason for the above proposal is I also want to keep it turned on in pro=
duction, and the current solution cannot be, due to the global locking and i=
s not expected to be kept on in production. But is still a worthwhile additi=
on for debug kernels IMO.

Thanks,

 - Joel


>                            Thanx, Paul
>=20
>>>>>>>> +}
>>>>>>>> +EXPORT_SYMBOL_GPL(call_rcu);
>>>>>>>> +#endif
>>>>>>>>=20
>>>>>>>> /* Maximum number of jiffies to wait before draining a batch. */
>>>>>>>> #define KFREE_DRAIN_JIFFIES (5 * HZ)
>>>>>>>> --=20
>>>>>>>> 2.25.1
>>>>>>>>=20
