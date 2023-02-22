Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0F9B69EC07
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 01:40:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229816AbjBVAkH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 19:40:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229674AbjBVAkE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 19:40:04 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4374727491
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 16:39:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1677026357;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/FyqmJlAwjkt1mSpJYa/P+tOTNA1fNWSEDwUa8aTvwI=;
        b=WAcYnWmNPMe14g8rPJM9xZK0bUX01zNn0th5sOXz2t12xTa9H8QWKh74VdkUl/BBP7L5Uu
        gcR08OEs56Zmb99olTdQHHh5WpSXAoQ6NsLjcBPWvwY1OWBr5BsZ1uodpgDhZp9MCbwxWU
        uZTuebrk9ZvPcIdo+PTl6zvjPXIyLaE=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-213-b5sEB8IKMluhTzwEzp32wQ-1; Tue, 21 Feb 2023 19:39:16 -0500
X-MC-Unique: b5sEB8IKMluhTzwEzp32wQ-1
Received: by mail-pj1-f71.google.com with SMTP id r7-20020a17090b050700b0023727c1e3c0so1091086pjz.1
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 16:39:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677026355;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/FyqmJlAwjkt1mSpJYa/P+tOTNA1fNWSEDwUa8aTvwI=;
        b=5N6msNwwTgn20UUmSEW3Fbf8X8kT4UUl8M0XrhczNpQY069mLqyExo78vrs+vI+9qc
         EbSs0XW5GzFpxz7oaBJTGx5n9gJGchpOZeingSOe1uX5yTSkFxEDUTzSUUX4m9rO3u/f
         QXhc+kfJK/eMDbl6uVUVIWJgm2PW99/abXxfo2liMKU1teWDR510c1C5cjTDGfk+4FeM
         BX+IF3B/NgXdbzIjL5OjG4XdcJVqcvd4Rmg2EtY9XvusHDyU//z3i0YEyiMlBcAYnR9g
         HMzkJPQOvjuQaYAtkEC6I33p+UBQVJatSAMFKw7E1GEa1Uv+HEJR6+AglJIqALzz2ob8
         VSVA==
X-Gm-Message-State: AO0yUKWGY7DYu/iRxPWavBrEzDii81lTlUCKI4JRKv8VaYXDDxWKpPnI
        ZKYZkfwrYN95DK0uZjCgeNafmDrBT7TwGTNE3p850MBJxiP7XFuiJpVwJSbgwkGzlXnTSzbB3k1
        UAUeHZzV5JCYr5yJMA5o4WT20FyMXhOKUEsvMVIxr
X-Received: by 2002:a62:8203:0:b0:5aa:59ee:bb5c with SMTP id w3-20020a628203000000b005aa59eebb5cmr753530pfd.25.1677026354944;
        Tue, 21 Feb 2023 16:39:14 -0800 (PST)
X-Google-Smtp-Source: AK7set8XJqFlNrgrENxH1GYPKgu4WLs6RnV2qWonseq4k8wcgFbK4jIwBv67FzjMme4VLfLy6wqOjRAFeDTPS1ZBtKM=
X-Received: by 2002:a62:8203:0:b0:5aa:59ee:bb5c with SMTP id
 w3-20020a628203000000b005aa59eebb5cmr753523pfd.25.1677026354634; Tue, 21 Feb
 2023 16:39:14 -0800 (PST)
MIME-Version: 1.0
References: <20230221135506.296074-1-yukuai1@huaweicloud.com>
In-Reply-To: <20230221135506.296074-1-yukuai1@huaweicloud.com>
From:   Xiao Ni <xni@redhat.com>
Date:   Wed, 22 Feb 2023 08:39:03 +0800
Message-ID: <CALTww2-eUz7__wmu6Cbxs0yV3OGD23WggRUbn6ry_z+W9MApKA@mail.gmail.com>
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
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yu Kuai

Thanks for reporting this problem.

For creating raid device, md raid calls do_md_run->md_run, dm raid
calls md_run. We alloc those memory in md_run.
For stopping raid device, md raid calls do_md_stop->__md_stop, dm raid
calls md_stop->__md_stop.

So how about this patch:
diff --git a/drivers/md/md.c b/drivers/md/md.c
index 927a43db5dfb..f5480778e2f7 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c

On Tue, Feb 21, 2023 at 9:33 PM Yu Kuai <yukuai1@huaweicloud.com> wrote:
>
> From: Yu Kuai <yukuai3@huawei.com>
>
> If md_run() failed after 'acitive_io' is initialized, then
> percpu_ref_exit() is called in error path, however, later md_free_disk()
> will call percpu_ref_exit() again, which lead to following
> null-ptr-deference:
>
> BUG: kernel NULL pointer dereference, address: 0000000000000038
> Oops: 0000 [#1] PREEMPT SMP
> CPU: 41 PID: 585 Comm: kworker/41:1 Not tainted 6.2.0-rc8-next-20230220 #1452
> Workqueue: md_misc mddev_delayed_delete
> RIP: 0010:free_percpu+0x110/0x630
> Call Trace:
>  <TASK>
>  __percpu_ref_exit+0x44/0x70
>  percpu_ref_exit+0x16/0x90
>  md_free_disk+0x2f/0x80
>  disk_release+0x101/0x180
>  device_release+0x84/0x110
>  kobject_put+0x12a/0x380
>  kobject_put+0x160/0x380
>  mddev_delayed_delete+0x19/0x30
>  process_one_work+0x269/0x680
>  worker_thread+0x266/0x640
>  kthread+0x151/0x1b0
>  ret_from_fork+0x1f/0x30
>
> Since freeing mddev will exit 'active_io' unconditionally, fix the
> problem by removing exiting 'active_io' from error path, this way
> it will be delayed to free mddev.
>
> Fixes: 72adae23a72c ("md: Change active_io to percpu")
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
> ---
>  drivers/md/md.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/drivers/md/md.c b/drivers/md/md.c
> index 927a43db5dfb..77124679b3fd 100644
> --- a/drivers/md/md.c
> +++ b/drivers/md/md.c
> @@ -5851,7 +5851,7 @@ int md_run(struct mddev *mddev)
>         if (!bioset_initialized(&mddev->bio_set)) {
>                 err = bioset_init(&mddev->bio_set, BIO_POOL_SIZE, 0, BIOSET_NEED_BVECS);
>                 if (err)
> -                       goto exit_active_io;
> +                       return err;
>         }
>         if (!bioset_initialized(&mddev->sync_set)) {
>                 err = bioset_init(&mddev->sync_set, BIO_POOL_SIZE, 0, BIOSET_NEED_BVECS);
> @@ -6039,8 +6039,6 @@ int md_run(struct mddev *mddev)
>         bioset_exit(&mddev->sync_set);
>  exit_bio_set:
>         bioset_exit(&mddev->bio_set);
> -exit_active_io:
> -       percpu_ref_exit(&mddev->active_io);
>         return err;
>  }
>  EXPORT_SYMBOL_GPL(md_run);
> --
> 2.31.1
>

