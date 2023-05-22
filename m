Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE40D70C2EF
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 18:03:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234381AbjEVQDc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 12:03:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231409AbjEVQDb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 12:03:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E88C6C5;
        Mon, 22 May 2023 09:03:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 74D7F61644;
        Mon, 22 May 2023 16:03:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE921C433EF;
        Mon, 22 May 2023 16:03:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684771408;
        bh=diFwMuGlQSl9msXnxnUJWOr9y6fEdWUi6lbjlWuyfUU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=hfciaBwkehpNzvR5/YWGrRHDY5xoQeiqidB4LXCK5aN6413dVqAaBxuzPoV3CKSC7
         1RE9NyU2+3ry4An42zsmWXoXpWUVs9f9AhD1D2Q7uFs574xs8CFi8JyAQPHoxI4/6w
         x7MGzVFk3m220ZGL6ls0RM/I6mHL8Y1etmwsmsS+r6AsyjxwQmEde234a+tQVHZkxA
         6VmSGBowDKCyzVDITCqAFdQFskaMJ70tm2qjSO/h3InZbolgVwdv621Qpw+BtH5rrm
         QIN4/xSuLXKZVDEx3VF1yBpOOxpkMHB8rXVWNrt/jmeLgypM3VtHx+CiLBr4YyORkE
         2RKPYWlqK5nTQ==
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2af2c35fb85so30926441fa.3;
        Mon, 22 May 2023 09:03:28 -0700 (PDT)
X-Gm-Message-State: AC+VfDwoZlY6t3dumgHLsmHxNMGPso+aiHhjox5R7P/PeMH4znixtt3A
        KQRZWcwmtI4wY32OwCUiRUWrNymYyf+OaNOmMJk=
X-Google-Smtp-Source: ACHHUZ77eO1lzVtszn4sQTn6uez60hsE+6AwDA4OvxE+2HgYR9rNNW0wmjw04AgqWr+/4SAR9Evu+bHj2nZgURg6yNU=
X-Received: by 2002:ac2:43cd:0:b0:4f2:6f55:2d6c with SMTP id
 u13-20020ac243cd000000b004f26f552d6cmr3525325lfl.5.1684771406870; Mon, 22 May
 2023 09:03:26 -0700 (PDT)
MIME-Version: 1.0
References: <20230522115449.2203939-1-linan666@huaweicloud.com>
 <20230522115449.2203939-3-linan666@huaweicloud.com> <801a3a11-9a2c-dca2-cec4-4a9c71d3afb6@huaweicloud.com>
In-Reply-To: <801a3a11-9a2c-dca2-cec4-4a9c71d3afb6@huaweicloud.com>
From:   Song Liu <song@kernel.org>
Date:   Mon, 22 May 2023 09:03:14 -0700
X-Gmail-Original-Message-ID: <CAPhsuW6UTc+sdVKvYqDX1VN3u9VgmkNVo0b84AxG=DdOY7pfhQ@mail.gmail.com>
Message-ID: <CAPhsuW6UTc+sdVKvYqDX1VN3u9VgmkNVo0b84AxG=DdOY7pfhQ@mail.gmail.com>
Subject: Re: [PATCH 2/3] md/raid10: fix incorrect done of recovery
To:     Yu Kuai <yukuai1@huaweicloud.com>
Cc:     linan666@huaweicloud.com, shli@fb.com, allenpeng@synology.com,
        alexwu@synology.com, bingjingc@synology.com, neilb@suse.de,
        linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
        linan122@huawei.com, yi.zhang@huawei.com, houtao1@huawei.com,
        yangerkun@huawei.com, "yukuai (C)" <yukuai3@huawei.com>
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

On Mon, May 22, 2023 at 6:54=E2=80=AFAM Yu Kuai <yukuai1@huaweicloud.com> w=
rote:
>
> Hi,
>
> =E5=9C=A8 2023/05/22 19:54, linan666@huaweicloud.com =E5=86=99=E9=81=93:
> > From: Li Nan <linan122@huawei.com>
> >
> > Recovery will go to giveup and let chunks_skipped++ in
> > raid10_sync_request() if there are some bad_blocks, and it will return
> > max_sector when chunks_skipped >=3D geo.raid_disks. Now, recovery fail =
and
> > data is inconsistent but user think recovery is done, it is wrong.
> >
> > Fix it by set mirror's recovery_disabled and spare device shouln't be
> > added to here.
> >
> > Signed-off-by: Li Nan <linan122@huawei.com>
> > ---
> >   drivers/md/raid10.c | 16 +++++++++++++++-
> >   1 file changed, 15 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/md/raid10.c b/drivers/md/raid10.c
> > index e21502c03b45..70cc87c7ee57 100644
> > --- a/drivers/md/raid10.c
> > +++ b/drivers/md/raid10.c
> > @@ -3303,6 +3303,7 @@ static sector_t raid10_sync_request(struct mddev =
*mddev, sector_t sector_nr,
> >       int chunks_skipped =3D 0;
> >       sector_t chunk_mask =3D conf->geo.chunk_mask;
> >       int page_idx =3D 0;
> > +     int error_disk =3D -1;
> >
> >       /*
> >        * Allow skipping a full rebuild for incremental assembly
> > @@ -3386,7 +3387,18 @@ static sector_t raid10_sync_request(struct mddev=
 *mddev, sector_t sector_nr,
> >               return reshape_request(mddev, sector_nr, skipped);
> >
> >       if (chunks_skipped >=3D conf->geo.raid_disks) {
> > -             /* if there has been nothing to do on any drive,
> > +             pr_err("md/raid10:%s: %s fail\n", mdname(mddev),
> > +                     test_bit(MD_RECOVERY_SYNC, &mddev->recovery) ?  "=
resync" : "recovery");
>
> Line exceed 80 columns, and following.

If it makes the code look better, such as in this case, it is OK to have
lines longer than 80 columns.

Thanks,
Song

> > +             if (error_disk >=3D 0 && !test_bit(MD_RECOVERY_SYNC, &mdd=
ev->recovery)) {
>
