Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FEBC686E8B
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 19:59:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231620AbjBAS75 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 13:59:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229601AbjBAS74 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 13:59:56 -0500
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02FE546B7
        for <linux-kernel@vger.kernel.org>; Wed,  1 Feb 2023 10:59:55 -0800 (PST)
Received: by mail-ed1-f54.google.com with SMTP id k4so7964941edo.12
        for <linux-kernel@vger.kernel.org>; Wed, 01 Feb 2023 10:59:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RCdDJqiPyvlEgNaMuW56Bk3ntaEZh8ldmtaeG6ero6M=;
        b=GjrEzbLXIjIWlwNOZOfP2f5X9YoFo+2+Xr35YxzXAD2x5QSJgVdEZ7aM6QA36l64cB
         v9qq5VWRrVEMZgNPy4UUQLEO0vKpD39Ep14AVRoCCbEFQ4hHEj249QJt8JVQRoLbAEp2
         P41Du0FaICEl76xcka4IgUZPNz/wPKKk855e5DNsnPCEs+F+ufXCPK5cR9ocTcobuSaD
         1+89DBgpcZgINpF1BhTxr9+glSYIVNMwX8rG9F3gQKN6YHgtPjhDgTGX8AnXdkoVT3+2
         MNeQzEJdGqtcgIjwaPC5Hua3u5MRXSMxyYGvW6hEK4lIo2YjruvEJMOHEj/g4USL8/lS
         2zpQ==
X-Gm-Message-State: AO0yUKXKqE2ELiL9BEyNGAWxj8fYdwkB/d+RhNFGCbHrakTeeY7RcJ/W
        NTxsp3DWSkgCNtQblkzlcuTpLSyXf//EvWo660/Puvu8bfE=
X-Google-Smtp-Source: AK7set8j7OpX2sMskbgbKDUzkj8Qm0slEDDKLNtZf+xy/T0W8PA9VplyGooV6SAJNjUDILSVxtHszs1mZnvJLAgWL1s=
X-Received: by 2002:a50:c350:0:b0:4a2:56e7:178 with SMTP id
 q16-20020a50c350000000b004a256e70178mr974268edb.58.1675277993359; Wed, 01 Feb
 2023 10:59:53 -0800 (PST)
MIME-Version: 1.0
References: <20230201083349.4038660-1-gregkh@linuxfoundation.org>
In-Reply-To: <20230201083349.4038660-1-gregkh@linuxfoundation.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 1 Feb 2023 19:59:42 +0100
Message-ID: <CAJZ5v0h5=HRRQ9oEHEgm362WtPFGYkfQeQLh_g1V7qF2OiFgUg@mail.gmail.com>
Subject: Re: [PATCH] driver core: bus: move lock_class_key into dynamic structure
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>
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

On Wed, Feb 1, 2023 at 9:33 AM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> Move the lock_class_key structure out of struct bus_type and into the
> dynamic structure we create already for all bus_types registered with
> the kernel.  This saves on static space and removes one more writable
> field in struct bus_type.
>
> In the future, the same field can be moved out of the struct class logic
> because it shares this same private structure.
>
> Most everyone will never notice this change, as lockdep is not enabled
> in real systems so no memory or logic changes are happening for them.
>
> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

This looks reasonable to me, so

Acked-by: Rafael J. Wysocki <rafael@kernel.org>

> ---
>  drivers/base/base.h        | 2 ++
>  drivers/base/bus.c         | 5 ++++-
>  include/linux/device/bus.h | 1 -
>  3 files changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/base/base.h b/drivers/base/base.h
> index 2208af509ce8..0e806f641079 100644
> --- a/drivers/base/base.h
> +++ b/drivers/base/base.h
> @@ -52,6 +52,8 @@ struct subsys_private {
>
>         struct kset glue_dirs;
>         struct class *class;
> +
> +       struct lock_class_key lock_key;
>  };
>  #define to_subsys_private(obj) container_of_const(obj, struct subsys_private, subsys.kobj)
>
> diff --git a/drivers/base/bus.c b/drivers/base/bus.c
> index cf1b8f00b4c0..aa70b3a7d778 100644
> --- a/drivers/base/bus.c
> +++ b/drivers/base/bus.c
> @@ -154,6 +154,7 @@ static void bus_release(struct kobject *kobj)
>         struct subsys_private *priv = to_subsys_private(kobj);
>         struct bus_type *bus = priv->bus;
>
> +       lockdep_unregister_key(&priv->lock_key);
>         kfree(priv);
>         bus->p = NULL;
>  }
> @@ -743,7 +744,7 @@ int bus_register(struct bus_type *bus)
>  {
>         int retval;
>         struct subsys_private *priv;
> -       struct lock_class_key *key = &bus->lock_key;
> +       struct lock_class_key *key;
>
>         priv = kzalloc(sizeof(struct subsys_private), GFP_KERNEL);
>         if (!priv)
> @@ -785,6 +786,8 @@ int bus_register(struct bus_type *bus)
>         }
>
>         INIT_LIST_HEAD(&priv->interfaces);
> +       key = &priv->lock_key;
> +       lockdep_register_key(key);
>         __mutex_init(&priv->mutex, "subsys mutex", key);
>         klist_init(&priv->klist_devices, klist_devices_get, klist_devices_put);
>         klist_init(&priv->klist_drivers, NULL, NULL);
> diff --git a/include/linux/device/bus.h b/include/linux/device/bus.h
> index 87e4d029c915..e3094db1e9fa 100644
> --- a/include/linux/device/bus.h
> +++ b/include/linux/device/bus.h
> @@ -112,7 +112,6 @@ struct bus_type {
>         const struct iommu_ops *iommu_ops;
>
>         struct subsys_private *p;
> -       struct lock_class_key lock_key;
>
>         bool need_parent_lock;
>  };
> --
> 2.39.1
>
