Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20C916D1E09
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 12:28:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230526AbjCaK2L convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 31 Mar 2023 06:28:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231148AbjCaK1r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 06:27:47 -0400
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 264911C1C5
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 03:26:47 -0700 (PDT)
Received: by mail-ed1-f43.google.com with SMTP id r11so87717174edd.5
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 03:26:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680258405;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/PCBodl10M8oBahJ3K029lCqeQKgWx6B6OyjKnOTIYs=;
        b=QFf+BbT9yaeGkDHMWK5r7gGquhST+gGXM5HgO+A8zTlCpXjtPX6KQ24oIuJpGjnZkK
         KEFryBWuA8slOzACrO09cjDUxMYXZI1ElJrJHP2Gk9l+9eMcD+psVMrLsRa+qRDxAnbT
         EDMkzjqXh/bf6GYUlLVOec3W+RcMsJ66NXbAIx3x9Ttmidh/0z7Zz5cWPL9Ye3U6U4yN
         wqeqoHOihj0D8/35YqJeKvBT7OyfI+ljDmypTPv1FzwCNi6SQEoWz3nGdJYnYoZmSRdW
         059gIJAo0W1s5i2LR3GBqVH9T1dflvJG4rUvtriARggnauDYQxQ6ONzcQ2ijbRNf7eut
         pYAw==
X-Gm-Message-State: AAQBX9epJvA5rWsclgsnyLr/+LJrnelwIhQLqHduf8xPcsUqp6r7XBhT
        MZjdztJANUdGPW/JGLK1oxgvKJ+EQI4jOMBZZks=
X-Google-Smtp-Source: AKy350Y4+XlEaRQa+V03s9cu82qhFND7JgYo0OgdrEDrxaHj6skkZRl2OmzKa+XK38JUfUiwV6jNyac6XBFG2RxJrCY=
X-Received: by 2002:a17:906:37c8:b0:934:b5d6:14d0 with SMTP id
 o8-20020a17090637c800b00934b5d614d0mr14142381ejc.2.1680258405649; Fri, 31 Mar
 2023 03:26:45 -0700 (PDT)
MIME-Version: 1.0
References: <20230331093318.82288-1-gregkh@linuxfoundation.org>
In-Reply-To: <20230331093318.82288-1-gregkh@linuxfoundation.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 31 Mar 2023 12:26:34 +0200
Message-ID: <CAJZ5v0iczxyGP_11hS19D-zQnFgvdbDAhTbNC+ueNwNo9qi2fA@mail.gmail.com>
Subject: Re: [PATCH 1/7] driver core: core: move to use class_to_subsys()
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
> There are a number of places in core.c that need access to the private
> subsystem structure of struct class, so move them to use
> class_to_subsys() instead of accessing it directly.
>
> This requires exporting class_to_subsys() out of class.c, but keeping it
> local to the driver core.
>
> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Reviewed-by: Rafael J. Wysocki <rafael@kernel.org>

> ---
>  drivers/base/base.h  |   2 +
>  drivers/base/class.c |   2 +-
>  drivers/base/core.c  | 121 ++++++++++++++++++++++++++++---------------
>  3 files changed, 81 insertions(+), 44 deletions(-)
>
> diff --git a/drivers/base/base.h b/drivers/base/base.h
> index 2867ca4ee4ce..6296164bb7f3 100644
> --- a/drivers/base/base.h
> +++ b/drivers/base/base.h
> @@ -73,6 +73,8 @@ static inline void subsys_put(struct subsys_private *sp)
>                 kset_put(&sp->subsys);
>  }
>
> +struct subsys_private *class_to_subsys(const struct class *class);
> +
>  struct driver_private {
>         struct kobject kobj;
>         struct klist klist_devices;
> diff --git a/drivers/base/class.c b/drivers/base/class.c
> index 1f12bd5d56d9..68a6f9b56d19 100644
> --- a/drivers/base/class.c
> +++ b/drivers/base/class.c
> @@ -39,7 +39,7 @@ static struct kset *class_kset;
>   * NULL.  A call to subsys_put() must be done when finished with the pointer in
>   * order for it to be properly freed.
>   */
> -static struct subsys_private *class_to_subsys(const struct class *class)
> +struct subsys_private *class_to_subsys(const struct class *class)
>  {
>         struct subsys_private *sp = NULL;
>         struct kobject *kobj;
> diff --git a/drivers/base/core.c b/drivers/base/core.c
> index 89249be22161..e3bc34fcf779 100644
> --- a/drivers/base/core.c
> +++ b/drivers/base/core.c
> @@ -3149,8 +3149,8 @@ static const struct kobj_type class_dir_ktype = {
>         .child_ns_type  = class_dir_child_ns_type
>  };
>
> -static struct kobject *
> -class_dir_create_and_add(const struct class *class, struct kobject *parent_kobj)
> +static struct kobject *class_dir_create_and_add(struct subsys_private *sp,
> +                                               struct kobject *parent_kobj)
>  {
>         struct class_dir *dir;
>         int retval;
> @@ -3159,12 +3159,12 @@ class_dir_create_and_add(const struct class *class, struct kobject *parent_kobj)
>         if (!dir)
>                 return ERR_PTR(-ENOMEM);
>
> -       dir->class = class;
> +       dir->class = sp->class;
>         kobject_init(&dir->kobj, &class_dir_ktype);
>
> -       dir->kobj.kset = &class->p->glue_dirs;
> +       dir->kobj.kset = &sp->glue_dirs;
>
> -       retval = kobject_add(&dir->kobj, parent_kobj, "%s", class->name);
> +       retval = kobject_add(&dir->kobj, parent_kobj, "%s", sp->class->name);
>         if (retval < 0) {
>                 kobject_put(&dir->kobj);
>                 return ERR_PTR(retval);
> @@ -3177,9 +3177,10 @@ static DEFINE_MUTEX(gdp_mutex);
>  static struct kobject *get_device_parent(struct device *dev,
>                                          struct device *parent)
>  {
> +       struct subsys_private *sp = class_to_subsys(dev->class);
>         struct kobject *kobj = NULL;
>
> -       if (dev->class) {
> +       if (sp) {
>                 struct kobject *parent_kobj;
>                 struct kobject *k;
>
> @@ -3190,30 +3191,34 @@ static struct kobject *get_device_parent(struct device *dev,
>                  */
>                 if (parent == NULL)
>                         parent_kobj = virtual_device_parent(dev);
> -               else if (parent->class && !dev->class->ns_type)
> +               else if (parent->class && !dev->class->ns_type) {
> +                       subsys_put(sp);
>                         return &parent->kobj;
> -               else
> +               } else {
>                         parent_kobj = &parent->kobj;
> +               }
>
>                 mutex_lock(&gdp_mutex);
>
>                 /* find our class-directory at the parent and reference it */
> -               spin_lock(&dev->class->p->glue_dirs.list_lock);
> -               list_for_each_entry(k, &dev->class->p->glue_dirs.list, entry)
> +               spin_lock(&sp->glue_dirs.list_lock);
> +               list_for_each_entry(k, &sp->glue_dirs.list, entry)
>                         if (k->parent == parent_kobj) {
>                                 kobj = kobject_get(k);
>                                 break;
>                         }
> -               spin_unlock(&dev->class->p->glue_dirs.list_lock);
> +               spin_unlock(&sp->glue_dirs.list_lock);
>                 if (kobj) {
>                         mutex_unlock(&gdp_mutex);
> +                       subsys_put(sp);
>                         return kobj;
>                 }
>
>                 /* or create a new class-directory at the parent device */
> -               k = class_dir_create_and_add(dev->class, parent_kobj);
> +               k = class_dir_create_and_add(sp, parent_kobj);
>                 /* do not emit an uevent for this simple "glue" directory */
>                 mutex_unlock(&gdp_mutex);
> +               subsys_put(sp);
>                 return k;
>         }
>
> @@ -3236,10 +3241,23 @@ static struct kobject *get_device_parent(struct device *dev,
>  static inline bool live_in_glue_dir(struct kobject *kobj,
>                                     struct device *dev)
>  {
> -       if (!kobj || !dev->class ||
> -           kobj->kset != &dev->class->p->glue_dirs)
> +       struct subsys_private *sp;
> +       bool retval;
> +
> +       if (!kobj || !dev->class)
>                 return false;
> -       return true;
> +
> +       sp = class_to_subsys(dev->class);
> +       if (!sp)
> +               return false;
> +
> +       if (kobj->kset == &sp->glue_dirs)
> +               retval = true;
> +       else
> +               retval = false;
> +
> +       subsys_put(sp);
> +       return retval;
>  }
>
>  static inline struct kobject *get_glue_dir(struct device *dev)
> @@ -3336,6 +3354,7 @@ static void cleanup_glue_dir(struct device *dev, struct kobject *glue_dir)
>  static int device_add_class_symlinks(struct device *dev)
>  {
>         struct device_node *of_node = dev_of_node(dev);
> +       struct subsys_private *sp;
>         int error;
>
>         if (of_node) {
> @@ -3345,12 +3364,11 @@ static int device_add_class_symlinks(struct device *dev)
>                 /* An error here doesn't warrant bringing down the device */
>         }
>
> -       if (!dev->class)
> +       sp = class_to_subsys(dev->class);
> +       if (!sp)
>                 return 0;
>
> -       error = sysfs_create_link(&dev->kobj,
> -                                 &dev->class->p->subsys.kobj,
> -                                 "subsystem");
> +       error = sysfs_create_link(&dev->kobj, &sp->subsys.kobj, "subsystem");
>         if (error)
>                 goto out_devnode;
>
> @@ -3362,35 +3380,37 @@ static int device_add_class_symlinks(struct device *dev)
>         }
>
>         /* link in the class directory pointing to the device */
> -       error = sysfs_create_link(&dev->class->p->subsys.kobj,
> -                                 &dev->kobj, dev_name(dev));
> +       error = sysfs_create_link(&sp->subsys.kobj, &dev->kobj, dev_name(dev));
>         if (error)
>                 goto out_device;
> -
> -       return 0;
> +       goto exit;
>
>  out_device:
>         sysfs_remove_link(&dev->kobj, "device");
> -
>  out_subsys:
>         sysfs_remove_link(&dev->kobj, "subsystem");
>  out_devnode:
>         sysfs_remove_link(&dev->kobj, "of_node");
> +exit:
> +       subsys_put(sp);
>         return error;
>  }
>
>  static void device_remove_class_symlinks(struct device *dev)
>  {
> +       struct subsys_private *sp = class_to_subsys(dev->class);
> +
>         if (dev_of_node(dev))
>                 sysfs_remove_link(&dev->kobj, "of_node");
>
> -       if (!dev->class)
> +       if (!sp)
>                 return;
>
>         if (dev->parent && device_is_not_partition(dev))
>                 sysfs_remove_link(&dev->kobj, "device");
>         sysfs_remove_link(&dev->kobj, "subsystem");
> -       sysfs_delete_link(&dev->class->p->subsys.kobj, &dev->kobj, dev_name(dev));
> +       sysfs_delete_link(&sp->subsys.kobj, &dev->kobj, dev_name(dev));
> +       subsys_put(sp);
>  }
>
>  /**
> @@ -3499,6 +3519,7 @@ static int device_private_init(struct device *dev)
>   */
>  int device_add(struct device *dev)
>  {
> +       struct subsys_private *sp;
>         struct device *parent;
>         struct kobject *kobj;
>         struct class_interface *class_intf;
> @@ -3627,18 +3648,18 @@ int device_add(struct device *dev)
>                 klist_add_tail(&dev->p->knode_parent,
>                                &parent->p->klist_children);
>
> -       if (dev->class) {
> -               mutex_lock(&dev->class->p->mutex);
> +       sp = class_to_subsys(dev->class);
> +       if (sp) {
> +               mutex_lock(&sp->mutex);
>                 /* tie the class to the device */
> -               klist_add_tail(&dev->p->knode_class,
> -                              &dev->class->p->klist_devices);
> +               klist_add_tail(&dev->p->knode_class, &sp->klist_devices);
>
>                 /* notify any interfaces that the device is here */
> -               list_for_each_entry(class_intf,
> -                                   &dev->class->p->interfaces, node)
> +               list_for_each_entry(class_intf, &sp->interfaces, node)
>                         if (class_intf->add_dev)
>                                 class_intf->add_dev(dev, class_intf);
> -               mutex_unlock(&dev->class->p->mutex);
> +               mutex_unlock(&sp->mutex);
> +               subsys_put(sp);
>         }
>  done:
>         put_device(dev);
> @@ -3758,6 +3779,7 @@ EXPORT_SYMBOL_GPL(kill_device);
>   */
>  void device_del(struct device *dev)
>  {
> +       struct subsys_private *sp;
>         struct device *parent = dev->parent;
>         struct kobject *glue_dir = NULL;
>         struct class_interface *class_intf;
> @@ -3784,18 +3806,20 @@ void device_del(struct device *dev)
>                 device_remove_sys_dev_entry(dev);
>                 device_remove_file(dev, &dev_attr_dev);
>         }
> -       if (dev->class) {
> +
> +       sp = class_to_subsys(dev->class);
> +       if (sp) {
>                 device_remove_class_symlinks(dev);
>
> -               mutex_lock(&dev->class->p->mutex);
> +               mutex_lock(&sp->mutex);
>                 /* notify any interfaces that the device is now gone */
> -               list_for_each_entry(class_intf,
> -                                   &dev->class->p->interfaces, node)
> +               list_for_each_entry(class_intf, &sp->interfaces, node)
>                         if (class_intf->remove_dev)
>                                 class_intf->remove_dev(dev, class_intf);
>                 /* remove the device from the class list */
>                 klist_del(&dev->p->knode_class);
> -               mutex_unlock(&dev->class->p->mutex);
> +               mutex_unlock(&sp->mutex);
> +               subsys_put(sp);
>         }
>         device_remove_file(dev, &dev_attr_uevent);
>         device_remove_attrs(dev);
> @@ -4458,9 +4482,16 @@ int device_rename(struct device *dev, const char *new_name)
>         }
>
>         if (dev->class) {
> -               error = sysfs_rename_link_ns(&dev->class->p->subsys.kobj,
> -                                            kobj, old_device_name,
> +               struct subsys_private *sp = class_to_subsys(dev->class);
> +
> +               if (!sp) {
> +                       error = -EINVAL;
> +                       goto out;
> +               }
> +
> +               error = sysfs_rename_link_ns(&sp->subsys.kobj, kobj, old_device_name,
>                                              new_name, kobject_namespace(kobj));
> +               subsys_put(sp);
>                 if (error)
>                         goto out;
>         }
> @@ -4643,6 +4674,7 @@ int device_change_owner(struct device *dev, kuid_t kuid, kgid_t kgid)
>  {
>         int error;
>         struct kobject *kobj = &dev->kobj;
> +       struct subsys_private *sp;
>
>         dev = get_device(dev);
>         if (!dev)
> @@ -4685,10 +4717,13 @@ int device_change_owner(struct device *dev, kuid_t kuid, kgid_t kgid)
>          * directory entry for @dev to @kuid/@kgid. This ensures that the
>          * symlink shows the same permissions as its target.
>          */
> -       error = sysfs_link_change_owner(&dev->class->p->subsys.kobj, &dev->kobj,
> -                                       dev_name(dev), kuid, kgid);
> -       if (error)
> +       sp = class_to_subsys(dev->class);
> +       if (!sp) {
> +               error = -EINVAL;
>                 goto out;
> +       }
> +       error = sysfs_link_change_owner(&sp->subsys.kobj, &dev->kobj, dev_name(dev), kuid, kgid);
> +       subsys_put(sp);
>
>  out:
>         put_device(dev);
> --
> 2.40.0
>
