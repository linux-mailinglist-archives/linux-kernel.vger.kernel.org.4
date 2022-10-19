Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0668604F94
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 20:25:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229872AbiJSSZk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 14:25:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229727AbiJSSZe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 14:25:34 -0400
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 375A216C230
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 11:25:31 -0700 (PDT)
Received: by mail-qt1-x82e.google.com with SMTP id g11so12267121qts.1
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 11:25:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IqSnWiFf4XnA91LNCiQ8+qSB8w27yT+g4XxiCybjj7Q=;
        b=RvMdHYgUuWQG5QRQFO8w26AgqVd2tuBt1R3iR88f1CH9bkQtJ+HPFsDODKiz4z2bd2
         8OpKq/W19LajzFjJ+HRPbdtzU2fb3TPcjAyMQqEWHmYWq2XnQO9ApKY/1cz2VuXHp4qe
         wJvSBf+KPBxLOko16qobSFffUh5iErDsxqK6g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IqSnWiFf4XnA91LNCiQ8+qSB8w27yT+g4XxiCybjj7Q=;
        b=xaJuEpiJsGkGoB+AyR0mw1wTsi18KZ5HwGPI4HEWM3B5R3QCVKngBWhDkjds8SeqOS
         7sX84bo2gSbjBFkzkuTH0sg8B4yX9zANGqedQZb0RLmqSgEc+R5wr9KdIf4Rw9CZFSVl
         4/7p2ykXWWWC1yiCC78w7CQ2x6O4jR27yTx8TLk7UqqUfDrYmizBrxqeNzcB9XsQG/W7
         Ldazaj1CTXNcPF5nepaF4NWJrtQsWgm5vL9/xZ0tnB0/1Y+ktHdkU4FvQxZ2vCE1T5hZ
         Cb0CFUt4jWt2Gid4H++kMrxX3Mc/21/nM+/p5DWpjvcUXZd8jJ30gGtYBKNNMuyPcOkl
         VIig==
X-Gm-Message-State: ACrzQf36XYY9K0uSBC8ZbXVO3m9sdMXTPoW5YLHEsqGY5jljfceTvuUj
        plYIZcpKllELeJr9p3Mm8zJzveV+bgQy/g==
X-Google-Smtp-Source: AMsMyM5FNgIei+2ggGlRuX/NL3B2nRiKE0rmUBDD6+Gqmgo/5e9KwKeqfoQOHJIHQ7V36RuJsxZrfQ==
X-Received: by 2002:ac8:5e08:0:b0:399:e50e:f821 with SMTP id h8-20020ac85e08000000b00399e50ef821mr7660239qtx.5.1666203930283;
        Wed, 19 Oct 2022 11:25:30 -0700 (PDT)
Received: from smtpclient.apple (c-73-148-104-166.hsd1.va.comcast.net. [73.148.104.166])
        by smtp.gmail.com with ESMTPSA id cb23-20020a05622a1f9700b0039cc22a2c49sm4474058qtb.47.2022.10.19.11.25.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Oct 2022 11:25:29 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Joel Fernandes <joel@joelfernandes.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH] rcu: Make call_rcu() lazy only when CONFIG_RCU_LAZY is enabled
Date:   Wed, 19 Oct 2022 14:25:29 -0400
Message-Id: <6E2C7AC3-9BA6-4C5B-A9D7-59F5F6279177@joelfernandes.org>
References: <20221019174458.GD5600@paulmck-ThinkPad-P17-Gen-1>
Cc:     Zqiang <qiang1.zhang@intel.com>, frederic@kernel.org,
        rcu@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20221019174458.GD5600@paulmck-ThinkPad-P17-Gen-1>
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



> On Oct 19, 2022, at 1:45 PM, Paul E. McKenney <paulmck@kernel.org> wrote:
>=20
> =EF=BB=BFOn Wed, Oct 19, 2022 at 08:12:30AM -0400, Joel Fernandes wrote:
>>> On Oct 19, 2022, at 8:10 AM, Joel Fernandes <joel@joelfernandes.org> wro=
te:
>>>>> On Oct 19, 2022, at 6:34 AM, Zqiang <qiang1.zhang@intel.com> wrote:
>>>>>=20
>>>>> =EF=BB=BFCurrently, regardless of whether the CONFIG_RCU_LAZY is enabl=
ed,
>>>>> invoke the call_rcu() is always lazy, it also means that when
>>>>> CONFIG_RCU_LAZY is disabled, invoke the call_rcu_flush() is also
>>>>> lazy. therefore, this commit make call_rcu() lazy only when
>>>>> CONFIG_RCU_LAZY is enabled.
>>=20
>> First, good eyes!  Thank you for spotting this!!
>>>>> Signed-off-by: Zqiang <qiang1.zhang@intel.com>
>>>>> ---
>>>>> kernel/rcu/tree.c | 8 +++++++-
>>>>> 1 file changed, 7 insertions(+), 1 deletion(-)
>>>>>=20
>>>>> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
>>>>> index abc615808b6e..97ef602da3d5 100644
>>>>> --- a/kernel/rcu/tree.c
>>>>> +++ b/kernel/rcu/tree.c
>>>>> @@ -2839,7 +2839,6 @@ void call_rcu_flush(struct rcu_head *head, rcu_c=
allback_t func)
>>>>>  return __call_rcu_common(head, func, false);
>>>>> }
>>>>> EXPORT_SYMBOL_GPL(call_rcu_flush);
>>>>> -#endif
>>>>>=20
>>>>> /**
>>>>> * call_rcu() - Queue an RCU callback for invocation after a grace peri=
od.
>>>>> @@ -2890,6 +2889,13 @@ void call_rcu(struct rcu_head *head, rcu_callba=
ck_t func)
>>>>>  return __call_rcu_common(head, func, true);
>>>>> }
>>>>> EXPORT_SYMBOL_GPL(call_rcu);
>>>>> +#else
>>>>> +void call_rcu(struct rcu_head *head, rcu_callback_t func)
>>>>> +{
>>>>> +    return __call_rcu_common(head, func, false);
>>>=20
>>> Thanks. Instead of adding new function, you can also pass IS_ENABLED(CON=
FIG=E2=80=A6) to the existing function of the same name.
>=20
> I do like this approach better -- less code, more obvious what is going on=
.

Sounds good. Zqiang, do you mind updating your patch along these lines? That=
 way you get the proper attribution.

More comments below:
>=20
>>> Looks like though I made every one test the patch without having to enab=
le the config option ;-). Hey, I=E2=80=99m a half glass full kind of guy, wh=
y do you ask?
>>>=20
>>> Paul, I=E2=80=99ll take a closer look once I=E2=80=99m at the desk, but w=
ould you prefer to squash a diff into the existing patch, or want a new patc=
h altogether?
>>=20
>> On the other hand, what I=E2=80=99d want is to nuke the config option alt=
ogether or make it default y, we want to catch issues sooner than later.
>=20
> That might be what we do at some point, but one thing at a time.  Let's
> not penalize innocent bystanders, at least not just yet.

It=E2=80=99s a trade off, I thought that=E2=80=99s why we wanted to have the=
 binary search stuff. If no one reports issue on Linux-next, then that code w=
on=E2=80=99t be put to use in the near future at least.

> I do very strongly encourage the ChromeOS and Android folks to test this
> very severely, however.

Agreed. Yes that will happen, though I have to make a note for Android folks=
 other than Vlad, to backports these (and enable the config option), careful=
ly! Especially on pre-5.15 kernels. Luckily I had to do this (not so trivial=
) exercise myself.

Thanks!

 - Joel

>=20
>                            Thanx, Paul
>=20
>> Thanks.
>>=20
>>>=20
>>> Thanks.
>>>=20
>>> - Joel
>>>=20
>>>=20
>>>> +}
>>>> +EXPORT_SYMBOL_GPL(call_rcu);
>>>> +#endif
>>>>=20
>>>> /* Maximum number of jiffies to wait before draining a batch. */
>>>> #define KFREE_DRAIN_JIFFIES (5 * HZ)
>>>> --=20
>>>> 2.25.1
>>>>=20
