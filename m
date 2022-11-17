Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FBA762DC42
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 14:06:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239623AbiKQNG3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 08:06:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239378AbiKQNG0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 08:06:26 -0500
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E40ED45ED9
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 05:06:24 -0800 (PST)
Received: by mail-qv1-xf2d.google.com with SMTP id h10so1107191qvq.7
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 05:06:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mX++uJXV1qxwrlIs+THLJyL9PZPRKWWId3DO5MTzq1Y=;
        b=Mzg3qp3fyAn20NVgdiv3BmGE6I5b8Uu0fD9r2B7wuSXa/LIj9keUGKeMMCci4K6w26
         ZqTMe4q2TPiu7I3dxMVd5+3tGzD7JwfQia+v5c0ug4mAQnVUxEGaBk0ApK3f+IUqeaDS
         UtZlsRjFqGaZggemALFGtpyfitliqfX12ji4c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mX++uJXV1qxwrlIs+THLJyL9PZPRKWWId3DO5MTzq1Y=;
        b=N7+zwYuy25gLLMZhIBGsj4jMg0M0j1g8+UmDfxxfk93zjzDbouE2gQyDutRsfiyq/3
         +5S7H91o9AeYLil5YbvSrQ8yuYBWdK7ea9QgUJUl4W+uXhPxRjJWx7VWu/fnEILzyUL8
         8hxcOIgItE6cdtoAW4XzdkHghxvPxYNmWqsxs1M/nSawk941Gt6HFnlAMOH4prFZRnGn
         NY392pBocS5bvSp/xN9+XnNfk1E+u9jgiJMJwj+neLodYAMTf5tPixI81GHupWXzLM2c
         j0xXdWZLLobOFeLPTl6EX7cVbQQvBW7KYl4UikTCPYdxJKgyOmot8lQNRy2oXT1lJZIJ
         Nk2Q==
X-Gm-Message-State: ANoB5pmRLbIjHAobIz+BKywesyI8Hi5gMoKxchBl3XofT1XFtwEg2zG9
        mj1vwcjzqXrVI6LO7vsGpb8kLAddD7VB4w==
X-Google-Smtp-Source: AA0mqf7l6yNX/X3oTgtYYRBWUjbNHSxkBG3oW18m49cxVqlKxfMOn5Up9lkt+2PGGd5ikC2Y3JVgsw==
X-Received: by 2002:a05:6214:15d4:b0:4bc:176f:a4fc with SMTP id p20-20020a05621415d400b004bc176fa4fcmr2214237qvz.112.1668690383880;
        Thu, 17 Nov 2022 05:06:23 -0800 (PST)
Received: from smtpclient.apple (c-73-148-104-166.hsd1.va.comcast.net. [73.148.104.166])
        by smtp.gmail.com with ESMTPSA id n1-20020a05620a294100b006fa617ac616sm418803qkp.49.2022.11.17.05.06.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Nov 2022 05:06:23 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Joel Fernandes <joel@joelfernandes.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v2] rcu/kfree: Do not request RCU when not needed
Date:   Thu, 17 Nov 2022 08:06:21 -0500
Message-Id: <1AF9A4B1-A9E2-4461-99E0-4CEC2E3AFA1F@joelfernandes.org>
References: <Y3YwDuKibmOiz6/7@pc636>
Cc:     paulmck@kernel.org, linux-kernel@vger.kernel.org,
        rcu@vger.kernel.org
In-Reply-To: <Y3YwDuKibmOiz6/7@pc636>
To:     Uladzislau Rezki <urezki@gmail.com>
X-Mailer: iPhone Mail (19G82)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Nov 17, 2022, at 7:58 AM, Uladzislau Rezki <urezki@gmail.com> wrote:
>=20
> =EF=BB=BFOn Wed, Nov 16, 2022 at 10:05:46PM +0000, Joel Fernandes wrote:
>>> On Wed, Nov 16, 2022 at 7:19 PM Uladzislau Rezki <urezki@gmail.com> wrot=
e:
>>>=20
>>> Hello, Paul, Joel.
>>>=20
>>>>>=20
>>>>> Yes sure, I am doing a run now with my patch. However, I have a
>>>>> question -- why do you feel blocking in the kworker is not an issue?
>>>>> You are taking a snapshot before queuing the normal kwork and then
>>>>> reading the snapshot when the normal kwork runs. Considering it is a
>>>>> high priority queue, the delay between when you are taking the
>>>>> snapshot, and reading it is likely small so there is a bigger chance
>>>>> of blocking in cond_synchronize_rcu(). Did I miss something?
>>>>>=20
>>>> We can wait indeed in the reclaim worker. But the worker does not do an=
y
>>>> nasty or extra work here. If there is a need we block and wait. After a=

>>>> grace period, we are awoken and proceed.
>>>>=20
>>>> Therefore i do not see the reason in handling two cases:
>>>>=20
>>>> if (gp_done)
>>>>    queue_work();
>>>> else
>>>>    queue_rcu_work();
>>>>=20
>>>> it is the same if we just queue the work and check on entry. The curren=
t
>>>> scenario is: queue the work after a grace period. This is the differenc=
e.
>>>>=20
>>>> Right if the reclaimer was a high prio kthread a time would be shorter.=

>>>>=20
>>>> In your scenario the time seems even shorter(i have not checked) becaus=
e
>>>> you update a snapshot of krcp each time a kvfree_rcu() is invoked. So
>>>> basically even though you have objects whose grace period is passed you=

>>>> do not separate it anyhow. Because you update the:
>>>>=20
>>>> krcp->gp_snap =3D get_state_synchronize_rcu();
>>>>=20
>>>> too often.
>>>>=20
>>> Once upon a time we discussed that it is worth to keep track of GP
>>> per-a-page in order to reduce a memory footprint. Below patch addresses
>>> it:
>>=20
>> In the patch below, it appears you are tracking the GP per krwp, and
>> not per page. But I could be missing something - could you split it
>> into separate patches for easier review?
>>=20
> I will split. I was thinking about it. The GP is tracked per-a-page. As fo=
r
> krwp it is only for channel_3. Everything goes there if no-page or no cach=
e.
>=20
Ah, ok.

>>=20
>> Also it still does cond_synchronize_rcu() :-(
>>=20
> Sometimes we need to wait for a GP we can not just release :)

You know that is not what I meant ;) I was concerned about the blocking.

Thanks,

 - Joel=20

>=20
> --
> Uladzislau Rezki
