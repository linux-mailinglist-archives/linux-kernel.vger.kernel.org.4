Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90512717912
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 09:53:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235016AbjEaHxf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 03:53:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234980AbjEaHwy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 03:52:54 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFAB310F0
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 00:51:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1685519470;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GIyti307NVAkK2IVpw6AEUVPy+EJ6caNfOmMj6XXpdY=;
        b=bNfwwpoetyEMRXsJXMBH+fXXFS/2oeMJDletLzUtHvyn9fZyosLDAvMdfk1UUiH8uQA5fi
        yaLFRKdd037P8LT419cvdeQkKCfQWUPYNiTOBuXKwM1uJBR05NICtZy/LFlUBXywOYeR8G
        pzw+BP4hGmlYLkFuo1yjDihIodcHH+A=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-654-cMk0ZdiyN5azVgSrM1RroA-1; Wed, 31 May 2023 03:51:08 -0400
X-MC-Unique: cMk0ZdiyN5azVgSrM1RroA-1
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-1b03ae23eacso34494275ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 00:51:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685519468; x=1688111468;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GIyti307NVAkK2IVpw6AEUVPy+EJ6caNfOmMj6XXpdY=;
        b=f3BOlqA6GyNvrJ9w1cSEWwJwAAWI/qito2Sa50+luqTxt4bt6CMZ92zCd9YWsHkg/o
         HCPvfiI2oJkvAnejln69x+7Zf9DyGVNWkxfXv42gilGGrXXF3u8UR/9VrbtJtoHTzwkw
         vYqnph5/dmPuz10jKg28AB/m/AdKJuImEMtYnmjF/FFmR+1fzA4dy0SFsZF4AgX4t9kK
         uYKD6fAfejZh35dMjJ/+CIe3omgl6Wl3H/IiZ192gV25DcZ8N2FqJnpByxo1dFOgbQCe
         UV4ZAyerWHNu/9nPRxKD9Kmx6SuMl7oJ9ZkwHc9k2FKe5CqBu4aAbB4D7bdMNLtenyn7
         EJ3g==
X-Gm-Message-State: AC+VfDy6LSrbP2Yrc4ds48nSIx0giYzOurVcWOcFd4udY6V0BMrVxEoJ
        0tnDmyzqhwH8Gx+Hl8pQaL3spgK6lkI8j3gb0fYkyUW6q63OI+ps0aI6OpmQ/0iOxuzCyD7ExuY
        SLa1mcmR7Ijdd5sh6qHlGs1dTIxlJW6kjEURW6NpH
X-Received: by 2002:a17:902:eccc:b0:1b0:2986:8a6b with SMTP id a12-20020a170902eccc00b001b029868a6bmr5368377plh.55.1685519467805;
        Wed, 31 May 2023 00:51:07 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5Ahmb1OOjhgvMqKaa9XR2VNIgsTX4PeJFINGaZxsDn574aSWlvJqrA9Kl8DiFtr7ZZx3tfV0MltE+Z38qKuXo=
X-Received: by 2002:a17:902:eccc:b0:1b0:2986:8a6b with SMTP id
 a12-20020a170902eccc00b001b029868a6bmr5368361plh.55.1685519467506; Wed, 31
 May 2023 00:51:07 -0700 (PDT)
MIME-Version: 1.0
References: <20230529131106.2123367-1-yukuai1@huaweicloud.com> <20230529131106.2123367-7-yukuai1@huaweicloud.com>
In-Reply-To: <20230529131106.2123367-7-yukuai1@huaweicloud.com>
From:   Xiao Ni <xni@redhat.com>
Date:   Wed, 31 May 2023 15:50:56 +0800
Message-ID: <CALTww29ixKpcVknNe36D+x=2c1Aw-=z32SP-dJ_Hj8WxL2n4bg@mail.gmail.com>
Subject: Re: [PATCH -next v3 6/7] md/raid1-10: don't handle pluged bio by
 daemon thread
To:     Yu Kuai <yukuai1@huaweicloud.com>
Cc:     song@kernel.org, neilb@suse.de, akpm@osdl.org,
        linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
        yukuai3@huawei.com, yi.zhang@huawei.com, yangerkun@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 29, 2023 at 9:14=E2=80=AFPM Yu Kuai <yukuai1@huaweicloud.com> w=
rote:
>
> From: Yu Kuai <yukuai3@huawei.com>
>
> current->bio_list will be set under submit_bio() context, in this case
> bitmap io will be added to the list and wait for current io submission to
> finish, while current io submission must wait for bitmap io to be done.
> commit 874807a83139 ("md/raid1{,0}: fix deadlock in bitmap_unplug.") fix
> the deadlock by handling plugged bio by daemon thread.

Thanks for the historic introduction. I did a test and printed the
logs in raid10_unplug. The tools I used are dd and mkfs. from_schedule
is always true during I/O and it's 0 when io finishes. So I have a
question here, how can I trigger the condition that from_schedule is 0
and current->list is not NULL? In other words, is there really a
deadlock here? Before your patch it looks like all bios are merged
into conf->pending_bio_list and are handled by raid10d. It can't
submit bio directly in the originating process which mentioned in
57c67df48866

>
> On the one hand, the deadlock won't exist after commit a214b949d8e3
> ("blk-mq: only flush requests from the plug in blk_mq_submit_bio"). On
> the other hand, current solution makes it impossible to flush plugged bio
> in raid1/10_make_request(), because this will cause that all the writes
> will goto daemon thread.
>
> In order to limit the number of plugged bio, commit 874807a83139
> ("md/raid1{,0}: fix deadlock in bitmap_unplug.") is reverted, and the
> deadlock is fixed by handling bitmap io asynchronously.
>
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
> ---
>  drivers/md/raid1-10.c | 14 ++++++++++++++
>  drivers/md/raid1.c    |  4 ++--
>  drivers/md/raid10.c   |  8 +++-----
>  3 files changed, 19 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/md/raid1-10.c b/drivers/md/raid1-10.c
> index 73cc3cb9154d..17e55c1fd5a1 100644
> --- a/drivers/md/raid1-10.c
> +++ b/drivers/md/raid1-10.c
> @@ -151,3 +151,17 @@ static inline bool raid1_add_bio_to_plug(struct mdde=
v *mddev, struct bio *bio,
>
>         return true;
>  }
> +
> +/*
> + * current->bio_list will be set under submit_bio() context, in this cas=
e bitmap
> + * io will be added to the list and wait for current io submission to fi=
nish,
> + * while current io submission must wait for bitmap io to be done. In or=
der to
> + * avoid such deadlock, submit bitmap io asynchronously.
> + */
> +static inline void raid1_prepare_flush_writes(struct bitmap *bitmap)
> +{
> +       if (current->bio_list)
> +               md_bitmap_unplug_async(bitmap);
> +       else
> +               md_bitmap_unplug(bitmap);
> +}
> diff --git a/drivers/md/raid1.c b/drivers/md/raid1.c
> index 0778e398584c..006620fed595 100644
> --- a/drivers/md/raid1.c
> +++ b/drivers/md/raid1.c
> @@ -794,7 +794,7 @@ static int read_balance(struct r1conf *conf, struct r=
1bio *r1_bio, int *max_sect
>  static void flush_bio_list(struct r1conf *conf, struct bio *bio)
>  {
>         /* flush any pending bitmap writes to disk before proceeding w/ I=
/O */
> -       md_bitmap_unplug(conf->mddev->bitmap);
> +       raid1_prepare_flush_writes(conf->mddev->bitmap);

If we unplug bitmap asynchronously, can we make sure the bitmap are
flushed before the corresponding data?

Regards
Xiao

>         wake_up(&conf->wait_barrier);
>
>         while (bio) { /* submit pending writes */
> @@ -1166,7 +1166,7 @@ static void raid1_unplug(struct blk_plug_cb *cb, bo=
ol from_schedule)
>         struct r1conf *conf =3D mddev->private;
>         struct bio *bio;
>
> -       if (from_schedule || current->bio_list) {
> +       if (from_schedule) {
>                 spin_lock_irq(&conf->device_lock);
>                 bio_list_merge(&conf->pending_bio_list, &plug->pending);
>                 spin_unlock_irq(&conf->device_lock);
> diff --git a/drivers/md/raid10.c b/drivers/md/raid10.c
> index 6640507ecb0d..fb22cfe94d32 100644
> --- a/drivers/md/raid10.c
> +++ b/drivers/md/raid10.c
> @@ -902,9 +902,7 @@ static void flush_pending_writes(struct r10conf *conf=
)
>                 __set_current_state(TASK_RUNNING);
>
>                 blk_start_plug(&plug);
> -               /* flush any pending bitmap writes to disk
> -                * before proceeding w/ I/O */
> -               md_bitmap_unplug(conf->mddev->bitmap);
> +               raid1_prepare_flush_writes(conf->mddev->bitmap);
>                 wake_up(&conf->wait_barrier);
>
>                 while (bio) { /* submit pending writes */
> @@ -1108,7 +1106,7 @@ static void raid10_unplug(struct blk_plug_cb *cb, b=
ool from_schedule)
>         struct r10conf *conf =3D mddev->private;
>         struct bio *bio;
>
> -       if (from_schedule || current->bio_list) {
> +       if (from_schedule) {
>                 spin_lock_irq(&conf->device_lock);
>                 bio_list_merge(&conf->pending_bio_list, &plug->pending);
>                 spin_unlock_irq(&conf->device_lock);
> @@ -1120,7 +1118,7 @@ static void raid10_unplug(struct blk_plug_cb *cb, b=
ool from_schedule)
>
>         /* we aren't scheduling, so we can do the write-out directly. */
>         bio =3D bio_list_get(&plug->pending);
> -       md_bitmap_unplug(mddev->bitmap);
> +       raid1_prepare_flush_writes(mddev->bitmap);
>         wake_up(&conf->wait_barrier);
>
>         while (bio) { /* submit pending writes */
> --
> 2.39.2
>

