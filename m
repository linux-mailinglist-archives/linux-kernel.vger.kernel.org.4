Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B6927477C0
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 19:28:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229610AbjGDR2a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 13:28:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230256AbjGDR20 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 13:28:26 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFA2610D5
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jul 2023 10:28:24 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id 38308e7fff4ca-2b698937f85so97718071fa.2
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jul 2023 10:28:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1688491703; x=1691083703;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vj6prjYgCz+OJ6VBMNkshSba4mEisihuW2iEwzn3epM=;
        b=kSsq7DA2FSbUhRUmoAvyo8d688tglP3OPUlHshPbPpuaRGjPtWyT6BNiUGV1q/Emld
         uyM5jZAfRt8jZQVMMa0HVMJtzICcPV+TKZ3YZZbisoZfRa15te/ALBE1tKLtZWkhrC/K
         wYE8ztb0bqBY1ZJe9//3RzbKxTm9bY9j+cb90=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688491703; x=1691083703;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Vj6prjYgCz+OJ6VBMNkshSba4mEisihuW2iEwzn3epM=;
        b=Bo//meo8xcEqDVaF/BcM1fhB1w8vWcBi8dmyN9dR8AanpMGIvTRB+17R4lVdWF0GLR
         7bokurUi7TxO0UlcW+WJvCdsVY8gKvKN6SAyugh3dbOMfHwAIKTTl8Nj3A0qFMrRs1s3
         6hAAva9B/6eXSx8u6JMrqtukhYyUdO51c4skC8TCGmwCMUtwOYSeZPQJ/XDmmPs6hfo+
         TKJ31L8OOxHzFGc4hW365XaZ0qBrVAtB279eyZOMSOvWwk+PfuSO6wdWtbcrWdxUQkx2
         tTOTM7hUluo1zUw6MAn7JWu3oXf5UCRi4R4Uiowo4sW9UTRMGIJsU4YhZuIV7vUo6fM9
         hxhw==
X-Gm-Message-State: ABy/qLaKmPQh6Y/WYgMne8hKd1FeqZzxHLcg7jTErD+yOj1GIdsvyG9T
        59nYfeMB5A5uVRxGHplwKxNPTiBm5bxGJjA3Vw5Qdw==
X-Google-Smtp-Source: APBJJlHGSOT+bmpQeV1NeS4bgwAL7PAC6ODGZc3Mc/MytG+pzsfrqEklhu1GrwQOfUHzMj5J1I1Dlo0yY5ankPod9SA=
X-Received: by 2002:a2e:94d7:0:b0:2b6:dd78:2a8e with SMTP id
 r23-20020a2e94d7000000b002b6dd782a8emr6359314ljh.50.1688491702788; Tue, 04
 Jul 2023 10:28:22 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1686239016.git.bristot@kernel.org> <e08a76013ff2b6a83028e8fdf3b8a6a0aa677d58.1686239016.git.bristot@kernel.org>
 <xhsmhpm5mw2gm.mognet@vschneid.remote.csb> <70837b44-4d21-9d70-d13b-2b6168fd02e3@redhat.com>
 <CAEXW_YS3vkhdggmOaB2_Y9NL7a9Fi8ZamN3mpbBDCvVa4e3W4Q@mail.gmail.com>
In-Reply-To: <CAEXW_YS3vkhdggmOaB2_Y9NL7a9Fi8ZamN3mpbBDCvVa4e3W4Q@mail.gmail.com>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Tue, 4 Jul 2023 13:28:10 -0400
Message-ID: <CAEXW_YRArM0C7ih92LJAdk=Sdgz8cu-vGT_P8=RfZanT_Sobww@mail.gmail.com>
Subject: Re: [RFC PATCH V3 4/6] sched/deadline: Introduce deadline servers
To:     Daniel Bristot de Oliveira <bristot@redhat.com>
Cc:     Valentin Schneider <vschneid@redhat.com>,
        Daniel Bristot de Oliveira <bristot@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        linux-kernel@vger.kernel.org,
        Luca Abeni <luca.abeni@santannapisa.it>,
        Tommaso Cucinotta <tommaso.cucinotta@santannapisa.it>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vineeth Pillai <vineeth@bitbyteword.org>,
        Shuah Khan <skhan@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 4, 2023 at 1:25=E2=80=AFPM Joel Fernandes <joel@joelfernandes.o=
rg> wrote:
>
> On Tue, Jul 4, 2023 at 11:52=E2=80=AFAM Daniel Bristot de Oliveira
> <bristot@redhat.com> wrote:
> >
> >
> > Back from EOSS...
> >
> > On 6/23/23 18:47, Valentin Schneider wrote:
> > > On 08/06/23 17:58, Daniel Bristot de Oliveira wrote:
> > >> @@ -2033,9 +2147,20 @@ static struct task_struct *pick_next_task_dl(=
struct rq *rq)
> > >>      struct task_struct *p;
> > >>
> > >>      p =3D pick_task_dl(rq);
> > >> -    if (p)
> > >> +    if (!p)
> > >> +            return p;
> > >> +
> > >> +    /*
> > >> +     * XXX: re-check !dl_server, changed from v2 because of
> > >> +     * pick_next_task_dl change
> > >> +     */
> > >> +    if (!dl_server(&p->dl))
> > >>              set_next_task_dl(rq, p, true);
> > >>
> > >
> > > Should this be
> > >
> > >        if (!p->server)
> > >
> > > instead? AFAICT dl_server(&p->dl) can never be true since there's no
> > > pi_se-like link to the server via the dl_se, only via the task_struct=
, and
> > > the server pick cannot return the server itself (as it's a pure sched=
_entity).
> >
> > makes sense... I will check that in the v4.
>
> Makes sense to me too. Since p is either a real DL task or a CFS task,
> "if (dl_server(&p->dl))" is incorrect.  "if (p->server)" is the right
> check.

Grr, "if (!p->server)" I mean. Which ensures that set_next_task_dl()
is not called on a non-DL task.

 - Joel
