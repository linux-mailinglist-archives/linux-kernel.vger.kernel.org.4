Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22FF47392E4
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 01:11:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230039AbjFUXK5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 19:10:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230211AbjFUXKy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 19:10:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D93E81BCA;
        Wed, 21 Jun 2023 16:10:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 48A75616E9;
        Wed, 21 Jun 2023 23:10:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1D1FC433C9;
        Wed, 21 Jun 2023 23:10:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687389051;
        bh=9JinHSaZmwELjEFzO877UhVIsQ8lZYLjxB9oB9iQWCU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ZwZk7DC5mg37lN5q2LMRY+1J0gbLnDsxXDFmYNdsMFJS8+BN5W1AINbmbEwsM8/qq
         nzjsbCN38iov+d1+kZ1b+iyqOIWnFHt2F1fKjtc8YuOzKCulwDnTmtZNA3xoyAot0j
         vj8Pe1HecpOEmN4N+kNRNrtZDX5Kxx5mi0VkNWlTMTbe8eXfZqQB1T7ZYvfPOqeG4c
         c9KHItzxlNH6rBI3FaoGda3CKGA0nVvBdiAdp0fopPRZVHpMKc72zaRVBp+o13tmge
         zOKLe8fyw8ue9QcM9+xdQm8V6rPC5RoJxeUhsdC1lLNjpkQfDA00AgcEGsdyvx6g55
         Yixy6uSfsAKUQ==
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-4f883420152so4055670e87.1;
        Wed, 21 Jun 2023 16:10:51 -0700 (PDT)
X-Gm-Message-State: AC+VfDxUGaJ7NRFXENpbk0ot4xbU6fkLji+eWrshdbIIsDWkBAorNZAl
        CPtJX9Bc1GC6eJvNqtMc2sD5yYIAhhRbVZpt4II=
X-Google-Smtp-Source: ACHHUZ4J0UdrDWNzHmuzyTdhztAk80nGpQTUEb5T7s4TFzyGryRYCOg1zgWhXZqkW/u7e/SK3Vny7AsdI+BntSf8W4s=
X-Received: by 2002:a05:6512:1028:b0:4f7:6017:8fb with SMTP id
 r8-20020a056512102800b004f7601708fbmr10052167lfr.26.1687389049650; Wed, 21
 Jun 2023 16:10:49 -0700 (PDT)
MIME-Version: 1.0
References: <20230621142933.1395629-1-yukuai1@huaweicloud.com>
In-Reply-To: <20230621142933.1395629-1-yukuai1@huaweicloud.com>
From:   Song Liu <song@kernel.org>
Date:   Wed, 21 Jun 2023 16:10:37 -0700
X-Gmail-Original-Message-ID: <CAPhsuW7CZwpy22_Eto1NuUuJk9XY1LqQHW1=jVoQ_Hhj2JbH7w@mail.gmail.com>
Message-ID: <CAPhsuW7CZwpy22_Eto1NuUuJk9XY1LqQHW1=jVoQ_Hhj2JbH7w@mail.gmail.com>
Subject: Re: [PATCH] md: fix 'delete_mutex' deadlock
To:     Yu Kuai <yukuai1@huaweicloud.com>
Cc:     yukuai3@huawei.com, linux-raid@vger.kernel.org,
        linux-kernel@vger.kernel.org, yi.zhang@huawei.com,
        yangerkun@huawei.com
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

On Tue, Jun 20, 2023 at 11:31=E2=80=AFPM Yu Kuai <yukuai1@huaweicloud.com> =
wrote:
>
> From: Yu Kuai <yukuai3@huawei.com>
>
> Commit 3ce94ce5d05a ("md: fix duplicate filename for rdev") introduce a
> new lock 'delete_mutex', and trigger a new deadlock:
>
> t1: remove rdev                 t2: sysfs writer
>
> rdev_attr_store                 rdev_attr_store
>  mddev_lock
>  state_store
>  md_kick_rdev_from_array
>   lock delete_mutex
>   list_add mddev->deleting
>   unlock delete_mutex
>  mddev_unlock
>                                  mddev_lock
>                                  ...
>   lock delete_mutex
>   kobject_del
>   // wait for sysfs writers to be done
>                                  mddev_unlock
>                                  lock delete_mutex
>                                  // wait for delete_mutex, deadlock
>
> 'delete_mutex' is used to protect the list 'mddev->deleting', turns out
> that this list can be protected by 'reconfig_mutex' directly, and this
> lock can be removed.
>
> Fix this problem by removing the lock, and use 'reconfig_mutex' to
> protect the list. mddev_unlock() will move this list to a local list to
> be handled after 'reconfig_mutex' is dropped.
>
> Fixes: 3ce94ce5d05a ("md: fix duplicate filename for rdev")
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>

Applied to md-next. Thanks for the quick fix!

Song

> ---
>  drivers/md/md.c | 28 +++++++++-------------------
>  drivers/md/md.h |  4 +---
>  2 files changed, 10 insertions(+), 22 deletions(-)
>
> diff --git a/drivers/md/md.c b/drivers/md/md.c
> index 1086d7282ee7..089f7d7a9052 100644
> --- a/drivers/md/md.c
> +++ b/drivers/md/md.c
> @@ -643,7 +643,6 @@ void mddev_init(struct mddev *mddev)
>  {
>         mutex_init(&mddev->open_mutex);
>         mutex_init(&mddev->reconfig_mutex);
> -       mutex_init(&mddev->delete_mutex);
>         mutex_init(&mddev->sync_mutex);
>         mutex_init(&mddev->bitmap_info.mutex);
>         INIT_LIST_HEAD(&mddev->disks);
> @@ -751,26 +750,15 @@ static void mddev_free(struct mddev *mddev)
>
>  static const struct attribute_group md_redundancy_group;
>
> -static void md_free_rdev(struct mddev *mddev)
> +void mddev_unlock(struct mddev *mddev)
>  {
>         struct md_rdev *rdev;
>         struct md_rdev *tmp;
> +       LIST_HEAD(delete);
>
> -       mutex_lock(&mddev->delete_mutex);
> -       if (list_empty(&mddev->deleting))
> -               goto out;
> +       if (!list_empty(&mddev->deleting))
> +               list_splice_init(&mddev->deleting, &delete);
>
> -       list_for_each_entry_safe(rdev, tmp, &mddev->deleting, same_set) {
> -               list_del_init(&rdev->same_set);
> -               kobject_del(&rdev->kobj);
> -               export_rdev(rdev, mddev);
> -       }
> -out:
> -       mutex_unlock(&mddev->delete_mutex);
> -}
> -
> -void mddev_unlock(struct mddev *mddev)
> -{
>         if (mddev->to_remove) {
>                 /* These cannot be removed under reconfig_mutex as
>                  * an access to the files will try to take reconfig_mutex
> @@ -810,7 +798,11 @@ void mddev_unlock(struct mddev *mddev)
>         } else
>                 mutex_unlock(&mddev->reconfig_mutex);
>
> -       md_free_rdev(mddev);
> +       list_for_each_entry_safe(rdev, tmp, &delete, same_set) {
> +               list_del_init(&rdev->same_set);
> +               kobject_del(&rdev->kobj);
> +               export_rdev(rdev, mddev);
> +       }
>
>         md_wakeup_thread(mddev->thread);
>         wake_up(&mddev->sb_wait);
> @@ -2490,9 +2482,7 @@ static void md_kick_rdev_from_array(struct md_rdev =
*rdev)
>          * reconfig_mutex is held, hence it can't be called under
>          * reconfig_mutex and it's delayed to mddev_unlock().
>          */
> -       mutex_lock(&mddev->delete_mutex);
>         list_add(&rdev->same_set, &mddev->deleting);
> -       mutex_unlock(&mddev->delete_mutex);
>  }
>
>  static void export_array(struct mddev *mddev)
> diff --git a/drivers/md/md.h b/drivers/md/md.h
> index 892a598a5029..8ae957480976 100644
> --- a/drivers/md/md.h
> +++ b/drivers/md/md.h
> @@ -531,11 +531,9 @@ struct mddev {
>
>         /*
>          * Temporarily store rdev that will be finally removed when
> -        * reconfig_mutex is unlocked.
> +        * reconfig_mutex is unlocked, protected by reconfig_mutex.
>          */
>         struct list_head                deleting;
> -       /* Protect the deleting list */
> -       struct mutex                    delete_mutex;
>
>         /* Used to synchronize idle and frozen for action_store() */
>         struct mutex                    sync_mutex;
> --
> 2.39.2
>
