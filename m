Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAE6372FB04
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 12:33:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229796AbjFNKdH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 06:33:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244049AbjFNKcx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 06:32:53 -0400
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com [IPv6:2607:f8b0:4864:20::112d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 422EF2127
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 03:32:07 -0700 (PDT)
Received: by mail-yw1-x112d.google.com with SMTP id 00721157ae682-570002c9b38so5852417b3.1
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 03:32:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686738726; x=1689330726;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o4vm7ceTzo1hNNcW7BySp+CwxkjlqbbfFxfrM36R0A8=;
        b=jltIjhB3RuexEW8rWeAnwei/hwCvgdf+XWXZd/46qYmQLCyMEVebejzVgylMQzIb/G
         nk1fVkrER++UpRTiVjzjGOkV5THpd2tQQPOiaAIik4ffA2HwEwUqQ6D9PcqYIWeMT4iQ
         syhc6V+JqZGF3iCGYVExGSWr5pKNU1zlU5AMWVg9gRtOwvBP4OwngzFdPw+9WPxvAb/S
         6IczwejzpYaXz/C1vXDMgG8XpUWFeCKId4bOzLyOHGK+7gRzSgBVC+cxTbKm5EXjyLGS
         Guix/mRthYtEtE1S6GvYqUxD3dw+RsJzjgfcl9UC8EKVphMi1gJCMsV9jP9zxuHjSUn5
         5F2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686738726; x=1689330726;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o4vm7ceTzo1hNNcW7BySp+CwxkjlqbbfFxfrM36R0A8=;
        b=C3NdkW6LQvjU9mPNY3iy2z3drsRUrBMNjcUmzCmuxDf2tz3PJNUohCX8yi2TLI8PDM
         K4kCSAKgVETdoduDtBB9AxcvXQHM02tVFYigkEM2jlNFXupRgRimF+rfxCutj4T+WkmK
         gr2OLfpc5z08l5cwTtW55NHzSX0EVHg7ix4hwMdzHlkcdDcoBVvpCVNAsS8hWaTpEVMu
         XHK4ZUuVGyO2NcqBjrtvlaIvL+7QoAd77ur2z0EinVWxtBlizooDDbHbGql7xYiQSArB
         AUFYgPFoDHku27vicBXNQDiRvv/x/5I/qIBMqt3aIcxKs0Aw1rj385fZRFHNjvXwvsOT
         UCmw==
X-Gm-Message-State: AC+VfDy1JGZE1XI0N2qXH//iOh206SwVFdkUanWGKJn0/vO81ICCqZzZ
        MjyEDrt2pwSdiZnbXot/1brpQ4W+F8zg3asfREEE5A==
X-Google-Smtp-Source: ACHHUZ5bPiBMBDH1k9u8J09EszdLHhDZWgBv8iL+J3SKVW6gSRNx27FS7lk5Zw848NEiyq3DuSZ2qgfOrRKptxZ0VuY=
X-Received: by 2002:a0d:e8c6:0:b0:56d:2792:ef49 with SMTP id
 r189-20020a0de8c6000000b0056d2792ef49mr1542577ywe.23.1686738726401; Wed, 14
 Jun 2023 03:32:06 -0700 (PDT)
MIME-Version: 1.0
References: <20230607082713.517157-1-martin@geanix.com>
In-Reply-To: <20230607082713.517157-1-martin@geanix.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 14 Jun 2023 12:31:30 +0200
Message-ID: <CAPDyKFrNVwxxDyzS3mV3FN8RX8wnA42_1Gj7zu56v9XoCPwwrQ@mail.gmail.com>
Subject: Re: [PATCHv2] mmc: meson: remove redundant mmc_request_done() call
 from irq context
To:     =?UTF-8?Q?Martin_Hundeb=C3=B8ll?= <martin@geanix.com>
Cc:     Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        stable@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 7 Jun 2023 at 10:27, Martin Hundeb=C3=B8ll <martin@geanix.com> wrot=
e:
>
> The call to mmc_request_done() can schedule, so it must not be called
> from irq context. Wake the irq thread if it needs to be called, and let
> its existing logic do its work.
>
> Fixes the following kernel bug, which appears when running an RT patched
> kernel on the AmLogic Meson AXG A113X SoC:
> [   11.111407] BUG: scheduling while atomic: kworker/0:1H/75/0x00010001
> [   11.111438] Modules linked in:
> [   11.111451] CPU: 0 PID: 75 Comm: kworker/0:1H Not tainted 6.4.0-rc3-rt=
2-rtx-00081-gfd07f41ed6b4-dirty #1
> [   11.111461] Hardware name: RTX AXG A113X Linux Platform Board (DT)
> [   11.111469] Workqueue: kblockd blk_mq_run_work_fn
> [   11.111492] Call trace:
> [   11.111497]  dump_backtrace+0xac/0xe8
> [   11.111510]  show_stack+0x18/0x28
> [   11.111518]  dump_stack_lvl+0x48/0x60
> [   11.111530]  dump_stack+0x18/0x24
> [   11.111537]  __schedule_bug+0x4c/0x68
> [   11.111548]  __schedule+0x80/0x574
> [   11.111558]  schedule_loop+0x2c/0x50
> [   11.111567]  schedule_rtlock+0x14/0x20
> [   11.111576]  rtlock_slowlock_locked+0x468/0x730
> [   11.111587]  rt_spin_lock+0x40/0x64
> [   11.111596]  __wake_up_common_lock+0x5c/0xc4
> [   11.111610]  __wake_up+0x18/0x24
> [   11.111620]  mmc_blk_mq_req_done+0x68/0x138
> [   11.111633]  mmc_request_done+0x104/0x118
> [   11.111644]  meson_mmc_request_done+0x38/0x48
> [   11.111654]  meson_mmc_irq+0x128/0x1f0
> [   11.111663]  __handle_irq_event_percpu+0x70/0x114
> [   11.111674]  handle_irq_event_percpu+0x18/0x4c
> [   11.111683]  handle_irq_event+0x80/0xb8
> [   11.111691]  handle_fasteoi_irq+0xa4/0x120
> [   11.111704]  handle_irq_desc+0x20/0x38
> [   11.111712]  generic_handle_domain_irq+0x1c/0x28
> [   11.111721]  gic_handle_irq+0x8c/0xa8
> [   11.111735]  call_on_irq_stack+0x24/0x4c
> [   11.111746]  do_interrupt_handler+0x88/0x94
> [   11.111757]  el1_interrupt+0x34/0x64
> [   11.111769]  el1h_64_irq_handler+0x18/0x24
> [   11.111779]  el1h_64_irq+0x64/0x68
> [   11.111786]  __add_wait_queue+0x0/0x4c
> [   11.111795]  mmc_blk_rw_wait+0x84/0x118
> [   11.111804]  mmc_blk_mq_issue_rq+0x5c4/0x654
> [   11.111814]  mmc_mq_queue_rq+0x194/0x214
> [   11.111822]  blk_mq_dispatch_rq_list+0x3ac/0x528
> [   11.111834]  __blk_mq_sched_dispatch_requests+0x340/0x4d0
> [   11.111847]  blk_mq_sched_dispatch_requests+0x38/0x70
> [   11.111858]  blk_mq_run_work_fn+0x3c/0x70
> [   11.111865]  process_one_work+0x17c/0x1f0
> [   11.111876]  worker_thread+0x1d4/0x26c
> [   11.111885]  kthread+0xe4/0xf4
> [   11.111894]  ret_from_fork+0x10/0x20
>
> Fixes: 51c5d8447bd7 ("MMC: meson: initial support for GX platforms")
> Cc: stable@vger.kernel.org
> Signed-off-by: Martin Hundeb=C3=B8ll <martin@geanix.com>

Applied for fixes, thanks!

Kind regards
Uffe


> ---
> Version 1 of this patch:
> https://lore.kernel.org/linux-amlogic/20230606065918.460866-1-martin@gean=
ix.com/
>
> Changes since v1:
>  * remove redundant change to meson_mmc_irq_thread(), as per Martin's
>    review
>  * return early instead of assigning to "ret" variable
>  * change commit short-log to reflect code removal instead of it being
>    moved. (Was: "mmc: meson: move mmc_request_done() call to irq thread")
>
>  drivers/mmc/host/meson-gx-mmc.c | 10 ++--------
>  1 file changed, 2 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/mmc/host/meson-gx-mmc.c b/drivers/mmc/host/meson-gx-=
mmc.c
> index b8514d9d5e736..f90b0fd8d8b00 100644
> --- a/drivers/mmc/host/meson-gx-mmc.c
> +++ b/drivers/mmc/host/meson-gx-mmc.c
> @@ -991,11 +991,8 @@ static irqreturn_t meson_mmc_irq(int irq, void *dev_=
id)
>
>                 if (data && !cmd->error)
>                         data->bytes_xfered =3D data->blksz * data->blocks=
;
> -               if (meson_mmc_bounce_buf_read(data) ||
> -                   meson_mmc_get_next_command(cmd))
> -                       ret =3D IRQ_WAKE_THREAD;
> -               else
> -                       ret =3D IRQ_HANDLED;
> +
> +               return IRQ_WAKE_THREAD;
>         }
>
>  out:
> @@ -1007,9 +1004,6 @@ static irqreturn_t meson_mmc_irq(int irq, void *dev=
_id)
>                 writel(start, host->regs + SD_EMMC_START);
>         }
>
> -       if (ret =3D=3D IRQ_HANDLED)
> -               meson_mmc_request_done(host->mmc, cmd->mrq);
> -
>         return ret;
>  }
>
> --
> 2.40.1
>
