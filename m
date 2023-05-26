Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DFC1712EF9
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 23:38:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237913AbjEZVip (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 17:38:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229964AbjEZVim (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 17:38:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EE01AD;
        Fri, 26 May 2023 14:38:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 01E8B65002;
        Fri, 26 May 2023 21:38:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5ADA5C433D2;
        Fri, 26 May 2023 21:38:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685137120;
        bh=OUL/JbdwR38LDfZP5Jo8QoBNmitapP5ncID9LOrh4RM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=LUHwcAlYUsvEtZZk+PzIF7+KPH/Ce/SImhP+mG+ykKLrjy86HmuPvneYr52GiQjlA
         50rJRoTo2GX2IfrmH1Mv5HPOyZDMS+i1rCVeKMPFGXDHvWoZZaYIh7bSgPFra4XYrK
         ztms1JVET9JOmXxN0nUY2O/2KuSfcaMVl3D5rXCN1YqZ12W8DHE4ZWGPbwV4ygG3Fx
         WmWmtPTnbUBOIHC7wSeFFLgQL4ShmK2li0Atu45xra1HX0g4FGqrrbqveYTgoxwHo2
         Pt5BW3uFXrkd9LAdAIRRdtj/IWVu5OE7jbxthmYtNTQuCP0cpRr2hFUDm4BRoqw9G+
         /UyqX2F9JGccg==
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-4f3b9c88af8so1383326e87.2;
        Fri, 26 May 2023 14:38:40 -0700 (PDT)
X-Gm-Message-State: AC+VfDyC4/tkB/lylRhfJ3HV5YqjsEpqA7NEW07cuiyL96GZRYJ1lnop
        NAKwuxu2kATnm3JrJ4l/IU9VirQ5qDbjxc7AslM=
X-Google-Smtp-Source: ACHHUZ4Y4vsMGiVcHbG/n176heAtWs4TWfFT1nqRdOmftZJjxYij4hWV0m0aafecf+twTK2NYX6GkB2ICJ20iEubGWI=
X-Received: by 2002:ac2:4567:0:b0:4f4:b13a:d683 with SMTP id
 k7-20020ac24567000000b004f4b13ad683mr879235lfm.69.1685137118345; Fri, 26 May
 2023 14:38:38 -0700 (PDT)
MIME-Version: 1.0
References: <20230526074551.669792-1-linan666@huaweicloud.com> <20230526074551.669792-2-linan666@huaweicloud.com>
In-Reply-To: <20230526074551.669792-2-linan666@huaweicloud.com>
From:   Song Liu <song@kernel.org>
Date:   Fri, 26 May 2023 14:38:26 -0700
X-Gmail-Original-Message-ID: <CAPhsuW5ThXyAL2rAyWZC31etY27fqsG+eFHcHtzfCS9Da4bosw@mail.gmail.com>
Message-ID: <CAPhsuW5ThXyAL2rAyWZC31etY27fqsG+eFHcHtzfCS9Da4bosw@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] md/raid10: fix null-ptr-deref of mreplace in raid10_sync_request
To:     linan666@huaweicloud.com
Cc:     bingjingc@synology.com, allenpeng@synology.com,
        alexwu@synology.com, shli@fb.com, neilb@suse.de,
        linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
        linan122@huawei.com, yukuai3@huawei.com, yi.zhang@huawei.com,
        houtao1@huawei.com, yangerkun@huawei.com
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

On Fri, May 26, 2023 at 12:47=E2=80=AFAM <linan666@huaweicloud.com> wrote:
>
> From: Li Nan <linan122@huawei.com>
>
> need_replace will be set to 1 if no-Faulty mreplace exists, and mreplace
> will be deref later. However, the latter check of mreplace might set
> mreplace to NULL, null-ptr-deref occurs if need_replace is 1 at this time=
.
>
> Fix it by merging two checks into one. And replace 'need_replace' with
> 'mreplace' because their values are always the same.
>
> Fixes: ee37d7314a32 ("md/raid10: Fix raid10 replace hang when new added d=
isk faulty")
> Signed-off-by: Li Nan <linan122@huawei.com>
> ---
>  drivers/md/raid10.c | 13 +++++--------
>  1 file changed, 5 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/md/raid10.c b/drivers/md/raid10.c
> index 4fcfcb350d2b..e21502c03b45 100644
> --- a/drivers/md/raid10.c
> +++ b/drivers/md/raid10.c
> @@ -3438,7 +3438,6 @@ static sector_t raid10_sync_request(struct mddev *m=
ddev, sector_t sector_nr,
>                         int must_sync;
>                         int any_working;
>                         int need_recover =3D 0;
> -                       int need_replace =3D 0;
>                         struct raid10_info *mirror =3D &conf->mirrors[i];
>                         struct md_rdev *mrdev, *mreplace;
>
> @@ -3451,10 +3450,10 @@ static sector_t raid10_sync_request(struct mddev =
*mddev, sector_t sector_nr,
>                             !test_bit(In_sync, &mrdev->flags))
>                                 need_recover =3D 1;
>                         if (mreplace !=3D NULL &&
> -                           !test_bit(Faulty, &mreplace->flags))
> -                               need_replace =3D 1;
> +                           test_bit(Faulty, &mreplace->flags))
> +                               mreplace =3D NULL;
>
> -                       if (!need_recover && !need_replace) {
> +                       if (!need_recover && !mreplace) {
>                                 rcu_read_unlock();
>                                 continue;
>                         }
> @@ -3470,8 +3469,6 @@ static sector_t raid10_sync_request(struct mddev *m=
ddev, sector_t sector_nr,
>                                 rcu_read_unlock();
>                                 continue;
>                         }

To make sure I understand the issue correctly:

The null-ptr-deref only happens when the Faulty bit was set after the
last check and before this check below, right?

> -                       if (mreplace && test_bit(Faulty, &mreplace->flags=
))
> -                               mreplace =3D NULL;
>                         /* Unless we are doing a full sync, or a replacem=
ent
>                          * we only need to recover the block if it is set=
 in
>                          * the bitmap

Thanks,
Song

> @@ -3594,11 +3591,11 @@ static sector_t raid10_sync_request(struct mddev =
*mddev, sector_t sector_nr,
>                                 bio =3D r10_bio->devs[1].repl_bio;
>                                 if (bio)
>                                         bio->bi_end_io =3D NULL;
> -                               /* Note: if need_replace, then bio
> +                               /* Note: if replace is not NULL, then bio
>                                  * cannot be NULL as r10buf_pool_alloc wi=
ll
>                                  * have allocated it.
>                                  */
> -                               if (!need_replace)
> +                               if (!mreplace)
>                                         break;
>                                 bio->bi_next =3D biolist;
>                                 biolist =3D bio;
> --
> 2.31.1
>
