Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DA5370F76C
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 15:12:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235430AbjEXNMA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 09:12:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235351AbjEXNLp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 09:11:45 -0400
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71DDC1B5
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 06:11:36 -0700 (PDT)
Received: by mail-yb1-xb2e.google.com with SMTP id 3f1490d57ef6-ba1815e12efso838664276.3
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 06:11:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684933895; x=1687525895;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=HhgnwAIyg9ROUXM0L6/ZAuKoK3jhzVh9JsVx69YO1KM=;
        b=MYDNqTo1bpq9NIQ3/rF5thaPiqmsb9Qc15tZKJNXUvpKf4mT2K3IcrXWXcArzhqzFt
         kVXoo67F0C6k4uReBaWd/e83uk78UJTOE+nnEGlBlFw9CF/q5CABWfoJPMWzJuTiStb2
         wSt8XU8WHU3o7pi3Yw2pNP/PVoBru9HfXdHilyyRkvcuA8IB1Ks2D8TpVU0t2kBKaQxP
         +ONHixoNuldTLEVPQG5tLnr5aeQmmrfpRWN4ceWNuIpm8gN/XMd/YV4QYFo5+zB7Jt6y
         G7v6XW6Z8BuzAModSE/Mvq92x7BlLwiTo4dNVeStwI6Sb++4azsiudcRuZE/+4x/U3kt
         huwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684933895; x=1687525895;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HhgnwAIyg9ROUXM0L6/ZAuKoK3jhzVh9JsVx69YO1KM=;
        b=O1CCl/YwWGELdKYCvB1uaVmjCCrbXmzFVu+I4jL8qZsqUwxyFY/poPoBoApf9DBSGf
         r1CLNHk0UjlpToAllXrelS/CNKAnP3OtMwkEGPkmVm6YmnXQO2iD+I4WE+aIKUcWYpfs
         IrpUonzN5Qwv+fm0tHHgulnJI22YQibpwmqgCZ0ElgjH1fAeN3DRxQleP9lsZZa8vbsj
         N2iS9edrx+zCOLBQ5/NVsqkmhLARB8pK7PMaRGp0mvxHcXk87Y25hRhBbtaVjAeNf9Mj
         QHdPtltX7eWlxdUkhMLH5mzx9CabOpiDfxh86ltdzkI5GzTaMux5qX6v2sZPYyc2ifxR
         nx6w==
X-Gm-Message-State: AC+VfDx8VYHJ+J0gtK/CRUyBso6jQYCaZyXvkT1WkvU6AnrI4hj/FacL
        sMklxXpwnDOb1yeQKOv0H+5QgTYU8tkyZKFYt9Ud3HaQy9F2FN9N
X-Google-Smtp-Source: ACHHUZ53EcD1EWc15pHU2C/SQX48n1mVShKiznRsFWM7OfXIExFLwTk6450FERUJrDG2TqL/PVh98YJqi6PUYvmrepY=
X-Received: by 2002:a25:407:0:b0:bab:c46f:c7f3 with SMTP id
 7-20020a250407000000b00babc46fc7f3mr13165694ybe.24.1684933895541; Wed, 24 May
 2023 06:11:35 -0700 (PDT)
MIME-Version: 1.0
References: <36e805fa-338d-a945-2621-75c5077572fc@intel.com> <20230518101216.369970-1-asuk4.q@gmail.com>
In-Reply-To: <20230518101216.369970-1-asuk4.q@gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 24 May 2023 15:10:59 +0200
Message-ID: <CAPDyKFqrXteKEj6AnWfefijK5xL2004yt8YRozWWgUt89jqSWw@mail.gmail.com>
Subject: Re: [PATCH] mmc: core: Remove unnecessary error checks and change
 return type
To:     Yeqi Fu <asuk4.q@gmail.com>
Cc:     CLoehle@hyperstone.com, adrian.hunter@intel.com,
        avri.altman@wdc.com, axboe@kernel.dk, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 18 May 2023 at 12:13, Yeqi Fu <asuk4.q@gmail.com> wrote:
>
> The error checks in mmc_blk_add_debugfs() and mmc_blk_remove_debugfs()
> are extraneous. Therefore, this patch removes all error checks from
> both functions.
> Additionally, mmc_blk_add_debugfs() has been changed to return void
> instead of an integer value that was never used. This simplifies the
> function and improves its clarity.
>
> Signed-off-by: Yeqi Fu <asuk4.q@gmail.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/core/block.c | 25 +++++++------------------
>  1 file changed, 7 insertions(+), 18 deletions(-)
>
> diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
> index 00c33edb9fb9..81f33200b893 100644
> --- a/drivers/mmc/core/block.c
> +++ b/drivers/mmc/core/block.c
> @@ -2894,12 +2894,12 @@ static const struct file_operations mmc_dbg_ext_csd_fops = {
>         .llseek         = default_llseek,
>  };
>
> -static int mmc_blk_add_debugfs(struct mmc_card *card, struct mmc_blk_data *md)
> +static void mmc_blk_add_debugfs(struct mmc_card *card, struct mmc_blk_data *md)
>  {
>         struct dentry *root;
>
>         if (!card->debugfs_root)
> -               return 0;
> +               return;
>
>         root = card->debugfs_root;
>
> @@ -2908,19 +2908,13 @@ static int mmc_blk_add_debugfs(struct mmc_card *card, struct mmc_blk_data *md)
>                         debugfs_create_file_unsafe("status", 0400, root,
>                                                    card,
>                                                    &mmc_dbg_card_status_fops);
> -               if (!md->status_dentry)
> -                       return -EIO;
>         }
>
>         if (mmc_card_mmc(card)) {
>                 md->ext_csd_dentry =
>                         debugfs_create_file("ext_csd", S_IRUSR, root, card,
>                                             &mmc_dbg_ext_csd_fops);
> -               if (!md->ext_csd_dentry)
> -                       return -EIO;
>         }
> -
> -       return 0;
>  }
>
>  static void mmc_blk_remove_debugfs(struct mmc_card *card,
> @@ -2929,22 +2923,17 @@ static void mmc_blk_remove_debugfs(struct mmc_card *card,
>         if (!card->debugfs_root)
>                 return;
>
> -       if (!IS_ERR_OR_NULL(md->status_dentry)) {
> -               debugfs_remove(md->status_dentry);
> -               md->status_dentry = NULL;
> -       }
> +       debugfs_remove(md->status_dentry);
> +       md->status_dentry = NULL;
>
> -       if (!IS_ERR_OR_NULL(md->ext_csd_dentry)) {
> -               debugfs_remove(md->ext_csd_dentry);
> -               md->ext_csd_dentry = NULL;
> -       }
> +       debugfs_remove(md->ext_csd_dentry);
> +       md->ext_csd_dentry = NULL;
>  }
>
>  #else
>
> -static int mmc_blk_add_debugfs(struct mmc_card *card, struct mmc_blk_data *md)
> +static void mmc_blk_add_debugfs(struct mmc_card *card, struct mmc_blk_data *md)
>  {
> -       return 0;
>  }
>
>  static void mmc_blk_remove_debugfs(struct mmc_card *card,
> --
> 2.37.2
>
