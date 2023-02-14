Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE415696217
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 12:12:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232411AbjBNLMP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 06:12:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232972AbjBNLLx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 06:11:53 -0500
Received: from mail-vs1-xe29.google.com (mail-vs1-xe29.google.com [IPv6:2607:f8b0:4864:20::e29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D083B27D49
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 03:11:07 -0800 (PST)
Received: by mail-vs1-xe29.google.com with SMTP id d66so16096508vsd.9
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 03:11:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=CphVCx6zNeJRiICfBSd451PoNoLt5ncJSNhJYqLyD5g=;
        b=ucWlvEhukodRIgj2znQE6MS0MVLTf8Y/Blz+Of8GLvVxMrCouO3quOR3nXYoKyZ9tf
         u8hV15cEFcIc+mzPUezh6pnH5sTbWLhALiGLAJ1N08Cb9kdArsuYBfkEkGTsNfdOroD5
         EkbOre0x1OTe8mKusE6ubqtf+syOcNk+w/8MAQXrVpvLWg3tkf47vnbsaOCa3GJfcFgu
         Mtad2bR7CROX/nWeNENEm/Z14kdutHNnmFsxx7Ztd9NWfHRstu5rHOCQpLjRCl5fkR5N
         dmM7rmywsRM7Fp9YV7OXWvdVJjU657SVNwhvrgzzFRpMouJEqvloq6eTnDAeLW1moEiB
         oRjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CphVCx6zNeJRiICfBSd451PoNoLt5ncJSNhJYqLyD5g=;
        b=Gfxl02EElcdjiFhe7fmR2Gsr/JLYoyNt6rVaTf8itC0wO68O+Uy5ZUaCFV2LfNiR9k
         vv7O1OKIDdhvn0FyHck/itxpvAQDLxgVZH+KmeV/9CjPYMS+QrWYDQ1oLavLJp+tWt4A
         0BNtsCDkvQiBz3ZHT+vTxWPw+TysLRVWDlxsm7ZiIC7/lDOVWlK4zphBZxFqhZBDV7Cx
         nYLBCalvRxYuFJV3K8kJndPlLreJLzsnR9vRQ7g4G8E62q9OtmHRWfLWeBfGL4xUvGSk
         E7pbQx2eve9eO3HFSa92GxdYdSziNnbVxdw0tBZNod8xU7ONlMBz3Efi2Lq4q9mdYgXW
         aFXA==
X-Gm-Message-State: AO0yUKUrWccsqk0F1ImRy27F6UHgE3Q5JfAHMTUtX4R40j2jy/A9HP+L
        gkJnfHKhvsO5/pnEGHQGFzoHRbjJFkeMPWggh9Alqw==
X-Google-Smtp-Source: AK7set9pGxSzJLJtwWTrlG/pr9dWTw/2Dx8Va1Q6rt8yO4eomdIEop1/97m/4aupQnPXw3qmY+ASe45Oh1rBkHNN9wc=
X-Received: by 2002:a67:e317:0:b0:411:a043:bb3f with SMTP id
 j23-20020a67e317000000b00411a043bb3fmr274131vsf.14.1676373061519; Tue, 14 Feb
 2023 03:11:01 -0800 (PST)
MIME-Version: 1.0
References: <20230213095829.42911-1-etienne.carriere@linaro.org> <20230213095829.42911-2-etienne.carriere@linaro.org>
In-Reply-To: <20230213095829.42911-2-etienne.carriere@linaro.org>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Tue, 14 Feb 2023 16:40:50 +0530
Message-ID: <CAFA6WYPX4t9ML_ErT8NXibdC0BOj_yQteKE=bE2225qh42hvZA@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] optee: add per cpu asynchronous notification
To:     Etienne Carriere <etienne.carriere@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Jens Wiklander <jens.wiklander@linaro.org>,
        Marc Zyngier <maz@kernel.org>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 13 Feb 2023 at 15:28, Etienne Carriere
<etienne.carriere@linaro.org> wrote:
>
> Implements use of per-cpu irq for optee asynchronous notification.
>
> Existing optee async notif implementation allows OP-TEE world to
> raise an interrupt for which Linux optee driver will query pending
> events bound to waiting tasks in Linux world or threaded bottom half
> tasks to be invoked in TEE world. This change allows the signaling
> interrupt to be a per-cpu interrupt as with Arm GIC PPIs.
>
> Using a PPI instead of an SPI is useful when no GIC lines are provisioned
> in the chip design for OP-TEE async notifications. Instead of using an
> unused GIC SPI for a specific platform, optee can use a common GIC PPI
> across platforms.
>
> Cc: Jens Wiklander <jens.wiklander@linaro.org>
> Cc: Sumit Garg <sumit.garg@linaro.org>
> Cc: Marc Zyngier <maz@kernel.org>
>
> Co-developed-by: Alexandre Torgue <alexandre.torgue@foss.st.com>
> Signed-off-by: Alexandre Torgue <alexandre.torgue@foss.st.com>
> Signed-off-by: Etienne Carriere <etienne.carriere@linaro.org>
> ---
> Changes since v3:
> - Fixed typo in commit message.
> - Added few words in commit message about why we do this change.
> - Appended a 2nd commit to the series for request DT bindings update.
>
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

AFAICS, this percpu irq is only enabled for CPU which is doing OP-TEE
driver probe. How would it be enabled for other CPUs? Hot plugged
CPUs?

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
> +               return init_pcpu_irq(optee, irq);
> +       else
> +               return init_irq(optee, irq);
> +}
> +
> +static void uninit_pcpu_irq(struct optee *optee)
> +{
> +       disable_percpu_irq(optee->smc.notif_irq);

OP-TEE remove may be called on a different CPU than the one which did
the OP-TEE probe. So we need to disable percpu irq for every CPU which
I am not sure can be done in a clean manner here. AFAICS,
cpuhp_setup_state() and friends are the commonly used APIs to
enable/disable percpu irq.

-Sumit

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
