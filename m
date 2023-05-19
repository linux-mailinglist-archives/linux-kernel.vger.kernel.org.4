Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 196A370A338
	for <lists+linux-kernel@lfdr.de>; Sat, 20 May 2023 01:16:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229586AbjESXQB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 19:16:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjESXP7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 19:15:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 634B812C;
        Fri, 19 May 2023 16:15:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EA72F6185C;
        Fri, 19 May 2023 23:15:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CC28C4339C;
        Fri, 19 May 2023 23:15:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684538157;
        bh=ctggW45C4qZN8MuWcqhIdXG6lIrQzs/0cq7htlpYDEI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=B4qFPiGv49KaRZpopjCHOOA9NpD0pCgROgb+Lxy5D38uVkKvMcniVC1nN+AlLT+EZ
         FSBu9Y4PmABl0/hyE8DA2aO3GhgmyXsIk/usuDqi6KZJWeu8CncEfF7eTbfNdlPedD
         W12avD3+cWws/bCIcVoB5rWyK44YowaXmgeybQaPXmWoPa4L1zS9Mlvx5rDC+rgsRO
         1u6scsRQ+9vcILPLyCMd638oyRiwEu5GOet+r8OnLDJXzox6mB4qSF/AZZ9nqos8Yd
         /JnzVJrALq73MlumazBRBRBSfuECFPDuBkTgxjfFMi9VfGF2jfnLuDL701QhXguwub
         8Dx+4kabES1DQ==
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-4f37b860173so4228504e87.2;
        Fri, 19 May 2023 16:15:57 -0700 (PDT)
X-Gm-Message-State: AC+VfDxgkdsQzORnpgFbuGXGXgkRnR/R8+5D5GIPAwy/h+GIQjgIDWVF
        uliabXgSDx3cSmD5ezTv8gI2Cp2W9JA0eOrd4Lk=
X-Google-Smtp-Source: ACHHUZ4CaSj5wtRzcuyIbCsxD3oP6c+ReR1E4DO0JFM9No3bCyE4JZQg/16rPJwOgv4M0GUkxJvS5SoAB5Vg1FW68T4=
X-Received: by 2002:ac2:5233:0:b0:4f2:4d6c:b30b with SMTP id
 i19-20020ac25233000000b004f24d6cb30bmr1297795lfl.68.1684538155294; Fri, 19
 May 2023 16:15:55 -0700 (PDT)
MIME-Version: 1.0
References: <20230428071059.1988153-1-yukuai1@huaweicloud.com>
In-Reply-To: <20230428071059.1988153-1-yukuai1@huaweicloud.com>
From:   Song Liu <song@kernel.org>
Date:   Fri, 19 May 2023 16:15:43 -0700
X-Gmail-Original-Message-ID: <CAPhsuW75ufS+t-Q=GaXP__VOt9Wf8cZKMBMXEXaVWWS=5bN8ew@mail.gmail.com>
Message-ID: <CAPhsuW75ufS+t-Q=GaXP__VOt9Wf8cZKMBMXEXaVWWS=5bN8ew@mail.gmail.com>
Subject: Re: [PATCH -next] md: fix duplicate filename for rdev
To:     Yu Kuai <yukuai1@huaweicloud.com>
Cc:     neilb@suse.de, akpm@linux-foundation.org,
        linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
        yukuai3@huawei.com, yi.zhang@huawei.com, yangerkun@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 28, 2023 at 12:13=E2=80=AFAM Yu Kuai <yukuai1@huaweicloud.com> =
wrote:
>
> From: Yu Kuai <yukuai3@huawei.com>
>
> commit 5792a2856a63 ("[PATCH] md: avoid a deadlock when removing a device
> from an md array via sysfs") delay the deleting of rdev, however, this
> introduce a window that rdev can be added again while the deleting is
> not done yet, and sysfs will complain about duplicate filename.
>
> Follow up patches try to fix this problem by flush workqueue, however,
> flush_rdev_wq() is just dead code, the progress in
> md_kick_rdev_from_array():
>
> 1) list_del_rcu(&rdev->same_set);
> 2) synchronize_rcu();
> 3) queue_work(md_rdev_misc_wq, &rdev->del_work);
>
> So in flush_rdev_wq(), if rdev is found in the list, work_pending() can
> never pass, in the meantime, if work is queued, then rdev can never be
> found in the list.
>
> flush_rdev_wq() can be replaced by flush_workqueue() directly, however,
> this approach is not good:
> - the workqueue is global, this synchronization for all raid disks is
>   not necessary.
> - flush_workqueue can't be called under 'reconfig_mutex', there is still
>   a small window between flush_workqueue() and mddev_lock() that other
>   context can queue new work, hence the problem is not solved completely.
>
> sysfs already have apis to support delete itself through writer, and
> these apis, specifically sysfs_break/unbreak_active_protection(), is used
> so support deleting rdev synchronously. Therefore, the above commit can b=
e
> reverted, and sysfs duplicate filename can be avoided.
>
> A new mdadm regression test [1] is proposed as well.
>
> Link: https://lore.kernel.org/linux-raid/20230428062845.1975462-1-yukuai1=
@huaweicloud.com/
> Fixes: 5792a2856a63 ("[PATCH] md: avoid a deadlock when removing a device=
 from an md array via sysfs")
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
> ---
>  drivers/md/md.c | 85 +++++++++++++++++++++++++------------------------
>  drivers/md/md.h |  8 +++++
>  2 files changed, 51 insertions(+), 42 deletions(-)
>
> diff --git a/drivers/md/md.c b/drivers/md/md.c
> index 0a4a10d4c0e0..e1bc223d58b3 100644
> --- a/drivers/md/md.c
> +++ b/drivers/md/md.c
> @@ -83,12 +83,12 @@ static struct module *md_cluster_mod;
>  static DECLARE_WAIT_QUEUE_HEAD(resync_wait);
>  static struct workqueue_struct *md_wq;
>  static struct workqueue_struct *md_misc_wq;
> -static struct workqueue_struct *md_rdev_misc_wq;
>
>  static int remove_and_add_spares(struct mddev *mddev,
>                                  struct md_rdev *this);
>  static void mddev_detach(struct mddev *mddev);
>  static void md_wakeup_thread_directly(struct md_thread __rcu *thread);
> +static void export_rdev(struct md_rdev *rdev);

There is some conflict with md_wakeup_thread_directly().
I guess you run format-patch on top of the "protect md_thread" set
which is not merged yet (and we are waiting for v8 of it?).

Please redo the patch on top of the latest md-next. I just updated it.

Thanks,
Song
