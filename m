Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BB266878A6
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 10:21:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231778AbjBBJVp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 04:21:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230375AbjBBJVm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 04:21:42 -0500
Received: from mail-vs1-xe32.google.com (mail-vs1-xe32.google.com [IPv6:2607:f8b0:4864:20::e32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 555C0448E
        for <linux-kernel@vger.kernel.org>; Thu,  2 Feb 2023 01:21:41 -0800 (PST)
Received: by mail-vs1-xe32.google.com with SMTP id y8so1205327vsq.0
        for <linux-kernel@vger.kernel.org>; Thu, 02 Feb 2023 01:21:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=0iI8cUab0N9LjLiaN2HdwLBKZPdPq3S5ESRz3PoGNws=;
        b=JEGTaDFVgbwZc5LxjjZH5/UwjYD6YmgA+SHVUgg5RUxVLmtkzCaww1XGt9PbY61tx7
         T6EMVugYFBP8Gv/F8qSsoukLs76OJznIcQDbRdUn5YUoGbBZwAlocExe6tjEGys9AfO7
         res97iPahFMM9QrvUGaX5bUKPicBxGuHk6T2Mc2MFXlQtUvR9qn1n2Z2ZdnRWJki9/AJ
         00jAPOCC2V175ojMrGhFinBtu/Nda5IxIMhAWNZbV4uX/RRccMLTucZ/DJ/WS4Xt9Z12
         auU4gppZa/ae4GPVYM/kSCDLFtvK92GN6b4ciHzJVT9c5PmNp8r9ABlVBaHbxe9lccKS
         IC8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0iI8cUab0N9LjLiaN2HdwLBKZPdPq3S5ESRz3PoGNws=;
        b=wzGwIt6CbwpUDAxYFXxjy4pC6vf7WGlL+GQ87K1AK4fUZoqNPva2T/r4ibhDl4tiZ1
         GsgAGTYVlvlx0Vy1bb8Jyu++Pp5OdsBcMyF5p2sOlmSnVY1TJ7w6SYa1NJa50ontqhYz
         56zZH0yXRzmYGBlfT9NfUSbzdrRzb/5l55g4F/z6H17+mU/sCYswLGgroQD1lVE8uGtm
         1VAthNk9alRTqBIegoc1707NQf5JFTxkhpIvGY5iqSnRWoTOBQonWOP+y6pMeU10f2k3
         sCHsYj331ps2XjNvU4Bwr+WkqCsI5AkVkMVYrv1VbTHJZHWajLwvvQg4DvCZbkLLhdMi
         gzXg==
X-Gm-Message-State: AO0yUKVAwUcQYaw+fs9ZyiLYWAPlSk9LL3fb/mnkuLasBmho6wlPa+X7
        pNJmXQyYValFTe37NX7Y8Zfnk9agpaRj81AcHkyNxzDOgkIdTZ8T
X-Google-Smtp-Source: AK7set/3dGcmvILU4SkF+d5z1oO4LHch/Id9jI5oD2pvQ5px7RTOr3pDZwL11PMmAK+0S6Xf7AFYRo5wIf9MnTa/jFA=
X-Received: by 2002:a67:c317:0:b0:3fb:b5e6:18a1 with SMTP id
 r23-20020a67c317000000b003fbb5e618a1mr897905vsj.77.1675329700499; Thu, 02 Feb
 2023 01:21:40 -0800 (PST)
MIME-Version: 1.0
References: <20230124100215.1671472-1-etienne.carriere@linaro.org>
In-Reply-To: <20230124100215.1671472-1-etienne.carriere@linaro.org>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Thu, 2 Feb 2023 14:51:29 +0530
Message-ID: <CAFA6WYNTUnum2kZnZVJgCQyV57kM0SVZ6FZs7bH4cjb8zgkiag@mail.gmail.com>
Subject: Re: [PATCH v3] optee: add per cpu asynchronous notification
To:     Etienne Carriere <etienne.carriere@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Jens Wiklander <jens.wiklander@linaro.org>,
        Marc Zyngier <maz@kernel.org>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Etienne,

On Tue, 24 Jan 2023 at 15:33, Etienne Carriere
<etienne.carriere@linaro.org> wrote:
>
> Implements use of per-cpu irq for optee asynchronous notification.
>
> Existing optee async notif implementation allows OP-TE world to

s/OP-TE/OP-TEE/

> raise an interrupt for which Linux optee driver will query pending
> events bound to waiting tasks in Linux world or threaded bottom half
> tasks to be invoked in TEE world. This change allows the signaling
> interrupt to be a per-cpu interrupt as with Arm GIC PPIs.

This description says what you have done but doesn't mention why? IOW,
why do you need a per-cpu interrupt for async notifications?

>
> Cc: Jens Wiklander <jens.wiklander@linaro.org>
> Cc: Sumit Garg <sumit.garg@linaro.org>
> Cc: Marc Zyngier <maz@kernel.org>
>
> Co-developed-by: Alexandre Torgue <alexandre.torgue@foss.st.com>
> Signed-off-by: Alexandre Torgue <alexandre.torgue@foss.st.com>
> Signed-off-by: Etienne Carriere <etienne.carriere@linaro.org>
> ---
> Changes since v2:
> - Irq and per-cpu irq no more share the primary same handler function
>   but have a common irq_handler() helper function.
> - Removed useless spinlocks.
> - Wrapped lines > 80 char.
>
> Changes since v1:
> - Fixed missing __percpu attribute reported by kernel test robot.
> - Rephrased commit message and added Cc tags.
> ---
>  drivers/tee/optee/optee_private.h | 22 +++++++
>  drivers/tee/optee/smc_abi.c       | 97 +++++++++++++++++++++++++++++--
>  2 files changed, 115 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/tee/optee/optee_private.h b/drivers/tee/optee/optee_private.h
> index 04ae58892608..e5bd3548691f 100644
> --- a/drivers/tee/optee/optee_private.h
> +++ b/drivers/tee/optee/optee_private.h
> @@ -94,11 +94,33 @@ struct optee_supp {
>         struct completion reqs_c;
>  };
>
> +/*
> + * struct optee_pcpu - per cpu notif private struct passed to work functions
> + * @optee              optee device reference
> + */
> +struct optee_pcpu {
> +       struct optee *optee;
> +};
> +
> +/*
> + * struct optee_smc - optee smc communication struct
> + * @invoke_fn          handler function to invoke secure monitor
> + * @memremaped_shm     virtual address of memory in shared memory pool
> + * @sec_caps:          secure world capabilities defined by
> + *                     OPTEE_SMC_SEC_CAP_* in optee_smc.h
> + * @notif_irq          interrupt used as async notification by OP-TEE or 0
> + * @optee_pcpu         per_cpu optee instance for per cpu work or NULL
> + * @notif_pcpu_wq      workqueue for per cpu aynchronous notification or NULL
> + * @notif_pcpu_work    work for per cpu asynchronous notification
> + */
>  struct optee_smc {
>         optee_invoke_fn *invoke_fn;
>         void *memremaped_shm;
>         u32 sec_caps;
>         unsigned int notif_irq;
> +       struct optee_pcpu __percpu *optee_pcpu;
> +       struct workqueue_struct *notif_pcpu_wq;
> +       struct work_struct notif_pcpu_work;
>  };
>
>  /**
> diff --git a/drivers/tee/optee/smc_abi.c b/drivers/tee/optee/smc_abi.c
> index a1c1fa1a9c28..eff35f66399e 100644
> --- a/drivers/tee/optee/smc_abi.c
> +++ b/drivers/tee/optee/smc_abi.c
> @@ -991,9 +991,8 @@ static u32 get_async_notif_value(optee_invoke_fn *invoke_fn, bool *value_valid,
>         return res.a1;
>  }
>
> -static irqreturn_t notif_irq_handler(int irq, void *dev_id)
> +static irqreturn_t irq_handler(struct optee *optee)
>  {
> -       struct optee *optee = dev_id;
>         bool do_bottom_half = false;
>         bool value_valid;
>         bool value_pending;
> @@ -1016,6 +1015,11 @@ static irqreturn_t notif_irq_handler(int irq, void *dev_id)
>         return IRQ_HANDLED;
>  }
>
> +static irqreturn_t notif_irq_handler(int irq, void *dev_id)
> +{
> +       return irq_handler((struct optee *)dev_id);
> +}
> +
>  static irqreturn_t notif_irq_thread_fn(int irq, void *dev_id)
>  {
>         struct optee *optee = dev_id;
> @@ -1025,7 +1029,7 @@ static irqreturn_t notif_irq_thread_fn(int irq, void *dev_id)
>         return IRQ_HANDLED;
>  }
>
> -static int optee_smc_notif_init_irq(struct optee *optee, u_int irq)
> +static int init_irq(struct optee *optee, u_int irq)
>  {
>         int rc;
>
> @@ -1040,12 +1044,97 @@ static int optee_smc_notif_init_irq(struct optee *optee, u_int irq)
>         return 0;
>  }
>
> +static irqreturn_t notif_pcpu_irq_handler(int irq, void *dev_id)
> +{
> +       struct optee_pcpu __percpu *pcpu = (struct optee_pcpu *)dev_id;
> +       struct optee *optee = pcpu->optee;
> +
> +       if (irq_handler(optee) == IRQ_WAKE_THREAD)
> +               queue_work(optee->smc.notif_pcpu_wq,
> +                          &optee->smc.notif_pcpu_work);
> +
> +       return IRQ_HANDLED;
> +}
> +
> +static void notif_pcpu_irq_work_fn(struct work_struct *work)
> +{
> +       struct optee_smc *optee_smc = container_of(work, struct optee_smc,
> +                                                  notif_pcpu_work);
> +       struct optee *optee = container_of(optee_smc, struct optee, smc);
> +
> +       optee_smc_do_bottom_half(optee->ctx);
> +}
> +
> +static int init_pcpu_irq(struct optee *optee, u_int irq)
> +{
> +       struct optee_pcpu __percpu *optee_pcpu;
> +       int cpu;
> +       int rc;
> +
> +       optee_pcpu = alloc_percpu(struct optee_pcpu);
> +       if (!optee_pcpu)
> +               return -ENOMEM;
> +
> +       for_each_present_cpu(cpu) {
> +               struct optee_pcpu __percpu *p = per_cpu_ptr(optee_pcpu, cpu);
> +
> +               p->optee = optee;
> +       }
> +
> +       rc = request_percpu_irq(irq, notif_pcpu_irq_handler,
> +                               "optee_pcpu_notification", optee_pcpu);
> +       if (rc)
> +               goto err_free_pcpu;
> +
> +       enable_percpu_irq(irq, 0);
> +
> +       INIT_WORK(&optee->smc.notif_pcpu_work, notif_pcpu_irq_work_fn);
> +       optee->smc.notif_pcpu_wq = create_workqueue("optee_pcpu_notification");
> +       if (!optee->smc.notif_pcpu_wq) {
> +               rc = -EINVAL;
> +               goto err_free_pcpu_irq;
> +       }
> +
> +       optee->smc.optee_pcpu = optee_pcpu;
> +       optee->smc.notif_irq = irq;
> +
> +       return 0;
> +
> +err_free_pcpu_irq:
> +       disable_percpu_irq(irq);
> +       free_percpu_irq(irq, optee_pcpu);
> +err_free_pcpu:
> +       free_percpu(optee_pcpu);
> +
> +       return rc;
> +}
> +
> +static int optee_smc_notif_init_irq(struct optee *optee, u_int irq)
> +{
> +       if (irq_is_percpu_devid(irq))

You need to update OP-TEE DT binding as well to say that the interrupt
can be a PPI as well.

-Sumit

> +               return init_pcpu_irq(optee, irq);
> +       else
> +               return init_irq(optee, irq);
> +}
> +
> +static void uninit_pcpu_irq(struct optee *optee)
> +{
> +       disable_percpu_irq(optee->smc.notif_irq);
> +
> +       free_percpu_irq(optee->smc.notif_irq, optee->smc.optee_pcpu);
> +       free_percpu(optee->smc.optee_pcpu);
> +}
> +
>  static void optee_smc_notif_uninit_irq(struct optee *optee)
>  {
>         if (optee->smc.sec_caps & OPTEE_SMC_SEC_CAP_ASYNC_NOTIF) {
>                 optee_smc_stop_async_notif(optee->ctx);
>                 if (optee->smc.notif_irq) {
> -                       free_irq(optee->smc.notif_irq, optee);
> +                       if (irq_is_percpu_devid(optee->smc.notif_irq))
> +                               uninit_pcpu_irq(optee);
> +                       else
> +                               free_irq(optee->smc.notif_irq, optee);
> +
>                         irq_dispose_mapping(optee->smc.notif_irq);
>                 }
>         }
> --
> 2.25.1
>
