Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 924165FE6BA
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 03:56:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229600AbiJNB44 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 21:56:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbiJNB4y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 21:56:54 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0BA4181C93
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 18:56:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 15BF6B821B6
        for <linux-kernel@vger.kernel.org>; Fri, 14 Oct 2022 01:56:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D202EC433B5
        for <linux-kernel@vger.kernel.org>; Fri, 14 Oct 2022 01:56:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665712610;
        bh=XvsGt36lXf/4iPSbAVQsh1wTJCHrHfmS0W8+B95Kokw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=gMRXodoIgDQum8JJvfFjdHFLLjvTimii52+aOuHirbjOhpPlrRT9aGLIUQrm4yZal
         dP3rvlIfnGbZ4GMJMUvDcEIP+v6XoS8jWtY8wh6satpGfv4CO9fCsnohsts6yB8s1U
         b2AZizX1xdUyC3inV7yKg/wQ2LfXLcBs1rNnBjMCBs9r36K4LV2PTPZ4SxVrM/x4xi
         VrYgUbEsB0oCC3HbnFISs12qut51Hdb1uRuvQoQX5+Z2yQ29XUYuV9Fdsxb+9+yQGp
         FoaiZQzns9fyfSzU9ttNBZkQOSVzV0yuEVctNLhQZQH/uCWTPlPvuPaoVOLzOb5Lbj
         ytETJ9mL87RtA==
Received: by mail-ed1-f42.google.com with SMTP id g27so4961456edf.11
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 18:56:50 -0700 (PDT)
X-Gm-Message-State: ACrzQf1KPYgnBlkiUZszMrZrMJV3eWDVgFsYoNApaRAgAoK3z3OouEF3
        6CwqARPBnU0MtYFQFMcozgBWhWOu19yEbgtFO3M=
X-Google-Smtp-Source: AMsMyM6rUwE9WH0JpXJ7oqRV8TojeQMOEuFjNpViIsP6yp+XRKDfxhuvcWv4Th2E65Z0gHCoINBl4Ml0JTDOFAq1VVc=
X-Received: by 2002:aa7:df16:0:b0:45b:f51f:ab73 with SMTP id
 c22-20020aa7df16000000b0045bf51fab73mr2191385edy.366.1665712609049; Thu, 13
 Oct 2022 18:56:49 -0700 (PDT)
MIME-Version: 1.0
References: <20221014015212.1150629-1-yangyingliang@huawei.com>
In-Reply-To: <20221014015212.1150629-1-yangyingliang@huawei.com>
From:   Huacai Chen <chenhuacai@kernel.org>
Date:   Fri, 14 Oct 2022 09:56:34 +0800
X-Gmail-Original-Message-ID: <CAAhV-H6nGcVKn9E8hvcFh1=3Ak04xg4Xe3+oXM6yJao+M7DvyA@mail.gmail.com>
Message-ID: <CAAhV-H6nGcVKn9E8hvcFh1=3Ak04xg4Xe3+oXM6yJao+M7DvyA@mail.gmail.com>
Subject: Re: [PATCH] platform/loongarch: laptop: fix possible UAF and simplify
 return in generic_acpi_laptop_init()
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

Queued for loongarch-fixes, thanks.

Huacai

On Fri, Oct 14, 2022 at 9:52 AM Yang Yingliang <yangyingliang@huawei.com> wrote:
>
> Current the return value of 'sub_driver->init' is not checked,
> if sparse_keymap_setup() called in the init function fails,
> 'generic_inputdev' is freed, then it willl lead a UAF when
> using it in generic_acpi_laptop_init(). Fix it by checking
> return value. Set generic_inputdev to NULL after free to avoid
> double free it.
>
> The error code in generic_subdriver_init() is always negative,
> the return of generic_subdriver_init() can be simplified.
>
> Fixes: 6246ed09111f ("LoongArch: Add ACPI-based generic laptop driver")
> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
> ---
>  drivers/platform/loongarch/loongson-laptop.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/platform/loongarch/loongson-laptop.c b/drivers/platform/loongarch/loongson-laptop.c
> index f0166ad5d2c2..572290abf151 100644
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
> @@ -519,7 +523,7 @@ static int __init generic_subdriver_init(struct generic_sub_driver *sub_driver)
>
>  err_out:
>         generic_subdriver_exit(sub_driver);
> -       return (ret < 0) ? ret : 0;
> +       return ret;
>  }
>
>  static void generic_subdriver_exit(struct generic_sub_driver *sub_driver)
> --
> 2.25.1
>
