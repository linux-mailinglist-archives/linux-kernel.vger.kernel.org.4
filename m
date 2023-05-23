Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2696870D494
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 09:12:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235341AbjEWHLv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 03:11:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232326AbjEWHLt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 03:11:49 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC67811A
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 00:11:46 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-510eb3dbaaeso925863a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 00:11:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684825905; x=1687417905;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=LiK1Nuqo3o2646Zkl3M6Ui0oCHg/IKOGD9WlbrrSQLc=;
        b=CZEDzOLy6N0HZlFRdU7/8vJN9xrcUkZvPG9F1t6iZI5fj/9+qY4HcKpQ2XVG+os9su
         zY4jEwM5BaN8cQMwoh+wj5LZz3G/6y2q7lQQiN3Cc6XjZmGq2dfdAdMjY5TdRzvwB1eA
         EizSfWWvlV+OV7eKHWaTZQnCxkP7XmStgS+WZHQjirGxb+9cWg02UsakUIGToC6AQ8jL
         IVdeuA+Nag7c11zHyBN8AJeXTvVBBl15HXRMATU4HefG+BiRFMMWBDhz9KBcB0pHV2EK
         3WpHepTsEJtwHHANL+hNMn6ACXdVhyMQFyJF8g4bk9/vOMrz28IBKCm8BdNCwJvuaNy1
         rz4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684825905; x=1687417905;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LiK1Nuqo3o2646Zkl3M6Ui0oCHg/IKOGD9WlbrrSQLc=;
        b=FvtURPCBGRfY2jSilACgVLm6+vPIBLizrJaJMo4FSkZZfQHGVwX/CXR6bxECRlNstk
         3ZDHlaUIKww5/lPmUIFUIX6+hBJDBu1BMh/gjyxli6N7LslY0gIUXGUC239lYKLQlQY2
         +66HnMetv529Z67/N7Ch720iXwhmOTrGeqSMGeAgUZsvA3cAG13NeLDayUGyqdMzKUtY
         FvfOmZR3bMuxlBt9f1JwmIaJC6+5EycD0q/nsoTc3iqkNmFRvOaFoC02N+y9Uu1MhVxT
         WSm7XmA3nIiJCe+l6kNI8pQa7Au+hVDf7cxxLm72DBEiiH8dRSokoBd0T1L77SXPewJA
         WwoA==
X-Gm-Message-State: AC+VfDzTLuyt2ptZt3gkOS0ZhrgVq4rDePEfKL7+Rd+uqX+PpNNeavZo
        r/I1rYhQxHoDs4djk84tTH3cthYRB5DBCgTk6IQIHg==
X-Google-Smtp-Source: ACHHUZ71ywLZAAhcukfOMjOPJpYp4je7yn4L+6o6C4jGd4et/jP62EyvdYi2fVmq6FVSpK4ECjBYBPA68BcNQS4cxUI=
X-Received: by 2002:aa7:c74c:0:b0:510:e756:3a1e with SMTP id
 c12-20020aa7c74c000000b00510e7563a1emr9156267eds.11.1684825905300; Tue, 23
 May 2023 00:11:45 -0700 (PDT)
MIME-Version: 1.0
References: <20230517143311.585080-1-sumit.garg@linaro.org>
In-Reply-To: <20230517143311.585080-1-sumit.garg@linaro.org>
From:   Etienne Carriere <etienne.carriere@linaro.org>
Date:   Tue, 23 May 2023 09:11:34 +0200
Message-ID: <CAN5uoS9h6OmO-SZWmBdRUkT+ih9QK+mTo8Kvmn3ePQ4NrKriBw@mail.gmail.com>
Subject: Re: [PATCH v9 3/4] tee: optee: support tracking system threads
To:     Sumit Garg <sumit.garg@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        op-tee@lists.trustedfirmware.org, jens.wiklander@linaro.org,
        sudeep.holla@arm.com, cristian.marussi@arm.com,
        vincent.guittot@linaro.org,
        etienne carriere <Etienne.carriere@st.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Sumit,


On Wed, 17 May 2023 at 16:33, Sumit Garg <sumit.garg@linaro.org> wrote:
>
> From: Etienne Carriere <etienne.carriere@linaro.org>
>
> Adds support in the OP-TEE driver to keep track of reserved system
> threads. The optee_cq_*() functions are updated to handle this if
> enabled. The SMC ABI part of the driver enables this tracking, but the
> FF-A ABI part does not.
>
> The logic allows atleast 1 OP-TEE thread can be reserved to TEE system
> sessions. For sake of simplicity, initialization of call queue
> management is factorized into new helper function optee_cq_init().
>
> Co-developed-by: Jens Wiklander <jens.wiklander@linaro.org>
> Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
> Signed-off-by: Etienne Carriere <etienne.carriere@linaro.org>
> Co-developed-by: Sumit Garg <sumit.garg@linaro.org>
> Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
> ---
>
> Disclaimer: Compile tested only
>
> Hi Etienne,
>
> Overall the idea we agreed upon was okay but the implementation looked
> complex to me. So I thought it would be harder to explain that via
> review and I decided myself to give a try at simplification. I would
> like you to test it if this still addresses the SCMI deadlock problem or
> not. Also, feel free to include this in your patchset if all goes fine
> wrt testing.

With these changes, there is no more a specific waiting list for TEE
system threads hence when a waiting queue can complete, we'll pick any
TEE thread, not a TEE system thread first..
Also, as stated in a below answer, these change unconditionally
reserve a TEE thread for TEE system calls even if no TEE client
reserved such.

>
> -Sumit
>
> Changes since v8:
> - Simplified system threads tracking implementation.
>
>  drivers/tee/optee/call.c          | 72 +++++++++++++++++++++++++++++--
>  drivers/tee/optee/ffa_abi.c       |  3 +-
>  drivers/tee/optee/optee_private.h | 16 +++++++
>  drivers/tee/optee/smc_abi.c       | 16 ++++++-
>  4 files changed, 99 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/tee/optee/call.c b/drivers/tee/optee/call.c
> index 42e478ac6ce1..09e824e4dcaf 100644
> --- a/drivers/tee/optee/call.c
> +++ b/drivers/tee/optee/call.c
> @@ -39,9 +39,27 @@ struct optee_shm_arg_entry {
>         DECLARE_BITMAP(map, MAX_ARG_COUNT_PER_ENTRY);
>  };
>
> +void optee_cq_init(struct optee_call_queue *cq, int thread_count)
> +{
> +       mutex_init(&cq->mutex);
> +       INIT_LIST_HEAD(&cq->waiters);
> +       /*
> +        * If cq->total_thread_count is 0 then we're not trying to keep
> +        * track of how many free threads we have, instead we're relying on
> +        * the secure world to tell us when we're out of thread and have to
> +        * wait for another thread to become available.
> +        */
> +       cq->total_thread_count = thread_count;
> +       cq->free_thread_count = thread_count;
> +}
> +
>  void optee_cq_wait_init(struct optee_call_queue *cq,
>                         struct optee_call_waiter *w, bool sys_thread)
>  {
> +       bool need_wait = false;
> +
> +       memset(w, 0, sizeof(*w));
> +
>         /*
>          * We're preparing to make a call to secure world. In case we can't
>          * allocate a thread in secure world we'll end up waiting in
> @@ -53,15 +71,43 @@ void optee_cq_wait_init(struct optee_call_queue *cq,
>         mutex_lock(&cq->mutex);
>
>         /*
> -        * We add ourselves to the queue, but we don't wait. This
> -        * guarantees that we don't lose a completion if secure world
> -        * returns busy and another thread just exited and try to complete
> -        * someone.
> +        * We add ourselves to a queue, but we don't wait. This guarantees
> +        * that we don't lose a completion if secure world returns busy and
> +        * another thread just exited and try to complete someone.
>          */
>         init_completion(&w->c);
>         list_add_tail(&w->list_node, &cq->waiters);
>
> +       if (cq->total_thread_count && sys_thread) {
> +               if (cq->free_thread_count > 0)
> +                       cq->free_thread_count--;
> +               else
> +                       need_wait = true;
> +       } else if (cq->total_thread_count) {
> +               if (cq->free_thread_count > 1)

This unconditionally reserves a TEE thread for TEE system calls, even
if no client has claimed such system thread reservation.


> +                       cq->free_thread_count--;
> +               else
> +                       need_wait = true;
> +       }
> +
>         mutex_unlock(&cq->mutex);
> +
> +       while (need_wait) {
> +               optee_cq_wait_for_completion(cq, w);
> +               mutex_lock(&cq->mutex);
> +               if (sys_thread) {
> +                       if (cq->free_thread_count > 0) {
> +                               cq->free_thread_count--;
> +                               need_wait = false;
> +                       }
> +               } else {
> +                       if (cq->free_thread_count > 1) {
> +                               cq->free_thread_count--;
> +                               need_wait = false;
> +                       }
> +               }
> +               mutex_unlock(&cq->mutex);
> +       }
>  }
>
>  void optee_cq_wait_for_completion(struct optee_call_queue *cq,
> @@ -104,6 +150,8 @@ void optee_cq_wait_final(struct optee_call_queue *cq,
>         /* Get out of the list */
>         list_del(&w->list_node);
>
> +       cq->free_thread_count++;
> +
>         /* Wake up one eventual waiting task */
>         optee_cq_complete_one(cq);
>
> @@ -361,6 +409,22 @@ int optee_open_session(struct tee_context *ctx,
>         return rc;
>  }
>
> +int optee_system_session(struct tee_context *ctx, u32 session)
> +{
> +       struct optee_context_data *ctxdata = ctx->data;
> +       struct optee_session *sess;
> +
> +       mutex_lock(&ctxdata->mutex);
> +
> +       sess = find_session(ctxdata, session);
> +       if (sess && !sess->use_sys_thread)
> +               sess->use_sys_thread = true;
> +
> +       mutex_unlock(&ctxdata->mutex);
> +
> +       return 0;

Nitpicking: should rather return 0 only upon session is valid
(sess!=NULL here)  and system thread reservation is supported
(total_thread_count > 0).
But that's not a big deal I guess, can be addressed.

Etienne




> +}
> +
>  int optee_close_session_helper(struct tee_context *ctx, u32 session,
>                                bool system_thread)
>  {
> diff --git a/drivers/tee/optee/ffa_abi.c b/drivers/tee/optee/ffa_abi.c
> index 5fde9d4100e3..0c9055691343 100644
> --- a/drivers/tee/optee/ffa_abi.c
> +++ b/drivers/tee/optee/ffa_abi.c
> @@ -852,8 +852,7 @@ static int optee_ffa_probe(struct ffa_device *ffa_dev)
>         if (rc)
>                 goto err_unreg_supp_teedev;
>         mutex_init(&optee->ffa.mutex);
> -       mutex_init(&optee->call_queue.mutex);
> -       INIT_LIST_HEAD(&optee->call_queue.waiters);
> +       optee_cq_init(&optee->call_queue, 0);
>         optee_supp_init(&optee->supp);
>         optee_shm_arg_cache_init(optee, arg_cache_flags);
>         ffa_dev_set_drvdata(ffa_dev, optee);
> diff --git a/drivers/tee/optee/optee_private.h b/drivers/tee/optee/optee_private.h
> index b68273051454..6dcecb83c893 100644
> --- a/drivers/tee/optee/optee_private.h
> +++ b/drivers/tee/optee/optee_private.h
> @@ -40,15 +40,29 @@ typedef void (optee_invoke_fn)(unsigned long, unsigned long, unsigned long,
>                                 unsigned long, unsigned long,
>                                 struct arm_smccc_res *);
>
> +/*
> + * struct optee_call_waiter - TEE entry may need to wait for a free TEE thread
> + * @list_node          Reference in waiters list
> + * @c                  Waiting completion reference
> + */
>  struct optee_call_waiter {
>         struct list_head list_node;
>         struct completion c;
>  };
>
> +/*
> + * struct optee_call_queue - OP-TEE call queue management
> + * @mutex                      Serializes access to this struct
> + * @waiters                    List of threads waiting to enter OP-TEE
> + * @total_thread_count         Overall number of thread context in OP-TEE or 0
> + * @free_thread_count          Number of threads context free in OP-TEE
> + */
>  struct optee_call_queue {
>         /* Serializes access to this struct */
>         struct mutex mutex;
>         struct list_head waiters;
> +       int total_thread_count;
> +       int free_thread_count;
>  };
>
>  struct optee_notif {
> @@ -254,6 +268,7 @@ int optee_supp_send(struct tee_context *ctx, u32 ret, u32 num_params,
>  int optee_open_session(struct tee_context *ctx,
>                        struct tee_ioctl_open_session_arg *arg,
>                        struct tee_param *param);
> +int optee_system_session(struct tee_context *ctx, u32 session);
>  int optee_close_session_helper(struct tee_context *ctx, u32 session,
>                                bool system_thread);
>  int optee_close_session(struct tee_context *ctx, u32 session);
> @@ -303,6 +318,7 @@ static inline void optee_to_msg_param_value(struct optee_msg_param *mp,
>         mp->u.value.c = p->u.value.c;
>  }
>
> +void optee_cq_init(struct optee_call_queue *cq, int thread_count);
>  void optee_cq_wait_init(struct optee_call_queue *cq,
>                         struct optee_call_waiter *w, bool sys_thread);
>  void optee_cq_wait_for_completion(struct optee_call_queue *cq,
> diff --git a/drivers/tee/optee/smc_abi.c b/drivers/tee/optee/smc_abi.c
> index e2763cdcf111..3314ffeb91c8 100644
> --- a/drivers/tee/optee/smc_abi.c
> +++ b/drivers/tee/optee/smc_abi.c
> @@ -1209,6 +1209,7 @@ static const struct tee_driver_ops optee_clnt_ops = {
>         .release = optee_release,
>         .open_session = optee_open_session,
>         .close_session = optee_close_session,
> +       .system_session = optee_system_session,
>         .invoke_func = optee_invoke_func,
>         .cancel_req = optee_cancel_req,
>         .shm_register = optee_shm_register,
> @@ -1356,6 +1357,16 @@ static bool optee_msg_exchange_capabilities(optee_invoke_fn *invoke_fn,
>         return true;
>  }
>
> +static unsigned int optee_msg_get_thread_count(optee_invoke_fn *invoke_fn)
> +{
> +       struct arm_smccc_res res;
> +
> +       invoke_fn(OPTEE_SMC_GET_THREAD_COUNT, 0, 0, 0, 0, 0, 0, 0, &res);
> +       if (res.a0)
> +               return 0;
> +       return res.a1;
> +}
> +
>  static struct tee_shm_pool *
>  optee_config_shm_memremap(optee_invoke_fn *invoke_fn, void **memremaped_shm)
>  {
> @@ -1609,6 +1620,7 @@ static int optee_probe(struct platform_device *pdev)
>         struct optee *optee = NULL;
>         void *memremaped_shm = NULL;
>         unsigned int rpc_param_count;
> +       unsigned int thread_count;
>         struct tee_device *teedev;
>         struct tee_context *ctx;
>         u32 max_notif_value;
> @@ -1636,6 +1648,7 @@ static int optee_probe(struct platform_device *pdev)
>                 return -EINVAL;
>         }
>
> +       thread_count = optee_msg_get_thread_count(invoke_fn);
>         if (!optee_msg_exchange_capabilities(invoke_fn, &sec_caps,
>                                              &max_notif_value,
>                                              &rpc_param_count)) {
> @@ -1725,8 +1738,7 @@ static int optee_probe(struct platform_device *pdev)
>         if (rc)
>                 goto err_unreg_supp_teedev;
>
> -       mutex_init(&optee->call_queue.mutex);
> -       INIT_LIST_HEAD(&optee->call_queue.waiters);
> +       optee_cq_init(&optee->call_queue, thread_count);
>         optee_supp_init(&optee->supp);
>         optee->smc.memremaped_shm = memremaped_shm;
>         optee->pool = pool;
> --
> 2.34.1
>
