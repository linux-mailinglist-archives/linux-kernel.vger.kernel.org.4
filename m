Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88F057013A8
	for <lists+linux-kernel@lfdr.de>; Sat, 13 May 2023 03:08:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241446AbjEMBIt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 21:08:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240720AbjEMBIr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 21:08:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DB879E;
        Fri, 12 May 2023 18:08:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9927664F81;
        Sat, 13 May 2023 01:08:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 081F6C433D2;
        Sat, 13 May 2023 01:08:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683940125;
        bh=q31HKbymA1nbLCbAxsLflc0enmVgPpKA/A51o6w6Bkw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=lPIUl9/E1pDDw8u76k3kxKL8nfTTy1PJU4cOSwZ6QrdrcMuGec4AfmyDpDTxagC6b
         zCd2aFT7/lXuCZiolvzsliNh0kNpPArlwzft/Dcxg5ICg5lhu/vuFEZANDI3AzxZxg
         LnJhGqE//GlF6MB0YHaLyGMzMxSKH6gOKdqRlbSyw8eEoxWOISRJ2riI8s0fdIFl0u
         cDi3mGO06C0his9okyH9MWoFwjsoQBoFnl58GX7hzeOHea/2mNE3MJ/qGWWKVQjFjx
         hQjeKeURzrgg0+OCkz7GpWsFl3o6wIXR65XOfSaObQJ0KRhGdPBot5O9T4FrZqhwle
         A8zNYKmeroVHw==
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-4f2510b2b98so7731215e87.3;
        Fri, 12 May 2023 18:08:44 -0700 (PDT)
X-Gm-Message-State: AC+VfDzMDRQGMPewct6mCbUKrEH7cmevc0H3lS6v3//0rVcWHIpyMBXT
        knadPX6lskN2bEbS2jq71tCIAc9F5ADRg4vcyp0=
X-Google-Smtp-Source: ACHHUZ4A54avAIK/pGlfJV2rLfsYsI/N5dnnr7E1kSN+B0gX62qbhdHdNjJKbDzAZE8n5cL3RsR5od788Ti1E7W1rMU=
X-Received: by 2002:ac2:5623:0:b0:4eb:30f9:eed7 with SMTP id
 b3-20020ac25623000000b004eb30f9eed7mr4911328lff.22.1683940123041; Fri, 12 May
 2023 18:08:43 -0700 (PDT)
MIME-Version: 1.0
References: <20230506012315.3370489-1-linan666@huaweicloud.com>
 <20230506012315.3370489-4-linan666@huaweicloud.com> <ddec947c-d2b9-e4fe-30e6-02c76f162ab3@huaweicloud.com>
In-Reply-To: <ddec947c-d2b9-e4fe-30e6-02c76f162ab3@huaweicloud.com>
From:   Song Liu <song@kernel.org>
Date:   Fri, 12 May 2023 18:08:31 -0700
X-Gmail-Original-Message-ID: <CAPhsuW6zSN86vGO9rd-oTq4TuCYLc+ftrAO6mo6UE7qCNJaCUw@mail.gmail.com>
Message-ID: <CAPhsuW6zSN86vGO9rd-oTq4TuCYLc+ftrAO6mo6UE7qCNJaCUw@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] md/raid10: fix wrong setting of max_corr_read_errors
To:     Yu Kuai <yukuai1@huaweicloud.com>
Cc:     linan666@huaweicloud.com, neilb@suse.de, Rob.Becker@riverbed.com,
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

On Fri, May 5, 2023 at 7:02=E2=80=AFPM Yu Kuai <yukuai1@huaweicloud.com> wr=
ote:
>
> Hi,
>
> =E5=9C=A8 2023/05/06 9:23, linan666@huaweicloud.com =E5=86=99=E9=81=93:
> > From: Li Nan <linan122@huawei.com>
> >
> > max_corr_read_errors should not be negative number. Change it to
> > unsigned int where use it.
> >
>
> Looks good, feel free to add:
>
> Reviewed-by: Yu Kuai <yukuai3@huawei.com>
>
> > Fixes: 1e50915fe0bb ("raid: improve MD/raid10 handling of correctable r=
ead errors.")
> > Signed-off-by: Li Nan <linan122@huawei.com>

Hmm.. Does the current code break in any cases?

Thanks,
Song

> > ---
> >   drivers/md/md.c     | 2 +-
> >   drivers/md/raid10.c | 5 +++--
> >   2 files changed, 4 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/md/md.c b/drivers/md/md.c
> > index fd5c3babcd6d..4a1e566d6bdc 100644
> > --- a/drivers/md/md.c
> > +++ b/drivers/md/md.c
> > @@ -4486,7 +4486,7 @@ __ATTR_PREALLOC(array_state, S_IRUGO|S_IWUSR, arr=
ay_state_show, array_state_stor
> >
> >   static ssize_t
> >   max_corrected_read_errors_show(struct mddev *mddev, char *page) {
> > -     return sprintf(page, "%d\n",
> > +     return sprintf(page, "%u\n",
> >                      atomic_read(&mddev->max_corr_read_errors));
> >   }
> >
> > diff --git a/drivers/md/raid10.c b/drivers/md/raid10.c
> > index 4fcfcb350d2b..4d615fcc6a50 100644
> > --- a/drivers/md/raid10.c
> > +++ b/drivers/md/raid10.c
> > @@ -2727,7 +2727,8 @@ static void fix_read_error(struct r10conf *conf, =
struct mddev *mddev, struct r10
> >       int sect =3D 0; /* Offset from r10_bio->sector */
> >       int sectors =3D r10_bio->sectors;
> >       struct md_rdev *rdev;
> > -     int max_read_errors =3D atomic_read(&mddev->max_corr_read_errors)=
;
> > +     unsigned int max_read_errors =3D
> > +                     atomic_read(&mddev->max_corr_read_errors);
> >       int d =3D r10_bio->devs[r10_bio->read_slot].devnum;
> >
> >       /* still own a reference to this rdev, so it cannot
> > @@ -2743,7 +2744,7 @@ static void fix_read_error(struct r10conf *conf, =
struct mddev *mddev, struct r10
> >       check_decay_read_errors(mddev, rdev);
> >       atomic_inc(&rdev->read_errors);
> >       if (atomic_read(&rdev->read_errors) > max_read_errors) {
> > -             pr_notice("md/raid10:%s: %pg: Raid device exceeded read_e=
rror threshold [cur %d:max %d]\n",
> > +             pr_notice("md/raid10:%s: %pg: Raid device exceeded read_e=
rror threshold [cur %u:max %u]\n",
> >                         mdname(mddev), rdev->bdev,
> >                         atomic_read(&rdev->read_errors), max_read_error=
s);
> >               pr_notice("md/raid10:%s: %pg: Failing raid device\n",
> >
>
