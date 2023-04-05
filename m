Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DB466D8AD0
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 00:54:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229379AbjDEWyY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 18:54:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjDEWyW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 18:54:22 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C07522115
        for <linux-kernel@vger.kernel.org>; Wed,  5 Apr 2023 15:54:21 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id d17so37684151wrb.11
        for <linux-kernel@vger.kernel.org>; Wed, 05 Apr 2023 15:54:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680735260;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7o5GgVU7z5k3433DlqPupRo8Cvgy27yFx7WOeby8kIE=;
        b=tGCNt1AXOcis7NJe2FaI4KQysuzeG7Yjjz5iUS2EdPJMcKs1jBqnfTMK2uswTiTENd
         vpHFc5MVXJpfR+OYiNatBxNAotq5WQrvQSeoBle/KsgFZBXYb4CSwV++MlL1kz0s3Rgx
         RYpSVN/PW3iJ5NHiQ55/pfUxNJxWS3EvsLe5IcWeoe++qvCV4+N3SPLQ+2BXy3jZveyv
         21ui/pifk1k749C841IqQWaKvc2Gs+yb7UvD+by/BoOR5jDEK5GmyhZi1iUwOpJqSWag
         QIzPmI7JQtJ78Vzlo9CuXFKlZZvcL9u3s+hqnNpoH0nee9aN+An7cVrlDbC/A6jme0UH
         Y36A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680735260;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7o5GgVU7z5k3433DlqPupRo8Cvgy27yFx7WOeby8kIE=;
        b=NckW0YPrKTJ+rivxOuJ1QZkFL5vEoK8k+CL10xWxT1tJPuq2I/RJlFNrU2OIhW7iWl
         JeW23QV1JHsee48Iu2EmEIWxvtwcoLWoiP0wf/hVRhYV8xc6uSRhKHkHG7H1nBs9eb2J
         XrhmRk6URg9gNYoclYAodGNairfQNX/Sa9lL31Hv2d0Ljcp6wlSikTzaodlQw6Pbdt2C
         8XXJ5y/96XgAExOrEs2ZSRF7ZyXjHkjYqAIIKfeui52p24QbdfsgoFs5W868ty2d8zAz
         N9qPd+HoNhUv0deqnKaY2UmCuj+RIBBkIy2QYaXhYpVW06Ld38fWqgdItUyq2RzbTXR1
         n4Eg==
X-Gm-Message-State: AAQBX9ewWArfAHVzUVDWJo3BaagVeihB9pLAf2gIcjBgvPdLNIigEbK9
        fFMsI+gz9XQlWdy/DiBgb+umm4fEsl+xkoDfYewpTw==
X-Google-Smtp-Source: AKy350ZscqY3b6tBXXMKfuK1PwbdL4HHEBURc1ZrigEfSsLmvFqehpps13I7djWA6Vy64QiFDOkG+u1sznJD+zhudeE=
X-Received: by 2002:adf:fdc9:0:b0:2e5:18d6:8648 with SMTP id
 i9-20020adffdc9000000b002e518d68648mr1596741wrs.6.1680735260070; Wed, 05 Apr
 2023 15:54:20 -0700 (PDT)
MIME-Version: 1.0
References: <20230330224348.1006691-1-davidai@google.com> <20230330224348.1006691-2-davidai@google.com>
 <20230405081449.GX4253@hirez.programming.kicks-ass.net>
In-Reply-To: <20230405081449.GX4253@hirez.programming.kicks-ass.net>
From:   David Dai <davidai@google.com>
Date:   Wed, 5 Apr 2023 15:54:08 -0700
Message-ID: <CABN1KCLjXpxNak90iowd0iiz9SD8-5n+6S3kEoCKO9NantyXxg@mail.gmail.com>
Subject: Re: [RFC PATCH 1/6] sched/fair: Add util_guest for tasks
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Saravana Kannan <saravanak@google.com>,
        kernel-team@android.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-15.7 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 5, 2023 at 1:14=E2=80=AFAM Peter Zijlstra <peterz@infradead.org=
> wrote:
>

Hi Peter,

Appreciate your time,

> On Thu, Mar 30, 2023 at 03:43:36PM -0700, David Dai wrote:
> > @@ -499,6 +509,7 @@ struct sched_avg {
> >       unsigned long                   load_avg;
> >       unsigned long                   runnable_avg;
> >       unsigned long                   util_avg;
> > +     unsigned long                   util_guest;
> >       struct util_est                 util_est;
> >  } ____cacheline_aligned;
> >
>
> Yeah, no... you'll have to make room first.
>

I=E2=80=99m not sure what you mean. Do you mean making room by reducing
another member in the same struct? If so, which member would be a good
fit to shorten? Or do you mean something else entirely?

Thanks,
David

> struct sched_avg {
>         /* typedef u64 -> __u64 */ long long unsigned int     last_update=
_time;          /*     0     8 */
>         /* typedef u64 -> __u64 */ long long unsigned int     load_sum;  =
                /*     8     8 */
>         /* typedef u64 -> __u64 */ long long unsigned int     runnable_su=
m;              /*    16     8 */
>         /* typedef u32 -> __u32 */ unsigned int               util_sum;  =
                /*    24     4 */
>         /* typedef u32 -> __u32 */ unsigned int               period_cont=
rib;            /*    28     4 */
>         long unsigned int          load_avg;                             =
                /*    32     8 */
>         long unsigned int          runnable_avg;                         =
                /*    40     8 */
>         long unsigned int          util_avg;                             =
                /*    48     8 */
>         struct util_est {
>                 unsigned int       enqueued;                             =
                /*    56     4 */
>                 unsigned int       ewma;                                 =
                /*    60     4 */
>         } __attribute__((__aligned__(8)))util_est __attribute__((__aligne=
d__(8))); /*    56     8 */
>
>         /* size: 64, cachelines: 1, members: 9 */
>         /* forced alignments: 1 */
> } __attribute__((__aligned__(64)));
>
>
