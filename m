Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB7756FDB57
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 12:09:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236411AbjEJKJE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 06:09:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236404AbjEJKJA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 06:09:00 -0400
Received: from mail-vs1-xe33.google.com (mail-vs1-xe33.google.com [IPv6:2607:f8b0:4864:20::e33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2B9B2116
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 03:08:57 -0700 (PDT)
Received: by mail-vs1-xe33.google.com with SMTP id ada2fe7eead31-436175b038fso494602137.3
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 03:08:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683713336; x=1686305336;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+AGafdssGIIrcUwasbkv+OIk+7sv9JEMpWfrECLjPro=;
        b=c+ndQyz0WLIqBAn6kxhPH3Tr/H4kAIZzdmLl2glPwwXTkYrlIYwC/hgbvhVQyUvHYk
         RVc0qZRfHnn4Jt62ZpuGQRHK7p4MRrL0llDbMk+/aEzRH/8eHf+J+cZx1DPmtiYZdCr4
         HNZlCS+wP58NlRGb5d2vE2ftBWHRoU85UarArkf4lpl0P2vl3wfGDTtf34rXTgWd1get
         ZvCBA6cQzOzPioA8sGEQXNXQS5obaiKCXQQGDVe+slHJ16+JaCrXrU4/VgJR/DR3WcLb
         JggNgR8c/DgMSutJEYl5yFjojP4jsW9icnaJvE/WIqukC0E6doScf16yAY8k7t5giUKQ
         PFWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683713336; x=1686305336;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+AGafdssGIIrcUwasbkv+OIk+7sv9JEMpWfrECLjPro=;
        b=dYz0/PZ5cfCvmN4OslikLPhdZUR7ldlSa2k20NtDM//8rpSNLNIP+d8mBZ00rFSuNK
         9v7jE8uMiKjL4nF48/a921XrXk40ijCOMomnKAaKWIX3TQMicc27nZi6rS5q/aNdFfNd
         qp8a6QXh8wAnBNxhfswQOYYz3u6ERGhjSshkncliuTpzdqXO7yQq2Id3bvCaeNI1E/EP
         AwgmS3zNb8rFFreJUJpGSFIti6FwpbKh8AFP/XHxvtVzyHP9xJPWAMex0gVYRF8wwoCS
         h0IF6ggRrpmWGX3rbxmAn/J0jMYO/VAKAscxcI+Jsw7+OUSkbcWN6C+kJcNcGh8YyC6D
         3wkg==
X-Gm-Message-State: AC+VfDzbKdnMUIVgya1ZnVsciIoVS1ZwvpBLWbYepEjOTlP2oVm95HUE
        cxS+j89kMjPwRbZmp0nLjzPtfxNDxH7PjcauVUX4yg==
X-Google-Smtp-Source: ACHHUZ50RN3MxoEC6hpxs0S6ITv1lvDtsThgkVcf50uaHL1NrnygFEB9UfWcyGCuP7ynWh0EqMjKk8zaEsxRTM8nRA8=
X-Received: by 2002:a67:f699:0:b0:434:7434:986c with SMTP id
 n25-20020a67f699000000b004347434986cmr5546905vso.11.1683713336519; Wed, 10
 May 2023 03:08:56 -0700 (PDT)
MIME-Version: 1.0
References: <20230505173012.881083-1-etienne.carriere@linaro.org> <20230505173012.881083-3-etienne.carriere@linaro.org>
In-Reply-To: <20230505173012.881083-3-etienne.carriere@linaro.org>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Wed, 10 May 2023 15:38:45 +0530
Message-ID: <CAFA6WYN4yjjedmsS4nAgR5L7OOTRAcKs7STW0YjCC7XsdfYzkA@mail.gmail.com>
Subject: Re: [PATCH v6 3/4] tee: optee: support tracking system threads
To:     Etienne Carriere <etienne.carriere@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        op-tee@lists.trustedfirmware.org,
        Jens Wiklander <jens.wiklander@linaro.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Cristian Marussi <cristian.marussi@arm.com>
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

On Fri, 5 May 2023 at 23:01, Etienne Carriere
<etienne.carriere@linaro.org> wrote:
>
> From: Jens Wiklander <jens.wiklander@linaro.org>
>
> Adds support in the OP-TEE driver to keep track of reserved system
> threads. The optee_cq_*() functions are updated to handle this if
> enabled. The SMC ABI part of the driver enables this tracking, but the
> FF-A ABI part does not.

OP-TEE system threads sound like a core feature towards OP-TEE. If we
enable it only for SMC ABI then it is likely to break kernel drivers
who migrate to FFA ABI. Also, looking from implementation point of
view it shouldn't be that hard to enable it for FFA ABI too.

>
> Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
> Signed-off-by: Etienne Carriere <etienne.carriere@linaro.org>
> ---
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
>  drivers/tee/optee/call.c          | 128 +++++++++++++++++++++++++++---
>  drivers/tee/optee/ffa_abi.c       |  10 +--
>  drivers/tee/optee/optee_private.h |  13 ++-
>  drivers/tee/optee/smc_abi.c       |  24 ++++--
>  4 files changed, 154 insertions(+), 21 deletions(-)
>
> diff --git a/drivers/tee/optee/call.c b/drivers/tee/optee/call.c
> index dba5339b61ae..c2d484201f79 100644
> --- a/drivers/tee/optee/call.c
> +++ b/drivers/tee/optee/call.c
> @@ -39,9 +39,26 @@ struct optee_shm_arg_entry {
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
> -                       struct optee_call_waiter *w)
> +                       struct optee_call_waiter *w, bool sys_thread)

Introduction of system_thread property should be part of patch #1.

>  {
> +       bool need_wait = false;
> +
>         /*
>          * We're preparing to make a call to secure world. In case we can't
>          * allocate a thread in secure world we'll end up waiting in
> @@ -53,15 +70,40 @@ void optee_cq_wait_init(struct optee_call_queue *cq,
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
> +       w->sys_thread = sys_thread;
> +       if (sys_thread) {
> +               list_add_tail(&w->list_node, &cq->sys_waiters);
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
> @@ -74,7 +116,10 @@ void optee_cq_wait_for_completion(struct optee_call_queue *cq,
>         /* Move to end of list to get out of the way for other waiters */
>         list_del(&w->list_node);
>         reinit_completion(&w->c);
> -       list_add_tail(&w->list_node, &cq->waiters);
> +       if (w->sys_thread)
> +               list_add_tail(&w->list_node, &cq->sys_waiters);
> +       else
> +               list_add_tail(&w->list_node, &cq->normal_waiters);
>
>         mutex_unlock(&cq->mutex);
>  }
> @@ -83,10 +128,19 @@ static void optee_cq_complete_one(struct optee_call_queue *cq)
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
> @@ -104,6 +158,9 @@ void optee_cq_wait_final(struct optee_call_queue *cq,
>         /* Get out of the list */
>         list_del(&w->list_node);
>
> +       if (!w->sys_thread)
> +               cq->free_normal_thread_count++; /* Release a normal thread */
> +
>         /* Wake up one eventual waiting task */
>         optee_cq_complete_one(cq);
>
> @@ -119,6 +176,36 @@ void optee_cq_wait_final(struct optee_call_queue *cq,
>         mutex_unlock(&cq->mutex);
>  }
>
> +bool optee_cq_inc_sys_thread_count(struct optee_call_queue *cq)
> +{
> +       bool rc = false;
> +
> +       mutex_lock(&cq->mutex);
> +
> +       /* Leave at least 1 normal (non-system) thread */

IMO, this might be counter productive. As most kernel drivers open a
session during driver probe which are only released in the driver
release method. If the kernel driver is built-in then the session is
never released. Now with system threads we would reserve an OP-TEE
thread for that kernel driver as well which will never be available to
regular user-space clients. So I would rather suggest we only allow a
single system thread to be reserved as a starting point which is
relevant to this critical SCMI service. We can also make this upper
bound for system threads configurable with default value as 1 if
needed.

> +       if (cq->res_sys_thread_count + 1 < cq->total_thread_count) {
> +               cq->free_normal_thread_count--;
> +               cq->res_sys_thread_count++;
> +               rc = true;
> +       }
> +
> +       mutex_unlock(&cq->mutex);
> +
> +       return rc;
> +}
> +
> +void optee_cq_dec_sys_thread_count(struct optee_call_queue *cq)
> +{
> +       mutex_lock(&cq->mutex);
> +       if (cq->res_sys_thread_count > 0) {
> +               cq->res_sys_thread_count--;
> +               cq->free_normal_thread_count++;
> +               /* If there's someone waiting, let it resume */
> +               optee_cq_complete_one(cq);
> +       }
> +       mutex_unlock(&cq->mutex);
> +}
> +
>  /* Requires the filpstate mutex to be held */
>  static struct optee_session *find_session(struct optee_context_data *ctxdata,
>                                           u32 session_id)
> @@ -361,6 +448,27 @@ int optee_open_session(struct tee_context *ctx,
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
> @@ -378,6 +486,8 @@ int optee_close_session_helper(struct tee_context *ctx, u32 session,
>         msg_arg->session = session;
>         optee->ops->do_call_with_arg(ctx, shm, offs, system_thread);
>
> +       if (system_thread)
> +               optee_cq_dec_sys_thread_count(&optee->call_queue);
>         optee_free_msg_arg(ctx, entry, offs);
>
>         return 0;
> diff --git a/drivers/tee/optee/ffa_abi.c b/drivers/tee/optee/ffa_abi.c
> index 52cec9d06041..0c9055691343 100644
> --- a/drivers/tee/optee/ffa_abi.c
> +++ b/drivers/tee/optee/ffa_abi.c
> @@ -528,7 +528,8 @@ static void optee_handle_ffa_rpc(struct tee_context *ctx, struct optee *optee,
>
>  static int optee_ffa_yielding_call(struct tee_context *ctx,
>                                    struct ffa_send_direct_data *data,
> -                                  struct optee_msg_arg *rpc_arg)
> +                                  struct optee_msg_arg *rpc_arg,
> +                                  bool system_thread)
>  {
>         struct optee *optee = tee_get_drvdata(ctx->teedev);
>         struct ffa_device *ffa_dev = optee->ffa.ffa_dev;
> @@ -541,7 +542,7 @@ static int optee_ffa_yielding_call(struct tee_context *ctx,
>         int rc;
>
>         /* Initialize waiter */
> -       optee_cq_wait_init(&optee->call_queue, &w);
> +       optee_cq_wait_init(&optee->call_queue, &w, system_thread);
>         while (true) {
>                 rc = msg_ops->sync_send_receive(ffa_dev, data);
>                 if (rc)
> @@ -643,7 +644,7 @@ static int optee_ffa_do_call_with_arg(struct tee_context *ctx,
>         if (IS_ERR(rpc_arg))
>                 return PTR_ERR(rpc_arg);
>
> -       return optee_ffa_yielding_call(ctx, &data, rpc_arg);
> +       return optee_ffa_yielding_call(ctx, &data, rpc_arg, system_thread);
>  }

Introduction of system_thread property should be part of patch #1.

>
>  /*
> @@ -851,8 +852,7 @@ static int optee_ffa_probe(struct ffa_device *ffa_dev)
>         if (rc)
>                 goto err_unreg_supp_teedev;
>         mutex_init(&optee->ffa.mutex);
> -       mutex_init(&optee->call_queue.mutex);
> -       INIT_LIST_HEAD(&optee->call_queue.waiters);
> +       optee_cq_init(&optee->call_queue, 0);

This looks like some refactoring going on which should be part of a
separate patch to ease the review process.

>         optee_supp_init(&optee->supp);
>         optee_shm_arg_cache_init(optee, arg_cache_flags);
>         ffa_dev_set_drvdata(ffa_dev, optee);
> diff --git a/drivers/tee/optee/optee_private.h b/drivers/tee/optee/optee_private.h
> index 3da7960ab34a..6e0863a70843 100644
> --- a/drivers/tee/optee/optee_private.h
> +++ b/drivers/tee/optee/optee_private.h
> @@ -43,12 +43,17 @@ typedef void (optee_invoke_fn)(unsigned long, unsigned long, unsigned long,
>  struct optee_call_waiter {
>         struct list_head list_node;
>         struct completion c;
> +       bool sys_thread;
>  };
>
>  struct optee_call_queue {
>         /* Serializes access to this struct */
>         struct mutex mutex;
> -       struct list_head waiters;
> +       struct list_head normal_waiters;
> +       struct list_head sys_waiters;
> +       int total_thread_count;
> +       int free_normal_thread_count;
> +       int res_sys_thread_count;
>  };
>
>  struct optee_notif {
> @@ -254,6 +259,7 @@ int optee_supp_send(struct tee_context *ctx, u32 ret, u32 num_params,
>  int optee_open_session(struct tee_context *ctx,
>                        struct tee_ioctl_open_session_arg *arg,
>                        struct tee_param *param);
> +int optee_system_session(struct tee_context *ctx, u32 session);
>  int optee_close_session_helper(struct tee_context *ctx, u32 session,
>                                bool system_thread);
>  int optee_close_session(struct tee_context *ctx, u32 session);
> @@ -303,8 +309,11 @@ static inline void optee_to_msg_param_value(struct optee_msg_param *mp,
>         mp->u.value.c = p->u.value.c;
>  }
>
> +void optee_cq_init(struct optee_call_queue *cq, int thread_count);
> +bool optee_cq_inc_sys_thread_count(struct optee_call_queue *cq);
> +void optee_cq_dec_sys_thread_count(struct optee_call_queue *cq);
>  void optee_cq_wait_init(struct optee_call_queue *cq,
> -                       struct optee_call_waiter *w);
> +                       struct optee_call_waiter *w, bool sys_thread);
>  void optee_cq_wait_for_completion(struct optee_call_queue *cq,
>                                   struct optee_call_waiter *w);
>  void optee_cq_wait_final(struct optee_call_queue *cq,
> diff --git a/drivers/tee/optee/smc_abi.c b/drivers/tee/optee/smc_abi.c
> index 56ebbb96ac97..2819674fd555 100644
> --- a/drivers/tee/optee/smc_abi.c
> +++ b/drivers/tee/optee/smc_abi.c
> @@ -281,9 +281,10 @@ static int optee_to_msg_param(struct optee *optee,
>  static void optee_enable_shm_cache(struct optee *optee)
>  {
>         struct optee_call_waiter w;
> +       bool system_thread = false;

This variable is redundant.

>
>         /* We need to retry until secure world isn't busy. */
> -       optee_cq_wait_init(&optee->call_queue, &w);
> +       optee_cq_wait_init(&optee->call_queue, &w, system_thread);
>         while (true) {
>                 struct arm_smccc_res res;
>
> @@ -306,9 +307,10 @@ static void optee_enable_shm_cache(struct optee *optee)
>  static void __optee_disable_shm_cache(struct optee *optee, bool is_mapped)
>  {
>         struct optee_call_waiter w;
> +       bool system_thread = false;
>

This variable is redundant.

>         /* We need to retry until secure world isn't busy. */
> -       optee_cq_wait_init(&optee->call_queue, &w);
> +       optee_cq_wait_init(&optee->call_queue, &w, system_thread);
>         while (true) {
>                 union {
>                         struct arm_smccc_res smccc;
> @@ -927,7 +929,7 @@ static int optee_smc_do_call_with_arg(struct tee_context *ctx,
>                 reg_pair_from_64(&param.a1, &param.a2, parg);
>         }
>         /* Initialize waiter */
> -       optee_cq_wait_init(&optee->call_queue, &w);
> +       optee_cq_wait_init(&optee->call_queue, &w, system_thread);
>         while (true) {
>                 struct arm_smccc_res res;
>
> @@ -1209,6 +1211,7 @@ static const struct tee_driver_ops optee_clnt_ops = {
>         .release = optee_release,
>         .open_session = optee_open_session,
>         .close_session = optee_close_session,
> +       .system_session = optee_system_session,
>         .invoke_func = optee_invoke_func,
>         .cancel_req = optee_cancel_req,
>         .shm_register = optee_shm_register,
> @@ -1356,6 +1359,16 @@ static bool optee_msg_exchange_capabilities(optee_invoke_fn *invoke_fn,
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
> @@ -1609,6 +1622,7 @@ static int optee_probe(struct platform_device *pdev)
>         struct optee *optee = NULL;
>         void *memremaped_shm = NULL;
>         unsigned int rpc_param_count;
> +       unsigned int thread_count;
>         struct tee_device *teedev;
>         struct tee_context *ctx;
>         u32 max_notif_value;
> @@ -1636,6 +1650,7 @@ static int optee_probe(struct platform_device *pdev)
>                 return -EINVAL;
>         }
>
> +       thread_count = optee_msg_get_thread_count(invoke_fn);
>         if (!optee_msg_exchange_capabilities(invoke_fn, &sec_caps,
>                                              &max_notif_value,
>                                              &rpc_param_count)) {
> @@ -1725,8 +1740,7 @@ static int optee_probe(struct platform_device *pdev)
>         if (rc)
>                 goto err_unreg_supp_teedev;
>
> -       mutex_init(&optee->call_queue.mutex);
> -       INIT_LIST_HEAD(&optee->call_queue.waiters);
> +       optee_cq_init(&optee->call_queue, thread_count);

Again, this looks like some refactoring going on which should be part
of a separate patch to ease the review process.

-Sumit

>         optee_supp_init(&optee->supp);
>         optee->smc.memremaped_shm = memremaped_shm;
>         optee->pool = pool;
> --
> 2.25.1
>
