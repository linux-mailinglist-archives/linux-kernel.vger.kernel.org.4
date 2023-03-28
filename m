Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4ABCC6CCDF4
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 01:17:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229724AbjC1XRv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 19:17:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbjC1XRt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 19:17:49 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8C921BF0;
        Tue, 28 Mar 2023 16:17:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 98E7DB81CC9;
        Tue, 28 Mar 2023 23:17:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6692FC4339B;
        Tue, 28 Mar 2023 23:17:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680045466;
        bh=FhXWBl3/P/hkvn7SURytWrxmi1wOCQCCyLVCHT/AjHg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=blux9YB951/4mf9tSWq1b+PHavxvnDpNH0F+o3W9b9WXGOFlQOQLYOGWpg6+3GDdN
         4iXS78ri3vyj1pLjS7eWdqzd30wh3mFZfK14beK70A/+KFcX1kikRtpSLS2Dcyffsk
         MzEWAKErbiQv76avCUA52mGfg3Kwygj1KUJ7OqLs9iu5X2f7mQfkmJs/wq1v44pHvY
         Nrew6jNidhflVxmCe95zkmhc2QEk7rkTNvQ5iK+mVbmdORMB6aY3Rs5ra+me/b1B31
         vDVf1eJZlDuoKFUQ6Ue9u/G9t7d/q00C+dCdTVoFlnH2RvPOXPlQoodbrQBcL8/ZU/
         oZ4XN+2ZykvvQ==
Received: by mail-lj1-f180.google.com with SMTP id a11so14254980lji.6;
        Tue, 28 Mar 2023 16:17:46 -0700 (PDT)
X-Gm-Message-State: AAQBX9dC+s62uDFMbOtPTEIGRzey6c9GFIGlx1sbCeoDHv1vsU3PIJFk
        XQjDS5Hz0c1z9Fz3p0BB3ri7OL7g1xS8VZPD/tc=
X-Google-Smtp-Source: AKy350ZoOmTviqMFDD7yk6Ien8iqOJ+XgAz2HmnZ1y8TuhUngMovHYNfS/rL4IlQRLzEimtw6spi42+fYJOchvvQ4kQ=
X-Received: by 2002:a2e:9002:0:b0:299:b5e6:4c45 with SMTP id
 h2-20020a2e9002000000b00299b5e64c45mr5368280ljg.5.1680045464363; Tue, 28 Mar
 2023 16:17:44 -0700 (PDT)
MIME-Version: 1.0
References: <20230327132324.1769595-1-trix@redhat.com>
In-Reply-To: <20230327132324.1769595-1-trix@redhat.com>
From:   Song Liu <song@kernel.org>
Date:   Tue, 28 Mar 2023 16:17:32 -0700
X-Gmail-Original-Message-ID: <CAPhsuW6=zpRso=5wPUWTPKO+s1Z0Nf09BDpSnb5sKHkEgizbHg@mail.gmail.com>
Message-ID: <CAPhsuW6=zpRso=5wPUWTPKO+s1Z0Nf09BDpSnb5sKHkEgizbHg@mail.gmail.com>
Subject: Re: [PATCH v2] md/raid5: remove unused working_disks variable
To:     Tom Rix <trix@redhat.com>
Cc:     nathan@kernel.org, ndesaulniers@google.com,
        linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 27, 2023 at 6:23=E2=80=AFAM Tom Rix <trix@redhat.com> wrote:
>
> clang with W=3D1 reports
> drivers/md/raid5.c:7719:6: error: variable 'working_disks'
>   set but not used [-Werror,-Wunused-but-set-variable]
>         int working_disks =3D 0;
>             ^
> This variable is not used so remove it.
>
> Signed-off-by: Tom Rix <trix@redhat.com>

Applied to md-next, with Yu Kuai's Reviewed-by.

Thanks,
Song

> ---
> v2: remove brances
> ---
>  drivers/md/raid5.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
>
> diff --git a/drivers/md/raid5.c b/drivers/md/raid5.c
> index 7b820b81d8c2..812a12e3e41a 100644
> --- a/drivers/md/raid5.c
> +++ b/drivers/md/raid5.c
> @@ -7716,7 +7716,6 @@ static void raid5_set_io_opt(struct r5conf *conf)
>  static int raid5_run(struct mddev *mddev)
>  {
>         struct r5conf *conf;
> -       int working_disks =3D 0;
>         int dirty_parity_disks =3D 0;
>         struct md_rdev *rdev;
>         struct md_rdev *journal_dev =3D NULL;
> @@ -7912,10 +7911,8 @@ static int raid5_run(struct mddev *mddev)
>                         pr_warn("md: cannot handle concurrent replacement=
 and reshape.\n");
>                         goto abort;
>                 }
> -               if (test_bit(In_sync, &rdev->flags)) {
> -                       working_disks++;
> +               if (test_bit(In_sync, &rdev->flags))
>                         continue;
> -               }
>                 /* This disc is not fully in-sync.  However if it
>                  * just stored parity (beyond the recovery_offset),
>                  * when we don't need to be concerned about the
> --
> 2.27.0
>
