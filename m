Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD922707A43
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 08:26:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229852AbjERG0P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 02:26:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230040AbjERG0G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 02:26:06 -0400
Received: from mail-ua1-x92e.google.com (mail-ua1-x92e.google.com [IPv6:2607:f8b0:4864:20::92e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 627301BDA
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 23:25:58 -0700 (PDT)
Received: by mail-ua1-x92e.google.com with SMTP id a1e0cc1a2514c-783fb1d02dcso427342241.3
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 23:25:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684391157; x=1686983157;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=cpdwrPzWFSoZRmhkO7li/gqDZJgI9foTK+ZOa6k6sXk=;
        b=mLC88ZrPZsFj5hNdT+sZrY+fzKKGfG8hODMaJytYtLYZMQ5osnu/ZOM81TlUvJ4o9i
         OOPrunz7e12TISTlgssElEMYQeAcYHRYTh0gNkSIe9hVI7YxZH127KbMuu1huJHBulIB
         8+jGtMFu9pRqyAIbmx4FV0yfkTJ0Vxjr20y6i9ff8AJFxL1JLVe/oVo3qBH7UfN6cNEM
         kmjWVCO8eJ+iJIYQbSMiglxRi5r1YtANmP44xq8/Yqky/zO6NLaZT6iTAfXk4lsuL7oc
         0XtMAvKz4meOGlAwR1lnC9/YZGJWdDLuDT1afsj5u3LcUqEwWfS/RWp63YXA9fqSmJQd
         tj5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684391157; x=1686983157;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cpdwrPzWFSoZRmhkO7li/gqDZJgI9foTK+ZOa6k6sXk=;
        b=c6IRXLgFhis4CbLujEOpTlp9SaWVtnD/V3qiNgXNH9ef+4NFBrMQHP+SOkCXru4h12
         tYIlpYO2/RYM5hLZiOmhnmWJ3VcsPYeeaJNQyD13X1Gm5h+Eeb3vq3la9T9v9jNT8Si4
         OEUuyHX0cY90IIZyhkNIPBKNbSbb/yU3iQovb1HIlDE82hQ3KH7z/+sx8GtZdjGad86M
         kWSfYHwljao6m6o2XBgfUvYQU4NTwD6buiSK0wNPFa1X5eVfdLLcszszEs289wUqGIuY
         f76KY3uQPkvxDJO8DNLUBTBfSjjbvX3Z+3/A1VUgt5CisBSkwjREmz3gwW79hGqiC3Lf
         0KOw==
X-Gm-Message-State: AC+VfDzA7qvxEQPqwBJkuUdNgpIXCUKcerv66juou+34kvwuDVt+0lOi
        2wSyBlR8AUEq936oeXkPr/aVTkiEwiWBoLd7VCgQVA==
X-Google-Smtp-Source: ACHHUZ5byD+i/d5u4cB/3S6rVSypSx5mH3/dp4sfNO/dpp+WbGLpnY/q4egXDisrw+pTkLuZ9xFXmtnOHT/xqcGP75M=
X-Received: by 2002:a67:ea45:0:b0:434:8632:e8ec with SMTP id
 r5-20020a67ea45000000b004348632e8ecmr182697vso.5.1684391157373; Wed, 17 May
 2023 23:25:57 -0700 (PDT)
MIME-Version: 1.0
References: <20230516125111.2690204-1-etienne.carriere@linaro.org> <20230516125111.2690204-4-etienne.carriere@linaro.org>
In-Reply-To: <20230516125111.2690204-4-etienne.carriere@linaro.org>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Thu, 18 May 2023 11:55:46 +0530
Message-ID: <CAFA6WYPYgWhY9hKGOq1HSE4QdHYpewOGTG6sYMWmVMaLakOGqA@mail.gmail.com>
Subject: Re: [PATCH v8 3/4] tee: optee: support tracking system threads
To:     Etienne Carriere <etienne.carriere@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        op-tee@lists.trustedfirmware.org,
        Jens Wiklander <jens.wiklander@linaro.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Cristian Marussi <cristian.marussi@arm.com>,
        Vincent Guittot <vincent.guittot@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 May 2023 at 18:24, Etienne Carriere
<etienne.carriere@linaro.org> wrote:
>
> Adds support in the OP-TEE driver to keep track of reserved system
> threads. The optee_cq_*() functions are updated to handle this if
> enabled. The SMC ABI part of the driver enables this tracking, but the
> FF-A ABI part does not.
>
> The call queue list optee_call_queue::waiters is replaced by 2 lists,
> one for regular sessions and one system sessions. The struct also
> stores count of TEE thread contexts provisioned/used/reserved to
> track use of TEE resources. The logic allows at most 1 OP-TEE entry
> can be reserved to TEE system sessions. For sake of simplicity,
> initialization of call queue management is factorized into new
> helper function optee_cq_init().
>
> Co-developed-by: Jens Wiklander <jens.wiklander@linaro.org>
> Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
> Signed-off-by: Etienne Carriere <etienne.carriere@linaro.org>
> ---
> Changes since v7:
> - Changes the logic to reserve at most 1 call entry for system sessions
>   as per patches v6 and v7 discussion threads (the 2 below bullets)
>   and updates commit message accordingly.
> - Field optee_call_queue::res_sys_thread_count is replaced with 2 fields:
>   sys_thread_req_count and boolean sys_thread_in_use.
> - Field optee_call_waiter::sys_thread is replaced with 2 fields:
>   sys_thread_req and sys_thread_used.
> - Adds inline description comments for struct optee_call_queue and
>   struct optee_call_waiter.
>

The implementation looks complex to me, see a simplified version [1]
of this patch.

[1] https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/thread/O4T3LI37GVBPW4MMVFLSM4EKTLHJNEJE/

-Sumit

> Changes since v6:
> - Moved out changes related to adding boolean system thread attribute
>   into optee driver call queue and SMC/FF-A ABIs API functions. These
>   changes were squashed into patch 1/4 of this patch v7 series.
> - Comment about adding a specific commit for call queue refactoring
>   was not addressed such a patch would only introduce function
>   optee_cq_init()  with very little content in (mutex & list init).
> - Added Co-developed-by tag for Jens contribution as he's not responsible
>   for the changes I made in this patch v7.
>
> No change since v5
>
> Changes since v4:
> - New change that supersedes implementation proposed in PATCH v4
>   (tee: system invocation"). Thanks to Jens implementation we don't need
>   the new OP-TEE services that my previous patch versions introduced to
>   monitor system threads entry. Now, Linux optee SMC ABI driver gets TEE
>   provisioned thread contexts count once and monitors thread entries in
>   OP-TEE on that basis and the system thread capability of the related
>   tee session. By the way, I dropped the WARN_ONCE() call I suggested
>   on tee thread exhaustion as it does not provides useful information.
> ---
>  drivers/tee/optee/call.c          | 131 ++++++++++++++++++++++++++++--
>  drivers/tee/optee/ffa_abi.c       |   3 +-
>  drivers/tee/optee/optee_private.h |  30 ++++++-
>  drivers/tee/optee/smc_abi.c       |  16 +++-
>  4 files changed, 167 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/tee/optee/call.c b/drivers/tee/optee/call.c
> index 152ae9bb1785..7aec64f0f7e0 100644
> --- a/drivers/tee/optee/call.c
> +++ b/drivers/tee/optee/call.c
> @@ -39,9 +39,28 @@ struct optee_shm_arg_entry {
>         DECLARE_BITMAP(map, MAX_ARG_COUNT_PER_ENTRY);
>  };
>
> +void optee_cq_init(struct optee_call_queue *cq, int thread_count)
> +{
> +       mutex_init(&cq->mutex);
> +       INIT_LIST_HEAD(&cq->normal_waiters);
> +       INIT_LIST_HEAD(&cq->sys_waiters);
> +       /*
> +        * If cq->total_thread_count is 0 then we're not trying to keep
> +        * track of how many free threads we have, instead we're relying on
> +        * the secure world to tell us when we're out of thread and have to
> +        * wait for another thread to become available.
> +        */
> +       cq->total_thread_count = thread_count;
> +       cq->free_normal_thread_count = thread_count;
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
> @@ -53,15 +72,46 @@ void optee_cq_wait_init(struct optee_call_queue *cq,
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
> -       list_add_tail(&w->list_node, &cq->waiters);
> +       w->sys_thread_req = sys_thread;
> +       if (sys_thread) {
> +               list_add_tail(&w->list_node, &cq->sys_waiters);
> +               if (cq->sys_thread_in_use) {
> +                       need_wait = true;
> +               } else {
> +                       cq->sys_thread_in_use = true;
> +                       w->sys_thread_used = true;
> +               }
> +       } else {
> +               list_add_tail(&w->list_node, &cq->normal_waiters);
> +               if (cq->total_thread_count) {
> +                       /*
> +                        * Claim a normal thread if one is available, else
> +                        * we'll need to wait for a normal thread to be
> +                        * released.
> +                        */
> +                       if (cq->free_normal_thread_count > 0)
> +                               cq->free_normal_thread_count--;
> +                       else
> +                               need_wait = true;
> +               }
> +       }
>
>         mutex_unlock(&cq->mutex);
> +
> +       while (need_wait) {
> +               optee_cq_wait_for_completion(cq, w);
> +               mutex_lock(&cq->mutex);
> +               if (cq->free_normal_thread_count > 0) {
> +                       cq->free_normal_thread_count--;
> +                       need_wait = false;
> +               }
> +               mutex_unlock(&cq->mutex);
> +       }
>  }
>
>  void optee_cq_wait_for_completion(struct optee_call_queue *cq,
> @@ -74,7 +124,10 @@ void optee_cq_wait_for_completion(struct optee_call_queue *cq,
>         /* Move to end of list to get out of the way for other waiters */
>         list_del(&w->list_node);
>         reinit_completion(&w->c);
> -       list_add_tail(&w->list_node, &cq->waiters);
> +       if (w->sys_thread_req)
> +               list_add_tail(&w->list_node, &cq->sys_waiters);
> +       else
> +               list_add_tail(&w->list_node, &cq->normal_waiters);
>
>         mutex_unlock(&cq->mutex);
>  }
> @@ -83,10 +136,19 @@ static void optee_cq_complete_one(struct optee_call_queue *cq)
>  {
>         struct optee_call_waiter *w;
>
> -       list_for_each_entry(w, &cq->waiters, list_node) {
> +       list_for_each_entry(w, &cq->sys_waiters, list_node) {
>                 if (!completion_done(&w->c)) {
>                         complete(&w->c);
> -                       break;
> +                       return;
> +               }
> +       }
> +
> +       if (!cq->total_thread_count || cq->free_normal_thread_count > 0) {
> +               list_for_each_entry(w, &cq->normal_waiters, list_node) {
> +                       if (!completion_done(&w->c)) {
> +                               complete(&w->c);
> +                               break;
> +                       }
>                 }
>         }
>  }
> @@ -104,6 +166,11 @@ void optee_cq_wait_final(struct optee_call_queue *cq,
>         /* Get out of the list */
>         list_del(&w->list_node);
>
> +       if (w->sys_thread_used)
> +               cq->sys_thread_in_use = false;
> +       else
> +               cq->free_normal_thread_count++; /* Release a normal thread */
> +
>         /* Wake up one eventual waiting task */
>         optee_cq_complete_one(cq);
>
> @@ -119,6 +186,31 @@ void optee_cq_wait_final(struct optee_call_queue *cq,
>         mutex_unlock(&cq->mutex);
>  }
>
> +bool optee_cq_inc_sys_thread_count(struct optee_call_queue *cq)
> +{
> +       if (cq->total_thread_count <= 1)
> +               return false;
> +
> +       mutex_lock(&cq->mutex);
> +       if (!cq->sys_thread_req_count)
> +               cq->free_normal_thread_count--;
> +       cq->sys_thread_req_count++;
> +       mutex_unlock(&cq->mutex);
> +
> +       return true;
> +}
> +
> +void optee_cq_dec_sys_thread_count(struct optee_call_queue *cq)
> +{
> +       mutex_lock(&cq->mutex);
> +       cq->sys_thread_req_count--;
> +       if (!cq->sys_thread_req_count)
> +               cq->free_normal_thread_count++;
> +       /* If there's someone waiting, let it resume */
> +       optee_cq_complete_one(cq);
> +       mutex_unlock(&cq->mutex);
> +}
> +
>  /* Requires the filpstate mutex to be held */
>  static struct optee_session *find_session(struct optee_context_data *ctxdata,
>                                           u32 session_id)
> @@ -361,6 +453,27 @@ int optee_open_session(struct tee_context *ctx,
>         return rc;
>  }
>
> +int optee_system_session(struct tee_context *ctx, u32 session)
> +{
> +       struct optee_context_data *ctxdata = ctx->data;
> +       struct optee *optee = tee_get_drvdata(ctx->teedev);
> +       struct optee_session *sess;
> +       int rc = -EINVAL;
> +
> +       mutex_lock(&ctxdata->mutex);
> +
> +       sess = find_session(ctxdata, session);
> +       if (sess && !sess->use_sys_thread &&
> +           optee_cq_inc_sys_thread_count(&optee->call_queue)) {
> +               rc = 0;
> +               sess->use_sys_thread = true;
> +       }
> +
> +       mutex_unlock(&ctxdata->mutex);
> +
> +       return rc;
> +}
> +
>  int optee_close_session_helper(struct tee_context *ctx, u32 session,
>                                bool system_thread)
>  {
> @@ -378,6 +491,8 @@ int optee_close_session_helper(struct tee_context *ctx, u32 session,
>         msg_arg->session = session;
>         optee->ops->do_call_with_arg(ctx, shm, offs, system_thread);
>
> +       if (system_thread)
> +               optee_cq_dec_sys_thread_count(&optee->call_queue);
>         optee_free_msg_arg(ctx, entry, offs);
>
>         return 0;
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
> index b68273051454..b8f22d7b34a6 100644
> --- a/drivers/tee/optee/optee_private.h
> +++ b/drivers/tee/optee/optee_private.h
> @@ -40,15 +40,39 @@ typedef void (optee_invoke_fn)(unsigned long, unsigned long, unsigned long,
>                                 unsigned long, unsigned long,
>                                 struct arm_smccc_res *);
>
> +/*
> + * struct optee_call_waiter - TEE entry may need to wait for a free TEE thread
> + * @list_node          Reference in waiters list
> + * @c                  Waiting completion reference
> + * @sys_thread_req     True only if waiter belongs to a requested system thread
> + * @sys_thread_used    True only if waiter is consuming the system thread
> + */
>  struct optee_call_waiter {
>         struct list_head list_node;
>         struct completion c;
> +       bool sys_thread_req;
> +       bool sys_thread_used;
>  };
>
> +/*
> + * struct optee_call_queue - OP-TEE call queue management
> + * @mutex                      Serializes access to this struct
> + * @normal_waiters             List of normal threads waiting to enter OP-TEE
> + * @sys_waiters                        List of system threads waiting to enter OP-TEE
> + * @total_thread_count         Overall number of thread context in OP-TEE or 0
> + * @free_normal_thread_count   Number of normal threads context free in OP-TEE
> + * @sys_thread_req_count       Number of registered system thread requests
> + * @sys_thread_in_use          True only if reserved system entry is consumed
> + */
>  struct optee_call_queue {
>         /* Serializes access to this struct */
>         struct mutex mutex;
> -       struct list_head waiters;
> +       struct list_head normal_waiters;
> +       struct list_head sys_waiters;
> +       int total_thread_count;
> +       int free_normal_thread_count;
> +       int sys_thread_req_count;
> +       bool sys_thread_in_use;
>  };
>
>  struct optee_notif {
> @@ -254,6 +278,7 @@ int optee_supp_send(struct tee_context *ctx, u32 ret, u32 num_params,
>  int optee_open_session(struct tee_context *ctx,
>                        struct tee_ioctl_open_session_arg *arg,
>                        struct tee_param *param);
> +int optee_system_session(struct tee_context *ctx, u32 session);
>  int optee_close_session_helper(struct tee_context *ctx, u32 session,
>                                bool system_thread);
>  int optee_close_session(struct tee_context *ctx, u32 session);
> @@ -303,6 +328,9 @@ static inline void optee_to_msg_param_value(struct optee_msg_param *mp,
>         mp->u.value.c = p->u.value.c;
>  }
>
> +void optee_cq_init(struct optee_call_queue *cq, int thread_count);
> +bool optee_cq_inc_sys_thread_count(struct optee_call_queue *cq);
> +void optee_cq_dec_sys_thread_count(struct optee_call_queue *cq);
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
> 2.25.1
>
