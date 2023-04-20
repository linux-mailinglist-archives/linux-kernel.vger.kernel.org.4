Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE2AA6E8740
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 03:12:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232996AbjDTBMJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 21:12:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232931AbjDTBMD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 21:12:03 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56A0D4C13
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 18:11:59 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id l31-20020a05600c1d1f00b003f1718d89b2so2345093wms.0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 18:11:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1681953118; x=1684545118;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=22Jgp2NNHKhZ/txW70k+3rxBOHsE9mfQXDpWkcdvQ1A=;
        b=3qFjTJuB0QEcNjYY9SNTfPND8ZW629fUAbmssX9cWFjL67ZJNCdv+vg7bPuxf9Z09+
         E8rAF9D/kq8hebxc+KAzheuGKASqLQVKzzPxyt7ydbQ5Q6ujuJV9Jd3/6r9H0pwB0UjQ
         Un34UzFEorIGPEXZcrMznDVEdhNwr/BjBA98axOxehPASFa5Rvf9SIcPGSOIV0Yw1ISJ
         TPkLrvabDwJAUfIayVzLhJAsrSkvqLPUXp/5Omlb//KoUTN7wunAlX3wYnXCpR2BJ5Of
         Kn//oqn70IdV/4fNJ4MJFixnCA2M8+WPbe30jogsknU9YI4vtiU7b+c1Un9uJYjiZnoR
         1X6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681953118; x=1684545118;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=22Jgp2NNHKhZ/txW70k+3rxBOHsE9mfQXDpWkcdvQ1A=;
        b=ZdUWtauu+9RR3GnMvIZez7ekWRy33F7QGccBvyK4W2r9VW9+cu2MrSf38IvfS2VPdi
         Ql3uaD/oOC9HIzq8OqL/2jAXrNkbBBPZSn0Wd3TlD628pX9UgIHPntJ3Lm4h6oN+OtRS
         RSaTC8nhlcM10N/rQ0N2YOL9Lk52o5qrTYEZ+CJbpKXbFBb/v5lBl4u6WiqzAck4b7U0
         HW4KGFP+SV3oiqMHERkhjr6+Q1ay7P3JCa13xpNski58xZLFXQ8BkLdBD5y2bEKohAA+
         0RK9AkyW7++FO5kAhBvV49ovM1wJy5kWK3zQfUs1yxktEXB+RzBa6qOQP9qOjJOfHg/L
         5DOQ==
X-Gm-Message-State: AAQBX9f4gl8TIdaPw8fIN7x/hlw1n0cRHCP6nwmojFh2bbEOk82vFH72
        lfu3l7w34rTeONFJj6f+eRIGm/FL3C2e2e/x8JmuWw==
X-Google-Smtp-Source: AKy350b7viMm1uEj5omqxonCorlqcxfd1m9G20DZYWLd4GiX8Ii8uT0q0iIsxaJ2W54O2USAaUOUOgRK79fl5NKTnFs=
X-Received: by 2002:a05:600c:2305:b0:3f1:728a:1881 with SMTP id
 5-20020a05600c230500b003f1728a1881mr9505707wmo.31.1681953117561; Wed, 19 Apr
 2023 18:11:57 -0700 (PDT)
MIME-Version: 1.0
References: <20230416213406.2966521-1-davidai@google.com> <d83950c4-7458-aeea-f341-327c163704a8@arm.com>
In-Reply-To: <d83950c4-7458-aeea-f341-327c163704a8@arm.com>
From:   David Dai <davidai@google.com>
Date:   Wed, 19 Apr 2023 18:11:46 -0700
Message-ID: <CABN1KC+_HDi_i2zzpZVbqiUP5-QB9YrE5wzLqr==_wOemaCXzA@mail.gmail.com>
Subject: Re: [RFC PATCH v1] sched/uclamp: Introduce SCHED_FLAG_RESET_UCLAMP_ON_FORK
 flag
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Qais Yousef <qyousef@google.com>,
        Quentin Perret <qperret@google.com>,
        Saravana Kannan <saravanak@google.com>,
        kernel-team@android.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 18, 2023 at 10:18=E2=80=AFPM Dietmar Eggemann
<dietmar.eggemann@arm.com> wrote:
>

Hi Dietmar, thanks for your time,

> On 16/04/2023 23:34, David Dai wrote:
> > A userspace service may manage uclamp dynamically for individual tasks =
and
> > a child task will unintentionally inherit a pesudo-random uclamp settin=
g.
> > This could result in the child task being stuck with a static uclamp va=
lue
>
> Could you explain this with a little bit more detail? Why isn't the
> child task also managed by the userspace service?

See Qais=E2=80=99 reply that contains more detail on how it=E2=80=99s being=
 used in
Android. In general, if a dynamic userspace service will adjust uclamp
on the fly for a given task, but has no knowledge or control over if
or when a task forks. Depending on the timing of the fork, a child
task may inherit a very large or a small uclamp_min or uclamp_max
value. The intent of this patch is to provide more flexibility to the
uclamp APIs such that child tasks do not get stuck with a poor uclamp
value when spawned while retaining other sched attributes. When
RESET_ON_FORK is set on the parent task, it will reset uclamp values
for the child but also reset other sched attributes as well.

>
> The child task will only make a difference if it's on the rq.
>
> Does this issue happen with uclamp mainline or only with Android's
> slightly different version (max- vs. sum aggregation)?

I=E2=80=99m using the version of uclamp that=E2=80=99s in Linus=E2=80=99 tr=
ee. How uclamp is
aggregated is unrelated to the problem I=E2=80=99m trying to solve with thi=
s
patch. Which is to extend the uclamp APIs to have finer control for
the uclamp inheritance of child tasks.

Thanks,
David

>
> > that results in poor performance or poor power.
> >
> > Using SCHED_FLAG_RESET_ON_FORK is too coarse for this usecase and will
> > reset other useful scheduler attributes. Adding a
> > SCHED_FLAG_RESET_UCLAMP_ON_FORK will allow userspace to have finer cont=
rol
> > over scheduler attributes of child processes.
>
> [...]
>
