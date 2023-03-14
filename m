Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 803F36BA0F0
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 21:43:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229749AbjCNUno (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 16:43:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229571AbjCNUnm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 16:43:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6628E4C01;
        Tue, 14 Mar 2023 13:43:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F3399619C4;
        Tue, 14 Mar 2023 20:43:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D897C4339C;
        Tue, 14 Mar 2023 20:43:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678826620;
        bh=0lEocAiqOfkC9eJWtiNBojjBFbXl2h9RIh9+B+2Ga8E=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ulvXk6Hvn8leXHRkIgfsR5SBi4ZX7N/YbyrT1jdOQO/PwLjg4jeebID7MzVCjm7DC
         zvw8hu4K9kWAk1440BZPrDAQNboLlHhtiXvF0ITE7N+0VUO5R+KrGr5bSFolr8hG3h
         JYCKKsWShkzegTlVmxQMX9VhL7ep7TN253gKmG07rMvz3lOVR+aKZ4v5oSaYKXt5GP
         0SwLhLsIoGWqvLoaOutcbPtQxCWkWDvzMQPxZR27ytEz+sdKevL8j1XRITDS6swUZ6
         DRCI69O2z+a0LWSRItlImd2ASMUZa3K66yWZbhWmUiGA5X/Jdpn75rsK5xyhjQ+SgU
         t2xzGL1Q3eK5w==
Received: by mail-lf1-f42.google.com with SMTP id d36so21655653lfv.8;
        Tue, 14 Mar 2023 13:43:40 -0700 (PDT)
X-Gm-Message-State: AO0yUKVx7BEqVbNPONuh8s7C9PKp+jOEa2rQBYLixiNyV8HdtgBTY+BC
        vQviAhGQqEd3qP1a0eTQ1k/5YqUmvRoUtvPKguw=
X-Google-Smtp-Source: AK7set9ydT7YX2hGq88YbVD8eD6SpUxK4DbVCXrJSwm6ebB5lt1Y+rHP96j9j+Zm43BpxDCjFPwyhk73QH5j2prMBCg=
X-Received: by 2002:ac2:4835:0:b0:4db:1a0d:f261 with SMTP id
 21-20020ac24835000000b004db1a0df261mr1208931lft.3.1678826618342; Tue, 14 Mar
 2023 13:43:38 -0700 (PDT)
MIME-Version: 1.0
References: <CAPhsuW5nw0tgVmm-iB++_x2K=dBNSyHNtfpLyKBArn6YZVoteA@mail.gmail.com>
 <20230314012258.2395894-1-yukuai1@huaweicloud.com>
In-Reply-To: <20230314012258.2395894-1-yukuai1@huaweicloud.com>
From:   Song Liu <song@kernel.org>
Date:   Tue, 14 Mar 2023 13:43:26 -0700
X-Gmail-Original-Message-ID: <CAPhsuW7nSyhgKy8=90MEttDPRmadKaAFb5--SBOjrOb34Mp3XA@mail.gmail.com>
Message-ID: <CAPhsuW7nSyhgKy8=90MEttDPRmadKaAFb5--SBOjrOb34Mp3XA@mail.gmail.com>
Subject: Re: [PATCH v3] md/raid10: don't call bio_start_io_acct twice for bio
 which experienced read error
To:     Yu Kuai <yukuai1@huaweicloud.com>
Cc:     guoqing.jiang@linux.dev, jgq516@gmail.com,
        linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
        yukuai3@huawei.com, yi.zhang@huawei.com, yangerkun@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 13, 2023 at 6:23=E2=80=AFPM Yu Kuai <yukuai1@huaweicloud.com> w=
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
> Suggested-by: Song Liu <song@kernel.org>
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>

Applied to md-next.

Thanks!
Song

> ---
> Changes in v3:
>  - use r10_bo->start_time instead of adding a new paramater.
> Changes in v3:
>  - Change the patch title
>
>  drivers/md/raid10.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/md/raid10.c b/drivers/md/raid10.c
> index 6c66357f92f5..3483fdf796ec 100644
> --- a/drivers/md/raid10.c
> +++ b/drivers/md/raid10.c
> @@ -1244,7 +1244,8 @@ static void raid10_read_request(struct mddev *mddev=
, struct bio *bio,
>         }
>         slot =3D r10_bio->read_slot;
>
> -       if (blk_queue_io_stat(bio->bi_bdev->bd_disk->queue))
> +       if (!r10_bio->start_time &&
> +           blk_queue_io_stat(bio->bi_bdev->bd_disk->queue))
>                 r10_bio->start_time =3D bio_start_io_acct(bio);
>         read_bio =3D bio_alloc_clone(rdev->bdev, bio, gfp, &mddev->bio_se=
t);
>
> @@ -1574,6 +1575,7 @@ static void __make_request(struct mddev *mddev, str=
uct bio *bio, int sectors)
>         r10_bio->sector =3D bio->bi_iter.bi_sector;
>         r10_bio->state =3D 0;
>         r10_bio->read_slot =3D -1;
> +       r10_bio->start_time =3D 0;
>         memset(r10_bio->devs, 0, sizeof(r10_bio->devs[0]) *
>                         conf->geo.raid_disks);
>
> --
> 2.31.1
>
