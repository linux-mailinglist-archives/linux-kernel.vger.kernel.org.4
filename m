Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E00E6CC62D
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 17:26:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233320AbjC1P0H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 11:26:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233258AbjC1PZu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 11:25:50 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A17DFF27
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 08:23:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680016967;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=I/jombuinPsc3d36lBI82kbzySmG0hrqCJeKU/IRSrs=;
        b=Hwmbz74o3XRyFGY+pThyf7CLxWAeJCM0Kp0Me/DA+c1oPGw+cBKL3W0Z55gzpbX+iP+QjF
        hWFreeG5cr2/XbU35zIc+kwbmM3BLONK5WKgYVB6Jbmp5ivETgTKJ9hJCycYapI7Jin96E
        TpGrffDD+QGa9TGKLZw7+id8FmyZ9yY=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-561-ujaJzOA2M7-2x248cNAqeA-1; Tue, 28 Mar 2023 11:22:44 -0400
X-MC-Unique: ujaJzOA2M7-2x248cNAqeA-1
Received: by mail-pj1-f71.google.com with SMTP id o19-20020a17090ab89300b0023b3a5f0aa3so3396824pjr.9
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 08:22:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680016963;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I/jombuinPsc3d36lBI82kbzySmG0hrqCJeKU/IRSrs=;
        b=6/ZvhV+qpJq+fJFKOpSl63kwtFPGZ9y2fLmrkl6wFYbnYuLudAkk8plcM9P8m0l3uk
         gJeMKQrKxQUmakJs/LLLPDfLGyHSFms779nCYU5QH4bjRY82o8a3SZH9aLroXQd8us33
         HcyYuWhrvrdhMZh6dwTbt4tuOIiPyqYJX1pbGgj8UtNwmHVpHeUq8hgB7jzaSl/Nka69
         6YcJjzN+qVRwQjBbTBVgy+6q6MdXYbmF6XrNz2iEv7Gvv4XMdTusvPs5oUWdWWo1rsws
         7FHWh8eul/4dyLOVQYws/m/nr2ESpHKrcE2I+X3tyvTOGKBdY1/6csjyxxwF82qumzj0
         gYog==
X-Gm-Message-State: AAQBX9foWIB6hULbUyRAW5BPVNaIr72+OBiTLhI7PEWSYSZhvAzksTCH
        /siLJceP4/PTp9OsWoQ+yQqUARqr37HScoI9VR8N7JND+a3k96MgQUNIbNNy8RyHq4Uqousr4KH
        rp3ygISA4D5X7ENpRvi8HECTKMr85+okAGZo3PjWC
X-Received: by 2002:a17:903:2442:b0:19f:3aa9:bbb7 with SMTP id l2-20020a170903244200b0019f3aa9bbb7mr5658527pls.13.1680016963357;
        Tue, 28 Mar 2023 08:22:43 -0700 (PDT)
X-Google-Smtp-Source: AKy350bddO1OZyVeOFVgKAZrYry1gLhOD8C8dAD8iF163zw35LAI0P3uVtvXD02YUtIK8oZXPZ07Rfo2ZZ+IXSGDKrQ=
X-Received: by 2002:a17:903:2442:b0:19f:3aa9:bbb7 with SMTP id
 l2-20020a170903244200b0019f3aa9bbb7mr5658516pls.13.1680016963038; Tue, 28 Mar
 2023 08:22:43 -0700 (PDT)
MIME-Version: 1.0
References: <20230328094400.1448955-1-yukuai1@huaweicloud.com>
In-Reply-To: <20230328094400.1448955-1-yukuai1@huaweicloud.com>
From:   Xiao Ni <xni@redhat.com>
Date:   Tue, 28 Mar 2023 23:22:31 +0800
Message-ID: <CALTww29WCGQDgfLcvGkvdhGTc0ONV0Bkdb-CCOujnWaXg2LdCQ@mail.gmail.com>
Subject: Re: [PATCH -next] md: fix regression for null-ptr-deference in __md_stop()
To:     Yu Kuai <yukuai1@huaweicloud.com>
Cc:     song@kernel.org, logang@deltatee.com, linux-raid@vger.kernel.org,
        linux-kernel@vger.kernel.org, yukuai3@huawei.com,
        yi.zhang@huawei.com, yangerkun@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 28, 2023 at 5:44=E2=80=AFPM Yu Kuai <yukuai1@huaweicloud.com> w=
rote:
>
> From: Yu Kuai <yukuai3@huawei.com>
>
> Commit 3e453522593d ("md: Free resources in __md_stop") tried to fix
> null-ptr-deference for 'active_io' by moving percpu_ref_exit() to
> __md_stop(), however, the commit also moving 'writes_pending' to
> __md_stop(), and this will cause mdadm tests broken:
>
> BUG: kernel NULL pointer dereference, address: 0000000000000038
> Oops: 0000 [#1] PREEMPT SMP
> CPU: 15 PID: 17830 Comm: mdadm Not tainted 6.3.0-rc3-next-20230324-00009-=
g520d37
> RIP: 0010:free_percpu+0x465/0x670
> Call Trace:
>  <TASK>
>  __percpu_ref_exit+0x48/0x70
>  percpu_ref_exit+0x1a/0x90
>  __md_stop+0xe9/0x170
>  do_md_stop+0x1e1/0x7b0
>  md_ioctl+0x90c/0x1aa0
>  blkdev_ioctl+0x19b/0x400
>  vfs_ioctl+0x20/0x50
>  __x64_sys_ioctl+0xba/0xe0
>  do_syscall_64+0x6c/0xe0
>  entry_SYSCALL_64_after_hwframe+0x63/0xcd
>
> And the problem can be reporduced 100% by following test:
>
> mdadm -CR /dev/md0 -l1 -n1 /dev/sda --force
> echo inactive > /sys/block/md0/md/array_state
> echo read-auto  > /sys/block/md0/md/array_state
> echo inactive > /sys/block/md0/md/array_state
>
> Root cause:
>
> // start raid
> raid1_run
>  mddev_init_writes_pending
>   percpu_ref_init
>
> // inactive raid
> array_state_store
>  do_md_stop
>   __md_stop
>    percpu_ref_exit
>
> // start raid again
> array_state_store
>  do_md_run
>   raid1_run
>    mddev_init_writes_pending
>     if (mddev->writes_pending.percpu_count_ptr)
>     // won't reinit
>
> // inactive raid again
> ...
> percpu_ref_exit
> -> null-ptr-deference
>
> Before the commit, 'writes_pending' is exited when mddev is freed, and
> it's safe to restart raid because mddev_init_writes_pending() already mak=
e
> sure that 'writes_pending' will only be initialized once.
>
> Fix the prblem by moving 'writes_pending' back, it's a litter hard to fin=
d
> the relationship between alloc memory and free memory, however, code
> changes is much less and we lived with this for a long time already.
>
> Fixes: 3e453522593d ("md: Free resources in __md_stop")
>
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
> ---
>  drivers/md/md.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/md/md.c b/drivers/md/md.c
> index 161231e01faa..06f262050400 100644
> --- a/drivers/md/md.c
> +++ b/drivers/md/md.c
> @@ -6265,7 +6265,6 @@ static void __md_stop(struct mddev *mddev)
>         module_put(pers->owner);
>         clear_bit(MD_RECOVERY_FROZEN, &mddev->recovery);
>
> -       percpu_ref_exit(&mddev->writes_pending);
>         percpu_ref_exit(&mddev->active_io);
>         bioset_exit(&mddev->bio_set);
>         bioset_exit(&mddev->sync_set);
> @@ -6278,6 +6277,7 @@ void md_stop(struct mddev *mddev)
>          */
>         __md_stop_writes(mddev);
>         __md_stop(mddev);
> +       percpu_ref_exit(&mddev->writes_pending);
>  }
>
>  EXPORT_SYMBOL_GPL(md_stop);
> @@ -7848,6 +7848,7 @@ static void md_free_disk(struct gendisk *disk)
>  {
>         struct mddev *mddev =3D disk->private_data;
>
> +       percpu_ref_exit(&mddev->writes_pending);
>         mddev_free(mddev);
>  }
>
> --
> 2.39.2
>
Hi Yu Kuai

Thanks for this. This patch is ok for me. But I have another one
something like this:

diff --git a/drivers/md/md.c b/drivers/md/md.c
index 39e49e5d7182..be07b2b1b717 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -5577,8 +5577,6 @@ static void no_op(struct percpu_ref *r) {}

 int mddev_init_writes_pending(struct mddev *mddev)
 {
-       if (mddev->writes_pending.percpu_count_ptr)
-               return 0;
        if (percpu_ref_init(&mddev->writes_pending, no_op,
                            PERCPU_REF_ALLOW_REINIT, GFP_KERNEL) < 0)
                return -ENOMEM;
@@ -6260,7 +6258,6 @@ static void __md_stop(struct mddev *mddev)
        module_put(pers->owner);
        clear_bit(MD_RECOVERY_FROZEN, &mddev->recovery);

-       percpu_ref_exit(&mddev->writes_pending);
        percpu_ref_exit(&mddev->active_io);
        bioset_exit(&mddev->bio_set);
        bioset_exit(&mddev->sync_set);
diff --git a/drivers/md/raid1.c b/drivers/md/raid1.c
index 68a9e2d9985b..6ba975ed4533 100644
--- a/drivers/md/raid1.c
+++ b/drivers/md/raid1.c
@@ -3210,6 +3210,7 @@ static void raid1_free(struct mddev *mddev, void *pri=
v)
        kfree(conf->barrier);
        bioset_exit(&conf->bio_split);
        kfree(conf);
+       percpu_ref_exit(&mddev->writes_pending);
 }

 static int raid1_resize(struct mddev *mddev, sector_t sectors)
diff --git a/drivers/md/raid10.c b/drivers/md/raid10.c
index 6c66357f92f5..22f0ccb0823b 100644
--- a/drivers/md/raid10.c
+++ b/drivers/md/raid10.c
@@ -4303,6 +4303,7 @@ static void raid10_free(struct mddev *mddev, void *pr=
iv)
        kfree(conf->mirrors_new);
        bioset_exit(&conf->bio_split);
        kfree(conf);
+       percpu_ref_exit(&mddev->writes_pending);
 }

 static void raid10_quiesce(struct mddev *mddev, int quiesce)
diff --git a/drivers/md/raid5.c b/drivers/md/raid5.c
index 7b820b81d8c2..0df9908b3bde 100644
--- a/drivers/md/raid5.c
+++ b/drivers/md/raid5.c
@@ -8087,6 +8087,7 @@ static void raid5_free(struct mddev *mddev, void *pri=
v)
        struct r5conf *conf =3D priv;

        free_conf(conf);
+       percpu_ref_exit(&mddev->writes_pending);
        acct_bioset_exit(mddev);
        mddev->to_remove =3D &raid5_attrs_group;
 }

raid0 doesn't need writes_pending, so we alloc writes_pending in
pers->run. In the function mddev_init_writes_pending, it checks if
writes_pending is freed or not. I guess the reason is to avoid
re-alloc memory during takeover(.e.g raid1->raid10). But it makes the
alloc/free sequence a little mess. If we free writes_pending in
pers->free, it doesn't need to check if writes_pending is valid in
mddev_init_writes_pending again and it's easy to maintain in future.

Anyway, the patch md: fix regression for null-ptr-deference in
__md_stop() is good for me.

Reviewed-by: Xiao Ni <xni@redhat.com>


--
Best Regards
Xiao Ni

