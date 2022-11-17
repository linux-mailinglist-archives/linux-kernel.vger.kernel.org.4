Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8404F62DC8E
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 14:23:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239956AbiKQNXm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 08:23:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239967AbiKQNXi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 08:23:38 -0500
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B120E17046
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 05:23:32 -0800 (PST)
Received: by mail-qv1-xf34.google.com with SMTP id i12so1160175qvs.2
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 05:23:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:from:to:cc:subject:date:message-id
         :reply-to;
        bh=P4qE9RTmLTvrWv23dU+LZNw4qYAOY7fS7onaXUzE0KE=;
        b=hCgwdYKJAabgQcG7x7Z5xhvq/SHD0Zb7OxSrL9ICbK+vw9MifK7iAQRL6b7ew/68vk
         upRDnHFRIfKf6apYbyKsvxDKZi8ktRxFjqK9fizdwCT/yedtDvrWJd3QHY8PtegqezR2
         XNa5fXdQ2M8Iovz6JKGLtSYiX1rLVbupFnI6k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P4qE9RTmLTvrWv23dU+LZNw4qYAOY7fS7onaXUzE0KE=;
        b=ip9cCiJ1Ou4igzu3IATK8e6qunV9dJcioHSRDDBECZDYlZuEmxaoA0YGiq5APzfrbK
         NmLlGXhzStXKZQ3LVjYRWg2FZFAtc5PKe517oPl85DvxeVEBSbveEgEDtlPGGn3mI2PM
         epUiQrVwPeBkh0zGY8tdMff8InI56YqDkwPc4dUSXF/wvIDjKLBX6OMYoT2J7BbUOJG6
         dDp8yd79V8tMJgS9rc4K2AiVxr+0Tl6C8fCBtSMeStnaXBnPFFrc6R4F0sVezSsZxtH/
         McVzyApX5kAT6d19JwHlmJwcuHVzlRBCLoq4qOdz+p7UTMLVhUcD+OgMjzP9ucnOLc35
         dC1A==
X-Gm-Message-State: ANoB5pkZ2qS7xY3foz3WL8OeaRKTFBMpsx3+fdeJrGuvIzQh52g1YG8s
        b5hldzla52U4nJ5qgByjltkrepTuFmoQkg==
X-Google-Smtp-Source: AA0mqf5xndxZ8iAeDsaSH/FxEPM9+KbqDuWBUmYEtwMIhFyeeODi0zo5VnEW3+siC1GYw2GAM9n1FQ==
X-Received: by 2002:a0c:ea88:0:b0:4bb:8304:23b1 with SMTP id d8-20020a0cea88000000b004bb830423b1mr2332515qvp.15.1668691411529;
        Thu, 17 Nov 2022 05:23:31 -0800 (PST)
Received: from smtpclient.apple (c-73-148-104-166.hsd1.va.comcast.net. [73.148.104.166])
        by smtp.gmail.com with ESMTPSA id dm50-20020a05620a1d7200b006fb7f94a65bsm448221qkb.44.2022.11.17.05.23.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Nov 2022 05:23:31 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Joel Fernandes <joel@joelfernandes.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v2] rcu/kfree: Do not request RCU when not needed
Date:   Thu, 17 Nov 2022 08:23:30 -0500
Message-Id: <938BD0DD-9F91-44E6-BCBA-3DA3FA6779C0@joelfernandes.org>
References: <Y3YzCi9exKhiAAd0@pc636>
Cc:     paulmck@kernel.org, linux-kernel@vger.kernel.org,
        rcu@vger.kernel.org
In-Reply-To: <Y3YzCi9exKhiAAd0@pc636>
To:     Uladzislau Rezki <urezki@gmail.com>
X-Mailer: iPhone Mail (19G82)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,MIME_QP_LONG_LINE,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Nov 17, 2022, at 8:11 AM, Uladzislau Rezki <urezki@gmail.com> wrote:
>=20
> =EF=BB=BFOn Thu, Nov 17, 2022 at 08:06:21AM -0500, Joel Fernandes wrote:
>>=20
>>=20
>>>> On Nov 17, 2022, at 7:58 AM, Uladzislau Rezki <urezki@gmail.com> wrote:=

>>>=20
>>> =EF=BB=BFOn Wed, Nov 16, 2022 at 10:05:46PM +0000, Joel Fernandes wrote:=

>>>>> On Wed, Nov 16, 2022 at 7:19 PM Uladzislau Rezki <urezki@gmail.com> wr=
ote:
>>>>>=20
>>>>> Hello, Paul, Joel.
>>>>>=20
>>>>>>>=20
>>>>>>> Yes sure, I am doing a run now with my patch. However, I have a
>>>>>>> question -- why do you feel blocking in the kworker is not an issue?=

>>>>>>> You are taking a snapshot before queuing the normal kwork and then
>>>>>>> reading the snapshot when the normal kwork runs. Considering it is a=

>>>>>>> high priority queue, the delay between when you are taking the
>>>>>>> snapshot, and reading it is likely small so there is a bigger chance=

>>>>>>> of blocking in cond_synchronize_rcu(). Did I miss something?
>>>>>>>=20
>>>>>> We can wait indeed in the reclaim worker. But the worker does not do a=
ny
>>>>>> nasty or extra work here. If there is a need we block and wait. After=
 a
>>>>>> grace period, we are awoken and proceed.
>>>>>>=20
>>>>>> Therefore i do not see the reason in handling two cases:
>>>>>>=20
>>>>>> if (gp_done)
>>>>>>   queue_work();
>>>>>> else
>>>>>>   queue_rcu_work();
>>>>>>=20
>>>>>> it is the same if we just queue the work and check on entry. The curr=
ent
>>>>>> scenario is: queue the work after a grace period. This is the differe=
nce.
>>>>>>=20
>>>>>> Right if the reclaimer was a high prio kthread a time would be shorte=
r.
>>>>>>=20
>>>>>> In your scenario the time seems even shorter(i have not checked) beca=
use
>>>>>> you update a snapshot of krcp each time a kvfree_rcu() is invoked. So=

>>>>>> basically even though you have objects whose grace period is passed y=
ou
>>>>>> do not separate it anyhow. Because you update the:
>>>>>>=20
>>>>>> krcp->gp_snap =3D get_state_synchronize_rcu();
>>>>>>=20
>>>>>> too often.
>>>>>>=20
>>>>> Once upon a time we discussed that it is worth to keep track of GP
>>>>> per-a-page in order to reduce a memory footprint. Below patch addresse=
s
>>>>> it:
>>>>=20
>>>> In the patch below, it appears you are tracking the GP per krwp, and
>>>> not per page. But I could be missing something - could you split it
>>>> into separate patches for easier review?
>>>>=20
>>> I will split. I was thinking about it. The GP is tracked per-a-page. As f=
or
>>> krwp it is only for channel_3. Everything goes there if no-page or no ca=
che.
>>>=20
>> Ah, ok.
>>=20
>>>>=20
>>>> Also it still does cond_synchronize_rcu() :-(
>>>>=20
>>> Sometimes we need to wait for a GP we can not just release :)
>>=20
>> You know that is not what I meant ;) I was concerned about the blocking.
>>=20
> Let me split. After that we/you can test and check if there is any issue
> with sleeping on entry for waiting a GP if needed.

Ack. What I=E2=80=99ll also do is, whenever you split it, I=E2=80=99ll put i=
t on ChromeOS and see in real world, how many times we block. It could be I=E2=
=80=99m missing something of how polled GP works.

thanks,

 - Joel=20

>=20
> --
> Uladzislau Rezki
