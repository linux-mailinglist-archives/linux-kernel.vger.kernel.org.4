Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC79F73079C
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 20:50:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233310AbjFNSuT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 14:50:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236797AbjFNSuH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 14:50:07 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8425C1BDB
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 11:50:06 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id ffacd0b85a97d-310b631c644so1263395f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 11:50:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686768605; x=1689360605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=27Ibbm+oRpNn4LqE//rGeaeQep+ElKzgKjwbwf1dYTI=;
        b=rlPvuEl/jJaiH0rCfqkOGxtRGN0uAw9VtA/vPTQ1mPTbRiF10BXc2h6HoiAr7+1c5D
         P+bQaqLycMc7aHNQDDnsY+sPC3EqTu2OP57pUnuOo54gx0Ekj04NiU6Psyh6Mlml27GJ
         u1NuoeypugKiOx4oyOgpe2iFK/vaCl12aNFSsy/7qswrxRzpy5qvxy+H03d9XIOcagsB
         9iP02FxwMx57BZiSbCfcEY1k2Lwbr+3bmlwUkJ38Vf3oS1Zt7nMVeOUIQA1RJdwFcDyo
         u1ndUOcBhF+pcou5sRvQHbZ19EgKHHc2CMGCj3XfBtjzMg9Vq7cgVyhW9OqI5R6jziSg
         C0TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686768605; x=1689360605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=27Ibbm+oRpNn4LqE//rGeaeQep+ElKzgKjwbwf1dYTI=;
        b=fcrkbF3a8Mh+C380AX7uQ/gSD6h5LK22OuT8AhICC59DADOeTsKxBxWyTstICc0Eeh
         3z08IgwsIzAmpZq9VPwVIZ2HxnS31mo5evYH6hOz7/suFNCUB6odF7k+3plQC9IexlzV
         R0ErJlAtxcdkvlltzQ3jr4ULktS2u5uVix9nw81EOePU+UF2sZ68min3ZHgDyxo2uXyU
         514j+0H/sdhgmv+77YFqYyOrlTkH/Ivb0Zz/6e6tTsuxByewhELCzaJVlYJFN9jVdrNJ
         KnRu+jQTwgy117NGREiZAZo+2KsxreBaQIitVj6PdXPnoAq2PM0x+CCN5T623Z2VVbk0
         7a2g==
X-Gm-Message-State: AC+VfDzUxzBszjMvnnRi7Pcmy9YOLmYOW6wB5ZDCoiqgQoLd8u5+4oPF
        tNwQ4d2F/Wlsi2kEfdnVbq2YvDS3Ci3UJvBjmu4MUg==
X-Google-Smtp-Source: ACHHUZ5rRWjGS8F+bSWT3HzGPZ4svnNt6B+OuJOD/+yunpJ8h6gygiQKlFbhDRCVM253Y59IjXAjbSrnej0eqNsh3AM=
X-Received: by 2002:adf:dd41:0:b0:30f:c4e2:fc57 with SMTP id
 u1-20020adfdd41000000b0030fc4e2fc57mr8656969wrm.31.1686768604863; Wed, 14 Jun
 2023 11:50:04 -0700 (PDT)
MIME-Version: 1.0
References: <20230519001709.2563-1-tj@kernel.org> <20230519001709.2563-15-tj@kernel.org>
 <CAB=BE-S=cxewXu7nqJY1DC5w9Bapar_C0cTjpZOQ-Qd5GGwYyw@mail.gmail.com>
 <c307ba94-0d8c-3cbf-19da-44ee31751428@amd.com> <ZIEBB-A1arYKSK2P@slm.duckdns.org>
 <fb3461cd-3fc2-189a-a86b-c638816a2440@amd.com> <ZIJbMQOu_k07jkFf@slm.duckdns.org>
 <fd5a27de-c8a9-892c-f413-66ea41221fdd@amd.com>
In-Reply-To: <fd5a27de-c8a9-892c-f413-66ea41221fdd@amd.com>
From:   Sandeep Dhavale <dhavale@google.com>
Date:   Wed, 14 Jun 2023 11:49:53 -0700
Message-ID: <CAB=BE-QaNBn1cVK6c7LM2cLpH_Ck_9SYw-YDYEnNrtwfoyu81Q@mail.gmail.com>
Subject: Re: [PATCH 14/24] workqueue: Generalize unbound CPU pods
To:     Tejun Heo <tj@kernel.org>
Cc:     jiangshanlai@gmail.com, torvalds@linux-foundation.org,
        peterz@infradead.org, linux-kernel@vger.kernel.org,
        kernel-team@meta.com, joshdon@google.com, brho@google.com,
        briannorris@chromium.org, nhuck@google.com, agk@redhat.com,
        snitzer@kernel.org, void@manifault.com, kernel-team@android.com,
        Swapnil Sapkal <swapnil.sapkal@amd.com>, kprateek.nayak@amd.com
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

Hi Tejun,
Thank you for your patches! I tested the affinity-scopes-v2 with app launch
benchmarks. The numbers below are total scheduling latency for erofs kworke=
rs
and last column is with percpu highpri kthreads that is
CONFIG_EROFS_FS_PCPU_KTHREAD=3Dy
CONFIG_EROFS_FS_PCPU_KTHREAD_HIPRI=3Dy

Scheduling latency is the latency between when the task became eligible to =
run
to when it actually started running. The test does 50 cold app launches for=
 each
and aggregates the numbers.

| Table        | Upstream | Cache nostrict | CPU nostrict | PCPU hpri |
|--------------+----------+----------------+--------------+-----------|
| Average (us) | 12286    | 7440           | 4435         | 2717      |
| Median (us)  | 12528    | 3901           | 3258         | 2476      |
| Minimum (us) | 287      | 555            | 638          | 357       |
| Maximum (us) | 35600    | 35911          | 13364        | 6874      |
| Stdev (us)   | 7918     | 7503           | 3323         | 1918      |
|--------------+----------+----------------+--------------+-----------|

We see here that with affinity-scopes-v2 (which defaults to cache nostrict)=
,
there is a good improvement when compared to the current codebase.
Affinity scope "CPU nostrict" for erofs workqueue has even better numbers
for my test launches and it resembles logically to percpu highpri kthreads
approach. Percpu highpri kthreads has the lowest latency and variation,
probably down to running at higher priority as those threads are set to
sched_set_fifo_low().

At high level, the app launch numbers itself improved with your series as
entire workqueue subsystem improved across the board.

Thanks,
Sandeep.

On Thu, Jun 8, 2023 at 8:43=E2=80=AFPM 'K Prateek Nayak' via kernel-team
<kernel-team@android.com> wrote:
>
> Hello Tejun,
>
> On 6/9/2023 4:20 AM, Tejun Heo wrote:
> > Hello,
> >
> > On Thu, Jun 08, 2023 at 08:31:34AM +0530, K Prateek Nayak wrote:
> >> [..snip..]
> >> o I consistently see a WARN_ON_ONCE() in kick_pool() being hit when I
> >>   run "sudo ./stress-ng --iomix 96 --timeout 1m". I've seen few
> >>   different stack traces so far. Including all below just in case:
> > ...
> >> This is the same WARN_ON_ONCE() you had added in the HEAD commit:
> >>
> >>     $ scripts/faddr2line vmlinux kick_pool+0xdb
> >>     kick_pool+0xdb/0xe0:
> >>     kick_pool at kernel/workqueue.c:1130 (discriminator 1)
> >>
> >>     $ sed -n 1130,1132p kernel/workqueue.c
> >>     if (!WARN_ON_ONCE(wake_cpu >=3D nr_cpu_ids))
> >>         p->wake_cpu =3D wake_cpu;
> >>     get_work_pwq(work)->stats[PWQ_STAT_REPATRIATED]++;
> >>
> >> Let me know if you need any more data from my test setup.
> >> P.S. The kernel is still up and running (~30min) despite hitting this
> >> WARN_ON_ONCE() in my case :)
> >
> > Okay, that was me being stupid and not initializing the new fields for
> > per-cpu workqueues. Can you please test the following branch? It should=
 have
> > both bugs fixed properly.
> >
> >  git://git.kernel.org/pub/scm/linux/kernel/git/tj/wq.git affinity-scope=
s-v2
>
> I've not run into any panics or warnings with this one. Kernel has been
> stable for ~30min while running stress-ng iomix. We'll resume the testing
> with v2 :)
>
> >
> > If that doesn't crash, I'd love to hear how it affects the perf regress=
ions
> > reported over that past few months.>
> > Thanks.
> >
>
> --
> Thanks and Regards,
> Prateek
>
> --
> To unsubscribe from this group and stop receiving emails from it, send an=
 email to kernel-team+unsubscribe@android.com.
>
