Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D0BC70A2AC
	for <lists+linux-kernel@lfdr.de>; Sat, 20 May 2023 00:07:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231335AbjESWHE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 18:07:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229807AbjESWHD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 18:07:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A826124;
        Fri, 19 May 2023 15:07:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B14D965B90;
        Fri, 19 May 2023 22:07:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C22CC433EF;
        Fri, 19 May 2023 22:07:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684534021;
        bh=s/YsWicazEt1ByNo2ZhYLVzSTqCXreOks8GOVcWPROY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=efoboCyzRZJCCM07UJr0jDQo8eJTh5LmaRW8B55khgreWd4m98kkBHvzENNRVGnbp
         sM5ceL9coNiSwwj7IquGZC1ZLVe1qI4TSJejWg/iz5lI5eGU+ZWLVhjEeTbjP51c1F
         J34SNjMzqDqQeMs9yNJKjtXmatKeEyrMxb7tcMi2vwmKBK6lGUJA7kWWMpFTAPw2en
         g9imorb7PUNtQVhyl/3ogbuXeA5o7by174wGB2rVGCcDVYp1psEpjZ6ScGQRQsKXZn
         VpdZcVENXXTW7hZhrkS8KBz9PDjojPp3thZR/QpKkElcq/LCCBbZ21A8Bk3s1+kjSI
         b9R/EpYh+aoGA==
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2af24ee004dso13887771fa.0;
        Fri, 19 May 2023 15:07:00 -0700 (PDT)
X-Gm-Message-State: AC+VfDyO91cQ7eqcgvcWf5GDW/EVZPSsl7mXw9XF+PUpD9Rt/5xjFYLI
        O6Wq9z6n31CpSPuLpyQq8V7N43DuVxswp147aJA=
X-Google-Smtp-Source: ACHHUZ6oO6BudlVQL4HrnAu94lpFnEfpI1CggEtQkEwqnCLkv/OdOdtBPpLot2I9WeDELfDJBD7zXb+mK/AhHjQRROE=
X-Received: by 2002:a2e:97c3:0:b0:2ac:e66c:e91 with SMTP id
 m3-20020a2e97c3000000b002ace66c0e91mr1355985ljj.19.1684534019079; Fri, 19 May
 2023 15:06:59 -0700 (PDT)
MIME-Version: 1.0
References: <20230515134808.3936750-1-linan666@huaweicloud.com> <20230515134808.3936750-4-linan666@huaweicloud.com>
In-Reply-To: <20230515134808.3936750-4-linan666@huaweicloud.com>
From:   Song Liu <song@kernel.org>
Date:   Fri, 19 May 2023 15:06:45 -0700
X-Gmail-Original-Message-ID: <CAPhsuW4SweXwqCN-_z926CSw4+i0-nHKj8wNooKBvV-1YJ1moQ@mail.gmail.com>
Message-ID: <CAPhsuW4SweXwqCN-_z926CSw4+i0-nHKj8wNooKBvV-1YJ1moQ@mail.gmail.com>
Subject: Re: [PATCH OLK-5.10 v3 3/4] md/raid10: fix wrong setting of max_corr_read_errors
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

On Mon, May 15, 2023 at 6:49=E2=80=AFAM <linan666@huaweicloud.com> wrote:
>
> From: Li Nan <linan122@huawei.com>
>
> max_corr_read_errors should not be negative number. Change it to
> unsigned int where use it.
>
> Fixes: 1e50915fe0bb ("raid: improve MD/raid10 handling of correctable rea=
d errors.")
> Signed-off-by: Li Nan <linan122@huawei.com>
> Reviewed-by: Yu Kuai <yukuai3@huawei.com>
> ---
>  drivers/md/md.c     | 2 +-
>  drivers/md/raid10.c | 5 +++--
>  2 files changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/md/md.c b/drivers/md/md.c
> index 5bba071ea907..b69ddfb1662a 100644
> --- a/drivers/md/md.c
> +++ b/drivers/md/md.c
> @@ -4484,7 +4484,7 @@ __ATTR_PREALLOC(array_state, S_IRUGO|S_IWUSR, array=
_state_show, array_state_stor
>
>  static ssize_t
>  max_corrected_read_errors_show(struct mddev *mddev, char *page) {
> -       return sprintf(page, "%d\n",
> +       return sprintf(page, "%u\n",
>                        atomic_read(&mddev->max_corr_read_errors));
>  }

max_corr_read_errors is atomic_t, so a signed integer. So these
signed =3D> unsigned changes are pretty error prone. Can we just
add check in max_corrected_read_errors_store() so we never store
a negative value?

Thanks,
Song

>
> diff --git a/drivers/md/raid10.c b/drivers/md/raid10.c
> index 4fcfcb350d2b..4d615fcc6a50 100644
> --- a/drivers/md/raid10.c
> +++ b/drivers/md/raid10.c
> @@ -2727,7 +2727,8 @@ static void fix_read_error(struct r10conf *conf, st=
ruct mddev *mddev, struct r10
>         int sect =3D 0; /* Offset from r10_bio->sector */
>         int sectors =3D r10_bio->sectors;
>         struct md_rdev *rdev;
> -       int max_read_errors =3D atomic_read(&mddev->max_corr_read_errors)=
;
> +       unsigned int max_read_errors =3D
> +                       atomic_read(&mddev->max_corr_read_errors);
>         int d =3D r10_bio->devs[r10_bio->read_slot].devnum;
>
>         /* still own a reference to this rdev, so it cannot
> @@ -2743,7 +2744,7 @@ static void fix_read_error(struct r10conf *conf, st=
ruct mddev *mddev, struct r10
>         check_decay_read_errors(mddev, rdev);
>         atomic_inc(&rdev->read_errors);
>         if (atomic_read(&rdev->read_errors) > max_read_errors) {
> -               pr_notice("md/raid10:%s: %pg: Raid device exceeded read_e=
rror threshold [cur %d:max %d]\n",
> +               pr_notice("md/raid10:%s: %pg: Raid device exceeded read_e=
rror threshold [cur %u:max %u]\n",
>                           mdname(mddev), rdev->bdev,
>                           atomic_read(&rdev->read_errors), max_read_error=
s);
>                 pr_notice("md/raid10:%s: %pg: Failing raid device\n",
> --
> 2.31.1
>
