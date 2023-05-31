Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F24D4718697
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 17:43:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234829AbjEaPn4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 11:43:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234496AbjEaPnw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 11:43:52 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F496125
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 08:43:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1685547784;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Neyvf7piN/jznj9GMJPM9dIGzEpEK9H8JJFuRevFs+I=;
        b=FfK3+gREyKXvmxTJcs95hB7I3kKJb+kMmrPddxed8rAzy1tX6rJV5VduQ9kPwdLctVd9gx
        6yHY6Rs99tLGrrV9XU7WsqjRIkFciTsYarlbdLrhdvrtc+ZoU4Ktaf43iYMIiwKHwSqAhX
        l5I2QfhFRotDWwlRrHBSHm6zezqD7vs=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-584-XB0OvHX_NEeOtxx8KAO32Q-1; Wed, 31 May 2023 11:43:02 -0400
X-MC-Unique: XB0OvHX_NEeOtxx8KAO32Q-1
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-25682c04f38so713272a91.1
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 08:43:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685547782; x=1688139782;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Neyvf7piN/jznj9GMJPM9dIGzEpEK9H8JJFuRevFs+I=;
        b=LTa7PAAj4EAxH9fGvoW6SQ7Mtm0xWxK/Ts+sVQvwrNG6NGeXCEyevXbnn8fLnIiSO5
         m7o6rnQdEsMDhDn67R9Nn5+nJON+dJFEqTsUVERxih1uwn2mTf9mqkvfnntXvQLbGH/4
         hH8uw5jNfu1LD2lXtEWb/og5Ydr7foahINcsrRYw78XShZi1SXqEsFJ1yh4Ph4Wf1EcB
         SV7SoUS5jUvhIlPFb6JC+uIOeAp1s1MYZht9NwzH3EUXsbr3uhXmjZO96hcpku/b7Q+z
         akcSwp3MjKURMbVWSzzJ/2OWZ0Fa66XU/izOQR5LodHzDakMoEypwa6+QUzINjzSkSxI
         XH9g==
X-Gm-Message-State: AC+VfDwVbYvRRrMZ9FEoSLfvSTEwr/CdGsccjc+WGXo+2aVrPDz3lNwQ
        /dr+ojkJFe5hNrXS/GKbc7yxWFFjoLr78ZG1nH3LMQWWanUzO8pzMC4dkM9H6urh81E0yhAgvOh
        SbEqdf4wmvU1xhJB5tio8wtH9d23VYb51Z/LBRDhL
X-Received: by 2002:a17:90a:c86:b0:256:a706:44cc with SMTP id v6-20020a17090a0c8600b00256a70644ccmr6614069pja.10.1685547781865;
        Wed, 31 May 2023 08:43:01 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7rr8NKOMFHE9bTirrXqziuDZM26000F7uZD+o4fsIDiodFAyTrkEOYJouqbypWO3p9YuiKoRILTpdsgJ3SXXw=
X-Received: by 2002:a17:90a:c86:b0:256:a706:44cc with SMTP id
 v6-20020a17090a0c8600b00256a70644ccmr6614049pja.10.1685547781501; Wed, 31 May
 2023 08:43:01 -0700 (PDT)
MIME-Version: 1.0
References: <20230529131106.2123367-1-yukuai1@huaweicloud.com> <20230529131106.2123367-8-yukuai1@huaweicloud.com>
In-Reply-To: <20230529131106.2123367-8-yukuai1@huaweicloud.com>
From:   Xiao Ni <xni@redhat.com>
Date:   Wed, 31 May 2023 23:42:50 +0800
Message-ID: <CALTww29JCfgQivaEqi3dAvTrfxT9bhN6Rj04fyXRRJF2DfNHyg@mail.gmail.com>
Subject: Re: [PATCH -next v3 7/7] md/raid1-10: limit the number of plugged bio
To:     Yu Kuai <yukuai1@huaweicloud.com>
Cc:     song@kernel.org, neilb@suse.de, akpm@osdl.org,
        linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
        yukuai3@huawei.com, yi.zhang@huawei.com, yangerkun@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 29, 2023 at 9:14=E2=80=AFPM Yu Kuai <yukuai1@huaweicloud.com> w=
rote:
>
> From: Yu Kuai <yukuai3@huawei.com>
>
> bio can be added to plug infinitely, and following writeback test can
> trigger huge amount of plugged bio:
>
> Test script:
> modprobe brd rd_nr=3D4 rd_size=3D10485760
> mdadm -CR /dev/md0 -l10 -n4 /dev/ram[0123] --assume-clean --bitmap=3Dinte=
rnal
> echo 0 > /proc/sys/vm/dirty_background_ratio
> fio -filename=3D/dev/md0 -ioengine=3Dlibaio -rw=3Dwrite -bs=3D4k -numjobs=
=3D1 -iodepth=3D128 -name=3Dtest
>
> Test result:
> Monitor /sys/block/md0/inflight will found that inflight keep increasing
> until fio finish writing, after running for about 2 minutes:
>
> [root@fedora ~]# cat /sys/block/md0/inflight
>        0  4474191
>
> Fix the problem by limiting the number of plugged bio based on the number
> of copies for original bio.
>
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
> ---
>  drivers/md/raid1-10.c | 9 ++++++++-
>  drivers/md/raid1.c    | 2 +-
>  drivers/md/raid10.c   | 2 +-
>  3 files changed, 10 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/md/raid1-10.c b/drivers/md/raid1-10.c
> index 17e55c1fd5a1..bb1e23b66c45 100644
> --- a/drivers/md/raid1-10.c
> +++ b/drivers/md/raid1-10.c
> @@ -21,6 +21,7 @@
>  #define IO_MADE_GOOD ((struct bio *)2)
>
>  #define BIO_SPECIAL(bio) ((unsigned long)bio <=3D 2)
> +#define MAX_PLUG_BIO 32
>
>  /* for managing resync I/O pages */
>  struct resync_pages {
> @@ -31,6 +32,7 @@ struct resync_pages {
>  struct raid1_plug_cb {
>         struct blk_plug_cb      cb;
>         struct bio_list         pending;
> +       unsigned int            count;
>  };
>
>  static void rbio_pool_free(void *rbio, void *data)
> @@ -128,7 +130,7 @@ static inline void raid1_submit_write(struct bio *bio=
)
>  }
>
>  static inline bool raid1_add_bio_to_plug(struct mddev *mddev, struct bio=
 *bio,
> -                                     blk_plug_cb_fn unplug)
> +                                     blk_plug_cb_fn unplug, int copies)
>  {
>         struct raid1_plug_cb *plug =3D NULL;
>         struct blk_plug_cb *cb;
> @@ -148,6 +150,11 @@ static inline bool raid1_add_bio_to_plug(struct mdde=
v *mddev, struct bio *bio,
>
>         plug =3D container_of(cb, struct raid1_plug_cb, cb);
>         bio_list_add(&plug->pending, bio);
> +       if (++plug->count / MAX_PLUG_BIO >=3D copies) {
> +               list_del(&cb->list);
> +               cb->callback(cb, false);
> +       }
> +
It doesn't need this line here.

Have you done some performance tests with this patch set?

Regards
Xiao
>
>         return true;
>  }
> diff --git a/drivers/md/raid1.c b/drivers/md/raid1.c
> index 006620fed595..dc89a1c4b1f1 100644
> --- a/drivers/md/raid1.c
> +++ b/drivers/md/raid1.c
> @@ -1562,7 +1562,7 @@ static void raid1_write_request(struct mddev *mddev=
, struct bio *bio,
>                                               r1_bio->sector);
>                 /* flush_pending_writes() needs access to the rdev so...*=
/
>                 mbio->bi_bdev =3D (void *)rdev;
> -               if (!raid1_add_bio_to_plug(mddev, mbio, raid1_unplug)) {
> +               if (!raid1_add_bio_to_plug(mddev, mbio, raid1_unplug, dis=
ks)) {
>                         spin_lock_irqsave(&conf->device_lock, flags);
>                         bio_list_add(&conf->pending_bio_list, mbio);
>                         spin_unlock_irqrestore(&conf->device_lock, flags)=
;
> diff --git a/drivers/md/raid10.c b/drivers/md/raid10.c
> index fb22cfe94d32..9237dbeb07ba 100644
> --- a/drivers/md/raid10.c
> +++ b/drivers/md/raid10.c
> @@ -1306,7 +1306,7 @@ static void raid10_write_one_disk(struct mddev *mdd=
ev, struct r10bio *r10_bio,
>
>         atomic_inc(&r10_bio->remaining);
>
> -       if (!raid1_add_bio_to_plug(mddev, mbio, raid10_unplug)) {
> +       if (!raid1_add_bio_to_plug(mddev, mbio, raid10_unplug, conf->copi=
es)) {
>                 spin_lock_irqsave(&conf->device_lock, flags);
>                 bio_list_add(&conf->pending_bio_list, mbio);
>                 spin_unlock_irqrestore(&conf->device_lock, flags);
> --
> 2.39.2
>

