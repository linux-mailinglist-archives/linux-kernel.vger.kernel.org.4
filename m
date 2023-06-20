Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D85E77366B3
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 10:53:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231187AbjFTIxi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 04:53:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229618AbjFTIxg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 04:53:36 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1858EE7E
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 01:52:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1687251169;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JPkt6qjqi1sD2NXj3pKbMA7Q//woLWYUK4JqSn2/djk=;
        b=ba/ivDwrk0rcJRUaVOhMmLE21OJxlICcF0WyXCccvBiwuGUKQb/yC0piaeHQ5wEYl96pPS
        Pexn4IUBOGGwhBSqjiC7L5r6MddlePPKE9T01QxD/U2x+AVMTbH2DfZhtZ3nE37ZHQaR05
        TzBx6HxV7/igMugOmjWBddLMnCtpqNI=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-252-GAD0MhuVMDy2CvD9lnfz1g-1; Tue, 20 Jun 2023 04:52:47 -0400
X-MC-Unique: GAD0MhuVMDy2CvD9lnfz1g-1
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-763a7abf1c5so137479285a.2
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 01:52:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687251167; x=1689843167;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JPkt6qjqi1sD2NXj3pKbMA7Q//woLWYUK4JqSn2/djk=;
        b=OX6KN5vdDfEJ1H/n5/suTk0WtqRaseFW3EFl+6UMWPIpaokD97seBC7VjCh+Ay2edc
         DOLKbMdtj97HUceTGJgH0TGQ9avaAE9PRS/EVeCyeiRfBCPn+8soBjj0+0pz7Zaf4/wA
         8WyBNTlNLeJGTGZssTUUh35MhqNqPRlp/SLu0YZmmLLJzPPRRjLWy0qSCO2vGkO34FuB
         R+7TC6+Q7rHed48UPjcW5Gb+ue504AKAw9i0QeXfEkla204H+JXjLpEJ50S9BD4hqe3c
         EwSi7HlanWoLCaUP0lmL77nCS6goexVy68ONOoBwBxeJVTqqFDFWPmEwneWc0N/y1OmW
         vvmQ==
X-Gm-Message-State: AC+VfDzbLNOdN/WbJrmvdPXpPGRV3zJJTo8iZfVjuVQpS2jGVNwtU0ww
        J6ChrJvvBtksmRJQ/s0ssuDzYs34kszlwWXIu79/42SaPWZuqdSIxf3bBCwi1Rrs4MAn+MLN+hX
        9cYp/lY0vfiohubGOngMOw5LMVohUNf3dtgiTVer6
X-Received: by 2002:a05:620a:8e17:b0:762:55b8:cf89 with SMTP id re23-20020a05620a8e1700b0076255b8cf89mr5715924qkn.21.1687251166818;
        Tue, 20 Jun 2023 01:52:46 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6IBRZc0xfZRJ8GgWYl3nrqNufoaJNHd5yD2Fh+mDlDMQjIJDCPXrknO/6JAe954R9KXiefbpzFdJSnhLUlrcM=
X-Received: by 2002:a05:620a:8e17:b0:762:55b8:cf89 with SMTP id
 re23-20020a05620a8e1700b0076255b8cf89mr5715910qkn.21.1687251166599; Tue, 20
 Jun 2023 01:52:46 -0700 (PDT)
MIME-Version: 1.0
References: <20230619204826.755559-1-yukuai1@huaweicloud.com> <20230619204826.755559-4-yukuai1@huaweicloud.com>
In-Reply-To: <20230619204826.755559-4-yukuai1@huaweicloud.com>
From:   Xiao Ni <xni@redhat.com>
Date:   Tue, 20 Jun 2023 16:52:35 +0800
Message-ID: <CALTww2_jEw+vOn+jp_p=b9mUO-7ovmdn=0-gzCmYD1O0HHqQUw@mail.gmail.com>
Subject: Re: [PATCH -next 3/8] raid5: fix missing io accounting in raid5_align_endio()
To:     Yu Kuai <yukuai1@huaweicloud.com>
Cc:     song@kernel.org, linux-raid@vger.kernel.org,
        linux-kernel@vger.kernel.org, yukuai3@huawei.com,
        yi.zhang@huawei.com, yangerkun@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 19, 2023 at 8:50=E2=80=AFPM Yu Kuai <yukuai1@huaweicloud.com> w=
rote:
>
> From: Yu Kuai <yukuai3@huawei.com>
>
> Io will only be accounted as done from raid5_align_endio() if the io
> succeed, and io inflight counter will be leaked if such io failed.
>
> Fix this problem by switching to use md_account_bio() for io accounting.
>
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
> ---
>  drivers/md/raid5.c | 29 ++++++++---------------------
>  1 file changed, 8 insertions(+), 21 deletions(-)
>
> diff --git a/drivers/md/raid5.c b/drivers/md/raid5.c
> index cef0b400b2ee..4cdb35e54251 100644
> --- a/drivers/md/raid5.c
> +++ b/drivers/md/raid5.c
> @@ -5468,26 +5468,17 @@ static struct bio *remove_bio_from_retry(struct r=
5conf *conf,
>   */
>  static void raid5_align_endio(struct bio *bi)
>  {
> -       struct md_io_clone *md_io_clone =3D bi->bi_private;
> -       struct bio *raid_bi =3D md_io_clone->orig_bio;
> -       struct mddev *mddev;
> -       struct r5conf *conf;
> -       struct md_rdev *rdev;
> +       struct bio *raid_bi =3D bi->bi_private;
> +       struct md_rdev *rdev =3D (void *)raid_bi->bi_next;
> +       struct mddev *mddev =3D rdev->mddev;
> +       struct r5conf *conf =3D mddev->private;
>         blk_status_t error =3D bi->bi_status;
> -       unsigned long start_time =3D md_io_clone->start_time;
>
>         bio_put(bi);
> -
> -       rdev =3D (void*)raid_bi->bi_next;
>         raid_bi->bi_next =3D NULL;
> -       mddev =3D rdev->mddev;
> -       conf =3D mddev->private;
> -
>         rdev_dec_pending(rdev, conf->mddev);
>
>         if (!error) {
> -               if (blk_queue_io_stat(raid_bi->bi_bdev->bd_disk->queue))
> -                       bio_end_io_acct(raid_bi, start_time);
>                 bio_endio(raid_bi);
>                 if (atomic_dec_and_test(&conf->active_aligned_reads))
>                         wake_up(&conf->wait_for_quiescent);
> @@ -5506,7 +5497,6 @@ static int raid5_read_one_chunk(struct mddev *mddev=
, struct bio *raid_bio)
>         struct md_rdev *rdev;
>         sector_t sector, end_sector, first_bad;
>         int bad_sectors, dd_idx;
> -       struct md_io_clone *md_io_clone;
>         bool did_inc;
>
>         if (!in_chunk_boundary(mddev, raid_bio)) {
> @@ -5543,16 +5533,13 @@ static int raid5_read_one_chunk(struct mddev *mdd=
ev, struct bio *raid_bio)
>                 return 0;
>         }
>
> -       align_bio =3D bio_alloc_clone(rdev->bdev, raid_bio, GFP_NOIO,
> -                                   &mddev->io_clone_set);
> -       md_io_clone =3D container_of(align_bio, struct md_io_clone, bio_c=
lone);
> +       md_account_bio(mddev, &raid_bio);
>         raid_bio->bi_next =3D (void *)rdev;
> -       if (blk_queue_io_stat(raid_bio->bi_bdev->bd_disk->queue))
> -               md_io_clone->start_time =3D bio_start_io_acct(raid_bio);
> -       md_io_clone->orig_bio =3D raid_bio;
>
> +       align_bio =3D bio_alloc_clone(rdev->bdev, raid_bio, GFP_NOIO,
> +                                   &mddev->bio_set);
>         align_bio->bi_end_io =3D raid5_align_endio;
> -       align_bio->bi_private =3D md_io_clone;
> +       align_bio->bi_private =3D raid_bio;
>         align_bio->bi_iter.bi_sector =3D sector;
>
>         /* No reshape active, so we can trust rdev->data_offset */
> --
> 2.39.2
>

Reviewed-by: Xiao Ni <xni@redhat.com>

