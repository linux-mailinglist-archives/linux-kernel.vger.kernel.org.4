Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36ABD74AD61
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 10:53:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232505AbjGGIxE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 04:53:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232055AbjGGIxD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 04:53:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 096A7129;
        Fri,  7 Jul 2023 01:53:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 970DF617B9;
        Fri,  7 Jul 2023 08:53:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BEFDC433C8;
        Fri,  7 Jul 2023 08:53:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688719981;
        bh=B5hPcOxxzJ0jpPaiyd3+n22kW4lc95EF3CeyUdQr46s=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=phOqDQCRbXj1hciqDFUYc6fB1/2xtZDvPUxqii3j+14BU4hjHdMRTSpq3I3y36Wjv
         eCZdEa/bzIMn72KiGjeR6Lix5KCnL86A4UQ5bluYGgTJydhda9kxItiWSn/GQN3h5u
         7CunJAufX9EDB2UyMwkr7RyDzQhohZSdNoG50/6QF8JPSInosN7zq7seC6mGkRjQlb
         dFr9iYv+uwAVz5tVwa9La+jGSoiyEvap92pWmktGsF7TrvuS3t8XkPuNbFqZsOujgA
         l9lo0hIMVtuOeyv+P4C5KlXJQ94OKUYZztrVbQm48jaOwRcSNz9TVNtjcMn5DriTIi
         iwenO1YR71eWQ==
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-4fb73ba3b5dso2579822e87.1;
        Fri, 07 Jul 2023 01:53:00 -0700 (PDT)
X-Gm-Message-State: ABy/qLYF8wIkO/pyEc0lzZ8Z8A9JU3wFufvVpsRyjHhecvUNEQkx9gtb
        v9WFYCxklEdOD9h3Aoe2UUTn5Bs5zhC/Rx6fsic=
X-Google-Smtp-Source: APBJJlEWeiDCRf6PVs5ujUOH8YhNen1v+kger9T1aDT3xKtQyuCvxxIRZQcwf4+AmpjxP4CRBnFllS8GahgpRQAgnTw=
X-Received: by 2002:ac2:4f0d:0:b0:4fa:21d5:8ed8 with SMTP id
 k13-20020ac24f0d000000b004fa21d58ed8mr3749590lfr.4.1688719979066; Fri, 07 Jul
 2023 01:52:59 -0700 (PDT)
MIME-Version: 1.0
References: <20230628010756.70649-1-yukuai1@huaweicloud.com> <20230628010756.70649-3-yukuai1@huaweicloud.com>
In-Reply-To: <20230628010756.70649-3-yukuai1@huaweicloud.com>
From:   Song Liu <song@kernel.org>
Date:   Fri, 7 Jul 2023 16:52:46 +0800
X-Gmail-Original-Message-ID: <CAPhsuW500i9LEcSsAchje46b2maKdj4EVaefPtinZfdP+AqELw@mail.gmail.com>
Message-ID: <CAPhsuW500i9LEcSsAchje46b2maKdj4EVaefPtinZfdP+AqELw@mail.gmail.com>
Subject: Re: [PATCH -next v2 2/2] md/raid5-cache: fix null-ptr-deref in r5l_reclaim_thread()
To:     Yu Kuai <yukuai1@huaweicloud.com>
Cc:     xni@redhat.com, logang@deltatee.com, hch@lst.de, shli@fb.com,
        linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
        yukuai3@huawei.com, yi.zhang@huawei.com, yangerkun@huawwe.com
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

On Wed, Jun 28, 2023 at 9:08=E2=80=AFAM Yu Kuai <yukuai1@huaweicloud.com> w=
rote:
>
> From: Yu Kuai <yukuai3@huawei.com>
>
> r5l_reclaim_thread() already check that 'conf->log' is not NULL in the
> beginning, however, r5c_do_reclaim() and r5l_do_reclaim() will
> dereference 'conf->log' again, which will cause null-ptr-deref if
> 'conf->log' is set to NULL from r5l_exit_log() concurrently.

r5l_exit_log() will wait until reclaim_thread() finishes, and then set
conf->log to NULL. So this is not a problem, no?

Thanks,
Song

>
> Fix this problem by don't dereference 'conf->log' again in
> r5c_do_reclaim() and r5c_do_reclaim().
>
> Fixes: a39f7afde358 ("md/r5cache: write-out phase and reclaim support")
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
> ---
>  drivers/md/raid5-cache.c | 20 ++++++++------------
>  1 file changed, 8 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/md/raid5-cache.c b/drivers/md/raid5-cache.c
> index 083288e36949..ba6fc146d265 100644
> --- a/drivers/md/raid5-cache.c
> +++ b/drivers/md/raid5-cache.c
> @@ -1148,10 +1148,9 @@ static void r5l_run_no_space_stripes(struct r5l_lo=
g *log)
>   * for write through mode, returns log->next_checkpoint
>   * for write back, returns log_start of first sh in stripe_in_journal_li=
st
>   */
> -static sector_t r5c_calculate_new_cp(struct r5conf *conf)
> +static sector_t r5c_calculate_new_cp(struct r5l_log *log)
>  {
>         struct stripe_head *sh;
> -       struct r5l_log *log =3D conf->log;
>         sector_t new_cp;
>         unsigned long flags;
>
> @@ -1159,12 +1158,12 @@ static sector_t r5c_calculate_new_cp(struct r5con=
f *conf)
>                 return log->next_checkpoint;
>
>         spin_lock_irqsave(&log->stripe_in_journal_lock, flags);
> -       if (list_empty(&conf->log->stripe_in_journal_list)) {
> +       if (list_empty(&log->stripe_in_journal_list)) {
>                 /* all stripes flushed */
>                 spin_unlock_irqrestore(&log->stripe_in_journal_lock, flag=
s);
>                 return log->next_checkpoint;
>         }
> -       sh =3D list_first_entry(&conf->log->stripe_in_journal_list,
> +       sh =3D list_first_entry(&log->stripe_in_journal_list,
>                               struct stripe_head, r5c);
>         new_cp =3D sh->log_start;
>         spin_unlock_irqrestore(&log->stripe_in_journal_lock, flags);
> @@ -1173,10 +1172,8 @@ static sector_t r5c_calculate_new_cp(struct r5conf=
 *conf)
>
>  static sector_t r5l_reclaimable_space(struct r5l_log *log)
>  {
> -       struct r5conf *conf =3D log->rdev->mddev->private;
> -
>         return r5l_ring_distance(log, log->last_checkpoint,
> -                                r5c_calculate_new_cp(conf));
> +                                r5c_calculate_new_cp(log));
>  }
>
>  static void r5l_run_no_mem_stripe(struct r5l_log *log)
> @@ -1419,9 +1416,9 @@ void r5c_flush_cache(struct r5conf *conf, int num)
>         }
>  }
>
> -static void r5c_do_reclaim(struct r5conf *conf)
> +static void r5c_do_reclaim(struct r5l_log *log)
>  {
> -       struct r5l_log *log =3D conf->log;
> +       struct r5conf *conf =3D log->rdev->mddev->private;
>         struct stripe_head *sh;
>         int count =3D 0;
>         unsigned long flags;
> @@ -1496,7 +1493,6 @@ static void r5c_do_reclaim(struct r5conf *conf)
>
>  static void r5l_do_reclaim(struct r5l_log *log)
>  {
> -       struct r5conf *conf =3D log->rdev->mddev->private;
>         sector_t reclaim_target =3D xchg(&log->reclaim_target, 0);
>         sector_t reclaimable;
>         sector_t next_checkpoint;
> @@ -1525,7 +1521,7 @@ static void r5l_do_reclaim(struct r5l_log *log)
>                                     log->io_list_lock);
>         }
>
> -       next_checkpoint =3D r5c_calculate_new_cp(conf);
> +       next_checkpoint =3D r5c_calculate_new_cp(log);
>         spin_unlock_irq(&log->io_list_lock);
>
>         if (reclaimable =3D=3D 0 || !write_super)
> @@ -1554,7 +1550,7 @@ static void r5l_reclaim_thread(struct md_thread *th=
read)
>
>         if (!log)
>                 return;
> -       r5c_do_reclaim(conf);
> +       r5c_do_reclaim(log);
>         r5l_do_reclaim(log);
>  }
>
> --
> 2.39.2
>
