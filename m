Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 945A070C48A
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 19:43:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231548AbjEVRns (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 13:43:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230497AbjEVRnq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 13:43:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C305102;
        Mon, 22 May 2023 10:43:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 17AF961B9A;
        Mon, 22 May 2023 17:43:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79EC4C433A0;
        Mon, 22 May 2023 17:43:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684777424;
        bh=FPI0mwoLZ5/oBKUdoSwgVmYtrOqGTpFHFh0y0gbMjWA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=cSLQWihBcB32CrS+msyB6IgPvV9pCt+wGLAkfGePv690HJTByP3Cxij8KcsFsqzRl
         yfr08frVrF8Kan+1Vsqxb8sYkYeAQg4xskJFNXGJBhNDd3XmBoV+Uz2jb2jmus5z/f
         6sfhiLomD8X28/pYNLmprqXed2CV9W4aPETqT+L/8Oo636umSxqFvH1F3c3AmZS5lM
         4wt9idbXevTOlAU4Ea5SPdYaxgvp9KMdKggwTKeUZGArpn18vrNV9ueffMovX98Cxe
         slWYvGG8Jen1CwPwDh4p620BLH7zGl3iHbztq2KR7xzmQkoGLY3DJ4QbUKDFT1r0L0
         TZHdVjvTX7PfQ==
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2af30a12e84so26881551fa.0;
        Mon, 22 May 2023 10:43:44 -0700 (PDT)
X-Gm-Message-State: AC+VfDy//03p0UueotKELnwO43uzxyxjObmAWzTAzgczd5Y6xUrSVCqV
        NFm62FUtsZFt9oNgJgPw7A4b83IC+cyrQOm3M3w=
X-Google-Smtp-Source: ACHHUZ76vzBhVq9PXdgDf9riYPp3vy4us4IUm+EYpKtvwPWjCWqG5o4t7pLmJQRvH0SGdI506l2Dh+6hENXf9auLDwA=
X-Received: by 2002:a2e:8093:0:b0:2af:2fb0:923c with SMTP id
 i19-20020a2e8093000000b002af2fb0923cmr2690082ljg.17.1684777422459; Mon, 22
 May 2023 10:43:42 -0700 (PDT)
MIME-Version: 1.0
References: <20230522072535.1523740-1-linan666@huaweicloud.com> <20230522072535.1523740-4-linan666@huaweicloud.com>
In-Reply-To: <20230522072535.1523740-4-linan666@huaweicloud.com>
From:   Song Liu <song@kernel.org>
Date:   Mon, 22 May 2023 10:43:30 -0700
X-Gmail-Original-Message-ID: <CAPhsuW7h-b1ocai=Ax+Kmyok8c3PfMQW8WfWfpTceuW=LH5rkg@mail.gmail.com>
Message-ID: <CAPhsuW7h-b1ocai=Ax+Kmyok8c3PfMQW8WfWfpTceuW=LH5rkg@mail.gmail.com>
Subject: Re: [PATCH v4 3/3] md/raid10: optimize check_decay_read_errors()
To:     linan666@huaweicloud.com
Cc:     neilb@suse.de, Rob.Becker@riverbed.com, linux-raid@vger.kernel.org,
        linux-kernel@vger.kernel.org, linan122@huawei.com,
        yukuai3@huawei.com, yi.zhang@huawei.com, houtao1@huawei.com,
        yangerkun@huawei.com
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

On Mon, May 22, 2023 at 12:27=E2=80=AFAM <linan666@huaweicloud.com> wrote:
>
> From: Li Nan <linan122@huawei.com>
>
> check_decay_read_errors() is used to handle rdev->read_errors. But
> read_errors is inc and read after check_decay_read_errors() is invoked
> in fix_read_error().
>
> Put all operations of read_errors into check_decay_read_errors() and
> clean up unnecessary atomic_read of read_errors.

If I understand correctly, this patch doesn't change the behavior of the
code. If this is the case, I guess we don't really need it. The original co=
de
looks reasonable to me.

Thanks,
Song

>
> Suggested-by: Yu Kuai <yukuai3@huawei.com>
> Signed-off-by: Li Nan <linan122@huawei.com>
> ---
>  drivers/md/raid10.c | 41 ++++++++++++++++++++++++-----------------
>  1 file changed, 24 insertions(+), 17 deletions(-)
>
> diff --git a/drivers/md/raid10.c b/drivers/md/raid10.c
> index 4fcfcb350d2b..d31eed17f186 100644
> --- a/drivers/md/raid10.c
> +++ b/drivers/md/raid10.c
> @@ -2655,23 +2655,24 @@ static void recovery_request_write(struct mddev *=
mddev, struct r10bio *r10_bio)
>  }
>
>  /*
> - * Used by fix_read_error() to decay the per rdev read_errors.
> + * Used by fix_read_error() to decay the per rdev read_errors and check =
if
> + * read_error > max_read_errors.
>   * We halve the read error count for every hour that has elapsed
>   * since the last recorded read error.
>   *
>   */
> -static void check_decay_read_errors(struct mddev *mddev, struct md_rdev =
*rdev)
> +static bool check_decay_read_errors(struct mddev *mddev, struct md_rdev =
*rdev)
>  {
> -       long cur_time_mon;
> +       time64_t cur_time_mon =3D ktime_get_seconds();
>         unsigned long hours_since_last;
> -       unsigned int read_errors =3D atomic_read(&rdev->read_errors);
> -
> -       cur_time_mon =3D ktime_get_seconds();
> +       unsigned int read_errors;
> +       unsigned int max_read_errors =3D
> +                       atomic_read(&mddev->max_corr_read_errors);
>
>         if (rdev->last_read_error =3D=3D 0) {
>                 /* first time we've seen a read error */
>                 rdev->last_read_error =3D cur_time_mon;
> -               return;
> +               goto increase;
>         }
>
>         hours_since_last =3D (long)(cur_time_mon -
> @@ -2684,10 +2685,25 @@ static void check_decay_read_errors(struct mddev =
*mddev, struct md_rdev *rdev)
>          * just set read errors to 0. We do this to avoid
>          * overflowing the shift of read_errors by hours_since_last.
>          */
> +       read_errors =3D atomic_read(&rdev->read_errors);
>         if (hours_since_last >=3D 8 * sizeof(read_errors))
>                 atomic_set(&rdev->read_errors, 0);
>         else
>                 atomic_set(&rdev->read_errors, read_errors >> hours_since=
_last);
> +
> +increase:
> +       read_errors =3D atomic_inc_return(&rdev->read_errors);
> +       if (read_errors > max_read_errors) {
> +               pr_notice("md/raid10:%s: %pg: Raid device exceeded read_e=
rror threshold [cur %d:max %d]\n",
> +                         mdname(mddev), rdev->bdev,
> +                         read_errors, max_read_errors);
> +               pr_notice("md/raid10:%s: %pg: Failing raid device\n",
> +                         mdname(mddev), rdev->bdev);
> +               md_error(mddev, rdev);
> +               return false;
> +       }
> +
> +       return true;
>  }
>
>  static int r10_sync_page_io(struct md_rdev *rdev, sector_t sector,
> @@ -2727,7 +2743,6 @@ static void fix_read_error(struct r10conf *conf, st=
ruct mddev *mddev, struct r10
>         int sect =3D 0; /* Offset from r10_bio->sector */
>         int sectors =3D r10_bio->sectors;
>         struct md_rdev *rdev;
> -       int max_read_errors =3D atomic_read(&mddev->max_corr_read_errors)=
;
>         int d =3D r10_bio->devs[r10_bio->read_slot].devnum;
>
>         /* still own a reference to this rdev, so it cannot
> @@ -2740,15 +2755,7 @@ static void fix_read_error(struct r10conf *conf, s=
truct mddev *mddev, struct r10
>                    more fix_read_error() attempts */
>                 return;
>
> -       check_decay_read_errors(mddev, rdev);
> -       atomic_inc(&rdev->read_errors);
> -       if (atomic_read(&rdev->read_errors) > max_read_errors) {
> -               pr_notice("md/raid10:%s: %pg: Raid device exceeded read_e=
rror threshold [cur %d:max %d]\n",
> -                         mdname(mddev), rdev->bdev,
> -                         atomic_read(&rdev->read_errors), max_read_error=
s);
> -               pr_notice("md/raid10:%s: %pg: Failing raid device\n",
> -                         mdname(mddev), rdev->bdev);
> -               md_error(mddev, rdev);
> +       if (!check_decay_read_errors(mddev, rdev)) {
>                 r10_bio->devs[r10_bio->read_slot].bio =3D IO_BLOCKED;
>                 return;
>         }
> --
> 2.31.1
>
