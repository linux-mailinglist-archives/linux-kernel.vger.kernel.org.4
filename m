Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9803D6C4EB8
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 15:59:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230481AbjCVO7B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 10:59:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231267AbjCVO6q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 10:58:46 -0400
Received: from mail-ua1-x92f.google.com (mail-ua1-x92f.google.com [IPv6:2607:f8b0:4864:20::92f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84FBC28D1E
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 07:58:23 -0700 (PDT)
Received: by mail-ua1-x92f.google.com with SMTP id r7so12846742uaj.2
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 07:58:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679497102;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=HPaUHKAswhBrfoLCTPOxVXiJXKFKpGsUrZPULRLwtpQ=;
        b=Dmst2gBCg9QmfgFA/k61KDvUi86KZnuMBpJHi1zXzXXrO6gfHmIZHhDP7GGTyJXce4
         xwkt8JSuKfIipTY0mTbSk48D5oAy1AlS3oqijPb1zPRK4a/0S6FDI3SIxNpsl/FEAULI
         Gs0j1S58OcHxOHeN2a5QJjy9+rzZM9RYLBlvV9yQt9tws7IoUfnqSSB0+lcbcwGEN1Gk
         Yp85olkkMsKT/o2B46gdKNt1+JKJKb3F2WgZqRKMgGToje1zb4k/MJv9gcibA6lU9CCh
         z7IYViVUc/oa6k6EVP3g6LtTSzBbTbHJYTMekjYLG1duwcNNXv/6rM6f8o24tVUsl7TQ
         cwkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679497102;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HPaUHKAswhBrfoLCTPOxVXiJXKFKpGsUrZPULRLwtpQ=;
        b=FDlieCE/vs9U6FBo0Z84aL91F8Bzl/Uwr1z0bjrV7lIyhtBYTw2aXghhIr/bYRcS6j
         Dm5KOPnJhKmoj0ASCTxiSknxsXAzgtRGnAu8LC1ir+8F26aSp5xIuiNDdAii4+tOJ62U
         whnLZJygbkPfXfs1HjvXVkqhOh9xigr2wzQDjsHuKfIAxaWNeHotwWqWLGCE13/SOIrR
         nYn1Ie7r3SBg1X8qp5O7so7dkrB299fQpjjX5W55UiWHtGy/jJiT8VkF7cHVwYOPS/lu
         abWS2Z8xKGiWaoOH/ExIBLK24rAfmen8pIaUSljQO2y5eQIj+KdyVUCKrCY9jycFmioE
         l0rg==
X-Gm-Message-State: AO0yUKWOki98KKurrfclUNYJ6ijYCWCYd4vZgEwIOTroSvQdHYRwIJ2F
        q9q+G2+ttjS2d8fK5/07YCsx5NXlIUgIWiP4kv0Qmg==
X-Google-Smtp-Source: AK7set/GU6f8zOS9ETm5eKU+DrTt8NonslwVk69slIl4VbJuedO/y3EwxFPyXdSC3mmZQYj9YysXy6T50+WJ4JC4yHI=
X-Received: by 2002:a1f:25c4:0:b0:436:3381:85c3 with SMTP id
 l187-20020a1f25c4000000b00436338185c3mr3408414vkl.2.1679497102591; Wed, 22
 Mar 2023 07:58:22 -0700 (PDT)
MIME-Version: 1.0
References: <20230322132212.3646972-1-etienne.carriere@linaro.org> <20230322132212.3646972-2-etienne.carriere@linaro.org>
In-Reply-To: <20230322132212.3646972-2-etienne.carriere@linaro.org>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Wed, 22 Mar 2023 20:28:11 +0530
Message-ID: <CAFA6WYP16n9MkC5mQnRXMBsCqVLQyfLejk1Vt1Z6o=XPX6ccAQ@mail.gmail.com>
Subject: Re: [PATCH v6 2/2] optee: add per cpu asynchronous notification
To:     Etienne Carriere <etienne.carriere@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        op-tee@lists.trustedfirmware.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jens Wiklander <jens.wiklander@linaro.org>,
        Marc Zyngier <maz@kernel.org>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 Mar 2023 at 18:52, Etienne Carriere
<etienne.carriere@linaro.org> wrote:
>
> Implements use of per-cpu irq for optee asynchronous notification.
>
> Existing optee async notif implementation allows OP-TEE world to
> raise an interrupt on which Linux optee driver will query some pending
> events. This change allows the signaling interrupt to be a per-cpu
> interrupt as with Arm GIC PPIs. Using a PPI instead of an SPI is useful
> when no GIC lines are provisioned in the chip design and there are spare
> PPI lines.
>
> Cc: Jens Wiklander <jens.wiklander@linaro.org>
> Cc: Sumit Garg <sumit.garg@linaro.org>
> Cc: Marc Zyngier <maz@kernel.org>
>
> Co-developed-by: Alexandre Torgue <alexandre.torgue@foss.st.com>
> Signed-off-by: Alexandre Torgue <alexandre.torgue@foss.st.com>
> Signed-off-by: Etienne Carriere <etienne.carriere@linaro.org>
> ---
> Changes since v5:
> - Removed spurious __percpu attributes reported by kernel test robot
>   (https://lore.kernel.org/lkml/202303190039.RsU7kCIu-lkp@intel.com/).
>

Apart from nit below, feel free to add:

Reviewed-by: Sumit Garg <sumit.garg@linaro.org>

> Changes since v4:
> - Used cpuhp_setup_state()/cpuhp_remove_state() to enable/disable the
>   per-cpu interrupt and let CPU hotplug also manage it.
> - Added a call to destroy_workqueue() that was missing in uninit_pcpu_irq().
> - Rephrased commit message.
>
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
>  drivers/tee/optee/optee_private.h |  24 ++++++
>  drivers/tee/optee/smc_abi.c       | 122 +++++++++++++++++++++++++++++-
>  2 files changed, 142 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/tee/optee/optee_private.h b/drivers/tee/optee/optee_private.h
> index 04ae58892608..6129d43dd354 100644
> --- a/drivers/tee/optee/optee_private.h
> +++ b/drivers/tee/optee/optee_private.h
> @@ -94,11 +94,35 @@ struct optee_supp {
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

s/aynchronous/asynchronous/

-Sumit

> + * @notif_pcpu_work    work for per cpu asynchronous notification
> + * @notif_cpuhp_state   CPU hotplug state assigned for pcpu interrupt management
> + */
>  struct optee_smc {
>         optee_invoke_fn *invoke_fn;
>         void *memremaped_shm;
>         u32 sec_caps;
>         unsigned int notif_irq;
> +       struct optee_pcpu __percpu *optee_pcpu;
> +       struct workqueue_struct *notif_pcpu_wq;
> +       struct work_struct notif_pcpu_work;
> +       unsigned int notif_cpuhp_state;
>  };
>
>  /**
> diff --git a/drivers/tee/optee/smc_abi.c b/drivers/tee/optee/smc_abi.c
> index a1c1fa1a9c28..de7ac9a46354 100644
> --- a/drivers/tee/optee/smc_abi.c
> +++ b/drivers/tee/optee/smc_abi.c
> @@ -52,6 +52,23 @@
>   */
>  #define OPTEE_MIN_STATIC_POOL_ALIGN    9 /* 512 bytes aligned */
>
> +/* SMC ABI considers at most a single TEE firmware */
> +static unsigned int pcpu_irq_num;
> +
> +static int optee_cpuhp_enable_pcpu_irq(unsigned int cpu)
> +{
> +       enable_percpu_irq(pcpu_irq_num, IRQ_TYPE_NONE);
> +
> +       return 0;
> +}
> +
> +static int optee_cpuhp_disable_pcpu_irq(unsigned int cpu)
> +{
> +       disable_percpu_irq(pcpu_irq_num);
> +
> +       return 0;
> +}
> +
>  /*
>   * 1. Convert between struct tee_param and struct optee_msg_param
>   *
> @@ -991,9 +1008,8 @@ static u32 get_async_notif_value(optee_invoke_fn *invoke_fn, bool *value_valid,
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
> @@ -1016,6 +1032,13 @@ static irqreturn_t notif_irq_handler(int irq, void *dev_id)
>         return IRQ_HANDLED;
>  }
>
> +static irqreturn_t notif_irq_handler(int irq, void *dev_id)
> +{
> +       struct optee *optee = dev_id;
> +
> +       return irq_handler(optee);
> +}
> +
>  static irqreturn_t notif_irq_thread_fn(int irq, void *dev_id)
>  {
>         struct optee *optee = dev_id;
> @@ -1025,7 +1048,7 @@ static irqreturn_t notif_irq_thread_fn(int irq, void *dev_id)
>         return IRQ_HANDLED;
>  }
>
> -static int optee_smc_notif_init_irq(struct optee *optee, u_int irq)
> +static int init_irq(struct optee *optee, u_int irq)
>  {
>         int rc;
>
> @@ -1040,12 +1063,103 @@ static int optee_smc_notif_init_irq(struct optee *optee, u_int irq)
>         return 0;
>  }
>
> +static irqreturn_t notif_pcpu_irq_handler(int irq, void *dev_id)
> +{
> +       struct optee_pcpu *pcpu = dev_id;
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
> +       int cpu, rc;
> +
> +       optee_pcpu = alloc_percpu(struct optee_pcpu);
> +       if (!optee_pcpu)
> +               return -ENOMEM;
> +
> +       for_each_present_cpu(cpu)
> +               per_cpu_ptr(optee_pcpu, cpu)->optee = optee;
> +
> +       rc = request_percpu_irq(irq, notif_pcpu_irq_handler,
> +                               "optee_pcpu_notification", optee_pcpu);
> +       if (rc)
> +               goto err_free_pcpu;
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
> +       pcpu_irq_num = irq;
> +       rc = cpuhp_setup_state(CPUHP_AP_ONLINE_DYN, "optee/pcpu-notif:starting",
> +                              optee_cpuhp_enable_pcpu_irq,
> +                              optee_cpuhp_disable_pcpu_irq);
> +       if (!rc)
> +               rc = -EINVAL;
> +       if (rc < 0)
> +               goto err_free_pcpu_irq;
> +
> +       optee->smc.notif_cpuhp_state = rc;
> +
> +       return 0;
> +
> +err_free_pcpu_irq:
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
> +       cpuhp_remove_state(optee->smc.notif_cpuhp_state);
> +
> +       destroy_workqueue(optee->smc.notif_pcpu_wq);
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
