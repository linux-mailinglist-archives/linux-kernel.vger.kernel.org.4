Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F8B3600F30
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 14:28:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230110AbiJQM1y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 08:27:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229726AbiJQM1v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 08:27:51 -0400
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 570213AE6F
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 05:27:50 -0700 (PDT)
Received: by mail-qv1-xf34.google.com with SMTP id de14so7278227qvb.5
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 05:27:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vmPKt7sMiB19LKrnjrYu3jxRrwVHfldzFhhLPrKboNQ=;
        b=h405mNfaUMIzd8j2awBC07EI+WNmP3n/rEmL+7WZe9GmZpmdSN/+ZdlNA3AWXTkXz5
         42ig5OnX4/UV9C7HVqf+UhAasD6dA9pMbfJ51Xgq/4Lq3OOtUCbifJyWJDwBm2tLpHf1
         +/qO0tjKRvxZO4ShiDiMXrM+JSbG4CYE4OgHM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vmPKt7sMiB19LKrnjrYu3jxRrwVHfldzFhhLPrKboNQ=;
        b=fCKm8H4meKOKJACRuVUysjPsH+ERjcZ9ra6yZ3+EyiJmS+ItMMPWaP4Xo4m6kv+uiU
         NBZqyjUNp6hS5cVZT7FcaCuPPCvjduXv+bnd6VSLtFzpkbDYSOV3PxDyzygFYH6FKdPI
         SfzZhG3O/ORCP+aqY064oSqb3paRpzFrc7qbXrkFofQYhj1aP1ZjYq6drNGHy1mnCA7S
         hAdd7EfiKBF1EkoC+vn8ztbh+rDsP98M4S63eD2QnBD1lKBpRIqVkcoQU0ZA5VIFC62t
         A2bG1Q0MPNvd1A76Oje0oUamNRd48Ov8fnAfbZM8UobQlGV01BoiIuWTanu8LIeM6ZsI
         wIuA==
X-Gm-Message-State: ACrzQf0P9ZCx0FvtpdOkkJO3xgxcPP1WawmkXSmBkyI9vCHttavaJMRy
        eqVD6AopDAxSG7niWxuYwaO14A==
X-Google-Smtp-Source: AMsMyM6xg4X++bauxNnH1cGbi/lfj7JvwNAmkyNNyziK1L37WIQqHBxjFBeKYYRVoQ5Frl/SW8QzVA==
X-Received: by 2002:a05:6214:f2b:b0:4b1:7b01:6de2 with SMTP id iw11-20020a0562140f2b00b004b17b016de2mr8014317qvb.122.1666009669421;
        Mon, 17 Oct 2022 05:27:49 -0700 (PDT)
Received: from smtpclient.apple (c-73-148-104-166.hsd1.va.comcast.net. [73.148.104.166])
        by smtp.gmail.com with ESMTPSA id d22-20020a376816000000b006ce0733caebsm9027202qkc.14.2022.10.17.05.27.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Oct 2022 05:27:48 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Joel Fernandes <joel@joelfernandes.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [RFC PATCH 00/11] Reviving the Proxy Execution Series
Date:   Mon, 17 Oct 2022 08:27:48 -0400
Message-Id: <4D33BE61-16B9-4E70-9781-FB8F3C791FCA@joelfernandes.org>
References: <5ea4949e-3e8b-2ec0-bdcf-93e5744caee1@bytedance.com>
Cc:     Connor O'Brien <connoro@google.com>, linux-kernel@vger.kernel.org,
        kernel-team@android.com, John Stultz <jstultz@google.com>,
        Joel Fernandes <joelaf@google.com>,
        Qais Yousef <qais.yousef@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>
In-Reply-To: <5ea4949e-3e8b-2ec0-bdcf-93e5744caee1@bytedance.com>
To:     Chengming Zhou <zhouchengming@bytedance.com>
X-Mailer: iPhone Mail (19G82)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Oct 17, 2022, at 12:26 AM, Chengming Zhou <zhouchengming@bytedance.com>=
 wrote:
>=20
> =EF=BB=BFOn 2022/10/17 11:56, Joel Fernandes wrote:
>>=20
>>=20
>>>> On Oct 16, 2022, at 11:25 PM, Chengming Zhou <zhouchengming@bytedance.c=
om> wrote:
>>>=20
>>> =EF=BB=BFHello,
>>>=20
>>>> On 2022/10/4 05:44, Connor O'Brien wrote:
>>>> Proxy execution is an approach to implementing priority inheritance
>>>> based on distinguishing between a task's scheduler context (information=

>>>> required in order to make scheduling decisions about when the task gets=

>>>> to run, such as its scheduler class and priority) and its execution
>>>> context (information required to actually run the task, such as CPU
>>>> affinity). With proxy execution enabled, a task p1 that blocks on a
>>>> mutex remains on the runqueue, but its "blocked" status and the mutex o=
n
>>>> which it blocks are recorded. If p1 is selected to run while still
>>>> blocked, the lock owner p2 can run "on its behalf", inheriting p1's
>>>> scheduler context. Execution context is not inherited, meaning that
>>>> e.g. the CPUs where p2 can run are still determined by its own affinity=

>>>> and not p1's.
>>>=20
>>> This is cool. We have a problem (others should have encountered it too) t=
hat
>>> priority inversion happened when the rwsem writer is waiting for many re=
aders
>>> which held lock but are throttled by CFS bandwidth control. (In our use c=
ase,
>>> the rwsem is the mm_struct->mmap_sem)
>>>=20
>>> So I'm curious if this work can also solve this problem? If we don't deq=
ueue
>>> the rwsem writer when it blocked on the rwsem, then CFS scheduler pick i=
t to
>>> run, we can use blocked chain to find the readers to run?
>>=20
>> That seems a lot harder and unsupported by current patch set AFAICS (my e=
xposure to this work is about a week so take it with a grain of salt). You c=
ould have multiple readers so how would you choose which reader to proxy for=
 (round robin?).  Also, you no longer have a chain but a tree of chains, wit=
h the leaves being each reader - so you have to track that somehow, then kee=
p migrating the blocked tasks in the chain to each readers CPU. Possibly mig=
rating a lot more than in the case of a single chain. Also it=E2=80=99s not c=
lear if it will be beneficial as proxying for one reader does not mean you=E2=
=80=99re improving the situation if it is another reader that is in need of t=
he boost.
>>=20
>=20
> Thanks for your reply, it's indeed more complex than I think, and proxying=
 for just one reader
> is also less efficient.
>=20
> But this rwsem priority inversion problem hurts us so much that we are afr=
aid to use
> CFS bandwidth control now. Imaging when 10 readers held mmap_sem then thro=
ttled for 20ms,
> the writer will have to wait for at least 200ms, which become worse if the=
 writer held other lock.

I hear you. But on the other hand with so many readers the writer is bound t=
o starve anyway. Rwsem is unfair to the writer by definition. But yes, I agr=
ee PE (if made to) can help here. I suggest also look into the per-VMA locks=
 and maple tree work that Suren et all are doing, to improve the situation.

Thanks.

>=20
> Thanks.
>=20
