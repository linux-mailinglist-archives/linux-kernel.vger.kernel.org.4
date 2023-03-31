Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C06CD6D22F8
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 16:50:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232929AbjCaOur convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 31 Mar 2023 10:50:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232926AbjCaOul (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 10:50:41 -0400
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E068020338
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 07:50:25 -0700 (PDT)
Received: by mail-ed1-f54.google.com with SMTP id h8so90635990ede.8
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 07:50:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680274224;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UTXnU7CzWhSdy7xcFiq1ngqYZWnk1gKS2NX6CEmWaSA=;
        b=ip8dqZEEy6ekROcnT/Q7jlZpR7e1u/+mr899z33WqVbCFwuDKOg2xX2RoFIB6Ngq0z
         UR9b4ZnjLF6GWNUo6T3HAPn5l0fadHag2xFS3iagxO45QsOE6HCu+vyMDqdI1JgU5gV3
         C2U5jMLK8bDhGQijIFQm9FvWKGrMWh5Db+f3NBA/5nBcf0kGbKRuG/TGCcyoMk2pwdS9
         gTJytIsSkaX9iSEiQ8VxArzHItV6NtWYBILq0HdfmV36MZZQN4YoigsQMjvpW2KXGV+h
         C+e9lmZDHeNiDkPyhsnRmmkvp0H5KNPswHKzVD/HaICRpogVsk1CcVJybJNyarzA7pD/
         KY/w==
X-Gm-Message-State: AAQBX9dTcukRAxWUcdmTs1Y4wHarHdZh8uvW4OWxLILoX5dPqi8NTE8p
        6E+3TKkLBhEjX5W8qMfQFlt1zGJyBChXs/WrjSc=
X-Google-Smtp-Source: AKy350ZdUeEr7hZV69Ik1/+NaicU9SIP4y3RiKeyXKDmozabrvDZ4g4Q6NgVILuMXOYgcTVzNs4YLcu0QkPBf0nULvU=
X-Received: by 2002:a50:9f82:0:b0:4fa:3c0b:74b with SMTP id
 c2-20020a509f82000000b004fa3c0b074bmr13875145edf.3.1680274224285; Fri, 31 Mar
 2023 07:50:24 -0700 (PDT)
MIME-Version: 1.0
References: <20230331093318.82288-1-gregkh@linuxfoundation.org> <20230331093318.82288-5-gregkh@linuxfoundation.org>
In-Reply-To: <20230331093318.82288-5-gregkh@linuxfoundation.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 31 Mar 2023 16:50:13 +0200
Message-ID: <CAJZ5v0jj_Jus-8wacxu4GdpvDVPJZaWA+ZdNfW2BgoCJxcunVw@mail.gmail.com>
Subject: Re: [PATCH 5/7] driver core: class: remove dev_kobj from struct class
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=0.5 required=5.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
        FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 31, 2023 at 11:33 AM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> The dev_kobj field in struct class is now only written to, but never
> read from, so it can be removed as it is useless.
>
> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Acked-by: Rafael J. Wysocki <rafael@kernel.org>

> ---
>  block/genhd.c                | 1 -
>  drivers/base/class.c         | 4 ----
>  include/linux/device/class.h | 2 --
>  3 files changed, 7 deletions(-)
>
> diff --git a/block/genhd.c b/block/genhd.c
> index e1e1230b1b9f..af7208a37c53 100644
> --- a/block/genhd.c
> +++ b/block/genhd.c
> @@ -899,7 +899,6 @@ static int __init genhd_device_init(void)
>  {
>         int error;
>
> -       block_class.dev_kobj = sysfs_dev_block_kobj;
>         error = class_register(&block_class);
>         if (unlikely(error))
>                 return error;
> diff --git a/drivers/base/class.c b/drivers/base/class.c
> index fcfb295363cc..06b96d6faa19 100644
> --- a/drivers/base/class.c
> +++ b/drivers/base/class.c
> @@ -197,10 +197,6 @@ int class_register(struct class *cls)
>                 return error;
>         }
>
> -       /* set the default /sys/dev directory for devices of this class */
> -       if (!cls->dev_kobj)
> -               cls->dev_kobj = sysfs_dev_char_kobj;
> -
>         cp->subsys.kobj.kset = class_kset;
>         cp->subsys.kobj.ktype = &class_ktype;
>         cp->class = cls;
> diff --git a/include/linux/device/class.h b/include/linux/device/class.h
> index f7aad64e256a..e946642c314e 100644
> --- a/include/linux/device/class.h
> +++ b/include/linux/device/class.h
> @@ -27,7 +27,6 @@ struct fwnode_handle;
>   * @name:      Name of the class.
>   * @class_groups: Default attributes of this class.
>   * @dev_groups:        Default attributes of the devices that belong to the class.
> - * @dev_kobj:  The kobject that represents this class and links it into the hierarchy.
>   * @dev_uevent:        Called when a device is added, removed from this class, or a
>   *             few other things that generate uevents to add the environment
>   *             variables.
> @@ -55,7 +54,6 @@ struct class {
>
>         const struct attribute_group    **class_groups;
>         const struct attribute_group    **dev_groups;
> -       struct kobject                  *dev_kobj;
>
>         int (*dev_uevent)(const struct device *dev, struct kobj_uevent_env *env);
>         char *(*devnode)(const struct device *dev, umode_t *mode);
> --
> 2.40.0
>
