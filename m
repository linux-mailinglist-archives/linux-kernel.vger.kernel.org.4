Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 689246EECB5
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 05:20:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239160AbjDZDUp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 23:20:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234013AbjDZDUn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 23:20:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD572E8;
        Tue, 25 Apr 2023 20:20:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 789776322B;
        Wed, 26 Apr 2023 03:20:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D803FC4339C;
        Wed, 26 Apr 2023 03:20:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682479240;
        bh=4m+RAvqrMjRcUw2kjLdDwpF/WMEs396oTUlibMXUvYs=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=NbgQDgBYBEeom+abZUDKMSoqayacAXdNCDcNMnJTK6KDtRbkPQ9XsjZsGottQlNro
         rUNC6m+56NbDmzdwSo2Ine1xDyihkKSIaOMQ7kJUpAlx21TelgTIl1DQ/cDnvZjuuY
         o+DpnC2bIOlrDdcNfLsNyWNDHiftbj0vfGX063/gK9JOje5srxQXZY6KLfn8VfNgMk
         kCvw0lLsW9VkdS4PKRF6cdTGCqE4dq0wu67cepBBwnDlfBDwu6CD3PY7ZMBz6GbvQs
         NLwqv+v755IMTa7F5XhCE2K0/d/TuaPFl5s+omW6XGblevdt9bFx9DyKzG0dUue4MT
         I19+9LrhdoN3A==
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-4f0025f4686so975008e87.3;
        Tue, 25 Apr 2023 20:20:40 -0700 (PDT)
X-Gm-Message-State: AC+VfDx/jp9rTc93T3E/RopLZMrlr8zXIiUSvfYqv7Lmbno6bTLRRCjx
        /cD3ozUvsds90zk1Fbdwk5r8X4Kni1CMNfXDQuE=
X-Google-Smtp-Source: ACHHUZ5ADaJ7wo1hTaXqsoIroeop91b/1N1jV35nqS4ro3YLuajoYqyCwKF2h6JC9ugVPoRWIWesTALupnf5VRBRSOY=
X-Received: by 2002:ac2:569c:0:b0:4ef:f6c9:b977 with SMTP id
 28-20020ac2569c000000b004eff6c9b977mr1526355lfr.49.1682479238845; Tue, 25 Apr
 2023 20:20:38 -0700 (PDT)
MIME-Version: 1.0
References: <20230425115256.3663932-1-yukuai1@huaweicloud.com> <20230425115256.3663932-6-yukuai1@huaweicloud.com>
In-Reply-To: <20230425115256.3663932-6-yukuai1@huaweicloud.com>
From:   Song Liu <song@kernel.org>
Date:   Tue, 25 Apr 2023 20:20:26 -0700
X-Gmail-Original-Message-ID: <CAPhsuW4_tDcmPZbo8Qs32LRxLAQfE6SNNTDys8bOoeHwx-1N=A@mail.gmail.com>
Message-ID: <CAPhsuW4_tDcmPZbo8Qs32LRxLAQfE6SNNTDys8bOoeHwx-1N=A@mail.gmail.com>
Subject: Re: [PATCH -next v7 5/5] md: protect md_thread with rcu
To:     Yu Kuai <yukuai1@huaweicloud.com>
Cc:     logang@deltatee.com, axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org,
        yukuai3@huawei.com, yi.zhang@huawei.com, yangerkun@huawei.com
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

On Tue, Apr 25, 2023 at 4:54=E2=80=AFAM Yu Kuai <yukuai1@huaweicloud.com> w=
rote:
>
> From: Yu Kuai <yukuai3@huawei.com>
>
> Our test reports a uaf for 'mddev->sync_thread':
>
> T1                      T2
> md_start_sync
>  md_register_thread
>  // mddev->sync_thread is set
>                         raid1d
>                          md_check_recovery
>                           md_reap_sync_thread
>                            md_unregister_thread
>                             kfree
>
>  md_wakeup_thread
>   wake_up
>   ->sync_thread was freed
>
> Root cause is that there is a small windown between register thread and
> wake up thread, where the thread can be freed concurrently.
>
> Currently, a global spinlock 'pers_lock' is borrowed to protect
> 'mddev->thread', this problem can be fixed likewise, however, there are
> similar problems elsewhere, and use a global lock for all the cases is
> not good.
>
> This patch protect all md_thread with rcu.
>
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
> ---
>  block/blk-cgroup.c        |  3 ++
>  drivers/md/md-bitmap.c    | 10 ++++--
>  drivers/md/md-cluster.c   | 17 ++++++----
>  drivers/md/md-multipath.c |  4 +--
>  drivers/md/md.c           | 69 ++++++++++++++++++---------------------
>  drivers/md/md.h           |  8 ++---
>  drivers/md/raid1.c        |  7 ++--
>  drivers/md/raid1.h        |  2 +-
>  drivers/md/raid10.c       | 20 +++++++-----
>  drivers/md/raid10.h       |  2 +-
>  drivers/md/raid5-cache.c  | 22 ++++++++-----
>  drivers/md/raid5.c        | 15 +++++----
>  drivers/md/raid5.h        |  2 +-
>  13 files changed, 100 insertions(+), 81 deletions(-)
>
> diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
> index 1c1ebeb51003..0ecb4cce8af2 100644
> --- a/block/blk-cgroup.c
> +++ b/block/blk-cgroup.c
> @@ -527,6 +527,9 @@ static void blkg_destroy_all(struct gendisk *disk)
>         list_for_each_entry_safe(blkg, n, &q->blkg_list, q_node) {
>                 struct blkcg *blkcg =3D blkg->blkcg;
>
> +               if (hlist_unhashed(&blkg->blkcg_node))
> +                       continue;
> +

This change is not related, right?

I don't think we can rush this change in the 6.4 merge window. Let's
test it more thoroughly and ship it in the next merge window.

Thanks for working on this!

Song
[...]
