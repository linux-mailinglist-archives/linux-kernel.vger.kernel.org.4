Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 346CF63C071
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 13:56:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234842AbiK2M4A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 07:56:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234789AbiK2Mzd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 07:55:33 -0500
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55CF461BBF
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 04:55:18 -0800 (PST)
Received: by mail-pg1-x52d.google.com with SMTP id 62so12883310pgb.13
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 04:55:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=nZBf1IfIVnb85Jco2r20WP4lEoHCR+U5L4gFwwhYWjk=;
        b=HSgQmY2oi5ayga1iYG0VKBLf4rBYBUxEhyYCZO38IHE4MDHqrwh5osdtvitwVUiS/Z
         yP8xyUC01FQtfgrq8II390a56K73zTTWFr2R5EoXFHLzsDRysn6O0xmbhSw20274XAUs
         t6zDoDcc7oF819/0sISA/b/+PpZsjV8Zy7Bs4kmnBtGg5mXDfJ4SF8q+o4U9Y7oDMf+8
         T8aDjOh7tdkYgGDbF0ab2FuFp0dbDFVOY8d6MpjBMGUUVhWOyupzAYI0ctnBjJtmLLmy
         d/F4LcuJ+nZojLxdhyWplvTata+NWuQpgYFaQQOOzfY2vpQZBZ4pXMLK8mItxZ8IeSm7
         2upg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nZBf1IfIVnb85Jco2r20WP4lEoHCR+U5L4gFwwhYWjk=;
        b=36GIFcEgI9fnGv+NeDXW/pt+6JssAbgZgO/ZvFaqLBgLXM0j2gQZQGuzy63q1KT8f/
         m9/C6/pEpQ2BZWblE1AguWEYEWqvO1G5d0vZg48vmdXT69qELzxpIWGqSaBWk+g6pPk+
         lH7H2Sn4G3QJ52XL91ifldLBC96i7yxH9B0oEf4kQjmVtOM7OuUVo1nrEvJr0RfGMQ4b
         qzqsTQETw+Nf6/a5Tp6EyUKAsieU/p+vCBR1R23Zzx1hIMy60zY3PaOZUS5MKQolJMCM
         op/H4hTXWJ4amTPOQ76eeTnSCpq9tb4Q0RFvfgLCSHrNMuCUFcr0hBvCp/Ll16yHHRa8
         ermg==
X-Gm-Message-State: ANoB5pkqmAQ2mCyKHzWyQD7rbJrJx5E11K+6BcciZpTnt3Ex3wGj0hEP
        CCGt/14CR0ayWJb5zJzcgdhP2TPnkwA6KEhunZK94A==
X-Google-Smtp-Source: AA0mqf5mFcdHVfXr/d6zhl2LXO3vJlAlD9Hrm44RqJ4l4rkzj6P9gSWDUDXBaFW+whGNCYVlq8BB1qqCgZosXtJxoRM=
X-Received: by 2002:aa7:998a:0:b0:575:6907:662a with SMTP id
 k10-20020aa7998a000000b005756907662amr4701446pfh.57.1669726517914; Tue, 29
 Nov 2022 04:55:17 -0800 (PST)
MIME-Version: 1.0
References: <20221128093847.22768-1-michael@allwinnertech.com>
In-Reply-To: <20221128093847.22768-1-michael@allwinnertech.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 29 Nov 2022 13:54:41 +0100
Message-ID: <CAPDyKFoz5-tU7v9im0iz07xaS9LhmCRTc9=okxBRij1c2RW27w@mail.gmail.com>
Subject: Re: [PATCH v2] mmc:mmc-hsq:use fifo to dispatch mmc_request
To:     Michael Wu <michael@allwinnertech.com>
Cc:     wenchao.chen@unisoc.com, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 28 Nov 2022 at 10:38, Michael Wu <michael@allwinnertech.com> wrote:
>
> Current next_tag selection will cause a large delay in some requests and
> destroy the scheduling results of the block scheduling layer. Because the
> issued mrq tags cannot ensure that each time is sequential, especially when
> the IO load is heavy. In the fio performance test, we found that 4k random
> read data was sent to mmc_hsq to start calling request_atomic It takes
> nearly 200ms to process the request, while mmc_hsq has processed thousands
> of other requests. So we use fifo here to ensure the first in, first out
> feature of the request and avoid adding additional delay to the request.
>
> Reviewed-by: Wenchao Chen <wenchao.chen@unisoc.com>
> Signed-off-by: Michael Wu <michael@allwinnertech.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/mmc_hsq.c | 40 ++++++++++++++------------------------
>  drivers/mmc/host/mmc_hsq.h |  5 +++++
>  2 files changed, 20 insertions(+), 25 deletions(-)
>
> diff --git a/drivers/mmc/host/mmc_hsq.c b/drivers/mmc/host/mmc_hsq.c
> index 9d35453e7371..424dc7b07858 100644
> --- a/drivers/mmc/host/mmc_hsq.c
> +++ b/drivers/mmc/host/mmc_hsq.c
> @@ -13,9 +13,6 @@
>
>  #include "mmc_hsq.h"
>
> -#define HSQ_NUM_SLOTS  64
> -#define HSQ_INVALID_TAG        HSQ_NUM_SLOTS
> -
>  static void mmc_hsq_retry_handler(struct work_struct *work)
>  {
>         struct mmc_hsq *hsq = container_of(work, struct mmc_hsq, retry_work);
> @@ -73,7 +70,6 @@ static void mmc_hsq_pump_requests(struct mmc_hsq *hsq)
>
>  static void mmc_hsq_update_next_tag(struct mmc_hsq *hsq, int remains)
>  {
> -       struct hsq_slot *slot;
>         int tag;
>
>         /*
> @@ -82,29 +78,12 @@ static void mmc_hsq_update_next_tag(struct mmc_hsq *hsq, int remains)
>          */
>         if (!remains) {
>                 hsq->next_tag = HSQ_INVALID_TAG;
> +               hsq->tail_tag = HSQ_INVALID_TAG;
>                 return;
>         }
>
> -       /*
> -        * Increasing the next tag and check if the corresponding request is
> -        * available, if yes, then we found a candidate request.
> -        */
> -       if (++hsq->next_tag != HSQ_INVALID_TAG) {
> -               slot = &hsq->slot[hsq->next_tag];
> -               if (slot->mrq)
> -                       return;
> -       }
> -
> -       /* Othersie we should iterate all slots to find a available tag. */
> -       for (tag = 0; tag < HSQ_NUM_SLOTS; tag++) {
> -               slot = &hsq->slot[tag];
> -               if (slot->mrq)
> -                       break;
> -       }
> -
> -       if (tag == HSQ_NUM_SLOTS)
> -               tag = HSQ_INVALID_TAG;
> -
> +       tag = hsq->tag_slot[hsq->next_tag];
> +       hsq->tag_slot[hsq->next_tag] = HSQ_INVALID_TAG;
>         hsq->next_tag = tag;
>  }
>
> @@ -233,8 +212,14 @@ static int mmc_hsq_request(struct mmc_host *mmc, struct mmc_request *mrq)
>          * Set the next tag as current request tag if no available
>          * next tag.
>          */
> -       if (hsq->next_tag == HSQ_INVALID_TAG)
> +       if (hsq->next_tag == HSQ_INVALID_TAG) {
>                 hsq->next_tag = tag;
> +               hsq->tail_tag = tag;
> +               hsq->tag_slot[hsq->tail_tag] = HSQ_INVALID_TAG;
> +       } else {
> +               hsq->tag_slot[hsq->tail_tag] = tag;
> +               hsq->tail_tag = tag;
> +       }
>
>         hsq->qcnt++;
>
> @@ -339,8 +324,10 @@ static const struct mmc_cqe_ops mmc_hsq_ops = {
>
>  int mmc_hsq_init(struct mmc_hsq *hsq, struct mmc_host *mmc)
>  {
> +       int i;
>         hsq->num_slots = HSQ_NUM_SLOTS;
>         hsq->next_tag = HSQ_INVALID_TAG;
> +       hsq->tail_tag = HSQ_INVALID_TAG;
>
>         hsq->slot = devm_kcalloc(mmc_dev(mmc), hsq->num_slots,
>                                  sizeof(struct hsq_slot), GFP_KERNEL);
> @@ -351,6 +338,9 @@ int mmc_hsq_init(struct mmc_hsq *hsq, struct mmc_host *mmc)
>         hsq->mmc->cqe_private = hsq;
>         mmc->cqe_ops = &mmc_hsq_ops;
>
> +       for (i = 0; i < HSQ_NUM_SLOTS; i++)
> +               hsq->tag_slot[i] = HSQ_INVALID_TAG;
> +
>         INIT_WORK(&hsq->retry_work, mmc_hsq_retry_handler);
>         spin_lock_init(&hsq->lock);
>         init_waitqueue_head(&hsq->wait_queue);
> diff --git a/drivers/mmc/host/mmc_hsq.h b/drivers/mmc/host/mmc_hsq.h
> index ffdd9cd172c3..1808024fc6c5 100644
> --- a/drivers/mmc/host/mmc_hsq.h
> +++ b/drivers/mmc/host/mmc_hsq.h
> @@ -2,6 +2,9 @@
>  #ifndef LINUX_MMC_HSQ_H
>  #define LINUX_MMC_HSQ_H
>
> +#define HSQ_NUM_SLOTS  64
> +#define HSQ_INVALID_TAG        HSQ_NUM_SLOTS
> +
>  struct hsq_slot {
>         struct mmc_request *mrq;
>  };
> @@ -17,6 +20,8 @@ struct mmc_hsq {
>         int next_tag;
>         int num_slots;
>         int qcnt;
> +       int tail_tag;
> +       int tag_slot[HSQ_NUM_SLOTS];
>
>         bool enabled;
>         bool waiting_for_idle;
> --
> 2.29.0
>
