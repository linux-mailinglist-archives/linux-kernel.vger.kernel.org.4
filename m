Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B557C717004
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 23:56:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232804AbjE3V4F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 17:56:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230399AbjE3V4D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 17:56:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EC8FAA;
        Tue, 30 May 2023 14:56:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id ABFD563428;
        Tue, 30 May 2023 21:56:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 155E0C4339B;
        Tue, 30 May 2023 21:56:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685483761;
        bh=Ab636SorLnuyDFcIFL0cr5qH3o9zsfvAyUFNn1onptE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=LD90/uFvg1c9KtUp5XlCN6TLyRrLVWiD/k1mAkB6LTHMyhkKat/JuAR2MZIgSuDzo
         ov48JowkudsOWCQmJYqWBhSSCkwtRyZhMf7fxz31zkTBfbgf7FGMmslcBPGhAaZ7vC
         Kto1pIX9ZiYOGXuEITuPjeozzGJ2WwSn0JNKgietL5W5YTe2jeIwltrNo6vXzTdszN
         x9ybVggT5nV1Ae5yMkEZzds94bsE1I5Lbnl39uYbXN4Uo/FYrbYY/U4xZuAGOy1YsT
         4wRK/5ipoafDM7eIJ9cKhWUQK9ZOUkrC8WTMwziy8c5JYeUwMk50mKJz70sUJuBD+i
         wCuTC9xh4F97w==
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-4f4b256a0c9so5618556e87.2;
        Tue, 30 May 2023 14:56:00 -0700 (PDT)
X-Gm-Message-State: AC+VfDwELUuymbal/WntEX3MW+zdk/lxHL+GwFmeIZdG7fFnOlo3rIHD
        /NYNsF1yI9u/FKmmiB7eStJphzzosSJqpaG39hs=
X-Google-Smtp-Source: ACHHUZ4zr978lSzTsVGiCf+DXNhcvkMtgDHh9kSk0Aqpbcc7UaKTx/R5piztamZfuAB6rp/+2+KeTsQGvIBfYxcdF+M=
X-Received: by 2002:a05:6512:69:b0:4f1:1de7:1aac with SMTP id
 i9-20020a056512006900b004f11de71aacmr1379883lfo.20.1685483759116; Tue, 30 May
 2023 14:55:59 -0700 (PDT)
MIME-Version: 1.0
References: <20230527072218.2365857-1-linan666@huaweicloud.com> <20230527072218.2365857-4-linan666@huaweicloud.com>
In-Reply-To: <20230527072218.2365857-4-linan666@huaweicloud.com>
From:   Song Liu <song@kernel.org>
Date:   Tue, 30 May 2023 14:55:47 -0700
X-Gmail-Original-Message-ID: <CAPhsuW7ZeiFNoiY=-EVwj67FhnaW5rphkkumBrSCdtHHgBxzNw@mail.gmail.com>
Message-ID: <CAPhsuW7ZeiFNoiY=-EVwj67FhnaW5rphkkumBrSCdtHHgBxzNw@mail.gmail.com>
Subject: Re: [PATCH v3 3/4] md/raid10: fix incorrect done of recovery
To:     linan666@huaweicloud.com
Cc:     bingjingc@synology.com, allenpeng@synology.com, shli@fb.com,
        alexwu@synology.com, neilb@suse.de, linux-raid@vger.kernel.org,
        linux-kernel@vger.kernel.org, linan122@huawei.com,
        yukuai3@huawei.com, yi.zhang@huawei.com, houtao1@huawei.com,
        yangerkun@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 27, 2023 at 12:24=E2=80=AFAM <linan666@huaweicloud.com> wrote:
>
> From: Li Nan <linan122@huawei.com>
>
> Recovery will go to giveup and let chunks_skipped++ in
> raid10_sync_request() if there are some bad_blocks, and it will return
> max_sector when chunks_skipped >=3D geo.raid_disks. Now, recovery fail an=
d
> data is inconsistent but user think recovery is done, it is wrong.
>
> Fix it by set mirror's recovery_disabled, spare device will not  be added
> to here. The same issue alos exists on resync, it will be fixd in future.
>
> Signed-off-by: Li Nan <linan122@huawei.com>

I applied 1/4 and 2/4 of the set to md-next.

For 3/4 and 4/4, please improve the commit log (rephrase confusing statemen=
ts,
fix typo's, etc.). Please also add a mdadm test for 3/4.

Thanks,
Song

> ---
>  drivers/md/raid10.c | 18 +++++++++++++++++-
>  1 file changed, 17 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/md/raid10.c b/drivers/md/raid10.c
> index d93d8cb2b620..3ba1516ea160 100644
> --- a/drivers/md/raid10.c
> +++ b/drivers/md/raid10.c
> @@ -3303,6 +3303,7 @@ static sector_t raid10_sync_request(struct mddev *m=
ddev, sector_t sector_nr,
>         int chunks_skipped =3D 0;
>         sector_t chunk_mask =3D conf->geo.chunk_mask;
>         int page_idx =3D 0;
> +       int error_disk =3D -1;
>
>         /*
>          * Allow skipping a full rebuild for incremental assembly
> @@ -3386,7 +3387,20 @@ static sector_t raid10_sync_request(struct mddev *=
mddev, sector_t sector_nr,
>                 return reshape_request(mddev, sector_nr, skipped);
>
>         if (chunks_skipped >=3D conf->geo.raid_disks) {
> -               /* if there has been nothing to do on any drive,
> +               pr_err("md/raid10:%s: %s fail\n", mdname(mddev),
> +                       test_bit(MD_RECOVERY_SYNC, &mddev->recovery) ?  "=
resync" : "recovery");
> +               if (error_disk >=3D 0 &&
> +                   !test_bit(MD_RECOVERY_SYNC, &mddev->recovery)) {
> +                       /*
> +                        * recovery fail, set mirrors.recovory_disabled,
> +                        * device shouldn't be added to there.
> +                        */
> +                       conf->mirrors[error_disk].recovery_disabled =3D
> +                                               mddev->recovery_disabled;
> +                       return 0;
> +               }
> +               /*
> +                * if there has been nothing to do on any drive,
>                  * then there is nothing to do at all..
>                  */
>                 *skipped =3D 1;
> @@ -3638,6 +3652,8 @@ static sector_t raid10_sync_request(struct mddev *m=
ddev, sector_t sector_nr,
>                                                        mdname(mddev));
>                                         mirror->recovery_disabled
>                                                 =3D mddev->recovery_disab=
led;
> +                               } else {
> +                                       error_disk =3D i;
>                                 }
>                                 put_buf(r10_bio);
>                                 if (rb2)
> --
> 2.31.1
>
