Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3815F747616
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 18:06:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231491AbjGDQGJ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 4 Jul 2023 12:06:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230232AbjGDQGI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 12:06:08 -0400
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0543BE7A;
        Tue,  4 Jul 2023 09:06:07 -0700 (PDT)
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2b58330576fso18767341fa.1;
        Tue, 04 Jul 2023 09:06:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688486765; x=1691078765;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FUYQR1OTGV83aKP/E1cbbGWILiLZ1oIf9GaUQyPplb4=;
        b=JhLjzIXXQitNFysoATz+whhkqk25+IYV+qgGb72YdQFYX4qic7renoTsCoC5/4ujed
         4iuHXUSeVY/dI8X1VIcWSfJ5vo3C/ONF3EguI6bQkbtzo8Lhuw4WNz9r6X1Kx4E76D4r
         6aks8nq5nI4iK9USejm2TMuuJF1o4v+8lcJNU+yAEqkbK6EkF4J7bxzZYmKrMl71Ilxl
         kj/OQEJ4oO0RSGPlC/Z25vMOOQvmAV3fna8EWI/gekZEI6Or9g2Ri8thg6E724LYJ6OP
         zIkdts8aa5o5iOpkWszOk+OrBfDrLEKgdXU4c7c5wy4vQFQWC2GP0e6llLvNg4QvAUVi
         tLpw==
X-Gm-Message-State: ABy/qLYep9riB43GF7UWNIhYH50tZbT5g5l4+SeOyd7EWVf7+d6mNadY
        0JtYzL8aYU+7KSmx3E2CXsh4bHiMbwFEsvLNHLqOtQsQoKE=
X-Google-Smtp-Source: APBJJlGtPqvxIQi/tu5cWjUHqXqFID5rJfjUKqOOlGmPxjKNAk7P4iDoje+JynoZ9YtiqnyubftxILjsC45WIiyNKCM=
X-Received: by 2002:a2e:870c:0:b0:2b6:cd7f:5ea8 with SMTP id
 m12-20020a2e870c000000b002b6cd7f5ea8mr9298617lji.1.1688486764797; Tue, 04 Jul
 2023 09:06:04 -0700 (PDT)
MIME-Version: 1.0
References: <20230704131715.44454-5-gregkh@linuxfoundation.org> <20230704131715.44454-8-gregkh@linuxfoundation.org>
In-Reply-To: <20230704131715.44454-8-gregkh@linuxfoundation.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 4 Jul 2023 18:05:53 +0200
Message-ID: <CAJZ5v0jsK+o=auHMwcOnqamLS1_cw6D9YRJ4YDs2n-46R=zGYw@mail.gmail.com>
Subject: Re: [PATCH 3/3] driver core: remove devm_device_add_groups()
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-hwmon@vger.kernel.org, linux@roeck-us.net,
        samsagax@gmail.com, linux-kernel@vger.kernel.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 4, 2023 at 3:17 PM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> There is no more in-kernel users of this function, and no driver should
> ever be using it, so remove it from the kernel.
>
> Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Acked-by: Rafael J. Wysocki <rafael@kernel.org>

> ---
>  drivers/base/core.c    | 45 ------------------------------------------
>  include/linux/device.h |  2 --
>  2 files changed, 47 deletions(-)
>
> diff --git a/drivers/base/core.c b/drivers/base/core.c
> index 3dff5037943e..94187c0b577d 100644
> --- a/drivers/base/core.c
> +++ b/drivers/base/core.c
> @@ -2748,15 +2748,6 @@ static void devm_attr_group_remove(struct device *dev, void *res)
>         sysfs_remove_group(&dev->kobj, group);
>  }
>
> -static void devm_attr_groups_remove(struct device *dev, void *res)
> -{
> -       union device_attr_group_devres *devres = res;
> -       const struct attribute_group **groups = devres->groups;
> -
> -       dev_dbg(dev, "%s: removing groups %p\n", __func__, groups);
> -       sysfs_remove_groups(&dev->kobj, groups);
> -}
> -
>  /**
>   * devm_device_add_group - given a device, create a managed attribute group
>   * @dev:       The device to create the group for
> @@ -2789,42 +2780,6 @@ int devm_device_add_group(struct device *dev, const struct attribute_group *grp)
>  }
>  EXPORT_SYMBOL_GPL(devm_device_add_group);
>
> -/**
> - * devm_device_add_groups - create a bunch of managed attribute groups
> - * @dev:       The device to create the group for
> - * @groups:    The attribute groups to create, NULL terminated
> - *
> - * This function creates a bunch of managed attribute groups.  If an error
> - * occurs when creating a group, all previously created groups will be
> - * removed, unwinding everything back to the original state when this
> - * function was called.  It will explicitly warn and error if any of the
> - * attribute files being created already exist.
> - *
> - * Returns 0 on success or error code from sysfs_create_group on failure.
> - */
> -int devm_device_add_groups(struct device *dev,
> -                          const struct attribute_group **groups)
> -{
> -       union device_attr_group_devres *devres;
> -       int error;
> -
> -       devres = devres_alloc(devm_attr_groups_remove,
> -                             sizeof(*devres), GFP_KERNEL);
> -       if (!devres)
> -               return -ENOMEM;
> -
> -       error = sysfs_create_groups(&dev->kobj, groups);
> -       if (error) {
> -               devres_free(devres);
> -               return error;
> -       }
> -
> -       devres->groups = groups;
> -       devres_add(dev, devres);
> -       return 0;
> -}
> -EXPORT_SYMBOL_GPL(devm_device_add_groups);
> -
>  static int device_add_attrs(struct device *dev)
>  {
>         const struct class *class = dev->class;
> diff --git a/include/linux/device.h b/include/linux/device.h
> index 66c13965153d..6dd087e4223d 100644
> --- a/include/linux/device.h
> +++ b/include/linux/device.h
> @@ -1164,8 +1164,6 @@ static inline void device_remove_group(struct device *dev,
>         return device_remove_groups(dev, groups);
>  }
>
> -int __must_check devm_device_add_groups(struct device *dev,
> -                                       const struct attribute_group **groups);
>  int __must_check devm_device_add_group(struct device *dev,
>                                        const struct attribute_group *grp);
>
> --
> 2.41.0
>
