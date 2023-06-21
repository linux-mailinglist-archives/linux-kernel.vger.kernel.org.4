Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05CF07392EC
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 01:13:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229773AbjFUXM6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 19:12:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjFUXM4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 19:12:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4610BC;
        Wed, 21 Jun 2023 16:12:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 33780616FD;
        Wed, 21 Jun 2023 23:12:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9658AC433C0;
        Wed, 21 Jun 2023 23:12:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687389174;
        bh=JfnF/TpSrmEJx8kCqNg6b06ZNb97Ka3wj6EXxtNhFq8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=DKuy/kRHktyLJ8w1WPfrGZGtEd7Tk9LHK61+rRYS/0gg+xjfuYuLVF5gVJfaRE/Z3
         frk/maU8fpNlXIEBhxRJFbMP750kGJXP1c4m0e8GblT+2S7XqfjuAoll7MWDmPvL0w
         F0RcibXGg22z7MKWnt2x/6ZWcrqBVCj4Lp1ZZZkBpunE3zfombs+EYuMZPawwEMDVd
         +V2cSsSYBZhikCO/9Cdi82P9oYMjbYR+ERrsmQy9GixzG5/wcEcw2P70F1rSSWyk2R
         PEkrDyZL1tH6r/DRmsWHPtGqCFHhCSF7vYkZhGYPKnQlMX/n4PvXaxl5yOQ+IgCzNG
         l+Clb2ngW/IKg==
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2b46f1256bbso784191fa.0;
        Wed, 21 Jun 2023 16:12:54 -0700 (PDT)
X-Gm-Message-State: AC+VfDxa10Y1QUTFTqytxdfsHgyDNBkpR5aLk1uR6+9bWcSWMks+jGNS
        ey9Ivhy8H5SXyGl6PAgKbT/LetfpFM0WFkDuRBA=
X-Google-Smtp-Source: ACHHUZ78Pvzh12zdbL3zmXXhiq51DBjD2HMVUc4E7SwgX1HyeMdhFY8OyIZwL1eUfduN/PZ2lj+CkXZnPo7EqccrLX8=
X-Received: by 2002:a19:5007:0:b0:4f8:52a8:d123 with SMTP id
 e7-20020a195007000000b004f852a8d123mr5815627lfb.12.1687389172627; Wed, 21 Jun
 2023 16:12:52 -0700 (PDT)
MIME-Version: 1.0
References: <20230621105728.1268542-1-yukuai1@huaweicloud.com>
In-Reply-To: <20230621105728.1268542-1-yukuai1@huaweicloud.com>
From:   Song Liu <song@kernel.org>
Date:   Wed, 21 Jun 2023 16:12:40 -0700
X-Gmail-Original-Message-ID: <CAPhsuW5Th2Q9xbP3-ayteNVcHjiPRKpM0agS0u9KP4YG+vxk7g@mail.gmail.com>
Message-ID: <CAPhsuW5Th2Q9xbP3-ayteNVcHjiPRKpM0agS0u9KP4YG+vxk7g@mail.gmail.com>
Subject: Re: [PATCH v2] raid10: avoid spin_lock from fastpath from raid10_unplug()
To:     Yu Kuai <yukuai1@huaweicloud.com>
Cc:     pmenzel@molgen.mpg.de, linux-raid@vger.kernel.org,
        linux-kernel@vger.kernel.org, yukuai3@huawei.com,
        yi.zhang@huawei.com, yangerkun@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 20, 2023 at 7:59=E2=80=AFPM Yu Kuai <yukuai1@huaweicloud.com> w=
rote:
>
> From: Yu Kuai <yukuai3@huawei.com>
>
> Commit 0c0be98bbe67 ("md/raid10: prevent unnecessary calls to wake_up()
> in fast path") missed one place, for example, with:
>
>         fio -direct=3D1 -rw=3Dwrite/randwrite -iodepth=3D1 ...
>
> Plug and unplug are called for each io, then wake_up() from raid10_unplug=
()
> will cause lock contention as well.
>
> Avoid this contention by using wake_up_barrier() instead of wake_up(),
> where spin_lock is not held if waitqueue is empty.
>
> Fio test script:
>
> [global]
> name=3Drandom reads and writes
> ioengine=3Dlibaio
> direct=3D1
> readwrite=3Drandrw
> rwmixread=3D70
> iodepth=3D64
> buffered=3D0
> filename=3D/dev/md0
> size=3D1G
> runtime=3D30
> time_based
> randrepeat=3D0
> norandommap
> refill_buffers
> ramp_time=3D10
> bs=3D4k
> numjobs=3D400
> group_reporting=3D1
> [job1]
>
> Test result with ramdisk raid10(By Ali):
>
>         Before this patch       With this patch
> READ    IOPS=3D2033k              IOPS=3D3642k
> WRITE   IOPS=3D871k               IOPS=3D1561K
>
> By the way, in this scenario, blk_plug_cb() will be allocated and freed
> for each io, this seems need to be optimized as well.
>
> Reported-and-tested-by: Ali Gholami Rudi <aligrudi@gmail.com>
> Closes: https://lore.kernel.org/all/20231606122233@laper.mirepesht/
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>

Applied to md-next.

Thanks,
Song

> ---
> Changes in v2:
>  - update commit message;
>
>  drivers/md/raid10.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/md/raid10.c b/drivers/md/raid10.c
> index d0de8c9fb3cf..fbaaa5e05edc 100644
> --- a/drivers/md/raid10.c
> +++ b/drivers/md/raid10.c
> @@ -1118,7 +1118,7 @@ static void raid10_unplug(struct blk_plug_cb *cb, b=
ool from_schedule)
>                 spin_lock_irq(&conf->device_lock);
>                 bio_list_merge(&conf->pending_bio_list, &plug->pending);
>                 spin_unlock_irq(&conf->device_lock);
> -               wake_up(&conf->wait_barrier);
> +               wake_up_barrier(conf);
>                 md_wakeup_thread(mddev->thread);
>                 kfree(plug);
>                 return;
> @@ -1127,7 +1127,7 @@ static void raid10_unplug(struct blk_plug_cb *cb, b=
ool from_schedule)
>         /* we aren't scheduling, so we can do the write-out directly. */
>         bio =3D bio_list_get(&plug->pending);
>         raid1_prepare_flush_writes(mddev->bitmap);
> -       wake_up(&conf->wait_barrier);
> +       wake_up_barrier(conf);
>
>         while (bio) { /* submit pending writes */
>                 struct bio *next =3D bio->bi_next;
> --
> 2.39.2
>
