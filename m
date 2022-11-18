Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B29E562F3ED
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 12:43:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241337AbiKRLnj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 06:43:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230042AbiKRLnd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 06:43:33 -0500
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5495FE0AE;
        Fri, 18 Nov 2022 03:43:31 -0800 (PST)
Received: by mail-qk1-x730.google.com with SMTP id z1so3179954qkl.9;
        Fri, 18 Nov 2022 03:43:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=LOs6c2XvVXH4tKQVpWmV3h9lepfF7gd7N53CvD43urw=;
        b=aF6yTISiPZ7mFI2UMQPIrAovTFoJjKRj35H0n9cNYhAzaufhgyr+GG8wdFvOL8iXl9
         kMYU0yoGGmhQUyeUYvsyn/nYq4G4y6IeD90J2UpGk0an0azWtrJ0Jx8uM1wIu+S8QPbN
         lK4c1Q87GHXf20siW/YkVmKb/Y3e4FTWYdd+VRQjOooWzyST/QEC5uj/Yl7w2XAqOBBS
         +H0R3x+SlP1Mu3w0amYDyvrSiZhSSyfX+Y7JUwN2EHQ7V5MmgTZ3XsYOmj/WemNP39wd
         /PCC5iLZPsLwvFf34i+Oe61tNRO//8Ii7GNBVVIjcfqzyiQGVXKy3/oiAoHXNrbimqwS
         Y3Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LOs6c2XvVXH4tKQVpWmV3h9lepfF7gd7N53CvD43urw=;
        b=2Hv1tSg54dfroxyigbNfASNcus7XLwrSBLlFktcRohS3LYtjJFF7PBMV+v/rl/pj6D
         G1xVMYEs3Z+IbeclCF6xdWrfoN7vkDK+Jj5zyHbBSzRUWxknDS6m+VXt5DvbPjBaitvW
         PhR9PDP0cSUcpJVsW3DmYZdwpE1mmyUKBdKvhnHIYGwE7x2xOptSWKcVy+JA5uEyOv6A
         7smTlFuZDJHVJHZqFtkTxwwdantklSSoVw7+GA2Ckr6qSTGyCBnmEn4q6uaolpyxv8S5
         29757urfmZxJZfaSg8A+uJIZEmd2vdF1CgQEV5sRQyqokYJl/bFdSQd6zPM827Y7b+lR
         kilg==
X-Gm-Message-State: ANoB5pkxo3FBD067W/iBY95f0onIz42o9UtbsOJ9j58zi+nX+Yo8nypi
        osALuZNtQGe7y+jnTRYzHEIQGHfLgHW+G+hfg/pg+gWB3iNAAQ==
X-Google-Smtp-Source: AA0mqf7FjHrgIMdUcXE6kcC899Kjubf5qPHlke+OY+gw2XNyNhSsO0D5/gZBxU8cDCh93iBHxeaiVKBX27r6gotrPDA=
X-Received: by 2002:a05:620a:268a:b0:6fa:2c8d:d6c7 with SMTP id
 c10-20020a05620a268a00b006fa2c8dd6c7mr5213234qkp.441.1668771810431; Fri, 18
 Nov 2022 03:43:30 -0800 (PST)
MIME-Version: 1.0
References: <20221118054725.80414-1-michael@allwinnertech.com>
In-Reply-To: <20221118054725.80414-1-michael@allwinnertech.com>
From:   Wenchao Chen <wenchao.chen666@gmail.com>
Date:   Fri, 18 Nov 2022 19:43:19 +0800
Message-ID: <CA+Da2qxP2gvUc2=n5xW7_YEcgevGpDhqbcVFWVbF0c6DqXDXHA@mail.gmail.com>
Subject: Re: [PATCH] mmc:mmc-hsq:use fifo to dispatch mmc_request
To:     Michael Wu <michael@allwinnertech.com>
Cc:     ulf.hansson@linaro.org, wenchao.chen@unisoc.com,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 18, 2022 at 1:52 PM Michael Wu <michael@allwinnertech.com> wrote:
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

Hi Michael
Is the test device an eMMC?
Could you share the fio test command if you want?
Can you provide more logs?

> Signed-off-by: Michael Wu <michael@allwinnertech.com>
> ---
>  drivers/mmc/host/mmc_hsq.c | 40 ++++++++++++++------------------------
>  drivers/mmc/host/mmc_hsq.h |  5 +++++
>  2 files changed, 20 insertions(+), 25 deletions(-)
>
> diff --git a/drivers/mmc/host/mmc_hsq.c b/drivers/mmc/host/mmc_hsq.c
> index 9d35453e7371..d2a1a96ed5bd 100644
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
> +               hsq->tag_tail = HSQ_INVALID_TAG;
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
> +               hsq->tag_tail = tag;
> +               hsq->tag_slot[hsq->tag_tail] = HSQ_INVALID_TAG;
> +       } else {
> +               hsq->tag_slot[hsq->tag_tail] = tag;
> +               hsq->tag_tail = tag;
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
> +       hsq->tag_tail = HSQ_INVALID_TAG;
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
> index ffdd9cd172c3..a783366285a9 100644
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
> +       int tag_tail;
> +       int tag_slot[HSQ_NUM_SLOTS];
>
>         bool enabled;
>         bool waiting_for_idle;
> --
> 2.29.0
>
