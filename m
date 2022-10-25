Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE7DC60D124
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 17:58:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232506AbiJYP5o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 11:57:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232893AbiJYP5c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 11:57:32 -0400
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1461C15B31A;
        Tue, 25 Oct 2022 08:57:32 -0700 (PDT)
Received: by mail-qt1-f177.google.com with SMTP id h24so7801609qta.7;
        Tue, 25 Oct 2022 08:57:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=k29w+kL7IGJnJULcDKFHRJDTCVQ+jNFBrIj3XeJ0s6Q=;
        b=jFYZXjx7/c8Ryly00vP13e8QPYn1XdF+6DHdgMls4uSTiUJ4GGMFSQgkK6YZ9NeW1j
         ACowD82ggr21KFwl/aloovd3wwAtImDknQCRcKkEVqGYIwB3otzdJ8e+nzByoybE2Xft
         F2OkBIJI0rXP+WQ30728GgyX5oUK3nn5zjwfq7YfgBKNAbVu4Uk6Nhk7C2tZvAVz3Tn9
         w69oIO091Nqn6yc+HE1F/K9Odrpean3qxRJCw6vLp+eEtue9fLq/YoMLK2BhIvfpDng1
         X1nbI8T6hp0PcC+3az6U6DPzjUmuUvfOL4RPeVWDzhjw08cROg8NBiBzEi532UCcfaGa
         2hYA==
X-Gm-Message-State: ACrzQf0zHGOtgXJv7t3mBtruApY/0XQnn4saizwTjm8Scg2moehzYVxZ
        IHwu7hI2Ii2c56pe2LLeY538dnv77uffBZ4hdtFRQGu1
X-Google-Smtp-Source: AMsMyM5pE6mS7PBO9yo7jvy6BF5n8mn+iOb3wxFuX1D5CYeBrjYGLcaY5jbQjnb9YM7hY0NYuptQEtg2Rc/ppoICL0w=
X-Received: by 2002:a05:622a:13c6:b0:39c:c34f:29ec with SMTP id
 p6-20020a05622a13c600b0039cc34f29ecmr32619602qtk.153.1666713451143; Tue, 25
 Oct 2022 08:57:31 -0700 (PDT)
MIME-Version: 1.0
References: <20220907064311.54475-1-niejianglei2021@163.com>
In-Reply-To: <20220907064311.54475-1-niejianglei2021@163.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 25 Oct 2022 17:57:20 +0200
Message-ID: <CAJZ5v0j_7y7craYxv0PiFTKOUgu+sS0mwuSnQi6-qAhRSSkGwg@mail.gmail.com>
Subject: Re: [PATCH] PM: hibernate: Fix potential memory leak in
 hibernate_preallocate_memory() and prepare_highmem_image()
To:     Jianglei Nie <niejianglei2021@163.com>
Cc:     rafael@kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 7, 2022 at 8:43 AM Jianglei Nie <niejianglei2021@163.com> wrote:
>
> hibernate_preallocate_memory() and prepare_highmem_image() allocates
> memory chunk with memory_bm_create(). When the function gets some error
> after memory_bm_create(), relavent memory should be released with
> memory_bm_free().

swsusp_free() called at the end is expected to free all of these
pages.  Doesn't it do that?

> Fix it by calling memory_bm_free() at the right time.
>
> Signed-off-by: Jianglei Nie <niejianglei2021@163.com>
> ---
>  kernel/power/snapshot.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/kernel/power/snapshot.c b/kernel/power/snapshot.c
> index 2a406753af90..e5ec204ebe22 100644
> --- a/kernel/power/snapshot.c
> +++ b/kernel/power/snapshot.c
> @@ -1752,6 +1752,7 @@ int hibernate_preallocate_memory(void)
>
>         error = memory_bm_create(&copy_bm, GFP_IMAGE, PG_ANY);
>         if (error) {
> +               memory_bm_free(&orig_bm, PG_UNSAFE_CLEAR);
>                 pr_err("Cannot allocate copy bitmap\n");
>                 goto err_out;
>         }
> @@ -2335,8 +2336,10 @@ static int prepare_highmem_image(struct memory_bitmap *bm,
>         if (memory_bm_create(bm, GFP_ATOMIC, PG_SAFE))
>                 return -ENOMEM;
>
> -       if (get_highmem_buffer(PG_SAFE))
> +       if (get_highmem_buffer(PG_SAFE)) {
> +               memory_bm_free(bm, PG_UNSAFE_CLEAR);
>                 return -ENOMEM;
> +       }
>
>         to_alloc = count_free_highmem_pages();
>         if (to_alloc > *nr_highmem_p)
> --
> 2.25.1
>
