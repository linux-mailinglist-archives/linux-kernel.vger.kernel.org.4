Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A10CE6B84B6
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 23:25:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229789AbjCMWZH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 18:25:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230131AbjCMWY6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 18:24:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E28D2637E8;
        Mon, 13 Mar 2023 15:24:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8215661520;
        Mon, 13 Mar 2023 22:24:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5BB9C4339B;
        Mon, 13 Mar 2023 22:24:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678746295;
        bh=NvFiLiJrQH6NUVzgS1QQsUP1+Drn7VRsdLOWQ3FKSjM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=AJqX7M2k7RdSnIDmu5DnNXY4xcDzaL5VwJNFMhCcpOS+/eqOQrgkr1OrZ8wAxFVpM
         lJvviDrh5aMn5CzpF4V3zDYPZ3XFKe+DNetz6O6QiEw/3iQ+z1qj0HdkG/PSYCNf7I
         KATTv5AMRD2AA0PlX4IOMxl4zzWypaIosxTzxEbmbf2w/2D+j7w33tCKToTw5AmlxH
         KqogK2FwitL3SwgtcM9EmLLfvAOfGmhTqeR4LDjS7PbZq7fCw0nVjD0WmQ/hASAKR0
         TwInxibj02Gl57kl/lLSmO1xjzJ0zRWyl4SKUR6O+OT10T3J2ChhNNL2mc4KM0uuth
         lrZnQy09nKmsg==
Received: by mail-lf1-f54.google.com with SMTP id n2so17587215lfb.12;
        Mon, 13 Mar 2023 15:24:55 -0700 (PDT)
X-Gm-Message-State: AO0yUKV/NclZG7kcAOql+wcf5drQTRH342+ik/pWXNoiYtN33ZPEeLPc
        sylaULPRWkqOtb+do7tTgAOJmKfLQhiDjNtGiao=
X-Google-Smtp-Source: AK7set+SFmA1qMTjX2b1JzjqoC3XjTjjiAL8tiyvErio3S2pUEaGFKVWgpBdNILikN6wbQY0GNSrUcjZa6aP7YTNeNw=
X-Received: by 2002:a05:6512:3e06:b0:4d8:86c2:75ea with SMTP id
 i6-20020a0565123e0600b004d886c275eamr54985lfv.3.1678746293916; Mon, 13 Mar
 2023 15:24:53 -0700 (PDT)
MIME-Version: 1.0
References: <20230310073855.1337560-1-yukuai1@huaweicloud.com> <20230310073855.1337560-3-yukuai1@huaweicloud.com>
In-Reply-To: <20230310073855.1337560-3-yukuai1@huaweicloud.com>
From:   Song Liu <song@kernel.org>
Date:   Mon, 13 Mar 2023 15:24:41 -0700
X-Gmail-Original-Message-ID: <CAPhsuW6eYdWgGyZjnXcT4yY4y-pcy3eEzc8uanStNz9aEGeGLg@mail.gmail.com>
Message-ID: <CAPhsuW6eYdWgGyZjnXcT4yY4y-pcy3eEzc8uanStNz9aEGeGLg@mail.gmail.com>
Subject: Re: [PATCH v2 2/6] md: fix soft lockup in status_resync
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
> status_resync() will calculate 'curr_resync - recovery_active' to show
> user a progress bar like following:
>
> [=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D>........]  resync =3D 61.4%
>
> 'curr_resync' and 'recovery_active' is updated in md_do_sync(), and
> status_resync() can read them concurrently, hence it's possible that
> 'curr_resync - recovery_active' can overflow to a huge number. In this
> case status_resync() will be stuck in the loop to print a large amount
> of '=3D', which will end up soft lockup.
>
> Fix the problem by setting 'resync' to MD_RESYNC_ACTIVE in this case,
> this way resync in progress will be reported to user.
>
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>

Looks good. Applied to md-next.

Thanks,
Song

> ---
>  drivers/md/md.c | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/md/md.c b/drivers/md/md.c
> index 546b1b81eb28..98970bbe32bf 100644
> --- a/drivers/md/md.c
> +++ b/drivers/md/md.c
> @@ -8009,16 +8009,16 @@ static int status_resync(struct seq_file *seq, st=
ruct mddev *mddev)
>         } else if (resync > max_sectors) {
>                 resync =3D max_sectors;
>         } else {
> -               resync -=3D atomic_read(&mddev->recovery_active);
> -               if (resync < MD_RESYNC_ACTIVE) {
> -                       /*
> -                        * Resync has started, but the subtraction has
> -                        * yielded one of the special values. Force it
> -                        * to active to ensure the status reports an
> -                        * active resync.
> -                        */
> +               res =3D atomic_read(&mddev->recovery_active);
> +               /*
> +                * Resync has started, but the subtraction has overflowed=
 or
> +                * yielded one of the special values. Force it to active =
to
> +                * ensure the status reports an active resync.
> +                */
> +               if (resync < res || resync - res < MD_RESYNC_ACTIVE)
>                         resync =3D MD_RESYNC_ACTIVE;
> -               }
> +               else
> +                       resync -=3D res;
>         }
>
>         if (resync =3D=3D MD_RESYNC_NONE) {
> --
> 2.31.1
>
