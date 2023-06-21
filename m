Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7BC4737B29
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 08:25:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229710AbjFUGSh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 02:18:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230209AbjFUGSS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 02:18:18 -0400
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B2471731
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 23:18:17 -0700 (PDT)
Received: by mail-qt1-x834.google.com with SMTP id d75a77b69052e-3f9d619103dso55551cf.1
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 23:18:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687328296; x=1689920296;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EY6Ne/SM4st5svkq+5PmFR9ym99PQO1FPMB+O80q/9k=;
        b=jJgJ8TEwkTcJjg1WjlUR9s8k6xuroY0T6d/deXtuR6rtpQms6eSvNiZYzdonANiUvl
         rtVLnv81nzNCVa4awgoAIxNR6WGcCzRae03XOEGQWufDl+YimvOSKnD6KTyqvZpqEgrR
         9k7bestW22knqvyeQe2LdOiQVRnDba3Lff5fGdys9NnvWhGrxUZ2FzgJ4Fg52lxWP+Zj
         87+9lorjspaapO563tVLV2xa13yHzMOq36qt1CEiYqqQI7dqNZkx/1R063gewZf9gZ/e
         mQwlcDu8WkksEmnyZ4CPgtCrYWbzWG5xpHpY8Beza9mx2MQ+L67Gic8xKZvVIUUzs/jc
         UcQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687328296; x=1689920296;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EY6Ne/SM4st5svkq+5PmFR9ym99PQO1FPMB+O80q/9k=;
        b=Lnq6TuKto5RIqHERkiVNVnMutG7PsxJvQtPFuTn0GT55DYDGli8KbsV8dJmcP6gKQu
         UAF2X+qJfMFVK6ctree1huAY3oeK26c4Ds2MdrJ4K7JRKp29VdXjYwYlI6DWGq+Ah/+1
         SPOB5eFdexJKzpAEk2p3h5V/D3pDJbVMxpQ8S0a4VeKMgCWTL6BkWgNpmSObYcZvfZvq
         5IKo+uL/p3iD0cAOtcWqETr14mKqkPREoB2j2pZ3qEafwolNTCO3y2pefTRZacysl1BG
         prvHdm3WymBwRE211oRIcCtIlmZEWjoWbvvh97lkNf4OxoXrnQ091VTkRWaThgof6Aqv
         zTLg==
X-Gm-Message-State: AC+VfDwNmVCq1fJhjt5Ge6F+1EDQvsPgZ+isVZOWkwuydm2nK7oEzSCh
        kln4HhF+yRpA/rda748z271sQuzH1PsfH0GD/12AEw==
X-Google-Smtp-Source: ACHHUZ5Si2f5rcozpuv/IX3egthC3n6xTOPCLu1mauqLlDSD8RTu21u5MDhWkbFZ/yCBTJdUKEE7iLebzq6xzpeI364=
X-Received: by 2002:a05:622a:14c7:b0:3f8:8c06:c53b with SMTP id
 u7-20020a05622a14c700b003f88c06c53bmr1388016qtx.0.1687328296083; Tue, 20 Jun
 2023 23:18:16 -0700 (PDT)
MIME-Version: 1.0
References: <20230602094841.1225-1-eric.lin@sifive.com> <CAPqJEFpamQSbCcD0QJ16u7ctRf1=NYihod6gdZJfxFpE0YUVHQ@mail.gmail.com>
In-Reply-To: <CAPqJEFpamQSbCcD0QJ16u7ctRf1=NYihod6gdZJfxFpE0YUVHQ@mail.gmail.com>
From:   Stephane Eranian <eranian@google.com>
Date:   Tue, 20 Jun 2023 23:18:05 -0700
Message-ID: <CABPqkBRyqsMnNbokBKepkWq1DtzfB0npXySGbKS1T3nQTwmaAw@mail.gmail.com>
Subject: Re: [PATCH] perf/core: Add pmu stop before unthrottling to prevent WARNING
To:     Eric Lin <eric.lin@sifive.com>
Cc:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@kernel.org, namhyung@kernel.org, irogers@google.com,
        adrian.hunter@intel.com, palmer@dabbelt.com,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, greentime.hu@sifive.com,
        vincent.chen@sifive.com
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

On Tue, Jun 20, 2023 at 9:25=E2=80=AFPM Eric Lin <eric.lin@sifive.com> wrot=
e:
>
> CC: Stephane Eranian
>
> On Fri, Jun 2, 2023 at 5:49=E2=80=AFPM Eric Lin <eric.lin@sifive.com> wro=
te:
> >
> > Currently, during the perf sampling, if the perf interrupt takes too lo=
ng,
> > perf framework will lower the perf_event_max_sample_rate. This will lim=
it
> > the number of samples per timer tick (max_samples_per_tick) and set hwc=
->interrupts
> > to MAX_INTERRUPTS within the __perf_event_account_interrupt() function.
> >
> > Afterward, the perf framework will unthrottle the event in the timer in=
terrupt
> > handler, which triggers the driver's *_pmu_start() function. Most of th=
e driver's
> > *_pmu_start() functions will check the event->hw.state to determine whe=
ther this
> > event has stopped. If the event has not stopped, a WARN_ON_ONCE() warni=
ng
> > will be triggered as shown below:
> >
> > [ 2110.224723] ------------[ cut here ]------------
> > [ 2110.224851] WARNING: CPU: 0 PID: 240 at drivers/perf/riscv_pmu.c:184=
 riscv_pmu_start+0x7c/0x8e
> > [ 2110.225242] Modules linked in:
> > [ 2110.225380] CPU: 0 PID: 240 Comm: ls Not tainted 6.4-rc4-g19d0788e9e=
f2 #1
> > [ 2110.225574] Hardware name: SiFive (DT)
> > [ 2110.225657] epc : riscv_pmu_start+0x7c/0x8e
> > [ 2110.225834]  ra : riscv_pmu_start+0x28/0x8e
> > [ 2110.225998] epc : ffffffff80aef864 ra : ffffffff80aef810 sp : ffff8f=
80004db6f0
> > [ 2110.226135]  gp : ffffffff81c83750 tp : ffffaf80069f9bc0 t0 : ffff8f=
80004db6c0
> > [ 2110.226245]  t1 : 0000000000000000 t2 : 000000000000001f s0 : ffff8f=
80004db720
> > [ 2110.226367]  s1 : ffffaf8008ca1068 a0 : 0000ffffffffffff a1 : 000000=
0000000000
> > [ 2110.226488]  a2 : 0000000000000001 a3 : 0000000000000870 a4 : 000000=
0000000000
> > [ 2110.226605]  a5 : 0000000000000000 a6 : 0000000000000840 a7 : 000000=
0000000030
> > [ 2110.226721]  s2 : 0000000000000000 s3 : ffffaf8005165800 s4 : ffffaf=
800424da00
> > [ 2110.226838]  s5 : ffffffffffffffff s6 : ffffffff81cc7590 s7 : 000000=
0000000000
> > [ 2110.226955]  s8 : 0000000000000006 s9 : 0000000000000001 s10: ffffaf=
807efbc340
> > [ 2110.227064]  s11: ffffaf807efbbf00 t3 : ffffaf8006a16028 t4 : 000000=
00dbfbb796
> > [ 2110.227180]  t5 : 0000000700000000 t6 : ffffaf8005269870
> > [ 2110.227277] status: 0000000200000100 badaddr: 0000000000000000 cause=
: 0000000000000003
> > [ 2110.227407] [<ffffffff80aef864>] riscv_pmu_start+0x7c/0x8e
> > [ 2110.227622] [<ffffffff80185b56>] perf_adjust_freq_unthr_context+0x15=
e/0x174
> > [ 2110.227961] [<ffffffff80188642>] perf_event_task_tick+0x88/0x9c
> > [ 2110.228235] [<ffffffff800626a8>] scheduler_tick+0xfe/0x27c
> > [ 2110.228463] [<ffffffff800b5640>] update_process_times+0x9a/0xba
> > [ 2110.228690] [<ffffffff800c5bd4>] tick_sched_handle+0x32/0x66
> > [ 2110.229007] [<ffffffff800c5e0c>] tick_sched_timer+0x64/0xb0
> > [ 2110.229253] [<ffffffff800b5e50>] __hrtimer_run_queues+0x156/0x2f4
> > [ 2110.229446] [<ffffffff800b6bdc>] hrtimer_interrupt+0xe2/0x1fe
> > [ 2110.229637] [<ffffffff80acc9e8>] riscv_timer_interrupt+0x38/0x42
> > [ 2110.229984] [<ffffffff80090a16>] handle_percpu_devid_irq+0x90/0x1d2
> > [ 2110.230162] [<ffffffff8008a9f4>] generic_handle_domain_irq+0x28/0x36
> >
> > To prevent this warning, we should call the driver's *_pmu_stop() funct=
ion before unthrottling
> >
> > Signed-off-by: Eric Lin <eric.lin@sifive.com>
> > ---
> >  kernel/events/core.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/kernel/events/core.c b/kernel/events/core.c
> > index db016e418931..098c875abe88 100644
> > --- a/kernel/events/core.c
> > +++ b/kernel/events/core.c
> > @@ -4128,6 +4128,7 @@ perf_adjust_freq_unthr_context(struct perf_event_=
context *ctx, bool unthrottle)
> >
> >                 if (hwc->interrupts =3D=3D MAX_INTERRUPTS) {
> >                         hwc->interrupts =3D 0;
> > +                       event->pmu->stop(event, 0);

But how could the event have been stopped with a call to pmu->stop()
during throttling?

>
> >                         perf_log_throttle(event, 1);
> >                         event->pmu->start(event, 0);
> >                 }
> > --
> > 2.17.1
> >
