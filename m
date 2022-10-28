Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84E92611988
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 19:43:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230171AbiJ1RnT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 13:43:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230090AbiJ1RnD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 13:43:03 -0400
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10405228CD1;
        Fri, 28 Oct 2022 10:43:03 -0700 (PDT)
Received: by mail-qt1-f178.google.com with SMTP id g16so3925239qtu.2;
        Fri, 28 Oct 2022 10:43:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Eah8WFgQUColVrZzNPgF2lY+dbjpV+ZLpOQgdNyOUHE=;
        b=UT6BwzgCyP7TUVyJu3Nsgd7Ng06rHtnucwVUQpC8d6MLq1pinO+aIoa0gyM6LAoms+
         pQGpzVxfUN7YotuTh2DuQv0e3qSCreo071euewtKK+gVE4BD9WF+McAI/K6H4U25uE1I
         izeTGXxUqvEGBvvmJ2UjoJsmvsuFE7vfF1fianmZnDJXSimoZPDwTeD/dqvYvDVMbzy7
         Ahmk+U5lTZRpOrCRNWQ8jfBSL4FpbQ/dXvYvTFQCE3Bf+iv5tLWNgLqDp3XgLpIKZKe8
         5S97fT7pfIKrKQJmeYQSi3cQjJP1ykWg0FSrFjzRirE18uozDyV/22ao0vLYA9Z8kxp8
         lGyA==
X-Gm-Message-State: ACrzQf3pnaxDiYpCvv5pbdNwBiPX9ygqtBqo55BeQjAIYhRSYKrLvQH6
        XRiueB7N3aQAO45g0Yam5nnli6xq2UZ3s6kiDFk=
X-Google-Smtp-Source: AMsMyM6OzHAUPtj73rfL8xjuNalrUrW/YmoClhm/6plK5pfLXawyKFhC7mKcWigsq90bhW8nRRUdquH+EAMo0c4HrOA=
X-Received: by 2002:a05:622a:1a25:b0:39c:b862:7318 with SMTP id
 f37-20020a05622a1a2500b0039cb8627318mr544644qtb.147.1666978982216; Fri, 28
 Oct 2022 10:43:02 -0700 (PDT)
MIME-Version: 1.0
References: <20221027031648.2452-1-huangqibo.tech@gmail.com>
In-Reply-To: <20221027031648.2452-1-huangqibo.tech@gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 28 Oct 2022 19:42:51 +0200
Message-ID: <CAJZ5v0gFTmJY0TzYkPeEWeeUVz+zMccnYEXHyvk-mV2ypWUwRg@mail.gmail.com>
Subject: Re: [PATCH] thermal/core: cooling device duplicate creation check
To:     Qibo Huang <huangqibo.tech@gmail.com>
Cc:     rafael@kernel.org, daniel.lezcano@linaro.org, amitk@kernel.org,
        rui.zhang@intel.com, linux-pm@vger.kernel.org,
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

On Thu, Oct 27, 2022 at 5:17 AM Qibo Huang <huangqibo.tech@gmail.com> wrote:
>
> Because creating a cooling device may have duplicate names.

Why is this a problem?

> When creating, first check thermal_cdev_list whether
> there is a device with the same name. If it has the same name,
> it returns a reference to the cooling device.

Why is this a correct and the best possible solution?

> Signed-off-by: Qibo Huang <huangqibo.tech@gmail.com>
> ---
>  drivers/thermal/thermal_core.c | 34 ++++++++++++++++++++++++++++++++++
>  1 file changed, 34 insertions(+)
>
> diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
> index 7e669b60a065..f38f9464e9f4 100644
> --- a/drivers/thermal/thermal_core.c
> +++ b/drivers/thermal/thermal_core.c
> @@ -844,6 +844,34 @@ static void bind_cdev(struct thermal_cooling_device *cdev)
>         mutex_unlock(&thermal_list_lock);
>  }
>
> +struct thermal_cooling_device *thermal_cdev_get_zone_by_name(const char *name)
> +{
> +       struct thermal_cooling_device *pos = NULL, *ref = ERR_PTR(-EINVAL);
> +       unsigned int found = 0;
> +
> +       if (!name)
> +               goto exit;
> +
> +       mutex_lock(&thermal_list_lock);
> +       list_for_each_entry(pos, &thermal_cdev_list, node)
> +               if (!strncasecmp(name, pos->type, THERMAL_NAME_LENGTH)) {
> +                       found++;
> +                       ref = pos;
> +               }
> +       mutex_unlock(&thermal_list_lock);
> +
> +       /* nothing has been found, thus an error code for it */
> +       if (found == 0)
> +               ref = ERR_PTR(-ENODEV);
> +       else if (found > 1)
> +       /* Success only when an unique zone is found */
> +               ref = ERR_PTR(-EEXIST);
> +
> +exit:
> +       return ref;
> +}
> +EXPORT_SYMBOL_GPL(thermal_cdev_get_zone_by_name);
> +
>  /**
>   * __thermal_cooling_device_register() - register a new thermal cooling device
>   * @np:                a pointer to a device tree node.
> @@ -873,6 +901,12 @@ __thermal_cooling_device_register(struct device_node *np,
>             !ops->set_cur_state)
>                 return ERR_PTR(-EINVAL);
>
> +       if (type) {
> +               cdev = thermal_cdev_get_zone_by_name(type);
> +               if (!IS_ERR(cdev))
> +                       return cdev;
> +       }
> +
>         cdev = kzalloc(sizeof(*cdev), GFP_KERNEL);
>         if (!cdev)
>                 return ERR_PTR(-ENOMEM);
> --
> 2.37.1
>
