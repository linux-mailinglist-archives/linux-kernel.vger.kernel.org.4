Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C29B77477BC
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 19:26:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231218AbjGDR0F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 13:26:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229615AbjGDR0E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 13:26:04 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07141E76
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jul 2023 10:26:03 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id 38308e7fff4ca-2b6f9edac8dso11985651fa.3
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jul 2023 10:26:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1688491561; x=1691083561;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J3DzlEIK3VQkSx1rkZscROCQHkagDt9CFs2s1aPNi+0=;
        b=W/f0RbbpH373Lb+jlIoNdUX3QZVvg8+fGkg2qvftQAAvT081nnSdrFcLsu/yhaxXpe
         LoPUEEEmpt1G1K/stHKPYB2RNf0Wl7RmpRJ2YSl02YZIyAK8pm0kHSGVaGb1m5U/gHVD
         6Azp6nit/ZXFQafN4vCI5knjK+9Rw6dq7lrRQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688491561; x=1691083561;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J3DzlEIK3VQkSx1rkZscROCQHkagDt9CFs2s1aPNi+0=;
        b=K5RYX6Sb6Todo3NbqXlzxN8zhajshNpDqCYm54yRJE52cWvPt40SFlHkM8R1ta5qsy
         OP+47MSTG6Lf1fboH3kjybehcnTbeIr97uin7+5kLeRMJ9JXikFzNbHdbYFyvk6i9s4n
         hyyMpuv6KJopXcK+X+UYKz4NJX1kZtFWd90m3ZjMhlYaKA7f4Uuyfxe72BFDG9IpABwX
         kzumQ5Di85MndzuWnNxkAILrWtPsFdroeZVngHZy7XFSlIKUdOWx8LohgQUGlo4epWEf
         YjQv+x4KVIgPyxSqreXu1kzjtgRn1XD1Z14ZhaA/KNOBWtWYyhDPjY7fU+1tPs9wGH68
         Ywqg==
X-Gm-Message-State: ABy/qLaRgKroo4Fh3hLn4zffMqeZue3fq+vv8NltftAZfb/pRf09c/eI
        uwLe5eFQMRMclOXyRAm/yNdT+gcl5Y5aTjX4rBQYqw==
X-Google-Smtp-Source: APBJJlG8+l/84etZVoJlausDLa8mM7trb1otYtsvE+NIeg1QK9UFGBW7BqihXpI4zXMQ3p01Oc9lF8hYA9R3l3GBzRc=
X-Received: by 2002:a05:651c:105a:b0:2b6:d8d4:f871 with SMTP id
 x26-20020a05651c105a00b002b6d8d4f871mr6704935ljm.40.1688491560875; Tue, 04
 Jul 2023 10:26:00 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1686239016.git.bristot@kernel.org> <e08a76013ff2b6a83028e8fdf3b8a6a0aa677d58.1686239016.git.bristot@kernel.org>
 <xhsmhpm5mw2gm.mognet@vschneid.remote.csb> <70837b44-4d21-9d70-d13b-2b6168fd02e3@redhat.com>
In-Reply-To: <70837b44-4d21-9d70-d13b-2b6168fd02e3@redhat.com>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Tue, 4 Jul 2023 13:25:49 -0400
Message-ID: <CAEXW_YS3vkhdggmOaB2_Y9NL7a9Fi8ZamN3mpbBDCvVa4e3W4Q@mail.gmail.com>
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

On Tue, Jul 4, 2023 at 11:52=E2=80=AFAM Daniel Bristot de Oliveira
<bristot@redhat.com> wrote:
>
>
> Back from EOSS...
>
> On 6/23/23 18:47, Valentin Schneider wrote:
> > On 08/06/23 17:58, Daniel Bristot de Oliveira wrote:
> >> @@ -2033,9 +2147,20 @@ static struct task_struct *pick_next_task_dl(st=
ruct rq *rq)
> >>      struct task_struct *p;
> >>
> >>      p =3D pick_task_dl(rq);
> >> -    if (p)
> >> +    if (!p)
> >> +            return p;
> >> +
> >> +    /*
> >> +     * XXX: re-check !dl_server, changed from v2 because of
> >> +     * pick_next_task_dl change
> >> +     */
> >> +    if (!dl_server(&p->dl))
> >>              set_next_task_dl(rq, p, true);
> >>
> >
> > Should this be
> >
> >        if (!p->server)
> >
> > instead? AFAICT dl_server(&p->dl) can never be true since there's no
> > pi_se-like link to the server via the dl_se, only via the task_struct, =
and
> > the server pick cannot return the server itself (as it's a pure sched_e=
ntity).
>
> makes sense... I will check that in the v4.

Makes sense to me too. Since p is either a real DL task or a CFS task,
"if (dl_server(&p->dl))" is incorrect.  "if (p->server)" is the right
check.

Optionally, a BUG_ON() as well could be added to make sure the p
returned by pick_task_dl() is always false:
BUG_ON(dl_server(&p->dl));

thanks,

 - Joel



>
> >
> >> +    /* XXX not quite right */
> >> +    if (hrtick_enabled(rq))
> >> +            start_hrtick_dl(rq, &p->dl);
> >> +
> >
> > IIUC that got hauled out of set_next_task_dl() to cover the case where =
we
> > pick the server (+ the server pick) and want to more thoroughly enforce=
 the
> > server's bandwidth. If so, what's the issue with starting the hrtick he=
re?
>
> I think that the commend was added more as a check if it is correct... it=
 seems it is.
>
> Thanks Vale!
> -- Daniel
>
> >
> >>      return p;
> >>  }
> >>
> >
>
