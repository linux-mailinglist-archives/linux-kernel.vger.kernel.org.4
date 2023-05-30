Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BD86716F94
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 23:19:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233512AbjE3VTq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 17:19:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233487AbjE3VTl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 17:19:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47CF8C0;
        Tue, 30 May 2023 14:19:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7E24062F3C;
        Tue, 30 May 2023 21:19:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0A0FC4339C;
        Tue, 30 May 2023 21:19:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685481577;
        bh=x1WXJBWs1R1xNOMa9KVhJe1bPYDSGGPqeWby99Rl4KM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=YoBZLT166OA3IK+OARQl7e/GQyfRWN5bLEMHVez7tqmfzEpFp+uFwZ04S+BiYEyeY
         4ZzSy6LBpqXfofyobBRIUHCglvbWXWrXWs2Cqu2LqBqlvqF5lItViTcSGz7gUzdQHW
         oHMEN/pTbkvrzKCyoBRPOWWuf/1N70lfvd0Vzyo/s3ZKhcETGFd3nFewosEMa1KrPb
         EwyyqvTe3y5mCn6Uxnlz3bqE99e8FU7cBpCYzO5gwD3PJ9YNijaGKDQqIjq/ZSHEWE
         yvhtPeXUGjx4UT3iDVs2PCmPUO49jzCVq+Xognpd8qaDeNDtrMbb2d1JEpAg+hgg+R
         48ufzYx4xXtrQ==
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2af2696fd1cso53607671fa.2;
        Tue, 30 May 2023 14:19:37 -0700 (PDT)
X-Gm-Message-State: AC+VfDy41zxVwP7L2Tm6IYgjczLoHJvTpOP1EWMRPVswrqKr1W1fU4bK
        agjdqNN5vHjSfyCU5C+w8QHgb1YI7PX90r151ww=
X-Google-Smtp-Source: ACHHUZ50CxTVWRPnaqHdS4xNXnfhDSKJXeFBM5qXJvW9Fadn/thQZqB2MNjJGusDUKqnhOtYkpRuSQWr/Md4S449Jao=
X-Received: by 2002:a2e:9e15:0:b0:2b0:486c:3102 with SMTP id
 e21-20020a2e9e15000000b002b0486c3102mr1488666ljk.10.1685481575947; Tue, 30
 May 2023 14:19:35 -0700 (PDT)
MIME-Version: 1.0
References: <20230529133410.2125914-1-yukuai1@huaweicloud.com>
In-Reply-To: <20230529133410.2125914-1-yukuai1@huaweicloud.com>
From:   Song Liu <song@kernel.org>
Date:   Tue, 30 May 2023 14:19:23 -0700
X-Gmail-Original-Message-ID: <CAPhsuW7n0iwBxEOpSAz-svFOqMM3Rc7Xini29jn+NNMUS8-2sg@mail.gmail.com>
Message-ID: <CAPhsuW7n0iwBxEOpSAz-svFOqMM3Rc7Xini29jn+NNMUS8-2sg@mail.gmail.com>
Subject: Re: [PATCH v2] md/raid5: don't allow concurrent reshape with recovery
To:     Yu Kuai <yukuai1@huaweicloud.com>
Cc:     pmenzel@molgen.mpg.de, linux-raid@vger.kernel.org,
        linux-kernel@vger.kernel.org, yukuai3@huawei.com,
        yi.zhang@huawei.com, yangerkun@huawei.com
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

On Mon, May 29, 2023 at 6:37=E2=80=AFAM Yu Kuai <yukuai1@huaweicloud.com> w=
rote:
>
> From: Yu Kuai <yukuai3@huawei.com>
>
> Commit 0aecb06e2249 ("md/raid5: don't allow replacement while reshape
> is in progress") fixes that replacement can be set if reshape is
> interrupted, which will cause that array can't be assembled.
>
> There is a similar problem on the other side, if recovery is
> interrupted, then reshape can start, which will cause the same problem.
>
> Fix the problem by not starting to reshape while recovery is still in
> progress.
>
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>

Applied to md-next.

Thanks,
Song

> ---
> Changes in v2:
>  - fix some typo in commit message.
>
>  drivers/md/raid5.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/drivers/md/raid5.c b/drivers/md/raid5.c
> index 8686d629e3f2..6615abf54d3f 100644
> --- a/drivers/md/raid5.c
> +++ b/drivers/md/raid5.c
> @@ -8525,6 +8525,7 @@ static int raid5_start_reshape(struct mddev *mddev)
>         struct r5conf *conf =3D mddev->private;
>         struct md_rdev *rdev;
>         int spares =3D 0;
> +       int i;
>         unsigned long flags;
>
>         if (test_bit(MD_RECOVERY_RUNNING, &mddev->recovery))
> @@ -8536,6 +8537,13 @@ static int raid5_start_reshape(struct mddev *mddev=
)
>         if (has_failed(conf))
>                 return -EINVAL;
>
> +       /* raid5 can't handle concurrent reshape and recovery */
> +       if (mddev->recovery_cp < MaxSector)
> +               return -EBUSY;
> +       for (i =3D 0; i < conf->raid_disks; i++)
> +               if (rdev_mdlock_deref(mddev, conf->disks[i].replacement))
> +                       return -EBUSY;
> +
>         rdev_for_each(rdev, mddev) {
>                 if (!test_bit(In_sync, &rdev->flags)
>                     && !test_bit(Faulty, &rdev->flags))
> --
> 2.39.2
>
