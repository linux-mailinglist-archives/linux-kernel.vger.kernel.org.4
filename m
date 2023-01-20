Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1963667521C
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 11:10:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229812AbjATKKI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 05:10:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbjATKKG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 05:10:06 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 054FC8B326
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 02:10:03 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id mg12so12674307ejc.5
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 02:10:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=AG1NAI3D9FdUdfEr4F/cuO0JdlZg8whZJ3y90V/FCuA=;
        b=FXhI148APYh86kLGt0/5pbAuLTtxoRAq4dMWsve4kZwTnLA+8+1+9almT2HOi7HCS6
         P/VuyW/reev7CVl9LmwIvkSLYEYrZiEmOe/OegsOOmLUkeBk9/1CNAk7Ar5muDuUBeQs
         vJ376GGR50cukkMOhBrnQ8prgv0tWBRnJXJrf1aP73tS77S0LuXu1Gf5y9CclM7g0Sr+
         Br+L4pv0h/xP0Eg3paLUnbjO7ePWToUgIt7zu1+cq72EAZCDfSG7aCSH0OwdsFuFvsih
         mfCJS/jbH6G/QRdm4zuu5KyKD9S/z/YHwkOyffe9e1YFhbV5GVgZe/tuT8uR5EgOR/pg
         yO0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AG1NAI3D9FdUdfEr4F/cuO0JdlZg8whZJ3y90V/FCuA=;
        b=vx6GW/WRGZ65szUNFnNwWqZjlOqyx1EiwufgTjoH4SpTZ8NhebTE/PI3B5cM2NK7VX
         DKN13c/l6jMN68xLudgSKUqPfEbC2B/zNh6sG+g2r2fAwFurnK02+gNziTs5QaUcHuvm
         2Pzy+sEfFMGlOBgNjAFvEe7hQJ/Sdpr3g6qwy+wWoqprc2g0LXwAWp0ZBZgImRRAGpzQ
         3uDoxviazTEBVbDq3DPZ4u1ZGrJ4ksaazW+F+ZIr+PzaUAnDrIoUE7qUEvQ7NRy5q5HT
         2s+zENr2jF9iaXTQawX4yp+oe6rfJ1Q5UgX0y2GEzcCBmRr4a00ezMT7luuN/kJ6FwLv
         Uanw==
X-Gm-Message-State: AFqh2kpnMUC0YnXv01ZltfjzpchyFCwJoU6Z+Hue7EIMjdzBsOPt0Fzh
        TuO+Vzb6zi8yIAAgyy5tpQsLedtIgHhTBAQOFttoPw==
X-Google-Smtp-Source: AMrXdXsqM7o8Qb0+P+a0CijvPg2ybYJZirmGbPjcMqAMVA78rxG6j57KeW1Gk+O/AahCFnZgiu1ti+YYLtk1TI756m0=
X-Received: by 2002:a17:906:4757:b0:79a:101a:7e57 with SMTP id
 j23-20020a170906475700b0079a101a7e57mr1840114ejs.368.1674209401551; Fri, 20
 Jan 2023 02:10:01 -0800 (PST)
MIME-Version: 1.0
References: <20230118174909.2049638-1-etienne.carriere@linaro.org> <Y8pR1Bm7TQdtI7x5@jade>
In-Reply-To: <Y8pR1Bm7TQdtI7x5@jade>
From:   Etienne Carriere <etienne.carriere@linaro.org>
Date:   Fri, 20 Jan 2023 11:09:50 +0100
Message-ID: <CAN5uoS_FLLMS2uUAZ9artSpx=mLS5ay+ybSL9XzPniU26Uuckw@mail.gmail.com>
Subject: Re: [PATCH v2] optee: add per cpu asynchronous notification
To:     Jens Wiklander <jens.wiklander@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Sumit Garg <sumit.garg@linaro.org>,
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

Hello Jens,

Thanks for the feedback.

On Fri, 20 Jan 2023 at 09:33, Jens Wiklander <jens.wiklander@linaro.org> wrote:
>
> On Wed, Jan 18, 2023 at 06:49:09PM +0100, Etienne Carriere wrote:
> > Implements use of per CPU irq for optee asynchronous notification.
> >
> > Existing optee async notif implementation allows OP-TE world to
>
> allows OP-TEE in the secure world to
>
> > raise an interrupt for the Linux optee driver to query pending events
> > bound to waiting tasks in Linux world or threaded bottom half tasks
> > to be invoked in TEE world. This change allows the signaling interrupt
> > to be a per cpu interrupt as with Arm GIC PPIs.
> >
> > Cc: Jens Wiklander <jens.wiklander@linaro.org>
> > Cc: Sumit Garg <sumit.garg@linaro.org>
> > Cc: Marc Zyngier <maz@kernel.org>
> >
> > Co-developed-by: Alexandre Torgue <alexandre.torgue@foss.st.com>
> > Signed-off-by: Alexandre Torgue <alexandre.torgue@foss.st.com>
> > Signed-off-by: Etienne Carriere <etienne.carriere@linaro.org>
> > ---
> > Changes since v1:
> > - Fixed missing __percpu attribute reported by kernel test robot.
> > - Rephrased commit message and added Cc tags.
> > ---
> >  drivers/tee/optee/optee_private.h |  22 ++++++
> >  drivers/tee/optee/smc_abi.c       | 107 ++++++++++++++++++++++++++++--
> >  2 files changed, 124 insertions(+), 5 deletions(-)
> >
> > diff --git a/drivers/tee/optee/optee_private.h b/drivers/tee/optee/optee_private.h
> > index 04ae58892608..e5bd3548691f 100644
> > --- a/drivers/tee/optee/optee_private.h
> > +++ b/drivers/tee/optee/optee_private.h
> > @@ -94,11 +94,33 @@ struct optee_supp {
> >       struct completion reqs_c;
> >  };
> >
> > +/*
> > + * struct optee_pcpu - per cpu notif private struct passed to work functions
> > + * @optee            optee device reference
> > + */
> > +struct optee_pcpu {
> > +     struct optee *optee;
> > +};
> > +
> > +/*
> > + * struct optee_smc - optee smc communication struct
> > + * @invoke_fn                handler function to invoke secure monitor
> > + * @memremaped_shm   virtual address of memory in shared memory pool
> > + * @sec_caps:                secure world capabilities defined by
> > + *                   OPTEE_SMC_SEC_CAP_* in optee_smc.h
> > + * @notif_irq                interrupt used as async notification by OP-TEE or 0
> > + * @optee_pcpu               per_cpu optee instance for per cpu work or NULL
> > + * @notif_pcpu_wq    workqueue for per cpu aynchronous notification or NULL
> > + * @notif_pcpu_work  work for per cpu asynchronous notification
> > + */
> >  struct optee_smc {
> >       optee_invoke_fn *invoke_fn;
> >       void *memremaped_shm;
> >       u32 sec_caps;
> >       unsigned int notif_irq;
> > +     struct optee_pcpu __percpu *optee_pcpu;
> > +     struct workqueue_struct *notif_pcpu_wq;
> > +     struct work_struct notif_pcpu_work;
> >  };
> >
> >  /**
> > diff --git a/drivers/tee/optee/smc_abi.c b/drivers/tee/optee/smc_abi.c
> > index a1c1fa1a9c28..ffa3f3aa7244 100644
> > --- a/drivers/tee/optee/smc_abi.c
> > +++ b/drivers/tee/optee/smc_abi.c
> > @@ -993,12 +993,20 @@ static u32 get_async_notif_value(optee_invoke_fn *invoke_fn, bool *value_valid,
> >
> >  static irqreturn_t notif_irq_handler(int irq, void *dev_id)
>
> Wouldn't it be easier with one handler for shared irqs and one for
> per-cpu irqs? The only common part is the do-while loop which I suppose
> could go into a helper function.

Ok, I do that.

>
> >  {
> > -     struct optee *optee = dev_id;
> > +     struct optee *optee;
> >       bool do_bottom_half = false;
> >       bool value_valid;
> >       bool value_pending;
> >       u32 value;
> >
> > +     if (irq_is_percpu_devid(irq)) {
> > +             struct optee_pcpu __percpu *pcpu = (struct optee_pcpu *)dev_id;
> > +
> > +             optee = pcpu->optee;
> > +     } else {
> > +             optee = dev_id;
> > +     }
> > +
> >       do {
> >               value = get_async_notif_value(optee->smc.invoke_fn,
> >                                             &value_valid, &value_pending);
> > @@ -1011,8 +1019,13 @@ static irqreturn_t notif_irq_handler(int irq, void *dev_id)
> >                       optee_notif_send(optee, value);
> >       } while (value_pending);
> >
> > -     if (do_bottom_half)
> > -             return IRQ_WAKE_THREAD;
> > +     if (do_bottom_half) {
> > +             if (irq_is_percpu_devid(irq))
> > +                     queue_work(optee->smc.notif_pcpu_wq, &optee->smc.notif_pcpu_work);
>
> This line is a bit long, please break it.

ok, thanks.

>
> > +             else
> > +                     return IRQ_WAKE_THREAD;
> > +     }
> > +
> >       return IRQ_HANDLED;
> >  }
> >
> > @@ -1025,7 +1038,7 @@ static irqreturn_t notif_irq_thread_fn(int irq, void *dev_id)
> >       return IRQ_HANDLED;
> >  }
> >
> > -static int optee_smc_notif_init_irq(struct optee *optee, u_int irq)
> > +static int init_irq(struct optee *optee, u_int irq)
> >  {
> >       int rc;
> >
> > @@ -1040,12 +1053,96 @@ static int optee_smc_notif_init_irq(struct optee *optee, u_int irq)
> >       return 0;
> >  }
> >
> > +static void notif_pcpu_irq_work_fn(struct work_struct *work)
> > +{
> > +     struct optee_smc *optee_smc = container_of(work, struct optee_smc, notif_pcpu_work);
>
> This line is a bit long, please break it.

ok.

>
> > +     struct optee *optee = container_of(optee_smc, struct optee, smc);
> > +
> > +     optee_smc_do_bottom_half(optee->ctx);
> > +}
> > +
> > +static int init_pcpu_irq(struct optee *optee, u_int irq)
> > +{
> > +     struct optee_pcpu __percpu *optee_pcpu;
> > +     spinlock_t lock;
> > +     int cpu;
> > +     int rc;
> > +
> > +     optee_pcpu = alloc_percpu(struct optee_pcpu);
> > +     if (!optee_pcpu)
> > +             return -ENOMEM;
> > +
> > +     for_each_present_cpu(cpu) {
> > +             struct optee_pcpu __percpu *p = per_cpu_ptr(optee_pcpu, cpu);
> > +
> > +             p->optee = optee;
> > +     }
> > +
> > +     rc = request_percpu_irq(irq, notif_irq_handler,
> > +                             "optee_pcpu_notification", optee_pcpu);
> > +     if (rc)
> > +             goto err_free_pcpu;
> > +
> > +     spin_lock_init(&lock);
> > +
> > +     spin_lock(&lock);
>
> What is the point with this spinlock?

Hmm... indeed. I'll remove.

>
> > +     enable_percpu_irq(irq, 0);
> > +     spin_unlock(&lock);
> > +
> > +     INIT_WORK(&optee->smc.notif_pcpu_work, notif_pcpu_irq_work_fn);
> > +     optee->smc.notif_pcpu_wq = create_workqueue("optee_pcpu_notification");
> > +     if (!optee->smc.notif_pcpu_wq) {
> > +             rc = -EINVAL;
> > +             goto err_free_pcpu_irq;
> > +     }
> > +
> > +     optee->smc.optee_pcpu = optee_pcpu;
> > +     optee->smc.notif_irq = irq;
> > +
> > +     return 0;
> > +
> > +err_free_pcpu_irq:
> > +     spin_lock(&lock);
> > +     disable_percpu_irq(irq);
> > +     spin_unlock(&lock);
> > +     free_percpu_irq(irq, optee_pcpu);
> > +err_free_pcpu:
> > +     free_percpu(optee_pcpu);
> > +
> > +     return rc;
> > +}
> > +
> > +static int optee_smc_notif_init_irq(struct optee *optee, u_int irq)
> > +{
> > +     if (irq_is_percpu_devid(irq))
> > +             return init_pcpu_irq(optee, irq);
> > +     else
> > +             return init_irq(optee, irq);
> > +}
> > +
> > +static void uninit_pcpu_irq(struct optee *optee)
> > +{
> > +     spinlock_t lock;
> > +
> > +     spin_lock_init(&lock);
> > +     spin_lock(&lock);
>
> What's the point with this spinlock?
>
>
> Cheers,
> Jens
>
> > +     disable_percpu_irq(optee->smc.notif_irq);
> > +     spin_unlock(&lock);
> > +
> > +     free_percpu_irq(optee->smc.notif_irq, optee->smc.optee_pcpu);
> > +     free_percpu(optee->smc.optee_pcpu);
> > +}
> > +
> >  static void optee_smc_notif_uninit_irq(struct optee *optee)
> >  {
> >       if (optee->smc.sec_caps & OPTEE_SMC_SEC_CAP_ASYNC_NOTIF) {
> >               optee_smc_stop_async_notif(optee->ctx);
> >               if (optee->smc.notif_irq) {
> > -                     free_irq(optee->smc.notif_irq, optee);
> > +                     if (irq_is_percpu_devid(optee->smc.notif_irq))
> > +                             uninit_pcpu_irq(optee);
> > +                     else
> > +                             free_irq(optee->smc.notif_irq, optee);
> > +
> >                       irq_dispose_mapping(optee->smc.notif_irq);
> >               }
> >       }
> > --
> > 2.25.1
> >
