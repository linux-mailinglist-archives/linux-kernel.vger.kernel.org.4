Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C8D66FEBAD
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 08:19:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237120AbjEKGTs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 02:19:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237096AbjEKGTp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 02:19:45 -0400
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com [IPv6:2607:f8b0:4864:20::1133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24C3A5265
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 23:19:40 -0700 (PDT)
Received: by mail-yw1-x1133.google.com with SMTP id 00721157ae682-559e53d1195so118561967b3.2
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 23:19:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1683785979; x=1686377979;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b18qtmniAi+AEeCXApPuuoSxsIi2qci+TPfIML3CctA=;
        b=CpdestOwKbifbG3w2RZxDl/clLet3qrBtU3nj7nChXpZpbS4qrwLbiEO/egmYRDQ+F
         gDoJlu08T24uEJPSwxEQXEaMrSrGbGGBoC4w1e6JcKNR0hxARwrm+AKJ6YTmqcrZi61+
         2H0vqX+Sl0AAak7cXEfPP+7069cet3qTdl/t4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683785979; x=1686377979;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b18qtmniAi+AEeCXApPuuoSxsIi2qci+TPfIML3CctA=;
        b=JKl5R3qmrkyY2wSMKpsQ5KbzDHXf2o6Qlveld6y1zhKjb4rh5t/L8BMSdD6ZrR5VK3
         wld/+CGBNcKtac2NHjrx/y8wtgFB8R7Y4sN4wfe/u+6LzsJcuL4QA8nyzga8YaN/3t9P
         mC9zTLYfTFkLrDp6Cv4fWyRwsYB+Ekyubg2qeAMkDpTTx4S97Pw4tQLf4zL9jYTSmXvd
         +BhfohWwjLEkj7i9lPU+x/UJzlY+w5vwSi00+Z81X09h0kAEzV1Nvl86svJXXD0cdvhu
         ZTEmyfcUhCk13sN7t2DJ7OyzSANzUSRBw9GhwwqgkVlUqpvHKTBm1+KEo5dlIMIbVHuW
         KDwA==
X-Gm-Message-State: AC+VfDxLnbp271DqpS1GgEu7oeaKK+nxC5rooeMm4Q9MP1sIcORNcdY9
        abPNMw6tbM91YZX2cSeIg4hyJpkwHz0vr38qaupXHg==
X-Google-Smtp-Source: ACHHUZ4fbzTjTcfsiWG/coHms/+UyyQOjCOsFw0hjewXQx+r3YEXTTgnwArQvI7+T53tu2RUBSsoa6FYv8srj0KRkuQ=
X-Received: by 2002:a25:4a46:0:b0:b8e:e918:33ac with SMTP id
 x67-20020a254a46000000b00b8ee91833acmr18954961yba.1.1683785979134; Wed, 10
 May 2023 23:19:39 -0700 (PDT)
MIME-Version: 1.0
References: <20230511014625.3443409-1-vineeth@bitbyteword.org>
In-Reply-To: <20230511014625.3443409-1-vineeth@bitbyteword.org>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Wed, 10 May 2023 23:19:27 -0700
Message-ID: <CAEXW_YRjNAUXFD8rPQQ53Vu8j8ka=Z-WEZS54JXEroVH7TPVjg@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] sched/deadline: Improve reclaim bandwidth accuracy
 for GRUB
To:     Vineeth Pillai <vineeth@bitbyteword.org>
Cc:     luca.abeni@santannapisa.it, Juri Lelli <juri.lelli@redhat.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Valentin Schneider <vschneid@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vineeth,
Nice work. ;-) Few quick comments below:

On Wed, May 10, 2023 at 6:46=E2=80=AFPM Vineeth Pillai <vineeth@bitbyteword=
.org> wrote:
>
> Current reclaim calculation for GRUB is a bit inaccurate and the
> inaccuracy gets larger as the bandwidth of tasks becomes smaller.
> I have a test program to show the issue - it runs one or more
> deadline threads and observes the utilization. Following tests
> are run on an isolated cpu(isolcpus=3D3) in a 4 cpu system and the
> results as shown below:
>
> RUN 1: runtime=3D7ms, deadline=3Dperiod=3D10ms, RT capacity =3D 95%
> TID[693]: RECLAIM=3D1, (r=3D7ms, d=3D10ms, p=3D10ms), Util: 93.33
> TID[693]: RECLAIM=3D1, (r=3D7ms, d=3D10ms, p=3D10ms), Util: 93.35
> TID[693]: RECLAIM=3D1, (r=3D7ms, d=3D10ms, p=3D10ms), Util: 93.35
> TID[693]: RECLAIM=3D1, (r=3D7ms, d=3D10ms, p=3D10ms), Util: 93.29
>
> RUN 2: runtime=3D2ms, deadline=3Dperiod=3D10ms, RT capacity =3D 95%
> TID[704]: RECLAIM=3D1, (r=3D2ms, d=3D10ms, p=3D10ms), Util: 79.96
> TID[704]: RECLAIM=3D1, (r=3D2ms, d=3D10ms, p=3D10ms), Util: 80.06
> TID[704]: RECLAIM=3D1, (r=3D2ms, d=3D10ms, p=3D10ms), Util: 80.00
>
> RUN 3: runtime=3D1ms, deadline=3Dperiod=3D100ms, RT capacity =3D 95%
> TID[708]: RECLAIM=3D1, (r=3D1ms, d=3D100ms, p=3D100ms), Util: 16.69
> TID[708]: RECLAIM=3D1, (r=3D1ms, d=3D100ms, p=3D100ms), Util: 16.69
> TID[708]: RECLAIM=3D1, (r=3D1ms, d=3D100ms, p=3D100ms), Util: 16.70
>
> When running multiple tasks, the reclaimed bandwidth is divided
> proportionately, but is not reclaimed to the max allowable limit:
>
> RUN 4: 2 SCHED_FLAG_RECLAIM tasks, 1 normal task
>         Task 1: runtime=3D1ms, deadline=3Dperiod=3D10ms
>         Task 2: runtime=3D1ms, deadline=3Dperiod=3D10ms
>         Task 3: runtime=3D5ms, deadline=3Dperiod=3D20ms(normal)
> TID[624]: RECLAIM=3D1, (r=3D1ms, d=3D10ms, p=3D10ms), Util: 20.10
> TID[625]: RECLAIM=3D1, (r=3D1ms, d=3D10ms, p=3D10ms), Util: 20.10
> TID[626]: RECLAIM=3D0, (r=3D5ms, d=3D20ms, p=3D20ms), Util: 25.07
> TID[624]: RECLAIM=3D1, (r=3D1ms, d=3D10ms, p=3D10ms), Util: 20.06
> TID[625]: RECLAIM=3D1, (r=3D1ms, d=3D10ms, p=3D10ms), Util: 20.13
> TID[626]: RECLAIM=3D0, (r=3D5ms, d=3D20ms, p=3D20ms), Util: 25.12
> TID[624]: RECLAIM=3D1, (r=3D1ms, d=3D10ms, p=3D10ms), Util: 19.95
> TID[625]: RECLAIM=3D1, (r=3D1ms, d=3D10ms, p=3D10ms), Util: 19.93
> TID[626]: RECLAIM=3D0, (r=3D5ms, d=3D20ms, p=3D20ms), Util: 25.04
>
> I have also tested multiple tasks on all cpus allowing for tasks to
> migrate and see the same issue there as well. Running 10 tasks on 3
> cpus with 6 SCHED_FLAG_RECLAIM and 4 normal tasks, top shows:
> %Cpu0  : 70.1 us,  0.3 sy,  0.0 ni, 29.3 id,  0.0 wa
> %Cpu1  : 69.1 us,  0.3 sy,  0.0 ni, 30.3 id,  0.3 wa
> %Cpu2  : 70.5 us,  0.3 sy,  0.0 ni, 29.2 id,  0.0 wa
>
> The max{} logic in the existing implementation seems to not fully
> capture the GRUB algorithm.
>
> This patch fixes the issue by appropriatley caping the max allowed
> utilization and also slightly adjusting GRUB algorithm to account
> for a mix of normal deadline and SCHED_FLAG_RECLAIM tasks.

Looked at the patch quickly as I am due for bedtime ;-). I feel like
this does more than should be done in one patch. So you should
consider splitting it IMHO.

> According to the GRUB rule, the runtime is depreciated as a factor
> of active bandwidth of the runqueue: "dq =3D -dt", where U is the

Saying "dq =3D -dt" where U does not make sense because U is not in the
equation ;-). Suggest rephrase.

> active bandwidth. Also, we do not allocate the full bandwidth of a
> cpu to deadline task, but only a portion(Umax) to it, so as to avoid
> deadline tasks starving lower class tasks. The equation could be
> re-written as "dq =3D -(U / Umax) * dt"

Isn't the equation in the code right now as:
dq =3D -max{ Ui / Umax, (1 - Uinact - Uextra) } dt

?

That's what the kernel docs say [1].

So what do you mean by "could be re-written" ?

[1] https://docs.kernel.org/scheduler/sched-deadline.html

>
> Since both normal deadline and SCHED_FLAG_RECLAIM tasks can share
> cpu, we need to consider bandwidth of only SCHED_FLAG_RECLAIM tasks
> in the equation:
>         "dq =3D -(Ureclaim / Umax_reclaim) * dt"

This makes sense, we deplete only as a percent of what's reclaimable
and not the whole damn thing. You did test a mix of reclaim and
non-reclaim tasks so that's good, also since Luca approves that's
great. ;-)

>
> Following are the results with this patch:
>
> RUN 1: runtime=3D7ms, deadline=3Dperiod=3D10ms, RT capacity =3D 95%
> TID[616]: RECLAIM=3D1, (r=3D7ms, d=3D10ms, p=3D10ms), Util: 94.98
> TID[616]: RECLAIM=3D1, (r=3D7ms, d=3D10ms, p=3D10ms), Util: 95.04
> TID[616]: RECLAIM=3D1, (r=3D7ms, d=3D10ms, p=3D10ms), Util: 95.01

All these look 100% correct to me. Do these tasks start at the same
time or are they shifted in their respective activations? Just wanted
to be sure it behaves the same either way...

[...]
> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index 3e8df6d31c1e..13d85af0f42b 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -257,6 +257,11 @@ static inline bool dl_entity_is_special(const struct=
 sched_dl_entity *dl_se)
>  #endif
>  }
>
> +static inline bool dl_entity_is_reclaim(const struct sched_dl_entity *dl=
_se)
> +{
> +       return dl_se->flags & SCHED_FLAG_RECLAIM;
> +}
> +

Can this helper addition be split out to a different patch?

>  /*
>   * Tells if entity @a should preempt entity @b.
>   */
> @@ -754,10 +759,20 @@ struct dl_rq {
>         u64                     extra_bw;
>
>         /*
> -        * Inverse of the fraction of CPU utilization that can be reclaim=
ed
> -        * by the GRUB algorithm.
> +        * Maximum available bandwidth for this runqueue. This is used to
> +        * calculate reclaimable bandwidth for SCHED_FLAG_RECLAIM tasks.
> +        * By restricting maximum usable bandwidth, we aim to give other
> +        * tasks on lower classes a chance to run, when competing with
> +        * SCHED_FLAG_RECLAIM tasks.
>          */
> -       u64                     bw_ratio;
> +       u64                     max_bw;
> +
> +       /*
> +        * Active bandwidth of SCHED_FLAG_RECLAIM tasks on this rq.
> +        * This will be a subset of running_bw.
> +        */
> +       u64                     reclaim_bw;
> +

And perhaps addition and use of these new fields if it makes sense.

I will take a closer look at your patches later or after v2..

 - Joel


>  };
>
>  #ifdef CONFIG_FAIR_GROUP_SCHED
> --
> 2.40.1
>
