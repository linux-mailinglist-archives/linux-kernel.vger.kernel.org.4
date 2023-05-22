Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A81A70C5A4
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 21:03:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233652AbjEVTCw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 15:02:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229620AbjEVTCt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 15:02:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D4E5B0;
        Mon, 22 May 2023 12:02:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A91D7626C8;
        Mon, 22 May 2023 19:02:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08262C433EF;
        Mon, 22 May 2023 19:02:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684782166;
        bh=ZMwvqTd1EAdihRUe1av1l8Jc4m/dK/xO7RTvtggqCuk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ImfZbSaphIr/rDzMYg127hHzfmG+Av0aZkNXJjwWElRtkOCN0gNPbE1hnz1nv+rBS
         bPX4BWxzI2XwqkgA4UbE9lQbazaNYBJ6xKwY74486AgcnEmxrrBA9a3wtpg4u0zdpI
         akiB1M04RCLON3Lk0R2oSEs/BpQJFMeXxYtKItFHCvW0RZ/78pwji6HE+E4P6Bs73b
         9J4o+zT2RwSKEop/sHjIl2PvKckiac9j2t9EXQ85I5kW0bNOLkZHAUI+jBbxVlpQQ/
         k1jAdJqqddIfCcudQTcILC23PbuzaBfXKKkv37J/roFrMdtVc6YbzRfYARjYsMsP0X
         URdd0FqOLxUUQ==
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2af278ca45eso41376841fa.1;
        Mon, 22 May 2023 12:02:45 -0700 (PDT)
X-Gm-Message-State: AC+VfDyfO8aLQffhGYXJV4H0SRNbxGSwO8m4GuZal7Q/WKTYKhybj1Gw
        YukOROrSk/yysLg8qM2UbuxcSb4LshrmSf3BkMY=
X-Google-Smtp-Source: ACHHUZ75BnwCyfdglkOYfRxt2j7pnMhpg1HF7UnmkDf/SfeVyz2PnLijgC5SCZy2mecejUxBCcxDO3qe8+5zzTbJ0wM=
X-Received: by 2002:a2e:96d2:0:b0:2ad:ce08:7a2b with SMTP id
 d18-20020a2e96d2000000b002adce087a2bmr4181484ljj.22.1684782163879; Mon, 22
 May 2023 12:02:43 -0700 (PDT)
MIME-Version: 1.0
References: <20230522133225.2983667-1-yukuai1@huaweicloud.com>
In-Reply-To: <20230522133225.2983667-1-yukuai1@huaweicloud.com>
From:   Song Liu <song@kernel.org>
Date:   Mon, 22 May 2023 12:02:31 -0700
X-Gmail-Original-Message-ID: <CAPhsuW7DEZFbzGOThwvZaTgdJdOhYZy2QHRUPUPr=_yYN=wCbQ@mail.gmail.com>
Message-ID: <CAPhsuW7DEZFbzGOThwvZaTgdJdOhYZy2QHRUPUPr=_yYN=wCbQ@mail.gmail.com>
Subject: Re: [PATCH v2] md: fix duplicate filename for rdev
To:     Yu Kuai <yukuai1@huaweicloud.com>
Cc:     neilb@suse.de, akpm@linux-foundation.org,
        linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
        yukuai3@huawei.com, yi.zhang@huawei.com, yangerkun@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 22, 2023 at 6:35=E2=80=AFAM Yu Kuai <yukuai1@huaweicloud.com> w=
rote:
>
> From: Yu Kuai <yukuai3@huawei.com>
>
> commit 5792a2856a63 ("[PATCH] md: avoid a deadlock when removing a device
> from an md array via sysfs") delay the deleting of rdev, however, this
> introduce a window that rdev can be added again while the deleting is
> not done yet, and sysfs will complain about duplicate filename.
>
> Follow up patches try to fix this problem by flush workqueue, however,
> flush_rdev_wq() is just dead code, the progress in
> md_kick_rdev_from_array():
>
> 1) list_del_rcu(&rdev->same_set);
> 2) synchronize_rcu();
> 3) queue_work(md_rdev_misc_wq, &rdev->del_work);
>
> So in flush_rdev_wq(), if rdev is found in the list, work_pending() can
> never pass, in the meantime, if work is queued, then rdev can never be
> found in the list.
>
> flush_rdev_wq() can be replaced by flush_workqueue() directly, however,
> this approach is not good:
> - the workqueue is global, this synchronization for all raid disks is
>   not necessary.
> - flush_workqueue can't be called under 'reconfig_mutex', there is still
>   a small window between flush_workqueue() and mddev_lock() that other
>   context can queue new work, hence the problem is not solved completely.
>
> sysfs already have apis to support delete itself through writer, and
> these apis, specifically sysfs_break/unbreak_active_protection(), is used
> to support deleting rdev synchronously. Therefore, the above commit can b=
e
> reverted, and sysfs duplicate filename can be avoided.
>
> A new mdadm regression test is proposed as well.
>
> Link: https://lore.kernel.org/linux-raid/20230428062845.1975462-1-yukuai1=
@huaweicloud.com/
> Fixes: 5792a2856a63 ("[PATCH] md: avoid a deadlock when removing a device=
 from an md array via sysfs")
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>

We got build time warning with this patch:

drivers/md/md.c:90:33: warning: =E2=80=98md_rdev_misc_wq=E2=80=99 defined b=
ut not used
[-Wunused-variable]
 static struct workqueue_struct *md_rdev_misc_wq;
                                 ^~~~~~~~~~~~~~~

Thanks,
Song

> ---
> Changes in v2:
>  - rebase from the latest md-next branch
>
>  drivers/md/md.c | 84 +++++++++++++++++++++++++------------------------
>  drivers/md/md.h |  8 +++++
>  2 files changed, 51 insertions(+), 41 deletions(-)
>
> diff --git a/drivers/md/md.c b/drivers/md/md.c
> index 7455bc9d8498..cafb457d614c 100644
> --- a/drivers/md/md.c
> +++ b/drivers/md/md.c
> @@ -92,6 +92,7 @@ static struct workqueue_struct *md_rdev_misc_wq;
>  static int remove_and_add_spares(struct mddev *mddev,
>                                  struct md_rdev *this);
>  static void mddev_detach(struct mddev *mddev);
> +static void export_rdev(struct md_rdev *rdev);
>
>  /*
>   * Default number of read corrections we'll attempt on an rdev
> @@ -643,9 +644,11 @@ void mddev_init(struct mddev *mddev)
>  {
>         mutex_init(&mddev->open_mutex);
>         mutex_init(&mddev->reconfig_mutex);
> +       mutex_init(&mddev->delete_mutex);
>         mutex_init(&mddev->bitmap_info.mutex);
>         INIT_LIST_HEAD(&mddev->disks);
>         INIT_LIST_HEAD(&mddev->all_mddevs);
> +       INIT_LIST_HEAD(&mddev->deleting);
>         timer_setup(&mddev->safemode_timer, md_safemode_timeout, 0);
>         atomic_set(&mddev->active, 1);
>         atomic_set(&mddev->openers, 0);
> @@ -747,6 +750,23 @@ static void mddev_free(struct mddev *mddev)
>
>  static const struct attribute_group md_redundancy_group;
>
> +static void md_free_rdev(struct mddev *mddev)
> +{
> +       struct md_rdev *rdev;
> +       struct md_rdev *tmp;
> +
> +       if (list_empty_careful(&mddev->deleting))
> +               return;
> +
> +       mutex_lock(&mddev->delete_mutex);
> +       list_for_each_entry_safe(rdev, tmp, &mddev->deleting, same_set) {
> +               list_del_init(&rdev->same_set);
> +               kobject_del(&rdev->kobj);
> +               export_rdev(rdev);
> +       }
> +       mutex_unlock(&mddev->delete_mutex);
> +}
> +
>  void mddev_unlock(struct mddev *mddev)
>  {
>         if (mddev->to_remove) {
> @@ -788,6 +808,8 @@ void mddev_unlock(struct mddev *mddev)
>         } else
>                 mutex_unlock(&mddev->reconfig_mutex);
>
> +       md_free_rdev(mddev);
> +
>         /* As we've dropped the mutex we need a spinlock to
>          * make sure the thread doesn't disappear
>          */
> @@ -2428,13 +2450,6 @@ static int bind_rdev_to_array(struct md_rdev *rdev=
, struct mddev *mddev)
>         return err;
>  }
>
> -static void rdev_delayed_delete(struct work_struct *ws)
> -{
> -       struct md_rdev *rdev =3D container_of(ws, struct md_rdev, del_wor=
k);
> -       kobject_del(&rdev->kobj);
> -       kobject_put(&rdev->kobj);
> -}
> -
>  void md_autodetect_dev(dev_t dev);
>
>  static void export_rdev(struct md_rdev *rdev)
> @@ -2452,6 +2467,8 @@ static void export_rdev(struct md_rdev *rdev)
>
>  static void md_kick_rdev_from_array(struct md_rdev *rdev)
>  {
> +       struct mddev *mddev =3D rdev->mddev;
> +
>         bd_unlink_disk_holder(rdev->bdev, rdev->mddev->gendisk);
>         list_del_rcu(&rdev->same_set);
>         pr_debug("md: unbind<%pg>\n", rdev->bdev);
> @@ -2465,15 +2482,17 @@ static void md_kick_rdev_from_array(struct md_rde=
v *rdev)
>         rdev->sysfs_unack_badblocks =3D NULL;
>         rdev->sysfs_badblocks =3D NULL;
>         rdev->badblocks.count =3D 0;
> -       /* We need to delay this, otherwise we can deadlock when
> -        * writing to 'remove' to "dev/state".  We also need
> -        * to delay it due to rcu usage.
> -        */
> +
>         synchronize_rcu();
> -       INIT_WORK(&rdev->del_work, rdev_delayed_delete);
> -       kobject_get(&rdev->kobj);
> -       queue_work(md_rdev_misc_wq, &rdev->del_work);
> -       export_rdev(rdev);
> +
> +       /*
> +        * kobject_del() will wait for all in progress writers to be done=
, where
> +        * reconfig_mutex is held, hence it can't be called under
> +        * reconfig_mutex and it's delayed to mddev_unlock().
> +        */
> +       mutex_lock(&mddev->delete_mutex);
> +       list_add(&rdev->same_set, &mddev->deleting);
> +       mutex_unlock(&mddev->delete_mutex);
>  }
>
>  static void export_array(struct mddev *mddev)
> @@ -3541,6 +3560,7 @@ rdev_attr_store(struct kobject *kobj, struct attrib=
ute *attr,
>  {
>         struct rdev_sysfs_entry *entry =3D container_of(attr, struct rdev=
_sysfs_entry, attr);
>         struct md_rdev *rdev =3D container_of(kobj, struct md_rdev, kobj)=
;
> +       struct kernfs_node *kn =3D NULL;
>         ssize_t rv;
>         struct mddev *mddev =3D rdev->mddev;
>
> @@ -3548,6 +3568,10 @@ rdev_attr_store(struct kobject *kobj, struct attri=
bute *attr,
>                 return -EIO;
>         if (!capable(CAP_SYS_ADMIN))
>                 return -EACCES;
> +
> +       if (entry->store =3D=3D state_store && cmd_match(page, "remove"))
> +               kn =3D sysfs_break_active_protection(kobj, attr);
> +
>         rv =3D mddev ? mddev_lock(mddev) : -ENODEV;
>         if (!rv) {
>                 if (rdev->mddev =3D=3D NULL)
> @@ -3556,6 +3580,10 @@ rdev_attr_store(struct kobject *kobj, struct attri=
bute *attr,
>                         rv =3D entry->store(rdev, page, length);
>                 mddev_unlock(mddev);
>         }
> +
> +       if (kn)
> +               sysfs_unbreak_active_protection(kn);
> +
>         return rv;
>  }
>
> @@ -4479,20 +4507,6 @@ null_show(struct mddev *mddev, char *page)
>         return -EINVAL;
>  }
>
> -/* need to ensure rdev_delayed_delete() has completed */
> -static void flush_rdev_wq(struct mddev *mddev)
> -{
> -       struct md_rdev *rdev;
> -
> -       rcu_read_lock();
> -       rdev_for_each_rcu(rdev, mddev)
> -               if (work_pending(&rdev->del_work)) {
> -                       flush_workqueue(md_rdev_misc_wq);
> -                       break;
> -               }
> -       rcu_read_unlock();
> -}
> -
>  static ssize_t
>  new_dev_store(struct mddev *mddev, const char *buf, size_t len)
>  {
> @@ -4520,7 +4534,6 @@ new_dev_store(struct mddev *mddev, const char *buf,=
 size_t len)
>             minor !=3D MINOR(dev))
>                 return -EOVERFLOW;
>
> -       flush_rdev_wq(mddev);
>         err =3D mddev_lock(mddev);
>         if (err)
>                 return err;
> @@ -5590,7 +5603,6 @@ struct mddev *md_alloc(dev_t dev, char *name)
>          * removed (mddev_delayed_delete).
>          */
>         flush_workqueue(md_misc_wq);
> -       flush_workqueue(md_rdev_misc_wq);
>
>         mutex_lock(&disks_mutex);
>         mddev =3D mddev_alloc(dev);
> @@ -7553,9 +7565,6 @@ static int md_ioctl(struct block_device *bdev, fmod=
e_t mode,
>
>         }
>
> -       if (cmd =3D=3D ADD_NEW_DISK || cmd =3D=3D HOT_ADD_DISK)
> -               flush_rdev_wq(mddev);
> -
>         if (cmd =3D=3D HOT_REMOVE_DISK)
>                 /* need to ensure recovery thread has run */
>                 wait_event_interruptible_timeout(mddev->sb_wait,
> @@ -9618,10 +9627,6 @@ static int __init md_init(void)
>         if (!md_misc_wq)
>                 goto err_misc_wq;
>
> -       md_rdev_misc_wq =3D alloc_workqueue("md_rdev_misc", 0, 0);
> -       if (!md_rdev_misc_wq)
> -               goto err_rdev_misc_wq;
> -
>         ret =3D __register_blkdev(MD_MAJOR, "md", md_probe);
>         if (ret < 0)
>                 goto err_md;
> @@ -9640,8 +9645,6 @@ static int __init md_init(void)
>  err_mdp:
>         unregister_blkdev(MD_MAJOR, "md");
>  err_md:
> -       destroy_workqueue(md_rdev_misc_wq);
> -err_rdev_misc_wq:
>         destroy_workqueue(md_misc_wq);
>  err_misc_wq:
>         destroy_workqueue(md_wq);
> @@ -9937,7 +9940,6 @@ static __exit void md_exit(void)
>         }
>         spin_unlock(&all_mddevs_lock);
>
> -       destroy_workqueue(md_rdev_misc_wq);
>         destroy_workqueue(md_misc_wq);
>         destroy_workqueue(md_wq);
>  }
> diff --git a/drivers/md/md.h b/drivers/md/md.h
> index 1eec65cf783c..4d191db831da 100644
> --- a/drivers/md/md.h
> +++ b/drivers/md/md.h
> @@ -531,6 +531,14 @@ struct mddev {
>         unsigned int                    good_device_nr; /* good device nu=
m within cluster raid */
>         unsigned int                    noio_flag; /* for memalloc scope =
API */
>
> +       /*
> +        * Temporarily store rdev that will be finally removed when
> +        * reconfig_mutex is unlocked.
> +        */
> +       struct list_head                deleting;
> +       /* Protect the deleting list */
> +       struct mutex                    delete_mutex;
> +
>         bool    has_superblocks:1;
>         bool    fail_last_dev:1;
>         bool    serialize_policy:1;
> --
> 2.39.2
>
