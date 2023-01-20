Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4C2067563A
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 14:58:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229954AbjATN6q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 08:58:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229947AbjATN6o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 08:58:44 -0500
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3910AC45B1;
        Fri, 20 Jan 2023 05:58:38 -0800 (PST)
Received: by mail-ej1-f43.google.com with SMTP id mp20so14134659ejc.7;
        Fri, 20 Jan 2023 05:58:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AEj2kXz159a60ugxgnnelotgtf68cOS7bPsTmNTRxnw=;
        b=MB/jByEi40dsxTmlc+bgPtsDxVJ0aIlJibw+7tk8/J7qxtp5b06yLaweqh0OhhnY8n
         AxrUDruO/AvdXQS4bAMflmXA5ayeSVpkHBMjng46UEj8GikkAoMCvdC/XR14ygxfyH0P
         iBllYexAYaLe3zje3W6zTudoIz8wsufTuiImQnI17YcTHrkJ3HKqoM9+iRrG8xE4H9I2
         Xc1AYd+qlirfL+vDH+PiIq5fg68o7jvpEY9xsjKPymbryF3N8UdBWF1VjHwzjPrNd0Er
         RL+GLIHWPJ/sk2I9bjLrWBYfijqO/ktYHAf36iFfWAh8gsTEY5zjpnVP0sE2/LXLVrA7
         kh4g==
X-Gm-Message-State: AFqh2kq2uAfbA4chBWNHPd9KdYqsZsIaz0WuY4KV5ak8DE1MaK/YnzV5
        ZcQMDRH//+eydZ0QsLVD/0aM46YqM2c6MbQxWFc=
X-Google-Smtp-Source: AMrXdXv58b76sdfeqtLM2rG//qM9vxKRshFkW4HhG2TN8ZX1EgDjIfccBQpTMFdwb6CwBhIy/0NwRM1Tw4IUAnB0VQU=
X-Received: by 2002:a17:907:7855:b0:855:63bb:d3cb with SMTP id
 lb21-20020a170907785500b0085563bbd3cbmr1517401ejc.532.1674223116839; Fri, 20
 Jan 2023 05:58:36 -0800 (PST)
MIME-Version: 1.0
References: <20230103125726.681099-1-yangyingliang@huawei.com>
In-Reply-To: <20230103125726.681099-1-yangyingliang@huawei.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 20 Jan 2023 14:58:25 +0100
Message-ID: <CAJZ5v0ija9YPhU-700a+7iDzGP+7ECrgrKim0z+vadS16wONxA@mail.gmail.com>
Subject: Re: [PATCH] powercap: fix possible name leak in powercap_register_zone()
To:     Yang Yingliang <yangyingliang@huawei.com>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        rafael@kernel.org, srinivas.pandruvada@linux.intel.com,
        jacob.jun.pan@linux.intel.com, gregkh@linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 3, 2023 at 1:38 PM Yang Yingliang <yangyingliang@huawei.com> wrote:
>
> In the error path after calling dev_set_name(), the device
> name is leaked. To fix this, calling dev_set_name() before
> device_register(), and call put_device() if it returns error.
> All the resources is released in powercap_release(), so it
> can return from powercap_register_zone() directly.
>
> Fixes: 75d2364ea0ca ("PowerCap: Add class driver")
> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
> ---
>  drivers/powercap/powercap_sys.c | 14 +++++++++-----
>  1 file changed, 9 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/powercap/powercap_sys.c b/drivers/powercap/powercap_sys.c
> index 1f968353d479..e180dee0f83d 100644
> --- a/drivers/powercap/powercap_sys.c
> +++ b/drivers/powercap/powercap_sys.c
> @@ -530,9 +530,6 @@ struct powercap_zone *powercap_register_zone(
>         power_zone->name = kstrdup(name, GFP_KERNEL);
>         if (!power_zone->name)
>                 goto err_name_alloc;
> -       dev_set_name(&power_zone->dev, "%s:%x",
> -                                       dev_name(power_zone->dev.parent),
> -                                       power_zone->id);
>         power_zone->constraints = kcalloc(nr_constraints,
>                                           sizeof(*power_zone->constraints),
>                                           GFP_KERNEL);
> @@ -555,9 +552,16 @@ struct powercap_zone *powercap_register_zone(
>         power_zone->dev_attr_groups[0] = &power_zone->dev_zone_attr_group;
>         power_zone->dev_attr_groups[1] = NULL;
>         power_zone->dev.groups = power_zone->dev_attr_groups;
> +       dev_set_name(&power_zone->dev, "%s:%x",
> +                                       dev_name(power_zone->dev.parent),
> +                                       power_zone->id);
>         result = device_register(&power_zone->dev);
> -       if (result)
> -               goto err_dev_ret;
> +       if (result) {
> +               put_device(&power_zone->dev);
> +               mutex_unlock(&control_type->lock);
> +
> +               return ERR_PTR(result);
> +       }
>
>         control_type->nr_zones++;
>         mutex_unlock(&control_type->lock);
> --

Applied as 6.3 material, thanks!
