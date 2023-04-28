Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 956B66F1DD8
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Apr 2023 20:13:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346186AbjD1SNS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Apr 2023 14:13:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346225AbjD1SNP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Apr 2023 14:13:15 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66A3859E4
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 11:13:12 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1a950b982d4so548745ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 11:13:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1682705592; x=1685297592;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k4DzREAspzv+9F+ia0lpOSMVfxCtA4Nx7vKfou+aOwE=;
        b=d+6VLxidtChkJY4/WS7CasSpBFZXqUZo6ZmDWxeVkVQYYSEwdgnOEkOPQBCqA+6WwA
         rBG9dWdcdzYt63nMTkb2hTH4Xeftmy/TTvQ3cr06Qd94vBvB2TAdNpDUwU0Ptd5IGHhD
         8ft4KZA1X5fErW4/T9+arum6SKodO2BKgVLSFWGsFDMj4arnTgJ9HvR+XItAVNpIzOEB
         GF++AUen3m1CuMGL6Yqy6YTw8itJjIaKxT6C8Qr+U7dfLq/y+Pe8+6fFp4SEMG11mf4m
         EHYITlMN9tbORerf5g78PCNoLh+neg9gx8Gjws7eA2Tesuyvy3vxA1Y5fKMv1eeJiMoL
         TyVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682705592; x=1685297592;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k4DzREAspzv+9F+ia0lpOSMVfxCtA4Nx7vKfou+aOwE=;
        b=N8W4yuk76UEk+/dYZDKqbdUoOnOpHQLCZ3lLu61wrt6HrxG/zmBfxSe1cPTLJxqVRN
         WM7lLVFnU376pFCkgIYIG4dMlXofxpmdsMs5CPnt+hafnyRygAkT5PH2gvrNOhlzss5F
         SHwaBzT9UZC+PpkI78fT16Mq5Kg5xZBdPkP6lDKvHVRQqo9zKDQ70XBjqQvWGEqBsEd4
         zjKexIzvHupzn1QRmgCUZf+9FvVBHhjqAIpKOlaQPH5pqniy6JOfDlq0lLNctnLYQUUQ
         ObCMSnp39Y3W4ifxSXgL5piHyNeq/K9/re+KSVhnVV0WdqxRbf7yZlxO3sb7gNULum2r
         eNww==
X-Gm-Message-State: AC+VfDzsiTzk47o6I2T9NXAwfMv7SNOczyNoBKp++kpNnDUuSA4kBYq3
        ysHrB9p7mtQ1hmDXulhI5dD4AakILcqkBWJzW/+mxw==
X-Google-Smtp-Source: ACHHUZ5xwx/KmPH4YaopIMhmcJf4lU/VxnJbHHlT3nSV6UuxiEhWSnDBbYK5AfyrD5ke+nFMUmAPhLQ2N+DjVWOGYQQ=
X-Received: by 2002:a17:902:e843:b0:1a6:6b90:a137 with SMTP id
 t3-20020a170902e84300b001a66b90a137mr1640plg.11.1682705591493; Fri, 28 Apr
 2023 11:13:11 -0700 (PDT)
MIME-Version: 1.0
References: <20230416213406.2966521-1-davidai@google.com> <20230419175414.ycnlaperdkjxgypx@airbuntu>
 <20230428115755.7uklfd4fmpoee4dp@airbuntu>
In-Reply-To: <20230428115755.7uklfd4fmpoee4dp@airbuntu>
From:   Saravana Kannan <saravanak@google.com>
Date:   Fri, 28 Apr 2023 11:12:35 -0700
Message-ID: <CAGETcx9xjLzQ2b3FraPsmG=w6=4pYU-tzW-na0Fd5qyrU+C+Yw@mail.gmail.com>
Subject: Re: [RFC PATCH v1] sched/uclamp: Introduce SCHED_FLAG_RESET_UCLAMP_ON_FORK
 flag
To:     Qais Yousef <qyousef@layalina.io>
Cc:     David Dai <davidai@google.com>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Qais Yousef <qyousef@google.com>,
        Quentin Perret <qperret@google.com>, kernel-team@android.com,
        linux-kernel@vger.kernel.org
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

On Fri, Apr 28, 2023 at 4:57=E2=80=AFAM Qais Yousef <qyousef@layalina.io> w=
rote:
>
> On 04/19/23 18:54, Qais Yousef wrote:
>
> [...]
>
> > I was considering to have something a bit more generic that allows sele=
cting
> > which attributes to reset.
> >
> > For example a syscall with SCHED_FLAG_RESET_ON_FORK_SEL combined with
> > SCHED_FLAG_UCLAMP_MIN/MAX will only reset those. This should make it ex=
tensible
> > if we have other similar use cases in the future. The downside it *migh=
t*
> > require to be done in a separate syscall to the one that sets these par=
ameter.
> > But it should be done once.
> >
> > Maybe there's a better interface, but I think it makes sense to do it i=
n a way
> > that we won't have to do this again. Would be good to hear from maintai=
ners
> > first before you take my word for it ;-)
>
> Actually I think we can do a better and simpler generic interface. We don=
't
> need a new flag. We can just add a new parameter for what to reset on for=
k.
> When this value is 0 (which it should be by default), it means reset
> everything.

Isn't he default NOT to reset everything?

> // pseudo code
>
> #define RESET_ON_FORK_ALL       0
> #define RESET_ON_FORK_POLICY    BIT(1) // implies resetting priority
> #define RESET_ON_FORK_PRIORITY  BIT(2)
> #define RESET_ON_FORK_UCLAMP    BIT(3)
>
> struct sched_attr {
>         ...
>         __u64 sched_reset_on_fork_flags;
> };
>

Also, honestly I think this is over designing for a hypothetical. We
have approximately 53 unused bits. By the time we run out of those,
we'd have added at least 20-50 more fields. At that point, we can
always add a flags2 field if we need it. I like David's patch as is --
it's clear and simple. Add a flag for explicitly what we are trying to
do and extend as needed.

-Saravana
