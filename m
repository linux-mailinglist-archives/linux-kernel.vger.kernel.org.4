Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E8175FDD80
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 17:48:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229799AbiJMPsV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 11:48:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229775AbiJMPsN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 11:48:13 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCE5CDED0E
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 08:48:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9F308B80DFB
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 15:48:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62060C433D7
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 15:48:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665676089;
        bh=Wa541eDzRYS4j76ntg21vDUMcW48jkczpqipGDLUNb8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=F8VjBD8XtQdHYVjkZNLeSI+YESNRncB1OewouOf1Ii5PDrEyrV22BVjLcEVg+/80G
         /x80hIApxam20WbYTFgLHxcKht85/wRBPCYULhdFNL+8vs9DgMHRfGeQD12qjxJeoc
         XGhExsYxgHfApKE+/rlD7lvQ1Eeb/m6jbcglGCt1SsYrMtVH5SyeQFK8MuEKDOQmIL
         dx8PyXPlSWwsSRKqbwUBi0FMdrq5wW2qPC9AcLQ216Rxj5df1d4Gsc90/jBq0Dvgcj
         HRjmJy5V7phPfoRaYsWGya0hHi+/xITUxEJ1RkpCaJFaNE1lCs/gIypAut2wktx3Ho
         e0uifKPOzM7wQ==
Received: by mail-ed1-f42.google.com with SMTP id z97so3209372ede.8
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 08:48:09 -0700 (PDT)
X-Gm-Message-State: ACrzQf20UxygaLI2jZqaE/cvYX4pMmBYAo6jZGv24+DU/ArQq1vA7eNd
        nwEdYXyJCZNIJDu2eT7Ou+qFq9/jnTVGMlFDVHs=
X-Google-Smtp-Source: AMsMyM6mSS/hhsIJgjZGknfVP14PF0iAv+DkD7V8yhWhoSenN35ubULnVc7C9k8d8AdlIyl9fYKJYZAVaqOFTYLSFd4=
X-Received: by 2002:aa7:df16:0:b0:45b:f51f:ab73 with SMTP id
 c22-20020aa7df16000000b0045bf51fab73mr365454edy.366.1665676087592; Thu, 13
 Oct 2022 08:48:07 -0700 (PDT)
MIME-Version: 1.0
References: <20221013131209.775969-1-yangyingliang@huawei.com>
In-Reply-To: <20221013131209.775969-1-yangyingliang@huawei.com>
From:   Huacai Chen <chenhuacai@kernel.org>
Date:   Thu, 13 Oct 2022 23:47:55 +0800
X-Gmail-Original-Message-ID: <CAAhV-H48bH5VAYhsMvupUSWouAUR=s9b4hJYdJYdymCYbKQfjA@mail.gmail.com>
Message-ID: <CAAhV-H48bH5VAYhsMvupUSWouAUR=s9b4hJYdJYdymCYbKQfjA@mail.gmail.com>
Subject: Re: [PATCH] platform/loongarch: laptop: fix possible UAF in generic_acpi_laptop_init()
To:     Yang Yingliang <yangyingliang@huawei.com>
Cc:     linux-kernel@vger.kernel.org, lvjianmin@loongson.cn,
        chenhuacai@loongson.cn
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Yingliang,

Thank you for your patches, but could you please merge the two trivial
patches to a single one?

Huacai

On Thu, Oct 13, 2022 at 9:12 PM Yang Yingliang <yangyingliang@huawei.com> wrote:
>
> Current the return value of 'sub_driver->init' is not checked,
> if sparse_keymap_setup() called in the init function fails,
> 'generic_inputdev' is freed, then it willl lead a UAF when
> using it in generic_acpi_laptop_init(). Fix it by checking
> return value. Set generic_inputdev to NULL after free to avoid
> double free it.
>
> Fixes: 6246ed09111f ("LoongArch: Add ACPI-based generic laptop driver")
> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
> ---
>  drivers/platform/loongarch/loongson-laptop.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/platform/loongarch/loongson-laptop.c b/drivers/platform/loongarch/loongson-laptop.c
> index f0166ad5d2c2..a665fd1042ac 100644
> --- a/drivers/platform/loongarch/loongson-laptop.c
> +++ b/drivers/platform/loongarch/loongson-laptop.c
> @@ -448,6 +448,7 @@ static int __init event_init(struct generic_sub_driver *sub_driver)
>         if (ret < 0) {
>                 pr_err("Failed to setup input device keymap\n");
>                 input_free_device(generic_inputdev);
> +               generic_inputdev = NULL;
>
>                 return ret;
>         }
> @@ -502,8 +503,11 @@ static int __init generic_subdriver_init(struct generic_sub_driver *sub_driver)
>         if (ret)
>                 return -EINVAL;
>
> -       if (sub_driver->init)
> -               sub_driver->init(sub_driver);
> +       if (sub_driver->init) {
> +               ret = sub_driver->init(sub_driver);
> +               if (ret)
> +                       goto err_out;
> +       }
>
>         if (sub_driver->notify) {
>                 ret = setup_acpi_notify(sub_driver);
> --
> 2.25.1
>
