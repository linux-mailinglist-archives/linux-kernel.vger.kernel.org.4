Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E79D66B8148
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 19:58:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230092AbjCMS6X convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 13 Mar 2023 14:58:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230167AbjCMS6T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 14:58:19 -0400
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0D1FEF83;
        Mon, 13 Mar 2023 11:58:15 -0700 (PDT)
Received: by mail-ed1-f45.google.com with SMTP id k10so52646190edk.13;
        Mon, 13 Mar 2023 11:58:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678733894;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZrJMGyZiz1YxkUM5EOo9zSSpVZzirClrJWMje4LXrg8=;
        b=pELetmQmHzNUggIDmefnqvbkqe0r8GpfNUH19vjnmv7bJHdQ2blGTwh1gAxDY1+xpq
         4N5bPDiAKaMQhJxkJIQCvyFGkZ8L0yOlTQTfDWfCNibr7qAIc2keo7fT9YXLu7TEzFg0
         jctfTuUlvMMElQ2vM9Wuw74kuI/9NjEWaDnx+5au8Jg+iPA0o2ns20/uvrHOSDvETJQg
         zGoeTmB9X6FNpI7sWMQg6bij8JqKn1p/WsNKZ434205YeST/ceaW0xAAovtBU0uL2X49
         HH4wxdJhRfrb31O+J2TykDIubanHBIkgJ/jW9ixaLF/PiyN8W8L3aCgIVvKDvNjhdV2Z
         2YNw==
X-Gm-Message-State: AO0yUKWkpbz0zy6Mz5wA9jSAfnT4gRWOg3iM26S5KknlYA5m/inznzs3
        5I8O/PG/sAspoaFLKuvm1TcMGw6AlLKrMYrp954=
X-Google-Smtp-Source: AK7set8eLAw0CtAP6wFZmMcmC4AM87iftZeTG7RENvhx7p4r7SyTatWUi5M0+TkIFcuSx0oLQWP/m+2dtLYPy3L1SuE=
X-Received: by 2002:a17:907:7b92:b0:8b1:3540:7632 with SMTP id
 ne18-20020a1709077b9200b008b135407632mr7814817ejc.2.1678733894011; Mon, 13
 Mar 2023 11:58:14 -0700 (PDT)
MIME-Version: 1.0
References: <20230313182918.1312597-1-gregkh@linuxfoundation.org> <20230313182918.1312597-6-gregkh@linuxfoundation.org>
In-Reply-To: <20230313182918.1312597-6-gregkh@linuxfoundation.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 13 Mar 2023 19:58:02 +0100
Message-ID: <CAJZ5v0hRScLjW27k_rHZ1jnLyn7B3O26oP9Jd3AwDL97VSJ8tQ@mail.gmail.com>
Subject: Re: [PATCH 06/36] cpuidle: move to use bus_get_dev_root()
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, rafael@kernel.org,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 13, 2023 at 7:30 PM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> Direct access to the struct bus_type dev_root pointer is going away soon
> so replace that with a call to bus_get_dev_root() instead, which is what
> it is there for.
>
> This allows us to clean up the cpuidle_add_interface() call a bit as it
> was only called in one place, with the same argument so just put that
> into the function itself.  Note that cpuidle_remove_interface() should
> also probably be removed in the future as there are no callers of it for
> some reason.
>
> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
> Cc: linux-pm@vger.kernel.org
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
> Note, this is a patch that is a prepatory cleanup as part of a larger
> series of patches that is working on resolving some old driver core
> design mistakes.  It will build and apply cleanly on top of 6.3-rc2 on
> its own, but I'd prefer if I could take it through my driver-core tree
> so that the driver core changes can be taken through there for 6.4-rc1.
>
>  drivers/cpuidle/cpuidle.c |  2 +-
>  drivers/cpuidle/cpuidle.h |  2 +-
>  drivers/cpuidle/sysfs.c   | 12 +++++++++---
>  3 files changed, 11 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/cpuidle/cpuidle.c b/drivers/cpuidle/cpuidle.c
> index 0b00f21cefe3..8e929f6602ce 100644
> --- a/drivers/cpuidle/cpuidle.c
> +++ b/drivers/cpuidle/cpuidle.c
> @@ -808,7 +808,7 @@ static int __init cpuidle_init(void)
>         if (cpuidle_disabled())
>                 return -ENODEV;
>
> -       return cpuidle_add_interface(cpu_subsys.dev_root);
> +       return cpuidle_add_interface();
>  }
>
>  module_param(off, int, 0444);
> diff --git a/drivers/cpuidle/cpuidle.h b/drivers/cpuidle/cpuidle.h
> index 9f336af17fa6..52701d9588f1 100644
> --- a/drivers/cpuidle/cpuidle.h
> +++ b/drivers/cpuidle/cpuidle.h
> @@ -30,7 +30,7 @@ extern int cpuidle_switch_governor(struct cpuidle_governor *gov);
>
>  struct device;
>
> -extern int cpuidle_add_interface(struct device *dev);
> +extern int cpuidle_add_interface(void);
>  extern void cpuidle_remove_interface(struct device *dev);
>  extern int cpuidle_add_device_sysfs(struct cpuidle_device *device);
>  extern void cpuidle_remove_device_sysfs(struct cpuidle_device *device);
> diff --git a/drivers/cpuidle/sysfs.c b/drivers/cpuidle/sysfs.c
> index 48948b171749..84e4946f1072 100644
> --- a/drivers/cpuidle/sysfs.c
> +++ b/drivers/cpuidle/sysfs.c
> @@ -119,11 +119,17 @@ static struct attribute_group cpuidle_attr_group = {
>
>  /**
>   * cpuidle_add_interface - add CPU global sysfs attributes
> - * @dev: the target device
>   */
> -int cpuidle_add_interface(struct device *dev)
> +int cpuidle_add_interface(void)
>  {
> -       return sysfs_create_group(&dev->kobj, &cpuidle_attr_group);
> +       struct device *dev_root = bus_get_dev_root(&cpu_subsys);
> +       int retval = -EINVAL;
> +
> +       if (dev_root) {
> +               retval = sysfs_create_group(&dev_root->kobj, &cpuidle_attr_group);
> +               put_device(dev_root);
> +       }
> +       return retval;

I would prefer

  if (!dev_root)
          return -EINVAL;

  retval = sysfs_create_group(&dev_root->kobj, &cpuidle_attr_group);
  put_device(dev_root);
  return retval;

assuming that successful group creation will bump up the reference
counter of dev_root.
