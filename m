Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 916556BD127
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 14:45:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230325AbjCPNpb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 09:45:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229930AbjCPNpY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 09:45:24 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBC0F75A40
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 06:45:22 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id l12so1579778wrm.10
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 06:45:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678974321;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XySx3jV3xEipa/HELoqrBjB9yryOO5F7eocg+dFMhy4=;
        b=adSxJTPRet2CALew/avVIjVyBLDMJLE36kXJIL+SxudjDBZ3QBbVnlmC94IzU8sKF1
         NNPtO9jQVEIOXh9YeHinCKXpjEvfzjIdEOw9yj4TWs1pcq5Ud0jvMyK2zhKpvxEosyzf
         Y0o4IoyTd4P6pl2oJmrfmOqjnutnhh1kgWNNCQScgdRQZdLJZB+Pn3LGQL4RP1RlOj8x
         NTFSgQxieoVFYggX8b0DLnZDIrTHBBLsNWWNJS8liYueTvUcLShV2DFDqywuvAjTfizW
         nIsbStHy+v91bZjfYH0U7KGehsg6kZJB1LhvnO9QuC0iJKTtWxakaCDhfr6l9hIVU96k
         BMMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678974321;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XySx3jV3xEipa/HELoqrBjB9yryOO5F7eocg+dFMhy4=;
        b=sjpUEzmPlZIlNA1QaDCAdpeYR/jrugrlo+6U54Po2Vm2f0VPNtzt/eL1Sl1sCb/GNl
         rQPqBcBn1xA7dHtzvf6ayeSJPT5IWyoAgBrqQUg0WPRFuse76Z67QnXX0QIUGyujrOYw
         POV6Ul2QFFpBJC7PWU0CngBx+6nikFMqagGmTcQwCn2sadTDmkuZbivqnj0IeF9HWqIc
         jpcFcE3cUN4E/zhhLgPbZ0uxQHedxzpVkR0h0oBNh9tNqI8lrYf6cpd+O97qycQ7oaHt
         G8PEQIlpCnMCpbvsloeDMDFGJPbuNwC4khD+TBDUBr+l4wVLnJBpMt+5A3o5EJ1wUhF3
         xVRg==
X-Gm-Message-State: AO0yUKVzAW8T2sG5bgJqm3R/bUyhaYoigJ0BsV0WEQDTDuLBjwzURFId
        cjxtHjBm9MktmsnNNEQ93KGx2+waua5Bv8Rla4zbXw==
X-Google-Smtp-Source: AK7set/a1eEDMJYhEaELVK3rBQ9cD7X+8cWYSf0F4De52iUTCLBhZ9KZTlVO/+3zI9nOa3oa7ltQ8P5MS469t5XPNxc=
X-Received: by 2002:a05:6000:104:b0:2cf:e388:7803 with SMTP id
 o4-20020a056000010400b002cfe3887803mr1134547wrx.3.1678974321102; Thu, 16 Mar
 2023 06:45:21 -0700 (PDT)
MIME-Version: 1.0
References: <20230315113201.1343781-1-etienne.carriere@linaro.org> <20230315113201.1343781-3-etienne.carriere@linaro.org>
In-Reply-To: <20230315113201.1343781-3-etienne.carriere@linaro.org>
From:   Jens Wiklander <jens.wiklander@linaro.org>
Date:   Thu, 16 Mar 2023 14:45:10 +0100
Message-ID: <CAHUa44FOKft9xQzc6g-CywY=jgcvp-ApG=ufR3CMzwAot4df5w@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] optee: add enable/disable/set_wake handlers to
 optee irqs
To:     Etienne Carriere <etienne.carriere@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Marc Zyngier <maz@kernel.org>,
        Sumit Garg <sumit.garg@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 15, 2023 at 12:32=E2=80=AFPM Etienne Carriere
<etienne.carriere@linaro.org> wrote:
>
> Implements OP-TEE's It Notif PTA API to deactivate and activate an
> interrupt notifier and to configure the wakeup capability
> of that interrupt. These controls are useful for efficient power
> management of the device when an interrupt controller resources is
> hosted in OP-TEE world.
>
> When OP-TEE does not implement the It Notif PTA, the related handlers
> simply return with success. If OP-TEE exposes the PTA services, they
> are invoked on enable, disable and set_wake irqchip operations.
>
> Cc: Jens Wiklander <jens.wiklander@linaro.org>
> Cc: Marc Zyngier <maz@kernel.org>
> Cc: Sumit Garg <sumit.garg@linaro.org>
>
> Signed-off-by: Etienne Carriere <etienne.carriere@linaro.org>
> ---
> Changes since v3:
> - Renamed it_notif/IT_NOTIF to itr_notif/ITR_NOTIF.
>
> Changes since v2:
> - Patch added in v2 series for power-up/down and wakeup configuration
>   of the irq chip.
>
> Patch not present in v1
> - Patch added for power-up/down and wakeup configuration of the irq chip.
> ---
>  drivers/tee/optee/optee_private.h |   2 +
>  drivers/tee/optee/smc_abi.c       | 157 ++++++++++++++++++++++++++++++
>  2 files changed, 159 insertions(+)
>
> diff --git a/drivers/tee/optee/optee_private.h b/drivers/tee/optee/optee_=
private.h
> index f467409e02e9..4b4002d81315 100644
> --- a/drivers/tee/optee/optee_private.h
> +++ b/drivers/tee/optee/optee_private.h
> @@ -166,6 +166,7 @@ struct optee_ops {
>   * @scan_bus_done      flag if device registation was already done.
>   * @scan_bus_wq                workqueue to scan optee bus and register =
optee drivers
>   * @scan_bus_work      workq to scan optee bus and register optee driver=
s
> + * @notif_itr_pta_ctx   TEE context for invoking interrupt configuration=
 services
>   */
>  struct optee {
>         struct tee_device *supp_teedev;
> @@ -185,6 +186,7 @@ struct optee {
>         bool   scan_bus_done;
>         struct workqueue_struct *scan_bus_wq;
>         struct work_struct scan_bus_work;
> +       struct tee_context *notif_itr_pta_ctx;

Please use the other *ctx above instead.

Thanks,
Jens

>  };
>
>  struct optee_session {
> diff --git a/drivers/tee/optee/smc_abi.c b/drivers/tee/optee/smc_abi.c
> index 6e6c6979abfd..046aa242b2ef 100644
> --- a/drivers/tee/optee/smc_abi.c
> +++ b/drivers/tee/optee/smc_abi.c
> @@ -52,6 +52,43 @@
>   */
>  #define OPTEE_MIN_STATIC_POOL_ALIGN    9 /* 512 bytes aligned */
>
> +/*
> + * Interrupt notification can be configured using Notif-IT PTA services.
> + * Below are the PTA UUID and its API commands.
> + */
> +#define PTA_ITR_NOTIF_UUID \
> +       UUID_INIT(0x4461e5c7, 0xb523, 0x4b73, 0xac, 0xed, 0x75, 0xad, \
> +                 0x2b, 0x9b, 0x59, 0xa1)
> +
> +/*
> + * PTA_ITR_NOTIF_ACTIVATE_DETECTION - Enable a interrupt notification
> + *
> + * [in]  params[0].value.a     Interrupt ID
> + */
> +#define PTA_ITR_NOTIF_ACTIVATE_DETECTION       0
> +
> +/*
> + * PTA_ITR_NOTIF_DEACTIVATE_DETECTION - Disable a interrupt notification
> + *
> + * [in]  params[0].value.a     Interrupt ID
> + */
> +#define PTA_ITR_NOTIF_DEACTIVATE_DETECTION     1
> +
> +/*
> + * PTA_ITR_NOTIF_ENABLE_WAKEUP_SOURCE - Enable an interrupt wakeup sourc=
e
> + *
> + * [in]  params[0].value.a     Interrupt ID
> + */
> +#define PTA_ITR_NOTIF_ENABLE_WAKEUP_SOURCE     2
> +
> +/*
> + * PTA_ITR_NOTIF_ENABLE_WAKEUP_SOURCE - Disable an interrupt wakeup sour=
ce
> + *
> + * [in]  params[0].value.a     Interrupt ID
> + */
> +#define PTA_ITR_NOTIF_DISABLE_WAKEUP_SOURCE    3
> +
> +
>  /*
>   * 1. Convert between struct tee_param and struct optee_msg_param
>   *
> @@ -977,6 +1014,92 @@ static int optee_smc_stop_async_notif(struct tee_co=
ntext *ctx)
>   * 5. Asynchronous notification
>   */
>
> +static int optee_ctx_match(struct tee_ioctl_version_data *ver, const voi=
d *data)
> +{
> +       return ver->impl_id =3D=3D TEE_IMPL_ID_OPTEE;
> +}
> +
> +static void init_optee_pta_context(struct optee *optee)
> +{
> +       struct tee_context *ctx =3D NULL;
> +       const uuid_t pta_uuid =3D PTA_ITR_NOTIF_UUID;
> +       struct tee_ioctl_open_session_arg sess_arg;
> +       int ret;
> +
> +       ctx =3D tee_client_open_context(NULL, optee_ctx_match, NULL, NULL=
);
> +       if (IS_ERR(ctx))
> +               return;
> +
> +       memset(&sess_arg, 0, sizeof(sess_arg));
> +       export_uuid(sess_arg.uuid, &pta_uuid);
> +       sess_arg.clnt_login =3D TEE_IOCTL_LOGIN_REE_KERNEL;
> +
> +       ret =3D tee_client_open_session(ctx, &sess_arg, NULL);
> +       if ((ret < 0) || (sess_arg.ret !=3D 0)) {
> +               pr_err("Can't open ITR_NOTIF PTA session: %#x\n", sess_ar=
g.ret);
> +               tee_client_close_context(ctx);
> +               return;
> +       }
> +
> +       tee_client_close_session(ctx, sess_arg.session);
> +
> +       optee->notif_itr_pta_ctx =3D ctx;
> +}
> +
> +static void release_optee_pta_context(struct optee *optee)
> +{
> +       if (optee->notif_itr_pta_ctx) {
> +               tee_client_close_context(optee->notif_itr_pta_ctx);
> +               optee->notif_itr_pta_ctx =3D NULL;
> +       }
> +}
> +
> +static int invoke_optee_pta(struct optee *optee, unsigned int command,
> +                           unsigned int irq_id)
> +{
> +       const uuid_t pta_uuid =3D PTA_ITR_NOTIF_UUID;
> +       struct tee_ioctl_open_session_arg sess_arg;
> +       struct tee_ioctl_invoke_arg inv_arg;
> +       struct tee_param param[1];
> +       int ret;
> +
> +       if (!optee->notif_itr_pta_ctx)
> +               return -ENOENT;
> +
> +       memset(&sess_arg, 0, sizeof(sess_arg));
> +       export_uuid(sess_arg.uuid, &pta_uuid);
> +       sess_arg.clnt_login =3D TEE_IOCTL_LOGIN_REE_KERNEL;
> +
> +       ret =3D tee_client_open_session(optee->notif_itr_pta_ctx, &sess_a=
rg, NULL);
> +       if ((ret < 0) || (sess_arg.ret !=3D 0)) {
> +               pr_err("tee_client_open_session failed, err: %#x\n", sess=
_arg.ret);
> +               if (!ret)
> +                       ret =3D -EINVAL;
> +               return ret;
> +       }
> +
> +       memset(&inv_arg, 0, sizeof(inv_arg));
> +       inv_arg.session =3D sess_arg.session;
> +       inv_arg.func =3D command;
> +       inv_arg.num_params =3D 1;
> +
> +       memset(&param, 0, sizeof(param));
> +       param[0].attr =3D TEE_IOCTL_PARAM_ATTR_TYPE_VALUE_INPUT;
> +       param[0].u.value.a =3D irq_id;
> +
> +       ret =3D tee_client_invoke_func(optee->notif_itr_pta_ctx, &inv_arg=
, param);
> +       if ((ret < 0) || (inv_arg.ret !=3D 0)) {
> +               pr_err("tee_client_invoke_func failed, ret: %d, err: %#x\=
n",
> +                      ret, inv_arg.ret);
> +               if (!ret)
> +                       ret =3D -EINVAL;
> +       }
> +
> +       tee_client_close_session(optee->notif_itr_pta_ctx, sess_arg.sessi=
on);
> +
> +       return ret;
> +}
> +
>  static void optee_itr_notif_mask(struct irq_data *d)
>  {
>         struct optee *optee =3D d->domain->host_data;
> @@ -995,10 +1118,40 @@ static void optee_itr_notif_unmask(struct irq_data=
 *d)
>                              0, 0, 0, 0, 0, &res);
>  }
>
> +static void optee_itr_notif_disable(struct irq_data *d)
> +{
> +       struct optee *optee =3D d->domain->host_data;
> +
> +       (void)invoke_optee_pta(optee, PTA_ITR_NOTIF_DEACTIVATE_DETECTION,=
 d->hwirq);
> +}
> +
> +static void optee_itr_notif_enable(struct irq_data *d)
> +{
> +       struct optee *optee =3D d->domain->host_data;
> +
> +       (void)invoke_optee_pta(optee, PTA_ITR_NOTIF_ACTIVATE_DETECTION, d=
->hwirq);
> +}
> +
> +static int optee_itr_notif_set_wake(struct irq_data *d, unsigned int on)
> +{
> +       struct optee *optee =3D d->domain->host_data;
> +       u32 command;
> +
> +       if (on)
> +               command =3D PTA_ITR_NOTIF_ENABLE_WAKEUP_SOURCE;
> +       else
> +               command =3D PTA_ITR_NOTIF_DISABLE_WAKEUP_SOURCE;
> +
> +       return invoke_optee_pta(optee, command, d->hwirq);
> +}
> +
>  static struct irq_chip optee_irq_chip =3D {
>         .name =3D "optee-it",
>         .irq_mask =3D optee_itr_notif_mask,
>         .irq_unmask =3D optee_itr_notif_unmask,
> +       .irq_disable =3D optee_itr_notif_disable,
> +       .irq_enable =3D optee_itr_notif_enable,
> +       .irq_set_wake =3D optee_itr_notif_set_wake,
>  };
>
>  static int optee_itr_alloc(struct irq_domain *d, unsigned int virq,
> @@ -1459,6 +1612,7 @@ static int optee_smc_remove(struct platform_device =
*pdev)
>                 optee_disable_shm_cache(optee);
>
>         optee_smc_notif_uninit_irq(optee);
> +       release_optee_pta_context(optee);
>
>         optee_remove_common(optee);
>
> @@ -1646,6 +1800,8 @@ static int optee_probe(struct platform_device *pdev=
)
>                                 irq_dispose_mapping(irq);
>                                 goto err_notif_uninit;
>                         }
> +
> +                       init_optee_pta_context(optee);
>                 }
>
>                 enable_async_notif(optee->smc.invoke_fn);
> @@ -1683,6 +1839,7 @@ static int optee_probe(struct platform_device *pdev=
)
>                 optee_disable_shm_cache(optee);
>         optee_smc_notif_uninit_irq(optee);
>         optee_unregister_devices();
> +       release_optee_pta_context(optee);
>  err_notif_uninit:
>         optee_notif_uninit(optee);
>  err_close_ctx:
> --
> 2.25.1
>
