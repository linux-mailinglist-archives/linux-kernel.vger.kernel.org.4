Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B041E69EC0B
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 01:43:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229872AbjBVAnC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 19:43:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjBVAnA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 19:43:00 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAC882886A
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 16:42:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1677026533;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=sPZDX6G7+5gu8tMW3XT5QRmfAgicU0SqI4p6DYfdB9E=;
        b=iC+lPl7Df8dSQHYCVVptCjRWVN8j0fpJKFeuacJdUjGaLrnvw/PMnBqns7O6IKUGA2jeUM
        mUf6Apb8HQbpr3dnyDkzVy7vTFngwZRhKcjNjUF0T7nzknD7KAgK6MGzELsM4WABTFwtkl
        5wjdE87gq5TvoocXHjbpY3bL6pVNCsg=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-591-Dox49r8gNb6lLIHCd9r25A-1; Tue, 21 Feb 2023 19:42:11 -0500
X-MC-Unique: Dox49r8gNb6lLIHCd9r25A-1
Received: by mail-pl1-f198.google.com with SMTP id w7-20020a170902e88700b0019ca50c7fa3so698733plg.23
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 16:42:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sPZDX6G7+5gu8tMW3XT5QRmfAgicU0SqI4p6DYfdB9E=;
        b=4E6MvUijCXBs/Dqm3N3aSHGAgYooAxKFkYpnffv9JYWzy769SWHrVoxDTPXBhOM2Km
         JoR7V5DpMVZlWxHW7xBc+zxB7C3ek8wUP1h3pO/Y5gCLQuVNqlgwg2F16OxUF3UA6j/6
         p9isXHbjaR6sq0szMDsy+aAhoFPy/+RPE2wYCAp3HlgnWalpqO1GkyBseirz4Y0lywik
         olPW2lS9dw1r8WeGNH7OWRFalPQ2HIby0bWQ8Zi1E+zbwb88kjvDXzdOq7d0HM2um2q4
         XtnDuOqtMtQ/LOAsiFpcO2kf6ICDtLRshnTt6+0HpkSEHcLZeP4MIPCdWzD8wLnpfXl/
         cicA==
X-Gm-Message-State: AO0yUKVUQMwB5McjFzy7t/zaEBF+aQIY0YGnKd+hrfXyA6euY4YzjMCd
        CYHnJXYaUFyqv5FfMw4GvHvqswE47Mi8l38R93esU76XuaK48wnyLaDsJyB4ZJ/XQpNeKx2gj3Q
        ES0Z0iIyuKs/Q/H91PtcWH1CgQnPrmrOGisTsaW62
X-Received: by 2002:a17:90b:42:b0:233:a68f:16d with SMTP id d2-20020a17090b004200b00233a68f016dmr1708828pjt.21.1677026530795;
        Tue, 21 Feb 2023 16:42:10 -0800 (PST)
X-Google-Smtp-Source: AK7set8/iTA719RzUTXGlE2nlzhQLatiQvm0/2Qfqwdi2knLtsM+uciGgCI5aYFOPLCHUSfMfzQm0RgnJwivRDV1TtI=
X-Received: by 2002:a17:90b:42:b0:233:a68f:16d with SMTP id
 d2-20020a17090b004200b00233a68f016dmr1708823pjt.21.1677026530497; Tue, 21 Feb
 2023 16:42:10 -0800 (PST)
MIME-Version: 1.0
References: <20230221135506.296074-1-yukuai1@huaweicloud.com> <CALTww2-eUz7__wmu6Cbxs0yV3OGD23WggRUbn6ry_z+W9MApKA@mail.gmail.com>
In-Reply-To: <CALTww2-eUz7__wmu6Cbxs0yV3OGD23WggRUbn6ry_z+W9MApKA@mail.gmail.com>
From:   Xiao Ni <xni@redhat.com>
Date:   Wed, 22 Feb 2023 08:41:59 +0800
Message-ID: <CALTww29pPRCx_U10yZsUvytoj6vhvE3_v2Mum_7hxHsa21+qCA@mail.gmail.com>
Subject: Re: [PATCH] md: fix null-ptr-deference in md_free_disk()
To:     Yu Kuai <yukuai1@huaweicloud.com>
Cc:     song@kernel.org, linux-raid@vger.kernel.org,
        linux-kernel@vger.kernel.org, yukuai3@huawei.com,
        yi.zhang@huawei.com, yangerkun@huawei.com,
        Heinz Mauelshagen <heinzm@redhat.com>,
        Nigel Croxon <ncroxon@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry, the patch was missed in the last email.

diff --git a/drivers/md/md.c b/drivers/md/md.c
index 927a43db5dfb..f5480778e2f7 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -6256,6 +6256,11 @@ static void __md_stop(struct mddev *mddev)
                mddev->to_remove = &md_redundancy_group;
        module_put(pers->owner);
        clear_bit(MD_RECOVERY_FROZEN, &mddev->recovery);
+
+       percpu_ref_exit(&mddev->writes_pending);
+       percpu_ref_exit(&mddev->active_io);
+       bioset_exit(&mddev->bio_set);
+       bioset_exit(&mddev->sync_set);
 }

 void md_stop(struct mddev *mddev)
@@ -6265,10 +6270,6 @@ void md_stop(struct mddev *mddev)
         */
        __md_stop_writes(mddev);
        __md_stop(mddev);
-       percpu_ref_exit(&mddev->writes_pending);
-       percpu_ref_exit(&mddev->active_io);
-       bioset_exit(&mddev->bio_set);
-       bioset_exit(&mddev->sync_set);
 }

 EXPORT_SYMBOL_GPL(md_stop);
@@ -7839,11 +7840,6 @@ static void md_free_disk(struct gendisk *disk)
 {
        struct mddev *mddev = disk->private_data;

-       percpu_ref_exit(&mddev->writes_pending);
-       percpu_ref_exit(&mddev->active_io);
-       bioset_exit(&mddev->bio_set);
-       bioset_exit(&mddev->sync_set);
-
        mddev_free(mddev);
 }

If we release those memories in md_free_disk, it's hard to find the
corresponding relationship between alloc memory and free memory.
If we free memory in __md_stop, it's easy to find the right place where
those memories are free.

Best Regards
Xiao


On Wed, Feb 22, 2023 at 8:39 AM Xiao Ni <xni@redhat.com> wrote:
>
> Hi Yu Kuai
>
> Thanks for reporting this problem.
>
> For creating raid device, md raid calls do_md_run->md_run, dm raid
> calls md_run. We alloc those memory in md_run.
> For stopping raid device, md raid calls do_md_stop->__md_stop, dm raid
> calls md_stop->__md_stop.
>
> So how about this patch:
> diff --git a/drivers/md/md.c b/drivers/md/md.c
> index 927a43db5dfb..f5480778e2f7 100644
> --- a/drivers/md/md.c
> +++ b/drivers/md/md.c
>
> On Tue, Feb 21, 2023 at 9:33 PM Yu Kuai <yukuai1@huaweicloud.com> wrote:
> >
> > From: Yu Kuai <yukuai3@huawei.com>
> >
> > If md_run() failed after 'acitive_io' is initialized, then
> > percpu_ref_exit() is called in error path, however, later md_free_disk()
> > will call percpu_ref_exit() again, which lead to following
> > null-ptr-deference:
> >
> > BUG: kernel NULL pointer dereference, address: 0000000000000038
> > Oops: 0000 [#1] PREEMPT SMP
> > CPU: 41 PID: 585 Comm: kworker/41:1 Not tainted 6.2.0-rc8-next-20230220 #1452
> > Workqueue: md_misc mddev_delayed_delete
> > RIP: 0010:free_percpu+0x110/0x630
> > Call Trace:
> >  <TASK>
> >  __percpu_ref_exit+0x44/0x70
> >  percpu_ref_exit+0x16/0x90
> >  md_free_disk+0x2f/0x80
> >  disk_release+0x101/0x180
> >  device_release+0x84/0x110
> >  kobject_put+0x12a/0x380
> >  kobject_put+0x160/0x380
> >  mddev_delayed_delete+0x19/0x30
> >  process_one_work+0x269/0x680
> >  worker_thread+0x266/0x640
> >  kthread+0x151/0x1b0
> >  ret_from_fork+0x1f/0x30
> >
> > Since freeing mddev will exit 'active_io' unconditionally, fix the
> > problem by removing exiting 'active_io' from error path, this way
> > it will be delayed to free mddev.
> >
> > Fixes: 72adae23a72c ("md: Change active_io to percpu")
> > Signed-off-by: Yu Kuai <yukuai3@huawei.com>
> > ---
> >  drivers/md/md.c | 4 +---
> >  1 file changed, 1 insertion(+), 3 deletions(-)
> >
> > diff --git a/drivers/md/md.c b/drivers/md/md.c
> > index 927a43db5dfb..77124679b3fd 100644
> > --- a/drivers/md/md.c
> > +++ b/drivers/md/md.c
> > @@ -5851,7 +5851,7 @@ int md_run(struct mddev *mddev)
> >         if (!bioset_initialized(&mddev->bio_set)) {
> >                 err = bioset_init(&mddev->bio_set, BIO_POOL_SIZE, 0, BIOSET_NEED_BVECS);
> >                 if (err)
> > -                       goto exit_active_io;
> > +                       return err;
> >         }
> >         if (!bioset_initialized(&mddev->sync_set)) {
> >                 err = bioset_init(&mddev->sync_set, BIO_POOL_SIZE, 0, BIOSET_NEED_BVECS);
> > @@ -6039,8 +6039,6 @@ int md_run(struct mddev *mddev)
> >         bioset_exit(&mddev->sync_set);
> >  exit_bio_set:
> >         bioset_exit(&mddev->bio_set);
> > -exit_active_io:
> > -       percpu_ref_exit(&mddev->active_io);
> >         return err;
> >  }
> >  EXPORT_SYMBOL_GPL(md_run);
> > --
> > 2.31.1
> >

