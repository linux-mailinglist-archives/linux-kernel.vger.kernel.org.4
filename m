Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0FD1737A1E
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 06:25:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229748AbjFUEZK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 00:25:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229659AbjFUEZG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 00:25:06 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CA6E1726
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 21:25:05 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id 2adb3069b0e04-4f8792d2e86so2642845e87.1
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 21:25:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1687321503; x=1689913503;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LuEAiEqFzxQqtssF/XyIsWFBa1XFMPGQrF0jyK8eg4s=;
        b=XXpqOWb76gFbvNHhpsISUXf41NyGxTGOgD+JApzu1tOt1Ekny/Au85wYwds7Uubgu8
         ydGBnJMW7KUk1G00lw29oWp/1fVcgHrGPiVHc74p95m8qW3E+DOvCsAHYU56WRlldZoG
         TJCqBMgFueyBOpq4TVo8LehsCBwNZQFu4mfpyiBpc3BitrVcUX9+zJr2FTbiBFL0eidM
         5BDvYZ+KdwVKznHkHNWmrHae9zbuSCxdrds+VTb1dEqovVZHzAZ7QF/FrLVPBjMqq1pz
         ho1Zo2+BXtftckfSK1xZah07L5YhK3odnfF/1XKuvAfcRVnYZTi2LwqYJOuO93RMf8iC
         05Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687321503; x=1689913503;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LuEAiEqFzxQqtssF/XyIsWFBa1XFMPGQrF0jyK8eg4s=;
        b=WPE70UsSGEdc+vjlNF/h/IMerCN/jftOV8MJ1Jajv4mBASrC5Hek+h3D21UYEn/QVJ
         HnXuqkg0Yczu57N27/kiGt2UZbvq4ty2Y2hSLMzGdZraJGbbWoGokzlmNo9kH+lzdjvB
         4tiHK8geOTyjq0cBgqxHXtn2E5eBagJDHModECU+t6n4dMkKcaktegSc/pVPTv4cHN7c
         Twqsdv+pWltVKTHrcdldInMC8Mt0phj5kIqulf5Q6ZmRHWRfXWC6qLn19cyUtcYIGER4
         SB5rO8YHh/BfiIpcN9eKtOC5jY4ejWNn7TH8vJi7U9PpqQ9jiSat6EG2Dy8xjFnQW//9
         0/IA==
X-Gm-Message-State: AC+VfDxE62oUwIwaxImaWUgAfllCGQ1FfeUSbnRCcZ35lx7EGQ62cMOp
        fJh1R/gEbGLkr8XnxYnEc0JkTn/t0gi+gdKsxaIrAA==
X-Google-Smtp-Source: ACHHUZ5e35l6LnX7XodTQBDPnk2bkYC/RZKniEMCiLxMYVECDyKqRYf9BNAs3JuKORFJ64C9YqrbJoQzdffkcu3SbgM=
X-Received: by 2002:a2e:7d09:0:b0:2b4:74a7:9606 with SMTP id
 y9-20020a2e7d09000000b002b474a79606mr4726742ljc.46.1687321503290; Tue, 20 Jun
 2023 21:25:03 -0700 (PDT)
MIME-Version: 1.0
References: <20230602094841.1225-1-eric.lin@sifive.com>
In-Reply-To: <20230602094841.1225-1-eric.lin@sifive.com>
From:   Eric Lin <eric.lin@sifive.com>
Date:   Wed, 21 Jun 2023 12:24:52 +0800
Message-ID: <CAPqJEFpamQSbCcD0QJ16u7ctRf1=NYihod6gdZJfxFpE0YUVHQ@mail.gmail.com>
Subject: Re: [PATCH] perf/core: Add pmu stop before unthrottling to prevent WARNING
To:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@kernel.org, namhyung@kernel.org, irogers@google.com,
        adrian.hunter@intel.com, palmer@dabbelt.com,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, eranian@google.com
Cc:     greentime.hu@sifive.com, vincent.chen@sifive.com
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

CC: Stephane Eranian

On Fri, Jun 2, 2023 at 5:49=E2=80=AFPM Eric Lin <eric.lin@sifive.com> wrote=
:
>
> Currently, during the perf sampling, if the perf interrupt takes too long=
,
> perf framework will lower the perf_event_max_sample_rate. This will limit
> the number of samples per timer tick (max_samples_per_tick) and set hwc->=
interrupts
> to MAX_INTERRUPTS within the __perf_event_account_interrupt() function.
>
> Afterward, the perf framework will unthrottle the event in the timer inte=
rrupt
> handler, which triggers the driver's *_pmu_start() function. Most of the =
driver's
> *_pmu_start() functions will check the event->hw.state to determine wheth=
er this
> event has stopped. If the event has not stopped, a WARN_ON_ONCE() warning
> will be triggered as shown below:
>
> [ 2110.224723] ------------[ cut here ]------------
> [ 2110.224851] WARNING: CPU: 0 PID: 240 at drivers/perf/riscv_pmu.c:184 r=
iscv_pmu_start+0x7c/0x8e
> [ 2110.225242] Modules linked in:
> [ 2110.225380] CPU: 0 PID: 240 Comm: ls Not tainted 6.4-rc4-g19d0788e9ef2=
 #1
> [ 2110.225574] Hardware name: SiFive (DT)
> [ 2110.225657] epc : riscv_pmu_start+0x7c/0x8e
> [ 2110.225834]  ra : riscv_pmu_start+0x28/0x8e
> [ 2110.225998] epc : ffffffff80aef864 ra : ffffffff80aef810 sp : ffff8f80=
004db6f0
> [ 2110.226135]  gp : ffffffff81c83750 tp : ffffaf80069f9bc0 t0 : ffff8f80=
004db6c0
> [ 2110.226245]  t1 : 0000000000000000 t2 : 000000000000001f s0 : ffff8f80=
004db720
> [ 2110.226367]  s1 : ffffaf8008ca1068 a0 : 0000ffffffffffff a1 : 00000000=
00000000
> [ 2110.226488]  a2 : 0000000000000001 a3 : 0000000000000870 a4 : 00000000=
00000000
> [ 2110.226605]  a5 : 0000000000000000 a6 : 0000000000000840 a7 : 00000000=
00000030
> [ 2110.226721]  s2 : 0000000000000000 s3 : ffffaf8005165800 s4 : ffffaf80=
0424da00
> [ 2110.226838]  s5 : ffffffffffffffff s6 : ffffffff81cc7590 s7 : 00000000=
00000000
> [ 2110.226955]  s8 : 0000000000000006 s9 : 0000000000000001 s10: ffffaf80=
7efbc340
> [ 2110.227064]  s11: ffffaf807efbbf00 t3 : ffffaf8006a16028 t4 : 00000000=
dbfbb796
> [ 2110.227180]  t5 : 0000000700000000 t6 : ffffaf8005269870
> [ 2110.227277] status: 0000000200000100 badaddr: 0000000000000000 cause: =
0000000000000003
> [ 2110.227407] [<ffffffff80aef864>] riscv_pmu_start+0x7c/0x8e
> [ 2110.227622] [<ffffffff80185b56>] perf_adjust_freq_unthr_context+0x15e/=
0x174
> [ 2110.227961] [<ffffffff80188642>] perf_event_task_tick+0x88/0x9c
> [ 2110.228235] [<ffffffff800626a8>] scheduler_tick+0xfe/0x27c
> [ 2110.228463] [<ffffffff800b5640>] update_process_times+0x9a/0xba
> [ 2110.228690] [<ffffffff800c5bd4>] tick_sched_handle+0x32/0x66
> [ 2110.229007] [<ffffffff800c5e0c>] tick_sched_timer+0x64/0xb0
> [ 2110.229253] [<ffffffff800b5e50>] __hrtimer_run_queues+0x156/0x2f4
> [ 2110.229446] [<ffffffff800b6bdc>] hrtimer_interrupt+0xe2/0x1fe
> [ 2110.229637] [<ffffffff80acc9e8>] riscv_timer_interrupt+0x38/0x42
> [ 2110.229984] [<ffffffff80090a16>] handle_percpu_devid_irq+0x90/0x1d2
> [ 2110.230162] [<ffffffff8008a9f4>] generic_handle_domain_irq+0x28/0x36
>
> To prevent this warning, we should call the driver's *_pmu_stop() functio=
n before unthrottling
>
> Signed-off-by: Eric Lin <eric.lin@sifive.com>
> ---
>  kernel/events/core.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index db016e418931..098c875abe88 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -4128,6 +4128,7 @@ perf_adjust_freq_unthr_context(struct perf_event_co=
ntext *ctx, bool unthrottle)
>
>                 if (hwc->interrupts =3D=3D MAX_INTERRUPTS) {
>                         hwc->interrupts =3D 0;
> +                       event->pmu->stop(event, 0);
>                         perf_log_throttle(event, 1);
>                         event->pmu->start(event, 0);
>                 }
> --
> 2.17.1
>
