Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D64BD605A1A
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 10:42:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230324AbiJTImM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 04:42:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229794AbiJTImI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 04:42:08 -0400
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 467197FE54
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 01:42:07 -0700 (PDT)
Received: by mail-qt1-x832.google.com with SMTP id g16so8453347qtu.2
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 01:42:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:from:to:cc:subject:date:message-id
         :reply-to;
        bh=StguZxeIZvSJHx8TIRzR/2jIU4L9v9uNe0d+i/ToWZQ=;
        b=WOcb8PzTO38DsVhQafWoNz35Dhjl+BXOaZAbJd5V73YqL1ZINuUhqXGH+uGzebmIWQ
         RJZza0lsMLrerlsfVjMUBDL9S0dpFXf/U1eAn+x6/AEajd+aAXTIr6AWB8Krq9WvssgZ
         fdnoNGPXFqtgzFrdGeGASYF11+0mS7a5mGZKU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=StguZxeIZvSJHx8TIRzR/2jIU4L9v9uNe0d+i/ToWZQ=;
        b=6mpX5oVDvt5DamZaj6sO5ovbx8MXrDjEewZAfkXUiI1CWjoQoH9Gw2kFnnrCd0d55x
         sx0q0YJCXvvotHO98aBbh+QYmh6F2YoX7tyTSGeDgsOHz0oc9XOP1DWkGHexYoVv2BFV
         icqk6BEpIqBuMf/X/n7XcteJP0H5nKWaMBFcSGmDjTJwOj0+K+iYgbqWDHVzPl9Xx8L9
         tQ7BUebWGU0c82Pv7qBBHOLtmhBjLaeQ9oTHBvOaigSBdslUl2kG0XTR2sbCn0gySf/N
         aVaUIOPyjVDKjjUp30mBN4t3UXNvNBOvt/ePcmHyOzrFG+dvMxMvFgtvQeeeTga0Oz88
         LCzA==
X-Gm-Message-State: ACrzQf08zpJnCZbjC1G5JEG864EqsJAvtO3k7rFTJlto69jJUo2Wm1+m
        sMn7lEiQlvHgFQc4LUs1rfFDtQ==
X-Google-Smtp-Source: AMsMyM5LcSx05k8/8fwlnDgM9wnUjMX0Az//Un5dA+ip5TWswPhSg6FWDhOcmtiXrWOl0ARTQHBf5w==
X-Received: by 2002:ac8:7c46:0:b0:39c:fa92:a27a with SMTP id o6-20020ac87c46000000b0039cfa92a27amr7457664qtv.61.1666255326244;
        Thu, 20 Oct 2022 01:42:06 -0700 (PDT)
Received: from smtpclient.apple (c-73-148-104-166.hsd1.va.comcast.net. [73.148.104.166])
        by smtp.gmail.com with ESMTPSA id r2-20020ae9d602000000b006ceb933a9fesm6727041qkk.81.2022.10.20.01.42.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Oct 2022 01:42:05 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Joel Fernandes <joel@joelfernandes.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH] rcu: Make call_rcu() lazy only when CONFIG_RCU_LAZY is enabled
Date:   Thu, 20 Oct 2022 04:42:05 -0400
Message-Id: <D7F0EE3F-0A06-4868-87E3-B88B9BD6480C@joelfernandes.org>
References: <20221019233419.GI5600@paulmck-ThinkPad-P17-Gen-1>
Cc:     Zqiang <qiang1.zhang@intel.com>, frederic@kernel.org,
        rcu@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20221019233419.GI5600@paulmck-ThinkPad-P17-Gen-1>
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



> On Oct 19, 2022, at 7:34 PM, Paul E. McKenney <paulmck@kernel.org> wrote:
>=20
> =EF=BB=BFOn Wed, Oct 19, 2022 at 02:25:29PM -0400, Joel Fernandes wrote:
>>=20
>>=20
>>>> On Oct 19, 2022, at 1:45 PM, Paul E. McKenney <paulmck@kernel.org> wrot=
e:
>>>=20
>>> =EF=BB=BFOn Wed, Oct 19, 2022 at 08:12:30AM -0400, Joel Fernandes wrote:=

>>>>> On Oct 19, 2022, at 8:10 AM, Joel Fernandes <joel@joelfernandes.org> w=
rote:
>>>>>>> On Oct 19, 2022, at 6:34 AM, Zqiang <qiang1.zhang@intel.com> wrote:
>>>>>>>=20
>>>>>>> =EF=BB=BFCurrently, regardless of whether the CONFIG_RCU_LAZY is ena=
bled,
>>>>>>> invoke the call_rcu() is always lazy, it also means that when
>>>>>>> CONFIG_RCU_LAZY is disabled, invoke the call_rcu_flush() is also
>>>>>>> lazy. therefore, this commit make call_rcu() lazy only when
>>>>>>> CONFIG_RCU_LAZY is enabled.
>>>>=20
>>>> First, good eyes!  Thank you for spotting this!!

Indeed.

>>>>>>> Signed-off-by: Zqiang <qiang1.zhang@intel.com>
>>>>>>> ---
>>>>>>> kernel/rcu/tree.c | 8 +++++++-
>>>>>>> 1 file changed, 7 insertions(+), 1 deletion(-)
>>>>>>>=20
>>>>>>> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
>>>>>>> index abc615808b6e..97ef602da3d5 100644
>>>>>>> --- a/kernel/rcu/tree.c
>>>>>>> +++ b/kernel/rcu/tree.c
>>>>>>> @@ -2839,7 +2839,6 @@ void call_rcu_flush(struct rcu_head *head, rcu=
_callback_t func)
>>>>>>> return __call_rcu_common(head, func, false);
>>>>>>> }
>>>>>>> EXPORT_SYMBOL_GPL(call_rcu_flush);
>>>>>>> -#endif
>>>>>>>=20
>>>>>>> /**
>>>>>>> * call_rcu() - Queue an RCU callback for invocation after a grace pe=
riod.
>>>>>>> @@ -2890,6 +2889,13 @@ void call_rcu(struct rcu_head *head, rcu_call=
back_t func)
>>>>>>> return __call_rcu_common(head, func, true);
>>>>>>> }
>>>>>>> EXPORT_SYMBOL_GPL(call_rcu);
>>>>>>> +#else
>>>>>>> +void call_rcu(struct rcu_head *head, rcu_callback_t func)
>>>>>>> +{
>>>>>>> +    return __call_rcu_common(head, func, false);
>>>>>=20
>>>>> Thanks. Instead of adding new function, you can also pass IS_ENABLED(C=
ONFIG=E2=80=A6) to the existing function of the same name.
>>>=20
>>> I do like this approach better -- less code, more obvious what is going o=
n.
>>=20
>> Sounds good. Zqiang, do you mind updating your patch along these lines? T=
hat way you get the proper attribution.

Acked that patch.

>> More comments below:
>>>=20
>>>>> Looks like though I made every one test the patch without having to en=
able the config option ;-). Hey, I=E2=80=99m a half glass full kind of guy, w=
hy do you ask?
>>>>>=20
>>>>> Paul, I=E2=80=99ll take a closer look once I=E2=80=99m at the desk, bu=
t would you prefer to squash a diff into the existing patch, or want a new p=
atch altogether?
>>>>=20
>>>> On the other hand, what I=E2=80=99d want is to nuke the config option a=
ltogether or make it default y, we want to catch issues sooner than later.
>>>=20
>>> That might be what we do at some point, but one thing at a time.  Let's
>>> not penalize innocent bystanders, at least not just yet.
>>=20
>> It=E2=80=99s a trade off, I thought that=E2=80=99s why we wanted to have t=
he binary search stuff. If no one reports issue on Linux-next, then that cod=
e won=E2=80=99t be put to use in the near future at least.
>=20
> Well, not to put too fine a point on it, but we currently really are
> exposing -next to lazy call_rcu().  ;-)

This is true. I think I assumed nobody will enable a default off config opti=
on but I probably meant a smaller percentage will.

>>> I do very strongly encourage the ChromeOS and Android folks to test this=

>>> very severely, however.
>>=20
>> Agreed. Yes that will happen, though I have to make a note for Android fo=
lks other than Vlad, to backports these (and enable the config option), care=
fully! Especially on pre-5.15 kernels. Luckily I had to do this (not so triv=
ial) exercise myself.
>=20
> And this is another situation in which the binary search stuff may prove
> extremely useful.

Agreed. Thanks. Very least I owe per-rdp splitting of the hashtable, to that=
 code.  Steven and me talked today that probably the hashtable can go into t=
he rcu_segcblist itself, and protect it by the nocb lock.

Thanks,

 - Joel


>                            Thanx, Paul
>=20
>> Thanks!
>>=20
>> - Joel
>>=20
>>>=20
>>>                           Thanx, Paul
>>>=20
>>>> Thanks.
>>>>=20
>>>>>=20
>>>>> Thanks.
>>>>>=20
>>>>> - Joel
>>>>>=20
>>>>>=20
>>>>>> +}
>>>>>> +EXPORT_SYMBOL_GPL(call_rcu);
>>>>>> +#endif
>>>>>>=20
>>>>>> /* Maximum number of jiffies to wait before draining a batch. */
>>>>>> #define KFREE_DRAIN_JIFFIES (5 * HZ)
>>>>>> --=20
>>>>>> 2.25.1
>>>>>>=20
