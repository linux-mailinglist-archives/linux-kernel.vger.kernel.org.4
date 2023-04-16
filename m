Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85FD26E3522
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Apr 2023 07:12:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229894AbjDPFKh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Apr 2023 01:10:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjDPFKf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Apr 2023 01:10:35 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DD632D76
        for <linux-kernel@vger.kernel.org>; Sat, 15 Apr 2023 22:10:34 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id z11-20020a17090abd8b00b0024721c47ceaso9034796pjr.3
        for <linux-kernel@vger.kernel.org>; Sat, 15 Apr 2023 22:10:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1681621834; x=1684213834;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:from:to:cc:subject:date:message-id
         :reply-to;
        bh=804GA9o6cT4dOHo4vnm+vLvNkHGZZYcxMInxuRb8f7c=;
        b=ScdNoKlH4JTMGEiqvR89Q59KZCv7m93l/m1krV52JoGBqCnVV45hI4jCvBZydcvNgF
         Fs1wE6udGBtuFEDTJ9tc9+pnv6YlTMjMaC0bgdEr2DwdJS4ptvcCQMHkk3g34LiOWSHk
         fQhJ0QDP5svSmNiB0lcj08M0n1M6qfeMz1Mv8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681621834; x=1684213834;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=804GA9o6cT4dOHo4vnm+vLvNkHGZZYcxMInxuRb8f7c=;
        b=G0K9xupiVRO1xh7ZZpejT3M5Q39jeKErgGh9tCfxIGZ2tDWEGWlIzXItOqBY1F6Kqs
         C+ttfce0Y39iMry/cnT3lnsiSbpj3fdd7XHTl+Kk5p9A1pgR2K4dUPWyLQufhe7y/MYt
         L/EdlMOjpfQCYiD17TaEx778ajoLyJzCrMGbKWT2SKebjAGdB+u0kLJMrbK32Kp/3P8v
         HAbjw8NMsjnLhIvj5IUQJP9+u0hfB8OXdtVVzT9xCWouokYc89lkVzhsnbB+NM+H72xI
         bXbJ9AScy1HOn2qZEAl0hy+VByXaw9zEVdpdvBOn/rVtqjnV8PynKgNNGJ28yXajGE2i
         KBHQ==
X-Gm-Message-State: AAQBX9de5yaOBcoJSMKWXyp7y/sV7KuKU6ZdNhbkQKyWYKts8YXYKWdC
        9G8/1+rqGKKcJYY/6KuPFKm82g==
X-Google-Smtp-Source: AKy350YACWmbtnA+6mOXh8/PYkPFBlj520MMLnYcxsPHmXPRKXEmJzLrF5AkWzOP4dd2gfyJ/6Ghog==
X-Received: by 2002:a17:902:e812:b0:19f:8ad5:4331 with SMTP id u18-20020a170902e81200b0019f8ad54331mr9770247plg.38.1681621833944;
        Sat, 15 Apr 2023 22:10:33 -0700 (PDT)
Received: from smtpclient.apple ([205.220.129.18])
        by smtp.gmail.com with ESMTPSA id az2-20020a170902a58200b001a27ea5cb94sm5333790plb.87.2023.04.15.22.10.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 15 Apr 2023 22:10:33 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Joel Fernandes <joel@joelfernandes.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH 14/17] sched/eevdf: Better handle mixed slice length
Date:   Sun, 16 Apr 2023 07:10:12 +0200
Message-Id: <A0A2A612-B872-477E-A3B6-A1792EDF691E@joelfernandes.org>
References: <20230414111808.GA144166@lorien.usersys.redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>, mingo@kernel.org,
        linux-kernel@vger.kernel.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, corbet@lwn.net,
        qyousef@layalina.io, chris.hyser@oracle.com,
        patrick.bellasi@matbug.net, pjt@google.com, pavel@ucw.cz,
        qperret@google.com, tim.c.chen@linux.intel.com, joshdon@google.com,
        timj@gnu.org, kprateek.nayak@amd.com, yu.c.chen@intel.com,
        youssefesmat@chromium.org, efault@gmx.de
In-Reply-To: <20230414111808.GA144166@lorien.usersys.redhat.com>
To:     Phil Auld <pauld@redhat.com>
X-Mailer: iPhone Mail (20B101)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Apr 14, 2023, at 1:18 PM, Phil Auld <pauld@redhat.com> wrote:
>=20
> =EF=BB=BFOn Wed, Apr 05, 2023 at 04:05:55PM -0400 Joel Fernandes wrote:
>>> On Wed, Apr 5, 2023 at 4:36=E2=80=AFAM Peter Zijlstra <peterz@infradead.=
org> wrote:
>>>=20
>>> On Tue, Apr 04, 2023 at 01:50:50PM +0000, Joel Fernandes wrote:
>>>>> On Tue, Apr 04, 2023 at 11:29:36AM +0200, Peter Zijlstra wrote:
>>>=20
>>>>> Heh, this is actually the correct behaviour. If you have a u=3D1 and a=

>>>>> u=3D.5 task, you should distribute time on a 2:1 basis, eg. 67% vs 33%=
.
>>>>=20
>>>> Splitting like that sounds like starvation of the sleeper to me. If som=
ething
>>>> sleeps a lot, it will get even less CPU time on an average than it woul=
d if
>>>> there was no contention from the u=3D1 task.
>>>=20
>>> No, sleeping, per definition, means you're not contending for CPU. What
>>> CFS does, giving them a little boost, is strictly yuck and messes with
>>> latency -- because suddenly you have a task that said it wasn't
>>> competing appear as if it were, but you didn't run it (how could you, it=

>>> wasn't there to run) -- but it still needs to catch up.
>>>=20
>>> The reason it does that, is mostly because at the time we didn't want to=

>>> do the whole lag thing -- it's somewhat heavy on the u64 mults and 32bit=

>>> computing was still a thing :/ So hacks happened.
>>=20
>> Also you have the whole "boost tasks" that sleep a lot with CFS right?
>> Like a task handling user input sleeps a lot, but when it wakes up,
>> it gets higher dynamic priority as its vruntime did not advance. I
>> guess EEVDF also gets you the same thing but still messes with the CPU
>> usage?
>>=20
>>> That said; I'm starting to regret not pushing the EEVDF thing harder
>>> back in 2010 when I first wrote it :/
>>>=20
>>>> And also CGroups will be even more weird than it already is in such a w=
orld,
>>>> 2 different containers will not get CPU time distributed properly- say i=
f
>>>> tasks in one container sleep a lot and tasks in another container are C=
PU
>>>> bound.
>>>=20
>>> Cgroups are an abomination anyway :-) /me runs like hell. But no, I
>>> don't actually expect too much trouble there.
>>=20
>> So, with 2 equally weighted containers, if one has a task that sleeps
>> 50% of the time, and another has a 100% task, then the sleeper will
>> only run 33% of the time? I can see people running containers having a
>> problem with that (a customer running one container gets less CPU than
>> the other.). Sorry if I missed something.
>>=20
>=20
> But the 50% sleeper is _asking_ for less CPU.  Doing 50% for each would
> mean that when the sleeper task was awake it always ran, always won, to
> the exclusion of any one else. (Assuming 1 CPU...)
>=20

It sounds like you are saying that if the task busy looped instead of sleepi=
ng, it would get more CPU during the time it is not busy looping but doing s=
ome real work. That sounds like encouraging abuse to get more perf.

But again, I have not looked too closely at EEVDF or Peters patches. I was j=
ust going by Vincents test and was cautioning to not break users who depend o=
n CFS shares..

Cheers,

- Joel


> Cheers,
> Phil
>=20
>> But yeah I do find the whole EEVDF idea interesting but I admit I have
>> to research it more.
>>=20
>> - Joel
>>=20
>=20
> --=20
>=20
