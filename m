Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 429896C7EFD
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 14:42:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231436AbjCXNmT convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 24 Mar 2023 09:42:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbjCXNmQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 09:42:16 -0400
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07345198D
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 06:42:15 -0700 (PDT)
Received: by mail-ed1-f54.google.com with SMTP id r11so8135130edd.5
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 06:42:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679665333;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yf2jfs7sDF2bJ427jfO5KVHMY/WrjqhV46BMZGPivnw=;
        b=2YZT+WYD8IDbUliAQGdmHPn20q190Km3FuzYPSkJvjTdxI5WsO9tNNEMSmTu5uAOpK
         eHzZu6Ie40fVHMVyPa1wY3odZoNc/1pFlVls9E5NluGylaKuCnhMsOe+hy3m6eX9dSqR
         7YRVHwq9cUzyG7mc3KR4h0QEc3x25qfj+WmuBQ1xhvBDWzPU1gKy+sZMMuSC3WXm47gn
         ehBQ5h84Gob82xCu7qRZMLmaxTuD2sTrU9c7C1zy3onSSgU9SAsmh5K+XCHDubrA3T+n
         YLZwFqvC5UdtZqD2ezFonHv7h8QSnTDf9mCQ6OHpIUBJ6B+0pPuqaFSmuEoQioincqO9
         Va8g==
X-Gm-Message-State: AAQBX9fPciN0BUJ0SNzDdB1sbnmZjFtW2xPSWGfVpNs9BZPwFLxw9LqV
        iG/6E0WcxSfa8kIXUlsduUrITp7ShSU5iTk5UBR7eYUHn2w=
X-Google-Smtp-Source: AKy350aSWHn+oEBgJqiZMvIz9ZUot+iG/4lvjSvKbO+Lqo/g68dO9QbmNvqhNspOqF1tQjnjehhpj4/XcBgEMlTIpNI=
X-Received: by 2002:a50:d49e:0:b0:502:148d:9e1e with SMTP id
 s30-20020a50d49e000000b00502148d9e1emr1489154edi.3.1679665333554; Fri, 24 Mar
 2023 06:42:13 -0700 (PDT)
MIME-Version: 1.0
References: <20230324100132.1633647-1-gregkh@linuxfoundation.org>
In-Reply-To: <20230324100132.1633647-1-gregkh@linuxfoundation.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 24 Mar 2023 14:42:02 +0100
Message-ID: <CAJZ5v0hMUgacfMTgsrYXHjKFJHqajJsR_unorcVSgQ7YzBm1nw@mail.gmail.com>
Subject: Re: [PATCH 1/2] driver core: class: use lock_class_key already
 present in struct subsys_private
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

On Fri, Mar 24, 2023 at 11:01 AM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> In commit 37e98d9bedb5 ("driver core: bus: move lock_class_key into
> dynamic structure"), we moved the lock_class_key into the internal
> structure shared by busses and classes, but only used it for buses.
>
> Move the class code to use this structure as it is already present and
> being allocated, instead of the statically allocated on-the-stack
> variable that class_create() was using as part of a macro wrapper around
> the core function call.
>
> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Reviewed-by: Rafael J. Wysocki <rafael@kernel.org>

> ---
>  drivers/base/class.c         | 15 +++++++++------
>  include/linux/device/class.h | 36 ++----------------------------------
>  2 files changed, 11 insertions(+), 40 deletions(-)
>
> diff --git a/drivers/base/class.c b/drivers/base/class.c
> index 3d65221b0dcb..dbaeb79ae917 100644
> --- a/drivers/base/class.c
> +++ b/drivers/base/class.c
> @@ -154,9 +154,10 @@ static void class_remove_groups(struct class *cls,
>         return sysfs_remove_groups(&cls->p->subsys.kobj, groups);
>  }
>
> -int __class_register(struct class *cls, struct lock_class_key *key)
> +int class_register(struct class *cls)
>  {
>         struct subsys_private *cp;
> +       struct lock_class_key *key;
>         int error;
>
>         pr_debug("device class '%s': registering\n", cls->name);
> @@ -167,6 +168,8 @@ int __class_register(struct class *cls, struct lock_class_key *key)
>         klist_init(&cp->klist_devices, klist_class_dev_get, klist_class_dev_put);
>         INIT_LIST_HEAD(&cp->interfaces);
>         kset_init(&cp->glue_dirs);
> +       key = &cp->lock_key;
> +       lockdep_register_key(key);
>         __mutex_init(&cp->mutex, "subsys mutex", key);
>         error = kobject_set_name(&cp->subsys.kobj, "%s", cls->name);
>         if (error) {
> @@ -201,7 +204,7 @@ int __class_register(struct class *cls, struct lock_class_key *key)
>         cls->p = NULL;
>         return error;
>  }
> -EXPORT_SYMBOL_GPL(__class_register);
> +EXPORT_SYMBOL_GPL(class_register);
>
>  void class_unregister(struct class *cls)
>  {
> @@ -218,7 +221,7 @@ static void class_create_release(struct class *cls)
>  }
>
>  /**
> - * __class_create - create a struct class structure
> + * class_create - create a struct class structure
>   * @name: pointer to a string for the name of this class.
>   * @key: the lock_class_key for this class; used by mutex lock debugging
>   *
> @@ -230,7 +233,7 @@ static void class_create_release(struct class *cls)
>   * Note, the pointer created here is to be destroyed when finished by
>   * making a call to class_destroy().
>   */
> -struct class *__class_create(const char *name, struct lock_class_key *key)
> +struct class *class_create(const char *name)
>  {
>         struct class *cls;
>         int retval;
> @@ -244,7 +247,7 @@ struct class *__class_create(const char *name, struct lock_class_key *key)
>         cls->name = name;
>         cls->class_release = class_create_release;
>
> -       retval = __class_register(cls, key);
> +       retval = class_register(cls);
>         if (retval)
>                 goto error;
>
> @@ -254,7 +257,7 @@ struct class *__class_create(const char *name, struct lock_class_key *key)
>         kfree(cls);
>         return ERR_PTR(retval);
>  }
> -EXPORT_SYMBOL_GPL(__class_create);
> +EXPORT_SYMBOL_GPL(class_create);
>
>  /**
>   * class_destroy - destroys a struct class structure
> diff --git a/include/linux/device/class.h b/include/linux/device/class.h
> index 75c1451fcc63..03d2f99f84c5 100644
> --- a/include/linux/device/class.h
> +++ b/include/linux/device/class.h
> @@ -82,18 +82,9 @@ struct class_dev_iter {
>
>  extern struct kobject *sysfs_dev_block_kobj;
>  extern struct kobject *sysfs_dev_char_kobj;
> -extern int __must_check __class_register(struct class *class,
> -                                        struct lock_class_key *key);
> +extern int __must_check class_register(struct class *class);
>  extern void class_unregister(struct class *class);
>
> -/* This is a #define to keep the compiler from merging different
> - * instances of the __key variable */
> -#define class_register(class)                  \
> -({                                             \
> -       static struct lock_class_key __key;     \
> -       __class_register(class, &__key);        \
> -})
> -
>  struct class_compat;
>  struct class_compat *class_compat_register(const char *name);
>  void class_compat_unregister(struct class_compat *cls);
> @@ -246,30 +237,7 @@ struct class_interface {
>  extern int __must_check class_interface_register(struct class_interface *);
>  extern void class_interface_unregister(struct class_interface *);
>
> -extern struct class * __must_check __class_create(const char *name,
> -                                                 struct lock_class_key *key);
> +extern struct class * __must_check class_create(const char *name);
>  extern void class_destroy(struct class *cls);
>
> -/* This is a #define to keep the compiler from merging different
> - * instances of the __key variable */
> -
> -/**
> - * class_create - create a struct class structure
> - * @name: pointer to a string for the name of this class.
> - *
> - * This is used to create a struct class pointer that can then be used
> - * in calls to device_create().
> - *
> - * Returns &struct class pointer on success, or ERR_PTR() on error.
> - *
> - * Note, the pointer created here is to be destroyed when finished by
> - * making a call to class_destroy().
> - */
> -#define class_create(name)                     \
> -({                                             \
> -       static struct lock_class_key __key;     \
> -       __class_create(name, &__key);           \
> -})
> -
> -
>  #endif /* _DEVICE_CLASS_H_ */
> --
> 2.40.0
>
