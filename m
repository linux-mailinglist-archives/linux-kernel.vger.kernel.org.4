Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 645B96B8482
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 23:09:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230169AbjCMWI7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 18:08:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230104AbjCMWIz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 18:08:55 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A584883EB;
        Mon, 13 Mar 2023 15:08:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 56FD4B81183;
        Mon, 13 Mar 2023 22:08:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F969C433A0;
        Mon, 13 Mar 2023 22:08:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678745331;
        bh=SWV5CxSdZlMxBr3D3J2SYdYdv4+nJ0WW4BhKp3O2LiI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Jo6lOD9szmrNyztaUkAdI2ZbrEbEEVG5ZMWLcI0Y2K64G4oNdR3dvONtMagdQ64ly
         hsXqSBmN50wz0BTiY70a4gitJaIcvp/y3tc9ZK3XR3uRWwC48UHKda3L0FZJz8n0NY
         vzZYzPccHClkrer++2YHNhQW/TQaoLaDLa+/ddy4jtDyUscmZXxIcYv9kQYk1JFS6J
         FysHmKuGo89n9KCKCJlHeA8KHoaxpPj+mnZdpBxNgj9MnNcaf794M4WZ3FRUExXSIM
         Td/AukBFInNB6/z6BWxiiaxMseQjiGN2rTwi5NreEkTkBfkAfUu5Dmquvie392LNy/
         E+JmvGIkRuLuQ==
Received: by mail-lj1-f169.google.com with SMTP id h9so14164572ljq.2;
        Mon, 13 Mar 2023 15:08:51 -0700 (PDT)
X-Gm-Message-State: AO0yUKV1fZhQlx9sVR6bKYCLGz7IbxbDdO20ZCD5J7YINbt6rs+WwPse
        gsM7nnaUvertz8BLYCEyGYrTTXtpLjqLUb4yolw=
X-Google-Smtp-Source: AK7set96vUjS/9oDgH6PlJqErw79LuRXgMyp/tFDb0v8wZwibYQ0wDi1/zLKG3u8/igklSblHxN2QHYWCGTsKwyFD6o=
X-Received: by 2002:a2e:b5a5:0:b0:295:93eb:e790 with SMTP id
 f5-20020a2eb5a5000000b0029593ebe790mr10958769ljn.5.1678745328994; Mon, 13 Mar
 2023 15:08:48 -0700 (PDT)
MIME-Version: 1.0
References: <20230310073855.1337560-1-yukuai1@huaweicloud.com> <20230310073855.1337560-2-yukuai1@huaweicloud.com>
In-Reply-To: <20230310073855.1337560-2-yukuai1@huaweicloud.com>
From:   Song Liu <song@kernel.org>
Date:   Mon, 13 Mar 2023 15:08:36 -0700
X-Gmail-Original-Message-ID: <CAPhsuW5nw0tgVmm-iB++_x2K=dBNSyHNtfpLyKBArn6YZVoteA@mail.gmail.com>
Message-ID: <CAPhsuW5nw0tgVmm-iB++_x2K=dBNSyHNtfpLyKBArn6YZVoteA@mail.gmail.com>
Subject: Re: [PATCH v2 1/6] md/raid10: don't call bio_start_io_acct twice for
 bio which experienced read error
To:     Yu Kuai <yukuai1@huaweicloud.com>
Cc:     guoqing.jiang@linux.dev, jgq516@gmail.com, neilb@suse.de,
        shli@fb.com, lzhong@suse.com, linux-raid@vger.kernel.org,
        linux-kernel@vger.kernel.org, yukuai3@huawei.com,
        yi.zhang@huawei.com, yangerkun@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 9, 2023 at 11:39=E2=80=AFPM Yu Kuai <yukuai1@huaweicloud.com> w=
rote:
>
> From: Yu Kuai <yukuai3@huawei.com>
>
> handle_read_error() will resumit r10_bio by raid10_read_request(), which
> will call bio_start_io_acct() again, while bio_end_io_acct() will only
> be called once.
>
> Fix the problem by don't account io again from handle_read_error().
>
> Fixes: 528bc2cf2fcc ("md/raid10: enable io accounting")
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
> Acked-by: Guoqing Jiang <guoqing.jiang@linux.dev>

I would rather keep same argument lists for raid10_read_request
and raid10_write_request. How about we do something like this
instead?

diff --git i/drivers/md/raid10.c w/drivers/md/raid10.c
index 6b39e6c7ada3..13f33a8a8fe8 100644
--- i/drivers/md/raid10.c
+++ w/drivers/md/raid10.c
@@ -1248,7 +1248,8 @@ static void raid10_read_request(struct mddev
*mddev, struct bio *bio,
        }
        slot =3D r10_bio->read_slot;

-       if (blk_queue_io_stat(bio->bi_bdev->bd_disk->queue))
+       if (!r10_bio->start_time &&
+           blk_queue_io_stat(bio->bi_bdev->bd_disk->queue))
                r10_bio->start_time =3D bio_start_io_acct(bio);
        read_bio =3D bio_alloc_clone(rdev->bdev, bio, gfp, &mddev->bio_set)=
;

@@ -1578,6 +1579,7 @@ static void __make_request(struct mddev *mddev,
struct bio *bio, int sectors)
        r10_bio->sector =3D bio->bi_iter.bi_sector;
        r10_bio->state =3D 0;
        r10_bio->read_slot =3D -1;
+       r10_bio->start_time =3D 0;
        memset(r10_bio->devs, 0, sizeof(r10_bio->devs[0]) *
                        conf->geo.raid_disks);

Thanks,
Song

> ---
>  drivers/md/raid10.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/md/raid10.c b/drivers/md/raid10.c
> index 6c66357f92f5..4f8edb6ea3e2 100644
> --- a/drivers/md/raid10.c
> +++ b/drivers/md/raid10.c
> @@ -1173,7 +1173,7 @@ static bool regular_request_wait(struct mddev *mdde=
v, struct r10conf *conf,
>  }
>
>  static void raid10_read_request(struct mddev *mddev, struct bio *bio,
> -                               struct r10bio *r10_bio)
> +                               struct r10bio *r10_bio, bool handle_error=
)
>  {
>         struct r10conf *conf =3D mddev->private;
>         struct bio *read_bio;
> @@ -1244,7 +1244,7 @@ static void raid10_read_request(struct mddev *mddev=
, struct bio *bio,
>         }
>         slot =3D r10_bio->read_slot;
>
> -       if (blk_queue_io_stat(bio->bi_bdev->bd_disk->queue))
> +       if (!handle_error && blk_queue_io_stat(bio->bi_bdev->bd_disk->que=
ue))
>                 r10_bio->start_time =3D bio_start_io_acct(bio);
>         read_bio =3D bio_alloc_clone(rdev->bdev, bio, gfp, &mddev->bio_se=
t);
>
> @@ -1578,7 +1578,7 @@ static void __make_request(struct mddev *mddev, str=
uct bio *bio, int sectors)
>                         conf->geo.raid_disks);
>
>         if (bio_data_dir(bio) =3D=3D READ)
> -               raid10_read_request(mddev, bio, r10_bio);
> +               raid10_read_request(mddev, bio, r10_bio, false);
>         else
>                 raid10_write_request(mddev, bio, r10_bio);
>  }
> @@ -2980,7 +2980,7 @@ static void handle_read_error(struct mddev *mddev, =
struct r10bio *r10_bio)
>         rdev_dec_pending(rdev, mddev);
>         allow_barrier(conf);
>         r10_bio->state =3D 0;
> -       raid10_read_request(mddev, r10_bio->master_bio, r10_bio);
> +       raid10_read_request(mddev, r10_bio->master_bio, r10_bio, true);
>  }
>
>  static void handle_write_completed(struct r10conf *conf, struct r10bio *=
r10_bio)
> --
> 2.31.1
>
